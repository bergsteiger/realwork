object DocumentList: TDocumentList
  Left = 0
  Top = 0
  Width = 435
  Height = 266
  Align = alClient
  TabOrder = 0
  object Split1: TvtSplitter
    Left = 0
    Top = 122
    Width = 435
    Height = 4
    Cursor = crVSplit
    Align = alBottom
    Visible = False
  end
  object SrchResultLister: TvtLister
    Left = 0
    Top = 0
    Width = 435
    Height = 122
    Images = ArchiResources.CommonImageList
    AutoRowHeight = False
    IntegralHeight = False
    MultiSelect = True
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    RowHeight = 19
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clInactiveCaption
    SelectNonFocusColor.TextColor = clHighlightText
    MultiStrokeItem = True
    ViewOptions = [voShowInterRowSpace]
    OnGetItemImageIndex = SrchResultListerGetItemImageIndex
    OnGetItemImageOverlays = SrchResultListerGetItemImageOverlays
    OnCurrentChanged = SrchResultListerCurrentChanged
    Align = alClient
    ParentColor = False
    PopupMenu = pmSrch
    TabOrder = 0
    TabStop = True
    OnActionElement = SrchResultListerActionElement
  end
  object SubList: TvtDStringLister
    Left = 0
    Top = 126
    Width = 435
    Height = 120
    Sorted = False
    Images = ArchiResources.CommonImageList
    AutoRowHeight = False
    IntegralHeight = False
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    RowHeight = 19
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clInactiveCaption
    SelectNonFocusColor.TextColor = clHighlightText
    OnGetItemImageIndex = SubListGetItemImageIndex
    Align = alBottom
    ParentColor = False
    TabOrder = 1
    TabStop = True
    Visible = False
    OnActionElement = SrchResultListerActionElement
  end
  object FooterPanel: TvtStatusBar
    Left = 0
    Top = 246
    Width = 435
    Height = 20
    Panels = <
      item
        Alignment = taCenter
        Width = 150
      end
      item
        Width = 50
      end>
    object PercentMeter: TW95Meter
      Left = 3
      Top = 4
      Width = 144
      Height = 15
      OnSetStr = evntPercentMeterSetStr
      EdgeStyle = st95None
      SegmentWidth = 4
      Percent = 33
      BorderStyle = bsNone
      HideInactive = True
    end
  end
  object pmSrch: TPopupMenu
    Left = 3
    Top = 14
    object piSort: TMenuItem
      Action = acSort
    end
    object piDocInfo: TMenuItem
      Action = acDocInfo
    end
    object miAddIDtoDocSet: TMenuItem
      Action = acAddIDtoDocSet
    end
    object miInsertDocToObjList: TMenuItem
      Action = acInsertDocToObjList
    end
    object miRemoveItem: TMenuItem
      Action = acRemoveItem
    end
  end
  object alDocList: TActionList
    Left = 44
    Top = 16
    object acSort: TAction
      Category = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072'...'
      GroupIndex = 1
      OnExecute = acSortExecute
    end
    object acTypeFilter: TAction
      Caption = #1060#1080#1083#1100#1090#1088' ...'
      OnExecute = acTypeFilterExecute
    end
    object acDocInfo: TAction
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072#1093
      ShortCut = 32841
      OnExecute = acDocInfoExecute
    end
    object acAddIDtoDocSet: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' ID'
      OnExecute = acAddIDtoDocSetExecute
    end
    object acInsertDocToObjList: TAction
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
      OnExecute = acInsertDocToObjListExecute
    end
    object acRemoveItem: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1080#1079' '#1089#1087#1080#1089#1082#1072
      ShortCut = 46
      OnExecute = acRemoveItemExecute
    end
    object acPrintAll: TAction
      Caption = #1055#1077#1095#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
      OnExecute = acPrintAllExecute
    end
    object acSaveToEVD: TAction
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' '#1069#1074#1077#1088#1077#1089#1090
      OnExecute = acSaveToEVDExecute
    end
    object acChangeHLinks: TAction
      Caption = #1047#1072#1084#1077#1085#1072' '#1089#1089#1099#1083#1086#1082
      OnExecute = acChangeHLinksExecute
    end
  end
end
