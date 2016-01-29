object MyEntityForm: TMyEntityForm
  Left = 1793
  Top = 157
  Width = 582
  Height = 243
  Caption = 'MyEntityForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 437
    Height = 133
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 464
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
  end
  object Entities: TvcmEntities
    Entities = <
      item
        Name = 'Form1'
      end>
    Left = 472
    Top = 68
  end
end
