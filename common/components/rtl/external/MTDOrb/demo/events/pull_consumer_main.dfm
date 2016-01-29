object Form1: TForm1
  Left = 262
  Top = 154
  BorderStyle = bsDialog
  Caption = 'Event pull consumer'
  ClientHeight = 181
  ClientWidth = 277
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 56
    Height = 13
    Caption = 'Parameters:'
  end
  object Edit1: TEdit
    Left = 7
    Top = 25
    Width = 266
    Height = 21
    TabOrder = 1
    Text = '-ORBNamingAddr inet:localhost:10000'
  end
  object Memo1: TMemo
    Left = 8
    Top = 56
    Width = 177
    Height = 113
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object Button1: TButton
    Left = 192
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Pull'
    TabOrder = 0
    OnClick = Button1Click
  end
end
