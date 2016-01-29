{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2013 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I gtDefines.inc}
{$I gtDocDefines.inc}


unit gtDocResStrs;

interface

uses
	gtConsts3;

{----Document Dialog-----------------------------------------------------------}

{$IFNDEF gtActiveX}
resourcestring
  SgbPageRange = 'Page Range';
  SrbtnAll = 'All Pages';
  SrbtnPages = 'Pages:';
  StsPreferences = 'Preferences';
  StsContent = 'Content';
  SchkOpenAfterCreate = 'Open After Create';
  SchkEMailAfterCreate = 'EMail After Create';
  SchkProcessAfterEachPage = 'Process After Each Page';
  SchkUseImagesAsResources = 'Use Images As Resources';
  SgbItemsToRender = 'Items To Render';
  SchkText = 'Text';
  SchkShape = 'Shape';
  SlblOutputImageFormat = 'Output Image Format:';
  SlblJPEGQuality = 'JPEG Quality:';
  SlblImagePixelFormat = 'Image Pixel Format:';
  SlblSourceDPI = 'Source DPI:';
  SchkImage = 'Image';
  StsBackground = 'Background';
  SlblBackgroundImage = 'Background Image:';
  SlblBackgroundDisplayType = 'Background Display Type:';
  SbtnSelectImage = 'Select Image';
  SbtnClear = 'Clear';
  SbtnImgPrvw = 'Preview';
  SlblBackgroundColor = 'Background Color:';
  SgbDocInfo = 'Document Information';
  SlblAuthor = 'Author:';
  SlblCreator = 'Creator:';
  SlblKeywords = 'Keywords:';
  SlblSubject = 'Subject:';
  SlblTitle = 'Title:';
  SbtnOK = 'OK';
  SbtnCancel = 'Cancel';
  SlblAdvanced = 'Advanced';
  SlblViewerPreferences = 'Viewer Preferences';
  SlblDigitalSignature = 'Digital Signature';

{$ELSE}
var
  SgbPageRange, SrbtnAll, SrbtnPages, StsPreferences, StsContent,
  SchkOpenAfterCreate, SchkEMailAfterCreate, SchkProcessAfterEachPage,
  SgbItemsToRender, SchkText, SchkShape, SlblOutputImageFormat,
  SlblJPEGQuality, SlblImagePixelFormat, SlblSourceDPI, SchkImage,
  StsBackground, SlblBackgroundImage, SlblBackgroundDisplayType,
  SbtnSelectImage, SbtnClear, SbtnImgPrvw, SlblBackgroundColor, SgbDocInfo,
  SlblAuthor, SlblCreator, SlblKeywords, SlblSubject, SlblTitle, SbtnOK,
  SbtnCancel, SlblAdvanced, SlblViewerPreferences,
  SchkUseImagesAsResources, SlblDigitalSignature: String;
{$ENDIF}

