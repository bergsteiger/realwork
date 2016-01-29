object Form1: TForm1
  Left = 1528
  Top = 69
  BorderStyle = bsDialog
  Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1086#1092#1086#1088#1084#1083#1077#1085#1080#1103' '#1090#1077#1082#1089#1090#1086#1074
  ClientHeight = 244
  ClientWidth = 489
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
  object Button1: TButton
    Left = 400
    Top = 8
    Width = 75
    Height = 25
    Caption = #1047#1072#1087#1091#1089#1082
    TabOrder = 0
    OnClick = Button1Click
  end
  object listFiles: TCheckListBox
    Left = 8
    Top = 8
    Width = 377
    Height = 217
    ItemHeight = 13
    TabOrder = 1
    OnDblClick = listFilesDblClick
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 232
    Width = 377
    Height = 9
    Smooth = True
    TabOrder = 2
  end
  object btnHideGood: TButton
    Left = 400
    Top = 56
    Width = 75
    Height = 25
    Caption = #1059#1073#1088#1072#1090#1100
    TabOrder = 3
    OnClick = btnHideGoodClick
  end
  object BtnRestore: TButton
    Left = 400
    Top = 88
    Width = 75
    Height = 25
    Caption = #1042#1077#1088#1085#1091#1090#1100
    TabOrder = 4
    OnClick = BtnRestoreClick
  end
end
