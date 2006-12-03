unit ToolListEditFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, TntForms, TntComCtrls, TntGrids, ComCtrls, Grids, TransIntf;
const
  WM_EDITITEM = WM_USER + 101;

type
  TfrmToolListEdit = class(TTntForm)
    sgItems: TTntDrawGrid;
    TntStatusBar1: TTntStatusBar;
    procedure TntFormResize(Sender: TObject);
    procedure sgItemsDblClick(Sender: TObject);
    procedure sgItemsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgItemsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
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

class function TfrmToolListEdit.Edit(
  const Items: ITranslationItems): boolean;
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
  if Items.Count = 0 then
    sgItems.RowCount := 2
  else
    sgItems.RowCount := Items.Count + 1;
  sgItems.FixedRows := 1;
end;

procedure TfrmToolListEdit.TntFormResize(Sender: TObject);
var W: integer;
begin
  W := sgItems.ClientWidth div 3;
  sgItems.ColWidths[0] := W;
  sgItems.ColWidths[1] := W;
  sgItems.ColWidths[2] := W; // sgItems.ClientWidth - W * 2;
end;

procedure TfrmToolListEdit.sgItemsDblClick(Sender: TObject);
begin
  EditItem;
end;

procedure TfrmToolListEdit.EditItem;
begin
  PostMessage(Handle, WM_EDITITEM, 0, 0);
end;

procedure TfrmToolListEdit.sgItemsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    EditItem;
  end;
end;

procedure TfrmToolListEdit.WmEditItem(var Msg: TMessage);
var R: TRect;
begin
  if (sgItems.Row >= sgItems.FixedRows) and (sgItems.Row < sgItems.RowCount - sgItems.FixedRows) then
  begin
    R := sgItems.CellRect(1, sgItems.Row + 1);
    if TfrmEditItem.Edit(FItems[sgItems.Row - 1], ClientToScreen(R.TopLeft)) then
      sgItems.Invalidate;
  end;
end;

procedure TfrmToolListEdit.sgItemsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  S: WideString;
  AItem:ITranslationItem;
begin
  AItem := nil;
  if ARow = 0 then // fixed col
  begin
    case ACol of
      0:
        S := 'Key';
      1:
        S := 'Original';
      2:
        S := 'Translation';
    end;
  end
  else if sgItems.Row < sgItems.RowCount - sgItems.FixedRows then
  begin
    AItem := FItems[ARow - 1];
    case ACol of
      0:
        S := AItem.Section + WideChar('.') + AItem.Name;
      1:
        S := AItem.Original;
      2:
        S := AItem.Translation;
    end;

  end;
  sgItems.Canvas.Font := sgItems.Font;
  if AItem <> nil then
  begin
    if AItem.Modified then
      sgItems.Canvas.Font.Style := [fsItalic];
    if not AItem.Translated then
      sgItems.Canvas.Font.Style := sgItems.Canvas.Font.Style + [fsBold];
  end;
  if gdSelected in State then
  begin
    sgItems.Canvas.Brush.Color := clHighlight;
    sgItems.Canvas.Font.Color := clHighlightText;
  end
  else if gdFixed in State then
  begin
    sgItems.Canvas.Brush.Color := clBtnFace;
    sgItems.Canvas.Font.COlor := clWindowText;
  end
  else
  begin
    sgItems.Canvas.Brush.Color := clWindow;
    sgItems.Canvas.Font.Color := clWindowText;
  end;
  InflateRect(Rect, -1, -1);
  sgItems.Canvas.FillRect(Rect);
  InflateRect(Rect, -2, 0);
  Tnt_DrawTextW(sgItems.Canvas.Handle, PWideCHar(S), Length(S), Rect, DT_SINGLELINE or DT_LEFT or DT_VCENTER);
end;

end.

