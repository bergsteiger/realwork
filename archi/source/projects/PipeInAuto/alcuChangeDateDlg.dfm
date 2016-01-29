object alcuChangeDateDialog: TalcuChangeDateDialog
  Left = 267
  Top = 110
  BorderStyle = bsDialog
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1076#1072#1090#1099' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1079#1072#1076#1072#1085#1080#1103
  ClientHeight = 113
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  object lblTaskCaption: TLabel
    Left = 8
    Top = 8
    Width = 3
    Height = 14
  end
  object Label1: TLabel
    Left = 8
    Top = 32
    Width = 39
    Height = 14
    Caption = #1042#1084#1077#1089#1090#1086
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 57
    Height = 14
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
  end
  object dtFrom: TDateTimePicker
    Left = 208
    Top = 24
    Width = 105
    Height = 22
    Date = 37984.638840162040000000
    Time = 37984.638840162040000000
    TabOrder = 0
  end
  object dtTo: TDateTimePicker
    Left = 208
    Top = 48
    Width = 105
    Height = 22
    Date = 37984.639286331010000000
    Time = 37984.639286331010000000
    TabOrder = 1
  end
  object Button1: TButton
    Left = 160
    Top = 80
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 240
    Top = 80
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
end
