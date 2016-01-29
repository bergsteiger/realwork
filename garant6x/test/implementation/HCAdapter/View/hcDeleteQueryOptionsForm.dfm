object frmDeleteQueryOptions: TfrmDeleteQueryOptions
  Left = 477
  Top = 262
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1081#1089#1090#1088#1086#1081#1082#1080' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1082#1086#1085#1089#1091#1083#1100#1090#1072#1094#1080#1081
  ClientHeight = 128
  ClientWidth = 349
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object rgKindDelete: TRadioGroup
    Left = 0
    Top = 0
    Width = 349
    Height = 79
    Align = alClient
    Caption = #1042#1080#1076' '#1091#1076#1072#1083#1077#1085#1080#1103':'
    ItemIndex = 0
    Items.Strings = (
      #1058#1086#1083#1100#1082#1086' '#1079#1072#1087#1088#1086#1089#1099' '#1089' '#1088#1072#1079#1088#1077#1096#1077#1085#1085#1099#1084#1080' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1089#1090#1072#1090#1091#1089#1072#1084#1080
      #1053#1077#1079#1072#1074#1080#1089#1080#1084#1086' '#1086#1090' '#1089#1090#1072#1090#1091#1089#1072)
    TabOrder = 0
  end
  object pnlButton: TPanel
    Left = 0
    Top = 79
    Width = 349
    Height = 49
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      349
      49)
    object btnOK: TButton
      Left = 176
      Top = 13
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 264
      Top = 13
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
  end
end
