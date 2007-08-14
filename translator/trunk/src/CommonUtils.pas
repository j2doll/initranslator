{@abstract(Common Utility Functions) }
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
unit CommonUtils;
{$I TRANSLATOR.INC}

interface
uses
  Windows, SysUtils, Controls, Classes, TntClasses;

procedure InfoMsg(const AText, ACaption:WideString);
procedure AboutMsg(const AText, ACaption:WideString);
procedure ErrMsg(const AText, ACaption:WideString);
function YesNo(const AText, ACaption:WideString):boolean;
function YesNoCancel(const AText, ACaption:WideString):integer;
function WideMessageBox(hWnd:HWND; lpText, lpCaption:PWideChar; uType:UINT):Integer;

function GetCmdSwitchValue(const Switch:AnsiString; SwitchChars:TSysCharSet; var Value:AnsiString; IgnoreCase:boolean):boolean;
function ScreenCursor(ACursor:TCursor):IInterface;
function WaitCursor:IInterface;

function StripChars(const S:AnsiString; Ch:TSysCharSet):AnsiString; overload;
function StripChars(const S:WideString; const Ch:WideString):WideString; overload;
function SysDir:WideString;
function WinDir:WideString;

function MatchesString(const SubStr, Str:WideString; WholeLine, CaseSense, Fuzzy:boolean):boolean;
function StripKey(const S, StripChars:WideString; ReallyStrip:boolean):WideString;
procedure StripKeys(Strings:TTntStrings; StripChars:WideString; ReallyStrip:boolean);
function trimCRLFRight(const S:WideString):WideString;
function strBetween(const S:WideString; StartChar, EndChar:WideChar):WideString;
function StrDefault(const S, Default:WideString):WideString;

function MyWideDequotedStr(const S:WideString; Quote:WideChar):WideString;
function AutoWideDequotedStr(const S:WideString):WideString;
function MyWideQuotedStr(const S:WideString; Quote:WideChar):WideString;

function GetMinimizedFilename(const AFilename:WideString; Minimize:boolean):WideString;
function DoubleQuoteString(const S:WideString; CheckString:boolean = true):WideString;
function RunProcess(const Filename, Params:WideString; WorkingDir:WideString;
  const WaitUntilTerminated, WaitUntilIdle:Boolean; const ShowCmd:Integer; var ResultCode:Cardinal):Boolean;
function GetSpecialFolderLocation(const Folder:Integer):WideString;
function WideSHGetFolderPath(hwnd:HWND; csidl:Integer; hToken:THandle; dwFlags:DWord; pszPath:PWideChar):HRESULT;
function IsFileOpen(const Filename:WideString):boolean;

function SubStrCount(const SubStr, Str:WideString):integer;
function WideContainsChar(Ch:WideChar; const S:WideString):boolean;
function IsCharPunct(const S:WideChar):boolean;
function IsCharUpper(const S:WideChar):boolean;
function IsCharLower(const S:WideChar):boolean;
function IsCharDigit(const S:WideChar):boolean;
function IsCharSpace(const S:WideChar):boolean;
function IsCharControl(const S:WideChar):boolean;
function IsCharBlank(const S:WideChar):boolean;
function IsCharHex(const S:WideChar):boolean;
function IsCharAlpha(const S:WideChar):boolean;

function GetClipboardString(const Section, Name, Value:WideString):WideString;
function ParseClipboardString(const Str:WideString; out Section, Name, Value:WideString):boolean;

// for Delphi 6
function ValueFromIndex(S:TTntStrings; i:integer):WideString; overload;
function ValueFromIndex(S:TStrings; i:integer):AnsiString; overload;
function strtok(Search, Delim:WideString):WideString;

function WideStartsText(const ASubText, AText:WideString):Boolean;
function WideEndsText(const ASubText, AText:WideString):Boolean;

function BinarySearch(AList:TList; L, R:integer; CompareItem:Pointer; CompareFunc:TListSortCompare; var Index:integer):boolean;

