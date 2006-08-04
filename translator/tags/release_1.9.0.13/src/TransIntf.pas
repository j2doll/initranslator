{@abstract(Translation interfaces. Used by plugins) }
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

// $Id$

unit TransIntf;

{$I TRANSLATOR.INC}

interface

type
  TTranslateSortType = integer;
const
  CAP_IMPORT = 1; // we can import
  CAP_EXPORT = 2; // we can export
  CAP_CONFIGURE = 4; // we have a configuration dialog
  CAP_ITEM_DELETE = 8; // we support deleting items
  CAP_ITEM_INSERT = 16; // we support adding items
  CAP_ITEM_EDIT = 32; // we support modifying the items

  stNone = 0;
  stSection = 1;
  stOriginal = 2;
  stInvertOriginal = 3;
  stTranslation = 4;
  stInvertTranslation = 5;
  stIndex = 6;
  stInvertIndex = 7;

  TOOL_ENABLED = 1;
  TOOL_CHECKED = 2;
  TOOL_VISIBLE = 4;

type
  ITranslationItems = interface;
  ITranslationItem = interface(IInterface)
    ['{5B400D54-5B0E-48B4-BEE3-9DBDA02AE3D6}']
    function GetIndex: integer;
    function GetName: WideString;
    function GetOrigComments: WideString;
    function GetOriginal: WideString;
    function GetSection: WideString;
    function GetTransComments: WideString;
    function GetTranslation: WideString;
    function GetTranslated: WordBool;
    function GetOwner: ITranslationItems;
    procedure SetTranslated(const Value: WordBool);
    procedure SetIndex(const Value: integer);
    procedure SetName(const Value: WideString);
    procedure SetOrigComments(const Value: WideString);
    procedure SetOriginal(const Value: WideString);
    procedure SetSection(const Value: WideString);
    procedure SetTransComments(const Value: WideString);
    procedure SetTranslation(const Value: WideString);
    procedure SetOwner(const Value: ITranslationItems);

    function TransQuote: WideChar;
    function OrigQuote: WideChar;

    property Index: integer read GetIndex write SetIndex;
    property Translated: WordBool read GetTranslated write SetTranslated;
    property TransComments: WideString read GetTransComments write SetTransComments;
    property OrigComments: WideString read GetOrigComments write SetOrigComments;
    property Original: WideString read GetOriginal write SetOriginal;
    property Translation: WideString read GetTranslation write SetTranslation;
    property Section: WideString read GetSection write SetSection;
    property Name: WideString read GetName write SetName;
    property Owner: ITranslationItems read GetOwner write SetOwner;
    // Works just as SetOriginal and SetTranslation in ITranslationItem, but
    // also sets OrigQuote/TransQuote to #0
    procedure SetClearOriginal(const Value: WideString);
    procedure SetClearTranslation(const Value: WideString);

    property ClearOriginal: WideString read GetOriginal write SetClearOriginal;
    property ClearTranslation: WideString read GetTranslation write SetClearTranslation;

    procedure SetModified(Value: WordBool);
    function GetModified: WordBool;
    procedure SetPrivateStorage(const Value: WideString);
    function GetPrivateStorage: WideString;
    // Some imported formats carry baggage not available in a standard translation item.
    // This property is provided so these formats can store whatever they
    // like along with each item.
    property PrivateStorage: WideString read GetPrivateStorage write SetPrivateStorage;
    property Modified: WordBool read GetModified write SetModified;
    function GetPreData:WideString;
    procedure SetPreData(const Value:WideString);
    function GetPostData:WideString;
    procedure SetPostData(const Value:WideString);
    property PreData:WideString read GetPreData write SetPreData;
    property PostData:WideString read GetPostData write SetPostData;
  end;


  ITranslationItems = interface(IInterface)
    ['{6ACD4934-9B26-4232-B11E-95FB18B60FCA}']
    function GetTranslatedCount: integer;
    procedure SetTranslatedCount(const Value: integer);
    function GetSort: TTranslateSortType;
    procedure SetSort(const Value: TTranslateSortType);
    procedure SetModified(Value: WordBool);
    function GetModified: WordBool;
    function GetItem(Index: integer): ITranslationItem;
    function GetCount: integer;

    function Add: ITranslationItem;overload;
    function Add(const Item: ITranslationItem): integer; overload;
    function CreateItem: ITranslationItem; // create an item that isn't added to the list
    procedure Delete(Index: integer);
    procedure Clear;
    function IndexOf(const Section, Name: WideString; CaseSense: WordBool = false): integer;overload;
    function IndexOf(const AItem:ITranslationItem): integer;overload;

    property Count: integer read GetCount;
    property Items[Index: integer]: ITranslationItem read GetItem; default;
    property TranslatedCount: integer read GetTranslatedCount write SetTranslatedCount;
    property Sort: TTranslateSortType read GetSort write SetSort;
    property Modified:WordBool read GetModified write SetModified;
  end;

  IFileParser = interface(IInterface)
    ['{3E556846-9B4D-4722-B48F-48D020715509}']
    function ExportItems(const Items, Orphans: ITranslationItems): HResult; safecall;
    function ImportItems(const Items, Orphans: ITranslationItems): HResult; safecall;
    function DisplayName(Capability: integer): WideString; safecall;
    // return combination of the CAP_ constants
    function Capabilities: integer; safecall;
    function Configure(Capability: integer): HResult; safecall;
    procedure Init(AppHandle: Cardinal); safecall;
  end;

  // An item that can reside on the "Plugins" menu
  // When clicked, the Execute function is called
  IToolItem = interface(IInterface)
  ['{E14F5620-0EC9-43B5-816C-1A265C3FF237}']
    function DisplayName:WideString;safecall; // what to display on the menu
    function About:WideString;safecall;
    function Status(const Items, Orphans: ITranslationItems; const SelectedItem:ITranslationItem):Integer; safecall; // TOOL_ENABLED or TOOL_CHECKED
    function Icon:LongWord; safecall; // HICON: return <= 0 for no icon

    function Execute(const Items, Orphans: ITranslationItems; var SelectedItem:ITranslationItem): HResult; safecall;
    procedure Init(AppHandle: Cardinal); safecall;
  end;

  // A list of IToolItem
  IToolItems = interface(IInterface)
  ['{05D4D3AB-366D-48A1-8913-F4EAEEE4DE2F}']
    function Count:Integer;safecall;
    // return S_OK if the index is valid
    function ToolItem(Index:Integer; out ToolItem:IToolItem):HResult;safecall;
  end;

  // not completed
  IApplication = interface(IInterface)
  ['{61FD76C9-714C-4DDF-BEB2-19A4631B444C}']
    function GetItems:ITranslationItems;
    function GetOrphans:ITranslationItems;
    function GetAppHandle:Cardinal;

    property Items:ITranslationItems read GetItems;
    property Orphans:ITranslationItems read GetOrphans;
    property AppHandle:Cardinal read GetAppHandle;

    function Changing:WordBool;safecall;
    procedure Change;safecall;
    function BeginUpdate:Integer;safecall;
    function EndUpdate:Integer;safecall;
  end;

  // return S_OK if all is fine
  TExportFunc = function(out Parser: IFileParser): HResult; stdcall;
  TExportToolItemsFunc = function(out ToolItems: IToolItems): HResult; stdcall;

const
  cRegisterTransFileParserFuncName = 'RegisterTransFileParser001';
  cRegisterTransToolItemsFuncName = 'RegisterTransToolItems001';

implementation

end.