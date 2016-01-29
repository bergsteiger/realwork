object MainForm: TMainForm
  Left = 542
  Top = 371
  BorderStyle = bsDialog
  Caption = #1057#1087#1080#1089#1086#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1089#1086' '#1089#1087#1088#1072#1074#1082#1072#1084#1080
  ClientHeight = 139
  ClientWidth = 442
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
    Left = 8
    Top = 8
    Width = 278
    Height = 13
    Caption = #1059#1082#1072#1078#1080#1090#1077' '#1092#1072#1081#1083', '#1074' '#1082#1086#1090#1086#1088#1099#1081' '#1085#1091#1078#1085#1086' '#1079#1072#1087#1080#1089#1072#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1099
  end
  object Button1: TButton
    Left = 148
    Top = 88
    Width = 145
    Height = 41
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100
    TabOrder = 0
    OnClick = Button1Click
  end
  object feResultFile: TFilenameEdit
    Left = 8
    Top = 24
    Width = 425
    Height = 21
    NumGlyphs = 1
    TabOrder = 1
  end
  object Progress: TProgressBar
    Left = 8
    Top = 56
    Width = 425
    Height = 17
    Step = 1
    TabOrder = 2
  end
  object XPManifest1: TXPManifest
    Left = 368
    Top = 8
  end
end
