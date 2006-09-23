{@abstract(Utility functions and procedures) }
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
unit AppUtils;
{$I TRANSLATOR.INC}

interface
uses
  SysUtils, Classes, Controls, ActnList, ActnMan,
  MsgTranslate, AppConsts, AppOptions,
  TntClasses, TBXExtItems;

procedure TBMRULoadFromIni(MRU: TTBXMRUList);
procedure TBMRUSaveToIni(MRU: TTBXMRUList);
procedure TBMRULoadFromReg(MRU: TTBXMRUList; RootKey: Cardinal; const Path: WideString);
procedure TBMRUSaveToReg(MRU: TTBXMRUList; RootKey: Cardinal; const Path: WideString);
// "Fuzzy" in this context just means "remove all white space and control characters before comparing SubStr and Str"
function DetectEncoding(const FileName: WideString): TEncoding;
function GetAppVersion: WideString;
function GetCurrentYear:Integer;

// TODO: add JvCreateProcess from JVCL to add support for capturing output?

function ActionShortCutInUse(AM: TActionList; ShortCut: Word): boolean;
function FindActionShortCut(AM: TActionList; ShortCut: Word): TCustomAction;
function RemoveActionShortCut(AM: TActionList; ShortCut: Word): integer;
function Translate(const ASection, AMsg: WideString): WideString;
function MyShortCutToText(ShortCut: TShortCut): WideString;
function BinarySearch(AList: TList; L, R: integer; CompareItem: Pointer; CompareFunc: TListSortCompare; var Index: integer): boolean;

function GlobalLanguageFile: TAppLanguage;
function GlobalAppOptions: TAppOptions;
function GetUserAppDataFolder(const Default: WideString): WideString;
function GetUserShortcutFile: WideString;
function GetUserAppOptionsFile: WideString;

procedure HandleFileCreateException(Sender: TObject; E: Exception; const Filename: WideString);
function GetSpecialFolderLocation(const Folder: Integer): WideString;
function GetAppStoragePath: WideString;
function AutoDetectCharacterSet(Stream: TStream): TEncoding; overload;
function AutoDetectCharacterSet(const Filename: WideString): TEncoding; overload;
function FileCharSetToEncoding(CharSet: TTntStreamCharSet): TEncoding;

// for Delphi 6
function ValueFromIndex(S: TTntStrings; i: integer): WideString; overload;
function ValueFromIndex(S: TStrings; i: integer): AnsiString; overload;
function strtok(Search, Delim: WideString): WideString;

procedure SetXPComboStyle(AControl:TControl);

implementation
uses
  Windows, Forms, Dialogs, Math, Registry, StdCtrls, 
  WideIniFiles, Menus, Consts, ShFolder,
  CommonUtils, ShlObj, ActiveX, TbxUxThemes, 
  TntWindows, TntSysUtils, TntWideStrUtils;

var
  FLanguageFile: TAppLanguage = nil;
  FAppOptions: TAppOptions = nil;

function AutoDetectCharacterSet(Stream: TStream): TEncoding;
begin
  case TntClasses.AutoDetectCharacterSet(Stream) of
    csAnsi: Result := feAnsi;
    csUnicode: Result := feUnicode;
    csUnicodeSwapped: Result := feUnicodeSwapped;
    csUtf8: Result := feUtf8;
  else
    Result := feAnsi;
  end;
end;

function AutoDetectCharacterSet(const Filename: WideString): TEncoding;
var F: TTntFileStream;
begin
  F := TTntFileStream.Create(Filename, fmOpenRead or fmShareDenyNone);
  try
    Result := AutoDetectCharacterSet(F);
  finally
    F.Free;
  end;
end;


function FileCharSetToEncoding(CharSet: TTntStreamCharSet): TEncoding;
begin
  case CharSet of
    csUnicode: Result := feUnicode;
    csUnicodeSwapped: Result := feUnicodeSwapped;
    csUtf8: Result := feUtf8;
  else
    Result := feAnsi;
  end;
end;

function GlobalLanguageFile: TAppLanguage;
begin
  if FLanguageFile = nil then
    FLanguageFile := TAppLanguage.Create('');
  Result := FLanguageFile;
end;

function GlobalAppOptions: TAppOptions;
begin
  if FAppOptions = nil then
    FAppOptions := TAppOptions.Create(GetUserAppOptionsFile);
  Result := FAppOptions;
end;

function SHGetFolderPathW2(hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWord; pszPath: PWideChar): HRESULT; stdcall; external 'SHFolder.dll' name 'SHGetFolderPathW';

