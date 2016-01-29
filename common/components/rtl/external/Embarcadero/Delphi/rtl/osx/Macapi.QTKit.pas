{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework QTKit
//

unit Macapi.QTKit;

interface

uses
  Macapi.ObjCRuntime,
  Macapi.ObjectiveC,
  Macapi.CocoaTypes,
//  Macapi.IOSurface,
//  Macapi.AudioToolbox,
  Macapi.CoreMedia,
  Macapi.Foundation,
  Macapi.AppKit,
//  Macapi.IOKit,
//  Macapi.CoreAudio,
  Macapi.OpenGL,
  Macapi.QuartzCore,
//  Macapi.Carbon,
//  Macapi.CoreMediaIO,
  Macapi.CoreServices,
  Macapi.CoreFoundation,
//  Macapi.ApplicationServices,
  Macapi.CoreVideo;

const
  MAC_OS_X_VERSION_10_4 = 1040;
  MAC_OS_X_VERSION_10_5 = 1050;
  MAC_OS_X_VERSION_10_6 = 1060;
  MAC_OS_X_VERSION_10_7 = 1070;
  QTCaptureDeviceAVCTransportControlsFastForwardSpeed = 13000;
  QTCaptureDeviceAVCTransportControlsFastReverseSpeed = -13000;
  QTCaptureDeviceAVCTransportControlsFastestForwardSpeed = 19000;
  QTCaptureDeviceAVCTransportControlsFastestReverseSpeed = -19000;
  QTCaptureDeviceAVCTransportControlsNormalForwardSpeed = 10000;
  QTCaptureDeviceAVCTransportControlsNormalReverseSpeed = -10000;
  QTCaptureDeviceAVCTransportControlsNotPlayingMode = 0;
  QTCaptureDeviceAVCTransportControlsPlayingMode = 1;
  QTCaptureDeviceAVCTransportControlsSlowForwardSpeed = 7000;
  QTCaptureDeviceAVCTransportControlsSlowReverseSpeed = -7000;
  QTCaptureDeviceAVCTransportControlsSlowestForwardSpeed = 1000;
  QTCaptureDeviceAVCTransportControlsSlowestReverseSpeed = -1000;
  QTCaptureDeviceAVCTransportControlsStoppedSpeed = 0;
  QTCaptureDeviceAVCTransportControlsVeryFastForwardSpeed = 16000;
  QTCaptureDeviceAVCTransportControlsVeryFastReverseSpeed = -16000;
  QTCaptureDeviceAVCTransportControlsVerySlowForwardSpeed = 4000;
  QTCaptureDeviceAVCTransportControlsVerySlowReverseSpeed = -4000;
  QTCaptureFileOutputBufferDestinationNewFile = 1;
  QTCaptureFileOutputBufferDestinationOldFile = 2;
  QTErrorDeviceAlreadyUsedbyAnotherSession = 1101;
  QTErrorDeviceExcludedByAnotherDevice = 1302;
  QTErrorDeviceInUseByAnotherApplication = 1301;
  QTErrorDeviceNotConnected = 1300;
  QTErrorDeviceWasDisconnected = 1203;
  QTErrorDiskFull = 1202;
  QTErrorExportExecutionFailed = 1503;
  QTErrorExportIOError = 1506;
  QTErrorExportInsufficientSpaceOnDevice = 1504;
  QTErrorExportNoSuchDirectoryOrFile = 1505;
  QTErrorIncompatibleInput = 1002;
  QTErrorIncompatibleOutput = 1003;
  QTErrorInvalidDestinationFileTypeForExport = 1501;
  QTErrorInvalidInputsOrOutputs = 1100;
  QTErrorInvalidSourceFileTypeForExport = 1502;
  QTErrorMaximumDurationReached = 1205;
  QTErrorMaximumFileSizeReached = 1206;
  QTErrorMaximumNumberOfSamplesForFileFormatReached = 1208;
  QTErrorMediaChanged = 1204;
  QTErrorMediaDiscontinuity = 1207;
  QTErrorNoDataCaptured = 1200;
  QTErrorSessionConfigurationChanged = 1201;
  QTErrorUnknown = -1;
  QTIncludeAggressiveTypes = 4;
  QTIncludeAllTypes = 65535;
  QTIncludeCommonTypes = 0;
  QTIncludeDynamicTypes = 8;
  QTIncludeStillImageTypes = 1;
  QTIncludeTranslatableTypes = 2;
  QTKIT_VERSION_7_0 = 70000;
  QTKIT_VERSION_7_2 = 70200;
  QTKIT_VERSION_7_6_3 = 70603;
  QTKIT_VERSION_7_6_6 = 70606;
  QTKIT_VERSION_7_7 = 70700;
  QTKIT_VERSION_MAX_ALLOWED = 70700;
  QTKIT_VERSION_MIN_REQUIRED = 70700;
  QTMovieLoadStateComplete = 100000;
  QTMovieLoadStateError = -1;
  QTMovieLoadStateLoaded = 2000;
  QTMovieLoadStateLoading = 1000;
  QTMovieLoadStatePlayable = 10000;
  QTMovieLoadStatePlaythroughOK = 20000;
  QTMovieOperationBeginPhase = 0;
  QTMovieOperationEndPhase = 2;
  QTMovieOperationUpdatePercentPhase = 1;
  QTSampleBufferAudioBufferListOptionAssure16ByteAlignment = 1;
  codecHighQuality = $00000300;
  codecLosslessQuality = $00000400;
  codecLowQuality = $00000100;
  codecMaxQuality = $000003FF;
  codecMinQuality = $00000000;
  codecNormalQuality = $00000200;
  graphicsModeComposition = 259;
  graphicsModePerComponentAlpha = 272;
  graphicsModePreBlackAlpha = 258;
  graphicsModePreMulColorAlpha = 261;
  graphicsModePreWhiteAlpha = 257;
  graphicsModeStraightAlpha = 256;
  graphicsModeStraightAlphaBlend = 260;
  kQTFileType3DMF = '3DMF';
  kQTFileType3GP2 = '3gp2';
  kQTFileType3GPP = '3gpp';
  kQTFileTypeAIFC = 'AIFC';
  kQTFileTypeAIFF = 'AIFF';
  kQTFileTypeAMC = 'amc ';
  kQTFileTypeAMR = 'amr ';
  kQTFileTypeAVI = 'VfW ';
  kQTFileTypeAudioCDTrack = 'trak';
  kQTFileTypeBMP = 'BMPf';
  kQTFileTypeDVC = 'dvc!';
  kQTFileTypeFLC = 'FLC ';
  kQTFileTypeFlash = 'SWFL';
  kQTFileTypeFlashPix = 'FPix';
  kQTFileTypeGIF = 'GIFf';
  kQTFileTypeJFIF = 'JPEG';
  kQTFileTypeJPEG = 'JPEG';
  kQTFileTypeJPEG2000 = 'jp2 ';
  kQTFileTypeMIDI = 'Midi';
  kQTFileTypeMP4 = 'mpg4';
  kQTFileTypeMacPaint = 'PNTG';
  kQTFileTypeMovie = 'MooV';
  kQTFileTypeMuLaw = 'ULAW';
  kQTFileTypePDF = 'PDF ';
  kQTFileTypePICS = 'PICS';
  kQTFileTypePNG = 'PNGf';
  kQTFileTypePhotoShop = '8BPS';
  kQTFileTypePicture = 'PICT';
  kQTFileTypeQuickDrawGXPicture = 'qdgx';
  kQTFileTypeQuickTimeImage = 'qtif';
  kQTFileTypeSDV = 'sdv ';
  kQTFileTypeSGIImage = '.SGI';
  kQTFileTypeSoundDesignerII = 'Sd2f';
  kQTFileTypeSystemSevenSound = 'sfil';
  kQTFileTypeTIFF = 'TIFF';
  kQTFileTypeTargaImage = 'TPIC';
  kQTFileTypeText = 'TEXT';
  kQTFileTypeWave = 'WAVE';
  kQTTimeIsIndefinite = 1;

type
  QTTime = record
    timeValue: Int64;
    timeScale: Longint;
    flags: Longint;
  end;
  PQTTime = ^QTTime;

  QTTimeRange = record
    time: QTTime;
    duration: QTTime;
  end;
  PQTTimeRange = ^QTTimeRange;

  TimeRecord = record
    value: CompTimeValue;
    scale: TimeScale;
    base: TimeBase;
  end;
  PTimeRecord = ^TimeRecord;

  Media = Pointer;
  Movie = Pointer;
  MovieController = Pointer;
  // For some NSString variable, cast it to ILocalObject and call GetObjectID
  // to get the orrect PNSString pointer for passing to the QTKit functions.
  PNSString = Pointer;
  QTCaptureFileOutputBufferDestination = NSUInteger;
  QTMovieFileTypeOptions = NSUInteger;
  QTSampleBufferAudioBufferListOptions = NSUInteger;
  QTVisualContextRef = Pointer;
  Track = Pointer;


// ===== External functions =====

const
  libQTKit = '/System/Library/Frameworks/QTKit.framework/QTKit';

function QTEqualTimeRanges(range: QTTimeRange; range2: QTTimeRange): Boolean; cdecl; external libQTKit name _PU + 'QTEqualTimeRanges';
function QTGetTimeInterval(time: QTTime; timeInterval: PNSTimeInterval): Boolean; cdecl; external libQTKit name _PU + 'QTGetTimeInterval';
function QTGetTimeRecord(time: QTTime; timeRecord: PTimeRecord): Boolean; cdecl; external libQTKit name _PU + 'QTGetTimeRecord';
function QTIntersectionTimeRange(range1: QTTimeRange; range2: QTTimeRange): QTTimeRange; cdecl; external libQTKit name _PU + 'QTIntersectionTimeRange';
function QTMakeTime(timeValue: Int64; timeScale: Longint): QTTime; cdecl; external libQTKit name _PU + 'QTMakeTime';
function QTMakeTimeRange(time: QTTime; duration: QTTime): QTTimeRange; cdecl; external libQTKit name _PU + 'QTMakeTimeRange';
function QTMakeTimeScaled(time: QTTime; timeScale: Longint): QTTime; cdecl; external libQTKit name _PU + 'QTMakeTimeScaled';
function QTMakeTimeWithTimeInterval(timeInterval: NSTimeInterval): QTTime; cdecl; external libQTKit name _PU + 'QTMakeTimeWithTimeInterval';
function QTMakeTimeWithTimeRecord(timeRecord: TimeRecord): QTTime; cdecl; external libQTKit name _PU + 'QTMakeTimeWithTimeRecord';
function QTOSTypeForString(string_: PNSString): OSType; cdecl; external libQTKit name _PU + 'QTOSTypeForString';
function QTStringForOSType(type_: OSType): PNSString; cdecl; external libQTKit name _PU + 'QTStringForOSType';
function QTStringFromSMPTETime(time: SMPTETime): PNSString; cdecl; external libQTKit name _PU + 'QTStringFromSMPTETime';
function QTStringFromTime(time: QTTime): PNSString; cdecl; external libQTKit name _PU + 'QTStringFromTime';
function QTStringFromTimeRange(range: QTTimeRange): PNSString; cdecl; external libQTKit name _PU + 'QTStringFromTimeRange';
function QTTimeCompare(time: QTTime; otherTime: QTTime): NSComparisonResult; cdecl; external libQTKit name _PU + 'QTTimeCompare';
function QTTimeDecrement(time: QTTime; decrement: QTTime): QTTime; cdecl; external libQTKit name _PU + 'QTTimeDecrement';
function QTTimeFromString(string_: PNSString): QTTime; cdecl; external libQTKit name _PU + 'QTTimeFromString';
function QTTimeInTimeRange(time: QTTime; range: QTTimeRange): Boolean; cdecl; external libQTKit name _PU + 'QTTimeInTimeRange';
function QTTimeIncrement(time: QTTime; increment: QTTime): QTTime; cdecl; external libQTKit name _PU + 'QTTimeIncrement';
function QTTimeIsIndefinite(time: QTTime): Boolean; cdecl; external libQTKit name _PU + 'QTTimeIsIndefinite';
function QTTimeRangeEnd(range: QTTimeRange): QTTime; cdecl; external libQTKit name _PU + 'QTTimeRangeEnd';
function QTTimeRangeFromString(string_: PNSString): QTTimeRange; cdecl; external libQTKit name _PU + 'QTTimeRangeFromString';
function QTUnionTimeRange(range1: QTTimeRange; range2: QTTimeRange): QTTimeRange; cdecl; external libQTKit name _PU + 'QTUnionTimeRange';

type
{$M+}
// ===== Forward declarations =====

  QTExportOptions = interface;
  QTExportSession = interface;
  QTFormatDescription = interface;
  QTCaptureView = interface;
  QTCompressionOptions = interface;
  QTDataReference = interface;
  QTMedia = interface;
  QTMovieView = interface;
  QTSampleBuffer = interface;
  QTTrack = interface;
  QTMetadataItem = interface;
  QTMovie = interface;
  QTMovieLayer = interface;
  QTCaptureSession = interface;
  QTCaptureConnection = interface;
  QTCaptureDevice = interface;
  QTCaptureInput = interface;
  QTCaptureLayer = interface;
  QTCaptureOutput = interface;
  QTCaptureFileOutput = interface;
  QTCaptureMovieFileOutput = interface;
  QTCaptureDeviceInput = interface;
  QTCaptureVideoPreviewOutput = interface;
  QTCaptureDecompressedAudioOutput = interface;
  QTCaptureDecompressedVideoOutput = interface;
  QTCaptureAudioPreviewOutput = interface;

// ===== Protocol declarations =====

  QTExportSessionDelegate = interface(IObjectiveC)
    ['{0D78A539-4EC9-44D6-B7AA-57CD1A3835B8}']
    procedure exportSession(exportSession: QTExportSession; didFailWithError: NSError); cdecl; overload;
    procedure exportSession(exportSession: QTExportSession; didReachProgress: double); cdecl; overload;
    procedure exportSessionDidSucceed(exportSession: QTExportSession); cdecl;
    procedure exportSessionWasCancelled(exportSession: QTExportSession); cdecl;
  end;

  QTCaptureDecompressedVideoOutput_Delegate = interface(IObjectiveC)
    ['{1C937D8E-B360-4E2B-ACFB-51DF7F59F595}']
    procedure captureOutput(captureOutput: QTCaptureOutput; didOutputVideoFrame: CVImageBufferRef;
      withSampleBuffer: QTSampleBuffer; fromConnection: QTCaptureConnection); cdecl;
  end;


// ===== Interface declarations =====

  QTExportOptionsClass = interface(NSObjectClass)
    ['{2BBCF757-51D9-4952-A44E-9878E8923030}']
    {class} function allExportOptionsIdentifiers: NSArray; cdecl;
    {class} function exportOptionsIdentifiersCompatibleWithMovie(movie: QTMovie): NSArray; cdecl;
    {class} function exportOptionsWithIdentifier(identifier: NSString): Pointer; cdecl;
    {class} function localizedNameForExportOptionsIdentifier(identifier: NSString): NSString; cdecl;
  end;
  QTExportOptions = interface(NSObject)
    ['{AFF7AD39-5E60-480C-A39F-8F724D6FFF64}']
    function localizedExportOptionsSummary: NSString; cdecl;
    function recommendedFileTypesForExportedFile: NSArray; cdecl;
  end;
  TQTExportOptions = class(TOCGenericImport<QTExportOptionsClass, QTExportOptions>)  end;

  QTExportSessionClass = interface(NSObjectClass)
    ['{D76AC295-3A95-4118-874B-FEFACB11301A}']
  end;
  QTExportSession = interface(NSObject)
    ['{D8AFB143-8FC7-4E63-96D1-9083EC3AAAB8}']
    procedure cancel; cdecl;
    function delegate: Pointer; cdecl;
    function exportOptions: QTExportOptions; cdecl;
    function initWithMovie(movie: QTMovie; exportOptions: QTExportOptions; outputURL: NSURL; error: NSError): Pointer; cdecl;
    function isCancelled: Boolean; cdecl;
    function isFinished: Boolean; cdecl;
    function isRunning: Boolean; cdecl;
    function localizedExportSessionOutputSummary: NSString; cdecl;
    function progress: double; cdecl;
    procedure run; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    function waitUntilFinished(error: NSError): Boolean; cdecl;
  end;
  TQTExportSession = class(TOCGenericImport<QTExportSessionClass, QTExportSession>)  end;

  QTFormatDescriptionClass = interface(NSObjectClass)
    ['{DFCB3FF6-8D02-4093-BCBE-F7FB85485E34}']
  end;
  QTFormatDescription = interface(NSObject)
    ['{D355EC17-318C-4A44-ABEC-B117763D5524}']
    function attributeForKey(key: NSString): Pointer; cdecl;
    function formatDescriptionAttributes: NSDictionary; cdecl;
    function formatType: UInt32; cdecl;
    function isEqualToFormatDescription(formatDescription: QTFormatDescription): Boolean; cdecl;
    function localizedFormatSummary: NSString; cdecl;
    function mediaType: NSString; cdecl;
    function quickTimeSampleDescription: NSData; cdecl;
  end;
  TQTFormatDescription = class(TOCGenericImport<QTFormatDescriptionClass, QTFormatDescription>)  end;

  QTCaptureViewClass = interface(NSViewClass)
    ['{6EFC1BFA-B44B-4FEE-8A77-5299E131C0F0}']
  end;
  QTCaptureView = interface(NSView)
    ['{436712BB-D32B-4162-8DB0-CC1AB34E8743}']
    function availableVideoPreviewConnections: NSArray; cdecl;
    function captureSession: QTCaptureSession; cdecl;
    function delegate: Pointer; cdecl;
    function fillColor: NSColor; cdecl;
    function preservesAspectRatio: Boolean; cdecl;
    function previewBounds: NSRect; cdecl;
    procedure setCaptureSession(captureSession: QTCaptureSession); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setFillColor(fillColor: NSColor); cdecl;
    procedure setPreservesAspectRatio(preservesAspectRatio: Boolean); cdecl;
    procedure setVideoPreviewConnection(videoPreviewConnection: QTCaptureConnection); cdecl;
    function videoPreviewConnection: QTCaptureConnection; cdecl;
  end;
  TQTCaptureView = class(TOCGenericImport<QTCaptureViewClass, QTCaptureView>)  end;

  QTCompressionOptionsClass = interface(NSObjectClass)
    ['{4EEED04E-BACD-4A04-B4A7-C8DCB86B0413}']
    {class} function compressionOptionsIdentifiersForMediaType(mediaType: NSString): NSArray; cdecl;
    {class} function compressionOptionsWithIdentifier(identifier: NSString): Pointer; cdecl;
  end;
  QTCompressionOptions = interface(NSObject)
    ['{0848F280-8966-41FB-87E0-58C8A672DCFB}']
    function isEqualToCompressionOptions(compressionOptions: QTCompressionOptions): Boolean; cdecl;
    function localizedCompressionOptionsSummary: NSString; cdecl;
    function localizedDisplayName: NSString; cdecl;
    function mediaType: NSString; cdecl;
  end;
  TQTCompressionOptions = class(TOCGenericImport<QTCompressionOptionsClass, QTCompressionOptions>)  end;

  QTDataReferenceClass = interface(NSObjectClass)
    ['{4A6908AA-0B5D-47B3-86FE-0DBEE5CAF0A8}']
    {class} function dataReferenceWithReferenceToData(data: NSData): Pointer; cdecl; overload;
    {class} function dataReferenceWithReferenceToData(data: NSData; name: NSString; MIMEType: NSString): Pointer; cdecl; overload;
    {class} function dataReferenceWithReferenceToFile(fileName: NSString): Pointer; cdecl;
    {class} function dataReferenceWithReferenceToURL(url: NSURL): Pointer; cdecl;
  end;
  QTDataReference = interface(NSObject)
    ['{73F7E9A6-2A4C-44CF-9BB5-7AF3D5123FC8}']
    function MIMEType: NSString; cdecl;
    function dataRef: Handle; cdecl;
    function dataRefData: NSData; cdecl;
    function dataRefType: NSString; cdecl;
    function initWithReferenceToData(data: NSData): Pointer; cdecl; overload;
    function initWithReferenceToData(data: NSData; name: NSString; MIMEType: NSString): Pointer; cdecl; overload;
    function initWithReferenceToFile(fileName: NSString): Pointer; cdecl;
    function initWithReferenceToURL(url: NSURL): Pointer; cdecl;
    function name: NSString; cdecl;
    function referenceData: NSData; cdecl;
    function referenceFile: NSString; cdecl;
    function referenceURL: NSURL; cdecl;
    procedure setDataRef(dataRef: Handle); cdecl;
    procedure setDataRefType(type_: NSString); cdecl;
  end;
  TQTDataReference = class(TOCGenericImport<QTDataReferenceClass, QTDataReference>)  end;

  QTMediaClass = interface(NSObjectClass)
    ['{0ECE4468-96E8-41C8-BB4C-6976CBDFC11E}']
    {class} function mediaWithQuickTimeMedia(media: Media; error: NSError): Pointer; cdecl;
  end;
  QTMedia = interface(NSObject)
    ['{117ADC05-7600-4509-A0F2-9875CA104B73}']
    function attributeForKey(attributeKey: NSString): Pointer; cdecl;
    function hasCharacteristic(characteristic: NSString): Boolean; cdecl;
    function initWithQuickTimeMedia(media: Media; error: NSError): Pointer; cdecl;
    function mediaAttributes: NSDictionary; cdecl;
    function quickTimeMedia: Media; cdecl;
    procedure setAttribute(value: Pointer; forKey: NSString); cdecl;
    procedure setMediaAttributes(attributes: NSDictionary); cdecl;
    function track: QTTrack; cdecl;
  end;
  TQTMedia = class(TOCGenericImport<QTMediaClass, QTMedia>)  end;

  QTMovieViewClass = interface(NSViewClass)
    ['{97DB9C0E-4C20-4570-A753-691400E8435A}']
  end;
  QTMovieView = interface(NSView)
    ['{76DF47F6-46E9-4F9B-97BC-AAF4B9EBA164}']
    procedure add(sender: Pointer); cdecl;
    procedure addScaled(sender: Pointer); cdecl;
    function areStepButtonsVisible: Boolean; cdecl;
    function areZoomButtonsVisible: Boolean; cdecl;
    function controllerBarHeight: Single; cdecl;
    procedure copy(sender: Pointer); cdecl;
    procedure cut(sender: Pointer); cdecl;
    function delegate: Pointer; cdecl;
    procedure delete(sender: Pointer); cdecl;
    function fillColor: NSColor; cdecl;
    procedure gotoBeginning(sender: Pointer); cdecl;
    procedure gotoEnd(sender: Pointer); cdecl;
    procedure gotoNextSelectionPoint(sender: Pointer); cdecl;
    procedure gotoPosterFrame(sender: Pointer); cdecl;
    procedure gotoPreviousSelectionPoint(sender: Pointer); cdecl;
    function isBackButtonVisible: Boolean; cdecl;
    function isControllerVisible: Boolean; cdecl;
    function isCustomButtonVisible: Boolean; cdecl;
    function isEditable: Boolean; cdecl;
    function isHotSpotButtonVisible: Boolean; cdecl;
    function isTranslateButtonVisible: Boolean; cdecl;
    function isVolumeButtonVisible: Boolean; cdecl;
    function movie: QTMovie; cdecl;
    function movieBounds: NSRect; cdecl;
    function movieControllerBounds: NSRect; cdecl;
    procedure paste(sender: Pointer); cdecl;
    procedure pause(sender: Pointer); cdecl;
    procedure play(sender: Pointer); cdecl;
    function preservesAspectRatio: Boolean; cdecl;
    procedure replace(sender: Pointer); cdecl;
    procedure selectAll(sender: Pointer); cdecl;
    procedure selectNone(sender: Pointer); cdecl;
    procedure setBackButtonVisible(state: Boolean); cdecl;
    procedure setControllerVisible(controllerVisible: Boolean); cdecl;
    procedure setCustomButtonVisible(state: Boolean); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setEditable(editable: Boolean); cdecl;
    procedure setFillColor(fillColor: NSColor); cdecl;
    procedure setHotSpotButtonVisible(state: Boolean); cdecl;
    procedure setMovie(movie: QTMovie); cdecl;
    procedure setPreservesAspectRatio(preservesAspectRatio: Boolean); cdecl;
    procedure setShowsResizeIndicator(show: Boolean); cdecl;
    procedure setStepButtonsVisible(state: Boolean); cdecl;
    procedure setTranslateButtonVisible(state: Boolean); cdecl;
    procedure setVolumeButtonVisible(state: Boolean); cdecl;
    procedure setZoomButtonsVisible(state: Boolean); cdecl;
    procedure stepBackward(sender: Pointer); cdecl;
    procedure stepForward(sender: Pointer); cdecl;
    procedure trim(sender: Pointer); cdecl;
  end;
  TQTMovieView = class(TOCGenericImport<QTMovieViewClass, QTMovieView>)  end;

  QTSampleBufferClass = interface(NSObjectClass)
    ['{A6DD58D4-2D8E-420B-A5E0-6A3CA2E9F0CA}']
  end;
  QTSampleBuffer = interface(NSObject)
    ['{CD2650E3-536E-4CA3-B97D-311E8A4EBA13}']
    function attributeForKey(key: NSString): Pointer; cdecl;
    function audioBufferListWithOptions(options: QTSampleBufferAudioBufferListOptions): AudioBufferList; cdecl;
    function bytesForAllSamples: Pointer; cdecl;
    function decodeTime: QTTime; cdecl;
    procedure decrementSampleUseCount; cdecl;
    function duration: QTTime; cdecl;
    function formatDescription: QTFormatDescription; cdecl;
    function getAudioStreamPacketDescriptions(audioStreamPacketDescriptions: AudioStreamPacketDescription; inRange: NSRange): Boolean; cdecl;
    procedure incrementSampleUseCount; cdecl;
    function lengthForAllSamples: NSUInteger; cdecl;
    function numberOfSamples: NSUInteger; cdecl;
    function presentationTime: QTTime; cdecl;
    function sampleBufferAttributes: NSDictionary; cdecl;
    function sampleUseCount: NSUInteger; cdecl;
  end;
  TQTSampleBuffer = class(TOCGenericImport<QTSampleBufferClass, QTSampleBuffer>)  end;

  QTTrackClass = interface(NSObjectClass)
    ['{3FD60BCD-2029-4847-B2AD-314F3382AC60}']
    {class} function trackWithQuickTimeTrack(track: Track; error: NSError): Pointer; cdecl;
  end;
  QTTrack = interface(NSObject)
    ['{F9B29B25-C224-4113-A8D8-08EBBA4A5DAD}']
    procedure addImage(image: NSImage; forDuration: QTTime; withAttributes: NSDictionary); cdecl;
    function apertureModeDimensionsForMode(mode: NSString): NSSize; cdecl;
    function attributeForKey(attributeKey: NSString): Pointer; cdecl;
    function availableMetadataFormats: NSArray; cdecl;
    function commonMetadata: NSArray; cdecl;
    procedure deleteSegment(segment: QTTimeRange); cdecl;
    procedure generateApertureModeDimensions; cdecl;
    function initWithQuickTimeTrack(track: Track; error: NSError): Pointer; cdecl;
    procedure insertEmptySegmentAt(range: QTTimeRange); cdecl;
    procedure insertSegmentOfTrack(track: QTTrack; fromRange: QTTimeRange; scaledToRange: QTTimeRange); cdecl; overload;
    procedure insertSegmentOfTrack(track: QTTrack; timeRange: QTTimeRange; atTime: QTTime); cdecl; overload;
    function isEnabled: Boolean; cdecl;
    function media: QTMedia; cdecl;
    function metadataForFormat(format: NSString): NSArray; cdecl;
    function movie: QTMovie; cdecl;
    function quickTimeTrack: Track; cdecl;
    procedure removeApertureModeDimensions; cdecl;
    procedure scaleSegment(segment: QTTimeRange; newDuration: QTTime); cdecl;
    procedure setApertureModeDimensions(dimensions: NSSize; forMode: NSString); cdecl;
    procedure setAttribute(value: Pointer; forKey: NSString); cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setTrackAttributes(attributes: NSDictionary); cdecl;
    procedure setVolume(volume: Single); cdecl;
    function trackAttributes: NSDictionary; cdecl;
    function volume: Single; cdecl;
  end;
  TQTTrack = class(TOCGenericImport<QTTrackClass, QTTrack>)  end;

  QTMetadataItemClass = interface(NSObjectClass)
    ['{72679AE7-1AF0-49DC-BB93-42D8C8E2B628}']
    {class} function metadataItemsFromArray(array_: NSArray; withKey: Pointer; keySpace: NSString): NSArray; cdecl; overload;
    {class} function metadataItemsFromArray(array_: NSArray; withLocale: NSLocale): NSArray; cdecl; overload;
  end;
  QTMetadataItem = interface(NSObject)
    ['{FBBCD195-60C9-4290-9B0D-DA377D2ED173}']
    function dataValue: NSData; cdecl;
    function dateValue: NSDate; cdecl;
    function extraAttributes: NSDictionary; cdecl;
    function key: Pointer; cdecl;
    function keySpace: NSString; cdecl;
    function locale: NSLocale; cdecl;
    function numberValue: NSNumber; cdecl;
    function stringValue: NSString; cdecl;
    function time: QTTime; cdecl;
    function value: Pointer; cdecl;
  end;
  TQTMetadataItem = class(TOCGenericImport<QTMetadataItemClass, QTMetadataItem>)  end;

  QTMovieClass = interface(NSObjectClass)
    ['{1E4681D9-4CE4-4C1E-B0EA-F66DDB814FDE}']
    {class} function canInitWithDataReference(dataReference: QTDataReference): Boolean; cdecl;
    {class} function canInitWithFile(fileName: NSString): Boolean; cdecl;
    {class} function canInitWithPasteboard(pasteboard: NSPasteboard): Boolean; cdecl;
    {class} function canInitWithURL(url: NSURL): Boolean; cdecl;
    {class} procedure enterQTKitOnThread; cdecl;
    {class} procedure enterQTKitOnThreadDisablingThreadSafetyProtection; cdecl;
    {class} procedure exitQTKitOnThread; cdecl;
    {class} function movie: Pointer; cdecl;
    {class} function movieFileTypes(types: QTMovieFileTypeOptions): NSArray; cdecl;
    {class} function movieNamed(name: NSString; error: NSError): Pointer; cdecl;
    {class} function movieTypesWithOptions(types: QTMovieFileTypeOptions): NSArray; cdecl;
    {class} function movieUnfilteredFileTypes: NSArray; cdecl;
    {class} function movieUnfilteredPasteboardTypes: NSArray; cdecl;
    {class} function movieWithAttributes(attributes: NSDictionary; error: NSError): Pointer; cdecl;
    {class} function movieWithData(data: NSData; error: NSError): Pointer; cdecl;
    {class} function movieWithDataReference(dataReference: QTDataReference; error: NSError): Pointer; cdecl;
    {class} function movieWithFile(fileName: NSString; error: NSError): Pointer; cdecl;
    {class} function movieWithPasteboard(pasteboard: NSPasteboard; error: NSError): Pointer; cdecl;
    {class} function movieWithQuickTimeMovie(movie: Movie; disposeWhenDone: Boolean; error: NSError): Pointer; cdecl;
    {class} function movieWithURL(url: NSURL; error: NSError): Pointer; cdecl;
  end;
  QTMovie = interface(NSObject)
    ['{BCF2221F-A1DA-4C37-B2FF-5DA8A73464E6}']
    procedure addChapters(chapters: NSArray; withAttributes: NSDictionary; error: NSError); cdecl;
    procedure addImage(image: NSImage; forDuration: QTTime; withAttributes: NSDictionary); cdecl;
    procedure appendSelectionFromMovie(movie: Pointer); cdecl;
    function attachToCurrentThread: Boolean; cdecl;
    function attributeForKey(attributeKey: NSString): Pointer; cdecl;
    procedure autoplay; cdecl;
    function availableMetadataFormats: NSArray; cdecl;
    function canUpdateMovieFile: Boolean; cdecl;
    function chapterCount: NSInteger; cdecl;
    function chapterIndexForTime(time: QTTime): NSInteger; cdecl;
    function chapters: NSArray; cdecl;
    function commonMetadata: NSArray; cdecl;
    function currentFrameImage: NSImage; cdecl;
    function currentTime: QTTime; cdecl;
    function delegate: Pointer; cdecl;
    procedure deleteSegment(segment: QTTimeRange); cdecl;
    function detachFromCurrentThread: Boolean; cdecl;
    function duration: QTTime; cdecl;
    function frameImageAtTime(time: QTTime): NSImage; cdecl; overload;
    function frameImageAtTime(time: QTTime; withAttributes: NSDictionary; error: NSError): Pointer; cdecl; overload;
    procedure generateApertureModeDimensions; cdecl;
    procedure gotoBeginning; cdecl;
    procedure gotoEnd; cdecl;
    procedure gotoNextSelectionPoint; cdecl;
    procedure gotoPosterTime; cdecl;
    procedure gotoPreviousSelectionPoint; cdecl;
    function hasChapters: Boolean; cdecl;
    function initToWritableData(data: NSMutableData; error: NSError): Pointer; cdecl;
    function initToWritableDataReference(dataReference: QTDataReference; error: NSError): Pointer; cdecl;
    function initToWritableFile(filename: NSString; error: NSError): Pointer; cdecl;
    function initWithAttributes(attributes: NSDictionary; error: NSError): Pointer; cdecl;
    function initWithData(data: NSData; error: NSError): Pointer; cdecl;
    function initWithDataReference(dataReference: QTDataReference; error: NSError): Pointer; cdecl;
    function initWithFile(fileName: NSString; error: NSError): Pointer; cdecl;
    function initWithMovie(movie: QTMovie; timeRange: QTTimeRange; error: NSError): Pointer; cdecl;
    function initWithPasteboard(pasteboard: NSPasteboard; error: NSError): Pointer; cdecl;
    function initWithQuickTimeMovie(movie: Movie; disposeWhenDone: Boolean; error: NSError): Pointer; cdecl;
    function initWithURL(url: NSURL; error: NSError): Pointer; cdecl;
    procedure insertEmptySegmentAt(range: QTTimeRange); cdecl;
    procedure insertSegmentOfMovie(movie: QTMovie; fromRange: QTTimeRange; scaledToRange: QTTimeRange); cdecl; overload;
    procedure insertSegmentOfMovie(movie: QTMovie; timeRange: QTTimeRange; atTime: QTTime); cdecl; overload;
    function insertSegmentOfTrack(track: QTTrack; fromRange: QTTimeRange; scaledToRange: QTTimeRange): QTTrack; cdecl; overload;
    function insertSegmentOfTrack(track: QTTrack; timeRange: QTTimeRange; atTime: QTTime): QTTrack; cdecl; overload;
    procedure invalidate; cdecl;
    function isIdling: Boolean; cdecl;
    function metadataForFormat(format: NSString): NSArray; cdecl;
    function movieAttributes: NSDictionary; cdecl;
    function movieFormatRepresentation: NSData; cdecl;
    function movieWithTimeRange(range: QTTimeRange; error: NSError): Pointer; cdecl;
    function muted: Boolean; cdecl;
    procedure play; cdecl;
    function posterImage: NSImage; cdecl;
    function quickTimeMovie: Movie; cdecl;
    function quickTimeMovieController: MovieController; cdecl;
    function rate: Single; cdecl;
    procedure removeApertureModeDimensions; cdecl;
    function removeChapters: Boolean; cdecl;
    procedure removeTrack(track: QTTrack); cdecl;
    procedure replaceSelectionWithSelectionFromMovie(movie: Pointer); cdecl;
    procedure scaleSegment(segment: QTTimeRange; newDuration: QTTime); cdecl;
    function selectionDuration: QTTime; cdecl;
    function selectionEnd: QTTime; cdecl;
    function selectionStart: QTTime; cdecl;
    procedure setAttribute(value: Pointer; forKey: NSString); cdecl;
    procedure setCurrentTime(time: QTTime); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setIdling(state: Boolean); cdecl;
    procedure setMovieAttributes(attributes: NSDictionary); cdecl;
    procedure setMuted(mute: Boolean); cdecl;
    procedure setRate(rate: Single); cdecl;
    procedure setSelection(selection: QTTimeRange); cdecl;
    procedure setVisualContext(visualContext: QTVisualContextRef); cdecl;
    procedure setVolume(volume: Single); cdecl;
    function startTimeOfChapter(chapterIndex: NSInteger): QTTime; cdecl;
    procedure stepBackward; cdecl;
    procedure stepForward; cdecl;
    procedure stop; cdecl;
    function trackByInsertingSegmentOfTrack(track: QTTrack; fromRange: QTTimeRange; scaledToRange: QTTimeRange): QTTrack; cdecl; overload;
    function trackByInsertingSegmentOfTrack(track: QTTrack; timeRange: QTTimeRange; atTime: QTTime): QTTrack; cdecl; overload;
    function tracks: NSArray; cdecl;
    function tracksOfMediaType(type_: NSString): NSArray; cdecl;
    function updateMovieFile: Boolean; cdecl;
    function visualContext: QTVisualContextRef; cdecl;
    function volume: Single; cdecl;
    function writeToFile(fileName: NSString; withAttributes: NSDictionary): Boolean; cdecl; overload;
    function writeToFile(fileName: NSString; withAttributes: NSDictionary; error: NSError): Boolean; cdecl; overload;
  end;
  TQTMovie = class(TOCGenericImport<QTMovieClass, QTMovie>)  end;

  QTMovieLayerClass = interface(CALayerClass)
    ['{B98DA4DD-05A6-496D-9F55-9F37FED76069}']
    {class} function layerWithMovie(movie: QTMovie): Pointer; cdecl;
  end;
  QTMovieLayer = interface(CALayer)
    ['{FD0C1A2F-AD9F-4411-93F8-E8355FCC2E88}']
    function initWithMovie(movie: QTMovie): Pointer; cdecl;
    function movie: QTMovie; cdecl;
    procedure setMovie(movie: QTMovie); cdecl;
  end;
  TQTMovieLayer = class(TOCGenericImport<QTMovieLayerClass, QTMovieLayer>)  end;

  QTCaptureSessionClass = interface(NSObjectClass)
    ['{3EECC294-5D8B-4500-BD65-B07BA3387B3F}']
  end;
  QTCaptureSession = interface(NSObject)
    ['{F07198F4-82B4-46D6-BC05-3852715D36E6}']
    function addInput(input: QTCaptureInput; error: NSError): Boolean; cdecl;
    function addOutput(output: QTCaptureOutput; error: NSError): Boolean; cdecl;
    function inputs: NSArray; cdecl;
    function isRunning: Boolean; cdecl;
    function outputs: NSArray; cdecl;
    procedure removeInput(input: QTCaptureInput); cdecl;
    procedure removeOutput(output: QTCaptureOutput); cdecl;
    procedure startRunning; cdecl;
    procedure stopRunning; cdecl;
  end;
  TQTCaptureSession = class(TOCGenericImport<QTCaptureSessionClass, QTCaptureSession>)  end;

  QTCaptureConnectionClass = interface(NSObjectClass)
    ['{30FD3997-FCB4-4CB5-A2A1-076D3A86CE43}']
  end;
  QTCaptureConnection = interface(NSObject)
    ['{3ADB6B0D-6181-4224-93B5-612B5BAF31E4}']
    function attributeForKey(attributeKey: NSString): Pointer; cdecl;
    function attributeIsReadOnly(attributeKey: NSString): Boolean; cdecl;
    function connectionAttributes: NSDictionary; cdecl;
    function formatDescription: QTFormatDescription; cdecl;
    function isEnabled: Boolean; cdecl;
    function mediaType: NSString; cdecl;
    function owner: Pointer; cdecl;
    procedure setAttribute(attribute: Pointer; forKey: NSString); cdecl;
    procedure setConnectionAttributes(connectionAttributes: NSDictionary); cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
  end;
  TQTCaptureConnection = class(TOCGenericImport<QTCaptureConnectionClass, QTCaptureConnection>)  end;

  QTCaptureDeviceClass = interface(NSObjectClass)
    ['{62C7D97F-68D4-4423-9623-66496142187F}']
    {class} function defaultInputDeviceWithMediaType(mediaType: NSString): Pointer; cdecl;
    {class} function deviceWithUniqueID(deviceUniqueID: NSString): Pointer; cdecl;
    {class} function inputDevices: NSArray; cdecl;
    {class} function inputDevicesWithMediaType(mediaType: NSString): NSArray; cdecl;
  end;
  QTCaptureDevice = interface(NSObject)
    ['{F25EE741-0DD9-46F2-8288-B9A7EA10DE65}']
    function attributeForKey(attributeKey: NSString): Pointer; cdecl;
    function attributeIsReadOnly(attributeKey: NSString): Boolean; cdecl;
    procedure close; cdecl;
    function deviceAttributes: NSDictionary; cdecl;
    function formatDescriptions: NSArray; cdecl;
    function hasMediaType(mediaType: NSString): Boolean; cdecl;
    function isConnected: Boolean; cdecl;
    function isInUseByAnotherApplication: Boolean; cdecl;
    function isOpen: Boolean; cdecl;
    function localizedDisplayName: NSString; cdecl;
    function modelUniqueID: NSString; cdecl;
    function open(errorPtr: NSError): Boolean; cdecl;
    procedure setAttribute(attribute: Pointer; forKey: NSString); cdecl;
    procedure setDeviceAttributes(deviceAttributes: NSDictionary); cdecl;
    function uniqueID: NSString; cdecl;
  end;
  TQTCaptureDevice = class(TOCGenericImport<QTCaptureDeviceClass, QTCaptureDevice>)  end;

  QTCaptureInputClass = interface(NSObjectClass)
    ['{BFD6EF61-E283-4123-AD6C-CAFE3EE7691D}']
  end;
  QTCaptureInput = interface(NSObject)
    ['{DE34E145-329C-4A69-8B10-EBCCFF9AC027}']
    function connections: NSArray; cdecl;
  end;
  TQTCaptureInput = class(TOCGenericImport<QTCaptureInputClass, QTCaptureInput>)  end;

  QTCaptureLayerClass = interface(CALayerClass)
    ['{585892F3-B9D1-4D3B-8A7B-C7124402FFA1}']
    {class} function layerWithSession(session: QTCaptureSession): Pointer; cdecl;
  end;
  QTCaptureLayer = interface(CALayer)
    ['{791B063F-5C41-41E1-A5A6-433FB74DF756}']
    function initWithSession(session: QTCaptureSession): Pointer; cdecl;
    function session: QTCaptureSession; cdecl;
    procedure setSession(session: QTCaptureSession); cdecl;
  end;
  TQTCaptureLayer = class(TOCGenericImport<QTCaptureLayerClass, QTCaptureLayer>)  end;

  QTCaptureOutputClass = interface(NSObjectClass)
    ['{01F0117E-4DF1-4C0A-847C-F77A2E045AE1}']
  end;
  QTCaptureOutput = interface(NSObject)
    ['{424A11C6-5C54-4B46-BB33-300464638A8B}']
    function connections: NSArray; cdecl;
  end;
  TQTCaptureOutput = class(TOCGenericImport<QTCaptureOutputClass, QTCaptureOutput>)  end;

  QTCaptureFileOutputClass = interface(QTCaptureOutputClass)
    ['{A178F61F-9827-4864-A7A4-D40E9815DB11}']
  end;
  QTCaptureFileOutput = interface(QTCaptureOutput)
    ['{93A0DBD7-3A5E-40B1-AC84-83079668552A}']
    function compressionOptionsForConnection(connection: QTCaptureConnection): QTCompressionOptions; cdecl;
    function delegate: Pointer; cdecl;
    function isRecordingPaused: Boolean; cdecl;
    function maximumRecordedDuration: QTTime; cdecl;
    function maximumRecordedFileSize: UInt64; cdecl;
    function maximumVideoSize: NSSize; cdecl;
    function minimumVideoFrameInterval: NSTimeInterval; cdecl;
    function outputFileURL: NSURL; cdecl;
    procedure pauseRecording; cdecl;
    procedure recordToOutputFileURL(url: NSURL); cdecl; overload;
    procedure recordToOutputFileURL(url: NSURL; bufferDestination: QTCaptureFileOutputBufferDestination); cdecl; overload;
    function recordedDuration: QTTime; cdecl;
    function recordedFileSize: UInt64; cdecl;
    procedure resumeRecording; cdecl;
    procedure setCompressionOptions(compressionOptions: QTCompressionOptions; forConnection: QTCaptureConnection); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setMaximumRecordedDuration(maximumRecordedDuration: QTTime); cdecl;
    procedure setMaximumRecordedFileSize(maximumRecordedFileSize: UInt64); cdecl;
    procedure setMaximumVideoSize(maximumVideoSize: NSSize); cdecl;
    procedure setMinimumVideoFrameInterval(minimumVideoFrameInterval: NSTimeInterval); cdecl;
  end;
  TQTCaptureFileOutput = class(TOCGenericImport<QTCaptureFileOutputClass, QTCaptureFileOutput>)  end;

  QTCaptureMovieFileOutputClass = interface(QTCaptureFileOutputClass)
    ['{88F0E6C6-F5C9-4C29-ADFF-7C3297EAFE0F}']
  end;
  QTCaptureMovieFileOutput = interface(QTCaptureFileOutput)
    ['{342F7DF5-FF87-42F2-93BB-91DE0FFAB848}']
  end;
  TQTCaptureMovieFileOutput = class(TOCGenericImport<QTCaptureMovieFileOutputClass, QTCaptureMovieFileOutput>)  end;

  QTCaptureDeviceInputClass = interface(QTCaptureInputClass)
    ['{54E57F5C-098A-4C1D-B96B-7BB76AB4BBEF}']
    {class} function deviceInputWithDevice(device: QTCaptureDevice): Pointer; cdecl;
  end;
  QTCaptureDeviceInput = interface(QTCaptureInput)
    ['{51F228C7-9B4C-4AA3-82C4-380C30B73DB2}']
    function device: QTCaptureDevice; cdecl;
    function initWithDevice(device: QTCaptureDevice): Pointer; cdecl;
  end;
  TQTCaptureDeviceInput = class(TOCGenericImport<QTCaptureDeviceInputClass, QTCaptureDeviceInput>)  end;

  QTCaptureVideoPreviewOutputClass = interface(QTCaptureOutputClass)
    ['{06F7B798-77C8-47B6-B011-1271E7042F04}']
  end;
  QTCaptureVideoPreviewOutput = interface(QTCaptureOutput)
    ['{57BFB194-0691-4557-A9C2-A712BF8E9305}']
    function delegate: Pointer; cdecl;
    procedure outputVideoFrame(videoFrame: CVImageBufferRef; withSampleBuffer: QTSampleBuffer; fromConnection: QTCaptureConnection); cdecl;
    function pixelBufferAttributes: NSDictionary; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setPixelBufferAttributes(pixelBufferAttributes: NSDictionary); cdecl;
    procedure setVisualContext(visualContext: QTVisualContextRef; forConnection: QTCaptureConnection); cdecl;
    function visualContextForConnection(connection: QTCaptureConnection): QTVisualContextRef; cdecl;
  end;
  TQTCaptureVideoPreviewOutput = class(TOCGenericImport<QTCaptureVideoPreviewOutputClass, QTCaptureVideoPreviewOutput>)  end;

  QTCaptureDecompressedAudioOutputClass = interface(QTCaptureOutputClass)
    ['{6D119EBC-AA7C-46C2-8DEB-4A75E227C9B6}']
  end;
  QTCaptureDecompressedAudioOutput = interface(QTCaptureOutput)
    ['{03E72AC3-58F8-41E0-8E49-7024F5B10BD6}']
    function delegate: Pointer; cdecl;
    procedure outputAudioSampleBuffer(sampleBuffer: QTSampleBuffer; fromConnection: QTCaptureConnection); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
  end;
  TQTCaptureDecompressedAudioOutput = class(TOCGenericImport<QTCaptureDecompressedAudioOutputClass, QTCaptureDecompressedAudioOutput>)  end;

  QTCaptureDecompressedVideoOutputClass = interface(QTCaptureOutputClass)
    ['{B7CA44C6-6D32-4E28-9826-558FBF2D1D8C}']
  end;
  QTCaptureDecompressedVideoOutput = interface(QTCaptureOutput)
    ['{2CB4A186-2B0E-45E0-8DED-C20616A257D8}']
    function automaticallyDropsLateVideoFrames: Boolean; cdecl;
    function delegate: Pointer; cdecl;
    function minimumVideoFrameInterval: NSTimeInterval; cdecl;
    procedure outputVideoFrame(videoFrame: CVImageBufferRef; withSampleBuffer: QTSampleBuffer; fromConnection: QTCaptureConnection); cdecl;
    function pixelBufferAttributes: NSDictionary; cdecl;
    procedure setAutomaticallyDropsLateVideoFrames(automaticallyDropsLateVideoFrames: Boolean); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setMinimumVideoFrameInterval(minimumVideoFrameInterval: NSTimeInterval); cdecl;
    procedure setPixelBufferAttributes(pixelBufferAttributes: NSDictionary); cdecl;
  end;
  TQTCaptureDecompressedVideoOutput = class(TOCGenericImport<QTCaptureDecompressedVideoOutputClass, QTCaptureDecompressedVideoOutput>)  end;

  QTCaptureAudioPreviewOutputClass = interface(QTCaptureOutputClass)
    ['{60F2A8E3-414F-4C7B-85E0-6CB8D123C7CF}']
  end;
  QTCaptureAudioPreviewOutput = interface(QTCaptureOutput)
    ['{E96FDA51-C59F-455E-AC95-9656F63359C4}']
    function outputDeviceUniqueID: NSString; cdecl;
    procedure setOutputDeviceUniqueID(uniqueID: NSString); cdecl;
    procedure setVolume(volume: Single); cdecl;
    function volume: Single; cdecl;
  end;
  TQTCaptureAudioPreviewOutput = class(TOCGenericImport<QTCaptureAudioPreviewOutputClass, QTCaptureAudioPreviewOutput>)  end;


function QTMediaTypeSound: NSString;
function QTMediaTypeVideo: NSString;

function QTMovieFrameImageType: NSString;
function QTMovieFrameImageTypeCGImageRef: NSString; 

function QTMovieNaturalSizeAttribute: NSString;

implementation

function QTMediaTypeSound: NSString;
begin
  Result := CocoaNSStringConst(libQTKit, 'QTMediaTypeSound');
end;

function QTMediaTypeVideo: NSString;
begin
  Result := CocoaNSStringConst(libQTKit, 'QTMediaTypeVideo');
end;

function QTMovieFrameImageType: NSString;
begin
  Result := CocoaNSStringConst(libQTKit, 'QTMovieFrameImageType');
end;

function QTMovieFrameImageTypeCGImageRef: NSString;
begin
  Result := CocoaNSStringConst(libQTKit, 'QTMovieFrameImageTypeCGImageRef');
end;

function QTMovieNaturalSizeAttribute: NSString;
begin
  Result := CocoaNSStringConst(libQTKit, 'QTMovieNaturalSizeAttribute');
end;


end.
