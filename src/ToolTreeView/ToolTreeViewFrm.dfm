object frmToolTreeView: TfrmToolTreeView
  Left = 447
  Top = 213
  Width = 650
  Height = 459
  ActiveControl = tvSections
  Caption = 'Tree View'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object TntSplitter1: TTntSplitter
    Left = 220
    Top = 0
    Width = 5
    Height = 413
  end
  object StatusBottom: TTntStatusBar
    Left = 0
    Top = 413
    Width = 642
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object TntPanel1: TTntPanel
    Left = 225
    Top = 0
    Width = 417
    Height = 413
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object TntSplitter2: TTntSplitter
      Left = 0
      Top = 193
      Width = 417
      Height = 5
      Cursor = crVSplit
      Align = alTop
    end
    object TntPanel2: TTntPanel
      Left = 0
      Top = 0
      Width = 417
      Height = 193
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object TntLabel1: TTntLabel
        Left = 0
        Top = 0
        Width = 417
        Height = 13
        Align = alTop
        Caption = '  &Original:'
        FocusControl = reOriginal
      end
      object reOriginal: TTntRichEdit
        Left = 0
        Top = 13
        Width = 417
        Height = 180
        Align = alClient
        BevelKind = bkFlat
        BorderStyle = bsNone
        PlainText = True
        ScrollBars = ssBoth
        TabOrder = 0
        WantReturns = False
        OnKeyDown = reOriginalKeyDown
      end
    end
    object TntPanel3: TTntPanel
      Left = 0
      Top = 198
      Width = 417
      Height = 215
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object TntPanel4: TTntPanel
        Left = 0
        Top = 0
        Width = 417
        Height = 215
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object TntLabel2: TTntLabel
          Left = 0
          Top = 0
          Width = 417
          Height = 13
          Align = alTop
          Caption = '  &Translation:'
          FocusControl = reTranslation
        end
        object reTranslation: TTntRichEdit
          Left = 0
          Top = 13
          Width = 417
          Height = 202
          Align = alClient
          BevelKind = bkFlat
          BorderStyle = bsNone
          PlainText = True
          ScrollBars = ssBoth
          TabOrder = 0
          WantReturns = False
          OnKeyDown = reOriginalKeyDown
        end
      end
    end
  end
  object TntPanel5: TTntPanel
    Left = 0
    Top = 0
    Width = 220
    Height = 413
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object TntLabel3: TTntLabel
      Left = 0
      Top = 0
      Width = 220
      Height = 13
      Align = alTop
      Caption = '  &Sections:'
      FocusControl = tvSections
    end
    object tvSections: TTntTreeView
      Left = 0
      Top = 13
      Width = 220
      Height = 400
      Align = alClient
      BevelKind = bkFlat
      BorderStyle = bsNone
      ChangeDelay = 60
      HideSelection = False
      Indent = 19
      ReadOnly = True
      RightClickSelect = True
      RowSelect = True
      TabOrder = 0
      OnChange = tvSectionsChange
      OnChanging = tvSectionsChanging
    end
  end
end
