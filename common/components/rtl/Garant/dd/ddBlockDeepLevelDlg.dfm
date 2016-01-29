object ddBlockDeepLevelDialog: TddBlockDeepLevelDialog
  Left = 334
  Top = 134
  Anchors = [akLeft]
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1089#1090#1088#1091#1082#1090#1091#1088#1099' '#1073#1083#1086#1082#1086#1074
  ClientHeight = 253
  ClientWidth = 233
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnPaint = FormPaint
  OnShow = FormShow
  DesignSize = (
    233
    253)
  PixelsPerInch = 96
  TextHeight = 15
  object BitBtn1: TBitBtn
    Left = 56
    Top = 221
    Width = 81
    Height = 25
    Anchors = [akLeft]
    TabOrder = 0
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 144
    Top = 221
    Width = 85
    Height = 25
    Anchors = [akLeft]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    Kind = bkCancel
  end
  object comboDeepLevel: TRadioGroup
    Left = 4
    Top = 4
    Width = 225
    Height = 149
    Caption = #1059#1088#1086#1074#1077#1085#1100' '#1074#1083#1086#1078#1077#1085#1085#1086#1089#1090#1080
    ItemIndex = 2
    Items.Strings = (
      '1 '#1091#1088#1086#1074#1077#1085#1100
      '2 '#1091#1088#1086#1074#1085#1103
      '3 '#1091#1088#1086#1074#1085#1103
      '4 '#1091#1088#1086#1074#1085#1103
      '5 '#1091#1088#1086#1074#1085#1077#1081
      #1041#1086#1083#1100#1096#1077' '#1087#1103#1090#1080' '#1091#1088#1086#1074#1085#1077#1081)
    TabOrder = 2
  end
  object checkConfirmJoin: TCheckBox
    Left = 4
    Top = 156
    Width = 225
    Height = 21
    Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1072#1090#1100' '#1089#1083#1080#1103#1085#1080#1077' '#1079#1072#1075#1086#1083#1086#1074#1082#1086#1074
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object cbUseFootnotes: TCheckBox
    Left = 4
    Top = 180
    Width = 221
    Height = 17
    Caption = #1042#1099#1076#1077#1083#1103#1090#1100' '#1089#1085#1086#1089#1082#1080' '#1074' '#1073#1083#1086#1082
    TabOrder = 4
  end
  object cbTuneStructure: TCheckBox
    Left = 4
    Top = 200
    Width = 225
    Height = 17
    Caption = #1053#1072#1089#1090#1088#1072#1080#1074#1072#1090#1100' '#1089#1090#1088#1091#1082#1090#1091#1088#1091
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
end
