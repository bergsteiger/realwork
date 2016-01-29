object MainForm: TMainForm
  Left = 451
  Top = 333
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'MainForm'
  ClientHeight = 385
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 22
    Height = 13
    Caption = #1051#1086#1075':'
  end
  object Button1: TButton
    Left = 112
    Top = 352
    Width = 313
    Height = 25
    Caption = #1057#1076#1077#1083#1072#1090#1100' '#1074#1089#1105' '#1082#1072#1082' '#1085#1072#1076#1086
    TabOrder = 0
    OnClick = Button1Click
  end
  object memLog: TMemo
    Left = 8
    Top = 24
    Width = 521
    Height = 329
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
