object Form1: TForm1
  Left = 658
  Top = 429
  Width = 509
  Height = 422
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClick = FormClick
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 36
    Width = 28
    Height = 13
    Caption = 'Page:'
  end
  object Label2: TLabel
    Left = 32
    Top = 68
    Width = 20
    Height = 13
    Caption = 'Min:'
  end
  object Label3: TLabel
    Left = 32
    Top = 100
    Width = 23
    Height = 13
    Caption = 'Max:'
  end
  object Label4: TLabel
    Left = 32
    Top = 132
    Width = 21
    Height = 13
    Caption = 'Pos:'
  end
  object Label5: TLabel
    Left = 216
    Top = 36
    Width = 65
    Height = 13
    Caption = 'SmallChange:'
  end
  object Label6: TLabel
    Left = 216
    Top = 68
    Width = 67
    Height = 13
    Caption = 'LargeChange:'
  end
  object sePage: TSpinEdit
    Left = 80
    Top = 32
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
    OnChange = sePageChange
  end
  object seMin: TSpinEdit
    Left = 80
    Top = 64
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
    OnChange = sePageChange
  end
  object seMax: TSpinEdit
    Left = 80
    Top = 96
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 0
    OnChange = sePageChange
  end
  object sePos: TSpinEdit
    Left = 80
    Top = 128
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 0
    OnChange = sePageChange
  end
  object seSmallChange: TSpinEdit
    Left = 288
    Top = 32
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 0
    OnChange = sePageChange
  end
  object seLargeChange: TSpinEdit
    Left = 288
    Top = 64
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 5
    Value = 0
    OnChange = sePageChange
  end
end
