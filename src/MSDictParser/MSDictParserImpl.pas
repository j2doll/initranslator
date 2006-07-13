{@abstract(Parser for MS Dictionary files) }
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
unit MSDictParserImpl;

interface
uses
  Classes, SysUtils, Types, TransIntf, TntClasses;

type
  TMsDictParser = class(TInterfacedObject, IUnknown, IFileParser)
  private
    FAppHandle: Cardinal;
    FSkipLines: integer;
    { IFileParser }
    function Capabilities: Integer; safecall;
    function Configure(Capability: Integer): HRESULT; safecall;
    function DisplayName(Capability: Integer): WideString; safecall;
    function ExportItems(const Items: ITranslationItems; const Orphans: ITranslationItems): HRESULT; safecall;
    function ImportItems(const Items: ITranslationItems; const Orphans: ITranslationItems): HRESULT; safecall;
    procedure Init(AppHandle: Cardinal); safecall;
    function AddCopyright: boolean;
  protected
    FTransFile: string;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure BuildPreview(Items: ITranslationItems; Strings: TTntStrings);

  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation
uses
  Forms, Windows, StrUtils, Controls, IniFiles, CommonUtils,
  TntSysUtils, PreviewExportFrm, SingleImportFrm;

const
  cMsDictFilter = 'MS Glossary Files (*.csv)|*.csv|All files (*.*)|*.*';
  cMsDictImportTitle = 'Import from MS Glossary CSV file';
  cMsDictExportTitle = 'Export to MS Glossary CSV file';
  cSectionName = 'MS Glossary';
  cCopyright = 'This glossary is intellectual property of Microsoft Corporation. Please refer to the complete copyright text in the README.TXT file included in this file.,,,,,,,';

{ TMsDictParser }

function TMsDictParser.AddCopyright: boolean;
begin
  Result := MessageBox(GetFocus, 'Add Microsoft Copyright notice?', 'Confirm', MB_YESNO) = IDYES;
end;

procedure TMsDictParser.BuildPreview(Items: ITranslationItems; Strings: TTntStrings);
var i: integer;
begin
  if AddCopyright then
  begin
    Strings.Add(cCopyright);
    Strings.Add('');
  end;
  for i := 0 to Items.Count - 1 do
    Strings.Add(WideFormat(Items[i].TransComments, ['"' + Items[i].Original + '"', '"' + Items[i].Translation + '"']));
end;

function TMsDictParser.Capabilities: Integer;
begin
  Result := CAP_IMPORT or CAP_EXPORT;
end;

function TMsDictParser.Configure(Capability: Integer): HRESULT;
begin
  Result := E_NOTIMPL;
end;

constructor TMsDictParser.Create;
begin
  inherited;
  FAppHandle := Application.Handle;
end;

destructor TMsDictParser.Destroy;
begin
  Application.Handle := FAppHandle;
  inherited;
end;

function TMsDictParser.DisplayName(Capability: Integer): WideString;
begin
  case Capability of
    CAP_IMPORT:
      Result := cMSDictImportTitle;
    CAP_EXPORT:
      Result := cMSDictExportTitle;
  else
    Result := '';
  end;
end;

function TMsDictParser.ExportItems(const Items,
  Orphans: ITranslationItems): HRESULT;
var
  S: TTntStringlist;
  FOldSort: TTranslateSortType;
begin
  WaitCursor;
  Result := S_FALSE;
  FOldSort := Items.Sort;
  try
    LoadSettings;
    Items.Sort := stIndex;
    S := TTntStringlist.Create;
    try
      BuildPreview(Items, S);
      if TfrmExport.Execute(FTransFile, cMsDictExportTitle, cMsDictFilter, '.', 'csv', S) then
      begin
        S.AnsiStrings.SaveToFile(FTransFile);
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

function WideContainsText(const AText, ASubText: WideString): boolean;
begin
  Result := Pos(WideUppercase(ASubText), WideUppercase(AText)) > 0;
end;

