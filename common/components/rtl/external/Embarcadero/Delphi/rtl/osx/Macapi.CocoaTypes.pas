{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Macapi.CocoaTypes;

interface

uses Macapi.ObjectiveC, Macapi.CoreFoundation, Macapi.CoreServices;


type
{$M+}
  NSUInteger = Longword;
  PNSUInteger = ^NSUInteger;
  NSInteger = Integer;
  PNSInteger = ^NSInteger;
  NSTimeInterval = Double;
  PNSTimeInterval = ^NSTimeInterval;
  CGFloat = Single;

  NSRange = record
    location: NSUInteger;
    length: NSUInteger;
  end;
  PNSRange = ^NSRange;

  NSDecimal = record
    _exponent: Integer;
    _length: Longword;
    _isNegative: Longword;
    _isCompact: Longword;
    _mantissa: Word;
  end;
  PNSDecimal = ^NSDecimal;

  NSPoint = record
    x: Single;
    y: Single;
  end;
  PNSPoint = ^NSPoint;
  CGPoint = NSPoint;
  PCGPoint = ^CGPoint;

  NSSize = record
    width: Single;
    height: Single;
  end;
  PNSSize = ^NSSize;
  CGSize = NSSize;
  PCGSize = ^CGSize;

  NSRect = record
    origin: NSPoint;
    size: NSSize;
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
    m11: Single;
    m12: Single;
    m21: Single;
    m22: Single;
    tX: Single;
    tY: Single;
  end;
  PNSAffineTransformStruct = ^NSAffineTransformStruct;

  CGAffineTransform = record
    a: Single;
    b: Single;
    c: Single;
    d: Single;
    tx: Single;
    ty: Single;
  end;
  PCGAffineTransform = ^CGAffineTransform;

  CVSMPTETime = record
    subframes: Smallint;
    subframeDivisor: Smallint;
    counter: Longword;
    type_: Longword;
    flags: Longword;
    hours: Smallint;
    minutes: Smallint;
    seconds: Smallint;
    frames: Smallint;
  end;
  SMPTETime = CVSMPTETime;

  CVTime = record
    timeValue: Int64;
    timeScale: Int64;
    flags: Integer;
  end;

  CVTimeStamp = record
    version: Longword;
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

  FourCharCode = array[0..3] of Byte;
  {$EXTERNALSYM FourCharCode}
  ResType = FourCharCode;
  DescType = ResType;
  AEDataStorage = Pointer;
  AEEventClass = FourCharCode;
  AEKeyword = FourCharCode;
  AEEventID = FourCharCode;
  AEReturnID = Integer;
  AETransactionID = Integer;
  AEDesc = record
    descriptorType: DescType;
    dataHandle: AEDataStorage;
  end;
  PAEDesc = ^AEDesc;

  // CoreGraphics data callbacks
  CGDataConsumerPutBytesCallback = function(info: Pointer; buffer: Pointer; count: Longword): Longword; cdecl;
  CGDataConsumerReleaseInfoCallback = procedure(info: Pointer); cdecl;

  CGDataConsumerCallbacks = record
    putBytes: CGDataConsumerPutBytesCallback;
    releaseConsumer: CGDataConsumerReleaseInfoCallback;
  end;
  PCGDataConsumerCallbacks = ^CGDataConsumerCallbacks;

  CGDataProviderGetBytesCallback = function(info: Pointer; buffer: Pointer; count: Longword): Longword; cdecl;
  CGDataProviderSkipBytesCallback = procedure(info: Pointer; count: Longword); cdecl;
  CGDataProviderRewindCallback = procedure(info: Pointer); cdecl;
  CGDataProviderReleaseInfoCallback = procedure(info: Pointer); cdecl;
  CGDataProviderGetBytePointerCallback  = function(info: Pointer): Pointer; cdecl;
  CGDataProviderReleaseBytePointerCallback = procedure(info: Pointer; ptr: Pointer); cdecl;
  CGDataProviderGetBytesAtPositionCallback = function(info: Pointer; buffer: Pointer; position: Integer; count: Longword): LongWord; cdecl;
  CGDataProviderGetBytesAtOffsetCallback = function(info: Pointer; buffer: Pointer; offset: Integer; count: Longword): LongWord; cdecl;
  CGDataProviderSkipForwardCallback = function(info: Pointer; count: Longword): Longword; cdecl;
  CGDataProviderReleaseDataCallback = procedure(info: Pointer; data: Pointer; size: Longword); cdecl;

  CGDataProviderCallbacks = record
    getBytes: CGDataProviderGetBytesCallback;
    skipBytes: CGDataProviderSkipBytesCallback;
    rewind: CGDataProviderRewindCallback;
    releaseProvider: CGDataProviderReleaseInfoCallback;
  end;
  PCGDataProviderCallbacks = ^CGDataProviderCallbacks;

  CGDataProviderDirectCallbacks = record
    version: Longword;
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
    version: Longword;
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
  ATSFontRef = Longword;
  AudioChannelLabel = Longword;
  AudioChannelLayoutTag = Longword;
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
  CGBitmapInfo = Longword;
  CGBlendMode = Longword;
  CGButtonCount = Longword;
  CGCaptureOptions = Longword;
  CGCharCode = Word;
  CGColorRef = Pointer;
  CGColorRenderingIntent = Longword;
  CGColorSpaceModel = Integer;
  CGColorSpaceRef = Pointer;
  CGConfigureOption = Longword;
  CGContextRef = Pointer;
  PCGContextRef = ^CGContextRef;
  CGDataConsumerRef = Pointer;
  CGDataProviderRef = Pointer;
  CGDirectDisplayID = Longword;
  PCGDirectDisplayID = ^CGDirectDisplayID;
  CGDirectPaletteRef = Pointer;
  CGDisplayBlendFraction = Single;
  CGDisplayChangeSummaryFlags = Longword;
  CGDisplayConfigRef = Pointer;
  CGDisplayFadeInterval = Single;
  CGDisplayFadeReservationToken = Longword;
  PCGDisplayFadeReservationToken = ^CGDisplayFadeReservationToken;
  CGDisplayModeRef = Pointer;
  CGDisplayReservationInterval = Single;
  CGError = Integer;
  CGEventField = Longword;
  CGEventFilterMask = Longword;
  CGEventFlags = UInt64;
  CGEventMask = UInt64;
  CGEventRef = Pointer;
  CGEventSourceKeyboardType = Longword;
  CGEventSourceRef = Pointer;
  CGEventSourceStateID = Integer;
  CGEventSourceSuppressionState = Longword;
  CGEventSuppressionState = Longword;
  CGEventTapLocation = Longword;
  CGEventTapOptions = Longword;
  CGEventTapPlacement = Longword;
  CGEventTapProxy = Pointer;
  CGEventTimestamp = UInt64;
  CGEventType = Longword;
  CGFontIndex = Word;
  CGFontPostScriptFormat = Longword;
  CGFontRef = Pointer;
  CGFunctionRef = Pointer;
  CGGammaValue = Single;
  PCGGammaValue = ^CGGammaValue;
  CGGlyph = Word;
  PCGGlyph = ^CGGlyph;
  CGGradientDrawingOptions = Longword;
  CGGradientRef = Pointer;
  CGImageAlphaInfo = Longword;
  CGImageDestinationRef = Pointer;
  CGImageRef = Pointer;
  CGImageSourceRef = Pointer;
  CGImageSourceStatus = NSInteger;
  CGInterpolationQuality = Longword;
  CGKeyCode = Word;
  CGLPBufferObj = Pointer;
  PCGLPBufferObj = Pointer;
  CGLContextEnable = Longword;
  CGLContextObj = Pointer;
  PCGLContextObj = Pointer;
  CGLContextParameter = Longword;
  CGLError = Longword;
  CGLGlobalOption = Longword;
  CGLineCap = Longword;
  CGLineJoin = Longword;
  CGLPixelFormatAttribute = Longword;
  PCGLPixelFormatAttribute = ^CGLPixelFormatAttribute;
  CGLPixelFormatObj = Pointer;
  PCGLPixelFormatObj = Pointer;
  CGLayerRef = Pointer;
  CGLRendererInfoObj = Pointer;
  PCGLRendererInfoObj = Pointer;
  CGLRendererProperty = Longword;
  CGLShareGroupObj = Pointer;
  CGMouseButton = Longword;
  CGMutablePathRef = Pointer;
  CGOpenGLDisplayMask = Longword;
  CGPaletteBlendFraction = Single;
  CGPathDrawingMode = Longword;
  CGPathElementType = Longword;
  CGPathRef = Pointer;
  CGPatternRef = Pointer;
  CGPatternTiling = Longword;
  CGPDFArrayRef = Pointer;
  PCGPDFArrayRef = ^CGPDFArrayRef;
  CGPDFBoolean = Byte;
  PCGPDFBoolean = ^CGPDFBoolean;
  CGPDFBox = Longword;
  CGPDFContentStreamRef = Pointer;
  CGPDFDataFormat = Longword;
  PCGPDFDataFormat = ^CGPDFDataFormat;
  CGPDFDictionaryRef = Pointer;
  PCGPDFDictionaryRef = ^CGPDFDictionaryRef;
  CGPDFDocumentRef = Pointer;
  CGPDFInteger = Longint;
  PCGPDFInteger = ^CGPDFInteger;
  CGPDFObjectRef = Pointer;
  PCGPDFObjectRef = ^CGPDFObjectRef;
  CGPDFObjectType = Longword;
  CGPDFOperatorTableRef = Pointer;
  CGPDFPageRef = Pointer;
  CGPDFReal = Single;
  PCGPDFReal = ^CGPDFReal;
  CGPDFScannerRef = Pointer;
  CGPDFStreamRef = Pointer;
  PCGPDFStreamRef = ^CGPDFStreamRef;
  CGPDFStringRef = Pointer;
  PCGPDFStringRef = ^CGPDFStringRef;
  CGPSConverterRef = Pointer;
  CGRectCount = Longword;
  CGRectEdge = Longword;
  CGRefreshRate = Double;
  CGScreenUpdateOperation = Longword;
  PCGScreenUpdateOperation = ^CGScreenUpdateOperation;
  CGScrollEventUnit = Longword;
  CGShadingRef = Pointer;
  CGTextDrawingMode = Longword;
  CGTextEncoding = Longword;
  CGWheelCount = Longword;
  CGWindowID = Longword;
  CGWindowImageOption = Longword;
  CGWindowLevel = Integer;
  CGWindowLevelKey = Integer;
  CGWindowListOption = Longword;
  CIFormat = Integer;
  CMAttachmentBearerRef = CFTypeRef;
  CMAttachmentMode = Longword;
  PCMAttachmentMode = ^CMAttachmentMode;
  CMAudioFormatDescriptionMask = Longword;
  PCMAudioFormatDescriptionMask = ^CMAudioFormatDescriptionMask;
  CMBlockBufferFlags = Longword;
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
  CMItemCount = Longint;
  PCMItemCount = ^CMItemCount;
  CMItemIndex = Longint;
  CMMediaType = FourCharCode;
  CMMetadataFormatDescriptionRef = CMFormatDescriptionRef;
  PCMMetadataFormatDescriptionRef = ^CMMetadataFormatDescriptionRef;
  CMMetadataFormatType = FourCharCode;
  CMMuxedFormatDescriptionRef = CMFormatDescriptionRef;
  PCMMuxedFormatDescriptionRef = ^CMMuxedFormatDescriptionRef;
  CMMuxedStreamType = FourCharCode;
  CMPersistentTrackID = Longint;
  CMSampleBufferRef = Pointer;
  PCMSampleBufferRef = ^CMSampleBufferRef;
  CMSimpleQueueRef = IntPtr;
  PCMSimpleQueueRef = ^CMSimpleQueueRef;
  CMTextDisplayFlags = Longword;
  PCMTextDisplayFlags = ^CMTextDisplayFlags;
  CMTextJustificationValue = Shortint;
  PCMTextJustificationValue = ^CMTextJustificationValue;
  CMTimeCodeFormatDescriptionRef = CMFormatDescriptionRef;
  PCMTimeCodeFormatDescriptionRef = ^CMTimeCodeFormatDescriptionRef;
  CMTimeCodeFormatType = FourCharCode;
  CMTimeRoundingMethod = Longword;
  CMVideoCodecType = FourCharCode;
  CMVideoFormatDescriptionRef = CMFormatDescriptionRef;
  PCMVideoFormatDescriptionRef = ^CMVideoFormatDescriptionRef;
  CMTimeEpoch = Int64;
  CMTimeFlags = Longword;
  CMTimeScale = Integer;
  CMTimeValue = Int64;
  CTCharacterCollection = Word;
  CTFontCollectionRef = Pointer;
  CTFontDescriptorRef = Pointer;
  PCTFontDescriptorRef = ^CTFontDescriptorRef;
  CTFontManagerAutoActivationSetting = Longword;
  CTFontManagerScope = Longword;
  CTFontOptions = CFOptionFlags;
  CTFontOrientation = Longword;
  CTFontRef = Pointer;
  CTFontSymbolicTraits = Longword;
  CTFontTableOptions = Longword;
  CTFontTableTag = Longword;
  CTFontUIFontType = Integer;
  CTFrameRef = Pointer;
  CTFramesetterRef = Pointer;
  CTGlyphInfoRef = Pointer;
  CTLineRef = Pointer;
  CTLineTruncationType = Longword;
  CTParagraphStyleRef = Pointer;
  CTParagraphStyleSpecifier = Longword;
  CTRunRef = Pointer;
  CTRunStatus = Longword;
  CTTextAlignment = Byte;
  CTTextTabRef = Pointer;
  CTTypesetterRef = Pointer;
  CVAttachmentMode = Longword;
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
  GLbitfield = Longword;
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
  GLenum = Longword;
  PGLenum = ^GLenum;
  GLfloat = Single;
  PGLfloat = ^GLfloat;
  GLhandleARB = Longword;
  PGLhandleARB = ^GLhandleARB;
  GLint = Integer;
  GLintptr = ^GLint;
  GLintptrARB = ^GLint;
  PGLint = ^GLint;
  GLshort = Smallint;
  PGLshort = ^GLshort;
  GLsizei = Integer;
  GLsizeiptr = ^GLsizei;
  GLsizeiptrARB = ^GLsizei;
  PGLsizei = ^GLsizei;
  GLubyte = Byte;
  PGLubyte = ^GLubyte;
  GLuint = Longword;
  PGLuint = ^GLuint;
  GLushort = Byte;
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
  NSOpenGLPixelFormatAttribute = Longword;
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


  AudioBuffer = record
    mNumberChannels: Longword;
    mDataByteSize: Longword;
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

  CGFunctionEvaluateCallback = procedure(info: Pointer; inData: Single; var outData: Single); cdecl;
  CGFunctionReleaseInfoCallback = procedure(info: Pointer); cdecl;

  CGFunctionCallbacks = record
    version: Longword;
    evaluate: CGFunctionEvaluateCallback;
    releaseInfo: CGFunctionReleaseInfoCallback;
  end;
  PCGFunctionCallbacks = ^CGFunctionCallbacks;

  CGEventTapInformation = record
    eventTapID: Longword;
    tapPoint: CGEventTapLocation;
    options: CGEventTapOptions;
    eventsOfInterest: CGEventMask;
    tappingProcess: Integer;
    processBeingTapped: Integer;
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
    version: Longword;
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
    valueSize: Longword;
    value: Pointer;
  end;
  PCTParagraphStyleSetting = ^CTParagraphStyleSetting;

  // CoreVideo data callbacks
  CVDisplayLinkOutputCallback = function(displayLink: CVDisplayLinkRef; const inNow: PCVTimeStamp;
    const inOutputTime: PCVTimestamp; flagsIn: CVOptionFlags; flagsOut: PCVOptionFlags;
    displayLinkContext: Pointer): CVReturn; cdecl;
  CVPixelBufferReleaseBytesCallback = procedure(releaseRefCon: Pointer; baseAddress: Pointer); cdecl;
  CVPixelBufferReleasePlanarBytesCallback = procedure(releaseRefCon: Pointer; dataPtr: Pointer;
    dataSize: Integer; numberOfPlanes: Integer; planeAddresses: PPointer); cdecl;

  AudioStreamBasicDescription = record
    mSampleRate: Double;
    mFormatID: Longword;
    mFormatFlags: Longword;
    mBytesPerPacket: Longword;
    mFramesPerPacket: Longword;
    mBytesPerFrame: Longword;
    mChannelsPerFrame: Longword;
    mBitsPerChannel: Longword;
    mReserved: Longword;
  end;
  PAudioStreamBasicDescription = ^AudioStreamBasicDescription;

  TAudioChannelCoordinatesArray = array[0..2] of Single;
  AudioChannelDescription = record
    mChannelLabel: AudioChannelLabel;
    mChannelFlags: Longword;
    mCoordinates: TAudioChannelCoordinatesArray;
  end;
  PAudioChannelDescription = ^AudioChannelDescription;

  AudioChannelLayout = record
    mChannelLayoutTag: AudioChannelLayoutTag;
    mChannelBitmap: Longword;
    mNumberChannelDescriptions: Longword;
    mChannelDescriptions: AudioChannelDescription;
  end;
  PAudioChannelLayout = ^AudioChannelLayout;

  AudioStreamPacketDescription = record
    mStartOffset: Int64;
    mVariableFramesInPacket: Longword;
    mDataByteSize: Longword;
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
    version: Longword;
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
    version: Longword;
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

// Base Cocoa NSObject
  NSObjectClass = interface(IObjectiveCClass)
    ['{84CDD025-E02A-4128-B1AC-35A7A5A4643B}']
  end;
  NSObject = interface(IObjectiveCInstance)
    ['{C8CC567E-50C3-461C-BAA7-AD96D2CDC5C6}']
    procedure retain; cdecl;
    procedure release; cdecl;
    function retainCount: Integer; cdecl;
    function isKindOfClass(cls: Pointer): Boolean; cdecl;
    function isMemberOfClass(cls: Pointer): Boolean; cdecl;
  end;
  TNSObject = class(TOCGenericImport<NSObjectClass, NSObject>) end;

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

end.
