{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework QuartzCore 
//
unit Macapi.QuartzCore;

interface

uses
  Macapi.ObjCRuntime,
  Macapi.ObjectiveC,
  Macapi.CocoaTypes,
//  Macapi.CoreVideo,
  Macapi.CoreFoundation,
//  Macapi.ApplicationServices,
  Macapi.OpenGL,
//  Macapi.IOKit,
  Macapi.Foundation,
//  Macapi.Accelerate,
//  Macapi.OpenCL,
//  Macapi.IOSurface,
  Macapi.CoreServices;

const
  kCAConstraintHeight = 7;
  kCAConstraintMaxX = 2;
  kCAConstraintMaxY = 6;
  kCAConstraintMidX = 1;
  kCAConstraintMidY = 5;
  kCAConstraintMinX = 0;
  kCAConstraintMinY = 4;
  kCAConstraintWidth = 3;
  kCALayerBottomEdge = 4;
  kCALayerHeightSizable = 16;
  kCALayerLeftEdge = 1;
  kCALayerMaxXMargin = 4;
  kCALayerMaxYMargin = 32;
  kCALayerMinXMargin = 1;
  kCALayerMinYMargin = 8;
  kCALayerNotSizable = 0;
  kCALayerRightEdge = 2;
  kCALayerTopEdge = 8;
  kCALayerWidthSizable = 2;
  kCVAttachmentMode_ShouldNotPropagate = 0;
  kCVAttachmentMode_ShouldPropagate = 1;
  kCVPixelBufferLock_ReadOnly = 1;
  kCVPixelFormatType_16BE555 = 16;
  kCVPixelFormatType_16BE565 = 1110783541;
  kCVPixelFormatType_16Gray = 1647392359;
  kCVPixelFormatType_16LE555 = 1278555445;
  kCVPixelFormatType_16LE5551 = 892679473;
  kCVPixelFormatType_16LE565 = 1278555701;
  kCVPixelFormatType_1IndexedGray_WhiteIsZero = 33;
  kCVPixelFormatType_1Monochrome = 1;
  kCVPixelFormatType_24BGR = 842285639;
  kCVPixelFormatType_24RGB = 24;
  kCVPixelFormatType_2Indexed = 2;
  kCVPixelFormatType_2IndexedGray_WhiteIsZero = 34;
  kCVPixelFormatType_32ABGR = 1094862674;
  kCVPixelFormatType_32ARGB = 32;
  kCVPixelFormatType_32AlphaGray = 1647522401;
  kCVPixelFormatType_32BGRA = 1111970369;
  kCVPixelFormatType_32RGBA = 1380401729;
  kCVPixelFormatType_420YpCbCr8Planar = 2033463856;
  kCVPixelFormatType_422YpCbCr10 = 1983000880;
  kCVPixelFormatType_422YpCbCr16 = 1983000886;
  kCVPixelFormatType_422YpCbCr8 = 846624121;
  kCVPixelFormatType_422YpCbCr_4A_8BiPlanar = 1630697081;
  kCVPixelFormatType_4444YpCbCrA8 = 1983131704;
  kCVPixelFormatType_4444YpCbCrA8R = 1916022840;
  kCVPixelFormatType_444YpCbCr10 = 1983131952;
  kCVPixelFormatType_444YpCbCr8 = 1983066168;
  kCVPixelFormatType_48RGB = 1647589490;
  kCVPixelFormatType_4Indexed = 4;
  kCVPixelFormatType_4IndexedGray_WhiteIsZero = 36;
  kCVPixelFormatType_64ARGB = 1647719521;
  kCVPixelFormatType_8Indexed = 8;
  kCVPixelFormatType_8IndexedGray_WhiteIsZero = 40;
  kCVReturnAllocationFailed = -6662;
  kCVReturnDisplayLinkAlreadyRunning = -6671;
  kCVReturnDisplayLinkCallbacksNotSet = -6673;
  kCVReturnDisplayLinkNotRunning = -6672;
  kCVReturnError = -6660;
  kCVReturnFirst = -6660;
  kCVReturnInvalidArgument = -6661;
  kCVReturnInvalidDisplay = -6670;
  kCVReturnInvalidPixelBufferAttributes = -6682;
  kCVReturnInvalidPixelFormat = -6680;
  kCVReturnInvalidPoolAttributes = -6691;
  kCVReturnInvalidSize = -6681;
  kCVReturnLast = -6699;
  kCVReturnPixelBufferNotOpenGLCompatible = -6683;
  kCVReturnPoolAllocationFailed = -6690;
  kCVReturnSuccess = 0;
  kCVSMPTETimeRunning = 2;
  kCVSMPTETimeType24 = 0;
  kCVSMPTETimeType25 = 1;
  kCVSMPTETimeType2997 = 4;
  kCVSMPTETimeType2997Drop = 5;
  kCVSMPTETimeType30 = 3;
  kCVSMPTETimeType30Drop = 2;
  kCVSMPTETimeType5994 = 7;
  kCVSMPTETimeType60 = 6;
  kCVSMPTETimeValid = 1;
  kCVTimeIsIndefinite = 1;
  kCVTimeStampBottomField = 131072;
  kCVTimeStampHostTimeValid = 2;
  kCVTimeStampIsInterlaced = 196608;
  kCVTimeStampRateScalarValid = 16;
  kCVTimeStampSMPTETimeValid = 4;
  kCVTimeStampTopField = 65536;
  kCVTimeStampVideoHostTimeValid = 3;
  kCVTimeStampVideoRefreshPeriodValid = 8;
  kCVTimeStampVideoTimeValid = 1;

type
{$M+}
// ===== Forward declarations =====

  CIFilterShape = interface;
  CIFilterGenerator = interface;
  CIImage = interface;
  CARenderer = interface;
  CIImageAccumulator = interface;
  CAValueFunction = interface;
  CIColor = interface;
  CIContext = interface;
  CIFilter = interface;
  CATransaction = interface;
  CAEmitterCell = interface;
  CIVector = interface;
  CAConstraintLayoutManager = interface;
  CAAnimation = interface;
  CAConstraint = interface;
  CIPlugIn = interface;
  CIKernel = interface;
  CAMediaTimingFunction = interface;
  CISampler = interface;
  CALayer = interface;
  CAPropertyAnimation = interface;
  CAReplicatorLayer = interface;
  CAEmitterLayer = interface;
  CAOpenGLLayer = interface;
  CAScrollLayer = interface;
  CATiledLayer = interface;
  CATransition = interface;
  CAShapeLayer = interface;
  CATextLayer = interface;
  CAKeyframeAnimation = interface;

// ===== Interface declarations =====

  CIFilterShapeClass = interface(NSObjectClass)
    ['{ED8A8D4B-5AAB-423F-A952-7DE68D8442DC}']
    {class} function shapeWithRect(r: CGRect): Pointer; cdecl;
  end;
  CIFilterShape = interface(NSObject)
    ['{35F7A213-E6D5-4212-9221-B61A70D84EE3}']
    function initWithRect(r: CGRect): Pointer; cdecl;
    function insetByX(dx: Integer; Y: Integer): CIFilterShape; cdecl;
    function intersectWith(s2: CIFilterShape): CIFilterShape; cdecl;
    function intersectWithRect(r: CGRect): CIFilterShape; cdecl;
    function transformBy(m: CGAffineTransform; interior: Boolean): CIFilterShape; cdecl;
    function unionWith(s2: CIFilterShape): CIFilterShape; cdecl;
    function unionWithRect(r: CGRect): CIFilterShape; cdecl;
  end;
  TCIFilterShape = class(TOCGenericImport<CIFilterShapeClass, CIFilterShape>)  end;

  CIFilterGeneratorClass = interface(NSObjectClass)
    ['{75AB872D-017A-45C6-8845-74B58A213148}']
    {class} function filterGenerator: Pointer; cdecl;
    {class} function filterGeneratorWithContentsOfURL(aURL: NSURL): Pointer; cdecl;
  end;
  CIFilterGenerator = interface(NSObject)
    ['{A0574B1F-E96C-4030-ACAE-46E88E4A187B}']
    function classAttributes: NSDictionary; cdecl;
    procedure exportKey(key: NSString; fromObject: Pointer; withName: NSString); cdecl;
    function exportedKeys: NSDictionary; cdecl;
    function filter: CIFilter; cdecl;
    function initWithContentsOfURL(aURL: NSURL): Pointer; cdecl;
    procedure registerFilterName(name: NSString); cdecl;
    procedure removeExportedKey(exportedKeyName: NSString); cdecl;
    procedure setAttributes(attributes: NSDictionary; forExportedKey: NSString); cdecl;
    procedure setClassAttributes(attributes: NSDictionary); cdecl;
    function writeToURL(aURL: NSURL; atomically: Boolean): Boolean; cdecl;
  end;
  TCIFilterGenerator = class(TOCGenericImport<CIFilterGeneratorClass, CIFilterGenerator>)  end;

  CIImageClass = interface(NSObjectClass)
    ['{D3FB7E49-7AE6-442C-9947-460096835C6F}']
    {class} function emptyImage: Pointer; cdecl;
    {class} function imageWithBitmapData(d: NSData; bytesPerRow: Longword; size: CGSize; format: CIFormat; colorSpace: CGColorSpaceRef): Pointer; cdecl;
    {class} function imageWithCGImage(image: CGImageRef): Pointer; cdecl; overload;
    {class} function imageWithCGImage(image: CGImageRef; options: NSDictionary): Pointer; cdecl; overload;
    {class} function imageWithCGLayer(layer: CGLayerRef): Pointer; cdecl; overload;
    {class} function imageWithCGLayer(layer: CGLayerRef; options: NSDictionary): Pointer; cdecl; overload;
    {class} function imageWithCVImageBuffer(imageBuffer: CVImageBufferRef): Pointer; cdecl; overload;
    {class} function imageWithCVImageBuffer(imageBuffer: CVImageBufferRef; options: NSDictionary): Pointer; cdecl; overload;
    {class} function imageWithColor(color: CIColor): Pointer; cdecl;
    {class} function imageWithContentsOfURL(url: NSURL): Pointer; cdecl; overload;
    {class} function imageWithContentsOfURL(url: NSURL; options: NSDictionary): Pointer; cdecl; overload;
    {class} function imageWithData(data: NSData): Pointer; cdecl; overload;
    {class} function imageWithData(data: NSData; options: NSDictionary): Pointer; cdecl; overload;
    {class} function imageWithIOSurface(surface: IOSurfaceRef): Pointer; cdecl; overload;
    {class} function imageWithIOSurface(surface: IOSurfaceRef; options: NSDictionary): Pointer; cdecl; overload;
    {class} function imageWithTexture(name: Longword; size: CGSize; flipped: Boolean; colorSpace: CGColorSpaceRef): Pointer; cdecl;
  end;
  CIImage = interface(NSObject)
    ['{8D285E15-52E9-485B-9221-5EA231BD3C09}']
    function colorSpace: CGColorSpaceRef; cdecl;
    function definition: CIFilterShape; cdecl;
    function extent: CGRect; cdecl;
    function imageByApplyingTransform(matrix: CGAffineTransform): CIImage; cdecl;
    function imageByCroppingToRect(r: CGRect): CIImage; cdecl;
    function initWithBitmapData(d: NSData; bytesPerRow: Longword; size: CGSize; format: CIFormat; colorSpace: CGColorSpaceRef): Pointer; cdecl;
    function initWithCGImage(image: CGImageRef): Pointer; cdecl; overload;
    function initWithCGImage(image: CGImageRef; options: NSDictionary): Pointer; cdecl; overload;
    function initWithCGLayer(layer: CGLayerRef): Pointer; cdecl; overload;
    function initWithCGLayer(layer: CGLayerRef; options: NSDictionary): Pointer; cdecl; overload;
    function initWithCVImageBuffer(imageBuffer: CVImageBufferRef): Pointer; cdecl; overload;
    function initWithCVImageBuffer(imageBuffer: CVImageBufferRef; options: NSDictionary): Pointer; cdecl; overload;
    function initWithColor(color: CIColor): Pointer; cdecl;
    function initWithContentsOfURL(url: NSURL): Pointer; cdecl; overload;
    function initWithContentsOfURL(url: NSURL; options: NSDictionary): Pointer; cdecl; overload;
    function initWithData(data: NSData): Pointer; cdecl; overload;
    function initWithData(data: NSData; options: NSDictionary): Pointer; cdecl; overload;
    function initWithIOSurface(surface: IOSurfaceRef): Pointer; cdecl; overload;
    function initWithIOSurface(surface: IOSurfaceRef; options: NSDictionary): Pointer; cdecl; overload;
    function initWithTexture(name: Longword; size: CGSize; flipped: Boolean; colorSpace: CGColorSpaceRef): Pointer; cdecl;
    function url: NSURL; cdecl;
  end;
  TCIImage = class(TOCGenericImport<CIImageClass, CIImage>)  end;

  CARendererClass = interface(NSObjectClass)
    ['{5A13E20D-59C9-4321-B060-D624748F918A}']
    {class} function rendererWithCGLContext(ctx: Pointer; options: NSDictionary): Pointer; cdecl;
  end;
  CARenderer = interface(NSObject)
    ['{D05F308E-25F5-4543-963F-3568CEB67207}']
    procedure addUpdateRect(r: CGRect); cdecl;
    procedure beginFrameAtTime(t: CFTimeInterval; timeStamp: CVTimeStamp); cdecl;
    function bounds: CGRect; cdecl;
    procedure endFrame; cdecl;
    function nextFrameTime: CFTimeInterval; cdecl;
    procedure render; cdecl;
    function updateBounds: CGRect; cdecl;
  end;
  TCARenderer = class(TOCGenericImport<CARendererClass, CARenderer>)  end;

  CIImageAccumulatorClass = interface(NSObjectClass)
    ['{49446EC1-C100-4746-AFFE-1C15D4198E0C}']
    {class} function imageAccumulatorWithExtent(r: CGRect; format: CIFormat): Pointer; cdecl;
  end;
  CIImageAccumulator = interface(NSObject)
    ['{C81718DB-5748-44D8-8B84-4A4F25B06112}']
    procedure clear; cdecl;
    function extent: CGRect; cdecl;
    function format: CIFormat; cdecl;
    function image: CIImage; cdecl;
    function initWithExtent(r: CGRect; format: CIFormat): Pointer; cdecl;
    procedure setImage(im: CIImage); cdecl; overload;
    procedure setImage(im: CIImage; dirtyRect: CGRect); cdecl; overload;
  end;
  TCIImageAccumulator = class(TOCGenericImport<CIImageAccumulatorClass, CIImageAccumulator>)  end;

  CAValueFunctionClass = interface(NSObjectClass)
    ['{82418C77-4498-4DB3-80F0-0592AE9C4B2C}']
    {class} function functionWithName(name: NSString): Pointer; cdecl;
  end;
  CAValueFunction = interface(NSObject)
    ['{04D17FD8-4062-48AA-AE7C-94988C11FEB4}']
  end;
  TCAValueFunction = class(TOCGenericImport<CAValueFunctionClass, CAValueFunction>)  end;

  CIColorClass = interface(NSObjectClass)
    ['{A2F27478-8912-446C-B207-8BD1E3D56008}']
    {class} function colorWithCGColor(c: CGColorRef): Pointer; cdecl;
    {class} function colorWithRed(r: Single; green: Single; blue: Single): Pointer; cdecl; overload;
    {class} function colorWithRed(r: Single; green: Single; blue: Single; alpha: Single): Pointer; cdecl; overload;
    {class} function colorWithString(representation: NSString): Pointer; cdecl;
  end;
  CIColor = interface(NSObject)
    ['{69FC8229-391D-4F70-8CA4-3551D8CC7B08}']
    function alpha: Single; cdecl;
    function blue: Single; cdecl;
    function colorSpace: CGColorSpaceRef; cdecl;
    function components: PSingle; cdecl;
    function green: Single; cdecl;
    function initWithCGColor(c: CGColorRef): Pointer; cdecl;
    function numberOfComponents: Longword; cdecl;
    function red: Single; cdecl;
    function stringRepresentation: NSString; cdecl;
  end;
  TCIColor = class(TOCGenericImport<CIColorClass, CIColor>)  end;

  CIContextClass = interface(NSObjectClass)
    ['{A780D4D7-165A-46EE-9632-1B95ED8240DE}']
    {class} function contextWithCGContext(ctx: CGContextRef; options: NSDictionary): Pointer; cdecl;
    {class} function contextWithCGLContext(ctx: CGLContextObj; pixelFormat: CGLPixelFormatObj; colorSpace: CGColorSpaceRef; options: NSDictionary): Pointer; cdecl; overload;
    {class} function contextWithCGLContext(ctx: CGLContextObj; pixelFormat: CGLPixelFormatObj; options: NSDictionary): Pointer; cdecl; overload;
  end;
  CIContext = interface(NSObject)
    ['{77E5A1EC-047D-4575-8F8A-A8CF61E6B9E9}']
    procedure clearCaches; cdecl;
    function createCGImage(im: CIImage; fromRect: CGRect): CGImageRef; cdecl; overload;
    function createCGImage(im: CIImage; fromRect: CGRect; format: CIFormat; colorSpace: CGColorSpaceRef): CGImageRef; cdecl; overload;
    function createCGLayerWithSize(size: CGSize; info: CFDictionaryRef): CGLayerRef; cdecl;
    procedure drawImage(im: CIImage; atPoint: CGPoint; fromRect: CGRect); cdecl; overload;
    procedure drawImage(im: CIImage; inRect: CGRect; fromRect: CGRect); cdecl; overload;
    procedure reclaimResources; cdecl;
    procedure render(im: CIImage; toBitmap: Pointer; rowBytes: Integer; bounds: CGRect; format: CIFormat; colorSpace: CGColorSpaceRef); cdecl; overload;
    procedure render(im: CIImage; toIOSurface: IOSurfaceRef; bounds: CGRect; colorSpace: CGColorSpaceRef); cdecl; overload;
  end;
  TCIContext = class(TOCGenericImport<CIContextClass, CIContext>)  end;

  CIFilterClass = interface(NSObjectClass)
    ['{FB4A9CD9-7D60-482D-A0F4-4F78FC6E7E8D}']
    {class} function filterNamesInCategories(categories: NSArray): NSArray; cdecl;
    {class} function filterNamesInCategory(category: NSString): NSArray; cdecl;
    {class} function filterWithImageData(data: NSData; options: NSDictionary): Pointer; cdecl;
    {class} function filterWithImageURL(url: NSURL; options: NSDictionary): Pointer; cdecl;
    {class} function filterWithName(name: NSString): Pointer; cdecl; overload;
    {class} function filterWithName(name: NSString; keysAndValues: Pointer): Pointer; cdecl; overload;
    {class} function localizedDescriptionForFilterName(filterName: NSString): NSString; cdecl;
    {class} function localizedNameForCategory(category: NSString): NSString; cdecl;
    {class} function localizedNameForFilterName(filterName: NSString): NSString; cdecl;
    {class} function localizedReferenceDocumentationForFilterName(filterName: NSString): NSURL; cdecl;
  end;
  CIFilter = interface(NSObject)
    ['{2ACA27E7-D365-4AAC-A474-E72867CDE89A}']
    function apply(apply: CIKernel): CIImage; cdecl; overload;
    function apply(k: CIKernel; arguments: NSArray; options: NSDictionary): CIImage; cdecl; overload;
    function attributes: NSDictionary; cdecl;
    function inputKeys: NSArray; cdecl;
    function isEnabled: Boolean; cdecl;
    function outputKeys: NSArray; cdecl;
    procedure setDefaults; cdecl;
  end;
  TCIFilter = class(TOCGenericImport<CIFilterClass, CIFilter>)  end;

  CATransactionClass = interface(NSObjectClass)
    ['{B8C38335-959C-401F-9541-B3B1CEC7E23A}']
    {class} function animationDuration: CFTimeInterval; cdecl;
    {class} function animationTimingFunction: CAMediaTimingFunction; cdecl;
    {class} procedure commit; cdecl;
    {class} function disableActions: Boolean; cdecl;
    {class} procedure flush; cdecl;
    {class} procedure lock; cdecl;
    {class} procedure setAnimationDuration(dur: CFTimeInterval); cdecl;
    {class} procedure setAnimationTimingFunction(function_: CAMediaTimingFunction); cdecl;
    {class} procedure setDisableActions(flag: Boolean); cdecl;
    {class} procedure setValue(anObject: Pointer; forKey: NSString); cdecl;
    {class} procedure unlock; cdecl;
    {class} function valueForKey(key: NSString): Pointer; cdecl;
  end;
  CATransaction = interface(NSObject)
    ['{1DD225E1-BD0F-4613-8A11-04A207C582CD}']
  end;
  TCATransaction = class(TOCGenericImport<CATransactionClass, CATransaction>)  end;

  CAEmitterCellClass = interface(NSObjectClass)
    ['{6BF67269-6556-44CC-A70B-FE29F34FFBDF}']
    {class} function defaultValueForKey(key: NSString): Pointer; cdecl;
    {class} function emitterCell: Pointer; cdecl;
  end;
  CAEmitterCell = interface(NSObject)
    ['{4D0670A7-801B-419B-97A3-7B016FD913D9}']
    function birthRate: Single; cdecl;
    function color: CGColorRef; cdecl;
    function contents: Pointer; cdecl;
    function contentsRect: CGRect; cdecl;
    function emissionRange: Single; cdecl;
    function isEnabled: Boolean; cdecl;
    function minificationFilterBias: Single; cdecl;
    function shouldArchiveValueForKey(key: NSString): Boolean; cdecl;
  end;
  TCAEmitterCell = class(TOCGenericImport<CAEmitterCellClass, CAEmitterCell>)  end;

  CIVectorClass = interface(NSObjectClass)
    ['{DBD5A5B9-95CD-4B9E-B422-818C9EC8007C}']
    {class} function vectorWithString(representation: NSString): Pointer; cdecl;
    {class} function vectorWithValues(values: PSingle; count: Longword): Pointer; cdecl;
    {class} function vectorWithX(x: Single): Pointer; cdecl; overload;
    {class} function vectorWithX(x: Single; Y: Single): Pointer; cdecl; overload;
    {class} function vectorWithX(x: Single; Y: Single; Z: Single): Pointer; cdecl; overload;
    {class} function vectorWithX(x: Single; Y: Single; Z: Single; W: Single): Pointer; cdecl; overload;
  end;
  CIVector = interface(NSObject)
    ['{7A610174-AB7D-4DF3-837D-F73B6FC060A8}']
    function W: Single; cdecl;
    function X: Single; cdecl;
    function Y: Single; cdecl;
    function Z: Single; cdecl;
    function count: Longword; cdecl;
    function initWithString(representation: NSString): Pointer; cdecl;
    function initWithValues(values: PSingle; count: Longword): Pointer; cdecl;
    function initWithX(x: Single): Pointer; cdecl; overload;
    function initWithX(x: Single; Y: Single): Pointer; cdecl; overload;
    function initWithX(x: Single; Y: Single; Z: Single): Pointer; cdecl; overload;
    function initWithX(x: Single; Y: Single; Z: Single; W: Single): Pointer; cdecl; overload;
    function stringRepresentation: NSString; cdecl;
    function valueAtIndex(index: Longword): Single; cdecl;
  end;
  TCIVector = class(TOCGenericImport<CIVectorClass, CIVector>)  end;

  CAConstraintLayoutManagerClass = interface(NSObjectClass)
    ['{04C7822E-7FCA-46A9-BCC9-8D86C0FB8951}']
    {class} function layoutManager: Pointer; cdecl;
  end;
  CAConstraintLayoutManager = interface(NSObject)
    ['{1CE3E266-8893-443C-B014-BA0EB44D5799}']
  end;
  TCAConstraintLayoutManager = class(TOCGenericImport<CAConstraintLayoutManagerClass, CAConstraintLayoutManager>)  end;

  CAAnimationClass = interface(NSObjectClass)
    ['{0C8F28C8-B612-4F9B-BF75-68E0627842FC}']
    {class} function animation: Pointer; cdecl;
    {class} function defaultValueForKey(key: NSString): Pointer; cdecl;
  end;
  CAAnimation = interface(NSObject)
    ['{8375F506-70C6-4DF8-9CCC-D788DE9AA0A1}']
    function delegate: Pointer; cdecl;
    function isRemovedOnCompletion: Boolean; cdecl;
    function shouldArchiveValueForKey(key: NSString): Boolean; cdecl;
  end;
  TCAAnimation = class(TOCGenericImport<CAAnimationClass, CAAnimation>)  end;

  CAConstraintClass = interface(NSObjectClass)
    ['{070C5BDE-94D7-4FFE-8FA8-913FAD0E4BE2}']
    {class} function constraintWithAttribute(attr: CAConstraintAttribute; relativeTo: NSString; attribute: CAConstraintAttribute): Pointer; cdecl; overload;
    {class} function constraintWithAttribute(attr: CAConstraintAttribute; relativeTo: NSString; attribute: CAConstraintAttribute; offset: Single): Pointer; cdecl; overload;
    {class} function constraintWithAttribute(attr: CAConstraintAttribute; relativeTo: NSString; attribute: CAConstraintAttribute; scale: Single; offset: Single): Pointer; cdecl; overload;
  end;
  CAConstraint = interface(NSObject)
    ['{29B688CE-80A3-47A5-87D7-F1BBD249858C}']
    function attribute: CAConstraintAttribute; cdecl;
    function initWithAttribute(attr: CAConstraintAttribute; relativeTo: NSString; attribute: CAConstraintAttribute; scale: Single; offset: Single): Pointer; cdecl;
    function sourceAttribute: CAConstraintAttribute; cdecl;
  end;
  TCAConstraint = class(TOCGenericImport<CAConstraintClass, CAConstraint>)  end;

  CIPlugInClass = interface(NSObjectClass)
    ['{8FC38418-AA0C-4514-B420-CE441CFE96E2}']
    {class} procedure loadAllPlugIns; cdecl;
    {class} procedure loadNonExecutablePlugIns; cdecl;
    {class} procedure loadPlugIn(url: NSURL; allowNonExecutable: Boolean); cdecl;
  end;
  CIPlugIn = interface(NSObject)
    ['{A5B434A1-06E3-4E04-9641-8D2FF3EA97F8}']
  end;
  TCIPlugIn = class(TOCGenericImport<CIPlugInClass, CIPlugIn>)  end;

  CIKernelClass = interface(NSObjectClass)
    ['{CF116953-138D-4A94-8300-AFFA5EAC770A}']
    {class} function kernelsWithString(s: NSString): NSArray; cdecl;
  end;
  CIKernel = interface(NSObject)
    ['{8FC12CBD-DC49-4578-8DD4-BCFF1708AE71}']
    function name: NSString; cdecl;
    procedure setROISelector(aMethod: SEL); cdecl;
  end;
  TCIKernel = class(TOCGenericImport<CIKernelClass, CIKernel>)  end;

  CAMediaTimingFunctionClass = interface(NSObjectClass)
    ['{A04935B8-C4CC-4C76-A353-745627C47254}']
    {class} function functionWithName(name: NSString): Pointer; cdecl;
  end;
  CAMediaTimingFunction = interface(NSObject)
    ['{3B618AF2-9186-4CA6-A09D-E5898146C58E}']
    procedure getControlPointAtIndex(idx: Longword; values: PSingle); cdecl;
  end;
  TCAMediaTimingFunction = class(TOCGenericImport<CAMediaTimingFunctionClass, CAMediaTimingFunction>)  end;

  CISamplerClass = interface(NSObjectClass)
    ['{1B2313BE-7BF5-49B3-92C0-126A3F4A6AD7}']
    {class} function samplerWithImage(im: CIImage): Pointer; cdecl; overload;
    {class} function samplerWithImage(im: CIImage; keysAndValues: Pointer): Pointer; cdecl; overload;
    {class} function samplerWithImage(im: CIImage; options: NSDictionary): Pointer; cdecl; overload;
  end;
  CISampler = interface(NSObject)
    ['{1B002855-B2D0-4532-9A8C-86D358745156}']
    function definition: CIFilterShape; cdecl;
    function extent: CGRect; cdecl;
    function initWithImage(im: CIImage): Pointer; cdecl; overload;
    function initWithImage(im: CIImage; keysAndValues: Pointer): Pointer; cdecl; overload;
    function initWithImage(im: CIImage; options: NSDictionary): Pointer; cdecl; overload;
  end;
  TCISampler = class(TOCGenericImport<CISamplerClass, CISampler>)  end;

  CALayerClass = interface(NSObjectClass)
    ['{823F25B4-4D05-4056-A36A-92A0A7251E90}']
    {class} function defaultActionForKey(event: NSString): Pointer; cdecl;
    {class} function defaultValueForKey(key: NSString): Pointer; cdecl;
    {class} function layer: Pointer; cdecl;
    {class} function needsDisplayForKey(key: NSString): Boolean; cdecl;
  end;
  CALayer = interface(NSObject)
    ['{3C0F4360-B3C0-44A2-8107-A8E2F1F8043A}']
    function actionForKey(event: NSString): Pointer; cdecl;
    procedure addAnimation(anim: CAAnimation; forKey: NSString); cdecl;
    procedure addConstraint(c: CAConstraint); cdecl;
    procedure addSublayer(layer: CALayer); cdecl;
    function affineTransform: CGAffineTransform; cdecl;
    function anchorPoint: CGPoint; cdecl;
    function anchorPointZ: Single; cdecl;
    function animationForKey(key: NSString): CAAnimation; cdecl;
    function animationKeys: NSArray; cdecl;
    function autoresizingMask: Longword; cdecl;
    function backgroundColor: CGColorRef; cdecl;
    function borderColor: CGColorRef; cdecl;
    function borderWidth: Single; cdecl;
    function bounds: CGRect; cdecl;
    function compositingFilter: Pointer; cdecl;
    function containsPoint(p: CGPoint): Boolean; cdecl;
    function contents: Pointer; cdecl;
    function contentsAreFlipped: Boolean; cdecl;
    function contentsCenter: CGRect; cdecl;
    function contentsRect: CGRect; cdecl;
    function convertPoint(p: CGPoint; fromLayer: CALayer): CGPoint; cdecl; overload;
//    function convertPoint(p: CGPoint; toLayer: CALayer): CGPoint; cdecl; overload;
    function convertRect(r: CGRect; fromLayer: CALayer): CGRect; cdecl; overload;
//    function convertRect(r: CGRect; toLayer: CALayer): CGRect; cdecl; overload;
    function convertTime(t: CFTimeInterval; fromLayer: CALayer): CFTimeInterval; cdecl; overload;
//    function convertTime(t: CFTimeInterval; toLayer: CALayer): CFTimeInterval; cdecl; overload;
    function cornerRadius: Single; cdecl;
    function delegate: Pointer; cdecl;
    procedure display; cdecl;
    procedure displayIfNeeded; cdecl;
    procedure drawInContext(ctx: CGContextRef); cdecl;
    function edgeAntialiasingMask: Longword; cdecl;
    function frame: CGRect; cdecl;
    function hitTest(p: CGPoint): CALayer; cdecl;
    function init: Pointer; cdecl;
    function initWithLayer(layer: Pointer): Pointer; cdecl;
    procedure insertSublayer(layer: CALayer; above: CALayer); cdecl; overload;
    procedure insertSublayer(layer: CALayer; atIndex: Longword); cdecl; overload;
//    procedure insertSublayer(layer: CALayer; below: CALayer); cdecl; overload;
    function isDoubleSided: Boolean; cdecl;
    function isGeometryFlipped: Boolean; cdecl;
    function isHidden: Boolean; cdecl;
    function isOpaque: Boolean; cdecl;
    procedure layoutIfNeeded; cdecl;
    function layoutManager: Pointer; cdecl;
    procedure layoutSublayers; cdecl;
    function masksToBounds: Boolean; cdecl;
    function minificationFilterBias: Single; cdecl;
    function modelLayer: Pointer; cdecl;
    function needsDisplay: Boolean; cdecl;
    function needsDisplayOnBoundsChange: Boolean; cdecl;
    function needsLayout: Boolean; cdecl;
    function opacity: Single; cdecl;
    function position: CGPoint; cdecl;
    function preferredFrameSize: CGSize; cdecl;
    function presentationLayer: Pointer; cdecl;
    procedure removeAllAnimations; cdecl;
    procedure removeAnimationForKey(key: NSString); cdecl;
    procedure removeFromSuperlayer; cdecl;
    procedure renderInContext(ctx: CGContextRef); cdecl;
    procedure resizeSublayersWithOldSize(size: CGSize); cdecl;
    procedure resizeWithOldSuperlayerSize(size: CGSize); cdecl;
    procedure scrollPoint(p: CGPoint); cdecl;
    procedure scrollRectToVisible(r: CGRect); cdecl;
    procedure setAffineTransform(m: CGAffineTransform); cdecl;
    procedure setNeedsDisplay; cdecl;
    procedure setNeedsDisplayInRect(r: CGRect); cdecl;
    procedure setNeedsLayout; cdecl;
    function shadowColor: CGColorRef; cdecl;
    function shadowOffset: CGSize; cdecl;
    function shadowOpacity: Single; cdecl;
    function shadowRadius: Single; cdecl;
    function shouldArchiveValueForKey(key: NSString): Boolean; cdecl;
//    function sublayerTransform: CATransform3D; cdecl;
//    function transform: CATransform3D; cdecl;
    function visibleRect: CGRect; cdecl;
    function zPosition: Single; cdecl;
  end;
  TCALayer = class(TOCGenericImport<CALayerClass, CALayer>)  end;

  CAPropertyAnimationClass = interface(CAAnimationClass)
    ['{7AA4A635-1425-4275-869C-4C5F73A2747F}']
    {class} function animationWithKeyPath(path: NSString): Pointer; cdecl;
  end;
  CAPropertyAnimation = interface(CAAnimation)
    ['{44F26264-6297-4231-84EC-7306D90262B4}']
    function isAdditive: Boolean; cdecl;
    function isCumulative: Boolean; cdecl;
  end;
  TCAPropertyAnimation = class(TOCGenericImport<CAPropertyAnimationClass, CAPropertyAnimation>)  end;

  CAReplicatorLayerClass = interface(CALayerClass)
    ['{1E3D066F-E82F-481B-8B4C-AB259C857750}']
  end;
  CAReplicatorLayer = interface(CALayer)
    ['{01096F71-0869-42AB-BD7F-B4EE358B7CB6}']
    function instanceColor: CGColorRef; cdecl;
    function instanceCount: NSInteger; cdecl;
    function instanceDelay: CFTimeInterval; cdecl;
//    function instanceTransform: CATransform3D; cdecl;
    function preservesDepth: Boolean; cdecl;
  end;
  TCAReplicatorLayer = class(TOCGenericImport<CAReplicatorLayerClass, CAReplicatorLayer>)  end;

  CAEmitterLayerClass = interface(CALayerClass)
    ['{A5941A9C-3379-4A31-8E50-629FFD409253}']
  end;
  CAEmitterLayer = interface(CALayer)
    ['{1F9542A1-8D2A-414E-B122-44D292470CF2}']
    function birthRate: Single; cdecl;
    function emitterDepth: Single; cdecl;
    function emitterPosition: CGPoint; cdecl;
    function emitterSize: CGSize; cdecl;
    function emitterZPosition: Single; cdecl;
    function lifetime: Single; cdecl;
    function preservesDepth: Boolean; cdecl;
    function scale: Single; cdecl;
    function seed: Longword; cdecl;
    function spin: Single; cdecl;
    function velocity: Single; cdecl;
  end;
  TCAEmitterLayer = class(TOCGenericImport<CAEmitterLayerClass, CAEmitterLayer>)  end;

  CAOpenGLLayerClass = interface(CALayerClass)
    ['{7FE40FFF-0D70-4204-92F8-95AC42367FAD}']
  end;
  CAOpenGLLayer = interface(CALayer)
    ['{73B4E831-B119-43E6-AAE2-CBFE791AABCA}']
    function canDrawInCGLContext(ctx: CGLContextObj; pixelFormat: CGLPixelFormatObj; forLayerTime: CFTimeInterval; displayTime: CVTimeStamp): Boolean; cdecl;
    function copyCGLContextForPixelFormat(pf: CGLPixelFormatObj): CGLContextObj; cdecl;
    function copyCGLPixelFormatForDisplayMask(mask: Longword): CGLPixelFormatObj; cdecl;
    procedure drawInCGLContext(ctx: CGLContextObj; pixelFormat: CGLPixelFormatObj; forLayerTime: CFTimeInterval; displayTime: CVTimeStamp); cdecl;
    function isAsynchronous: Boolean; cdecl;
    procedure releaseCGLContext(ctx: CGLContextObj); cdecl;
    procedure releaseCGLPixelFormat(pf: CGLPixelFormatObj); cdecl;
  end;
  TCAOpenGLLayer = class(TOCGenericImport<CAOpenGLLayerClass, CAOpenGLLayer>)  end;

  CAScrollLayerClass = interface(CALayerClass)
    ['{BD3C0193-537D-41A6-A125-027A5033ECF5}']
  end;
  CAScrollLayer = interface(CALayer)
    ['{41A6B827-A437-48F9-A0B9-141FD53288D6}']
    procedure scrollToPoint(p: CGPoint); cdecl;
    procedure scrollToRect(r: CGRect); cdecl;
  end;
  TCAScrollLayer = class(TOCGenericImport<CAScrollLayerClass, CAScrollLayer>)  end;

  CATiledLayerClass = interface(CALayerClass)
    ['{C04C8DF6-FC39-4984-A4D1-8429BCE47F38}']
    {class} function fadeDuration: CFTimeInterval; cdecl;
  end;
  CATiledLayer = interface(CALayer)
    ['{0B8D2A6A-1515-427F-98A0-E5EBCD22311B}']
    function levelsOfDetail: Longword; cdecl;
    function levelsOfDetailBias: Longword; cdecl;
    function tileSize: CGSize; cdecl;
  end;
  TCATiledLayer = class(TOCGenericImport<CATiledLayerClass, CATiledLayer>)  end;

  CATransitionClass = interface(CAAnimationClass)
    ['{9F1841A6-FBFF-459C-A0AB-662CF9472A4C}']
  end;
  CATransition = interface(CAAnimation)
    ['{872CFF39-2B64-4B95-806A-E4B2E58CB4B9}']
    function filter: Pointer; cdecl;
  end;
  TCATransition = class(TOCGenericImport<CATransitionClass, CATransition>)  end;

  CAShapeLayerClass = interface(CALayerClass)
    ['{1447D2FE-0303-47BA-83B8-5CB98F45C380}']
  end;
  CAShapeLayer = interface(CALayer)
    ['{D31277EF-1563-44B6-8F5F-43AFAC6765D3}']
    function fillColor: CGColorRef; cdecl;
    function lineDashPhase: Single; cdecl;
    function lineWidth: Single; cdecl;
    function miterLimit: Single; cdecl;
    function path: CGPathRef; cdecl;
    function strokeColor: CGColorRef; cdecl;
  end;
  TCAShapeLayer = class(TOCGenericImport<CAShapeLayerClass, CAShapeLayer>)  end;

  CATextLayerClass = interface(CALayerClass)
    ['{94BB4F2B-865A-48FA-8D11-4A4F0790EE15}']
  end;
  CATextLayer = interface(CALayer)
    ['{8A31948D-FB88-41DF-9166-60F0A427879F}']
    function font: CFTypeRef; cdecl;
    function fontSize: Single; cdecl;
    function foregroundColor: CGColorRef; cdecl;
    function isWrapped: Boolean; cdecl;
  end;
  TCATextLayer = class(TOCGenericImport<CATextLayerClass, CATextLayer>)  end;

  CAKeyframeAnimationClass = interface(CAPropertyAnimationClass)
    ['{85E0B579-2543-49DC-BD61-4EA394194FCC}']
  end;
  CAKeyframeAnimation = interface(CAPropertyAnimation)
    ['{729DAB9B-561A-4788-B034-6E89C7055497}']
    function path: CGPathRef; cdecl;
  end;
  TCAKeyframeAnimation = class(TOCGenericImport<CAKeyframeAnimationClass, CAKeyframeAnimation>)  end;



implementation
end.
