inherited FindAlarmDlg: TFindAlarmDlg
  Left = 463
  Top = 320
  Caption = #1055#1086#1080#1089#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1089' '#1085#1072#1087#1086#1084#1080#1085#1072#1085#1080#1103#1084#1080
  ClientHeight = 186
  ClientWidth = 357
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 141
    Width = 357
    inherited OK: TBitBtn
      Left = 83
    end
    inherited Cancel: TBitBtn
      Left = 174
    end
    inherited Help: TBitBtn
      Left = 264
    end
  end
  inherited Panel1: TPanel
    Width = 357
    Height = 141
    object vtLabel1: TvtLabel [0]
      Left = 10
      Top = 85
      Width = 121
      Height = 16
      AutoSize = False
      Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077
      ParentFont = True
    end
    inherited GroupBox1: TGroupBox
      Width = 340
    end
    object cbMessageText: TvtComboBox
      Left = 9
      Top = 106
      Width = 340
      Height = 24
      ItemHeight = 16
      TabOrder = 1
    end
  end
end
