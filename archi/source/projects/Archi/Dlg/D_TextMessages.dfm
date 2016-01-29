object dlgTextMessages: TdlgTextMessages
  Left = 318
  Top = 256
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
  ClientHeight = 426
  ClientWidth = 672
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Lister: TvtLister
    Left = 0
    Top = 0
    Width = 672
    Height = 372
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clBtnFace
    SelectNonFocusColor.TextColor = clBtnText
    MultiStrokeItem = True
    OnGetStrItem = ListerGetStrItem
    OnGetItemImageIndex = ListerGetItemImageIndex
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    ParentColor = False
    TabOrder = 0
    TabStop = True
  end
  object Button1: TButton
    Left = 528
    Top = 384
    Width = 131
    Height = 33
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
end
