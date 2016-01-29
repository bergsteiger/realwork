inherited DocSetParamDlg: TDocSetParamDlg
  VertScrollBar.Range = 0
  BorderStyle = bsDialog
  Caption = #1057#1054#1061#1056#1040#1053#1048#1058#1068' '#1042#1067#1041#1054#1056#1050#1059' '#1044#1054#1050#1059#1052#1045#1053#1058#1054#1042
  ClientHeight = 172
  ClientWidth = 363
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 127
    Width = 363
    inherited OK: TBitBtn
      Left = 89
    end
    inherited Cancel: TBitBtn
      Left = 180
    end
    inherited Help: TBitBtn
      Left = 270
    end
  end
  inherited Panel1: TPanel
    Width = 363
    Height = 127
    object Label1: TLabel
      Left = 6
      Top = 11
      Width = 85
      Height = 16
      Caption = #1048#1084#1103' '#1074#1099#1073#1086#1088#1082#1080
    end
    object NameEdit: TEdit
      Left = 7
      Top = 32
      Width = 349
      Height = 24
      TabOrder = 0
    end
    object rgSaveMethod: TRadioGroup
      Left = 7
      Top = 65
      Width = 349
      Height = 53
      Caption = ' '#1052#1077#1090#1086#1076' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '
      ItemIndex = 0
      Items.Strings = (
        ' '#1082#1072#1082' '#1079#1072#1087#1088#1086#1089
        ' '#1082#1072#1082' '#1085#1072#1073#1086#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074)
      TabOrder = 1
    end
  end
end