function TMsDictParser.ImportItems(const Items, Orphans: ITranslationItems): HRESULT;
var
  S: TTntStringlist;
  i: integer;

  procedure ParseItem(var S: PWideChar; _End: PWideChar; out Value: WideString);
  var
    Start: PWideChar;
    QuoteChar: WideChar;
  begin
    Value := '';
    if (S = nil) or (S = _End) then
      Exit;
    Start := S;
    if (S^ = WideChar('"')) or (S^ = WideChar('''')) then // starts with a quote, so should end with a quote
    begin
      QuoteChar := S^;
      Inc(S);
      Start := S;
      while True do
      begin
        if (S^ = QuoteChar) then
        begin
          // in Microsoft world, a quote char doesn't mean the string has ended unless it is directly followed by a comma...
          Inc(S);
          if (S^ = WideChar(',')) then
          begin
            SetString(Value, Start, S - Start - 1);
            Exit;
          end;
        end;
        if (S = _End) then
        begin
          SetString(Value, Start, S - Start);
          if S^ = QuoteChar then
            Inc(S);
          Exit;
        end;
        Inc(S);
      end
    end
    else
      while True do // no quote, so string ends at first comma
      begin
        if (S = _End) or (S^ = WideChar(',')) then
        begin
          SetString(Value, Start, S - Start);
          Exit;
        end;
        Inc(S);
      end;
  end;

  procedure AddItem(const Items: ITranslationItems; const S: WideString);
  var
    TI: ITranslationItem;
    AOrig, ATrans: WideString;
    P, R, _End: PWideChar;
    Cmt: WideString;
    ALength: integer;
  begin
    // Accroding to Microsoft, glossaries contain the following five mandatory columns:
    // Source Term, Translation (previously also called Target Term), String Category, Platform (previously also called Environment), Product

    // In practice, I've found that the glossaries actually has this format:
    // Source Term, ShortCut Letter, Translation, ShortCut Letter, String Category, Environment, Product

    // All items can be empty and are sometimes enclosed in double-quotes, sometimes not (even if they contain spaces).
    // Items are always enclosed in quotes if they contain commas.
    // Items can have embedded quotes of the same type that encloses the item. In those cases, the end of an item is
    // detected by checking for a comma after the quote char.
    // The files can (and often do) contain exact duplicate items.
    // The two first lines often (but not always) contains a Copyright notice and an empty line.
    // The files are saved as Unicode.

    // NB! In some cases an item is split on several lines. This parser cannot handle those items. To import
    // such a file, you will have to first manually edit it (in an editor that supports Unicode, like WordPad),
    // removing the unwanted CRLF's.
    Cmt := S;
    P := PWideChar(S);
    _End := P + Length(S);
    R := P;
    ParseItem(P, _End, AOrig);
    ALength := P - R;
    Delete(Cmt, 1, ALength);
    Insert('%s', Cmt, 1);
    if P^ = WideChar(',') then
      Inc(P);
    ParseItem(P, _End, ATrans);
    if P^ = WideChar(',') then
      Inc(P);
    R := P;
    ALength := P - PWideChar(S) - ALength + 3;
    ParseItem(P, _End, ATrans);
    Delete(Cmt, ALength, P - R);
    Insert('%s', Cmt, ALength);
    if AOrig <> '' then
    // if Items.IndexOf(cSectionName, AOrig) < 0 then // takes ages
    begin
      TI := Items.Add;
      TI.OrigComments := S;
      TI.TransComments := Cmt;

      TI.Section := cSectionName;
      P := PWideChar(AOrig);
      TI.Name := P;
      TI.Original := TI.Name;
      P := PWideChar(ATrans);
      TI.Translation := P;
      TI.Translated := TI.Translation <> '';
    end;
  end;
begin
  WaitCursor;
  Result := S_FALSE;
  try
    Items.Clear;
    Orphans.Clear;
    LoadSettings;
    if TfrmImport.Execute(FTransFile, FSkipLines, cMsDictImportTitle, cMsDictFilter, '.', 'csv') then
    begin
      Items.Sort := stNone;
      if FSkipLines < 0 then
        FSkipLines := 0;
      S := TTntStringlist.Create;
      try
        S.LoadFromFile(FTransFile);
        for i := FSkipLines to S.Count - 1 do
          AddItem(Items, S[i]);
        Items.Modified := false;
      finally
        Items.Sort := stIndex;
        S.Free;
      end;
      SaveSettings;
      Result := S_OK;
    end;
  except
    Application.HandleException(self);
  end;
end;

procedure TMsDictParser.Init(AppHandle: Cardinal);
begin
  Application.Handle := AppHandle;
end;

procedure TMsDictParser.LoadSettings;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
      FTransFile := ReadString('Settings', 'TransFile', FTransFile);
      FSkipLines := ReadInteger('Settings', 'SkipLines', 2);
    finally
      Free;
    end;
  except
    Application.HandleException(self);
  end;
end;

procedure TMsDictParser.SaveSettings;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
      WriteString('Settings', 'TransFile', FTransFile);
      WriteInteger('Settings', 'SkipLines', FSkipLines);
    finally
      Free;
    end;
  except
    Application.HandleException(self);
  end;
end;

end.

