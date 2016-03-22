object MainForm: TMainForm
  Left = 435
  Top = 265
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1050#1086#1085#1074#1077#1088#1090#1077#1088' '#1073#1077#1083#1072#1088#1091#1089#1082#1086#1075#1086' '#1079#1072#1082#1086#1085#1086#1076#1072#1090#1077#1083#1100#1089#1090#1074#1072
  ClientHeight = 218
  ClientWidth = 627
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    627
    218)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 179
    Height = 13
    Caption = #1055#1072#1087#1082#1072' '#1089' '#1092#1072#1081#1083#1072#1084#1080' '#1076#1083#1103' '#1082#1086#1085#1074#1077#1088#1090#1072#1094#1080#1080
  end
  object lblProgress: TLabel
    Left = 200
    Top = 136
    Width = 48
    Height = 13
    Caption = '                '
  end
  object lblCount: TLabel
    Left = 200
    Top = 197
    Width = 177
    Height = 13
    Caption = '                                                           '
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 187
    Height = 13
    Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1074' '#1082#1086#1085#1074#1077#1088#1090#1072#1094#1080#1080
  end
  object deSource: TDirectoryEdit
    Left = 8
    Top = 24
    Width = 610
    Height = 21
    DialogKind = dkWin32
    NumGlyphs = 1
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object btnDoThings: TButton
    Left = 496
    Top = 136
    Width = 123
    Height = 57
    Caption = #1050#1086#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100
    Default = True
    TabOrder = 1
    OnClick = btnDoThingsClick
  end
  object rgFormat: TRadioGroup
    Left = 8
    Top = 128
    Width = 185
    Height = 65
    Caption = ' '#1042#1099#1093#1086#1076#1085#1086#1081' '#1092#1086#1088#1084#1072#1090' '
    ItemIndex = 0
    Items.Strings = (
      'EVD'
      'NSRC')
    TabOrder = 2
  end
  object ProgressBar: TProgressBar
    Left = 200
    Top = 152
    Width = 289
    Height = 17
    TabOrder = 3
  end
  object DetailProgressBar: TProgressBar
    Left = 200
    Top = 176
    Width = 289
    Height = 17
    TabOrder = 4
  end
  object deResult: TDirectoryEdit
    Left = 8
    Top = 72
    Width = 609
    Height = 21
    NumGlyphs = 1
    TabOrder = 5
  end
  object cbAppendResult: TCheckBox
    Left = 8
    Top = 104
    Width = 225
    Height = 17
    Caption = #1044#1086#1087#1086#1083#1085#1103#1090#1100' '#1089#1091#1097#1077#1089#1090#1074#1091#1102#1097#1080#1081' '#1088#1077#1079#1091#1083#1100#1090#1072#1090
    TabOrder = 6
  end
end
