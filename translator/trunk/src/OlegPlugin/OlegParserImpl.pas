{@abstract(Parser for Oleg) }
{
  Copyright © 2003-2004 by Peter Thornqvist; all rights reserved

  Developer(s):

  Status:
   The contents of this file are subject to the Mozilla Public License Version
   1.1 (the "License"); you may not use this file except in compliance with the
   License. You may obtain a copy of the License at http://www.mozilla.org/MPL/MPL-1.1.html

   Software distributed under the License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.
}
// $Id: OlegParserImpl.pas 13 2006-07-12 14:30:20Z peter3 $
unit OlegParserImpl;

interface
uses
  Classes, Types, TntClasses, TransIntf;

type
  TOlegParser = class(TInterfacedObject, IUnknown, IFileParser)
  private
    FOldAppHandle: Cardinal;
    FTransFile: string;
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
    procedure Init(AppHandle: Cardinal); safecall;
  end;

implementation
uses
  SysUtils, Forms, IniFiles, PreviewExportFrm, SingleImportFrm;

const
  cOlegFilter = 'OlegTranslator  Files (*.txt)|*.txt|All files (*.*)|*.*';
  cOlegImportTitle = 'Import from OlegTranslator file';
  cOlegExportTitle = 'Export to OlegTranslator file';
  cSectionName = 'OlegTranslator';

{ TOlegParser }

procedure TOlegParser.BuildPreview(Items: ITranslationItems;
  Strings: TTntStrings);
var i: integer;
begin
  for i := 0 to Items.Count - 1 do
    Strings.Add(Items[i].Original + WideChar(#9) + Items[i].Translation);
end;

function TOlegParser.Capabilities: Integer;
begin
  Result := CAP_IMPORT or CAP_EXPORT;
end;

function TOlegParser.Configure(Capability: Integer): HRESULT;
begin
  Result := E_NOTIMPL;
end;

constructor TOlegParser.Create;
begin
  inherited;
  FOldAppHandle := Application.Handle;
end;

destructor TOlegParser.Destroy;
begin
  Application.Handle := FOldAppHandle;
  inherited;
end;

function TOlegParser.DisplayName(Capability: Integer): WideString;
begin
  case Capability of
    CAP_IMPORT:
      Result := cOlegImportTitle;
    CAP_EXPORT:
      Result := cOlegExportTitle;
  else
    Result := '';
  end;
end;

function TOlegParser.ExportItems(const Items,
  Orphans: ITranslationItems): HRESULT;
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
      if TfrmExport.Execute(FTransFile, cOlegExportTitle, cOlegFilter, '.', 'txt', S) then
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

function TOlegParser.ImportItems(const Items, Orphans: ITranslationItems): HRESULT;
var
  S: TTntStringlist;
  i, j: integer;
  TI: ITranslationItem;
begin
  Result := S_FALSE;
  try
    Items.Clear;
    Orphans.Clear;
    TI := nil;
    LoadSettings;
    if TfrmImport.Execute(FTransFile, cOlegImportTitle, cOlegFilter, '.', 'txt') then
    begin
      Items.Sort := stNone;
      S := TTntStringlist.Create;
      try
        S.LoadFromFile(FTransFile);
        for i := 0 to S.Count - 1 do
        begin
          j := Pos(#9, S[i]);
          if j > 0 then
          begin
            TI := Items.Add;
            TI.Section := cSectionName;
            TI.Original := Copy(S[i], 1, j - 1);
            TI.Translation := Copy(S[i], j + 1, MaxInt);
          end;
        end;
      finally
        Items.Sort := stIndex;
        S.Free;
      end;
      SaveSettings;
      Result := S_OK;
    end;
  except
    Application.HandleException(self);
  end;
end;

procedure TOlegParser.Init(AppHandle: Cardinal);
begin
  Application.Handle := AppHandle;
end;

procedure TOlegParser.LoadSettings;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
      FTransFile := ReadString('Settings', 'TransFile', FTransFile);
    finally
      Free;
    end;
  except
    Application.HandleException(self);
  end;
end;

procedure TOlegParser.SaveSettings;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
      WriteString('Settings', 'TransFile', FTransFile);
    finally
      Free;
    end;
  except
    Application.HandleException(self);
  end;
end;

end.

