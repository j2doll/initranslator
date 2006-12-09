unit ToolConsistencyFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, TntForms,
  Dialogs, TransIntf, TntWindows, TntClasses, TntMenus, StdCtrls, ComCtrls,
  TntStdCtrls, TntComCtrls, ActnList, Menus, TntActnList;

type
  TfrmToolConsistency = class(TTntForm)
    chkIgnoreAccelChar: TTntCheckBox;
    tvItems: TTntTreeView;
    btnClose: TTntButton;
    lblInfo: TTntLabel;
    btnUpdate: TTntButton;
    TntLabel1: TTntLabel;
    alMain: TTntActionList;
    acUpdate: TTntAction;
    acClose: TTntAction;
    acEdit: TTntAction;
    acUseThisTranslation: TTntAction;
    popItems: TTntPopupMenu;
    Usethistranslation1: TTntMenuItem;
    Edit1: TTntMenuItem;
    chkAutoAccelChar: TTntCheckBox;
    procedure chkIgnoreAccelCharClick(Sender: TObject);
    procedure tvItemsChange(Sender: TObject; Node: TTreeNode);
    procedure tvItemsEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure tvItemsEdited(Sender: TObject; Node: TTntTreeNode;
      var S: WideString);
    procedure acUseThisTranslationExecute(Sender: TObject);
    procedure acEditExecute(Sender: TObject);
    procedure acCloseExecute(Sender: TObject);
    procedure acUpdateExecute(Sender: TObject);
    procedure alMainUpdate(Action: TBasicAction; var Handled: Boolean);
  private
    { Private declarations }
    FItems: ITranslationItems;

    FSelectedItem: ITranslationItem;
    procedure BuildList(IgnoreAccelChar: boolean);
    procedure LoadSettings;
    procedure SaveSettings;

  public
    { Public declarations }
    class function Execute(const ApplicationServices: IApplicationServices;
      const Items, Orphans: ITranslationItems;
      var SelectedItem: ITranslationItem): boolean;
  end;

implementation
uses
  WideIniFiles, TntWideStrUtils, StrUtils;

{$R *.dfm}
type
  TTranslationItems = class
  private
    FOriginalItems: TTntStrings;
    FIgnoreAccelChar: boolean;
    function GetItems(Index: integer): TTntStrings;
    function GetCount: integer;
    function GetName(Index: integer): WideString;
    function GetRealItem(Index, SubIndex: integer): ITranslationItem;
  public
    constructor Create(IgnoreAccelChar: boolean);
    destructor Destroy; override;
    procedure Clear;
    procedure Add(const AItem: ITranslationItem);
    property Items[Index: integer]: TTntStrings read GetItems;
    property Name[Index: integer]: WideString read GetName;
    property RealItem[Index, SubIndex: integer]: ITranslationItem read GetRealItem;
    property Count: integer read GetCount;
  end;

{ TTranslationItems }

procedure TTranslationItems.Add(const AItem: ITranslationItem);
var
  AOriginal, ATranslation: WideString;
  SL: TTntStringlist;
  i: integer;
begin
  if FIgnoreAccelChar then
  begin
    AOriginal := WideStripHotkey(AItem.Original);
    ATranslation := WideStripHotkey(AItem.Translation);
  end
  else
  begin
    AOriginal := AItem.Original;
    ATranslation := AItem.Translation;
  end;
  i := FOriginalItems.IndexOf(AOriginal);
  if i < 0 then
    i := FOriginalItems.Add(AOriginal);
  if FOriginalItems.Objects[i] = nil then
  begin
    SL := TTntStringlist.Create;
    SL.Sorted := true;
    FOriginalItems.Objects[i] := SL;
  end
  else
    SL := TTntStringlist(FOriginalItems.Objects[i]);
  SL.AddObject(ATranslation, TObject(Pointer(AItem)));
end;

procedure TTranslationItems.Clear;
var i: integer;
begin
  for i := 0 to FOriginalItems.Count - 1 do
    TTntStringlist(FOriginalItems.Objects[i]).Free;
  FOriginalItems.Clear;
