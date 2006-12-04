unit ToolPropertiesViewFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntForms, TransIntf, ComCtrls, TntComCtrls;

type
  TfrmToolPropertiesView = class(TTntForm)
    TntStatusBar1: TTntStatusBar;
    lvItems: TTntListView;
    procedure lvItemsData(Sender: TObject; Item: TListItem);
  private
    { Private declarations }
    FItems: ITranslationItems;
    procedure LoadItems(const Items: ITranslationItems);
    procedure RefreshView;
  public
    { Public declarations }
    class function Execute(const Items, Orphans: ITranslationItems; var SelectedITem: ITranslationItem): Boolean;
  end;

implementation

{$R *.DFM}

{ TfrmToolPropertiesView }

class function TfrmToolPropertiesView.Execute(const Items,
  Orphans: ITranslationItems; var SelectedITem: ITranslationItem): Boolean;
var frm: TfrmToolPropertiesView;
begin
  frm := self.Create(Application);
  try
    frm.LoadItems(Items);
    frm.ShowModal;
    Result := false; // no changes
  finally
    frm.Free;
  end;
end;

procedure TfrmToolPropertiesView.LoadItems(const Items: ITranslationItems);
begin
  FItems := Items;
  RefreshView;
end;

procedure TfrmToolPropertiesView.RefreshView;
begin
  if FItems <> nil then
    lvItems.Items.Count := FItems.Count
  else
    lvItems.Items.Count := 0;
  TntStatusBar1.Panels[0].Text := WideFormat(' %d item(s) in list',[lvItems.Items.Count]);
end;

procedure TfrmToolPropertiesView.lvItemsData(Sender: TObject;
  Item: TListItem);
begin
  if (FItems <> nil) and (Item.Index >= 0) and (Item.Index < FItems.Count) then
    with TTntListItem(Item) do
    begin
      Caption := IntToStr(FItems[Index].Index);
      SubItems.Add(FItems[Index].Section);
      SubItems.Add(FItems[Index].Name);
      SubItems.Add(FItems[Index].Original);
      SubItems.Add(FItems[Index].Translation);
      SubItems.Add(FItems[Index].OrigComments);
      SubItems.Add(FItems[Index].TransComments);
      SubItems.Add(FItems[Index].PreData);
      SubItems.Add(FItems[Index].PostData);
      SubItems.Add(FItems[Index].OrigQuote);
      SubItems.Add(FItems[Index].TransQuote);
      SubItems.Add(FItems[Index].PrivateStorage);
      SubItems.Add(FItems[Index].ClearOriginal);
      SubItems.Add(FItems[Index].ClearTranslation);
    end;
end;

end.

