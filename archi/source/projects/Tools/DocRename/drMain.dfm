object MainForm: TMainForm
  Left = 542
  Top = 371
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082' '#1080' '#1079#1072#1084#1077#1085#1072' '#1074' '#1085#1072#1079#1074#1072#1085#1080#1103#1093' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
  ClientHeight = 157
  ClientWidth = 442
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblDisp: TLabel
    Left = 8
    Top = 112
    Width = 36
    Height = 13
    Caption = #1047#1072#1084#1077#1085':'
  end
  object Label1: TLabel
    Left = 48
    Top = 16
    Width = 353
    Height = 13
    Caption = 
      #1047#1072#1084#1077#1085#1103#1077#1090' "('#1089' '#1080#1079#1084'. '#1076#1086#1087'. '#1086#1090' ...)" '#1085#1072'  "('#1089' '#1080#1079#1084#1077#1085#1077#1085#1080#1103#1084#1080' '#1080' '#1076#1086#1087#1086#1083#1085#1077#1085#1080#1103 +
      #1084#1080')"'
  end
  object Button1: TButton
    Left = 152
    Top = 48
    Width = 145
    Height = 49
    Caption = #1057#1058#1040#1056#1058
    TabOrder = 0
    OnClick = Button1Click
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 128
    Width = 425
    Height = 17
    TabOrder = 1
  end
  object XPManifest1: TXPManifest
    Left = 408
    Top = 48
  end
end
