{@abstract(Mozilla DTD parser) }
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
unit MozillaDTDImpl;

interface
uses
  Classes, Types, TntClasses, TransIntf;

type
  TMozillaDTDParser = class(TInterfacedObject, IUnknown, IFileParser)
  private
    FOldAppHandle: Cardinal;
    FOrigFile, FTransFile: string;
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
    procedure Init(const ApplicationServices:IApplicationServices); safecall;
  end;

implementation
uses
  SysUtils, Forms, IniFiles, PreviewExportFrm, DualImportFrm;

const
  cDTDFilter = 'Mozilla DTD Files (*.dtd)|*.dtd|All files (*.*)|*.*';
  cDTDImportTitle = 'Import from Mozilla DTD file';
  cDTDExportTitle = 'Export to Mozilla DTD file';
  cSectionName = 'Mozilla Messenger';

{ TMozillaDTDParser }

procedure TMozillaDTDParser.BuildPreview(Items: ITranslationItems;
  Strings: TTntStrings);
var
  i: integer;
begin
  for i := 0 to Items.Count - 1 do
    with Items[i] do
    begin
      if TransComments <> '' then
        Strings.Add(TransComments);
      Strings.Add(Format('<!ENTITY %s "%s">', [Name, Translation]));
    end;
end;

function TMozillaDTDParser.Capabilities: Integer;
begin
  Result := CAP_IMPORT or CAP_EXPORT;
end;

function TMozillaDTDParser.Configure(Capability: Integer): HRESULT;
begin
  Result := E_NOTIMPL;
end;

constructor TMozillaDTDParser.Create;
begin
  inherited;
  FOldAppHandle := Application.Handle;
end;

destructor TMozillaDTDParser.Destroy;
begin
  Application.Handle := FOldAppHandle;
  inherited;
end;

function TMozillaDTDParser.DisplayName(Capability: Integer): WideString;
begin
  case Capability of
    CAP_IMPORT:
      Result := cDTDImportTitle;
    CAP_EXPORT:
      Result := cDTDExportTitle;
  else
    Result := '';
  end;
end;

function TMozillaDTDParser.ExportItems(const Items,
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
      if TfrmExport.Execute(FTransFile, cDTDExportTitle, cDTDFilter, '.', 'dtd', S) then
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

function TMozillaDTDParser.ImportItems(const Items,
  Orphans: ITranslationItems): HRESULT;
var
  S: TTntStringlist;
  tmp, tmp2, cmt: WideString;
  i, j: integer;
  TI: ITranslationItem;
begin
  Result := S_FALSE;
  try
    Items.Clear;
    Orphans.Clear;
    TI := nil;
    LoadSettings;
    if TfrmImport.Execute(FOrigFile, FTransFile, cDTDImportTitle, cDTDFilter, '.', 'dtd') then
    begin
      Items.Sort := stNone;
      S := TTntStringlist.Create;
      try
        cmt := '';
        S.LoadFromFile(FOrigFile);
        for i := 0 to S.Count - 1 do
        begin
          if Pos('<!ENTITY', S[i]) = 1 then
          begin
            tmp := Copy(S[i], Length('<!ENTITY ') + 1, MaxInt);
            tmp2 := trim(Copy(tmp, 1, Pos('"', tmp) - 1));
//            j := Items.IndexOf(cSectionName, tmp2);
//            if j > -1 then
//              TI := Items[j]
//            else
            TI := Items.Add;
            TI.Name := tmp2;
            tmp := Copy(tmp, Pos('"', tmp) + 1, MaxInt);
            tmp := Copy(tmp, 1, Pos('"', tmp) - 1);
            TI.Section := cSectionName;
            TI.Original := tmp;
            TI.OrigComments := cmt;
            cmt := '';
          end
          else
            cmt := cmt + #13#10 + S[i];
        end;
        Items.Sort := stSection;
        S.LoadFromFile(FTransFile);
        TI := nil;
        cmt := '';
        for i := 0 to S.Count - 1 do
        begin
          if Pos('<!ENTITY', S[i]) = 1 then
          begin
            tmp := Copy(S[i], Length('<!ENTITY ') + 1, MaxInt);
            tmp2 := trim(Copy(tmp, 1, Pos('"', tmp) - 1));
            j := Items.IndexOf(cSectionName, tmp2, true);
            if j > -1 then
            begin
              TI := Items[j];
              tmp := Copy(tmp, Pos('"', tmp) + 1, MaxInt);
              tmp := Copy(tmp, 1, Pos('"', tmp) - 1);
              TI.Translation := tmp;
              TI.Translated := tmp <> '';
              TI.TransComments := cmt;
              cmt := '';
            end;
          end
          else
            cmt := cmt + #13#10 + S[i];
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

procedure TMozillaDTDParser.Init(const ApplicationServices:IApplicationServices);
begin
  Application.Handle := ApplicationServices.AppHandle;
end;

procedure TMozillaDTDParser.LoadSettings;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
      FOrigFile := ReadString('Settings', 'OrigFile', FOrigFile);
      FTransFile := ReadString('Settings', 'TransFile', FTransFile);
    finally
      Free;
    end;
  except
    Application.HandleException(Self);
  end;
end;

procedure TMozillaDTDParser.SaveSettings;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
      WriteString('Settings', 'OrigFile', FOrigFile);
      WriteString('Settings', 'TransFile', FTransFile);
    finally
      Free;
    end;
  except
    Application.HandleException(Self);
  end;
end;

end.

