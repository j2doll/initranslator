unit Main;

interface

uses
  TestFrameWork;

type

  TMain = class(TTestCase)
  private

  protected

//   procedure SetUp; override;
//   procedure TearDown; override;

  published

// Add test methods here...

  end;

implementation

initialization

  TestFramework.RegisterTest('Main Suite',
    TMain.Suite);
 
end.

 