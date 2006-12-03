unit ExtToolsFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ActnList, ImgList,
  Menus,
  BaseForm, AppOptions, ShortCutEdit,
  TntMenus, TntButtons, TntStdCtrls, TntDialogs, TB2Item, TntActnList,
  TBX;

type
  TTestToolItemClickEvent = procedure(Sender: TObject; ToolItem: TToolItem) of object;
  TfrmTools = class(TfrmBase)
    Label1: TTntLabel;
    lbContents: TListBox;
    btnOK: TTntButton;
    btnCancel: TTntButton;
    btnAdd: TTntButton;
    btnDelete: TTntButton;
    btnUp: TTntButton;
    btnDown: TTntButton;
    odCommand: TTntOpenDialog;
    popArguments: TTBXPopupMenu;
    OriginalLine1: TTBXItem;
    OriginalText1: TTBXItem;
    OriginalPath1: TTBXItem;
    OriginalDirectory1: TTBXItem;
    OriginalName1: TTBXItem;
    OriginalExtension1: TTBXItem;
    N1: TTBXSeparatorItem;
    ranslationLine1: TTBXItem;
    ranslationText1: TTBXItem;
    ranslationPath1: TTBXItem;
    ranslationDirectory1: TTBXItem;
    ranslationName1: TTBXItem;
    ranslationExtension1: TTBXItem;
    N2: TTBXSeparatorItem;
    DictionaryPath1: TTBXItem;
    DictionaryDirectory1: TTBXItem;
    DictionaryName1: TTBXItem;
    DictionaryExtension1: TTBXItem;
    popInitialDir: TTBXPopupMenu;
    OriginalPath2: TTBXItem;
    ranslationPath2: TTBXItem;
    DictionaryPath2: TTBXItem;
    ApplicationPath1: TTBXItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    TBXItem1: TTBXItem;
    TBXItem2: TTBXItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    TBXItem3: TTBXItem;
    TBXItem4: TTBXItem;
    pnlEditTool: TPanel;
    Label2: TTntLabel;
    Label3: TTntLabel;
    Label4: TTntLabel;
    Label5: TTntLabel;
    edTitle: TTntEdit;
    edCommand: TTntEdit;
    edArguments: TTntEdit;
    edInitialDir: TTntEdit;
    btnCommand: TTntButton;
    btnArguments: TTntBitBtn;
    btnInitDir: TTntBitBtn;
    chkPrompt: TTntCheckBox;
    chkWait: TTntCheckBox;
    chkShell: TCheckBox;
    btnTest: TTntButton;
    TBItem1: TTBItem;
    lblShortCut: TTntLabel;
    btnClear: TTntButton;
    alTools: TTntActionList;
    acAdd: TTntAction;
    acDelete: TTntAction;
    acMoveUp: TTntAction;
    acMoveDown: TTntAction;
    acCommand: TTntAction;
    acClear: TTntAction;
    acUseShellexecute: TTntAction;
    acPrompt: TTntAction;
    acWait: TTntAction;
    acTest: TTntAction;
    acArgs: TTntAction;
    acDir: TTntAction;
    ilTools: TImageList;
    popContents: TTBXPopupMenu;
    TBXItem5: TTBXItem;
    TBXItem6: TTBXItem;
    TBXSeparatorItem3: TTBXSeparatorItem;
    TBXItem7: TTBXItem;
    TBXItem8: TTBXItem;
    Bevel1: TBevel;
    procedure ArgumentsClick(Sender: TObject);
    procedure InitialDirClick(Sender: TObject);
    procedure lbContentsClick(Sender: TObject);
    procedure edTitleChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure chkShellClick(Sender: TObject);
    function lbContentsDataFind(Control: TWinControl;
      FindString: string): Integer;
    procedure lbContentsData(Control: TWinControl; Index: Integer;
      var Data: string);
    procedure acAddExecute(Sender: TObject);
    procedure acDeleteExecute(Sender: TObject);
    procedure acMoveUpExecute(Sender: TObject);
    procedure acMoveDownExecute(Sender: TObject);
    procedure acCommandExecute(Sender: TObject);
    procedure acClearExecute(Sender: TObject);
    procedure acUseShellexecuteExecute(Sender: TObject);
    procedure acPromptExecute(Sender: TObject);
    procedure acWaitExecute(Sender: TObject);
    procedure acTestExecute(Sender: TObject);
    procedure acArgsExecute(Sender: TObject);
    procedure acDirExecute(Sender: TObject);
    procedure alToolsUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    FLastItemIndex: integer;
    FTools: TToolItems;
    FOnTestClick: TTestToolItemClickEvent;
    FMainActionList: TactionList;
    edShortCut: TShortCutEdit;
    procedure SaveCurrentTool;
    procedure LoadCurrentTool;
    function NewToolTitle: string;
  public
    { Public declarations }
    class function Edit(Options: TAppOptions; MainActionList: TActionList; TestClickEvent: TTestToolItemClickEvent): boolean;
    procedure LoadOptions(Options: TAppOptions);
    procedure SaveOptions(Options: TAppOptions);
    procedure ClearToolList;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property OnTestClick: TTestToolItemClickEvent read FOnTestClick write FOnTestClick;
  end;

