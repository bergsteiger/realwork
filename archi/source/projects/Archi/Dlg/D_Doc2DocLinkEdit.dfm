inherited Doc2DocLinkEditDlg: TDoc2DocLinkEditDlg
  Left = 587
  Top = 339
  Caption = #1057#1074#1103#1079#1100' '#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1084
  ClientHeight = 119
  ClientWidth = 259
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  inherited Label1: TLabel
    Left = 20
    Top = 59
  end
  object Label2: TLabel [1]
    Left = 11
    Top = 29
    Width = 66
    Height = 16
    Alignment = taRightJustify
    Caption = #1058#1080#1087' '#1089#1074#1103#1079#1080
  end
  inherited OKBtn: TBitBtn
    Left = 6
    Top = 87
  end
  inherited CancelBtn: TBitBtn
    Left = 92
    Top = 87
  end
  inherited HelpBtn: TBitBtn
    Left = 176
    Top = 87
  end
  inherited chkRenum: TCheckBox
    Left = 82
    Top = 3
    Visible = False
  end
  inherited edNumber: TComboBox
    Top = 54
  end
  object cbLinkType: TComboBox [7]
    Left = 96
    Top = 24
    Width = 153
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 5
    Text = #1076#1086#1082#1091#1084#1077#1085#1090' '#1080#1079#1084#1077#1085#1077#1085
    Items.Strings = (
      #1076#1086#1082#1091#1084#1077#1085#1090' '#1080#1079#1084#1077#1085#1077#1085
      #1076#1086#1082#1091#1084#1077#1085#1090' '#1091#1090#1088#1072#1090#1080#1083' '#1089#1080#1083#1091)
  end
  inherited ActionList1: TActionList
    Left = 9
    Top = 2
  end
end
