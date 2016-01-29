object MainForm: TMainForm
  Left = 383
  Top = 217
  BorderStyle = bsDialog
  Caption = #1059#1090#1080#1083#1080#1090#1072' '#1074#1099#1089#1090#1072#1074#1083#1077#1085#1080#1103' '#1092#1083#1072#1075#1072' "'#1074#1099#1083#1080#1074#1072#1090#1100' '#1074' '#1087#1089#1077#1074#1076#1086#1075#1088#1072#1092#1080#1082#1091'"'
  ClientHeight = 157
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    597
    157)
  PixelsPerInch = 96
  TextHeight = 16
  object lbPercent: TLabel
    Left = 0
    Top = 127
    Width = 597
    Height = 16
    Align = alBottom
    AutoSize = False
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 168
    Height = 16
    Caption = #1055#1091#1090#1100' '#1082' '#1087#1072#1087#1082#1077' '#1089' '#1093#1088#1072#1085#1080#1083#1080#1097#1077#1084
  end
  object lblTopicListFN: TLabel
    Left = 8
    Top = 42
    Width = 154
    Height = 16
    Caption = #1060#1072#1081#1083' '#1089#1086' '#1089#1087#1080#1089#1082#1086#1084' '#1090#1086#1087#1080#1082#1086#1074
    FocusControl = edTopicListFN
  end
  object btWork: TButton
    Left = 407
    Top = 71
    Width = 74
    Height = 26
    Caption = #1053#1072#1095#1072#1090#1100
    Default = True
    TabOrder = 0
    OnClick = btWorkClick
  end
  object btStop: TButton
    Left = 496
    Top = 71
    Width = 89
    Height = 26
    Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = btStopClick
  end
  object edBaseDir: TDirectoryEdit
    Left = 192
    Top = 4
    Width = 393
    Height = 21
    NumGlyphs = 1
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object pnStatus: TPanel
    Left = 0
    Top = 143
    Width = 597
    Height = 14
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
  end
  object edTopicListFN: TFilenameEdit
    Left = 192
    Top = 40
    Width = 393
    Height = 21
    NumGlyphs = 1
    TabOrder = 4
  end
  object Progress: TProgressBar
    Left = 0
    Top = 110
    Width = 597
    Height = 17
    Align = alBottom
    TabOrder = 5
  end
  object XPManifest1: TXPManifest
    Left = 24
    Top = 72
  end
end
