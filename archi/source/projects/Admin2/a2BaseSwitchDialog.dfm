object a2BaseSwitchForm: Ta2BaseSwitchForm
  Left = 431
  Top = 329
  BorderStyle = bsDialog
  Caption = #1055#1077#1088#1077#1082#1083#1102#1095#1077#1085#1080#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
  ClientHeight = 208
  ClientWidth = 519
  Color = clBtnFace
  Constraints.MinHeight = 238
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    519
    208)
  PixelsPerInch = 96
  TextHeight = 14
  object lblDisp: TLabel
    Left = 8
    Top = 179
    Width = 338
    Height = 27
    Anchors = [akRight, akBottom]
    AutoSize = False
    WordWrap = True
  end
  object Label1: TLabel
    Left = 248
    Top = 2
    Width = 54
    Height = 14
    Caption = 'Family path'
  end
  object Label2: TLabel
    Left = 248
    Top = 42
    Width = 47
    Height = 14
    Caption = 'TablePath'
  end
  object Label3: TLabel
    Left = 248
    Top = 82
    Width = 61
    Height = 14
    Caption = 'HomeDirPath'
  end
  object Label4: TLabel
    Left = 248
    Top = 123
    Width = 44
    Height = 14
    Caption = 'LockPath'
  end
  object rgBases: TRadioGroup
    Left = 8
    Top = 8
    Width = 233
    Height = 150
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = ' '#1055#1077#1088#1077#1082#1083#1102#1095#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081' '#1085#1072'... '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      #1056#1072#1073#1086#1095#1091#1102' '#1073#1072#1079#1091
      #1055#1086#1083#1085#1091#1102' '#1088#1077#1079#1077#1088#1074#1085#1091#1102' '#1082#1086#1087#1080#1102)
    ParentFont = False
    TabOrder = 0
    OnClick = rgBasesClick
  end
  object btnSwitch: TButton
    Left = 348
    Top = 179
    Width = 83
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1055#1077#1088#1077#1082#1083#1102#1095#1080#1090#1100
    Default = True
    TabOrder = 1
    OnClick = btnSwitchClick
  end
  object btnCancel: TButton
    Left = 436
    Top = 179
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 163
    Width = 506
    Height = 11
    Anchors = [akRight, akBottom]
    TabOrder = 3
    Visible = False
  end
  object edFamPath: TDirectoryEdit
    Left = 248
    Top = 16
    Width = 265
    Height = 21
    NumGlyphs = 1
    TabOrder = 4
    OnChange = edHomePathChange
  end
  object edTablePath: TDirectoryEdit
    Left = 248
    Top = 56
    Width = 265
    Height = 21
    NumGlyphs = 1
    TabOrder = 5
    OnChange = edHomePathChange
  end
  object edHomePath: TDirectoryEdit
    Left = 248
    Top = 96
    Width = 265
    Height = 21
    NumGlyphs = 1
    TabOrder = 6
    OnChange = edHomePathChange
  end
  object edLockPath: TDirectoryEdit
    Left = 248
    Top = 136
    Width = 265
    Height = 21
    NumGlyphs = 1
    TabOrder = 7
    OnChange = edHomePathChange
  end
end
