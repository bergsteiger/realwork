object MainForm: TMainForm
  Left = 590
  Top = 422
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1076#1080#1072#1087#1072#1079#1086#1085#1086#1074
  ClientHeight = 101
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblDiaName: TLabel
    Left = 16
    Top = 8
    Width = 79
    Height = 13
    Caption = #1048#1084#1103' '#1076#1080#1072#1087#1072#1079#1086#1085#1072
  end
  object lblDiapason: TLabel
    Left = 224
    Top = 8
    Width = 98
    Height = 13
    Caption = #1044#1080#1072#1087#1072#1079#1086#1085' '#1085#1086#1084#1077#1088#1086#1074
    FocusControl = edDiapason
  end
  object cbDiaName: TComboBox
    Left = 16
    Top = 24
    Width = 193
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    OnChange = CheckInput
    OnSelect = cbDiaNameSelect
  end
  object edDiapason: TEdit
    Left = 224
    Top = 24
    Width = 297
    Height = 21
    TabOrder = 1
    OnChange = CheckInput
  end
  object btnStart: TButton
    Left = 416
    Top = 64
    Width = 107
    Height = 25
    Cursor = crArrow
    Caption = #1053#1072#1095#1072#1090#1100' '#1086#1073#1088#1072#1073#1086#1090#1082#1091
    Enabled = False
    TabOrder = 2
    OnClick = btnStartClick
  end
  object ProgressBar: TProgressBar
    Left = 16
    Top = 69
    Width = 393
    Height = 17
    TabOrder = 3
    Visible = False
  end
  object XPManifest1: TXPManifest
    Left = 88
    Top = 24
  end
end
