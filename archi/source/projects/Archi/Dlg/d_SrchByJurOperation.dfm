inherited SrchByJurOperationDlg: TSrchByJurOperationDlg
  Left = 665
  Top = 235
  ClientHeight = 389
  ClientWidth = 417
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 344
    Width = 417
    inherited OK: TBitBtn
      Left = 143
    end
    inherited Cancel: TBitBtn
      Left = 234
    end
    inherited Help: TBitBtn
      Left = 324
    end
  end
  inherited Panel1: TPanel
    Width = 417
    Height = 344
    object lblJurOperation: TLabel [0]
      Left = 8
      Top = 136
      Width = 66
      Height = 16
      Caption = #1054#1087#1077#1088#1072#1094#1080#1080
    end
    object Label6: TLabel [1]
      Left = 6
      Top = 82
      Width = 91
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1056#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082
    end
    inherited GroupBox1: TGroupBox
      Width = 396
    end
    object lstJurOperation: TvtDStringLister
      Left = 9
      Top = 181
      Width = 398
      Height = 155
      Sorted = False
      AutoRowHeight = False
      IntegralHeight = False
      MultiSelect = True
      ProtectColor.BackColor = clRed
      ProtectColor.TextColor = clWhite
      SelectColor.BackColor = clHighlight
      SelectColor.TextColor = clHighlightText
      SelectNonFocusColor.BackColor = clBtnFace
      SelectNonFocusColor.TextColor = clBtnText
      PickedList = True
      Font.Charset = DEFAULT_CHARSET
      ParentColor = False
      TabOrder = 2
      TabStop = True
    end
    object cbUser: TComboBox
      Left = 10
      Top = 103
      Width = 395
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      TabOrder = 1
    end
    object cbxJurOp: TCheckBox
      Left = 10
      Top = 156
      Width = 139
      Height = 17
      Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1077
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = cbxJurOpClick
    end
    object cbxSysOp: TCheckBox
      Left = 133
      Top = 156
      Width = 131
      Height = 17
      Caption = #1057#1080#1089#1090#1077#1084#1085#1099#1077
      TabOrder = 4
      OnClick = cbxSysOpClick
    end
  end
end