resourcestring
  SPFDevice = 'Device';
  SPF1bit = '1 bit';
  SPF4bit = '4 bit';
  SPF8bit = '8 bit';
  SPF15bit = '15 bit';
  SPF16bit = '16 bit';
  SPF24bit = '24 bit';
  SPF32bit = '32 bit';
  SPFCustom = 'Custom';

  SBGDispTypTile = 'Tile';
  SBGDispTypTopLeft = 'Top-Left';
  SBGDispTypTopCenter = 'Top-Center';
  SBGDispTypTopRight = 'Top-Right';
  SBGDispTypCenterLeft = 'Center-Left';
  SBGDispTypCenter = 'Center';
  SBGDispTypCenterRight = 'Center-Right';
  SBGDispTypBottomLeft = 'Bottom-Left';
  SBGDispTypBottomCenter = 'Bottom-Center';
  SBGDispTypBottomRight = 'Bottom-Right';

  SImageFormatBMP = 'BMP';
  SImageFormatJPEG = 'JPEG';
  SImageFormatPNG = 'PNG';
  SImageFormatGIF = 'GIF';
  SImageFormatMetafile = 'Metafile';
  SImageFormatCCITT3 = 'CCITT3';
  SImageFormatCCITT4 = 'CCITT4';

  SpoLandScape = 'LandScape';
  SpoPortrait = 'Portrait';

  SpsLetter = 'Letter';
  SpsLetterSmall = 'Letter Small';
  SpsTabloid = 'Tabloid';
  SpsLedger = 'Ledger';
  SpsLegal = 'Legal';
  SpsStatement = 'Statement';
  SpsExecutive = 'Executive';
  SpsA3 = 'A3';
  SpsA4 = 'A4';
  SpsA4Small = 'A4 Small';
  SpsA5 = 'A5';
  SpsB4 = 'B4';
  SpsB5 = 'B5';
  SpsFolio = 'Folio';
  SpsQuarto = 'Quarto';
  Sps10X14 = '10 X 14';
  Sps11X17 = '11 X 17';
  SpsNote = 'Note';
  SpsEnv10 = 'Env 10';
  SpsEnv11 = 'Env 11';
  SpsEnv12 = 'Env 12';
  SpsEnv14 = 'Env 14';
  SpsCSheet = 'C Sheet';
  SpsDSheet = 'D Sheet';
  SpsESheet = 'E Sheet';
  SpsEnvDL = 'Env DL';
  SpsEnvD = 'Env D';
  SpsEnvC3 = 'Env C3';
  SpsEnvC4 = 'Env C4';
  SpsEnvC5 = 'Env C5';
  SpsEnvC6 = 'Env C6';
  SpsEnvC65 = 'Env C65';
  SpsEnvB4 = 'Env B4';
  SpsEnvB5 = 'Env B5';
  SpsEnvB6 = 'Env B6';
  SpsEnvItaly = 'Env Italy';
  SpsEnvMonarch = 'Env Monarch';
  SpsEnvPersonal = 'Env Personal';
  SpsFanfoldUS = 'Fanfold US';
  SpsFanfoldStdGerman = 'Fanfold Std German';
  SpsISOB4 = 'ISO B4';
  SpsCustom = 'Custom';
  SPreferences = 'Preferences';
  SContent = 'Content';
  SBackground = 'Background';
  SEMailSettings = 'EMail Settings';
  SlblPageExample = 'Enter page numbers and/or page ranges separated by commas. For example, 1,3,5-12';
  SlblDefaultDocFont = 'Default Document Font:';

{$IFNDEF gtActiveX}
{----Plain Sheet Dialog--------------------------------------------------------}

  SchkActiveHyperLinks = 'Active HyperLinks';
  SQualityScaling = 'Quality & Scaling';


{----Spread Sheet Dialog-------------------------------------------------------}

  StsFormatting = 'Formatting';
  SchkAutoFormatCells = 'Auto Format Cells';
  SlblColumnSpacing = 'Column Spacing:';
  SlblNumberFormatDecimalPlaces = 'Number Format Decimal Places';
  SlblRowSpacing = 'Row Spacing:';
  SchkApplyAlignment = 'Apply Alignment';
  SlblScaleX = 'Scale X:';
  SlblScaleY = 'Scale Y:';
  SlblFormatting = 'Formatting';

{----Graphics Dialog-----------------------------------------------------------}

  StsQualityAndScaling = 'Quality And Scaling';
  SchkMonochrome = 'Monochrome';
  SlblPixelFormat = 'Pixel Format:';

