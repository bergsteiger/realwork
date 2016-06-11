{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework Quartz
//

unit Macapi.Quartz;

interface

uses
  Macapi.AppKit,
  Macapi.CocoaTypes,
  Macapi.Foundation,
  Macapi.ObjectiveC,
  Macapi.QuartzCore;

const
  kQCPlugInExecutionModeProvider = 1;
  {$EXTERNALSYM kQCPlugInExecutionModeProvider}
  kQCPlugInExecutionModeProcessor = 2;
  {$EXTERNALSYM kQCPlugInExecutionModeProcessor}
  kQCPlugInExecutionModeConsumer = 3;
  {$EXTERNALSYM kQCPlugInExecutionModeConsumer}
  kQCPlugInTimeModeNone = 0;
  {$EXTERNALSYM kQCPlugInTimeModeNone}
  kQCPlugInTimeModeIdle = 1;
  {$EXTERNALSYM kQCPlugInTimeModeIdle}
  kQCPlugInTimeModeTimeBase = 2;
  {$EXTERNALSYM kQCPlugInTimeModeTimeBase}
  kPDFActionNamedNone = 0;
  {$EXTERNALSYM kPDFActionNamedNone}
  kPDFActionNamedNextPage = 1;
  {$EXTERNALSYM kPDFActionNamedNextPage}
  kPDFActionNamedPreviousPage = 2;
  {$EXTERNALSYM kPDFActionNamedPreviousPage}
  kPDFActionNamedFirstPage = 3;
  {$EXTERNALSYM kPDFActionNamedFirstPage}
  kPDFActionNamedLastPage = 4;
  {$EXTERNALSYM kPDFActionNamedLastPage}
  kPDFActionNamedGoBack = 5;
  {$EXTERNALSYM kPDFActionNamedGoBack}
  kPDFActionNamedGoForward = 6;
  {$EXTERNALSYM kPDFActionNamedGoForward}
  kPDFActionNamedGoToPage = 7;
  {$EXTERNALSYM kPDFActionNamedGoToPage}
  kPDFActionNamedFind = 8;
  {$EXTERNALSYM kPDFActionNamedFind}
  kPDFActionNamedPrint = 9;
  {$EXTERNALSYM kPDFActionNamedPrint}
  kPDFActionNamedZoomIn = 10;
  {$EXTERNALSYM kPDFActionNamedZoomIn}
  kPDFActionNamedZoomOut = 11;
  {$EXTERNALSYM kPDFActionNamedZoomOut}
  kPDFDisplayBoxMediaBox = 0;
  {$EXTERNALSYM kPDFDisplayBoxMediaBox}
  kPDFDisplayBoxCropBox = 1;
  {$EXTERNALSYM kPDFDisplayBoxCropBox}
  kPDFDisplayBoxBleedBox = 2;
  {$EXTERNALSYM kPDFDisplayBoxBleedBox}
  kPDFDisplayBoxTrimBox = 3;
  {$EXTERNALSYM kPDFDisplayBoxTrimBox}
  kPDFDisplayBoxArtBox = 4;
  {$EXTERNALSYM kPDFDisplayBoxArtBox}
  kPDFWidgetUnknownControl = -1;
  {$EXTERNALSYM kPDFWidgetUnknownControl}
  kPDFWidgetPushButtonControl = 0;
  {$EXTERNALSYM kPDFWidgetPushButtonControl}
  kPDFWidgetRadioButtonControl = 1;
  {$EXTERNALSYM kPDFWidgetRadioButtonControl}
  kPDFWidgetCheckBoxControl = 2;
  {$EXTERNALSYM kPDFWidgetCheckBoxControl}
  kPDFLineStyleNone = 0;
  {$EXTERNALSYM kPDFLineStyleNone}
  kPDFLineStyleSquare = 1;
  {$EXTERNALSYM kPDFLineStyleSquare}
  kPDFLineStyleCircle = 2;
  {$EXTERNALSYM kPDFLineStyleCircle}
  kPDFLineStyleDiamond = 3;
  {$EXTERNALSYM kPDFLineStyleDiamond}
  kPDFLineStyleOpenArrow = 4;
  {$EXTERNALSYM kPDFLineStyleOpenArrow}
  kPDFLineStyleClosedArrow = 5;
  {$EXTERNALSYM kPDFLineStyleClosedArrow}
  kPDFMarkupTypeHighlight = 0;
  {$EXTERNALSYM kPDFMarkupTypeHighlight}
  kPDFMarkupTypeStrikeOut = 1;
  {$EXTERNALSYM kPDFMarkupTypeStrikeOut}
  kPDFMarkupTypeUnderline = 2;
  {$EXTERNALSYM kPDFMarkupTypeUnderline}
  kPDFTextAnnotationIconComment = 0;
  {$EXTERNALSYM kPDFTextAnnotationIconComment}
  kPDFTextAnnotationIconKey = 1;
  {$EXTERNALSYM kPDFTextAnnotationIconKey}
  kPDFTextAnnotationIconNote = 2;
  {$EXTERNALSYM kPDFTextAnnotationIconNote}
  kPDFTextAnnotationIconHelp = 3;
  {$EXTERNALSYM kPDFTextAnnotationIconHelp}
  kPDFTextAnnotationIconNewParagraph = 4;
  {$EXTERNALSYM kPDFTextAnnotationIconNewParagraph}
  kPDFTextAnnotationIconParagraph = 5;
  {$EXTERNALSYM kPDFTextAnnotationIconParagraph}
  kPDFTextAnnotationIconInsert = 6;
  {$EXTERNALSYM kPDFTextAnnotationIconInsert}
  kPDFBorderStyleSolid = 0;
  {$EXTERNALSYM kPDFBorderStyleSolid}
  kPDFBorderStyleDashed = 1;
  {$EXTERNALSYM kPDFBorderStyleDashed}
  kPDFBorderStyleBeveled = 2;
  {$EXTERNALSYM kPDFBorderStyleBeveled}
  kPDFBorderStyleInset = 3;
  {$EXTERNALSYM kPDFBorderStyleInset}
  kPDFBorderStyleUnderline = 4;
  {$EXTERNALSYM kPDFBorderStyleUnderline}
  kPDFPrintPageScaleNone = 0;
  {$EXTERNALSYM kPDFPrintPageScaleNone}
  kPDFPrintPageScaleToFit = 1;
  {$EXTERNALSYM kPDFPrintPageScaleToFit}
  kPDFPrintPageScaleDownToFit = 2;
  {$EXTERNALSYM kPDFPrintPageScaleDownToFit}
  kPDFDocumentPermissionsNone = 0;
  {$EXTERNALSYM kPDFDocumentPermissionsNone}
  kPDFDocumentPermissionsUser = 1;
  {$EXTERNALSYM kPDFDocumentPermissionsUser}
  kPDFDocumentPermissionsOwner = 2;
  {$EXTERNALSYM kPDFDocumentPermissionsOwner}
  kPDFDisplaySinglePage = 0;
  {$EXTERNALSYM kPDFDisplaySinglePage}
  kPDFDisplaySinglePageContinuous = 1;
  {$EXTERNALSYM kPDFDisplaySinglePageContinuous}
  kPDFDisplayTwoUp = 2;
  {$EXTERNALSYM kPDFDisplayTwoUp}
  kPDFDisplayTwoUpContinuous = 3;
  {$EXTERNALSYM kPDFDisplayTwoUpContinuous}
  kPDFNoArea = 0;
  {$EXTERNALSYM kPDFNoArea}
  kPDFPageArea = 1;
  {$EXTERNALSYM kPDFPageArea}
  kPDFTextArea = 2;
  {$EXTERNALSYM kPDFTextArea}
  kPDFAnnotationArea = 4;
  {$EXTERNALSYM kPDFAnnotationArea}
  kPDFLinkArea = 8;
  {$EXTERNALSYM kPDFLinkArea}
  kPDFControlArea = 16;
  {$EXTERNALSYM kPDFControlArea}
  kPDFTextFieldArea = 32;
  {$EXTERNALSYM kPDFTextFieldArea}
  kPDFIconArea = 64;
  {$EXTERNALSYM kPDFIconArea}
  kPDFPopupArea = 128;
  {$EXTERNALSYM kPDFPopupArea}
  kPDFInterpolationQualityNone = 0;
  {$EXTERNALSYM kPDFInterpolationQualityNone}
  kPDFInterpolationQualityLow = 1;
  {$EXTERNALSYM kPDFInterpolationQualityLow}
  kPDFInterpolationQualityHigh = 2;
  {$EXTERNALSYM kPDFInterpolationQualityHigh}
  IKCellsStyleNone = 0;
  {$EXTERNALSYM IKCellsStyleNone}
  IKCellsStyleShadowed = 1;
  {$EXTERNALSYM IKCellsStyleShadowed}
  IKCellsStyleOutlined = 2;
  {$EXTERNALSYM IKCellsStyleOutlined}
  IKCellsStyleTitled = 4;
  {$EXTERNALSYM IKCellsStyleTitled}
  IKCellsStyleSubtitled = 8;
  {$EXTERNALSYM IKCellsStyleSubtitled}
  IKGroupBezelStyle = 0;
  {$EXTERNALSYM IKGroupBezelStyle}
  IKGroupDisclosureStyle = 1;
  {$EXTERNALSYM IKGroupDisclosureStyle}
  IKImageBrowserDropOn = 0;
  {$EXTERNALSYM IKImageBrowserDropOn}
  IKImageBrowserDropBefore = 1;
  {$EXTERNALSYM IKImageBrowserDropBefore}
  IKImageStateNoImage = 0;
  {$EXTERNALSYM IKImageStateNoImage}
  IKImageStateInvalid = 1;
  {$EXTERNALSYM IKImageStateInvalid}
  IKImageStateReady = 2;
  {$EXTERNALSYM IKImageStateReady}
  QLPreviewViewStyleNormal = 0;
  {$EXTERNALSYM QLPreviewViewStyleNormal}
  QLPreviewViewStyleCompact = 1;
  {$EXTERNALSYM QLPreviewViewStyleCompact}

type

  // ===== Forward declarations =====
  {$M+}
  QCPlugInContext = interface;
  QCPlugInInputImageSource = interface;
  QCPlugInOutputImageProvider = interface;
  QCPlugIn = interface;
  QCComposition = interface;
  QCCompositionRepository = interface;
  QCCompositionRenderer = interface;
  QCRenderer = interface;
  QCCompositionLayer = interface;
  QCView = interface;
  QCPatchController = interface;
  QCCompositionParameterView = interface;
  QCCompositionParameterViewDelegate = interface;
  QCCompositionPickerView = interface;
  QCCompositionPickerViewDelegate = interface;
  QCCompositionPickerPanel = interface;
  QCPlugInViewController = interface;
  QuartzFilter = interface;
  QuartzFilterView = interface;
  QuartzFilterManager = interface;
  QuartzFilterManagerDelegate = interface;
  PDFAction = interface;
  PDFDestination = interface;
  PDFActionGoTo = interface;
  PDFActionNamed = interface;
  PDFActionResetForm = interface;
  PDFActionRemoteGoTo = interface;
  PDFActionURL = interface;
  PDFDocument = interface;
  PDFAnnotation = interface;
  PDFSelection = interface;
  PDFPage = interface;
  PDFBorder = interface;
  PDFAnnotationPopup = interface;
  PDFAnnotationButtonWidget = interface;
  PDFAnnotationChoiceWidget = interface;
  PDFAnnotationCircle = interface;
  PDFAnnotationFreeText = interface;
  PDFAnnotationInk = interface;
  PDFAnnotationLine = interface;
  PDFAnnotationLink = interface;
  PDFAnnotationMarkup = interface;
  PDFAnnotationSquare = interface;
  PDFAnnotationStamp = interface;
  PDFAnnotationText = interface;
  PDFAnnotationTextWidget = interface;
  PDFOutline = interface;
  PDFDocumentNotifications = interface;
  PDFDocumentDelegate = interface;
  PDFView = interface;
  PDFThumbnailView = interface;
  PDFViewDelegate = interface;
  IKImageBrowserView = interface;
  IKImageBrowserCell = interface;
  IKImageBrowserDataSource = interface;
  IKImageBrowserItem = interface;
  IKImageBrowserDelegate = interface;
  IKPictureTaker = interface;
  IKFilterUIView = interface;
  IKFilterUIAddition = interface;
  IKFilterCustomUIProvider = interface;
  IKFilterBrowserView = interface;
  IKFilterBrowserPanel = interface;
  IKSlideshowDataSource = interface;
  IKSlideshow = interface;
  IKSaveOptions = interface;
  IKSaveOptionsDelegate = interface;
  IKImageView = interface;
  IKImageEditPanel = interface;
  IKImageEditPanelDataSource = interface;
  QLPreviewItem = interface;
  QLPreviewConvenienceAdditions = interface;
  QLPreviewPanelDelegate = interface;
  QLPreviewPanelDataSource = interface;
  QLPreviewPanel = interface;
  QLPreviewPanelController = interface;
  QLPreviewView = interface;

  // ===== Framework typedefs =====
  {$M+}
  QCPlugInExecutionMode = Cardinal;
  {$EXTERNALSYM QCPlugInExecutionMode}
  QCPlugInTimeMode = Cardinal;
  {$EXTERNALSYM QCPlugInTimeMode}
  QCPlugInBufferReleaseCallback = procedure(param1: Pointer; param2: Pointer); cdecl;
  QCPlugInTextureReleaseCallback = procedure(param1: CGLContextObj; param2: GLuint; param3: Pointer); cdecl;
  PDFActionNamedName = NSInteger;
  {$EXTERNALSYM PDFActionNamedName}
  PDFDisplayBox = NSInteger;
  {$EXTERNALSYM PDFDisplayBox}
  PDFWidgetControlType = NSInteger;
  {$EXTERNALSYM PDFWidgetControlType}
  PDFLineStyle = NSInteger;
  {$EXTERNALSYM PDFLineStyle}
  PDFMarkupType = NSInteger;
  {$EXTERNALSYM PDFMarkupType}
  PDFTextAnnotationIconType = NSInteger;
  {$EXTERNALSYM PDFTextAnnotationIconType}
  PDFBorderStyle = NSInteger;
  {$EXTERNALSYM PDFBorderStyle}
  PDFPrintScalingMode = NSInteger;
  {$EXTERNALSYM PDFPrintScalingMode}
  PDFDocumentPermissions = NSInteger;
  {$EXTERNALSYM PDFDocumentPermissions}
  PDFDisplayMode = NSInteger;
  {$EXTERNALSYM PDFDisplayMode}
  PDFAreaOfInterest = NSInteger;
  {$EXTERNALSYM PDFAreaOfInterest}
  PDFInterpolationQuality = NSInteger;
  {$EXTERNALSYM PDFInterpolationQuality}
  IKImageBrowserDropOperation = Cardinal;
  {$EXTERNALSYM IKImageBrowserDropOperation}
  IKImageBrowserCellState = Cardinal;
  {$EXTERNALSYM IKImageBrowserCellState}
  QLPreviewViewStyle = NSUInteger;
  {$EXTERNALSYM QLPreviewViewStyle}
  // ===== Interface declarations =====

  QCPlugInClass = interface(NSObjectClass)
    ['{A379AAC3-146E-45B9-BF99-B174E9D23AC2}']
    {class} function attributes: NSDictionary; cdecl;
    {class} function attributesForPropertyPortWithKey(key: NSString): NSDictionary; cdecl;
    {class} function sortedPropertyPortKeys: NSArray; cdecl;
    {class} function executionMode: QCPlugInExecutionMode; cdecl;
    {class} function timeMode: QCPlugInTimeMode; cdecl;
    {class} function plugInKeys: NSArray; cdecl;
    {class} function loadPlugInAtPath(path: NSString): Boolean; cdecl;
    {class} procedure registerPlugInClass(aClass: Pointer); cdecl;
  end;
  QCPlugIn = interface(NSObject)
    ['{625EA5B6-BAA9-451D-A8C7-68B881379EA2}']
    function startExecution(context: Pointer): Boolean; cdecl;
    procedure enableExecution(context: Pointer); cdecl;
    function executionTimeForContext(context: Pointer; atTime: NSTimeInterval; withArguments: NSDictionary)
      : NSTimeInterval; cdecl;
    function execute(context: Pointer; atTime: NSTimeInterval; withArguments: NSDictionary): Boolean; cdecl;
    procedure disableExecution(context: Pointer); cdecl;
    procedure stopExecution(context: Pointer); cdecl;
    function serializedValueForKey(key: NSString): Pointer; cdecl;
    procedure setSerializedValue(serializedValue: Pointer; forKey: NSString); cdecl;
    function didValueForInputKeyChange(key: NSString): Boolean; cdecl;
    function valueForInputKey(key: NSString): Pointer; cdecl;
    function setValue(value: Pointer; forOutputKey: NSString): Boolean; cdecl;
    procedure addInputPortWithType(&type: NSString; forKey: NSString; withAttributes: NSDictionary); cdecl;
    procedure removeInputPortForKey(key: NSString); cdecl;
    procedure addOutputPortWithType(&type: NSString; forKey: NSString; withAttributes: NSDictionary); cdecl;
    procedure removeOutputPortForKey(key: NSString); cdecl;
    function createViewController: QCPlugInViewController; cdecl;
  end;

  TQCPlugIn = class(TOCGenericImport<QCPlugInClass, QCPlugIn>)
  end;
  PQCPlugIn = Pointer;

  QCCompositionClass = interface(NSObjectClass)
    ['{6DD25DEE-03BC-47AD-A7AD-8E9A75A72617}']
    {class} function compositionWithFile(path: NSString): QCComposition; cdecl;
    {class} function compositionWithData(data: NSData): QCComposition; cdecl;
  end;
  QCComposition = interface(NSObject)
    ['{1A6A9D01-8D3F-4B62-BD47-0C25F53888F7}']
    function protocols: NSArray; cdecl;
    function attributes: NSDictionary; cdecl;
    function inputKeys: NSArray; cdecl;
    function outputKeys: NSArray; cdecl;
    function identifier: NSString; cdecl;
  end;

  TQCComposition = class(TOCGenericImport<QCCompositionClass, QCComposition>)
  end;
  PQCComposition = Pointer;

  QCCompositionRepositoryClass = interface(NSObjectClass)
    ['{92E66EF6-EB45-49B5-BCF7-53024E18735D}']
    {class} function sharedCompositionRepository: QCCompositionRepository; cdecl;
  end;
  QCCompositionRepository = interface(NSObject)
    ['{08F9DA24-EFE5-47F9-BA7E-7C5C5A8517FC}']
    function compositionWithIdentifier(identifier: NSString): QCComposition; cdecl;
    function compositionsWithProtocols(protocols: NSArray; andAttributes: NSDictionary): NSArray; cdecl;
    function allCompositions: NSArray; cdecl;
  end;

  TQCCompositionRepository = class(TOCGenericImport<QCCompositionRepositoryClass, QCCompositionRepository>)
  end;
  PQCCompositionRepository = Pointer;

  QCRendererClass = interface(NSObjectClass)
    ['{6A0292BB-EC36-4B13-AF9F-5FAE5D0477D0}']
  end;
  QCRenderer = interface(NSObject)
    ['{3A1DFE33-FCF3-48FB-AAEE-EE9499D34C0D}']
    function initWithComposition(composition: QCComposition; colorSpace: CGColorSpaceRef): Pointer; cdecl;
    function initWithCGLContext(context: CGLContextObj; pixelFormat: CGLPixelFormatObj; colorSpace: CGColorSpaceRef;
      composition: QCComposition): Pointer; cdecl;
    function initOffScreenWithSize(size: NSSize; colorSpace: CGColorSpaceRef; composition: QCComposition)
      : Pointer; cdecl;
    function initWithOpenGLContext(context: NSOpenGLContext; pixelFormat: NSOpenGLPixelFormat; &file: NSString)
      : Pointer; cdecl;
    function renderAtTime(time: NSTimeInterval; arguments: NSDictionary): Boolean; cdecl;
    function renderingTimeForTime(time: NSTimeInterval; arguments: NSDictionary): NSTimeInterval; cdecl;
    function composition: QCComposition; cdecl;
    function snapshotImage: NSImage; cdecl;
    function createSnapshotImageOfType(&type: NSString): Pointer; cdecl;
  end;

  TQCRenderer = class(TOCGenericImport<QCRendererClass, QCRenderer>)
  end;
  PQCRenderer = Pointer;

  QCCompositionLayerClass = interface(CAOpenGLLayerClass)
    ['{1E61C161-5090-453A-80B9-43EEBB51E172}']
    {class} function compositionLayerWithFile(path: NSString): QCCompositionLayer; cdecl;
    {class} function compositionLayerWithComposition(composition: QCComposition): QCCompositionLayer; cdecl;
  end;
  QCCompositionLayer = interface(CAOpenGLLayer)
    ['{3ACAABCD-A04F-4F18-9218-B6AB82C96601}']
    function initWithFile(path: NSString): Pointer; cdecl;
    function initWithComposition(composition: QCComposition): Pointer; cdecl;
    function composition: QCComposition; cdecl;
  end;

  TQCCompositionLayer = class(TOCGenericImport<QCCompositionLayerClass, QCCompositionLayer>)
  end;
  PQCCompositionLayer = Pointer;

  QCViewClass = interface(NSViewClass)
    ['{C23E88B6-0253-47FE-8E19-F0FC232E2B41}']
  end;
  QCView = interface(NSView)
    ['{5FCF2C67-9DC9-45EF-8C7D-F4064E9FF82B}']
    function loadCompositionFromFile(path: NSString): Boolean; cdecl;
    function loadComposition(composition: QCComposition): Boolean; cdecl;
    function loadedComposition: QCComposition; cdecl;
    procedure unloadComposition; cdecl;
    procedure setAutostartsRendering(flag: Boolean); cdecl;
    function autostartsRendering: Boolean; cdecl;
    procedure setEraseColor(color: NSColor); cdecl;
    function eraseColor: NSColor; cdecl;
    procedure setEventForwardingMask(mask: NSUInteger); cdecl;
    function eventForwardingMask: NSUInteger; cdecl;
    procedure setMaxRenderingFrameRate(maxFPS: Single); cdecl;
    function maxRenderingFrameRate: Single; cdecl;
    procedure erase; cdecl;
    function startRendering: Boolean; cdecl;
    function renderAtTime(time: NSTimeInterval; arguments: NSDictionary): Boolean; cdecl;
    procedure pauseRendering; cdecl;
    function isPausedRendering: Boolean; cdecl;
    procedure resumeRendering; cdecl;
    procedure stopRendering; cdecl;
    function isRendering: Boolean; cdecl;
    function snapshotImage: NSImage; cdecl;
    function createSnapshotImageOfType(&type: NSString): Pointer; cdecl;
    function openGLContext: NSOpenGLContext; cdecl;
    function openGLPixelFormat: NSOpenGLPixelFormat; cdecl;
    procedure start(sender: Pointer); cdecl;
    procedure stop(sender: Pointer); cdecl;
    procedure play(sender: Pointer); cdecl;
  end;

  TQCView = class(TOCGenericImport<QCViewClass, QCView>)
  end;
  PQCView = Pointer;

  QCPatchControllerClass = interface(NSControllerClass)
    ['{2A017CFF-0F68-4C10-9E49-0D951D1DA0E9}']
  end;
  QCPatchController = interface(NSController)
    ['{500B1274-B4CA-4424-8601-1B853AD59E94}']
  end;

  TQCPatchController = class(TOCGenericImport<QCPatchControllerClass, QCPatchController>)
  end;
  PQCPatchController = Pointer;

  QCCompositionParameterViewClass = interface(NSViewClass)
    ['{300B9B8D-FE5A-4ECA-AD28-4623BCF121B4}']
  end;
  QCCompositionParameterView = interface(NSView)
    ['{9256D213-8C1E-45C6-B1D6-C49C091038B2}']
    procedure setCompositionRenderer(renderer: Pointer); cdecl;
    function compositionRenderer: Pointer; cdecl;
    function hasParameters: Boolean; cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    function backgroundColor: NSColor; cdecl;
    procedure setDrawsBackground(flag: Boolean); cdecl;
    function drawsBackground: Boolean; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    function delegate: Pointer; cdecl;
  end;

  TQCCompositionParameterView = class(TOCGenericImport<QCCompositionParameterViewClass, QCCompositionParameterView>)
  end;
  PQCCompositionParameterView = Pointer;

  QCCompositionParameterViewDelegate = interface(IObjectiveC)
    ['{75CEEECF-A384-477D-902F-83FB1C03C24C}']
    [MethodName('compositionParameterView:shouldDisplayParameterWithKey:attributes:')]
    function compositionParameterViewShouldDisplayParameterWithKeyAttributes(parameterView: QCCompositionParameterView;
      shouldDisplayParameterWithKey: NSString; attributes: NSDictionary): Boolean; cdecl;
    [MethodName('compositionParameterView:didChangeParameterWithKey:')]
    procedure compositionParameterViewDidChangeParameterWithKey(parameterView: QCCompositionParameterView;
      didChangeParameterWithKey: NSString); cdecl;
  end;

  QCCompositionPickerViewClass = interface(NSViewClass)
    ['{50CF7E19-1D4A-4449-A6FD-F4CF5AFFD7DA}']
  end;
  QCCompositionPickerView = interface(NSView)
    ['{DC3C8728-0453-43AE-93ED-5BCEE7CAAA12}']
    procedure setCompositionsFromRepositoryWithProtocol(protocol: NSString; andAttributes: NSDictionary); cdecl;
    function compositions: NSArray; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    function delegate: Pointer; cdecl;
    procedure setShowsCompositionNames(flag: Boolean); cdecl;
    function showsCompositionNames: Boolean; cdecl;
    procedure setAllowsEmptySelection(flag: Boolean); cdecl;
    function allowsEmptySelection: Boolean; cdecl;
    procedure setCompositionAspectRatio(ratio: NSSize); cdecl;
    function compositionAspectRatio: NSSize; cdecl;
    procedure setDefaultValue(value: Pointer; forInputKey: NSString); cdecl;
    procedure resetDefaultInputValues; cdecl;
    procedure setSelectedComposition(composition: QCComposition); cdecl;
    function selectedComposition: QCComposition; cdecl;
    procedure startAnimation(sender: Pointer); cdecl;
    procedure stopAnimation(sender: Pointer); cdecl;
    function isAnimating: Boolean; cdecl;
    procedure setMaxAnimationFrameRate(maxFPS: Single); cdecl;
    function maxAnimationFrameRate: Single; cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    function backgroundColor: NSColor; cdecl;
    procedure setDrawsBackground(flag: Boolean); cdecl;
    function drawsBackground: Boolean; cdecl;
    function numberOfColumns: NSUInteger; cdecl;
    procedure setNumberOfColumns(columns: NSUInteger); cdecl;
    function numberOfRows: NSUInteger; cdecl;
    procedure setNumberOfRows(rows: NSUInteger); cdecl;
  end;

  TQCCompositionPickerView = class(TOCGenericImport<QCCompositionPickerViewClass, QCCompositionPickerView>)
  end;
  PQCCompositionPickerView = Pointer;

  QCCompositionPickerViewDelegate = interface(IObjectiveC)
    ['{2F71DBB3-80B6-433D-9F2A-5693C0B22C20}']
    procedure compositionPickerView(pickerView: QCCompositionPickerView; didSelectComposition: QCComposition); cdecl;
    procedure compositionPickerViewDidStartAnimating(pickerView: QCCompositionPickerView); cdecl;
    procedure compositionPickerViewWillStopAnimating(pickerView: QCCompositionPickerView); cdecl;
  end;

  QCCompositionPickerPanelClass = interface(NSPanelClass)
    ['{0A03248E-A511-44D5-BDC3-7518F8DF4D54}']
    {class} function sharedCompositionPickerPanel: QCCompositionPickerPanel; cdecl;
  end;
  QCCompositionPickerPanel = interface(NSPanel)
    ['{19A48D3E-4C15-43E7-93E1-28D647A3C24E}']
    function compositionPickerView: QCCompositionPickerView; cdecl;
  end;

  TQCCompositionPickerPanel = class(TOCGenericImport<QCCompositionPickerPanelClass, QCCompositionPickerPanel>)
  end;
  PQCCompositionPickerPanel = Pointer;

  QCPlugInViewControllerClass = interface(NSViewControllerClass)
    ['{767F020A-BA75-4381-8E3A-ACD0899815B8}']
  end;
  QCPlugInViewController = interface(NSViewController)
    ['{E90D4604-3A2C-4C19-A11B-AD366BB5E854}']
    function initWithPlugIn(plugIn: QCPlugIn; viewNibName: NSString): Pointer; cdecl;
    function plugIn: QCPlugIn; cdecl;
  end;

  TQCPlugInViewController = class(TOCGenericImport<QCPlugInViewControllerClass, QCPlugInViewController>)
  end;
  PQCPlugInViewController = Pointer;

  QuartzFilterClass = interface(NSObjectClass)
    ['{CCE7A464-D8D1-4982-966B-B6AE694032C3}']
    {class} function quartzFilterWithURL(aURL: NSURL): QuartzFilter; cdecl;
    {class} function quartzFilterWithProperties(properties: NSDictionary): QuartzFilter; cdecl;
    {class} function quartzFilterWithOutputIntents(outputIntents: NSArray): QuartzFilter; cdecl;
  end;
  QuartzFilter = interface(NSObject)
    ['{01BA66E0-D24B-4915-9C08-4D332D40A04A}']
    function properties: NSDictionary; cdecl;
    function url: NSURL; cdecl;
    function localizedName: NSString; cdecl;
    function applyToContext(aContext: CGContextRef): Boolean; cdecl;
    procedure removeFromContext(aContext: CGContextRef); cdecl;
  end;

  TQuartzFilter = class(TOCGenericImport<QuartzFilterClass, QuartzFilter>)
  end;
  PQuartzFilter = Pointer;

  QuartzFilterViewClass = interface(NSViewClass)
    ['{A74FC96C-56D6-4599-8E02-2A576A25357B}']
  end;
  QuartzFilterView = interface(NSView)
    ['{968237FB-8CBA-435A-A546-E43BF88EE04D}']
    procedure sizeToFit; cdecl;
  end;

  TQuartzFilterView = class(TOCGenericImport<QuartzFilterViewClass, QuartzFilterView>)
  end;
  PQuartzFilterView = Pointer;

  QuartzFilterManagerClass = interface(NSObjectClass)
    ['{02EE46BC-436D-41A1-AC98-9B175997D6A3}']
    {class} function filterManager: QuartzFilterManager; cdecl;
    {class} function filtersInDomains(domains: NSArray): NSArray; cdecl;
  end;
  QuartzFilterManager = interface(NSObject)
    ['{5EE64C92-D89A-4C5C-840A-78CD7B5435E7}']
    function filterPanel: NSPanel; cdecl;
    function filterView: QuartzFilterView; cdecl;
    function selectedFilter: QuartzFilter; cdecl;
    function selectFilter(filter: QuartzFilter): Boolean; cdecl;
    procedure setDelegate(aDelegate: Pointer); cdecl;
    function delegate: Pointer; cdecl;
    function importFilter(filterProperties: NSDictionary): QuartzFilter; cdecl;
  end;

  TQuartzFilterManager = class(TOCGenericImport<QuartzFilterManagerClass, QuartzFilterManager>)
  end;
  PQuartzFilterManager = Pointer;

  QuartzFilterManagerDelegate = interface(IObjectiveC)
    ['{6E85705E-8669-46F8-9BDC-38B944618ABE}']
    [MethodName('quartzFilterManager:didAddFilter:')]
    procedure quartzFilterManagerDidAddFilter(sender: QuartzFilterManager; didAddFilter: QuartzFilter); cdecl;
    [MethodName('quartzFilterManager:didRemoveFilter:')]
    procedure quartzFilterManagerDidRemoveFilter(sender: QuartzFilterManager; didRemoveFilter: QuartzFilter); cdecl;
    [MethodName('quartzFilterManager:didModifyFilter:')]
    procedure quartzFilterManagerDidModifyFilter(sender: QuartzFilterManager; didModifyFilter: QuartzFilter); cdecl;
    [MethodName('quartzFilterManager:didSelectFilter:')]
    procedure quartzFilterManagerDidSelectFilter(sender: QuartzFilterManager; didSelectFilter: QuartzFilter); cdecl;
  end;

  PDFActionClass = interface(NSObjectClass)
    ['{F8AA4781-4550-44CB-B0B8-E14CCBDB0F4A}']
  end;
  PDFAction = interface(NSObject)
    ['{0114D37D-6A15-4980-8124-F52200C323C3}']
    function &type: NSString; cdecl;
  end;

  TPDFAction = class(TOCGenericImport<PDFActionClass, PDFAction>)
  end;
  PPDFAction = Pointer;

  PDFDestinationClass = interface(NSObjectClass)
    ['{0095CBE9-06DA-4C3D-8220-27CB43A3D393}']
  end;
  PDFDestination = interface(NSObject)
    ['{922A2B05-CBAB-40DE-8771-32AD609BB422}']
    function initWithPage(page: PDFPage; atPoint: NSPoint): Pointer; cdecl;
    function page: PDFPage; cdecl;
    function point: NSPoint; cdecl;
    function zoom: CGFloat; cdecl;
    procedure setZoom(zoom: CGFloat); cdecl;
    function compare(destination: PDFDestination): NSComparisonResult; cdecl;
  end;

  TPDFDestination = class(TOCGenericImport<PDFDestinationClass, PDFDestination>)
  end;
  PPDFDestination = Pointer;

  PDFActionGoToClass = interface(PDFActionClass)
    ['{513F00D1-9C24-41C6-8CDB-CE12772A91B7}']
  end;
  PDFActionGoTo = interface(PDFAction)
    ['{1F67B413-3915-4DF8-9C68-3522A6691104}']
    function initWithDestination(destination: PDFDestination): Pointer; cdecl;
    function destination: PDFDestination; cdecl;
    procedure setDestination(destination: PDFDestination); cdecl;
  end;

  TPDFActionGoTo = class(TOCGenericImport<PDFActionGoToClass, PDFActionGoTo>)
  end;
  PPDFActionGoTo = Pointer;

  PDFActionNamedClass = interface(PDFActionClass)
    ['{FE7BA1E7-DCBA-48F8-8E27-E71632747865}']
  end;
  PDFActionNamed = interface(PDFAction)
    ['{0AF68EC2-A7CB-4FED-AB09-44B553E7BA65}']
    function initWithName(name: PDFActionNamedName): Pointer; cdecl;
    function name: PDFActionNamedName; cdecl;
    procedure setName(name: PDFActionNamedName); cdecl;
  end;

  TPDFActionNamed = class(TOCGenericImport<PDFActionNamedClass, PDFActionNamed>)
  end;
  PPDFActionNamed = Pointer;

  PDFActionResetFormClass = interface(PDFActionClass)
    ['{B342400E-6E74-495B-9879-53F2F8C43229}']
  end;
  PDFActionResetForm = interface(PDFAction)
    ['{649C093F-5568-46E8-8600-FC10C16C8EBE}']
    function init: Pointer; cdecl;
    function fields: NSArray; cdecl;
    procedure setFields(fields: NSArray); cdecl;
    function fieldsIncludedAreCleared: Boolean; cdecl;
    procedure setFieldsIncludedAreCleared(include: Boolean); cdecl;
  end;

  TPDFActionResetForm = class(TOCGenericImport<PDFActionResetFormClass, PDFActionResetForm>)
  end;
  PPDFActionResetForm = Pointer;

  PDFActionRemoteGoToClass = interface(PDFActionClass)
    ['{818FE1C9-6A70-4DCF-B6FD-ECE3BFE8E6A9}']
  end;
  PDFActionRemoteGoTo = interface(PDFAction)
    ['{0D212F1A-4A3F-4DF0-9683-6916EFB1CC31}']
    function initWithPageIndex(pageIndex: NSUInteger; atPoint: NSPoint; fileURL: NSURL): Pointer; cdecl;
    function pageIndex: NSUInteger; cdecl;
    procedure setPageIndex(pageIndex: NSUInteger); cdecl;
    function point: NSPoint; cdecl;
    procedure setPoint(point: NSPoint); cdecl;
    function url: NSURL; cdecl;
    procedure setURL(url: NSURL); cdecl;
  end;

  TPDFActionRemoteGoTo = class(TOCGenericImport<PDFActionRemoteGoToClass, PDFActionRemoteGoTo>)
  end;
  PPDFActionRemoteGoTo = Pointer;

  PDFActionURLClass = interface(PDFActionClass)
    ['{EA5F0B5D-D474-422F-BC76-715B251C6EA3}']
  end;
  PDFActionURL = interface(PDFAction)
    ['{AB449A23-9A63-42A6-970F-6D6274BB5B83}']
    function initWithURL(url: NSURL): Pointer; cdecl;
    function url: NSURL; cdecl;
    procedure setURL(url: NSURL); cdecl;
  end;

  TPDFActionURL = class(TOCGenericImport<PDFActionURLClass, PDFActionURL>)
  end;
  PPDFActionURL = Pointer;

  PDFDocumentClass = interface(NSObjectClass)
    ['{0640EFC0-B0B1-485F-A94C-8739E784C34D}']
  end;
  PDFDocument = interface(NSObject)
    ['{892F1288-86AF-4600-A837-7DEC27BD38E2}']
    function initWithURL(url: NSURL): Pointer; cdecl;
    function initWithData(data: NSData): Pointer; cdecl;
    function documentURL: NSURL; cdecl;
    function documentRef: CGPDFDocumentRef; cdecl;
    function documentAttributes: NSDictionary; cdecl;
    procedure setDocumentAttributes(attributes: NSDictionary); cdecl;
    function majorVersion: Integer; cdecl;
    function minorVersion: Integer; cdecl;
    function isEncrypted: Boolean; cdecl;
    function isLocked: Boolean; cdecl;
    function unlockWithPassword(password: NSString): Boolean; cdecl;
    function allowsPrinting: Boolean; cdecl;
    function allowsCopying: Boolean; cdecl;
    function permissionsStatus: PDFDocumentPermissions; cdecl;
    function &string: NSString; cdecl;
    procedure setDelegate(anObject: Pointer); cdecl;
    function delegate: Pointer; cdecl;
    function dataRepresentation: NSData; cdecl;
    function dataRepresentationWithOptions(options: NSDictionary): NSData; cdecl;
    [MethodName('writeToFile:')]
    function writeToFile(path: NSString): Boolean; cdecl;
    [MethodName('writeToFile:withOptions:')]
    function writeToFileWithOptions(path: NSString; withOptions: NSDictionary): Boolean; cdecl;
    [MethodName('writeToURL:')]
    function writeToURL(url: NSURL): Boolean; cdecl;
    [MethodName('writeToURL:withOptions:')]
    function writeToURLWithOptions(url: NSURL; withOptions: NSDictionary): Boolean; cdecl;
    function outlineRoot: PDFOutline; cdecl;
    procedure setOutlineRoot(outline: PDFOutline); cdecl;
    function outlineItemForSelection(selection: PDFSelection): PDFOutline; cdecl;
    function pageCount: NSUInteger; cdecl;
    function pageAtIndex(index: NSUInteger): PDFPage; cdecl;
    function indexForPage(page: PDFPage): NSUInteger; cdecl;
    procedure insertPage(page: PDFPage; atIndex: NSUInteger); cdecl;
    procedure removePageAtIndex(index: NSUInteger); cdecl;
    procedure exchangePageAtIndex(indexA: NSUInteger; withPageAtIndex: NSUInteger); cdecl;
    function pageClass: Pointer; cdecl;
    [MethodName('findString:withOptions:')]
    function findStringWithOptions(&string: NSString; withOptions: NSUInteger): NSArray; cdecl;
    procedure beginFindString(&string: NSString; withOptions: NSUInteger); cdecl;
    procedure beginFindStrings(strings: NSArray; withOptions: NSUInteger); cdecl;
    [MethodName('findString:fromSelection:withOptions:')]
    function findStringFromSelectionWithOptions(&string: NSString; fromSelection: PDFSelection; withOptions: NSUInteger)
      : PDFSelection; cdecl;
    function isFinding: Boolean; cdecl;
    procedure cancelFindString; cdecl;
    function printOperationForPrintInfo(printInfo: NSPrintInfo; scalingMode: PDFPrintScalingMode; autoRotate: Boolean)
      : NSPrintOperation; cdecl;
    function selectionForEntireDocument: PDFSelection; cdecl;
    [MethodName('selectionFromPage:atPoint:toPage:atPoint:')]
    function selectionFromPageAtPointToPageAtPoint(startPage: PDFPage; atPoint: NSPoint; toPage: PDFPage;
      atPoint1: NSPoint): PDFSelection; cdecl;
    [MethodName('selectionFromPage:atCharacterIndex:toPage:atCharacterIndex:')]
    function selectionFromPageAtCharacterIndexToPageAtCharacterIndex(startPage: PDFPage; atCharacterIndex: NSUInteger;
      toPage: PDFPage; atCharacterIndex1: NSUInteger): PDFSelection; cdecl;
  end;

  TPDFDocument = class(TOCGenericImport<PDFDocumentClass, PDFDocument>)
  end;
  PPDFDocument = Pointer;

  PDFAnnotationClass = interface(NSObjectClass)
    ['{7F4556FB-DC6C-4E9C-BC09-54D2989359B2}']
  end;
  PDFAnnotation = interface(NSObject)
    ['{DCE4A1CF-1ECD-4548-8EE1-72A77F248FBD}']
    function initWithBounds(bounds: NSRect): Pointer; cdecl;
    function page: PDFPage; cdecl;
    function &type: NSString; cdecl;
    function bounds: NSRect; cdecl;
    procedure setBounds(bounds: NSRect); cdecl;
    function modificationDate: NSDate; cdecl;
    procedure setModificationDate(date: NSDate); cdecl;
    function userName: NSString; cdecl;
    procedure setUserName(name: NSString); cdecl;
    function popup: PDFAnnotationPopup; cdecl;
    procedure setPopup(popup: PDFAnnotationPopup); cdecl;
    function shouldDisplay: Boolean; cdecl;
    procedure setShouldDisplay(display: Boolean); cdecl;
    function shouldPrint: Boolean; cdecl;
    procedure setShouldPrint(print: Boolean); cdecl;
    function border: PDFBorder; cdecl;
    procedure setBorder(border: PDFBorder); cdecl;
    function color: NSColor; cdecl;
    procedure setColor(color: NSColor); cdecl;
    function mouseUpAction: PDFAction; cdecl;
    procedure setMouseUpAction(action: PDFAction); cdecl;
    function contents: NSString; cdecl;
    procedure setContents(contents: NSString); cdecl;
    function toolTip: NSString; cdecl;
    function hasAppearanceStream: Boolean; cdecl;
    procedure removeAllAppearanceStreams; cdecl;
    procedure drawWithBox(box: PDFDisplayBox); cdecl;
  end;

  TPDFAnnotation = class(TOCGenericImport<PDFAnnotationClass, PDFAnnotation>)
  end;
  PPDFAnnotation = Pointer;

  PDFSelectionClass = interface(NSObjectClass)
    ['{AA59CA1F-C006-4CC3-BA42-3DE8376B745C}']
  end;
  PDFSelection = interface(NSObject)
    ['{BE7BB116-E712-44B7-B974-D76CC90FAB43}']
    function initWithDocument(document: PDFDocument): Pointer; cdecl;
    function pages: NSArray; cdecl;
    function color: NSColor; cdecl;
    procedure setColor(color: NSColor); cdecl;
    function &string: NSString; cdecl;
    function attributedString: NSAttributedString; cdecl;
    function boundsForPage(page: PDFPage): NSRect; cdecl;
    function numberOfTextRangesOnPage(page: PDFPage): NSUInteger; cdecl;
    function rangeAtIndex(index: NSUInteger; onPage: PDFPage): NSRange; cdecl;
    function selectionsByLine: NSArray; cdecl;
    procedure addSelection(selection: PDFSelection); cdecl;
    procedure addSelections(selections: NSArray); cdecl;
    procedure extendSelectionAtEnd(succeed: NSInteger); cdecl;
    procedure extendSelectionAtStart(precede: NSInteger); cdecl;
    [MethodName('drawForPage:active:')]
    procedure drawForPageActive(page: PDFPage; active: Boolean); cdecl;
    [MethodName('drawForPage:withBox:active:')]
    procedure drawForPageWithBoxActive(page: PDFPage; withBox: PDFDisplayBox; active: Boolean); cdecl;
  end;

  TPDFSelection = class(TOCGenericImport<PDFSelectionClass, PDFSelection>)
  end;
  PPDFSelection = Pointer;

  PDFPageClass = interface(NSObjectClass)
    ['{B119023A-55D1-486F-8010-3D4B2C0FA629}']
  end;
  PDFPage = interface(NSObject)
    ['{C64EAF4A-8995-49F1-B53B-1B0A04DF6576}']
    function initWithImage(image: NSImage): Pointer; cdecl;
    function document: PDFDocument; cdecl;
    function pageRef: CGPDFPageRef; cdecl;
    function &label: NSString; cdecl;
    function boundsForBox(box: PDFDisplayBox): NSRect; cdecl;
    procedure setBounds(bounds: NSRect; forBox: PDFDisplayBox); cdecl;
    function rotation: NSInteger; cdecl;
    procedure setRotation(angle: NSInteger); cdecl;
    function annotations: NSArray; cdecl;
    function displaysAnnotations: Boolean; cdecl;
    procedure setDisplaysAnnotations(display: Boolean); cdecl;
    procedure addAnnotation(annotation: PDFAnnotation); cdecl;
    procedure removeAnnotation(annotation: PDFAnnotation); cdecl;
    function annotationAtPoint(point: NSPoint): PDFAnnotation; cdecl;
    procedure drawWithBox(box: PDFDisplayBox); cdecl;
    procedure transformContextForBox(box: PDFDisplayBox); cdecl;
    function numberOfCharacters: NSUInteger; cdecl;
    function &string: NSString; cdecl;
    function attributedString: NSAttributedString; cdecl;
    function characterBoundsAtIndex(index: NSInteger): NSRect; cdecl;
    function characterIndexAtPoint(point: NSPoint): NSInteger; cdecl;
    function selectionForRect(rect: NSRect): PDFSelection; cdecl;
    function selectionForWordAtPoint(point: NSPoint): PDFSelection; cdecl;
    function selectionForLineAtPoint(point: NSPoint): PDFSelection; cdecl;
    function selectionFromPoint(startPoint: NSPoint; toPoint: NSPoint): PDFSelection; cdecl;
    function selectionForRange(range: NSRange): PDFSelection; cdecl;
    function dataRepresentation: NSData; cdecl;
  end;

  TPDFPage = class(TOCGenericImport<PDFPageClass, PDFPage>)
  end;
  PPDFPage = Pointer;

  PDFBorderClass = interface(NSObjectClass)
    ['{42E88797-6EED-4668-9341-026D3161CE84}']
  end;
  PDFBorder = interface(NSObject)
    ['{58AEDAF1-A6F1-4C6E-8CFA-50696AC52782}']
    function style: PDFBorderStyle; cdecl;
    procedure setStyle(style: PDFBorderStyle); cdecl;
    function lineWidth: CGFloat; cdecl;
    procedure setLineWidth(width: CGFloat); cdecl;
    function dashPattern: NSArray; cdecl;
    procedure setDashPattern(pattern: NSArray); cdecl;
    procedure drawInRect(rect: NSRect); cdecl;
  end;

  TPDFBorder = class(TOCGenericImport<PDFBorderClass, PDFBorder>)
  end;
  PPDFBorder = Pointer;

  PDFAnnotationPopupClass = interface(PDFAnnotationClass)
    ['{D7D010F6-9AE8-4FB1-AB3C-14AD0829113E}']
  end;
  PDFAnnotationPopup = interface(PDFAnnotation)
    ['{498F765C-5103-4C95-9B58-C7B267A20CA1}']
    function isOpen: Boolean; cdecl;
    procedure setIsOpen(isOpen: Boolean); cdecl;
  end;

  TPDFAnnotationPopup = class(TOCGenericImport<PDFAnnotationPopupClass, PDFAnnotationPopup>)
  end;
  PPDFAnnotationPopup = Pointer;

  PDFAnnotationButtonWidgetClass = interface(PDFAnnotationClass)
    ['{6760A664-D180-4C45-9848-509368AE12D0}']
  end;
  PDFAnnotationButtonWidget = interface(PDFAnnotation)
    ['{EB9A23E7-ED7E-4AAF-8D32-C925B5098B4E}']
    function controlType: PDFWidgetControlType; cdecl;
    procedure setControlType(&type: PDFWidgetControlType); cdecl;
    function state: NSInteger; cdecl;
    procedure setState(value: NSInteger); cdecl;
    function isHighlighted: Boolean; cdecl;
    procedure setHighlighted(flag: Boolean); cdecl;
    function backgroundColor: NSColor; cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    function allowsToggleToOff: Boolean; cdecl;
    procedure setAllowsToggleToOff(allowOff: Boolean); cdecl;
    function font: NSFont; cdecl;
    procedure setFont(font: NSFont); cdecl;
    function fontColor: NSColor; cdecl;
    procedure setFontColor(color: NSColor); cdecl;
    function caption: NSString; cdecl;
    procedure setCaption(name: NSString); cdecl;
    function fieldName: NSString; cdecl;
    procedure setFieldName(name: NSString); cdecl;
    function onStateValue: NSString; cdecl;
    procedure setOnStateValue(name: NSString); cdecl;
  end;

  TPDFAnnotationButtonWidget = class(TOCGenericImport<PDFAnnotationButtonWidgetClass, PDFAnnotationButtonWidget>)
  end;
  PPDFAnnotationButtonWidget = Pointer;

  PDFAnnotationChoiceWidgetClass = interface(PDFAnnotationClass)
    ['{7CBC999A-A354-4478-9A70-8895E88F814D}']
  end;
  PDFAnnotationChoiceWidget = interface(PDFAnnotation)
    ['{55FB217F-984E-4D83-816E-53751E5DCCD1}']
    function stringValue: NSString; cdecl;
    procedure setStringValue(value: NSString); cdecl;
    function backgroundColor: NSColor; cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    function font: NSFont; cdecl;
    procedure setFont(font: NSFont); cdecl;
    function fontColor: NSColor; cdecl;
    procedure setFontColor(color: NSColor); cdecl;
    function fieldName: NSString; cdecl;
    procedure setFieldName(name: NSString); cdecl;
    function isListChoice: Boolean; cdecl;
    procedure setIsListChoice(isList: Boolean); cdecl;
    function choices: NSArray; cdecl;
    procedure setChoices(options: NSArray); cdecl;
  end;

  TPDFAnnotationChoiceWidget = class(TOCGenericImport<PDFAnnotationChoiceWidgetClass, PDFAnnotationChoiceWidget>)
  end;
  PPDFAnnotationChoiceWidget = Pointer;

  PDFAnnotationCircleClass = interface(PDFAnnotationClass)
    ['{99F20428-F65D-45A0-88AB-AA19EA780301}']
  end;
  PDFAnnotationCircle = interface(PDFAnnotation)
    ['{201A340E-9784-45D2-AF5D-A3598A86485F}']
    function interiorColor: NSColor; cdecl;
    procedure setInteriorColor(color: NSColor); cdecl;
  end;

  TPDFAnnotationCircle = class(TOCGenericImport<PDFAnnotationCircleClass, PDFAnnotationCircle>)
  end;
  PPDFAnnotationCircle = Pointer;

  PDFAnnotationFreeTextClass = interface(PDFAnnotationClass)
    ['{FE39576B-581E-4AB9-B413-82EB3F17575D}']
  end;
  PDFAnnotationFreeText = interface(PDFAnnotation)
    ['{2C7EC115-3E75-47BF-A830-CBD2F5F1E973}']
    function font: NSFont; cdecl;
    procedure setFont(font: NSFont); cdecl;
    function fontColor: NSColor; cdecl;
    procedure setFontColor(color: NSColor); cdecl;
    function alignment: NSTextAlignment; cdecl;
    procedure setAlignment(alignment: NSTextAlignment); cdecl;
  end;

  TPDFAnnotationFreeText = class(TOCGenericImport<PDFAnnotationFreeTextClass, PDFAnnotationFreeText>)
  end;
  PPDFAnnotationFreeText = Pointer;

  PDFAnnotationInkClass = interface(PDFAnnotationClass)
    ['{6450CDFA-89E6-42ED-BE39-60E1D3461E51}']
  end;
  PDFAnnotationInk = interface(PDFAnnotation)
    ['{F5DBCB7B-85AC-44F9-A899-A3D8E5A38132}']
    function paths: NSArray; cdecl;
    procedure addBezierPath(path: NSBezierPath); cdecl;
    procedure removeBezierPath(path: NSBezierPath); cdecl;
  end;

  TPDFAnnotationInk = class(TOCGenericImport<PDFAnnotationInkClass, PDFAnnotationInk>)
  end;
  PPDFAnnotationInk = Pointer;

  PDFAnnotationLineClass = interface(PDFAnnotationClass)
    ['{B6D2265B-2E72-411A-A5F7-E30E66600110}']
  end;
  PDFAnnotationLine = interface(PDFAnnotation)
    ['{A8ECD1C5-36D0-49D4-A2BE-7D38D7B619A4}']
    function startPoint: NSPoint; cdecl;
    procedure setStartPoint(point: NSPoint); cdecl;
    function endPoint: NSPoint; cdecl;
    procedure setEndPoint(point: NSPoint); cdecl;
    function startLineStyle: PDFLineStyle; cdecl;
    procedure setStartLineStyle(style: PDFLineStyle); cdecl;
    function endLineStyle: PDFLineStyle; cdecl;
    procedure setEndLineStyle(style: PDFLineStyle); cdecl;
    function interiorColor: NSColor; cdecl;
    procedure setInteriorColor(color: NSColor); cdecl;
  end;

  TPDFAnnotationLine = class(TOCGenericImport<PDFAnnotationLineClass, PDFAnnotationLine>)
  end;
  PPDFAnnotationLine = Pointer;

  PDFAnnotationLinkClass = interface(PDFAnnotationClass)
    ['{347B88BA-1AD1-4B71-BC1C-9EED17243646}']
  end;
  PDFAnnotationLink = interface(PDFAnnotation)
    ['{ED446455-C0B8-4017-82AC-4BBE6CCA1F49}']
    function destination: PDFDestination; cdecl;
    procedure setDestination(destination: PDFDestination); cdecl;
    function url: NSURL; cdecl;
    procedure setURL(url: NSURL); cdecl;
    procedure setHighlighted(flag: Boolean); cdecl;
  end;

  TPDFAnnotationLink = class(TOCGenericImport<PDFAnnotationLinkClass, PDFAnnotationLink>)
  end;
  PPDFAnnotationLink = Pointer;

  PDFAnnotationMarkupClass = interface(PDFAnnotationClass)
    ['{23D04BDB-655B-47DC-BBF6-1BAE68341A96}']
  end;
  PDFAnnotationMarkup = interface(PDFAnnotation)
    ['{485170A0-23D0-4D20-9809-98AA9236A871}']
    function quadrilateralPoints: NSArray; cdecl;
    procedure setQuadrilateralPoints(points: NSArray); cdecl;
    function markupType: PDFMarkupType; cdecl;
    procedure setMarkupType(&type: PDFMarkupType); cdecl;
  end;

  TPDFAnnotationMarkup = class(TOCGenericImport<PDFAnnotationMarkupClass, PDFAnnotationMarkup>)
  end;
  PPDFAnnotationMarkup = Pointer;

  PDFAnnotationSquareClass = interface(PDFAnnotationClass)
    ['{37FA8A7A-BAC6-4ABF-ACC4-BBC17C51ADE6}']
  end;
  PDFAnnotationSquare = interface(PDFAnnotation)
    ['{1694CA3B-E3D3-4C66-AAC7-0CC6A0E5296B}']
    function interiorColor: NSColor; cdecl;
    procedure setInteriorColor(color: NSColor); cdecl;
  end;

  TPDFAnnotationSquare = class(TOCGenericImport<PDFAnnotationSquareClass, PDFAnnotationSquare>)
  end;
  PPDFAnnotationSquare = Pointer;

  PDFAnnotationStampClass = interface(PDFAnnotationClass)
    ['{F103EC6C-DFA1-455F-A139-07BDED041959}']
  end;
  PDFAnnotationStamp = interface(PDFAnnotation)
    ['{A79F33C2-C1F8-407E-9384-E5091D15D1A0}']
    function name: NSString; cdecl;
    procedure setName(name: NSString); cdecl;
  end;

  TPDFAnnotationStamp = class(TOCGenericImport<PDFAnnotationStampClass, PDFAnnotationStamp>)
  end;
  PPDFAnnotationStamp = Pointer;

  PDFAnnotationTextClass = interface(PDFAnnotationClass)
    ['{C7190D14-290B-436D-BB9E-399C2AEF2363}']
  end;
  PDFAnnotationText = interface(PDFAnnotation)
    ['{558A80AC-EF70-4C95-9CA7-D84FBC6D22BB}']
    function iconType: PDFTextAnnotationIconType; cdecl;
    procedure setIconType(&type: PDFTextAnnotationIconType); cdecl;
  end;

  TPDFAnnotationText = class(TOCGenericImport<PDFAnnotationTextClass, PDFAnnotationText>)
  end;
  PPDFAnnotationText = Pointer;

  PDFAnnotationTextWidgetClass = interface(PDFAnnotationClass)
    ['{98A7AEAF-BBBF-45DC-A6B4-F3D8F56BF52E}']
  end;
  PDFAnnotationTextWidget = interface(PDFAnnotation)
    ['{F56FAD32-A068-45DB-959E-949478168676}']
    function stringValue: NSString; cdecl;
    procedure setStringValue(value: NSString); cdecl;
    function attributedStringValue: NSAttributedString; cdecl;
    procedure setAttributedStringValue(value: NSAttributedString); cdecl;
    function backgroundColor: NSColor; cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    function rotation: Integer; cdecl;
    procedure setRotation(rotation: Integer); cdecl;
    function font: NSFont; cdecl;
    procedure setFont(font: NSFont); cdecl;
    function fontColor: NSColor; cdecl;
    procedure setFontColor(color: NSColor); cdecl;
    function alignment: NSTextAlignment; cdecl;
    procedure setAlignment(alignment: NSTextAlignment); cdecl;
    function maximumLength: NSUInteger; cdecl;
    procedure setMaximumLength(maxLen: NSUInteger); cdecl;
    function fieldName: NSString; cdecl;
    procedure setFieldName(name: NSString); cdecl;
  end;

  TPDFAnnotationTextWidget = class(TOCGenericImport<PDFAnnotationTextWidgetClass, PDFAnnotationTextWidget>)
  end;
  PPDFAnnotationTextWidget = Pointer;

  PDFOutlineClass = interface(NSObjectClass)
    ['{67F0E3D2-8F36-4146-9279-D12F8A714771}']
  end;
  PDFOutline = interface(NSObject)
    ['{C9C917E4-5B59-428E-A176-A2116E1CC6E8}']
    function init: Pointer; cdecl;
    function document: PDFDocument; cdecl;
    function parent: PDFOutline; cdecl;
    function numberOfChildren: NSUInteger; cdecl;
    function index: NSUInteger; cdecl;
    function childAtIndex(index: NSUInteger): PDFOutline; cdecl;
    procedure insertChild(child: PDFOutline; atIndex: NSUInteger); cdecl;
    procedure removeFromParent; cdecl;
    function &label: NSString; cdecl;
    procedure setLabel(&label: NSString); cdecl;
    function isOpen: Boolean; cdecl;
    procedure setIsOpen(open: Boolean); cdecl;
    function destination: PDFDestination; cdecl;
    procedure setDestination(destination: PDFDestination); cdecl;
    function action: PDFAction; cdecl;
    procedure setAction(action: PDFAction); cdecl;
  end;

  TPDFOutline = class(TOCGenericImport<PDFOutlineClass, PDFOutline>)
  end;
  PPDFOutline = Pointer;

  PDFDocumentNotifications = interface(IObjectiveC)
    ['{54F6333D-71AC-4FE8-B8D4-61FC379CC406}']
    procedure documentDidUnlock(notification: NSNotification); cdecl;
    procedure documentDidBeginDocumentFind(notification: NSNotification); cdecl;
    procedure documentDidEndDocumentFind(notification: NSNotification); cdecl;
    procedure documentDidBeginPageFind(notification: NSNotification); cdecl;
    procedure documentDidEndPageFind(notification: NSNotification); cdecl;
    procedure documentDidFindMatch(notification: NSNotification); cdecl;
  end;

  PDFDocumentDelegate = interface(IObjectiveC)
    ['{E3167F8B-DB42-4AF4-B1B5-AAA62CCE70B7}']
    procedure didMatchString(instance: PDFSelection); cdecl;
    function classForPage: Pointer; cdecl;
    function classForAnnotationClass(annotationClass: Pointer): Pointer; cdecl;
  end;

  PDFViewClass = interface(NSViewClass)
    ['{0BE25E49-6E0B-4F56-8B0C-7BEB57AEA21F}']
  end;
  PDFView = interface(NSView)
    ['{6FCD3A71-7D59-4E5F-8272-1CDCDD7F8432}']
    function document: PDFDocument; cdecl;
    procedure setDocument(document: PDFDocument); cdecl;
    function canGoToFirstPage: Boolean; cdecl;
    procedure goToFirstPage(sender: Pointer); cdecl;
    function canGoToLastPage: Boolean; cdecl;
    procedure goToLastPage(sender: Pointer); cdecl;
    function canGoToNextPage: Boolean; cdecl;
    procedure goToNextPage(sender: Pointer); cdecl;
    function canGoToPreviousPage: Boolean; cdecl;
    procedure goToPreviousPage(sender: Pointer); cdecl;
    function canGoBack: Boolean; cdecl;
    procedure goBack(sender: Pointer); cdecl;
    function canGoForward: Boolean; cdecl;
    procedure goForward(sender: Pointer); cdecl;
    function currentPage: PDFPage; cdecl;
    procedure goToPage(page: PDFPage); cdecl;
    function currentDestination: PDFDestination; cdecl;
    procedure goToDestination(destination: PDFDestination); cdecl;
    procedure goToSelection(selection: PDFSelection); cdecl;
    procedure goToRect(rect: NSRect; onPage: PDFPage); cdecl;
    procedure setDisplayMode(mode: PDFDisplayMode); cdecl;
    function displayMode: PDFDisplayMode; cdecl;
    procedure setDisplaysPageBreaks(breaks: Boolean); cdecl;
    function displaysPageBreaks: Boolean; cdecl;
    procedure setDisplayBox(box: PDFDisplayBox); cdecl;
    function displayBox: PDFDisplayBox; cdecl;
    procedure setDisplaysAsBook(asBook: Boolean); cdecl;
    function displaysAsBook: Boolean; cdecl;
    procedure setShouldAntiAlias(aliasing: Boolean); cdecl;
    function shouldAntiAlias: Boolean; cdecl;
    procedure setGreekingThreshold(threshold: CGFloat); cdecl;
    function greekingThreshold: CGFloat; cdecl;
    procedure takeBackgroundColorFrom(sender: Pointer); cdecl;
    procedure setBackgroundColor(newColor: NSColor); cdecl;
    function backgroundColor: NSColor; cdecl;
    procedure setInterpolationQuality(quality: PDFInterpolationQuality); cdecl;
    function interpolationQuality: PDFInterpolationQuality; cdecl;
    procedure setDelegate(anObject: Pointer); cdecl;
    function delegate: Pointer; cdecl;
    procedure setScaleFactor(scale: CGFloat); cdecl;
    function scaleFactor: CGFloat; cdecl;
    procedure zoomIn(sender: Pointer); cdecl;
    function canZoomIn: Boolean; cdecl;
    procedure zoomOut(sender: Pointer); cdecl;
    function canZoomOut: Boolean; cdecl;
    procedure setAutoScales(newAuto: Boolean); cdecl;
    function autoScales: Boolean; cdecl;
    function areaOfInterestForMouse(event: NSEvent): PDFAreaOfInterest; cdecl;
    procedure setCursorForAreaOfInterest(area: PDFAreaOfInterest); cdecl;
    procedure performAction(action: PDFAction); cdecl;
    function currentSelection: PDFSelection; cdecl;
    [MethodName('setCurrentSelection:')]
    procedure setCurrentSelection(selection: PDFSelection); cdecl;
    [MethodName('setCurrentSelection:animate:')]
    procedure setCurrentSelectionAnimate(selection: PDFSelection; animate: Boolean); cdecl;
    procedure clearSelection; cdecl;
    procedure selectAll(sender: Pointer); cdecl;
    procedure scrollSelectionToVisible(sender: Pointer); cdecl;
    procedure setHighlightedSelections(selections: NSArray); cdecl;
    function highlightedSelections: NSArray; cdecl;
    procedure takePasswordFrom(sender: Pointer); cdecl;
    procedure drawPage(page: PDFPage); cdecl;
    procedure drawPagePost(page: PDFPage); cdecl;
    procedure copy(sender: Pointer); cdecl;
    [MethodName('printWithInfo:autoRotate:')]
    procedure printWithInfoAutoRotate(printInfo: NSPrintInfo; autoRotate: Boolean); cdecl;
    [MethodName('printWithInfo:autoRotate:pageScaling:')]
    procedure printWithInfoAutoRotatePageScaling(printInfo: NSPrintInfo; autoRotate: Boolean;
      pageScaling: PDFPrintScalingMode); cdecl;
    function pageForPoint(point: NSPoint; nearest: Boolean): PDFPage; cdecl;
    [MethodName('convertPoint:toPage:')]
    function convertPointToPage(point: NSPoint; toPage: PDFPage): NSPoint; cdecl;
    [MethodName('convertRect:toPage:')]
    function convertRectToPage(rect: NSRect; toPage: PDFPage): NSRect; cdecl;
    [MethodName('convertPoint:fromPage:')]
    function convertPointFromPage(point: NSPoint; fromPage: PDFPage): NSPoint; cdecl;
    [MethodName('convertRect:fromPage:')]
    function convertRectFromPage(rect: NSRect; fromPage: PDFPage): NSRect; cdecl;
    function documentView: NSView; cdecl;
    procedure layoutDocumentView; cdecl;
    procedure annotationsChangedOnPage(page: PDFPage); cdecl;
    function rowSizeForPage(page: PDFPage): NSSize; cdecl;
    procedure setAllowsDragging(allow: Boolean); cdecl;
    function allowsDragging: Boolean; cdecl;
    function visiblePages: NSArray; cdecl;
    procedure setEnableDataDetectors(enable: Boolean); cdecl;
    function enableDataDetectors: Boolean; cdecl;
  end;

  TPDFView = class(TOCGenericImport<PDFViewClass, PDFView>)
  end;
  PPDFView = Pointer;

  PDFThumbnailViewClass = interface(NSViewClass)
    ['{D2673CD8-5583-4A28-AC75-ABF792F0E8D7}']
  end;
  PDFThumbnailView = interface(NSView)
    ['{2F8CB487-9F28-4DF3-9635-DE613CEF1B83}']
    procedure setPDFView(view: PDFView); cdecl;
    function PDFView: PDFView; cdecl;
    procedure setThumbnailSize(size: NSSize); cdecl;
    function thumbnailSize: NSSize; cdecl;
    procedure setMaximumNumberOfColumns(maxColumns: NSUInteger); cdecl;
    function maximumNumberOfColumns: NSUInteger; cdecl;
    procedure setLabelFont(font: NSFont); cdecl;
    function labelFont: NSFont; cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    function backgroundColor: NSColor; cdecl;
    procedure setAllowsDragging(allow: Boolean); cdecl;
    function allowsDragging: Boolean; cdecl;
    procedure setAllowsMultipleSelection(flag: Boolean); cdecl;
    function allowsMultipleSelection: Boolean; cdecl;
    function selectedPages: NSArray; cdecl;
  end;

  TPDFThumbnailView = class(TOCGenericImport<PDFThumbnailViewClass, PDFThumbnailView>)
  end;
  PPDFThumbnailView = Pointer;

  PDFViewDelegate = interface(IObjectiveC)
    ['{4E1F8911-4FAA-4761-9477-74C56FA55D49}']
    function PDFViewWillChangeScaleFactor(sender: PDFView; toScale: CGFloat): CGFloat; cdecl;
    procedure PDFViewWillClickOnLink(sender: PDFView; withURL: NSURL); cdecl;
    function PDFViewPrintJobTitle(sender: PDFView): NSString; cdecl;
    procedure PDFViewPerformFind(sender: PDFView); cdecl;
    procedure PDFViewPerformGoToPage(sender: PDFView); cdecl;
    procedure PDFViewPerformPrint(sender: PDFView); cdecl;
    procedure PDFViewOpenPDF(sender: PDFView; forRemoteGoToAction: PDFActionRemoteGoTo); cdecl;
  end;

  IKImageBrowserViewClass = interface(NSViewClass)
    ['{7B6363FC-20FB-4A93-9517-072A92C88D94}']
  end;
  IKImageBrowserView = interface(NSView)
    ['{AFD2E61D-56DE-476F-8CEC-E8B3B9C7ECBA}']
    function initWithFrame(frame: NSRect): Pointer; cdecl;
    procedure setDataSource(source: Pointer); cdecl;
    function dataSource: Pointer; cdecl;
    procedure reloadData; cdecl;
    procedure setDelegate(aDelegate: Pointer); cdecl;
    function delegate: Pointer; cdecl;
    procedure setCellsStyleMask(mask: NSUInteger); cdecl;
    function cellsStyleMask: NSUInteger; cdecl;
    procedure setConstrainsToOriginalSize(flag: Boolean); cdecl;
    function constrainsToOriginalSize: Boolean; cdecl;
    procedure setBackgroundLayer(aLayer: CALayer); cdecl;
    function backgroundLayer: CALayer; cdecl;
    procedure setForegroundLayer(aLayer: CALayer); cdecl;
    function foregroundLayer: CALayer; cdecl;
    function newCellForRepresentedItem(anItem: Pointer): IKImageBrowserCell; cdecl;
    function cellForItemAtIndex(index: NSUInteger): IKImageBrowserCell; cdecl;
    procedure setZoomValue(aValue: Single); cdecl;
    function zoomValue: Single; cdecl;
    procedure setContentResizingMask(mask: NSUInteger); cdecl;
    function contentResizingMask: NSUInteger; cdecl;
    procedure scrollIndexToVisible(index: NSInteger); cdecl;
    procedure setCellSize(size: NSSize); cdecl;
    function cellSize: NSSize; cdecl;
    function intercellSpacing: NSSize; cdecl;
    procedure setIntercellSpacing(aSize: NSSize); cdecl;
    function indexOfItemAtPoint(point: NSPoint): NSInteger; cdecl;
    function itemFrameAtIndex(index: NSInteger): NSRect; cdecl;
    function visibleItemIndexes: NSIndexSet; cdecl;
    function rowIndexesInRect(rect: NSRect): NSIndexSet; cdecl;
    function columnIndexesInRect(rect: NSRect): NSIndexSet; cdecl;
    function rectOfColumn(columnIndex: NSUInteger): NSRect; cdecl;
    function rectOfRow(rowIndex: NSUInteger): NSRect; cdecl;
    function numberOfRows: NSUInteger; cdecl;
    function numberOfColumns: NSUInteger; cdecl;
    procedure setCanControlQuickLookPanel(flag: Boolean); cdecl;
    function canControlQuickLookPanel: Boolean; cdecl;
    function selectionIndexes: NSIndexSet; cdecl;
    procedure setSelectionIndexes(indexes: NSIndexSet; byExtendingSelection: Boolean); cdecl;
    procedure setAllowsMultipleSelection(flag: Boolean); cdecl;
    function allowsMultipleSelection: Boolean; cdecl;
    procedure setAllowsEmptySelection(flag: Boolean); cdecl;
    function allowsEmptySelection: Boolean; cdecl;
    procedure setAllowsReordering(flag: Boolean); cdecl;
    function allowsReordering: Boolean; cdecl;
    procedure setAnimates(flag: Boolean); cdecl;
    function animates: Boolean; cdecl;
    procedure expandGroupAtIndex(index: NSUInteger); cdecl;
    procedure collapseGroupAtIndex(index: NSUInteger); cdecl;
    function isGroupExpandedAtIndex(index: NSUInteger): Boolean; cdecl;
    procedure setDraggingDestinationDelegate(delegate: Pointer); cdecl;
    function draggingDestinationDelegate: Pointer; cdecl;
    function indexAtLocationOfDroppedItem: NSUInteger; cdecl;
    function dropOperation: IKImageBrowserDropOperation; cdecl;
    procedure setAllowsDroppingOnItems(flag: Boolean); cdecl;
    function allowsDroppingOnItems: Boolean; cdecl;
    procedure setDropIndex(index: NSInteger; dropOperation: IKImageBrowserDropOperation); cdecl;
  end;

  TIKImageBrowserView = class(TOCGenericImport<IKImageBrowserViewClass, IKImageBrowserView>)
  end;
  PIKImageBrowserView = Pointer;

  IKImageBrowserCellClass = interface(NSObjectClass)
    ['{1F4010AE-876F-48B7-AB3D-5E92359AE324}']
  end;
  IKImageBrowserCell = interface(NSObject)
    ['{8AD44745-E7C7-4371-A2B9-CA64E6A563FC}']
    function imageBrowserView: IKImageBrowserView; cdecl;
    function representedItem: Pointer; cdecl;
    function indexOfRepresentedItem: NSUInteger; cdecl;
    function frame: NSRect; cdecl;
    function imageContainerFrame: NSRect; cdecl;
    function imageFrame: NSRect; cdecl;
    function selectionFrame: NSRect; cdecl;
    function titleFrame: NSRect; cdecl;
    function subtitleFrame: NSRect; cdecl;
    function imageAlignment: NSImageAlignment; cdecl;
    function isSelected: Boolean; cdecl;
    function cellState: IKImageBrowserCellState; cdecl;
    function opacity: CGFloat; cdecl;
    function layerForType(&type: NSString): CALayer; cdecl;
  end;

  TIKImageBrowserCell = class(TOCGenericImport<IKImageBrowserCellClass, IKImageBrowserCell>)
  end;
  PIKImageBrowserCell = Pointer;

  IKImageBrowserDataSource = interface(IObjectiveC)
    ['{3A2B200E-0241-4D8A-A148-5947FC31D46F}']
    function numberOfItemsInImageBrowser(aBrowser: IKImageBrowserView): NSUInteger; cdecl;
    [MethodName('imageBrowser:itemAtIndex:')]
    function imageBrowserItemAtIndex(aBrowser: IKImageBrowserView; itemAtIndex: NSUInteger): Pointer; cdecl;
    [MethodName('imageBrowser:removeItemsAtIndexes:')]
    procedure imageBrowserRemoveItemsAtIndexes(aBrowser: IKImageBrowserView; removeItemsAtIndexes: NSIndexSet); cdecl;
    [MethodName('imageBrowser:moveItemsAtIndexes:toIndex:')]
    function imageBrowserMoveItemsAtIndexesToIndex(aBrowser: IKImageBrowserView; moveItemsAtIndexes: NSIndexSet;
      toIndex: NSUInteger): Boolean; cdecl;
    [MethodName('imageBrowser:writeItemsAtIndexes:toPasteboard:')]
    function imageBrowserWriteItemsAtIndexesToPasteboard(aBrowser: IKImageBrowserView; writeItemsAtIndexes: NSIndexSet;
      toPasteboard: NSPasteboard): NSUInteger; cdecl;
    function numberOfGroupsInImageBrowser(aBrowser: IKImageBrowserView): NSUInteger; cdecl;
    [MethodName('imageBrowser:groupAtIndex:')]
    function imageBrowserGroupAtIndex(aBrowser: IKImageBrowserView; groupAtIndex: NSUInteger): NSDictionary; cdecl;
  end;

  IKImageBrowserItem = interface(IObjectiveC)
    ['{EDEF4D60-FF5D-45C5-8B54-E9D7C7B05E13}']
    function imageUID: NSString; cdecl;
    function imageRepresentationType: NSString; cdecl;
    function imageRepresentation: Pointer; cdecl;
    function imageVersion: NSUInteger; cdecl;
    function imageTitle: NSString; cdecl;
    function imageSubtitle: NSString; cdecl;
    function isSelectable: Boolean; cdecl;
  end;

  IKImageBrowserDelegate = interface(IObjectiveC)
    ['{B7E13F5B-4094-40AB-8BE6-126D1CE1974C}']
    procedure imageBrowserSelectionDidChange(aBrowser: IKImageBrowserView); cdecl;
    [MethodName('imageBrowser:cellWasDoubleClickedAtIndex:')]
    procedure imageBrowserCellWasDoubleClickedAtIndex(aBrowser: IKImageBrowserView;
      cellWasDoubleClickedAtIndex: NSUInteger); cdecl;
    [MethodName('imageBrowser:cellWasRightClickedAtIndex:withEvent:')]
    procedure imageBrowserCellWasRightClickedAtIndexWithEvent(aBrowser: IKImageBrowserView;
      cellWasRightClickedAtIndex: NSUInteger; withEvent: NSEvent); cdecl;
    [MethodName('imageBrowser:backgroundWasRightClickedWithEvent:')]
    procedure imageBrowserBackgroundWasRightClickedWithEvent(aBrowser: IKImageBrowserView;
      backgroundWasRightClickedWithEvent: NSEvent); cdecl;
  end;

  IKPictureTakerClass = interface(NSPanelClass)
    ['{7AD10B5C-B73D-4D53-AFD0-749FE52EE325}']
    {class} function pictureTaker: IKPictureTaker; cdecl;
  end;
  IKPictureTaker = interface(NSPanel)
    ['{FB7C3332-FC79-4FEA-829D-8EDFB4236424}']
    function runModal: NSInteger; cdecl;
    procedure beginPictureTakerWithDelegate(delegate: Pointer; didEndSelector: SEL; contextInfo: Pointer); cdecl;
    procedure beginPictureTakerSheetForWindow(aWindow: NSWindow; withDelegate: Pointer; didEndSelector: SEL;
      contextInfo: Pointer); cdecl;
    procedure popUpRecentsMenuForView(aView: NSView; withDelegate: Pointer; didEndSelector: SEL;
      contextInfo: Pointer); cdecl;
    procedure setInputImage(image: NSImage); cdecl;
    function inputImage: NSImage; cdecl;
    function outputImage: NSImage; cdecl;
    procedure setMirroring(b: Boolean); cdecl;
    function mirroring: Boolean; cdecl;
  end;

  TIKPictureTaker = class(TOCGenericImport<IKPictureTakerClass, IKPictureTaker>)
  end;
  PIKPictureTaker = Pointer;

  IKFilterUIViewClass = interface(NSViewClass)
    ['{ACBF40DE-9C04-40AE-B024-695B74E7FDA7}']
    {class} function viewWithFrame(frameRect: NSRect; filter: CIFilter): Pointer; cdecl;
  end;
  IKFilterUIView = interface(NSView)
    ['{98F81E00-8271-4F85-9781-944712E93BBA}']
    function initWithFrame(frameRect: NSRect; filter: CIFilter): Pointer; cdecl;
    function filter: CIFilter; cdecl;
    function objectController: NSObjectController; cdecl;
  end;

  TIKFilterUIView = class(TOCGenericImport<IKFilterUIViewClass, IKFilterUIView>)
  end;
  PIKFilterUIView = Pointer;

  IKFilterUIAddition = interface(IObjectiveC)
    ['{D16CE7A2-7518-4D96-B51B-774E787516DA}']
    function viewForUIConfiguration(inUIConfiguration: NSDictionary; excludedKeys: NSArray): IKFilterUIView; cdecl;
  end;

  IKFilterBrowserViewClass = interface(NSViewClass)
    ['{F9C3A45F-7C9D-476E-BE15-CC28F3636499}']
  end;
  IKFilterBrowserView = interface(NSView)
    ['{D6DD70D2-0859-4485-B6B4-E3C21BC1C90D}']
    procedure setPreviewState(inState: Boolean); cdecl;
    function filterName: NSString; cdecl;
  end;

  TIKFilterBrowserView = class(TOCGenericImport<IKFilterBrowserViewClass, IKFilterBrowserView>)
  end;
  PIKFilterBrowserView = Pointer;

  IKFilterBrowserPanelClass = interface(NSPanelClass)
    ['{B26C48CF-7F8F-472F-B9F2-011EE61525BF}']
    {class} function filterBrowserPanelWithStyleMask(styleMask: Cardinal): Pointer; cdecl;
  end;
  IKFilterBrowserPanel = interface(NSPanel)
    ['{49BEB98B-55E7-4AEB-ACEC-76C28598F0B9}']
    function filterName: NSString; cdecl;
    procedure beginWithOptions(inOptions: NSDictionary; modelessDelegate: Pointer; didEndSelector: SEL;
      contextInfo: Pointer); cdecl;
    procedure beginSheetWithOptions(inOptions: NSDictionary; modalForWindow: NSWindow; modalDelegate: Pointer;
      didEndSelector: SEL; contextInfo: Pointer); cdecl;
    function runModalWithOptions(inOptions: NSDictionary): Integer; cdecl;
    function filterBrowserViewWithOptions(inOptions: NSDictionary): IKFilterBrowserView; cdecl;
    procedure finish(sender: Pointer); cdecl;
  end;

  TIKFilterBrowserPanel = class(TOCGenericImport<IKFilterBrowserPanelClass, IKFilterBrowserPanel>)
  end;
  PIKFilterBrowserPanel = Pointer;

  IKSlideshowClass = interface(NSObjectClass)
    ['{98EB442D-F72C-400F-A08E-5C7D3B745500}']
    {class} function sharedSlideshow: IKSlideshow; cdecl;
    {class} function canExportToApplication(applicationBundleIdentifier: NSString): Boolean; cdecl;
    {class} procedure exportSlideshowItem(item: Pointer; toApplication: NSString); cdecl;
  end;
  IKSlideshow = interface(NSObject)
    ['{92BE4215-5448-409B-A760-33EEEB20FD32}']
    procedure setAutoPlayDelay(autoPlayDelay: NSTimeInterval); cdecl;
    function autoPlayDelay: NSTimeInterval; cdecl;
    procedure runSlideshowWithDataSource(dataSource: Pointer; inMode: NSString; options: NSDictionary); cdecl;
    procedure stopSlideshow(sender: Pointer); cdecl;
    procedure reloadData; cdecl;
    procedure reloadSlideshowItemAtIndex(index: NSUInteger); cdecl;
    function indexOfCurrentSlideshowItem: NSUInteger; cdecl;
  end;

  TIKSlideshow = class(TOCGenericImport<IKSlideshowClass, IKSlideshow>)
  end;
  PIKSlideshow = Pointer;

  IKSaveOptionsClass = interface(NSObjectClass)
    ['{060493D9-6179-48DB-BECC-BE6DC4500BC3}']
  end;
  IKSaveOptions = interface(NSObject)
    ['{78B57A6B-A2B7-4938-BDB4-3A55E382F865}']
    procedure setDelegate(delegate: Pointer); cdecl;
    function delegate: Pointer; cdecl;
    function imageProperties: NSDictionary; cdecl;
    function imageUTType: NSString; cdecl;
    function userSelection: NSDictionary; cdecl;
    function initWithImageProperties(imageProperties: NSDictionary; imageUTType: NSString): Pointer; cdecl;
    procedure addSaveOptionsAccessoryViewToSavePanel(savePanel: NSSavePanel); cdecl;
    procedure addSaveOptionsToView(view: NSView); cdecl;
  end;

  TIKSaveOptions = class(TOCGenericImport<IKSaveOptionsClass, IKSaveOptions>)
  end;
  PIKSaveOptions = Pointer;

  IKSaveOptionsDelegate = interface(IObjectiveC)
    ['{EC08F1C0-7945-4B96-9B04-E0488E52BFEB}']
    function saveOptions(saveOptions: IKSaveOptions; shouldShowUTType: NSString): Boolean; cdecl;
  end;

  IKImageViewClass = interface(NSViewClass)
    ['{E8B6E98A-4FB1-4F57-BEAA-B93780112BEA}']
  end;
  IKImageView = interface(NSView)
    ['{62ED3646-1988-4AEC-958B-2F84A22DBA82}']
    procedure setDelegate(delegate: Pointer); cdecl;
    function delegate: Pointer; cdecl;
    procedure setZoomFactor(zoomFactor: CGFloat); cdecl;
    function zoomFactor: CGFloat; cdecl;
    [MethodName('setRotationAngle:')]
    procedure setRotationAngle(rotationAngle: CGFloat); cdecl;
    function rotationAngle: CGFloat; cdecl;
    procedure setCurrentToolMode(currentToolMode: NSString); cdecl;
    function currentToolMode: NSString; cdecl;
    procedure setAutoresizes(autoresizes: Boolean); cdecl;
    function autoresizes: Boolean; cdecl;
    procedure setHasHorizontalScroller(hasHorizontalScroller: Boolean); cdecl;
    function hasHorizontalScroller: Boolean; cdecl;
    procedure setHasVerticalScroller(hasVerticalScroller: Boolean); cdecl;
    function hasVerticalScroller: Boolean; cdecl;
    procedure setAutohidesScrollers(autohidesScrollers: Boolean); cdecl;
    function autohidesScrollers: Boolean; cdecl;
    procedure setSupportsDragAndDrop(supportsDragAndDrop: Boolean); cdecl;
    function supportsDragAndDrop: Boolean; cdecl;
    procedure setEditable(editable: Boolean); cdecl;
    function editable: Boolean; cdecl;
    procedure setDoubleClickOpensImageEditPanel(doubleClickOpensImageEditPanel: Boolean); cdecl;
    function doubleClickOpensImageEditPanel: Boolean; cdecl;
    procedure setImageCorrection(imageCorrection: CIFilter); cdecl;
    function imageCorrection: CIFilter; cdecl;
    procedure setBackgroundColor(backgroundColor: NSColor); cdecl;
    function backgroundColor: NSColor; cdecl;
    procedure setImage(image: CGImageRef; imageProperties: NSDictionary); cdecl;
    procedure setImageWithURL(url: NSURL); cdecl;
    function image: CGImageRef; cdecl;
    function imageSize: NSSize; cdecl;
    function imageProperties: NSDictionary; cdecl;
    [MethodName('setRotationAngle:centerPoint:')]
    procedure setRotationAngleCenterPoint(rotationAngle: CGFloat; centerPoint: NSPoint); cdecl;
    procedure rotateImageLeft(sender: Pointer); cdecl;
    procedure rotateImageRight(sender: Pointer); cdecl;
    procedure setImageZoomFactor(zoomFactor: CGFloat; centerPoint: NSPoint); cdecl;
    procedure zoomImageToRect(rect: NSRect); cdecl;
    procedure zoomImageToFit(sender: Pointer); cdecl;
    procedure zoomImageToActualSize(sender: Pointer); cdecl;
    procedure zoomIn(sender: Pointer); cdecl;
    procedure zoomOut(sender: Pointer); cdecl;
    procedure flipImageHorizontal(sender: Pointer); cdecl;
    procedure flipImageVertical(sender: Pointer); cdecl;
    procedure crop(sender: Pointer); cdecl;
    procedure setOverlay(layer: CALayer; forType: NSString); cdecl;
    function overlayForType(layerType: NSString): CALayer; cdecl;
    procedure scrollToPoint(point: NSPoint); cdecl;
    procedure scrollToRect(rect: NSRect); cdecl;
    function convertViewPointToImagePoint(viewPoint: NSPoint): NSPoint; cdecl;
    function convertViewRectToImageRect(viewRect: NSRect): NSRect; cdecl;
    function convertImagePointToViewPoint(imagePoint: NSPoint): NSPoint; cdecl;
    function convertImageRectToViewRect(imageRect: NSRect): NSRect; cdecl;
  end;

  TIKImageView = class(TOCGenericImport<IKImageViewClass, IKImageView>)
  end;
  PIKImageView = Pointer;

  IKImageEditPanelClass = interface(NSPanelClass)
    ['{E0F292D8-137F-4B24-AE71-3AA16EBCF6C0}']
    {class} function sharedImageEditPanel: IKImageEditPanel; cdecl;
  end;
  IKImageEditPanel = interface(NSPanel)
    ['{80D8D3D5-D685-496A-871D-4898F578463A}']
    procedure setDataSource(dataSource: Pointer); cdecl;
    function dataSource: Pointer; cdecl;
    function filterArray: NSArray; cdecl;
    procedure reloadData; cdecl;
  end;

  TIKImageEditPanel = class(TOCGenericImport<IKImageEditPanelClass, IKImageEditPanel>)
  end;
  PIKImageEditPanel = Pointer;

  QLPreviewConvenienceAdditions = interface(IObjectiveC)
    ['{AEAC0F68-EEA5-4B6E-AEE9-C79168F46DDB}']
  end;

  QLPreviewPanelClass = interface(NSPanelClass)
    ['{89646669-4774-479D-91B7-0DB012BF0FCA}']
    {class} function sharedPreviewPanel: QLPreviewPanel; cdecl;
    {class} function sharedPreviewPanelExists: Boolean; cdecl;
  end;
  QLPreviewPanel = interface(NSPanel)
    ['{A420A868-3E4B-40A2-A39A-97E8F0591B34}']
    function currentController: Pointer; cdecl;
    procedure updateController; cdecl;
    procedure setDataSource(dataSource: Pointer); cdecl;
    function dataSource: Pointer; cdecl;
    procedure reloadData; cdecl;
    procedure refreshCurrentPreviewItem; cdecl;
    procedure setCurrentPreviewItemIndex(currentPreviewItemIndex: NSInteger); cdecl;
    function currentPreviewItemIndex: NSInteger; cdecl;
    function currentPreviewItem: Pointer; cdecl;
    procedure setDisplayState(displayState: Pointer); cdecl;
    function displayState: Pointer; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    function delegate: Pointer; cdecl;
    function enterFullScreenMode(screen: NSScreen; withOptions: NSDictionary): Boolean; cdecl;
    procedure exitFullScreenModeWithOptions(options: NSDictionary); cdecl;
    function isInFullScreenMode: Boolean; cdecl;
  end;

  TQLPreviewPanel = class(TOCGenericImport<QLPreviewPanelClass, QLPreviewPanel>)
  end;
  PQLPreviewPanel = Pointer;

  QLPreviewPanelController = interface(IObjectiveC)
    ['{76B34498-7D93-4E75-A469-F0770CFAC597}']
    function acceptsPreviewPanelControl(panel: QLPreviewPanel): Boolean; cdecl;
    procedure beginPreviewPanelControl(panel: QLPreviewPanel); cdecl;
    procedure endPreviewPanelControl(panel: QLPreviewPanel); cdecl;
  end;

  QLPreviewViewClass = interface(NSViewClass)
    ['{A9A013B0-5D44-4957-84AF-C00A4320F98F}']
  end;
  QLPreviewView = interface(NSView)
    ['{F3801446-0D5D-408D-BDDF-7C99911190C6}']
    [MethodName('initWithFrame:style:')]
    function initWithFrameStyle(frame: NSRect; style: QLPreviewViewStyle): Pointer; cdecl;
    [MethodName('initWithFrame:')]
    function initWithFrame(frame: NSRect): Pointer; cdecl;
    procedure setPreviewItem(previewItem: Pointer); cdecl;
    function previewItem: Pointer; cdecl;
    procedure refreshPreviewItem; cdecl;
    procedure setDisplayState(displayState: Pointer); cdecl;
    function displayState: Pointer; cdecl;
    procedure close; cdecl;
    procedure setShouldCloseWithWindow(shouldCloseWithWindow: Boolean); cdecl;
    function shouldCloseWithWindow: Boolean; cdecl;
    procedure setAutostarts(autostarts: Boolean); cdecl;
    function autostarts: Boolean; cdecl;
  end;

  TQLPreviewView = class(TOCGenericImport<QLPreviewViewClass, QLPreviewView>)
  end;
  PQLPreviewView = Pointer;

  // ===== Protocol declarations =====

  QCPlugInContext = interface(IObjectiveC)
    ['{49C315B7-7C77-4E53-83EA-79B85C835D97}']
    function compositionURL: NSURL; cdecl;
    procedure logMessage(format: NSString); cdecl;
    function userInfo: NSMutableDictionary; cdecl;
    function colorSpace: CGColorSpaceRef; cdecl;
    function bounds: NSRect; cdecl;
    function CGLContextObj: CGLContextObj; cdecl;
    function outputImageProviderFromBufferWithPixelFormat(format: NSString; pixelsWide: NSUInteger;
      pixelsHigh: NSUInteger; baseAddress: Pointer; bytesPerRow: NSUInteger;
      releaseCallback: QCPlugInBufferReleaseCallback; releaseContext: Pointer; colorSpace: CGColorSpaceRef;
      shouldColorMatch: Boolean): Pointer; cdecl;
    function outputImageProviderFromTextureWithPixelFormat(format: NSString; pixelsWide: NSUInteger;
      pixelsHigh: NSUInteger; name: GLuint; flipped: Boolean; releaseCallback: QCPlugInTextureReleaseCallback;
      releaseContext: Pointer; colorSpace: CGColorSpaceRef; shouldColorMatch: Boolean): Pointer; cdecl;
  end;

  QCPlugInInputImageSource = interface(IObjectiveC)
    ['{5E7D9450-2E96-4E5C-AA21-C51798EB0702}']
    function imageBounds: NSRect; cdecl;
    function imageColorSpace: CGColorSpaceRef; cdecl;
    function shouldColorMatch: Boolean; cdecl;
    function lockBufferRepresentationWithPixelFormat(format: NSString; colorSpace: CGColorSpaceRef; forBounds: NSRect)
      : Boolean; cdecl;
    function bufferPixelsWide: NSUInteger; cdecl;
    function bufferPixelsHigh: NSUInteger; cdecl;
    function bufferPixelFormat: NSString; cdecl;
    function bufferColorSpace: CGColorSpaceRef; cdecl;
    function bufferBaseAddress: Pointer; cdecl;
    function bufferBytesPerRow: NSUInteger; cdecl;
    procedure unlockBufferRepresentation; cdecl;
    function lockTextureRepresentationWithColorSpace(colorSpace: CGColorSpaceRef; forBounds: NSRect): Boolean; cdecl;
    function texturePixelsWide: NSUInteger; cdecl;
    function texturePixelsHigh: NSUInteger; cdecl;
    function textureTarget: GLenum; cdecl;
    function textureName: GLuint; cdecl;
    function textureColorSpace: CGColorSpaceRef; cdecl;
    function textureFlipped: Boolean; cdecl;
    function textureMatrix: GLfloat; cdecl;
    procedure bindTextureRepresentationToCGLContext(cgl_ctx: CGLContextObj; textureUnit: GLenum;
      normalizeCoordinates: Boolean); cdecl;
    procedure unbindTextureRepresentationFromCGLContext(cgl_ctx: CGLContextObj; textureUnit: GLenum); cdecl;
    procedure unlockTextureRepresentation; cdecl;
  end;

  QCPlugInOutputImageProvider = interface(IObjectiveC)
    ['{6A838EFE-90D2-4F82-A162-279E0B27E3D6}']
    function imageBounds: NSRect; cdecl;
    function imageColorSpace: CGColorSpaceRef; cdecl;
    function shouldColorMatch: Boolean; cdecl;
    function supportedBufferPixelFormats: NSArray; cdecl;
    function renderToBuffer(baseAddress: Pointer; withBytesPerRow: NSUInteger; pixelFormat: NSString; forBounds: NSRect)
      : Boolean; cdecl;
    function supportedRenderedTexturePixelFormats: NSArray; cdecl;
    function copyRenderedTextureForCGLContext(cgl_ctx: CGLContextObj; pixelFormat: NSString; bounds: NSRect;
      isFlipped: PBoolean): GLuint; cdecl;
    procedure releaseRenderedTexture(name: GLuint; forCGLContext: CGLContextObj); cdecl;
    function canRenderWithCGLContext(cgl_ctx: CGLContextObj): Boolean; cdecl;
    function renderWithCGLContext(cgl_ctx: CGLContextObj; forBounds: NSRect): Boolean; cdecl;
  end;

  QCCompositionRenderer = interface(IObjectiveC)
    ['{E96DA80A-7013-468D-9AFB-4F98235BA33C}']
    function attributes: NSDictionary; cdecl;
    function inputKeys: NSArray; cdecl;
    function outputKeys: NSArray; cdecl;
    function setValue(value: Pointer; forInputKey: NSString): Boolean; cdecl;
    function valueForInputKey(key: NSString): Pointer; cdecl;
    [MethodName('valueForOutputKey:')]
    function valueForOutputKey(key: NSString): Pointer; cdecl;
    [MethodName('valueForOutputKey:ofType:')]
    function valueForOutputKeyOfType(key: NSString; ofType: NSString): Pointer; cdecl;
    function propertyListFromInputValues: Pointer; cdecl;
    procedure setInputValuesWithPropertyList(plist: Pointer); cdecl;
    function userInfo: NSMutableDictionary; cdecl;
  end;

  IKFilterCustomUIProvider = interface(IObjectiveC)
    ['{63205FF7-5A7B-4F9A-960F-5CAE0578CB79}']
    function provideViewForUIConfiguration(inUIConfiguration: NSDictionary; excludedKeys: NSArray)
      : IKFilterUIView; cdecl;
  end;

  IKSlideshowDataSource = interface(IObjectiveC)
    ['{924C1DB9-BD0E-45EF-9FCC-32859892760A}']
    function numberOfSlideshowItems: NSUInteger; cdecl;
    function slideshowItemAtIndex(index: NSUInteger): Pointer; cdecl;
    function nameOfSlideshowItemAtIndex(index: NSUInteger): NSString; cdecl;
    function canExportSlideshowItemAtIndex(index: NSUInteger; toApplication: NSString): Boolean; cdecl;
    procedure slideshowWillStart; cdecl;
    procedure slideshowDidStop; cdecl;
    procedure slideshowDidChangeCurrentIndex(newIndex: NSUInteger); cdecl;
  end;

  IKImageEditPanelDataSource = interface(IObjectiveC)
    ['{3BD0FF1C-D62C-45EA-A316-0936C751D247}']
    function image: CGImageRef; cdecl;
    procedure setImage(image: CGImageRef; imageProperties: NSDictionary); cdecl;
    function thumbnailWithMaximumSize(size: NSSize): CGImageRef; cdecl;
    function imageProperties: NSDictionary; cdecl;
    function hasAdjustMode: Boolean; cdecl;
    function hasEffectsMode: Boolean; cdecl;
    function hasDetailsMode: Boolean; cdecl;
  end;

  QLPreviewItem = interface(IObjectiveC)
    ['{C6EFF720-836D-44B8-8ABA-C1A274F62167}']
    function previewItemURL: NSURL; cdecl;
    function previewItemTitle: NSString; cdecl;
    function previewItemDisplayState: Pointer; cdecl;
  end;

  QLPreviewPanelDelegate = interface(IObjectiveC)
    ['{7C5FCEEC-807E-49EE-BBE1-5D67794D1134}']
    [MethodName('previewPanel:handleEvent:')]
    function previewPanelHandleEvent(panel: QLPreviewPanel; handleEvent: NSEvent): Boolean; cdecl;
    [MethodName('previewPanel:sourceFrameOnScreenForPreviewItem:')]
    function previewPanelSourceFrameOnScreenForPreviewItem(panel: QLPreviewPanel;
      sourceFrameOnScreenForPreviewItem: Pointer): NSRect; cdecl;
    [MethodName('previewPanel:transitionImageForPreviewItem:contentRect:')]
    function previewPanelTransitionImageForPreviewItemContentRect(panel: QLPreviewPanel;
      transitionImageForPreviewItem: Pointer; contentRect: Pointer): Pointer; cdecl;
  end;

  QLPreviewPanelDataSource = interface(IObjectiveC)
    ['{3238F63F-61B8-4028-9C70-86B2242F5288}']
    function numberOfPreviewItemsInPreviewPanel(panel: QLPreviewPanel): NSInteger; cdecl;
    function previewPanel(panel: QLPreviewPanel; previewItemAtIndex: NSInteger): Pointer; cdecl;
  end;

  // ===== Exported string consts =====

function QCPlugInAttributeNameKey: NSString;
function QCPlugInAttributeDescriptionKey: NSString;
function QCPlugInAttributeCopyrightKey: NSString;
function QCPlugInAttributeCategoriesKey: NSString;
function QCPlugInAttributeExamplesKey: NSString;
function QCPortAttributeTypeKey: NSString;
function QCPortAttributeNameKey: NSString;
function QCPortAttributeMinimumValueKey: NSString;
function QCPortAttributeMaximumValueKey: NSString;
function QCPortAttributeDefaultValueKey: NSString;
function QCPortAttributeMenuItemsKey: NSString;
function QCPortTypeBoolean: NSString;
function QCPortTypeIndex: NSString;
function QCPortTypeNumber: NSString;
function QCPortTypeString: NSString;
function QCPortTypeColor: NSString;
function QCPortTypeImage: NSString;
function QCPortTypeStructure: NSString;
function QCPlugInPixelFormatARGB8: NSString;
function QCPlugInPixelFormatBGRA8: NSString;
function QCPlugInPixelFormatRGBAf: NSString;
function QCPlugInPixelFormatI8: NSString;
function QCPlugInPixelFormatIf: NSString;
function QCPlugInExecutionArgumentEventKey: NSString;
function QCPlugInExecutionArgumentMouseLocationKey: NSString;
function QCCompositionAttributeNameKey: NSString;
function QCCompositionAttributeDescriptionKey: NSString;
function QCCompositionAttributeCopyrightKey: NSString;
function QCCompositionAttributeBuiltInKey: NSString;
function QCCompositionAttributeIsTimeDependentKey: NSString;
function QCCompositionAttributeHasConsumersKey: NSString;
function QCCompositionAttributeCategoryKey: NSString;
function QCCompositionCategoryDistortion: NSString;
function QCCompositionCategoryStylize: NSString;
function QCCompositionCategoryUtility: NSString;
function QCCompositionInputImageKey: NSString;
function QCCompositionInputSourceImageKey: NSString;
function QCCompositionInputDestinationImageKey: NSString;
function QCCompositionInputRSSFeedURLKey: NSString;
function QCCompositionInputRSSArticleDurationKey: NSString;
function QCCompositionInputPreviewModeKey: NSString;
function QCCompositionInputXKey: NSString;
function QCCompositionInputYKey: NSString;
function QCCompositionInputScreenImageKey: NSString;
function QCCompositionInputAudioPeakKey: NSString;
function QCCompositionInputAudioSpectrumKey: NSString;
function QCCompositionInputTrackPositionKey: NSString;
function QCCompositionInputTrackInfoKey: NSString;
function QCCompositionInputTrackSignalKey: NSString;
function QCCompositionInputPrimaryColorKey: NSString;
function QCCompositionInputSecondaryColorKey: NSString;
function QCCompositionInputPaceKey: NSString;
function QCCompositionOutputImageKey: NSString;
function QCCompositionOutputWebPageURLKey: NSString;
function QCCompositionProtocolGraphicAnimation: NSString;
function QCCompositionProtocolGraphicTransition: NSString;
function QCCompositionProtocolImageFilter: NSString;
function QCCompositionProtocolScreenSaver: NSString;
function QCCompositionProtocolRSSVisualizer: NSString;
function QCCompositionProtocolMusicVisualizer: NSString;
function QCCompositionRepositoryDidUpdateNotification: NSString;
function QCRendererEventKey: NSString;
function QCRendererMouseLocationKey: NSString;
function QCViewDidStartRenderingNotification: NSString;
function QCViewDidStopRenderingNotification: NSString;
function QCCompositionPickerViewDidSelectCompositionNotification: NSString;
function QCCompositionPickerPanelDidSelectCompositionNotification: NSString;
function globalUpdateOK: Pointer;
function kQuartzFilterApplicationDomain: NSString;
function kQuartzFilterPDFWorkflowDomain: NSString;
function kQuartzFilterPrintingDomain: NSString;
function kQuartzFilterManagerDidAddFilterNotification: NSString;
function kQuartzFilterManagerDidRemoveFilterNotification: NSString;
function kQuartzFilterManagerDidModifyFilterNotification: NSString;
function kQuartzFilterManagerDidSelectFilterNotification: NSString;
function PDFDocumentDidUnlockNotification: NSString;
function PDFDocumentDidBeginFindNotification: NSString;
function PDFDocumentDidEndFindNotification: NSString;
function PDFDocumentDidBeginPageFindNotification: NSString;
function PDFDocumentDidEndPageFindNotification: NSString;
function PDFDocumentDidFindMatchNotification: NSString;
function PDFDocumentDidBeginWriteNotification: NSString;
function PDFDocumentDidEndWriteNotification: NSString;
function PDFDocumentDidBeginPageWriteNotification: NSString;
function PDFDocumentDidEndPageWriteNotification: NSString;
function PDFDocumentTitleAttribute: NSString;
function PDFDocumentAuthorAttribute: NSString;
function PDFDocumentSubjectAttribute: NSString;
function PDFDocumentCreatorAttribute: NSString;
function PDFDocumentProducerAttribute: NSString;
function PDFDocumentCreationDateAttribute: NSString;
function PDFDocumentModificationDateAttribute: NSString;
function PDFDocumentKeywordsAttribute: NSString;
function PDFThumbnailViewDocumentEditedNotification: NSString;
function PDFViewDocumentChangedNotification: NSString;
function PDFViewChangedHistoryNotification: NSString;
function PDFViewPageChangedNotification: NSString;
function PDFViewScaleChangedNotification: NSString;
function PDFViewAnnotationHitNotification: NSString;
function PDFViewCopyPermissionNotification: NSString;
function PDFViewPrintPermissionNotification: NSString;
function PDFViewAnnotationWillHitNotification: NSString;
function PDFViewSelectionChangedNotification: NSString;
function PDFViewDisplayModeChangedNotification: NSString;
function PDFViewDisplayBoxChangedNotification: NSString;
function IKImageBrowserPathRepresentationType: NSString;
function IKImageBrowserNSURLRepresentationType: NSString;
function IKImageBrowserNSImageRepresentationType: NSString;
function IKImageBrowserCGImageRepresentationType: NSString;
function IKImageBrowserCGImageSourceRepresentationType: NSString;
function IKImageBrowserNSDataRepresentationType: NSString;
function IKImageBrowserNSBitmapImageRepresentationType: NSString;
function IKImageBrowserQTMovieRepresentationType: NSString;
function IKImageBrowserQTMoviePathRepresentationType: NSString;
function IKImageBrowserQCCompositionRepresentationType: NSString;
function IKImageBrowserQCCompositionPathRepresentationType: NSString;
function IKImageBrowserQuickLookPathRepresentationType: NSString;
function IKImageBrowserIconRefPathRepresentationType: NSString;
function IKImageBrowserIconRefRepresentationType: NSString;
function IKImageBrowserPDFPageRepresentationType: NSString;
function IKImageBrowserBackgroundColorKey: NSString;
function IKImageBrowserSelectionColorKey: NSString;
function IKImageBrowserCellsOutlineColorKey: NSString;
function IKImageBrowserCellsTitleAttributesKey: NSString;
function IKImageBrowserCellsHighlightedTitleAttributesKey: NSString;
function IKImageBrowserCellsSubtitleAttributesKey: NSString;
function IKImageBrowserGroupRangeKey: NSString;
function IKImageBrowserGroupBackgroundColorKey: NSString;
function IKImageBrowserGroupTitleKey: NSString;
function IKImageBrowserGroupStyleKey: NSString;
function IKImageBrowserGroupHeaderLayer: NSString;
function IKImageBrowserGroupFooterLayer: NSString;
function IKImageBrowserCellBackgroundLayer: NSString;
function IKImageBrowserCellForegroundLayer: NSString;
function IKImageBrowserCellSelectionLayer: NSString;
function IKImageBrowserCellPlaceHolderLayer: NSString;
function IKPictureTakerAllowsVideoCaptureKey: NSString;
function IKPictureTakerAllowsFileChoosingKey: NSString;
function IKPictureTakerShowRecentPictureKey: NSString;
function IKPictureTakerUpdateRecentPictureKey: NSString;
function IKPictureTakerAllowsEditingKey: NSString;
function IKPictureTakerShowEffectsKey: NSString;
function IKPictureTakerInformationalTextKey: NSString;
function IKPictureTakerImageTransformsKey: NSString;
function IKPictureTakerOutputImageMaxSizeKey: NSString;
function IKPictureTakerShowAddressBookPictureKey: NSString;
function IKPictureTakerShowEmptyPictureKey: NSString;
function IKPictureTakerRemainOpenAfterValidateKey: NSString;
function IKUISizeFlavor: NSString;
function IKUISizeMini: NSString;
function IKUISizeSmall: NSString;
function IKUISizeRegular: NSString;
function IKUImaxSize: NSString;
function IKUIFlavorAllowFallback: NSString;
function IKFilterBrowserFilterSelectedNotification: NSString;
function IKFilterBrowserFilterDoubleClickNotification: NSString;
function IKFilterBrowserWillPreviewFilterNotification: NSString;
function IKFilterBrowserShowCategories: NSString;
function IKFilterBrowserShowPreview: NSString;
function IKFilterBrowserExcludeCategories: NSString;
function IKFilterBrowserExcludeFilters: NSString;
function IKFilterBrowserDefaultInputImage: NSString;
function IKSlideshowModeImages: NSString;
function IKSlideshowModePDF: NSString;
function IKSlideshowModeOther: NSString;
function IKSlideshowWrapAround: NSString;
function IKSlideshowStartPaused: NSString;
function IKSlideshowStartIndex: NSString;
function IKSlideshowScreen: NSString;
function IKSlideshowAudioFile: NSString;
function IKSlideshowPDFDisplayBox: NSString;
function IKSlideshowPDFDisplayMode: NSString;
function IKSlideshowPDFDisplaysAsBook: NSString;
function IK_iPhotoBundleIdentifier: NSString;
function IK_ApertureBundleIdentifier: NSString;
function IK_MailBundleIdentifier: NSString;
function IKToolModeNone: NSString;
function IKToolModeMove: NSString;
function IKToolModeSelect: NSString;
function IKToolModeSelectRect: NSString;
function IKToolModeSelectEllipse: NSString;
function IKToolModeSelectLasso: NSString;
function IKToolModeCrop: NSString;
function IKToolModeRotate: NSString;
function IKToolModeAnnotate: NSString;
function IKOverlayTypeBackground: NSString;
function IKOverlayTypeImage: NSString;
function IKPictureTakerShowAddressBookPicture: NSString;
function IKPictureTakerShowEmptyPicture: NSString;
function IKPictureTakerCropAreaSizeKey: NSString;


// ===== External functions =====

const
  libQuartz = '/System/Library/Frameworks/Quartz.framework/Quartz';

implementation

function QCPlugInAttributeNameKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPlugInAttributeNameKey');
end;

function QCPlugInAttributeDescriptionKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPlugInAttributeDescriptionKey');
end;

function QCPlugInAttributeCopyrightKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPlugInAttributeCopyrightKey');
end;

function QCPlugInAttributeCategoriesKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPlugInAttributeCategoriesKey');
end;

function QCPlugInAttributeExamplesKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPlugInAttributeExamplesKey');
end;

function QCPortAttributeTypeKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPortAttributeTypeKey');
end;

function QCPortAttributeNameKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPortAttributeNameKey');
end;

function QCPortAttributeMinimumValueKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPortAttributeMinimumValueKey');
end;

function QCPortAttributeMaximumValueKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPortAttributeMaximumValueKey');
end;

function QCPortAttributeDefaultValueKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPortAttributeDefaultValueKey');
end;

function QCPortAttributeMenuItemsKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPortAttributeMenuItemsKey');
end;

function QCPortTypeBoolean: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPortTypeBoolean');
end;

function QCPortTypeIndex: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPortTypeIndex');
end;

function QCPortTypeNumber: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPortTypeNumber');
end;

function QCPortTypeString: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPortTypeString');
end;

function QCPortTypeColor: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPortTypeColor');
end;

function QCPortTypeImage: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPortTypeImage');
end;

function QCPortTypeStructure: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPortTypeStructure');
end;

function QCPlugInPixelFormatARGB8: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPlugInPixelFormatARGB8');
end;

function QCPlugInPixelFormatBGRA8: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPlugInPixelFormatBGRA8');
end;

function QCPlugInPixelFormatRGBAf: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPlugInPixelFormatRGBAf');
end;

function QCPlugInPixelFormatI8: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPlugInPixelFormatI8');
end;

function QCPlugInPixelFormatIf: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPlugInPixelFormatIf');
end;

function QCPlugInExecutionArgumentEventKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPlugInExecutionArgumentEventKey');
end;

function QCPlugInExecutionArgumentMouseLocationKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCPlugInExecutionArgumentMouseLocationKey');
end;

function QCCompositionAttributeNameKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionAttributeNameKey');
end;

function QCCompositionAttributeDescriptionKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionAttributeDescriptionKey');
end;

function QCCompositionAttributeCopyrightKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionAttributeCopyrightKey');
end;

function QCCompositionAttributeBuiltInKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionAttributeBuiltInKey');
end;

function QCCompositionAttributeIsTimeDependentKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionAttributeIsTimeDependentKey');
end;

function QCCompositionAttributeHasConsumersKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionAttributeHasConsumersKey');
end;

function QCCompositionAttributeCategoryKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionAttributeCategoryKey');
end;

function QCCompositionCategoryDistortion: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionCategoryDistortion');
end;

function QCCompositionCategoryStylize: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionCategoryStylize');
end;

function QCCompositionCategoryUtility: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionCategoryUtility');
end;

function QCCompositionInputImageKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputImageKey');
end;

function QCCompositionInputSourceImageKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputSourceImageKey');
end;

function QCCompositionInputDestinationImageKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputDestinationImageKey');
end;

function QCCompositionInputRSSFeedURLKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputRSSFeedURLKey');
end;

function QCCompositionInputRSSArticleDurationKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputRSSArticleDurationKey');
end;

function QCCompositionInputPreviewModeKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputPreviewModeKey');
end;

function QCCompositionInputXKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputXKey');
end;

function QCCompositionInputYKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputYKey');
end;

function QCCompositionInputScreenImageKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputScreenImageKey');
end;

function QCCompositionInputAudioPeakKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputAudioPeakKey');
end;

function QCCompositionInputAudioSpectrumKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputAudioSpectrumKey');
end;

function QCCompositionInputTrackPositionKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputTrackPositionKey');
end;

function QCCompositionInputTrackInfoKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputTrackInfoKey');
end;

function QCCompositionInputTrackSignalKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputTrackSignalKey');
end;

function QCCompositionInputPrimaryColorKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputPrimaryColorKey');
end;

function QCCompositionInputSecondaryColorKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputSecondaryColorKey');
end;

function QCCompositionInputPaceKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionInputPaceKey');
end;

function QCCompositionOutputImageKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionOutputImageKey');
end;

function QCCompositionOutputWebPageURLKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionOutputWebPageURLKey');
end;

function QCCompositionProtocolGraphicAnimation: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionProtocolGraphicAnimation');
end;

function QCCompositionProtocolGraphicTransition: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionProtocolGraphicTransition');
end;

function QCCompositionProtocolImageFilter: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionProtocolImageFilter');
end;

function QCCompositionProtocolScreenSaver: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionProtocolScreenSaver');
end;

function QCCompositionProtocolRSSVisualizer: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionProtocolRSSVisualizer');
end;

function QCCompositionProtocolMusicVisualizer: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionProtocolMusicVisualizer');
end;

function QCCompositionRepositoryDidUpdateNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionRepositoryDidUpdateNotification');
end;

function QCRendererEventKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCRendererEventKey');
end;

function QCRendererMouseLocationKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCRendererMouseLocationKey');
end;

function QCViewDidStartRenderingNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCViewDidStartRenderingNotification');
end;

function QCViewDidStopRenderingNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCViewDidStopRenderingNotification');
end;

function QCCompositionPickerViewDidSelectCompositionNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionPickerViewDidSelectCompositionNotification');
end;

function QCCompositionPickerPanelDidSelectCompositionNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'QCCompositionPickerPanelDidSelectCompositionNotification');
end;

