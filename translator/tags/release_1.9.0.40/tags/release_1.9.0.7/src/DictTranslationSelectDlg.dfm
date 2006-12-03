inherited frmDictTranslationSelect: TfrmDictTranslationSelect
  ActiveControl = edTranslation
  Caption = 'Select Translation'
  ClientHeight = 363
  ClientWidth = 402
  Constraints.MinHeight = 390
  Constraints.MinWidth = 410
  PixelsPerInch = 96
  TextHeight = 13
  object TntLabel1: TTntLabel
    Left = 8
    Top = 16
    Width = 40
    Height = 13
    Caption = '&Original:'
    FocusControl = edOriginal
  end
  object TntLabel2: TTntLabel
    Left = 8
    Top = 64
    Width = 57
    Height = 13
    Caption = '&Translation:'
    FocusControl = edTranslation
  end
  object TntLabel3: TTntLabel
    Left = 8
    Top = 112
    Width = 106
    Height = 13
    Caption = 'A&vailable translations:'
    FocusControl = lbTranslations
  end
  object edOriginal: TTntEdit
    Left = 8
    Top = 32
    Width = 379
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    BevelKind = bkFlat
    BorderStyle = bsNone
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 0
  end
  object edTranslation: TTntEdit
    Left = 8
    Top = 80
    Width = 379
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    BevelKind = bkFlat
    BorderStyle = bsNone
    TabOrder = 1
    OnChange = edTranslationChange
  end
  object lbTranslations: TTntListBox
    Left = 8
    Top = 128
    Width = 379
    Height = 161
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BorderStyle = bsNone
    ItemHeight = 13
    TabOrder = 2
    OnClick = lbTranslationsClick
    OnDblClick = lbTranslationsDblClick
  end
  object btnUse: TTntButton
    Left = 45
    Top = 324
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = '&Change'
    Default = True
    ModalResult = 1
    TabOrder = 6
    OnClick = btnUseClick
  end
  object btnCancel: TTntButton
    Left = 306
    Top = 324
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 7
    OnClick = btnCancelClick
  end
  object btnIgnore: TTntButton
    Left = 219
    Top = 324
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = '&Ignore'
    ModalResult = 1
    TabOrder = 4
    OnClick = btnIgnoreClick
  end
  object btnAdd: TTntButton
    Left = 132
    Top = 324
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = '&Add'
    TabOrder = 5
    OnClick = btnAddClick
  end
  object chkIgnoreNonEmpty: TTntCheckBox
    Left = 24
    Top = 296
    Width = 361
    Height = 17
    Anchors = [akLeft, akRight, akBottom]
    Caption = '&Don'#39't check translated items'
    TabOrder = 3
  end
end
