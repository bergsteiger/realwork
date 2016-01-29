object Main: TMain
  Left = 176
  Top = 149
  Width = 696
  Height = 256
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1085#1086#1074#1099#1093' '#1076#1072#1085#1085#1099#1093
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object labIniFile: TLabel
    Left = 18
    Top = 16
    Width = 75
    Height = 13
    Caption = #1060#1072#1081#1083' Archi.ini :'
  end
  object labDataFile: TLabel
    Left = 20
    Top = 88
    Width = 211
    Height = 13
    Caption = #1060#1072#1081#1083' '#1089' '#1076#1072#1085#1085#1099#1084#1080' '#1086' '#1085#1086#1074#1099#1093' '#1075#1080#1087#1077#1088#1089#1089#1099#1083#1082#1072#1093' :'
  end
  object labDataFile2: TLabel
    Left = 22
    Top = 166
    Width = 167
    Height = 13
    Caption = #1060#1072#1081#1083' '#1089' '#1076#1072#1085#1085#1099#1084#1080' '#1086' '#1085#1086#1074#1099#1093' '#1076#1072#1090#1072#1093' :'
  end
  object bLoadHLinks: TButton
    Left = 500
    Top = 106
    Width = 143
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' '#1041#1044
    TabOrder = 0
    OnClick = bLoadHLinksClick
  end
  object edArchiIni: TEdit
    Left = 18
    Top = 36
    Width = 351
    Height = 21
    TabOrder = 1
  end
  object edHLinkFile: TEdit
    Left = 18
    Top = 106
    Width = 351
    Height = 21
    TabOrder = 2
  end
  object bSelectHlinkFile: TButton
    Left = 390
    Top = 104
    Width = 75
    Height = 25
    Caption = #1042#1099#1073#1088#1072#1090#1100' ...'
    TabOrder = 3
    OnClick = bSelectHlinkFileClick
  end
  object bSelectArchiIni: TButton
    Left = 388
    Top = 34
    Width = 75
    Height = 25
    Caption = #1042#1099#1073#1088#1072#1090#1100' ...'
    TabOrder = 4
    OnClick = bSelectArchiIniClick
  end
  object edDatesFile: TEdit
    Left = 20
    Top = 184
    Width = 351
    Height = 21
    TabOrder = 5
  end
  object bSelectDatesFile: TButton
    Left = 392
    Top = 182
    Width = 75
    Height = 25
    Caption = #1042#1099#1073#1088#1072#1090#1100' ...'
    TabOrder = 6
    OnClick = bSelectDatesFileClick
  end
  object bLoadDates: TButton
    Left = 502
    Top = 184
    Width = 143
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' '#1041#1044
    TabOrder = 7
    OnClick = bLoadDatesClick
  end
  object FileDialog: TOpenDialog
    DefaultExt = '*.ini'
    FileName = 'archi.ini'
    Filter = 'Ini-'#1092#1072#1081#1083#1099'|*.ini|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = #1060#1072#1081#1083' '#1089' '#1085#1072#1089#1090#1088#1086#1081#1082#1072#1084#1080' '#1041#1044' (archi.ini)'
    Left = 276
    Top = 8
  end
end
