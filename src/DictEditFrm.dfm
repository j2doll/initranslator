inherited frmDictEdit: TfrmDictEdit
  Caption = 'Edit Dictionary'
  ClientHeight = 452
  ClientWidth = 494
  PixelsPerInch = 96
  TextHeight = 13
  object TntLabel1: TTntLabel
    Left = 8
    Top = 15
    Width = 40
    Height = 13
    Caption = '&Original:'
    FocusControl = cbOriginal
  end
  object TntLabel2: TTntLabel
    Left = 8
    Top = 79
    Width = 62
    Height = 13
    Caption = '&Translations:'
  end
  object TntBevel1: TTntBevel
    Left = 1
    Top = 412
    Width = 492
    Height = 4
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
  end
  object TntLabel3: TTntLabel
    Left = 8
    Top = 424
    Width = 30
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'S&how:'
    FocusControl = cbFilter
  end
  object cbOriginal: TTntComboBox
    Left = 8
    Top = 32
    Width = 473
    Height = 21
    BevelKind = bkFlat
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    OnChange = cbOriginalChange
  end
  object btnAddOriginal: TTntButton
    Left = 296
    Top = 64
    Width = 80
    Height = 23
    Action = acAddOriginal
    Anchors = [akTop, akRight]
    TabOrder = 1
  end
  object btnRemoveOriginal: TTntButton
    Left = 384
    Top = 64
    Width = 80
    Height = 23
    Action = acRemoveOriginal
    Anchors = [akTop, akRight]
    TabOrder = 2
  end
  object lbTranslations: TTntListBox
    Left = 8
    Top = 96
    Width = 473
    Height = 265
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BorderStyle = bsNone
    ItemHeight = 13
    Sorted = True
    TabOrder = 3
    OnClick = lbTranslationsClick
  end
  object edTranslation: TTntEdit
    Left = 8
    Top = 377
    Width = 291
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    BevelKind = bkFlat
    BorderStyle = bsNone
    TabOrder = 4
  end
  object btnAddTranslation: TTntButton
    Left = 312
    Top = 376
    Width = 80
    Height = 23
    Action = acAddTranslation
    Anchors = [akRight, akBottom]
    TabOrder = 5
  end
  object btnRemoveTranslation: TTntButton
    Left = 400
    Top = 376
    Width = 80
    Height = 23
    Action = acRemoveTranslation
    Anchors = [akRight, akBottom]
    TabOrder = 6
  end
  object btnOK: TTntButton
    Left = 312
    Top = 421
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 8
  end
  object btnCancel: TTntButton
    Left = 400
    Top = 421
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 9
  end
  object cbFilter: TTntComboBox
    Left = 48
    Top = 420
    Width = 249
    Height = 21
    BevelKind = bkTile
    Style = csDropDownList
    Anchors = [akLeft, akRight, akBottom]
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 7
    Text = 'All items'
    OnChange = cbFilterChange
    Items.WideStrings = (
      'All items'
      'Items with translations'
      'Items without translations')
  end
  object alDictEdit: TTntActionList
    OnUpdate = alDictEditUpdate
    Left = 192
    Top = 168
    object acAddOriginal: TTntAction
      Caption = 'A&dd'
      OnExecute = acAddOriginalExecute
    end
    object acRemoveOriginal: TTntAction
      Caption = 'Re&move'
      OnExecute = acRemoveOriginalExecute
    end
    object acAddTranslation: TTntAction
      Caption = '&Add'
      OnExecute = acAddTranslationExecute
    end
    object acRemoveTranslation: TTntAction
      Caption = '&Remove'
      OnExecute = acRemoveTranslationExecute
    end
  end
end
