{@abstract(Main form for INI Translator) }

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
unit MainFrm;
{$I TRANSLATOR.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, StdCtrls, ExtCtrls, ActnList, StdActns, ImgList,
  // app specific
  BaseForm, FileMonitor, MsgTranslate, AppOptions,
  AppConsts, TranslateFile, TransIntf, Dictionary,
  FindReplaceFrm, EncodingDlgs, ToolItems, WideIniFiles,
{$IFDEF USEADDICTSPELLCHECKER}
  // addict spell checker (www.addictive-software.com)
  ad3Spell, ad3SpellBase, ad3Configuration, ad3ConfigurationDialogCtrl, ad3SpellLanguages, ad3ParserBase, ad3Ignore,
{$ENDIF USEADDICTSPELLCHECKER}
  // TNT controls (http://home.ccci.org/wolbrink/tnt/delphi_unicode_controls.htm)
  TntStdCtrls, TntComCtrls, TNTClasses, TNTSysUtils,
  TntActnList, TntExtCtrls, TntDialogs, TntStdActns,
  // Toolbar2000 (http://www.jrsoftware.org)
  TB2Item, TB2Dock, TB2Toolbar, TB2ToolWindow, TB2MRU,
  // TBX (http://g32.org)
  TBX, TBXExtItems, TB2ExtItems, TBXSwitcher,
  TBXDefaultTheme, TBXOfficeXPTheme, TBXAluminumTheme, TBXStripesTheme, TBXStatusBars,
  // additional TBX themes (http://www.rmklever.com)
{$IFDEF USEOLDTBX}
  TBXOffice11XPTheme, TBXOffice11AdaptiveTheme, TBXTristanTheme, TBXTristan2Theme,
  TBXAthenTheme, TBXMonaiXPTheme, TBXMonaiTheme,
  TBXNewOfficeTheme, TBXNewOfficeAdaptiveTheme, TBXDreamTheme,
  TBXEosTheme,
  TBXNexos2Theme, TBXNexos3Theme, TBXNexos4Theme, TBXNexos5Theme, TBXNexosXTheme,
  TBXOfficeCTheme, TBXOfficeKTheme, TBXReliferTheme, TBXRomaTheme,
  TBXSentimoXTheme, TBXUxThemes, TBXXitoTheme,
  TBXStatusBars, TBXToolPals, TBXLists,
  TBXDefaultXPTheme, TBXWhidbeyTheme, TBXZezioTheme,
  //
  // TBXOfficeXPGradientTheme,
  // TBXOffice2003Theme, TBXDock2003,
  // TBXBlueGradientXPTheme,
  //
{$ENDIF USEOLDTBX}
  TBXDkPanels;

const
  WM_DELAYLOADED = WM_USER + 1001;

type
  TfrmMain = class(TfrmBase)
    StatusBar1: TTBXStatusBar;
    alMain: TTntActionList;
    acOpenOrig: TTntAction;
    acOpenTrans: TTntAction;
    acSaveTrans: TTntAction;
    acSaveTransAs: TTntAction;
    acExit: TTntAction;
    acPrev: TTntAction;
    acNext: TTntAction;
    acCopyFromOriginal: TTntAction;
    acAbout: TTntAction;
    acToggleFocus: TTntAction;
    acFocusTranslation: TTntAction;
    acFind: TTntAction;
    acFindNext: TTntAction;
    acReplace: TTntAction;
    acNextUntranslated: TTntAction;
    acPrevUntranslated: TTntAction;
    acFocusListView: TTntAction;
    acFocusOriginal: TTntAction;
    acShowQuotes: TTntAction;
    acFont: TTntAction;
    acRestoreSort: TTntAction;
    acDictSave: TTntAction;
    acDictLoad: TTntAction;
    SaveDictDlg: TTntSaveDialog;
    OpenDictDlg: TTntOpenDialog;
    acDictCreate: TTntAction;
    acDictTranslate: TTntAction;
    il16: TImageList;
    acDictInvert: TTntAction;
    acHelp: TTntAction;
    acNewTrans: TTntAction;
    acCreateTranslationFile: TTntAction;
    acCopyAllFromOrig: TTntAction;
    acViewDetails: TTntAction;
    acCut: TTntAction;
    acCopy: TTntAction;
    acPaste: TTntAction;
    acSelectAll: TTntEditSelectAll;
    acUndo: TTntAction;
    TopDock: TTBXDock;
    tbMenu: TTBXToolbar;
    mnuFile: TTBXSubmenuItem;
    OpenOriginal1: TTBXItem;
    ClearTranslation1: TTBXItem;
    OpenTranslation1: TTBXItem;
    SaveTranslation1: TTBXItem;
    SaveTranslationAs1: TTBXItem;
    N1: TTBXSeparatorItem;
    SelectLanguage1: TTBXItem;
    N11: TTBXSeparatorItem;
    Exit1: TTBXItem;
    Edit1: TTBXSubmenuItem;
    acCopyFromOriginal1: TTBXItem;
    Find1: TTBXItem;
    FindNext1: TTBXItem;
    Replace1: TTBXItem;
    N8: TTBXSeparatorItem;
    ToggleFocus1: TTBXItem;
    N9: TTBXSeparatorItem;
    Navigation1: TTBXSubmenuItem;
    Previous1: TTBXItem;
    Next1: TTBXItem;
    About2: TTBXSeparatorItem;
    Previousuntranslated1: TTBXItem;
    Nextuntranslated1: TTBXItem;
    N2: TTBXSeparatorItem;
    Font1: TTBXItem;
    N4: TTBXSeparatorItem;
    ShowQuotes1: TTBXItem;
    Unsort1: TTBXItem;
    N10: TTBXSeparatorItem;
    ShowDetails1: TTBXItem;
    Dictionary1: TTBXSubmenuItem;
    LoadDictionary1: TTBXItem;
    SaveDictionary1: TTBXItem;
    N5: TTBXSeparatorItem;
    CreateDictionary1: TTBXItem;
    N6: TTBXSeparatorItem;
    Translatewithdictionary1: TTBXItem;
    acDictInvert1: TTBXItem;
    Help1: TTBXSubmenuItem;
    Help2: TTBXItem;
    N7: TTBXSeparatorItem;
    About1: TTBXItem;
    TBSeparatorItem3: TTBXSeparatorItem;
    TBDock1: TTBXDock;
    TBDock2: TTBXDock;
    TBDock3: TTBXDock;
    TBItem5: TTBXItem;
    TBItem6: TTBXItem;
    TBItem7: TTBXItem;
    TBSeparatorItem6: TTBXSeparatorItem;
    acCopyFromName: TTntAction;
    TBItem13: TTBXItem;
    acPreferences: TTntAction;
    acViewComments: TTntAction;
    TBItem14: TTBXItem;
    TBSeparatorItem8: TTBXSeparatorItem;
    acAsciiValues: TTntAction;
    TBItem16: TTBXItem;
    popEdit: TTBXPopupMenu;
    Undo1: TTBXItem;
    N13: TTBXSeparatorItem;
    Cut1: TTBXItem;
    Copy1: TTBXItem;
    Paste1: TTBXItem;
    N14: TTBXSeparatorItem;
    SelectAll1: TTBXItem;
    TBSeparatorItem9: TTBXSeparatorItem;
    TBItem17: TTBXItem;
    popList: TTBXPopupMenu;
    TBItem20: TTBXItem;
    TBItem21: TTBXItem;
    TBItem24: TTBXItem;
    TBItem25: TTBXItem;
    TBSeparatorItem14: TTBXSeparatorItem;
    tbTools: TTBXToolbar;
    TBItem1: TTBXItem;
    TBSeparatorItem2: TTBXSeparatorItem;
    TBItem2: TTBXItem;
    TBItem3: TTBXItem;
    TBItem4: TTBXItem;
    TBSeparatorItem1: TTBXSeparatorItem;
    TBItem12: TTBXItem;
    TBItem10: TTBXItem;
    TBItem8: TTBXItem;
    TBSeparatorItem7: TTBXSeparatorItem;
    TBItem9: TTBXItem;
    TBItem11: TTBXItem;
    TBSeparatorItem12: TTBXSeparatorItem;
    TBItem18: TTBXItem;
    TBItem19: TTBXItem;
    TBSeparatorItem4: TTBXSeparatorItem;
    TBItem27: TTBXItem;
    TBSeparatorItem5: TTBXSeparatorItem;
    TBItem29: TTBXItem;
    MRUFiles: TTBXMRUList;
    TBMRUListItem1: TTBXMRUListItem;
    miRecentlyUsed: TTBXSubmenuItem;
    acClearMRU: TTntAction;
    acClearInvalidMRU: TTntAction;
    TBSeparatorItem15: TTBXSeparatorItem;
    TBItem31: TTBXItem;
    TBItem32: TTBXItem;
    TBSeparatorItem16: TTBXSeparatorItem;
    acFindUnmatchedShortCut: TTntAction;
    acHome: TTntAction;
    acEnd: TTntAction;
    acPageUp: TTntAction;
    acPageDown: TTntAction;
    TBSubmenuItem2: TTBXSubmenuItem;
    TBItem36: TTBXItem;
    ilBookmarks: TImageList;
    acGotoBookmark1: TTntAction;
    acGotoBookmark2: TTntAction;
    acGotoBookmark4: TTntAction;
    acGotoBookmark5: TTntAction;
    acGotoBookmark6: TTntAction;
    acGotoBookmark7: TTntAction;
    acGotoBookmark8: TTntAction;
    acGotoBookmark9: TTntAction;
    acGotoBookmark0: TTntAction;
    acToggleBookmark1: TTntAction;
    acToggleBookmark2: TTntAction;
    acToggleBookmark3: TTntAction;
    acToggleBookmark4: TTntAction;
    acToggleBookmark5: TTntAction;
    acToggleBookmark6: TTntAction;
    acToggleBookmark7: TTntAction;
    acToggleBookmark8: TTntAction;
    acToggleBookmark9: TTntAction;
    acToggleBookmark0: TTntAction;
    acGotoBookmark3: TTntAction;
    TBSubmenuItem3: TTBXSubmenuItem;
    TBSubmenuItem4: TTBXSubmenuItem;
    TBItem22: TTBXItem;
    TBItem23: TTBXItem;
    TBItem26: TTBXItem;
    TBItem28: TTBXItem;
    TBItem30: TTBXItem;
    TBItem37: TTBXItem;
    TBItem38: TTBXItem;
    TBItem39: TTBXItem;
    TBItem40: TTBXItem;
    TBItem41: TTBXItem;
    TBItem42: TTBXItem;
    TBItem43: TTBXItem;
    TBItem44: TTBXItem;
    TBItem45: TTBXItem;
    TBItem46: TTBXItem;
    TBItem47: TTBXItem;
    TBItem48: TTBXItem;
    TBItem49: TTBXItem;
    TBItem50: TTBXItem;
    TBItem51: TTBXItem;
    alBookmarks: TTntActionList;
    TBSeparatorItem10: TTBXSeparatorItem;
    acClearAllTranslations: TTntAction;
    acReplaceEverywhere: TTntAction;
    TBSeparatorItem11: TTBXSeparatorItem;
    TBItem52: TTBXItem;
    TBItem53: TTBXItem;
    TBItem54: TTBXItem;
    acNextSuspicious: TTntAction;
    TBItem55: TTBXItem;
    TBItem56: TTBXItem;
    acViewOrphans: TTntAction;
    ThemeSwitcher: TTBXSwitcher;
    cbThemes: TTBXComboBoxItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    pbTranslated: TTntProgressBar;
    acSaveOrigAs: TTntAction;
    TBXItem1: TTBXItem;
    acConfigureKeyboard: TTntAction;
    TBXSeparatorItem2: TTBXSeparatorItem;
    TBXItem2: TTBXItem;
    TBXSeparatorItem3: TTBXSeparatorItem;
    TBXVisibilityToggleItem1: TTBXVisibilityToggleItem;
    MainFontDlg: TFontDialog;
    acImport: TTntAction;
    acExport: TTntAction;
    TBXSeparatorItem4: TTBXSeparatorItem;
    TBXItem3: TTBXItem;
    TBXItem4: TTBXItem;
    acToggleTranslated: TTntAction;
    TBXSeparatorItem5: TTBXSeparatorItem;
    TBXItem5: TTBXItem;
    pnlBack: TTntPanel;
    splitHorz: TSplitter;
    pnlBottom: TTntPanel;
    pnlTrans: TTntPanel;
    lblTrans: TTntLabel;
    reTranslation: TTntRichEdit;
    pnlOrig: TTntPanel;
    lblOrig: TTntLabel;
    reOriginal: TTntRichEdit;
    lvTranslateStrings: TTntListView;
    pnlKeyBack: TTntPanel;
    pnlKeyDetails: TTntPanel;
    lblViewDetails: TLabel;
    acTestExceptionHandler: TTntAction;
    acDictAdd: TTntAction;
    TBXItem6: TTBXItem;
    TBXItem7: TTBXItem;
    acFullScreen: TTntAction;
    TBXItem8: TTBXItem;
    TBXSeparatorItem6: TTBXSeparatorItem;
    smiDictionary: TTBXSubmenuItem;
    acSpellCheck: TTntAction;
    tbxSpellCheck: TTBXItem;
    acToolsCustomize: TTntAction;
    TBXItem10: TTBXItem;
    TBXSubmenuItem1: TTBXSubmenuItem;
    acNoRichEditTntAction: TTntAction;
    acDeleteItem: TTntAction;
    acEditItem: TTntAction;
    acAddItem: TTntAction;
    TBXSeparatorItem7: TTBXSeparatorItem;
    TBXItem9: TTBXItem;
    TBXItem11: TTBXItem;
    TBXItem12: TTBXItem;
    acSaveOriginal: TTntAction;
    TBXItem13: TTBXItem;
    TBXItem14: TTBXItem;
    acTrim: TTntAction;
    acConfigSuspicious: TTntAction;
    TBXItem15: TTBXItem;
    acDictEdit: TTntAction;
    TBXItem16: TTBXItem;
    TBXSeparatorItem8: TTBXSeparatorItem;
    mnuPlugins: TTBXSubmenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure lvTranslateStringsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure reTranslationExit(Sender: TObject);
    procedure lvTranslateStringsData(Sender: TObject; Item: TListItem);
    procedure acExitExecute(Sender: TObject);
    procedure acOpenOrigExecute(Sender: TObject);
    procedure acOpenTransExecute(Sender: TObject);
    procedure acSaveTransExecute(Sender: TObject);
    procedure acSaveTransAsExecute(Sender: TObject);
    procedure acPrevExecute(Sender: TObject);
    procedure acNextExecute(Sender: TObject);
    procedure acCopyFromOriginalExecute(Sender: TObject);
    procedure reTranslationEnter(Sender: TObject);
    procedure acAboutExecute(Sender: TObject);
    procedure lvTranslateStringsEnter(Sender: TObject);
    procedure acToggleFocusExecute(Sender: TObject);
    procedure acFocusTranslationExecute(Sender: TObject);
    procedure acFindExecute(Sender: TObject);
    procedure acFindNextExecute(Sender: TObject);
    procedure acReplaceExecute(Sender: TObject);
    procedure lvTranslateStringsAdvancedCustomDrawItem(
      Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
      Stage: TCustomDrawStage; var DefaultDraw: boolean);
    procedure acNextUntranslatedExecute(Sender: TObject);
    procedure acPrevUntranslatedExecute(Sender: TObject);
    procedure acFocusListViewExecute(Sender: TObject);
    procedure acFocusOriginalExecute(Sender: TObject);
    procedure acShowQuotesExecute(Sender: TObject);
    procedure alMainUpdate(Action: TBasicAction; var Handled: boolean);
    procedure acFontExecute(Sender: TObject);
    procedure MainFontDlgApply(Sender: TObject; Wnd: HWND);
    procedure lvTranslateStringsColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure acRestoreSortExecute(Sender: TObject);
    procedure pnlBottomResize(Sender: TObject);
    procedure acDictSaveExecute(Sender: TObject);
    procedure acDictLoadExecute(Sender: TObject);
    procedure acDictCreateExecute(Sender: TObject);
    procedure acDictTranslateExecute(Sender: TObject);
    procedure acDictInvertExecute(Sender: TObject);
    procedure acDictAddExecute(Sender: TObject);
    procedure acHelpExecute(Sender: TObject);
    procedure lvTranslateStringsDataFind(Sender: TObject; Find: TItemFind;
      const FindString: WideString; const FindPosition: TPoint;
      FindData: Pointer; StartIndex: integer; Direction: TSearchDirection;
      Wrap: boolean; var Index: integer);
    procedure acNewTransExecute(Sender: TObject);
    procedure acCreateTranslationFileExecute(Sender: TObject);
    procedure acCopyAllFromOrigExecute(Sender: TObject);
    procedure acViewDetailsExecute(Sender: TObject);
    procedure acPasteUpdate(Sender: TObject);
    procedure reTranslationKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure acCopyFromNameExecute(Sender: TObject);
    procedure acPreferencesExecute(Sender: TObject);
    procedure acViewCommentsExecute(Sender: TObject);
    procedure acAsciiValuesExecute(Sender: TObject);
    procedure lvTranslateStringsInfoTip(Sender: TObject; Item: TListItem;
      var InfoTip: string);
    procedure MRUFilesClick(Sender: TObject; const FileName: string);
    procedure acClearMRUExecute(Sender: TObject);
    procedure acClearInvalidMRUExecute(Sender: TObject);
    procedure mnuFileSelect(Sender: TTBCustomItem; Viewer: TTBItemViewer;
      Selecting: boolean);
    procedure acFindUnmatchedShortCutExecute(Sender: TObject);
    procedure acHomeExecute(Sender: TObject);
    procedure acEndExecute(Sender: TObject);
    procedure acPageUpExecute(Sender: TObject);
    procedure acPageDownExecute(Sender: TObject);
    procedure GotoBookmarkExecute(Sender: TObject);
    procedure ToggleBookmarkExecute(Sender: TObject);
    procedure acClearAllTranslationsExecute(Sender: TObject);
    procedure acReplaceEverywhereExecute(Sender: TObject);
    procedure acNextSuspiciousExecute(Sender: TObject);
    procedure acViewOrphansExecute(Sender: TObject);
    procedure acCutExecute(Sender: TObject);
    procedure acCopyExecute(Sender: TObject);
    procedure acPasteExecute(Sender: TObject);
    procedure acSelectAllExecute(Sender: TObject);
    procedure acUndoExecute(Sender: TObject);
    procedure acSaveOrigAsExecute(Sender: TObject);
    procedure acConfigureKeyboardExecute(Sender: TObject);
    procedure acImportExecute(Sender: TObject);
    procedure acExportExecute(Sender: TObject);
    procedure acToggleTranslatedExecute(Sender: TObject);
    procedure acTestExceptionHandlerExecute(Sender: TObject);
    procedure acFullScreenExecute(Sender: TObject);
    procedure popEditPopup(Sender: TObject);
    procedure acToolsCustomizeExecute(Sender: TObject);
    procedure TBXSubmenuItem1Select(Sender: TTBCustomItem;
      Viewer: TTBItemViewer; Selecting: Boolean);
    procedure acDeleteItemExecute(Sender: TObject);
    procedure acEditItemExecute(Sender: TObject);
    procedure acAddItemExecute(Sender: TObject);
    procedure acSaveOriginalExecute(Sender: TObject);
    procedure lvTranslateStringsDblClick(Sender: TObject);
    procedure acTrimExecute(Sender: TObject);
    procedure acConfigSuspiciousExecute(Sender: TObject);
    procedure acDictEditExecute(Sender: TObject);
    procedure mnuPluginsPopup(Sender: TTBCustomItem; FromLink: Boolean);
    procedure cbThemesChange(Sender: TObject);
  private
    { Private declarations }
    OpenOrigDlg, OpenTransDlg: TEncodingOpenDialog;
    SaveTransDlg, SaveOrigDlg: TEncodingSaveDialog;
    FFindReplace: TFindReplace;
    FTranslateFile: TTranslateFiles;
    FLastFindText, FLastFolder: WideString;
    FModified: boolean;
    FDict: TDictionaryItems;
    FCommandProcessor: boolean;
    FFileMonitors: array of TFileMonitorThread;
    FBookmarks: array[0..9] of integer;
    FImportIndex, FCapabilitesSupported: integer;
    FExternalToolItems: TExternalToolItems;
{$IFDEF USEADDICTSPELLCHECKER}
    adSpellChecker: TAddictSpell3;
    procedure SpellCheckComplete(Sender: TObject);
    procedure CreateSpellChecker;
    procedure SpellCheckGetString(Sender: TObject;
      LanguageString: TSpellLanguageString; var Text: string);
    procedure SpellCheckWordCheck(Sender: TObject; const
      Word: string; var CheckType: TWordCheckType; var Replacement: string);
    procedure SpellCheckExecute(Sender: TObject);
{$ENDIF USEADDICTSPELLCHECKER}

    // returns true if it's OK to continue
    function CheckModified: boolean;
    function CheckDictModified: boolean;
    procedure LoadSettings(FirstLoad: boolean);
    procedure SaveSettings;
    procedure LoadTranslate;
    function LoadOriginal(const FileName: string; Encoding: TEncoding):TEncoding;
    function LoadTranslation(const FileName: string; Encoding: TEncoding):TEncoding;
    function SaveTranslation(const FileName: string; Encoding: TEncoding): boolean;
    function SaveTranslationAs(const FileName: string; Encoding: TEncoding): boolean;
    function SaveOriginal(const FileName: string; Encoding: TEncoding): boolean;
    function SaveOrigAs(const FileName: string; Encoding: TEncoding): boolean;
    procedure SetModified(const Value: boolean);
    function GetModified: boolean;
    function SearchFromCurrent(const FindText: WideString; CaseSense, WholeWord,
      Down, Fuzzy: boolean; FindIn: TFindIn): TTntListItem;
    procedure UpdateStatus;
    function AddQuotes(const S: WideString): WideString;
    function RemoveQuotes(const S: WideString): WideString;
    procedure CreateDict(ClearList: boolean);
    procedure LoadDictionary(const FileName: string);
    procedure SaveDictionary(const FileName: string);
    procedure HandleCommandLine;
    // returns false if the application should be terminated
    function ProcessCommand(const ACommand: WideString): boolean;
    // lods a file with commands and processes them
    procedure ProcessCommands(const CommandFile: string);
    procedure DoMonitoredFileChange(Sender: TObject; const FileName: string;
      var AContinue, AReset: boolean);
    procedure DoThreadTerminate(Sender: TObject);
    procedure StartMonitor(var AMonitor: TFileMonitorThread;
      const AFileName: string);
    procedure StopMonitor(var AMonitor: TFileMonitorThread);
    procedure UseDictionary;
    procedure DoWriteObject(Sender, AnObject: TObject; const APropName: WideString;
      var ASection, AName, AValue: WideString);
    procedure DoSaveExtra(Sender: TObject; ini: TWideCustomIniFile);
    procedure DoAllowWriting(Sender, AnObject: TObject; const APropName: WideString; var ATranslate: boolean);
    procedure DoReadObject(Sender, AnObject: TObject; const PropName, Section: WideString; var Value: WideString);
    procedure ScrollToTop;
    procedure SaveEditChanges;
    function GetFilename(const Filename: string): string;
    procedure MoveCommentWindow;
    procedure WMDropFiles(var Message: TWmDropFiles); message WM_DROPFILES;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMDelayLoaded(var Message: TMessage); message WM_DELAYLOADED;
    procedure MoveListViewSelection(Index: integer);
    // bookmark support
    // either toggles bookmark on/off or moves bookmark from current index to new index
    procedure ToggleBookmark(Bookmark, Index: integer);
    // moves focus to Bookmark
    procedure GotoBookmark(Bookmark: integer);
    // clears all bookmarks
    procedure ClearBookmarks;
    // returns the bookmark for item at Index
    function GetBookmark(Index: integer): integer;
    procedure DoFindNext(Sender: TObject);
    procedure DoFindReplace(Sender: TObject);
    procedure DoFindReplaceAll(Sender: TObject);
    procedure CreateDialogs;
    procedure FixXPPanelBug;
    procedure AddMRUFile(const FileName: string; AOriginal: boolean);
    procedure OpenMRUFiles(const FileName: string);
    function MRUFileExists(const FileName: string): boolean;
    procedure DoCommentModified(Sender: TObject; const AText: WideString);
    procedure UpdateColumn(Index: integer; const AFileName: string);
    procedure DoTranslateSuggestionClick(Sender: TObject);
    procedure BuildToolMenu(Parent: TTBCustomItem);
    procedure BuildExternalToolMenu(Parent: TTBCustomItem);

    procedure DoToolMenuClick(Sender: TObject);
    procedure DoTestToolClick(Sender: TObject; Tool: TToolItem);
    function MacroReplace(const AMacros: WideString): WideString;
    procedure ExecuteTool(ATool: TToolItem);
    function QueryArgs(const Title, CmdLine: WideString; var Args: WideString): boolean;
    procedure DoMacroReplace(Sender: TObject; var Args: WideString);

    procedure GetSections(Strings: TTntStringlist);
    procedure CheckBookMarkImages;
    procedure DoTrim;
    procedure AddItem(const Section, Original, Translation, OrigComments, TransComments: WideString); overload;
    procedure AddItem(AItem: ITranslationItem); overload;
    procedure DeleteItem(Index: integer);
    procedure DoExternalToolClick(Sender: TObject);
  public
    { Public declarations }
    property Modified: boolean read GetModified write SetModified;
  end;

var
  frmMain: TfrmMain;

implementation
uses
  ShellAPI, StrUtils, TntWindows, TntClipbrd, TntWideStrUtils, 
{$IFDEF USEADDICTSPELLCHECKER}
  ad3ParseEngine,
{$ENDIF USEADDICTSPELLCHECKER}
  AppUtils, CommonUtils, OptionsFrm, CommentsFrm, OrphansFrm,
  KbdCfgFrame, KbdCfgFrm, ImportExportFrm, ExtToolsFrm, PromptArgsFrm,
  EditItemFrm, TrimFrm, SuspiciousConfigFrm, DictTranslationSelectDlg,
  DictEditFrm;

{$R *.dfm}
{$R manifest.res} // for XP theme support

{ TfrmMain }
// frmMain support routines

procedure TfrmMain.LoadSettings(FirstLoad: boolean);
var
  i: integer;
  m: boolean;
begin
  WaitCursor;
  // only options that can be changed from the options dialog needs to be reset, so these are only set once
  if FirstLoad then
  begin
    CreateDialogs;
    if FileExists(GlobalAppOptions.OriginalFile) then
      LoadOriginal(GlobalAppOptions.OriginalFile, TEncoding(GlobalAppOptions.OrigEncoding)); // ??
    if FileExists(GlobalAppOptions.TranslationFile) then
      LoadTranslation(GlobalAppOptions.TranslationFile, TEncoding(GlobalAppOptions.TransEncoding)); // ??
    if FileExists(GlobalAppOptions.DictionaryFile) then
      LoadDictionary(GlobalAppOptions.DictionaryFile);

    Caption := GlobalAppOptions.AppTitle;
    Application.Title := Caption;
    pnlBottom.Height := GlobalAppOptions.SplitterPosition;
    reOriginal.Color := cColorUntranslated;
    TBIniLoadPositions(Self, GetUserAppOptionsFile, cIniToolbarKey);
    // Find replace dialog
    FFindReplace.FindHistory.CommaText := trim(GlobalAppOptions.FindHistory);
    FFindReplace.ReplaceHistory.CommaText := trim(GlobalAppOptions.ReplaceHistory);
    FFindReplace.FindText := GlobalAppOptions.FindText;
    FFindReplace.ReplaceText := GlobalAppOptions.ReplaceText;
    FFindReplace.MatchLine := GlobalAppOptions.MatchLine;
    FFindReplace.MatchCase := GlobalAppOptions.MatchCase;
    FFindReplace.SearchUp := GlobalAppOptions.SearchUp;
    FFindReplace.FuzzySearch := GlobalAppOptions.FuzzySearch;

    FFindReplace.OnFindNext := DoFindNext;
    FFindReplace.OnReplace := DoFindReplace;
    FFindReplace.OnReplaceAll := DoFindReplaceAll;

    // don't load mru until translation is loaded or the filenames might get "decoded"
    TBMRULoadFromIni(MRUFiles);
    // load shortcuts
    LoadActionShortCutsFromFile(alMain, GetUserShortcutFile);
    // get all available themes

    cbThemes.Lines.Clear;
    for i := 0 to ThemeSwitcher.ThemeCount - 1 do
      cbThemes.Lines.Add(ThemeSwitcher.Themes[i]);
    cbThemes.Lines.Sort;
    cbThemes.Text := GlobalAppOptions.Theme;
    // must call ThemeSwitcher manually: cbThemes.OnChange is not triggered when assigning directly to Text property
    ThemeSwitcher.Theme := GlobalAppOptions.Theme;
    PostMessage(Handle, WM_DELAYLOADED, Handle, 0);
    acRestoreSortExecute(nil);
    LoadTranslate;

  end;
  UpdateColumn(0, GlobalAppOptions.OriginalFile);
  UpdateColumn(1, GlobalAppOptions.TranslationFile);

  lvTranslateStrings.Font := GlobalAppOptions.AppFont;
  reOriginal.Font := GlobalAppOptions.AppFont;
  reOriginal.DefAttributes.Assign(reOriginal.Font);
  m := reTranslation.Modified;
  try
    reTranslation.Font := GlobalAppOptions.AppFont;
    reTranslation.DefAttributes.Assign(reTranslation.Font);
  finally
    reTranslation.Modified := m;
  end;
  Application.ShowHint := GlobalAppOptions.ShowToolTips;
  Application.HintShortCuts := GlobalAppOptions.ShowToolTipShortCuts;
  ShowHint := Application.ShowHint;
  FDict.IgnorePunctuation := GlobalAppOptions.DictIgnoreSpeedKeys;
  if GlobalAppOptions.ShowQuotes <> acShowQuotes.Checked then
    acShowQuotes.Execute;
  if acDictInvert.Checked <> GlobalAppOptions.InvertDictionary then
    acDictInvert.Execute;
  if acViewDetails.Checked <> GlobalAppOptions.ShowDetails then
    acViewDetails.Execute;
{$IFNDEF USEADDICTSPELLCHECKER}
  acSpellCheck.Enabled := false;
  acSpellCheck.Visible := false;
  acSpellCheck.Tag := ACTION_HIDDEN_TAG;
{$ELSE}
  acSpellCheck.Enabled := true;
  acSpellCheck.Visible := true;
  acSpellCheck.Tag := 0;
  acSpellCheck.OnExecute := SpellCheckExecute;
{$ENDIF}
end;

procedure TfrmMain.SaveSettings;
var
  W: TAppWindowInfo;
begin
  if FCommandProcessor then
    Exit;
  WaitCursor;
  W.BoundsRect := BoundsRect;
  if IsIconic(Application.Handle) then
    W.WindowState := wsMinimized
  else
    W.WindowState := WindowState;
  GlobalAppOptions.WindowInfos[Self] := W;

  GlobalAppOptions.ShowQuotes := acShowQuotes.Checked;
  GlobalAppOptions.AppTitle := SAppTitle;
  GlobalAppOptions.SplitterPosition := pnlBottom.Height;
  GlobalAppOptions.InvertDictionary := acDictInvert.Checked;
  GlobalAppOptions.ShowDetails := acViewDetails.Checked;
  GlobalAppOptions.ShowToolTips := Application.ShowHint;
  //  GlobalAppOptions.ShowToolTipShortCuts := Application.HintShortCuts;
  GlobalAppOptions.AppFont.Assign(reOriginal.Font);
  if (frmComments <> nil) then
    GlobalAppOptions.PinCommentWindow := frmComments.Pinned;
  // find / replace dialog
  FFindReplace.FindHistory.Text := trim(FFindReplace.FindHistory.Text);
  FFindReplace.ReplaceHistory.Text := trim(FFindReplace.ReplaceHistory.Text);
  GlobalAppOptions.FindHistory := FFindReplace.FindHistory.CommaText;
  GlobalAppOptions.ReplaceHistory := FFindReplace.ReplaceHistory.CommaText;
  GlobalAppOptions.FindText := FFindReplace.FindText;
  GlobalAppOptions.ReplaceText := FFindReplace.ReplaceText;
  GlobalAppOptions.MatchLine := FFindReplace.MatchLine;
  GlobalAppOptions.MatchCase := FFindReplace.MatchCase;
  GlobalAppOptions.SearchUp := FFindReplace.SearchUp;
  GlobalAppOptions.FuzzySearch := FFindReplace.FuzzySearch;
  GlobalAppOptions.FindInIndex := Ord(FFindReplace.FindInIndex);
  GlobalAppOptions.Theme := cbThemes.Text;

  TBIniSavePositions(Self, GetUserAppOptionsFile, cIniToolbarKey);
  TBMRUSaveToIni(MRUFiles);
  try
    SaveActionShortCutsToFile(alMain, GetUserShortcutFile);
  except
    on E: Exception do
      HandleFileCreateException(Self, E, GetUserShortcutFile);
  end;
end;

function TfrmMain.ProcessCommand(const ACommand: WideString): boolean;
var
  tmp, tmp2: WideString;
  i: integer;
begin
  Result := true;
  i := AnsiPos(' ', ACommand);
  if i > 0 then
  begin
    tmp := trim(Copy(ACommand, 1, i - 1));
    tmp2 := ExpandUNCFileName(RemoveQuotes(trim(Copy(ACommand, i + 1, MaxInt))));
  end
  else
  begin
    tmp := trim(ACommand);
    tmp2 := '';
  end;
  if WideSameText('OPENORIG', tmp) and FileExists(tmp2) then
    LoadOriginal(tmp2, feAnsi)
  else if WideSameText('OPENORIGUC', tmp) and FileExists(tmp2) then
    LoadOriginal(tmp2, feUnicode)
  else if WideSameText('OPENORIGUTF8', tmp) and FileExists(tmp2) then
    LoadOriginal(tmp2, feUTF8)
  else if WideSameText('OPENTRANS', tmp) and FileExists(tmp2) then
    LoadTranslation(tmp2, feAnsi)
  else if WideSameText('OPENTRANSUC', tmp) and FileExists(tmp2) then
    LoadTranslation(tmp2, feUnicode)
  else if WideSameText('OPENTRANSUTF8', tmp) and FileExists(tmp2) then
    LoadTranslation(tmp2, feUTF8)
  else if WideSameText('OPENDICT', tmp) and FileExists(tmp2) then
    LoadDictionary(tmp2)
  else if WideSameText('SAVETRANS', tmp) then
  begin
    if (tmp2 = '') then
      ErrMsg('SAVETRANS called with empty Filename', Translate(ClassName, SErrorCaption))
    else
      SaveTranslation(tmp2, feAnsi);
  end
  else if WideSameText('SAVETRANSUC', tmp) then
  begin
    if (tmp2 = '') then
      ErrMsg('SAVETRANSUC called with empty Filename', Translate(ClassName, SErrorCaption))
    else
      SaveTranslation(tmp2, feUnicode);
  end
  else if WideSameText('SAVETRANSUTF8', tmp) then
  begin
    if (tmp2 = '') then
      ErrMsg('SAVETRANSUTF8 called with empty Filename', Translate(ClassName, SErrorCaption))
    else
      SaveTranslation(tmp2, feUTF8);
  end
  else if WideSameText('SAVEDICT', tmp) then
  begin
    if (tmp2 = '') then
      ErrMsg('SAVEDICT called with empty Filename', Translate(ClassName, SErrorCaption))
    else
      SaveDictionary(tmp2);
  end
  else if WideSameText('CREATEDICT', tmp) then
    CreateDict(false)
  else if WideSameText('CLEARDICT', tmp) then
    FDict.Clear
  else if WideSameText('USEDICT', tmp) then
    UseDictionary
  else if WideSameText('INVERTDICT', tmp) then
    acDictInvert.Execute
  else if WideSameText('QUIT', tmp) then
    Result := false;
end;

procedure TfrmMain.ProcessCommands(const CommandFile: string);
var
  S: TStringlist;
  i: integer;
begin
  if not FileExists(CommandFile) then
    ErrMsg(WideFormat(Translate(ClassName, SFmtFileNotFound), [CommandFile]), Translate(ClassName, SErrorCaption))
  else
  begin
    WaitCursor;
    FCommandProcessor := true;
    ShowWindow(Application.Handle, SW_MINIMIZE);
    SendMessage(Handle, WM_SETREDRAW, 0, 0);
    try
      S := TStringlist.Create;
      try
        S.LoadFromFile(CommandFile);
        for i := 0 to S.Count - 1 do
          if not ProcessCommand(S[i]) then
          begin
            Application.Terminate;
            Close;
            Exit; // this will skip the ShowWindow below
          end;
      finally
        S.Free;
      end;
    finally
      FCommandProcessor := false;
      lvTranslateStrings.Items.Count := FTranslateFile.Items.Count;
    end;
    ShowWindow(Handle, SW_RESTORE);
    SendMessage(Handle, WM_SETREDRAW, 1, 0);
  end;
end;

procedure TfrmMain.HandleCommandLine;
var
  S: string;
begin
  UpdateColumn(0, '');
  UpdateColumn(1, '');
  if GetCmdSwitchValue('b', ['-', '/'], S, true) then // /b<commandfile>
    ProcessCommands(ExpandUNCFileName(S))
  else if (ParamCount >= 1) then // <orig> <trans> <dict>
  begin
    if (ParamCount >= 1) then
    begin
      S := ExpandUNCFileName(ParamStr(1));
      if FileExists(S) then
        LoadOriginal(S, DetectEncoding(S));
      if (ParamCount >= 2) then
      begin
        S := ExpandUNCFileName(ParamStr(2));
        if FileExists(S) then
          LoadTranslation(S, DetectEncoding(S));
      end
      else if FileExists(GlobalAppOptions.TranslationFile) then
        LoadTranslation(GlobalAppOptions.TranslationFile, DetectEncoding(GlobalAppOptions.TranslationFile));
    end;
    if (ParamCount >= 3) then
    begin
      S := ExpandUNCFileName(ParamStr(3));
      if FileExists(S) then
        LoadDictionary(S);
    end;
  end;
  UpdateStatus;
  Modified := false;
end;

function TfrmMain.LoadOriginal(const FileName: string; Encoding: TEncoding):TEncoding;
begin
  WaitCursor;

  if not CheckModified then
  begin
    Result := Encoding;
    Exit;
  end;

  if FileExists(Filename) and not FCommandProcessor then
  begin
    FCapabilitesSupported := 0;
    AddMRUFile(FileName, true);
  end;

  StopMonitor(FFileMonitors[cOrigMonitor]);

  ScrollToTop;
  reOriginal.Clear;
  reTranslation.Clear;
  lvTranslateStrings.Items.Count := 0;

  GlobalAppOptions.OriginalFile := Filename;
  GlobalAppOptions.OrigEncoding := Ord(Encoding);
  FLastFolder := ExtractFilePath(Filename);

  Result := FTranslateFile.LoadOriginal(FileName, Encoding);
  GlobalAppOptions.OrigEncoding := Ord(Result);
  StartMonitor(FFileMonitors[cOrigMonitor], Filename);

  if not FCommandProcessor then
  begin
    lvTranslateStrings.Items.Count := FTranslateFile.Items.Count;
    lvTranslateStrings.Invalidate;
  end;
  UpdateStatus;
  acRestoreSortExecute(nil);
end;

function TfrmMain.LoadTranslation(const FileName: string; Encoding: TEncoding):TEncoding;
begin
  WaitCursor;
  if not CheckModified then
  begin
    Result := Encoding;
    Exit;
  end;
  StopMonitor(FFileMonitors[cTransMonitor]);
  reOriginal.Clear;
  reTranslation.Clear;
  ScrollToTop;
  lvTranslateStrings.Items.Count := 0;

  GlobalAppOptions.TranslationFile := Filename;
  GlobalAppOptions.TransEncoding := Ord(Encoding);
  FLastFolder := ExtractFilePath(Filename);

  AddMRUFile(FileName, false);

  Result := FTranslateFile.LoadTranslation(FileName, Encoding);
  GlobalAppOptions.TransEncoding := Ord(Result);
  StartMonitor(FFileMonitors[cTransMonitor], FileName);
  lvTranslateStrings.Items.Count := FTranslateFile.Items.Count;
  lvTranslateStrings.Invalidate;

  if Visible then
  begin
    if lvTranslateStrings.CanFocus then
      lvTranslateStrings.SetFocus;
    lvTranslateStringsEnter(nil);
    if reTranslation.CanFocus then
    begin
      reTranslation.SetFocus;
      reTranslation.SelectAll;
    end;
  end;
  Modified := false;
  UpdateStatus;
  acRestoreSortExecute(nil);
end;

function TfrmMain.SaveTranslation(const FileName: string; Encoding: TEncoding): boolean;
var
  i: integer;
begin
  i := lvTranslateStrings.ItemIndex;
  if FileName = '' then
  begin
    Result := SaveTranslationAs(FileName, Encoding);
    Exit;
  end;
  WaitCursor;

  // stop the monitor thread
  StopMonitor(FFileMonitors[cTransMonitor]);
  // avoid false alarms when original = translation
  StopMonitor(FFileMonitors[cOrigMonitor]);
  SaveEditChanges;
  //  DeleteFile(Filename); // clear old content
  try
    FTranslateFile.SaveTranslation(FileName, Encoding);
  except
    on E: Exception do
      HandleFileCreateException(Self, E, FileName);
  end;
  GlobalAppOptions.TranslationFile := Filename;
  GlobalAppOptions.TransEncoding := Ord(Encoding);
  FLastFolder := ExtractFilePath(Filename);

  UpdateColumn(1, FileName);
  Result := true;
  Modified := false;
  // resume the monitor thread
  StartMonitor(FFileMonitors[cTransMonitor], FileName);
  StartMonitor(FFileMonitors[cOrigMonitor], GlobalAppOptions.OriginalFile);
  lvTranslateStrings.Invalidate;
  lvTranslateStrings.ItemIndex := i;
end;

function TfrmMain.SaveTranslationAs(const FileName: string; Encoding: TEncoding): boolean;
begin
  Result := false;
  SaveTransDlg.FileName := GetFilename(Filename);
  SaveTransDlg.FilterIndex := GlobalAppOptions.FilterIndex;
  SaveTransDlg.EncodingIndex := Ord(Encoding);
  
  if SaveTransDlg.Execute then
  begin
    GlobalAppOptions.FilterIndex := SaveTransDlg.FilterIndex;
    SaveTranslation(SaveTransDlg.FileName, TEncoding(SaveTransDlg.EncodingIndex));
    Result := true;
  end;
end;

function TfrmMain.SaveOriginal(const FileName: string; Encoding: TEncoding): boolean;
var
  i: integer;
begin
  i := lvTranslateStrings.ItemIndex;
  if FileName = '' then
  begin
    Result := SaveOrigAs(FileName, Encoding);
    Exit;
  end;
  WaitCursor;

  // stop the monitor thread
  StopMonitor(FFileMonitors[cTransMonitor]);
  // avoid false alarms when original = translation
  StopMonitor(FFileMonitors[cOrigMonitor]);
  SaveEditChanges;
  //  DeleteFile(Filename); // clear old content
  try
    FTranslateFile.SaveOriginal(FileName, Encoding);
  except
    on E: Exception do
      HandleFileCreateException(Self, E, FileName);
  end;

  GlobalAppOptions.OriginalFile := Filename;
  GlobalAppOptions.OrigEncoding := Ord(Encoding);
  FLastFolder := ExtractFilePath(Filename);

  UpdateColumn(0, FileName);
  Result := true;
  Modified := false;
  // resume the monitor thread
  StartMonitor(FFileMonitors[cTransMonitor], GlobalAppOptions.TranslationFile);
  StartMonitor(FFileMonitors[cOrigMonitor], GlobalAppOptions.OriginalFile);
  lvTranslateStrings.Invalidate;
  lvTranslateStrings.ItemIndex := i;
end;

function TfrmMain.SaveOrigAs(const FileName: string; Encoding: TEncoding): boolean;
begin
  Result := false;
  SaveOrigDlg.FileName := GetFilename(Filename);
  SaveOrigDlg.EncodingIndex := Ord(Encoding);
  SaveOrigDlg.FilterIndex := GlobalAppOptions.FilterIndex;
  if SaveOrigDlg.Execute then
  begin
    GlobalAppOptions.FilterIndex := SaveOrigDlg.FilterIndex;
    SaveOriginal(SaveOrigDlg.Filename, TEncoding(SaveOrigDlg.EncodingIndex));
    Result := true;
  end;
end;

procedure TfrmMain.CreateDict(ClearList: boolean);
var
  i: integer;
begin
  WaitCursor;
  if ClearList then
    FDict.Clear;
  for i := 0 to FTranslateFile.Items.Count - 1 do
    with FTranslateFile.Items[i] do
      if (trim(Original) <> '') then
      begin
        if (trim(Translation) <> '') then
          FDict.Add(trim(Original)).Translations.Add(trim(Translation))
        else
          FDict.Add(trim(Original));
      end;
  OpenDictDlg.Filename := '';
  SaveDictDlg.FileName := '';
  UpdateStatus;
end;

procedure TfrmMain.LoadDictionary(const FileName: string);
begin
  WaitCursor;
  if not CheckDictModified then
    Exit;
  SaveDictDlg.FileName := FileName;
  OpenDictDlg.FileName := FileName;
  if acDictInvert.Checked then
    acDictInvert.Execute; // toggle invert
  FDict.LoadFromFile(FileName);
  GlobalAppOptions.DictionaryFile := Filename;
  if not acDictInvert.Checked and GlobalAppOptions.InvertDictionary then
    acDictInvert.Execute; // toggle invert
  StartMonitor(FFileMonitors[cDictMonitor], FileName);
  UpdateStatus;
end;

procedure TfrmMain.SaveDictionary(const FileName: string);
begin
  WaitCursor;
  // stop the monitor thread
  StopMonitor(FFileMonitors[cDictMonitor]);
  try
    FDict.SaveToFile(SaveDictDlg.FileName);
    GlobalAppOptions.DictionaryFile := Filename;
  except
    on E: Exception do
      HandleFileCreateException(Self, E, SaveDictDlg.Filename);
  end;
  UpdateStatus;
  // resume the monitor thread
  StartMonitor(FFileMonitors[cDictMonitor], FileName);
end;

procedure TfrmMain.UseDictionary;
var
  i, j, FResult: integer;
  S: WideString;
  FModified: boolean;
begin
  for i := 0 to FTranslateFile.Items.Count - 1 do
//    if FTranslateFile.Items[i].Translation = '' then
  begin
    if FTranslateFile.Items[i].Translated and GlobalAppOptions.DictIgnoreNonEmpty then
      Continue;
    j := FDict.IndexOf(FTranslateFile.Items[i].Original);
    if (j >= 0) then // dictionary item found
    begin
      lvTranslateStrings.Items[i].MakeVisible(false);
      lvTranslateStrings.Items[i].Selected := true;
      lvTranslateStrings.Items[i].Focused := true;
      S := FTranslateFile.Items[i].Translation;
      FResult := TfrmDictTranslationSelect.Edit(FDict[j], S, FModified);
      FDict.Modified := FDict.Modified or FModified;
      case FResult of
        cDictIgnore:
          Continue;
        cDictAdd:
          begin
            FDict[j].Translations.Add(S);
            FTranslateFile.Items[i].Translation := S;
          end;
        cDictUse:
          FTranslateFile.Items[i].Translation := S;
        cDictCancel:
          Exit;
      end;
      FTranslateFile.Items[i].Translated := S <> '';
    end;
  end;
  InfoMsg(SDictTranslationCompleted, SInfoCaption);
end;

procedure TfrmMain.SetModified(const Value: boolean);

  procedure ClearModified;
  var i: integer;
  begin
    for i := 0 to FTranslateFile.Items.Count - 1 do
      FTranslateFile.Items[i].Modified := false;
    lvTranslateStrings.Update;
  end;
begin
  FModified := Value;
  reTranslation.Modified := Value;
  if not Value then
    ClearModified;
end;

function TfrmMain.GetModified: boolean;
begin
  FModified := reTranslation.Modified or FModified or FTranslateFile.Items.Modified;
  Result := FModified;
end;

function TfrmMain.SearchFromCurrent(const FindText: WideString;
  CaseSense, WholeWord, Down, Fuzzy: boolean; FindIn: TFindIn): TTntListItem;
var
  i: integer;
begin
  Result := nil;
  if FTranslateFile.Items.Count < 1 then
    Exit;
  WaitCursor;
  if lvTranslateStrings.Selected = nil then
  begin
    if Down then
      i := 0
    else
      i := FTranslateFile.Items.Count - 1;
  end
  else
  begin
    if Down then
      i := lvTranslateStrings.Selected.Index + 1
    else
      i := lvTranslateStrings.Selected.Index - 1;
  end;
  Result := nil;
  while (i >= 0) and (i < FTranslateFile.Items.Count) do
  begin
    if FindIn in [fiiOriginal, fiiBoth] then
    begin
      if MatchesString(FindText, FTranslateFile.Items[i].Original, WholeWord, CaseSense, Fuzzy) then
      begin
        Result := lvTranslateStrings.Items[i];
        Exit;
      end;
    end;
    if FindIn in [fiiTranslation, fiiBoth] then
    begin
      if MatchesString(FindText, FTranslateFile.Items[i].Translation, WholeWord, CaseSense, Fuzzy) then
      begin
        Result := lvTranslateStrings.Items[i];
        Exit;
      end;
    end;
    if Down then
      Inc(i)
    else
      Dec(i);
  end;
end;

function TfrmMain.AddQuotes(const S: WideString): WideString;
begin
  if acShowQuotes.Checked then
    Result := '"' + S + '"'
  else
    Result := S;
end;

function TfrmMain.RemoveQuotes(const S: WideString): WideString;
begin
  Result := S;
  if not acShowQuotes.Checked then
    Exit;
  if (Length(Result) > 0) then
  begin
    if Result[Length(Result)] in [WideChar(#39), WideChar('"')] then
      SetLength(Result, Length(Result) - 1);
    if (Length(Result) > 0) and (Result[1] in [WideChar(#39), WideChar('"')]) then
      Result := Copy(Result, 2, MaxInt);
  end;
end;

procedure TfrmMain.ScrollToTop;
begin
  SendMessage(lvTranslateStrings.Handle, WM_VSCROLL, SB_TOP, 0);
end;

procedure TfrmMain.UpdateStatus;
var
  i: integer;

  // NB! Pass in Font.Size for StartSize and MinSize. AWidth is max width in pixels. Returns positive Font.Height

  function CalcMaxFontSize(ACanvas: TCanvas; const S: string; AWidth: integer; StartSize, MinSize: integer): integer;
  var
    aSize: TSize;
  begin
    ACanvas.Font.Size := StartSize;
    Result := StartSize;
    while GetTextExtentPoint32(ACanvas.Handle, PChar(S), Length(S), aSize) do
    begin
      if aSize.cx <= AWidth then
      begin
        Result := trunc((aSize.cy * 72) / ACanvas.Font.PixelsPerInch);
        Exit;
      end;
      ACanvas.Font.Size := ACanvas.Font.Size - 1;
      if ACanvas.Font.Size <= MinSize then
      begin
        Result := trunc((aSize.cy * 72) / ACanvas.Font.PixelsPerInch);
        Exit;
      end;
    end;
  end;
begin
  if Modified then
    StatusBar1.Panels[0].Caption := '  ' + Translate(ClassName, SModified)
  else
    StatusBar1.Panels[0].Caption := '  ' + Translate(ClassName, SReady);

  if lvTranslateStrings.Selected <> nil then
  begin
    StatusBar1.Panels[1].Caption := '  ' + FTranslateFile.Items[lvTranslateStrings.Selected.Index].Section;
    StatusBar1.Panels[2].Caption := '  ' + FTranslateFile.Items[lvTranslateStrings.Selected.Index].Name;
    with FTranslateFile.Items[lvTranslateStrings.Selected.Index] do
      lblViewDetails.Caption := WideFormat(Translate(ClassName, SFmtKeyDetails), [Section, Name]);
  end
  else
  begin
    StatusBar1.Panels[1].Caption := '';
    StatusBar1.Panels[2].Caption := '';
    lblViewDetails.Caption := Application.Title;
  end;
  // very simple, but should work *most* of the time...
  lblViewDetails.Font.Height := -CalcMaxFontSize(lblViewDetails.Canvas, lblViewDetails.Caption, lblViewDetails.Width,
    14, 7);
  StatusBar1.Panels[3].Caption := '  ' + WideFormat(Translate(ClassName, SFmtItemsCount), [FTranslateFile.Items.Count]);
  if SaveDictDlg.FileName <> '' then
    StatusBar1.Panels[4].Caption := '  ' + ExtractFileName(SaveDictDlg.FileName)
  else
    StatusBar1.Panels[4].Caption := '  ' + Translate(ClassName, SNoDictionary);
  if acDictInvert.Checked then
    StatusBar1.Panels[4].Caption := StatusBar1.Panels[4].Caption + WideFormat(' (%s)', [Translate(ClassName,
        SDictInverted)]);
  pbTranslated.Max := FTranslateFile.Items.Count;
  pbTranslated.Position := FTranslateFile.Items.TranslatedCount;
  pbTranslated.Hint := '  ' + WideFormat(Translate(ClassName, SCountOfCountTranslated), [FTranslateFile.Items.TranslatedCount,
    FTranslateFile.Items.Count]);
  StatusBar1.Panels[5].Caption := pbTranslated.Hint;
  for i := 0 to StatusBar1.Panels.Count - 1 do
    StatusBar1.Panels[i].Hint := StatusBar1.Panels[i].Caption;

  UpdateColumn(0, GlobalAppOptions.OriginalFile);
  UpdateColumn(1, GlobalAppOptions.TranslationFile);

end;

procedure TfrmMain.DoThreadTerminate(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(FFileMonitors) - 1 do
    if FFileMonitors[i] = Sender then
      FFileMonitors[i] := nil;
end;

procedure TfrmMain.DoMonitoredFileChange(Sender: TObject; const FileName: string; var AContinue, AReset: boolean);
begin
  if GetActiveWindow <> Handle then
  begin
    AReset := false;
    Exit; // only show confirm message if we have focus
  end;
  AContinue := false;
  if YesNo(WideFormat(Translate(ClassName, SFmtFileChangedReloadPrompt), [FileName]), Translate(ClassName, SConfirmCaption)) then
  begin
    if Sender = FFileMonitors[cOrigMonitor] then
    begin
      // in case Original and Translation is the same file...
      StopMonitor(FFileMonitors[cTransMonitor]);
//      if FileExists(GlobalAppOptions.TranslationFile) then
//        SaveTranslation(GlobalAppOptions.TranslationFile, DetectEncoding(GlobalAppOptions.TranslationFile));
      LoadOriginal(FileName, TEncoding(GlobalAppOptions.OrigEncoding));
      LoadTranslation(GlobalAppOptions.TranslationFile, TEncoding(GlobalAppOptions.TransEncoding));
    end
    else if Sender = FFileMonitors[cTransMonitor] then
      LoadTranslation(FileName, TEncoding(GlobalAppOptions.TransEncoding))
    else if Sender = FFileMonitors[cDictMonitor] then
      LoadDictionary(FileName)
    else
      AContinue := true;
  end
  else
    AContinue := true;
end;

procedure TfrmMain.StartMonitor(var AMonitor: TFileMonitorThread; const AFileName: string);
begin
  if GlobalAppOptions.MonitorFiles and FileExists(AFileName) then
  begin
    StopMonitor(AMonitor);
    AMonitor := TFileMonitorThread.Create(AFileName);
    AMonitor.FreeOnTerminate := true;
    AMonitor.OnTerminate := DoThreadTerminate;
    AMonitor.OnChange := DoMonitoredFileChange;
    AMonitor.Resume;
  end;
end;

procedure TfrmMain.StopMonitor(var AMonitor: TFileMonitorThread);
begin
  if AMonitor <> nil then
  begin
    AMonitor.OnTerminate := nil;
    AMonitor.OnChange := nil;
    AMonitor.Terminate;
    AMonitor := nil;
  end;
end;

procedure TfrmMain.SaveEditChanges;
begin
  reTranslationExit(nil);
end;

procedure TfrmMain.LoadTranslate;
begin
  WaitCursor;
  if GlobalLanguageFile <> nil then
  begin
    GlobalLanguageFile.LoadFromFile(GlobalAppOptions.LanguageFile);
    GlobalLanguageFile.TranslateObject(Self, ClassName);
  end;
end;

function TfrmMain.GetFilename(const Filename: string): string;
begin
  if GlobalAppOptions.GlobalPath and (FLastFolder <> '') then
    Result := IncludeTrailingPathDelimiter(FLastFolder) + ExtractFileName(Filename)
  else
    Result := Filename;
  Result := ExcludeTrailingPathDelimiter(Result);
end;

procedure TfrmMain.MoveCommentWindow;
begin
  if (frmComments = nil) or not frmComments.Visible or not frmComments.Pinned then
    Exit;
  frmComments.Top := Top;
  if Left + Width + frmComments.Width <= Screen.Width then
    frmComments.Left := Left + Width // place to right
  else if Left - frmComments.Width >= 0 then
    frmComments.Left := Left - frmComments.Width // place to left
  else
  begin
    frmComments.Left := Screen.Width - frmComments.Width; // place in top right corner
    frmComments.Top := GetSystemMetrics(SM_CYCAPTION) - 1;
  end;
end;

procedure TfrmMain.MoveListViewSelection(Index: integer);
begin
  SaveEditChanges;
  if Index < 0 then
    Index := 0;
  if Index > lvTranslateStrings.Items.Count - 1 then
    Index := lvTranslateStrings.Items.Count - 1;
  if (Index >= 0) and (Index < lvTranslateStrings.Items.Count) then
  begin
    lvTranslateStrings.Selected := lvTranslateStrings.Items[Index];
    lvTranslateStrings.Selected.MakeVisible(false);
  end;
  if reTranslation.CanFocus then
    reTranslation.SetFocus;
  reTranslation.SelectAll;
end;

procedure TfrmMain.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  MoveCommentWindow;
end;

type
  THackPersistent = class(TPersistent);

procedure TfrmMain.DoWriteObject(Sender, AnObject: TObject;
  const APropName: WideString; var ASection, AName, AValue: WideString);

  function GetOwnerComponent(AComponent: TComponent): string;
  var
    C: TComponent;
  begin
    C := AComponent;
    Result := Self.ClassName;
    while (C <> nil) and (C <> Application) do
    begin
      Result := C.ClassName;
      C := C.Owner;
    end;
  end;

begin
  if AnObject is TCustomForm then
    ASection := TCustomForm(AnObject).ClassName
  else if AnObject is TComponent then
    ASection := GetOwnerComponent(TComponent(AnObject))
  else
    ASection := Self.ClassName;
  AName := AValue;
end;

procedure TfrmMain.DoSaveExtra(Sender: TObject; ini: TWideCustomIniFile);
var
  i: integer;
  S: string;
begin
  // write out all resourcestrings
  ini.WriteString(ClassName, EncodeStrings(SFmtAboutText), EncodeStrings(SFmtAboutText));
  ini.WriteString(ClassName, EncodeStrings(SFmtAboutCaption), EncodeStrings(SFmtAboutCaption));
  ini.WriteString(ClassName, EncodeStrings(SSavePrompt), EncodeStrings(SSavePrompt));
  ini.WriteString(ClassName, EncodeStrings(SOriginalColumn), EncodeStrings(SOriginalColumn));
  ini.WriteString(ClassName, EncodeStrings(STranslationColumn), EncodeStrings(STranslationColumn));
  ini.WriteString(ClassName, EncodeStrings(SFmtTextNotFound), EncodeStrings(SFmtTextNotFound));
  ini.WriteString(ClassName, EncodeStrings(SSearchFailCaption), EncodeStrings(SSearchFailCaption));
  ini.WriteString(ClassName, EncodeStrings(SAppTitle), EncodeStrings(SAppTitle));
  ini.WriteString(ClassName, EncodeStrings(SModified), EncodeStrings(SModified));
  ini.WriteString(ClassName, EncodeStrings(SReady), EncodeStrings(SReady));
  ini.WriteString(ClassName, EncodeStrings(SOriginal), EncodeStrings(SOriginal));
  ini.WriteString(ClassName, EncodeStrings(STranslation), EncodeStrings(STranslation));
  ini.WriteString(ClassName, EncodeStrings(SInfoCaption), EncodeStrings(SInfoCaption));
  ini.WriteString(ClassName, EncodeStrings(SConfirmCaption), EncodeStrings(SConfirmCaption));
  ini.WriteString(ClassName, EncodeStrings(SErrorCaption), EncodeStrings(SErrorCaption));
  ini.WriteString(ClassName, EncodeStrings(SErrDictEmpty), EncodeStrings(SErrDictEmpty));
  ini.WriteString(ClassName, EncodeStrings(SDictCreated), EncodeStrings(SDictCreated));
  ini.WriteString(ClassName, EncodeStrings(SClearDictPrompt), EncodeStrings(SClearDictPrompt));
  ini.WriteString(ClassName, EncodeStrings(SFmtErrHelpNotFound), EncodeStrings(SFmtErrHelpNotFound));
  ini.WriteString(ClassName, EncodeStrings(SDictInverted), EncodeStrings(SDictInverted));
  ini.WriteString(ClassName, EncodeStrings(SFmtFileNotFound), EncodeStrings(SFmtFileNotFound));
  ini.WriteString(ClassName, EncodeStrings(SNotImplemented), EncodeStrings(SNotImplemented));
  ini.WriteString(ClassName, EncodeStrings(SFmtFileChangedReloadPrompt), EncodeStrings(SFmtFileChangedReloadPrompt));
  ini.WriteString(ClassName, EncodeStrings(SFmtItemsCount), EncodeStrings(SFmtItemsCount));
  ini.WriteString(ClassName, EncodeStrings(SSaveTranslationTemplate), EncodeStrings(SSaveTranslationTemplate));
  ini.WriteString(ClassName, EncodeStrings(SLanguageNotChangedUntilRestart),
    EncodeStrings(SLanguageNotChangedUntilRestart));
  ini.WriteString(ClassName, EncodeStrings(SDeleteItemText), EncodeStrings(SDeleteItemText));
  ini.WriteString(ClassName, EncodeStrings(SFmtKeyDetails), EncodeStrings(SFmtKeyDetails));
  ini.WriteString(ClassName, EncodeStrings(SNoDictionary), EncodeStrings(SNoDictionary));
  ini.WriteString(ClassName, EncodeStrings(SDecodedCharsCaption), EncodeStrings(SDecodedCharsCaption));
  ini.WriteString(ClassName, EncodeStrings(SAsciiValue), EncodeStrings(SAsciiValue));
  ini.WriteString(ClassName, EncodeStrings(SOpenOrigTitle), EncodeStrings(SOpenOrigTitle));
  ini.WriteString(ClassName, EncodeStrings(SOpenTransTitle), EncodeStrings(SOpenTransTitle));
  ini.WriteString(ClassName, EncodeStrings(SSaveTransTitle), EncodeStrings(SSaveTransTitle));
  ini.WriteString(ClassName, EncodeStrings(SLngExt), EncodeStrings(SLngExt));
  ini.WriteString(ClassName, EncodeStrings(SANSI), EncodeStrings(SANSI));
  ini.WriteString(ClassName, EncodeStrings(SUTF8), EncodeStrings(SUTF8));
  ini.WriteString(ClassName, EncodeStrings(SUnicode), EncodeStrings(SUnicode));
  ini.WriteString(ClassName, EncodeStrings(SFileFilter), EncodeStrings(SFileFilter));
  ini.WriteString(ClassName, EncodeStrings(SCountOfCountTranslated), EncodeStrings(SCountOfCountTranslated));
  ini.WriteString(ClassName, EncodeStrings(SQCopyToClipboard), EncodeStrings(SQCopyToClipboard));
  ini.WriteString(ClassName, EncodeStrings(SNotAssigned), EncodeStrings(SNotAssigned));
  ini.WriteString(ClassName, EncodeStrings(SAssignedTo), EncodeStrings(SAssignedTo));
  ini.WriteString(ClassName, EncodeStrings(SNoCategory), EncodeStrings(SNoCategory));
  ini.WriteString(ClassName, EncodeStrings(SImportCaption), EncodeStrings(SImportCaption));
  ini.WriteString(ClassName, EncodeStrings(SImportLabelCaption), EncodeStrings(SImportLabelCaption));
  ini.WriteString(ClassName, EncodeStrings(SImportButtonCaption), EncodeStrings(SImportButtonCaption));
  ini.WriteString(ClassName, EncodeStrings(SExportCaption), EncodeStrings(SExportCaption));
  ini.WriteString(ClassName, EncodeStrings(SExportLabelCaption), EncodeStrings(SExportLabelCaption));
  ini.WriteString(ClassName, EncodeStrings(SExportButtonCaption), EncodeStrings(SExportButtonCaption));
  ini.WriteString(ClassName, EncodeStrings(SNoPluginsAvaliable), EncodeStrings(SNoPluginsAvaliable));
  ini.WriteString(ClassName, EncodeStrings(SPluginError), EncodeStrings(SPluginError));
  ini.WriteString(ClassName, EncodeStrings(SSaveDictPrompt), EncodeStrings(SSaveDictPrompt));
  ini.WriteString(ClassName, EncodeStrings(SArgumentsPrompt), EncodeStrings(SArgumentsPrompt));
  ini.WriteString(ClassName, EncodeStrings(SErrToolExecFmt), EncodeStrings(SErrToolExecFmt));
  ini.WriteString(ClassName, EncodeStrings(SNewToolNameFmt), EncodeStrings(SNewToolNameFmt));
  ini.WriteString(ClassName, EncodeStrings(SErrCreateFileFmt), EncodeStrings(SErrCreateFileFmt));
  ini.WriteString(ClassName, EncodeStrings(SPromptDeleteItem), EncodeStrings(SPromptDeleteItem));
  ini.WriteString(ClassName, EncodeStrings(SConfirmDelete), EncodeStrings(SConfirmDelete));
  ini.WriteString(ClassName, EncodeStrings(SCaptionEditItem), EncodeStrings(SCaptionEditItem));
  ini.WriteString(ClassName, EncodeStrings(SCaptionAddItem), EncodeStrings(SCaptionAddItem));
  ini.WriteString(ClassName, EncodeStrings(SErrSectionEmpty), EncodeStrings(SErrSectionEmpty));
  ini.WriteString(ClassName, EncodeStrings(SErrNameEmpty), EncodeStrings(SErrNameEmpty));
  ini.WriteString(ClassName, EncodeStrings(SErrOrigTextEmpty), EncodeStrings(SErrOrigTextEmpty));
  ini.WriteString(ClassName, EncodeStrings(SErrSectionNameExists), EncodeStrings(SErrSectionNameExists));
  ini.WriteString(ClassName, EncodeStrings(SDictTranslationCompleted), EncodeStrings(SDictTranslationCompleted));
  ini.WriteString(ClassName, EncodeStrings(SSelectLanguageFile), EncodeStrings(SSelectLanguageFile));
  ini.WriteString(ClassName, EncodeStrings(SSelectHelpFile), EncodeStrings(SSelectHelpFile));

  for i := 0 to alMain.ActionCount - 1 do
  begin
    S := EncodeStrings(alMain.Actions[i].Category);
    ini.WriteString(ClassName, S, S);
    S := EncodeStrings(TAction(alMain.Actions[i]).Hint);
    ini.WriteString(ClassName, S, S);
  end;

  // write out author info (do not localize)
  ini.WriteString('Translator', 'Author', 'Ini Translator');
  ini.WriteString('Translator', 'Language', 'Default');
  ini.WriteString('Translator', 'EMail', '(none)');
  ini.WriteString('Translator', 'Version', GetAppVersion);
end;

procedure TfrmMain.DoReadObject(Sender, AnObject: TObject; const PropName, Section: WideString; var Value: WideString);
begin
  Value := GlobalLanguageFile.Translate(Section, Value, Value);
end;

procedure TfrmMain.DoAllowWriting(Sender, AnObject: TObject; const APropName: WideString; var ATranslate: boolean);
begin
  ATranslate := (AnObject <> lblViewDetails) and
    (AnObject <> lvTranslateStrings.Columns[0]) and (AnObject <> lvTranslateStrings.Columns[1]) and
    not ((AnObject is TTntComboBox) and (TTntComboBox(AnObject).Style = csDropDown));
end;

procedure TfrmMain.DoFindNext(Sender: TObject);
var
  li: TTntListItem;
begin
  if (FLastFindText <> FFindReplace.FindText) then
    lvTranslateStrings.Selected := nil;
  SaveEditChanges;
  FLastFindText := FFindReplace.FindText;
  li := SearchFromCurrent(FLastFindText, FFindReplace.MatchCase, FFindReplace.MatchLine,
    not FFindReplace.SearchUp, FFindReplace.FuzzySearch, TFindIn(FFindReplace.FindInIndex));
  if li <> nil then
  begin
    lvTranslateStrings.Selected := li;
    lvTranslateStrings.Selected.MakeVisible(false)
  end
  else
    InfoMsg(WideFormat(Translate(ClassName, SFmtTextNotFound), [FFindReplace.FindText]),
      Translate(ClassName, SSearchFailCaption));
end;

procedure TfrmMain.DoFindReplace(Sender: TObject);
var
  i: integer;
  F: TReplaceFlags;
  b: boolean;
begin
  if lvTranslateStrings.Selected = nil then
  begin
    acFindNext.Execute;
    Exit;
  end;
  i := lvTranslateStrings.Selected.Index;

  b := false;
  if (FFindReplace.FindInIndex in [fiiOriginal, fiiBoth]) then
    b := MatchesString(FFindReplace.FindText, FTranslateFile.Items[i].Original, FFindReplace.MatchLine,
      FFindReplace.MatchCase, FFindReplace.FuzzySearch);
  if not b and (FFindReplace.FindInIndex in [fiiTranslation, fiiBoth]) then
    b := MatchesString(FFindReplace.FindText, FTranslateFile.Items[i].Translation, FFindReplace.MatchLine,
      FFindReplace.MatchCase, FFindReplace.FuzzySearch);
  if b then
  begin
    if FFindReplace.MatchLine then
      FTranslateFile.Items[i].Translation := FFindReplace.ReplaceText
    else
    begin
      F := [rfReplaceAll];
      if not FFindReplace.MatchCase then
        Include(F, rfIgnoreCase);
      FTranslateFile.Items[i].Translation := Tnt_WideStringReplace(FTranslateFile.Items[i].Translation,
        FFindReplace.FindText, FFindReplace.ReplaceText, F);
    end;
    FTranslateFile.Items[i].Translated := FTranslateFile.Items[i].Translation <> '';
    reTranslation.Text := FTranslateFile.Items[i].Translation;
    Modified := true;
  end;
  DoFindNext(Sender);
end;

procedure TfrmMain.DoFindReplaceAll(Sender: TObject);
var
  i: integer;
  b: boolean;
  F: TReplaceFlags;
  li: TTntListItem;
begin
  li := lvTranslateStrings.Selected;
  if li = nil then
    li := SearchFromCurrent(FFindReplace.FindText, FFindReplace.MatchCase, FFindReplace.MatchLine, not
      FFindReplace.SearchUp, FFindReplace.FuzzySearch, FFindReplace.FindInIndex);
  if li = nil then
  begin
    InfoMsg(WideFormat(Translate(ClassName, SFmtTextNotFound), [FFindReplace.FindText]),
      Translate(ClassName, SSearchFailCaption));
    Exit;
  end;
  SaveEditChanges;
  i := lvTranslateStrings.Selected.Index;
  F := [rfReplaceAll];
  if not FFindReplace.MatchCase then
    Include(F, rfIgnoreCase);
  while i < FTranslateFile.Items.Count do
  begin
    b := false;
    if (FFindReplace.FindInIndex in [fiiOriginal, fiiBoth]) then
      b := MatchesString(FFindReplace.FindText, FTranslateFile.Items[i].Original, FFindReplace.MatchLine,
        FFindReplace.MatchCase, FFindReplace.FuzzySearch);
    if not b and (FFindReplace.FindInIndex in [fiiTranslation, fiiBoth]) then
      b := MatchesString(FFindReplace.FindText, FTranslateFile.Items[i].Translation, FFindReplace.MatchLine,
        FFindReplace.MatchCase, FFindReplace.FuzzySearch);
    if b then
    begin
      if FFindReplace.MatchLine then
        FTranslateFile.Items[i].Translation := FFindReplace.ReplaceText
      else
      begin
        F := [rfReplaceAll];
        if not FFindReplace.MatchCase then
          Include(F, rfIgnoreCase);
        FTranslateFile.Items[i].Translation := Tnt_WideStringReplace(FTranslateFile.Items[i].Translation,
          FFindReplace.FindText, FFindReplace.ReplaceText, F);
      end;
      FTranslateFile.Items[i].Translated := FTranslateFile.Items[i].Translation <> '';
      if i = lvTranslateStrings.Selected.Index then
        reTranslation.Text := FTranslateFile.Items[i].Translation;
      Modified := true;
    end;
    Inc(i);
  end;
  if li <> nil then
  begin
    lvTranslateStrings.Selected := li;
    lvTranslateStrings.Selected.MakeVisible(false);
  end;
  lvTranslateStrings.Invalidate;
end;

// bookmark support

procedure TfrmMain.ClearBookmarks;
var
  i: integer;
begin
  for i := Low(FBookmarks) to High(FBookmarks) do
    FBookmarks[i] := -1;
  CheckBookMarkImages;
  lvTranslateStrings.Invalidate;
end;

function TfrmMain.GetBookmark(Index: integer): integer;
begin
  // get highest bookmark icon first
  for Result := High(FBookmarks) downto Low(FBookmarks) do
    if FBookmarks[Result] = Index then
      Exit;
  if FTranslateFile.Items[Index].Modified then
    Result := High(FBookmarks) + 1
  else
    Result := -1;
end;

procedure TfrmMain.GotoBookmark(Bookmark: integer);
begin
  if (FBookmarks[Bookmark] >= 0) and (FBookmarks[Bookmark] < lvTranslateStrings.Items.Count) then
    MoveListViewSelection(FBookmarks[Bookmark])
  else
    FBookmarks[Bookmark] := -1; // out of bounds
  CheckBookMarkImages;
end;

procedure TfrmMain.CheckBookMarkImages;
var
  i: integer;
begin
  lvTranslateStrings.StateImages := ilBookmarks;
  Exit;

  for i := Low(FBookmarks) to High(FBookmarks) do
    if FBookmarks[i] <> -1 then
    begin
      lvTranslateStrings.StateImages := ilBookmarks;
      Exit;
    end;
  lvTranslateStrings.StateImages := nil;
end;

procedure TfrmMain.ToggleBookmark(Bookmark, Index: integer);
begin
  if FBookmarks[Bookmark] = Index then
    FBookmarks[Bookmark] := -1 // toggle off
  else
    FBookmarks[Bookmark] := Index; // toggle on
  CheckBookMarkImages;
  lvTranslateStrings.Invalidate;
end;

procedure TfrmMain.WMDelayLoaded(var Message: TMessage);
begin
  if frmComments <> nil then
    frmComments.Pinned := GlobalAppOptions.PinCommentWindow;
  if lvTranslateStrings.VisibleRowCount < lvTranslateStrings.Items.Count then
    lvTranslateStrings.Columns[0].Width := lvTranslateStrings.Columns[0].Width - GetSystemMetrics(SM_CXVSCROLL);
end;

procedure TfrmMain.WMDropFiles(var Message: TWmDropFiles);
var
  ACount: integer;
  P: TPoint;
  buf: array[0..MAX_PATH] of char;
begin
  // find out where we are
  ACount := DragQueryFile(Message.Drop, $FFFFFFFF, nil, 0);
  try
    case ACount of
      0: Exit;
      1:
        begin
          DragQueryFile(Message.Drop, 0, buf, sizeof(buf));
          if FileExists(buf) then
          begin
            // find out where it was dropped so we can load the right file
            if not DragQueryPoint(Message.Drop, P) or PtInRect(Rect(0, 0, Width div 2, Height), P) then
            begin
              GlobalAppOptions.OriginalFile := buf;
              LoadOriginal(GlobalAppOptions.OriginalFile, DetectEncoding(GlobalAppOptions.OriginalFile));
              acNewTrans.Execute;
            end
            else
            begin
              GlobalAppOptions.TranslationFile := buf;
              LoadTranslation(GlobalAppOptions.TranslationFile, DetectEncoding(GlobalAppOptions.TranslationFile));
            end;
          end;
        end;
      2:
        begin
          DragQueryFile(Message.Drop, 0, buf, sizeof(buf));
          if FileExists(buf) then
            LoadOriginal(buf, DetectEncoding(buf));
          DragQueryFile(Message.Drop, 1, buf, sizeof(buf));
          if FileExists(buf) then
            LoadTranslation(buf, DetectEncoding(buf));
        end;
    else // more than 2
      begin
        DragQueryFile(Message.Drop, 0, buf, sizeof(buf));
        if FileExists(buf) then
          LoadOriginal(buf, DetectEncoding(buf));
        DragQueryFile(Message.Drop, 1, buf, sizeof(buf));
        if FileExists(buf) then
          LoadTranslation(buf, DetectEncoding(buf));
        DragQueryFile(Message.Drop, 2, buf, sizeof(buf));
        if FileExists(buf) then
          LoadDictionary(buf);
      end;
    end;
  finally
    DragFinish(Message.Drop);
  end;
  UpdateStatus;
end;

procedure TfrmMain.CreateDialogs;
begin
  { DONE : Localize these strings! }
  OpenOrigDlg := TEncodingOpenDialog.Create(Self);
  with OpenOrigDlg do
  begin
    DefaultExt := Translate(ClassName, SLngExt);
    Filter := Translate(ClassName, SFileFilter);

    InitialDir := '.';
    Title := Translate(ClassName, SOpenOrigTitle);
    Encodings.Add(Translate(ClassName, SANSI));
    Encodings.Add(Translate(ClassName, SUTF8));
    Encodings.Add(Translate(ClassName, SUnicode));
  end;

  OpenTransDlg := TEncodingOpenDialog.Create(Self);
  with OpenTransDlg do
  begin
    DefaultExt := Translate(ClassName, SLngExt);
    Filter := Translate(ClassName, SFileFilter);
    InitialDir := '.';
    Title := Translate(ClassName, SOpenTransTitle);
    Encodings.Add(Translate(ClassName, SANSI));
    Encodings.Add(Translate(ClassName, SUTF8));
    Encodings.Add(Translate(ClassName, SUnicode));
  end;
  SaveTransDlg := TEncodingSaveDialog.Create(Self);
  with SaveTransDlg do
  begin
    DefaultExt := Translate(ClassName, SLngExt);
    Filter := Translate(ClassName, SFileFilter);
    InitialDir := '.';
    Options := [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing];
    Title := Translate(ClassName, SSaveTransTitle);
    Encodings.Add(Translate(ClassName, SANSI));
    Encodings.Add(Translate(ClassName, SUTF8));
    Encodings.Add(Translate(ClassName, SUnicode));
  end;
  SaveOrigDlg := TEncodingSaveDialog.Create(Self);
  with SaveOrigDlg do
  begin
    DefaultExt := Translate(ClassName, SLngExt);
    Filter := Translate(ClassName, SFileFilter);
    InitialDir := '.';
    Options := [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing];
    Title := Translate(ClassName, SSaveOrigTitle);
    Encodings.Add(Translate(ClassName, SANSI));
    Encodings.Add(Translate(ClassName, SUTF8));
    Encodings.Add(Translate(ClassName, SUnicode));
  end;
end;

function TfrmMain.CheckModified: boolean;
begin
  Result := true;
  if Modified then
  begin
    case YesNoCancel(Translate(ClassName, SSavePrompt), Translate(ClassName, SConfirmCaption)) of
      IDYES:
        Result := SaveTranslation(GlobalAppOptions.TranslationFile, TEncoding(GlobalAppOptions.TransEncoding));
      IDNO: Result := true; // do nothing
      IDCANCEL:
        Result := false;
    end;
  end
  else
    Modified := false;
end;

function TfrmMain.CheckDictModified: boolean;
begin
  Result := true;
  if FDict.Modified then
  begin
    case YesNoCancel(Translate(ClassName, SSaveDictPrompt), Translate(ClassName, SConfirmCaption)) of
      IDYES:
        Result := acDictSave.Execute;
      IDNO:
        Result := true; // do nothing
      IDCANCEL:
        Result := false;
    end;
  end
  else
    Modified := false;
end;

{$IFDEF VER150}

procedure TfrmMain.FixXPPanelBug;
var
  i: integer;
begin
  // there's an annoying bug in Delphi 7 when running under XP:
  // if TPanel.ParentBackground isn't explicitly set false,  the panel will be transparent...
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TCustomPanel then
      TCustomPanel(Components[i]).ParentBackground := false;
end;
{$ELSE}

procedure TfrmMain.FixXPPanelBug;
begin
end;
{$ENDIF}

procedure TfrmMain.AddMRUFile(const FileName: string; AOriginal: boolean);
var
  S: string;
begin
  if AOriginal then
    S := WideFormat('%s [%s]', [FileName, GlobalAppOptions.TranslationFile])
  else
    S := WideFormat('%s [%s]', [GlobalAppOptions.OriginalFile, FileName]);
  MRUFiles.Add(S);
end;

procedure TfrmMain.OpenMRUFiles(const FileName: string);
var
  Orig, Trans: string;
begin
  Orig := trim(Copy(FileName, 1, Pos('[', FileName) - 1));
  if Orig <> '' then
    Trans := strBetween(FileName, '[', ']')
  else
  begin
    Trans := '';
    Orig := FileName;
  end;
  if (Orig <> '') and FileExists(Orig) then
    LoadOriginal(Orig, DetectEncoding(Orig));
  if (Trans <> '') and FileExists(Trans) then
    LoadTranslation(Trans, DetectEncoding(Trans))
  else
    acOpenTrans.Execute;
end;

function TfrmMain.MRUFileExists(const FileName: string): boolean;
var
  Orig, Trans: string;
begin
  Orig := trim(Copy(FileName, 1, Pos('[', FileName) - 1));
  if Orig <> '' then
    Trans := strBetween(FileName, '[', ']')
  else
  begin
    Trans := '';
    Orig := FileName;
  end;
  Result := (Orig <> '') and (Trans <> '') and FileExists(Orig) and FileExists(Trans);
end;

// frmMain event handlers

procedure TfrmMain.alMainUpdate(Action: TBasicAction;
  var Handled: boolean);
var
  Index, ACount: integer;
begin
  if GetActiveWindow <> Handle then
  begin
    alMain.State := asSuspended;
    Exit;
  end
  else
    alMain.State := asNormal;
  if lvTranslateStrings.Selected <> nil then
    Index := lvTranslateStrings.Selected.Index
  else
    Index := -1;
  ACount := FTranslateFile.Items.Count;
  acUndo.Enabled := reTranslation.Focused and Modified;
  acDictSave.Enabled := FDict.Count > 0;
  acDictEdit.Enabled := acDictSave.Enabled;
  acDictTranslate.Enabled := (FDict.Count > 0) and (ACount > 0);
  acDictAdd.Enabled := (Index > -1) and (FTranslateFile.Items[Index].Original <> '') and (FTranslateFile.Items[Index].Translation <> '');

  acFind.Enabled := ACount > 0;
  acFindNext.Enabled := ACount > 0;
  acReplace.Enabled := ACount > 0;
  //  acSaveTrans.Enabled := Modified;
  acPrev.Enabled := (Index > -1) and (Index > 0);
  acNext.Enabled := (Index > -1) and (Index < lvTranslateStrings.Items.Count - 1);
  acAsciiValues.Enabled := (reOriginal.SelLength > 0) or (reTranslation.SelLength > 0);
  acClearAllTranslations.Enabled := ACount > 0;
  acReplaceEverywhere.Enabled := (Index > -1);
  acNextSuspicious.Enabled := ACount > 0;
  acViewOrphans.Enabled := FTranslateFile.Orphans.Count > 0;
  acViewComments.Checked := (frmComments <> nil) and frmComments.Visible;
  acCopy.Enabled := (ActiveControl is TCustomEdit) and (TCustomEdit(ActiveControl).SelLength > 0);
  acCut.Enabled := acCopy.Enabled and
    (GetWindowLong(TCustomEdit(ActiveControl).Handle, GWL_STYLE) and ES_READONLY <> ES_READONLY);
  acPaste.Enabled := (TntClipboard.HasFormat(CF_TEXT) or TntClipboard.HasFormat(CF_UNICODETEXT)) and
    (GetWindowLong(TCustomEdit(ActiveControl).Handle, GWL_STYLE) and ES_READONLY <> ES_READONLY);
  acToggleTranslated.Enabled := Index > -1;
  acToggleTranslated.Checked := acToggleTranslated.Enabled and FTranslateFile.Items[Index].Translated;

  acDeleteItem.Enabled := (Index <> -1) and ((FCapabilitesSupported = 0) or (FCapabilitesSupported and CAP_ITEM_DELETE = CAP_ITEM_DELETE));
  acAddItem.Enabled := (Index <> -1) and ((FCapabilitesSupported = 0) or (FCapabilitesSupported and CAP_ITEM_INSERT = CAP_ITEM_INSERT));
  acEditItem.Enabled := (Index <> -1) and ((FCapabilitesSupported = 0) or (FCapabilitesSupported and CAP_ITEM_EDIT = CAP_ITEM_EDIT));
  acTrim.Enabled := FTranslateFile.Items.Count > 0;
  // Handled := true;
end;

procedure TfrmMain.acFontExecute(Sender: TObject);
begin
  MainFontDlg.Font := GlobalAppOptions.AppFont;
  if MainFontDlg.Execute then
    MainFontDlgApply(Sender, MainFontDlg.Handle);
end;

procedure TfrmMain.MainFontDlgApply(Sender: TObject; Wnd: HWND);
var
  tmp: boolean;
begin
  tmp := reTranslation.Modified;
  try
    GlobalAppOptions.AppFont.Assign(MainFontDlg.Font);
    Font.CharSet := DEFAULT_CHARSET;
    lvTranslateStrings.Font := GlobalAppOptions.AppFont;
    reOriginal.Font := GlobalAppOptions.AppFont;
    reTranslation.Font := GlobalAppOptions.AppFont;
  finally
    reTranslation.Modified := tmp;
  end;
end;

procedure TfrmMain.lvTranslateStringsColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  WaitCursor;
  //  lvTranslateStrings.Items.Count := 0;
  try
    lvTranslateStrings.Columns[0].ImageIndex := -1;
    lvTranslateStrings.Columns[1].ImageIndex := -1;
    case Column.Index of

      0:
        begin
          if FTranslateFile.Items.Sort <> stOriginal then
          begin
            FTranslateFile.Items.Sort := stOriginal;
            lvTranslateStrings.Columns[0].ImageIndex := cArrowDown;
          end
          else
          begin
            FTranslateFile.Items.Sort := stInvertOriginal;
            lvTranslateStrings.Columns[0].ImageIndex := cArrowUp;
          end;
        end;
      1:
        begin
          if FTranslateFile.Items.Sort <> stTranslation then
          begin
            FTranslateFile.Items.Sort := stTranslation;
            lvTranslateStrings.Columns[1].ImageIndex := cArrowDown;
          end
          else
          begin
            FTranslateFile.Items.Sort := stInvertTranslation;
            lvTranslateStrings.Columns[1].ImageIndex := cArrowUp;
          end;
        end;
      2:
        begin
          if FTranslateFile.Items.Sort <> stIndex then
          begin
            FTranslateFile.Items.Sort := stIndex;
            lvTranslateStrings.Columns[2].ImageIndex := cArrowDown;
          end
          else
          begin
            FTranslateFile.Items.Sort := stInvertIndex;
            lvTranslateStrings.Columns[2].ImageIndex := cArrowUp;
          end;
        end;
    end; // case
  finally
    //    lvTranslateStrings.Items.Count := FTranslateFile.Count;
    lvTranslateStrings.Invalidate;
  end;
end;

procedure TfrmMain.acRestoreSortExecute(Sender: TObject);
var
  i, j: integer;
begin
  if not lvTranslateStrings.HandleAllocated then
    Exit;
  WaitCursor;
  if lvTranslateStrings.Selected <> nil then
    i := lvTranslateStrings.Selected.Index
  else
    i := 0;
  ScrollToTop;
  lvTranslateStrings.Items.Count := 0;
  try
    FTranslateFile.Items.Sort := stIndex;
    for j := 0 to lvTranslateStrings.Columns.Count - 1 do
      lvTranslateStrings.Columns[j].ImageIndex := -1;
  finally
    lvTranslateStrings.Items.Count := FTranslateFile.Items.Count;
    if FTranslateFile.Items.Count > 0 then
    begin
      lvTranslateStrings.Selected := lvTranslateStrings.Items[i];
      lvTranslateStrings.Invalidate;
    end;
  end;
end;

procedure TfrmMain.pnlBottomResize(Sender: TObject);
var
  W: integer;
begin
  W := pnlBottom.Height - pnlOrig.Height - pnlTrans.Height;
  if W < 0 then
    Exit;
  reOriginal.Height := W div 2;
end;

procedure TfrmMain.acDictSaveExecute(Sender: TObject);
begin
  if FDict.Count = 0 then
  begin
    ErrMsg(Translate(ClassName, SErrDictEmpty), Translate(ClassName, SInfoCaption));
    Exit;
  end;
  SaveDictDlg.FileName := GlobalAppOptions.DictionaryFile;
  if SaveDictDlg.Execute then
  begin
    SaveDictionary(SaveDictDlg.FileName);
    UpdateStatus;
  end;
end;

procedure TfrmMain.acDictLoadExecute(Sender: TObject);
begin
  OpenDictDlg.Filename := GlobalAppOptions.DictionaryFile;
  if OpenDictDlg.Execute then
  begin
    LoadDictionary(OpenDictDlg.FileName);
    UpdateStatus;
  end;
end;

procedure TfrmMain.acDictCreateExecute(Sender: TObject);
begin
  CreateDict(YesNo(Translate(ClassName, SClearDictPrompt), Translate(ClassName, SConfirmCaption)));
  InfoMsg(Translate(ClassName, SDictCreated), Translate(ClassName, SInfoCaption));
end;

procedure TfrmMain.acDictTranslateExecute(Sender: TObject);
begin
  if FDict.Count = 0 then
  begin
    ErrMsg(Translate(ClassName, SErrDictEmpty), Translate(ClassName, SInfoCaption));
    Exit;
  end;
  WaitCursor;
  try
    UseDictionary;
  finally
    lvTranslateStrings.Invalidate;
  end;
end;

procedure TfrmMain.acExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  ScreenCursor(crAppStart);
  ClearBookmarks;
  FixXPPanelBug;
  BuildExternalToolMenu(mnuPlugins);

  GlobalLanguageFile.OnRead := DoReadObject;

  GlobalLanguageFile.SkipProperty('Name');
  GlobalLanguageFile.SkipProperty('Category');
  GlobalLanguageFile.SkipProperty('HelpKeyWord');
  GlobalLanguageFile.SkipProperty('HelpFile');
  GlobalLanguageFile.SkipProperty('Filename');
  GlobalLanguageFile.SkipProperty('ImeName');
  GlobalLanguageFile.SkipProperty('SecondaryShortCuts');
  GlobalLanguageFile.SkipProperty('DefaultExt');
  GlobalLanguageFile.SkipProperty('InitialDir');
  GlobalLanguageFile.SkipProperty('FindText');
  GlobalLanguageFile.SkipProperty('ReplaceText');
  GlobalLanguageFile.SkipProperty('FindHistory');
  GlobalLanguageFile.SkipProperty('ReplaceHistory');

  GlobalLanguageFile.SkipClass(TPanel);
  GlobalLanguageFile.SkipClass(THintWindow);
  GlobalLanguageFile.SkipClass(TStatusBar);
  GlobalLanguageFile.SkipClass(TStatusPanel);
  GlobalLanguageFile.SkipClass(TAction);
  GlobalLanguageFile.SkipClass(TCustomEdit);
  GlobalLanguageFile.SkipClass(TTBXStatusBar);
  GlobalLanguageFile.SkipClass(TTBXStatusPanel);
  GlobalLanguageFile.SkipClass(TTBXSeparatorItem);
  GlobalLanguageFile.SkipClass(TTBXComboBoxItem);
  GlobalLanguageFile.SkipClass(TTBXSwitcher);
  GlobalLanguageFile.SkipClass(TTBXMRUList);
  GlobalLanguageFile.SkipClass(TProgressBar);

  DragAcceptFiles(Handle, true);
  ToolbarFont.CharSet := DEFAULT_CHARSET;
  FTranslateFile := TTranslateFiles.Create;
  FFindReplace := TFindReplace.Create(Self);
  FDict := TDictionaryItems.Create;
  SetLength(FFileMonitors, 3);

  LoadSettings(true);
  HandleCommandLine;
  UpdateStatus;

  Windows.SetFocus(reTranslation.Handle);
  // strange bug here: form picks up "Show about box" hint (something to do with TBX maybe?)
  Hint := '';
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  i: integer;
begin
  WaitCursor;
  CanClose := CheckModified and CheckDictModified;
  if not CanClose then
    Exit;
  if acFullScreen.Checked then
    acFullScreen.Execute;
  DragAcceptFiles(Handle, false);
  SaveEditChanges;
  SaveSettings;
  FTranslateFile.Free;
  FDict.Free;
  FExternalToolItems.Free;
  for i := 0 to Length(FFileMonitors) - 1 do
    if FFileMonitors[i] <> nil then
      FFileMonitors[i].Terminate;
end;

procedure TfrmMain.lvTranslateStringsChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if Item <> nil then
    with FTranslateFile.Items[Item.Index] do
    begin
      reOriginal.Text := AddQuotes(MyWideDequotedStr(Original, OrigQuote));
      reTranslation.Text := AddQuotes(MyWideDequotedStr(Translation, TransQuote));
      reTranslation.Modified := false;
      if frmComments <> nil then
      begin
        frmComments.SetComments(FTranslateFile.Items[Item.Index], FTranslateFile.CommentChar);
        frmComments.OnCommentModified := DoCommentModified;
      end;
    end
  else if frmComments <> nil then
    frmComments.SetComments(nil, FTranslateFile.CommentChar);
  UpdateStatus;
end;

procedure TfrmMain.reTranslationExit(Sender: TObject);
var
  i: integer;
begin
  if reTranslation.Modified and (lvTranslateStrings.Selected <> nil) then
  begin
    i := lvTranslateStrings.Selected.Index;
    with FTranslateFile.Items[i] do
    begin
      Translation := RemoveQuotes(trimCRLFRight(reTranslation.Text));
      Translated := MyWideDequotedStr(Translation, TransQuote) <> '';
      lvTranslateStrings.Invalidate;
      if GlobalAppOptions.UseTranslationEverywhere then
      begin
        reTranslation.Modified := false; // avoid infinite recursion
        acReplaceEverywhere.Execute;
      end;
      Modified := true;
    end;
    UpdateStatus;
  end
end;

procedure TfrmMain.lvTranslateStringsData(Sender: TObject;
  Item: TListItem);
begin
  if Item = nil then
    Exit;

  with FTranslateFile.Items[Item.Index] do
  begin
    TTntListItem(Item).Caption := MyWideDequotedStr(Original, OrigQuote);
    if not Translated then
    begin
      Item.ImageIndex := cDefaultUntranslatedImage;
      if (trim(OrigComments) <> '') or (trim(TransComments) <> '') then
        Item.ImageIndex := cUntranslatedCommentImage;
    end
    else
    begin
      Item.ImageIndex := cDefaultItemImage;
      if (trim(OrigComments) <> '') or (trim(TransComments) <> '') then
        Item.ImageIndex := cTranslatedCommentImage;
    end;
    TTntListItem(Item).SubItems.Add(MyWideDequotedStr(Translation, TransQuote));
    TTntListItem(Item).SubItems.Add(IntToStr(Index + 1));
  end;

  Item.StateIndex := GetBookmark(Item.Index);
end;

procedure TfrmMain.acOpenOrigExecute(Sender: TObject);
begin
  if not CheckModified then
    Exit;
  OpenOrigDlg.FileName := GetFilename(GlobalAppOptions.OriginalFile);
  OpenOrigDlg.FilterIndex := GlobalAppOptions.FilterIndex;
  OpenOrigDlg.EncodingIndex := GlobalAppOptions.OrigEncoding;
  if OpenOrigDlg.Execute then
  begin
    GlobalAppOptions.FilterIndex := OpenOrigDlg.FilterIndex;
    Modified := false;
    LoadOriginal(OpenOrigDlg.FileName, TEncoding(OpenOrigDlg.EncodingIndex));
    acOpenTrans.Execute;
  end;
end;

procedure TfrmMain.acOpenTransExecute(Sender: TObject);
begin
  if not CheckModified then
    Exit;
  OpenTransDlg.FileName := GetFilename(GlobalAppOptions.TranslationFile);
  OpenTransDlg.FilterIndex := GlobalAppOptions.FilterIndex;
  OpenTransDlg.EncodingIndex := GlobalAppOptions.TransEncoding;
  if OpenTransDlg.Execute then
  begin
    GlobalAppOptions.FilterIndex := OpenOrigDlg.FilterIndex;
    Modified := false;
    LoadTranslation(OpenTransDlg.FileName, TEncoding(OpenTransDlg.EncodingIndex));
    // jump directly to first untranslated item (if available)
    acNextUntranslated.Execute;
  end;
end;

procedure TfrmMain.acSaveTransExecute(Sender: TObject);
begin
  //  if not HandleImportedSave then
  SaveTranslation(GlobalAppOptions.TranslationFile, TEncoding(GlobalAppOptions.TransEncoding));
end;

procedure TfrmMain.acSaveTransAsExecute(Sender: TObject);
begin
  SaveTranslationAs(GlobalAppOptions.TranslationFile, TEncoding(GlobalAppOptions.TransEncoding));
end;

procedure TfrmMain.acSaveOriginalExecute(Sender: TObject);
begin
  SaveOriginal(GlobalAppOptions.OriginalFile, TEncoding(GlobalAppOptions.OrigEncoding));
end;

procedure TfrmMain.acSaveOrigAsExecute(Sender: TObject);
begin
  SaveOrigAs(GlobalAppOptions.OriginalFile, TEncoding(GlobalAppOptions.OrigEncoding));
end;

procedure TfrmMain.acPrevExecute(Sender: TObject);
begin
  if (lvTranslateStrings.Selected = nil) then
    MoveListViewSelection(0)
  else
    MoveListViewSelection(lvTranslateStrings.Selected.Index - 1);
end;

procedure TfrmMain.acNextExecute(Sender: TObject);
begin
  if (lvTranslateStrings.Selected = nil) then
    MoveListViewSelection(0)
  else
    MoveListViewSelection(lvTranslateStrings.Selected.Index + 1)
end;

procedure TfrmMain.acCopyFromOriginalExecute(Sender: TObject);
begin
  reTranslation.Text := reOriginal.Text;
  Modified := true;
end;

procedure TfrmMain.reTranslationEnter(Sender: TObject);
begin
  reTranslation.SelectAll;
end;

procedure TfrmMain.acAboutExecute(Sender: TObject);
var
  S: WideString;
begin
  S := WideFormat(Translate(ClassName, SFmtAboutText), [Caption, GetAppVersion]);
  AboutMsg(S, WideFormat(Translate(ClassName, SFmtAboutCaption), [Caption]));
end;

procedure TfrmMain.acCutExecute(Sender: TObject);
begin
  if ActiveControl is TTntRichEdit then
  begin
    TntClipboard.AsWideText := trimCRLFRight(TTntRichEdit(ActiveControl).SelText);
    TTntRichEdit(ActiveControl).SelText := '';
    TTntRichEdit(ActiveControl).Modified := true;
  end
  else if ActiveControl is TWinControl then
    SendMessage(TWinControl(ActiveControl).Handle, WM_CUT, 0, 0);
end;

procedure TfrmMain.acCopyExecute(Sender: TObject);
begin
  if ActiveControl is TTntRichEdit then
    TntClipboard.AsWideText := trimCRLFRight(TTntRichEdit(ActiveControl).SelText)
  else if ActiveControl is TWinControl then
    SendMessage(TWinControl(ActiveControl).Handle, WM_COPY, 0, 0);
end;

procedure TfrmMain.acPasteExecute(Sender: TObject);
begin
  if ActiveControl is TTntRichEdit then
  begin
    TTntRichEdit(ActiveControl).SelText := trimCRLFRight(TntClipboard.AsWideText);
    TTntRichEdit(ActiveControl).Modified := true;
  end
  else if ActiveControl is TWinControl then
    SendMessage(TWinControl(ActiveControl).Handle, WM_PASTE, 0, 0);
end;

procedure TfrmMain.acSelectAllExecute(Sender: TObject);
begin
  if ActiveControl is TWinControl then
    SendMessage(TWinControl(ActiveControl).Handle, EM_SETSEL, 0, -1);
end;

procedure TfrmMain.acUndoExecute(Sender: TObject);
begin
  if ActiveControl is TWinControl then
    SendMessage(TWinControl(ActiveControl).Handle, WM_UNDO, 0, 0);
end;

procedure TfrmMain.lvTranslateStringsEnter(Sender: TObject);
begin
  if (lvTranslateStrings.Selected = nil) and (lvTranslateStrings.Items.Count > 0) then
    lvTranslateStrings.Selected := lvTranslateStrings.Items[0];
  if (lvTranslateStrings.Selected <> nil) then
    lvTranslateStrings.Selected.Focused := true;
end;

procedure TfrmMain.acToggleFocusExecute(Sender: TObject);
begin
  if lvTranslateStrings.Focused then
    reTranslation.SetFocus
  else
    lvTranslateStrings.SetFocus;
end;

procedure TfrmMain.acFocusTranslationExecute(Sender: TObject);
begin
  reTranslation.SetFocus;
  reTranslation.SelectAll;
end;

procedure TfrmMain.acFindExecute(Sender: TObject);
begin
  if not FFindReplace.Showing then
  begin
    SaveEditChanges;
    FFindReplace.Expanded := false;
    FFindReplace.FindInIndex := TFindIn(GlobalAppOptions.FindInIndex);
    FFindReplace.Execute;
  end;
end;

procedure TfrmMain.acFindNextExecute(Sender: TObject);
begin
  if FFindReplace.FindText = '' then
    acFind.Execute
  else
  begin
    SaveEditChanges;
    DoFindNext(Sender);
  end;
end;

procedure TfrmMain.acReplaceExecute(Sender: TObject);
begin
  if not FFindReplace.Showing then
  begin
    FFindReplace.Expanded := true;
    FFindReplace.Execute;
  end;
end;

procedure TfrmMain.lvTranslateStringsAdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: boolean);
begin
  DefaultDraw := true;
  if (Item <> nil) and (Stage = cdPrePaint) then
  begin
    if not FTranslateFile.Items[Item.Index].Translated then
      Sender.Canvas.Brush.Color := cColorUntranslated
    else if Odd(Item.Index) then
      Sender.Canvas.Brush.Color := cColorAlternateList1
    else
      Sender.Canvas.Brush.Color := cColorAlternateList2;
  end;
end;

procedure TfrmMain.acNextUntranslatedExecute(Sender: TObject);
var
  i: integer;
begin
  SaveEditChanges;
  if lvTranslateStrings.Selected = nil then
    i := 0
  else
    i := lvTranslateStrings.Selected.Index + 1;
  if i >= FTranslateFile.Items.Count then
    i := 0; // wrap
  while i < FTranslateFile.Items.Count do
  begin
    if not FTranslateFile.Items[i].Translated then
    begin
      lvTranslateStrings.Selected := lvTranslateStrings.Items[i];
      lvTranslateStrings.Selected.MakeVisible(false);
      Exit;
    end;
    Inc(i);
  end;
end;

procedure TfrmMain.acPrevUntranslatedExecute(Sender: TObject);
var
  i: integer;
begin
  SaveEditChanges;
  if lvTranslateStrings.Selected = nil then
    i := FTranslateFile.Items.Count - 1
  else
    i := lvTranslateStrings.Selected.Index - 1;
  if i < 0 then
    i := FTranslateFile.Items.Count - 1; // wrap
  while i > -1 do
  begin
    if not FTranslateFile.Items[i].Translated then
    begin
      lvTranslateStrings.Selected := lvTranslateStrings.Items[i];
      lvTranslateStrings.Selected.MakeVisible(false);
      Exit;
    end;
    Dec(i);
  end;
end;

procedure TfrmMain.acFocusListViewExecute(Sender: TObject);
begin
  lvTranslateStrings.SetFocus;
end;

procedure TfrmMain.acFocusOriginalExecute(Sender: TObject);
begin
  reOriginal.SetFocus;
  reOriginal.SelectAll;
end;

procedure TfrmMain.acShowQuotesExecute(Sender: TObject);
begin
  acShowQuotes.Checked := not acShowQuotes.Checked;
  lvTranslateStringsChange(Sender, lvTranslateStrings.Selected, ctText);
end;

procedure TfrmMain.acDictInvertExecute(Sender: TObject);
begin
  WaitCursor;
  acDictInvert.Checked := not acDictInvert.Checked;
  FDict.Invert;
  UpdateStatus;
end;

procedure TfrmMain.acDictAddExecute(Sender: TObject);
var
  Index: integer;
begin
  Index := lvTranslateStrings.Selected.Index;
  with FTranslateFile.Items[Index] do
    if acDictInvert.Checked then
      FDict.Add(Translation).Translations.Add(Original)
    else
      FDict.Add(Original).Translations.Add(Translation);
end;

procedure TfrmMain.acHelpExecute(Sender: TObject);
begin
  if not FileExists(GlobalAppOptions.HelpFile) then
    ErrMsg(WideFormat(Translate(ClassName, SFmtErrHelpNotFound), [GlobalAppOptions.HelpFile]),
      Translate(ClassName, SErrorCaption))
  else
    ShellExecute(Handle, '', PChar(GlobalAppOptions.HelpFile), nil, nil, SW_SHOWNORMAL);
  //
end;

procedure TfrmMain.lvTranslateStringsDataFind(Sender: TObject;
  Find: TItemFind; const FindString: WideString;
  const FindPosition: TPoint; FindData: Pointer; StartIndex: integer;
  Direction: TSearchDirection; Wrap: boolean; var Index: integer);
begin
  // since DataFind is called as soon as the user types in the listview, we can check
  // for auto focus here instead of using the keydown event
  Index := -1;
  if GlobalAppOptions.AutoFocusTranslation then
  begin
    reTranslation.Text := FindString;
    reTranslation.SetFocus;
    reTranslation.SelStart := Length(FindString);
    Exit;
  end;

  // we ignore most properties here
  while (StartIndex >= 0) and (StartIndex < FTranslateFile.Items.Count) do
  begin
    if AnsiStartsText(FindString, FTranslateFile.Items[StartIndex].Original) then
    begin
      Index := StartIndex;
      Exit;
    end;
    if Direction <> sdAbove then
      Inc(StartIndex)
    else
      Dec(StartIndex);
  end;
end;

procedure TfrmMain.acNewTransExecute(Sender: TObject);
var
  i, j: integer;
begin
  if lvTranslateStrings.Selected <> nil then
    j := lvTranslateStrings.Selected.Index
  else
    j := 0;
  ScrollToTop;
  lvTranslateStrings.Items.Count := 0;
  try
    for i := 0 to FTranslateFile.Items.Count - 1 do
    begin
      FTranslateFile.Items[i].Translation := '';
      FTranslateFile.Items[i].Translated := false;
    end;
  finally
    lvTranslateStrings.Items.Count := FTranslateFile.Items.Count;
    lvTranslateStrings.Invalidate;
    if j < FTranslateFile.Items.Count then
      lvTranslateStrings.Selected :=
        lvTranslateStrings.Items[j];
  end;
  GlobalAppOptions.TranslationFile := '';
  UpdateStatus;
end;

procedure TfrmMain.acCreateTranslationFileExecute(Sender: TObject);
var
  frm1, frm2, frm3, frm4, frm5, frm6, frm7, frm8, frm9, frm10, frm11: TfrmBase;
begin
  with TTntSaveDialog.Create(nil) do
  try
    Options := Options + [ofOverwritePrompt];
    Title := Translate(ClassName, SSaveTranslationTemplate);
    if Execute then
    begin
      DeleteFile(FileName);
      GlobalLanguageFile.OnWriting := DoAllowWriting;
      GlobalLanguageFile.OnWrite := DoWriteObject;
      GlobalLanguageFile.OnWriteAdditional := DoSaveExtra;
      // create the forms so we can access their properties
      frm1 := TfrmOptions.Create(Application);
      frm2 := TfrmOrphans.Create(Application);
      frm3 := TfrmConfigKbd.Create(Application);
      frm4 := TfrmImportExport.Create(Application);
      frm5 := TfrmTools.Create(Application);
      frm6 := TfrmPromptArgs.Create(Application);
      frm7 := TfrmEditItem.Create(Application);
      frm8 := TfrmTrim.Create(Application);
      frm9 := TfrmConfigSuspicious.Create(Application);
      frm10 := TfrmDictTranslationSelect.Create(Application);
      frm11 := TfrmDictEdit.Create(Application);
      try
        GlobalLanguageFile.CreateTemplate(FileName, Application);
      finally
        frm1.Free;
        frm2.Free;
        frm3.Free;
        frm4.Free;
        frm5.Free;
        frm6.Free;
        frm7.Free;
        frm8.Free;
        frm9.Free;
        frm10.Free;
        frm11.Free;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TfrmMain.acCopyAllFromOrigExecute(Sender: TObject);
var
  i: integer;
begin
  lvTranslateStrings.Items.Count := 0;
  try
    for i := 0 to FTranslateFile.Items.Count - 1 do
      if not FTranslateFile.Items[i].Translated then
      begin
        FTranslateFile.Items[i].Translation := FTranslateFile.Items[i].Original;
        FTranslateFile.Items[i].Translated := FTranslateFile.Items[i].Translation <> '';
      end;
  finally
    lvTranslateStrings.Items.Count := FTranslateFile.Items.Count;
    lvTranslateStrings.Invalidate;
  end;
end;

procedure TfrmMain.acViewDetailsExecute(Sender: TObject);
begin
  acViewDetails.Checked := not acViewDetails.Checked;
  pnlKeyBack.Visible := acViewDetails.Checked;
end;

procedure TfrmMain.acPasteUpdate(Sender: TObject);
begin
  // the standard edit cut/paste actions doesn't do this right:
  if (ActiveControl is TCustomEdit) and TCustomEdit(ActiveControl).HandleAllocated then
  begin
    acPaste.Enabled := GetWindowLong(TCustomEdit(ActiveControl).Handle, GWL_STYLE) and ES_READONLY = 0;
    acCut.Enabled := acPaste.Enabled and (TCustomEdit(ActiveControl).SelLength > 0);
  end
  else
  begin
    acCut.Enabled := false;
    acPaste.Enabled := false;
  end;
end;

procedure TfrmMain.reTranslationKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    if GlobalAppOptions.SaveOnReturn then
      reTranslationExit(Sender); // save changes
    if GlobalAppOptions.AutoMoveToNext then
    begin
      if ssShift in Shift then
        acPrev.Execute
      else
        acNext.Execute;
    end;
    Key := 0;
  end;
end;

procedure TfrmMain.acCopyFromNameExecute(Sender: TObject);
begin
  if lvTranslateStrings.Selected <> nil then
  begin
    reTranslation.Text := FTranslateFile.Items[lvTranslateStrings.Selected.Index].Name;
    Modified := true;
  end;
end;

procedure TfrmMain.acPreferencesExecute(Sender: TObject);
begin
  SaveSettings;
  if TfrmOptions.Execute(GlobalAppOptions) then
    LoadSettings(false);
end;

procedure TfrmMain.acViewCommentsExecute(Sender: TObject);
begin
  if frmComments <> nil then
  begin
    if frmComments.Visible then
      frmComments.Hide
    else
    begin
      frmComments.Show;
      MoveCommentWindow;
      SetFocus;
    end;
  end;
end;

procedure TfrmMain.acAsciiValuesExecute(Sender: TObject);
var
  S, T: string;
  i: integer;
begin
  if reOriginal.Focused then
    S := reOriginal.SelText
  else
    S := reTranslation.SelText;
  T := '  ';
  for i := 1 to Length(S) do
    T := T + ' $' + IntToHex(Ord(S[i]), 2);
  T := T + #13#10'  ';
  for i := 1 to Length(S) do
    T := T + WideFormat('Alt+%.5d ', [Ord(S[i])]);
  if YesNo(Translate(ClassName, SAsciiValue) + #13#10 + T + #13#10#13#10 + Translate(ClassName, SQCopyToClipboard),
    Translate(ClassName, SDecodedCharsCaption)) then
    TntClipboard.AsWideText := T;
end;

procedure TfrmMain.lvTranslateStringsInfoTip(Sender: TObject;
  Item: TListItem; var InfoTip: string);
var
  P: TPoint;
  AInfoTip: WideString;
begin
  InfoTip := '';
  AInfoTip := '';
  if Item <> nil then
  begin
    GetCursorPos(P);
    if PtInRect(Rect(Left, Top, Left + Width div 2, Height), P) then
    begin
      if trim(FTranslateFile.Items[Item.Index].OrigComments) <> '' then
        AInfoTip := Translate(ClassName, SOriginal) + ':'#13#10 + trim(FTranslateFile.Items[Item.Index].OrigComments)
      else
        AInfoTip := FTranslateFile.Items[Item.Index].Original;
    end
    else if PtInRect(Rect(Left + Width div 2, Top, Left + Width, Height), P) then
    begin
      if trim(FTranslateFile.Items[Item.Index].TransComments) <> '' then
        AInfoTip := Translate(ClassName, STranslation) + ':'#13#10 + trim(FTranslateFile.Items[Item.Index].TransComments)
      else
        AInfoTip := FTranslateFile.Items[Item.Index].Translation;
    end
    else
    begin
      if trim(FTranslateFile.Items[Item.Index].OrigComments) <> '' then
        AInfoTip := Translate(ClassName, SOriginal) + ':'#13#10 + trim(FTranslateFile.Items[Item.Index].OrigComments) +
          #13#10#13#10;
      if trim(FTranslateFile.Items[Item.Index].TransComments) <> '' then
        AInfoTip := Translate(ClassName, STranslation) + ':'#13#10 +
          trim(FTranslateFile.Items[Item.Index].TransComments);
      if AInfoTip = '' then
        AInfoTip := FTranslateFile.Items[Item.Index].Original + ' - ' + FTranslateFile.Items[Item.Index].Translation;
    end;
  end;
  InfoTip := AInfoTip;
  lvTranslateStrings.Hint := AInfoTip;
end;

procedure TfrmMain.MRUFilesClick(Sender: TObject; const FileName: string);
begin
  if not CheckModified then
    Exit;
  OpenMRUFiles(FileName);
end;

procedure TfrmMain.acClearMRUExecute(Sender: TObject);
begin
  MRUFiles.Items.Clear;
end;

procedure TfrmMain.acClearInvalidMRUExecute(Sender: TObject);
var
  i: integer;
begin
  for i := MRUFiles.Items.Count - 1 downto 0 do
    if not MRUFileExists(MRUFiles.Items[i]) then
      MRUFiles.Items.Delete(i);
end;

procedure TfrmMain.mnuFileSelect(Sender: TTBCustomItem;
  Viewer: TTBItemViewer; Selecting: boolean);
begin
  miRecentlyUsed.Enabled := MRUFiles.Items.Count > 0;
end;

procedure TfrmMain.acFindUnmatchedShortCutExecute(Sender: TObject);
var
  i: integer;

begin
  SaveEditChanges;
  if lvTranslateStrings.Selected = nil then
    i := 0
  else
    i := lvTranslateStrings.Selected.Index + 1;
  if i < 0 then
    i := lvTranslateStrings.Items.Count - 1;
  if i > lvTranslateStrings.Items.Count - 1 then
    i := 0;
  while (i >= 0) and (i < lvTranslateStrings.Items.Count - 1) do
  begin
    if (FTranslateFile.Items[i].Translation <> '') and (SubStrCount('&', FTranslateFile.Items[i].Original) <> SubStrCount('&', FTranslateFile.Items[i].Translation)) then
    begin
      lvTranslateStrings.Selected := lvTranslateStrings.Items[i];
      if lvTranslateStrings.Selected <> nil then
        lvTranslateStrings.Selected.MakeVisible(false);
      Exit;
    end;
    Inc(i);
  end;
end;

procedure TfrmMain.acHomeExecute(Sender: TObject);
begin
  MoveListViewSelection(0);
end;

procedure TfrmMain.acEndExecute(Sender: TObject);
begin
  MoveListViewSelection(lvTranslateStrings.Items.Count - 1);
end;

procedure TfrmMain.acPageUpExecute(Sender: TObject);
begin
  if lvTranslateStrings.Selected = nil then
    MoveListViewSelection(0)
  else
    MoveListViewSelection(lvTranslateStrings.Selected.Index - lvTranslateStrings.VisibleRowCount + 1);
end;

procedure TfrmMain.acPageDownExecute(Sender: TObject);
begin
  if lvTranslateStrings.Selected = nil then
    MoveListViewSelection(lvTranslateStrings.Items.Count - 1)
  else
    MoveListViewSelection(lvTranslateStrings.Selected.Index + lvTranslateStrings.VisibleRowCount - 1);
end;

procedure TfrmMain.GotoBookmarkExecute(Sender: TObject);
begin
  with Sender as TAction do
    GotoBookmark(Tag);
end;

procedure TfrmMain.ToggleBookmarkExecute(Sender: TObject);
begin
  if lvTranslateStrings.Selected <> nil then
    ToggleBookmark((Sender as TAction).Tag, lvTranslateStrings.Selected.Index);
end;

procedure TfrmMain.acClearAllTranslationsExecute(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to FTranslateFile.Items.Count - 1 do
  begin
    FTranslateFile.Items[i].Translation := '';
    FTranslateFile.Items[i].Translated := false;
  end;
  Modified := true;
  lvTranslateStrings.Refresh;
end;

procedure TfrmMain.acReplaceEverywhereExecute(Sender: TObject);
var
  FOrig, FTrans: WideString;
  i: integer;
begin
  SaveEditChanges;
  with lvTranslateStrings.Selected do
  begin
    FOrig := FTranslateFile.Items[Index].Original;
    FTrans := FTranslateFile.Items[Index].Translation;
  end;
  for i := 0 to FTranslateFile.Items.Count - 1 do
  begin
    if WideSameText(FOrig, FTranslateFile.Items[i].Original) then
    begin
      FTranslateFile.Items[i].Translation := FTrans;
      FTranslateFile.Items[i].Translated := FTrans <> '';
      Modified := true;
    end;
  end;
  lvTranslateStrings.Refresh;
end;

procedure TfrmMain.acNextSuspiciousExecute(Sender: TObject);
const
  cWideSpace = WideChar(#32);

var
  i: integer;
  FLoop: boolean;
  MisMatchList: TTntStringlist;

  function LeadingSpaces(const S: WideString): integer;
  var
    j: integer;
  begin
    Result := 0;
    if not GlobalAppOptions.MisMatchLeadingSpaces then
      Exit;
    for j := 1 to Length(S) do // is this loop really correct? does it skip trailbytes?
      if S[j] = cWideSpace then
        Inc(Result)
      else
        Exit;
  end;

  function TrailingSpaces(const S: WideString): integer;
  var
    j: integer;
  begin
    Result := 0;
    if not GlobalAppOptions.MisMatchTrailingSpaces then
      Exit;
    for j := Length(S) downto 1 do // is this loop really correct? does it skip trailbytes?
      if S[j] = cWideSpace then
        Inc(Result)
      else
        Exit;
  end;

  function EndControl(const S: WideString): WideString;
  var
    W: WideChar;
    i: integer;
  begin
    Result := '';
    for i := Length(S) downto 1 do // is this loop really correct? does it skip trailbytes?
    begin
      W := TntWideLastChar(S[i]);
      if IsCharPunct(W) then
        Result := W + Result
      else
        break;
    end;
  end;

  function IsSameEndControl(const Original, Translation: string): boolean;
  begin
    Result := not GlobalAppOptions.MisMatchEndControl or WideSameStr(EndControl(Original), EndControl(Translation));
  end;

  function CountMisMatch(const Original, Translation: WideString): boolean;
  var
    i: Integer;
  begin
    Result := MisMatchList.Count > 0;
    for i := 0 to MisMatchList.Count - 1 do
      if SubStrCount(MisMatchList[i], Original) <> SubStrCount(MisMatchList[i], Translation) then
        Exit;
    Result := false;
  end;

  function IsSame(const Original, Translation: WideString): boolean;
  begin
    Result := GlobalAppOptions.MisMatchIdentical and WideSameStr(Original, Translation);
  end;

  function IsUntranslated(Value: boolean): boolean;
  begin
    Result := GlobalAppOptions.MisMatchEmptyTranslation and not Value;
  end;
begin
  // this action finds any translation that doesn't match the original in the following manner:
  // * terminating character mismatch if the character is any combination of one or more punctutation markers
  // * leading and/or trailing space count mismatch
  // * original and translation is the same (this doesn't have to be an error, but it is "suspicious")
  // * translation is empty (same as acNextUntranslated)
  // * if any of the items in the "MisMatch" list doesn't match between Original and Translation
  MisMatchList := TTntStringlist.Create;
  try
    MisMatchList.CommaText := GLobalAppOptions.MisMatchItems;
    SaveEditChanges;
    if lvTranslateStrings.Selected <> nil then
      i := lvTranslateStrings.Selected.Index
    else
      i := -1;
    if i = lvTranslateStrings.Items.Count - 1 then
      i := -1;
    Inc(i);
    FLoop := false;
    while i < FTranslateFile.Items.Count do
    begin
      with FTranslateFile.Items[i] do
      begin
        if IsSame(Original, Translation) then
          Break;
        if IsUntranslated(Translated) then
          Break
        else if Translation <> '' then
        begin
          if (LeadingSpaces(Original) <> LeadingSpaces(Translation))
            or (TrailingSpaces(Original) <> TrailingSpaces(Translation))
            or not IsSameEndControl(Original, Translation)
            or CountMismatch(Original, Translation) then
            Break;
        end;
        Inc(i);
        if i = FTranslateFile.Items.Count - 1 then
        begin
          if FLoop then // already looped once, so break out
          begin
            i := -1; // don't change selection
            Break;
          end;
          i := 0;
          FLoop := true;
        end;
      end;
    end;
    if (i >= 0) and (i < FTranslateFile.Items.Count) then
      lvTranslateStrings.Selected := lvTranslateStrings.Items[i];
    if lvTranslateStrings.Selected <> nil then
      lvTranslateStrings.Selected.MakeVisible(true);
  finally
    MisMatchList.Free;
  end;
end;

procedure TfrmMain.acViewOrphansExecute(Sender: TObject);
begin
  TfrmOrphans.Edit(FTranslateFile.Orphans);
end;

procedure TfrmMain.acConfigureKeyboardExecute(Sender: TObject);
begin
  TfrmConfigKbd.EditShortCuts(alMain);
end;

procedure TfrmMain.acImportExecute(Sender: TObject);
begin
  WaitCursor;
  SaveEditChanges;
  //  (FTranslateFile.Items as ITranslationItems)._AddRef;
  if not CheckModified then
    Exit;
  lvTranslateStrings.Selected := nil;
  ScrollToTop;
  lvTranslateStrings.Items.Count := 0;
  reOriginal.Clear;
  reTranslation.Clear;
  if TfrmImportExport.Edit(FTranslateFile.Items, FTranslateFile.Orphans,
    ExtractFilePath(Application.ExeName) + 'plugins', true, FImportIndex, FCapabilitesSupported) then
  begin
    // make sure the "Save As" dialog is shown on Ctrl+S to prevent inadverent saving to wrong file
    StopMonitor(FFileMonitors[cOrigMonitor]);
    StopMonitor(FFileMonitors[cTransMonitor]);
    //    StopMonitor(FFileMonitors[cDictMonitor]);
    GlobalAppOptions.TranslationFile := '';
    GlobalAppOptions.OriginalFIle := '';
    acRestoreSort.Execute;
    Modified := true;
  end;
  lvTranslateStrings.Items.Count := FTranslateFile.Items.Count;
  ScrollToTop;
  lvTranslateStrings.Invalidate;
  UpdateStatus;
end;

procedure TfrmMain.acExportExecute(Sender: TObject);
var
  Dummy: integer;
begin
  //  (FTranslateFile.Items as ITranslationItems)._AddRef;
  WaitCursor;
  TfrmImportExport.Edit(FTranslateFile.Items, FTranslateFile.Orphans, ExtractFilePath(Application.ExeName) + 'plugins',
    false, FImportIndex, Dummy);
  lvTranslateStrings.Items.Count := FTranslateFile.Items.Count;
end;

procedure TfrmMain.acToggleTranslatedExecute(Sender: TObject);
begin
  with lvTranslateStrings.Selected do
    FTranslateFile.Items[Index].Translated := not FTranslateFile.Items[Index].Translated
end;

procedure TfrmMain.DoCommentModified(Sender: TObject;
  const AText: WideString);

  function MakeComment(const S: WideString): WideString;
  var
    CChar: WideChar;
  begin
    CChar := FTranslateFile.CommentChar;
    Result := CChar + Tnt_WideStringReplace(trim(S), SLineBreak, SLineBreak + CChar, [rfReplaceAll]);
    while (Length(Result) > 0) and (Result[Length(Result)] = CChar) do
      SetLength(Result, Length(Result) - 1);
  end;
begin
  if lvTranslateStrings.Selected <> nil then
    with lvTranslateStrings.Selected do
      FTranslateFile.Items[Index].TransComments := MakeComment(AText);
end;

procedure TfrmMain.UpdateColumn(Index: integer; const AFileName: string);
begin
  case Index of
    0:
      if AFileName <> '' then
        lvTranslateStrings.Columns[0].Caption := WideFormat(Translate(ClassName, SOriginalColumn),
          [GetMinimizedFilename(AFileName, not GlobalAppOptions.ShowFullNameInColumns)])
      else
        lvTranslateStrings.Columns[0].Caption := Translate(ClassName, SOriginal);
    1:
      if AFileName <> '' then
        lvTranslateStrings.Columns[1].Caption := WideFormat(Translate(ClassName, STranslationColumn),
          [GetMinimizedFilename(AFileName, not GlobalAppOptions.ShowFullNameInColumns)])
      else
        lvTranslateStrings.Columns[1].Caption := Translate(ClassName, STranslation);
  end;
end;

procedure TfrmMain.acTestExceptionHandlerExecute(Sender: TObject);
begin
  raise Exception.Create(
    '01. This is just a test for the exception handler. Please ignore.'#10 +
    '02. This is just a test for the exception handler. Please ignore.'#10 +
    '03. This is just a test for the exception handler. Please ignore.'#10 +
    '04. This is just a test for the exception handler. Please ignore.'#10 +
    '05. This is just a test for the exception handler. Please ignore.'#10 +
    '06. This is just a test for the exception handler. Please ignore.'#10 +
    '07. This is just a test for the exception handler. Please ignore.'#10 +
    '08. This is just a test for the exception handler. Please ignore.'#10 +
    '09. This is just a test for the exception handler. Please ignore.'#10 +
    '10. This is just a test for the exception handler. Please ignore.'#10 +
    '11. This is just a test for the exception handler. Please ignore.'#10 +
    '12. This is just a test for the exception handler. Please ignore.'#10 +
    '13. This is just a test for the exception handler. Please ignore.'#10 +
    '14. This is just a test for the exception handler. Please ignore.'#10 +
    '15. This is just a test for the exception handler. Please ignore.'#10 +
    '16. This is just a test for the exception handler. Please ignore.'#10 +
    '17. This is just a test for the exception handler. Please ignore.'#10 +
    '18. This is just a test for the exception handler. Please ignore.'#10 +
    '19. This is just a test for the exception handler. Please ignore.'#10 +
    '20. This is just a test for the exception handler. Please ignore.'#10 +
    '21. This is just a test for the exception handler. Please ignore.'#10 +
    '22. This is just a test for the exception handler. Please ignore.'#10 +
    '23. This is just a test for the exception handler. Please ignore.'#10 +
    '24. This is just a test for the exception handler. Please ignore.'#10 +
    '25. This is just a test for the exception handler. Please ignore.'#10 +
    '26. This is just a test for the exception handler. Please ignore.'#10 +
    '27. This is just a test for the exception handler. Please ignore.'#10 +
    '28. This is just a test for the exception handler. Please ignore.'#10 +
    '29. This is just a test for the exception handler. Please ignore.'#10 +
    '30. This is just a test for the exception handler. Please ignore.'#10
    );
end;

procedure TfrmMain.acFullScreenExecute(Sender: TObject);
var
  P: TWindowPlacement;
begin
  acFullScreen.Checked := not acFullScreen.Checked;
  FillChar(P, sizeof(P), 0);
  P.length := sizeof(P);
  // get default and current values
  GetWindowPlacement(Handle, @P);
  // adjust UI
  if acFullScreen.Checked then
  begin
    StatusBar1.Visible := false;
    tbTools.Tag := Ord(tbTools.Visible);
    tbTools.Visible := false;
    BorderStyle := bsNone;
    P.showCmd := SW_SHOWMAXIMIZED;
  end
  else
  begin
    StatusBar1.Visible := true;
    tbTools.Visible := tbTools.Visible or (tbTools.Tag = 1);
    BorderStyle := bsSizeable;
    P.showCmd := SW_RESTORE;
  end;
  // set new size/position
  SetWindowPlacement(Handle, @P);
end;

procedure TfrmMain.DoTranslateSuggestionClick(Sender: TObject);
begin
  reTranslation.SelText := (Sender as TTBXItem).Caption;
end;

procedure TfrmMain.popEditPopup(Sender: TObject);
var
  R: TCustomEdit;
  M: TTBXItem;
  i, j: integer;
  S: string;
begin
  smiDictionary.Clear;
  if popEdit.PopupComponent is TCustomEdit then
    R := TCustomEdit(popEdit.PopupComponent)
  else
    R := nil;
  i := -1;
  if Assigned(R) and (FDict.Count > 0) then
  begin
    if R.SelLength = 0 then
      S := R.Text
    else
      S := R.SelText;
    i := FDict.IndexOf(trim(S));
    if i >= 0 then
      for j := 0 to FDict[i].Translations.Count - 1 do
      begin
        M := TTBXItem.Create(popEdit);
        M.Caption := FDict[i].Translations[j];
        M.OnClick := DoTranslateSuggestionClick;
        smiDictionary.Add(M);
      end;
  end;
  if i < 0 then
  begin
    M := TTBXItem.Create(popEdit);
    M.Caption := SNoCategory;
    smiDictionary.Add(M);
  end;
end;

{$IFDEF USEADDICTSPELLCHECKER}

procedure TfrmMain.SpellCheckExecute(Sender: TObject);
var
  i, j: integer;
begin
  CreateSpellChecker;
  adSpellChecker.StartSequenceCheck;
  try
    if lvTranslateStrings.Selected <> nil then
      j := lvTranslateStrings.Selected.Index
    else
      j := 0;
    for i := j to lvTranslateStrings.Items.Count - 1 do
    begin
      // this copies the content of the listview item to the richedit control (reTranslation)
      lvTranslateStrings.Selected := lvTranslateStrings.Items[i];
      lvTranslateStrings.Selected.MakeVisible(false);
      // the OnCompleteCheck event is hooked up to save any changes to the richedit back to the listview
      adSpellChecker.CheckWinControl(reTranslation, ctAll);
      if adSpellChecker.CheckCanceled then
        Exit;
      // here I would like to check if the dialog was closed (Cancel clicked) so I can break out of the loop
    end;
    if j <> 0 then
      for i := 0 to j do
      begin
        // this copies the content of the listview item to the richedit control (reTranslation)
        lvTranslateStrings.Selected := lvTranslateStrings.Items[i];
        lvTranslateStrings.Selected.MakeVisible(false);
        // the OnCompleteCheck event is hooked up to save any changes to the richedit back to the listview
        adSpellChecker.CheckWinControl(reTranslation, ctAll);
        // here I would like to check if the dialog was closed (Cancel clicked) so I can break out of the loop
        if adSpellChecker.CheckCanceled then
          Exit;
      end;
  finally
    adSpellChecker.StopSequenceCheck;
    FreeAndNil(adSpellChecker);
  end;
end;

procedure TfrmMain.SpellCheckComplete(Sender: TObject);
begin
  reTranslationExit(reTranslation);
end;

procedure WriteToFile(const Name, Value: string);
begin
  with TWideMemIniFile.Create(ChangeFileExt(Application.ExeName, '.spl')) do
  try
    WriteString('SpellChecker', Name, Value);
    UpdateFile;
  finally
    Free;
  end;
end;

procedure TfrmMain.SpellCheckGetString(Sender: TObject; LanguageString: TSpellLanguageString; var Text: string);
var
  AText: string;
begin
  AText := Text;
  Text := GlobalLanguageFile.Translate('SpellChecker', Text, Text);
{$IFDEF TRANSLATOR_DEBUG}
  WriteToFile(AText, Text);
{$ENDIF}
end;

procedure TfrmMain.CreateSpellChecker;
begin
  if adSpellChecker <> nil then
    Exit;
  adSpellChecker := TAddictSpell3.Create(Self);
  with adSpellChecker do
  begin
    ConfigStorage := csFile;
    ConfigID := '%UserName%';
    ConfigFilename := '%AppDir%\dictionaries\Spell.cfg';
//    ConfigRegistryKey := 'Software\Addictive Software\%AppName%';
    ConfigDictionaryDir.Add('%AppDir%\dictionaries');
    ConfigAvailableOptions := [soUpcase, soNumbers, soInternet, soPrimaryOnly, soRepeated, soDUalCaps];
    ConfigUseMSWordCustom := True;
    ConfigDefaultMain.Add('%AppDir%\dictionaries\American.adm');
    ConfigDefaultActiveCustom := '%AppDir%\dictionaries\%ConfigID%.adu';
    ConfigDefaultOptions := [soInternet, soAbbreviations, soRepeated, soDUalCaps];
    ConfigDefaultUseMSWordCustom := False;
    SuggestionsAutoReplace := False;
    SuggestionsLearning := True;
    SuggestionsLearningDict := '%AppDir%\dictionaries\%UserName%_sp.adl';
    QuoteChars := '>';
    DialogInitialPos := ipLastUserPos;
    DialogSelectionAvoid := saAvoid;
    DialogShowImmediate := False;
    DialogShowModal := False;
    EndMessage := emExceptCancel;
    EndCursorPosition := epOriginal;
    EndMessageWordCount := False;
    MaxUndo := -1;
    MaxSuggestions := -1;
    KeepDictionariesActive := False;
    SynchronousCheck := True;
    UseHourglassCursor := True;
    CommandsVisible := [sdcIgnore, sdcIgnoreAll, sdcChange, sdcChangeAll, sdcAdd, sdcHelp, sdcCancel, sdcOptions, sdcCustomDictionary, sdcCustomDictionaries, sdcConfigOK, sdcAddedEdit, sdcAutoCorrectEdit, sdcExcludedEdit, sdcInternalEdit, sdcMainDictFolderBrowse, sdcResetDefaults];
    CommandsEnabled := [sdcIgnore, sdcIgnoreAll, sdcChange, sdcChangeAll, sdcAdd, sdcHelp, sdcCancel, sdcOptions, sdcCustomDictionary, sdcCustomDictionaries, sdcConfigOK, sdcAddedEdit, sdcAutoCorrectEdit, sdcExcludedEdit, sdcInternalEdit, sdcMainDictFolderBrowse, sdcResetDefaults];
    PhoneticSuggestions := True;
    PhoneticMaxDistance := 4;
    PhoneticDivisor := 2;
    PhoneticDepth := 2;
    MappingAutoReplace := True;
    UseExcludeWords := True;
    UseAutoCorrectFirst := False;
    RecheckReplacedWords := True;
    ResumeFromLastPosition := False;
    AllowedCases := cmInitialCapsOrUpcase;
    UILanguage := ltEnglish;
    UIType := suiDialog;
    UILanguageFontControls := Self.Font;
    UILanguageFontText := Self.Font;
    UILanguageUseFonts := True;
    OnCompleteCheck := reTranslationExit;
    OnSpellDialogHide := SpellCheckComplete;
    OnGetString := SpellCheckGetString;
    OnWordCheck := SpellCheckWordCheck; // check ampersand characters separately
    TMainParsingEngine(ParsingEngine).ForbidMidWord := ''; // don't skip &'s
  end;
end;

procedure TfrmMain.SpellCheckWordCheck(Sender: TObject; const Word: string; var CheckType: TWordCheckType; var Replacement: string);
begin
  if (CheckType = wcDenied) then
  begin
    Replacement := StripHotkey(Word);
    if not AnsiSameText(Word, Replacement) and adSpellChecker.WordAcceptable(Replacement) then
      CheckType := wcAccepted;
  end;
end;

{$ENDIF USEADDICTSPELLCHECKER}

procedure TfrmMain.acToolsCustomizeExecute(Sender: TObject);
begin
  // DONE: add test click event
  TfrmTools.Edit(GlobalAppOptions, alMain, DoTestToolClick);
end;

procedure TfrmMain.BuildToolMenu(Parent: TTBCustomItem);
var
  P: TTBXSubmenuItem;
  M: TTBXItem;
  i: integer;
begin
  P := Parent as TTBXSubmenuItem;
  while P.Count > 1 do
    P.Delete(P.Count - 1); //remove previous menu items
  if GlobalAppOptions.Tools.Count > 0 then
  begin
    P.Add(TTBXSeparatorItem.Create(Parent)); // add a separator
    for i := 0 to GlobalAppOptions.Tools.Count - 1 do
    begin
      if GlobalAppOptions.Tools[i].Title = '-' then
        P.Add(TTBXSeparatorItem.Create(Parent))
      else
      begin
        M := TTBXItem.Create(P);
        M.Caption := GlobalAppOptions.Tools[i].Title;
        M.Tag := integer(GlobalAppOptions.Tools[i]);
        M.ShortCut := GlobalAppOptions.Tools[i].ShortCut;
        M.OnClick := DoToolMenuClick;
        P.Add(M);
      end;
    end;
  end;
end;

procedure TfrmMain.DoExternalToolClick(Sender: TObject);
var
  T: TExternalToolItem;
  i: integer;
begin
  i := lvTranslateStrings.ItemIndex;
  lvTranslateStrings.Items.BeginUpdate;
  try
    T := TExternalToolItem((Sender as TTBCustomItem).Tag);
    T.Execute(FTranslateFile.Items, FTranslateFile.Orphans);
    lvTranslateStrings.Items.Count := FTranslateFile.Items.Count;
    lvTranslateStrings.Invalidate;
  finally
    lvTranslateStrings.Items.EndUpdate;
    lvTranslateStrings.ItemIndex := i;
  end;

  if lvTranslateStrings.Selected <> nil then
  begin
    lvTranslateStrings.Selected.Focused := true;
    lvTranslateStrings.Selected.MakeVisible(false);
  end;
end;

procedure TfrmMain.BuildExternalToolMenu(Parent: TTBCustomItem);
var
  M: TTBXItem;
  i: integer;
  E: TExternalToolItem;
begin
  FExternalToolItems := TExternalToolItems.Create(ExtractFilePath(Application.ExeName) + 'plugins');
  Parent.Clear;
  for i := 0 to FExternalToolItems.Count - 1 do
  begin
    E := FExternalToolItems[i];
    M := TTBXItem.Create(Parent);
    M.Caption := Translate(ClassName, E.DisplayName);
    M.OnClick := DoExternalToolClick;
    M.Images := FExternalToolItems.Images;
    M.ImageIndex := E.ImageIndex;

    M.Tag := Integer(E);
    Parent.Add(M);
  end;
  Parent.Visible := Parent.Count > 0;
  FExternalToolItems.InitAll(Application.Handle);
end;

procedure TfrmMain.mnuPluginsPopup(Sender: TTBCustomItem; FromLink: Boolean);
var
  i, AStatus, aVisibleCount: integer;
begin
  aVisibleCount := 0;
  for i := 0 to mnuPlugins.Count - 1 do
  begin
    with TExternalToolItem(mnuPlugins[i].Tag) do
      AStatus := Status(FTranslateFile.Items, FTranslateFile.Orphans);
    mnuPlugins[i].Enabled := AStatus and TOOL_ENABLED = TOOL_ENABLED;
    mnuPlugins[i].Checked := AStatus and TOOL_CHECKED = TOOL_CHECKED;
    mnuPlugins[i].Visible := AStatus and TOOL_VISIBLE = TOOL_VISIBLE;
    if mnuPlugins[i].Visible then
      Inc(aVisibleCount);
  end;
  mnuPlugins.Visible := aVisibleCount > 0;
end;

function TfrmMain.MacroReplace(const AMacros: WideString): WideString;
var
  S, tmp: WideString;
begin
  Result := AMacros;

  Result := Tnt_WideStringReplace(Result, '$(OrigLine)', reOriginal.Text, [rfReplaceAll, rfIgnoreCase]);
  if reOriginal.SelLength = 0 then
    S := reOriginal.Text
  else
    S := reOriginal.SelText;
  tmp := GlobalAppOptions.OriginalFile;
  Result := Tnt_WideStringReplace(Result, '$(OrigText)', S, [rfReplaceAll, rfIgnoreCase]);
  Result := Tnt_WideStringReplace(Result, '$(OrigPath)', tmp, [rfReplaceAll, rfIgnoreCase]);
  Result := Tnt_WideStringReplace(Result, '$(OrigDir)', tmp, [rfReplaceAll, rfIgnoreCase]);
  Result := Tnt_WideStringReplace(Result, '$(OrigName)', ChangeFileExt(ExtractFilename(tmp), ''), [rfReplaceAll, rfIgnoreCase]);
  Result := Tnt_WideStringReplace(Result, '$(OrigExt)', ExtractFileExt(tmp), [rfReplaceAll, rfIgnoreCase]);

  Result := Tnt_WideStringReplace(Result, '$(TransLine)', reTranslation.Text, [rfReplaceAll, rfIgnoreCase]);
  if reTranslation.SelLength = 0 then
    S := reTranslation.Text
  else
    S := reTranslation.SelText;
  tmp := GlobalAppOptions.TranslationFile;
  Result := Tnt_WideStringReplace(Result, '$(TransText)', S, [rfReplaceAll, rfIgnoreCase]);
  Result := Tnt_WideStringReplace(Result, '$(TransPath)', tmp, [rfReplaceAll, rfIgnoreCase]);
  Result := Tnt_WideStringReplace(Result, '$(TransDir)', ExtractFilePath(tmp), [rfReplaceAll, rfIgnoreCase]);
  Result := Tnt_WideStringReplace(Result, '$(TransName)', ChangeFileExt(ExtractFilename(tmp), ''), [rfReplaceAll, rfIgnoreCase]);
  Result := Tnt_WideStringReplace(Result, '$(TransExt)', ExtractFileExt(tmp), [rfReplaceAll, rfIgnoreCase]);

  tmp := GlobalAppOptions.DictionaryFile;
  Result := Tnt_WideStringReplace(Result, '$(DictPath)', tmp, [rfReplaceAll, rfIgnoreCase]);
  Result := Tnt_WideStringReplace(Result, '$(DictDir)', ExtractFilePath(tmp), [rfReplaceAll, rfIgnoreCase]);
  Result := Tnt_WideStringReplace(Result, '$(DictName)', ChangeFileExt(ExtractFilename(tmp), ''), [rfReplaceAll, rfIgnoreCase]);
  Result := Tnt_WideStringReplace(Result, '$(DictExt)', ExtractFileExt(tmp), [rfReplaceAll, rfIgnoreCase]);

  Result := Tnt_WideStringReplace(Result, '$(AppDir)', ExtractFilePath(Application.ExeName), [rfReplaceAll, rfIgnoreCase]);
  Result := Tnt_WideStringReplace(Result, '$(WinDir)', WinDir, [rfReplaceAll, rfIgnoreCase]);
  Result := Tnt_WideStringReplace(Result, '$(SysDir)', SysDir, [rfReplaceAll, rfIgnoreCase]);
end;

procedure TfrmMain.DoMacroReplace(Sender: TObject; var Args: WideString);
begin
  Args := MacroReplace(Args);
end;

function TfrmMain.QueryArgs(const Title, CmdLine: WideString; var Args: WideString): boolean;
begin
  Result := TfrmPromptArgs.Edit(Title, CmdLine, Args, DoMacroReplace);
end;

procedure TfrmMain.ExecuteTool(ATool: TToolItem);
var
  Cmd, Args, Dir: WideString;
  ReturnValue: Cardinal;
  FOutput: TStringlist;
begin
  Cmd := MacroReplace(ATool.Command);
  if ATool.PromptForArguments then
  begin
    Args := ATool.Arguments;
    if not QueryArgs(StripHotkey(ATool.Title), Cmd, Args) then
      Exit;
    Args := MacroReplace(Args);
  end
  else
    Args := MacroReplace(ATool.Arguments);
  Dir := trim(MacroReplace(ATool.InitialDirectory));

  if ATool.UseShellExecute then
  begin

    ReturnValue := Tnt_ShellExecuteW(Handle, nil, PWideChar(Cmd), PWideChar(Args), PWideChar(Dir), SW_SHOWNORMAL);
    if ReturnValue <= 32 then
      ReturnValue := GetLastError
    else
      ReturnValue := 0;
  end
  else
  begin
    FOutput := TStringlist.Create;
    try
      if RunProcess(trim(Cmd), trim(Args), trim(Dir), ATool.WaitForCompletion,
        ATool.WaitForCompletion, SW_SHOWNORMAL, ReturnValue) then
        ReturnValue := 0;
    finally
      FOutput.Free;
    end;
  end;

  if (ReturnValue <> 0) and (ATool.WaitForCompletion or ATool.UseShellExecute) then
    ErrMsg(WideFormat(Translate(ClassName, SErrToolExecFmt), [Cmd, Args, SysErrorMessage(ReturnValue)]), StripHotkey(ATool.Title));
end;

procedure TfrmMain.DoToolMenuClick(Sender: TObject);
begin
  ExecuteTool(TToolItem(TTBXITem(Sender).Tag));
end;

procedure TfrmMain.DoTestToolClick(Sender: TObject; Tool: TToolItem);
begin
  ExecuteTool(Tool);
end;

procedure TfrmMain.TBXSubmenuItem1Select(Sender: TTBCustomItem;
  Viewer: TTBItemViewer; Selecting: Boolean);
begin
  if Selecting then
    BuildToolMenu(Sender);
end;

procedure TfrmMain.GetSections(Strings: TTntStringlist);
var
  i: integer;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    Strings.Sorted := true;
    for i := 0 to FTranslateFile.Items.Count - 1 do
      Strings.Add(FTranslateFile.Items[i].Section);
  finally
    Strings.EndUpdate;
  end;

end;

procedure TfrmMain.AddItem(AItem: ITranslationItem);
var
  AIndex, i: integer;
  FOldSort: TTranslateSortType;
begin
  FOldSort := FTranslateFile.Items.Sort;
  try
    FTranslateFile.Items.Sort := stIndex;
    AIndex := FTranslateFile.Items.Add(AItem);
    i := 0;
    while i <= AIndex do
    begin
    // find first item with same section name
      if WideSameText(FTranslateFile.Items[i].Section, AItem.Section) then
      begin
        while i <= AIndex do
        begin
                // find first item with another section name
          if not WideSameText(FTranslateFile.Items[i].Section, AItem.Section) then
          begin
                  // insert our new item into the list
            FTranslateFile.Items[AIndex].Index := i;
                  // increment index of all subsequent items
            while i < AIndex do
            begin
              FTranslateFile.Items[i].Index := FTranslateFile.Items[i].Index + 1;
              Inc(i);
            end;
          end;
          Inc(i);
        end;
      end;
      Inc(i);
    end;
  finally
    FTranslateFile.Items.Sort := FOldSort;
  end;
end;

procedure TfrmMain.AddItem(const Section, Original, Translation, OrigComments, TransComments: WideString);
var AItem: ITranslationItem;
begin
  AItem := FTranslateFile.Items.CreateItem;
  AItem.Section := Section;
  AItem.Original := Original;
  AItem.Translation := Translation;
  AItem.OrigComments := OrigComments;
  AItem.TransComments := TransComments;
  AddItem(AItem);
end;

procedure TfrmMain.DeleteItem(Index: integer);
begin
  if (Index >= 0) and (Index < FTranslateFile.Items.Count) then
    FTranslateFile.Items.Delete(Index);
end;

procedure TfrmMain.acAddItemExecute(Sender: TObject);
var
  AItem: ITranslationItem;
  ASections: TTntStringlist;
begin
  AItem := FTranslateFile.Items.CreateItem;
  with lvTranslateStrings do
    if ItemIndex > -1 then
      AItem.Section := FTranslateFile.Items[ItemIndex].Section;
  ASections := TTntStringlist.Create;
  try
    GetSections(ASections);
    if TfrmEditItem.Edit(Translate(ClassName, SCaptionAddItem), ASections, AItem, true) then
    begin
      if (AItem.Section = '') then
        ErrMsg(Translate(ClassName, SErrSectionEmpty), SErrorCaption)
      else if (AItem.Name = '') then
        ErrMsg(Translate(ClassName, SErrNameEmpty), SErrorCaption)
      else if (AItem.Original = '') then
        ErrMsg(Translate(ClassName, SErrOrigTextEmpty), SErrorCaption)
      else if (FTranslateFile.Items.IndexOf(AItem.Section, AItem.Name, false) > -1) then
        ErrMsg(Translate(ClassName, SErrSectionNameExists), SErrorCaption)
      else
      begin
        lvTranslateStrings.Items.BeginUpdate;
        try
          // insert the new item at the correct location
          AddItem(AItem);
          Modified := true;
          lvTranslateStrings.Items.Count := FTranslateFile.Items.Count;
          UpdateStatus;
        finally
          lvTranslateStrings.Items.EndUpdate;
        end;
        // scroll it into view
        lvTranslateStrings.ItemIndex := FTranslateFile.Items.IndexOf(AItem.Section, AItem.Name);
        if lvTranslateStrings.Selected <> nil then
          lvTranslateStrings.Selected.MakeVisible(true);
      end;
    end;
  finally
    ASections.Free;
  end;
end;

procedure TfrmMain.acEditItemExecute(Sender: TObject);
var
  Index: integer;
  AItem, ANewItem: ITranslationItem;
  ASections: TTntStringlist;

  procedure CopyItem(const FromItem, ToItem: ITranslationItem);
  begin
    ToItem.Index := FromItem.Index;
    ToItem.Translated := FromItem.Translated;
    ToItem.TransComments := FromItem.TransComments;
    ToItem.OrigComments := FromItem.OrigComments;
    ToItem.Original := FromItem.Original;
    ToItem.Translation := FromItem.Translation;
    ToItem.Section := FromItem.Section;
    ToItem.Name := FromItem.Name;
    ToItem.ClearOriginal := FromItem.ClearOriginal;
    ToItem.ClearTranslation := FromItem.ClearTranslation;
    ToItem.PrivateStorage := FromItem.PrivateStorage;
  end;

  function EqualItems(const FromItem, ToItem: ITranslationItem): boolean;
  begin
    Result :=
      WideSameStr(FromItem.Section, ToItem.Section)
      and WideSameStr(FromItem.Original, ToItem.Original)
      and WideSameStr(FromItem.Translation, ToItem.Translation)
      and WideSameStr(FromItem.OrigComments, ToItem.OrigComments)
      and WideSameStr(FromItem.TransComments, ToItem.TransComments);
  end;
begin
  ANewItem := FTranslateFile.Items.CreateItem;
  Index := lvTranslateStrings.Selected.Index;
  AItem := FTranslateFile.Items[Index];
  ASections := TTntStringlist.Create;
  try
    GetSections(ASections);
    CopyItem(AItem, ANewItem);
    if TfrmEditItem.Edit(Translate(ClassName, SCaptionEditItem), ASections, ANewItem, false) then
    begin
      if EqualItems(AItem, ANewItem) then
        Exit;
      lvTranslateStrings.Items.BeginUpdate;
      try
        if (ANewItem.Section = '') then
          ErrMsg(Translate(ClassName, SErrSectionEmpty), SErrorCaption)
        else if (ANewItem.Name = '') then
          ErrMsg(Translate(ClassName, SErrNameEmpty), SErrorCaption)
        else if (ANewItem.Original = '') then
          ErrMsg(Translate(ClassName, SErrOrigTextEmpty), SErrorCaption)
        else
        begin
          lvTranslateStrings.ItemIndex := -1;
          CopyItem(ANewItem, AItem);
          Modified := true;
          lvTranslateStrings.ItemIndex := Index;
          if lvTranslateStrings.Selected <> nil then
            lvTranslateStrings.Selected.MakeVisible(true);
          UpdateStatus;
        end;
      finally
        lvTranslateStrings.Items.EndUpdate;
      end;
    end;
  finally
    ASections.Free;
  end;
end;

procedure TfrmMain.acDeleteItemExecute(Sender: TObject);
var i: integer;
begin
  if (lvTranslateStrings.Selected <> nil) and YesNo(Translate(ClassName, SPromptDeleteItem), Translate(ClassName, SConfirmDelete)) then
  begin
    i := lvTranslateStrings.Selected.Index;
    DeleteItem(lvTranslateStrings.Selected.Index);
    lvTranslateStrings.Items.Count := FTranslateFile.Items.Count;
    if i >= FTranslateFile.Items.Count then
      i := FTranslateFile.Items.Count - 1
    else if i < 0 then
      i := 0;
    lvTranslateStrings.ItemIndex := i;
    if lvTranslateStrings.ItemIndex = -1 then
      lvTranslateStrings.ItemIndex := 0;
    if lvTranslateStrings.Selected <> nil then
      lvTranslateStrings.Selected.MakeVisible(false);
    lvTranslateStrings.Invalidate;
    lvTranslateStringsChange(Sender, lvTranslateStrings.Selected, ctText);
    UpdateStatus;
  end;
end;

procedure TfrmMain.lvTranslateStringsDblClick(Sender: TObject);
begin
  acEditItem.Execute;
end;

procedure TfrmMain.DoTrim;
var
  i: integer;
  ti: ITranslationItem;
  S: WideString;

  procedure InternalTrim(var S: WideString);
  var iStart: integer;
  begin
    if GlobalAppOptions.TrimHow in [cTrimLeading, cTrimBoth] then
    begin
      iStart := 1;
      while (iStart <= Length(S)) and ((Pos(S[iStart], GlobalAppOptions.TrimWhat) > 0)
        or (GlobalAppOptions.TrimWhiteSpace and (S[iStart] < #33))) do
        Inc(iStart);
      S := Copy(S, iStart, MaxInt);
    end;
    if GlobalAppOptions.TrimHow in [cTrimTrailing, cTrimBoth] then
    begin
      iStart := Length(S);
      while (iStart >= 1) and ((Pos(S[iStart], GlobalAppOptions.TrimWhat) > 0)
        or (GlobalAppOptions.TrimWhiteSpace and (S[iStart] < #33))) do
        Dec(iStart);
      S := Copy(S, 1, iStart);
    end;

  end;
begin
  if (GlobalAppOptions.TrimWhat <> '') or GlobalAppOptions.TrimWhiteSpace then
  begin
    for i := 0 to FTranslateFile.Items.Count - 1 do
    begin
      ti := FTranslateFile.Items[i];
      if (GlobalAppOptions.TrimWhere in [cTrimOriginal, cTrimBoth]) and (ti.Original <> '') then
      begin
        S := ti.Original;
        InternalTrim(S);
        if Length(S) <> Length(ti.Original) then
        begin
          ti.Original := S;
          Modified := true;
        end;
      end;
      if (GlobalAppOptions.TrimWhere in [cTrimTranslation, cTrimBoth]) and (ti.Translation <> '') then
      begin
        S := ti.Translation;
        InternalTrim(S);
        if Length(S) <> Length(ti.Translation) then
        begin
          ti.Translation := S;
          Modified := true;
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.acTrimExecute(Sender: TObject);
begin
  if TfrmTrim.Edit(GlobalAppOptions) then
  begin
    lvTranslateStrings.Items.BeginUpdate;
    try
      DoTrim;
    finally
      lvTranslateStrings.Items.EndUpdate;
    end;
  end;
end;

procedure TfrmMain.acConfigSuspiciousExecute(Sender: TObject);
begin
  TfrmConfigSuspicious.Edit(GlobalAppOptions);
end;

procedure TfrmMain.acDictEditExecute(Sender: TObject);
begin
  TfrmDictEdit.Edit(FDict);
end;

procedure TfrmMain.cbThemesChange(Sender: TObject);
begin
  ThemeSwitcher.Theme := cbThemes.Text;
end;


end.

