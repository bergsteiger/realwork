object TOCItemEditDlg: TTOCItemEditDlg
  Left = 267
  Top = 137
  BorderStyle = bsDialog
  Caption = #1048#1089#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1086#1075#1083#1072#1074#1083#1077#1085#1080#1103
  ClientHeight = 134
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 4
    Top = 4
    Width = 92
    Height = 16
    Caption = #1058#1077#1082#1089#1090' '#1101#1083#1077#1084#1077#1085#1090#1072
  end
  object memoItemEdit: TMemo
    Left = 4
    Top = 24
    Width = 477
    Height = 65
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button1: TButton
    Left = 324
    Top = 100
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 408
    Top = 100
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
end