function WideSHGetFolderPath(hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWord; pszPath: PWideChar): HRESULT;
var AnsiBuff:AnsiString;
begin
  if Win32PlatformIsUnicode then
    Result := SHGetFolderPathW2(hwnd, csidl, hToken, dwFlags, pszPath)
  else
  begin
    SetLength(AnsiBuff, MAX_PATH * 2);
    Result := SHGetFolderPathA(hwnd, csidl, hToken, dwFlags, PAnsiChar(AnsiBuff));
    AnsiBuff := AnsiString(PAnsiChar(AnsiBuff));
    // pszPath :=
    WStrPLCopy(pszPath, AnsiBuff, Length(AnsiBuff));
   end;
end;


function GetUserAppDataFolder(const Default: WideString): WideString;
begin
  SetLength(Result, MAX_PATH + 1);
  // DONE: it seems SHGetFolderPathW in SHFolder doesn't use PWideChar...
  if not Succeeded(WideSHGetFolderPath(0, CSIDL_APPDATA, 0, 0, PWideChar(Result))) then
    Result := '';
  if Result = '' then
    Result := Default;
  Result := WideString(PWideChar(Result)); // strip excessive characters
end;

function GetUserShortcutFile: WideString;
begin
  Result := GetUserAppDataFolder('');
  if (Result <> '') and WideDirectoryExists(Result) then
    Result := WideIncludeTrailingPathDelimiter(Result) + 'IniTranslator'
  else
    Result := WideExtractFilePath(Application.ExeName);

  WideForceDirectories(Result);
  Result := WideIncludeTrailingPathDelimiter(Result) + 'translator.alf';
end;

function GetUserAppOptionsFile: WideString;
begin
  Result := GetUserAppDataFolder('');
  if (Result <> '') and WideDirectoryExists(Result) then
    Result := WideIncludeTrailingPathDelimiter(Result) + 'IniTranslator'
  else
    Result := WideExtractFilePath(Application.ExeName);
  WideForceDirectories(Result);
  Result := WideIncludeTrailingPathDelimiter(Result) + 'translator.ini';
end;

function Translate(const ASection, AMsg: WideString): WideString;
begin
  if GlobalLanguageFile <> nil then
    Result := GlobalLanguageFile.Translate(ASection, AMsg, AMsg)
  else
    Result := AMsg;
end;

