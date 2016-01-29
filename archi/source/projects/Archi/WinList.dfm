object WinList: TWinList
  Left = 371
  Top = 149
  Width = 626
  Height = 247
  Caption = #1057#1087#1080#1089#1086#1082' '#1086#1090#1082#1088#1099#1090#1099#1093' '#1086#1082#1086#1085
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object lstWinSet: TvtStringLister
    Left = 0
    Top = 0
    Width = 610
    Height = 189
    Sorted = False
    AlienSource = False
    AutoRowHeight = False
    IntegralHeight = False
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clInactiveCaption
    SelectNonFocusColor.TextColor = clHighlightText
    OnCurrentChanged = lstWinSetCurrentChanged
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    ParentColor = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    TabStop = True
    OnActionElement = lstWinSetActionElement
  end
  object ListFooter: TvtStatusBar
    Left = 0
    Top = 189
    Width = 610
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
  object PopupMenu1: TPopupMenu
    Left = 157
    Top = 63
    object miGoto: TMenuItem
      Caption = #1055#1077#1088#1077#1081#1090#1080
      Default = True
      OnClick = miGotoClick
    end
    object miDel: TMenuItem
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ShortCut = 46
      OnClick = miDelClick
    end
  end
end
