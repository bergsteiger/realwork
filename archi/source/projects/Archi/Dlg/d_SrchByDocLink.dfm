inherited SearchByDocLinkDlg: TSearchByDocLinkDlg
  Left = 510
  Top = 378
  VertScrollBar.Range = 0
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1089#1074#1103#1079#1103#1084' '#1084#1077#1078#1076#1091' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1084#1080
  ClientHeight = 195
  ClientWidth = 367
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 150
    Width = 367
    inherited OK: TBitBtn
      Left = 91
    end
    inherited Cancel: TBitBtn
      Left = 183
    end
    inherited Help: TBitBtn
      Left = 275
    end
  end
  inherited Panel1: TPanel
    Width = 367
    Height = 150
    object Label1: TLabel
      Left = 8
      Top = 96
      Width = 66
      Height = 16
      Caption = #1058#1080#1087' '#1089#1074#1103#1079#1080
      FocusControl = cbLinkType
    end
    object rgSearchType: TRadioGroup
      Left = 8
      Top = 8
      Width = 353
      Height = 73
      Caption = ' '#1048#1097#1077#1084' '#1076#1086#1082#1091#1084#1077#1085#1090#1099', '
      ItemIndex = 0
      Items.Strings = (
        #1082#1086#1090#1086#1088#1099#1077' '#1080#1079#1084#1077#1085#1103#1102#1090' '#1076#1088#1091#1075#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
        #1080#1079#1084#1077#1085#1103#1077#1084#1099#1077' '#1076#1088#1091#1075#1080#1084#1080' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1084#1080)
      TabOrder = 0
    end
    object cbLinkType: TComboBox
      Left = 8
      Top = 112
      Width = 353
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      ItemIndex = 0
      TabOrder = 1
      Text = '<'#1083#1102#1073#1086#1081'>'
      Items.Strings = (
        '<'#1083#1102#1073#1086#1081'>'
        #1057#1074#1103#1079#1072#1085#1085#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' '#1080#1079#1084#1077#1085#1077#1085
        #1057#1074#1103#1079#1072#1085#1085#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' '#1091#1090#1088#1072#1090#1080#1083' '#1089#1080#1083#1091)
    end
  end
end
