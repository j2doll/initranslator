{@abstract(Implementaiton of XLIFF parser) }
{
  Copyright © 2006 by Peter Thornqvist; all rights reserved

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
unit XLIFFParserImpl;

interface
uses
  SysUtils, TransIntf;

type
  TXLIFFParser = class(TInterfacedObject, IInterface, IFileParser)
  private
    FOldAppHandle: Cardinal;
    FFilename, FOrigLang, FTransLang: string;
    procedure LoadSettings;
    procedure SaveSettings;
  protected
    function Capabilities: Integer; safecall;
    function Configure(Capability: Integer): HRESULT; safecall;
    function DisplayName(Capability: Integer): WideString; safecall;
    function ExportItems(const Items: ITranslationItems;
      const Orphans: ITranslationItems): HRESULT; safecall;
    function ImportItems(const Items: ITranslationItems;
      const Orphans: ITranslationItems): HRESULT; safecall;
    procedure Init(AppHandle: Cardinal); safecall;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation
uses
  Forms, Dialogs, xmldoc, xmldom, xmlintf,
  TntClasses, TntSysUtils, IniFiles,
  PreviewExportFrm, XLIFFImportFrm, Math;

resourcestring
  cXLIFFImportTitle = 'Import from XLIFF file';
  cXLIFFExportTitle = 'Export to XLIFF file';
  cXLIFFFilter = 'XLIFF files (*.xlf)|*.xlf|All files (*.*)|*.*';

var
  XML: WideString = '';
const
  cTranslationItem: WideString = '!!!Translation%d!!!!';
  cOriginalItem: WideString = '!!!Original%d!!!!';

{ TXLIFFParser }

function TXLIFFParser.Capabilities: Integer;
begin
  Result := CAP_IMPORT or CAP_EXPORT;
end;

function TXLIFFParser.Configure(Capability: Integer): HRESULT;
begin
  Result := E_NOTIMPL;
end;

constructor TXLIFFParser.Create;
begin
  FOldAppHandle := Application.Handle;
  inherited Create;
end;

destructor TXLIFFParser.Destroy;
begin
  Application.Handle := FOldAppHandle;
  inherited;
end;

function TXLIFFParser.DisplayName(Capability: Integer): WideString;
begin
  case Capability of
    CAP_IMPORT:
      Result := cXLIFFImportTitle;
    CAP_EXPORT:
      Result := cXLIFFExportTitle;
  else
    Result := '';
  end;
end;

function TXLIFFParser.ExportItems(const Items, Orphans: ITranslationItems): HRESULT;
var Strings: TTntStringlist;

  function WrapTags(const T:ITranslationItem; IsOriginal:boolean):WideString;
  begin
    if IsOriginal then
    begin
      if T.OrigComments <> '' then
        Result := WideFormat('<source %s>%s</source>',[T.OrigComments, T.Original])
      else
        Result := WideFormat('<source>%s</source>',[T.Original]);
    end
    else
    begin
      if T.TransComments <> '' then
        Result := WideFormat('<target %s>%s</target>',[T.TransComments, T.Translation])
      else
        Result := WideFormat('<target>%s</target>',[T.Translation]);
    end;
  end;
  procedure BuildPreview(const Items, Orphans: ITranslationItems; Strings: TTntStrings);
  var
    S: WideString;
    i: integer;
    TI: ITranslationItem;
  begin
    S := XML;
    for i := 0 to Items.Count - 1 do
    begin
      TI := Items[i];
      S := Tnt_WideStringReplace(S, WideFormat(cOriginalItem, [TI.Index]), WrapTags(TI, true), [rfReplaceAll]);
      S := Tnt_WideStringReplace(S, WideFormat(cTranslationItem, [TI.Index]), WrapTags(TI, false), [rfReplaceAll]);
    end;
    Strings.Text := S;
  end;
begin
  Result := S_FALSE;
  LoadSettings;
  Strings := TTntStringlist.Create;
  try
    try
      BuildPreview(Items, Orphans, Strings);
      if TfrmExport.Execute(FFilename, cXLIFFExportTitle, cXLIFFFilter, '.', '.xlf', Strings) then
      begin
        SaveSettings;
        Strings.SaveToFile(FFilename);
        Result := S_OK;
      end;
    finally
      Strings.Free;
    end;
  except
    Application.HandleException(Self);
  end;
end;

function TXLIFFParser.ImportItems(const Items, Orphans: ITranslationItems): HRESULT;
type
  TFoundItem = (fiOriginal, fiTranslation);
  TFoundItems = set of TFoundItem;

var
  NodeList: IDOMNodeList;
  Node, ChildNode: IDOMNode;
  i, j: integer;
  TI: ITranslationItem;
  FFoundItems: TFoundItems;
  FXMLImport: IXMLDocument;

  function IsOriginal(const ANode: IDOMNode): boolean;
  var ALang: WideString;
  begin
    if (ANode.Attributes <> nil) and (ANode.Attributes.getNamedItem('xml:lang') <> nil) then
      ALang := ANode.Attributes.getNamedItem('xml:lang').nodeValue
    else
      ALang := '';
    Result := WideSameText(ANode.nodeName, 'source') and ((FOrigLang = '') or (ALang = '') or WideSameText(ALang, FOrigLang));
  end;

  function IsTranslation(const ANode: IDOMNode): boolean;
  var ALang: WideString;
  begin
    if (ANode.Attributes <> nil) and (ANode.Attributes.getNamedItem('xml:lang') <> nil) then
      ALang := ANode.Attributes.getNamedItem('xml:lang').nodeValue
    else
      ALang := '';
    Result := WideSameText(ANode.nodeName, 'target') and ((FTransLang = '') or (ALang = '') or WideSameText(ALang, FTransLang));
  end;

  procedure CreateTI(var TI: ITranslationItem);
  begin
    if TI = nil then
    begin
      TI := Items.Add;
      TI.Section := 'XLIFF';
    end;
  end;

  function Attr2Str(const ANode: IDOMNode): WideString;
  var i:integer;
  begin
    Result := '';
    if (ANode <> nil) and (ANode.attributes <> nil) then
      with ANode.attributes do
        for i := 0 to length - 1 do
          Result := Result + WideFormat(' %s="%s"',[item[i].nodeName, item[i].nodeValue]);
    Result := trim(Result);
  end;
  function StripTags(const S: WideString): WideString;
  var i:integer;
  begin
    Result := S;
    // strip start tag
    i := 1;
    while i <= Length(Result) do
    begin
      if Result[i] = '>' then
      begin
        Result := Copy(Result, i + 1, MaxInt);
        Break;
      end;
      Inc(i);
    end;
    // strip end tag
    i := Length(Result);
    while i >= 1 do
    begin
      if Result[i] = '<' then
      begin
        SetLength(Result, i - 1);
        Break;
      end;
      Dec(i);
    end;
  end;
begin
  Result := S_FALSE;
  FFoundItems := [];
  try
    Items.Clear;
    Orphans.Clear;
    LoadSettings;
    if TfrmImport.Execute(FFilename, FOrigLang, FTransLang, cXLIFFImportTitle, cXLIFFFilter, '.', '.xlf') then
    begin
      SaveSettings;
      FXMLImport := LoadXMLDocument(FFilename);
      if FXMLImport.DOMDocument <> nil then
      begin
        NodeList := FXMLImport.DOMDocument.getElementsByTagName('trans-unit');
        if NodeList <> nil then
        begin
          ShowMessageFmt('%d nodes',[NodeList.length]);
          for i := 0 to NodeList.length - 1 do
          begin
            Node := NodeList.item[i];
            if Node.hasChildNodes then
              for j := Node.childNodes.length - 1 downto 0 do
              begin
                ChildNode := Node.childNodes[j];
                if IsOriginal(ChildNode) then
                begin
                  CreateTI(TI);
//                  if (Node.attributes <> nil) and (Node.attributes.getNamedItem('id') <> nil) then
//                    TI.Name := Node.attributes.getNamedItem('id').nodeValue;
//                  TI.Original := StripTags((ChildNode as IDOMNodeEx).xml);
                  TI.Original := (ChildNode as IDOMNodeEx).xml;
                  TI.OrigComments := Attr2Str(ChildNode);

                  Node.removeChild(ChildNode);
                  ChildNode := FXMLImport.DOMDocument.createTextNode('');
                  ChildNode.nodeValue := WideFormat(cOriginalItem, [TI.Index]);
                  Node.appendChild(ChildNode);
                  Include(FFoundItems, fiOriginal);
                end
                else if IsTranslation(ChildNode) then
                begin
                  CreateTI(TI);
//                  if (Node.attributes <> nil) and (Node.attributes.getNamedItem('id') <> nil) then
//                    TI.Name := Node.attributes.getNamedItem('id').nodeValue;
//                  TI.Translation := StripTags((ChildNode as IDOMNodeEx).xml);
                  TI.Translation := (ChildNode as IDOMNodeEx).xml;
                  TI.TransComments := Attr2Str(ChildNode);
                  Node.removeChild(ChildNode);
                  ChildNode := FXMLImport.DOMDocument.createTextNode('');
                  ChildNode.nodeValue := WideFormat(cTranslationItem, [TI.Index]);
                  Node.appendChild(ChildNode);
                  Include(FFoundItems, fiTranslation);
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
        end;
      end;
      SaveSettings;
      Items.Modified := false;
      FXMLImport.SaveToXML(XML); // save the imported data in a string
      Result := S_OK;
    end;
  except
    Application.HandleException(self);
  end;
end;

procedure TXLIFFParser.Init(AppHandle: Cardinal);
begin
  if FOldAppHandle = 0 then
    FOldAppHandle := Application.Handle;
  Application.Handle := AppHandle;
end;

procedure TXLIFFParser.LoadSettings;
begin
  with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
  try
    FFilename := ReadString('Settings', 'Filename', FFilename);
    FOrigLang := ReadString('Settings', 'OrigLang', FOrigLang);
    FTransLang := ReadString('Settings', 'TransLang', FTransLang);
  finally
    Free;
  end;
end;

procedure TXLIFFParser.SaveSettings;
begin
  with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
  try
    WriteString('Settings', 'Filename', FFilename);
    WriteString('Settings', 'OrigLang', FOrigLang);
    WriteString('Settings', 'TransLang', FTransLang);
  finally
    Free;
  end;
end;

end.

