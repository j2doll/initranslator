unit ToolKeyCheckFrm;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, TntForms, ComCtrls, TransIntf, TntComCtrls, ImgList, ActnList,
  TntActnList, StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls;

type
  TListViewInfo = class
    Column:TListColumn;
    Descending:boolean;
  end;

  TfrmToolKeyCheck = class(TTntForm)
    TntStatusBar1: TTntStatusBar;
    lvItems: TTntListView;
    ilSortArrows: TImageList;
    TntPanel1: TTntPanel;
    chkIgnoreEmpty: TTntCheckBox;
    TntButton1: TTntButton;
    alMain: TTntActionList;
    acUpdate: TTntAction;
    acEdit: TTntAction;
    acClose: TTntAction;
    procedure lvItemsResize(Sender: TObject);
    procedure lvItemsEnter(Sender: TObject);
    procedure lvItemsColumnClick(Sender: TObject; Column: TListColumn);
    procedure TntFormCreate(Sender: TObject);
    procedure TntFormDestroy(Sender: TObject);
    procedure lvItemsDblClick(Sender: TObject);
    procedure lvItemsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvItemsInsert(Sender: TObject; Item: TListItem);
    procedure acCloseExecute(Sender: TObject);
    procedure acUpdateExecute(Sender: TObject);
    procedure chkIgnoreEmptyClick(Sender: TObject);
    procedure acEditExecute(Sender: TObject);
  private
    { Private declarations }
    FAppServices:IApplicationServices;
    FListViewInfo:TListViewInfo;
    FItems: ITranslationItems;
    procedure LoadItems;
    procedure LoadSettings;
    procedure SaveSettings;
  public
    { Public declarations }
    class function Edit(const ApplicationServices:IApplicationServices; const Items: ITranslationItems): boolean;
  end;

implementation

uses
  CommonUtils, TntWindows, TntMenus, Math;

{$R *.DFM}
const
  cUpArrow = 4;
  cDnArrow = 5;

{ TfrmToolKeyCheck }

class function TfrmToolKeyCheck.Edit(const ApplicationServices:IApplicationServices; const Items: ITranslationItems): boolean;
var
  frm: TfrmToolKeyCheck;
  FAppHandle:Cardinal;
begin
  FAppHandle := Application.Handle;
  Application.Handle := ApplicationServices.AppHandle;
  frm := self.Create(Application);
  try
    frm.FItems := Items;
    frm.FAppServices := ApplicationServices;
    frm.LoadSettings;
    frm.acUpdate.Execute;
    frm.ShowModal;
    frm.SaveSettings;
    Result := true;
  finally
    frm.Free;
    Application.Handle := FAppHandle;
  end;
end;

