object LockMessageDialog: TLockMessageDialog
  Left = 169
  Top = 183
  BorderStyle = bsDialog
  Caption = #1047#1072#1082#1088#1099#1090#1080#1077' '#1073#1072#1079#1099' '#1086#1090' '#1074#1093#1086#1076#1072' '#1074' '#1085#1077#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
  ClientHeight = 86
  ClientWidth = 659
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 12
    Width = 150
    Height = 13
    Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1086#1085#1085#1086#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
  end
  object comboMessage: TComboBox
    Left = 172
    Top = 8
    Width = 481
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 488
    Top = 52
    Width = 75
    Height = 25
    Caption = #1054#1082
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 576
    Top = 52
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 36
    Width = 465
    Height = 45
    Caption = #1047#1072#1082#1088#1099#1090#1100' '#1073#1072#1079#1091
    TabOrder = 1
    object Label2: TLabel
      Left = 4
      Top = 20
      Width = 6
      Height = 13
      Caption = 'c'
    end
    object Label3: TLabel
      Left = 228
      Top = 20
      Width = 12
      Height = 13
      Caption = #1076#1086
    end
    object dtpLockTime: TDateTimePicker
      Left = 248
      Top = 16
      Width = 73
      Height = 21
      Date = 37223.644616886600000000
      Time = 37223.644616886600000000
      Kind = dtkTime
      TabOrder = 2
    end
    object dtpLockDate: TDateTimePicker
      Left = 324
      Top = 16
      Width = 133
      Height = 21
      Date = 37223.644651655100000000
      Time = 37223.644651655100000000
      DateFormat = dfLong
      TabOrder = 3
    end
    object dtpStartLockTime: TDateTimePicker
      Left = 16
      Top = 16
      Width = 73
      Height = 21
      Date = 37461.588209513900000000
      Time = 37461.588209513900000000
      Kind = dtkTime
      TabOrder = 0
    end
    object dtpStartLockDate: TDateTimePicker
      Left = 96
      Top = 16
      Width = 126
      Height = 21
      Date = 37461.588344432900000000
      Time = 37461.588344432900000000
      DateFormat = dfLong
      TabOrder = 1
    end
  end
end
