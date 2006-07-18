{@abstract(Generic file select dialog. Two files) }
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
// $Id$
unit DualImportFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmImport = class(TForm)
    lblOriginal: TLabel;
    edFilename: TEdit;
    btnBrowse: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    OpenDialog1: TOpenDialog;
    lblTranslation: TLabel;
    edFilename2: TEdit;
    btnBrowse2: TButton;
    OpenDialog2: TOpenDialog;
    procedure CheckChange(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure btnBrowse2Click(Sender: TObject);
  private
    { Private declarations }
    FSecondIsOptional: boolean;
    procedure LoadSettings;
    procedure SaveSettings;
  public
    { Public declarations }
    // SecondIsOptional parameter suggested by Chris Thornton
    class function Execute(var AOriginalFile, ATranslationFile: string; const ACaption, Filter, InitialDir, DefaultExt: string; const SecondIsOptional: Boolean = false): boolean;
  end;

implementation
uses
  IniFiles;

resourcestring
  SOptional = '&Translation file (optional):';

{$R *.dfm}

{ TfrmImport }

class function TfrmImport.Execute(var AOriginalFile, ATranslationFile: string; const ACaption, Filter, InitialDir, DefaultExt: string; const SecondIsOptional: Boolean = false): boolean;
var
  frmImport: TfrmImport;
begin
  frmImport := self.Create(Application);
  with frmImport do
  try
    LoadSettings;
    FSecondIsOptional := SecondIsOptional;
    Caption := ACaption;
    OpenDialog1.Filter := Filter;
    OpenDialog1.InitialDir := InitialDir;
    OpenDialog1.DefaultExt := DefaultExt;
    OpenDialog2.Filter := Filter;
    OpenDialog2.InitialDir := InitialDir;
    OpenDialog2.DefaultExt := DefaultExt;
    edFilename.Text := AOriginalFile;
    if SecondIsOptional then
      lblTranslation.Caption := SOptional;
    edFilename2.Text := ATranslationFile;
    CheckChange(nil);
    Result := (ShowModal = mrOk) and FileExists(edFilename.Text) and (SecondIsOptional or FileExists(edFilename2.Text));
    if Result then
    begin
      AOriginalFile := edFilename.Text;
      ATranslationFile := edFilename2.Text;
    end;
    SaveSettings;
  finally
    Free;
  end;
end;

procedure TfrmImport.CheckChange(Sender: TObject);
begin
  btnOK.Enabled := (edFilename.Text <> '') and (FSecondIsOptional or ((edFilename2.Text <> '') and FileExists(edFilename.Text) and FileExists(edFilename2.Text)));
end;

procedure TfrmImport.btnBrowseClick(Sender: TObject);
begin
  OpenDialog1.Filename := edFilename.Text;
  if OpenDialog1.Execute then
    edFilename.Text := OpenDialog1.Filename;
  CheckChange(Sender);
end;

procedure TfrmImport.btnBrowse2Click(Sender: TObject);
begin
  OpenDialog2.Filename := edFilename2.Text;
  if OpenDialog2.Execute then
    edFilename2.Text := OpenDialog2.Filename;
  CheckChange(Sender);
end;

procedure TfrmImport.LoadSettings;
var M: TMemoryStream; FRect: TRect;
begin
  try
    FRect := Rect(0, 0, 0, 0);
    with TIniFile.Create(ChangeFileExt(GetModuleName(HInstance), '.ini')) do
    try
      M := TMemoryStream.Create;
      try
        if ReadBinaryStream('Forms', ClassName, M) = SizeOf(TRect) then
        begin
          M.Seek(0, soFromBeginning);
          Move(M.Memory^, Pointer(@FRect)^, sizeof(TRect));
        end;
      finally
        M.Free;
      end;
    finally
      Free;
    end;
    if not IsRectEmpty(FRect) then
    begin
      if (BorderStyle in [bsSizeable, bsSizeToolWin]) and (Screen.PixelsPerInch = PixelsPerInch) then
        BoundsRect := FRect
      else
      begin
        Left := FRect.Left;
        Top := FRect.Top;
      end;
    end
    else
    begin
      Left := (Screen.Width - Width) div 2;
      Top := (Screen.Height - Height) div 2;
    end;
  except
    Application.HandleException(Self);
  end;
end;

procedure TfrmImport.SaveSettings;
var M: TMemoryStream; FRect: TRect;
begin
  if WindowState = wsNormal then
  try
    FRect := BoundsRect;
    with TIniFile.Create(ChangeFileExt(GetModuleName(HInstance), '.ini')) do
    try
      M := TMemoryStream.Create;
      try
        M.Write(FRect, sizeof(TRect));
        M.Seek(0, soFromBeginning);
        WriteBinaryStream('Forms', ClassName, M);
      finally
        M.Free;
      end;
    finally
      Free;
    end;
  except
    Application.HandleException(Self);
  end;
end;

end.
