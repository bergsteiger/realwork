object MainForm: TMainForm
  Left = 363
  Top = 252
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1048#1089#1087#1088#1072#1074#1083#1103#1090#1086#1088' '#1086#1087#1077#1095#1072#1090#1086#1082
  ClientHeight = 287
  ClientWidth = 477
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 222
    Width = 477
    Height = 65
    Align = alBottom
    TabOrder = 0
    object ProgressBar: TProgressBar
      Left = 4
      Top = 4
      Width = 469
      Height = 17
      TabOrder = 0
    end
    object btnGo: TButton
      Left = 336
      Top = 30
      Width = 131
      Height = 25
      Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100' '#1086#1087#1077#1095#1072#1090#1082#1080
      TabOrder = 1
      OnClick = btnGoClick
    end
  end
  object pnlSettings: TPanel
    Left = 0
    Top = 0
    Width = 477
    Height = 222
    Align = alClient
    TabOrder = 1
  end
end
