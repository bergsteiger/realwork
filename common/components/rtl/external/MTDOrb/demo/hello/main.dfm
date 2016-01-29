object Form1: TForm1
  Left = 233
  Top = 138
  BorderStyle = bsDialog
  Caption = 'Hello'
  ClientHeight = 85
  ClientWidth = 333
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
    Left = 16
    Top = 8
    Width = 59
    Height = 13
    Caption = 'IOR location'
  end
  object Button1: TButton
    Left = 248
    Top = 56
    Width = 75
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 24
    Width = 305
    Height = 21
    TabOrder = 1
    Text = 'http://www.home.org/hello.ref'
  end
end
