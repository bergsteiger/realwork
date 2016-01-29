inherited DateIntervalDlg: TDateIntervalDlg
  Left = 410
  Top = 336
  VertScrollBar.Range = 0
  AutoScroll = False
  Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1076#1072#1090
  ClientHeight = 148
  ClientWidth = 333
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 103
    Width = 333
    inherited OK: TBitBtn
      Left = 59
    end
    inherited Cancel: TBitBtn
      Left = 150
    end
    inherited Help: TBitBtn
      Left = 240
    end
  end
  inherited Panel1: TPanel
    Width = 333
    Height = 103
    object Label1: TStaticText
      Left = 10
      Top = 45
      Width = 18
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1089
      TabOrder = 2
    end
    object Label2: TStaticText
      Left = 168
      Top = 45
      Width = 20
      Height = 20
      Caption = #1087#1086
      TabOrder = 3
    end
    object edtDateLow: TvtDateEdit
      Left = 35
      Top = 40
      Width = 121
      Height = 24
      ParentFont = True
      Style = csDropDown
      TabOrder = 0
    end
    object edtDateHigh: TvtDateEdit
      Left = 192
      Top = 40
      Width = 121
      Height = 24
      ParentFont = True
      Style = csDropDown
      TabOrder = 1
    end
  end
end
