object Form1: TForm1
  Left = 192
  Top = 124
  Width = 1305
  Height = 750
  Caption = 'AsO'
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
  object Memo1: TMemo
    Left = 132
    Top = 36
    Width = 625
    Height = 561
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 28
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 32
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button8: TButton
    Left = 828
    Top = 196
    Width = 75
    Height = 25
    Action = Action1
    TabOrder = 3
  end
  object CheckBox1: TCheckBox
    Left = 796
    Top = 60
    Width = 97
    Height = 17
    Caption = 'Stress Mode'
    Checked = True
    State = cbChecked
    TabOrder = 4
    OnClick = CheckBox1Click
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