{----PDF Dialog----------------------------------------------------------------}

  SPDFDlgCaption = 'PDF Setup';
  StsPDFAdvanced = 'Advanced';
  SchkCompressDocument = 'Compress Document';
  SlblCompressionLevel = 'Compression Level:';
  SchkEnableEncryption = 'Encrypt Document';
  SlblOwnerPassword = 'Owner Password:';
  SlblConfirmOwnerPassword = 'Confirm Owner Password:';
  SlblUserPassword = 'User Password:';
  SlblConfirmUserPassword = 'Confirm User Password:';
  SlblEncryptionLevel = 'Level:';
  SgbUserPermissions = 'User Permissions';
  SchkCopy = 'Copy';
  SchkModify = 'Modify';
  SchkPrint = 'Print';
  SchkFormFill = 'Form Fill';
  SchkAnnotation = 'Annotation';
  SchkAccessibility = 'Accessibility';
  SchkDocumentAssembly = 'Document Assembly';
  SchkHighResolutionPrint = 'High Resolution Print';
  SlblFontEncoding = 'Font Encoding:';

  StsViewerPreferences = 'Viewer Preferences';
  SlblPageLayout = 'Page Layout:';
  SlblPageMode = 'Page Mode:';
  SgbHideUIElements = 'Hide UI Elements';
  SchkMenuBar = 'Menu Bar';
  SchkToolBar = 'Tool Bar';
  SchkNavigationControls = 'Navigation Controls';
  SgbPresentationMode = 'Presentation Mode';
  SlblPageTransitionEffect = 'Page Transition Effect:';
  SlblPageTransitionDuration = 'Page Transition Duration:';
  SrgpEmbedTrueTypeFonts = 'Embed Used TrueType Fonts';
  SPasswordMissMatch = 'The %s Passwords do not match.' + #13#10 + 'Please re-enter.';

  SchkDigitallySignDocument = 'Digitally Sign Document';
  SpgtFieldProperties = 'Field Properties';
  SlblFieldName = 'Field Name:';
  SchkFieldVisibleOnPage = 'Field Visible On Page';
  SlblFieldPage = 'Field Page #:';
  SlblFieldBounds = 'Field Bounds (%s):';
  SlblFieldLeft = 'Left';
  SlblFieldTop = 'Top';
  SlblFieldRight = 'Right';
  SlblFieldBottem = 'Bottom';
  SlblFillColor = 'Fill Color:';
  SgbAppearenceText = 'Appearence Text';
  SchkShowName = 'Show Name';
  SchkShowReason = 'Show Reason';
  SchkShowLocation = 'Show Location';
  SchkShowDate = 'Show Date';
  SchkShowLabels = 'Show Labels';
  SpgtSignatureProperties = 'Signature Properties';
  SlblCertFileName = 'Certificate File:';
  SlblCertPassword = 'Certificate Password:';
  SlblConfirmPassword = 'Confirm Password:';
  SlblContactInformation = 'Contact Information:';
  SlblReason = 'Reason:';
  SlblLocation = 'Location:';
  SlblDate = 'Date:';
  SrgDate = 'Date :';
  SrbCurrentSystemDate = 'Current System Date';
  SrbFixed = 'Fixed';

  SmsgDateShouldNotExceed = 'Date should not exceed today';
  SmsgValueShouldBeLessThan = 'Value should be less than 8.25';

  { ---- Measurement Unit Resource Strings ----------------------------------- }
  SUnitTypePixels = 'Pixels';
  SUnitTypeInches = 'Inches';
  SUnitTypeMM = 'mm';
  SUnitTypePoints = 'Points';
  SUnitTypeTwips = 'Twips';




{$ELSE}
var
  {----Plain Sheet Dialog------------------------------------------------------}
  SchkActiveHyperLinks, SQualityScaling: String;

  {----Spread Sheet Dialog-----------------------------------------------------}
  StsFormatting, SchkAutoFormatCells, SlblColumnSpacing, SlblRowSpacing,
  SlblScaleX, SlblScaleY, SlblFormatting: String;

  {----Graphics Dialog---------------------------------------------------------}
  StsQualityAndScaling, SchkMonochrome, SlblPixelFormat: String;

  {----PDF Dialog--------------------------------------------------------------}
  SPDFDlgCaption, StsPDFAdvanced, SchkCompressDocument, SlblCompressionLevel,
  SchkEnableEncryption, SlblOwnerPassword, SlblConfirmOwnerPassword,
  SlblUserPassword, SlblConfirmUserPassword, SlblEncryptionLevel,
  SgbUserPermissions, SchkCopy, SchkModify, SchkPrint, SchkFormFill,
  SchkAnnotation, SchkAccessibility, SchkDocumentAssembly,
  SchkHighResolutionPrint, SlblFontEncoding, StsViewerPreferences,
  SlblPageLayout, SlblPageMode, SgbHideUIElements, SchkMenuBar, SchkToolBar,
  SchkNavigationControls, SgbPresentationMode, SlblPageTransitionEffect,
  SlblPageTransitionDuration, SrgpEmbedTrueTypeFonts, SPasswordMissMatch: String;
{$ENDIF}

