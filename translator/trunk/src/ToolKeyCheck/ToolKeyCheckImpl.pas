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
