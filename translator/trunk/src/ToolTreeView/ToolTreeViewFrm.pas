unit ToolTreeViewFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, TntForms,
  Dialogs, ComCtrls, TntComCtrls, StdCtrls, TntStdCtrls, ExtCtrls,
  TntExtCtrls, TransIntf;

type
  TfrmToolTreeView = class(TTntForm)
    StatusBottom: TTntStatusBar;
    TntSplitter1: TTntSplitter;
    TntPanel5: TTntPanel;
    TntLabel3: TTntLabel;
    tvSections: TTntTreeView;
    nbViews: TNotebook;
    TntPanel1: TTntPanel;
    TntSplitter2: TTntSplitter;
    TntPanel2: TTntPanel;
    TntLabel1: TTntLabel;
    reOriginal: TTntRichEdit;
    TntPanel3: TTntPanel;
    TntPanel4: TTntPanel;
    TntLabel2: TTntLabel;
    reTranslation: TTntRichEdit;
    lvView: TTntListView;
    procedure reOriginalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tvSectionsChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure lvViewDblClick(Sender: TObject);
    procedure tvSectionsCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    { Private declarations }
    procedure BuildTree(const Items: ITranslationItems);
    procedure FillListView(Node: TTntTreeNode);
    procedure FindInTree(Data: Pointer);
  public
    { Public declarations }
    class function Edit(const Items: ITranslationItems): WordBool;
  end;

implementation

{$R *.dfm}

function trimCRLFRight(const S: WideString): WideString;
var i:integer;
begin
  Result := S;
  i := Length(Result);
  while (i >= 1) and (Result[i] in [WideChar(#10), WideChar(#13)]) do
    Dec(i);
  if i >= 0 then
    SetLength(Result, i);
end;

procedure TfrmToolTreeView.BuildTree(const Items: ITranslationItems);
var
  N: TTntTreeNode;
  i: integer;
  FLastSection: WideString;
  FoldSort: Integer;
begin
  tvSections.Items.BeginUpdate;
  FOldSort := Items.Sort;
  try
    Items.Sort := stIndex;
    tvSections.Items.Clear;
    reOriginal.Clear;
    reTranslation.Clear;
    FLastSection := #2;
    N := nil;
    for i := 0 to Items.Count - 1 do
    begin
      if (i = 0) or not WideSameText(FLastSection, Items[i].Section) then
      begin
        FLastSection := Items[i].Section;
        N := tvSections.Items.Add(nil, Items[i].Section);
      end;
      tvSections.Items.AddChildObject(N, Items[i].Name, Pointer(Items[i]));
    end;
  finally
    Items.Sort := FOldSort;
    tvSections.Items.EndUpdate;
  end;
  if tvSections.Items.Count > 0 then
  begin
    tvSections.Selected := tvSections.Items[0];
    tvSections.Selected.MakeVisible;
    tvSections.Selected.Expand(false);
  end;
end;

class function TfrmToolTreeView.Edit(const Items: ITranslationItems): WordBool;
var
  frm: TfrmToolTreeView;
  Dummy: boolean;
begin
  frm := self.Create(Application);
  try
    frm.BuildTree(Items);
    frm.ShowModal;
    frm.tvSectionsChanging(frm.tvSections, frm.tvSections.Selected, Dummy); // save last edit
    Result := true;
  finally
    frm.Free;
  end;
end;

procedure TfrmToolTreeView.reOriginalKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Key := 0;
end;

procedure TfrmToolTreeView.tvSectionsChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
var I: ITranslationItem;
begin
  if tvSections.Selected <> nil then // the previous selected node
  begin
    I := ITranslationItem(TTntTreeNode(tvSections.Selected).Data);
    if I <> nil then
    begin
      if reOriginal.Modified then
        I.Original := trimCRLFRight(reOriginal.Lines.Text);
      if reTranslation.Modified then
      begin
        I.Translation := trimCRLFRight(reTranslation.Lines.Text);
        I.Translated := I.Translation <> '';
        tvSections.Invalidate;
      end;
    end;
  end;
  if Node <> nil then // the newly selected node
  begin
    I := ITranslationItem(TTntTreeNode(Node).Data);
    if I <> nil then
    begin
      reOriginal.Enabled := true;
      reTranslation.Enabled := true;
      reOriginal.Lines.Text := I.Original;
      reTranslation.Lines.Text := I.Translation;
      nbViews.PageIndex := 0;
    end
    else
    begin
      reOriginal.Lines.Text := '';
      reTranslation.Lines.Text := '';
      reOriginal.Enabled := false;
      reTranslation.Enabled := false;
      FillListView(TTntTreeNode(Node));
      nbViews.PageIndex := 1;
    end;
  end;
  reOriginal.Modified := false;
  reTranslation.Modified := false;
end;

procedure TfrmToolTreeView.FillListView(Node: TTntTreeNode);
var
  N: TTntTreeNode;
begin
  lvView.Items.BeginUpdate;
  try
    lvView.Items.Clear;
    N := Node.getFirstChild;
    while N <> nil do
    begin
      with lvView.Items.Add do
      begin
        Caption := N.Text;
        Data := N.Data;
      end;
      N := N.getNextSibling;
    end;
  finally
    lvView.Items.EndUpdate;
  end;
  if lvView.Items.Count > 0 then
    lvView.Selected := lvView.Items[0];
end;

procedure TfrmToolTreeView.lvViewDblClick(Sender: TObject);
begin
  if lvView.Selected <> nil then
    FindInTree(lvView.Selected.Data);
end;

procedure TfrmToolTreeView.FindInTree(Data: Pointer);
var N: TTntTreeNode; Dummy:Boolean;
begin
  N := tvSections.Items.GetFirstNode;
  while N <> nil do
  begin
    if N.Data = Data then
    begin
      tvSectionsChanging(tvSections, N, Dummy);
      Exit;
    end;
    N := N.GetNext;
  end;
end;

procedure TfrmToolTreeView.tvSectionsCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  var DefaultDraw: Boolean);
var I: ITranslationItem;
begin
  if Node = nil then
    Exit;
  I := ITranslationItem(TTntTreeNode(Node).Data);
  if I <> nil then
  begin
    TTntTreeView(Sender).Canvas.Font.Style := TTntTreeView(Sender).Font.Style;
    if I.Translated then
      TTntTreeView(Sender).Canvas.Font.Style := [fsBold];
    if I.Modified then
      TTntTreeView(Sender).Canvas.Font.Style := TTntTreeView(Sender).Canvas.Font.Style + [fsItalic];
  end;
end;

end.

