object frmToolConsistency: TfrmToolConsistency
  Left = 436
  Top = 264
  Width = 402
  Height = 237
  ActiveControl = tvItems
  Caption = 'Consistency Checker'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    394
    203)
  PixelsPerInch = 96
  TextHeight = 13
  object lblInfo: TTntLabel
    Left = 380
    Top = 8
    Width = 3
    Height = 13
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = [fsBold]
    ParentFont = False
    ShowAccelChar = False
  end
  object TntLabel1: TTntLabel
    Left = 7
    Top = 8
    Width = 91
    Height = 13
    Caption = '&Inconsistent items:'
    FocusControl = tvItems
  end
  object chkIgnoreAccelChar: TTntCheckBox
    Left = 21
    Top = 172
    Width = 197
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Ignore accelerator &key'
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = chkIgnoreAccelCharClick
  end
  object tvItems: TTntTreeView
    Left = 7
    Top = 25
    Width = 378
    Height = 138
    Anchors = [akLeft, akTop, akRight, akBottom]
    Indent = 19
    ReadOnly = True
    TabOrder = 0
    OnChange = tvItemsChange
  end
  object btnClose: TTntButton
    Left = 307
    Top = 168
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = '&Close'
    ModalResult = 2
    TabOrder = 3
    OnClick = btnCloseClick
  end
  object btnUpdate: TTntButton
    Left = 223
    Top = 168
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Update'
    Default = True
    TabOrder = 2
    OnClick = btnUpdateClick
  end
end
