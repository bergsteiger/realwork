object en_Difference: Ten_Difference
  Left = 20
  Top = 158
  Width = 928
  Height = 465
  Caption = 'en_Difference'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 12
    Top = 92
    Width = 69
    Height = 16
    Caption = 'Original text'
  end
  object Label2: TLabel
    Left = 12
    Top = 236
    Width = 50
    Height = 16
    Caption = 'New text'
  end
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 897
    Height = 73
    Alignment = taCenter
    AutoSize = False
    Caption = 'Label3'
    WordWrap = True
  end
  object Label4: TLabel
    Left = 468
    Top = 92
    Width = 69
    Height = 16
    Caption = 'Original text'
  end
  object Label5: TLabel
    Left = 468
    Top = 236
    Width = 50
    Height = 16
    Caption = 'New text'
  end
  object Memo1: TMemo
    Left = 8
    Top = 116
    Width = 445
    Height = 121
    Lines.Strings = (
      'Memo1')
    ReadOnly = True
    TabOrder = 0
    WantReturns = False
  end
  object Memo2: TMemo
    Left = 8
    Top = 256
    Width = 445
    Height = 121
    Lines.Strings = (
      'Memo2')
    ReadOnly = True
    TabOrder = 1
    WantReturns = False
  end
  object SameBtn: TButton
    Left = 368
    Top = 388
    Width = 75
    Height = 25
    Caption = 'Same text'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object DifferentBtn: TButton
    Left = 508
    Top = 388
    Width = 117
    Height = 25
    Cancel = True
    Caption = 'Different text'
    ModalResult = 2
    TabOrder = 3
  end
  object Memo3: TMemo
    Left = 464
    Top = 116
    Width = 445
    Height = 121
    Lines.Strings = (
      'Memo1')
    ReadOnly = True
    TabOrder = 4
    WantReturns = False
  end
  object Memo4: TMemo
    Left = 464
    Top = 256
    Width = 445
    Height = 121
    Lines.Strings = (
      'Memo2')
    TabOrder = 5
    OnKeyDown = Memo4KeyDown
    OnKeyPress = Memo4KeyPress
    OnKeyUp = Memo4KeyUp
  end
end
