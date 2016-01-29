object frmHtmlViewer: TfrmHtmlViewer
  Left = 147
  Top = 135
  Caption = 'Gnostice eDocEngine - HtmlViewer Interface Demo'
  ClientHeight = 0
  ClientWidth = 145
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 145
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btnLoadfile: TButton
      Left = 16
      Top = 16
      Width = 111
      Height = 25
      Caption = 'Load HTML File...'
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
    Width = 145
    Height = 1
    Align = alClient
    BevelOuter = bvLowered
    Caption = 'Panel2'
    TabOrder = 1
    object HTMLViewer1: THTMLViewer
      Left = 1
      Top = 1
      Width = 143
      Height = 7
      TabOrder = 0
      Align = alClient
      BorderStyle = htFocused
      HistoryMaxCount = 0
      DefFontName = 'Times New Roman'
      DefPreFontName = 'Courier New'
      NoSelect = False
      CharSet = DEFAULT_CHARSET
      PrintMarginLeft = 2.000000000000000000
      PrintMarginRight = 2.000000000000000000
      PrintMarginTop = 2.000000000000000000
      PrintMarginBottom = 2.000000000000000000
      PrintScale = 1.000000000000000000
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'HTML Files (*.html;*.htm) |*.html;*.htm'
    FilterIndex = 2
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 209
    Top = 418
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 378
    Top = 418
  end
  object gtDocSettings1: TgtDocSettings
    BackgroundImageDisplayType = dtCenter
    MeasurementUnit = muPixels
    Page.Width = 793.699199999999900000
    Page.Height = 1122.518400000000000000
    Page.BinNumber = 0
    Left = 519
    Top = 418
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
    ImageSettings.OutputImageFormat = ifBMP
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    FontEncoding = feWinAnsiEncoding
    DigitalSignature.FieldProperties.Visible = True
    DigitalSignature.FieldProperties.PageNumber = 1
    DigitalSignature.FieldProperties.FieldAppearenceOptions = [sfaoShowName, sfaoShowReason, sfaoShowLocation, sfaoShowDate, sfaoShowLabels]
    DigitalSignature.SignatureProperties.DateTime = 41645.607945347220000000
    Left = 12
    Top = 418
  end
  object gtRTFEngine1: TgtRTFEngine
    FileExtension = 'rtf'
    FileDescription = 'Rich Text Format'
    InputXRes = 86
    InputYRes = 86
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
    Left = 293
    Top = 418
  end
  object gtHTMLEngine1: TgtHTMLEngine
    FileExtension = 'htm'
    FileDescription = 'HyperText Markup Language'
    InputXRes = 86
    InputYRes = 86
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
    TOCPageSettings.ItemFont.Height = -11
    TOCPageSettings.ItemFont.Name = 'MS Sans Serif'
    TOCPageSettings.ItemFont.Style = []
    TOCPageSettings.TitleFont.Charset = DEFAULT_CHARSET
    TOCPageSettings.TitleFont.Color = clWindowText
    TOCPageSettings.TitleFont.Height = -11
    TOCPageSettings.TitleFont.Name = 'MS Sans Serif'
    TOCPageSettings.TitleFont.Style = []
    TOCPageSettings.Title = 'Table Of Contents'
    Left = 406
    Top = 418
  end
  object gtExcelEngine1: TgtExcelEngine
    FileExtension = 'xlsx'
    FileDescription = 'Microsoft Excel Workbook'
    InputXRes = 86
    InputYRes = 86
    ItemsToRender = [irText, irImage]
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
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifMetafile
    Left = 181
    Top = 418
  end
  object gtTextEngine1: TgtTextEngine
    FileExtension = 'txt'
    FileDescription = 'Text Document'
    InputXRes = 86
    InputYRes = 86
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
    Left = 321
    Top = 418
  end
  object gtQuattroProEngine1: TgtQuattroProEngine
    FileExtension = 'wb1'
    FileDescription = 'Quattro Pro for Windows'
    InputXRes = 86
    InputYRes = 86
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
    Left = 462
    Top = 418
  end
  object gtLotusEngine1: TgtLotusEngine
    FileExtension = 'WK1'
    FileDescription = 'Lotus 1-2-3'
    InputXRes = 86
    InputYRes = 86
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
    Left = 575
    Top = 418
  end
  object gtDIFEngine1: TgtDIFEngine
    FileExtension = 'DIF'
    FileDescription = 'Data Interchange Format'
    InputXRes = 86
    InputYRes = 86
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
    Left = 68
    Top = 418
  end
  object gtSYLKEngine1: TgtSYLKEngine
    FileExtension = 'slk'
    FileDescription = 'Symbolic Link'
    InputXRes = 86
    InputYRes = 86
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
    Left = 350
    Top = 418
  end
  object gtTIFFEngine1: TgtTIFFEngine
    FileExtension = 'tif'
    FileDescription = 'Tagged Image File Format'
    InputXRes = 86
    InputYRes = 86
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
    Left = 434
    Top = 418
  end
  object gtPNGEngine1: TgtPNGEngine
    FileExtension = 'png'
    FileDescription = 'Portable Network Graphics'
    InputXRes = 86
    InputYRes = 86
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
    Left = 547
    Top = 418
  end
  object gtSVGEngine1: TgtSVGEngine
    FileExtension = 'svg'
    FileDescription = 'Scalable Vector Graphics'
    InputXRes = 86
    InputYRes = 86
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
    Left = 40
    Top = 418
  end
  object gtJPEGEngine1: TgtJPEGEngine
    FileExtension = 'jpg'
    FileDescription = 'JPEG File Interchange Format'
    InputXRes = 86
    InputYRes = 86
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
    Left = 237
    Top = 418
  end
  object gtGIFEngine1: TgtGIFEngine
    InputXRes = 86
    InputYRes = 86
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
    Left = 490
    Top = 418
  end
  object gtBMPEngine1: TgtBMPEngine
    FileExtension = 'bmp'
    FileDescription = 'Windows Bitmap'
    InputXRes = 86
    InputYRes = 86
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
    Left = 631
    Top = 418
  end
  object gtEMFEngine1: TgtEMFEngine
    FileExtension = 'emf'
    FileDescription = 'Enhanced Metafiles'
    InputXRes = 86
    InputYRes = 86
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
    Left = 96
    Top = 418
  end
  object gtWMFEngine1: TgtWMFEngine
    FileExtension = 'wmf'
    FileDescription = 'Windows Metafiles'
    InputXRes = 86
    InputYRes = 86
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
    Left = 265
    Top = 418
  end
  object gtXHTMLEngine1: TgtXHTMLEngine
    FileExtension = 'htm'
    FileDescription = 'Extended HyperText Markup Language'
    InputXRes = 86
    InputYRes = 86
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
    TOCPageSettings.ItemFont.Height = -11
    TOCPageSettings.ItemFont.Name = 'MS Sans Serif'
    TOCPageSettings.ItemFont.Style = []
    TOCPageSettings.TitleFont.Charset = DEFAULT_CHARSET
    TOCPageSettings.TitleFont.Color = clWindowText
    TOCPageSettings.TitleFont.Height = -11
    TOCPageSettings.TitleFont.Name = 'MS Sans Serif'
    TOCPageSettings.TitleFont.Style = []
    TOCPageSettings.Title = 'Table Of Contents'
    Left = 603
    Top = 418
  end
  object gtHtmlViewInterface1: TgtHtmlViewInterface
    DoBeginDoc = True
    DoEndDoc = True
    AutoSizePage = True
    Left = 128
    Top = 417
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
    Left = 152
    Top = 420
  end
end
