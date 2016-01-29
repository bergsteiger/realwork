object ChangePasswordDlg: TChangePasswordDlg
  Left = 360
  Top = 303
  BorderStyle = bsDialog
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1072#1088#1086#1083#1103
  ClientHeight = 146
  ClientWidth = 244
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object edPassword: TLabeledEdit
    Left = 8
    Top = 24
    Width = 225
    Height = 21
    EditLabel.Width = 38
    EditLabel.Height = 13
    EditLabel.Caption = #1055#1072#1088#1086#1083#1100
    PasswordChar = '*'
    TabOrder = 0
  end
  object edPasswordConfirm: TLabeledEdit
    Left = 8
    Top = 69
    Width = 225
    Height = 21
    EditLabel.Width = 76
    EditLabel.Height = 13
    EditLabel.Caption = #1055#1086#1074#1090#1086#1088' '#1087#1072#1088#1086#1083#1103
    PasswordChar = '*'
    TabOrder = 1
  end
  object Button1: TButton
    Left = 80
    Top = 112
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 160
    Top = 112
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
end
