{@abstract(Parser for Xilisoft language files) }
{
  Copyright © 2006 by Alexander Kornienko; all rights reserved

  Developer(s):

  Status:
   The contents of this file are subject to the Mozilla Public License Version
   1.1 (the "License"); you may not use this file except in compliance with the
   License. You may obtain a copy of the License at http://www.mozilla.org/MPL/MPL-1.1.html

   Software distributed under the License is distributed on an "AS IS" basis,
   WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
   the specific language governing rights and limitations under the License.
}
// $Id: $
unit XilisoftParserImpl;

interface
uses
  PluginLocale,
  Classes, Types, TntClasses, TransIntf;

type
  TXilisoftParser = class(TInterfacedObject, IUnknown, IFileParser)
  private
    FOldAppHandle: Cardinal;
    FOrigFile: string;
    FTransFile: string;
    FLangFile: string;
    FSkip: Boolean;
    FPLocale: TPlgLocale;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure BuildPreview(Items, Orphans: ITranslationItems; Strings: TTntStrings);
    procedure InitLocale;
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
    procedure Init(const ApplicationServices: IApplicationServices); safecall;
    property SkipEmpty: Boolean read FSkip write FSkip;
  end;

implementation
uses
  XilisoftParserCfgForm,
  Controls,
  Windows, SysUtils, Forms, IniFiles, DualImportFrm;

const
  cSectionName = 'XilisoftTranslator';
  cSkip = 'SkipEmpty';
  cPlugin = 'Plugin';
  cImport = 'ImportFrom';
  cExport = 'ExportTo';
  cAllFiles = 'AllFiles';
  cLangFiles = 'LangFiles';

var
  cXilisoftFilter: string = 'Lang files (*.lang)|*.lang|All files (*.*)|*.*';
  cXilisoftImportTitle: string = 'Import from Xilisoft .lang file';
  cXilisoftExportTitle: string = 'Export to Xilisoft .lang file';

function GetLocaleInformation(Flag: Integer): string;
var
  pcLCA: array[0..20] of Char;
begin
  if (GetLocaleInfo(LOCALE_SYSTEM_DEFAULT, Flag, pcLCA, 19) <= 0) then
  begin
    pcLCA[0] := #0;
  end;
  Result := pcLCA;
end;

{ TXilisoftParser }

procedure TXilisoftParser.BuildPreview(Items, Orphans: ITranslationItems;
  Strings: TTntStrings);
var i: integer;
begin
  for i := 0 to Orphans.Count - 1 do
    Strings.Add(Orphans[i].Name + WideChar('=') + Orphans[i].Translation);
  for i := 0 to Items.Count - 1 do
    if Items[i].Translation <> '' then
    begin
      Strings.Add(WideChar('#') + Items[i].Name + WideString('# "') + Items[i].Translation + WideChar('"'));
      Items[i].Modified := false;
    end;
end;

function TXilisoftParser.Capabilities: Integer;
begin
  Result := CAP_IMPORT or CAP_EXPORT; // or CAP_CONFIGURE;
end;

procedure TXiliSoftParser.InitLocale;
var s: string;
begin
  if FPLocale = nil then
  begin
    FLangFile := ChangeFileExt(GetModuleName(hInstance), '.lng');
    FPLocale := TPlgLocale.Create(FLangFile);
    FPLocale.PluginSection := cPlugin;
    FPLocale.AddKey(sPlugin, cImport);
    FPLocale.AddKey(sPlugin, cExport);
    FPLocale.AddKey(sPlugin, cAllFiles);
    FPLocale.AddKey(sPlugin, cLangFiles);
    s := FPLocale.GetLocalizedKey(sPlugin, cImport);
    if s <> '' then
      cXilisoftImportTitle := s + ' Xilisoft .lang'
    else
      cXilisoftImportTitle := 'Import from Xilisoft .lang file';
    s := FPLocale.GetLocalizedKey(sPlugin, cExport);
    if s <> '' then
      cXilisoftExportTitle := s + ' Xilisoft .lang'
    else
      cXilisoftExportTitle := 'Export to Xilisoft .lang file';
    s := FPLocale.GetLocalizedKey(sPlugin, cLangFiles);
    if s <> '' then
      cXilisoftFilter := s + '|*.lang'
    else
      cXilisoftFilter := 'Lang files (*.lang)|*.lang|';
    s := FPLocale.GetLocalizedKey(sPlugin, cAllFiles);
    if s <> '' then
      cXilisoftFilter := cXilisoftFilter + s + '|*.*'
    else
      cXilisoftFilter := cXilisoftFilter + 'All files (*.*)|*.*';
  end;

end;

function TXilisoftParser.Configure(Capability: Integer): HRESULT;
begin
//  InitLocale;
  case Capability of
    CAP_EXPORT:
      begin
        XilisoftCfgForm := TXilisoftCfgForm.Create(nil);
        try
        // XilisoftCfgForm.FillLocale(FPLocale);
          XilisoftCfgForm.TCB1.Checked := SkipEmpty;
          if XilisoftCfgForm.ShowModal = mrYes then
            SkipEmpty := true
          else
            SkipEmpty := false;
        finally
          XilisoftCfgForm.Free;
        end;
        Result := S_OK;
      end;
  else
    Result := S_OK;
  end;
end;

constructor TXilisoftParser.Create;
begin
  inherited Create;
  FOldAppHandle := Application.Handle;
end;

destructor TXilisoftParser.Destroy;
begin
  FreeAndNil(FPLocale);
  Application.Handle := FOldAppHandle;
  inherited;
end;

