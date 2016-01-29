object evExtDlgSpecialPaste: TevExtDlgSpecialPaste
  Left = 244
  Top = 129
  ActiveControl = lstClipboardFormats
  BorderStyle = bsDialog
  Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1072#1103' '#1074#1089#1090#1072#1074#1082#1072
  ClientHeight = 179
  ClientWidth = 388
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TBitBtn
    Left = 300
    Top = 8
    Width = 77
    Height = 27
    TabOrder = 0
    Kind = bkOK
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object CancelBtn: TBitBtn
    Left = 300
    Top = 40
    Width = 77
    Height = 27
    TabOrder = 1
    Kind = bkCancel
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object HelpBtn: TBitBtn
    Left = 300
    Top = 72
    Width = 77
    Height = 27
    TabOrder = 2
    Kind = bkHelp
    Margin = 2
    Spacing = -1
    IsControl = True
  end
  object pnClipboardFormats: TPanel
    Left = 7
    Top = 8
    Width = 288
    Height = 163
    BevelInner = bvLowered
    TabOrder = 3
    object lstClipboardFormats: TvtStringLister
      Left = 2
      Top = 2
      Width = 284
      Height = 159
      Sorted = False
      AlienSource = False
      AutoRowHeight = False
      Header.Left = 0
      Header.Top = 0
      Header.Width = 280
      Header.Height = 0
      Header.Sections = <>
      IntegralHeight = False
      ProtectColor.BackColor = clRed
      ProtectColor.TextColor = clWhite
      RowHeight = 13
      SelectColor.BackColor = clHighlight
      SelectColor.TextColor = clHighlightText
      SelectNonFocusColor.BackColor = clInactiveCaption
      SelectNonFocusColor.TextColor = clHighlightText
      ReadOnly = False
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      TabOrder = 0
      TabStop = True
      OnActionElement = lstClipboardFormatsActionElement
    end
  end
end
