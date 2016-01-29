object ShowDocInfoDlg: TShowDocInfoDlg
  Left = 379
  Top = 236
  ActiveControl = OKBtn
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'ИНФОРМАЦИЯ'
  ClientHeight = 104
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 20
  object lblDocSize: TLabel
    Left = 21
    Top = 18
    Width = 355
    Height = 20
    AutoSize = False
    Caption = 'Размер документа : %d байт'
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 63
    Width = 394
    Height = 41
    Align = alBottom
    TabOrder = 0
    object pnlButtonsRight: TPanel
      Left = 136
      Top = 1
      Width = 257
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object OKBtn: TBitBtn
        Left = 18
        Top = 6
        Width = 77
        Height = 27
        TabOrder = 0
        Kind = bkOK
        Margin = 2
        Spacing = -1
        IsControl = True
      end
    end
  end
end
