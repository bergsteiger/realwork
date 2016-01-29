inherited DirEditDlg: TDirEditDlg
  Left = 484
  Top = 252
  VertScrollBar.Range = 0
  AutoScroll = False
  ClientHeight = 130
  ClientWidth = 338
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 85
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
    Height = 85
    object lblText: TLabel
      Left = 24
      Top = 16
      Width = 3
      Height = 16
    end
    object edtFilename: TDirectoryEdit
      Left = 9
      Top = 53
      Width = 321
      Height = 21
      NumGlyphs = 1
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
end
