object BaseCopyDlg: TBaseCopyDlg
  Left = 282
  Top = 110
  BorderStyle = bsDialog
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1082#1086#1087#1080#1080' '#1073#1072#1079#1099
  ClientHeight = 324
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 54
    Width = 35
    Height = 13
    Caption = #1055#1072#1087#1082#1072' '
  end
  object Label2: TLabel
    Left = 16
    Top = 24
    Width = 48
    Height = 13
    Caption = #1058#1080#1087' '#1073#1072#1079#1099
  end
  object Label3: TLabel
    Left = 16
    Top = 76
    Width = 83
    Height = 13
    Caption = #1053#1072#1073#1086#1088' '#1089#1083#1086#1074#1072#1088#1077#1081
  end
  object dirDestFolder: TDirectoryEdit
    Left = 80
    Top = 48
    Width = 305
    Height = 21
    DialogText = #1059#1082#1072#1078#1080#1090#1077' '#1087#1072#1087#1082#1091' '#1076#1083#1103' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1082#1086#1087#1080#1080
    DialogOptions = [sdAllowCreate]
    NumGlyphs = 1
    TabOrder = 1
    OnChange = dirDestFolderChange
  end
  object cbBaseType: TComboBox
    Left = 80
    Top = 20
    Width = 305
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = cbBaseTypeChange
    Items.Strings = (
      #1057#1086' '#1089#1083#1086#1074#1072#1088#1103#1084#1080
      #1055#1091#1089#1090#1072#1103
      #1055#1086' '#1074#1099#1073#1086#1088#1091' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103)
  end
  object clbDictSet: TCheckListBox
    Left = 16
    Top = 94
    Width = 369
    Height = 169
    OnClickCheck = clbDictSetClickCheck
    ItemHeight = 13
    Items.Strings = (
      #1048#1089#1093#1086#1076#1103#1097#1080#1077' '#1086#1088#1075#1072#1085#1099
      #1058#1080#1087#1099
      #1050#1083#1072#1089#1089#1099
      #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
      #1043#1088#1091#1087#1087#1099' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      #1055#1088#1077#1076#1091#1087#1088#1077#1078#1076#1077#1085#1080#1103
      #1048#1089#1090#1086#1095#1085#1080#1082#1080' '#1086#1087#1091#1073#1083#1080#1082#1086#1074#1072#1085#1080#1103
      #1055#1088#1077#1092#1080#1082#1089#1099
      #1058#1077#1088#1088#1080#1090#1086#1088#1080#1103
      #1053#1086#1088#1084#1099' '#1087#1088#1072#1074#1072
      #1043#1088#1091#1087#1087#1099' '#1076#1086#1089#1090#1091#1087#1072
      #1053#1086#1074#1099#1077' '#1082#1083#1072#1089#1089#1099
      #1050#1083#1072#1089#1089#1099' '#1072#1085#1085#1086#1090#1072#1094#1080#1081
      #1057#1083#1091#1078#1077#1073#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103)
    TabOrder = 2
  end
  object cbWithUsers: TCheckBox
    Left = 16
    Top = 268
    Width = 165
    Height = 17
    Caption = #1057' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103#1084#1080
    Enabled = False
    TabOrder = 3
  end
  object Button1: TButton
    Left = 224
    Top = 288
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 4
  end
  object Button2: TButton
    Left = 312
    Top = 288
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 5
  end
end
