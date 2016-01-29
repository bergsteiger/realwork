object Form1: TForm1
  Left = 435
  Top = 149
  Width = 388
  Height = 629
  Caption = #1058#1077#1089#1090#1099' '#1080#1085#1090#1077#1075#1088#1072#1094#1080#1080
  Color = $00F9F8FA
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object IsGarantInstalledButton: TButton
    Left = 7
    Top = 10
    Width = 156
    Height = 20
    Caption = 'IsGarantInstalled'
    TabOrder = 0
    OnClick = IsGarantInstalledButtonClick
  end
  object CommandGroupBox: TvtGroupBox
    Left = 7
    Top = 39
    Width = 361
    Height = 214
    Caption = ' Command '
    TabOrder = 1
    object Label3: TvtLabel
      Left = 7
      Top = 23
      Width = 59
      Height = 16
      Caption = 'Command'
    end
    object Label4: TvtLabel
      Left = 7
      Top = 75
      Width = 49
      Height = 16
      Caption = #1058#1072#1081#1084#1072#1091#1090
    end
    object Label5: TvtLabel
      Left = 7
      Top = 156
      Width = 87
      Height = 16
      Caption = #1055#1091#1090#1100' '#1082' '#1075#1072#1088#1072#1085#1090#1091
    end
    object Label7: TvtLabel
      Left = 7
      Top = 130
      Width = 102
      Height = 16
      Caption = #1050#1083#1102#1095' '#1080#1085#1090#1077#1075#1088#1072#1094#1080#1080
    end
    object CommandComboBox: TComboBox
      Left = 59
      Top = 20
      Width = 293
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      ItemIndex = 0
      TabOrder = 0
      Text = #1055#1088#1086#1089#1090#1086' '#1079#1072#1087#1091#1089#1090#1080#1090#1100'/'#1072#1082#1090#1080#1074#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1077#1077' '#1086#1082#1085#1086
      Items.Strings = (
        #1055#1088#1086#1089#1090#1086' '#1079#1072#1087#1091#1089#1090#1080#1090#1100'/'#1072#1082#1090#1080#1074#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1077#1077' '#1086#1082#1085#1086
        #1054#1089#1085#1086#1074#1085#1086#1077' '#1084#1077#1085#1102
        #1055#1088#1072#1074#1086#1074#1086#1081' '#1085#1072#1074#1080#1075#1072#1090#1086#1088
        #1055#1086#1080#1089#1082#1080' '#1087#1086' '#1089#1080#1090#1091#1072#1094#1080#1080
        #1055#1086#1080#1089#1082#1080' '#1087#1086' '#1088#1077#1082#1074#1080#1079#1080#1090#1072#1084
        #1055#1086#1080#1089#1082#1080' '#1087#1086' '#1080#1089#1090#1086#1095#1085#1080#1082#1091' '#1086#1087#1091#1073#1083#1080#1082#1086#1074#1072#1085#1080#1103
        #1055#1086#1080#1089#1082#1080' '#1089' '#1087#1088#1072#1074#1086#1074#1086#1081' '#1087#1086#1076#1076#1077#1088#1078#1082#1086#1081
        #1054#1073#1079#1086#1088' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1074' '#1079#1072#1082#1086#1085#1086#1076#1072#1090#1077#1083#1100#1089#1090#1074#1077
        #1058#1086#1083#1082#1086#1074#1099#1081' '#1089#1083#1086#1074#1072#1088#1100
        #1053#1086#1074#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
        #1055#1086#1080#1089#1082' '#1083#1077#1082#1072#1088#1089#1090#1074#1077#1085#1085#1086#1075#1086' '#1087#1088#1077#1087#1072#1088#1072#1090#1072
        #1057#1087#1080#1089#1086#1082' '#1083#1077#1082#1072#1088#1089#1090#1074#1077#1085#1085#1099#1093' '#1087#1088#1077#1087#1072#1088#1072#1090#1086#1074
        #1054#1089#1085#1086#1074#1085#1086#1077' '#1084#1077#1085#1102' '#1048#1085#1092#1072#1088#1084
        #1057#1083#1086#1074#1072#1088#1100' '#1084#1077#1076'. '#1090#1077#1088#1084#1080#1085#1086#1074
        #1040' '#1090#1072#1082#1086#1075#1086' '#1085#1077#1090' (ERROR !)')
    end
    object CommandOpenNewCheckBox: TCheckBox
      Left = 7
      Top = 49
      Width = 169
      Height = 14
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074' '#1085#1086#1074#1086#1084' '#1086#1082#1085#1077
      TabOrder = 1
    end
    object CommandInfiniteCheckBox: TCheckBox
      Left = 166
      Top = 72
      Width = 62
      Height = 13
      Caption = 'infinite'
      TabOrder = 2
    end
    object GarantProcessCommandButton: TButton
      Left = 7
      Top = 98
      Width = 264
      Height = 23
      Caption = 'GarantProcessCommand'
      TabOrder = 3
      OnClick = GarantProcessCommandButtonClick
    end
    object GarantDemoProcessCommandButton: TButton
      Left = 7
      Top = 182
      Width = 264
      Height = 23
      Caption = 'GarantDemoProcessCommand'
      TabOrder = 4
      OnClick = GarantDemoProcessCommandButtonClick
    end
    object CommandDirectoryEdit: TDirectoryEdit
      Left = 94
      Top = 153
      Width = 255
      Height = 24
      NumGlyphs = 1
      ButtonWidth = 17
      TabOrder = 5
    end
    object CommandTimeOutSpinEdit: TSpinEdit
      Left = 62
      Top = 68
      Width = 98
      Height = 26
      MaxValue = 999999999
      MinValue = 0
      TabOrder = 6
      Value = 0
    end
    object CommandKeyEdit: TEdit
      Left = 111
      Top = 127
      Width = 241
      Height = 24
      TabOrder = 7
    end
  end
  object LinkGroupBox: TvtGroupBox
    Left = 7
    Top = 257
    Width = 361
    Height = 330
    Caption = ' Link '
    TabOrder = 2
    object Label1: TvtLabel
      Left = 7
      Top = 16
      Width = 24
      Height = 16
      Caption = 'Link'
    end
    object Label2: TvtLabel
      Left = 7
      Top = 191
      Width = 49
      Height = 16
      Caption = #1058#1072#1081#1084#1072#1091#1090
    end
    object Label6: TvtLabel
      Left = 10
      Top = 272
      Width = 87
      Height = 16
      Caption = #1055#1091#1090#1100' '#1082' '#1075#1072#1088#1072#1085#1090#1091
    end
    object Label8: TvtLabel
      Left = 7
      Top = 245
      Width = 102
      Height = 16
      Caption = #1050#1083#1102#1095' '#1080#1085#1090#1077#1075#1088#1072#1094#1080#1080
    end
    object vtLabel1: TvtLabel
      Left = 7
      Top = 146
      Width = 79
      Height = 16
      Caption = #1055#1091#1090#1100' '#1082' '#1092#1072#1081#1083#1091
    end
    object LinkMemo: TMemo
      Left = 7
      Top = 33
      Width = 345
      Height = 91
      Lines.Strings = (
        '<?xml version="1.0" encoding="UTF-8" standalone="no" '
        '?>'
        '<bookmark xml_version = "1" id = "" point = "" point_type '
        '= "" />')
      TabOrder = 0
    end
    object LinkOpenNewCheckBox: TCheckBox
      Left = 7
      Top = 170
      Width = 169
      Height = 14
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074' '#1085#1086#1074#1086#1084' '#1086#1082#1085#1077
      TabOrder = 3
    end
    object LinkTimeOutSpinEdit: TSpinEdit
      Left = 62
      Top = 184
      Width = 98
      Height = 26
      MaxValue = 999999999
      MinValue = 0
      TabOrder = 4
      Value = 0
    end
    object LinkInfiniteCheckBox: TCheckBox
      Left = 166
      Top = 187
      Width = 62
      Height = 14
      Caption = 'infinite'
      TabOrder = 5
    end
    object GarantShowLinkButton: TButton
      Left = 7
      Top = 213
      Width = 264
      Height = 24
      Caption = 'GarantShowLink'
      TabOrder = 6
      OnClick = GarantShowLinkButtonClick
    end
    object LinkDirectoryEdit: TDirectoryEdit
      Left = 98
      Top = 269
      Width = 251
      Height = 24
      NumGlyphs = 1
      ButtonWidth = 17
      TabOrder = 7
    end
    object GarantDemoShowLinkButton: TButton
      Left = 7
      Top = 298
      Width = 264
      Height = 24
      Caption = 'GarantDemoShowLink'
      TabOrder = 8
      OnClick = GarantDemoShowLinkButtonClick
    end
    object LinkKeyEdit: TEdit
      Left = 111
      Top = 242
      Width = 241
      Height = 24
      TabOrder = 9
    end
    object FromFileCheckBox: TCheckBox
      Left = 7
      Top = 128
      Width = 169
      Height = 14
      Caption = #1048#1079' '#1092#1072#1081#1083#1072
      TabOrder = 1
      OnClick = FromFileCheckBoxClick
    end
    object XMLFileEdit: TFilenameEdit
      Left = 88
      Top = 143
      Width = 264
      Height = 24
      OnAfterDialog = XMLFileEditAfterDialog
      Enabled = False
      ButtonWidth = 17
      NumGlyphs = 1
      TabOrder = 2
      OnChange = XMLFileEditChange
    end
  end
end
