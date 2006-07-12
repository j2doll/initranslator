{@abstract(Orphaned Items) }
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

// $Id: OrphansFrm.pas 13 2006-07-12 14:30:20Z peter3 $

unit OrphansFrm;

{$I TRANSLATOR.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Menus,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls,
  ActnList,
  BaseForm, TranslateFile, TransIntf,
  TntClasses, TntComCtrls, TntStdCtrls, TntActnList, TntMenus, TntExtCtrls;

type
  TfrmOrphans = class(TfrmBase)
    lvOrphaned: TTntListView;
    StatusBar1: TTntStatusBar;
    Panel1: TTntPanel;
    Panel2: TTntPanel;
    lblSection: TTntLabel;
    alOrphans: TTntActionList;
    PopupMenu1: TTntPopupMenu;
    Copy1: TTntMenuItem;
    acCopy: TTntAction;
    procedure lvOrphanedResize(Sender: TObject);
    procedure acCopyExecute(Sender: TObject);
    procedure alOrphansUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure lvOrphanedChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Edit(const Items: ITranslationItems): boolean;
  end;

implementation
uses
  AppUtils, Clipbrd;

{$R *.dfm}

class function TfrmOrphans.Edit(const Items: ITranslationItems): boolean;
var
  frmOrphans: TfrmOrphans;
  i: integer;
begin
  frmOrphans := self.Create(Application);
  try
    for i := 0 to Items.Count - 1 do
      with TTntListItem(frmOrphans.lvOrphaned.Items.Add) do
      begin
        Caption := Items[i].Original;
        SubItems.Add(Items[i].Translation);
        SubItems.Add(Items[i].Section);
      end;
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
var S: string;
begin
  S := lvOrphaned.Selected.SubItems[0];
  if S = '' then
    S := lvOrphaned.Selected.Caption;
  if S <> '' then
    Clipboard.AsText := S;
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
    lblSection.Caption := '[' + lvOrphaned.Selected.SubItems[1] + ']'
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

end.
