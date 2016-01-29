inherited AttrAlarmDlg: TAttrAlarmDlg
  Left = 463
  Top = 320
  VertScrollBar.Range = 0
  BorderStyle = bsDialog
  Caption = #1047#1074#1086#1085#1086#1082'-'#1085#1072#1087#1086#1084#1080#1085#1072#1085#1080#1077
  ClientHeight = 152
  ClientWidth = 506
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 107
    Width = 506
    inherited OK: TBitBtn
      Left = 232
    end
    inherited Cancel: TBitBtn
      Left = 323
    end
    inherited Help: TBitBtn
      Left = 413
    end
  end
  inherited Panel1: TPanel
    Width = 506
    Height = 107
    object Label1: TLabel
      Left = 38
      Top = 24
      Width = 53
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1044#1072#1090#1072
      FocusControl = edtDate
    end
    object Label2: TLabel
      Left = 7
      Top = 66
      Width = 85
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077
      FocusControl = edtComment
    end
    object edtDate: TvtDateEdit
      Left = 101
      Top = 20
      Width = 121
      Height = 24
      Style = csDropDown
      TabOrder = 0
    end
    object edtComment: TvtSimpleComboEdit
      Left = 102
      Top = 62
      Width = 395
      Height = 24
      ButtonStyle = cbsEllipsis
      Style = csDropDown
      TabOrder = 1
      OnDropDown = edtCommentDropDown
    end
  end
end