function kQuartzFilterApplicationDomain: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'kQuartzFilterApplicationDomain');
end;

function kQuartzFilterPDFWorkflowDomain: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'kQuartzFilterPDFWorkflowDomain');
end;

function kQuartzFilterPrintingDomain: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'kQuartzFilterPrintingDomain');
end;

function kQuartzFilterManagerDidAddFilterNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'kQuartzFilterManagerDidAddFilterNotification');
end;

function kQuartzFilterManagerDidRemoveFilterNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'kQuartzFilterManagerDidRemoveFilterNotification');
end;

function kQuartzFilterManagerDidModifyFilterNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'kQuartzFilterManagerDidModifyFilterNotification');
end;

function kQuartzFilterManagerDidSelectFilterNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'kQuartzFilterManagerDidSelectFilterNotification');
end;

function PDFDocumentDidUnlockNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentDidUnlockNotification');
end;

function PDFDocumentDidBeginFindNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentDidBeginFindNotification');
end;

function PDFDocumentDidEndFindNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentDidEndFindNotification');
end;

function PDFDocumentDidBeginPageFindNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentDidBeginPageFindNotification');
end;

function PDFDocumentDidEndPageFindNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentDidEndPageFindNotification');
end;

function PDFDocumentDidFindMatchNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentDidFindMatchNotification');
end;

function PDFDocumentDidBeginWriteNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentDidBeginWriteNotification');
end;

function PDFDocumentDidEndWriteNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentDidEndWriteNotification');
end;

function PDFDocumentDidBeginPageWriteNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentDidBeginPageWriteNotification');
end;

function PDFDocumentDidEndPageWriteNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentDidEndPageWriteNotification');
end;

function PDFDocumentTitleAttribute: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentTitleAttribute');
end;

function PDFDocumentAuthorAttribute: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentAuthorAttribute');
end;

function PDFDocumentSubjectAttribute: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentSubjectAttribute');
end;

function PDFDocumentCreatorAttribute: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentCreatorAttribute');
end;

function PDFDocumentProducerAttribute: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentProducerAttribute');
end;

function PDFDocumentCreationDateAttribute: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentCreationDateAttribute');
end;

function PDFDocumentModificationDateAttribute: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentModificationDateAttribute');
end;

function PDFDocumentKeywordsAttribute: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFDocumentKeywordsAttribute');
end;

function PDFThumbnailViewDocumentEditedNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFThumbnailViewDocumentEditedNotification');
end;

function PDFViewDocumentChangedNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFViewDocumentChangedNotification');
end;

function PDFViewChangedHistoryNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFViewChangedHistoryNotification');
end;

function PDFViewPageChangedNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFViewPageChangedNotification');
end;

function PDFViewScaleChangedNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFViewScaleChangedNotification');
end;

function PDFViewAnnotationHitNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFViewAnnotationHitNotification');
end;

function PDFViewCopyPermissionNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFViewCopyPermissionNotification');
end;

function PDFViewPrintPermissionNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFViewPrintPermissionNotification');
end;

function PDFViewAnnotationWillHitNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFViewAnnotationWillHitNotification');
end;

function PDFViewSelectionChangedNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFViewSelectionChangedNotification');
end;

function PDFViewDisplayModeChangedNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFViewDisplayModeChangedNotification');
end;

function PDFViewDisplayBoxChangedNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'PDFViewDisplayBoxChangedNotification');
end;

function IKImageBrowserPathRepresentationType: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserPathRepresentationType');
end;

function IKImageBrowserNSURLRepresentationType: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserNSURLRepresentationType');
end;

function IKImageBrowserNSImageRepresentationType: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserNSImageRepresentationType');
end;

function IKImageBrowserCGImageRepresentationType: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserCGImageRepresentationType');
end;

function IKImageBrowserCGImageSourceRepresentationType: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserCGImageSourceRepresentationType');
end;

function IKImageBrowserNSDataRepresentationType: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserNSDataRepresentationType');
end;

