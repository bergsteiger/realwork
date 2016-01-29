{****************************************************************}
{                                                                }
{               CodeGear Delphi Runtime Library                  }
{                                                                }
{      Copyright(c) 2010-2013 Embarcadero Technologies, Inc.     }
{                                                                }
{****************************************************************}
{  Delphi-Objective-C Bridge                                     }
{  Interfaces for Cocoa framework CoreMedia                      }
{                                                                }
{  Copyright 2010-2012 Apple Inc. All rights reserved.           }
{                                                                }
{  Translator: Embarcadero Technologies, Inc.                    }
{  Copyright (c) 2012-2013 Embarcadero Technologies, Inc.        }
{****************************************************************}

unit Macapi.CoreMedia;

interface

uses
  Macapi.ObjCRuntime,
  Macapi.ObjectiveC,
  Macapi.CocoaTypes,
  Macapi.Foundation,
//  Macapi.CoreAudio,
  Macapi.CoreFoundation,
  Macapi.CoreVideo;

const
  kCMAttachmentMode_ShouldNotPropagate = 0;
  kCMAttachmentMode_ShouldPropagate = 1;
  kCMAudioCodecType_AAC_AudibleProtected = 1633771875;
  kCMAudioCodecType_AAC_LCProtected = 1885430115;
  kCMAudioFormatDescriptionMask_All = 15;
  kCMAudioFormatDescriptionMask_ChannelLayout = 4;
  kCMAudioFormatDescriptionMask_Extensions = 8;
  kCMAudioFormatDescriptionMask_MagicCookie = 2;
  kCMAudioFormatDescriptionMask_StreamBasicDescription = 1;
  kCMBlockBufferAlwaysCopyDataFlag = 2;
  kCMBlockBufferAssureMemoryNowFlag = 1;
  kCMBlockBufferBadCustomBlockSourceErr = -12702;
  kCMBlockBufferBadLengthParameterErr = -12704;
  kCMBlockBufferBadOffsetParameterErr = -12703;
  kCMBlockBufferBadPointerParameterErr = -12705;
  kCMBlockBufferBlockAllocationFailedErr = -12701;
  kCMBlockBufferCustomBlockSourceVersion = 0;
  kCMBlockBufferDontOptimizeDepthFlag = 4;
  kCMBlockBufferEmptyBBufErr = -12706;
  kCMBlockBufferNoErr = 0;
  kCMBlockBufferPermitEmptyReferenceFlag = 8;
  kCMBlockBufferStructureAllocationFailedErr = -12700;
  kCMBlockBufferUnallocatedBlockErr = -12707;
  kCMBufferQueueError_AllocationFailed = -12760;
  kCMBufferQueueError_BadTriggerDuration = -12765;
  kCMBufferQueueError_CannotModifyQueueFromTriggerCallback = -12766;
  kCMBufferQueueError_EnqueueAfterEndOfData = -12763;
  kCMBufferQueueError_InvalidBuffer = -12769;
  kCMBufferQueueError_InvalidCMBufferCallbacksStruct = -12762;
  kCMBufferQueueError_InvalidTriggerCondition = -12767;
  kCMBufferQueueError_InvalidTriggerToken = -12768;
  kCMBufferQueueError_QueueIsFull = -12764;
  kCMBufferQueueError_RequiredParameterMissing = -12761;
  kCMBufferQueueTrigger_WhenBufferCountBecomesGreaterThan = 11;
  kCMBufferQueueTrigger_WhenBufferCountBecomesLessThan = 10;
  kCMBufferQueueTrigger_WhenDataBecomesReady = 7;
  kCMBufferQueueTrigger_WhenDurationBecomesGreaterThan = 3;
  kCMBufferQueueTrigger_WhenDurationBecomesGreaterThanOrEqualTo = 4;
  kCMBufferQueueTrigger_WhenDurationBecomesLessThan = 1;
  kCMBufferQueueTrigger_WhenDurationBecomesLessThanOrEqualTo = 2;
  kCMBufferQueueTrigger_WhenEndOfDataReached = 8;
  kCMBufferQueueTrigger_WhenMaxPresentationTimeStampChanges = 6;
  kCMBufferQueueTrigger_WhenMinPresentationTimeStampChanges = 5;
  kCMBufferQueueTrigger_WhenReset = 9;
  kCMClosedCaptionFormatType_ATSC = 1635017571;
  kCMClosedCaptionFormatType_CEA608 = 1664495672;
  kCMClosedCaptionFormatType_CEA708 = 1664561208;
  kCMFormatDescriptionError_AllocationFailed = -12711;
  kCMFormatDescriptionError_InvalidParameter = -12710;
  kCMMPEG2VideoProfile_HDV_1080i50 = 1751414323;
  kCMMPEG2VideoProfile_HDV_1080i60 = 1751414322;
  kCMMPEG2VideoProfile_HDV_1080p24 = 1751414326;
  kCMMPEG2VideoProfile_HDV_1080p25 = 1751414327;
  kCMMPEG2VideoProfile_HDV_1080p30 = 1751414328;
  kCMMPEG2VideoProfile_HDV_720p24 = 1751414324;
  kCMMPEG2VideoProfile_HDV_720p25 = 1751414325;
  kCMMPEG2VideoProfile_HDV_720p30 = 1751414321;
  kCMMPEG2VideoProfile_HDV_720p50 = 1751414369;
  kCMMPEG2VideoProfile_HDV_720p60 = 1751414329;
  kCMMPEG2VideoProfile_XDCAM_EX_1080i50_VBR35 = 2019849827;
  kCMMPEG2VideoProfile_XDCAM_EX_1080i60_VBR35 = 2019849826;
  kCMMPEG2VideoProfile_XDCAM_EX_1080p24_VBR35 = 2019849828;
  kCMMPEG2VideoProfile_XDCAM_EX_1080p25_VBR35 = 2019849829;
  kCMMPEG2VideoProfile_XDCAM_EX_1080p30_VBR35 = 2019849830;
  kCMMPEG2VideoProfile_XDCAM_EX_720p24_VBR35 = 2019849780;
  kCMMPEG2VideoProfile_XDCAM_EX_720p25_VBR35 = 2019849781;
  kCMMPEG2VideoProfile_XDCAM_EX_720p30_VBR35 = 2019849777;
  kCMMPEG2VideoProfile_XDCAM_EX_720p50_VBR35 = 2019849825;
  kCMMPEG2VideoProfile_XDCAM_EX_720p60_VBR35 = 2019849785;
  kCMMPEG2VideoProfile_XDCAM_HD422_1080i50_CBR50 = 2019833187;
  kCMMPEG2VideoProfile_XDCAM_HD422_1080i60_CBR50 = 2019833186;
  kCMMPEG2VideoProfile_XDCAM_HD422_1080p24_CBR50 = 2019833188;
  kCMMPEG2VideoProfile_XDCAM_HD422_1080p25_CBR50 = 2019833189;
  kCMMPEG2VideoProfile_XDCAM_HD422_1080p30_CBR50 = 2019833190;
  kCMMPEG2VideoProfile_XDCAM_HD422_540p = 2019846194;
  kCMMPEG2VideoProfile_XDCAM_HD422_720p24_CBR50 = 2019833140;
  kCMMPEG2VideoProfile_XDCAM_HD422_720p25_CBR50 = 2019833141;
  kCMMPEG2VideoProfile_XDCAM_HD422_720p30_CBR50 = 2019833137;
  kCMMPEG2VideoProfile_XDCAM_HD422_720p50_CBR50 = 2019833185;
  kCMMPEG2VideoProfile_XDCAM_HD422_720p60_CBR50 = 2019833145;
  kCMMPEG2VideoProfile_XDCAM_HD_1080i50_VBR35 = 2019849779;
  kCMMPEG2VideoProfile_XDCAM_HD_1080i60_VBR35 = 2019849778;
  kCMMPEG2VideoProfile_XDCAM_HD_1080p24_VBR35 = 2019849782;
  kCMMPEG2VideoProfile_XDCAM_HD_1080p25_VBR35 = 2019849783;
  kCMMPEG2VideoProfile_XDCAM_HD_1080p30_VBR35 = 2019849784;
  kCMMPEG2VideoProfile_XDCAM_HD_540p = 2019846244;
  kCMMediaType_Audio = 'soun';
  kCMMediaType_ClosedCaption = 'clcp';
  kCMMediaType_Muxed = 'muxx';
  kCMMediaType_Subtitle = 'sbtl';
  kCMMediaType_Text = 'text';
  kCMMediaType_TimeCode = 'tmcd';
  kCMMediaType_TimedMetadata = 'tmet';
  kCMMediaType_Video = 'vide';
  kCMMuxedStreamType_DV = 'dv  ';
  kCMMuxedStreamType_MPEG1System = 'mp1s';
  kCMMuxedStreamType_MPEG2Program = 'mp2p';
  kCMMuxedStreamType_MPEG2Transport = 'mp2t';
  kCMPersistentTrackID_Invalid = 0;
  kCMPixelFormat_16BE555 = 16;
  kCMPixelFormat_16BE565 = 1110783541;
  kCMPixelFormat_16LE555 = 1278555445;
  kCMPixelFormat_16LE5551 = 892679473;
  kCMPixelFormat_16LE565 = 1278555701;
  kCMPixelFormat_24RGB = 24;
  kCMPixelFormat_32ARGB = 32;
  kCMPixelFormat_32BGRA = 1111970369;
  kCMPixelFormat_422YpCbCr10 = 1983000880;
  kCMPixelFormat_422YpCbCr16 = 1983000886;
  kCMPixelFormat_422YpCbCr8 = 846624121;
  kCMPixelFormat_422YpCbCr8_yuvs = 2037741171;
  kCMPixelFormat_4444YpCbCrA8 = 1983131704;
  kCMPixelFormat_444YpCbCr10 = 1983131952;
  kCMPixelFormat_444YpCbCr8 = 1983066168;
  kCMPixelFormat_8IndexedGray_WhiteIsZero = 40;
  kCMSampleBufferError_AllocationFailed = -12730;
  kCMSampleBufferError_AlreadyHasDataBuffer = -12732;
  kCMSampleBufferError_ArrayTooSmall = -12737;
  kCMSampleBufferError_BufferHasNoSampleSizes = -12735;
  kCMSampleBufferError_BufferHasNoSampleTimingInfo = -12736;
  kCMSampleBufferError_BufferNotReady = -12733;
  kCMSampleBufferError_CannotSubdivide = -12739;
  kCMSampleBufferError_InvalidEntryCount = -12738;
  kCMSampleBufferError_InvalidMediaFormat = -12743;
  kCMSampleBufferError_InvalidMediaTypeForOperation = -12741;
  kCMSampleBufferError_InvalidSampleData = -12742;
  kCMSampleBufferError_Invalidated = -12744;
  kCMSampleBufferError_RequiredParameterMissing = -12731;
  kCMSampleBufferError_SampleIndexOutOfRange = -12734;
  kCMSampleBufferError_SampleTimingInfoInvalid = -12740;
  kCMSampleBufferFlag_AudioBufferList_Assure16ByteAlignment = 1;
  kCMSimpleQueueError_AllocationFailed = -12770;
  kCMSimpleQueueError_ParameterOutOfRange = -12772;
  kCMSimpleQueueError_QueueIsFull = -12773;
  kCMSimpleQueueError_RequiredParameterMissing = -12771;
  kCMTextDisplayFlag_allSubtitlesForced = 2147483648;
  kCMTextDisplayFlag_continuousKaraoke = 2048;
  kCMTextDisplayFlag_fillTextRegion = 262144;
  kCMTextDisplayFlag_forcedSubtitlesPresent = 1073741824;
  kCMTextDisplayFlag_scrollDirectionMask = 384;
  kCMTextDisplayFlag_scrollDirection_bottomToTop = 0;
  kCMTextDisplayFlag_scrollDirection_leftToRight = 384;
  kCMTextDisplayFlag_scrollDirection_rightToLeft = 128;
  kCMTextDisplayFlag_scrollDirection_topToBottom = 256;
  kCMTextDisplayFlag_scrollIn = 32;
  kCMTextDisplayFlag_scrollOut = 64;
  kCMTextDisplayFlag_writeTextVertically = 131072;
  kCMTextFormatType_3GText = 1954034535;
  kCMTextFormatType_QTText = 1952807028;
  kCMTextJustification_bottom_right = -1;
  kCMTextJustification_centered = 1;
  kCMTextJustification_left_top = 0;
  kCMTimeCodeFlag_24HourMax = 2;
  kCMTimeCodeFlag_DropFrame = 1;
  kCMTimeCodeFlag_NegTimesOK = 4;
  kCMTimeCodeFormatType_Counter32 = 'cn32';
  kCMTimeCodeFormatType_Counter64 = 'cn64';
  kCMTimeCodeFormatType_TimeCode32 = 'tmcd';
  kCMTimeCodeFormatType_TimeCode64 = 'tc64';
  kCMTimeFlags_HasBeenRounded = 2;
  kCMTimeFlags_ImpliedValueFlagsMask = 28;
  kCMTimeFlags_Indefinite = 16;
  kCMTimeFlags_NegativeInfinity = 8;
  kCMTimeFlags_PositiveInfinity = 4;
  kCMTimeFlags_Valid = 1;
  kCMTimeMaxTimescale = 2147483647;
  kCMTimeRoundingMethod_Default = 1;
  kCMTimeRoundingMethod_QuickTime = 4;
  kCMTimeRoundingMethod_RoundAwayFromZero = 3;
  kCMTimeRoundingMethod_RoundHalfAwayFromZero = 1;
  kCMTimeRoundingMethod_RoundTowardNegativeInfinity = 6;
  kCMTimeRoundingMethod_RoundTowardPositiveInfinity = 5;
  kCMTimeRoundingMethod_RoundTowardZero = 2;
  kCMTimedMetadataFormatType_Boxed = 'mebx';
  kCMTimedMetadataFormatType_ICY = 'icy ';
  kCMTimedMetadataFormatType_ID3 = 'id3 ';
  kCMVideoCodecType_422YpCbCr8 = kCMPixelFormat_422YpCbCr8;
  kCMVideoCodecType_Animation = 'rle ';
  kCMVideoCodecType_AppleProRes422 = 'apcn';
  kCMVideoCodecType_AppleProRes422HQ = 'apch';
  kCMVideoCodecType_AppleProRes422LT = 'apcs';
  kCMVideoCodecType_AppleProRes422Proxy = 'apco';
  kCMVideoCodecType_AppleProRes4444 = 'ap4h';
  kCMVideoCodecType_Cinepak = 'cvid';
  kCMVideoCodecType_DVCNTSC = 'dvc ';
  kCMVideoCodecType_DVCPAL = 'dvcp';
  kCMVideoCodecType_DVCPROHD1080i50 = 'dvh5';
  kCMVideoCodecType_DVCPROHD1080i60 = 'dvh6';
  kCMVideoCodecType_DVCPROHD1080p25 = 'dvh2';
  kCMVideoCodecType_DVCPROHD1080p30 = 'dvh3';
  kCMVideoCodecType_DVCPROHD720p50 = 'dvhq';
  kCMVideoCodecType_DVCPROHD720p60 = 'dvhp';
  kCMVideoCodecType_DVCPro50NTSC = 'dv5n';
  kCMVideoCodecType_DVCPro50PAL = 'dv5p';
  kCMVideoCodecType_DVCProPAL = 'dvpp';
  kCMVideoCodecType_H263 = 'h263';
  kCMVideoCodecType_H264 = 'avc1';
  kCMVideoCodecType_JPEG = 'jpeg';
  kCMVideoCodecType_JPEG_OpenDML = 'dmb1';
  kCMVideoCodecType_MPEG1Video = 'mp1v';
  kCMVideoCodecType_MPEG2Video = 'mp2v';
  kCMVideoCodecType_MPEG4Video = 'mp4v';
  kCMVideoCodecType_SorensonVideo = 'SVQ1';
  kCMVideoCodecType_SorensonVideo3 = 'SVQ3';

