unit ToolItemEditFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, TntForms, ExtCtrls, StdCtrls, ComCtrls, TntComCtrls, TransIntf;

type
  TfrmEditItem = class(TTntForm)
    reOriginal: TTntRichEdit;
    Panel1: TPanel;
    reTranslation: TTntRichEdit;
    procedure reTranslationKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TntFormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Edit(const AItem:ITranslationItem; APos:TPoint):boolean;
  end;


implementation

{$R *.DFM}

procedure TfrmEditItem.reTranslationKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Key := 0;
end;

class function TfrmEditItem.Edit(const AItem: ITranslationItem; APos:TPoint): boolean;
var
  frm: TfrmEditItem;
begin
  frm := Self.Create(Application);
  try
    frm.reOriginal.Text := AItem.Original;
    frm.reTranslation.Text := AItem.Translation;
    frm.reTranslation.SelectAll;
    if APos.X < 0 then
      frm.Left := (Screen.Width - frm.Width) div 2
    else
      frm.Left := APos.X;
    if APos.Y < 0 then
      frm.Top := (Screen.Height - frm.Height) div 2
    else
      frm.Top := APos.Y;
    Result := frm.ShowModal = mrOK;
    if Result then
    begin
      AItem.Original := frm.reOriginal.Text;
      AItem.Translation := frm.reTranslation.Text;
    end;
  finally
    frm.Free;
  end;
end;

procedure TfrmEditItem.TntFormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    ModalResult := mrOK;
  end
  else if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

end.