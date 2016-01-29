object LinkHistoForm: TLinkHistoForm
  Left = 366
  Top = 160
  Width = 626
  Height = 462
  Caption = '"'#1055#1077#1088#1077#1075#1088#1091#1078#1077#1085#1085#1099#1077'" '#1101#1083#1077#1084#1077#1085#1090#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lstHisto: TvtDStringLister
    Left = 0
    Top = 0
    Width = 610
    Height = 404
    Sorted = False
    AutoRowHeight = False
    IntegralHeight = False
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clInactiveCaption
    SelectNonFocusColor.TextColor = clHighlightText
    MultiStrokeItem = True
    ViewOptions = [voShowInterRowSpace]
    OnCurrentChanged = lstHistoCurrentChanged
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    ParentColor = False
    PopupMenu = ListPopUpMenu
    TabOrder = 0
    TabStop = True
  end
  object ListFooter: TvtStatusBar
    Left = 0
    Top = 404
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
  object ListPopUpMenu: TPopupMenu
    Left = 30
    Top = 38
    object miInsertClassToObjList: TMenuItem
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100
      OnClick = miInsertClassToObjListClick
    end
  end
end
