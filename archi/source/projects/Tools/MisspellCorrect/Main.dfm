object MainForm: TMainForm
  Left = 383
  Top = 217
  Width = 613
  Height = 208
  Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1077' '#1080#1089#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1086#1087#1077#1095#1072#1090#1086#1082
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    597
    172)
  PixelsPerInch = 96
  TextHeight = 13
  object lbFile: TLabel
    Left = 7
    Top = 81
    Width = 29
    Height = 13
    Caption = #1060#1072#1081#1083
  end
  object lbFiles: TLabel
    Left = 7
    Top = 114
    Width = 37
    Height = 13
    Caption = #1060#1072#1081#1083#1099
  end
  object lbNum: TLabel
    Left = 47
    Top = 79
    Width = 417
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
  end
  object lbPercent: TLabel
    Left = 52
    Top = 113
    Width = 411
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
  end
  object Label1: TLabel
    Left = 208
    Top = 8
    Width = 63
    Height = 13
    Caption = #1055#1091#1090#1100' '#1082' '#1073#1072#1079#1077':'
  end
  object lblTopicListFN: TLabel
    Left = 8
    Top = 44
    Width = 135
    Height = 13
    Caption = #1060#1072#1081#1083' '#1089#1086' '#1089#1087#1080#1089#1082#1086#1084' '#1090#1086#1087#1080#1082#1086#1074
    FocusControl = edTopicListFN
  end
  object btCopy: TButton
    Left = 7
    Top = 7
    Width = 91
    Height = 20
    Caption = #1053#1072#1095#1072#1090#1100
    Default = True
    TabOrder = 0
    OnClick = btCopyClick
  end
  object FileMeter: TvtW95Meter
    Left = 7
    Top = 94
    Width = 578
    Height = 15
    Anchors = [akLeft, akTop, akRight]
  end
  object FilesMeter: TvtW95Meter
    Left = 7
    Top = 128
    Width = 578
    Height = 14
    OnSetStr = FilesMeterSetStr
    Anchors = [akLeft, akTop, akRight]
  end
  object btStop: TButton
    Left = 104
    Top = 7
    Width = 72
    Height = 20
    Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = btStopClick
  end
  object edBaseDir: TDirectoryEdit
    Left = 280
    Top = 4
    Width = 305
    Height = 21
    NumGlyphs = 1
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
  object pnStatus: TPanel
    Left = 0
    Top = 148
    Width = 597
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    object btStat: TSpeedButton
      Left = 2
      Top = 2
      Width = 19
      Height = 18
      Caption = '?'
      OnClick = btStatClick
    end
    object btHideFileMeter: TSpeedButton
      Left = 24
      Top = 2
      Width = 19
      Height = 18
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'H'
      OnClick = btHideFileMeterClick
    end
  end
  object edTopicListFN: TFilenameEdit
    Left = 152
    Top = 40
    Width = 433
    Height = 21
    NumGlyphs = 1
    TabOrder = 6
    Text = 'C:\Users\'#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088'\Desktop\misspell.txt'
  end
  object OvcController: TOvcController
    EntryCommands.TableList = (
      'Default'
      True
      (
        2474123
        0)
      'WordStar'
      False
      ()
      'List'
      False
      ()
      'Grid'
      False
      ())
    Left = 552
    Top = 144
  end
end