implementation
uses
  TntClasses, AppUtils, AppConsts;

{$R *.dfm}

{ TfrmTools }

procedure TfrmTools.ClearToolList;
begin
  lbContents.Count := 0;
  FLastItemIndex := -1;
end;

destructor TfrmTools.Destroy;
begin
  ClearToolList;
  FTools.Free;
  inherited;
end;

class function TfrmTools.Edit(Options: TAppOptions; MainActionList: TActionList; TestClickEvent: TTestToolItemClickEvent): boolean;
var
  frmTools: TfrmTools;
begin
  frmTools := Self.Create(Application);
  try
    // frmTools.Font := Application.MainForm.Font;
    frmTools.OnTestClick := TestClickEvent;
    frmTools.FMainActionList := MainActionList;
    frmTools.LoadOptions(Options);
    frmTools.lbContents.ItemIndex := 0;
    frmTools.LoadCurrentTool;
    Result := frmTools.ShowModal = mrOK;
    if Result then
      frmTools.SaveOptions(Options);
  finally
    frmTools.Free;
  end;
end;

procedure TfrmTools.LoadOptions(Options: TAppOptions);
begin
  ClearToolList;
  FTools.Assign(Options.Tools);
  lbContents.Count := FTools.Count;
  lbContents.ItemIndex := 0;
end;

procedure TfrmTools.SaveOptions(Options: TAppOptions);
begin
  SaveCurrentTool;
  Options.Tools.Assign(FTools);
end;

procedure TfrmTools.ArgumentsClick(Sender: TObject);
begin
  edArguments.SelText := cArgsMacros[TMenuItem(Sender).Tag];
end;

procedure TfrmTools.InitialDirClick(Sender: TObject);
begin
  edInitialDir.SelText := cDirMacros[TMenuItem(Sender).Tag];
end;

procedure TfrmTools.lbContentsClick(Sender: TObject);
begin
  SaveCurrentTool;
  LoadCurrentTool;
  FLastItemIndex := lbContents.ItemIndex;
end;

procedure TfrmTools.LoadCurrentTool;
var
  ATool: TToolItem;
  I: integer;
begin
  I := lbContents.ItemIndex;
  if (I >= 0) and (I < FTools.Count) then
  begin
    ATool := FTools[I];
    edTitle.Text := ATool.Title;
    edCommand.Text := ATool.Command;
    edArguments.Text := ATool.Arguments;
    edInitialDir.Text := ATool.InitialDirectory;
