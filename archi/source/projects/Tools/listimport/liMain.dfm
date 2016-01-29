object MainForm: TMainForm
  Left = 630
  Top = 370
  ActiveControl = feFilename
  BorderStyle = bsSingle
  Caption = #1054#1073#1088#1072#1073#1086#1090#1082#1072' '#1088#1077#1077#1089#1090#1088#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
  ClientHeight = 147
  ClientWidth = 458
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 73
    Height = 13
    Caption = #1060#1072#1081#1083' '#1088#1077#1077#1089#1090#1088#1072
  end
  object feFilename: TFilenameEdit
    Left = 16
    Top = 32
    Width = 425
    Height = 21
    Filter = #1060#1072#1081#1083#1099' '#1088#1077#1077#1089#1090#1088#1086#1074' (*.csv)|*.csv'
    NumGlyphs = 1
    TabOrder = 0
    OnChange = feFilenameChange
  end
  object ProgressBar: TProgressBar
    Left = 16
    Top = 64
    Width = 425
    Height = 17
    TabOrder = 1
  end
  object btnStart: TButton
    Left = 112
    Top = 96
    Width = 233
    Height = 41
    Caption = #1053#1072#1095#1072#1083#1080'!'
    Default = True
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnStartClick
  end
end
