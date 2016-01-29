object RangeEditDlg: TRangeEditDlg
  Left = 468
  Top = 406
  BorderStyle = bsDialog
  Caption = #1048#1085#1090#1077#1088#1074#1072#1083
  ClientHeight = 100
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 159
    Height = 13
    Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1085#1086#1084#1077#1088#1086#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
  end
  object Label2: TLabel
    Left = 16
    Top = 27
    Width = 11
    Height = 13
    Caption = #1086#1090
  end
  object Label3: TLabel
    Left = 168
    Top = 27
    Width = 12
    Height = 13
    Caption = #1076#1086
  end
  object edFrom: TEdit
    Left = 32
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
    OnChange = edFromChange
  end
  object edTo: TEdit
    Left = 184
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 1
    OnChange = edFromChange
  end
  object btnOK: TButton
    Left = 144
    Top = 64
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 230
    Top = 64
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
end
