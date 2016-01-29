object FindMainForm: TFindMainForm
  Left = 282
  Top = 110
  ActiveControl = FindDriSelector
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082' '#1082#1088#1080#1074#1099#1093' '#1090#1072#1073#1083#1080#1094
  ClientHeight = 65
  ClientWidth = 432
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Progress: TLabel
    Left = 8
    Top = 38
    Width = 337
    Height = 17
    AutoSize = False
  end
  object StartButton: TButton
    Left = 348
    Top = 8
    Width = 75
    Height = 25
    Caption = #1057#1090#1072#1088#1090
    Default = True
    TabOrder = 1
    OnClick = StartButtonClick
  end
  object FindDriSelector: TDirectoryEdit
    Left = 8
    Top = 10
    Width = 337
    Height = 21
    NumGlyphs = 1
    TabOrder = 0
    Text = 'w:\TestDocs'
  end
end
