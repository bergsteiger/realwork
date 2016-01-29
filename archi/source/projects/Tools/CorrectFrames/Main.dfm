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
    680
    259)
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
    Top = 235
    Width = 680
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
  object vtVersionDate: TvtDateEdit
    Left = 8
    Top = 104
    Width = 121
    Height = 24
    Style = csDropDown
    TabOrder = 7
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
    Left = 416
    Top = 104
  end
end
