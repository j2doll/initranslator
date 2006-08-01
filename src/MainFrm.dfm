object frmMain: TfrmMain
  Left = 379
  Top = 181
  Width = 651
  Height = 550
  Action = acAbout
  ActiveControl = reTranslation
  Caption = 'Ini Translator'
  Color = clBtnFace
  Constraints.MinHeight = 375
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClick = acAboutExecute
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TTBXStatusBar
    Left = 0
    Top = 504
    Width = 643
    Height = 19
    Panels = <
      item
        Size = 100
        Tag = 0
      end
      item
        Size = 150
        Tag = 0
      end
      item
        Size = 150
        Tag = 0
      end
      item
        Size = 150
        Tag = 0
      end
      item
        Size = 120
        Tag = 0
      end
      item
        Alignment = taRightJustify
        Control = pbTranslated
        Framed = False
        Size = 200
        StretchPriority = 1
        Tag = 0
        TextTruncation = twEndEllipsis
      end
      item
        Alignment = taRightJustify
        Framed = False
        MaxSize = 32
        Size = 32
        Tag = 0
      end>
    UseSystemFont = False
    object pbTranslated: TTntProgressBar
      Left = 0
      Top = 0
      Width = 0
      Height = 0
      Position = 50
      Smooth = True
      Step = 1
      TabOrder = 0
    end
  end
  object TopDock: TSpTBXDock
    Left = 0
    Top = 0
    Width = 643
    Height = 49
    FixAlign = True
    object tbMenu: TSpTBXToolbar
      Left = 0
      Top = 0
      Caption = 'Menu'
      ChevronHint = 'More Buttons|Click to see more buttons'
      CloseButton = False
      DblClickUndock = True
      DefaultDock = TopDock
      FullSize = True
      HideWhenInactive = False
      Images = il16
      MenuBar = True
      Options = [tboLongHintInMenuOnly, tboShowHint]
      ProcessShortCuts = True
      TabOrder = 0
      object mnuFile: TSpTBXSubmenuItem
        OnSelect = mnuFileSelect
        CaptionW = '&File'
        object OpenOriginal1: TSpTBXItem
          Action = acOpenOrig
          CaptionW = 'Open Original...'
          HintW = 'Open original and translation file'
        end
        object TBXItem13: TSpTBXItem
          Action = acSaveOriginal
          CaptionW = 'Save Original'
          HintW = 'Save current original file'
        end
        object TBXItem1: TSpTBXItem
          Action = acSaveOrigAs
          CaptionW = 'Save Original As...'
          HintW = 'Save current original file with a new filename'
        end
        object TBSeparatorItem3: TSpTBXSeparatorItem
        end
        object ClearTranslation1: TSpTBXItem
          Action = acNewTrans
          CaptionW = 'New Translation'
          HintW = 'Create new translation'
        end
        object OpenTranslation1: TSpTBXItem
          Action = acOpenTrans
          CaptionW = 'Open Translation...'
          HintW = 'Open existing translation file'
        end
        object SaveTranslation1: TSpTBXItem
          Action = acSaveTrans
          CaptionW = 'Save Translation'
          HintW = 'Save current translation file'
        end
        object SaveTranslationAs1: TSpTBXItem
          Action = acSaveTransAs
          CaptionW = 'Save Translation As...'
          HintW = 'Save current translation with a new filename'
        end
        object N1: TSpTBXSeparatorItem
        end
        object TBXItem4: TSpTBXItem
          Action = acImport
          CaptionW = 'Import...'
          HintW = 'Import from an external file or files'
        end
        object TBXItem3: TSpTBXItem
          Action = acExport
          CaptionW = 'Export...'
          HintW = 'Export to an external file or files'
        end
        object TBXSeparatorItem4: TSpTBXSeparatorItem
        end
        object SelectLanguage1: TSpTBXItem
          Action = acPreferences
          CaptionW = 'Preferences...'
          HintW = 'Display the settings dialog'
        end
        object TBSeparatorItem16: TSpTBXSeparatorItem
        end
        object miRecentlyUsed: TSpTBXSubmenuItem
          DropdownCombo = True
          CaptionW = 'Reopen'
          object TBMRUListItem1: TTBXMRUListItem
            MRUList = MRUFiles
          end
          object TBSeparatorItem15: TSpTBXSeparatorItem
          end
          object TBItem31: TSpTBXItem
            Action = acClearMRU
            CaptionW = 'Clear'
            HintW = 'Clear the MRU list'
          end
          object TBItem32: TSpTBXItem
            Action = acClearInvalidMRU
            CaptionW = 'Remove Invalid'
            HintW = 'Remove invalid entries from the MRU list'
          end
        end
        object N11: TSpTBXSeparatorItem
        end
        object Exit1: TSpTBXItem
          Action = acExit
          CaptionW = 'Exit'
          HintW = 'Exit application'
        end
      end
      object Edit1: TSpTBXSubmenuItem
        ShortCut = 16474
        CaptionW = '&Edit'
        object TBItem14: TSpTBXItem
          Action = acUndo
          CaptionW = 'Undo'
          HintW = 'Undo last edit'
        end
        object TBSeparatorItem8: TSpTBXSeparatorItem
        end
        object TBItem5: TSpTBXItem
          Action = acCut
          CaptionW = 'Cut'
          HintW = 'Cut selected text'
        end
        object TBItem7: TSpTBXItem
          Action = acCopy
          CaptionW = 'Copy'
          HintW = 'Copy selected text'
        end
        object acCopyFromOriginal1: TSpTBXItem
          Action = acCopyFromOriginal
          CaptionW = 'Copy from Original'
          HintW = 'Copy the value of Original to Translation'
        end
        object TBItem13: TSpTBXItem
          Action = acCopyFromName
          CaptionW = 'Copy from Name'
          HintW = 'Copy the value of Name to Translation'
        end
        object TBItem6: TSpTBXItem
          Action = acPaste
          CaptionW = 'Paste'
          HintW = 'Paste from clipboard'
        end
        object TBSeparatorItem6: TSpTBXSeparatorItem
        end
        object Find1: TSpTBXItem
          Action = acFind
          CaptionW = 'Find...'
          HintW = 'Search for text'
        end
        object FindNext1: TSpTBXItem
          Action = acFindNext
          CaptionW = 'Find Next'
          HintW = 'Continue searching'
        end
        object Replace1: TSpTBXItem
          Action = acReplace
          CaptionW = 'Replace...'
          HintW = 'Replace text'
        end
        object N8: TSpTBXSeparatorItem
        end
        object ToggleFocus1: TSpTBXItem
          Action = acToggleFocus
          CaptionW = 'Toggle Focus'
          HintW = 'Toggle focus between list and translation'
        end
      end
      object Navigation1: TSpTBXSubmenuItem
        CaptionW = '&Actions'
        object tbxSpellCheck: TSpTBXItem
          Action = acSpellCheck
          CaptionW = 'Spelling...'
          HintW = 'Spell check the translations'
        end
        object Previous1: TSpTBXItem
          Action = acPrev
          CaptionW = 'Previous'
          HintW = 'Go to previous item in list'
        end
        object Next1: TSpTBXItem
          Action = acNext
          CaptionW = 'Next'
          HintW = 'Go to next item in list'
        end
        object About2: TSpTBXSeparatorItem
        end
        object Previousuntranslated1: TSpTBXItem
          Action = acPrevUntranslated
          CaptionW = 'Prev untranslated'
          HintW = 'Go to previous untranslated item'
        end
        object Nextuntranslated1: TSpTBXItem
          Action = acNextUntranslated
          CaptionW = 'Next untranslated'
          HintW = 'Go to next untranslated item'
        end
        object N2: TSpTBXSeparatorItem
        end
        object Font1: TSpTBXItem
          Action = acFont
          CaptionW = 'Font...'
          HintW = 'Change application font'
        end
        object N4: TSpTBXSeparatorItem
        end
        object Unsort1: TSpTBXItem
          Action = acRestoreSort
          CaptionW = 'Restore original sort'
          HintW = 'Restore original sort'
        end
        object TBXItem14: TSpTBXItem
          Action = acTrim
          CaptionW = 'Trim...'
          HintW = 'Trim leading and trailing characters'
        end
        object TBSeparatorItem10: TSpTBXSeparatorItem
        end
        object TBSubmenuItem3: TSpTBXSubmenuItem
          CaptionW = 'Toggle Bookmark'
          object TBItem41: TSpTBXItem
            Action = acToggleBookmark0
            Images = ilBookmarks
            CaptionW = 'Bookmark 0'
            HintW = 'Toggle Bookmark 0 on/off'
          end
          object TBItem40: TSpTBXItem
            Action = acToggleBookmark1
            Images = ilBookmarks
            CaptionW = 'Bookmark 1'
            HintW = 'Toggle Bookmark 1 on/off'
          end
          object TBItem39: TSpTBXItem
            Action = acToggleBookmark2
            Images = ilBookmarks
            CaptionW = 'Bookmark 2'
            HintW = 'Toggle Bookmark 2 on/off'
          end
          object TBItem38: TSpTBXItem
            Action = acToggleBookmark3
            Images = ilBookmarks
            CaptionW = 'Bookmark 3'
            HintW = 'Toggle Bookmark 3 on/off'
          end
          object TBItem37: TSpTBXItem
            Action = acToggleBookmark4
            Images = ilBookmarks
            CaptionW = 'Bookmark 4'
            HintW = 'Toggle Bookmark 4 on/off'
          end
          object TBItem30: TSpTBXItem
            Action = acToggleBookmark5
            Images = ilBookmarks
            CaptionW = 'Bookmark 5'
            HintW = 'Toggle Bookmark 5 on/off'
          end
          object TBItem28: TSpTBXItem
            Action = acToggleBookmark6
            Images = ilBookmarks
            CaptionW = 'Bookmark 6'
            HintW = 'Toggle Bookmark 6 on/off'
          end
          object TBItem26: TSpTBXItem
            Action = acToggleBookmark7
            Images = ilBookmarks
            CaptionW = 'Bookmark 7'
            HintW = 'Toggle Bookmark 7 on/off'
          end
          object TBItem23: TSpTBXItem
            Action = acToggleBookmark8
            Images = ilBookmarks
            CaptionW = 'Bookmark 8'
            HintW = 'Toggle Bookmark 8 on/off'
          end
          object TBItem22: TSpTBXItem
            Action = acToggleBookmark9
            Images = ilBookmarks
            CaptionW = 'Bookmark 9'
            HintW = 'Toggle Bookmark 9 on/off'
          end
        end
        object TBSubmenuItem4: TSpTBXSubmenuItem
          CaptionW = 'Goto Bookmark'
          object TBItem51: TSpTBXItem
            Action = acGotoBookmark0
            Images = ilBookmarks
            CaptionW = 'Bookmark 0'
            HintW = 'Goto Bookmark 0'
          end
          object TBItem50: TSpTBXItem
            Action = acGotoBookmark1
            Images = ilBookmarks
            CaptionW = 'Bookmark 1'
            HintW = 'Goto Bookmark 1'
          end
          object TBItem49: TSpTBXItem
            Action = acGotoBookmark2
            Images = ilBookmarks
            CaptionW = 'Bookmark 2'
            HintW = 'Goto Bookmark 2'
          end
          object TBItem48: TSpTBXItem
            Action = acGotoBookmark3
            Images = ilBookmarks
            CaptionW = 'Bookmark 3'
            HintW = 'Goto Bookmark 3'
          end
          object TBItem47: TSpTBXItem
            Action = acGotoBookmark4
            Images = ilBookmarks
            CaptionW = 'Bookmark 4'
            HintW = 'Goto Bookmark 4'
          end
          object TBItem46: TSpTBXItem
            Action = acGotoBookmark5
            Images = ilBookmarks
            CaptionW = 'Bookmark 5'
            HintW = 'Goto Bookmark 5'
          end
          object TBItem45: TSpTBXItem
            Action = acGotoBookmark6
            Images = ilBookmarks
            CaptionW = 'Bookmark 6'
            HintW = 'Goto Bookmark 6'
          end
          object TBItem44: TSpTBXItem
            Action = acGotoBookmark7
            Images = ilBookmarks
            CaptionW = 'Bookmark 7'
            HintW = 'Goto Bookmark 7'
          end
          object TBItem43: TSpTBXItem
            Action = acGotoBookmark8
            Images = ilBookmarks
            CaptionW = 'Bookmark 8'
            HintW = 'Goto Bookmark 8'
          end
          object TBItem42: TSpTBXItem
            Action = acGotoBookmark9
            Images = ilBookmarks
            CaptionW = 'Bookmark 9'
            HintW = 'Goto Bookmark 9'
          end
        end
        object TBXSeparatorItem2: TSpTBXSeparatorItem
        end
        object TBXItem2: TSpTBXItem
          Action = acConfigureKeyboard
          CaptionW = 'Configure Keyboard...'
          HintW = 'Display the keyboard configuration window'
        end
      end
      object TBSubmenuItem2: TSpTBXSubmenuItem
        CaptionW = '&View'
        object TBItem36: TSpTBXItem
          Action = acFindUnmatchedShortCut
          CaptionW = 'Next unmatched shortcut'
          HintW = 
            'Find next translated item that is missing a shortcut key present' +
            ' in the original'
        end
        object TBItem55: TSpTBXItem
          Action = acNextSuspicious
          CaptionW = 'Next suspicious translation'
          HintW = 
            'Move to next item that is suspected not being translated correct' +
            'ly'
        end
        object TBXItem15: TSpTBXItem
          Action = acConfigSuspicious
          CaptionW = 'Configure suspicious translations...'
          HintW = 'Configure the behavior of Next Suspicious Translation'
        end
        object N9: TSpTBXSeparatorItem
        end
        object ShowQuotes1: TSpTBXItem
          Action = acShowQuotes
          CaptionW = 'Show Quotes'
          HintW = 'Show quotes in texts'
        end
        object ShowDetails1: TSpTBXItem
          Action = acViewDetails
          CaptionW = 'Show Key Details'
          HintW = 'Display the details pane'
        end
        object N10: TSpTBXSeparatorItem
        end
        object TBItem16: TSpTBXItem
          Action = acViewComments
          CaptionW = 'View Comments'
          HintW = 'Toggle the comments window'
        end
        object TBItem56: TSpTBXItem
          Action = acViewOrphans
          CaptionW = 'View Orphaned Items'
          HintW = 
            'Display orphans (items in translation that are not in the origin' +
            'al)'
        end
        object TBXSeparatorItem3: TSpTBXSeparatorItem
        end
        object TBXVisibilityToggleItem1: TSpTBXItem
          Control = tbTools
          CaptionW = 'Tools'
        end
        object TBXItem8: TSpTBXItem
          Action = acFullScreen
          CaptionW = 'Full Screen'
          HintW = 'Toggle full screen mode'
        end
      end
      object Dictionary1: TSpTBXSubmenuItem
        CaptionW = '&Dictionary'
        object CreateDictionary1: TSpTBXItem
          Action = acDictCreate
          CaptionW = 'New Dictionary...'
          HintW = 'Create new dictionary'
        end
        object LoadDictionary1: TSpTBXItem
          Action = acDictLoad
          CaptionW = 'Load Dictionary...'
          HintW = 'Load existing dictionary'
        end
        object SaveDictionary1: TSpTBXItem
          Action = acDictSave
          CaptionW = 'Save Dictionary...'
          HintW = 'Save current dictionary to file'
        end
        object N5: TSpTBXSeparatorItem
        end
        object Translatewithdictionary1: TSpTBXItem
          Action = acDictTranslate
          CaptionW = 'Translate using Dictionary'
          HintW = 'Translate using the dictionary'
        end
        object TBXItem6: TSpTBXItem
          Action = acDictAdd
          CaptionW = 'Add to Dictionary'
          HintW = 'Add current item to the dictionary'
        end
        object N6: TSpTBXSeparatorItem
        end
        object TBXItem16: TSpTBXItem
          Action = acDictEdit
          CaptionW = 'Edit Dictionary...'
          HintW = 'Edit the currently loaded dictionary'
        end
        object TBXSeparatorItem8: TSpTBXSeparatorItem
        end
        object acDictInvert1: TSpTBXItem
          Action = acDictInvert
          CaptionW = 'Invert Dictionary'
          HintW = 'Invert the dictionary'
        end
      end
      object mnuPlugins: TSpTBXSubmenuItem
        Visible = False
        OnPopup = mnuPluginsPopup
        CaptionW = '&Plugins'
      end
      object TBXSubmenuItem1: TSpTBXSubmenuItem
        OnSelect = TBXSubmenuItem1Select
        CaptionW = 'T&ools'
        object TBXItem10: TSpTBXItem
          Action = acToolsCustomize
          CaptionW = 'Customize...'
          HintW = 'Display the tools window'
        end
      end
      object Help1: TSpTBXSubmenuItem
        CaptionW = '&Help'
        object Help2: TSpTBXItem
          Action = acHelp
          CaptionW = 'Help'
          HintW = 'Show help file'
        end
        object N7: TSpTBXSeparatorItem
        end
        object About1: TSpTBXItem
          Action = acAbout
          CaptionW = 'About...'
          HintW = 'Show about box'
        end
      end
    end
    object tbTools: TSpTBXToolbar
      Left = 0
      Top = 23
      Caption = 'Tools'
      ChevronHint = 'More Buttons|Click to see more buttons'
      DblClickUndock = True
      DefaultDock = TopDock
      DockPos = 0
      DockRow = 1
      FullSize = True
      HideWhenInactive = False
      Images = il16
      Options = [tboLongHintInMenuOnly, tboShowHint]
      TabOrder = 1
      object TBItem1: TSpTBXItem
        Action = acOpenOrig
        CaptionW = 'Open Original...'
        HintW = 'Open original and translation file'
      end
      object TBSeparatorItem2: TSpTBXSeparatorItem
      end
      object TBItem2: TSpTBXItem
        Action = acNewTrans
        CaptionW = 'New Translation'
        HintW = 'Create new translation'
      end
      object TBItem3: TSpTBXItem
        Action = acOpenTrans
        CaptionW = 'Open Translation...'
        HintW = 'Open existing translation file'
      end
      object TBItem4: TSpTBXItem
        Action = acSaveTrans
        CaptionW = 'Save Translation'
        HintW = 'Save current translation file'
      end
      object TBSeparatorItem1: TSpTBXSeparatorItem
      end
      object TBItem12: TSpTBXItem
        Action = acCut
        CaptionW = 'Cut'
        HintW = 'Cut selected text'
      end
      object TBItem10: TSpTBXItem
        Action = acCopy
        CaptionW = 'Copy'
        HintW = 'Copy selected text'
      end
      object TBItem8: TSpTBXItem
        Action = acPaste
        CaptionW = 'Paste'
        HintW = 'Paste from clipboard'
      end
      object TBSeparatorItem7: TSpTBXSeparatorItem
      end
      object TBItem9: TSpTBXItem
        Action = acFind
        CaptionW = 'Find...'
        HintW = 'Search for text'
      end
      object TBItem11: TSpTBXItem
        Action = acReplace
        CaptionW = 'Replace...'
        HintW = 'Replace text'
      end
      object TBSeparatorItem12: TSpTBXSeparatorItem
      end
      object TBItem18: TSpTBXItem
        Action = acPrevUntranslated
        CaptionW = 'Prev untranslated'
        HintW = 'Go to previous untranslated item'
      end
      object TBItem19: TSpTBXItem
        Action = acNextUntranslated
        CaptionW = 'Next untranslated'
        HintW = 'Go to next untranslated item'
      end
      object TBSeparatorItem4: TSpTBXSeparatorItem
      end
      object TBItem27: TSpTBXItem
        Action = acDictTranslate
        CaptionW = 'Translate using Dictionary'
        HintW = 'Translate using the dictionary'
      end
      object TBSeparatorItem5: TSpTBXSeparatorItem
      end
      object TBItem29: TSpTBXItem
        Action = acHelp
        CaptionW = 'Help'
        HintW = 'Show help file'
      end
      object TBXSeparatorItem1: TSpTBXSeparatorItem
      end
      object SpTBXSubmenuItem1: TSpTBXSubmenuItem
        DisplayMode = nbdmTextOnlyInMenus
        DropdownCombo = True
        CaptionW = 'Themes'
        object SpTBXThemeGroupItem1: TSpTBXThemeGroupItem
        end
      end
    end
  end
  object TBDock1: TSpTBXDock
    Left = 0
    Top = 49
    Width = 9
    Height = 446
    Position = dpLeft
  end
  object TBDock2: TSpTBXDock
    Left = 634
    Top = 49
    Width = 9
    Height = 446
    Position = dpRight
  end
  object TBDock3: TSpTBXDock
    Left = 0
    Top = 495
    Width = 643
    Height = 9
    Position = dpBottom
  end
  object pnlBack: TTntPanel
    Left = 9
    Top = 49
    Width = 625
    Height = 446
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 4
    TabOrder = 5
    object splitHorz: TSplitter
      Left = 4
      Top = 246
      Width = 617
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      AutoSnap = False
      MinSize = 100
      ResizeStyle = rsUpdate
    end
    object pnlBottom: TTntPanel
      Left = 4
      Top = 251
      Width = 617
      Height = 191
      Align = alBottom
      BevelOuter = bvNone
      BorderWidth = 1
      TabOrder = 0
      OnResize = pnlBottomResize
      object pnlTrans: TTntPanel
        Left = 1
        Top = 97
        Width = 615
        Height = 23
        Align = alTop
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 0
        object lblTrans: TTntLabel
          Left = 8
          Top = 5
          Width = 57
          Height = 13
          Caption = '&Translation:'
          FocusControl = reTranslation
        end
      end
      object reTranslation: TTntRichEdit
        Left = 1
        Top = 120
        Width = 615
        Height = 70
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvRaised
        BevelKind = bkFlat
        BorderStyle = bsNone
        HideSelection = False
        PlainText = True
        PopupMenu = popEdit
        ScrollBars = ssBoth
        TabOrder = 3
        WantReturns = False
        OnEnter = reTranslationEnter
        OnExit = reTranslationExit
        OnKeyDown = reTranslationKeyDown
      end
      object pnlOrig: TTntPanel
        Left = 1
        Top = 1
        Width = 615
        Height = 23
        Align = alTop
        Alignment = taLeftJustify
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 2
        object lblOrig: TTntLabel
          Left = 8
          Top = 4
          Width = 40
          Height = 13
          Caption = 'Ori&ginal:'
          FocusControl = reOriginal
          Layout = tlCenter
        end
      end
      object reOriginal: TTntRichEdit
        Left = 1
        Top = 24
        Width = 615
        Height = 73
        Align = alTop
        BevelInner = bvNone
        BevelOuter = bvRaised
        BevelKind = bkFlat
        BorderStyle = bsNone
        HideSelection = False
        PlainText = True
        PopupMenu = popEdit
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 1
        WantReturns = False
      end
    end
    object lvTranslateStrings: TTntListView
      Left = 4
      Top = 45
      Width = 617
      Height = 201
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvRaised
      Columns = <
        item
          AutoSize = True
          Caption = 'Original'
        end
        item
          AutoSize = True
          Caption = 'Translation'
          Tag = 1
        end
        item
          Alignment = taRightJustify
          Caption = '#'
          Tag = 2
          Width = 46
        end>
      GridLines = True
      HideSelection = False
      OwnerData = True
      ReadOnly = True
      RowSelect = True
      ParentShowHint = False
      PopupMenu = popList
      ShowHint = True
      SmallImages = il16
      TabOrder = 1
      ViewStyle = vsReport
      OnAdvancedCustomDrawItem = lvTranslateStringsAdvancedCustomDrawItem
      OnChange = lvTranslateStringsChange
      OnColumnClick = lvTranslateStringsColumnClick
      OnData = lvTranslateStringsData
      OnDataFind = lvTranslateStringsDataFind
      OnDblClick = lvTranslateStringsDblClick
      OnEnter = lvTranslateStringsEnter
      OnInfoTip = lvTranslateStringsInfoTip
    end
    object pnlKeyBack: TTntPanel
      Left = 4
      Top = 4
      Width = 617
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      BorderWidth = 2
      TabOrder = 2
      object pnlKeyDetails: TTntPanel
        Left = 2
        Top = 2
        Width = 613
        Height = 37
        Align = alClient
        Alignment = taLeftJustify
        BevelOuter = bvNone
        BorderWidth = 4
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlightText
        Font.Height = -19
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object lblViewDetails: TLabel
          Left = 4
          Top = 4
          Width = 605
          Height = 29
          Align = alClient
          AutoSize = False
          ParentShowHint = False
          ShowAccelChar = False
          ShowHint = True
          Layout = tlCenter
          WordWrap = True
        end
      end
    end
  end
  object alMain: TTntActionList
    Images = il16
    OnUpdate = alMainUpdate
    Left = 118
    Top = 158
    object acOpenOrig: TTntAction
      Category = 'File'
      Caption = 'Open Original...'
      Hint = 'Open original and translation file'
      ImageIndex = 68
      ShortCut = 24655
      OnExecute = acOpenOrigExecute
    end
    object acSaveOriginal: TTntAction
      Category = 'File'
      Caption = 'Save Original'
      Hint = 'Save current original file'
      ImageIndex = 18
      ShortCut = 24659
      OnExecute = acSaveOriginalExecute
    end
    object acSaveOrigAs: TTntAction
      Category = 'File'
      Caption = 'Save Original As...'
      Hint = 'Save current original file with a new filename'
      OnExecute = acSaveOrigAsExecute
    end
    object acCopyFromName: TTntAction
      Category = 'Edit'
      Caption = 'Copy from Name'
      Hint = 'Copy the value of Name to Translation'
      ShortCut = 24653
      OnExecute = acCopyFromNameExecute
    end
    object acCopyFromOriginal: TTntAction
      Category = 'Edit'
      Caption = 'Copy from Original'
      Hint = 'Copy the value of Original to Translation'
      ShortCut = 24643
      OnExecute = acCopyFromOriginalExecute
    end
    object acCopyAllFromOrig: TTntAction
      Category = 'Edit'
      Caption = 'Copy All From Original'
      Hint = 'Copy all text from original file to translation'
      ShortCut = 57411
      OnExecute = acCopyAllFromOrigExecute
    end
    object acNewTrans: TTntAction
      Category = 'File'
      Caption = 'New Translation'
      Hint = 'Create new translation'
      ImageIndex = 16
      ShortCut = 16462
      OnExecute = acNewTransExecute
    end
    object acOpenTrans: TTntAction
      Category = 'File'
      Caption = 'Open Translation...'
      Hint = 'Open existing translation file'
      ImageIndex = 17
      ShortCut = 16463
      OnExecute = acOpenTransExecute
    end
    object acSaveTrans: TTntAction
      Category = 'File'
      Caption = 'Save Translation'
      Hint = 'Save current translation file'
      ImageIndex = 18
      ShortCut = 16467
      OnExecute = acSaveTransExecute
    end
    object acSaveTransAs: TTntAction
      Category = 'File'
      Caption = 'Save Translation As...'
      Hint = 'Save current translation with a new filename'
      OnExecute = acSaveTransAsExecute
    end
    object acExit: TTntAction
      Category = 'File'
      Caption = 'Exit'
      Hint = 'Exit application'
      ShortCut = 32883
      OnExecute = acExitExecute
    end
    object acPrev: TTntAction
      Category = 'View'
      Caption = 'Previous'
      Hint = 'Go to previous item in list'
      ShortCut = 16422
      OnExecute = acPrevExecute
    end
    object acNext: TTntAction
      Category = 'View'
      Caption = 'Next'
      Hint = 'Go to next item in list'
      ShortCut = 16424
      OnExecute = acNextExecute
    end
    object acAbout: TTntAction
      Category = 'Help'
      Caption = 'About...'
      Hint = 'Show about box'
      OnExecute = acAboutExecute
    end
    object acToggleFocus: TTntAction
      Category = 'View'
      Caption = 'Toggle Focus'
      Hint = 'Toggle focus between list and translation'
      ShortCut = 117
      OnExecute = acToggleFocusExecute
    end
    object acFind: TTntAction
      Category = 'Edit'
      Caption = 'Find...'
      Hint = 'Search for text'
      ImageIndex = 22
      ShortCut = 16454
      OnExecute = acFindExecute
    end
    object acFindNext: TTntAction
      Category = 'Edit'
      Caption = 'Find Next'
      Hint = 'Continue searching'
      ShortCut = 114
      OnExecute = acFindNextExecute
    end
    object acReplace: TTntAction
      Category = 'Edit'
      Caption = 'Replace...'
      Hint = 'Replace text'
      ImageIndex = 23
      ShortCut = 16456
      OnExecute = acReplaceExecute
    end
    object acNextUntranslated: TTntAction
      Category = 'Actions'
      Caption = 'Next untranslated'
      Hint = 'Go to next untranslated item'
      ImageIndex = 9
      ShortCut = 16469
      OnExecute = acNextUntranslatedExecute
    end
    object acPrevUntranslated: TTntAction
      Category = 'Actions'
      Caption = 'Prev untranslated'
      Hint = 'Go to previous untranslated item'
      ImageIndex = 8
      ShortCut = 24661
      OnExecute = acPrevUntranslatedExecute
    end
    object acFocusTranslation: TTntAction
      Category = 'View'
      Caption = 'Focus Translation'
      Hint = 'Set focus to the translation edit field'
      ShortCut = 32852
      OnExecute = acFocusTranslationExecute
    end
    object acFocusListView: TTntAction
      Category = 'View'
      Caption = 'Focus ListView'
      Hint = 'Set focus to the listview'
      ShortCut = 32844
      OnExecute = acFocusListViewExecute
    end
    object acFocusOriginal: TTntAction
      Category = 'View'
      Caption = 'Focus Original'
      Hint = 'Set focus to the original edit field'
      ShortCut = 32839
      OnExecute = acFocusOriginalExecute
    end
    object acShowQuotes: TTntAction
      Category = 'View'
      Caption = 'Show Quotes'
      Hint = 'Show quotes in texts'
      ShortCut = 16465
      OnExecute = acShowQuotesExecute
    end
    object acFont: TTntAction
      Category = 'Edit'
      Caption = 'Font...'
      Hint = 'Change application font'
      ShortCut = 24646
      OnExecute = acFontExecute
    end
    object acRestoreSort: TTntAction
      Category = 'Actions'
      Caption = 'Restore original sort'
      Hint = 'Restore original sort'
      ShortCut = 24658
      OnExecute = acRestoreSortExecute
    end
    object acDictCreate: TTntAction
      Category = 'Dictionary'
      Caption = 'New Dictionary...'
      Hint = 'Create new dictionary'
      ImageIndex = 65
      ShortCut = 49230
      OnExecute = acDictCreateExecute
    end
    object acDictSave: TTntAction
      Category = 'Dictionary'
      Caption = 'Save Dictionary...'
      Hint = 'Save current dictionary to file'
      ImageIndex = 67
      ShortCut = 49235
      OnExecute = acDictSaveExecute
    end
    object acDictLoad: TTntAction
      Category = 'Dictionary'
      Caption = 'Load Dictionary...'
      Hint = 'Load existing dictionary'
      ImageIndex = 66
      ShortCut = 49231
      OnExecute = acDictLoadExecute
    end
    object acDictTranslate: TTntAction
      Category = 'Dictionary'
      Caption = 'Translate using Dictionary'
      Hint = 'Translate using the dictionary'
      ImageIndex = 64
      ShortCut = 49236
      OnExecute = acDictTranslateExecute
    end
    object acDictEdit: TTntAction
      Category = 'Dictionary'
      Caption = 'Edit Dictionary...'
      Hint = 'Edit the currently loaded dictionary'
      ShortCut = 49221
      OnExecute = acDictEditExecute
    end
    object acDictInvert: TTntAction
      Category = 'Dictionary'
      Caption = 'Invert Dictionary'
      Hint = 'Invert the dictionary'
      ImageIndex = 32
      ShortCut = 49225
      OnExecute = acDictInvertExecute
    end
    object acDictAdd: TTntAction
      Category = 'Dictionary'
      Caption = 'Add to Dictionary'
      Hint = 'Add current item to the dictionary'
      ImageIndex = 31
      ShortCut = 49217
      OnExecute = acDictAddExecute
    end
    object acHelp: TTntAction
      Category = 'Help'
      Caption = 'Help'
      Hint = 'Show help file'
      ImageIndex = 47
      ShortCut = 112
      OnExecute = acHelpExecute
    end
    object acCreateTranslationFile: TTntAction
      Caption = 'Create Translation File...'
      Hint = 'Create a new translation template file for IniTranslator itself'
      ShortCut = 57489
      Visible = False
      OnExecute = acCreateTranslationFileExecute
    end
    object acViewDetails: TTntAction
      Category = 'View'
      Caption = 'Show Key Details'
      Checked = True
      Hint = 'Display the details pane'
      ShortCut = 16452
      OnExecute = acViewDetailsExecute
    end
    object acCut: TTntAction
      Category = 'Edit'
      Caption = 'Cut'
      Enabled = False
      Hint = 'Cut selected text'
      ImageIndex = 10
      ShortCut = 16472
      OnExecute = acCutExecute
    end
    object acCopy: TTntAction
      Category = 'Edit'
      Caption = 'Copy'
      Enabled = False
      Hint = 'Copy selected text'
      ImageIndex = 11
      ShortCut = 16451
      OnExecute = acCopyExecute
    end
    object acPaste: TTntAction
      Category = 'Edit'
      Caption = 'Paste'
      Enabled = False
      Hint = 'Paste from clipboard'
      ImageIndex = 12
      ShortCut = 16470
      OnExecute = acPasteExecute
      OnUpdate = acPasteUpdate
    end
    object acSelectAll: TTntEditSelectAll
      Category = 'Edit'
      Caption = 'Select All'
      Hint = 'Select all text'
      ShortCut = 16449
    end
    object acUndo: TTntAction
      Category = 'Edit'
      Caption = 'Undo'
      Hint = 'Undo last edit'
      ImageIndex = 13
      ShortCut = 16474
      OnExecute = acUndoExecute
    end
    object acPreferences: TTntAction
      Category = 'File'
      Caption = 'Preferences...'
      Hint = 'Display the settings dialog'
      ImageIndex = 20
      ShortCut = 32781
      OnExecute = acPreferencesExecute
    end
    object acViewComments: TTntAction
      Category = 'View'
      Caption = 'View Comments'
      Hint = 'Toggle the comments window'
      ImageIndex = 44
      ShortCut = 16461
      OnExecute = acViewCommentsExecute
    end
    object acAsciiValues: TTntAction
      Category = 'View'
      Caption = 'ASCII Value(s)...'
      Hint = 'Show the ASCII values for the selected text'
      ShortCut = 16457
      OnExecute = acAsciiValuesExecute
    end
    object acClearMRU: TTntAction
      Category = 'MRU'
      Caption = 'Clear'
      Hint = 'Clear the MRU list'
      ImageIndex = 15
      OnExecute = acClearMRUExecute
    end
    object acClearInvalidMRU: TTntAction
      Category = 'MRU'
      Caption = 'Remove Invalid'
      Hint = 'Remove invalid entries from the MRU list'
      OnExecute = acClearInvalidMRUExecute
    end
    object acFindUnmatchedShortCut: TTntAction
      Category = 'Actions'
      Caption = 'Next unmatched shortcut'
      Hint = 
        'Find next translated item that is missing a shortcut key present' +
        ' in the original'
      ShortCut = 119
      OnExecute = acFindUnmatchedShortCutExecute
    end
    object acHome: TTntAction
      Category = 'View'
      Caption = 'Home'
      Hint = 'Move to the top of the list'
      ShortCut = 16420
      OnExecute = acHomeExecute
    end
    object acEnd: TTntAction
      Category = 'View'
      Caption = 'End'
      Hint = 'Move to the bottom of the list'
      ShortCut = 16419
      OnExecute = acEndExecute
    end
    object acPageUp: TTntAction
      Category = 'View'
      Caption = 'Page Up'
      Hint = 'Move one page up in the list'
      ShortCut = 16417
      OnExecute = acPageUpExecute
    end
    object acPageDown: TTntAction
      Category = 'View'
      Caption = 'Page Down'
      Hint = 'Move one page down in the list'
      ShortCut = 16418
      OnExecute = acPageDownExecute
    end
    object acNoRichEditTntAction: TTntAction
      Tag = -1
      Caption = 'NoRichEditTntAction'
      Enabled = False
      Hint = 
        'This action is just here to disable shortcuts in rich edits (no ' +
        'need to translate this text)'
      SecondaryShortCuts.Strings = (
        'Ctrl+L'
        'Ctrl+R'
        'Ctrl+B'
        'Ctrl+I'
        'Ctrl+U')
    end
    object acClearAllTranslations: TTntAction
      Category = 'View'
      Caption = 'Clear All Translations'
      Hint = 'Clear the translated text'
      ShortCut = 24622
      OnExecute = acClearAllTranslationsExecute
    end
    object acReplaceEverywhere: TTntAction
      Category = 'View'
      Caption = 'Use this translation everywhere'
      Hint = 'Use this translation everywhere'
      ImageIndex = 19
      ShortCut = 24648
      OnExecute = acReplaceEverywhereExecute
    end
    object acNextSuspicious: TTntAction
      Category = 'Actions'
      Caption = 'Next suspicious translation'
      Hint = 
        'Move to next item that is suspected not being translated correct' +
        'ly'
      ShortCut = 8311
      OnExecute = acNextSuspiciousExecute
    end
    object acConfigSuspicious: TTntAction
      Category = 'Actions'
      Caption = 'Configure suspicious translations...'
      Hint = 'Configure the behavior of Next Suspicious Translation'
      ShortCut = 32887
      OnExecute = acConfigSuspiciousExecute
    end
    object acViewOrphans: TTntAction
      Category = 'View'
      Caption = 'View Orphaned Items'
      Hint = 
        'Display orphans (items in translation that are not in the origin' +
        'al)'
      OnExecute = acViewOrphansExecute
    end
    object acConfigureKeyboard: TTntAction
      Category = 'Actions'
      Caption = 'Configure Keyboard...'
      Hint = 'Display the keyboard configuration window'
      ShortCut = 24651
      OnExecute = acConfigureKeyboardExecute
    end
    object acImport: TTntAction
      Category = 'File'
      Caption = 'Import...'
      Hint = 'Import from an external file or files'
      ImageIndex = 9
      OnExecute = acImportExecute
    end
    object acExport: TTntAction
      Category = 'File'
      Caption = 'Export...'
      Hint = 'Export to an external file or files'
      ImageIndex = 8
      OnExecute = acExportExecute
    end
    object acToggleTranslated: TTntAction
      Category = 'Actions'
      Caption = 'Translated'
      Hint = 'Toggle the Translated status of the item'
      ShortCut = 16468
      OnExecute = acToggleTranslatedExecute
    end
    object acTestExceptionHandler: TTntAction
      Tag = 1
      Caption = 'Test exception'
      Hint = 'Test the exception handler'
      ShortCut = 57467
      OnExecute = acTestExceptionHandlerExecute
    end
    object acFullScreen: TTntAction
      Category = 'View'
      Caption = 'Full Screen'
      Hint = 'Toggle full screen mode'
      ShortCut = 122
      OnExecute = acFullScreenExecute
    end
    object acSpellCheck: TTntAction
      Category = 'Actions'
      Caption = 'Spelling...'
      Hint = 'Spell check the translations'
      ShortCut = 118
    end
    object acToolsCustomize: TTntAction
      Category = 'Tools'
      Caption = 'External Tools...'
      Hint = 'Display the tools window'
      ImageIndex = 36
      OnExecute = acToolsCustomizeExecute
    end
    object acAddItem: TTntAction
      Category = 'Edit'
      Caption = 'Add Item...'
      Hint = 'Add new item to original and translation'
      ImageIndex = 31
      ShortCut = 16429
      OnExecute = acAddItemExecute
    end
    object acEditItem: TTntAction
      Category = 'Edit'
      Caption = 'Edit Item...'
      Hint = 'Edit all parts of the current item'
      ImageIndex = 35
      ShortCut = 8237
      OnExecute = acEditItemExecute
    end
    object acDeleteItem: TTntAction
      Category = 'Edit'
      Caption = 'Delete Item...'
      Hint = 'Delete the current item from both original and translation'
      ImageIndex = 15
      ShortCut = 16430
      OnExecute = acDeleteItemExecute
    end
    object acTrim: TTntAction
      Category = 'Actions'
      Caption = 'Trim...'
      Hint = 'Trim leading and trailing characters'
      ShortCut = 24660
      OnExecute = acTrimExecute
    end
  end
  object SaveDictDlg: TTntSaveDialog
    DefaultExt = 'dct'
    Filter = 'Dictionary files|*.dct;*.cat|All files|*.*'
    InitialDir = '.'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save Dictionary File'
    Left = 78
    Top = 192
  end
  object OpenDictDlg: TTntOpenDialog
    DefaultExt = 'dct'
    Filter = 'Dictionary files|*.dct;*.cat|All files|*.*'
    InitialDir = '.'
    Title = 'Open Dictionary File'
    Left = 38
    Top = 192
  end
  object il16: TImageList
    AllocBy = 24
    Left = 158
    Top = 192
    Bitmap = {
      494C010146004A00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003001000001001000000000000098
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008031803160666066004260660042
      6066004260660042000000000000000000000000000000000000000010001000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008031F37F80316066606660666066
      0042606600426066004200000000000000000000000000000000100000000000
      1000000000001000100000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008031F37F207F8031606660666066
      6066606660660042606600420000000000000000000000000000100000000000
      1000000010000000000010000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008031F37FFF7F207F803160666066
      6066606660666066004260660042000000000000000000000000100000000000
      1000000010000000000010000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008031F37F207FFF7F207F80318031
      8031803180318031803180318031803100000000000000000000000010001000
      1000000010000000000010000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008031F37FFF7F207FFF7F207F207F
      207F207F207F0000000000000000000000000000000000000000000000000000
      1000000010001000100000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008031F37F207FFF7FF37FF37FF37F
      F37FF37FF37F0000000000001000100010000000000000000000000000000000
      1000000010000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008031FF7FF37F3367803180318031
      8031803180318031000000000000100010000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006066803180318031606600426066
      0042000010000000000000001000000010000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006066606660666066606660660042
      6066004200001000100010000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008031803180318031803180318031
      8031803180310000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000207F207F207F207F207F00000000
      0000000000000000000000001000100010000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F37FF37FF37FF37FF37F00000000
      0000000000000000000000000000100010000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008031803180318031803180310000
      0000000010000000000000001000000010000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001000100010000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000104218631863
      1863186318631863186318631863186300000000000000000000104218631863
      1863186318631863186318631863186300000000803180316066606600426066
      0042606600426066004200000000000000000000000086316C4E6C4EC618C618
      C618C618C618C618D65AD65AC618803100001040104010401040104010401042
      104010401040104010401040FF7F186300001040104010401040104010401042
      104010401040104010401040FF7F186300001040104010401040104010400042
      1040104010401040104010400000000000000000104010401040104010401040
      FF7F1040104010401040104010406C4E00000000000018631863186300000000
      000018631863186310420000FF7F186300000000000018631863186300000000
      000018631863186310420000FF7F186300000000000018631863186300000000
      0000186318631863104200000042000000000000000000001863186318630000
      00000000186318631863104200006C4E00000000104200000000000018631042
      186300000000000000001040FF7F186300000000104200000000000018631042
      186300000000000000001040FF7F186300000000104200000000000018631042
      1863000000000000000010406066004200000000000010420000000000001863
      10421863000000000000000010406C4E000000001042FF7FFF7F186310420000
      FF7FFF7FFF7F186300001040FF7F1863000000001042FF7FFF7F186310420000
      FF7FFF7FFF7F186300001040FF7F1863000000001042FF7FFF7F186310420000
      FF7FFF7FFF7F186300001040803180318031000000001042FF7FFF7F18631042
      0000FF7FFF7FFF7F1863000010406C4E000000001042FF7FFF7F186310420000
      FF7FFF7FFF7F186300001040FF7F1863000000001042FF7FFF7F186310421042
      FF7FFF7FFF7F186300001040FF7F1863000000001042FF7FFF7F186310420000
      FF7FFF7FFF7F186300001040000000000000000000001042FF7FFF7F18631042
      0000FF7FFF7FFF7F1863000010406C4E000000001042FF7FFF7F186310421042
      FF7FFF7FFF7F186300001040FF7F1863000000001042FF7FFF7F186310421042
      FF7FFF7FFF7F186300001040FF7F1863000000001042FF7FFF7F186310421042
      FF7FFF7FFF7F186300001040000000000000000000001042FF7FFF7F18631042
      1042FF7FFF7FFF7F1863000010403367000000001042FF7FFF7F186310421042
      FF7FFF7FFF7F186300001040FF7F1863000000001042FF7FFF7F186310421042
      FF7FFF7FFF7F186300001040FF7F1863000000001042FF7FFF7F186310421042
      FF7FFF7FFF7F186300001040000000000000000000001042FF7FFF7F18631042
      1042FF7FFF7FFF7F1863000010403367000000000000FF7FFF7F186310420000
      FF7FFF7FFF7F186300001040FF7F1863000000000000FF7FFF7F186310420000
      FF7FFF7FFF7F186300001040FF7F1863000000000000FF7FFF7F186310420000
      FF7FFF7FFF7F186300001040CC00CC00CC00000000000000FF7FFF7F18631042
      0000FF7FFF7FFF7F186300001040336700000000000010421042000000000000
      000010421042000018631863FF7F18630000007C007C007C104200000000007C
      000010421042000018631863FF7F186300000000000010421042000000000000
      0000104210420000000000000000D300CC000000000000001042104200000000
      FF7F0000104210420000F97F863133670000000000000000000010421863FF7F
      1863E07F18631863FF7F000000000000000000000000007C007CFF7F007C007C
      0000E07F18631863FF7F00000000000000000000000000000000000000000000
      00000000D300000000000000D3000000CC00000000008631F97F6C4EFF7FFF7F
      FF7FFF7FFF7FF97FF97FF37F86318631000000000000000000001042FF7FE07F
      FF7FFF7FFF7FE07FFF7F1863FF7F104200000000007C007C007C007C007C007C
      007C007CFF7FE07FFF7F1863FF7F104200000000000000000000000000000000
      000000000000D300D300D300000000000000000000008631FF7F6C4E6C326C32
      6C326C326C326C326C326C3286311863000000000000000000001042FF7FFF7F
      FF7FE07FFF7FFF7FFF7F1863104200000000007C007C0000007C007C007CFF7F
      FF7FE07FFF7FFF7FFF7F18631042000000000000000000000000000000000000
      00000000000000000000000000000000000000000000863186316C4E6C326C32
      6C326C326C326C326C326C328631863100000000000000000000104210421042
      104210421042104210421042000000000000000000000000007C1042007C007C
      1042104210421042104210420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000104218631863
      1863186318631863186318631863186300000000000000000000104218631863
      1863186318631863186318631863186300000000000000000000104218631863
      1863186318631863186318631863186300000000000000000000104218631863
      18631863186318631863186318631863000000000000000000001042FF7FE07F
      FF7FFF7FFF7FE07FFF7FE07FFF7F1863000000000000000000001042FF7FE07F
      FF7FFF7FFF7FE07FFF7FE07FFF7F1863000000000000000000001042FF7FE07F
      FF7FFF7FFF7FE07FFF7FE07FFF7F1863000000000000000000001042FF7FE07F
      FF7FFF7FFF7FE07FFF7FE07FFF7F1863000000000000000000001042FF7FFF7F
      FF7F0000000000000000FF7FFF7F1863000000000000000000001042FF7FFF7F
      FF7F0000000000000000FF7FFF7F1863000000000000000000001042FF7FFF7F
      FF7FFF7F1040FF7FFF7FFF7FFF7F1863000000000000000000001042FF7FFF7F
      FF7FFF7F1040FF7FFF7FFF7FFF7F1863000000000000000000001042FF7FE07F
      FF7FE07F00000000FF7FE07FFF7F1863000000000000000000001042FF7FE07F
      FF7FE07F00000000FF7FE07FFF7F1863000000000000000000001042FF7FE07F
      FF7F1040FF7FE07FFF7FE07FFF7F1863000000000000000000001042FF7FE07F
      FF7F1040FF7FE07FFF7FE07FFF7F1863000000000000000000001042FF7FFF7F
      FF7FFF7F00000000FF7FFF7FFF7F1863000000000000000000001042FF7FFF7F
      FF7FFF7F00000000FF7FFF7FFF7F1863000000000000000000001042FF7FFF7F
      10401040FF7FFF7FFF7FFF7FFF7F1863000000000000000000001042FF7FFF7F
      10401040FF7FFF7FFF7FFF7FFF7F1863000000000000000000001042FF7FE07F
      FF7FE07F00000000FF7FE07FFF7F1863000000000000000000001042FF7FE07F
      FF7FE07F00000000FF7FE07FFF7F1863000000000000000000001042FF7FE07F
      10401040FF7FE07FFF7FE07FFF7F1863000000000000000000001042FF7FE07F
      10401040FF7FE07FFF7FE07FFF7F1863000000000000000000001042FF7FFF7F
      FF7FFF7F000000000000FF7FFF7F18630000000000000000007C1042FF7F007C
      FF7FFF7F000000000000FF7FFF7F1863000000000000000000001042FF7FFF7F
      104010401040FF7FFF7F1040FF7F18630000000000000000007C1042FF7F007C
      104010401040FF7FFF7F1040FF7F1863000000000000000000001042FF7FE07F
      FF7FE07FFF7FE07FFF7FE07FFF7F18630000000000000000007C007CFF7F007C
      FF7FE07FFF7FE07FFF7FE07FFF7F1863000000000000000000001042FF7FE07F
      FF7F10401040104010401040FF7F18630000000000000000007C007CFF7F007C
      FF7F10401040104010401040FF7F1863000000000000000000001042FF7FFF7F
      FF7FFF7F00001042FF7FFF7FFF7F186300000000000000000000007C007C007C
      FF7F007C007C1042FF7FFF7FFF7F1863000000000000000000001042FF7FFF7F
      FF7FFF7F1040104010401040FF7F186300000000000000000000007C007C007C
      FF7F007C007C104010401040FF7F1863000000000000000000001042FF7FE07F
      FF7F0000000000001863FF7FFF7F186300000000007C007C007C007C007C007C
      007C007C000000001863FF7FFF7F1863000000000000000000001042FF7FE07F
      FF7F10401040104010401040FF7F186300000000007C007C007C007C007C007C
      007C007C1040104010401040FF7F1863000000000000000000001042FF7FFF7F
      FF7FFF7F00001042FF7F0000000000000000000000000000007C007CFF7F007C
      007CFF7F00001042FF7F000000000000000000000000000000001042FF7FFF7F
      FF7FFF7FFF7FFF7FFF7F0000000000000000000000000000007C007CFF7F007C
      007CFF7FFF7FFF7FFF7F000000000000000000000000000000001042FF7FE07F
      FF7FFF7FFF7FE07FFF7F1863FF7F1042000000000000007C007C007C007C007C
      007C007C007CE07FFF7F1863FF7F1042000000000000000000001042FF7FE07F
      FF7FFF7FFF7FE07FFF7F1863FF7F1042000000000000007C007C007C007C007C
      007C007C007CE07FFF7F1863FF7F1042000000000000000000001042FF7FFF7F
      FF7FE07FFF7FFF7FFF7F18631042000000000000007C007C0000007C007C007C
      FF7FE07FFF7FFF7FFF7F186310420000000000000000000000001042FF7FFF7F
      FF7FE07FFF7FFF7FFF7F18631042000000000000007C007C0000007C007C007C
      FF7FE07FFF7FFF7FFF7F18631042000000000000000000000000104210421042
      1042104210421042104210420000000000000000000000000000007C1042007C
      007C104210421042104210420000000000000000000000000000104210421042
      1042104210421042104210420000000000000000000000000000007C1042007C
      007C104210421042104210420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001863
      0000000000000000000000000000000000000000000000000000000000001863
      0000000000000000000000000000000000000000000000000000000000001863
      0000000000000000000000000000000000000000000000000000000000001863
      0000000000000000000000000000000000000000000000000000186310001000
      1042186318631863186318631863186300000000000000000000186310001000
      1042186318631863186318631863186300000000000000000000186310001000
      1042186318631863186318631863186300000000000000000000186310001000
      104218631863186318631863186318630000000000000000186310001F001F00
      1042FF7FE07FFF7FFF7FE07FFF7F18630000000000000000186310001F001F00
      1042FF7FE07FFF7FFF7FE07FFF7F18630000000000000000186310001F001F00
      1042FF7FE07FFF7FFF7FE07FFF7F18630000000000000000186310001F001F00
      1042FF7FE07FFF7FFF7FE07FFF7F1863000000000000000010001F001F001F00
      1042FF7FFF7F1F001F001F00FF7F1863000000000000000010001F001F001F00
      1042FF7FFF7F1F001F001F00FF7F1863000000000000000010001F001F001F00
      1042FF7FE07F100010001863FF7F1863000000000000000010001F001F001F00
      1042FF7FE07F100010001863FF7F186300000000000018631F0000021F001F00
      1042FF7FE07FFF7FFF7FE07FFF7F186300000000000018631F0000021F001F00
      1042FF7FE07FFF7FFF7FE07FFF7F186300000000000018631F0000021F001F00
      1042FF7F10021F001F0010001863186300000000000018631F0000021F001F00
      1042FF7F10021F001F00100018631863000000000000104200021F001F001F00
      1042FF7FFF7F1F001F001F00FF7F1863000000000000104200021F001F001F00
      1042FF7FFF7F1F001F001F00FF7F1863000000000000104200021F001F001F00
      1042FF7F100210420002100010421863000000000000104200021F001F001F00
      1042FF7F100210420002100010421863000000000000104218631F001F001002
      1042E07FFF7FFF7FE07FFF7FFF7F1863000000000000104218631F001F001002
      1042E07FFF7FFF7FFF7FFF7FFF7F1863000000000000104218631F001F001002
      1042FF7F1002FF7F1042100018631863000000000000104218631F001F001002
      1042FF7F1002FF7F10421000186318630000000000001042100218631F001863
      1042FF7FFF7F1F001F00186300000000000000000000007C10021863007C1863
      1042FF7FFF7F1F001F001863000000000000000000001042100218631F001863
      1042FF7FE07F10021002186300000000000000000000007C10021863007C1863
      1042FF7FE07F1002100218630000000000000000000010421863FF7F18631F00
      1042FF7FE07FFF7FFF7F1863FF7F1042104200000000007C007CFF7F007C1F00
      1042FF7FE07FFF7FFF7F1863FF7F104210420000000010421863FF7F18631F00
      1042FF7FE07FFF7FFF7F1863FF7F1042104200000000007C007CFF7F007C1F00
      1042FF7FE07FFF7FFF7F1863FF7F1042104200000000186310421863FF7F0002
      1042FF7FFF7FFF7FE07F1863104210421863000000001863007C007C007C0002
      007C007CFF7FFF7FE07F186310421042186300000000186310421863FF7F0002
      1042FF7FFF7FFF7FE07F1863104210421863000000001863007C007C007C0002
      007C007CFF7FFF7FE07F18631042104218630000000000001042FF7F18631002
      104210421042104210421042104200000000007C007C007C007C007C007C007C
      007C104210421042104210421042000000000000000000001042FF7F18631002
      104210421042104210421042104200000000007C007C007C007C007C007C007C
      007C1042104210421042104210420000000000000000000018631042FF7F1863
      FF7F00021F00000200021F0010001863000000000000007C007CFF7F007C007C
      FF7F00021F00000200021F0010001863000000000000000018631042FF7F1863
      FF7F00021F00000200021F0010001863000000000000007C007CFF7F007C007C
      FF7F00021F00000200021F001000186300000000000000000000186310421042
      18631F00100210021F001F001863000000000000007C007C007C007C007C007C
      007C007C100210021F001F001863000000000000000000000000186310421042
      18631F00100210021F001F001863000000000000007C007C007C007C007C007C
      007C007C100210021F001F001863000000000000000000000000000000001863
      104210421042104218630000000000000000007C007C0000007C007C007C1863
      1042104210421042186300000000000000000000000000000000000000001863
      104210421042104218630000000000000000007C007C0000007C007C007C1863
      1042104210421042186300000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000007C0000007C007C
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000007C0000007C007C
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001040
      0000104200000000000000000000000000000000000000000000000010401040
      1040104010401040104010401040104000000000000000000000104218631863
      1863186318631863186318631863186300000000000000000000104218631863
      1863186318631863186318631863186300000000000000000000000010401040
      0000FF7F1863FF7F0000000000000000000000000000000000001040FF7F0000
      104210421863FF7FFF7FFF7FFF7F1040000000000000000000001042FF7FE07F
      FF7FE07FFF7FFF7FFF7FFF7FE07F1863000000000000000000001042FF7FE07F
      FF7FE07FFF7FFF7FFF7FFF7FE07F186300000000000000000000104010401040
      00001042FF7F1863FF7F186300000000000000000000000010401040FF7F0000
      1863FF7F104210421863FF7FFF7F1040000000000000000000001042FF7FFF7F
      FF7FFF7FFF7FFF7FE07FFF7FFF7F1863000000000000000000001042FF7FFF7F
      FF7FFF7FFF7FFF7FE07FFF7FFF7F186300000000000000001040104010401040
      18630000000010421863FF7F1863000000000000000010401040FF7FFF7F0000
      1863FF7FFF7FFF7F10421863FF7F1040000000000000000000001042E07FFF7F
      1F001F001F001F001F00FF7FFF7F1863000000000000000000001042E07FFF7F
      1F001F001F001F001F00FF7FFF7F186300000000000010401040104010401863
      104010401040000000001042FF7F10420000000000001040FF7FFF7FFF7F0000
      1863FF7FE07FFF7FFF7F1042FF7F1040000000000000000000001042FF7FFF7F
      E07FFF7FFF7FFF7FFF7FFF7FE07F1863000000000000000000001042FF7FFF7F
      E07FFF7FFF7FFF7FFF7FFF7FE07F186300000000104010401040104018631040
      104010401040104010400000000010420000000000001040FF7FFF7FFF7F0000
      1863FF7FFF7FFF7FE07F1042FF7F1040000000000000000000001042FF7FFF7F
      1F001F001F001F001F00FF7FFF7F1863000000000000000000001042FF7FFF7F
      1F001F001F001F001F00FF7FFF7F1863000000001040007C10401863007C1040
      10401040104010401040104010400000000000000000007CFF7FFF7F007C0000
      1863FF7FE07FFF7FFF7F1042FF7F1040000000000000000000001042E07FFF7F
      E07FFF7FFF7FFF7FFF7FFF7FFF7F1863000000000000000000001042E07FFF7F
      E07FFF7FFF7FFF7FFF7FFF7FFF7F1863000000001040007C007C1040007C1040
      10401040104010401040104010400000000000000000007C007CFF7F007C0000
      1863FF7FFF7FFF7FE07F1042FF7F1040000000000000000000001042FF7FE07F
      1F001F001F001F001F00FF7FFF7F18630000000000000000007C1042FF7F007C
      1F001F001F001F001F00FF7FFF7F18630000000010401863007C007C007C1040
      007C007C1040104010401040000000000000000000001040007C007C007C0000
      007C007CE07FFF7FFF7F1042FF7F1040000000000000000000001042FF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FE07F18630000000000000000007C007CFF7F007C
      FF7FFF7FFF7FFF7FFF7FFF7FE07F18630000007C007C007C007C007C007C007C
      007C10401040104010400000000000000000007C007C007C007C007C007C007C
      007CFF7FFF7FFF7FE07F104200000000000000000000000000001042FF7FE07F
      1F001F001F001F00FF7FFF7FFF7F186300000000000000000000007C007C007C
      1F00007C007C1F00FF7FFF7FFF7F1863000000000000007C007CFF7F007C007C
      10401040104010400000000000000000000000000000007C007CFF7F007C007C
      000010421042FF7FFF7F104200000000000000000000000000001042FF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00000000000000000000007C007C007C007C007C007C
      007C007CFF7FFF7FFF7F00000000000000000000007C007C007C007C007C007C
      007C007C10400000000000000000000000000000007C007C007C007C007C007C
      007C007C000010421042104200000000000000000000000000001042FF7FE07F
      E07FFF7FE07FFF7FFF7F1863FF7F10420000000000000000007C007CFF7F007C
      007CFF7FE07FFF7FFF7F1863FF7F10420000007C007C0000007C007C007C0000
      104010400000000000000000000000000000007C007C1042007C007C007C0000
      00000000000000000000000000000000000000000000000000001042FF7FFF7F
      FF7FFF7FFF7FFF7FE07F186310420000000000000000007C007C007C007C007C
      007C007C007CFF7FE07F1863104200000000000000000000007C0000007C007C
      000000000000000000000000000000000000000000000000007C0000007C007C
      0000000000000000000000000000000000000000000000000000104210421042
      1042104210421042104210420000000000000000007C007C0000007C007C007C
      1042104210421042104210420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001040
      0000104200000000000000000000000000000000000000000000000010401040
      1040104010401040104010401040104000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000010401040
      0000FF7F1863FF7F0000000000000000000000000000000000001040FF7F0000
      104210421863FF7FFF7FFF7FFF7F104000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000104010401040
      00001042FF7F1863FF7F186300000000000000000000000010401040FF7F0000
      1863FF7F104210421863FF7FFF7F104000000000000000000000FF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7F00000000000000000000000000000000000000000000
      1042FF7F00000000000000000000000000000000000000001040104010401040
      18630000000010421863FF7F1863000000000000000010401040FF7FFF7F0000
      1863FF7FFF7FFF7F10421863FF7F104000000000000000000000104210420000
      000000000000FF7FFF7F00000000000000000000000000000000000000001042
      1042FF7FFF7F0000000000000000000000000000000010401040104010401863
      104010401040000000001042FF7F10420000000000001040FF7FFF7FFF7F0000
      1863FF7FE07FFF7FFF7F1042FF7F104000000000000000000000000010420000
      000000000000FF7F000000000000000000000000000000000000000000001042
      00000000FF7F0000000000000000000000000000104010401040104018631040
      104010401040104010400000000010420000000000001040FF7FFF7FFF7F0000
      1863FF7FFF7FFF7FE07F1042FF7F104000000000000000000000000010421042
      00000000FF7FFF7F000000000000000000000000000000000000000010421042
      00000000FF7FFF7F000000000000000000000000104010401040186310401040
      104010401040104010401040104000000000000000001040FF7FFF7FFF7F0000
      1863FF7FE07FFF7FFF7F1042FF7F104000000000000000000000000000001042
      00000000FF7F0000000000000000000000000000000000000000000010420000
      000000000000FF7F000000000000000000000000104010401863104010401040
      104010401040104010401040104000000000000000001040FF7FFF7FFF7F0000
      1863FF7FFF7FFF7FE07F1042FF7F104000000000000000000000000000001042
      1042FF7FFF7F0000000000000000000000000000000000000000104210420000
      000000000000FF7FFF7F00000000000000000000104018631040104010401040
      104010401040104010401040000000000000000000001040FF7FFF7FFF7F0000
      1863FF7FE07FFF7FFF7F1042FF7F104000000000000000000000000000000000
      1042FF7F00000000000000000000000000000000000000000000104210421042
      1042104210421042104200000000000000000000186310401040104010401040
      104010401040104010400000000000000000000000001040FF7FFF7F18631042
      1042FF7FFF7FFF7FE07F10420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000001040104010401040
      104010401040104000000000000000000000000000001040FF7FFF7F10420000
      000010421042FF7FFF7F10420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000010401040
      104010401040000000000000000000000000000000001040FF7F186310420000
      0000000000001042104210420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      1040104000000000000000000000000000000000000010421863104200000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000001042000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000001F001F001F0000001F001F00
      1F001F001F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084100821
      945210410410000000000000000000000000000000001F000000186300000000
      00001F001F00000000000000000000000000000000000000000000000000007C
      007C007C007C007C00000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F0000000000000000000000000000082194521863
      7B6F1863104104100000000000000000000000000000000010421863FF7F1863
      1863000000000000000000000000000000000000000000000000007C007C007C
      007C007C007C007C007C007C000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F000000000000000000000821945218637B6F3967
      524AD65A186390400410000000000000000000000000000000001042FF7FFF7F
      104200000000396739673967396739670000000000000000007C007C007C007C
      007C007C007C007C007C007C007C00000000000000000000FF7FFF7FFF7FFF7F
      0002FF7FFF7FFF7FFF7FFF7F0000000000000410524A18637B6F3967524A9041
      00009041D65A186390400410000000000000000000001863186318631863FF7F
      000000000000F37FFF7FF37FFF7F39670000000000000000007C007CFF7FFF7F
      007C007C007CFF7FFF7F007C007C00000000000000000000FF7FFF7FFF7F0002
      000200020002FF7FFF7FFF7F0000000000001040945239671042904100000410
      104000009041D65A1863904004100000000000000000FF7FFF7FFF7FFF7F0000
      0000000000000000F37FFF7FF37F3967000000000000007C007C007C007CFF7F
      FF7F007CFF7FFF7F007C007C007C007C0000000000000000FF7FFF7FFF7FFF7F
      0002FF7FFF7F0002FF7FFF7F0000000000001040104290410000041010401040
      1040104000009041D65A1863104104100000000000001863FF7FFF7FFF7F1042
      0000000000000000FF7FF37FFF7F3967000000000000007C007C007C007C007C
      FF7FFF7FFF7F007C007C007C007C007C0000000000000000FF7FFF7F0002FF7F
      FF7FFF7FFF7F0002FF7FFF7F0000000000001040000004101040104010401040
      10401040104000009041D65A18631041000000001863FF7FFF7FFF7FFF7FFF7F
      0000000000000000F37FFF7FF37F3967000000000000007C007C007C007C007C
      FF7FFF7FFF7F007C007C007C007C007C0000000000000000FF7FFF7F0002FF7F
      FF7F0002FF7FFF7FFF7FFF7F000000000000104090411040104010401040604E
      004290401040104000009041D65A08210000000018631F001863FF7FFF7F1042
      0000000000000000FF7FF37FFF7F3967000000000000007C007C007C007CFF7F
      FF7F007CFF7FFF7F007C007C007C007C0000000000000000FF7FFF7FFF7F0002
      000200020002FF7FFF7FFF7F0000000000000000104090411040104010401041
      524AE07F606F904010400410904184100000000000001042FF7F186300000000
      0000000000000000F37FFF7FF37F39670000000000000000007C007CFF7FFF7F
      007C007C007CFF7FFF7F007C007C00000000000000000000FF7FFF7FFF7FFF7F
      FF7F0002FF7FFF7FFF7FFF7F0000000000000000000010409041104010400042
      04421042E07F606F9040104004100000000000001863FF7FFF7F000000000000
      0000000000000000FF7FF37F396739670000000000000000007C007C007C007C
      007C007C007C007C007C007C007C00000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7F0000000000000000000000000000000000001040904110408C40
      606FE07FE07F604E104010401040000000000000000000000000000000000000
      000000000000FF7FF37F00000000000000000000000000000000007C007C007C
      007C007C007C007C007C007C000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7F0000FF7F00000000000000000000000000000000104090411040
      1041104110419040104010400410000000000000000000000000000000000000
      00000000FF7FFF7FFF7F1042FF7F00000000000000000000000000000000007C
      007C007C007C007C00000000000000000000000000000000FF7FFF7FFF7FFF7F
      FF7FFF7FFF7F0000000000000000000000000000000000000000000010409041
      1040104010401040041000000000000000000000000000000000000000000000
      0000FF7FFF7FFF7FFF7F10420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001040
      9041104004100000000000000000000000000000000000000000000010421042
      1042104210421042104210420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      1040041000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000100010001000100010001021
      1000100010000000000000000000000000000000000000000000000010001000
      1000100010001000100010001000100010000000000000000000000010001000
      1000100010001000100010001000100010000000000000000000000000001042
      18631863186310420000000000000000000010001F001B001021102110219452
      9010170010001000000000000000000000000000000000000000000010001F00
      1F001F0010001F001F001F001F001F0010000000000000000000000010001F00
      1F001F0010001F001F001F001F001F001000100010001000000000001863FF7F
      FF7F18631863186318631042000000000000000010001021D65A3967FF7FD65A
      9031100010001000901010001000100000000000000000000000000010001000
      1F00100018631000100010001F001F0010000000000000000000000010001000
      1F00100018631000100010001F001F00100010001F00100000001863FF7FFF7F
      104210421042000000000000000000000000000000000000524AFF7F7B6F524A
      0821901010001021945210211B0010001000604EF97F2C672C672C672C671000
      100010421863FF7F18631863100010000000000000002C672C672C672C671000
      100010421863FF7F186318631000100000001F001F001F0000001863FF7F1863
      FF7FFF7F186310421042E07F1042000000000000000000008410396718631863
      1863D65A0400F75ED65A1042100010000000604EF97FF37FF37F337FF37F337F
      100000001042FF7FFF7F1042000000000000000000002C67F97FF37FF37FF37F
      100000001042FF7FFF7F10420000000000001002100210020000104210421042
      1042104210421863E07F1863000010420000000000000000000008217B6FFF7F
      FF7F7B6F0821F75E94520C21100000000000604EF97FF37FF37FF37F337F0000
      1863186318631863FF7F000000000000000000002C67F97FF37FF37FF37F0000
      1863186318631863FF7F00000000000000001000100010001000E07F1863E07F
      1863E07F1863E07F186310420000104200000000000000000000524AFF7FFF7F
      FF7FD65A0821524A1863D65AD65A08210000604EF97FF37FF37FF37FF37F0000
      FF7FFF7FFF7FFF7F0000000000000000000000002C67F97FF37FF37FF37F0000
      FF7FFF7FFF7FFF7F000000000000000000001042FF7F1863E07F1863E07F1863
      E07F1863E07F1863E07F000010421042000000000000000008217B6FFF7FFF7F
      FF7F3967945208217B6FFF7FBD7708210000604EF97FF37FF37FF37FF37F0000
      1863FF7FFF7FFF7F104200000000000000002C67F97FF37FF37FF37FF37F0000
      1863FF7FFF7FFF7F104200000000000000001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7F104200001863104200000000000000000000524A7B6FFF7F
      18639B10524A08217B6FFF7F7B6F08210000604EF97FF37FF37FF37F00001863
      FF7FFF7FFF7FFF7FFF7F00000000000000002C67F97FF97FF97FF97F00001863
      FF7FFF7FFF7FFF7FFF7F00000000000000001042104210421042104210421042
      104210421042104210421042E07F10420000000000000000000000000821D65A
      BD77524A10429452FF7FFF7FBD77D65A0821604EF97FF37FF37FF37F00001863
      1F001863FF7FFF7F104200000000000000002C672C672C672C672C6700001863
      1F001863FF7FFF7F1042000000000000000000001042FF7F1863E07F1863E07F
      1863E07F1863E07F1863E07F1863104200000000000000000000000000008410
      39671863524A082139673967592994520821604EF97FF37FF37FF37FF37F0000
      1042FF7F18630000000000000000000000000000604EF97FF37FF37FF37F0000
      1042FF7F186300000000000000000000000000001042FF7FE07F1863E07F1863
      E07F1863FF7FFF7FFF7FFF7FFF7F104200000000000000000000000000000000
      08210821841000009452BD7794528C310000604EF97FF97FF97FF97F00001863
      FF7FFF7F00000000000000000000000000000000604EF97FF97FF97F00001863
      FF7FFF7F000000000000000000000000000000001042FF7F1863E07F1863E07F
      1863FF7F10421042104210421042104200000000000000000000000000000000
      000000000000000084103967BD7794528410604E2C672C672C672C6700000000
      0000000000000000000000000000000000000000604E2C672C672C6700000000
      000000000000000000000000000000000000000000001042FF7FFF7FFF7FFF7F
      FF7F104200000000000000000000000000000000000000000000000000000000
      0000000000000000000008210821082100000000604EDE7BF97FF97F00000000
      00000000000000000000000000000000000000000000604EDE7BF97F00000000
      0000000000000000000000000000000000000000000000001042104210421042
      1042000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000604E604E604E604E0000
      000000000000000000000000000000000000000000000000604E604E604E0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C030C030C0300000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000040007CC04C0040C030000000000000000000000000000000000000
      0000186318631042104200000000000000001042104210421042104210421042
      1042104210421042104210421042000000000000000000000000000000000000
      1042186318631863104200000000000000008031E07F207FE07F207F6066207F
      60666066C0642C7F807DC04CC030000000000000000000000000000000001863
      1863186318631042104200000000000000001042FF7FE07F1863E07F1863E07F
      1863E07F1863E07F1863E07F1042000000000000100010001000000000001863
      FF7FFF7F18631863186318631042000000008031F37FF37F207FF37F207F6066
      207F6066C0642C7F807DC04CC030000000000000000000000000186318630002
      1863186318631042104200000000000000001042FF7F1863E07F1863E07F1863
      E07F1863E07F1863E07F1863104200000000000010001F00100000001863FF7F
      FF7F104210421042000000000000000000008031F37F207FF37F207FF37F207F
      6066207FC0642C7F807DC04CC030000000000000000010421863186300020002
      0002000218631042104210420000000000001042FF7FE07F1863E07F1863E07F
      1863E07F1863E07F1863E07F10420000000000001F001F001F0000001863FF7F
      1863FF7FFF7F186310421042E07F104200008031F37FFF7F207FF37F207FF37F
      207F6066C0642C7F807DC04CC030000000000000000010421863000218630002
      1863000218631042104210420000000000001042FF7F1863E07F1863E07F1863
      E07F186310421863E07F18631042000000000000100210021002000010421042
      10421042104210421863E07F1863104200008031F37F207FFF7F207FF37F207F
      F37F207FC0642C7F807DC04CC030000000000000104218631863000218631863
      1863186318631042104210420000000000001042FF7FE07F1863E07F1863E07F
      1863E07F0000E07F1863E07F10420000000000001000100010001000E07F1863
      E07F1863E07F1863E07F1863E07F104200008031F37FF37FF37FF37FF37FF37F
      F37FE07FC064F37F807DC04CC030000000000000104218630002000200021863
      0002000218631042104210420000000000001042FF7F1863E07F1863E07F1863
      E07F000000000000E07F186310420000000000001042FF7F1863E07F1863E07F
      1863E07F1863E07F1863E07F1863104200008031803180318031803180318031
      80318031C064F37F2C7FC04C0040000000000000104218631863000218631863
      0002000218631042104210421042000000001042FF7FE07F1863E07F1863E07F
      0000FF03100210020000E07F10420000000000001042FF7FE07F1863E07F1863
      E07F1863E07F1863E07F1863E07F1042000000008031FE7FF37FF37F60660000
      0000000000428C658C65C04C0000000000000000104218631863186300020002
      FF7FFF7FFF7FFF7F104210421042000000001042FF7FFF7FFF7FFF7FFF7F0000
      FF031002000010021002000010420000000000001042FF7F1863E07F1863E07F
      1863E07F1863E07F1863E07F1863104200000000000080318031803100000000
      00000000000008213E53000000000000000010421863186318631863FF7FFF7F
      1042186318631863FF7FFF7F10420000000010421863E07F1863E07F18630000
      FF030000100200001002000010420000000000001042FF7FE07F1863E07F1863
      E07F1863E07F1863E07F1863E07F104200000000000000000000000000000000
      CE390821000008213E530000000000000000104218631863FF7FFF7F00001042
      10421863186318631863FF7FFF7F00000000000010421863E07F1863E07F1863
      00000000100200000000000000000000000000001042FF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F10420000000000000000000000000000CE39
      BF670821082110423E53D3180000D31800001042FF7FFF7F1042104200001042
      186318631863FF7FFF7F10421042000000000000000010421042104210421042
      18630000000000000000000000000000000000001042E07F1863E07F1863E07F
      1863E07F1042104210421042104210420000000000000000000000000000CE39
      FF7F186318631863FF7F186318633E53000010421042FF7FFF7F104200001863
      1863FF7FFF7F1042104200000000000000000000000000000000000000000000
      00001002FF03100200000000000000000000000000001042E07F1863E07F1863
      E07F10420000000000000000000000000000000000000000000000000000CE39
      FF7F3E530000FF7FFF7FBF67BF67000000000000000010421042FF7F1042FF7F
      FF7F104210420000000000000000000000000000000000000000000000000000
      0000FF0310021002000000000000000000000000000000001042104210421042
      1042000000000000000000000000000000000000000000000000000000000000
      CE39CE390000CE39CE39CE39CE39000000000000000000000000104210421042
      1042000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000104239673967396739673967000000000000000000008031F37F207F
      207F207F207F6066207F606660660000000000000000000000008031F37F207F
      207F207F207F6066207F60666066000000000000000000000000000000000000
      8031F37F207F207F207F606660660000000000000000CC000000000000000000
      000000001042FF7FF37FFF7FF37F3967000000000000000000008031F37FF37F
      207F207F207F207F6066207F60660000000000000000000000008031F37FF37F
      207F207F207F207F6066207F6066000000000000000000000000000000000000
      8031F37FFF7F207F207F207F60660000000000000000D300CC00000000000000
      000000001042FF7FFF7FF37FFF7F3967000000000000000000008031F37F207F
      F37F207F207F207F207F606660660000000000000000000000008031F37F207F
      F37F207F207F207F207F60666066000000000000000000000000000000000000
      8031F37F207FFF7F207F207F6066000000000000CC00D900D900D30000000000
      000000001042FF7FF37FFF7FF37F3967000000000000000000008031F37FFF7F
      207FF37F207F207F207F207F60660000000000000000000000008031F37FFF7F
      207FF37F207F207F207F207F6066000000000000000000000000000000000000
      8031F37FF37FF37FF37FF37FF37F00000000CC000000D900D300000000001042
      396739671042FF7FFF7FF37FFF7F3967000000000000000000008031F37F207F
      FF7F207FF37F207F207F207F6066000000001042FF7FF37FFF7F8031F37F207F
      FF7F207FF37F207F207F207F60660000000000000000CE393967396739673967
      8031F37FF37FF37F80318031803100000000D3000000D3000000000000001042
      FF7FFF7F1042FF7FFF7FFF7FFF7F000000008031F37F207F207F8031F37FF37F
      F37FF37FF37FF37FF37FF37FF37F000000001042FF7FFF7FF37F8031F37FF37F
      F37FF37FF37FF37FF37FF37FF37F0000000000000000CE39F37FFF7FF37FFF7F
      396780318031803180310000000000000000D300000000000000000000001042
      FF7FF37F10421042104210421042104200008031F37FF37F207F8031F37FF37F
      F37F336780318031803180318031000000001042FF7FF37FFF7F8031F37FF37F
      F37F8031803180318031803180310000000010423967CE39FF7FF37FFF7FF37F
      396700000000000000000000000000000000D300000000000000000000001042
      FF7FFF7FF37FFF7F396700000000000000008031F37F207FF37F207F80318031
      8031803160660000000000000000000000001042FF7FFF7FF37FFF7F80318031
      80310000000000000000000000000000000010423967CE39FF7FFF7FF37FFF7F
      3967000000000000000000000000000000000000D30000000000000000001042
      FF7FFF7FFF7FF37F396700000000000000008031F37FFF7F207FF37F207F207F
      207F606660660000000000001000000000001042FF7FF37FFF7FF37FFF7FF37F
      39670000000000000000000010000000000010423967CE39FF7FF37FFF7FF37F
      3967000000000000000000001000000000000000000000000000000000001042
      FF7FFF7FFF7FFF7F000000000000000000008031F37F207FFF7F207FF37F207F
      207F207F6066000000001000D300100000001042FF7FFF7FF37FFF7FF37F3967
      396700000000000000001000D3001000000010423967CE39FF7FFF7FF37FFF7F
      396700000000000000001000D300100000000000000000000000000000001042
      1042104210421042000000000000000000008031F37FF37FF37FF37FF37FF37F
      F37FF37FF37F0000D900D900D300100010001042FF7FFF7FFF7FF37F00000000
      0000000000000000D900D900D3001000100010423967CE39FF7FFF7FFF7FFF7F
      3967000000000000D900D900D300100010000000000000000000000000000000
      0000000000000000000000000000000000008031F37FF37FF37F336780318031
      8031803180310000000000001000000000001042FF7FFF7FFF7FFF7F1042FF7F
      00000000000000000000000010000000000010423967CE39CE39CE39CE39CE39
      CE39000000000000000000001000000000000000000000000000000000000000
      0000000000000000000000000000000000000000803180318031803100000000
      0000000000001000100010000000000000001042FF7FFF7FFF7FFF7F10420000
      0000000000001000100010000000000000001042396739673967396739670000
      0000000000001000100010000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001042104210421042104210420000
      000000000000000000000000000000000000104210421042104210421042CE39
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001042396739673967396739673967
      3967396739673967396739673967396700008031F37F207F207F6066207F6066
      207F6066606660666C4E60666C4E000000008031F37F207F207F6066207F6066
      6066606660666066000000000000000000000000000000000000000000001042
      3967396739673967396739673967396700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700008031F37F207F207F207F6066207F
      6066207F6066606660666C4E6066000000008031F37F207F207F207F6066207F
      60666066606660660000000000000000000000000000CC000000000000001042
      FF7FFF7FF37FFF7FF37FFF7FF37F396700001042FF7FFF7FD300FF7FFF7FD900
      D900D900FF7FD900D900D900FF7F396700008031F37FFF7F207F207FC618C618
      C618C618C618C618606660666C4E000000008031F37FF97F207F207F207F6066
      207F6066606660660000000000000000000000000000D300CC00000000001042
      FF7FF37FFF7FF37FFF7FF37FFF7F396700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700008031F37F207FFF7F207FC618207F
      207F207F6066207F606660666066000000008031F37F207FF97F207F207F207F
      6066207F60666066006400000000000000000000CC00D900D900D30000001042
      FF7FFF7FF37FFF7FF37FFF7FF37F396700001042FF7FFF7FD300FF7FFF7F9F19
      9F199F19FF7F9F199F199F19FF7F396700008031F37FFF7F207FFF7FC618207F
      207F207F207F6066207F60666066000000008031F37FF97F207FF97F207F207F
      207F6066207F606600000000000000640000CC000000D900D300000000001042
      FF7FF37FFF7FF37FFF7FF37FFF7F396700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700008031F37F207FC618C618C618C618
      C618207F207F207F207F207F6066000000008031F37F207FF97F207FF97F207F
      207F207F0064207F00640000006400000000D3000000D3000000000000001042
      FF7FFF7FF37FFF7FF37FFF7FF37F396700001042FF7FFF7F1042104210421042
      104210421042104210421042FF7F396700008031F37FFF7F207FC618C618C618
      207FFF7F207F207F207F6066207F000000008031F37FF37FF37FF37FF37FF37F
      F37FF37FF37F0064004C0064000000000000D300000000000000000000001042
      FF7FFF7FFF7FF37FFF7FF37F3967396700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700008031F37F207FFF7F207FC618207F
      FF7F207FFF7F207F207F207F6066000000008031803180318031803180318031
      006400640064004CFF7F004C006400000064D300000000000000000000001042
      FF7FFF7FFF7FFF7FF37F00000000000000001042FF7FFF7FFF7FFF7FFF7F9F19
      9F199F19FF7F9F199F199F19FF7F396700008031F37FF37FF37FF37FF37FF37F
      F37FF37FF37FF37FF37FF37FF37F0000000000008031FF7FF37FF37FF37F0000
      0000000000000064004C00640000000000000000D30000000000006400000064
      FF7F0064FF7FFF7FFF7F1042FF7F000000001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700008031803180318031803180318031
      8031803180318031803180318031000000000000000080318031803180310000
      000000000064000000640000006400000000000000000000000000000064004C
      0064FF7FFF7FFF7FFF7F10420000000000001000100010001000100010001000
      10001000100010001000100010001000000000008031F37FF37F33673367604E
      0000000000000000000000000000000000000000000000000000000000000000
      00000064000000000000000000000064000000000000000000000064004CFF7F
      004C006410421042104210420000000000001F007F1A9F199F199F199F199F19
      9F199F199F199F199F199F199F199F1900000000000080318031803180318031
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000640000000000000000000000000000000000000064004C
      0064000000000000000000000000000000001F001F001F001F001F001F001F00
      1F001F001F001F001F001F001F001F0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000006400000064
      0000006400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000006400000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF7FFF7FFF7F7B6F7B6F
      39673967D65AD65A00006B2D0000000000001042396739673967396739673967
      3967396739673967396739673967396700001042396739673967396739673967
      3967396739673967396739673967396700001042396739673967396739673967
      3967396739673967396739673967396700000000000000000000000000000000
      0000000000000000000000006B2D000000001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7F0000000000000000FF7F396700001042FF7FFF7FD300D300FF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700001042FF7FD300D300FF7FFF7FFF7F
      FF7FFF7FD300D300FF7FFF7FFF7F396700001042FF7FFF7F7B6F396739673967
      E003E003E0033967396700000000000000001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700001042FF7FFF7F9F19D300FF7F0000
      0000FF7FFF7FFF7FFF7FFF7FFF7F396700001042FF7F9F19D300FF7F00000000
      FF7FFF7F9F19D300FF7F00000000396700001042FF7FFF7FFF7F7B6F39673967
      0002000200023967396700001042000000001042FF7FFF7F0000000000000000
      FF7FFF7FD300D300D300D300FF7F396700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700001042104210421042104210421042
      1042104210421042104200001042104200001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7F9F1939673967D300FF7F396700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FD300D300FF7FFF7FFF7F396700001042FF7FD300D300FF7FFF7FFF7F
      FF7FFF7FD300D300FF7FFF7FFF7F396700001042FF7FFF7FFF7FFF7FFF7F7B6F
      7B6F396739673967000010420000104200001042FF7FFF7FD300D300D300D300
      FF7FFF7F9F19FF7FD300D300FF7F396700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7F9F19D300FF7F00000000396700001042FF7F9F19D300FF7F00000000
      FF7FFF7F9F19D300FF7F00000000396700000000104210421042104210421042
      1042104210421042104200001042000000001042FF7FFF7F9F1939673967D300
      FF7FFF7F9F199F199F19FF7FFF7F396700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700000000000010423967FF7FFF7FFF7F
      FF7FFF7FFF7FFF7F000010420000104200001042FF7FFF7F9F19FF7FD300D300
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700001042FF7FFF7FD300D300FF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700001042FF7FD300D300FF7FFF7FFF7F
      FF7FFF7FD300D300FF7FFF7FFF7F396700000000000000001042FF7FDF18DF18
      DF18DF18DF18FF7F000000000000000000001042FF7FFF7F9F199F199F19FF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700001042FF7FFF7F9F19D300FF7F0000
      0000FF7FFF7FFF7FFF7FFF7FFF7F396700001042FF7F9F19D300FF7F00000000
      FF7FFF7F9F19D300FF7F000000003967000000000000000010423967FF7FFF7F
      FF7FFF7FFF7FFF7F396700000000000000001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F396700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7FFF7F3967000000000000000000001042FF7F9F19
      9F199F199F199F19FF7F00000000000000001000100010001000100010001000
      1000100010001000100010001000100000001000100010001000100010001000
      1000100010001000100010001000100000001000100010001000100010001000
      100010001000100010001000100010000000000000000000000010423967FF7F
      FF7FFF7FFF7FFF7FFF7F39670000000000001F007F1A9F199F199F199F199F19
      9F199F199F199F199F199F199F199F1900001F007F1A9F199F199F199F199F19
      9F199F199F199F199F199F199F199F1900001F007F1A9F199F199F199F199F19
      9F199F199F199F199F199F199F199F1900000000000000000000000010421042
      1042104210421042104210421042000000001F001F001F001F001F001F001F00
      1F001F001F001F001F001F001F001F0000001F001F001F001F001F001F001F00
      1F001F001F001F001F001F001F001F0000001F001F001F001F001F001F001F00
      1F001F001F001F001F001F001F001F0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000060660000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000064607E0064000000000000000000000000000000000000
      0064607E00640000000000000000000000001042396739673967396739673967
      3967396739673967000000000000000000000000000000000000000060660000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000064607E007C0064000000000000000000000000000000000064
      607E007C00640000000000000000000000001042FF7F1F001F00F37F1F001F00
      1F001F001F003967000000000000000000000000000000000000606600000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000064607E007C0064000000000000000000000000000000000000607E
      007C006400000000000000000000000000001042FF7FFF7FF37FFF7FF37FFF7F
      F37FFF7FF37F3967000000000000000000000000000000000000606600000000
      0000000000009F193F1B00000000000000000000000000000000000000000000
      00000000607E007C00640000000000000000000010423F1B3F1B791A93190000
      00640000000000000000C64C0000000000001042FF7F9F199F19F37F9F199F19
      9F199F199F193967000000000000000000006066000000006066000000000000
      0000000000000000000000000000000000000000000010420000790279027902
      93199319000000640000000000000000000010423F4FFF1BFF1B3F4F791A9319
      0000000000000000C64C00640000000000001042FF7FFF7FF37FFF7FF37FFF7F
      F37FFF7FF37F3967000000000000000000006066F37F00006066000000000000
      00000000000000000000000000000000000000001042D65A3F1B3F1B3F1B3F1B
      79027902931900000000000000000000000010423F4FFF67FF4FFF1B3F4F791A
      000000000000C64C007C0064C64CC64C00001042FF7F39673967F37FFF7FF37F
      3967000039673967000000000000000000006066F37F207F207F606600000000
      0000000000009F197F1A000000000000000000001042FF4FFF4FFF4F3F4F3F1B
      3F1B7902790200000000000000000000000010423F4FFF7FFF67FF4FFF1B3F1B
      00000000000000000064007C00000000C64C1042FF7F000000003967F37F3967
      0000336700003967000000000000000000006066F37FF37F207F207F60660000
      00000000000000009F197F1A00000000000010423F4FFF4FFF4FFF4FFF4FFF4F
      3F1B3F1B79029319000000000000000000001042D65AFF7FFF7FFF67FF1B3F1B
      00000000000000000000006400000000C64C1042FF7F6C4EF97F000039670000
      3367863133670000000000000000000000006066F37F2C7F207F606600000000
      000000000000000000009F197F1A0000000010423F4FFF67FF67FF67FF4FFF4F
      FF4F3F1B790279020000000000000000000000001042D65A3F4F3F4F3F4F1042
      00000000000000000000000000000000C64C1042FF7FFF7F6C4EF97F00003367
      8631336786316C4E6C4E6C4E00009F199F1960662C7FF37F6066000000000000
      0000000000000000000000009F197F1A000010423F4FFF7FFF7FFF67FF67FF4F
      FF4F3F4F3F1B7902000000000000000000000000000010421042104210420000
      00000000006400000000000000000000000010421042104210426C4EF97F0000
      336786313367336733676C4E6C4E7F1A7F1A6066F37F60660000000000000000
      9F193F1B00000000000000009F193F1B00001042D65AFF7FFF7FFF7FFF67FF67
      FF4FFF4F3F1B7902000000000000000000000000000000000000000000000000
      00000000006400000000C64C000000000000000000000000000000006C4EF97F
      0000F97FF97F33673367336733673F1B3F1B60662C7F00000000000000000000
      9F193F1B00000000000000009F193F1B0000000010423F4FFF7FFF7FFF7FFF67
      FF4FFF4F3F1B0000000000000000000000000000000000000000000000000000
      000000000064000000000064C64C000000000000000000000000000000006C4E
      FF7FFF7FF97FF97FF97FF97F6C4EFF4FFF4F6066000000000000000000000000
      00009F193F1B0000000000007F1A9F19000000001042D65A3F4FFF7FFF7FFF67
      FF4F3F4F791A0000000000000000000000000000000000000000000000000000
      00000000000000640064007C007CC64C00000000000000000000000000000000
      6C4E6C4E6C4E6C4E6C4E6C4E00009F199F196066000000000000000000000000
      000000009F199F199F199F199F19000000000000000010421042D65A3F4F3F4F
      3F4F104210420000000000000000000000000000000000000000000000000000
      00000000000000000000007C0064000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000104210421042
      1042000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000640000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000021040064607E00640000000000000000000000001042396739673967
      3967396739673967396739670000000000008031803160666066004260660042
      606600426066004200000000000000000000000086316C4E6C4EC618C618C618
      C618C618C618D65AD65AC6188031000000000000000000000000104239673967
      396739670064607E007C00640000186300000000000000001042F97FFF7FF37F
      FF7FF37FFF7FF37FFF7F39670000000000008031F37F80316066606660666066
      004260660042606600420000000000000000000086316C4E336729252925C618
      C618C618C6183967D65AC6186C4E0000000000000000000000001042FF7FF37F
      FF7F0064607E007C00640000FF7F186300000000000000001042FF7FF37FFF7F
      F37FFF7FF37FFF7FF37F39670000000000008031F37F207F8031606660666066
      6066606660660042606600420000000000000000863133673367292529252925
      29252925C618FF7F3967C6186C4E0000000000000000000000001042F37FFF7F
      0064607E007C00640000FF7FF37F186300000000000000001042FF7FFF7FF37F
      FF7FF37FFF7FF37FFF7F39670000000000008031F37FFF7F207F803160666066
      6066606660666066004260660042000000000000863133673367292529252925
      29252925292529252925C6186C4E000000000000000000000000000000000000
      607E006400640000FF7FF37FFF7F186300000000000000001042FF7FF37FFF7F
      F37FFF7FF37FFF7FF37F39670000000000008031F37F207FFF7F207F80318031
      80318031803180318031803180318031000000008631F97F3367336733673367
      3367336733673367336733676C4E000000000000A514791A3F4FD65A3F4F0000
      006400640000FF7FF37FFF7FF37F186300000000000000001042FF7FFF7FF37F
      FF7FF37FFF7FF37FFF7F39670000000000008031F37FFF7F207FFF7F207F207F
      207F207F207F00000000000000000000000000008631F97F3367863186318631
      8631863186318631863133676C4E000000001042791A3F4F3F4FD65AFF4F9319
      00000000FF7FF37FFF7FF37FFF7F186300000000000000001042FF7FFF7FFF7F
      F37FFF7FF37FFF7FF37F39670000000000008031F37F207FFF7FF37FF37FF37F
      F37FF37FF37F00000000000000000000000000008631F97F6C4EF97FF97FF37F
      F37FF37FF37FF37FF37F863133670000000010423F4F3F4F3F4FD65AFF673F4F
      0000D65AF37FFF7FF37FFF7FF37F186300000000000000001042FF7FFF7FFF7F
      FF7FF37FFF7FF37F396739670000000000008031FF7FF37F3367803180318031
      80318031803180310000000000000000000000008631F97F6C4EF97FF97FF97F
      F97FF97FF97FF37FF37F863133670000000010423F4F3F4F3F4FD65AFF7FFF4F
      0000D65AFF7FF37FFF7FF37FFF7F186300000000000000001042FF7FFF7FFF7F
      FF7FFF7FF37F0000000000000000000000000000803180318031000000000000
      00000000000000000000CC00CC00CC00000000008631F97F6C4EFF7FFF7FFF7F
      FF7FF97FF97FF97FF37F863133670000000010423F4F3F4F3F4FD65AFF7FFF4F
      0000D65AF37FFF7FF37FFF7FF37F186300000000000000001042FF7FFF7FFF7F
      FF7FFF7FFF7F1042FF7F00000000000000000000000000000000000000000000
      000000000000000000000000D300CC00000000008631F97F6C4EFF7FFF7FFF7F
      FF7FFF7FF97FF97FF37F86313367000000001042791A3F4F3F4FD65AFF4F3F4F
      0000FF7FFF7FF37FFF7FF37F1863186300000000000000001042FF7FFF7FFF7F
      FF7FFF7FFF7F1042000000000000000000000000000000000000000000000000
      0000D300000000000000D3000000CC00000000008631F97F6C4EFF7FFF7FFF7F
      FF7FFF7FF97FF97FF37F863186310000000000001042791A3F4FD65A3F4F0000
      1863FF7FFF7FFF7FF37F00000000000000000000000000001042104210421042
      1042104210421042000000000000000000000000000000000000000000000000
      00000000D300D300D300000000000000000000008631FF7F6C4E6C326C326C32
      6C326C326C326C326C328631186300000000000000001042104210421042FF7F
      FF7FFF7FFF7FFF7FFF7F1042FF7F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000863186316C4E6C326C326C32
      6C326C326C326C326C32863186310000000000000000000000001042FF7FFF7F
      FF7FFF7FFF7FFF7FFF7F10420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000104210421042
      1042104210421042104210420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000004C0000000000000000
      000000000000000000000000007C000000000000000000000000000000000000
      1042396739673967396739673967396700000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000C664007C004C000000000000
      00000000000000000000000000000000000086316C4E6C4E6C4E6C4E6C4E6C4E
      1042FF7FD900D900D900D900D900396700000000000000000000000000000000
      000000000000000000000000000000000000000000009F190000000000000000
      0000000000000000000000000000000000000000C664667E007C004C00000000
      00000000000000000000007C0000000000008631336733676C4E33676C4E6C4E
      1042F37FFF7FF37FFF7FF37F3967396700000000000000000000000000000000
      00000000000000009F19FF4F000000000000000000009F19FF4F000000000000
      00000000000000000000000000000000000000000000C664807D006400000000
      0000000000000000007C00000000000000008631F97F33673367336733676C4E
      1042FF7F1F001F00FF7FCE390000000000009F193F1B3F1B3F1B3F1B00000000
      00000000000000009F19FF4F3F1B0000000000009F19FF4F3F1B000000000000
      0000000000009F193F1B3F1B3F1B3F1B00000000000000000064007C004C0000
      000000000000007C004C000000000000000086313367F97F336733676C4E3367
      1042FF7FF37FFF7FF37F1042FF7F000000009F19FF67FF673F1B000000000000
      000000000000000000009F19FF4F0000000000009F19FF4F0000000000000000
      00000000000000009F19FF7FFF4F3F1B000000000000000000000064007C004C
      00000000007C004C000000000000000000008631F97F3367F97F336733673367
      1042FF7FFF7FFF7FFF7F10420000000000009F19FF67FF67FF4F000000000000
      000000000000000000009F19FF4F0000000000009F19FF4F0000000000000000
      00000000000000009F19FF4F3F1B3F1B0000000000000000000000000064007C
      004C007C004C0000000000000000000000008631F97FF97F3367F97F33673367
      1042104210421042104210420000000000009F19FF7F0000FF4F3F1B00000000
      000000000000000000009F19FF4F0000000000009F19FF4F0000000000000000
      0000000000009F19FF4F3F1B00003F1B00000000000000000000000000000064
      007C004C00000000000000000000000000008631F97FF97FF97F3367F97F3367
      33676C4E33676C4E33676C4E0000000000009F19000000009F19FF4F3F1B0000
      000000000000000000003F1BFF4F0000000000009F19FF7F3F1B000000000000
      00009F199F19FF4F3F1B000000009F190000000000000000000000000064007C
      004C0064004C0000000000000000000000008631FF7FF97F0000000000000000
      00000000000000006C4E6C4E0000000000009F190000000000009F19FF4FFF4F
      3F1B0000000000003F1BFF4F000000000000000000009F19FF4F3F1B00000000
      0000FF4FFF4F3F1B9F19000000000000000000000000000000000064007C004C
      000000000064004C000000000000000000008631FF7FF97F6066F37F267F267F
      267F6066804D00006C4E6C4E000000000000000000000000000000009F199F19
      FF4FFF4FFF4FFF4FFF4F00000000000000000000000000009F19FF7FFF4FFF4F
      FF4F3F1B9F199F1900000000000000000000000000000064007C007C004C0000
      0000000000000064004C00000000000000008631FF7FFF7FFF7F6066F37F8031
      8031606600006C4E33676C4E0000000000000000000000000000000000000000
      9F199F199F199F199F19000000000000000000000000000000009F199F199F19
      9F199F19000000000000000000000000000000000064667E007C004C00000000
      00000000000000000064004C000000000000000086318631863186316066FF7F
      F37F000086318631863186310000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000008C4D00648C4D000000000000
      0000000000000000000000000064000000000000000000000000000060666066
      6066804D00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001F001F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000001F00000000001F00
      000000001F001F00000000000000000000000000000000000000000000000000
      1042396739673967396739673967396700000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000001F00000000001F00
      00001F00000000001F0000000000000000000000000000000000000000000000
      1042F37F1F001F001F001F001F00396700000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000001F00000000001F00
      00001F00000000001F0000000000000000000000000000000000000000000000
      1042FF7FF37FFF7FF37FFF7FF37F39670000000000000000000000007F1A0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009F190000000000000000000000000000000000001F001F001F00
      00001F00000000001F0000000000000000000000104239673967396739673967
      1042F37F1F001F001F001F001F003967000000000000000000007F1A7F1A0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F1A9F1900000000000000000000000000000000000000001F00
      00001F001F001F000000000000000000000000001042FF7FD300D300D300D300
      1042FF7FF37FFF7FF37FFF7F3967396700000000000000007F1A3F1B7F1A7F1A
      7F1A7F1A7F1A7F1A7F1A7F1A000000000000000000009F197F1A7F1A7F1A7F1A
      7F1A7F1A7F1A7F1A3F1B9F190000000000000000000000000000000000001F00
      00001F00000000000000000000000000000000001042F37FFF7FF37FFF7FF37F
      1042FF7F9F199F19FF7F0000000000000000000000009F19FF4FFF4FFF4FFF4F
      FF4FFF4FFF4FFF4FFF4F7F1A000000000000000000009F19FF67FF67FF67FF67
      FF67FF67FF67FF67FF4F3F1B0000000000000000000000000000000000000000
      00000000000000000000000000000000000000001042FF7FD300D300D300D300
      1042FF7FFF7FFF7FF37F1042FF7F000000000000000000009F19FF4FFF4F0000
      9F199F199F199F199F199F19000000000000000000009F199F199F199F199F19
      9F199F199F19FF673F1B00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000001042F37FFF7FF37FFF7FF37F
      1042FF7FFF7FFF7FFF7F104200000000000000000000000000009F19FF4F0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000009F193F1B000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000001042FF7FD300D300FF7F0000
      104210421042104210421042000000000000000000000000000000009F190000
      0000000000000000000000000000000000000000000000000000000000000000
      000000009F190000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000001042FF7FFF7FFF7FF37F1042
      FF7F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000009F190000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000001042FF7FFF7FFF7FFF7F1042
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000104210421042104210421042
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A514A514A514A514A514A514A514
      A514A514A514A514A514000000000000000000000000000000008031A5148031
      00000000000000000000000000000000000000000000000000008031A5148031
      00000000000000000000000000000000000000000000000000008031A5148031
      0000000000000000000000000000000000001042186318631863186318631863
      1863186318631863A51400000000000000000000A514A5140000803100428031
      0000A514A5140000000000000000000000000000A514A5140000803100428031
      0000A514A5140000000000000000000000000000A514A5140000803100428031
      0000A514A5140000000000000000000000001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7F1863A5140000000000000000000000420042A51480312C670042
      A51400422C67803100000000000000000000000000420042A51480312C670042
      A51400422C67803100000000000000000000000000420042A51480312C670042
      A51400422C678031000000000000000000001042FF7FFF7F0040FF7FFF7FFF7F
      00020002FF7F1863A51400000000000000000000A514F97F00428031F97F0042
      0042F97F8031A514000000000000000000000000A514F97F00428031F97F0042
      0042F97F8031A514000000000000000000000000A514F97F00428031F97F0042
      0042F97F8031A514000000000000000000001042FF7F0040007C0040FF7F0002
      FF031F00FF7F1863A51439673967396700008031604EA514F97FF37FF37FF37F
      F37FA514004280312C672C672C672C6700008031604EA514F97FF37FF37FF37F
      F37FA514004280312C672C672C67803100008031604EA514F97FF37FF37FF37F
      F37FA51400428031396739673967396700001042FF7FFF7FE07F0040FF7FFF7F
      1F00FF7FFF7F1863A514F37FFF7F3967000080312C67F97F2C67604E2925604E
      F97FF37FF97F8031337F337F337F2C67000080312C67F97F2C67604E2925604E
      F97FF37FF97F8031337FF37F2C678031000080312C67F97F2C67604E2925604E
      F97FF37FF97F8031FF7FF37FFF7F396700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7F1863A514FF7FF37F39670000604E604EF37F604E1042FF7F2925
      604E2C67604E604EF37F337F337F2C670000604E604EF37F604E1042FF7F2925
      604E2C67604E604EF37F337F80312C670000604E604EF37F604E1042FF7F2925
      604E2C67604E604EF37FFF7FF37F396700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7F1863A514F37FFF7F396700000000A514604EF97F1042FF7F4A29
      2C67604E8031F37F337FF37F337F2C6700000000A514604EF97F1042FF7F4A29
      2C67604E8031F37F337F2C6780312C6700000000A514604EF97F1042FF7F4A29
      2C67604E8031F37FFF7FF37FFF7F396700001042CE391042CE391042CE391042
      1042104210421042A514FF7FF37F3967000000008031F97FA5141042FF7F2925
      A5142C678031337FF37F337FF37F2C6700002C678031F97FA5141042FF7F2925
      A5142C678031337FF37F80312C672C67000000008031F97FA5141042FF7F2925
      A5142C678031FF7FF37FFF7FF37F3967000010423F333F333F333F333F333F1B
      7F327F329F31DF18A514F37FFF7F39670000000080318031F37F186310421042
      F37F80318031F37F337FF37F337F2C6700002C6780318031F97F186310421042
      F97F80318031F97F2C678031337F2C6700000000803180310000186310421042
      FF7F80318031F37FFF7FF37FFF7F396700001042104210421042104210421042
      1042104210421042A514FF7FF37F396700000000604EF97FF37FF37FF37FF37F
      F37FF37FF37F337FF37F337FF37F2C6700002C672C672C672C672C672C672C67
      2C672C672C672C672C672C67F37F2C670000000000000000000000001042FF7F
      FF7FFF7FF37FFF7FF37FFF7FF37F39670000000000000000000000001042FF7F
      FF7FFF7FFF7FF37FFF7FF37F3967396700000000604EF97FF37FF37FF37FF37F
      F37FF37FF37FF37FF37FF37F337F2C6700000000604EF97FF37FF37FF37FF37F
      F37FF37FF37FF37FF37FF37F337F2C670000000000000000000000001042FF7F
      FF7FFF7FFF7FF37FFF7FF37F396739670000000000000000000000001042FF7F
      FF7FFF7FFF7FFF7FF37F00000000000000000000604EF97FF97FF97FF97FF97F
      F97FF97FF97FF97FF97FF97FF37F2C6700000000604EF97FF97FF97FF97FF97F
      F97FF97FF97FF97FF97FF97FF37F2C670000000000000000000000001042FF7F
      FF7FFF7FFF7FFF7FF37F0000000000000000000000000000000000001042FF7F
      FF7FFF7FFF7FFF7FFF7F1042FF7F000000000000604E2C672C672C672C672C67
      2C672C67604E604E604E604E604E604E00000000604E2C672C672C672C672C67
      2C672C67604E604E604E604E604E604E0000000000000000000000001042FF7F
      FF7FFF7FFF7FFF7FFF7F1042FF7F00000000000000000000000000001042FF7F
      FF7FFF7FFF7FFF7FFF7F104200000000000000000000604EDE7BF97FF97FF37F
      F37F604E000000000000000000000000000000000000604EDE7BF97FF97FF37F
      F37F604E0000000000000000000000000000000000000000000000001042FF7F
      FF7FFF7FFF7FFF7FFF7F10420000000000000000000000000000000010421042
      104210421042104210421042000000000000000000000000604E604E604E604E
      604E00000000000000000000000000000000000000000000604E604E604E604E
      604E000000000000000000000000000000000000000000000000000010421042
      1042104210421042104210420000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A514A514A514A514A514A514A514
      A514A514A514A514A5140000000000000000A514A514A514A514A514A514A514
      A514A514A514A514A51400000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001042186318631863186318631863
      1863186318631863A51400000000000000001042186318631863186318631863
      1863186318631863A51400000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7F1863A51400000000000000001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7F1863A51400000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001042FF7FFF7F0040FF7FFF7FFF7F
      00020002FF7F1863A51400000000000000001042FF7FFF7F0040FF7FFF7FFF7F
      00020002FF7F1863A5140000000000000000604EF97F2C672C672C672C672C67
      2C672C672C672C672C672C672C6700000000000000002C672C672C672C672C67
      2C672C672C672C672C672C672C67803100001042FF7F0040007C0040FF7F0002
      FF031F00FF7F1863A5142C672C672C6700001042FF7F0040007C0040FF7F0002
      FF031F00FF7F1863A5142C672C6780310000604EF97FF37FF37F337FF37F337F
      F37F337FF37F337F337F337F2C6700000000000000002C67F97FF37FF37FF37F
      337FF37F337FF37F337FF37F2C67803100001042FF7FFF7FE07F0040FF7FFF7F
      1F00FF7FFF7F1863A514337F337F2C6700001042FF7FFF7FE07F0040FF7FFF7F
      1F00FF7FFF7F1863A514F37F2C6780310000604EF97FF37FF37FF37F337FF37F
      337FF37F337FF37F337F337F2C670000000000002C67F97FF37FF37FF37FF37F
      F37F337FF37F337FF37F337F80312C6700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7F1863A514337F337F2C6700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7F1863A514337F80312C670000604EF97FF37FF37FF37FF37F337F
      F37F337FF37F337FF37F337F2C670000000000002C67F97FF37FF37FF37FF37F
      337FF37F337FF37F337F2C6780312C6700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7F1863A514F37F337F2C6700001042FF7FFF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7F1863A5142C6780312C670000604EF97FF37FF37FF37FF37FF37F
      337FF37F337FF37F337FF37F2C67000000002C67F97FF37FF37FF37FF37FF37F
      F37FF37FF37F337FF37F80312C672C6700001042CE391042CE391042CE391042
      1042104210421042A514337FF37F2C6700001042CE391042CE391042CE391042
      1042104210421042A51480312C672C670000604EF97FF37FF37FF37FF37FF37F
      F37F337FF37F337FF37F337F2C67000000002C67F97FF97FF97FF97FF97FF97F
      F97FF97FF97FF97F2C678031337F2C67000010423F333F333F333F333F333F1B
      7F327F329F31DF18A514F37F337F2C67000010423F333F333F333F333F333F1B
      7F327F329F31DF18A5148031337F2C670000604EF97FF37FF37FF37FF37FF37F
      F37FF37F337FF37F337FF37F2C67000000002C672C672C672C672C672C672C67
      2C672C672C672C672C672C67F37F2C6700001042104210421042104210421042
      1042104210421042A514337FF37F2C6700001042104210421042104210421042
      1042104210421042A5142C67F37F2C670000604EF97FF37FF37FF37FF37FF37F
      F37FF37FF37FF37FF37F337F2C67000000000000604EF97FF37FF37FF37FF37F
      F37FF37FF37FF37FF37FF37F337F2C6700000000604EF97FF37FF37FF37FF37F
      F37FF37FF37FF37FF37FF37F337F2C6700000000604EF97FF37FF37FF37FF37F
      F37FF37FF37FF37FF37FF37F337F2C670000604EF97FF97FF97FF97FF97FF97F
      F97FF97FF97FF97FF97FF37F2C67000000000000604EF97FF97FF97FF97FF97F
      F97FF97FF97FF97FF97FF97FF37F2C6700000000604EF97FF97FF97FF97FF97F
      F97FF97FF97FF97FF97FF97FF37F2C6700000000604EF97FF97FF97FF97FF97F
      F97FF97FF97FF97FF97FF97FF37F2C670000604E2C672C672C672C672C672C67
      2C67604E604E604E604E604E604E000000000000604E2C672C672C672C672C67
      2C672C67604E604E604E604E604E604E00000000604E2C672C672C672C672C67
      2C672C67604E604E604E604E604E604E00000000604E2C672C672C672C672C67
      2C672C67604E604E604E604E604E604E00000000604EDE7BF97FF97FF37FF37F
      604E0000000000000000000000000000000000000000604EDE7BF97FF97FF37F
      F37F604E000000000000000000000000000000000000604EDE7BF97FF97FF37F
      F37F604E000000000000000000000000000000000000604EDE7BF97FF97FF37F
      F37F604E000000000000000000000000000000000000604E604E604E604E604E
      000000000000000000000000000000000000000000000000604E604E604E604E
      604E00000000000000000000000000000000000000000000604E604E604E604E
      604E00000000000000000000000000000000000000000000604E604E604E604E
      604E00000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300100000100010000000000800900000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000001FFFFF00000000000FF9FF00000000
      0007F6CF000000000003F6B7000000000001F6B7000000000000F8B700000000
      001FFE8F000000000018FE3F00000000001CFF7F00000000003AFE3F00000000
      0007FEBF00000000001FFC9F0000000003F8FDDF0000000003FCFDDF00000000
      03BAFDDF00000000FFC7FFFF00000000FFFFFFFFFFFFFFFFF000F000800FE000
      F000F0008007C000000000000003800000000000000180000000000000008000
      0000000000000000000000000007800000000000000780000000000000078000
      000000000000800082000000821CC000F000C100FFBAC000F0018001FFC7C000
      F0032003FFFFC000F007E007FFFFFFFFFFFFFFFFFFFFFFFFF000F000F000F000
      F000F000F000F000F000F000F000F000F000F000F000F000F000F000F000F000
      F000F000F000F000F000F000F000F000F000E000F000E000F000E000F000E000
      F000F000F000F000F0008000F0008000F000E000F000E000F001C001F001C001
      F0039003F0039003F007F007F007F007FFFFFFFFFFFFFFFFFC00FC00FC00FC00
      F000F000F000F000E000E000E000E000E000E000E000E000C000C000C000C000
      C000C000C000C000C000C000C000C000C000C000C000C000C000C000C000C000
      C000C000C000C000E0010001E0010001E001C001E001C001F0038003F0038003
      FC0F200FFC0F200FFFFFE9FFFFFFE9FFFFFFFFFFFFFFFFFFFC7FF800F000F000
      F81FF000F000F000F007E000F000F000E001C000F000F000C0008000F000F000
      80018000F000F00000018000F000F00000008000F000F00000018000F000E000
      00038000F000E00000070001F000F000800F8107F0008000801F8047F001E001
      203F03FFF003C003E87FE9FFF0079007FFFFFFFFFFFFFFFFFFFFFFFFFC7FF800
      FFFFFFFFF81FF000FFFFFFFFF007E000FFFFFFFFE001C000F00FFE7FC0008000
      F3CFFC3F80018000FBDFFDBF00018000F99FF99F00008000FDBFFBDF00018000
      FC3FF3CF00038000FE7FF00F00078001FFFFFFFF800F8307FFFFFFFFE01F83C7
      FFFFFFFFF83FC7FFFFFFFFFFFE7FEFFFFFFFFFFFFFFFFE7F883FFC1FC003F83F
      D73FF007C003E01FE0C0E003C003800FE000C001C00300078000C001C0030003
      80008000C003000180008000C003000000008000C003000000008000C0038001
      8000C001C003C0010000C001C003E0010000E003C007F0010001F007C00FF807
      8003FC1FC01FFC1FF807FFFFFFFFFE7FFC1F803FF800F8000807001FF800F800
      000080018000E0000000C0000001C001000080010001C0010000800300018001
      0000000100018000000000010000000000000001000000000000000000000000
      800000000000800080008001000080008001C00000018001C07FE0008003C003
      E0FFFE00C007E007FFFFFF01FFFFFFFFFFC7FF0F8001FE0F0003FC0700018403
      0003F007000180000003C007000180000003C003000180000003C00300018000
      0003800300018000000380030001800000038001000180008187800100018000
      C3C7000100038000FE440001800F8000FC000003C01F8001FC00000FFE0FC07F
      FC01C03FFE0FE0FFFE43F0FFFF1FFFFFFFFFFFFFFFFFFFFFFF80F001F001FE01
      FF80F001F001FE01DF80F001F001FE01CF80F001F001FE018400F0010001C001
      4C0000010001C0035C0000010001000F7C0100030003007F7C07001F007F007F
      BC07001B007B007BFC07001100710071FC0F000000600060FFFF003B00FB007B
      FFFF87C701C701C7FFFFFFFF03FF01FFFFFFFFFFFFFFFFFF00000001000FFC00
      00000001000FFC0000000001000FDC0000000001000FCC0000000001000F8400
      00000001000D4C0000000001000B5C000000000100077C000000000100027C00
      0000000181C7B40100000001C3ABF803000080FFFF7DF0070000C1FFFFEFF8FF
      0000FFFFFFFFF57FFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFC007000000000000
      8003000000000000000100000000000000010000000000000001000000000000
      000000000000000000000000000000008000000000000000C000000000000000
      E001000000000000E007000000000000F007000000000000F003000000000000
      F803000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFF3FF3F000FF9FFFFE1FE1F
      000FF9FFFFC1FC1F000FF3C7FF83C03F000F73C7F0078077000F27FFC00F00E7
      000F07C7801F00C1000F00C7801F00E6000F01E3000F00F6000003F1000F81FE
      00000638000FC3BF00000E38000FFFB7F8001E38801FFFB3FC003F01801FFFC1
      FE047F83C03FFFF3FFFFFFFFF0FFFFF7FFFFFFFFFFFFFFE7E003001FC001F000
      E003000F8001F000E00300078001F000E00300038001F000E00300018001C000
      E003000080018000E003001F80010000E003001F80010000E003001F80010000
      E0038FF180010000E007FFF980010000E00FFF7580018000E01FFF8F8001C001
      FFFFFFFF8001F003FFFFFFFFFFFFF007FFFFFFFFFFFFFFFFFE00FFFFFFFFDFFB
      8000FFFFFFFF8FFF0000FFE3C7FF87F7000001E3C780C7EF000003E187C0E3CF
      000107F18FE0F19F000307F18FE0F83F000303F18FC0FC7F000320E18704F83F
      00037003C00EF19F0003F807E01FC3CF0003FE0FF07F87E78007FFFFFFFF8FFB
      F87FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3FFFE00
      FFFFFFFFED9FFE00FDFFFFBFED6FFE00F9FFFF9FED6F8000F1FFFF8FF16F8000
      E003C007FD1F8000C003C003FC7F8000C003C003FEFF8001E003C007FC7F8003
      F1FFFF8FFD7F8007F9FFFF9FF93F807FFDFFFFBFFBBF80FFFFFFFFFFFBBF81FF
      FFFFFFFFFBBFFFFFFFFFFFFFFFFFFFFF000FF1FFF1FFF1FF000F913F913F913F
      000F801F801F801F000080008000800000000000000000000000000000000000
      0000000000000000000080008000800000008000000080000000800000009000
      000080000000F800F80080008000F800F80080008000F800F80180018001F801
      F803C07FC07FF803F807E0FFE0FFF807FFFFFFFF000F000FFFFFFFFF000F000F
      FFFFFFFF000F000F8001E000000000000001C000000000000001C00000000000
      0001800000000000000180000000000000010000000000000001000000000000
      0001000000000000000180008000800000018000800080000003800180018001
      80FFC07FC07FC07FC1FFE0FFE0FFE0FF00000000000000000000000000000000
      000000000000}
  end
  object popEdit: TSpTBXPopupMenu
    Images = il16
    OnPopup = popEditPopup
    Left = 38
    Top = 158
    object Undo1: TSpTBXItem
      Action = acUndo
      CaptionW = 'Undo'
      HintW = 'Undo last edit'
    end
    object N13: TSpTBXSeparatorItem
    end
    object Cut1: TSpTBXItem
      Action = acCut
      CaptionW = 'Cut'
      HintW = 'Cut selected text'
    end
    object Copy1: TSpTBXItem
      Action = acCopy
      CaptionW = 'Copy'
      HintW = 'Copy selected text'
    end
    object Paste1: TSpTBXItem
      Action = acPaste
      CaptionW = 'Paste'
      HintW = 'Paste from clipboard'
    end
    object N14: TSpTBXSeparatorItem
    end
    object TBItem54: TSpTBXItem
      Action = acReplaceEverywhere
      CaptionW = 'Use this translation everywhere'
      HintW = 'Use this translation everywhere'
    end
    object SelectAll1: TSpTBXItem
      Action = acSelectAll
      CaptionW = 'Select All'
      HintW = 'Select all text'
    end
    object TBSeparatorItem9: TSpTBXSeparatorItem
    end
    object TBItem17: TSpTBXItem
      Action = acAsciiValues
      CaptionW = 'ASCII Value(s)...'
      HintW = 'Show the ASCII values for the selected text'
    end
    object TBXSeparatorItem6: TSpTBXSeparatorItem
    end
    object smiDictionary: TSpTBXSubmenuItem
      CaptionW = 'Dictionary'
    end
  end
  object popList: TSpTBXPopupMenu
    Images = il16
    Left = 78
    Top = 158
    object TBItem20: TSpTBXItem
      Action = acCopyFromOriginal
      CaptionW = 'Copy from Original'
      HintW = 'Copy the value of Original to Translation'
    end
    object TBItem21: TSpTBXItem
      Action = acCopyFromName
      CaptionW = 'Copy from Name'
      HintW = 'Copy the value of Name to Translation'
    end
    object TBXItem7: TSpTBXItem
      Action = acDictAdd
      CaptionW = 'Add to Dictionary'
      HintW = 'Add current item to the dictionary'
    end
    object TBSeparatorItem14: TSpTBXSeparatorItem
    end
    object TBItem24: TSpTBXItem
      Action = acNextUntranslated
      CaptionW = 'Next untranslated'
      HintW = 'Go to next untranslated item'
    end
    object TBItem25: TSpTBXItem
      Action = acPrevUntranslated
      CaptionW = 'Prev untranslated'
      HintW = 'Go to previous untranslated item'
    end
    object TBSeparatorItem11: TSpTBXSeparatorItem
    end
    object TBItem53: TSpTBXItem
      Action = acClearAllTranslations
      CaptionW = 'Clear All Translations'
      HintW = 'Clear the translated text'
    end
    object TBItem52: TSpTBXItem
      Action = acReplaceEverywhere
      CaptionW = 'Use this translation everywhere'
      HintW = 'Use this translation everywhere'
    end
    object TBXSeparatorItem5: TSpTBXSeparatorItem
    end
    object TBXItem5: TSpTBXItem
      Action = acToggleTranslated
      CaptionW = 'Translated'
      HintW = 'Toggle the Translated status of the item'
    end
    object TBXSeparatorItem7: TSpTBXSeparatorItem
    end
    object TBXItem12: TSpTBXItem
      Action = acAddItem
      CaptionW = 'Add Item...'
      HintW = 'Add new item to original and translation'
    end
    object TBXItem11: TSpTBXItem
      Action = acEditItem
      CaptionW = 'Edit Item...'
      HintW = 'Edit all parts of the current item'
    end
    object TBXItem9: TSpTBXItem
      Action = acDeleteItem
      CaptionW = 'Delete Item...'
      HintW = 'Delete the current item from both original and translation'
    end
  end
  object MRUFiles: TTBXMRUList
    HidePathExtension = False
    MaxItems = 10
    OnClick = MRUFilesClick
    Prefix = 'MRU'
    Left = 118
    Top = 122
  end
  object ilBookmarks: TImageList
    AllocBy = 24
    Height = 15
    Width = 12
    Left = 118
    Top = 192
    Bitmap = {
      494C01010B000E0004000C000F00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000300000003C00000001001000000000008016
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000186310020002100200021002
      0002100200000000000000001863100200021002000210020002100200000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000186300021002000000000000
      1002000200001042000000001863000210020002100200020000000200001042
      000000000000000000000106C001C00100010000000000000000000000000000
      0000000000000000000000000000000000000000186310020000100200021002
      0000100200001042000000001863100200021002000210020000100200001042
      00000000000000002412C001420AA00140018311E10C00000000000000000000
      0000000000000000000000000000000000000000186300020000000210020002
      0000000200001042000000001863000210020002100200020000000200001042
      000000000000C209E205640A00020002E1058005621100000000000000000000
      0000000000000000000000000000000000000000186310020000100200021002
      0000100200001042000000001863100200020000000010020000100200001042
      000000002F3B0612A91AC81222024302220AE109600500010000000000000000
      0000000000000000000000000000000000000000186310021002000000000000
      1002000200001042000000001863000200000002100200000000000200001042
      00000000CF368C26CD22EC1A2C1BE9160102220AA00140010000000000000000
      0000000000000000000000000000000000000000186310020000100200021002
      0000100200001042000000001863100200001002000210020000100200001042
      00000000F13A8E2AAF22CF1EAC122D1F0A23C001231280010000000000000000
      0000000000000000000000000000000000000000186300020000000210020002
      0000000200001042000000001863000200000002100200020000000200001042
      00000000D13EB136902AB743D63FED22CA222412A00524160000000000000000
      0000000000000000000000000000000000000000186310020002000000000000
      0002100200001042000000001863100200020000000000000002100200001042
      00000000565B6F36B132FD5FB7478C22AB2AA20DC31500000000000000000000
      0000000000000000000000000000000000000000186300021002000210020002
      1002000200001042000000001863000210020002100200021002000200001042
      000000000000555BD23E6F2A6E2ACF32AC36E621000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001042000000000000000000000000000000000000000000001042
      00000000000000005553F23ED136F13ECE420000000000000000000000000000
      0000000000000000000000000000000000000000000018631863186318631863
      1863186318631042000000000000186318631863186318631863186318631042
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000186310020002100200021002
      0002100200000000000000001863100200021002000210020002100200000000
      0000000018631002000210020002100200021002000000000000000018631002
      0002100200021002000210020000000000000000186300021002000210020000
      1002000200001042000000001863000210020000000000001002000200001042
      0000000018630002100200000000000010020002000010420000000018630002
      1002000200000002100200020000104200000000186310020002100200020000
      0002100200001042000000001863100200001002000210020000100200001042
      0000000018631002000010020002100200001002000010420000000018631002
      0002100200001002000210020000104200000000186300021002000210020000
      1002000200001042000000001863000210020002100200020000000200001042
      0000000018630002000000021002000200000002000010420000000018630002
      1002000200000002100200020000104200000000186310020000000000000000
      0000100200001042000000001863100200021002000210020000100200001042
      0000000018631002000010020002100200001002000010420000000018631002
      0002100200020000000210020000104200000000186300020000000210020000
      1002000200001042000000001863000200000000000000001002000200001042
      0000000018630002000000000000000010020002000010420000000018630002
      1002000210020000100200020000104200000000186310020000100200020000
      0002100200001042000000001863100200001002000210020002100200001042
      0000000018631002000010020002100200021002000010420000000018631002
      0002100200021002000010020000104200000000186300020000000210020000
      1002000200001042000000001863000200000002100200021002000200001042
      0000000018630002000000021002000200000002000010420000000018630002
      0000000210020002000000020000104200000000186310020000100200020000
      0002100200001042000000001863100200000000000000000000100200001042
      0000000018631002000200000000000000021002000010420000000018631002
      0000000000000000000010020000104200000000186300021002000210020002
      1002000200001042000000001863000210020002100200021002000200001042
      0000000018630002100200021002000210020002000010420000000018630002
      1002000210020002100200020000104200000000000000000000000000000000
      0000000000001042000000000000000000000000000000000000000000001042
      0000000000000000000000000000000000000000000010420000000000000000
      0000000000000000000000000000104200000000000018631863186318631863
      1863186318631042000000000000186318631863186318631863186318631042
      0000000000001863186318631863186318631863186310420000000000001863
      1863186318631863186318631863104200000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000186310020002100200021002
      0002100200000000000000001863100200021002000210020002100200000000
      0000000018631002000210020002100200021002000000000000000018631002
      0002100200021002000210020000000000000000186300021002000000000000
      1002000200001042000000001863000200000000000000000000000200001042
      0000000018630002000000000000000000000002000010420000000018630002
      1002000000000000100200020000104200000000186310020000100200021002
      0000100200001042000000001863100200021002000010020002100200001042
      0000000018631002000010020002100200021002000010420000000018631002
      0000100200021002000010020000104200000000186300020000000210020002
      0000000200001042000000001863000210020002000000021002000200001042
      0000000018630002100200001002000210020002000010420000000018630002
      1002000210020002000000020000104200000000186310020000100200021002
      0000100200001042000000001863100200021002000010020002100200001042
      0000000018631002000210020000100200021002000010420000000018631002
      0002100200021002000010020000104200000000186300020000000210020002
      0000000200001042000000001863000210020002000000021002000200001042
      0000000018630002100200021002000010020002000010420000000018630002
      1002000200000000100200020000104200000000186310020000100200021002
      0000100200001042000000001863100200001002000010020002100200001042
      0000000018631002000210020002100200001002000010420000000018631002
      0002100200021002000010020000104200000000186300020000000210020002
      0000000200001042000000001863000210020000000000021002000200001042
      0000000018630002000000021002000200000002000010420000000018630002
      0000000210020002000000020000104200000000186310020002000000000000
      0002100200001042000000001863100200021002000010020002100200001042
      0000000018631002000200000000000000021002000010420000000018631002
      0002000000000000000210020000104200000000186300021002000210020002
      1002000200001042000000001863000210020002100200021002000200001042
      0000000018630002100200021002000210020002000010420000000018630002
      1002000210020002100200020000104200000000000000000000000000000000
      0000000000001042000000000000000000000000000000000000000000001042
      0000000000000000000000000000000000000000000010420000000000000000
      0000000000000000000000000000104200000000000018631863186318631863
      1863186318631042000000000000186318631863186318631863186318631042
      0000000000001863186318631863186318631863186310420000000000001863
      1863186318631863186318631863104200000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      28000000300000003C0000000100010000000000E00100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFF0000000003003FFF0000000001001FFF0000000
      000000F0F0000000000000E030000000000000C0300000000000008010000000
      0000008010000000000000801000000000000080100000000000008030000000
      000000C070000000000000E0F0000000800800FFF0000000C01C01FFF0000000
      FFFFFFFFFFFF0000003003003003000000100100100100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000008008008008000000C01C01C01C010000FFFFFFFFFFFF0000
      0030030030030000001001001001000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8008008008000000C01C01C01C01000000000000000000000000000000000000
      000000000000}
  end
  object alBookmarks: TTntActionList
    Images = ilBookmarks
    OnUpdate = alMainUpdate
    Left = 158
    Top = 158
    object acGotoBookmark1: TTntAction
      Tag = 1
      Category = 'Bookmarks'
      Caption = 'Bookmark 1'
      Hint = 'Goto Bookmark 1'
      ImageIndex = 1
      ShortCut = 16433
      OnExecute = GotoBookmarkExecute
    end
    object acGotoBookmark2: TTntAction
      Tag = 2
      Category = 'Bookmarks'
      Caption = 'Bookmark 2'
      Hint = 'Goto Bookmark 2'
      ImageIndex = 2
      ShortCut = 16434
      OnExecute = GotoBookmarkExecute
    end
    object acGotoBookmark3: TTntAction
      Tag = 3
      Category = 'Bookmarks'
      Caption = 'Bookmark 3'
      Hint = 'Goto Bookmark 3'
      ImageIndex = 3
      ShortCut = 16435
      OnExecute = GotoBookmarkExecute
    end
    object acGotoBookmark4: TTntAction
      Tag = 4
      Category = 'Bookmarks'
      Caption = 'Bookmark 4'
      Hint = 'Goto Bookmark 4'
      ImageIndex = 4
      ShortCut = 16436
      OnExecute = GotoBookmarkExecute
    end
    object acGotoBookmark5: TTntAction
      Tag = 5
      Category = 'Bookmarks'
      Caption = 'Bookmark 5'
      Hint = 'Goto Bookmark 5'
      ImageIndex = 5
      ShortCut = 16437
      OnExecute = GotoBookmarkExecute
    end
    object acGotoBookmark6: TTntAction
      Tag = 6
      Category = 'Bookmarks'
      Caption = 'Bookmark 6'
      Hint = 'Goto Bookmark 6'
      ImageIndex = 6
      ShortCut = 16438
      OnExecute = GotoBookmarkExecute
    end
    object acGotoBookmark7: TTntAction
      Tag = 7
      Category = 'Bookmarks'
      Caption = 'Bookmark 7'
      Hint = 'Goto Bookmark 7'
      ImageIndex = 7
      ShortCut = 16439
      OnExecute = GotoBookmarkExecute
    end
    object acGotoBookmark8: TTntAction
      Tag = 8
      Category = 'Bookmarks'
      Caption = 'Bookmark 8'
      Hint = 'Goto Bookmark 8'
      ImageIndex = 8
      ShortCut = 16440
      OnExecute = GotoBookmarkExecute
    end
    object acGotoBookmark9: TTntAction
      Tag = 9
      Category = 'Bookmarks'
      Caption = 'Bookmark 9'
      Hint = 'Goto Bookmark 9'
      ImageIndex = 9
      ShortCut = 16441
      OnExecute = GotoBookmarkExecute
    end
    object acGotoBookmark0: TTntAction
      Category = 'Bookmarks'
      Caption = 'Bookmark 0'
      Hint = 'Goto Bookmark 0'
      ImageIndex = 0
      ShortCut = 16432
      OnExecute = GotoBookmarkExecute
    end
    object acToggleBookmark1: TTntAction
      Tag = 1
      Category = 'Bookmarks'
      Caption = 'Bookmark 1'
      Hint = 'Toggle Bookmark 1 on/off'
      ImageIndex = 1
      ShortCut = 24625
      OnExecute = ToggleBookmarkExecute
    end
    object acToggleBookmark2: TTntAction
      Tag = 2
      Category = 'Bookmarks'
      Caption = 'Bookmark 2'
      Hint = 'Toggle Bookmark 2 on/off'
      ImageIndex = 2
      ShortCut = 24626
      OnExecute = ToggleBookmarkExecute
    end
    object acToggleBookmark3: TTntAction
      Tag = 3
      Category = 'Bookmarks'
      Caption = 'Bookmark 3'
      Hint = 'Toggle Bookmark 3 on/off'
      ImageIndex = 3
      ShortCut = 24627
      OnExecute = ToggleBookmarkExecute
    end
    object acToggleBookmark4: TTntAction
      Tag = 4
      Category = 'Bookmarks'
      Caption = 'Bookmark 4'
      Hint = 'Toggle Bookmark 4 on/off'
      ImageIndex = 4
      ShortCut = 24628
      OnExecute = ToggleBookmarkExecute
    end
    object acToggleBookmark5: TTntAction
      Tag = 5
      Category = 'Bookmarks'
      Caption = 'Bookmark 5'
      Hint = 'Toggle Bookmark 5 on/off'
      ImageIndex = 5
      ShortCut = 24629
      OnExecute = ToggleBookmarkExecute
    end
    object acToggleBookmark6: TTntAction
      Tag = 6
      Category = 'Bookmarks'
      Caption = 'Bookmark 6'
      Hint = 'Toggle Bookmark 6 on/off'
      ImageIndex = 6
      ShortCut = 24630
      OnExecute = ToggleBookmarkExecute
    end
    object acToggleBookmark7: TTntAction
      Tag = 7
      Category = 'Bookmarks'
      Caption = 'Bookmark 7'
      Hint = 'Toggle Bookmark 7 on/off'
      ImageIndex = 7
      ShortCut = 24631
      OnExecute = ToggleBookmarkExecute
    end
    object acToggleBookmark8: TTntAction
      Tag = 8
      Category = 'Bookmarks'
      Caption = 'Bookmark 8'
      Hint = 'Toggle Bookmark 8 on/off'
      ImageIndex = 8
      ShortCut = 24632
      OnExecute = ToggleBookmarkExecute
    end
    object acToggleBookmark9: TTntAction
      Tag = 9
      Category = 'Bookmarks'
      Caption = 'Bookmark 9'
      Hint = 'Toggle Bookmark 9 on/off'
      ImageIndex = 9
      ShortCut = 24633
      OnExecute = ToggleBookmarkExecute
    end
    object acToggleBookmark0: TTntAction
      Category = 'Bookmarks'
      Caption = 'Bookmark 0'
      Hint = 'Toggle Bookmark 0 on/off'
      ImageIndex = 0
      ShortCut = 24624
      OnExecute = ToggleBookmarkExecute
    end
  end
  object ThemeSwitcher: TTBXSwitcher
    Theme = 'Default'
    Left = 78
    Top = 122
  end
  object MainFontDlg: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    Options = [fdAnsiOnly, fdNoSimulations, fdNoVectorFonts]
    OnApply = MainFontDlgApply
    Left = 38
    Top = 122
  end
end
