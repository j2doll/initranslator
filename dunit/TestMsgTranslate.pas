unit TestMsgTranslate;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, TntClasses, Classes, MsgTranslate, SysUtils, TransIntf, WideIniFiles;
type
  // Test methods for class TAppLanguage
  
  TestTAppLanguage = class(TTestCase)
  strict private
    FAppLanguage: TAppLanguage;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestTranslate;
    procedure TestInSkipList;
    procedure TestInClassSkipList;
    procedure TestTranslateObject;
    procedure TestLoadFromFile;
    procedure TestSaveToFile;
    procedure TestCreateTemplate;
    procedure TestSkipClass;
    procedure TestSkipProperty;
  end;

implementation

procedure TestTAppLanguage.SetUp;
begin
  FAppLanguage := TAppLanguage.Create;
end;

procedure TestTAppLanguage.TearDown;
begin
  FAppLanguage.Free;
  FAppLanguage := nil;
end;

procedure TestTAppLanguage.TestTranslate;
var
  ReturnValue: WideString;
  Value: WideString;
  Name: WideString;
  Section: WideString;
begin
  // TODO: Setup method call parameters
  ReturnValue := FAppLanguage.Translate(Section, Name, Value);
  // TODO: Validate method results
end;

procedure TestTAppLanguage.TestInSkipList;
var
  ReturnValue: Boolean;
  S: WideString;
begin
  // TODO: Setup method call parameters
  ReturnValue := FAppLanguage.InSkipList(S);
  // TODO: Validate method results
end;

procedure TestTAppLanguage.TestInClassSkipList;
var
  ReturnValue: Boolean;
  AClass: TClass;
begin
  // TODO: Setup method call parameters
  ReturnValue := FAppLanguage.InClassSkipList(AClass);
  // TODO: Validate method results
end;

procedure TestTAppLanguage.TestTranslateObject;
var
  Section: WideString;
  AnObject: TObject;
begin
  // TODO: Setup method call parameters
  FAppLanguage.TranslateObject(AnObject, Section);
  // TODO: Validate method results
end;

procedure TestTAppLanguage.TestLoadFromFile;
var
  AFilename: WideString;
begin
  // TODO: Setup method call parameters
  FAppLanguage.LoadFromFile(AFilename);
  // TODO: Validate method results
end;

procedure TestTAppLanguage.TestSaveToFile;
var
  AFilename: WideString;
begin
  // TODO: Setup method call parameters
  FAppLanguage.SaveToFile(AFilename);
  // TODO: Validate method results
end;

procedure TestTAppLanguage.TestCreateTemplate;
var
  AnObject: TObject;
  AFilename: WideString;
begin
  // TODO: Setup method call parameters
  FAppLanguage.CreateTemplate(AFilename, AnObject);
  // TODO: Validate method results
end;

procedure TestTAppLanguage.TestSkipClass;
var
  AClass: TClass;
begin
  // TODO: Setup method call parameters
  FAppLanguage.SkipClass(AClass);
  // TODO: Validate method results
end;

procedure TestTAppLanguage.TestSkipProperty;
var
  PropName: WideString;
begin
  // TODO: Setup method call parameters
  FAppLanguage.SkipProperty(PropName);
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTAppLanguage.Suite);
end.

