object MainForm: TMainForm
  Left = 196
  Top = 120
  Width = 696
  Height = 480
  Caption = 'Everest Viewer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 113
    Top = 52
    Height = 346
  end
  object Splitter2: TSplitter
    Left = 153
    Top = 52
    Height = 346
  end
  object Viewer: TevEditor
    Left = 156
    Top = 52
    Width = 532
    Height = 346
    Canvas.DrawSpecial = False
    Align = alClient
    Controller = OvcController
    HScrollBar = HScrollBar
    VSubPanel = VSubPanel
    ScrollStyle = ssVertical
    ReadOnly = True
    TextSource = TextSource
    OnGetMonikerSink = ViewerGetMonikerSink
    Color = clWhite
    TabOrder = 0
    TabStop = True
    BorderStyle = bsSingle
  end
  object URL: TevEdit
    Left = 0
    Top = 27
    Width = 688
    Height = 25
    Canvas.DrawSpecial = False
    Align = alTop
    Controller = OvcController
    TabOrder = 1
    TabStop = True
    BorderStyle = bsSingle
    OnKeyDown = URLKeyDown
  end
  object pnStatus: TPanel
    Left = 0
    Top = 398
    Width = 688
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 2
    object Meter: TvtW95Meter
      Left = 0
      Top = 0
      Width = 169
      Height = 20
      OnSetStr = MeterSetStr
      Align = alLeft
      HideInactive = True
    end
    object HScrollBar: TScrollBar
      Left = 544
      Top = 0
      Width = 140
      Height = 20
      Align = alRight
      LargeChange = 3968
      Max = 11906
      PageSize = 6336
      SmallChange = 120
      TabOrder = 1
    end
  end
  object Contents: TvtOutliner
    Left = 0
    Top = 52
    Width = 113
    Height = 346
    Images = vtStdResources.Images
    AutoRowHeight = False
    HeaderHeight = 0
    IntegralHeight = False
    MultiStrokeItem = False
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    RowHeight = 20
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    PickedList = False
    ReadOnly = False
    ShowRoot = False
    Align = alLeft
    Controller = OvcController
    ParentColor = False
    TabOrder = 3
    TabStop = True
    OnActionElement = ContentsActionElement
  end
  object Dock971: TDock97
    Left = 0
    Top = 0
    Width = 688
    Height = 27
    object Toolbar971: TToolbar97
      Left = 0
      Caption = 'Toolbar971'
      DockPos = 0
      object evButton1: TevButton
        Left = 161
        Operation = ev_ccShowDocumentPart
        GroupIndex = 1
        DisplayMode = dmTextOnly
        Caption = 'All'
      end
      object evButton2: TevButton
        Tag = 7
        Left = 138
        Operation = ev_ccShowDocumentPart
        GroupIndex = 1
        DisplayMode = dmTextOnly
        Caption = '7'
      end
      object evButton3: TevButton
        Tag = 1
        Left = 0
        Operation = ev_ccShowDocumentPart
        GroupIndex = 1
        DisplayMode = dmTextOnly
        Caption = '1'
      end
      object evButton4: TevButton
        Tag = 6
        Left = 115
        Operation = ev_ccShowDocumentPart
        GroupIndex = 1
        DisplayMode = dmTextOnly
        Caption = '6'
      end
      object evButton5: TevButton
        Tag = 5
        Left = 92
        Operation = ev_ccShowDocumentPart
        GroupIndex = 1
        DisplayMode = dmTextOnly
        Caption = '5'
      end
      object evButton6: TevButton
        Tag = 4
        Left = 69
        Operation = ev_ccShowDocumentPart
        GroupIndex = 1
        DisplayMode = dmTextOnly
        Caption = '4'
      end
      object evButton7: TevButton
        Tag = 3
        Left = 46
        Operation = ev_ccShowDocumentPart
        GroupIndex = 1
        DisplayMode = dmTextOnly
        Caption = '3'
      end
      object evButton8: TevButton
        Tag = 2
        Left = 23
        Operation = ev_ccShowDocumentPart
        GroupIndex = 1
        DisplayMode = dmTextOnly
        Caption = '2'
      end
    end
  end
  object VSubPanel: TevSubPanel
    Left = 116
    Top = 52
    Width = 37
    Height = 346
    Align = alLeft
    TabOrder = 5
    SubDescriptors = SubDescriptors
  end
  object MainMenu: TMainMenu
    Left = 16
    Top = 32
    object miFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object miFileNew: TMenuItem
        Caption = #1053#1086#1074#1099#1081
        ShortCut = 16462
        OnClick = miFileNewClick
      end
      object miFileOpen: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100'...'
        ShortCut = 16463
        OnClick = miFileOpenClick
      end
      object miFilePrintBreak: TMenuItem
        Caption = '-'
      end
      object miFilePrint: TevMenuItem
        Caption = #1055#1077#1095#1072#1090#1100'...'
        ShortCut = 16464
        Operation = ev_ccPrintEx
      end
      object miExitBreak: TMenuItem
        Caption = '-'
      end
      object miFileExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = miFileExitClick
      end
      object miMRUBreak: TMenuItem
        Caption = '-'
      end
      object miMRU: TMenuItem
        Caption = 'MRU'
      end
    end
    object miText: TMenuItem
      Caption = #1058#1077#1082#1089#1090
      object miTextSearch: TevMenuItem
        Caption = #1053#1072#1081#1090#1080'...'
        ShortCut = 16454
        Operation = ev_ccSearch
      end
      object miTextSearchAgain: TevMenuItem
        Caption = #1053#1072#1081#1090#1080' '#1076#1072#1083#1077#1077
        ShortCut = 114
        Operation = ev_ccSearchAgain
      end
      object miSelectBreak: TMenuItem
        Caption = '-'
      end
      object miTextSelectAll: TevMenuItem
        Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
        ShortCut = 16449
        Operation = ev_ccSelectAll
      end
      object miTextHideSelection: TevMenuItem
        Caption = #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
        ShortCut = 24641
        Operation = ev_ccHideSelection
      end
    end
    object miView: TMenuItem
      Caption = #1042#1080#1076
      object miViewShowDocumentStructure: TevMenuItem
        AutoCheck = True
        Caption = #1057#1090#1088#1091#1082#1090#1091#1088#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        Operation = ev_ccShowDocumentParts
      end
    end
  end
  object OvcController: TOvcController
    EntryCommands.TableList = (
      'Default'
      True
      ()
      'WordStar'
      False
      ()
      'Grid'
      False
      ())
    Left = 144
    Top = 152
  end
  object TextSource: TevTextSource
    Processor.ReadOnly = True
    DocumentContainer.NeedProcessMessages = True
    Indicator.NeedProgressProc = True
    Indicator.Meter = Meter
    PrintDialog = PrintDialog
    Left = 144
    Top = 192
  end
  object OpenDialog: TOpenDialog
    Filter = 
      #1044#1086#1082#1091#1084#1077#1085#1090#1099' '#1069#1074#1077#1088#1077#1089#1090' (*.evd;*.evr)|*.evr;*.evd|'#1058#1072#1073#1083#1080#1094#1099' '#1089#1090#1080#1083#1077#1081' '#1069#1074#1077#1088#1077 +
      #1089#1090' (*.evs)|*.evs|'#1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' c '#1092#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1085#1080#1077#1084' (*.txt)|*.txt' +
      '|'#1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' AS IS (*.txt)|*.txt|'#1048#1089#1093#1086#1076#1085#1080#1082#1080' '#1043#1072#1088#1072#1085#1090#1072' (*.nsr)|*' +
      '.nsr|'#1044#1086#1082#1091#1084#1077#1085#1090#1099' RTF (*.rtf)|*.rtf|'#1044#1086#1082#1091#1084#1077#1085#1090#1099' RTF ('#1073#1077#1079' '#1086#1092#1086#1088#1084#1083#1077#1085#1080#1103') ' +
      '(*.rtf)|*.rtf|'#1044#1086#1082#1091#1084#1077#1085#1090#1099' MS Word (*.doc)|*.doc|HTML-'#1089#1090#1088#1072#1085#1080#1094#1099' (*.h' +
      'tm;*.html)|*.htm;*.html|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Title = #1054#1090#1082#1088#1099#1090#1100
    Left = 180
    Top = 154
  end
  object Everest: TDdeServerConv
    OnExecuteMacro = EverestExecuteMacro
    Left = 217
    Top = 155
  end
  object PrintDialog: TPrintDialog
    Left = 184
    Top = 192
  end
  object LoadDocumentManager: TevLoadDocumentManager
    OpenDialog = OpenDialog
    Left = 248
    Top = 154
  end
  object SubDescriptors: TevSubDescriptors
    SubsLayer.Font.Color = clBlack
    MarkersLayer.Flag0.Font.Color = clNavy
    MarkersLayer.Flag0.Offset = 20
    MarkersLayer.Flag1.Font.Color = clTeal
    MarkersLayer.Flag1.Offset = 20
    BookmarksLayer.Font.Color = clGreen
    MarksLayer.Font.Color = clRed
    MarksLayer.Flag0.Font.Color = clNavy
    MarksLayer.Flag0.Offset = 20
    MarksLayer.Flag1.Font.Color = clLime
    MarksLayer.Flag1.Offset = 20
    Left = 225
    Top = 192
  end
end
