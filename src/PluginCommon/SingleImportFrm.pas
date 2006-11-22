{@abstract(Generic single file select dialog) }
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

unit SingleImportFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, TransIntf, TntForms, TntDialogs, TntStdCtrls;

type
  TfrmImport = class(TTntForm)
    lblFilename: TTntLabel;
    edFilename: TTntEdit;
    btnBrowse: TTntButton;
    btnOK: TTntButton;
    btnCancel: TTntButton;
    OpenDialog1: TTntOpenDialog;
    procedure btnBrowseClick(Sender: TObject);
  private
    { Private declarations }
    FApplicationServices:IApplicationServices;
    function Translate(const Value:WideString):WideString;
  public
    { Public declarations }
    class function Execute(var AFilename: string; const ACaption, Filter, InitialDir, DefaultExt: string): boolean;overload;
    class function Execute(const ApplicationServices:IApplicationServices; var AFilename: string; const ACaption, Filter, InitialDir, DefaultExt: string): boolean;overload;
  end;

implementation

{$R *.dfm}

{ TfrmImport }

class function TfrmImport.Execute(var AFilename: string; const ACaption, Filter, InitialDir, DefaultExt: string): boolean;
begin
  Result := Execute(nil, AFilename, ACaption, Filter, InitialDir, DefaultExt);
end;

procedure TfrmImport.btnBrowseClick(Sender: TObject);
begin
  OpenDialog1.Filename := edFilename.Text;
  if OpenDialog1.Execute then
    edFilename.Text := OpenDialog1.Filename;
end;

class function TfrmImport.Execute(
  const ApplicationServices: IApplicationServices; var AFilename: string;
  const ACaption, Filter, InitialDir, DefaultExt: string): boolean;
var
  frmImport: TfrmImport;
begin
  frmImport := self.Create(Application);
  with frmImport do
  try
    FApplicationServices := ApplicationServices;
    if ACaption <> '' then
      Caption := Translate(ACaption)
    else
      Caption := Translate(Caption);
    OpenDialog1.Filter := Translate(Filter);
    lblFilename.Caption := Translate(lblFilename.Caption);
    btnOK.Caption := Translate(btnOK.Caption);
    btnCancel.Caption := Translate(btnCancel.Caption);
    OpenDialog1.InitialDir := InitialDir;
    OpenDialog1.DefaultExt := DefaultExt;
    edFilename.Text := AFilename;
    Result := (ShowModal = mrOk) and FileExists(edFilename.Text);
    if Result then
      AFilename := edFilename.Text;
  finally
    Free;
  end;

end;

function TfrmImport.Translate(const Value: WideString): WideString;
begin
  if FApplicationServices <> nil then
    Result := FApplicationServices.Translate(self.ClassName, Value, Value)
  else
    Result := Value;
end;

end.

