object frmOptions: TfrmOptions
  Left = 316
  Top = 175
  ActiveControl = chkShowQuotes
  BorderStyle = bsDialog
  Caption = 'Preferences'
  ClientHeight = 371
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  DesignSize = (
    444
    371)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TTntLabel
    Left = 16
    Top = 217
    Width = 51
    Height = 13
    Anchors = [akLeft, akRight, akBottom]
    Caption = '&Language:'
    FocusControl = edLanguage
  end
  object Label2: TTntLabel
    Left = 16
    Top = 265
    Width = 25
    Height = 13
    Anchors = [akLeft, akRight, akBottom]
    Caption = '&Help:'
    FocusControl = edHelp
  end
  object Bevel1: TBevel
    Left = -4
    Top = 168
    Width = 435
    Height = 3
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Bevel2: TBevel
    Left = 4
    Top = 321
    Width = 435
    Height = 3
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
  end
  object btnOK: TTntButton
    Left = 265
    Top = 337
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 20
  end
  object btnCancel: TTntButton
    Left = 349
    Top = 337
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 21
  end
  object chkShowQuotes: TTntCheckBox
    Left = 8
    Top = 12
    Width = 202
    Height = 17
    Hint = 'Enclose strings in quote characters when editing them'
    Caption = 'Show &quotes'
    TabOrder = 0
  end
  object chkInvertDictionary: TTntCheckBox
    Left = 8
    Top = 31
    Width = 202
    Height = 17
    Hint = 'Switch order of the items in the dictionary'
    Caption = 'In&vert dictionary'
    TabOrder = 1
  end
  object btnFont: TTntButton
    Left = 356
    Top = 184
    Width = 80
    Height = 23
    Hint = 'Select a new font for the list and edit fields'
    Anchors = [akRight, akBottom]
    Caption = '&Font...'
    TabOrder = 15
    OnClick = btnFontClick
  end
  object chkShowDetails: TTntCheckBox
    Left = 8
    Top = 48
    Width = 202
    Height = 17
    Hint = 'Show the details panel in the main window'
    Caption = 'Sho&w details'
    TabOrder = 2
  end
  object chkShowToolTips: TTntCheckBox
    Left = 8
    Top = 67
    Width = 202
    Height = 17
    Hint = 'Show tooltips windows'
    Caption = 'Show &tooltips:'
    TabOrder = 3
    OnClick = chkShowToolTipsClick
  end
  object chkShowShortCuts: TTntCheckBox
    Left = 24
    Top = 86
    Width = 186
    Height = 17
    Hint = 'Show shortcuts in tooltips windows'
    Caption = 'Show short&cuts in tooltips'
    Enabled = False
    TabOrder = 4
  end
  object chkReturnToSave: TTntCheckBox
    Left = 214
    Top = 12
    Width = 223
    Height = 17
    Hint = 'Save the current edits when pressing RETURN'
    Caption = 'Press &RETURN to confirm translation:'
    TabOrder = 8
    OnClick = chkReturnToSaveClick
  end
  object chkMoveToNext: TTntCheckBox
    Left = 230
    Top = 31
    Width = 207
    Height = 17
    Hint = 
      'Move to the next item when pressing RETURN (press Shift+RETURN t' +
      'o move to the previous item)'
    Caption = 'A&utomatically move to next/previous'
    Enabled = False
    TabOrder = 9
  end
  object edLanguage: TTntEdit
    Left = 16
    Top = 236
    Width = 394
    Height = 21
    Hint = 'Select a language file for the program'
    Anchors = [akLeft, akRight, akBottom]
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvRaised
    BorderStyle = bsNone
    TabOrder = 16
  end
  object btnLanguage: TTntButton
    Left = 413
    Top = 238
    Width = 19
    Height = 19
    Anchors = [akRight, akBottom]
    Caption = '...'
    TabOrder = 17
    OnClick = btnLanguageClick
  end
  object edHelp: TTntEdit
    Left = 16
    Top = 284
    Width = 394
    Height = 21
    Hint = 'Select a file that is to be openend when F1 is pressed'
    Anchors = [akLeft, akRight, akBottom]
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvRaised
    BorderStyle = bsNone
    TabOrder = 18
  end
  object btnHelp: TTntButton
    Left = 413
    Top = 286
    Width = 19
    Height = 19
    Anchors = [akRight, akBottom]
    Caption = '...'
    TabOrder = 19
    OnClick = btnHelpClick
  end
  object chkSavePosition: TTntCheckBox
    Left = 214
    Top = 48
    Width = 223
    Height = 17
    Hint = 'Remember location of main window'
    Caption = 'Remember form &position:'
    TabOrder = 10
    OnClick = chkSavePositionClick
  end
  object chkSaveMinMax: TTntCheckBox
    Left = 230
    Top = 67
    Width = 207
    Height = 17
    Hint = 'Remember whether main window was minimized /maximized'
    Caption = 'Remember form min/ma&x state'
    TabOrder = 11
  end
  object chkGlobalPath: TTntCheckBox
    Left = 8
    Top = 123
    Width = 202
    Height = 17
    Hint = 
      'When a file is opened, set the new folder as the start folder fo' +
      'r all file open and save dialogs'
    Caption = 'Use sa&me start folder for all files'
    TabOrder = 6
  end
  object pnlFontPreview: TTntPanel
    Left = 16
    Top = 184
    Width = 330
    Height = 25
    Anchors = [akLeft, akRight, akBottom]
    BevelOuter = bvLowered
    TabOrder = 22
  end
  object chkMonitorFiles: TTntCheckBox
    Left = 214
    Top = 86
    Width = 223
    Height = 17
    Hint = 
      'Continually check whether the currently loaded files are being m' +
      'odified outside the program'
    Caption = 'Monitor external file &changes'
    TabOrder = 12
    OnClick = chkSavePositionClick
  end
  object chkDictIgnoreSpeedKey: TTntCheckBox
    Left = 8
    Top = 104
    Width = 202
    Height = 17
    Hint = 
      'When translating with the dictionary, strip out any &'#39's in the o' +
      'riginal text before comparing'
    Caption = 'I&gnore &&'#39's in dictionaries'
    TabOrder = 5
    OnClick = chkSavePositionClick
  end
  object chkShowFullNames: TTntCheckBox
    Left = 214
    Top = 104
    Width = 225
    Height = 17
    Hint = 
      'Enable to show the full path and filename of the loaded files in' +
      ' the listview'#39's columns header'
    Caption = 'Sh&ow full filename in list columns'
    TabOrder = 13
  end
  object chkUseTranslationEverywhere: TTntCheckBox
    Left = 214
    Top = 123
    Width = 225
    Height = 17
    Hint = 
      'When a translation is made, copies the translation to all other ' +
      'matching items automatically'
    Caption = 'Use translation ever&ywhere'
    TabOrder = 14
  end
  object chkAutoFocusTranslation: TTntCheckBox
    Left = 8
    Top = 144
    Width = 433
    Height = 17
    Hint = 
      'When activated, typing in the listview will automatically move f' +
      'ocus to the translation edit field.'
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Autofo&cus translation when typing'
    TabOrder = 7
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    Options = [fdAnsiOnly, fdNoSimulations, fdNoVectorFonts]
    Left = 310
    Top = 176
  end
end