end;

constructor TTranslationItems.Create(IgnoreAccelChar: boolean);
begin
  inherited Create;
  FOriginalItems := TTntStringlist.Create;
  TTntStringlist(FOriginalItems).Sorted := true;
  FIgnoreAccelChar := IgnoreAccelChar;
end;

destructor TTranslationItems.Destroy;
begin
  Clear;
  FreeAndNil(FOriginalItems);
  inherited;
end;

function TTranslationItems.GetCount: integer;
begin
  Result := FOriginalItems.Count;
end;

function TTranslationItems.GetItems(Index: integer): TTntStrings;
begin
  Result := TTntStrings(FOriginalItems.Objects[Index]);
end;


function TTranslationItems.GetName(Index: integer): WideString;
begin
  Result := FOriginalItems[Index];
end;

function TTranslationItems.GetRealItem(Index, SubIndex: integer): ITranslationItem;
begin
  Result := ITranslationItem(Pointer(TTntStrings(FOriginalItems.Objects[Index]).Objects[SubIndex]));
end;

{ TfrmToolConsistency }

procedure TfrmToolConsistency.chkIgnoreAccelCharClick(Sender: TObject);
begin
  BuildList(chkIgnoreAccelChar.Checked);
end;

procedure TfrmToolConsistency.BuildList(IgnoreAccelChar: boolean);
var
  i, j: integer;
  N: TTntTreeNode;
  AItem: ITranslationItem;
  FTItems: TTranslationItems;
begin
  tvItems.Items.Clear;
  FTItems := TTranslationItems.Create(IgnoreAccelChar);
  try
    // first build a list of original items with translations as subitems
    // each original item only appears once and each subitem translation
    // only appear once (because the lists are sorted and we ignore duplicates)
    for i := 0 to FItems.Count - 1 do
      FTItems.Add(FItems[i]);
    // next, build a tree of all items that have more than 1 unique translation
    // since this indicates that the translations are not consistent for the specific original item
    for i := 0 to FTItems.Count - 1 do
      if FTItems.Items[i].Count > 1 then
      begin
        N := tvItems.Items.Add(nil, FTItems.Name[i]);
        for j := 0 to FTItems.Items[i].Count - 1 do
        begin
          AItem := FTItems.RealItem[i, j];
          tvItems.Items.AddChildObject(N, AItem.Translation, Pointer(AItem));
        end;
      end;
    if tvItems.Items.Count = 0 then
    begin
      // no items in tree -> translation is consistent
      tvItems.ShowRoot := false;
      tvItems.Items.Add(nil, 'Congratulations! - No inconsistent items found!');
    end
    else
      tvItems.ShowRoot := true;
    tvItems.FullExpand;
    tvItems.Selected := tvItems.Items.GetFirstNode;
    tvItems.Selected.MakeVisible;
  finally
    FreeAndNil(FTItems);
  end;
end;

class function TfrmToolConsistency.Execute(const ApplicationServices: IApplicationServices; const Items, Orphans: ITranslationItems; var SelectedItem: ITranslationItem): boolean;
var
  frm: TfrmToolConsistency;
  FAppHandle:Cardinal;
begin
  FAppHandle := Application.Handle;
  Application.Handle := ApplicationServices.AppHandle;
  frm := self.Create(Application);
  try
    frm.FItems := Items;
    frm.FSelectedItem := SelectedItem;
    frm.LoadSettings;
    frm.acUpdate.Execute;
    frm.ShowModal;
    SelectedItem := frm.FSelectedItem;
    frm.SaveSettings;
    Result := true;
  finally
    frm.Free;
    Application.Handle := FAppHandle;
  end;
end;

procedure TfrmToolConsistency.LoadSettings;
begin
  with TWideMemIniFile.Create(ChangeFileExt(GetModuleName(HInstance), '.ini')) do
  try
    chkIgnoreAccelChar.Checked := ReadBool('Settings', 'IgnoreAccelChar', chkIgnoreAccelChar.Checked);
    chkAutoAccelChar.Checked := ReadBool('Settings', 'InsertAccelChar', chkAutoAccelChar.Checked);
  finally
    Free;
  end;
