object TestForm: TTestForm
  Left = 480
  Top = 392
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1058#1077#1089#1090' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1074' '#1073#1072#1079#1091
  ClientHeight = 148
  ClientWidth = 407
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  Visible = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object lblGlobalStatus: TLabel
    Left = 14
    Top = 15
    Width = 71
    Height = 14
    Caption = 'lblGlobalStatus'
  end
  object Panel1: TPanel
    Left = 0
    Top = 98
    Width = 407
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnGo: TButton
      Left = 236
      Top = 8
      Width = 75
      Height = 25
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      Default = True
      TabOrder = 0
      OnClick = btnGoClick
    end
    object CancelButton: TButton
      Tag = 100
      Left = 321
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 1
      OnClick = CancelButtonClick
    end
    object ClearBaseBTN: TButton
      Left = 120
      Top = 8
      Width = 107
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1073#1072#1079#1091
      TabOrder = 2
      OnClick = ClearBaseBTNClick
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 136
    Top = 32
  end
end
