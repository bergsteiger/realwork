object MainForm: TMainForm
  Left = 645
  Top = 243
  BorderStyle = bsSingle
  Caption = #1044#1080#1089#1090#1088#1080#1073#1091#1094#1080#1103' '#1040#1088#1093#1080#1074#1072#1088#1080#1091#1089#1072
  ClientHeight = 417
  ClientWidth = 371
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblDisp: TLabel
    Left = 8
    Top = 312
    Width = 116
    Height = 13
    Caption = #1055#1088#1086#1075#1088#1077#1089#1089' '#1076#1080#1089#1090#1088#1080#1073#1091#1094#1080#1080
  end
  object btnAdd: TButton
    Left = 176
    Top = 8
    Width = 81
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 0
    OnClick = btnAddClick
  end
  object btnDelete: TButton
    Left = 264
    Top = 8
    Width = 97
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = btnDeleteClick
  end
  object lstItems: TvtLister
    Left = 8
    Top = 40
    Width = 353
    Height = 264
    AutoRowHeight = True
    BorderStyle = bsSingle
    Columns = 255
    IntegralHeight = True
    MultiSelect = False
    InternalSelector = True
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    RowHeight = 20
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
    OnGetStrItem = lstItemsGetStrItem
    OnGetItemColor = lstItemsGetItemColor
    OnCountChanged = lstItemsCountChanged
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Arial Narrow'
    Font.Style = []
    ParentColor = False
    TabOrder = 2
    TabStop = True
    OnActionElement = lstItemsActionElement
  end
  object btnDistribute: TButton
    Left = 8
    Top = 352
    Width = 353
    Height = 25
    Caption = #1055#1086#1076#1083#1086#1078#1080#1090#1100' '#1089#1074#1077#1078#1091#1102' '#1074#1077#1088#1089#1080#1102
    TabOrder = 3
    OnClick = btnDistributeClick
  end
  object btnRestore: TButton
    Left = 8
    Top = 384
    Width = 353
    Height = 25
    Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1080#1079' '#1072#1088#1093#1080#1074#1072
    TabOrder = 4
    OnClick = btnRestoreClick
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 328
    Width = 353
    Height = 17
    TabOrder = 5
  end
end
