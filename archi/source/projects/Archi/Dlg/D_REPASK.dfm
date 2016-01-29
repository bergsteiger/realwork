object SaveTroubleDlg: TSaveTroubleDlg
  Left = 426
  Top = 306
  ActiveControl = OKBtn
  BorderStyle = bsDialog
  Caption = #1055#1056#1045#1044#1059#1055#1056#1045#1046#1044#1045#1053#1048#1045
  ClientHeight = 110
  ClientWidth = 385
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
    Left = 16
    Top = 24
    Width = 353
    Height = 25
    Alignment = taCenter
    AutoSize = False
    Caption = #1042#1099#1073#1086#1088#1082#1072' '#1089' '#1090#1072#1082#1080#1084' '#1085#1072#1079#1074#1072#1085#1080#1077#1084' '#1091#1078#1077' '#1089#1091#1097#1077#1089#1090#1074#1091#1077#1090'.'
  end
  object OKBtn: TBitBtn
    Left = 16
    Top = 64
    Width = 113
    Height = 33
    Caption = #1055#1077#1088#1077#1087#1080#1089#1072#1090#1100
    TabOrder = 0
    Kind = bkOK
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 256
    Top = 64
    Width = 113
    Height = 33
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    Kind = bkCancel
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object RetryBtn: TBitBtn
    Left = 136
    Top = 64
    Width = 113
    Height = 33
    Caption = '&'#1048#1089#1087#1088#1072#1074#1080#1090#1100
    TabOrder = 1
    Kind = bkRetry
  end
end
