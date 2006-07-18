inherited frmTrim: TfrmTrim
  ActiveControl = edTrimWhat
  BorderStyle = bsDialog
  Caption = 'Trim Options'
  ClientHeight = 240
  ClientWidth = 390
  PixelsPerInch = 96
  TextHeight = 13
  object TntLabel1: TTntLabel
    Left = 8
    Top = 16
    Width = 51
    Height = 13
    Caption = 'Trim wh&at:'
    FocusControl = edTrimWhat
  end
  object TntLabel2: TTntLabel
    Left = 8
    Top = 96
    Width = 57
    Height = 13
    Caption = 'Trim wh&ere:'
    FocusControl = cbTrimWhere
  end
  object TntLabel3: TTntLabel
    Left = 8
    Top = 144
    Width = 47
    Height = 13
    Caption = 'Trim h&ow:'
    FocusControl = cbTrimHow
  end
  object edTrimWhat: TTntEdit
    Left = 8
    Top = 31
    Width = 373
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    BevelKind = bkFlat
    BorderStyle = bsNone
    TabOrder = 0
  end
  object cbTrimWhere: TTntComboBox
    Left = 8
    Top = 112
    Width = 373
    Height = 21
    BevelKind = bkFlat
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    ItemIndex = 2
    TabOrder = 2
    Text = 'Both'
    Items.WideStrings = (
      'Original'
      'Translation'
      'Both')
  end
  object cbTrimHow: TTntComboBox
    Left = 8
    Top = 160
    Width = 373
    Height = 21
    BevelKind = bkFlat
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    ItemIndex = 2
    TabOrder = 3
    Text = 'Both'
    Items.WideStrings = (
      'Leading'
      'Trailing'
      'Both')
  end
  object chkTrimWhitespace: TTntCheckBox
    Left = 16
    Top = 63
    Width = 364
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Trim additional &whitespace also'
    TabOrder = 1
  end
  object btnOK: TTntButton
    Left = 204
    Top = 202
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object btnCancel: TTntButton
    Left = 292
    Top = 202
    Width = 80
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
end
