{@abstract(Implementaiton of XLIFF parser) }
{
  Copyright © 2006 by Peter Thornqvist; all rights reserved

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
unit XLIFFParserImpl;

interface
uses
  SysUtils, TransIntf;

type
  TXLIFFParser = class(TInterfacedObject, IInterface, IFileParser)
  private
    FOldAppHandle:Cardinal;
  protected
    function Capabilities: Integer; safecall;
    function Configure(Capability: Integer): HRESULT; safecall;
    function DisplayName(Capability: Integer): WideString; safecall;
    function ExportItems(const Items: ITranslationItems;
      const Orphans: ITranslationItems): HRESULT; safecall;
    function ImportItems(const Items: ITranslationItems;
      const Orphans: ITranslationItems): HRESULT; safecall;
    procedure Init(AppHandle: Cardinal); safecall;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation
uses
  Forms;
resourcestring
  cXLIFFImportTitle = 'Import from XLIFF file';
  cXLIFFExportTitle = 'Export to XLIFF file';

{ TXLIFFParser }

function TXLIFFParser.Capabilities: Integer;
begin
  Result := CAP_IMPORT or CAP_EXPORT;
end;

function TXLIFFParser.Configure(Capability: Integer): HRESULT;
begin
  Result := E_NOTIMPL;
end;

constructor TXLIFFParser.Create;
begin
  FOldAppHandle := Application.Handle;
  inherited Create;
end;

destructor TXLIFFParser.Destroy;
begin
  Application.Handle := FOldAppHandle;
  inherited;
end;

function TXLIFFParser.DisplayName(Capability: Integer): WideString;
begin
  case Capability of
    CAP_IMPORT:
      Result := cXLIFFImportTitle;
    CAP_EXPORT:
      Result := cXLIFFExportTitle;
  else
    Result := '';
  end;
end;

function TXLIFFParser.ExportItems(const Items,
  Orphans: ITranslationItems): HRESULT;
begin
  Result := S_FALSE;
  // TODO!
end;

function TXLIFFParser.ImportItems(const Items,
  Orphans: ITranslationItems): HRESULT;
begin
  Result := S_FALSE;
  // TODO!
end;

procedure TXLIFFParser.Init(AppHandle: Cardinal);
begin
  Application.Handle := AppHandle;
end;

end.
