inherited ShowInfoDlg: TShowInfoDlg
  Left = 394
  Top = 227
  VertScrollBar.Range = 0
  AutoScroll = False
  Caption = #1057#1058#1040#1058#1048#1057#1058#1048#1050#1040' '#1055#1054#1048#1057#1050#1040
  ClientWidth = 441
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Width = 441
    inherited OK: TBitBtn
      Left = 167
    end
    inherited Cancel: TBitBtn
      Left = 258
    end
    inherited Help: TBitBtn
      Left = 348
    end
  end
  inherited Panel1: TPanel
    Width = 441
    object emInfo: TevMemo
      Left = 1
      Top = 1
      Width = 439
      Height = 216
      AutoSelect = False
      Align = alClient
      TabOrder = 0
      TabStop = True
    end
  end
end
