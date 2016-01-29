object frmPassword: TfrmPassword
  Left = 409
  Top = 292
  BorderStyle = bsDialog
  Caption = 'Enter Password'
  ClientHeight = 122
  ClientWidth = 231
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
    Width = 193
    Height = 33
    AutoSize = False
    Caption = 'This is a Password protected file. Please enter the password:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 231
    Height = 122
  end
  object edtpassword: TEdit
    Left = 9
    Top = 56
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
  object Button1: TButton
    Left = 73
    Top = 92
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 150
    Top = 92
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = Button2Click
  end
end
