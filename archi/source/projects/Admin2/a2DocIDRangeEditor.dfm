object DocIDRangeEditor: TDocIDRangeEditor
  Left = 509
  Top = 312
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1076#1080#1072#1087#1072#1079#1086#1085#1086#1074' Doc ID'
  ClientHeight = 361
  ClientWidth = 356
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  ZoneType = vcm_ztManualModal
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 10
    Top = 50
    Width = 157
    Height = 16
    Caption = #1054#1087#1088#1077#1076#1077#1083#1077#1085#1085#1099#1077' '#1080#1085#1090#1077#1088#1074#1072#1083#1099
  end
  object lstRanges: TvtDStringLister
    Left = 10
    Top = 72
    Width = 336
    Height = 202
    Sorted = False
    AutoRowHeight = False
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    RowHeight = 18
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clBtnFace
    SelectNonFocusColor.TextColor = clBtnText
    Font.Charset = DEFAULT_CHARSET
    Font.Height = -16
    ParentColor = False
    TabOrder = 0
    TabStop = True
  end
  object btnAdd: TButton
    Left = 10
    Top = 286
    Width = 168
    Height = 31
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1080#1085#1090#1077#1088#1074#1072#1083
    TabOrder = 1
    OnClick = btnAddClick
  end
  object btnDel: TButton
    Left = 187
    Top = 286
    Width = 159
    Height = 31
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1080#1085#1090#1077#1088#1074#1072#1083
    TabOrder = 2
    OnClick = btnDelClick
  end
  object btnClose: TButton
    Left = 254
    Top = 326
    Width = 92
    Height = 30
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 1
    TabOrder = 3
  end
  object cbIntervals: TComboBox
    Left = 8
    Top = 16
    Width = 337
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    TabOrder = 4
    OnSelect = cbIntervalsSelect
  end
end
