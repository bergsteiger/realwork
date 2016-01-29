object Example: TExample
  Left = 257
  Top = 252
  Width = 676
  Height = 549
  Caption = 'TElDBTree Examples'
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
  object ElDBLabel1: TElDBLabel
    Left = 112
    Top = 12
    Width = 56
    Height = 13
    Cursor = crDefault
    Caption = 'ElDBLabel1'
    IsHTML = False
    WordWrap = False
    LinkStyle = [fsUnderline]
  end
  object ElPageControl1: TElPageControl
    Left = 0
    Top = 0
    Width = 668
    Height = 503
    Style = etsFlatTabs
    TabIndex = 0
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clBlue
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ActivePage = ElTabSheet1
    ActiveTabFont.Charset = DEFAULT_CHARSET
    ActiveTabFont.Color = clWindowText
    ActiveTabFont.Height = -11
    ActiveTabFont.Name = 'MS Sans Serif'
    ActiveTabFont.Style = []
    Align = alClient
    ParentColor = False
    TabOrder = 0
    DockOrientation = doNoOrient
    object ElTabSheet1: TElTabSheet
      PageControl = ElPageControl1
      Caption = 'Master-Detail'
      object Panel7: TPanel
        Left = 0
        Top = 332
        Width = 664
        Height = 148
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object ElDBTree3: TElDBTree
          Left = 0
          Top = 21
          Width = 664
          Height = 127
          DataSource = MasterDetail
          MaxLevelCount = 10
          StylesDefs = <
            item
              StyleCaption = 'RootLevel'
              ShowCaption = False
              HintField = 'City'
              HintIsHTML = False
              Color = clGreen
              BkColor = clBlack
              RowBkColor = clWhite
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
              IsHTML = True
              Multiline = False
              DrawHLine = True
              AllowEdit = True
              SuppressButtons = False
              SuppressLines = False
              StrikedOutLine = False
              StrikedLineColor = clRed
              OwnerHeight = True
              Height = 0
              IndentAdjust = 0
              BorderStyle = ibsNone
              ImageIndex = -1
              StateImageIndex = -1
              ImageIndex2 = -1
              StateImageIndex2 = -1
              ImagesFromBase = False
              Pattern = 
                '<html><a href="Company"></a> <b> last invoice date </b> <a href=' +
                '"LastInvoiceDate"></a> '
              UsePattern = True
            end
            item
              StyleCaption = 'Relation 0 level : Customer-Orders'
              ShowCaption = False
              HintIsHTML = False
              Color = clBlack
              BkColor = clBlack
              RowBkColor = clGray
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
              IsHTML = True
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
              Pattern = 
                '<html><a href="OrderNo"></a> payment method <a href="PaymentMeth' +
                'od"></a> items total <a href="ItemsTotal"></a> '
              UsePattern = True
            end
            item
              StyleCaption = 'Relation 1 level : Orders-Item'
              ShowCaption = False
              HintIsHTML = False
              Color = clOlive
              BkColor = clBlack
              RowBkColor = clWhite
              ParentColors = False
              UseBkColor = False
              ParentFontStyle = False
              Italic = False
              Underlined = True
              Bold = True
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
              StrikedLineColor = clSilver
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
          Align = alClient
          DockOrientation = doNoOrient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          HorzScrollBarStyles.ShowTrackHint = False
          HorzScrollBarStyles.Width = 13
          HorzScrollBarStyles.ButtonSize = 13
          LineHeight = 17
          ShowCheckboxes = True
          ShowLeafButton = False
          StoragePath = '\Tree'
          TabOrder = 0
          TabStop = True
          VertScrollBarStyles.ShowTrackHint = True
          VertScrollBarStyles.Width = 13
          VertScrollBarStyles.ButtonSize = 13
        end
        object ElPanel7: TElPanel
          Left = 0
          Top = 0
          Width = 664
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
          Caption = 'Result tree (master/detail)'
          DockOrientation = doNoOrient
          BevelKind = bkFlat
        end
      end
      object Panel6: TElPanel
        Left = 0
        Top = 41
        Width = 664
        Height = 283
        Align = alTop
        BevelWidth = 0
        TabOrder = 0
        DockOrientation = doNoOrient
        DoubleBuffered = True
        object Panel9: TElPanel
          Left = 0
          Top = 0
          Width = 664
          Height = 136
          Align = alTop
          BevelWidth = 0
          TabOrder = 0
          DockOrientation = doNoOrient
          DoubleBuffered = True
          object ElSplitter4: TElSplitter
            Left = 345
            Top = 0
            Width = 8
            Height = 136
            Cursor = crHSplit
            ControlTopLeft = ElPanel16
            ControlBottomRight = ElPanel14
            AutoHide = False
            ShowSnapButton = True
            Align = alLeft
            BevelOuter = bvNone
          end
          object ElPanel14: TElPanel
            Left = 353
            Top = 0
            Width = 311
            Height = 136
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            DockOrientation = doNoOrient
            object ElPanel15: TElPanel
              Left = 0
              Top = 0
              Width = 311
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
              TabOrder = 0
              Caption = 'Table "Orders"'
              DockOrientation = doNoOrient
              BevelKind = bkFlat
            end
            object DBGrid5: TDBGrid
              Left = 0
              Top = 21
              Width = 311
              Height = 115
              Align = alClient
              DataSource = DataSource4
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              TabOrder = 1
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              OnEnter = DBGrid7Enter
            end
          end
          object ElPanel16: TElPanel
            Left = 0
            Top = 0
            Width = 345
            Height = 136
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 2
            DockOrientation = doNoOrient
            object ElPanel17: TElPanel
              Left = 0
              Top = 0
              Width = 345
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
              TabOrder = 0
              Caption = 'Table "Item"'
              DockOrientation = doNoOrient
              BevelKind = bkFlat
            end
            object DBGrid3: TDBGrid
              Left = 0
              Top = 21
              Width = 345
              Height = 115
              Align = alClient
              DataSource = DataSource6
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
              TabOrder = 1
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              OnEnter = DBGrid7Enter
            end
          end
        end
        object ElPanel12: TElPanel
          Left = 0
          Top = 144
          Width = 664
          Height = 139
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          DockOrientation = doNoOrient
          object ElPanel13: TElPanel
            Left = 0
            Top = 0
            Width = 664
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
            TabOrder = 0
            Caption = 'Table "Customer"'
            DockOrientation = doNoOrient
            BevelKind = bkFlat
          end
          object DBGrid7: TDBGrid
            Left = 0
            Top = 21
            Width = 664
            Height = 118
            Align = alClient
            DataSource = DataSource5
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnEnter = DBGrid7Enter
          end
        end
        object ElSplitter5: TElSplitter
          Left = 0
          Top = 136
          Width = 664
          Height = 8
          Cursor = crVSplit
          ControlTopLeft = Panel9
          ControlBottomRight = ElPanel12
          AutoHide = False
          ShowSnapButton = True
          Align = alTop
          BevelOuter = bvNone
        end
      end
      object ElSplitter1: TElSplitter
        Left = 0
        Top = 324
        Width = 664
        Height = 8
        Cursor = crVSplit
        ControlTopLeft = Panel6
        ControlBottomRight = Panel7
        AutoHide = False
        ShowSnapButton = True
        Align = alTop
        BevelOuter = bvNone
      end
      object Panel8: TElPanel
        Left = 0
        Top = 0
        Width = 664
        Height = 41
        Align = alTop
        BevelWidth = 0
        Locked = True
        TabOrder = 3
        DockOrientation = doNoOrient
        object ElDBNavigator2: TElDBNavigator
          Left = 5
          Top = 6
          Width = 565
          Height = 24
          Align = alNone
          AutoSize = False
          TabOrder = 0
          DockOrientation = doNoOrient
          AutoWrap = False
          UseLargeGlyphs = False
          UseImageList = True
          TransparentButtons = False
          ThinButtons = False
          ShowMoreMenu = False
          IsToolbar = False
          object ElDBNavButton2: TElDBNavButton
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
          object ElDBNavButton3: TElDBNavButton
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
          object ElDBNavButton4: TElDBNavButton
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
          object ElDBNavButton5: TElDBNavButton
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
          object ElDBNavButton6: TElDBNavButton
            Left = 96
            Top = 0
            Width = 24
            Height = 24
            Role = nbrInsert
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 4
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton7: TElDBNavButton
            Left = 120
            Top = 0
            Width = 24
            Height = 24
            Role = nbrDelete
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 5
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton8: TElDBNavButton
            Left = 144
            Top = 0
            Width = 24
            Height = 24
            Role = nbrEdit
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 6
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton9: TElDBNavButton
            Left = 168
            Top = 0
            Width = 24
            Height = 24
            Role = nbrPost
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 7
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton10: TElDBNavButton
            Left = 192
            Top = 0
            Width = 24
            Height = 24
            Role = nbrCancel
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 8
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton11: TElDBNavButton
            Left = 216
            Top = 0
            Width = 24
            Height = 24
            Role = nbrRefresh
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 9
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton21: TElDBNavButton
            Left = 240
            Top = 0
            Width = 24
            Height = 24
            Role = nbrSearch
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 10
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton22: TElDBNavButton
            Left = 264
            Top = 0
            Width = 24
            Height = 24
            Role = nbrSetFilter
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 11
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton23: TElDBNavButton
            Left = 288
            Top = 0
            Width = 24
            Height = 24
            Role = nbrRemoveFilter
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 12
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
        end
      end
    end
    object ElTabSheet2: TElTabSheet
      PageControl = ElPageControl1
      Caption = 'SelfReference'
      Visible = False
      object ElSplitter2: TElSplitter
        Left = 345
        Top = 41
        Width = 8
        Height = 439
        Cursor = crHSplit
        AutoSnap = True
        ControlTopLeft = ElPanel10
        ControlBottomRight = ElPanel8
        AutoHide = True
        ShowSnapButton = True
        Align = alLeft
        BevelOuter = bvNone
      end
      object ElPanel2: TElPanel
        Left = 0
        Top = 0
        Width = 664
        Height = 41
        Align = alTop
        BevelWidth = 0
        Locked = True
        TabOrder = 1
        DockOrientation = doNoOrient
        object ElDBNavigator1: TElDBNavigator
          Left = 5
          Top = 6
          Width = 565
          Height = 24
          Align = alNone
          AutoSize = False
          TabOrder = 0
          DockOrientation = doNoOrient
          AutoWrap = False
          UseLargeGlyphs = False
          UseImageList = True
          TransparentButtons = False
          ThinButtons = False
          ShowMoreMenu = False
          DataSource = DataSource3
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
          object ElDBNavButton12: TElDBNavButton
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
          object ElDBNavButton13: TElDBNavButton
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
          object ElDBNavButton14: TElDBNavButton
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
          object ElDBNavButton15: TElDBNavButton
            Left = 96
            Top = 0
            Width = 24
            Height = 24
            Role = nbrInsert
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 4
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton16: TElDBNavButton
            Left = 120
            Top = 0
            Width = 24
            Height = 24
            Role = nbrDelete
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 5
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton17: TElDBNavButton
            Left = 144
            Top = 0
            Width = 24
            Height = 24
            Role = nbrEdit
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 6
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton18: TElDBNavButton
            Left = 168
            Top = 0
            Width = 24
            Height = 24
            Role = nbrPost
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 7
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton19: TElDBNavButton
            Left = 192
            Top = 0
            Width = 24
            Height = 24
            Role = nbrCancel
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 8
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton20: TElDBNavButton
            Left = 216
            Top = 0
            Width = 24
            Height = 24
            Role = nbrRefresh
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 9
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton24: TElDBNavButton
            Left = 240
            Top = 0
            Width = 24
            Height = 24
            Role = nbrSearch
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 10
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton25: TElDBNavButton
            Left = 264
            Top = 0
            Width = 24
            Height = 24
            Role = nbrSetFilter
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 11
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton26: TElDBNavButton
            Left = 288
            Top = 0
            Width = 24
            Height = 24
            Role = nbrRemoveFilter
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 12
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
        end
      end
      object ElPanel8: TElPanel
        Left = 353
        Top = 41
        Width = 311
        Height = 439
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 2
        DockOrientation = doNoOrient
        object ElPanel9: TElPanel
          Left = 0
          Top = 0
          Width = 311
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
          TabOrder = 0
          Caption = 'Result tree (Self-Reference)'
          DockOrientation = doNoOrient
          BevelKind = bkFlat
        end
        object ElDBTree2: TElDBTree
          Left = 0
          Top = 21
          Width = 311
          Height = 418
          Images = ImageList1
          DataSource = SelfReference
          MaxLevelCount = 10
          StylesDefs = <
            item
              StyleCaption = 'RootLevel'
              ShowCaption = False
              HintIsHTML = False
              Image = 'IMAGEINDEX'
              StImage = 'STATEINDEX'
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
            end
            item
              StyleCaption = 'Relation 0 level : TableTree-TableTree'
              ShowCaption = False
              HintIsHTML = False
              Image = 'IMAGEINDEX'
              StImage = 'STATEINDEX'
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
          Align = alClient
          DockOrientation = doNoOrient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          HorzScrollBarStyles.ShowTrackHint = False
          HorzScrollBarStyles.Width = 13
          HorzScrollBarStyles.ButtonSize = 13
          LineHeight = 17
          ParentFont = False
          ShowCheckboxes = True
          ShowLeafButton = False
          StoragePath = '\Tree'
          TabOrder = 1
          TabStop = True
          VertScrollBarStyles.ShowTrackHint = True
          VertScrollBarStyles.Width = 13
          VertScrollBarStyles.ButtonSize = 13
        end
      end
      object ElPanel10: TElPanel
        Left = 0
        Top = 41
        Width = 345
        Height = 439
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 3
        DockOrientation = doNoOrient
        object ElPanel11: TElPanel
          Left = 0
          Top = 0
          Width = 345
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
          TabOrder = 0
          Caption = 'Source Table'
          DockOrientation = doNoOrient
          BevelKind = bkFlat
        end
        object DBGrid4: TDBGrid
          Left = 0
          Top = 21
          Width = 345
          Height = 418
          Align = alClient
          DataSource = DataSource3
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
    end
    object ElTabSheet3: TElTabSheet
      PageControl = ElPageControl1
      Caption = 'Query'
      Visible = False
      object Panel1: TPanel
        Left = 0
        Top = 41
        Width = 345
        Height = 439
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object DBGrid2: TDBGrid
          Left = 0
          Top = 21
          Width = 345
          Height = 130
          Align = alTop
          DataSource = DataSource1
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnEnter = DBGrid1Enter
        end
        object DBGrid1: TDBGrid
          Left = 0
          Top = 193
          Width = 345
          Height = 246
          Align = alClient
          DataSource = DataSource2
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnEnter = DBGrid1Enter
        end
        object ElPanel1: TElPanel
          Left = 0
          Top = 0
          Width = 345
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
          TabOrder = 2
          Caption = 'Root level : "Select distinct category from biolife"'
          DockOrientation = doNoOrient
          BevelKind = bkFlat
        end
        object ElPanel3: TElPanel
          Left = 0
          Top = 151
          Width = 345
          Height = 42
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
          TabOrder = 3
          DockOrientation = doNoOrient
          BevelKind = bkFlat
          object Label2: TLabel
            Left = 0
            Top = 6
            Width = 341
            Height = 32
            Align = alBottom
            Alignment = taCenter
            AutoSize = False
            Caption = 
              'Detail level : "Select * from biolife where Category = :Category' +
              '"'
            Transparent = True
            WordWrap = True
          end
        end
      end
      object ElSplitter3: TElSplitter
        Left = 345
        Top = 41
        Width = 8
        Height = 439
        Cursor = crHSplit
        AutoSnap = True
        ControlTopLeft = Panel1
        ControlBottomRight = ElPanel5
        AutoHide = False
        ShowSnapButton = True
        Align = alLeft
        BevelOuter = bvNone
      end
      object ElPanel4: TElPanel
        Left = 0
        Top = 0
        Width = 664
        Height = 41
        Align = alTop
        BevelWidth = 0
        Locked = True
        TabOrder = 2
        DockOrientation = doNoOrient
        object ElDBNavigator3: TElDBNavigator
          Left = 5
          Top = 6
          Width = 565
          Height = 24
          Align = alNone
          AutoSize = False
          TabOrder = 0
          DockOrientation = doNoOrient
          AutoWrap = False
          UseLargeGlyphs = False
          UseImageList = True
          TransparentButtons = False
          ThinButtons = False
          ShowMoreMenu = False
          DataSource = DataSource3
          IsToolbar = False
          object ElDBNavButton27: TElDBNavButton
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
          object ElDBNavButton28: TElDBNavButton
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
          object ElDBNavButton29: TElDBNavButton
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
          object ElDBNavButton30: TElDBNavButton
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
          object ElDBNavButton31: TElDBNavButton
            Left = 96
            Top = 0
            Width = 24
            Height = 24
            Role = nbrInsert
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 4
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton32: TElDBNavButton
            Left = 120
            Top = 0
            Width = 24
            Height = 24
            Role = nbrDelete
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 5
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton33: TElDBNavButton
            Left = 144
            Top = 0
            Width = 24
            Height = 24
            Role = nbrEdit
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 6
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton34: TElDBNavButton
            Left = 168
            Top = 0
            Width = 24
            Height = 24
            Role = nbrPost
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 7
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton35: TElDBNavButton
            Left = 192
            Top = 0
            Width = 24
            Height = 24
            Role = nbrCancel
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 8
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton36: TElDBNavButton
            Left = 216
            Top = 0
            Width = 24
            Height = 24
            Role = nbrRefresh
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 9
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton37: TElDBNavButton
            Left = 240
            Top = 0
            Width = 24
            Height = 24
            Role = nbrSearch
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 10
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton38: TElDBNavButton
            Left = 264
            Top = 0
            Width = 24
            Height = 24
            Role = nbrSetFilter
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 11
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
          object ElDBNavButton39: TElDBNavButton
            Left = 288
            Top = 0
            Width = 24
            Height = 24
            Role = nbrRemoveFilter
            Wrap = False
            NumLargeGlyphs = 1
            NumGlyphs = 1
            Flat = True
            ShowText = False
            ImageIndex = 12
            UseImageList = True
            Enabled = False
            ButtonID = 0
          end
        end
      end
      object ElPanel5: TElPanel
        Left = 353
        Top = 41
        Width = 311
        Height = 439
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 3
        DockOrientation = doNoOrient
        object ElPanel6: TElPanel
          Left = 0
          Top = 0
          Width = 311
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
          TabOrder = 0
          Caption = 'Result Tree (see hint on pictures)'
          DockOrientation = doNoOrient
          BevelKind = bkFlat
        end
        object ElDBTree1: TElDBTree
          Left = 0
          Top = 21
          Width = 311
          Height = 418
          DataSource = ElRelDataSource2
          MaxLevelCount = 10
          StylesDefs = <
            item
              StyleCaption = 'RootLevel'
              Caption = 'Rootlevel'
              ShowCaption = False
              Hint = 
                '<html><font color=#FF0000>Simple</font><br> <i>HTML</i> <b>Hint<' +
                '/b>'
              HintIsHTML = True
              Color = clBlue
              BkColor = clWhite
              RowBkColor = clFuchsia
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
              IsHTML = True
              Multiline = False
              DrawHLine = False
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
              Pattern = '<html><a href="category"></a> '
              UsePattern = True
            end
            item
              StyleCaption = 'Relation 0 level : BioQuery-DetailQuery'
              Caption = 'Relation 0 level : BioQuery-DetailQuery'
              ShowCaption = False
              HintField = 'Notes'
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
              DrawHLine = False
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
          OnActivateLevel = ElDBTree1ActivateLevel
          Align = alClient
          DockOrientation = doNoOrient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          HorzScrollBarStyles.ShowTrackHint = False
          HorzScrollBarStyles.Width = 13
          HorzScrollBarStyles.ButtonSize = 13
          LineHeight = 17
          LinesColor = clBtnShadow
          ParentFont = False
          ShowCheckboxes = True
          ShowLeafButton = False
          StoragePath = '\Tree'
          TabOrder = 1
          TabStop = True
          VertScrollBarStyles.ShowTrackHint = True
          VertScrollBarStyles.Width = 13
          VertScrollBarStyles.ButtonSize = 13
          UseSystemHintColors = True
          TextColor = clBtnText
          OnShowLineHint = ElDBTree1ShowLineHint
        end
      end
    end
  end
  object ElStatusBar1: TElStatusBar
    Left = 0
    Top = 503
    Width = 668
    Height = 19
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
  object BioQuery: TQuery
    Active = True
    DatabaseName = 'DBDEMOS'
    SQL.Strings = (
      'Select distinct category from biolife')
    Left = 636
    Top = 40
    object BioQuerycategory: TStringField
      FieldName = 'category'
      Origin = 'DBDEMOS."biolife.DB".Category'
      Size = 15
    end
  end
  object ElRelDataSource2: TElRelDataSource
    DataSet = BioQuery
    Filtered = False
    OwnFilter = False
    Relations = <
      item
        DenyLookSetPosition = True
        MasterDataSet = BioQuery
        MasterField = 'category'
        DetailDataSet = DetailQuery
        DetailField = 'Category'
        DetailDisplayField = 'Graphic'
      end>
    RootDataField = 'category'
    Left = 604
    Top = 52
  end
  object DetailQuery: TQuery
    DatabaseName = 'DBDEMOS'
    ParamCheck = False
    SQL.Strings = (
      'Select * from biolife where Category = :Category')
    Left = 638
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Category'
        ParamType = ptUnknown
      end>
    object DetailQuerySpeciesNo: TFloatField
      FieldName = 'Species No'
      Origin = 'DBDEMOS."biolife.DB".Species No'
    end
    object DetailQueryCategory: TStringField
      FieldName = 'Category'
      Origin = 'DBDEMOS."biolife.DB".Category'
      Size = 15
    end
    object DetailQueryCommon_Name: TStringField
      FieldName = 'Common_Name'
      Origin = 'DBDEMOS."biolife.DB".Common_Name'
      Size = 30
    end
    object DetailQuerySpeciesName: TStringField
      FieldName = 'Species Name'
      Origin = 'DBDEMOS."biolife.DB".Species Name'
      Size = 40
    end
    object DetailQueryLengthcm: TFloatField
      FieldName = 'Length (cm)'
      Origin = 'DBDEMOS."biolife.DB".Length (cm)'
    end
    object DetailQueryLength_In: TFloatField
      FieldName = 'Length_In'
      Origin = 'DBDEMOS."biolife.DB".Length_In'
    end
    object DetailQueryNotes: TMemoField
      FieldName = 'Notes'
      Origin = 'DBDEMOS."biolife.DB".Notes'
      BlobType = ftMemo
      Size = 50
    end
    object DetailQueryGraphic: TGraphicField
      FieldName = 'Graphic'
      Origin = 'DBDEMOS."biolife.DB".Graphic'
      BlobType = ftGraphic
    end
  end
  object DataSource1: TDataSource
    DataSet = BioQuery
    Left = 672
    Top = 44
  end
  object DataSource2: TDataSource
    DataSet = DetailQuery
    Left = 672
    Top = 80
  end
  object TableTree: TTable
    DatabaseName = '..\..\data'
    Filtered = True
    TableName = 'tree.dbf'
    Left = 520
    Top = 316
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
  object ImageList1: TImageList
    AllocBy = 3
    Left = 552
    Top = 356
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000B5848400B584
      8400B5848400B5848400B5848400B5848400B5848400B5848400B5848400B584
      8400B5848400B5848400B5848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6A59C00FFEF
      D600F7E7C600F7DEBD00F7DEB500F7D6AD00F7D6A500EFCE9C00EFCE9400EFCE
      9400EFCE9400F7D69C00B5848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029ADD60031B5DE0021AD
      D600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6A59C00FFEF
      D600F7E7CE00F7DEC600F7DEBD00F7D6B500F7D6A500EFCE9C00EFCE9C00EFCE
      9400EFCE9400EFCE9C00B5848400000000000000000029ADD60029ADD60029AD
      D60029ADD60029ADD60029ADD60029ADD60029ADD60029ADD60029ADD60029AD
      D60029ADD60029ADD60000000000000000000000000029ADD6009CDEEF0084EF
      FF004AC6E70021ADD60018A5C60018A5C60018A5C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6ADA500FFEF
      E700F7E7D600F7E7CE00F7DEC600F7DEBD00F7D6B500F7D6AD00EFCE9C00EFCE
      9C00EFCE9400EFCE9C00B5848400000000000000000029ADD6009CFFFF006BE7
      FF006BE7FF006BE7FF006BE7FF006BE7FF006BE7FF005ADEFF005ADEFF005ADE
      FF005ADEFF0029ADD60000000000000000000000000029ADD60052BDE7009CFF
      FF0094FFFF0073DEF70073DEF70073DEF70073DEF7004AC6E70021ADD60018A5
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6ADA500FFF7
      E700F7E7D600F7E7CE00F7E7C600F7DEC600F7DEB500F7D6B500F7D6AD00EFCE
      9C00EFCE9C00EFCE9400B5848400000000000000000029ADD6009CFFFF0094F7
      FF0094F7FF0084EFFF0084EFFF006BE7FF006BE7FF006BE7FF005ADEFF005ADE
      FF005ADEFF0029ADD60000000000000000000000000029ADD60052BDE700ADFF
      FF008CF7FF008CEFFF008CEFFF008CEFFF0073DEF70073DEF70073DEF7004AC6
      EF0021ADD6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CEB5AD00FFFF
      F700FFEFE700F7E7D600F7E7D600F7E7CE00F7DEC600F7DEBD00F7D6B500F7D6
      AD00EFCE9C00EFCE9C00B5848400000000000000000029ADD6009CFFFF0094F7
      FF0094F7FF0094F7FF0084EFFF0084EFFF006BE7FF006BE7FF006BE7FF005ADE
      FF005ADEFF0029ADD60000000000000000000000000029ADD60029ADD600ADDE
      EF0094F7FF0094F7FF008CEFFF008CEFFF008CEFFF008CEFFF0073DEF70073DE
      F7004AC6EF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6B5AD00FFFF
      FF00FFF7EF00FFEFE700F7E7D600F7E7CE00F7E7C600F7DEC600F7DEBD00F7D6
      AD00F7D6A500F7D6A500B5848400000000000000000029ADD6009CFFFF0094F7
      FF0094F7FF0094F7FF0094F7FF0084EFFF0084EFFF006BE7FF006BE7FF006BE7
      FF005ADEFF0029ADD60000000000000000000000000029ADD60073DEF70029AD
      D6009CFFFF008CF7FF008CF7FF008CF7FF008CEFFF008CEFFF008CEFFF0073DE
      F70073DEF70018A5C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6BDB500FFFF
      FF00FFF7F700FFF7EF00FFEFDE00F7E7D600F7E7CE00F7E7C600F7DEC600F7DE
      BD00F7D6B500F7D6AD00B5848400000000000000000029ADD6009CFFFF0094F7
      FF0094F7FF0094F7FF0094F7FF0094F7FF0084EFFF0084EFFF006BE7FF006BE7
      FF006BE7FF0029ADD60000000000000000000000000029ADD60094F7FF0029AD
      D600ADDEEF00A5EFF700A5EFF700A5F7FF008CEFFF008CEFFF008CEFFF0073DE
      F70073DEF70039BDE70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6BDB500FFFF
      FF00FFFFFF00FFF7F700FFF7EF00FFEFE700F7E7D600F7E7CE00F7DEC600F7DE
      BD00F7DEB500F7DEB500B5848400000000000000000029ADD6009CFFFF0094F7
      FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0084EFFF0084EFFF006BE7
      FF006BE7FF0029ADD60000000000000000000000000029ADD6009CFFFF0073DE
      F70029ADD60018A5C60018A5C60018A5C600ADDEEF008CF7FF0084EFFF0084EF
      FF0073DEF70073DEF70018A5C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEBDB500FFFF
      FF00FFFFFF00FFFFFF00FFF7F700FFEFE700FFEFDE00F7E7D600F7E7CE00F7DE
      C600F7DEC600F7D6B500B5848400000000000000000029ADD6009CFFFF0094F7
      FF0094F7FF0094F7FF0094F7FF0084EFFF0084EFFF0084EFFF0084EFFF0084EF
      FF006BE7FF0029ADD60000000000000000000000000029ADD6009CFFFF0094F7
      FF0073DEF70073DEF70073DEF7006BDEF70029ADD600ADDEEF0084EFFF0084EF
      FF0084EFFF0094EFFF0031A5D600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEC6B500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFEFE700FFEFDE00FFEFDE00FFEF
      D600E7DEC600C6BDAD00B5848400000000000000000029ADD6009CFFFF009CFF
      FF0094F7FF0084EFFF0084EFFF0029ADD60029ADD60029ADD60029ADD60029AD
      D60029ADD60029ADD60000000000088C10000000000029ADD6009CFFFF0094F7
      FF0094F7FF0094F7FF0094F7FF0073DEF70073DEF70029ADD60018A5C60029A5
      D60029A5D60029A5D60018A5C600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7C6B500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00FFF7EF00F7E7D600C6A5
      9400B5948C00B58C8400B584840000000000000000000000000029ADD6009CFF
      FF0084EFFF0084EFFF0029ADD600000000000000000000000000000000000000
      0000000000000000000000000000088C10000000000029ADD600C6FFFF0094FF
      FF009CFFFF00D6FFFF00D6FFFF008CEFFF0094EFFF0073DEF70073DEF70018AD
      DE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7C6B500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700E7CECE00BD8C
      7300EFB57300EFA54A00C6846B0000000000000000000000000052CEEF0029AD
      D60029ADD60029ADD60052CEEF00000000000000000000000000000000000000
      000018AD290000000000088C1000007308000000000021ADD6009CDEEF00C6FF
      FF00C6FFFF009CDEEF0018ADD60018A5C60018A5C60018A5C60018A5C60018A5
      CE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFCEBD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7D6CE00C694
      7B00FFC67300CE94730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000088C100018AD2900088C100000000000000000000000000031B5DE0029AD
      D60018A5C60018A5C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7C6B500FFF7
      F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00E7CECE00C694
      7B00CE9C84000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000088C10005AE78C0018AD2900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7C6B500EFCE
      B500EFCEB500EFCEB500EFCEB500E7C6B500E7C6B500EFCEB500D6BDB500BD84
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000730800007308000073080018AD29000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00C001FFFFFFFF0000C001FFFF8FFF0000
      C0018003807F0000C0018003800F0000C001800380070000C001800380070000
      C001800380030000C001800380030000C001800380010000C001800380010000
      C001800280010000C001C1FE800F0000C001C1F4800F0000C003FFF1C3FF0000
      C007FFF1FFFF0000C00FFFF0FFFF000000000000000000000000000000000000
      000000000000}
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
    Left = 552
    Top = 316
  end
  object DataSource3: TDataSource
    DataSet = TableTree
    Left = 560
    Top = 416
  end
  object Item: TTable
    DatabaseName = '..\..\data'
    TableName = 'items.dbf'
    Left = 384
    Top = 336
    object ItemOrderNo: TFloatField
      FieldName = 'OrderNo'
    end
    object ItemItemNo: TFloatField
      FieldName = 'ItemNo'
    end
    object ItemPartNo: TFloatField
      FieldName = 'PartNo'
    end
    object ItemQty: TIntegerField
      FieldName = 'Qty'
    end
    object ItemDiscount: TFloatField
      FieldName = 'Discount'
    end
    object ItemPartsDesc: TStringField
      FieldKind = fkLookup
      FieldName = 'PartsDesc'
      LookupDataSet = Parts
      LookupKeyFields = 'PartNo'
      LookupResultField = 'Description'
      KeyFields = 'PartNo'
      Size = 30
      Lookup = True
    end
  end
  object Orders: TTable
    AutoRefresh = True
    DatabaseName = '..\..\data'
    TableName = 'orders.dbf'
    Left = 416
    Top = 336
    object OrdersOrderNo: TFloatField
      FieldName = 'OrderNo'
    end
    object OrdersCustNo: TFloatField
      FieldName = 'CustNo'
      Required = True
    end
    object OrdersSaleDate: TDateTimeField
      FieldName = 'SaleDate'
    end
    object OrdersShipDate: TDateTimeField
      FieldName = 'ShipDate'
    end
    object OrdersEmpNo: TIntegerField
      FieldName = 'EmpNo'
      Required = True
    end
    object OrdersShipToContact: TStringField
      FieldName = 'ShipToContact'
    end
    object OrdersShipToAddr1: TStringField
      FieldName = 'ShipToAddr1'
      Size = 30
    end
    object OrdersShipToAddr2: TStringField
      FieldName = 'ShipToAddr2'
      Size = 30
    end
    object OrdersShipToCity: TStringField
      FieldName = 'ShipToCity'
      Size = 15
    end
    object OrdersShipToState: TStringField
      FieldName = 'ShipToState'
    end
    object OrdersShipToZip: TStringField
      FieldName = 'ShipToZip'
      Size = 10
    end
    object OrdersShipToCountry: TStringField
      FieldName = 'ShipToCountry'
    end
    object OrdersShipToPhone: TStringField
      FieldName = 'ShipToPhone'
      Size = 15
    end
    object OrdersShipVIA: TStringField
      FieldName = 'ShipVIA'
      Size = 7
    end
    object OrdersPO: TStringField
      FieldName = 'PO'
      Size = 15
    end
    object OrdersTerms: TStringField
      FieldName = 'Terms'
      Size = 6
    end
    object OrdersPaymentMethod: TStringField
      FieldName = 'PaymentMethod'
      Size = 7
    end
    object OrdersItemsTotal: TCurrencyField
      FieldName = 'ItemsTotal'
    end
    object OrdersTaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object OrdersFreight: TCurrencyField
      FieldName = 'Freight'
    end
    object OrdersAmountPaid: TCurrencyField
      FieldName = 'AmountPaid'
    end
  end
  object Customer: TTable
    DatabaseName = '..\..\data'
    FieldDefs = <
      item
        Name = 'CustNo'
        DataType = ftFloat
      end
      item
        Name = 'Company'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Addr1'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Addr2'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'City'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'State'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Zip'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Phone'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'FAX'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'TaxRate'
        DataType = ftFloat
      end
      item
        Name = 'Contact'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LastInvoiceDate'
        DataType = ftDateTime
      end>
    IndexDefs = <
      item
        Name = 'CustomerIndex1'
        Fields = 'CustNo'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'ByCompany'
        Fields = 'Company'
        Options = [ixCaseInsensitive]
      end>
    StoreDefs = True
    TableName = 'customer.dbf'
    Left = 416
    Top = 372
    object CustomerCustNo: TFloatField
      FieldName = 'CustNo'
    end
    object CustomerCompany: TStringField
      FieldName = 'Company'
      Size = 30
    end
    object CustomerAddr1: TStringField
      FieldName = 'Addr1'
      Size = 30
    end
    object CustomerAddr2: TStringField
      FieldName = 'Addr2'
      Size = 30
    end
    object CustomerCity: TStringField
      FieldName = 'City'
      Size = 15
    end
    object CustomerState: TStringField
      FieldName = 'State'
    end
    object CustomerZip: TStringField
      FieldName = 'Zip'
      Size = 10
    end
    object CustomerCountry: TStringField
      FieldName = 'Country'
    end
    object CustomerPhone: TStringField
      FieldName = 'Phone'
      Size = 15
    end
    object CustomerFAX: TStringField
      FieldName = 'FAX'
      Size = 15
    end
    object CustomerTaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object CustomerContact: TStringField
      FieldName = 'Contact'
    end
    object CustomerLastInvoiceDate: TDateTimeField
      FieldName = 'LastInvoiceDate'
    end
  end
  object Parts: TTable
    DatabaseName = '..\..\data'
    TableName = 'parts.dbf'
    Left = 384
    Top = 372
    object PartsPartNo: TFloatField
      FieldName = 'PartNo'
    end
    object PartsVendorNo: TFloatField
      FieldName = 'VendorNo'
    end
    object PartsDescription: TStringField
      FieldName = 'Description'
      Size = 30
    end
    object PartsOnHand: TFloatField
      FieldName = 'OnHand'
    end
    object PartsOnOrder: TFloatField
      FieldName = 'OnOrder'
    end
    object PartsCost: TCurrencyField
      FieldName = 'Cost'
    end
    object PartsListPrice: TCurrencyField
      FieldName = 'ListPrice'
    end
  end
  object DataSource4: TDataSource
    DataSet = Orders
    Left = 612
    Top = 404
  end
  object DataSource5: TDataSource
    DataSet = Customer
    Left = 508
    Top = 432
  end
  object DataSource6: TDataSource
    DataSet = Item
    Left = 660
    Top = 388
  end
  object MasterDetail: TElRelDataSource
    DataSet = Customer
    Filtered = False
    OwnFilter = False
    Relations = <
      item
        MasterDataSet = Customer
        MasterField = 'CustNo'
        DetailDataSet = Orders
        DetailField = 'CustNo'
        DetailDisplayField = 'OrderNo'
      end
      item
        MasterDataSet = Orders
        MasterField = 'OrderNo'
        DetailDataSet = Item
        DetailField = 'OrderNo'
        DetailDisplayField = 'PartsDesc'
      end>
    RootDataField = 'Company'
    Left = 452
    Top = 356
  end
  object ElDBTreeEdit1: TElDBTreeEdit
    Tree = ElDBTree3
    Types = [sftText]
    Left = 296
    Top = 416
  end
  object ElDBTreeDateTimePickerEdit1: TElDBTreeDateTimePickerEdit
    Tree = ElDBTree3
    Types = [sftDateTime, sftDate, sftTime]
    Left = 336
    Top = 416
  end
  object ElDBTreeCurrencyEdit1: TElDBTreeCurrencyEdit
    Tree = ElDBTree3
    Types = [sftCurrency]
    Left = 376
    Top = 416
  end
  object ElDBTreeFloatSpinEdit1: TElDBTreeFloatSpinEdit
    Tree = ElDBTree3
    Types = [sftFloating]
    Left = 408
    Top = 416
  end
  object ElFlatMultiController1: TElFlatMultiController
    Entries = <
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPageControl1
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElTabSheet2
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElTabSheet3
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = Panel1
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = False
        DesignActive = True
        Control = DBGrid2
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = False
        DesignActive = True
        Control = DBGrid1
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElTabSheet1
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = Panel7
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElDBTree3
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = Panel6
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = Panel9
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElSplitter1
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElSplitter2
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElSplitter3
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel2
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElDBNavigator1
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel1
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel3
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElSplitter4
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElStatusBar1
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel4
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElDBNavigator3
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel5
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel6
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElDBTree1
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel7
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel8
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel9
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElDBTree2
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel10
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel11
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = DBGrid4
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel12
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel13
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = DBGrid7
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel14
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel15
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = DBGrid5
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel16
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElPanel17
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = DBGrid3
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElSplitter5
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = Panel8
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end
      item
        Active = True
        BorderSides = []
        FlatFocusedScrollbars = True
        DesignActive = True
        Control = ElDBNavigator2
        ActiveBorderType = fbtLineBorder
        InactiveBorderType = fbtFlat
        LineBorderActiveColor = clBlack
        LineBorderInactiveColor = clBlack
        UseXPThemes = True
      end>
    FlatFocusedScrollbars = True
    ActiveBorderType = fbtLineBorder
    InactiveBorderType = fbtFlat
    LineBorderActiveColor = clBlack
    LineBorderInactiveColor = clBlack
    BorderSides = []
    Left = 604
    Top = 256
  end
end
