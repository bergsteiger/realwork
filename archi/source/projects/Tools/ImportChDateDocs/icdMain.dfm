object Form1: TForm1
  Left = 613
  Top = 275
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1047#1072#1083#1080#1074#1082#1072' '#1076#1072#1085#1085#1099#1093' chdate'
  ClientHeight = 140
  ClientWidth = 399
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
    Left = 8
    Top = 16
    Width = 139
    Height = 13
    Caption = #1048#1084#1103' CVS-'#1092#1072#1081#1083#1072' '#1089' '#1076#1072#1085#1085#1099#1084#1080
  end
  object lblDisplay: TLabel
    Left = 8
    Top = 56
    Width = 385
    Height = 13
    AutoSize = False
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 72
    Width = 385
    Height = 17
    TabOrder = 0
  end
  object btnStart: TButton
    Left = 286
    Top = 104
    Width = 107
    Height = 25
    Caption = #1053#1072#1095#1072#1090#1100
    TabOrder = 1
    OnClick = btnStartClick
  end
  object feSource: TFilenameEdit
    Left = 8
    Top = 32
    Width = 385
    Height = 21
    Filter = 'CSV '#1092#1072#1081#1083#1099' (*.csv)|*.csv;*.log'
    NumGlyphs = 1
    TabOrder = 2
  end
end
