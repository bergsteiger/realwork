object MainForm: TMainForm
  Left = 114
  Top = 349
  BorderStyle = bsDialog
  Caption = 
    #1055#1086#1080#1089#1082' '#1085#1086#1084#1077#1088#1086#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074', '#1080#1084#1077#1102#1097#1080#1093#1089#1103' '#1074' '#1093#1088#1072#1085#1080#1083#1080#1097#1077', '#1085#1086' '#1086#1090#1089#1091#1090#1089#1090#1074#1091#1102#1097#1080 +
    #1093' '#1074' '#1041#1044
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
  OnClose = FormClose
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
  object bStart: TButton
    Left = 24
    Top = 12
    Width = 75
    Height = 25
    Caption = #1047#1072#1087#1091#1089#1082
    TabOrder = 2
    OnClick = bStartClick
  end
  object bStop: TButton
    Left = 108
    Top = 12
    Width = 75
    Height = 25
    Caption = #1055#1088#1077#1088#1074#1072#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = bStopClick
  end
  object bSave: TButton
    Left = 530
    Top = 12
    Width = 141
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083' ...'
    Enabled = False
    TabOrder = 4
    OnClick = bSaveClick
  end
end
