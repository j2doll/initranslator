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
  // TODO!
end;

function TXLIFFParser.ImportItems(const Items,
  Orphans: ITranslationItems): HRESULT;
begin
  // TODO!
end;

procedure TXLIFFParser.Init(AppHandle: Cardinal);
begin
  FOldAppHandle := Application.Handle;
  Application.Handle := AppHandle;
end;

end.
