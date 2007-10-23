object frmToolTreeView: TfrmToolTreeView
  Left = 494
  Top = 220
  Width = 644
  Height = 483
  ActiveControl = tvSections
  Caption = 'Tree View'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  Icon.Data = {
    000001000200101010000000000028010000260000002020100000000000E802
    00004E0100002800000010000000200000000100040000000000800000000000
    0000000000001000000010000000000000000000800000800000008080008000
    0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF000000000000000000078888888888800007FF
    FFFFFFFF800007FFFFF000FF800007FF0004430F800007FFFF04440F800007FF
    0008440F800007FFFFF000FF800007FF000000FF800007FFFFFFFFFF800007FF
    000F00FF800007FFFFFFFFFF800007FFFFFFFFFF800007F0F0F0F0F0F000000F
    7F7F7F7F00000000000000000000C00700008003000080030000800300008003
    0000800300008003000080030000800300008003000080030000800300008003
    000080030000C0070000EAAF0000280000002000000040000000010004000000
    0000000200000000000000000000100000001000000000000000000080000080
    00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000000000000
    00000000000000078888888888888888888880800000007FFFFFFFFFFFFFFFFF
    FFFFF8080000007FFFFFFFFFFFFFFFFFFFFFF8080000007FF000000FFFFF0000
    0FFFF8080000007FFFFFFFFFFFF0C22240FFF8080000007FF000000FFF0CCC22
    240FF8080000007FFFFFFFFFFF4CCCC2220FF8080000007FFFFFFFFFFF4ACCCC
    220FF8080000007FF00000000042ACC2220FF8080000007FFFFFFFFFFF4A27CC
    220FF8080000007FF000000000B4ACCC208FF8080000007FFFFFFFFFFFFB4444
    00FFF8080000007FF000000000000000000FF8080000007FFFFFFFFFFFFFFFFF
    FFFFF8080000007FF000000000000000000FF8080000007FFFFFFFFFFFFFFFFF
    FFFFF8080000007FFFFFFFFFFFFFFFFFFFFFF8080000007FF000000FFFFFFFFF
    FFFFF8080000007FFFFFFFFFFFFFFFFFFFFFF8080000007FFFFFFFFFFFFFFFFF
    FFFFF8080000007FFFFFFFFFFFFFFFFFFFFFF8080000007FF000000FFFFFFFFF
    FFFFF8080000007FFFFFFFFFFFFFFFFFFFFFF8080000007FF000000FFFFFFF0F
    000FF8080000007FFFFFFFFFFFFFFFFFFFFFF8080000007FFFFFFFFFFFFFFFFF
    FFFFF8080000007FFFFFFFFFFFFFFFFFFFFFF8080000007F0FF0FF0FF0FF0FF0
    FF0FF7080000007F0FF0FF0FF0FF0FF0FF0FF70800000007F77F77F77F77F77F
    77F77F70000000000000000000000000000000000000F000001FE000000FC000
    0007C0000007C0000007C0000007C0000007C0000007C0000007C0000007C000
    0007C0000007C0000007C0000007C0000007C0000007C0000007C0000007C000
    0007C0000007C0000007C0000007C0000007C0000007C0000007C0000007C000
    0007C0000007C0000007C0000007E000000FF24924BF}
  KeyPreview = True
  OldCreateOrder = False
  PopupMenu = popTreeview
  Position = poMainFormCenter
  Scaled = False
  ShowHint = True
  OnKeyUp = TntFormKeyUp
  OnResize = TntFormResize
  PixelsPerInch = 96
  TextHeight = 13
  object splitVertical: TTntSplitter
    Left = 272
    Top = 0
    Width = 5
    Height = 430
    Cursor = crSizeWE
    AutoSnap = False
    MinSize = 100
    ResizeStyle = rsUpdate
  end
  object StatusBottom: TTntStatusBar
    Left = 0
    Top = 430
    Width = 636
    Height = 19
    Panels = <
      item
        Text = '[Section]'
        Width = 400
      end>
  end
  object pnlLeft: TTntPanel
    Left = 0
    Top = 0
    Width = 272
    Height = 430
    Align = alLeft
    BevelOuter = bvLowered
    TabOrder = 1
    object lblSections: TTntLabel
      Left = 1
      Top = 1
      Width = 270
      Height = 17
      Align = alTop
      AutoSize = False
      Caption = '  &Sections:'
      FocusControl = tvSections
      Layout = tlCenter
    end
    object tvSections: TTntTreeView
      Left = 1
      Top = 18
      Width = 270
      Height = 411
      Hint = '  Bold = untranslated. Italic = modified'
      Align = alClient
      BevelInner = bvNone
      BevelKind = bkFlat
      BorderStyle = bsNone
      ChangeDelay = 60
      HideSelection = False
      Images = ilTreeView
      Indent = 19
      ReadOnly = True
      RowSelect = True
      StateImages = ilTreeView
      TabOrder = 0
      ToolTips = False
      OnChanging = tvSectionsChanging
      OnCustomDrawItem = tvSectionsCustomDrawItem
      OnDblClick = tvSectionsDblClick
      OnGetImageIndex = tvSectionsGetImageIndex
      OnKeyPress = tvSectionsKeyPress
      OnKeyUp = tvSectionsKeyUp
    end
  end
  object nbViews: TNotebook
    Left = 277
    Top = 0
    Width = 359
    Height = 430
    Align = alClient
    TabOrder = 2
    object TPage
      Left = 0
      Top = 0
      Caption = 'Edit'
      object pnlRight: TTntPanel
        Left = 0
        Top = 0
        Width = 359
        Height = 430
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object splitHorizontal: TTntSplitter
          Left = 0
          Top = 193
          Width = 359
          Height = 5
          Cursor = crVSplit
          Align = alTop
        end
        object pnlTopRight: TTntPanel
          Left = 0
          Top = 0
          Width = 359
          Height = 193
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lblOriginal: TTntLabel
            Left = 0
            Top = 0
            Width = 359
            Height = 17
            Align = alTop
            AutoSize = False
            Caption = '  &Original:'
            FocusControl = reOriginal
            Layout = tlCenter
          end
          object reOriginal: TTntRichEdit
            Left = 0
            Top = 17
            Width = 359
            Height = 176
            Align = alClient
            BevelKind = bkFlat
            BorderStyle = bsNone
            Color = 15724527
            PlainText = True
            ReadOnly = True
            ScrollBars = ssBoth
            TabOrder = 0
            WantReturns = False
            WordWrap = False
          end
        end
        object pnlBottomRight: TTntPanel
          Left = 0
          Top = 198
          Width = 359
          Height = 232
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object lblTranslation: TTntLabel
            Left = 0
            Top = 0
            Width = 359
            Height = 17
            Align = alTop
            AutoSize = False
            Caption = '  &Translation:'
            FocusControl = reTranslation
            Layout = tlCenter
          end
          object reTranslation: TTntRichEdit
            Left = 0
            Top = 17
            Width = 359
            Height = 215
            Align = alClient
            BevelKind = bkFlat
            BorderStyle = bsNone
            PlainText = True
            ScrollBars = ssBoth
            TabOrder = 0
            WantReturns = False
            WordWrap = False
            OnKeyDown = reTranslationKeyDown
            OnKeyUp = reTranslationKeyUp
          end
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'View'
      object lvView: TTntListView
        Left = 0
        Top = 0
        Width = 359
        Height = 430
        Hint = '  Bold = untranslated. Italic = modified'
        Align = alClient
        BevelKind = bkFlat
        BorderStyle = bsNone
        Columns = <
          item
            AutoSize = True
            Caption = 'Names'
          end
          item
            Caption = 'Original'
          end
          item
            Caption = 'Translation'
          end>
        ColumnClick = False
        GridLines = True
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        SmallImages = ilTreeView
        StateImages = ilTreeView
        TabOrder = 0
        ViewStyle = vsReport
        OnCustomDrawItem = lvViewCustomDrawItem
        OnDblClick = lvViewDblClick
        OnEnter = lvViewEnter
        OnKeyDown = lvViewKeyDown
        OnKeyPress = lvViewKeyPress
      end
    end
  end
  object popTreeview: TTntPopupMenu
    Left = 72
    Top = 56
    object Previous1: TTntMenuItem
      Action = acPrev
    end
    object Next1: TTntMenuItem
      Action = acNext
    end
    object N2: TTntMenuItem
      Caption = '-'
    end
    object Previousuntranslated1: TTntMenuItem
      Action = acPrevUntrans
    end
    object Nextuntranslated1: TTntMenuItem
      Action = acNextUntrans
    end
    object N1: TTntMenuItem
      Caption = '-'
    end
    object Previoussection1: TTntMenuItem
      Action = acPrevSection
    end
    object Nextsection1: TTntMenuItem
      Action = acNextSection
    end
  end
  object ilTreeView: TImageList
    Left = 136
    Top = 56
    Bitmap = {
      494C010105000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
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
      000000000000000000000000000000000000000000000000000063CECE0063CE
      CE0063CECE0063CECE0063CECE0063CECE0063CECE0063CECE0063CECE0063CE
      CE0063CECE0063CECE0000636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063CECE00CEFF
      FF009CFFFF009CFFFF009CFFFF009CCEFF009CFFFF009CCEFF009CFFFF009CCE
      FF009CFFFF0063CECE0000636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063CECE00CEFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CCEFF009CFFFF009CCEFF009CFF
      FF009CCEFF000063630063CECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063CECE00CEFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CCEFF009CFFFF009CCEFF009CFFFF009CCE
      FF0063CECE000063630063CECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063CECE00CEFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CCEFF009CFF
      FF000063630063CECE0063CECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063CECE00CEFFFF00CEFFFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF0063CE
      CE00006363009CCEFF0063CECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063CECE0063CECE0063CECE0063CE
      CE0063CECE0063CECE0063CECE0063CECE0063CECE0063CECE0063CECE0063CE
      CE0063CECE009CFFFF0063CECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009C9C00CEFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CFFFF009CCEFF0063CECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009C9C00CEFFFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFF
      FF00CEFFFF009CFFFF0063CECE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009C9C0063CECE0063CE
      CE0063CECE0063CECE0063CECE0063CECE0063CECE00009C9C00009C9C00009C
      9C00009C9C00009C9C00009C9C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000009C9C00F7F7
      F700CEFFFF00CEFFFF009CFFFF009CFFFF00009C9C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000009C
      9C00009C9C00009C9C00009C9C00009C9C000000000000000000000000000000
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
      00000000000000000000C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600840000008400000084848400C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000C6C6C600840000008400000084848400C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60084000000FF000000FF00000084848400FFFFFF0000FFFF00FFFFFF00FFFF
      FF0000FFFF00FFFFFF00C6C6C60000000000000000000000000000000000C6C6
      C60084000000FF000000FF00000084848400FFFFFF0000FFFF00FFFFFF00FFFF
      FF0000FFFF00FFFFFF00C6C6C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000FF000000FF000000FF00000084848400FFFFFF0000FFFF00840000008400
      0000C6C6C600FFFFFF00C6C6C600000000000000000000000000000000008400
      0000FF000000FF000000FF00000084848400FFFFFF0000FFFF00840000008400
      0000C6C6C600FFFFFF00C6C6C600000000000000000000000000000000000000
      000000000000000000000A800F00007500000070000000470000000000000000
      000000000000000000000000000000000000009C9C00CEFFFF0063CECE0063CE
      CE0063CECE0063CECE0063CECE0063CECE0063CECE0063CECE0063CECE0063CE
      CE0063CECE0063CECE0000000000000000000000000000000000C6C6C600FF00
      000000840000FF000000FF00000084848400FFFFFF0084840000FF000000FF00
      000084000000C6C6C600C6C6C600000000000000000000000000C6C6C600FF00
      000000840000FF000000FF00000084848400FFFFFF0084840000FF000000FF00
      000084000000C6C6C600C6C6C600000000000000000000000000000000000000
      000000000000238B26000076000016961300006C000000530000196727000F3E
      1D0000000000000000000000000000000000009C9C00CEFFFF009CFFFF009CFF
      FF009CCEFF009CFFFF009CCEFF009CFFFF009CCEFF009CFFFF009CCEFF009CCE
      FF009CCEFF0063CECE0000000000000000000000000000000000848484000084
      0000FF000000FF000000FF00000084848400FFFFFF0084840000848484000084
      00008400000084848400C6C6C600000000000000000000000000848484000084
      0000FF000000FF000000FF00000084848400FFFFFF0084840000848484000084
      00008400000084848400C6C6C600000000000000000000000000000000000000
      000017711700147D0800269E17000384000000810000087B0D0003630F00155C
      230000000000000000000000000000000000009C9C00CEFFFF009CFFFF009CFF
      FF009CFFFF009CCEFF009CFFFF009CCEFF009CFFFF009CCEFF009CFFFF009CCE
      FF009CCEFF0063CECE000000000000000000000000000000000084848400C6C6
      C600FF000000FF0000008484000084848400FFFFFF0084840000FFFFFF008484
      840084000000C6C6C600C6C6C60000000000000000000000000084848400C6C6
      C600FF000000FF0000008484000084848400FFFFFF0084840000FFFFFF008484
      840084000000C6C6C600C6C6C600000000000000000000000000000000007CC8
      7600348725004EAD340044B02200128800001A950500158D11000D7A1400005C
      0B0000430000000000000000000000000000009C9C00CEFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF009CCEFF009CFFFF009CCEFF009CFFFF009CCEFF009CFF
      FF009CCEFF0063CECE0000000000000000000000000000000000848484008484
      0000C6C6C600FF000000C6C6C60084848400FFFFFF0000FFFF00848400008484
      0000C6C6C60000000000000000000000000000000000000000000000FF008484
      0000C6C6C6000000FF00C6C6C60084848400FFFFFF0000FFFF00848400008484
      0000C6C6C6000000000000000000000000000000000000000000000000007DB5
      680067A64A006FB6420064B8300066C834004EBC28000C810000128811000069
      020000550000000000000000000000000000009C9C00CEFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CCEFF009CFFFF009CCEFF009CFFFF009CCE
      FF009CFFFF0063CECE000000000000000000000000000000000084848400C6C6
      C600FFFFFF00C6C6C600FF00000084848400FFFFFF0000FFFF00FFFFFF00FFFF
      FF00C6C6C600FFFFFF00848484008484840000000000000000000000FF000000
      FF00FFFFFF000000FF00FF00000084848400FFFFFF0000FFFF00FFFFFF00FFFF
      FF00C6C6C600FFFFFF0084848400848484000000000000000000000000008DB8
      750072A152007CAF470078B73B0060AE25006CC93E0056C14200007200001D8E
      200000610000000000000000000000000000009C9C00CEFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CCEFF009CFFFF009CCEFF009CFF
      FF009CCEFF0063CECE0000000000000000000000000000000000C6C6C6008484
      8400C6C6C600FFFFFF000084000084848400FFFFFF00FFFFFF00FFFFFF0000FF
      FF00C6C6C6008484840084848400C6C6C6000000000000000000C6C6C6000000
      FF000000FF000000FF00008400000000FF000000FF00FFFFFF00FFFFFF0000FF
      FF00C6C6C6008484840084848400C6C6C6000000000000000000000000008FB0
      7D008BAE6E0083A65000BCEA8000B6F27C006FB9430052B0410023892300046B
      0A0021892A00000000000000000000000000009C9C00CEFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CCEFF009CFFFF009CCE
      FF009CFFFF0063CECE0000000000000000000000000000000000000000008484
      8400FFFFFF00C6C6C60084840000848484008484840084848400848484008484
      8400848484008484840000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF008484840084848400848484008484
      840084848400848484000000000000000000000000000000000000000000B6D7
      B2007B9B6A008DAA6500EFFFBC00BEED8B0067A442005FAF5600126919001F74
      2A0000000000000000000000000000000000009C9C00CEFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF009CCEFF0063CECE000000000000000000000000000000000000000000C6C6
      C60084848400FFFFFF00C6C6C600FFFFFF0000840000FF000000008400000084
      0000FF00000084000000C6C6C6000000000000000000000000000000FF000000
      FF00FFFFFF000000FF000000FF00FFFFFF0000840000FF000000008400000084
      0000FF00000084000000C6C6C600000000000000000000000000000000000000
      0000AED7B20094B77F00789A5400759F52007CB1670067AA6C00317945000000
      000000000000000000000000000000000000009C9C00CEFFFF00CEFFFF00CEFF
      FF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFFFF00CEFF
      FF009CFFFF0063CECE0000000000000000000000000000000000000000000000
      0000C6C6C6008484840084848400C6C6C600FF0000008484000084840000FF00
      0000FF000000C6C6C6000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF008484000084840000FF00
      0000FF000000C6C6C60000000000000000000000000000000000000000000000
      000000000000AFD3A40097B97D008BB16F008BBA7C0076B38100000000000000
      000000000000000000000000000000000000009C9C0063CECE0063CECE0063CE
      CE0063CECE0063CECE0063CECE0063CECE00009C9C00009C9C00009C9C00009C
      9C00009C9C00009C9C0000000000000000000000000000000000000000000000
      00000000000000000000C6C6C60084848400848484008484840084848400C6C6
      C600000000000000000000000000000000000000FF000000FF00000000000000
      FF000000FF000000FF00C6C6C60084848400848484008484840084848400C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000009C9C00F7F7F700CEFF
      FF00CEFFFF009CFFFF009CFFFF00009C9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000009C9C00009C
      9C00009C9C00009C9C00009C9C00000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FFFF000000000000
      FFFF000000000000E000000000000000C000000000000000C000000000000000
      8000000000000000800000000000000000000000000000000000000000000000
      0000000000000000800000000000000080000000000000008001000000000000
      C07F000000000000E0FF000000000000FFFFFFFFFFFFFFFFFC00FC00FFFFFFFF
      F000F000FFFFFFFFE000E000FFFF8001E000E000FC3F0001C000C000F80F0001
      C000C000F00F0001C000C000E0070001C000C000E0070001C000C000E0070001
      C000C000E0070001E0010001E00F0001E001C001F01F0001F0038003F83F0003
      FC0F200FFFFF80FFFFFFE9FFFFFFC1FF00000000000000000000000000000000
      000000000000}
  end
  object alMain: TTntActionList
    Left = 88
    Top = 104
    object acPrev: TTntAction
      Caption = 'Previous'
      ShortCut = 38
      OnExecute = acPrevExecute
    end
    object acNext: TTntAction
      Caption = 'Next'
      ShortCut = 40
      OnExecute = acNextExecute
    end
    object acPrevUntrans: TTntAction
      Caption = 'Previous untranslated'
      ShortCut = 16422
      OnExecute = acPrevUntransExecute
    end
    object acNextUntrans: TTntAction
      Caption = 'Next untranslated'
      ShortCut = 16424
      OnExecute = acNextUntransExecute
    end
    object acPrevSection: TTntAction
      Caption = 'Previous section'
      ShortCut = 16417
      OnExecute = acPrevSectionExecute
    end
    object acNextSection: TTntAction
      Caption = 'Next section'
      ShortCut = 16418
      OnExecute = acNextSectionExecute
    end
    object acClose: TTntAction
      Caption = 'Close'
      ShortCut = 27
      OnExecute = acCloseExecute
    end
  end
end