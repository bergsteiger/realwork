inherited DocSearchDlg: TDocSearchDlg
  Left = 250
  Top = 193
  VertScrollBar.Range = 0
  AutoScroll = False
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1047#1040#1055#1056#1054#1057' '#1053#1040' '#1055#1054#1048#1057#1050
  ClientHeight = 407
  ClientWidth = 518
  Font.Color = clBlack
  Font.Name = 'Arial'
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 362
    Width = 518
    inherited OK: TBitBtn
      Left = 245
      OnClick = OKClick
    end
    inherited Cancel: TBitBtn
      Left = 335
    end
    inherited Help: TBitBtn
      Left = 425
    end
    object cbxNewOnly: TvtCheckBox
      Left = 8
      Top = 16
      Width = 177
      Height = 17
      Caption = #1042#1089#1077#1075#1076#1072' '#1085#1086#1074#1072#1103' '#1074#1099#1073#1086#1088#1082#1072
      ParentFont = True
      TabOrder = 3
      OnClick = cbxNewOnlyClick
    end
  end
  inherited Panel1: TPanel
    Width = 518
    Height = 0
    Align = alTop
    TabOrder = 2
    Visible = False
  end
  object nbkSearchWhat: TPageControl
    Left = 0
    Top = 0
    Width = 518
    Height = 362
    ActivePage = TabSheet1
    Align = alClient
    Images = ImageList1
    TabOrder = 0
    TabStop = False
    OnChanging = nbkSearchWhatChanging
    object TabSheet1: TTabSheet
      Caption = '&'#1040#1090#1088#1080#1073#1091#1090#1099
      ImageIndex = -1
      object pnlTxt: TPanel
        Left = 246
        Top = 0
        Width = 264
        Height = 331
        Align = alClient
        BevelInner = bvLowered
        TabOrder = 1
        DesignSize = (
          264
          331)
        object Label2: TvtLabel
          Left = 5
          Top = 5
          Width = 62
          Height = 16
          AutoSize = False
          Caption = #1058#1077#1082#1089#1090
          ParentFont = True
        end
        object lblTxt2: TvtLabel
          Left = 8
          Top = 60
          Width = 9
          Height = 16
          Caption = #1048
          ParentFont = True
        end
        object lblTxt3: TvtLabel
          Left = 8
          Top = 95
          Width = 9
          Height = 16
          Caption = #1048
          ParentFont = True
        end
        object lblTxt4: TvtLabel
          Left = 8
          Top = 127
          Width = 9
          Height = 16
          Caption = #1048
          ParentFont = True
        end
        object edtTxt1: TEdit
          Left = 23
          Top = 24
          Width = 228
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnChange = edtTxt1Change
        end
        object edtTxt2: TEdit
          Left = 23
          Top = 56
          Width = 228
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          OnChange = edtTxt1Change
        end
        object edtTxt3: TEdit
          Left = 23
          Top = 89
          Width = 228
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          OnChange = edtTxt1Change
        end
        object edtTxt4: TEdit
          Left = 23
          Top = 122
          Width = 228
          Height = 24
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
          OnChange = edtTxt1Change
        end
        object cbxSrchInNameOnly2: TvtCheckBox
          Left = 25
          Top = 160
          Width = 224
          Height = 17
          Caption = ' '#1048#1089#1082#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1087#1086' '#1085#1072#1079#1074#1072#1085#1080#1102
          ParentFont = True
          TabOrder = 4
          OnClick = cbxSrchInNameOnlyClick
        end
        object grpTags: TGroupBox
          Left = 8
          Top = 204
          Width = 241
          Height = 77
          Caption = ' '#1052#1077#1090#1082#1080' '
          TabOrder = 5
          object cbInternet: TCheckBox
            Left = 8
            Top = 24
            Width = 169
            Height = 17
            AllowGrayed = True
            Caption = #1048#1085#1090#1077#1088#1085#1077#1090
            State = cbGrayed
            TabOrder = 0
          end
          object cbHang: TCheckBox
            Left = 8
            Top = 49
            Width = 161
            Height = 17
            AllowGrayed = True
            Caption = #1054#1073#1088#1072#1073#1086#1090#1082#1072' '#1086#1090#1083#1086#1078#1077#1085#1072
            State = cbGrayed
            TabOrder = 1
          end
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 246
        Height = 331
        Align = alLeft
        BevelInner = bvLowered
        TabOrder = 0
        object StatusBox: TvtGroupBoxEx
          Left = 11
          Top = 204
          Width = 225
          Height = 60
          Caption = ' &'#1057#1090#1072#1090#1091#1089' '
          ParentFont = True
          TabOrder = 1
          object CheckBox1: TvtCheckBox
            Left = 8
            Top = 20
            Width = 197
            Height = 15
            Caption = #1044#1077#1081#1089#1090#1074#1091#1102#1097#1080#1081
            Checked = True
            ParentFont = True
            State = cbChecked
            TabOrder = 0
            OnClick = StatusCheckBoxClick
          end
          object CheckBox2: TvtCheckBox
            Left = 8
            Top = 40
            Width = 200
            Height = 15
            Caption = #1053#1077#1076#1077#1081#1089#1090#1074#1091#1102#1097#1080#1081
            Checked = True
            ParentFont = True
            State = cbChecked
            TabOrder = 1
            OnClick = StatusCheckBoxClick
          end
        end
        object GroupBox1: TGroupBox
          Left = 11
          Top = 2
          Width = 225
          Height = 200
          TabOrder = 0
          object Label6: TvtLabel
            Left = 5
            Top = 31
            Width = 48
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = #1053#1086#1084#1077#1088
            FocusControl = cbNumber
            ParentFont = True
          end
          object Label7: TvtLabel
            Left = 14
            Top = 171
            Width = 39
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = #1058#1080#1087
            FocusControl = cbDocType
            ParentFont = True
          end
          object Label4: TvtLabel
            Left = 25
            Top = 123
            Width = 28
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = #1087#1086
            ParentFont = True
          end
          object Label1: TvtLabel
            Left = 28
            Top = 90
            Width = 25
            Height = 16
            Alignment = taRightJustify
            AutoSize = False
            Caption = #1089
            ParentFont = True
          end
          object Label8: TvtLabel
            Left = 25
            Top = 67
            Width = 28
            Height = 16
            Alignment = taRightJustify
            Caption = #1044#1072#1090#1072
            ParentFont = True
          end
          object cbNumber: TComboBox
            Left = 57
            Top = 27
            Width = 160
            Height = 24
            ItemHeight = 16
            TabOrder = 0
            OnChange = cbDocTypeChange
            OnDropDown = cbNumberDropDown
          end
          object cbDocType: TComboBox
            Left = 57
            Top = 167
            Width = 160
            Height = 24
            Style = csDropDownList
            ItemHeight = 16
            TabOrder = 3
            OnChange = cbDocTypeChange
          end
          object LowDateEdit: TvtDateEdit
            Left = 57
            Top = 85
            Width = 160
            Height = 24
            ParentFont = True
            Style = csDropDown
            TabOrder = 1
            OnChange = EditChange
          end
          object HighDateEdit: TvtDateEdit
            Left = 57
            Top = 118
            Width = 160
            Height = 24
            ParentFont = True
            Style = csDropDown
            TabOrder = 2
            OnChange = EditChange
            OnEnter = HighDateEditEnter
          end
        end
        object grpUrgency: TvtGroupBox
          Left = 10
          Top = 266
          Width = 228
          Height = 57
          Caption = ' '#1057#1088#1086#1095#1085#1086#1089#1090#1100' '
          ParentFont = True
          TabOrder = 2
          object cbUrgency: TComboBox
            Left = 8
            Top = 22
            Width = 209
            Height = 24
            Style = csDropDownList
            ItemHeight = 16
            ItemIndex = 0
            TabOrder = 0
            Text = '['#1083#1102#1073#1072#1103']'
            Items.Strings = (
              '['#1083#1102#1073#1072#1103']')
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = '&'#1050#1083#1072#1089#1089#1099
      ImageIndex = -1
      inline SearchAttrExplorer: TAttrExplorer
        Left = 0
        Top = 0
        Width = 510
        Height = 307
        Align = alClient
        TabOrder = 0
        inherited otlAttributes: TvtOutliner
          Width = 510
          Height = 287
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
        end
        inherited AttrFooter: TvtStatusBar
          Top = 287
          Width = 510
        end
        inherited AttrPopUpMenu: TLinkPopUpMenu
          PrimaryPopUpMenu = MainPopupMenu
          Top = 48
        end
      end
      object ParamsPanel: TPanel
        Left = 0
        Top = 307
        Width = 510
        Height = 24
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object cbxWithEquals: TvtCheckBox
          Left = 4
          Top = 5
          Width = 300
          Height = 17
          Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1101#1082#1074#1080#1074#1072#1083#1077#1085#1090#1085#1099#1077
          ParentFont = True
          TabOrder = 0
          OnClick = cbxWithEqualsClick
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = '&'#1058#1077#1082#1089#1090
      ImageIndex = -1
      object TextSrchMemo: TevMemo
        Left = 0
        Top = 30
        Width = 510
        Height = 275
        Align = alClient
        RMargin = 8
        Ctl3D = True
        ParentFont = True
        ParentCtl3D = False
        TabOrder = 0
        TabStop = True
        BorderStyle = bsSingle
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 510
        Height = 30
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object sbANDSign: TToolbarButton97
          Left = 4
          Top = 3
          Width = 25
          Height = 25
          Hint = #1057#1083#1086#1078#1077#1085#1080#1077' '#1087#1086' "'#1048'"|'
          DisplayMode = dmTextOnly
          Caption = '&&'
          Flat = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = sbANDSignClick
        end
        object sbORSign: TToolbarButton97
          Left = 86
          Top = 3
          Width = 25
          Height = 25
          Hint = #1057#1083#1086#1078#1077#1085#1080#1077' '#1087#1086' "'#1048#1051#1048'"|'
          DisplayMode = dmTextOnly
          Caption = '|'
          Flat = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = sbORSignClick
        end
        object sbANDNOTSign: TToolbarButton97
          Left = 112
          Top = 3
          Width = 25
          Height = 25
          Hint = #1057#1083#1086#1078#1077#1085#1080#1077' '#1087#1086' "'#1048' '#1053#1045'"|'
          DisplayMode = dmTextOnly
          Caption = '~'
          Flat = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = sbANDNOTSignClick
        end
        object sbFLWSign: TToolbarButton97
          Left = 45
          Top = 3
          Width = 25
          Height = 25
          Hint = #1057#1083#1077#1076#1086#1074#1072#1085#1080#1077'|'
          DisplayMode = dmTextOnly
          Caption = ':'
          Flat = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Opaque = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = sbFLWSignClick
        end
        object sbBrackets: TToolbarButton97
          Left = 138
          Top = 3
          Width = 25
          Height = 25
          Hint = #1057#1082#1086#1073#1082#1080'|'
          Caption = '( )'
          Flat = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = sbBracketsClick
        end
        object sbANDSignInterval: TToolbarButton97
          Left = 29
          Top = 3
          Width = 15
          Height = 25
          Hint = #1057#1083#1086#1078#1077#1085#1080#1077' '#1087#1086' "'#1048'"|'
          DropdownMenu = IntervalPopupMenu
          Flat = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Margin = 0
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = sbANDSignIntervalClick
        end
        object sbFLWSignInterval: TToolbarButton97
          Left = 70
          Top = 3
          Width = 15
          Height = 25
          Hint = #1057#1083#1077#1076#1086#1074#1072#1085#1080#1077' '#1085#1072' '#1080#1085#1090#1077#1088#1074#1072#1083#1077'|'
          DropdownMenu = IntervalPopupMenu
          Flat = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Margin = 0
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = sbFLWSignIntervalClick
        end
        object sbAsteriskSign: TToolbarButton97
          Left = 169
          Top = 3
          Width = 25
          Height = 25
          Caption = '*'
          Flat = False
          OnClick = sbAsteriskSignClick
        end
        object sbQuestSign: TToolbarButton97
          Left = 194
          Top = 3
          Width = 25
          Height = 25
          Caption = '?'
          Flat = False
          OnClick = sbQuestSignClick
        end
      end
      object Panel9: TPanel
        Left = 0
        Top = 305
        Width = 510
        Height = 26
        Align = alBottom
        TabOrder = 2
        object cbxSrchInNameOnly: TvtCheckBox
          Left = 5
          Top = 4
          Width = 277
          Height = 19
          Caption = ' '#1048#1089#1082#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1087#1086' '#1085#1072#1079#1074#1072#1085#1080#1102
          ParentFont = True
          TabOrder = 0
          OnClick = cbxSrchInNameOnlyClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = '&'#1069#1090#1072#1087#1099
      ImageIndex = -1
      object tblStage: TOvcTable
        Left = 0
        Top = 0
        Width = 510
        Height = 231
        RowLimit = 10
        Align = alClient
        BorderStyle = bsNone
        ColorUnused = clBtnFace
        Colors.ActiveFocused = clHighlight
        Colors.ActiveFocusedText = clHighlightText
        Colors.ActiveUnfocused = clHighlight
        Colors.ActiveUnfocusedText = clHighlightText
        Colors.Locked = clBtnFace
        Colors.LockedText = clWindowText
        Colors.Editing = clBtnFace
        Colors.EditingText = clWindowText
        Colors.Selected = clHighlight
        Colors.SelectedText = clHighlightText
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        GridPenSet.NormalGrid.NormalColor = clBtnShadow
        GridPenSet.NormalGrid.SecondColor = clBtnHighlight
        GridPenSet.NormalGrid.Style = psSolid
        GridPenSet.NormalGrid.Effect = ge3D
        GridPenSet.LockedGrid.NormalColor = clBtnShadow
        GridPenSet.LockedGrid.SecondColor = clBtnHighlight
        GridPenSet.LockedGrid.Style = psSolid
        GridPenSet.LockedGrid.Effect = ge3D
        GridPenSet.CellWhenFocused.NormalColor = clBlack
        GridPenSet.CellWhenFocused.SecondColor = clBtnHighlight
        GridPenSet.CellWhenFocused.Style = psSolid
        GridPenSet.CellWhenFocused.Effect = ge3D
        GridPenSet.CellWhenUnfocused.NormalColor = clBlack
        GridPenSet.CellWhenUnfocused.SecondColor = clBtnHighlight
        GridPenSet.CellWhenUnfocused.Style = psSolid
        GridPenSet.CellWhenUnfocused.Effect = ge3D
        LockedRowsCell = chStage
        Options = [otoNoRowResizing]
        ParentFont = False
        TabOrder = 0
        OnDoneEdit = tblStageDoneEdit
        OnExit = tblStageExit
        OnGetCellData = tblStageGetCellData
        CellData = (
          'DocSearchDlg.chStage'
          'DocSearchDlg.tcCondition'
          'DocSearchDlg.tcStageName')
        RowData = (
          24
          1
          False
          23
          8
          False
          23)
        ColData = (
          289
          False
          True
          'DocSearchDlg.tcStageName'
          206
          False
          True
          'DocSearchDlg.tcCondition')
      end
      object Panel12: TPanel
        Left = 0
        Top = 231
        Width = 510
        Height = 100
        Align = alBottom
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        DesignSize = (
          510
          100)
        object gbxStageStatus: TvtGroupBoxEx
          Left = 3
          Top = 57
          Width = 503
          Height = 40
          Anchors = [akLeft, akTop, akRight]
          Caption = ' &'#1057#1090#1072#1090#1091#1089' '
          ParentFont = True
          TabOrder = 1
          object cbxStageInc: TvtCheckBox
            Left = 12
            Top = 17
            Width = 134
            Height = 16
            Caption = ' '#1055#1086#1076#1082#1083#1102#1095#1077#1085#1085#1099#1077
            ParentFont = True
            TabOrder = 0
            OnClick = cbStageUnplugOnlyClick
          end
          object cbxStageUnInc: TvtCheckBox
            Left = 152
            Top = 16
            Width = 161
            Height = 17
            Caption = ' '#1053#1077#1087#1086#1076#1082#1083#1102#1095#1077#1085#1085#1099#1077
            Checked = True
            ParentFont = True
            State = cbChecked
            TabOrder = 1
            OnClick = cbStageUnplugOnlyClick
          end
        end
        object gbStageDates: TGroupBox
          Left = 5
          Top = 2
          Width = 501
          Height = 54
          Anchors = [akLeft, akTop, akRight]
          Caption = ' &'#1044#1072#1090#1072' '
          TabOrder = 0
          object Label3: TvtLabel
            Left = 11
            Top = 24
            Width = 23
            Height = 15
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'C'
            ParentFont = True
          end
          object Label5: TvtLabel
            Left = 158
            Top = 26
            Width = 27
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = #1055#1054
            ParentFont = True
          end
          object edtStageDateBegin: TvtDateEdit
            Left = 42
            Top = 19
            Width = 100
            Height = 24
            ParentFont = True
            Style = csDropDown
            TabOrder = 0
            OnChange = EditChange
          end
          object edtStageDateEnd: TvtDateEdit
            Left = 199
            Top = 20
            Width = 100
            Height = 24
            ParentFont = True
            Style = csDropDown
            TabOrder = 1
            OnChange = EditChange
            OnEnter = HighDateEditEnter
          end
        end
      end
    end
  end
  object IntervalPopupMenu: TPopupMenu
    Left = 474
    Top = 2
    object piIntervalDoc: TMenuItem
      Caption = #1074' '#1087#1088#1077#1076#1077#1083#1072#1093' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      OnClick = piItervalClick
    end
    object piIntervalPara: TMenuItem
      Tag = 255
      Caption = #1074' '#1087#1088#1077#1076#1077#1083#1072#1093' '#1072#1073#1079#1072#1094#1072
      OnClick = piItervalClick
    end
    object piIntervalExpr: TMenuItem
      Tag = 254
      Caption = #1074' '#1087#1088#1077#1076#1077#1083#1072#1093' '#1087#1088#1077#1076#1083#1086#1078#1077#1085#1080#1103
      OnClick = piItervalClick
    end
    object piIntervalTogether: TMenuItem
      Tag = 1
      Caption = #1088#1103#1076#1086#1084
      OnClick = piItervalClick
    end
    object piInterval: TMenuItem
      Caption = #1074' '#1080#1085#1090#1077#1088#1074#1072#1083#1077
      object piInterval2: TMenuItem
        Tag = 2
        Caption = '2'
        OnClick = piItervalClick
      end
      object piInterval3: TMenuItem
        Tag = 3
        Caption = '3'
        OnClick = piItervalClick
      end
      object piInterval4: TMenuItem
        Tag = 4
        Caption = '4'
        OnClick = piItervalClick
      end
      object piInterval5: TMenuItem
        Tag = 5
        Caption = '5'
        OnClick = piItervalClick
      end
    end
  end
  object chStage: TOvcTCColHead
    Headings.Strings = (
      #1069#1090#1072#1087#1099
      #1057#1086#1089#1090#1086#1103#1085#1080#1077)
    ShowActiveCol = False
    ShowLetters = False
    Table = tblStage
    TextStyle = tsFlat
    UseWordWrap = False
    Left = 332
    Top = 65535
  end
  object tcCondition: TOvcTCComboBox
    AcceptActivationClick = True
    AutoAdvanceChar = False
    AutoAdvanceLeftRight = False
    Items.Strings = (
      #1053#1077' '#1079#1072#1076#1072#1085#1086
      #1053#1077' '#1085#1072#1095#1072#1083#1089#1103
      #1053#1072#1095#1072#1083#1089#1103
      #1053#1077' '#1086#1082#1086#1085#1095#1080#1083#1089#1103
      #1054#1082#1086#1085#1095#1080#1083#1089#1103)
    ShowHint = False
    MaxLength = 0
    SaveStringValue = False
    Style = csDropDownList
    Table = tblStage
    TextStyle = tsFlat
    UseRunTimeItems = False
    Left = 388
    Top = 65535
  end
  object tcStageName: TOvcTCString
    Access = otxReadOnly
    AutoAdvanceChar = False
    AutoAdvanceLeftRight = False
    MaxLength = 0
    ShowHint = False
    Table = tblStage
    TextStyle = tsFlat
    UseWordWrap = False
    UseASCIIZStrings = False
    Left = 360
    Top = 65535
  end
  object ImageList1: TImageList
    Left = 444
    Top = 65535
    Bitmap = {
      494C010101000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      FF000000FF000000FF000000FF000000FF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007F7F7F007F7F7F007F7F
      7F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007F7F7F007F7F7F007F7F
      7F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007F7F7F000000FF000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080007F7F7F000000FF00000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      000000000000000000000000000000000000FFFFFF0080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080007F7F7F007F7F7F00FFFFFF00FFFFFF0080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      80008000800080008000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F00FFFFFF00800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      80007F7F7F007F7F7F007F7F7F007F7F7F00FFFFFF00FFFFFF00800080008000
      8000800080008000800080008000800080000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000007F7F7F007F7F7F007F7F7F008000
      80008000800080008000800080007F7F7F007F7F7F007F7F7F00FFFFFF00FFFF
      FF00800080008000800080008000800080008000800080008000800080008000
      800080008000800080008000800080008000800080007F7F7F007F7F7F007F7F
      7F007F7F7F00800080007F7F7F007F7F7F007F7F7F007F7F7F00FFFFFF008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      FF0000000000000000000000000000000000800080007F7F7F007F7F7F007F7F
      7F00FFFFFF00FFFFFF0080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080007F7F7F007F7F7F007F7F7F00FFFF
      FF00FFFFFF008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      80008000800080008000800080007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000FF000000000000000000000000008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080007F7F
      7F007F7F7F007F7F7F00FFFFFF00FFFFFF008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      80008000800080008000800080008000800080008000800080007F7F7F007F7F
      7F007F7F7F00FFFFFF00FFFFFF00800080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      8000800080008000800080008000800080008000800080008000800080008000
      800080008000800080008000800080008000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFF80FFFFFF00FFFFFF80FFFFFF00
      F9FFFF80FFFFFF00F0FFFF80FFFFFF00F0FFFF80FFFFFF00E07FFF80FFFFFF00
      C07FFF80FFFFFF00843FFF80FFFFFF001E3FFF80FFFFFF00FE1FFF80FFFFFF00
      FF1FFF80FFFFFF00FF8FFF80FFFFFF00FFC7FF00DFDFDF00FFE3FF00FFFFFF00
      FFF8000000000000FFFF2E200000000000000000000000000000000000000000
      000000000000}
  end
  object MainPopupMenu: TPopupMenu
    Left = 416
    Top = 65535
  end
end
