unit DictTranslationSelectDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseForm, StdCtrls, TntStdCtrls, Dictionary;

type
  TfrmDictTranslationSelect = class(TfrmBase)
    TntLabel1: TTntLabel;
    edOriginal: TTntEdit;
    TntLabel2: TTntLabel;
    edTranslation: TTntEdit;
    TntLabel3: TTntLabel;
    lbTranslations: TTntListBox;
    btnUse: TTntButton;
    btnCancel: TTntButton;
    btnIgnore: TTntButton;
    btnAdd: TTntButton;
    procedure btnIgnoreClick(Sender: TObject);
    procedure btnUseClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure lbTranslationsClick(Sender: TObject);
    procedure edTranslationChange(Sender: TObject);
  private
    { Private declarations }
    FResult:integer;
  public
    { Public declarations }
    class function Edit(DictionaryItem:TDictionaryItem; var Translation:WideString):Integer;
  end;


implementation
uses
  AppConsts;

{$R *.dfm}

{ TfrmDictTranslationSelect }

class function TfrmDictTranslationSelect.Edit(
  DictionaryItem: TDictionaryItem; var Translation: WideString): Integer;
var
  frm: TfrmDictTranslationSelect;
begin
  if DictionaryItem = nil then
  begin
    Result := cDictIgnore;
    Exit;
  end;
  
  frm := self.Create(Application);
  try
    frm.edOriginal.Text := DictionaryItem.Original;
    frm.edTranslation.Text := Translation;
    frm.lbTranslations.Items.Assign(DictionaryItem.Translations);
    frm.lbTranslations.ItemIndex := frm.lbTranslations.Items.IndexOf(Translation);
    frm.edTranslationChange(nil);
    if frm.ShowModal <> mrOK then
      frm.FResult := cDictCancel;
    Result := frm.FResult;
    if Result in [cDictUse, cDictAdd] then
      Translation := frm.edTranslation.Text;
  finally
    frm.Free;
  end;
end;

procedure TfrmDictTranslationSelect.btnIgnoreClick(Sender: TObject);
begin
  FResult := cDictIgnore;
end;

procedure TfrmDictTranslationSelect.btnUseClick(Sender: TObject);
begin
  FResult := cDictUse;
end;

procedure TfrmDictTranslationSelect.btnAddClick(Sender: TObject);
begin
  FResult := cDictAdd;
end;

procedure TfrmDictTranslationSelect.btnCancelClick(Sender: TObject);
begin
  FResult := cDictCancel;
end;

procedure TfrmDictTranslationSelect.lbTranslationsClick(Sender: TObject);
begin
  with lbTranslations do
  begin
    if ItemIndex > -1 then
      edTranslation.Text := Items[ItemIndex];
  end;
end;

procedure TfrmDictTranslationSelect.edTranslationChange(Sender: TObject);
begin
  btnAdd.Enabled := (edTranslation.Text <> '') and (lbTranslations.Items.IndexOf(edTranslation.Text) < 0);
end;

end.