function WideUpperCaseFirst(const S: WideString): WideString;
var i: integer;
begin
  if S = '' then
    Result := ''
  else
    Result := WideUpperCase(S[1]) + WideLowerCase(Copy(S, 2, MaxInt));
  for i := 2 to Length(Result) do
    if (Result[i - 1] in [WideChar(#0)..WideChar(#32), WideChar('_'),
      WideChar('-'), WideChar('+'), WideChar('\'), WideChar('/'), WideChar(':'),
        WideChar(';'), WideChar('.')]) then
      Result[i] := WideUpperCase(Result[i])[1];
end;

function MyShortCutToText(ShortCut: TShortCut): WideString;
var
  ACtrl, AShift, AAlt: WideString;
  i: integer;
begin
  Result := ShortCutToText(ShortCut);
  if Pos('+', Result) > 0 then
  begin
    if Pos(SmkcShift, Result) > 0 then
      AShift := SmkcShift
    else
      AShift := '';
    if Pos(SmkcCtrl, Result) > 0 then
      ACtrl := SmkcCtrl
    else
      ACtrl := '';
    if Pos(SmkcAlt, Result) > 0 then
      AAlt := SmkcAlt
    else
      AAlt := '';
    for i := Length(Result) - 1 downto 1 do // skip the last char to avoid removing something like "Ctrl++"
      if (Result[i] = '+') then
        Break;
    Result := ACtrl + AShift + AAlt + Copy(Result, i + 1, Maxint);
  end;
  Result := WideUpperCaseFirst(Result);
end;

function DetectEncoding(const FileName: WideString): TEncoding;
begin
  { DONE : Fix this later }
  Result := AutoDetectCharacterSet(Filename);
end;

procedure TBMRULoadFromReg(MRU: TTBXMRUList; RootKey: DWORD; const Path: WideString);
var
  ini: TRegIniFile;
begin
  ini := TRegIniFile.Create('');
  try
    ini.RootKey := RootKey;
    ini.OpenKey(Path, true);
    MRU.LoadFromRegIni(ini, cIniMRUKey);
  finally
    ini.Free;
  end;
end;

procedure TBMRUSaveToReg(MRU: TTBXMRUList; RootKey: DWORD; const Path: WideString);
var
  ini: TRegIniFile;
begin
  ini := TRegIniFile.Create('');
  try
    ini.RootKey := RootKey;
    ini.OpenKey(Path, true);
    MRU.SaveToRegIni(ini, cIniMRUKey);
  finally
    ini.Free;
  end;
end;

procedure TBMRULoadFromIni(MRU: TTBXMRUList);
var
  ini: TWideIniFile;
  I: Integer;
  S: WideString;
begin
  ini := TWideIniFile.Create(GetUserAppOptionsFile);
  try
    MRU.Items.Clear;

    for I := 1 to MRU.MaxItems do
    begin
      S := Ini.ReadString(cIniMRUKey, MRU.Prefix + IntToStr(I), '');
      if S <> '' then
        MRU.Items.Add(S);
    end;
  finally
    ini.Free;
  end;
end;

procedure TBMRUSaveToIni(MRU: TTBXMRUList);
var
  ini: TWideIniFile;
  I: Integer;
begin
  ini := TWideIniFile.Create(GetUserAppOptionsFile);
  try
    for I := 1 to MRU.MaxItems do
    begin
      if I <= MRU.Items.Count then
        Ini.WriteString(cIniMRUKey, MRU.Prefix + IntToStr(I), MRU.Items[I - 1])
      else
        Ini.DeleteKey(cIniMRUKey, MRU.Prefix + IntToStr(I));
    end;
  finally
    ini.Free;
  end;
end;

function GetCurrentYear:Integer;
var Y, M, D:Word;
begin
  DecodeDate(Date, Y, M, D);
  Result := Y;
end;

function GetAppVersion: WideString;
var
  FileName: WideString;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  Result := '1.0.0.0';
  FileName := Application.ExeName;
  InfoSize := Tnt_GetFileVersionInfoSizeW(PWideChar(FileName), Wnd);
  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if Tnt_GetFileVersionInfoW(PWideChar(FileName), Wnd, InfoSize, VerBuf) then
        if Tnt_VerQueryValueW(VerBuf, '\', Pointer(FI), VerSize) then
          Result := Format('%d.%d.%d.%d', [HiWord(FI.dwFileVersionMS), LoWord(FI.dwFileVersionMS), HiWord(FI.dwFileVersionLS), LoWord(FI.dwFileVersionLS)]);
    finally
      FreeMem(VerBuf);
    end;
  end;
end;

function ActionShortCutInUse(AM: TActionList; ShortCut: Word): boolean;
begin
  Result := FindActionShortCut(AM, ShortCut) <> nil;
end;

function FindActionShortCut(AM: TActionList; ShortCut: Word): TCustomAction;
var
  i, j: integer;
begin
  Result := nil;
  if ShortCut = 0 then
    Exit;
  for i := 0 to AM.ActionCount - 1 do
    if AM.Actions[i] is TCustomAction then
    begin
      Result := TCustomAction(AM.Actions[i]);
      if Result.ShortCut = ShortCut then
        Exit;
      j := Result.SecondaryShortCuts.IndexOfShortCut(ShortCut);
      if j >= 0 then
        Exit;
    end;
  Result := nil;
end;

function RemoveActionShortCut(AM: TActionList; ShortCut: Word): integer;
var
  Action: TCustomAction;
  i: integer;
begin
  Result := 0;
  if ShortCut = 0 then
    Exit;
  Action := FindActionShortCut(AM, ShortCut);
  while Action <> nil do
  begin
    if Action.ShortCut = ShortCut then
    begin
      Action.ShortCut := 0;
      Inc(Result);
    end;
    i := Action.SecondaryShortCuts.IndexOfShortCut(ShortCut);
    if i >= 0 then
    begin
      Action.SecondaryShortCuts.Delete(i);
      Inc(Result);
    end;
    Action := FindActionShortCut(AM, ShortCut);
  end;
end;

function BinarySearch(AList: TList; L, R: integer; CompareItem: Pointer; CompareFunc: TListSortCompare; var Index: integer): boolean;
var
  M: integer;
  CompareResult: integer;
begin
  while L <= R do
  begin
    M := (L + R) div 2;
    CompareResult := CompareFunc(AList[M], CompareItem);
    if (CompareResult < 0) then
      L := M + 1
    else if (CompareResult > 0) then
      R := M - 1
    else
    begin
      Index := M;
      Result := true;
      Exit;
    end;
  end;
  // not found, should be located here:
  Result := false;
  Index := L;
end;

procedure HandleFileCreateException(Sender: TObject; E: Exception; const Filename: WideString);
begin
  if E is EFCreateError then
    ErrMsg(WideFormat(Translate(Sender.ClassName, SErrCreateFileFmt), [Filename]), Translate(Sender.ClassName, SErrorCaption))
  else
    Application.HandleException(Sender);
end;

procedure SaveAndFreeOptions;
begin
  if FAppOptions <> nil then
  try
    FAppOptions.SaveToFile(GetUserAppOptionsFile);
  except
    on E: Exception do
      HandleFileCreateException(FAppOptions, E, GetUserAppOptionsFile);
  end;
  FreeAndNil(FAppOptions);
end;

function PidlFree(var IdList: PItemIdList): Boolean;
var
  Malloc: IMalloc;
begin
  Result := False;
  if IdList = nil then
    Result := True
  else
  begin
    if Succeeded(SHGetMalloc(Malloc)) and (Malloc.DidAlloc(IdList) > 0) then
    begin
      Malloc.Free(IdList);
      IdList := nil;
      Result := True;
    end;
  end;
end;

function PidlToPath(IdList: PItemIdList): WideString;
begin
  SetLength(Result, MAX_PATH);
  if Tnt_SHGetPathFromIDListW(IdList, PWideChar(Result)) then
    Result := WideString(PWideChar(Result))
  else
    Result := '';
end;

function GetSpecialFolderLocation(const Folder: Integer): WideString;
var
  FolderPidl: PItemIdList;
begin
  if Succeeded(SHGetSpecialFolderLocation(0, Folder, FolderPidl)) then
  begin
    Result := PidlToPath(FolderPidl);
    PidlFree(FolderPidl);
  end
  else
    Result := '';
end;

function GetAppStoragePath: WideString;
begin
  // try to get path to \Documents and Settings\<user>\Application Data
  // if that fails, use application install folder
  Result := GetSpecialFolderLocation(CSIDL_APPDATA);
  if Result = '' then
    Result := WideIncludeTrailingPathDelimiter(WideExtractFilePath(Application.ExeName))
  else
    Result := WideIncludeTrailingPathDelimiter(Result) + 'IniTranslator\';
  WideForceDirectories(Result);
end;

function ValueFromIndex(S: TTntStrings; i: integer): WideString;
begin
  if (i >= 0) and (i < S.Count) then
  begin
    Result := S[i];
    i := Pos('=', Result);
    if i > 0 then
      Result := Copy(Result, i + 1, MaxInt)
    else
      Result := '';
  end;
end;

function ValueFromIndex(S: TStrings; i: integer): AnsiString;
var tmp: TTntStringlist;
begin
  tmp := TTntStringlist.Create;
  try
    tmp.Assign(S);
    Result := ValueFromIndex(tmp, i);
  finally
    tmp.Free;
  end;
end;

{$IFOPT J+}
{$DEFINE JOPTSET}
{$ENDIF}
{$J+ }

function strtok(Search, Delim: WideString): WideString;
const

  I: integer = 1;
  Len: integer = 0;
  PrvStr: WideString = '';
begin
  Result := '';
  if Search <> '' then
  begin
    I := 1;
    PrvStr := Search;
    Len := Length(PrvStr);
  end;
  if PrvStr = '' then
    Exit;
  while (i <= Len) and (Pos(PrvStr[i], Delim) > 0) do
    Inc(I);
  while (i <= Len) and (Pos(PrvStr[i], Delim) = 0) do
  begin
    Result := Result + PrvStr[i];
    Inc(i);
  end;
end;
{$IFDEF JOPTSET}
{$J- }
{$ENDIF JOPTSET}
{$UNDEF JOPTSET}

type
  TAccessComboBox = class(TCustomComboBox);

procedure SetXPComboStyle(AControl:TControl);
var i:integer;
begin
  if (AControl is TWinControl) then
    for i := 0 to TWinControl(AControl).ControlCount - 1 do
    begin
      if TWinControl(AControl).Controls[i] is TCustomComboBox then
      begin
        if IsAppThemed {Win32PlatformIsXP} then
          TAccessComboBox(TWinControl(AControl).Controls[i]).BevelKind := bkNone
        else
          TAccessComboBox(TWinControl(AControl).Controls[i]).BevelKind := bkFlat;
      end;
      if TWinControl(AControl).Controls[i] is TWinControl then
        SetXPComboStyle(TWinControl(TWinControl(AControl).Controls[i]));
    end;
end;

initialization

finalization
  SaveAndFreeOptions;
  FreeAndNil(FLanguageFile);

end.

