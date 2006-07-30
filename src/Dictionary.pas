{@abstract(Utility functions and procedures) }
{
  Copyright © 2003-2006 by Peter Thornqvist; all rights reserved

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
unit Dictionary;

interface
uses
  SysUtils, Classes, TntClasses;

type
  TDictionaryItem = class
  private
    FTranslations: TTntStrings;
    FOriginal: WideString;
    FOnChange: TNotifyEvent;
    procedure SetTranslations(const Value: TTntStrings);
    procedure Change;
    procedure SetOriginal(const Value: WideString);
  public
    constructor Create;
    destructor Destroy; override;
    property Original: WideString read FOriginal write SetOriginal;
    property Translations: TTntStrings read FTranslations write SetTranslations;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TDictionaryItems = class(TPersistent)
  private
    FItems: TList;
    FIgnorePunctuation: boolean;
    FModified: boolean;
    function GetCount: integer;
    function GetItems(Index: integer): TDictionaryItem;
  protected
    procedure DoChange(Sender: TObject);
    procedure Merge;
  public
    procedure Invert;
    procedure Assign(Source:TPersistent);override;
    function Add(const AOriginal: WideString): TDictionaryItem; overload;
    function Add(var Item: TDictionaryItem): integer; overload;
    procedure Delete(Index: integer);
    function IndexOf(const S: WideString): integer;
    // find is like IndexOf but returns the index of where the item should be located
    function Find(const S: WideString; var Index: integer): boolean;
    procedure Clear;
    procedure Sort;
    constructor Create;
    destructor Destroy; override;
    property Items[Index: integer]: TDictionaryItem read GetItems; default;
    property Count: integer read GetCount;
    property Modified:boolean read FModified write FModified;
    procedure LoadFromFile(const Filename: WideString);
    procedure SaveToFile(const Filename: WideString);
    property IgnorePunctuation: boolean read FIgnorePunctuation write FIgnorePunctuation;
  end;

implementation
uses
  AppUtils, CommonUtils;

function StripPunctuation(const S: WideString): WideString;
var i, j: integer;
begin
  Result := S;
  j := 0;
  for i := 1 to Length(S) do
    if not IsCharPunct(S[i]) then
    begin
      Inc(j);
      Result[j] := S[i];
    end;
  SetLength(Result, j);
end;

function OriginalCompareIgnore(Item1, Item2: Pointer): integer;
begin
  Result := WideCompareText(StripPunctuation(TDictionaryItem(Item1).Original), StripPunctuation(TDictionaryItem(Item2).Original));
end;

function OriginalCompare(Item1, Item2: Pointer): integer;
begin
  Result := WideCompareText(TDictionaryItem(Item1).Original, TDictionaryItem(Item2).Original);
end;

{ TDictionaryItem }

procedure TDictionaryItem.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TDictionaryItem.Create;
begin
  inherited Create;
  FTranslations := TTntStringlist.Create;
  TTntStringlist(FTranslations).Sorted := true;
end;

destructor TDictionaryItem.Destroy;
begin
  FTranslations.Free;
  inherited Destroy;
end;

procedure TDictionaryItem.SetOriginal(const Value: WideString);
begin
  if FOriginal <> Value then
  begin
    FOriginal := Value;
    Change;
  end;
end;

procedure TDictionaryItem.SetTranslations(const Value: TTntStrings);
begin
  FTranslations.Assign(Value);
  Change;
end;

{ TDictionaryItems }

function TDictionaryItems.Add(const AOriginal: WideString): TDictionaryItem;
begin
  Assert(AOriginal <> '', 'The original string must not be empty');
  Result := TDictionaryItem.Create;
  Result.Original := AOriginal;
  Result.OnChange := DoChange;
  Add(Result);
end;

function TDictionaryItems.Add(var Item: TDictionaryItem): integer;
begin
  Assert(Item <> nil, 'Item not assigned');
  Assert(Item.Original <> '', 'The original string must not be empty');
  if not Find(Item.Original, Result) then
  begin
    FItems.Insert(Result, Item); // add a new item in it's correct position (no need to sort)
    Item.OnChange := DoChange; // make sure any changes to the original string is detected
  end
  else
  begin // just add any new translations
    Items[Result].Translations.AddStrings(Item.Translations);
    FreeAndNil(Item);
    Item := Items[Result];
  end;
  Modified := true;
end;

procedure TDictionaryItems.Assign(Source: TPersistent);
var i:integer;
begin
  if Source = nil then
    Clear
  else if Source is TDictionaryItems then
  begin
    Clear;
    for i := 0 to TDictionaryItems(Source).Count - 1 do
      Add(TDictionaryItems(Source).Items[i].Original).Translations.Assign(TDictionaryItems(Source).Items[i].Translations);
  end
  else
  begin
    inherited Assign(Source);
    Exit;
  end;
  Modified := true;
end;

procedure TDictionaryItems.Clear;
var i: integer;
begin
  for i := FItems.Count - 1 downto 0 do
    TDictionaryItems(FItems[i]).Free;
  FItems.Clear;
  Modified := true;
end;

constructor TDictionaryItems.Create;
begin
  inherited Create;
  FItems := TList.Create;
end;

procedure TDictionaryItems.Delete(Index: integer);
var P: TDictionaryItem;
begin
  P := Items[Index];
  FItems.Delete(Index);
  P.Free;
  Modified := true;
end;

destructor TDictionaryItems.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited;
end;

procedure TDictionaryItems.DoChange(Sender: TObject);
begin
  // always sort after the original string has been changed, so it ends up in the right position
  Sort;
  Merge;
  Modified := true;
end;

function TDictionaryItems.Find(const S: WideString;
  var Index: integer): boolean;
var AItem: TDictionaryItem;
begin
  AItem := TDictionaryItem.Create;
  try
    AItem.Original := S;
    if IgnorePunctuation then
      Result := BinarySearch(FItems, 0, FItems.Count - 1, AItem, OriginalCompareIgnore, Index)
    else
      Result := BinarySearch(FItems, 0, FItems.Count - 1, AItem, OriginalCompare, Index);
  finally
    AItem.Free;
  end;
end;

function TDictionaryItems.GetCount: integer;
begin
  Result := FItems.Count;
end;

function TDictionaryItems.GetItems(Index: integer): TDictionaryItem;
begin
  Result := TDictionaryItem(FItems[Index]);
end;

function TDictionaryItems.IndexOf(const S: WideString): integer;
begin
  if not Find(S, Result) then
    Result := -1;
end;

procedure TDictionaryItems.Invert;
var
  i, j: integer;
  tmp: TDictionaryItems;
begin
  tmp := TDictionaryItems.Create;
  try
    for i := 0 to Count - 1 do
      for j := 0 to Items[i].Translations.Count - 1 do
        tmp.Add(Items[i].Translations[j]).Translations.Add(Items[i].Original);
    Clear;
    for i := 0 to tmp.Count - 1 do
      Add(tmp[i].Original).Translations := tmp[i].Translations;
  finally
    tmp.Free;
  end;
  Modified := true;
end;

procedure TDictionaryItems.LoadFromFile(const Filename: WideString);
var
  AFile, AValues: TTntStringlist;
  i: integer;
  AItem: TDictionaryItem;
begin
  // format:
  // original=translation, translation, translation[,translation]
  Clear;
  AFile := TTNtStringlist.Create;
  AValues := TTNtStringlist.Create;
  try
    AFile.LoadFromFile(Filename);
    for i := 0 to AFile.Count - 1 do
    begin
      if AFile.Names[i] <> '' then
      begin
        AItem := TDictionaryItem.Create;
        AItem.Original := AFile.Names[i];
        AValues.CommaText := ValueFromIndex(AFile, i);
        AItem.Translations := AValues;
        Add(AItem);
      end;
    end;
    Merge;

  finally
    AFile.Free;
    AValues.Free;
  end;
  Modified := false;
end;

procedure TDictionaryItems.Merge;
var
  ACurrentOriginal: WideString;
  i: integer;
begin
  ACurrentOriginal := ''; // we don't allow empty originals, so this value should never appear in the list
  i := 0;
  while true do
  begin
    while (i < Count) and WideSameText(ACurrentOriginal, Items[i].Original) do
    begin
      // Since ACurrentOriginal is the same as the current item, it means that
      // we've already seen this item, i.e it's the same as the previous one (the list is sorted),
      // so copy the translations of the current item to the previous item...
      Items[i - 1].Translations.AddStrings(Items[i].Translations);
      // ...and remove the item
      Delete(i);
      Modified := true;
    end;
    if i < Count then
      ACurrentOriginal := Items[i].Original
    else
      Break;
    // TODO: merge duplicate items
    Inc(i);
  end;
end;

procedure TDictionaryItems.SaveToFile(const Filename: WideString);
var
  AFile: TTntStringlist;
  i: integer;
begin
  AFile := TTNtStringlist.Create;
  try
    for i := 0 to Count - 1 do
      AFile.Add(Items[i].Original + '=' + Items[i].Translations.CommaText);
    AFile.SaveToFile(Filename);
  finally
    AFile.Free;
  end;
  Modified := false;
end;

procedure TDictionaryItems.Sort;
begin
  FItems.Sort(OriginalCompare);
end;

end.
