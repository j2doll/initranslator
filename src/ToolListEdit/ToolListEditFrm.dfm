object frmToolListEdit: TfrmToolListEdit
  Left = 434
  Top = 211
  Width = 593
  Height = 439
  Caption = 'List Editor'
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
  OldCreateOrder = False
  OnResize = TntFormResize
  PixelsPerInch = 96
  TextHeight = 13
  object sgItems: TTntDrawGrid
    Left = 0
    Top = 0
    Width = 585
    Height = 393
    Align = alClient
    ColCount = 3
    DefaultRowHeight = 19
    FixedCols = 0
    RowCount = 2
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goTabs, goRowSelect, goThumbTracking]
    ScrollBars = ssVertical
    TabOrder = 0
    OnDblClick = sgItemsDblClick
    OnDrawCell = sgItemsDrawCell
    OnKeyUp = sgItemsKeyUp
  end
  object TntStatusBar1: TTntStatusBar
    Left = 0
    Top = 393
    Width = 585
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
end