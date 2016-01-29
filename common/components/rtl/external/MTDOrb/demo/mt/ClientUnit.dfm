object Form1: TForm1
  Left = -2
  Top = 112
  Width = 246
  Height = 168
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = Button1Click
  end
  object edLoop: TEdit
    Left = 104
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object Memo1: TMemo
    Left = 8
    Top = 40
    Width = 217
    Height = 89
    TabOrder = 2
  end
end