resourcestring
  STTFENone = 'None';
  STTFEFull = 'Full';
  STTFESubset = 'Subset';

  SCompressionMethodFastest = 'Fastest';
  SCompressionMethodNormal = 'Normal';
  SCompressionMethodMaximum = 'Maximum';

  SPageLayoutSinglePage = 'Single Page';
  SPageLayoutOneColoumn = 'One Column';
  SPageLayoutTwoColoumnLeft = 'Two Column Left';
  SPageLayoutTwoColoumnRight = 'Two Column Right';

  SPageModeUseNone = 'Use None';
  SPageModeUseOutlines = 'Use Outlines';
  SPageModeUseThumbs = 'Use Thumbs';
  SPageModeFullScreen = 'Full Screen';

  SSplitHorizontalInward = 'Split Horizontal Inward';
  SSplitHorizontalOutward = 'Split Horizontal Outward';
  SSplitVerticalInward = 'Split Vertical Inward';
  SSplitVerticalOutward = 'Split Vertical Outward';
  SBlindsHorizontal = 'Blinds Horizontal';
  SBlindsVertical = 'Blinds Vertical';
  SBoxInward = 'Box Inward';
  SBoxOutward = 'Box Outward';
  SWipeLeftToRight = 'Wipe Left To Right';
  SWipeBottomToTop = 'Wipe Bottom To Top';
  SWipeRightToLeft = 'Wipe Right To Left';
  SWipeTopToBottom = 'Wipe Top To Bottom';
  SDissolve = 'Dissolve';
  SGlitterLeftToRight = 'Glitter Left To Right';
  SGlitterTopToBottom = 'Glitter Top To Bottom';
  SGlitterTopLeftToBottomRight = 'Glitter Top-Left To Bottom-Right';
  SNone = 'None';

  Sel40Bit = '40 Bit';
  Sel128Bit = '128 Bit';

{----RTF Dialog----------------------------------------------------------------}

{$IFNDEF gtActiveX}
  SRTFDlgCaption = 'RTF Setup';
  SchkGraphicDataInBinary = 'Graphic Data In Binary';
  SrgpEncodingType = 'Encoding Type';
{$ELSE}
var
  SRTFDlgCaption, SchkGraphicDataInBinary, SrgpEncodingType: String;
{$ENDIF}

resourcestring
  SetPositionalAccuracy = 'Positional Accuracy';
  SetEaseOfEditing = 'Ease Of Editing';

{----HTML Dialog---------------------------------------------------------------}

{$IFNDEF gtActiveX}
  SHTMLDlgCaption = 'HTML Setup';
  SchkAutoScrollDocument = 'Auto Scroll Document';
  StsFileLocationAndOptimization = 'File Location && Optimization';
  SchkOptimizeforIE = 'Optimize For Internet Explorer';
  SlblCSSFile = 'CSS File:';
  SsbtnCSSFileName = '...';
  SchkOutputStylesToCSSFile = 'Output Style To CSS File';
  SchkPageEndLines = 'Page End Lines';
  SlblJSFile = 'JS File:';
  SsbtnJSFileName = '...';
  SchkOutputScriptsToJSFile = 'Output Script To JavaScript File';
  StsNavigatorOptions = 'Navigator Options';
  SlblNavigatorBackgroundColor = 'Navigator Background Color:';
  SlblHoverForeColor = 'Navigator Hover Foreground Color:';
  SlblHoverBackColor = 'Navigator Hover Background Color:';
  SlblNavigatorType = 'Navigator Type:';
  SlblNavigatorOrientation = 'Navigator Orientation:';
  SlblNavigatorPosition = 'Navigator Position:';
  StsUseTextLinks = 'Use Text Links';
  SlblFirst = 'First:';
  SlblLast = 'Last:';
  SlblNext = 'Next:';
  SlblPrevious = 'Previous:';
  SlblLinkCaptions = 'Link Captions:';
  SbtnSetFont = 'Set Font';
  StsUseGraphicLinks = 'Use Graphic Links';
  SlblUseGraphicLinksFirst = 'First:';
  SlblUseGraphicLinksPrevious = 'Previous:';
  SlblUseGraphicLinksNext = 'Next:';
  SlblUseGraphicLinksLast = 'Last:';
  SsbtnFirst = '...';
  SsbtnPrevious = '...';
  SsbtnNext = '...';
  SsbtnLast = '...';
  SlblImageSource = 'Image Source:';
  SrbtnUseTextLinks = 'Use Text Links';
  SrbtnUseGraphicLinks = 'Use Graphic Links';
  SchkShowNavigator = 'Show Navigator';
  SchkSingleFile = 'Single File';
  StsTOCPageSettings = 'TOC Page Settings';
  SlblDefaultFont = 'Default Font:';
  SlblItemFont = 'Item Font:';
  SlblTOCTitle = 'TOC Title:';
  SlblAlignment = 'Alignment:';
  SlblTitleFont = 'Title Font:';
	SOpenDialogFilterJSSFile = 'Java Script File Name (*.js)|*.js';
	SOpenDialogFilterCSSFile = 'Cascaded Style Sheets (*.css)|*.css';
{$ELSE}
var
  SHTMLDlgCaption, SchkAutoScrollDocument, StsFileLocationAndOptimization,
  SchkOptimizeforIE, SlblCSSFile, SsbtnCSSFileName, SchkOutputStylesToCSSFile,
  SchkPageEndLines, SlblJSFile, SsbtnJSFileName, SchkOutputScriptsToJSFile,
  StsNavigatorOptions, SlblNavigatorBackgroundColor, SlblHoverForeColor,
  SlblHoverBackColor, SlblNavigatorType, SlblNavigatorOrientation,
  SlblNavigatorPosition, StsUseTextLinks, SlblFirst, SlblLast, SlblNext,
  SlblPrevious, SlblLinkCaptions, SbtnSetFont, StsUseGraphicLinks,
  SlblUseGraphicLinksFirst, SlblUseGraphicLinksPrevious, SlblUseGraphicLinksNext,
  SlblUseGraphicLinksLast, SsbtnFirst, SsbtnPrevious, SsbtnNext, SsbtnLast,
  SlblImageSource, SrbtnUseTextLinks, SrbtnUseGraphicLinks, SchkShowNavigator,
  SchkSingleFile, StsTOCPageSettings, SlblDefaultFont, SlblItemFont,
  SlblTOCTitle, SlblAlignment, SlblTitleFont, SOpenDialogFilterJSSFile,
  SOpenDialogFilterCSSFile: String;
{$ENDIF}

