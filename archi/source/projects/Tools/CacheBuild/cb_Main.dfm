object MainForm: TMainForm
  Left = 768
  Top = 239
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1082#1101#1096#1072' '#1072#1074#1090#1086#1087#1088#1086#1089#1090#1072#1085#1086#1074#1097#1080#1082#1072' '#1089#1089#1099#1083#1086#1082
  ClientHeight = 312
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    499
    312)
  PixelsPerInch = 96
  TextHeight = 13
  object lblDisplay: TLabel
    Left = 8
    Top = 270
    Width = 44
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'lblDisplay'
    Visible = False
  end
  object lblRemoteCacheDir: TLabel
    Left = 26
    Top = 160
    Width = 277
    Height = 13
    Caption = #1076#1080#1088#1077#1082#1090#1086#1088#1080#1103', '#1074' '#1082#1086#1090#1086#1088#1091#1102' '#1073#1091#1076#1077#1090' '#1087#1086#1084#1077#1097#1105#1085' "'#1074#1085#1077#1096#1085#1080#1081'" '#1082#1101#1096
    Enabled = False
    FocusControl = deRemoteCacheDir
  end
  object btnStart: TButton
    Left = 383
    Top = 278
    Width = 99
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1053#1072#1095#1072#1090#1100
    TabOrder = 0
    OnClick = btnStartClick
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 286
    Width = 368
    Height = 17
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    Visible = False
  end
  object rbUpdate: TRadioButton
    Left = 8
    Top = 8
    Width = 225
    Height = 17
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1082#1101#1096' '#1072#1074#1090#1086#1087#1088#1086#1089#1090#1072#1085#1086#1074#1097#1080#1082#1072
    Checked = True
    TabOrder = 2
    TabStop = True
    OnClick = RadiobuttonClick
  end
  object rbCreate: TRadioButton
    Left = 8
    Top = 59
    Width = 233
    Height = 17
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1082#1101#1096' '#1072#1074#1090#1086#1087#1088#1086#1089#1090#1072#1085#1086#1074#1097#1080#1082#1072' '#1089' '#1085#1091#1083#1103
    TabOrder = 3
    OnClick = RadiobuttonClick
  end
  object deRemoteCacheDir: TDirectoryEdit
    Left = 26
    Top = 176
    Width = 455
    Height = 21
    DialogOptions = [sdAllowCreate, sdPerformCreate]
    Enabled = False
    NumGlyphs = 1
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
  object cbDocs: TCheckBox
    Left = 26
    Top = 75
    Width = 97
    Height = 17
    Caption = #1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 5
  end
  object cbEditions: TCheckBox
    Left = 26
    Top = 95
    Width = 121
    Height = 17
    Caption = #1087#1088#1086#1096#1083#1099#1093' '#1088#1077#1076#1072#1082#1094#1080#1081
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 6
  end
  object cbStruct: TCheckBox
    Left = 26
    Top = 116
    Width = 145
    Height = 17
    Caption = #1089#1090#1088#1091#1082#1090#1091#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 7
  end
  object rbExternal: TRadioButton
    Left = 8
    Top = 144
    Width = 281
    Height = 17
    Caption = #1055#1086#1076#1075#1086#1090#1086#1074#1080#1090#1100' "'#1074#1085#1077#1096#1085#1080#1081'" '#1082#1101#1096' '#1072#1074#1090#1086#1087#1088#1086#1089#1090#1072#1085#1086#1074#1097#1080#1082#1072
    TabOrder = 8
    OnClick = RadiobuttonClick
  end
  object cbOneDoc: TCheckBox
    Left = 24
    Top = 32
    Width = 177
    Height = 17
    Caption = #1044#1083#1103' '#1082#1086#1085#1082#1088#1077#1090#1085#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072': '
    TabOrder = 9
    OnClick = RadiobuttonClick
  end
  object edOneDoc: TEdit
    Left = 202
    Top = 30
    Width = 151
    Height = 21
    Enabled = False
    TabOrder = 10
  end
  object rbCleanupCache: TRadioButton
    Left = 8
    Top = 208
    Width = 369
    Height = 17
    Caption = #1055#1086#1095#1080#1089#1090#1080#1090#1100' '#1082#1101#1096' '#1086#1090' '#1091#1076#1072#1083#1105#1085#1085#1099#1093' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
    TabOrder = 11
  end
  object rbService: TRadioButton
    Left = 8
    Top = 237
    Width = 377
    Height = 17
    Caption = #1057#1077#1088#1074#1080#1089#1085#1086#1077' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1077
    TabOrder = 12
  end
end
