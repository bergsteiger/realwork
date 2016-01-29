object ArchiIndexForm: TArchiIndexForm
  Left = 253
  Top = 120
  BorderStyle = bsDialog
  Caption = #1048#1085#1076#1077#1082#1089#1072#1090#1086#1088' '#1073#1072#1079#1099' "'#1040#1088#1093#1080#1074#1072#1088#1080#1091#1089#1072'"'
  ClientHeight = 112
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object lblProgressDescript: TLabel
    Left = 4
    Top = 92
    Width = 353
    Height = 13
    AutoSize = False
  end
  object cbBuildDocumentIndex: TCheckBox
    Left = 4
    Top = 4
    Width = 157
    Height = 17
    Caption = #1058#1077#1082#1089#1090#1099' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
    Checked = True
    State = cbChecked
    TabOrder = 0
  end
  object cbBuildHeaderIndex: TCheckBox
    Left = 4
    Top = 24
    Width = 161
    Height = 17
    Caption = #1053#1072#1079#1074#1072#1085#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object btnStart: TButton
    Left = 168
    Top = 4
    Width = 191
    Height = 69
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    Default = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btnStartClick
  end
  object pbProcess: TProgressBar
    Left = 4
    Top = 80
    Width = 353
    Height = 10
    Smooth = True
    Step = 1
    TabOrder = 5
  end
  object cbUpdateDatebase: TCheckBox
    Left = 4
    Top = 60
    Width = 161
    Height = 17
    Caption = #1054#1073#1085#1086#1074#1083#1103#1090#1100' '#1090#1072#1073#1083#1080#1094#1099
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object cbBuildDictEntryIndex: TCheckBox
    Left = 4
    Top = 42
    Width = 145
    Height = 17
    Caption = #1057#1083#1086#1074#1072#1088#1085#1099#1077' '#1089#1090#1072#1090#1100#1080
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
end
