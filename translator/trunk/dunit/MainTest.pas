{@abstract(dunit test cases for translator) }
{

  Copyright © 2003 by Peter Thornqvist; all rights reserved

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
unit MainTest;

interface

uses
  Classes,
  TestFrameWork, // get dunit from http://dunit.sourceforge.net
  TransIntf, 
  TranslateFile;

type
  TTranslateFileCreator = class
  private
    FTranslateFile: TTranslateFiles;
    FOriginal: string;
    FTranslation: string;
    procedure SetOriginal(const Value: string);
    procedure SetTranslation(const Value: string);
  public
    constructor Create(const AOriginal, ATranslation: string);
    destructor Destroy; override;
    property TranslateFile: TTranslateFiles read FTranslateFile;
    property Original: string read FOriginal write SetOriginal;
    property Translation: string read FTranslation write SetTranslation;
  end;

  TTranslateFilesTest = class(TTestCase)
  private
    FC: TTranslateFiles;
    function MakeQualifiedFilename(const Filename: string): string;
  protected

    procedure SetUp; override;
    procedure TearDown; override;
    procedure LoadOriginal(Filename: string);
    procedure LoadTranslation(Filename: string);
    procedure SaveOriginal(Filename: string);
    procedure SaveTranslation(Filename: string);
  protected
     { these not implemented yet }
    procedure TestOrphans;
    procedure TestSeparators;

  published
    procedure AddTest;
    procedure DeleteTest;
    procedure ClearTest;
    procedure FindTest;
    procedure SortTypeTest;
    procedure TranslatedCountTest;
    procedure TranslatedCountTest2;
    procedure TranslatedCountTest3;
    procedure TranslatedCountTest4;
    procedure IndexTest;
    procedure SaveToFileTest;
    procedure LoadFromFileTest;
  end;

  TTranslateUtilsTest = class(TTestCase)
  published
    procedure TrimCRLFRightTest;
    procedure StripCharsTest;
    procedure MatchesStringTest;
    procedure StripKeyTest;
    procedure StripKeysTest;
    procedure StrBetweenTest;
    procedure StrDefaultTest;
    procedure DoubleQuoteStringTest;
  end;

implementation
uses
  Windows, SysUtils, AppUtils, CommonUtils, AppConsts;

const
  aItemCount = 120;
  aLowBound = 5;
  aDefaultSectionName = '';

function IsValidFilename(const Filename: string): boolean;
var
  buf1: array[0..MAX_PATH] of char;
  buf2: PChar;
begin
  Result := (Filename <> '') and (GetFullPathName(PChar(Filename), sizeof(buf1), buf1, buf2) <> 0);
end;

{ TTranslateFileCreator }

constructor TTranslateFileCreator.Create(const AOriginal, ATranslation: string);
begin
  inherited Create;
  FTranslateFile := TTranslateFiles.Create;
  Original := AOriginal;
  Translation := ATranslation;
end;

destructor TTranslateFileCreator.Destroy;
begin
  FTranslateFile.Free;
  inherited;
end;

procedure TTranslateFileCreator.SetOriginal(const Value: string);
begin
  FOriginal := Value;
  if FileExists(FOriginal) then FTranslateFile.LoadOriginal(Original, feAnsi);
end;

procedure TTranslateFileCreator.SetTranslation(const Value: string);
begin
  FTranslation := Value;
  if FileExists(FTranslation) then FTranslateFile.LoadTranslation(FTranslation, feAnsi);
end;

{ TTranslateFilesTest }

function TTranslateFilesTest.MakeQualifiedFilename(const Filename: string): string;
begin
  Result := Filename;
  if not FileExists(Result) then
    Result := ExpandUNCFilename(Result);
  if not FileExists(Result) then
    Result := ExtractFilePath(ParamStr(0)) + ExtractFilename(Result);
  if not FileExists(Result) then
    Result := IncludeTrailingPathDelimiter(GetCurrentDir) + ExtractFilename(Result);
  Check(FileExists(Result), Format('File not found: <%s>', [Filename]));
end;

procedure TTranslateFilesTest.LoadOriginal(Filename: string);
begin
  FC.LoadOriginal(MakeQualifiedFilename(Filename), feAnsi);
end;

procedure TTranslateFilesTest.LoadTranslation(Filename: string);
begin
  FC.LoadTranslation(MakeQualifiedFilename(Filename), feAnsi);
end;

procedure TTranslateFilesTest.SaveOriginal(Filename: string);
begin
  Check(IsValidFilename(Filename), Format('Invalid filename: <%s>', [Filename]));
  FC.SaveOriginal(Filename, feAnsi);
end;

procedure TTranslateFilesTest.SaveTranslation(Filename: string);
begin
  Check(IsValidFilename(Filename), Format('Invalid filename: <%s>', [Filename]));
  FC.SaveTranslation(Filename, feAnsi);
end;

procedure TTranslateFilesTest.SetUp;
begin
  inherited;
  FC := TTranslateFiles.Create;
end;

procedure TTranslateFilesTest.TearDown;
begin
  inherited;
  FC.Free;
end;

procedure TTranslateFilesTest.AddTest;
var
  i: integer;
begin
  FC.Items.Clear;
  for i := 0 to aItemCount - 1 do
    with FC.Items.Add do
    begin
      Section := aDefaultSectionName;
      Name := IntToStr(i);
      Original := 'Original_' + Name;
      Translation := 'Translation_' + Name;
    end;
  CheckEquals(aItemCount, FC.Items.Count, 'Count does not match:');
end;

procedure TTranslateFilesTest.ClearTest;
begin
  AddTest;
  FC.Items.Clear;
  CheckEquals(0, FC.Items.Count, 'Count does not match:');
end;

procedure TTranslateFilesTest.DeleteTest;
var
  i, j, k, m: integer;
begin
  // test removal of a random number of items
  AddTest;
  m := Random(FC.Items.Count);
  k := Random(FC.Items.Count div 2);
  j := FC.Items.Count;
  for i := m - 1 downto k do
  begin
    FC.Items.Delete(i);
    Dec(j);
  end;
  CheckEquals(j, FC.Items.Count, 'Count does not match:');
end;

procedure TTranslateFilesTest.FindTest;
var i, aIndex, aResult:integer;
begin
  // find an item you know is in there
  // then find an item you know is not in there
  // sort the items in various ways and do it again
  AddTest;
  for i := stNone to stIndex do
  begin
    // this should be in there
    FC.Items.Sort := i;
    aIndex := Random(aItemCount-1);
    aResult :=  FC.Items.IndexOf(aDefaultSectionName, IntToStr(aIndex), false);
    CheckEquals(FC.Items[aResult].Index, aIndex);
    // this should never be found
    aResult :=  FC.Items.IndexOf(aDefaultSectionName, IntToStr(aItemCount + 1), false);
    CheckEquals(-1, aResult);
  end;
end;

procedure TTranslateFilesTest.IndexTest;
var
  i: integer;
begin
  // check whether the index matches the items location in the array
  AddTest;
  FC.Items.Sort := stIndex;
  for i := 0 to FC.Items.Count - 1 do
    CheckEquals(i, FC.Items[i].Index, 'Index does not match:');
end;

procedure TTranslateFilesTest.TestOrphans;
begin
  // load a translation file that has items not in the original file and
  // check the orphans for a match
  
  Check(false, 'Not implemented');
end;

procedure TTranslateFilesTest.TestSeparators;
begin
  // change the separators
  // load a file from disk that uses them and test
  // load a file that doesn't use them and test
  Check(false, 'Not implemented');
end;

procedure TTranslateFilesTest.SortTypeTest;
var i:integer;
begin
  for i := stNone to stIndex do
  begin
    FC.Items.Sort := i;
    CheckEquals(i, FC.Items.Sort, 'Sort does not match:');
  end;
end;

procedure TTranslateFilesTest.TranslatedCountTest;
begin
  AddTest; // AddTest adds strings for both Original and Translation
  // Changing Translation does not automatically change Translated
  CheckEquals(FC.Items.TranslatedCount, 0, 'TranslateCount does not match:');
end;

procedure TTranslateFilesTest.TranslatedCountTest2;
var
  i, j: integer;
begin
  AddTest; // AddTest adds strings for both Original and Translation
  j := 0;
  // set first half of the translations to translated
  for i := 0 to FC.Items.Count div 2 do
  begin
    FC.Items[i].Translated := true;
    Inc(j);
  end;
  // Changing Translation does not automatically change Translated
  CheckEquals(j, FC.Items.TranslatedCount, 'TranslateCount does not match:');
end;

procedure TTranslateFilesTest.TranslatedCountTest3;
var
  i, j: integer;
begin
  AddTest; // AddTest adds strings for both Original and Translation
  j := 0;
  // set every other translation to translated
  for i := 0 to FC.Items.Count - 1 do
    if Odd(i) then
    begin
      FC.Items[i].Translated := true;
      Inc(j);
    end;
  CheckEquals(j, FC.Items.TranslatedCount, 'TranslateCount does not match:');
end;

procedure TTranslateFilesTest.TranslatedCountTest4;
var
  i, j: integer;
begin
  AddTest; // AddTest adds strings for both Original and Translation
  j := FC.Items.TranslatedCount;
  // set last half of the translations to translated
  for i := FC.Items.Count div 2 to FC.Items.Count - 1 do
  begin
    FC.Items[i].Translated := true;
    Inc(j);
  end;
  CheckEquals(j, FC.Items.TranslatedCount, 'TranslateCount does not match:');
end;

procedure TTranslateFilesTest.LoadFromFileTest;
begin
  LoadOriginal('TestOriginal1.lng');
  
  LoadTranslation('TestTranslation1.lng');
end;

procedure TTranslateFilesTest.SaveToFileTest;
begin
  AddTest;
  SaveOriginal('TestOriginal1.lng');
  CheckEquals(FileExists('TestOriginal1.lng'), true, 'File TestOriginal1.lng not created');
  SaveTranslation('TestTranslation1.lng');
  CheckEquals(FileExists('TestTranslation1.lng'), true, 'File TestTranslation1.lng not created');
end;

{ TTranslateUtilsTest }

procedure TTranslateUtilsTest.MatchesStringTest;
begin
  Check(MatchesString('s test 1', 'This is test 1', false, true, false));
  Check(MatchesString('This is test 2', 'This is test 2', true, true, false));
  Check(MatchesString('This is test 3', 'This is test 3', true, true, false));
  Check(MatchesString('&This is test 4', 'This &is test 4', true, true, true));
  Check(MatchesString('TeSt 5', 'This &is test 5', false, false, false));
  Check(MatchesString('TE&ST 6', 'This &is test 6', false, false, true));
end;

procedure TTranslateUtilsTest.StrBetweenTest;
var
  S, T: string;
begin
  S := 'Test string: [return this] and skip this';
  T := strBetween(S, '[', ']');
  CheckEquals('return this', T);

  S := 'Test string: [[[return this] and skip this] and this]';
  T := strBetween(S, '[', ']');
  CheckEquals('return this', T);

  S := 'Test string: [][don''t return this] [or this]';
  T := strBetween(S, '[', ']');
  CheckEquals('', T);
end;

procedure TTranslateUtilsTest.StrDefaultTest;
begin
  CheckEquals(StrDefault('','empty'),'empty');
  CheckEquals(StrDefault('empty',''),'empty');
  CheckEquals(StrDefault('',''),'');
  CheckEquals(StrDefault('empty','empty'),'empty');
end;

procedure TTranslateUtilsTest.StripCharsTest;
begin
  CheckEquals('', StripChars('abcdefghij', ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j']));
  CheckEquals('abc', StripChars('abcdefghij', ['d', 'e', 'f', 'g', 'h', 'i', 'j']));
  CheckEquals('defghij', StripChars('abcdefghij', ['a', 'b', 'c']));
  CheckEquals('abc', StripChars('jjjjabcddddeeeejjjeffffffggggghhhhhiiiij', ['d', 'e', 'f', 'g', 'h', 'i', 'j']));
end;

procedure TTranslateUtilsTest.StripKeysTest;
var
  S: TStringlist;
begin
  S := TStringlist.Create;
  try
    S.Add('hhhahbhchhhhdhehhhfhhhhhhhghhhhhhihjhhh');
    S.Add('abcdefghij');
    S.Add('hdehdehdehdehdeh');
    S.Add('hhaahhddhhaahhdd');
    S.Add('hhhh');
    StripKeys(S, 'h', true);
    CheckEquals('abcdefgij', S[0]);
    CheckEquals('abcdefgij', S[1]);
    CheckEquals('dedededede', S[2]);
    CheckEquals('aaddaadd', S[3]);
    CheckEquals('', S[4]);
  finally
    S.Free;
  end;
end;

procedure TTranslateUtilsTest.StripKeyTest;
begin
  CheckEquals('abcdefgij', StripKey('hhhahbhchhhhdhehhhfhhhhhhhghhhhhhihjhhh', 'h', true));
  CheckEquals('bcdefghij', StripKey('abcdefghij', 'a', true));
  CheckEquals('aaaaaaaaaaaaaa', StripKey('bbbaaaaaaaaabbbaaaaabbb', 'b', true));
  CheckEquals('abc', StripKey('ddddddabcdddd', 'd', true));
end;

procedure TTranslateUtilsTest.DoubleQuoteStringTest;
var Orig:string;
begin
  Orig := 'StringWithoutSpaces';
  // only double quote if needed
  CheckEquals(DoubleQuoteString(Orig,true), Orig, 'Invalid double-quoting');
  // always double quote
  CheckEquals(DoubleQuoteString(Orig,false), '"' + Orig + '"', 'Invalid double-quoting');
  Orig := 'String With Spaces';
  // only double quote if needed
  CheckEquals(DoubleQuoteString(Orig,true), '"' + Orig + '"', 'Invalid double-quoting');
  // always double quote
  CheckEquals(DoubleQuoteString(Orig,false), '"' + Orig + '"', 'Invalid double-quoting');
  Orig := '';
  // only double quote if needed
  CheckEquals(DoubleQuoteString(Orig,true), '', 'Invalid double-quoting');
  // always double quote
  CheckEquals(DoubleQuoteString(Orig,false), '""', 'Invalid double-quoting');
end;

procedure TTranslateUtilsTest.TrimCRLFRightTest;
begin
  CheckEquals('Test string 1', trimCRLFRight('Test string 1'#13#10'  '));
  CheckEquals('Test string 2', trimCRLFRight('Test string'#13#10'2  '));
  CheckEquals(' Test   string 3', trimCRLFRight(#13#10'Test'#13#10#13#10' string 3 '));
end;

initialization
  TestFramework.RegisterTests('Translator Tests', [TTranslateFilesTest.Suite, TTranslateUtilsTest.Suite]);
  Randomize;
end.