function IKImageBrowserNSBitmapImageRepresentationType: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserNSBitmapImageRepresentationType');
end;

function IKImageBrowserQTMovieRepresentationType: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserQTMovieRepresentationType');
end;

function IKImageBrowserQTMoviePathRepresentationType: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserQTMoviePathRepresentationType');
end;

function IKImageBrowserQCCompositionRepresentationType: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserQCCompositionRepresentationType');
end;

function IKImageBrowserQCCompositionPathRepresentationType: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserQCCompositionPathRepresentationType');
end;

function IKImageBrowserQuickLookPathRepresentationType: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserQuickLookPathRepresentationType');
end;

function IKImageBrowserIconRefPathRepresentationType: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserIconRefPathRepresentationType');
end;

function IKImageBrowserIconRefRepresentationType: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserIconRefRepresentationType');
end;

function IKImageBrowserPDFPageRepresentationType: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserPDFPageRepresentationType');
end;

function IKImageBrowserBackgroundColorKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserBackgroundColorKey');
end;

function IKImageBrowserSelectionColorKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserSelectionColorKey');
end;

function IKImageBrowserCellsOutlineColorKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserCellsOutlineColorKey');
end;

function IKImageBrowserCellsTitleAttributesKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserCellsTitleAttributesKey');
end;

