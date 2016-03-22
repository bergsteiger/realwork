object Form1: TForm1
  Left = 320
  Top = 194
  Width = 658
  Height = 605
  Caption = #1057#1088#1072#1074#1085#1077#1085#1080#1077' '#1089#1072#1073#1086#1074' '#1080' '#1072#1090#1088#1080#1073#1091#1090#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    642
    567)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 115
    Height = 13
    Caption = #1060#1072#1081#1083#1099' '#1076#1083#1103' '#1089#1088#1072#1074#1085#1077#1085#1080#1103
  end
  object fnFile1: TFilenameEdit
    Left = 16
    Top = 24
    Width = 521
    Height = 21
    DefaultExt = 'evd'
    Filter = 'EVD '#1092#1072#1081#1083#1099' (*.evd)|*.evd'
    Anchors = [akLeft, akTop, akRight]
    NumGlyphs = 1
    TabOrder = 0
  end
  object fnFile2: TFilenameEdit
    Left = 16
    Top = 56
    Width = 521
    Height = 21
    DefaultExt = 'evd'
    Filter = 'EVD '#1092#1072#1081#1083#1099' (*.evd)|*.evd'
    Anchors = [akLeft, akTop, akRight]
    NumGlyphs = 1
    TabOrder = 1
  end
  object btnDoJob: TButton
    Left = 544
    Top = 24
    Width = 89
    Height = 49
    Anchors = [akTop, akRight]
    Caption = #1057#1088#1072#1074#1085#1080#1090#1100
    Default = True
    TabOrder = 2
    OnClick = btnDoJobClick
  end
  object memResult: TMemo
    Left = 16
    Top = 88
    Width = 617
    Height = 465
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      #1058#1091#1090' '#1073#1091#1076#1077#1090' '#1088#1077#1079#1091#1083#1100#1090#1072#1090' '#1089#1088#1072#1074#1085#1077#1085#1080#1103'...')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
end
