unit TestDictTranslationSelectDlg;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, TntStdCtrls, Windows, Forms, Dialogs, Controls, Dictionary, Classes, 
  SysUtils, BaseForm, Variants, Graphics, Messages, DictTranslationSelectDlg, StdCtrls;
type
  // Test methods for class TfrmDictTranslationSelect
  
  TestTfrmDictTranslationSelect = class(TTestCase)
  strict private
    FfrmDictTranslationSelect: TfrmDictTranslationSelect;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestbtnIgnoreClick;
    procedure TestbtnUseClick;
    procedure TestbtnAddClick;
    procedure TestbtnCancelClick;
    procedure TestlbTranslationsClick;
    procedure TestedTranslationChange;
    procedure TestlbTranslationsDblClick;
    procedure TestEdit;
  end;

implementation

procedure TestTfrmDictTranslationSelect.SetUp;
begin
  FfrmDictTranslationSelect := TfrmDictTranslationSelect.Create(nil);
end;

procedure TestTfrmDictTranslationSelect.TearDown;
begin
  FfrmDictTranslationSelect.Free;
  FfrmDictTranslationSelect := nil;
end;

procedure TestTfrmDictTranslationSelect.TestbtnIgnoreClick;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmDictTranslationSelect.btnIgnoreClick(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmDictTranslationSelect.TestbtnUseClick;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmDictTranslationSelect.btnUseClick(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmDictTranslationSelect.TestbtnAddClick;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmDictTranslationSelect.btnAddClick(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmDictTranslationSelect.TestbtnCancelClick;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmDictTranslationSelect.btnCancelClick(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmDictTranslationSelect.TestlbTranslationsClick;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmDictTranslationSelect.lbTranslationsClick(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmDictTranslationSelect.TestedTranslationChange;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmDictTranslationSelect.edTranslationChange(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmDictTranslationSelect.TestlbTranslationsDblClick;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmDictTranslationSelect.lbTranslationsDblClick(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmDictTranslationSelect.TestEdit;
var
  ReturnValue: Integer;
  Prompt: Boolean;
  Modified: Boolean;
  Translation: WideString;
  DictionaryItem: TDictionaryItem;
begin
  // TODO: Setup method call parameters
  ReturnValue := FfrmDictTranslationSelect.Edit(DictionaryItem, Translation, 
      Modified, Prompt);
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTfrmDictTranslationSelect.Suite);
end.

