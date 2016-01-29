object Form1: TForm1
  Left = 372
  Top = 329
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1086#1080#1089#1082' '#1073#1080#1090#1099#1093' '#1086#1073#1088#1072#1079#1086#1074
  ClientHeight = 157
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 139
    Height = 13
    Caption = #1044#1080#1088#1077#1082#1090#1086#1088#1080#1103' '#1076#1083#1103' '#1086#1073#1088#1072#1073#1086#1090#1082#1080
    FocusControl = deInitDir
  end
  object dispLabel1: TLabel
    Left = 8
    Top = 80
    Width = 51
    Height = 13
    Caption = 'dispLabel1'
    Visible = False
  end
  object dispLabel2: TLabel
    Left = 8
    Top = 96
    Width = 51
    Height = 13
    Caption = 'dispLabel2'
    Visible = False
  end
  object deInitDir: TDirectoryEdit
    Left = 8
    Top = 24
    Width = 513
    Height = 21
    DialogKind = dkWin32
    NumGlyphs = 1
    TabOrder = 0
  end
  object cbSubDir: TCheckBox
    Left = 8
    Top = 56
    Width = 289
    Height = 17
    Caption = #1057#1082#1072#1085#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1076#1076#1080#1088#1077#1082#1090#1086#1088#1080#1080
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object btnStart: TButton
    Left = 8
    Top = 120
    Width = 169
    Height = 25
    Caption = #1053#1072#1095#1072#1090#1100' '#1086#1073#1088#1072#1073#1086#1090#1082#1091
    TabOrder = 2
    OnClick = btnStartClick
  end
  object btnExit: TButton
    Left = 448
    Top = 120
    Width = 75
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 3
    OnClick = btnExitClick
  end
  object DirIterator: TvtDirNavigator
    IncludeFileFilter = '*.TIF'
    DirectoryFilter = '*.*'
    SrchFileAttr = [foNormalFiles, foReadOnlyFiles, foArchiveFiles]
    ExploreDirAttr = [foNormalDir]
    OnFound = DirIteratorFound
    Left = 448
    Top = 8
  end
  object XPManifest1: TXPManifest
    Left = 480
    Top = 8
  end
end
