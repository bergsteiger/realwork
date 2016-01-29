inherited AccessErrorWin: TAccessErrorWin
  Left = 380
  Top = 266
  HorzScrollBar.Range = 0
  AutoScroll = False
  Caption = #1055#1088#1086#1073#1083#1077#1084#1099' '#1075#1088#1091#1087#1087#1086#1074#1086#1081' '#1086#1087#1077#1088#1072#1094#1080#1080
  ClientHeight = 369
  ClientWidth = 496
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Left = 399
    Height = 369
  end
  inherited Panel1: TPanel
    Width = 399
    Height = 369
    object ItemList: TvtDStringLister
      Left = 1
      Top = 1
      Width = 397
      Height = 347
      Sorted = False
      AutoRowHeight = False
      IntegralHeight = False
      MultiSelect = True
      ProtectColor.BackColor = clRed
      ProtectColor.TextColor = clWhite
      SelectColor.BackColor = clHighlight
      SelectColor.TextColor = clHighlightText
      SelectNonFocusColor.BackColor = clInactiveCaption
      SelectNonFocusColor.TextColor = clHighlightText
      MultiStrokeItem = True
      ViewOptions = [voShowInterRowSpace]
      OnCurrentChanged = ItemListCurrentChanged
      Align = alClient
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      ParentColor = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      TabStop = True
    end
    object ListFooter: TvtStatusBar
      Left = 1
      Top = 348
      Width = 397
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
  object PopupMenu1: TPopupMenu
    Left = 85
    Top = 89
    object pmCopy: TMenuItem
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' ID '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      ShortCut = 16451
      OnClick = pmCopyClick
    end
  end
end
