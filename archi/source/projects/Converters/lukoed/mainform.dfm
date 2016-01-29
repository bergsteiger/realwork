object SDFImportForm: TSDFImportForm
  Left = 1956
  Top = 455
  BorderStyle = bsDialog
  Caption = #1048#1084#1087#1086#1088#1090' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1051#1059#1050#1086#1081#1083
  ClientHeight = 304
  ClientWidth = 574
  Color = clBtnFace
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
  object LabelProgress: TLabel
    Left = 8
    Top = 232
    Width = 553
    Height = 13
    Alignment = taCenter
    AutoSize = False
  end
  object WorkSpace: TPanel
    Left = 0
    Top = 0
    Width = 569
    Height = 225
    BevelOuter = bvNone
    TabOrder = 0
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 248
    Width = 553
    Height = 10
    Smooth = True
    TabOrder = 1
  end
  object ImportButton: TButton
    Left = 400
    Top = 272
    Width = 75
    Height = 25
    Caption = #1048#1084#1087#1086#1088#1090
    Default = True
    TabOrder = 2
    OnClick = ImportButtonClick
  end
  object CancelButton: TButton
    Left = 488
    Top = 272
    Width = 75
    Height = 25
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 3
    OnClick = Button2Click
  end
end
