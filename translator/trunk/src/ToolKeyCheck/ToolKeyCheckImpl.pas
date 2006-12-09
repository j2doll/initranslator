{@abstract(ToolKeyCheck implementation) }
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

unit ToolKeyCheckImpl;

interface
uses
  TransIntf;

type
  TToolKeyCheckPlugins = class(TInterfacedObject, IUnknown, IToolItems)
  public
    function Count: Integer; safecall;
    function ToolItem(Index: Integer; out ToolItem: IToolItem): HRESULT; safecall;
  end;

  TTToolKeyCheckPlugin = class(TInterfacedObject, IUnknown, IToolItem)
  private
    FOldAppHandle:Cardinal;
    FAppServices:IApplicationServices;
  public
    function About: WideString; safecall;
    function DisplayName: WideString; safecall;
    function Execute(const Items, Orphans: ITranslationItems; var SelectedItem:ITranslationItem): HRESULT; safecall;
    function Icon: Cardinal; safecall;
    procedure Init(const ApplicationServices: IApplicationServices); safecall;
    function Status(const Items, Orphans: ITranslationItems; const SelectedItem:ITranslationItem): Integer; safecall;
    destructor Destroy; override;
  end;


implementation
uses
  Forms, ToolKeyCheckFrm;

{ TTToolKeyCheckPlugins }

function TToolKeyCheckPlugins.Count: Integer;
begin
  Result := 1;
end;

function TToolKeyCheckPlugins.ToolItem(Index: Integer;
  out ToolItem: IToolItem): HRESULT;
begin
  Result := S_FALSE;
  if Index = 0 then
  begin
    ToolItem := TTToolKeyCheckPlugin.Create;
    Result := S_OK;
  end;
end;

{ TTToolKeyCheckPlugin }

function TTToolKeyCheckPlugin.About: WideString;
begin
  Result := 'Key Check plugin for IniTranslator';
end;

destructor TTToolKeyCheckPlugin.Destroy;
begin
  Application.Handle := FOldAppHandle;
  inherited;
end;

function TTToolKeyCheckPlugin.DisplayName: WideString;
begin
  Result := '&Check accelerator and access keys...';
end;

function TTToolKeyCheckPlugin.Execute(const Items, Orphans: ITranslationItems; var SelectedItem: ITranslationItem): HRESULT;
begin
  TfrmToolKeyCheck.Edit(FAppServices, Items);
  Result := S_OK;
end;

function TTToolKeyCheckPlugin.Icon: Cardinal;
begin
  Result := 0;
end;

procedure TTToolKeyCheckPlugin.Init(const ApplicationServices: IApplicationServices);
begin
  FOldAppHandle := Application.Handle;
  Application.Handle := ApplicationServices.AppHandle;
  FAppServices := ApplicationServices;
end;

function TTToolKeyCheckPlugin.Status(const Items,
  Orphans: ITranslationItems;
  const SelectedItem: ITranslationItem): Integer;
begin
  Result := TOOL_VISIBLE;
  if Items.Count > 0 then
    Result := Result or TOOL_ENABLED;
end;

end.
