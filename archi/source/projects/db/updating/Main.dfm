object FormMain: TFormMain
  Left = 450
  Top = 284
  Width = 500
  Height = 500
  Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1041#1044' "'#1040#1088#1093#1080#1074#1072#1088#1080#1091#1089#1072'"'
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pTop: TPanel
    Left = 0
    Top = 0
    Width = 484
    Height = 249
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      484
      249)
    object Bevel1: TBevel
      Left = 12
      Top = 186
      Width = 463
      Height = 51
      Anchors = [akLeft, akTop, akRight]
    end
    object labDbInfo: TLabel
      Left = 14
      Top = 61
      Width = 258
      Height = 13
      Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086' '#1090#1077#1082#1091#1097#1077#1084' '#1089#1086#1089#1090#1086#1103#1085#1080#1080' '#1086#1073#1085#1086#1074#1083#1103#1077#1084#1086#1081' '#1041#1044' :'
    end
    object labIniFile: TLabel
      Left = 12
      Top = 10
      Width = 146
      Height = 13
      Caption = #1050#1086#1088#1085#1077#1074#1072#1103' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1103' '#1073#1072#1079#1099' :'
    end
    object labUpdateInfo: TLabel
      Left = 20
      Top = 190
      Width = 3
      Height = 13
    end
    object bDoUpdate: TButton
      Left = 290
      Top = 198
      Width = 178
      Height = 27
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = bDoUpdateClick
    end
    object mDbInfo: TMemo
      Left = 12
      Top = 82
      Width = 463
      Height = 99
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      ParentColor = True
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object edtBaseDir: TDirectoryEdit
      Left = 12
      Top = 24
      Width = 463
      Height = 21
      OnAfterDialog = edtBaseDirAfterDialog
      DialogKind = dkWin32
      DirectInput = False
      NumGlyphs = 1
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
  end
  object mLog: TMemo
    Left = 0
    Top = 249
    Width = 484
    Height = 213
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
  object XPManifest1: TXPManifest
    Left = 392
    Top = 48
  end
end
