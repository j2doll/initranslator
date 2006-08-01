library XLIFFParser;

uses
  SysUtils,
  Classes,
  XLIFFParserImpl in 'XLIFFParserImpl.pas',
  TransIntf in '..\TransIntf.pas',
  PreviewExportFrm in '..\PluginCommon\PreviewExportFrm.pas' {frmExport};

{$R *.res}

function InstallPlugin(out Parser: IFileParser): HResult; stdcall;
begin
  Parser := TXLIFFParser.Create;
  Result := S_OK;
end;

exports InstallPlugin name cRegisterTransFileParserFuncName;
begin

end.


