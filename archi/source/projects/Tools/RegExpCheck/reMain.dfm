object MainForm: TMainForm
  Left = 327
  Top = 240
  Width = 915
  Height = 583
  Caption = #1055#1088#1086#1074#1077#1088#1103#1083#1082#1072' '#1088#1077#1075#1091#1083#1103#1088#1085#1099#1093' '#1074#1099#1088#1072#1078#1077#1085#1080#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    899
    545)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 120
    Height = 13
    Caption = #1056#1077#1075#1091#1083#1103#1088#1085#1086#1077' '#1074#1099#1088#1072#1078#1077#1085#1080#1077
  end
  object Label2: TLabel
    Left = 16
    Top = 144
    Width = 102
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1058#1077#1082#1089#1090' '#1076#1083#1103' '#1087#1088#1086#1074#1077#1088#1082#1080
  end
  object Label3: TLabel
    Left = 16
    Top = 312
    Width = 79
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1047#1085#1072#1095#1077#1085#1080#1103' '#1090#1077#1075#1086#1074
  end
  object lblResult: TLabel
    Left = 704
    Top = 376
    Width = 185
    Height = 23
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Caption = 'lblResult'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object lbTagParts: TListBox
    Left = 16
    Top = 328
    Width = 681
    Height = 201
    Anchors = [akLeft, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 4
  end
  object btnStart: TButton
    Left = 704
    Top = 328
    Width = 185
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
    Default = True
    TabOrder = 5
    OnClick = btnStartClick
  end
  object cbCaseSensitive: TCheckBox
    Left = 16
    Top = 280
    Width = 201
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1088#1077#1075#1080#1089#1090#1088' '#1089#1080#1084#1074#1086#1083#1086#1074
    TabOrder = 2
  end
  object memText: TMemo
    Left = 16
    Top = 160
    Width = 873
    Height = 113
    Anchors = [akLeft, akRight, akBottom]
    HideSelection = False
    TabOrder = 1
  end
  object cbNoCRLF: TCheckBox
    Left = 232
    Top = 280
    Width = 193
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #1048#1075#1085#1086#1088#1080#1088#1086#1074#1072#1090#1100' '#1087#1077#1088#1077#1085#1086#1089#1099' '#1089#1090#1088#1086#1082
    TabOrder = 3
  end
  object memRegExp: TevMemo
    Left = 16
    Top = 24
    Width = 873
    Height = 97
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 0
    TabStop = True
    BorderStyle = bsSingle
  end
  object XPManifest1: TXPManifest
    Left = 864
    Top = 496
  end
end
