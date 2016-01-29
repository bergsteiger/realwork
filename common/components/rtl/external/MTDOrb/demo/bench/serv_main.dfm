object Form1: TForm1
  Left = 285
  Top = 204
  BorderStyle = bsDialog
  Caption = 'Bench server'
  ClientHeight = 62
  ClientWidth = 294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 3
    Width = 41
    Height = 13
    Caption = 'Address:'
  end
  object Edit1: TEdit
    Left = 8
    Top = 24
    Width = 193
    Height = 21
    TabOrder = 0
    Text = 'inet:localhost:10000'
  end
  object Button1: TButton
    Left = 208
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = Button1Click
  end
end
