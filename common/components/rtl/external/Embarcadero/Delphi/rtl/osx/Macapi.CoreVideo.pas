{****************************************************************}
{                                                                }
{               CodeGear Delphi Runtime Library                  }
{                                                                }
{      Copyright(c) 2010-2013 Embarcadero Technologies, Inc.     }
{                                                                }
{****************************************************************}
{  Delphi-Objective-C Bridge                                     }
{  Interfaces for Cocoa framework CoreVideo                      }
{                                                                }
{  Copyright (c) 2004 Apple Computer, Inc. All rights reserved.  }
{                                                                }
{  Translator: Embarcadero Technologies, Inc.                    }
{  Copyright (c) 2012-2013 Embarcadero Technologies, Inc.        }
{****************************************************************}
unit Macapi.CoreVideo;

interface

uses
  Macapi.ObjCRuntime,
  Macapi.ObjectiveC,
  Macapi.CocoaTypes,
  Macapi.CoreFoundation,
  Macapi.Foundation,
//  Macapi.ApplicationServices,
  Macapi.OpenGL,
//  Macapi.IOKit,
//  Macapi.IOSurface,
  Macapi.CoreServices;

const
  COREVIDEO_SUPPORTS_COLORSPACE = 1;
  COREVIDEO_SUPPORTS_DIRECT3D = 0;
  COREVIDEO_SUPPORTS_DISPLAYLINK = 1;
  COREVIDEO_SUPPORTS_IOSURFACE = 1;
  COREVIDEO_SUPPORTS_OPENGL = 1;
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
  kCVPixelFormatType_30RGB = 1378955371;
  kCVPixelFormatType_32ABGR = 1094862674;
  kCVPixelFormatType_32ARGB = 32;
  kCVPixelFormatType_32AlphaGray = 1647522401;
  kCVPixelFormatType_32BGRA = 1111970369;
  kCVPixelFormatType_32RGBA = 1380401729;
  kCVPixelFormatType_420YpCbCr8BiPlanarFullRange = 875704422;
  kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange = 875704438;
  kCVPixelFormatType_420YpCbCr8Planar = 2033463856;
  kCVPixelFormatType_420YpCbCr8PlanarFullRange = 1714696752;
  kCVPixelFormatType_422YpCbCr10 = 1983000880;
  kCVPixelFormatType_422YpCbCr16 = 1983000886;
  kCVPixelFormatType_422YpCbCr8 = 846624121;
  kCVPixelFormatType_422YpCbCr8FullRange = 2037741158;
  kCVPixelFormatType_422YpCbCr8_yuvs = 2037741171;
  kCVPixelFormatType_422YpCbCr_4A_8BiPlanar = 1630697081;
  kCVPixelFormatType_4444AYpCbCr16 = 2033463606;
  kCVPixelFormatType_4444AYpCbCr8 = 2033463352;
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
  kCVReturnWouldExceedAllocationThreshold = -6689;
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

// ===== External functions =====

const
  libCoreVideo = '/System/Library/Frameworks/CoreVideo.framework/CoreVideo';

