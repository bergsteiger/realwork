object BtnDlg: TBtnDlg
  Left = 533
  Top = 445
  BorderStyle = bsDialog
  ClientHeight = 274
  ClientWidth = 459
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object ButtonPanel: TPanel
    Left = 0
    Top = 229
    Width = 459
    Height = 45
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      459
      45)
    object OK: TBitBtn
      Left = 185
      Top = 10
      Width = 85
      Height = 27
      Anchors = [akTop, akRight]
      TabOrder = 0
      Kind = bkOK
      Margin = 2
      Spacing = -1
      IsControl = True
    end
    object Cancel: TBitBtn
      Left = 276
      Top = 10
      Width = 85
      Height = 27
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      Kind = bkCancel
      Margin = 2
      Spacing = -1
      IsControl = True
    end
    object Help: TBitBtn
      Left = 366
      Top = 10
      Width = 85
      Height = 27
      Anchors = [akTop, akRight]
      Caption = #1055#1086#1084#1086#1097#1100
      TabOrder = 2
      OnClick = HelpClick
      Kind = bkHelp
      Margin = 2
      Spacing = -1
      IsControl = True
    end
  end
end
