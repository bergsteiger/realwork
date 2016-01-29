object ddConfirmSplitDialog: TddConfirmSplitDialog
  Left = 295
  Top = 110
  BorderStyle = bsDialog
  Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077
  ClientHeight = 114
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  object radioAction: TRadioGroup
    Left = 8
    Top = 8
    Width = 261
    Height = 61
    Caption = #1044#1077#1081#1089#1090#1074#1080#1077' '#1085#1072#1076' '#1073#1083#1086#1082#1072#1084#1080
    ItemIndex = 0
    Items.Strings = (
      #1086#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1074' '#1086#1076#1080#1085' '#1073#1083#1086#1082
      #1074#1083#1086#1078#1080#1090#1100' '#1086#1076#1080#1085' '#1074' '#1076#1088#1091#1075#1086#1081)
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 108
    Top = 80
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 192
    Top = 80
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    Kind = bkCancel
  end
end
