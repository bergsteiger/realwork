object MainForm: TMainForm
  Left = 75
  Top = 120
  Width = 827
  Height = 185
  Caption = #1048#1085#1076#1077#1082#1089#1072#1094#1080#1103' '#1073#1072#1079#1099
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
    819
    158)
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
    Width = 600
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
  end
  object btCopy: TButton
    Left = 7
    Top = 7
    Width = 91
    Height = 20
    Caption = #1048#1085#1076#1077#1082#1089#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 0
    OnClick = btCopyClick
  end
  object FileMeter: TvtW95Meter
    Left = 7
    Top = 46
    Width = 646
    Height = 15
    Anchors = [akLeft, akTop, akRight]
  end
  object FilesMeter: TvtW95Meter
    Left = 7
    Top = 80
    Width = 646
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
  object edBaseDir: TEdit
    Left = 182
    Top = 7
    Width = 313
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
  object pnStatus: TPanel
    Left = 0
    Top = 135
    Width = 819
    Height = 23
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
  object seIndexID: TvtSpinEdit
    Left = 494
    Top = 7
    Width = 159
    Height = 24
    UseMaxValue = False
    Value = 1.000000000000000000
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
  end
  object cbPacked: TCheckBox
    Left = 392
    Top = 33
    Width = 103
    Height = 13
    Caption = #1059#1087#1072#1082#1086#1074#1099#1074#1072#1090#1100
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object cbDelta: TCheckBox
    Left = 501
    Top = 33
    Width = 78
    Height = 13
    Caption = #1044#1077#1083#1100#1090#1072
    TabOrder = 8
  end
  object cbFake: TCheckBox
    Left = 585
    Top = 33
    Width = 79
    Height = 13
    Caption = #1042' '#1087#1091#1089#1090#1086#1090#1091
    TabOrder = 9
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
