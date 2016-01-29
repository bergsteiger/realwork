inherited StringEditDlg: TStringEditDlg
  Left = 477
  Top = 330
  VertScrollBar.Range = 0
  BorderStyle = bsDialog
  ClientHeight = 130
  ClientWidth = 410
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 85
    Width = 410
    inherited OK: TBitBtn
      Left = 140
    end
    inherited Cancel: TBitBtn
      Left = 228
    end
    inherited Help: TBitBtn
      Left = 316
    end
  end
  inherited Panel1: TPanel
    Width = 410
    Height = 85
    object lblText: TLabel
      Left = 24
      Top = 16
      Width = 3
      Height = 16
    end
    object edtValue: TEdit
      Left = 9
      Top = 49
      Width = 393
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
end
