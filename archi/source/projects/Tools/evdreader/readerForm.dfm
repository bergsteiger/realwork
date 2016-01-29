object Form1: TForm1
  Left = 282
  Top = 110
  ActiveControl = DirectoryEdit1
  BorderStyle = bsDialog
  Caption = #1048#1079' '#1087#1091#1089#1090#1086#1075#1086' '#1074' '#1087#1086#1088#1086#1078#1085#1077#1077
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
  object Label1: TLabel
    Left = 8
    Top = 38
    Width = 337
    Height = 17
    AutoSize = False
  end
  object Button1: TButton
    Left = 348
    Top = 8
    Width = 75
    Height = 25
    Caption = #1057#1090#1072#1088#1090
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object DirectoryEdit1: TDirectoryEdit
    Left = 8
    Top = 10
    Width = 337
    Height = 21
    NumGlyphs = 1
    TabOrder = 0
    Text = 'D:\evd\2'
  end
end
