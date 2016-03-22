object Form3: TForm3
  Left = 192
  Top = 124
  Width = 735
  Height = 586
  Caption = 'Form3'
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
  object Label1: TLabel
    Left = 22
    Top = 10
    Width = 49
    Height = 13
    Caption = 'Processes'
  end
  object Label2: TLabel
    Left = 317
    Top = 9
    Width = 46
    Height = 13
    Caption = 'Out folder'
  end
  object SpeedButton1: TSpeedButton
    Left = 693
    Top = 27
    Width = 23
    Height = 22
    Caption = '...'
    OnClick = SpeedButton1Click
  end
  object Label3: TLabel
    Left = 319
    Top = 52
    Width = 18
    Height = 13
    Caption = 'Log'
  end
  object ProcessListBox: TListBox
    Left = 15
    Top = 28
    Width = 292
    Height = 444
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 18
    Top = 510
    Width = 288
    Height = 25
    Caption = 'Make dump'
    TabOrder = 1
    OnClick = Button1Click
  end
  object OutDir: TEdit
    Left = 317
    Top = 30
    Width = 372
    Height = 21
    TabOrder = 2
  end
  object LogMemo: TMemo
    Left = 316
    Top = 66
    Width = 396
    Height = 468
    ReadOnly = True
    TabOrder = 3
  end
  object SuspendCheck: TCheckBox
    Left = 20
    Top = 477
    Width = 284
    Height = 17
    Caption = 'Suspend threads'
    TabOrder = 4
  end
  object WriteCheck: TCheckBox
    Left = 20
    Top = 494
    Width = 286
    Height = 17
    Caption = 'Write dump'
    TabOrder = 5
  end
end
