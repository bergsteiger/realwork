object Form1: TForm1
  Left = 236
  Top = 97
  BorderStyle = bsDialog
  Caption = 'Calendar server'
  ClientHeight = 341
  ClientWidth = 308
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 5
    Width = 41
    Height = 13
    Caption = 'Address:'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 64
    Height = 13
    Caption = 'REF file path:'
  end
  object Addr: TEdit
    Left = 8
    Top = 18
    Width = 185
    Height = 21
    TabOrder = 0
    Text = 'inet:localhost:10000'
  end
  object RunBtn: TButton
    Left = 216
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Run'
    TabOrder = 1
    OnClick = RunBtnClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 104
    Width = 289
    Height = 233
    ReadOnly = True
    TabOrder = 2
  end
  object PathEdit: TEdit
    Left = 8
    Top = 64
    Width = 281
    Height = 21
    TabOrder = 3
    Text = 'd:\calendar.ref'
  end
end
