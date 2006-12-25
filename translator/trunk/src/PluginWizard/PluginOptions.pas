unit PluginOptions;

interface

type
  TPluginOptions = class
  private
    procedure LoadSettings;
    procedure SaveSettings;
  public
    PluginClassName:string;
    ProjectName:string;
    UnitName:string;
    TransIntfPath:string;
    Title:string;
    IsFileParser:boolean;
    constructor Create;
    destructor Destroy;override;
  end;

implementation
uses
  Registry;

{ TPluginOptions }

constructor TPluginOptions.Create;
begin
  inherited;
  LoadSettings;
end;

destructor TPluginOptions.Destroy;
begin
  SaveSettings;
  inherited Destroy;
end;

procedure TPluginOptions.LoadSettings;
begin
  with TRegIniFile.Create('\Software\Borland\IniTranslatorWizard') do
  try
    PluginClassName := ReadString('Settings','PluginClassName',PluginClassName);
    ProjectName := ReadString('Settings','ProjectName',ProjectName);
    UnitName := ReadString('Settings','UnitName',UnitName);
    TransIntfPath := ReadString('Settings','TransIntfPath',TransIntfPath);
    Title := ReadString('Settings','Title',Title);
    IsFileParser := ReadBool('Settings','IsFileParser',IsFileParser);
  finally
    Free;
  end;
end;

procedure TPluginOptions.SaveSettings;
begin
  with TRegIniFile.Create('\Software\Borland\IniTranslatorWizard') do
  try
    WriteString('Settings','PluginClassName',PluginClassName);
    WriteString('Settings','ProjectName',ProjectName);
    WriteString('Settings','UnitName',UnitName);
    WriteString('Settings','TransIntfPath',TransIntfPath);
    WriteString('Settings','Title',Title);
    WriteBool('Settings','IsFileParser',IsFileParser);
  finally
    Free;
  end;
end;

end.
