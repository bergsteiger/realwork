object TextSearchDlg: TTextSearchDlg
  Left = 502
  Top = 241
  ActiveControl = STextComboBox
  BorderStyle = bsDialog
  Caption = #1055#1054#1048#1057#1050
  ClientHeight = 335
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 428
    Height = 335
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 428
      Height = 335
      ActivePage = TabSheet2
      Align = alClient
      TabOrder = 0
      OnChange = PageControl1Change
      object TabSheet1: TTabSheet
        Caption = '&'#1055#1086#1080#1089#1082
      end
      object TabSheet2: TTabSheet
        Caption = '&'#1047#1072#1084#1077#1085#1072
        ImageIndex = 1
      end
    end
  end
  object Panel12: TPanel
    Left = 2
    Top = 28
    Width = 421
    Height = 89
    Alignment = taRightJustify
    BevelOuter = bvNone
    TabOrder = 3
    object Label1: TLabel
      Left = 15
      Top = 7
      Width = 43
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1058#1077#1082#1089#1090
      FocusControl = STextComboBox
    end
    object Label2: TLabel
      Left = 5
      Top = 36
      Width = 53
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = #1047#1072#1084#1077#1085#1072
      Visible = False
    end
    object sbSrchSpecType: TvtSpeedButton
      Left = 368
      Top = 4
      Width = 24
      Height = 24
      Hint = #1054#1073#1098#1077#1082#1090' '#1087#1086#1080#1089#1082#1072
      Flat = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbSrchSpecTypeClick
    end
    object sbReplaceSpecType: TvtSpeedButton
      Left = 368
      Top = 33
      Width = 24
      Height = 24
      Hint = #1054#1073#1098#1077#1082#1090' '#1079#1072#1084#1077#1085#1099
      Flat = False
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = sbSrchSpecTypeClick
    end
    object btnSymbols: TvtSpeedButton
      Left = 395
      Top = 4
      Width = 24
      Height = 24
      Hint = #1057#1087#1077#1094#1089#1080#1084#1074#1086#1083#1099
      Flat = False
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      Glyph.Data = {
        22020000424D220200000000000042000000280000000F0000000F0000000100
        100003000000E0010000120B0000120B00000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C31461F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C4A291F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C524A08212925841029250821
        EF3D1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7CCE392104EF3D4A291F7CEF3D
        2104524A00001F7C1F7C1F7C1F7C1F7C1F7C1F7C4A298C311F7C4A291F7C524A
        0000CE3900003146AD351F7C1F7C1F7CEF3DCE39524A1F7C1F7C4A29AD358410
        84101F7C00001F7CA514524A1F7C1F7CC61831461F7C314608212104C6188C31
        1F7C1F7C00001F7CCE3908211F7C8C314A291F7C524A21044A2908211F7C1F7C
        8C311F7C00001F7C1F7CC6183146A514524A1F7CCE39A5141F7C4A291F7C8C31
        C6181F7C00001F7C1F7C314621048C311F7C1F7C1F7CA514CE394A29CE39630C
        4A291F7C00001F7C1F7C1F7CEF3D1F7C1F7C1F7C1F7C524A8C31A5148C31EF3D
        31461F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C8C311F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C0000}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSymbolsClick
    end
    object btnSymbolsR: TvtSpeedButton
      Left = 395
      Top = 33
      Width = 24
      Height = 24
      Hint = #1057#1087#1077#1094#1089#1080#1084#1074#1086#1083#1099
      Flat = False
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      Glyph.Data = {
        22020000424D220200000000000042000000280000000F0000000F0000000100
        100003000000E0010000120B0000120B00000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C31461F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C4A291F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C524A08212925841029250821
        EF3D1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7CCE392104EF3D4A291F7CEF3D
        2104524A00001F7C1F7C1F7C1F7C1F7C1F7C1F7C4A298C311F7C4A291F7C524A
        0000CE3900003146AD351F7C1F7C1F7CEF3DCE39524A1F7C1F7C4A29AD358410
        84101F7C00001F7CA514524A1F7C1F7CC61831461F7C314608212104C6188C31
        1F7C1F7C00001F7CCE3908211F7C8C314A291F7C524A21044A2908211F7C1F7C
        8C311F7C00001F7C1F7CC6183146A514524A1F7CCE39A5141F7C4A291F7C8C31
        C6181F7C00001F7C1F7C314621048C311F7C1F7C1F7CA514CE394A29CE39630C
        4A291F7C00001F7C1F7C1F7CEF3D1F7C1F7C1F7C1F7C524A8C31A5148C31EF3D
        31461F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C8C311F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C0000}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = btnSymbolsClick
    end
    object lblOptionsDisp: TLabel
      Left = 61
      Top = 61
      Width = 300
      Height = 26
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object ScopeGroup: TRadioGroup
    Left = 6
    Top = 268
    Width = 203
    Height = 58
    Caption = ' '#1054#1073#1083#1072#1089#1090#1100' '#1087#1086#1080#1089#1082#1072' '
    Color = clBtnFace
    ItemIndex = 0
    Items.Strings = (
      ' '#1042#1077#1089#1100' '#1090#1077#1082#1089#1090
      ' '#1042#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1090#1077#1082#1089#1090)
    ParentColor = False
    TabOrder = 10
    Visible = False
    OnClick = ScopeGroupClick
  end
  object OriginGroup: TRadioGroup
    Left = 216
    Top = 268
    Width = 204
    Height = 58
    Caption = ' '#1058#1086#1095#1082#1072' '#1085#1072#1095#1072#1083#1072' '
    ItemIndex = 0
    Items.Strings = (
      ' '#1054#1090' '#1085#1072#1095#1072#1083#1072' '#1090#1077#1082#1089#1090#1072
      ' '#1054#1090' '#1082#1091#1088#1089#1086#1088#1072)
    TabOrder = 11
    Visible = False
    OnClick = InputsChange
  end
  object OptionGroupBox: TGroupBox
    Left = 6
    Top = 150
    Width = 414
    Height = 116
    Caption = ' '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '
    TabOrder = 9
    Visible = False
    object cbCaseSens: TCheckBox
      Left = 7
      Top = 18
      Width = 185
      Height = 18
      Caption = ' '#1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1088#1077#1075#1080#1089#1090#1088
      TabOrder = 0
      OnClick = cbCaseSensClick
    end
    object cbWordOnly: TCheckBox
      Left = 7
      Top = 37
      Width = 185
      Height = 18
      Caption = ' '#1058#1086#1083#1100#1082#1086' '#1094#1077#1083#1086#1077' '#1089#1083#1086#1074#1086
      TabOrder = 1
      OnClick = cbWordOnlyClick
    end
    object cbNormalize: TCheckBox
      Left = 7
      Top = 56
      Width = 185
      Height = 18
      Caption = ' '#1057#1086' '#1089#1083#1086#1074#1086#1092#1086#1088#1084#1072#1084#1080
      TabOrder = 2
      OnClick = cbNormalizeClick
    end
    object cbRegular: TCheckBox
      Left = 7
      Top = 94
      Width = 185
      Height = 18
      Caption = ' '#1056#1077#1075#1091#1083#1103#1088#1085#1086#1077' '#1074#1099#1088#1072#1078#1077#1085#1080#1077
      TabOrder = 4
      OnClick = cbRegularClick
    end
    object cbWholePara: TCheckBox
      Left = 204
      Top = 16
      Width = 185
      Height = 18
      Caption = ' '#1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1082' '#1087#1072#1088#1072#1075#1088#1072#1092#1091
      TabOrder = 5
      Visible = False
      OnClick = cbWholeParaClick
    end
    object cbAnyTail: TCheckBox
      Left = 7
      Top = 75
      Width = 185
      Height = 18
      Caption = ' '#1057' '#1083#1102#1073#1099#1084#1080' '#1086#1082#1086#1085#1095#1072#1085#1080#1103#1084#1080
      TabOrder = 3
      OnClick = cbAnyTailClick
    end
  end
  object STextComboBox: TvtComboBox
    Left = 64
    Top = 32
    Width = 301
    Height = 24
    ItemHeight = 16
    TabOrder = 1
    OnChange = STextComboBoxChange
    OnDropDown = STextComboBoxDropDown
  end
  object RTextComboBox: TvtComboBox
    Left = 64
    Top = 61
    Width = 301
    Height = 24
    ItemHeight = 16
    TabOrder = 2
    Visible = False
    OnChange = InputsChange
    OnDropDown = STextComboBoxDropDown
  end
  object btnCancel: TButton
    Left = 346
    Top = 119
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 8
    OnClick = btnCancelClick
  end
  object btnMore: TBitBtn
    Left = 7
    Top = 119
    Width = 75
    Height = 25
    Caption = #1054#1087#1094#1080#1080
    TabOrder = 4
    OnClick = btnMoreClick
    Glyph.Data = {
      8E000000424D8E00000000000000760000002800000005000000060000000100
      0400000000001800000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DD0DD000D000
      D00000000000DD0DD000D000D00000000000}
  end
  object btnReplace: TButton
    Left = 85
    Top = 119
    Width = 75
    Height = 25
    Caption = #1047#1072#1084#1077#1085#1080#1090#1100
    Enabled = False
    TabOrder = 5
    Visible = False
    OnClick = btnReplaceClick
  end
  object btnReplaceAll: TButton
    Left = 164
    Top = 119
    Width = 101
    Height = 25
    Caption = #1047#1072#1084#1077#1085#1080#1090#1100' '#1074#1089#1077
    Enabled = False
    TabOrder = 6
    Visible = False
    OnClick = btnReplaceAllClick
  end
  object btnFind: TButton
    Left = 268
    Top = 119
    Width = 75
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 7
    OnClick = btnFindClick
  end
  object mnuRegular: TPopupMenu
    Left = 352
    Top = 256
    object N1: TMenuItem
      Tag = 1
      Caption = #1051#1102#1073#1086#1081' '#1089#1080#1084#1074#1086#1083
      OnClick = mnuRegularsClick
    end
    object N7: TMenuItem
      Tag = 2
      Caption = #1055#1088#1080#1079#1085#1072#1082' '#1085#1077#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1086#1089#1090#1080' '#1089#1080#1084#1074#1086#1083#1072
      OnClick = mnuRegularsClick
    end
    object N2: TMenuItem
      Tag = 3
      Caption = #1057#1080#1084#1074#1086#1083' '#1074' '#1076#1080#1072#1087#1072#1079#1086#1085#1077
      OnClick = mnuRegularsClick
    end
    object N6: TMenuItem
      Tag = 4
      Caption = #1053#1077' '#1074' '#1076#1080#1072#1087#1072#1079#1086#1085#1077
      OnClick = mnuRegularsClick
    end
    object N3: TMenuItem
      Tag = 5
      Caption = #1053#1072#1095#1072#1083#1086' '#1087#1072#1088#1072#1075#1088#1072#1092#1072
      OnClick = mnuRegularsClick
    end
    object N4: TMenuItem
      Tag = 6
      Caption = #1050#1086#1085#1077#1094' '#1087#1072#1088#1072#1075#1088#1072#1092#1072
      OnClick = mnuRegularsClick
    end
    object N31: TMenuItem
      Tag = 15
      Caption = #1053#1072#1095#1072#1083#1086' '#1089#1083#1086#1074#1072
      OnClick = mnuRegularsClick
    end
    object N32: TMenuItem
      Tag = 16
      Caption = #1050#1086#1085#1077#1094' '#1089#1083#1086#1074#1072
      OnClick = mnuRegularsClick
    end
    object N5: TMenuItem
      Tag = 7
      Caption = #1043#1088#1091#1087#1087#1072
      OnClick = mnuRegularsClick
    end
    object N8: TMenuItem
      Tag = 8
      Caption = #1054#1076#1080#1085' '#1080#1083#1080' '#1073#1086#1083#1100#1096#1077' '#1087#1086#1074#1090#1086#1088#1086#1074
      OnClick = mnuRegularsClick
    end
    object N9: TMenuItem
      Tag = 9
      Caption = #1053#1086#1083#1100' '#1080#1083#1080' '#1073#1086#1083#1100#1096#1077' '#1087#1086#1074#1090#1086#1088#1086#1074
      OnClick = mnuRegularsClick
    end
    object N10: TMenuItem
      Caption = '-'
      OnClick = mnuRegularsClick
    end
    object N11: TMenuItem
      Tag = 10
      Caption = #1058#1072#1073#1091#1083#1103#1094#1080#1103
      OnClick = mnuRegularsClick
    end
    object N12: TMenuItem
      Tag = 11
      Caption = #1055#1077#1088#1077#1074#1086#1076' '#1089#1090#1088#1086#1082#1080
      OnClick = mnuRegularsClick
    end
    object N13: TMenuItem
      Tag = 12
      Caption = #1058#1077#1082#1089#1090
      OnClick = mnuRegularsClick
    end
    object N14: TMenuItem
      Tag = 13
      Caption = #1053#1077' '#1090#1077#1082#1089#1090
      OnClick = mnuRegularsClick
    end
    object N23: TMenuItem
      Tag = 14
      Caption = #1062#1080#1092#1088#1072
      OnClick = mnuRegularsClick
    end
  end
  object mnuSpecials: TPopupMenu
    AutoPopup = False
    Left = 352
    Top = 221
    object N15: TMenuItem
      Tag = 1
      Caption = #1058#1072#1073#1091#1083#1103#1094#1080#1103
      OnClick = mnuSymbolsClick
    end
    object N29: TMenuItem
      Tag = 10
      Caption = #1055#1072#1088#1072#1075#1088#1072#1092
      OnClick = mnuSymbolsClick
    end
    object N16: TMenuItem
      Tag = 2
      Caption = #1051#1102#1073#1086#1081' '#1089#1080#1084#1074#1086#1083
      OnClick = mnuSymbolsClick
    end
    object N17: TMenuItem
      Tag = 3
      Caption = #1051#1102#1073#1072#1103' '#1094#1080#1092#1088#1072
      OnClick = mnuSymbolsClick
    end
    object N18: TMenuItem
      Tag = 4
      Caption = #1051#1102#1073#1072#1103' '#1073#1091#1082#1074#1072
      OnClick = mnuSymbolsClick
    end
    object N19: TMenuItem
      Tag = 5
      Caption = #1055#1077#1088#1077#1074#1086#1076' '#1089#1090#1088#1086#1082#1080
      OnClick = mnuSymbolsClick
    end
    object N20: TMenuItem
      Tag = 6
      Caption = #1058#1080#1088#1077
      OnClick = mnuSymbolsClick
    end
    object N21: TMenuItem
      Tag = 7
      Caption = #1044#1083#1080#1085#1085#1086#1077' '#1090#1080#1088#1077
      OnClick = mnuSymbolsClick
    end
    object N22: TMenuItem
      Tag = 8
      Caption = #1053#1077#1088#1072#1079#1073#1080#1074#1072#1077#1084#1099#1081' '#1087#1088#1086#1073#1077#1083
      OnClick = mnuSymbolsClick
    end
  end
  object mnuSymbolsR: TPopupMenu
    Left = 384
    Top = 221
    object N24: TMenuItem
      Tag = 1
      Caption = #1058#1072#1073#1091#1083#1103#1094#1080#1103
      OnClick = mnuSymbolsClick
    end
    object N30: TMenuItem
      Tag = 10
      Caption = #1055#1072#1088#1072#1075#1088#1072#1092
      OnClick = mnuSymbolsClick
    end
    object N25: TMenuItem
      Tag = 5
      Caption = #1055#1077#1088#1077#1074#1086#1076' '#1089#1090#1088#1086#1082#1080
      OnClick = mnuSymbolsClick
    end
    object N26: TMenuItem
      Tag = 6
      Caption = #1058#1080#1088#1077
      OnClick = mnuSymbolsClick
    end
    object N27: TMenuItem
      Tag = 7
      Caption = #1044#1083#1080#1085#1085#1086#1077' '#1090#1080#1088#1077
      OnClick = mnuSymbolsClick
    end
    object N28: TMenuItem
      Tag = 8
      Caption = #1053#1077#1088#1072#1079#1073#1080#1074#1072#1077#1084#1099#1081' '#1087#1088#1086#1073#1077#1083
      OnClick = mnuSymbolsClick
    end
  end
  object ilOpenClose: TImageList
    Height = 8
    Width = 7
    Left = 319
    Top = 221
    Bitmap = {
      494C010102000400040007000800FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000001C0000000800000001002000000000008003
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      280000001C000000080000000100010000000000200000000000000000000000
      000000000000000000000000FFFFFF00FFFC000083DC0000C78C0000EF040000
      83DC0000C78C0000EF040000FFFC000000000000000000000000000000000000
      000000000000}
  end
end
