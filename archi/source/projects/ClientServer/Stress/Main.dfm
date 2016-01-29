object Form3: TForm3
  Left = 192
  Top = 124
  Width = 360
  Height = 196
  Caption = 'STress test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 28
    Top = 32
    Width = 44
    Height = 13
    Caption = 'FileName'
  end
  object Label2: TLabel
    Left = 36
    Top = 60
    Width = 39
    Height = 13
    Caption = 'SizePart'
  end
  object Edit1: TEdit
    Left = 80
    Top = 28
    Width = 253
    Height = 21
    TabOrder = 0
    Text = 'C:\_out\document.nsr '
  end
  object Edit2: TEdit
    Left = 80
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '65536'
  end
  object Button1: TButton
    Left = 64
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Run'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 188
    Top = 108
    Width = 75
    Height = 25
    Caption = 'Run2'
    TabOrder = 3
    OnClick = Button2Click
  end
end