implementation
uses
  Forms, Dialogs, Math, Registry, StrUtils,
  ShlObj, ActiveX, ShFolder,
  TntWindows, TntSysUtils, {$IFDEF COMPILER_9_UP}WideStrUtils{$ELSE}TntWideStrUtils{$ENDIF};

function AutoWideDequotedStr(const S:WideString):WideString;
begin
  if (Length(S) > 1) and (S[1] in [WideChar(''''), WideChar('"')]) and
  (S[Length(S)] in [WideChar(''''), WideChar('"')]) then
    Result := MyWideDequotedStr(S, S[1])
  else
    Result := S;
end;

function MyWideDequotedStr(const S:WideString; Quote:WideChar):WideString;
// var LText:PWideChar;
begin
  if (S = '') or (Quote = #0) then
  begin
    Result := S;
    Exit;
  end;
  if (Length(S) > 1) and (S[1] = Quote) and (TntWideLastChar(S) = Quote) then
  begin
//    LText := PWideChar(S);
//    Result := WideExtractQuotedStr(LText, Quote);
    Result := Copy(S, 2, Length(S) - 2);
  end;
end;

function MyWideQuotedStr(const S:WideString; Quote:WideChar):WideString;
begin
  if (S = '') or (Quote = #0) then
    Result := S
  else
    Result := Quote + S + Quote;
end;

function StripChars(const S:AnsiString; Ch:TSysCharSet):AnsiString;
var
  i, j:integer;
begin
  Result := '';
  SetLength(Result, Length(S));
  j := 0;
  for i := 1 to Length(S) do
  begin
    if not (S[i] in Ch) then
    begin
      Inc(j);
      Result[j] := S[i];
    end;
  end;
  SetLength(Result, j);
end;

function StripChars(const S:WideString; const Ch:WideString):WideString; overload;
var
  i, j:integer;
begin
  Result := '';
  SetLength(Result, Length(S));
  j := 0;
  for i := 1 to Length(S) do
  begin
    if Pos(S[i], Ch) > 0 then
    begin
      Inc(j);
      Result[j] := S[i];
    end;
  end;
  SetLength(Result, j);
end;

function trimCRLFRight(const S:WideString):WideString;
var
  i:integer;
begin
  Result := S;
  i := Length(Result);
  while (i >= 1) and (Result[i] in [WideChar(#10), WideChar(#13)]) do
    Dec(i);
  if i >= 0 then
    SetLength(Result, i);
end;

function WideMessageBox(hWnd:HWND; lpText, lpCaption:PWideChar; uType:UINT):Integer;
begin
  if Win32PlatformIsUnicode then
    Result := MessageBoxW(hWnd, lpText, lpCaption, uType)
  else
    Result := MessageBoxA(hWnd, PAnsiChar(string(lpText)), PAnsiChar(string(lpCaption)), uType);
end;

procedure InfoMsg(const AText, ACaption:WideString);
begin
  WideMessageBox(GetFocus, PWideChar(AText), PWideChar(ACaption), MB_OK or MB_ICONINFORMATION)
end;

procedure AboutMsg(const AText, ACaption:WideString);
var
  ParamsW:TMsgBoxParamsW;
  ParamsA:TMsgBoxParamsA;
begin
  // if there's no icon, display an info box instead
  if FindResource(hInstance, PAnsiChar('MAINICON'), RT_GROUP_ICON) = 0 then
  begin
    InfoMsg(AText, ACaption);
    Exit;
  end;

  // use app icon, different code dependning on platform
  // (is this more complicated than it ought to be or am I just lazy)?
  if Win32PlatformIsUnicode then
  begin
    FillChar(ParamsW, sizeof(TMsgBoxParamsW), 0);
    with ParamsW do
    begin
      cbSize := sizeof(TMsgBoxParamsW);
      hwndOwner := GetActiveWindow;
      hInstance := SysInit.hInstance;
      lpszText := PWideChar(AText);
      lpszCaption := PWideChar(ACaption);
      dwStyle := MB_OK or MB_USERICON;
      lpszIcon := PWideChar(WideString('MAINICON'));
      dwContextHelpId := 0;
      lpfnMsgBoxCallback := nil;
      dwLanguageId := GetUserDefaultLangID;
      MessageBoxIndirectW(ParamsW);
    end
  end
  else
  begin
    FillChar(ParamsA, sizeof(TMsgBoxParamsA), 0);
    with ParamsA do
    begin
      cbSize := sizeof(TMsgBoxParamsA);
      hwndOwner := GetActiveWindow;
      hInstance := SysInit.hInstance;
      lpszText := PAnsiChar(AnsiString(AText));
      lpszCaption := PAnsiChar(AnsiString(ACaption));
      dwStyle := MB_OK or MB_USERICON;
      lpszIcon := PAnsiChar('MAINICON');
      dwContextHelpId := 0;
      lpfnMsgBoxCallback := nil;
      dwLanguageId := GetUserDefaultLangID;
      MessageBoxIndirectA(ParamsA);
    end;
  end;
end;

procedure ErrMsg(const AText, ACaption:WideString);
begin
  WideMessageBox(GetFocus, PWideChar(AText), PWideChar(ACaption), MB_OK or MB_ICONERROR)
end;

function YesNo(const AText, ACaption:WideString):boolean;
begin
  Result := WideMessageBox(GetFocus, PWideChar(AText), PWideChar(ACaption), MB_YESNO or MB_ICONQUESTION) = IDYES
end;

function YesNoCancel(const AText, ACaption:WideString):integer;
begin
  Result := WideMessageBox(GetFocus, PWideChar(AText), PWideChar(ACaption), MB_YESNOCANCEL or MB_ICONQUESTION)
end;

function GetCmdSwitchValue(const Switch:AnsiString; SwitchChars:TSysCharSet; var
  Value:AnsiString; IgnoreCase:boolean):boolean;
var
  i:integer;
  S:AnsiString;
begin
  Result := false;
  for i := 1 to ParamCount do
  begin
    S := ParamStr(i);
    if (SwitchChars = []) or (S[1] in SwitchChars) then
    begin
      if IgnoreCase then
        Result := InRange(Pos(AnsiUpperCase(Switch), AnsiUpperCase(S)), 1, 2)
      else
        Result := InRange(Pos(Switch, S), 1, 2);
      if Result then
      begin
        Value := trim(Copy(S, Length(Switch) + Ord(SwitchChars <> []) + 1, MaxInt));
        Exit;
      end;
    end;
  end;
end;

type
  TScreenCursor = class(TInterfacedObject, IInterface)
  private
    FCursor:TCursor;
  public
    constructor Create(ACursor:TCursor);
    destructor Destroy; override;
  end;

  { TScreenCursor }

constructor TScreenCursor.Create(ACursor:TCursor);
begin
  inherited Create;
  FCursor := Screen.Cursor;
  Screen.Cursor := ACursor;
end;

destructor TScreenCursor.Destroy;
begin
  Screen.Cursor := FCursor;

  inherited;
end;

function ScreenCursor(ACursor:TCursor):IInterface;
begin
  Result := TScreenCursor.Create(ACursor);
end;

function WaitCursor:IInterface;
begin
  Result := ScreenCursor(crHourGlass);
end;

function SysDir:WideString;
var
  buf:array[0..MAX_PATH] of WideChar;
begin
  SetString(Result, buf, Tnt_GetSystemDirectoryW(buf, sizeof(buf)));
end;

function WinDir:WideString;
var
  buf:array[0..MAX_PATH] of WideChar;
begin
  SetString(Result, buf, Tnt_GetWindowsDirectoryW(buf, sizeof(buf)));
end;

function MatchesString(const SubStr, Str:WideString; WholeLine, CaseSense, Fuzzy:boolean):boolean;

  function MakeFuzzy(const S:WideString):WideString;
  var
    i:integer;
    W:Word;
    tmp:WideChar;
  begin
    if not Fuzzy then
      Result := S
    else
    begin
      Result := '';
      for i := 1 to Length(S) do
      begin
        tmp := S[i];
        if GetStringTypeEx(LOCALE_USER_DEFAULT, CT_CTYPE1, @tmp, 1, W) and
          (W and C1_ALPHA = C1_ALPHA) then
          Result := Result + S[i];
      end;
    end;

  end;
begin
  if WholeLine then
  begin
    if CaseSense then
      Result := WideSameStr(MakeFuzzy(Str), MakeFuzzy(SubStr))
    else
      Result := WideSameText(MakeFuzzy(Str), MakeFuzzy(SubStr));
  end
  else
  begin
    if CaseSense then
      Result := AnsiContainsStr(MakeFuzzy(Str), MakeFuzzy(SubStr))
    else
      Result := AnsiContainsText(MakeFuzzy(Str), MakeFuzzy(SubStr));
  end;
end;

function StripKey(const S, StripChars:WideString; ReallyStrip:boolean):WideString;
var
  i, j:integer;
begin
  Result := S;
  if ReallyStrip then
  begin
    j := 0;
    for i := 1 to Length(S) do
    begin
      if Pos(S[i], StripChars) = 0 then
      begin
        Inc(j);
        Result[j] := S[i];
      end;
    end;
    SetLength(Result, j);
  end;
end;

procedure StripKeys(Strings:TTntStrings; StripChars:WideString; ReallyStrip:boolean);
var
  i:integer;
begin
  if ReallyStrip then
  begin
    for i := 0 to Strings.Count - 1 do
      Strings[i] := StripKey(Strings[i], StripChars, true);
  end;
end;

function strBetween(const S:WideString; StartChar, EndChar:WideChar):WideString;
var
  i, AStart, AEnd:integer;
begin
  AStart := 0;
  AEnd := 0;
  for i := 1 to Length(S) do
    if S[i] = StartChar then
      AStart := i + 1
    else if S[i] = EndChar then
    begin
      AEnd := i;
      Break;
    end;
  if (AStart > 0) and (AEnd > 0) and (AEnd > AStart) then
    Result := Copy(S, AStart, AEnd - AStart)
  else
    Result := '';
end;

function StrDefault(const S, Default:WideString):WideString;
begin
  if S = '' then
    Result := Default
  else
    Result := S;
end;

function GetMinimizedFilename(const AFilename:WideString; Minimize:boolean):WideString;
begin
  if Minimize then
    Result := WideChangeFileExt(WideExtractFileName(AFilename), '')
  else
    Result := AFilename;
end;

function DoubleQuoteString(const S:WideString; CheckString:boolean = true):WideString;
begin
  if not CheckString or (Pos(' ', S) > 0) then
    Result := WideQuotedStr(S, '"')
  else
    Result := S;
end;

procedure ProcessMessage;
var
  M:TMsg;
begin
  while PeekMessage(M, 0, 0, 0, PM_REMOVE) do
  begin
    TranslateMessage(M);
    DispatchMessage(M);
  end;
end;

// from Inno Setup

function RunProcess(const Filename, Params:WideString; WorkingDir:WideString;
  const WaitUntilTerminated, WaitUntilIdle:Boolean; const ShowCmd:Integer; var ResultCode:Cardinal):Boolean;
var
  CmdLine:WideString;
  WorkingDirP:PWideChar;
  StartupInfo:TStartupInfoW;
  ProcessInfo:TProcessInformation;
begin
  Result := False;
  CmdLine := DoubleQuoteString(Filename);
  if Params <> '' then
    CmdLine := CmdLine + ' ' + Params;
  if WorkingDir = '' then
    WorkingDir := WideExcludeTrailingPathDelimiter(WideExtractFilePath(Filename));
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := ShowCmd;
  if WorkingDir <> '' then
    WorkingDirP := PWideChar(WorkingDir)
  else
    WorkingDirP := nil;
  if not Tnt_CreateProcessW(nil, PWideChar(CmdLine), nil, nil, False, 0, nil,
    WorkingDirP, StartupInfo, ProcessInfo) then
  begin
    ResultCode := GetLastError;
    Exit;
  end;
  with ProcessInfo do
  try
    CloseHandle(hThread);
    if WaitUntilIdle then
      WaitForInputIdle(hProcess, INFINITE);
    if WaitUntilTerminated then
      { Wait until the process returns, but still process any messages that
        arrive. }
      while true do
      begin
        ProcessMessage;
        case MsgWaitForMultipleObjects(1, hProcess, False, INFINITE, QS_ALLINPUT) of
          WAIT_OBJECT_0:
            Break;
          WAIT_OBJECT_0 + 1:
            ProcessMessage;
          WAIT_FAILED:
            Exit;
        end;
      end;
    { Get the exit code. Will be set to STILL_ACTIVE if not yet available }
    { Then close the process handle }
  finally
    GetExitCodeProcess(hProcess, DWORD(ResultCode));
    CloseHandle(hProcess);
  end;
  Result := True;
end;

function PidlFree(var IdList:PItemIdList):Boolean;
var
  Malloc:IMalloc;
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

function PidlToPath(IdList:PItemIdList):WideString;
begin
  SetLength(Result, MAX_PATH);
  if Tnt_SHGetPathFromIDListW(IdList, PWideChar(Result)) then
    Result := WideString(PWideChar(Result))
  else
    Result := '';
end;

function GetSpecialFolderLocation(const Folder:Integer):WideString;
var
  FolderPidl:PItemIdList;
begin
  if Succeeded(SHGetSpecialFolderLocation(0, Folder, FolderPidl)) then
  begin
    Result := PidlToPath(FolderPidl);
    PidlFree(FolderPidl);
  end
  else
    Result := '';
end;

function SHGetFolderPathW2(hwnd:HWND; csidl:Integer; hToken:THandle; dwFlags:DWord; pszPath:PWideChar):HRESULT; stdcall; external 'SHFolder.dll' name 'SHGetFolderPathW';

function WideSHGetFolderPath(hwnd:HWND; csidl:Integer; hToken:THandle; dwFlags:DWord; pszPath:PWideChar):HRESULT;
var
  AnsiBuff:AnsiString;
begin
  if Win32PlatformIsUnicode then
    Result := SHGetFolderPathW2(hwnd, csidl, hToken, dwFlags, pszPath)
  else
  begin
    SetLength(AnsiBuff, MAX_PATH * 2);
    Result := SHGetFolderPathA(hwnd, csidl, hToken, dwFlags, PAnsiChar(AnsiBuff));
    AnsiBuff := AnsiString(PAnsiChar(AnsiBuff));
    WStrPLCopy(pszPath, AnsiBuff, Length(AnsiBuff));
  end;
end;

function IsFileOpen(const Filename:WideString):boolean;
var
  hFile:THandle;
  aLastError, aOldErrorMode:DWORD;
begin
  Result := false;
  // don't display dialog when accessing removable drives without media
  aOldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  try
    hFile := Tnt_CreateFileW(PWideChar(Filename), OPEN_EXISTING, 0, nil, 0, 0, 0);
    try
      if hFile = INVALID_HANDLE_VALUE then
      begin
        // get error...
        aLastError := GetLastError;
        // check error...
        Result := aLastError = ERROR_SHARING_VIOLATION;
        // restore error
        SetLastError(aLastError);
      end;
    finally
      if hFile <> INVALID_HANDLE_VALUE then
        CloseHandle(hFile);
    end;
  finally
    SetErrorMode(aOldErrorMode);
  end;
end;

function SubStrCount(const SubStr, Str:WideString):integer;
var
  tmp:PWideChar;
begin
  Result := 0;
  if (Length(SubStr) = 0) or (Length(Str) = 0) then
    Exit;
  tmp := WStrPos(PWideChar(Str), PWideChar(SubStr));
  while tmp <> nil do
  begin
    Inc(Result);
    Inc(tmp, Length(SubStr));
    tmp := WStrPos(tmp, PWideChar(SubStr));
  end;
end;

function WideContainsChar(Ch:WideChar; const S:WideString):boolean;
var
  i:integer;
begin
  for i := 1 to Length(S) do
    if Ch = S[i] then
    begin
      Result := true;
      Exit;
    end;
  Result := false;
end;

function IsCharType(const S:WideChar; InfoType, AType:Cardinal):boolean;
var
  CharType:integer;
begin
  if (S <> WideChar(#0)) and GetStringTypeExW(LOCALE_USER_DEFAULT, InfoType, @S, 1, CharType) then
    Result := CharType and AType = AType
  else
    Result := false;
end;

function IsCharPunct(const S:WideChar):boolean;
begin
  Result := IsCharType(S, CT_CTYPE1, C1_PUNCT);
end;

function IsCharUpper(const S:WideChar):boolean;
begin
  Result := IsCharType(S, CT_CTYPE1, C1_UPPER);
end;

function IsCharLower(const S:WideChar):boolean;
begin
  Result := IsCharType(S, CT_CTYPE1, C1_LOWER);
end;

function IsCharDigit(const S:WideChar):boolean;
begin
  Result := IsCharType(S, CT_CTYPE1, C1_DIGIT);
end;

function IsCharSpace(const S:WideChar):boolean;
begin
  Result := IsCharType(S, CT_CTYPE1, C1_SPACE);
end;

function IsCharControl(const S:WideChar):boolean;
begin
  Result := IsCharType(S, CT_CTYPE1, C1_CNTRL);
end;

function IsCharBlank(const S:WideChar):boolean;
begin
  Result := IsCharType(S, CT_CTYPE1, C1_BLANK);
end;

function IsCharHex(const S:WideChar):boolean;
begin
  Result := IsCharType(S, CT_CTYPE1, C1_XDIGIT);
end;

function IsCharAlpha(const S:WideChar):boolean;
begin
  Result := IsCharType(S, CT_CTYPE1, C1_ALPHA);
end;

function GetClipboardString(const Section, Name, Value:WideString):WideString;
var
  S:TTntStringlist;
begin
  S := TTntStringlist.Create;
  try
    S.Add(Section);
    S.Add(Name);
    S.Add(Value);
    Result := S.CommaText;
  finally
    S.Free;
  end;
end;

function ParseClipboardString(const Str:WideString; out Section, Name, Value:WideString):boolean;
var
  S:TTntStringlist;
begin
  S := TTntStringlist.Create;
  try
    S.CommaText := Str;
    if S.Count > 0 then
      Section := S[0]
    else
      Section := '';
    if S.Count > 1 then
      Name := S[1]
    else
      Name := '';
    if S.Count > 2 then
      Value := S[2]
    else
      Value := '';
    Result := S.Count > 2;
  finally
    S.Free;
  end;
end;

function ValueFromIndex(S:TTntStrings; i:integer):WideString;
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

function ValueFromIndex(S:TStrings; i:integer):AnsiString;
var
  tmp:TTntStringlist;
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

function strtok(Search, Delim:WideString):WideString;
const

  I:integer = 1;
  Len:integer = 0;
  PrvStr:WideString = '';
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

function WideStartsText(const ASubText, AText:WideString):Boolean;
begin
  if (ASubText <> '') and (AText <> '') then
    Result := WideSameText(ASubText, Copy(AText, 1, Length(ASubText)))
  else
    Result := false;
end;

function WideEndsText(const ASubText, AText:WideString):Boolean;
var
  L:integer;
begin
  if not Win32PlatformIsUnicode then
    Result := AnsiEndsText(ASubText, AText)
  else
  begin
    L := Length(AText) - Length(ASubText);
    if (L > 0) and (ASubText <> '') then
      Result := WideSameText(ASubText, Copy(AText, L + 1, MaxInt))
    else
      Result := false;
  end;
end;

function BinarySearch(AList:TList; L, R:integer; CompareItem:Pointer; CompareFunc:TListSortCompare; var Index:integer):boolean;
var
  M:integer;
  CompareResult:integer;
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

end.
