inherited ReplaceCorrespDlg: TReplaceCorrespDlg
  Left = 518
  ActiveControl = edtAddress
  ClientHeight = 196
  ClientWidth = 280
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 151
    Width = 280
    inherited OK: TBitBtn
      Left = 10
    end
    inherited Cancel: TBitBtn
      Left = 98
    end
    inherited Help: TBitBtn
      Left = 186
    end
  end
  inherited Panel1: TPanel
    Width = 280
    Height = 151
    inherited lblText: TLabel
      Left = 16
      Top = 86
      Width = 85
      Caption = #1053#1086#1074#1099#1081' '#1072#1076#1088#1077#1089
    end
    inherited edtAddress: TEdit
      Left = 16
      Top = 110
      Width = 249
      TabOrder = 3
    end
    object rbSelectedSubs: TRadioButton
      Left = 16
      Top = 16
      Width = 249
      Height = 17
      Caption = #1044#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1084#1077#1090#1086#1082
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbSelectedSubsClick
    end
    object rbOneSub: TRadioButton
      Left = 16
      Top = 48
      Width = 97
      Height = 17
      Caption = #1044#1083#1103' '#1084#1077#1090#1082#1080' '
      TabOrder = 1
      OnClick = rbOneSubClick
    end
    object edtSubNumber: TvtSpinEdit
      Left = 111
      Top = 45
      Width = 154
      Height = 24
      UseMaxValue = False
      UseMinValue = False
      Enabled = False
      TabOrder = 2
    end
  end
end
