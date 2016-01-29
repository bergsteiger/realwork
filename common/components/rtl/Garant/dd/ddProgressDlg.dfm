object ddProgressDialog: TddProgressDialog
  Left = 401
  Top = 192
  BorderIcons = []
  BorderStyle = bsSingle
  ClientHeight = 359
  ClientWidth = 469
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object rbLocal: TGroupBox
    Left = 8
    Top = 8
    Width = 453
    Height = 97
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1090#1077#1082#1091#1097#1077#1084' '#1082#1091#1089#1082#1077
    TabOrder = 0
    object lblMessage: TLabel
      Left = 8
      Top = 16
      Width = 437
      Height = 13
      AutoSize = False
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1082#1091#1089#1082#1072
    end
    object lblLocalDone: TLabel
      Left = 8
      Top = 52
      Width = 101
      Height = 14
      Caption = #1057#1076#1077#1083#1072#1085#1086' '#1087#1088#1086#1094#1077#1085#1090#1086#1074
    end
    object lblLocalSpeed: TLabel
      Left = 8
      Top = 72
      Width = 114
      Height = 14
      Caption = #1057#1082#1086#1088#1086#1089#1090#1100' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
    end
    object lblLocalElapsed: TLabel
      Left = 240
      Top = 56
      Width = 103
      Height = 14
      Caption = #1055#1086#1090#1088#1072#1095#1077#1085#1086' '#1074#1088#1077#1084#1077#1085#1080
    end
    object lblLocalRemaining: TLabel
      Left = 240
      Top = 76
      Width = 98
      Height = 14
      Caption = #1054#1089#1090#1072#1083#1086#1089#1100' '#1074#1088#1077#1084#1077#1085#1080
    end
    object pbLocal: TProgressBar
      Left = 8
      Top = 32
      Width = 437
      Height = 17
      TabOrder = 0
    end
  end
  object gbTotal: TGroupBox
    Left = 8
    Top = 108
    Width = 453
    Height = 77
    Caption = #1042#1089#1077#1075#1086
    TabOrder = 1
    object lblTotalDone: TLabel
      Left = 8
      Top = 40
      Width = 58
      Height = 14
      Caption = 'lblTotalDone'
    end
    object lblTotalSpeed: TLabel
      Left = 8
      Top = 56
      Width = 64
      Height = 14
      Caption = 'lblTotalSpeed'
    end
    object lblTotalElapsed: TLabel
      Left = 244
      Top = 36
      Width = 71
      Height = 14
      Caption = 'lblTotalElapsed'
    end
    object lblTotalRemaining: TLabel
      Left = 244
      Top = 52
      Width = 82
      Height = 14
      Caption = 'lblTotalRemaining'
    end
    object pbTotal: TProgressBar
      Left = 8
      Top = 16
      Width = 437
      Height = 17
      TabOrder = 0
    end
  end
  object lbLogProcess: TListBox
    Left = 8
    Top = 208
    Width = 453
    Height = 113
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 12
    ParentFont = False
    TabOrder = 2
  end
  object Button1: TButton
    Left = 188
    Top = 328
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = BitBtn1Click
  end
  object cbShowDetails: TCheckBox
    Left = 8
    Top = 188
    Width = 177
    Height = 17
    Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1076#1077#1090#1072#1083#1080' '#1087#1088#1086#1094#1077#1089#1089#1072
    Checked = True
    State = cbChecked
    TabOrder = 4
    OnClick = cbShowDetailsClick
  end
end