resourcestring
  SntFixedToScreen = 'Fixed To Screen';
  SntFixedToPage = 'Fixed To Page';

  SnoHorizontal = 'Horizontal';
  SnoVertical = 'Vertical';

  SnpTopLeft = 'Top Left';
  SnpTopCenter = 'Top Center';
  SnpTopRight = 'Top Right';
  SnpCenterLeft = 'Center Left';
  SnpCenter = 'Center';
  SnpCenterRight = 'Center Right';
  SnpBottomLeft = 'Bottom Left';
  SnpBottomCenter = 'Bottom Center';
  SnpBottomRight = 'Bottom Right';

  ShaLeft = 'Left';
  ShaRight = 'Right';
  ShaCenter = 'Center';
  ShaJustify = 'Justify';
  ShaGeneral = 'General';

  SlbDocumentDlgFileSettings = 'File Settings';
  SlbDocumentDlgNavigatorOptions = 'Navigator Options';
  SlbDocumentDlgTOCPageSettings = 'TOC Page Settings';

{$IFNDEF gtActiveX}
{----XHTML Dialog--------------------------------------------------------------}

  SXHTMLDlgCaption = 'XHTML Setup';

{----SVG Dialog----------------------------------------------------------------}

  SSVGDlgCaption = 'SVG Setup';

{----Text Dialog---------------------------------------------------------------}

  STXTDlgCaption = 'Text Setup';
  StsTextFormatting = 'Formatting';
  SlblTextLineSpacing = 'Line Spacing:';
  SlblTextColumnSpacing = 'Column Spacing:';
  SchkSeparatorMode = 'Separator Mode';
  SlblSeparator = 'Separator:';
  SlblTextDefaultFont = 'Default Document Font:';
  SchkTextPageEndLines = 'Page End Lines';
  SchkInsertPageBreaks = 'Insert Page Breaks';
  SchkTextSingleFile = 'Single File';
{$ELSE}
var
  SXHTMLDlgCaption, SSVGDlgCaption, STXTDlgCaption, StsTextFormatting,
  SlblTextLineSpacing, SlblTextColumnSpacing, SchkSeparatorMode, SlblSeparator,
  SlblTextDefaultFont, SchkTextPageEndLines, SchkInsertPageBreaks,
  SchkTextSingleFile: String;
{$ENDIF}

resourcestring
  SlsActual = 'Actual';
  SlsOneBlank = 'One Blank';
  SlsTwoBlank = 'Two Blank';
  SlsThreeBlank = 'Three Blank';
  SlsFourBlank = 'Four Blank';
  SlsFiveBlank = 'Five Blank';

