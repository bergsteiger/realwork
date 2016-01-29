object ViewSubDlg: TViewSubDlg
  Left = 428
  Top = 212
  AutoScroll = False
  Caption = #1052#1045#1058#1050#1048' - '#1042#1051#1040#1044#1045#1051#1068#1062#1067
  ClientHeight = 262
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object lstSub: TvtDStringLister
    Left = 0
    Top = 0
    Width = 397
    Height = 242
    Sorted = False
    AutoRowHeight = False
    IntegralHeight = False
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clInactiveCaption
    SelectNonFocusColor.TextColor = clHighlightText
    OnGetItemImageIndex = lstSubGetItemImageIndex
    OnCurrentChanged = lstSubCurrentChanged
    Align = alClient
    ParentColor = False
    TabOrder = 0
    TabStop = True
    OnActionElement = lstSubActionElement
  end
  object FooterPanel: TvtStatusBar
    Left = 0
    Top = 242
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
