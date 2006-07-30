{@abstract(IB Forums laguage file parser) }
{
  Copyright © 2003-2006 by Peter Thornqvist; all rights reserved

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
// $Id$
unit IBForumsParserImpl;

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
  TIBFParser = class(TInterfacedObject, IUnknown, IFileParser)
  private
    FOldHandle: LongWord;
    FOrigFile, FTransFile: string;
    FExportRect: TRect;
    procedure BuildPreview(const Items: ITranslationItems; Strings: TTntStrings);
    function DoImport(const Items, Orphans: ITranslationItems; const OrigFile, TransFile: string): boolean;
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
    function HandleOrig(const AFilename: WideString; const Items: ITranslationItems; const Orphans: ITranslationItems): Boolean; safecall;
    function HandleTrans(const AFilename: WideString; const Items: ITranslationItems; const Orphans: ITranslationItems): Boolean; safecall;
  end;

implementation
uses
  Windows, Forms, IniFiles, TntSysUtils, PreviewExportFrm, DualImportFrm;

var
  FHeader, FFooter: TTntStringlist;

const
  cPHPFilter = 'PHP files (*.php)|*.php|All files (*.*)|*.*';
  cIBFExportTitle = 'Export to IB Forums language file';
  cIBFImportTitle = 'Import from IB Forums language file';
  cSectionName = 'IB Forums';
  SImportError = 'There was an error importing, please check the files and try again';
  SError = 'IB Forums Parser Error';
  SFmtErrorMsg = '%s';

function YesNo(const Text, Caption: string): boolean;
begin
  Result := Application.MessageBox(PChar(Text), PChar(Caption), MB_YESNO or MB_ICONQUESTION) = IDYES;
end;

function MyWideDequotedStr(const S: WideString; Quote: WideChar): WideString;
//var LText:PWideChar;
begin
  Result := S;
  if (S = '') or (Quote = #0) then
    Result := S;
  if (Length(S) > 1) and (S[1] = Quote) and (TntWideLastChar(S) = Quote) then
    Result := Copy(S, 2, Length(S) - 2)
end;

procedure ShowError(const Text: string);
begin
  Application.MessageBox(PChar(Format(SFmtErrorMsg, [Text])), PChar(SError), MB_OK or MB_ICONERROR);
end;

{ TIBFParser }

function TIBFParser.Capabilities: Integer;
begin
  Result := CAP_IMPORT or CAP_EXPORT;
end;

function TIBFParser.Configure(Capability: Integer): HRESULT;
begin
  Result := S_OK;
end;

constructor TIBFParser.Create;
begin
  inherited Create;
  FOldHandle := Application.Handle;
end;

procedure TIBFParser.BuildPreview(const Items: ITranslationItems;
  Strings: TTntStrings);
var
  i: integer;
  FOldSort: TTranslateSortType;
begin
  try
    FOldSort := Items.Sort;
    try
      Items.Sort := stIndex;
      if FHeader.Count = 0 then
        FHeader.Add('<?php');
      if FFooter.Count = 0 then
        FFooter.Add('?>');

      Strings.AddStrings(FHeader);
      for i := 0 to Items.Count - 1 do
        Strings.Add(Format('$lang[''%s''] = %s;', [Items[i].Name, Items[i].Translation]));
      Strings.AddStrings(FFooter);
    finally
      Items.Sort := FOldSort;
    end;
  except
    Application.HandleException(Self);
  end;
end;

destructor TIBFParser.Destroy;
begin
  Application.Handle := FOldHandle;
  inherited;
end;

function TIBFParser.DisplayName(Capability: Integer): WideString;
begin
  case Capability of
    CAP_IMPORT: Result := cIBFImportTitle;
    CAP_EXPORT: Result := cIBFExportTitle;
//    CAP_CONFIGURE : Result := 'Configure';
  else
    Result := '';
  end;
end;

function TIBFParser.DoImport(const Items, Orphans: ITranslationItems;
  const OrigFile, TransFile: string): boolean;
var
  S: TTntStringList;
  HeaderComplete: boolean;
  i: integer;
  FOldSort: TTranslateSortType;
  function ParseRow(const S: string; IsTranslation, TranslateFormat: boolean): boolean;
  var
    T: ITranslationItem;
    i: integer;
    tmp, tmp2: Widestring;
  begin
    Result := false;
    if not TranslateFormat then
    begin
      i := Pos('=>', S);
      tmp := trim(Copy(S, 1, i - 1));
      tmp2 := trim(Copy(S, i + 3, MaxInt));
      if Length(tmp2) > 0 then
        SetLength(tmp2, Length(tmp2) - 1);
    end
    else
    begin
      /// $lang['id']

      i := Pos('$lang[', S);
      tmp := Copy(S, i + 6, MaxInt);
      i := Pos(']', tmp);
      tmp := trim(Copy(tmp, 1, i - 1));

      i := Pos('=', S);
      tmp2 := trim(Copy(S, i + 1, MaxInt));
      if Length(tmp2) > 0 then
        SetLength(tmp2, Length(tmp2) - 1);
    end;
    tmp := MyWideDequotedStr(tmp, '"');
    tmp := MyWideDequotedStr(tmp, #39);
    if IsTranslation then
    begin
      i := Items.IndexOf(cSectionName, tmp);
      if i > -1 then
      begin
        T := Items[i];
        T.Translation := tmp2;
        T.Translated := tmp2 <> '';
      end;
    end
    else
    begin
      T := Items.Add;
      T.Section := cSectionName;
      T.Name := MyWideDequotedStr(tmp, #39);
      T.Original := tmp2;
      Result := true;
    end;
  end;

begin
{

  original file format:
<?php
$lang = array (

'gzip_on' => "GZIP Enabled",
'gzip_off' => "GZIP Disabled",

<more of the same>

ba_edit => "Edit",
ba_delete => "Delete",

<more of the same>

);
?>

  translated file format:
<?php
$lang['by']  = "Av";
$lang['newslink']  = "senaste nytt:";

?>

}
  Result := false;
  try
    Items.Clear;
    Orphans.Clear;
    FOldSort := Items.Sort;
    Items.Sort := stNone;
    HeaderComplete := false;
    S := TTntStringlist.Create;
    try
      S.LoadFromFile(OrigFile);
      for i := 0 to S.Count - 1 do
        if Pos('=>', S[i]) > 0 then
          ParseRow(S[i], false, false);

      FHeader.Clear;
      FFooter.Clear;
      Items.Sort := stSection;
      S.LoadFromFile(TransFile);
      for i := 0 to S.Count - 1 do
        if Pos('=>', S[i]) > 0 then
        begin
          ParseRow(S[i], true, false);
          HeaderComplete := true;
        end
        else if Pos('$lang[', S[i]) > 0 then
        begin
          ParseRow(S[i], true, true);
          HeaderComplete := true;
        end
        else if Pos('$lang', S[i]) = 0 then
        begin
          if not HeaderComplete then
            FHeader.Add(S[i])
          else
            FFooter.Add(S[i]);
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

function TIBFParser.ExportItems(const Items, Orphans: ITranslationItems): HRESULT;
var
  S: TTntStringlist;
begin
  try
    Result := S_FALSE;
    LoadSettings;
    S := TTntStringlist.Create;
    try
      BuildPreview(Items, S);
      if TfrmExport.Execute(FTransFile, cIBFExportTitle, cPHPFilter, '.', 'php', S) then
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

function TIBFParser.ImportItems(const Items, Orphans: ITranslationItems): HRESULT;
begin
  Result := S_FALSE;
  LoadSettings;
  if TfrmImport.Execute(FOrigFile, FTransFile, cIBFImportTitle, cPHPFilter, '.', 'php') then
  begin
    if DoImport(Items, Orphans, FOrigFile, FTransFile) then
    begin
      SaveSettings;
      Result := S_OK;
    end
    else
      Application.MessageBox(PChar(SImportError), PChar(SError), MB_OK or MB_ICONERROR);
  end;
end;

procedure TIBFParser.Init(AppHandle: Cardinal);
begin
  Application.Handle := AppHandle;
end;

procedure TIBFParser.LoadSettings;
var
  M: TMemoryStream;
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

procedure TIBFParser.SaveSettings;
var
  M: TMemoryStream;
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

function TIBFParser.HandleOrig(const AFilename: WideString; const Items,
  Orphans: ITranslationItems): Boolean;
begin
  Result := false;
end;

function TIBFParser.HandleTrans(const AFilename: WideString; const Items,
  Orphans: ITranslationItems): Boolean;
begin
  Result := false;
end;

initialization
  FHeader := TTntStringlist.Create;
  FFooter := TTntStringlist.Create;

finalization
  FHeader.Free;
  FFooter.Free;

end.

