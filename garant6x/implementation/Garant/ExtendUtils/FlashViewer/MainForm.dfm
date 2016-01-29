object fmMain: TfmMain
  Left = 106
  Top = 159
  Width = 870
  Height = 640
  Caption = 'FlashViewer'
  Color = $00F9F8FA
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
  object Header: TvtPanel
    Left = 0
    Top = 0
    Width = 854
    Height = 59
    Align = alTop
    TabOrder = 0
    object lbWidth: TvtLabel
      Left = 568
      Top = 8
      Width = 81
      Height = 16
      Caption = 'lbWidth'
    end
    object lbHeight: TvtLabel
      Left = 568
      Top = 24
      Width = 89
      Height = 16
      Caption = 'lbHeight'
    end
    object lbCommand: TvtLabel
      Left = 1
      Top = 42
      Width = 852
      Height = 16
      Align = alBottom
      Caption = 'lbCommand'
    end
    object btLoad: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072
      TabOrder = 0
      OnClick = btLoadClick
    end
    object edFileName: TFilenameEdit
      Left = 91
      Top = 10
      Width = 470
      Height = 21
      OnAfterDialog = edFileNameAfterDialog
      Filter = #1057#1093#1077#1084#1099' (*.swf)|*.swf|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
      InitialDir = 'c:\'
      NumGlyphs = 1
      TabOrder = 1
      Text = '*.swf'
    end
  end
  object Client: TvtPanel
    Left = 0
    Top = 59
    Width = 854
    Height = 545
    Align = alClient
    TabOrder = 1
    object Box: TScrollBox
      Left = 1
      Top = 1
      Width = 852
      Height = 543
      Align = alClient
      TabOrder = 0
    end
  end
  object Timer: TTimer
    Interval = 500
    OnTimer = TimerTimer
    Left = 32
    Top = 73
  end
end
