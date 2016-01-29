object Form1: TForm1
  Left = 195
  Top = 221
  Width = 681
  Height = 341
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 40
    Top = 96
    Width = 185
    Height = 25
    Caption = 'Set Menu Background Color'
    TabOrder = 0
    OnClick = Button1Click
  end
  object MainMenu1: TMainMenu
    Left = 100
    Top = 44
    object Menu11: TMenuItem
      Caption = 'Menu1'
      object Item11: TMenuItem
        Caption = 'Item1'
      end
      object Item21: TMenuItem
        Caption = 'Item2'
      end
      object Item31: TMenuItem
        Caption = 'Item3'
      end
    end
    object Menu21: TMenuItem
      Caption = 'Menu2'
      object Item12: TMenuItem
        Caption = 'Item1'
      end
      object Item22: TMenuItem
        Caption = 'Item2'
      end
    end
  end
end
