object EmailMessage: TEmailMessage
  Left = 405
  Top = 318
  BorderStyle = bsDialog
  Caption = #1053#1086#1074#1086#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
  ClientHeight = 233
  ClientWidth = 305
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
  object Label1: TLabel
    Left = 8
    Top = 88
    Width = 88
    Height = 14
    Caption = #1058#1077#1082#1089#1090' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 85
    Height = 14
    Caption = #1058#1077#1084#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
  end
  object editAddress: TLabeledEdit
    Left = 8
    Top = 24
    Width = 289
    Height = 22
    EditLabel.Width = 95
    EditLabel.Height = 14
    EditLabel.Caption = #1040#1076#1088#1077#1089' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1103
    TabOrder = 0
    OnChange = editAddressChange
  end
  object cbSubject: TComboBox
    Left = 8
    Top = 64
    Width = 289
    Height = 22
    AutoComplete = False
    ItemHeight = 14
    TabOrder = 1
    OnChange = editAddressChange
    OnSelect = cbSubjectSelect
  end
  object memoBody: TMemo
    Left = 8
    Top = 104
    Width = 289
    Height = 89
    TabOrder = 2
    OnChange = editAddressChange
  end
  object Button1: TButton
    Left = 144
    Top = 200
    Width = 75
    Height = 25
    Caption = #1054#1050
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 3
  end
  object Button2: TButton
    Left = 224
    Top = 200
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 4
  end
end
