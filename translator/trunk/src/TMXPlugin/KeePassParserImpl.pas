{@abstract(Parser for KeePass) }
{
keepass.sourceforge.net
  Copyright © 2006 by Peter Thornqvist; all rights reserved

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

unit KeePassParserImpl;

interface
uses
  Classes, Types, TntClasses, TntSysUtils, TransIntf;

type
  TKeePassParser = class(TInterfacedObject, IUnknown, IFileParser)
  private
    FOldAppHandle: Cardinal;
    FFilename: string;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure BuildPreview(Items: ITranslationItems; Strings: TTntStrings);
  public
    constructor Create;
    destructor Destroy; override;

    function Capabilities: Integer; safecall;
    function Configure(Capability: Integer): HRESULT; safecall;
    function DisplayName(Capability: Integer): WideString; safecall;
    function ExportItems(const Items: ITranslationItems;
      const Orphans: ITranslationItems): HRESULT; safecall;
    function ImportItems(const Items: ITranslationItems;
      const Orphans: ITranslationItems): HRESULT; safecall;
    procedure Init(const ApplicationServices: IApplicationServices); safecall;
  end;

implementation
uses
  Windows, SysUtils, Forms, IniFiles, PreviewExportFrm, SingleImportFrm;

const
  cKeePassFilter = 'KeePass Language Files (*.lng)|*.lng|All files (*.*)|*.*';
  cKeePassImportTitle = 'Import from KeePass language file';
  cKeePassExportTitle = 'Export to KeePass language file';

{ TKeePassParser }

procedure TKeePassParser.BuildPreview(Items: ITranslationItems; Strings: TTntStrings);
var
  i: integer;
begin
  for i := 0 to Items.Count - 1 do
  begin
    Strings.Add(WideFormat('|%s||%s|', [Items[i].Original, Items[i].Translation]));
    Strings.Text := Tnt_WideStringReplace(Strings.Text, CRLF, '', [rfReplaceAll]);
  end;
end;

function TKeePassParser.Capabilities: Integer;
begin
  Result := CAP_IMPORT or CAP_EXPORT;
end;

function TKeePassParser.Configure(Capability: Integer): HRESULT;
begin
  Result := E_NOTIMPL;
end;

constructor TKeePassParser.Create;
begin
  inherited;
  FOldAppHandle := Application.Handle;
end;

destructor TKeePassParser.Destroy;
begin
  Application.Handle := FOldAppHandle;
  inherited;
end;

function TKeePassParser.DisplayName(Capability: Integer): WideString;
begin
  case Capability of
    CAP_IMPORT:
      Result := cKeePassImportTitle;
    CAP_EXPORT:
      Result := cKeePassExportTitle;
  else
    Result := '';
  end;
end;

function TKeePassParser.ExportItems(const Items, Orphans: ITranslationItems): HRESULT;
var
  S: TTntStringlist;
  FOldSort: TTranslateSortType;
begin
  Result := S_FALSE;
  FOldSort := Items.Sort;
  try
    LoadSettings;
    Items.Sort := stIndex;
    S := TTntStringlist.Create;
    try
      BuildPreview(Items, S);
      if TfrmExport.Execute(FFilename, cKeePassExportTitle, cKeePassFilter, '.', 'lng', S) then
      begin
        S.AnsiStrings.SaveToFileEx(FFilename, CP_UTF8);
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

// format:
// |ORIGINAL||Translation||ORIGINAL||Translation|...

function TKeePassParser.ImportItems(const Items, Orphans: ITranslationItems): HRESULT;
var
  S: TTntStringlist;

  procedure ParseItems(P: PWideChar);
  const
    cNull = WideChar(#0);
    cBar = WideChar('|');
  type
    States = (Original, Translation);
  var
    R: PWideChar;
    AStates: States;
    TI: ITranslationItem;

  begin
    AStates := Original;
    TI := nil;
    while P^ <> cNull do
    begin
      if P^ = cBar then
      begin
        case AStates of
          Original:
            begin
              Inc(P);
              R := P;
              while P^ <> cBar do
                Inc(P);
              TI := Items.Add;
              TI.Original := Copy(R, 0, P - R);
              Inc(P);
              AStates := Translation;
            end;
          Translation:
            begin
              Inc(P);
              R := P;
              while P^ <> cBar do
                Inc(P);
              if TI <> nil then
              begin
                TI.Translation := Copy(R, 0, P - R);
                TI.Translated := TI.Translation <> '';
              end;
              Inc(P);
              AStates := Original;
            end;
        end;
      end
      else
        Inc(P);
    end;
  end;
begin
  LoadSettings;
  if TfrmSingleImport.Execute(FFilename, cKeePassImportTitle, cKeePassFilter, '.', 'lng') then
  begin
    Items.Clear;
    Items.Sort := stNone;
    S := TTntStringlist.Create;
    try
      S.AnsiStrings.LoadFromFileEx(FFilename, CP_UTF8);
      ParseItems(PWideChar(S.Text));
      Items.Modified := false;
      SaveSettings;
      Result := S_OK;
    finally
      S.Free;
    end;
  end
  else
    Result := S_FALSE;

end;

procedure TKeePassParser.Init(const ApplicationServices: IApplicationServices);
begin
  Application.Handle := ApplicationServices.AppHandle;
end;

procedure TKeePassParser.LoadSettings;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
      FFilename := ReadString('Settings', 'Filename', FFilename);
    finally
      Free;
    end;
  except
    Application.HandleException(self);
  end;
end;

procedure TKeePassParser.SaveSettings;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
      WriteString('Settings', 'Filename', FFilename);
    finally
      Free;
    end;
  except
    Application.HandleException(self);
  end;
end;

end.

