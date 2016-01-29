object MainForm: TMainForm
  Left = 504
  Top = 118
  Width = 449
  Height = 322
  Caption = #1055#1086#1080#1089#1082' "'#1087#1086#1090#1077#1088#1103#1085#1085#1099#1093'" '#1089#1089#1099#1083#1086#1082
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gbFind: TGroupBox
    Left = 8
    Top = 8
    Width = 417
    Height = 209
    Caption = ' '#1053#1072#1081#1090#1080' '
    TabOrder = 0
    object lblFixRulesFile: TLabel
      Left = 35
      Top = 157
      Width = 199
      Height = 13
      Caption = #1060#1072#1081#1083' '#1089#1086' '#1089#1087#1080#1089#1082#1086#1084' '#1087#1088#1072#1074#1080#1083' '#1080#1089#1087#1088#1072#1074#1083#1077#1085#1080#1081
      Enabled = False
    end
    object rbSearchAll: TRadioButton
      Left = 16
      Top = 24
      Width = 241
      Height = 17
      Caption = #1054#1073#1099#1089#1082#1072#1090#1100' '#1074#1089#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1074' '#1073#1072#1079#1077
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbSearchAllClick
    end
    object rbSearchInList: TRadioButton
      Left = 16
      Top = 48
      Width = 193
      Height = 17
      Caption = #1054#1073#1099#1089#1082#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1080#1079' '#1089#1087#1080#1089#1082#1072
      Enabled = False
      TabOrder = 1
    end
    object feList: TFilenameEdit
      Left = 35
      Top = 68
      Width = 374
      Height = 21
      Enabled = False
      NumGlyphs = 1
      TabOrder = 2
    end
    object rbFix: TRadioButton
      Left = 16
      Top = 112
      Width = 257
      Height = 17
      Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1080#1079' '#1089#1087#1080#1089#1082#1072
      TabOrder = 3
      OnClick = rbSearchAllClick
    end
    object feFixDocList: TFilenameEdit
      Left = 35
      Top = 132
      Width = 374
      Height = 21
      Enabled = False
      NumGlyphs = 1
      TabOrder = 4
    end
    object feFixRules: TFilenameEdit
      Left = 35
      Top = 172
      Width = 374
      Height = 21
      Enabled = False
      NumGlyphs = 1
      TabOrder = 5
    end
  end
  object btnDoWork: TButton
    Left = 336
    Top = 248
    Width = 89
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    TabOrder = 1
    OnClick = btnDoWorkClick
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 224
    Width = 417
    Height = 17
    TabOrder = 2
  end
end
