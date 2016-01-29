object FormMain: TFormMain
  Left = 433
  Top = 110
  Width = 506
  Height = 500
  Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1041#1044' "'#1040#1088#1093#1080#1074#1072#1088#1080#1091#1089#1072'"'
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pTop: TPanel
    Left = 0
    Top = 0
    Width = 498
    Height = 175
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      498
      175)
    object labIniFile: TLabel
      Left = 16
      Top = 10
      Width = 75
      Height = 13
      Caption = #1060#1072#1081#1083' Archi.ini :'
    end
    object labDBList: TLabel
      Left = 295
      Top = 8
      Width = 92
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1057#1087#1080#1089#1086#1082' '#1089#1077#1084#1077#1081#1089#1090#1074':'
    end
    object labGarantFolder: TLabel
      Left = 16
      Top = 90
      Width = 91
      Height = 14
      Caption = #1055#1072#1087#1082#1072' Garant:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object labMainFolder: TLabel
      Left = 16
      Top = 112
      Width = 77
      Height = 14
      Caption = #1055#1072#1087#1082#1072' Main:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object bDoVerify: TButton
      Left = 16
      Top = 136
      Width = 178
      Height = 27
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = bDoVerifyClick
    end
    object edIniFile: TEdit
      Left = 16
      Top = 28
      Width = 264
      Height = 21
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      ParentColor = True
      ReadOnly = True
      TabOrder = 2
    end
    object bSelectIniFile: TButton
      Left = 16
      Top = 56
      Width = 97
      Height = 25
      Caption = #1042#1099#1073#1088#1072#1090#1100' ...'
      TabOrder = 3
      OnClick = bSelectIniFileClick
    end
    object lbFamilyNames: TListBox
      Left = 293
      Top = 26
      Width = 191
      Height = 53
      Anchors = [akTop, akRight]
      ItemHeight = 13
      TabOrder = 4
    end
    object bDoRepair: TButton
      Left = 306
      Top = 136
      Width = 178
      Height = 27
      Anchors = [akTop, akRight]
      Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = bDoVerifyClick
    end
  end
  object mLog: TMemo
    Left = 0
    Top = 175
    Width = 498
    Height = 297
    TabStop = False
    Align = alClient
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'System'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object IniFileDialog: TOpenDialog
    DefaultExt = '*.ini'
    FileName = 'archi.ini'
    Filter = 'Ini-'#1092#1072#1081#1083#1099'|*.ini|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = #1060#1072#1081#1083' '#1089' '#1085#1072#1089#1090#1088#1086#1081#1082#1072#1084#1080' '#1041#1044' (archi.ini)'
    Left = 238
    Top = 66
  end
end
