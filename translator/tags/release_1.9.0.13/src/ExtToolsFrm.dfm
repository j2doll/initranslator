object frmTools: TfrmTools
  Left = 380
  Top = 180
  ActiveControl = lbContents
  BorderStyle = bsDialog
  Caption = 'External Tools'
  ClientHeight = 398
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  DesignSize = (
    418
    398)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 357
    Width = 418
    Height = 41
    Align = alBottom
    Shape = bsTopLine
  end
  object Label1: TTntLabel
    Left = 10
    Top = 13
    Width = 77
    Height = 13
    Caption = 'Me&nu Contents:'
  end
  object lbContents: TTntListBox
    Left = 10
    Top = 29
    Width = 312
    Height = 130
    Style = lbVirtual
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvRaised
    BorderStyle = bsNone
    IntegralHeight = True
    ItemHeight = 13
    PopupMenu = popContents
    TabOrder = 0
    OnClick = lbContentsClick
    OnData = lbContentsData
    OnDataFind = lbContentsDataFind
  end
  object btnOK: TTntButton
    Left = 240
    Top = 366
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 7
    OnClick = btnOKClick
  end
  object btnCancel: TTntButton
    Left = 328
    Top = 366
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 8
  end
  object btnAdd: TTntButton
    Left = 330
    Top = 32
    Width = 80
    Height = 23
    Action = acAdd
    Anchors = [akTop, akRight]
    TabOrder = 1
  end
  object btnDelete: TTntButton
    Left = 330
    Top = 62
    Width = 80
    Height = 23
    Action = acDelete
    Anchors = [akTop, akRight]
    TabOrder = 2
  end
  object btnUp: TTntButton
    Left = 330
    Top = 112
    Width = 80
    Height = 23
    Action = acMoveUp
    Anchors = [akTop, akRight]
    TabOrder = 3
  end
  object btnDown: TTntButton
    Left = 330
    Top = 140
    Width = 80
    Height = 23
    Action = acMoveDown
    Anchors = [akTop, akRight]
    TabOrder = 4
  end
  object pnlEditTool: TTntPanel
    Left = 1
    Top = 174
    Width = 417
    Height = 179
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 5
    DesignSize = (
      417
      179)
    object Label2: TTntLabel
      Left = 10
      Top = 14
      Width = 24
      Height = 13
      Caption = '&Title:'
      FocusControl = edTitle
    end
    object Label3: TTntLabel
      Left = 10
      Top = 42
      Width = 51
      Height = 13
      Caption = '&Command:'
      FocusControl = edCommand
    end
    object Label4: TTntLabel
      Left = 10
      Top = 70
      Width = 56
      Height = 13
      Caption = 'A&rguments:'
      FocusControl = edArguments
    end
    object Label5: TTntLabel
      Left = 10
      Top = 98
      Width = 77
      Height = 13
      Caption = '&Initial Directory:'
      FocusControl = edInitialDir
    end
    object lblShortCut: TTntLabel
      Left = 10
      Top = 126
      Width = 66
      Height = 13
      Caption = 'Shortcut &Key:'
    end
    object edTitle: TTntEdit
      Left = 104
      Top = 9
      Width = 303
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvRaised
      BorderStyle = bsNone
      TabOrder = 0
      OnChange = edTitleChange
    end
    object edCommand: TTntEdit
      Left = 104
      Top = 36
      Width = 275
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvRaised
      BorderStyle = bsNone
      TabOrder = 1
    end
    object edArguments: TTntEdit
      Left = 104
      Top = 63
      Width = 275
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvRaised
      BorderStyle = bsNone
      HideSelection = False
      TabOrder = 3
    end
    object edInitialDir: TTntEdit
      Left = 104
      Top = 91
      Width = 275
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvRaised
      BorderStyle = bsNone
      HideSelection = False
      TabOrder = 5
    end
    object btnCommand: TTntButton
      Left = 387
      Top = 38
      Width = 19
      Height = 19
      Action = acCommand
      Anchors = [akTop, akRight]
      TabOrder = 2
    end
    object btnArguments: TTntBitBtn
      Left = 387
      Top = 65
      Width = 19
      Height = 19
      Action = acArgs
      Anchors = [akTop, akRight]
      TabOrder = 4
      Glyph.Data = {
        76040000424D7604000000000000360400002800000006000000080000000100
        0800000000004000000000000000000000000001000000010000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A60004040400080808000C0C0C0011111100161616001C1C1C00222222002929
        2900555555004D4D4D004242420039393900807CFF005050FF009300D600FFEC
        CC00C6D6EF00D6E7E70090A9AD000000330000006600000099000000CC000033
        00000033330000336600003399000033CC000033FF0000660000006633000066
        6600006699000066CC000066FF00009900000099330000996600009999000099
        CC000099FF0000CC000000CC330000CC660000CC990000CCCC0000CCFF0000FF
        660000FF990000FFCC00330000003300330033006600330099003300CC003300
        FF00333300003333330033336600333399003333CC003333FF00336600003366
        330033666600336699003366CC003366FF003399000033993300339966003399
        99003399CC003399FF0033CC000033CC330033CC660033CC990033CCCC0033CC
        FF0033FF330033FF660033FF990033FFCC0033FFFF0066000000660033006600
        6600660099006600CC006600FF00663300006633330066336600663399006633
        CC006633FF00666600006666330066666600666699006666CC00669900006699
        330066996600669999006699CC006699FF0066CC000066CC330066CC990066CC
        CC0066CCFF0066FF000066FF330066FF990066FFCC00CC00FF00FF00CC009999
        000099339900990099009900CC009900000099333300990066009933CC009900
        FF00996600009966330099336600996699009966CC009933FF00999933009999
        6600999999009999CC009999FF0099CC000099CC330066CC660099CC990099CC
        CC0099CCFF0099FF000099FF330099CC660099FF990099FFCC0099FFFF00CC00
        000099003300CC006600CC009900CC00CC0099330000CC333300CC336600CC33
        9900CC33CC00CC33FF00CC660000CC66330099666600CC669900CC66CC009966
        FF00CC990000CC993300CC996600CC999900CC99CC00CC99FF00CCCC0000CCCC
        3300CCCC6600CCCC9900CCCCCC00CCCCFF00CCFF0000CCFF330099FF6600CCFF
        9900CCFFCC00CCFFFF00CC003300FF006600FF009900CC330000FF333300FF33
        6600FF339900FF33CC00FF33FF00FF660000FF663300CC666600FF669900FF66
        CC00CC66FF00FF990000FF993300FF996600FF999900FF99CC00FF99FF00FFCC
        0000FFCC3300FFCC6600FFCC9900FFCCCC00FFCCFF00FFFF3300CCFF6600FFFF
        9900FFFFCC006666FF0066FF660066FFFF00FF666600FF66FF00FFFF66002100
        A5005F5F5F00777777008686860096969600CBCBCB00B2B2B200D7D7D700DDDD
        DD00E3E3E300EAEAEA00F1F1F100F8F8F800F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FD0AFDFDFDFD
        0000FD0A0AFDFDFD0000FD0A0A0AFDFD0000FD0A0A0A0AFD0000FD0A0A0AFDFD
        0000FD0A0AFDFDFD0000FD0AFDFDFDFD0000FDFDFDFDFDFD0000}
      Layout = blGlyphBottom
    end
    object btnInitDir: TTntBitBtn
      Left = 387
      Top = 93
      Width = 19
      Height = 19
      Action = acDir
      Anchors = [akTop, akRight]
      TabOrder = 6
      Glyph.Data = {
        76040000424D7604000000000000360400002800000006000000080000000100
        0800000000004000000000000000000000000001000000010000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A60004040400080808000C0C0C0011111100161616001C1C1C00222222002929
        2900555555004D4D4D004242420039393900807CFF005050FF009300D600FFEC
        CC00C6D6EF00D6E7E70090A9AD000000330000006600000099000000CC000033
        00000033330000336600003399000033CC000033FF0000660000006633000066
        6600006699000066CC000066FF00009900000099330000996600009999000099
        CC000099FF0000CC000000CC330000CC660000CC990000CCCC0000CCFF0000FF
        660000FF990000FFCC00330000003300330033006600330099003300CC003300
        FF00333300003333330033336600333399003333CC003333FF00336600003366
        330033666600336699003366CC003366FF003399000033993300339966003399
        99003399CC003399FF0033CC000033CC330033CC660033CC990033CCCC0033CC
        FF0033FF330033FF660033FF990033FFCC0033FFFF0066000000660033006600
        6600660099006600CC006600FF00663300006633330066336600663399006633
        CC006633FF00666600006666330066666600666699006666CC00669900006699
        330066996600669999006699CC006699FF0066CC000066CC330066CC990066CC
        CC0066CCFF0066FF000066FF330066FF990066FFCC00CC00FF00FF00CC009999
        000099339900990099009900CC009900000099333300990066009933CC009900
        FF00996600009966330099336600996699009966CC009933FF00999933009999
        6600999999009999CC009999FF0099CC000099CC330066CC660099CC990099CC
        CC0099CCFF0099FF000099FF330099CC660099FF990099FFCC0099FFFF00CC00
        000099003300CC006600CC009900CC00CC0099330000CC333300CC336600CC33
        9900CC33CC00CC33FF00CC660000CC66330099666600CC669900CC66CC009966
        FF00CC990000CC993300CC996600CC999900CC99CC00CC99FF00CCCC0000CCCC
        3300CCCC6600CCCC9900CCCCCC00CCCCFF00CCFF0000CCFF330099FF6600CCFF
        9900CCFFCC00CCFFFF00CC003300FF006600FF009900CC330000FF333300FF33
        6600FF339900FF33CC00FF33FF00FF660000FF663300CC666600FF669900FF66
        CC00CC66FF00FF990000FF993300FF996600FF999900FF99CC00FF99FF00FFCC
        0000FFCC3300FFCC6600FFCC9900FFCCCC00FFCCFF00FFFF3300CCFF6600FFFF
        9900FFFFCC006666FF0066FF660066FFFF00FF666600FF66FF00FFFF66002100
        A5005F5F5F00777777008686860096969600CBCBCB00B2B2B200D7D7D700DDDD
        DD00E3E3E300EAEAEA00F1F1F100F8F8F800F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FD0AFDFDFDFD
        0000FD0A0AFDFDFD0000FD0A0A0AFDFD0000FD0A0A0A0AFD0000FD0A0A0AFDFD
        0000FD0A0AFDFDFD0000FD0AFDFDFDFD0000FDFDFDFDFDFD0000}
      Layout = blGlyphBottom
    end
    object chkPrompt: TTntCheckBox
      Left = 148
      Top = 152
      Width = 133
      Height = 17
      Action = acPrompt
      TabOrder = 9
    end
    object chkWait: TTntCheckBox
      Tag = -1
      Left = 283
      Top = 152
      Width = 126
      Height = 17
      Action = acWait
      TabOrder = 10
    end
    object chkShell: TTntCheckBox
      Left = 14
      Top = 152
      Width = 131
      Height = 17
      Action = acUseShellexecute
      TabOrder = 8
    end
    object btnClear: TTntButton
      Left = 333
      Top = 120
      Width = 75
      Height = 21
      Action = acClear
      Anchors = [akTop, akRight]
      TabOrder = 7
    end
  end
  object btnTest: TTntButton
    Left = 16
    Top = 366
    Width = 80
    Height = 23
    Action = acTest
    Anchors = [akLeft, akBottom]
    TabOrder = 6
  end
  object odCommand: TTntOpenDialog
    Filter = 
      'All Executables (*.exe;*.com;*.pif;*.bat;*.cmd)|*.exe;*.com;*.pi' +
      'f;*.bat;*.cmd|All files (*.*)|*.*'
    Left = 96
    Top = 70
  end
  object popArguments: TSpTBXPopupMenu
    Left = 16
    Top = 40
    object OriginalLine1: TSpTBXItem
      OnClick = ArgumentsClick
      CaptionW = 'Original Line'
    end
    object OriginalText1: TSpTBXItem
      Tag = 1
      OnClick = ArgumentsClick
      CaptionW = 'Original Text'
    end
    object OriginalPath1: TSpTBXItem
      Tag = 2
      OnClick = ArgumentsClick
      CaptionW = 'Original Path'
    end
    object OriginalDirectory1: TSpTBXItem
      Tag = 3
      OnClick = ArgumentsClick
      CaptionW = 'Original Directory'
    end
    object OriginalName1: TSpTBXItem
      Tag = 4
      OnClick = ArgumentsClick
      CaptionW = 'Original Name'
    end
    object OriginalExtension1: TSpTBXItem
      Tag = 5
      OnClick = ArgumentsClick
      CaptionW = 'Original Extension'
    end
    object N1: TSpTBXSeparatorItem
    end
    object ranslationLine1: TSpTBXItem
      Tag = 6
      OnClick = ArgumentsClick
      CaptionW = 'Translation Line'
    end
    object ranslationText1: TSpTBXItem
      Tag = 7
      OnClick = ArgumentsClick
      CaptionW = 'Translation Text'
    end
    object ranslationPath1: TSpTBXItem
      Tag = 8
      OnClick = ArgumentsClick
      CaptionW = 'Translation Path'
    end
    object ranslationDirectory1: TSpTBXItem
      Tag = 9
      OnClick = ArgumentsClick
      CaptionW = 'Translation Directory'
    end
    object ranslationName1: TSpTBXItem
      Tag = 10
      OnClick = ArgumentsClick
      CaptionW = 'Translation Name'
    end
    object ranslationExtension1: TSpTBXItem
      Tag = 11
      OnClick = ArgumentsClick
      CaptionW = 'Translation Extension'
    end
    object N2: TSpTBXSeparatorItem
    end
    object DictionaryPath1: TSpTBXItem
      Tag = 12
      OnClick = ArgumentsClick
      CaptionW = 'Dictionary Path'
    end
    object DictionaryDirectory1: TSpTBXItem
      Tag = 13
      OnClick = ArgumentsClick
      CaptionW = 'Dictionary Directory'
    end
    object DictionaryName1: TSpTBXItem
      Tag = 14
      OnClick = ArgumentsClick
      CaptionW = 'Dictionary Name'
    end
    object DictionaryExtension1: TSpTBXItem
      Tag = 15
      OnClick = ArgumentsClick
      CaptionW = 'Dictionary Extension'
    end
    object TBXSeparatorItem1: TSpTBXSeparatorItem
    end
    object TBItem1: TSpTBXItem
      OnClick = ArgumentsClick
      CaptionW = 'Application Directory'
    end
    object TBXItem2: TSpTBXItem
      Tag = 16
      OnClick = ArgumentsClick
      CaptionW = 'Windows Directory'
    end
    object TBXItem1: TSpTBXItem
      Tag = 17
      OnClick = ArgumentsClick
      CaptionW = 'System Directory'
    end
  end
  object popInitialDir: TSpTBXPopupMenu
    Left = 56
    Top = 40
    object OriginalPath2: TSpTBXItem
      OnClick = InitialDirClick
      CaptionW = 'Original Directory'
    end
    object ranslationPath2: TSpTBXItem
      Tag = 1
      OnClick = InitialDirClick
      CaptionW = 'Translation Directory'
    end
    object DictionaryPath2: TSpTBXItem
      Tag = 2
      OnClick = InitialDirClick
      CaptionW = 'Dictionary Directory'
    end
    object ApplicationPath1: TSpTBXItem
      Tag = 3
      OnClick = InitialDirClick
      CaptionW = 'Application Directory'
    end
    object TBXSeparatorItem2: TSpTBXSeparatorItem
    end
    object TBXItem3: TSpTBXItem
      Tag = 4
      OnClick = InitialDirClick
      CaptionW = 'Windows Directory'
    end
    object TBXItem4: TSpTBXItem
      Tag = 5
      OnClick = InitialDirClick
      CaptionW = 'System Directory'
    end
  end
  object alTools: TTntActionList
    Images = ilTools
    OnUpdate = alToolsUpdate
    Left = 16
    Top = 70
    object acAdd: TTntAction
      Caption = '&Add'
      ShortCut = 45
      OnExecute = acAddExecute
    end
    object acDelete: TTntAction
      Caption = '&Delete'
      OnExecute = acDeleteExecute
    end
    object acMoveUp: TTntAction
      Caption = 'Move &Up'
      OnExecute = acMoveUpExecute
    end
    object acMoveDown: TTntAction
      Caption = 'Move Do&wn'
      OnExecute = acMoveDownExecute
    end
    object acCommand: TTntAction
      Caption = '&...'
      ShortCut = 16397
      OnExecute = acCommandExecute
    end
    object acClear: TTntAction
      Caption = 'C&lear'
      OnExecute = acClearExecute
    end
    object acUseShellexecute: TTntAction
      Caption = 'Use Shell E&xecute'
      OnExecute = acUseShellexecuteExecute
    end
    object acPrompt: TTntAction
      Caption = '&Prompt for arguments'
      OnExecute = acPromptExecute
    end
    object acWait: TTntAction
      Caption = 'Wait for co&mpletion'
      OnExecute = acWaitExecute
    end
    object acTest: TTntAction
      Caption = '&Test'
      OnExecute = acTestExecute
    end
    object acArgs: TTntAction
      ImageIndex = 0
      OnExecute = acArgsExecute
    end
    object acDir: TTntAction
      ImageIndex = 0
      OnExecute = acDirExecute
    end
  end
  object ilTools: TImageList
    Left = 55
    Top = 70
    Bitmap = {
      494C010101000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
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
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FFFF000000000000
      FFFF000000000000FFFF000000000000FFFF000000000000FBFF000000000000
      F9FF000000000000F8FF000000000000F87F000000000000F8FF000000000000
      F9FF000000000000FBFF000000000000FFFF000000000000FFFF000000000000
      FFFF000000000000FFFF00000000000000000000000000000000000000000000
      000000000000}
  end
  object popContents: TSpTBXPopupMenu
    Left = 96
    Top = 40
    object TBXItem8: TSpTBXItem
      Action = acAdd
      CaptionW = '&Add'
    end
    object TBXItem7: TSpTBXItem
      Action = acDelete
      CaptionW = '&Delete'
    end
    object TBXSeparatorItem3: TSpTBXSeparatorItem
    end
    object TBXItem6: TSpTBXItem
      Action = acMoveUp
      CaptionW = 'Move &Up'
    end
    object TBXItem5: TSpTBXItem
      Action = acMoveDown
      CaptionW = 'Move Do&wn'
    end
  end
end
