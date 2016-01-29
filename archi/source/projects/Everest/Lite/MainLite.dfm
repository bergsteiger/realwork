inherited MainFormLite: TMainFormLite
  Left = 235
  Top = 189
  Width = 655
  Height = 495
  Caption = #1069#1074#1077#1088#1077#1089#1090
  Font.Color = clBlack
  Menu = MainMenu
  Position = poDefault
  Scaled = False
  ShowHint = True
  WindowMenu = miWindow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusLine: TvtHeader [0]
    Left = 0
    Top = 415
    Width = 639
    Height = 22
    Align = alBottom
    BevelInner = bvLowered
    BevelWidth = 2
    BorderStyle = bsNone
    Font.Name = 'Arial CYR'
    OnSizing = StatusLineSizing
    Sections = <
      item
        Width = 380
        AutoResize = False
        MinWidth = 20
        MaxWidth = 2147483647
      end
      item
        Width = 152
        AutoResize = False
        MinWidth = 20
        MaxWidth = 2147483647
      end
      item
        Width = 20
        AutoResize = False
        MinWidth = 20
        MaxWidth = 2147483647
      end>
    TabOrder = 0
    object pnMemory: TLabel
      Left = 535
      Top = 4
      Width = 121
      Height = 18
      AutoSize = False
      OnDblClick = pnMemoryDblClick
    end
    object Progress: TvtW95Meter
      Left = 384
      Top = 4
      Width = 144
      Height = 12
      EdgeStyle = st95None
      Visible = False
    end
  end
  object dcTop: TDock97 [1]
    Left = 0
    Top = 0
    Width = 639
    Height = 83
    BoundLines = [blTop]
    SmartAlign = False
    object tbAdd: TToolbar97
      Left = 269
      Top = 27
      Width = 59
      Height = 27
      Caption = #1042#1089#1090#1072#1074#1082#1072'/'#1091#1076#1072#1083#1077#1085#1080#1077
      DockPos = 269
      DockRow = 1
      TabOrder = 0
      object btInsert: TevButton
        Left = 0
        Operation = ev_ccInsert
        ImageIndex = 207
        Images = dmStandardRes.ilOffice
      end
      object btDelete: TevButton
        Left = 23
        Operation = ev_ccDelete
        ImageIndex = 206
        Images = dmStandardRes.ilOffice
      end
    end
    object tbUndo: TToolbar97
      Left = 151
      Width = 59
      Height = 27
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100'/'#1074#1077#1088#1085#1091#1090#1100
      DockPos = 151
      TabOrder = 1
      object btUndo: TevButton
        Left = 0
        Operation = ev_ccUndo
        ImageIndex = 21
        Images = dmStandardRes.ilOffice
      end
      object btRedo: TevButton
        Left = 23
        Operation = ev_ccRedo
        ImageIndex = 22
        Images = dmStandardRes.ilOffice
      end
    end
    object tbJustification: TToolbar97
      Left = 36
      Top = 27
      Width = 128
      Height = 27
      Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077
      DockPos = 36
      DockRow = 1
      TabOrder = 2
      object btLeft: TevButton
        Left = 0
        Operation = ev_ccJustifyLeft
        GroupIndex = 1
        ImageIndex = 123
        Images = dmStandardRes.ilOffice
      end
      object btCenter: TevButton
        Left = 23
        Operation = ev_ccJustifyCenter
        GroupIndex = 1
        ImageIndex = 124
        Images = dmStandardRes.ilOffice
      end
      object btRight: TevButton
        Left = 46
        Operation = ev_ccJustifyRight
        GroupIndex = 1
        ImageIndex = 125
        Images = dmStandardRes.ilOffice
      end
      object btWidth: TevButton
        Left = 69
        Operation = ev_ccJustifyWidth
        GroupIndex = 1
        Down = True
        ImageIndex = 126
        Images = dmStandardRes.ilOffice
      end
      object btPreformatted: TevButton
        Left = 92
        Operation = ev_ccJustifyPreformatted
        GroupIndex = 1
        ImageIndex = 204
        Images = dmStandardRes.ilOffice
      end
    end
    object tbFont: TToolbar97
      Left = 0
      Top = 27
      Width = 36
      Height = 27
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1096#1088#1080#1092#1090#1072
      DockPos = 0
      DockRow = 1
      TabOrder = 3
      object btVisible: TevButton
        Left = 0
        Operation = ev_ccVisible
        AllowAllUp = True
        GroupIndex = 5
        ImageIndex = 203
        Images = dmStandardRes.ilOffice
      end
    end
    object tbView: TToolbar97
      Left = 374
      Width = 128
      Height = 27
      Caption = #1042#1080#1076
      DockPos = 374
      TabOrder = 4
      object btShowSpecial: TevButton
        Left = 0
        Operation = ev_ccShowSpecial
        AllowAllUp = True
        GroupIndex = 7
        ImageIndex = 39
        Images = dmStandardRes.ilOffice
      end
      object btWebStyle: TevButton
        Left = 69
        Operation = ev_ccWebStyle
        AllowAllUp = True
        GroupIndex = 8
        ImageIndex = 49
        Images = dmStandardRes.ilOffice
      end
      object btPrintPreview: TevButton
        Left = 46
        Operation = ev_ccPrintPreview
        AllowAllUp = True
        GroupIndex = 8
        ImageIndex = 11
        Images = dmStandardRes.ilOffice
      end
      object btPersistent: TevButton
        Left = 115
        Width = 0
        Operation = ev_ccPersistent
        AllowAllUp = True
        GroupIndex = 10
        DisplayMode = dmTextOnly
        Caption = 'P'
      end
      object btAdjustMargin: TevButton
        Left = 115
        Width = 0
        Action = acAdjustMargin
        AllowAllUp = True
        GroupIndex = 11
        DisplayMode = dmTextOnly
      end
      object btShowDocumentParts: TevButton
        Left = 23
        Operation = ev_ccShowDocumentParts
        AllowAllUp = True
        GroupIndex = 14
        ImageIndex = 9
        Images = dmStandardRes.ilCommon
      end
      object btDrawLines: TevButton
        Left = 92
        Operation = ev_ccDrawLines
        AllowAllUp = True
        GroupIndex = 15
        ImageIndex = 182
        Images = dmStandardRes.ilOffice
      end
    end
    object tbFile: TToolbar97
      Left = 0
      Width = 151
      Height = 27
      Caption = #1060#1072#1081#1083#1086#1074#1099#1077' '#1086#1087#1077#1088#1072#1094#1080#1080
      DockPos = 0
      TabOrder = 5
      object btNew: TevButton
        Left = 0
        Operation = ev_ccNew
        ImageIndex = 0
        Images = dmStandardRes.ilOffice
      end
      object btOpen: TevButton
        Left = 23
        Operation = ev_ccOpen
        ImageIndex = 3
        Images = dmStandardRes.ilOffice
      end
      object btSave: TevButton
        Left = 46
        Operation = ev_ccSave
        ImageIndex = 5
        Images = dmStandardRes.ilOffice
      end
      object btSaveAll: TevButton
        Left = 69
        Operation = ev_ccSaveAll
        Glyph.Data = {
          2E070000424D2E07000000000000360400002800000026000000130000000100
          080000000000F802000000000000000000000001000000010000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A60000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          800000800000008080008000000080008000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070707070707
          0707070707070707070707070707070707070707070707070707070707070707
          0000070707070707070707070707070707070707070707070F0F0F0F0F0F0F0F
          0F0F070707070707000007070700000000000000000000070707070707070707
          181818181818181818180F070707070700000707000E0E0000000007000E0007
          07070707070707180F07181818180F180F180F0F0707070700000707000E0E00
          00000007000E000000070707070707180F07181818180F180F1818180F070707
          00000707000E0E0000000000000E000E00070707070707180F07181818181818
          0F180F180F0F070700000707000E0E0E0E0E0E0E0E0E000E0000000707070718
          0F070F0F0F0F0F0F0F180F1818180F0700000707000E0E00000000000E0E000E
          000E0007070707180F0718181818180F0F180F180F180F0700000707000E0007
          07070707000E000E000E0007070707180F180F07070707180F180F180F180F07
          00000707000E000707070707000E000E000E0007070707180F180F0707070718
          0F180F180F180F0700000707000E0007070707070000000E000E000707070718
          0F180F070707071818180F180F180F0700000707000E0007070707070007000E
          000E0007070707180F180F07070707180F180F180F180F070000070700000000
          0000000000000000000E0007070707181818181818181818181818180F180F07
          000007070707000E0007070707070007000E00070707070707180F180F0F0F0F
          0F180F180F180F07000007070707000000000000000000000000000707070707
          07181818181818181818181818180F070000070707070707000E000707070707
          0007000707070707070707180F180F0F0F0F0F180F180F070000070707070707
          0000000000000000000000070707070707070718181818181818181818180707
          0000070707070707070707070707070707070707070707070707070707070707
          0707070707070707000007070707070707070707070707070707070707070707
          070707070707070707070707070707070000}
        NumGlyphs = 2
      end
      object btPrint: TevButton
        Left = 92
        Operation = ev_ccPrintEx
        ImageIndex = 12
        Images = dmStandardRes.ilOffice
      end
      object btGroup: TevButton
        Left = 115
        Operation = ev_ccGroup
        Glyph.Data = {
          2E070000424D2E07000000000000360400002800000026000000130000000100
          080000000000F802000000000000000000000001000000010000000000000000
          80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
          A60000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
          800000800000008080008000000080008000F0FBFF00A4A0A000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070707070707
          0707070707070707070707070707070F0F0F0F0F0F0F0F0F0F07070707070707
          0000070000000000000000000007070707070707070718181818181818181818
          0F07070707070707000007000F0F0F0F0F0F0F0F00070707070707070707180F
          07070707070707180F0F0F0F07070707000007000F0F0F0F0F0F0F0F00000000
          070707070707180F07070707070707181818180F07070707000007000F0F0F0F
          0F0F0F0F000F0F00070707070707180F07070707070707180F07180F0F0F0F07
          000007000F0F0F0F0F0F0F0F000F0F00000000070707180F0707070707070718
          0F07181818180F07000007000F0F0F0F0F0F0F0F000F0F000F0F00070707180F
          07070707070707180F07180F07180F07000007000F0F0F0F0F0F0F0F000F0F00
          0F0F00070707180F07070707070707180F07180F07180F07000007000F0F0F0F
          0F0F0F0F000F0F000F0F00070707180F070707070F0F0F180F07180F07180F07
          000007000F0F0F0F0F000000000F0F000F0F00070707180F0707070718181818
          0F07180F07180F07000007000F0F0F0F0F000F000F0F0F000F0F00070707180F
          07070707180F18070707180F07180F07000007000F0F0F0F0F00000F00000000
          0F0F00070707180F0F0F0F0F181807181818180F07180F070000070000000000
          00000F0F000F000F0F0F00070707181818181818180707180F18070707180F07
          000007070707000F0F0F0F0F00000F00000000070707070707180F0F0F0F0F18
          1807181818180707000007070707000000000000000F0F000F00070707070707
          07181818181818180707180F18070707000007070707070707000F0F0F0F0F00
          000707070707070707070707180F0F0F0F0F1818070707070000070707070707
          0700000000000000070707070707070707070707181818181818180707070707
          0000070707070707070707070707070707070707070707070707070707070707
          0707070707070707000007070707070707070707070707070707070707070707
          070707070707070707070707070707070000}
        NumGlyphs = 2
      end
    end
    object tbEdit: TToolbar97
      Left = 210
      Width = 82
      Height = 27
      Caption = #1054#1087#1077#1088#1072#1094#1080#1080' '#1089' '#1073#1091#1092#1077#1088#1086#1084' '#1086#1073#1084#1077#1085#1072
      DockPos = 210
      TabOrder = 6
      object btCut: TevButton
        Left = 0
        Operation = ev_ccCut
        ImageIndex = 24
        Images = dmStandardRes.ilOffice
      end
      object btCopy: TevButton
        Left = 23
        Operation = ev_ccCopy
        ImageIndex = 25
        Images = dmStandardRes.ilOffice
      end
      object btPaste: TevButton
        Left = 46
        Operation = ev_ccPaste
        ImageIndex = 26
        Images = dmStandardRes.ilOffice
      end
    end
    object tbSearchReplace: TToolbar97
      Left = 292
      Width = 82
      Height = 27
      Caption = #1055#1086#1080#1089#1082
      DockPos = 292
      TabOrder = 7
      object btSearch: TevButton
        Left = 0
        Operation = ev_ccSearch
        ImageIndex = 28
        Images = dmStandardRes.ilOffice
      end
      object btSearchAgain: TevButton
        Left = 23
        Operation = ev_ccSearchAgain
        ImageIndex = 29
        Images = dmStandardRes.ilOffice
      end
      object btSpellcheck: TevButton
        Left = 46
        Operation = ev_ccSpellcheck
        ImageIndex = 146
        Images = dmStandardRes.ilOffice
      end
    end
    object tbTable: TToolbar97
      Left = 328
      Top = 27
      Width = 220
      Height = 27
      Caption = #1058#1072#1073#1083#1080#1094#1099
      DockPos = 328
      DockRow = 1
      TabOrder = 8
      object btInsertTable: TevButton
        Left = 0
        Operation = ev_ccInsertTable
        ImageIndex = 166
        Images = dmStandardRes.ilOffice
      end
      object btInsertRow: TevButton
        Left = 23
        Operation = ev_ccInsertRow
        ImageIndex = 169
        Images = dmStandardRes.ilOffice
      end
      object btInsertColumn: TevButton
        Left = 46
        Operation = ev_ccInsertColumn
        ImageIndex = 170
        Images = dmStandardRes.ilOffice
      end
      object btDeleteRow: TevButton
        Left = 69
        Operation = ev_ccDeleteRow
        ImageIndex = 172
        Images = dmStandardRes.ilOffice
      end
      object btDeleteColumn: TevButton
        Left = 92
        Operation = ev_ccDeleteColumn
        ImageIndex = 173
        Images = dmStandardRes.ilOffice
      end
      object btTest: TevButton
        Left = 207
        Width = 0
        DisplayMode = dmTextOnly
        Caption = '@'
        OnClick = btTestClick
      end
      object btMergeCells: TevButton
        Left = 115
        Operation = ev_ccMergeCells
        ImageIndex = 184
        Images = dmStandardRes.ilOffice
      end
      object btSplitCells: TevButton
        Left = 138
        Operation = ev_ccSplitCells
        ImageIndex = 185
        Images = dmStandardRes.ilOffice
      end
      object btHSplit: TevButton
        Left = 184
        Operation = ev_ccHSplit
        ImageIndex = 235
        Images = dmStandardRes.ilOffice
      end
      object btVSplit: TevButton
        Left = 161
        Operation = ev_ccVSplit
        ImageIndex = 234
        Images = dmStandardRes.ilOffice
      end
    end
    object tbStyle: TToolbar97
      Left = 0
      Top = 54
      Width = 160
      Height = 27
      Caption = #1057#1090#1080#1083#1100
      DockPos = 0
      DockRow = 2
      TabOrder = 9
      object StyleComboBox: TSpeedBarComboBox
        Left = 0
        Top = 0
        Width = 147
        Height = 22
        Hint = #1057#1090#1080#1083#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        TabOrder = 0
        TabStop = False
        OnChange = StyleComboBoxChange
        OnDropDown = StyleComboBoxDropDown
      end
    end
    object tbZoom: TToolbar97
      Left = 160
      Top = 54
      Width = 76
      Height = 27
      Caption = #1052#1072#1089#1096#1090#1072#1073
      DockPos = 160
      DockRow = 2
      TabOrder = 10
      object seZoom: TvtSpinEdit
        Left = 0
        Top = 0
        Width = 63
        Height = 23
        Hint = #1052#1072#1089#1096#1090#1072#1073
        TabStop = False
        MaxValue = 500.000000000000000000
        Value = 100.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnBottomClick = seZoomBottomClick
        OnTopClick = seZoomTopClick
        OnExit = seZoomExit
        OnKeyPress = seZoomKeyPress
      end
    end
    object tbVerticalAligment: TToolbar97
      Left = 548
      Top = 27
      Width = 82
      Height = 27
      Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077' '#1087#1086' '#1074#1077#1088#1090#1080#1082#1072#1083#1080
      DockPos = 571
      DockRow = 1
      TabOrder = 11
      object btTop: TevButton
        Left = 0
        Operation = ev_ccVAlignTop
        GroupIndex = 16
        ImageIndex = 186
        Images = dmStandardRes.ilOffice
      end
      object btVCenter: TevButton
        Left = 23
        Operation = ev_ccVAlignCenter
        GroupIndex = 16
        ImageIndex = 187
        Images = dmStandardRes.ilOffice
      end
      object btBottom: TevButton
        Left = 46
        Operation = ev_ccVAlignBottom
        GroupIndex = 16
        ImageIndex = 188
        Images = dmStandardRes.ilOffice
      end
    end
    object tbFormat: TToolbar97
      Left = 502
      Width = 82
      Height = 27
      Caption = #1054#1092#1086#1088#1084#1083#1077#1085#1080#1077
      DockPos = 548
      TabOrder = 12
      object btBordersAndShade: TevButton
        Left = 0
        Operation = ev_ccBordersAndShade
        Action = MainEditorForm.acBordersAndShade
        ImageIndex = 232
        Images = dmStandardRes.ilOffice
      end
      object btStyles: TevButton
        Left = 23
        Action = acEditStyles
        Images = dmStandardRes.ilOffice
      end
      object btHideHyperlinks: TevButton
        Left = 46
        Action = acHideHyperlinks
        AllowAllUp = True
        GroupIndex = 16
        Images = dmStandardRes.ilOffice
      end
    end
    object tbOutline: TToolbar97
      Left = 236
      Top = 54
      Width = 128
      Height = 27
      Caption = #1057#1090#1088#1091#1082#1090#1091#1088#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      DockPos = 236
      DockRow = 2
      TabOrder = 13
      object btShowLevel1: TevButton
        Tag = 1
        Left = 0
        Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1073#1083#1086#1082#1080' 1-'#1075#1086' '#1091#1088#1086#1074#1085#1103
        Operation = ev_ccShowDocumentPart
        GroupIndex = 11
        ImageIndex = 60
        Images = dmStandardRes.ilOffice
      end
      object btShowLevel2: TevButton
        Tag = 2
        Left = 23
        Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1073#1083#1086#1082#1080' 2-'#1075#1086' '#1091#1088#1086#1074#1085#1103
        Operation = ev_ccShowDocumentPart
        GroupIndex = 11
        ImageIndex = 61
        Images = dmStandardRes.ilOffice
      end
      object btShowLevel3: TevButton
        Tag = 3
        Left = 46
        Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1073#1083#1086#1082#1080' 3-'#1075#1086' '#1091#1088#1086#1074#1085#1103
        Operation = ev_ccShowDocumentPart
        GroupIndex = 11
        ImageIndex = 62
        Images = dmStandardRes.ilOffice
      end
      object btShowLevel4: TevButton
        Tag = 4
        Left = 69
        Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1073#1083#1086#1082#1080' 4-'#1075#1086' '#1091#1088#1086#1074#1085#1103
        Operation = ev_ccShowDocumentPart
        GroupIndex = 11
        ImageIndex = 63
        Images = dmStandardRes.ilOffice
      end
      object btShowLevel5: TevButton
        Tag = 5
        Left = 92
        Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1073#1083#1086#1082#1080' 5-'#1075#1086' '#1091#1088#1086#1074#1085#1103
        Operation = ev_ccShowDocumentPart
        GroupIndex = 11
        ImageIndex = 64
        Images = dmStandardRes.ilOffice
      end
      object btShowAllLevels: TevButton
        Left = 115
        Width = 0
        Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077' '#1073#1083#1086#1082#1080
        Operation = ev_ccShowDocumentPart
        GroupIndex = 11
        DisplayMode = dmTextOnly
        Down = True
        Caption = 'All'
      end
    end
    object tbList: TToolbar97
      Left = 164
      Top = 27
      Width = 105
      Height = 27
      Caption = #1057#1087#1080#1089#1082#1080
      DockPos = 164
      DockRow = 1
      TabOrder = 14
      object btBullet: TToolbarButton97
        Left = 0
        Top = 0
        Width = 23
        Height = 22
        Action = acBullet
        AllowAllUp = True
        GroupIndex = 4
        DisplayMode = dmGlyphOnly
        Images = dmStandardRes.ilOffice
      end
      object btIncIndent: TToolbarButton97
        Left = 69
        Top = 0
        Width = 23
        Height = 22
        Action = acIncIndent
        DisplayMode = dmGlyphOnly
        Images = dmStandardRes.ilOffice
      end
      object btDecIndent: TToolbarButton97
        Left = 46
        Top = 0
        Width = 23
        Height = 22
        Action = acDecIndent
        DisplayMode = dmGlyphOnly
        Images = dmStandardRes.ilOffice
      end
      object btNumber: TToolbarButton97
        Left = 23
        Top = 0
        Width = 23
        Height = 22
        Action = acNumber
        AllowAllUp = True
        GroupIndex = 4
        DisplayMode = dmGlyphOnly
        Images = dmStandardRes.ilOffice
      end
    end
  end
  object dcLeft: TDock97 [2]
    Left = 0
    Top = 83
    Width = 9
    Height = 307
    BoundLines = [blLeft]
    Position = dpLeft
    SmartAlign = False
  end
  inherited tsDocuments: TTabSet
    Top = 390
    Width = 639
  end
  object dcBottom: TDock97 [4]
    Left = 0
    Top = 406
    Width = 639
    Height = 9
    BoundLines = [blBottom]
    Position = dpBottom
    SmartAlign = False
  end
  object MainMenu: TMainMenu [6]
    Images = dmStandardRes.ilOffice
    Left = 456
    Top = 137
    object miFile: TevMenuItem
      Caption = '&'#1044#1086#1082#1091#1084#1077#1085#1090#1099
      SubMenuImages = dmStandardRes.ilOffice
      Hint = #1050#1086#1084#1072#1085#1076#1099' '#1091#1087#1088#1072#1074#1083#1077#1085#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1084#1080
      object miFileNew: TevMenuItem
        Caption = '&'#1053#1086#1074#1099#1081
        Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
        ImageIndex = 0
        Operation = ev_ccNew
      end
      object miFileOpen: TevMenuItem
        Caption = '&'#1054#1090#1082#1088#1099#1090#1100'...'
        Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
        ImageIndex = 3
        ShortCut = 114
        Operation = ev_ccOpen
      end
      object miFileClose: TevMenuItem
        Caption = '&'#1047#1072#1082#1088#1099#1090#1100
        Hint = #1047#1072#1082#1088#1099#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
        ImageIndex = 4
        ShortCut = 32882
        OnClick = miFileCloseClick
      end
      object miFileSave: TevMenuItem
        Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
        Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1086#1090#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1085#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
        ImageIndex = 5
        ShortCut = 113
        Operation = ev_ccSave
      end
      object miFileSaveAs: TevMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' &'#1074'...'
        Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1086#1090#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1085#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' '#1089' '#1076#1088#1091#1075#1080#1084' '#1080#1084#1077#1085#1077#1084
        ImageIndex = 217
        ShortCut = 32881
        Operation = ev_ccSaveAs
      end
      object N8: TevMenuItem
        Caption = '-'
      end
      object miFilePrint: TevMenuItem
        Caption = #1055#1077#1095#1072#1090#1100
        Hint = #1055#1077#1095#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        ImageIndex = 12
        Operation = ev_ccPrint
      end
      object miFileProperties: TMenuItem
        Caption = #1057#1074#1086#1081#1089#1090#1074#1072
        ImageIndex = 231
        OnClick = miFilePropertiesClick
      end
      object miPrintPreview: TMenuItem
        Action = acPrintPreview
      end
      object miFileBatchPrint: TevMenuItem
        Caption = #1060#1086#1085#1086#1074#1072#1103' '#1087#1077#1095#1072#1090#1100'...'
        OnClick = miFileBatchPrintClick
      end
      object N1: TevMenuItem
        Caption = '-'
        Visible = False
      end
      object miFileSend: TMenuItem
        Action = acSendDocument
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object miFileExit: TevMenuItem
        Caption = #1042#1099'&'#1093#1086#1076
        Hint = #1047#1072#1082#1086#1085#1095#1080#1090#1100' '#1088#1072#1073#1086#1090#1091' '#1089' '#1087#1088#1086#1075#1088#1072#1084#1084#1086#1081
        ImageIndex = 209
        ShortCut = 32856
        OnClick = miFileExitClick
      end
      object miMRUBreak: TMenuItem
        Caption = '-'
        Visible = False
      end
      object miMRU: TMenuItem
        Caption = 'MRU'
        Hint = #1056#1072#1085#1077#1077' '#1086#1090#1082#1088#1099#1074#1072#1074#1096#1080#1077#1089#1103' '#1092#1072#1081#1083#1099
        ImageIndex = 222
        Visible = False
      end
    end
    object MI_Text: TevMenuItem
      Caption = #1058#1077#1082#1089#1090
      SubMenuImages = dmStandardRes.ilOffice
      GroupIndex = 1
      Hint = #1050#1086#1084#1072#1085#1076#1099' '#1091#1087#1088#1072#1074#1083#1077#1085#1080#1103' '#1090#1077#1082#1089#1090#1086#1084
      object MIUndo: TevMenuItem
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100
        Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1086#1087#1077#1088#1072#1094#1080#1102
        ImageIndex = 21
        ShortCut = 16474
        Operation = ev_ccUndo
      end
      object MIRedo: TevMenuItem
        Caption = #1042#1077#1088#1085#1091#1090#1100
        Hint = #1042#1077#1088#1085#1091#1090#1100' '#1086#1087#1077#1088#1072#1094#1080#1102
        ImageIndex = 22
        ShortCut = 24666
        Operation = ev_ccRedo
      end
      object MISplitLine1: TevMenuItem
        Caption = '-'
      end
      object MICut: TevMenuItem
        Caption = #1042#1099#1088#1077#1079#1072#1090#1100
        Hint = #1042#1099#1088#1077#1079#1072#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1090#1077#1082#1089#1090
        ImageIndex = 24
        ShortCut = 16472
        Operation = ev_ccCut
      end
      object MICopy: TevMenuItem
        Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
        Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1090#1077#1082#1089#1090' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
        ImageIndex = 25
        ShortCut = 16451
        Operation = ev_ccCopy
      end
      object MIPaste: TevMenuItem
        Caption = #1042#1089#1090#1072#1074#1080#1090#1100
        Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079' '#1073#1091#1092#1077#1088#1072' '#1086#1073#1084#1077#1085#1072
        ImageIndex = 26
        ShortCut = 16470
        Operation = ev_ccPaste
      end
      object miSpecialPaste: TevMenuItem
        Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1072#1103' '#1074#1089#1090#1072#1074#1082#1072'...'
        Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079' '#1073#1091#1092#1077#1088#1072' '#1086#1073#1084#1077#1085#1072' '#1089' '#1074#1099#1073#1086#1088#1086#1084' '#1092#1086#1088#1084#1072#1090#1072
        ImageIndex = 220
        Operation = ev_ccSpecialPaste
      end
      object MIAddToClipboard: TevMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082' '#1073#1091#1092#1077#1088#1091' '#1086#1073#1084#1077#1085#1072
        ShortCut = 24621
        Operation = ev_ccAdd
      end
      object miDelete: TevMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1090#1077#1082#1089#1090
        ImageIndex = 206
        ShortCut = 16430
        Operation = ev_ccDelete
      end
      object N9: TevMenuItem
        Caption = '-'
      end
      object miSelectAll: TevMenuItem
        Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
        Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1077#1089#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
        ImageIndex = 218
        ShortCut = 16449
        Operation = ev_ccSelectAll
      end
      object miHideSelection: TevMenuItem
        Caption = #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
        Hint = #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
        ImageIndex = 219
        ShortCut = 24641
        Operation = ev_ccHideSelection
      end
      object miSelectPara: TevMenuItem
        Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1087#1072#1088#1072#1075#1088#1072#1092
        Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1087#1072#1088#1072#1075#1088#1072#1092
        ShortCut = 16464
        Operation = ev_ccSelectPara
      end
      object miSelectWord: TevMenuItem
        Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1089#1083#1086#1074#1086
        Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1089#1083#1086#1074#1086
        ShortCut = 16471
        Operation = ev_ccSelectWord
      end
      object N10: TevMenuItem
        Caption = '-'
      end
      object miConversion: TevMenuItem
        Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103
        GroupIndex = 2
        object miTextTextToPara: TevMenuItem
          Action = acText2Para
        end
        object N6: TevMenuItem
          Caption = '-'
        end
        object miUpCase: TevMenuItem
          Action = acLo2Up
        end
        object miLoCase: TevMenuItem
          Action = acUp2Lo
        end
        object miSwapLoUp: TevMenuItem
          Action = acSwapLoUp
        end
      end
    end
    object miView: TMenuItem
      Caption = #1042#1080#1076
      GroupIndex = 1
      object miViewShowDocumentParts: TevMenuItem
        AutoCheck = True
        Caption = #1057#1090#1088#1091#1082#1090#1091#1088#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1089#1090#1088#1091#1082#1090#1091#1088#1091' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        ImageIndex = 236
        Operation = ev_ccShowDocumentParts
      end
      object miViewShowSpecial: TevMenuItem
        AutoCheck = True
        Caption = #1057#1087#1077#1094#1089#1080#1084#1074#1086#1083#1099
        Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1089#1087#1077#1094#1089#1080#1084#1074#1086#1083#1099
        ImageIndex = 39
        Operation = ev_ccShowSpecial
      end
      object miViewPrintPreview: TevMenuItem
        AutoCheck = True
        Caption = #1055#1086' '#1087#1088#1080#1085#1090#1077#1088#1091
        Hint = #1060#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1084#1077#1090#1088#1080#1082#1072#1084' '#1087#1088#1080#1085#1090#1077#1088#1072
        ImageIndex = 11
        Operation = ev_ccPrintPreview
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object miViewPanels: TMenuItem
        Caption = #1055#1072#1085#1077#1083#1080' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074
      end
    end
    object miInsert: TevMenuItem
      Caption = #1042#1089#1090#1072#1074#1082#1072
      SubMenuImages = dmStandardRes.ilOffice
      GroupIndex = 2
      object miSubs: TevMenuItem
        Caption = #1052#1077#1090#1082#1080
        SubMenuImages = dmStandardRes.ilCommon
        GroupIndex = 2
        Hint = #1054#1087#1077#1088#1072#1094#1080#1080' '#1089' '#1090#1086#1095#1082#1072#1084#1080' '#1074#1093#1086#1076#1072
        object miAddSub: TevMenuItem
          Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100'...'
          Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1090#1086#1095#1082#1091' '#1074#1093#1086#1076#1072' ('#1103#1082#1086#1088#1100')'
          ImageIndex = 8
          OnClick = miAddSubClick
        end
        object miDelSub: TevMenuItem
          Caption = #1059#1076#1072#1083#1080#1090#1100
          Hint = #1059#1076#1072#1083#1080#1090#1100' '#1090#1086#1095#1082#1091' '#1074#1093#1086#1076' ('#1103#1082#1086#1088#1100')'
          OnClick = miDelSubClick
        end
      end
      object miHyperLink: TevMenuItem
        Caption = #1057#1089#1099#1083#1082#1080
        SubMenuImages = dmStandardRes.ilOffice
        GroupIndex = 2
        Hint = #1054#1087#1077#1088#1072#1094#1080#1080' '#1089#1086' '#1089#1089#1099#1083#1082#1072#1084#1080
        object miInsertHyperLink: TevMenuItem
          Caption = #1042#1089#1090#1072#1074#1080#1090#1100'...'
          Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1089#1089#1099#1083#1082#1091
          ImageIndex = 32
          OnClick = miInsertHyperLinkClick
        end
        object miDeleteHyperLink: TevMenuItem
          Caption = #1059#1076#1072#1083#1080#1090#1100
          Hint = #1059#1076#1072#1083#1080#1090#1100' '#1089#1089#1099#1083#1082#1091
          ImageIndex = 33
          OnClick = miDeleteHyperLinkClick
        end
      end
      object N12: TevMenuItem
        Caption = '-'
        GroupIndex = 2
      end
      object miSideBySide: TevMenuItem
        Caption = #1055#1086#1076#1087#1080#1089#1100
        GroupIndex = 2
        Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1087#1086#1076#1087#1080#1089#1100
        ImageIndex = 208
        Operation = ev_ccInsertSBS
      end
      object N13: TevMenuItem
        Caption = '-'
        GroupIndex = 2
      end
      object miInsertFileInsert: TMenuItem
        Action = acInsertFile
        GroupIndex = 2
      end
      object miInsertPicture: TevMenuItem
        Action = acInsertPicture
        GroupIndex = 2
      end
      object miBlock: TevMenuItem
        Action = acInsertBlock
        SubMenuImages = dmStandardRes.ilCommon
        GroupIndex = 2
      end
      object miInsertBreak: TMenuItem
        Caption = #1056#1072#1079#1088#1099#1074
        GroupIndex = 2
        Hint = #1054#1087#1077#1088#1072#1094#1080#1080' '#1089' '#1088#1072#1079#1088#1099#1074#1072#1084#1080
        object miInsertPageBreak: TevMenuItem
          Caption = #1057#1090#1088#1072#1085#1080#1094#1099
          GroupIndex = 2
          Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1088#1072#1079#1088#1099#1074' '#1089#1090#1088#1072#1085#1080#1094#1099
          ImageIndex = 71
          ShortCut = 8205
          Operation = ev_ccInsertPageBreak
        end
        object miInsertSectionBreak: TevMenuItem
          Caption = #1056#1072#1079#1076#1077#1083#1072
          GroupIndex = 2
          Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1088#1072#1079#1088#1099#1074' '#1088#1072#1079#1076#1077#1083#1072
          ImageIndex = 70
          ShortCut = 24589
          Operation = ev_ccInsertSectionBreak
        end
      end
      object miInsertComponent: TevMenuItem
        Caption = #1050#1086#1084#1087#1086#1085#1077#1085#1090
        GroupIndex = 2
        Visible = False
        OnClick = miInsertComponentClick
      end
    end
    object miFormat: TevMenuItem
      Caption = #1060#1086#1088#1084#1072#1090
      SubMenuImages = dmStandardRes.ilOffice
      GroupIndex = 2
      Hint = #1050#1086#1084#1072#1085#1076#1099' '#1092#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1090#1077#1082#1089#1090#1072
      object miFormatJustifyLeft: TevMenuItem
        AutoCheck = True
        Caption = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1074#1083#1077#1074#1086
        Checked = True
        GroupIndex = 2
        Hint = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1087#1072#1088#1072#1075#1088#1072#1092' '#1074#1083#1077#1074#1086
        ImageIndex = 123
        RadioItem = True
        Operation = ev_ccJustifyLeft
      end
      object miFormatJustifyCenter: TevMenuItem
        AutoCheck = True
        Caption = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1087#1086' '#1094#1077#1085#1090#1088#1091
        GroupIndex = 2
        Hint = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1087#1072#1088#1072#1075#1088#1072#1092' '#1087#1086' '#1094#1077#1085#1090#1088#1091
        ImageIndex = 124
        RadioItem = True
        Operation = ev_ccJustifyCenter
      end
      object miFormatJustifyRight: TevMenuItem
        AutoCheck = True
        Caption = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1074#1087#1088#1072#1074#1086
        GroupIndex = 2
        Hint = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1087#1072#1088#1072#1075#1088#1072#1092' '#1074#1087#1088#1072#1074#1086
        ImageIndex = 125
        RadioItem = True
        Operation = ev_ccJustifyRight
      end
      object miFormatJustifyWidth: TevMenuItem
        AutoCheck = True
        Caption = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1087#1086' '#1096#1080#1088#1080#1085#1077
        GroupIndex = 2
        Hint = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1087#1072#1088#1072#1075#1088#1072#1092' '#1087#1086' '#1096#1080#1088#1080#1085#1077
        ImageIndex = 126
        RadioItem = True
        Operation = ev_ccJustifyWidth
      end
      object miFormatPreformatted: TevMenuItem
        AutoCheck = True
        Caption = '"'#1055#1088#1077#1092#1086#1084#1072#1090#1080#1088#1086#1074#1072#1085#1085#1099#1081'" '#1090#1077#1082#1089#1090
        GroupIndex = 2
        Hint = '"'#1055#1088#1077#1092#1086#1084#1072#1090#1080#1088#1086#1074#1072#1085#1085#1099#1081'" '#1090#1077#1082#1089#1090
        ImageIndex = 204
        RadioItem = True
        Operation = ev_ccJustifyPreformatted
      end
      object N5: TMenuItem
        Caption = '-'
        GroupIndex = 2
      end
      object miFormatBordersAndShade: TevMenuItem
        Caption = #1043#1088#1072#1085#1080#1094#1099' '#1080' '#1079#1072#1083#1080#1074#1082#1072'...'
        GroupIndex = 6
        ImageIndex = 232
        Operation = ev_ccBordersAndShade
      end
      object N2: TevMenuItem
        Caption = '-'
        GroupIndex = 6
      end
      object miFormatStyles: TevMenuItem
        Action = acEditStyles
        GroupIndex = 6
      end
      object miLoadStyles: TevMenuItem
        Caption = #1057#1095#1080#1090#1072#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
        GroupIndex = 6
        Visible = False
      end
      object miSaveStyles: TevMenuItem
        Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1074' '#1092#1072#1081#1083
        GroupIndex = 6
        Visible = False
      end
      object miFormatStyle: TMenuItem
        Caption = #1057#1090#1080#1083#1100
        GroupIndex = 6
        object miFormatStyleColorSelection: TMenuItem
          Action = acColorSelection
        end
        object miFormatStyleANSIDos: TMenuItem
          Action = acANSIDOS
        end
        object miFormatStyleNormal: TMenuItem
          Action = acNormal
        end
        object miFormatStyleOEM: TMenuItem
          Action = acNormalOEM
        end
        object miFormatStyleHeader1: TMenuItem
          Action = acHeading1
        end
        object miFormatStyleArticleHeader: TMenuItem
          Action = acArticleHeading
        end
        object miFormatStyleOutOfDate: TMenuItem
          Action = acOutOfDate
        end
        object miFormatStyleComment: TMenuItem
          Action = acComment
        end
        object miFormatStyleHyperlinkContinue: TMenuItem
          Action = acHyperlinkCont
        end
        object miFormatStyleToLeft: TMenuItem
          Action = acLeft
        end
      end
    end
    object miTools: TevMenuItem
      Caption = #1057#1077#1088#1074#1080#1089
      GroupIndex = 2
      object miBuildDocumentStructure: TMenuItem
        Action = acBuildDocumentStructure
      end
      object miDeleteAllBlocks: TMenuItem
        Action = acDeleteAllDocumentParts
      end
      object miBuildContents: TMenuItem
        Action = acBuildContents
      end
    end
    object miTable: TevMenuItem
      Caption = #1058#1072#1073#1083#1080#1094#1099
      SubMenuImages = dmStandardRes.ilOffice
      GroupIndex = 2
      Hint = #1050#1086#1084#1072#1085#1076#1099' '#1088#1072#1073#1086#1090#1099' '#1089' '#1090#1072#1073#1083#1080#1094#1072#1084#1080
      object miTableInsert: TevMenuItem
        Caption = #1057#1086#1079#1076#1072#1090#1100'...'
        Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
        ImageIndex = 166
        Operation = ev_ccInsertTable
      end
      object miTableFromText: TevMenuItem
        Action = acConvertTextToTable
      end
      object miTableInsertRow: TevMenuItem
        Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1089#1090#1088#1086#1082#1091
        Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1089#1090#1088#1086#1082#1091' '#1090#1072#1073#1083#1080#1094#1099
        ImageIndex = 169
        Operation = ev_ccInsertRow
      end
      object miTableDeleteRow: TevMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1088#1086#1082#1091
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1088#1086#1082#1091' '#1090#1072#1073#1083#1080#1094#1099
        ImageIndex = 172
        Operation = ev_ccDeleteRow
      end
      object miTableInsertColumn: TevMenuItem
        Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1089#1090#1086#1083#1073#1077#1094
        Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1089#1090#1086#1083#1073#1077#1094' '#1090#1072#1073#1083#1080#1094#1099
        ImageIndex = 170
        Operation = ev_ccInsertColumn
      end
      object miTableDeleteColumn: TevMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1086#1083#1073#1077#1094
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1086#1083#1073#1077#1094' '#1090#1072#1073#1083#1080#1094#1099
        ImageIndex = 173
        Operation = ev_ccDeleteColumn
      end
      object MITblShlCol: TevMenuItem
        Caption = #1057#1076#1074#1080#1085#1091#1090#1100' '#1074#1083#1077#1074#1086
        Visible = False
      end
      object MITblShrCol: TevMenuItem
        Caption = #1057#1076#1074#1080#1085#1091#1090#1100' '#1074#1087#1088#1072#1074#1086
        Visible = False
      end
      object miMergeCells: TevMenuItem
        Caption = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1103#1095#1077#1081#1082#1080
        Hint = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1103#1095#1077#1081#1082#1080' '#1090#1072#1073#1083#1080#1094#1099
        ImageIndex = 184
        Operation = ev_ccMergeCells
      end
      object miSplitCell: TevMenuItem
        Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1100' '#1103#1095#1077#1081#1082#1080
        Hint = #1056#1072#1079#1076#1077#1083#1080#1090#1100' '#1103#1095#1077#1081#1082#1080' '#1090#1072#1073#1083#1080#1094#1099
        ImageIndex = 185
        Operation = ev_ccSplitCells
      end
      object miTableSplitTable: TevMenuItem
        Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
        Operation = ev_ccSplitTable
      end
      object miTableMergeTables: TevMenuItem
        Caption = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1099
        Operation = ev_ccMergeTables
      end
      object miMergeCellsHorz: TevMenuItem
        Caption = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1103#1095#1077#1081#1082#1080' '#1087#1086' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1080
        Hint = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1103#1095#1077#1081#1082#1080' '#1087#1086' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1080
        Operation = ev_ccMergeCellsHorz
      end
      object miMergeCellsVert: TevMenuItem
        Caption = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1103#1095#1077#1081#1082#1080' '#1087#1086' '#1074#1077#1088#1090#1080#1082#1072#1083#1080
        Hint = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1103#1095#1077#1081#1082#1080' '#1087#1086' '#1074#1077#1088#1090#1080#1082#1072#1083#1080
        Operation = ev_ccMergeCellsVert
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object miTop: TevMenuItem
        Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077' '#1082' '#1074#1077#1088#1093#1091
        Checked = True
        GroupIndex = 3
        Hint = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1089#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1103#1095#1077#1081#1082#1080' '#1082' '#1074#1077#1088#1093#1091
        ImageIndex = 186
        RadioItem = True
        Operation = ev_ccVAlignTop
      end
      object miVCenter: TevMenuItem
        Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077' '#1087#1086' '#1094#1077#1085#1090#1088#1091
        GroupIndex = 3
        Hint = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1089#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1103#1095#1077#1081#1082#1080' '#1087#1086' '#1094#1077#1085#1090#1088#1091
        ImageIndex = 187
        RadioItem = True
        Operation = ev_ccVAlignCenter
      end
      object miBottom: TevMenuItem
        Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077' '#1082' '#1085#1080#1079#1091
        GroupIndex = 3
        Hint = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1089#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1103#1095#1077#1081#1082#1080' '#1082' '#1085#1080#1079#1091
        ImageIndex = 188
        RadioItem = True
        Operation = ev_ccVAlignBottom
      end
      object miTableToolsBreak: TMenuItem
        Caption = '-'
        GroupIndex = 3
      end
      object miTableTools: TMenuItem
        Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
        GroupIndex = 3
        object miMergeRows: TMenuItem
        end
      end
    end
    object miSearch: TevMenuItem
      Caption = #1055#1086#1080#1089#1082
      SubMenuImages = dmStandardRes.ilOffice
      GroupIndex = 2
      Hint = #1050#1086#1084#1072#1085#1076#1099' '#1087#1086#1080#1089#1082#1072
      object miFind: TevMenuItem
        Caption = #1053#1072#1081#1090#1080'...'
        Hint = #1053#1072#1081#1090#1080' '#1079#1072#1076#1072#1085#1085#1099#1081' '#1092#1088#1072#1075#1084#1077#1085#1090
        ImageIndex = 28
        ShortCut = 16467
        Operation = ev_ccSearch
      end
      object miReplace: TevMenuItem
        Caption = #1047#1072#1084#1077#1085#1080#1090#1100'...'
        Hint = #1053#1072#1081#1090#1080' '#1079#1072#1076#1072#1085#1085#1099#1081' '#1092#1088#1072#1075#1084#1077#1085#1090' '#1080' '#1079#1072#1084#1077#1085#1080#1090#1100' '#1085#1072' '#1076#1088#1091#1075#1086#1081
        ImageIndex = 30
        ShortCut = 16466
        Operation = ev_ccReplace
      end
      object miSearchAgain: TevMenuItem
        Caption = #1055#1086#1074#1090#1086#1088#1080#1090#1100' '#1087#1086#1080#1089#1082
        Hint = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1100' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1081' '#1087#1086#1080#1089#1082' / '#1079#1072#1084#1077#1085#1091
        ImageIndex = 29
        ShortCut = 16460
        Operation = ev_ccSearchAgain
      end
    end
    object miWindow: TevMenuItem
      AutoHotkeys = maManual
      AutoLineReduction = maManual
      Caption = '&'#1054#1082#1085#1072
      SubMenuImages = dmStandardRes.ilOffice
      GroupIndex = 2
      Hint = #1050#1086#1084#1072#1085#1076#1099' '#1091#1087#1088#1072#1074#1083#1077#1085#1080#1103' '#1086#1082#1085#1072#1084#1080
      object miWindowCascade: TevMenuItem
        Caption = '&'#1050#1072#1089#1082#1072#1076
        Hint = #1042#1099#1088#1072#1074#1085#1103#1090#1100' '#1086#1082#1085#1072' '#1089' '#1087#1077#1088#1077#1082#1088#1099#1090#1080#1077#1084
        ImageIndex = 215
        OnClick = miWindowCascadeClick
      end
      object miWindowTile: TevMenuItem
        Caption = '&'#1063#1077#1088#1077#1087#1080#1094#1072
        Hint = #1042#1099#1088#1072#1074#1085#1103#1090#1100' '#1086#1082#1085#1072' '#1073#1077#1079' '#1087#1077#1088#1077#1082#1088#1099#1090#1080#1103
        ImageIndex = 193
        OnClick = miWindowTileClick
      end
      object miWindowArrange: TevMenuItem
        Caption = '&'#1042#1099#1088#1072#1074#1085#1103#1090#1100' '#1079#1085#1072#1095#1082#1080
        Hint = #1042#1099#1088#1072#1074#1085#1103#1090#1100' '#1079#1085#1072#1095#1082#1080' '#1086#1082#1086#1085' '#1087#1086' '#1085#1080#1079#1091' '#1086#1089#1085#1086#1074#1085#1086#1075#1086' '#1086#1082#1085#1072
        ImageIndex = 216
        OnClick = miWindowArrangeClick
      end
      object miWindowMinimize: TevMenuItem
        Caption = '&'#1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077
        Hint = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077' '#1086#1082#1085#1072
        ImageIndex = 213
        OnClick = miWindowMinimizeClick
      end
      object N3: TevMenuItem
        Caption = '-'
      end
      object miMDIChildren: TevMenuItem
        Action = acMDIChildList
      end
      object miPaintDebug: TevMenuItem
        Caption = #1054#1090#1083#1072#1076#1082#1072' '#1086#1090#1088#1080#1089#1086#1074#1082#1080
        OnClick = miPaintDebugClick
      end
    end
    object miHelp: TevMenuItem
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      SubMenuImages = dmStandardRes.ilOffice
      GroupIndex = 5
      Hint = #1050#1086#1084#1072#1085#1076#1099' '#1087#1086#1083#1091#1095#1077#1085#1080#1103' '#1089#1087#1088#1072#1074#1082#1080
      object miHelpAbout: TevMenuItem
        Caption = '&'#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        Hint = #1057#1087#1088#1072#1074#1082#1072' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        ImageIndex = 221
        OnClick = miHelpAboutClick
      end
    end
  end
  object Timer: TTimer [8]
    OnTimer = TimerTimer
    Left = 510
    Top = 139
  end
  object TextSource: TevTextSource [11]
    Left = 458
    Top = 256
  end
  inherited OvcController1: TOvcController
    EntryCommands.TableList = (
      'Default'
      True
      (
        1037
        0)
      'WordStar'
      True
      ()
      'Grid'
      False
      ()
      'List'
      True
      ())
  end
  object pmSection: TPopupMenu
    Images = dmStandardRes.ilOffice
    Left = 48
    Top = 352
    object miPortrait: TMenuItem
      Action = acSectionPortrait
      AutoCheck = True
      GroupIndex = 1
      RadioItem = True
    end
    object miLandscape: TMenuItem
      Action = acSectionLandscape
      AutoCheck = True
      GroupIndex = 1
      RadioItem = True
    end
    object MenuItem1: TMenuItem
      Caption = '-'
      GroupIndex = 1
    end
    object miA4Size: TMenuItem
      Action = acSectionA4Size
      AutoCheck = True
      GroupIndex = 2
      RadioItem = True
    end
    object miA3Size: TMenuItem
      Action = acSectionA3Size
      AutoCheck = True
      GroupIndex = 2
      RadioItem = True
    end
    object miA2Size: TMenuItem
      Action = acSectionA2Size
      GroupIndex = 2
    end
    object miA1Size: TMenuItem
      Action = acSectionA1Size
      GroupIndex = 2
    end
  end
  object pmSub: TPopupMenu
    Images = dmStandardRes.ilOffice
    Left = 16
    Top = 352
    object miSubProperties: TMenuItem
      Action = acSubProperties
      Default = True
    end
    object miSubDelete: TMenuItem
      Action = acSubDelete
    end
    object miDocumentPartMerge: TMenuItem
      Action = acDocumentPartMerge
    end
  end
  object pmHyperlink: TPopupMenu
    Images = dmStandardRes.ilOffice
    Left = 80
    Top = 352
    object miHypelinkProperties: TMenuItem
      Action = acHyperlinkProperties
    end
    object miFollowHyperlink: TMenuItem
      Action = acHyperlinkFollow
      Default = True
    end
    object MenuItem2: TMenuItem
      Action = acHyperlinkDelete
    end
  end
  object pmCell: TPopupMenu
    Images = dmStandardRes.ilOffice
    Left = 112
    Top = 352
    object miCellBordersAndShade: TMenuItem
    end
    object miCellMerge: TMenuItem
      Action = acCellMerge
    end
    object miCellDelete: TMenuItem
      Action = acCellDelete
    end
  end
  object pmEditor: TPopupMenu
    Images = dmStandardRes.ilOffice
    OnPopup = pmEditorPopup
    Left = 144
    Top = 352
    object miHRuler: TMenuItem
      Caption = #1043#1086#1088#1080#1079#1086#1085#1090#1072#1083#1100#1085#1072#1103' '#1083#1080#1085#1077#1081#1082#1072
      Checked = True
      ImageIndex = 38
      OnClick = miHRulerClick
    end
    object miVRuler: TMenuItem
      Caption = #1042#1077#1088#1090#1080#1082#1072#1083#1100#1085#1072#1103' '#1083#1080#1085#1077#1081#1082#1072
      Checked = True
      OnClick = miVRulerClick
    end
    object miVSubPanel: TMenuItem
      Caption = #1055#1072#1085#1077#1083#1100' '#1079#1072#1082#1083#1072#1076#1086#1082
      Checked = True
      OnClick = miVSubPanelClick
    end
    object miSplitWindow: TMenuItem
      Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1100' '#1086#1082#1085#1086
      Hint = #1056#1072#1079#1076#1077#1083#1080#1090#1100' '#1086#1082#1085#1086' '#1088#1077#1076#1072#1082#1090#1086#1088#1072
      ImageIndex = 226
      OnClick = miSplitWindowClick
    end
    object miShowExplorer: TMenuItem
      Caption = #1057#1090#1088#1091#1082#1090#1091#1088#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1089#1090#1088#1091#1082#1090#1091#1088#1091' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      ImageIndex = 225
      OnClick = miShowExplorerClick
    end
    object miLine1: TMenuItem
      Caption = '-'
    end
    object evMenuItem1: TevMenuItem
      Caption = #1042#1099#1088#1077#1079#1072#1090#1100
      ImageIndex = 24
      ShortCut = 8238
      Operation = ev_ccCut
    end
    object evMenuItem2: TevMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 25
      ShortCut = 16429
      Operation = ev_ccCopy
    end
    object evMenuItem3: TevMenuItem
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      ImageIndex = 26
      ShortCut = 8237
      Operation = ev_ccPaste
    end
    object evMenuItem4: TevMenuItem
      Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1072#1103' '#1074#1089#1090#1072#1074#1082#1072'...'
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079' '#1073#1091#1092#1077#1088#1072' '#1086#1073#1084#1077#1085#1072' '#1089' '#1074#1099#1073#1086#1088#1086#1084' '#1092#1086#1088#1084#1072#1090#1072
      ImageIndex = 220
      Operation = ev_ccSpecialPaste
    end
    object evMenuItem5: TevMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 206
      ShortCut = 16430
      Operation = ev_ccDelete
    end
    object MenuItem3: TMenuItem
      Caption = '-'
    end
    object evMenuItem6: TevMenuItem
      Caption = #1053#1072#1081#1090#1080'...'
      Hint = #1053#1072#1081#1090#1080' '#1079#1072#1076#1072#1085#1085#1099#1081' '#1092#1088#1072#1075#1084#1077#1085#1090
      ImageIndex = 28
      ShortCut = 16467
      Operation = ev_ccSearch
    end
    object evMenuItem7: TevMenuItem
      Caption = #1047#1072#1084#1077#1085#1080#1090#1100'...'
      Hint = #1053#1072#1081#1090#1080' '#1079#1072#1076#1072#1085#1085#1099#1081' '#1092#1088#1072#1075#1084#1077#1085#1090' '#1080' '#1079#1072#1084#1077#1085#1080#1090#1100' '#1077#1075#1086' '#1085#1077' '#1076#1088#1091#1075#1086#1081
      ImageIndex = 30
      ShortCut = 16466
      Operation = ev_ccReplace
    end
    object miFindAgain: TevMenuItem
      Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1100' '#1087#1086#1080#1089#1082
      Hint = #1055#1086#1074#1090#1086#1088#1080#1090#1100' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1081' '#1087#1086#1080#1089#1082'/'#1079#1072#1084#1077#1085#1091
      ImageIndex = 29
      ShortCut = 16460
      Operation = ev_ccSearchAgain
    end
    object MenuItem4: TMenuItem
      Caption = '-'
    end
    object miCloseEditor: TMenuItem
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086
      ImageIndex = 4
      ShortCut = 32882
      OnClick = miCloseEditorClick
    end
    object miMaximize: TMenuItem
      Caption = #1052#1072#1082#1089#1080#1084#1080#1079#1080#1088#1086#1074#1072#1090#1100
      Hint = #1052#1072#1082#1089#1080#1084#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1086#1082#1085#1086'|'#1052#1072#1082#1089#1080#1084#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1090#1077#1082#1091#1097#1077#1077' '#1086#1082#1085#1086' '#1088#1077#1076#1072#1082#1090#1086#1088#1072
      ImageIndex = 212
      ShortCut = 116
      OnClick = miMaximizeClick
    end
  end
  object pmExplorer: TPopupMenu
    Images = dmStandardRes.ilOffice
    OnPopup = pmExplorerPopup
    Left = 176
    Top = 353
    object miGotoSub: TMenuItem
      Action = acGotoSub
      Default = True
    end
    object miExplorerSubProperties: TMenuItem
      Action = acSubProperties
    end
    object MenuItem5: TMenuItem
      Action = acSubDelete
    end
  end
end