//    chkCapture.Checked := ATool.CaptureOutput;
    chkPrompt.Checked := ATool.PromptForArguments;
    chkShell.Checked := ATool.UseShellExecute;
    chkWait.Checked := ATool.WaitForCompletion;
    edShortCut.ShortCut := ATool.ShortCut;
  end
  else
  begin
    edTitle.Text := '';
    edCommand.Text := '';
    edArguments.Text := '';
    edInitialDir.Text := '';
//    chkCapture.Checked := false;
    chkPrompt.Checked := false;
    chkWait.Checked := false;
    chkShell.Checked := false;
    edShortCut.ShortCut := 0;
  end;
  FLastItemIndex := I;
end;

procedure TfrmTools.SaveCurrentTool;
var ATool: TToolItem;
begin
  if (FLastItemIndex >= 0) and (FLastItemIndex < FTools.Count) then
  begin
    ATool := FTools[FLastItemIndex];
    ATool.Title := edTitle.Text;
    ATool.Command := edCommand.Text;
    ATool.Arguments := edArguments.Text;
    ATool.InitialDirectory := edInitialDir.Text;
//    ATool.CaptureOutput := chkCapture.Checked;
    ATool.PromptForArguments := chkPrompt.Checked;
    ATool.WaitForCompletion := chkWait.Checked;
    ATool.UseShellExecute := chkShell.Checked;
    ATool.ShortCut := edShortCut.ShortCut;
  end;
end;

constructor TfrmTools.Create(AOwner: TComponent);
begin
  inherited;
  FLastItemIndex := -1;
  FTools := TToolItems.Create;

  edShortCut := TShortCutEdit.Create(Self);
  edShortCut.Parent := pnlEditTool;
  edShortCut.Left := 104;
  edShortCut.Top := 120;
  edShortCut.Width := 217;
  edShortCut.Anchors := [akLeft, akTop, akRight];
  edShortCut.TabOrder := 7;
  edShortCut.BevelInner := bvNone;
  edShortCut.BevelOuter := bvRaised;
  edShortCut.BevelKind := bkFlat;
  edShortCut.BorderStyle := bsNone;
  lblShortCut.FocusControl := edShortCut;
end;

function TfrmTools.NewToolTitle: string;
var
  i: integer;
  S: string;
begin
  i := 1;
  S := Translate(Application.MainForm.ClassName, SNewToolNameFmt);
  Result := Format(S, [i]);
  while FTools.IndexOf(Result) >= 0 do
  begin
    Inc(i);
    Result := Format(S, [i]);
  end;
end;

procedure TfrmTools.edTitleChange(Sender: TObject);
begin
  with lbContents do
    if (ItemIndex >= 0) and (ItemIndex < FTools.Count) then
    begin
      FTools[ItemIndex].Title := edTitle.Text;
      Invalidate;
    end;
end;

procedure TfrmTools.btnOKClick(Sender: TObject);
begin
  FLastItemIndex := lbContents.ItemIndex;
  SaveCurrentTool;
end;

procedure TfrmTools.chkShellClick(Sender: TObject);
begin
  chkWait.Enabled := not chkShell.Checked;
end;

function TfrmTools.lbContentsDataFind(Control: TWinControl;
  FindString: string): Integer;
begin
  Result := FTools.IndexOf(FindString);
end;

procedure TfrmTools.lbContentsData(Control: TWinControl; Index: Integer;
  var Data: string);
var Action: TCustomAction;
begin
  Data := FTools[Index].Title;
  Action := FindActionShortCut(FMainActionList, FTools[Index].ShortCut);
  if Action <> nil then
    Data := '!>  ' + Data + '  <!'; // ' (' + Action.Caption + ')';
end;

procedure TfrmTools.acAddExecute(Sender: TObject);
var ATool: TToolItem;
begin
  SaveCurrentTool;
  ATool := FTools.Add;
  ATool.Title := NewToolTitle;
  lbContents.Count := FTools.Count;
  lbContents.ItemIndex := FTools.Count - 1;
  LoadCurrentTool;
  if edTitle.CanFocus then
    edTitle.SetFocus;
end;

