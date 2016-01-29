object Form1: TForm1
  Left = 231
  Top = 148
  BorderStyle = bsDialog
  Caption = 'Bench client'
  ClientHeight = 128
  ClientWidth = 337
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
    Left = 16
    Top = 8
    Width = 38
    Height = 13
    Caption = 'Address'
  end
  object Edit1: TEdit
    Left = 16
    Top = 24
    Width = 225
    Height = 21
    TabOrder = 0
    Text = 'inet:localhost:10000'
  end
  object Button1: TButton
    Left = 248
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 48
    Width = 225
    Height = 73
    TabOrder = 2
  end
end
