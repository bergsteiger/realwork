inherited LogRequestDlg: TLogRequestDlg
  ActiveControl = edtDateLow
  BorderStyle = bsDialog
  Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1080#1079#1084#1077#1085#1080#1074#1096#1080#1084#1089#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1084
  ClientHeight = 191
  ClientWidth = 385
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 146
    Width = 385
    BevelOuter = bvSpace
    inherited OK: TBitBtn
      Left = 111
    end
    inherited Cancel: TBitBtn
      Left = 202
    end
    inherited Help: TBitBtn
      Left = 292
    end
  end
  inherited Panel1: TPanel
    Width = 385
    Height = 146
    object Label3: TLabel [0]
      Left = 14
      Top = 90
      Width = 183
      Height = 16
      Caption = #1060#1072#1081#1083' '#1089' '#1086#1090#1095#1077#1090#1086#1084
    end
    object GroupBox1: TGroupBox [1]
      Left = 6
      Top = 9
      Width = 368
      Height = 66
      Anchors = [akLeft, akTop, akBottom]
      Caption = ' '#1044#1080#1072#1087#1072#1079#1086#1085' '#1076#1072#1090' '
      TabOrder = 4
    end
    inherited edtDateLow: TvtDateEdit [2]
      Left = 57
      Top = 38
    end
    inherited edtDateHigh: TvtDateEdit [3]
      Left = 214
      Top = 38
    end
    inherited Label1: TStaticText [4]
      Left = 32
      Top = 43
    end
    inherited Label2: TStaticText [5]
      Left = 190
      Top = 43
    end
    object edtFilename: TFilenameEdit
      Left = 7
      Top = 110
      Width = 370
      Height = 21
      NumGlyphs = 1
      TabOrder = 5
    end
  end
end
