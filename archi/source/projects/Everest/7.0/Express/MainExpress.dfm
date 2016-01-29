inherited MainExpressForm: TMainExpressForm
  PixelsPerInch = 120
  TextHeight = 16
  object cbFontSize: TFontSizeComboBox [0]
    Left = 136
    Top = 176
    Width = 57
    Height = 24
    Hint = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072
    Enabled = False
    ItemHeight = 16
    TabOrder = 4
    OnChange = cbFontSizeChange
    FontSize = 0
  end
  inherited theActions: TActionList
    object acBold: TevAction
      Operation = ev_ccBold
      ImageIndex = 98
    end
    object acItalic: TevAction
      Operation = ev_ccItalic
      ImageIndex = 99
    end
    object acUnderline: TevAction
      Operation = ev_ccUnderline
      ImageIndex = 100
    end
    object acStrikeout: TevAction
      Operation = ev_ccStrikeout
      ImageIndex = 113
    end
    object acSubscript: TevAction
      Operation = ev_ccSubscript
      ImageIndex = 118
    end
    object acSuperscript: TevAction
      Operation = ev_ccSuperscript
      ImageIndex = 117
    end
  end
  inherited dxBarManager: TdxBarManager
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
            Item = miFormat
            Visible = True
          end
          item
            Item = miTools
            Visible = True
          end
          item
            Item = miTable
            Visible = True
          end
          item
            Item = miSearch
            Visible = True
          end
          item
            Item = miWindow
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
        DockedTop = 27
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
        DockedLeft = 113
        DockedTop = 27
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
        DockedLeft = 180
        DockedTop = 27
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
        DockedLeft = 508
        DockedTop = 27
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
        DockedLeft = 552
        DockedTop = 27
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
        DockedTop = 54
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
            Item = btDeleteRow
            Visible = True
          end
          item
            Item = btInsertColumn
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
            Item = btSplitCells
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
        DockedLeft = 399
        DockedTop = 54
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
        DockedLeft = 379
        DockedTop = 27
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
        DockedTop = 27
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
            Item = btReplace
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
        DockedLeft = 489
        DockedTop = 54
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
        DockedTop = 54
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
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1096#1088#1080#1092#1090#1072
        DockedDockingStyle = dsTop
        DockedLeft = 181
        DockedTop = 81
        DockingStyle = dsTop
        FloatLeft = 234
        FloatTop = 178
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = btBold
            Visible = True
          end
          item
            Item = btItalic
            Visible = True
          end
          item
            Item = btUnderline
            Visible = True
          end
          item
            Item = btStrikeout
            Visible = True
          end
          item
            Item = btSubscript
            Visible = True
          end
          item
            Item = btSuperscript
            Visible = True
          end>
        OneOnRow = False
        Row = 3
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = #1043#1072#1088#1085#1080#1090#1091#1088#1072' '#1096#1088#1080#1092#1090#1072
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 81
        DockingStyle = dsTop
        FloatLeft = 234
        FloatTop = 178
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = cbFontName
            Visible = True
          end>
        OneOnRow = False
        Row = 3
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072
        DockedDockingStyle = dsTop
        DockedLeft = 340
        DockedTop = 81
        DockingStyle = dsTop
        FloatLeft = 346
        FloatTop = 291
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = ccFontSize
            Visible = True
          end>
        Name = #1056#1072#1079#1084#1077#1088' '#1096#1088#1080#1092#1090#1072
        OneOnRow = False
        Row = 3
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end
      item
        Caption = #1057#1087#1080#1089#1082#1080
        DockedDockingStyle = dsTop
        DockedLeft = 418
        DockedTop = 81
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
          end
          item
            Item = btDecIndent
            Visible = True
          end
          item
            Item = btIncIndent
            Visible = True
          end>
        Name = #1057#1087#1080#1089#1082#1080
        OneOnRow = False
        Row = 3
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end>
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
      True)
    DockControlHeights = (
      0
      0
      109
      0)
    object btBold: TdxBarButton
      Action = acBold
      Category = 17
      ButtonStyle = bsChecked
    end
    object btItalic: TdxBarButton
      Action = acItalic
      Category = 17
      ButtonStyle = bsChecked
    end
    object btUnderline: TdxBarButton
      Action = acUnderline
      Category = 17
      ButtonStyle = bsChecked
    end
    object btStrikeout: TdxBarButton
      Action = acStrikeout
      Category = 17
      ButtonStyle = bsChecked
    end
    object btSubscript: TdxBarButton
      Action = acSubscript
      Category = 17
      ButtonStyle = bsChecked
      GroupIndex = 3
    end
    object btSuperscript: TdxBarButton
      Action = acSuperscript
      Category = 17
      ButtonStyle = bsChecked
      GroupIndex = 3
    end
    object cbFontName: TdxBarFontNameCombo
      Caption = #1043#1072#1088#1085#1080#1090#1091#1088#1072
      Category = 17
      Enabled = False
      Hint = #1043#1072#1088#1085#1080#1090#1091#1088#1072
      Visible = ivAlways
      OnChange = cbFontNameChange
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888888888888888888888888888888888888444488844444488887488888744
        7888888448888744888888874888844788888888444444488888888874884478
        8888888884484488888888888744478888888888884448888888888888747888
        8888888888848888888888888888888888888888888888888888}
      Width = 160
      DropDownCount = 12
    end
    object ccFontSize: TdxBarControlContainerItem
      Caption = #1050#1077#1075#1083#1100
      Category = 17
      Enabled = False
      Hint = #1050#1077#1075#1083#1100
      Visible = ivAlways
      Control = cbFontSize
    end
  end
end
