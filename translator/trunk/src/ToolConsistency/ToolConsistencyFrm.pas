unit ToolConsistencyFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, TntForms,
  Dialogs, TntClasses, TransIntf, TntMenus, StdCtrls, ComCtrls,
  TntStdCtrls, TntComCtrls;

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

  TfrmToolConsistency = class(TTntForm)
    chkIgnoreAccelChar: TTntCheckBox;
    tvItems: TTntTreeView;
    btnClose: TTntButton;
    lblInfo: TTntLabel;
    btnUpdate: TTntButton;
    TntLabel1: TTntLabel;
    procedure chkIgnoreAccelCharClick(Sender: TObject);
    procedure tvItemsChange(Sender: TObject; Node: TTreeNode);
    procedure btnCloseClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
  private
    { Private declarations }
    FItems: ITranslationItems;
    FTItems: TTranslationItems;
    procedure BuildList(IgnoreAccelChar: boolean);
    procedure LoadSettings;
    procedure SaveSettings;

  public
    { Public declarations }
    class function Execute(const ApplicationServices: IApplicationServices; const Items, Orphans: ITranslationItems): boolean;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

{ TfrmToolConsistency }

procedure TfrmToolConsistency.BuildList(IgnoreAccelChar: boolean);
var
  i, j: integer;
  N: TTntTreeNode;
begin
  FreeAndNil(FTItems);
  tvItems.Items.Clear;
  FTItems := TTranslationItems.Create(IgnoreAccelChar);
  for i := 0 to FItems.Count - 1 do
    FTItems.Add(FItems[i]);
  for i := 0 to FTItems.Count - 1 do
    if FTItems.Items[i].Count > 1 then
    begin
      N := tvItems.Items.Add(nil, FTItems.Name[i]);
      for j := 0 to FTItems.Items[i].Count - 1 do
        tvItems.Items.AddChildObject(N, FTItems.Items[i].Strings[j], Pointer(FTItems.RealItem[i, j]));
    end;
  if tvItems.Items.Count = 0 then
  begin
    tvItems.ShowRoot := false;
    tvItems.Items.Add(nil, 'Congratulations! - No inconsistent items found!');
  end
  else
    tvItems.ShowRoot := true;
  tvItems.FullExpand;
  tvItems.Selected := tvItems.Items.GetFirstNode;
  tvItems.Selected.MakeVisible;
end;

class function TfrmToolConsistency.Execute(const ApplicationServices: IApplicationServices; const Items, Orphans: ITranslationItems): boolean;
var frm: TfrmToolConsistency;
begin
  frm := self.Create(Application);
  try
    frm.FItems := Items;
    frm.LoadSettings;
    frm.btnUpdate.Click;
    frm.ShowModal;
    frm.SaveSettings;
    Result := true;
  finally
    frm.Free;
  end;
end;

destructor TfrmToolConsistency.Destroy;
begin
  FreeAndNil(FTItems);
  inherited;
end;

procedure TfrmToolConsistency.LoadSettings;
begin
// TODO
end;

procedure TfrmToolConsistency.SaveSettings;
begin
// TODO
end;

procedure TfrmToolConsistency.tvItemsChange(Sender: TObject;
  Node: TTreeNode);
var AItem:ITranslationItem;
begin
  if Assigned(Node) and Assigned(Node.Data) then
  begin
    AItem := ITranslationItem(Node.Data);
    lblInfo.Caption := WideFormat('(%s.%s)',[AItem.Section, AItem.Name]);
  end
  else
    lblInfo.Caption := '';
end;

procedure TfrmToolConsistency.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmToolConsistency.btnUpdateClick(Sender: TObject);
begin
  BuildList(chkIgnoreAccelChar.Checked);
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

procedure TfrmToolConsistency.chkIgnoreAccelCharClick(Sender: TObject);
begin
  BuildList(chkIgnoreAccelChar.Checked);
end;

function TTranslationItems.GetName(Index: integer): WideString;
begin
  Result := FOriginalItems[Index];
end;

function TTranslationItems.GetRealItem(Index, SubIndex: integer): ITranslationItem;
begin
  Result := ITranslationItem(Pointer(TTntStrings(FOriginalItems.Objects[Index]).Objects[SubIndex]));
end;

end.

