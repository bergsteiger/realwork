object MainForm: TMainForm
  Left = 190
  Top = 120
  Width = 696
  Height = 295
  Caption = #1055#1086#1080#1089#1082' '#1086#1096#1080#1073#1086#1082'.'
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
    688
    268)
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
    Width = 500
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
  end
  object lbPercent: TLabel
    Left = 52
    Top = 65
    Width = 494
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
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
    Top = 46
    Width = 540
    Height = 15
    Anchors = [akLeft, akTop, akRight]
  end
  object FilesMeter: TvtW95Meter
    Left = 7
    Top = 80
    Width = 540
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
    Left = 182
    Top = 7
    Width = 261
    Height = 21
    NumGlyphs = 1
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
  object pnStatus: TPanel
    Left = 0
    Top = 244
    Width = 688
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
  object seMinNum: TvtSpinEdit
    Left = 449
    Top = 7
    Width = 98
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
  end
  object cbHyphen: TCheckBox
    Left = 203
    Top = 128
    Width = 194
    Height = 13
    Caption = #1055#1077#1088#1077#1085#1086#1089#1099
    TabOrder = 7
  end
  object cbDict: TCheckBox
    Left = 203
    Top = 115
    Width = 188
    Height = 13
    Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1089#1083#1086#1074#1072#1088#1100
    TabOrder = 8
  end
  object cbAlternate: TCheckBox
    Left = 203
    Top = 102
    Width = 188
    Height = 13
    Caption = #1040#1083#1100#1090#1077#1088#1085#1072#1090#1080#1074#1099
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
  object gbInfo: TGroupBox
    Left = 7
    Top = 98
    Width = 182
    Height = 103
    Caption = #1063#1090#1086' '#1089#1086#1073#1080#1088#1072#1090#1100'?'
    TabOrder = 10
    object rbErrors: TRadioButton
      Left = 7
      Top = 20
      Width = 91
      Height = 13
      Caption = #1054#1096#1080#1073#1082#1080
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbErrorsClick
    end
    object rbHyperlinks: TRadioButton
      Left = 7
      Top = 39
      Width = 91
      Height = 14
      Caption = #1057#1089#1099#1083#1082#1080
      TabOrder = 1
      OnClick = rbErrorsClick
    end
    object rbSubs: TRadioButton
      Left = 7
      Top = 59
      Width = 91
      Height = 13
      Caption = #1052#1077#1090#1082#1080
      TabOrder = 2
      OnClick = rbErrorsClick
    end
    object rbBlocks: TRadioButton
      Left = 85
      Top = 20
      Width = 91
      Height = 13
      Caption = #1041#1083#1086#1082#1080
      TabOrder = 3
      OnClick = rbErrorsClick
    end
    object rbSize: TRadioButton
      Left = 85
      Top = 39
      Width = 91
      Height = 14
      Caption = #1056#1072#1079#1084#1077#1088
      TabOrder = 4
    end
    object rb1252: TRadioButton
      Left = 85
      Top = 59
      Width = 91
      Height = 13
      Caption = '1252'
      TabOrder = 5
    end
    object rbEmpty: TRadioButton
      Left = 8
      Top = 80
      Width = 73
      Height = 17
      Caption = #1055#1091#1089#1090#1099#1077
      TabOrder = 6
    end
  end
  object cbOld: TCheckBox
    Left = 8
    Top = 208
    Width = 169
    Height = 17
    Caption = #1057#1090#1072#1088#1086#1077' '#1093#1088#1072#1085#1080#1083#1080#1097#1077
    TabOrder = 11
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
    Left = 656
    Top = 120
  end
end
