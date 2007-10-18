{@abstract(Parser for SciTE language files) }
{
  Copyright � 2003-2006 by Peter Thornqvist; all rights reserved

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
unit SciTEParserImpl;

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
  TSciTEParser = class(TInterfacedObject, IUnknown, IFileParser)
  private
    FOldHandle:LongWord;
    FTransFile:WideString;
    FExportRect:TRect;
    procedure BuildPreview(const Items:ITranslationItems; Strings:TTntStrings);
    function DoSciTEImport(const Items, Orphans:ITranslationItems; const TransFile:WideString):boolean;
    procedure LoadSettings;
    procedure SaveSettings;
  public
    constructor Create;
    destructor Destroy; override;
    function Configure(Capability:Integer):HRESULT; safecall;
    function DisplayName(Capability:Integer):WideString; safecall;
    function ExportItems(const Items, Orphans:ITranslationItems):HRESULT; safecall;
    function ImportItems(const Items, Orphans:ITranslationItems):HRESULT; safecall;
    procedure Init(const ApplicationServices:IApplicationServices); safecall;
    function Capabilities:Integer; safecall;
  end;

implementation
uses
  Windows, Forms, IniFiles, CommonUtils, PreviewExportFrm, SingleImportFrm;

const
  cSciTEFilter = 'SciTE files (locale.properties)|*.properties|All files (*.*)|*.*';
  cSciTEExportTitle = 'Export to SciTE language file';
  cSciTEImportTitle = 'Import from SciTE language file';
  cSectionName = 'SciTE';
  SImportError = 'There was an error importing, please check the files and try again';
  SError = 'SciTE Parser Error';

function YesNo(const Text, Caption:WideString):boolean;
begin
  Result := WideMessageBox(GetActiveWindow, PWideChar(Text), PWideChar(Caption), MB_YESNO or MB_ICONQUESTION) = IDYES;
end;

procedure ShowError(const Text:WideString);
begin
  WideMessageBox(GetActiveWindow, PWideChar('There was an error:'#13#10 + Text), PWideChar(WideString('SciTE Error')), MB_OK or MB_ICONERROR);
end;

{ TSciTEParser }

function TSciTEParser.Capabilities:Integer;
begin
  Result := CAP_IMPORT or CAP_EXPORT;
end;

function TSciTEParser.Configure(Capability:Integer):HRESULT;
begin
  Result := S_OK;
end;

constructor TSciTEParser.Create;
begin
  inherited Create;
  FOldHandle := Application.Handle;
end;

procedure TSciTEParser.BuildPreview(const Items:ITranslationItems;
  Strings:TTntStrings);
var
  i:integer;
  FOldSort:TTranslateSortType;
begin
  try
    FOldSort := Items.Sort;
    try
      Items.Sort := stIndex;
      for i := 0 to Items.Count - 1 do
      begin
        if Items[i].OrigComments <> '' then
          Strings.Add(Items[i].OrigComments);
        Strings.Add(Format('%s=%s', [Items[i].Original, Items[i].Translation]));
      end;
    finally
      Items.Sort := FOldSort;
    end;
  except
    Application.HandleException(Self);
  end;
end;

destructor TSciTEParser.Destroy;
begin
  Application.Handle := FOldHandle;
  inherited;
end;

function TSciTEParser.DisplayName(Capability:Integer):WideString;
begin
  case Capability of
    CAP_IMPORT:Result := cSciTEImportTitle;
    CAP_EXPORT:Result := cSciTEExportTitle;
//    CAP_CONFIGURE : Result := 'Configure';
  else
    Result := '';
  end;
end;

function TSciTEParser.DoSciTEImport(const Items, Orphans:ITranslationItems;
  const TransFile:WideString):boolean;
var
  S:TTntStringList;
  i:integer;
  FOldSort:TTranslateSortType;
  FLastItem:ITranslationItem;
  procedure ParseRow(const S:WideString);
  begin
    if (Pos('#', S) = 1) then
    begin
      if FLastItem = nil then
      begin
        FLastItem := Items.Add;
        FLastItem.Index := Items.Count - 1;
      end;
      if FLastItem.OrigComments <> '' then
        FLastItem.OrigComments := FLastItem.OrigComments + #13#10;
      FLastItem.OrigComments := FLastItem.OrigComments + S;
    end
    else if (S = '') then
    begin
      if FLastItem = nil then
      begin
        FLastItem := Items.Add;
        FLastItem.Index := Items.Count - 1;
      end;
      FLastItem.OrigComments := FLastItem.OrigComments + #13#10;
    end
    else
    begin
      if FLastItem = nil then
      begin
        FLastItem := Items.Add;
        FLastItem.Index := Items.Count - 1;
      end;
      FLastItem.Section := 'SciTE';
      FLastItem.Original := Copy(S, 1, Pos('=', S) - 1);
      FLastItem.Name := FLastItem.Original;
      FLastItem.Translation := Copy(S, Pos('=', S) + 1, MaxInt);
      FLastItem.Translated := FLastItem.Translation <> '';
      FLastItem := nil;
    end;
  end;
begin
  Result := false;
  try
    Items.Clear;
    Orphans.Clear;
    FOldSort := Items.Sort;
    Items.Sort := stNone;
    FLastItem := nil;
    S := TTntStringlist.Create;
    try
      S.LoadFromFile(TransFile);
      for i := 0 to S.Count - 1 do
        ParseRow(S[i]);
      // remove any empty lines at the end
      i := Items.Count - 1;
      while (i >= 0) and (Items[i].Original = '') do
      begin
        Items.Delete(i);
        Dec(i);
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

function TSciTEParser.ExportItems(const Items, Orphans:ITranslationItems):HRESULT;
var
  S:TTntStringlist;
begin
  try
    Result := S_FALSE;
    LoadSettings;
    S := TTntStringlist.Create;
    try
      BuildPreview(Items, S);
      if TfrmExport.Execute(FTransFile, cSciTEExportTitle, cSciTEFilter, '.', 'properties', S) then
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

function TSciTEParser.ImportItems(const Items, Orphans:ITranslationItems):HRESULT;
begin
  try
    Result := S_FALSE;
    LoadSettings;
    if TfrmSingleImport.Execute(FTransFile, cSciTEImportTitle, cSciTEFilter, '.', 'properties') then
    begin
      if DoSciTEImport(Items, Orphans, FTransFile) then
      begin
        SaveSettings;
        Items.Modified := false;
        Orphans.Modified := false;
        Result := S_OK;
      end
      else
        Application.MessageBox(PChar(SImportError), PChar(SError), MB_OK or MB_ICONERROR);
    end;
  except
    Application.HandleException(Self);
  end;
end;

procedure TSciTEParser.Init(const ApplicationServices:IApplicationServices);
begin
  Application.Handle := ApplicationServices.AppHandle;
end;

procedure TSciTEParser.LoadSettings;
var
  M:TMemoryStream;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
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

procedure TSciTEParser.SaveSettings;
var
  M:TMemoryStream;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
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
