inherited UrgencyEditDlg: TUrgencyEditDlg
  Left = 496
  Top = 333
  Caption = #1057#1088#1086#1095#1085#1086#1089#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
  ClientHeight = 160
  ClientWidth = 307
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 115
    Width = 307
    inherited OK: TBitBtn
      Left = 30
    end
    inherited Cancel: TBitBtn
      Left = 121
    end
    inherited Help: TBitBtn
      Left = 211
    end
  end
  inherited Panel1: TPanel
    Width = 307
    Height = 115
    object Label1: TLabel
      Left = 48
      Top = 32
      Width = 213
      Height = 16
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1089#1088#1086#1095#1085#1086#1089#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1072':'
    end
    object cbxUrgency: TComboBox
      Left = 48
      Top = 56
      Width = 217
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 0
    end
  end
end
