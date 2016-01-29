object MainForm: TMainForm
  Left = 364
  Top = 277
  Width = 631
  Height = 373
  Caption = #1059#1076#1072#1083#1077#1085#1080#1077' "'#1087#1086#1083#1091#1095#1077#1085#1086' '#1087#1086' '#1088#1072#1089#1089#1099#1083#1082#1077'"'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    615
    337)
  PixelsPerInch = 96
  TextHeight = 13
  object memLog: TMemo
    Left = 8
    Top = 64
    Width = 598
    Height = 263
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Lucida Console'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 169
    Height = 49
    Caption = #1053#1072#1095#1072#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
  object XPManifest1: TXPManifest
    Left = 440
    Top = 16
  end
end
