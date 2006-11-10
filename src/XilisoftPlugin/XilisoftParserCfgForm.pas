{
  Copyright © 2006 by Alexander Kornienko; all rights reserved

  Developer(s):

  Status:
   The contents of this file are subject to the Mozilla Public License Version
   1.1 (the "License"); you may not use this file except in compliance with the
   License. You may obtain a copy of the License at http://www.mozilla.org/MPL/MPL-1.1.html

   Software distributed under the License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.
}
// $Id: $
unit XilisoftParserCfgForm;

interface

uses
  PluginLocale,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TntStdCtrls;

type
  TXilisoftCfgForm = class(TForm)
    TCB1: TTntCheckBox;
    TntButton1: TTntButton;
    procedure TntButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FLocale: TPlgLocale;
  public
    { Public declarations }
    procedure FillLocale(LocaleFile: TPlgLocale);
  end;

var
  XilisoftCfgForm: TXilisoftCfgForm;

implementation

uses
  IniFiles;

{$R *.dfm}

const
  cfgSection = 'CfgForm';
  cCaption = 'Caption';
  cSkip = 'SkipEmpty';

procedure TXilisoftCfgForm.TntButton1Click(Sender: TObject);
begin
  if TCB1.Checked then
    ModalResult := mrYes
  else
    ModalResult := mrNo;
end;

procedure TXilisoftCfgForm.FillLocale(LocaleFile: TPlgLocale);
begin
  FLocale := LocaleFile;
  FLocale.FormSection := cfgSection;
  FLocale.AddKey(sForm, cCaption);
  FLocale.AddKey(sForm, cSkip);
end;

procedure TXilisoftCfgForm.FormShow(Sender: TObject);
var
  s: string;
begin
  s := FLocale.GetLocalizedKey(sForm, cCaption);
  if s <> '' then
    Caption := s;
  s := FLocale.GetLocalizedKey(sForm, cSkip);
  if s <> '' then
    TCB1.Caption := s;
end;

end.

