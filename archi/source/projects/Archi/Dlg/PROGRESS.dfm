object ProgressDlg: TProgressDlg
  Left = 355
  Top = 167
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 109
  ClientWidth = 423
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 120
  TextHeight = 16
  object MsgLabel: TLabel
    Left = 7
    Top = 8
    Width = 409
    Height = 56
    Alignment = taCenter
    AutoSize = False
    Transparent = True
  end
  object PercentMeter: TW95Meter
    Left = 9
    Top = 78
    Width = 404
    HideInactive = False
  end
  object CancelBtn: TBitBtn
    Left = 183
    Top = 119
    Width = 77
    Height = 27
    Caption = 'ярно'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Kind = bkCancel
    Margin = 2
    Spacing = -1
    IsControl = True
  end
end
