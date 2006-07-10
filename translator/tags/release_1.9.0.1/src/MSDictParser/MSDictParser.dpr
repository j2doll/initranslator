library MSDictParser;

uses
  SysUtils,
  Classes,
  TransIntf in '..\TransIntf.pas',
  PreviewExportFrm in '..\PluginCommon\PreviewExportFrm.pas' {frmExport},
  SingleImportFrm in '..\PluginCommon\SingleImportFrm.pas' {frmImport},
  MSDictParserImpl in 'MSDictParserImpl.pas',
  CommonUtils in '..\CommonUtils.pas';

{$R *.res}
function InstallPlugin(out Parser:IFileParser):HResult;stdcall;
begin
  Parser := TMSDictParser.Create;
  Result := S_OK;
end;

exports InstallPlugin name cRegisterTransFileParserFuncName;

begin
end.

