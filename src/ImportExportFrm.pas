{@abstract(Import / export form: lists available import or export plugins) }
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
// $Id: ImportExportFrm.pas 13 2006-07-12 14:30:20Z peter3 $
unit ImportExportFrm;

{$I TRANSLATOR.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ActnList,
  BaseForm, TranslateFile, TransIntf,
  TntActnList, TntStdCtrls, TntComCtrls;

type
  TfrmImportExport = class(TfrmBase)
    lvItems: TTntListView;
    btnOK: TTntButton;
    btnCancel: TTntButton;
    lblList: TTntLabel;
    acImportExport: TTntActionList;
    acImport: TTntAction;
    acExport: TTntAction;
    btnConfigure: TTntButton;
    acConfigure: TTntAction;
    stNothingToShow: TTntStaticText;
    procedure lvItemsDblClick(Sender: TObject);
    procedure acImportExportUpdate(Action: TBasicAction;
      var Handled: boolean);
    procedure lvItemsEnter(Sender: TObject);
    procedure acImportExecute(Sender: TObject);
    procedure acExportExecute(Sender: TObject);
    procedure acConfigureExecute(Sender: TObject);
  private
    { Private declarations }
    FCapabilitiesSupported: integer;
    FItems, FOrphans: ITranslationItems;
    FImport: boolean;
    function DoTranslate(const S: WideString): WideString;
    function LoadPlugins(const PluginFolder: string; ForImport: boolean): integer;
  public
    { Public declarations }
    class function Edit(const Items, Orphans: ITranslationItems; const PluginFolder: string;
      const DoImport: boolean; var ItemIndex, CapabilitesSupported: integer): boolean;
  end;

implementation
uses
  AppConsts, AppUtils;

{$R *.dfm}
var
  FLoadedLibs: TList = nil;

type
  TLibItem = class
    LibName: string;
    LibHandle: HMODULE;
    Parser: IFileParser;
  end;

function InternalLoadLibrary(const LibName: string): TLibItem;
var
  LibHandle: HMODULE;
  ExportFunc: TExportFunc;
  i: integer;
begin
  Result := nil;
  // find already loaded DLL's
  for i := 0 to FLoadedLibs.Count - 1 do
    if AnsiSameText(TLibItem(FLoadedLibs[i]).LibName, LibName) then
    begin
      Result := FLoadedLibs[i];
      Exit;
    end;
  // check if this module is already in the adress space
  LibHandle := GetModuleHandle(PChar(LibName));
  // load DLL
  if LibHandle = 0 then
    LibHandle := LoadLibrary(PChar(LibName));
  // check for the exported function
  if LibHandle <> 0 then
  begin
    ExportFunc := GetProcAddress(LibHandle, cRegisterTransFileParserFuncName);
    if (@ExportFunc <> nil) then
    begin
      Result := TLibItem.Create;
    // check that we can get an implementation
      if (ExportFunc(Result.Parser) <> S_OK) then
        FreeAndNil(Result)
      else
      begin
        Result.LibName := LibName;
        Result.LibHandle := LibHandle;
        FLoadedLibs.Add(Result);
      end;
    end;
  end;
end;

procedure FreeLibraries;
var
  i: integer;
begin
  for i := 0 to FLoadedLibs.Count - 1 do
    if FLoadedLibs[i] <> nil then
    begin
      TLibItem(FLoadedLibs[i]).Parser := nil;
      FreeLibrary(TLibItem(FLoadedLibs[i]).LibHandle);
      TLibItem(FLoadedLibs[i]).Free;
    end;
  FLoadedLibs.Count := 0;
end;

{ TfrmImportExport }

class function TfrmImportExport.Edit(const Items, Orphans: ITranslationItems;
  const PluginFolder: string; const DoImport: boolean; var ItemIndex, CapabilitesSupported: integer): boolean;
var
  frmImportExport: TfrmImportExport;
  i: integer;
begin
  frmImportExport := Self.Create(Application);
  with frmImportExport do
  try
    FImport := DoImport;
    FItems := Items;
    FOrphans := Orphans;
    if DoImport then
    begin
      Caption := DoTranslate(SImportCaption);
      lblList.Caption := DoTranslate(SImportLabelCaption);
      btnOK.Action := acImport;
      btnOK.Caption := DoTranslate(SImportButtonCaption);
    end
    else
    begin
      Caption := DoTranslate(SExportCaption);
      lblList.Caption := DoTranslate(SExportLabelCaption);
      btnOK.Action := acExport;
      btnOK.Caption := DoTranslate(SExportButtonCaption);
    end;
{    if LoadPlugins(PluginFolder, DoImport) = 0 then
    begin
      ErrMsg(DoTranslate(SNoPluginsAvaliable), DoTranslate(SPluginError));
      Result := false;
      Exit;
    end; }
    i := LoadPlugins(PluginFolder, DoImport);
    lvItems.AlphaSort;
    if (ItemIndex >= 0) and (ItemIndex < lvItems.Items.Count) then
    begin
      lvItems.Items[ItemIndex].Selected := true;
      lvItems.Items[ItemIndex].Focused := true;
    end;
    Result := (ShowModal = mrOK) and (i > 0);
    if Result then
    begin
      if DoImport then
        CapabilitesSupported := FCapabilitiesSupported;
      ItemIndex := lvItems.ItemIndex;
    end;
  finally
    Free;
  end;
end;

procedure TfrmImportExport.lvItemsDblClick(Sender: TObject);
begin
  btnOK.Click;
end;

procedure TfrmImportExport.acImportExportUpdate(Action: TBasicAction;
  var Handled: boolean);
begin
  if btnOK.Action <> nil then
    TAction(btnOK.Action).Enabled := lvItems.Selected <> nil;
  acConfigure.Enabled := (lvItems.Selected <> nil) and
    (TLibItem(lvItems.Selected.Data).Parser.Capabilities and CAP_CONFIGURE = CAP_CONFIGURE);
end;

function TfrmImportExport.LoadPlugins(const PluginFolder: string;
  ForImport: boolean): integer;
const
  cCapability: array[boolean] of integer = (CAP_EXPORT, CAP_IMPORT);
var
  F: TSearchRec;
  APath: string;
  li: TListItem;
  LibItem: TLibItem;
begin
  Result := 0;
  APath := IncludeTrailingPathDelimiter(PluginFolder);
{$WARN SYMBOL_PLATFORM OFF}
  if FindFirst(APath + '*.dll', faAnyFile and not (faDirectory or faVolumeID), F) = 0 then
  try
    repeat
      if FileExists(APath + F.Name) then
      begin
        LibItem := InternalLoadLibrary(APath + F.Name);
        if LibItem <> nil then
        begin
          begin
            if (LibItem.Parser.Capabilities and cCapability[ForImport] = cCapability[ForImport]) then
            begin
              li := lvItems.Items.Add;
              li.Caption := DoTranslate(LibItem.Parser.DisplayName(cCapability[ForImport]));
              li.Data := LibItem;
              Inc(Result);
            end;
          end;
        end;
      end;
    until FindNext(F) <> 0;
  finally
    FindClose(F);
  end;
  if lvItems.Items.Count = 0 then
  begin
//    lvItems.Enabled := false;
    with stNothingToShow do
    begin
      Parent := lvItems;
      Left := (lvItems.ClientWidth - ClientWidth) div 2;
      Top := 8;
    end;
  end
  else
    stNothingToShow.Visible := false;
end;

procedure TfrmImportExport.lvItemsEnter(Sender: TObject);
begin
  if (lvItems.Selected = nil) and (lvItems.Items.Count > 0) then
  begin
    lvItems.Items[0].Selected := true;
    lvItems.Items[0].Focused := true;
  end;
end;

procedure TfrmImportExport.acImportExecute(Sender: TObject);
var
  Parser: IFileParser;
begin
  Parser := TLibItem(lvItems.Selected.Data).Parser;
  Parser.Init(Application.Handle);
  FCapabilitiesSupported := Parser.Capabilities;
  if FCapabilitiesSupported and CAP_CONFIGURE = CAP_CONFIGURE then
    if Parser.Configure(CAP_IMPORT) <> S_OK then
    begin
      ModalResult := mrAbort;
      Close;
      Exit;
    end;
  if Parser.ImportItems(FItems, FOrphans) <> S_OK then
    ModalResult := mrNone;
end;

procedure TfrmImportExport.acExportExecute(Sender: TObject);
var
  Parser: IFileParser;
begin
  Parser := TLibItem(lvItems.Selected.Data).Parser;
  Parser.Init(Application.Handle);
  if Parser.Capabilities and CAP_CONFIGURE = CAP_CONFIGURE then
    if Parser.Configure(CAP_EXPORT) <> S_OK then
    begin
      ModalResult := mrAbort;
      Close;
      Exit;
    end;
  if Parser.ExportItems(FItems, FOrphans) <> S_OK then
    ModalResult := mrNone;
end;

procedure TfrmImportExport.acConfigureExecute(Sender: TObject);
const
  cCapability: array[boolean] of integer = (CAP_EXPORT, CAP_IMPORT);
begin
  TLibItem(lvItems.Selected.Data).Parser.Configure(cCapability[FImport]);
end;

function TfrmImportExport.DoTranslate(const S: WideString): WideString;
begin
  if GlobalLanguageFile <> nil then
    Result := GlobalLanguageFile.Translate(Application.MainForm.ClassName, S, S)
  else
    Result := S;
end;

initialization
  FLoadedLibs := TList.Create;
finalization
  FreeLibraries;
  FreeAndNil(FLoadedLibs);

end.