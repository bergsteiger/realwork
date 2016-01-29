{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}
{  Delphi-Objective-C Bridge                            }
{  Interfaces for Cocoa framework AVFoundation          }
{                                                       }
{  Copyright 2008-2010 Apple Inc. All rights reserved.  }
{                                                       }
{  Translator: Embarcadero Technologies, Inc.           }
{ Copyright (c) 2012-2013 Embarcadero Technologies, Inc.}
{*******************************************************}

unit Macapi.AVFoundation;

interface

uses
  Macapi.ObjCRuntime,
  Macapi.ObjectiveC,
  Macapi.CocoaTypes,
  Macapi.Dispatch,
//  Macapi.CoreVideo,
//  Macapi.AudioToolbox,
  Macapi.Foundation,
//  Macapi.CoreMedia,
  Macapi.CoreFoundation,
//  Macapi.ApplicationServices,
  Macapi.QuartzCore,
//  Macapi.CoreMediaIO,
//  Macapi.CoreAudio,
  Macapi.Security,
  Macapi.CoreServices;

const
  AVAssetExportSessionStatusCancelled = 5;
  AVAssetExportSessionStatusCompleted = 3;
  AVAssetExportSessionStatusExporting = 2;
  AVAssetExportSessionStatusFailed = 4;
  AVAssetExportSessionStatusUnknown = 0;
  AVAssetExportSessionStatusWaiting = 1;
  AVAssetImageGeneratorCancelled = 2;
  AVAssetImageGeneratorFailed = 1;
  AVAssetImageGeneratorSucceeded = 0;
  AVAssetReaderStatusCancelled = 4;
  AVAssetReaderStatusCompleted = 2;
  AVAssetReaderStatusFailed = 3;
  AVAssetReaderStatusReading = 1;
  AVAssetReaderStatusUnknown = 0;
  AVAssetReferenceRestrictionForbidAll = 65535;
  AVAssetReferenceRestrictionForbidCrossSiteReference = 4;
  AVAssetReferenceRestrictionForbidLocalReferenceToLocal = 8;
  AVAssetReferenceRestrictionForbidLocalReferenceToRemote = 2;
  AVAssetReferenceRestrictionForbidNone = 0;
  AVAssetReferenceRestrictionForbidRemoteReferenceToLocal = 1;
  AVAssetWriterStatusCancelled = 4;
  AVAssetWriterStatusCompleted = 2;
  AVAssetWriterStatusFailed = 3;
  AVAssetWriterStatusUnknown = 0;
  AVAssetWriterStatusWriting = 1;
  AVAudioQualityHigh = 96;
  AVAudioQualityLow = 32;
  AVAudioQualityMax = 127;
  AVAudioQualityMedium = 64;
  AVAudioQualityMin = 0;
  AVCaptureDevicePositionBack = 1;
  AVCaptureDevicePositionFront = 2;
  AVCaptureDevicePositionUnspecified = 0;
  AVCaptureDeviceTransportControlsNotPlayingMode = 0;
  AVCaptureDeviceTransportControlsPlayingMode = 1;
  AVCaptureExposureModeAutoExpose = 1;
  AVCaptureExposureModeContinuousAutoExposure = 2;
  AVCaptureExposureModeLocked = 0;
  AVCaptureFlashModeAuto = 2;
  AVCaptureFlashModeOff = 0;
  AVCaptureFlashModeOn = 1;
  AVCaptureFocusModeAutoFocus = 1;
  AVCaptureFocusModeContinuousAutoFocus = 2;
  AVCaptureFocusModeLocked = 0;
  AVCaptureTorchModeAuto = 2;
  AVCaptureTorchModeOff = 0;
  AVCaptureTorchModeOn = 1;
  AVCaptureVideoOrientationLandscapeLeft = 4;
  AVCaptureVideoOrientationLandscapeRight = 3;
  AVCaptureVideoOrientationPortrait = 1;
  AVCaptureVideoOrientationPortraitUpsideDown = 2;
  AVCaptureWhiteBalanceModeAutoWhiteBalance = 1;
  AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance = 2;
  AVCaptureWhiteBalanceModeLocked = 0;
  AVContentAuthorizationBusy = 4;
  AVContentAuthorizationCancelled = 2;
  AVContentAuthorizationCompleted = 1;
  AVContentAuthorizationNotAvailable = 5;
  AVContentAuthorizationNotPossible = 6;
  AVContentAuthorizationTimedOut = 3;
  AVContentAuthorizationUnknown = 0;
  AVErrorApplicationIsNotAuthorized = -11836;
  AVErrorCompositionTrackSegmentsNotContiguous = -11824;
  AVErrorContentIsNotAuthorized = -11835;
  AVErrorContentIsProtected = -11831;
  AVErrorDecodeFailed = -11821;
  AVErrorDecoderNotFound = -11833;
  AVErrorDeviceAlreadyUsedByAnotherSession = -11804;
  AVErrorDeviceInUseByAnotherApplication = -11815;
  AVErrorDeviceLockedForConfigurationByAnotherProcess = -11817;
  AVErrorDeviceNotConnected = -11814;
  AVErrorDeviceWasDisconnected = -11808;
  AVErrorDiskFull = -11807;
  AVErrorEncoderNotFound = -11834;
  AVErrorExportFailed = -11820;
  AVErrorFileAlreadyExists = -11823;
  AVErrorFileFailedToParse = -11829;
  AVErrorFileFormatNotRecognized = -11828;
  AVErrorInvalidCompositionTrackSegmentDuration = -11825;
  AVErrorInvalidCompositionTrackSegmentSourceDuration = -11827;
  AVErrorInvalidCompositionTrackSegmentSourceStartTime = -11826;
  AVErrorInvalidSourceMedia = -11822;
  AVErrorMaximumDurationReached = -11810;
  AVErrorMaximumFileSizeReached = -11811;
  AVErrorMaximumNumberOfSamplesForFileFormatReached = -11813;
  AVErrorMaximumStillImageCaptureRequestsExceeded = -11830;
  AVErrorMediaChanged = -11809;
  AVErrorMediaDiscontinuity = -11812;
  AVErrorNoDataCaptured = -11805;
  AVErrorNoImageAtTime = -11832;
  AVErrorOperationNotSupportedForAsset = -11838;
  AVErrorOutOfMemory = -11801;
  AVErrorSessionConfigurationChanged = -11806;
  AVErrorSessionNotRunning = -11803;
  AVErrorUnknown = -11800;
  AVKeyValueStatusCancelled = 4;
  AVKeyValueStatusFailed = 3;
  AVKeyValueStatusLoaded = 2;
  AVKeyValueStatusLoading = 1;
  AVKeyValueStatusUnknown = 0;
  AVPlayerActionAtItemEndAdvance = 0;
  AVPlayerActionAtItemEndNone = 2;
  AVPlayerActionAtItemEndPause = 1;
  AVPlayerItemStatusFailed = 2;
  AVPlayerItemStatusReadyToPlay = 1;
  AVPlayerItemStatusUnknown = 0;
  AVPlayerStatusFailed = 2;
  AVPlayerStatusReadyToPlay = 1;
  AVPlayerStatusUnknown = 0;
  AVVideoFieldModeBoth = 0;
  AVVideoFieldModeBottomOnly = 2;
  AVVideoFieldModeDeinterlace = 3;
  AVVideoFieldModeTopOnly = 1;

// ===== External functions =====

const
  libAVFoundation = '/System/Library/Frameworks/AVFoundation.framework/AVFoundation';

function AVMakeRectWithAspectRatioInsideRect(aspectRatio: CGSize; boundingRect: CGRect): CGRect; cdecl; external libAVFoundation name _PU + 'AVMakeRectWithAspectRatioInsideRect';

type
{$M+}
// ===== Forward declarations =====

  AVAudioPlayerDelegate = interface;
  AVAudioRecorderDelegate = interface;
  AVCaptureAudioDataOutputSampleBufferDelegate = interface;
  AVCaptureFileOutputDelegate = interface;
  AVCaptureFileOutputRecordingDelegate = interface;
  AVCaptureVideoDataOutputSampleBufferDelegate = interface;

  AVTimedMetadataGroup = interface;
  AVCaptureInputPort = interface;
  AVCaptureOutput = interface;
  AVCaptureSession = interface;
  AVSynchronizedLayer = interface;
  AVCaptureDeviceFormat = interface;
  AVCaptureDevice = interface;
  AVVideoComposition = interface;
  AVCaptureInput = interface;
  AVCaptureDeviceInputSource = interface;
  AVPlayerLayer = interface;
  AVPlayerItemAccessLogEvent = interface;
  AVMetadataItem = interface;
  AVPlayerItemAccessLog = interface;
  AVPlayer = interface;
  AVPlayerItem = interface;
  AVPlayerItemTrack = interface;
  AVCaptureVideoPreviewLayer = interface;
  AVPlayerItemErrorLogEvent = interface;
  AVFrameRateRange = interface;
  AVPlayerItemErrorLog = interface;
  AVCaptureConnection = interface;
  AVAssetTrack = interface;
  AVAssetWriter = interface;
  AVAssetTrackSegment = interface;
  AVAssetReaderOutput = interface;
  AVAssetExportSession = interface;
  AVAsset = interface;
  AVAssetImageGenerator = interface;
  AVAssetReader = interface;
  AVCaptureAudioChannel = interface;
  AVAudioRecorder = interface;
  AVVideoCompositionLayerInstruction = interface;
  AVVideoCompositionCoreAnimationTool = interface;
  AVVideoCompositionInstruction = interface;
  AVAudioPlayer = interface;
  AVAssetWriterInputPixelBufferAdaptor = interface;
  AVAssetWriterInput = interface;
  AVAudioMix = interface;
  AVAudioMixInputParameters = interface;
  AVMutableVideoCompositionLayerInstruction = interface;
  AVMutableVideoCompositionInstruction = interface;
  AVURLAsset = interface;
  AVQueuePlayer = interface;
  AVMutableVideoComposition = interface;
  AVCaptureFileOutput = interface;
  AVCaptureDeviceInput = interface;
  AVCaptureStillImageOutput = interface;
  AVCaptureScreenInput = interface;
  AVCaptureAudioPreviewOutput = interface;
  AVAssetReaderTrackOutput = interface;
  AVAssetReaderAudioMixOutput = interface;
  AVCaptureAudioDataOutput = interface;
  AVAssetReaderVideoCompositionOutput = interface;
  AVCaptureVideoDataOutput = interface;
  AVMutableAudioMixInputParameters = interface;
  AVMutableAudioMix = interface;
  AVMutableTimedMetadataGroup = interface;
  AVMutableMetadataItem = interface;
  AVCompositionTrack = interface;
  AVComposition = interface;
  AVCompositionTrackSegment = interface;
  AVMutableCompositionTrack = interface;
  AVCaptureMovieFileOutput = interface;
  AVCaptureAudioFileOutput = interface;
  AVMutableComposition = interface;

  // ===== Protocol declarations =====


  AVAsynchronousKeyValueLoading = interface
    ['{6A7DAE6F-B701-4D4D-B3DD-906C74C0BF8D}']
    function statusOfValueForKey(key: NSString; error: NSError): AVKeyValueStatus; cdecl;
  end;
  AVAudioPlayerDelegate = interface(IObjectiveC)
    ['{A36A19B7-F324-4C33-8F72-8A5714C90A8C}']
    procedure audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer; error: NSError); cdecl;
    procedure audioPlayerDidFinishPlaying(player: AVAudioPlayer; successfully: Boolean); cdecl;
  end;
  AVAudioRecorderDelegate = interface(IObjectiveC)
    ['{79549A53-A7CE-4DC3-9AAC-FFC5FCA01107}']
    procedure audioRecorderDidFinishRecording(recorder: AVAudioRecorder; successfully: Boolean); cdecl;
    procedure audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder; error: NSError); cdecl;
  end;
  AVCaptureAudioDataOutputSampleBufferDelegate = interface(IObjectiveC)
    ['{22015942-1F1E-4E83-8ED1-B0D096703D76}']
    procedure captureOutput(captureOutput: AVCaptureOutput; didOutputSampleBuffer: CMSampleBufferRef; fromConnection: AVCaptureConnection); cdecl;
  end;
  AVCaptureFileOutputDelegate = interface(IObjectiveC)
    ['{E8B7841F-8FD3-4653-9450-3CA097F2D4E5}']
    procedure captureOutput(captureOutput: AVCaptureOutput; didOutputSampleBuffer: CMSampleBufferRef; fromConnection: AVCaptureConnection); cdecl;
  end;
  AVCaptureFileOutputRecordingDelegate = interface(IObjectiveC)
    ['{357F0719-63B9-4BE3-B0CD-DFBE2229C198}']
    procedure captureOutput(captureOutput: AVCaptureFileOutput; didFinishRecordingToOutputFileAtURL: NSURL; fromConnections: NSArray; error: NSError); cdecl; overload;
