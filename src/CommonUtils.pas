{@abstract(Common Utility Functions) }
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
// $Id: $
unit CommonUtils;

interface
uses
  SysUtils, Controls, Classes;

procedure InfoMsg(const AText, ACaption: WideString);
procedure AboutMsg(const AText, ACaption: WideString);
procedure ErrMsg(const AText, ACaption: WideString);
function YesNo(const AText, ACaption: WideString): boolean;
function YesNoCancel(const AText, ACaption: WideString): integer;

function GetCmdSwitchValue(const Switch: string; SwitchChars: TSysCharSet;
  var Value: string; IgnoreCase: boolean): boolean;
function ScreenCursor(ACursor: TCursor): IUnknown;
function WaitCursor: IUnknown;

function StripChars(const S: string; Ch: TSysCharSet): string; overload;
function StripChars(const S: WideString; const Ch: WideString): WideString; overload;
function SysDir: string;
function WinDir: string;

function MatchesString(const SubStr, Str: WideString; WholeLine, CaseSense, Fuzzy: boolean): boolean;
function StripKey(const S, StripChars: WideString; ReallyStrip: boolean): WideString;
procedure StripKeys(Strings: TStrings; StripChars: WideString; ReallyStrip: boolean);
function trimCRLFRight(const S: WideString): WideString;
function strBetween(const S: WideString; StartChar, EndChar: WideChar): WideString;
function StrDefault(const S, Default: WideString): WideString;

function MyWideDequotedStr(const S: WideString; Quote: WideChar): WideString;
function MyWideQuotedStr(const S: WideString; Quote: WideChar): WideString;
function GetMinimizedFilename(const AFilename: string; Minimize: boolean): string;
function DoubleQuoteString(const S: WideString; CheckString: boolean = true): WideString;

function RunProcess(const Filename, Params: string; WorkingDir: string;
  const WaitUntilTerminated, WaitUntilIdle: Boolean; const ShowCmd: Integer; var ResultCode: Cardinal): Boolean;
function SubStrCount(const SubStr, Str: WideString): integer;
function WideContainsChar(Ch: WideChar; const S: WideString): boolean;
function IsCharPunct(const S:WideChar):boolean;


implementation
uses
  Windows, Forms, Dialogs, Math, Registry, StrUtils, TntSysUtils;