procedure TfrmToolKeyCheck.LoadItems;
var
  i: integer;
  li: TTntListItem;
  aAccess, aAccel:WideString;

  function GetAccelerator(const S: WideString): WideString;
  begin
    Result := WideGetHotkey(S);
  end;

  function GetAccessKey(const S: WideString): WideString;
  var
    i: integer;
    aShortCut: TShortCut;
    tmp :WideString;
  begin
    Result := '';
    // sanity check
    if Pos(WideString('Ctrl'),S) +
      Pos(WideString('Shift'),S) + Pos(WideString('Alt'),S) +
      Pos(WideString('\t'),S) + Pos(WideString(#9),S) <= 0 then
        Exit;

    // trim off as much as possible
    tmp := S;
    i := Pos(WideChar(' '), tmp);
    while i > 0 do
    begin
      tmp := Copy(tmp, i + 1, MaxInt);
      i := Pos(WideChar(' '), tmp);
    end;
    i := Pos(WideString('\t'), tmp);
    while i > 0 do
    begin
      tmp := Copy(tmp, i + 1, MaxInt);
      i := Pos(WideString('\t'), tmp);
    end;

    i := Pos(WideChar(#9), tmp);
    while i > 0 do
    begin
      tmp := Copy(tmp, i + 1, MaxInt);
      i := Pos(WideChar(#9), tmp);
    end;

    // brute force (slow!)
    for i := 1 to Length(tmp) - 1 do // need at least 2 characters
    begin
      aShortCut := WideTextToShortCut(Copy(tmp, i, MaxInt));
      if aShortCut <> 0 then
      begin
        Result := WideShortCutToText(aShortCut);
        Exit;
      end;
    end;
    Result := '';
  end;
begin
  WaitCursor;
  if FItems = nil then Exit;
  lvItems.Items.BeginUpdate;
  try
    lvItems.Items.Clear;
    for i := 0 to FItems.Count - 1 do
    begin
      aAccess := GetAccessKey(FItems[i].Translation);
      aAccel := GetAccelerator(FItems[i].Translation);
      if not chkIgnoreEmpty.Checked or (aAccel <> '') or (aAccess <> '') then
      begin
        li := lvItems.Items.Add;
        li.Caption := FItems[i].Original;
        li.SubItems.Add(FItems[i].Translation);
        li.SubItems.Add(aAccel);
        li.SubItems.Add(aAccess);
        li.Data := Pointer(FItems[i]);
      end;
    end;
    FListViewInfo.Column := nil;
    lvItemsColumnClick(lvItems, lvItems.Columns[2]); 
  finally
    lvItems.Items.EndUpdate;
  end;
end;

procedure TfrmToolKeyCheck.lvItemsResize(Sender: TObject);
var i, W: integer;
begin
  W := lvItems.ClientWidth div lvItems.Columns.Count;
  for i := 0 to lvItems.Columns.Count - 1 do
    lvItems.Columns[i].Width := W;
end;

procedure TfrmToolKeyCheck.lvItemsEnter(Sender: TObject);
begin
  if (lvItems.Items.Count > 0) and (lvItems.Selected = nil) then
  begin
    lvItems.Selected := lvItems.Items[0];
    lvItems.Selected.Focused := true;
  end;
end;


function ListViewSort(lParam1, lParam2, lParamSort: Integer): Integer; stdcall;
var
  Item1:TTntListItem absolute lParam1;
  Item2:TTntListItem absolute lParam2;
  Info:TListVIewInfo absolute lParamSort;
  S1, S2:WIdeString;
begin
  if Info.Column.Index = 0 then
  begin
    S1 := Item1.Caption;
    S2 := Item2.Caption;
  end
  else
  begin
    S1 := Item1.SubItems[Info.Column.Index - 1];
    S2 := Item2.SubItems[Info.Column.Index - 1];
  end;
  Result := WideCompareText(S1, S2);
  if Result = 0 then
    Result := WideCompareStr(S1, S2);
  if Info.Descending then
    Result := -Result;
end;

procedure TfrmToolKeyCheck.lvItemsColumnClick(Sender: TObject;
  Column: TListColumn);
var i:integer;
begin
  if FListViewInfo.Column = Column then
    FListViewInfo.Descending := not FListViewInfo.Descending
  else
    FListViewInfo.Descending := false;
  FListViewInfo.Column := Column;
  lvItems.CustomSort(ListViewSort, integer(FListViewInfo));
  for i := 0 to lvItems.Columns.Count - 1 do
    lvItems.Columns[i].ImageIndex := -1;
  if FListViewInfo.Descending then
    Column.ImageIndex := cUpArrow
  else
    Column.ImageIndex := cDnArrow;
end;

procedure TfrmToolKeyCheck.TntFormCreate(Sender: TObject);
begin
  FListViewInfo := TListViewInfo.Create;
end;

procedure TfrmToolKeyCheck.TntFormDestroy(Sender: TObject);
begin
  FListViewInfo.Free;
end;

procedure TfrmToolKeyCheck.lvItemsDblClick(Sender: TObject);
var AItem:ITranslationItem;
begin
  if lvItems.Selected <> nil then
  AItem := ITranslationItem(lvItems.Selected.Data);
  if AItem <> nil then
    FAppServices.SelectedItem := AItem;
end;

procedure TfrmToolKeyCheck.lvItemsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
var AItem:ITranslationItem;
begin
  if Assigned(Item) and Assigned(Item.Data) then
  begin
    AItem := ITranslationItem(Item.Data);
    TntStatusBar1.Panels[0].Text := WideFormat('"%s", "%s", "%s", "%s"',
      [AItem.Section, AItem.Name, AItem.Original, AItem.Translation]);
  end
  else
    TntStatusBar1.Panels[0].Text := '';
end;

procedure TfrmToolKeyCheck.lvItemsInsert(Sender: TObject; Item: TListItem);
begin
  Item.ImageIndex := -1;
  Item.StateIndex := -1;
end;

procedure TfrmToolKeyCheck.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmToolKeyCheck.acUpdateExecute(Sender: TObject);
begin
  LoadItems;
end;

procedure TfrmToolKeyCheck.chkIgnoreEmptyClick(Sender: TObject);
begin
  acUpdate.Execute;
end;

procedure TfrmToolKeyCheck.LoadSettings;
begin
// TODO
end;

procedure TfrmToolKeyCheck.SaveSettings;
begin
// TODO
end;

procedure TfrmToolKeyCheck.acEditExecute(Sender: TObject);
begin
//
end;

end.

