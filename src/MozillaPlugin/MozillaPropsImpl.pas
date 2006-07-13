{@abstract(Moziall .properties file parser) }
{
  Copyright � 2003-2004 by Peter Thornqvist; all rights reserved

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
// $Id: MozillaPropsImpl.pas 13 2006-07-12 14:30:20Z peter3 $
unit MozillaPropsImpl;

interface
uses
  SysUtils, Classes, Types, TntClasses, TransIntf;
type
  TMozillaPropsParser = class(TInterfacedObject, IUnknown, IFileParser)
  private
    FOldAppHandle: Cardinal;
    FOrigFile, FTransFile: string;
    FExportRect:TRect;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure BuildPreview(Items:ITranslationItems; Strings:TTntStrings);
  public
    constructor Create;
    destructor Destroy; override;
    function Capabilities: Integer;safecall;
    function Configure(Capability: Integer): HRESULT;safecall;
    function DisplayName(Capability: Integer): WideString;safecall;
    function ExportItems(const Items: ITranslationItems;
      const Orphans: ITranslationItems): HRESULT;safecall;
    function ImportItems(const Items: ITranslationItems;
      const Orphans: ITranslationItems): HRESULT;safecall;
    procedure Init(AppHandle: Cardinal);safecall;
  end;

implementation
uses
  Forms, IniFiles, PreviewExportFrm, DualImportFrm;

const
  cPropsFilter = 'Mozilla properties files|*.properties|All files (*.*)|*.*';
  cPropsImportTitle = 'Import from Mozilla Properties file';
  cPropsExportTitle = 'Export to Mozilla Properties file';
  cSectionName = 'Mozilla Properties';

{ TMozillaPropsParser }

procedure TMozillaPropsParser.BuildPreview(Items: ITranslationItems;
  Strings: TTntStrings);
var i:integer;
begin
  for i := 0 to Items.Count - 1 do
  with Items[i] do
  begin
    if TransComments <> '' then
      Strings.Add(TransComments);
    Strings.Add(Format('%s=%s',[Name, Translation]));
  end;
end;

function TMozillaPropsParser.Capabilities: Integer;
begin
  Result := CAP_EXPORT or CAP_IMPORT;
end;

function TMozillaPropsParser.Configure(Capability: Integer): HRESULT;
begin
  Result := E_NOTIMPL;
end;

constructor TMozillaPropsParser.Create;
begin
  inherited;
  FOldAppHandle := Application.Handle;
end;

destructor TMozillaPropsParser.Destroy;
begin
  Application.Handle := FOldAppHandle;
  inherited;
end;

function TMozillaPropsParser.DisplayName(Capability: Integer): WideString;
begin
  case Capability of
    CAP_EXPORT:
      Result := cPropsExportTitle;
    CAP_IMPORT:
      Result := cPropsImportTitle;
  else
    Result := '';
  end;
end;

function TMozillaPropsParser.ExportItems(const Items,
  Orphans: ITranslationItems): HRESULT;
var
  S: TTntStringlist;
  FOldSort:TTranslateSortType;
begin
  Result := S_FALSE;
  try
    LoadSettings;
    FOldSort := Items.Sort;
    S := TTntStringlist.Create;
    try
      Items.Sort := stIndex;
      BuildPreview(Items, S);
      if TfrmExport.Execute(FTransFile, cPropsExportTitle, cPropsFilter, '.', 'properties', S) then
      begin
        S.AnsiStrings.SaveToFile(FTransFile);
        Result := S_OK;
        SaveSettings;
      end;
    finally
      S.Free;
      Items.Sort := FOldSort;
    end;
  except
    Application.HandleException(self);
  end;
end;

function TMozillaPropsParser.ImportItems(const Items,
  Orphans: ITranslationItems): HRESULT;
var
  S: TTntStringlist;
  i, j: integer;
  TI: ITranslationItem;
  tmp, cmt:WideString;
begin
  Result := S_FALSE;
  try
    LoadSettings;
    if TfrmImport.Execute(FOrigFile, FTransFile, cPropsImportTitle, cPropsFilter, '.', 'properties') then
    begin
      TI := nil;
      S := TTntStringlist.Create;
      try
        Items.Clear;
        Items.Sort := stIndex;
        Orphans.Clear;
        S.LoadFromFile(FOrigFile);
        for i := 0 to S.Count - 1 do
        begin
          if TI = nil then
            TI := Items.Add;
          if Pos('#', S[i]) = 1 then
            TI.OrigComments := TI.OrigComments + #13#10 + S[i]
          else if Pos('=',S[i]) > 0 then
          begin
            TI.Section := cSectionName;
            TI.Name := trim(Copy(S[i], 1, Pos('=', S[i]) - 1));
            TI.Original := Copy(S[i], Pos('=', S[i]) + 1, MaxInt);
            if i < S.Count - 1 then
              TI := Items.Add;
          end;
        end;
        cmt := '';
        Items.Sort := stSection;
        S.LoadFromFile(FOrigFile);
        for i := 0 to S.Count - 1 do
        begin
          if Pos('#', S[i]) = 1 then
            cmt := cmt + #13#10 + S[i]
          else if Pos('=',S[i]) > 0 then
          begin
            tmp := trim(Copy(S[i], 1, Pos('=', S[i]) - 1));
            j := Items.IndexOf(cSectionName, tmp);
            if j > -1 then
            begin
              TI := Items[j];
              TI.Translation := Copy(S[i], Pos('=', S[i]) + 1, MaxInt);
              TI.Translated := TI.Translation <> '';
              TI.TransComments := cmt;
              cmt := '';
            end;
          end;
        end;
      finally
        S.Free;
      end;
      SaveSettings;
      Result := S_OK;
    end;
  except
    Application.HandleException(self);
  end;
end;

procedure TMozillaPropsParser.Init(AppHandle: Cardinal);
begin
  Application.Handle := AppHandle;
end;

procedure TMozillaPropsParser.LoadSettings;
var M: TMemoryStream;
begin
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
end;

procedure TMozillaPropsParser.SaveSettings;
var M: TMemoryStream;
begin
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
end;

end.

