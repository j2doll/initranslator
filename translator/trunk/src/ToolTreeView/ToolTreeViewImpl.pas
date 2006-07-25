{@abstract("Tool" Plugin displaying the content in a treeview) }
{
  Copyright � 2006 by Peter Thornqvist; all rights reserved

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
unit ToolTreeViewImpl;

interface
uses
  TransIntf;

type
  TToolTreeViewPlugins = class(TInterfacedObject, IUnknown, IToolItems)
  public
    function Count: Integer; safecall;
    function ToolItem(Index: Integer; out ToolItem: IToolItem): HRESULT; safecall;
  end;

  TToolTreeViewPlugin = class(TInterfacedObject, IUnknown, IToolItem)
  private
    FOldAppHandle:Cardinal;
  public
    function About: WideString; safecall;
    function DisplayName: WideString; safecall;
    function Execute(const Items, Orphans: ITranslationItems): HRESULT; safecall;
    function Icon: Cardinal; safecall;
    procedure Init(AppHandle: Cardinal); safecall;
    function Status(const Items, Orphans: ITranslationItems): Integer; safecall;
    destructor Destroy; override;
  end;

implementation
uses
  Forms, ToolTreeViewFrm;

{ TToolTreeViewPlugin }

function TToolTreeViewPlugin.About: WideString;
begin
  Result := 'Treeview plugin for IniTranslator, version 1.0';
end;

destructor TToolTreeViewPlugin.Destroy;
begin
  Application.Handle := FOldAppHandle;
  inherited;
end;

function TToolTreeViewPlugin.DisplayName: WideString;
begin
  Result := '&Tree view';
end;

function TToolTreeViewPlugin.Execute(const Items, Orphans: ITranslationItems): HRESULT;
begin
  if TfrmToolTreeView.Edit(Items) then
    Result := S_OK
  else
    Result := S_FALSE;
end;

function TToolTreeViewPlugin.Icon: Cardinal;
begin
  Result := 0;
end;

procedure TToolTreeViewPlugin.Init(AppHandle: Cardinal);
begin
  FOldAppHandle := AppHandle;
  Application.Handle := AppHandle;
end;

function TToolTreeViewPlugin.Status(const Items,
  Orphans: ITranslationItems): Integer;
begin
  Result := TOOL_VISIBLE;
  if Items.Count > 0 then
    Result := Result or TOOL_ENABLED;
end;

{ TToolTreeViewPlugins }

function TToolTreeViewPlugins.Count: Integer;
begin
  Result := 1;
end;

function TToolTreeViewPlugins.ToolItem(Index: Integer;
  out ToolItem: IToolItem): HRESULT;
begin
  if Index = 0 then
  begin
    ToolItem := TToolTreeViewPlugin.Create;
    Result := S_OK;
  end
  else
    Result := S_FALSE;
end;

end.