// ===== External functions =====

const
  libCoreMedia = '/System/Library/Frameworks/CoreMedia.framework/CoreMedia';

function CMAudioFormatDescriptionCreate(allocator: CFAllocatorRef; asbd: PAudioStreamBasicDescription; layoutSize: Longword; layout: PAudioChannelLayout; magicCookieSize: Longword; magicCookie: Pointer; extensions: CFDictionaryRef; outDesc: PCMAudioFormatDescriptionRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMAudioFormatDescriptionCreate';
function CMAudioFormatDescriptionCreateSummary(allocator: CFAllocatorRef; formatDescriptionArray: CFArrayRef; flags: Longword; summaryFormatDescriptionOut: PCMAudioFormatDescriptionRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMAudioFormatDescriptionCreateSummary';
function CMAudioFormatDescriptionEqual(desc1: CMAudioFormatDescriptionRef; desc2: CMAudioFormatDescriptionRef; equalityMask: CMAudioFormatDescriptionMask; equalityMaskOut: PCMAudioFormatDescriptionMask): Boolean; cdecl; external libCoreMedia name _PU + 'CMAudioFormatDescriptionEqual';
function CMAudioFormatDescriptionGetChannelLayout(desc: CMAudioFormatDescriptionRef; layoutSize: PLongword): PAudioChannelLayout; cdecl; external libCoreMedia name _PU + 'CMAudioFormatDescriptionGetChannelLayout';
function CMAudioFormatDescriptionGetFormatList(desc: CMAudioFormatDescriptionRef; formatListSize: PLongword): PAudioFormatListItem; cdecl; external libCoreMedia name _PU + 'CMAudioFormatDescriptionGetFormatList';
function CMAudioFormatDescriptionGetMagicCookie(desc: CMAudioFormatDescriptionRef; cookieSizeOut: PLongword): Pointer; cdecl; external libCoreMedia name _PU + 'CMAudioFormatDescriptionGetMagicCookie';
function CMAudioFormatDescriptionGetMostCompatibleFormat(desc: CMAudioFormatDescriptionRef): PAudioFormatListItem; cdecl; external libCoreMedia name _PU + 'CMAudioFormatDescriptionGetMostCompatibleFormat';
function CMAudioFormatDescriptionGetRichestDecodableFormat(desc: CMAudioFormatDescriptionRef): PAudioFormatListItem; cdecl; external libCoreMedia name _PU + 'CMAudioFormatDescriptionGetRichestDecodableFormat';
function CMAudioFormatDescriptionGetStreamBasicDescription(desc: CMAudioFormatDescriptionRef): PAudioStreamBasicDescription; cdecl; external libCoreMedia name _PU + 'CMAudioFormatDescriptionGetStreamBasicDescription';
function CMAudioSampleBufferCreateWithPacketDescriptions(allocator: CFAllocatorRef; dataBuffer: CMBlockBufferRef; dataReady: Boolean; makeDataReadyCallback: CMSampleBufferMakeDataReadyCallback; makeDataReadyRefcon: Pointer; formatDescription: CMFormatDescriptionRef; numSamples: CMItemCount; sbufPTS: CMTime; packetDescriptions: PAudioStreamPacketDescription; sBufOut: PCMSampleBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMAudioSampleBufferCreateWithPacketDescriptions';
function CMBlockBufferAccessDataBytes(theBuffer: CMBlockBufferRef; offset: Longword; length: Longword; temporaryBlock: Pointer; returnedPointer: Pchar): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBlockBufferAccessDataBytes';
function CMBlockBufferAppendBufferReference(theBuffer: CMBlockBufferRef; targetBBuf: CMBlockBufferRef; offsetToData: Longword; dataLength: Longword; flags: CMBlockBufferFlags): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBlockBufferAppendBufferReference';
function CMBlockBufferAppendMemoryBlock(theBuffer: CMBlockBufferRef; memoryBlock: Pointer; blockLength: Longword; blockAllocator: CFAllocatorRef; customBlockSource: PCMBlockBufferCustomBlockSource; offsetToData: Longword; dataLength: Longword; flags: CMBlockBufferFlags): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBlockBufferAppendMemoryBlock';
function CMBlockBufferAssureBlockMemory(theBuffer: CMBlockBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBlockBufferAssureBlockMemory';
function CMBlockBufferCopyDataBytes(theSourceBuffer: CMBlockBufferRef; offsetToData: Longword; dataLength: Longword; destination: Pointer): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBlockBufferCopyDataBytes';
function CMBlockBufferCreateContiguous(structureAllocator: CFAllocatorRef; sourceBuffer: CMBlockBufferRef; blockAllocator: CFAllocatorRef; customBlockSource: PCMBlockBufferCustomBlockSource; offsetToData: Longword; dataLength: Longword; flags: CMBlockBufferFlags; newBBufOut: PCMBlockBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBlockBufferCreateContiguous';
function CMBlockBufferCreateEmpty(structureAllocator: CFAllocatorRef; subBlockCapacity: Longword; flags: CMBlockBufferFlags; newBBufOut: PCMBlockBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBlockBufferCreateEmpty';
function CMBlockBufferCreateWithBufferReference(structureAllocator: CFAllocatorRef; targetBuffer: CMBlockBufferRef; offsetToData: Longword; dataLength: Longword; flags: CMBlockBufferFlags; newBBufOut: PCMBlockBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBlockBufferCreateWithBufferReference';
function CMBlockBufferCreateWithMemoryBlock(structureAllocator: CFAllocatorRef; memoryBlock: Pointer; blockLength: Longword; blockAllocator: CFAllocatorRef; customBlockSource: PCMBlockBufferCustomBlockSource; offsetToData: Longword; dataLength: Longword; flags: CMBlockBufferFlags; newBBufOut: PCMBlockBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBlockBufferCreateWithMemoryBlock';
function CMBlockBufferFillDataBytes(fillByte: char; destinationBuffer: CMBlockBufferRef; offsetIntoDestination: Longword; dataLength: Longword): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBlockBufferFillDataBytes';
function CMBlockBufferGetDataLength(theBuffer: CMBlockBufferRef): Longword; cdecl; external libCoreMedia name _PU + 'CMBlockBufferGetDataLength';
function CMBlockBufferGetDataPointer(theBuffer: CMBlockBufferRef; offset: Longword; lengthAtOffset: PLongword; totalLength: PLongword; dataPointer: Pchar): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBlockBufferGetDataPointer';
function CMBlockBufferGetTypeID: CFTypeID; cdecl; external libCoreMedia name _PU + 'CMBlockBufferGetTypeID';
function CMBlockBufferIsEmpty(theBuffer: CMBlockBufferRef): Boolean; cdecl; external libCoreMedia name _PU + 'CMBlockBufferIsEmpty';
function CMBlockBufferIsRangeContiguous(theBuffer: CMBlockBufferRef; offset: Longword; length: Longword): Boolean; cdecl; external libCoreMedia name _PU + 'CMBlockBufferIsRangeContiguous';
function CMBlockBufferReplaceDataBytes(sourceBytes: Pointer; destinationBuffer: CMBlockBufferRef; offsetIntoDestination: Longword; dataLength: Longword): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBlockBufferReplaceDataBytes';
function CMBufferQueueCallForEachBuffer(queue: CMBufferQueueRef; callback: TCMBufferQueueCallback; refcon: Pointer): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBufferQueueCallForEachBuffer';
function CMBufferQueueContainsEndOfData(queue: CMBufferQueueRef): Boolean; cdecl; external libCoreMedia name _PU + 'CMBufferQueueContainsEndOfData';
function CMBufferQueueCreate(allocator: CFAllocatorRef; capacity: CMItemCount; callbacks: PCMBufferCallbacks; queueOut: PCMBufferQueueRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBufferQueueCreate';
function CMBufferQueueDequeueAndRetain(queue: CMBufferQueueRef): CMBufferRef; cdecl; external libCoreMedia name _PU + 'CMBufferQueueDequeueAndRetain';
function CMBufferQueueDequeueIfDataReadyAndRetain(queue: CMBufferQueueRef): CMBufferRef; cdecl; external libCoreMedia name _PU + 'CMBufferQueueDequeueIfDataReadyAndRetain';
function CMBufferQueueEnqueue(queue: CMBufferQueueRef; buf: CMBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBufferQueueEnqueue';
function CMBufferQueueGetBufferCount(queue: CMBufferQueueRef): CMItemCount; cdecl; external libCoreMedia name _PU + 'CMBufferQueueGetBufferCount';
function CMBufferQueueGetCallbacksForSampleBuffersSortedByOutputPTS: PCMBufferCallbacks; cdecl; external libCoreMedia name _PU + 'CMBufferQueueGetCallbacksForSampleBuffersSortedByOutputPTS';
function CMBufferQueueGetCallbacksForUnsortedSampleBuffers: PCMBufferCallbacks; cdecl; external libCoreMedia name _PU + 'CMBufferQueueGetCallbacksForUnsortedSampleBuffers';
function CMBufferQueueGetDuration(queue: CMBufferQueueRef): CMTime; cdecl; external libCoreMedia name _PU + 'CMBufferQueueGetDuration';
function CMBufferQueueGetEndPresentationTimeStamp(queue: CMBufferQueueRef): CMTime; cdecl; external libCoreMedia name _PU + 'CMBufferQueueGetEndPresentationTimeStamp';
function CMBufferQueueGetFirstDecodeTimeStamp(queue: CMBufferQueueRef): CMTime; cdecl; external libCoreMedia name _PU + 'CMBufferQueueGetFirstDecodeTimeStamp';
function CMBufferQueueGetFirstPresentationTimeStamp(queue: CMBufferQueueRef): CMTime; cdecl; external libCoreMedia name _PU + 'CMBufferQueueGetFirstPresentationTimeStamp';
function CMBufferQueueGetHead(queue: CMBufferQueueRef): CMBufferRef; cdecl; external libCoreMedia name _PU + 'CMBufferQueueGetHead';
function CMBufferQueueGetMaxPresentationTimeStamp(queue: CMBufferQueueRef): CMTime; cdecl; external libCoreMedia name _PU + 'CMBufferQueueGetMaxPresentationTimeStamp';
function CMBufferQueueGetMinDecodeTimeStamp(queue: CMBufferQueueRef): CMTime; cdecl; external libCoreMedia name _PU + 'CMBufferQueueGetMinDecodeTimeStamp';
function CMBufferQueueGetMinPresentationTimeStamp(queue: CMBufferQueueRef): CMTime; cdecl; external libCoreMedia name _PU + 'CMBufferQueueGetMinPresentationTimeStamp';
function CMBufferQueueGetTypeID: CFTypeID; cdecl; external libCoreMedia name _PU + 'CMBufferQueueGetTypeID';
function CMBufferQueueInstallTrigger(queue: CMBufferQueueRef; triggerCallback: CMBufferQueueTriggerCallback; triggerRefcon: Pointer; triggerCondition: CMBufferQueueTriggerCondition; triggerTime: CMTime; triggerTokenOut: PCMBufferQueueTriggerToken): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBufferQueueInstallTrigger';
function CMBufferQueueInstallTriggerWithIntegerThreshold(queue: CMBufferQueueRef; triggerCallback: CMBufferQueueTriggerCallback; triggerRefcon: Pointer; triggerCondition: CMBufferQueueTriggerCondition; triggerThreshold: CMItemCount; triggerTokenOut: PCMBufferQueueTriggerToken): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBufferQueueInstallTriggerWithIntegerThreshold';
function CMBufferQueueIsAtEndOfData(queue: CMBufferQueueRef): Boolean; cdecl; external libCoreMedia name _PU + 'CMBufferQueueIsAtEndOfData';
function CMBufferQueueIsEmpty(queue: CMBufferQueueRef): Boolean; cdecl; external libCoreMedia name _PU + 'CMBufferQueueIsEmpty';
function CMBufferQueueMarkEndOfData(queue: CMBufferQueueRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBufferQueueMarkEndOfData';
function CMBufferQueueRemoveTrigger(queue: CMBufferQueueRef; triggerToken: CMBufferQueueTriggerToken): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBufferQueueRemoveTrigger';
function CMBufferQueueReset(queue: CMBufferQueueRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBufferQueueReset';
function CMBufferQueueResetWithCallback(queue: CMBufferQueueRef; callback: TCMBufferQueueResetCallback; refcon: Pointer): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBufferQueueResetWithCallback';
function CMBufferQueueSetValidationCallback(queue: CMBufferQueueRef; validationCallback: CMBufferValidationCallback; validationRefCon: Pointer): OSStatus; cdecl; external libCoreMedia name _PU + 'CMBufferQueueSetValidationCallback';
function CMBufferQueueTestTrigger(queue: CMBufferQueueRef; triggerToken: CMBufferQueueTriggerToken): Boolean; cdecl; external libCoreMedia name _PU + 'CMBufferQueueTestTrigger';
function CMCopyDictionaryOfAttachments(allocator: CFAllocatorRef; target: CMAttachmentBearerRef; attachmentMode: CMAttachmentMode): CFDictionaryRef; cdecl; external libCoreMedia name _PU + 'CMCopyDictionaryOfAttachments';
function CMFormatDescriptionCreate(allocator: CFAllocatorRef; mediaType: CMMediaType; mediaSubtype: FourCharCode; extensions: CFDictionaryRef; descOut: PCMFormatDescriptionRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMFormatDescriptionCreate';
function CMFormatDescriptionEqual(desc1: CMFormatDescriptionRef; desc2: CMFormatDescriptionRef): Boolean; cdecl; external libCoreMedia name _PU + 'CMFormatDescriptionEqual';
function CMFormatDescriptionEqualIgnoringExtensionKeys(desc1: CMFormatDescriptionRef; desc2: CMFormatDescriptionRef; formatDescriptionExtensionKeysToIgnore: CFTypeRef; sampleDescriptionExtensionAtomKeysToIgnore: CFTypeRef): Boolean; cdecl; external libCoreMedia name _PU + 'CMFormatDescriptionEqualIgnoringExtensionKeys';
function CMFormatDescriptionGetExtension(desc: CMFormatDescriptionRef; extensionKey: CFStringRef): CFPropertyListRef; cdecl; external libCoreMedia name _PU + 'CMFormatDescriptionGetExtension';
function CMFormatDescriptionGetExtensions(desc: CMFormatDescriptionRef): CFDictionaryRef; cdecl; external libCoreMedia name _PU + 'CMFormatDescriptionGetExtensions';
function CMFormatDescriptionGetMediaSubType(desc: CMFormatDescriptionRef): FourCharCode; cdecl; external libCoreMedia name _PU + 'CMFormatDescriptionGetMediaSubType';
function CMFormatDescriptionGetMediaType(desc: CMFormatDescriptionRef): CMMediaType; cdecl; external libCoreMedia name _PU + 'CMFormatDescriptionGetMediaType';
function CMFormatDescriptionGetTypeID: CFTypeID; cdecl; external libCoreMedia name _PU + 'CMFormatDescriptionGetTypeID';
function CMGetAttachment(target: CMAttachmentBearerRef; key: CFStringRef; attachmentModeOut: PCMAttachmentMode): CFTypeRef; cdecl; external libCoreMedia name _PU + 'CMGetAttachment';
function CMMetadataFormatDescriptionCreateWithKeys(allocator: CFAllocatorRef; metadataType: CMMetadataFormatType; keys: CFArrayRef; outDesc: PCMMetadataFormatDescriptionRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMMetadataFormatDescriptionCreateWithKeys';
function CMMetadataFormatDescriptionGetKeyWithLocalID(desc: CMMetadataFormatDescriptionRef; localKeyID: OSType): CFDictionaryRef; cdecl; external libCoreMedia name _PU + 'CMMetadataFormatDescriptionGetKeyWithLocalID';
function CMMuxedFormatDescriptionCreate(allocator: CFAllocatorRef; muxType: CMMuxedStreamType; extensions: CFDictionaryRef; outDesc: PCMMuxedFormatDescriptionRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMMuxedFormatDescriptionCreate';
procedure CMPropagateAttachments(source: CMAttachmentBearerRef; destination: CMAttachmentBearerRef); cdecl; external libCoreMedia name _PU + 'CMPropagateAttachments';
procedure CMRemoveAllAttachments(target: CMAttachmentBearerRef); cdecl; external libCoreMedia name _PU + 'CMRemoveAllAttachments';
procedure CMRemoveAttachment(target: CMAttachmentBearerRef; key: CFStringRef); cdecl; external libCoreMedia name _PU + 'CMRemoveAttachment';
function CMSampleBufferCallForEachSample(sbuf: CMSampleBufferRef; callback: TCMSampleBufferCallback; refcon: Pointer): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferCallForEachSample';
function CMSampleBufferCopySampleBufferForRange(allocator: CFAllocatorRef; sbuf: CMSampleBufferRef; sampleRange: CFRange; sBufOut: PCMSampleBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferCopySampleBufferForRange';
function CMSampleBufferCreate(allocator: CFAllocatorRef; dataBuffer: CMBlockBufferRef; dataReady: Boolean; makeDataReadyCallback: CMSampleBufferMakeDataReadyCallback; makeDataReadyRefcon: Pointer; formatDescription: CMFormatDescriptionRef; numSamples: CMItemCount; numSampleTimingEntries: CMItemCount; sampleTimingArray: PCMSampleTimingInfo; numSampleSizeEntries: CMItemCount; sampleSizeArray: PLongword; sBufOut: PCMSampleBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferCreate';
function CMSampleBufferCreateCopy(allocator: CFAllocatorRef; sbuf: CMSampleBufferRef; sbufCopyOut: PCMSampleBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferCreateCopy';
function CMSampleBufferCreateCopyWithNewTiming(allocator: CFAllocatorRef; originalSBuf: CMSampleBufferRef; numSampleTimingEntries: CMItemCount; sampleTimingArray: PCMSampleTimingInfo; sBufCopyOut: PCMSampleBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferCreateCopyWithNewTiming';
function CMSampleBufferCreateForImageBuffer(allocator: CFAllocatorRef; imageBuffer: CVImageBufferRef; dataReady: Boolean; makeDataReadyCallback: CMSampleBufferMakeDataReadyCallback; makeDataReadyRefcon: Pointer; formatDescription: CMVideoFormatDescriptionRef; sampleTiming: PCMSampleTimingInfo; sBufOut: PCMSampleBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferCreateForImageBuffer';
function CMSampleBufferDataIsReady(sbuf: CMSampleBufferRef): Boolean; cdecl; external libCoreMedia name _PU + 'CMSampleBufferDataIsReady';
function CMSampleBufferGetAudioBufferListWithRetainedBlockBuffer(sbuf: CMSampleBufferRef; bufferListSizeNeededOut: PLongword; bufferListOut: PAudioBufferList; bufferListSize: Longword; bbufStructAllocator: CFAllocatorRef; bbufMemoryAllocator: CFAllocatorRef; flags: Longword; blockBufferOut: PCMBlockBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetAudioBufferListWithRetainedBlockBuffer';
function CMSampleBufferGetAudioStreamPacketDescriptions(sbuf: CMSampleBufferRef; packetDescriptionsSize: Longword; packetDescriptionsOut: PAudioStreamPacketDescription; packetDescriptionsSizeNeededOut: PLongword): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetAudioStreamPacketDescriptions';
function CMSampleBufferGetAudioStreamPacketDescriptionsPtr(sbuf: CMSampleBufferRef; packetDescriptionsPtrOut: PAudioStreamPacketDescription; packetDescriptionsSizeOut: PLongword): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetAudioStreamPacketDescriptionsPtr';
function CMSampleBufferGetDataBuffer(sbuf: CMSampleBufferRef): CMBlockBufferRef; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetDataBuffer';
function CMSampleBufferGetDecodeTimeStamp(sbuf: CMSampleBufferRef): CMTime; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetDecodeTimeStamp';
function CMSampleBufferGetDuration(sbuf: CMSampleBufferRef): CMTime; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetDuration';
function CMSampleBufferGetFormatDescription(sbuf: CMSampleBufferRef): CMFormatDescriptionRef; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetFormatDescription';
function CMSampleBufferGetImageBuffer(sbuf: CMSampleBufferRef): CVImageBufferRef; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetImageBuffer';
function CMSampleBufferGetNumSamples(sbuf: CMSampleBufferRef): CMItemCount; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetNumSamples';
function CMSampleBufferGetOutputDecodeTimeStamp(sbuf: CMSampleBufferRef): CMTime; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetOutputDecodeTimeStamp';
function CMSampleBufferGetOutputDuration(sbuf: CMSampleBufferRef): CMTime; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetOutputDuration';
function CMSampleBufferGetOutputPresentationTimeStamp(sbuf: CMSampleBufferRef): CMTime; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetOutputPresentationTimeStamp';
function CMSampleBufferGetOutputSampleTimingInfoArray(sbuf: CMSampleBufferRef; timingArrayEntries: CMItemCount; timingArrayOut: PCMSampleTimingInfo; timingArrayEntriesNeededOut: PCMItemCount): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetOutputSampleTimingInfoArray';
function CMSampleBufferGetPresentationTimeStamp(sbuf: CMSampleBufferRef): CMTime; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetPresentationTimeStamp';
function CMSampleBufferGetSampleAttachmentsArray(sbuf: CMSampleBufferRef; createIfNecessary: Boolean): CFArrayRef; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetSampleAttachmentsArray';
function CMSampleBufferGetSampleSize(sbuf: CMSampleBufferRef; sampleIndex: CMItemIndex): Longword; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetSampleSize';
function CMSampleBufferGetSampleSizeArray(sbuf: CMSampleBufferRef; sizeArrayEntries: CMItemCount; sizeArrayOut: PLongword; sizeArrayEntriesNeededOut: PCMItemCount): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetSampleSizeArray';
function CMSampleBufferGetSampleTimingInfo(sbuf: CMSampleBufferRef; sampleIndex: CMItemIndex; timingInfoOut: PCMSampleTimingInfo): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetSampleTimingInfo';
function CMSampleBufferGetSampleTimingInfoArray(sbuf: CMSampleBufferRef; timingArrayEntries: CMItemCount; timingArrayOut: PCMSampleTimingInfo; timingArrayEntriesNeededOut: PCMItemCount): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetSampleTimingInfoArray';
function CMSampleBufferGetTotalSampleSize(sbuf: CMSampleBufferRef): Longword; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetTotalSampleSize';
function CMSampleBufferGetTypeID: CFTypeID; cdecl; external libCoreMedia name _PU + 'CMSampleBufferGetTypeID';
function CMSampleBufferInvalidate(sbuf: CMSampleBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferInvalidate';
function CMSampleBufferIsValid(sbuf: CMSampleBufferRef): Boolean; cdecl; external libCoreMedia name _PU + 'CMSampleBufferIsValid';
function CMSampleBufferMakeDataReady(sbuf: CMSampleBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferMakeDataReady';
function CMSampleBufferSetDataBuffer(sbuf: CMSampleBufferRef; dataBuffer: CMBlockBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferSetDataBuffer';
function CMSampleBufferSetDataBufferFromAudioBufferList(sbuf: CMSampleBufferRef; bbufStructAllocator: CFAllocatorRef; bbufMemoryAllocator: CFAllocatorRef; flags: Longword; bufferList: PAudioBufferList): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferSetDataBufferFromAudioBufferList';
function CMSampleBufferSetDataReady(sbuf: CMSampleBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferSetDataReady';
function CMSampleBufferSetInvalidateCallback(sbuf: CMSampleBufferRef; invalidateCallback: CMSampleBufferInvalidateCallback; invalidateRefCon: UInt64): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferSetInvalidateCallback';
function CMSampleBufferSetOutputPresentationTimeStamp(sbuf: CMSampleBufferRef; outputPresentationTimeStamp: CMTime): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferSetOutputPresentationTimeStamp';
function CMSampleBufferTrackDataReadiness(sbuf: CMSampleBufferRef; sbufToTrack: CMSampleBufferRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSampleBufferTrackDataReadiness';
procedure CMSetAttachment(target: CMAttachmentBearerRef; key: CFStringRef; value: CFTypeRef; attachmentMode: CMAttachmentMode); cdecl; external libCoreMedia name _PU + 'CMSetAttachment';
procedure CMSetAttachments(target: CMAttachmentBearerRef; theAttachments: CFDictionaryRef; attachmentMode: CMAttachmentMode); cdecl; external libCoreMedia name _PU + 'CMSetAttachments';
function CMSimpleQueueCreate(allocator: CFAllocatorRef; capacity: Integer; queueOut: PCMSimpleQueueRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSimpleQueueCreate';
function CMSimpleQueueDequeue(queue: CMSimpleQueueRef): Pointer; cdecl; external libCoreMedia name _PU + 'CMSimpleQueueDequeue';
function CMSimpleQueueEnqueue(queue: CMSimpleQueueRef; element: Pointer): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSimpleQueueEnqueue';
function CMSimpleQueueGetCapacity(queue: CMSimpleQueueRef): Integer; cdecl; external libCoreMedia name _PU + 'CMSimpleQueueGetCapacity';
function CMSimpleQueueGetCount(queue: CMSimpleQueueRef): Integer; cdecl; external libCoreMedia name _PU + 'CMSimpleQueueGetCount';
function CMSimpleQueueGetHead(queue: CMSimpleQueueRef): Pointer; cdecl; external libCoreMedia name _PU + 'CMSimpleQueueGetHead';
function CMSimpleQueueGetTypeID: CFTypeID; cdecl; external libCoreMedia name _PU + 'CMSimpleQueueGetTypeID';
function CMSimpleQueueReset(queue: CMSimpleQueueRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMSimpleQueueReset';
function CMTextFormatDescriptionGetDefaultStyle(desc: CMFormatDescriptionRef; outLocalFontID: PWord; outBold: PBoolean; outItalic: PBoolean; outUnderline: PBoolean; outFontSize: PSingle; outColorComponents: PSingle): OSStatus; cdecl; external libCoreMedia name _PU + 'CMTextFormatDescriptionGetDefaultStyle';
function CMTextFormatDescriptionGetDefaultTextBox(desc: CMFormatDescriptionRef; originIsAtTopLeft: Boolean; heightOfTextTrack: Single; outDefaultTextBox: PCGRect): OSStatus; cdecl; external libCoreMedia name _PU + 'CMTextFormatDescriptionGetDefaultTextBox';
function CMTextFormatDescriptionGetDisplayFlags(desc: CMFormatDescriptionRef; outDisplayFlags: PCMTextDisplayFlags): OSStatus; cdecl; external libCoreMedia name _PU + 'CMTextFormatDescriptionGetDisplayFlags';
function CMTextFormatDescriptionGetFontName(desc: CMFormatDescriptionRef; localFontID: Word; outFontName: PCFStringRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMTextFormatDescriptionGetFontName';
function CMTextFormatDescriptionGetJustification(desc: CMFormatDescriptionRef; outHorizontalJust: PCMTextJustificationValue; outVerticalJust: PCMTextJustificationValue): OSStatus; cdecl; external libCoreMedia name _PU + 'CMTextFormatDescriptionGetJustification';
function CMTimeAbsoluteValue(time: CMTime): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeAbsoluteValue';
function CMTimeAdd(addend1: CMTime; addend2: CMTime): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeAdd';
function CMTimeClampToRange(time: CMTime; range: CMTimeRange): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeClampToRange';
function CMTimeCodeFormatDescriptionCreate(allocator: CFAllocatorRef; timeCodeFormatType: CMTimeCodeFormatType; frameDuration: CMTime; frameQuanta: Longword; tcFlags: Longword; extensions: CFDictionaryRef; descOut: PCMTimeCodeFormatDescriptionRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMTimeCodeFormatDescriptionCreate';
function CMTimeCodeFormatDescriptionGetFrameDuration(timeCodeFormatDescription: CMTimeCodeFormatDescriptionRef): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeCodeFormatDescriptionGetFrameDuration';
function CMTimeCodeFormatDescriptionGetFrameQuanta(timeCodeFormatDescription: CMTimeCodeFormatDescriptionRef): Longword; cdecl; external libCoreMedia name _PU + 'CMTimeCodeFormatDescriptionGetFrameQuanta';
function CMTimeCodeFormatDescriptionGetTimeCodeFlags(desc: CMTimeCodeFormatDescriptionRef): Longword; cdecl; external libCoreMedia name _PU + 'CMTimeCodeFormatDescriptionGetTimeCodeFlags';
function CMTimeCompare(time1: CMTime; time2: CMTime): Integer; cdecl; external libCoreMedia name _PU + 'CMTimeCompare';
function CMTimeConvertScale(time: CMTime; newTimescale: Integer; method: CMTimeRoundingMethod): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeConvertScale';
function CMTimeCopyAsDictionary(time: CMTime; allocator: CFAllocatorRef): CFDictionaryRef; cdecl; external libCoreMedia name _PU + 'CMTimeCopyAsDictionary';
function CMTimeCopyDescription(allocator: CFAllocatorRef; time: CMTime): CFStringRef; cdecl; external libCoreMedia name _PU + 'CMTimeCopyDescription';
function CMTimeGetSeconds(time: CMTime): Float64; cdecl; external libCoreMedia name _PU + 'CMTimeGetSeconds';
function CMTimeMake(value: Int64; timescale: Integer): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeMake';
function CMTimeMakeFromDictionary(dict: CFDictionaryRef): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeMakeFromDictionary';
function CMTimeMakeWithEpoch(value: Int64; timescale: Integer; epoch: Int64): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeMakeWithEpoch';
function CMTimeMakeWithSeconds(seconds: Float64; preferredTimeScale: Integer): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeMakeWithSeconds';
function CMTimeMapDurationFromRangeToRange(dur: CMTime; fromRange: CMTimeRange; toRange: CMTimeRange): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeMapDurationFromRangeToRange';
function CMTimeMapTimeFromRangeToRange(t: CMTime; fromRange: CMTimeRange; toRange: CMTimeRange): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeMapTimeFromRangeToRange';
function CMTimeMaximum(time1: CMTime; time2: CMTime): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeMaximum';
function CMTimeMinimum(time1: CMTime; time2: CMTime): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeMinimum';
function CMTimeMultiply(time: CMTime; multiplier: Integer): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeMultiply';
function CMTimeMultiplyByFloat64(time: CMTime; multiplier: Float64): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeMultiplyByFloat64';
function CMTimeRangeContainsTime(range: CMTimeRange; time: CMTime): Boolean; cdecl; external libCoreMedia name _PU + 'CMTimeRangeContainsTime';
function CMTimeRangeContainsTimeRange(range1: CMTimeRange; range2: CMTimeRange): Boolean; cdecl; external libCoreMedia name _PU + 'CMTimeRangeContainsTimeRange';
function CMTimeRangeCopyAsDictionary(range: CMTimeRange; allocator: CFAllocatorRef): CFDictionaryRef; cdecl; external libCoreMedia name _PU + 'CMTimeRangeCopyAsDictionary';
function CMTimeRangeCopyDescription(allocator: CFAllocatorRef; range: CMTimeRange): CFStringRef; cdecl; external libCoreMedia name _PU + 'CMTimeRangeCopyDescription';
function CMTimeRangeEqual(range1: CMTimeRange; range2: CMTimeRange): Boolean; cdecl; external libCoreMedia name _PU + 'CMTimeRangeEqual';
function CMTimeRangeFromTimeToTime(start: CMTime; end_: CMTime): CMTimeRange; cdecl; external libCoreMedia name _PU + 'CMTimeRangeFromTimeToTime';
function CMTimeRangeGetEnd(range: CMTimeRange): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeRangeGetEnd';
function CMTimeRangeGetIntersection(range1: CMTimeRange; range2: CMTimeRange): CMTimeRange; cdecl; external libCoreMedia name _PU + 'CMTimeRangeGetIntersection';
function CMTimeRangeGetUnion(range1: CMTimeRange; range2: CMTimeRange): CMTimeRange; cdecl; external libCoreMedia name _PU + 'CMTimeRangeGetUnion';
function CMTimeRangeMake(start: CMTime; duration: CMTime): CMTimeRange; cdecl; external libCoreMedia name _PU + 'CMTimeRangeMake';
function CMTimeRangeMakeFromDictionary(dict: CFDictionaryRef): CMTimeRange; cdecl; external libCoreMedia name _PU + 'CMTimeRangeMakeFromDictionary';
procedure CMTimeRangeShow(range: CMTimeRange); cdecl; external libCoreMedia name _PU + 'CMTimeRangeShow';
procedure CMTimeShow(time: CMTime); cdecl; external libCoreMedia name _PU + 'CMTimeShow';
function CMTimeSubtract(minuend: CMTime; subtrahend: CMTime): CMTime; cdecl; external libCoreMedia name _PU + 'CMTimeSubtract';
function CMVideoFormatDescriptionCreate(allocator: CFAllocatorRef; codecType: CMVideoCodecType; width: Integer; height: Integer; extensions: CFDictionaryRef; outDesc: PCMVideoFormatDescriptionRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMVideoFormatDescriptionCreate';
function CMVideoFormatDescriptionCreateForImageBuffer(allocator: CFAllocatorRef; imageBuffer: CVImageBufferRef; outDesc: PCMVideoFormatDescriptionRef): OSStatus; cdecl; external libCoreMedia name _PU + 'CMVideoFormatDescriptionCreateForImageBuffer';
function CMVideoFormatDescriptionGetCleanAperture(videoDesc: CMVideoFormatDescriptionRef; originIsAtTopLeft: Boolean): CGRect; cdecl; external libCoreMedia name _PU + 'CMVideoFormatDescriptionGetCleanAperture';
function CMVideoFormatDescriptionGetDimensions(videoDesc: CMVideoFormatDescriptionRef): CMVideoDimensions; cdecl; external libCoreMedia name _PU + 'CMVideoFormatDescriptionGetDimensions';
function CMVideoFormatDescriptionGetExtensionKeysCommonWithImageBuffers: CFArrayRef; cdecl; external libCoreMedia name _PU + 'CMVideoFormatDescriptionGetExtensionKeysCommonWithImageBuffers';
function CMVideoFormatDescriptionGetPresentationDimensions(videoDesc: CMVideoFormatDescriptionRef; usePixelAspectRatio: Boolean; useCleanAperture: Boolean): CGSize; cdecl; external libCoreMedia name _PU + 'CMVideoFormatDescriptionGetPresentationDimensions';
function CMVideoFormatDescriptionMatchesImageBuffer(desc: CMVideoFormatDescriptionRef; imageBuffer: CVImageBufferRef): Boolean; cdecl; external libCoreMedia name _PU + 'CMVideoFormatDescriptionMatchesImageBuffer';

function kCMTimeZero: CMTime;
function kCMTimeIndefinite: CMTime;
function kCMTimePositiveInfinity: CMTime;
function kCMTimeNegativeInfinity: CMTime;

implementation

uses System.SysUtils;

function kCMTimeZero: CMTime;
begin
  Result := PCMTime(CocoaPointerConst(libCoreMedia, 'kCMTimeZero'))^;
end;
  
function kCMTimeIndefinite: CMTime;
begin
  Result := PCMTime(CocoaPointerConst(libCoreMedia, 'kCMTimeIndefinite'))^;
end;
  
function kCMTimePositiveInfinity: CMTime;
begin
  Result := PCMTime(CocoaPointerConst(libCoreMedia, 'kCMTimePositiveInfinity'))^;
end;
  
function kCMTimeNegativeInfinity: CMTime;
begin
  Result := PCMTime(CocoaPointerConst(libCoreMedia, 'kCMTimeNegativeInfinity'))^;
end;

end.
