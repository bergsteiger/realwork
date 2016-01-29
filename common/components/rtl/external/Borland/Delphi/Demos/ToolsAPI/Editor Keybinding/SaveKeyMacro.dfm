object SaveKeyMacroDlg: TSaveKeyMacroDlg
  Left = 282
  Top = 155
  AutoScroll = False
  Caption = 'Save Key Macro'
  ClientHeight = 87
  ClientWidth = 401
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
    Top = 8
    Width = 203
    Height = 13
    Caption = '&Save key macro (Cancel to use as default):'
    FocusControl = Button3
  end
  object Edit1: TEdit
    Left = 8
    Top = 24
    Width = 361
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 376
    Top = 24
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 240
    Top = 56
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object Button3: TButton
    Left = 320
    Top = 56
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Borland Key Macros (*.bkm)|*.bkm|Any File (*.*)|*.*'
    Title = 'Save Key Macro'
    Left = 8
    Top = 56
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Borland Key Macros (*.bkm)|*.bkm|Any File (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Load Key Macro'
    Left = 40
    Top = 56
  end
end