end;


procedure TfrmToolConsistency.SaveSettings;
begin
  with TWideMemIniFile.Create(ChangeFileExt(GetModuleName(HInstance), '.ini')) do
  try
    WriteBool('Settings', 'IgnoreAccelChar', chkIgnoreAccelChar.Checked);
    WriteBool('Settings', 'InsertAccelChar', chkAutoAccelChar.Checked);
    UpdateFile;
  finally
    Free;
  end;
end;

procedure TfrmToolConsistency.tvItemsChange(Sender: TObject;
  Node: TTreeNode);
begin
  if Assigned(Node) and Assigned(Node.Data) then
  begin
    FSelectedItem := ITranslationItem(Node.Data);
    lblInfo.Caption := WideFormat('(%s.%s)', [FSelectedItem.Section, FSelectedItem.Name]);
  end
  else
    lblInfo.Caption := '';

  alMain.UpdateAction(nil);
end;

procedure TfrmToolConsistency.tvItemsEditing(Sender: TObject;
  Node: TTreeNode; var AllowEdit: Boolean);
begin
  AllowEdit := Assigned(Node) and Assigned(Node.Data);
end;

procedure TfrmToolConsistency.tvItemsEdited(Sender: TObject;
  Node: TTntTreeNode; var S: WideString);
  function DoAutoAccelChar(var S:WideString):WideString;
  begin
    Result := S;
    if chkAutoAccelChar.Checked and AnsiContainsText(FSelectedItem.Original, '&')
      and not AnsiContainsText(S, '&') then
        Result := '&' + S;
    S := Result;
  end;
begin
  FSelectedItem := ITranslationItem(Node.Data);
  if FSelectedItem <> nil then
    FSelectedItem.Translation := DoAutoAccelChar(S);
end;

procedure TfrmToolConsistency.acUseThisTranslationExecute(Sender: TObject);
var
  N: TTntTreeNode;
  Item1, Item2: ITranslationItem;
begin
  if Assigned(tvItems.Selected) and Assigned(tvItems.Selected.Data) then
  begin
    N := tvItems.Selected;
    Item1 := ITranslationItem(tvItems.Selected.Data);

    N := N.getPrevSibling;
    while N <> nil do
    begin
      Caption := 'N.getPrevSibling';
      Item2 := ITranslationItem(N.Data);
      Item2.Translation := Item1.Translation;
      Item2.Translated := Item2.Translation <> '';
      N.Text := Item2.Translation;
      N := N.getPrevSibling;
    end;

    N := tvItems.Selected;
    Item1 := ITranslationItem(tvItems.Selected.Data);
    N := N.getNextSibling;
    while N <> nil do
    begin
      Caption := 'N.getNextSibling';
      Item2 := ITranslationItem(N.Data);
      Item2.Translation := Item1.Translation;
      Item2.Translated := Item2.Translation <> '';
      N.Text := Item2.Translation;
      N := N.getNextSibling;
    end;
  end;
end;

procedure TfrmToolConsistency.acEditExecute(Sender: TObject);
begin
  if Assigned(tvItems.Selected) and Assigned(tvItems.Selected.Data) then
    tvItems.Selected.EditText;
end;

procedure TfrmToolConsistency.acCloseExecute(Sender: TObject);
begin
  if tvItems.IsEditing then
    tvItems.Selected.EndEdit(true)
  else
    Close;
end;

procedure TfrmToolConsistency.acUpdateExecute(Sender: TObject);
begin
  BuildList(chkIgnoreAccelChar.Checked);
end;

procedure TfrmToolConsistency.alMainUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  acUseThisTranslation.Enabled := Assigned(tvItems.Selected) and Assigned(tvItems.Selected.Data);
  acEdit.Enabled := acUseThisTranslation.Enabled;
end;

end.