//    procedure captureOutput(captureOutput: AVCaptureFileOutput; didPauseRecordingToOutputFileAtURL: NSURL; fromConnections: NSArray); cdecl; overload;
//    procedure captureOutput(captureOutput: AVCaptureFileOutput; didResumeRecordingToOutputFileAtURL: NSURL; fromConnections: NSArray); cdecl; overload;
//    procedure captureOutput(captureOutput: AVCaptureFileOutput; didStartRecordingToOutputFileAtURL: NSURL; fromConnections: NSArray); cdecl; overload;
//    procedure captureOutput(captureOutput: AVCaptureFileOutput; willFinishRecordingToOutputFileAtURL: NSURL; fromConnections: NSArray; error: NSError); cdecl; overload;
  end;
  AVCaptureVideoDataOutputSampleBufferDelegate = interface(IObjectiveC)
    ['{E10F8D60-FACF-4C7D-BD26-5B44B48D1FA9}']
//    procedure captureOutput(captureOutput: AVCaptureOutput; didDropSampleBuffer: CMSampleBufferRef; fromConnection: AVCaptureConnection); cdecl; overload;
    procedure captureOutput(captureOutput: AVCaptureOutput; didOutputSampleBuffer: CMSampleBufferRef; fromConnection: AVCaptureConnection); cdecl; overload;
  end;

