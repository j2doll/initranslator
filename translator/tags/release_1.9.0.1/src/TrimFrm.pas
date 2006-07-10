unit TrimFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, BaseForm, StdCtrls, TntStdCtrls, AppOptions;

type
  TfrmTrim = class(TfrmBase)
    TntLabel1: TTntLabel;
    edTrimWhat: TTntEdit;
    TntLabel2: TTntLabel;
    cbTrimWhere: TTntComboBox;
    TntLabel3: TTntLabel;
    cbTrimHow: TTntComboBox;
    chkTrimWhitespace: TTntCheckBox;
    btnOK: TTntButton;
    btnCancel: TTntButton;
  private
    { Private declarations }
  public
    { Public declarations }
    class function Edit(Options: TAppOptions): boolean;
    procedure LoadOptions(Options: TAppOptions);
    procedure SaveOptions(Options: TAppOptions);
  end;

implementation

{$R *.dfm}

{ TfrmTrim }

class function TfrmTrim.Edit(Options: TAppOptions): boolean;
var
  frmTrim: TfrmTrim;
begin
  frmTrim := self.Create(Application);
  try
    // frmTrim.Font := Application.MainForm.Font;
    frmTrim.LoadOptions(Options);
    Result := frmTrim.ShowModal = mrOK;
    if Result then
      frmTrim.SaveOptions(Options);
  finally
    frmTrim.Free;
  end;
end;

procedure TfrmTrim.LoadOptions(Options: TAppOptions);
begin
  edTrimWhat.Text := Options.TrimWhat;
  cbTrimWhere.ItemIndex := Options.TrimWhere;
  cbTrimHow.ItemIndex := Options.TrimHow;
  chkTrimWhitespace.Checked := Options.TrimWhiteSpace;
end;

procedure TfrmTrim.SaveOptions(Options: TAppOptions);
begin
  Options.TrimWhat := edTrimWhat.Text;
  Options.TrimWhere := cbTrimWhere.ItemIndex;
  Options.TrimHow := cbTrimHow.ItemIndex;
  Options.TrimWhiteSpace := chkTrimWhitespace.Checked;
end;

end.
