object StyleDesignDlg: TStyleDesignDlg
  Left = 257
  Top = 157
  BorderStyle = bsDialog
  Caption = #1044#1080#1079#1072#1081#1085#1077#1088' '#1089#1090#1080#1083#1077#1081
  ClientHeight = 500
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 16
  object OKBtn: TBitBtn
    Left = 503
    Top = 464
    Width = 92
    Height = 27
    TabOrder = 0
    Kind = bkOK
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object HelpBtn: TBitBtn
    Left = 701
    Top = 464
    Width = 92
    Height = 27
    Caption = #1055#1086#1084#1086#1097#1100
    TabOrder = 1
    OnClick = HelpBtnClick
    Kind = bkHelp
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object Panel1: TPanel
    Left = 4
    Top = 8
    Width = 285
    Height = 449
    BorderWidth = 1
    TabOrder = 2
    DesignSize = (
      285
      449)
    object Label1: TLabel
      Left = 7
      Top = 6
      Width = 35
      Height = 16
      Caption = #1057#1090#1080#1083#1100
    end
    object StyleEdit: TEdit
      Left = 5
      Top = 27
      Width = 274
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object StylesOutliner: TvtOutliner
      Left = 5
      Top = 56
      Width = 274
      Height = 384
      AutoRowHeight = False
      ProtectColor.BackColor = clRed
      ProtectColor.TextColor = clWhite
      RowHeight = 19
      SelectColor.BackColor = clHighlight
      SelectColor.TextColor = clHighlightText
      SelectNonFocusColor.BackColor = clBtnFace
      SelectNonFocusColor.TextColor = clBtnText
      OnGetItemImage = StylesOutlinerGetItemImage
      OnNodeMoveEnd = StylesOutlinerNodeMoveEnd
      OnGetItemColor = StylesOutlinerGetItemColor
      OnCurrentChanged = StylesOutlinerCurrentChanged
      Font.Color = clBlack
      ParentColor = False
      ParentFont = True
      TabOrder = 1
      TabStop = True
      EditOptions = [eoItemHMoving, eoItemVMoving, eoItemExpand]
    end
  end
  object BitBtn1: TBitBtn
    Left = 602
    Top = 464
    Width = 92
    Height = 27
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    Kind = bkCancel
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object Panel2: TPanel
    Left = 296
    Top = 8
    Width = 497
    Height = 449
    TabOrder = 4
    object Bevel1: TBevel
      Left = 8
      Top = 335
      Width = 477
      Height = 82
      Shape = bsFrame
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 87
      Width = 286
      Height = 241
      Caption = ' '#1064#1088#1080#1092#1090' '
      TabOrder = 0
      object lbFontName: TLabel
        Left = 32
        Top = 25
        Width = 104
        Height = 16
        AutoSize = False
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      end
      object lbFontSize: TLabel
        Left = 226
        Top = 25
        Width = 54
        Height = 16
        AutoSize = False
        Caption = #1056#1072#1079#1084#1077#1088
      end
      object lbFontColor: TLabel
        Left = 33
        Top = 78
        Width = 61
        Height = 16
        AutoSize = False
        Caption = #1058#1077#1082#1089#1090
      end
      object sbFontNameInherit: TSpeedButton
        Left = 10
        Top = 25
        Width = 18
        Height = 17
        Caption = #1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbInheritClick
      end
      object sbFontSizeInherit: TSpeedButton
        Left = 205
        Top = 25
        Width = 17
        Height = 17
        Caption = #1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbInheritClick
      end
      object sbFontColorInherit: TSpeedButton
        Left = 10
        Top = 78
        Width = 18
        Height = 17
        Caption = #1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbInheritClick
      end
      object sbFontBoldInherit: TSpeedButton
        Left = 12
        Top = 137
        Width = 18
        Height = 17
        Caption = #1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbInheritClick
      end
      object sbFontItalicInherit: TSpeedButton
        Left = 12
        Top = 155
        Width = 18
        Height = 17
        Caption = #1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbInheritClick
      end
      object sbFontUnderlineInherit: TSpeedButton
        Left = 12
        Top = 173
        Width = 18
        Height = 17
        Caption = #1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbInheritClick
      end
      object sbBackColorInherit: TSpeedButton
        Left = 149
        Top = 78
        Width = 18
        Height = 17
        Caption = #1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbInheritClick
      end
      object lbBackColor: TLabel
        Left = 172
        Top = 79
        Width = 60
        Height = 16
        AutoSize = False
        Caption = #1060#1086#1085
      end
      object sbVisibleInherit: TSpeedButton
        Left = 12
        Top = 209
        Width = 18
        Height = 17
        Caption = #1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbInheritClick
      end
      object sbFontStrikeoutInherit: TSpeedButton
        Left = 12
        Top = 191
        Width = 18
        Height = 17
        Caption = #1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbInheritClick
      end
      object cbColor: TvtColorBox
        Tag = 1
        Left = 9
        Top = 98
        Width = 131
        Height = 22
        OnChange = cbColorChange
        ColorStyle = [cbStandardColors, cbSystemColors, cbIncludeDefault, cbCustomColor, cbPrettyNames]
        Selected = clScrollBar
        Font.Color = clBlack
        Font.Height = -11
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TabStop = True
      end
      object FontSizeEdit: TvtSpinEdit
        Left = 204
        Top = 44
        Width = 72
        Height = 24
        MaxValue = 72.000000000000000000
        MinValue = 1.000000000000000000
        Value = 1.000000000000000000
        TabOrder = 1
        OnChange = FontSizeEditChange
      end
      object FontCombo: TComboBox
        Left = 9
        Top = 44
        Width = 185
        Height = 24
        ItemHeight = 16
        TabOrder = 2
        OnChange = FontComboChange
      end
      object chbBold: TCheckBox
        Left = 34
        Top = 137
        Width = 125
        Height = 17
        Caption = #1046#1080#1088#1085#1099#1081
        TabOrder = 3
        OnClick = chbBoldClick
      end
      object chbItalic: TCheckBox
        Left = 35
        Top = 155
        Width = 126
        Height = 17
        Caption = #1053#1072#1082#1083#1086#1085#1085#1099#1081
        Color = clBtnFace
        ParentColor = False
        TabOrder = 4
        OnClick = chbItalicClick
      end
      object chbUnderline: TCheckBox
        Left = 34
        Top = 173
        Width = 127
        Height = 17
        Caption = #1055#1086#1076#1095#1077#1088#1082#1085#1091#1090#1099#1081
        TabOrder = 5
        OnClick = chbUnderlineClick
      end
      object cbBackColor: TvtColorBox
        Left = 147
        Top = 98
        Width = 131
        Height = 22
        OnChange = cbColorChange
        ColorStyle = [cbStandardColors, cbSystemColors, cbIncludeDefault, cbCustomColor, cbPrettyNames]
        DefaultColorColor = clWhite
        Selected = clScrollBar
        Font.Color = clBlack
        Font.Height = -11
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        TabStop = True
      end
      object chbVisible: TCheckBox
        Left = 34
        Top = 209
        Width = 127
        Height = 17
        Caption = #1042#1080#1076#1080#1084#1099#1081
        TabOrder = 7
        OnClick = chbVisibleClick
      end
      object chbStrikeout: TCheckBox
        Left = 34
        Top = 191
        Width = 127
        Height = 17
        Caption = #1047#1072#1095#1077#1088#1082#1085#1091#1090#1099#1081
        TabOrder = 8
        OnClick = chbStrikeoutClick
      end
    end
    object GroupBox3: TGroupBox
      Left = 299
      Top = 6
      Width = 189
      Height = 322
      Caption = ' '#1040#1073#1079#1072#1094' '
      TabOrder = 1
      object Label6: TLabel
        Left = 39
        Top = 34
        Width = 114
        Height = 16
        AutoSize = False
        Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077
      end
      object Label7: TLabel
        Left = 39
        Top = 126
        Width = 106
        Height = 16
        AutoSize = False
        Caption = #1054#1090#1089#1090#1091#1087' '#1089#1083#1077#1074#1072
      end
      object Label8: TLabel
        Left = 39
        Top = 189
        Width = 138
        Height = 16
        AutoSize = False
        Caption = #1054#1090#1089#1090#1091#1087' '#1082#1088#1072#1089#1085#1086#1081' '#1089#1090#1088#1086#1082#1080
      end
      object Label10: TLabel
        Left = 38
        Top = 251
        Width = 120
        Height = 16
        AutoSize = False
        Caption = #1064#1080#1088#1080#1085#1072' '#1087#1072#1088#1072#1075#1088#1072#1092#1072
      end
      object MeasureLabel1: TLabel
        Left = 139
        Top = 153
        Width = 52
        Height = 16
        AutoSize = False
        Caption = #1089#1084
        Transparent = True
      end
      object MeasureLabel2: TLabel
        Left = 139
        Top = 216
        Width = 46
        Height = 16
        AutoSize = False
        Caption = #1089#1084
        Transparent = True
      end
      object MeasureLabel3: TLabel
        Left = 140
        Top = 278
        Width = 47
        Height = 16
        AutoSize = False
        Caption = #1089#1084
        Transparent = True
      end
      object sbLeftJstF: TSpeedButton
        Left = 15
        Top = 56
        Width = 26
        Height = 25
        Hint = #1042#1099#1088#1072#1074#1085#1103#1090#1100' '#1074#1083#1077#1074#1086'|'
        GroupIndex = 2
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777777777777777770000000000777777777777777777777700000000000
          0007777777777777777770000000000777777777777777777777700000000000
          0007777777777777777770000000000777777777777777777777700000000000
          0007777777777777777777777777777777777777777777777777}
        OnClick = sbJstFClick
      end
      object sbWideJstF: TSpeedButton
        Left = 90
        Top = 56
        Width = 26
        Height = 25
        Hint = #1042#1099#1088#1072#1074#1085#1103#1090#1100' '#1087#1086' '#1096#1080#1088#1080#1085#1077'|'
        GroupIndex = 2
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777777777777777770000000000000077777777777777777700000000000
          0007777777777777777770000000000000077777777777777777700000000000
          0007777777777777777770000000000000077777777777777777700000000000
          0007777777777777777777777777777777777777777777777777}
        OnClick = sbJstFClick
      end
      object sbRightJstF: TSpeedButton
        Left = 65
        Top = 56
        Width = 26
        Height = 25
        Hint = #1042#1099#1088#1072#1074#1085#1103#1090#1100' '#1074#1087#1088#1072#1074#1086'|'
        GroupIndex = 2
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777777777777777777777000000000077777777777777777700000000000
          0007777777777777777777777000000000077777777777777777700000000000
          0007777777777777777777777000000000077777777777777777700000000000
          0007777777777777777777777777777777777777777777777777}
        OnClick = sbJstFClick
      end
      object sbCenterJstF: TSpeedButton
        Left = 40
        Top = 56
        Width = 26
        Height = 25
        Hint = #1042#1099#1088#1072#1074#1085#1103#1090#1100' '#1074' '#1087#1086' '#1094#1077#1085#1090#1088#1091'|'
        GroupIndex = 2
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777777777777777777700000000007777777777777777777700000000000
          0007777777777777777777700000000007777777777777777777700000000000
          0007777777777777777777700000000007777777777777777777700000000000
          0007777777777777777777777777777777777777777777777777}
        OnClick = sbJstFClick
      end
      object sbParaJustInherit: TSpeedButton
        Left = 15
        Top = 33
        Width = 19
        Height = 17
        Caption = #1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbParaInheritClick
      end
      object sbParaLeftInherit: TSpeedButton
        Left = 15
        Top = 125
        Width = 19
        Height = 17
        Caption = #1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbParaInheritClick
      end
      object sbParaFirstInherit: TSpeedButton
        Left = 15
        Top = 188
        Width = 19
        Height = 17
        Caption = #1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbParaInheritClick
      end
      object sbParaWidthInherit: TSpeedButton
        Left = 15
        Top = 251
        Width = 19
        Height = 17
        Caption = #1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = sbParaInheritClick
      end
      object sbJustifyPreformatted: TSpeedButton
        Left = 115
        Top = 56
        Width = 26
        Height = 25
        Hint = #1055#1088#1077#1092#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1085#1085#1099#1081' '#1087#1072#1088#1072#1075#1088#1072#1092
        GroupIndex = 2
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888888888888888888888888888888888888888888888888888888888
          8888888888888888888880888888888888088000000000000008800000000000
          0008808888888888880888888888888888888888888888888888888888888888
          8888888888888888888888888888888888888888888888888888}
        OnClick = sbJstFClick
      end
      object EditParaWidth: TvtSpinEdit
        Left = 13
        Top = 273
        Width = 124
        Height = 24
        Increment = 0.100000000000000000
        ValueType = vtFloat
        MaxValue = 999.000000000000000000
        MinValue = -2147483648.000000000000000000
        EmptyValue = -1.000000000000000000
        Value = -1.000000000000000000
        TabOrder = 0
        OnChange = EditParaWidthChange
      end
      object EditFirstLineMargin: TvtSpinEdit
        Left = 13
        Top = 210
        Width = 124
        Height = 24
        Increment = 0.100000000000000000
        ValueType = vtFloat
        MaxValue = 999.000000000000000000
        MinValue = -2147483648.000000000000000000
        EmptyValue = -1.000000000000000000
        Value = -1.000000000000000000
        TabOrder = 1
        OnChange = EditFirstLineMarginChange
      end
      object EditLeftMargin: TvtSpinEdit
        Left = 14
        Top = 147
        Width = 123
        Height = 24
        Increment = 0.100000000000000000
        ValueType = vtFloat
        MaxValue = 999.000000000000000000
        MinValue = -2147483648.000000000000000000
        EmptyValue = -1.000000000000000000
        Value = -1.000000000000000000
        TabOrder = 2
        OnChange = EditLeftMarginChange
      end
    end
    object ExamplePanel: TevMemo
      Left = 15
      Top = 343
      Width = 464
      Height = 64
      LMargin = 16
      ScrollStyle = ssNone
      Text = 
        #1058#1077#1089#1090#1086#1074#1099#1081' '#1087#1072#1088#1072#1075#1088#1072#1092'. '#1058#1077#1089#1090#1086#1074#1099#1081' '#1087#1072#1088#1072#1075#1088#1072#1092'. '#1058#1077#1089#1090#1086#1074#1099#1081' '#1087#1072#1088#1072#1075#1088#1072#1092'. '#1058#1077#1089#1090#1086#1074#1099 +
        #1081' '#1087#1072#1088#1072#1075#1088#1072#1092'.'
      Enabled = False
      TabOrder = 2
      TabStop = True
      BorderStyle = bsSingle
    end
    object GrpStyle: TRadioGroup
      Left = 8
      Top = 7
      Width = 285
      Height = 74
      Caption = ' '#1058#1080#1087' '#1089#1090#1080#1083#1103' '
      ItemIndex = 0
      Items.Strings = (
        #1040#1073#1079#1072#1094
        #1042#1099#1076#1077#1083#1077#1085#1080#1077)
      TabOrder = 3
      OnClick = GrpStyleClick
    end
    object sbStyleTypeInherit: TButton
      Left = 269
      Top = 24
      Width = 17
      Height = 17
      Caption = 'C'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      TabStop = False
    end
    object chbVisibleUser: TCheckBox
      Left = 10
      Top = 425
      Width = 335
      Height = 17
      Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1089#1090#1080#1083#1100' '#1074' '#1089#1087#1080#1089#1082#1077' '#1090#1077#1082#1089#1090#1086#1074#1086#1075#1086' '#1088#1077#1076#1072#1082#1090#1086#1088#1072
      TabOrder = 5
      OnClick = chbVisibleUserClick
    end
  end
end
