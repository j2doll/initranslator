unit EditItemFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, BaseForm, StdCtrls, TntStdCtrls, TntClasses, TransIntf,
  ComCtrls, TntComCtrls;

type
  TfrmEditItem = class(TfrmBase)
    btnOK: TTntButton;
    btnCancel: TTntButton;
    Label1: TTntLabel;
    cbSections: TTntComboBox;
    Label2: TTntLabel;
    edOriginal: TTntRichEdit;
    Label3: TTntLabel;
    edTranslation: TTntRichEdit;
    Label6: TLabel;
    edName: TEdit;
    pcComments: TTntPageControl;
    tabOriginal: TTntTabSheet;
    tabTranslation: TTntTabSheet;
    edOrigComments: TTntRichEdit;
    edTransComment: TTntRichEdit;
    procedure TntFormCreate(Sender: TObject);
    procedure DoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Edit(const ACaption: WideString;
      Sections: TTntStringlist; const AItem: ITranslationItem; IsNewItem: boolean): boolean;
  end;

var
  frmEditItem: TfrmEditItem;

implementation
uses
  AppUtils;

{$R *.dfm}

{ TfrmEditItem }

class function TfrmEditItem.Edit(const ACaption: WideString; Sections: TTntStringlist;
  const AItem: ITranslationItem; IsNewItem: boolean): boolean;
var frm: TfrmEditItem;
begin
  frm := self.Create(Application);
  try
    GlobalLanguageFile.TranslateObject(frm, frm.ClassName);
    frm.Caption := ACaption;
    if Sections <> nil then
      frm.cbSections.Items := Sections;
    frm.cbSections.Text := AItem.Section;
    if frm.cbSections.Text = '' then
      frm.cbSections.ItemIndex := 0;
    frm.cbSections.Enabled := IsNewItem;
    frm.edName.Text := AItem.Name;
    frm.edName.Enabled := IsNewItem;
    frm.edOriginal.Text := AItem.Original;
    frm.edTranslation.Text := AItem.Translation;
    frm.edOrigComments.Text := AItem.OrigComments;
    frm.edTransComment.Text := AItem.TransComments;
    Result := frm.ShowModal = mrOK;
    if Result then
    begin
      AItem.Section := frm.cbSections.Text;
      AItem.Name := frm.edName.Text;
      AItem.Original := frm.edOriginal.Text;
      AItem.Translation := frm.edTranslation.Text;
      AItem.OrigComments := frm.edOrigComments.Text;
      AItem.TransComments := frm.edTransComment.Text;
    end;
  finally
    frm.Free;
  end;
end;

procedure TfrmEditItem.TntFormCreate(Sender: TObject);
begin
  inherited;
  pcComments.ActivePageIndex := 0;
end;

procedure TfrmEditItem.DoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Key := 0;
end;

end.
