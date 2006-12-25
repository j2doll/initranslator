unit PluginsDesign;

interface
uses
  Classes, DesignIntf, ToolsAPI;

type
  TPluginWizard = class(TNotifierobject, IOTAWizard, IOTARepositoryWizard, IOTAProjectWizard)
  public
    { IOTAWizard }
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Execute;
    { IOTARepositoryWizard }
    function GetAuthor: string;
    function GetComment: string;
    function GetGlyph: Cardinal;
    function GetPage: string;
  end;

procedure Register;

implementation
uses
  Windows, SysUtils, PluginOptions, PluginWizardForm;
  
{$R includes.res}

procedure Register;
begin
  RegisterPackageWizard(TPluginWizard.Create);
end;

function ModuleServices: IOTAModuleServices;
begin
  Result := (BorlandIDEServices as IOTAModuleServices);
end;

function GetActiveProjectGroup: IOTAProjectGroup;
var
  ModuleServices: IOTAModuleServices;
  i: Integer;
begin
  Result := nil;
  if Assigned(BorlandIDEServices) then
  begin
    ModuleServices := BorlandIDEServices as IOTAModuleServices;
    for i := 0 to ModuleServices.ModuleCount - 1 do
      if Supports(ModuleServices.Modules[i], IOTAProjectGroup, Result) then
        Break;
  end;
end;

function GetActiveProject: IOTAProject;
var
  ProjectGroup: IOTAProjectGroup;
begin
  Result := nil;
  ProjectGroup := GetActiveProjectGroup;
  if ProjectGroup <> nil then
    Result := ProjectGroup.ActiveProject;
end;

function LoadResourceText(const ResID:string):string;
var
  HRes:HRSRC;
  ResInstance:Cardinal;
begin
  ResInstance := hInstance;
  HRes := FindResource(ResInstance, MakeIntResource(ResID), RT_RCDATA);
  Result := PChar(LockResource(LoadResource(ResInstance, HRes)));
  SetLength(Result, SizeofResource(ResInstance, HRes));
end;

function ReplaceMacros(const S:String; Options:TPluginOptions):String;
begin
// %transpath% %project% %pluginclassname% %unit% %title%
  Result := StringReplace(S, '%transpath%', Options.TransIntfPath, [rfReplaceAll]);
  Result := StringReplace(Result, '%project%', Options.ProjectName, [rfReplaceAll]);
  Result := StringReplace(Result, '%pluginclassname%', Options.PluginClassName, [rfReplaceAll]);
  Result := StringReplace(Result, '%unit%', Options.UnitName, [rfReplaceAll]);
  Result := StringReplace(Result, '%title%', Options.Title, [rfReplaceAll]);
end;

type
  TPluginCreator = class(TInterfacedObject, IInterface, IOTACreator, IOTAProjectCreator)
  private
    FOptions: TPluginOptions;
  public
    // IOTACreator
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;
    // IOTAProjectCreator
    function GetFileName: string;
    function GetOptionFileName: string;
    function GetShowSource: Boolean;
    procedure NewDefaultModule;
    function NewOptionSource(const ProjectName: string): IOTAFile;
    procedure NewProjectResource(const Project: IOTAProject);
    function NewProjectSource(const ProjectName: string): IOTAFile;
    constructor Create(Options: TPluginOptions);
  end;

  TProjectFile = class(TInterfacedObject, IInterface, IOTAFile)
  private
    FOptions: TPluginOptions;
  public
    constructor Create(Options: TPluginOptions; const ProjectName: string);
    function GetAge: TDateTime;
    function GetSource: string;
  end;

  TUnitCreator = class(TInterfacedObject, IInterface, IOTACreator, IOTAModuleCreator)
  private
    FModule: IOTAModule;
    FOptions: TPluginOptions;
  public
    procedure FormCreated(const FormEditor: IOTAFormEditor);
    function GetAncestorName: string;
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetFormName: string;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetMainForm: Boolean;
    function GetOwner: IOTAModule;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
    function GetUnnamed: Boolean;
    function NewFormFile(const FormIdent: string;
      const AncestorIdent: string): IOTAFile;
    function NewImplSource(const ModuleIdent: string;
      const FormIdent: string; const AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent: string;
      const FormIdent: string; const AncestorIdent: string): IOTAFile;
    constructor Create(const Module: IOTAModule; Options: TPluginOptions);
  end;

  TUnitFile = class(TInterfacedObject, IInterface, IOTAFile)
  private
    FOptions: TPluginOptions;
  public
    function GetAge: TDateTime;
    function GetSource: string;
    constructor Create(Options: TPluginOptions; ModuleIdent: string);
  end;

{ TPluginWizard }

procedure TPluginWizard.Execute;
var
  Module: IOTAModule;
  Options: TPluginOptions;
begin
  Options := TPluginOptions.Create;
  try
    if TfrmTranslatorPluginWizard.Execute(Options) then
    begin
      Module := ModuleServices.CreateModule(TPluginCreator.Create(Options));
      Module := ModuleServices.CreateModule(TUnitCreator.Create(Module, Options));
    end;
  finally
    FreeAndNil(Options);
  end;
