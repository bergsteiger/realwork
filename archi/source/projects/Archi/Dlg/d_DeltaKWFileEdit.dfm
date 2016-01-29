inherited DeltaKWFileEditDlg: TDeltaKWFileEditDlg
  Left = 484
  Top = 252
  VertScrollBar.Range = 0
  AutoScroll = False
  Caption = #1060#1072#1081#1083#1099' '#1076#1077#1083#1100#1090#1099' '
  ClientHeight = 170
  ClientWidth = 331
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 125
    Width = 331
    inherited OK: TBitBtn
      Left = 61
    end
    inherited Cancel: TBitBtn
      Left = 149
    end
    inherited Help: TBitBtn
      Left = 237
    end
  end
  inherited Panel1: TPanel
    Width = 331
    Height = 125
    object lblText: TLabel
      Left = 8
      Top = 8
      Width = 111
      Height = 16
      Caption = #1060#1072#1081#1083' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
    end
    object Label1: TLabel
      Left = 8
      Top = 56
      Width = 102
      Height = 16
      Caption = #1060#1072#1081#1083' '#1091#1076#1072#1083#1077#1085#1080#1081
    end
    object edtDeltaFileName: TFilenameEdit
      Left = 9
      Top = 29
      Width = 312
      Height = 21
      Filter = #1060#1072#1081#1083' '#1082#1083#1102#1095#1077#1074#1099#1093' '#1089#1083#1086#1074' (*.kw)|*.kw|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
      NumGlyphs = 1
      TabOrder = 0
    end
    object edtKillFileName: TFilenameEdit
      Left = 9
      Top = 77
      Width = 312
      Height = 21
      Filter = #1060#1072#1081#1083' '#1082#1083#1102#1095#1077#1074#1099#1093' '#1089#1083#1086#1074' (*.kw)|*.kw|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
      DialogOptions = [ofHideReadOnly, ofFileMustExist]
      NumGlyphs = 1
      TabOrder = 1
    end
  end
end
