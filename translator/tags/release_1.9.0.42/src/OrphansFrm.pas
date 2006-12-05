{@abstract(Orphaned Items) }
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

unit OrphansFrm;

{$I TRANSLATOR.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus,
  ComCtrls, StdCtrls, ExtCtrls,
  ActnList,
  BaseForm, TranslateFile, TransIntf, WideIniFiles,
  TntClasses, TntComCtrls, TntStdCtrls, TntActnList, TntMenus, TntExtCtrls, TntDialogs,
  TB2Item, TBX, SpTBXItem;

type
  TfrmOrphans = class(TfrmBase)
    lvOrphaned: TTntListView;
    StatusBar1: TTntStatusBar;
    Panel1: TTntPanel;
    Panel2: TTntPanel;
    lblSection: TTntLabel;
    alOrphans: TTntActionList;
    popListView: TSpTBXPopupMenu;
    Copy1: TSpTBXItem;
    acCopy: TTntAction;
    TntPanel1: TTntPanel;
    btnSave: TTntButton;
    btnMerge: TTntButton;
    acSave: TTntAction;
    acMerge: TTntAction;
    procedure lvOrphanedResize(Sender: TObject);
    procedure acCopyExecute(Sender: TObject);
    procedure alOrphansUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure lvOrphanedChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormShow(Sender: TObject);
    procedure acMergeExecute(Sender: TObject);
    procedure lvOrphanedData(Sender: TObject; Item: TListItem);
    procedure acSaveExecute(Sender: TObject);
  private
    FItems, FOrphans: ITranslationItems;
    FOnMerge:TNotifyEvent;
    procedure SaveToFile(const FileName: WideString);
    procedure ShowError(Count:integer);
    { Private declarations }
  public
    { Public declarations }
    class function Edit(const Items, Orphans: ITranslationItems; CanMerge:boolean; OnMerge:TNotifyEvent): boolean;
  end;

implementation
uses
  AppUtils, CommonUtils, AppConsts, TntClipbrd, Dialogs;

{$R *.dfm}

class function TfrmOrphans.Edit(const Items, Orphans: ITranslationItems; CanMerge:boolean; OnMerge:TNotifyEvent): boolean;
var
  frmOrphans: TfrmOrphans;
begin
  frmOrphans := self.Create(Application);
  try
    frmOrphans.FItems := Items;
    frmOrphans.FOrphans := Orphans;
    frmOrphans.FOnMerge := OnMerge;
    frmOrphans.lvOrphaned.Items.Count := Orphans.Count;
    frmOrphans.acSave.Enabled := Orphans.Count > 0;
    frmOrphans.acMerge.Enabled := Assigned(OnMerge) and CanMerge and (Orphans.Count > 0);
    Result := frmOrphans.ShowModal = mrOK;
  finally
    frmOrphans.Free;
  end;
end;

procedure TfrmOrphans.lvOrphanedResize(Sender: TObject);
begin
  lvOrphaned.Columns[0].Width := lvOrphaned.ClientWidth div 2;
  lvOrphaned.Columns[1].Width := lvOrphaned.ClientWidth - lvOrphaned.Columns[0].Width;
end;

procedure TfrmOrphans.acCopyExecute(Sender: TObject);
var S: WideString;
begin
  with lvOrphaned.Selected do
  begin
    if (Index >= 0) and (Index < FOrphans.Count) then
    begin
      S := FOrphans.Items[Index].Translation;
      if S = '' then
        S := FOrphans.Items[Index].Original;
      if S <> '' then
        TntClipboard.AsWideText := S;
    end;
  end;
end;

procedure TfrmOrphans.alOrphansUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  acCopy.Enabled := (lvOrphaned.Selected <> nil)
    and ((lvOrphaned.Selected.Caption <> '') or (lvOrphaned.Selected.SubItems[0] <> ''));
end;

procedure TfrmOrphans.lvOrphanedChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if (lvOrphaned.Selected <> nil) then
    lblSection.Caption := '[' + FOrphans.Items[lvOrphaned.Selected.Index].Section + '] ' + FOrphans.Items[lvOrphaned.Selected.Index].Name 
  else
    lblSection.Caption := '[]';
end;

procedure TfrmOrphans.FormShow(Sender: TObject);
begin
  if (lvOrphaned.Selected = nil) and (lvOrphaned.Items.Count > 0) then
    lvOrphaned.Selected := lvOrphaned.Items[0];
  if lvOrphaned.Selected <> nil then
    lvOrphaned.Selected.Focused := true;
end;

procedure TfrmOrphans.SaveToFile(const FileName: WideString);
var i, iError: integer;
begin
  with TWideMemIniFile.Create(Filename) do
  try
    iError := 0;
    for i := 0 to FOrphans.Count - 1 do
      with FOrphans.Items[i] do
        if Original <> '' then
          WriteString(Section, Original, Translation)
        else
          Inc(iError);
    UpdateFile;
    if iError > 0 then
      ShowError(iError);
  finally
    Free;
  end;
end;

procedure TfrmOrphans.acMergeExecute(Sender: TObject);
begin
  if Assigned(FOnMerge) then
  begin
    FOnMerge(self);
    lvOrphaned.Items.Count := FOrphans.Count;
    lvOrphaned.Invalidate;
  end;
  acMerge.Enabled := (FOrphans.Count > 0);
  acSave.Enabled := acMerge.Enabled;
  lvOrphanedChange(nil, nil, ctState);
end;

procedure TfrmOrphans.lvOrphanedData(Sender: TObject; Item: TListItem);
begin
  if (Item <> nil) and (Item.Index >= 0) and (Item.Index < FOrphans.Count) then
    begin
      TTntListItem(Item).Caption := FOrphans.Items[Item.Index].Original;
      TTntListItem(Item).SubItems.Add(FOrphans.Items[Item.Index].Translation);
    end;
end;

procedure TfrmOrphans.acSaveExecute(Sender: TObject);
begin
  with TTntSaveDialog.Create(nil) do
  try
    Options := Options + [ofOverwritePrompt];
    Filter := SAllFileFilter;
    InitialDir := '.';
    if Execute then
      SaveToFile(Filename);
  finally
    Free;
  end;
end;

procedure TfrmOrphans.ShowError(Count: integer);
begin
  ErrMsg(WideFormat(SFmtSaveItemsNoName,[Count]), SErrorCaption);
end;

end.

