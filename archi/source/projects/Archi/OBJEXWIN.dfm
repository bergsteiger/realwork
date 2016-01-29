object ObjectExplorerWin: TObjectExplorerWin
  Left = 405
  Top = 307
  Width = 160
  Height = 522
  ActiveControl = ObjectExplorer
  BorderIcons = [biSystemMenu]
  Caption = #1056#1045#1045#1057#1058#1056' '#1054#1041#1066#1045#1050#1058#1054#1042
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ObjectExplorer: TvtOutliner
    Left = 0
    Top = 0
    Width = 144
    Height = 484
    AutoRowHeight = False
    IntegralHeight = False
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    RowHeight = 20
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clBtnFace
    SelectNonFocusColor.TextColor = clBtnText
    OnGetItemImage = ObjectExplorerGetItemImage
    OnCurrentChanged = ObjectExplorerCurrentChanged
    Align = alClient
    ParentColor = False
    PopupMenu = pmExtendExplorer
    TabOrder = 0
    TabStop = True
    OnActionElement = ObjectExplorerActionElement
  end
  object pmExtendExplorer: TPopupMenu
    Left = 11
    Top = 12
    object piHideExplorer: TMenuItem
      Caption = #1057#1087#1088#1103#1090#1072#1090#1100' '#1088#1077#1077#1089#1090#1088' '#1086#1073#1098#1077#1082#1090#1086#1074
      OnClick = piHideExplorerClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object piDeleteSaveDocSet: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1099#1073#1086#1088#1082#1091
      ShortCut = 46
      OnClick = piDeleteClickDispatcher
    end
    object piRemoveLink: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1089#1099#1083#1082#1091
      ShortCut = 46
      OnClick = piRemoveLinkClick
    end
    object piCloseDoc: TMenuItem
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086
      OnClick = piCloseDocClick
    end
    object piSendMsg: TMenuItem
      Caption = #1055#1086#1089#1083#1072#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
      OnClick = piSendMsgClick
    end
    object piDeleteMessage: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' c'#1086#1086#1073#1097#1077#1085#1080#1077
      ShortCut = 46
      OnClick = piDeleteMessageClick
    end
    object piInsertDocToObjList: TMenuItem
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
      OnClick = piInsertDocToObjListClick
    end
  end
end
