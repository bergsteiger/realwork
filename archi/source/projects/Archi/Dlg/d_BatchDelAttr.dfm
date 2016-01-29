inherited BatchAttrDelDlg: TBatchAttrDelDlg
  Left = 489
  Top = 268
  VertScrollBar.Range = 0
  AutoScroll = False
  Caption = #1055#1072#1082#1077#1090#1085#1086#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1077' '#1072#1090#1088#1080#1073#1091#1090#1086#1074
  ClientHeight = 449
  ClientWidth = 437
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  inherited ButtonPanel: TPanel
    Top = 404
    Width = 437
    inherited OK: TBitBtn
      Left = 149
      Enabled = False
    end
    inherited Cancel: TBitBtn
      Left = 247
    end
    inherited Help: TBitBtn
      Left = 344
    end
  end
  object lstAttrTypes: TvtLister
    Left = 0
    Top = 0
    Width = 437
    Height = 404
    AutoRowHeight = False
    IntegralHeight = False
    MultiSelect = True
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clBtnFace
    SelectNonFocusColor.TextColor = clBtnText
    PickedList = True
    OnGetStrItem = lstAttrTypesGetStrItem
    OnSelectChanged = lstAttrTypesSelectChanged
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    ParentColor = False
    TabOrder = 1
    TabStop = True
  end
end
