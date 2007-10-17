unit TestOrphansFrm;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, TranslateFile, TBX, TntComCtrls, TntActnList, SysUtils, ComCtrls, Windows, 
  TransIntf, TB2Item, TntDialogs, StdCtrls, BaseForm, TB2Toolbar, Messages, TntExtCtrls, 
  ExtCtrls, Menus, Controls, Classes, SpTBXItem, TntClasses, WideIniFiles, TB2Dock, Forms, 
  TntMenus, TntStdCtrls, ActnList, Graphics, OrphansFrm;
type
  // Test methods for class TfrmOrphans
  
  TestTfrmOrphans = class(TTestCase)
  strict private
    FfrmOrphans: TfrmOrphans;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestlvOrphanedResize;
    procedure TestacCopyExecute;
    procedure TestalOrphansUpdate;
    procedure TestlvOrphanedChange;
    procedure TestFormShow;
    procedure TestacMergeExecute;
    procedure TestlvOrphanedData;
    procedure TestacSaveExecute;
    procedure TestacCloseExecute;
    procedure TestacClearExecute;
    procedure TestacRemoveExecute;
    procedure TestacPasteExecute;
    procedure TestacFindItemExecute;
    procedure TestacFindNextExecute;
    procedure TestacAddExecute;
    procedure TestEdit;
  end;

implementation

procedure TestTfrmOrphans.SetUp;
begin
  FfrmOrphans := TfrmOrphans.Create(nil);
end;

procedure TestTfrmOrphans.TearDown;
begin
  FfrmOrphans.Free;
  FfrmOrphans := nil;
end;

procedure TestTfrmOrphans.TestlvOrphanedResize;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmOrphans.lvOrphanedResize(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmOrphans.TestacCopyExecute;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmOrphans.acCopyExecute(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmOrphans.TestalOrphansUpdate;
var
  Handled: Boolean;
  Action: TBasicAction;
begin
  // TODO: Setup method call parameters
  FfrmOrphans.alOrphansUpdate(Action, Handled);
  // TODO: Validate method results
end;

procedure TestTfrmOrphans.TestlvOrphanedChange;
var
  Change: TItemChange;
  Item: TListItem;
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmOrphans.lvOrphanedChange(Sender, Item, Change);
  // TODO: Validate method results
end;

procedure TestTfrmOrphans.TestFormShow;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmOrphans.FormShow(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmOrphans.TestacMergeExecute;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmOrphans.acMergeExecute(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmOrphans.TestlvOrphanedData;
var
  Item: TListItem;
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmOrphans.lvOrphanedData(Sender, Item);
  // TODO: Validate method results
end;

procedure TestTfrmOrphans.TestacSaveExecute;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmOrphans.acSaveExecute(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmOrphans.TestacCloseExecute;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmOrphans.acCloseExecute(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmOrphans.TestacClearExecute;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmOrphans.acClearExecute(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmOrphans.TestacRemoveExecute;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmOrphans.acRemoveExecute(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmOrphans.TestacPasteExecute;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmOrphans.acPasteExecute(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmOrphans.TestacFindItemExecute;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmOrphans.acFindItemExecute(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmOrphans.TestacFindNextExecute;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmOrphans.acFindNextExecute(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmOrphans.TestacAddExecute;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmOrphans.acAddExecute(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmOrphans.TestEdit;
var
  ReturnValue: Boolean;
  OnMerge: TNotifyEvent;
  CanMerge: Boolean;
  ApplicationServices: IApplicationServices;
begin
  // TODO: Setup method call parameters
  ReturnValue := FfrmOrphans.Edit(ApplicationServices, CanMerge, OnMerge);
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTfrmOrphans.Suite);
end.
