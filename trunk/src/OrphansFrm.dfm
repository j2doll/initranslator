object frmOrphans: TfrmOrphans
  Left = 433
  Top = 172
  Width = 445
  Height = 340
  ActiveControl = lvOrphaned
  BorderIcons = [biSystemMenu]
  BorderWidth = 2
  Caption = 'Orphaned Items'
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lvOrphaned: TTntListView
    Left = 0
    Top = 41
    Width = 433
    Height = 201
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvRaised
    BevelKind = bkFlat
    BorderStyle = bsNone
    Columns = <
      item
        Caption = 'Original'
        Width = 200
      end
      item
        Caption = 'Translation'
        Width = 200
      end>
    GridLines = True
    HideSelection = False
    OwnerData = True
    ReadOnly = True
    RowSelect = True
    ParentShowHint = False
    PopupMenu = popListView
    ShowHint = True
    TabOrder = 0
    ViewStyle = vsReport
    OnChange = lvOrphanedChange
    OnData = lvOrphanedData
    OnResize = lvOrphanedResize
  end
  object StatusBar1: TTntStatusBar
    Left = 0
    Top = 283
    Width = 433
    Height = 19
    Panels = <>
  end
  object Panel1: TTntPanel
    Left = 0
    Top = 0
    Width = 433
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 3
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object Panel2: TTntPanel
      Left = 3
      Top = 3
      Width = 427
      Height = 35
      Align = alClient
      BevelOuter = bvNone
      Color = clBtnShadow
      TabOrder = 0
      object lblSection: TTntLabel
        Left = 10
        Top = 7
        Width = 6
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlightText
        Font.Height = -19
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = []
        ParentFont = False
        ShowAccelChar = False
      end
    end
  end
  object TntPanel1: TTntPanel
    Left = 0
    Top = 242
    Width = 433
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 3
    DesignSize = (
      433
      41)
    object TntButton1: TTntButton
      Left = 259
      Top = 7
      Width = 75
      Height = 25
      Action = acSave
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
    object TntButton2: TTntButton
      Left = 343
      Top = 7
      Width = 75
      Height = 25
      Action = acMerge
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
  end
  object alOrphans: TTntActionList
    OnUpdate = alOrphansUpdate
    Left = 320
    Top = 176
    object acCopy: TTntAction
      Caption = 'Copy'
      ShortCut = 16451
      OnExecute = acCopyExecute
    end
    object acSave: TTntAction
      Caption = '&Save...'
      ShortCut = 16467
      OnExecute = acSaveExecute
    end
    object acMerge: TTntAction
      Caption = '&Merge...'
      ShortCut = 16461
      OnExecute = acMergeExecute
    end
  end
  object popListView: TSpTBXPopupMenu
    Left = 128
    Top = 144
    object Copy1: TSpTBXItem
      Action = acCopy
      CaptionW = 'Copy'
    end
  end
end
