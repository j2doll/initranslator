{@abstract(Generic single file select dialog) }
{
  Copyright � 2003-2006 by Peter Thornqvist; all rights reserved

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
unit TMXImportFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TntForms, TntStdCtrls, TntDialogs;

type
  TfrmTMXImport = class(TTntForm)
    Label1:TTntLabel;
    edFilename:TTntEdit;
    btnBrowse:TTntButton;
    btnOK:TTntButton;
    btnCancel:TTntButton;
    OpenDialog1:TTntOpenDialog;
    Label2:TTntLabel;
    Label3:TTntLabel;
    cbOrigLang:TTntComboBox;
    cbTransLang:TTntComboBox;
    procedure btnBrowseClick(Sender:TObject);
    procedure edFilenameChange(Sender:TObject);
  private
    { Private declarations }
    procedure ParseLanguages(const Filename:WideString);
  public
    { Public declarations }
    class function Execute(var AFilename, AOrigLang, ATransLang:WideString; const ACaption, Filter, InitialDir, DefaultExt:WideString):boolean;
  end;

implementation
uses
  TntClasses, XMLDoc, xmldom;

{$R *.dfm}

{ TfrmImport }

class function TfrmTMXImport.Execute(var AFilename, AOrigLang, ATransLang:WideString; const ACaption, Filter, InitialDir, DefaultExt:WideString):boolean;
var
  frmImport:TfrmTMXImport;
begin
  frmImport := self.Create(Application);
  with frmImport do
  try
    Caption := ACaption;
    OpenDialog1.Filter := Filter;
    OpenDialog1.InitialDir := InitialDir;
    OpenDialog1.DefaultExt := DefaultExt;
    edFilename.Text := AFilename;
    cbOrigLang.Text := AOrigLang;
    cbTransLang.Text := ATransLang;
    Result := (ShowModal = mrOk) and FileExists(edFilename.Text) and (cbOrigLang.Text <> '') and (cbTransLang.Text <> '');
    if Result then
    begin
      AFilename := edFilename.Text;
      AOrigLang := cbOrigLang.Text;
      ATransLang := cbTransLang.Text;
    end;
  finally
    Free;
  end;
end;

procedure TfrmTMXImport.btnBrowseClick(Sender:TObject);
begin
  OpenDialog1.Filename := edFilename.Text;
  if OpenDialog1.Execute then
    edFilename.Text := OpenDialog1.Filename;
end;

procedure TfrmTMXImport.edFilenameChange(Sender:TObject);
begin
  if FileExists(edFilename.Text) then
    ParseLanguages(edFilename.Text);
end;

procedure TfrmTMXImport.ParseLanguages(const Filename:WideString);
var
  FXMLImport:TXMLDocument;
  NodeList:IDOMNodeList;
  Node:IDOMNode;
  i:integer;
  S:WideString;
  List:TTntStringList;
begin
  // detect available languages
  FXMLImport := TXMLDocument.Create(nil);
  List := TTntStringList.Create;
  try
    List.Sorted := true; // no duplicates

    FXMLImport.LoadFromFile(Filename);
    if FXMLImport.DOMDocument <> nil then
    begin
      NodeList := FXMLImport.DOMDocument.getElementsByTagName('tuv');
      if NodeList <> nil then
        for i := 0 to NodeList.length - 1 do
        begin
          Node := NodeList.item[i];
          if (Node.attributes <> nil) and (Node.attributes.getNamedItem('xml:lang') <> nil) then
          begin
            S := Node.attributes.getNamedItem('xml:lang').nodeValue;
            if S <> '' then
              List.Add(S);
          end;
          cbOrigLang.Items.Assign(List);
          cbTransLang.Items.Assign(List);
        end;
      cbOrigLang.ItemIndex := 0;
      cbTransLang.ItemIndex := 0;
    end;
  finally
    List.Free;
  end;
end;

end.
