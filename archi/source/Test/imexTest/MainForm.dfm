object TestForm: TTestForm
  Left = 480
  Top = 392
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '"'#1040#1088#1093#1080#1074#1072#1088#1080#1091#1089'". '#1058#1077#1089#1090' '#1080#1084#1087#1086#1088#1090#1072'/'#1101#1082#1089#1087#1086#1088#1090#1072
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
  end
end