{$IFNDEF gtActiveX}
{----Excel Dialog--------------------------------------------------------------}

  SXLSDlgCaption = 'Excel Setup';
  SlblPagesPerWorkSheet = 'Pages Per WorkSheet:';
  SchkPageMargins = 'Page Margins';
  SchkPrintGridLines = 'Print Grid Lines';

{----Quattro Pro Dialog--------------------------------------------------------}

  SQProDlgCaption = 'Quattro Pro Setup';

{----DIF Dialog----------------------------------------------------------------}

  SDIFDlgCaption = 'DIF Setup';

{----Lotus Dialog--------------------------------------------------------------}

  SLotusDlgCaption = 'Lotus Setup';

{----SYLK Dialog---------------------------------------------------------------}

  SSLKDlgCaption = 'SYLK Setup';

{----BMP Dialog----------------------------------------------------------------}

  SBMPDlgCaption = 'BMP Setup';

{----JPEG Dialog---------------------------------------------------------------}

  SJPEGDlgCaption = 'JPEG Setup';

  SchkProgressiveEncoding = 'Progressive Encoding';
  SlblQuality = 'Quality:';

{----GIF Dialog----------------------------------------------------------------}

  SGIFDlgCaption = 'GIF Setup';

{----EMF Dialog----------------------------------------------------------------}

  SEMFDlgCaption = 'EMF Setup';

{----WMF Dialog----------------------------------------------------------------}

  SWMFDlgCaption = 'WMF Setup';

{----TIFF Dialog---------------------------------------------------------------}

  STIFFDlgCaption = 'TIFF Setup';
  SchkGrayscale = 'Grayscale';
  SchkMultiPage = 'Multi-Page';
  SlblCompressionType = 'Compression Type:';
{$ELSE}
var
  SXLSDlgCaption, SlblPagesPerWorkSheet, SchkPageMargins,
  SchkPrintGridLines, SQProDlgCaption, SDIFDlgCaption, SLotusDlgCaption,
  SSLKDlgCaption, SBMPDlgCaption, SJPEGDlgCaption, SchkProgressiveEncoding,
  SlblQuality, SGIFDlgCaption, SEMFDlgCaption, SWMFDlgCaption,
  STIFFDlgCaption, SchkGrayscale, SchkMultiPage, SlblCompressionType: String;
{$ENDIF}

resourcestring
  SctNone = 'None';
  SctRLE = 'Pack Bits';
  SctLZW = 'Zip';
  SctCCITT3 = 'CCITT3';
  SctCCITT4 = 'CCITT4';

{----PNG Dialog----------------------------------------------------------------}

{$IFNDEF gtActiveX}
  SPNGDlgCaption = 'PNG Setup';
  SlblColorType = 'Color Type:';
  SchkPixelDimensions = 'Pixel Dimensions';
  SlblXPixelsPerUnit = 'X Pixels Per Unit:';
  SlblYPixelsPerUnit = 'Y Pixels Per Unit:';
  SlblUnitSpecifier = 'Unit Specifier:';
  SchkTransparency = 'Transparency';
  SlblImageAlpha = 'Image Alpha:';
  SlblTransparencyColor = 'Transparency Color:';
{$ELSE}
var
  SPNGDlgCaption, SlblColorType, SchkPixelDimensions, SlblXPixelsPerUnit,
  SlblYPixelsPerUnit, SlblUnitSpecifier, SchkTransparency, SlblImageAlpha,
  SlblTransparencyColor: String;
{$ENDIF}

resourcestring
  SctGrayscale = 'Grayscale';
  SctRGB = 'RGB';
  SctRGBA = 'RGB With Alpha';
  SctGrayAlpha = 'Grayscale With Alpha';

  SusNone = 'None';
  SusMeter = 'Meter';

{ ------------------------- Hyperlink Strings ---------------------------------}

  Shttp = 'http://';
  Sftp = 'ftp://';
  Swww = 'www.';

{$IFNDEF gtActiveX}
{----Image Preview Dialog------------------------------------------------------}
  SImgPrvwDlgCaption = 'Preview';
{$ELSE}
var
  SImgPrvwDlgCaption: String;
{$ENDIF}

