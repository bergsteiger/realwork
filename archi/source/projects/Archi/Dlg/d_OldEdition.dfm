inherited OldEditionDlg: TOldEditionDlg
  Left = 414
  Top = 378
  VertScrollBar.Range = 0
  ActiveControl = edtDocID
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1094#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
  ClientHeight = 169
  ClientWidth = 282
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 124
    Width = 282
    inherited OK: TBitBtn
      Left = 8
      OnClick = OKClick
    end
    inherited Cancel: TBitBtn
      Left = 99
    end
    inherited Help: TBitBtn
      Left = 189
    end
  end
  inherited Panel1: TPanel
    Width = 282
    Height = 124
    object Label1: TLabel
      Left = 10
      Top = 21
      Width = 79
      Height = 16
      Caption = 'ID '#1088#1077#1076#1072#1082#1094#1080#1080
    end
    object edtDocID: TvtSpinEdit
      Left = 103
      Top = 17
      Width = 121
      Height = 24
      UseMaxValue = False
      TabOrder = 0
    end
    object rgEditionKind: TRadioGroup
      Left = 7
      Top = 48
      Width = 267
      Height = 64
      ItemIndex = 0
      Items.Strings = (
        #1057#1090#1072#1088#1072#1103' '#1088#1077#1076#1072#1082#1094#1080#1103
        #1041#1091#1076#1091#1097#1072#1103' '#1088#1077#1076#1072#1082#1094#1080#1103)
      TabOrder = 1
    end
  end
end
