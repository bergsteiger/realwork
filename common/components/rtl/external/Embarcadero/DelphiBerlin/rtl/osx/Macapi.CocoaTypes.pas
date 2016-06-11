{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Macapi.CocoaTypes;

interface

uses
  System.Types, Posix.SysTypes, Posix.StdDef, Macapi.CoreFoundation, Macapi.CoreServices;

const
  NSDecimalMaxSize = 8;

type
{$M+}
  NSUInteger = LongWord;
  PNSUInteger = ^NSUInteger;
  NSInteger = LongInt;
  PNSInteger = ^NSInteger;
  NSTimeInterval = Double;
  PNSTimeInterval = ^NSTimeInterval;
  {$IF defined(CPU32BITS)}
  CGFloat = Single;
  {$ELSEIF defined(CPU64BITS)}
  CGFloat = Double;
  {$ENDIF}
  PCGFloat = ^CGFloat;
  PUInt16 = ^UInt16;
  SEL = Pointer;
  ID = Pointer;
  
  NSRange = record
    location: NSUInteger;
    length: NSUInteger;
  end;
  PNSRange = ^NSRange;

  NSDecimal = record
    _exponent: Integer;
    _length: Cardinal;
    _isNegative: Cardinal;
    _isCompact: Cardinal;
    _mantissa: array [0..NSDecimalMaxSize - 1] of Word;
  end;
  PNSDecimal = ^NSDecimal;

  NSPoint = record
    x: CGFloat;
    y: CGFloat;
    constructor Create(const Origin: TPointF);
    function ToPointF: TPointF;
  end;
  PNSPoint = ^NSPoint;
  CGPoint = NSPoint;
  PCGPoint = ^CGPoint;

  NSSize = record
    width: CGFloat;
    height: CGFloat;
    constructor Create(const Origin: TSizeF);
    function ToSizeF: TSizeF;
    function ToPointF: TPointF;
  end;
  PNSSize = ^NSSize;
  CGSize = NSSize;
  PCGSize = ^CGSize;

  NSRect = record
    origin: NSPoint;
    size: NSSize;
    constructor Create(const Origin: TRectF);
    function ToSizeF: TSizeF;
    function ToRectF: TRectF;
  end;
  PNSRect = ^NSRect;
  CGRect = NSRect;
  PCGRect = ^CGRect;

  PMRect = record
	  top: Double;
	  left: Double;
	  bottom: Double;
	  right: Double;
  end;
  PPMRect = ^PMRect;

  NSAffineTransformStruct = record
    m11: CGFloat;
    m12: CGFloat;
    m21: CGFloat;
    m22: CGFloat;
    tX: CGFloat;
    tY: CGFloat;
  end;
  PNSAffineTransformStruct = ^NSAffineTransformStruct;

  CGAffineTransform = record
    a: CGFloat;
    b: CGFloat;
    c: CGFloat;
    d: CGFloat;
    tx: CGFloat;
    ty: CGFloat;
  end;
  PCGAffineTransform = ^CGAffineTransform;

  CVSMPTETime = record
    subframes: SInt16;
    subframeDivisor: SInt16;
    counter: UInt32;
    type_: UInt32;
    flags: UInt32;
    hours: SInt16;
    minutes: SInt16;
    seconds: SInt16;
    frames: SInt16;
  end;
  SMPTETime = CVSMPTETime;

  CVTime = record
    timeValue: Int64;
    timeScale: Int64;
    flags: Integer;
  end;

  CVTimeStamp = record
    version: UInt32;
    videoTimeScale: Integer;
    videoTime: Int64;
    hostTime: UInt64;
    rateScalar: Double;
    videoRefreshPeriod: Int64;
    smpteTime: CVSMPTETime;
    flags: UInt64;
    reserved: UInt64;
  end;
  PCVTimeStamp = ^CVTimeStamp;

  ResType = FourCharCode;
  DescType = ResType;
  AEDataStorage = Pointer;
  AEEventClass = FourCharCode;
  AEKeyword = FourCharCode;
  AEEventID = FourCharCode;
  AEReturnID = Int16;
  AETransactionID = Int32;
  AEDesc = record
    descriptorType: DescType;
    dataHandle: AEDataStorage;
  end;
  PAEDesc = ^AEDesc;

  // CoreGraphics data callbacks
  CGDataConsumerPutBytesCallback = function(info: Pointer; buffer: Pointer; count: size_t): size_t; cdecl;
  CGDataConsumerReleaseInfoCallback = procedure(info: Pointer); cdecl;

  CGDataConsumerCallbacks = record
    putBytes: CGDataConsumerPutBytesCallback;
    releaseConsumer: CGDataConsumerReleaseInfoCallback;
  end;
  PCGDataConsumerCallbacks = ^CGDataConsumerCallbacks;

  CGDataProviderGetBytesCallback = function(info: Pointer; buffer: Pointer; count: size_t): size_t; cdecl;
  CGDataProviderSkipBytesCallback = procedure(info: Pointer; count: size_t); cdecl;
  CGDataProviderRewindCallback = procedure(info: Pointer); cdecl;
  CGDataProviderReleaseInfoCallback = procedure(info: Pointer); cdecl;
  CGDataProviderGetBytePointerCallback  = function(info: Pointer): Pointer; cdecl;
  CGDataProviderReleaseBytePointerCallback = procedure(info: Pointer; ptr: Pointer); cdecl;
  CGDataProviderGetBytesAtPositionCallback = function(info: Pointer; buffer: Pointer; position: off_t; count: size_t): size_t; cdecl;
  CGDataProviderGetBytesAtOffsetCallback = function(info: Pointer; buffer: Pointer; offset: size_t; count: size_t): size_t; cdecl;
  CGDataProviderSkipForwardCallback = function(info: Pointer; count: size_t): off_t; cdecl;
  CGDataProviderReleaseDataCallback = procedure(info: Pointer; data: Pointer; size: size_t); cdecl;

  CGDataProviderCallbacks = record
    getBytes: CGDataProviderGetBytesCallback;
    skipBytes: CGDataProviderSkipBytesCallback;
    rewind: CGDataProviderRewindCallback;
    releaseProvider: CGDataProviderReleaseInfoCallback;
  end;
  PCGDataProviderCallbacks = ^CGDataProviderCallbacks;

  CGDataProviderDirectCallbacks = record
    version: UInt32;
    getBytePointer: CGDataProviderGetBytePointerCallback;
    releaseBytePointer: CGDataProviderReleaseBytePointerCallback;
    getBytesAtPosition: CGDataProviderGetBytesAtPositionCallback;
    releaseProvider: CGDataProviderReleaseInfoCallback;
  end;
  PCGDataProviderDirectCallbacks = ^CGDataProviderDirectCallbacks;

  CGDataProviderDirectAccessCallbacks = record
    getBytePointer: CGDataProviderGetBytePointerCallback;
    releaseBytePointer: CGDataProviderReleaseBytePointerCallback;
    getBytes: CGDataProviderGetBytesAtOffsetCallback;
    releaseProvider: CGDataProviderReleaseInfoCallback;
  end;
  PCGDataProviderDirectAccessCallbacks = ^CGDataProviderDirectAccessCallbacks;

  CGDataProviderSequentialCallbacks = record
    version: UInt32;
    getBytes: CGDataProviderGetBytesCallback;
    skipForward: CGDataProviderSkipForwardCallback;
    rewind: CGDataProviderRewindCallback;
    releaseInfo: CGDataProviderReleaseInfoCallback;
  end;
  PCGDataProviderSequentialCallbacks = ^CGDataProviderSequentialCallbacks;

  CGDeviceColor = record
    red: Single;
    green: Single;
    blue: Single;
  end;
  PCGDeviceColor = ^CGDeviceColor;

  CGDeviceByteColor = record
    red: Byte;
    green: Byte;
    blue: Byte;
  end;
  PCGDeviceByteColor = ^CGDeviceByteColor;
  
  PMLanguageInfo = record
    level: Str32;
	version: Str32;
	release: Str32;
  end;
  PPMLanguageInfo = ^PMLanguageInfo;
  
  PMResolution = record
    hRes: Double;
	vRes: Double;
  end;
  PPMResolution = ^PMResolution;

  // Typedefs for Cocoa Foundation, OpenGL, QuartzCore and AppKit frameworks
  ATSFontRef = UInt32;
  AudioChannelLabel = UInt32;
  AudioChannelLayoutTag = UInt32;
  AVAssetExportSessionStatus = NSInteger;
  AVAssetReaderStatus = NSInteger;
  AVAssetReferenceRestrictions = NSUInteger;
  AVAssetWriterStatus = NSInteger;
  AVCaptureDevicePosition = NSInteger;
  AVCaptureDeviceTransportControlsPlaybackMode = NSInteger;
  AVCaptureDeviceTransportControlsSpeed = NSInteger;
  AVCaptureExposureMode = NSInteger;
  AVCaptureFlashMode = NSInteger;
  AVCaptureFocusMode = NSInteger;
  AVCaptureTorchMode = NSInteger;
  AVCaptureVideoOrientation = NSInteger;
  AVCaptureWhiteBalanceMode = NSInteger;
  AVContentAuthorizationStatus = NSInteger;
  AVKeyValueStatus = NSInteger;
  AVPlayerStatus = NSInteger;
  AVPlayerActionAtItemEnd = NSInteger;
  AVPlayerItemStatus = NSInteger;
  AVVideoFieldMode = NSInteger;
  CAConstraintAttribute = Integer;
  CGBitmapInfo = UInt32;
  CGBlendMode = UInt32;
  CGButtonCount = UInt32;
  CGCaptureOptions = UInt32;
  CGCharCode = Word;
  CGColorRef = Pointer;
  CGColorRenderingIntent = UInt32;
  CGColorSpaceModel = Integer;
  CGColorSpaceRef = Pointer;
  CGConfigureOption = UInt32;
  CGContextRef = Pointer;
  PCGContextRef = ^CGContextRef;
  CGDataConsumerRef = Pointer;
  CGDataProviderRef = Pointer;
  CGDirectDisplayID = UInt32;
  PCGDirectDisplayID = ^CGDirectDisplayID;
  CGDirectPaletteRef = Pointer;
  CGDisplayBlendFraction = Single;
  CGDisplayChangeSummaryFlags = UInt32;
  CGDisplayConfigRef = Pointer;
  CGDisplayFadeInterval = Single;
  CGDisplayFadeReservationToken = UInt32;
  PCGDisplayFadeReservationToken = ^CGDisplayFadeReservationToken;
  CGDisplayModeRef = Pointer;
  CGDisplayReservationInterval = Single;
  CGError = Integer;
  CGEventField = UInt32;
  CGEventFilterMask = UInt32;
  CGEventFlags = UInt64;
  CGEventMask = UInt64;
  CGEventRef = Pointer;
  CGEventSourceKeyboardType = UInt32;
  CGEventSourceRef = Pointer;
  CGEventSourceStateID = Integer;
  CGEventSourceSuppressionState = UInt32;
  CGEventSuppressionState = UInt32;
  CGEventTapLocation = UInt32;
  CGEventTapOptions = UInt32;
  CGEventTapPlacement = UInt32;
  CGEventTapProxy = Pointer;
  CGEventTimestamp = UInt64;
  CGEventType = UInt32;
  CGFontIndex = Word;
  CGFontPostScriptFormat = UInt32;
  CGFontRef = Pointer;
  CGFunctionRef = Pointer;
  CGGammaValue = Single;
  PCGGammaValue = ^CGGammaValue;
  CGGlyph = Word;
  PCGGlyph = ^CGGlyph;
  CGGradientDrawingOptions = UInt32;
  CGGradientRef = Pointer;
  CGImageAlphaInfo = UInt32;
  CGImageDestinationRef = Pointer;
  CGImageRef = Pointer;
  CGImageSourceRef = Pointer;
  CGImageSourceStatus = NSInteger;
  CGInterpolationQuality = UInt32;
  CGKeyCode = Word;
  CGLPBufferObj = Pointer;
  PCGLPBufferObj = Pointer;
  CGLContextEnable = UInt32;
  CGLContextObj = Pointer;
  PCGLContextObj = Pointer;
  CGLContextParameter = UInt32;
  CGLError = UInt32;
  CGLGlobalOption = UInt32;
  CGLineCap = UInt32;
  CGLineJoin = UInt32;
  CGLPixelFormatAttribute = UInt32;
  PCGLPixelFormatAttribute = ^CGLPixelFormatAttribute;
  CGLPixelFormatObj = Pointer;
  PCGLPixelFormatObj = Pointer;
  CGLayerRef = Pointer;
  CGLRendererInfoObj = Pointer;
  PCGLRendererInfoObj = Pointer;
  CGLRendererProperty = UInt32;
  CGLShareGroupObj = Pointer;
  CGMouseButton = UInt32;
  CGMutablePathRef = Pointer;
  CGOpenGLDisplayMask = UInt32;
  CGPaletteBlendFraction = Single;
  CGPathDrawingMode = UInt32;
  CGPathElementType = UInt32;
  CGPathRef = Pointer;
  CGPatternRef = Pointer;
  CGPatternTiling = UInt32;
  CGPDFArrayRef = Pointer;
  PCGPDFArrayRef = ^CGPDFArrayRef;
  CGPDFBoolean = Byte;
  PCGPDFBoolean = ^CGPDFBoolean;
  CGPDFBox = UInt32;
  CGPDFContentStreamRef = Pointer;
  CGPDFDataFormat = UInt32;
  PCGPDFDataFormat = ^CGPDFDataFormat;
  CGPDFDictionaryRef = Pointer;
  PCGPDFDictionaryRef = ^CGPDFDictionaryRef;
  CGPDFDocumentRef = Pointer;
  CGPDFInteger = LongInt;
  PCGPDFInteger = ^CGPDFInteger;
  CGPDFObjectRef = Pointer;
  PCGPDFObjectRef = ^CGPDFObjectRef;
  CGPDFObjectType = UInt32;
  CGPDFOperatorTableRef = Pointer;
  CGPDFPageRef = Pointer;
  CGPDFReal = CGFloat;
  PCGPDFReal = ^CGPDFReal;
  CGPDFScannerRef = Pointer;
  CGPDFStreamRef = Pointer;
  PCGPDFStreamRef = ^CGPDFStreamRef;
  CGPDFStringRef = Pointer;
  PCGPDFStringRef = ^CGPDFStringRef;
  CGPSConverterRef = Pointer;
  CGRectCount = UInt32;
  CGRectEdge = UInt32;
  CGRefreshRate = Double;
  CGScreenUpdateOperation = UInt32;
  PCGScreenUpdateOperation = ^CGScreenUpdateOperation;
  CGScrollEventUnit = UInt32;
  CGShadingRef = Pointer;
  CGTextDrawingMode = UInt32;
  CGTextEncoding = UInt32;
  CGWheelCount = UInt32;
  CGWindowID = UInt32;
  CGWindowImageOption = UInt32;
  CGWindowLevel = Integer;
  CGWindowLevelKey = Integer;
  CGWindowListOption = UInt32;
  CIFormat = Integer;
  CMAttachmentBearerRef = CFTypeRef;
  CMAttachmentMode = UInt32;
  PCMAttachmentMode = ^CMAttachmentMode;
  CMAudioFormatDescriptionMask = UInt32;
  PCMAudioFormatDescriptionMask = ^CMAudioFormatDescriptionMask;
  CMBlockBufferFlags = UInt32;
  CMBlockBufferRef = IntPtr;
  PCMBlockBufferRef = ^CMBlockBufferRef;
  CMBufferRef = CFTypeRef;
  CMBufferQueueRef = IntPtr;
  PCMBufferQueueRef = ^CMBufferQueueRef;
  CMBufferQueueTriggerCondition = Integer;
  CMBufferQueueTriggerToken = IntPtr;
  PCMBufferQueueTriggerToken = ^CMBufferQueueTriggerToken;
  CMFormatDescriptionRef = IntPtr;
  PCMFormatDescriptionRef = ^CMFormatDescriptionRef;
  CMAudioFormatDescriptionRef = CMFormatDescriptionRef;
  PCMAudioFormatDescriptionRef = ^CMAudioFormatDescriptionRef;
  CMItemCount = LongInt;
  PCMItemCount = ^CMItemCount;
  CMItemIndex = LongInt;
  CMMediaType = FourCharCode;
  CMMetadataFormatDescriptionRef = CMFormatDescriptionRef;
  PCMMetadataFormatDescriptionRef = ^CMMetadataFormatDescriptionRef;
  CMMetadataFormatType = FourCharCode;
  CMMuxedFormatDescriptionRef = CMFormatDescriptionRef;
  PCMMuxedFormatDescriptionRef = ^CMMuxedFormatDescriptionRef;
  CMMuxedStreamType = FourCharCode;
  CMPersistentTrackID = LongInt;
  CMSampleBufferRef = Pointer;
  PCMSampleBufferRef = ^CMSampleBufferRef;
  CMSimpleQueueRef = IntPtr;
  PCMSimpleQueueRef = ^CMSimpleQueueRef;
  CMTextDisplayFlags = UInt32;
  PCMTextDisplayFlags = ^CMTextDisplayFlags;
  CMTextJustificationValue = Shortint;
  PCMTextJustificationValue = ^CMTextJustificationValue;
  CMTimeCodeFormatDescriptionRef = CMFormatDescriptionRef;
  PCMTimeCodeFormatDescriptionRef = ^CMTimeCodeFormatDescriptionRef;
  CMTimeCodeFormatType = FourCharCode;
  CMTimeRoundingMethod = UInt32;
  CMVideoCodecType = FourCharCode;
  CMVideoFormatDescriptionRef = CMFormatDescriptionRef;
  PCMVideoFormatDescriptionRef = ^CMVideoFormatDescriptionRef;
  CMTimeEpoch = Int64;
  CMTimeFlags = UInt32;
  CMTimeScale = Integer;
  CMTimeValue = Int64;
  CTCharacterCollection = Word;
  CTFontCollectionRef = Pointer;
  CTFontDescriptorRef = Pointer;
  PCTFontDescriptorRef = ^CTFontDescriptorRef;
  CTFontManagerAutoActivationSetting = UInt32;
  CTFontManagerScope = UInt32;
  CTFontOptions = CFOptionFlags;
  CTFontOrientation = UInt32;
  CTFontRef = Pointer;
  CTFontSymbolicTraits = UInt32;
  CTFontTableOptions = UInt32;
  CTFontTableTag = UInt32;
  CTFontUIFontType = Integer;
  CTFrameRef = Pointer;
  CTFramesetterRef = Pointer;
  CTGlyphInfoRef = Pointer;
  CTLineRef = Pointer;
  CTLineTruncationType = UInt32;
  CTParagraphStyleRef = Pointer;
  CTParagraphStyleSpecifier = UInt32;
  CTRunRef = Pointer;
  CTRunStatus = UInt32;
  CTTextAlignment = Byte;
  CTTextTabRef = Pointer;
  CTTypesetterRef = Pointer;
  CVAttachmentMode = UInt32;
  PCVAttachmentMode = ^CVAttachmentMode;
  CVBufferRef = IntPtr;
  CVDisplayLinkRef = IntPtr;
  PCVDisplayLinkRef = ^CVDisplayLinkRef;
  CVImageBufferRef = IntPtr;
  CVOpenGLBufferPoolRef = IntPtr;
  PCVOpenGLBufferPoolRef = ^CVOpenGLBufferPoolRef;
  CVOpenGLBufferRef = CVImageBufferRef;
  PCVOpenGLBufferRef = ^CVOpenGLBufferRef;
  CVOpenGLTextureCacheRef = IntPtr;
  PCVOpenGLTextureCacheRef = ^CVOpenGLTextureCacheRef;
  CVOpenGLTextureRef = CVImageBufferRef;
  PCVOpenGLTextureRef = ^CVOpenGLTextureRef;
  CVOptionFlags = UInt64;
  PCVOptionFlags = ^CVOptionFlags;
  CVPixelBufferPoolRef = IntPtr;
  PCVPixelBufferPoolRef = ^CVPixelBufferPoolRef;
  CVPixelBufferRef = CVImageBufferRef;
  PCVPixelBufferRef = ^CVPixelBufferRef;
  CVReturn = Integer;
  GLbitfield = UInt32;
  GLboolean = Byte;
  PGLboolean = ^GLboolean;
  GLbyte = Shortint;
  PGLbyte = ^GLbyte;
  GLcampd = Double;
  GLchar = Byte;
  PGLchar = MarshaledAString;
  PGLcharARB = MarshaledAString;
  GLclampd = Double;
  GLclampf = Single;
  PGLclampf = ^GLclampf;
  GLdouble = Double;
  PGLdouble = ^GLdouble;
  GLenum = UInt32;
  PGLenum = ^GLenum;
  GLfloat = Single;
  PGLfloat = ^GLfloat;
  GLhandleARB = UInt32;
  PGLhandleARB = ^GLhandleARB;
  GLint = Integer;
  GLintptr = IntPtr;
  GLintptrARB = IntPtr;
  PGLint = ^GLint;
  GLshort = Smallint;
  PGLshort = ^GLshort;
  GLsizei = Integer;
  GLsizeiptr = IntPtr;
  GLsizeiptrARB = IntPtr;
  PGLsizei = ^GLsizei;
  GLubyte = Byte;
  PGLubyte = ^GLubyte;
  GLuint = UInt32;
  PGLuint = ^GLuint;
  GLushort = Word;
  PGLushort = ^GLushort;
  GLvoid = Pointer;
  PGLvoid = Pointer;
  IOSurfaceRef = Pointer;
  IconRef = Pointer;
  NSAlertStyle = NSUInteger;
  NSAnimationBlockingMode = NSUInteger;
  NSAnimationCurve = NSUInteger;
  NSAnimationProgress = Single;
  NSAppleEventManagerSuspensionID = NSInteger;
  NSApplicationActivationOptions = NSUInteger;
  NSApplicationActivationPolicy = NSInteger;
  NSApplicationDelegateReply = NSUInteger;
  NSApplicationPresentationOptions = NSUInteger;
  NSAttributeType = NSUInteger;
  NSBackgroundStyle = NSUInteger;
  NSBackingStoreType = NSUInteger;
  NSBezelStyle = NSUInteger;
  NSBezierPathElement = NSUInteger;
  NSBinarySearchingOptions = NSUInteger;
  NSBitmapFormat = NSUInteger;
  NSBitmapImageFileType = NSUInteger;
  NSBorderType = NSUInteger;
  NSBoxType = NSUInteger;
  NSBrowserColumnResizingType = NSUInteger;
  NSButtonType = NSUInteger;
  NSCalendarUnit = NSUInteger;
  NSCellAttribute = NSUInteger;
  NSCellImagePosition = NSUInteger;
  NSCellType = NSUInteger;
  NSCharacterCollection = NSUInteger;
  NSColorPanelMode = NSInteger;
  NSColorRenderingIntent = NSInteger;
  NSColorSpaceModel = NSInteger;
  NSComparator = Pointer;
  NSComparisonPredicateModifier = NSUInteger;
  NSComparisonResult = NSInteger;
  NSCompositingOperation = NSUInteger;
  NSCompoundPredicateType = NSUInteger;
  NSControlSize = NSUInteger;
  NSControlTint = NSUInteger;
  NSDataReadingOptions = NSUInteger;
  NSDataSearchOptions = NSUInteger;
  NSDataWritingOptions = NSUInteger;
  NSDateFormatterBehavior = NSUInteger;
  NSDateFormatterStyle = NSUInteger;
  NSDatePickerElementFlags = NSUInteger;
  NSDatePickerMode = NSUInteger;
  NSDatePickerStyle = NSUInteger;
  NSDirectoryEnumerationOptions = NSUInteger;
  NSDocumentChangeType = NSUInteger;
  NSDragOperation = NSInteger;
  NSEventType = NSUInteger;
  NSExpressionType = NSUInteger;
  NSFileManagerItemReplacementOptions = NSUInteger;
  NSFileWrapperReadingOptions = NSUInteger;
  NSFileWrapperWritingOptions = NSUInteger;
  NSFocusRingType = NSUInteger;
  NSFontAction = NSUInteger;
  NSFontRenderingMode = NSUInteger;
  NSFontSymbolicTraits = NSUInteger;
  NSFontTraitMask = NSUInteger;
  NSGlyph = NSUInteger;
  PNSGlyph = ^NSGlyph;
  NSGlyphInscription = NSUInteger;
  PNSGlyphInscription = ^NSGlyphInscription;
  NSGradientDrawingOptions = NSUInteger;
  NSGradientType = NSUInteger;
  NSHTTPCookieAcceptPolicy = NSUInteger;
  NSImageAlignment = NSUInteger;
  NSImageCacheMode = NSUInteger;
  NSImageFrameStyle = NSUInteger;
  NSImageInterpolation = NSUInteger;
  NSImageScaling = NSUInteger;
  NSInsertionPosition = NSUInteger;
  NSInterfaceStyle = NSUInteger;
  NSKeyValueObservingOptions = NSUInteger;
  NSLevelIndicatorStyle = NSUInteger;
  NSLineBreakMode = NSUInteger;
  NSLineCapStyle = NSUInteger;
  NSLineJoinStyle = NSUInteger;
  NSLineMovementDirection = NSUInteger;
  NSLineSweepDirection = NSUInteger;
  NSLocaleLanguageDirection = NSUInteger;
  NSMatrixMode = NSUInteger;
  NSMenuProperties = NSUInteger;
  NSModalSession = Pointer;
  NSNetServiceOptions = NSUInteger;
  NSNumberFormatterBehavior = NSUInteger;
  NSNumberFormatterPadPosition = NSUInteger;
  NSNumberFormatterRoundingMode = NSUInteger;
  NSNumberFormatterStyle = NSUInteger;
  NSOpenGLContextParameter = NSUInteger;
  NSOpenGLPixelFormatAttribute = UInt32;
  PNSOpenGLPixelFormatAttribute = ^NSOpenGLPixelFormatAttribute;
  NSOperationQueuePriority = NSInteger;
  NSPathStyle = NSInteger;
  NSPointArray = PNSPoint;
  NSPointPointer = PNSPoint;
  NSPointerFunctionsOptions = NSUInteger;
  NSPointingDeviceType = NSInteger;
  NSPopUpArrowPosition = NSUInteger;
  NSPostingStyle = NSUInteger;
  NSPredicateOperatorType = NSUInteger;
  NSPrintPanelOptions = NSInteger;
  NSPrinterTableStatus = NSUInteger;
  NSPrintingOrientation = NSUInteger;
  NSPrintingPageOrder = NSInteger;
  NSPrintingPaginationMode = NSUInteger;
  NSProgressIndicatorStyle = NSUInteger;
  NSProgressIndicatorThickness = NSUInteger;
  NSPropertyListFormat = NSUInteger;
  PNSPropertyListFormat = ^NSPropertyListFormat;
  NSPropertyListMutabilityOptions = NSUInteger;
  NSPropertyListReadOptions = NSUInteger;
  NSPropertyListWriteOptions = NSUInteger;
  NSRectArray = PNSRect;
  NSRectEdge = NSUInteger;
  NSRectPointer = PNSRect;
  NSRelativePosition = NSUInteger;
  NSRequestUserAttentionType = NSUInteger;
  NSRoundingMode = NSUInteger;
  NSRuleEditorNestingMode = NSUInteger;
  NSRuleEditorRowType = NSUInteger;
  NSRulerOrientation = NSUInteger;
  NSSaveOperationType = NSUInteger;
  NSSaveOptions = NSUInteger;
  NSScrollArrowPosition = NSUInteger;
  NSScrollerArrow = NSUInteger;
  NSScrollerPart = NSUInteger;
  NSSearchPathDirectory = NSUInteger;
  NSSearchPathDomainMask = NSUInteger;
  NSSegmentStyle = NSInteger;
  NSSegmentSwitchTracking = NSUInteger;
  NSSelectionAffinity = NSUInteger;
  NSSelectionDirection = NSUInteger;
  NSSelectionGranularity = NSUInteger;
  NSSizeArray = PNSSize;
  NSSliderType = NSUInteger;
  NSSocketNativeHandle = Integer;
  NSSortOptions = NSUInteger;
  NSSpeechBoundary = NSUInteger;
  NSSplitViewDividerStyle = NSInteger;
  NSStreamStatus = NSUInteger;
  NSStringCompareOptions = NSUInteger;
  NSStringDrawingOptions = NSInteger;
  NSStringEncoding = NSUInteger;
  PNSStringEncoding = ^NSStringEncoding;
  NSStringEncodingConversionOptions = NSUInteger;
  NSTIFFCompression = NSUInteger;
  PNSTIFFCompression = ^NSTIFFCompression;
  NSTabViewType = NSUInteger;
  NSTableViewColumnAutoresizingStyle = NSUInteger;
  NSTableViewDraggingDestinationFeedbackStyle = NSInteger;
  NSTableViewDropOperation = NSUInteger;
  NSTableViewSelectionHighlightStyle = NSInteger;
  NSTabState = NSUInteger;
  NSTaskTerminationReason = NSInteger;
  NSTestComparisonOperation = NSUInteger;
  NSTextAlignment = NSUInteger;
  NSTextBlockDimension = NSUInteger;
  NSTextBlockLayer = NSInteger;
  NSTextBlockValueType = NSUInteger;
  NSTextBlockVerticalAlignment = NSUInteger;
  NSTextCheckingType = UInt64;
  NSTextCheckingTypes = UInt64;
  NSTextFieldBezelStyle = NSUInteger;
  NSTextTabType = NSUInteger;
  NSTextTableLayoutAlgorithm = NSUInteger;
  NSTickMarkPosition = NSUInteger;
  NSTimeZoneNameStyle = NSInteger;
  NSTitlePosition = NSUInteger;
  NSTokenStyle = NSUInteger;
  NSToolTipTag = NSUInteger;
  NSToolbarDisplayMode = NSUInteger;
  NSToolbarSizeMode = NSUInteger;
  NSTouchPhase = NSUInteger;
  NSTrackingAreaOptions = NSUInteger;
  NSTrackingRectTag = NSInteger;
  NSTypesetterBehavior = NSInteger;
  NSTypesetterControlCharacterAction = NSUInteger;
  NSURLBookmarkCreationOptions = NSUInteger;
  NSURLBookmarkFileCreationOptions = NSUInteger;
  NSURLBookmarkResolutionOptions = NSUInteger;
  NSURLCacheStoragePolicy = Integer;
  NSURLCredentialPersistence = NSUInteger;
  NSURLRequestCachePolicy = NSUInteger;
  NSUsableScrollerParts = NSUInteger;
  NSUserInterfaceLayoutDirection = NSInteger;
  NSViewLayerContentsPlacement = NSInteger;
  NSViewLayerContentsRedrawPolicy = NSInteger;
  NSVolumeEnumerationOptions = NSUInteger;
  NSWhoseSubelementIdentifier = NSUInteger;
  NSWindingRule = NSUInteger;
  NSWindowBackingLocation = NSUInteger;
  NSWindowButton = NSUInteger;
  NSWindowCollectionBehavior = NSUInteger;
  NSWindowDepth = NSUInteger;
  NSWindowNumberListOptions = NSUInteger;
  NSWindowOrderingMode = NSInteger;
  NSWindowSharingType = NSUInteger;
  NSWorkspaceIconCreationOptions = NSUInteger;
  NSWorkspaceLaunchOptions = NSUInteger;
  NSWritingDirection = NSInteger;
  NSXMLDTDNodeKind = NSUInteger;
  NSXMLDocumentContentKind = NSUInteger;
  NSXMLNodeKind = NSUInteger;
  NSZone = Pointer;
  PMDataFormat = NSUInteger;
  PMDestinationType = Word;
  PPMDestinationType = ^PMDestinationType;
  PMDuplexMode = NSUInteger;
  PPMDuplexMode = ^PMDuplexMode;
  PMObject = Pointer;
  PMOrientation = Word;
  PPMOrientation = ^PMOrientation;
  PMPageFormat = Pointer;
  PPMPageFormat = ^PMPageFormat;
  PMPaper = Pointer;
  PPMPaper = ^PMPaper;
  PMPaperMargins = PMRect;
  PPMPaperMargins = ^PMPaperMargins;
  PMPPDDomain = Word;
  PMPreset = Pointer; 
  PMPrinter = Pointer;
  PPMPrinter = ^PMPrinter;
  PMPrintSession = Pointer;
  PPMPrintSession = ^PMPrintSession;
  PMPrintSettings = Pointer;
  PPMPrintSettings = ^PMPrintSettings;
  PMPrinterState = Word;
  PPMPrinterState = ^PMPrinterState;
  PMServer = Pointer;
  SecIdentityRef = Pointer;
  SecTrustRef = Pointer;
  uuid_t = PByte;


  AudioBuffer = record
    mNumberChannels: UInt32;
    mDataByteSize: UInt32;
    mData: Pointer;
  end;
  PAudioBuffer = &AudioBuffer;

  AudioBufferList = record
    mNumberBuffers: UInt32;
    mBuffers: array[0..0] of AudioBuffer;
  end;
  PAudioBufferList = ^AudioBufferList;

  CGBitmapContextReleaseDataCallback = procedure(releaseInfo: Pointer; data: Pointer); cdecl;
  CGEventTapCallBack = procedure(proxy: CGEventTapProxy; type_: CGEventType; event: CGEventRef; refcon: Pointer); cdecl;

  CGFunctionEvaluateCallback = procedure(info: Pointer; inData: PCGFloat; outData: PCGFloat); cdecl;
  CGFunctionReleaseInfoCallback = procedure(info: Pointer); cdecl;

  CGFunctionCallbacks = record
    version: Cardinal;
    evaluate: CGFunctionEvaluateCallback;
    releaseInfo: CGFunctionReleaseInfoCallback;
  end;
  PCGFunctionCallbacks = ^CGFunctionCallbacks;

  CGEventTapInformation = record
    eventTapID: UInt32;
    tapPoint: CGEventTapLocation;
    options: CGEventTapOptions;
    eventsOfInterest: CGEventMask;
    tappingProcess: pid_t;
    processBeingTapped: pid_t;
    enabled: Boolean;
    minUsecLatency: Single;
    avgUsecLatency: Single;
    maxUsecLatency: Single;
  end;
  PCGEventTapInformation = ^CGEventTapInformation;

  CGPDFDictionaryApplierFunction = procedure(key: MarshaledAString; value: CGPDFObjectRef; info: Pointer); cdecl;
  CGPDFOperatorCallback = procedure(scanner: CGPDFScannerRef; info: Pointer); cdecl;

  CGPathElement = record
    type_: CGPathElementType;
    points: PCGPoint;
  end;
  PCGPathElement = ^CGPathElement;

  CGPathApplierFunction = procedure(info: Pointer; const element: PCGPathElement); cdecl;

  CGPatternDrawPatternCallback = procedure(info: Pointer; context: CGContextRef); cdecl;
  CGPatternReleaseInfoCallback = procedure(info: Pointer); cdecl;
  CGPatternCallbacks = record
    version: Cardinal;
    drawPattern: CGPatternDrawPatternCallback;
    releaseInfo: CGPatternReleaseInfoCallback;
  end;
  PCGPatternCallbacks = ^CGPatternCallbacks;

  CGScreenUpdateMoveDelta = record
    dx: Integer;
    dy: Integer;
  end;
  PCGScreenUpdateMoveDelta = ^CGScreenUpdateMoveDelta;
  CGDisplayReconfigurationCallBack = procedure(display: CGDirectDisplayID; flags: CGDisplayChangeSummaryFlags; userInfo: Pointer); cdecl;
  CGScreenRefreshCallback = procedure(count: CGRectCount; rectArray: PCGRect; userParameter: Pointer); cdecl;
  CGScreenUpdateMoveCallback = procedure(delta: CGScreenUpdateMoveDelta; count: CGRectCount; rectArray: PCGRect; userParameter: Pointer); cdecl;

  CTFontCollectionSortDescriptorsCallback = function(first, second: CTFontDescriptorRef; refCon: Pointer): CFComparisonResult; cdecl;

  CTParagraphStyleSetting = record
    spec: CTParagraphStyleSpecifier;
    valueSize: size_t;
    value: Pointer;
  end;
  PCTParagraphStyleSetting = ^CTParagraphStyleSetting;

  // CoreVideo data callbacks
  CVDisplayLinkOutputCallback = function(displayLink: CVDisplayLinkRef; const inNow: PCVTimeStamp;
    const inOutputTime: PCVTimestamp; flagsIn: CVOptionFlags; flagsOut: PCVOptionFlags;
    displayLinkContext: Pointer): CVReturn; cdecl;
  CVPixelBufferReleaseBytesCallback = procedure(releaseRefCon: Pointer; baseAddress: Pointer); cdecl;
  CVPixelBufferReleasePlanarBytesCallback = procedure(releaseRefCon: Pointer; dataPtr: Pointer;
    dataSize: size_t; numberOfPlanes: size_t; planeAddresses: PPointer); cdecl;

  AudioStreamBasicDescription = record
    mSampleRate: Double;
    mFormatID: UInt32;
    mFormatFlags: UInt32;
    mBytesPerPacket: UInt32;
    mFramesPerPacket: UInt32;
    mBytesPerFrame: UInt32;
    mChannelsPerFrame: UInt32;
    mBitsPerChannel: UInt32;
    mReserved: UInt32;
  end;
  PAudioStreamBasicDescription = ^AudioStreamBasicDescription;

  TAudioChannelCoordinatesArray = array[0..2] of Single;
  AudioChannelDescription = record
    mChannelLabel: AudioChannelLabel;
    mChannelFlags: Single;
    mCoordinates: TAudioChannelCoordinatesArray;
  end;
  PAudioChannelDescription = ^AudioChannelDescription;

  AudioChannelLayout = record
    mChannelLayoutTag: AudioChannelLayoutTag;
    mChannelBitmap: UInt32;
    mNumberChannelDescriptions: UInt32;
    mChannelDescriptions: AudioChannelDescription;
  end;
  PAudioChannelLayout = ^AudioChannelLayout;

  AudioStreamPacketDescription = record
    mStartOffset: Int64;
    mVariableFramesInPacket: UInt32;
    mDataByteSize: UInt32;
  end;
  PAudioStreamPacketDescription = ^AudioStreamPacketDescription;

  AudioFormatListItem = record
    mASBD: AudioStreamBasicDescription;
    mChannelLayoutTag: AudioChannelLayoutTag;
  end;
  PAudioFormatListItem = ^AudioFormatListItem;

  CMTime = record
    value: CMTimeValue;
    timescale: CMTimeScale;
    flags: CMTimeFlags;
    epoch: CMTimeEpoch
  end;
  PCMTime = ^CMTime;

  CMTimeRange = record
    start: CMTime;
    duration: CMTime;
  end;
  PCMTImeRange = ^CMTimeRange;

  CMTimeMapping = record
    source: CMTimeRange;
    target: CMTimeRange;
  end;
  PCMTimeMapping = ^CMTimeMapping;

  TCMBlockBufferAllocator = function(refCon: Pointer; sizeInBytes: Integer): Pointer;
  TCMBlockBufferDeallocator = procedure(refCon: Pointer; doomedMemoryBlock: Pointer; sizeInBytes: Integer);

  CMBlockBufferCustomBlockSource = record
    version: Cardinal;
    AllocateBlock: TCMBlockBufferAllocator;
    FreeBlock: TCMBlockBufferDeallocator;
    refCon: Pointer;
  end;
  PCMBlockBufferCustomBlockSource = ^CMBlockBufferCustomBlockSource;

  CMSampleTimingInfo = record
    duration: CMTime;
    presentationTimeStamp: CMTime;
    decodeTimeStamp: CMTime;
  end;
  PCMSampleTimingInfo = ^CMSampleTimingInfo;

  CMVideoDimensions = record
    width: Integer;
    height: Integer;
  end;

  // CoreMedia data callbacks
  CMSampleBufferMakeDataReadyCallback = function(sbuf: CMSampleBufferRef;
    makeDataReadyRefCon: Pointer): OSStatus; cdecl;
  CMBufferGetTimeCallback = function(buf: CMBufferRef; refcon: Pointer): CMTime; cdecl;
  CMBufferGetBooleanCallback = function(buf: CMBufferRef; refcon: Pointer): Boolean; cdecl;
  CMBufferCompareCallback = function(buf1: CMBufferRef; buf2: CMBufferRef; refcon: Pointer): CFComparisonResult; cdecl;
  CMBufferQueueTriggerCallback = procedure(triggerRefcon: Pointer; triggerToken: CMBufferQueueTriggerToken); cdecl;
  TCMBufferQueueResetCallback = procedure(buffer: CMBufferRef; refcon: Pointer); cdecl;
  TCMBufferQueueCallback = function(buffer: CMBufferRef; refcon: Pointer): OSStatus; cdecl;
  CMBufferValidationCallback = function(queue: CMBufferQueueRef; buf: CMBufferRef;
    validationRefCon: Pointer): OSStatus; cdecl;
  TCMSampleBufferCallback = function(sampleBuffer: CMSampleBufferRef; index: CMItemCount;
    refcon: Pointer): OSStatus; cdecl;
  CMSampleBufferInvalidateCallback = procedure(sbuf: CMSampleBufferRef; invalidateRefCon: UInt64); cdecl;

  CMBufferCallbacks = record
    version: Cardinal;
    refcon: Pointer;
    getDecodeTimeStamp: CMBufferGetTimeCallback;
    getPresentationTimeStamp: CMBufferGetTimeCallback;
    getDuration: CMBufferGetTimeCallback;
    isDataReady: CMBufferGetBooleanCallback;
    compare: CMBufferCompareCallback;
    dataBecameReadyNotification: CFStringRef;
  end;
  PCMBufferCallbacks = ^CMBufferCallbacks;

  // CoreLocation simple data types
  CLLocationAccuracy = Double;
  CLLocationDegrees = Double;
  CLLocationDirection = Double;
  CLLocationDistance = Double;
  CLLocationSpeed = Double;
  CLHeadingComponentValue = Double;

  CLLocationCoordinate2D = record
    latitude: CLLocationDegrees;
    longitude: CLLocationDegrees;
  end;

  CLAuthorizationStatus = NSInteger;
  CLDeviceOrientation = NSInteger;
  CLError = NSInteger;

const
  CGAffineTransformIdentity: CGAffineTransform = (
    a: 1;
    b: 0;
    c: 0;
    d: 1;
    tx: 0;
    ty: 0;
  );

// Convenience methods for making structured types

function MakeNSRect(ox, oy, sx, sy: Single): NSRect;

implementation

function MakeNSRect(ox, oy, sx, sy: Single): NSRect;
begin
  Result.origin.x := ox;
  Result.origin.y := oy;
  Result.size.width := sx;
  Result.size.height := sy;
end;

{ NSPoint }

constructor NSPoint.Create(const Origin: TPointF);
begin
  Self.x := Origin.X;
  Self.y := Origin.Y;
end;

function NSPoint.ToPointF: TPointF;
begin
  Result := TPointF.Create(Self.x, Self.y);
end;

{ NSRect }

constructor NSRect.Create(const Origin: TRectF);
begin
  Self.origin.x := Origin.Left;
  Self.origin.Y := Origin.Top;
  Self.size.Width := Origin.Width;
  Self.size.Height := Origin.Height;
end;

function NSRect.ToRectF: TRectF;
begin
  Result := TRectF.Create(Self.origin.ToPointF, Self.size.width, Self.size.height);
end;

function NSRect.ToSizeF: TSizeF;
begin
  Result.Width := size.width;
  Result.Height := size.height;
end;

{ NSSize }

constructor NSSize.Create(const Origin: TSizeF);
begin
  width := Origin.Width;
  height := Origin.Height;
end;

function NSSize.ToPointF: TPointF;
begin
  Result.X := width;
  Result.Y := height;
end;

function NSSize.ToSizeF: TSizeF;
begin
  Result := TSizeF.Create(width, height);
end;

end.
