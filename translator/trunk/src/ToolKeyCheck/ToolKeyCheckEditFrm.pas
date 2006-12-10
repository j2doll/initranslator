unit ToolKeyCheckEditFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TntForms, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls;

type
  TfrmToolKeyCheckEdit = class(TTntForm)
    TntLabel1: TTntLabel;
    reOriginal: TTntRichEdit;
    TntLabel2: TTntLabel;
    reTranslation: TTntRichEdit;
    btnOK: TTntButton;
    btnCancel: TTntButton;
    procedure reTranslationKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure reTranslationKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure reTranslationEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Edit(const Original:WideString; var Translation:WideString):boolean;
  end;

implementation

{$R *.DFM}

{ TfrmToolKeyCheckEdit }

class function TfrmToolKeyCheckEdit.Edit(const Original: WideString;
  var Translation: WideString): boolean;
var frm:TfrmToolKeyCheckEdit;
begin
  frm := self.Create(Application);
  try
    frm.reOriginal.Text := Original;
    frm.reTranslation.Text := Translation;
    Result := frm.ShowModal = mrOK;
    if Result then
      Translation := frm.reTranslation.Text;
  finally
    frm.Free;
  end;
end;

procedure TfrmToolKeyCheckEdit.reTranslationKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then
   Key := 0;
end;

procedure TfrmToolKeyCheckEdit.reTranslationKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then
   Key := 0;
end;

procedure TfrmToolKeyCheckEdit.reTranslationEnter(Sender: TObject);
begin
  reTranslation.SelectAll;
end;

end.