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
  Dialogs, StdCtrls, ComCtrls;

type

  TfrmImport = class(TForm)
    Label1: TLabel;
    edFilename: TEdit;
    btnBrowse: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    OpenDialog1: TOpenDialog;
    edSkipLines: TEdit;
    Label2: TLabel;
    udSkipLines: TUpDown;
    procedure btnBrowseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Execute(var AFilename: string; var SkipLines:integer; const ACaption, Filter, InitialDir, DefaultExt: string): boolean;
  end;

implementation

{$R *.dfm}

{ TfrmImport }

class function TfrmImport.Execute(var AFilename: string; var SkipLines:integer; const ACaption, Filter, InitialDir, DefaultExt: string): boolean;
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
    udSkipLines.Position := SkipLines;
    Result := (ShowModal = mrOk) and FileExists(edFilename.Text);
    if Result then
    begin
      AFilename := edFilename.Text;
      SkipLines := udSkipLines.Position;
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