function MyWideDequotedStr(const S: WideString; Quote: WideChar): WideString;
// var LText:PWideChar;
begin
  if (S = '') or (Quote = #0) then
  begin
    Result := S;
    Exit;
  end;
  if (Length(S) > 1) and (S[1] = Quote) and (WideLastChar(S) = Quote) then
  begin
//    LText := PWideChar(S);
//    Result := WideExtractQuotedStr(LText, Quote);
    Result := Copy(S, 2, Length(S) - 2);
  end;
end;

function MyWideQuotedStr(const S: WideString; Quote: WideChar): WideString;
begin
  if (S = '') or (Quote = #0) then
    Result := S
  else
    Result := Quote + S + Quote;
end;

function StripChars(const S: string; Ch: TSysCharSet): string;
var
  i, j: integer;
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

function StripChars(const S: WideString; const Ch: WideString): WideString; overload;
var
  i, j: integer;
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

function trimCRLFRight(const S: WideString): WideString;
begin
  Result := trimRight(StringReplace(S, #13#10, ' ', [rfReplaceAll]));
end;

procedure InfoMsg(const AText, ACaption: WideString);
begin
  if Win32PlatformIsUnicode then
    MessageBoxW(GetFocus, PWideChar(AText), PWideChar(ACaption), MB_OK or MB_ICONINFORMATION)
  else
    MessageBox(GetFocus, PChar(string(AText)), PChar(string(ACaption)), MB_OK or MB_ICONINFORMATION);
end;

procedure AboutMsg(const AText, ACaption: WideString);
var
  ParamsW: TMsgBoxParamsW;
  ParamsA: TMsgBoxParamsA;
begin
  // if there's no icon, display an info box instead
  if FindResource(hInstance, PChar('MAINICON'), RT_GROUP_ICON) = 0 then
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
      lpszText := PWideChar(WideString(AText));
      lpszCaption := PWideChar(WideString(ACaption));
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
      lpszText := PChar(string(AText));
      lpszCaption := PChar(string(ACaption));
      dwStyle := MB_OK or MB_USERICON;
      lpszIcon := PChar('MAINICON');
      dwContextHelpId := 0;
      lpfnMsgBoxCallback := nil;
      dwLanguageId := GetUserDefaultLangID;
      MessageBoxIndirectA(ParamsA);
    end;
  end;
end;

procedure ErrMsg(const AText, ACaption: WideString);
begin
  if Win32PlatformIsUnicode then
    MessageBoxW(GetFocus, PWideChar(AText), PWideChar(ACaption), MB_OK or MB_ICONERROR)
  else
    MessageBox(GetFocus, PChar(string(AText)), PChar(string(ACaption)), MB_OK or MB_ICONERROR);
end;

function YesNo(const AText, ACaption: WideString): boolean;
begin
  if Win32PlatformIsUnicode then
    Result := MessageBoxW(GetFocus, PWideChar(AText), PWideChar(ACaption), MB_YESNO or MB_ICONQUESTION) = IDYES
  else
    Result := MessageBox(GetFocus, PChar(string(AText)), PChar(string(ACaption)), MB_YESNO or MB_ICONQUESTION) = IDYES
end;

function YesNoCancel(const AText, ACaption: WideString): integer;
begin
  if Win32PlatformIsUnicode then
    Result := MessageBoxW(GetFocus, PWideChar(AText), PWideChar(ACaption), MB_YESNOCANCEL or MB_ICONQUESTION)
  else
    Result := MessageBox(GetFocus, PChar(string(AText)), PChar(string(ACaption)), MB_YESNOCANCEL or MB_ICONQUESTION);
end;

function GetCmdSwitchValue(const Switch: string; SwitchChars: TSysCharSet; var
  Value: string; IgnoreCase: boolean): boolean;
var
  i: integer;
  S: string;
begin
  Result := false;
  for i := 1 to ParamCount do
  begin
    S := ParamStr(i);
    if (SwitchChars = []) or (S[1] in SwitchChars) then
    begin
      if IgnoreCase then
        Result := InRange(AnsiPos(AnsiUpperCase(Switch), AnsiUpperCase(S)), 1, 2)
      else
        Result := InRange(AnsiPos(Switch, S), 1, 2);
      if Result then
      begin
        Value := trim(Copy(S, Length(Switch) + Ord(SwitchChars <> []) + 1, MaxInt));
        Exit;
      end;
    end;
  end;
end;

type
  TScreenCursor = class(TInterfacedObject, IUnknown)
  private
    FCursor: TCursor;
  public
    constructor Create(ACursor: TCursor);
    destructor Destroy; override;
  end;

  { TScreenCursor }

constructor TScreenCursor.Create(ACursor: TCursor);
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

function ScreenCursor(ACursor: TCursor): IUnknown;
begin
  Result := TScreenCursor.Create(ACursor);
end;

function WaitCursor: IUnknown;
begin
  Result := ScreenCursor(crHourGlass);
end;

function SysDir: string;
var
  buf: array[0..MAX_PATH] of char;
begin
  SetString(Result, buf, GetSystemDirectory(buf, sizeof(buf)));
end;

function WinDir: string;
var
  buf: array[0..MAX_PATH] of char;
begin
  SetString(Result, buf, GetWindowsDirectory(buf, sizeof(buf)));
end;

function MatchesString(const SubStr, Str: WideString; WholeLine, CaseSense, Fuzzy: boolean): boolean;

  function MakeFuzzy(const S: WideString): WideString;
  var
    i: integer;
    W: Word;
    tmp: WideChar;
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

function StripKey(const S, StripChars: WideString; ReallyStrip: boolean): WideString;
var
  i, j: integer;
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

procedure StripKeys(Strings: TStrings; StripChars: WideString; ReallyStrip: boolean);
var
  i: integer;
begin
  if ReallyStrip then
  begin
    for i := 0 to Strings.Count - 1 do
      Strings[i] := StripKey(Strings[i], StripChars, true);
  end;
end;

function strBetween(const S: WideString; StartChar, EndChar: WideChar): WideString;
var
  i, AStart, AEnd: integer;
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

function StrDefault(const S, Default: WideString): WideString;
begin
  if S = '' then
    Result := Default
  else
    Result := S;
end;

function GetMinimizedFilename(const AFilename: string; Minimize: boolean): string;
begin
  if Minimize then
    Result := ChangeFileExt(ExtractFileName(AFilename), '')
  else
    Result := AFilename;
end;

function DoubleQuoteString(const S: WideString; CheckString: boolean = true): WideString;
begin
  if not CheckString or (Pos(' ', S) > 0) then
    Result := AnsiQuotedStr(S, '"')
  else
    Result := S;
end;

procedure ProcessMessage;
var
  M: TMsg;
begin
  while PeekMessage(M, 0, 0, 0, PM_REMOVE) do
  begin
    TranslateMessage(M);
    DispatchMessage(M);
  end;
end;

// from Inno Setup

function RunProcess(const Filename, Params: string; WorkingDir: string;
  const WaitUntilTerminated, WaitUntilIdle: Boolean; const ShowCmd: Integer; var ResultCode: Cardinal): Boolean;
var
  CmdLine: string;
  WorkingDirP: PChar;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  Result := False;
  CmdLine := DoubleQuoteString(Filename);
  if Params <> '' then
    CmdLine := CmdLine + ' ' + Params;
  if WorkingDir = '' then
    WorkingDir := ExcludeTrailingPathDelimiter(ExtractFilePath(Filename));
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := ShowCmd;
  if WorkingDir <> '' then
    WorkingDirP := PChar(WorkingDir)
  else
    WorkingDirP := nil;
  if not CreateProcess(nil, PChar(CmdLine), nil, nil, False, 0, nil,
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

function SubStrCount(const SubStr, Str: WideString): integer;
var tmp: PWideChar;
begin
  Result := 0;
  if (Length(SubStr) = 0) or (Length(Str) = 0) then
    Exit;
  tmp := StrPosW(PWideChar(Str), PWideChar(SubStr));
  while tmp <> nil do
  begin
    Inc(Result);
    Inc(tmp, Length(SubStr));
    tmp := StrPosW(tmp, PWideChar(SubStr));
  end;
end;

function WideContainsChar(Ch: WideChar; const S: WideString): boolean;
begin
  Result := SubStrCount(Ch, S) > 0;
end;

function IsCharPunct(const S:WideChar):boolean;
var
  CharType: integer;
begin
  if GetStringTypeExW(LOCALE_SYSTEM_DEFAULT, CT_CTYPE1, @S, 1, CharType) then
    Result := CharType and C1_PUNCT = C1_PUNCT
  else
    Result := false;
end;

end.