function IKImageBrowserCellsHighlightedTitleAttributesKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserCellsHighlightedTitleAttributesKey');
end;

function IKImageBrowserCellsSubtitleAttributesKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserCellsSubtitleAttributesKey');
end;

function IKImageBrowserGroupRangeKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserGroupRangeKey');
end;

function IKImageBrowserGroupBackgroundColorKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserGroupBackgroundColorKey');
end;

function IKImageBrowserGroupTitleKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserGroupTitleKey');
end;

function IKImageBrowserGroupStyleKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserGroupStyleKey');
end;

function IKImageBrowserGroupHeaderLayer: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserGroupHeaderLayer');
end;

function IKImageBrowserGroupFooterLayer: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserGroupFooterLayer');
end;

function IKImageBrowserCellBackgroundLayer: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserCellBackgroundLayer');
end;

function IKImageBrowserCellForegroundLayer: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserCellForegroundLayer');
end;

function IKImageBrowserCellSelectionLayer: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserCellSelectionLayer');
end;

function IKImageBrowserCellPlaceHolderLayer: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKImageBrowserCellPlaceHolderLayer');
end;

function IKPictureTakerAllowsVideoCaptureKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKPictureTakerAllowsVideoCaptureKey');
end;

function IKPictureTakerAllowsFileChoosingKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKPictureTakerAllowsFileChoosingKey');
end;

function IKPictureTakerShowRecentPictureKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKPictureTakerShowRecentPictureKey');
end;

function IKPictureTakerUpdateRecentPictureKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKPictureTakerUpdateRecentPictureKey');
end;

function IKPictureTakerAllowsEditingKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKPictureTakerAllowsEditingKey');
end;

function IKPictureTakerShowEffectsKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKPictureTakerShowEffectsKey');
end;

function IKPictureTakerInformationalTextKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKPictureTakerInformationalTextKey');
end;

function IKPictureTakerImageTransformsKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKPictureTakerImageTransformsKey');
end;

function IKPictureTakerOutputImageMaxSizeKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKPictureTakerOutputImageMaxSizeKey');
end;

function IKPictureTakerShowAddressBookPictureKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKPictureTakerShowAddressBookPictureKey');
end;

function IKPictureTakerShowEmptyPictureKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKPictureTakerShowEmptyPictureKey');
end;

function IKPictureTakerRemainOpenAfterValidateKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKPictureTakerRemainOpenAfterValidateKey');
end;

function IKUISizeFlavor: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKUISizeFlavor');
end;

function IKUISizeMini: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKUISizeMini');
end;

function IKUISizeSmall: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKUISizeSmall');
end;

function IKUISizeRegular: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKUISizeRegular');
end;

