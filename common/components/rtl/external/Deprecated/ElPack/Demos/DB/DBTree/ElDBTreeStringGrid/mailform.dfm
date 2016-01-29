object Form1: TForm1
  Left = 228
  Top = 233
  Width = 712
  Height = 572
  Caption = 'Breeders'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 704
    Height = 272
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object ElPanel3: TElPanel
      Left = 0
      Top = 0
      Width = 488
      Height = 272
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      DockOrientation = doNoOrient
      object DBGrid1: TDBGrid
        Left = 0
        Top = 21
        Width = 488
        Height = 251
        Align = alClient
        DataSource = DataSource1
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnCellClick = DBGrid1CellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'NAME'
            Width = 185
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SEX'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'HEIGHT'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'WEIGHT'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DOB'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MOMID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DADID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BREEDERID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AWARDS'
            Visible = True
          end>
      end
      object ElPanel4: TElPanel
        Left = 0
        Top = 0
        Width = 488
        Height = 21
        BackgroundType = bgtVertGradient
        GradientEndColor = clBtnFace
        GradientStartColor = clBtnHighlight
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        Caption = 'Source Table'
        DockOrientation = doNoOrient
        BevelKind = bkFlat
      end
    end
    object ElPanel5: TElPanel
      Left = 488
      Top = 0
      Width = 216
      Height = 272
      Align = alRight
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 1
      DockOrientation = doNoOrient
      object DBImage1: TDBImage
        Left = 0
        Top = 21
        Width = 216
        Height = 251
        Align = alClient
        DataField = 'Graphic'
        DataSource = DataSource2
        TabOrder = 0
      end
      object ElPanel6: TElPanel
        Left = 0
        Top = 0
        Width = 216
        Height = 21
        BackgroundType = bgtVertGradient
        GradientEndColor = clBtnFace
        GradientStartColor = clBtnHighlight
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        Caption = 'Picture'
        DockOrientation = doNoOrient
        BevelKind = bkFlat
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 321
    Width = 704
    Height = 206
    Align = alClient
    TabOrder = 1
    object ElDBTreeStringGrid1: TElDBTreeStringGrid
      Left = 1
      Top = 22
      Width = 702
      Height = 183
      Images = ImageList1
      DataSource = ElRelDataSource1
      MaxLevelCount = 10
      StylesDefs = <
        item
          DataFields.Strings = (
            'dob'
            'height'
            'weight'
            'awards')
          StyleCaption = 'RootLevel'
          ShowCaption = False
          HintField = 'awards'
          HintIsHTML = False
          Image = 'sexx'
          StImage = 'sexx'
          Color = clBlue
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
          ImagesFromBase = True
        end
        item
          DataFields.Strings = (
            'dob'
            'height'
            'weight'
            'awards')
          StyleCaption = 'Relation 0 level : Query1-Query1'
          ShowCaption = False
          HintField = 'awards'
          HintIsHTML = False
          Image = 'sexx'
          StImage = 'sexx'
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
          ImagesFromBase = True
        end>
      goRowSelect = True
      Align = alClient
      DockOrientation = doNoOrient
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      HeaderHeight = 20
      HeaderSections.Data = {
        F4FFFFFF0500000018CC7808003B0000FFFFFFFF000001010100000032000000
        00000000102700000001004108469C070000000001010000FFFFFFFF0000016D
        0000000000000000000100010000000080F95002A5F95002CFF95002F4F95002
        1AFA500240FA50026EFA500294FA5002B4FA5002D9FA5002FCFA50021EFB5002
        3DFB50025EFB500285FB5002ABFB5002D1FB5002050000004E616D6500010000
        0000000000000000000018CC7808003B0000FFFFFFFF00000101010000005000
        0000000000001027000000010041CC469C070100000001010000FFFFFFFF0000
        016D0000000000000000000100010000000080F95002A5F95002CFF95002F4F9
        50021AFA500240FA50026EFA500294FA5002B4FA5002D9FA5002FCFA50021EFB
        50023DFB50025EFB500285FB5002ABFB5002D1FB50020E00000044617465206F
        66206269727468000100000000000000000000000018CC7808003B0000FFFFFF
        FF00000101010000003500000000000000102700000001004170969D07020000
        0001010000FFFFFFFF0000016D0000000000000000000100010000000080F950
        02A5F95002CFF95002F4F950021AFA500240FA50026EFA500294FA5002B4FA50
        02D9FA5002FCFA50021EFB50023DFB50025EFB500285FB5002ABFB5002D1FB50
        0207000000486569676874000100000000000000000000000018CC7808003B00
        00FFFFFFFF00000101010000003800000000000000102700000001004134979D
        070300000001010000FFFFFFFF0000016D000000000000000000010001000000
        0080F95002A5F95002CFF95002F4F950021AFA500240FA50026EFA500294FA50
        02B4FA5002D9FA5002FCFA50021EFB50023DFB50025EFB500285FB5002ABFB50
        02D1FB500207000000576569676874000100000000000000000000000018CC78
        08003B0000FFFFFFFF0000010101000000390000000000000010270000000100
        41DC2BA70F0400000001010000FFFFFFFF0000016D0000000000000000000100
        010000000080F95002A5F95002CFF95002F4F950021AFA500240FA50026EFA50
        0294FA5002B4FA5002D9FA5002FCFA50021EFB50023DFB50025EFB500285FB50
        02ABFB5002D1FB50020700000041776172647300010000000000000000000000
        00}
      HeaderFlat = True
      HorzScrollBarStyles.ShowTrackHint = False
      HorzScrollBarStyles.Width = 13
      HorzScrollBarStyles.ButtonSize = 13
      ParentFont = False
      ParentShowHint = False
      ShowButtons = True
      ShowCheckboxes = True
      ShowHint = True
      ShowImages = True
      StoragePath = '\Tree'
      TabOrder = 0
      TabStop = True
      VertScrollBarStyles.ShowTrackHint = True
      VertScrollBarStyles.Width = 13
      VertScrollBarStyles.ButtonSize = 13
      OnAfterSelectionChange = ElDBTreeStringGrid1AfterSelectionChange
    end
    object ElPanel2: TElPanel
      Left = 1
      Top = 1
      Width = 702
      Height = 21
      BackgroundType = bgtVertGradient
      GradientEndColor = clBtnFace
      GradientStartColor = clBtnHighlight
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Caption = 'Family tree'
      DockOrientation = doNoOrient
      BevelKind = bkFlat
    end
  end
  object ElPanel1: TElPanel
    Left = 0
    Top = 0
    Width = 704
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    DockOrientation = doNoOrient
    object ElDBNavigator1: TElDBNavigator
      Left = 0
      Top = 0
      Width = 704
      Height = 24
      Align = alTop
      TabOrder = 0
      DockOrientation = doNoOrient
      AutoWrap = True
      UseLargeGlyphs = False
      UseImageList = True
      TransparentButtons = False
      ThinButtons = False
      ShowMoreMenu = False
      DataSource = DataSource1
      IsToolbar = False
      object ElDBNavButton1: TElDBNavButton
        Left = 0
        Top = 0
        Width = 24
        Height = 24
        Role = nbrFirst
        Wrap = False
        NumLargeGlyphs = 1
        NumGlyphs = 1
        Flat = True
        ShowText = False
        ImageIndex = 0
        UseImageList = True
        Enabled = False
        ButtonID = 0
      end
      object ElDBNavButton2: TElDBNavButton
        Left = 24
        Top = 0
        Width = 24
        Height = 24
        Role = nbrPrior
        Wrap = False
        NumLargeGlyphs = 1
        NumGlyphs = 1
        Flat = True
        ShowText = False
        ImageIndex = 1
        UseImageList = True
        Enabled = False
        ButtonID = 0
      end
      object ElDBNavButton3: TElDBNavButton
        Left = 48
        Top = 0
        Width = 24
        Height = 24
        Role = nbrNext
        Wrap = False
        NumLargeGlyphs = 1
        NumGlyphs = 1
        Flat = True
        ShowText = False
        ImageIndex = 2
        UseImageList = True
        Enabled = False
        ButtonID = 0
      end
      object ElDBNavButton4: TElDBNavButton
        Left = 72
        Top = 0
        Width = 24
        Height = 24
        Role = nbrLast
        Wrap = False
        NumLargeGlyphs = 1
        NumGlyphs = 1
        Flat = True
        ShowText = False
        ImageIndex = 3
        UseImageList = True
        Enabled = False
        ButtonID = 0
      end
    end
  end
  object ElStatusBar1: TElStatusBar
    Left = 0
    Top = 527
    Width = 704
    Height = 18
    Panels = <>
    SimpleTextIsHTML = False
    ResizablePanels = False
    Bevel = epbNone
    Align = alBottom
    Color = clBtnFace
    ParentColor = False
    DockOrientation = doNoOrient
    DoubleBuffered = False
  end
  object ElSplitter1: TElSplitter
    Left = 0
    Top = 313
    Width = 704
    Height = 8
    Cursor = crVSplit
    ControlTopLeft = Panel1
    ControlBottomRight = Panel3
    AutoHide = False
    ShowSnapButton = True
    Align = alTop
  end
  object DataSource1: TDataSource
    DataSet = breeders
    Left = 64
    Top = 8
  end
  object breeders: TTable
    AfterPost = breedersAfterPost
    AfterDelete = breedersAfterDelete
    OnCalcFields = breedersCalcFields
    DatabaseName = '..\..\data'
    TableName = 'BREEDERS.DBF'
    Left = 12
    Top = 132
    object breederssexx: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'sexx'
      Calculated = True
    end
    object breedersBreed: TStringField
      FieldKind = fkLookup
      FieldName = 'Breed'
      LookupDataSet = breed
      LookupKeyFields = 'ID'
      LookupResultField = 'Breed'
      KeyFields = 'ID'
      Lookup = True
    end
    object breedersBREEDERID: TFloatField
      FieldName = 'BREEDERID'
    end
    object breedersNAME: TStringField
      FieldName = 'NAME'
      Size = 34
    end
    object breedersDADID: TFloatField
      FieldName = 'DADID'
    end
    object breedersMOMID: TFloatField
      FieldName = 'MOMID'
    end
    object breedersSEX: TStringField
      FieldName = 'SEX'
      Size = 9
    end
    object breedersDOB: TDateField
      FieldName = 'DOB'
    end
    object breedersHEIGHT: TFloatField
      FieldName = 'HEIGHT'
    end
    object breedersWEIGHT: TFloatField
      FieldName = 'WEIGHT'
    end
    object breedersCHAMP: TFloatField
      FieldName = 'CHAMP'
    end
    object breedersAWARDS: TStringField
      FieldName = 'AWARDS'
      Size = 35
    end
    object breedersID: TSmallintField
      FieldName = 'ID'
    end
  end
  object ElRelDataSource1: TElRelDataSource
    DataSet = Query1
    Filtered = True
    Filter = 'ID=0'
    OwnFilter = False
    Relations = <
      item
        MasterDataSet = Query1
        MasterField = 'BreederID'
        DetailDataSet = Query1
        DetailField = 'ID'
        DetailDisplayField = 'Name'
      end>
    RootDataField = 'Name'
    Left = 96
    Top = 85
  end
  object Query1: TQuery
    OnCalcFields = Query1CalcFields
    DatabaseName = '..\..\data'
    SQL.Strings = (
      
        'select distinct name, breederID , momID as Id, sex, dob, ID as b' +
        'rId, awards,height, weight from breeders.dbf'
      
        'union all select distinct name, breederID , dadID as Id, sex, do' +
        'b, ID as brId, awards,height, weight from breeders.dbf where not' +
        ' (dadID is null)'
      '')
    Left = 16
    Top = 89
    object Query1breederID: TFloatField
      FieldName = 'breederID'
    end
    object Query1Id: TFloatField
      FieldName = 'Id'
    end
    object Query1sex: TStringField
      FieldName = 'sex'
      Size = 9
    end
    object Query1dob: TDateField
      FieldName = 'dob'
    end
    object Query1brId: TSmallintField
      FieldName = 'brId'
    end
    object Query1name: TStringField
      FieldName = 'name'
      Size = 34
    end
    object Query1sexx: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'sexx'
      Calculated = True
    end
    object Query1awards: TStringField
      FieldName = 'awards'
      Size = 35
    end
    object Query1height: TFloatField
      FieldName = 'height'
    end
    object Query1weight: TFloatField
      FieldName = 'weight'
    end
  end
  object ImageList1: TImageList
    AllocBy = 2
    Left = 440
    Top = 146
  end
  object breed: TTable
    DatabaseName = '..\..\data'
    IndexFieldNames = 'ID'
    TableName = 'breed.db'
    Left = 16
    Top = 48
    object breedID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object breedBreed: TStringField
      FieldName = 'Breed'
    end
    object breedNotes: TMemoField
      FieldName = 'Notes'
      BlobType = ftMemo
      Size = 100
    end
    object breedGraphic: TGraphicField
      FieldName = 'Graphic'
      BlobType = ftGraphic
    end
  end
  object DataSource2: TDataSource
    DataSet = breed_detale
    Left = 56
    Top = 48
  end
  object breed_detale: TTable
    DatabaseName = '..\..\data'
    IndexFieldNames = 'ID'
    MasterFields = 'brId'
    MasterSource = DataSource3
    TableName = 'breed.db'
    Left = 96
    Top = 48
  end
  object DataSource3: TDataSource
    DataSet = Query1
    Left = 56
    Top = 88
  end
end
