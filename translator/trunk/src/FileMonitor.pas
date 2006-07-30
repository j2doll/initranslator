{@abstract(A file monitor class) }
{
  Copyright © 2003-2006 by Peter Thornqvist; all rights reserved

  Developer(s):
    p3 - peter3 att users dott sourceforge dott net

  Status:
   The contents of this file are subject to the Mozilla Public License Version
   1.1 (the "License"); you may not use this file except in compliance with the
   License. You may obtain a copy of the License at http://www.mozilla.org/MPL/

   Software distributed under the License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.
}
// $Id$
unit FileMonitor;
{$I TRANSLATOR.INC}

interface
uses
  Windows, Messages, SysUtils, Classes;

const
  WM_THREADRESUME = WM_USER + 101;

type
  TFileMonitorEvent = procedure(Sender: TObject; const Filename: WideString; var AContinue, AReset: boolean) of object;
  TFileMonitorThread = class(TThread)
  private
    FOnChange: TFileMonitorEvent;
    FFilename: WideString;
    FFileAge: integer;
    FTimeOut: integer;
    procedure Change; dynamic;
    procedure SetFilename(const Value: WideString);
  protected
    procedure Execute; override;
    // override these to check for other changes in the file (like attributes)
    // by default, it only checks for last modify date
    procedure InitMonitor; virtual;
    function HasChanged: boolean; virtual;

    procedure WmThreadResume(var Msg: TMessage); message WM_THREADRESUME;
  public
    constructor Create(const AFilename: WideString; ATimeOut: integer = 200);
    // changing the filename will reset the monitor thread (calls InitMonitor)
    property Filename: WideString read FFilename write SetFilename;
    property OnChange: TFileMonitorEvent read FOnChange write FOnChange;
  end;

implementation
uses
  TntSysUtils;
  
resourcestring
  SFmtMonitorFileNotFound = 'File "%s" not found: cannot monitor a nonexistent file!';

{ TFileMonitorThread }

procedure TFileMonitorThread.Change;
var
  AContinue, AReset: boolean;
begin
  AContinue := true; // by default, we want to continue monitoring
  AReset := true; // by default, we don't prompt again on this change
  if Assigned(FOnChange) and not Suspended and not Terminated then
    FOnChange(self, FFilename, AContinue, AReset);
  if not Terminated then
  begin
    if AReset then
      InitMonitor;
    if not AContinue then
      Terminate;
  end;
end;

constructor TFileMonitorThread.Create(const AFilename: WideString; ATimeOut: integer);
begin
  if (AFilename = '') or not WideFileExists(AFilename) then
    raise Exception.CreateFmt(SFmtMonitorFileNotFound, [AFilename]);

  inherited Create(true);
  Priority := tpLowest;
  Filename := AFilename;
  FFileAge := FileAge(Filename);
  FTimeOut := ATimeOut;
end;

procedure TFileMonitorThread.Execute;
begin
  while not Terminated and not Suspended do
  begin
    if not WideFileExists(FFilename) then
    begin
      Synchronize(Change); // file was deleted, so let user know
      Terminate;
      Exit;
    end
    else if HasChanged then
    begin
      Synchronize(Change);
      if Terminated or Suspended then
        Exit;
    end;
    sleep(FTimeOut);
  end;
end;

function TFileMonitorThread.HasChanged: boolean;
begin
  Result := FFileAge < FileAge(Filename);
end;

procedure TFileMonitorThread.InitMonitor;
begin
  FFileAge := FileAge(Filename);
end;

procedure TFileMonitorThread.SetFilename(const Value: WideString);
var
  DoResume: boolean;
begin
  if (Value = '') or not WideFileExists(Value) then
    raise Exception.CreateFmt(SFmtMonitorFileNotFound, [Value]);
  DoResume := not Suspended;
  if DoResume then
    Suspend;
  FFilename := Value;
  InitMonitor;
  if DoResume then
    Resume;
end;

procedure TFileMonitorThread.WmThreadResume(var Msg: TMessage);
begin
  if Suspended then
    Resume;
end;

end.
