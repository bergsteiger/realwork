object Form1: TForm1
  Left = 399
  Top = 362
  Width = 335
  Height = 397
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 21
    Width = 327
    Height = 3
    Align = alTop
    Shape = bsSpacer
  end
  object ElStatusBar1: TElStatusBar
    Left = 0
    Top = 351
    Width = 327
    Height = 19
    Panels = <>
    SimpleTextIsHTML = False
    ResizablePanels = False
    Bevel = epbLowered
    Align = alBottom
    Color = clBtnFace
    ParentColor = False
    DockOrientation = doNoOrient
    DoubleBuffered = False
  end
  object ElPanel1: TElPanel
    Left = 0
    Top = 0
    Width = 327
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    Caption = 'TElDBTree Self-reference example'
    DockOrientation = doNoOrient
    BevelKind = bkFlat
  end
  object Filer: TElDBTreeStringGrid
    Left = 0
    Top = 24
    Width = 327
    Height = 327
    DataSource = SelfReference
    MaxLevelCount = 10
    StylesDefs = <
      item
        DataFields.Strings = (
          'IMAGEINDEX'
          '')
        StyleCaption = 'RootLevel'
        ShowCaption = False
        HintIsHTML = False
        Color = clBlack
        BkColor = clBlack
        RowBkColor = clBlack
        ParentColors = True
        UseBkColor = False
        ParentFontStyle = True
        Italic = False
        Underlined = False
        Bold = False
        Strikeout = False
        ForceButtons = False
        CheckBoxEnabled = False
        ShowCheckBox = False
        Hidden = False
        IsHTML = False
        Multiline = False
        DrawHLine = True
        AllowEdit = True
        SuppressButtons = False
        SuppressLines = False
        StrikedOutLine = False
        StrikedLineColor = clBlack
        OwnerHeight = True
        Height = 0
        IndentAdjust = 0
        BorderStyle = ibsNone
        ImageIndex = -1
        StateImageIndex = -1
        ImageIndex2 = -1
        StateImageIndex2 = -1
        ImagesFromBase = False
      end
      item
        DataFields.Strings = (
          'IMAGEINDEX'
          '')
        StyleCaption = 'Relation 0 level : TableTree-TableTree'
        ShowCaption = False
        HintIsHTML = False
        Color = clBlack
        BkColor = clBlack
        RowBkColor = clBlack
        ParentColors = True
        UseBkColor = False
        ParentFontStyle = True
        Italic = False
        Underlined = False
        Bold = False
        Strikeout = False
        ForceButtons = False
        CheckBoxEnabled = False
        ShowCheckBox = False
        Hidden = False
        IsHTML = False
        Multiline = False
        DrawHLine = True
        AllowEdit = True
        SuppressButtons = False
        SuppressLines = False
        StrikedOutLine = False
        StrikedLineColor = clBlack
        OwnerHeight = True
        Height = 0
        IndentAdjust = 0
        BorderStyle = ibsNone
        ImageIndex = -1
        StateImageIndex = -1
        ImageIndex2 = -1
        StateImageIndex2 = -1
        ImagesFromBase = False
      end>
    ColCount = 2
    goRowSelect = True
    Align = alClient
    DockOrientation = doNoOrient
    DragAllowed = True
    ExpandOnDragOver = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HeaderHeight = 20
    HeaderSections.Data = {
      F4FFFFFF02000000ACB7320600000000FFFFFFFF000001010100000008010000
      000000001027000000010000D8538C0A0000000001010000FFFFFFFF00000100
      0000000000000000000100000000000000000000010000004000000000000000
      102700000001000000000000000000001470920A847032060000000000000000
      FFFFFFFF00000000000000000000000090000000010000000001000000000000
      000000000000ACB7320600000000FFFFFFFF0000010101000000590000000000
      0000102700000001000068548C0A0100000001010000FFFFFFFF000001000000
      0000000000000001000100000000000000000100000040000000000000001027
      00000001000000000000000000001470920A847032060000000000000000FFFF
      FFFF000000000000000000000000900000000B000000494D414745494E444558
      0001000000000000000000000000}
    HorzScrollBarStyles.ShowTrackHint = False
    HorzScrollBarStyles.Width = 0
    HorzScrollBarStyles.ButtonSize = 16
    HorzScrollBarStyles.UseSystemMetrics = False
    ShowButtons = True
    ShowCheckboxes = True
    StoragePath = '\Tree'
    TabOrder = 2
    TabStop = True
    VertScrollBarStyles.ShowTrackHint = True
    VertScrollBarStyles.Width = 16
    VertScrollBarStyles.ButtonSize = 16
    OnResize = FilerResize
    OnDragDrop = FilerDragDrop
    OnDragOver = FilerDragOver
    OnStartDrag = FilerStartDrag
  end
  object SelfReference: TElRelDataSource
    DataSet = TableTree
    Filtered = True
    Filter = 'ParentID = 0'
    OwnFilter = True
    Relations = <
      item
        ActiveOnLevel = 1
        MasterDataSet = TableTree
        MasterField = 'DIRID'
        DetailDataSet = TableTree
        DetailField = 'PARENTID'
        DetailDisplayField = 'DIRNAME'
      end>
    RootDataField = 'DIRNAME'
    Left = 200
    Top = 80
  end
  object TableTree: TTable
    Active = True
    DatabaseName = '..\data'
    Filtered = True
    TableName = 'tree.dbf'
    Left = 244
    Top = 80
    object TableTreeDIRNAME: TStringField
      FieldName = 'DIRNAME'
      Size = 17
    end
    object TableTreeDIRID: TFloatField
      FieldName = 'DIRID'
    end
    object TableTreePARENTID: TFloatField
      FieldName = 'PARENTID'
    end
    object TableTreeIMAGEINDEX: TFloatField
      FieldName = 'IMAGEINDEX'
    end
    object TableTreeSELECTEDIN: TFloatField
      FieldName = 'SELECTEDIN'
    end
    object TableTreeSTATEINDEX: TFloatField
      FieldName = 'STATEINDEX'
    end
  end
end
