unit PluginWizardForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TntStdCtrls, PluginOptions, TntDialogs;

type
  TfrmTranslatorPluginWizard = class(TForm)
    btnOK: TTntButton;
    btnCancel: TTntButton;
    TntGroupBox1: TTntGroupBox;
    TntLabel1: TTntLabel;
    edClassName: TTntEdit;
    rbFileParser: TTntRadioButton;
    rbToolPlugin: TTntRadioButton;
    TntLabel2: TTntLabel;
    edTitle: TTntEdit;
    TntLabel3: TTntLabel;
    edTransIntfPath: TTntEdit;
    TntButton1: TTntButton;
    odTransIntf: TTntOpenDialog;
    procedure TntButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Execute(Options: TPluginOptions): boolean;
  end;

implementation

{$R *.dfm}

{ TfrmTranslatorPluginWizard }

class function TfrmTranslatorPluginWizard.Execute(Options: TPluginOptions): boolean;
var frm: TfrmTranslatorPluginWizard;
begin
  frm := self.Create(Application);
  try
    frm.edClassName.Text := Options.PluginClassName;
    frm.edTitle.Text := Options.Title;
    frm.edTransIntfPath.Text := Options.TransIntfPath;
    frm.rbFileParser.Checked := Options.IsFileParser;
    frm.rbToolPlugin.Checked := not Options.IsFileParser;
    Result := frm.ShowModal = mrOk;
    if Result then
    begin
      Options.PluginClassName := frm.edClassName.Text;
      Options.Title := frm.edTitle.Text;
      Options.TransIntfPath := frm.edTransIntfPath.Text;
      Options.IsFileParser := frm.rbFileParser.Checked;
    end;
  finally
    frm.Free;
  end;
end;

procedure TfrmTranslatorPluginWizard.TntButton1Click(Sender: TObject);
begin
  odTransIntf.FileName := edTransIntfPath.Text;
  if odTransIntf.Execute then
    edTransIntfPath.Text := odTransIntf.FileName;
end;

end.

