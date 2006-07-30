{@abstract(Options dialog) }
{

  Copyright © 2003-2006 by Peter Thornqvist; all rights reserved

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

// $Id$

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
    btnColors: TTntButton;
    procedure chkShowToolTipsClick(Sender: TObject);
    procedure chkReturnToSaveClick(Sender: TObject);
    procedure btnLanguageClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure chkSavePositionClick(Sender: TObject);
    procedure btnColorsClick(Sender: TObject);
  private
    { Private declarations }
    FOptions:TAppOptions;
    procedure UpdatePreview;
    procedure LoadOptions(Options: TAppOptions);
    procedure SaveOptions(Options: TAppOptions);
  public
    { Public declarations }
    class function Execute(Options: TAppOptions): boolean;
  end;

implementation
uses
  AppConsts, AppUtils, CommonUtils, TntDialogs, ColorsFrm;

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
  with TTntOpenDialog.Create(nil) do
  try
    InitialDir := '.';
    Title := SSelectLanguageFile;
    Filename := edLanguage.Text;
    if Execute then
      edLanguage.Text := Filename;
  finally
    Free;
  end;
end;

procedure TfrmOptions.btnHelpClick(Sender: TObject);
begin
  with TTntOpenDialog.Create(nil) do
  try
    Title := SSelectHelpFile;
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
    frm.LoadOptions(Options);
    Result := frm.ShowModal = mrOk;
    if Result then
    begin
      // save options
      if AnsiCompareFilename(frm.edLanguage.Text, Options.LanguageFile) <> 0 then
        InfoMsg(Translate(Application.MainForm.ClassName, SLanguageNotChangedUntilRestart), Translate(Application.MainForm.ClassName, SInfoCaption));
      frm.SaveOptions(Options);
    end;
  finally
    frm.Free;
  end;
end;

procedure TfrmOptions.UpdatePreview;
begin
  pnlFontPreview.Font := FontDialog.Font;
  pnlFontPreview.Caption :=
    WideFormat('%s, %dpt', [FontDialog.Font.Name, FontDialog.Font.Size]);
end;

procedure TfrmOptions.btnColorsClick(Sender: TObject);
begin
  TfrmColors.Edit(FOptions);
end;

procedure TfrmOptions.LoadOptions(Options: TAppOptions);
begin
  FOptions := Options;
  chkShowQuotes.Checked := Options.ShowQuotes;
  chkInvertDictionary.Checked := Options.InvertDictionary;
  chkShowDetails.Checked := Options.ShowDetails;
  chkShowToolTips.Checked := Options.ShowToolTips;
  chkShowShortCuts.Checked := Options.ShowToolTipShortCuts;
  chkDictIgnoreSpeedKey.Checked := Options.DictIgnoreSpeedKeys;
  chkReturnToSave.Checked := Options.SaveOnReturn;
  chkMoveToNext.Checked := Options.AutoMoveToNext;
  chkSavePosition.Checked := Options.SaveFormPos;
  chkSaveMinMax.Checked := Options.SaveMinMaxState;
  chkGlobalPath.Checked := Options.GlobalPath;
  chkMonitorFiles.Checked := Options.MonitorFiles;
  chkShowFullNames.Checked := Options.ShowFullNameInColumns;
  chkUseTranslationEverywhere.Checked := Options.UseTranslationEverywhere;
  chkAutoFocusTranslation.Checked := Options.AutoFocusTranslation;
  chkDictIgnoreNonEmpty.Checked := Options.DictIgnoreNonEmpty;
  edLanguage.Text := Options.LanguageFile;
  edHelp.Text := Options.HelpFile;
  FontDialog.Font := Options.AppFont;
  UpdatePreview;
end;

procedure TfrmOptions.SaveOptions(Options: TAppOptions);
begin
  FOptions := Options;
  Options.ShowQuotes := chkShowQuotes.Checked;
  Options.InvertDictionary := chkInvertDictionary.Checked;
  Options.ShowDetails := chkShowDetails.Checked;
  Options.ShowToolTips := chkShowToolTips.Checked;
  Options.ShowToolTipShortCuts := chkShowShortCuts.Checked;
  Options.DictIgnoreSpeedKeys := chkDictIgnoreSpeedKey.Checked;
  Options.SaveOnReturn := chkReturnToSave.Checked;
  Options.AutoMoveToNext := chkMoveToNext.Checked;
  Options.SaveFormPos := chkSavePosition.Checked;
  Options.SaveMinMaxState := chkSaveMinMax.Checked;
  Options.GlobalPath := chkGlobalPath.Checked;
  Options.MonitorFiles := chkMonitorFiles.Checked;
  Options.UseTranslationEverywhere := chkUseTranslationEverywhere.Checked;
  Options.AutoFocusTranslation := chkAutoFocusTranslation.Checked;
  Options.DictIgnoreNonEmpty := chkDictIgnoreNonEmpty.Checked;
  Options.ShowFullNameInColumns := chkShowFullNames.Checked;
  Options.LanguageFile := edLanguage.Text;
  Options.HelpFile := edHelp.Text;
  Options.AppFont.Assign(FontDialog.Font);
end;

end.
