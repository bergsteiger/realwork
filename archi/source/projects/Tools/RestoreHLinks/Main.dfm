object MainForm: TMainForm
  Left = 480
  Top = 236
  Width = 492
  Height = 259
  Caption = #1055#1086#1080#1089#1082' '#1080' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1087#1086#1090#1077#1088#1103#1085#1085#1099#1093' '#1075#1080#1087#1077#1088#1089#1089#1099#1083#1086#1082
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  DesignSize = (
    484
    232)
  PixelsPerInch = 96
  TextHeight = 13
  object labInfo: TLabel
    Left = 18
    Top = 12
    Width = 48
    Height = 13
    Caption = '                '
  end
  object labStarted: TLabel
    Left = 20
    Top = 96
    Width = 54
    Height = 13
    Caption = #1047#1072#1087#1091#1097#1077#1085#1086':'
  end
  object labFinished: TLabel
    Left = 20
    Top = 114
    Width = 57
    Height = 13
    Caption = #1047#1072#1082#1086#1085#1095#1077#1085#1086':'
  end
  object labFinishedTime: TLabel
    Left = 78
    Top = 114
    Width = 12
    Height = 13
    Caption = '    '
  end
  object labStartedTime: TLabel
    Left = 78
    Top = 96
    Width = 12
    Height = 13
    Caption = '    '
  end
  object labFoundHLink: TLabel
    Left = 296
    Top = 96
    Width = 92
    Height = 13
    Caption = #1053#1072#1081#1076#1077#1085#1086' HLink'#39#1086#1074':'
  end
  object labFoundSub: TLabel
    Left = 296
    Top = 114
    Width = 83
    Height = 13
    Caption = #1053#1072#1081#1076#1077#1085#1086' Sub'#39#1086#1074':'
  end
  object labFoundSubNum: TLabel
    Left = 424
    Top = 114
    Width = 12
    Height = 13
    Caption = '    '
  end
  object labFoundHLinkNum: TLabel
    Left = 424
    Top = 96
    Width = 12
    Height = 13
    Caption = '    '
  end
  object Label1: TLabel
    Left = 14
    Top = 188
    Width = 170
    Height = 13
    Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074'-'#1092#1072#1085#1090#1086#1084#1086#1074
  end
  object bGo: TButton
    Left = 136
    Top = 148
    Width = 235
    Height = 25
    Caption = #1057#1090#1072#1088#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = bGoClick
  end
  object FileMeter: TW95Meter
    Left = 16
    Top = 40
    Width = 454
    Anchors = [akLeft, akTop, akRight]
  end
  object FilesMeter: TW95Meter
    Left = 16
    Top = 64
    Width = 454
    Anchors = [akLeft, akTop, akRight]
  end
  object BadDocsDirEdit: TDirectoryEdit
    Left = 12
    Top = 204
    Width = 243
    Height = 21
    DialogText = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1087#1086#1090#1077#1088#1103#1085#1085#1099#1093' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
    DialogOptions = [sdAllowCreate, sdPerformCreate, sdPrompt]
    NumGlyphs = 1
    TabOrder = 3
  end
  object bDownload: TButton
    Left = 264
    Top = 202
    Width = 211
    Height = 25
    Caption = #1057#1083#1080#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1099'-'#1092#1072#1085#1090#1086#1084#1099
    TabOrder = 4
    OnClick = bDownloadClick
  end
end
