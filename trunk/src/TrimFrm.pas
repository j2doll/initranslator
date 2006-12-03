{@abstract(Trim options dialog) }
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
