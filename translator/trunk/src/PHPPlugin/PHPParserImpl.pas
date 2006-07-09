{@abstract(Generic php parser) }
{
  Copyright © 2003-2004 by Peter Thornqvist; all rights reserved

  Developer(s):
    p3 - peter3 att users dott sourceforge dott net

  Status:
   The contents of this file are subject to the Mozilla Public License Version
   1.1 (the "License"); you may not use this file except in compliance with the
   License. You may obtain a copy of the License at http://www.mozilla.org/MPL/MPL-1.1.html

   Software distributed under the License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.
}

// $Id: PHPParserImpl.pas,v 1.15 2006/07/05 22:33:10 peter3 Exp $
unit PHPParserImpl;

interface
uses
  SysUtils, Classes, Types, TntClasses, TransIntf;
{
RESTRICTIONS:
  * strips all comments
  * does not support embedded quotes
  * does not do any character escaping
}


type
  TPHPParser = class(TInterfacedObject, IUnknown, IFileParser)
  private
    FOldHandle: LongWord;
    FOrigFile, FTransFile: string;
    FExportRect: TRect;
    procedure BuildPreview(const Items: ITranslationItems; Strings: TTntStrings);
    function DoPHPImport(const Items, Orphans: ITranslationItems; const OrigFile, TransFile: string): boolean;
    procedure LoadSettings;
    procedure SaveSettings;
  public
    constructor Create;
    destructor Destroy; override;
    function Configure(Capability: Integer): HRESULT; safecall;
    function DisplayName(Capability: Integer): WideString; safecall;
    function ExportItems(const Items, Orphans: ITranslationItems): HRESULT; safecall;
    function ImportItems(const Items, Orphans: ITranslationItems): HRESULT; safecall;
    procedure Init(AppHandle: Cardinal); safecall;
    function Capabilities: Integer; safecall;
  end;

implementation
uses
  Windows, Forms, IniFiles, PreviewExportFrm, DualImportFrm;
const
  cPHPFilter = 'PHP files (*.php)|*.php;*.php3|All files (*.*)|*.*';
  cPHPExportTitle = 'Export to PHP language file';
  cPHPImportTitle = 'Import from PHP language file';
  cSectionName = 'php';
  SImportError = 'There was an error importing, please check the files and try again';
  SError = 'PHP Parser Error';

function YesNo(const Text, Caption: string): boolean;
begin
  Result := Application.MessageBox(PChar(Text), PChar(Caption), MB_YESNO or MB_ICONQUESTION) = IDYES;
end;

