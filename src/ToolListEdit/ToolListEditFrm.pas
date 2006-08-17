unit ToolListEditFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, TntForms, TntComCtrls, TntGrids, ComCtrls, Grids, TransIntf;
const
  WM_EDITITEM = WM_USER + 101;

type
  TfrmToolListEdit = class(TTntForm)
    TntStatusBar1: TTntStatusBar;
    lvItems: TTntListView;
    procedure lvItemsResize(Sender: TObject);
    procedure lvItemsDblClick(Sender: TObject);
    procedure lvItemsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lvItemsData(Sender: TObject; Item: TListItem);
    procedure lvItemsAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure lvItemsEnter(Sender: TObject);
  private
    { Private declarations }
    FItems: ITranslationItems;
    procedure LoadItems(const Items: ITranslationItems);
    procedure EditItem;
    procedure WmEditItem(var Msg: TMessage); message WM_EDITITEM;
  public
    { Public declarations }
    class function Edit(const Items: ITranslationItems): boolean;
  end;

implementation

uses
  ToolItemEditFrm, TntWindows;

{$R *.DFM}

{ TfrmToolListEdit }

class function TfrmToolListEdit.Edit(const Items: ITranslationItems): boolean;
var
  frm: TfrmToolListEdit;
begin
  frm := self.Create(Application);
  try
    frm.LoadItems(Items);
    frm.ShowModal;
    Result := true;
  finally
    frm.Free;
  end;
end;

procedure TfrmToolListEdit.LoadItems(const Items: ITranslationItems);
begin
  FItems := Items;
  lvItems.Items.Count := FItems.Count;
  lvItems.Invalidate;
end;

procedure TfrmToolListEdit.EditItem;
begin
  PostMessage(Handle, WM_EDITITEM, 0, 0);
end;

procedure TfrmToolListEdit.WmEditItem(var Msg: TMessage);
var P: TPoint;
begin
  if (lvItems.Selected <> nil) then
  begin
    P := lvItems.Selected.GetPosition;
    // add a bit of offset
    Inc(P.Y, 19);
    if TfrmEditItem.Edit(FItems[lvItems.Selected.Index], lvItems.ClientToScreen(P)) then
      lvItems.Invalidate;
  end;
end;

procedure TfrmToolListEdit.lvItemsResize(Sender: TObject);
var W: integer;
begin
  W := lvItems.ClientWidth div 3;
  lvItems.Columns[0].Width := W;
  lvItems.Columns[1].Width := W;
  lvItems.Columns[2].Width := W;
end;

procedure TfrmToolListEdit.lvItemsDblClick(Sender: TObject);
begin
  EditItem;
end;

procedure TfrmToolListEdit.lvItemsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    EditItem;
  end;
end;

procedure TfrmToolListEdit.lvItemsData(Sender: TObject; Item: TListItem);
begin
  if (Item <> nil) and (Item.Index >= 0) then
  begin
    with FItems[Item.Index] do
    begin
      TTntListItem(Item).Caption := WideFormat('%s.%s', [Section, Name]);
      TTntListItem(Item).SubItems.Add(Original);
      TTntListItem(Item).SubItems.Add(Translation);
    end;
  end;
end;

procedure TfrmToolListEdit.lvItemsAdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
  if (Item <> nil) and (Item.Index >= 0) then
    with FItems[Item.Index] do
    begin
      if not Translated then
        Sender.Canvas.Font.Style := Sender.Canvas.Font.Style + [fsBold];
      if Modified then
        Sender.Canvas.Font.Style := Sender.Canvas.Font.Style + [fsItalic];
    end;
end;

procedure TfrmToolListEdit.lvItemsEnter(Sender: TObject);
begin
  if (lvItems.Items.Count > 0) and (lvItems.Selected = nil) then
  begin
    lvItems.Selected := lvItems.Items[0];
    lvItems.Selected.Focused := true;
  end;

end;

end.

