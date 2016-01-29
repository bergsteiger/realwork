{**********************************************************}
{                                                          }
{           CodeGear Delphi Runtime Library                }
{                                                          }
{ Delphi-Objective-C Bridge                                }
{ Interfaces for Cocoa framework CoreVideo                 }
{                                                          }
{ Copyright (c) 2004 Apple Inc. All rights reserved.       }
{                                                          }
{ Translator: Embarcadero Technologies, Inc.               }
{   Copyright(c) 2012-2013 Embarcadero Technologies, Inc.  }
{                                                          }
{**********************************************************}

unit iOSapi.CoreVideo;

interface

uses Macapi.CoreFoundation, iOSapi.Foundation, iOSapi.CoreGraphics, iOSapi.OpenGLES;

const
  COREVIDEO_SUPPORTS_COLORSPACE = 0;
  COREVIDEO_SUPPORTS_DIRECT3D = 0;
  COREVIDEO_SUPPORTS_DISPLAYLINK = 0;
  COREVIDEO_SUPPORTS_IOSURFACE = 0;
  COREVIDEO_SUPPORTS_OPENGL = 0;
  COREVIDEO_SUPPORTS_OPENGLES = 1;
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

// ===== Typedefs and structs =====
type
{$M+}
  CVAttachmentMode = Longword;
  PCVAttachmentMode = ^CVAttachmentMode;
  CVBufferRef = IntPtr;
  CVDisplayLinkRef = IntPtr;
  PCVDisplayLinkRef = ^CVDisplayLinkRef;
  CVImageBufferRef = IntPtr;
  CVOpenGLESTextureCacheRef = IntPtr;
  PCVOpenGLESTextureCacheRef = ^CVOpenGLESTextureCacheRef;
  CVOpenGLESTextureRef = CVImageBufferRef;
  PCVOpenGLESTextureRef = ^CVOpenGLESTextureRef;
  CVOptionFlags = UInt64;
  PCVOptionFlags = ^CVOptionFlags;
  CVPixelBufferPoolRef = IntPtr;
  PCVPixelBufferPoolRef = ^CVPixelBufferPoolRef;
  CVPixelBufferRef = CVImageBufferRef;
  PCVPixelBufferRef = ^CVPixelBufferRef;
  CVReturn = Integer;

  CVPixelBufferReleaseBytesCallback = procedure(releaseRefCon: Pointer; baseAddress: Pointer); cdecl;

  CVPixelBufferReleasePlanarBytesCallback = procedure(releaseRefCon: Pointer; dataPtr: Pointer;
    dataSize: Integer; numberOfPlanes: Integer; planeAddresses: PPointer); cdecl;



