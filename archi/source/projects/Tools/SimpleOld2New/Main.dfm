object MainForm: TMainForm
  Left = 326
  Top = 303
  BorderStyle = bsDialog
  Caption = #1055#1077#1088#1077#1083#1080#1074#1082#1072' '#1073#1072#1079#1099
  ClientHeight = 133
  ClientWidth = 582
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
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
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 81
    Height = 13
    Caption = #1044#1080#1088#1077#1082#1090#1086#1088#1080#1103' '#1041#1044
  end
  object btCopy: TButton
    Left = 460
    Top = 11
    Width = 102
    Height = 24
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
  object pnStatus: TPanel
    Left = 0
    Top = 110
    Width = 582
    Height = 23
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
  end
  object edBaseDir: TDirectoryEdit
    Left = 114
    Top = 12
    Width = 281
    Height = 21
    NumGlyphs = 1
    TabOrder = 1
  end
end
