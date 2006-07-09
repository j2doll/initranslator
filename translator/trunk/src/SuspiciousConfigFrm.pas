unit SuspiciousConfigFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, BaseForm, StdCtrls, TntStdCtrls, ComCtrls, TntComCtrls, AppOptions,
  ExtCtrls, TntExtCtrls;

type
  TfrmConfigSuspicious = class(TfrmBase)
    chkLeading: TTntCheckBox;
    chkTrailing: TTntCheckBox;
    chkEndControl: TTntCheckBox;
    chkIdentical: TTntCheckBox;
    chkEmptyTranslation: TTntCheckBox;
    TntLabel1: TTntLabel;
    TntLabel2: TTntLabel;
    btnOK: TTntButton;
    btnCancel: TTntButton;
    reItems: TTntRichEdit;
    TntBevel1: TTntBevel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadOptions(AppOptions: TAppOptions);
    procedure SaveOptions(AppOptions: TAppOptions);
    class function Edit(AppOptions: TAppOptions): boolean;
  end;

implementation

{$R *.dfm}

{ TfrmConfigSuspicious }

class function TfrmConfigSuspicious.Edit(AppOptions: TAppOptions): boolean;
var
  frm: TfrmConfigSuspicious;
begin
  frm := self.Create(Application);
  try
    frm.LoadOptions(AppOptions);
    Result := frm.ShowModal = mrOK;
    if Result then
      frm.SaveOptions(AppOptions);
  finally
    frm.Free;
  end;
end;

procedure TfrmConfigSuspicious.LoadOptions(AppOptions: TAppOptions);
begin
  chkLeading.Checked := AppOptions.MisMatchLeadingSpaces;
  chkTrailing.Checked := AppOptions.MisMatchTrailingSpaces;
  chkEndControl.Checked := AppOptions.MisMatchEndControl;
  chkIdentical.Checked := AppOptions.MisMatchIdentical;
  chkEmptyTranslation.Checked := AppOptions.MisMatchEmptyTranslation;
  reItems.Lines.CommaText := AppOptions.MisMatchItems;
end;

procedure TfrmConfigSuspicious.SaveOptions(AppOptions: TAppOptions);
begin
  AppOptions.MisMatchLeadingSpaces := chkLeading.Checked;
  AppOptions.MisMatchTrailingSpaces := chkTrailing.Checked;
  AppOptions.MisMatchEndControl := chkEndControl.Checked;
  AppOptions.MisMatchIdentical := chkIdentical.Checked;
  AppOptions.MisMatchEmptyTranslation := chkEmptyTranslation.Checked;
  AppOptions.MisMatchItems := reItems.Lines.CommaText;
end;

end.
