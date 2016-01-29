object MainForm: TMainForm
  Left = 354
  Top = 260
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1088#1077#1075#1080#1086#1085#1086#1074' '#1074' UserID'
  ClientHeight = 142
  ClientWidth = 422
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dispRegion: TLabel
    Left = 10
    Top = 8
    Width = 123
    Height = 13
    Caption = '<'#1088#1077#1075#1080#1086#1085' '#1085#1077' '#1091#1089#1090#1072#1085#1086#1074#1083#1077#1085'>'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 56
    Width = 409
    Height = 17
    Shape = bsTopLine
  end
  object btnRegionChange: TButton
    Left = 8
    Top = 24
    Width = 75
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
    TabOrder = 0
    OnClick = btnRegionChangeClick
  end
  object btnStart: TButton
    Left = 88
    Top = 80
    Width = 233
    Height = 41
    Caption = #1053#1072#1095#1072#1090#1100' '#1086#1073#1088#1072#1073#1086#1090#1082#1091' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
    TabOrder = 1
    OnClick = btnStartClick
  end
  object XPManifest1: TXPManifest
    Left = 384
    Top = 8
  end
end
