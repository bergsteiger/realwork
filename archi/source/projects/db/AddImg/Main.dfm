object formMain: TformMain
  Left = 542
  Top = 277
  Width = 411
  Height = 326
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1086#1073#1088#1072#1079#1086#1074' '#1082' '#1041#1044
  Color = clBtnFace
  Constraints.MaxHeight = 326
  Constraints.MinHeight = 326
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    395
    288)
  PixelsPerInch = 96
  TextHeight = 13
  object butSrcFile: TSpeedButton
    Left = 367
    Top = 30
    Width = 21
    Height = 21
    Anchors = [akTop, akRight]
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = butSrcFileClick
  end
  object labSrcFile: TLabel
    Left = 16
    Top = 12
    Width = 145
    Height = 13
    Caption = #1060#1072#1081#1083' '#1089' '#1086#1087#1080#1089#1072#1085#1080#1077#1084' '#1086#1073#1088#1072#1079#1086#1074':'
  end
  object labProgress: TLabel
    Left = 16
    Top = 204
    Width = 161
    Height = 13
    Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1087#1088#1086#1094#1077#1089#1089#1072' '#1086#1073#1088#1072#1073#1086#1090#1082#1080
  end
  object labSource: TLabel
    Left = 18
    Top = 66
    Width = 131
    Height = 13
    Caption = #1048#1089#1090#1086#1095#1085#1080#1082' '#1086#1087#1091#1073#1083#1080#1082#1086#1074#1072#1085#1080#1103':'
  end
  object lblAddSource: TLabel
    Left = 18
    Top = 114
    Width = 220
    Height = 13
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1081' '#1080#1089#1090#1086#1095#1085#1080#1082' '#1086#1087#1091#1073#1083#1080#1082#1086#1074#1072#1085#1080#1103':'
    Enabled = False
    FocusControl = cbAddSource
  end
  object edSrcFile: TEdit
    Left = 16
    Top = 30
    Width = 351
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object butRun: TButton
    Left = 213
    Top = 260
    Width = 80
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1091#1089#1082
    TabOrder = 3
    OnClick = butRunClick
  end
  object prBar: TProgressBar
    Left = 16
    Top = 222
    Width = 371
    Height = 16
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object butExit: TButton
    Left = 313
    Top = 260
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 4
    OnClick = butExitClick
  end
  object cbSource: TComboBox
    Left = 18
    Top = 84
    Width = 370
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    TabOrder = 1
    OnSelect = cbSourceSelect
  end
  object cbCloseOnFinish: TCheckBox
    Left = 18
    Top = 168
    Width = 279
    Height = 17
    Caption = #1047#1072#1082#1088#1099#1090#1100' '#1087#1088#1086#1075#1088#1072#1084#1084#1091' '#1087#1086' '#1086#1082#1086#1085#1095#1072#1085#1080#1080' '#1087#1088#1086#1094#1077#1089#1089#1072
    TabOrder = 5
  end
  object cbAddSource: TComboBox
    Left = 18
    Top = 132
    Width = 370
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    Enabled = False
    ItemHeight = 13
    TabOrder = 6
  end
  object OpenDialog: TOpenDialog
    Left = 222
    Top = 4
  end
end