function TXilisoftParser.DisplayName(Capability: Integer): WideString;
begin
  {
  if GetLocaleInformation(LOCALE_ILANGUAGE)='0419' then
   begin
    cXilisoftFilter := 'Файлы Lang (*.lang)|*.lang|Все файлы (*.*)|*.*';
    cXilisoftImportTitle := 'Импорт из файла Xilisoft .lang';
    cXilisoftExportTitle := 'Экспорт в файл Xilisoft .lang';
   end
  else
   begin
    cXilisoftFilter := 'Lang files (*.lang)|*.lang|All files (*.*)|*.*';
    cXilisoftImportTitle := 'Import from Xilisoft .lang file';
    cXilisoftExportTitle := 'Export to Xilisoft .lang file';
   end;
  }
  case Capability of
    CAP_IMPORT:
      Result := cXilisoftImportTitle;
    CAP_EXPORT:
      Result := cXilisoftExportTitle;
  else
    Result := '';
  end;
end;

function TXilisoftParser.ExportItems(const Items,
  Orphans: ITranslationItems): HRESULT;
var
  S: TTntStringlist;
begin
  Result := S_FALSE;
  try
    LoadSettings;
    S := TTntStringlist.Create;
    try
      BuildPreview(Items, Orphans, S);
      begin
        S.AnsiStrings.SaveToFile(FTransFile);
        Result := S_OK;
        SaveSettings;
      end;
    finally
      S.Free;
    end;
  except
    Application.HandleException(self);
  end;
end;

function TXilisoftParser.ImportItems(const Items, Orphans: ITranslationItems): HRESULT;
var
  SO, ST: TTntStringlist;
  i, j, k: integer;
  TI: ITranslationItem;
  ssi, sst, sName, sValue: string;
  IsInT: Boolean;
begin
  Result := S_FALSE;
  try
    Items.Clear;
    Orphans.Clear;
    TI := nil;
    LoadSettings;
    if TfrmImport.Execute(FOrigFile, FTransFile, cXilisoftImportTitle, cXilisoftFilter, '.', 'lang') then
    begin
      Items.Sort := stNone;
      SO := TTntStringlist.Create;
      ST := TTntStringlist.Create;
      try
        SO.LoadFromFile(FOrigFile);
        ST.LoadFromFile(FTransFile);
        for i := 0 to SO.Count - 1 do
        begin
          ssi := SO[i];
          if ssi = '' then
            Continue;
          if ssi[1] in ['/', ';'] then
            Continue;
          k := Pos('=', ssi);
          if k > 0 then
          begin
            sName := Copy(ssi, 1, k - 1);
            sValue := Copy(ssi, k + 1, MaxInt);
            IsInT := false;
            for j := 0 to ST.Count - 1 do
            begin
              if ST[j] = '' then
                Continue;
              k := Pos('=', ST[j]);
              if k > 0 then
              begin
                sst := Copy(ST[j], 1, k - 1);
                if sst = sName then
                begin
                  sst := ST[j];
                  IsInT := true;
                  Break;
                end;
              end;
            end;
            TI := Orphans.Add;
            TI.Section := cSectionName;
            TI.Name := sName;
            TI.Original := sValue;
            if IsInT then
            begin
              k := Pos('=', sst);
              TI.Translation := Copy(sst, k + 1, MaxInt);
              TI.Translated := true;
            end
            else
            begin
              TI.Translation := '';
              TI.Translated := false;
            end;
            Continue;
          end;
          k := Pos('#', ssi);
          if k > 0 then
          begin
            k := Pos(' ', ssi);
            sName := Copy(ssi, 1, k - 1);
            sValue := Copy(ssi, k + 1, MaxInt);
            IsInT := false;
            for j := 0 to ST.Count - 1 do
            begin
              if ST[j] = '' then
                Continue;
              k := Pos('#', ST[j]);
              if k > 0 then
              begin
                k := Pos(' ', ST[j]);
                sst := Copy(ST[j], 1, k - 1);
                if sst = sName then
                begin
                  sst := ST[j];
                  IsInT := true;
                  Break;
                end;
              end;
            end;
            TI := Items.Add;
            TI.Section := cSectionName;
            TI.Name := Copy(sName, 2, Length(sName) - 2);
            TI.Original := Copy(sValue, 2, Length(sValue) - 2);
            if IsInT then
            begin
              ssi := Copy(sst, Pos(' ', sst) + 1, MaxInt);
              TI.Translation := Copy(ssi, 2, Length(ssi) - 2);
              TI.Translated := true;
            end
            else
            begin
              TI.Translation := '';
              TI.Translated := false;
            end;
            TI.Modified := false;
          end;
        end;
      finally
        SO.Free;
        ST.Free;
      end;
      SaveSettings;
      Result := S_OK;
    end;
  except
    Application.HandleException(self);
  end;
end;

procedure TXilisoftParser.Init(const ApplicationServices: IApplicationServices);
begin
  Application.Handle := ApplicationServices.AppHandle;
end;

procedure TXilisoftParser.LoadSettings;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
      FOrigFile := ReadString('Settings', 'OrigFile', FOrigFile);
      FTransFile := ReadString('Settings', 'TransFile', FTransFile);
      SkipEmpty := ReadBool('Settings', cSkip, false);
    finally
      Free;
    end;
  except
    Application.HandleException(self);
  end;
end;

procedure TXilisoftParser.SaveSettings;
begin
  try
    with TIniFile.Create(ChangeFileExt(GetModuleName(hInstance), '.ini')) do
    try
      WriteString('Settings', 'OrigFile', FOrigFile);
      WriteString('Settings', 'TransFile', FTransFile);
      WriteBool('Settings', cSkip, SkipEmpty);
    finally
      Free;
    end;
  except
    Application.HandleException(self);
  end;
end;

end.

