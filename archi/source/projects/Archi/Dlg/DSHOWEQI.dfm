inherited DShowEq: TDShowEq
  Left = 495
  Top = 228
  HorzScrollBar.Range = 0
  AutoScroll = False
  Caption = #1069#1050#1042#1048#1042#1040#1051#1045#1053#1058#1053#1067#1045' '#1050#1051#1040#1057#1057#1067
  ClientHeight = 376
  ClientWidth = 518
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Left = 421
    Height = 376
    inherited OK: TBitBtn
      OnClick = OKClick
    end
  end
  inherited Panel1: TPanel
    Width = 421
    Height = 376
    object ItemList: TvtDStringLister
      Left = 1
      Top = 1
      Width = 419
      Height = 354
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
      OnGetItemImageIndex = ItemListGetItemImageIndex
      OnCurrentChanged = ItemListCurrentChanged
      Align = alClient
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      ParentColor = False
      TabOrder = 0
      TabStop = True
      OnActionElement = ItemListActionElement
    end
    object ListFooter: TvtStatusBar
      Left = 1
      Top = 355
      Width = 419
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
end
