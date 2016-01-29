object MainForm: TMainForm
  Left = 358
  Top = 239
  BorderStyle = bsDialog
  Caption = #1050#1086#1085#1090#1088#1086#1083#1100' '#1079#1072' '#1087#1077#1088#1077#1093#1086#1076#1086#1084' '#1085#1072' '#1074#1077#1088#1089#1080#1102
  ClientHeight = 158
  ClientWidth = 521
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 113
    Height = 13
    Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072' '#1083#1086#1075#1072' Archi:'
  end
  object Label2: TLabel
    Left = 8
    Top = 51
    Width = 137
    Height = 13
    Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1072#1103' '#1074#1077#1088#1089#1080#1103' Archi'
  end
  object feLog: TFilenameEdit
    Left = 8
    Top = 24
    Width = 505
    Height = 21
    NumGlyphs = 1
    TabOrder = 0
    OnChange = feLogChange
  end
  object pnlResult: TPanel
    Left = 0
    Top = 127
    Width = 521
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object PB: TProgressBar
    Left = 8
    Top = 104
    Width = 505
    Height = 17
    TabOrder = 2
  end
  object btnStart: TButton
    Left = 344
    Top = 62
    Width = 171
    Height = 25
    Caption = #1053#1072#1095#1072#1090#1100' '#1087#1088#1086#1074#1077#1088#1082#1091
    Enabled = False
    TabOrder = 3
    OnClick = btnStartClick
  end
  object edMinVersion: TEdit
    Left = 8
    Top = 67
    Width = 137
    Height = 21
    TabOrder = 4
    OnChange = edMinVersionChange
  end
  object XPManifest1: TXPManifest
    Left = 288
    Top = 56
  end
end
