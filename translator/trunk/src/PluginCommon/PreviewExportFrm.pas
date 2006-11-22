{@abstract(Generic export dialog w. content preview) }
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
unit PreviewExportFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, TntForms, TntClasses, TntComCtrls, TransIntf,
  TntDialogs, TntStdCtrls;

type
  TfrmExport = class(TTntForm, IInterface, ILocalizable)
    lblFilename: TTntLabel;
    edFilename: TTntEdit;
    btnBrowse: TTntButton;
    rePreview: TTntRichEdit;
    btnOK: TTntButton;
    btnCancel: TTntButton;
    lblPreview: TTntLabel;
    SaveDialog1: TTntSaveDialog;
    procedure btnBrowseClick(Sender: TObject);
  private
    { Private declarations }
    FHasPrompted: boolean;
    FApplicationServices: IApplicationServices;
    FCount: integer;
    function CheckFilename: boolean;
    function IsValidFilename: boolean;
    function OverwriteOK: boolean;
    procedure LoadSettings;
    procedure SaveSettings;
    function Translate(const Value: WideString): WideString;
  public
    { Public declarations }
    class function Execute(var FileName: string; const ACaption, Filter, InitialDir, DefaultExt: string;
      Preview: TTntStrings): boolean; overload;
    class function Execute(const ApplicationServices: IApplicationServices; var FileName: string;
      const ACaption, Filter, InitialDir, DefaultExt: string; Preview: TTntStrings): boolean; overload;
    function GetString(out Section: WideString; out Name: WideString; out Value: WideString): WordBool; safecall;
  end;

implementation
uses
  ShellAPI, IniFiles;

const
  SFmtErrIvalidFilename = 'Invalid filename "%s". Select another filename and try again.';
  SError = 'Error';
  SFmtOverwriteOK = 'File "%s" already exists. Do you want to overwrite it?';
  SConfirm = 'Confirm';

{$R *.dfm}

{ TfrmExport }

class function TfrmExport.Execute(var FileName: string;
  const ACaption, Filter, InitialDir, DefaultExt: string;
  Preview: TTntStrings): boolean;
begin
  Result := Execute(nil, Filename, ACaption, Filter, InitialDir, DefaultExt, Preview);
end;

procedure TfrmExport.btnBrowseClick(Sender: TObject);
begin
  SaveDialog1.FileName := edFilename.Text;
  if SaveDialog1.Execute then
  begin
    FHasPrompted := true;
    edFilename.Text := SaveDialog1.FileName;
  end;
end;

function TfrmExport.OverwriteOK: boolean;
begin
  Result := FHasPrompted or not FileExists(edFilename.Text) or
    (MessageBox(Handle, PChar(Format(SFmtOverwriteOK, [edFilename.Text])), PChar(SConfirm), MB_YESNO or MB_TASKMODAl or MB_ICONQUESTION) = IDYES);
end;

procedure TfrmExport.LoadSettings;
var M: TMemoryStream;
  FRect: TRect;
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

procedure TfrmExport.SaveSettings;
var M: TMemoryStream;
  FRect: TRect;
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

function TfrmExport.IsValidFilename: boolean;
var
  AHandle: THandle;
  ALAstError: DWORD;
begin
  if edFilename.Text <> '' then
  begin
    // try to create a new file: either it will fail because the file exists
    // or because the name is invalid
    AHandle := CreateFile(PChar(string(edFilename.Text)), 0, 0, nil, CREATE_NEW, 0, 0);
    try
      ALastError := GetLastError;
      Result := (ALastError = ERROR_FILE_EXISTS) or (AHandle <> INVALID_HANDLE_VALUE);
      SetLastError(ALastError);
    finally
      if AHandle <> INVALID_HANDLE_VALUE then
        CloseHandle(AHandle);
    end;
  end
  else
    Result := false;
end;

function TfrmExport.CheckFilename: boolean;
begin
  Result := IsValidFilename;
  if not Result then
    MessageBox(Handle, PChar(Format(SFmtErrIvalidFilename, [edFilename.Text])), PChar(SError), MB_OK or MB_TASKMODAl or MB_ICONERROR);
end;

class function TfrmExport.Execute(
  const ApplicationServices: IApplicationServices; var FileName: string;
  const ACaption, Filter, InitialDir, DefaultExt: string;
  Preview: TTntStrings): boolean;
var
  frmExport: TfrmExport;
begin
  Result := false;
  frmExport := self.Create(Application);
  with frmExport do
  try
    LoadSettings;
    FApplicationServices := ApplicationServices;
    if ACaption <> '' then
      Caption := Translate(ACaption)
    else
      Caption := Translate(Caption);
    lblFilename.Caption := Translate(lblFilename.Caption);
    lblPreview.Caption := Translate(lblPreview.Caption);
    btnOK.Caption := Translate(btnOK.Caption);
    btnCancel.Caption := Translate(btnCancel.Caption);
    SaveDialog1.Filter := Translate(Filter);
    SaveDialog1.InitialDir := InitialDir;
    SaveDialog1.DefaultExt := DefaultExt;
    edFilename.Text := Filename;
    rePreview.Lines := Preview;
    rePreview.SelStart := 0;
    SendMessage(rePreview.Handle, EM_SCROLLCARET, 0, 0);
    if (ShowModal = mrOK) and CheckFilename and OverwriteOK then
    begin
      Result := true;
      Preview.Assign(rePreview.Lines);
      Filename := edFilename.Text;
    end;
    SaveSettings;
  finally
    Free;
  end;
end;

function TfrmExport.Translate(const Value: WideString): WideString;
begin
  if FApplicationServices <> nil then
    Result := FApplicationServices.Translate(ClassName, Value, Value)
  else
    Result := Value;
end;

function TfrmExport.GetString(out Section, Name, Value: WideString): WordBool;
begin
  Result := true;
  case FCount of
    0: Value := SFmtErrIvalidFilename;
    1: Value := SError;
    2: Value := SFmtOverwriteOK;
    3: Value := SConfirm;
    4: Value := Self.Caption;
    5: Value := lblFilename.Caption;
    6: Value := lblPreview.Caption;
    7: Value := btnBrowse.Caption;
    8: Value := btnOK.Caption;
    9: Value := btnCancel.Caption;  
  else
    Result := false;
    FCount := 0;
  end;
  if Result then
    Inc(FCount);
  Section := ClassName;
  Name := Value;
end;

end.

