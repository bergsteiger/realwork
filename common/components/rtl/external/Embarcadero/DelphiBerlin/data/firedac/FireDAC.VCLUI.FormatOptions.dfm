object frmFDGUIxFormsFormatOptions: TfrmFDGUIxFormsFormatOptions
  Left = 0
  Top = 0
  Width = 577
  Height = 553
  Hint = 'Format Options'
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  TabStop = True
  object mo_GroupBox1: TPanel
    Left = 0
    Top = 0
    Width = 561
    Height = 194
    Caption = ' Data Mapping Rules '
    TabOrder = 2
    object mo_Panel3: TPanel
      Left = 1
      Top = 26
      Width = 559
      Height = 167
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 12
      TabOrder = 0
      object mo_sgMapRules: TStringGrid
        Left = 12
        Top = 12
        Width = 535
        Height = 113
        Align = alClient
        ColCount = 10
        DefaultRowHeight = 19
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
        TabOrder = 0
        OnEnter = mo_sgMapRulesEnter
        OnKeyDown = mo_sgMapRulesKeyDown
        OnSelectCell = mo_sgMapRulesSelectCell
        OnTopLeftChanged = mo_sgMapRulesTopLeftChanged
      end
      object mo_cbxDataType: TComboBox
        Left = 76
        Top = 30
        Width = 66
        Height = 21
        Style = csDropDownList
        TabOrder = 1
        Visible = False
        OnExit = mo_cbxDataTypeExit
        OnKeyDown = mo_cbxDataTypeKeyDown
        Items.Strings = (
          'dtUnknown'
          'dtBoolean'
          'dtSByte'
          'dtInt16'
          'dtInt32'
          'dtInt64'
          'dtByte'
          'dtUInt16'
          'dtUInt32'
          'dtUInt64'
          'dtSingle'
          'dtDouble'
          'dtExtended'
          'dtCurrency'
          'dtBCD'
          'dtFmtBCD'
          'dtDateTime'
          'dtTime'
          'dtDate'
          'dtDateTimeStamp'
          'dtTimeIntervalFull'
          'dtTimeIntervalYM'
          'dtTimeIntervalDS'
          'dtAnsiString'
          'dtWideString'
          'dtByteString'
          'dtBlob'
          'dtMemo'
          'dtWideMemo'
          'dtXML'
          'dtHBlob'
          'dtHMemo'
          'dtWideHMemo'
          'dtHBFile'
          'dtRowSetRef'
          'dtCursorRef'
          'dtRowRef'
          'dtArrayRef'
          'dtParentRowRef'
          'dtGUID'
          'dtObject')
      end
      object mo_Panel2: TPanel
        Left = 12
        Top = 125
        Width = 535
        Height = 30
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object mo_btnAddRule: TSpeedButton
          Left = 0
          Top = 8
          Width = 77
          Height = 22
          Caption = '&Add Rule'
          Flat = True
          OnClick = mo_btnAddRuleClick
        end
        object mo_btnRemRule: TSpeedButton
          Left = 82
          Top = 8
          Width = 77
          Height = 22
          Caption = '&Delete Rule'
          Flat = True
          OnClick = mo_btnRemRuleClick
        end
      end
    end
    object mo_Panel5: TPanel
      Left = 1
      Top = 1
      Width = 559
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object mo_cbOwnMapRules: TCheckBox
        Left = 11
        Top = 7
        Width = 199
        Height = 17
        Caption = 'I&gnore inherited rules'
        TabOrder = 0
        OnClick = mo_cbOwnMapRulesClick
      end
    end
  end
  object mo_gb1: TPanel
    Left = 250
    Top = 200
    Width = 244
    Height = 83
    Caption = ' Handling BCD / FmtBCD Type '
    TabOrder = 0
    object mo_Label2: TLabel
      Left = 11
      Top = 35
      Width = 93
      Height = 13
      Caption = 'Maximum &precision:'
      FocusControl = mo_edtMaxBcdPrecision
    end
    object mo_Label3: TLabel
      Left = 11
      Top = 10
      Width = 75
      Height = 13
      Caption = 'Maximum &scale:'
      FocusControl = mo_edtMaxBcdScale
    end
    object mo_edtMaxBcdPrecision: TEdit
      Left = 107
      Top = 32
      Width = 125
      Height = 21
      TabOrder = 1
      OnChange = mo_Change
    end
    object mo_edtMaxBcdScale: TEdit
      Left = 107
      Top = 7
      Width = 125
      Height = 21
      TabOrder = 0
      OnChange = mo_Change
    end
    object mo_cbDataSnapCompatibility: TCheckBox
      Left = 11
      Top = 57
      Width = 167
      Height = 17
      Caption = '&DataSnap Compatibility'
      TabOrder = 2
      OnClick = mo_Change
    end
  end
  object mo_gb2: TPanel
    Left = 0
    Top = 199
    Width = 244
    Height = 138
    Caption = ' Handling String Type '
    TabOrder = 1
    object mo_Label1: TLabel
      Left = 11
      Top = 3
      Width = 96
      Height = 26
      Caption = 'Convert to memo if '#13#10'size is greater than:'
      FocusControl = mo_edtMaxStringSize
    end
    object mo_Label10: TLabel
      Left = 11
      Top = 30
      Width = 95
      Height = 26
      Caption = 'Store data &Inline if '#13#10'size is less or equal:'
      FocusControl = mo_edtInlineDataSize
    end
    object mo_cbStrsEmpty2Null: TCheckBox
      Left = 11
      Top = 63
      Width = 167
      Height = 17
      Caption = '&Convert empty strings to Null'
      TabOrder = 2
      OnClick = mo_Change
    end
    object mo_cbStrsTrim: TCheckBox
      Left = 11
      Top = 88
      Width = 167
      Height = 17
      Caption = '&Trim fixed length strings'
      TabOrder = 3
      OnClick = mo_Change
    end
    object mo_edtMaxStringSize: TEdit
      Left = 107
      Top = 7
      Width = 125
      Height = 21
      TabOrder = 0
      OnChange = mo_Change
    end
    object mo_edtInlineDataSize: TEdit
      Left = 107
      Top = 34
      Width = 125
      Height = 21
      TabOrder = 1
      OnChange = mo_Change
    end
    object mo_cbStrsTrim2Len: TCheckBox
      Left = 11
      Top = 113
      Width = 167
      Height = 17
      Caption = 'T&rim strings at maximum length'
      TabOrder = 4
      OnClick = mo_Change
    end
  end
  object mo_Panel6: TPanel
    Left = 304
    Top = 289
    Width = 244
    Height = 40
    Caption = ' Parameters Default Type '
    TabOrder = 3
    object mo_Label6: TLabel
      Left = 11
      Top = 10
      Width = 52
      Height = 13
      Caption = 'Data t&ype:'
      FocusControl = mo_cbDefaultParamDataType
    end
    object mo_cbDefaultParamDataType: TComboBox
      Left = 107
      Top = 7
      Width = 125
      Height = 21
      TabOrder = 0
      OnChange = mo_Change
      Items.Strings = (
        'ftUnknown'
        'ftString'
        'ftSmallint'
        'ftInteger'
        'ftWord'
        'ftBoolean'
        'ftFloat'
        'ftCurrency'
        'ftBCD'
        'ftDate'
        'ftTime'
        'ftDateTime'
        'ftBytes'
        'ftVarBytes'
        'ftAutoInc'
        'ftBlob'
        'ftMemo'
        'ftGraphic'
        'ftFmtMemo'
        'ftParadoxOle'
        'ftDBaseOle'
        'ftTypedBinary'
        'ftCursor'
        'ftFixedChar'
        'ftWideString'
        'ftLargeint'
        'ftADT'
        'ftArray'
        'ftReference'
        'ftDataSet'
        'ftOraBlob'
        'ftOraClob'
        'ftVariant'
        'ftInterface'
        'ftIDispatch'
        'ftGuid'
        'ftTimeStamp'
        'ftFMTBcd'
        'ftFixedWideChar'
        'ftWideMemo'
        'ftOraTimeStamp'
        'ftOraInterval')
    end
  end
  object mo_Panel7: TPanel
    Left = 37
    Top = 327
    Width = 476
    Height = 57
    Caption = ' Values Preprocessing'
    TabOrder = 4
    object mo_cbRound2Scale: TCheckBox
      Left = 11
      Top = 8
      Width = 462
      Height = 17
      Caption = 'Round time and num values to specified scale'
      TabOrder = 0
      OnClick = mo_Change
    end
    object mo_cbCheckPrecision: TCheckBox
      Left = 11
      Top = 31
      Width = 462
      Height = 17
      Caption = 'Check numeric values precision'
      TabOrder = 1
      OnClick = mo_Change
    end
  end
  object mo_Panel1: TPanel
    Left = 13
    Top = 404
    Width = 244
    Height = 146
    Caption = ' Default Field Formats'
    TabOrder = 5
    object mo_Label15: TLabel
      Left = 11
      Top = 10
      Width = 63
      Height = 13
      Caption = 'Date display:'
      FocusControl = mo_edtFmtDisplayDate
    end
    object mo_Label16: TLabel
      Left = 11
      Top = 37
      Width = 62
      Height = 13
      Caption = 'Time display:'
      FocusControl = mo_edtFmtDisplayTime
    end
    object mo_Label17: TLabel
      Left = 11
      Top = 64
      Width = 85
      Height = 13
      Caption = 'DateTime display:'
      FocusControl = mo_edtFmtDisplayDateTime
    end
    object mo_Label18: TLabel
      Left = 11
      Top = 91
      Width = 78
      Height = 13
      Caption = 'Numeric display:'
      FocusControl = mo_edtFmtDisplayNum
    end
    object mo_Label19: TLabel
      Left = 11
      Top = 118
      Width = 63
      Height = 13
      Caption = 'Numeric edit:'
      FocusControl = mo_edtFmtEditNum
    end
    object mo_edtFmtDisplayDate: TEdit
      Left = 107
      Top = 7
      Width = 125
      Height = 21
      TabOrder = 0
      OnChange = mo_Change
    end
    object mo_edtFmtDisplayTime: TEdit
      Left = 107
      Top = 34
      Width = 125
      Height = 21
      TabOrder = 1
      OnChange = mo_Change
    end
    object mo_edtFmtDisplayDateTime: TEdit
      Left = 107
      Top = 61
      Width = 125
      Height = 21
      TabOrder = 2
      OnChange = mo_Change
    end
    object mo_edtFmtDisplayNum: TEdit
      Left = 107
      Top = 88
      Width = 125
      Height = 21
      TabOrder = 3
      OnChange = mo_Change
    end
    object mo_edtFmtEditNum: TEdit
      Left = 107
      Top = 115
      Width = 125
      Height = 21
      TabOrder = 4
      OnChange = mo_Change
    end
  end
end
