object fmMain: TfmMain
  Left = 2
  Top = 114
  Width = 483
  Height = 261
  Caption = 'fmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 288
    Top = 136
    Width = 23
    Height = 13
    Caption = 'Date'
  end
  object Label2: TLabel
    Left = 288
    Top = 160
    Width = 23
    Height = 13
    Caption = 'Time'
  end
  object Label3: TLabel
    Left = 288
    Top = 184
    Width = 28
    Height = 13
    Caption = 'Offset'
  end
  object Label4: TLabel
    Left = 288
    Top = 208
    Width = 30
    Height = 13
    Caption = 'Period'
  end
  object Label5: TLabel
    Left = 456
    Top = 184
    Width = 13
    Height = 13
    Caption = 'ms'
  end
  object Label6: TLabel
    Left = 456
    Top = 208
    Width = 13
    Height = 13
    Caption = 'ms'
  end
  object edAddr: TEdit
    Left = 7
    Top = 9
    Width = 266
    Height = 21
    TabOrder = 0
    Text = '-ORBBindAddr inet:localhost:10000'
  end
  object btStart: TButton
    Left = 280
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = btStartClick
  end
  object mEvent: TMemo
    Left = 8
    Top = 40
    Width = 265
    Height = 185
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object btRegister: TButton
    Left = 280
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Register'
    TabOrder = 3
    OnClick = btRegisterClick
  end
  object rgTimeType: TRadioGroup
    Left = 368
    Top = 8
    Width = 97
    Height = 105
    Caption = 'Time type'
    ItemIndex = 0
    Items.Strings = (
      'Absolute'
      'Relative'
      'Periodic')
    TabOrder = 4
    OnClick = rgTimeTypeClick
  end
  object meDate: TMaskEdit
    Left = 368
    Top = 128
    Width = 97
    Height = 21
    EditMask = '!99/99/00;1;_'
    MaxLength = 8
    TabOrder = 5
    Text = '  .  .  '
  end
  object meTime: TMaskEdit
    Left = 368
    Top = 152
    Width = 97
    Height = 21
    EditMask = '!90:00;1;_'
    MaxLength = 5
    TabOrder = 6
    Text = '  :  '
  end
  object edOffset: TEdit
    Left = 368
    Top = 176
    Width = 81
    Height = 21
    Enabled = False
    TabOrder = 7
  end
  object edPeriod: TEdit
    Left = 368
    Top = 200
    Width = 81
    Height = 21
    Enabled = False
    TabOrder = 8
  end
end
