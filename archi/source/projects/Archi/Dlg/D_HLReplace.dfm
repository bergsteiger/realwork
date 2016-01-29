inherited HLReplaceDlg: THLReplaceDlg
  Caption = #1047#1072#1084#1077#1085#1080#1090#1100' '#1074' '#1089#1089#1099#1083#1082#1072#1093
  ClientHeight = 141
  ClientWidth = 332
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 96
    Width = 332
    inherited OK: TBitBtn
      Left = 62
    end
    inherited Cancel: TBitBtn
      Left = 150
    end
    inherited Help: TBitBtn
      Left = 238
    end
  end
  inherited Panel1: TPanel
    Width = 332
    Height = 96
    object lblText: TLabel
      Left = 5
      Top = 59
      Width = 174
      Height = 16
      Alignment = taRightJustify
      Caption = #1053#1086#1074#1099#1081' '#1085#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object lblOldDoc: TLabel
      Left = 4
      Top = 24
      Width = 173
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = #1053#1086#1084#1077#1088'  '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      ParentBiDiMode = False
    end
    object edtOldDoc: TvtSpinEdit
      Left = 188
      Top = 19
      Width = 132
      Height = 24
      UseMaxValue = False
      TabOrder = 0
    end
    object edtNewDoc: TvtSpinEdit
      Left = 188
      Top = 56
      Width = 132
      Height = 24
      UseMaxValue = False
      UseMinValue = False
      TabOrder = 1
    end
  end
end
