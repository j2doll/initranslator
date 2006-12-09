library ToolKeyCheck;


uses
  SysUtils,
  Classes,
  ToolKeyCheckImpl in 'ToolKeyCheckImpl.pas',
  TransIntf in '..\TransIntf.pas',
  ToolKeyCheckFrm in 'ToolKeyCheckFrm.pas' {frmToolKeyCheck: TfrmToolKeyCheck},
  CommonUtils in '..\CommonUtils.pas';

{$R *.res}
function InstallPlugin(out ToolItems: IToolItems): HResult; stdcall;
begin
  ToolItems := TToolKeyCheckPlugins.Create;
  Result := S_OK;
end;

exports InstallPlugin name cRegisterTransToolItemsFuncName;
begin
end.
