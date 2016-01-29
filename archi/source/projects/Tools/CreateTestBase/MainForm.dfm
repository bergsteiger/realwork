object TestForm: TTestForm
  Left = 480
  Top = 392
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1090#1077#1089#1090#1086#1074#1086#1081' '#1073#1072#1079#1099'.'
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
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object lblGlobalStatus: TLabel
    Left = 14
    Top = 15
    Width = 3
    Height = 14
  end
  object DBPath: TLabel
    Left = 8
    Top = 72
    Width = 35
    Height = 14
    Caption = 'DBPath'
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
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 40
    Width = 385
    Height = 17
    TabOrder = 1
  end
end
