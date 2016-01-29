object AttrExplorer: TAttrExplorer
  Left = 0
  Top = 0
  Width = 435
  Height = 266
  Align = alClient
  TabOrder = 0
  object otlAttributes: TvtOutliner
    Left = 0
    Top = 0
    Width = 435
    Height = 246
    AutoRowHeight = False
    IntegralHeight = False
    MultiSelect = True
    MultiStrokeItem = True
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    RowHeight = 17
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clBtnFace
    SelectNonFocusColor.TextColor = clBtnText
    OnGetItemImage = otlAttributesGetItemImage
    OnGetItemFont = otlAttributesGetItemFont
    OnCurrentChanged = otlAttributesCurrentChanged
    Align = alClient
    ParentColor = False
    PopupMenu = AttrPopUpMenu
    TabOrder = 0
    TabStop = True
    OnActionElement = otlAttributesActionElement
    ViewOptions = [voShowInterRowSpace, voShowIcons, voShowExpandable, voShowLines, voShowOpenChip]
  end
  object AttrFooter: TvtStatusBar
    Left = 0
    Top = 246
    Width = 435
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Panels = <
      item
        Alignment = taCenter
        Width = 150
      end
      item
        Width = 50
      end>
    ParentFont = False
  end
  object AttrPopUpMenu: TLinkPopUpMenu
    Active = False
    Left = 59
    Top = 55
    object miEditAttrTree: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1086#1088
      OnClick = miEditAttrTreeClick
    end
    object miInsertAttrsToObjList: TMenuItem
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
      OnClick = miInsertAttrsToObjListClick
    end
    object miDelDocClass: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ShortCut = 46
      OnClick = miDelDocAttrClick
    end
  end
end
