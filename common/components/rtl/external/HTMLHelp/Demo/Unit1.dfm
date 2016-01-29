object Form1: TForm1
  Left = 319
  Top = 250
  Width = 436
  Height = 128
  Caption = 'HTML Test'
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
  object CheckBox1: TCheckBox
    Left = 8
    Top = 8
    Width = 97
    Height = 17
    HelpContext = 2000
    Caption = 'View Page 1'
    TabOrder = 0
  end
  object CheckBox2: TCheckBox
    Left = 8
    Top = 24
    Width = 97
    Height = 17
    HelpContext = 3000
    Caption = 'View Page 2'
    TabOrder = 1
  end
  object CheckBox3: TCheckBox
    Left = 8
    Top = 40
    Width = 97
    Height = 17
    HelpContext = 4000
    Caption = 'View Page 3'
    TabOrder = 2
  end
  object Button1: TButton
    Left = 240
    Top = 8
    Width = 177
    Height = 25
    Caption = 'Show Table of contents'
    TabOrder = 3
    OnClick = Button1Click
  end
  object CheckBox4: TCheckBox
    Left = 8
    Top = 56
    Width = 97
    Height = 17
    HelpContext = 5000
    Caption = 'View Page 4'
    TabOrder = 4
  end
  object Button2: TButton
    Left = 241
    Top = 35
    Width = 177
    Height = 25
    Caption = 'Show Register'
    TabOrder = 5
    OnClick = Button2Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 82
    Width = 428
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object CheckBox5: TCheckBox
    Left = 104
    Top = 8
    Width = 130
    Height = 17
    HelpType = htKeyword
    HelpKeyword = 'Link'
    Caption = 'Key Word Link'
    TabOrder = 7
  end
  object CheckBox6: TCheckBox
    Left = 104
    Top = 24
    Width = 130
    Height = 17
    HelpType = htKeyword
    HelpKeyword = 'URL'
    Caption = 'Key Word URL'
    TabOrder = 8
  end
  object CheckBox7: TCheckBox
    Left = 104
    Top = 40
    Width = 130
    Height = 17
    HelpType = htKeyword
    HelpKeyword = 'Server'
    Caption = 'Key Word Server'
    TabOrder = 9
  end
  object CheckBox8: TCheckBox
    Left = 104
    Top = 56
    Width = 130
    Height = 17
    HelpType = htKeyword
    HelpKeyword = 'Application'
    Caption = 'Key Word Application'
    TabOrder = 10
  end
end