procedure TfrmTools.acDeleteExecute(Sender: TObject);
var i: integer;
begin
  with lbContents do
  begin
    if (ItemIndex >= 0) and (ItemIndex < FTools.Count) then
    begin
      i := ItemIndex;
      FTools.Delete(i);
      lbContents.Count := FTools.Count;
      ItemIndex := i;
      if ItemIndex < 0 then
        ItemIndex := i - 1;
      LoadCurrentTool;
    end;
  end;
end;

procedure TfrmTools.acMoveUpExecute(Sender: TObject);
var i: integer;
begin
  SaveCurrentTool;
  with lbContents do
  begin
    i := ItemIndex;
    if i > 0 then
    begin
      FTools.Exchange(i, i - 1);
      FLastItemIndex := -1;
      ItemIndex := i - 1;
      Invalidate;
    end;
  end;
end;

procedure TfrmTools.acMoveDownExecute(Sender: TObject);
var i: integer;
begin
  SaveCurrentTool;
  with lbContents do
  begin
    i := ItemIndex;
    if i < FTools.Count - 1 then
    begin
      FTools.Exchange(i, i + 1);
      FLastItemIndex := -1;
      ItemIndex := i + 1;
      Invalidate;
    end;
  end;
end;

procedure TfrmTools.acCommandExecute(Sender: TObject);
begin
  odCommand.Filename := edCommand.Text;
  if odCommand.Execute then
    edCommand.Text := odCommand.Filename;
end;

procedure TfrmTools.acClearExecute(Sender: TObject);
begin
  edShortCut.ShortCut := 0;
end;

procedure TfrmTools.acUseShellexecuteExecute(Sender: TObject);
begin
  acUseShellexecute.Checked := not acUseShellexecute.Checked;
end;

procedure TfrmTools.acPromptExecute(Sender: TObject);
begin
  acPrompt.Checked := not acPrompt.Checked;
end;

procedure TfrmTools.acWaitExecute(Sender: TObject);
begin
  acWait.Checked := not acWait.Checked;
end;

procedure TfrmTools.acTestExecute(Sender: TObject);
begin
  with lbContents do
    if (ItemIndex >= 0) and (ItemIndex < FTools.Count) and Assigned(FOnTestClick) then
    begin
      SaveCurrentTool;
      FOnTestClick(btnTest, FTools[ItemIndex]);
    end;
end;

procedure TfrmTools.acArgsExecute(Sender: TObject);
var P: TPoint;
begin
  P := btnArguments.ClientOrigin;
  Inc(P.X, btnArguments.Width);
  popArguments.Popup(P.X, P.Y);
end;

procedure TfrmTools.acDirExecute(Sender: TObject);
var P: TPoint;
begin
  P := btnInitDir.ClientOrigin;
  Inc(P.X, btnInitDir.Width);
  popInitialDir.Popup(P.X, P.Y);
end;

procedure TfrmTools.alToolsUpdate(Action: TBasicAction;
  var Handled: Boolean);

procedure PropagateEnabled(AWinControl: TWinControl; Enabled: boolean);
  var i: integer;
  begin
    if AWinControl.Tag <> -1 then // leave these alone
      AWinControl.Enabled := Enabled;
    for i := 0 to AWinControl.ControlCount - 1 do
    begin
      if AWinControl.Controls[i] is TWinControl then
        PropagateEnabled(TWinControl(AWinControl.Controls[i]), Enabled);
    end;
  end;
begin
  acDelete.Enabled := (lbContents.ItemIndex >= 0) and (lbContents.ItemIndex < FTools.Count);
  acMoveUp.Enabled := lbContents.ItemIndex > 0;
  acMoveDown.Enabled := lbContents.ItemIndex < FTools.Count - 1;
  acTest.Enabled := btnDelete.Enabled and Assigned(OnTestClick);
  acClear.Enabled := edShortCut.ShortCut <> 0;

  PropagateEnabled(pnlEditTool, acDelete.Enabled);
end;

end.
