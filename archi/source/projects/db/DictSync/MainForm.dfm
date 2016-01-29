object DictSyncForm: TDictSyncForm
  Left = 461
  Top = 372
  BorderStyle = bsDialog
  Caption = #1050#1086#1088#1088#1077#1082#1090#1086#1088' '#1057#1083#1086#1074#1072#1088#1077#1081
  ClientHeight = 175
  ClientWidth = 472
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
    Left = 16
    Top = 88
    Width = 166
    Height = 13
    Caption = #1055#1072#1087#1082#1072' '#1089' '#1101#1090#1072#1083#1086#1085#1085#1099#1084#1080' '#1089#1083#1086#1074#1072#1088#1103#1084#1080
  end
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 123
    Height = 13
    Caption = #1048#1089#1087#1088#1072#1074#1083#1103#1077#1084#1099#1081' '#1089#1083#1086#1074#1072#1088#1100
  end
  object Label3: TLabel
    Left = 16
    Top = 8
    Width = 74
    Height = 13
    Caption = #1055#1072#1087#1082#1072' '#1089' '#1073#1072#1079#1086#1081
  end
  object btnRun: TButton
    Left = 368
    Top = 24
    Width = 89
    Height = 25
    Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100
    Default = True
    Enabled = False
    TabOrder = 6
    OnClick = btnRunClick
  end
  object EditEtalonFolder: TEdit
    Left = 16
    Top = 104
    Width = 265
    Height = 21
    TabOrder = 4
    Text = 'data'
    OnChange = comboDictsChange
  end
  object btnBrowseForEtalon: TButton
    Left = 288
    Top = 104
    Width = 57
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    TabOrder = 5
    OnClick = btnBrowseForEtalonClick
  end
  object comboDicts: TComboBox
    Left = 16
    Top = 64
    Width = 265
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    OnChange = comboDictsChange
  end
  object editbaseFolder: TEdit
    Left = 16
    Top = 24
    Width = 265
    Height = 21
    TabOrder = 0
    OnChange = comboDictsChange
  end
  object btnBrowseBaseFolder: TButton
    Left = 288
    Top = 24
    Width = 57
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    TabOrder = 1
    OnClick = btnBrowseBaseFolderClick
  end
  object cbCorrectLinks: TCheckBox
    Left = 288
    Top = 64
    Width = 169
    Height = 17
    Caption = #1048#1089#1087#1088#1072#1074#1083#1103#1090#1100' '#1083#1080#1085#1082#1080' '#1074#1088#1091#1095#1085#1091#1102
    TabOrder = 3
  end
end
