unit TestApplicationServices;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework, Classes, TransIntf, SysUtils, ApplicationServices, MainFrm;

type
  // Test methods for class TApplicationServices

  TestTApplicationServices = class(TTestCase)
  strict private
    FApplicationServices:TApplicationServices;
    FForm:TfrmMain;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestBeginUpdate;
    procedure TestEndUpdate;
    procedure TestTranslate;
  end;

implementation

procedure TestTApplicationServices.SetUp;
begin
  FForm := TfrmMain.Create(nil);
  FApplicationServices := TApplicationServices.Create(FForm);
end;

procedure TestTApplicationServices.TearDown;
begin
  FApplicationServices.Free;
  FApplicationServices := nil;
  FForm.Free;
  FForm := nil;
end;

procedure TestTApplicationServices.TestBeginUpdate;
var
  ReturnValue:Integer;
begin
  ReturnValue := FApplicationServices.BeginUpdate;
  // TODO: Validate method results
end;

procedure TestTApplicationServices.TestEndUpdate;
var
  ReturnValue:Integer;
begin
  ReturnValue := FApplicationServices.EndUpdate;
  // TODO: Validate method results
end;

procedure TestTApplicationServices.TestTranslate;
var
  ReturnValue:WideString;
  Value:WideString;
  Name:WideString;
  Section:WideString;
begin
  // TODO: Setup method call parameters
  ReturnValue := FApplicationServices.Translate(Section, Name, Value);
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTApplicationServices.Suite);
end.

