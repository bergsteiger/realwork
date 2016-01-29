inherited SearchSettingsDlg: TSearchSettingsDlg
  Left = 450
  Top = 289
  VertScrollBar.Range = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1086#1080#1089#1082#1072
  ClientHeight = 227
  ClientWidth = 324
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 182
    Width = 324
    inherited OK: TBitBtn
      Left = 47
    end
    inherited Cancel: TBitBtn
      Left = 138
    end
    inherited Help: TBitBtn
      Left = 228
    end
  end
  inherited Panel1: TPanel
    Width = 324
    Height = 182
    object rgLinkDate: TRadioGroup
      Left = 8
      Top = 16
      Width = 305
      Height = 73
      Caption = #1044#1072#1090#1072' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      ItemIndex = 0
      Items.Strings = (
        #1054#1076#1080#1085#1086#1095#1085#1072#1103' '#1076#1072#1090#1072
        #1044#1080#1072#1087#1072#1079#1086#1085' '#1076#1072#1090)
      TabOrder = 0
    end
    object rgDict: TRadioGroup
      Left = 8
      Top = 96
      Width = 305
      Height = 73
      Caption = #1060#1080#1083#1100#1090#1088#1072#1094#1080#1103' '#1087#1086' '#1089#1083#1086#1074#1072#1088#1102
      ItemIndex = 0
      Items.Strings = (
        #1043#1088#1091#1087#1087#1099' '#1076#1086#1089#1090#1091#1087#1072
        #1043#1088#1091#1087#1087#1099' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074)
      TabOrder = 1
    end
  end
end
