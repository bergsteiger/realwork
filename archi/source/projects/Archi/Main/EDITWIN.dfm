object DocEditorWindow: TDocEditorWindow
  Left = 750
  Top = 216
  Width = 941
  Height = 569
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0FFFFFFFFFFFFFFFFFFFFFF0000000000FFFFFFFFFFFFFFFFFFFFFF000000000
    0F000000000FFFFFFFFFFFF0000000000F000000000FFFFFFFFFFFF000000000
    0FFFFFFFFFFFFFFFFFFFFFF0000000000FFFFFFFFFFFFFFFFFFFFFF000000000
    0F0000FF000000000FF00FF0000000000F0000FF000000000FF00FF000000000
    0FFFFFFFFFFFFFFFFFFFFFF0000000000FFFFFFFFFFFFFFFFFFFFFF000000000
    0F000000000FF00000000FF0000000000F000000000FF00000000FF000000000
    0FFFFFFFFFFFFFFFFFFFFFF0000000000FFFFFFFFFFFFFFFFFFFFFF000000000
    0F0000FF000000FF00000FF0000000000F0000FF000000FF00000FF000000000
    0FFFFFFFFFFFFFFFFFFFFFF0000000000FFFFFFFFFFFFFFFFFFFFFF000000000
    0000000000FF0000FF000FF00000000000FFFFFFF0FF0000FF000FF000000000
    000FFFFFF0FFFFFFFFFFFFF0000000000000FFFFF0FFFFFFFFFFFFF000000000
    00000FFFF0FF00FF00000FF000000000000000FFF0FF00FF00000FF000000000
    0000000FF0FFFFFFFFFFFFF00000000000000000F0FFFFFFFFFFFFF000000000
    0000000000FFFFFFFFFFFFF00000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000
    000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000
    000FF000000FF000000FF000000FF000000FF800000FFC00000FFE00000FFF00
    000FFF80000FFFC0000FFFE0000FFFF0000FFFF8000FFFFFFFFFFFFFFFFF}
  Menu = TextEditMenu
  OldCreateOrder = True
  PopupMenu = MainPopupMenu
  Position = poDefault
  Scaled = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object WinSplitLine: TvtSplitter
    Left = 0
    Top = 46
    Width = 5
    Height = 425
    Cursor = crHSplit
    Beveled = True
    Visible = False
  end
  object ModalButtonPanel: TPanel
    Left = 0
    Top = 471
    Width = 925
    Height = 40
    Align = alBottom
    TabOrder = 1
    Visible = False
    object TPanel
      Left = 666
      Top = 1
      Width = 258
      Height = 38
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object OK: TBitBtn
        Left = 10
        Top = 6
        Width = 77
        Height = 27
        TabOrder = 0
        Kind = bkOK
        Margin = 2
        Spacing = -1
        IsControl = True
      end
      object Cancel: TBitBtn
        Left = 93
        Top = 6
        Width = 77
        Height = 27
        TabOrder = 1
        Kind = bkCancel
        Margin = 2
        Spacing = -1
        IsControl = True
      end
      object Help: TBitBtn
        Left = 176
        Top = 6
        Width = 77
        Height = 27
        Caption = 'Help'
        TabOrder = 2
        Kind = bkHelp
        Margin = 2
        Spacing = -1
        IsControl = True
      end
    end
  end
  object WarnPanel: TPanel
    Left = 0
    Top = 0
    Width = 925
    Height = 22
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Color = clPurple
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Visible = False
  end
  object nbkDocPages: TOvcNotebook
    Left = 5
    Top = 46
    Width = 920
    Height = 425
    ActiveTabFont.Charset = RUSSIAN_CHARSET
    ActiveTabFont.Color = clWindowText
    ActiveTabFont.Height = -13
    ActiveTabFont.Name = 'Arial'
    ActiveTabFont.Style = [fsBold]
    ConserveResources = True
    DefaultPageIndex = 2
    PageHelpContext = 0
    Style = bsNew
    TabIndent = 0
    TabRowCount = 2
    TabWidth = 131
    OnPageChange = nbkDocPagesPageChange
    OnPageChanged = nbkDocPagesPageChanged
    AutoTabSize = False
    Align = alClient
    Ctl3D = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TabStop = False
    object TOvcNotebookPage
      Caption = '&'#1053#1072#1079#1074#1072#1085#1080#1077
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 911
        Height = 304
        Align = alClient
        BorderWidth = 6
        TabOrder = 0
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 911
        Height = 304
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 6
        Caption = 'Panel3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object FullNameMEdit: TevMemo
          Left = 6
          Top = 26
          Width = 899
          Height = 272
          TextSource.OnBruttoCharCountChange = FullNameMEditTextSourceBruttoCharCountChange
          Align = alClient
          RMargin = 8
          Ctl3D = True
          ParentFont = True
          ParentCtl3D = False
          PopupMenu = ClipbrdPopUpMenu
          TabOrder = 0
          TabStop = True
          BorderStyle = bsSingle
          OnExit = FullNameMEditExit
        end
        object Panel7: TPanel
          Left = 6
          Top = 6
          Width = 899
          Height = 20
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object Label8: TLabel
            Left = 1
            Top = 0
            Width = 304
            Height = 20
            AutoSize = False
            Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          end
        end
      end
      object SNPanel: TPanel
        Left = 0
        Top = 304
        Width = 911
        Height = 75
        Align = alBottom
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnResize = SNPanelResize
        object Label1: TLabel
          Left = 8
          Top = 59
          Width = 269
          Height = 21
          AutoSize = False
          Caption = '&'#1050#1086#1088#1086#1090#1082#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        end
        object Label7: TLabel
          Left = 7
          Top = 3
          Width = 269
          Height = 21
          AutoSize = False
          Caption = #1050#1086'&'#1084#1084#1077#1085#1090#1072#1088#1080#1081
        end
        object ShortNameEdit: TevEdit
          Left = 6
          Top = 80
          Width = 630
          Height = 28
          TextSource.OnBruttoCharCountChange = ShortNameEditChange
          LMargin = 1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          UpperCase = True
          Ctl3D = True
          ParentCtl3D = False
          PopupMenu = ClipbrdPopUpMenu
          TabOrder = 1
          TabStop = True
          BorderStyle = bsSingle
        end
        object CommentEdit: TevEdit
          Left = 9
          Top = 25
          Width = 630
          Height = 28
          LMargin = 1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Ctl3D = True
          ParentCtl3D = False
          PopupMenu = ClipbrdPopUpMenu
          TabOrder = 0
          TabStop = True
          BorderStyle = bsSingle
        end
      end
    end
    object TOvcNotebookPage
      Caption = '&'#1040#1090#1088#1080#1073#1091#1090#1099
      inline MainAttrExplorer: TAttrExplorer
        Left = 0
        Top = 0
        Width = 0
        Height = 0
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        inherited otlAttributes: TvtOutliner
          Width = 0
          Height = 0
          Font.Height = -15
          Font.Name = 'Arial'
          PopupMenu = PriznPopUpMenu
          OnActionElement = otlAttributesActionElement
        end
        inherited AttrFooter: TvtStatusBar
          Top = 0
          Width = 0
        end
        inherited AttrPopUpMenu: TLinkPopUpMenu
          Left = 306
          Top = 125
        end
      end
    end
    object TOvcNotebookPage
      Caption = '&'#1058#1077#1082#1089#1090
      object Splitter1: TvtSplitter
        Left = 121
        Top = 0
        Width = 3
        Height = 0
        Cursor = crHSplit
        Beveled = True
        MinSize = 20
        ResizeStyle = rsLine
      end
      inline DocTextEditor: TTextEditorWin
        Left = 124
        Top = 0
        Width = 787
        Height = 0
        Align = alClient
        TabOrder = 1
        inherited HRuler: TevRuler
          Width = 787
        end
        inherited VRuler: TevRuler
          Height = 0
        end
        inherited SubShowPanel: TevSubPanel
          Height = 0
          PopupMenu = SubPanelPopUpMenu
          OnClickSub = SubShowPanelClickSub
          OnMenuSub = SubShowPanelMenuSub
          OnMouseOverSub = SubShowPanelMouseOverSub
        end
        inherited DocEditor: TevEditor
          Width = 752
          Height = 0
          OnParaChange = evntEditorParaChange
          OnFontChange = evntEditorFontChange
          OnStyleChange = evntEditorStyleChange
          OnJumpTo = evntDocEditorJumpTo
          OnMouseAction = DocTextEditorDocEditorMouseAction
          PopupMenu = TextPopupMenu
        end
        inherited FooterPanel: TvtStatusBar
          Top = 30
          Width = 787
        end
        inherited pmRuller: TPopupMenu
          Left = 138
          Top = 72
        end
      end
      object otlBlocks: TvtOutliner
        Left = 0
        Top = 0
        Width = 121
        Height = 0
        AutoRowHeight = False
        BorderStyle = bsSingle
        Columns = 255
        IntegralHeight = False
        MultiSelect = False
        MultiStrokeItem = True
        OpenChipColor = clBlack
        ProtectColor.BackColor = clRed
        ProtectColor.TextColor = clWhite
        RowHeight = 20
        ScrollStyle = ssVertical
        SelectColor.BackColor = clHighlight
        SelectColor.TextColor = clHighlightText
        SelectNonFocusColor.BackColor = clBtnFace
        SelectNonFocusColor.TextColor = clBtnText
        SelfDrawNodes = False
        ShowHeader = False
        UseTabStops = False
        PickedList = False
        ReadOnly = False
        ShowRoot = False
        OnGetItemImage = otlBlocksGetItemImage
        OnGetItemFont = otlBlocksGetItemFont
        Align = alLeft
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = True
        PopupMenu = pmBlockTree
        TabOrder = 0
        TabStop = True
        VJustify = vt_vjCenter
        OnActionElement = otlBlocksActionElement
        IsShowLines = True
        ShowExpandable = True
        ShowOpenChip = True
        ViewOptions = [voShowInterRowSpace, voShowIcons, voShowExpandable, voShowLines, voShowOpenChip]
        EditOptions = [eoItemExpand]
      end
    end
    object TOvcNotebookPage
      Caption = #1054#1073#1098#1077#1082'&'#1090
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 0
        Height = 36
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnResize = Panel1Resize
        object edtObjectFilePath: TVEdit
          Left = 4
          Top = 3
          Width = 635
          Height = 28
          Hint = #1055#1091#1090#1100' '#1082' '#1075#1088#1072#1092#1080#1095#1077#1089#1082#1086#1084#1091' '#1092#1072#1081#1083#1091'|'
          CharCase = ecUpperCase
          Ctl3D = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          PopupMenu = ClipbrdPopUpMenu
          TabOrder = 0
          OnExit = edtObjectFilePathExit
        end
        object Panel4: TPanel
          Left = 576
          Top = 2
          Width = 65
          Height = 31
          BevelOuter = bvNone
          TabOrder = 1
          object btnExportObj: TSpeedButton
            Left = 35
            Top = 1
            Width = 28
            Height = 28
            Hint = #1047#1072#1087#1080#1089#1072#1090#1100' '#1086#1073#1098#1077#1082#1090' '#1080#1079' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1085#1072' '#1076#1080#1089#1082
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
              333333333333337FF3333333333333903333333333333377FF33333333333399
              03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
              99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
              99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
              03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
              33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
              33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
              3333777777333333333333333333333333333333333333333333}
            NumGlyphs = 2
            ParentShowHint = False
            ShowHint = True
            OnClick = btnExportObjClick
          end
          object btnReplaceObj: TSpeedButton
            Left = 2
            Top = 1
            Width = 28
            Height = 28
            Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1086#1073#1098#1077#1082#1090' '#1080#1079' '#1092#1072#1081#1083#1072
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
              FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
              00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
              F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
              00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
              F033777777777337F73309999990FFF0033377777777FFF77333099999000000
              3333777777777777333333399033333333333337773333333333333903333333
              3333333773333333333333303333333333333337333333333333}
            NumGlyphs = 2
            ParentShowHint = False
            ShowHint = True
            OnClick = btnReplaceObjClick
          end
        end
      end
      object pnlObject: TPanel
        Left = 0
        Top = 36
        Width = 0
        Height = 343
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        OnResize = pnlObjectResize
        object ieView: TImageEnView
          Left = 0
          Top = 0
          Width = 0
          Height = 343
          Cursor = crArrow
          ParentCtl3D = False
          BorderStyle = bsNone
          ZoomFilter = rfFastLinear
          MouseInteract = [miScroll]
          DelayZoomFilter = True
          Align = alClient
          Enabled = False
          PopupMenu = pmPicture
          TabOrder = 0
        end
      end
    end
    object TOvcNotebookPage
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      inline SprTextEditor: TTextEditorWin
        Left = 0
        Top = 0
        Width = 0
        Height = 0
        Align = alClient
        TabOrder = 0
        inherited HRuler: TevRuler
          Width = 35
        end
        inherited VRuler: TevRuler
          Height = 0
        end
        inherited SubShowPanel: TevSubPanel
          Height = 0
          PopupMenu = RelSubPanelPopupMenu
          OnClickSub = SubShowPanelClickSub
          OnMenuSub = SubShowPanelMenuSub
        end
        inherited DocEditor: TevEditor
          Width = 0
          Height = 0
          OnParaChange = evntEditorParaChange
          OnFontChange = evntEditorFontChange
          OnStyleChange = evntEditorStyleChange
          OnJumpTo = evntDocEditorJumpTo
          OnMouseAction = DocTextEditorDocEditorMouseAction
          PopupMenu = TextPopupMenu
        end
        inherited FooterPanel: TvtStatusBar
          Top = 30
          Width = 35
        end
        inherited pmRuller: TPopupMenu
          Left = 414
          Top = 128
        end
      end
    end
    object TOvcNotebookPage
      Caption = #1040#1085#1085'&'#1086#1090#1072#1094#1080#1103
      object Panel500: TPanel
        Left = 0
        Top = 0
        Width = 0
        Height = 36
        Align = alTop
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnResize = Panel5Resize
        object edtAnnoName: TevEdit
          Left = 5
          Top = 4
          Width = 635
          Height = 28
          Hint = #1047#1072#1075#1086#1083#1086#1074#1086#1082' '#1072#1085#1085#1086#1090#1072#1094#1080#1080'|'
          TextSource.OnBruttoCharCountChange = edtAnnoNameTextSourceBruttoCharCountChange
          LMargin = 1
          ParentFont = True
          PopupMenu = ClipbrdPopUpMenu
          TabOrder = 0
          TabStop = True
          BorderStyle = bsSingle
        end
      end
      inline AnnoTextEditor: TTextEditorWin
        Left = 0
        Top = 36
        Width = 0
        Height = 343
        Align = alClient
        TabOrder = 0
        inherited HRuler: TevRuler
          Width = 35
        end
        inherited VRuler: TevRuler
          Height = 293
        end
        inherited SubShowPanel: TevSubPanel
          Height = 293
          PopupMenu = RelSubPanelPopupMenu
          OnClickSub = SubShowPanelClickSub
          OnMenuSub = SubShowPanelMenuSub
        end
        inherited DocEditor: TevEditor
          Width = 0
          Height = 293
          OnParaChange = evntEditorParaChange
          OnFontChange = evntEditorFontChange
          OnStyleChange = evntEditorStyleChange
          OnJumpTo = evntDocEditorJumpTo
          OnMouseAction = DocTextEditorDocEditorMouseAction
          PopupMenu = AnnoPopUpMenu
        end
        inherited FooterPanel: TvtStatusBar
          Top = 323
          Width = 35
        end
      end
      object cbxHasAnno: TCheckBox
        Left = 4
        Top = 41
        Width = 19
        Height = 21
        TabOrder = 2
        Visible = False
      end
    end
    object TOvcNotebookPage
      Caption = #1040#1090#1088#1080#1073#1091#1090#1099' '#1084#1077#1090#1086#1082
      object ClassSubsPanel: TPanel
        Left = 0
        Top = 0
        Width = 0
        Height = 30
        Align = alTop
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnResize = ClassSubsPanelResize
        object ClassAnchorImage: TImage
          Left = 6
          Top = 6
          Width = 18
          Height = 21
          Picture.Data = {
            07544269746D6170F6000000424DF60000000000000076000000280000001000
            0000100000000100040000000000800000000000000000000000100000000000
            000000000000000080000080000000808000800000008000800080800000C0C0
            C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
            FF00FFFFFF4444FFFFFFFFFF44444444FFFFFFF444F44F444FFFFFF4FFF44FFF
            4FFFFFF4FFF44FFF4FFFFF444FF44FF444FFFFF4FFF44FFF4FFFFFFFFFF44FFF
            FFFFFFFFF444444FFFFFFFFF44444444FFFFFFFFFFF44FFFFFFFFFFFFF4774FF
            FFFFFFFFFF4FF4FFFFFFFFFFFF4774FFFFFFFFFFFFF44FFFFFFFFFFFFFFFFFFF
            FFFF}
          Transparent = True
        end
        object btnAllSabs: TSpeedButton
          Left = 526
          Top = 4
          Width = 105
          Height = 22
          Caption = #1042#1089#1077' '#1084#1077#1090#1082#1080
          OnClick = btnAllSabsClick
        end
        object cbClassSubs: TvtComboTree
          Left = 32
          Top = 3
          Width = 489
          Height = 24
          Hint = #1057#1087#1080#1089#1086#1082' '#1084#1077#1090#1086#1082'|'
          OnGetItemImage = otlBlocksGetItemImage
          OnChange = cbClassSubsChange
        end
      end
      inline SubAttrExplorer: TAttrExplorer
        Left = 0
        Top = 30
        Width = 0
        Height = 353
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        inherited otlAttributes: TvtOutliner
          Width = 0
          Height = 333
          Font.Height = -15
          Font.Name = 'Arial'
          PopupMenu = PriznPopUpMenu
          OnActionElement = otlAttributesActionElement
        end
        inherited AttrFooter: TvtStatusBar
          Top = 333
          Width = 0
        end
      end
    end
    object TOvcNotebookPage
      Caption = '&'#1043#1088#1072#1092'. '#1086#1073#1088#1072#1079
      object pnlDocImageContainer: TPanel
        Left = 0
        Top = 0
        Width = 0
        Height = 0
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        OnResize = pnlDocImageContainerResize
        object cbCorSources: TComboBox
          Left = 416
          Top = 5
          Width = 214
          Height = 24
          Style = csDropDownList
          ItemHeight = 16
          TabOrder = 0
          OnChange = cbCorSourcesChange
        end
      end
    end
    object TOvcNotebookPage
      Caption = '&'#1052#1077#1090#1082#1080
      object SubList: TvtDStringLister
        Left = 0
        Top = 0
        Width = 0
        Height = 359
        Sorted = False
        Images = ArchiResources.CommonImageList
        AutoRowHeight = False
        BorderStyle = bsSingle
        Columns = 255
        IntegralHeight = False
        MultiSelect = False
        ProtectColor.BackColor = clRed
        ProtectColor.TextColor = clWhite
        RowHeight = 20
        ScrollStyle = ssVertical
        SelectColor.BackColor = clHighlight
        SelectColor.TextColor = clHighlightText
        SelectNonFocusColor.BackColor = clInactiveCaption
        SelectNonFocusColor.TextColor = clHighlightText
        ShowHeader = False
        UseTabStops = False
        PickedList = False
        MultiStrokeItem = True
        ReadOnly = False
        ViewOptions = [voShowInterRowSpace]
        OnGetItemImageIndex = SubListGetItemImageIndex
        OnCurrentChanged = SubListCurrentChanged
        Align = alClient
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = True
        ParentShowHint = False
        PopupMenu = pmSubList
        ShowHint = False
        TabOrder = 0
        TabStop = True
        OnActionElement = SubListActionElement
      end
      object SubDocFooter: TvtStatusBar
        Left = 0
        Top = -20
        Width = 0
        Height = 20
        Panels = <
          item
            Alignment = taCenter
            Width = 150
          end
          item
            Width = 50
          end>
      end
    end
    object TOvcNotebookPage
      Caption = '&'#1056#1077#1089#1087#1086#1085#1076#1077#1085#1090#1099
      object ChildDocOutliner: TvtOutliner
        Left = 0
        Top = 0
        Width = 0
        Height = 365
        AutoRowHeight = False
        BorderStyle = bsSingle
        Columns = 255
        IntegralHeight = False
        MultiSelect = False
        MultiStrokeItem = True
        OpenChipColor = clBlack
        ProtectColor.BackColor = clRed
        ProtectColor.TextColor = clWhite
        RowHeight = 20
        ScrollStyle = ssVertical
        SelectColor.BackColor = clHighlight
        SelectColor.TextColor = clHighlightText
        SelectNonFocusColor.BackColor = clBtnFace
        SelectNonFocusColor.TextColor = clBtnText
        SelfDrawNodes = False
        ShowHeader = False
        UseTabStops = False
        PickedList = False
        ReadOnly = False
        ShowRoot = False
        OnGetItemImage = ChildDocOutlinerGetItemImage
        OnCurrentChanged = ChildDocOutlinerCurrentChanged
        Align = alClient
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = True
        TabOrder = 0
        TabStop = True
        VJustify = vt_vjCenter
        OnActionElement = ChildDocOutlinerActionElement
        IsShowLines = False
        ShowExpandable = True
        ShowOpenChip = True
        ViewOptions = [voShowInterRowSpace, voShowIcons, voShowExpandable, voShowOpenChip]
        EditOptions = [eoItemExpand]
      end
      object ChildDocFooter: TvtStatusBar
        Left = 0
        Top = -20
        Width = 0
        Height = 20
        Panels = <
          item
            Alignment = taCenter
            Width = 150
          end
          item
            Width = 50
          end>
      end
    end
    object TOvcNotebookPage
      Caption = '&'#1050#1086#1088#1088#1077#1089#1087#1086#1085#1076#1077#1085#1090#1099
      object ParentDocList: TvtLister
        Left = 0
        Top = 25
        Width = 0
        Height = 340
        Images = ArchiResources.CommonImageList
        AutoRowHeight = False
        BorderStyle = bsSingle
        Columns = 255
        IntegralHeight = False
        MultiSelect = False
        InternalSelector = True
        ProtectColor.BackColor = clRed
        ProtectColor.TextColor = clWhite
        RowHeight = 20
        ScrollStyle = ssVertical
        SelectColor.BackColor = clHighlight
        SelectColor.TextColor = clHighlightText
        SelectNonFocusColor.BackColor = clInactiveCaption
        SelectNonFocusColor.TextColor = clHighlightText
        ShowHeader = False
        UseTabStops = False
        PickedList = False
        TriplePicked = False
        MultiStrokeItem = True
        ReadOnly = False
        ViewOptions = [voShowInterRowSpace]
        ActionElementMode = l3_amDoubleClick
        OnGetStrItem = ParentDocListGetStrItem
        OnGetItemImageIndex = ParentDocListGetItemImageIndex
        OnCurrentChanged = ParentDocListCurrentChanged
        Align = alClient
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = True
        PopupMenu = pmCrrespList
        TabOrder = 1
        TabStop = True
        OnActionElement = ParentDocListActionElement
      end
      object WarnCorespForBlockPanel: TPanel
        Left = 0
        Top = 0
        Width = 0
        Height = 25
        Align = alTop
        Alignment = taLeftJustify
        Caption = '  '#1050#1086#1088#1088#1077#1089#1087#1086#1085#1076#1077#1085#1090#1099' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1092#1088#1072#1075#1084#1077#1085#1090#1072
        Color = clActiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clCaptionText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Visible = False
        object Panel6: TPanel
          Left = -23
          Top = 1
          Width = 22
          Height = 23
          Align = alRight
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          DesignSize = (
            22
            23)
          object sbCloseCorespondentsForBlock: TSpeedButton
            Left = 3
            Top = 4
            Width = 16
            Height = 16
            Anchors = [akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clCaptionText
            Font.Height = -16
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Glyph.Data = {
              D6000000424DD60000000000000076000000280000000C0000000C0000000100
              0400000000006000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
              0000888888888888000080088888008800008000888000880000880008000888
              0000888000008888000088880008888800008880000088880000880008000888
              0000800088800088000080088888008800008888888888880000}
            ParentFont = False
            OnClick = sbCloseCorespondentsForBlockClick
          end
        end
      end
      object ParentDocFooter: TvtStatusBar
        Left = 0
        Top = -20
        Width = 0
        Height = 20
        Panels = <
          item
            Alignment = taCenter
            Width = 150
          end
          item
            Width = 50
          end>
      end
    end
    object TOvcNotebookPage
      Caption = #1056#1077'&'#1076#1072#1082#1094#1080#1080
      object lstVersion: TvtIStrListLister
        Left = 0
        Top = 0
        Width = 0
        Height = 365
        Images = ArchiResources.CommonImageList
        AutoRowHeight = False
        BorderStyle = bsSingle
        Columns = 255
        IntegralHeight = False
        MultiSelect = False
        ProtectColor.BackColor = clRed
        ProtectColor.TextColor = clWhite
        RowHeight = 20
        ScrollStyle = ssVertical
        SelectColor.BackColor = clHighlight
        SelectColor.TextColor = clHighlightText
        SelectNonFocusColor.BackColor = clInactiveCaption
        SelectNonFocusColor.TextColor = clHighlightText
        ShowHeader = False
        UseTabStops = False
        PickedList = False
        MultiStrokeItem = True
        ReadOnly = False
        ViewOptions = [voShowInterRowSpace]
        OnGetItemImageIndex = lstVersionGetItemImageIndex
        OnGetItemFont = lstVersionGetItemFont
        OnCurrentChanged = lstVersionCurrentChanged
        Align = alClient
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = True
        TabOrder = 0
        TabStop = True
        OnActionElement = lstVersionActionElement
      end
      object VersionFooter: TvtStatusBar
        Left = 0
        Top = -20
        Width = 0
        Height = 20
        Panels = <
          item
            Alignment = taCenter
            Width = 150
          end
          item
            Width = 50
          end>
      end
    end
    object TOvcNotebookPage
      Caption = '&'#1046#1091#1088#1085#1072#1083#1099
      object nbkJournals: TOvcNotebook
        Left = 0
        Top = 0
        Width = 911
        Height = 379
        ActiveTabFont.Charset = RUSSIAN_CHARSET
        ActiveTabFont.Color = clWindowText
        ActiveTabFont.Height = -13
        ActiveTabFont.Name = 'Arial'
        ActiveTabFont.Style = [fsBold]
        ConserveResources = False
        PageHelpContext = 0
        TabIndent = 0
        TabOrientation = toRight
        TabRowCount = 1
        TabWidth = 94
        OnPageChange = nbkJournalsPageChange
        AutoTabSize = False
        Align = alClient
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object TOvcNotebookPage
          Caption = #1057'&'#1086#1089#1090#1086#1103#1085#1080#1077
          object ExpDatePanel: TPanel
            Left = 0
            Top = 0
            Width = 888
            Height = 373
            Align = alClient
            BevelOuter = bvNone
            Ctl3D = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 0
            object Label2: TLabel
              Left = 64
              Top = 14
              Width = 39
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = #1058#1080#1087
            end
            object Label4: TLabel
              Left = 66
              Top = 76
              Width = 101
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'ID '#1044#1086#1082#1091#1084#1077#1085#1090#1072
              FocusControl = edtDocID
            end
            object lblInternalID: TLabel
              Left = 17
              Top = 132
              Width = 3
              Height = 16
            end
            object Label6: TLabel
              Left = 66
              Top = 107
              Width = 101
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'ID '#1057#1087#1088#1072#1074#1082#1080
              FocusControl = edtDocID
            end
            object Label3: TLabel
              Left = 25
              Top = 166
              Width = 78
              Height = 16
              Alignment = taRightJustify
              AutoSize = False
              Caption = #1057#1088#1086#1095#1085#1086#1089#1090#1100
            end
            object Label5: TLabel
              Left = 101
              Top = 44
              Width = 66
              Height = 16
              Caption = ' '#1042#1072#1078#1085#1086#1089#1090#1100
            end
            object cbxChargeFree: TCheckBox
              Left = 78
              Top = 198
              Width = 125
              Height = 20
              Caption = ' '#1041#1077#1089#1087#1083#1072#1090#1085#1099#1081
              TabOrder = 6
              OnClick = ChkBxClick
            end
            object cbUserType: TComboBox
              Left = 108
              Top = 10
              Width = 208
              Height = 24
              Style = csDropDownList
              ItemHeight = 16
              TabOrder = 0
              OnChange = cbUserTypeChange
              Items.Strings = (
                #1055#1088#1086#1089#1090#1086' '#1076#1086#1082#1091#1084#1077#1085#1090
                #1044#1086#1082#1091#1084#1077#1085#1090
                #1058#1077#1093'. '#1076#1086#1082#1091#1084#1077#1085#1090' (NoDoc)'
                #1050#1072#1083#1077#1085#1076#1072#1088#1100
                #1041#1080#1079#1085#1077#1089'-'#1089#1087#1088#1072#1074#1082#1072
                #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1076#1083#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
                'WEB-'#1072#1076#1088#1077#1089#1072
                #1053#1077#1076#1077#1081#1089#1090#1074#1091#1102#1097#1072#1103' '#1088#1077#1076#1072#1082#1094#1080#1103
                #1050#1085#1080#1075#1072' '#1041#1080#1073#1083#1080#1086#1090#1082#1080' '#1087#1088#1072#1074#1086#1074#1086#1075#1086' '#1085#1072#1089#1083#1077#1076#1080#1103
                #1048#1079#1084#1077#1085#1103#1102#1097#1080#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
                #1050#1072#1088#1090#1086#1095#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
                #1044#1086#1089#1100#1077
                #1040#1040#1050' - '#1089#1086#1076#1077#1088#1078#1072#1085#1080#1077
                #1040#1040#1050' - '#1090#1077#1082#1089#1090)
            end
            object edtDocID: TvtSpinEdit
              Left = 173
              Top = 71
              Width = 143
              Height = 24
              MinValue = -1.000000000000000000
              UseMaxValue = False
              EmptyValue = -1.000000000000000000
              Value = -1.000000000000000000
              TabOrder = 3
              OnChange = edtDocIDChange
              OnExit = edtDocIDExit
            end
            object edtPriorityID: TvtSpinEdit
              Left = 173
              Top = 39
              Width = 143
              Height = 24
              MaxValue = 32767.000000000000000000
              TabOrder = 2
              OnChange = edtPriorityIDChange
              OnExit = edtDocIDExit
            end
            object cbxPriorityType: TCheckBox
              Left = 78
              Top = 42
              Width = 17
              Height = 19
              TabOrder = 1
              OnClick = cbxPriorityTypeClick
            end
            object edtSprDocID: TvtSpinEdit
              Left = 173
              Top = 102
              Width = 143
              Height = 24
              MinValue = -1.000000000000000000
              UseMaxValue = False
              EmptyValue = -1.000000000000000000
              Value = -1.000000000000000000
              TabOrder = 4
              OnChange = edtDocIDChange
              OnExit = edtSprDocIDExit
            end
            object cbxNotTM: TCheckBox
              Left = 78
              Top = 222
              Width = 315
              Height = 17
              Caption = #1053#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085' '#1082' "'#1084#1072#1096#1080#1085#1077' '#1074#1088#1077#1084#1077#1085#1080'"'
              TabOrder = 7
              OnClick = ChkBxClick
            end
            object cbUrgency: TComboBox
              Left = 108
              Top = 162
              Width = 208
              Height = 24
              Style = csDropDownList
              ItemHeight = 16
              TabOrder = 5
              OnChange = cbUrgencyChange
            end
            object cbxNoCompare: TCheckBox
              Left = 78
              Top = 245
              Width = 314
              Height = 17
              Caption = #1053#1077' '#1091#1095#1072#1089#1090#1074#1091#1077#1090' '#1074' '#1089#1088#1072#1074#1085#1077#1085#1080#1080' '#1088#1077#1076#1072#1082#1094#1080#1081
              TabOrder = 8
              OnClick = ChkBxClick
            end
            object cbxInternet: TCheckBox
              Left = 78
              Top = 269
              Width = 314
              Height = 17
              Caption = #1048#1085#1090#1077#1088#1085#1077#1090'-'#1076#1086#1082#1091#1084#1077#1085#1090
              TabOrder = 9
              OnClick = ChkBxClick
            end
            object cbxHang: TCheckBox
              Left = 79
              Top = 293
              Width = 411
              Height = 17
              Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1086#1090#1083#1086#1078#1077#1085#1086
              TabOrder = 10
              OnClick = cbxHangClick
            end
          end
        end
        object TOvcNotebookPage
          Caption = '&'#1069#1090#1072#1087#1099
          object tblStage: TOvcTable
            Left = 0
            Top = 26
            Width = 0
            Height = 347
            RowLimit = 10
            LockedCols = 0
            LeftCol = 0
            Align = alClient
            ColorUnused = clBtnFace
            Colors.ActiveFocused = clHighlight
            Colors.ActiveFocusedText = clHighlightText
            Colors.ActiveUnfocused = clBtnFace
            Colors.ActiveUnfocusedText = clHighlightText
            Colors.Locked = clBtnFace
            Colors.LockedText = clWindowText
            Colors.Editing = clBtnFace
            Colors.EditingText = clWindowText
            Colors.Selected = clHighlight
            Colors.SelectedText = clHighlightText
            Ctl3D = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
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
            GridPenSet.CellWhenFocused.Effect = geNone
            GridPenSet.CellWhenUnfocused.NormalColor = clBlack
            GridPenSet.CellWhenUnfocused.SecondColor = clBtnHighlight
            GridPenSet.CellWhenUnfocused.Style = psSolid
            GridPenSet.CellWhenUnfocused.Effect = geNone
            LockedRowsCell = chStage
            Options = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 1
            OnBeginEdit = tblStageBeginEdit
            OnDoneEdit = tblStageDoneEdit
            OnGetCellData = tblStageGetCellData
            OnGetCellAttributes = tblStageGetCellAttributes
            CellData = (
              'DocEditorWindow.chStage'
              'DocEditorWindow.tcStageBegin'
              'DocEditorWindow.tcStageEnd'
              'DocEditorWindow.tcStageName'
              'DocEditorWindow.tcStageCheckUser'
              'DocEditorWindow.tcStageCheckTime')
            RowData = (
              30
              2
              False
              29)
            ColData = (
              86
              False
              True
              'DocEditorWindow.tcStageBegin'
              86
              False
              True
              'DocEditorWindow.tcStageEnd'
              255
              False
              True
              'DocEditorWindow.tcStageName'
              118
              False
              True
              'DocEditorWindow.tcStageCheckTime'
              322
              False
              True
              'DocEditorWindow.tcStageCheckUser')
          end
          object pnlIncludedWarn: TPanel
            Left = 0
            Top = 0
            Width = 0
            Height = 26
            Align = alTop
            Alignment = taLeftJustify
            Caption = '      '
            Color = clBtnShadow
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clLime
            Font.Height = -15
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object cbxIncDone: TCheckBox
              Left = 6
              Top = 5
              Width = 220
              Height = 17
              Caption = #1044#1086#1082#1091#1084#1077#1085#1090' '#1087#1086#1076#1082#1083#1102#1095#1077#1085
              Enabled = False
              TabOrder = 0
              OnClick = cbxIncDoneClick
            end
          end
        end
        object TOvcNotebookPage
          Caption = '&'#1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1081
          object tblJurJournal: TvtIStrListLister
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            AutoRowHeight = False
            BorderStyle = bsSingle
            Columns = 255
            Header.Left = 0
            Header.Top = 0
            Header.Width = 0
            Header.Height = 18
            Header.Sections = <
              item
                Caption = #1044#1072#1090#1072
                Width = 92
                AutoResize = False
                MinWidth = 20
                MaxWidth = 2147483647
              end
              item
                Caption = #1042#1088#1077#1084#1103
                Width = 76
                AutoResize = False
                MinWidth = 20
                MaxWidth = 2147483647
              end
              item
                Caption = #1054#1087#1077#1088#1072#1094#1080#1103
                Width = 242
                AutoResize = False
                MinWidth = 20
                MaxWidth = 2147483647
              end
              item
                Caption = #1040#1074#1090#1086#1088
                Width = 75
                AutoResize = False
                MinWidth = 20
                MaxWidth = 2147483647
              end>
            Header.Font.Charset = RUSSIAN_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -13
            Header.Font.Name = 'Arial CYR'
            Header.Font.Style = []
            IntegralHeight = False
            MultiSelect = False
            ProtectColor.BackColor = clRed
            ProtectColor.TextColor = clWhite
            RowHeight = 20
            ScrollStyle = ssVertical
            SelectColor.BackColor = clHighlight
            SelectColor.TextColor = clHighlightText
            SelectNonFocusColor.BackColor = clBtnFace
            SelectNonFocusColor.TextColor = clBtnText
            ShowHeader = True
            UseTabStops = True
            PickedList = False
            MultiStrokeItem = False
            ReadOnly = False
            ViewOptions = []
            OnGetItemColor = tblJurJournalGetItemColor
            Align = alClient
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = True
            TabOrder = 0
            TabStop = True
          end
        end
        object TOvcNotebookPage
          Caption = #1057'&'#1080#1089#1090#1077#1084#1085#1099#1081
          object tblOrdJournal: TvtIStrListLister
            Left = 0
            Top = 0
            Width = 0
            Height = 0
            AutoRowHeight = False
            BorderStyle = bsSingle
            Columns = 255
            Header.Left = 0
            Header.Top = 0
            Header.Width = 0
            Header.Height = 18
            Header.Sections = <
              item
                Caption = #1044#1072#1090#1072
                Width = 92
                AutoResize = False
                MinWidth = 20
                MaxWidth = 2147483647
              end
              item
                Caption = #1042#1088#1077#1084#1103
                Width = 76
                AutoResize = False
                MinWidth = 20
                MaxWidth = 2147483647
              end
              item
                Caption = #1054#1087#1077#1088#1072#1094#1080#1103
                Width = 242
                AutoResize = False
                MinWidth = 20
                MaxWidth = 2147483647
              end
              item
                Caption = #1040#1074#1090#1086#1088
                Width = 75
                AutoResize = False
                MinWidth = 20
                MaxWidth = 2147483647
              end>
            Header.Font.Charset = RUSSIAN_CHARSET
            Header.Font.Color = clWindowText
            Header.Font.Height = -13
            Header.Font.Name = 'Arial CYR'
            Header.Font.Style = []
            IntegralHeight = False
            MultiSelect = False
            ProtectColor.BackColor = clRed
            ProtectColor.TextColor = clWhite
            RowHeight = 20
            ScrollStyle = ssVertical
            SelectColor.BackColor = clHighlight
            SelectColor.TextColor = clHighlightText
            SelectNonFocusColor.BackColor = clBtnFace
            SelectNonFocusColor.TextColor = clBtnText
            ShowHeader = True
            UseTabStops = True
            PickedList = False
            MultiStrokeItem = False
            ReadOnly = False
            ViewOptions = []
            OnGetItemColor = tblOrdJournalGetItemColor
            Align = alClient
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = []
            ParentColor = False
            ParentFont = True
            TabOrder = 0
            TabStop = True
          end
        end
      end
    end
  end
  object pnlIncludeWarning: TPanel
    Left = 0
    Top = 31
    Width = 925
    Height = 5
    Hint = #1044#1086#1082#1091#1084#1077#1085#1090' '#1087#1086#1076#1082#1083#1102#1095#1077#1085
    Align = alTop
    BevelOuter = bvNone
    Color = clRed
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Visible = False
  end
  object pnlHasFutureEditionWarning: TPanel
    Left = 0
    Top = 36
    Width = 925
    Height = 5
    Hint = #1044#1086#1082#1091#1084#1077#1085#1090' '#1080#1084#1077#1077#1090' '#1073#1091#1076#1091#1097#1091#1102' '#1088#1077#1076#1072#1082#1094#1080#1102
    Align = alTop
    BevelOuter = bvNone
    Color = clYellow
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Visible = False
  end
  object pnlUrgent: TPanel
    Left = 0
    Top = 41
    Width = 925
    Height = 5
    Hint = #1057#1088#1086#1095#1085#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
    Align = alTop
    BevelOuter = bvNone
    Color = 46847
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    Visible = False
  end
  object pnlHang: TPanel
    Left = 0
    Top = 22
    Width = 925
    Height = 9
    Hint = #1054#1073#1088#1072#1073#1086#1090#1082#1072' '#1086#1090#1083#1086#1078#1077#1085#1072
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 1
    Color = 16756766
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Visible = False
    object Panel8: TPanel
      Left = 1
      Top = 1
      Width = 923
      Height = 1
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
    end
  end
  object StyleSearcher: TevStyleSearcher
    Left = 502
    Top = 177
  end
  object TextEditMenu: TMainMenu
    AutoMerge = True
    Left = 305
    Top = 111
    object miText: TMenuItem
      Caption = #1058#1077#1082#1089#1090
      GroupIndex = 5
      object miSave: TMenuItem
        Action = acTextSave
      end
      object miSaveAs: TMenuItem
        Action = acTextSaveAs
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object miSelectAll: TMenuItem
        Action = acTextSelectAll
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object miUndo: TevMenuItem
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100
        ShortCut = 16474
        Operation = ev_ccUndo
      end
      object miRedo: TevMenuItem
        Caption = #1042#1077#1088#1085#1091#1090#1100
        ShortCut = 24666
        Operation = ev_ccRedo
      end
      object miSplitLine1: TMenuItem
        Caption = '-'
      end
      object miCut: TMenuItem
        Action = acTextCut
      end
      object miCopy: TMenuItem
        Action = acTextCopy
      end
      object miPaste: TMenuItem
        Action = acTextPaste
      end
      object miAddToClipboard: TevMenuItem
        Action = MainForm.acAdd2Clipbrd
        Operation = ev_ccAdd
      end
      object miPasteFromFile: TMenuItem
        Action = acTextPasteFromFile
      end
      object miPasteSpecial: TevMenuItem
        Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1072#1103' '#1074#1089#1090#1072#1074#1082#1072' ...'
        Operation = ev_ccSpecialPaste
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object miStyle: TMenuItem
        Caption = #1057#1090#1080#1083#1100
        object miUserColorSegment: TMenuItem
          Tag = 1
          Action = acStyleColorSegment
        end
        object miUserMonoWidth: TMenuItem
          Tag = 2
          Action = acStyleMonospace
        end
        object miUserStyle3: TMenuItem
          Tag = 3
          Action = acStyleNormal
        end
        object miUserStyle4: TMenuItem
          Tag = 4
          Action = acStyleNormalOEM
        end
        object miUserStyle5: TMenuItem
          Tag = 5
          Action = acStyleHeader1
        end
        object miUserStyle6: TMenuItem
          Tag = 6
          Action = acStyleArticleHeader
        end
        object miUserStyle7: TMenuItem
          Tag = 7
          Action = acStyleExpired
        end
        object miUserStyle8: TMenuItem
          Tag = 8
          Action = acStyleComment
        end
        object miUserStyle9: TMenuItem
          Tag = 9
          Action = acStyleLinkContinue
        end
        object miUserStyle0: TMenuItem
          Action = acStyleLeftAdjusted
        end
        object miUserStyle10: TMenuItem
          Tag = 10
          Action = acStyleVersionInfo
        end
        object miUserStyle11: TMenuItem
          Tag = 11
          Action = acStyleNoEffectYet
        end
        object miUserStyle12: TMenuItem
          Action = acStyleApendixHeader
        end
      end
      object miSplitLine3: TMenuItem
        Caption = '-'
      end
      object miJustLeft: TevMenuItem
        Action = MainForm.acJustifyLeft
        AutoCheck = True
        Operation = ev_ccJustifyLeft
      end
      object miJustCenter: TevMenuItem
        Action = MainForm.acJustifyCenter
        AutoCheck = True
        Operation = ev_ccJustifyRight
      end
      object miJustRight: TevMenuItem
        Action = MainForm.acJustifyRight
        AutoCheck = True
        Operation = ev_ccJustifyRight
      end
      object miJustWide: TevMenuItem
        Action = MainForm.acJustifyWidth
        AutoCheck = True
        Operation = ev_ccJustifyWidth
      end
      object miAlignWithSeparator: TMenuItem
        Action = MainForm.acAlignWithSeparator
        AutoCheck = True
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miSetTextInvisible: TMenuItem
        Action = acTextMarkAsNonPrintable
      end
      object miSetTextVisible: TMenuItem
        Action = acTextMarkAsPrintable
      end
      object N21: TMenuItem
        Caption = '-'
      end
    end
    object miInsertMenu: TMenuItem
      Caption = #1042#1089#1090#1072#1074#1082#1072
      GroupIndex = 5
      object miInsertSbSPara: TMenuItem
        Action = acInsSignature
      end
      object miSection: TMenuItem
        Action = acInsSection
      end
      object miPageBreak: TMenuItem
        Action = acInsPageBreak
      end
      object miInsertFormula: TMenuItem
        Action = acInsFormula
      end
      object N48: TMenuItem
        Caption = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1096#1072#1073#1083#1086#1085
        object N49: TMenuItem
          Action = acInsTemplateEdit
        end
        object N50: TMenuItem
          Action = acInsTemplate
        end
      end
    end
    object miTable: TMenuItem
      Caption = #1058#1072'&'#1073#1083#1080#1094#1099
      GroupIndex = 5
      object miTblBorder: TMenuItem
        Action = acTblBoundaries
      end
      object miTblFromText: TMenuItem
        Action = acTblFromText
      end
      object N30: TMenuItem
        Caption = #1042#1089#1090#1072#1074#1080#1090#1100
        object miTblCreate: TMenuItem
          Action = MainForm.acInsertTable
        end
        object miTblInsStr: TMenuItem
          Action = MainForm.acInsertRow
        end
        object miTblInsCol: TMenuItem
          Action = MainForm.acInsertColumn
        end
      end
      object N34: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        object miDeleteTable: TMenuItem
          Action = MainForm.acDeleteTable
        end
        object miTblDelStr: TMenuItem
          Action = MainForm.acDeleteRow
        end
        object miTblDelCol: TMenuItem
          Action = MainForm.acDeleteColumn
        end
        object miDeleteCell: TMenuItem
          Action = MainForm.acDeleteCell
        end
      end
      object N35: TMenuItem
        Caption = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100
        object miTblMergeTables: TMenuItem
          Action = MainForm.acMergeTables
        end
        object miCellsMerge: TMenuItem
          Action = MainForm.acMergeCells
        end
        object miMergeCellsVert: TMenuItem
          Action = MainForm.acMergeCellsVert
        end
        object miMergeCellsHorz: TMenuItem
          Action = MainForm.acMergeCellsHorz
        end
      end
      object N36: TMenuItem
        Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1100
        object miTblSplitTable: TMenuItem
          Action = MainForm.acSplitTable
        end
        object miCellSplit: TMenuItem
          Action = MainForm.acSplitCells
        end
      end
      object pmTranslate2Text: TMenuItem
        Action = acTranslate2Text
      end
      object N14: TMenuItem
        Caption = '-'
        Visible = False
      end
      object miTblAjustCellBorder: TMenuItem
        Action = acTblAdjustCellsBoundaries
      end
      object miTblAjustColumnWidth: TMenuItem
        Action = acTblAdjustNumberCell
      end
      object miSetCellWidth: TMenuItem
        Action = acTblSetCellWidth
      end
      object N42: TMenuItem
        Caption = '-'
      end
      object N41: TMenuItem
        Action = acRememberWidths
      end
      object N43: TMenuItem
        Action = acApplyWidths
      end
      object N37: TMenuItem
        Caption = '-'
      end
      object N38: TMenuItem
        Action = acSetFrame
      end
      object N39: TMenuItem
        Action = acDelFrame
      end
      object N32: TMenuItem
        Caption = '-'
      end
      object miOldNSRC: TMenuItem
        Action = acOldNSRC
      end
    end
    object miHyperText: TMenuItem
      Caption = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      GroupIndex = 5
      object mi_SetSub: TMenuItem
        Action = acSetSub
      end
      object mi_RemoveSub: TMenuItem
        Action = acDelSub
      end
      object miDelAllBlocks: TMenuItem
        Action = acDelAllBlocks
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miSetReference: TMenuItem
        Action = acLinkSet
      end
      object miSetReferenceDirect: TMenuItem
        Action = acLinkSetManually
      end
      object mi_RemoveReference: TMenuItem
        Action = acLinkDelete
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object miGoByRef: TMenuItem
        Action = acLinkFollow
      end
      object N23: TMenuItem
        Caption = '-'
      end
      object N24: TMenuItem
        Action = acGetCorespondentsForBlock
        Caption = #1050#1086#1088#1088#1077#1089#1087#1086#1085#1076#1077#1085#1090#1099' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1092#1088#1072#1075#1084#1077#1085#1090#1072
      end
      object N25: TMenuItem
        Action = acReplaceHRefDocForBlockCorrespondents
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object miSubNameCorrect: TMenuItem
        Action = acSubNameCorrect
      end
      object miCreateStructure: TMenuItem
        Action = acInsCreateStructure
      end
    end
    object miSearch: TMenuItem
      Caption = #1055'&'#1086#1080#1089#1082
      GroupIndex = 5
      object miFind: TMenuItem
        Action = acFindGeneralSearch
      end
      object miReplace: TMenuItem
        Action = acFindGeneralReplace
      end
      object miSrchAgain: TMenuItem
        Action = acFindGeneralRepeatSearch
      end
      object miParseSelectTextAndSearch: TMenuItem
        Action = acFindInFragment
      end
      object miSplit21: TMenuItem
        Caption = '-'
      end
      object miGotoNextOccur: TMenuItem
        Action = MainForm.acGotoNextOccur
      end
      object N40: TMenuItem
        Action = acFindTable
      end
    end
    object miService: TMenuItem
      Caption = #1057#1077#1088#1074#1080#1089
      GroupIndex = 5
      object miTranformText: TMenuItem
        Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100
        object miUpReg: TMenuItem
          Action = acToolsCnvUpperCase
        end
        object miLowReg: TMenuItem
          Action = acToolsCnvLowerCase
        end
        object N45: TMenuItem
          Action = acToolsCnvLowerCaseWithFirst
        end
        object miInvReg: TMenuItem
          Action = acToolsCnvInvertCase
        end
        object miRusReg: TMenuItem
          Action = acToolsCnvRusCharset
        end
        object miEngReg: TMenuItem
          Action = acToolsCnvEngCharset
        end
        object miOEM2ANSI: TMenuItem
          Action = acToolsCnvOEM2ANSI
        end
        object ANSI2OEM: TMenuItem
          Action = acToolsCnvANSI2OEM
        end
        object miDate2Text: TMenuItem
          Action = acToolsCnvDate2Text
        end
        object miParaMerge: TMenuItem
          Action = acToolsCnvMergePara
        end
      end
      object miAnaliseParam: TMenuItem
        Action = acToolsAnalyseHeader
      end
      object N44: TMenuItem
        Action = acToolsSetSections
      end
      object N46: TMenuItem
        Action = acToolsAutolink
      end
      object N18: TMenuItem
        Caption = '-'
      end
      object miFindTNVED: TMenuItem
        Action = acToolsFindTNVED
      end
      object miSetVChanged: TMenuItem
        Action = acToolsSubmitJurChanges
      end
      object miSetVLControl: TMenuItem
        Action = acToolsUncontrol
      end
      object miSetAnonced: TMenuItem
        Action = acToolsAnnounce
      end
      object miSetMOJNotReg: TMenuItem
        Action = acToolsRegistrationDeclined
      end
      object miSetAnnoDate: TMenuItem
        Action = acToolsLinkAnno
      end
      object miUrOpSetAbolished: TMenuItem
        Action = acToolsDocExpired
      end
      object miUrOpMakeOldEdition: TMenuItem
        Action = acToolsMakeOldEdition
      end
      object miUrOpMakeFullEdition: TMenuItem
        Action = acToolsMakeOtherEdition
      end
      object miOpenAllRevisions: TMenuItem
        Action = acToolsOpenAllEditions
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object miDelSpravka: TMenuItem
        Action = acToolsDeleteReference
      end
      object miDelAnno: TMenuItem
        Action = acToolsDeleteAnno
      end
      object acPrevVersion1: TMenuItem
        Action = acPrevVersion
        Caption = #1042#1077#1088#1085#1091#1090#1100#1089#1103' '#1082' '#1089#1086#1093#1088#1072#1085#1077#1085#1085#1086#1081' '#1074#1077#1088#1089#1080#1080'...'
      end
    end
  end
  object MainPopupMenu: TPopupMenu
    Left = 409
    Top = 113
    object miHSplitWindow: TMenuItem
      Action = acPMMainSplitWindow
      ShortCut = 16495
    end
    object miSwapPanel: TMenuItem
      Action = acPMMainSwapPanels
    end
  end
  object TextPopupMenu: TLinkPopUpMenu
    OnPopup = acSetSubUpdate
    PrimaryPopUpMenu = ClipbrdPopUpMenu
    Active = False
    Left = 409
    Top = 141
    object miSetSub: TMenuItem
      Action = acSetSub
    end
    object piSetReference: TMenuItem
      Action = acLinkSet
    end
    object miSetBlock: TMenuItem
      Action = acSetBlock
    end
    object miSetClass: TMenuItem
      Action = acPMTextSetClass
      ShortCut = 49219
    end
    object miSetPrefix: TMenuItem
      Action = acPMTextSetPrefix
      ShortCut = 49240
    end
    object miSetKeyWord: TMenuItem
      Action = acPMTextSetKey
      ShortCut = 49227
    end
    object miSetKeyType: TMenuItem
      Action = acPMTextSetType
      ShortCut = 49236
    end
    object miInsertDictText: TMenuItem
      Action = acPMTextInsertText
      ShortCut = 49225
    end
    object N22: TMenuItem
      Caption = '-'
    end
    object piParseSelectTextAndSearch: TMenuItem
      Action = acFindInFragment
    end
    object piFindDictEntryBySelect: TMenuItem
      Action = acPMTextFindInterpretation
      ShortCut = 49220
    end
    object miJumpToSub: TMenuItem
      Action = acPMTextJumpToSub
      ShortCut = 49226
    end
    object miJumpByPara: TMenuItem
      Action = acPMTextJumpToPara
      ShortCut = 49232
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object miDocInfo: TMenuItem
      Action = acPMTextDocInfo
      ShortCut = 32841
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object mipOldNSRC: TMenuItem
      Action = acOldNSRC
    end
    object N33: TMenuItem
      Caption = '-'
    end
  end
  object ClipbrdPopUpMenu: TLinkPopUpMenu
    PrimaryPopUpMenu = MainPopupMenu
    Active = False
    Left = 409
    Top = 169
    object piCut: TMenuItem
      Action = MainForm.acCut
    end
    object piCopy: TMenuItem
      Action = MainForm.acCopy
    end
    object piPaste: TMenuItem
      Action = MainForm.acPaste
    end
    object piAddToClipboard: TevMenuItem
      Action = MainForm.acAdd2Clipbrd
      Operation = ev_ccAdd
    end
    object N4: TMenuItem
      Caption = '-'
    end
  end
  object PriznPopUpMenu: TLinkPopUpMenu
    OnPopup = PriznPopUpMenuPopup
    PrimaryPopUpMenu = MainPopupMenu
    Active = False
    Left = 409
    Top = 197
    object miEditClassTree: TMenuItem
      Action = acPMAttrEdit
    end
    object miInsertClassToObjList: TMenuItem
      Action = acPMAttrSave
    end
    object miDelDocClass: TMenuItem
      Action = acPMAttrDelete
    end
    object piShowOwnerSubOnClass: TMenuItem
      Action = acPMAttrShowOwners
    end
    object N9: TMenuItem
      Caption = '-'
    end
  end
  object SubPanelPopUpMenu: TLinkPopUpMenu
    PrimaryPopUpMenu = MainPopupMenu
    Active = False
    Left = 381
    Top = 141
    object piShowSubNumber: TMenuItem
      Action = acPMSubPanelLabelNum
    end
    object piShowNameType: TMenuItem
      Tag = 1
      Action = acPMSubPanelNameType
    end
    object piShowClasses: TMenuItem
      Tag = 3
      Action = acPMSubPanelClasses
    end
    object piShowKWords: TMenuItem
      Tag = 2
      Action = acPMSubPanelKeys
    end
    object piShowDocTypes: TMenuItem
      Tag = 5
      Action = acPMSubPanelTypes
    end
    object N28: TMenuItem
      Tag = 6
      Action = acPMSubPanelTOC
    end
    object piShowRTF: TMenuItem
      Tag = 7
      Action = acPMSubPanelExtObjects
    end
    object N12: TMenuItem
      Caption = '-'
    end
  end
  object pmSubList: TLinkPopUpMenu
    PrimaryPopUpMenu = MainPopupMenu
    Active = False
    Left = 381
    Top = 169
    object miSubNameEdit: TMenuItem
      Action = acPMSubEditName
    end
    object miDelSubItem: TMenuItem
      Action = acPMSubDelete
      ShortCut = 46
    end
    object N10: TMenuItem
      Caption = '-'
    end
  end
  object chStage: TOvcTCColHead
    Headings.Strings = (
      #1053#1072#1095#1072#1083#1089#1103
      #1047#1072#1082#1086#1085#1095#1080#1083#1089#1103
      #1053#1072#1079#1074#1072#1085#1080#1077
      #1044#1072#1090#1072
      #1054#1087#1077#1088#1072#1090#1086#1088)
    ShowActiveCol = False
    ShowLetters = False
    Adjust = otaCenter
    Table = tblStage
    TextStyle = tsFlat
    UseWordWrap = False
    Left = 468
    Top = 235
  end
  object tcStageBegin: TOvcTCCheckBox
    AcceptActivationClick = True
    Adjust = otaCenter
    AllowGrayed = False
    CellGlyphs.IsDefault = True
    CellGlyphs.GlyphCount = 3
    CellGlyphs.ActiveGlyphCount = 2
    Color = clInactiveBorder
    ShowHint = False
    Table = tblStage
    TableColor = False
    Left = 468
    Top = 263
  end
  object tcStageEnd: TOvcTCCheckBox
    AcceptActivationClick = True
    Adjust = otaCenter
    AllowGrayed = False
    CellGlyphs.IsDefault = True
    CellGlyphs.GlyphCount = 3
    CellGlyphs.ActiveGlyphCount = 2
    Color = clInactiveBorder
    ShowHint = False
    Table = tblStage
    TableColor = False
    Left = 496
    Top = 263
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
    Left = 524
    Top = 263
  end
  object pmSubAnchor: TLinkPopUpMenu
    Active = False
    Left = 353
    Top = 141
    object piSubNameEdit: TMenuItem
      Action = acPMSubAncorEdit
    end
    object piRemoveSub: TMenuItem
      Action = acPMSubAncorDelete
    end
    object piInsertSubToObjList: TMenuItem
      Action = acPMSubAncorSave
    end
    object miSubSinchronize: TMenuItem
      Action = acPMSubAncorSync
    end
    object N47: TMenuItem
      Action = acPMSubCopyAddr
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object miSetClassOnSub: TMenuItem
      Action = acPMSubAncorSetClass
    end
    object miSetPrefixOnSub: TMenuItem
      Action = acPMSubAncorSetPrefix
    end
    object miSetKWOnSub: TMenuItem
      Action = acPMSubAncorSetKey
    end
    object miSetTypeOnSub: TMenuItem
      Action = acPMSubAncorSetType
    end
    object piSetContents: TMenuItem
      Action = acPMSubAncorSetTOC
    end
    object piSetExternalObjOnSub: TMenuItem
      Action = acPMSubAncorLinkExtObject
    end
    object N20: TMenuItem
      Action = acPMSubAncorDelExtObject
    end
    object N15: TMenuItem
      Caption = '-'
    end
  end
  object pmBlockTree: TPopupMenu
    Left = 325
    Top = 141
    object pmDelBlock: TMenuItem
      Action = acPMBTreeDelete
    end
  end
  object pmPicture: TLinkPopUpMenu
    PrimaryPopUpMenu = ClipbrdPopUpMenu
    Active = False
    Left = 377
    Top = 226
    object miStretchPicture: TMenuItem
      Action = acPMPicStretch
      GroupIndex = 3
    end
    object MenuItem12: TMenuItem
      Caption = '-'
      GroupIndex = 3
    end
  end
  object pmJournal: TLinkPopUpMenu
    PrimaryPopUpMenu = MainPopupMenu
    Active = False
    Left = 349
    Top = 225
    object miDelJournalRec: TMenuItem
      Action = acPMJournalDelete
      ShortCut = 46
    end
    object MenuItem4: TMenuItem
      Caption = '-'
    end
  end
  object pmSection: TPopupMenu
    Left = 338
    Top = 184
    object miPortrait: TMenuItem
      Action = acPMSectionPortrait
      Checked = True
      GroupIndex = 1
      RadioItem = True
    end
    object miLandscape: TMenuItem
      Action = acPMSectionLandscape
      GroupIndex = 1
      RadioItem = True
    end
    object N6: TMenuItem
      Caption = '-'
      GroupIndex = 1
    end
    object miA4: TMenuItem
      Action = acPMSectionA4
      Checked = True
      GroupIndex = 2
      RadioItem = True
    end
    object miA3: TMenuItem
      Action = acPMSectionA3
      GroupIndex = 2
      RadioItem = True
    end
    object miA2: TMenuItem
      Action = acPMSectionA2
      GroupIndex = 2
      RadioItem = True
    end
    object miA1: TMenuItem
      Action = acPMSectionA1
      GroupIndex = 2
      RadioItem = True
    end
  end
  object tcStageCheckTime: TOvcTCDate
    ShowHint = False
    Table = tblStage
    Left = 552
    Top = 263
  end
  object tcStageCheckUser: TOvcTCComboBox
    AcceptActivationClick = True
    AutoAdvanceChar = False
    AutoAdvanceLeftRight = False
    ShowHint = False
    MaxLength = 0
    SaveStringValue = False
    Style = csDropDownList
    Table = tblStage
    TextStyle = tsFlat
    UseRunTimeItems = False
    Left = 580
    Top = 263
  end
  object ActionList1: TActionList
    Left = 240
    Top = 116
    object acPageName: TAction
      Category = #1053#1072#1074#1080#1075#1072#1094#1080#1103
      ShortCut = 8304
      OnExecute = acGoToPageExecute
    end
    object acPageAttr: TAction
      Tag = 1
      Category = #1053#1072#1074#1080#1075#1072#1094#1080#1103
      ShortCut = 8305
      OnExecute = acGoToPageExecute
    end
    object acPageText: TAction
      Tag = 2
      Category = #1053#1072#1074#1080#1075#1072#1094#1080#1103
      ShortCut = 8306
      OnExecute = acGoToPageExecute
    end
    object acPageSprv: TAction
      Tag = 4
      Category = #1053#1072#1074#1080#1075#1072#1094#1080#1103
      ShortCut = 8307
      OnExecute = acGoToPageExecute
    end
    object acPageClass: TAction
      Tag = 6
      Category = #1053#1072#1074#1080#1075#1072#1094#1080#1103
      ShortCut = 8308
      OnExecute = acGoToPageExecute
    end
    object acPageAnno: TAction
      Tag = 5
      Category = #1053#1072#1074#1080#1075#1072#1094#1080#1103
      ShortCut = 8309
      OnExecute = acGoToPageExecute
    end
    object acPageResp: TAction
      Tag = 9
      Category = #1053#1072#1074#1080#1075#1072#1094#1080#1103
      ShortCut = 8310
      OnExecute = acGoToPageExecute
    end
    object acPageCoresp: TAction
      Tag = 10
      Category = #1053#1072#1074#1080#1075#1072#1094#1080#1103
      ShortCut = 8311
      OnExecute = acGoToPageExecute
    end
    object acPageVersions: TAction
      Tag = 11
      Category = #1053#1072#1074#1080#1075#1072#1094#1080#1103
      ShortCut = 8312
      OnExecute = acGoToPageExecute
    end
    object acPageJourn: TAction
      Tag = 12
      Category = #1053#1072#1074#1080#1075#1072#1094#1080#1103
      ShortCut = 8313
      OnExecute = acGoToPageExecute
    end
    object acPageStage: TAction
      Tag = 13
      Category = #1053#1072#1074#1080#1075#1072#1094#1080#1103
      ShortCut = 8314
      OnExecute = acGoToPageExecute
    end
    object acPageJurJournal: TAction
      Tag = 14
      Category = #1053#1072#1074#1080#1075#1072#1094#1080#1103
      ShortCut = 8315
      OnExecute = acGoToPageExecute
    end
    object acSetReferenceBegin: TAction
      Category = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      Caption = 'acSetReferenceBegin'
      ShortCut = 122
    end
    object acSetReferenceEnd: TAction
      Category = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      Caption = 'acSetReferenceEnd'
      ShortCut = 123
      OnExecute = acSetReferenceEndExecute
    end
    object acSetSub: TAction
      Category = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1084#1077#1090#1082#1091
      ShortCut = 121
      SecondaryShortCuts.Strings = (
        'Ctrl+Alt+S')
      OnExecute = acSetSubClick
      OnUpdate = acSetSubUpdate
    end
    object acDelSub: TAction
      Category = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1084#1077#1090#1082#1091
      ShortCut = 32889
      OnExecute = acDelSubExecute
    end
    object acSetIncludedStage: TAction
      Category = #1052#1072#1082#1088#1086#1089#1099
      ShortCut = 16571
      OnExecute = acSetIncludedStageExecute
    end
    object acTextSearch: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = 'acTextSearch'
      ShortCut = 16468
      OnExecute = acTextSearchExecute
    end
    object acTextReplace: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = 'acTextReplace'
      Enabled = False
      ShortCut = 24660
      OnExecute = acTextReplaceExecute
    end
    object acRefSearch: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = 'acRefSearch'
      ShortCut = 16467
      OnExecute = acRefSearchExecute
    end
    object acRefReplace: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = 'acRefReplace'
      Enabled = False
      ShortCut = 24659
      OnExecute = acRefReplaceExecute
    end
    object acPrevVersion: TAction
      Category = #1059#1090#1080#1083#1080#1090#1099
      Caption = #1042#1077#1088#1085#1091#1090#1100#1089#1103' '#1082' '#1087#1088#1077#1076#1099#1076#1091#1097#1077#1081' '#1074#1077#1088#1089#1080#1080
      OnExecute = acPrevVersionExecute
    end
    object acSetBlock: TAction
      Category = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1073#1083#1086#1082
      ShortCut = 49218
      OnExecute = acSetBlockExecute
    end
    object acDelAllBlocks: TAction
      Category = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1089#1077' '#1073#1083#1086#1082#1080
      OnExecute = acDelAllBlocksExecute
    end
    object acJurCommentStyleSearch: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = 'acJurCommentStyleSearch'
      ShortCut = 24643
      OnExecute = acJurCommentStyleSearchExecute
    end
    object acVersionInfoStyleSearch: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = 'acVersionInfoStyleSearch'
      ShortCut = 24649
      OnExecute = acVersionInfoStyleSearchExecute
    end
    object acSetFullEditionStage: TAction
      Category = #1052#1072#1082#1088#1086#1089#1099
      Caption = 'acSetFullEditionStage'
      ShortCut = 16573
      OnExecute = acSetFullEditionStageExecute
    end
    object acSetSharpReference: TAction
      Category = #1052#1072#1082#1088#1086#1089#1099
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' #-'#1089#1089#1099#1083#1082#1091
      ShortCut = 49203
      OnExecute = acSetSharpReferenceExecute
    end
    object acGetCorespondentsForBlock: TAction
      Category = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      Caption = #1050#1086#1088#1088#1077#1089#1087#1086#1085#1076#1077#1085#1090#1099' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1073#1083#1086#1082#1072
      Hint = #1057#1087#1080#1089#1086#1082' '#1082#1086#1088#1088#1077#1089#1087#1086#1085#1076#1077#1085#1090#1086#1074' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1092#1088#1072#1075#1084#1077#1085#1090#1072
      ShortCut = 24695
      OnExecute = acGetCorespondentsForBlockExecute
    end
    object acReplaceHRefDocForBlockCorrespondents: TAction
      Category = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      Caption = #1047#1072#1084#1077#1085#1072' '#1089#1089#1099#1083#1086#1082' '#1074' '#1082#1086#1088#1088#1077#1089#1087#1086#1085#1076#1077#1085#1090#1072#1093
      Hint = 
        #1047#1072#1084#1077#1085#1072' '#1085#1086#1084#1077#1088#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1074' '#1089#1089#1099#1083#1082#1072#1093', '#1089#1089#1099#1083#1072#1102#1097#1080#1093#1089#1103' '#1085#1072' '#1084#1077#1090#1082#1080' '#1074#1099#1076#1077#1083#1077#1085#1085 +
        #1086#1075#1086' '#1073#1083#1086#1082#1072
      ShortCut = 49234
      OnExecute = acReplaceHRefDocForBlockCorrespondentsExecute
    end
    object acSubNameCorrect: TAction
      Category = #1052#1072#1082#1088#1086#1089#1099
      Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100' '#1080#1084#1077#1085#1072' '#1084#1077#1090#1086#1082
      OnExecute = acSubNameCorrectExecute
    end
    object acAutoComplete: TAction
      Category = #1059#1090#1080#1083#1080#1090#1099
      Caption = 'acAutoComplete'
      ShortCut = 49191
      OnExecute = acAutoCompleteExecute
    end
    object acTextSave: TAction
      Category = #1058#1077#1082#1089#1090
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ShortCut = 113
      OnExecute = acTextSaveExecute
    end
    object acTextSaveAs: TAction
      Category = #1058#1077#1082#1089#1090
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082' ...'
      OnExecute = acTextSaveAsExecute
    end
    object acTextSelectAll: TAction
      Category = #1058#1077#1082#1089#1090
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      ShortCut = 16449
      OnExecute = acTextSelectAllExecute
    end
    object acTextCut: TAction
      Category = #1058#1077#1082#1089#1090
      Caption = #1042#1099#1088#1077#1079#1072#1090#1100
      ShortCut = 16472
      OnExecute = acTextCutExecute
    end
    object acTextCopy: TAction
      Category = #1058#1077#1082#1089#1090
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      ShortCut = 16451
      OnExecute = acTextCopyExecute
    end
    object acTextPaste: TAction
      Category = #1058#1077#1082#1089#1090
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      ShortCut = 16470
      OnExecute = acTextPasteExecute
    end
    object acTextPasteFromFile: TAction
      Category = #1058#1077#1082#1089#1090
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072' ...'
      OnExecute = acTextPasteFromFileExecute
    end
    object acStyleColorSegment: TAction
      Tag = 1
      Category = #1058#1077#1082#1089#1090
      Caption = #1062#1074#1077#1090#1086#1074#1086#1077' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
      ShortCut = 32817
      OnExecute = miUserSetStyle
    end
    object acStyleMonospace: TAction
      Tag = 2
      Category = #1058#1077#1082#1089#1090
      Caption = #1052#1086#1085#1086#1096#1080#1088#1080#1085#1085#1099#1081
      ShortCut = 32818
      OnExecute = miUserSetStyle
    end
    object acStyleNormal: TAction
      Tag = 3
      Category = #1058#1077#1082#1089#1090
      Caption = #1053#1086#1088#1084#1072#1083#1100#1085#1099#1081
      ShortCut = 32819
      OnExecute = miUserSetStyle
    end
    object acStyleNormalOEM: TAction
      Tag = 4
      Category = #1058#1077#1082#1089#1090
      Caption = #1053#1086#1088#1084#1072#1083#1100#1085#1099#1081' (OEM)'
      ShortCut = 32820
      OnExecute = miUserSetStyle
    end
    object acStyleHeader1: TAction
      Tag = 5
      Category = #1058#1077#1082#1089#1090
      Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082' 1'
      ShortCut = 32821
      OnExecute = miUserSetStyle
    end
    object acStyleArticleHeader: TAction
      Tag = 6
      Category = #1058#1077#1082#1089#1090
      Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082' '#1089#1090#1072#1090#1100#1080
      ShortCut = 32822
      OnExecute = miUserSetStyle
    end
    object acStyleExpired: TAction
      Tag = 7
      Category = #1058#1077#1082#1089#1090
      Caption = #1059#1090#1088#1072#1090#1080#1083' '#1089#1080#1083#1091
      ShortCut = 32823
      OnExecute = miUserSetStyle
    end
    object acStyleComment: TAction
      Tag = 8
      Category = #1058#1077#1082#1089#1090
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
      ShortCut = 32824
      OnExecute = miUserSetStyle
    end
    object acStyleLinkContinue: TAction
      Tag = 9
      Category = #1058#1077#1082#1089#1090
      Caption = #1055#1088#1086#1076#1086#1083#1078#1077#1085#1080#1077' '#1089#1089#1099#1083#1082#1080
      ShortCut = 32825
      OnExecute = miUserSetStyle
    end
    object acStyleLeftAdjusted: TAction
      Category = #1058#1077#1082#1089#1090
      Caption = #1055#1088#1080#1078#1072#1090#1099#1081' '#1074#1083#1077#1074#1086
      ShortCut = 32816
      OnExecute = miUserSetStyle
    end
    object acStyleVersionInfo: TAction
      Tag = 10
      Category = #1058#1077#1082#1089#1090
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1074#1077#1088#1089#1080#1080
      ShortCut = 32854
      OnExecute = miUserSetStyle
    end
    object acStyleNoEffectYet: TAction
      Tag = 11
      Category = #1058#1077#1082#1089#1090
      Caption = #1053#1077' '#1074#1089#1090#1091#1087#1080#1083' '#1074' '#1089#1080#1083#1091
      ShortCut = 32838
      OnExecute = miUserSetStyle
    end
    object acStyleTehComment: TAction
      Tag = 12
      Category = #1058#1077#1082#1089#1090
      Caption = #1058#1077#1093'. '#1082#1086#1084#1077#1085#1090#1072#1088#1080#1081
      ShortCut = 32849
      OnExecute = miUserSetStyle
    end
    object acTextMarkAsNonPrintable: TAction
      Category = #1058#1077#1082#1089#1090
      Caption = #1055#1086#1084#1077#1090#1080#1090#1100' '#1082#1072#1082' '#1085#1077#1087#1077#1095#1072#1090#1072#1077#1084#1099#1081
      OnExecute = acTextMarkAsNonPrintableExecute
    end
    object acTextMarkAsPrintable: TAction
      Category = #1058#1077#1082#1089#1090
      Caption = #1055#1086#1084#1077#1090#1080#1090#1100' '#1082#1072#1082' '#1087#1077#1095#1072#1090#1072#1077#1084#1099#1081
      OnExecute = acTextMarkAsPrintableExecute
    end
    object acInsSignature: TAction
      Category = #1042#1089#1090#1072#1074#1082#1072
      Caption = '"'#1055#1086#1076#1087#1080#1089#1100'"'
      OnExecute = acInsSignatureExecute
    end
    object acInsSection: TAction
      Category = #1042#1089#1090#1072#1074#1082#1072
      Caption = #1056#1072#1079#1076#1077#1083
      OnExecute = acInsSectionExecute
    end
    object acInsPageBreak: TAction
      Category = #1042#1089#1090#1072#1074#1082#1072
      Caption = #1056#1072#1079#1088#1099#1074' '#1089#1090#1088#1072#1085#1080#1094#1099
      ShortCut = 8205
      OnExecute = acInsPageBreakExecute
    end
    object acInsCreateStructure: TAction
      Category = #1042#1089#1090#1072#1074#1082#1072
      Caption = #1056#1072#1079#1073#1080#1074#1082#1072' '#1085#1072' '#1073#1083#1086#1082#1080
      OnExecute = acInsCreateStructureExecute
    end
    object acTblBoundaries: TAction
      Category = #1058#1072#1073#1083#1080#1094#1099
      Caption = #1043#1088#1072#1085#1080#1094#1099'...'
      OnExecute = acTblBoundariesExecute
    end
    object acTblFromText: TAction
      Category = #1058#1072#1073#1083#1080#1094#1099
      Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1090#1077#1082#1089#1090' '#1074' '#1090#1072#1073#1083#1080#1094#1091'...'
      OnExecute = acTblFromTextExecute
    end
    object acTblAdjustCellsBoundaries: TAction
      Category = #1058#1072#1073#1083#1080#1094#1099
      Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077' '#1075#1088#1072#1085#1080#1094' '#1103#1095#1077#1077#1082
      ShortCut = 16471
      OnExecute = acTblAdjustCellsBoundariesExecute
    end
    object acTblAdjustNumberCell: TAction
      Category = #1058#1072#1073#1083#1080#1094#1099
      Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077' '#1096#1080#1088#1080#1085#1099' '#1082#1086#1083#1086#1085#1082#1080' '#1089' '#1095#1080#1089#1083#1072#1084#1080
      OnExecute = acTblAdjustNumberCellExecute
    end
    object acTblSetCellWidth: TAction
      Category = #1058#1072#1073#1083#1080#1094#1099
      Caption = #1047#1072#1076#1072#1090#1100' '#1096#1080#1088#1080#1085#1091' '#1103#1095#1077#1077#1082
      OnExecute = acTblSetCellWidthExecute
    end
    object acLinkSet: TAction
      Category = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1089#1099#1083#1082#1091
      ShortCut = 122
      OnExecute = acLinkSetExecute
    end
    object acLinkSetManually: TAction
      Category = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1089#1099#1083#1082#1091' "'#1074#1088#1091#1095#1085#1091#1102'"'
      ShortCut = 32886
      OnExecute = acLinkSetManuallyExecute
    end
    object acLinkDelete: TAction
      Category = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1089#1099#1083#1082#1091
      ShortCut = 32814
      OnExecute = acLinkDeleteExecute
    end
    object acLinkDeleteContext: TAction
      Category = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1089#1099#1083#1082#1091
      OnExecute = acLinkDeleteContextExecute
    end
    object acLinkFollow: TAction
      Category = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1087#1086' '#1089#1089#1099#1083#1082#1077
      ShortCut = 32781
      OnExecute = acLinkFollowExecute
    end
    object acFindGeneralSearch: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = #1053#1072#1081#1090#1080
      ShortCut = 16454
      OnExecute = acFindGeneralSearchExecute
    end
    object acFindGeneralReplace: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = #1047#1072#1084#1077#1085#1080#1090#1100
      ShortCut = 16466
      OnExecute = acFindGeneralReplaceExecute
    end
    object acFindGeneralRepeatSearch: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = #1055#1086#1074#1090#1086#1088#1080#1090#1100' '#1087#1086#1080#1089#1082
      ShortCut = 16460
      OnExecute = acFindGeneralRepeatSearchExecute
    end
    object acFindInFragment: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1092#1088#1072#1075#1084#1077#1085#1090#1091
      ShortCut = 49222
      OnExecute = acFindInFragmentExecute
    end
    object acToolsCnvUpperCase: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1042#1077#1088#1093#1085#1080#1081' '#1088#1077#1075#1080#1089#1090#1088
      ShortCut = 24661
      OnExecute = acToolsCnvUpperCaseExecute
    end
    object acToolsCnvLowerCase: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1053#1080#1078#1085#1080#1081' '#1088#1077#1075#1080#1089#1090#1088
      ShortCut = 24652
      OnExecute = acToolsCnvLowerCaseExecute
    end
    object acToolsCnvLowerCaseWithFirst: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1053#1080#1078#1085#1080#1081' '#1088#1077#1075#1080#1089#1090#1088' ('#1087#1077#1088#1074#1072#1103' '#1079#1072#1075#1083#1072#1074#1085#1072#1103')'
      ShortCut = 24654
      OnExecute = acToolsCnvLowerCaseWithFirstExecute
    end
    object acToolsCnvInvertCase: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1048#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1088#1077#1075#1080#1089#1090#1088
      OnExecute = acToolsCnvInvertCaseExecute
    end
    object acToolsCnvRusCharset: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1056#1091#1089#1089#1082#1072#1103' '#1088#1072#1089#1082#1083#1072#1076#1082#1072
      OnExecute = acToolsCnvRusCharsetExecute
    end
    object acToolsCnvEngCharset: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1040#1085#1075#1083#1080#1081#1089#1082#1072#1103' '#1088#1072#1089#1082#1083#1072#1076#1082#1072
      OnExecute = acToolsCnvEngCharsetExecute
    end
    object acToolsCnvOEM2ANSI: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = 'OEM '#1074' ANSI'
      OnExecute = acToolsCnvOEM2ANSIExecute
    end
    object acToolsCnvANSI2OEM: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = 'ANSI '#1074' OEM'
      OnExecute = acToolsCnvANSI2OEMExecute
    end
    object acToolsCnvDate2Text: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1044#1072#1090#1072' '#1074' '#1090#1077#1082#1089#1090
      ShortCut = 24644
      OnExecute = acToolsCnvDate2TextExecute
    end
    object acToolsCnvMergePara: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1054#1073#1098#1077#1076#1080#1085#1080#1090#1100' '#1072#1073#1079#1072#1094#1099
      ShortCut = 24655
      OnExecute = acToolsCnvMergeParaExecute
    end
    object acToolsAnalyseHeader: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1040#1085#1072#1083#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1075#1086#1083#1086#1074#1086#1082
      ShortCut = 24641
      OnExecute = acToolsAnalyseHeaderExecute
    end
    object acToolsFindTNVED: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1057#1089#1099#1083#1082#1080' '#1085#1072' '#1058#1053#1042#1069#1044
      OnExecute = acToolsFindTNVEDExecute
    end
    object acToolsSubmitJurChanges: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1042#1085#1077#1089#1090#1080' '#1102#1088'. '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      OnExecute = acToolsSubmitJurChangesExecute
    end
    object acToolsUncontrol: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1057#1085#1103#1090#1100' '#1089' '#1082#1086#1085#1090#1088#1086#1083#1103'...'
      OnExecute = acToolsUncontrolExecute
    end
    object acToolsAnnounce: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1040#1085#1086#1085#1089#1080#1088#1086#1074#1072#1090#1100
      OnExecute = acToolsAnnounceExecute
    end
    object acToolsRegistrationDeclined: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1054#1090#1082#1072#1079#1072#1085#1086' '#1074' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
      OnExecute = acToolsRegistrationDeclinedExecute
    end
    object acToolsLinkAnno: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100' '#1072#1085#1085#1086#1090#1072#1094#1080#1102
      OnExecute = acToolsLinkAnnoExecute
    end
    object acToolsDocExpired: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1059#1090#1088#1072#1090#1080#1090#1100' '#1102#1088'. '#1089#1080#1083#1091
      ShortCut = 32885
      OnExecute = acToolsDocExpiredExecute
    end
    object acToolsMakeOldEdition: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1089#1090#1072#1088#1091#1102' '#1088#1077#1076#1072#1082#1094#1080#1102'...'
      ShortCut = 32847
      OnExecute = acToolsMakeOldEditionExecute
    end
    object acToolsMakeOtherEdition: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1076#1088#1091#1075#1091#1102' '#1088#1077#1076#1072#1082#1094#1080#1102'...'
      ShortCut = 32837
      OnExecute = acToolsMakeOtherEditionExecute
    end
    object acToolsOpenAllEditions: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1074#1089#1077' '#1088#1077#1076#1072#1082#1094#1080#1080
      OnExecute = acToolsOpenAllEditionsExecute
    end
    object acToolsDeleteReference: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1087#1088#1072#1074#1082#1091
      OnExecute = acToolsDeleteReferenceExecute
    end
    object acToolsDeleteAnno: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1072#1085#1085#1086#1090#1072#1094#1080#1102
      OnExecute = acToolsDeleteAnnoExecute
    end
    object acCLDelete: TAction
      Caption = 'acCLDelete'
    end
    object acPMCorrDelete: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = acPMCorrDeleteExecute
    end
    object acPMBTreeDelete: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = acPMBTreeDeleteExecute
    end
    object acPMSubAncorEdit: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100
      OnExecute = acPMSubAncorEditExecute
    end
    object acPMSubAncorDelete: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = acPMSubAncorDeleteExecute
    end
    object acPMSubAncorSave: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
      OnExecute = acPMSubAncorSaveExecute
    end
    object acPMSubAncorSync: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1080#1088#1086#1074#1072#1090#1100
      OnExecute = acPMSubAncorSyncExecute
    end
    object acPMSubAncorSetClass: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1082#1083#1072#1089#1089
      OnExecute = acPMSubAncorSetClassExecute
    end
    object acPMSubAncorSetPrefix: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1088#1077#1092#1080#1082#1089
      OnExecute = acPMSubAncorSetPrefixExecute
    end
    object acPMSubAncorSetKey: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1082#1083#1102#1095
      OnExecute = acPMSubAncorSetKeyExecute
    end
    object acPMSubAncorSetType: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1090#1080#1087
      OnExecute = acPMSubAncorSetTypeExecute
    end
    object acPMSubAncorSetTOC: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1086#1075#1083#1072#1074#1083#1077#1085#1080#1077
      OnExecute = acPMSubAncorSetTOCExecute
    end
    object acPMSubAncorLinkExtObject: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100' '#1074#1085#1077#1096#1085#1080#1081' '#1086#1073#1098#1077#1082#1090
      OnExecute = acPMSubAncorLinkExtObjectExecute
    end
    object acPMSubAncorDelExtObject: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1085#1077#1096#1085#1080#1081' '#1086#1073#1098#1077#1082#1090
      OnExecute = acPMSubAncorDelExtObjectExecute
    end
    object acPMSubPanelLabelNum: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1053#1086#1084#1077#1088' '#1084#1077#1090#1082#1080
      OnExecute = ShowSubMaskClick
    end
    object acPMSubPanelNameType: TAction
      Tag = 1
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1058#1080#1087' '#1085#1072#1079#1074#1072#1085#1080#1103
      OnExecute = ShowSubMaskClick
    end
    object acPMSubPanelClasses: TAction
      Tag = 3
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1050#1083#1072#1089#1089#1099
      OnExecute = ShowSubMaskClick
    end
    object acPMSubPanelAutoClasses: TAction
      Tag = 4
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1040#1074#1090#1086#1050#1083#1072#1089#1089#1099
      OnExecute = ShowSubMaskClick
    end
    object acPMSubPanelKeys: TAction
      Tag = 2
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1050#1083#1102#1095#1080
      OnExecute = ShowSubMaskClick
    end
    object acPMSubPanelTypes: TAction
      Tag = 5
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1058#1080#1087#1099
      OnExecute = ShowSubMaskClick
    end
    object acPMSubPanelTOC: TAction
      Tag = 6
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1054#1075#1083#1072#1074#1083#1077#1085#1080#1077
      OnExecute = ShowSubMaskClick
    end
    object acPMSubPanelExtObjects: TAction
      Tag = 7
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1042#1085#1077#1096#1085#1080#1077' '#1086#1073#1098#1077#1082#1090#1099
      OnExecute = ShowSubMaskClick
    end
    object acPMTextSetClass: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1082#1083#1072#1089#1089
      OnExecute = acPMTextSetClassExecute
    end
    object acPMTextSetPrefix: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1088#1077#1092#1080#1082#1089
      OnExecute = acPMTextSetPrefixExecute
    end
    object acPMTextSetKey: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1082#1083#1102#1095
      OnExecute = acPMTextSetKeyExecute
    end
    object acPMTextSetType: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1090#1080#1087
      OnExecute = acPMTextSetTypeExecute
    end
    object acPMTextInsertText: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1090#1077#1082#1089#1090
      OnExecute = acPMTextInsertTextExecute
    end
    object acPMTextFindInterpretation: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1055#1086#1080#1089#1082' '#1090#1086#1083#1082#1086#1074#1072#1085#1080#1103
      OnExecute = acPMTextFindInterpretationExecute
    end
    object acPMTextJumpToSub: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1085#1072' '#1084#1077#1090#1082#1091
      OnExecute = acPMTextJumpToSubExecute
    end
    object acPMTextJumpToPara: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1057#1084#1077#1089#1090#1080#1090#1100#1089#1103' '#1087#1086' '#1087#1072#1088#1072#1075#1088#1072#1092#1072#1084
      OnExecute = acPMTextJumpToParaExecute
    end
    object acPMTextDocInfo: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1077
      OnExecute = acPMTextDocInfoExecute
    end
    object acPMAnnoSetClass: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1082#1083#1072#1089#1089' '#1072#1085#1085#1086#1090#1072#1094#1080#1080
      OnExecute = acPMAnnoSetClassExecute
    end
    object acPMMainSplitWindow: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1100' '#1086#1082#1085#1086
      OnExecute = acPMMainSplitWindowExecute
    end
    object acPMMainSwapPanels: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1055#1086#1084#1077#1085#1103#1090#1100' '#1084#1077#1089#1090#1072#1084#1080
      Enabled = False
      OnExecute = acPMMainSwapPanelsExecute
    end
    object acPMSubEditName: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100' '#1085#1072#1079#1074#1072#1085#1080#1077
      OnExecute = acPMSubEditNameExecute
    end
    object acPMSubDelete: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = acPMSubDeleteExecute
    end
    object acPMSectionPortrait: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1050#1085#1080#1078#1085#1072#1103
      OnExecute = acPMSectionPortraitExecute
    end
    object acPMSectionLandscape: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1040#1083#1100#1073#1086#1084#1085#1072#1103
      OnExecute = acPMSectionLandscapeExecute
    end
    object acPMSectionA4: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = 'A4'
      OnExecute = acPMSectionA4Execute
    end
    object acPMSectionA3: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = 'A3'
      OnExecute = acPMSectionA3Execute
    end
    object acPMSectionA2: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = 'A2'
      OnExecute = acPMSectionA2Execute
    end
    object acPMSectionA1: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = 'A1'
      OnExecute = acPMSectionA1Execute
    end
    object acPMAttrEdit: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1056#1077#1076#1072#1082#1090#1086#1088
      OnExecute = acPMAttrEditExecute
    end
    object acPMAttrSave: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
      OnExecute = acPMAttrSaveExecute
    end
    object acPMAttrDelete: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ShortCut = 46
      OnExecute = acPMAttrDeleteExecute
    end
    object acPMAttrShowOwners: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1052#1077#1090#1082#1080'-'#1074#1083#1072#1076#1077#1083#1100#1094#1099
      OnExecute = acPMAttrShowOwnersExecute
    end
    object acPMJournalDelete: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnExecute = acPMJournalDeleteExecute
    end
    object acPMPicStretch: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1056#1072#1089#1090#1103#1075#1080#1074#1072#1090#1100
      OnExecute = acPMPicStretchExecute
    end
    object acInsFormula: TAction
      Category = #1042#1089#1090#1072#1074#1082#1072
      Caption = #1060#1086#1088#1084#1091#1083#1072
      ShortCut = 24646
      OnExecute = acInsFormulaExecute
    end
    object acStyleApendixHeader: TAction
      Tag = 13
      Category = #1058#1077#1082#1089#1090
      Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1103
      ShortCut = 32833
      OnExecute = miUserSetStyle
    end
    object acLinkFollowContext: TAction
      Category = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      Caption = #1055#1077#1088#1077#1081#1090#1080' '#1087#1086' '#1089#1089#1099#1083#1082#1077
      OnExecute = acLinkFollowContextExecute
    end
    object acLinkSave: TAction
      Category = #1043#1080#1087#1077#1088#1090#1077#1082#1089#1090
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100' '#1072#1076#1088#1077#1089
      OnExecute = acLinkSaveExecute
    end
    object acSetFrame: TAction
      Category = #1058#1072#1073#1083#1080#1094#1099
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1088#1072#1084#1082#1080
      ShortCut = 32851
      OnExecute = acSetFrameExecute
    end
    object acDelFrame: TAction
      Category = #1058#1072#1073#1083#1080#1094#1099
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1088#1072#1084#1082#1080
      ShortCut = 32836
      OnExecute = acDelFrameExecute
    end
    object acFindTable: TAction
      Category = #1055#1086#1080#1089#1082
      Caption = #1053#1072#1081#1090#1080' '#1090#1072#1073#1083#1080#1094#1091
      ShortCut = 32852
      OnExecute = acFindTableExecute
    end
    object acOldNSRC: TAction
      Category = #1058#1072#1073#1083#1080#1094#1099
      Caption = #1042#1099#1083#1080#1074#1072#1090#1100' '#1074' '#1087#1089#1077#1074#1076#1086#1075#1088#1072#1092#1080#1082#1091
      GroupIndex = 1
      OnExecute = acOldNSRCExecute
      OnUpdate = acOldNSRCUpdate
    end
    object acRememberWidths: TAction
      Category = #1058#1072#1073#1083#1080#1094#1099
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100' '#1096#1080#1088#1080#1085#1099' '#1103#1095#1077#1077#1082
      ShortCut = 16461
      OnExecute = acRememberWidthsExecute
      OnUpdate = acRememberWidthsUpdate
    end
    object acApplyWidths: TAction
      Category = #1058#1072#1073#1083#1080#1094#1099
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1096#1080#1088#1080#1085#1099' '#1103#1095#1077#1077#1082
      ShortCut = 16463
      OnExecute = acApplyWidthsExecute
      OnUpdate = acApplyWidthsUpdate
    end
    object acMonoEnlarge: TAction
      Category = #1059#1090#1080#1083#1080#1090#1099
      Caption = 'acMonoEnlarge'
      ShortCut = 49339
      OnExecute = acMonoEnlargeExecute
    end
    object acMonoShrink: TAction
      Category = #1059#1090#1080#1083#1080#1090#1099
      Caption = 'acMonoShrink'
      ShortCut = 49341
      OnExecute = acMonoShrinkExecute
    end
    object acToolsSetSections: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1056#1072#1089#1089#1090#1072#1085#1086#1074#1082#1072' '#1088#1072#1079#1076#1077#1083#1086#1074
      OnExecute = acToolsSetSectionsExecute
    end
    object acTranslate2Text: TAction
      Category = #1058#1072#1073#1083#1080#1094#1099
      Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1074' '#1090#1077#1082#1089#1090
      OnExecute = acTranslate2TextExecute
      OnUpdate = acTranslate2TextUpdate
    end
    object acToolsAutolink: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1040#1074#1090#1086#1087#1088#1086#1089#1090#1072#1085#1086#1074#1082#1072' '#1089#1089#1099#1083#1086#1082
      OnExecute = acToolsAutolinkExecute
    end
    object acPMSubCopyAddr: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1072#1076#1088#1077#1089
      OnExecute = acPMSubCopyAddrExecute
    end
    object acInsTemplate: TAction
      Category = #1042#1089#1090#1072#1074#1082#1072
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      ShortCut = 32813
      OnExecute = acInsTemplateExecute
    end
    object acInsTemplateEdit: TAction
      Category = #1042#1089#1090#1072#1074#1082#1072
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      OnExecute = acInsTemplateEditExecute
    end
    object acPMRelSubPanelSubNum: TAction
      Category = #1050#1086#1085#1090'. '#1052#1077#1085#1102
      Caption = #1053#1086#1084#1077#1088' '#1084#1077#1090#1082#1080
      OnExecute = ShowRelSubMaskClick
    end
    object acSaveLocal: TAction
      Category = #1058#1077#1082#1089#1090
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1083#1086#1082#1072#1083#1100#1085#1086
      ShortCut = 32881
      OnExecute = acSaveLocalExecute
    end
  end
  object acPagePublished: TAction
    Tag = 11
    Category = #1053#1072#1074#1080#1075#1072#1094#1080#1103
    ShortCut = 8314
    OnExecute = acGoToPageExecute
  end
  object pmCrrespList: TPopupMenu
    Left = 297
    Top = 141
    object miDelCorrepItem: TMenuItem
      Action = acPMCorrDelete
      ShortCut = 46
    end
    object N27: TMenuItem
      Action = acReplaceHRefDocForBlockCorrespondents
    end
  end
  object AnnoPopUpMenu: TLinkPopUpMenu
    PrimaryPopUpMenu = ClipbrdPopUpMenu
    Active = False
    Left = 437
    Top = 141
    object miSetAnnoClass: TMenuItem
      Action = acPMAnnoSetClass
      ShortCut = 49217
    end
  end
  object dlgOpenObjectFile: TOpenDialog
    Filter = 
      #1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*|'#1043#1088#1072#1092#1080#1095#1077#1089#1082#1080#1077' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103'|*.gif;*.tif;*.jpg;*.jpeg;*' +
      '.bmp;*.png;*.pcx;*.tga'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = #1042#1089#1090#1072#1074#1080#1090#1100' '#1086#1073#1098#1077#1082#1090' '#1074' '#1076#1086#1082#1091#1084#1077#1085#1090
    Left = 16
    Top = 409
  end
  object dlgSaveObjectFile: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1086#1073#1098#1077#1082#1090' '#1085#1072' '#1076#1080#1089#1082
    Left = 48
    Top = 409
  end
  object pmHyperlink: TPopupMenu
    Left = 299
    Top = 185
    object N26: TMenuItem
      Action = acLinkFollowContext
    end
    object N31: TMenuItem
      Action = acLinkSave
    end
    object N29: TMenuItem
      Action = acLinkDeleteContext
    end
  end
  object RelSubPanelPopupMenu: TLinkPopUpMenu
    PrimaryPopUpMenu = MainPopupMenu
    Active = False
    Left = 465
    Top = 141
    object piRelShowSubNumber: TMenuItem
      Action = acPMRelSubPanelSubNum
    end
    object N52: TMenuItem
      Caption = '-'
    end
  end
end