function CVBufferGetAttachment(buffer: CVBufferRef; key: CFStringRef; attachmentMode: PCVAttachmentMode): CFTypeRef; cdecl; external libCoreVideo name _PU + 'CVBufferGetAttachment';
function CVBufferGetAttachments(buffer: CVBufferRef; attachmentMode: CVAttachmentMode): CFDictionaryRef; cdecl; external libCoreVideo name _PU + 'CVBufferGetAttachments';
procedure CVBufferPropagateAttachments(sourceBuffer: CVBufferRef; destinationBuffer: CVBufferRef); cdecl; external libCoreVideo name _PU + 'CVBufferPropagateAttachments';
procedure CVBufferRelease(buffer: CVBufferRef); cdecl; external libCoreVideo name _PU + 'CVBufferRelease';
procedure CVBufferRemoveAllAttachments(buffer: CVBufferRef); cdecl; external libCoreVideo name _PU + 'CVBufferRemoveAllAttachments';
procedure CVBufferRemoveAttachment(buffer: CVBufferRef; key: CFStringRef); cdecl; external libCoreVideo name _PU + 'CVBufferRemoveAttachment';
function CVBufferRetain(buffer: CVBufferRef): CVBufferRef; cdecl; external libCoreVideo name _PU + 'CVBufferRetain';
procedure CVBufferSetAttachment(buffer: CVBufferRef; key: CFStringRef; value: CFTypeRef; attachmentMode: CVAttachmentMode); cdecl; external libCoreVideo name _PU + 'CVBufferSetAttachment';
procedure CVBufferSetAttachments(buffer: CVBufferRef; theAttachments: CFDictionaryRef; attachmentMode: CVAttachmentMode); cdecl; external libCoreVideo name _PU + 'CVBufferSetAttachments';
function CVDisplayLinkCreateWithActiveCGDisplays(displayLinkOut: PCVDisplayLinkRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkCreateWithActiveCGDisplays';
function CVDisplayLinkCreateWithCGDisplay(displayID: CGDirectDisplayID; displayLinkOut: PCVDisplayLinkRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkCreateWithCGDisplay';
function CVDisplayLinkCreateWithCGDisplays(displayArray: PCGDirectDisplayID; count: CFIndex; displayLinkOut: PCVDisplayLinkRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkCreateWithCGDisplays';
function CVDisplayLinkCreateWithOpenGLDisplayMask(mask: CGOpenGLDisplayMask; displayLinkOut: PCVDisplayLinkRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkCreateWithOpenGLDisplayMask';
function CVDisplayLinkGetActualOutputVideoRefreshPeriod(displayLink: CVDisplayLinkRef): double; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkGetActualOutputVideoRefreshPeriod';
function CVDisplayLinkGetCurrentCGDisplay(displayLink: CVDisplayLinkRef): CGDirectDisplayID; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkGetCurrentCGDisplay';
function CVDisplayLinkGetCurrentTime(displayLink: CVDisplayLinkRef; outTime: PCVTimeStamp): CVReturn; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkGetCurrentTime';
function CVDisplayLinkGetNominalOutputVideoRefreshPeriod(displayLink: CVDisplayLinkRef): CVTime; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkGetNominalOutputVideoRefreshPeriod';
function CVDisplayLinkGetOutputVideoLatency(displayLink: CVDisplayLinkRef): CVTime; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkGetOutputVideoLatency';
function CVDisplayLinkGetTypeID: CFTypeID; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkGetTypeID';
function CVDisplayLinkIsRunning(displayLink: CVDisplayLinkRef): Boolean; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkIsRunning';
procedure CVDisplayLinkRelease(displayLink: CVDisplayLinkRef); cdecl; external libCoreVideo name _PU + 'CVDisplayLinkRelease';
function CVDisplayLinkRetain(displayLink: CVDisplayLinkRef): CVDisplayLinkRef; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkRetain';
function CVDisplayLinkSetCurrentCGDisplay(displayLink: CVDisplayLinkRef; displayID: CGDirectDisplayID): CVReturn; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkSetCurrentCGDisplay';
function CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(displayLink: CVDisplayLinkRef; cglContext: CGLContextObj; cglPixelFormat: CGLPixelFormatObj): CVReturn; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext';
function CVDisplayLinkSetOutputCallback(displayLink: CVDisplayLinkRef; callback: CVDisplayLinkOutputCallback; userInfo: Pointer): CVReturn; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkSetOutputCallback';
function CVDisplayLinkStart(displayLink: CVDisplayLinkRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkStart';
function CVDisplayLinkStop(displayLink: CVDisplayLinkRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkStop';
function CVDisplayLinkTranslateTime(displayLink: CVDisplayLinkRef; inTime: PCVTimeStamp; outTime: PCVTimeStamp): CVReturn; cdecl; external libCoreVideo name _PU + 'CVDisplayLinkTranslateTime';
function CVGetCurrentHostTime: UInt64; cdecl; external libCoreVideo name _PU + 'CVGetCurrentHostTime';
function CVGetHostClockFrequency: double; cdecl; external libCoreVideo name _PU + 'CVGetHostClockFrequency';
function CVGetHostClockMinimumTimeDelta: Longword; cdecl; external libCoreVideo name _PU + 'CVGetHostClockMinimumTimeDelta';
function CVImageBufferGetCleanRect(imageBuffer: CVImageBufferRef): CGRect; cdecl; external libCoreVideo name _PU + 'CVImageBufferGetCleanRect';
function CVImageBufferGetColorSpace(imageBuffer: CVImageBufferRef): CGColorSpaceRef; cdecl; external libCoreVideo name _PU + 'CVImageBufferGetColorSpace';
function CVImageBufferGetDisplaySize(imageBuffer: CVImageBufferRef): CGSize; cdecl; external libCoreVideo name _PU + 'CVImageBufferGetDisplaySize';
function CVImageBufferGetEncodedSize(imageBuffer: CVImageBufferRef): CGSize; cdecl; external libCoreVideo name _PU + 'CVImageBufferGetEncodedSize';
function CVOpenGLBufferAttach(openGLBuffer: CVOpenGLBufferRef; cglContext: CGLContextObj; face: GLenum; level: GLint; screen: GLint): CVReturn; cdecl; external libCoreVideo name _PU + 'CVOpenGLBufferAttach';
function CVOpenGLBufferCreate(allocator: CFAllocatorRef; width: Longword; height: Longword; attributes: CFDictionaryRef; bufferOut: PCVOpenGLBufferRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVOpenGLBufferCreate';
function CVOpenGLBufferGetAttributes(openGLBuffer: CVOpenGLBufferRef): CFDictionaryRef; cdecl; external libCoreVideo name _PU + 'CVOpenGLBufferGetAttributes';
function CVOpenGLBufferGetTypeID: CFTypeID; cdecl; external libCoreVideo name _PU + 'CVOpenGLBufferGetTypeID';
function CVOpenGLBufferPoolCreate(allocator: CFAllocatorRef; poolAttributes: CFDictionaryRef; openGLBufferAttributes: CFDictionaryRef; poolOut: PCVOpenGLBufferPoolRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVOpenGLBufferPoolCreate';
function CVOpenGLBufferPoolCreateOpenGLBuffer(allocator: CFAllocatorRef; openGLBufferPool: CVOpenGLBufferPoolRef; openGLBufferOut: PCVOpenGLBufferRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVOpenGLBufferPoolCreateOpenGLBuffer';
function CVOpenGLBufferPoolGetAttributes(pool: CVOpenGLBufferPoolRef): CFDictionaryRef; cdecl; external libCoreVideo name _PU + 'CVOpenGLBufferPoolGetAttributes';
function CVOpenGLBufferPoolGetOpenGLBufferAttributes(pool: CVOpenGLBufferPoolRef): CFDictionaryRef; cdecl; external libCoreVideo name _PU + 'CVOpenGLBufferPoolGetOpenGLBufferAttributes';
function CVOpenGLBufferPoolGetTypeID: CFTypeID; cdecl; external libCoreVideo name _PU + 'CVOpenGLBufferPoolGetTypeID';
procedure CVOpenGLBufferPoolRelease(openGLBufferPool: CVOpenGLBufferPoolRef); cdecl; external libCoreVideo name _PU + 'CVOpenGLBufferPoolRelease';
function CVOpenGLBufferPoolRetain(openGLBufferPool: CVOpenGLBufferPoolRef): CVOpenGLBufferPoolRef; cdecl; external libCoreVideo name _PU + 'CVOpenGLBufferPoolRetain';
procedure CVOpenGLBufferRelease(buffer: CVOpenGLBufferRef); cdecl; external libCoreVideo name _PU + 'CVOpenGLBufferRelease';
function CVOpenGLBufferRetain(buffer: CVOpenGLBufferRef): CVOpenGLBufferRef; cdecl; external libCoreVideo name _PU + 'CVOpenGLBufferRetain';
function CVOpenGLTextureCacheCreate(allocator: CFAllocatorRef; cacheAttributes: CFDictionaryRef; cglContext: CGLContextObj; cglPixelFormat: CGLPixelFormatObj; textureAttributes: CFDictionaryRef; cacheOut: PCVOpenGLTextureCacheRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVOpenGLTextureCacheCreate';
function CVOpenGLTextureCacheCreateTextureFromImage(allocator: CFAllocatorRef; textureCache: CVOpenGLTextureCacheRef; sourceImage: CVImageBufferRef; attributes: CFDictionaryRef; textureOut: PCVOpenGLTextureRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVOpenGLTextureCacheCreateTextureFromImage';
procedure CVOpenGLTextureCacheFlush(textureCache: CVOpenGLTextureCacheRef; options: CVOptionFlags); cdecl; external libCoreVideo name _PU + 'CVOpenGLTextureCacheFlush';
function CVOpenGLTextureCacheGetTypeID: CFTypeID; cdecl; external libCoreVideo name _PU + 'CVOpenGLTextureCacheGetTypeID';
procedure CVOpenGLTextureCacheRelease(textureCache: CVOpenGLTextureCacheRef); cdecl; external libCoreVideo name _PU + 'CVOpenGLTextureCacheRelease';
function CVOpenGLTextureCacheRetain(textureCache: CVOpenGLTextureCacheRef): CVOpenGLTextureCacheRef; cdecl; external libCoreVideo name _PU + 'CVOpenGLTextureCacheRetain';
procedure CVOpenGLTextureGetCleanTexCoords(image: CVOpenGLTextureRef; lowerLeft: PGLfloat; lowerRight: PGLfloat; upperRight: PGLfloat; upperLeft: PGLfloat); cdecl; external libCoreVideo name _PU + 'CVOpenGLTextureGetCleanTexCoords';
function CVOpenGLTextureGetName(image: CVOpenGLTextureRef): GLuint; cdecl; external libCoreVideo name _PU + 'CVOpenGLTextureGetName';
function CVOpenGLTextureGetTarget(image: CVOpenGLTextureRef): GLenum; cdecl; external libCoreVideo name _PU + 'CVOpenGLTextureGetTarget';
function CVOpenGLTextureGetTypeID: CFTypeID; cdecl; external libCoreVideo name _PU + 'CVOpenGLTextureGetTypeID';
function CVOpenGLTextureIsFlipped(image: CVOpenGLTextureRef): Boolean; cdecl; external libCoreVideo name _PU + 'CVOpenGLTextureIsFlipped';
procedure CVOpenGLTextureRelease(texture: CVOpenGLTextureRef); cdecl; external libCoreVideo name _PU + 'CVOpenGLTextureRelease';
function CVOpenGLTextureRetain(texture: CVOpenGLTextureRef): CVOpenGLTextureRef; cdecl; external libCoreVideo name _PU + 'CVOpenGLTextureRetain';
function CVPixelBufferCreate(allocator: CFAllocatorRef; width: Longword; height: Longword; pixelFormatType: OSType; pixelBufferAttributes: CFDictionaryRef; pixelBufferOut: PCVPixelBufferRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferCreate';
function CVPixelBufferCreateResolvedAttributesDictionary(allocator: CFAllocatorRef; attributes: CFArrayRef; resolvedDictionaryOut: PCFDictionaryRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferCreateResolvedAttributesDictionary';
function CVPixelBufferCreateWithBytes(allocator: CFAllocatorRef; width: Longword; height: Longword; pixelFormatType: OSType; baseAddress: Pointer; bytesPerRow: Longword; releaseCallback: CVPixelBufferReleaseBytesCallback; releaseRefCon: Pointer; pixelBufferAttributes: CFDictionaryRef; pixelBufferOut: PCVPixelBufferRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferCreateWithBytes';
function CVPixelBufferCreateWithIOSurface(allocator: CFAllocatorRef; surface: IOSurfaceRef; pixelBufferAttributes: CFDictionaryRef; pixelBufferOut: PCVPixelBufferRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferCreateWithIOSurface';
function CVPixelBufferCreateWithPlanarBytes(allocator: CFAllocatorRef; width: Longword; height: Longword; pixelFormatType: OSType; dataPtr: Pointer; dataSize: Longword; numberOfPlanes: Longword; planeBaseAddress: Pointer; planeWidth: PLongword; planeHeight: PLongword; planeBytesPerRow: PLongword; releaseCallback: CVPixelBufferReleasePlanarBytesCallback; releaseRefCon: Pointer; pixelBufferAttributes: CFDictionaryRef; pixelBufferOut: PCVPixelBufferRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferCreateWithPlanarBytes';
function CVPixelBufferFillExtendedPixels(pixelBuffer: CVPixelBufferRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferFillExtendedPixels';
function CVPixelBufferGetBaseAddress(pixelBuffer: CVPixelBufferRef): Pointer; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetBaseAddress';
function CVPixelBufferGetBaseAddressOfPlane(pixelBuffer: CVPixelBufferRef; planeIndex: Longword): Pointer; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetBaseAddressOfPlane';
function CVPixelBufferGetBytesPerRow(pixelBuffer: CVPixelBufferRef): Longword; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetBytesPerRow';
function CVPixelBufferGetBytesPerRowOfPlane(pixelBuffer: CVPixelBufferRef; planeIndex: Longword): Longword; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetBytesPerRowOfPlane';
function CVPixelBufferGetDataSize(pixelBuffer: CVPixelBufferRef): Longword; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetDataSize';
procedure CVPixelBufferGetExtendedPixels(pixelBuffer: CVPixelBufferRef; extraColumnsOnLeft: PLongword; extraColumnsOnRight: PLongword; extraRowsOnTop: PLongword; extraRowsOnBottom: PLongword); cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetExtendedPixels';
function CVPixelBufferGetHeight(pixelBuffer: CVPixelBufferRef): Longword; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetHeight';
function CVPixelBufferGetHeightOfPlane(pixelBuffer: CVPixelBufferRef; planeIndex: Longword): Longword; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetHeightOfPlane';
function CVPixelBufferGetIOSurface(pixelBuffer: CVPixelBufferRef): IOSurfaceRef; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetIOSurface';
function CVPixelBufferGetPixelFormatType(pixelBuffer: CVPixelBufferRef): OSType; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetPixelFormatType';
function CVPixelBufferGetPlaneCount(pixelBuffer: CVPixelBufferRef): Longword; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetPlaneCount';
function CVPixelBufferGetTypeID: CFTypeID; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetTypeID';
function CVPixelBufferGetWidth(pixelBuffer: CVPixelBufferRef): Longword; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetWidth';
function CVPixelBufferGetWidthOfPlane(pixelBuffer: CVPixelBufferRef; planeIndex: Longword): Longword; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetWidthOfPlane';
function CVPixelBufferIsPlanar(pixelBuffer: CVPixelBufferRef): Boolean; cdecl; external libCoreVideo name _PU + 'CVPixelBufferIsPlanar';
function CVPixelBufferLockBaseAddress(pixelBuffer: CVPixelBufferRef; lockFlags: CVOptionFlags): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferLockBaseAddress';
function CVPixelBufferPoolCreate(allocator: CFAllocatorRef; poolAttributes: CFDictionaryRef; pixelBufferAttributes: CFDictionaryRef; poolOut: PCVPixelBufferPoolRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferPoolCreate';
function CVPixelBufferPoolCreatePixelBuffer(allocator: CFAllocatorRef; pixelBufferPool: CVPixelBufferPoolRef; pixelBufferOut: PCVPixelBufferRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferPoolCreatePixelBuffer';
function CVPixelBufferPoolCreatePixelBufferWithAuxAttributes(allocator: CFAllocatorRef; pixelBufferPool: CVPixelBufferPoolRef; auxAttributes: CFDictionaryRef; pixelBufferOut: PCVPixelBufferRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferPoolCreatePixelBufferWithAuxAttributes';
function CVPixelBufferPoolGetAttributes(pool: CVPixelBufferPoolRef): CFDictionaryRef; cdecl; external libCoreVideo name _PU + 'CVPixelBufferPoolGetAttributes';
function CVPixelBufferPoolGetPixelBufferAttributes(pool: CVPixelBufferPoolRef): CFDictionaryRef; cdecl; external libCoreVideo name _PU + 'CVPixelBufferPoolGetPixelBufferAttributes';
function CVPixelBufferPoolGetTypeID: CFTypeID; cdecl; external libCoreVideo name _PU + 'CVPixelBufferPoolGetTypeID';
procedure CVPixelBufferPoolRelease(pixelBufferPool: CVPixelBufferPoolRef); cdecl; external libCoreVideo name _PU + 'CVPixelBufferPoolRelease';
function CVPixelBufferPoolRetain(pixelBufferPool: CVPixelBufferPoolRef): CVPixelBufferPoolRef; cdecl; external libCoreVideo name _PU + 'CVPixelBufferPoolRetain';
procedure CVPixelBufferRelease(texture: CVPixelBufferRef); cdecl; external libCoreVideo name _PU + 'CVPixelBufferRelease';
function CVPixelBufferRetain(texture: CVPixelBufferRef): CVPixelBufferRef; cdecl; external libCoreVideo name _PU + 'CVPixelBufferRetain';
function CVPixelBufferUnlockBaseAddress(pixelBuffer: CVPixelBufferRef; unlockFlags: CVOptionFlags): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferUnlockBaseAddress';
function CVPixelFormatDescriptionArrayCreateWithAllPixelFormatTypes(allocator: CFAllocatorRef): CFArrayRef; cdecl; external libCoreVideo name _PU + 'CVPixelFormatDescriptionArrayCreateWithAllPixelFormatTypes';
function CVPixelFormatDescriptionCreateWithPixelFormatType(allocator: CFAllocatorRef; pixelFormat: OSType): CFDictionaryRef; cdecl; external libCoreVideo name _PU + 'CVPixelFormatDescriptionCreateWithPixelFormatType';
procedure CVPixelFormatDescriptionRegisterDescriptionWithPixelFormatType(description: CFDictionaryRef; pixelFormat: OSType); cdecl; external libCoreVideo name _PU + 'CVPixelFormatDescriptionRegisterDescriptionWithPixelFormatType';

function kCVPixelBufferPixelFormatTypeKey: CFStringRef;

implementation

function kCVPixelBufferPixelFormatTypeKey: CFStringRef;
begin
  Result := CFStringRef(CocoaPointerConst(libCoreVideo, 'kCVPixelBufferPixelFormatTypeKey')^);
end;

end.
