{@abstract(Dictionary Edit Dialog) }
{
  Copyright © 2003-2004 by Peter Thornqvist; all rights reserved

  Developer(s):
    p3 - peter3 att users dott sourceforge dott net

  Status:
   The contents of this file are subject to the Mozilla Public License Version
   1.1 (the "License"); you may not use this file except in compliance with the
   License. You may obtain a copy of the License at http://www.mozilla.org/MPL/MPL-1.1.html

   Software distributed under the License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.
}
// $Id: $
unit DictEditFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseForm, StdCtrls, TntStdCtrls, ExtCtrls, TntExtCtrls, Dictionary,
  ActnList, TntActnList;

type
  TfrmDictEdit = class(TfrmBase)
    cbOriginal: TTntComboBox;
    TntLabel1: TTntLabel;
    btnAddOriginal: TTntButton;
    btnRemoveOriginal: TTntButton;
    lbTranslations: TTntListBox;
    TntLabel2: TTntLabel;
    edTranslation: TTntEdit;
    btnAddTranslation: TTntButton;
    btnRemoveTranslation: TTntButton;
    btnOK: TTntButton;
    btnCancel: TTntButton;
    TntBevel1: TTntBevel;
    alDictEdit: TTntActionList;
    acAddOriginal: TTntAction;
    acRemoveOriginal: TTntAction;
    acAddTranslation: TTntAction;
    acRemoveTranslation: TTntAction;
    TntLabel3: TTntLabel;
    cbFilter: TTntComboBox;
    procedure cbOriginalChange(Sender: TObject);
    procedure alDictEditUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure acAddOriginalExecute(Sender: TObject);
    procedure acRemoveOriginalExecute(Sender: TObject);
    procedure acAddTranslationExecute(Sender: TObject);
    procedure acRemoveTranslationExecute(Sender: TObject);
    procedure lbTranslationsClick(Sender: TObject);
    procedure cbFilterChange(Sender: TObject);
  private
    { Private declarations }
    FItems: TDictionaryItems;
    procedure SetItems(const Value: TDictionaryItems);
    function GetItems: TDictionaryItems;
    procedure UpdateUI;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Items: TDictionaryItems read GetItems write SetItems;
    class function Edit(Items: TDictionaryItems): boolean;
  end;

implementation
uses
  AppUtils;

{$R *.dfm}

{ TfrmDictEdit }

constructor TfrmDictEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TDictionaryItems.Create;
end;

destructor TfrmDictEdit.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

class function TfrmDictEdit.Edit(Items: TDictionaryItems): boolean;
var
  frm: TfrmDictEdit;
begin
  frm := self.Create(Application);
  try
    frm.cbFilter.ItemIndex := GlobalAppOptions.DictEditFilter;
    frm.Items := Items;
//    frm.Items.IgnorePunctuation := Items.IgnorePunctuation;
    Result := frm.ShowModal = mrOK;
    if Result then
    begin
      Items.Assign(frm.Items);
      GlobalAppOptions.DictEditFilter := frm.cbFilter.ItemIndex;
    end;
  finally
    frm.Free;
  end;
end;

function TfrmDictEdit.GetItems: TDictionaryItems;
begin
  Result := FItems;
end;

procedure TfrmDictEdit.SetItems(const Value: TDictionaryItems);
begin
  FItems.Assign(Value);
  cbOriginal.Items.Clear;
  lbTranslations.Items.Clear;
  cbFilterChange(nil);
end;

procedure TfrmDictEdit.cbOriginalChange(Sender: TObject);
var i: integer;
begin
  lbTranslations.Items.Clear;
  i := FItems.IndexOf(cbOriginal.Text);
  if i > -1 then
    lbTranslations.Items := FItems[i].Translations;
  UpdateUI;
end;

procedure TfrmDictEdit.alDictEditUpdate(Action: TBasicAction;
  var Handled: Boolean);
