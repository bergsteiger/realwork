inherited ddDocumentVersionForm: TddDocumentVersionForm
  Left = 468
  Top = 327
  Width = 866
  Height = 576
  Font.Height = -11
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 206
    Top = 0
    Height = 491
  end
  inherited ButtonPanel: TPanel
    Top = 491
    Width = 850
    Height = 47
    TabOrder = 2
    inherited OK: TBitBtn
      Left = 580
      Top = 11
      Caption = #1047#1072#1084#1077#1085#1080#1090#1100
      Enabled = False
    end
    inherited Cancel: TBitBtn
      Left = 668
      Top = 11
    end
    inherited Help: TBitBtn
      Left = 756
      Top = 11
    end
  end
  inherited Panel1: TPanel
    Left = 209
    Width = 641
    Height = 491
    TabOrder = 1
    object evEditor1: TevEditor
      Left = 6
      Top = 1
      Width = 634
      Height = 489
      Align = alClient
      VSubPanel = evSubPanel1
      ReadOnly = True
      TextSource = evTextSource1
      Color = clWhite
      TabOrder = 0
      TabStop = True
    end
    object evSubPanel1: TevSubPanel
      Left = 1
      Top = 1
      Height = 489
      Align = alLeft
      ParentFont = True
      TabOrder = 1
    end
  end
  object otlVersionList: TvtOutliner
    Left = 0
    Top = 0
    Width = 206
    Height = 491
    AutoRowHeight = True
    BorderStyle = bsSingle
    Columns = 255
    IntegralHeight = False
    MultiSelect = False
    MultiStrokeItem = False
    OpenChipColor = clBlack
    ProtectColor.BackColor = clRed
    ProtectColor.TextColor = clWhite
    RowHeight = 16
    ScrollStyle = ssVertical
    SelectColor.BackColor = clHighlight
    SelectColor.TextColor = clHighlightText
    SelectNonFocusColor.BackColor = clBtnFace
    SelectNonFocusColor.TextColor = clBtnText
    SelfDrawNodes = False
    ShowHeader = False
    UseTabStops = False
    PickedList = False
    ReadOnly = False
    ShowRoot = False
    OnCurrentChanged = otlVersionListCurrentChanged
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = True
    TabOrder = 0
    TabStop = True
    VJustify = vt_vjCenter
    IsShowLines = True
    ShowExpandable = True
    ShowOpenChip = True
    ViewOptions = [voShowIcons, voShowExpandable, voShowLines, voShowOpenChip]
    EditOptions = [eoItemExpand]
  end
  object evTextSource1: TevTextSource
    ReadOnly = True
    Left = 436
    Top = 136
  end
end
