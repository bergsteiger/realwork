object frmRave: TfrmRave
  Left = 205
  Top = 131
  Caption = 'Gnostice eDocEngine - RaveReports Interface Demo'
  ClientHeight = 6
  ClientWidth = 116
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 116
    Height = 57
    Align = alTop
    TabOrder = 0
    object btnLoadFile: TButton
      Left = 16
      Top = 16
      Width = 111
      Height = 25
      Caption = 'Load NDR File...'
      TabOrder = 0
      OnClick = btnLoadFileClick
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
    Width = 116
    Height = 3
    Align = alClient
    TabOrder = 1
    object ScrollBox1: TScrollBox
      Left = 1
      Top = 1
      Width = 114
      Height = 1
      Align = alClient
      TabOrder = 0
    end
  end
  object btnNextPage: TButton
    Left = 259
    Top = 16
    Width = 110
    Height = 25
    Caption = 'Next Page'
    TabOrder = 2
    OnClick = btnNextPageClick
  end
  object btnPrevPage: TButton
    Left = 380
    Top = 16
    Width = 112
    Height = 25
    Caption = 'Previous Page'
    TabOrder = 3
    OnClick = btnPrevPageClick
  end
  object RvRenderPreview1: TRvRenderPreview
    DisplayName = 'RPRender'
    ScrollBox = ScrollBox1
    ZoomFactor = 100.000000000000000000
    ShadowDepth = 0
    Left = 93
    Top = 392
  end
  object RvSystem1: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemOptions = [soShowStatus, soAllowPrintFromPreview, soPreviewModal, soNoGenerate]
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemFiler.StreamMode = smFile
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 123
    Top = 392
  end
  object OpenDialog1: TOpenDialog
    Filter = 'NDR Files (*.ndr) | *.ndr'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 183
    Top = 392
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 302
    Top = 392
  end
  object gtRaveExportInterface1: TgtRaveExportInterface
    DoBeginDoc = True
    DoEndDoc = True
    Left = 362
    Top = 392
  end
  object gtDocSettings1: TgtDocSettings
    BackgroundImageDisplayType = dtCenter
    MeasurementUnit = muPixels
    Page.Width = 793.699199999999900000
    Page.Height = 1122.518400000000000000
    Page.BinNumber = 0
    Left = 392
    Top = 392
  end
  object gtPDFEngine1: TgtPDFEngine
    FileExtension = 'pdf'
    FileDescription = 'Adobe PDF Files'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    Preferences.ProcessAfterEachPage = True
    Preferences.UseImagesAsResources = False
    FontEncoding = feWinAnsiEncoding
    DigitalSignature.FieldProperties.Visible = True
    DigitalSignature.FieldProperties.PageNumber = 1
    DigitalSignature.FieldProperties.FieldAppearenceOptions = [sfaoShowName, sfaoShowReason, sfaoShowLocation, sfaoShowDate, sfaoShowLabels]
    DigitalSignature.SignatureProperties.DateTime = 41303.469299305560000000
    Left = 64
    Top = 424
  end
  object gtRTFEngine1: TgtRTFEngine
    FileExtension = 'rtf'
    FileDescription = 'Rich Text Format'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    Preferences.GraphicDataInBinary = False
    DocumentEncodingType = etPositionalAccuracy
    Left = 93
    Top = 424
  end
  object gtHTMLEngine1: TgtHTMLEngine
    FileExtension = 'htm'
    FileDescription = 'HyperText Markup Language'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    Preferences.AutoScroll = False
    Preferences.OptimizeForIE = False
    Navigator.LinkFont.Charset = DEFAULT_CHARSET
    Navigator.LinkFont.Color = clBlue
    Navigator.LinkFont.Height = -27
    Navigator.LinkFont.Name = 'Wingdings'
    Navigator.LinkFont.Style = []
    TransparentBackground = True
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
    Left = 123
    Top = 424
  end
  object gtXHTMLEngine1: TgtXHTMLEngine
    FileExtension = 'htm'
    FileDescription = 'Extended HyperText Markup Language'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    Preferences.AutoScroll = False
    Preferences.OptimizeForIE = False
    Navigator.LinkFont.Charset = DEFAULT_CHARSET
    Navigator.LinkFont.Color = clBlue
    Navigator.LinkFont.Height = -27
    Navigator.LinkFont.Name = 'Wingdings'
    Navigator.LinkFont.Style = []
    TransparentBackground = True
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
    Left = 153
    Top = 424
  end
  object gtTextEngine1: TgtTextEngine
    FileExtension = 'txt'
    FileDescription = 'Text Document'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -11
    DefaultFont.Name = 'MS Sans Serif'
    DefaultFont.Style = []
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    PageEndLines = True
    ColumnSpacing = 1
    Left = 183
    Top = 424
  end
  object gtQuattroProEngine1: TgtQuattroProEngine
    FileExtension = 'wb1'
    FileDescription = 'Quattro Pro for Windows'
    InputXRes = 96
    InputYRes = 96
    ItemsToRender = [irText]
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Preferences.NumberFormatDecimalPlaces = 0
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1.000000000000000000
    Formatting.ScaleY = 1.000000000000000000
    Left = 213
    Top = 424
  end
  object gtLotusEngine1: TgtLotusEngine
    FileExtension = 'WK1'
    FileDescription = 'Lotus 1-2-3'
    InputXRes = 96
    InputYRes = 96
    ItemsToRender = [irText]
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Preferences.NumberFormatDecimalPlaces = 0
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1.000000000000000000
    Formatting.ScaleY = 1.000000000000000000
    Left = 242
    Top = 424
  end
  object gtDIFEngine1: TgtDIFEngine
    FileExtension = 'DIF'
    FileDescription = 'Data Interchange Format'
    InputXRes = 96
    InputYRes = 96
    ItemsToRender = [irText]
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Preferences.NumberFormatDecimalPlaces = 0
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1.000000000000000000
    Formatting.ScaleY = 1.000000000000000000
    Left = 272
    Top = 424
  end
  object gtSYLKEngine1: TgtSYLKEngine
    FileExtension = 'slk'
    FileDescription = 'Symbolic Link'
    InputXRes = 96
    InputYRes = 96
    ItemsToRender = [irText]
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Preferences.NumberFormatDecimalPlaces = 0
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1.000000000000000000
    Formatting.ScaleY = 1.000000000000000000
    Left = 302
    Top = 424
  end
  object gtJPEGEngine1: TgtJPEGEngine
    FileExtension = 'jpg'
    FileDescription = 'JPEG File Interchange Format'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Left = 64
    Top = 392
  end
  object gtGIFEngine1: TgtGIFEngine
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Left = 153
    Top = 392
  end
  object gtBMPEngine1: TgtBMPEngine
    FileExtension = 'bmp'
    FileDescription = 'Windows Bitmap'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Left = 213
    Top = 392
  end
  object gtEMFEngine1: TgtEMFEngine
    FileExtension = 'emf'
    FileDescription = 'Enhanced Metafiles'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Left = 242
    Top = 392
  end
  object gtWMFEngine1: TgtWMFEngine
    FileExtension = 'wmf'
    FileDescription = 'Windows Metafiles'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Left = 272
    Top = 392
  end
  object gtExcelEngine1: TgtExcelEngine
    FileExtension = 'xlsx'
    FileDescription = 'Microsoft Excel Workbook'
    InputXRes = 96
    InputYRes = 96
    ItemsToRender = [irText, irImage]
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    FileName = 'xlsx'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Preferences.NumberFormatDecimalPlaces = 0
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1.000000000000000000
    Formatting.ScaleY = 1.000000000000000000
    Brush.Color = clBlue
    ImageSettings.SourceDPI = 86
    ImageSettings.OutputImageFormat = ifMetafile
    Left = 332
    Top = 392
  end
  object gtRaveExportInterface2: TgtRaveExportInterface
    DoBeginDoc = True
    DoEndDoc = True
    Left = 104
    Top = 408
  end
  object gtXLSEngine1: TgtXLSEngine
    FileExtension = 'xls'
    FileDescription = 'Microsoft Excel Workbook'
    InputXRes = 96
    InputYRes = 96
    ItemsToRender = [irText, irImage]
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    Preferences.AutoFormatCells = False
    Preferences.NumberFormatDecimalPlaces = 0
    Formatting.ColumnSpacing = -1
    Formatting.RowSpacing = -1
    Formatting.ScaleX = 1.000000000000000000
    Formatting.ScaleY = 1.000000000000000000
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifMetafile
    Left = 344
    Top = 432
  end
end
