{@abstract(Options dialog) }
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

// $Id: OptionsFrm.pas 13 2006-07-12 14:30:20Z peter3 $

unit OptionsFrm;

{$I TRANSLATOR.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, AppOptions, BaseForm,
  TntStdCtrls,
  TntExtCtrls;

type
  TfrmOptions = class(TfrmBase)
    btnOK: TTntButton;
    btnCancel: TTntButton;
    chkShowQuotes: TTntCheckBox;
    chkInvertDictionary: TTntCheckBox;
    btnFont: TTntButton;
    chkShowDetails: TTntCheckBox;
    chkShowToolTips: TTntCheckBox;
    chkShowShortCuts: TTntCheckBox;
    chkReturnToSave: TTntCheckBox;
    chkMoveToNext: TTntCheckBox;
    Label1: TTntLabel;
    edLanguage: TTntEdit;
    btnLanguage: TTntButton;
    Label2: TTntLabel;
    edHelp: TTntEdit;
    btnHelp: TTntButton;
    chkSavePosition: TTntCheckBox;
    chkSaveMinMax: TTntCheckBox;
    Bevel1: TBevel;
    chkGlobalPath: TTntCheckBox;
    FontDialog: TFontDialog;
    pnlFontPreview: TTntPanel;
    Bevel2: TBevel;
    chkMonitorFiles: TTntCheckBox;
    chkDictIgnoreSpeedKey: TTntCheckBox;
    chkShowFullNames: TTntCheckBox;
    chkUseTranslationEverywhere: TTntCheckBox;
    chkAutoFocusTranslation: TTntCheckBox;
    chkDictIgnoreNonEmpty: TTntCheckBox;
    procedure chkShowToolTipsClick(Sender: TObject);
    procedure chkReturnToSaveClick(Sender: TObject);
    procedure btnLanguageClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure chkSavePositionClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdatePreview;
  public
    { Public declarations }
    class function Execute(Options: TAppOptions): boolean;
  end;

implementation
uses
  AppConsts, AppUtils, CommonUtils;

{$R *.dfm}

procedure TfrmOptions.chkShowToolTipsClick(Sender: TObject);
begin
  chkShowShortCuts.Enabled := chkShowToolTips.Checked;
end;

procedure TfrmOptions.chkReturnToSaveClick(Sender: TObject);
begin
  chkMoveToNext.Enabled := chkReturnToSave.Checked;
end;

procedure TfrmOptions.btnLanguageClick(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do
  try
    InitialDir := '.';
    Filename := edLanguage.Text;
    if Execute then
      edLanguage.Text := Filename;
  finally
    Free;
  end;
end;

procedure TfrmOptions.btnHelpClick(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do
  try
    InitialDir := '.';
    Filename := edHelp.Text;
    if Execute then
      edHelp.Text := Filename;
  finally
    Free;
  end;
end;

procedure TfrmOptions.btnFontClick(Sender: TObject);
begin
  FontDialog.Execute;
  UpdatePreview;
end;

procedure TfrmOptions.chkSavePositionClick(Sender: TObject);
begin
  chkSaveMinMax.Enabled := chkSavePosition.Checked;
end;

class function TfrmOptions.Execute(Options: TAppOptions): boolean;
var
  frm: TfrmOptions;
begin
  frm := self.Create(Application);
  try
    // load options
    frm.chkShowQuotes.Checked := Options.ShowQuotes;
    frm.chkInvertDictionary.Checked := Options.InvertDictionary;
    frm.chkShowDetails.Checked := Options.ShowDetails;
    frm.chkShowToolTips.Checked := Options.ShowToolTips;
    frm.chkShowShortCuts.Checked := Options.ShowToolTipShortCuts;
    frm.chkDictIgnoreSpeedKey.Checked := Options.DictIgnoreSpeedKeys;
    frm.chkReturnToSave.Checked := Options.SaveOnReturn;
    frm.chkMoveToNext.Checked := Options.AutoMoveToNext;
    frm.chkSavePosition.Checked := Options.SaveFormPos;
    frm.chkSaveMinMax.Checked := Options.SaveMinMaxState;
    frm.chkGlobalPath.Checked := Options.GlobalPath;
    frm.chkMonitorFiles.Checked := Options.MonitorFiles;
    frm.chkShowFullNames.Checked := Options.ShowFullNameInColumns;
    frm.chkUseTranslationEverywhere.Checked := Options.UseTranslationEverywhere;
    frm.chkAutoFocusTranslation.Checked := Options.AutoFocusTranslation;
    frm.chkDictIgnoreNonEmpty.Checked := Options.DictIgnoreNonEmpty;
    frm.edLanguage.Text := Options.LanguageFile;
    frm.edHelp.Text := Options.HelpFile;
    frm.FontDialog.Font := Options.AppFont;
    frm.UpdatePreview;
    Result := frm.ShowModal = mrOk;
    if Result then
    begin
      // save options
      Options.ShowQuotes := frm.chkShowQuotes.Checked;
      Options.InvertDictionary := frm.chkInvertDictionary.Checked;
      Options.ShowDetails := frm.chkShowDetails.Checked;
      Options.ShowToolTips := frm.chkShowToolTips.Checked;
      Options.ShowToolTipShortCuts := frm.chkShowShortCuts.Checked;
      Options.DictIgnoreSpeedKeys := frm.chkDictIgnoreSpeedKey.Checked;
      Options.SaveOnReturn := frm.chkReturnToSave.Checked;
      Options.AutoMoveToNext := frm.chkMoveToNext.Checked;
      Options.SaveFormPos := frm.chkSavePosition.Checked;
      Options.SaveMinMaxState := frm.chkSaveMinMax.Checked;
      Options.GlobalPath := frm.chkGlobalPath.Checked;
      Options.MonitorFiles := frm.chkMonitorFiles.Checked;
      Options.UseTranslationEverywhere := frm.chkUseTranslationEverywhere.Checked;
      Options.AutoFocusTranslation := frm.chkAutoFocusTranslation.Checked;
      Options.DictIgnoreNonEmpty := frm.chkDictIgnoreNonEmpty.Checked;
      Options.ShowFullNameInColumns := frm.chkShowFullNames.Checked;
      if AnsiCompareFilename(frm.edLanguage.Text, Options.LanguageFile) <> 0 then
        InfoMsg(Translate(Application.MainForm.ClassName, SLanguageNotChangedUntilRestart), Translate(frm.ClassName, SInfoCaption));
      Options.LanguageFile := frm.edLanguage.Text;
      Options.HelpFile := frm.edHelp.Text;
      Options.AppFont.Assign(frm.FontDialog.Font);
    end;
  finally
    frm.Free;
  end;
end;

procedure TfrmOptions.UpdatePreview;
begin
  pnlFontPreview.Font := FontDialog.Font;
  pnlFontPreview.Caption :=
    Format('%s, %dpt', [FontDialog.Font.Name, FontDialog.Font.Size]);
end;

end.
