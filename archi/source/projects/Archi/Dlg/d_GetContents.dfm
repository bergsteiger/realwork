inherited ContentsEditDlg: TContentsEditDlg
  Left = 550
  Top = 451
  Width = 354
  Height = 194
  ActiveControl = edtValue6
  Caption = #1054#1075#1083#1072#1074#1083#1077#1085#1080#1077
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 113
    Width = 338
    inherited OK: TBitBtn
      Left = 68
    end
    inherited Cancel: TBitBtn
      Left = 156
    end
    inherited Help: TBitBtn
      Left = 244
    end
  end
  inherited Panel1: TPanel
    Width = 338
    Height = 113
    object lblText: TLabel
      Left = 16
      Top = 26
      Width = 159
      Height = 16
      AutoSize = False
      Caption = #1059#1088#1086#1074#1077#1085#1100' '#1074#1083#1086#1078#1077#1085#1085#1086#1089#1090#1080
    end
    object Label1: TLabel
      Left = 16
      Top = 58
      Width = 217
      Height = 39
      AutoSize = False
      Caption = #1059#1088#1086#1074#1077#1085#1100' '#1074#1083#1086#1078#1077#1085#1085#1086#1089#1090#1080' '#1073#1083#1086#1082#1086#1074', '#1091#1095#1072#1089#1090#1074#1091#1102#1097#1080#1093' '#1074' '#1089#1088#1072#1074#1085#1077#1085#1080#1080
      WordWrap = True
    end
    object edtValue6: TvtSpinEdit
      Left = 226
      Top = 22
      Width = 87
      Height = 24
      MinValue = -1.000000000000000000
      UseMaxValue = False
      EmptyValue = -1.000000000000000000
      Value = 2.000000000000000000
      TabOrder = 0
    end
    object edtCompareContentsLevel: TvtSpinEdit
      Left = 226
      Top = 60
      Width = 87
      Height = 24
      MinValue = -1.000000000000000000
      UseMaxValue = False
      EmptyValue = -1.000000000000000000
      Value = 2.000000000000000000
      TabOrder = 1
    end
  end
end
