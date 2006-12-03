unit ColorsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseForm, StdCtrls, TntStdCtrls, AppOptions, ExtCtrls;

type
  TfrmColors = class(TfrmBase)
    btnCancel: TTntButton;
    btnOK: TTntButton;
    cbUntranslated: TColorBox;
    TntLabel1: TTntLabel;
    TntLabel2: TTntLabel;
    cbEvenRows: TColorBox;
    TntLabel3: TTntLabel;
    cbOddRows: TColorBox;
    TntLabel4: TTntLabel;
    cbUntranslatedFont: TColorBox;
    TntLabel5: TTntLabel;
    cbEvenRowFont: TColorBox;
    TntLabel6: TTntLabel;
    cbOddRowFont: TColorBox;
  private
    { Private declarations }
    procedure LoadOptions(Options: TAppOptions);
    procedure SaveOptions(Options: TAppOptions);
  public
    { Public declarations }
    class function Edit(Options:TAppOptions):boolean;
  end;


implementation

{$R *.dfm}

{ TfrmColors }

class function TfrmColors.Edit(Options: TAppOptions): boolean;
var
  frm: TfrmColors;
begin
  frm := self.Create(Application);
  try
    frm.LoadOptions(Options);
    Result := frm.ShowModal = mrOK;
    if Result then
      frm.SaveOptions(Options);
  finally
    frm.Free;
  end;
end;

procedure TfrmColors.LoadOptions(Options: TAppOptions);
begin
  cbUntranslated.Selected := Options.ColorUntranslated;
  cbUntranslatedFont.Selected := Options.ColorFontUntranslated;
  cbEvenRows.Selected := Options.ColorEvenRow;
  cbEvenRowFont.Selected := Options.ColorFontEvenRow;
  cbOddRows.Selected := Options.ColorOddRow;
  cbOddRowFont.Selected := Options.ColorFontOddRow;
end;

procedure TfrmColors.SaveOptions(Options: TAppOptions);
begin
  Options.ColorUntranslated := cbUntranslated.Selected;
  Options.ColorFontUntranslated := cbUntranslatedFont.Selected;
  Options.ColorEvenRow := cbEvenRows.Selected;
  Options.ColorFontEvenRow := cbEvenRowFont.Selected;
  Options.ColorOddRow := cbOddRows.Selected;
  Options.ColorFontOddRow := cbOddRowFont.Selected;
end;

end.
