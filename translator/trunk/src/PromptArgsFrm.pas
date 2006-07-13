{@abstract(Prompt for arguments dialog) }
{
  Copyright © 2003-2004 by Peter Thornqvist; all rights reserved

  Developer(s):
    p3 - peter3 att users dott sourceforge dott net

  Status:
   The contents of this file are subject to the Mozilla Public License Version
   1.1 (the "License"); you may not use this file except in compliance with the
   License. You may obtain a copy of the License at http://www.mozilla.org/MPL/MPL-1.1.html

   Software distributed under the License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.
}

// $Id$
unit PromptArgsFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, Menus,
  BaseForm,
  TntStdCtrls, TntButtons,
  TB2Item,
  TBX, TntComCtrls;

type
  TMacroReplaceEvent = procedure(Sender: TObject; var Args: WideString) of object;
  TfrmPromptArgs = class(TfrmBase)
    edArguments: TTntEdit;
    btnArguments: TTntBitBtn;
    Label1: TTntLabel;
    Label2: TTntLabel;
    reCommandLine: TTntRichEdit;
    btnCancel: TTntButton;
    btnOK: TTntButton;
    popArguments: TTBXPopupMenu;
    OriginalLine1: TTBXItem;
    OriginalText1: TTBXItem;
    OriginalPath1: TTBXItem;
    OriginalDirectory1: TTBXItem;
    OriginalName1: TTBXItem;
    OriginalExtension1: TTBXItem;
    N1: TTBXSeparatorItem;
    ranslationLine1: TTBXItem;
    ranslationText1: TTBXItem;
    ranslationPath1: TTBXItem;
    ranslationDirectory1: TTBXItem;
    ranslationName1: TTBXItem;
    ranslationExtension1: TTBXItem;
    N2: TTBXSeparatorItem;
    DictionaryPath1: TTBXItem;
    DictionaryDirectory1: TTBXItem;
    DictionaryName1: TTBXItem;
    DictionaryExtension1: TTBXItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    TBItem1: TTBItem;
    TBXItem2: TTBXItem;
    TBXItem1: TTBXItem;
    procedure btnArgumentsClick(Sender: TObject);
    procedure edArgumentsChange(Sender: TObject);
    procedure ArgumentsClick(Sender: TObject);
  private
    { Private declarations }
    FOnMacroReplace: TMacroReplaceEvent;
    FCmdLine: string;
  public
    { Public declarations }
    class function Edit(const Title, CmdLine: WideString; var Args: WideString; OnMacroReplace: TMacroReplaceEvent): boolean;
  end;

implementation
uses
  AppUtils, AppConsts;

{$R *.dfm}

{ TfrmPromptArgs }

class function TfrmPromptArgs.Edit(const Title, CmdLine: WideString; var Args: WideString; OnMacroReplace: TMacroReplaceEvent): boolean;
var frmPromptArgs: TfrmPromptArgs;
begin
  frmPromptArgs := Self.Create(Application);
  try
    frmPromptArgs.Caption := Title;
    frmPromptArgs.edArguments.Text := Args;
    frmPromptArgs.FOnMacroReplace := OnMacroReplace;
    frmPromptArgs.FCmdLine := CmdLine;
    frmPromptArgs.edArgumentsChange(frmPromptArgs.edArguments);
    Result := frmPromptArgs.ShowModal = mrOK;
    if Result then
      Args := frmPromptArgs.edArguments.Text;
  finally
    frmPromptArgs.Free;
  end;
end;

procedure TfrmPromptArgs.btnArgumentsClick(Sender: TObject);
var P: TPoint;
begin
  P := btnArguments.ClientOrigin;
  Inc(P.X, btnArguments.Width);
  popArguments.Popup(P.X, P.Y);
end;

procedure TfrmPromptArgs.edArgumentsChange(Sender: TObject);
var S: WideString;
begin
  S := edArguments.Text;
  if Assigned(FOnMacroReplace) then
    FOnMacroReplace(Self, S);
  reCommandLine.Text := FCmdLine + ' ' + S;
end;

procedure TfrmPromptArgs.ArgumentsClick(Sender: TObject);
begin
  edArguments.SelText := cArgsMacros[TMenuItem(Sender).Tag];
end;

end.