// ===== Interface declarations =====

  AVTimedMetadataGroupClass = interface(NSObjectClass)
    ['{4C94B1EA-473D-4BE3-8961-D8660807FDDE}']
  end;
  AVTimedMetadataGroup = interface(NSObject)
    ['{37E80B6D-9DA5-4517-91B6-E1FC653AF47E}']
    function initWithItems(items: NSArray; timeRange: CMTimeRange): Pointer; cdecl;
    function items: NSArray; cdecl;
    function timeRange: CMTimeRange; cdecl;
  end;
  TAVTimedMetadataGroup = class(TOCGenericImport<AVTimedMetadataGroupClass, AVTimedMetadataGroup>)  end;

  AVCaptureInputPortClass = interface(NSObjectClass)
    ['{B5ACA2A4-5E45-4846-9087-03747B91F17F}']
  end;
  AVCaptureInputPort = interface(NSObject)
    ['{BC1B8C1E-565C-419C-815D-35DE86D1772E}']
    function formatDescription: CMFormatDescriptionRef; cdecl;
    function input: AVCaptureInput; cdecl;
    function isEnabled: Boolean; cdecl;
    function mediaType: NSString; cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
  end;
  TAVCaptureInputPort = class(TOCGenericImport<AVCaptureInputPortClass, AVCaptureInputPort>)  end;

  AVCaptureOutputClass = interface(NSObjectClass)
    ['{A1F907E8-E4ED-4D38-80AA-E64168FB25DC}']
  end;
  AVCaptureOutput = interface(NSObject)
    ['{05F18F87-BA90-4774-89E6-4A41C7BF4319}']
    function connectionWithMediaType(mediaType: NSString): AVCaptureConnection; cdecl;
    function connections: NSArray; cdecl;
  end;
  TAVCaptureOutput = class(TOCGenericImport<AVCaptureOutputClass, AVCaptureOutput>)  end;

  AVCaptureSessionClass = interface(NSObjectClass)
    ['{745FFD2C-8789-4E32-B2CF-B2F712BADE4F}']
  end;
  AVCaptureSession = interface(NSObject)
    ['{B667FB95-0118-48D9-AE9C-1484C42159C1}']
    procedure addConnection(connection: AVCaptureConnection); cdecl;
    procedure addInput(input: AVCaptureInput); cdecl;
    procedure addInputWithNoConnections(input: AVCaptureInput); cdecl;
    procedure addOutput(output: AVCaptureOutput); cdecl;
    procedure addOutputWithNoConnections(output: AVCaptureOutput); cdecl;
    procedure beginConfiguration; cdecl;
    function canAddConnection(connection: AVCaptureConnection): Boolean; cdecl;
    function canAddInput(input: AVCaptureInput): Boolean; cdecl;
    function canAddOutput(output: AVCaptureOutput): Boolean; cdecl;
    function canSetSessionPreset(preset: NSString): Boolean; cdecl;
    procedure commitConfiguration; cdecl;
    function inputs: NSArray; cdecl;
    function isRunning: Boolean; cdecl;
    function outputs: NSArray; cdecl;
    procedure removeConnection(connection: AVCaptureConnection); cdecl;
    procedure removeInput(input: AVCaptureInput); cdecl;
    procedure removeOutput(output: AVCaptureOutput); cdecl;
    function sessionPreset: NSString; cdecl;
    procedure setSessionPreset(sessionPreset: NSString); cdecl;
    procedure startRunning; cdecl;
    procedure stopRunning; cdecl;
  end;
  TAVCaptureSession = class(TOCGenericImport<AVCaptureSessionClass, AVCaptureSession>)  end;

  AVSynchronizedLayerClass = interface(CALayerClass)
    ['{98D343AE-AEA3-4E87-87F9-D9FAFC21E90C}']
    {class} function synchronizedLayerWithPlayerItem(playerItem: AVPlayerItem): Pointer; cdecl;
  end;
  AVSynchronizedLayer = interface(CALayer)
    ['{E9D0E415-BB8D-4E83-99D3-959D54457C02}']
    function playerItem: AVPlayerItem; cdecl;
    procedure setPlayerItem(playerItem: AVPlayerItem); cdecl;
  end;
  TAVSynchronizedLayer = class(TOCGenericImport<AVSynchronizedLayerClass, AVSynchronizedLayer>)  end;

  AVCaptureDeviceFormatClass = interface(NSObjectClass)
    ['{33DAB63A-7FCD-47F1-AAB9-392059BDF345}']
  end;
  AVCaptureDeviceFormat = interface(NSObject)
    ['{F0B88852-EBCA-4D6C-A59B-F0CE93694B7F}']
    function formatDescription: CMFormatDescriptionRef; cdecl;
    function mediaType: NSString; cdecl;
    function videoSupportedFrameRateRanges: NSArray; cdecl;
  end;
  TAVCaptureDeviceFormat = class(TOCGenericImport<AVCaptureDeviceFormatClass, AVCaptureDeviceFormat>)  end;

  AVCaptureDeviceClass = interface(NSObjectClass)
    ['{74F45CA3-C520-4069-8EE3-DCD1B19FB5F3}']
    {class} function defaultDeviceWithMediaType(mediaType: NSString): Pointer; cdecl;
    {class} function deviceWithUniqueID(deviceUniqueID: NSString): Pointer; cdecl;
    {class} function devices: NSArray; cdecl;
    {class} function devicesWithMediaType(mediaType: NSString): NSArray; cdecl;
  end;
  AVCaptureDevice = interface(NSObject)
    ['{CC532659-BBE1-442D-B1D9-9ECA7BD7B2D3}']
    function activeFormat: AVCaptureDeviceFormat; cdecl;
    function activeInputSource: AVCaptureDeviceInputSource; cdecl;
    function activeVideoMinFrameDuration: CMTime; cdecl;
    function exposureMode: AVCaptureExposureMode; cdecl;
    function exposurePointOfInterest: CGPoint; cdecl;
    function flashMode: AVCaptureFlashMode; cdecl;
    function focusMode: AVCaptureFocusMode; cdecl;
    function focusPointOfInterest: CGPoint; cdecl;
    function formats: NSArray; cdecl;
    function hasFlash: Boolean; cdecl;
    function hasMediaType(mediaType: NSString): Boolean; cdecl;
    function hasTorch: Boolean; cdecl;
    function inputSources: NSArray; cdecl;
    function isAdjustingExposure: Boolean; cdecl;
    function isAdjustingFocus: Boolean; cdecl;
    function isAdjustingWhiteBalance: Boolean; cdecl;
    function isConnected: Boolean; cdecl;
    function isExposureModeSupported(exposureMode: AVCaptureExposureMode): Boolean; cdecl;
    function isExposurePointOfInterestSupported: Boolean; cdecl;
    function isFlashModeSupported(flashMode: AVCaptureFlashMode): Boolean; cdecl;
    function isFocusModeSupported(focusMode: AVCaptureFocusMode): Boolean; cdecl;
    function isFocusPointOfInterestSupported: Boolean; cdecl;
    function isInUseByAnotherApplication: Boolean; cdecl;
    function isSuspended: Boolean; cdecl;
    function isTorchModeSupported(torchMode: AVCaptureTorchMode): Boolean; cdecl;
    function isWhiteBalanceModeSupported(whiteBalanceMode: AVCaptureWhiteBalanceMode): Boolean; cdecl;
    function linkedDevices: NSArray; cdecl;
    function localizedName: NSString; cdecl;
    function lockForConfiguration(outError: NSError): Boolean; cdecl;
    function modelID: NSString; cdecl;
    function position: AVCaptureDevicePosition; cdecl;
    procedure setActiveFormat(activeFormat: AVCaptureDeviceFormat); cdecl;
    procedure setActiveInputSource(activeInputSource: AVCaptureDeviceInputSource); cdecl;
    procedure setActiveVideoMinFrameDuration(activeVideoMinFrameDuration: CMTime); cdecl;
    procedure setExposureMode(exposureMode: AVCaptureExposureMode); cdecl;
    procedure setExposurePointOfInterest(exposurePointOfInterest: CGPoint); cdecl;
    procedure setFlashMode(flashMode: AVCaptureFlashMode); cdecl;
    procedure setFocusMode(focusMode: AVCaptureFocusMode); cdecl;
    procedure setFocusPointOfInterest(focusPointOfInterest: CGPoint); cdecl;
    procedure setTorchMode(torchMode: AVCaptureTorchMode); cdecl;
    procedure setTransportControlsPlaybackMode(mode: AVCaptureDeviceTransportControlsPlaybackMode; speed: AVCaptureDeviceTransportControlsSpeed); cdecl;
    procedure setWhiteBalanceMode(whiteBalanceMode: AVCaptureWhiteBalanceMode); cdecl;
    function supportsAVCaptureSessionPreset(preset: NSString): Boolean; cdecl;
    function torchMode: AVCaptureTorchMode; cdecl;
    function transportControlsPlaybackMode: AVCaptureDeviceTransportControlsPlaybackMode; cdecl;
    function transportControlsSpeed: AVCaptureDeviceTransportControlsSpeed; cdecl;
    function transportControlsSupported: Boolean; cdecl;
    function transportType: Integer; cdecl;
    function uniqueID: NSString; cdecl;
    procedure unlockForConfiguration; cdecl;
    function whiteBalanceMode: AVCaptureWhiteBalanceMode; cdecl;
  end;
  TAVCaptureDevice = class(TOCGenericImport<AVCaptureDeviceClass, AVCaptureDevice>)  end;

  AVVideoCompositionClass = interface(NSObjectClass)
    ['{33942A0B-6AED-41F2-8024-A5A546E63964}']
  end;
  AVVideoComposition = interface(NSObject)
    ['{6EC79EEC-9626-4AD5-B5DA-880D6189C787}']
    function animationTool: AVVideoCompositionCoreAnimationTool; cdecl;
    function frameDuration: CMTime; cdecl;
    function instructions: NSArray; cdecl;
    function renderSize: CGSize; cdecl;
  end;
  TAVVideoComposition = class(TOCGenericImport<AVVideoCompositionClass, AVVideoComposition>)  end;

  AVCaptureInputClass = interface(NSObjectClass)
    ['{2097E5B8-7DBB-4163-AEF5-F5219CDE89A0}']
  end;
  AVCaptureInput = interface(NSObject)
    ['{BA89A6A6-ABF4-484E-870A-0D46DA4F0FB9}']
    function ports: NSArray; cdecl;
  end;
  TAVCaptureInput = class(TOCGenericImport<AVCaptureInputClass, AVCaptureInput>)  end;

  AVCaptureDeviceInputSourceClass = interface(NSObjectClass)
    ['{EA35B7BE-FE2E-430A-AF83-2F6C790BA60F}']
  end;
  AVCaptureDeviceInputSource = interface(NSObject)
    ['{A8F59FC0-9CD5-4918-B948-EB49B7A65C0C}']
    function inputSourceID: NSString; cdecl;
    function localizedName: NSString; cdecl;
  end;
  TAVCaptureDeviceInputSource = class(TOCGenericImport<AVCaptureDeviceInputSourceClass, AVCaptureDeviceInputSource>)  end;

  AVPlayerLayerClass = interface(CALayerClass)
    ['{090F5E38-D228-4323-9195-AB99D99938CD}']
    {class} function playerLayerWithPlayer(player: AVPlayer): Pointer; cdecl;
  end;
  AVPlayerLayer = interface(CALayer)
    ['{D26ED910-C694-465D-BD25-5CC296BBF6B4}']
    function isReadyForDisplay: Boolean; cdecl;
    function player: AVPlayer; cdecl;
    procedure setPlayer(player: AVPlayer); cdecl;
    procedure setVideoGravity(videoGravity: NSString); cdecl;
    function videoGravity: NSString; cdecl;
  end;
  TAVPlayerLayer = class(TOCGenericImport<AVPlayerLayerClass, AVPlayerLayer>)  end;

  AVPlayerItemAccessLogEventClass = interface(NSObjectClass)
    ['{93C390A9-6319-4728-A950-57B08C50DB49}']
  end;
  AVPlayerItemAccessLogEvent = interface(NSObject)
    ['{EB79F70F-E097-4F28-AE60-25EDB31E552C}']
    function URI: NSString; cdecl;
    function durationWatched: NSTimeInterval; cdecl;
    function indicatedBitrate: double; cdecl;
    function numberOfBytesTransferred: Int64; cdecl;
    function numberOfDroppedVideoFrames: NSInteger; cdecl;
    function numberOfSegmentsDownloaded: NSInteger; cdecl;
    function numberOfServerAddressChanges: NSInteger; cdecl;
    function numberOfStalls: NSInteger; cdecl;
    function observedBitrate: double; cdecl;
    function playbackSessionID: NSString; cdecl;
    function playbackStartDate: NSDate; cdecl;
    function playbackStartOffset: NSTimeInterval; cdecl;
    function segmentsDownloadedDuration: NSTimeInterval; cdecl;
    function serverAddress: NSString; cdecl;
  end;
  TAVPlayerItemAccessLogEvent = class(TOCGenericImport<AVPlayerItemAccessLogEventClass, AVPlayerItemAccessLogEvent>)  end;

  AVMetadataItemClass = interface(NSObjectClass)
    ['{DB034D5D-086B-4D54-9528-B7220372743C}']
    {class} function metadataItemsFromArray(array_: NSArray; withKey: Pointer; keySpace: NSString): NSArray; cdecl; overload;
    {class} function metadataItemsFromArray(array_: NSArray; withLocale: NSLocale): NSArray; cdecl; overload;
  end;
  AVMetadataItem = interface(NSObject)
    ['{15ABF8E3-5360-451C-B8AE-C01F9B7F26D5}']
    function commonKey: NSString; cdecl;
    function dataValue: NSData; cdecl;
    function dateValue: NSDate; cdecl;
    function duration: CMTime; cdecl;
    function extraAttributes: NSDictionary; cdecl;
    function key: Pointer; cdecl;
    function keySpace: NSString; cdecl;
    function locale: NSLocale; cdecl;
    function numberValue: NSNumber; cdecl;
    function statusOfValueForKey(key: NSString; error: NSError): AVKeyValueStatus; cdecl;
    function stringValue: NSString; cdecl;
    function time: CMTime; cdecl;
    function value: Pointer; cdecl;
  end;
  TAVMetadataItem = class(TOCGenericImport<AVMetadataItemClass, AVMetadataItem>)  end;

  AVPlayerItemAccessLogClass = interface(NSObjectClass)
    ['{A6D04F22-8262-4CF7-ADE5-D36BA8DB7661}']
  end;
  AVPlayerItemAccessLog = interface(NSObject)
    ['{93CB32D7-8C95-49B9-865E-B9FA01E48544}']
    function events: NSArray; cdecl;
    function extendedLogData: NSData; cdecl;
    function extendedLogDataStringEncoding: NSStringEncoding; cdecl;
  end;
  TAVPlayerItemAccessLog = class(TOCGenericImport<AVPlayerItemAccessLogClass, AVPlayerItemAccessLog>)  end;

  AVPlayerClass = interface(NSObjectClass)
    ['{691E8D75-B4C8-4415-BE94-013EC8394DC6}']
    {class} function playerWithPlayerItem(item: AVPlayerItem): Pointer; cdecl;
    {class} function playerWithURL(URL: NSURL): Pointer; cdecl;
  end;
  AVPlayer = interface(NSObject)
    ['{941C8324-C5AD-431E-876C-7ED574C33825}']
    function actionAtItemEnd: AVPlayerActionAtItemEnd; cdecl;
    function currentItem: AVPlayerItem; cdecl;
    function currentTime: CMTime; cdecl;
    function error: NSError; cdecl;
    function initWithPlayerItem(item: AVPlayerItem): Pointer; cdecl;
    function initWithURL(URL: NSURL): Pointer; cdecl;
    function isClosedCaptionDisplayEnabled: Boolean; cdecl;
    function isMuted: Boolean; cdecl;
    procedure pause; cdecl;
    procedure play; cdecl;
    function rate: Single; cdecl;
    procedure removeTimeObserver(observer: Pointer); cdecl;
    procedure replaceCurrentItemWithPlayerItem(item: AVPlayerItem); cdecl;
    procedure seekToTime(time: CMTime); cdecl; overload;
    procedure seekToTime(time: CMTime; toleranceBefore: CMTime; toleranceAfter: CMTime); cdecl; overload;
    procedure setActionAtItemEnd(actionAtItemEnd: AVPlayerActionAtItemEnd); cdecl;
    procedure setClosedCaptionDisplayEnabled(closedCaptionDisplayEnabled: Boolean); cdecl;
    procedure setMuted(muted: Boolean); cdecl;
    procedure setRate(rate: Single); cdecl;
    procedure setVolume(volume: Single); cdecl;
    function status: AVPlayerStatus; cdecl;
    function volume: Single; cdecl;
  end;
  TAVPlayer = class(TOCGenericImport<AVPlayerClass, AVPlayer>)  end;

  AVPlayerItemClass = interface(NSObjectClass)
    ['{6B78CF7E-535B-460D-88FB-65A17F8B9579}']
    {class} function playerItemWithAsset(asset: AVAsset): Pointer; cdecl;
    {class} function playerItemWithURL(URL: NSURL): Pointer; cdecl;
  end;
  AVPlayerItem = interface(NSObject)
    ['{A27D597B-D7FD-4CED-BFC7-24F47B60AF9B}']
    function accessLog: AVPlayerItemAccessLog; cdecl;
    function asset: AVAsset; cdecl;
    function audioMix: AVAudioMix; cdecl;
    procedure cancelContentAuthorizationRequest; cdecl;
    procedure cancelPendingSeeks; cdecl;
    function contentAuthorizationRequestStatus: AVContentAuthorizationStatus; cdecl;
    function currentDate: NSDate; cdecl;
    function currentTime: CMTime; cdecl;
    function duration: CMTime; cdecl;
    function error: NSError; cdecl;
    function errorLog: AVPlayerItemErrorLog; cdecl;
    function forwardPlaybackEndTime: CMTime; cdecl;
    function initWithAsset(asset: AVAsset): Pointer; cdecl;
    function initWithURL(URL: NSURL): Pointer; cdecl;
    function isApplicationAuthorizedForPlayback: Boolean; cdecl;
    function isAuthorizationRequiredForPlayback: Boolean; cdecl;
    function isContentAuthorizedForPlayback: Boolean; cdecl;
    function isPlaybackBufferEmpty: Boolean; cdecl;
    function isPlaybackBufferFull: Boolean; cdecl;
    function isPlaybackLikelyToKeepUp: Boolean; cdecl;
    function loadedTimeRanges: NSArray; cdecl;
    function presentationSize: CGSize; cdecl;
    function reversePlaybackEndTime: CMTime; cdecl;
    function seekToDate(date: NSDate): Boolean; cdecl;
    procedure seekToTime(time: CMTime); cdecl; overload;
    procedure seekToTime(time: CMTime; toleranceBefore: CMTime; toleranceAfter: CMTime); cdecl; overload;
    function seekableTimeRanges: NSArray; cdecl;
    procedure setAudioMix(audioMix: AVAudioMix); cdecl;
    procedure setForwardPlaybackEndTime(forwardPlaybackEndTime: CMTime); cdecl;
    procedure setReversePlaybackEndTime(reversePlaybackEndTime: CMTime); cdecl;
    procedure setVideoComposition(videoComposition: AVVideoComposition); cdecl;
    function status: AVPlayerItemStatus; cdecl;
    procedure stepByCount(stepCount: NSInteger); cdecl;
    function timedMetadata: NSArray; cdecl;
    function tracks: NSArray; cdecl;
    function videoComposition: AVVideoComposition; cdecl;
  end;
  TAVPlayerItem = class(TOCGenericImport<AVPlayerItemClass, AVPlayerItem>)  end;

  AVPlayerItemTrackClass = interface(NSObjectClass)
    ['{8DAE6A2C-737F-4996-826A-169BE01CF594}']
  end;
  AVPlayerItemTrack = interface(NSObject)
    ['{680F9FD4-5166-4BEC-8F34-D9D08F417E79}']
    function assetTrack: AVAssetTrack; cdecl;
    function isEnabled: Boolean; cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
  end;
  TAVPlayerItemTrack = class(TOCGenericImport<AVPlayerItemTrackClass, AVPlayerItemTrack>)  end;

  AVCaptureVideoPreviewLayerClass = interface(CALayerClass)
    ['{920CF542-3D33-49F5-A88C-3E07318DEA0D}']
    {class} function layerWithSession(session: AVCaptureSession): Pointer; cdecl;
    {class} function layerWithSessionWithNoConnection(session: AVCaptureSession): Pointer; cdecl;
  end;
  AVCaptureVideoPreviewLayer = interface(CALayer)
    ['{E1EBB076-3D7C-47CA-ACC5-A669E2EBA6EB}']
    function connection: AVCaptureConnection; cdecl;
    function initWithSession(session: AVCaptureSession): Pointer; cdecl;
    function initWithSessionWithNoConnection(session: AVCaptureSession): Pointer; cdecl;
    function session: AVCaptureSession; cdecl;
    procedure setSession(session: AVCaptureSession); cdecl;
    procedure setSessionWithNoConnection(session: AVCaptureSession); cdecl;
    procedure setVideoGravity(videoGravity: NSString); cdecl;
    function videoGravity: NSString; cdecl;
  end;
  TAVCaptureVideoPreviewLayer = class(TOCGenericImport<AVCaptureVideoPreviewLayerClass, AVCaptureVideoPreviewLayer>)  end;

  AVPlayerItemErrorLogEventClass = interface(NSObjectClass)
    ['{7D27B720-04E7-4CDD-8473-4D7EC2A1CBA8}']
  end;
  AVPlayerItemErrorLogEvent = interface(NSObject)
    ['{5AC660A5-A04F-4EBB-97C2-4DD38AE3F386}']
    function URI: NSString; cdecl;
    function date: NSDate; cdecl;
    function errorComment: NSString; cdecl;
    function errorDomain: NSString; cdecl;
    function errorStatusCode: NSInteger; cdecl;
    function playbackSessionID: NSString; cdecl;
    function serverAddress: NSString; cdecl;
  end;
  TAVPlayerItemErrorLogEvent = class(TOCGenericImport<AVPlayerItemErrorLogEventClass, AVPlayerItemErrorLogEvent>)  end;

  AVFrameRateRangeClass = interface(NSObjectClass)
    ['{51C96BF2-51EC-4E25-A4CE-806D18607A5D}']
  end;
  AVFrameRateRange = interface(NSObject)
    ['{700FEF02-5332-4B8B-B608-23147D5A56CC}']
    function maxFrameDuration: CMTime; cdecl;
    function maxFrameRate: Float64; cdecl;
    function minFrameDuration: CMTime; cdecl;
    function minFrameRate: Float64; cdecl;
  end;
  TAVFrameRateRange = class(TOCGenericImport<AVFrameRateRangeClass, AVFrameRateRange>)  end;

  AVPlayerItemErrorLogClass = interface(NSObjectClass)
    ['{5C676276-2109-4D16-8672-60245A9CE9CD}']
  end;
  AVPlayerItemErrorLog = interface(NSObject)
    ['{CA870439-085F-4AE5-94E6-4E2F7E6FE4B3}']
    function events: NSArray; cdecl;
    function extendedLogData: NSData; cdecl;
    function extendedLogDataStringEncoding: NSStringEncoding; cdecl;
  end;
  TAVPlayerItemErrorLog = class(TOCGenericImport<AVPlayerItemErrorLogClass, AVPlayerItemErrorLog>)  end;

  AVCaptureConnectionClass = interface(NSObjectClass)
    ['{17021D41-6B6B-4F11-B121-39D5FEBB4579}']
    {class} function connectionWithInputPort(port: AVCaptureInputPort; videoPreviewLayer: AVCaptureVideoPreviewLayer): Pointer; cdecl;
    {class} function connectionWithInputPorts(ports: NSArray; output: AVCaptureOutput): Pointer; cdecl;
  end;
  AVCaptureConnection = interface(NSObject)
    ['{4F4BC321-39B0-4881-9F5F-DA4C720B6E1D}']
    function audioChannels: NSArray; cdecl;
    function automaticallyAdjustsVideoMirroring: Boolean; cdecl;
    function initWithInputPort(port: AVCaptureInputPort; videoPreviewLayer: AVCaptureVideoPreviewLayer): Pointer; cdecl;
    function initWithInputPorts(ports: NSArray; output: AVCaptureOutput): Pointer; cdecl;
    function inputPorts: NSArray; cdecl;
    function isActive: Boolean; cdecl;
    function isEnabled: Boolean; cdecl;
    function isVideoFieldModeSupported: Boolean; cdecl;
    function isVideoMinFrameDurationSupported: Boolean; cdecl;
    function isVideoMirrored: Boolean; cdecl;
    function isVideoMirroringSupported: Boolean; cdecl;
    function isVideoOrientationSupported: Boolean; cdecl;
    function output: AVCaptureOutput; cdecl;
    procedure setAutomaticallyAdjustsVideoMirroring(automaticallyAdjustsVideoMirroring: Boolean); cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setVideoFieldMode(videoFieldMode: AVVideoFieldMode); cdecl;
    procedure setVideoMinFrameDuration(videoMinFrameDuration: CMTime); cdecl;
    procedure setVideoMirrored(videoMirrored: Boolean); cdecl;
    procedure setVideoOrientation(videoOrientation: AVCaptureVideoOrientation); cdecl;
    function videoFieldMode: AVVideoFieldMode; cdecl;
    function videoMinFrameDuration: CMTime; cdecl;
    function videoOrientation: AVCaptureVideoOrientation; cdecl;
    function videoPreviewLayer: AVCaptureVideoPreviewLayer; cdecl;
  end;
  TAVCaptureConnection = class(TOCGenericImport<AVCaptureConnectionClass, AVCaptureConnection>)  end;

  AVAssetTrackClass = interface(NSObjectClass)
    ['{302158FA-96C5-4A4B-AC00-5AE58022F714}']
  end;
  AVAssetTrack = interface(NSObject)
    ['{5782B4EC-0DCC-476E-9951-FEB48DB8E28F}']
    function asset: AVAsset; cdecl;
    function availableMetadataFormats: NSArray; cdecl;
    function commonMetadata: NSArray; cdecl;
    function estimatedDataRate: Single; cdecl;
    function extendedLanguageTag: NSString; cdecl;
    function formatDescriptions: NSArray; cdecl;
    function hasMediaCharacteristic(mediaCharacteristic: NSString): Boolean; cdecl;
    function isEnabled: Boolean; cdecl;
    function isSelfContained: Boolean; cdecl;
    function languageCode: NSString; cdecl;
    function mediaType: NSString; cdecl;
    function metadataForFormat(format: NSString): NSArray; cdecl;
    function naturalSize: CGSize; cdecl;
    function naturalTimeScale: CMTimeScale; cdecl;
    function nominalFrameRate: Single; cdecl;
    function preferredTransform: CGAffineTransform; cdecl;
    function preferredVolume: Single; cdecl;
    function samplePresentationTimeForTrackTime(trackTime: CMTime): CMTime; cdecl;
    function segmentForTrackTime(trackTime: CMTime): AVAssetTrackSegment; cdecl;
    function segments: NSArray; cdecl;
    function timeRange: CMTimeRange; cdecl;
    function totalSampleDataLength: Int64; cdecl;
    function trackID: CMPersistentTrackID; cdecl;
  end;
  TAVAssetTrack = class(TOCGenericImport<AVAssetTrackClass, AVAssetTrack>)  end;

  AVAssetWriterClass = interface(NSObjectClass)
    ['{445CA4E3-DBF8-43C1-A24D-2A0F3B280395}']
    {class} function assetWriterWithURL(outputURL: NSURL; fileType: NSString; error: NSError): Pointer; cdecl;
  end;
  AVAssetWriter = interface(NSObject)
    ['{60566C37-0D16-47E3-A551-0AA54B47AFC2}']
    procedure addInput(input: AVAssetWriterInput); cdecl;
    function availableMediaTypes: NSArray; cdecl;
    function canAddInput(input: AVAssetWriterInput): Boolean; cdecl;
    function canApplyOutputSettings(outputSettings: NSDictionary; forMediaType: NSString): Boolean; cdecl;
    procedure cancelWriting; cdecl;
    procedure endSessionAtSourceTime(endTime: CMTime); cdecl;
    function error: NSError; cdecl;
    function finishWriting: Boolean; cdecl;
    function initWithURL(outputURL: NSURL; fileType: NSString; error: NSError): Pointer; cdecl;
    function inputs: NSArray; cdecl;
    function metadata: NSArray; cdecl;
    function movieFragmentInterval: CMTime; cdecl;
    function movieTimeScale: CMTimeScale; cdecl;
    function outputFileType: NSString; cdecl;
    function outputURL: NSURL; cdecl;
    procedure setMetadata(metadata: NSArray); cdecl;
    procedure setMovieFragmentInterval(movieFragmentInterval: CMTime); cdecl;
    procedure setMovieTimeScale(movieTimeScale: CMTimeScale); cdecl;
    procedure setShouldOptimizeForNetworkUse(shouldOptimizeForNetworkUse: Boolean); cdecl;
    function shouldOptimizeForNetworkUse: Boolean; cdecl;
    procedure startSessionAtSourceTime(startTime: CMTime); cdecl;
    function startWriting: Boolean; cdecl;
    function status: AVAssetWriterStatus; cdecl;
  end;
  TAVAssetWriter = class(TOCGenericImport<AVAssetWriterClass, AVAssetWriter>)  end;

  AVAssetTrackSegmentClass = interface(NSObjectClass)
    ['{75045BE9-5228-4913-B7EC-D1E05645CF0C}']
  end;
  AVAssetTrackSegment = interface(NSObject)
    ['{7D240EE9-332E-41F0-88CA-EBF0B720F078}']
    function isEmpty: Boolean; cdecl;
    function timeMapping: CMTimeMapping; cdecl;
  end;
  TAVAssetTrackSegment = class(TOCGenericImport<AVAssetTrackSegmentClass, AVAssetTrackSegment>)  end;

  AVAssetReaderOutputClass = interface(NSObjectClass)
    ['{FA9839EB-2C0D-464C-9D25-8190EE199750}']
  end;
  AVAssetReaderOutput = interface(NSObject)
    ['{2FDBB250-2466-49E0-BA5E-5C19EA25FC62}']
    function copyNextSampleBuffer: CMSampleBufferRef; cdecl;
    function mediaType: NSString; cdecl;
  end;
  TAVAssetReaderOutput = class(TOCGenericImport<AVAssetReaderOutputClass, AVAssetReaderOutput>)  end;

  AVAssetExportSessionClass = interface(NSObjectClass)
    ['{4C471FD3-49A2-4F27-9D9C-9BA3E6A1ED87}']
    {class} function allExportPresets: NSArray; cdecl;
    {class} function exportPresetsCompatibleWithAsset(asset: AVAsset): NSArray; cdecl;
    {class} function exportSessionWithAsset(asset: AVAsset; presetName: NSString): Pointer; cdecl;
  end;
  AVAssetExportSession = interface(NSObject)
    ['{515970BB-7FFA-4B3D-A923-8C5F72AB5B2B}']
    function audioMix: AVAudioMix; cdecl;
    procedure cancelExport; cdecl;
    function error: NSError; cdecl;
    function initWithAsset(asset: AVAsset; presetName: NSString): Pointer; cdecl;
    function metadata: NSArray; cdecl;
    function outputFileType: NSString; cdecl;
    function outputURL: NSURL; cdecl;
    function presetName: NSString; cdecl;
    function progress: Single; cdecl;
    procedure setAudioMix(audioMix: AVAudioMix); cdecl;
    procedure setMetadata(metadata: NSArray); cdecl;
    procedure setOutputFileType(outputFileType: NSString); cdecl;
    procedure setOutputURL(outputURL: NSURL); cdecl;
    procedure setShouldOptimizeForNetworkUse(shouldOptimizeForNetworkUse: Boolean); cdecl;
    procedure setTimeRange(timeRange: CMTimeRange); cdecl;
    procedure setVideoComposition(videoComposition: AVVideoComposition); cdecl;
    function shouldOptimizeForNetworkUse: Boolean; cdecl;
    function status: AVAssetExportSessionStatus; cdecl;
    function supportedFileTypes: NSArray; cdecl;
    function timeRange: CMTimeRange; cdecl;
    function videoComposition: AVVideoComposition; cdecl;
  end;
  TAVAssetExportSession = class(TOCGenericImport<AVAssetExportSessionClass, AVAssetExportSession>)  end;

  AVAssetClass = interface(NSObjectClass)
    ['{CE952542-B222-407C-9608-776841514537}']
    {class} function assetWithURL(URL: NSURL): Pointer; cdecl;
  end;
  AVAsset = interface(NSObject)
    ['{A52810C0-3D64-4F9A-BF95-C4E9BE72383C}']
    function availableChapterLocales: NSArray; cdecl;
    function availableMetadataFormats: NSArray; cdecl;
    procedure cancelLoading; cdecl;
    function chapterMetadataGroupsWithTitleLocale(locale: NSLocale; containingItemsWithCommonKeys: NSArray): NSArray; cdecl;
    function commonMetadata: NSArray; cdecl;
    function duration: CMTime; cdecl;
    function hasProtectedContent: Boolean; cdecl;
    function isComposable: Boolean; cdecl;
    function isExportable: Boolean; cdecl;
    function isPlayable: Boolean; cdecl;
    function isReadable: Boolean; cdecl;
    function lyrics: NSString; cdecl;
    function metadataForFormat(format: NSString): NSArray; cdecl;
    function naturalSize: CGSize; cdecl;
    function preferredRate: Single; cdecl;
    function preferredTransform: CGAffineTransform; cdecl;
    function preferredVolume: Single; cdecl;
    function providesPreciseDurationAndTiming: Boolean; cdecl;
    function referenceRestrictions: AVAssetReferenceRestrictions; cdecl;
    function trackWithTrackID(trackID: CMPersistentTrackID): AVAssetTrack; cdecl;
    function tracks: NSArray; cdecl;
    function tracksWithMediaCharacteristic(mediaCharacteristic: NSString): NSArray; cdecl;
    function tracksWithMediaType(mediaType: NSString): NSArray; cdecl;
    function unusedTrackID: CMPersistentTrackID; cdecl;
  end;
  TAVAsset = class(TOCGenericImport<AVAssetClass, AVAsset>)  end;

  AVAssetImageGeneratorClass = interface(NSObjectClass)
    ['{4307A647-49A6-4446-A890-4E0B1EB3F2B6}']
    {class} function assetImageGeneratorWithAsset(asset: AVAsset): Pointer; cdecl;
  end;
  AVAssetImageGenerator = interface(NSObject)
    ['{07136C3F-968C-455D-A6BB-F9E45984B152}']
    function apertureMode: NSString; cdecl;
    function appliesPreferredTrackTransform: Boolean; cdecl;
    procedure cancelAllCGImageGeneration; cdecl;
    function copyCGImageAtTime(requestedTime: CMTime; actualTime: PCMTime; error: NSError): CGImageRef; cdecl;
    procedure generateCGImagesAsynchronouslyForTimes(requestedTimes: NSArray; handler: Pointer{AVAssetImageGeneratorCompletionHandler}); cdecl;
    function initWithAsset(asset: AVAsset): Pointer; cdecl;
    function maximumSize: CGSize; cdecl;
    function requestedTimeToleranceAfter: CMTime; cdecl;
    function requestedTimeToleranceBefore: CMTime; cdecl;
    procedure setApertureMode(apertureMode: NSString); cdecl;
    procedure setAppliesPreferredTrackTransform(appliesPreferredTrackTransform: Boolean); cdecl;
    procedure setMaximumSize(maximumSize: CGSize); cdecl;
    procedure setRequestedTimeToleranceAfter(requestedTimeToleranceAfter: CMTime); cdecl;
    procedure setRequestedTimeToleranceBefore(requestedTimeToleranceBefore: CMTime); cdecl;
    procedure setVideoComposition(videoComposition: AVVideoComposition); cdecl;
    function videoComposition: AVVideoComposition; cdecl;
  end;
  TAVAssetImageGenerator = class(TOCGenericImport<AVAssetImageGeneratorClass, AVAssetImageGenerator>)  end;

  AVAssetReaderClass = interface(NSObjectClass)
    ['{36234DFD-5BC0-461C-9246-C2086ADE260E}']
    {class} function assetReaderWithAsset(asset: AVAsset; error: NSError): Pointer; cdecl;
  end;
  AVAssetReader = interface(NSObject)
    ['{E4AF11A1-5622-4452-B60E-77BF333060BE}']
    procedure addOutput(output: AVAssetReaderOutput); cdecl;
    function asset: AVAsset; cdecl;
    function canAddOutput(output: AVAssetReaderOutput): Boolean; cdecl;
    procedure cancelReading; cdecl;
    function error: NSError; cdecl;
    function initWithAsset(asset: AVAsset; error: NSError): Pointer; cdecl;
    function outputs: NSArray; cdecl;
    procedure setTimeRange(timeRange: CMTimeRange); cdecl;
    function startReading: Boolean; cdecl;
    function status: AVAssetReaderStatus; cdecl;
    function timeRange: CMTimeRange; cdecl;
  end;
  TAVAssetReader = class(TOCGenericImport<AVAssetReaderClass, AVAssetReader>)  end;

  AVCaptureAudioChannelClass = interface(NSObjectClass)
    ['{EC04C028-FC96-4ABC-B1E9-DFC9549FA794}']
  end;
  AVCaptureAudioChannel = interface(NSObject)
    ['{04242AC2-970F-4A59-8364-F1C19A92DE8A}']
    function averagePowerLevel: Single; cdecl;
    function isEnabled: Boolean; cdecl;
    function peakHoldLevel: Single; cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setVolume(volume: Single); cdecl;
    function volume: Single; cdecl;
  end;
  TAVCaptureAudioChannel = class(TOCGenericImport<AVCaptureAudioChannelClass, AVCaptureAudioChannel>)  end;

  AVAudioRecorderClass = interface(NSObjectClass)
    ['{11F957EC-EE15-4E3A-BA8A-86865F9586AA}']
  end;
  AVAudioRecorder = interface(NSObject)
    ['{7E74B886-60D9-4CDB-9A2D-B75548F5ECC0}']
    function averagePowerForChannel(channelNumber: NSUInteger): Single; cdecl;
    function currentTime: NSTimeInterval; cdecl;
    function delegate: Pointer; cdecl;
    function deleteRecording: Boolean; cdecl;
    function initWithURL(url: NSURL; settings: NSDictionary; error: NSError): Pointer; cdecl;
    function isMeteringEnabled: Boolean; cdecl;
    function isRecording: Boolean; cdecl;
    procedure pause; cdecl;
    function peakPowerForChannel(channelNumber: NSUInteger): Single; cdecl;
    function prepareToRecord: Boolean; cdecl;
    function recordForDuration(duration: NSTimeInterval): Boolean; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setMeteringEnabled(meteringEnabled: Boolean); cdecl;
    function settings: NSDictionary; cdecl;
    procedure stop; cdecl;
    procedure updateMeters; cdecl;
    function url: NSURL; cdecl;
  end;
  TAVAudioRecorder = class(TOCGenericImport<AVAudioRecorderClass, AVAudioRecorder>)  end;

  AVVideoCompositionLayerInstructionClass = interface(NSObjectClass)
    ['{510F7D4B-4F0E-4DE5-96B7-103CD9B86C3A}']
  end;
  AVVideoCompositionLayerInstruction = interface(NSObject)
    ['{872B33B2-98D9-45DD-A67A-B3FE762FF7A6}']
    function getOpacityRampForTime(time: CMTime; startOpacity: PSingle; endOpacity: PSingle; timeRange: CMTimeRange): Boolean; cdecl;
    function getTransformRampForTime(time: CMTime; startTransform: CGAffineTransform; endTransform: CGAffineTransform; timeRange: CMTimeRange): Boolean; cdecl;
    function trackID: CMPersistentTrackID; cdecl;
  end;
  TAVVideoCompositionLayerInstruction = class(TOCGenericImport<AVVideoCompositionLayerInstructionClass, AVVideoCompositionLayerInstruction>)  end;

  AVVideoCompositionCoreAnimationToolClass = interface(NSObjectClass)
    ['{E18999C1-B694-48F9-891E-1EBCAD3CC515}']
    {class} function videoCompositionCoreAnimationToolWithAdditionalLayer(layer: CALayer; asTrackID: CMPersistentTrackID): Pointer; cdecl;
    {class} function videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer(videoLayer: CALayer; inLayer: CALayer): Pointer; cdecl;
  end;
  AVVideoCompositionCoreAnimationTool = interface(NSObject)
    ['{25A0AD80-FC9A-4A67-9B26-17C1CA70F810}']
  end;
  TAVVideoCompositionCoreAnimationTool = class(TOCGenericImport<AVVideoCompositionCoreAnimationToolClass, AVVideoCompositionCoreAnimationTool>)  end;

  AVVideoCompositionInstructionClass = interface(NSObjectClass)
    ['{F297F501-E56D-492A-BE81-BAEB9F0DE5E2}']
  end;
  AVVideoCompositionInstruction = interface(NSObject)
    ['{5641777A-806B-454B-BB7B-D3450A630D5F}']
    function backgroundColor: CGColorRef; cdecl;
    function enablePostProcessing: Boolean; cdecl;
    function layerInstructions: NSArray; cdecl;
    procedure setBackgroundColor(backgroundColor: CGColorRef); cdecl;
    function timeRange: CMTimeRange; cdecl;
  end;
  TAVVideoCompositionInstruction = class(TOCGenericImport<AVVideoCompositionInstructionClass, AVVideoCompositionInstruction>)  end;

  AVAudioPlayerClass = interface(NSObjectClass)
    ['{1D3E43F8-4679-4650-8998-D4665C6E9012}']
  end;
  AVAudioPlayer = interface(NSObject)
    ['{21D2CBC4-63C7-4CA7-AB4D-CE64B5647275}']
    function averagePowerForChannel(channelNumber: NSUInteger): Single; cdecl;
    function currentTime: NSTimeInterval; cdecl;
    function data: NSData; cdecl;
    function delegate: Pointer; cdecl;
    function deviceCurrentTime: NSTimeInterval; cdecl;
    function duration: NSTimeInterval; cdecl;
    function initWithContentsOfURL(url: NSURL; error: NSError): Pointer; cdecl;
    function initWithData(data: NSData; error: NSError): Pointer; cdecl;
    function isMeteringEnabled: Boolean; cdecl;
    function isPlaying: Boolean; cdecl;
    function numberOfChannels: NSUInteger; cdecl;
    function numberOfLoops: NSInteger; cdecl;
    function pan: Single; cdecl;
    procedure pause; cdecl;
    function peakPowerForChannel(channelNumber: NSUInteger): Single; cdecl;
    function play: Boolean; cdecl;
    function playAtTime(time: NSTimeInterval): Boolean; cdecl;
    function prepareToPlay: Boolean; cdecl;
    procedure setCurrentTime(currentTime: NSTimeInterval); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setMeteringEnabled(meteringEnabled: Boolean); cdecl;
    procedure setNumberOfLoops(numberOfLoops: NSInteger); cdecl;
    procedure setPan(pan: Single); cdecl;
    procedure setVolume(volume: Single); cdecl;
    function settings: NSDictionary; cdecl;
    procedure stop; cdecl;
    procedure updateMeters; cdecl;
    function url: NSURL; cdecl;
    function volume: Single; cdecl;
  end;
  TAVAudioPlayer = class(TOCGenericImport<AVAudioPlayerClass, AVAudioPlayer>)  end;

  AVAssetWriterInputPixelBufferAdaptorClass = interface(NSObjectClass)
    ['{A79D8BCE-74D7-4EFE-A8B3-5C23951AA1D6}']
    {class} function assetWriterInputPixelBufferAdaptorWithAssetWriterInput(input: AVAssetWriterInput; sourcePixelBufferAttributes: NSDictionary): Pointer; cdecl;
  end;
  AVAssetWriterInputPixelBufferAdaptor = interface(NSObject)
    ['{034FE82B-621C-4A0C-BFB6-97125BD3B8C4}']
    function appendPixelBuffer(pixelBuffer: CVPixelBufferRef; withPresentationTime: CMTime): Boolean; cdecl;
    function assetWriterInput: AVAssetWriterInput; cdecl;
    function initWithAssetWriterInput(input: AVAssetWriterInput; sourcePixelBufferAttributes: NSDictionary): Pointer; cdecl;
    function pixelBufferPool: CVPixelBufferPoolRef; cdecl;
    function sourcePixelBufferAttributes: NSDictionary; cdecl;
  end;
  TAVAssetWriterInputPixelBufferAdaptor = class(TOCGenericImport<AVAssetWriterInputPixelBufferAdaptorClass, AVAssetWriterInputPixelBufferAdaptor>)  end;

  AVAssetWriterInputClass = interface(NSObjectClass)
    ['{10548B0A-E702-49D9-9E4A-1C724933E03F}']
    {class} function assetWriterInputWithMediaType(mediaType: NSString; outputSettings: NSDictionary): Pointer; cdecl;
  end;
  AVAssetWriterInput = interface(NSObject)
    ['{9E47C179-E1B8-4AF7-9D4A-B0A7174446E7}']
    function appendSampleBuffer(sampleBuffer: CMSampleBufferRef): Boolean; cdecl;
    function expectsMediaDataInRealTime: Boolean; cdecl;
    function initWithMediaType(mediaType: NSString; outputSettings: NSDictionary): Pointer; cdecl;
    function isReadyForMoreMediaData: Boolean; cdecl;
    procedure markAsFinished; cdecl;
    function mediaTimeScale: CMTimeScale; cdecl;
    function mediaType: NSString; cdecl;
    function metadata: NSArray; cdecl;
    function outputSettings: NSDictionary; cdecl;
    procedure setExpectsMediaDataInRealTime(expectsMediaDataInRealTime: Boolean); cdecl;
    procedure setMediaTimeScale(mediaTimeScale: CMTimeScale); cdecl;
    procedure setMetadata(metadata: NSArray); cdecl;
    procedure setTransform(transform: CGAffineTransform); cdecl;
    function transform: CGAffineTransform; cdecl;
  end;
  TAVAssetWriterInput = class(TOCGenericImport<AVAssetWriterInputClass, AVAssetWriterInput>)  end;

  AVAudioMixClass = interface(NSObjectClass)
    ['{AF7C0F46-2350-4C91-BB4C-85392E4706CB}']
  end;
  AVAudioMix = interface(NSObject)
    ['{D7843019-6352-47E5-9532-9418F697B26C}']
    function inputParameters: NSArray; cdecl;
  end;
  TAVAudioMix = class(TOCGenericImport<AVAudioMixClass, AVAudioMix>)  end;

  AVAudioMixInputParametersClass = interface(NSObjectClass)
    ['{B9DF0690-71D0-4C7B-BAFA-5B70FE7B6DE8}']
  end;
  AVAudioMixInputParameters = interface(NSObject)
    ['{E2BB064F-A712-4989-B9BD-CD472757C525}']
    function getVolumeRampForTime(time: CMTime; startVolume: PSingle; endVolume: PSingle; timeRange: CMTimeRange): Boolean; cdecl;
    function trackID: CMPersistentTrackID; cdecl;
  end;
  TAVAudioMixInputParameters = class(TOCGenericImport<AVAudioMixInputParametersClass, AVAudioMixInputParameters>)  end;

  AVMutableVideoCompositionLayerInstructionClass = interface(AVVideoCompositionLayerInstructionClass)
    ['{52779534-C63D-40E6-94F4-59291AD44EE1}']
    {class} function videoCompositionLayerInstruction: Pointer; cdecl;
    {class} function videoCompositionLayerInstructionWithAssetTrack(track: AVAssetTrack): Pointer; cdecl;
  end;
  AVMutableVideoCompositionLayerInstruction = interface(AVVideoCompositionLayerInstruction)
    ['{AF8E63C9-54F2-4B18-BA34-A47BC7098CF5}']
    procedure setOpacity(opacity: Single; atTime: CMTime); cdecl;
    procedure setOpacityRampFromStartOpacity(startOpacity: Single; toEndOpacity: Single; timeRange: CMTimeRange); cdecl;
    procedure setTrackID(trackID: CMPersistentTrackID); cdecl;
    procedure setTransform(transform: CGAffineTransform; atTime: CMTime); cdecl;
    procedure setTransformRampFromStartTransform(startTransform: CGAffineTransform; toEndTransform: CGAffineTransform; timeRange: CMTimeRange); cdecl;
    function trackID: CMPersistentTrackID; cdecl;
  end;
  TAVMutableVideoCompositionLayerInstruction = class(TOCGenericImport<AVMutableVideoCompositionLayerInstructionClass, AVMutableVideoCompositionLayerInstruction>)  end;

  AVMutableVideoCompositionInstructionClass = interface(AVVideoCompositionInstructionClass)
    ['{73851FFB-D014-49DC-886D-BC66BA072C7F}']
    {class} function videoCompositionInstruction: Pointer; cdecl;
  end;
  AVMutableVideoCompositionInstruction = interface(AVVideoCompositionInstruction)
    ['{243A4E34-1231-4F3C-A26E-2F9FB35E34CB}']
    function backgroundColor: CGColorRef; cdecl;
    function enablePostProcessing: Boolean; cdecl;
    function layerInstructions: NSArray; cdecl;
    procedure setBackgroundColor(backgroundColor: CGColorRef); cdecl;
    procedure setEnablePostProcessing(enablePostProcessing: Boolean); cdecl;
    procedure setLayerInstructions(layerInstructions: NSArray); cdecl;
    procedure setTimeRange(timeRange: CMTimeRange); cdecl;
    function timeRange: CMTimeRange; cdecl;
  end;
  TAVMutableVideoCompositionInstruction = class(TOCGenericImport<AVMutableVideoCompositionInstructionClass, AVMutableVideoCompositionInstruction>)  end;

  AVURLAssetClass = interface(AVAssetClass)
    ['{25F659C2-54FA-4F69-B353-86E057E6E953}']
    {class} function URLAssetWithURL(URL: NSURL; options: NSDictionary): Pointer; cdecl;
    {class} function audiovisualMIMETypes: NSArray; cdecl;
    {class} function audiovisualTypes: NSArray; cdecl;
    {class} function isPlayableExtendedMIMEType(extendedMIMEType: NSString): Boolean; cdecl;
  end;
  AVURLAsset = interface(AVAsset)
    ['{A4B68691-C443-4511-A88E-473E1860F3DE}']
    function URL: NSURL; cdecl;
    function compatibleTrackForCompositionTrack(compositionTrack: AVCompositionTrack): AVAssetTrack; cdecl;
    function initWithURL(URL: NSURL; options: NSDictionary): Pointer; cdecl;
  end;
  TAVURLAsset = class(TOCGenericImport<AVURLAssetClass, AVURLAsset>)  end;

  AVQueuePlayerClass = interface(AVPlayerClass)
    ['{8D04D7CB-AFD2-4E18-92B3-19602328299D}']
    {class} function queuePlayerWithItems(items: NSArray): Pointer; cdecl;
  end;
  AVQueuePlayer = interface(AVPlayer)
    ['{17187B77-EFC8-40B2-8D72-909A33E2CFEF}']
    procedure advanceToNextItem; cdecl;
    function canInsertItem(item: AVPlayerItem; afterItem: AVPlayerItem): Boolean; cdecl;
    function initWithItems(items: NSArray): Pointer; cdecl;
    procedure insertItem(item: AVPlayerItem; afterItem: AVPlayerItem); cdecl;
    function items: NSArray; cdecl;
    procedure removeAllItems; cdecl;
    procedure removeItem(item: AVPlayerItem); cdecl;
  end;
  TAVQueuePlayer = class(TOCGenericImport<AVQueuePlayerClass, AVQueuePlayer>)  end;

  AVMutableVideoCompositionClass = interface(AVVideoCompositionClass)
    ['{38CABEE6-916A-47B5-A192-CCDB4B4DEBC2}']
    {class} function videoComposition: Pointer; cdecl;
  end;
  AVMutableVideoComposition = interface(AVVideoComposition)
    ['{DE91B992-6718-4FB9-A5A8-9898816B25C9}']
    function animationTool: AVVideoCompositionCoreAnimationTool; cdecl;
    function frameDuration: CMTime; cdecl;
    function instructions: NSArray; cdecl;
    function renderSize: CGSize; cdecl;
    procedure setAnimationTool(animationTool: AVVideoCompositionCoreAnimationTool); cdecl;
    procedure setFrameDuration(frameDuration: CMTime); cdecl;
    procedure setInstructions(instructions: NSArray); cdecl;
    procedure setRenderSize(renderSize: CGSize); cdecl;
  end;
  TAVMutableVideoComposition = class(TOCGenericImport<AVMutableVideoCompositionClass, AVMutableVideoComposition>)  end;

  AVCaptureFileOutputClass = interface(AVCaptureOutputClass)
    ['{DCDBF7B2-D2DA-4474-9AB7-5ACAEE1DA2EB}']
  end;
  AVCaptureFileOutput = interface(AVCaptureOutput)
    ['{62009CD7-9AD2-4AE6-860C-4E1DC2A0A786}']
    function delegate: Pointer; cdecl;
    function isRecording: Boolean; cdecl;
    function isRecordingPaused: Boolean; cdecl;
    function maxRecordedDuration: CMTime; cdecl;
    function maxRecordedFileSize: Int64; cdecl;
    function minFreeDiskSpaceLimit: Int64; cdecl;
    function outputFileURL: NSURL; cdecl;
    procedure pauseRecording; cdecl;
    function recordedDuration: CMTime; cdecl;
    function recordedFileSize: Int64; cdecl;
    procedure resumeRecording; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setMaxRecordedDuration(maxRecordedDuration: CMTime); cdecl;
    procedure setMaxRecordedFileSize(maxRecordedFileSize: Int64); cdecl;
    procedure setMinFreeDiskSpaceLimit(minFreeDiskSpaceLimit: Int64); cdecl;
    procedure startRecordingToOutputFileURL(outputFileURL: NSURL; recordingDelegate: Pointer); cdecl;
    procedure stopRecording; cdecl;
  end;
  TAVCaptureFileOutput = class(TOCGenericImport<AVCaptureFileOutputClass, AVCaptureFileOutput>)  end;

  AVCaptureDeviceInputClass = interface(AVCaptureInputClass)
    ['{B7D833B4-8DD1-40A4-8CE4-4119F89899A3}']
    {class} function deviceInputWithDevice(device: AVCaptureDevice; error: NSError): Pointer; cdecl;
  end;
  AVCaptureDeviceInput = interface(AVCaptureInput)
    ['{FC75F5FB-4A0D-4B6F-A33F-FEA293F095AA}']
    function device: AVCaptureDevice; cdecl;
    function initWithDevice(device: AVCaptureDevice; error: NSError): Pointer; cdecl;
  end;
  TAVCaptureDeviceInput = class(TOCGenericImport<AVCaptureDeviceInputClass, AVCaptureDeviceInput>)  end;

  AVCaptureStillImageOutputClass = interface(AVCaptureOutputClass)
    ['{EC9963DF-21AD-4E3E-AF8F-9D37F2A1B85F}']
    {class} function jpegStillImageNSDataRepresentation(jpegSampleBuffer: CMSampleBufferRef): NSData; cdecl;
  end;
  AVCaptureStillImageOutput = interface(AVCaptureOutput)
    ['{B0A799C7-1B33-4769-96B9-FB0AC92101FA}']
    function availableImageDataCVPixelFormatTypes: NSArray; cdecl;
    function availableImageDataCodecTypes: NSArray; cdecl;
    function outputSettings: NSDictionary; cdecl;
    procedure setOutputSettings(outputSettings: NSDictionary); cdecl;
  end;
  TAVCaptureStillImageOutput = class(TOCGenericImport<AVCaptureStillImageOutputClass, AVCaptureStillImageOutput>)  end;

  AVCaptureScreenInputClass = interface(AVCaptureInputClass)
    ['{D24FE7E0-63CA-4639-9E27-960103CD56D9}']
  end;
  AVCaptureScreenInput = interface(AVCaptureInput)
    ['{257546AD-E27C-4709-B247-4BB3DECB5034}']
    function capturesMouseClicks: Boolean; cdecl;
    function cropRect: CGRect; cdecl;
    function initWithDisplayID(displayID: CGDirectDisplayID): Pointer; cdecl;
    function minFrameDuration: CMTime; cdecl;
    function scaleFactor: Single; cdecl;
    procedure setCapturesMouseClicks(capturesMouseClicks: Boolean); cdecl;
    procedure setCropRect(cropRect: CGRect); cdecl;
    procedure setMinFrameDuration(minFrameDuration: CMTime); cdecl;
    procedure setScaleFactor(scaleFactor: Single); cdecl;
  end;
  TAVCaptureScreenInput = class(TOCGenericImport<AVCaptureScreenInputClass, AVCaptureScreenInput>)  end;

  AVCaptureAudioPreviewOutputClass = interface(AVCaptureOutputClass)
    ['{C6773DCE-6CC7-46CA-B2D2-8404F644494E}']
  end;
  AVCaptureAudioPreviewOutput = interface(AVCaptureOutput)
    ['{59009B8D-FA46-44EB-A5B8-96A7E9E73E66}']
    function outputDeviceUniqueID: NSString; cdecl;
    procedure setOutputDeviceUniqueID(outputDeviceUniqueID: NSString); cdecl;
    procedure setVolume(volume: Single); cdecl;
    function volume: Single; cdecl;
  end;
  TAVCaptureAudioPreviewOutput = class(TOCGenericImport<AVCaptureAudioPreviewOutputClass, AVCaptureAudioPreviewOutput>)  end;

  AVAssetReaderTrackOutputClass = interface(AVAssetReaderOutputClass)
    ['{BFFA2D74-C273-41A4-BEE8-E1BBA0DC836E}']
    {class} function assetReaderTrackOutputWithTrack(track: AVAssetTrack; outputSettings: NSDictionary): Pointer; cdecl;
  end;
  AVAssetReaderTrackOutput = interface(AVAssetReaderOutput)
    ['{F54BBA0B-CE57-427E-AA15-9B06C09B8928}']
    function initWithTrack(track: AVAssetTrack; outputSettings: NSDictionary): Pointer; cdecl;
    function outputSettings: NSDictionary; cdecl;
    function track: AVAssetTrack; cdecl;
  end;
  TAVAssetReaderTrackOutput = class(TOCGenericImport<AVAssetReaderTrackOutputClass, AVAssetReaderTrackOutput>)  end;

  AVAssetReaderAudioMixOutputClass = interface(AVAssetReaderOutputClass)
    ['{389C299A-8799-4E8B-A943-5BB2B90692B3}']
    {class} function assetReaderAudioMixOutputWithAudioTracks(audioTracks: NSArray; audioSettings: NSDictionary): Pointer; cdecl;
  end;
  AVAssetReaderAudioMixOutput = interface(AVAssetReaderOutput)
    ['{6CF376D8-FF50-459A-8705-7ED821FFCAF4}']
    function audioMix: AVAudioMix; cdecl;
    function audioSettings: NSDictionary; cdecl;
    function audioTracks: NSArray; cdecl;
    function initWithAudioTracks(audioTracks: NSArray; audioSettings: NSDictionary): Pointer; cdecl;
    procedure setAudioMix(audioMix: AVAudioMix); cdecl;
  end;
  TAVAssetReaderAudioMixOutput = class(TOCGenericImport<AVAssetReaderAudioMixOutputClass, AVAssetReaderAudioMixOutput>)  end;

  AVCaptureAudioDataOutputClass = interface(AVCaptureOutputClass)
    ['{3C857CDC-598C-4481-9F2E-D121A50773E0}']
  end;
  AVCaptureAudioDataOutput = interface(AVCaptureOutput)
    ['{B369D623-0083-4719-837B-6092284B599C}']
    function audioSettings: NSDictionary; cdecl;
    function sampleBufferCallbackQueue: dispatch_queue_t; cdecl;
    function sampleBufferDelegate: Pointer; cdecl;
    procedure setAudioSettings(audioSettings: NSDictionary); cdecl;
    procedure setSampleBufferDelegate(sampleBufferDelegate: Pointer; queue: dispatch_queue_t); cdecl;
  end;
  TAVCaptureAudioDataOutput = class(TOCGenericImport<AVCaptureAudioDataOutputClass, AVCaptureAudioDataOutput>)  end;

  AVAssetReaderVideoCompositionOutputClass = interface(AVAssetReaderOutputClass)
    ['{768BB054-695D-4075-A31C-5EC1BAD1CDBE}']
    {class} function assetReaderVideoCompositionOutputWithVideoTracks(videoTracks: NSArray; videoSettings: NSDictionary): Pointer; cdecl;
  end;
  AVAssetReaderVideoCompositionOutput = interface(AVAssetReaderOutput)
    ['{557626FD-9BBE-4E87-BCB2-988C2B234658}']
    function initWithVideoTracks(videoTracks: NSArray; videoSettings: NSDictionary): Pointer; cdecl;
    procedure setVideoComposition(videoComposition: AVVideoComposition); cdecl;
    function videoComposition: AVVideoComposition; cdecl;
    function videoSettings: NSDictionary; cdecl;
    function videoTracks: NSArray; cdecl;
  end;
  TAVAssetReaderVideoCompositionOutput = class(TOCGenericImport<AVAssetReaderVideoCompositionOutputClass, AVAssetReaderVideoCompositionOutput>)  end;

  AVCaptureVideoDataOutputClass = interface(AVCaptureOutputClass)
    ['{CC77E863-9D14-4B5E-B61B-8D5B0372D8BF}']
  end;
  AVCaptureVideoDataOutput = interface(AVCaptureOutput)
    ['{8C626C87-D92C-4CB7-8A83-AF24ACAD00B1}']
    function alwaysDiscardsLateVideoFrames: Boolean; cdecl;
    function availableVideoCVPixelFormatTypes: NSArray; cdecl;
    function availableVideoCodecTypes: NSArray; cdecl;
    function sampleBufferCallbackQueue: dispatch_queue_t; cdecl;
    function sampleBufferDelegate: Pointer; cdecl;
    procedure setAlwaysDiscardsLateVideoFrames(alwaysDiscardsLateVideoFrames: Boolean); cdecl;
    procedure setSampleBufferDelegate(sampleBufferDelegate: Pointer; queue: dispatch_queue_t); cdecl;
    procedure setVideoSettings(videoSettings: NSDictionary); cdecl;
    function videoSettings: NSDictionary; cdecl;
  end;
  TAVCaptureVideoDataOutput = class(TOCGenericImport<AVCaptureVideoDataOutputClass, AVCaptureVideoDataOutput>)  end;

  AVMutableAudioMixInputParametersClass = interface(AVAudioMixInputParametersClass)
    ['{C1E81455-5556-4895-9F07-5F652A6D90D2}']
    {class} function audioMixInputParameters: Pointer; cdecl;
    {class} function audioMixInputParametersWithTrack(track: AVAssetTrack): Pointer; cdecl;
  end;
  AVMutableAudioMixInputParameters = interface(AVAudioMixInputParameters)
    ['{22932840-393A-44E3-B1E9-79658973D4FB}']
    procedure setTrackID(trackID: CMPersistentTrackID); cdecl;
    procedure setVolume(volume: Single; atTime: CMTime); cdecl;
    procedure setVolumeRampFromStartVolume(startVolume: Single; toEndVolume: Single; timeRange: CMTimeRange); cdecl;
    function trackID: CMPersistentTrackID; cdecl;
  end;
  TAVMutableAudioMixInputParameters = class(TOCGenericImport<AVMutableAudioMixInputParametersClass, AVMutableAudioMixInputParameters>)  end;

  AVMutableAudioMixClass = interface(AVAudioMixClass)
    ['{7C31FEAE-C5D9-4ED7-9619-792109261D55}']
    {class} function audioMix: Pointer; cdecl;
  end;
  AVMutableAudioMix = interface(AVAudioMix)
    ['{E895B36D-7BA2-4765-8E7F-DA726D162586}']
    function inputParameters: NSArray; cdecl;
    procedure setInputParameters(inputParameters: NSArray); cdecl;
  end;
  TAVMutableAudioMix = class(TOCGenericImport<AVMutableAudioMixClass, AVMutableAudioMix>)  end;

  AVMutableTimedMetadataGroupClass = interface(AVTimedMetadataGroupClass)
    ['{86D5EE41-070E-4EC0-9653-84788C4DBD0C}']
  end;
  AVMutableTimedMetadataGroup = interface(AVTimedMetadataGroup)
    ['{8B89626F-BC6E-4432-B999-8FEA79E8394F}']
    function items: NSArray; cdecl;
    procedure setItems(items: NSArray); cdecl;
    procedure setTimeRange(timeRange: CMTimeRange); cdecl;
    function timeRange: CMTimeRange; cdecl;
  end;
  TAVMutableTimedMetadataGroup = class(TOCGenericImport<AVMutableTimedMetadataGroupClass, AVMutableTimedMetadataGroup>)  end;

  AVMutableMetadataItemClass = interface(AVMetadataItemClass)
    ['{BB7C9E01-7C03-4D6C-A78B-CE20CBCA41C8}']
    {class} function metadataItem: Pointer; cdecl;
  end;
  AVMutableMetadataItem = interface(AVMetadataItem)
    ['{9E053DAE-CC77-46AB-8B3D-2BE5750C12B0}']
    function duration: CMTime; cdecl;
    function extraAttributes: NSDictionary; cdecl;
    function key: Pointer; cdecl;
    function keySpace: NSString; cdecl;
    function locale: NSLocale; cdecl;
    procedure setDuration(duration: CMTime); cdecl;
    procedure setExtraAttributes(extraAttributes: NSDictionary); cdecl;
    procedure setKey(key: Pointer); cdecl;
    procedure setKeySpace(keySpace: NSString); cdecl;
    procedure setLocale(locale: NSLocale); cdecl;
    procedure setTime(time: CMTime); cdecl;
    procedure setValue(value: Pointer); cdecl;
    function time: CMTime; cdecl;
    function value: Pointer; cdecl;
  end;
  TAVMutableMetadataItem = class(TOCGenericImport<AVMutableMetadataItemClass, AVMutableMetadataItem>)  end;

  AVCompositionTrackClass = interface(AVAssetTrackClass)
    ['{C7F9E3C3-12DD-4EFF-84BC-AA8E38E09D7E}']
  end;
  AVCompositionTrack = interface(AVAssetTrack)
    ['{922D8B8B-E5D6-4C01-88D9-523E8BB802D0}']
    function segments: NSArray; cdecl;
  end;
  TAVCompositionTrack = class(TOCGenericImport<AVCompositionTrackClass, AVCompositionTrack>)  end;

  AVCompositionClass = interface(AVAssetClass)
    ['{52C4DB17-5FC5-4C92-BDE0-C159C78A670D}']
  end;
  AVComposition = interface(AVAsset)
    ['{08A40D61-2174-4828-AA31-0F9FEB2F2C0C}']
    function tracks: NSArray; cdecl;
  end;
  TAVComposition = class(TOCGenericImport<AVCompositionClass, AVComposition>)  end;

  AVCompositionTrackSegmentClass = interface(AVAssetTrackSegmentClass)
    ['{8970BDF7-67C5-4893-8C5A-A93977AAB9DF}']
    {class} function compositionTrackSegmentWithTimeRange(timeRange: CMTimeRange): Pointer; cdecl;
    {class} function compositionTrackSegmentWithURL(URL: NSURL; trackID: CMPersistentTrackID; sourceTimeRange: CMTimeRange; targetTimeRange: CMTimeRange): Pointer; cdecl;
  end;
  AVCompositionTrackSegment = interface(AVAssetTrackSegment)
    ['{AA355C96-A502-4460-BF62-1F2C604D19EB}']
    function initWithTimeRange(timeRange: CMTimeRange): Pointer; cdecl;
    function initWithURL(URL: NSURL; trackID: CMPersistentTrackID; sourceTimeRange: CMTimeRange; targetTimeRange: CMTimeRange): Pointer; cdecl;
    function isEmpty: Boolean; cdecl;
    function sourceTrackID: CMPersistentTrackID; cdecl;
    function sourceURL: NSURL; cdecl;
  end;
  TAVCompositionTrackSegment = class(TOCGenericImport<AVCompositionTrackSegmentClass, AVCompositionTrackSegment>)  end;

  AVMutableCompositionTrackClass = interface(AVCompositionTrackClass)
    ['{56E8147E-64A4-41D1-8022-4FD435488F35}']
  end;
  AVMutableCompositionTrack = interface(AVCompositionTrack)
    ['{070E3CC2-A32A-4072-83EB-FC21047B16E5}']
    function extendedLanguageTag: NSString; cdecl;
    procedure insertEmptyTimeRange(timeRange: CMTimeRange); cdecl;
    function insertTimeRange(timeRange: CMTimeRange; ofTrack: AVAssetTrack; atTime: CMTime; error: NSError): Boolean; cdecl;
    function languageCode: NSString; cdecl;
    function naturalTimeScale: CMTimeScale; cdecl;
    function preferredTransform: CGAffineTransform; cdecl;
    function preferredVolume: Single; cdecl;
    procedure removeTimeRange(timeRange: CMTimeRange); cdecl;
    procedure scaleTimeRange(timeRange: CMTimeRange; toDuration: CMTime); cdecl;
    function segments: NSArray; cdecl;
    procedure setExtendedLanguageTag(extendedLanguageTag: NSString); cdecl;
    procedure setLanguageCode(languageCode: NSString); cdecl;
    procedure setNaturalTimeScale(naturalTimeScale: CMTimeScale); cdecl;
    procedure setPreferredTransform(preferredTransform: CGAffineTransform); cdecl;
    procedure setPreferredVolume(preferredVolume: Single); cdecl;
    procedure setSegments(segments: NSArray); cdecl;
    function validateTrackSegments(trackSegments: NSArray; error: NSError): Boolean; cdecl;
  end;
  TAVMutableCompositionTrack = class(TOCGenericImport<AVMutableCompositionTrackClass, AVMutableCompositionTrack>)  end;

  AVCaptureMovieFileOutputClass = interface(AVCaptureFileOutputClass)
    ['{9A6DCAB6-C5BF-4F05-8FC4-2D66E22B7923}']
  end;
  AVCaptureMovieFileOutput = interface(AVCaptureFileOutput)
    ['{B048C968-23FF-43D9-900D-16C460105762}']
    function metadata: NSArray; cdecl;
    function movieFragmentInterval: CMTime; cdecl;
    function outputSettingsForConnection(connection: AVCaptureConnection): NSDictionary; cdecl;
    procedure setMetadata(metadata: NSArray); cdecl;
    procedure setMovieFragmentInterval(movieFragmentInterval: CMTime); cdecl;
    procedure setOutputSettings(outputSettings: NSDictionary; forConnection: AVCaptureConnection); cdecl;
  end;
  TAVCaptureMovieFileOutput = class(TOCGenericImport<AVCaptureMovieFileOutputClass, AVCaptureMovieFileOutput>)  end;

  AVCaptureAudioFileOutputClass = interface(AVCaptureFileOutputClass)
    ['{3BC155FD-25C7-48ED-96FC-196F18F8B54D}']
    {class} function availableOutputFileTypes: NSArray; cdecl;
  end;
  AVCaptureAudioFileOutput = interface(AVCaptureFileOutput)
    ['{45F3E9FF-7A9D-41CC-AB0A-6357F71A618F}']
    function audioSettings: NSDictionary; cdecl;
    function metadata: NSArray; cdecl;
    procedure setAudioSettings(audioSettings: NSDictionary); cdecl;
    procedure setMetadata(metadata: NSArray); cdecl;
    procedure startRecordingToOutputFileURL(outputFileURL: NSURL; outputFileType: NSString; recordingDelegate: Pointer); cdecl;
  end;
  TAVCaptureAudioFileOutput = class(TOCGenericImport<AVCaptureAudioFileOutputClass, AVCaptureAudioFileOutput>)  end;

  AVMutableCompositionClass = interface(AVCompositionClass)
    ['{0B4D402A-8BE6-4631-AFC5-3E933BF2C538}']
    {class} function composition: Pointer; cdecl;
  end;
  AVMutableComposition = interface(AVComposition)
    ['{405EE9E5-F06F-4DEC-B82B-9CD5A372BA8D}']
    function addMutableTrackWithMediaType(mediaType: NSString; preferredTrackID: CMPersistentTrackID): AVMutableCompositionTrack; cdecl;
    procedure insertEmptyTimeRange(timeRange: CMTimeRange); cdecl;
    function insertTimeRange(timeRange: CMTimeRange; ofAsset: AVAsset; atTime: CMTime; error: NSError): Boolean; cdecl;
    function mutableTrackCompatibleWithTrack(track: AVAssetTrack): AVMutableCompositionTrack; cdecl;
    function naturalSize: CGSize; cdecl;
    procedure removeTimeRange(timeRange: CMTimeRange); cdecl;
    procedure removeTrack(track: AVCompositionTrack); cdecl;
    procedure scaleTimeRange(timeRange: CMTimeRange; toDuration: CMTime); cdecl;
    procedure setNaturalSize(naturalSize: CGSize); cdecl;
    function tracks: NSArray; cdecl;
  end;
  TAVMutableComposition = class(TOCGenericImport<AVMutableCompositionClass, AVMutableComposition>)  end;