end;

function TPluginWizard.GetAuthor: string;
begin
  Result := 'Peter Thörnqvist';
end;

function TPluginWizard.GetComment: string;
begin
  Result := 'Create new IniTranslator plugin';
end;

function TPluginWizard.GetGlyph: Cardinal;
begin
  Result := LoadIcon(hInstance, MakeIntResource('IDI_ICON1'));
end;

function TPluginWizard.GetIDString: string;
begin
  Result := 'IniTranslator.PluginWizard';
end;

function TPluginWizard.GetName: string;
begin
  Result := 'Create IniTranslator Plugin';
end;

function TPluginWizard.GetPage: string;
begin
  Result := 'New';
end;

function TPluginWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

{ TPluginCreator }

constructor TPluginCreator.Create(Options: TPluginOptions);
begin
  FOptions := Options;
end;

function TPluginCreator.GetCreatorType: string;
begin
  Result := ''; // custom
end;

function TPluginCreator.GetExisting: Boolean;
begin
  Result := false;
end;

function TPluginCreator.GetFileName: string;
begin
  Result := '';
end;

function TPluginCreator.GetFileSystem: string;
begin
  Result := '';
end;

function TPluginCreator.GetOptionFileName: string;
begin
  Result := '';
end;

function TPluginCreator.GetOwner: IOTAModule;
begin
  Result := GetActiveProjectGroup;
end;

function TPluginCreator.GetShowSource: Boolean;
begin
  Result := true;
end;

function TPluginCreator.GetUnnamed: Boolean;
begin
  Result := true;
end;

procedure TPluginCreator.NewDefaultModule;
begin
  //
end;

function TPluginCreator.NewOptionSource(const ProjectName: string): IOTAFile;
begin
  Result := nil;
end;

procedure TPluginCreator.NewProjectResource(const Project: IOTAProject);
begin
  //
end;

function TPluginCreator.NewProjectSource(const ProjectName: string): IOTAFile;
begin
  Result := TProjectFile.Create(FOptions, ProjectName);
end;

{ TProjectFile }

constructor TProjectFile.Create(Options: TPluginOptions; const ProjectName: string);
begin
  FOptions := Options;
  FOptions.ProjectName := ProjectName;
end;

function TProjectFile.GetAge: TDateTime;
begin
  Result := -1;
end;

function TProjectFile.GetSource: string;
begin
  if FOptions.IsFileParser then
    Result := LoadResourceText('FILEPLUGINPROJECT')
  else
    Result := LoadResourceText('TOOLPLUGINPROJECT');
  Result := ReplaceMacros(Result, FOptions);
end;

{ TUnitCreator }

constructor TUnitCreator.Create(const Module: IOTAModule;
  Options: TPluginOptions);
begin
  FModule := Module;
  FOptions := Options;
end;

procedure TUnitCreator.FormCreated(const FormEditor: IOTAFormEditor);
begin
//
end;

function TUnitCreator.GetAncestorName: string;
begin
  Result := '';
end;

function TUnitCreator.GetCreatorType: string;
begin
  Result := ''; // custom
end;

function TUnitCreator.GetExisting: Boolean;
begin
  Result := false;
end;

function TUnitCreator.GetFileSystem: string;
begin
  Result := '';
end;

function TUnitCreator.GetFormName: string;
begin
  Result := '';
end;

function TUnitCreator.GetImplFileName: string;
begin
  Result := '';
end;

function TUnitCreator.GetIntfFileName: string;
begin
  Result := '';
end;

function TUnitCreator.GetMainForm: Boolean;
begin
  Result := false;
end;

function TUnitCreator.GetOwner: IOTAModule;
begin
  Result := FModule;
end;

function TUnitCreator.GetShowForm: Boolean;
begin
  Result := false;
end;

function TUnitCreator.GetShowSource: Boolean;
begin
  Result := true;
end;

function TUnitCreator.GetUnnamed: Boolean;
begin
  Result := true;
end;

function TUnitCreator.NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

function TUnitCreator.NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := TUnitFile.Create(FOptions, ModuleIdent);
end;

function TUnitCreator.NewIntfSource(const ModuleIdent, FormIdent,
  AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

{ TUnitFile }

constructor TUnitFile.Create(Options: TPluginOptions; ModuleIdent: string);
begin
  FOptions := Options;
  FOptions.UnitName := ModuleIdent;
end;

function TUnitFile.GetAge: TDateTime;
begin
  Result := -1;
end;

function TUnitFile.GetSource: string;
var
  s, dummy: string;
begin
  if FOptions.UnitName = '' then
  begin
    ModuleServices.GetNewModuleAndClassName('', s, dummy, dummy);
    FOptions.UnitName := s;
  end;
  if FOptions.IsFileParser then
    Result := LoadResourceText('FILEPLUGINUNIT')
  else
    Result := LoadResourceText('TOOLPLUGINUNIT');
  Result := ReplaceMacros(Result, FOptions);
end;

end.

