object MainClientForm: TMainClientForm
  Left = 298
  Top = 338
  Width = 521
  Height = 370
  Caption = 'Client'
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
  object lbState: TLabel
    Left = 186
    Top = 20
    Width = 59
    Height = 13
    Caption = 'CurrentState'
  end
  object btConnect: TButton
    Left = 44
    Top = 92
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = btConnectClick
  end
  object btDisconnect: TButton
    Left = 44
    Top = 132
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 1
    OnClick = btDisconnectClick
  end
  object btQuery: TButton
    Left = 174
    Top = 110
    Width = 75
    Height = 25
    Caption = 'Query'
    TabOrder = 2
    OnClick = btQueryClick
  end
end
