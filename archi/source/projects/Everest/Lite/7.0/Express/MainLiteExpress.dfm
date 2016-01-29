inherited MainLiteExpressForm: TMainLiteExpressForm
  Left = 131
  Width = 878
  DefaultMonitor = dmPrimary
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar [0]
    Left = 0
    Top = 423
    Width = 862
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  inherited tsDocuments: TTabSet
    Top = 407
    Width = 862
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
  inherited theActions: TActionList
    object acFileExit: TFileExit [0]
      Category = 'File'
      Caption = #1042#1099'&'#1093#1086#1076
      Hint = #1042#1099#1093#1086#1076'|'#1042#1099#1081#1090#1080' '#1080#1079' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
      ImageIndex = 209
      ShortCut = 32856
    end
    object acOpen: TevAction [1]
      Operation = ev_ccOpen
      ImageIndex = 3
    end
    object acNew: TevAction [2]
      Operation = ev_ccNew
      ImageIndex = 0
    end
    object acSave: TevAction [3]
      Operation = ev_ccSave
      ImageIndex = 5
    end
    object acSaveAs: TevAction [4]
      Operation = ev_ccSaveAs
      ImageIndex = 217
      ShortCut = 8315
    end
    object acUndo: TevAction [5]
      Operation = ev_ccUndo
      ImageIndex = 21
    end
    object acRedo: TevAction [6]
      Operation = ev_ccRedo
      ImageIndex = 22
    end
    object acPrintEx: TevAction [7]
      Operation = ev_ccPrintEx
      ImageIndex = 12
      ShortCut = 16464
    end
    object acCut: TevAction [8]
      Operation = ev_ccCut
      ImageIndex = 24
    end
    object acCopy: TevAction [9]
      Operation = ev_ccCopy
      ImageIndex = 25
    end
    object acPaste: TevAction [10]
      Operation = ev_ccPaste
      ImageIndex = 26
    end
    object acDelete: TevAction [11]
      Operation = ev_ccDelete
      ImageIndex = 206
    end
    object acSpecialPaste: TevAction [12]
      Operation = ev_ccSpecialPaste
      ImageIndex = 220
      ShortCut = 32855
    end
    object acAdd: TevAction [13]
      Operation = ev_ccAdd
      ImageIndex = 250
    end
    object acSelectAll: TevAction [14]
      Operation = ev_ccSelectAll
      ImageIndex = 218
    end
    object acHideSelection: TevAction [15]
      Operation = ev_ccHideSelection
      ImageIndex = 219
    end
    object acShowSpecial: TevAction [16]
      Operation = ev_ccShowSpecial
      Checked = True
      ImageIndex = 39
    end
    object acShowDocumentParts: TevAction [17]
      Operation = ev_ccShowDocumentParts
      ImageIndex = 236
    end
    object acPrintPreviewMode: TevAction [18]
      Operation = ev_ccPrintPreview
      ImageIndex = 11
    end
    object acInsertSBS: TevAction [19]
      Operation = ev_ccInsertSBS
      ImageIndex = 208
    end
    object acInsertTable: TevAction [20]
      Operation = ev_ccInsertTable
      ImageIndex = 166
    end
    object acInsertRow: TevAction [21]
      Operation = ev_ccInsertRow
      ImageIndex = 169
    end
    object acDeleteRow: TevAction [22]
      Operation = ev_ccDeleteRow
      ImageIndex = 172
    end
    object acInsertColumn: TevAction [23]
      Operation = ev_ccInsertColumn
      ImageIndex = 170
    end
    object acDeleteColumn: TevAction [24]
      Operation = ev_ccDeleteColumn
      ImageIndex = 173
    end
    object acMergeCells: TevAction [25]
      Operation = ev_ccMergeCells
      ImageIndex = 184
    end
    object acSplitCells: TevAction [26]
      Operation = ev_ccSplitCells
      ImageIndex = 185
    end
    object acJustifyLeft: TevAction [27]
      Operation = ev_ccJustifyLeft
      ImageIndex = 123
    end
    object acJustifyCenter: TevAction [28]
      Operation = ev_ccJustifyCenter
      ImageIndex = 124
    end
    object acJustifyRight: TevAction [29]
      Operation = ev_ccJustifyRight
      ImageIndex = 125
    end
    object acJustifyWidth: TevAction [30]
      Operation = ev_ccJustifyWidth
      ImageIndex = 126
    end
    object acJustifyPreformatted: TevAction [31]
      Operation = ev_ccJustifyPreformatted
      ImageIndex = 204
    end
    object acVAlignTop: TevAction [32]
      Operation = ev_ccVAlignTop
      ImageIndex = 186
    end
    object acVAlignCenter: TevAction [33]
      Operation = ev_ccVAlignCenter
      ImageIndex = 187
    end
    object acVAlignBottom: TevAction [34]
      Operation = ev_ccVAlignBottom
      ImageIndex = 188
    end
    object acHSplit: TevAction [35]
      Operation = ev_ccHSplit
      ImageIndex = 235
    end
    object acVSplit: TevAction [36]
      Operation = ev_ccVSplit
      ImageIndex = 234
    end
    object acPrint: TevAction [37]
      Operation = ev_ccPrint
      ImageIndex = 12
    end
    object acDrawLines: TevAction [38]
      Operation = ev_ccDrawLines
      ImageIndex = 182
    end
    object acSearch: TevAction [39]
      Operation = ev_ccSearch
      ImageIndex = 28
    end
    object acReplace: TevAction [40]
      Operation = ev_ccReplace
      ImageIndex = 30
    end
    object acSearchAgain: TevAction [41]
      Operation = ev_ccSearchAgain
      ImageIndex = 29
    end
    object acWindowCascade: TWindowCascade [42]
      Category = 'Window'
      Caption = #1050#1072#1089#1082#1072#1076
      Enabled = False
      Hint = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1086#1082#1085#1072' '#1082#1072#1089#1082#1072#1076#1086#1084
      ImageIndex = 215
    end
    object acWindowTileHorizontal: TWindowTileHorizontal [43]
      Category = 'Window'
      Caption = #1063#1077#1088#1077#1087#1080#1094#1072
      Enabled = False
      HelpKeyword = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1086#1082#1085#1072' '#1073#1077#1079' '#1087#1077#1088#1077#1082#1088#1099#1090#1080#1103
      Hint = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1086#1082#1085#1072' '#1095#1077#1088#1077#1087#1080#1094#1077#1081
      ImageIndex = 193
    end
    object acWindowTileVertical: TWindowTileVertical [44]
      Category = 'Window'
      Caption = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1087#1086' '#1074#1077#1088#1090#1080#1082#1072#1083#1080
      Enabled = False
      Hint = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1086#1082#1085#1072' '#1087#1086' '#1074#1077#1088#1090#1080#1082#1072#1083#1080
    end
    object acWindowMinimizeAll: TWindowMinimizeAll [45]
      Category = 'Window'
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077
      Enabled = False
      Hint = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077' '#1086#1082#1085#1072
      ImageIndex = 213
    end
    object acWindowArrange: TWindowArrange [46]
      Category = 'Window'
      Caption = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1079#1085#1072#1095#1082#1080
      Enabled = False
      Hint = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1079#1085#1072#1095#1082#1080
      ImageIndex = 216
    end
    object acWindowClose: TWindowClose [47]
      Category = 'Window'
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Enabled = False
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
      ImageIndex = 4
      ShortCut = 32882
    end
    object acPersistent: TevAction [48]
      Operation = ev_ccPersistent
    end
    object acSplitTable: TevAction [49]
      Operation = ev_ccSplitTable
    end
    object acMergeTables: TevAction [50]
      Operation = ev_ccMergeTables
    end
    object acMergeCellsHorz: TevAction [52]
      Operation = ev_ccMergeCellsHorz
    end
    object acMergeCellsVert: TevAction [53]
      Operation = ev_ccMergeCellsVert
    end
    object acSpellcheck: TevAction [70]
      Operation = ev_ccSpellcheck
      ImageIndex = 146
    end
    object acInsertPageBreak: TevAction [71]
      Operation = ev_ccInsertPageBreak
      ImageIndex = 71
    end
    object acInsertSectionBreak: TevAction [72]
      Operation = ev_ccInsertSectionBreak
      ImageIndex = 70
    end
    object acVisible: TevAction [87]
      Operation = ev_ccVisible
      ImageIndex = 203
    end
    object acWebStyle: TevAction [88]
      Operation = ev_ccWebStyle
      ImageIndex = 49
    end
    object acOldNSRCTable: TevAction [128]
      Operation = ev_ccOldNSRCTable
      AutoCheck = True
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Bars = <
      item
        Caption = #1054#1089#1085#1086#1074#1085#1086#1077' '#1084#1077#1085#1102
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 231
        FloatTop = 223
        FloatClientWidth = 23
        FloatClientHeight = 22
        IsMainMenu = True
        ItemLinks = <
          item
            Item = miFile
            Visible = True
          end
          item
            Item = miText
            Visible = True
          end
          item
            Item = miView
            Visible = True
          end
          item
            Item = miInsert
            Visible = True
          end
          item
            Item = dxTables
            Visible = True
          end
          item
            Item = miSearch
            Visible = True
          end
          item
            Item = miTools
            Visible = True
          end
          item
            Item = miWindow
            Visible = True
          end
          item
            Item = dxBarHelp
            Visible = True
          end>
        MultiLine = True
        OneOnRow = True
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = True
      end
      item
        Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 25
        DockingStyle = dsTop
        FloatLeft = 234
        FloatTop = 178
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = btNew
            Visible = True
          end
          item
            Item = btOpen
            Visible = True
          end
          item
            Item = btSave
            Visible = True
          end
          item
            Item = btPrintEx
            Visible = True
          end>
        OneOnRow = False
        Row = 1
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100'/'#1074#1077#1088#1085#1091#1090#1100
        DockedDockingStyle = dsTop
        DockedLeft = 203
        DockedTop = 25
        DockingStyle = dsTop
        FloatLeft = 234
        FloatTop = 178
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = btUndo
            Visible = True
          end
          item
            Item = btRedo
            Visible = True
          end>
        OneOnRow = False
        Row = 1
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = #1041#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
        DockedDockingStyle = dsTop
        DockedLeft = 113
        DockedTop = 25
        DockingStyle = dsTop
        FloatLeft = 340
        FloatTop = 279
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = btCut
            Visible = True
          end
          item
            Item = btCopy
            Visible = True
          end
          item
            Item = btPaste
            Visible = True
          end>
        OneOnRow = False
        Row = 1
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = #1054#1073#1098#1077#1082#1090#1099
        DockedDockingStyle = dsTop
        DockedLeft = 532
        DockedTop = 25
        DockingStyle = dsTop
        FloatLeft = 340
        FloatTop = 279
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = btDelete
            Visible = True
          end>
        OneOnRow = False
        Row = 1
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = #1060#1086#1088#1084#1072#1090
        DockedDockingStyle = dsTop
        DockedLeft = 576
        DockedTop = 25
        DockingStyle = dsTop
        FloatLeft = 340
        FloatTop = 279
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = btJustifyLeft
            Visible = True
          end
          item
            Item = btJustifyCenter
            Visible = True
          end
          item
            Item = btJustifyRight
            Visible = True
          end
          item
            Item = btJustifyWidth
            Visible = True
          end
          item
            Item = btJustifyPreformatted
            Visible = True
          end
          item
            Item = btVisible
            Visible = True
          end
          item
            Item = bcAlignWithSeparator
            Visible = True
          end>
        OneOnRow = False
        Row = 1
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = #1058#1072#1073#1083#1080#1094#1099
        DockedDockingStyle = dsTop
        DockedLeft = 153
        DockedTop = 51
        DockingStyle = dsTop
        FloatLeft = 234
        FloatTop = 178
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = btInsertTable
            Visible = True
          end
          item
            BeginGroup = True
            Item = btInsertRow
            Visible = True
          end
          item
            Item = btInsertColumn
            Visible = True
          end
          item
            Item = btDeleteRow
            Visible = True
          end
          item
            Item = btDeleteColumn
            Visible = True
          end
          item
            BeginGroup = True
            Item = btMergeCells
            Visible = True
          end
          item
            Item = btnSplitCells
            Visible = True
          end
          item
            BeginGroup = True
            Item = btHSplit
            Visible = True
          end
          item
            Item = btVSplit
            Visible = True
          end
          item
            Item = btMergeCellsHorz
            Visible = True
          end
          item
            Item = btMergeCellsVert
            Visible = True
          end
          item
            Item = btMergeTables
            Visible = True
          end
          item
            Item = btnSplitTable
            Visible = True
          end>
        OneOnRow = False
        Row = 2
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077' '#1087#1086' '#1074#1077#1088#1090#1080#1082#1072#1083#1080
        DockedDockingStyle = dsTop
        DockedLeft = 488
        DockedTop = 51
        DockingStyle = dsTop
        FloatLeft = 349
        FloatTop = 289
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = btVAlignTop
            Visible = True
          end
          item
            Item = btVAlignCenter
            Visible = True
          end
          item
            Item = btVAlignBottom
            Visible = True
          end>
        OneOnRow = False
        Row = 2
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = #1042#1080#1076
        DockedDockingStyle = dsTop
        DockedLeft = 360
        DockedTop = 25
        DockingStyle = dsTop
        FloatLeft = 234
        FloatTop = 178
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = btShowSpecial
            Visible = True
          end
          item
            Item = btShowDocumentParts
            Visible = True
          end
          item
            Item = btPrintPreview
            Visible = True
          end
          item
            Item = btPersistent
            Visible = True
          end
          item
            Item = btDrawLines
            Visible = True
          end
          item
            Item = btAdjustMargin
            Visible = True
          end
          item
            Item = btWebStyle
            Visible = True
          end>
        OneOnRow = False
        Row = 1
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = #1055#1086#1080#1089#1082
        DockedDockingStyle = dsTop
        DockedLeft = 270
        DockedTop = 25
        DockingStyle = dsTop
        FloatLeft = 436
        FloatTop = 275
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = btSearch
            Visible = True
          end
          item
            Item = btSearchAgain
            Visible = True
          end
          item
            Item = btSpellCheck
            Visible = True
          end>
        OneOnRow = False
        Row = 1
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = #1052#1072#1089#1096#1090#1072#1073
        DockedDockingStyle = dsTop
        DockedLeft = 578
        DockedTop = 51
        DockingStyle = dsTop
        FloatLeft = 234
        FloatTop = 178
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = seZoom
            UserDefine = [udWidth]
            UserWidth = 51
            Visible = True
          end>
        Name = #1052#1072#1089#1096#1090#1072#1073
        OneOnRow = False
        Row = 2
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = #1057#1090#1080#1083#1100
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 51
        DockingStyle = dsTop
        FloatLeft = 322
        FloatTop = 191
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = cbStyles
            UserDefine = [udWidth]
            UserWidth = 132
            Visible = True
          end>
        Name = #1057#1090#1080#1083#1100
        OneOnRow = False
        Row = 2
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = #1057#1087#1080#1089#1082#1080
        DockedDockingStyle = dsTop
        DockedLeft = 650
        DockedTop = 51
        DockingStyle = dsTop
        FloatLeft = 234
        FloatTop = 178
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = btBullet
            Visible = True
          end
          item
            Item = btNumbering
            Visible = True
          end>
        Name = #1057#1087#1080#1089#1082#1080
        OneOnRow = False
        Row = 2
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end>
    Categories.Strings = (
      #1041#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      #1052#1077#1085#1102
      #1044#1086#1082#1091#1084#1077#1085#1090#1099
      #1055#1088#1080#1083#1086#1078#1077#1085#1080#1077
      #1054#1090#1084#1077#1085#1080#1090#1100'/'#1074#1077#1088#1085#1091#1090#1100
      #1054#1073#1098#1077#1082#1090#1099
      #1055#1077#1095#1072#1090#1100
      #1042#1099#1076#1077#1083#1077#1085#1080#1077
      #1058#1072#1073#1083#1080#1094#1099
      #1042#1080#1076
      #1060#1086#1088#1084#1072#1090
      #1055#1086#1080#1089#1082
      #1054#1082#1085#1072
      #1042#1089#1090#1072#1074#1082#1072
      #1071#1079#1099#1082
      #1050#1086#1085#1090#1077#1082#1089#1090#1085#1086#1077' '#1084#1077#1085#1102
      #1057#1077#1088#1074#1080#1089
      #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1096#1088#1080#1092#1090#1072
      #1055#1086#1084#1086#1097#1100)
    Categories.ItemsVisibles = (
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True
      True)
    Images = dmStandardRes.ilOffice
    MenusShowRecentItemsFirst = False
    PopupMenuLinks = <>
    ShowFullMenusAfterDelay = False
    StretchGlyphs = False
    Style = bmsFlat
    UseSystemFont = True
    Left = 40
    Top = 408
    DockControlHeights = (
      0
      0
      77
      0)
    object miFile: TdxBarSubItem
      Caption = '&'#1044#1086#1082#1091#1084#1077#1085#1090#1099
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Item = btNew
          Visible = True
        end
        item
          Item = btOpen
          Visible = True
        end
        item
          Item = btClose
          Visible = True
        end
        item
          Item = btSave
          Visible = True
        end
        item
          Item = btSaveAs
          Visible = True
        end
        item
          BeginGroup = True
          Item = btPrintEx
          Visible = True
        end
        item
          Item = btShowPreview
          Visible = True
        end
        item
          BeginGroup = True
          Item = btSendDocument
          Visible = True
        end
        item
          BeginGroup = True
          Item = btExit
          Visible = True
        end
        item
          BeginGroup = True
          Item = miMRU
          Visible = True
        end>
    end
    object btNew: TdxBarButton
      Action = acNew
      Category = 2
      Description = #1057#1086#1079#1076#1072#1085#1080#1077' '#1085#1086#1074#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072'.'
    end
    object btOpen: TdxBarButton
      Action = acOpen
      Category = 2
      Description = #1054#1090#1082#1088#1099#1090#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072'.'
    end
    object btExit: TdxBarButton
      Action = acFileExit
      Category = 3
      Description = #1047#1072#1074#1077#1088#1096#1077#1085#1080#1077' '#1088#1072#1073#1086#1090#1099' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103'.'
    end
    object btCut: TdxBarButton
      Action = acCut
      Category = 0
      Description = #1050#1086#1087#1080#1088#1091#1077#1090' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1090#1077#1082#1089#1090' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072', '#1072' '#1079#1072#1090#1077#1084' '#1091#1076#1072#1083#1103#1077#1090' '#1077#1075#1086'.'
    end
    object btCopy: TdxBarButton
      Action = acCopy
      Category = 0
      Description = #1050#1086#1087#1080#1088#1091#1077#1090' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1090#1077#1082#1089#1090' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072'.'
    end
    object btPaste: TdxBarButton
      Action = acPaste
      Category = 0
      Description = #1042#1089#1090#1072#1074#1083#1103#1077#1090' '#1076#1072#1085#1085#1099#1077' '#1080#1079' '#1073#1091#1092#1077#1088#1072' '#1086#1073#1084#1077#1085#1072'.'
    end
    object btPasteSpecial: TdxBarButton
      Action = acSpecialPaste
      Category = 0
      Description = #1042#1089#1090#1072#1074#1083#1103#1077#1090' '#1076#1072#1085#1085#1099#1077' '#1080#1079' '#1073#1091#1092#1077#1088#1072' '#1086#1073#1084#1077#1085#1072' '#1089' '#1074#1086#1079#1084#1086#1078#1085#1086#1089#1090#1100#1102' '#1074#1099#1073#1086#1088#1072' '#1092#1086#1088#1084#1072#1090#1072'.'
    end
    object miText: TdxBarSubItem
      Caption = #1058'&'#1077#1082#1089#1090
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Item = btSelectAll
          Visible = True
        end
        item
          Item = btHideSelection
          Visible = True
        end
        item
          BeginGroup = True
          Item = btUndo
          Visible = True
        end
        item
          Item = btRedo
          Visible = True
        end
        item
          BeginGroup = True
          Item = btCut
          Visible = True
        end
        item
          Item = btCopy
          Visible = True
        end
        item
          Item = btPaste
          Visible = True
        end
        item
          Item = btAdd
          Visible = True
        end
        item
          Item = btInsertFile
          Visible = True
        end
        item
          Item = btPasteSpecial
          Visible = True
        end
        item
          BeginGroup = True
          Item = siStyle
          Visible = True
        end
        item
          BeginGroup = True
          Item = btJustifyLeft
          Visible = True
        end
        item
          Item = btJustifyCenter
          Visible = True
        end
        item
          Item = btJustifyRight
          Visible = True
        end
        item
          Item = btJustifyWidth
          Visible = True
        end
        item
          Item = bcAlignWithSeparator
          Visible = True
        end
        item
          BeginGroup = True
          Item = btJustifyPreformatted
          Visible = True
        end
        item
          BeginGroup = True
          Item = dxTextNonPrintable
          Visible = True
        end
        item
          Item = dxTextSetPrintable
          Visible = True
        end>
    end
    object btUndo: TdxBarButton
      Action = acUndo
      Category = 4
      Description = #1054#1090#1084#1077#1085#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1081' '#1086#1087#1077#1088#1072#1094#1080#1080'.'
    end
    object btRedo: TdxBarButton
      Action = acRedo
      Category = 4
      Description = #1042#1086#1079#1074#1088#1072#1090' '#1087#1086#1089#1083#1077#1076#1085#1077#1081' '#1086#1090#1084#1077#1085#1077#1085#1085#1086#1081' '#1086#1087#1077#1088#1072#1094#1080#1080'.'
    end
    object btAdd: TdxBarButton
      Action = acAdd
      Category = 0
      Description = 
        #1044#1086#1073#1072#1074#1083#1103#1077#1090' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1090#1077#1082#1089#1090' '#1082' '#1091#1078#1077' '#1080#1084#1077#1102#1097#1080#1084#1089#1103' '#1076#1072#1085#1085#1099#1084' '#1074' '#1073#1091#1092#1077#1088#1077' '#1086#1073#1084#1077#1085 +
        #1072'.'
    end
    object btDelete: TdxBarButton
      Action = acDelete
      Category = 5
      Description = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1086#1073#1098#1077#1082#1090'.'
    end
    object btSelectAll: TdxBarButton
      Action = acSelectAll
      Category = 7
      Description = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1077#1089#1100' '#1076#1086#1082#1091#1084#1077#1085#1090'.'
    end
    object btHideSelection: TdxBarButton
      Action = acHideSelection
      Category = 7
      Description = #1059#1073#1088#1072#1090#1100' '#1090#1077#1082#1091#1097#1077#1077' '#1074#1099#1076#1077#1083#1077#1085#1080#1077'.'
    end
    object btShowSpecial: TdxBarButton
      Action = acShowSpecial
      Category = 9
      Description = #1056#1077#1078#1080#1084' '#1087#1086#1082#1072#1079#1072' '#1089#1087#1077#1094#1089#1080#1084#1074#1086#1083#1086#1074'.'
      ButtonStyle = bsChecked
    end
    object miView: TdxBarSubItem
      Caption = '&'#1042#1080#1076
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Item = btShowSpecial
          Visible = True
        end
        item
          Item = btShowDocumentParts
          Visible = True
        end
        item
          Item = btPrintPreview
          Visible = True
        end
        item
          Item = btWebStyle
          Visible = True
        end>
    end
    object btJustifyLeft: TdxBarButton
      Action = acJustifyLeft
      Category = 10
      Description = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1090#1077#1082#1089#1090#1072' '#1087#1086' '#1083#1077#1074#1086#1084#1091' '#1082#1088#1072#1102'.'
      ButtonStyle = bsChecked
      GroupIndex = 1
    end
    object btJustifyCenter: TdxBarButton
      Action = acJustifyCenter
      Category = 10
      Description = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1090#1077#1082#1089#1090#1072' '#1087#1086' '#1094#1077#1085#1090#1088#1091'.'
      ButtonStyle = bsChecked
      GroupIndex = 1
    end
    object btJustifyRight: TdxBarButton
      Action = acJustifyRight
      Category = 10
      Description = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1090#1077#1082#1089#1090#1072' '#1087#1086' '#1087#1088#1072#1074#1086#1084#1091' '#1082#1088#1072#1102'.'
      ButtonStyle = bsChecked
      GroupIndex = 1
    end
    object btJustifyWidth: TdxBarButton
      Action = acJustifyWidth
      Category = 10
      Description = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1090#1077#1082#1089#1090#1072' '#1087#1086' '#1096#1080#1088#1080#1085#1077'.'
      ButtonStyle = bsChecked
      GroupIndex = 1
    end
    object btJustifyPreformatted: TdxBarButton
      Action = acJustifyPreformatted
      Category = 10
      Description = 
        #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1090#1077#1082#1089#1090' '#1082#1072#1082' "'#1087#1088#1077#1092#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1085#1085#1099#1081'". '#1041#1072#1079' '#1085#1072#1088#1077#1079#1082#1080' ' +
        #1085#1072' '#1089#1090#1088#1086#1082#1080' '#1080' '#1089#1086' '#1096#1088#1080#1092#1090#1086#1084' '#1092#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1086#1081' '#1096#1080#1088#1080#1085#1099'.'
      ButtonStyle = bsChecked
      GroupIndex = 1
    end
    object miInsert: TdxBarSubItem
      Caption = #1042#1089#1090#1072#1074'&'#1082#1072
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Item = btInsertSBS
          Visible = True
        end
        item
          Item = btInsertSectionBreak
          Visible = True
        end
        item
          Item = btInsertPageBreak
          Visible = True
        end
        item
          Item = btBuildContents
          Visible = True
        end
        item
          BeginGroup = True
          Item = btInsertPicture
          Visible = True
        end
        item
          Item = btInsertFormula
          Visible = True
        end
        item
          BeginGroup = True
          Item = btInsertBlock
          Visible = True
        end
        item
          Item = dxInsertSubBtn
          Visible = True
        end>
    end
    object miFormat: TdxBarSubItem
      Caption = '&'#1060#1086#1088#1084#1072#1090
      Category = 1
      Visible = ivAlways
      ItemLinks = <>
    end
    object btInsertTable: TdxBarButton
      Action = acInsertTable
      Category = 8
      Description = #1042#1089#1090#1072#1074#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091' '#1089' '#1079#1072#1076#1072#1085#1085#1099#1084' '#1095#1080#1089#1083#1086#1084' '#1089#1090#1088#1086#1082' '#1080' '#1089#1090#1086#1083#1073#1094#1086#1074'.'
    end
    object btInsertRow: TdxBarButton
      Action = acInsertRow
      Category = 8
      Description = #1042#1089#1090#1072#1074#1080#1090#1100' '#1089#1090#1088#1086#1082#1091' '#1090#1072#1073#1083#1080#1094#1099'.'
    end
    object btDeleteRow: TdxBarButton
      Action = acDeleteRow
      Category = 8
      Description = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1088#1086#1082#1091' '#1090#1072#1073#1083#1080#1094#1099'.'
    end
    object btInsertColumn: TdxBarButton
      Action = acInsertColumn
      Category = 8
      Description = #1042#1089#1090#1072#1074#1080#1090#1100' '#1082#1086#1083#1086#1085#1082#1091' '#1090#1072#1073#1083#1080#1094#1099'.'
    end
    object btDeleteColumn: TdxBarButton
      Action = acDeleteColumn
      Category = 8
      Description = #1042#1089#1090#1072#1074#1080#1090#1100' '#1082#1086#1083#1086#1085#1082#1091' '#1090#1072#1073#1083#1080#1094#1099'.'
    end
    object btVAlignTop: TdxBarButton
      Action = acVAlignTop
      Category = 10
      Description = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1089#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1103#1095#1077#1081#1082#1080' '#1082' '#1074#1077#1088#1093#1091'.'
      ButtonStyle = bsChecked
      GroupIndex = 2
    end
    object btVAlignCenter: TdxBarButton
      Action = acVAlignCenter
      Category = 10
      Description = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1089#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1103#1095#1077#1081#1082#1080' '#1087#1086' '#1094#1077#1085#1090#1088#1091'.'
      ButtonStyle = bsChecked
      GroupIndex = 2
    end
    object btVAlignBottom: TdxBarButton
      Action = acVAlignBottom
      Category = 10
      Description = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1089#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1103#1095#1077#1081#1082#1080' '#1082' '#1085#1080#1079#1091'.'
      ButtonStyle = bsChecked
      GroupIndex = 2
    end
    object btSave: TdxBarButton
      Action = acSave
      Category = 2
      Description = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072'.'
    end
    object btSaveAs: TdxBarButton
      Action = acSaveAs
      Category = 2
      Description = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1089' '#1085#1086#1074#1099#1084' '#1080#1084#1077#1085#1077#1084'.'
    end
    object btMergeCells: TdxBarButton
      Action = acMergeCells
      Category = 8
      Description = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1103#1095#1077#1081#1082#1080' '#1090#1072#1073#1083#1080#1094#1099'.'
    end
    object btHSplit: TdxBarButton
      Action = acHSplit
      Category = 8
      Description = #1056#1072#1079#1076#1077#1083#1080#1090#1100' '#1103#1095#1077#1081#1082#1091' '#1087#1086' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1080'.'
      ImageIndex = 247
    end
    object btShowDocumentParts: TdxBarButton
      Action = acShowDocumentParts
      Category = 9
      Description = #1056#1077#1078#1080#1084' '#1087#1086#1082#1072#1079#1072' '#1073#1083#1086#1095#1085#1086#1081' '#1089#1090#1088#1091#1082#1090#1091#1088#1099' '#1076#1086#1082#1091#1084#1077#1085#1090#1072'.'
      ButtonStyle = bsChecked
    end
    object btPrint: TdxBarButton
      Action = acPrint
      Category = 6
      Description = #1055#1077#1095#1072#1090#1100' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072'.'
    end
    object btShowPreview: TdxBarButton
      Action = acPrintPreview
      Category = 6
    end
    object btPrintEx: TdxBarButton
      Action = acPrintEx
      Category = 6
      Description = 
        #1055#1077#1095#1072#1090#1100' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1089' '#1074#1086#1079#1084#1086#1078#1085#1086#1089#1090#1100#1102' '#1079#1072#1076#1072#1085#1080#1103' '#1085#1072#1089#1090#1088#1086#1077#1082' '#1087#1077#1095#1072#1090#1080 +
        '.'
    end
    object btDrawLines: TdxBarButton
      Action = acDrawLines
      Category = 9
      Description = #1056#1077#1078#1080#1084' '#1088#1080#1089#1086#1074#1072#1085#1080#1103' '#1083#1080#1085#1080#1081' '#1087#1089#1077#1074#1076#1086#1075#1088#1072#1092#1080#1082#1086#1081'.'
      ButtonStyle = bsChecked
    end
    object btPrintPreview: TdxBarButton
      Action = acPrintPreviewMode
      Category = 8
      Description = #1056#1077#1078#1080#1084' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1089' '#1092#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1085#1080#1077#1084' '#1087#1086' '#1084#1077#1090#1088#1080#1082#1072#1084' '#1087#1088#1080#1085#1090#1077#1088#1072'.'
      AllowAllUp = True
      ButtonStyle = bsChecked
      GroupIndex = 4
    end
    object btSearch: TdxBarButton
      Action = acSearch
      Category = 11
      Description = #1053#1072#1081#1090#1080' '#1079#1072#1076#1072#1085#1085#1099#1081' '#1092#1088#1072#1075#1084#1077#1085#1090' '#1080#1083#1080' '#1092#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1085#1080#1077'.'
      ImageIndex = 248
    end
    object btReplace: TdxBarButton
      Action = acReplace
      Category = 11
      Description = #1053#1072#1081#1090#1080' '#1080' '#1079#1072#1084#1077#1085#1080#1090#1100' '#1079#1072#1076#1072#1085#1085#1099#1081' '#1092#1088#1072#1075#1084#1077#1085#1090' '#1080#1083#1080' '#1092#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1085#1080#1077'.'
    end
    object btSearchAgain: TdxBarButton
      Action = acSearchAgain
      Category = 11
      Description = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1100' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1081' '#1087#1086#1080#1089#1082'/'#1079#1072#1084#1077#1085#1091'.'
      ImageIndex = 244
    end
    object miTools: TdxBarSubItem
      Caption = '&'#1057#1077#1088#1074#1080#1089
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Item = miConvert
          Visible = True
        end
        item
          Item = dxSetSeparators
          Visible = True
        end
        item
          Item = btSpellCheck
          Visible = True
        end
        item
          BeginGroup = True
          Item = btBuildDocumentStructure
          Visible = True
        end
        item
          Item = btDeleteAllDocumentParts
          Visible = True
        end
        item
          Item = btAutoCompleteCfg
          Visible = True
        end
        item
          BeginGroup = True
          Item = dxAAC
          Visible = True
        end
        item
          BeginGroup = True
          Item = btEditStyles
          Visible = True
        end>
    end
    object btCascade: TdxBarButton
      Action = acWindowCascade
      Category = 12
      Description = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1086#1082#1085#1072' '#1082#1072#1089#1082#1072#1076#1086#1084'.'
    end
    object btTile: TdxBarButton
      Action = acWindowTileHorizontal
      Category = 12
      Description = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1086#1082#1085#1072' '#1095#1077#1088#1077#1087#1080#1094#1077#1081'.'
    end
    object btMinimizeAll: TdxBarButton
      Action = acWindowMinimizeAll
      Category = 12
      Description = #1057#1074#1077#1088#1085#1091#1090#1100' '#1074#1089#1077' '#1086#1082#1085#1072'.'
    end
    object btArrangeIcons: TdxBarButton
      Action = acWindowArrange
      Category = 12
      Description = #1042#1099#1088#1086#1074#1085#1103#1090#1100' '#1079#1085#1072#1095#1082#1080'.'
    end
    object btClose: TdxBarButton
      Action = acWindowClose
      Category = 12
      Description = #1047#1072#1082#1088#1099#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1086#1082#1091#1084#1077#1085#1090'.'
      ShortCut = 16499
    end
    object btPersistent: TdxBarButton
      Action = acPersistent
      Caption = 'P'
      Category = 9
      Description = #1056#1077#1078#1080#1084' '#1082#1086#1075#1076#1072' '#1082#1091#1088#1089#1086#1088' '#1084#1086#1078#1077#1090' '#1087#1077#1088#1077#1076#1074#1080#1075#1072#1090#1100#1089#1103' '#1086#1090#1076#1077#1083#1100#1085#1086' '#1086#1090' '#1074#1099#1076#1077#1083#1077#1085#1080#1103'.'
      ButtonStyle = bsChecked
      PaintStyle = psCaption
    end
    object miMRU: TdxBarMRUListItem
      Caption = 'MRU'
      Category = 2
      Description = #1057#1087#1080#1089#1086#1082' '#1088#1072#1085#1077#1077' '#1086#1090#1082#1088#1099#1074#1072#1074#1096#1080#1093#1089#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074'.'
      Visible = ivAlways
      OnClick = miMRUClick
    end
    object liMDIChildren: TdxBarListItem
      Caption = #1054#1090#1082#1088#1099#1090#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
      Category = 12
      Description = #1057#1087#1080#1089#1086#1082' '#1086#1090#1082#1088#1099#1090#1099#1093' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074'.'
      Hint = #1057#1087#1080#1089#1086#1082' '#1086#1090#1082#1088#1099#1090#1099#1093' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      Visible = ivAlways
      OnClick = liMDIChildrenClick
      OnGetData = liMDIChildrenGetData
      ShowCheck = True
    end
    object cbStyles: TdxBarCombo
      Caption = #1057#1090#1080#1083#1100
      Category = 10
      Description = #1048#1079#1084#1077#1085#1080#1090#1100' '#1089#1090#1080#1083#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1084#1091' '#1090#1077#1082#1089#1090#1091'.'
      Enabled = False
      Hint = #1057#1090#1080#1083#1100
      Visible = ivAlways
      OnChange = cbStylesChange
      Width = 100
      OnDropDown = cbStylesDropDown
      ItemIndex = -1
    end
    object btMergeTables: TdxBarButton
      Action = acMergeTables
      Category = 8
      Description = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1099'.'
      ImageIndex = 245
    end
    object btSordersAndShade: TdxBarButton
      Action = acBordersAndShade
      Category = 10
      Description = #1048#1079#1084#1077#1085#1080#1090#1100' '#1075#1088#1072#1085#1080#1094#1099' '#1080' '#1079#1072#1083#1080#1074#1082#1091' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1084#1091' '#1090#1077#1082#1089#1090#1091'.'
    end
    object seZoom: TdxBarSpinEdit
      Caption = #1052#1072#1089#1096#1090#1072#1073
      Category = 9
      Description = #1052#1072#1089#1096#1090#1072#1073#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1072'.'
      Enabled = False
      Hint = #1052#1072#1089#1096#1090#1072#1073
      Visible = ivAlways
      OnChange = seZoomChange
      Width = 100
      MaxValue = 500.000000000000000000
      MinValue = 10.000000000000000000
      Value = 100.000000000000000000
      OnButtonClick = seZoomButtonClick
    end
    object btMergeCellsHorz: TdxBarButton
      Action = acMergeCellsHorz
      Category = 8
      Description = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1103#1095#1077#1081#1082#1080' '#1090#1072#1073#1083#1080#1094#1099' '#1087#1086' '#1075#1086#1088#1080#1079#1086#1085#1090#1072#1083#1080'.'
      ImageIndex = 241
    end
    object btMergeCellsVert: TdxBarButton
      Action = acMergeCellsVert
      Category = 8
      Description = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1103#1095#1077#1081#1082#1080' '#1090#1072#1073#1083#1080#1094#1099' '#1087#1086' '#1074#1077#1088#1090#1080#1082#1072#1083#1080'.'
      ImageIndex = 243
    end
    object btInsertFile: TdxBarButton
      Action = acInsertFile
      Caption = #1042#1089#1090#1072#1074#1082#1072' '#1080#1079' '#1092#1072#1081#1083#1072'...'
      Category = 13
      Description = #1042#1089#1090#1072#1074#1080#1090#1100' '#1092#1072#1081#1083' '#1074' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1086#1082#1091#1084#1077#1085#1090'.'
    end
    object miSearch: TdxBarSubItem
      Caption = '&'#1055#1086#1080#1089#1082
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Item = btSearch
          Visible = True
        end
        item
          Item = btReplace
          Visible = True
        end
        item
          Item = btSearchAgain
          Visible = True
        end
        item
          Item = dxFindTable
          Visible = True
        end>
    end
    object btInsertPicture: TdxBarButton
      Action = acInsertPicture
      Category = 13
      Description = #1042#1089#1090#1072#1074#1080#1090#1100' '#1088#1080#1089#1091#1085#1086#1082' '#1074' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1086#1082#1091#1084#1077#1085#1090'.'
    end
    object btInsertSBS: TdxBarButton
      Action = acInsertSBS
      Category = 13
      Description = #1042#1089#1090#1072#1074#1080#1090#1100' '#1087#1086#1076#1087#1080#1089#1100' '#1074' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1086#1082#1091#1084#1077#1085#1090'.'
    end
    object btInsertFormula: TdxBarButton
      Action = acInsertFormula
      Category = 13
    end
    object btSpellCheck: TdxBarButton
      Action = acSpellcheck
      Category = 14
      Description = #1055#1088#1086#1074#1077#1088#1082#1072' '#1086#1088#1092#1086#1075#1088#1072#1092#1080#1080'.'
    end
    object miWindow: TdxBarSubItem
      Caption = '&'#1054#1082#1085#1072
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Item = btCascade
          Visible = True
        end
        item
          Item = btTile
          Visible = True
        end
        item
          Item = btArrangeIcons
          Visible = True
        end
        item
          Item = btMinimizeAll
          Visible = True
        end
        item
          BeginGroup = True
          Item = btMDIChildrenList
          Visible = True
        end
        item
          BeginGroup = True
          Item = liMDIChildren
          Visible = True
        end>
    end
    object btInsertPageBreak: TdxBarButton
      Action = acInsertPageBreak
      Category = 13
      Description = #1042#1089#1090#1072#1074#1080#1090#1100' '#1088#1072#1079#1088#1099#1074' '#1089#1090#1088#1072#1085#1080#1094#1099' '#1074' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1086#1082#1091#1084#1077#1085#1090'.'
    end
    object btInsertSectionBreak: TdxBarButton
      Action = acInsertSectionBreak
      Caption = #1056#1072#1079#1076#1077#1083
      Category = 13
      Description = #1042#1089#1090#1072#1074#1080#1090#1100' '#1088#1072#1079#1088#1099#1074' '#1088#1072#1079#1076#1077#1083#1072' '#1074' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1086#1082#1091#1084#1077#1085#1090'.'
      Hint = #1056#1072#1079#1076#1077#1083
    end
    object miInsertBreak: TdxBarSubItem
      Caption = #1056#1072#1079#1088#1099#1074
      Category = 13
      Description = #1042#1089#1090#1072#1074#1082#1072' '#1088#1072#1079#1088#1099#1074#1072'. '
      Visible = ivAlways
      ItemLinks = <>
    end
    object btSubProperties: TdxBarButton
      Action = acSubProperties
      Category = 15
      Description = #1057#1074#1086#1081#1089#1090#1074#1072' '#1084#1077#1090#1082#1080'.'
    end
    object btSubDelete: TdxBarButton
      Action = acSubDelete
      Category = 15
      Description = #1059#1076#1072#1083#1080#1090#1100' '#1084#1077#1090#1082#1091'.'
    end
    object btDocumentPartMerge: TdxBarButton
      Action = acDocumentPartMerge
      Category = 15
      Description = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1073#1083#1086#1082' '#1089#1086' '#1089#1083#1077#1076#1091#1102#1097#1080#1084'.'
    end
    object btSectionPortrait: TdxBarButton
      Action = acSectionPortrait
      Category = 15
      Description = #1050#1085#1080#1078#1085#1072#1103' '#1086#1088#1080#1077#1085#1090#1072#1094#1080#1103' '#1088#1072#1079#1076#1077#1083#1072'.'
      ButtonStyle = bsChecked
      GroupIndex = 1
    end
    object btSectionLandscape: TdxBarButton
      Action = acSectionLandscape
      Category = 15
      Description = #1040#1083#1100#1073#1086#1084#1085#1072#1103' '#1086#1088#1080#1077#1085#1090#1072#1094#1080#1103' '#1088#1072#1079#1076#1077#1083#1072'.'
      ButtonStyle = bsChecked
      GroupIndex = 1
    end
    object btSectionSizeA4: TdxBarButton
      Action = acSectionA4Size
      Category = 15
      Description = #1060#1086#1088#1084#1072#1090' '#1088#1072#1079#1076#1077#1083#1072' '#1040'4.'
      ButtonStyle = bsChecked
      GroupIndex = 2
    end
    object btSectionSizeA3: TdxBarButton
      Action = acSectionA3Size
      Category = 15
      Description = #1060#1086#1088#1084#1072#1090' '#1088#1072#1079#1076#1077#1083#1072' '#1040'3.'
      ButtonStyle = bsChecked
      GroupIndex = 2
    end
    object btCellBordersAndShade: TdxBarButton
      Category = 15
      Description = #1043#1088#1072#1085#1080#1094#1099' '#1080' '#1079#1072#1083#1080#1074#1082#1072' '#1103#1095#1077#1081#1082#1080'.'
      Visible = ivAlways
    end
    object btCellMerge: TdxBarButton
      Action = acCellMerge
      Category = 15
      Description = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1089' '#1089#1086#1089#1077#1076#1085#1077#1081' '#1103#1095#1077#1081#1082#1086#1081'.'
    end
    object btCellDelete: TdxBarButton
      Action = acCellDelete
      Category = 15
      Description = #1059#1076#1072#1083#1080#1090#1100' '#1103#1095#1077#1081#1082#1091'.'
    end
    object btHyperlinkProperties: TdxBarButton
      Action = acHyperlinkProperties
      Category = 15
      Description = #1057#1074#1086#1081#1089#1090#1074#1072' '#1089#1089#1099#1083#1082#1080'.'
    end
    object btHyperlinkFollow: TdxBarButton
      Action = acHyperlinkFollow
      Category = 15
      Description = #1055#1077#1088#1077#1081#1090#1080' '#1087#1086' '#1089#1089#1099#1083#1082#1077'.'
    end
    object btHyperlinkDelete: TdxBarButton
      Action = acHyperlinkDelete
      Category = 15
      Description = #1059#1076#1072#1083#1080#1090#1100' '#1089#1089#1099#1083#1082#1091'.'
    end
    object btSubFollow: TdxBarButton
      Action = acGotoSub
      Category = 15
      Description = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1084#1077#1090#1082#1077'.'
    end
    object btBuildDocumentStructure: TdxBarButton
      Action = acBuildDocumentStructure
      Category = 16
      Description = #1056#1072#1079#1073#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' '#1085#1072' '#1073#1083#1086#1082#1080'.'
    end
    object btSendDocument: TdxBarButton
      Action = acSendDocument
      Category = 16
      Description = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' '#1087#1086' '#1087#1086#1095#1090#1077'.'
    end
    object btEditStyles: TdxBarButton
      Action = acEditStyles
      Category = 10
      Description = #1042#1099#1079#1074#1072#1090#1100' '#1088#1077#1076#1072#1082#1090#1086#1088' '#1089#1090#1080#1083#1077#1081'.'
    end
    object btVisible: TdxBarButton
      Action = acVisible
      Category = 10
      Description = #1055#1086#1084#1077#1090#1080#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1090#1077#1082#1089#1090' '#1082#1072#1082' '#1074#1080#1076#1080#1084#1099#1081'.'
      AllowAllUp = True
      ButtonStyle = bsChecked
    end
    object btWebStyle: TdxBarButton
      Action = acWebStyle
      Category = 9
      Description = 'Web-'#1089#1090#1080#1083#1100'. '#1058#1077#1082#1089#1090' '#1092#1086#1088#1084#1072#1090#1080#1088#1091#1077#1090#1089#1103' '#1087#1086' '#1096#1080#1088#1080#1085#1077' '#1086#1082#1085#1072'.'
      AllowAllUp = True
      ButtonStyle = bsChecked
      GroupIndex = 4
    end
    object btStyle1: TdxBarButton
      Action = acColorSelection
      Category = 10
      Description = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1082' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1084#1091' '#1090#1077#1082#1089#1090#1091' '#1089#1090#1080#1083#1100' "'#1062#1074#1077#1090#1086#1074#1086#1077' '#1074#1099#1076#1077#1083#1077#1085#1080#1077'".'
    end
    object btStyle2: TdxBarButton
      Action = acANSIDOS
      Category = 10
      Description = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1082' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1084#1091' '#1090#1077#1082#1089#1090#1091' '#1089#1090#1080#1083#1100' "'#1052#1086#1085#1086#1096#1080#1088#1080#1085#1085#1099#1081'".'
    end
    object btStyle3: TdxBarButton
      Action = acNormal
      Category = 10
      Description = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1082' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1084#1091' '#1090#1077#1082#1089#1090#1091' '#1089#1090#1080#1083#1100' "'#1053#1086#1088#1084#1072#1083#1100#1085#1099#1081'".'
    end
    object btStyle4: TdxBarButton
      Action = acNormalOEM
      Category = 10
      Description = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1082' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1084#1091' '#1090#1077#1082#1089#1090#1091' '#1089#1090#1080#1083#1100' "'#1053#1086#1088#1084#1072#1083#1100#1085#1099#1081' (OEM)".'
    end
    object btStyle5: TdxBarButton
      Action = acHeading1
      Category = 10
      Description = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1082' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1084#1091' '#1090#1077#1082#1089#1090#1091' '#1089#1090#1080#1083#1100' "'#1047#1072#1075#1086#1083#1086#1074#1086#1082' 1".'
    end
    object btStyle6: TdxBarButton
      Action = acArticleHeading
      Category = 10
      Description = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1082' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1084#1091' '#1090#1077#1082#1089#1090#1091' '#1089#1090#1080#1083#1100' "'#1047#1072#1075#1086#1083#1086#1074#1086#1082' '#1089#1090#1072#1090#1100#1080'".'
    end
    object btStyle7: TdxBarButton
      Action = acOutOfDate
      Category = 10
      Description = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1082' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1084#1091' '#1090#1077#1082#1089#1090#1091' '#1089#1090#1080#1083#1100' "'#1059#1090#1088#1072#1090#1080#1083' '#1089#1080#1083#1091'".'
    end
    object btStyle8: TdxBarButton
      Action = acComment
      Category = 10
      Description = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1082' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1084#1091' '#1090#1077#1082#1089#1090#1091' '#1089#1090#1080#1083#1100' "'#1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081'".'
    end
    object btStyle9: TdxBarButton
      Action = acHyperlinkCont
      Category = 10
      Description = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1082' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1084#1091' '#1090#1077#1082#1089#1090#1091' '#1089#1090#1080#1083#1100' "'#1055#1088#1086#1076#1086#1083#1078#1077#1085#1080#1077' '#1089#1089#1099#1083#1082#1080'".'
    end
    object btStyle0: TdxBarButton
      Action = acLeft
      Category = 10
      Description = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1082' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1084#1091' '#1090#1077#1082#1089#1090#1091' '#1089#1090#1080#1083#1100' "'#1055#1088#1080#1078#1072#1090#1099#1081' '#1074#1083#1077#1074#1086'".'
    end
    object siStyle: TdxBarSubItem
      Caption = #1057#1090#1080#1083#1100
      Category = 10
      Description = #1053#1072#1073#1086#1088' '#1089#1090#1072#1085#1076#1072#1088#1090#1085#1099#1093' '#1089#1090#1080#1083#1077#1081'.'
      Visible = ivAlways
      ItemLinks = <
        item
          Item = btStyle1
          Visible = True
        end
        item
          Item = btStyle2
          Visible = True
        end
        item
          Item = btStyle3
          Visible = True
        end
        item
          Item = btStyle4
          Visible = True
        end
        item
          Item = btStyle5
          Visible = True
        end
        item
          Item = btStyle6
          Visible = True
        end
        item
          Item = btStyle7
          Visible = True
        end
        item
          Item = btStyle8
          Visible = True
        end
        item
          Item = btStyle9
          Visible = True
        end
        item
          Item = btStyle0
          Visible = True
        end
        item
          Item = dxVerInfo
          Visible = True
        end
        item
          Item = dxNotInPower
          Visible = True
        end
        item
          Item = dxAppHeader
          Visible = True
        end>
    end
    object btAdjustMargin: TdxBarButton
      Action = acAdjustMargin
      Category = 9
      Description = #1042#1082#1083#1102#1095#1077#1085#1080#1077'/'#1074#1099#1082#1083#1102#1095#1077#1085#1080#1077' '#1088#1077#1078#1080#1084#1072' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1083#1077#1074#1086#1075#1086' '#1087#1086#1083#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1072'.'
      ButtonStyle = bsChecked
    end
    object btInsertBlock: TdxBarButton
      Action = acInsertBlock
      Category = 13
      Description = #1042#1089#1090#1072#1074#1080#1090#1100' '#1073#1083#1086#1082
    end
    object btConvertTextToTable: TdxBarButton
      Action = acConvertTextToTable
      Category = 16
      Description = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1090#1077#1082#1089#1090' '#1074' '#1090#1072#1073#1083#1080#1094#1091
    end
    object btLo2Up: TdxBarButton
      Action = acLo2Up
      Category = 16
    end
    object btUp2Lo: TdxBarButton
      Action = acUp2Lo
      Category = 16
    end
    object btSwapLoUp: TdxBarButton
      Action = acSwapLoUp
      Category = 16
      Hint = #1048#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1088#1077#1075#1080#1089#1090#1088
    end
    object btText2Para: TdxBarButton
      Action = acText2Para
      Category = 16
    end
    object miConvert: TdxBarSubItem
      Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103
      Category = 16
      Visible = ivAlways
      ItemLinks = <
        item
          Item = btLo2Up
          Visible = True
        end
        item
          Item = btUp2Lo
          Visible = True
        end
        item
          Item = btSwapLoUp
          Visible = True
        end
        item
          Item = btnRussian
          Visible = True
        end
        item
          Item = btnEngCharset
          Visible = True
        end
        item
          Item = btnOEM2ANSI
          Visible = True
        end
        item
          Item = btnANSI2OEM
          Visible = True
        end
        item
          Item = btnDate2Text
          Visible = True
        end
        item
          Item = btnMergePara
          Visible = True
        end>
    end
    object btBuildContents: TdxBarButton
      Action = acBuildContents
      Caption = #1054#1075#1083#1072#1074#1083#1077#1085#1080#1077
      Category = 16
      Description = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1086#1075#1083#1072#1074#1083#1077#1085#1080#1077'.'
      Hint = #1054#1075#1083#1072#1074#1083#1077#1085#1080#1077
    end
    object btMergeRows: TdxBarButton
      Caption = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1089#1090#1088#1086#1082#1080'...'
      Category = 8
      Description = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1089#1090#1088#1086#1082#1080' '#1087#1086#1089#1083#1077' '#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103'.'
      Hint = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1089#1090#1088#1086#1082#1080' '#1087#1086#1089#1083#1077' '#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103
      Visible = ivAlways
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      Category = 8
      Description = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099' '#1076#1083#1103' '#1088#1072#1073#1086#1090#1099' '#1089' '#1090#1072#1073#1083#1080#1094#1072#1084#1080'.'
      Visible = ivAlways
      ItemLinks = <
        item
          Item = btMergeRows
          Visible = True
        end>
    end
    object btMDIChildrenList: TdxBarButton
      Action = acMDIChildList
      Category = 12
      Description = #1057#1087#1080#1089#1086#1082' '#1086#1090#1082#1088#1099#1090#1099#1093' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074'.'
    end
    object btDeleteAllDocumentParts: TdxBarButton
      Action = acDeleteAllDocumentParts
      Category = 16
    end
    object btBullet: TdxBarButton
      Action = acBullet
      Category = 10
      ButtonStyle = bsChecked
    end
    object btNumbering: TdxBarButton
      Action = acNumber
      Category = 10
      ButtonStyle = bsChecked
    end
    object btIncIndent: TdxBarButton
      Action = acIncIndent
      Category = 10
    end
    object btDecIndent: TdxBarButton
      Action = acDecIndent
      Category = 10
    end
    object bcAlignWithSeparator: TdxBarButton
      Action = acAlignWithSeparator
      Category = 10
    end
    object btSectionSizeA2: TdxBarButton
      Action = acSectionA2Size
      Category = 15
      ButtonStyle = bsChecked
      GroupIndex = 2
    end
    object btSectionSizeA1: TdxBarButton
      Action = acSectionA1Size
      Category = 15
      ButtonStyle = bsChecked
      GroupIndex = 2
    end
    object dxDocInfo: TdxBarButton
      Action = acDocInfo
      Category = 15
    end
    object btAutoCompleteCfg: TdxBarButton
      Action = acAutoCompleteSetup
      Category = 16
    end
    object btAutoComplete: TdxBarButton
      Action = acAutoComplete
      Category = 16
    end
    object btnConvertTextToTable: TdxBarButton
      Action = acConvertTextToTable
      Category = 8
    end
    object dxInsertSubItems: TdxBarSubItem
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Category = 8
      Visible = ivAlways
      ItemLinks = <
        item
          Item = btInsertTable
          Visible = True
        end
        item
          Item = btInsertRow
          Visible = True
        end
        item
          Item = btInsertColumn
          Visible = True
        end>
    end
    object dxDeleteItems: TdxBarSubItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 8
      Visible = ivAlways
      ItemLinks = <
        item
          Item = btnDeleteTable
          Visible = True
        end
        item
          Item = btDeleteRow
          Visible = True
        end
        item
          Item = btDeleteColumn
          Visible = True
        end
        item
          Item = btnDeleteCell
          Visible = True
        end>
    end
    object btnDeleteTable: TdxBarButton
      Caption = #1058#1072#1073#1083#1080#1094#1091
      Category = 8
      Hint = #1058#1072#1073#1083#1080#1094#1091
      Visible = ivAlways
      OnClick = btnDeleteTableClick
    end
    object btnDeleteCell: TdxBarButton
      Action = acCellDelete
      Category = 8
    end
    object dxMergeCells: TdxBarSubItem
      Caption = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100
      Category = 8
      Visible = ivAlways
      ItemLinks = <
        item
          Item = btMergeTables
          Visible = True
        end
        item
          Item = btMergeCells
          Visible = True
        end
        item
          Item = btMergeCellsHorz
          Visible = True
        end
        item
          Item = btMergeCellsVert
          Visible = True
        end>
    end
    object dxSplitCells: TdxBarSubItem
      Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1100
      Category = 8
      Visible = ivAlways
      ItemLinks = <
        item
          Item = btnSplitTable
          Visible = True
        end
        item
          Item = btHSplit
          Visible = True
        end
        item
          Item = btVSplit
          Visible = True
        end>
    end
    object btnSplitTable: TdxBarButton
      Action = acSplitTable
      Category = 8
      ImageIndex = 246
    end
    object btnAlignBorrowCells: TdxBarButton
      Action = acAlignCellsBoundary
      Category = 8
    end
    object btnCellsNumbersAlign: TdxBarButton
      Action = acAjustColumnWidth
      Category = 8
    end
    object btnInputCellWidth: TdxBarButton
      Action = acSetCellWidth
      Category = 8
    end
    object dxTables: TdxBarSubItem
      Caption = '&'#1058#1072#1073#1083#1080#1094#1099
      Category = 1
      Visible = ivAlways
      ItemLinks = <
        item
          Item = btSordersAndShade
          Visible = True
        end
        item
          Item = btnConvertTextToTable
          Visible = True
        end
        item
          Item = dxTranslate2Text
          Visible = True
        end
        item
          BeginGroup = True
          Item = dxInsertSubItems
          Visible = True
        end
        item
          Item = dxDeleteItems
          Visible = True
        end
        item
          Item = dxMergeCells
          Visible = True
        end
        item
          Item = dxSplitCells
          Visible = True
        end
        item
          BeginGroup = True
          Item = btnAlignBorrowCells
          Visible = True
        end
        item
          Item = btnCellsNumbersAlign
          Visible = True
        end
        item
          Item = btnInputCellWidth
          Visible = True
        end
        item
          BeginGroup = True
          Item = dxCellAlign
          Visible = True
        end
        item
          BeginGroup = True
          Item = dxTblSetFrame
          Visible = True
        end
        item
          Item = dxTblDelFrame
          Visible = True
        end
        item
          BeginGroup = True
          Item = dxCopyWidths
          Visible = True
        end
        item
          Item = dxPasteWidth
          Visible = True
        end
        item
          Item = dxOldNSRC
          Visible = True
        end>
    end
    object btnRussian: TdxBarButton
      Action = acToolsCnvRusCharset
      Category = 16
    end
    object btnEngCharset: TdxBarButton
      Action = acToolsCnvEngCharset
      Category = 16
    end
    object btnOEM2ANSI: TdxBarButton
      Action = acToolsCnvOEM2ANSI
      Category = 16
    end
    object btnANSI2OEM: TdxBarButton
      Action = acToolsCnvANSI2OEM
      Category = 16
    end
    object btnDate2Text: TdxBarButton
      Action = acToolsCnvDate2Text
      Category = 16
    end
    object btnMergePara: TdxBarButton
      Action = acToolsCnvMergePara
      Category = 16
    end
    object dxCellAlign: TdxBarSubItem
      Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077' '#1103#1095#1077#1081#1082#1080
      Category = 8
      Visible = ivAlways
      ItemLinks = <
        item
          Item = btVAlignTop
          Visible = True
        end
        item
          Item = btVAlignCenter
          Visible = True
        end
        item
          Item = btVAlignBottom
          Visible = True
        end>
    end
    object btVSplit: TdxBarButton
      Action = acVSplit
      Category = 8
      ImageIndex = 242
    end
    object dxAboutBox: TdxBarButton
      Action = acHelpAbout
      Category = 18
    end
    object dxBarHelp: TdxBarSubItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      Category = 18
      Visible = ivAlways
      ItemLinks = <
        item
          Item = dxAboutBox
          Visible = True
        end>
    end
    object dxJump2Sub: TdxBarButton
      Action = acJump2Sub
      Category = 15
    end
    object dxFindTable: TdxBarButton
      Action = acFindTable
      Category = 11
    end
    object dxTblSetFrame: TdxBarButton
      Action = acTblSetFrame
      Category = 8
    end
    object dxTblDelFrame: TdxBarButton
      Action = acTblDelFrame
      Category = 8
    end
    object dxOldNSRC: TdxBarButton
      Action = acOldNSRCTable
      Category = 8
      ButtonStyle = bsChecked
    end
    object dxCopyWidths: TdxBarButton
      Action = acCopyWidths
      Category = 8
    end
    object dxPasteWidth: TdxBarButton
      Action = acApplyWidth
      Category = 8
    end
    object dxAAC: TdxBarButton
      Action = acAAC
      Category = 16
    end
    object dxVerInfo: TdxBarButton
      Action = acVersInfo
      Category = 10
    end
    object dxNotInPower: TdxBarButton
      Action = acNotInPower
      Category = 10
    end
    object dxAppHeader: TdxBarButton
      Action = acAppHeader
      Category = 10
    end
    object dxTextNonPrintable: TdxBarButton
      Action = acSetTextNonPrintable
      Category = 10
    end
    object dxTextSetPrintable: TdxBarButton
      Action = acSetTextPrintable
      Category = 10
    end
    object dxTranslate2Text: TdxBarButton
      Action = acTranslate2Text
      Category = 8
    end
    object dxSetSeparators: TdxBarButton
      Action = acToolsSetSections
      Category = 16
    end
    object dxInsertSubBtn: TdxBarButton
      Action = acInsertSub
      Category = 13
    end
    object btnSplitCells: TdxBarButton
      Action = acSplitCells
      Category = 8
    end
  end
  object pmSub: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Item = btSubProperties
        Visible = True
      end
      item
        Item = btSubDelete
        Visible = True
      end
      item
        Item = btDocumentPartMerge
        Visible = True
      end>
    UseOwnFont = False
    UseRecentItems = True
    Left = 72
    Top = 408
  end
  object pmSection: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Item = btSectionPortrait
        Visible = True
      end
      item
        Item = btSectionLandscape
        Visible = True
      end
      item
        BeginGroup = True
        Item = btSectionSizeA4
        Visible = True
      end
      item
        Item = btSectionSizeA3
        Visible = True
      end
      item
        Item = btSectionSizeA2
        Visible = True
      end
      item
        Item = btSectionSizeA1
        Visible = True
      end>
    UseOwnFont = False
    UseRecentItems = True
    Left = 104
    Top = 408
  end
  object pmHyperlink: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Item = btHyperlinkProperties
        Visible = True
      end
      item
        Item = btHyperlinkFollow
        Visible = True
      end
      item
        Item = btHyperlinkDelete
        Visible = True
      end>
    UseOwnFont = False
    UseRecentItems = True
    Left = 136
    Top = 408
  end
  object pmCell: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Item = btCellBordersAndShade
        Visible = True
      end
      item
        Item = btCellMerge
        Visible = True
      end
      item
        Item = btCellDelete
        Visible = True
      end>
    UseOwnFont = False
    UseRecentItems = True
    Left = 168
    Top = 408
  end
  object pmEditor: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Item = btCut
        Visible = True
      end
      item
        Item = btCopy
        Visible = True
      end
      item
        Item = btPaste
        Visible = True
      end
      item
        Item = btPasteSpecial
        Visible = True
      end
      item
        Item = btDelete
        Visible = True
      end
      item
        BeginGroup = True
        Item = btSearch
        Visible = True
      end
      item
        Item = btReplace
        Visible = True
      end
      item
        Item = btSearchAgain
        Visible = True
      end
      item
        BeginGroup = True
        Item = dxJump2Sub
        Visible = True
      end
      item
        Item = dxDocInfo
        Visible = True
      end
      item
        BeginGroup = True
        Item = btClose
        Visible = True
      end>
    UseOwnFont = False
    UseRecentItems = True
    Left = 200
    Top = 408
  end
  object pmExplorer: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Item = btSubFollow
        Visible = True
      end
      item
        Item = btSubProperties
        Visible = True
      end
      item
        Item = btSubDelete
        Visible = True
      end>
    UseOwnFont = False
    UseRecentItems = True
    OnPopup = pmExplorerPopup
    Left = 232
    Top = 408
  end
end
