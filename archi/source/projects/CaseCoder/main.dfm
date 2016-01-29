object MainForm: TMainForm
  Left = 154
  Top = 215
  Width = 585
  Height = 341
  Caption = #1056#1072#1089#1089#1090#1072#1085#1086#1074#1097#1080#1082' '#1085#1086#1084#1077#1088#1086#1074' '#1076#1077#1083
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
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 240
    Width = 553
    Height = 17
    TabOrder = 0
  end
  object WorkSpace: TPanel
    Left = 0
    Top = 0
    Width = 569
    Height = 233
    BevelOuter = bvNone
    TabOrder = 1
  end
  object Button1: TButton
    Left = 392
    Top = 264
    Width = 75
    Height = 25
    Caption = #1056#1072#1089#1089#1090#1072#1074#1080#1090#1100
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 480
    Top = 264
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = Button2Click
  end
end
