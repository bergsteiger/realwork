object alcuMessageDialog: TalcuMessageDialog
  Left = 1300
  Top = 374
  BorderStyle = bsDialog
  Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077' '#1076#1083#1103
  ClientHeight = 119
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 4
    Width = 90
    Height = 13
    Caption = #1058#1077#1082#1089#1090' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
  end
  object comboDefined: TComboBox
    Left = 8
    Top = 20
    Width = 629
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Items.Strings = (
      
        #1042' '#1089#1074#1103#1079#1080' '#1089' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077#1085#1085#1086#1081' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1086#1089#1090#1100#1102', '#1087#1086#1078#1072#1083#1091#1081#1089#1090#1072', '#1074#1099#1081#1076#1080#1090#1077' '#1080 +
        #1079' "'#1040#1088#1093#1080#1074#1072#1088#1080#1091#1089#1072'"'
      #1055#1086#1082#1080#1076#1072#1103' '#1088#1072#1073#1086#1095#1077#1077' '#1084#1077#1089#1090#1086', '#1085#1077' '#1079#1072#1073#1091#1076#1100#1090#1077' '#1074#1099#1082#1083#1102#1095#1080#1090#1100' "'#1040#1088#1093#1080#1074#1072#1088#1080#1091#1089'".'
      
        'C 20:00 '#1076#1086' 22:00 '#1073#1091#1076#1091#1090' '#1087#1088#1086#1074#1086#1076#1080#1090#1100#1089#1103' '#1087#1088#1086#1092#1080#1083#1072#1082#1090#1080#1095#1077#1089#1082#1080#1077' '#1088#1072#1073#1086#1090#1099'. '#1042#1086' '#1080 +
        #1079#1073#1077#1078#1072#1085#1080#1077' '#1085#1077#1076#1086#1088#1072#1079#1091#1084#1077#1085#1080#1081' '#1079#1072#1074#1077#1088#1096#1080#1090#1077' '#1089#1074#1086#1102' '#1088#1072#1073#1086#1090#1091' '#1076#1086' '#1091#1082#1072#1079#1072#1085#1085#1086#1075#1086' '#1074#1088#1077#1084#1077 +
        #1085#1080
      
        #1055#1086#1103#1074#1080#1083#1072#1089#1100' '#1085#1086#1074#1072#1103' '#1074#1077#1088#1089#1080#1103' "'#1040#1088#1093#1080#1074#1072#1088#1080#1091#1089#1072'". '#1055#1086#1078#1072#1083#1091#1081#1089#1090#1072', '#1074#1099#1081#1076#1080#1090#1077' '#1080#1079' '#1087#1088#1086 +
        #1075#1088#1072#1084#1084#1099' '#1080' '#1074#1086#1081#1076#1080#1090#1077' '#1079#1072#1085#1086#1074#1086' '
      #1059#1073#1077#1076#1080#1090#1077#1083#1100#1085#1072#1103' '#1087#1088#1086#1089#1100#1073#1072' '#1085#1077' '#1079#1072#1087#1091#1089#1082#1072#1090#1100' '#1080#1084#1087#1086#1088#1090' '#1076#1086' 13:00.')
  end
  object cbToAll: TCheckBox
    Left = 16
    Top = 44
    Width = 153
    Height = 17
    Caption = #1044#1083#1103' '#1074#1089#1077#1093' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
    TabOrder = 1
    OnClick = cbToAllClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 68
    Width = 465
    Height = 49
    TabOrder = 2
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
  object cbLockBase: TCheckBox
    Left = 16
    Top = 64
    Width = 105
    Height = 17
    Caption = #1047#1072#1082#1088#1099#1090#1100' '#1073#1072#1079#1091
    Enabled = False
    TabOrder = 3
    OnClick = cbLockBaseClick
  end
  object OkBtn: TButton
    Left = 480
    Top = 80
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object CancelBtn: TButton
    Left = 560
    Top = 80
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 5
  end
end
