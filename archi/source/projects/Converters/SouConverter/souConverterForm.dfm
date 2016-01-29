object souMainForm: TsouMainForm
  Left = 323
  Top = 184
  BorderStyle = bsDialog
  Caption = #1055#1088#1086#1089#1090#1072#1085#1086#1074#1082#1072' '#1089#1089#1099#1083#1086#1082' '#1080' '#1050#1058
  ClientHeight = 79
  ClientWidth = 357
  Color = clBtnFace
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
  object LabelFile: TLabel
    Left = 8
    Top = 8
    Width = 345
    Height = 13
    AutoSize = False
  end
  object LabelFOlder: TLabel
    Left = 8
    Top = 24
    Width = 345
    Height = 13
    AutoSize = False
  end
  object ProgressLabel: TLabel
    Left = 8
    Top = 64
    Width = 337
    Height = 13
    AutoSize = False
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 40
    Width = 337
    Height = 17
    TabOrder = 0
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 208
    Top = 8
  end
end
