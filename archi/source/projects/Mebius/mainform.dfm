object MebiusForm: TMebiusForm
  Left = 418
  Top = 290
  BorderStyle = bsDialog
  Caption = #1052#1105#1073#1080#1091#1089
  ClientHeight = 262
  ClientWidth = 497
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object Descript: TLabel
    Left = 8
    Top = 240
    Width = 105
    Height = 14
    AutoSize = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 349
    Height = 121
    Caption = #1042#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 149
      Height = 14
      Caption = #1055#1072#1087#1082#1072' '#1089' '#1080#1089#1093#1086#1076#1085#1099#1084#1080' '#1092#1072#1081#1083#1072#1084#1080
    end
    object Label2: TLabel
      Left = 8
      Top = 88
      Width = 65
      Height = 14
      Caption = #1058#1080#1087' '#1080#1084#1087#1086#1088#1090#1072
    end
    object Label4: TLabel
      Left = 8
      Top = 64
      Width = 86
      Height = 14
      Caption = #1042#1093#1086#1076#1085#1086#1081' '#1092#1086#1088#1084#1072#1090
    end
    object dirSourceFolder: TDirectoryEdit
      Left = 8
      Top = 32
      Width = 333
      Height = 21
      NumGlyphs = 1
      TabOrder = 0
    end
    object cbImportType: TComboBox
      Left = 112
      Top = 88
      Width = 229
      Height = 22
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 1
      Items.Strings = (
        #1054#1076#1085#1086#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1080#1081
        #1054#1076#1085#1086#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1080#1081' '#1076#1074#1091#1093#1087#1088#1086#1093#1086#1076#1085#1099#1081
        #1052#1085#1086#1075#1086#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1080#1081)
    end
    object cbInputFileType: TComboBox
      Left = 112
      Top = 64
      Width = 229
      Height = 22
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 2
      Items.Strings = (
        #1048#1089#1093#1086#1076#1085#1080#1082#1080' '#1043#1040#1056#1040#1053#1058#1072' (*.nsr)'
        #1044#1086#1082#1091#1084#1077#1085#1090#1099' '#1069#1074#1077#1088#1077#1089#1090' (*.evd)'
        #1040#1074#1090#1086#1086#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' (*.*)')
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 136
    Width = 349
    Height = 97
    Caption = #1042#1099#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
    TabOrder = 1
    object Label3: TLabel
      Left = 8
      Top = 16
      Width = 149
      Height = 14
      Caption = #1055#1072#1087#1082#1072' '#1076#1083#1103' '#1074#1099#1093#1086#1076#1085#1099#1093' '#1092#1072#1081#1083#1086#1074
    end
    object Label5: TLabel
      Left = 8
      Top = 64
      Width = 94
      Height = 14
      Caption = #1042#1099#1093#1086#1076#1085#1086#1081' '#1092#1086#1088#1084#1072#1090
    end
    object dirDestinationFolder: TDirectoryEdit
      Left = 8
      Top = 32
      Width = 333
      Height = 21
      NumGlyphs = 1
      TabOrder = 0
    end
    object cbOutputFileType: TComboBox
      Left = 112
      Top = 64
      Width = 229
      Height = 22
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 1
      Items.Strings = (
        #1044#1074#1086#1080#1095#1085#1099#1081' '#1069#1074#1077#1088#1077#1089#1090' (*.evd)'
        #1058#1077#1082#1089#1090#1074#1086#1074#1099#1081' '#1069#1074#1077#1088#1077#1089#1090' (*.evd)'
        #1054#1073#1099#1095#1085#1099#1081' '#1090#1077#1082#1089#1090' (*.txt)'
        #1048#1089#1093#1086#1076#1085#1099#1081#1090#1077#1082#1089#1090' '#1043#1040#1056#1040#1053#1058#1072' (*.nsr)'
        #1044#1086#1082#1091#1084#1077#1085#1090' RTF (*.rtf)'
        #1042#1077#1073' '#1076#1086#1082#1091#1084#1077#1085#1090' (*.html)')
    end
  end
  object Button1: TButton
    Left = 364
    Top = 12
    Width = 127
    Height = 49
    Caption = #1057#1090#1072#1088#1090
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object ProgressBar: TProgressBar
    Left = 120
    Top = 240
    Width = 237
    Height = 17
    TabOrder = 3
    Visible = False
  end
  object XPManifest1: TXPManifest
    Left = 420
    Top = 104
  end
end
