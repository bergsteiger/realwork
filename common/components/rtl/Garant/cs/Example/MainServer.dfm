object MainServerForm: TMainServerForm
  Left = 477
  Top = 431
  Width = 467
  Height = 342
  Caption = 'Server'
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
  object lbInfo: TLabel
    Left = 76
    Top = 26
    Width = 18
    Height = 13
    Caption = 'Info'
  end
  object btBroadcast: TButton
    Left = 60
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Broadcast'
    TabOrder = 0
    OnClick = btBroadcastClick
  end
end
