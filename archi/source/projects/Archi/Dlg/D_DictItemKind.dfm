inherited DictItemKindDlg: TDictItemKindDlg
  Left = 400
  Top = 333
  Caption = #1053#1086#1074#1099#1081' '#1101#1083#1077#1084#1077#1085#1090
  ClientHeight = 147
  ClientWidth = 289
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 102
    Width = 289
    inherited OK: TBitBtn
      Left = 15
    end
    inherited Cancel: TBitBtn
      Left = 106
    end
    inherited Help: TBitBtn
      Left = 196
    end
  end
  inherited Panel1: TPanel
    Width = 289
    Height = 102
    object RadioGroup1: TRadioGroup
      Left = 9
      Top = 11
      Width = 270
      Height = 80
      Caption = #1058#1080#1087' '#1101#1083#1077#1084#1077#1085#1090#1072
      ItemIndex = 0
      Items.Strings = (
        #1048#1079#1076#1072#1085#1080#1077
        #1053#1086#1084#1077#1088' '#1080#1079#1076#1072#1085#1080#1103)
      TabOrder = 0
    end
  end
end
