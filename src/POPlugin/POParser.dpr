{@abstract(PO parser project file) }
{
  Copyright � 2003-2004 by Peter Thornqvist; all rights reserved

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
// $Id: POParser.dpr 13 2006-07-12 14:30:20Z peter3 $
library POParser;



uses
  SysUtils,
  Classes,
  TransIntf in '..\TransIntf.pas',
  POExportFrm in 'POExportFrm.pas' {frmPOExport},
  POParserImpl in 'POParserImpl.pas',
  CommonUtils in '..\CommonUtils.pas';

{$R *.res}
function InstallPlugin(out Parser:IFileParser):HResult;stdcall;
begin
  Parser := TPoFileParser.Create;
  Result := S_OK;
end;

exports InstallPlugin name cRegisterTransFileParserFuncName;

begin

end.
 