function CVBufferGetAttachment(buffer: CVBufferRef; key: CFStringRef; attachmentMode: PCVAttachmentMode): CFTypeRef; cdecl; external libCoreVideo name _PU + 'CVBufferGetAttachment';
function CVBufferGetAttachments(buffer: CVBufferRef; attachmentMode: CVAttachmentMode): CFDictionaryRef; cdecl; external libCoreVideo name _PU + 'CVBufferGetAttachments';
procedure CVBufferPropagateAttachments(sourceBuffer: CVBufferRef; destinationBuffer: CVBufferRef); cdecl; external libCoreVideo name _PU + 'CVBufferPropagateAttachments';
procedure CVBufferRelease(buffer: CVBufferRef); cdecl; external libCoreVideo name _PU + 'CVBufferRelease';
procedure CVBufferRemoveAllAttachments(buffer: CVBufferRef); cdecl; external libCoreVideo name _PU + 'CVBufferRemoveAllAttachments';
procedure CVBufferRemoveAttachment(buffer: CVBufferRef; key: CFStringRef); cdecl; external libCoreVideo name _PU + 'CVBufferRemoveAttachment';
function CVBufferRetain(buffer: CVBufferRef): CVBufferRef; cdecl; external libCoreVideo name _PU + 'CVBufferRetain';
procedure CVBufferSetAttachment(buffer: CVBufferRef; key: CFStringRef; value: CFTypeRef; attachmentMode: CVAttachmentMode); cdecl; external libCoreVideo name _PU + 'CVBufferSetAttachment';
procedure CVBufferSetAttachments(buffer: CVBufferRef; theAttachments: CFDictionaryRef; attachmentMode: CVAttachmentMode); cdecl; external libCoreVideo name _PU + 'CVBufferSetAttachments';
function CVGetCurrentHostTime: UInt64; cdecl; external libCoreVideo name _PU + 'CVGetCurrentHostTime';
function CVGetHostClockFrequency: double; cdecl; external libCoreVideo name _PU + 'CVGetHostClockFrequency';
function CVGetHostClockMinimumTimeDelta: Longword; cdecl; external libCoreVideo name _PU + 'CVGetHostClockMinimumTimeDelta';
function CVImageBufferGetCleanRect(imageBuffer: CVImageBufferRef): CGRect; cdecl; external libCoreVideo name _PU + 'CVImageBufferGetCleanRect';
function CVImageBufferGetDisplaySize(imageBuffer: CVImageBufferRef): CGSize; cdecl; external libCoreVideo name _PU + 'CVImageBufferGetDisplaySize';
function CVImageBufferGetEncodedSize(imageBuffer: CVImageBufferRef): CGSize; cdecl; external libCoreVideo name _PU + 'CVImageBufferGetEncodedSize';
function CVOpenGLESTextureCacheCreate(allocator: CFAllocatorRef; cacheAttributes: CFDictionaryRef; eaglContext: Pointer; textureAttributes: CFDictionaryRef; cacheOut: PCVOpenGLESTextureCacheRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVOpenGLESTextureCacheCreate';
function CVOpenGLESTextureCacheCreateTextureFromImage(allocator: CFAllocatorRef; textureCache: CVOpenGLESTextureCacheRef; sourceImage: CVImageBufferRef; textureAttributes: CFDictionaryRef; target: GLenum; internalFormat: GLint; width: GLsizei; height: GLsizei; format: GLenum; type_: GLenum; planeIndex: Longword; textureOut: PCVOpenGLESTextureRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVOpenGLESTextureCacheCreateTextureFromImage';
procedure CVOpenGLESTextureCacheFlush(textureCache: CVOpenGLESTextureCacheRef; options: CVOptionFlags); cdecl; external libCoreVideo name _PU + 'CVOpenGLESTextureCacheFlush';
function CVOpenGLESTextureCacheGetTypeID: CFTypeID; cdecl; external libCoreVideo name _PU + 'CVOpenGLESTextureCacheGetTypeID';
procedure CVOpenGLESTextureGetCleanTexCoords(image: CVOpenGLESTextureRef; lowerLeft: PGLfloat; lowerRight: PGLfloat; upperRight: PGLfloat; upperLeft: PGLfloat); cdecl; external libCoreVideo name _PU + 'CVOpenGLESTextureGetCleanTexCoords';
function CVOpenGLESTextureGetName(image: CVOpenGLESTextureRef): GLuint; cdecl; external libCoreVideo name _PU + 'CVOpenGLESTextureGetName';
function CVOpenGLESTextureGetTarget(image: CVOpenGLESTextureRef): GLenum; cdecl; external libCoreVideo name _PU + 'CVOpenGLESTextureGetTarget';
function CVOpenGLESTextureGetTypeID: CFTypeID; cdecl; external libCoreVideo name _PU + 'CVOpenGLESTextureGetTypeID';
function CVOpenGLESTextureIsFlipped(image: CVOpenGLESTextureRef): Boolean; cdecl; external libCoreVideo name _PU + 'CVOpenGLESTextureIsFlipped';
function CVPixelBufferCreate(allocator: CFAllocatorRef; width: Longword; height: Longword; pixelFormatType: OSType; pixelBufferAttributes: CFDictionaryRef; pixelBufferOut: PCVPixelBufferRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferCreate';
function CVPixelBufferCreateResolvedAttributesDictionary(allocator: CFAllocatorRef; attributes: CFArrayRef; resolvedDictionaryOut: PCFDictionaryRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferCreateResolvedAttributesDictionary';
function CVPixelBufferCreateWithBytes(allocator: CFAllocatorRef; width: Longword; height: Longword; pixelFormatType: OSType; baseAddress: Pointer; bytesPerRow: Longword; releaseCallback: CVPixelBufferReleaseBytesCallback; releaseRefCon: Pointer; pixelBufferAttributes: CFDictionaryRef; pixelBufferOut: PCVPixelBufferRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferCreateWithBytes';
function CVPixelBufferCreateWithPlanarBytes(allocator: CFAllocatorRef; width: Longword; height: Longword; pixelFormatType: OSType; dataPtr: Pointer; dataSize: Longword; numberOfPlanes: Longword; planeBaseAddress: Pvoid; planeWidth: PLongword; planeHeight: PLongword; planeBytesPerRow: PLongword; releaseCallback: CVPixelBufferReleasePlanarBytesCallback; releaseRefCon: Pointer; pixelBufferAttributes: CFDictionaryRef; pixelBufferOut: PCVPixelBufferRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferCreateWithPlanarBytes';
function CVPixelBufferFillExtendedPixels(pixelBuffer: CVPixelBufferRef): CVReturn; cdecl; external libCoreVideo name _PU + 'CVPixelBufferFillExtendedPixels';
function CVPixelBufferGetBaseAddress(pixelBuffer: CVPixelBufferRef): Pointer; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetBaseAddress';
function CVPixelBufferGetBaseAddressOfPlane(pixelBuffer: CVPixelBufferRef; planeIndex: Longword): Pointer; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetBaseAddressOfPlane';
function CVPixelBufferGetBytesPerRow(pixelBuffer: CVPixelBufferRef): Longword; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetBytesPerRow';
function CVPixelBufferGetBytesPerRowOfPlane(pixelBuffer: CVPixelBufferRef; planeIndex: Longword): Longword; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetBytesPerRowOfPlane';
function CVPixelBufferGetDataSize(pixelBuffer: CVPixelBufferRef): Longword; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetDataSize';
procedure CVPixelBufferGetExtendedPixels(pixelBuffer: CVPixelBufferRef; extraColumnsOnLeft: PLongword; extraColumnsOnRight: PLongword; extraRowsOnTop: PLongword; extraRowsOnBottom: PLongword); cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetExtendedPixels';
function CVPixelBufferGetHeight(pixelBuffer: CVPixelBufferRef): Longword; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetHeight';
function CVPixelBufferGetHeightOfPlane(pixelBuffer: CVPixelBufferRef; planeIndex: Longword): Longword; cdecl; external libCoreVideo name _PU + 'CVPixelBufferGetHeightOfPlane';
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
