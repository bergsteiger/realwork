object frmGmPrintSuite: TfrmGmPrintSuite
  Left = 221
  Top = 145
  Width = 705
  Height = 484
  Caption = 'Gnostice eDocEngine - GmPrintSuite Interface Demo'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 697
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnLoadfile: TButton
      Left = 16
      Top = 16
      Width = 111
      Height = 25
      Caption = 'Load RTF File...'
      TabOrder = 0
      OnClick = btnLoadfileClick
    end
    object btnExportfile: TButton
      Left = 138
      Top = 16
      Width = 111
      Height = 25
      Caption = 'Export Report...'
      TabOrder = 1
      OnClick = btnExportfileClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 57
    Width = 697
    Height = 393
    Align = alClient
    BevelOuter = bvLowered
    Caption = 'Panel2'
    TabOrder = 1
    object GmPreview1: TGmPreview
      Left = 1
      Top = 1
      Width = 695
      Height = 354
      HorzScrollBar.Range = 854
      VertScrollBar.Range = 1183
      About = 'TGmPreview v2,96.6'
      Align = alClient
      AutoScroll = False
      TabOrder = 0
      Canvas.CompareGraphics = True
      Footer.CaptionLeft.Font.Charset = DEFAULT_CHARSET
      Footer.CaptionLeft.Font.Color = clWindowText
      Footer.CaptionLeft.Font.Height = -16
      Footer.CaptionLeft.Font.Name = 'Arial'
      Footer.CaptionLeft.Font.Style = []
      Footer.CaptionCenter.Font.Charset = DEFAULT_CHARSET
      Footer.CaptionCenter.Font.Color = clWindowText
      Footer.CaptionCenter.Font.Height = -16
      Footer.CaptionCenter.Font.Name = 'Arial'
      Footer.CaptionCenter.Font.Style = []
      Footer.CaptionRight.Font.Charset = DEFAULT_CHARSET
      Footer.CaptionRight.Font.Color = clWindowText
      Footer.CaptionRight.Font.Height = -16
      Footer.CaptionRight.Font.Name = 'Arial'
      Footer.CaptionRight.Font.Style = []
      GmPrinter.Collate = False
      GmPrinter.Duplex = gmSimplex
      GmPrinter.PrintColor = gmColor
      GmPrinter.DitherType = gmNone
      GmPrinter.PrintQuality = gmMedium
      GmPrinter.Title = '<document>'
      Header.CaptionLeft.Font.Charset = DEFAULT_CHARSET
      Header.CaptionLeft.Font.Color = clWindowText
      Header.CaptionLeft.Font.Height = -16
      Header.CaptionLeft.Font.Name = 'Arial'
      Header.CaptionLeft.Font.Style = []
      Header.CaptionCenter.Font.Charset = DEFAULT_CHARSET
      Header.CaptionCenter.Font.Color = clWindowText
      Header.CaptionCenter.Font.Height = -16
      Header.CaptionCenter.Font.Name = 'Arial'
      Header.CaptionCenter.Font.Style = []
      Header.CaptionRight.Font.Charset = DEFAULT_CHARSET
      Header.CaptionRight.Font.Color = clWindowText
      Header.CaptionRight.Font.Height = -16
      Header.CaptionRight.Font.Name = 'Arial'
      Header.CaptionRight.Font.Style = []
      Margins.Pen.Color = clSilver
      Margins.Pen.Style = psDot
      Margins.PrinterMarginPen.Color = clSilver
      Margins.PrinterMarginPen.Style = psDot
      Margins.Values.Left = 0.5
      Margins.Values.Top = 0.5
      Margins.Values.Right = 0.5
      Margins.Values.Bottom = 0.5
      PageGrid.GridPen.Color = clSilver
      PagesPerSheet = gmOnePage
      Zoom = 100
      MarginValues = '720,720,720,720,"12632256,1,2,4","12632256,1,2,4"'
    end
    object GmPageNavigator1: TGmPageNavigator
      Left = 1
      Top = 355
      Width = 695
      Height = 37
      About = 'TGmPageNavigator v2,96.6'
      Align = alBottom
      BorderStyle = bsSingle
      TabOrder = 1
      BorderWidth = 6
      ButtonHeight = 30
      ButtonWidth = 30
      Preview = GmPreview1
      VisibleButtons = [gmFirstPage, gmPrevPage, gmNextPage, gmLastPage, gmZoomIn, gmZoomOut, gmActualSize, gmFitWidth, gmFitHeight, gmFitWholePage]
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'RTF files (*.rtf) |*.rtf'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 181
    Top = 42
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 359
    Top = 42
  end
  object gtDocSettings1: TgtDocSettings
    BackgroundImageDisplayType = dtCenter
    MeasurementUnit = muPixels
    Page.Width = 793.6992
    Page.Height = 1122.5184
    Page.BinNumber = 0
    Left = 507
    Top = 42
  end
  object gtPDFEngine1: TgtPDFEngine
    FileExtension = 'pdf'
    FileDescription = 'Adobe PDF Files'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    FontEncoding = feWinAnsiEncoding
    Left = 4
    Top = 42
  end
  object gtRTFEngine1: TgtRTFEngine
    FileExtension = 'rtf'
    FileDescription = 'Rich Text Format'
    InputXRes = 86
    InputYRes = 86
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.GraphicDataInBinary = False
    DocumentEncodingType = etPositionalAccuracy
    Left = 270
    Top = 42
  end
  object gtHTMLEngine1: TgtHTMLEngine
    FileExtension = 'htm'
    FileDescription = 'HyperText Markup Language'
    InputXRes = 86
    InputYRes = 86
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.AutoScroll = False
    Preferences.OptimizeForIE = False
    Navigator.LinkFont.Charset = DEFAULT_CHARSET
    Navigator.LinkFont.Color = clBlue
    Navigator.LinkFont.Height = -27
    Navigator.LinkFont.Name = 'Wingdings'
    Navigator.LinkFont.Style = []
    TOCPageSettings.ItemFont.Charset = DEFAULT_CHARSET
    TOCPageSettings.ItemFont.Color = clWindowText
    TOCPageSettings.ItemFont.Height = -10
    TOCPageSettings.ItemFont.Name = 'MS Sans Serif'
    TOCPageSettings.ItemFont.Style = []
    TOCPageSettings.TitleFont.Charset = DEFAULT_CHARSET
    TOCPageSettings.TitleFont.Color = clWindowText
    TOCPageSettings.TitleFont.Height = -10
    TOCPageSettings.TitleFont.Name = 'MS Sans Serif'
    TOCPageSettings.TitleFont.Style = []
    TOCPageSettings.Title = 'Table Of Contents'
    Left = 389
    Top = 42
  end
  object gtExcelEngine1: TgtExcelEngine
    FileExtension = 'xls'
    FileDescription = 'Microsoft Excel Workbook'
    InputXRes = 86
    InputYRes = 86
    ItemsToRender = [irText, irImage]
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1
    Formatting.ScaleY = 1
    ImageSettings.SourceDPI = 86
    ImageSettings.OutputImageFormat = ifMetafile
    Left = 152
    Top = 42
  end
  object gtTextEngine1: TgtTextEngine
    FileExtension = 'txt'
    FileDescription = 'Text Document'
    InputXRes = 86
    InputYRes = 86
    ReferencePoint = rpBand
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -11
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    PageEndLines = True
    ColumnSpacing = 1
    Left = 300
    Top = 42
  end
  object gtQuattroProEngine1: TgtQuattroProEngine
    FileExtension = 'wb1'
    FileDescription = 'Quattro Pro for Windows'
    InputXRes = 86
    InputYRes = 86
    ItemsToRender = [irText]
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1
    Formatting.ScaleY = 1
    Left = 448
    Top = 42
  end
  object gtLotusEngine1: TgtLotusEngine
    FileExtension = 'WK1'
    FileDescription = 'Lotus 1-2-3'
    InputXRes = 86
    InputYRes = 86
    ItemsToRender = [irText]
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1
    Formatting.ScaleY = 1
    Left = 567
    Top = 42
  end
  object gtDIFEngine1: TgtDIFEngine
    FileExtension = 'DIF'
    FileDescription = 'Data Interchange Format'
    InputXRes = 86
    InputYRes = 86
    ItemsToRender = [irText]
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1
    Formatting.ScaleY = 1
    Left = 63
    Top = 42
  end
  object gtSYLKEngine1: TgtSYLKEngine
    FileExtension = 'slk'
    FileDescription = 'Symbolic Link'
    InputXRes = 86
    InputYRes = 86
    ItemsToRender = [irText]
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1
    Formatting.ScaleY = 1
    Left = 330
    Top = 42
  end
  object gtJPEGEngine1: TgtJPEGEngine
    FileExtension = 'jpg'
    FileDescription = 'JPEG File Interchange Format'
    InputXRes = 86
    InputYRes = 86
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    ScaleX = 1
    ScaleY = 1
    Left = 211
    Top = 42
  end
  object gtGIFEngine1: TgtGIFEngine
    InputXRes = 86
    InputYRes = 86
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    ScaleX = 1
    ScaleY = 1
    Left = 478
    Top = 42
  end
  object gtBMPEngine1: TgtBMPEngine
    FileExtension = 'bmp'
    FileDescription = 'Windows Bitmap'
    InputXRes = 86
    InputYRes = 86
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    ScaleX = 1
    ScaleY = 1
    Left = 626
    Top = 42
  end
  object gtEMFEngine1: TgtEMFEngine
    FileExtension = 'emf'
    FileDescription = 'Enhanced Metafiles'
    InputXRes = 86
    InputYRes = 86
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    ScaleX = 1
    ScaleY = 1
    Left = 92
    Top = 42
  end
  object gtWMFEngine1: TgtWMFEngine
    FileExtension = 'wmf'
    FileDescription = 'Windows Metafiles'
    InputXRes = 86
    InputYRes = 86
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    ScaleX = 1
    ScaleY = 1
    Left = 241
    Top = 42
  end
  object gtXHTMLEngine1: TgtXHTMLEngine
    FileExtension = 'htm'
    FileDescription = 'Extended HyperText Markup Language'
    InputXRes = 86
    InputYRes = 86
    ReferencePoint = rpBand
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.2677
    Page.Height = 11.6929
    Page.BinNumber = 0
    Preferences.AutoScroll = False
    Preferences.OptimizeForIE = False
    Navigator.LinkFont.Charset = DEFAULT_CHARSET
    Navigator.LinkFont.Color = clBlue
    Navigator.LinkFont.Height = -27
    Navigator.LinkFont.Name = 'Wingdings'
    Navigator.LinkFont.Style = []
    TOCPageSettings.ItemFont.Charset = DEFAULT_CHARSET
    TOCPageSettings.ItemFont.Color = clWindowText
    TOCPageSettings.ItemFont.Height = -10
    TOCPageSettings.ItemFont.Name = 'MS Sans Serif'
    TOCPageSettings.ItemFont.Style = []
    TOCPageSettings.TitleFont.Charset = DEFAULT_CHARSET
    TOCPageSettings.TitleFont.Color = clWindowText
    TOCPageSettings.TitleFont.Height = -10
    TOCPageSettings.TitleFont.Name = 'MS Sans Serif'
    TOCPageSettings.TitleFont.Style = []
    TOCPageSettings.Title = 'Table Of Contents'
    Left = 596
    Top = 42
  end
  object gtGmSuiteInterface1: TgtGmSuiteInterface
    DoBeginDoc = True
    DoEndDoc = True
    Left = 122
    Top = 42
  end
  object GmRtfPreview1: TGmRtfPreview
    About = 'TGmRtfPreview v2,96.6'
    Preview = GmPreview1
    TextFileFont.Charset = DEFAULT_CHARSET
    TextFileFont.Color = clWindowText
    TextFileFont.Height = -12
    TextFileFont.Name = 'Arial'
    TextFileFont.Style = []
    Left = 656
    Top = 42
  end
end
