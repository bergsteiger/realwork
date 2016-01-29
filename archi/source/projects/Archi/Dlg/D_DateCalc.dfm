inherited DateCalcDlg: TDateCalcDlg
  Left = 557
  Top = 390
  VertScrollBar.Range = 0
  ActiveControl = edtInitialDate
  BorderStyle = bsDialog
  Caption = #1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088' '#1076#1072#1090
  ClientHeight = 184
  ClientWidth = 593
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 139
    Width = 593
    inherited OK: TBitBtn
      Left = 319
    end
    inherited Cancel: TBitBtn
      Left = 410
    end
    inherited Help: TBitBtn
      Left = 500
    end
  end
  inherited Panel1: TPanel
    Width = 593
    Height = 139
    object Label3: TLabel
      Left = 14
      Top = 16
      Width = 197
      Height = 20
      AutoSize = False
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090', '#1086#1087#1091#1073#1083#1080#1082#1086#1074#1072#1085#1085#1099#1081
    end
    object Label4: TLabel
      Left = 14
      Top = 58
      Width = 157
      Height = 20
      AutoSize = False
      Caption = #1074#1089#1090#1091#1087#1072#1077#1090' '#1074' '#1089#1080#1083#1091' '#1095#1077#1088#1077#1079
    end
    object Label1: TLabel
      Left = 474
      Top = 58
      Width = 102
      Height = 16
      Caption = #1086#1087#1091#1073#1083#1080#1082#1086#1074#1072#1085#1080#1103
    end
    object Label5: TLabel
      Left = 14
      Top = 101
      Width = 295
      Height = 16
      Caption = #1069#1090#1086' '#1086#1079#1085#1072#1095#1072#1077#1090', '#1095#1090#1086' '#1076#1086#1082#1091#1084#1077#1085#1090' '#1074#1089#1090#1091#1087#1072#1077#1090' '#1074' '#1089#1080#1083#1091
    end
    object edtInitialDate: TvtDateEdit
      Left = 206
      Top = 12
      Width = 118
      Height = 24
      AlignmentVertical = avCenter
      Font.Charset = DEFAULT_CHARSET
      Style = csDropDown
      TabOrder = 0
      OnChange = edtInitialDateChange
    end
    object edtlDateDelta: TvtSpinEdit
      Left = 172
      Top = 54
      Width = 80
      Height = 24
      UseMaxValue = False
      UseMinValue = False
      TabOrder = 1
      OnChange = edtlDateDeltaChange
    end
    object edtResultDate: TvtDateEdit
      Left = 323
      Top = 97
      Width = 109
      Height = 24
      AlignmentVertical = avCenter
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Style = csDropDown
      TabOrder = 4
    end
    object cbLogModificator: TComboBox
      Left = 359
      Top = 54
      Width = 107
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      ItemIndex = 0
      TabOrder = 3
      Text = #1089#1086' '#1076#1085#1103
      OnChange = cbLogModificatorChange
      Items.Strings = (
        #1089#1086' '#1076#1085#1103
        #1087#1086#1089#1083#1077' '#1076#1085#1103)
    end
    object cbDeltaKind: TComboBox
      Left = 261
      Top = 54
      Width = 89
      Height = 24
      Style = csDropDownList
      ItemHeight = 16
      ItemIndex = 0
      TabOrder = 2
      Text = #1076#1085#1077#1081
      OnChange = cbDeltaKindChange
      Items.Strings = (
        #1076#1085#1077#1081
        #1084#1077#1089#1103#1094#1077#1074
        #1083#1077#1090)
    end
  end
end
