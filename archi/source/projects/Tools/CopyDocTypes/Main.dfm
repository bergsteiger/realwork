object MainForm: TMainForm
  Left = 300
  Top = 107
  BorderStyle = bsDialog
  Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1090#1080#1087#1086#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1087#1086' '#1090#1072#1073#1083#1080#1094#1077' FILE'
  ClientHeight = 137
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  DesignSize = (
    688
    137)
  PixelsPerInch = 96
  TextHeight = 13
  object lbFile: TLabel
    Left = 184
    Top = 19
    Width = 217
    Height = 13
    AutoSize = False
  end
  object lbFiles: TLabel
    Left = 24
    Top = 96
    Width = 241
    Height = 13
    AutoSize = False
  end
  object btStart: TButton
    Left = 20
    Top = 14
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = btStartClick
  end
  object btStop: TButton
    Left = 104
    Top = 14
    Width = 75
    Height = 25
    Caption = 'Stop'
    Enabled = False
    TabOrder = 1
    OnClick = btStopClick
  end
  object FileMeter: TW95Meter
    Left = 24
    Top = 48
    Width = 649
    OnSetStr = FileMeterSetStr
    Anchors = [akLeft, akTop, akRight]
  end
  object FilesMeter: TW95Meter
    Left = 24
    Top = 72
    Width = 649
    OnSetStr = FilesMeterSetStr
    Anchors = [akLeft, akTop, akRight]
  end
end
