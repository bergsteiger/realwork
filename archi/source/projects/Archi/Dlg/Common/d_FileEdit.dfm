inherited FileEditDlg: TFileEditDlg
  Left = 484
  Top = 252
  Caption = ''
  ClientHeight = 130
  ClientWidth = 278
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 85
    Width = 278
    inherited OK: TBitBtn
      Left = 8
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
    object edtFilename: TFilenameEdit
      Left = 9
      Top = 53
      Width = 260
      Height = 21
      NumGlyphs = 1
      TabOrder = 0
    end
  end
end
