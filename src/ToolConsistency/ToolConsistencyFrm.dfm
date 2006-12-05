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
    Anchors = [akTop, akRight]
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
    Height = 134
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BorderStyle = bsNone
    ChangeDelay = 60
    HideSelection = False
    Indent = 19
    PopupMenu = popItems
    TabOrder = 0
    OnChange = tvItemsChange
    OnEdited = tvItemsEdited
    OnEditing = tvItemsEditing
  end
  object btnClose: TTntButton
    Left = 307
    Top = 168
    Width = 75
    Height = 25
    Action = acClose
    Anchors = [akRight, akBottom]
    Cancel = True
    TabOrder = 3
  end
  object btnUpdate: TTntButton
    Left = 223
    Top = 168
    Width = 75
    Height = 25
    Action = acUpdate
    Anchors = [akRight, akBottom]
    TabOrder = 2
  end
  object alMain: TActionList
    OnUpdate = alMainUpdate
    Left = 196
    Top = 56
    object acUpdate: TAction
      Caption = '&Update'
      ShortCut = 116
      OnExecute = acUpdateExecute
    end
    object acClose: TAction
      Caption = '&Close'
      ShortCut = 27
      OnExecute = acCloseExecute
    end
    object acEdit: TAction
      Caption = 'Edit'
      ShortCut = 113
      OnExecute = acEditExecute
    end
    object acUseThisTranslation: TAction
      Caption = 'Use &this translation'
      ShortCut = 16397
      OnExecute = acUseThisTranslationExecute
    end
  end
  object popItems: TPopupMenu
    Left = 252
    Top = 56
    object Usethistranslation1: TMenuItem
      Action = acUseThisTranslation
    end
    object Edit1: TMenuItem
      Action = acEdit
    end
  end
end
