object en_LocalizationManager: Ten_LocalizationManager
  Left = 233
  Top = 277
  Width = 890
  Height = 296
  Caption = 'Translation manager'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 124
    Width = 63
    Height = 16
    Caption = 'Source file'
  end
  object Label2: TLabel
    Left = 8
    Top = 156
    Width = 60
    Height = 16
    Caption = 'Target file'
  end
  object vtLabel1: TvtLabel
    Left = 492
    Top = 8
    Width = 373
    Height = 233
    AutoSize = False
    Caption = 
      '-1. '#1057#1076#1077#1083#1072#1090#1100' '#1092#1072#1081#1083' '#1089' '#1087#1077#1088#1077#1095#1080#1089#1083#1077#1085#1080#1077#1084' '#1080#1089#1093#1086#1076#1085#1099#1093' '#1088#1077#1089#1091#1088#1089#1086#1074' '#1076#1083#1103' '#1084#1077#1088#1076#1078#1072' (n' +
      'emesis.res.lng, admin.res.lng '#1080' monitorings.res.lng)'#13#10'0. '#1048#1079#1075#1086#1090#1086#1074 +
      #1080#1090#1100' nemesis.res.lng, admin.res.lng '#1080' monitorings.res.lng'#13#10'1. '#1057#1083#1080 +
      #1090#1100' (merge) '#1092#1072#1081#1083' '#1089' '#1087#1077#1088#1077#1095#1080#1089#1083#1077#1085#1080#1077#1084' '#1080#1089#1093#1086#1076#1085#1099#1093' '#1088#1077#1089#1091#1088#1089#1086#1074' '#1074' Target (shel' +
      'l.mo.lng)'#13#10'2. '#1042#1083#1080#1090#1100' (load/synchronize) shell.mo.lng '#1074' shell.mo.e' +
      'n'#13#10'3. '#1042#1099#1075#1088#1091#1079#1080#1090#1100' (export untranslated) '#1085#1077#1087#1077#1088#1077#1074#1077#1076#1077#1085#1085#1086#1077' '#1080#1079' shell.mo' +
      '.en'#13#10'4. '#1047#1072#1076#1080#1090#1100' (load translated) '#1087#1077#1088#1077#1074#1086#1076' '#1074' shell.mo.en'
    WordWrap = True
  end
  object SourceFileEdit: TEdit
    Left = 80
    Top = 120
    Width = 313
    Height = 24
    TabOrder = 1
  end
  object SourceBrowseBtn: TButton
    Left = 404
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Browse'
    TabOrder = 2
    OnClick = SourceBrowseBtnClick
  end
  object TargetFileEdit: TEdit
    Left = 80
    Top = 152
    Width = 317
    Height = 24
    TabOrder = 3
  end
  object TargetBrowseBtn: TButton
    Left = 404
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Browse'
    TabOrder = 4
    OnClick = TargetBrowseBtnClick
  end
  object ModeRadioGroup: TRadioGroup
    Left = 8
    Top = 8
    Width = 473
    Height = 105
    Caption = 'Mode'
    ItemIndex = 0
    Items.Strings = (
      'merge original messages (nemesis + monitorings + admin => shell)'
      'load/synchronize original language messages'
      'export untranslated messages'
      'load translated messages')
    TabOrder = 0
    OnClick = ModeRadioGroupClick
  end
  object ProcessBtn: TButton
    Left = 8
    Top = 184
    Width = 477
    Height = 57
    Caption = 'Process'
    TabOrder = 5
    OnClick = ProcessBtnClick
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*'
    Filter = '*.*|*.*'
    Left = 272
    Top = 132
  end
end
