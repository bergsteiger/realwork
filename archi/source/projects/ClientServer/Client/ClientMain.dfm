object Form2: TForm2
  Left = 192
  Top = 124
  Width = 1305
  Height = 750
  Caption = 'Make'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 36
    Top = 28
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 40
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 32
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 32
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Memo1: TMemo
    Left = 132
    Top = 36
    Width = 625
    Height = 561
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
  end
  object Button5: TButton
    Left = 784
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 788
    Top = 76
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 6
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 788
    Top = 132
    Width = 75
    Height = 25
    Caption = 'Send login'
    TabOrder = 7
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 828
    Top = 196
    Width = 75
    Height = 25
    Action = Action1
    TabOrder = 8
  end
  object Button9: TButton
    Left = 784
    Top = 300
    Width = 75
    Height = 25
    Caption = 'Stress'
    TabOrder = 9
    OnClick = Button9Click
  end
  object Edit1: TEdit
    Left = 784
    Top = 268
    Width = 121
    Height = 21
    TabOrder = 10
    Text = '10'
  end
  object ActionList1: TActionList
    Left = 872
    Top = 316
    object Action1: TAction
      Caption = 'Action1'
      OnExecute = Action1Execute
      OnUpdate = Action1Update
    end
  end
end
