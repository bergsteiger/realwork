object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Gnostice eDocEngine - ScaleRichView Interface Demo'
  ClientHeight = 485
  ClientWidth = 921
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 921
    Height = 59
    Align = alTop
    TabOrder = 0
    object Button1: TButton
      Left = 10
      Top = 18
      Width = 129
      Height = 25
      Caption = 'Load RVF/RTF File...'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 600
      Top = 18
      Width = 129
      Height = 25
      Caption = 'Export Report'
      TabOrder = 1
      OnClick = Button2Click
    end
    object GroupBox1: TGroupBox
      Left = 210
      Top = 1
      Width = 321
      Height = 52
      Caption = 'Rendering Options'
      TabOrder = 2
      object CheckBox1: TCheckBox
        Left = 16
        Top = 18
        Width = 115
        Height = 17
        Caption = 'Page Number Visible '
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object CheckBox2: TCheckBox
        Left = 150
        Top = 18
        Width = 83
        Height = 17
        Caption = 'Clip Margins'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object CheckBox3: TCheckBox
        Left = 250
        Top = 18
        Width = 115
        Height = 17
        Caption = 'Printing'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 59
    Width = 921
    Height = 426
    Align = alClient
    TabOrder = 1
    ExplicitTop = 41
    ExplicitWidth = 720
    ExplicitHeight = 444
    object SRichViewEdit1: TSRichViewEdit
      Left = 1
      Top = 1
      Width = 919
      Height = 424
      Cursor = crIBeam
      Align = alClient
      Color = 10070188
      HScrollBarSchemeIndex = 0
      VScrollBarSchemeIndex = 0
      Version = 'v5.5'
      PageProperty.PageWidth = 210.000000000000000000
      PageProperty.PageHeight = 297.000000000000000000
      PageProperty.LeftMargin = 35.000000000000000000
      PageProperty.RightMargin = 15.000000000000000000
      PageProperty.TopMargin = 25.000000000000000000
      PageProperty.BottomMargin = 25.000000000000000000
      PageProperty.PageNoFont.Charset = DEFAULT_CHARSET
      PageProperty.PageNoFont.Color = clWindowText
      PageProperty.PageNoFont.Height = -11
      PageProperty.PageNoFont.Name = 'Arial'
      PageProperty.PageNoFont.Style = []
      PageProperty.PageBreak.Text = 'Page break'
      PageProperty.HeaderY = 10.000000000000000000
      PageProperty.FooterY = 10.000000000000000000
      ViewProperty.MarginBounds = [srvmbLeft, srvmbRight, srvmbTop, srvmbBottom]
      ViewProperty.HintFont.Charset = DEFAULT_CHARSET
      ViewProperty.HintFont.Color = clInfoText
      ViewProperty.HintFont.Height = -13
      ViewProperty.HintFont.Name = 'Arial'
      ViewProperty.HintFont.Style = []
      ViewProperty.HintPrefixText = 'Page '
      ViewProperty.ZoomPanelFont.Charset = DEFAULT_CHARSET
      ViewProperty.ZoomPanelFont.Height = -11
      ViewProperty.ZoomPanelFont.Name = 'Arial'
      ViewProperty.ZoomPercent = 108.000000000000000000
      ViewProperty.ZoomPercentEdit = 100.000000000000000000
      ViewProperty.ZoomPercentIN = 29.037923812866210000
      ViewProperty.ZoomPercentOUT = 100.000000000000000000
      ViewProperty.MainTitleFont.Charset = DEFAULT_CHARSET
      ViewProperty.MainTitleFont.Height = -11
      ViewProperty.MainTitleFont.Name = 'Tahoma'
      ViewProperty.MainTitleFont.Style = []
      ViewProperty.HeaderTitle = 'Header'
      ViewProperty.HeaderTitleFont.Charset = DEFAULT_CHARSET
      ViewProperty.HeaderTitleFont.Height = -11
      ViewProperty.HeaderTitleFont.Name = 'Tahoma'
      ViewProperty.HeaderTitleFont.Style = []
      ViewProperty.FooterTitle = 'Footer'
      ViewProperty.FooterTitleFont.Charset = DEFAULT_CHARSET
      ViewProperty.FooterTitleFont.Height = -11
      ViewProperty.FooterTitleFont.Name = 'Tahoma'
      ViewProperty.FooterTitleFont.Style = []
      BackgroundProperty.PercentMiddle = 50.000000000000000000
      MenuHButtons = <>
      MenuVButtons = <>
      MenuHorizontal.PenFrame.Color = 12937777
      MenuHorizontal.ButtonWidth = 15
      MenuVertical.PenFrame.Color = 12937777
      MenuVertical.ButtonHeight = 15
      CaretBlinkTime = 530
      RVColor = clWhite
      RVOptions = [rvoAllowSelection, rvoScrollToEnd, rvoTagsArePChars, rvoAutoCopyText, rvoAutoCopyRVF, rvoAutoCopyImage, rvoAutoCopyRTF, rvoFormatInvalidate, rvoDblClickSelectsWord, rvoRClickDeselects, rvoFastFormatting]
      RVEditorOptions = [rvoCtrlJumps, rvoWantTabs]
      RTFOptions = [rvrtfDuplicateUnicode, rvrtfSaveEMFAsWMF, rvrtfSaveJpegAsJpeg, rvrtfSaveDocParameters, rvrtfSaveHeaderFooter]
      RVFOptions = [rvfoSavePicturesBody, rvfoSaveControlsBody, rvfoIgnoreUnknownPicFmt, rvfoIgnoreUnknownCtrls, rvfoConvUnknownStylesToZero, rvfoConvLargeImageIdxToZero, rvfoSaveBinary, rvfoSaveBack, rvfoLoadBack, rvfoSaveTextStyles, rvfoSaveParaStyles, rvfoSaveLayout, rvfoLoadLayout, rvfoSaveDocProperties, rvfoLoadDocProperties]
      TabNavigation = rvtnNone
      ExplicitLeft = 41
      ExplicitTop = 6
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'RVF Files (*.rvf) |*.rvf|RTF files (*.rtf) |*.rtf'
    Top = 440
  end
  object gtDocSettings1: TgtDocSettings
    BackgroundImageDisplayType = dtCenter
    MeasurementUnit = muPixels
    Page.Width = 793.699199999999900000
    Page.Height = 1122.518400000000000000
    Page.BinNumber = 0
    Left = 168
    Top = 440
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
    Font.Name = 'Tahoma'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    Preferences.GraphicDataInBinary = False
    DocumentEncodingType = etPositionalAccuracy
    Left = 488
    Top = 440
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
    Font.Name = 'Tahoma'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
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
    TOCPageSettings.ItemFont.Name = 'Tahoma'
    TOCPageSettings.ItemFont.Style = []
    TOCPageSettings.TitleFont.Charset = DEFAULT_CHARSET
    TOCPageSettings.TitleFont.Color = clWindowText
    TOCPageSettings.TitleFont.Height = -11
    TOCPageSettings.TitleFont.Name = 'Tahoma'
    TOCPageSettings.TitleFont.Style = []
    TOCPageSettings.Title = 'Table Of Contents'
    Left = 312
    Top = 440
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
    Font.Name = 'Tahoma'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
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
    TOCPageSettings.ItemFont.Name = 'Tahoma'
    TOCPageSettings.ItemFont.Style = []
    TOCPageSettings.TitleFont.Charset = DEFAULT_CHARSET
    TOCPageSettings.TitleFont.Color = clWindowText
    TOCPageSettings.TitleFont.Height = -11
    TOCPageSettings.TitleFont.Name = 'Tahoma'
    TOCPageSettings.TitleFont.Style = []
    TOCPageSettings.Title = 'Table Of Contents'
    Left = 664
    Top = 440
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
    Left = 248
    Top = 440
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
    DefaultFont.Name = 'Tahoma'
    DefaultFont.Style = []
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    PageEndLines = True
    ColumnSpacing = 1
    Left = 576
    Top = 440
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
    Left = 464
    Top = 440
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
    Left = 376
    Top = 440
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
    Left = 128
    Top = 440
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
    Left = 552
    Top = 440
  end
  object gtTIFFEngine1: TgtTIFFEngine
    FileExtension = 'tif'
    FileDescription = 'Tagged Image File Format'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Left = 608
    Top = 440
  end
  object gtPNGEngine1: TgtPNGEngine
    FileExtension = 'png'
    FileDescription = 'Portable Network Graphics'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Left = 432
    Top = 440
  end
  object gtSVGEngine1: TgtSVGEngine
    FileExtension = 'svg'
    FileDescription = 'Scalable Vector Graphics'
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    Left = 520
    Top = 440
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
    Font.Name = 'Tahoma'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Left = 344
    Top = 440
  end
  object gtGIFEngine1: TgtGIFEngine
    InputXRes = 96
    InputYRes = 96
    ReferencePoint = rpBand
    EMailSettings.AuthenticationRequired = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Left = 280
    Top = 440
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
    Font.Name = 'Tahoma'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Left = 88
    Top = 440
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
    Font.Name = 'Tahoma'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Left = 200
    Top = 440
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
    Font.Name = 'Tahoma'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Left = 632
    Top = 440
  end
  object SaveDialog1: TSaveDialog
    Left = 40
    Top = 440
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
    Left = 224
    Top = 440
  end
  object gtScaleRichViewInterface1: TgtScaleRichViewInterface
    DoBeginDoc = True
    DoEndDoc = True
    Left = 408
    Top = 440
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
    Font.Name = 'Tahoma'
    Font.Style = []
    ImageSettings.SourceDPI = 96
    ImageSettings.OutputImageFormat = ifJPEG
    Page.Width = 8.267700000000000000
    Page.Height = 11.692900000000000000
    Page.BinNumber = 0
    FontEncoding = feWinAnsiEncoding
    DigitalSignature.FieldProperties.Visible = True
    DigitalSignature.FieldProperties.PageNumber = 1
    DigitalSignature.FieldProperties.FieldAppearenceOptions = [sfaoShowName, sfaoShowReason, sfaoShowLocation, sfaoShowDate, sfaoShowLabels]
    DigitalSignature.SignatureProperties.DateTime = 41718.461838263890000000
    Left = 72
    Top = 440
  end
end
