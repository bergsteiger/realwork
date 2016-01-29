inherited DateEditDlg: TDateEditDlg
  Left = 477
  Top = 330
  Caption = ''
  ClientHeight = 111
  ClientWidth = 332
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 66
    Width = 332
    inherited OK: TBitBtn
      Left = 60
    end
    inherited Cancel: TBitBtn
      Left = 150
    end
    inherited Help: TBitBtn
      Left = 240
    end
  end
  inherited Panel1: TPanel
    Width = 332
    Height = 66
    object lblText: TvtBoundedLabel
      Left = 81
      Top = 26
      Width = 32
      Height = 16
      BoundedControl = edtDate
      Caption = #1044#1072#1090#1072
    end
    object edtDate: TvtDateEdit
      Left = 118
      Top = 22
      Width = 109
      Height = 24
      ButtonStyle = cbsDefault
      ImageIndex = 0
      ReadOnly = False
      Style = csDropDown
      TabOrder = 0
    end
  end
end
