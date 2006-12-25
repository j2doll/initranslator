object frmTranslatorPluginWizard: TfrmTranslatorPluginWizard
  Left = 339
  Top = 183
  ActiveControl = edClassName
  BorderStyle = bsDialog
  Caption = 'Create IniTranslatorPlugin'
  ClientHeight = 247
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    447
    247)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TTntButton
    Left = 256
    Top = 211
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TTntButton
    Left = 347
    Top = 211
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object TntGroupBox1: TTntGroupBox
    Left = 7
    Top = 7
    Width = 433
    Height = 195
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = ' Options: '
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      433
      195)
    object TntLabel1: TTntLabel
      Left = 16
      Top = 28
      Width = 84
      Height = 13
      Caption = '&Plugin classname:'
    end
    object TntLabel2: TTntLabel
      Left = 16
      Top = 98
      Width = 24
      Height = 13
      Caption = 'Title:'
    end
    object TntLabel3: TTntLabel
      Left = 16
      Top = 140
      Width = 108
      Height = 13
      Caption = 'Transintf.pas location:'
    end
    object edClassName: TTntEdit
      Left = 16
      Top = 42
      Width = 380
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object rbFileParser: TTntRadioButton
      Left = 32
      Top = 70
      Width = 113
      Height = 17
      Caption = 'IFileParser'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object rbToolPlugin: TTntRadioButton
      Left = 168
      Top = 70
      Width = 113
      Height = 17
      Caption = 'IToolPlugin'
      TabOrder = 2
    end
    object edTitle: TTntEdit
      Left = 16
      Top = 112
      Width = 380
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
    object edTransIntfPath: TTntEdit
      Left = 16
      Top = 154
      Width = 380
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
    end
    object TntButton1: TTntButton
      Left = 402
      Top = 154
      Width = 21
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 5
      OnClick = TntButton1Click
    end
  end
  object odTransIntf: TTntOpenDialog
    DefaultExt = 'pas'
    Filter = 'Source files (*.pas)|*.pas|All files (*.*)|*.*'
    InitialDir = '.'
    Left = 308
    Top = 70
  end
end
