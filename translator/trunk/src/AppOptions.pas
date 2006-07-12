{@abstract(Options class for application) }
{
  Copyright � 2003-2004 by Peter Thornqvist; all rights reserved

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
// $Id: AppOptions.pas,v 1.26 2006/07/07 10:18:37 peter3 Exp $
unit AppOptions;
{$I TRANSLATOR.INC}

interface
uses
  Classes, Forms, Types, SysUtils, Graphics, IniFiles;

type
  PAppWindowInfo = ^TAppWindowInfo;
  TAppWindowInfo = record
    Name: shortstring;
    BoundsRect: TRect;
    WindowState: TWindowState;
  end;

  TToolItem = class(TCollectionItem)
  private
    FCaptureOutput: boolean;
    FWaitForCompletion: boolean;
    FPromptForArguments: boolean;
    FInitialDirectory: string;
    FArguments: string;
    FTitle: string;
    FCommand: string;
    FUseShellExecute: boolean;
    FShortCut: Word;
    function GetAsString: string;
    procedure SetAsString(const Value: string);
  public
    procedure Assign(Source: TPersistent); override;
    property AsString: string read GetAsString write SetAsString;
  published
    property Title: string read FTitle write FTitle;
    property Command: string read FCommand write FCommand;
    property Arguments: string read FArguments write FArguments;
    property InitialDirectory: string read FInitialDirectory write FInitialDirectory;
    property CaptureOutput: boolean read FCaptureOutput write FCaptureOutput;
    property PromptForArguments: boolean read FPromptForArguments write FPromptForArguments;
    property WaitForCompletion: boolean read FWaitForCompletion write FWaitForCompletion;
    property UseShellExecute: boolean read FUseShellExecute write FUseShellExecute;
    property ShortCut: Word read FShortCut write FShortCut;
  end;

  TToolItems = class(TCollection)
  private
    function GetItem(Index: integer): TToolItem;
    procedure SetItem(Index: integer; const Value: TToolItem);
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    function Add: TToolItem;
    function IndexOf(const Title: string): integer;
    procedure Exchange(Index1, Index2: integer);
    procedure LoadFromIni(ini: TCustomIniFile);
    procedure SaveToIni(ini: TCustomIniFile);
    property Items[Index: integer]: TToolItem read GetItem write SetItem; default;
  end;

  TAppOptions = class
  private
    FWindowInfos: TStrings;
    FInvertDictionary: boolean;
    FSaveFormPos: boolean;
    FSaveOnReturn: boolean;
    FShowToolTips: boolean;
    FAutoMoveToNext: boolean;
    FShowDetails: boolean;
    FShowQuotes: boolean;
    FShowToolTipShortCuts: boolean;
    FSaveMinMaxState: boolean;
    FSplitterPosition: integer;
    FAppTitle: WideString;
    FOriginalFile: string;
    FLanguageFile: string;
    FTranslationFile: string;
    FHelpFile: string;
    FDictionaryFile: string;
    FFilename: string;
    FAppFont: TFont;
    FFilterIndex: integer;
    FGlobalPath: boolean;
    FPinCommentWindow: boolean;
    FMatchCase: boolean;
    FMatchLine: boolean;
    FSearchUp: boolean;
    FFindText: WideString;
    FReplaceText: WideString;
    FReplaceHistory: WideString;
    FFindHistory: WideString;
    FFindInIndex: integer;
    FTransEncoding: integer;
    FOrigEncoding: integer;
    FMonitorFiles: boolean;
    FTheme: string;
    FFuzzySearch: boolean;
    FDictIgnoreSpeedKeys: boolean;
    FShowFullNameInColumns: boolean;
    FUseTranslationEverywhere: boolean;
    FAutoFocusTranslation: boolean;
    FTools: TToolItems;
    FTrimWhiteSpace: boolean;
    FTrimHow: integer;
    FTrimWhere: integer;
    FTrimWhat: string;
    FMisMatchItems: string;
    FMisMatchTrailingSpaces: boolean;
    FMisMatchLeadingSpaces: boolean;
    FMisMatchIdentical: boolean;
    FMisMatchEmptyTranslation: boolean;
    FMisMatchEndControl: boolean;
    FDictIgnoreNonEmpty: boolean;
    FDictEditFilter: Integer;
    procedure ReadWindowInfos(ini: TCustomIniFile);
    procedure WriteWindowInfos(ini: TCustomIniFile);
    function GetWindowInfo(AForm: TForm): TAppWindowInfo;
    procedure SetWindowInfo(AForm: TForm; const Value: TAppWindowInfo);
    procedure SetTools(const Value: TToolItems);
  public
    constructor Create(const AFilename: string);
    destructor Destroy; override;
    procedure ClearWindowInfos;
    procedure SaveToFile(AFilename: string);
    procedure LoadFromFile(AFilename: string);
    property Filename: string read FFilename;
    property WindowInfos[AForm: TForm]: TAppWindowInfo read GetWindowInfo write SetWindowInfo;
  public
    property ShowQuotes: boolean read FShowQuotes write FShowQuotes;
    property InvertDictionary: boolean read FInvertDictionary write FInvertDictionary;
    property SaveFormPos: boolean read FSaveFormPos write FSaveFormPos default true;
    property SaveMinMaxState: boolean read FSaveMinMaxState write FSaveMinMaxState default true;
    property ShowDetails: boolean read FShowDetails write FShowDetails;
    property SaveOnReturn: boolean read FSaveOnReturn write FSaveOnReturn;
    property AutoMoveToNext: boolean read FAutoMoveToNext write FAutoMoveToNext;
    property ShowToolTips: boolean read FShowToolTips write FShowToolTips;
    property ShowToolTipShortCuts: boolean read FShowToolTipShortCuts write FShowToolTipShortCuts;
    property DictIgnoreSpeedKeys: boolean read FDictIgnoreSpeedKeys write FDictIgnoreSpeedKeys;
    property LanguageFile: string read FLanguageFile write FLanguageFile;
    property GlobalPath: boolean read FGlobalPath write FGlobalPath;
    property UseTranslationEverywhere: boolean read FUseTranslationEverywhere write FUseTranslationEverywhere;
    property AutoFocusTranslation: boolean read FAutoFocusTranslation write FAutoFocusTranslation;
    property HelpFile: string read FHelpFile write FHelpFile;
    property DictionaryFile: string read FDictionaryFile write FDictionaryFile;
    property TranslationFile: string read FTranslationFile write FTranslationFile;
    property TransEncoding: integer read FTransEncoding write FTransEncoding;
    property OriginalFile: string read FOriginalFile write FOriginalFile;
    property OrigEncoding: integer read FOrigEncoding write FOrigEncoding;
    property SplitterPosition: integer read FSplitterPosition write FSplitterPosition default 160;
    property FilterIndex: integer read FFilterIndex write FFilterIndex default 1;
    property AppTitle: WideString read FAppTitle write FAppTitle;
    property AppFont: TFont read FAppFont;
    property MonitorFiles: boolean read FMonitorFiles write FMonitorFiles default true;
    property Theme: string read FTheme write FTheme;
    // find replace
    property FindText: WideString read FFindText write FFindText;
    property ReplaceText: WideString read FReplaceText write FReplaceText;
    property FindHistory: WideString read FFindHistory write FFindHistory;
    property ReplaceHistory: WideString read FReplaceHistory write FReplaceHistory;
    property MatchLine: boolean read FMatchLine write FMatchLine;
    property MatchCase: boolean read FMatchCase write FMatchCase;
    property SearchUp: boolean read FSearchUp write FSearchUp;
    property FuzzySearch: boolean read FFuzzySearch write FFuzzySearch;
    property FindInIndex: integer read FFindInIndex write FFindInIndex;
    // trim
    property TrimWhat: string read FTrimWhat write FTrimWhat;
    property TrimWhere: integer read FTrimWhere write FTrimWhere;
    property TrimHow: integer read FTrimHow write FTrimHow;
    property TrimWhiteSpace: boolean read FTrimWhiteSpace write FTrimWhiteSpace;

    property MisMatchItems: string read FMisMatchItems write FMisMatchItems;
    property MisMatchLeadingSpaces: boolean read FMisMatchLeadingSpaces write FMisMatchLeadingSpaces;
    property MisMatchTrailingSpaces: boolean read FMisMatchTrailingSpaces write FMisMatchTrailingSpaces;
    property MisMatchEndControl: boolean read FMisMatchEndControl write FMisMatchEndControl;
    property MisMatchIdentical: boolean read FMisMatchIdentical write FMisMatchIdentical;
    property MisMatchEmptyTranslation: boolean read FMisMatchEmptyTranslation write FMisMatchEmptyTranslation;

    property PinCommentWindow: boolean read FPinCommentWindow write FPinCommentWindow default true;
    property ShowFullNameInColumns: boolean read FShowFullNameInColumns write FShowFullNameInColumns default false;
    property Tools: TToolItems read FTools write SetTools;

    property DictIgnoreNonEmpty:boolean read FDictIgnoreNonEmpty write FDictIgnoreNonEmpty;
    property DictEditFilter:Integer read FDictEditFilter write FDictEditFilter;
  end;

implementation
uses
  StrUtils, AppConsts, TntClasses, AppUtils;

function StrToFontStyles(const S: string): TFontStyles;
begin
  Result := [];
  if AnsiPos('B', S) > 0 then
    Include(Result, fsBold);
  if AnsiPos('I', S) > 0 then
    Include(Result, fsItalic);
  if AnsiPos('U', S) > 0 then
    Include(Result, fsUnderline);
  if AnsiPos('S', S) > 0 then
    Include(Result, fsStrikeout);
end;

function FontStylesToStr(Styles: TFontStyles): string;
const
  cStyles: array[TFontStyle] of PChar = ('B', 'I', 'U', 'S');
var
  i: TFontStyle;
begin
  Result := '';
  for i := Low(cStyles) to High(cStyles) do
    if i in Styles then
      Result := Result + cStyles[i];
end;

{ TToolItem }

procedure TToolItem.Assign(Source: TPersistent);
begin
  if Source is TToolItem then
    AsString := TToolItem(Source).AsString
  else
    inherited;
end;

function TToolItem.GetAsString: string;
var S: TTntStringlist;
begin
  S := TTntStringlist.Create;
  try
    S.Add(Title);
    S.Add(Command);
    S.Add(Arguments);
    S.Add(InitialDirectory);
    S.Add(BoolToStr(CaptureOutput, true));
    S.Add(BoolToStr(PromptForArguments, true));
    S.Add(BoolToStr(WaitForCompletion, true));
    S.Add(BoolToStr(UseShellExecute, true));
    S.Add(IntToStr(ShortCut));
    Result := S.CommaText;
  finally
    S.Free;
  end;
end;

procedure TToolItem.SetAsString(const Value: string);
var S: TTntStringlist;
begin
  S := TTntStringlist.Create;
  try
    S.CommaText := Value;
    if S.Count > 0 then
      Title := S[0];
    if S.Count > 1 then
      Command := S[1];
    if S.Count > 2 then
      Arguments := S[2];
    if S.Count > 3 then
      InitialDirectory := S[3];
    if S.Count > 4 then
      CaptureOutput := SameText(S[4], 'true');
    if S.Count > 5 then
      PromptForArguments := SameText(S[5], 'true');
    if S.Count > 6 then
      WaitForCompletion := SameText(S[6], 'true');
    if S.Count > 7 then
      UseShellExecute := SameText(S[7], 'true');
    if S.Count > 8 then
      ShortCut := StrToIntDef(S[8], ShortCut);
  finally
    S.Free;
  end;
end;

{ TToolItems }

function TToolItems.Add: TToolItem;
begin
  Result := TToolItem(inherited Add);
end;

procedure TToolItems.Assign(Source: TPersistent);
var i: integer;
begin
  if Source is TToolItems then
  begin
    Clear;
    for i := 0 to TToolItems(Source).Count - 1 do
      Add.Assign(TToolItems(Source)[i]);
  end
  else
    inherited;
end;

constructor TToolItems.Create;
begin
  inherited Create(TToolItem);
end;

procedure TToolItems.Exchange(Index1, Index2: integer);
var F: TToolItem;
begin
  F := Add;
  F.Assign(Items[Index1]);
  Items[Index1] := Items[Index2];
  Items[Index2] := F;
  Delete(Count - 1);
end;

function TToolItems.GetItem(Index: integer): TToolItem;
begin
  Result := TToolItem(inherited Items[Index]);
end;

function TToolItems.IndexOf(const Title: string): integer;
begin
  for Result := 0 to Count - 1 do
    if WideSameText(Items[Result].Title, Title) then
      Exit;
  Result := -1;
end;

procedure TToolItems.LoadFromIni(ini: TCustomIniFile);
var
  i: integer;
  S: TStringlist;

  function ValueFromIndex(S: TStrings; i: integer): string;
  begin
    if (i >= 0) and (i < S.Count) then
    begin
      Result := S[i];
      i := Pos('=', Result);
      if i > 0 then
        Result := Copy(Result, i + 1, MaxInt)
      else
        Result := '';
    end;
  end;
begin
  Clear;
  S := TStringlist.Create;
  try
    ini.ReadSectionValues('External Tools', S);
    for i := 0 to S.Count - 1 do
      Add.AsString := ValueFromIndex(S, i);
  finally
    S.Free;
  end;
end;

procedure TToolItems.SaveToIni(ini: TCustomIniFile);
var i: integer;
begin
  ini.EraseSection('External Tools');
  for i := 0 to Count - 1 do
    ini.WriteString('External Tools', IntToStr(i), Items[i].AsString);
end;

procedure TToolItems.SetItem(Index: integer; const Value: TToolItem);
begin
  inherited Items[Index] := Value;
end;

{ TAppOptions }

procedure TAppOptions.ClearWindowInfos;
var i: integer;
begin
  for i := 0 to FWindowInfos.Count - 1 do
    Dispose(PAppWindowInfo(FWindowInfos.Objects[i]));
  FWindowInfos.Clear;
end;

constructor TAppOptions.Create(const AFilename: string);
resourcestring
  sDefault = 'Default';
begin
  inherited Create;
  FTools := TToolItems.Create;
  // set defaults
  FAppFont := TFont.Create;
  FAppFont.Name := 'MS Shell Dlg 2';
  FWindowInfos := TStringlist.Create;
  TStringlist(FWindowInfos).Sorted := true;

  SplitterPosition := 160;
  SaveFormPos := true;
  SaveMinMaxState := true;
  AppTitle := SAppTitle;
  HelpFile := ExtractFilePath(Application.ExeName) + 'help\translator.html';
  FilterIndex := 1;
  PinCommentWindow := true;
  MonitorFiles := true;
  Theme := sDefault;
  LoadFromFile(AFilename);
end;

destructor TAppOptions.Destroy;
begin
  ClearWindowInfos;
  FAppFont.Free;
  FWindowInfos.Free;
  FTools.Free;
  inherited;
end;

{$J+ }

function strtok(Search, Delim: string): string;
const

  I: integer = 1;
  Len: integer = 0;
  PrvStr: string = '';
begin
  Result := '';
  if Search <> '' then
  begin
    I := 1;
    PrvStr := Search;
    Len := Length(PrvStr);
  end;
  if PrvStr = '' then
    Exit;
  while (i <= Len) and (AnsiPos(PrvStr[i], Delim) > 0) do
    Inc(I);
  while (i <= Len) and (AnsiPos(PrvStr[i], Delim) = 0) do
  begin
    Result := Result + PrvStr[i];
    Inc(i);
  end;
end;
{$J- }

procedure TAppOptions.ReadWindowInfos(ini: TCustomIniFile);
var
  i: integer;
  S: TStringlist;

  procedure DecodeInfo(const Name, Value: string);
  var P: PAppWindowInfo;
  begin
    // format of Value: Left;Top;Right;Bottom;WindowState
    if (FWindowInfos.IndexOf(Name) < 0) then
    begin
      New(P);
      with P^.BoundsRect do
      begin
        Left := StrToIntDef(strtok(Value, ';'), 0);
        Top := StrToIntDef(strtok('', ';'), 0);
        Right := StrToIntDef(strtok('', ';'), 0);
        Bottom := StrToIntDef(strtok('', ';'), 0);
        P^.WindowState := TWindowState(StrToIntDef(strtok('', ';'), 0));
      end;
      FWindowInfos.AddObject(Name, TObject(P));
    end;
  end;
begin
  ClearWindowInfos;
  S := TStringlist.Create;
  try
    ini.ReadSectionValues('Windows', S);
    for i := 0 to S.Count - 1 do
      DecodeInfo(S.Names[i], S.Values[S.Names[i]]);
  finally
    S.Free;
  end;
end;

procedure TAppOptions.LoadFromFile(AFilename: string);
var
  ini: TMemIniFile;
begin
  if AFilename = '' then
    AFilename := GetAppStoragePath + 'translator.ini';
  ini := TMemIniFile.Create(AFilename);
  try
    FFilename := AFilename;
    FAppFont.Name := ini.ReadString('Font', 'Font.Name', FAppFont.Name);
    FAppFont.Height := ini.ReadInteger('Font', 'Font.Height', FAppFont.Height);
    FAppFont.Style := StrToFontStyles(ini.ReadString('Font', 'Font.Style', FontStylesToStr(FAppFont.Style)));
    FAppFont.Color := ini.ReadInteger('Font', 'Font.Color', FAppFont.Color);

    ShowQuotes := ini.ReadBool('General', 'ShowQuotes', ShowQuotes);
    InvertDictionary := ini.ReadBool('General', 'InvertDictionary', InvertDictionary);
    SaveFormPos := ini.ReadBool('General', 'SaveFormPos', SaveFormPos);
    SaveMinMaxState := ini.ReadBool('General', 'SaveMinMaxState', SaveMinMaxState);
    ShowDetails := ini.ReadBool('General', 'ShowDetails', ShowDetails);
    SaveOnReturn := ini.ReadBool('General', 'SaveOnReturn', SaveOnReturn);
    AutoMoveToNext := ini.ReadBool('General', 'AutoMoveToNext', AutoMoveToNext);
    ShowToolTips := ini.ReadBool('General', 'ShowToolTips', ShowToolTips);
    ShowToolTipShortCuts := ini.ReadBool('General', 'ShowToolTipShortCuts', ShowToolTipShortCuts);
    DictIgnoreSpeedKeys := ini.ReadBool('General', 'DictIgnoreSpeedKeys', DictIgnoreSpeedKeys);
    SplitterPosition := ini.ReadInteger('General', 'SplitterPosition', SplitterPosition);
    AppTitle := ini.ReadString('General', 'AppTitle', AppTitle);
    GlobalPath := ini.ReadBool('General', 'GlobalPath', GlobalPath);
    UseTranslationEverywhere := ini.ReadBool('General', 'UseTranslationEverywhere', UseTranslationEverywhere);
    AutoFocusTranslation := ini.ReadBool('General', 'AutoFocusTranslation', AutoFocusTranslation);
    FilterIndex := ini.ReadInteger('Files', 'FilterIndex', FilterIndex);
    LanguageFile := ini.ReadString('Files', 'LanguageFile', LanguageFile);
    HelpFile := ini.ReadString('Files', 'HelpFile', HelpFile);
    DictionaryFile := ini.ReadString('Files', 'DictionaryFile', DictionaryFile);
    TranslationFile := ini.ReadString('Files', 'TranslationFile', TranslationFile);
    OriginalFile := ini.ReadString('Files', 'OriginalFile', OriginalFile);
    TransEncoding := ini.ReadInteger('Files', 'TransEncoding', TransEncoding);
    OrigEncoding := ini.ReadInteger('Files', 'OrigEncoding', OrigEncoding);
    MonitorFiles := ini.ReadBool('Files', 'MonitorFiles', MonitorFiles);
    Theme := ini.ReadString('General', 'Theme', Theme);
    DictIgnoreNonEmpty := ini.ReadBool('General', 'DictIgnoreNonEmpty', false);
    DictEditFilter := ini.ReadInteger('General', 'DictEditFilter', 0);

    PinCommentWindow := ini.ReadBool('Comments', 'PinCommentWindow', PinCommentWindow);
    ShowFullNameInColumns := ini.ReadBool('General', 'ShowFullNameInColumns', ShowFullNameInColumns);

    // find/replace dialog
    FindText := ini.ReadString('FindReplace', 'FindText', FindText);
    ReplaceText := ini.ReadString('FindReplace', 'ReplaceText', ReplaceText);
    FindHistory := ini.ReadString('FindReplace', 'FindHistory', FindHistory);
    ReplaceHistory := ini.ReadString('FindReplace', 'ReplaceHistory', ReplaceHistory);
    MatchLine := ini.ReadBool('FindReplace', 'MatchLine', MatchLine);
    MatchCase := ini.ReadBool('FindReplace', 'MatchCase', MatchCase);
    SearchUp := ini.ReadBool('FindReplace', 'SearchUp', SearchUp);
    FuzzySearch := ini.ReadBool('FindReplace', 'FuzzySearch', FuzzySearch);
    FindInIndex := ini.ReadInteger('FindReplace', 'FindInIndex', FindInIndex);
    if (FindInIndex < 0) or (FindInIndex > 2) then
      FindInIndex := 0;

    TrimWhat := ini.ReadString('Trim', 'TrimWhat', '');
    TrimWhere := ini.ReadInteger('Trim', 'TrimWhere', cTrimTranslation);
    TrimHow := ini.ReadInteger('Trim', 'TrimHow', cTrimBoth);
    TrimWhiteSpace := ini.ReadBool('Trim', 'TrimWhiteSpace', true);

    MisMatchItems := ini.ReadString('MisMatch', 'Items', '&,!,...,?,:,!');
    MisMatchLeadingSpaces := ini.ReadBool('MisMatch', 'MisMatchLeadingSpaces', true);
    MisMatchTrailingSpaces := ini.ReadBool('MisMatch', 'MisMatchTrailingSpaces', true);
    MisMatchEndControl := ini.ReadBool('MisMatch', 'MisMatchEndControl', true);
    MisMatchIdentical := ini.ReadBool('MisMatch', 'MisMatchIdentical', true);
    MisMatchEmptyTranslation := ini.ReadBool('MisMatch', 'MisMatchEmptyTranslation', true);

    ReadWindowInfos(ini);
    FTools.LoadFromIni(ini);
  finally
    ini.Free;
  end;
end;

procedure TAppOptions.WriteWindowInfos(ini: TCustomIniFile);
var
  i: integer;

  function EncodeInfo(Info: TAppWindowInfo): string;
  begin
    // format of value: Left;Top;Right;Bottom;WindowState;
    with Info.BoundsRect do
      Result :=
        Format('%d;%d;%d;%d;%d;', [Left, Top, Right, Bottom, Ord(Info.WindowState)]);
  end;
begin
  ini.EraseSection('Windows');
  for i := 0 to FWindowInfos.Count - 1 do
    ini.WriteString('Windows', FWindowInfos[i],
      EncodeInfo(PAppWindowInfo(FWindowInfos.Objects[i])^));
end;

procedure TAppOptions.SaveToFile(AFilename: string);
var
  ini: TMemIniFile;
begin
  if AFilename = '' then
    AFilename := GetAppStoragePath + 'translator.ini';
  ini := TMemIniFile.Create(AFilename);
  try
    FFilename := AFilename;
    ini.WriteString('Font', 'Font.Name', FAppFont.Name);
    ini.WriteInteger('Font', 'Font.Height', FAppFont.Height);
    ini.WriteString('Font', 'Font.Style', FontStylesToStr(FAppFont.Style));
    ini.WriteInteger('Font', 'Font.Color', FAppFont.Color);

    ini.WriteBool('General', 'ShowQuotes', ShowQuotes);
    ini.WriteBool('General', 'InvertDictionary', InvertDictionary);
    ini.WriteBool('General', 'SaveFormPos', SaveFormPos);
    ini.WriteBool('General', 'SaveMinMaxState', SaveMinMaxState);
    ini.WriteBool('General', 'ShowDetails', ShowDetails);
    ini.WriteBool('General', 'SaveOnReturn', SaveOnReturn);
    ini.WriteBool('General', 'AutoMoveToNext', AutoMoveToNext);
    ini.WriteBool('General', 'ShowToolTips', ShowToolTips);
    ini.WriteBool('General', 'ShowToolTipShortCuts', ShowToolTipShortCuts);
    ini.WriteBool('General', 'DictIgnoreSpeedKeys', DictIgnoreSpeedKeys);
    ini.WriteInteger('General', 'SplitterPosition', SplitterPosition);
    ini.WriteString('General', 'AppTitle', AppTitle);
    ini.WriteBool('General', 'GlobalPath', GlobalPath);
    ini.WriteBool('General', 'UseTranslationEverywhere', UseTranslationEverywhere);
    ini.WriteBool('General', 'AutoFocusTranslation', AutoFocusTranslation);

    ini.WriteInteger('Files', 'FilterIndex', FilterIndex);
    ini.WriteString('Files', 'LanguageFile', LanguageFile);
    ini.WriteString('Files', 'HelpFile', HelpFile);
    ini.WriteString('Files', 'DictionaryFile', DictionaryFile);
    ini.WriteString('Files', 'TranslationFile', TranslationFile);
    ini.WriteString('Files', 'OriginalFile', OriginalFile);
    ini.WriteInteger('Files', 'OrigEncoding', OrigEncoding);
    ini.WriteInteger('Files', 'TransEncoding', TransEncoding);
    ini.WriteBool('Files', 'MonitorFiles', MonitorFiles);
    ini.WriteString('General', 'Theme', Theme);
    ini.WriteBool('General', 'DictIgnoreNonEmpty', DictIgnoreNonEmpty);
    ini.WriteInteger('General', 'DictEditFilter', DictEditFilter);

    ini.WriteBool('Comments', 'PinCommentWindow', PinCommentWindow);
    ini.WriteBool('General', 'ShowFullNameInColumns', ShowFullNameInColumns);
    // find replace dialog
    ini.WriteString('FindReplace', 'FindText', FindText);
    ini.WriteString('FindReplace', 'ReplaceText', ReplaceText);
    ini.WriteString('FindReplace', 'FindHistory', trim(FindHistory));
    ini.WriteString('FindReplace', 'ReplaceHistory', trim(ReplaceHistory));
    ini.WriteBool('FindReplace', 'MatchLine', MatchLine);
    ini.WriteBool('FindReplace', 'MatchCase', MatchCase);
    ini.WriteBool('FindReplace', 'SearchUp', SearchUp);
    ini.WriteBool('FindReplace', 'FuzzySearch', FuzzySearch);
    ini.WriteInteger('FindReplace', 'FindInIndex', FindInIndex);
    ini.WriteString('Trim', 'TrimWhat', TrimWhat);
    ini.WriteInteger('Trim', 'TrimWhere', TrimWhere);
    ini.WriteInteger('Trim', 'TrimHow', TrimHow);
    ini.WriteBool('Trim', 'TrimWhiteSpace', TrimWhiteSpace);
    ini.WriteString('MisMatch', 'Items', MisMatchItems);
    ini.WriteBool('MisMatch', 'MisMatchLeadingSpaces', MisMatchLeadingSpaces);
    ini.WriteBool('MisMatch', 'MisMatchTrailingSpaces', MisMatchTrailingSpaces);
    ini.WriteBool('MisMatch', 'MisMatchEndControl', MisMatchEndControl);
    ini.WriteBool('MisMatch', 'MisMatchIdentical', MisMatchIdentical);
    ini.WriteBool('MisMatch', 'MisMatchEmptyTranslation', MisMatchEmptyTranslation);

    WriteWindowInfos(ini);
    FTools.SaveToIni(ini);
    ini.UpdateFile;
  finally
    ini.Free;
  end;
end;

function TAppOptions.GetWindowInfo(AForm: TForm): TAppWindowInfo;
var
  i: integer;
  AName: string;
begin
  Result.BoundsRect := AForm.BoundsRect;
  Result.WindowState := AForm.WindowState;
  if not SaveFormPos then
    Exit;
  AName := AForm.Name;
  if AName = '' then
    AName := Copy(AForm.ClassName, 2, MaxInt);
  i := FWindowInfos.IndexOf(AName);
  if (i >= 0) then
  begin
    Result.BoundsRect := PAppWindowInfo(FWindowInfos.Objects[i])^.BoundsRect;
    if IsRectEmpty(Result.BoundsRect) then
      Result.BoundsRect := AForm.BoundsRect;
    if SaveMinMaxState then
      Result.WindowState := PAppWindowInfo(FWindowInfos.Objects[i])^.WindowState;
  end;
end;

procedure TAppOptions.SetWindowInfo(AForm: TForm;
  const Value: TAppWindowInfo);
var
  i: integer;
  P: PAppWindowInfo;
  AName: string;
begin
  if not SaveFormPos then
    Exit;
  AName := AForm.Name;
  if AName = '' then
    AName := Copy(AForm.ClassName, 2, MaxInt);
  i := FWindowInfos.IndexOf(AName);
  if (i >= 0) then
  begin
    P := PAppWindowInfo(FWindowInfos.Objects[i]);
    if Value.WindowState = wsNormal then
      P^.BoundsRect := Value.BoundsRect;
    if SaveMinMaxState then
      P^.WindowState := Value.WindowState
    else
      P^.WindowState := wsNormal;
  end
  else
  begin
    New(P);
    P^.BoundsRect := Value.BoundsRect;
    if SaveMinMaxState then
      P^.WindowState := Value.WindowState
    else
      P^.WindowState := wsNormal;
    FWindowInfos.AddObject(AForm.Name, TObject(P));
  end;
end;

procedure TAppOptions.SetTools(const Value: TToolItems);
begin
  FTools.Assign(Value);
end;

end.