// exported string consts

function AVMediaTypeAudio: NSString;
function AVMediaTypeVideo: NSString;

function AVCaptureSessionPresetPhoto: NSString;
function AVCaptureSessionPresetHigh: NSString;
function AVCaptureSessionPresetMedium: NSString;
function AVCaptureSessionPresetLow: NSString;

function AVFileTypeWAVE: NSString;

implementation

function AVMediaTypeAudio: NSString;
begin
  Result := CocoaNSStringConst(libAVFoundation, 'AVMediaTypeAudio');
end;

function AVMediaTypeVideo: NSString;
begin
  Result := CocoaNSStringConst(libAVFoundation, 'AVMediaTypeVideo');
end;

function AVCaptureSessionPresetPhoto: NSString;
begin
  Result := CocoaNSStringConst(libAVFoundation, 'AVCaptureSessionPresetPhoto');
end;

function AVCaptureSessionPresetHigh: NSString;
begin
  Result := CocoaNSStringConst(libAVFoundation, 'AVCaptureSessionPresetHigh');
end;

function AVCaptureSessionPresetMedium: NSString;
begin
  Result := CocoaNSStringConst(libAVFoundation, 'AVCaptureSessionPresetMedium');
end;

function AVCaptureSessionPresetLow: NSString;
begin
  Result := CocoaNSStringConst(libAVFoundation, 'AVCaptureSessionPresetLow');
end;

function AVFileTypeWAVE: NSString;
begin
  Result := CocoaNSStringConst(libAVFoundation, 'AVFileTypeWAVE');
end;



end.
