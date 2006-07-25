{@abstract(Parser for TMX) }
{
  Copyright © 2004-2005 by Peter Thornqvist; all rights reserved

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

unit TMXParserImpl;

interface
uses
  Classes, Types, TntClasses, TntSysUtils, TransIntf;

type
  TTMXParser = class(TInterfacedObject, IUnknown, IFileParser)
  private
    FOldAppHandle: Cardinal;
    FOrigFile, FOrigLang, FTransLang: string;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure BuildPreview(Items: ITranslationItems; Strings: TTntStrings);
  public
    constructor Create;
    destructor Destroy; override;

    function Capabilities: Integer; safecall;
    function Configure(Capability: Integer): HRESULT; safecall;
    function DisplayName(Capability: Integer): WideString; safecall;
    function ExportItems(const Items: ITranslationItems;
      const Orphans: ITranslationItems): HRESULT; safecall;
    function ImportItems(const Items: ITranslationItems;
      const Orphans: ITranslationItems): HRESULT; safecall;
    procedure Init(AppHandle: Cardinal); safecall;
  end;

implementation
uses
  SysUtils, Forms, IniFiles, PreviewExportFrm, TMXImportFrm,
  xmlintf, xmldoc, xmldom;

const
  cTMXFilter = 'TMX Files (*.tmx)|*.tmx|All files (*.*)|*.*';
  cTMXImportTitle = 'Import from TMX file';
  cTMXExportTitle = 'Export to TMX file';

var
  XML: WideString = '';

{ TTMXParser }

procedure TTMXParser.BuildPreview(Items: ITranslationItems; Strings: TTntStrings);
var
  i: integer;
  TI: ItranslationItem;
begin
  for i := 0 to Items.Count - 1 do
  begin
    TI := Items[i];
//    XML := Tnt_WideStringReplace(XML, Items[i].OrigComments, Items[i].Original, [rfReplaceall]);
    XML := Tnt_WideStringReplace(XML, TI.TransComments, TI.Translation, [rfReplaceAll]);
  end;
  Strings.Text := XML;
end;

function TTMXParser.Capabilities: Integer;
begin
  Result := CAP_IMPORT or CAP_EXPORT or CAP_ITEM_EDIT;
end;

function TTMXParser.Configure(Capability: Integer): HRESULT;
begin
  Result := E_NOTIMPL;
end;

constructor TTMXParser.Create;
begin
  inherited;
  FOldAppHandle := Application.Handle;
end;

destructor TTMXParser.Destroy;
begin
  Application.Handle := FOldAppHandle;
  inherited;
end;

function TTMXParser.DisplayName(Capability: Integer): WideString;
begin
  case Capability of
    CAP_IMPORT:
      Result := cTMXImportTitle;
    CAP_EXPORT:
      Result := cTMXExportTitle;
  else
    Result := '';
  end;
end;

function TTMXParser.ExportItems(const Items, Orphans: ITranslationItems): HRESULT;
var
  S: TTntStringlist;
  FOldSort: TTranslateSortType;
begin
  Result := S_FALSE;
  FOldSort := Items.Sort;
  try
    LoadSettings;
    Items.Sort := stIndex;
    S := TTntStringlist.Create;
    try
      BuildPreview(Items, S);
      if TfrmExport.Execute(FOrigFile, cTMXExportTitle, cTMXFilter, '.', 'tmx', S) then
      begin
        S.SaveToFile(FOrigFile);
        Result := S_OK;
        SaveSettings;
      end;
    finally
      S.Free;
      Items.Sort := FOldSort;
    end;
  except
    Application.HandleException(self);
  end;
end;

function TTMXParser.ImportItems(const Items, Orphans: ITranslationItems): HRESULT;
type
  TFoundItem = (fiOriginal, fiTranslation);
  TFoundItems = set of TFoundItem;

var
  NodeList: IDOMNodeList;
  Node, ChildNode: IDOMNodeEx;
  i: integer;
  TI: ITranslationItem;
  FFoundItems: TFoundItems;
  FXMLImport: IXMLDocument;

  function IsOriginal(const Attributes: IDOMNamedNodeMap): boolean;
  begin
    Result := (Attributes <> nil) and (Attributes.getNamedItem('xml:lang') <> nil)
      and WideSameText(Attributes.getNamedItem('xml:lang').nodeValue, FOrigLang);
  end;

  function IsTranslation(const Attributes: IDOMNamedNodeMap): boolean;
  begin
    Result := (Attributes <> nil) and (Attributes.getNamedItem('xml:lang') <> nil)
      and WideSameText(Attributes.getNamedItem('xml:lang').nodeValue, FTransLang);
  end;
begin
  Result := S_FALSE;
  FFoundItems := [];
  try
    Items.Clear;
    Orphans.Clear;
    LoadSettings;
    if TfrmImport.Execute(FOrigFile, FOrigLang, FTransLang, cTMXImportTitle, cTMXFilter, '.', 'tmx') then
    begin
      // TODO
      FXMLImport := TXMLDocument.Create(nil);
      try
        FXMLImport.LoadFromFile(FOrigFile);
//        FXMLImport.SaveToXML(XML);
//        FXMLImport := LoadXMLData(XML);

        if FXMLImport.DOMDocument <> nil then
        begin
          NodeList := FXMLImport.DOMDocument.getElementsByTagName('tuv');
          if NodeList <> nil then
            for i := 0 to NodeList.length - 1 do
            begin
              Node := NodeList.item[i] as IDOMNodeEx;
              if IsOriginal(Node.attributes) then
              begin
                ChildNode := Node.firstChild as IDOMNodeEx;
                if (ChildNode <> nil) and (ChildNode.nodeName = 'seg') then
                begin
                  if TI = nil then
                    TI := Items.Add;
                  TI.Original := ChildNode.xml;
//                TI.OrigComments := ChildNode.xml;
                  Include(FFoundItems, fiOriginal);
                end;
              end
              else if IsTranslation(Node.attributes) then
              begin
                ChildNode := Node.firstChild as IDOMNodeEx;
                if (ChildNode <> nil) and (ChildNode.nodeName = 'seg') then
                begin
                  if TI = nil then
                    TI := Items.Add;
                  TI.Translation := ChildNode.xml;
                  TI.TransComments := ChildNode.xml;
                  Include(FFoundItems, fiTranslation);
                end;
              end;
              if FFoundItems = [fiTranslation, fiOriginal] then
              begin
                if TI <> nil then
                  TI.Translated := TI.Translation <> '';
                TI := nil;
                FFoundItems := [];
              end;
            end;
        end;
        SaveSettings;
//        FXMLImport.SaveToXML(XML);
        Result := S_OK;
      finally
        FXMLImport := nil;
      end;
    end;
  except
    Application.HandleException(self);
  end;
end;

procedure TTMXParser.Init(AppHandle: Cardinal);
begin
  Application.Handle := AppHandle;
end;

procedure TTMXParser.LoadSettings;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
      FOrigFile := ReadString('Settings', 'OrigFile', FOrigFile);
      FOrigLang := ReadString('Settings', 'OrigLang', FOrigLang);
      FTransLang := ReadString('Settings', 'TransLang', FTransLang);
    finally
      Free;
    end;
  except
    Application.HandleException(self);
  end;
end;

procedure TTMXParser.SaveSettings;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
      WriteString('Settings', 'OrigFile', FOrigFile);
      WriteString('Settings', 'OrigLang', FOrigLang);
      WriteString('Settings', 'TransLang', FTransLang);
    finally
      Free;
    end;
  except
    Application.HandleException(self);
  end;
end;

end.

