inherited AttrCopyEditDlg: TAttrCopyEditDlg
  Left = 536
  Top = 279
  VertScrollBar.Range = 0
  BorderStyle = bsDialog
  ClientHeight = 149
  ClientWidth = 304
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 104
    Width = 304
    inherited OK: TBitBtn
      Left = 34
    end
    inherited Cancel: TBitBtn
      Left = 122
    end
    inherited Help: TBitBtn
      Left = 210
    end
  end
  inherited Panel1: TPanel
    Width = 304
    Height = 104
    object Label1: TLabel
      Left = 10
      Top = 26
      Width = 138
      Height = 16
      AutoSize = False
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090'-'#1080#1089#1090#1086#1095#1085#1080#1082
    end
    object Label2: TLabel
      Left = 11
      Top = 66
      Width = 141
      Height = 16
      AutoSize = False
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090'-'#1087#1088#1080#1077#1084#1085#1080#1082
    end
    object edtDonorDocID: TvtSpinEdit
      Left = 157
      Top = 23
      Width = 133
      Height = 24
      UseMaxValue = False
      TabOrder = 0
    end
    object edtAcceptorDocID: TvtSpinEdit
      Left = 158
      Top = 60
      Width = 133
      Height = 24
      UseMaxValue = False
      UseMinValue = False
      TabOrder = 1
    end
  end
end