function IKUImaxSize: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKUImaxSize');
end;

function IKUIFlavorAllowFallback: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKUIFlavorAllowFallback');
end;

function IKFilterBrowserFilterSelectedNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKFilterBrowserFilterSelectedNotification');
end;

function IKFilterBrowserFilterDoubleClickNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKFilterBrowserFilterDoubleClickNotification');
end;

function IKFilterBrowserWillPreviewFilterNotification: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKFilterBrowserWillPreviewFilterNotification');
end;

function IKFilterBrowserShowCategories: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKFilterBrowserShowCategories');
end;

function IKFilterBrowserShowPreview: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKFilterBrowserShowPreview');
end;

function IKFilterBrowserExcludeCategories: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKFilterBrowserExcludeCategories');
end;

function IKFilterBrowserExcludeFilters: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKFilterBrowserExcludeFilters');
end;

function IKFilterBrowserDefaultInputImage: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKFilterBrowserDefaultInputImage');
end;

function IKSlideshowModeImages: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKSlideshowModeImages');
end;

function IKSlideshowModePDF: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKSlideshowModePDF');
end;

function IKSlideshowModeOther: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKSlideshowModeOther');
end;

function IKSlideshowWrapAround: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKSlideshowWrapAround');
end;

function IKSlideshowStartPaused: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKSlideshowStartPaused');
end;

function IKSlideshowStartIndex: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKSlideshowStartIndex');
end;

function IKSlideshowScreen: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKSlideshowScreen');
end;

function IKSlideshowAudioFile: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKSlideshowAudioFile');
end;

function IKSlideshowPDFDisplayBox: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKSlideshowPDFDisplayBox');
end;

function IKSlideshowPDFDisplayMode: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKSlideshowPDFDisplayMode');
end;

function IKSlideshowPDFDisplaysAsBook: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKSlideshowPDFDisplaysAsBook');
end;

function IK_iPhotoBundleIdentifier: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IK_iPhotoBundleIdentifier');
end;

function IK_ApertureBundleIdentifier: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IK_ApertureBundleIdentifier');
end;

function IK_MailBundleIdentifier: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IK_MailBundleIdentifier');
end;

function IKToolModeNone: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKToolModeNone');
end;

function IKToolModeMove: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKToolModeMove');
end;

function IKToolModeSelect: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKToolModeSelect');
end;

function IKToolModeSelectRect: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKToolModeSelectRect');
end;

function IKToolModeSelectEllipse: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKToolModeSelectEllipse');
end;

function IKToolModeSelectLasso: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKToolModeSelectLasso');
end;

function IKToolModeCrop: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKToolModeCrop');
end;

function IKToolModeRotate: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKToolModeRotate');
end;

function IKToolModeAnnotate: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKToolModeAnnotate');
end;

function IKOverlayTypeBackground: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKOverlayTypeBackground');
end;

function IKOverlayTypeImage: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKOverlayTypeImage');
end;

function IKPictureTakerShowAddressBookPicture: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKPictureTakerShowAddressBookPicture');
end;

function IKPictureTakerShowEmptyPicture: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKPictureTakerShowEmptyPicture');
end;

function IKPictureTakerCropAreaSizeKey: NSString;
begin
  Result := CocoaNSStringConst(libQuartz, 'IKPictureTakerCropAreaSizeKey');
end;

function globalUpdateOK: Pointer;
begin
  Result := CocoaPointerConst(libQuartz, 'globalUpdateOK');
end;

end.
