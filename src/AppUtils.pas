{@abstract(Utility functions and procedures) }
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
function DetectEncoding(const FileName: string): TEncoding;
function GetAppVersion: string;
// TODO: add JvCreateProcess from JVCL to add support for capturing output?

function ActionShortCutInUse(AM: TActionList; ShortCut: Word): boolean;
function FindActionShortCut(AM: TActionList; ShortCut: Word): TCustomAction;
function RemoveActionShortCut(AM: TActionList; ShortCut: Word): integer;
function Translate(const ASection, AMsg: WideString): WideString;
function MyShortCutToText(ShortCut: TShortCut): WideString;
function BinarySearch(AList: TList; L, R: integer; CompareItem: Pointer; CompareFunc: TListSortCompare; var Index: integer): boolean;

function GlobalLanguageFile: TAppLanguage;
function GlobalAppOptions: TAppOptions;
function GetUserAppDataFolder(const Default: string): string;
function GetUserShortcutFile: string;
function GetUserAppOptionsFile: string;

procedure HandleFileCreateException(Sender: TObject; E: Exception; const Filename: string);
function GetSpecialFolderLocation(const Folder: Integer): string;
function GetAppStoragePath: string;
function AutoDetectCharacterSet(Stream:TStream):TEncoding;overload;
function AutoDetectCharacterSet(const Filename:string):TEncoding;overload;
function AutoDetectCharacterSet(const S:WideString):TEncoding;overload;
function FileCharSetToEncoding(CharSet:TTntStreamCharSet):TEncoding;


implementation
uses
  Windows, Forms, Dialogs, Math,
  Registry, IniFiles, StrUtils, Menus, Consts, ShFolder,
  TntSysUtils, CommonUtils, ShlObj, ActiveX;

var
  FLanguageFile: TAppLanguage = nil;
  FAppOptions: TAppOptions = nil;

function AutoDetectCharacterSet(Stream:TStream):TEncoding;
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

function AutoDetectCharacterSet(const Filename:string):TEncoding;
var F:TTntFileStream;
begin
  F := TTntFileStream.Create(Filename, fmOpenRead or fmShareDenyNone);
  try
    Result := AutoDetectCharacterSet(F);
  finally
    F.Free;
  end;
end;

function AutoDetectCharacterSet(const S:WideString):TEncoding;
var T:TStringStream;
begin
  T := TStringStream.Create(S);
  try
    Result := AutoDetectCharacterSet(T);
  finally
    T.Free;
  end;
end;
function FileCharSetToEncoding(CharSet:TTntStreamCharSet):TEncoding;
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

function GetUserAppDataFolder(const Default: string): string;
begin
  SetLength(Result, MAX_PATH + 1);
  if not Succeeded(SHGetFolderPath(0, CSIDL_APPDATA, 0, 0, PChar(Result))) then
    Result := '';
  if Result = '' then
    Result := Default;
  Result := string(PChar(Result));
end;

function GetUserShortcutFile: string;
begin
  Result := GetUserAppDataFolder('');
  if Result <> '' then
    Result := IncludeTrailingPathDelimiter(Result) + 'IniTranslator'
  else
    Result := ExtractFilePath(Application.ExeName);
  ForceDirectories(Result);
  Result := IncludeTrailingPathDelimiter(Result) + 'translator.alf';
end;

function GetUserAppOptionsFile: string;
begin
  Result := GetUserAppDataFolder('');
  if Result <> '' then
    Result := IncludeTrailingPathDelimiter(Result) + 'IniTranslator'
  else
    Result := ExtractFilePath(Application.ExeName);
  ForceDirectories(Result);
  Result := IncludeTrailingPathDelimiter(Result) + 'translator.ini';
end;

function Translate(const ASection, AMsg: WideString): WideString;
begin
  if GlobalLanguageFile <> nil then
    Result := GlobalLanguageFile.Translate(ASection, AMsg, AMsg)
  else
    Result := AMsg;
end;

function AnsiUpperCaseFirst(const S: WideString): WideString;
var i: integer;
begin
  if S = '' then
    Result := ''
  else
    Result := AnsiUpperCase(S[1]) + AnsiLowerCase(Copy(S, 2, MaxInt));
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
  Result := AnsiUpperCaseFirst(Result);
end;

function DetectEncoding(const FileName: string): TEncoding;
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
var ini:TIniFile;
begin
  ini := TIniFile.Create(GetUserAppOptionsFile);
  try
    MRU.LoadFromIni(ini, cIniMRUKey);
  finally
    ini.Free;
  end;
end;

procedure TBMRUSaveToIni(MRU: TTBXMRUList);
var ini:TIniFile;
begin
  ini := TIniFile.Create(GetUserAppOptionsFile);
  try
    MRU.SaveToIni(ini, cIniMRUKey);
  finally
    ini.Free;
  end;
end;

function GetAppVersion: string;
var
  FileName: string;
  InfoSize, Wnd: DWORD;
  VerBuf: Pointer;
  FI: PVSFixedFileInfo;
  VerSize: DWORD;
begin
  Result := '1.0.0.0';
  FileName := Application.ExeName;
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Wnd);
  if InfoSize <> 0 then
  begin
    GetMem(VerBuf, InfoSize);
    try
      if GetFileVersionInfo(PChar(FileName), Wnd, InfoSize, VerBuf) then
        if VerQueryValue(VerBuf, '\', Pointer(FI), VerSize) then
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

procedure HandleFileCreateException(Sender: TObject; E: Exception; const Filename: string);
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

function PidlToPath(IdList: PItemIdList): string;
begin
  SetLength(Result, MAX_PATH);
  if SHGetPathFromIdList(IdList, PChar(Result)) then
    Result := WideString(PChar(Result))
  else
    Result := '';
end;

function GetSpecialFolderLocation(const Folder: Integer): string;
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

function GetAppStoragePath: string;
begin
  // try to get path to \Documents and Settings\<user>\Application Data
  // if that fails, use application install folder
  Result := GetSpecialFolderLocation(CSIDL_APPDATA);
  if Result = '' then
    Result := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))
  else
    Result := IncludeTrailingPathDelimiter(Result) + 'IniTranslator\';
  ForceDirectories(Result);
end;

initialization

finalization
  SaveAndFreeOptions;
  FreeAndNil(FLanguageFile);

end.
