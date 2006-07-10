{@abstract(Generic single file select dialog) }
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
// $Id: SingleImportFrm.pas,v 1.3 2004/11/05 20:10:44 peter3 Exp $
unit TMXImportFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmImport = class(TForm)
    Label1: TLabel;
    edFilename: TEdit;
    btnBrowse: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    OpenDialog1: TOpenDialog;
    Label2: TLabel;
    edOrigLang: TEdit;
    Label3: TLabel;
    edTransLang: TEdit;
    procedure btnBrowseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Execute(var AFilename, AOrigLang, ATransLang: string; const ACaption, Filter, InitialDir, DefaultExt:string): boolean;
  end;

implementation

{$R *.dfm}

{ TfrmImport }

class function TfrmImport.Execute(var AFilename, AOrigLang, ATransLang: string; const ACaption, Filter, InitialDir, DefaultExt:string): boolean;
var
  frmImport: TfrmImport;
begin
  frmImport := self.Create(Application);
  with frmImport do
  try
    Caption := ACaption;
    OpenDialog1.Filter := Filter;
    OpenDialog1.InitialDir := InitialDir;
    OpenDialog1.DefaultExt := DefaultExt;
    edFilename.Text := AFilename;
    edOrigLang.Text := AOrigLang;
    edTransLang.Text := ATransLang;
    Result := (ShowModal = mrOk) and FileExists(edFilename.Text) and (edOrigLang.Text <> '') and (edTransLang.Text <> '');
    if Result then
    begin
      AFilename := edFilename.Text;
      AOrigLang := edOrigLang.Text;
      ATransLang := edTransLang.Text;
    end;
  finally
    Free;
  end;
end;

procedure TfrmImport.btnBrowseClick(Sender: TObject);
begin
  OpenDialog1.Filename := edFilename.Text;
  if OpenDialog1.Execute then
    edFilename.Text := OpenDialog1.Filename;
end;

end.


