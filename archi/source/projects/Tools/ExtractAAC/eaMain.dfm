object Form1: TForm1
  Left = 590
  Top = 291
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1056#1072#1089#1087#1072#1082#1086#1074#1082#1072' '#1040#1040#1057' evd'
  ClientHeight = 323
  ClientWidth = 496
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
    Top = 72
    Width = 80
    Height = 13
    Caption = #1048#1089#1093#1086#1076#1085#1099#1081' '#1092#1072#1081#1083
  end
  object Label2: TLabel
    Left = 8
    Top = 120
    Width = 106
    Height = 13
    Caption = #1055#1072#1087#1082#1072' '#1089' zip-'#1092#1072#1081#1083#1072#1084#1080
  end
  object Label3: TLabel
    Left = 8
    Top = 216
    Width = 133
    Height = 13
    Caption = #1050#1091#1076#1072' '#1087#1086#1084#1077#1097#1072#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090
  end
  object lblDisp: TLabel
    Left = 8
    Top = 288
    Width = 56
    Height = 13
    Caption = #1053#1072#1081#1076#1077#1085#1086': 0'
  end
  object feInputFile: TFilenameEdit
    Left = 8
    Top = 88
    Width = 481
    Height = 21
    Filter = 'NSRC (*.nsr)|*.nsr'
    NumGlyphs = 1
    TabOrder = 0
  end
  object deSource: TDirectoryEdit
    Left = 8
    Top = 136
    Width = 481
    Height = 21
    NumGlyphs = 1
    TabOrder = 1
  end
  object deDest: TDirectoryEdit
    Left = 7
    Top = 232
    Width = 481
    Height = 21
    NumGlyphs = 1
    TabOrder = 2
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 264
    Width = 481
    Height = 17
    TabOrder = 3
  end
  object btnStart: TButton
    Left = 392
    Top = 288
    Width = 99
    Height = 25
    Caption = #1057#1090#1072#1088#1090
    TabOrder = 4
    OnClick = btnStartClick
  end
  object Panel1: TPanel
    Left = 8
    Top = 168
    Width = 185
    Height = 49
    BevelOuter = bvNone
    TabOrder = 5
    object rbLookForEVD: TRadioButton
      Left = 8
      Top = 5
      Width = 113
      Height = 17
      Caption = #1048#1089#1082#1072#1090#1100' EVD'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbLookForGZ: TRadioButton
      Left = 8
      Top = 24
      Width = 113
      Height = 17
      Caption = #1048#1089#1082#1072#1090#1100' GZ'
      TabOrder = 1
    end
  end
  object rgInputFormat: TRadioGroup
    Left = 8
    Top = 8
    Width = 185
    Height = 57
    Caption = ' '#1060#1086#1088#1084#1072#1090' '#1074#1093#1086#1076#1085#1086#1075#1086' '#1092#1072#1081#1083#1072' '
    ItemIndex = 0
    Items.Strings = (
      'NSRC'
      #1051#1086#1075'-'#1092#1072#1081#1083' '#1079#1072#1083#1080#1074#1082#1080)
    TabOrder = 6
    OnClick = rgInputFormatClick
  end
end
