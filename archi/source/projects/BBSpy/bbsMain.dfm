object MainForm: TMainForm
  Left = 647
  Top = 331
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1064#1087#1080#1086#1085' '#1041#1086#1083#1100#1096#1086#1075#1086' '#1041#1088#1072#1090#1072
  ClientHeight = 201
  ClientWidth = 356
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblDate1: TLabel
    Left = 8
    Top = 76
    Width = 67
    Height = 13
    Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1089
  end
  object lblDate2: TLabel
    Left = 208
    Top = 76
    Width = 12
    Height = 13
    Caption = #1087#1086
  end
  object Label3: TLabel
    Left = 8
    Top = 16
    Width = 36
    Height = 13
    Caption = #1056#1077#1075#1080#1086#1085
  end
  object lblOutFile: TLabel
    Left = 8
    Top = 112
    Width = 112
    Height = 13
    Caption = #1060#1072#1081#1083' '#1089' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072#1084#1080
  end
  object deFrom: TvtDateEdit
    Left = 80
    Top = 72
    Width = 121
    Height = 21
    Style = csDropDown
    TabOrder = 0
  end
  object deTo: TvtDateEdit
    Left = 224
    Top = 72
    Width = 121
    Height = 21
    Style = csDropDown
    TabOrder = 1
  end
  object cbRegion: TComboBox
    Left = 8
    Top = 32
    Width = 337
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
  object feResultFile: TFilenameEdit
    Left = 8
    Top = 128
    Width = 337
    Height = 21
    DefaultExt = 'csv'
    Filter = #1060#1072#1081#1083#1099' CSV (*.csv)|*.csv'
    DialogTitle = #1042#1099#1073#1077#1088#1080#1090#1077' '#1092#1072#1081#1083' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072
    NumGlyphs = 1
    TabOrder = 3
  end
  object btnStart: TButton
    Left = 8
    Top = 160
    Width = 225
    Height = 33
    Caption = #1055#1059#1057#1050
    Enabled = False
    TabOrder = 4
    OnClick = btnStartClick
  end
  object btnExit: TButton
    Left = 240
    Top = 160
    Width = 105
    Height = 33
    Cancel = True
    Caption = #1042#1067#1061#1054#1044
    TabOrder = 5
    OnClick = btnExitClick
  end
  object Timer1: TTimer
    Interval = 300
    OnTimer = Timer1Timer
    Left = 328
  end
end
