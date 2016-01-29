object ArchiveList: TArchiveList
  Left = 619
  Top = 325
  BorderStyle = bsDialog
  Caption = #1057#1087#1080#1089#1086#1082' '#1072#1088#1093#1080#1074#1086#1074
  ClientHeight = 274
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lstArchives: TvtLister
    Left = 8
    Top = 8
    Width = 377
    Height = 225
    AutoRowHeight = True
    BorderStyle = bsSingle
    Columns = 255
    IntegralHeight = True
    MultiSelect = False
    InternalSelector = True
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    RowHeight = 13
    ScrollStyle = ssVertical
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clBtnFace
    SelectNonFocusColor.TextColor = clBtnText
    ShowHeader = False
    UseTabStops = False
    PickedList = False
    TriplePicked = False
    MultiStrokeItem = False
    ReadOnly = False
    ViewOptions = []
    ActionElementMode = l3_amDoubleClick
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = True
    TabOrder = 0
    TabStop = True
  end
  object btnRestore: TButton
    Left = 184
    Top = 240
    Width = 123
    Height = 25
    Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 312
    Top = 240
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
  end
end
