object MainForm: TMainForm
  Left = 539
  Top = 344
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = #1048#1084#1087#1086#1088#1090' '#1088#1077#1077#1089#1090#1088#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1084#1091#1085#1080#1094#1080#1087#1072#1083#1100#1085#1099#1093' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1081
  ClientHeight = 138
  ClientWidth = 510
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 117
    Height = 16
    Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072' '#1088#1077#1077#1089#1090#1088#1072
    FocusControl = feSource
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 175
    Height = 16
    Caption = #1053#1072#1095#1072#1083#1100#1085#1099#1081' '#1085#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
  end
  object feSource: TFilenameEdit
    Left = 8
    Top = 24
    Width = 497
    Height = 21
    Filter = #1060#1072#1081#1083#1099' '#1088#1077#1077#1089#1090#1088#1072' (*.csv)|*.csv'
    NumGlyphs = 1
    TabOrder = 0
  end
  object edTopicStartNum: TEdit
    Left = 8
    Top = 72
    Width = 177
    Height = 24
    TabOrder = 1
  end
  object btnStart: TButton
    Left = 400
    Top = 56
    Width = 105
    Height = 33
    Caption = #1053#1072#1095#1072#1090#1100
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnStartClick
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 112
    Width = 497
    Height = 17
    TabOrder = 3
    Visible = False
  end
  object XPManifest1: TXPManifest
    Left = 288
    Top = 56
  end
end
