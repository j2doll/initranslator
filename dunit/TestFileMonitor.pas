unit TestFileMonitor;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, Messages, SysUtils, FileMonitor, Classes, Windows;
type
  // Test methods for class TFileMonitorThread
  
  TestTFileMonitorThread = class(TTestCase)
  strict private
    FFileMonitorThread: TFileMonitorThread;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
  end;

implementation

procedure TestTFileMonitorThread.SetUp;
begin
  // TODO
  FFileMonitorThread := TFileMonitorThread.Create('');
end;

procedure TestTFileMonitorThread.TearDown;
begin
  FFileMonitorThread.Free;
  FFileMonitorThread := nil;
end;


initialization
  // Register any test cases with the test runner
  //RegisterTest(TestTFileMonitorThread.Suite);
end.

