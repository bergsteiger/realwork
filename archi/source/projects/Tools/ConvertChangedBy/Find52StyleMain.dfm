object MainForm: TMainForm
  Left = 383
  Top = 217
  BorderStyle = bsDialog
  Caption = #1040#1088#1093#1080#1074#1072#1088#1080#1091#1089'. '#1055#1086#1080#1089#1082' '#1089#1090#1080#1083#1103' 52'
  ClientHeight = 268
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    536
    268)
  PixelsPerInch = 96
  TextHeight = 16
  object lbPercent: TLabel
    Left = 16
    Top = 224
    Width = 393
    Height = 16
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
  end
  object btWork: TButton
    Left = 439
    Top = 7
    Width = 90
    Height = 26
    Caption = #1053#1072#1095#1072#1090#1100
    Default = True
    TabOrder = 0
    OnClick = btWorkClick
  end
  object btStop: TButton
    Left = 440
    Top = 39
    Width = 89
    Height = 26
    Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = btStopClick
  end
  object pnStatus: TPanel
    Left = 16
    Top = 253
    Width = 393
    Height = 14
    Align = alCustom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 2
  end
  object Progress: TProgressBar
    Left = 16
    Top = 240
    Width = 393
    Height = 10
    Smooth = True
    TabOrder = 3
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 0
    Width = 409
    Height = 105
    Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1082' '#1073#1072#1079#1077
    TabOrder = 4
    DesignSize = (
      409
      105)
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 85
      Height = 16
      Caption = #1055#1072#1087#1082#1072' '#1089' '#1073#1072#1079#1086#1081
    end
    object Label4: TLabel
      Left = 8
      Top = 56
      Width = 83
      Height = 16
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    end
    object Label5: TLabel
      Left = 208
      Top = 56
      Width = 44
      Height = 16
      Caption = #1055#1072#1088#1086#1083#1100
    end
    object edBaseDir: TDirectoryEdit
      Left = 8
      Top = 32
      Width = 393
      Height = 21
      Hint = #1055#1086#1083#1085#1099#1081' '#1087#1091#1090#1100' '#1082' '#1087#1072#1087#1082#1077' '#1089' '#1073#1072#1079#1086#1081
      NumGlyphs = 1
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object EditLogin: TEdit
      Left = 8
      Top = 72
      Width = 193
      Height = 24
      TabOrder = 1
    end
    object EditPassword: TEdit
      Left = 208
      Top = 72
      Width = 193
      Height = 24
      PasswordChar = '*'
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 112
    Width = 409
    Height = 105
    Caption = #1054#1073#1088#1072#1073#1086#1090#1082#1072
    TabOrder = 5
    object Label2: TLabel
      Left = 8
      Top = 17
      Width = 85
      Height = 16
      Caption = #1054#1073#1088#1072#1073#1072#1090#1099#1074#1072#1090#1100
    end
    object lblTopicListFN: TLabel
      Left = 8
      Top = 57
      Width = 154
      Height = 16
      Caption = #1060#1072#1081#1083' '#1089#1086' '#1089#1087#1080#1089#1082#1086#1084' '#1090#1086#1087#1080#1082#1086#1074
      FocusControl = edTopicListFN
      Visible = False
    end
    object comboWhat: TComboBox
      Left = 8
      Top = 33
      Width = 391
      Height = 24
      Hint = 
        #1053#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1074#1099#1073#1088#1072#1090#1100' '#1086#1073#1098#1077#1084' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' - '#1074#1089#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1080#1083#1080' '#1089#1087#1080#1089#1086#1082' '#1076#1086 +
        #1082#1091#1084#1077#1085#1090#1086#1074
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 0
      OnChange = comboWhatChange
      Items.Strings = (
        #1042#1089#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1074' '#1093#1088#1072#1085#1080#1083#1080#1097#1077
        #1044#1086#1082#1091#1084#1077#1085#1090#1099' '#1089#1087#1080#1089#1082#1072)
    end
    object edTopicListFN: TFilenameEdit
      Left = 8
      Top = 76
      Width = 393
      Height = 21
      Hint = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1092#1072#1081#1083' '#1089#1086' '#1089#1087#1080#1089#1082#1086#1084' '#1042#1053#1059#1058#1056#1045#1053#1053#1048#1061' '#1085#1086#1084#1077#1088#1086#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      Filter = #1060#1072#1081#1083#1099' '#1089#1087#1080#1089#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074'(*.lst, *.txt)|*.lst;*.txt'
      NumGlyphs = 1
      TabOrder = 1
      Visible = False
    end
  end
end
