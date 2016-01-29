inherited AddressEditDlg: TAddressEditDlg
  VertScrollBar.Range = 0
  BorderStyle = bsDialog
  ClientHeight = 130
  ClientWidth = 278
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 85
    Width = 278
    DesignSize = (
      278
      45)
    inherited OK: TBitBtn
      Left = 8
      OnClick = OKClick
    end
    inherited Cancel: TBitBtn
      Left = 96
    end
    inherited Help: TBitBtn
      Left = 184
    end
  end
  inherited Panel1: TPanel
    Width = 278
    Height = 85
    object lblText: TLabel
      Left = 24
      Top = 16
      Width = 3
      Height = 16
    end
    object edtAddress: TEdit
      Left = 22
      Top = 48
      Width = 243
      Height = 24
      TabOrder = 0
    end
  end
end
