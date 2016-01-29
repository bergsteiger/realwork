inherited SearchDocForExportDlg: TSearchDocForExportDlg
  Left = 318
  Top = 155
  Width = 482
  Height = 397
  ActiveControl = edtLinkedFromDate
  BorderStyle = bsSizeable
  Caption = #1055#1086#1080#1089#1082
  PixelsPerInch = 96
  TextHeight = 16
  object TBevel [0]
    Left = 130
    Top = 87
    Width = 336
    Height = 8
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  inherited ButtonPanel: TPanel
    Top = 325
    Width = 474
    inherited OK: TBitBtn
      Left = 79
    end
    inherited Cancel: TBitBtn
      Left = 170
    end
    inherited Help: TBitBtn
      Left = 260
    end
    object btnSettings: TBitBtn
      Left = 351
      Top = 10
      Width = 105
      Height = 27
      Anchors = [akTop, akRight]
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
      TabOrder = 3
      OnClick = btnSettingsClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555550FF0559
        1950555FF75F7557F7F757000FF055591903557775F75557F77570FFFF055559
        1933575FF57F5557F7FF0F00FF05555919337F775F7F5557F7F700550F055559
        193577557F7F55F7577F07550F0555999995755575755F7FFF7F5570F0755011
        11155557F755F777777555000755033305555577755F75F77F55555555503335
        0555555FF5F75F757F5555005503335505555577FF75F7557F55505050333555
        05555757F75F75557F5505000333555505557F777FF755557F55000000355557
        07557777777F55557F5555000005555707555577777FF5557F55553000075557
        0755557F7777FFF5755555335000005555555577577777555555}
      NumGlyphs = 2
    end
  end
  inherited Panel1: TPanel
    Width = 474
    Height = 325
    object Bevel2: TBevel
      Left = 130
      Top = 69
      Width = 335
      Height = 8
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
    end
    object Label1: TLabel
      Left = 15
      Top = 92
      Width = 23
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1089
      FocusControl = edtLowDate
    end
    object Label4: TLabel
      Left = 151
      Top = 92
      Width = 29
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1087#1086
      Color = clBtnFace
      FocusControl = edtHighDate
      ParentColor = False
    end
    object Bevel1: TBevel
      Left = 77
      Top = 17
      Width = 388
      Height = 8
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
    end
    object Bevel3: TBevel
      Left = 176
      Top = 126
      Width = 289
      Height = 8
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
    end
    object lblLinkedFromDate: TLabel
      Left = 9
      Top = 35
      Width = 29
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1086#1090
    end
    object lblLinkedToDate: TLabel
      Left = 151
      Top = 35
      Width = 29
      Height = 16
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1087#1086
      Color = clBtnFace
      FocusControl = edtLinkedToDate
      ParentColor = False
      Visible = False
    end
    object otlAttrFilter: TvtOutliner
      Left = 8
      Top = 140
      Width = 449
      Height = 173
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
      OnSelectChanged = otlAttrFilterSelectChanged
      Font.Charset = DEFAULT_CHARSET
      ParentColor = False
      TabOrder = 7
      TabStop = True
      Anchors = [akLeft, akTop, akRight, akBottom]
    end
    object cbxChangedDoc: TCheckBox
      Left = 9
      Top = 61
      Width = 124
      Height = 17
      Caption = #1048#1079#1084#1077#1085#1080#1074#1096#1080#1077#1089#1103' '
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object edtLowDate: TvtDateEdit
      Left = 47
      Top = 87
      Width = 100
      Height = 24
      Style = csDropDown
      TabOrder = 4
      OnChange = edtIzmDateChange
    end
    object edtHighDate: TvtDateEdit
      Left = 186
      Top = 87
      Width = 100
      Height = 24
      Style = csDropDown
      TabOrder = 5
      OnChange = edtIzmDateChange
    end
    object edtLinkedFromDate: TvtDateEdit
      Left = 47
      Top = 31
      Width = 100
      Height = 24
      Style = csDropDown
      TabOrder = 1
      OnChange = edtNewDateChange
    end
    object cbxNewDoc: TCheckBox
      Left = 9
      Top = 8
      Width = 187
      Height = 17
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1085#1099#1077' '#1074' '#1074#1077#1088#1089#1080#1102
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object cbxAttrFilter: TCheckBox
      Left = 10
      Top = 119
      Width = 159
      Height = 17
      Caption = #1043#1088#1091#1087#1087#1099' '#1076#1086#1089#1090#1091#1087#1072
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = cbxAttrFilterClick
    end
    object edtLinkedToDate: TvtDateEdit
      Left = 186
      Top = 31
      Width = 100
      Height = 24
      Style = csDropDown
      TabOrder = 2
      Visible = False
      OnChange = edtNewDateChange
    end
  end
end
