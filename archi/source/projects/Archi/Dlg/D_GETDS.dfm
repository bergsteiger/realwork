object GetDocSetDlg: TGetDocSetDlg
  Left = 378
  Top = 188
  ActiveControl = lstDocSet
  AutoScroll = False
  Caption = #1042#1067#1041#1054#1056#1050#1048' '#1044#1054#1050#1059#1052#1045#1053#1058#1054#1042
  ClientHeight = 279
  ClientWidth = 377
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
  object Panel1: TPanel
    Left = 0
    Top = 240
    Width = 377
    Height = 39
    Align = alBottom
    TabOrder = 0
    object Panel2: TPanel
      Left = 123
      Top = 1
      Width = 253
      Height = 37
      Align = alRight
      BevelOuter = bvNone
      Caption = 'Panel2'
      TabOrder = 0
      object OKBtn: TBitBtn
        Left = 2
        Top = 5
        Width = 77
        Height = 27
        TabOrder = 0
        Kind = bkOK
        Margin = 2
        Spacing = -1
        IsControl = True
      end
      object CancelBtn: TBitBtn
        Left = 86
        Top = 5
        Width = 77
        Height = 27
        TabOrder = 1
        Kind = bkCancel
        Margin = 2
        Spacing = -1
        IsControl = True
      end
      object HelpBtn: TBitBtn
        Left = 170
        Top = 5
        Width = 77
        Height = 27
        Caption = 'Help'
        TabOrder = 2
        Kind = bkHelp
        Margin = 2
        Spacing = -1
        IsControl = True
      end
    end
  end
  object lstDocSet: TvtStringLister
    Left = 0
    Top = 0
    Width = 377
    Height = 240
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
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    ParentColor = False
    TabOrder = 1
    TabStop = True
  end
end
