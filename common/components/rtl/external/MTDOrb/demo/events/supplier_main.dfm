object Form1: TForm1
  Left = 223
  Top = 134
  BorderStyle = bsDialog
  Caption = 'Event supplier'
  ClientHeight = 87
  ClientWidth = 254
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
    Top = 8
    Width = 56
    Height = 13
    Caption = 'Parameters:'
  end
  object Edit1: TEdit
    Left = 7
    Top = 25
    Width = 241
    Height = 21
    TabOrder = 0
    Text = '-ORBNamingAddr inet:localhost:10000'
  end
  object Button1: TButton
    Left = 176
    Top = 56
    Width = 75
    Height = 25
    Caption = 'send'
    TabOrder = 1
    OnClick = Button1Click
  end
end
