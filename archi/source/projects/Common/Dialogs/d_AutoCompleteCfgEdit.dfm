object ACEditDlg: TACEditDlg
  Left = 388
  Top = 244
  BorderStyle = bsDialog
  Caption = #1069#1083#1077#1084#1077#1085#1090' '#1072#1074#1090#1086#1079#1072#1084#1077#1085#1099
  ClientHeight = 177
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object vtBoundedLabel1: TvtBoundedLabel
    Left = 8
    Top = 3
    Width = 41
    Height = 16
    BoundedControl = edMacro
    Caption = #1048#1089#1082#1072#1090#1100
    Position = lpAbove
  end
  object vtBoundedLabel2: TvtBoundedLabel
    Left = 8
    Top = 59
    Width = 75
    Height = 16
    BoundedControl = edReplacement
    Caption = #1047#1072#1084#1077#1085#1080#1090#1100' '#1085#1072
    Position = lpAbove
  end
  object edMacro: TEdit
    Left = 8
    Top = 24
    Width = 353
    Height = 24
    TabOrder = 0
    OnChange = edMacroChange
  end
  object edReplacement: TEdit
    Left = 8
    Top = 80
    Width = 353
    Height = 24
    TabOrder = 1
    OnChange = edMacroChange
  end
  object cbRegexp: TCheckBox
    Left = 8
    Top = 120
    Width = 353
    Height = 17
    Caption = #1056#1077#1075#1091#1083#1103#1088#1085#1099#1077' '#1074#1099#1088#1072#1078#1077#1085#1080#1103
    TabOrder = 2
  end
  object btnOK: TButton
    Left = 208
    Top = 144
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 288
    Top = 144
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 4
  end
end
