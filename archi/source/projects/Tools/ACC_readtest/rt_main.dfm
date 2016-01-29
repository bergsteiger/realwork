object Form1: TForm1
  Left = 558
  Top = 341
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1060#1086#1088#1084#1072
  ClientHeight = 295
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    473
    295)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 123
    Height = 13
    Caption = #1055#1072#1087#1082#1072' '#1089' HTML-'#1092#1072#1081#1083#1072#1084#1080
  end
  object Bevel1: TBevel
    Left = 8
    Top = 88
    Width = 457
    Height = 18
    Shape = bsBottomLine
  end
  object lblDisplay: TLabel
    Left = 8
    Top = 252
    Width = 457
    Height = 13
    Anchors = [akLeft, akBottom]
    AutoSize = False
  end
  object Label2: TLabel
    Left = 8
    Top = 120
    Width = 91
    Height = 13
    Caption = #1060#1072#1081#1083' '#1089' '#1074#1099#1073#1086#1088#1082#1086#1081
  end
  object Label3: TLabel
    Left = 8
    Top = 168
    Width = 167
    Height = 13
    Caption = #1060#1072#1081#1083' '#1089' '#1085#1072#1081#1076#1077#1085#1085#1099#1084#1080' '#1072#1090#1088#1080#1073#1091#1090#1072#1084#1080
  end
  object deSource: TDirectoryEdit
    Left = 8
    Top = 32
    Width = 457
    Height = 21
    NumGlyphs = 1
    TabOrder = 0
  end
  object btnFindAttributes: TButton
    Left = 320
    Top = 64
    Width = 147
    Height = 25
    Caption = #1053#1072#1081#1090#1080' '#1072#1090#1088#1080#1073#1091#1090#1099
    TabOrder = 1
    OnClick = btnFindAttributesClick
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 268
    Width = 457
    Height = 17
    Anchors = [akLeft, akBottom]
    TabOrder = 2
  end
  object feTopicList: TFilenameEdit
    Left = 8
    Top = 136
    Width = 457
    Height = 21
    NumGlyphs = 1
    TabOrder = 3
  end
  object feFoundArr: TFilenameEdit
    Left = 8
    Top = 184
    Width = 457
    Height = 21
    Filter = #1060#1072#1081#1083#1099' CSV (*.csv)|*.csv'
    NumGlyphs = 1
    TabOrder = 4
  end
  object btnCompare: TButton
    Left = 320
    Top = 216
    Width = 145
    Height = 25
    Caption = #1057#1088#1072#1074#1085#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
    TabOrder = 5
    OnClick = btnCompareClick
  end
end
