object frmAce: TfrmAce
  Left = 203
  Top = 160
  Caption = 'Gnostice eDocEngine - AceExporter Interface Demo'
  ClientHeight = 512
  ClientWidth = 604
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 604
    Height = 57
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 116
    object btnLoadFile: TButton
      Left = 16
      Top = 16
      Width = 111
      Height = 25
      Caption = 'Load Ace File...'
      TabOrder = 0
      OnClick = btnLoadFileClick
    end
    object Button2: TButton
      Left = 138
      Top = 16
      Width = 111
      Height = 25
      Caption = 'Export Report...'
      TabOrder = 1
      OnClick = Button2Click
    end
    object btnNextPage: TButton
      Left = 260
      Top = 16
      Width = 111
      Height = 25
      Caption = 'Next Page'
      TabOrder = 2
      OnClick = btnNextPageClick
    end
    object btnPrevPage: TButton
      Left = 382
      Top = 16
      Width = 111
      Height = 25
      Caption = 'Previous Page'
      TabOrder = 3
      OnClick = btnPrevPageClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 57
    Width = 604
    Height = 455
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 116
    ExplicitHeight = 1
    object AcePreview1: TAcePreview
      Left = 1
      Top = 1
      Width = 602
      Height = 453
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 114
      ExplicitHeight = 0
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Ace Files (*.ace) | *.ace'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 344
    Top = 400
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 376
    Top = 400
  end
  object gtAceExportInterface1: TgtAceExportInterface
    DoBeginDoc = True
    DoEndDoc = True
    Left = 344
    Top = 432
  end
  object gtDocSettings1: TgtDocSettings
    BackgroundImageDisplayType = dtCenter
    MeasurementUnit = muPixels
    Page.Width = 793.699199999999900000
    Page.Height = 1122.518400000000000000
    Page.BinNumber = 0
    Left = 376
    Top = 432
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
    DigitalSignature.SignatureProperties.DateTime = 41645.605603946760000000
    Left = 56
    Top = 432
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
    Left = 88
    Top = 432
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
    TOCPageSettings.ItemFont.Height = -11
    TOCPageSettings.ItemFont.Name = 'MS Sans Serif'
    TOCPageSettings.ItemFont.Style = []
    TOCPageSettings.TitleFont.Charset = DEFAULT_CHARSET
    TOCPageSettings.TitleFont.Color = clWindowText
    TOCPageSettings.TitleFont.Height = -11
    TOCPageSettings.TitleFont.Name = 'MS Sans Serif'
    TOCPageSettings.TitleFont.Style = []
    TOCPageSettings.Title = 'Table Of Contents'
    Left = 120
    Top = 432
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
    TOCPageSettings.ItemFont.Height = -11
    TOCPageSettings.ItemFont.Name = 'MS Sans Serif'
    TOCPageSettings.ItemFont.Style = []
    TOCPageSettings.TitleFont.Charset = DEFAULT_CHARSET
    TOCPageSettings.TitleFont.Color = clWindowText
    TOCPageSettings.TitleFont.Height = -11
    TOCPageSettings.TitleFont.Name = 'MS Sans Serif'
    TOCPageSettings.TitleFont.Style = []
    TOCPageSettings.Title = 'Table Of Contents'
    Left = 152
    Top = 432
  end
  object gtExcelEngine1: TgtExcelEngine
    FileExtension = 'xlsx'
    FileDescription = 'Microsoft Excel Workbook'
    InputXRes = 96
    InputYRes = 96
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
    Left = 184
    Top = 432
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
    Left = 216
    Top = 432
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
    Left = 248
    Top = 432
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
    Left = 280
    Top = 432
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
    Left = 312
    Top = 432
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
    Left = 56
    Top = 400
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
    Left = 184
    Top = 400
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
    Left = 216
    Top = 400
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
    Left = 248
    Top = 400
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
    Left = 280
    Top = 400
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
    Left = 312
    Top = 400
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
    Left = 104
    Top = 400
  end
end
