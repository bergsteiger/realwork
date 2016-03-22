object Form1: TForm1
  Left = 435
  Top = 149
  Width = 388
  Height = 629
  Caption = #1058#1077#1089#1090#1099' '#1080#1085#1090#1077#1075#1088#1072#1094#1080#1080
  Color = 16382202
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
  object CommandGroupBox: TGroupBox
    Left = 7
    Top = 39
    Width = 361
    Height = 214
    Caption = ' Command '
    TabOrder = 1
    object Label3: TLabel
      Left = 7
      Top = 23
      Width = 47
      Height = 13
      Caption = 'Command'
    end
    object Label4: TLabel
      Left = 7
      Top = 75
      Width = 43
      Height = 13
      Caption = #1058#1072#1081#1084#1072#1091#1090
    end
    object Label5: TLabel
      Left = 8
      Top = 152
      Width = 75
      Height = 13
      Caption = #1055#1091#1090#1100' '#1082' '#1075#1072#1088#1072#1085#1090#1091
    end
    object Label7: TLabel
      Left = 8
      Top = 128
      Width = 87
      Height = 13
      Caption = #1050#1083#1102#1095' '#1080#1085#1090#1077#1075#1088#1072#1094#1080#1080
    end
    object CommandComboBox: TComboBox
      Left = 59
      Top = 20
      Width = 293
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
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
        #1053#1086#1074#1086#1089#1090#1080' '#1086#1085#1083#1072#1081#1085
        #1047#1072#1076#1072#1090#1100' '#1074#1086#1087#1088#1086#1089' '#1101#1082#1089#1087#1077#1088#1090#1091
        #1052#1086#1103' '#1085#1086#1074#1086#1089#1090#1085#1072#1103' '#1083#1077#1085#1090#1072
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
    object CommandTimeOutSpinEdit: TSpinEdit
      Left = 62
      Top = 68
      Width = 98
      Height = 22
      MaxValue = 999999999
      MinValue = 0
      TabOrder = 5
      Value = 0
    end
    object CommandKeyEdit: TEdit
      Left = 112
      Top = 128
      Width = 241
      Height = 21
      TabOrder = 6
    end
    object CommandDirectoryEdit: TEdit
      Left = 112
      Top = 152
      Width = 209
      Height = 21
      ReadOnly = True
      TabOrder = 7
    end
    object CommandDirectoryButton: TButton
      Left = 328
      Top = 152
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 8
      OnClick = CommandDirectoryButtonClick
    end
  end
  object LinkGroupBox: TGroupBox
    Left = 7
    Top = 257
    Width = 361
    Height = 330
    Caption = ' Link '
    TabOrder = 2
    object Label1: TLabel
      Left = 7
      Top = 16
      Width = 20
      Height = 13
      Caption = 'Link'
    end
    object Label2: TLabel
      Left = 7
      Top = 191
      Width = 43
      Height = 13
      Caption = #1058#1072#1081#1084#1072#1091#1090
    end
    object Label6: TLabel
      Left = 8
      Top = 272
      Width = 75
      Height = 13
      Caption = #1055#1091#1090#1100' '#1082' '#1075#1072#1088#1072#1085#1090#1091
    end
    object Label8: TLabel
      Left = 8
      Top = 248
      Width = 87
      Height = 13
      Caption = #1050#1083#1102#1095' '#1080#1085#1090#1077#1075#1088#1072#1094#1080#1080
    end
    object vtLabel1: TLabel
      Left = 7
      Top = 146
      Width = 67
      Height = 13
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
      TabOrder = 2
    end
    object LinkTimeOutSpinEdit: TSpinEdit
      Left = 62
      Top = 184
      Width = 98
      Height = 22
      MaxValue = 999999999
      MinValue = 0
      TabOrder = 3
      Value = 0
    end
    object LinkInfiniteCheckBox: TCheckBox
      Left = 166
      Top = 187
      Width = 62
      Height = 14
      Caption = 'infinite'
      TabOrder = 4
    end
    object GarantShowLinkButton: TButton
      Left = 7
      Top = 213
      Width = 264
      Height = 24
      Caption = 'GarantShowLink'
      TabOrder = 5
      OnClick = GarantShowLinkButtonClick
    end
    object GarantDemoShowLinkButton: TButton
      Left = 7
      Top = 298
      Width = 264
      Height = 24
      Caption = 'GarantDemoShowLink'
      TabOrder = 6
      OnClick = GarantDemoShowLinkButtonClick
    end
    object LinkKeyEdit: TEdit
      Left = 112
      Top = 248
      Width = 241
      Height = 21
      TabOrder = 7
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
    object LinkDirectoryEdit: TEdit
      Left = 112
      Top = 272
      Width = 209
      Height = 21
      ReadOnly = True
      TabOrder = 8
    end
    object XMLFileEdit: TEdit
      Left = 112
      Top = 144
      Width = 209
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 9
    end
    object XMLFileButton: TButton
      Left = 328
      Top = 144
      Width = 21
      Height = 21
      Caption = '...'
      Enabled = False
      TabOrder = 10
      OnClick = XMLFileButtonClick
    end
    object LinkDirectoryButton: TButton
      Left = 328
      Top = 272
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 11
      OnClick = LinkDirectoryButtonClick
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'XML|*.xml'
    Options = [ofReadOnly, ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 192
    Top = 8
  end
end