{ ------------------------- HTML Engine ---------------------------------------}
resourcestring
	// Link text
  SLinkTextTOC = ']';       // Wingdings '¯', '&', ']' can be used for TOC
	SLinkTextFirst = 'Ù';			// Wingdings
	SLinkTextPrev = '×';			// Wingdings
	SLinkTextNext = 'Ø';			// Wingdings
	SLinkTextLast = 'Ú';			// Wingdings

{$IFNDEF gtActiveX}
	// Link Hint (only appears in IE)
  STitleTextTOC = 'Table Of Contents';
	STitleTextFirst = 'First';
	STitleTextPrev = 'Previous';
	STitleTextNext = 'Next';
	STitleTextLast = 'Last';

{ ------------------------- Filter Description --------------------------------}
  SPDFDescription = 'Adobe PDF Files';
  SRTFDescription = 'Rich Text Format';
  SBMPDescription = 'Windows Bitmap';
  STIFFDescription = 'Tagged Image File Format';
  SPNGDescription = 'Portable Network Graphics';
  SJPEGDescription = 'JPEG File Interchange Format';
  SWMFDescription = 'Windows Metafiles';
  SEMFDescription = 'Enhanced Metafiles';
  SGIFDescription = 'Graphics Interchange Format';
  SSVGDescription = 'Scalable Vector Graphics';
  SHTMLDescription = 'HyperText Markup Language';
  SXHTMLDescription = 'Extended HyperText Markup Language';
  SExcelDescription = 'Microsoft Excel Workbook';
  SQuattroProDescription = 'Quattro Pro for Windows';
  SLotusDescription = 'Lotus 1-2-3';
  SDIFDescription = 'Data Interchange Format';
  SSYLKDescription = 'Symbolic Link';
	STextDescription = 'Text Document';
  SClipboardDescription = 'Windows Clipboard';

{ ------------------------- Error Descriptions --------------------------------}

	SFileCreateError = 'File could not be created!' + CRLF + CRLF +
		'Possible cause: It could be in use by some other application';
	SInvalidPageNo = 'Invalid Page Number';
	SInvalidEngineState = 'Not a valid Engine State identifier';
	SEMailError = 'Report could not be E-Mailed!' + CRLF + CRLF +
		'Possible cause: Internet/Mail server Connection' +
		' could not be established.' + CRLF + CRLF +
		'Solution: Check Mail server connection properties' +
		' and your Internet connection.';
  SUnsupportedGraphics = 'Unknown Graphics format';
	SUnsupportedPDFImageFormat =
		'The PDF Engine does not support image format';
	SUnsupportedBackgroundDisplayType =
		'The RTF Engine does not support Tile display type';
	SUnsupportedExcelImageFormat =
		'The Excel Engine supports only  BMP and Metafile image formats';
	SUnsupportedRTFImageFormat =
		'The RTF Engine does not support this format';
  STransparencyNotAllowed = 'Transparency Chunk Not Allowed';//PNG
  SUnsupportedSVGImageFormat =
		'The SVG supports only JPEG and PNG image formats';
  //HTML
  SCSSFileCreationError = 'CSS File Creation Error';
  SJSFileCreationError = 'JavaScript File Creation Error';
  SUnsupportedHTMLImageFormat =
  	'HTML Engine does not support this image format';

{$ELSE}
var
  STitleTextTOC, STitleTextFirst, STitleTextPrev, STitleTextNext, STitleTextLast,
  SPDFDescription, SRTFDescription, SBMPDescription, STIFFDescription,
  SPNGDescription, SJPEGDescription, SWMFDescription, SEMFDescription,
  SGIFDescription, SSVGDescription, SHTMLDescription, SXHTMLDescription,
  SExcelDescription, SQuattroProDescription, SLotusDescription,
  SDIFDescription, SSYLKDescription, STextDescription, SClipboardDescription,
  // Error messages
	SFileCreateError, SInvalidPageNo, SInvalidEngineState, SEMailError,
  SUnsupportedGraphics, SUnsupportedPDFImageFormat,
  SUnsupportedBackgroundDisplayType, SUnsupportedExcelImageFormat,
	SUnsupportedRTFImageFormat, STransparencyNotAllowed,
  SUnsupportedSVGImageFormat, SCSSFileCreationError, SJSFileCreationError,
  SUnsupportedHTMLImageFormat: String;
{$ENDIF}

{------------------------------------------------------------------------------}

implementation

end.
