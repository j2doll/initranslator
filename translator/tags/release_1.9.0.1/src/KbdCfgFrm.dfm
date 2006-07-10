object frmConfigKbd: TfrmConfigKbd
  Left = 439
  Top = 141
  BorderStyle = bsDialog
  Caption = 'Configure Keyboard'
  ClientHeight = 403
  ClientWidth = 388
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inline FrmKbdCfg1: TFrmKbdCfg
    Left = 0
    Top = 0
    Width = 388
    Height = 403
    Align = alClient
    TabOrder = 0
    inherited lblAssignedTo: TTntLabel
      Top = 305
    end
    inherited lblAssignedTo2: TTntLabel
      Top = 305
    end
    inherited bvTop: TBevel
      Width = 284
    end
    inherited bvMiddle: TBevel
      Width = 292
    end
    inherited lblDescription: TTntLabel
      Top = 348
      Width = 12
    end
    inherited lblBottom: TTntLabel
      Top = 326
    end
    inherited bvBottom: TBevel
      Top = 333
      Width = 308
    end
    inherited lbCurrentShortCuts: TTntListBox
      Height = 75
    end
    inherited btnAdd: TTntButton
      Top = 376
    end
    inherited btnRemove: TTntButton
      Top = 376
    end
    inherited btnReset: TTntButton
      Top = 376
    end
    inherited btnClose: TTntButton
      Top = 376
    end
  end
end
