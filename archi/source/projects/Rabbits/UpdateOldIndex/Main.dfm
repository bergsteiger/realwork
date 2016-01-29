object MainForm: TMainForm
  Left = 190
  Top = 120
  Width = 761
  Height = 185
  Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1080#1085#1076#1077#1082#1089#1072'.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    753
    153)
  PixelsPerInch = 120
  TextHeight = 16
  object lbFile: TLabel
    Left = 8
    Top = 40
    Width = 38
    Height = 16
    Caption = #1060#1072#1081#1083
  end
  object lbFiles: TLabel
    Left = 8
    Top = 81
    Width = 48
    Height = 16
    Caption = #1060#1072#1081#1083#1099
  end
  object lbNum: TLabel
    Left = 58
    Top = 38
    Width = 327
    Height = 16
    AutoSize = False
  end
  object lbPercent: TLabel
    Left = 64
    Top = 80
    Width = 673
    Height = 16
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
  end
  object btCopy: TButton
    Left = 8
    Top = 8
    Width = 113
    Height = 25
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    Default = True
    TabOrder = 0
    OnClick = btCopyClick
  end
  object FileMeter: TvtW95Meter
    Left = 8
    Top = 57
    Width = 730
    Anchors = [akLeft, akTop, akRight]
  end
  object FilesMeter: TvtW95Meter
    Left = 8
    Top = 98
    Width = 730
    OnSetStr = FilesMeterSetStr
    Anchors = [akLeft, akTop, akRight]
  end
  object btStop: TButton
    Left = 128
    Top = 8
    Width = 89
    Height = 25
    Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = btStopClick
  end
  object edBaseDir: TEdit
    Left = 224
    Top = 8
    Width = 513
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
  object pnStatus: TPanel
    Left = 0
    Top = 124
    Width = 753
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    object btStat: TSpeedButton
      Left = 3
      Top = 3
      Width = 23
      Height = 22
      Caption = '?'
      OnClick = btStatClick
    end
    object btHideFileMeter: TSpeedButton
      Left = 30
      Top = 3
      Width = 23
      Height = 22
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'H'
      OnClick = btHideFileMeterClick
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
    Left = 656
    Top = 120
  end
end