procedure ShowError(const Text: string);
begin
  Application.MessageBox(PChar('There was an error:'#13#10 + Text), PChar('PHP Error'), MB_OK or MB_ICONERROR);
end;
{ TPHPParser }

function TPHPParser.Capabilities: Integer;
begin
  Result := CAP_IMPORT or CAP_EXPORT;
end;

function TPHPParser.Configure(Capability: Integer): HRESULT;
begin
  Result := S_OK;
end;

constructor TPHPParser.Create;
begin
  inherited Create;
  FOldHandle := Application.Handle;
end;

procedure TPHPParser.BuildPreview(const Items: ITranslationItems;
  Strings: TTntStrings);
var
  i: integer;
  FOldSort: TTranslateSortType;
begin
  try
    FOldSort := Items.Sort;
    try
      Items.Sort := stIndex;
      Strings.Add('<?php');
      for i := 0 to Items.Count - 1 do
        Strings.Add(Format('$%s=''%s'';', [Items[i].Name, Items[i].Translation]));
      Strings.Add('?>');
    finally
      Items.Sort := FOldSort;
    end;
  except
    Application.HandleException(Self);
  end;
end;

destructor TPHPParser.Destroy;
begin
  Application.Handle := FOldHandle;
  inherited;
end;

function TPHPParser.DisplayName(Capability: Integer): WideString;
begin
  case Capability of
    CAP_IMPORT: Result := cPHPImportTitle;
    CAP_EXPORT: Result := cPHPExportTitle;
//    CAP_CONFIGURE : Result := 'Configure';
  else
    Result := '';
  end;
end;

function TPHPParser.DoPHPImport(const Items, Orphans: ITranslationItems;
  const OrigFile, TransFile: string): boolean;
var
  S: TTntStringList;
  i, j: integer;
  FOldSort: TTranslateSortType;
  function ParseRow(const S: string; AIndex: integer; IsTranslation: boolean): boolean;
  type
    TParseState = (stNone, stDollar, stEqual, stFirstQuote, stLastQuote, stSemi);
  var
    AName, AStr: string;
    State: TParseState;
    i, j: integer;
  begin
    Result := false;
    State := stNone;
    j := 1;
    for i := 1 to Length(S) do
      case S[i] of
        '$':
          begin
            State := stDollar;
            j := 2;
          end;
        '=':
          begin
            if State = stDollar then
              AName := trim(Copy(S, j, i - j));
            State := stEqual;
          end;
        #39:
          if State = stEqual then
          begin
            State := stFirstQuote;
            j := i + 1;
          end
          else if State = stFirstQuote then
          begin
            AStr := Copy(S, j, i - j);
            State := stLastQuote;
          end;
        ';':
          if State = stLastQuote then
          begin
            if not IsTranslation then
            begin
              with Items.Add do
              begin
                Section := cSectionName;
                Name := AName;
                Original := AStr;
  //              Index := AIndex;
                Result := true;
              end;
            end
            else
            begin
              j := Items.IndexOf(cSectionName, AName);
              if j > -1 then
              begin
                Items[j].Translation := AStr;
                Items[j].Translated := Items[j].Translation <> '';
                Result := true;
              end;
            end;
          end;
      end;
  end;
begin
  // format of file:
  // $name='value';

  Result := false;
  try
    Items.Clear;
    Orphans.Clear;
    FOldSort := Items.Sort;
    j := 0;
    Items.Sort := stNone;
    S := TTntStringlist.Create;
    try
      S.LoadFromFile(OrigFile);
      if not AnsiSameText(Copy(S.Text, 1, Length('<?php')), '<?php') then Exit;
      for i := 0 to S.Count - 1 do
        if Pos('$', S[i]) = 1 then
        begin
          if ParseRow(S[i], j, false) then
            Inc(j);
        end;
      S.LoadFromFile(TransFile);
      Items.Sort := stSection;
      if not AnsiSameText(Copy(S.Text, 1, Length('<?php')), '<?php') then Exit;
      for i := 0 to S.Count - 1 do
      begin
        if Pos('$', S[i]) = 1 then
          ParseRow(S[i], -1, true);
      end;
    finally
      S.Free;
    end;
    Items.Sort := FOldSort;
    Result := true;
  except
    Application.HandleException(self);
  end;
end;

function TPHPParser.ExportItems(const Items, Orphans: ITranslationItems): HRESULT;
var S: TTntStringlist;
begin
  try
    Result := S_FALSE;
    LoadSettings;
    S := TTntStringlist.Create;
    try
      BuildPreview(Items, S);
      if TfrmExport.Execute(FTransFile, cPHPExportTitle, cPHPFilter, '.', 'php', S) then
      begin
        S.AnsiStrings.SaveToFile(FTransFile);
        SaveSettings;
        Result := S_OK;
      end;
    finally
      S.Free
    end;
  except
    Application.HandleException(Self);
  end;
end;

function TPHPParser.ImportItems(const Items, Orphans: ITranslationItems): HRESULT;
begin
  try
    Result := S_FALSE;
    LoadSettings;
    if TfrmImport.Execute(FOrigFile, FTransFile, cPHPImportTitle, cPHPFilter, '.', 'php') then
    begin
      if DoPHPImport(Items, Orphans, FOrigFile, FTransFile) then
      begin
        SaveSettings;
        Result := S_OK;
      end
      else
        Application.MessageBox(PChar(SImportError), PChar(SError), MB_OK or MB_ICONERROR);
    end;
  except
    Application.HandleException(Self);
  end;
end;

procedure TPHPParser.Init(AppHandle: Cardinal);
begin
  Application.Handle := AppHandle;
end;

procedure TPHPParser.LoadSettings;
var M: TMemoryStream;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
      FOrigFile := ReadString('Settings', 'OrigFile', FOrigFile);
      FTransFile := ReadString('Settings', 'TransFile', FTransFile);
      M := TMemoryStream.Create;
      try
        if ReadBinaryStream('Forms', 'Export', M) = SizeOf(TRect) then
        begin
          M.Seek(0, soFromBeginning);
          Move(M.Memory^, Pointer(@FExportRect)^, sizeof(TRect));
        end;
      finally
        M.Free;
      end;
    finally
      Free;
    end;
  except
    Application.HandleException(Self);
  end;
end;

procedure TPHPParser.SaveSettings;
var M: TMemoryStream;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
      WriteString('Settings', 'OrigFile', FOrigFile);
      WriteString('Settings', 'TransFile', FTransFile);
      M := TMemoryStream.Create;
      try
        M.Write(FExportRect, sizeof(TRect));
        M.Seek(0, soFromBeginning);
        WriteBinaryStream('Forms', 'Export', M);
      finally
        M.Free;
      end;
    finally
      Free;
    end;
  except
    Application.HandleException(Self);
  end;
end;

end.

