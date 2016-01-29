object MainForm: TMainForm
  Left = 272
  Top = 145
  Width = 870
  Height = 640
  Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
  Color = $00F9F8FA
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Toolbar: TvtPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 41
    Align = alTop
    TabOrder = 0
  end
  object Footer: TvtPanel
    Left = 0
    Top = 572
    Width = 862
    Height = 41
    Align = alBottom
    TabOrder = 1
  end
  object evEditor1: TevEditor
    Left = 0
    Top = 41
    Width = 862
    Height = 531
    Align = alClient
    TextSource = TextSource
    TabOrder = 2
    TabStop = True
  end
  object TextSource: TevTextSource
    Left = 8
    Top = 48
  end
end
