unit TestEditItemFrm;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, EditItemFrm, TntComCtrls, SysUtils, ComCtrls, Windows, TransIntf, 
  StdCtrls, BaseForm, Messages, Controls, Classes, Dialogs, TntClasses, Forms, TntStdCtrls, 
  Graphics;
type
  // Test methods for class TfrmEditItem
  
  TestTfrmEditItem = class(TTestCase)
  strict private
    FfrmEditItem: TfrmEditItem;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestTntFormCreate;
    procedure TestDoKeyDown;
    procedure TestTntFormShow;
    procedure TestEdit;
  end;

implementation

procedure TestTfrmEditItem.SetUp;
begin
  FfrmEditItem := TfrmEditItem.Create(nil);
end;

procedure TestTfrmEditItem.TearDown;
begin
  FfrmEditItem.Free;
  FfrmEditItem := nil;
end;

procedure TestTfrmEditItem.TestTntFormCreate;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmEditItem.TntFormCreate(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmEditItem.TestDoKeyDown;
var
  Shift: TShiftState;
  Key: Word;
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmEditItem.DoKeyDown(Sender, Key, Shift);
  // TODO: Validate method results
end;

procedure TestTfrmEditItem.TestTntFormShow;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmEditItem.TntFormShow(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmEditItem.TestEdit;
var
  ReturnValue: Boolean;
  IsNewItem: Boolean;
  AItem: ITranslationItem;
  Sections: TTntStringList;
  ACaption: WideString;
begin
  // TODO: Setup method call parameters
  ReturnValue := FfrmEditItem.Edit(ACaption, Sections, AItem, IsNewItem);
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTfrmEditItem.Suite);
end.

