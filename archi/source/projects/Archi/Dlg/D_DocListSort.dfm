inherited DocListSortDlg: TDocListSortDlg
  Left = 470
  Top = 298
  Width = 344
  Height = 368
  Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 285
    Width = 328
    inherited OK: TBitBtn
      Left = 54
    end
    inherited Cancel: TBitBtn
      Left = 145
    end
    inherited Help: TBitBtn
      Left = 235
    end
  end
  inherited Panel1: TPanel
    Width = 328
    Height = 285
    object rgSortField: TRadioGroup
      Left = 8
      Top = 8
      Width = 313
      Height = 145
      Caption = ' '#1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '
      Items.Strings = (
        #1073#1077#1079' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1080
        #1087#1086' '#1076#1072#1090#1077
        #1087#1086' '#1074#1072#1078#1085#1086#1089#1090#1080
        #1087#1086' '#1085#1072#1079#1074#1072#1085#1080#1102
        #1087#1086' '#1089#1088#1086#1095#1085#1086#1089#1090#1080)
      TabOrder = 0
      OnClick = rgSortFieldClick
    end
    object rgSortOrder: TRadioGroup
      Left = 8
      Top = 168
      Width = 313
      Height = 73
      Caption = ' '#1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' '
      Items.Strings = (
        #1087#1086' '#1074#1086#1079#1088#1072#1089#1090#1072#1085#1080#1102
        #1087#1086' '#1091#1073#1099#1074#1072#1085#1080#1102)
      TabOrder = 1
    end
    object cbSetAsDefault: TCheckBox
      Left = 8
      Top = 256
      Width = 313
      Height = 17
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100' '#1082#1072#1082' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1091' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      TabOrder = 2
    end
  end
end
