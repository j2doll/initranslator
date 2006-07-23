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
    TntPanel1: TTntPanel;
    TntPanel2: TTntPanel;
    TntPanel3: TTntPanel;
    TntPanel4: TTntPanel;
    TntLabel1: TTntLabel;
    TntLabel2: TTntLabel;
    TntSplitter2: TTntSplitter;
    reOriginal: TTntRichEdit;
    TntPanel5: TTntPanel;
    TntLabel3: TTntLabel;
    tvSections: TTntTreeView;
    reTranslation: TTntRichEdit;
    procedure reOriginalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tvSectionsChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure tvSectionsChange(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
    procedure BuildTree(const Items: ITranslationItems);
  public
    { Public declarations }
    class function Edit(const Items: ITranslationItems): WordBool;
  end;

implementation

{$R *.dfm}

procedure TfrmToolTreeView.BuildTree(const Items: ITranslationItems);
var
  N: TTntTreeNode;
  i: integer;
  FLastSection: WideString;
  FoldSort:Integer;
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
  Dummy:boolean;
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
  if Node = nil then Exit;
  I := ITranslationItem(TTntTreeNode(Node).Data);
  if I <> nil then
  begin
    reOriginal.Enabled := true;
    reTranslation.Enabled := true;
    if reOriginal.Modified then
      I.Original := reOriginal.Lines.Text;
    if reTranslation.Modified then
      I.Translation := reTranslation.Lines.Text;
  end
  else
  begin
    reOriginal.Lines.Text := '';
    reTranslation.Lines.Text := '';
    reOriginal.Enabled := false;
    reTranslation.Enabled := false;
  end;
  reOriginal.Modified := false;
  reTranslation.Modified := false;
end;

procedure TfrmToolTreeView.tvSectionsChange(Sender: TObject;
  Node: TTreeNode);
var I: ITranslationItem;
begin
  if Node = nil then Exit;
  I := ITranslationItem(TTntTreeNode(Node).Data);
  if I <> nil then
  begin
    reOriginal.Enabled := true;
    reTranslation.Enabled := true;
    reOriginal.Lines.Text := I.Original;
    reTranslation.Lines.Text := I.Translation;
  end
  else
  begin
    reOriginal.Lines.Text := '';
    reTranslation.Lines.Text := '';
    reOriginal.Enabled := false;
    reTranslation.Enabled := false;
  end;
  reOriginal.Modified := false;
  reTranslation.Modified := false;
end;

end.

