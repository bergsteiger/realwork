object PasswordDlg: TPasswordDlg
  Left = 314
  Top = 145
  ActiveControl = Password
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1050#1054#1053#1058#1056#1054#1051#1068' '#1044#1054#1057#1058#1059#1055#1040
  ClientHeight = 146
  ClientWidth = 323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 96
    Top = 50
    Width = 162
    Height = 17
    AutoSize = False
    Caption = #1055#1072#1088#1086#1083#1100':'
  end
  object NameLabel: TLabel
    Left = 93
    Top = 6
    Width = 224
    Height = 16
    AutoSize = False
    Caption = #1048#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
    Transparent = True
  end
  object OKBtn: TBitBtn
    Left = 145
    Top = 107
    Width = 78
    Height = 27
    TabOrder = 1
    Kind = bkOK
    Margin = 2
    Spacing = -1
  end
  object CancelBtn: TBitBtn
    Left = 236
    Top = 107
    Width = 78
    Height = 27
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    Kind = bkCancel
    Margin = 2
    Spacing = -1
  end
  object UserName: TEdit
    Left = 94
    Top = 24
    Width = 220
    Height = 20
    AutoSize = False
    MaxLength = 15
    TabOrder = 3
  end
  object Password: TEdit
    Left = 95
    Top = 71
    Width = 219
    Height = 21
    AutoSize = False
    MaxLength = 10
    PasswordChar = '#'
    TabOrder = 0
  end
end