var i: integer;
begin
  i := cbOriginal.Items.IndexOf(cbOriginal.Text);
  acAddOriginal.Enabled := (cbOriginal.Text <> '') and (i < 0);
  acRemoveOriginal.Enabled := i > -1;

  i := lbTranslations.Items.IndexOf(edTranslation.Text);
  acAddTranslation.Enabled := (edTranslation.Text <> '') and (i < 0);
  acRemoveTranslation.Enabled := i > -1;
end;

procedure TfrmDictEdit.acAddOriginalExecute(Sender: TObject);
var i: integer;
begin
  if (cbOriginal.Text <> '') and (cbOriginal.Items.IndexOf(cbOriginal.Text) < 0) then
  begin
    cbOriginal.ItemIndex := cbOriginal.Items.Add(cbOriginal.Text);
    FItems.Add(cbOriginal.Text);
    i := FItems.IndexOf(cbOriginal.Text);
    if i >= 0 then
      lbTranslations.Items := FItems[i].Translations
    else
      lbTranslations.Items.Clear;
    edTranslation.SetFocus;
    edTranslation.SelectAll;
  end;
  cbFilterChange(Sender);
end;

procedure TfrmDictEdit.acRemoveOriginalExecute(Sender: TObject);
var i: integer;
begin
  i := FItems.IndexOf(cbOriginal.Text);
  if i >= 0 then
    FItems.Delete(i);

  i := cbOriginal.Items.IndexOf(cbOriginal.Text);
  if i >= 0 then
  begin
    cbOriginal.Items.Delete(i);
    cbOriginal.ItemIndex := i;
  end;
  if cbOriginal.ItemIndex < 0 then
    cbOriginal.ItemIndex := 0;
  cbOriginalChange(Sender);
  cbOriginal.SetFocus;
end;

procedure TfrmDictEdit.acAddTranslationExecute(Sender: TObject);
var i: integer;
begin
  if edTranslation.Text = '' then
    Exit;
  i := FItems.IndexOf(cbOriginal.Text);
  if (i >= 0) and (FItems[i].Translations.IndexOf(edTranslation.Text) < 0) then
  begin
    FItems[i].Translations.Add(edTranslation.Text);
    cbOriginalChange(Sender);
    edTranslation.SetFocus;
    edTranslation.SelectAll;
  end;
end;

procedure TfrmDictEdit.acRemoveTranslationExecute(Sender: TObject);
var
  i, j: integer;
  S: WideString;
begin
  i := Items.IndexOf(cbOriginal.Text);
  if (i >= 0) then
  begin
    if lbTranslations.ItemIndex >= 0 then
    begin
      S := lbTranslations.Items[lbTranslations.ItemIndex];
      j := Items[i].Translations.IndexOf(S);
      if j >= 0 then
      begin
        Items[i].Translations.Delete(j);
        cbOriginalChange(Sender);
      end;
    end;
  end;
end;

procedure TfrmDictEdit.lbTranslationsClick(Sender: TObject);
begin
  with lbTranslations do
    if ItemIndex >= 0 then
      edTranslation.Text := Items[ItemIndex];
  UpdateUI;
end;

procedure TfrmDictEdit.UpdateUI;
begin
  alDictEdit.UpdateAction(nil);
end;

procedure TfrmDictEdit.cbFilterChange(Sender: TObject);
var i:integer;
begin
  cbOriginal.Text := '';
  cbOriginal.Items.Clear;
  for i := 0 to FItems.Count - 1 do
    case cbFilter.ItemIndex of
    0:  // all items
      cbOriginal.Items.Add(FItems[i].Original);
    1:  // items with translations
      if FItems[i].Translations.Count > 0 then
        cbOriginal.Items.Add(FItems[i].Original);
    2:
      if FItems[i].Translations.Count = 0 then
        cbOriginal.Items.Add(FItems[i].Original);
  end;
  if cbOriginal.Items.Count > 0 then
    cbOriginal.ItemIndex := 0;
  cbOriginalChange(Sender);
end;

end.

