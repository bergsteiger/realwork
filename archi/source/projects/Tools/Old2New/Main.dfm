object MainForm: TMainForm
  Left = 290
  Top = 169
  Width = 590
  Height = 363
  Caption = #1055#1077#1088#1077#1083#1080#1074#1082#1072' '#1073#1072#1079#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbFile: TLabel
    Left = 7
    Top = 33
    Width = 29
    Height = 13
    Caption = #1060#1072#1081#1083
  end
  object lbFiles: TLabel
    Left = 7
    Top = 66
    Width = 37
    Height = 13
    Caption = #1060#1072#1081#1083#1099
  end
  object lbNum: TLabel
    Left = 47
    Top = 31
    Width = 123
    Height = 13
    AutoSize = False
  end
  object lbPercent: TLabel
    Left = 52
    Top = 65
    Width = 495
    Height = 13
    AutoSize = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 112
    Width = 249
    Height = 193
    TabOrder = 7
    object cbDouble: TCheckBox
      Left = 32
      Top = 40
      Width = 79
      Height = 14
      Caption = #1044#1074#1072' '#1088#1072#1079#1072
      TabOrder = 1
    end
    object cbBlocks: TCheckBox
      Left = 16
      Top = 24
      Width = 124
      Height = 14
      Caption = #1041#1083#1086#1095#1085#1072#1103' '#1089#1090#1088#1091#1082#1090#1091#1088#1072
      TabOrder = 0
    end
    object cbIntoVersion: TCheckBox
      Left = 16
      Top = 144
      Width = 209
      Height = 17
      Caption = #1044#1086#1073#1072#1074#1083#1103#1090#1100' '#1074' '#1087#1077#1088#1077#1084#1077#1085#1085#1091#1102' '#1095#1072#1089#1090#1100
      TabOrder = 3
    end
    object rgRewrite: TRadioGroup
      Left = 16
      Top = 64
      Width = 217
      Height = 73
      Caption = #1055#1077#1088#1077#1079#1072#1087#1080#1089#1099#1074#1072#1090#1100
      ItemIndex = 1
      Items.Strings = (
        #1042#1089#1077
        #1055#1091#1089#1090#1099#1077' '#1080' '#1086#1089#1091#1090#1089#1090#1074#1091#1102#1097#1080#1077
        #1054#1090#1089#1091#1090#1089#1090#1074#1091#1102#1097#1080#1077)
      TabOrder = 2
    end
  end
  object btCopy: TButton
    Left = 7
    Top = 7
    Width = 65
    Height = 20
    Caption = #1055#1077#1088#1077#1083#1080#1090#1100
    TabOrder = 0
    OnClick = btCopyClick
  end
  object FileMeter: TvtW95Meter
    Left = 7
    Top = 46
    Width = 569
    Height = 19
  end
  object FilesMeter: TvtW95Meter
    Left = 7
    Top = 80
    Width = 569
    Height = 20
    OnSetStr = FilesMeterSetStr
  end
  object btStop: TButton
    Left = 78
    Top = 7
    Width = 72
    Height = 20
    Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = btStopClick
  end
  object pnStatus: TPanel
    Left = 0
    Top = 313
    Width = 582
    Height = 23
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 8
    object btStat: TSpeedButton
      Left = 562
      Top = 2
      Width = 19
      Height = 18
      Caption = '?'
      OnClick = btStatClick
    end
  end
  object seMinNum: TvtSpinEdit
    Left = 449
    Top = 7
    Width = 127
    Height = 24
    TabOrder = 3
  end
  object edBaseDir: TDirectoryEdit
    Left = 160
    Top = 8
    Width = 281
    Height = 21
    NumGlyphs = 1
    TabOrder = 2
  end
  object cbOldToNew: TCheckBox
    Left = 16
    Top = 110
    Width = 169
    Height = 17
    Caption = #1055#1077#1088#1077#1083#1080#1090#1100' '#1080#1079' '#1089#1090#1072#1088#1086#1081' '#1074' '#1085#1086#1074#1091#1102
    TabOrder = 4
  end
  object gbMakeCopy: TGroupBox
    Left = 264
    Top = 112
    Width = 225
    Height = 105
    TabOrder = 9
    object cbMakeCopy: TCheckBox
      Left = 8
      Top = 0
      Width = 97
      Height = 17
      Caption = #1057#1076#1077#1083#1072#1090#1100' '#1082#1086#1087#1080#1102
      TabOrder = 0
    end
    object cbFromOld: TCheckBox
      Left = 24
      Top = 19
      Width = 97
      Height = 17
      Caption = #1048#1079' '#1089#1090#1072#1088#1086#1075#1086
      TabOrder = 1
    end
    object cbToOld: TCheckBox
      Left = 24
      Top = 39
      Width = 97
      Height = 17
      Caption = #1042' '#1089#1090#1072#1088#1086#1077
      TabOrder = 2
    end
    object cbModified: TCheckBox
      Left = 24
      Top = 59
      Width = 153
      Height = 17
      Caption = #1055#1077#1088#1077#1084#1077#1085#1085#1091#1102' '#1095#1072#1089#1090#1100
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object cbNotEmpty: TCheckBox
      Left = 25
      Top = 79
      Width = 152
      Height = 17
      Caption = #1053#1077' '#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1087#1091#1089#1090#1099#1077
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
  end
  object gbUpdate: TGroupBox
    Left = 264
    Top = 224
    Width = 225
    Height = 81
    TabOrder = 10
    object cbUpdate: TCheckBox
      Left = 8
      Top = 0
      Width = 185
      Height = 17
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1087#1077#1088#1077#1084#1077#1085#1085#1091#1102' '#1095#1072#1089#1090#1100
      TabOrder = 0
    end
    object cbNotUpdateEmpty: TCheckBox
      Left = 24
      Top = 24
      Width = 161
      Height = 17
      Caption = #1053#1077' '#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1087#1091#1089#1090#1099#1077
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
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
    Left = 528
    Top = 120
  end
end
