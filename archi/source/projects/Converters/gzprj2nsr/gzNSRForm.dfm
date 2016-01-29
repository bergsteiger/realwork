object ConverterForm: TConverterForm
  Left = 633
  Top = 190
  BorderStyle = bsToolWindow
  Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077' '#1087#1086#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1081
  ClientHeight = 72
  ClientWidth = 461
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object ProgressLabel: TLabel
    Left = 8
    Top = 56
    Width = 449
    Height = 13
    AutoSize = False
  end
  object LabelFolder: TLabel
    Left = 8
    Top = 24
    Width = 449
    Height = 17
    AutoSize = False
  end
  object LabelFile: TLabel
    Left = 8
    Top = 40
    Width = 449
    Height = 16
    AutoSize = False
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 8
    Width = 449
    Height = 17
    Smooth = True
    TabOrder = 0
  end
end
