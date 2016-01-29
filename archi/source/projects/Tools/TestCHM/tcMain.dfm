object Form1: TForm1
  Left = 589
  Top = 281
  Width = 534
  Height = 156
  Caption = #1055#1088#1086#1074#1077#1088#1103#1083#1082#1072' CHM'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 110
    Height = 13
    Caption = #1060#1072#1081#1083' '#1089#1087#1088#1072#1074#1082#1080' (*.chm)'
  end
  object Label2: TLabel
    Left = 16
    Top = 64
    Width = 47
    Height = 13
    Caption = #1050#1086#1085#1090#1077#1082#1089#1090
  end
  object feCHM: TFilenameEdit
    Left = 16
    Top = 32
    Width = 489
    Height = 21
    Filter = #1060#1072#1081#1083#1099' '#1089#1087#1088#1072#1074#1082#1080' (*.chm)|*.chm'
    NumGlyphs = 1
    TabOrder = 0
  end
  object edContext: TEdit
    Left = 16
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object btnOpen: TButton
    Left = 144
    Top = 78
    Width = 75
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = btnOpenClick
  end
end
