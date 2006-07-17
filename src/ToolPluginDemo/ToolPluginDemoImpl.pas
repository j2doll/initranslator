{@abstract(Tool plugin demo implementation) }
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

// $Id:$
unit ToolPluginDemoImpl;

interface
uses
  TransIntf, Classes;

type
  TDemoPlugins = class(TInterfacedObject, IUnknown, IToolItems)
  public
    function Count: Integer; safecall;
    function ToolItem(Index: Integer; out ToolItem: IToolItem): HRESULT; safecall;
  end;

  TUppercaseDemoPlugin = class(TInterfacedObject, IUnknown, IToolItem)
  private
    FClicked: boolean;
    FOldAppHandle: Cardinal;
  public
    destructor Destroy; override;
    function About: WideString; safecall;
    function DisplayName: WideString; safecall;
    function Execute(const Items, Orphans: ITranslationItems): HRESULT; safecall;
    function Icon: Cardinal; safecall;
    procedure Init(AppHandle: Cardinal); safecall;
    function Status(const Items, Orphans: ITranslationItems): Integer; safecall;
  end;

  TLowercaseDemoPlugin = class(TInterfacedObject, IUnknown, IToolItem)
  private
    FClicked: boolean;
    FOldAppHandle: Cardinal;
  public
    destructor Destroy; override;
    function About: WideString; safecall;
    function DisplayName: WideString; safecall;
    function Execute(const Items: ITranslationItems;
      const Orphans: ITranslationItems): HRESULT; safecall;
    procedure Init(AppHandle: Cardinal); safecall;
    function Icon: Cardinal; safecall;
    function Status(const Items, Orphans: ITranslationItems): Integer; safecall;
  end;

implementation
uses
  Forms, Windows, SysUtils;

{ TDemoPlugins }

function TDemoPlugins.Count: Integer;
begin
  // tell main app how many we are
  Result := 2;
end;

function TDemoPlugins.ToolItem(Index: Integer; out ToolItem: IToolItem): HRESULT;
begin
  Result := S_OK;
  // return one of two plugins or error
  case Index of
    0:
      ToolItem := TUppercaseDemoPlugin.Create;
    1:
      ToolItem := TLowercaseDemoPlugin.Create;
  else
    Result := S_FALSE;
  end;
end;

{ TUppercaseDemoPlugin }

function TUppercaseDemoPlugin.About: WideString;
begin
  // tell us who you are
  // TODO: not yet used
  Result := 'This is a demo plugin that uppercases translations';
end;

destructor TUppercaseDemoPlugin.Destroy;
begin
  // restore original app handle
  if FOldAppHandle <> 0 then
    Application.Handle := FOldAppHandle;
  inherited Destroy;
  ;
end;

function TUppercaseDemoPlugin.DisplayName: WideString;
begin
  // this text is displayed on the menu item
  Result := 'Uppercase translations';
end;

function TUppercaseDemoPlugin.Execute(const Items, Orphans: ITranslationItems): HRESULT;
var
  i: integer;
  S: WideString;
begin
  for i := 0 to Items.Count - 1 do
  begin
    S := Items[i].Translation;
    Items[i].Translation := WideUpperCase(S);
    if not Items[i].Modified then
      Items[i].Modified := not WideSameStr(Items[i].Translation, S);
  end;
  FClicked := not FClicked;
end;

function TUppercaseDemoPlugin.Icon: Cardinal;
begin
  // load a standard icon for simplicity
  // return 0 if you don't have an icon
  Result := LoadIcon(0, IDI_QUESTION);
end;

procedure TUppercaseDemoPlugin.Init(AppHandle: Cardinal);
begin
  // save old app hanlde and set new app handle
  // this is in case we need to display a dialog or similar
  // using AppHandle makes the dialog behave better with the main app
  FOldAppHandle := Application.Handle;
  Application.Handle := AppHandle;
end;

function TUppercaseDemoPlugin.Status(const Items, Orphans: ITranslationItems): Integer;
begin
  if Items.Count > 0 then
  begin
    Result := TOOL_ENABLED; // can't do anything unless there are items...
    if FClicked then
      Result := Result or TOOL_CHECKED;
  end
  else
    Result := 0;
end;

{ TLowercaseDemoPlugin }

function TLowercaseDemoPlugin.About: WideString;
begin
  // tell us who you are
  // TODO: not yet used
  Result := 'This is a demo plugin that lowercases translations';
end;

destructor TLowercaseDemoPlugin.Destroy;
begin
  // restore original app handle
  if FOldAppHandle <> 0 then
    Application.Handle := FOldAppHandle;
  inherited Destroy;
end;

function TLowercaseDemoPlugin.DisplayName: WideString;
begin
  // this text is displayed on the menu item
  Result := 'Lowercase translation';
end;

function TLowercaseDemoPlugin.Execute(const Items,
  Orphans: ITranslationItems): HRESULT;
var
  i: integer;
  S: WideString;
begin
  for i := 0 to Items.Count - 1 do
  begin
    S := Items[i].Translation;
    Items[i].Translation := WideLowerCase(S);
    if not Items[i].Modified then
      Items[i].Modified := not WideSameStr(Items[i].Translation, S);
  end;
  FClicked := not FClicked;
end;

function TLowercaseDemoPlugin.Icon: Cardinal;
begin
  // load a standard icon for simplicity
  // return 0 if you don't have an icon
  Result := LoadIcon(0, IDI_EXCLAMATION);
end;

procedure TLowercaseDemoPlugin.Init(AppHandle: Cardinal);
begin
  // save old app hanlde and set new app handle
  // this is in case we need to display a dialog or similar
  // using AppHandle makes the dialog behave better with the main app
  FOldAppHandle := Application.Handle;
  Application.Handle := AppHandle;
end;

function TLowercaseDemoPlugin.Status(const Items, Orphans: ITranslationItems): Integer;
begin
  if Items.Count > 0 then
  begin
    Result := TOOL_ENABLED; // can't do anything unless there are items...
    if FClicked then
      Result := Result or TOOL_CHECKED;
  end
  else
    Result := 0;
end;

end.

