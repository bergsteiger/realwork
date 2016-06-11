{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.Media;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.GraphicsRT,
  Winapi.Media.Devices,
  Winapi.Media.MediaProperties,
  Winapi.WebRT,
  // Internal Uses...
  Winapi.Foundation.Collections,
  Winapi.Foundation,
  Winapi.Storage,
  Winapi.Devices.Enumeration,
  Winapi.Storage.Streams,
  Winapi.Globalization,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.Media Class Names
  // Windows.Media.VideoFrame
  // DualAPI
  SVideoFrame = 'Windows.Media.VideoFrame';
  // Windows.Media.AudioBuffer
  // DualAPI
  SAudioBuffer = 'Windows.Media.AudioBuffer';
  // Windows.Media.AudioFrame
  // DualAPI
  SAudioFrame = 'Windows.Media.AudioFrame';
  // Windows.Media.Audio.AudioGraph
  // DualAPI
  SAudio_AudioGraph = 'Windows.Media.Audio.AudioGraph';
  // Windows.Media.Audio.CreateAudioGraphResult
  // DualAPI
  SAudio_CreateAudioGraphResult = 'Windows.Media.Audio.CreateAudioGraphResult';
  // Windows.Media.Audio.AudioGraphSettings
  // DualAPI
  SAudio_AudioGraphSettings = 'Windows.Media.Audio.AudioGraphSettings';
  // Windows.Media.Audio.AudioDeviceInputNode
  // DualAPI
  SAudio_AudioDeviceInputNode = 'Windows.Media.Audio.AudioDeviceInputNode';
  // Windows.Media.Audio.CreateAudioDeviceInputNodeResult
  // DualAPI
  SAudio_CreateAudioDeviceInputNodeResult = 'Windows.Media.Audio.CreateAudioDeviceInputNodeResult';
  // Windows.Media.Audio.AudioDeviceOutputNode
  // DualAPI
  SAudio_AudioDeviceOutputNode = 'Windows.Media.Audio.AudioDeviceOutputNode';
  // Windows.Media.Audio.CreateAudioDeviceOutputNodeResult
  // DualAPI
  SAudio_CreateAudioDeviceOutputNodeResult = 'Windows.Media.Audio.CreateAudioDeviceOutputNodeResult';
  // Windows.Media.Audio.AudioFileInputNode
  // DualAPI
  SAudio_AudioFileInputNode = 'Windows.Media.Audio.AudioFileInputNode';
  // Windows.Media.Audio.CreateAudioFileInputNodeResult
  // DualAPI
  SAudio_CreateAudioFileInputNodeResult = 'Windows.Media.Audio.CreateAudioFileInputNodeResult';
  // Windows.Media.Audio.AudioFileOutputNode
  // DualAPI
  SAudio_AudioFileOutputNode = 'Windows.Media.Audio.AudioFileOutputNode';
  // Windows.Media.Audio.CreateAudioFileOutputNodeResult
  // DualAPI
  SAudio_CreateAudioFileOutputNodeResult = 'Windows.Media.Audio.CreateAudioFileOutputNodeResult';
  // Windows.Media.Audio.AudioGraphUnrecoverableErrorOccurredEventArgs
  // DualAPI
  SAudio_AudioGraphUnrecoverableErrorOccurredEventArgs = 'Windows.Media.Audio.AudioGraphUnrecoverableErrorOccurredEventArgs';
  // Windows.Media.Audio.AudioFrameInputNode
  // DualAPI
  SAudio_AudioFrameInputNode = 'Windows.Media.Audio.AudioFrameInputNode';
  // Windows.Media.Audio.AudioFrameOutputNode
  // DualAPI
  SAudio_AudioFrameOutputNode = 'Windows.Media.Audio.AudioFrameOutputNode';
  // Windows.Media.Audio.AudioSubmixNode
  // DualAPI
  SAudio_AudioSubmixNode = 'Windows.Media.Audio.AudioSubmixNode';
  // Windows.Media.Audio.AudioGraphConnection
  // DualAPI
  SAudio_AudioGraphConnection = 'Windows.Media.Audio.AudioGraphConnection';
  // Windows.Media.Audio.AudioFrameCompletedEventArgs
  // DualAPI
  SAudio_AudioFrameCompletedEventArgs = 'Windows.Media.Audio.AudioFrameCompletedEventArgs';
  // Windows.Media.Audio.FrameInputNodeQuantumStartedEventArgs
  // DualAPI
  SAudio_FrameInputNodeQuantumStartedEventArgs = 'Windows.Media.Audio.FrameInputNodeQuantumStartedEventArgs';
  // Windows.Media.Audio.EqualizerBand
  // DualAPI
  SAudio_EqualizerBand = 'Windows.Media.Audio.EqualizerBand';
  // Windows.Media.Audio.EqualizerEffectDefinition
  // DualAPI
  SAudio_EqualizerEffectDefinition = 'Windows.Media.Audio.EqualizerEffectDefinition';
  // Windows.Media.Audio.ReverbEffectDefinition
  // DualAPI
  SAudio_ReverbEffectDefinition = 'Windows.Media.Audio.ReverbEffectDefinition';
  // Windows.Media.Audio.EchoEffectDefinition
  // DualAPI
  SAudio_EchoEffectDefinition = 'Windows.Media.Audio.EchoEffectDefinition';
  // Windows.Media.Audio.LimiterEffectDefinition
  // DualAPI
  SAudio_LimiterEffectDefinition = 'Windows.Media.Audio.LimiterEffectDefinition';
  // Windows.Media.Casting.CastingSource
  // DualAPI
  SCasting_CastingSource = 'Windows.Media.Casting.CastingSource';
  // Windows.Media.Casting.CastingConnectionErrorOccurredEventArgs
  // DualAPI
  SCasting_CastingConnectionErrorOccurredEventArgs = 'Windows.Media.Casting.CastingConnectionErrorOccurredEventArgs';
  // Windows.Media.Casting.CastingDevice
  // DualAPI
  SCasting_CastingDevice = 'Windows.Media.Casting.CastingDevice';
  // Windows.Media.Casting.CastingConnection
  // DualAPI
  SCasting_CastingConnection = 'Windows.Media.Casting.CastingConnection';
  // Windows.Media.Casting.CastingDeviceSelectedEventArgs
  // DualAPI
  SCasting_CastingDeviceSelectedEventArgs = 'Windows.Media.Casting.CastingDeviceSelectedEventArgs';
  // Windows.Media.Casting.CastingDevicePickerFilter
  // DualAPI
  SCasting_CastingDevicePickerFilter = 'Windows.Media.Casting.CastingDevicePickerFilter';
  // Windows.Media.Casting.CastingDevicePicker
  // DualAPI
  SCasting_CastingDevicePicker = 'Windows.Media.Casting.CastingDevicePicker';
  // Windows.Media.DialProtocol.DialDeviceSelectedEventArgs
  // DualAPI
  SDialProtocol_DialDeviceSelectedEventArgs = 'Windows.Media.DialProtocol.DialDeviceSelectedEventArgs';
  // Windows.Media.DialProtocol.DialDisconnectButtonClickedEventArgs
  // DualAPI
  SDialProtocol_DialDisconnectButtonClickedEventArgs = 'Windows.Media.DialProtocol.DialDisconnectButtonClickedEventArgs';
  // Windows.Media.DialProtocol.DialDevicePickerFilter
  // DualAPI
  SDialProtocol_DialDevicePickerFilter = 'Windows.Media.DialProtocol.DialDevicePickerFilter';
  // Windows.Media.DialProtocol.DialDevicePicker
  // DualAPI
  SDialProtocol_DialDevicePicker = 'Windows.Media.DialProtocol.DialDevicePicker';
  // Windows.Media.Effects.VideoCompositorDefinition
  // DualAPI
  SEffects_VideoCompositorDefinition = 'Windows.Media.Effects.VideoCompositorDefinition';
  // Windows.Media.Editing.MediaOverlay
  // DualAPI
  SEditing_MediaOverlay = 'Windows.Media.Editing.MediaOverlay';
  // Windows.Media.Effects.CompositeVideoFrameContext
  // DualAPI
  SEffects_CompositeVideoFrameContext = 'Windows.Media.Effects.CompositeVideoFrameContext';
  // Windows.Media.Editing.MediaClip
  // DualAPI
  SEditing_MediaClip = 'Windows.Media.Editing.MediaClip';
  // Windows.Media.Editing.EmbeddedAudioTrack
  // DualAPI
  SEditing_EmbeddedAudioTrack = 'Windows.Media.Editing.EmbeddedAudioTrack';
  // Windows.Media.Editing.BackgroundAudioTrack
  // DualAPI
  SEditing_BackgroundAudioTrack = 'Windows.Media.Editing.BackgroundAudioTrack';
  // Windows.Media.Editing.MediaComposition
  // DualAPI
  SEditing_MediaComposition = 'Windows.Media.Editing.MediaComposition';
  // Windows.Media.Editing.MediaOverlayLayer
  // DualAPI
  SEditing_MediaOverlayLayer = 'Windows.Media.Editing.MediaOverlayLayer';
  // Windows.Media.Effects.AudioEffect
  // DualAPI
  SEffects_AudioEffect = 'Windows.Media.Effects.AudioEffect';
  // Windows.Media.Import.PhotoImportSource
  // DualAPI
  SImport_PhotoImportSource = 'Windows.Media.Import.PhotoImportSource';
  // Windows.Media.Import.PhotoImportOperation
  // DualAPI
  SImport_PhotoImportOperation = 'Windows.Media.Import.PhotoImportOperation';
  // Windows.Media.Import.PhotoImportManager
  // DualAPI
  SImport_PhotoImportManager = 'Windows.Media.Import.PhotoImportManager';
  // Windows.Media.Import.PhotoImportSession
  // DualAPI
  SImport_PhotoImportSession = 'Windows.Media.Import.PhotoImportSession';
  // Windows.Media.Import.PhotoImportFindItemsResult
  // DualAPI
  SImport_PhotoImportFindItemsResult = 'Windows.Media.Import.PhotoImportFindItemsResult';
  // Windows.Media.Import.PhotoImportImportItemsResult
  // DualAPI
  SImport_PhotoImportImportItemsResult = 'Windows.Media.Import.PhotoImportImportItemsResult';
  // Windows.Media.Import.PhotoImportDeleteImportedItemsFromSourceResult
  // DualAPI
  SImport_PhotoImportDeleteImportedItemsFromSourceResult = 'Windows.Media.Import.PhotoImportDeleteImportedItemsFromSourceResult';
  // Windows.Media.Import.PhotoImportStorageMedium
  // DualAPI
  SImport_PhotoImportStorageMedium = 'Windows.Media.Import.PhotoImportStorageMedium';
  // Windows.Media.Import.PhotoImportSidecar
  // DualAPI
  SImport_PhotoImportSidecar = 'Windows.Media.Import.PhotoImportSidecar';
  // Windows.Media.Import.PhotoImportVideoSegment
  // DualAPI
  SImport_PhotoImportVideoSegment = 'Windows.Media.Import.PhotoImportVideoSegment';
  // Windows.Media.Import.PhotoImportItem
  // DualAPI
  SImport_PhotoImportItem = 'Windows.Media.Import.PhotoImportItem';
  // Windows.Media.Import.PhotoImportSelectionChangedEventArgs
  // DualAPI
  SImport_PhotoImportSelectionChangedEventArgs = 'Windows.Media.Import.PhotoImportSelectionChangedEventArgs';
  // Windows.Media.Import.PhotoImportItemImportedEventArgs
  // DualAPI
  SImport_PhotoImportItemImportedEventArgs = 'Windows.Media.Import.PhotoImportItemImportedEventArgs';
  // Windows.Media.Capture.MediaCapture
  // DualAPI
  SCapture_MediaCapture = 'Windows.Media.Capture.MediaCapture';
  // Windows.Media.Capture.MediaCaptureVideoProfileMediaDescription
  // DualAPI
  SCapture_MediaCaptureVideoProfileMediaDescription = 'Windows.Media.Capture.MediaCaptureVideoProfileMediaDescription';
  // Windows.Media.Capture.MediaCaptureVideoProfile
  // DualAPI
  SCapture_MediaCaptureVideoProfile = 'Windows.Media.Capture.MediaCaptureVideoProfile';
  // Windows.Media.Capture.MediaCaptureInitializationSettings
  // DualAPI
  SCapture_MediaCaptureInitializationSettings = 'Windows.Media.Capture.MediaCaptureInitializationSettings';
  // Windows.Media.Capture.MediaCaptureSettings
  // DualAPI
  SCapture_MediaCaptureSettings = 'Windows.Media.Capture.MediaCaptureSettings';
  // Windows.Media.Capture.LowLagMediaRecording
  // DualAPI
  SCapture_LowLagMediaRecording = 'Windows.Media.Capture.LowLagMediaRecording';
  // Windows.Media.Capture.LowLagPhotoCapture
  // DualAPI
  SCapture_LowLagPhotoCapture = 'Windows.Media.Capture.LowLagPhotoCapture';
  // Windows.Media.Capture.LowLagPhotoSequenceCapture
  // DualAPI
  SCapture_LowLagPhotoSequenceCapture = 'Windows.Media.Capture.LowLagPhotoSequenceCapture';
  // Windows.Media.Capture.Core.VariablePhotoSequenceCapture
  // DualAPI
  SCapture_Core_VariablePhotoSequenceCapture = 'Windows.Media.Capture.Core.VariablePhotoSequenceCapture';
  // Windows.Media.Capture.MediaCaptureFocusChangedEventArgs
  // DualAPI
  SCapture_MediaCaptureFocusChangedEventArgs = 'Windows.Media.Capture.MediaCaptureFocusChangedEventArgs';
  // Windows.Media.Capture.PhotoConfirmationCapturedEventArgs
  // DualAPI
  SCapture_PhotoConfirmationCapturedEventArgs = 'Windows.Media.Capture.PhotoConfirmationCapturedEventArgs';
  // Windows.Media.Capture.AdvancedPhotoCapture
  // DualAPI
  SCapture_AdvancedPhotoCapture = 'Windows.Media.Capture.AdvancedPhotoCapture';
  // Windows.Media.Capture.CapturedPhoto
  // DualAPI
  SCapture_CapturedPhoto = 'Windows.Media.Capture.CapturedPhoto';
  // Windows.Media.Capture.AdvancedCapturedPhoto
  // DualAPI
  SCapture_AdvancedCapturedPhoto = 'Windows.Media.Capture.AdvancedCapturedPhoto';
  // Windows.Media.Capture.OptionalReferencePhotoCapturedEventArgs
  // DualAPI
  SCapture_OptionalReferencePhotoCapturedEventArgs = 'Windows.Media.Capture.OptionalReferencePhotoCapturedEventArgs';
  // Windows.Media.Capture.CapturedFrame
  // DualAPI
  SCapture_CapturedFrame = 'Windows.Media.Capture.CapturedFrame';
  // Windows.Media.Capture.PhotoCapturedEventArgs
  // DualAPI
  SCapture_PhotoCapturedEventArgs = 'Windows.Media.Capture.PhotoCapturedEventArgs';
  // Windows.Media.Capture.CapturedFrameControlValues
  // DualAPI
  SCapture_CapturedFrameControlValues = 'Windows.Media.Capture.CapturedFrameControlValues';
  // Windows.Media.Capture.VideoStreamConfiguration
  // DualAPI
  SCapture_VideoStreamConfiguration = 'Windows.Media.Capture.VideoStreamConfiguration';
  // Windows.Media.Capture.Core.VariablePhotoCapturedEventArgs
  // DualAPI
  SCapture_Core_VariablePhotoCapturedEventArgs = 'Windows.Media.Capture.Core.VariablePhotoCapturedEventArgs';
  // Windows.Media.VideoEffects
  // DualAPI
  SVideoEffects = 'Windows.Media.VideoEffects';
  // Windows.Media.Effects.VideoEffectDefinition
  // DualAPI
  SEffects_VideoEffectDefinition = 'Windows.Media.Effects.VideoEffectDefinition';
  // Windows.Media.Effects.AudioEffectDefinition
  // DualAPI
  SEffects_AudioEffectDefinition = 'Windows.Media.Effects.AudioEffectDefinition';
  // Windows.Media.Effects.ProcessVideoFrameContext
  // DualAPI
  SEffects_ProcessVideoFrameContext = 'Windows.Media.Effects.ProcessVideoFrameContext';
  // Windows.Media.Effects.ProcessAudioFrameContext
  // DualAPI
  SEffects_ProcessAudioFrameContext = 'Windows.Media.Effects.ProcessAudioFrameContext';
  // Windows.Media.Effects.VideoTransformEffectDefinition
  // DualAPI
  SEffects_VideoTransformEffectDefinition = 'Windows.Media.Effects.VideoTransformEffectDefinition';
  // Windows.Media.Protection.MediaProtectionPMPServer
  // DualAPI
  SProtection_MediaProtectionPMPServer = 'Windows.Media.Protection.MediaProtectionPMPServer';
  // Windows.Media.Playback.MediaPlaybackItem
  // DualAPI
  SPlayback_MediaPlaybackItem = 'Windows.Media.Playback.MediaPlaybackItem';
  // Windows.Media.Core.AudioStreamDescriptor
  // DualAPI
  SCore_AudioStreamDescriptor = 'Windows.Media.Core.AudioStreamDescriptor';
  // Windows.Media.Core.VideoStreamDescriptor
  // DualAPI
  SCore_VideoStreamDescriptor = 'Windows.Media.Core.VideoStreamDescriptor';
  // Windows.Media.Core.MediaStreamSource
  // DualAPI
  SCore_MediaStreamSource = 'Windows.Media.Core.MediaStreamSource';
  // Windows.Media.Core.MediaStreamSourceClosedEventArgs
  // DualAPI
  SCore_MediaStreamSourceClosedEventArgs = 'Windows.Media.Core.MediaStreamSourceClosedEventArgs';
  // Windows.Media.Core.MediaStreamSourceStartingEventArgs
  // DualAPI
  SCore_MediaStreamSourceStartingEventArgs = 'Windows.Media.Core.MediaStreamSourceStartingEventArgs';
  // Windows.Media.Core.MediaStreamSourceSampleRequestedEventArgs
  // DualAPI
  SCore_MediaStreamSourceSampleRequestedEventArgs = 'Windows.Media.Core.MediaStreamSourceSampleRequestedEventArgs';
  // Windows.Media.Core.MediaStreamSourceSwitchStreamsRequestedEventArgs
  // DualAPI
  SCore_MediaStreamSourceSwitchStreamsRequestedEventArgs = 'Windows.Media.Core.MediaStreamSourceSwitchStreamsRequestedEventArgs';
  // Windows.Media.Core.MediaStreamSamplePropertySet
  // DualAPI
  SCore_MediaStreamSamplePropertySet = 'Windows.Media.Core.MediaStreamSamplePropertySet';
  // Windows.Media.Core.MediaStreamSample
  // DualAPI
  SCore_MediaStreamSample = 'Windows.Media.Core.MediaStreamSample';
  // Windows.Media.Core.MediaStreamSampleProtectionProperties
  // DualAPI
  SCore_MediaStreamSampleProtectionProperties = 'Windows.Media.Core.MediaStreamSampleProtectionProperties';
  // Windows.Media.Core.MediaStreamSourceClosedRequest
  // DualAPI
  SCore_MediaStreamSourceClosedRequest = 'Windows.Media.Core.MediaStreamSourceClosedRequest';
  // Windows.Media.Core.MediaStreamSourceStartingRequestDeferral
  // DualAPI
  SCore_MediaStreamSourceStartingRequestDeferral = 'Windows.Media.Core.MediaStreamSourceStartingRequestDeferral';
  // Windows.Media.Core.MediaStreamSourceStartingRequest
  // DualAPI
  SCore_MediaStreamSourceStartingRequest = 'Windows.Media.Core.MediaStreamSourceStartingRequest';
  // Windows.Media.Core.MediaStreamSourceSampleRequestDeferral
  // DualAPI
  SCore_MediaStreamSourceSampleRequestDeferral = 'Windows.Media.Core.MediaStreamSourceSampleRequestDeferral';
  // Windows.Media.Core.MediaStreamSourceSampleRequest
  // DualAPI
  SCore_MediaStreamSourceSampleRequest = 'Windows.Media.Core.MediaStreamSourceSampleRequest';
  // Windows.Media.Core.MediaStreamSourceSwitchStreamsRequestDeferral
  // DualAPI
  SCore_MediaStreamSourceSwitchStreamsRequestDeferral = 'Windows.Media.Core.MediaStreamSourceSwitchStreamsRequestDeferral';
  // Windows.Media.Core.MediaStreamSourceSwitchStreamsRequest
  // DualAPI
  SCore_MediaStreamSourceSwitchStreamsRequest = 'Windows.Media.Core.MediaStreamSourceSwitchStreamsRequest';
  // Windows.Media.Core.MseStreamSource
  // DualAPI
  SCore_MseStreamSource = 'Windows.Media.Core.MseStreamSource';
  // Windows.Media.Core.MseSourceBufferList
  // DualAPI
  SCore_MseSourceBufferList = 'Windows.Media.Core.MseSourceBufferList';
  // Windows.Media.Core.MseSourceBuffer
  // DualAPI
  SCore_MseSourceBuffer = 'Windows.Media.Core.MseSourceBuffer';
  // Windows.Media.Transcoding.PrepareTranscodeResult
  // DualAPI
  STranscoding_PrepareTranscodeResult = 'Windows.Media.Transcoding.PrepareTranscodeResult';
  // Windows.Media.Transcoding.MediaTranscoder
  // DualAPI
  STranscoding_MediaTranscoder = 'Windows.Media.Transcoding.MediaTranscoder';
  // Windows.Media.Core.HighDynamicRangeControl
  // DualAPI
  SCore_HighDynamicRangeControl = 'Windows.Media.Core.HighDynamicRangeControl';
  // Windows.Media.Core.SceneAnalysisEffect
  // DualAPI
  SCore_SceneAnalysisEffect = 'Windows.Media.Core.SceneAnalysisEffect';
  // Windows.Media.Core.SceneAnalyzedEventArgs
  // DualAPI
  SCore_SceneAnalyzedEventArgs = 'Windows.Media.Core.SceneAnalyzedEventArgs';
  // Windows.Media.Core.HighDynamicRangeOutput
  // DualAPI
  SCore_HighDynamicRangeOutput = 'Windows.Media.Core.HighDynamicRangeOutput';
  // Windows.Media.Core.SceneAnalysisEffectFrame
  // DualAPI
  SCore_SceneAnalysisEffectFrame = 'Windows.Media.Core.SceneAnalysisEffectFrame';
  // Windows.Media.Core.SceneAnalysisEffectDefinition
  // DualAPI
  SCore_SceneAnalysisEffectDefinition = 'Windows.Media.Core.SceneAnalysisEffectDefinition';
  // Windows.Media.Core.FaceDetectionEffectFrame
  // DualAPI
  SCore_FaceDetectionEffectFrame = 'Windows.Media.Core.FaceDetectionEffectFrame';
  // Windows.Media.Core.FaceDetectedEventArgs
  // DualAPI
  SCore_FaceDetectedEventArgs = 'Windows.Media.Core.FaceDetectedEventArgs';
  // Windows.Media.Core.FaceDetectionEffect
  // DualAPI
  SCore_FaceDetectionEffect = 'Windows.Media.Core.FaceDetectionEffect';
  // Windows.Media.Core.FaceDetectionEffectDefinition
  // DualAPI
  SCore_FaceDetectionEffectDefinition = 'Windows.Media.Core.FaceDetectionEffectDefinition';
  // Windows.Media.Core.VideoStabilizationEffectEnabledChangedEventArgs
  // DualAPI
  SCore_VideoStabilizationEffectEnabledChangedEventArgs = 'Windows.Media.Core.VideoStabilizationEffectEnabledChangedEventArgs';
  // Windows.Media.Core.VideoStabilizationEffect
  // DualAPI
  SCore_VideoStabilizationEffect = 'Windows.Media.Core.VideoStabilizationEffect';
  // Windows.Media.Core.VideoStabilizationEffectDefinition
  // DualAPI
  SCore_VideoStabilizationEffectDefinition = 'Windows.Media.Core.VideoStabilizationEffectDefinition';
  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSource
  // DualAPI
  SStreaming_Adaptive_AdaptiveMediaSource = 'Windows.Media.Streaming.Adaptive.AdaptiveMediaSource';
  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceCreationResult
  // DualAPI
  SStreaming_Adaptive_AdaptiveMediaSourceCreationResult = 'Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceCreationResult';
  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadBitrateChangedEventArgs
  // DualAPI
  SStreaming_Adaptive_AdaptiveMediaSourceDownloadBitrateChangedEventArgs = 'Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadBitrateChangedEventArgs';
  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourcePlaybackBitrateChangedEventArgs
  // DualAPI
  SStreaming_Adaptive_AdaptiveMediaSourcePlaybackBitrateChangedEventArgs = 'Windows.Media.Streaming.Adaptive.AdaptiveMediaSourcePlaybackBitrateChangedEventArgs';
  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadRequestedEventArgs
  // DualAPI
  SStreaming_Adaptive_AdaptiveMediaSourceDownloadRequestedEventArgs = 'Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadRequestedEventArgs';
  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadCompletedEventArgs
  // DualAPI
  SStreaming_Adaptive_AdaptiveMediaSourceDownloadCompletedEventArgs = 'Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadCompletedEventArgs';
  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadFailedEventArgs
  // DualAPI
  SStreaming_Adaptive_AdaptiveMediaSourceDownloadFailedEventArgs = 'Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadFailedEventArgs';
  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadResult
  // DualAPI
  SStreaming_Adaptive_AdaptiveMediaSourceDownloadResult = 'Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadResult';
  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadRequestedDeferral
  // DualAPI
  SStreaming_Adaptive_AdaptiveMediaSourceDownloadRequestedDeferral = 'Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadRequestedDeferral';
  // Windows.Media.Core.MediaSourceError
  // DualAPI
  SCore_MediaSourceError = 'Windows.Media.Core.MediaSourceError';
  // Windows.Media.Core.MediaSource
  // DualAPI
  SCore_MediaSource = 'Windows.Media.Core.MediaSource';
  // Windows.Media.Core.MediaSourceOpenOperationCompletedEventArgs
  // DualAPI
  SCore_MediaSourceOpenOperationCompletedEventArgs = 'Windows.Media.Core.MediaSourceOpenOperationCompletedEventArgs';
  // Windows.Media.Core.TimedTextSource
  // DualAPI
  SCore_TimedTextSource = 'Windows.Media.Core.TimedTextSource';
  // Windows.Media.Core.TimedMetadataTrack
  // DualAPI
  SCore_TimedMetadataTrack = 'Windows.Media.Core.TimedMetadataTrack';
  // Windows.Media.Core.TimedTextRegion
  // DualAPI
  SCore_TimedTextRegion = 'Windows.Media.Core.TimedTextRegion';
  // Windows.Media.Core.TimedTextStyle
  // DualAPI
  SCore_TimedTextStyle = 'Windows.Media.Core.TimedTextStyle';
  // Windows.Media.Core.TimedTextLine
  // DualAPI
  SCore_TimedTextLine = 'Windows.Media.Core.TimedTextLine';
  // Windows.Media.Core.TimedTextSubformat
  // DualAPI
  SCore_TimedTextSubformat = 'Windows.Media.Core.TimedTextSubformat';
  // Windows.Media.Core.TimedMetadataTrackError
  // DualAPI
  SCore_TimedMetadataTrackError = 'Windows.Media.Core.TimedMetadataTrackError';
  // Windows.Media.Core.MediaCueEventArgs
  // DualAPI
  SCore_MediaCueEventArgs = 'Windows.Media.Core.MediaCueEventArgs';
  // Windows.Media.Core.TimedMetadataTrackFailedEventArgs
  // DualAPI
  SCore_TimedMetadataTrackFailedEventArgs = 'Windows.Media.Core.TimedMetadataTrackFailedEventArgs';
  // Windows.Media.Core.TimedTextSourceResolveResultEventArgs
  // DualAPI
  SCore_TimedTextSourceResolveResultEventArgs = 'Windows.Media.Core.TimedTextSourceResolveResultEventArgs';
  // Windows.Media.Core.TimedTextCue
  // DualAPI
  SCore_TimedTextCue = 'Windows.Media.Core.TimedTextCue';
  // Windows.Media.Core.DataCue
  // DualAPI
  SCore_DataCue = 'Windows.Media.Core.DataCue';
  // Windows.Media.Core.VideoTrack
  // DualAPI
  SCore_VideoTrack = 'Windows.Media.Core.VideoTrack';
  // Windows.Media.Core.AudioTrack
  // DualAPI
  SCore_AudioTrack = 'Windows.Media.Core.AudioTrack';
  // Windows.Media.Playback.MediaPlaybackAudioTrackList
  // DualAPI
  SPlayback_MediaPlaybackAudioTrackList = 'Windows.Media.Playback.MediaPlaybackAudioTrackList';
  // Windows.Media.Playback.MediaPlaybackVideoTrackList
  // DualAPI
  SPlayback_MediaPlaybackVideoTrackList = 'Windows.Media.Playback.MediaPlaybackVideoTrackList';
  // Windows.Media.Playback.MediaPlaybackTimedMetadataTrackList
  // DualAPI
  SPlayback_MediaPlaybackTimedMetadataTrackList = 'Windows.Media.Playback.MediaPlaybackTimedMetadataTrackList';
  // Windows.Media.Playback.MediaPlaybackItemError
  // DualAPI
  SPlayback_MediaPlaybackItemError = 'Windows.Media.Playback.MediaPlaybackItemError';
  // Windows.Media.Playback.MediaPlaybackList
  // DualAPI
  SPlayback_MediaPlaybackList = 'Windows.Media.Playback.MediaPlaybackList';
  // Windows.Media.Playback.MediaPlaybackItemFailedEventArgs
  // DualAPI
  SPlayback_MediaPlaybackItemFailedEventArgs = 'Windows.Media.Playback.MediaPlaybackItemFailedEventArgs';
  // Windows.Media.Playback.CurrentMediaPlaybackItemChangedEventArgs
  // DualAPI
  SPlayback_CurrentMediaPlaybackItemChangedEventArgs = 'Windows.Media.Playback.CurrentMediaPlaybackItemChangedEventArgs';
  // Windows.Media.Playback.MediaPlaybackItemOpenedEventArgs
  // DualAPI
  SPlayback_MediaPlaybackItemOpenedEventArgs = 'Windows.Media.Playback.MediaPlaybackItemOpenedEventArgs';
  // Windows.Media.Playback.TimedMetadataPresentationModeChangedEventArgs
  // DualAPI
  SPlayback_TimedMetadataPresentationModeChangedEventArgs = 'Windows.Media.Playback.TimedMetadataPresentationModeChangedEventArgs';
  // Windows.Media.Playlists.Playlist
  // DualAPI
  SPlaylists_Playlist = 'Windows.Media.Playlists.Playlist';


type
  // Forward declare interfaces
  // Windows.Media.IMediaFrame
  IMediaFrame = interface;
  PIMediaFrame = ^IMediaFrame;

  // Windows.Media.IVideoFrame
  IVideoFrame = interface;
  PIVideoFrame = ^IVideoFrame;

  // Windows.Media.IVideoFrameFactory
  IVideoFrameFactory = interface;
  PIVideoFrameFactory = ^IVideoFrameFactory;

  // Windows.Media.IAudioBuffer
  IAudioBuffer = interface;
  PIAudioBuffer = ^IAudioBuffer;

  // Windows.Media.IAudioFrame
  IAudioFrame = interface;
  PIAudioFrame = ^IAudioFrame;

  // Windows.Media.IAudioFrameFactory
  IAudioFrameFactory = interface;
  PIAudioFrameFactory = ^IAudioFrameFactory;

  // Windows.Media.Effects.IAudioEffectDefinition
  Effects_IAudioEffectDefinition = interface;
  PEffects_IAudioEffectDefinition = ^Effects_IAudioEffectDefinition;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Effects.IAudioEffectDefinition>
  IIterator_1__Effects_IAudioEffectDefinition = interface;
  PIIterator_1__Effects_IAudioEffectDefinition = ^IIterator_1__Effects_IAudioEffectDefinition;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Effects.IAudioEffectDefinition>
  IIterable_1__Effects_IAudioEffectDefinition = interface;
  PIIterable_1__Effects_IAudioEffectDefinition = ^IIterable_1__Effects_IAudioEffectDefinition;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Effects.IAudioEffectDefinition>
  IVectorView_1__Effects_IAudioEffectDefinition = interface;
  PIVectorView_1__Effects_IAudioEffectDefinition = ^IVectorView_1__Effects_IAudioEffectDefinition;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Effects.IAudioEffectDefinition>
  IVector_1__Effects_IAudioEffectDefinition = interface;
  PIVector_1__Effects_IAudioEffectDefinition = ^IVector_1__Effects_IAudioEffectDefinition;

  // Windows.Media.Audio.IAudioNode
  Audio_IAudioNode = interface;
  PAudio_IAudioNode = ^Audio_IAudioNode;

  // Windows.Media.Audio.IAudioGraphConnection
  Audio_IAudioGraphConnection = interface;
  PAudio_IAudioGraphConnection = ^Audio_IAudioGraphConnection;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Audio.IAudioGraphConnection>
  IIterator_1__Audio_IAudioGraphConnection = interface;
  PIIterator_1__Audio_IAudioGraphConnection = ^IIterator_1__Audio_IAudioGraphConnection;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Audio.IAudioGraphConnection>
  IIterable_1__Audio_IAudioGraphConnection = interface;
  PIIterable_1__Audio_IAudioGraphConnection = ^IIterable_1__Audio_IAudioGraphConnection;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Audio.IAudioGraphConnection>
  IVectorView_1__Audio_IAudioGraphConnection = interface;
  PIVectorView_1__Audio_IAudioGraphConnection = ^IVectorView_1__Audio_IAudioGraphConnection;

  // Windows.Media.Audio.IAudioInputNode
  Audio_IAudioInputNode = interface;
  PAudio_IAudioInputNode = ^Audio_IAudioInputNode;

  // Windows.Media.Audio.IAudioFrameCompletedEventArgs
  Audio_IAudioFrameCompletedEventArgs = interface;
  PAudio_IAudioFrameCompletedEventArgs = ^Audio_IAudioFrameCompletedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Audio.IAudioFrameInputNode,Windows.Media.Audio.IAudioFrameCompletedEventArgs>
  TypedEventHandler_2__Audio_IAudioFrameInputNode__Audio_IAudioFrameCompletedEventArgs = interface;
  PTypedEventHandler_2__Audio_IAudioFrameInputNode__Audio_IAudioFrameCompletedEventArgs = ^TypedEventHandler_2__Audio_IAudioFrameInputNode__Audio_IAudioFrameCompletedEventArgs;

  // Windows.Media.Audio.IFrameInputNodeQuantumStartedEventArgs
  Audio_IFrameInputNodeQuantumStartedEventArgs = interface;
  PAudio_IFrameInputNodeQuantumStartedEventArgs = ^Audio_IFrameInputNodeQuantumStartedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Audio.IAudioFrameInputNode,Windows.Media.Audio.IFrameInputNodeQuantumStartedEventArgs>
  TypedEventHandler_2__Audio_IAudioFrameInputNode__Audio_IFrameInputNodeQuantumStartedEventArgs = interface;
  PTypedEventHandler_2__Audio_IAudioFrameInputNode__Audio_IFrameInputNodeQuantumStartedEventArgs = ^TypedEventHandler_2__Audio_IAudioFrameInputNode__Audio_IFrameInputNodeQuantumStartedEventArgs;

  // Windows.Media.Audio.IAudioFrameInputNode
  Audio_IAudioFrameInputNode = interface;
  PAudio_IAudioFrameInputNode = ^Audio_IAudioFrameInputNode;

  // Windows.Media.Audio.IAudioDeviceInputNode
  Audio_IAudioDeviceInputNode = interface;
  PAudio_IAudioDeviceInputNode = ^Audio_IAudioDeviceInputNode;

  // Windows.Media.Audio.ICreateAudioDeviceInputNodeResult
  Audio_ICreateAudioDeviceInputNodeResult = interface;
  PAudio_ICreateAudioDeviceInputNodeResult = ^Audio_ICreateAudioDeviceInputNodeResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Audio.ICreateAudioDeviceInputNodeResult>
  AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceInputNodeResult = interface;
  PAsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceInputNodeResult = ^AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceInputNodeResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Audio.ICreateAudioDeviceInputNodeResult>
  IAsyncOperation_1__Audio_ICreateAudioDeviceInputNodeResult = interface;
  PIAsyncOperation_1__Audio_ICreateAudioDeviceInputNodeResult = ^IAsyncOperation_1__Audio_ICreateAudioDeviceInputNodeResult;

  // Windows.Media.Audio.IAudioFrameOutputNode
  Audio_IAudioFrameOutputNode = interface;
  PAudio_IAudioFrameOutputNode = ^Audio_IAudioFrameOutputNode;

  // Windows.Media.Audio.IAudioDeviceOutputNode
  Audio_IAudioDeviceOutputNode = interface;
  PAudio_IAudioDeviceOutputNode = ^Audio_IAudioDeviceOutputNode;

  // Windows.Media.Audio.ICreateAudioDeviceOutputNodeResult
  Audio_ICreateAudioDeviceOutputNodeResult = interface;
  PAudio_ICreateAudioDeviceOutputNodeResult = ^Audio_ICreateAudioDeviceOutputNodeResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Audio.ICreateAudioDeviceOutputNodeResult>
  AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceOutputNodeResult = interface;
  PAsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceOutputNodeResult = ^AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceOutputNodeResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Audio.ICreateAudioDeviceOutputNodeResult>
  IAsyncOperation_1__Audio_ICreateAudioDeviceOutputNodeResult = interface;
  PIAsyncOperation_1__Audio_ICreateAudioDeviceOutputNodeResult = ^IAsyncOperation_1__Audio_ICreateAudioDeviceOutputNodeResult;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Audio.IAudioFileInputNode,Object>
  TypedEventHandler_2__Audio_IAudioFileInputNode__IInspectable = interface;
  PTypedEventHandler_2__Audio_IAudioFileInputNode__IInspectable = ^TypedEventHandler_2__Audio_IAudioFileInputNode__IInspectable;

  // Windows.Media.Audio.IAudioFileInputNode
  Audio_IAudioFileInputNode = interface;
  PAudio_IAudioFileInputNode = ^Audio_IAudioFileInputNode;

  // Windows.Media.Audio.ICreateAudioFileInputNodeResult
  Audio_ICreateAudioFileInputNodeResult = interface;
  PAudio_ICreateAudioFileInputNodeResult = ^Audio_ICreateAudioFileInputNodeResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Audio.ICreateAudioFileInputNodeResult>
  AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileInputNodeResult = interface;
  PAsyncOperationCompletedHandler_1__Audio_ICreateAudioFileInputNodeResult = ^AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileInputNodeResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Audio.ICreateAudioFileInputNodeResult>
  IAsyncOperation_1__Audio_ICreateAudioFileInputNodeResult = interface;
  PIAsyncOperation_1__Audio_ICreateAudioFileInputNodeResult = ^IAsyncOperation_1__Audio_ICreateAudioFileInputNodeResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Transcoding.TranscodeFailureReason>
  AsyncOperationCompletedHandler_1__Transcoding_TranscodeFailureReason = interface;
  PAsyncOperationCompletedHandler_1__Transcoding_TranscodeFailureReason = ^AsyncOperationCompletedHandler_1__Transcoding_TranscodeFailureReason;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Transcoding.TranscodeFailureReason>
  IAsyncOperation_1__Transcoding_TranscodeFailureReason = interface;
  PIAsyncOperation_1__Transcoding_TranscodeFailureReason = ^IAsyncOperation_1__Transcoding_TranscodeFailureReason;

  // Windows.Media.Audio.IAudioFileOutputNode
  Audio_IAudioFileOutputNode = interface;
  PAudio_IAudioFileOutputNode = ^Audio_IAudioFileOutputNode;

  // Windows.Media.Audio.ICreateAudioFileOutputNodeResult
  Audio_ICreateAudioFileOutputNodeResult = interface;
  PAudio_ICreateAudioFileOutputNodeResult = ^Audio_ICreateAudioFileOutputNodeResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Audio.ICreateAudioFileOutputNodeResult>
  AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileOutputNodeResult = interface;
  PAsyncOperationCompletedHandler_1__Audio_ICreateAudioFileOutputNodeResult = ^AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileOutputNodeResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Audio.ICreateAudioFileOutputNodeResult>
  IAsyncOperation_1__Audio_ICreateAudioFileOutputNodeResult = interface;
  PIAsyncOperation_1__Audio_ICreateAudioFileOutputNodeResult = ^IAsyncOperation_1__Audio_ICreateAudioFileOutputNodeResult;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Audio.IAudioGraph,Object>
  TypedEventHandler_2__Audio_IAudioGraph__IInspectable = interface;
  PTypedEventHandler_2__Audio_IAudioGraph__IInspectable = ^TypedEventHandler_2__Audio_IAudioGraph__IInspectable;

  // Windows.Media.Audio.IAudioGraphUnrecoverableErrorOccurredEventArgs
  Audio_IAudioGraphUnrecoverableErrorOccurredEventArgs = interface;
  PAudio_IAudioGraphUnrecoverableErrorOccurredEventArgs = ^Audio_IAudioGraphUnrecoverableErrorOccurredEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Audio.IAudioGraph,Windows.Media.Audio.IAudioGraphUnrecoverableErrorOccurredEventArgs>
  TypedEventHandler_2__Audio_IAudioGraph__Audio_IAudioGraphUnrecoverableErrorOccurredEventArgs = interface;
  PTypedEventHandler_2__Audio_IAudioGraph__Audio_IAudioGraphUnrecoverableErrorOccurredEventArgs = ^TypedEventHandler_2__Audio_IAudioGraph__Audio_IAudioGraphUnrecoverableErrorOccurredEventArgs;

  // Windows.Media.Audio.IAudioGraph
  Audio_IAudioGraph = interface;
  PAudio_IAudioGraph = ^Audio_IAudioGraph;

  // Windows.Media.Audio.ICreateAudioGraphResult
  Audio_ICreateAudioGraphResult = interface;
  PAudio_ICreateAudioGraphResult = ^Audio_ICreateAudioGraphResult;

  // Windows.Media.Audio.IAudioGraphSettings
  Audio_IAudioGraphSettings = interface;
  PAudio_IAudioGraphSettings = ^Audio_IAudioGraphSettings;

  // Windows.Media.Audio.IAudioGraphSettingsFactory
  Audio_IAudioGraphSettingsFactory = interface;
  PAudio_IAudioGraphSettingsFactory = ^Audio_IAudioGraphSettingsFactory;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Audio.ICreateAudioGraphResult>
  AsyncOperationCompletedHandler_1__Audio_ICreateAudioGraphResult = interface;
  PAsyncOperationCompletedHandler_1__Audio_ICreateAudioGraphResult = ^AsyncOperationCompletedHandler_1__Audio_ICreateAudioGraphResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Audio.ICreateAudioGraphResult>
  IAsyncOperation_1__Audio_ICreateAudioGraphResult = interface;
  PIAsyncOperation_1__Audio_ICreateAudioGraphResult = ^IAsyncOperation_1__Audio_ICreateAudioGraphResult;

  // Windows.Media.Audio.IAudioGraphStatics
  Audio_IAudioGraphStatics = interface;
  PAudio_IAudioGraphStatics = ^Audio_IAudioGraphStatics;

  // Windows.Media.Audio.IEqualizerBand
  Audio_IEqualizerBand = interface;
  PAudio_IEqualizerBand = ^Audio_IEqualizerBand;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Audio.IEqualizerBand>
  IIterator_1__Audio_IEqualizerBand = interface;
  PIIterator_1__Audio_IEqualizerBand = ^IIterator_1__Audio_IEqualizerBand;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Audio.IEqualizerBand>
  IIterable_1__Audio_IEqualizerBand = interface;
  PIIterable_1__Audio_IEqualizerBand = ^IIterable_1__Audio_IEqualizerBand;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Audio.IEqualizerBand>
  IVectorView_1__Audio_IEqualizerBand = interface;
  PIVectorView_1__Audio_IEqualizerBand = ^IVectorView_1__Audio_IEqualizerBand;

  // Windows.Media.Audio.IEqualizerEffectDefinition
  Audio_IEqualizerEffectDefinition = interface;
  PAudio_IEqualizerEffectDefinition = ^Audio_IEqualizerEffectDefinition;

  // Windows.Media.Audio.IEqualizerEffectDefinitionFactory
  Audio_IEqualizerEffectDefinitionFactory = interface;
  PAudio_IEqualizerEffectDefinitionFactory = ^Audio_IEqualizerEffectDefinitionFactory;

  // Windows.Media.Audio.IReverbEffectDefinition
  Audio_IReverbEffectDefinition = interface;
  PAudio_IReverbEffectDefinition = ^Audio_IReverbEffectDefinition;

  // Windows.Media.Audio.IReverbEffectDefinitionFactory
  Audio_IReverbEffectDefinitionFactory = interface;
  PAudio_IReverbEffectDefinitionFactory = ^Audio_IReverbEffectDefinitionFactory;

  // Windows.Media.Audio.IEchoEffectDefinition
  Audio_IEchoEffectDefinition = interface;
  PAudio_IEchoEffectDefinition = ^Audio_IEchoEffectDefinition;

  // Windows.Media.Audio.IEchoEffectDefinitionFactory
  Audio_IEchoEffectDefinitionFactory = interface;
  PAudio_IEchoEffectDefinitionFactory = ^Audio_IEchoEffectDefinitionFactory;

  // Windows.Media.Audio.ILimiterEffectDefinition
  Audio_ILimiterEffectDefinition = interface;
  PAudio_ILimiterEffectDefinition = ^Audio_ILimiterEffectDefinition;

  // Windows.Media.Audio.ILimiterEffectDefinitionFactory
  Audio_ILimiterEffectDefinitionFactory = interface;
  PAudio_ILimiterEffectDefinitionFactory = ^Audio_ILimiterEffectDefinitionFactory;

  // Windows.Media.Casting.ICastingSource
  Casting_ICastingSource = interface;
  PCasting_ICastingSource = ^Casting_ICastingSource;

  // Windows.Media.Casting.ICastingConnectionErrorOccurredEventArgs
  Casting_ICastingConnectionErrorOccurredEventArgs = interface;
  PCasting_ICastingConnectionErrorOccurredEventArgs = ^Casting_ICastingConnectionErrorOccurredEventArgs;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Casting.CastingPlaybackTypes>
  AsyncOperationCompletedHandler_1__Casting_CastingPlaybackTypes = interface;
  PAsyncOperationCompletedHandler_1__Casting_CastingPlaybackTypes = ^AsyncOperationCompletedHandler_1__Casting_CastingPlaybackTypes;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Casting.CastingPlaybackTypes>
  IAsyncOperation_1__Casting_CastingPlaybackTypes = interface;
  PIAsyncOperation_1__Casting_CastingPlaybackTypes = ^IAsyncOperation_1__Casting_CastingPlaybackTypes;

  // Windows.Media.Casting.ICastingDevice
  Casting_ICastingDevice = interface;
  PCasting_ICastingDevice = ^Casting_ICastingDevice;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Casting.ICastingConnection,Object>
  TypedEventHandler_2__Casting_ICastingConnection__IInspectable = interface;
  PTypedEventHandler_2__Casting_ICastingConnection__IInspectable = ^TypedEventHandler_2__Casting_ICastingConnection__IInspectable;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Casting.ICastingConnection,Windows.Media.Casting.ICastingConnectionErrorOccurredEventArgs>
  TypedEventHandler_2__Casting_ICastingConnection__Casting_ICastingConnectionErrorOccurredEventArgs = interface;
  PTypedEventHandler_2__Casting_ICastingConnection__Casting_ICastingConnectionErrorOccurredEventArgs = ^TypedEventHandler_2__Casting_ICastingConnection__Casting_ICastingConnectionErrorOccurredEventArgs;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Casting.CastingConnectionErrorStatus>
  AsyncOperationCompletedHandler_1__Casting_CastingConnectionErrorStatus = interface;
  PAsyncOperationCompletedHandler_1__Casting_CastingConnectionErrorStatus = ^AsyncOperationCompletedHandler_1__Casting_CastingConnectionErrorStatus;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Casting.CastingConnectionErrorStatus>
  IAsyncOperation_1__Casting_CastingConnectionErrorStatus = interface;
  PIAsyncOperation_1__Casting_CastingConnectionErrorStatus = ^IAsyncOperation_1__Casting_CastingConnectionErrorStatus;

  // Windows.Media.Casting.ICastingConnection
  Casting_ICastingConnection = interface;
  PCasting_ICastingConnection = ^Casting_ICastingConnection;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Casting.ICastingDevice>
  AsyncOperationCompletedHandler_1__Casting_ICastingDevice = interface;
  PAsyncOperationCompletedHandler_1__Casting_ICastingDevice = ^AsyncOperationCompletedHandler_1__Casting_ICastingDevice;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Casting.ICastingDevice>
  IAsyncOperation_1__Casting_ICastingDevice = interface;
  PIAsyncOperation_1__Casting_ICastingDevice = ^IAsyncOperation_1__Casting_ICastingDevice;

  // Windows.Media.Casting.ICastingDeviceStatics
  Casting_ICastingDeviceStatics = interface;
  PCasting_ICastingDeviceStatics = ^Casting_ICastingDeviceStatics;

  // Windows.Media.Casting.ICastingDeviceSelectedEventArgs
  Casting_ICastingDeviceSelectedEventArgs = interface;
  PCasting_ICastingDeviceSelectedEventArgs = ^Casting_ICastingDeviceSelectedEventArgs;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Casting.ICastingSource>
  IIterator_1__Casting_ICastingSource = interface;
  PIIterator_1__Casting_ICastingSource = ^IIterator_1__Casting_ICastingSource;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Casting.ICastingSource>
  IIterable_1__Casting_ICastingSource = interface;
  PIIterable_1__Casting_ICastingSource = ^IIterable_1__Casting_ICastingSource;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Casting.ICastingSource>
  IVectorView_1__Casting_ICastingSource = interface;
  PIVectorView_1__Casting_ICastingSource = ^IVectorView_1__Casting_ICastingSource;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Casting.ICastingSource>
  IVector_1__Casting_ICastingSource = interface;
  PIVector_1__Casting_ICastingSource = ^IVector_1__Casting_ICastingSource;

  // Windows.Media.Casting.ICastingDevicePickerFilter
  Casting_ICastingDevicePickerFilter = interface;
  PCasting_ICastingDevicePickerFilter = ^Casting_ICastingDevicePickerFilter;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Casting.ICastingDevicePicker,Windows.Media.Casting.ICastingDeviceSelectedEventArgs>
  TypedEventHandler_2__Casting_ICastingDevicePicker__Casting_ICastingDeviceSelectedEventArgs = interface;
  PTypedEventHandler_2__Casting_ICastingDevicePicker__Casting_ICastingDeviceSelectedEventArgs = ^TypedEventHandler_2__Casting_ICastingDevicePicker__Casting_ICastingDeviceSelectedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Casting.ICastingDevicePicker,Object>
  TypedEventHandler_2__Casting_ICastingDevicePicker__IInspectable = interface;
  PTypedEventHandler_2__Casting_ICastingDevicePicker__IInspectable = ^TypedEventHandler_2__Casting_ICastingDevicePicker__IInspectable;

  // Windows.Media.Casting.ICastingDevicePicker
  Casting_ICastingDevicePicker = interface;
  PCasting_ICastingDevicePicker = ^Casting_ICastingDevicePicker;

  // Windows.Media.DialProtocol.IDialAppStateDetails
  DialProtocol_IDialAppStateDetails = interface;
  PDialProtocol_IDialAppStateDetails = ^DialProtocol_IDialAppStateDetails;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.DialProtocol.DialAppLaunchResult>
  AsyncOperationCompletedHandler_1__DialProtocol_DialAppLaunchResult = interface;
  PAsyncOperationCompletedHandler_1__DialProtocol_DialAppLaunchResult = ^AsyncOperationCompletedHandler_1__DialProtocol_DialAppLaunchResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.DialProtocol.DialAppLaunchResult>
  IAsyncOperation_1__DialProtocol_DialAppLaunchResult = interface;
  PIAsyncOperation_1__DialProtocol_DialAppLaunchResult = ^IAsyncOperation_1__DialProtocol_DialAppLaunchResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.DialProtocol.DialAppStopResult>
  AsyncOperationCompletedHandler_1__DialProtocol_DialAppStopResult = interface;
  PAsyncOperationCompletedHandler_1__DialProtocol_DialAppStopResult = ^AsyncOperationCompletedHandler_1__DialProtocol_DialAppStopResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.DialProtocol.DialAppStopResult>
  IAsyncOperation_1__DialProtocol_DialAppStopResult = interface;
  PIAsyncOperation_1__DialProtocol_DialAppStopResult = ^IAsyncOperation_1__DialProtocol_DialAppStopResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.DialProtocol.IDialAppStateDetails>
  AsyncOperationCompletedHandler_1__DialProtocol_IDialAppStateDetails = interface;
  PAsyncOperationCompletedHandler_1__DialProtocol_IDialAppStateDetails = ^AsyncOperationCompletedHandler_1__DialProtocol_IDialAppStateDetails;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.DialProtocol.IDialAppStateDetails>
  IAsyncOperation_1__DialProtocol_IDialAppStateDetails = interface;
  PIAsyncOperation_1__DialProtocol_IDialAppStateDetails = ^IAsyncOperation_1__DialProtocol_IDialAppStateDetails;

  // Windows.Media.DialProtocol.IDialApp
  DialProtocol_IDialApp = interface;
  PDialProtocol_IDialApp = ^DialProtocol_IDialApp;

  // Windows.Media.DialProtocol.IDialDevice
  DialProtocol_IDialDevice = interface;
  PDialProtocol_IDialDevice = ^DialProtocol_IDialDevice;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.DialProtocol.IDialDevice>
  AsyncOperationCompletedHandler_1__DialProtocol_IDialDevice = interface;
  PAsyncOperationCompletedHandler_1__DialProtocol_IDialDevice = ^AsyncOperationCompletedHandler_1__DialProtocol_IDialDevice;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.DialProtocol.IDialDevice>
  IAsyncOperation_1__DialProtocol_IDialDevice = interface;
  PIAsyncOperation_1__DialProtocol_IDialDevice = ^IAsyncOperation_1__DialProtocol_IDialDevice;

  // Windows.Media.DialProtocol.IDialDeviceSelectedEventArgs
  DialProtocol_IDialDeviceSelectedEventArgs = interface;
  PDialProtocol_IDialDeviceSelectedEventArgs = ^DialProtocol_IDialDeviceSelectedEventArgs;

  // Windows.Media.DialProtocol.IDialDisconnectButtonClickedEventArgs
  DialProtocol_IDialDisconnectButtonClickedEventArgs = interface;
  PDialProtocol_IDialDisconnectButtonClickedEventArgs = ^DialProtocol_IDialDisconnectButtonClickedEventArgs;

  // Windows.Media.DialProtocol.IDialDevicePickerFilter
  DialProtocol_IDialDevicePickerFilter = interface;
  PDialProtocol_IDialDevicePickerFilter = ^DialProtocol_IDialDevicePickerFilter;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.DialProtocol.IDialDevicePicker,Windows.Media.DialProtocol.IDialDeviceSelectedEventArgs>
  TypedEventHandler_2__DialProtocol_IDialDevicePicker__DialProtocol_IDialDeviceSelectedEventArgs = interface;
  PTypedEventHandler_2__DialProtocol_IDialDevicePicker__DialProtocol_IDialDeviceSelectedEventArgs = ^TypedEventHandler_2__DialProtocol_IDialDevicePicker__DialProtocol_IDialDeviceSelectedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.DialProtocol.IDialDevicePicker,Windows.Media.DialProtocol.IDialDisconnectButtonClickedEventArgs>
  TypedEventHandler_2__DialProtocol_IDialDevicePicker__DialProtocol_IDialDisconnectButtonClickedEventArgs = interface;
  PTypedEventHandler_2__DialProtocol_IDialDevicePicker__DialProtocol_IDialDisconnectButtonClickedEventArgs = ^TypedEventHandler_2__DialProtocol_IDialDevicePicker__DialProtocol_IDialDisconnectButtonClickedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.DialProtocol.IDialDevicePicker,Object>
  TypedEventHandler_2__DialProtocol_IDialDevicePicker__IInspectable = interface;
  PTypedEventHandler_2__DialProtocol_IDialDevicePicker__IInspectable = ^TypedEventHandler_2__DialProtocol_IDialDevicePicker__IInspectable;

  // Windows.Media.DialProtocol.IDialDevicePicker
  DialProtocol_IDialDevicePicker = interface;
  PDialProtocol_IDialDevicePicker = ^DialProtocol_IDialDevicePicker;

  // Windows.Media.Effects.IVideoCompositorDefinition
  Effects_IVideoCompositorDefinition = interface;
  PEffects_IVideoCompositorDefinition = ^Effects_IVideoCompositorDefinition;

  // Windows.Media.Effects.IVideoCompositorDefinitionFactory
  Effects_IVideoCompositorDefinitionFactory = interface;
  PEffects_IVideoCompositorDefinitionFactory = ^Effects_IVideoCompositorDefinitionFactory;

  // Windows.Media.Editing.IEmbeddedAudioTrack
  Editing_IEmbeddedAudioTrack = interface;
  PEditing_IEmbeddedAudioTrack = ^Editing_IEmbeddedAudioTrack;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Editing.IEmbeddedAudioTrack>
  IIterator_1__Editing_IEmbeddedAudioTrack = interface;
  PIIterator_1__Editing_IEmbeddedAudioTrack = ^IIterator_1__Editing_IEmbeddedAudioTrack;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Editing.IEmbeddedAudioTrack>
  IIterable_1__Editing_IEmbeddedAudioTrack = interface;
  PIIterable_1__Editing_IEmbeddedAudioTrack = ^IIterable_1__Editing_IEmbeddedAudioTrack;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Editing.IEmbeddedAudioTrack>
  IVectorView_1__Editing_IEmbeddedAudioTrack = interface;
  PIVectorView_1__Editing_IEmbeddedAudioTrack = ^IVectorView_1__Editing_IEmbeddedAudioTrack;

  // Windows.Media.Effects.IVideoEffectDefinition
  Effects_IVideoEffectDefinition = interface;
  PEffects_IVideoEffectDefinition = ^Effects_IVideoEffectDefinition;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Effects.IVideoEffectDefinition>
  IIterator_1__Effects_IVideoEffectDefinition = interface;
  PIIterator_1__Effects_IVideoEffectDefinition = ^IIterator_1__Effects_IVideoEffectDefinition;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Effects.IVideoEffectDefinition>
  IIterable_1__Effects_IVideoEffectDefinition = interface;
  PIIterable_1__Effects_IVideoEffectDefinition = ^IIterable_1__Effects_IVideoEffectDefinition;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Effects.IVideoEffectDefinition>
  IVectorView_1__Effects_IVideoEffectDefinition = interface;
  PIVectorView_1__Effects_IVideoEffectDefinition = ^IVectorView_1__Effects_IVideoEffectDefinition;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Effects.IVideoEffectDefinition>
  IVector_1__Effects_IVideoEffectDefinition = interface;
  PIVector_1__Effects_IVideoEffectDefinition = ^IVector_1__Effects_IVideoEffectDefinition;

  // Windows.Media.Editing.IMediaClip
  Editing_IMediaClip = interface;
  PEditing_IMediaClip = ^Editing_IMediaClip;

  // Windows.Media.Editing.IMediaOverlay
  Editing_IMediaOverlay = interface;
  PEditing_IMediaOverlay = ^Editing_IMediaOverlay;

  // Windows.Media.Effects.ICompositeVideoFrameContext
  Effects_ICompositeVideoFrameContext = interface;
  PEffects_ICompositeVideoFrameContext = ^Effects_ICompositeVideoFrameContext;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Editing.IMediaClip>
  IIterator_1__Editing_IMediaClip = interface;
  PIIterator_1__Editing_IMediaClip = ^IIterator_1__Editing_IMediaClip;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Editing.IMediaClip>
  IIterable_1__Editing_IMediaClip = interface;
  PIIterable_1__Editing_IMediaClip = ^IIterable_1__Editing_IMediaClip;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Editing.IMediaClip>
  IVectorView_1__Editing_IMediaClip = interface;
  PIVectorView_1__Editing_IMediaClip = ^IVectorView_1__Editing_IMediaClip;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Editing.IMediaClip>
  IVector_1__Editing_IMediaClip = interface;
  PIVector_1__Editing_IMediaClip = ^IVector_1__Editing_IMediaClip;

  // Windows.Media.Editing.IBackgroundAudioTrack
  Editing_IBackgroundAudioTrack = interface;
  PEditing_IBackgroundAudioTrack = ^Editing_IBackgroundAudioTrack;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Editing.IBackgroundAudioTrack>
  IIterator_1__Editing_IBackgroundAudioTrack = interface;
  PIIterator_1__Editing_IBackgroundAudioTrack = ^IIterator_1__Editing_IBackgroundAudioTrack;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Editing.IBackgroundAudioTrack>
  IIterable_1__Editing_IBackgroundAudioTrack = interface;
  PIIterable_1__Editing_IBackgroundAudioTrack = ^IIterable_1__Editing_IBackgroundAudioTrack;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Editing.IBackgroundAudioTrack>
  IVectorView_1__Editing_IBackgroundAudioTrack = interface;
  PIVectorView_1__Editing_IBackgroundAudioTrack = ^IVectorView_1__Editing_IBackgroundAudioTrack;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Editing.IBackgroundAudioTrack>
  IVector_1__Editing_IBackgroundAudioTrack = interface;
  PIVector_1__Editing_IBackgroundAudioTrack = ^IVector_1__Editing_IBackgroundAudioTrack;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Media.Transcoding.TranscodeFailureReason,Double>
  AsyncOperationProgressHandler_2__Transcoding_TranscodeFailureReason__Double = interface;
  PAsyncOperationProgressHandler_2__Transcoding_TranscodeFailureReason__Double = ^AsyncOperationProgressHandler_2__Transcoding_TranscodeFailureReason__Double;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Media.Transcoding.TranscodeFailureReason,Double>
  AsyncOperationWithProgressCompletedHandler_2__Transcoding_TranscodeFailureReason__Double = interface;
  PAsyncOperationWithProgressCompletedHandler_2__Transcoding_TranscodeFailureReason__Double = ^AsyncOperationWithProgressCompletedHandler_2__Transcoding_TranscodeFailureReason__Double;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Media.Transcoding.TranscodeFailureReason,Double>
  IAsyncOperationWithProgress_2__Transcoding_TranscodeFailureReason__Double = interface;
  PIAsyncOperationWithProgress_2__Transcoding_TranscodeFailureReason__Double = ^IAsyncOperationWithProgress_2__Transcoding_TranscodeFailureReason__Double;

  // Windows.Media.Core.IMediaSource
  Core_IMediaSource = interface;
  PCore_IMediaSource = ^Core_IMediaSource;

  // Windows.Media.Core.IMediaStreamSourceClosedRequest
  Core_IMediaStreamSourceClosedRequest = interface;
  PCore_IMediaStreamSourceClosedRequest = ^Core_IMediaStreamSourceClosedRequest;

  // Windows.Media.Core.IMediaStreamSourceClosedEventArgs
  Core_IMediaStreamSourceClosedEventArgs = interface;
  PCore_IMediaStreamSourceClosedEventArgs = ^Core_IMediaStreamSourceClosedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSource,Windows.Media.Core.IMediaStreamSourceClosedEventArgs>
  TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceClosedEventArgs = interface;
  PTypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceClosedEventArgs = ^TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceClosedEventArgs;

  // Windows.Media.Core.IMediaStreamSourceStartingRequestDeferral
  Core_IMediaStreamSourceStartingRequestDeferral = interface;
  PCore_IMediaStreamSourceStartingRequestDeferral = ^Core_IMediaStreamSourceStartingRequestDeferral;

  // Windows.Media.Core.IMediaStreamSourceStartingRequest
  Core_IMediaStreamSourceStartingRequest = interface;
  PCore_IMediaStreamSourceStartingRequest = ^Core_IMediaStreamSourceStartingRequest;

  // Windows.Media.Core.IMediaStreamSourceStartingEventArgs
  Core_IMediaStreamSourceStartingEventArgs = interface;
  PCore_IMediaStreamSourceStartingEventArgs = ^Core_IMediaStreamSourceStartingEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSource,Windows.Media.Core.IMediaStreamSourceStartingEventArgs>
  TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceStartingEventArgs = interface;
  PTypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceStartingEventArgs = ^TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceStartingEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSource,Object>
  TypedEventHandler_2__Core_IMediaStreamSource__IInspectable = interface;
  PTypedEventHandler_2__Core_IMediaStreamSource__IInspectable = ^TypedEventHandler_2__Core_IMediaStreamSource__IInspectable;

  // Windows.Media.Core.IMediaStreamDescriptor
  Core_IMediaStreamDescriptor = interface;
  PCore_IMediaStreamDescriptor = ^Core_IMediaStreamDescriptor;

  // Windows.Media.Core.IMediaStreamSourceSampleRequestDeferral
  Core_IMediaStreamSourceSampleRequestDeferral = interface;
  PCore_IMediaStreamSourceSampleRequestDeferral = ^Core_IMediaStreamSourceSampleRequestDeferral;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSample,Object>
  TypedEventHandler_2__Core_IMediaStreamSample__IInspectable = interface;
  PTypedEventHandler_2__Core_IMediaStreamSample__IInspectable = ^TypedEventHandler_2__Core_IMediaStreamSample__IInspectable;

  // Windows.Media.Core.IMediaStreamSampleProtectionProperties
  Core_IMediaStreamSampleProtectionProperties = interface;
  PCore_IMediaStreamSampleProtectionProperties = ^Core_IMediaStreamSampleProtectionProperties;

  // Windows.Media.Core.IMediaStreamSample
  Core_IMediaStreamSample = interface;
  PCore_IMediaStreamSample = ^Core_IMediaStreamSample;

  // Windows.Media.Core.IMediaStreamSourceSampleRequest
  Core_IMediaStreamSourceSampleRequest = interface;
  PCore_IMediaStreamSourceSampleRequest = ^Core_IMediaStreamSourceSampleRequest;

  // Windows.Media.Core.IMediaStreamSourceSampleRequestedEventArgs
  Core_IMediaStreamSourceSampleRequestedEventArgs = interface;
  PCore_IMediaStreamSourceSampleRequestedEventArgs = ^Core_IMediaStreamSourceSampleRequestedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSource,Windows.Media.Core.IMediaStreamSourceSampleRequestedEventArgs>
  TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceSampleRequestedEventArgs = interface;
  PTypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceSampleRequestedEventArgs = ^TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceSampleRequestedEventArgs;

  // Windows.Media.Core.IMediaStreamSourceSwitchStreamsRequestDeferral
  Core_IMediaStreamSourceSwitchStreamsRequestDeferral = interface;
  PCore_IMediaStreamSourceSwitchStreamsRequestDeferral = ^Core_IMediaStreamSourceSwitchStreamsRequestDeferral;

  // Windows.Media.Core.IMediaStreamSourceSwitchStreamsRequest
  Core_IMediaStreamSourceSwitchStreamsRequest = interface;
  PCore_IMediaStreamSourceSwitchStreamsRequest = ^Core_IMediaStreamSourceSwitchStreamsRequest;

  // Windows.Media.Core.IMediaStreamSourceSwitchStreamsRequestedEventArgs
  Core_IMediaStreamSourceSwitchStreamsRequestedEventArgs = interface;
  PCore_IMediaStreamSourceSwitchStreamsRequestedEventArgs = ^Core_IMediaStreamSourceSwitchStreamsRequestedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSource,Windows.Media.Core.IMediaStreamSourceSwitchStreamsRequestedEventArgs>
  TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceSwitchStreamsRequestedEventArgs = interface;
  PTypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceSwitchStreamsRequestedEventArgs = ^TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceSwitchStreamsRequestedEventArgs;

  // Windows.Media.Protection.IMediaProtectionServiceRequest
  Protection_IMediaProtectionServiceRequest = interface;
  PProtection_IMediaProtectionServiceRequest = ^Protection_IMediaProtectionServiceRequest;

  // Windows.Media.Protection.IMediaProtectionServiceCompletion
  Protection_IMediaProtectionServiceCompletion = interface;
  PProtection_IMediaProtectionServiceCompletion = ^Protection_IMediaProtectionServiceCompletion;

  // Windows.Media.Protection.IServiceRequestedEventArgs
  Protection_IServiceRequestedEventArgs = interface;
  PProtection_IServiceRequestedEventArgs = ^Protection_IServiceRequestedEventArgs;

  // Windows.Media.Protection.ServiceRequestedEventHandler
  Protection_ServiceRequestedEventHandler = interface;
  PProtection_ServiceRequestedEventHandler = ^Protection_ServiceRequestedEventHandler;

  // Windows.Media.Protection.RebootNeededEventHandler
  Protection_RebootNeededEventHandler = interface;
  PProtection_RebootNeededEventHandler = ^Protection_RebootNeededEventHandler;

  // Windows.Media.Protection.IRevocationAndRenewalItem
  Protection_IRevocationAndRenewalItem = interface;
  PProtection_IRevocationAndRenewalItem = ^Protection_IRevocationAndRenewalItem;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Protection.IRevocationAndRenewalItem>
  IIterator_1__Protection_IRevocationAndRenewalItem = interface;
  PIIterator_1__Protection_IRevocationAndRenewalItem = ^IIterator_1__Protection_IRevocationAndRenewalItem;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Protection.IRevocationAndRenewalItem>
  IIterable_1__Protection_IRevocationAndRenewalItem = interface;
  PIIterable_1__Protection_IRevocationAndRenewalItem = ^IIterable_1__Protection_IRevocationAndRenewalItem;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Protection.IRevocationAndRenewalItem>
  IVectorView_1__Protection_IRevocationAndRenewalItem = interface;
  PIVectorView_1__Protection_IRevocationAndRenewalItem = ^IVectorView_1__Protection_IRevocationAndRenewalItem;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Protection.IRevocationAndRenewalItem>
  IVector_1__Protection_IRevocationAndRenewalItem = interface;
  PIVector_1__Protection_IRevocationAndRenewalItem = ^IVector_1__Protection_IRevocationAndRenewalItem;

  // Windows.Media.Protection.IRevocationAndRenewalInformation
  Protection_IRevocationAndRenewalInformation = interface;
  PProtection_IRevocationAndRenewalInformation = ^Protection_IRevocationAndRenewalInformation;

  // Windows.Media.Protection.IComponentLoadFailedEventArgs
  Protection_IComponentLoadFailedEventArgs = interface;
  PProtection_IComponentLoadFailedEventArgs = ^Protection_IComponentLoadFailedEventArgs;

  // Windows.Media.Protection.ComponentLoadFailedEventHandler
  Protection_ComponentLoadFailedEventHandler = interface;
  PProtection_ComponentLoadFailedEventHandler = ^Protection_ComponentLoadFailedEventHandler;

  // Windows.Media.Protection.IMediaProtectionManager
  Protection_IMediaProtectionManager = interface;
  PProtection_IMediaProtectionManager = ^Protection_IMediaProtectionManager;

  // Windows.Media.Core.IMediaStreamSource
  Core_IMediaStreamSource = interface;
  PCore_IMediaStreamSource = ^Core_IMediaStreamSource;

  // Windows.Media.Editing.IMediaComposition
  Editing_IMediaComposition = interface;
  PEditing_IMediaComposition = ^Editing_IMediaComposition;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Editing.IMediaClip>
  AsyncOperationCompletedHandler_1__Editing_IMediaClip = interface;
  PAsyncOperationCompletedHandler_1__Editing_IMediaClip = ^AsyncOperationCompletedHandler_1__Editing_IMediaClip;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Editing.IMediaClip>
  IAsyncOperation_1__Editing_IMediaClip = interface;
  PIAsyncOperation_1__Editing_IMediaClip = ^IAsyncOperation_1__Editing_IMediaClip;

  // Windows.Media.Editing.IMediaClipStatics
  Editing_IMediaClipStatics = interface;
  PEditing_IMediaClipStatics = ^Editing_IMediaClipStatics;

  // Windows.Media.Editing.IMediaClipStatics2
  Editing_IMediaClipStatics2 = interface;
  PEditing_IMediaClipStatics2 = ^Editing_IMediaClipStatics2;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Editing.IMediaComposition>
  AsyncOperationCompletedHandler_1__Editing_IMediaComposition = interface;
  PAsyncOperationCompletedHandler_1__Editing_IMediaComposition = ^AsyncOperationCompletedHandler_1__Editing_IMediaComposition;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Editing.IMediaComposition>
  IAsyncOperation_1__Editing_IMediaComposition = interface;
  PIAsyncOperation_1__Editing_IMediaComposition = ^IAsyncOperation_1__Editing_IMediaComposition;

  // Windows.Media.Editing.IMediaCompositionStatics
  Editing_IMediaCompositionStatics = interface;
  PEditing_IMediaCompositionStatics = ^Editing_IMediaCompositionStatics;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Editing.IBackgroundAudioTrack>
  AsyncOperationCompletedHandler_1__Editing_IBackgroundAudioTrack = interface;
  PAsyncOperationCompletedHandler_1__Editing_IBackgroundAudioTrack = ^AsyncOperationCompletedHandler_1__Editing_IBackgroundAudioTrack;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Editing.IBackgroundAudioTrack>
  IAsyncOperation_1__Editing_IBackgroundAudioTrack = interface;
  PIAsyncOperation_1__Editing_IBackgroundAudioTrack = ^IAsyncOperation_1__Editing_IBackgroundAudioTrack;

  // Windows.Media.Editing.IBackgroundAudioTrackStatics
  Editing_IBackgroundAudioTrackStatics = interface;
  PEditing_IBackgroundAudioTrackStatics = ^Editing_IBackgroundAudioTrackStatics;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Editing.IMediaOverlay>
  IIterator_1__Editing_IMediaOverlay = interface;
  PIIterator_1__Editing_IMediaOverlay = ^IIterator_1__Editing_IMediaOverlay;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Editing.IMediaOverlay>
  IIterable_1__Editing_IMediaOverlay = interface;
  PIIterable_1__Editing_IMediaOverlay = ^IIterable_1__Editing_IMediaOverlay;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Editing.IMediaOverlay>
  IVectorView_1__Editing_IMediaOverlay = interface;
  PIVectorView_1__Editing_IMediaOverlay = ^IVectorView_1__Editing_IMediaOverlay;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Editing.IMediaOverlay>
  IVector_1__Editing_IMediaOverlay = interface;
  PIVector_1__Editing_IMediaOverlay = ^IVector_1__Editing_IMediaOverlay;

  // Windows.Media.Editing.IMediaOverlayLayer
  Editing_IMediaOverlayLayer = interface;
  PEditing_IMediaOverlayLayer = ^Editing_IMediaOverlayLayer;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Editing.IMediaOverlayLayer>
  IIterator_1__Editing_IMediaOverlayLayer = interface;
  PIIterator_1__Editing_IMediaOverlayLayer = ^IIterator_1__Editing_IMediaOverlayLayer;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Editing.IMediaOverlayLayer>
  IIterable_1__Editing_IMediaOverlayLayer = interface;
  PIIterable_1__Editing_IMediaOverlayLayer = ^IIterable_1__Editing_IMediaOverlayLayer;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Editing.IMediaOverlayLayer>
  IVectorView_1__Editing_IMediaOverlayLayer = interface;
  PIVectorView_1__Editing_IMediaOverlayLayer = ^IVectorView_1__Editing_IMediaOverlayLayer;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Editing.IMediaOverlayLayer>
  IVector_1__Editing_IMediaOverlayLayer = interface;
  PIVector_1__Editing_IMediaOverlayLayer = ^IVector_1__Editing_IMediaOverlayLayer;

  // Windows.Media.Editing.IMediaComposition2
  Editing_IMediaComposition2 = interface;
  PEditing_IMediaComposition2 = ^Editing_IMediaComposition2;

  // Windows.Media.Editing.IMediaOverlayFactory
  Editing_IMediaOverlayFactory = interface;
  PEditing_IMediaOverlayFactory = ^Editing_IMediaOverlayFactory;

  // Windows.Media.Editing.IMediaOverlayLayerFactory
  Editing_IMediaOverlayLayerFactory = interface;
  PEditing_IMediaOverlayLayerFactory = ^Editing_IMediaOverlayLayerFactory;

  // Windows.Media.Effects.IAudioEffect
  Effects_IAudioEffect = interface;
  PEffects_IAudioEffect = ^Effects_IAudioEffect;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Effects.IAudioEffect>
  IIterator_1__Effects_IAudioEffect = interface;
  PIIterator_1__Effects_IAudioEffect = ^IIterator_1__Effects_IAudioEffect;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Effects.IAudioEffect>
  IIterable_1__Effects_IAudioEffect = interface;
  PIIterable_1__Effects_IAudioEffect = ^IIterable_1__Effects_IAudioEffect;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Effects.IAudioEffect>
  IVectorView_1__Effects_IAudioEffect = interface;
  PIVectorView_1__Effects_IAudioEffect = ^IVectorView_1__Effects_IAudioEffect;

  // Windows.Media.FaceAnalysis.IDetectedFace
  FaceAnalysis_IDetectedFace = interface;
  PFaceAnalysis_IDetectedFace = ^FaceAnalysis_IDetectedFace;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.FaceAnalysis.IDetectedFace>
  IIterator_1__FaceAnalysis_IDetectedFace = interface;
  PIIterator_1__FaceAnalysis_IDetectedFace = ^IIterator_1__FaceAnalysis_IDetectedFace;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.FaceAnalysis.IDetectedFace>
  IIterable_1__FaceAnalysis_IDetectedFace = interface;
  PIIterable_1__FaceAnalysis_IDetectedFace = ^IIterable_1__FaceAnalysis_IDetectedFace;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.FaceAnalysis.IDetectedFace>
  IVectorView_1__FaceAnalysis_IDetectedFace = interface;
  PIVectorView_1__FaceAnalysis_IDetectedFace = ^IVectorView_1__FaceAnalysis_IDetectedFace;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.FaceAnalysis.IDetectedFace>
  IVector_1__FaceAnalysis_IDetectedFace = interface;
  PIVector_1__FaceAnalysis_IDetectedFace = ^IVector_1__FaceAnalysis_IDetectedFace;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVector`1<Windows.Media.FaceAnalysis.IDetectedFace>>
  AsyncOperationCompletedHandler_1__IVector_1__FaceAnalysis_IDetectedFace = interface;
  PAsyncOperationCompletedHandler_1__IVector_1__FaceAnalysis_IDetectedFace = ^AsyncOperationCompletedHandler_1__IVector_1__FaceAnalysis_IDetectedFace;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVector`1<Windows.Media.FaceAnalysis.IDetectedFace>>
  IAsyncOperation_1__IVector_1__FaceAnalysis_IDetectedFace = interface;
  PIAsyncOperation_1__IVector_1__FaceAnalysis_IDetectedFace = ^IAsyncOperation_1__IVector_1__FaceAnalysis_IDetectedFace;

  // Windows.Media.Import.IPhotoImportStorageMedium
  Import_IPhotoImportStorageMedium = interface;
  PImport_IPhotoImportStorageMedium = ^Import_IPhotoImportStorageMedium;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Import.IPhotoImportStorageMedium>
  IIterator_1__Import_IPhotoImportStorageMedium = interface;
  PIIterator_1__Import_IPhotoImportStorageMedium = ^IIterator_1__Import_IPhotoImportStorageMedium;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Import.IPhotoImportStorageMedium>
  IIterable_1__Import_IPhotoImportStorageMedium = interface;
  PIIterable_1__Import_IPhotoImportStorageMedium = ^IIterable_1__Import_IPhotoImportStorageMedium;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportStorageMedium>
  IVectorView_1__Import_IPhotoImportStorageMedium = interface;
  PIVectorView_1__Import_IPhotoImportStorageMedium = ^IVectorView_1__Import_IPhotoImportStorageMedium;

  // Windows.Media.Import.IPhotoImportSidecar
  Import_IPhotoImportSidecar = interface;
  PImport_IPhotoImportSidecar = ^Import_IPhotoImportSidecar;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Import.IPhotoImportSidecar>
  IIterator_1__Import_IPhotoImportSidecar = interface;
  PIIterator_1__Import_IPhotoImportSidecar = ^IIterator_1__Import_IPhotoImportSidecar;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Import.IPhotoImportSidecar>
  IIterable_1__Import_IPhotoImportSidecar = interface;
  PIIterable_1__Import_IPhotoImportSidecar = ^IIterable_1__Import_IPhotoImportSidecar;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportSidecar>
  IVectorView_1__Import_IPhotoImportSidecar = interface;
  PIVectorView_1__Import_IPhotoImportSidecar = ^IVectorView_1__Import_IPhotoImportSidecar;

  // Windows.Media.Import.IPhotoImportVideoSegment
  Import_IPhotoImportVideoSegment = interface;
  PImport_IPhotoImportVideoSegment = ^Import_IPhotoImportVideoSegment;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Import.IPhotoImportVideoSegment>
  IIterator_1__Import_IPhotoImportVideoSegment = interface;
  PIIterator_1__Import_IPhotoImportVideoSegment = ^IIterator_1__Import_IPhotoImportVideoSegment;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Import.IPhotoImportVideoSegment>
  IIterable_1__Import_IPhotoImportVideoSegment = interface;
  PIIterable_1__Import_IPhotoImportVideoSegment = ^IIterable_1__Import_IPhotoImportVideoSegment;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportVideoSegment>
  IVectorView_1__Import_IPhotoImportVideoSegment = interface;
  PIVectorView_1__Import_IPhotoImportVideoSegment = ^IVectorView_1__Import_IPhotoImportVideoSegment;

  // Windows.Media.Import.IPhotoImportItem
  Import_IPhotoImportItem = interface;
  PImport_IPhotoImportItem = ^Import_IPhotoImportItem;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Import.IPhotoImportItem>
  IIterator_1__Import_IPhotoImportItem = interface;
  PIIterator_1__Import_IPhotoImportItem = ^IIterator_1__Import_IPhotoImportItem;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Import.IPhotoImportItem>
  IIterable_1__Import_IPhotoImportItem = interface;
  PIIterable_1__Import_IPhotoImportItem = ^IIterable_1__Import_IPhotoImportItem;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportItem>
  IVectorView_1__Import_IPhotoImportItem = interface;
  PIVectorView_1__Import_IPhotoImportItem = ^IVectorView_1__Import_IPhotoImportItem;

  // Windows.Media.Import.IPhotoImportSelectionChangedEventArgs
  Import_IPhotoImportSelectionChangedEventArgs = interface;
  PImport_IPhotoImportSelectionChangedEventArgs = ^Import_IPhotoImportSelectionChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Import.IPhotoImportFindItemsResult,Windows.Media.Import.IPhotoImportSelectionChangedEventArgs>
  TypedEventHandler_2__Import_IPhotoImportFindItemsResult__Import_IPhotoImportSelectionChangedEventArgs = interface;
  PTypedEventHandler_2__Import_IPhotoImportFindItemsResult__Import_IPhotoImportSelectionChangedEventArgs = ^TypedEventHandler_2__Import_IPhotoImportFindItemsResult__Import_IPhotoImportSelectionChangedEventArgs;

  // Windows.Media.Import.IPhotoImportDeleteImportedItemsFromSourceResult
  Import_IPhotoImportDeleteImportedItemsFromSourceResult = interface;
  PImport_IPhotoImportDeleteImportedItemsFromSourceResult = ^Import_IPhotoImportDeleteImportedItemsFromSourceResult;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Media.Import.IPhotoImportDeleteImportedItemsFromSourceResult,Double>
  AsyncOperationProgressHandler_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double = interface;
  PAsyncOperationProgressHandler_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double = ^AsyncOperationProgressHandler_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Media.Import.IPhotoImportDeleteImportedItemsFromSourceResult,Double>
  AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double = interface;
  PAsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double = ^AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Media.Import.IPhotoImportDeleteImportedItemsFromSourceResult,Double>
  IAsyncOperationWithProgress_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double = interface;
  PIAsyncOperationWithProgress_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double = ^IAsyncOperationWithProgress_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double;

  // Windows.Media.Import.IPhotoImportImportItemsResult
  Import_IPhotoImportImportItemsResult = interface;
  PImport_IPhotoImportImportItemsResult = ^Import_IPhotoImportImportItemsResult;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Media.Import.IPhotoImportImportItemsResult,Windows.Media.Import.PhotoImportProgress>
  AsyncOperationProgressHandler_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress = interface;
  PAsyncOperationProgressHandler_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress = ^AsyncOperationProgressHandler_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Media.Import.IPhotoImportImportItemsResult,Windows.Media.Import.PhotoImportProgress>
  AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress = interface;
  PAsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress = ^AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Media.Import.IPhotoImportImportItemsResult,Windows.Media.Import.PhotoImportProgress>
  IAsyncOperationWithProgress_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress = interface;
  PIAsyncOperationWithProgress_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress = ^IAsyncOperationWithProgress_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress;

  // Windows.Media.Import.IPhotoImportItemImportedEventArgs
  Import_IPhotoImportItemImportedEventArgs = interface;
  PImport_IPhotoImportItemImportedEventArgs = ^Import_IPhotoImportItemImportedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Import.IPhotoImportFindItemsResult,Windows.Media.Import.IPhotoImportItemImportedEventArgs>
  TypedEventHandler_2__Import_IPhotoImportFindItemsResult__Import_IPhotoImportItemImportedEventArgs = interface;
  PTypedEventHandler_2__Import_IPhotoImportFindItemsResult__Import_IPhotoImportItemImportedEventArgs = ^TypedEventHandler_2__Import_IPhotoImportFindItemsResult__Import_IPhotoImportItemImportedEventArgs;

  // Windows.Media.Import.IPhotoImportFindItemsResult
  Import_IPhotoImportFindItemsResult = interface;
  PImport_IPhotoImportFindItemsResult = ^Import_IPhotoImportFindItemsResult;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Media.Import.IPhotoImportFindItemsResult,UInt32>
  AsyncOperationProgressHandler_2__Import_IPhotoImportFindItemsResult__Cardinal = interface;
  PAsyncOperationProgressHandler_2__Import_IPhotoImportFindItemsResult__Cardinal = ^AsyncOperationProgressHandler_2__Import_IPhotoImportFindItemsResult__Cardinal;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Media.Import.IPhotoImportFindItemsResult,UInt32>
  AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportFindItemsResult__Cardinal = interface;
  PAsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportFindItemsResult__Cardinal = ^AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportFindItemsResult__Cardinal;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Media.Import.IPhotoImportFindItemsResult,UInt32>
  IAsyncOperationWithProgress_2__Import_IPhotoImportFindItemsResult__Cardinal = interface;
  PIAsyncOperationWithProgress_2__Import_IPhotoImportFindItemsResult__Cardinal = ^IAsyncOperationWithProgress_2__Import_IPhotoImportFindItemsResult__Cardinal;

  // Windows.Media.Import.IPhotoImportSession
  Import_IPhotoImportSession = interface;
  PImport_IPhotoImportSession = ^Import_IPhotoImportSession;

  // Windows.Media.Import.IPhotoImportSource
  Import_IPhotoImportSource = interface;
  PImport_IPhotoImportSource = ^Import_IPhotoImportSource;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Import.IPhotoImportSource>
  IIterator_1__Import_IPhotoImportSource = interface;
  PIIterator_1__Import_IPhotoImportSource = ^IIterator_1__Import_IPhotoImportSource;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Import.IPhotoImportSource>
  IIterable_1__Import_IPhotoImportSource = interface;
  PIIterable_1__Import_IPhotoImportSource = ^IIterable_1__Import_IPhotoImportSource;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportSource>
  IVectorView_1__Import_IPhotoImportSource = interface;
  PIVectorView_1__Import_IPhotoImportSource = ^IVectorView_1__Import_IPhotoImportSource;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportSource>>
  AsyncOperationCompletedHandler_1__IVectorView_1__Import_IPhotoImportSource = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__Import_IPhotoImportSource = ^AsyncOperationCompletedHandler_1__IVectorView_1__Import_IPhotoImportSource;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportSource>>
  IAsyncOperation_1__IVectorView_1__Import_IPhotoImportSource = interface;
  PIAsyncOperation_1__IVectorView_1__Import_IPhotoImportSource = ^IAsyncOperation_1__IVectorView_1__Import_IPhotoImportSource;

  // Windows.Media.Import.IPhotoImportOperation
  Import_IPhotoImportOperation = interface;
  PImport_IPhotoImportOperation = ^Import_IPhotoImportOperation;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Import.IPhotoImportOperation>
  IIterator_1__Import_IPhotoImportOperation = interface;
  PIIterator_1__Import_IPhotoImportOperation = ^IIterator_1__Import_IPhotoImportOperation;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Import.IPhotoImportOperation>
  IIterable_1__Import_IPhotoImportOperation = interface;
  PIIterable_1__Import_IPhotoImportOperation = ^IIterable_1__Import_IPhotoImportOperation;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportOperation>
  IVectorView_1__Import_IPhotoImportOperation = interface;
  PIVectorView_1__Import_IPhotoImportOperation = ^IVectorView_1__Import_IPhotoImportOperation;

  // Windows.Media.Import.IPhotoImportManagerStatics
  Import_IPhotoImportManagerStatics = interface;
  PImport_IPhotoImportManagerStatics = ^Import_IPhotoImportManagerStatics;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Import.IPhotoImportSource>
  AsyncOperationCompletedHandler_1__Import_IPhotoImportSource = interface;
  PAsyncOperationCompletedHandler_1__Import_IPhotoImportSource = ^AsyncOperationCompletedHandler_1__Import_IPhotoImportSource;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Import.IPhotoImportSource>
  IAsyncOperation_1__Import_IPhotoImportSource = interface;
  PIAsyncOperation_1__Import_IPhotoImportSource = ^IAsyncOperation_1__Import_IPhotoImportSource;

  // Windows.Media.Import.IPhotoImportSourceStatics
  Import_IPhotoImportSourceStatics = interface;
  PImport_IPhotoImportSourceStatics = ^Import_IPhotoImportSourceStatics;

  // Windows.Media.Playback.IMediaPlaybackSource
  Playback_IMediaPlaybackSource = interface;
  PPlayback_IMediaPlaybackSource = ^Playback_IMediaPlaybackSource;

  // Windows.Media.Core.IAudioStreamDescriptor
  Core_IAudioStreamDescriptor = interface;
  PCore_IAudioStreamDescriptor = ^Core_IAudioStreamDescriptor;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.IAudioStreamDescriptor>
  IIterator_1__Core_IAudioStreamDescriptor = interface;
  PIIterator_1__Core_IAudioStreamDescriptor = ^IIterator_1__Core_IAudioStreamDescriptor;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.IAudioStreamDescriptor>
  IIterable_1__Core_IAudioStreamDescriptor = interface;
  PIIterable_1__Core_IAudioStreamDescriptor = ^IIterable_1__Core_IAudioStreamDescriptor;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.IAudioStreamDescriptor>
  IVectorView_1__Core_IAudioStreamDescriptor = interface;
  PIVectorView_1__Core_IAudioStreamDescriptor = ^IVectorView_1__Core_IAudioStreamDescriptor;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Core.IAudioStreamDescriptor>
  IVector_1__Core_IAudioStreamDescriptor = interface;
  PIVector_1__Core_IAudioStreamDescriptor = ^IVector_1__Core_IAudioStreamDescriptor;

  // Windows.Media.Core.IVideoStreamDescriptor
  Core_IVideoStreamDescriptor = interface;
  PCore_IVideoStreamDescriptor = ^Core_IVideoStreamDescriptor;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.IVideoStreamDescriptor>
  IIterator_1__Core_IVideoStreamDescriptor = interface;
  PIIterator_1__Core_IVideoStreamDescriptor = ^IIterator_1__Core_IVideoStreamDescriptor;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.IVideoStreamDescriptor>
  IIterable_1__Core_IVideoStreamDescriptor = interface;
  PIIterable_1__Core_IVideoStreamDescriptor = ^IIterable_1__Core_IVideoStreamDescriptor;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.IVideoStreamDescriptor>
  IVectorView_1__Core_IVideoStreamDescriptor = interface;
  PIVectorView_1__Core_IVideoStreamDescriptor = ^IVectorView_1__Core_IVideoStreamDescriptor;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Core.IVideoStreamDescriptor>
  IVector_1__Core_IVideoStreamDescriptor = interface;
  PIVector_1__Core_IVideoStreamDescriptor = ^IVector_1__Core_IVideoStreamDescriptor;

  // Windows.Media.Protection.PlayReady.INDSendResult
  Protection_PlayReady_INDSendResult = interface;
  PProtection_PlayReady_INDSendResult = ^Protection_PlayReady_INDSendResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Protection.PlayReady.INDSendResult>
  AsyncOperationCompletedHandler_1__Protection_PlayReady_INDSendResult = interface;
  PAsyncOperationCompletedHandler_1__Protection_PlayReady_INDSendResult = ^AsyncOperationCompletedHandler_1__Protection_PlayReady_INDSendResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Protection.PlayReady.INDSendResult>
  IAsyncOperation_1__Protection_PlayReady_INDSendResult = interface;
  PIAsyncOperation_1__Protection_PlayReady_INDSendResult = ^IAsyncOperation_1__Protection_PlayReady_INDSendResult;

  // Windows.Media.Protection.PlayReady.INDTransmitterProperties
  Protection_PlayReady_INDTransmitterProperties = interface;
  PProtection_PlayReady_INDTransmitterProperties = ^Protection_PlayReady_INDTransmitterProperties;

  // Windows.Media.Protection.PlayReady.INDStartResult
  Protection_PlayReady_INDStartResult = interface;
  PProtection_PlayReady_INDStartResult = ^Protection_PlayReady_INDStartResult;

  // Windows.Media.Protection.PlayReady.INDProximityDetectionCompletedEventArgs
  Protection_PlayReady_INDProximityDetectionCompletedEventArgs = interface;
  PProtection_PlayReady_INDProximityDetectionCompletedEventArgs = ^Protection_PlayReady_INDProximityDetectionCompletedEventArgs;

  // Windows.Media.Protection.PlayReady.INDClosedCaptionDataReceivedEventArgs
  Protection_PlayReady_INDClosedCaptionDataReceivedEventArgs = interface;
  PProtection_PlayReady_INDClosedCaptionDataReceivedEventArgs = ^Protection_PlayReady_INDClosedCaptionDataReceivedEventArgs;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Protection.PlayReady.INDStartResult>
  AsyncOperationCompletedHandler_1__Protection_PlayReady_INDStartResult = interface;
  PAsyncOperationCompletedHandler_1__Protection_PlayReady_INDStartResult = ^AsyncOperationCompletedHandler_1__Protection_PlayReady_INDStartResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Protection.PlayReady.INDStartResult>
  IAsyncOperation_1__Protection_PlayReady_INDStartResult = interface;
  PIAsyncOperation_1__Protection_PlayReady_INDStartResult = ^IAsyncOperation_1__Protection_PlayReady_INDStartResult;

  // Windows.Media.IMediaMarker
  IMediaMarker = interface;
  PIMediaMarker = ^IMediaMarker;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.IMediaMarker>
  IIterator_1__IMediaMarker = interface;
  PIIterator_1__IMediaMarker = ^IIterator_1__IMediaMarker;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.IMediaMarker>
  IIterable_1__IMediaMarker = interface;
  PIIterable_1__IMediaMarker = ^IIterable_1__IMediaMarker;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.IMediaMarker>
  IVectorView_1__IMediaMarker = interface;
  PIVectorView_1__IMediaMarker = ^IVectorView_1__IMediaMarker;

  // Windows.Media.IMediaMarkers
  IMediaMarkers = interface;
  PIMediaMarkers = ^IMediaMarkers;

  // Windows.Media.Capture.IMediaCaptureFailedEventArgs
  Capture_IMediaCaptureFailedEventArgs = interface;
  PCapture_IMediaCaptureFailedEventArgs = ^Capture_IMediaCaptureFailedEventArgs;

  // Windows.Media.Capture.IMediaCaptureInitializationSettings
  Capture_IMediaCaptureInitializationSettings = interface;
  PCapture_IMediaCaptureInitializationSettings = ^Capture_IMediaCaptureInitializationSettings;

  // Windows.Media.IMediaExtension
  IMediaExtension = interface;
  PIMediaExtension = ^IMediaExtension;

  // Windows.Media.Capture.RecordLimitationExceededEventHandler
  Capture_RecordLimitationExceededEventHandler = interface;
  PCapture_RecordLimitationExceededEventHandler = ^Capture_RecordLimitationExceededEventHandler;

  // Windows.Media.Capture.IMediaCaptureSettings
  Capture_IMediaCaptureSettings = interface;
  PCapture_IMediaCaptureSettings = ^Capture_IMediaCaptureSettings;

  // Windows.Media.Capture.IMediaCapture
  Capture_IMediaCapture = interface;
  PCapture_IMediaCapture = ^Capture_IMediaCapture;

  // Windows.Media.Capture.MediaCaptureFailedEventHandler
  Capture_MediaCaptureFailedEventHandler = interface;
  PCapture_MediaCaptureFailedEventHandler = ^Capture_MediaCaptureFailedEventHandler;

  // Windows.Media.Capture.IMediaCaptureVideoProfileMediaDescription
  Capture_IMediaCaptureVideoProfileMediaDescription = interface;
  PCapture_IMediaCaptureVideoProfileMediaDescription = ^Capture_IMediaCaptureVideoProfileMediaDescription;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Capture.IMediaCaptureVideoProfileMediaDescription>
  IIterator_1__Capture_IMediaCaptureVideoProfileMediaDescription = interface;
  PIIterator_1__Capture_IMediaCaptureVideoProfileMediaDescription = ^IIterator_1__Capture_IMediaCaptureVideoProfileMediaDescription;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Capture.IMediaCaptureVideoProfileMediaDescription>
  IIterable_1__Capture_IMediaCaptureVideoProfileMediaDescription = interface;
  PIIterable_1__Capture_IMediaCaptureVideoProfileMediaDescription = ^IIterable_1__Capture_IMediaCaptureVideoProfileMediaDescription;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Capture.IMediaCaptureVideoProfileMediaDescription>
  IVectorView_1__Capture_IMediaCaptureVideoProfileMediaDescription = interface;
  PIVectorView_1__Capture_IMediaCaptureVideoProfileMediaDescription = ^IVectorView_1__Capture_IMediaCaptureVideoProfileMediaDescription;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Capture.IMediaCaptureVideoProfile>
  IIterator_1__Capture_IMediaCaptureVideoProfile = interface;
  PIIterator_1__Capture_IMediaCaptureVideoProfile = ^IIterator_1__Capture_IMediaCaptureVideoProfile;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Capture.IMediaCaptureVideoProfile>
  IIterable_1__Capture_IMediaCaptureVideoProfile = interface;
  PIIterable_1__Capture_IMediaCaptureVideoProfile = ^IIterable_1__Capture_IMediaCaptureVideoProfile;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Capture.IMediaCaptureVideoProfile>
  IVectorView_1__Capture_IMediaCaptureVideoProfile = interface;
  PIVectorView_1__Capture_IMediaCaptureVideoProfile = ^IVectorView_1__Capture_IMediaCaptureVideoProfile;

  // Windows.Media.Capture.IMediaCaptureVideoProfile
  Capture_IMediaCaptureVideoProfile = interface;
  PCapture_IMediaCaptureVideoProfile = ^Capture_IMediaCaptureVideoProfile;

  // Windows.Media.Capture.IMediaCaptureInitializationSettings2
  Capture_IMediaCaptureInitializationSettings2 = interface;
  PCapture_IMediaCaptureInitializationSettings2 = ^Capture_IMediaCaptureInitializationSettings2;

  // Windows.Media.Capture.IMediaCaptureInitializationSettings3
  Capture_IMediaCaptureInitializationSettings3 = interface;
  PCapture_IMediaCaptureInitializationSettings3 = ^Capture_IMediaCaptureInitializationSettings3;

  // Windows.Media.Capture.IMediaCaptureInitializationSettings4
  Capture_IMediaCaptureInitializationSettings4 = interface;
  PCapture_IMediaCaptureInitializationSettings4 = ^Capture_IMediaCaptureInitializationSettings4;

  // Windows.Media.Capture.IMediaCaptureStatics
  Capture_IMediaCaptureStatics = interface;
  PCapture_IMediaCaptureStatics = ^Capture_IMediaCaptureStatics;

  // Windows.Media.Effects.IVideoCompositor
  Effects_IVideoCompositor = interface;
  PEffects_IVideoCompositor = ^Effects_IVideoCompositor;

  // Windows.Media.Capture.ILowLagMediaRecording
  Capture_ILowLagMediaRecording = interface;
  PCapture_ILowLagMediaRecording = ^Capture_ILowLagMediaRecording;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.ILowLagMediaRecording>
  AsyncOperationCompletedHandler_1__Capture_ILowLagMediaRecording = interface;
  PAsyncOperationCompletedHandler_1__Capture_ILowLagMediaRecording = ^AsyncOperationCompletedHandler_1__Capture_ILowLagMediaRecording;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.ILowLagMediaRecording>
  IAsyncOperation_1__Capture_ILowLagMediaRecording = interface;
  PIAsyncOperation_1__Capture_ILowLagMediaRecording = ^IAsyncOperation_1__Capture_ILowLagMediaRecording;

  // Windows.Media.Capture.ICapturedFrame
  Capture_ICapturedFrame = interface;
  PCapture_ICapturedFrame = ^Capture_ICapturedFrame;

  // Windows.Media.Capture.ICapturedPhoto
  Capture_ICapturedPhoto = interface;
  PCapture_ICapturedPhoto = ^Capture_ICapturedPhoto;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.ICapturedPhoto>
  AsyncOperationCompletedHandler_1__Capture_ICapturedPhoto = interface;
  PAsyncOperationCompletedHandler_1__Capture_ICapturedPhoto = ^AsyncOperationCompletedHandler_1__Capture_ICapturedPhoto;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.ICapturedPhoto>
  IAsyncOperation_1__Capture_ICapturedPhoto = interface;
  PIAsyncOperation_1__Capture_ICapturedPhoto = ^IAsyncOperation_1__Capture_ICapturedPhoto;

  // Windows.Media.Capture.ILowLagPhotoCapture
  Capture_ILowLagPhotoCapture = interface;
  PCapture_ILowLagPhotoCapture = ^Capture_ILowLagPhotoCapture;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.ILowLagPhotoCapture>
  AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoCapture = interface;
  PAsyncOperationCompletedHandler_1__Capture_ILowLagPhotoCapture = ^AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoCapture;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.ILowLagPhotoCapture>
  IAsyncOperation_1__Capture_ILowLagPhotoCapture = interface;
  PIAsyncOperation_1__Capture_ILowLagPhotoCapture = ^IAsyncOperation_1__Capture_ILowLagPhotoCapture;

  // Windows.Media.Capture.IPhotoCapturedEventArgs
  Capture_IPhotoCapturedEventArgs = interface;
  PCapture_IPhotoCapturedEventArgs = ^Capture_IPhotoCapturedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.ILowLagPhotoSequenceCapture,Windows.Media.Capture.IPhotoCapturedEventArgs>
  TypedEventHandler_2__Capture_ILowLagPhotoSequenceCapture__Capture_IPhotoCapturedEventArgs = interface;
  PTypedEventHandler_2__Capture_ILowLagPhotoSequenceCapture__Capture_IPhotoCapturedEventArgs = ^TypedEventHandler_2__Capture_ILowLagPhotoSequenceCapture__Capture_IPhotoCapturedEventArgs;

  // Windows.Media.Capture.ILowLagPhotoSequenceCapture
  Capture_ILowLagPhotoSequenceCapture = interface;
  PCapture_ILowLagPhotoSequenceCapture = ^Capture_ILowLagPhotoSequenceCapture;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.ILowLagPhotoSequenceCapture>
  AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoSequenceCapture = interface;
  PAsyncOperationCompletedHandler_1__Capture_ILowLagPhotoSequenceCapture = ^AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoSequenceCapture;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.ILowLagPhotoSequenceCapture>
  IAsyncOperation_1__Capture_ILowLagPhotoSequenceCapture = interface;
  PIAsyncOperation_1__Capture_ILowLagPhotoSequenceCapture = ^IAsyncOperation_1__Capture_ILowLagPhotoSequenceCapture;

  // Windows.Media.Capture.IMediaCapture2
  Capture_IMediaCapture2 = interface;
  PCapture_IMediaCapture2 = ^Capture_IMediaCapture2;

  // Windows.Media.Capture.ICapturedFrameControlValues
  Capture_ICapturedFrameControlValues = interface;
  PCapture_ICapturedFrameControlValues = ^Capture_ICapturedFrameControlValues;

  // Windows.Media.Capture.Core.IVariablePhotoCapturedEventArgs
  Capture_Core_IVariablePhotoCapturedEventArgs = interface;
  PCapture_Core_IVariablePhotoCapturedEventArgs = ^Capture_Core_IVariablePhotoCapturedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.Core.IVariablePhotoSequenceCapture,Windows.Media.Capture.Core.IVariablePhotoCapturedEventArgs>
  TypedEventHandler_2__Capture_Core_IVariablePhotoSequenceCapture__Capture_Core_IVariablePhotoCapturedEventArgs = interface;
  PTypedEventHandler_2__Capture_Core_IVariablePhotoSequenceCapture__Capture_Core_IVariablePhotoCapturedEventArgs = ^TypedEventHandler_2__Capture_Core_IVariablePhotoSequenceCapture__Capture_Core_IVariablePhotoCapturedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.Core.IVariablePhotoSequenceCapture,Object>
  TypedEventHandler_2__Capture_Core_IVariablePhotoSequenceCapture__IInspectable = interface;
  PTypedEventHandler_2__Capture_Core_IVariablePhotoSequenceCapture__IInspectable = ^TypedEventHandler_2__Capture_Core_IVariablePhotoSequenceCapture__IInspectable;

  // Windows.Media.Capture.Core.IVariablePhotoSequenceCapture
  Capture_Core_IVariablePhotoSequenceCapture = interface;
  PCapture_Core_IVariablePhotoSequenceCapture = ^Capture_Core_IVariablePhotoSequenceCapture;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.Core.IVariablePhotoSequenceCapture>
  AsyncOperationCompletedHandler_1__Capture_Core_IVariablePhotoSequenceCapture = interface;
  PAsyncOperationCompletedHandler_1__Capture_Core_IVariablePhotoSequenceCapture = ^AsyncOperationCompletedHandler_1__Capture_Core_IVariablePhotoSequenceCapture;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.Core.IVariablePhotoSequenceCapture>
  IAsyncOperation_1__Capture_Core_IVariablePhotoSequenceCapture = interface;
  PIAsyncOperation_1__Capture_Core_IVariablePhotoSequenceCapture = ^IAsyncOperation_1__Capture_Core_IVariablePhotoSequenceCapture;

  // Windows.Media.Capture.IMediaCaptureFocusChangedEventArgs
  Capture_IMediaCaptureFocusChangedEventArgs = interface;
  PCapture_IMediaCaptureFocusChangedEventArgs = ^Capture_IMediaCaptureFocusChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.IMediaCapture,Windows.Media.Capture.IMediaCaptureFocusChangedEventArgs>
  TypedEventHandler_2__Capture_IMediaCapture__Capture_IMediaCaptureFocusChangedEventArgs = interface;
  PTypedEventHandler_2__Capture_IMediaCapture__Capture_IMediaCaptureFocusChangedEventArgs = ^TypedEventHandler_2__Capture_IMediaCapture__Capture_IMediaCaptureFocusChangedEventArgs;

  // Windows.Media.Capture.IPhotoConfirmationCapturedEventArgs
  Capture_IPhotoConfirmationCapturedEventArgs = interface;
  PCapture_IPhotoConfirmationCapturedEventArgs = ^Capture_IPhotoConfirmationCapturedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.IMediaCapture,Windows.Media.Capture.IPhotoConfirmationCapturedEventArgs>
  TypedEventHandler_2__Capture_IMediaCapture__Capture_IPhotoConfirmationCapturedEventArgs = interface;
  PTypedEventHandler_2__Capture_IMediaCapture__Capture_IPhotoConfirmationCapturedEventArgs = ^TypedEventHandler_2__Capture_IMediaCapture__Capture_IPhotoConfirmationCapturedEventArgs;

  // Windows.Media.Capture.IMediaCapture3
  Capture_IMediaCapture3 = interface;
  PCapture_IMediaCapture3 = ^Capture_IMediaCapture3;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.IMediaExtension>
  AsyncOperationCompletedHandler_1__IMediaExtension = interface;
  PAsyncOperationCompletedHandler_1__IMediaExtension = ^AsyncOperationCompletedHandler_1__IMediaExtension;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.IMediaExtension>
  IAsyncOperation_1__IMediaExtension = interface;
  PIAsyncOperation_1__IMediaExtension = ^IAsyncOperation_1__IMediaExtension;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.IMediaCapture,Object>
  TypedEventHandler_2__Capture_IMediaCapture__IInspectable = interface;
  PTypedEventHandler_2__Capture_IMediaCapture__IInspectable = ^TypedEventHandler_2__Capture_IMediaCapture__IInspectable;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.IVideoFrame>
  AsyncOperationCompletedHandler_1__IVideoFrame = interface;
  PAsyncOperationCompletedHandler_1__IVideoFrame = ^AsyncOperationCompletedHandler_1__IVideoFrame;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.IVideoFrame>
  IAsyncOperation_1__IVideoFrame = interface;
  PIAsyncOperation_1__IVideoFrame = ^IAsyncOperation_1__IVideoFrame;

  // Windows.Media.Capture.IAdvancedCapturedPhoto
  Capture_IAdvancedCapturedPhoto = interface;
  PCapture_IAdvancedCapturedPhoto = ^Capture_IAdvancedCapturedPhoto;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.IAdvancedCapturedPhoto>
  AsyncOperationCompletedHandler_1__Capture_IAdvancedCapturedPhoto = interface;
  PAsyncOperationCompletedHandler_1__Capture_IAdvancedCapturedPhoto = ^AsyncOperationCompletedHandler_1__Capture_IAdvancedCapturedPhoto;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.IAdvancedCapturedPhoto>
  IAsyncOperation_1__Capture_IAdvancedCapturedPhoto = interface;
  PIAsyncOperation_1__Capture_IAdvancedCapturedPhoto = ^IAsyncOperation_1__Capture_IAdvancedCapturedPhoto;

  // Windows.Media.Capture.IOptionalReferencePhotoCapturedEventArgs
  Capture_IOptionalReferencePhotoCapturedEventArgs = interface;
  PCapture_IOptionalReferencePhotoCapturedEventArgs = ^Capture_IOptionalReferencePhotoCapturedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.IAdvancedPhotoCapture,Windows.Media.Capture.IOptionalReferencePhotoCapturedEventArgs>
  TypedEventHandler_2__Capture_IAdvancedPhotoCapture__Capture_IOptionalReferencePhotoCapturedEventArgs = interface;
  PTypedEventHandler_2__Capture_IAdvancedPhotoCapture__Capture_IOptionalReferencePhotoCapturedEventArgs = ^TypedEventHandler_2__Capture_IAdvancedPhotoCapture__Capture_IOptionalReferencePhotoCapturedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.IAdvancedPhotoCapture,Object>
  TypedEventHandler_2__Capture_IAdvancedPhotoCapture__IInspectable = interface;
  PTypedEventHandler_2__Capture_IAdvancedPhotoCapture__IInspectable = ^TypedEventHandler_2__Capture_IAdvancedPhotoCapture__IInspectable;

  // Windows.Media.Capture.IAdvancedPhotoCapture
  Capture_IAdvancedPhotoCapture = interface;
  PCapture_IAdvancedPhotoCapture = ^Capture_IAdvancedPhotoCapture;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.IAdvancedPhotoCapture>
  AsyncOperationCompletedHandler_1__Capture_IAdvancedPhotoCapture = interface;
  PAsyncOperationCompletedHandler_1__Capture_IAdvancedPhotoCapture = ^AsyncOperationCompletedHandler_1__Capture_IAdvancedPhotoCapture;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.IAdvancedPhotoCapture>
  IAsyncOperation_1__Capture_IAdvancedPhotoCapture = interface;
  PIAsyncOperation_1__Capture_IAdvancedPhotoCapture = ^IAsyncOperation_1__Capture_IAdvancedPhotoCapture;

  // Windows.Media.Capture.IMediaCapture4
  Capture_IMediaCapture4 = interface;
  PCapture_IMediaCapture4 = ^Capture_IMediaCapture4;

  // Windows.Media.Capture.ILowLagMediaRecording2
  Capture_ILowLagMediaRecording2 = interface;
  PCapture_ILowLagMediaRecording2 = ^Capture_ILowLagMediaRecording2;

  // Windows.Foundation.IReference`1<Windows.Media.Capture.WhiteBalanceGain>
  IReference_1__Capture_WhiteBalanceGain = interface;
  PIReference_1__Capture_WhiteBalanceGain = ^IReference_1__Capture_WhiteBalanceGain;

  // Windows.Media.Capture.ICapturedFrameControlValues2
  Capture_ICapturedFrameControlValues2 = interface;
  PCapture_ICapturedFrameControlValues2 = ^Capture_ICapturedFrameControlValues2;

  // Windows.Media.Capture.ICapturedFrameWithSoftwareBitmap
  Capture_ICapturedFrameWithSoftwareBitmap = interface;
  PCapture_ICapturedFrameWithSoftwareBitmap = ^Capture_ICapturedFrameWithSoftwareBitmap;

  // Windows.Media.Capture.IMediaCaptureVideoPreview
  Capture_IMediaCaptureVideoPreview = interface;
  PCapture_IMediaCaptureVideoPreview = ^Capture_IMediaCaptureVideoPreview;

  // Windows.Media.Capture.IMediaCaptureSettings2
  Capture_IMediaCaptureSettings2 = interface;
  PCapture_IMediaCaptureSettings2 = ^Capture_IMediaCaptureSettings2;

  // Windows.Media.Capture.IVideoStreamConfiguration
  Capture_IVideoStreamConfiguration = interface;
  PCapture_IVideoStreamConfiguration = ^Capture_IVideoStreamConfiguration;

  // Windows.Media.Capture.Core.IVariablePhotoSequenceCapture2
  Capture_Core_IVariablePhotoSequenceCapture2 = interface;
  PCapture_Core_IVariablePhotoSequenceCapture2 = ^Capture_Core_IVariablePhotoSequenceCapture2;

  // Windows.Media.IVideoEffectsStatics
  IVideoEffectsStatics = interface;
  PIVideoEffectsStatics = ^IVideoEffectsStatics;

  // Windows.Media.Effects.IVideoEffectDefinitionFactory
  Effects_IVideoEffectDefinitionFactory = interface;
  PEffects_IVideoEffectDefinitionFactory = ^Effects_IVideoEffectDefinitionFactory;

  // Windows.Media.Effects.IAudioEffectDefinitionFactory
  Effects_IAudioEffectDefinitionFactory = interface;
  PEffects_IAudioEffectDefinitionFactory = ^Effects_IAudioEffectDefinitionFactory;

  // Windows.Media.Effects.IProcessVideoFrameContext
  Effects_IProcessVideoFrameContext = interface;
  PEffects_IProcessVideoFrameContext = ^Effects_IProcessVideoFrameContext;

  // Windows.Media.Effects.IBasicVideoEffect
  Effects_IBasicVideoEffect = interface;
  PEffects_IBasicVideoEffect = ^Effects_IBasicVideoEffect;

  // Windows.Media.Effects.IProcessAudioFrameContext
  Effects_IProcessAudioFrameContext = interface;
  PEffects_IProcessAudioFrameContext = ^Effects_IProcessAudioFrameContext;

  // Windows.Media.Effects.IBasicAudioEffect
  Effects_IBasicAudioEffect = interface;
  PEffects_IBasicAudioEffect = ^Effects_IBasicAudioEffect;

  // Windows.Media.Effects.IVideoTransformEffectDefinition
  Effects_IVideoTransformEffectDefinition = interface;
  PEffects_IVideoTransformEffectDefinition = ^Effects_IVideoTransformEffectDefinition;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Playback.IMediaPlaybackItem,Windows.Foundation.Collections.IVectorChangedEventArgs>
  TypedEventHandler_2__Playback_IMediaPlaybackItem__IVectorChangedEventArgs = interface;
  PTypedEventHandler_2__Playback_IMediaPlaybackItem__IVectorChangedEventArgs = ^TypedEventHandler_2__Playback_IMediaPlaybackItem__IVectorChangedEventArgs;

  // Windows.Media.Core.IMediaSourceError
  Core_IMediaSourceError = interface;
  PCore_IMediaSourceError = ^Core_IMediaSourceError;

  // Windows.Media.Core.IMediaSourceOpenOperationCompletedEventArgs
  Core_IMediaSourceOpenOperationCompletedEventArgs = interface;
  PCore_IMediaSourceOpenOperationCompletedEventArgs = ^Core_IMediaSourceOpenOperationCompletedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaSource2,Windows.Media.Core.IMediaSourceOpenOperationCompletedEventArgs>
  TypedEventHandler_2__Core_IMediaSource2__Core_IMediaSourceOpenOperationCompletedEventArgs = interface;
  PTypedEventHandler_2__Core_IMediaSource2__Core_IMediaSourceOpenOperationCompletedEventArgs = ^TypedEventHandler_2__Core_IMediaSource2__Core_IMediaSourceOpenOperationCompletedEventArgs;

  // Windows.Media.Core.ITimedMetadataTrackError
  Core_ITimedMetadataTrackError = interface;
  PCore_ITimedMetadataTrackError = ^Core_ITimedMetadataTrackError;

  // Windows.Media.Core.IMediaTrack
  Core_IMediaTrack = interface;
  PCore_IMediaTrack = ^Core_IMediaTrack;

  // Windows.Media.Core.IMediaCue
  Core_IMediaCue = interface;
  PCore_IMediaCue = ^Core_IMediaCue;

  // Windows.Media.Core.IMediaCueEventArgs
  Core_IMediaCueEventArgs = interface;
  PCore_IMediaCueEventArgs = ^Core_IMediaCueEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.ITimedMetadataTrack,Windows.Media.Core.IMediaCueEventArgs>
  TypedEventHandler_2__Core_ITimedMetadataTrack__Core_IMediaCueEventArgs = interface;
  PTypedEventHandler_2__Core_ITimedMetadataTrack__Core_IMediaCueEventArgs = ^TypedEventHandler_2__Core_ITimedMetadataTrack__Core_IMediaCueEventArgs;

  // Windows.Media.Core.ITimedMetadataTrackFailedEventArgs
  Core_ITimedMetadataTrackFailedEventArgs = interface;
  PCore_ITimedMetadataTrackFailedEventArgs = ^Core_ITimedMetadataTrackFailedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.ITimedMetadataTrack,Windows.Media.Core.ITimedMetadataTrackFailedEventArgs>
  TypedEventHandler_2__Core_ITimedMetadataTrack__Core_ITimedMetadataTrackFailedEventArgs = interface;
  PTypedEventHandler_2__Core_ITimedMetadataTrack__Core_ITimedMetadataTrackFailedEventArgs = ^TypedEventHandler_2__Core_ITimedMetadataTrack__Core_ITimedMetadataTrackFailedEventArgs;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.IMediaCue>
  IIterator_1__Core_IMediaCue = interface;
  PIIterator_1__Core_IMediaCue = ^IIterator_1__Core_IMediaCue;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.IMediaCue>
  IIterable_1__Core_IMediaCue = interface;
  PIIterable_1__Core_IMediaCue = ^IIterable_1__Core_IMediaCue;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.IMediaCue>
  IVectorView_1__Core_IMediaCue = interface;
  PIVectorView_1__Core_IMediaCue = ^IVectorView_1__Core_IMediaCue;

  // Windows.Media.Core.ITimedMetadataTrack
  Core_ITimedMetadataTrack = interface;
  PCore_ITimedMetadataTrack = ^Core_ITimedMetadataTrack;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.ITimedMetadataTrack>
  IIterator_1__Core_ITimedMetadataTrack = interface;
  PIIterator_1__Core_ITimedMetadataTrack = ^IIterator_1__Core_ITimedMetadataTrack;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.ITimedMetadataTrack>
  IIterable_1__Core_ITimedMetadataTrack = interface;
  PIIterable_1__Core_ITimedMetadataTrack = ^IIterable_1__Core_ITimedMetadataTrack;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.ITimedMetadataTrack>
  IVectorView_1__Core_ITimedMetadataTrack = interface;
  PIVectorView_1__Core_ITimedMetadataTrack = ^IVectorView_1__Core_ITimedMetadataTrack;

  // Windows.Media.Core.ITimedTextSourceResolveResultEventArgs
  Core_ITimedTextSourceResolveResultEventArgs = interface;
  PCore_ITimedTextSourceResolveResultEventArgs = ^Core_ITimedTextSourceResolveResultEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.ITimedTextSource,Windows.Media.Core.ITimedTextSourceResolveResultEventArgs>
  TypedEventHandler_2__Core_ITimedTextSource__Core_ITimedTextSourceResolveResultEventArgs = interface;
  PTypedEventHandler_2__Core_ITimedTextSource__Core_ITimedTextSourceResolveResultEventArgs = ^TypedEventHandler_2__Core_ITimedTextSource__Core_ITimedTextSourceResolveResultEventArgs;

  // Windows.Media.Core.ITimedTextSource
  Core_ITimedTextSource = interface;
  PCore_ITimedTextSource = ^Core_ITimedTextSource;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.ITimedTextSource>
  IIterator_1__Core_ITimedTextSource = interface;
  PIIterator_1__Core_ITimedTextSource = ^IIterator_1__Core_ITimedTextSource;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.ITimedTextSource>
  IIterable_1__Core_ITimedTextSource = interface;
  PIIterable_1__Core_ITimedTextSource = ^IIterable_1__Core_ITimedTextSource;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.ITimedTextSource>
  IVectorView_1__Core_ITimedTextSource = interface;
  PIVectorView_1__Core_ITimedTextSource = ^IVectorView_1__Core_ITimedTextSource;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Core.ITimedTextSource>
  IVector_1__Core_ITimedTextSource = interface;
  PIVector_1__Core_ITimedTextSource = ^IVector_1__Core_ITimedTextSource;

  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.Media.Core.ITimedTextSource>
  VectorChangedEventHandler_1__Core_ITimedTextSource = interface;
  PVectorChangedEventHandler_1__Core_ITimedTextSource = ^VectorChangedEventHandler_1__Core_ITimedTextSource;

  // Windows.Foundation.Collections.IObservableVector`1<Windows.Media.Core.ITimedTextSource>
  IObservableVector_1__Core_ITimedTextSource = interface;
  PIObservableVector_1__Core_ITimedTextSource = ^IObservableVector_1__Core_ITimedTextSource;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Core.ITimedMetadataTrack>
  IVector_1__Core_ITimedMetadataTrack = interface;
  PIVector_1__Core_ITimedMetadataTrack = ^IVector_1__Core_ITimedMetadataTrack;

  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.Media.Core.ITimedMetadataTrack>
  VectorChangedEventHandler_1__Core_ITimedMetadataTrack = interface;
  PVectorChangedEventHandler_1__Core_ITimedMetadataTrack = ^VectorChangedEventHandler_1__Core_ITimedMetadataTrack;

  // Windows.Foundation.Collections.IObservableVector`1<Windows.Media.Core.ITimedMetadataTrack>
  IObservableVector_1__Core_ITimedMetadataTrack = interface;
  PIObservableVector_1__Core_ITimedMetadataTrack = ^IObservableVector_1__Core_ITimedMetadataTrack;

  // Windows.Media.Core.IMediaSource2
  Core_IMediaSource2 = interface;
  PCore_IMediaSource2 = ^Core_IMediaSource2;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.IMediaTrack>
  IIterator_1__Core_IMediaTrack = interface;
  PIIterator_1__Core_IMediaTrack = ^IIterator_1__Core_IMediaTrack;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.IMediaTrack>
  IIterable_1__Core_IMediaTrack = interface;
  PIIterable_1__Core_IMediaTrack = ^IIterable_1__Core_IMediaTrack;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.IMediaTrack>
  IVectorView_1__Core_IMediaTrack = interface;
  PIVectorView_1__Core_IMediaTrack = ^IVectorView_1__Core_IMediaTrack;

  // Windows.Media.Playback.IMediaPlaybackItem
  Playback_IMediaPlaybackItem = interface;
  PPlayback_IMediaPlaybackItem = ^Playback_IMediaPlaybackItem;

  // Windows.Media.Protection.IMediaProtectionPMPServer
  Protection_IMediaProtectionPMPServer = interface;
  PProtection_IMediaProtectionPMPServer = ^Protection_IMediaProtectionPMPServer;

  // Windows.Media.Protection.IMediaProtectionPMPServerFactory
  Protection_IMediaProtectionPMPServerFactory = interface;
  PProtection_IMediaProtectionPMPServerFactory = ^Protection_IMediaProtectionPMPServerFactory;

  // Windows.Media.Core.IAudioStreamDescriptorFactory
  Core_IAudioStreamDescriptorFactory = interface;
  PCore_IAudioStreamDescriptorFactory = ^Core_IAudioStreamDescriptorFactory;

  // Windows.Media.Core.IVideoStreamDescriptorFactory
  Core_IVideoStreamDescriptorFactory = interface;
  PCore_IVideoStreamDescriptorFactory = ^Core_IVideoStreamDescriptorFactory;

  // Windows.Media.Core.IMediaStreamSourceFactory
  Core_IMediaStreamSourceFactory = interface;
  PCore_IMediaStreamSourceFactory = ^Core_IMediaStreamSourceFactory;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Core.IMediaStreamSample>
  AsyncOperationCompletedHandler_1__Core_IMediaStreamSample = interface;
  PAsyncOperationCompletedHandler_1__Core_IMediaStreamSample = ^AsyncOperationCompletedHandler_1__Core_IMediaStreamSample;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Core.IMediaStreamSample>
  IAsyncOperation_1__Core_IMediaStreamSample = interface;
  PIAsyncOperation_1__Core_IMediaStreamSample = ^IAsyncOperation_1__Core_IMediaStreamSample;

  // Windows.Media.Core.IMediaStreamSampleStatics
  Core_IMediaStreamSampleStatics = interface;
  PCore_IMediaStreamSampleStatics = ^Core_IMediaStreamSampleStatics;

  // Windows.Media.Core.IMseStreamSourceStatics
  Core_IMseStreamSourceStatics = interface;
  PCore_IMseStreamSourceStatics = ^Core_IMseStreamSourceStatics;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMseStreamSource,Object>
  TypedEventHandler_2__Core_IMseStreamSource__IInspectable = interface;
  PTypedEventHandler_2__Core_IMseStreamSource__IInspectable = ^TypedEventHandler_2__Core_IMseStreamSource__IInspectable;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMseSourceBufferList,Object>
  TypedEventHandler_2__Core_IMseSourceBufferList__IInspectable = interface;
  PTypedEventHandler_2__Core_IMseSourceBufferList__IInspectable = ^TypedEventHandler_2__Core_IMseSourceBufferList__IInspectable;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMseSourceBuffer,Object>
  TypedEventHandler_2__Core_IMseSourceBuffer__IInspectable = interface;
  PTypedEventHandler_2__Core_IMseSourceBuffer__IInspectable = ^TypedEventHandler_2__Core_IMseSourceBuffer__IInspectable;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.MseTimeRange>
  IIterator_1__Core_MseTimeRange = interface;
  PIIterator_1__Core_MseTimeRange = ^IIterator_1__Core_MseTimeRange;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.MseTimeRange>
  IIterable_1__Core_MseTimeRange = interface;
  PIIterable_1__Core_MseTimeRange = ^IIterable_1__Core_MseTimeRange;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.MseTimeRange>
  IVectorView_1__Core_MseTimeRange = interface;
  PIVectorView_1__Core_MseTimeRange = ^IVectorView_1__Core_MseTimeRange;

  // Windows.Media.Core.IMseSourceBuffer
  Core_IMseSourceBuffer = interface;
  PCore_IMseSourceBuffer = ^Core_IMseSourceBuffer;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.IMseSourceBuffer>
  IIterator_1__Core_IMseSourceBuffer = interface;
  PIIterator_1__Core_IMseSourceBuffer = ^IIterator_1__Core_IMseSourceBuffer;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.IMseSourceBuffer>
  IIterable_1__Core_IMseSourceBuffer = interface;
  PIIterable_1__Core_IMseSourceBuffer = ^IIterable_1__Core_IMseSourceBuffer;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.IMseSourceBuffer>
  IVectorView_1__Core_IMseSourceBuffer = interface;
  PIVectorView_1__Core_IMseSourceBuffer = ^IVectorView_1__Core_IMseSourceBuffer;

  // Windows.Media.Core.IMseSourceBufferList
  Core_IMseSourceBufferList = interface;
  PCore_IMseSourceBufferList = ^Core_IMseSourceBufferList;

  // Windows.Media.Core.IMseStreamSource
  Core_IMseStreamSource = interface;
  PCore_IMseStreamSource = ^Core_IMseStreamSource;

  // Windows.Media.Transcoding.IPrepareTranscodeResult
  Transcoding_IPrepareTranscodeResult = interface;
  PTranscoding_IPrepareTranscodeResult = ^Transcoding_IPrepareTranscodeResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Transcoding.IPrepareTranscodeResult>
  AsyncOperationCompletedHandler_1__Transcoding_IPrepareTranscodeResult = interface;
  PAsyncOperationCompletedHandler_1__Transcoding_IPrepareTranscodeResult = ^AsyncOperationCompletedHandler_1__Transcoding_IPrepareTranscodeResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Transcoding.IPrepareTranscodeResult>
  IAsyncOperation_1__Transcoding_IPrepareTranscodeResult = interface;
  PIAsyncOperation_1__Transcoding_IPrepareTranscodeResult = ^IAsyncOperation_1__Transcoding_IPrepareTranscodeResult;

  // Windows.Media.Transcoding.IMediaTranscoder2
  Transcoding_IMediaTranscoder2 = interface;
  PTranscoding_IMediaTranscoder2 = ^Transcoding_IMediaTranscoder2;

  // Windows.Media.Transcoding.IMediaTranscoder
  Transcoding_IMediaTranscoder = interface;
  PTranscoding_IMediaTranscoder = ^Transcoding_IMediaTranscoder;

  // Windows.Media.Core.IHighDynamicRangeControl
  Core_IHighDynamicRangeControl = interface;
  PCore_IHighDynamicRangeControl = ^Core_IHighDynamicRangeControl;

  // Windows.Media.Core.IHighDynamicRangeOutput
  Core_IHighDynamicRangeOutput = interface;
  PCore_IHighDynamicRangeOutput = ^Core_IHighDynamicRangeOutput;

  // Windows.Media.Core.ISceneAnalysisEffectFrame
  Core_ISceneAnalysisEffectFrame = interface;
  PCore_ISceneAnalysisEffectFrame = ^Core_ISceneAnalysisEffectFrame;

  // Windows.Media.Core.ISceneAnalyzedEventArgs
  Core_ISceneAnalyzedEventArgs = interface;
  PCore_ISceneAnalyzedEventArgs = ^Core_ISceneAnalyzedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.ISceneAnalysisEffect,Windows.Media.Core.ISceneAnalyzedEventArgs>
  TypedEventHandler_2__Core_ISceneAnalysisEffect__Core_ISceneAnalyzedEventArgs = interface;
  PTypedEventHandler_2__Core_ISceneAnalysisEffect__Core_ISceneAnalyzedEventArgs = ^TypedEventHandler_2__Core_ISceneAnalysisEffect__Core_ISceneAnalyzedEventArgs;

  // Windows.Media.Core.ISceneAnalysisEffect
  Core_ISceneAnalysisEffect = interface;
  PCore_ISceneAnalysisEffect = ^Core_ISceneAnalysisEffect;

  // Windows.Media.Core.IFaceDetectionEffectFrame
  Core_IFaceDetectionEffectFrame = interface;
  PCore_IFaceDetectionEffectFrame = ^Core_IFaceDetectionEffectFrame;

  // Windows.Media.Core.IFaceDetectedEventArgs
  Core_IFaceDetectedEventArgs = interface;
  PCore_IFaceDetectedEventArgs = ^Core_IFaceDetectedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IFaceDetectionEffect,Windows.Media.Core.IFaceDetectedEventArgs>
  TypedEventHandler_2__Core_IFaceDetectionEffect__Core_IFaceDetectedEventArgs = interface;
  PTypedEventHandler_2__Core_IFaceDetectionEffect__Core_IFaceDetectedEventArgs = ^TypedEventHandler_2__Core_IFaceDetectionEffect__Core_IFaceDetectedEventArgs;

  // Windows.Media.Core.IFaceDetectionEffect
  Core_IFaceDetectionEffect = interface;
  PCore_IFaceDetectionEffect = ^Core_IFaceDetectionEffect;

  // Windows.Media.Core.IFaceDetectionEffectDefinition
  Core_IFaceDetectionEffectDefinition = interface;
  PCore_IFaceDetectionEffectDefinition = ^Core_IFaceDetectionEffectDefinition;

  // Windows.Media.Core.IVideoStabilizationEffectEnabledChangedEventArgs
  Core_IVideoStabilizationEffectEnabledChangedEventArgs = interface;
  PCore_IVideoStabilizationEffectEnabledChangedEventArgs = ^Core_IVideoStabilizationEffectEnabledChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IVideoStabilizationEffect,Windows.Media.Core.IVideoStabilizationEffectEnabledChangedEventArgs>
  TypedEventHandler_2__Core_IVideoStabilizationEffect__Core_IVideoStabilizationEffectEnabledChangedEventArgs = interface;
  PTypedEventHandler_2__Core_IVideoStabilizationEffect__Core_IVideoStabilizationEffectEnabledChangedEventArgs = ^TypedEventHandler_2__Core_IVideoStabilizationEffect__Core_IVideoStabilizationEffectEnabledChangedEventArgs;

  // Windows.Media.Core.IVideoStabilizationEffect
  Core_IVideoStabilizationEffect = interface;
  PCore_IVideoStabilizationEffect = ^Core_IVideoStabilizationEffect;

  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadBitrateChangedEventArgs
  Streaming_Adaptive_IAdaptiveMediaSourceDownloadBitrateChangedEventArgs = interface;
  PStreaming_Adaptive_IAdaptiveMediaSourceDownloadBitrateChangedEventArgs = ^Streaming_Adaptive_IAdaptiveMediaSourceDownloadBitrateChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource,Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadBitrateChangedEventArgs>
  TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadBitrateChangedEventArgs = interface;
  PTypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadBitrateChangedEventArgs = ^TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadBitrateChangedEventArgs;

  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs
  Streaming_Adaptive_IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs = interface;
  PStreaming_Adaptive_IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs = ^Streaming_Adaptive_IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource,Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs>
  TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs = interface;
  PTypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs = ^TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs;

  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadResult
  Streaming_Adaptive_IAdaptiveMediaSourceDownloadResult = interface;
  PStreaming_Adaptive_IAdaptiveMediaSourceDownloadResult = ^Streaming_Adaptive_IAdaptiveMediaSourceDownloadResult;

  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadRequestedDeferral
  Streaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedDeferral = interface;
  PStreaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedDeferral = ^Streaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedDeferral;

  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadRequestedEventArgs
  Streaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedEventArgs = interface;
  PStreaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedEventArgs = ^Streaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource,Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadRequestedEventArgs>
  TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedEventArgs = interface;
  PTypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedEventArgs = ^TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedEventArgs;

  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadCompletedEventArgs
  Streaming_Adaptive_IAdaptiveMediaSourceDownloadCompletedEventArgs = interface;
  PStreaming_Adaptive_IAdaptiveMediaSourceDownloadCompletedEventArgs = ^Streaming_Adaptive_IAdaptiveMediaSourceDownloadCompletedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource,Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadCompletedEventArgs>
  TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadCompletedEventArgs = interface;
  PTypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadCompletedEventArgs = ^TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadCompletedEventArgs;

  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadFailedEventArgs
  Streaming_Adaptive_IAdaptiveMediaSourceDownloadFailedEventArgs = interface;
  PStreaming_Adaptive_IAdaptiveMediaSourceDownloadFailedEventArgs = ^Streaming_Adaptive_IAdaptiveMediaSourceDownloadFailedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource,Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadFailedEventArgs>
  TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadFailedEventArgs = interface;
  PTypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadFailedEventArgs = ^TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadFailedEventArgs;

  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource
  Streaming_Adaptive_IAdaptiveMediaSource = interface;
  PStreaming_Adaptive_IAdaptiveMediaSource = ^Streaming_Adaptive_IAdaptiveMediaSource;

  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceCreationResult
  Streaming_Adaptive_IAdaptiveMediaSourceCreationResult = interface;
  PStreaming_Adaptive_IAdaptiveMediaSourceCreationResult = ^Streaming_Adaptive_IAdaptiveMediaSourceCreationResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceCreationResult>
  AsyncOperationCompletedHandler_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult = interface;
  PAsyncOperationCompletedHandler_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult = ^AsyncOperationCompletedHandler_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceCreationResult>
  IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult = interface;
  PIAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult = ^IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult;

  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceStatics
  Streaming_Adaptive_IAdaptiveMediaSourceStatics = interface;
  PStreaming_Adaptive_IAdaptiveMediaSourceStatics = ^Streaming_Adaptive_IAdaptiveMediaSourceStatics;

  // Windows.Media.Core.IMediaSourceStatics
  Core_IMediaSourceStatics = interface;
  PCore_IMediaSourceStatics = ^Core_IMediaSourceStatics;

  // Windows.Media.Core.ITimedTextRegion
  Core_ITimedTextRegion = interface;
  PCore_ITimedTextRegion = ^Core_ITimedTextRegion;

  // Windows.Media.Core.ITimedTextStyle
  Core_ITimedTextStyle = interface;
  PCore_ITimedTextStyle = ^Core_ITimedTextStyle;

  // Windows.Media.Core.ITimedTextSubformat
  Core_ITimedTextSubformat = interface;
  PCore_ITimedTextSubformat = ^Core_ITimedTextSubformat;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.ITimedTextSubformat>
  IIterator_1__Core_ITimedTextSubformat = interface;
  PIIterator_1__Core_ITimedTextSubformat = ^IIterator_1__Core_ITimedTextSubformat;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.ITimedTextSubformat>
  IIterable_1__Core_ITimedTextSubformat = interface;
  PIIterable_1__Core_ITimedTextSubformat = ^IIterable_1__Core_ITimedTextSubformat;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.ITimedTextSubformat>
  IVectorView_1__Core_ITimedTextSubformat = interface;
  PIVectorView_1__Core_ITimedTextSubformat = ^IVectorView_1__Core_ITimedTextSubformat;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Core.ITimedTextSubformat>
  IVector_1__Core_ITimedTextSubformat = interface;
  PIVector_1__Core_ITimedTextSubformat = ^IVector_1__Core_ITimedTextSubformat;

  // Windows.Media.Core.ITimedTextLine
  Core_ITimedTextLine = interface;
  PCore_ITimedTextLine = ^Core_ITimedTextLine;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.ITimedTextLine>
  IIterator_1__Core_ITimedTextLine = interface;
  PIIterator_1__Core_ITimedTextLine = ^IIterator_1__Core_ITimedTextLine;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.ITimedTextLine>
  IIterable_1__Core_ITimedTextLine = interface;
  PIIterable_1__Core_ITimedTextLine = ^IIterable_1__Core_ITimedTextLine;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.ITimedTextLine>
  IVectorView_1__Core_ITimedTextLine = interface;
  PIVectorView_1__Core_ITimedTextLine = ^IVectorView_1__Core_ITimedTextLine;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Core.ITimedTextLine>
  IVector_1__Core_ITimedTextLine = interface;
  PIVector_1__Core_ITimedTextLine = ^IVector_1__Core_ITimedTextLine;

  // Windows.Media.Core.ITimedTextCue
  Core_ITimedTextCue = interface;
  PCore_ITimedTextCue = ^Core_ITimedTextCue;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.ISingleSelectMediaTrackList,Object>
  TypedEventHandler_2__Core_ISingleSelectMediaTrackList__IInspectable = interface;
  PTypedEventHandler_2__Core_ISingleSelectMediaTrackList__IInspectable = ^TypedEventHandler_2__Core_ISingleSelectMediaTrackList__IInspectable;

  // Windows.Media.Core.ISingleSelectMediaTrackList
  Core_ISingleSelectMediaTrackList = interface;
  PCore_ISingleSelectMediaTrackList = ^Core_ISingleSelectMediaTrackList;

  // Windows.Media.Core.IDataCue
  Core_IDataCue = interface;
  PCore_IDataCue = ^Core_IDataCue;

  // Windows.Media.Core.ITimedMetadataTrackFactory
  Core_ITimedMetadataTrackFactory = interface;
  PCore_ITimedMetadataTrackFactory = ^Core_ITimedMetadataTrackFactory;

  // Windows.Media.Core.ITimedTextSourceStatics
  Core_ITimedTextSourceStatics = interface;
  PCore_ITimedTextSourceStatics = ^Core_ITimedTextSourceStatics;

  // Windows.Media.Playback.IMediaPlaybackItemFactory
  Playback_IMediaPlaybackItemFactory = interface;
  PPlayback_IMediaPlaybackItemFactory = ^Playback_IMediaPlaybackItemFactory;

  // Windows.Media.Playback.IMediaPlaybackItemError
  Playback_IMediaPlaybackItemError = interface;
  PPlayback_IMediaPlaybackItemError = ^Playback_IMediaPlaybackItemError;

  // Windows.Media.Playback.IMediaEnginePlaybackSource
  Playback_IMediaEnginePlaybackSource = interface;
  PPlayback_IMediaEnginePlaybackSource = ^Playback_IMediaEnginePlaybackSource;

  // Windows.Media.Playback.IMediaPlaybackItemOpenedEventArgs
  Playback_IMediaPlaybackItemOpenedEventArgs = interface;
  PPlayback_IMediaPlaybackItemOpenedEventArgs = ^Playback_IMediaPlaybackItemOpenedEventArgs;

  // Windows.Media.Playback.IMediaPlaybackItemFailedEventArgs
  Playback_IMediaPlaybackItemFailedEventArgs = interface;
  PPlayback_IMediaPlaybackItemFailedEventArgs = ^Playback_IMediaPlaybackItemFailedEventArgs;

  // Windows.Media.Playback.ICurrentMediaPlaybackItemChangedEventArgs
  Playback_ICurrentMediaPlaybackItemChangedEventArgs = interface;
  PPlayback_ICurrentMediaPlaybackItemChangedEventArgs = ^Playback_ICurrentMediaPlaybackItemChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Playback.IMediaPlaybackList,Windows.Media.Playback.IMediaPlaybackItemFailedEventArgs>
  TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_IMediaPlaybackItemFailedEventArgs = interface;
  PTypedEventHandler_2__Playback_IMediaPlaybackList__Playback_IMediaPlaybackItemFailedEventArgs = ^TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_IMediaPlaybackItemFailedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Playback.IMediaPlaybackList,Windows.Media.Playback.ICurrentMediaPlaybackItemChangedEventArgs>
  TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_ICurrentMediaPlaybackItemChangedEventArgs = interface;
  PTypedEventHandler_2__Playback_IMediaPlaybackList__Playback_ICurrentMediaPlaybackItemChangedEventArgs = ^TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_ICurrentMediaPlaybackItemChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Playback.IMediaPlaybackList,Windows.Media.Playback.IMediaPlaybackItemOpenedEventArgs>
  TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_IMediaPlaybackItemOpenedEventArgs = interface;
  PTypedEventHandler_2__Playback_IMediaPlaybackList__Playback_IMediaPlaybackItemOpenedEventArgs = ^TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_IMediaPlaybackItemOpenedEventArgs;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Playback.IMediaPlaybackItem>
  IIterator_1__Playback_IMediaPlaybackItem = interface;
  PIIterator_1__Playback_IMediaPlaybackItem = ^IIterator_1__Playback_IMediaPlaybackItem;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Playback.IMediaPlaybackItem>
  IIterable_1__Playback_IMediaPlaybackItem = interface;
  PIIterable_1__Playback_IMediaPlaybackItem = ^IIterable_1__Playback_IMediaPlaybackItem;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Playback.IMediaPlaybackItem>
  IVectorView_1__Playback_IMediaPlaybackItem = interface;
  PIVectorView_1__Playback_IMediaPlaybackItem = ^IVectorView_1__Playback_IMediaPlaybackItem;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Playback.IMediaPlaybackItem>
  IVector_1__Playback_IMediaPlaybackItem = interface;
  PIVector_1__Playback_IMediaPlaybackItem = ^IVector_1__Playback_IMediaPlaybackItem;

  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.Media.Playback.IMediaPlaybackItem>
  VectorChangedEventHandler_1__Playback_IMediaPlaybackItem = interface;
  PVectorChangedEventHandler_1__Playback_IMediaPlaybackItem = ^VectorChangedEventHandler_1__Playback_IMediaPlaybackItem;

  // Windows.Foundation.Collections.IObservableVector`1<Windows.Media.Playback.IMediaPlaybackItem>
  IObservableVector_1__Playback_IMediaPlaybackItem = interface;
  PIObservableVector_1__Playback_IMediaPlaybackItem = ^IObservableVector_1__Playback_IMediaPlaybackItem;

  // Windows.Media.Playback.IMediaPlaybackList
  Playback_IMediaPlaybackList = interface;
  PPlayback_IMediaPlaybackList = ^Playback_IMediaPlaybackList;

  // Windows.Media.Playback.ITimedMetadataPresentationModeChangedEventArgs
  Playback_ITimedMetadataPresentationModeChangedEventArgs = interface;
  PPlayback_ITimedMetadataPresentationModeChangedEventArgs = ^Playback_ITimedMetadataPresentationModeChangedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.ITimedMetadataTrack>,Windows.Media.Playback.ITimedMetadataPresentationModeChangedEventArgs>
  TypedEventHandler_2__IVectorView_1__Core_ITimedMetadataTrack__Playback_ITimedMetadataPresentationModeChangedEventArgs = interface;
  PTypedEventHandler_2__IVectorView_1__Core_ITimedMetadataTrack__Playback_ITimedMetadataPresentationModeChangedEventArgs = ^TypedEventHandler_2__IVectorView_1__Core_ITimedMetadataTrack__Playback_ITimedMetadataPresentationModeChangedEventArgs;

  // Windows.Media.Playback.IMediaPlaybackTimedMetadataTrackList
  Playback_IMediaPlaybackTimedMetadataTrackList = interface;
  PPlayback_IMediaPlaybackTimedMetadataTrackList = ^Playback_IMediaPlaybackTimedMetadataTrackList;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.ContentRestrictions.ContentAccessRestrictionLevel>
  AsyncOperationCompletedHandler_1__ContentRestrictions_ContentAccessRestrictionLevel = interface;
  PAsyncOperationCompletedHandler_1__ContentRestrictions_ContentAccessRestrictionLevel = ^AsyncOperationCompletedHandler_1__ContentRestrictions_ContentAccessRestrictionLevel;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.ContentRestrictions.ContentAccessRestrictionLevel>
  IAsyncOperation_1__ContentRestrictions_ContentAccessRestrictionLevel = interface;
  PIAsyncOperation_1__ContentRestrictions_ContentAccessRestrictionLevel = ^IAsyncOperation_1__ContentRestrictions_ContentAccessRestrictionLevel;

  // Windows.Media.Playlists.IPlaylist
  Playlists_IPlaylist = interface;
  PPlaylists_IPlaylist = ^Playlists_IPlaylist;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Playlists.IPlaylist>
  AsyncOperationCompletedHandler_1__Playlists_IPlaylist = interface;
  PAsyncOperationCompletedHandler_1__Playlists_IPlaylist = ^AsyncOperationCompletedHandler_1__Playlists_IPlaylist;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Playlists.IPlaylist>
  IAsyncOperation_1__Playlists_IPlaylist = interface;
  PIAsyncOperation_1__Playlists_IPlaylist = ^IAsyncOperation_1__Playlists_IPlaylist;

  // Windows.Media.Playlists.IPlaylistStatics
  Playlists_IPlaylistStatics = interface;
  PPlaylists_IPlaylistStatics = ^Playlists_IPlaylistStatics;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Media.Protection.RenewalStatus,UInt32>
  AsyncOperationProgressHandler_2__Protection_RenewalStatus__Cardinal = interface;
  PAsyncOperationProgressHandler_2__Protection_RenewalStatus__Cardinal = ^AsyncOperationProgressHandler_2__Protection_RenewalStatus__Cardinal;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Media.Protection.RenewalStatus,UInt32>
  AsyncOperationWithProgressCompletedHandler_2__Protection_RenewalStatus__Cardinal = interface;
  PAsyncOperationWithProgressCompletedHandler_2__Protection_RenewalStatus__Cardinal = ^AsyncOperationWithProgressCompletedHandler_2__Protection_RenewalStatus__Cardinal;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Media.Protection.RenewalStatus,UInt32>
  IAsyncOperationWithProgress_2__Protection_RenewalStatus__Cardinal = interface;
  PIAsyncOperationWithProgress_2__Protection_RenewalStatus__Cardinal = ^IAsyncOperationWithProgress_2__Protection_RenewalStatus__Cardinal;


  // Emit Forwarded interfaces
  // Windows.Media Interfaces
  // DualAPI Interface
  // Windows.Media.IMediaFrame
  IMediaFrame = interface(IInspectable)
  ['{BFB52F8C-5943-47D8-8E10-05308AA5FBD0}']
    function get_Type: HSTRING; safecall;
    function get_IsReadOnly: Boolean; safecall;
    procedure put_RelativeTime(value: IReference_1__TimeSpan); safecall;
    function get_RelativeTime: IReference_1__TimeSpan; safecall;
    procedure put_SystemRelativeTime(value: IReference_1__TimeSpan); safecall;
    function get_SystemRelativeTime: IReference_1__TimeSpan; safecall;
    procedure put_Duration(value: IReference_1__TimeSpan); safecall;
    function get_Duration: IReference_1__TimeSpan; safecall;
    procedure put_IsDiscontinuous(value: Boolean); safecall;
    function get_IsDiscontinuous: Boolean; safecall;
    function get_ExtendedProperties: IPropertySet; safecall;
    property Duration: IReference_1__TimeSpan read get_Duration write put_Duration;
    property ExtendedProperties: IPropertySet read get_ExtendedProperties;
    property IsDiscontinuous: Boolean read get_IsDiscontinuous write put_IsDiscontinuous;
    property IsReadOnly: Boolean read get_IsReadOnly;
    property RelativeTime: IReference_1__TimeSpan read get_RelativeTime write put_RelativeTime;
    property SystemRelativeTime: IReference_1__TimeSpan read get_SystemRelativeTime write put_SystemRelativeTime;
    property &Type: HSTRING read get_Type;
  end;

  // DualAPI Interface
  // Windows.Media.IVideoFrame
  [WinRTClassNameAttribute(SVideoFrame)]
  IVideoFrame = interface(IInspectable)
  ['{0CC06625-90FC-4C92-BD95-7DED21819D1C}']
    function get_SoftwareBitmap: Imaging_ISoftwareBitmap; safecall;
    function CopyToAsync(frame: IVideoFrame): IAsyncAction; safecall;
    function get_Direct3DSurface: DirectX_Direct3D11_IDirect3DSurface; safecall;
    property Direct3DSurface: DirectX_Direct3D11_IDirect3DSurface read get_Direct3DSurface;
    property SoftwareBitmap: Imaging_ISoftwareBitmap read get_SoftwareBitmap;
  end;

  // DualAPI Interface
  // Windows.Media.IVideoFrameFactory
  [WinRTClassNameAttribute(SVideoFrame)]
  IVideoFrameFactory = interface(IInspectable)
  ['{014B6D69-2228-4C92-92FF-50C380D3E776}']
    function Create(format: Imaging_BitmapPixelFormat; width: Integer; height: Integer): IVideoFrame; safecall;
    function CreateWithAlpha(format: Imaging_BitmapPixelFormat; width: Integer; height: Integer; alpha: Imaging_BitmapAlphaMode): IVideoFrame; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.IAudioBuffer
  [WinRTClassNameAttribute(SAudioBuffer)]
  IAudioBuffer = interface(IInspectable)
  ['{35175827-724B-4C6A-B130-F6537F9AE0D0}']
    function get_Capacity: Cardinal; safecall;
    function get_Length: Cardinal; safecall;
    procedure put_Length(value: Cardinal); safecall;
    property Capacity: Cardinal read get_Capacity;
    property Length: Cardinal read get_Length write put_Length;
  end;

  // DualAPI Interface
  // Windows.Media.IAudioFrame
  [WinRTClassNameAttribute(SAudioFrame)]
  IAudioFrame = interface(IInspectable)
  ['{E36AC304-AAB2-4277-9ED0-43CEDF8E29C6}']
    function LockBuffer(mode: AudioBufferAccessMode): IAudioBuffer; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.IAudioFrameFactory
  [WinRTClassNameAttribute(SAudioFrame)]
  IAudioFrameFactory = interface(IInspectable)
  ['{91A90ADE-2422-40A6-B9AD-30D02404317D}']
    function Create(capacity: Cardinal): IAudioFrame; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Effects.IAudioEffectDefinition
  [WinRTClassNameAttribute(SEffects_AudioEffectDefinition)]
  Effects_IAudioEffectDefinition = interface(IInspectable)
  ['{E4D7F974-7D80-4F73-9089-E31C9DB9C294}']
    function get_ActivatableClassId: HSTRING; safecall;
    function get_Properties: IPropertySet; safecall;
    property ActivatableClassId: HSTRING read get_ActivatableClassId;
    property Properties: IPropertySet read get_Properties;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Effects.IAudioEffectDefinition>
  IIterator_1__Effects_IAudioEffectDefinition = interface(IInspectable)
  ['{EC0F39FC-6959-5423-9E1A-F7CB8E845CA1}']
    function get_Current: Effects_IAudioEffectDefinition; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PEffects_IAudioEffectDefinition): Cardinal; safecall;
    property Current: Effects_IAudioEffectDefinition read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Effects.IAudioEffectDefinition>
  IIterable_1__Effects_IAudioEffectDefinition = interface(IInspectable)
  ['{607A20BF-32B4-5B8E-A793-3024F8D3582A}']
    function First: IIterator_1__Effects_IAudioEffectDefinition; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Effects.IAudioEffectDefinition>
  IVectorView_1__Effects_IAudioEffectDefinition = interface(IInspectable)
  ['{DE9E6A7F-D28E-5EF1-916A-EFA880B489D1}']
    function GetAt(index: Cardinal): Effects_IAudioEffectDefinition; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Effects_IAudioEffectDefinition; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PEffects_IAudioEffectDefinition): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Effects.IAudioEffectDefinition>
  IVector_1__Effects_IAudioEffectDefinition = interface(IInspectable)
  ['{2828A982-D849-5FC9-84CE-F9A4B3B4D341}']
    function GetAt(index: Cardinal): Effects_IAudioEffectDefinition; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Effects_IAudioEffectDefinition; safecall;
    function IndexOf(value: Effects_IAudioEffectDefinition; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Effects_IAudioEffectDefinition); safecall;
    procedure InsertAt(index: Cardinal; value: Effects_IAudioEffectDefinition); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Effects_IAudioEffectDefinition); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PEffects_IAudioEffectDefinition): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PEffects_IAudioEffectDefinition); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IAudioNode
  Audio_IAudioNode = interface(IInspectable)
  ['{15389D7F-DBD8-4819-BF03-668E9357CD6D}']
    function get_EffectDefinitions: IVector_1__Effects_IAudioEffectDefinition; safecall;
    procedure put_OutgoingGain(value: Double); safecall;
    function get_OutgoingGain: Double; safecall;
    function get_EncodingProperties: IAudioEncodingProperties; safecall;
    function get_ConsumeInput: Boolean; safecall;
    procedure put_ConsumeInput(value: Boolean); safecall;
    procedure Start; safecall;
    procedure Stop; safecall;
    procedure Reset; safecall;
    procedure DisableEffectsByDefinition(definition: Effects_IAudioEffectDefinition); safecall;
    procedure EnableEffectsByDefinition(definition: Effects_IAudioEffectDefinition); safecall;
    property ConsumeInput: Boolean read get_ConsumeInput write put_ConsumeInput;
    property EffectDefinitions: IVector_1__Effects_IAudioEffectDefinition read get_EffectDefinitions;
    property EncodingProperties: IAudioEncodingProperties read get_EncodingProperties;
    property OutgoingGain: Double read get_OutgoingGain write put_OutgoingGain;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IAudioGraphConnection
  [WinRTClassNameAttribute(SAudio_AudioGraphConnection)]
  Audio_IAudioGraphConnection = interface(IInspectable)
  ['{763070ED-D04E-4FAC-B233-600B42EDD469}']
    function get_Destination: Audio_IAudioNode; safecall;
    procedure put_Gain(value: Double); safecall;
    function get_Gain: Double; safecall;
    property Destination: Audio_IAudioNode read get_Destination;
    property Gain: Double read get_Gain write put_Gain;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Audio.IAudioGraphConnection>
  IIterator_1__Audio_IAudioGraphConnection = interface(IInspectable)
  ['{7C7BD0C4-7FBA-5AF3-82DC-DC37A172EE13}']
    function get_Current: Audio_IAudioGraphConnection; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PAudio_IAudioGraphConnection): Cardinal; safecall;
    property Current: Audio_IAudioGraphConnection read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Audio.IAudioGraphConnection>
  IIterable_1__Audio_IAudioGraphConnection_Base = interface(IInspectable)
  ['{96168D06-A51A-5480-9403-FBD7631E3B3C}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Audio.IAudioGraphConnection>
  IIterable_1__Audio_IAudioGraphConnection = interface(IIterable_1__Audio_IAudioGraphConnection_Base)
  ['{52713CD2-9D0F-5FAE-A8A4-D3DBD69DBFC4}']
    function First: IIterator_1__Audio_IAudioGraphConnection; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Audio.IAudioGraphConnection>
  IVectorView_1__Audio_IAudioGraphConnection = interface(IInspectable)
  ['{56CA9249-0753-5D4C-B9AC-581BFD70E8C0}']
    function GetAt(index: Cardinal): Audio_IAudioGraphConnection; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Audio_IAudioGraphConnection; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PAudio_IAudioGraphConnection): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IAudioInputNode
  [WinRTClassNameAttribute(SAudio_AudioSubmixNode)]
  Audio_IAudioInputNode = interface(IInspectable)
  ['{D148005C-8428-4784-B7FD-A99D468C5D20}']
    function get_OutgoingConnections: IVectorView_1__Audio_IAudioGraphConnection; safecall;
    procedure AddOutgoingConnection(destination: Audio_IAudioNode); overload; safecall;
    procedure AddOutgoingConnection(destination: Audio_IAudioNode; gain: Double); overload; safecall;
    procedure RemoveOutgoingConnection(destination: Audio_IAudioNode); safecall;
    property OutgoingConnections: IVectorView_1__Audio_IAudioGraphConnection read get_OutgoingConnections;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IAudioFrameCompletedEventArgs
  [WinRTClassNameAttribute(SAudio_AudioFrameCompletedEventArgs)]
  Audio_IAudioFrameCompletedEventArgs = interface(IInspectable)
  ['{DC7C829E-0208-4504-A5A8-F0F268920A65}']
    function get_Frame: IAudioFrame; safecall;
    property Frame: IAudioFrame read get_Frame;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Audio.IAudioFrameInputNode,Windows.Media.Audio.IAudioFrameCompletedEventArgs>
  TypedEventHandler_2__Audio_IAudioFrameInputNode__Audio_IAudioFrameCompletedEventArgs_Delegate_Base = interface(IUnknown)
  ['{AD59DCFE-71B0-5E16-99C2-CD90644D8EE8}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Audio.IAudioFrameInputNode,Windows.Media.Audio.IAudioFrameCompletedEventArgs>
  TypedEventHandler_2__Audio_IAudioFrameInputNode__Audio_IAudioFrameCompletedEventArgs = interface(TypedEventHandler_2__Audio_IAudioFrameInputNode__Audio_IAudioFrameCompletedEventArgs_Delegate_Base)
  ['{87136DC3-7179-5D76-AB37-AE1936C73E61}']
    procedure Invoke(sender: Audio_IAudioFrameInputNode; args: Audio_IAudioFrameCompletedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IFrameInputNodeQuantumStartedEventArgs
  [WinRTClassNameAttribute(SAudio_FrameInputNodeQuantumStartedEventArgs)]
  Audio_IFrameInputNodeQuantumStartedEventArgs = interface(IInspectable)
  ['{3D9BD498-A306-4F06-BD9F-E9EFC8226304}']
    function get_RequiredSamples: Integer; safecall;
    property RequiredSamples: Integer read get_RequiredSamples;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Audio.IAudioFrameInputNode,Windows.Media.Audio.IFrameInputNodeQuantumStartedEventArgs>
  TypedEventHandler_2__Audio_IAudioFrameInputNode__Audio_IFrameInputNodeQuantumStartedEventArgs_Delegate_Base = interface(IUnknown)
  ['{4530D121-BB9A-57FE-922F-A98EEEDF59AF}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Audio.IAudioFrameInputNode,Windows.Media.Audio.IFrameInputNodeQuantumStartedEventArgs>
  TypedEventHandler_2__Audio_IAudioFrameInputNode__Audio_IFrameInputNodeQuantumStartedEventArgs = interface(TypedEventHandler_2__Audio_IAudioFrameInputNode__Audio_IFrameInputNodeQuantumStartedEventArgs_Delegate_Base)
  ['{E82D8A90-3812-5930-A62C-BAD415076BE6}']
    procedure Invoke(sender: Audio_IAudioFrameInputNode; args: Audio_IFrameInputNodeQuantumStartedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IAudioFrameInputNode
  [WinRTClassNameAttribute(SAudio_AudioFrameInputNode)]
  Audio_IAudioFrameInputNode = interface(IInspectable)
  ['{01B266C7-FD96-4FF5-A3C5-D27A9BF44237}']
    procedure put_PlaybackSpeedFactor(value: Double); safecall;
    function get_PlaybackSpeedFactor: Double; safecall;
    procedure AddFrame(frame: IAudioFrame); safecall;
    procedure DiscardQueuedFrames; safecall;
    function get_QueuedSampleCount: UInt64; safecall;
    function add_AudioFrameCompleted(handler: TypedEventHandler_2__Audio_IAudioFrameInputNode__Audio_IAudioFrameCompletedEventArgs): EventRegistrationToken; safecall;
    procedure remove_AudioFrameCompleted(token: EventRegistrationToken); safecall;
    function add_QuantumStarted(handler: TypedEventHandler_2__Audio_IAudioFrameInputNode__Audio_IFrameInputNodeQuantumStartedEventArgs): EventRegistrationToken; safecall;
    procedure remove_QuantumStarted(token: EventRegistrationToken); safecall;
    property PlaybackSpeedFactor: Double read get_PlaybackSpeedFactor write put_PlaybackSpeedFactor;
    property QueuedSampleCount: UInt64 read get_QueuedSampleCount;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IAudioDeviceInputNode
  [WinRTClassNameAttribute(SAudio_AudioDeviceInputNode)]
  Audio_IAudioDeviceInputNode = interface(IInspectable)
  ['{B01B6BE1-6F4E-49E2-AC01-559D62BEB3A9}']
    function get_Device: IDeviceInformation; safecall;
    property Device: IDeviceInformation read get_Device;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.ICreateAudioDeviceInputNodeResult
  [WinRTClassNameAttribute(SAudio_CreateAudioDeviceInputNodeResult)]
  Audio_ICreateAudioDeviceInputNodeResult = interface(IInspectable)
  ['{16EEC7A8-1CA7-40EF-91A4-D346E0AA1BBA}']
    function get_Status: Audio_AudioDeviceNodeCreationStatus; safecall;
    function get_DeviceInputNode: Audio_IAudioDeviceInputNode; safecall;
    property DeviceInputNode: Audio_IAudioDeviceInputNode read get_DeviceInputNode;
    property Status: Audio_AudioDeviceNodeCreationStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Audio.ICreateAudioDeviceInputNodeResult>
  AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceInputNodeResult_Delegate_Base = interface(IUnknown)
  ['{6CC56450-E4E8-59C9-83D8-63E46EACB20B}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Audio.ICreateAudioDeviceInputNodeResult>
  AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceInputNodeResult = interface(AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceInputNodeResult_Delegate_Base)
  ['{D3FBAF3D-B1BE-5447-A6B8-A24B9266B30E}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Audio_ICreateAudioDeviceInputNodeResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Audio.ICreateAudioDeviceInputNodeResult>
  IAsyncOperation_1__Audio_ICreateAudioDeviceInputNodeResult_Base = interface(IInspectable)
  ['{71AB4481-EC4A-5EE9-A342-3A31747829B8}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Audio.ICreateAudioDeviceInputNodeResult>
  IAsyncOperation_1__Audio_ICreateAudioDeviceInputNodeResult = interface(IAsyncOperation_1__Audio_ICreateAudioDeviceInputNodeResult_Base)
  ['{BE15A1DC-4FBB-5A22-8452-881A590E3ACA}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceInputNodeResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceInputNodeResult; safecall;
    function GetResults: Audio_ICreateAudioDeviceInputNodeResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceInputNodeResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IAudioFrameOutputNode
  [WinRTClassNameAttribute(SAudio_AudioFrameOutputNode)]
  Audio_IAudioFrameOutputNode = interface(IInspectable)
  ['{B847371B-3299-45F5-88B3-C9D12A3F1CC8}']
    function GetFrame: IAudioFrame; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IAudioDeviceOutputNode
  [WinRTClassNameAttribute(SAudio_AudioDeviceOutputNode)]
  Audio_IAudioDeviceOutputNode = interface(IInspectable)
  ['{362EDBFF-FF1C-4434-9E0F-BD2EF522AC82}']
    function get_Device: IDeviceInformation; safecall;
    property Device: IDeviceInformation read get_Device;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.ICreateAudioDeviceOutputNodeResult
  [WinRTClassNameAttribute(SAudio_CreateAudioDeviceOutputNodeResult)]
  Audio_ICreateAudioDeviceOutputNodeResult = interface(IInspectable)
  ['{F7776D27-1D9A-47F7-9CD4-2859CC1B7BFF}']
    function get_Status: Audio_AudioDeviceNodeCreationStatus; safecall;
    function get_DeviceOutputNode: Audio_IAudioDeviceOutputNode; safecall;
    property DeviceOutputNode: Audio_IAudioDeviceOutputNode read get_DeviceOutputNode;
    property Status: Audio_AudioDeviceNodeCreationStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Audio.ICreateAudioDeviceOutputNodeResult>
  AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceOutputNodeResult_Delegate_Base = interface(IUnknown)
  ['{EDBC9B59-7CAE-513F-B0DC-17666D37BA77}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Audio.ICreateAudioDeviceOutputNodeResult>
  AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceOutputNodeResult = interface(AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceOutputNodeResult_Delegate_Base)
  ['{8350138E-5DD6-5DC0-AEF7-2AB7C058CF3E}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Audio_ICreateAudioDeviceOutputNodeResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Audio.ICreateAudioDeviceOutputNodeResult>
  IAsyncOperation_1__Audio_ICreateAudioDeviceOutputNodeResult_Base = interface(IInspectable)
  ['{F810D730-DE15-58E0-A5F4-C159F73669ED}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Audio.ICreateAudioDeviceOutputNodeResult>
  IAsyncOperation_1__Audio_ICreateAudioDeviceOutputNodeResult = interface(IAsyncOperation_1__Audio_ICreateAudioDeviceOutputNodeResult_Base)
  ['{4CB6F751-D460-5037-AA59-E0B2314F948F}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceOutputNodeResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceOutputNodeResult; safecall;
    function GetResults: Audio_ICreateAudioDeviceOutputNodeResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Audio_ICreateAudioDeviceOutputNodeResult read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Audio.IAudioFileInputNode,Object>
  TypedEventHandler_2__Audio_IAudioFileInputNode__IInspectable_Delegate_Base = interface(IUnknown)
  ['{4481085B-8B8B-5520-9825-E9671DA2A89F}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Audio.IAudioFileInputNode,Object>
  TypedEventHandler_2__Audio_IAudioFileInputNode__IInspectable = interface(TypedEventHandler_2__Audio_IAudioFileInputNode__IInspectable_Delegate_Base)
  ['{C3299F12-9086-5F50-86EB-06FEDA10DF6E}']
    procedure Invoke(sender: Audio_IAudioFileInputNode; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IAudioFileInputNode
  [WinRTClassNameAttribute(SAudio_AudioFileInputNode)]
  Audio_IAudioFileInputNode = interface(IInspectable)
  ['{905B67C8-6F65-4CD4-8890-4694843C276D}']
    procedure put_PlaybackSpeedFactor(value: Double); safecall;
    function get_PlaybackSpeedFactor: Double; safecall;
    function get_Position: TimeSpan; safecall;
    procedure Seek(position: TimeSpan); safecall;
    function get_StartTime: IReference_1__TimeSpan; safecall;
    procedure put_StartTime(value: IReference_1__TimeSpan); safecall;
    function get_EndTime: IReference_1__TimeSpan; safecall;
    procedure put_EndTime(value: IReference_1__TimeSpan); safecall;
    function get_LoopCount: IReference_1__Integer; safecall;
    procedure put_LoopCount(value: IReference_1__Integer); safecall;
    function get_Duration: TimeSpan; safecall;
    function get_SourceFile: IStorageFile; safecall;
    function add_FileCompleted(handler: TypedEventHandler_2__Audio_IAudioFileInputNode__IInspectable): EventRegistrationToken; safecall;
    procedure remove_FileCompleted(token: EventRegistrationToken); safecall;
    property Duration: TimeSpan read get_Duration;
    property EndTime: IReference_1__TimeSpan read get_EndTime write put_EndTime;
    property LoopCount: IReference_1__Integer read get_LoopCount write put_LoopCount;
    property PlaybackSpeedFactor: Double read get_PlaybackSpeedFactor write put_PlaybackSpeedFactor;
    property Position: TimeSpan read get_Position;
    property SourceFile: IStorageFile read get_SourceFile;
    property StartTime: IReference_1__TimeSpan read get_StartTime write put_StartTime;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.ICreateAudioFileInputNodeResult
  [WinRTClassNameAttribute(SAudio_CreateAudioFileInputNodeResult)]
  Audio_ICreateAudioFileInputNodeResult = interface(IInspectable)
  ['{CE83D61C-E297-4C50-9CE7-1C7A69D6BD09}']
    function get_Status: Audio_AudioFileNodeCreationStatus; safecall;
    function get_FileInputNode: Audio_IAudioFileInputNode; safecall;
    property FileInputNode: Audio_IAudioFileInputNode read get_FileInputNode;
    property Status: Audio_AudioFileNodeCreationStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Audio.ICreateAudioFileInputNodeResult>
  AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileInputNodeResult_Delegate_Base = interface(IUnknown)
  ['{504D1EFD-C11C-506E-B8C9-AF17C771EFB5}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Audio.ICreateAudioFileInputNodeResult>
  AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileInputNodeResult = interface(AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileInputNodeResult_Delegate_Base)
  ['{74969811-B1BE-55AF-BE81-9F9280C90FB8}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Audio_ICreateAudioFileInputNodeResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Audio.ICreateAudioFileInputNodeResult>
  IAsyncOperation_1__Audio_ICreateAudioFileInputNodeResult_Base = interface(IInspectable)
  ['{473B06BF-387B-56CA-BEE1-527480272B0F}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Audio.ICreateAudioFileInputNodeResult>
  IAsyncOperation_1__Audio_ICreateAudioFileInputNodeResult = interface(IAsyncOperation_1__Audio_ICreateAudioFileInputNodeResult_Base)
  ['{09523B34-2247-58D1-ADDE-D388D76B966B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileInputNodeResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileInputNodeResult; safecall;
    function GetResults: Audio_ICreateAudioFileInputNodeResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileInputNodeResult read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Transcoding.TranscodeFailureReason>
  AsyncOperationCompletedHandler_1__Transcoding_TranscodeFailureReason_Delegate_Base = interface(IUnknown)
  ['{C42AE2BF-E194-5179-B8AD-03B51C04E1DA}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Transcoding.TranscodeFailureReason>
  AsyncOperationCompletedHandler_1__Transcoding_TranscodeFailureReason = interface(AsyncOperationCompletedHandler_1__Transcoding_TranscodeFailureReason_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Transcoding_TranscodeFailureReason; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Transcoding.TranscodeFailureReason>
  IAsyncOperation_1__Transcoding_TranscodeFailureReason_Base = interface(IInspectable)
  ['{02132510-3899-5257-BED9-A43E5149D28C}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Transcoding.TranscodeFailureReason>
  IAsyncOperation_1__Transcoding_TranscodeFailureReason = interface(IAsyncOperation_1__Transcoding_TranscodeFailureReason_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Transcoding_TranscodeFailureReason); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Transcoding_TranscodeFailureReason; safecall;
    function GetResults: Transcoding_TranscodeFailureReason; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Transcoding_TranscodeFailureReason read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IAudioFileOutputNode
  [WinRTClassNameAttribute(SAudio_AudioFileOutputNode)]
  Audio_IAudioFileOutputNode = interface(IInspectable)
  ['{50E01980-5166-4093-80F8-ADA00089E9CF}']
    function get_File: IStorageFile; safecall;
    function get_FileEncodingProfile: IMediaEncodingProfile; safecall;
    function FinalizeAsync: IAsyncOperation_1__Transcoding_TranscodeFailureReason; safecall;
    property &File: IStorageFile read get_File;
    property FileEncodingProfile: IMediaEncodingProfile read get_FileEncodingProfile;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.ICreateAudioFileOutputNodeResult
  [WinRTClassNameAttribute(SAudio_CreateAudioFileOutputNodeResult)]
  Audio_ICreateAudioFileOutputNodeResult = interface(IInspectable)
  ['{47D6BA7B-E909-453F-866E-5540CDA734FF}']
    function get_Status: Audio_AudioFileNodeCreationStatus; safecall;
    function get_FileOutputNode: Audio_IAudioFileOutputNode; safecall;
    property FileOutputNode: Audio_IAudioFileOutputNode read get_FileOutputNode;
    property Status: Audio_AudioFileNodeCreationStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Audio.ICreateAudioFileOutputNodeResult>
  AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileOutputNodeResult_Delegate_Base = interface(IUnknown)
  ['{A7A95713-A08F-5FDF-89C6-9627BCF5D80A}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Audio.ICreateAudioFileOutputNodeResult>
  AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileOutputNodeResult = interface(AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileOutputNodeResult_Delegate_Base)
  ['{7A7D880E-AFF4-5211-951C-D11439458145}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Audio_ICreateAudioFileOutputNodeResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Audio.ICreateAudioFileOutputNodeResult>
  IAsyncOperation_1__Audio_ICreateAudioFileOutputNodeResult_Base = interface(IInspectable)
  ['{1164517D-E953-5415-A5B3-4249A969BE7B}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Audio.ICreateAudioFileOutputNodeResult>
  IAsyncOperation_1__Audio_ICreateAudioFileOutputNodeResult = interface(IAsyncOperation_1__Audio_ICreateAudioFileOutputNodeResult_Base)
  ['{4D516665-1D50-592C-9E86-75AF69A44B55}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileOutputNodeResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileOutputNodeResult; safecall;
    function GetResults: Audio_ICreateAudioFileOutputNodeResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Audio_ICreateAudioFileOutputNodeResult read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Audio.IAudioGraph,Object>
  TypedEventHandler_2__Audio_IAudioGraph__IInspectable_Delegate_Base = interface(IUnknown)
  ['{E1407134-09E7-53DE-B54C-8A0659397B88}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Audio.IAudioGraph,Object>
  TypedEventHandler_2__Audio_IAudioGraph__IInspectable = interface(TypedEventHandler_2__Audio_IAudioGraph__IInspectable_Delegate_Base)
  ['{AD7722FD-63CE-595F-9867-3695871F2152}']
    procedure Invoke(sender: Audio_IAudioGraph; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IAudioGraphUnrecoverableErrorOccurredEventArgs
  [WinRTClassNameAttribute(SAudio_AudioGraphUnrecoverableErrorOccurredEventArgs)]
  Audio_IAudioGraphUnrecoverableErrorOccurredEventArgs = interface(IInspectable)
  ['{C3D9CBE0-3FF6-4FB3-B262-50D435C55423}']
    function get_Error: Audio_AudioGraphUnrecoverableError; safecall;
    property Error: Audio_AudioGraphUnrecoverableError read get_Error;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Audio.IAudioGraph,Windows.Media.Audio.IAudioGraphUnrecoverableErrorOccurredEventArgs>
  TypedEventHandler_2__Audio_IAudioGraph__Audio_IAudioGraphUnrecoverableErrorOccurredEventArgs_Delegate_Base = interface(IUnknown)
  ['{899670C9-DD7F-5F12-98CB-8B17FE80A47F}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Audio.IAudioGraph,Windows.Media.Audio.IAudioGraphUnrecoverableErrorOccurredEventArgs>
  TypedEventHandler_2__Audio_IAudioGraph__Audio_IAudioGraphUnrecoverableErrorOccurredEventArgs = interface(TypedEventHandler_2__Audio_IAudioGraph__Audio_IAudioGraphUnrecoverableErrorOccurredEventArgs_Delegate_Base)
  ['{097D4FD7-937E-5B2E-BB98-38E78447F22B}']
    procedure Invoke(sender: Audio_IAudioGraph; args: Audio_IAudioGraphUnrecoverableErrorOccurredEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IAudioGraph
  [WinRTClassNameAttribute(SAudio_AudioGraph)]
  Audio_IAudioGraph = interface(IInspectable)
  ['{1AD46EED-E48C-4E14-9660-2C4F83E9CDD8}']
    function CreateFrameInputNode: Audio_IAudioFrameInputNode; overload; safecall;
    function CreateFrameInputNode(encodingProperties: IAudioEncodingProperties): Audio_IAudioFrameInputNode; overload; safecall;
    function CreateDeviceInputNodeAsync(category: Capture_MediaCategory): IAsyncOperation_1__Audio_ICreateAudioDeviceInputNodeResult; overload; safecall;
    function CreateDeviceInputNodeAsync(category: Capture_MediaCategory; encodingProperties: IAudioEncodingProperties): IAsyncOperation_1__Audio_ICreateAudioDeviceInputNodeResult; overload; safecall;
    function CreateDeviceInputNodeAsync(category: Capture_MediaCategory; encodingProperties: IAudioEncodingProperties; device: IDeviceInformation): IAsyncOperation_1__Audio_ICreateAudioDeviceInputNodeResult; overload; safecall;
    function CreateFrameOutputNode: Audio_IAudioFrameOutputNode; overload; safecall;
    function CreateFrameOutputNode(encodingProperties: IAudioEncodingProperties): Audio_IAudioFrameOutputNode; overload; safecall;
    function CreateDeviceOutputNodeAsync: IAsyncOperation_1__Audio_ICreateAudioDeviceOutputNodeResult; safecall;
    function CreateFileInputNodeAsync(&file: IStorageFile): IAsyncOperation_1__Audio_ICreateAudioFileInputNodeResult; safecall;
    function CreateFileOutputNodeAsync(&file: IStorageFile): IAsyncOperation_1__Audio_ICreateAudioFileOutputNodeResult; overload; safecall;
    function CreateFileOutputNodeAsync(&file: IStorageFile; fileEncodingProfile: IMediaEncodingProfile): IAsyncOperation_1__Audio_ICreateAudioFileOutputNodeResult; overload; safecall;
    function CreateSubmixNode: Audio_IAudioInputNode; overload; safecall;
    function CreateSubmixNode(encodingProperties: IAudioEncodingProperties): Audio_IAudioInputNode; overload; safecall;
    procedure Start; safecall;
    procedure Stop; safecall;
    procedure ResetAllNodes; safecall;
    function add_QuantumStarted(handler: TypedEventHandler_2__Audio_IAudioGraph__IInspectable): EventRegistrationToken; safecall;
    procedure remove_QuantumStarted(token: EventRegistrationToken); safecall;
    function add_QuantumProcessed(handler: TypedEventHandler_2__Audio_IAudioGraph__IInspectable): EventRegistrationToken; safecall;
    procedure remove_QuantumProcessed(token: EventRegistrationToken); safecall;
    function add_UnrecoverableErrorOccurred(handler: TypedEventHandler_2__Audio_IAudioGraph__Audio_IAudioGraphUnrecoverableErrorOccurredEventArgs): EventRegistrationToken; safecall;
    procedure remove_UnrecoverableErrorOccurred(token: EventRegistrationToken); safecall;
    function get_CompletedQuantumCount: UInt64; safecall;
    function get_EncodingProperties: IAudioEncodingProperties; safecall;
    function get_LatencyInSamples: Integer; safecall;
    function get_PrimaryRenderDevice: IDeviceInformation; safecall;
    function get_RenderDeviceAudioProcessing: AudioProcessing; safecall;
    function get_SamplesPerQuantum: Integer; safecall;
    property CompletedQuantumCount: UInt64 read get_CompletedQuantumCount;
    property EncodingProperties: IAudioEncodingProperties read get_EncodingProperties;
    property LatencyInSamples: Integer read get_LatencyInSamples;
    property PrimaryRenderDevice: IDeviceInformation read get_PrimaryRenderDevice;
    property RenderDeviceAudioProcessing: AudioProcessing read get_RenderDeviceAudioProcessing;
    property SamplesPerQuantum: Integer read get_SamplesPerQuantum;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.ICreateAudioGraphResult
  [WinRTClassNameAttribute(SAudio_CreateAudioGraphResult)]
  Audio_ICreateAudioGraphResult = interface(IInspectable)
  ['{5453EF7E-7BDE-4B76-BB5D-48F79CFC8C0B}']
    function get_Status: Audio_AudioGraphCreationStatus; safecall;
    function get_Graph: Audio_IAudioGraph; safecall;
    property Graph: Audio_IAudioGraph read get_Graph;
    property Status: Audio_AudioGraphCreationStatus read get_Status;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IAudioGraphSettings
  [WinRTClassNameAttribute(SAudio_AudioGraphSettings)]
  Audio_IAudioGraphSettings = interface(IInspectable)
  ['{1D59647F-E6FE-4628-84F8-9D8BDBA25785}']
    function get_EncodingProperties: IAudioEncodingProperties; safecall;
    procedure put_EncodingProperties(value: IAudioEncodingProperties); safecall;
    function get_PrimaryRenderDevice: IDeviceInformation; safecall;
    procedure put_PrimaryRenderDevice(value: IDeviceInformation); safecall;
    function get_QuantumSizeSelectionMode: Audio_QuantumSizeSelectionMode; safecall;
    procedure put_QuantumSizeSelectionMode(value: Audio_QuantumSizeSelectionMode); safecall;
    function get_DesiredSamplesPerQuantum: Integer; safecall;
    procedure put_DesiredSamplesPerQuantum(value: Integer); safecall;
    function get_AudioRenderCategory: Render_AudioRenderCategory; safecall;
    procedure put_AudioRenderCategory(value: Render_AudioRenderCategory); safecall;
    function get_DesiredRenderDeviceAudioProcessing: AudioProcessing; safecall;
    procedure put_DesiredRenderDeviceAudioProcessing(value: AudioProcessing); safecall;
    property AudioRenderCategory: Render_AudioRenderCategory read get_AudioRenderCategory write put_AudioRenderCategory;
    property DesiredRenderDeviceAudioProcessing: AudioProcessing read get_DesiredRenderDeviceAudioProcessing write put_DesiredRenderDeviceAudioProcessing;
    property DesiredSamplesPerQuantum: Integer read get_DesiredSamplesPerQuantum write put_DesiredSamplesPerQuantum;
    property EncodingProperties: IAudioEncodingProperties read get_EncodingProperties write put_EncodingProperties;
    property PrimaryRenderDevice: IDeviceInformation read get_PrimaryRenderDevice write put_PrimaryRenderDevice;
    property QuantumSizeSelectionMode: Audio_QuantumSizeSelectionMode read get_QuantumSizeSelectionMode write put_QuantumSizeSelectionMode;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IAudioGraphSettingsFactory
  [WinRTClassNameAttribute(SAudio_AudioGraphSettings)]
  Audio_IAudioGraphSettingsFactory = interface(IInspectable)
  ['{A5D91CC6-C2EB-4A61-A214-1D66D75F83DA}']
    function Create(audioRenderCategory: Render_AudioRenderCategory): Audio_IAudioGraphSettings; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Audio.ICreateAudioGraphResult>
  AsyncOperationCompletedHandler_1__Audio_ICreateAudioGraphResult_Delegate_Base = interface(IUnknown)
  ['{4E660BDA-D438-5741-8B66-85FE72574AAB}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Audio.ICreateAudioGraphResult>
  AsyncOperationCompletedHandler_1__Audio_ICreateAudioGraphResult = interface(AsyncOperationCompletedHandler_1__Audio_ICreateAudioGraphResult_Delegate_Base)
  ['{1A7B6376-3D51-57BB-9489-72C6CCD7157D}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Audio_ICreateAudioGraphResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Audio.ICreateAudioGraphResult>
  IAsyncOperation_1__Audio_ICreateAudioGraphResult_Base = interface(IInspectable)
  ['{3E13B431-65CE-5BFB-B0AA-FAC8DF958B95}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Audio.ICreateAudioGraphResult>
  IAsyncOperation_1__Audio_ICreateAudioGraphResult = interface(IAsyncOperation_1__Audio_ICreateAudioGraphResult_Base)
  ['{F46C1B8D-C5CA-581F-AA97-2948BAE4E844}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Audio_ICreateAudioGraphResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Audio_ICreateAudioGraphResult; safecall;
    function GetResults: Audio_ICreateAudioGraphResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Audio_ICreateAudioGraphResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IAudioGraphStatics
  [WinRTClassNameAttribute(SAudio_AudioGraph)]
  Audio_IAudioGraphStatics = interface(IInspectable)
  ['{76EC3132-E159-4AB7-A82A-17BEB4B31E94}']
    function CreateAsync(settings: Audio_IAudioGraphSettings): IAsyncOperation_1__Audio_ICreateAudioGraphResult; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IEqualizerBand
  [WinRTClassNameAttribute(SAudio_EqualizerBand)]
  Audio_IEqualizerBand = interface(IInspectable)
  ['{C00A5A6A-262D-4B85-9BB7-43280B62ED0C}']
    function get_Bandwidth: Double; safecall;
    procedure put_Bandwidth(value: Double); safecall;
    function get_FrequencyCenter: Double; safecall;
    procedure put_FrequencyCenter(value: Double); safecall;
    function get_Gain: Double; safecall;
    procedure put_Gain(value: Double); safecall;
    property Bandwidth: Double read get_Bandwidth write put_Bandwidth;
    property FrequencyCenter: Double read get_FrequencyCenter write put_FrequencyCenter;
    property Gain: Double read get_Gain write put_Gain;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Audio.IEqualizerBand>
  IIterator_1__Audio_IEqualizerBand = interface(IInspectable)
  ['{A32D544C-1599-56FA-B966-8749B547CF9A}']
    function get_Current: Audio_IEqualizerBand; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PAudio_IEqualizerBand): Cardinal; safecall;
    property Current: Audio_IEqualizerBand read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Audio.IEqualizerBand>
  IIterable_1__Audio_IEqualizerBand_Base = interface(IInspectable)
  ['{6F76D148-023E-565A-9F09-4AD4A32AD74F}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Audio.IEqualizerBand>
  IIterable_1__Audio_IEqualizerBand = interface(IIterable_1__Audio_IEqualizerBand_Base)
  ['{5E78AB72-2967-555C-B1B1-3FDA9303A920}']
    function First: IIterator_1__Audio_IEqualizerBand; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Audio.IEqualizerBand>
  IVectorView_1__Audio_IEqualizerBand = interface(IInspectable)
  ['{BCEA7D0A-5756-58DE-9A28-0D7A22C763D7}']
    function GetAt(index: Cardinal): Audio_IEqualizerBand; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Audio_IEqualizerBand; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PAudio_IEqualizerBand): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IEqualizerEffectDefinition
  [WinRTClassNameAttribute(SAudio_EqualizerEffectDefinition)]
  Audio_IEqualizerEffectDefinition = interface(IInspectable)
  ['{023F6F1F-83FE-449A-A822-C696442D16B0}']
    function get_Bands: IVectorView_1__Audio_IEqualizerBand; safecall;
    property Bands: IVectorView_1__Audio_IEqualizerBand read get_Bands;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IEqualizerEffectDefinitionFactory
  [WinRTClassNameAttribute(SAudio_EqualizerEffectDefinition)]
  Audio_IEqualizerEffectDefinitionFactory = interface(IInspectable)
  ['{D2876FC4-D410-4EB5-9E69-C9AA1277EAF0}']
    function Create(audioGraph: Audio_IAudioGraph): Audio_IEqualizerEffectDefinition; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IReverbEffectDefinition
  [WinRTClassNameAttribute(SAudio_ReverbEffectDefinition)]
  Audio_IReverbEffectDefinition = interface(IInspectable)
  ['{4606AA89-F563-4D0A-8F6E-F0CDDFF35D84}']
    procedure put_WetDryMix(value: Double); safecall;
    function get_WetDryMix: Double; safecall;
    procedure put_ReflectionsDelay(value: Cardinal); safecall;
    function get_ReflectionsDelay: Cardinal; safecall;
    procedure put_ReverbDelay(value: Byte); safecall;
    function get_ReverbDelay: Byte; safecall;
    procedure put_RearDelay(value: Byte); safecall;
    function get_RearDelay: Byte; safecall;
    procedure put_PositionLeft(value: Byte); safecall;
    function get_PositionLeft: Byte; safecall;
    procedure put_PositionRight(value: Byte); safecall;
    function get_PositionRight: Byte; safecall;
    procedure put_PositionMatrixLeft(value: Byte); safecall;
    function get_PositionMatrixLeft: Byte; safecall;
    procedure put_PositionMatrixRight(value: Byte); safecall;
    function get_PositionMatrixRight: Byte; safecall;
    procedure put_EarlyDiffusion(value: Byte); safecall;
    function get_EarlyDiffusion: Byte; safecall;
    procedure put_LateDiffusion(value: Byte); safecall;
    function get_LateDiffusion: Byte; safecall;
    procedure put_LowEQGain(value: Byte); safecall;
    function get_LowEQGain: Byte; safecall;
    procedure put_LowEQCutoff(value: Byte); safecall;
    function get_LowEQCutoff: Byte; safecall;
    procedure put_HighEQGain(value: Byte); safecall;
    function get_HighEQGain: Byte; safecall;
    procedure put_HighEQCutoff(value: Byte); safecall;
    function get_HighEQCutoff: Byte; safecall;
    procedure put_RoomFilterFreq(value: Double); safecall;
    function get_RoomFilterFreq: Double; safecall;
    procedure put_RoomFilterMain(value: Double); safecall;
    function get_RoomFilterMain: Double; safecall;
    procedure put_RoomFilterHF(value: Double); safecall;
    function get_RoomFilterHF: Double; safecall;
    procedure put_ReflectionsGain(value: Double); safecall;
    function get_ReflectionsGain: Double; safecall;
    procedure put_ReverbGain(value: Double); safecall;
    function get_ReverbGain: Double; safecall;
    procedure put_DecayTime(value: Double); safecall;
    function get_DecayTime: Double; safecall;
    procedure put_Density(value: Double); safecall;
    function get_Density: Double; safecall;
    procedure put_RoomSize(value: Double); safecall;
    function get_RoomSize: Double; safecall;
    procedure put_DisableLateField(value: Boolean); safecall;
    function get_DisableLateField: Boolean; safecall;
    property DecayTime: Double read get_DecayTime write put_DecayTime;
    property Density: Double read get_Density write put_Density;
    property DisableLateField: Boolean read get_DisableLateField write put_DisableLateField;
    property EarlyDiffusion: Byte read get_EarlyDiffusion write put_EarlyDiffusion;
    property HighEQCutoff: Byte read get_HighEQCutoff write put_HighEQCutoff;
    property HighEQGain: Byte read get_HighEQGain write put_HighEQGain;
    property LateDiffusion: Byte read get_LateDiffusion write put_LateDiffusion;
    property LowEQCutoff: Byte read get_LowEQCutoff write put_LowEQCutoff;
    property LowEQGain: Byte read get_LowEQGain write put_LowEQGain;
    property PositionLeft: Byte read get_PositionLeft write put_PositionLeft;
    property PositionMatrixLeft: Byte read get_PositionMatrixLeft write put_PositionMatrixLeft;
    property PositionMatrixRight: Byte read get_PositionMatrixRight write put_PositionMatrixRight;
    property PositionRight: Byte read get_PositionRight write put_PositionRight;
    property RearDelay: Byte read get_RearDelay write put_RearDelay;
    property ReflectionsDelay: Cardinal read get_ReflectionsDelay write put_ReflectionsDelay;
    property ReflectionsGain: Double read get_ReflectionsGain write put_ReflectionsGain;
    property ReverbDelay: Byte read get_ReverbDelay write put_ReverbDelay;
    property ReverbGain: Double read get_ReverbGain write put_ReverbGain;
    property RoomFilterFreq: Double read get_RoomFilterFreq write put_RoomFilterFreq;
    property RoomFilterHF: Double read get_RoomFilterHF write put_RoomFilterHF;
    property RoomFilterMain: Double read get_RoomFilterMain write put_RoomFilterMain;
    property RoomSize: Double read get_RoomSize write put_RoomSize;
    property WetDryMix: Double read get_WetDryMix write put_WetDryMix;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IReverbEffectDefinitionFactory
  [WinRTClassNameAttribute(SAudio_ReverbEffectDefinition)]
  Audio_IReverbEffectDefinitionFactory = interface(IInspectable)
  ['{A7D5CBFE-100B-4FF0-9DA6-DC4E05A759F0}']
    function Create(audioGraph: Audio_IAudioGraph): Audio_IReverbEffectDefinition; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IEchoEffectDefinition
  [WinRTClassNameAttribute(SAudio_EchoEffectDefinition)]
  Audio_IEchoEffectDefinition = interface(IInspectable)
  ['{0E4D3FAA-36B8-4C91-B9DA-11F44A8A6610}']
    procedure put_WetDryMix(value: Double); safecall;
    function get_WetDryMix: Double; safecall;
    procedure put_Feedback(value: Double); safecall;
    function get_Feedback: Double; safecall;
    procedure put_Delay(value: Double); safecall;
    function get_Delay: Double; safecall;
    property Delay: Double read get_Delay write put_Delay;
    property Feedback: Double read get_Feedback write put_Feedback;
    property WetDryMix: Double read get_WetDryMix write put_WetDryMix;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.IEchoEffectDefinitionFactory
  [WinRTClassNameAttribute(SAudio_EchoEffectDefinition)]
  Audio_IEchoEffectDefinitionFactory = interface(IInspectable)
  ['{0D4E2257-AAF2-4E86-A54C-FB79DB8F6C12}']
    function Create(audioGraph: Audio_IAudioGraph): Audio_IEchoEffectDefinition; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.ILimiterEffectDefinition
  [WinRTClassNameAttribute(SAudio_LimiterEffectDefinition)]
  Audio_ILimiterEffectDefinition = interface(IInspectable)
  ['{6B755D19-2603-47BA-BDEB-39055E3486DC}']
    procedure put_Release(value: Cardinal); safecall;
    function get_Release: Cardinal; safecall;
    procedure put_Loudness(value: Cardinal); safecall;
    function get_Loudness: Cardinal; safecall;
    property Loudness: Cardinal read get_Loudness write put_Loudness;
    property Release: Cardinal read get_Release write put_Release;
  end;

  // DualAPI Interface
  // Windows.Media.Audio.ILimiterEffectDefinitionFactory
  [WinRTClassNameAttribute(SAudio_LimiterEffectDefinition)]
  Audio_ILimiterEffectDefinitionFactory = interface(IInspectable)
  ['{ECBAE6F1-61FF-45EF-B8F5-48659A57C72D}']
    function Create(audioGraph: Audio_IAudioGraph): Audio_ILimiterEffectDefinition; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Casting.ICastingSource
  [WinRTClassNameAttribute(SCasting_CastingSource)]
  Casting_ICastingSource = interface(IInspectable)
  ['{F429EA72-3467-47E6-A027-522923E9D727}']
    function get_PreferredSourceUri: IUriRuntimeClass; safecall;
    procedure put_PreferredSourceUri(value: IUriRuntimeClass); safecall;
    property PreferredSourceUri: IUriRuntimeClass read get_PreferredSourceUri write put_PreferredSourceUri;
  end;

  // DualAPI Interface
  // Windows.Media.Casting.ICastingConnectionErrorOccurredEventArgs
  [WinRTClassNameAttribute(SCasting_CastingConnectionErrorOccurredEventArgs)]
  Casting_ICastingConnectionErrorOccurredEventArgs = interface(IInspectable)
  ['{A7FB3C69-8719-4F00-81FB-961863C79A32}']
    function get_ErrorStatus: Casting_CastingConnectionErrorStatus; safecall;
    function get_Message: HSTRING; safecall;
    property ErrorStatus: Casting_CastingConnectionErrorStatus read get_ErrorStatus;
    property Message: HSTRING read get_Message;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Casting.CastingPlaybackTypes>
  AsyncOperationCompletedHandler_1__Casting_CastingPlaybackTypes_Delegate_Base = interface(IUnknown)
  ['{B55E550C-DFA8-50BE-BE8F-5D42C9DAC120}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Casting.CastingPlaybackTypes>
  AsyncOperationCompletedHandler_1__Casting_CastingPlaybackTypes = interface(AsyncOperationCompletedHandler_1__Casting_CastingPlaybackTypes_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Casting_CastingPlaybackTypes; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Casting.CastingPlaybackTypes>
  IAsyncOperation_1__Casting_CastingPlaybackTypes_Base = interface(IInspectable)
  ['{DFF10E53-4C5E-5DBA-9269-CD61881BB8B3}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Casting.CastingPlaybackTypes>
  IAsyncOperation_1__Casting_CastingPlaybackTypes = interface(IAsyncOperation_1__Casting_CastingPlaybackTypes_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Casting_CastingPlaybackTypes); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Casting_CastingPlaybackTypes; safecall;
    function GetResults: Casting_CastingPlaybackTypes; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Casting_CastingPlaybackTypes read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Casting.ICastingDevice
  [WinRTClassNameAttribute(SCasting_CastingDevice)]
  Casting_ICastingDevice = interface(IInspectable)
  ['{DE721C83-4A43-4AD1-A6D2-2492A796C3F2}']
    function get_Id: HSTRING; safecall;
    function get_FriendlyName: HSTRING; safecall;
    function get_Icon: IRandomAccessStreamWithContentType; safecall;
    function GetSupportedCastingPlaybackTypesAsync: IAsyncOperation_1__Casting_CastingPlaybackTypes; safecall;
    function CreateCastingConnection: Casting_ICastingConnection; safecall;
    property FriendlyName: HSTRING read get_FriendlyName;
    property Icon: IRandomAccessStreamWithContentType read get_Icon;
    property Id: HSTRING read get_Id;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Casting.ICastingConnection,Object>
  TypedEventHandler_2__Casting_ICastingConnection__IInspectable_Delegate_Base = interface(IUnknown)
  ['{F1576170-9B08-5A9B-87D2-C1AC47BC6681}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Casting.ICastingConnection,Object>
  TypedEventHandler_2__Casting_ICastingConnection__IInspectable = interface(TypedEventHandler_2__Casting_ICastingConnection__IInspectable_Delegate_Base)
  ['{1B9DFF83-C9B9-5F0E-BFE0-C62BF5BD9355}']
    procedure Invoke(sender: Casting_ICastingConnection; args: IInspectable); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Casting.ICastingConnection,Windows.Media.Casting.ICastingConnectionErrorOccurredEventArgs>
  TypedEventHandler_2__Casting_ICastingConnection__Casting_ICastingConnectionErrorOccurredEventArgs_Delegate_Base = interface(IUnknown)
  ['{78AFBBD0-9811-5F0E-9566-47C3E8CDD929}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Casting.ICastingConnection,Windows.Media.Casting.ICastingConnectionErrorOccurredEventArgs>
  TypedEventHandler_2__Casting_ICastingConnection__Casting_ICastingConnectionErrorOccurredEventArgs = interface(TypedEventHandler_2__Casting_ICastingConnection__Casting_ICastingConnectionErrorOccurredEventArgs_Delegate_Base)
  ['{FBFDED1E-0522-58DB-86DF-D2F4B4C786DD}']
    procedure Invoke(sender: Casting_ICastingConnection; args: Casting_ICastingConnectionErrorOccurredEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Casting.CastingConnectionErrorStatus>
  AsyncOperationCompletedHandler_1__Casting_CastingConnectionErrorStatus_Delegate_Base = interface(IUnknown)
  ['{7216A94A-A10A-5763-8E96-BF33C582ED92}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Casting.CastingConnectionErrorStatus>
  AsyncOperationCompletedHandler_1__Casting_CastingConnectionErrorStatus = interface(AsyncOperationCompletedHandler_1__Casting_CastingConnectionErrorStatus_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Casting_CastingConnectionErrorStatus; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Casting.CastingConnectionErrorStatus>
  IAsyncOperation_1__Casting_CastingConnectionErrorStatus_Base = interface(IInspectable)
  ['{25C821BC-DEB8-5850-8AF2-D3AC35426BD2}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Casting.CastingConnectionErrorStatus>
  IAsyncOperation_1__Casting_CastingConnectionErrorStatus = interface(IAsyncOperation_1__Casting_CastingConnectionErrorStatus_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Casting_CastingConnectionErrorStatus); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Casting_CastingConnectionErrorStatus; safecall;
    function GetResults: Casting_CastingConnectionErrorStatus; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Casting_CastingConnectionErrorStatus read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Casting.ICastingConnection
  [WinRTClassNameAttribute(SCasting_CastingConnection)]
  Casting_ICastingConnection = interface(IInspectable)
  ['{CD951653-C2F1-4498-8B78-5FB4CD3640DD}']
    function get_State: Casting_CastingConnectionState; safecall;
    function get_Device: Casting_ICastingDevice; safecall;
    function get_Source: Casting_ICastingSource; safecall;
    procedure put_Source(value: Casting_ICastingSource); safecall;
    function add_StateChanged(handler: TypedEventHandler_2__Casting_ICastingConnection__IInspectable): EventRegistrationToken; safecall;
    procedure remove_StateChanged(token: EventRegistrationToken); safecall;
    function add_ErrorOccurred(handler: TypedEventHandler_2__Casting_ICastingConnection__Casting_ICastingConnectionErrorOccurredEventArgs): EventRegistrationToken; safecall;
    procedure remove_ErrorOccurred(token: EventRegistrationToken); safecall;
    function RequestStartCastingAsync(value: Casting_ICastingSource): IAsyncOperation_1__Casting_CastingConnectionErrorStatus; safecall;
    function DisconnectAsync: IAsyncOperation_1__Casting_CastingConnectionErrorStatus; safecall;
    property Device: Casting_ICastingDevice read get_Device;
    property Source: Casting_ICastingSource read get_Source write put_Source;
    property State: Casting_CastingConnectionState read get_State;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Casting.ICastingDevice>
  AsyncOperationCompletedHandler_1__Casting_ICastingDevice_Delegate_Base = interface(IUnknown)
  ['{F0C69B9E-14CB-510A-8EF0-7E86D771BAAF}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Casting.ICastingDevice>
  AsyncOperationCompletedHandler_1__Casting_ICastingDevice = interface(AsyncOperationCompletedHandler_1__Casting_ICastingDevice_Delegate_Base)
  ['{B0A7DE0D-5DC5-5450-851F-5A75F11F6193}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Casting_ICastingDevice; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Casting.ICastingDevice>
  IAsyncOperation_1__Casting_ICastingDevice_Base = interface(IInspectable)
  ['{1B4EE058-4C69-5E70-8834-C1D171CC1B22}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Casting.ICastingDevice>
  IAsyncOperation_1__Casting_ICastingDevice = interface(IAsyncOperation_1__Casting_ICastingDevice_Base)
  ['{03D3EC7A-2E35-5F46-A261-5909EE4223F5}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Casting_ICastingDevice); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Casting_ICastingDevice; safecall;
    function GetResults: Casting_ICastingDevice; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Casting_ICastingDevice read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Casting.ICastingDeviceStatics
  [WinRTClassNameAttribute(SCasting_CastingDevice)]
  Casting_ICastingDeviceStatics = interface(IInspectable)
  ['{E7D958D7-4D13-4237-A365-4C4F6A4CFD2F}']
    function GetDeviceSelector(&type: Casting_CastingPlaybackTypes): HSTRING; safecall;
    function GetDeviceSelectorFromCastingSourceAsync(castingSource: Casting_ICastingSource): IAsyncOperation_1__HSTRING; safecall;
    function FromIdAsync(value: HSTRING): IAsyncOperation_1__Casting_ICastingDevice; safecall;
    function DeviceInfoSupportsCastingAsync(device: IDeviceInformation): IAsyncOperation_1__Boolean; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Casting.ICastingDeviceSelectedEventArgs
  [WinRTClassNameAttribute(SCasting_CastingDeviceSelectedEventArgs)]
  Casting_ICastingDeviceSelectedEventArgs = interface(IInspectable)
  ['{DC439E86-DD57-4D0D-9400-AF45E4FB3663}']
    function get_SelectedCastingDevice: Casting_ICastingDevice; safecall;
    property SelectedCastingDevice: Casting_ICastingDevice read get_SelectedCastingDevice;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Casting.ICastingSource>
  IIterator_1__Casting_ICastingSource = interface(IInspectable)
  ['{11D83DC6-EE20-5B3C-94FE-DDFE17F24CE0}']
    function get_Current: Casting_ICastingSource; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PCasting_ICastingSource): Cardinal; safecall;
    property Current: Casting_ICastingSource read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Casting.ICastingSource>
  IIterable_1__Casting_ICastingSource_Base = interface(IInspectable)
  ['{1ABB2CC9-46A2-58B1-91AA-28699D66D1AB}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Casting.ICastingSource>
  IIterable_1__Casting_ICastingSource = interface(IIterable_1__Casting_ICastingSource_Base)
  ['{4E266F05-5C65-51D2-A1D6-9D24CF5D4284}']
    function First: IIterator_1__Casting_ICastingSource; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Casting.ICastingSource>
  IVectorView_1__Casting_ICastingSource = interface(IInspectable)
  ['{45713C56-E6EA-5BC3-9939-C15F4F988134}']
    function GetAt(index: Cardinal): Casting_ICastingSource; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Casting_ICastingSource; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCasting_ICastingSource): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Casting.ICastingSource>
  IVector_1__Casting_ICastingSource = interface(IInspectable)
  ['{A71BC55B-7E69-532E-AFB7-86551493EF24}']
    function GetAt(index: Cardinal): Casting_ICastingSource; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Casting_ICastingSource; safecall;
    function IndexOf(value: Casting_ICastingSource; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Casting_ICastingSource); safecall;
    procedure InsertAt(index: Cardinal; value: Casting_ICastingSource); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Casting_ICastingSource); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCasting_ICastingSource): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PCasting_ICastingSource); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Casting.ICastingDevicePickerFilter
  [WinRTClassNameAttribute(SCasting_CastingDevicePickerFilter)]
  Casting_ICastingDevicePickerFilter = interface(IInspectable)
  ['{BE8C619C-B563-4354-AE33-9FDAAD8C6291}']
    function get_SupportsAudio: Boolean; safecall;
    procedure put_SupportsAudio(value: Boolean); safecall;
    function get_SupportsVideo: Boolean; safecall;
    procedure put_SupportsVideo(value: Boolean); safecall;
    function get_SupportsPictures: Boolean; safecall;
    procedure put_SupportsPictures(value: Boolean); safecall;
    function get_SupportedCastingSources: IVector_1__Casting_ICastingSource; safecall;
    property SupportedCastingSources: IVector_1__Casting_ICastingSource read get_SupportedCastingSources;
    property SupportsAudio: Boolean read get_SupportsAudio write put_SupportsAudio;
    property SupportsPictures: Boolean read get_SupportsPictures write put_SupportsPictures;
    property SupportsVideo: Boolean read get_SupportsVideo write put_SupportsVideo;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Casting.ICastingDevicePicker,Windows.Media.Casting.ICastingDeviceSelectedEventArgs>
  TypedEventHandler_2__Casting_ICastingDevicePicker__Casting_ICastingDeviceSelectedEventArgs_Delegate_Base = interface(IUnknown)
  ['{B3655B33-C4AD-5F4C-A187-B2E4C770A16B}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Casting.ICastingDevicePicker,Windows.Media.Casting.ICastingDeviceSelectedEventArgs>
  TypedEventHandler_2__Casting_ICastingDevicePicker__Casting_ICastingDeviceSelectedEventArgs = interface(TypedEventHandler_2__Casting_ICastingDevicePicker__Casting_ICastingDeviceSelectedEventArgs_Delegate_Base)
  ['{403A3B9B-BC19-5C05-8476-D285105333BA}']
    procedure Invoke(sender: Casting_ICastingDevicePicker; args: Casting_ICastingDeviceSelectedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Casting.ICastingDevicePicker,Object>
  TypedEventHandler_2__Casting_ICastingDevicePicker__IInspectable_Delegate_Base = interface(IUnknown)
  ['{A64B972B-AA63-5C61-9CDE-CD6FFEA8A247}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Casting.ICastingDevicePicker,Object>
  TypedEventHandler_2__Casting_ICastingDevicePicker__IInspectable = interface(TypedEventHandler_2__Casting_ICastingDevicePicker__IInspectable_Delegate_Base)
  ['{74A94C43-5E45-59C3-BEE5-61A76D66B5FF}']
    procedure Invoke(sender: Casting_ICastingDevicePicker; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Casting.ICastingDevicePicker
  [WinRTClassNameAttribute(SCasting_CastingDevicePicker)]
  Casting_ICastingDevicePicker = interface(IInspectable)
  ['{DCD39924-0591-49BE-AACB-4B82EE756A95}']
    function get_Filter: Casting_ICastingDevicePickerFilter; safecall;
    function get_Appearance: IDevicePickerAppearance; safecall;
    function add_CastingDeviceSelected(handler: TypedEventHandler_2__Casting_ICastingDevicePicker__Casting_ICastingDeviceSelectedEventArgs): EventRegistrationToken; safecall;
    procedure remove_CastingDeviceSelected(token: EventRegistrationToken); safecall;
    function add_CastingDevicePickerDismissed(handler: TypedEventHandler_2__Casting_ICastingDevicePicker__IInspectable): EventRegistrationToken; safecall;
    procedure remove_CastingDevicePickerDismissed(token: EventRegistrationToken); safecall;
    procedure Show(selection: TRectF); overload; safecall;
    procedure Show(selection: TRectF; preferredPlacement: Popups_Placement); overload; safecall;
    procedure Hide; safecall;
    property Appearance: IDevicePickerAppearance read get_Appearance;
    property Filter: Casting_ICastingDevicePickerFilter read get_Filter;
  end;

  // Windows.Media.DialProtocol.IDialAppStateDetails
  DialProtocol_IDialAppStateDetails = interface(IInspectable)
  ['{DDC4A4A1-F5DE-400D-BEA4-8C8466BB2961}']
    function get_State: DialProtocol_DialAppState; safecall;
    function get_FullXml: HSTRING; safecall;
    property FullXml: HSTRING read get_FullXml;
    property State: DialProtocol_DialAppState read get_State;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.DialProtocol.DialAppLaunchResult>
  AsyncOperationCompletedHandler_1__DialProtocol_DialAppLaunchResult_Delegate_Base = interface(IUnknown)
  ['{164C0AA8-3D2B-579B-94A3-CC4925C695EC}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.DialProtocol.DialAppLaunchResult>
  AsyncOperationCompletedHandler_1__DialProtocol_DialAppLaunchResult = interface(AsyncOperationCompletedHandler_1__DialProtocol_DialAppLaunchResult_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__DialProtocol_DialAppLaunchResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.DialProtocol.DialAppLaunchResult>
  IAsyncOperation_1__DialProtocol_DialAppLaunchResult_Base = interface(IInspectable)
  ['{4512C15E-1FC4-5648-BD49-51533A3FE6B4}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.DialProtocol.DialAppLaunchResult>
  IAsyncOperation_1__DialProtocol_DialAppLaunchResult = interface(IAsyncOperation_1__DialProtocol_DialAppLaunchResult_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__DialProtocol_DialAppLaunchResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__DialProtocol_DialAppLaunchResult; safecall;
    function GetResults: DialProtocol_DialAppLaunchResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__DialProtocol_DialAppLaunchResult read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.DialProtocol.DialAppStopResult>
  AsyncOperationCompletedHandler_1__DialProtocol_DialAppStopResult_Delegate_Base = interface(IUnknown)
  ['{C755F54A-EF7B-563A-9B14-462E72D9665A}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.DialProtocol.DialAppStopResult>
  AsyncOperationCompletedHandler_1__DialProtocol_DialAppStopResult = interface(AsyncOperationCompletedHandler_1__DialProtocol_DialAppStopResult_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__DialProtocol_DialAppStopResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.DialProtocol.DialAppStopResult>
  IAsyncOperation_1__DialProtocol_DialAppStopResult_Base = interface(IInspectable)
  ['{8598F24E-0D62-517A-961C-31FCA73ACEDD}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.DialProtocol.DialAppStopResult>
  IAsyncOperation_1__DialProtocol_DialAppStopResult = interface(IAsyncOperation_1__DialProtocol_DialAppStopResult_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__DialProtocol_DialAppStopResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__DialProtocol_DialAppStopResult; safecall;
    function GetResults: DialProtocol_DialAppStopResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__DialProtocol_DialAppStopResult read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.DialProtocol.IDialAppStateDetails>
  AsyncOperationCompletedHandler_1__DialProtocol_IDialAppStateDetails_Delegate_Base = interface(IUnknown)
  ['{38C62DD5-1F16-55C0-8EC7-CA0FC841D614}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.DialProtocol.IDialAppStateDetails>
  AsyncOperationCompletedHandler_1__DialProtocol_IDialAppStateDetails = interface(AsyncOperationCompletedHandler_1__DialProtocol_IDialAppStateDetails_Delegate_Base)
  ['{A16156BC-153F-5EAD-9718-FACE28E16A95}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__DialProtocol_IDialAppStateDetails; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.DialProtocol.IDialAppStateDetails>
  IAsyncOperation_1__DialProtocol_IDialAppStateDetails_Base = interface(IInspectable)
  ['{E50A07A2-2CEF-5FC7-B14C-D6DD8517C58E}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.DialProtocol.IDialAppStateDetails>
  IAsyncOperation_1__DialProtocol_IDialAppStateDetails = interface(IAsyncOperation_1__DialProtocol_IDialAppStateDetails_Base)
  ['{8E5B4DD6-2050-5B27-BF3D-122463A3A3CD}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__DialProtocol_IDialAppStateDetails); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__DialProtocol_IDialAppStateDetails; safecall;
    function GetResults: DialProtocol_IDialAppStateDetails; safecall;
    property Completed: AsyncOperationCompletedHandler_1__DialProtocol_IDialAppStateDetails read get_Completed write put_Completed;
  end;

  // Windows.Media.DialProtocol.IDialApp
  DialProtocol_IDialApp = interface(IInspectable)
  ['{555FFBD3-45B7-49F3-BBD7-302DB6084646}']
    function get_AppName: HSTRING; safecall;
    function RequestLaunchAsync(appArgument: HSTRING): IAsyncOperation_1__DialProtocol_DialAppLaunchResult; safecall;
    function StopAsync: IAsyncOperation_1__DialProtocol_DialAppStopResult; safecall;
    function GetAppStateAsync: IAsyncOperation_1__DialProtocol_IDialAppStateDetails; safecall;
    property AppName: HSTRING read get_AppName;
  end;

  // Windows.Media.DialProtocol.IDialDevice
  DialProtocol_IDialDevice = interface(IInspectable)
  ['{FFF0EDAF-759F-41D2-A20A-7F29CE0B3784}']
    function get_Id: HSTRING; safecall;
    function GetDialApp(appName: HSTRING): DialProtocol_IDialApp; safecall;
    property Id: HSTRING read get_Id;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.DialProtocol.IDialDevice>
  AsyncOperationCompletedHandler_1__DialProtocol_IDialDevice_Delegate_Base = interface(IUnknown)
  ['{81BC7D1B-7D06-555F-811B-42EC0FA71B55}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.DialProtocol.IDialDevice>
  AsyncOperationCompletedHandler_1__DialProtocol_IDialDevice = interface(AsyncOperationCompletedHandler_1__DialProtocol_IDialDevice_Delegate_Base)
  ['{2DE4643B-1D68-5BD1-B49D-25E8D8F84147}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__DialProtocol_IDialDevice; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.DialProtocol.IDialDevice>
  IAsyncOperation_1__DialProtocol_IDialDevice_Base = interface(IInspectable)
  ['{471CADA5-1EE4-51C0-B6B5-BF72F5F50422}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.DialProtocol.IDialDevice>
  IAsyncOperation_1__DialProtocol_IDialDevice = interface(IAsyncOperation_1__DialProtocol_IDialDevice_Base)
  ['{91136866-7F9F-5D80-B952-1FD092B571D8}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__DialProtocol_IDialDevice); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__DialProtocol_IDialDevice; safecall;
    function GetResults: DialProtocol_IDialDevice; safecall;
    property Completed: AsyncOperationCompletedHandler_1__DialProtocol_IDialDevice read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.DialProtocol.IDialDeviceSelectedEventArgs
  [WinRTClassNameAttribute(SDialProtocol_DialDeviceSelectedEventArgs)]
  DialProtocol_IDialDeviceSelectedEventArgs = interface(IInspectable)
  ['{480B92AD-AC76-47EB-9C06-A19304DA0247}']
    function get_SelectedDialDevice: DialProtocol_IDialDevice; safecall;
    property SelectedDialDevice: DialProtocol_IDialDevice read get_SelectedDialDevice;
  end;

  // DualAPI Interface
  // Windows.Media.DialProtocol.IDialDisconnectButtonClickedEventArgs
  [WinRTClassNameAttribute(SDialProtocol_DialDisconnectButtonClickedEventArgs)]
  DialProtocol_IDialDisconnectButtonClickedEventArgs = interface(IInspectable)
  ['{52765152-9C81-4E55-ADC2-0EBE99CDE3B6}']
    function get_Device: DialProtocol_IDialDevice; safecall;
    property Device: DialProtocol_IDialDevice read get_Device;
  end;

  // DualAPI Interface
  // Windows.Media.DialProtocol.IDialDevicePickerFilter
  [WinRTClassNameAttribute(SDialProtocol_DialDevicePickerFilter)]
  DialProtocol_IDialDevicePickerFilter = interface(IInspectable)
  ['{C17C93BA-86C0-485D-B8D6-0F9A8F641590}']
    function get_SupportedAppNames: IVector_1__HSTRING; safecall;
    property SupportedAppNames: IVector_1__HSTRING read get_SupportedAppNames;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.DialProtocol.IDialDevicePicker,Windows.Media.DialProtocol.IDialDeviceSelectedEventArgs>
  TypedEventHandler_2__DialProtocol_IDialDevicePicker__DialProtocol_IDialDeviceSelectedEventArgs_Delegate_Base = interface(IUnknown)
  ['{8375C0D7-E7C3-56BC-9880-46B69CA10D45}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.DialProtocol.IDialDevicePicker,Windows.Media.DialProtocol.IDialDeviceSelectedEventArgs>
  TypedEventHandler_2__DialProtocol_IDialDevicePicker__DialProtocol_IDialDeviceSelectedEventArgs = interface(TypedEventHandler_2__DialProtocol_IDialDevicePicker__DialProtocol_IDialDeviceSelectedEventArgs_Delegate_Base)
  ['{66E97340-5F01-570E-80FD-38CA3D3C8A6C}']
    procedure Invoke(sender: DialProtocol_IDialDevicePicker; args: DialProtocol_IDialDeviceSelectedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.DialProtocol.IDialDevicePicker,Windows.Media.DialProtocol.IDialDisconnectButtonClickedEventArgs>
  TypedEventHandler_2__DialProtocol_IDialDevicePicker__DialProtocol_IDialDisconnectButtonClickedEventArgs_Delegate_Base = interface(IUnknown)
  ['{13492AF0-1C7F-57E8-B57E-A5AE8F2C462E}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.DialProtocol.IDialDevicePicker,Windows.Media.DialProtocol.IDialDisconnectButtonClickedEventArgs>
  TypedEventHandler_2__DialProtocol_IDialDevicePicker__DialProtocol_IDialDisconnectButtonClickedEventArgs = interface(TypedEventHandler_2__DialProtocol_IDialDevicePicker__DialProtocol_IDialDisconnectButtonClickedEventArgs_Delegate_Base)
  ['{C144F3DB-C6C9-5207-8ABA-3B28650B89EC}']
    procedure Invoke(sender: DialProtocol_IDialDevicePicker; args: DialProtocol_IDialDisconnectButtonClickedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.DialProtocol.IDialDevicePicker,Object>
  TypedEventHandler_2__DialProtocol_IDialDevicePicker__IInspectable_Delegate_Base = interface(IUnknown)
  ['{DAC94028-1B44-5F45-B9E3-ABCF4AB044BF}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.DialProtocol.IDialDevicePicker,Object>
  TypedEventHandler_2__DialProtocol_IDialDevicePicker__IInspectable = interface(TypedEventHandler_2__DialProtocol_IDialDevicePicker__IInspectable_Delegate_Base)
  ['{A12903C1-1444-55CF-8B95-806AD3EA4E64}']
    procedure Invoke(sender: DialProtocol_IDialDevicePicker; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.DialProtocol.IDialDevicePicker
  [WinRTClassNameAttribute(SDialProtocol_DialDevicePicker)]
  DialProtocol_IDialDevicePicker = interface(IInspectable)
  ['{BA7E520A-FF59-4F4B-BDAC-D89F495AD6E1}']
    function get_Filter: DialProtocol_IDialDevicePickerFilter; safecall;
    function get_Appearance: IDevicePickerAppearance; safecall;
    function add_DialDeviceSelected(handler: TypedEventHandler_2__DialProtocol_IDialDevicePicker__DialProtocol_IDialDeviceSelectedEventArgs): EventRegistrationToken; safecall;
    procedure remove_DialDeviceSelected(token: EventRegistrationToken); safecall;
    function add_DisconnectButtonClicked(handler: TypedEventHandler_2__DialProtocol_IDialDevicePicker__DialProtocol_IDialDisconnectButtonClickedEventArgs): EventRegistrationToken; safecall;
    procedure remove_DisconnectButtonClicked(token: EventRegistrationToken); safecall;
    function add_DialDevicePickerDismissed(handler: TypedEventHandler_2__DialProtocol_IDialDevicePicker__IInspectable): EventRegistrationToken; safecall;
    procedure remove_DialDevicePickerDismissed(token: EventRegistrationToken); safecall;
    procedure Show(selection: TRectF); overload; safecall;
    procedure Show(selection: TRectF; preferredPlacement: Popups_Placement); overload; safecall;
    function PickSingleDialDeviceAsync(selection: TRectF): IAsyncOperation_1__DialProtocol_IDialDevice; overload; safecall;
    function PickSingleDialDeviceAsync(selection: TRectF; preferredPlacement: Popups_Placement): IAsyncOperation_1__DialProtocol_IDialDevice; overload; safecall;
    procedure Hide; safecall;
    procedure SetDisplayStatus(device: DialProtocol_IDialDevice; status: DialProtocol_DialDeviceDisplayStatus); safecall;
    property Appearance: IDevicePickerAppearance read get_Appearance;
    property Filter: DialProtocol_IDialDevicePickerFilter read get_Filter;
  end;

  // DualAPI Interface
  // Windows.Media.Effects.IVideoCompositorDefinition
  [WinRTClassNameAttribute(SEffects_VideoCompositorDefinition)]
  Effects_IVideoCompositorDefinition = interface(IInspectable)
  ['{7946B8D0-2010-4AE3-9AB2-2CEF42EDD4D2}']
    function get_ActivatableClassId: HSTRING; safecall;
    function get_Properties: IPropertySet; safecall;
    property ActivatableClassId: HSTRING read get_ActivatableClassId;
    property Properties: IPropertySet read get_Properties;
  end;

  // DualAPI Interface
  // Windows.Media.Effects.IVideoCompositorDefinitionFactory
  [WinRTClassNameAttribute(SEffects_VideoCompositorDefinition)]
  Effects_IVideoCompositorDefinitionFactory = interface(IInspectable)
  ['{4366FD10-68B8-4D52-89B6-02A968CCA899}']
    function Create(activatableClassId: HSTRING): Effects_IVideoCompositorDefinition; safecall;
    function CreateWithProperties(activatableClassId: HSTRING; props: IPropertySet): Effects_IVideoCompositorDefinition; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Editing.IEmbeddedAudioTrack
  [WinRTClassNameAttribute(SEditing_EmbeddedAudioTrack)]
  Editing_IEmbeddedAudioTrack = interface(IInspectable)
  ['{55EE5A7A-2D30-3FBA-A190-4F1A6454F88F}']
    function GetAudioEncodingProperties: IAudioEncodingProperties; safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Editing.IEmbeddedAudioTrack>
  IIterator_1__Editing_IEmbeddedAudioTrack = interface(IInspectable)
  ['{A457FE75-3D28-5A78-95F9-9A2B79D95994}']
    function get_Current: Editing_IEmbeddedAudioTrack; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PEditing_IEmbeddedAudioTrack): Cardinal; safecall;
    property Current: Editing_IEmbeddedAudioTrack read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Editing.IEmbeddedAudioTrack>
  IIterable_1__Editing_IEmbeddedAudioTrack_Base = interface(IInspectable)
  ['{32FABED0-E1E6-578E-86E5-B4E6ABEB22D6}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Editing.IEmbeddedAudioTrack>
  IIterable_1__Editing_IEmbeddedAudioTrack = interface(IIterable_1__Editing_IEmbeddedAudioTrack_Base)
  ['{5F1F3071-3D4A-5C50-8D07-85F2DB66F6D1}']
    function First: IIterator_1__Editing_IEmbeddedAudioTrack; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Editing.IEmbeddedAudioTrack>
  IVectorView_1__Editing_IEmbeddedAudioTrack = interface(IInspectable)
  ['{4721D1E5-015C-5C79-85A8-384AE06EC54C}']
    function GetAt(index: Cardinal): Editing_IEmbeddedAudioTrack; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Editing_IEmbeddedAudioTrack; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PEditing_IEmbeddedAudioTrack): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Effects.IVideoEffectDefinition
  [WinRTClassNameAttribute(SCore_VideoStabilizationEffectDefinition)]
  Effects_IVideoEffectDefinition = interface(IInspectable)
  ['{39F38CF0-8D0F-4F3E-84FC-2D46A5297943}']
    function get_ActivatableClassId: HSTRING; safecall;
    function get_Properties: IPropertySet; safecall;
    property ActivatableClassId: HSTRING read get_ActivatableClassId;
    property Properties: IPropertySet read get_Properties;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Effects.IVideoEffectDefinition>
  IIterator_1__Effects_IVideoEffectDefinition = interface(IInspectable)
  ['{9D82379D-4958-558E-A155-3A809BB16C04}']
    function get_Current: Effects_IVideoEffectDefinition; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PEffects_IVideoEffectDefinition): Cardinal; safecall;
    property Current: Effects_IVideoEffectDefinition read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Effects.IVideoEffectDefinition>
  IIterable_1__Effects_IVideoEffectDefinition = interface(IInspectable)
  ['{EB567F6F-B014-513D-99CD-F16C226C3C41}']
    function First: IIterator_1__Effects_IVideoEffectDefinition; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Effects.IVideoEffectDefinition>
  IVectorView_1__Effects_IVideoEffectDefinition = interface(IInspectable)
  ['{A44B4F8E-7CA3-53B1-B68B-098BAF45C73E}']
    function GetAt(index: Cardinal): Effects_IVideoEffectDefinition; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Effects_IVideoEffectDefinition; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PEffects_IVideoEffectDefinition): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Effects.IVideoEffectDefinition>
  IVector_1__Effects_IVideoEffectDefinition = interface(IInspectable)
  ['{7CA161ED-E201-5615-AACC-25348564F0B3}']
    function GetAt(index: Cardinal): Effects_IVideoEffectDefinition; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Effects_IVideoEffectDefinition; safecall;
    function IndexOf(value: Effects_IVideoEffectDefinition; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Effects_IVideoEffectDefinition); safecall;
    procedure InsertAt(index: Cardinal; value: Effects_IVideoEffectDefinition); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Effects_IVideoEffectDefinition); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PEffects_IVideoEffectDefinition): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PEffects_IVideoEffectDefinition); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Editing.IMediaClip
  [WinRTClassNameAttribute(SEditing_MediaClip)]
  Editing_IMediaClip = interface(IInspectable)
  ['{53F25366-5FBA-3EA4-8693-24761811140A}']
    function get_TrimTimeFromStart: TimeSpan; safecall;
    procedure put_TrimTimeFromStart(value: TimeSpan); safecall;
    function get_TrimTimeFromEnd: TimeSpan; safecall;
    procedure put_TrimTimeFromEnd(value: TimeSpan); safecall;
    function get_OriginalDuration: TimeSpan; safecall;
    function get_TrimmedDuration: TimeSpan; safecall;
    function get_UserData: IMap_2__HSTRING__HSTRING; safecall;
    function Clone: Editing_IMediaClip; safecall;
    function get_StartTimeInComposition: TimeSpan; safecall;
    function get_EndTimeInComposition: TimeSpan; safecall;
    function get_EmbeddedAudioTracks: IVectorView_1__Editing_IEmbeddedAudioTrack; safecall;
    function get_SelectedEmbeddedAudioTrackIndex: Cardinal; safecall;
    procedure put_SelectedEmbeddedAudioTrackIndex(value: Cardinal); safecall;
    procedure put_Volume(value: Double); safecall;
    function get_Volume: Double; safecall;
    function GetVideoEncodingProperties: IVideoEncodingProperties; safecall;
    function get_AudioEffectDefinitions: IVector_1__Effects_IAudioEffectDefinition; safecall;
    function get_VideoEffectDefinitions: IVector_1__Effects_IVideoEffectDefinition; safecall;
    property AudioEffectDefinitions: IVector_1__Effects_IAudioEffectDefinition read get_AudioEffectDefinitions;
    property EmbeddedAudioTracks: IVectorView_1__Editing_IEmbeddedAudioTrack read get_EmbeddedAudioTracks;
    property EndTimeInComposition: TimeSpan read get_EndTimeInComposition;
    property OriginalDuration: TimeSpan read get_OriginalDuration;
    property SelectedEmbeddedAudioTrackIndex: Cardinal read get_SelectedEmbeddedAudioTrackIndex write put_SelectedEmbeddedAudioTrackIndex;
    property StartTimeInComposition: TimeSpan read get_StartTimeInComposition;
    property TrimTimeFromEnd: TimeSpan read get_TrimTimeFromEnd write put_TrimTimeFromEnd;
    property TrimTimeFromStart: TimeSpan read get_TrimTimeFromStart write put_TrimTimeFromStart;
    property TrimmedDuration: TimeSpan read get_TrimmedDuration;
    property UserData: IMap_2__HSTRING__HSTRING read get_UserData;
    property VideoEffectDefinitions: IVector_1__Effects_IVideoEffectDefinition read get_VideoEffectDefinitions;
    property Volume: Double read get_Volume write put_Volume;
  end;

  // DualAPI Interface
  // Windows.Media.Editing.IMediaOverlay
  [WinRTClassNameAttribute(SEditing_MediaOverlay)]
  Editing_IMediaOverlay = interface(IInspectable)
  ['{A902AE5D-7869-4830-8AB1-94DC01C05FA4}']
    function get_Position: TRectF; safecall;
    procedure put_Position(value: TRectF); safecall;
    procedure put_Delay(value: TimeSpan); safecall;
    function get_Delay: TimeSpan; safecall;
    function get_Opacity: Double; safecall;
    procedure put_Opacity(value: Double); safecall;
    function Clone: Editing_IMediaOverlay; safecall;
    function get_Clip: Editing_IMediaClip; safecall;
    function get_AudioEnabled: Boolean; safecall;
    procedure put_AudioEnabled(value: Boolean); safecall;
    property AudioEnabled: Boolean read get_AudioEnabled write put_AudioEnabled;
    property Clip: Editing_IMediaClip read get_Clip;
    property Delay: TimeSpan read get_Delay write put_Delay;
    property Opacity: Double read get_Opacity write put_Opacity;
    property Position: TRectF read get_Position write put_Position;
  end;

  // DualAPI Interface
  // Windows.Media.Effects.ICompositeVideoFrameContext
  [WinRTClassNameAttribute(SEffects_CompositeVideoFrameContext)]
  Effects_ICompositeVideoFrameContext = interface(IInspectable)
  ['{6C30024B-F514-4278-A5F7-B9188049D110}']
    function get_SurfacesToOverlay: IVectorView_1__DirectX_Direct3D11_IDirect3DSurface; safecall;
    function get_BackgroundFrame: IVideoFrame; safecall;
    function get_OutputFrame: IVideoFrame; safecall;
    function GetOverlayForSurface(surfaceToOverlay: DirectX_Direct3D11_IDirect3DSurface): Editing_IMediaOverlay; safecall;
    property BackgroundFrame: IVideoFrame read get_BackgroundFrame;
    property OutputFrame: IVideoFrame read get_OutputFrame;
    property SurfacesToOverlay: IVectorView_1__DirectX_Direct3D11_IDirect3DSurface read get_SurfacesToOverlay;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Editing.IMediaClip>
  IIterator_1__Editing_IMediaClip = interface(IInspectable)
  ['{54A2E07F-5DD7-53AF-93B7-E4BB8AF40D71}']
    function get_Current: Editing_IMediaClip; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PEditing_IMediaClip): Cardinal; safecall;
    property Current: Editing_IMediaClip read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Editing.IMediaClip>
  IIterable_1__Editing_IMediaClip_Base = interface(IInspectable)
  ['{FF2E9B5C-26D0-575D-A3EB-7D938BD16F17}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Editing.IMediaClip>
  IIterable_1__Editing_IMediaClip = interface(IIterable_1__Editing_IMediaClip_Base)
  ['{A31E1D08-4635-56A2-834D-D628D7EAA025}']
    function First: IIterator_1__Editing_IMediaClip; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Editing.IMediaClip>
  IVectorView_1__Editing_IMediaClip = interface(IInspectable)
  ['{92688D76-BA1C-54AF-93A3-34F4D307E8B0}']
    function GetAt(index: Cardinal): Editing_IMediaClip; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Editing_IMediaClip; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PEditing_IMediaClip): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Editing.IMediaClip>
  IVector_1__Editing_IMediaClip = interface(IInspectable)
  ['{93C531EC-879C-51F1-9425-BB736DAB7576}']
    function GetAt(index: Cardinal): Editing_IMediaClip; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Editing_IMediaClip; safecall;
    function IndexOf(value: Editing_IMediaClip; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Editing_IMediaClip); safecall;
    procedure InsertAt(index: Cardinal; value: Editing_IMediaClip); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Editing_IMediaClip); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PEditing_IMediaClip): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PEditing_IMediaClip); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Editing.IBackgroundAudioTrack
  [WinRTClassNameAttribute(SEditing_BackgroundAudioTrack)]
  Editing_IBackgroundAudioTrack = interface(IInspectable)
  ['{4B91B3BD-9E21-4266-A9C2-67DD011A2357}']
    function get_TrimTimeFromStart: TimeSpan; safecall;
    procedure put_TrimTimeFromStart(value: TimeSpan); safecall;
    function get_TrimTimeFromEnd: TimeSpan; safecall;
    procedure put_TrimTimeFromEnd(value: TimeSpan); safecall;
    function get_OriginalDuration: TimeSpan; safecall;
    function get_TrimmedDuration: TimeSpan; safecall;
    function get_UserData: IMap_2__HSTRING__HSTRING; safecall;
    procedure put_Delay(value: TimeSpan); safecall;
    function get_Delay: TimeSpan; safecall;
    procedure put_Volume(value: Double); safecall;
    function get_Volume: Double; safecall;
    function Clone: Editing_IBackgroundAudioTrack; safecall;
    function GetAudioEncodingProperties: IAudioEncodingProperties; safecall;
    function get_AudioEffectDefinitions: IVector_1__Effects_IAudioEffectDefinition; safecall;
    property AudioEffectDefinitions: IVector_1__Effects_IAudioEffectDefinition read get_AudioEffectDefinitions;
    property Delay: TimeSpan read get_Delay write put_Delay;
    property OriginalDuration: TimeSpan read get_OriginalDuration;
    property TrimTimeFromEnd: TimeSpan read get_TrimTimeFromEnd write put_TrimTimeFromEnd;
    property TrimTimeFromStart: TimeSpan read get_TrimTimeFromStart write put_TrimTimeFromStart;
    property TrimmedDuration: TimeSpan read get_TrimmedDuration;
    property UserData: IMap_2__HSTRING__HSTRING read get_UserData;
    property Volume: Double read get_Volume write put_Volume;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Editing.IBackgroundAudioTrack>
  IIterator_1__Editing_IBackgroundAudioTrack = interface(IInspectable)
  ['{173F9DCA-3476-5BDF-9C49-1537141B20E3}']
    function get_Current: Editing_IBackgroundAudioTrack; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PEditing_IBackgroundAudioTrack): Cardinal; safecall;
    property Current: Editing_IBackgroundAudioTrack read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Editing.IBackgroundAudioTrack>
  IIterable_1__Editing_IBackgroundAudioTrack_Base = interface(IInspectable)
  ['{3FC05BA2-30F6-5219-9047-1197FFAE8DBA}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Editing.IBackgroundAudioTrack>
  IIterable_1__Editing_IBackgroundAudioTrack = interface(IIterable_1__Editing_IBackgroundAudioTrack_Base)
  ['{184B8107-785C-5344-A12D-4473A05EA38A}']
    function First: IIterator_1__Editing_IBackgroundAudioTrack; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Editing.IBackgroundAudioTrack>
  IVectorView_1__Editing_IBackgroundAudioTrack = interface(IInspectable)
  ['{9EAAB854-FB6A-5F88-AF6F-EF8FB492B659}']
    function GetAt(index: Cardinal): Editing_IBackgroundAudioTrack; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Editing_IBackgroundAudioTrack; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PEditing_IBackgroundAudioTrack): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Editing.IBackgroundAudioTrack>
  IVector_1__Editing_IBackgroundAudioTrack = interface(IInspectable)
  ['{58EF15C7-96DE-5D00-8042-2F99F62379E1}']
    function GetAt(index: Cardinal): Editing_IBackgroundAudioTrack; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Editing_IBackgroundAudioTrack; safecall;
    function IndexOf(value: Editing_IBackgroundAudioTrack; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Editing_IBackgroundAudioTrack); safecall;
    procedure InsertAt(index: Cardinal; value: Editing_IBackgroundAudioTrack); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Editing_IBackgroundAudioTrack); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PEditing_IBackgroundAudioTrack): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PEditing_IBackgroundAudioTrack); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Media.Transcoding.TranscodeFailureReason,Double>
  AsyncOperationProgressHandler_2__Transcoding_TranscodeFailureReason__Double_Delegate_Base = interface(IUnknown)
  ['{009C6245-0E59-53B0-9FD2-D250E45A00A3}']
  end;
  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Media.Transcoding.TranscodeFailureReason,Double>
  AsyncOperationProgressHandler_2__Transcoding_TranscodeFailureReason__Double = interface(AsyncOperationProgressHandler_2__Transcoding_TranscodeFailureReason__Double_Delegate_Base)
  ['{E309A77A-10C5-5333-B24D-E22BBA8A53EC}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__Transcoding_TranscodeFailureReason__Double; progressInfo: Double); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Media.Transcoding.TranscodeFailureReason,Double>
  AsyncOperationWithProgressCompletedHandler_2__Transcoding_TranscodeFailureReason__Double_Delegate_Base = interface(IUnknown)
  ['{080F1890-4FCA-5165-A989-4B07DA8E0B53}']
  end;
  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Media.Transcoding.TranscodeFailureReason,Double>
  AsyncOperationWithProgressCompletedHandler_2__Transcoding_TranscodeFailureReason__Double = interface(AsyncOperationWithProgressCompletedHandler_2__Transcoding_TranscodeFailureReason__Double_Delegate_Base)
  ['{77A9A9A2-F0FC-51B8-8B0B-20EA78F25D9A}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__Transcoding_TranscodeFailureReason__Double; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Media.Transcoding.TranscodeFailureReason,Double>
  IAsyncOperationWithProgress_2__Transcoding_TranscodeFailureReason__Double = interface(IInspectable)
  ['{171791B3-C620-58EC-AF24-5C4B14F6FA1C}']
    procedure put_Progress(handler: AsyncOperationProgressHandler_2__Transcoding_TranscodeFailureReason__Double); safecall;
    function get_Progress: AsyncOperationProgressHandler_2__Transcoding_TranscodeFailureReason__Double; safecall;
    procedure put_Completed(handler: AsyncOperationWithProgressCompletedHandler_2__Transcoding_TranscodeFailureReason__Double); safecall;
    function get_Completed: AsyncOperationWithProgressCompletedHandler_2__Transcoding_TranscodeFailureReason__Double; safecall;
    function GetResults: Transcoding_TranscodeFailureReason; safecall;
    property Progress: AsyncOperationProgressHandler_2__Transcoding_TranscodeFailureReason__Double read get_Progress write put_Progress;
    property Completed: AsyncOperationWithProgressCompletedHandler_2__Transcoding_TranscodeFailureReason__Double read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaSource
  [WinRTClassNameAttribute(SCore_MediaSource)]
  Core_IMediaSource = interface(IInspectable)
  ['{E7BFB599-A09D-4C21-BCDF-20AF4F86B3D9}']
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSourceClosedRequest
  [WinRTClassNameAttribute(SCore_MediaStreamSourceClosedRequest)]
  Core_IMediaStreamSourceClosedRequest = interface(IInspectable)
  ['{907C00E9-18A3-4951-887A-2C1EEBD5C69E}']
    function get_Reason: Core_MediaStreamSourceClosedReason; safecall;
    property Reason: Core_MediaStreamSourceClosedReason read get_Reason;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSourceClosedEventArgs
  [WinRTClassNameAttribute(SCore_MediaStreamSourceClosedEventArgs)]
  Core_IMediaStreamSourceClosedEventArgs = interface(IInspectable)
  ['{CD8C7EB2-4816-4E24-88F0-491EF7386406}']
    function get_Request: Core_IMediaStreamSourceClosedRequest; safecall;
    property Request: Core_IMediaStreamSourceClosedRequest read get_Request;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSource,Windows.Media.Core.IMediaStreamSourceClosedEventArgs>
  TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceClosedEventArgs_Delegate_Base = interface(IUnknown)
  ['{238CC251-D0B8-5A34-81D4-0DD1F936A20D}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSource,Windows.Media.Core.IMediaStreamSourceClosedEventArgs>
  TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceClosedEventArgs = interface(TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceClosedEventArgs_Delegate_Base)
  ['{F0F13B5A-50DC-5917-918A-5D5D9D6BA876}']
    procedure Invoke(sender: Core_IMediaStreamSource; args: Core_IMediaStreamSourceClosedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSourceStartingRequestDeferral
  [WinRTClassNameAttribute(SCore_MediaStreamSourceStartingRequestDeferral)]
  Core_IMediaStreamSourceStartingRequestDeferral = interface(IInspectable)
  ['{3F1356A5-6340-4DC4-9910-068ED9F598F8}']
    procedure Complete; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSourceStartingRequest
  [WinRTClassNameAttribute(SCore_MediaStreamSourceStartingRequest)]
  Core_IMediaStreamSourceStartingRequest = interface(IInspectable)
  ['{2A9093E4-35C4-4B1B-A791-0D99DB56DD1D}']
    function get_StartPosition: IReference_1__TimeSpan; safecall;
    function GetDeferral: Core_IMediaStreamSourceStartingRequestDeferral; safecall;
    procedure SetActualStartPosition(position: TimeSpan); safecall;
    property StartPosition: IReference_1__TimeSpan read get_StartPosition;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSourceStartingEventArgs
  [WinRTClassNameAttribute(SCore_MediaStreamSourceStartingEventArgs)]
  Core_IMediaStreamSourceStartingEventArgs = interface(IInspectable)
  ['{F41468F2-C274-4940-A5BB-28A572452FA7}']
    function get_Request: Core_IMediaStreamSourceStartingRequest; safecall;
    property Request: Core_IMediaStreamSourceStartingRequest read get_Request;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSource,Windows.Media.Core.IMediaStreamSourceStartingEventArgs>
  TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceStartingEventArgs_Delegate_Base = interface(IUnknown)
  ['{A93D5846-C660-586E-B6B5-A52FB81F9240}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSource,Windows.Media.Core.IMediaStreamSourceStartingEventArgs>
  TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceStartingEventArgs = interface(TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceStartingEventArgs_Delegate_Base)
  ['{0606F8AF-9EB8-5EC1-B4CE-8336AF9F5167}']
    procedure Invoke(sender: Core_IMediaStreamSource; args: Core_IMediaStreamSourceStartingEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSource,Object>
  TypedEventHandler_2__Core_IMediaStreamSource__IInspectable_Delegate_Base = interface(IUnknown)
  ['{6FD6DED7-421B-5EF5-8BF5-EDEA45401665}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSource,Object>
  TypedEventHandler_2__Core_IMediaStreamSource__IInspectable = interface(TypedEventHandler_2__Core_IMediaStreamSource__IInspectable_Delegate_Base)
  ['{1BF402DC-E381-5B37-908F-18E15AA67651}']
    procedure Invoke(sender: Core_IMediaStreamSource; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamDescriptor
  Core_IMediaStreamDescriptor = interface(IInspectable)
  ['{80F16E6E-92F7-451E-97D2-AFD80742DA70}']
    function get_IsSelected: Boolean; safecall;
    procedure put_Name(value: HSTRING); safecall;
    function get_Name: HSTRING; safecall;
    procedure put_Language(value: HSTRING); safecall;
    function get_Language: HSTRING; safecall;
    property IsSelected: Boolean read get_IsSelected;
    property Language: HSTRING read get_Language write put_Language;
    property Name: HSTRING read get_Name write put_Name;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSourceSampleRequestDeferral
  [WinRTClassNameAttribute(SCore_MediaStreamSourceSampleRequestDeferral)]
  Core_IMediaStreamSourceSampleRequestDeferral = interface(IInspectable)
  ['{7895CC02-F982-43C8-9D16-C62D999319BE}']
    procedure Complete; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSample,Object>
  TypedEventHandler_2__Core_IMediaStreamSample__IInspectable_Delegate_Base = interface(IUnknown)
  ['{D4DC5EF1-C1CB-5C32-803D-F2F9A7AD9916}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSample,Object>
  TypedEventHandler_2__Core_IMediaStreamSample__IInspectable = interface(TypedEventHandler_2__Core_IMediaStreamSample__IInspectable_Delegate_Base)
  ['{BD57C7BA-B003-53E5-B88B-461AB65C4BA9}']
    procedure Invoke(sender: Core_IMediaStreamSample; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSampleProtectionProperties
  [WinRTClassNameAttribute(SCore_MediaStreamSampleProtectionProperties)]
  Core_IMediaStreamSampleProtectionProperties = interface(IInspectable)
  ['{4EB88292-ECDF-493E-841D-DD4ADD7CACA2}']
    procedure SetKeyIdentifier(valueSize: Cardinal; value: PByte); safecall;
    procedure GetKeyIdentifier(valueSize: Cardinal; value: PByte); safecall;
    procedure SetInitializationVector(valueSize: Cardinal; value: PByte); safecall;
    procedure GetInitializationVector(valueSize: Cardinal; value: PByte); safecall;
    procedure SetSubSampleMapping(valueSize: Cardinal; value: PByte); safecall;
    procedure GetSubSampleMapping(valueSize: Cardinal; value: PByte); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSample
  [WinRTClassNameAttribute(SCore_MediaStreamSample)]
  Core_IMediaStreamSample = interface(IInspectable)
  ['{5C8DB627-4B80-4361-9837-6CB7481AD9D6}']
    function add_Processed(handler: TypedEventHandler_2__Core_IMediaStreamSample__IInspectable): EventRegistrationToken; safecall;
    procedure remove_Processed(token: EventRegistrationToken); safecall;
    function get_Buffer: IBuffer; safecall;
    function get_Timestamp: TimeSpan; safecall;
    function get_ExtendedProperties: IMap_2__TGuid__IInspectable; safecall;
    function get_Protection: Core_IMediaStreamSampleProtectionProperties; safecall;
    procedure put_DecodeTimestamp(value: TimeSpan); safecall;
    function get_DecodeTimestamp: TimeSpan; safecall;
    procedure put_Duration(value: TimeSpan); safecall;
    function get_Duration: TimeSpan; safecall;
    procedure put_KeyFrame(value: Boolean); safecall;
    function get_KeyFrame: Boolean; safecall;
    procedure put_Discontinuous(value: Boolean); safecall;
    function get_Discontinuous: Boolean; safecall;
    property Buffer: IBuffer read get_Buffer;
    property DecodeTimestamp: TimeSpan read get_DecodeTimestamp write put_DecodeTimestamp;
    property Discontinuous: Boolean read get_Discontinuous write put_Discontinuous;
    property Duration: TimeSpan read get_Duration write put_Duration;
    property ExtendedProperties: IMap_2__TGuid__IInspectable read get_ExtendedProperties;
    property KeyFrame: Boolean read get_KeyFrame write put_KeyFrame;
    property Protection: Core_IMediaStreamSampleProtectionProperties read get_Protection;
    property Timestamp: TimeSpan read get_Timestamp;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSourceSampleRequest
  [WinRTClassNameAttribute(SCore_MediaStreamSourceSampleRequest)]
  Core_IMediaStreamSourceSampleRequest = interface(IInspectable)
  ['{4DB341A9-3501-4D9B-83F9-8F235C822532}']
    function get_StreamDescriptor: Core_IMediaStreamDescriptor; safecall;
    function GetDeferral: Core_IMediaStreamSourceSampleRequestDeferral; safecall;
    procedure put_Sample(value: Core_IMediaStreamSample); safecall;
    function get_Sample: Core_IMediaStreamSample; safecall;
    procedure ReportSampleProgress(progress: Cardinal); safecall;
    property Sample: Core_IMediaStreamSample read get_Sample write put_Sample;
    property StreamDescriptor: Core_IMediaStreamDescriptor read get_StreamDescriptor;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSourceSampleRequestedEventArgs
  [WinRTClassNameAttribute(SCore_MediaStreamSourceSampleRequestedEventArgs)]
  Core_IMediaStreamSourceSampleRequestedEventArgs = interface(IInspectable)
  ['{10F9BB9E-71C5-492F-847F-0DA1F35E81F8}']
    function get_Request: Core_IMediaStreamSourceSampleRequest; safecall;
    property Request: Core_IMediaStreamSourceSampleRequest read get_Request;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSource,Windows.Media.Core.IMediaStreamSourceSampleRequestedEventArgs>
  TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceSampleRequestedEventArgs_Delegate_Base = interface(IUnknown)
  ['{4F1A3AE3-B8B7-5689-901D-B0B623F5A172}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSource,Windows.Media.Core.IMediaStreamSourceSampleRequestedEventArgs>
  TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceSampleRequestedEventArgs = interface(TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceSampleRequestedEventArgs_Delegate_Base)
  ['{6855C107-2EAB-5A68-9B38-A6D67F3A2E7A}']
    procedure Invoke(sender: Core_IMediaStreamSource; args: Core_IMediaStreamSourceSampleRequestedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSourceSwitchStreamsRequestDeferral
  [WinRTClassNameAttribute(SCore_MediaStreamSourceSwitchStreamsRequestDeferral)]
  Core_IMediaStreamSourceSwitchStreamsRequestDeferral = interface(IInspectable)
  ['{BEE3D835-A505-4F9A-B943-2B8CB1B4BBD9}']
    procedure Complete; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSourceSwitchStreamsRequest
  [WinRTClassNameAttribute(SCore_MediaStreamSourceSwitchStreamsRequest)]
  Core_IMediaStreamSourceSwitchStreamsRequest = interface(IInspectable)
  ['{41B8808E-38A9-4EC3-9BA0-B69B85501E90}']
    function get_OldStreamDescriptor: Core_IMediaStreamDescriptor; safecall;
    function get_NewStreamDescriptor: Core_IMediaStreamDescriptor; safecall;
    function GetDeferral: Core_IMediaStreamSourceSwitchStreamsRequestDeferral; safecall;
    property NewStreamDescriptor: Core_IMediaStreamDescriptor read get_NewStreamDescriptor;
    property OldStreamDescriptor: Core_IMediaStreamDescriptor read get_OldStreamDescriptor;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSourceSwitchStreamsRequestedEventArgs
  [WinRTClassNameAttribute(SCore_MediaStreamSourceSwitchStreamsRequestedEventArgs)]
  Core_IMediaStreamSourceSwitchStreamsRequestedEventArgs = interface(IInspectable)
  ['{42202B72-6EA1-4677-981E-350A0DA412AA}']
    function get_Request: Core_IMediaStreamSourceSwitchStreamsRequest; safecall;
    property Request: Core_IMediaStreamSourceSwitchStreamsRequest read get_Request;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSource,Windows.Media.Core.IMediaStreamSourceSwitchStreamsRequestedEventArgs>
  TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceSwitchStreamsRequestedEventArgs_Delegate_Base = interface(IUnknown)
  ['{452B2E4A-5511-5B3C-8A8E-EE659576A4C1}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaStreamSource,Windows.Media.Core.IMediaStreamSourceSwitchStreamsRequestedEventArgs>
  TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceSwitchStreamsRequestedEventArgs = interface(TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceSwitchStreamsRequestedEventArgs_Delegate_Base)
  ['{34AD4DE5-88FC-5ADE-8503-AC4AEAF03332}']
    procedure Invoke(sender: Core_IMediaStreamSource; args: Core_IMediaStreamSourceSwitchStreamsRequestedEventArgs); safecall;
  end;

  // Windows.Media.Protection.IMediaProtectionServiceRequest
  Protection_IMediaProtectionServiceRequest = interface(IInspectable)
  ['{B1DE0EA6-2094-478D-87A4-8B95200F85C6}']
    function get_ProtectionSystem: TGuid; safecall;
    function get_Type: TGuid; safecall;
    property ProtectionSystem: TGuid read get_ProtectionSystem;
    property &Type: TGuid read get_Type;
  end;

  // Windows.Media.Protection.IMediaProtectionServiceCompletion
  Protection_IMediaProtectionServiceCompletion = interface(IInspectable)
  ['{8B5CCA18-CFD5-44EE-A2ED-DF76010C14B5}']
    procedure Complete(success: Boolean); safecall;
  end;

  // Windows.Media.Protection.IServiceRequestedEventArgs
  Protection_IServiceRequestedEventArgs = interface(IInspectable)
  ['{34283BAF-ABB4-4FC1-BD89-93F106573A49}']
    function get_Request: Protection_IMediaProtectionServiceRequest; safecall;
    function get_Completion: Protection_IMediaProtectionServiceCompletion; safecall;
    property Completion: Protection_IMediaProtectionServiceCompletion read get_Completion;
    property Request: Protection_IMediaProtectionServiceRequest read get_Request;
  end;

  // Windows.Media.Protection.ServiceRequestedEventHandler
  Protection_ServiceRequestedEventHandler = interface(IUnknown)
  ['{D2D690BA-CAC9-48E1-95C0-D38495A84055}']
    procedure Invoke(sender: Protection_IMediaProtectionManager; e: Protection_IServiceRequestedEventArgs); safecall;
  end;

  // Windows.Media.Protection.RebootNeededEventHandler
  Protection_RebootNeededEventHandler = interface(IUnknown)
  ['{64E12A45-973B-4A3A-B260-91898A49A82C}']
    procedure Invoke(sender: Protection_IMediaProtectionManager); safecall;
  end;

  // Windows.Media.Protection.IRevocationAndRenewalItem
  Protection_IRevocationAndRenewalItem = interface(IInspectable)
  ['{3099C20C-3CF0-49EA-902D-CAF32D2DDE2C}']
    function get_Reasons: Protection_RevocationAndRenewalReasons; safecall;
    function get_HeaderHash: HSTRING; safecall;
    function get_PublicKeyHash: HSTRING; safecall;
    function get_Name: HSTRING; safecall;
    function get_RenewalId: HSTRING; safecall;
    property HeaderHash: HSTRING read get_HeaderHash;
    property Name: HSTRING read get_Name;
    property PublicKeyHash: HSTRING read get_PublicKeyHash;
    property Reasons: Protection_RevocationAndRenewalReasons read get_Reasons;
    property RenewalId: HSTRING read get_RenewalId;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Protection.IRevocationAndRenewalItem>
  IIterator_1__Protection_IRevocationAndRenewalItem = interface(IInspectable)
  ['{62F023AD-7A84-5466-A851-7B69A759D36B}']
    function get_Current: Protection_IRevocationAndRenewalItem; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PProtection_IRevocationAndRenewalItem): Cardinal; safecall;
    property Current: Protection_IRevocationAndRenewalItem read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Protection.IRevocationAndRenewalItem>
  IIterable_1__Protection_IRevocationAndRenewalItem_Base = interface(IInspectable)
  ['{07015868-578C-556B-8A35-4039A35D1D92}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Protection.IRevocationAndRenewalItem>
  IIterable_1__Protection_IRevocationAndRenewalItem = interface(IIterable_1__Protection_IRevocationAndRenewalItem_Base)
  ['{23A7F493-CFD9-560C-BD1B-20B09C32CF96}']
    function First: IIterator_1__Protection_IRevocationAndRenewalItem; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Protection.IRevocationAndRenewalItem>
  IVectorView_1__Protection_IRevocationAndRenewalItem = interface(IInspectable)
  ['{D4BED0AA-0377-58AB-829C-201E1283ABBE}']
    function GetAt(index: Cardinal): Protection_IRevocationAndRenewalItem; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Protection_IRevocationAndRenewalItem; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PProtection_IRevocationAndRenewalItem): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Protection.IRevocationAndRenewalItem>
  IVector_1__Protection_IRevocationAndRenewalItem = interface(IInspectable)
  ['{982757F8-7839-5622-B031-72D79B5C1684}']
    function GetAt(index: Cardinal): Protection_IRevocationAndRenewalItem; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Protection_IRevocationAndRenewalItem; safecall;
    function IndexOf(value: Protection_IRevocationAndRenewalItem; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Protection_IRevocationAndRenewalItem); safecall;
    procedure InsertAt(index: Cardinal; value: Protection_IRevocationAndRenewalItem); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Protection_IRevocationAndRenewalItem); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PProtection_IRevocationAndRenewalItem): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PProtection_IRevocationAndRenewalItem); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Media.Protection.IRevocationAndRenewalInformation
  Protection_IRevocationAndRenewalInformation = interface(IInspectable)
  ['{F3A1937B-2501-439E-A6E7-6FC95E175FCF}']
    function get_Items: IVector_1__Protection_IRevocationAndRenewalItem; safecall;
    property Items: IVector_1__Protection_IRevocationAndRenewalItem read get_Items;
  end;

  // Windows.Media.Protection.IComponentLoadFailedEventArgs
  Protection_IComponentLoadFailedEventArgs = interface(IInspectable)
  ['{95972E93-7746-417E-8495-F031BBC5862C}']
    function get_Information: Protection_IRevocationAndRenewalInformation; safecall;
    function get_Completion: Protection_IMediaProtectionServiceCompletion; safecall;
    property Completion: Protection_IMediaProtectionServiceCompletion read get_Completion;
    property Information: Protection_IRevocationAndRenewalInformation read get_Information;
  end;

  // Windows.Media.Protection.ComponentLoadFailedEventHandler
  Protection_ComponentLoadFailedEventHandler = interface(IUnknown)
  ['{95DA643C-6DB9-424B-86CA-091AF432081C}']
    procedure Invoke(sender: Protection_IMediaProtectionManager; e: Protection_IComponentLoadFailedEventArgs); safecall;
  end;

  // Windows.Media.Protection.IMediaProtectionManager
  Protection_IMediaProtectionManager = interface(IInspectable)
  ['{45694947-C741-434B-A79E-474C12D93D2F}']
    function add_ServiceRequested(handler: Protection_ServiceRequestedEventHandler): EventRegistrationToken; safecall;
    procedure remove_ServiceRequested(cookie: EventRegistrationToken); safecall;
    function add_RebootNeeded(handler: Protection_RebootNeededEventHandler): EventRegistrationToken; safecall;
    procedure remove_RebootNeeded(cookie: EventRegistrationToken); safecall;
    function add_ComponentLoadFailed(handler: Protection_ComponentLoadFailedEventHandler): EventRegistrationToken; safecall;
    procedure remove_ComponentLoadFailed(cookie: EventRegistrationToken); safecall;
    function get_Properties: IPropertySet; safecall;
    property Properties: IPropertySet read get_Properties;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSource
  [WinRTClassNameAttribute(SCore_MediaStreamSource)]
  Core_IMediaStreamSource = interface(IInspectable)
  ['{3712D543-45EB-4138-AA62-C01E26F3843F}']
    function add_Closed(handler: TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceClosedEventArgs): EventRegistrationToken; safecall;
    procedure remove_Closed(token: EventRegistrationToken); safecall;
    function add_Starting(handler: TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceStartingEventArgs): EventRegistrationToken; safecall;
    procedure remove_Starting(token: EventRegistrationToken); safecall;
    function add_Paused(handler: TypedEventHandler_2__Core_IMediaStreamSource__IInspectable): EventRegistrationToken; safecall;
    procedure remove_Paused(token: EventRegistrationToken); safecall;
    function add_SampleRequested(handler: TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceSampleRequestedEventArgs): EventRegistrationToken; safecall;
    procedure remove_SampleRequested(token: EventRegistrationToken); safecall;
    function add_SwitchStreamsRequested(handler: TypedEventHandler_2__Core_IMediaStreamSource__Core_IMediaStreamSourceSwitchStreamsRequestedEventArgs): EventRegistrationToken; safecall;
    procedure remove_SwitchStreamsRequested(token: EventRegistrationToken); safecall;
    procedure NotifyError(errorStatus: Core_MediaStreamSourceErrorStatus); safecall;
    procedure AddStreamDescriptor(descriptor: Core_IMediaStreamDescriptor); safecall;
    procedure put_MediaProtectionManager(value: Protection_IMediaProtectionManager); safecall;
    function get_MediaProtectionManager: Protection_IMediaProtectionManager; safecall;
    procedure put_Duration(value: TimeSpan); safecall;
    function get_Duration: TimeSpan; safecall;
    procedure put_CanSeek(value: Boolean); safecall;
    function get_CanSeek: Boolean; safecall;
    procedure put_BufferTime(value: TimeSpan); safecall;
    function get_BufferTime: TimeSpan; safecall;
    procedure SetBufferedRange(startOffset: TimeSpan; endOffset: TimeSpan); safecall;
    function get_MusicProperties: FileProperties_IMusicProperties; safecall;
    function get_VideoProperties: FileProperties_IVideoProperties; safecall;
    procedure put_Thumbnail(value: IRandomAccessStreamReference); safecall;
    function get_Thumbnail: IRandomAccessStreamReference; safecall;
    procedure AddProtectionKey(streamDescriptor: Core_IMediaStreamDescriptor; keyIdentifierSize: Cardinal; keyIdentifier: PByte; licenseData: Byte); safecall;
    property BufferTime: TimeSpan read get_BufferTime write put_BufferTime;
    property CanSeek: Boolean read get_CanSeek write put_CanSeek;
    property Duration: TimeSpan read get_Duration write put_Duration;
    property MediaProtectionManager: Protection_IMediaProtectionManager read get_MediaProtectionManager write put_MediaProtectionManager;
    property MusicProperties: FileProperties_IMusicProperties read get_MusicProperties;
    property Thumbnail: IRandomAccessStreamReference read get_Thumbnail write put_Thumbnail;
    property VideoProperties: FileProperties_IVideoProperties read get_VideoProperties;
  end;

  // DualAPI Interface
  // Windows.Media.Editing.IMediaComposition
  [WinRTClassNameAttribute(SEditing_MediaComposition)]
  Editing_IMediaComposition = interface(IInspectable)
  ['{2E06E605-DC71-41D6-B837-2D2BC14A2947}']
    function get_Duration: TimeSpan; safecall;
    function get_Clips: IVector_1__Editing_IMediaClip; safecall;
    function get_BackgroundAudioTracks: IVector_1__Editing_IBackgroundAudioTrack; safecall;
    function get_UserData: IMap_2__HSTRING__HSTRING; safecall;
    function Clone: Editing_IMediaComposition; safecall;
    function SaveAsync(&file: IStorageFile): IAsyncAction; safecall;
    function GetThumbnailAsync(timeFromStart: TimeSpan; scaledWidth: Integer; scaledHeight: Integer; framePrecision: Editing_VideoFramePrecision): IAsyncOperation_1__IRandomAccessStreamWithContentType; safecall;
    function GetThumbnailsAsync(timesFromStart: IIterable_1__TimeSpan; scaledWidth: Integer; scaledHeight: Integer; framePrecision: Editing_VideoFramePrecision): IAsyncOperation_1__IVectorView_1__IRandomAccessStreamWithContentType; safecall;
    function RenderToFileAsync(destination: IStorageFile): IAsyncOperationWithProgress_2__Transcoding_TranscodeFailureReason__Double; overload; safecall;
    function RenderToFileAsync(destination: IStorageFile; trimmingPreference: Editing_MediaTrimmingPreference): IAsyncOperationWithProgress_2__Transcoding_TranscodeFailureReason__Double; overload; safecall;
    function RenderToFileAsync(destination: IStorageFile; trimmingPreference: Editing_MediaTrimmingPreference; encodingProfile: IMediaEncodingProfile): IAsyncOperationWithProgress_2__Transcoding_TranscodeFailureReason__Double; overload; safecall;
    function CreateDefaultEncodingProfile: IMediaEncodingProfile; safecall;
    function GenerateMediaStreamSource: Core_IMediaStreamSource; overload; safecall;
    function GenerateMediaStreamSource(encodingProfile: IMediaEncodingProfile): Core_IMediaStreamSource; overload; safecall;
    function GeneratePreviewMediaStreamSource(scaledWidth: Integer; scaledHeight: Integer): Core_IMediaStreamSource; safecall;
    property BackgroundAudioTracks: IVector_1__Editing_IBackgroundAudioTrack read get_BackgroundAudioTracks;
    property Clips: IVector_1__Editing_IMediaClip read get_Clips;
    property Duration: TimeSpan read get_Duration;
    property UserData: IMap_2__HSTRING__HSTRING read get_UserData;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Editing.IMediaClip>
  AsyncOperationCompletedHandler_1__Editing_IMediaClip_Delegate_Base = interface(IUnknown)
  ['{60CDE3BC-119F-50A8-9CCB-9EA57EA96BFD}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Editing.IMediaClip>
  AsyncOperationCompletedHandler_1__Editing_IMediaClip = interface(AsyncOperationCompletedHandler_1__Editing_IMediaClip_Delegate_Base)
  ['{0FED90DA-8827-5E5B-B4C0-2EC4702BA0A2}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Editing_IMediaClip; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Editing.IMediaClip>
  IAsyncOperation_1__Editing_IMediaClip_Base = interface(IInspectable)
  ['{B5E699DD-B6F1-51C0-B752-E02FA0068D79}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Editing.IMediaClip>
  IAsyncOperation_1__Editing_IMediaClip = interface(IAsyncOperation_1__Editing_IMediaClip_Base)
  ['{6373D8BB-AB90-52A3-95CF-E72CB440E719}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Editing_IMediaClip); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Editing_IMediaClip; safecall;
    function GetResults: Editing_IMediaClip; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Editing_IMediaClip read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Editing.IMediaClipStatics
  [WinRTClassNameAttribute(SEditing_MediaClip)]
  Editing_IMediaClipStatics = interface(IInspectable)
  ['{FA402B68-928F-43C4-BC6E-783A1A359656}']
    function CreateFromColor(color: Color; originalDuration: TimeSpan): Editing_IMediaClip; safecall;
    function CreateFromFileAsync(&file: IStorageFile): IAsyncOperation_1__Editing_IMediaClip; safecall;
    function CreateFromImageFileAsync(&file: IStorageFile; originalDuration: TimeSpan): IAsyncOperation_1__Editing_IMediaClip; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Editing.IMediaClipStatics2
  [WinRTClassNameAttribute(SEditing_MediaClip)]
  Editing_IMediaClipStatics2 = interface(IInspectable)
  ['{5B1DD7B3-854E-4D9B-877D-4774A556CD12}']
    function CreateFromSurface(surface: DirectX_Direct3D11_IDirect3DSurface; originalDuration: TimeSpan): Editing_IMediaClip; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Editing.IMediaComposition>
  AsyncOperationCompletedHandler_1__Editing_IMediaComposition_Delegate_Base = interface(IUnknown)
  ['{EDD253F8-4EBD-56E5-9592-3C09375EBDC4}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Editing.IMediaComposition>
  AsyncOperationCompletedHandler_1__Editing_IMediaComposition = interface(AsyncOperationCompletedHandler_1__Editing_IMediaComposition_Delegate_Base)
  ['{BB7FB79A-2314-5A6F-848C-65EA5C7B1644}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Editing_IMediaComposition; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Editing.IMediaComposition>
  IAsyncOperation_1__Editing_IMediaComposition_Base = interface(IInspectable)
  ['{E170E898-D11F-5054-AB13-1080A4807636}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Editing.IMediaComposition>
  IAsyncOperation_1__Editing_IMediaComposition = interface(IAsyncOperation_1__Editing_IMediaComposition_Base)
  ['{B9DC8FAB-58C7-593D-B549-41CAF1DFD880}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Editing_IMediaComposition); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Editing_IMediaComposition; safecall;
    function GetResults: Editing_IMediaComposition; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Editing_IMediaComposition read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Editing.IMediaCompositionStatics
  [WinRTClassNameAttribute(SEditing_MediaComposition)]
  Editing_IMediaCompositionStatics = interface(IInspectable)
  ['{87A08F04-E32A-45CE-8F66-A30DF0766224}']
    function LoadAsync(&file: IStorageFile): IAsyncOperation_1__Editing_IMediaComposition; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Editing.IBackgroundAudioTrack>
  AsyncOperationCompletedHandler_1__Editing_IBackgroundAudioTrack_Delegate_Base = interface(IUnknown)
  ['{B8830BC7-188B-5C25-A3BB-959052BCB740}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Editing.IBackgroundAudioTrack>
  AsyncOperationCompletedHandler_1__Editing_IBackgroundAudioTrack = interface(AsyncOperationCompletedHandler_1__Editing_IBackgroundAudioTrack_Delegate_Base)
  ['{57CC5E94-B2B8-5666-993A-B37AE6A9DDED}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Editing_IBackgroundAudioTrack; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Editing.IBackgroundAudioTrack>
  IAsyncOperation_1__Editing_IBackgroundAudioTrack_Base = interface(IInspectable)
  ['{493DC898-6076-55F5-AB84-CCF973AC0397}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Editing.IBackgroundAudioTrack>
  IAsyncOperation_1__Editing_IBackgroundAudioTrack = interface(IAsyncOperation_1__Editing_IBackgroundAudioTrack_Base)
  ['{84D9CB85-B036-5B3E-BC65-B3CAC9EC8825}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Editing_IBackgroundAudioTrack); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Editing_IBackgroundAudioTrack; safecall;
    function GetResults: Editing_IBackgroundAudioTrack; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Editing_IBackgroundAudioTrack read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Editing.IBackgroundAudioTrackStatics
  [WinRTClassNameAttribute(SEditing_BackgroundAudioTrack)]
  Editing_IBackgroundAudioTrackStatics = interface(IInspectable)
  ['{D9B1C0D7-D018-42A8-A559-CB4D9E97E664}']
    function CreateFromEmbeddedAudioTrack(embeddedAudioTrack: Editing_IEmbeddedAudioTrack): Editing_IBackgroundAudioTrack; safecall;
    function CreateFromFileAsync(&file: IStorageFile): IAsyncOperation_1__Editing_IBackgroundAudioTrack; safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Editing.IMediaOverlay>
  IIterator_1__Editing_IMediaOverlay = interface(IInspectable)
  ['{E78A6F3C-A8B3-5ACD-BFA1-6AC80BC9C6FA}']
    function get_Current: Editing_IMediaOverlay; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PEditing_IMediaOverlay): Cardinal; safecall;
    property Current: Editing_IMediaOverlay read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Editing.IMediaOverlay>
  IIterable_1__Editing_IMediaOverlay_Base = interface(IInspectable)
  ['{EFCDA247-A1FB-51DC-A776-E3E06695FB36}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Editing.IMediaOverlay>
  IIterable_1__Editing_IMediaOverlay = interface(IIterable_1__Editing_IMediaOverlay_Base)
  ['{5833D1FF-5172-5C3E-A9E8-F7D5509772B2}']
    function First: IIterator_1__Editing_IMediaOverlay; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Editing.IMediaOverlay>
  IVectorView_1__Editing_IMediaOverlay = interface(IInspectable)
  ['{C2D1EE9B-D163-596B-B8B3-73376867290B}']
    function GetAt(index: Cardinal): Editing_IMediaOverlay; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Editing_IMediaOverlay; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PEditing_IMediaOverlay): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Editing.IMediaOverlay>
  IVector_1__Editing_IMediaOverlay = interface(IInspectable)
  ['{338149D6-D505-59AB-9D80-23CCD5A670A6}']
    function GetAt(index: Cardinal): Editing_IMediaOverlay; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Editing_IMediaOverlay; safecall;
    function IndexOf(value: Editing_IMediaOverlay; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Editing_IMediaOverlay); safecall;
    procedure InsertAt(index: Cardinal; value: Editing_IMediaOverlay); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Editing_IMediaOverlay); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PEditing_IMediaOverlay): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PEditing_IMediaOverlay); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Editing.IMediaOverlayLayer
  [WinRTClassNameAttribute(SEditing_MediaOverlayLayer)]
  Editing_IMediaOverlayLayer = interface(IInspectable)
  ['{A6D9BA57-EEDA-46C6-BBE5-E398C84168AC}']
    function Clone: Editing_IMediaOverlayLayer; safecall;
    function get_Overlays: IVector_1__Editing_IMediaOverlay; safecall;
    function get_CustomCompositorDefinition: Effects_IVideoCompositorDefinition; safecall;
    property CustomCompositorDefinition: Effects_IVideoCompositorDefinition read get_CustomCompositorDefinition;
    property Overlays: IVector_1__Editing_IMediaOverlay read get_Overlays;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Editing.IMediaOverlayLayer>
  IIterator_1__Editing_IMediaOverlayLayer = interface(IInspectable)
  ['{514F7287-8C4D-54CB-8585-8487888830D4}']
    function get_Current: Editing_IMediaOverlayLayer; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PEditing_IMediaOverlayLayer): Cardinal; safecall;
    property Current: Editing_IMediaOverlayLayer read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Editing.IMediaOverlayLayer>
  IIterable_1__Editing_IMediaOverlayLayer_Base = interface(IInspectable)
  ['{7D2312D0-F3A2-5091-8A5E-41832E632C08}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Editing.IMediaOverlayLayer>
  IIterable_1__Editing_IMediaOverlayLayer = interface(IIterable_1__Editing_IMediaOverlayLayer_Base)
  ['{FB3A9C6E-2C63-5741-A408-AA44834DB731}']
    function First: IIterator_1__Editing_IMediaOverlayLayer; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Editing.IMediaOverlayLayer>
  IVectorView_1__Editing_IMediaOverlayLayer = interface(IInspectable)
  ['{85F4D243-A090-574C-9624-7C000C421808}']
    function GetAt(index: Cardinal): Editing_IMediaOverlayLayer; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Editing_IMediaOverlayLayer; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PEditing_IMediaOverlayLayer): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Editing.IMediaOverlayLayer>
  IVector_1__Editing_IMediaOverlayLayer = interface(IInspectable)
  ['{B331E53D-9A53-5961-AFF1-9B41EB32A607}']
    function GetAt(index: Cardinal): Editing_IMediaOverlayLayer; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Editing_IMediaOverlayLayer; safecall;
    function IndexOf(value: Editing_IMediaOverlayLayer; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Editing_IMediaOverlayLayer); safecall;
    procedure InsertAt(index: Cardinal; value: Editing_IMediaOverlayLayer); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Editing_IMediaOverlayLayer); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PEditing_IMediaOverlayLayer): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PEditing_IMediaOverlayLayer); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Editing.IMediaComposition2
  Editing_IMediaComposition2 = interface(IInspectable)
  ['{A59E5372-2366-492C-BEC8-E6DFBA6D0281}']
    function get_OverlayLayers: IVector_1__Editing_IMediaOverlayLayer; safecall;
    property OverlayLayers: IVector_1__Editing_IMediaOverlayLayer read get_OverlayLayers;
  end;

  // DualAPI Interface
  // Windows.Media.Editing.IMediaOverlayFactory
  [WinRTClassNameAttribute(SEditing_MediaOverlay)]
  Editing_IMediaOverlayFactory = interface(IInspectable)
  ['{B584828A-6188-4F8F-A2E0-AA552D598E18}']
    function Create(clip: Editing_IMediaClip): Editing_IMediaOverlay; safecall;
    function CreateWithPositionAndOpacity(clip: Editing_IMediaClip; position: TRectF; opacity: Double): Editing_IMediaOverlay; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Editing.IMediaOverlayLayerFactory
  [WinRTClassNameAttribute(SEditing_MediaOverlayLayer)]
  Editing_IMediaOverlayLayerFactory = interface(IInspectable)
  ['{947CB473-A39E-4362-ABBF-9F8B5070A062}']
    function CreateWithCompositorDefinition(compositorDefinition: Effects_IVideoCompositorDefinition): Editing_IMediaOverlayLayer; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Effects.IAudioEffect
  [WinRTClassNameAttribute(SEffects_AudioEffect)]
  Effects_IAudioEffect = interface(IInspectable)
  ['{34AAFA51-9207-4055-BE93-6E5734A86AE4}']
    function get_AudioEffectType: Effects_AudioEffectType; safecall;
    property AudioEffectType: Effects_AudioEffectType read get_AudioEffectType;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Effects.IAudioEffect>
  IIterator_1__Effects_IAudioEffect = interface(IInspectable)
  ['{B577A420-FEA9-5749-B275-2449C60DCB76}']
    function get_Current: Effects_IAudioEffect; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PEffects_IAudioEffect): Cardinal; safecall;
    property Current: Effects_IAudioEffect read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Effects.IAudioEffect>
  IIterable_1__Effects_IAudioEffect_Base = interface(IInspectable)
  ['{07AF9AFD-25B8-579D-BE7E-8ACC03418D0B}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Effects.IAudioEffect>
  IIterable_1__Effects_IAudioEffect = interface(IIterable_1__Effects_IAudioEffect_Base)
  ['{1895EAB1-DCC6-5621-987B-4C4273284EF6}']
    function First: IIterator_1__Effects_IAudioEffect; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Effects.IAudioEffect>
  IVectorView_1__Effects_IAudioEffect = interface(IInspectable)
  ['{C99A8712-7619-5C0B-8932-64385686A17D}']
    function GetAt(index: Cardinal): Effects_IAudioEffect; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Effects_IAudioEffect; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PEffects_IAudioEffect): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Media.FaceAnalysis.IDetectedFace
  FaceAnalysis_IDetectedFace = interface(IInspectable)
  ['{8200D454-66BC-34DF-9410-E89400195414}']
    function get_FaceBox: Imaging_BitmapBounds; safecall;
    property FaceBox: Imaging_BitmapBounds read get_FaceBox;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.FaceAnalysis.IDetectedFace>
  IIterator_1__FaceAnalysis_IDetectedFace = interface(IInspectable)
  ['{90D3F012-5420-566E-A536-BDD8A9EF1E1F}']
    function get_Current: FaceAnalysis_IDetectedFace; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PFaceAnalysis_IDetectedFace): Cardinal; safecall;
    property Current: FaceAnalysis_IDetectedFace read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.FaceAnalysis.IDetectedFace>
  IIterable_1__FaceAnalysis_IDetectedFace_Base = interface(IInspectable)
  ['{25347323-3556-5CBB-9855-2B5856437F4D}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.FaceAnalysis.IDetectedFace>
  IIterable_1__FaceAnalysis_IDetectedFace = interface(IIterable_1__FaceAnalysis_IDetectedFace_Base)
  ['{058589D0-1CA4-54E1-B3C1-53C603A2E03F}']
    function First: IIterator_1__FaceAnalysis_IDetectedFace; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.FaceAnalysis.IDetectedFace>
  IVectorView_1__FaceAnalysis_IDetectedFace = interface(IInspectable)
  ['{DC2C389F-2996-548D-8920-BA7A896998E0}']
    function GetAt(index: Cardinal): FaceAnalysis_IDetectedFace; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: FaceAnalysis_IDetectedFace; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PFaceAnalysis_IDetectedFace): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.FaceAnalysis.IDetectedFace>
  IVector_1__FaceAnalysis_IDetectedFace = interface(IInspectable)
  ['{01E93A00-9C03-547D-AF95-9975AE07E725}']
    function GetAt(index: Cardinal): FaceAnalysis_IDetectedFace; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__FaceAnalysis_IDetectedFace; safecall;
    function IndexOf(value: FaceAnalysis_IDetectedFace; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: FaceAnalysis_IDetectedFace); safecall;
    procedure InsertAt(index: Cardinal; value: FaceAnalysis_IDetectedFace); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: FaceAnalysis_IDetectedFace); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PFaceAnalysis_IDetectedFace): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PFaceAnalysis_IDetectedFace); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVector`1<Windows.Media.FaceAnalysis.IDetectedFace>>
  AsyncOperationCompletedHandler_1__IVector_1__FaceAnalysis_IDetectedFace_Delegate_Base = interface(IUnknown)
  ['{B0A53153-2015-58B3-9DD0-BDF291B856B2}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVector`1<Windows.Media.FaceAnalysis.IDetectedFace>>
  AsyncOperationCompletedHandler_1__IVector_1__FaceAnalysis_IDetectedFace = interface(AsyncOperationCompletedHandler_1__IVector_1__FaceAnalysis_IDetectedFace_Delegate_Base)
  ['{3A5F5ABE-CA0D-565E-BFAD-948FF16E368C}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVector_1__FaceAnalysis_IDetectedFace; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVector`1<Windows.Media.FaceAnalysis.IDetectedFace>>
  IAsyncOperation_1__IVector_1__FaceAnalysis_IDetectedFace_Base = interface(IInspectable)
  ['{37F1D7DC-A1A4-5A94-B33B-74205A65A1ED}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVector`1<Windows.Media.FaceAnalysis.IDetectedFace>>
  IAsyncOperation_1__IVector_1__FaceAnalysis_IDetectedFace = interface(IAsyncOperation_1__IVector_1__FaceAnalysis_IDetectedFace_Base)
  ['{6E19DC38-7D50-531F-8C84-A22BD7CA3AB6}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVector_1__FaceAnalysis_IDetectedFace); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVector_1__FaceAnalysis_IDetectedFace; safecall;
    function GetResults: IVector_1__FaceAnalysis_IDetectedFace; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVector_1__FaceAnalysis_IDetectedFace read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Import.IPhotoImportStorageMedium
  [WinRTClassNameAttribute(SImport_PhotoImportStorageMedium)]
  Import_IPhotoImportStorageMedium = interface(IInspectable)
  ['{F2B9B093-FC85-487F-87C2-58D675D05B07}']
    function get_Name: HSTRING; safecall;
    function get_Description: HSTRING; safecall;
    function get_SerialNumber: HSTRING; safecall;
    function get_StorageMediumType: Import_PhotoImportStorageMediumType; safecall;
    function get_SupportedAccessMode: Import_PhotoImportAccessMode; safecall;
    function get_CapacityInBytes: UInt64; safecall;
    function get_AvailableSpaceInBytes: UInt64; safecall;
    procedure Refresh; safecall;
    property AvailableSpaceInBytes: UInt64 read get_AvailableSpaceInBytes;
    property CapacityInBytes: UInt64 read get_CapacityInBytes;
    property Description: HSTRING read get_Description;
    property Name: HSTRING read get_Name;
    property SerialNumber: HSTRING read get_SerialNumber;
    property StorageMediumType: Import_PhotoImportStorageMediumType read get_StorageMediumType;
    property SupportedAccessMode: Import_PhotoImportAccessMode read get_SupportedAccessMode;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Import.IPhotoImportStorageMedium>
  IIterator_1__Import_IPhotoImportStorageMedium = interface(IInspectable)
  ['{9FEDC748-7884-53EF-998E-C534BDDB0C4C}']
    function get_Current: Import_IPhotoImportStorageMedium; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PImport_IPhotoImportStorageMedium): Cardinal; safecall;
    property Current: Import_IPhotoImportStorageMedium read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Import.IPhotoImportStorageMedium>
  IIterable_1__Import_IPhotoImportStorageMedium = interface(IInspectable)
  ['{0B060B18-4AC5-5B0D-BF1A-D1AD5C31220F}']
    function First: IIterator_1__Import_IPhotoImportStorageMedium; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportStorageMedium>
  IVectorView_1__Import_IPhotoImportStorageMedium = interface(IInspectable)
  ['{D27C363D-64B0-5F16-B6B8-94504BD7922B}']
    function GetAt(index: Cardinal): Import_IPhotoImportStorageMedium; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Import_IPhotoImportStorageMedium; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PImport_IPhotoImportStorageMedium): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Import.IPhotoImportSidecar
  [WinRTClassNameAttribute(SImport_PhotoImportSidecar)]
  Import_IPhotoImportSidecar = interface(IInspectable)
  ['{46D7D757-F802-44C7-9C98-7A71F4BC1486}']
    function get_Name: HSTRING; safecall;
    function get_SizeInBytes: UInt64; safecall;
    function get_Date: DateTime; safecall;
    property Date: DateTime read get_Date;
    property Name: HSTRING read get_Name;
    property SizeInBytes: UInt64 read get_SizeInBytes;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Import.IPhotoImportSidecar>
  IIterator_1__Import_IPhotoImportSidecar = interface(IInspectable)
  ['{F6531CDF-A0F1-5552-988C-C51E528EFF89}']
    function get_Current: Import_IPhotoImportSidecar; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PImport_IPhotoImportSidecar): Cardinal; safecall;
    property Current: Import_IPhotoImportSidecar read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Import.IPhotoImportSidecar>
  IIterable_1__Import_IPhotoImportSidecar = interface(IInspectable)
  ['{2AAC9167-1E61-5938-9AAA-A7EFAF2D9191}']
    function First: IIterator_1__Import_IPhotoImportSidecar; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportSidecar>
  IVectorView_1__Import_IPhotoImportSidecar = interface(IInspectable)
  ['{2CCF73EC-50B4-54A6-A07B-E06F53D03DC5}']
    function GetAt(index: Cardinal): Import_IPhotoImportSidecar; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Import_IPhotoImportSidecar; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PImport_IPhotoImportSidecar): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Import.IPhotoImportVideoSegment
  [WinRTClassNameAttribute(SImport_PhotoImportVideoSegment)]
  Import_IPhotoImportVideoSegment = interface(IInspectable)
  ['{623C0289-321A-41D8-9166-8C62A333276C}']
    function get_Name: HSTRING; safecall;
    function get_SizeInBytes: UInt64; safecall;
    function get_Date: DateTime; safecall;
    function get_Sibling: Import_IPhotoImportSidecar; safecall;
    function get_Sidecars: IVectorView_1__Import_IPhotoImportSidecar; safecall;
    property Date: DateTime read get_Date;
    property Name: HSTRING read get_Name;
    property Sibling: Import_IPhotoImportSidecar read get_Sibling;
    property Sidecars: IVectorView_1__Import_IPhotoImportSidecar read get_Sidecars;
    property SizeInBytes: UInt64 read get_SizeInBytes;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Import.IPhotoImportVideoSegment>
  IIterator_1__Import_IPhotoImportVideoSegment = interface(IInspectable)
  ['{E970C93B-8D22-5CCD-B85D-E120E8551CF3}']
    function get_Current: Import_IPhotoImportVideoSegment; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PImport_IPhotoImportVideoSegment): Cardinal; safecall;
    property Current: Import_IPhotoImportVideoSegment read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Import.IPhotoImportVideoSegment>
  IIterable_1__Import_IPhotoImportVideoSegment = interface(IInspectable)
  ['{016284C1-5540-5B25-8372-E705632D0996}']
    function First: IIterator_1__Import_IPhotoImportVideoSegment; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportVideoSegment>
  IVectorView_1__Import_IPhotoImportVideoSegment = interface(IInspectable)
  ['{550ED523-02AD-5A38-B513-582A17288AA9}']
    function GetAt(index: Cardinal): Import_IPhotoImportVideoSegment; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Import_IPhotoImportVideoSegment; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PImport_IPhotoImportVideoSegment): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Import.IPhotoImportItem
  [WinRTClassNameAttribute(SImport_PhotoImportItem)]
  Import_IPhotoImportItem = interface(IInspectable)
  ['{A9D07E76-9BFC-43B8-B356-633B6A988C9E}']
    function get_Name: HSTRING; safecall;
    function get_ItemKey: UInt64; safecall;
    function get_ContentType: Import_PhotoImportContentType; safecall;
    function get_SizeInBytes: UInt64; safecall;
    function get_Date: DateTime; safecall;
    function get_Sibling: Import_IPhotoImportSidecar; safecall;
    function get_Sidecars: IVectorView_1__Import_IPhotoImportSidecar; safecall;
    function get_VideoSegments: IVectorView_1__Import_IPhotoImportVideoSegment; safecall;
    function get_IsSelected: Boolean; safecall;
    procedure put_IsSelected(value: Boolean); safecall;
    function get_Thumbnail: IRandomAccessStreamReference; safecall;
    function get_ImportedFileNames: IVectorView_1__HSTRING; safecall;
    function get_DeletedFileNames: IVectorView_1__HSTRING; safecall;
    property ContentType: Import_PhotoImportContentType read get_ContentType;
    property Date: DateTime read get_Date;
    property DeletedFileNames: IVectorView_1__HSTRING read get_DeletedFileNames;
    property ImportedFileNames: IVectorView_1__HSTRING read get_ImportedFileNames;
    property IsSelected: Boolean read get_IsSelected write put_IsSelected;
    property ItemKey: UInt64 read get_ItemKey;
    property Name: HSTRING read get_Name;
    property Sibling: Import_IPhotoImportSidecar read get_Sibling;
    property Sidecars: IVectorView_1__Import_IPhotoImportSidecar read get_Sidecars;
    property SizeInBytes: UInt64 read get_SizeInBytes;
    property Thumbnail: IRandomAccessStreamReference read get_Thumbnail;
    property VideoSegments: IVectorView_1__Import_IPhotoImportVideoSegment read get_VideoSegments;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Import.IPhotoImportItem>
  IIterator_1__Import_IPhotoImportItem = interface(IInspectable)
  ['{EC346A78-3590-5BCE-A4C3-D5FD43F5E3BE}']
    function get_Current: Import_IPhotoImportItem; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PImport_IPhotoImportItem): Cardinal; safecall;
    property Current: Import_IPhotoImportItem read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Import.IPhotoImportItem>
  IIterable_1__Import_IPhotoImportItem = interface(IInspectable)
  ['{D6AD4D82-8202-52FA-88DF-9D84F76DCB42}']
    function First: IIterator_1__Import_IPhotoImportItem; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportItem>
  IVectorView_1__Import_IPhotoImportItem = interface(IInspectable)
  ['{CEB9DB5E-9176-5763-9EE5-2A2CF1A80B54}']
    function GetAt(index: Cardinal): Import_IPhotoImportItem; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Import_IPhotoImportItem; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PImport_IPhotoImportItem): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Import.IPhotoImportSelectionChangedEventArgs
  [WinRTClassNameAttribute(SImport_PhotoImportSelectionChangedEventArgs)]
  Import_IPhotoImportSelectionChangedEventArgs = interface(IInspectable)
  ['{10461782-FA9D-4C30-8BC9-4D64911572D5}']
    function get_IsSelectionEmpty: Boolean; safecall;
    property IsSelectionEmpty: Boolean read get_IsSelectionEmpty;
  end;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Import.IPhotoImportFindItemsResult,Windows.Media.Import.IPhotoImportSelectionChangedEventArgs>
  TypedEventHandler_2__Import_IPhotoImportFindItemsResult__Import_IPhotoImportSelectionChangedEventArgs = interface(IUnknown)
  ['{51C404BB-F631-5B21-92ED-122203365DC8}']
    procedure Invoke(sender: Import_IPhotoImportFindItemsResult; args: Import_IPhotoImportSelectionChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Import.IPhotoImportDeleteImportedItemsFromSourceResult
  [WinRTClassNameAttribute(SImport_PhotoImportDeleteImportedItemsFromSourceResult)]
  Import_IPhotoImportDeleteImportedItemsFromSourceResult = interface(IInspectable)
  ['{F4E112F8-843D-428A-A1A6-81510292B0AE}']
    function get_Session: Import_IPhotoImportSession; safecall;
    function get_HasSucceeded: Boolean; safecall;
    function get_DeletedItems: IVectorView_1__Import_IPhotoImportItem; safecall;
    function get_PhotosCount: Cardinal; safecall;
    function get_PhotosSizeInBytes: UInt64; safecall;
    function get_VideosCount: Cardinal; safecall;
    function get_VideosSizeInBytes: UInt64; safecall;
    function get_SidecarsCount: Cardinal; safecall;
    function get_SidecarsSizeInBytes: UInt64; safecall;
    function get_SiblingsCount: Cardinal; safecall;
    function get_SiblingsSizeInBytes: UInt64; safecall;
    function get_TotalCount: Cardinal; safecall;
    function get_TotalSizeInBytes: UInt64; safecall;
    property DeletedItems: IVectorView_1__Import_IPhotoImportItem read get_DeletedItems;
    property HasSucceeded: Boolean read get_HasSucceeded;
    property PhotosCount: Cardinal read get_PhotosCount;
    property PhotosSizeInBytes: UInt64 read get_PhotosSizeInBytes;
    property Session: Import_IPhotoImportSession read get_Session;
    property SiblingsCount: Cardinal read get_SiblingsCount;
    property SiblingsSizeInBytes: UInt64 read get_SiblingsSizeInBytes;
    property SidecarsCount: Cardinal read get_SidecarsCount;
    property SidecarsSizeInBytes: UInt64 read get_SidecarsSizeInBytes;
    property TotalCount: Cardinal read get_TotalCount;
    property TotalSizeInBytes: UInt64 read get_TotalSizeInBytes;
    property VideosCount: Cardinal read get_VideosCount;
    property VideosSizeInBytes: UInt64 read get_VideosSizeInBytes;
  end;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Media.Import.IPhotoImportDeleteImportedItemsFromSourceResult,Double>
  AsyncOperationProgressHandler_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double = interface(IUnknown)
  ['{BD06B7C0-61FA-5847-80FD-15FA0E5EE472}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double; progressInfo: Double); safecall;
  end;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Media.Import.IPhotoImportDeleteImportedItemsFromSourceResult,Double>
  AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double = interface(IUnknown)
  ['{71719D54-108E-53B6-8614-F1CF2C933FBB}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Media.Import.IPhotoImportDeleteImportedItemsFromSourceResult,Double>
  IAsyncOperationWithProgress_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double = interface(IInspectable)
  ['{2D45F8E8-C550-52FF-A79E-DB61FFB63C4D}']
    procedure put_Progress(handler: AsyncOperationProgressHandler_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double); safecall;
    function get_Progress: AsyncOperationProgressHandler_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double; safecall;
    procedure put_Completed(handler: AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double); safecall;
    function get_Completed: AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double; safecall;
    function GetResults: Import_IPhotoImportDeleteImportedItemsFromSourceResult; safecall;
    property Progress: AsyncOperationProgressHandler_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double read get_Progress write put_Progress;
    property Completed: AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Import.IPhotoImportImportItemsResult
  [WinRTClassNameAttribute(SImport_PhotoImportImportItemsResult)]
  Import_IPhotoImportImportItemsResult = interface(IInspectable)
  ['{E4D4F478-D419-4443-A84E-F06A850C0B00}']
    function get_Session: Import_IPhotoImportSession; safecall;
    function get_HasSucceeded: Boolean; safecall;
    function get_ImportedItems: IVectorView_1__Import_IPhotoImportItem; safecall;
    function get_PhotosCount: Cardinal; safecall;
    function get_PhotosSizeInBytes: UInt64; safecall;
    function get_VideosCount: Cardinal; safecall;
    function get_VideosSizeInBytes: UInt64; safecall;
    function get_SidecarsCount: Cardinal; safecall;
    function get_SidecarsSizeInBytes: UInt64; safecall;
    function get_SiblingsCount: Cardinal; safecall;
    function get_SiblingsSizeInBytes: UInt64; safecall;
    function get_TotalCount: Cardinal; safecall;
    function get_TotalSizeInBytes: UInt64; safecall;
    function DeleteImportedItemsFromSourceAsync: IAsyncOperationWithProgress_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double; safecall;
    property HasSucceeded: Boolean read get_HasSucceeded;
    property ImportedItems: IVectorView_1__Import_IPhotoImportItem read get_ImportedItems;
    property PhotosCount: Cardinal read get_PhotosCount;
    property PhotosSizeInBytes: UInt64 read get_PhotosSizeInBytes;
    property Session: Import_IPhotoImportSession read get_Session;
    property SiblingsCount: Cardinal read get_SiblingsCount;
    property SiblingsSizeInBytes: UInt64 read get_SiblingsSizeInBytes;
    property SidecarsCount: Cardinal read get_SidecarsCount;
    property SidecarsSizeInBytes: UInt64 read get_SidecarsSizeInBytes;
    property TotalCount: Cardinal read get_TotalCount;
    property TotalSizeInBytes: UInt64 read get_TotalSizeInBytes;
    property VideosCount: Cardinal read get_VideosCount;
    property VideosSizeInBytes: UInt64 read get_VideosSizeInBytes;
  end;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Media.Import.IPhotoImportImportItemsResult,Windows.Media.Import.PhotoImportProgress>
  AsyncOperationProgressHandler_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress = interface(IUnknown)
  ['{09F43DAE-C229-5E00-AAB6-7C557FB14260}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress; progressInfo: Import_PhotoImportProgress); safecall;
  end;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Media.Import.IPhotoImportImportItemsResult,Windows.Media.Import.PhotoImportProgress>
  AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress = interface(IUnknown)
  ['{EEAE0DEB-A642-5F84-8304-199380D154FF}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Media.Import.IPhotoImportImportItemsResult,Windows.Media.Import.PhotoImportProgress>
  IAsyncOperationWithProgress_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress = interface(IInspectable)
  ['{91ED64C2-84AA-57B8-81C2-D96A52C22B6D}']
    procedure put_Progress(handler: AsyncOperationProgressHandler_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress); safecall;
    function get_Progress: AsyncOperationProgressHandler_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress; safecall;
    procedure put_Completed(handler: AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress); safecall;
    function get_Completed: AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress; safecall;
    function GetResults: Import_IPhotoImportImportItemsResult; safecall;
    property Progress: AsyncOperationProgressHandler_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress read get_Progress write put_Progress;
    property Completed: AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Import.IPhotoImportItemImportedEventArgs
  [WinRTClassNameAttribute(SImport_PhotoImportItemImportedEventArgs)]
  Import_IPhotoImportItemImportedEventArgs = interface(IInspectable)
  ['{42CB2FDD-7D68-47B5-BC7C-CEB73E0C77DC}']
    function get_ImportedItem: Import_IPhotoImportItem; safecall;
    property ImportedItem: Import_IPhotoImportItem read get_ImportedItem;
  end;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Import.IPhotoImportFindItemsResult,Windows.Media.Import.IPhotoImportItemImportedEventArgs>
  TypedEventHandler_2__Import_IPhotoImportFindItemsResult__Import_IPhotoImportItemImportedEventArgs = interface(IUnknown)
  ['{27BA5B5E-F5A8-5A92-A95D-80A4BCCDE676}']
    procedure Invoke(sender: Import_IPhotoImportFindItemsResult; args: Import_IPhotoImportItemImportedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Import.IPhotoImportFindItemsResult
  [WinRTClassNameAttribute(SImport_PhotoImportFindItemsResult)]
  Import_IPhotoImportFindItemsResult = interface(IInspectable)
  ['{3915E647-6C78-492B-844E-8FE5E8F6BFB9}']
    function get_Session: Import_IPhotoImportSession; safecall;
    function get_HasSucceeded: Boolean; safecall;
    function get_FoundItems: IVectorView_1__Import_IPhotoImportItem; safecall;
    function get_PhotosCount: Cardinal; safecall;
    function get_PhotosSizeInBytes: UInt64; safecall;
    function get_VideosCount: Cardinal; safecall;
    function get_VideosSizeInBytes: UInt64; safecall;
    function get_SidecarsCount: Cardinal; safecall;
    function get_SidecarsSizeInBytes: UInt64; safecall;
    function get_SiblingsCount: Cardinal; safecall;
    function get_SiblingsSizeInBytes: UInt64; safecall;
    function get_TotalCount: Cardinal; safecall;
    function get_TotalSizeInBytes: UInt64; safecall;
    procedure SelectAll; safecall;
    procedure SelectNone; safecall;
    function SelectNewAsync: IAsyncAction; safecall;
    procedure SetImportMode(value: Import_PhotoImportImportMode); safecall;
    function get_ImportMode: Import_PhotoImportImportMode; safecall;
    function get_SelectedPhotosCount: Cardinal; safecall;
    function get_SelectedPhotosSizeInBytes: UInt64; safecall;
    function get_SelectedVideosCount: Cardinal; safecall;
    function get_SelectedVideosSizeInBytes: UInt64; safecall;
    function get_SelectedSidecarsCount: Cardinal; safecall;
    function get_SelectedSidecarsSizeInBytes: UInt64; safecall;
    function get_SelectedSiblingsCount: Cardinal; safecall;
    function get_SelectedSiblingsSizeInBytes: UInt64; safecall;
    function get_SelectedTotalCount: Cardinal; safecall;
    function get_SelectedTotalSizeInBytes: UInt64; safecall;
    function add_SelectionChanged(value: TypedEventHandler_2__Import_IPhotoImportFindItemsResult__Import_IPhotoImportSelectionChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_SelectionChanged(token: EventRegistrationToken); safecall;
    function ImportItemsAsync: IAsyncOperationWithProgress_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress; safecall;
    function add_ItemImported(value: TypedEventHandler_2__Import_IPhotoImportFindItemsResult__Import_IPhotoImportItemImportedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ItemImported(token: EventRegistrationToken); safecall;
    property FoundItems: IVectorView_1__Import_IPhotoImportItem read get_FoundItems;
    property HasSucceeded: Boolean read get_HasSucceeded;
    property ImportMode: Import_PhotoImportImportMode read get_ImportMode;
    property PhotosCount: Cardinal read get_PhotosCount;
    property PhotosSizeInBytes: UInt64 read get_PhotosSizeInBytes;
    property SelectedPhotosCount: Cardinal read get_SelectedPhotosCount;
    property SelectedPhotosSizeInBytes: UInt64 read get_SelectedPhotosSizeInBytes;
    property SelectedSiblingsCount: Cardinal read get_SelectedSiblingsCount;
    property SelectedSiblingsSizeInBytes: UInt64 read get_SelectedSiblingsSizeInBytes;
    property SelectedSidecarsCount: Cardinal read get_SelectedSidecarsCount;
    property SelectedSidecarsSizeInBytes: UInt64 read get_SelectedSidecarsSizeInBytes;
    property SelectedTotalCount: Cardinal read get_SelectedTotalCount;
    property SelectedTotalSizeInBytes: UInt64 read get_SelectedTotalSizeInBytes;
    property SelectedVideosCount: Cardinal read get_SelectedVideosCount;
    property SelectedVideosSizeInBytes: UInt64 read get_SelectedVideosSizeInBytes;
    property Session: Import_IPhotoImportSession read get_Session;
    property SiblingsCount: Cardinal read get_SiblingsCount;
    property SiblingsSizeInBytes: UInt64 read get_SiblingsSizeInBytes;
    property SidecarsCount: Cardinal read get_SidecarsCount;
    property SidecarsSizeInBytes: UInt64 read get_SidecarsSizeInBytes;
    property TotalCount: Cardinal read get_TotalCount;
    property TotalSizeInBytes: UInt64 read get_TotalSizeInBytes;
    property VideosCount: Cardinal read get_VideosCount;
    property VideosSizeInBytes: UInt64 read get_VideosSizeInBytes;
  end;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Media.Import.IPhotoImportFindItemsResult,UInt32>
  AsyncOperationProgressHandler_2__Import_IPhotoImportFindItemsResult__Cardinal = interface(IUnknown)
  ['{82C5AE94-23F3-5F41-AA1C-50C2B683A32D}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__Import_IPhotoImportFindItemsResult__Cardinal; progressInfo: Cardinal); safecall;
  end;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Media.Import.IPhotoImportFindItemsResult,UInt32>
  AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportFindItemsResult__Cardinal = interface(IUnknown)
  ['{8661BBC6-1435-5866-A267-96A65FB60717}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__Import_IPhotoImportFindItemsResult__Cardinal; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Media.Import.IPhotoImportFindItemsResult,UInt32>
  IAsyncOperationWithProgress_2__Import_IPhotoImportFindItemsResult__Cardinal = interface(IInspectable)
  ['{8AB6631B-C06D-5555-9707-C27343BF2E39}']
    procedure put_Progress(handler: AsyncOperationProgressHandler_2__Import_IPhotoImportFindItemsResult__Cardinal); safecall;
    function get_Progress: AsyncOperationProgressHandler_2__Import_IPhotoImportFindItemsResult__Cardinal; safecall;
    procedure put_Completed(handler: AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportFindItemsResult__Cardinal); safecall;
    function get_Completed: AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportFindItemsResult__Cardinal; safecall;
    function GetResults: Import_IPhotoImportFindItemsResult; safecall;
    property Progress: AsyncOperationProgressHandler_2__Import_IPhotoImportFindItemsResult__Cardinal read get_Progress write put_Progress;
    property Completed: AsyncOperationWithProgressCompletedHandler_2__Import_IPhotoImportFindItemsResult__Cardinal read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Import.IPhotoImportSession
  [WinRTClassNameAttribute(SImport_PhotoImportSession)]
  Import_IPhotoImportSession = interface(IInspectable)
  ['{AA63916E-ECDB-4EFE-94C6-5F5CAFE34CFB}']
    function get_Source: Import_IPhotoImportSource; safecall;
    function get_SessionId: TGuid; safecall;
    procedure put_DestinationFolder(value: IStorageFolder); safecall;
    function get_DestinationFolder: IStorageFolder; safecall;
    procedure put_AppendSessionDateToDestinationFolder(value: Boolean); safecall;
    function get_AppendSessionDateToDestinationFolder: Boolean; safecall;
    procedure put_SubfolderCreationMode(value: Import_PhotoImportSubfolderCreationMode); safecall;
    function get_SubfolderCreationMode: Import_PhotoImportSubfolderCreationMode; safecall;
    procedure put_DestinationFileNamePrefix(value: HSTRING); safecall;
    function get_DestinationFileNamePrefix: HSTRING; safecall;
    function FindItemsAsync(contentTypeFilter: Import_PhotoImportContentTypeFilter; itemSelectionMode: Import_PhotoImportItemSelectionMode): IAsyncOperationWithProgress_2__Import_IPhotoImportFindItemsResult__Cardinal; safecall;
    property AppendSessionDateToDestinationFolder: Boolean read get_AppendSessionDateToDestinationFolder write put_AppendSessionDateToDestinationFolder;
    property DestinationFileNamePrefix: HSTRING read get_DestinationFileNamePrefix write put_DestinationFileNamePrefix;
    property DestinationFolder: IStorageFolder read get_DestinationFolder write put_DestinationFolder;
    property SessionId: TGuid read get_SessionId;
    property Source: Import_IPhotoImportSource read get_Source;
    property SubfolderCreationMode: Import_PhotoImportSubfolderCreationMode read get_SubfolderCreationMode write put_SubfolderCreationMode;
  end;

  // DualAPI Interface
  // Windows.Media.Import.IPhotoImportSource
  [WinRTClassNameAttribute(SImport_PhotoImportSource)]
  Import_IPhotoImportSource = interface(IInspectable)
  ['{1F8EA35E-145B-4CD6-87F1-54965A982FEF}']
    function get_Id: HSTRING; safecall;
    function get_DisplayName: HSTRING; safecall;
    function get_Description: HSTRING; safecall;
    function get_Manufacturer: HSTRING; safecall;
    function get_Model: HSTRING; safecall;
    function get_SerialNumber: HSTRING; safecall;
    function get_ConnectionProtocol: HSTRING; safecall;
    function get_ConnectionTransport: Import_PhotoImportConnectionTransport; safecall;
    function get_Type: Import_PhotoImportSourceType; safecall;
    function get_PowerSource: Import_PhotoImportPowerSource; safecall;
    function get_BatteryLevelPercent: IReference_1__Cardinal; safecall;
    function get_DateTime: IReference_1__DateTime; safecall;
    function get_StorageMedia: IVectorView_1__Import_IPhotoImportStorageMedium; safecall;
    function get_IsLocked: IReference_1__Boolean; safecall;
    function get_IsMassStorage: Boolean; safecall;
    function get_Thumbnail: IRandomAccessStreamReference; safecall;
    function CreateImportSession: Import_IPhotoImportSession; safecall;
    property BatteryLevelPercent: IReference_1__Cardinal read get_BatteryLevelPercent;
    property ConnectionProtocol: HSTRING read get_ConnectionProtocol;
    property ConnectionTransport: Import_PhotoImportConnectionTransport read get_ConnectionTransport;
    property DateTime: IReference_1__DateTime read get_DateTime;
    property Description: HSTRING read get_Description;
    property DisplayName: HSTRING read get_DisplayName;
    property Id: HSTRING read get_Id;
    property IsLocked: IReference_1__Boolean read get_IsLocked;
    property IsMassStorage: Boolean read get_IsMassStorage;
    property Manufacturer: HSTRING read get_Manufacturer;
    property Model: HSTRING read get_Model;
    property PowerSource: Import_PhotoImportPowerSource read get_PowerSource;
    property SerialNumber: HSTRING read get_SerialNumber;
    property StorageMedia: IVectorView_1__Import_IPhotoImportStorageMedium read get_StorageMedia;
    property Thumbnail: IRandomAccessStreamReference read get_Thumbnail;
    property &Type: Import_PhotoImportSourceType read get_Type;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Import.IPhotoImportSource>
  IIterator_1__Import_IPhotoImportSource = interface(IInspectable)
  ['{F1189FA7-294E-5CFE-B566-C8D8EB82ADEB}']
    function get_Current: Import_IPhotoImportSource; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PImport_IPhotoImportSource): Cardinal; safecall;
    property Current: Import_IPhotoImportSource read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Import.IPhotoImportSource>
  IIterable_1__Import_IPhotoImportSource = interface(IInspectable)
  ['{2C2DEFF8-BDA2-5573-A743-77032B04FB7D}']
    function First: IIterator_1__Import_IPhotoImportSource; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportSource>
  IVectorView_1__Import_IPhotoImportSource = interface(IInspectable)
  ['{0EEF3559-5B9B-5AF3-895C-328456DD2BF3}']
    function GetAt(index: Cardinal): Import_IPhotoImportSource; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Import_IPhotoImportSource; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PImport_IPhotoImportSource): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportSource>>
  AsyncOperationCompletedHandler_1__IVectorView_1__Import_IPhotoImportSource = interface(IUnknown)
  ['{A3BA1A86-C72C-567C-9114-7ECD92B23804}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__Import_IPhotoImportSource; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportSource>>
  IAsyncOperation_1__IVectorView_1__Import_IPhotoImportSource = interface(IInspectable)
  ['{27E4DC99-1B11-55D6-A063-24D214B2B843}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__Import_IPhotoImportSource); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__Import_IPhotoImportSource; safecall;
    function GetResults: IVectorView_1__Import_IPhotoImportSource; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__Import_IPhotoImportSource read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Import.IPhotoImportOperation
  [WinRTClassNameAttribute(SImport_PhotoImportOperation)]
  Import_IPhotoImportOperation = interface(IInspectable)
  ['{D9F797E4-A09A-4EE4-A4B1-20940277A5BE}']
    function get_Stage: Import_PhotoImportStage; safecall;
    function get_Session: Import_IPhotoImportSession; safecall;
    function get_ContinueFindingItemsAsync: IAsyncOperationWithProgress_2__Import_IPhotoImportFindItemsResult__Cardinal; safecall;
    function get_ContinueImportingItemsAsync: IAsyncOperationWithProgress_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress; safecall;
    function get_ContinueDeletingImportedItemsFromSourceAsync: IAsyncOperationWithProgress_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double; safecall;
    property ContinueDeletingImportedItemsFromSourceAsync: IAsyncOperationWithProgress_2__Import_IPhotoImportDeleteImportedItemsFromSourceResult__Double read get_ContinueDeletingImportedItemsFromSourceAsync;
    property ContinueFindingItemsAsync: IAsyncOperationWithProgress_2__Import_IPhotoImportFindItemsResult__Cardinal read get_ContinueFindingItemsAsync;
    property ContinueImportingItemsAsync: IAsyncOperationWithProgress_2__Import_IPhotoImportImportItemsResult__Import_PhotoImportProgress read get_ContinueImportingItemsAsync;
    property Session: Import_IPhotoImportSession read get_Session;
    property Stage: Import_PhotoImportStage read get_Stage;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Import.IPhotoImportOperation>
  IIterator_1__Import_IPhotoImportOperation = interface(IInspectable)
  ['{61EAAC9A-E337-5E73-AE8C-46866038D643}']
    function get_Current: Import_IPhotoImportOperation; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PImport_IPhotoImportOperation): Cardinal; safecall;
    property Current: Import_IPhotoImportOperation read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Import.IPhotoImportOperation>
  IIterable_1__Import_IPhotoImportOperation = interface(IInspectable)
  ['{F12CCD56-8C6A-5B1D-A322-B6F967525008}']
    function First: IIterator_1__Import_IPhotoImportOperation; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Import.IPhotoImportOperation>
  IVectorView_1__Import_IPhotoImportOperation = interface(IInspectable)
  ['{03C84016-1194-5C35-BF26-AFAEB26C1626}']
    function GetAt(index: Cardinal): Import_IPhotoImportOperation; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Import_IPhotoImportOperation; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PImport_IPhotoImportOperation): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Import.IPhotoImportManagerStatics
  [WinRTClassNameAttribute(SImport_PhotoImportManager)]
  Import_IPhotoImportManagerStatics = interface(IInspectable)
  ['{2771903D-A046-4F06-9B9C-BFD662E83287}']
    function IsSupportedAsync: IAsyncOperation_1__Boolean; safecall;
    function FindAllSourcesAsync: IAsyncOperation_1__IVectorView_1__Import_IPhotoImportSource; safecall;
    function GetPendingOperations: IVectorView_1__Import_IPhotoImportOperation; safecall;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Import.IPhotoImportSource>
  AsyncOperationCompletedHandler_1__Import_IPhotoImportSource = interface(IUnknown)
  ['{D13718A8-C27E-5C35-A3D3-F1548B670C46}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Import_IPhotoImportSource; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Import.IPhotoImportSource>
  IAsyncOperation_1__Import_IPhotoImportSource = interface(IInspectable)
  ['{4CE1935D-7478-5009-AB7E-EA3930D4120D}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Import_IPhotoImportSource); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Import_IPhotoImportSource; safecall;
    function GetResults: Import_IPhotoImportSource; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Import_IPhotoImportSource read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Import.IPhotoImportSourceStatics
  [WinRTClassNameAttribute(SImport_PhotoImportSource)]
  Import_IPhotoImportSourceStatics = interface(IInspectable)
  ['{0528E586-32D8-467C-8CEE-23A1B2F43E85}']
    function FromIdAsync(sourceId: HSTRING): IAsyncOperation_1__Import_IPhotoImportSource; safecall;
    function FromFolderAsync(sourceRootFolder: IStorageFolder): IAsyncOperation_1__Import_IPhotoImportSource; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Playback.IMediaPlaybackSource
  Playback_IMediaPlaybackSource = interface(IInspectable)
  ['{EF9DC2BC-9317-4696-B051-2BAD643177B5}']
  end;

  // DualAPI Interface
  // Windows.Media.Core.IAudioStreamDescriptor
  [WinRTClassNameAttribute(SCore_AudioStreamDescriptor)]
  Core_IAudioStreamDescriptor = interface(IInspectable)
  ['{1E3692E4-4027-4847-A70B-DF1D9A2A7B04}']
    function get_EncodingProperties: IAudioEncodingProperties; safecall;
    property EncodingProperties: IAudioEncodingProperties read get_EncodingProperties;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.IAudioStreamDescriptor>
  IIterator_1__Core_IAudioStreamDescriptor = interface(IInspectable)
  ['{676BE182-2B2B-5755-94CB-DD512AD111BE}']
    function get_Current: Core_IAudioStreamDescriptor; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PCore_IAudioStreamDescriptor): Cardinal; safecall;
    property Current: Core_IAudioStreamDescriptor read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.IAudioStreamDescriptor>
  IIterable_1__Core_IAudioStreamDescriptor_Base = interface(IInspectable)
  ['{A3E2C972-A171-5B94-8389-E983EBC3F3B9}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.IAudioStreamDescriptor>
  IIterable_1__Core_IAudioStreamDescriptor = interface(IIterable_1__Core_IAudioStreamDescriptor_Base)
  ['{93E7C43E-0D19-5EEA-B110-02B24E6E007F}']
    function First: IIterator_1__Core_IAudioStreamDescriptor; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.IAudioStreamDescriptor>
  IVectorView_1__Core_IAudioStreamDescriptor = interface(IInspectable)
  ['{A97548F5-13ED-5B5D-86C2-D9853F89CBD3}']
    function GetAt(index: Cardinal): Core_IAudioStreamDescriptor; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Core_IAudioStreamDescriptor; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_IAudioStreamDescriptor): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Core.IAudioStreamDescriptor>
  IVector_1__Core_IAudioStreamDescriptor = interface(IInspectable)
  ['{4AA8CDE4-787E-5075-AF19-B5E29A5B4A75}']
    function GetAt(index: Cardinal): Core_IAudioStreamDescriptor; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Core_IAudioStreamDescriptor; safecall;
    function IndexOf(value: Core_IAudioStreamDescriptor; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Core_IAudioStreamDescriptor); safecall;
    procedure InsertAt(index: Cardinal; value: Core_IAudioStreamDescriptor); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Core_IAudioStreamDescriptor); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_IAudioStreamDescriptor): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PCore_IAudioStreamDescriptor); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IVideoStreamDescriptor
  [WinRTClassNameAttribute(SCore_VideoStreamDescriptor)]
  Core_IVideoStreamDescriptor = interface(IInspectable)
  ['{12EE0D55-9C2B-4440-8057-2C7A90F0CBEC}']
    function get_EncodingProperties: IVideoEncodingProperties; safecall;
    property EncodingProperties: IVideoEncodingProperties read get_EncodingProperties;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.IVideoStreamDescriptor>
  IIterator_1__Core_IVideoStreamDescriptor = interface(IInspectable)
  ['{360EA333-DC3F-5682-986B-4C807136494A}']
    function get_Current: Core_IVideoStreamDescriptor; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PCore_IVideoStreamDescriptor): Cardinal; safecall;
    property Current: Core_IVideoStreamDescriptor read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.IVideoStreamDescriptor>
  IIterable_1__Core_IVideoStreamDescriptor_Base = interface(IInspectable)
  ['{3ACBF03C-0A79-5823-AAA9-D88BC3F8F594}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.IVideoStreamDescriptor>
  IIterable_1__Core_IVideoStreamDescriptor = interface(IIterable_1__Core_IVideoStreamDescriptor_Base)
  ['{279FFF16-8217-56BF-8117-B3BCA6705D0B}']
    function First: IIterator_1__Core_IVideoStreamDescriptor; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.IVideoStreamDescriptor>
  IVectorView_1__Core_IVideoStreamDescriptor = interface(IInspectable)
  ['{169BE92A-80D0-5ABF-A578-524970C2FEF3}']
    function GetAt(index: Cardinal): Core_IVideoStreamDescriptor; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Core_IVideoStreamDescriptor; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_IVideoStreamDescriptor): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Core.IVideoStreamDescriptor>
  IVector_1__Core_IVideoStreamDescriptor = interface(IInspectable)
  ['{F4E5A134-CFFB-52DE-B2A9-5FA3AC96885E}']
    function GetAt(index: Cardinal): Core_IVideoStreamDescriptor; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Core_IVideoStreamDescriptor; safecall;
    function IndexOf(value: Core_IVideoStreamDescriptor; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Core_IVideoStreamDescriptor); safecall;
    procedure InsertAt(index: Cardinal; value: Core_IVideoStreamDescriptor); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Core_IVideoStreamDescriptor); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_IVideoStreamDescriptor): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PCore_IVideoStreamDescriptor); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Media.Protection.PlayReady.INDSendResult
  Protection_PlayReady_INDSendResult = interface(IInspectable)
  ['{E3685517-A584-479D-90B7-D689C7BF7C80}']
    function get_Response(resultSize: Cardinal; resultValue: PByte): HRESULT; stdcall;
    // property Response: PByte read get_Response;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Protection.PlayReady.INDSendResult>
  AsyncOperationCompletedHandler_1__Protection_PlayReady_INDSendResult_Delegate_Base = interface(IUnknown)
  ['{85D6389C-765E-574A-B69A-C8DE41EF9102}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Protection.PlayReady.INDSendResult>
  AsyncOperationCompletedHandler_1__Protection_PlayReady_INDSendResult = interface(AsyncOperationCompletedHandler_1__Protection_PlayReady_INDSendResult_Delegate_Base)
  ['{C6C485D0-FDAB-5142-B079-97AF0567F0B6}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Protection_PlayReady_INDSendResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Protection.PlayReady.INDSendResult>
  IAsyncOperation_1__Protection_PlayReady_INDSendResult_Base = interface(IInspectable)
  ['{D914A124-9ED1-5744-AA03-B66FCB87CC0C}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Protection.PlayReady.INDSendResult>
  IAsyncOperation_1__Protection_PlayReady_INDSendResult = interface(IAsyncOperation_1__Protection_PlayReady_INDSendResult_Base)
  ['{6C3788A8-0E6D-5E29-9AD1-D88A65EB500B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Protection_PlayReady_INDSendResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Protection_PlayReady_INDSendResult; safecall;
    function GetResults: Protection_PlayReady_INDSendResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Protection_PlayReady_INDSendResult read get_Completed write put_Completed;
  end;

  // Windows.Media.Protection.PlayReady.INDTransmitterProperties
  Protection_PlayReady_INDTransmitterProperties = interface(IInspectable)
  ['{E536AF23-AC4F-4ADC-8C66-4FF7C2702DD6}']
    function get_CertificateType: Protection_PlayReady_NDCertificateType; safecall;
    function get_PlatformIdentifier: Protection_PlayReady_NDCertificatePlatformID; safecall;
    function get_SupportedFeatures(resultSize: Cardinal; resultValue: PProtection_PlayReady_NDCertificateFeature): HRESULT; stdcall;
    function get_SecurityLevel: Cardinal; safecall;
    function get_SecurityVersion: Cardinal; safecall;
    function get_ExpirationDate: DateTime; safecall;
    function get_ClientID(resultSize: Cardinal; resultValue: PByte): HRESULT; stdcall;
    function get_ModelDigest(resultSize: Cardinal; resultValue: PByte): HRESULT; stdcall;
    function get_ModelManufacturerName: HSTRING; safecall;
    function get_ModelName: HSTRING; safecall;
    function get_ModelNumber: HSTRING; safecall;
    property CertificateType: Protection_PlayReady_NDCertificateType read get_CertificateType;
    // property ClientID: PByte read get_ClientID;
    property ExpirationDate: DateTime read get_ExpirationDate;
    // property ModelDigest: PByte read get_ModelDigest;
    property ModelManufacturerName: HSTRING read get_ModelManufacturerName;
    property ModelName: HSTRING read get_ModelName;
    property ModelNumber: HSTRING read get_ModelNumber;
    property PlatformIdentifier: Protection_PlayReady_NDCertificatePlatformID read get_PlatformIdentifier;
    property SecurityLevel: Cardinal read get_SecurityLevel;
    property SecurityVersion: Cardinal read get_SecurityVersion;
    // property SupportedFeatures: PProtection_PlayReady_NDCertificateFeature read get_SupportedFeatures;
  end;

  // Windows.Media.Protection.PlayReady.INDStartResult
  Protection_PlayReady_INDStartResult = interface(IInspectable)
  ['{79F6E96E-F50F-4015-8BA4-C2BC344EBD4E}']
    function get_MediaStreamSource: Core_IMediaStreamSource; safecall;
    property MediaStreamSource: Core_IMediaStreamSource read get_MediaStreamSource;
  end;

  // Windows.Media.Protection.PlayReady.INDProximityDetectionCompletedEventArgs
  Protection_PlayReady_INDProximityDetectionCompletedEventArgs = interface(IInspectable)
  ['{2A706328-DA25-4F8C-9EB7-5D0FC3658BCA}']
    function get_ProximityDetectionRetryCount: Cardinal; safecall;
    property ProximityDetectionRetryCount: Cardinal read get_ProximityDetectionRetryCount;
  end;

  // Windows.Media.Protection.PlayReady.INDClosedCaptionDataReceivedEventArgs
  Protection_PlayReady_INDClosedCaptionDataReceivedEventArgs = interface(IInspectable)
  ['{4738D29F-C345-4649-8468-B8C5FC357190}']
    function get_ClosedCaptionDataFormat: Protection_PlayReady_NDClosedCaptionFormat; safecall;
    function get_PresentationTimestamp: Int64; safecall;
    function get_ClosedCaptionData(resultSize: Cardinal; resultValue: PByte): HRESULT; stdcall;
    // property ClosedCaptionData: PByte read get_ClosedCaptionData;
    property ClosedCaptionDataFormat: Protection_PlayReady_NDClosedCaptionFormat read get_ClosedCaptionDataFormat;
    property PresentationTimestamp: Int64 read get_PresentationTimestamp;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Protection.PlayReady.INDStartResult>
  AsyncOperationCompletedHandler_1__Protection_PlayReady_INDStartResult_Delegate_Base = interface(IUnknown)
  ['{75F160F5-4699-535B-912C-278BF94BF2EE}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Protection.PlayReady.INDStartResult>
  AsyncOperationCompletedHandler_1__Protection_PlayReady_INDStartResult = interface(AsyncOperationCompletedHandler_1__Protection_PlayReady_INDStartResult_Delegate_Base)
  ['{1E4E3760-B22B-5F0A-9058-475AFF310DB5}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Protection_PlayReady_INDStartResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Protection.PlayReady.INDStartResult>
  IAsyncOperation_1__Protection_PlayReady_INDStartResult_Base = interface(IInspectable)
  ['{EFC92F3A-9347-514F-BFB5-D019B9AA154B}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Protection.PlayReady.INDStartResult>
  IAsyncOperation_1__Protection_PlayReady_INDStartResult = interface(IAsyncOperation_1__Protection_PlayReady_INDStartResult_Base)
  ['{01FAB63E-6AAB-54A2-80F7-DBED22F58D56}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Protection_PlayReady_INDStartResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Protection_PlayReady_INDStartResult; safecall;
    function GetResults: Protection_PlayReady_INDStartResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Protection_PlayReady_INDStartResult read get_Completed write put_Completed;
  end;

  // Windows.Media.IMediaMarker
  IMediaMarker = interface(IInspectable)
  ['{1803DEF8-DCA5-4B6F-9C20-E3D3C0643625}']
    function get_Time: TimeSpan; safecall;
    function get_MediaMarkerType: HSTRING; safecall;
    function get_Text: HSTRING; safecall;
    property MediaMarkerType: HSTRING read get_MediaMarkerType;
    property Text: HSTRING read get_Text;
    property Time: TimeSpan read get_Time;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.IMediaMarker>
  IIterator_1__IMediaMarker = interface(IInspectable)
  ['{F464661E-88BC-5CEA-93CD-0C123F17D258}']
    function get_Current: IMediaMarker; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIMediaMarker): Cardinal; safecall;
    property Current: IMediaMarker read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.IMediaMarker>
  IIterable_1__IMediaMarker = interface(IInspectable)
  ['{A1C0A397-0364-5E4C-9DCA-7CD7011BD114}']
    function First: IIterator_1__IMediaMarker; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.IMediaMarker>
  IVectorView_1__IMediaMarker = interface(IInspectable)
  ['{B543562C-02B1-5824-80A8-9854130CDADD}']
    function GetAt(index: Cardinal): IMediaMarker; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IMediaMarker; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIMediaMarker): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Media.IMediaMarkers
  IMediaMarkers = interface(IInspectable)
  ['{AFEAB189-F8DD-466E-AA10-920B52353FDF}']
    function get_Markers: IVectorView_1__IMediaMarker; safecall;
    property Markers: IVectorView_1__IMediaMarker read get_Markers;
  end;

  // Windows.Media.Capture.IMediaCaptureFailedEventArgs
  Capture_IMediaCaptureFailedEventArgs = interface(IInspectable)
  ['{80FDE3F4-54C4-42C0-8D19-CEA1A87CA18B}']
    function get_Message: HSTRING; safecall;
    function get_Code: Cardinal; safecall;
    property Code: Cardinal read get_Code;
    property Message: HSTRING read get_Message;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IMediaCaptureInitializationSettings
  [WinRTClassNameAttribute(SCapture_MediaCaptureInitializationSettings)]
  Capture_IMediaCaptureInitializationSettings = interface(IInspectable)
  ['{9782BA70-EA65-4900-9356-8CA887726884}']
    procedure put_AudioDeviceId(value: HSTRING); safecall;
    function get_AudioDeviceId: HSTRING; safecall;
    procedure put_VideoDeviceId(value: HSTRING); safecall;
    function get_VideoDeviceId: HSTRING; safecall;
    procedure put_StreamingCaptureMode(value: Capture_StreamingCaptureMode); safecall;
    function get_StreamingCaptureMode: Capture_StreamingCaptureMode; safecall;
    procedure put_PhotoCaptureSource(value: Capture_PhotoCaptureSource); safecall;
    function get_PhotoCaptureSource: Capture_PhotoCaptureSource; safecall;
    property AudioDeviceId: HSTRING read get_AudioDeviceId write put_AudioDeviceId;
    property PhotoCaptureSource: Capture_PhotoCaptureSource read get_PhotoCaptureSource write put_PhotoCaptureSource;
    property StreamingCaptureMode: Capture_StreamingCaptureMode read get_StreamingCaptureMode write put_StreamingCaptureMode;
    property VideoDeviceId: HSTRING read get_VideoDeviceId write put_VideoDeviceId;
  end;

  // DualAPI Interface
  // Windows.Media.IMediaExtension
  IMediaExtension = interface(IInspectable)
  ['{07915118-45DF-442B-8A3F-F7826A6370AB}']
    procedure SetProperties(configuration: IPropertySet); safecall;
  end;

  // Windows.Media.Capture.RecordLimitationExceededEventHandler
  Capture_RecordLimitationExceededEventHandler = interface(IUnknown)
  ['{3FAE8F2E-4FE1-4FFD-AABA-E1F1337D4E53}']
    procedure Invoke(sender: Capture_IMediaCapture); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IMediaCaptureSettings
  [WinRTClassNameAttribute(SCapture_MediaCaptureSettings)]
  Capture_IMediaCaptureSettings = interface(IInspectable)
  ['{1D83AAFE-6D45-4477-8DC4-AC5BC01C4091}']
    function get_AudioDeviceId: HSTRING; safecall;
    function get_VideoDeviceId: HSTRING; safecall;
    function get_StreamingCaptureMode: Capture_StreamingCaptureMode; safecall;
    function get_PhotoCaptureSource: Capture_PhotoCaptureSource; safecall;
    function get_VideoDeviceCharacteristic: Capture_VideoDeviceCharacteristic; safecall;
    property AudioDeviceId: HSTRING read get_AudioDeviceId;
    property PhotoCaptureSource: Capture_PhotoCaptureSource read get_PhotoCaptureSource;
    property StreamingCaptureMode: Capture_StreamingCaptureMode read get_StreamingCaptureMode;
    property VideoDeviceCharacteristic: Capture_VideoDeviceCharacteristic read get_VideoDeviceCharacteristic;
    property VideoDeviceId: HSTRING read get_VideoDeviceId;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IMediaCapture
  [WinRTClassNameAttribute(SCapture_MediaCapture)]
  Capture_IMediaCapture = interface(IInspectable)
  ['{C61AFBB4-FB10-4A34-AC18-CA80D9C8E7EE}']
    function InitializeAsync: IAsyncAction; overload; safecall;
    function InitializeAsync(mediaCaptureInitializationSettings: Capture_IMediaCaptureInitializationSettings): IAsyncAction; overload; safecall;
    function StartRecordToStorageFileAsync(encodingProfile: IMediaEncodingProfile; &file: IStorageFile): IAsyncAction; safecall;
    function StartRecordToStreamAsync(encodingProfile: IMediaEncodingProfile; stream: IRandomAccessStream): IAsyncAction; safecall;
    function StartRecordToCustomSinkAsync(encodingProfile: IMediaEncodingProfile; customMediaSink: IMediaExtension): IAsyncAction; overload; safecall;
    function StartRecordToCustomSinkAsync(encodingProfile: IMediaEncodingProfile; customSinkActivationId: HSTRING; customSinkSettings: IPropertySet): IAsyncAction; overload; safecall;
    function StopRecordAsync: IAsyncAction; safecall;
    function CapturePhotoToStorageFileAsync(&type: IImageEncodingProperties; &file: IStorageFile): IAsyncAction; safecall;
    function CapturePhotoToStreamAsync(&type: IImageEncodingProperties; stream: IRandomAccessStream): IAsyncAction; safecall;
    function AddEffectAsync(mediaStreamType: Capture_MediaStreamType; effectActivationID: HSTRING; effectSettings: IPropertySet): IAsyncAction; safecall;
    function ClearEffectsAsync(mediaStreamType: Capture_MediaStreamType): IAsyncAction; safecall;
    procedure SetEncoderProperty(mediaStreamType: Capture_MediaStreamType; propertyId: TGuid; propertyValue: IInspectable); safecall;
    function GetEncoderProperty(mediaStreamType: Capture_MediaStreamType; propertyId: TGuid): IInspectable; safecall;
    function add_Failed(errorEventHandler: Capture_MediaCaptureFailedEventHandler): EventRegistrationToken; safecall;
    procedure remove_Failed(eventCookie: EventRegistrationToken); safecall;
    function add_RecordLimitationExceeded(recordLimitationExceededEventHandler: Capture_RecordLimitationExceededEventHandler): EventRegistrationToken; safecall;
    procedure remove_RecordLimitationExceeded(eventCookie: EventRegistrationToken); safecall;
    function get_MediaCaptureSettings: Capture_IMediaCaptureSettings; safecall;
    function get_AudioDeviceController: IAudioDeviceController; safecall;
    function get_VideoDeviceController: IVideoDeviceController; safecall;
    procedure SetPreviewMirroring(value: Boolean); safecall;
    function GetPreviewMirroring: Boolean; safecall;
    procedure SetPreviewRotation(value: Capture_VideoRotation); safecall;
    function GetPreviewRotation: Capture_VideoRotation; safecall;
    procedure SetRecordRotation(value: Capture_VideoRotation); safecall;
    function GetRecordRotation: Capture_VideoRotation; safecall;
    property AudioDeviceController: IAudioDeviceController read get_AudioDeviceController;
    property MediaCaptureSettings: Capture_IMediaCaptureSettings read get_MediaCaptureSettings;
    property VideoDeviceController: IVideoDeviceController read get_VideoDeviceController;
  end;

  // Windows.Media.Capture.MediaCaptureFailedEventHandler
  Capture_MediaCaptureFailedEventHandler = interface(IUnknown)
  ['{2014EFFB-5CD8-4F08-A314-0D360DA59F14}']
    procedure Invoke(sender: Capture_IMediaCapture; errorEventArgs: Capture_IMediaCaptureFailedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IMediaCaptureVideoProfileMediaDescription
  [WinRTClassNameAttribute(SCapture_MediaCaptureVideoProfileMediaDescription)]
  Capture_IMediaCaptureVideoProfileMediaDescription = interface(IInspectable)
  ['{8012AFEF-B691-49FF-83F2-C1E76EAAEA1B}']
    function get_Width: Cardinal; safecall;
    function get_Height: Cardinal; safecall;
    function get_FrameRate: Double; safecall;
    function get_IsVariablePhotoSequenceSupported: Boolean; safecall;
    function get_IsHdrVideoSupported: Boolean; safecall;
    property FrameRate: Double read get_FrameRate;
    property Height: Cardinal read get_Height;
    property IsHdrVideoSupported: Boolean read get_IsHdrVideoSupported;
    property IsVariablePhotoSequenceSupported: Boolean read get_IsVariablePhotoSequenceSupported;
    property Width: Cardinal read get_Width;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Capture.IMediaCaptureVideoProfileMediaDescription>
  IIterator_1__Capture_IMediaCaptureVideoProfileMediaDescription = interface(IInspectable)
  ['{D8A28063-75B8-5B18-99F6-DAA842E0E03E}']
    function get_Current: Capture_IMediaCaptureVideoProfileMediaDescription; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PCapture_IMediaCaptureVideoProfileMediaDescription): Cardinal; safecall;
    property Current: Capture_IMediaCaptureVideoProfileMediaDescription read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Capture.IMediaCaptureVideoProfileMediaDescription>
  IIterable_1__Capture_IMediaCaptureVideoProfileMediaDescription_Base = interface(IInspectable)
  ['{0895E56D-FE1F-5364-AB67-C597D8970B89}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Capture.IMediaCaptureVideoProfileMediaDescription>
  IIterable_1__Capture_IMediaCaptureVideoProfileMediaDescription = interface(IIterable_1__Capture_IMediaCaptureVideoProfileMediaDescription_Base)
  ['{6DA537F0-3321-5348-A52A-D3C7EB841B6E}']
    function First: IIterator_1__Capture_IMediaCaptureVideoProfileMediaDescription; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Capture.IMediaCaptureVideoProfileMediaDescription>
  IVectorView_1__Capture_IMediaCaptureVideoProfileMediaDescription = interface(IInspectable)
  ['{05C7BEEF-90A2-559D-BAA7-EF2829B73F50}']
    function GetAt(index: Cardinal): Capture_IMediaCaptureVideoProfileMediaDescription; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Capture_IMediaCaptureVideoProfileMediaDescription; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCapture_IMediaCaptureVideoProfileMediaDescription): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Capture.IMediaCaptureVideoProfile>
  IIterator_1__Capture_IMediaCaptureVideoProfile = interface(IInspectable)
  ['{C79887D9-00EC-5467-ACE7-526C66AE12EC}']
    function get_Current: Capture_IMediaCaptureVideoProfile; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PCapture_IMediaCaptureVideoProfile): Cardinal; safecall;
    property Current: Capture_IMediaCaptureVideoProfile read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Capture.IMediaCaptureVideoProfile>
  IIterable_1__Capture_IMediaCaptureVideoProfile_Base = interface(IInspectable)
  ['{DBD49D71-E07B-5E11-824A-62ACE8BDFC3E}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Capture.IMediaCaptureVideoProfile>
  IIterable_1__Capture_IMediaCaptureVideoProfile = interface(IIterable_1__Capture_IMediaCaptureVideoProfile_Base)
  ['{AA89F4F4-E6A8-5FE1-9F90-8EC7D6361B78}']
    function First: IIterator_1__Capture_IMediaCaptureVideoProfile; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Capture.IMediaCaptureVideoProfile>
  IVectorView_1__Capture_IMediaCaptureVideoProfile = interface(IInspectable)
  ['{ACAE267E-7B10-533A-BAA3-DA739D17B4D8}']
    function GetAt(index: Cardinal): Capture_IMediaCaptureVideoProfile; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Capture_IMediaCaptureVideoProfile; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCapture_IMediaCaptureVideoProfile): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IMediaCaptureVideoProfile
  [WinRTClassNameAttribute(SCapture_MediaCaptureVideoProfile)]
  Capture_IMediaCaptureVideoProfile = interface(IInspectable)
  ['{21A073BF-A3EE-4ECF-9EF6-50B0BC4E1305}']
    function get_Id: HSTRING; safecall;
    function get_VideoDeviceId: HSTRING; safecall;
    function get_SupportedPreviewMediaDescription: IVectorView_1__Capture_IMediaCaptureVideoProfileMediaDescription; safecall;
    function get_SupportedRecordMediaDescription: IVectorView_1__Capture_IMediaCaptureVideoProfileMediaDescription; safecall;
    function get_SupportedPhotoMediaDescription: IVectorView_1__Capture_IMediaCaptureVideoProfileMediaDescription; safecall;
    function GetConcurrency: IVectorView_1__Capture_IMediaCaptureVideoProfile; safecall;
    property Id: HSTRING read get_Id;
    property SupportedPhotoMediaDescription: IVectorView_1__Capture_IMediaCaptureVideoProfileMediaDescription read get_SupportedPhotoMediaDescription;
    property SupportedPreviewMediaDescription: IVectorView_1__Capture_IMediaCaptureVideoProfileMediaDescription read get_SupportedPreviewMediaDescription;
    property SupportedRecordMediaDescription: IVectorView_1__Capture_IMediaCaptureVideoProfileMediaDescription read get_SupportedRecordMediaDescription;
    property VideoDeviceId: HSTRING read get_VideoDeviceId;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IMediaCaptureInitializationSettings2
  Capture_IMediaCaptureInitializationSettings2 = interface(IInspectable)
  ['{404E0626-C9DC-43E9-AEE4-E6BF1B57B44C}']
    procedure put_MediaCategory(value: Capture_MediaCategory); safecall;
    function get_MediaCategory: Capture_MediaCategory; safecall;
    procedure put_AudioProcessing(value: AudioProcessing); safecall;
    function get_AudioProcessing: AudioProcessing; safecall;
    property AudioProcessing: AudioProcessing read get_AudioProcessing write put_AudioProcessing;
    property MediaCategory: Capture_MediaCategory read get_MediaCategory write put_MediaCategory;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IMediaCaptureInitializationSettings3
  Capture_IMediaCaptureInitializationSettings3 = interface(IInspectable)
  ['{4160519D-BE48-4730-8104-0CF6E9E97948}']
    procedure put_AudioSource(value: Core_IMediaSource); safecall;
    function get_AudioSource: Core_IMediaSource; safecall;
    procedure put_VideoSource(value: Core_IMediaSource); safecall;
    function get_VideoSource: Core_IMediaSource; safecall;
    property AudioSource: Core_IMediaSource read get_AudioSource write put_AudioSource;
    property VideoSource: Core_IMediaSource read get_VideoSource write put_VideoSource;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IMediaCaptureInitializationSettings4
  Capture_IMediaCaptureInitializationSettings4 = interface(IInspectable)
  ['{F502A537-4CB7-4D28-95ED-4F9F012E0518}']
    function get_VideoProfile: Capture_IMediaCaptureVideoProfile; safecall;
    procedure put_VideoProfile(value: Capture_IMediaCaptureVideoProfile); safecall;
    function get_PreviewMediaDescription: Capture_IMediaCaptureVideoProfileMediaDescription; safecall;
    procedure put_PreviewMediaDescription(value: Capture_IMediaCaptureVideoProfileMediaDescription); safecall;
    function get_RecordMediaDescription: Capture_IMediaCaptureVideoProfileMediaDescription; safecall;
    procedure put_RecordMediaDescription(value: Capture_IMediaCaptureVideoProfileMediaDescription); safecall;
    function get_PhotoMediaDescription: Capture_IMediaCaptureVideoProfileMediaDescription; safecall;
    procedure put_PhotoMediaDescription(value: Capture_IMediaCaptureVideoProfileMediaDescription); safecall;
    property PhotoMediaDescription: Capture_IMediaCaptureVideoProfileMediaDescription read get_PhotoMediaDescription write put_PhotoMediaDescription;
    property PreviewMediaDescription: Capture_IMediaCaptureVideoProfileMediaDescription read get_PreviewMediaDescription write put_PreviewMediaDescription;
    property RecordMediaDescription: Capture_IMediaCaptureVideoProfileMediaDescription read get_RecordMediaDescription write put_RecordMediaDescription;
    property VideoProfile: Capture_IMediaCaptureVideoProfile read get_VideoProfile write put_VideoProfile;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IMediaCaptureStatics
  [WinRTClassNameAttribute(SCapture_MediaCapture)]
  Capture_IMediaCaptureStatics = interface(IInspectable)
  ['{ACEF81FF-99ED-4645-965E-1925CFC63834}']
    function IsVideoProfileSupported(videoDeviceId: HSTRING): Boolean; safecall;
    function FindAllVideoProfiles(videoDeviceId: HSTRING): IVectorView_1__Capture_IMediaCaptureVideoProfile; safecall;
    function FindConcurrentProfiles(videoDeviceId: HSTRING): IVectorView_1__Capture_IMediaCaptureVideoProfile; safecall;
    function FindKnownVideoProfiles(videoDeviceId: HSTRING; name: Capture_KnownVideoProfile): IVectorView_1__Capture_IMediaCaptureVideoProfile; safecall;
  end;

  // Windows.Media.Effects.IVideoCompositor
  Effects_IVideoCompositor = interface(IInspectable)
  ['{8510B43E-420C-420F-96C7-7C98BBA1FC55}']
    function get_TimeIndependent: Boolean; safecall;
    procedure SetEncodingProperties(backgroundProperties: IVideoEncodingProperties; device: DirectX_Direct3D11_IDirect3DDevice); safecall;
    procedure CompositeFrame(context: Effects_ICompositeVideoFrameContext); safecall;
    procedure Close(reason: Effects_MediaEffectClosedReason); safecall;
    procedure DiscardQueuedFrames; safecall;
    property TimeIndependent: Boolean read get_TimeIndependent;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.ILowLagMediaRecording
  [WinRTClassNameAttribute(SCapture_LowLagMediaRecording)]
  Capture_ILowLagMediaRecording = interface(IInspectable)
  ['{41C8BAF7-FF3F-49F0-A477-F195E3CE5108}']
    function StartAsync: IAsyncAction; safecall;
    function StopAsync: IAsyncAction; safecall;
    function FinishAsync: IAsyncAction; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.ILowLagMediaRecording>
  AsyncOperationCompletedHandler_1__Capture_ILowLagMediaRecording_Delegate_Base = interface(IUnknown)
  ['{64A8F80C-E646-52BB-8F4B-2A1D6B0B8219}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.ILowLagMediaRecording>
  AsyncOperationCompletedHandler_1__Capture_ILowLagMediaRecording = interface(AsyncOperationCompletedHandler_1__Capture_ILowLagMediaRecording_Delegate_Base)
  ['{CC1AFB16-7B7E-56A5-984E-1AF16BE62978}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Capture_ILowLagMediaRecording; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.ILowLagMediaRecording>
  IAsyncOperation_1__Capture_ILowLagMediaRecording_Base = interface(IInspectable)
  ['{4FEBEFCC-BEC0-5433-A7BA-7603D1EDC7B9}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.ILowLagMediaRecording>
  IAsyncOperation_1__Capture_ILowLagMediaRecording = interface(IAsyncOperation_1__Capture_ILowLagMediaRecording_Base)
  ['{28D1B875-02BB-5F2C-AE79-E28CAEC91E64}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Capture_ILowLagMediaRecording); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Capture_ILowLagMediaRecording; safecall;
    function GetResults: Capture_ILowLagMediaRecording; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Capture_ILowLagMediaRecording read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.ICapturedFrame
  [WinRTClassNameAttribute(SCapture_CapturedFrame)]
  Capture_ICapturedFrame = interface(IInspectable)
  ['{1DD2DE1F-571B-44D8-8E80-A08A1578766E}']
    function get_Width: Cardinal; safecall;
    function get_Height: Cardinal; safecall;
    property Height: Cardinal read get_Height;
    property Width: Cardinal read get_Width;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.ICapturedPhoto
  [WinRTClassNameAttribute(SCapture_CapturedPhoto)]
  Capture_ICapturedPhoto = interface(IInspectable)
  ['{B0CE7E5A-CFCC-4D6C-8AD1-0869208ACA16}']
    function get_Frame: Capture_ICapturedFrame; safecall;
    function get_Thumbnail: Capture_ICapturedFrame; safecall;
    property Frame: Capture_ICapturedFrame read get_Frame;
    property Thumbnail: Capture_ICapturedFrame read get_Thumbnail;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.ICapturedPhoto>
  AsyncOperationCompletedHandler_1__Capture_ICapturedPhoto_Delegate_Base = interface(IUnknown)
  ['{FDB0AA78-04E1-56B3-B6FC-F4DE79CD41A0}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.ICapturedPhoto>
  AsyncOperationCompletedHandler_1__Capture_ICapturedPhoto = interface(AsyncOperationCompletedHandler_1__Capture_ICapturedPhoto_Delegate_Base)
  ['{4B2524D3-9AA6-5F16-B25E-B5997E21DCB2}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Capture_ICapturedPhoto; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.ICapturedPhoto>
  IAsyncOperation_1__Capture_ICapturedPhoto_Base = interface(IInspectable)
  ['{AF5235B1-4778-55E1-B49F-608048EA9BD9}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.ICapturedPhoto>
  IAsyncOperation_1__Capture_ICapturedPhoto = interface(IAsyncOperation_1__Capture_ICapturedPhoto_Base)
  ['{397F5882-DD79-5694-B055-FB1075CE20AF}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Capture_ICapturedPhoto); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Capture_ICapturedPhoto; safecall;
    function GetResults: Capture_ICapturedPhoto; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Capture_ICapturedPhoto read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.ILowLagPhotoCapture
  [WinRTClassNameAttribute(SCapture_LowLagPhotoCapture)]
  Capture_ILowLagPhotoCapture = interface(IInspectable)
  ['{A37251B7-6B44-473D-8F24-F703D6C0EC44}']
    function CaptureAsync: IAsyncOperation_1__Capture_ICapturedPhoto; safecall;
    function FinishAsync: IAsyncAction; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.ILowLagPhotoCapture>
  AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoCapture_Delegate_Base = interface(IUnknown)
  ['{6CEBB368-4E84-500A-9A5F-7B9A1ADE1F44}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.ILowLagPhotoCapture>
  AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoCapture = interface(AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoCapture_Delegate_Base)
  ['{4761919E-25C6-5618-9CF5-3B3E0005CDC7}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Capture_ILowLagPhotoCapture; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.ILowLagPhotoCapture>
  IAsyncOperation_1__Capture_ILowLagPhotoCapture_Base = interface(IInspectable)
  ['{AF24404B-7E0D-5FFE-BBC8-AAF6FFE208FC}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.ILowLagPhotoCapture>
  IAsyncOperation_1__Capture_ILowLagPhotoCapture = interface(IAsyncOperation_1__Capture_ILowLagPhotoCapture_Base)
  ['{F1DCCB77-692E-52BA-A268-78F2783775D3}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoCapture); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoCapture; safecall;
    function GetResults: Capture_ILowLagPhotoCapture; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoCapture read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IPhotoCapturedEventArgs
  [WinRTClassNameAttribute(SCapture_PhotoCapturedEventArgs)]
  Capture_IPhotoCapturedEventArgs = interface(IInspectable)
  ['{373BFBC1-984E-4FF0-BF85-1C00AABC5A45}']
    function get_Frame: Capture_ICapturedFrame; safecall;
    function get_Thumbnail: Capture_ICapturedFrame; safecall;
    function get_CaptureTimeOffset: TimeSpan; safecall;
    property CaptureTimeOffset: TimeSpan read get_CaptureTimeOffset;
    property Frame: Capture_ICapturedFrame read get_Frame;
    property Thumbnail: Capture_ICapturedFrame read get_Thumbnail;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.ILowLagPhotoSequenceCapture,Windows.Media.Capture.IPhotoCapturedEventArgs>
  TypedEventHandler_2__Capture_ILowLagPhotoSequenceCapture__Capture_IPhotoCapturedEventArgs_Delegate_Base = interface(IUnknown)
  ['{B98AAB3A-FE80-5B27-88C3-E77FF585A96B}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.ILowLagPhotoSequenceCapture,Windows.Media.Capture.IPhotoCapturedEventArgs>
  TypedEventHandler_2__Capture_ILowLagPhotoSequenceCapture__Capture_IPhotoCapturedEventArgs = interface(TypedEventHandler_2__Capture_ILowLagPhotoSequenceCapture__Capture_IPhotoCapturedEventArgs_Delegate_Base)
  ['{A1D14777-8210-53AF-8B23-7CB85AAF01A6}']
    procedure Invoke(sender: Capture_ILowLagPhotoSequenceCapture; args: Capture_IPhotoCapturedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.ILowLagPhotoSequenceCapture
  [WinRTClassNameAttribute(SCapture_LowLagPhotoSequenceCapture)]
  Capture_ILowLagPhotoSequenceCapture = interface(IInspectable)
  ['{7CC346BB-B9A9-4C91-8FFA-287E9C668669}']
    function StartAsync: IAsyncAction; safecall;
    function StopAsync: IAsyncAction; safecall;
    function FinishAsync: IAsyncAction; safecall;
    function add_PhotoCaptured(handler: TypedEventHandler_2__Capture_ILowLagPhotoSequenceCapture__Capture_IPhotoCapturedEventArgs): EventRegistrationToken; safecall;
    procedure remove_PhotoCaptured(token: EventRegistrationToken); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.ILowLagPhotoSequenceCapture>
  AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoSequenceCapture_Delegate_Base = interface(IUnknown)
  ['{767E0FDC-9563-572D-84E1-9CAAB0DEB63F}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.ILowLagPhotoSequenceCapture>
  AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoSequenceCapture = interface(AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoSequenceCapture_Delegate_Base)
  ['{899A0A19-26E2-5DE2-BBA1-A1BB5B997489}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Capture_ILowLagPhotoSequenceCapture; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.ILowLagPhotoSequenceCapture>
  IAsyncOperation_1__Capture_ILowLagPhotoSequenceCapture_Base = interface(IInspectable)
  ['{AC9F0460-9D14-5AF0-B17B-37EA2D76A80D}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.ILowLagPhotoSequenceCapture>
  IAsyncOperation_1__Capture_ILowLagPhotoSequenceCapture = interface(IAsyncOperation_1__Capture_ILowLagPhotoSequenceCapture_Base)
  ['{D2B2E0AB-DC80-5328-A33E-5CE648C3F893}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoSequenceCapture); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoSequenceCapture; safecall;
    function GetResults: Capture_ILowLagPhotoSequenceCapture; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Capture_ILowLagPhotoSequenceCapture read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IMediaCapture2
  Capture_IMediaCapture2 = interface(IInspectable)
  ['{9CC68260-7DA1-4043-B652-21B8878DAFF9}']
    function PrepareLowLagRecordToStorageFileAsync(encodingProfile: IMediaEncodingProfile; &file: IStorageFile): IAsyncOperation_1__Capture_ILowLagMediaRecording; safecall;
    function PrepareLowLagRecordToStreamAsync(encodingProfile: IMediaEncodingProfile; stream: IRandomAccessStream): IAsyncOperation_1__Capture_ILowLagMediaRecording; safecall;
    function PrepareLowLagRecordToCustomSinkAsync(encodingProfile: IMediaEncodingProfile; customMediaSink: IMediaExtension): IAsyncOperation_1__Capture_ILowLagMediaRecording; overload; safecall;
    function PrepareLowLagRecordToCustomSinkAsync(encodingProfile: IMediaEncodingProfile; customSinkActivationId: HSTRING; customSinkSettings: IPropertySet): IAsyncOperation_1__Capture_ILowLagMediaRecording; overload; safecall;
    function PrepareLowLagPhotoCaptureAsync(&type: IImageEncodingProperties): IAsyncOperation_1__Capture_ILowLagPhotoCapture; safecall;
    function PrepareLowLagPhotoSequenceCaptureAsync(&type: IImageEncodingProperties): IAsyncOperation_1__Capture_ILowLagPhotoSequenceCapture; safecall;
    function SetEncodingPropertiesAsync(mediaStreamType: Capture_MediaStreamType; mediaEncodingProperties: IMediaEncodingProperties; encoderProperties: IMap_2__TGuid__IInspectable): IAsyncAction; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.ICapturedFrameControlValues
  [WinRTClassNameAttribute(SCapture_CapturedFrameControlValues)]
  Capture_ICapturedFrameControlValues = interface(IInspectable)
  ['{90C65B7F-4E0D-4CA4-882D-7A144FED0A90}']
    function get_Exposure: IReference_1__TimeSpan; safecall;
    function get_ExposureCompensation: IReference_1__Single; safecall;
    function get_IsoSpeed: IReference_1__Cardinal; safecall;
    function get_Focus: IReference_1__Cardinal; safecall;
    function get_SceneMode: IReference_1__CaptureSceneMode; safecall;
    function get_Flashed: IReference_1__Boolean; safecall;
    function get_FlashPowerPercent: IReference_1__Single; safecall;
    function get_WhiteBalance: IReference_1__Cardinal; safecall;
    function get_ZoomFactor: IReference_1__Single; safecall;
    property Exposure: IReference_1__TimeSpan read get_Exposure;
    property ExposureCompensation: IReference_1__Single read get_ExposureCompensation;
    property FlashPowerPercent: IReference_1__Single read get_FlashPowerPercent;
    property Flashed: IReference_1__Boolean read get_Flashed;
    property Focus: IReference_1__Cardinal read get_Focus;
    property IsoSpeed: IReference_1__Cardinal read get_IsoSpeed;
    property SceneMode: IReference_1__CaptureSceneMode read get_SceneMode;
    property WhiteBalance: IReference_1__Cardinal read get_WhiteBalance;
    property ZoomFactor: IReference_1__Single read get_ZoomFactor;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.Core.IVariablePhotoCapturedEventArgs
  [WinRTClassNameAttribute(SCapture_Core_VariablePhotoCapturedEventArgs)]
  Capture_Core_IVariablePhotoCapturedEventArgs = interface(IInspectable)
  ['{D1EB4C5C-1B53-4E4A-8B5C-DB7887AC949B}']
    function get_Frame: Capture_ICapturedFrame; safecall;
    function get_CaptureTimeOffset: TimeSpan; safecall;
    function get_UsedFrameControllerIndex: IReference_1__Cardinal; safecall;
    function get_CapturedFrameControlValues: Capture_ICapturedFrameControlValues; safecall;
    property CaptureTimeOffset: TimeSpan read get_CaptureTimeOffset;
    property CapturedFrameControlValues: Capture_ICapturedFrameControlValues read get_CapturedFrameControlValues;
    property Frame: Capture_ICapturedFrame read get_Frame;
    property UsedFrameControllerIndex: IReference_1__Cardinal read get_UsedFrameControllerIndex;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.Core.IVariablePhotoSequenceCapture,Windows.Media.Capture.Core.IVariablePhotoCapturedEventArgs>
  TypedEventHandler_2__Capture_Core_IVariablePhotoSequenceCapture__Capture_Core_IVariablePhotoCapturedEventArgs_Delegate_Base = interface(IUnknown)
  ['{BAB30230-3DCD-58E2-AAC5-A45F3E6F8097}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.Core.IVariablePhotoSequenceCapture,Windows.Media.Capture.Core.IVariablePhotoCapturedEventArgs>
  TypedEventHandler_2__Capture_Core_IVariablePhotoSequenceCapture__Capture_Core_IVariablePhotoCapturedEventArgs = interface(TypedEventHandler_2__Capture_Core_IVariablePhotoSequenceCapture__Capture_Core_IVariablePhotoCapturedEventArgs_Delegate_Base)
  ['{818A58C1-18A9-52C1-AA61-244BAB25CC56}']
    procedure Invoke(sender: Capture_Core_IVariablePhotoSequenceCapture; args: Capture_Core_IVariablePhotoCapturedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.Core.IVariablePhotoSequenceCapture,Object>
  TypedEventHandler_2__Capture_Core_IVariablePhotoSequenceCapture__IInspectable_Delegate_Base = interface(IUnknown)
  ['{2210A640-0E7B-5E8F-A617-2CBB10314A5A}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.Core.IVariablePhotoSequenceCapture,Object>
  TypedEventHandler_2__Capture_Core_IVariablePhotoSequenceCapture__IInspectable = interface(TypedEventHandler_2__Capture_Core_IVariablePhotoSequenceCapture__IInspectable_Delegate_Base)
  ['{B09D0C99-44F4-56B6-BD8B-166A0B9B2950}']
    procedure Invoke(sender: Capture_Core_IVariablePhotoSequenceCapture; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.Core.IVariablePhotoSequenceCapture
  [WinRTClassNameAttribute(SCapture_Core_VariablePhotoSequenceCapture)]
  Capture_Core_IVariablePhotoSequenceCapture = interface(IInspectable)
  ['{D0112D1D-031E-4041-A6D6-BD742476A8EE}']
    function StartAsync: IAsyncAction; safecall;
    function StopAsync: IAsyncAction; safecall;
    function FinishAsync: IAsyncAction; safecall;
    function add_PhotoCaptured(handler: TypedEventHandler_2__Capture_Core_IVariablePhotoSequenceCapture__Capture_Core_IVariablePhotoCapturedEventArgs): EventRegistrationToken; safecall;
    procedure remove_PhotoCaptured(token: EventRegistrationToken); safecall;
    function add_Stopped(handler: TypedEventHandler_2__Capture_Core_IVariablePhotoSequenceCapture__IInspectable): EventRegistrationToken; safecall;
    procedure remove_Stopped(token: EventRegistrationToken); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.Core.IVariablePhotoSequenceCapture>
  AsyncOperationCompletedHandler_1__Capture_Core_IVariablePhotoSequenceCapture_Delegate_Base = interface(IUnknown)
  ['{18A55DD3-01E3-5AE5-9B5E-C84AD40CF6B7}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.Core.IVariablePhotoSequenceCapture>
  AsyncOperationCompletedHandler_1__Capture_Core_IVariablePhotoSequenceCapture = interface(AsyncOperationCompletedHandler_1__Capture_Core_IVariablePhotoSequenceCapture_Delegate_Base)
  ['{8D92F345-0FF9-5C67-9B2C-43F2AAED42A6}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Capture_Core_IVariablePhotoSequenceCapture; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.Core.IVariablePhotoSequenceCapture>
  IAsyncOperation_1__Capture_Core_IVariablePhotoSequenceCapture_Base = interface(IInspectable)
  ['{0327C8BC-3148-53F3-8A3D-CDB12E49E132}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.Core.IVariablePhotoSequenceCapture>
  IAsyncOperation_1__Capture_Core_IVariablePhotoSequenceCapture = interface(IAsyncOperation_1__Capture_Core_IVariablePhotoSequenceCapture_Base)
  ['{84E9E62A-CF4C-570F-B529-38FDAA4EF6DE}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Capture_Core_IVariablePhotoSequenceCapture); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Capture_Core_IVariablePhotoSequenceCapture; safecall;
    function GetResults: Capture_Core_IVariablePhotoSequenceCapture; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Capture_Core_IVariablePhotoSequenceCapture read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IMediaCaptureFocusChangedEventArgs
  [WinRTClassNameAttribute(SCapture_MediaCaptureFocusChangedEventArgs)]
  Capture_IMediaCaptureFocusChangedEventArgs = interface(IInspectable)
  ['{81E1BC7F-2277-493E-ABEE-D3F44FF98C04}']
    function get_FocusState: MediaCaptureFocusState; safecall;
    property FocusState: MediaCaptureFocusState read get_FocusState;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.IMediaCapture,Windows.Media.Capture.IMediaCaptureFocusChangedEventArgs>
  TypedEventHandler_2__Capture_IMediaCapture__Capture_IMediaCaptureFocusChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{0561D9E8-0290-5332-B15E-B0D51ABE737C}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.IMediaCapture,Windows.Media.Capture.IMediaCaptureFocusChangedEventArgs>
  TypedEventHandler_2__Capture_IMediaCapture__Capture_IMediaCaptureFocusChangedEventArgs = interface(TypedEventHandler_2__Capture_IMediaCapture__Capture_IMediaCaptureFocusChangedEventArgs_Delegate_Base)
  ['{71CEE5C6-FFFF-5D12-A9F4-AEE02F3A74B6}']
    procedure Invoke(sender: Capture_IMediaCapture; args: Capture_IMediaCaptureFocusChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IPhotoConfirmationCapturedEventArgs
  [WinRTClassNameAttribute(SCapture_PhotoConfirmationCapturedEventArgs)]
  Capture_IPhotoConfirmationCapturedEventArgs = interface(IInspectable)
  ['{AB473672-C28A-4827-8F8D-3636D3BEB51E}']
    function get_Frame: Capture_ICapturedFrame; safecall;
    function get_CaptureTimeOffset: TimeSpan; safecall;
    property CaptureTimeOffset: TimeSpan read get_CaptureTimeOffset;
    property Frame: Capture_ICapturedFrame read get_Frame;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.IMediaCapture,Windows.Media.Capture.IPhotoConfirmationCapturedEventArgs>
  TypedEventHandler_2__Capture_IMediaCapture__Capture_IPhotoConfirmationCapturedEventArgs_Delegate_Base = interface(IUnknown)
  ['{37DC3B13-B096-5F43-8104-F0DC4302E2B5}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.IMediaCapture,Windows.Media.Capture.IPhotoConfirmationCapturedEventArgs>
  TypedEventHandler_2__Capture_IMediaCapture__Capture_IPhotoConfirmationCapturedEventArgs = interface(TypedEventHandler_2__Capture_IMediaCapture__Capture_IPhotoConfirmationCapturedEventArgs_Delegate_Base)
  ['{9DE3D879-0219-5E31-9F3D-DA1D63686BF5}']
    procedure Invoke(sender: Capture_IMediaCapture; args: Capture_IPhotoConfirmationCapturedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IMediaCapture3
  Capture_IMediaCapture3 = interface(IInspectable)
  ['{D4136F30-1564-466E-BC0A-AF94E02AB016}']
    function PrepareVariablePhotoSequenceCaptureAsync(&type: IImageEncodingProperties): IAsyncOperation_1__Capture_Core_IVariablePhotoSequenceCapture; safecall;
    function add_FocusChanged(handler: TypedEventHandler_2__Capture_IMediaCapture__Capture_IMediaCaptureFocusChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_FocusChanged(token: EventRegistrationToken); safecall;
    function add_PhotoConfirmationCaptured(handler: TypedEventHandler_2__Capture_IMediaCapture__Capture_IPhotoConfirmationCapturedEventArgs): EventRegistrationToken; safecall;
    procedure remove_PhotoConfirmationCaptured(token: EventRegistrationToken); safecall;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.IMediaExtension>
  AsyncOperationCompletedHandler_1__IMediaExtension = interface(IUnknown)
  ['{9C1B578E-FB7D-5BAB-BA39-86387FE533B6}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IMediaExtension; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.IMediaExtension>
  IAsyncOperation_1__IMediaExtension = interface(IInspectable)
  ['{F5CB3303-1C1F-5D30-B402-EFA192E80C49}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IMediaExtension); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IMediaExtension; safecall;
    function GetResults: IMediaExtension; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IMediaExtension read get_Completed write put_Completed;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.IMediaCapture,Object>
  TypedEventHandler_2__Capture_IMediaCapture__IInspectable_Delegate_Base = interface(IUnknown)
  ['{44C588F1-1BB7-5E12-8413-3CF0373C0BC8}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.IMediaCapture,Object>
  TypedEventHandler_2__Capture_IMediaCapture__IInspectable = interface(TypedEventHandler_2__Capture_IMediaCapture__IInspectable_Delegate_Base)
  ['{60F3CBEE-49C9-5045-8FD0-8DF644BD36C3}']
    procedure Invoke(sender: Capture_IMediaCapture; args: IInspectable); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.IVideoFrame>
  AsyncOperationCompletedHandler_1__IVideoFrame_Delegate_Base = interface(IUnknown)
  ['{6086F2FB-4A29-54CA-B6A3-F2391A03BC3B}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.IVideoFrame>
  AsyncOperationCompletedHandler_1__IVideoFrame = interface(AsyncOperationCompletedHandler_1__IVideoFrame_Delegate_Base)
  ['{F61D24ED-EDC5-5C0A-AD72-E42B5472F49A}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVideoFrame; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.IVideoFrame>
  IAsyncOperation_1__IVideoFrame_Base = interface(IInspectable)
  ['{F12E515D-AC45-5153-96B2-CE53AB594A57}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.IVideoFrame>
  IAsyncOperation_1__IVideoFrame = interface(IAsyncOperation_1__IVideoFrame_Base)
  ['{9425A3A5-A840-55AC-98B0-5BCC74311B8C}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVideoFrame); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVideoFrame; safecall;
    function GetResults: IVideoFrame; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVideoFrame read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IAdvancedCapturedPhoto
  [WinRTClassNameAttribute(SCapture_AdvancedCapturedPhoto)]
  Capture_IAdvancedCapturedPhoto = interface(IInspectable)
  ['{F072728B-B292-4491-9D41-99807A550BBF}']
    function get_Frame: Capture_ICapturedFrame; safecall;
    function get_Mode: AdvancedPhotoMode; safecall;
    function get_Context: IInspectable; safecall;
    property Context: IInspectable read get_Context;
    property Frame: Capture_ICapturedFrame read get_Frame;
    property Mode: AdvancedPhotoMode read get_Mode;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.IAdvancedCapturedPhoto>
  AsyncOperationCompletedHandler_1__Capture_IAdvancedCapturedPhoto = interface(IUnknown)
  ['{775828B8-66F2-5C90-B123-FDD8D845CA94}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Capture_IAdvancedCapturedPhoto; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.IAdvancedCapturedPhoto>
  IAsyncOperation_1__Capture_IAdvancedCapturedPhoto = interface(IInspectable)
  ['{357EEAE9-781A-52AE-866E-4F864968DEE4}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Capture_IAdvancedCapturedPhoto); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Capture_IAdvancedCapturedPhoto; safecall;
    function GetResults: Capture_IAdvancedCapturedPhoto; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Capture_IAdvancedCapturedPhoto read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IOptionalReferencePhotoCapturedEventArgs
  [WinRTClassNameAttribute(SCapture_OptionalReferencePhotoCapturedEventArgs)]
  Capture_IOptionalReferencePhotoCapturedEventArgs = interface(IInspectable)
  ['{470F88B3-1E6D-4051-9C8B-F1D85AF047B7}']
    function get_Frame: Capture_ICapturedFrame; safecall;
    function get_Context: IInspectable; safecall;
    property Context: IInspectable read get_Context;
    property Frame: Capture_ICapturedFrame read get_Frame;
  end;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.IAdvancedPhotoCapture,Windows.Media.Capture.IOptionalReferencePhotoCapturedEventArgs>
  TypedEventHandler_2__Capture_IAdvancedPhotoCapture__Capture_IOptionalReferencePhotoCapturedEventArgs = interface(IUnknown)
  ['{508EE272-5577-54A4-9637-32F71737C85B}']
    procedure Invoke(sender: Capture_IAdvancedPhotoCapture; args: Capture_IOptionalReferencePhotoCapturedEventArgs); safecall;
  end;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Capture.IAdvancedPhotoCapture,Object>
  TypedEventHandler_2__Capture_IAdvancedPhotoCapture__IInspectable = interface(IUnknown)
  ['{FCFAABE9-43D4-5DED-AB4B-C88DE63997B1}']
    procedure Invoke(sender: Capture_IAdvancedPhotoCapture; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IAdvancedPhotoCapture
  [WinRTClassNameAttribute(SCapture_AdvancedPhotoCapture)]
  Capture_IAdvancedPhotoCapture = interface(IInspectable)
  ['{83FFAAFA-6667-44DC-973C-A6BCE596AA0F}']
    function CaptureAsync: IAsyncOperation_1__Capture_IAdvancedCapturedPhoto; overload; safecall;
    function CaptureAsync(context: IInspectable): IAsyncOperation_1__Capture_IAdvancedCapturedPhoto; overload; safecall;
    function add_OptionalReferencePhotoCaptured(handler: TypedEventHandler_2__Capture_IAdvancedPhotoCapture__Capture_IOptionalReferencePhotoCapturedEventArgs): EventRegistrationToken; safecall;
    procedure remove_OptionalReferencePhotoCaptured(token: EventRegistrationToken); safecall;
    function add_AllPhotosCaptured(handler: TypedEventHandler_2__Capture_IAdvancedPhotoCapture__IInspectable): EventRegistrationToken; safecall;
    procedure remove_AllPhotosCaptured(token: EventRegistrationToken); safecall;
    function FinishAsync: IAsyncAction; safecall;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Capture.IAdvancedPhotoCapture>
  AsyncOperationCompletedHandler_1__Capture_IAdvancedPhotoCapture = interface(IUnknown)
  ['{F271BDDB-6CED-51B3-9426-913F2FB80912}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Capture_IAdvancedPhotoCapture; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Capture.IAdvancedPhotoCapture>
  IAsyncOperation_1__Capture_IAdvancedPhotoCapture = interface(IInspectable)
  ['{530C0B1C-200C-5649-A9FB-16D4E6C39199}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Capture_IAdvancedPhotoCapture); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Capture_IAdvancedPhotoCapture; safecall;
    function GetResults: Capture_IAdvancedPhotoCapture; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Capture_IAdvancedPhotoCapture read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IMediaCapture4
  Capture_IMediaCapture4 = interface(IInspectable)
  ['{BACD6FD6-FB08-4947-AEA2-CE14EFF0CE13}']
    function AddAudioEffectAsync(definition: Effects_IAudioEffectDefinition): IAsyncOperation_1__IMediaExtension; safecall;
    function AddVideoEffectAsync(definition: Effects_IVideoEffectDefinition; mediaStreamType: Capture_MediaStreamType): IAsyncOperation_1__IMediaExtension; safecall;
    function PauseRecordAsync(behavior: MediaCapturePauseBehavior): IAsyncAction; safecall;
    function ResumeRecordAsync: IAsyncAction; safecall;
    function add_CameraStreamStateChanged(handler: TypedEventHandler_2__Capture_IMediaCapture__IInspectable): EventRegistrationToken; safecall;
    procedure remove_CameraStreamStateChanged(token: EventRegistrationToken); safecall;
    function get_CameraStreamState: CameraStreamState; safecall;
    function GetPreviewFrameAsync: IAsyncOperation_1__IVideoFrame; overload; safecall;
    function GetPreviewFrameAsync(destination: IVideoFrame): IAsyncOperation_1__IVideoFrame; overload; safecall;
    function add_ThermalStatusChanged(handler: TypedEventHandler_2__Capture_IMediaCapture__IInspectable): EventRegistrationToken; safecall;
    procedure remove_ThermalStatusChanged(token: EventRegistrationToken); safecall;
    function get_ThermalStatus: Capture_MediaCaptureThermalStatus; safecall;
    function PrepareAdvancedPhotoCaptureAsync(encodingProperties: IImageEncodingProperties): IAsyncOperation_1__Capture_IAdvancedPhotoCapture; safecall;
    property CameraStreamState: CameraStreamState read get_CameraStreamState;
    property ThermalStatus: Capture_MediaCaptureThermalStatus read get_ThermalStatus;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.ILowLagMediaRecording2
  Capture_ILowLagMediaRecording2 = interface(IInspectable)
  ['{6369C758-5644-41E2-97AF-8EF56A25E225}']
    function PauseAsync(behavior: MediaCapturePauseBehavior): IAsyncAction; safecall;
    function ResumeAsync: IAsyncAction; safecall;
  end;

  // Windows.Foundation.IReference`1<Windows.Media.Capture.WhiteBalanceGain>
  IReference_1__Capture_WhiteBalanceGain = interface(IInspectable)
  ['{455ACF7B-8F11-5BB9-93BE-7A214CD5A134}']
    function get_Value: Capture_WhiteBalanceGain; safecall;
    property Value: Capture_WhiteBalanceGain read get_Value;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.ICapturedFrameControlValues2
  Capture_ICapturedFrameControlValues2 = interface(IInspectable)
  ['{500B2B88-06D2-4AA7-A7DB-D37AF73321D8}']
    function get_FocusState: IReference_1__MediaCaptureFocusState; safecall;
    function get_IsoDigitalGain: IReference_1__Double; safecall;
    function get_IsoAnalogGain: IReference_1__Double; safecall;
    function get_SensorFrameRate: IMediaRatio; safecall;
    function get_WhiteBalanceGain: IReference_1__Capture_WhiteBalanceGain; safecall;
    property FocusState: IReference_1__MediaCaptureFocusState read get_FocusState;
    property IsoAnalogGain: IReference_1__Double read get_IsoAnalogGain;
    property IsoDigitalGain: IReference_1__Double read get_IsoDigitalGain;
    property SensorFrameRate: IMediaRatio read get_SensorFrameRate;
    property WhiteBalanceGain: IReference_1__Capture_WhiteBalanceGain read get_WhiteBalanceGain;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.ICapturedFrameWithSoftwareBitmap
  Capture_ICapturedFrameWithSoftwareBitmap = interface(IInspectable)
  ['{B58E8B6E-8503-49B5-9E86-897D26A3FF3D}']
    function get_SoftwareBitmap: Imaging_ISoftwareBitmap; safecall;
    property SoftwareBitmap: Imaging_ISoftwareBitmap read get_SoftwareBitmap;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IMediaCaptureVideoPreview
  Capture_IMediaCaptureVideoPreview = interface(IInspectable)
  ['{27727073-549E-447F-A20A-4F03C479D8C0}']
    function StartPreviewAsync: IAsyncAction; safecall;
    function StartPreviewToCustomSinkAsync(encodingProfile: IMediaEncodingProfile; customMediaSink: IMediaExtension): IAsyncAction; overload; safecall;
    function StartPreviewToCustomSinkAsync(encodingProfile: IMediaEncodingProfile; customSinkActivationId: HSTRING; customSinkSettings: IPropertySet): IAsyncAction; overload; safecall;
    function StopPreviewAsync: IAsyncAction; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IMediaCaptureSettings2
  Capture_IMediaCaptureSettings2 = interface(IInspectable)
  ['{6F9E7CFB-FA9F-4B13-9CBE-5AB94F1F3493}']
    function get_ConcurrentRecordAndPhotoSupported: Boolean; safecall;
    function get_ConcurrentRecordAndPhotoSequenceSupported: Boolean; safecall;
    function get_CameraSoundRequiredForRegion: Boolean; safecall;
    function get_Horizontal35mmEquivalentFocalLength: IReference_1__Cardinal; safecall;
    function get_PitchOffsetDegrees: IReference_1__Integer; safecall;
    function get_Vertical35mmEquivalentFocalLength: IReference_1__Cardinal; safecall;
    function get_MediaCategory: Capture_MediaCategory; safecall;
    function get_AudioProcessing: AudioProcessing; safecall;
    property AudioProcessing: AudioProcessing read get_AudioProcessing;
    property CameraSoundRequiredForRegion: Boolean read get_CameraSoundRequiredForRegion;
    property ConcurrentRecordAndPhotoSequenceSupported: Boolean read get_ConcurrentRecordAndPhotoSequenceSupported;
    property ConcurrentRecordAndPhotoSupported: Boolean read get_ConcurrentRecordAndPhotoSupported;
    property Horizontal35mmEquivalentFocalLength: IReference_1__Cardinal read get_Horizontal35mmEquivalentFocalLength;
    property MediaCategory: Capture_MediaCategory read get_MediaCategory;
    property PitchOffsetDegrees: IReference_1__Integer read get_PitchOffsetDegrees;
    property Vertical35mmEquivalentFocalLength: IReference_1__Cardinal read get_Vertical35mmEquivalentFocalLength;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.IVideoStreamConfiguration
  [WinRTClassNameAttribute(SCapture_VideoStreamConfiguration)]
  Capture_IVideoStreamConfiguration = interface(IInspectable)
  ['{D8770A6F-4390-4B5E-AD3E-0F8AF0963490}']
    function get_InputProperties: IVideoEncodingProperties; safecall;
    function get_OutputProperties: IVideoEncodingProperties; safecall;
    property InputProperties: IVideoEncodingProperties read get_InputProperties;
    property OutputProperties: IVideoEncodingProperties read get_OutputProperties;
  end;

  // DualAPI Interface
  // Windows.Media.Capture.Core.IVariablePhotoSequenceCapture2
  Capture_Core_IVariablePhotoSequenceCapture2 = interface(IInspectable)
  ['{FE2C62BC-50B0-43E3-917C-E3B92798942F}']
    function UpdateSettingsAsync: IAsyncAction; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.IVideoEffectsStatics
  [WinRTClassNameAttribute(SVideoEffects)]
  IVideoEffectsStatics = interface(IInspectable)
  ['{1FCDA5E8-BAF1-4521-980C-3BCEBB44CF38}']
    function get_VideoStabilization: HSTRING; safecall;
    property VideoStabilization: HSTRING read get_VideoStabilization;
  end;

  // DualAPI Interface
  // Windows.Media.Effects.IVideoEffectDefinitionFactory
  [WinRTClassNameAttribute(SEffects_VideoEffectDefinition)]
  Effects_IVideoEffectDefinitionFactory = interface(IInspectable)
  ['{81439B4E-6E33-428F-9D21-B5AAFEF7617C}']
    function Create(activatableClassId: HSTRING): Effects_IVideoEffectDefinition; safecall;
    function CreateWithProperties(activatableClassId: HSTRING; props: IPropertySet): Effects_IVideoEffectDefinition; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Effects.IAudioEffectDefinitionFactory
  [WinRTClassNameAttribute(SEffects_AudioEffectDefinition)]
  Effects_IAudioEffectDefinitionFactory = interface(IInspectable)
  ['{8E1DA646-E705-45ED-8A2B-FC4E4F405A97}']
    function Create(activatableClassId: HSTRING): Effects_IAudioEffectDefinition; safecall;
    function CreateWithProperties(activatableClassId: HSTRING; props: IPropertySet): Effects_IAudioEffectDefinition; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Effects.IProcessVideoFrameContext
  [WinRTClassNameAttribute(SEffects_ProcessVideoFrameContext)]
  Effects_IProcessVideoFrameContext = interface(IInspectable)
  ['{276F0E2B-6461-401E-BA78-0FDAD6114EEC}']
    function get_InputFrame: IVideoFrame; safecall;
    function get_OutputFrame: IVideoFrame; safecall;
    property InputFrame: IVideoFrame read get_InputFrame;
    property OutputFrame: IVideoFrame read get_OutputFrame;
  end;

  // Windows.Media.Effects.IBasicVideoEffect
  Effects_IBasicVideoEffect = interface(IInspectable)
  ['{8262C7EF-B360-40BE-949B-2FF42FF35693}']
    function get_IsReadOnly: Boolean; safecall;
    function get_SupportedMemoryTypes: Effects_MediaMemoryTypes; safecall;
    function get_TimeIndependent: Boolean; safecall;
    function get_SupportedEncodingProperties: IVectorView_1__IVideoEncodingProperties; safecall;
    procedure SetEncodingProperties(encodingProperties: IVideoEncodingProperties; device: DirectX_Direct3D11_IDirect3DDevice); safecall;
    procedure ProcessFrame(context: Effects_IProcessVideoFrameContext); safecall;
    procedure Close(reason: Effects_MediaEffectClosedReason); safecall;
    procedure DiscardQueuedFrames; safecall;
    property IsReadOnly: Boolean read get_IsReadOnly;
    property SupportedEncodingProperties: IVectorView_1__IVideoEncodingProperties read get_SupportedEncodingProperties;
    property SupportedMemoryTypes: Effects_MediaMemoryTypes read get_SupportedMemoryTypes;
    property TimeIndependent: Boolean read get_TimeIndependent;
  end;

  // DualAPI Interface
  // Windows.Media.Effects.IProcessAudioFrameContext
  [WinRTClassNameAttribute(SEffects_ProcessAudioFrameContext)]
  Effects_IProcessAudioFrameContext = interface(IInspectable)
  ['{4CD92946-1222-4A27-A586-FB3E20273255}']
    function get_InputFrame: IAudioFrame; safecall;
    function get_OutputFrame: IAudioFrame; safecall;
    property InputFrame: IAudioFrame read get_InputFrame;
    property OutputFrame: IAudioFrame read get_OutputFrame;
  end;

  // Windows.Media.Effects.IBasicAudioEffect
  Effects_IBasicAudioEffect = interface(IInspectable)
  ['{8C062C53-6BC0-48B8-A99A-4B41550F1359}']
    function get_UseInputFrameForOutput: Boolean; safecall;
    function get_SupportedEncodingProperties: IVectorView_1__IAudioEncodingProperties; safecall;
    procedure SetEncodingProperties(encodingProperties: IAudioEncodingProperties); safecall;
    procedure ProcessFrame(context: Effects_IProcessAudioFrameContext); safecall;
    procedure Close(reason: Effects_MediaEffectClosedReason); safecall;
    procedure DiscardQueuedFrames; safecall;
    property SupportedEncodingProperties: IVectorView_1__IAudioEncodingProperties read get_SupportedEncodingProperties;
    property UseInputFrameForOutput: Boolean read get_UseInputFrameForOutput;
  end;

  // DualAPI Interface
  // Windows.Media.Effects.IVideoTransformEffectDefinition
  [WinRTClassNameAttribute(SEffects_VideoTransformEffectDefinition)]
  Effects_IVideoTransformEffectDefinition = interface(IInspectable)
  ['{9664BB6A-1EA6-4AA6-8074-ABE8851ECAE2}']
    function get_PaddingColor: Color; safecall;
    procedure put_PaddingColor(value: Color); safecall;
    function get_OutputSize: TSizeF; safecall;
    procedure put_OutputSize(value: TSizeF); safecall;
    function get_CropRectangle: TRectF; safecall;
    procedure put_CropRectangle(value: TRectF); safecall;
    function get_Rotation: MediaRotation; safecall;
    procedure put_Rotation(value: MediaRotation); safecall;
    function get_Mirror: MediaMirroringOptions; safecall;
    procedure put_Mirror(value: MediaMirroringOptions); safecall;
    procedure put_ProcessingAlgorithm(value: Transcoding_MediaVideoProcessingAlgorithm); safecall;
    function get_ProcessingAlgorithm: Transcoding_MediaVideoProcessingAlgorithm; safecall;
    property CropRectangle: TRectF read get_CropRectangle write put_CropRectangle;
    property Mirror: MediaMirroringOptions read get_Mirror write put_Mirror;
    property OutputSize: TSizeF read get_OutputSize write put_OutputSize;
    property PaddingColor: Color read get_PaddingColor write put_PaddingColor;
    property ProcessingAlgorithm: Transcoding_MediaVideoProcessingAlgorithm read get_ProcessingAlgorithm write put_ProcessingAlgorithm;
    property Rotation: MediaRotation read get_Rotation write put_Rotation;
  end;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Playback.IMediaPlaybackItem,Windows.Foundation.Collections.IVectorChangedEventArgs>
  TypedEventHandler_2__Playback_IMediaPlaybackItem__IVectorChangedEventArgs = interface(IUnknown)
  ['{782906DD-5011-5A36-9331-14044DF71A56}']
    procedure Invoke(sender: Playback_IMediaPlaybackItem; args: IVectorChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaSourceError
  [WinRTClassNameAttribute(SCore_MediaSourceError)]
  Core_IMediaSourceError = interface(IInspectable)
  ['{5C0A8965-37C5-4E9D-8D21-1CDEE90CECC6}']
    function get_ExtendedError: HRESULT; safecall;
    property ExtendedError: HRESULT read get_ExtendedError;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaSourceOpenOperationCompletedEventArgs
  [WinRTClassNameAttribute(SCore_MediaSourceOpenOperationCompletedEventArgs)]
  Core_IMediaSourceOpenOperationCompletedEventArgs = interface(IInspectable)
  ['{FC682CEB-E281-477C-A8E0-1ACD654114C8}']
    function get_Error: Core_IMediaSourceError; safecall;
    property Error: Core_IMediaSourceError read get_Error;
  end;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMediaSource2,Windows.Media.Core.IMediaSourceOpenOperationCompletedEventArgs>
  TypedEventHandler_2__Core_IMediaSource2__Core_IMediaSourceOpenOperationCompletedEventArgs = interface(IUnknown)
  ['{2292B367-0CE9-58B0-978A-9149FFB031FB}']
    procedure Invoke(sender: Core_IMediaSource2; args: Core_IMediaSourceOpenOperationCompletedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ITimedMetadataTrackError
  [WinRTClassNameAttribute(SCore_TimedMetadataTrackError)]
  Core_ITimedMetadataTrackError = interface(IInspectable)
  ['{B3767915-4114-4819-B9D9-DD76089E72F8}']
    function get_ErrorCode: Core_TimedMetadataTrackErrorCode; safecall;
    function get_ExtendedError: HRESULT; safecall;
    property ErrorCode: Core_TimedMetadataTrackErrorCode read get_ErrorCode;
    property ExtendedError: HRESULT read get_ExtendedError;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaTrack
  [WinRTClassNameAttribute(SCore_AudioTrack)]
  Core_IMediaTrack = interface(IInspectable)
  ['{03E1FAFC-C931-491A-B46B-C10EE8C256B7}']
    function get_Id: HSTRING; safecall;
    function get_Language: HSTRING; safecall;
    function get_TrackKind: Core_MediaTrackKind; safecall;
    procedure put_Label(value: HSTRING); safecall;
    function get_Label: HSTRING; safecall;
    property Id: HSTRING read get_Id;
    property &Label: HSTRING read get_Label write put_Label;
    property Language: HSTRING read get_Language;
    property TrackKind: Core_MediaTrackKind read get_TrackKind;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaCue
  Core_IMediaCue = interface(IInspectable)
  ['{C7D15E5D-59DC-431F-A0EE-27744323B36D}']
    procedure put_StartTime(value: TimeSpan); safecall;
    function get_StartTime: TimeSpan; safecall;
    procedure put_Duration(value: TimeSpan); safecall;
    function get_Duration: TimeSpan; safecall;
    procedure put_Id(value: HSTRING); safecall;
    function get_Id: HSTRING; safecall;
    property Duration: TimeSpan read get_Duration write put_Duration;
    property Id: HSTRING read get_Id write put_Id;
    property StartTime: TimeSpan read get_StartTime write put_StartTime;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaCueEventArgs
  [WinRTClassNameAttribute(SCore_MediaCueEventArgs)]
  Core_IMediaCueEventArgs = interface(IInspectable)
  ['{D12F47F7-5FA4-4E68-9FE5-32160DCEE57E}']
    function get_Cue: Core_IMediaCue; safecall;
    property Cue: Core_IMediaCue read get_Cue;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.ITimedMetadataTrack,Windows.Media.Core.IMediaCueEventArgs>
  TypedEventHandler_2__Core_ITimedMetadataTrack__Core_IMediaCueEventArgs_Delegate_Base = interface(IUnknown)
  ['{4AAC9411-C355-5C95-8C78-5A0F5CA1A54D}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.ITimedMetadataTrack,Windows.Media.Core.IMediaCueEventArgs>
  TypedEventHandler_2__Core_ITimedMetadataTrack__Core_IMediaCueEventArgs = interface(TypedEventHandler_2__Core_ITimedMetadataTrack__Core_IMediaCueEventArgs_Delegate_Base)
  ['{8994D194-4D58-5DD5-87F6-12576E1F75B5}']
    procedure Invoke(sender: Core_ITimedMetadataTrack; args: Core_IMediaCueEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ITimedMetadataTrackFailedEventArgs
  [WinRTClassNameAttribute(SCore_TimedMetadataTrackFailedEventArgs)]
  Core_ITimedMetadataTrackFailedEventArgs = interface(IInspectable)
  ['{A57FC9D1-6789-4D4D-B07F-84B4F31ACB70}']
    function get_Error: Core_ITimedMetadataTrackError; safecall;
    property Error: Core_ITimedMetadataTrackError read get_Error;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.ITimedMetadataTrack,Windows.Media.Core.ITimedMetadataTrackFailedEventArgs>
  TypedEventHandler_2__Core_ITimedMetadataTrack__Core_ITimedMetadataTrackFailedEventArgs_Delegate_Base = interface(IUnknown)
  ['{8DC73162-255B-532E-B0C7-9A6D70B4BB9E}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.ITimedMetadataTrack,Windows.Media.Core.ITimedMetadataTrackFailedEventArgs>
  TypedEventHandler_2__Core_ITimedMetadataTrack__Core_ITimedMetadataTrackFailedEventArgs = interface(TypedEventHandler_2__Core_ITimedMetadataTrack__Core_ITimedMetadataTrackFailedEventArgs_Delegate_Base)
  ['{93A88A48-6D62-56F5-AB42-286248198B55}']
    procedure Invoke(sender: Core_ITimedMetadataTrack; args: Core_ITimedMetadataTrackFailedEventArgs); safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.IMediaCue>
  IIterator_1__Core_IMediaCue = interface(IInspectable)
  ['{1A594DC8-A64B-55ED-9B34-7B274E1D5C70}']
    function get_Current: Core_IMediaCue; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PCore_IMediaCue): Cardinal; safecall;
    property Current: Core_IMediaCue read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.IMediaCue>
  IIterable_1__Core_IMediaCue = interface(IInspectable)
  ['{737A2098-41BF-5D9F-A1D2-2F171C578B3C}']
    function First: IIterator_1__Core_IMediaCue; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.IMediaCue>
  IVectorView_1__Core_IMediaCue = interface(IInspectable)
  ['{996421A1-625C-5D92-AD68-8B3911D294B0}']
    function GetAt(index: Cardinal): Core_IMediaCue; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Core_IMediaCue; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_IMediaCue): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ITimedMetadataTrack
  [WinRTClassNameAttribute(SCore_TimedMetadataTrack)]
  Core_ITimedMetadataTrack = interface(IInspectable)
  ['{9E6AED9E-F67A-49A9-B330-CF03B0E9CF07}']
    function add_CueEntered(handler: TypedEventHandler_2__Core_ITimedMetadataTrack__Core_IMediaCueEventArgs): EventRegistrationToken; safecall;
    procedure remove_CueEntered(token: EventRegistrationToken); safecall;
    function add_CueExited(handler: TypedEventHandler_2__Core_ITimedMetadataTrack__Core_IMediaCueEventArgs): EventRegistrationToken; safecall;
    procedure remove_CueExited(token: EventRegistrationToken); safecall;
    function add_TrackFailed(handler: TypedEventHandler_2__Core_ITimedMetadataTrack__Core_ITimedMetadataTrackFailedEventArgs): EventRegistrationToken; safecall;
    procedure remove_TrackFailed(token: EventRegistrationToken); safecall;
    function get_Cues: IVectorView_1__Core_IMediaCue; safecall;
    function get_ActiveCues: IVectorView_1__Core_IMediaCue; safecall;
    function get_TimedMetadataKind: Core_TimedMetadataKind; safecall;
    function get_DispatchType: HSTRING; safecall;
    procedure AddCue(cue: Core_IMediaCue); safecall;
    procedure RemoveCue(cue: Core_IMediaCue); safecall;
    property ActiveCues: IVectorView_1__Core_IMediaCue read get_ActiveCues;
    property Cues: IVectorView_1__Core_IMediaCue read get_Cues;
    property DispatchType: HSTRING read get_DispatchType;
    property TimedMetadataKind: Core_TimedMetadataKind read get_TimedMetadataKind;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.ITimedMetadataTrack>
  IIterator_1__Core_ITimedMetadataTrack = interface(IInspectable)
  ['{5C2DCA1F-749F-5EFD-BFAA-159A4EAC747D}']
    function get_Current: Core_ITimedMetadataTrack; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PCore_ITimedMetadataTrack): Cardinal; safecall;
    property Current: Core_ITimedMetadataTrack read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.ITimedMetadataTrack>
  IIterable_1__Core_ITimedMetadataTrack_Base = interface(IInspectable)
  ['{150A4454-03BB-5DD1-8153-6A600E851F71}']
  end;
  // DualAPI Interface
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.ITimedMetadataTrack>
  IIterable_1__Core_ITimedMetadataTrack = interface(IIterable_1__Core_ITimedMetadataTrack_Base)
  ['{2B6AF8CA-3ADF-5703-8D95-B712D018DB94}']
    function First: IIterator_1__Core_ITimedMetadataTrack; safecall;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.ITimedMetadataTrack>
  IVectorView_1__Core_ITimedMetadataTrack = interface(IInspectable)
  ['{DD588DAC-C2FE-523F-B519-6DDEAA5281A9}']
    function GetAt(index: Cardinal): Core_ITimedMetadataTrack; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Core_ITimedMetadataTrack; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_ITimedMetadataTrack): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ITimedTextSourceResolveResultEventArgs
  [WinRTClassNameAttribute(SCore_TimedTextSourceResolveResultEventArgs)]
  Core_ITimedTextSourceResolveResultEventArgs = interface(IInspectable)
  ['{48907C9C-DCD8-4C33-9AD3-6CDCE7B1C566}']
    function get_Error: Core_ITimedMetadataTrackError; safecall;
    function get_Tracks: IVectorView_1__Core_ITimedMetadataTrack; safecall;
    property Error: Core_ITimedMetadataTrackError read get_Error;
    property Tracks: IVectorView_1__Core_ITimedMetadataTrack read get_Tracks;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.ITimedTextSource,Windows.Media.Core.ITimedTextSourceResolveResultEventArgs>
  TypedEventHandler_2__Core_ITimedTextSource__Core_ITimedTextSourceResolveResultEventArgs_Delegate_Base = interface(IUnknown)
  ['{0220562A-5DE4-5AD2-AC20-6CD26F111745}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.ITimedTextSource,Windows.Media.Core.ITimedTextSourceResolveResultEventArgs>
  TypedEventHandler_2__Core_ITimedTextSource__Core_ITimedTextSourceResolveResultEventArgs = interface(TypedEventHandler_2__Core_ITimedTextSource__Core_ITimedTextSourceResolveResultEventArgs_Delegate_Base)
  ['{38560393-CB87-5DD9-A3BE-300ECC2F9C0D}']
    procedure Invoke(sender: Core_ITimedTextSource; args: Core_ITimedTextSourceResolveResultEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ITimedTextSource
  [WinRTClassNameAttribute(SCore_TimedTextSource)]
  Core_ITimedTextSource = interface(IInspectable)
  ['{C4ED9BA6-101F-404D-A949-82F33FCD93B7}']
    function add_Resolved(handler: TypedEventHandler_2__Core_ITimedTextSource__Core_ITimedTextSourceResolveResultEventArgs): EventRegistrationToken; safecall;
    procedure remove_Resolved(token: EventRegistrationToken); safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.ITimedTextSource>
  IIterator_1__Core_ITimedTextSource = interface(IInspectable)
  ['{7B26AAC5-FA64-5F77-B899-673454375B42}']
    function get_Current: Core_ITimedTextSource; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PCore_ITimedTextSource): Cardinal; safecall;
    property Current: Core_ITimedTextSource read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.ITimedTextSource>
  IIterable_1__Core_ITimedTextSource_Base = interface(IInspectable)
  ['{4FC57282-0EDF-5D85-9D89-DDC2A5692C13}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.ITimedTextSource>
  IIterable_1__Core_ITimedTextSource = interface(IIterable_1__Core_ITimedTextSource_Base)
  ['{DE79E1C9-A094-57A6-95EE-91F58F4EEC5E}']
    function First: IIterator_1__Core_ITimedTextSource; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.ITimedTextSource>
  IVectorView_1__Core_ITimedTextSource = interface(IInspectable)
  ['{BA85D72E-0B17-521D-A537-4D3333084540}']
    function GetAt(index: Cardinal): Core_ITimedTextSource; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Core_ITimedTextSource; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_ITimedTextSource): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Core.ITimedTextSource>
  IVector_1__Core_ITimedTextSource = interface(IInspectable)
  ['{E0695D2A-E7B6-54B1-8564-ACA965A35E12}']
    function GetAt(index: Cardinal): Core_ITimedTextSource; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Core_ITimedTextSource; safecall;
    function IndexOf(value: Core_ITimedTextSource; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Core_ITimedTextSource); safecall;
    procedure InsertAt(index: Cardinal; value: Core_ITimedTextSource); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Core_ITimedTextSource); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_ITimedTextSource): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PCore_ITimedTextSource); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.Media.Core.ITimedTextSource>
  VectorChangedEventHandler_1__Core_ITimedTextSource_Delegate_Base = interface(IUnknown)
  ['{E12E6261-B198-56E0-9822-BA2D3BB6F8FE}']
  end;
  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.Media.Core.ITimedTextSource>
  VectorChangedEventHandler_1__Core_ITimedTextSource = interface(VectorChangedEventHandler_1__Core_ITimedTextSource_Delegate_Base)
  ['{3B4D630C-11EC-51AD-8B8C-CD2979D73A87}']
    procedure Invoke(sender: IObservableVector_1__Core_ITimedTextSource; event: IVectorChangedEventArgs); safecall;
  end;

  // Windows.Foundation.Collections.IObservableVector`1<Windows.Media.Core.ITimedTextSource>
  IObservableVector_1__Core_ITimedTextSource = interface(IInspectable)
  ['{0C98C465-6D21-5D0F-9682-7337B29F0B91}']
    function add_VectorChanged(vhnd: VectorChangedEventHandler_1__Core_ITimedTextSource): EventRegistrationToken; safecall;
    procedure remove_VectorChanged(token: EventRegistrationToken); safecall;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Core.ITimedMetadataTrack>
  IVector_1__Core_ITimedMetadataTrack = interface(IInspectable)
  ['{23E79F93-8448-589C-BB48-9AD242933EB9}']
    function GetAt(index: Cardinal): Core_ITimedMetadataTrack; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Core_ITimedMetadataTrack; safecall;
    function IndexOf(value: Core_ITimedMetadataTrack; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Core_ITimedMetadataTrack); safecall;
    procedure InsertAt(index: Cardinal; value: Core_ITimedMetadataTrack); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Core_ITimedMetadataTrack); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_ITimedMetadataTrack): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PCore_ITimedMetadataTrack); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.Media.Core.ITimedMetadataTrack>
  VectorChangedEventHandler_1__Core_ITimedMetadataTrack_Delegate_Base = interface(IUnknown)
  ['{BD1DC81C-23C4-5B4B-AC38-C5D34CDF34E4}']
  end;
  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.Media.Core.ITimedMetadataTrack>
  VectorChangedEventHandler_1__Core_ITimedMetadataTrack = interface(VectorChangedEventHandler_1__Core_ITimedMetadataTrack_Delegate_Base)
  ['{A2A777D5-776B-5806-A334-2193F4ECF158}']
    procedure Invoke(sender: IObservableVector_1__Core_ITimedMetadataTrack; event: IVectorChangedEventArgs); safecall;
  end;

  // Windows.Foundation.Collections.IObservableVector`1<Windows.Media.Core.ITimedMetadataTrack>
  IObservableVector_1__Core_ITimedMetadataTrack = interface(IInspectable)
  ['{19EAC50E-BEBF-58B6-B8B7-DB6B157EEAEC}']
    function add_VectorChanged(vhnd: VectorChangedEventHandler_1__Core_ITimedMetadataTrack): EventRegistrationToken; safecall;
    procedure remove_VectorChanged(token: EventRegistrationToken); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaSource2
  Core_IMediaSource2 = interface(IInspectable)
  ['{2EB61048-655F-4C37-B813-B4E45DFA0ABE}']
    function add_OpenOperationCompleted(handler: TypedEventHandler_2__Core_IMediaSource2__Core_IMediaSourceOpenOperationCompletedEventArgs): EventRegistrationToken; safecall;
    procedure remove_OpenOperationCompleted(token: EventRegistrationToken); safecall;
    function get_CustomProperties: IPropertySet; safecall;
    function get_Duration: IReference_1__TimeSpan; safecall;
    function get_IsOpen: Boolean; safecall;
    function get_ExternalTimedTextSources: IObservableVector_1__Core_ITimedTextSource; safecall;
    function get_ExternalTimedMetadataTracks: IObservableVector_1__Core_ITimedMetadataTrack; safecall;
    property CustomProperties: IPropertySet read get_CustomProperties;
    property Duration: IReference_1__TimeSpan read get_Duration;
    property ExternalTimedMetadataTracks: IObservableVector_1__Core_ITimedMetadataTrack read get_ExternalTimedMetadataTracks;
    property ExternalTimedTextSources: IObservableVector_1__Core_ITimedTextSource read get_ExternalTimedTextSources;
    property IsOpen: Boolean read get_IsOpen;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.IMediaTrack>
  IIterator_1__Core_IMediaTrack = interface(IInspectable)
  ['{1080BE0A-E89C-5E8D-8535-AEAD52CADA8D}']
    function get_Current: Core_IMediaTrack; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PCore_IMediaTrack): Cardinal; safecall;
    property Current: Core_IMediaTrack read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.IMediaTrack>
  IIterable_1__Core_IMediaTrack_Base = interface(IInspectable)
  ['{84413442-A2E3-5E0F-936D-BC40B0FB2DCD}']
  end;
  // DualAPI Interface
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.IMediaTrack>
  IIterable_1__Core_IMediaTrack = interface(IIterable_1__Core_IMediaTrack_Base)
  ['{4B7F70F1-451D-58CD-A2F7-F80429A9A1EB}']
    function First: IIterator_1__Core_IMediaTrack; safecall;
  end;

  // DualAPI Interface
  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.IMediaTrack>
  [WinRTClassNameAttribute(SPlayback_MediaPlaybackVideoTrackList)]
  IVectorView_1__Core_IMediaTrack = interface(IInspectable)
  ['{1CE05BEC-9E9B-5108-9D24-80E1C8C2866E}']
    function GetAt(index: Cardinal): Core_IMediaTrack; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Core_IMediaTrack; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_IMediaTrack): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Playback.IMediaPlaybackItem
  [WinRTClassNameAttribute(SPlayback_MediaPlaybackItem)]
  Playback_IMediaPlaybackItem = interface(IInspectable)
  ['{047097D2-E4AF-48AB-B283-6929E674ECE2}']
    function add_AudioTracksChanged(handler: TypedEventHandler_2__Playback_IMediaPlaybackItem__IVectorChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_AudioTracksChanged(token: EventRegistrationToken); safecall;
    function add_VideoTracksChanged(handler: TypedEventHandler_2__Playback_IMediaPlaybackItem__IVectorChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_VideoTracksChanged(token: EventRegistrationToken); safecall;
    function add_TimedMetadataTracksChanged(handler: TypedEventHandler_2__Playback_IMediaPlaybackItem__IVectorChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_TimedMetadataTracksChanged(token: EventRegistrationToken); safecall;
    function get_Source: Core_IMediaSource2; safecall;
    function get_AudioTracks: IVectorView_1__Core_IMediaTrack; safecall;
    function get_VideoTracks: IVectorView_1__Core_IMediaTrack; safecall;
    function get_TimedMetadataTracks: IVectorView_1__Core_ITimedMetadataTrack; safecall;
    property AudioTracks: IVectorView_1__Core_IMediaTrack read get_AudioTracks;
    property Source: Core_IMediaSource2 read get_Source;
    property TimedMetadataTracks: IVectorView_1__Core_ITimedMetadataTrack read get_TimedMetadataTracks;
    property VideoTracks: IVectorView_1__Core_IMediaTrack read get_VideoTracks;
  end;

  // DualAPI Interface
  // Windows.Media.Protection.IMediaProtectionPMPServer
  [WinRTClassNameAttribute(SProtection_MediaProtectionPMPServer)]
  Protection_IMediaProtectionPMPServer = interface(IInspectable)
  ['{0C111226-7B26-4D31-95BB-9C1B08EF7FC0}']
    function get_Properties: IPropertySet; safecall;
    property Properties: IPropertySet read get_Properties;
  end;

  // DualAPI Interface
  // Windows.Media.Protection.IMediaProtectionPMPServerFactory
  [WinRTClassNameAttribute(SProtection_MediaProtectionPMPServer)]
  Protection_IMediaProtectionPMPServerFactory = interface(IInspectable)
  ['{602C8E5E-F7D2-487E-AF91-DBC4252B2182}']
    function CreatePMPServer(pProperties: IPropertySet): Protection_IMediaProtectionPMPServer; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IAudioStreamDescriptorFactory
  [WinRTClassNameAttribute(SCore_AudioStreamDescriptor)]
  Core_IAudioStreamDescriptorFactory = interface(IInspectable)
  ['{4A86CE9E-4CB1-4380-8E0C-83504B7F5BF3}']
    function Create(encodingProperties: IAudioEncodingProperties): Core_IAudioStreamDescriptor; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IVideoStreamDescriptorFactory
  [WinRTClassNameAttribute(SCore_VideoStreamDescriptor)]
  Core_IVideoStreamDescriptorFactory = interface(IInspectable)
  ['{494EF6D1-BB75-43D2-9E5E-7B79A3AFCED4}']
    function Create(encodingProperties: IVideoEncodingProperties): Core_IVideoStreamDescriptor; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSourceFactory
  [WinRTClassNameAttribute(SCore_MediaStreamSource)]
  Core_IMediaStreamSourceFactory = interface(IInspectable)
  ['{EF77E0D9-D158-4B7A-863F-203342FBFD41}']
    function CreateFromDescriptor(descriptor: Core_IMediaStreamDescriptor): Core_IMediaStreamSource; safecall;
    function CreateFromDescriptors(descriptor: Core_IMediaStreamDescriptor; descriptor2: Core_IMediaStreamDescriptor): Core_IMediaStreamSource; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Core.IMediaStreamSample>
  AsyncOperationCompletedHandler_1__Core_IMediaStreamSample_Delegate_Base = interface(IUnknown)
  ['{DF7AACC9-A86C-5C7D-BF98-CC371C97C67B}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Core.IMediaStreamSample>
  AsyncOperationCompletedHandler_1__Core_IMediaStreamSample = interface(AsyncOperationCompletedHandler_1__Core_IMediaStreamSample_Delegate_Base)
  ['{279400EC-FBCD-56C9-9324-84C74B18E130}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Core_IMediaStreamSample; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Core.IMediaStreamSample>
  IAsyncOperation_1__Core_IMediaStreamSample_Base = interface(IInspectable)
  ['{3CDC5E86-4ADA-5EF7-967A-E137A4621907}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Core.IMediaStreamSample>
  IAsyncOperation_1__Core_IMediaStreamSample = interface(IAsyncOperation_1__Core_IMediaStreamSample_Base)
  ['{FD0094F8-A96B-5DDC-95DB-6B77745A4C42}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Core_IMediaStreamSample); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Core_IMediaStreamSample; safecall;
    function GetResults: Core_IMediaStreamSample; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Core_IMediaStreamSample read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaStreamSampleStatics
  [WinRTClassNameAttribute(SCore_MediaStreamSample)]
  Core_IMediaStreamSampleStatics = interface(IInspectable)
  ['{DFDF218F-A6CF-4579-BE41-73DD941AD972}']
    function CreateFromBuffer(buffer: IBuffer; timestamp: TimeSpan): Core_IMediaStreamSample; safecall;
    function CreateFromStreamAsync(stream: IInputStream; count: Cardinal; timestamp: TimeSpan): IAsyncOperation_1__Core_IMediaStreamSample; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMseStreamSourceStatics
  [WinRTClassNameAttribute(SCore_MseStreamSource)]
  Core_IMseStreamSourceStatics = interface(IInspectable)
  ['{465C679D-D570-43CE-BA21-0BFF5F3FBD0A}']
    function IsContentTypeSupported(contentType: HSTRING): Boolean; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMseStreamSource,Object>
  TypedEventHandler_2__Core_IMseStreamSource__IInspectable_Delegate_Base = interface(IUnknown)
  ['{724BF4EF-DE7A-5DBD-815E-522A87BC3344}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMseStreamSource,Object>
  TypedEventHandler_2__Core_IMseStreamSource__IInspectable = interface(TypedEventHandler_2__Core_IMseStreamSource__IInspectable_Delegate_Base)
  ['{08C10C63-03A9-5D6A-8A44-7B55D00C64A8}']
    procedure Invoke(sender: Core_IMseStreamSource; args: IInspectable); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMseSourceBufferList,Object>
  TypedEventHandler_2__Core_IMseSourceBufferList__IInspectable_Delegate_Base = interface(IUnknown)
  ['{0FF01695-FBB2-5E95-8EC7-DA17D8E99F16}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMseSourceBufferList,Object>
  TypedEventHandler_2__Core_IMseSourceBufferList__IInspectable = interface(TypedEventHandler_2__Core_IMseSourceBufferList__IInspectable_Delegate_Base)
  ['{BBAF9BAC-3BE9-557B-BDE5-6FE15E68D71F}']
    procedure Invoke(sender: Core_IMseSourceBufferList; args: IInspectable); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMseSourceBuffer,Object>
  TypedEventHandler_2__Core_IMseSourceBuffer__IInspectable_Delegate_Base = interface(IUnknown)
  ['{187FD3D7-BB9D-541A-94FD-43C31DD84A67}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IMseSourceBuffer,Object>
  TypedEventHandler_2__Core_IMseSourceBuffer__IInspectable = interface(TypedEventHandler_2__Core_IMseSourceBuffer__IInspectable_Delegate_Base)
  ['{A8082AAB-CD71-5438-A66B-A40E02D70532}']
    procedure Invoke(sender: Core_IMseSourceBuffer; args: IInspectable); safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.MseTimeRange>
  IIterator_1__Core_MseTimeRange = interface(IInspectable)
  ['{752850B9-5ED2-5655-8DE2-262EFC26CF39}']
    function get_Current: Core_MseTimeRange; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PCore_MseTimeRange): Cardinal; safecall;
    property Current: Core_MseTimeRange read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.MseTimeRange>
  IIterable_1__Core_MseTimeRange_Base = interface(IInspectable)
  ['{ED0C6E08-E22F-5AC2-BA14-E0FF1DF3467F}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.MseTimeRange>
  IIterable_1__Core_MseTimeRange = interface(IIterable_1__Core_MseTimeRange_Base)
  ['{1B6614A1-8FC5-567D-9157-410A9E0ECBC5}']
    function First: IIterator_1__Core_MseTimeRange; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.MseTimeRange>
  IVectorView_1__Core_MseTimeRange = interface(IInspectable)
  ['{86D0B56E-CB4E-58F0-B9A2-1528619DCD26}']
    function GetAt(index: Cardinal): Core_MseTimeRange; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Core_MseTimeRange; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_MseTimeRange): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMseSourceBuffer
  [WinRTClassNameAttribute(SCore_MseSourceBuffer)]
  Core_IMseSourceBuffer = interface(IInspectable)
  ['{0C1AA3E3-DF8D-4079-A3FE-6849184B4E2F}']
    function add_UpdateStarting(handler: TypedEventHandler_2__Core_IMseSourceBuffer__IInspectable): EventRegistrationToken; safecall;
    procedure remove_UpdateStarting(token: EventRegistrationToken); safecall;
    function add_Updated(handler: TypedEventHandler_2__Core_IMseSourceBuffer__IInspectable): EventRegistrationToken; safecall;
    procedure remove_Updated(token: EventRegistrationToken); safecall;
    function add_UpdateEnded(handler: TypedEventHandler_2__Core_IMseSourceBuffer__IInspectable): EventRegistrationToken; safecall;
    procedure remove_UpdateEnded(token: EventRegistrationToken); safecall;
    function add_ErrorOccurred(handler: TypedEventHandler_2__Core_IMseSourceBuffer__IInspectable): EventRegistrationToken; safecall;
    procedure remove_ErrorOccurred(token: EventRegistrationToken); safecall;
    function add_Aborted(handler: TypedEventHandler_2__Core_IMseSourceBuffer__IInspectable): EventRegistrationToken; safecall;
    procedure remove_Aborted(token: EventRegistrationToken); safecall;
    function get_Mode: Core_MseAppendMode; safecall;
    procedure put_Mode(value: Core_MseAppendMode); safecall;
    function get_IsUpdating: Boolean; safecall;
    function get_Buffered: IVectorView_1__Core_MseTimeRange; safecall;
    function get_TimestampOffset: TimeSpan; safecall;
    procedure put_TimestampOffset(value: TimeSpan); safecall;
    function get_AppendWindowStart: TimeSpan; safecall;
    procedure put_AppendWindowStart(value: TimeSpan); safecall;
    function get_AppendWindowEnd: IReference_1__TimeSpan; safecall;
    procedure put_AppendWindowEnd(value: IReference_1__TimeSpan); safecall;
    procedure AppendBuffer(buffer: IBuffer); safecall;
    procedure AppendStream(stream: IInputStream); overload; safecall;
    procedure AppendStream(stream: IInputStream; maxSize: UInt64); overload; safecall;
    procedure Abort; safecall;
    procedure Remove(start: TimeSpan; &end: IReference_1__TimeSpan); safecall;
    property AppendWindowEnd: IReference_1__TimeSpan read get_AppendWindowEnd write put_AppendWindowEnd;
    property AppendWindowStart: TimeSpan read get_AppendWindowStart write put_AppendWindowStart;
    property Buffered: IVectorView_1__Core_MseTimeRange read get_Buffered;
    property IsUpdating: Boolean read get_IsUpdating;
    property Mode: Core_MseAppendMode read get_Mode write put_Mode;
    property TimestampOffset: TimeSpan read get_TimestampOffset write put_TimestampOffset;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.IMseSourceBuffer>
  IIterator_1__Core_IMseSourceBuffer = interface(IInspectable)
  ['{272FE72F-5993-555B-90A4-641A57B42C98}']
    function get_Current: Core_IMseSourceBuffer; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PCore_IMseSourceBuffer): Cardinal; safecall;
    property Current: Core_IMseSourceBuffer read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.IMseSourceBuffer>
  IIterable_1__Core_IMseSourceBuffer_Base = interface(IInspectable)
  ['{5CA0DA86-6307-558A-865F-3A1EF9FE56B3}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.IMseSourceBuffer>
  IIterable_1__Core_IMseSourceBuffer = interface(IIterable_1__Core_IMseSourceBuffer_Base)
  ['{9CB0CD5C-931E-5ACC-9853-3D3280DF1B13}']
    function First: IIterator_1__Core_IMseSourceBuffer; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.IMseSourceBuffer>
  IVectorView_1__Core_IMseSourceBuffer = interface(IInspectable)
  ['{F707442C-E628-5E3A-9674-9C002D487136}']
    function GetAt(index: Cardinal): Core_IMseSourceBuffer; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Core_IMseSourceBuffer; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_IMseSourceBuffer): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMseSourceBufferList
  [WinRTClassNameAttribute(SCore_MseSourceBufferList)]
  Core_IMseSourceBufferList = interface(IInspectable)
  ['{95FAE8E7-A8E7-4EBF-8927-145E940BA511}']
    function add_SourceBufferAdded(handler: TypedEventHandler_2__Core_IMseSourceBufferList__IInspectable): EventRegistrationToken; safecall;
    procedure remove_SourceBufferAdded(token: EventRegistrationToken); safecall;
    function add_SourceBufferRemoved(handler: TypedEventHandler_2__Core_IMseSourceBufferList__IInspectable): EventRegistrationToken; safecall;
    procedure remove_SourceBufferRemoved(token: EventRegistrationToken); safecall;
    function get_Buffers: IVectorView_1__Core_IMseSourceBuffer; safecall;
    property Buffers: IVectorView_1__Core_IMseSourceBuffer read get_Buffers;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMseStreamSource
  [WinRTClassNameAttribute(SCore_MseStreamSource)]
  Core_IMseStreamSource = interface(IInspectable)
  ['{B0B4198D-02F4-4923-88DD-81BC3F360FFA}']
    function add_Opened(handler: TypedEventHandler_2__Core_IMseStreamSource__IInspectable): EventRegistrationToken; safecall;
    procedure remove_Opened(token: EventRegistrationToken); safecall;
    function add_Ended(handler: TypedEventHandler_2__Core_IMseStreamSource__IInspectable): EventRegistrationToken; safecall;
    procedure remove_Ended(token: EventRegistrationToken); safecall;
    function add_Closed(handler: TypedEventHandler_2__Core_IMseStreamSource__IInspectable): EventRegistrationToken; safecall;
    procedure remove_Closed(token: EventRegistrationToken); safecall;
    function get_SourceBuffers: Core_IMseSourceBufferList; safecall;
    function get_ActiveSourceBuffers: Core_IMseSourceBufferList; safecall;
    function get_ReadyState: Core_MseReadyState; safecall;
    function get_Duration: IReference_1__TimeSpan; safecall;
    procedure put_Duration(value: IReference_1__TimeSpan); safecall;
    function AddSourceBuffer(mimeType: HSTRING): Core_IMseSourceBuffer; safecall;
    procedure RemoveSourceBuffer(buffer: Core_IMseSourceBuffer); safecall;
    procedure EndOfStream(status: Core_MseEndOfStreamStatus); safecall;
    property ActiveSourceBuffers: Core_IMseSourceBufferList read get_ActiveSourceBuffers;
    property Duration: IReference_1__TimeSpan read get_Duration write put_Duration;
    property ReadyState: Core_MseReadyState read get_ReadyState;
    property SourceBuffers: Core_IMseSourceBufferList read get_SourceBuffers;
  end;

  // DualAPI Interface
  // Windows.Media.Transcoding.IPrepareTranscodeResult
  [WinRTClassNameAttribute(STranscoding_PrepareTranscodeResult)]
  Transcoding_IPrepareTranscodeResult = interface(IInspectable)
  ['{05F25DCE-994F-4A34-9D68-97CCCE1730D6}']
    function get_CanTranscode: Boolean; safecall;
    function get_FailureReason: Transcoding_TranscodeFailureReason; safecall;
    function TranscodeAsync: IAsyncActionWithProgress_1__Double; safecall;
    property CanTranscode: Boolean read get_CanTranscode;
    property FailureReason: Transcoding_TranscodeFailureReason read get_FailureReason;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Transcoding.IPrepareTranscodeResult>
  AsyncOperationCompletedHandler_1__Transcoding_IPrepareTranscodeResult_Delegate_Base = interface(IUnknown)
  ['{A44D7D07-8F74-52EE-9F02-C2B244B4FF2A}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Transcoding.IPrepareTranscodeResult>
  AsyncOperationCompletedHandler_1__Transcoding_IPrepareTranscodeResult = interface(AsyncOperationCompletedHandler_1__Transcoding_IPrepareTranscodeResult_Delegate_Base)
  ['{AE14E17F-05D5-55CB-8F28-85A7C84ED130}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Transcoding_IPrepareTranscodeResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Transcoding.IPrepareTranscodeResult>
  IAsyncOperation_1__Transcoding_IPrepareTranscodeResult_Base = interface(IInspectable)
  ['{F5F07C13-3047-5BAB-8EB7-6E5D7D14AFAE}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Transcoding.IPrepareTranscodeResult>
  IAsyncOperation_1__Transcoding_IPrepareTranscodeResult = interface(IAsyncOperation_1__Transcoding_IPrepareTranscodeResult_Base)
  ['{597B00B0-750D-5EAA-AAB4-6D73FF756500}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Transcoding_IPrepareTranscodeResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Transcoding_IPrepareTranscodeResult; safecall;
    function GetResults: Transcoding_IPrepareTranscodeResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Transcoding_IPrepareTranscodeResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Transcoding.IMediaTranscoder2
  Transcoding_IMediaTranscoder2 = interface(IInspectable)
  ['{40531D74-35E0-4F04-8574-CA8BC4E5A082}']
    function PrepareMediaStreamSourceTranscodeAsync(source: Core_IMediaSource; destination: IRandomAccessStream; profile: IMediaEncodingProfile): IAsyncOperation_1__Transcoding_IPrepareTranscodeResult; safecall;
    procedure put_VideoProcessingAlgorithm(value: Transcoding_MediaVideoProcessingAlgorithm); safecall;
    function get_VideoProcessingAlgorithm: Transcoding_MediaVideoProcessingAlgorithm; safecall;
    property VideoProcessingAlgorithm: Transcoding_MediaVideoProcessingAlgorithm read get_VideoProcessingAlgorithm write put_VideoProcessingAlgorithm;
  end;

  // DualAPI Interface
  // Windows.Media.Transcoding.IMediaTranscoder
  [WinRTClassNameAttribute(STranscoding_MediaTranscoder)]
  Transcoding_IMediaTranscoder = interface(IInspectable)
  ['{190C99D2-A0AA-4D34-86BC-EED1B12C2F5B}']
    procedure put_TrimStartTime(value: TimeSpan); safecall;
    function get_TrimStartTime: TimeSpan; safecall;
    procedure put_TrimStopTime(value: TimeSpan); safecall;
    function get_TrimStopTime: TimeSpan; safecall;
    procedure put_AlwaysReencode(value: Boolean); safecall;
    function get_AlwaysReencode: Boolean; safecall;
    procedure put_HardwareAccelerationEnabled(value: Boolean); safecall;
    function get_HardwareAccelerationEnabled: Boolean; safecall;
    procedure AddAudioEffect(activatableClassId: HSTRING); overload; safecall;
    procedure AddAudioEffect(activatableClassId: HSTRING; effectRequired: Boolean; configuration: IPropertySet); overload; safecall;
    procedure AddVideoEffect(activatableClassId: HSTRING); overload; safecall;
    procedure AddVideoEffect(activatableClassId: HSTRING; effectRequired: Boolean; configuration: IPropertySet); overload; safecall;
    procedure ClearEffects; safecall;
    function PrepareFileTranscodeAsync(source: IStorageFile; destination: IStorageFile; profile: IMediaEncodingProfile): IAsyncOperation_1__Transcoding_IPrepareTranscodeResult; safecall;
    function PrepareStreamTranscodeAsync(source: IRandomAccessStream; destination: IRandomAccessStream; profile: IMediaEncodingProfile): IAsyncOperation_1__Transcoding_IPrepareTranscodeResult; safecall;
    property AlwaysReencode: Boolean read get_AlwaysReencode write put_AlwaysReencode;
    property HardwareAccelerationEnabled: Boolean read get_HardwareAccelerationEnabled write put_HardwareAccelerationEnabled;
    property TrimStartTime: TimeSpan read get_TrimStartTime write put_TrimStartTime;
    property TrimStopTime: TimeSpan read get_TrimStopTime write put_TrimStopTime;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IHighDynamicRangeControl
  [WinRTClassNameAttribute(SCore_HighDynamicRangeControl)]
  Core_IHighDynamicRangeControl = interface(IInspectable)
  ['{55F1A7AE-D957-4DC9-9D1C-8553A82A7D99}']
    procedure put_Enabled(value: Boolean); safecall;
    function get_Enabled: Boolean; safecall;
    property Enabled: Boolean read get_Enabled write put_Enabled;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IHighDynamicRangeOutput
  [WinRTClassNameAttribute(SCore_HighDynamicRangeOutput)]
  Core_IHighDynamicRangeOutput = interface(IInspectable)
  ['{0F57806B-253B-4119-BB40-3A90E51384F7}']
    function get_Certainty: Double; safecall;
    function get_FrameControllers: IVectorView_1__Core_IFrameController; safecall;
    property Certainty: Double read get_Certainty;
    property FrameControllers: IVectorView_1__Core_IFrameController read get_FrameControllers;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ISceneAnalysisEffectFrame
  [WinRTClassNameAttribute(SCore_SceneAnalysisEffectFrame)]
  Core_ISceneAnalysisEffectFrame = interface(IInspectable)
  ['{D8B10E4C-7FD9-42E1-85EB-6572C297C987}']
    function get_FrameControlValues: Capture_ICapturedFrameControlValues; safecall;
    function get_HighDynamicRange: Core_IHighDynamicRangeOutput; safecall;
    property FrameControlValues: Capture_ICapturedFrameControlValues read get_FrameControlValues;
    property HighDynamicRange: Core_IHighDynamicRangeOutput read get_HighDynamicRange;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ISceneAnalyzedEventArgs
  [WinRTClassNameAttribute(SCore_SceneAnalyzedEventArgs)]
  Core_ISceneAnalyzedEventArgs = interface(IInspectable)
  ['{146B9588-2851-45E4-AD55-44CF8DF8DB4D}']
    function get_ResultFrame: Core_ISceneAnalysisEffectFrame; safecall;
    property ResultFrame: Core_ISceneAnalysisEffectFrame read get_ResultFrame;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.ISceneAnalysisEffect,Windows.Media.Core.ISceneAnalyzedEventArgs>
  TypedEventHandler_2__Core_ISceneAnalysisEffect__Core_ISceneAnalyzedEventArgs_Delegate_Base = interface(IUnknown)
  ['{48630F8C-DBDE-569E-A0C8-7588D1D2BD03}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.ISceneAnalysisEffect,Windows.Media.Core.ISceneAnalyzedEventArgs>
  TypedEventHandler_2__Core_ISceneAnalysisEffect__Core_ISceneAnalyzedEventArgs = interface(TypedEventHandler_2__Core_ISceneAnalysisEffect__Core_ISceneAnalyzedEventArgs_Delegate_Base)
  ['{660BEC11-8A1D-58B3-A332-1F486278AA4D}']
    procedure Invoke(sender: Core_ISceneAnalysisEffect; args: Core_ISceneAnalyzedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ISceneAnalysisEffect
  [WinRTClassNameAttribute(SCore_SceneAnalysisEffect)]
  Core_ISceneAnalysisEffect = interface(IInspectable)
  ['{C04BA319-CA41-4813-BFFD-7B08B0ED2557}']
    function get_HighDynamicRangeAnalyzer: Core_IHighDynamicRangeControl; safecall;
    procedure put_DesiredAnalysisInterval(value: TimeSpan); safecall;
    function get_DesiredAnalysisInterval: TimeSpan; safecall;
    function add_SceneAnalyzed(handler: TypedEventHandler_2__Core_ISceneAnalysisEffect__Core_ISceneAnalyzedEventArgs): EventRegistrationToken; safecall;
    procedure remove_SceneAnalyzed(cookie: EventRegistrationToken); safecall;
    property DesiredAnalysisInterval: TimeSpan read get_DesiredAnalysisInterval write put_DesiredAnalysisInterval;
    property HighDynamicRangeAnalyzer: Core_IHighDynamicRangeControl read get_HighDynamicRangeAnalyzer;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IFaceDetectionEffectFrame
  [WinRTClassNameAttribute(SCore_FaceDetectionEffectFrame)]
  Core_IFaceDetectionEffectFrame = interface(IInspectable)
  ['{8AB08993-5DC8-447B-A247-5270BD802ECE}']
    function get_DetectedFaces: IVectorView_1__FaceAnalysis_IDetectedFace; safecall;
    property DetectedFaces: IVectorView_1__FaceAnalysis_IDetectedFace read get_DetectedFaces;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IFaceDetectedEventArgs
  [WinRTClassNameAttribute(SCore_FaceDetectedEventArgs)]
  Core_IFaceDetectedEventArgs = interface(IInspectable)
  ['{19918426-C65B-46BA-85F8-13880576C90A}']
    function get_ResultFrame: Core_IFaceDetectionEffectFrame; safecall;
    property ResultFrame: Core_IFaceDetectionEffectFrame read get_ResultFrame;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IFaceDetectionEffect,Windows.Media.Core.IFaceDetectedEventArgs>
  TypedEventHandler_2__Core_IFaceDetectionEffect__Core_IFaceDetectedEventArgs_Delegate_Base = interface(IUnknown)
  ['{01F0D7A6-F9BD-5BC1-AAA9-DFF396F72F87}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IFaceDetectionEffect,Windows.Media.Core.IFaceDetectedEventArgs>
  TypedEventHandler_2__Core_IFaceDetectionEffect__Core_IFaceDetectedEventArgs = interface(TypedEventHandler_2__Core_IFaceDetectionEffect__Core_IFaceDetectedEventArgs_Delegate_Base)
  ['{A50D93A2-5928-5A8A-9D31-00C3AEA49923}']
    procedure Invoke(sender: Core_IFaceDetectionEffect; args: Core_IFaceDetectedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IFaceDetectionEffect
  [WinRTClassNameAttribute(SCore_FaceDetectionEffect)]
  Core_IFaceDetectionEffect = interface(IInspectable)
  ['{AE15EBD2-0542-42A9-BC90-F283A29F46C1}']
    procedure put_Enabled(value: Boolean); safecall;
    function get_Enabled: Boolean; safecall;
    procedure put_DesiredDetectionInterval(value: TimeSpan); safecall;
    function get_DesiredDetectionInterval: TimeSpan; safecall;
    function add_FaceDetected(handler: TypedEventHandler_2__Core_IFaceDetectionEffect__Core_IFaceDetectedEventArgs): EventRegistrationToken; safecall;
    procedure remove_FaceDetected(cookie: EventRegistrationToken); safecall;
    property DesiredDetectionInterval: TimeSpan read get_DesiredDetectionInterval write put_DesiredDetectionInterval;
    property Enabled: Boolean read get_Enabled write put_Enabled;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IFaceDetectionEffectDefinition
  [WinRTClassNameAttribute(SCore_FaceDetectionEffectDefinition)]
  Core_IFaceDetectionEffectDefinition = interface(IInspectable)
  ['{43DCA081-B848-4F33-B702-1FD2624FB016}']
    procedure put_DetectionMode(value: Core_FaceDetectionMode); safecall;
    function get_DetectionMode: Core_FaceDetectionMode; safecall;
    procedure put_SynchronousDetectionEnabled(value: Boolean); safecall;
    function get_SynchronousDetectionEnabled: Boolean; safecall;
    property DetectionMode: Core_FaceDetectionMode read get_DetectionMode write put_DetectionMode;
    property SynchronousDetectionEnabled: Boolean read get_SynchronousDetectionEnabled write put_SynchronousDetectionEnabled;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IVideoStabilizationEffectEnabledChangedEventArgs
  [WinRTClassNameAttribute(SCore_VideoStabilizationEffectEnabledChangedEventArgs)]
  Core_IVideoStabilizationEffectEnabledChangedEventArgs = interface(IInspectable)
  ['{187EFF28-67BB-4713-B900-4168DA164529}']
    function get_Reason: Core_VideoStabilizationEffectEnabledChangedReason; safecall;
    property Reason: Core_VideoStabilizationEffectEnabledChangedReason read get_Reason;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IVideoStabilizationEffect,Windows.Media.Core.IVideoStabilizationEffectEnabledChangedEventArgs>
  TypedEventHandler_2__Core_IVideoStabilizationEffect__Core_IVideoStabilizationEffectEnabledChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{897592E2-BFCC-5F16-8834-2C9C4F20559B}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.IVideoStabilizationEffect,Windows.Media.Core.IVideoStabilizationEffectEnabledChangedEventArgs>
  TypedEventHandler_2__Core_IVideoStabilizationEffect__Core_IVideoStabilizationEffectEnabledChangedEventArgs = interface(TypedEventHandler_2__Core_IVideoStabilizationEffect__Core_IVideoStabilizationEffectEnabledChangedEventArgs_Delegate_Base)
  ['{61816F56-C54F-5740-B7E0-6ABB9CA78FC2}']
    procedure Invoke(sender: Core_IVideoStabilizationEffect; args: Core_IVideoStabilizationEffectEnabledChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IVideoStabilizationEffect
  [WinRTClassNameAttribute(SCore_VideoStabilizationEffect)]
  Core_IVideoStabilizationEffect = interface(IInspectable)
  ['{0808A650-9698-4E57-877B-BD7CB2EE0F8A}']
    procedure put_Enabled(value: Boolean); safecall;
    function get_Enabled: Boolean; safecall;
    function add_EnabledChanged(handler: TypedEventHandler_2__Core_IVideoStabilizationEffect__Core_IVideoStabilizationEffectEnabledChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_EnabledChanged(cookie: EventRegistrationToken); safecall;
    function GetRecommendedStreamConfiguration(controller: IVideoDeviceController; desiredProperties: IVideoEncodingProperties): Capture_IVideoStreamConfiguration; safecall;
    property Enabled: Boolean read get_Enabled write put_Enabled;
  end;

  // DualAPI Interface
  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadBitrateChangedEventArgs
  [WinRTClassNameAttribute(SStreaming_Adaptive_AdaptiveMediaSourceDownloadBitrateChangedEventArgs)]
  Streaming_Adaptive_IAdaptiveMediaSourceDownloadBitrateChangedEventArgs = interface(IInspectable)
  ['{670C0A44-E04E-4EFF-816A-17399F78F4BA}']
    function get_OldValue: Cardinal; safecall;
    function get_NewValue: Cardinal; safecall;
    property NewValue: Cardinal read get_NewValue;
    property OldValue: Cardinal read get_OldValue;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource,Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadBitrateChangedEventArgs>
  TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadBitrateChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{AD268CAF-7DA0-5AD4-8585-CEEB903DBD50}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource,Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadBitrateChangedEventArgs>
  TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadBitrateChangedEventArgs = interface(TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadBitrateChangedEventArgs_Delegate_Base)
  ['{154A26A0-057A-507B-8AA9-84670A13A8F6}']
    procedure Invoke(sender: Streaming_Adaptive_IAdaptiveMediaSource; args: Streaming_Adaptive_IAdaptiveMediaSourceDownloadBitrateChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs
  [WinRTClassNameAttribute(SStreaming_Adaptive_AdaptiveMediaSourcePlaybackBitrateChangedEventArgs)]
  Streaming_Adaptive_IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs = interface(IInspectable)
  ['{23A29F6D-7DDA-4A51-87A9-6FA8C5B292BE}']
    function get_OldValue: Cardinal; safecall;
    function get_NewValue: Cardinal; safecall;
    function get_AudioOnly: Boolean; safecall;
    property AudioOnly: Boolean read get_AudioOnly;
    property NewValue: Cardinal read get_NewValue;
    property OldValue: Cardinal read get_OldValue;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource,Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs>
  TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{DF4F4E89-6173-539B-94D8-69B7CB7578A7}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource,Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs>
  TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs = interface(TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs_Delegate_Base)
  ['{B0D57C1B-85EF-555E-B69C-83C2ED6C5A86}']
    procedure Invoke(sender: Streaming_Adaptive_IAdaptiveMediaSource; args: Streaming_Adaptive_IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadResult
  [WinRTClassNameAttribute(SStreaming_Adaptive_AdaptiveMediaSourceDownloadResult)]
  Streaming_Adaptive_IAdaptiveMediaSourceDownloadResult = interface(IInspectable)
  ['{F4AFDC73-BCEE-4A6A-9F0A-FEC41E2339B0}']
    function get_ResourceUri: IUriRuntimeClass; safecall;
    procedure put_ResourceUri(value: IUriRuntimeClass); safecall;
    function get_InputStream: IInputStream; safecall;
    procedure put_InputStream(value: IInputStream); safecall;
    function get_Buffer: IBuffer; safecall;
    procedure put_Buffer(value: IBuffer); safecall;
    function get_ContentType: HSTRING; safecall;
    procedure put_ContentType(value: HSTRING); safecall;
    function get_ExtendedStatus: Cardinal; safecall;
    procedure put_ExtendedStatus(value: Cardinal); safecall;
    property Buffer: IBuffer read get_Buffer write put_Buffer;
    property ContentType: HSTRING read get_ContentType write put_ContentType;
    property ExtendedStatus: Cardinal read get_ExtendedStatus write put_ExtendedStatus;
    property InputStream: IInputStream read get_InputStream write put_InputStream;
    property ResourceUri: IUriRuntimeClass read get_ResourceUri write put_ResourceUri;
  end;

  // DualAPI Interface
  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadRequestedDeferral
  [WinRTClassNameAttribute(SStreaming_Adaptive_AdaptiveMediaSourceDownloadRequestedDeferral)]
  Streaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedDeferral = interface(IInspectable)
  ['{05C68F64-FA20-4DBD-9821-4BF4C9BF77AB}']
    procedure Complete; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadRequestedEventArgs
  [WinRTClassNameAttribute(SStreaming_Adaptive_AdaptiveMediaSourceDownloadRequestedEventArgs)]
  Streaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedEventArgs = interface(IInspectable)
  ['{C83FDFFD-44A9-47A2-BF96-03398B4BFAAF}']
    function get_ResourceType: Streaming_Adaptive_AdaptiveMediaSourceResourceType; safecall;
    function get_ResourceUri: IUriRuntimeClass; safecall;
    function get_ResourceByteRangeOffset: IReference_1__UInt64; safecall;
    function get_ResourceByteRangeLength: IReference_1__UInt64; safecall;
    function get_Result: Streaming_Adaptive_IAdaptiveMediaSourceDownloadResult; safecall;
    function GetDeferral: Streaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedDeferral; safecall;
    property ResourceByteRangeLength: IReference_1__UInt64 read get_ResourceByteRangeLength;
    property ResourceByteRangeOffset: IReference_1__UInt64 read get_ResourceByteRangeOffset;
    property ResourceType: Streaming_Adaptive_AdaptiveMediaSourceResourceType read get_ResourceType;
    property ResourceUri: IUriRuntimeClass read get_ResourceUri;
    property Result: Streaming_Adaptive_IAdaptiveMediaSourceDownloadResult read get_Result;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource,Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadRequestedEventArgs>
  TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedEventArgs_Delegate_Base = interface(IUnknown)
  ['{D3B7DBF1-FD8E-589E-9C7F-BA67397E50CD}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource,Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadRequestedEventArgs>
  TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedEventArgs = interface(TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedEventArgs_Delegate_Base)
  ['{E724A0D6-68B7-52DE-9936-68BC10850256}']
    procedure Invoke(sender: Streaming_Adaptive_IAdaptiveMediaSource; args: Streaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadCompletedEventArgs
  [WinRTClassNameAttribute(SStreaming_Adaptive_AdaptiveMediaSourceDownloadCompletedEventArgs)]
  Streaming_Adaptive_IAdaptiveMediaSourceDownloadCompletedEventArgs = interface(IInspectable)
  ['{19240DC3-5B37-4A1A-8970-D621CB6CA83B}']
    function get_ResourceType: Streaming_Adaptive_AdaptiveMediaSourceResourceType; safecall;
    function get_ResourceUri: IUriRuntimeClass; safecall;
    function get_ResourceByteRangeOffset: IReference_1__UInt64; safecall;
    function get_ResourceByteRangeLength: IReference_1__UInt64; safecall;
    function get_HttpResponseMessage: Http_IHttpResponseMessage; safecall;
    property HttpResponseMessage: Http_IHttpResponseMessage read get_HttpResponseMessage;
    property ResourceByteRangeLength: IReference_1__UInt64 read get_ResourceByteRangeLength;
    property ResourceByteRangeOffset: IReference_1__UInt64 read get_ResourceByteRangeOffset;
    property ResourceType: Streaming_Adaptive_AdaptiveMediaSourceResourceType read get_ResourceType;
    property ResourceUri: IUriRuntimeClass read get_ResourceUri;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource,Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadCompletedEventArgs>
  TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadCompletedEventArgs_Delegate_Base = interface(IUnknown)
  ['{CEF775DD-25B2-5588-8D51-DACDEA660A7D}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource,Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadCompletedEventArgs>
  TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadCompletedEventArgs = interface(TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadCompletedEventArgs_Delegate_Base)
  ['{18ED2E26-1582-5201-BA28-D36640B7566E}']
    procedure Invoke(sender: Streaming_Adaptive_IAdaptiveMediaSource; args: Streaming_Adaptive_IAdaptiveMediaSourceDownloadCompletedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadFailedEventArgs
  [WinRTClassNameAttribute(SStreaming_Adaptive_AdaptiveMediaSourceDownloadFailedEventArgs)]
  Streaming_Adaptive_IAdaptiveMediaSourceDownloadFailedEventArgs = interface(IInspectable)
  ['{37739048-F4AB-40A4-B135-C6DFD8BD7FF1}']
    function get_ResourceType: Streaming_Adaptive_AdaptiveMediaSourceResourceType; safecall;
    function get_ResourceUri: IUriRuntimeClass; safecall;
    function get_ResourceByteRangeOffset: IReference_1__UInt64; safecall;
    function get_ResourceByteRangeLength: IReference_1__UInt64; safecall;
    function get_HttpResponseMessage: Http_IHttpResponseMessage; safecall;
    property HttpResponseMessage: Http_IHttpResponseMessage read get_HttpResponseMessage;
    property ResourceByteRangeLength: IReference_1__UInt64 read get_ResourceByteRangeLength;
    property ResourceByteRangeOffset: IReference_1__UInt64 read get_ResourceByteRangeOffset;
    property ResourceType: Streaming_Adaptive_AdaptiveMediaSourceResourceType read get_ResourceType;
    property ResourceUri: IUriRuntimeClass read get_ResourceUri;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource,Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadFailedEventArgs>
  TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadFailedEventArgs_Delegate_Base = interface(IUnknown)
  ['{6EE5CC44-49AD-5138-AB47-F5C075A2BC34}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource,Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceDownloadFailedEventArgs>
  TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadFailedEventArgs = interface(TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadFailedEventArgs_Delegate_Base)
  ['{569C79C5-DEB8-52EF-B9BD-053D702E92C9}']
    procedure Invoke(sender: Streaming_Adaptive_IAdaptiveMediaSource; args: Streaming_Adaptive_IAdaptiveMediaSourceDownloadFailedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSource
  [WinRTClassNameAttribute(SStreaming_Adaptive_AdaptiveMediaSource)]
  Streaming_Adaptive_IAdaptiveMediaSource = interface(IInspectable)
  ['{4C7332EF-D39F-4396-B4D9-043957A7C964}']
    function get_IsLive: Boolean; safecall;
    function get_DesiredLiveOffset: TimeSpan; safecall;
    procedure put_DesiredLiveOffset(value: TimeSpan); safecall;
    function get_InitialBitrate: Cardinal; safecall;
    procedure put_InitialBitrate(value: Cardinal); safecall;
    function get_CurrentDownloadBitrate: Cardinal; safecall;
    function get_CurrentPlaybackBitrate: Cardinal; safecall;
    function get_AvailableBitrates: IVectorView_1__Cardinal; safecall;
    function get_DesiredMinBitrate: IReference_1__Cardinal; safecall;
    procedure put_DesiredMinBitrate(value: IReference_1__Cardinal); safecall;
    function get_DesiredMaxBitrate: IReference_1__Cardinal; safecall;
    procedure put_DesiredMaxBitrate(value: IReference_1__Cardinal); safecall;
    function get_AudioOnlyPlayback: Boolean; safecall;
    function get_InboundBitsPerSecond: UInt64; safecall;
    function get_InboundBitsPerSecondWindow: TimeSpan; safecall;
    procedure put_InboundBitsPerSecondWindow(value: TimeSpan); safecall;
    function add_DownloadBitrateChanged(handler: TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadBitrateChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_DownloadBitrateChanged(token: EventRegistrationToken); safecall;
    function add_PlaybackBitrateChanged(handler: TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourcePlaybackBitrateChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_PlaybackBitrateChanged(token: EventRegistrationToken); safecall;
    function add_DownloadRequested(handler: TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadRequestedEventArgs): EventRegistrationToken; safecall;
    procedure remove_DownloadRequested(token: EventRegistrationToken); safecall;
    function add_DownloadCompleted(handler: TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadCompletedEventArgs): EventRegistrationToken; safecall;
    procedure remove_DownloadCompleted(token: EventRegistrationToken); safecall;
    function add_DownloadFailed(handler: TypedEventHandler_2__Streaming_Adaptive_IAdaptiveMediaSource__Streaming_Adaptive_IAdaptiveMediaSourceDownloadFailedEventArgs): EventRegistrationToken; safecall;
    procedure remove_DownloadFailed(token: EventRegistrationToken); safecall;
    property AudioOnlyPlayback: Boolean read get_AudioOnlyPlayback;
    property AvailableBitrates: IVectorView_1__Cardinal read get_AvailableBitrates;
    property CurrentDownloadBitrate: Cardinal read get_CurrentDownloadBitrate;
    property CurrentPlaybackBitrate: Cardinal read get_CurrentPlaybackBitrate;
    property DesiredLiveOffset: TimeSpan read get_DesiredLiveOffset write put_DesiredLiveOffset;
    property DesiredMaxBitrate: IReference_1__Cardinal read get_DesiredMaxBitrate write put_DesiredMaxBitrate;
    property DesiredMinBitrate: IReference_1__Cardinal read get_DesiredMinBitrate write put_DesiredMinBitrate;
    property InboundBitsPerSecond: UInt64 read get_InboundBitsPerSecond;
    property InboundBitsPerSecondWindow: TimeSpan read get_InboundBitsPerSecondWindow write put_InboundBitsPerSecondWindow;
    property InitialBitrate: Cardinal read get_InitialBitrate write put_InitialBitrate;
    property IsLive: Boolean read get_IsLive;
  end;

  // DualAPI Interface
  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceCreationResult
  [WinRTClassNameAttribute(SStreaming_Adaptive_AdaptiveMediaSourceCreationResult)]
  Streaming_Adaptive_IAdaptiveMediaSourceCreationResult = interface(IInspectable)
  ['{4686B6B2-800F-4E31-9093-76D4782013E7}']
    function get_Status: Streaming_Adaptive_AdaptiveMediaSourceCreationStatus; safecall;
    function get_MediaSource: Streaming_Adaptive_IAdaptiveMediaSource; safecall;
    function get_HttpResponseMessage: Http_IHttpResponseMessage; safecall;
    property HttpResponseMessage: Http_IHttpResponseMessage read get_HttpResponseMessage;
    property MediaSource: Streaming_Adaptive_IAdaptiveMediaSource read get_MediaSource;
    property Status: Streaming_Adaptive_AdaptiveMediaSourceCreationStatus read get_Status;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceCreationResult>
  AsyncOperationCompletedHandler_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult_Delegate_Base = interface(IUnknown)
  ['{BD68CC00-724C-5A76-A437-1464EBDDA4AC}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceCreationResult>
  AsyncOperationCompletedHandler_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult = interface(AsyncOperationCompletedHandler_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult_Delegate_Base)
  ['{F744DE86-F28C-55E8-8D96-27B634737681}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceCreationResult>
  IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult_Base = interface(IInspectable)
  ['{BE0BCC1D-D606-59D2-B2F9-FF204543DA12}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceCreationResult>
  IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult = interface(IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult_Base)
  ['{E80E3F02-CF03-51CA-948B-35FF046A76E2}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult; safecall;
    function GetResults: Streaming_Adaptive_IAdaptiveMediaSourceCreationResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Streaming.Adaptive.IAdaptiveMediaSourceStatics
  [WinRTClassNameAttribute(SStreaming_Adaptive_AdaptiveMediaSource)]
  Streaming_Adaptive_IAdaptiveMediaSourceStatics = interface(IInspectable)
  ['{50A6BD5D-66EF-4CD3-9579-9E660507DC3F}']
    function IsContentTypeSupported(contentType: HSTRING): Boolean; safecall;
    function CreateFromUriAsync(uri: IUriRuntimeClass): IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult; overload; safecall;
    function CreateFromUriAsync(uri: IUriRuntimeClass; httpClient: Http_IHttpClient): IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult; overload; safecall;
    function CreateFromStreamAsync(stream: IInputStream; uri: IUriRuntimeClass; contentType: HSTRING): IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult; overload; safecall;
    function CreateFromStreamAsync(stream: IInputStream; uri: IUriRuntimeClass; contentType: HSTRING; httpClient: Http_IHttpClient): IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult; overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IMediaSourceStatics
  [WinRTClassNameAttribute(SCore_MediaSource)]
  Core_IMediaSourceStatics = interface(IInspectable)
  ['{F77D6FA4-4652-410E-B1D8-E9A5E245A45C}']
    function CreateFromAdaptiveMediaSource(mediaSource: Streaming_Adaptive_IAdaptiveMediaSource): Core_IMediaSource2; safecall;
    function CreateFromMediaStreamSource(mediaSource: Core_IMediaStreamSource): Core_IMediaSource2; safecall;
    function CreateFromMseStreamSource(mediaSource: Core_IMseStreamSource): Core_IMediaSource2; safecall;
    function CreateFromIMediaSource(mediaSource: Core_IMediaSource): Core_IMediaSource2; safecall;
    function CreateFromStorageFile(&file: IStorageFile): Core_IMediaSource2; safecall;
    function CreateFromStream(stream: IRandomAccessStream; contentType: HSTRING): Core_IMediaSource2; safecall;
    function CreateFromStreamReference(stream: IRandomAccessStreamReference; contentType: HSTRING): Core_IMediaSource2; safecall;
    function CreateFromUri(uri: IUriRuntimeClass): Core_IMediaSource2; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ITimedTextRegion
  [WinRTClassNameAttribute(SCore_TimedTextRegion)]
  Core_ITimedTextRegion = interface(IInspectable)
  ['{1ED0881F-8A06-4222-9F59-B21BF40124B4}']
    function get_Name: HSTRING; safecall;
    procedure put_Name(value: HSTRING); safecall;
    function get_Position: Core_TimedTextPoint; safecall;
    procedure put_Position(value: Core_TimedTextPoint); safecall;
    function get_Extent: Core_TimedTextSize; safecall;
    procedure put_Extent(value: Core_TimedTextSize); safecall;
    function get_Background: Color; safecall;
    procedure put_Background(value: Color); safecall;
    function get_WritingMode: Core_TimedTextWritingMode; safecall;
    procedure put_WritingMode(value: Core_TimedTextWritingMode); safecall;
    function get_DisplayAlignment: Core_TimedTextDisplayAlignment; safecall;
    procedure put_DisplayAlignment(value: Core_TimedTextDisplayAlignment); safecall;
    function get_LineHeight: Core_TimedTextDouble; safecall;
    procedure put_LineHeight(value: Core_TimedTextDouble); safecall;
    function get_IsOverflowClipped: Boolean; safecall;
    procedure put_IsOverflowClipped(value: Boolean); safecall;
    function get_Padding: Core_TimedTextPadding; safecall;
    procedure put_Padding(value: Core_TimedTextPadding); safecall;
    function get_TextWrapping: Core_TimedTextWrapping; safecall;
    procedure put_TextWrapping(value: Core_TimedTextWrapping); safecall;
    function get_ZIndex: Integer; safecall;
    procedure put_ZIndex(value: Integer); safecall;
    function get_ScrollMode: Core_TimedTextScrollMode; safecall;
    procedure put_ScrollMode(value: Core_TimedTextScrollMode); safecall;
    property Background: Color read get_Background write put_Background;
    property DisplayAlignment: Core_TimedTextDisplayAlignment read get_DisplayAlignment write put_DisplayAlignment;
    property Extent: Core_TimedTextSize read get_Extent write put_Extent;
    property IsOverflowClipped: Boolean read get_IsOverflowClipped write put_IsOverflowClipped;
    property LineHeight: Core_TimedTextDouble read get_LineHeight write put_LineHeight;
    property Name: HSTRING read get_Name write put_Name;
    property Padding: Core_TimedTextPadding read get_Padding write put_Padding;
    property Position: Core_TimedTextPoint read get_Position write put_Position;
    property ScrollMode: Core_TimedTextScrollMode read get_ScrollMode write put_ScrollMode;
    property TextWrapping: Core_TimedTextWrapping read get_TextWrapping write put_TextWrapping;
    property WritingMode: Core_TimedTextWritingMode read get_WritingMode write put_WritingMode;
    property ZIndex: Integer read get_ZIndex write put_ZIndex;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ITimedTextStyle
  [WinRTClassNameAttribute(SCore_TimedTextStyle)]
  Core_ITimedTextStyle = interface(IInspectable)
  ['{1BB2384D-A825-40C2-A7F5-281EAEDF3B55}']
    function get_Name: HSTRING; safecall;
    procedure put_Name(value: HSTRING); safecall;
    function get_FontFamily: HSTRING; safecall;
    procedure put_FontFamily(value: HSTRING); safecall;
    function get_FontSize: Core_TimedTextDouble; safecall;
    procedure put_FontSize(value: Core_TimedTextDouble); safecall;
    function get_FontWeight: Core_TimedTextWeight; safecall;
    procedure put_FontWeight(value: Core_TimedTextWeight); safecall;
    function get_Foreground: Color; safecall;
    procedure put_Foreground(value: Color); safecall;
    function get_Background: Color; safecall;
    procedure put_Background(value: Color); safecall;
    function get_IsBackgroundAlwaysShown: Boolean; safecall;
    procedure put_IsBackgroundAlwaysShown(value: Boolean); safecall;
    function get_FlowDirection: Core_TimedTextFlowDirection; safecall;
    procedure put_FlowDirection(value: Core_TimedTextFlowDirection); safecall;
    function get_LineAlignment: Core_TimedTextLineAlignment; safecall;
    procedure put_LineAlignment(value: Core_TimedTextLineAlignment); safecall;
    function get_OutlineColor: Color; safecall;
    procedure put_OutlineColor(value: Color); safecall;
    function get_OutlineThickness: Core_TimedTextDouble; safecall;
    procedure put_OutlineThickness(value: Core_TimedTextDouble); safecall;
    function get_OutlineRadius: Core_TimedTextDouble; safecall;
    procedure put_OutlineRadius(value: Core_TimedTextDouble); safecall;
    property Background: Color read get_Background write put_Background;
    property FlowDirection: Core_TimedTextFlowDirection read get_FlowDirection write put_FlowDirection;
    property FontFamily: HSTRING read get_FontFamily write put_FontFamily;
    property FontSize: Core_TimedTextDouble read get_FontSize write put_FontSize;
    property FontWeight: Core_TimedTextWeight read get_FontWeight write put_FontWeight;
    property Foreground: Color read get_Foreground write put_Foreground;
    property IsBackgroundAlwaysShown: Boolean read get_IsBackgroundAlwaysShown write put_IsBackgroundAlwaysShown;
    property LineAlignment: Core_TimedTextLineAlignment read get_LineAlignment write put_LineAlignment;
    property Name: HSTRING read get_Name write put_Name;
    property OutlineColor: Color read get_OutlineColor write put_OutlineColor;
    property OutlineRadius: Core_TimedTextDouble read get_OutlineRadius write put_OutlineRadius;
    property OutlineThickness: Core_TimedTextDouble read get_OutlineThickness write put_OutlineThickness;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ITimedTextSubformat
  [WinRTClassNameAttribute(SCore_TimedTextSubformat)]
  Core_ITimedTextSubformat = interface(IInspectable)
  ['{D713502F-3261-4722-A0C2-B937B2390F14}']
    function get_StartIndex: Integer; safecall;
    procedure put_StartIndex(value: Integer); safecall;
    function get_Length: Integer; safecall;
    procedure put_Length(value: Integer); safecall;
    function get_SubformatStyle: Core_ITimedTextStyle; safecall;
    procedure put_SubformatStyle(value: Core_ITimedTextStyle); safecall;
    property Length: Integer read get_Length write put_Length;
    property StartIndex: Integer read get_StartIndex write put_StartIndex;
    property SubformatStyle: Core_ITimedTextStyle read get_SubformatStyle write put_SubformatStyle;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.ITimedTextSubformat>
  IIterator_1__Core_ITimedTextSubformat = interface(IInspectable)
  ['{FB4AA4C4-1FC1-50E6-971F-12F37D9559AF}']
    function get_Current: Core_ITimedTextSubformat; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PCore_ITimedTextSubformat): Cardinal; safecall;
    property Current: Core_ITimedTextSubformat read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.ITimedTextSubformat>
  IIterable_1__Core_ITimedTextSubformat_Base = interface(IInspectable)
  ['{CEE3AE43-C93C-56F7-8C55-9024DED72C76}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.ITimedTextSubformat>
  IIterable_1__Core_ITimedTextSubformat = interface(IIterable_1__Core_ITimedTextSubformat_Base)
  ['{38D80C41-06F4-5AF5-9F8D-6039899EF908}']
    function First: IIterator_1__Core_ITimedTextSubformat; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.ITimedTextSubformat>
  IVectorView_1__Core_ITimedTextSubformat = interface(IInspectable)
  ['{000FFD4A-3B93-561C-9AE7-2186172AF5F5}']
    function GetAt(index: Cardinal): Core_ITimedTextSubformat; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Core_ITimedTextSubformat; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_ITimedTextSubformat): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Core.ITimedTextSubformat>
  IVector_1__Core_ITimedTextSubformat = interface(IInspectable)
  ['{D6526EDE-ADE5-5718-BD3E-512256835A37}']
    function GetAt(index: Cardinal): Core_ITimedTextSubformat; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Core_ITimedTextSubformat; safecall;
    function IndexOf(value: Core_ITimedTextSubformat; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Core_ITimedTextSubformat); safecall;
    procedure InsertAt(index: Cardinal; value: Core_ITimedTextSubformat); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Core_ITimedTextSubformat); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_ITimedTextSubformat): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PCore_ITimedTextSubformat); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ITimedTextLine
  [WinRTClassNameAttribute(SCore_TimedTextLine)]
  Core_ITimedTextLine = interface(IInspectable)
  ['{978D7CE2-7308-4C66-BE50-65777289F5DF}']
    function get_Text: HSTRING; safecall;
    procedure put_Text(value: HSTRING); safecall;
    function get_Subformats: IVector_1__Core_ITimedTextSubformat; safecall;
    property Subformats: IVector_1__Core_ITimedTextSubformat read get_Subformats;
    property Text: HSTRING read get_Text write put_Text;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Core.ITimedTextLine>
  IIterator_1__Core_ITimedTextLine = interface(IInspectable)
  ['{F22C67D8-62B7-50F0-AB02-79895BC4EE28}']
    function get_Current: Core_ITimedTextLine; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PCore_ITimedTextLine): Cardinal; safecall;
    property Current: Core_ITimedTextLine read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.ITimedTextLine>
  IIterable_1__Core_ITimedTextLine_Base = interface(IInspectable)
  ['{AEC710AD-3BD8-5A59-AE77-E7FC46FB105B}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Core.ITimedTextLine>
  IIterable_1__Core_ITimedTextLine = interface(IIterable_1__Core_ITimedTextLine_Base)
  ['{4F04DF6F-33BD-548E-AFE2-73CB2ADA8A99}']
    function First: IIterator_1__Core_ITimedTextLine; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.ITimedTextLine>
  IVectorView_1__Core_ITimedTextLine = interface(IInspectable)
  ['{D5191C8C-979C-5E6A-ADA3-0F484DBB2ECC}']
    function GetAt(index: Cardinal): Core_ITimedTextLine; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Core_ITimedTextLine; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_ITimedTextLine): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Core.ITimedTextLine>
  IVector_1__Core_ITimedTextLine = interface(IInspectable)
  ['{702EA02E-ADF3-5F5A-B2B7-1259E6884874}']
    function GetAt(index: Cardinal): Core_ITimedTextLine; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Core_ITimedTextLine; safecall;
    function IndexOf(value: Core_ITimedTextLine; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Core_ITimedTextLine); safecall;
    procedure InsertAt(index: Cardinal; value: Core_ITimedTextLine); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Core_ITimedTextLine); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PCore_ITimedTextLine): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PCore_ITimedTextLine); safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ITimedTextCue
  [WinRTClassNameAttribute(SCore_TimedTextCue)]
  Core_ITimedTextCue = interface(IInspectable)
  ['{51C79E51-3B86-494D-B359-BB2EA7ACA9A9}']
    function get_CueRegion: Core_ITimedTextRegion; safecall;
    procedure put_CueRegion(value: Core_ITimedTextRegion); safecall;
    function get_CueStyle: Core_ITimedTextStyle; safecall;
    procedure put_CueStyle(value: Core_ITimedTextStyle); safecall;
    function get_Lines: IVector_1__Core_ITimedTextLine; safecall;
    property CueRegion: Core_ITimedTextRegion read get_CueRegion write put_CueRegion;
    property CueStyle: Core_ITimedTextStyle read get_CueStyle write put_CueStyle;
    property Lines: IVector_1__Core_ITimedTextLine read get_Lines;
  end;

  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Core.ISingleSelectMediaTrackList,Object>
  TypedEventHandler_2__Core_ISingleSelectMediaTrackList__IInspectable = interface(IUnknown)
  ['{21EB6E39-728A-56A9-8DCE-062BA4C81BF5}']
    procedure Invoke(sender: Core_ISingleSelectMediaTrackList; args: IInspectable); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ISingleSelectMediaTrackList
  Core_ISingleSelectMediaTrackList = interface(IInspectable)
  ['{77206F1F-C34F-494F-8077-2BAD9FF4ECF1}']
    function add_SelectedIndexChanged(handler: TypedEventHandler_2__Core_ISingleSelectMediaTrackList__IInspectable): EventRegistrationToken; safecall;
    procedure remove_SelectedIndexChanged(token: EventRegistrationToken); safecall;
    procedure put_SelectedIndex(value: Integer); safecall;
    function get_SelectedIndex: Integer; safecall;
    property SelectedIndex: Integer read get_SelectedIndex write put_SelectedIndex;
  end;

  // DualAPI Interface
  // Windows.Media.Core.IDataCue
  [WinRTClassNameAttribute(SCore_DataCue)]
  Core_IDataCue = interface(IInspectable)
  ['{7C7F676D-1FBC-4E2D-9A87-EE38BD1DC637}']
    procedure put_Data(value: IBuffer); safecall;
    function get_Data: IBuffer; safecall;
    property Data: IBuffer read get_Data write put_Data;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ITimedMetadataTrackFactory
  [WinRTClassNameAttribute(SCore_TimedMetadataTrack)]
  Core_ITimedMetadataTrackFactory = interface(IInspectable)
  ['{8DD57611-97B3-4E1F-852C-0F482C81AD26}']
    function Create(id: HSTRING; language: HSTRING; kind: Core_TimedMetadataKind): Core_ITimedMetadataTrack; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Core.ITimedTextSourceStatics
  [WinRTClassNameAttribute(SCore_TimedTextSource)]
  Core_ITimedTextSourceStatics = interface(IInspectable)
  ['{7E311853-9ABA-4AC4-BB98-2FB176C3BFDD}']
    function CreateFromStream(stream: IRandomAccessStream): Core_ITimedTextSource; overload; safecall;
    function CreateFromUri(uri: IUriRuntimeClass): Core_ITimedTextSource; overload; safecall;
    function CreateFromStream(stream: IRandomAccessStream; defaultLanguage: HSTRING): Core_ITimedTextSource; overload; safecall;
    function CreateFromUri(uri: IUriRuntimeClass; defaultLanguage: HSTRING): Core_ITimedTextSource; overload; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Playback.IMediaPlaybackItemFactory
  [WinRTClassNameAttribute(SPlayback_MediaPlaybackItem)]
  Playback_IMediaPlaybackItemFactory = interface(IInspectable)
  ['{7133FCE1-1769-4FF9-A7C1-38D2C4D42360}']
    function Create(source: Core_IMediaSource2): Playback_IMediaPlaybackItem; safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Playback.IMediaPlaybackItemError
  [WinRTClassNameAttribute(SPlayback_MediaPlaybackItemError)]
  Playback_IMediaPlaybackItemError = interface(IInspectable)
  ['{69FBEF2B-DCD6-4DF9-A450-DBF4C6F1C2C2}']
    function get_ErrorCode: Playback_MediaPlaybackItemErrorCode; safecall;
    function get_ExtendedError: HRESULT; safecall;
    property ErrorCode: Playback_MediaPlaybackItemErrorCode read get_ErrorCode;
    property ExtendedError: HRESULT read get_ExtendedError;
  end;

  // Windows.Media.Playback.IMediaEnginePlaybackSource
  Playback_IMediaEnginePlaybackSource = interface(IInspectable)
  ['{5C1D0BA7-3856-48B9-8DC6-244BF107BF8C}']
    function get_CurrentItem: Playback_IMediaPlaybackItem; safecall;
    procedure SetPlaybackSource(source: Playback_IMediaPlaybackSource); safecall;
    property CurrentItem: Playback_IMediaPlaybackItem read get_CurrentItem;
  end;

  // DualAPI Interface
  // Windows.Media.Playback.IMediaPlaybackItemOpenedEventArgs
  [WinRTClassNameAttribute(SPlayback_MediaPlaybackItemOpenedEventArgs)]
  Playback_IMediaPlaybackItemOpenedEventArgs = interface(IInspectable)
  ['{CBD9BD82-3037-4FBE-AE8F-39FC39EDF4EF}']
    function get_Item: Playback_IMediaPlaybackItem; safecall;
    property Item: Playback_IMediaPlaybackItem read get_Item;
  end;

  // DualAPI Interface
  // Windows.Media.Playback.IMediaPlaybackItemFailedEventArgs
  [WinRTClassNameAttribute(SPlayback_MediaPlaybackItemFailedEventArgs)]
  Playback_IMediaPlaybackItemFailedEventArgs = interface(IInspectable)
  ['{7703134A-E9A7-47C3-862C-C656D30683D4}']
    function get_Item: Playback_IMediaPlaybackItem; safecall;
    function get_Error: Playback_IMediaPlaybackItemError; safecall;
    property Error: Playback_IMediaPlaybackItemError read get_Error;
    property Item: Playback_IMediaPlaybackItem read get_Item;
  end;

  // DualAPI Interface
  // Windows.Media.Playback.ICurrentMediaPlaybackItemChangedEventArgs
  [WinRTClassNameAttribute(SPlayback_CurrentMediaPlaybackItemChangedEventArgs)]
  Playback_ICurrentMediaPlaybackItemChangedEventArgs = interface(IInspectable)
  ['{1743A892-5C43-4A15-967A-572D2D0F26C6}']
    function get_NewItem: Playback_IMediaPlaybackItem; safecall;
    function get_OldItem: Playback_IMediaPlaybackItem; safecall;
    property NewItem: Playback_IMediaPlaybackItem read get_NewItem;
    property OldItem: Playback_IMediaPlaybackItem read get_OldItem;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Playback.IMediaPlaybackList,Windows.Media.Playback.IMediaPlaybackItemFailedEventArgs>
  TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_IMediaPlaybackItemFailedEventArgs_Delegate_Base = interface(IUnknown)
  ['{23319E7D-34B1-57B7-97E5-844948BA4719}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Playback.IMediaPlaybackList,Windows.Media.Playback.IMediaPlaybackItemFailedEventArgs>
  TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_IMediaPlaybackItemFailedEventArgs = interface(TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_IMediaPlaybackItemFailedEventArgs_Delegate_Base)
  ['{1F76DC5C-1C50-5B41-BB8E-8D5484D21BFC}']
    procedure Invoke(sender: Playback_IMediaPlaybackList; args: Playback_IMediaPlaybackItemFailedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Playback.IMediaPlaybackList,Windows.Media.Playback.ICurrentMediaPlaybackItemChangedEventArgs>
  TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_ICurrentMediaPlaybackItemChangedEventArgs_Delegate_Base = interface(IUnknown)
  ['{404C5F9D-250D-5F8C-9627-6B4105C32D09}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Playback.IMediaPlaybackList,Windows.Media.Playback.ICurrentMediaPlaybackItemChangedEventArgs>
  TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_ICurrentMediaPlaybackItemChangedEventArgs = interface(TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_ICurrentMediaPlaybackItemChangedEventArgs_Delegate_Base)
  ['{72062F95-CEC4-5AB6-B38E-DCA1F7E0AFAD}']
    procedure Invoke(sender: Playback_IMediaPlaybackList; args: Playback_ICurrentMediaPlaybackItemChangedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Playback.IMediaPlaybackList,Windows.Media.Playback.IMediaPlaybackItemOpenedEventArgs>
  TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_IMediaPlaybackItemOpenedEventArgs_Delegate_Base = interface(IUnknown)
  ['{6732BBEF-3311-5F83-9C9D-82A5CF3CD82A}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.Media.Playback.IMediaPlaybackList,Windows.Media.Playback.IMediaPlaybackItemOpenedEventArgs>
  TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_IMediaPlaybackItemOpenedEventArgs = interface(TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_IMediaPlaybackItemOpenedEventArgs_Delegate_Base)
  ['{885F3922-DD52-5541-BE52-D6EECEED6876}']
    procedure Invoke(sender: Playback_IMediaPlaybackList; args: Playback_IMediaPlaybackItemOpenedEventArgs); safecall;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.Media.Playback.IMediaPlaybackItem>
  IIterator_1__Playback_IMediaPlaybackItem = interface(IInspectable)
  ['{A907ECB0-09C8-5486-914B-5FF26F18201A}']
    function get_Current: Playback_IMediaPlaybackItem; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PPlayback_IMediaPlaybackItem): Cardinal; safecall;
    property Current: Playback_IMediaPlaybackItem read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Playback.IMediaPlaybackItem>
  IIterable_1__Playback_IMediaPlaybackItem_Base = interface(IInspectable)
  ['{8B8AB4A4-0253-56E9-A232-94E335AEFA8F}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.Media.Playback.IMediaPlaybackItem>
  IIterable_1__Playback_IMediaPlaybackItem = interface(IIterable_1__Playback_IMediaPlaybackItem_Base)
  ['{C6A18D55-5131-5BB3-8E5D-13B6412B951F}']
    function First: IIterator_1__Playback_IMediaPlaybackItem; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.Media.Playback.IMediaPlaybackItem>
  IVectorView_1__Playback_IMediaPlaybackItem = interface(IInspectable)
  ['{8C2857DE-FC0E-55E9-AD49-247B154BBBE0}']
    function GetAt(index: Cardinal): Playback_IMediaPlaybackItem; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: Playback_IMediaPlaybackItem; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PPlayback_IMediaPlaybackItem): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.Media.Playback.IMediaPlaybackItem>
  IVector_1__Playback_IMediaPlaybackItem = interface(IInspectable)
  ['{55C2EF00-81DA-55D1-8A4A-57146FA8F06E}']
    function GetAt(index: Cardinal): Playback_IMediaPlaybackItem; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__Playback_IMediaPlaybackItem; safecall;
    function IndexOf(value: Playback_IMediaPlaybackItem; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: Playback_IMediaPlaybackItem); safecall;
    procedure InsertAt(index: Cardinal; value: Playback_IMediaPlaybackItem); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: Playback_IMediaPlaybackItem); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PPlayback_IMediaPlaybackItem): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PPlayback_IMediaPlaybackItem); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Generic Delegate for 
  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.Media.Playback.IMediaPlaybackItem>
  VectorChangedEventHandler_1__Playback_IMediaPlaybackItem_Delegate_Base = interface(IUnknown)
  ['{891BDDDE-6BF3-5D1F-80AB-5A342A16A0BB}']
  end;
  // Windows.Foundation.Collections.VectorChangedEventHandler`1<Windows.Media.Playback.IMediaPlaybackItem>
  VectorChangedEventHandler_1__Playback_IMediaPlaybackItem = interface(VectorChangedEventHandler_1__Playback_IMediaPlaybackItem_Delegate_Base)
  ['{F8775AF8-7117-526E-9A5A-253D61782515}']
    procedure Invoke(sender: IObservableVector_1__Playback_IMediaPlaybackItem; event: IVectorChangedEventArgs); safecall;
  end;

  // Windows.Foundation.Collections.IObservableVector`1<Windows.Media.Playback.IMediaPlaybackItem>
  IObservableVector_1__Playback_IMediaPlaybackItem = interface(IInspectable)
  ['{12101F97-44F6-51BF-A04B-DFAE83A2BD3D}']
    function add_VectorChanged(vhnd: VectorChangedEventHandler_1__Playback_IMediaPlaybackItem): EventRegistrationToken; safecall;
    procedure remove_VectorChanged(token: EventRegistrationToken); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Playback.IMediaPlaybackList
  [WinRTClassNameAttribute(SPlayback_MediaPlaybackList)]
  Playback_IMediaPlaybackList = interface(IInspectable)
  ['{7F77EE9C-DC42-4E26-A98D-7850DF8EC925}']
    function add_ItemFailed(handler: TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_IMediaPlaybackItemFailedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ItemFailed(token: EventRegistrationToken); safecall;
    function add_CurrentItemChanged(handler: TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_ICurrentMediaPlaybackItemChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_CurrentItemChanged(token: EventRegistrationToken); safecall;
    function add_ItemOpened(handler: TypedEventHandler_2__Playback_IMediaPlaybackList__Playback_IMediaPlaybackItemOpenedEventArgs): EventRegistrationToken; safecall;
    procedure remove_ItemOpened(token: EventRegistrationToken); safecall;
    function get_Items: IObservableVector_1__Playback_IMediaPlaybackItem; safecall;
    function get_AutoRepeatEnabled: Boolean; safecall;
    procedure put_AutoRepeatEnabled(value: Boolean); safecall;
    function get_ShuffleEnabled: Boolean; safecall;
    procedure put_ShuffleEnabled(value: Boolean); safecall;
    function get_CurrentItem: Playback_IMediaPlaybackItem; safecall;
    function get_CurrentItemIndex: Cardinal; safecall;
    function MoveNext: Playback_IMediaPlaybackItem; safecall;
    function MovePrevious: Playback_IMediaPlaybackItem; safecall;
    function MoveTo(itemIndex: Cardinal): Playback_IMediaPlaybackItem; safecall;
    property AutoRepeatEnabled: Boolean read get_AutoRepeatEnabled write put_AutoRepeatEnabled;
    property CurrentItem: Playback_IMediaPlaybackItem read get_CurrentItem;
    property CurrentItemIndex: Cardinal read get_CurrentItemIndex;
    property Items: IObservableVector_1__Playback_IMediaPlaybackItem read get_Items;
    property ShuffleEnabled: Boolean read get_ShuffleEnabled write put_ShuffleEnabled;
  end;

  // DualAPI Interface
  // Windows.Media.Playback.ITimedMetadataPresentationModeChangedEventArgs
  [WinRTClassNameAttribute(SPlayback_TimedMetadataPresentationModeChangedEventArgs)]
  Playback_ITimedMetadataPresentationModeChangedEventArgs = interface(IInspectable)
  ['{D1636099-65DF-45AE-8CEF-DC0B53FDC2BB}']
    function get_Track: Core_ITimedMetadataTrack; safecall;
    function get_OldPresentationMode: Playback_TimedMetadataTrackPresentationMode; safecall;
    function get_NewPresentationMode: Playback_TimedMetadataTrackPresentationMode; safecall;
    property NewPresentationMode: Playback_TimedMetadataTrackPresentationMode read get_NewPresentationMode;
    property OldPresentationMode: Playback_TimedMetadataTrackPresentationMode read get_OldPresentationMode;
    property Track: Core_ITimedMetadataTrack read get_Track;
  end;

  // Windows.Foundation.TypedEventHandler`2<Windows.Foundation.Collections.IVectorView`1<Windows.Media.Core.ITimedMetadataTrack>,Windows.Media.Playback.ITimedMetadataPresentationModeChangedEventArgs>
  TypedEventHandler_2__IVectorView_1__Core_ITimedMetadataTrack__Playback_ITimedMetadataPresentationModeChangedEventArgs = interface(IUnknown)
  ['{ED0CA484-0D2F-551E-BD0D-418D534C1A30}']
    procedure Invoke(sender: IVectorView_1__Core_ITimedMetadataTrack; args: Playback_ITimedMetadataPresentationModeChangedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.Media.Playback.IMediaPlaybackTimedMetadataTrackList
  [WinRTClassNameAttribute(SPlayback_MediaPlaybackTimedMetadataTrackList)]
  Playback_IMediaPlaybackTimedMetadataTrackList = interface(IInspectable)
  ['{72B41319-BBFB-46A3-9372-9C9C744B9438}']
    function add_PresentationModeChanged(handler: TypedEventHandler_2__IVectorView_1__Core_ITimedMetadataTrack__Playback_ITimedMetadataPresentationModeChangedEventArgs): EventRegistrationToken; safecall;
    procedure remove_PresentationModeChanged(token: EventRegistrationToken); safecall;
    function GetPresentationMode(index: Cardinal): Playback_TimedMetadataTrackPresentationMode; safecall;
    procedure SetPresentationMode(index: Cardinal; value: Playback_TimedMetadataTrackPresentationMode); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.ContentRestrictions.ContentAccessRestrictionLevel>
  AsyncOperationCompletedHandler_1__ContentRestrictions_ContentAccessRestrictionLevel_Delegate_Base = interface(IUnknown)
  ['{CF61BE5D-40C3-5484-846A-3F82B8BA5738}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.ContentRestrictions.ContentAccessRestrictionLevel>
  AsyncOperationCompletedHandler_1__ContentRestrictions_ContentAccessRestrictionLevel = interface(AsyncOperationCompletedHandler_1__ContentRestrictions_ContentAccessRestrictionLevel_Delegate_Base)
  ['{E08EC1E0-E4AE-55A1-9A15-180859E0FA0F}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__ContentRestrictions_ContentAccessRestrictionLevel; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.ContentRestrictions.ContentAccessRestrictionLevel>
  IAsyncOperation_1__ContentRestrictions_ContentAccessRestrictionLevel_Base = interface(IInspectable)
  ['{860C0179-BE01-546D-A9CE-5956464C98AB}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.ContentRestrictions.ContentAccessRestrictionLevel>
  IAsyncOperation_1__ContentRestrictions_ContentAccessRestrictionLevel = interface(IAsyncOperation_1__ContentRestrictions_ContentAccessRestrictionLevel_Base)
  ['{CA76FC11-A2C1-513E-B837-B4E39C42DC6B}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__ContentRestrictions_ContentAccessRestrictionLevel); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__ContentRestrictions_ContentAccessRestrictionLevel; safecall;
    function GetResults: ContentRestrictions_ContentAccessRestrictionLevel; safecall;
    property Completed: AsyncOperationCompletedHandler_1__ContentRestrictions_ContentAccessRestrictionLevel read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Playlists.IPlaylist
  [WinRTClassNameAttribute(SPlaylists_Playlist)]
  Playlists_IPlaylist = interface(IInspectable)
  ['{803736F5-CF44-4D97-83B3-7A089E9AB663}']
    function get_Files: IVector_1__IStorageFile; safecall;
    function SaveAsync: IAsyncAction; safecall;
    function SaveAsAsync(saveLocation: IStorageFolder; desiredName: HSTRING; option: NameCollisionOption): IAsyncOperation_1__IStorageFile; overload; safecall;
    function SaveAsAsync(saveLocation: IStorageFolder; desiredName: HSTRING; option: NameCollisionOption; playlistFormat: Playlists_PlaylistFormat): IAsyncOperation_1__IStorageFile; overload; safecall;
    property Files: IVector_1__IStorageFile read get_Files;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Playlists.IPlaylist>
  AsyncOperationCompletedHandler_1__Playlists_IPlaylist_Delegate_Base = interface(IUnknown)
  ['{427DEAFD-B226-5EF0-9320-C9F325E37474}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Media.Playlists.IPlaylist>
  AsyncOperationCompletedHandler_1__Playlists_IPlaylist = interface(AsyncOperationCompletedHandler_1__Playlists_IPlaylist_Delegate_Base)
  ['{A338C60F-5A0B-5A14-8945-FDD290DE1AB4}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__Playlists_IPlaylist; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Playlists.IPlaylist>
  IAsyncOperation_1__Playlists_IPlaylist_Base = interface(IInspectable)
  ['{8FFB74AB-912F-5BC1-87FA-2865F673CBFC}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Media.Playlists.IPlaylist>
  IAsyncOperation_1__Playlists_IPlaylist = interface(IAsyncOperation_1__Playlists_IPlaylist_Base)
  ['{C690486C-69A0-5A12-8E73-70F3B0FB6D4A}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__Playlists_IPlaylist); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__Playlists_IPlaylist; safecall;
    function GetResults: Playlists_IPlaylist; safecall;
    property Completed: AsyncOperationCompletedHandler_1__Playlists_IPlaylist read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.Media.Playlists.IPlaylistStatics
  [WinRTClassNameAttribute(SPlaylists_Playlist)]
  Playlists_IPlaylistStatics = interface(IInspectable)
  ['{C5C331CD-81F9-4FF3-95B9-70B6FF046B68}']
    function LoadAsync(&file: IStorageFile): IAsyncOperation_1__Playlists_IPlaylist; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Media.Protection.RenewalStatus,UInt32>
  AsyncOperationProgressHandler_2__Protection_RenewalStatus__Cardinal_Delegate_Base = interface(IUnknown)
  ['{B9DA4AA0-26E0-5D69-A0C8-05716A406235}']
  end;
  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.Media.Protection.RenewalStatus,UInt32>
  AsyncOperationProgressHandler_2__Protection_RenewalStatus__Cardinal = interface(AsyncOperationProgressHandler_2__Protection_RenewalStatus__Cardinal_Delegate_Base)
  ['{C4BFC97F-A590-5D41-85C8-4536F00C4015}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__Protection_RenewalStatus__Cardinal; progressInfo: Cardinal); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Media.Protection.RenewalStatus,UInt32>
  AsyncOperationWithProgressCompletedHandler_2__Protection_RenewalStatus__Cardinal_Delegate_Base = interface(IUnknown)
  ['{EC067827-67D9-59A6-A57B-3E7CA12B89C1}']
  end;
  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.Media.Protection.RenewalStatus,UInt32>
  AsyncOperationWithProgressCompletedHandler_2__Protection_RenewalStatus__Cardinal = interface(AsyncOperationWithProgressCompletedHandler_2__Protection_RenewalStatus__Cardinal_Delegate_Base)
  ['{F0E33274-09BD-5C11-BFAC-D3B438553737}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__Protection_RenewalStatus__Cardinal; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.Media.Protection.RenewalStatus,UInt32>
  IAsyncOperationWithProgress_2__Protection_RenewalStatus__Cardinal = interface(IInspectable)
  ['{85794F43-57E4-5D0C-B938-F23F36650C5E}']
    procedure put_Progress(handler: AsyncOperationProgressHandler_2__Protection_RenewalStatus__Cardinal); safecall;
    function get_Progress: AsyncOperationProgressHandler_2__Protection_RenewalStatus__Cardinal; safecall;
    procedure put_Completed(handler: AsyncOperationWithProgressCompletedHandler_2__Protection_RenewalStatus__Cardinal); safecall;
    function get_Completed: AsyncOperationWithProgressCompletedHandler_2__Protection_RenewalStatus__Cardinal; safecall;
    function GetResults: Protection_RenewalStatus; safecall;
    property Progress: AsyncOperationProgressHandler_2__Protection_RenewalStatus__Cardinal read get_Progress write put_Progress;
    property Completed: AsyncOperationWithProgressCompletedHandler_2__Protection_RenewalStatus__Cardinal read get_Completed write put_Completed;
  end;


  // Emit Forwarded classes
  // Windows.Media.VideoFrame
  // DualAPI
  TVideoFrame = class(TWinRTGenericImportF<IVideoFrameFactory>)
  public
    // -> IVideoFrameFactory
    class function Create(format: Imaging_BitmapPixelFormat; width: Integer; height: Integer): IVideoFrame; static; inline;
    class function CreateWithAlpha(format: Imaging_BitmapPixelFormat; width: Integer; height: Integer; alpha: Imaging_BitmapAlphaMode): IVideoFrame; static; inline;
  end;

  // Windows.Media.AudioBuffer
  // DualAPI

  // Windows.Media.AudioFrame
  // DualAPI
  TAudioFrame = class(TWinRTGenericImportF<IAudioFrameFactory>)
  public
    // -> IAudioFrameFactory
    class function Create(capacity: Cardinal): IAudioFrame; static; inline;
  end;

  // Windows.Media.Audio.AudioGraph
  // DualAPI
  TAudio_AudioGraph = class(TWinRTGenericImportS<Audio_IAudioGraphStatics>)
  public
    // -> Audio_IAudioGraphStatics
    class function CreateAsync(settings: Audio_IAudioGraphSettings): IAsyncOperation_1__Audio_ICreateAudioGraphResult; static; inline;
  end;

  // Windows.Media.Audio.CreateAudioGraphResult
  // DualAPI

  // Windows.Media.Audio.AudioGraphSettings
  // DualAPI
  TAudio_AudioGraphSettings = class(TWinRTGenericImportF<Audio_IAudioGraphSettingsFactory>)
  public
    // -> Audio_IAudioGraphSettingsFactory
    class function Create(audioRenderCategory: Render_AudioRenderCategory): Audio_IAudioGraphSettings; static; inline;
  end;

  // Windows.Media.Audio.AudioDeviceInputNode
  // DualAPI

  // Windows.Media.Audio.CreateAudioDeviceInputNodeResult
  // DualAPI

  // Windows.Media.Audio.AudioDeviceOutputNode
  // DualAPI

  // Windows.Media.Audio.CreateAudioDeviceOutputNodeResult
  // DualAPI

  // Windows.Media.Audio.AudioFileInputNode
  // DualAPI

  // Windows.Media.Audio.CreateAudioFileInputNodeResult
  // DualAPI

  // Windows.Media.Audio.AudioFileOutputNode
  // DualAPI

  // Windows.Media.Audio.CreateAudioFileOutputNodeResult
  // DualAPI

  // Windows.Media.Audio.AudioGraphUnrecoverableErrorOccurredEventArgs
  // DualAPI

  // Windows.Media.Audio.AudioFrameInputNode
  // DualAPI

  // Windows.Media.Audio.AudioFrameOutputNode
  // DualAPI

  // Windows.Media.Audio.AudioSubmixNode
  // DualAPI

  // Windows.Media.Audio.AudioGraphConnection
  // DualAPI

  // Windows.Media.Audio.AudioFrameCompletedEventArgs
  // DualAPI

  // Windows.Media.Audio.FrameInputNodeQuantumStartedEventArgs
  // DualAPI

  // Windows.Media.Audio.EqualizerBand
  // DualAPI

  // Windows.Media.Audio.EqualizerEffectDefinition
  // DualAPI
  TAudio_EqualizerEffectDefinition = class(TWinRTGenericImportF<Audio_IEqualizerEffectDefinitionFactory>)
  public
    // -> Audio_IEqualizerEffectDefinitionFactory
    class function Create(audioGraph: Audio_IAudioGraph): Audio_IEqualizerEffectDefinition; static; inline;
  end;

  // Windows.Media.Audio.ReverbEffectDefinition
  // DualAPI
  TAudio_ReverbEffectDefinition = class(TWinRTGenericImportF<Audio_IReverbEffectDefinitionFactory>)
  public
    // -> Audio_IReverbEffectDefinitionFactory
    class function Create(audioGraph: Audio_IAudioGraph): Audio_IReverbEffectDefinition; static; inline;
  end;

  // Windows.Media.Audio.EchoEffectDefinition
  // DualAPI
  TAudio_EchoEffectDefinition = class(TWinRTGenericImportF<Audio_IEchoEffectDefinitionFactory>)
  public
    // -> Audio_IEchoEffectDefinitionFactory
    class function Create(audioGraph: Audio_IAudioGraph): Audio_IEchoEffectDefinition; static; inline;
  end;

  // Windows.Media.Audio.LimiterEffectDefinition
  // DualAPI
  TAudio_LimiterEffectDefinition = class(TWinRTGenericImportF<Audio_ILimiterEffectDefinitionFactory>)
  public
    // -> Audio_ILimiterEffectDefinitionFactory
    class function Create(audioGraph: Audio_IAudioGraph): Audio_ILimiterEffectDefinition; static; inline;
  end;

  // Windows.Media.Casting.CastingSource
  // DualAPI

  // Windows.Media.Casting.CastingConnectionErrorOccurredEventArgs
  // DualAPI

  // Windows.Media.Casting.CastingDevice
  // DualAPI
  TCasting_CastingDevice = class(TWinRTGenericImportS<Casting_ICastingDeviceStatics>)
  public
    // -> Casting_ICastingDeviceStatics
    class function GetDeviceSelector(&type: Casting_CastingPlaybackTypes): HSTRING; static; inline;
    class function GetDeviceSelectorFromCastingSourceAsync(castingSource: Casting_ICastingSource): IAsyncOperation_1__HSTRING; static; inline;
    class function FromIdAsync(value: HSTRING): IAsyncOperation_1__Casting_ICastingDevice; static; inline;
    class function DeviceInfoSupportsCastingAsync(device: IDeviceInformation): IAsyncOperation_1__Boolean; static; inline;
  end;

  // Windows.Media.Casting.CastingConnection
  // DualAPI

  // Windows.Media.Casting.CastingDeviceSelectedEventArgs
  // DualAPI

  // Windows.Media.Casting.CastingDevicePickerFilter
  // DualAPI

  // Windows.Media.Casting.CastingDevicePicker
  // DualAPI
  TCasting_CastingDevicePicker = class(TWinRTGenericImportI<Casting_ICastingDevicePicker>) end;

  // Windows.Media.DialProtocol.DialDeviceSelectedEventArgs
  // DualAPI

  // Windows.Media.DialProtocol.DialDisconnectButtonClickedEventArgs
  // DualAPI

  // Windows.Media.DialProtocol.DialDevicePickerFilter
  // DualAPI

  // Windows.Media.DialProtocol.DialDevicePicker
  // DualAPI
  TDialProtocol_DialDevicePicker = class(TWinRTGenericImportI<DialProtocol_IDialDevicePicker>) end;

  // Windows.Media.Effects.VideoCompositorDefinition
  // DualAPI
  TEffects_VideoCompositorDefinition = class(TWinRTGenericImportF<Effects_IVideoCompositorDefinitionFactory>)
  public
    // -> Effects_IVideoCompositorDefinitionFactory
    class function Create(activatableClassId: HSTRING): Effects_IVideoCompositorDefinition; static; inline;
    class function CreateWithProperties(activatableClassId: HSTRING; props: IPropertySet): Effects_IVideoCompositorDefinition; static; inline;
  end;

  // Windows.Media.Editing.MediaOverlay
  // DualAPI
  TEditing_MediaOverlay = class(TWinRTGenericImportF<Editing_IMediaOverlayFactory>)
  public
    // -> Editing_IMediaOverlayFactory
    class function Create(clip: Editing_IMediaClip): Editing_IMediaOverlay; static; inline;
    class function CreateWithPositionAndOpacity(clip: Editing_IMediaClip; position: TRectF; opacity: Double): Editing_IMediaOverlay; static; inline;
  end;

  // Windows.Media.Effects.CompositeVideoFrameContext
  // DualAPI

  // Windows.Media.Editing.MediaClip
  // DualAPI
  TEditing_MediaClip = class(TWinRTGenericImportS2<Editing_IMediaClipStatics, Editing_IMediaClipStatics2>)
  public
    // -> Editing_IMediaClipStatics
    class function CreateFromColor(color: Color; originalDuration: TimeSpan): Editing_IMediaClip; static; inline;
    class function CreateFromFileAsync(&file: IStorageFile): IAsyncOperation_1__Editing_IMediaClip; static; inline;
    class function CreateFromImageFileAsync(&file: IStorageFile; originalDuration: TimeSpan): IAsyncOperation_1__Editing_IMediaClip; static; inline;

    // -> Editing_IMediaClipStatics2
    class function CreateFromSurface(surface: DirectX_Direct3D11_IDirect3DSurface; originalDuration: TimeSpan): Editing_IMediaClip; static; inline;
  end;

  // Windows.Media.Editing.EmbeddedAudioTrack
  // DualAPI

  // Windows.Media.Editing.BackgroundAudioTrack
  // DualAPI
  TEditing_BackgroundAudioTrack = class(TWinRTGenericImportS<Editing_IBackgroundAudioTrackStatics>)
  public
    // -> Editing_IBackgroundAudioTrackStatics
    class function CreateFromEmbeddedAudioTrack(embeddedAudioTrack: Editing_IEmbeddedAudioTrack): Editing_IBackgroundAudioTrack; static; inline;
    class function CreateFromFileAsync(&file: IStorageFile): IAsyncOperation_1__Editing_IBackgroundAudioTrack; static; inline;
  end;

  // Windows.Media.Editing.MediaComposition
  // DualAPI
  TEditing_MediaComposition = class(TWinRTGenericImportSI<Editing_IMediaCompositionStatics, Editing_IMediaComposition>)
  public
    // -> Editing_IMediaCompositionStatics
    class function LoadAsync(&file: IStorageFile): IAsyncOperation_1__Editing_IMediaComposition; static; inline;
  end;

  // Windows.Media.Editing.MediaOverlayLayer
  // DualAPI
  TEditing_MediaOverlayLayer = class(TWinRTGenericImportFI<Editing_IMediaOverlayLayerFactory, Editing_IMediaOverlayLayer>)
  public
    // -> Editing_IMediaOverlayLayerFactory
    class function CreateWithCompositorDefinition(compositorDefinition: Effects_IVideoCompositorDefinition): Editing_IMediaOverlayLayer; static; inline;
  end;

  // Windows.Media.Effects.AudioEffect
  // DualAPI

  // Windows.Media.Import.PhotoImportSource
  // DualAPI
  TImport_PhotoImportSource = class(TWinRTGenericImportS<Import_IPhotoImportSourceStatics>)
  public
    // -> Import_IPhotoImportSourceStatics
    class function FromIdAsync(sourceId: HSTRING): IAsyncOperation_1__Import_IPhotoImportSource; static; inline;
    class function FromFolderAsync(sourceRootFolder: IStorageFolder): IAsyncOperation_1__Import_IPhotoImportSource; static; inline;
  end;

  // Windows.Media.Import.PhotoImportOperation
  // DualAPI

  // Windows.Media.Import.PhotoImportManager
  // DualAPI
  TImport_PhotoImportManager = class(TWinRTGenericImportS<Import_IPhotoImportManagerStatics>)
  public
    // -> Import_IPhotoImportManagerStatics
    class function IsSupportedAsync: IAsyncOperation_1__Boolean; static; inline;
    class function FindAllSourcesAsync: IAsyncOperation_1__IVectorView_1__Import_IPhotoImportSource; static; inline;
    class function GetPendingOperations: IVectorView_1__Import_IPhotoImportOperation; static; inline;
  end;

  // Windows.Media.Import.PhotoImportSession
  // DualAPI

  // Windows.Media.Import.PhotoImportFindItemsResult
  // DualAPI

  // Windows.Media.Import.PhotoImportImportItemsResult
  // DualAPI

  // Windows.Media.Import.PhotoImportDeleteImportedItemsFromSourceResult
  // DualAPI

  // Windows.Media.Import.PhotoImportStorageMedium
  // DualAPI

  // Windows.Media.Import.PhotoImportSidecar
  // DualAPI

  // Windows.Media.Import.PhotoImportVideoSegment
  // DualAPI

  // Windows.Media.Import.PhotoImportItem
  // DualAPI

  // Windows.Media.Import.PhotoImportSelectionChangedEventArgs
  // DualAPI

  // Windows.Media.Import.PhotoImportItemImportedEventArgs
  // DualAPI

  // Windows.Media.Capture.MediaCapture
  // DualAPI
  TCapture_MediaCapture = class(TWinRTGenericImportSI<Capture_IMediaCaptureStatics, Capture_IMediaCapture>)
  public
    // -> Capture_IMediaCaptureStatics
    class function IsVideoProfileSupported(videoDeviceId: HSTRING): Boolean; static; inline;
    class function FindAllVideoProfiles(videoDeviceId: HSTRING): IVectorView_1__Capture_IMediaCaptureVideoProfile; static; inline;
    class function FindConcurrentProfiles(videoDeviceId: HSTRING): IVectorView_1__Capture_IMediaCaptureVideoProfile; static; inline;
    class function FindKnownVideoProfiles(videoDeviceId: HSTRING; name: Capture_KnownVideoProfile): IVectorView_1__Capture_IMediaCaptureVideoProfile; static; inline;
  end;

  // Windows.Media.Capture.MediaCaptureVideoProfileMediaDescription
  // DualAPI

  // Windows.Media.Capture.MediaCaptureVideoProfile
  // DualAPI

  // Windows.Media.Capture.MediaCaptureInitializationSettings
  // DualAPI
  TCapture_MediaCaptureInitializationSettings = class(TWinRTGenericImportI<Capture_IMediaCaptureInitializationSettings>) end;

  // Windows.Media.Capture.MediaCaptureSettings
  // DualAPI

  // Windows.Media.Capture.LowLagMediaRecording
  // DualAPI

  // Windows.Media.Capture.LowLagPhotoCapture
  // DualAPI

  // Windows.Media.Capture.LowLagPhotoSequenceCapture
  // DualAPI

  // Windows.Media.Capture.Core.VariablePhotoSequenceCapture
  // DualAPI

  // Windows.Media.Capture.MediaCaptureFocusChangedEventArgs
  // DualAPI

  // Windows.Media.Capture.PhotoConfirmationCapturedEventArgs
  // DualAPI

  // Windows.Media.Capture.AdvancedPhotoCapture
  // DualAPI

  // Windows.Media.Capture.CapturedPhoto
  // DualAPI

  // Windows.Media.Capture.AdvancedCapturedPhoto
  // DualAPI

  // Windows.Media.Capture.OptionalReferencePhotoCapturedEventArgs
  // DualAPI

  // Windows.Media.Capture.CapturedFrame
  // DualAPI

  // Windows.Media.Capture.PhotoCapturedEventArgs
  // DualAPI

  // Windows.Media.Capture.CapturedFrameControlValues
  // DualAPI

  // Windows.Media.Capture.VideoStreamConfiguration
  // DualAPI

  // Windows.Media.Capture.Core.VariablePhotoCapturedEventArgs
  // DualAPI

  // Windows.Media.VideoEffects
  // DualAPI
  TVideoEffects = class(TWinRTGenericImportS<IVideoEffectsStatics>)
  public
    // -> IVideoEffectsStatics
    class function get_VideoStabilization: HSTRING; static; inline;
    class property VideoStabilization: HSTRING read get_VideoStabilization;
  end;

  // Windows.Media.Effects.VideoEffectDefinition
  // DualAPI
  TEffects_VideoEffectDefinition = class(TWinRTGenericImportF<Effects_IVideoEffectDefinitionFactory>)
  public
    // -> Effects_IVideoEffectDefinitionFactory
    class function Create(activatableClassId: HSTRING): Effects_IVideoEffectDefinition; static; inline;
    class function CreateWithProperties(activatableClassId: HSTRING; props: IPropertySet): Effects_IVideoEffectDefinition; static; inline;
  end;

  // Windows.Media.Effects.AudioEffectDefinition
  // DualAPI
  TEffects_AudioEffectDefinition = class(TWinRTGenericImportF<Effects_IAudioEffectDefinitionFactory>)
  public
    // -> Effects_IAudioEffectDefinitionFactory
    class function Create(activatableClassId: HSTRING): Effects_IAudioEffectDefinition; static; inline;
    class function CreateWithProperties(activatableClassId: HSTRING; props: IPropertySet): Effects_IAudioEffectDefinition; static; inline;
  end;

  // Windows.Media.Effects.ProcessVideoFrameContext
  // DualAPI

  // Windows.Media.Effects.ProcessAudioFrameContext
  // DualAPI

  // Windows.Media.Effects.VideoTransformEffectDefinition
  // DualAPI
  TEffects_VideoTransformEffectDefinition = class(TWinRTGenericImportI<Effects_IVideoTransformEffectDefinition>) end;

  // Windows.Media.Protection.MediaProtectionPMPServer
  // DualAPI
  TProtection_MediaProtectionPMPServer = class(TWinRTGenericImportF<Protection_IMediaProtectionPMPServerFactory>)
  public
    // -> Protection_IMediaProtectionPMPServerFactory
    class function CreatePMPServer(pProperties: IPropertySet): Protection_IMediaProtectionPMPServer; static; inline;
  end;

  // Windows.Media.Playback.MediaPlaybackItem
  // DualAPI
  TPlayback_MediaPlaybackItem = class(TWinRTGenericImportF<Playback_IMediaPlaybackItemFactory>)
  public
    // -> Playback_IMediaPlaybackItemFactory
    class function Create(source: Core_IMediaSource2): Playback_IMediaPlaybackItem; static; inline;
  end;

  // Windows.Media.Core.AudioStreamDescriptor
  // DualAPI
  TCore_AudioStreamDescriptor = class(TWinRTGenericImportF<Core_IAudioStreamDescriptorFactory>)
  public
    // -> Core_IAudioStreamDescriptorFactory
    class function Create(encodingProperties: IAudioEncodingProperties): Core_IAudioStreamDescriptor; static; inline;
  end;

  // Windows.Media.Core.VideoStreamDescriptor
  // DualAPI
  TCore_VideoStreamDescriptor = class(TWinRTGenericImportF<Core_IVideoStreamDescriptorFactory>)
  public
    // -> Core_IVideoStreamDescriptorFactory
    class function Create(encodingProperties: IVideoEncodingProperties): Core_IVideoStreamDescriptor; static; inline;
  end;

  // Windows.Media.Core.MediaStreamSource
  // DualAPI
  TCore_MediaStreamSource = class(TWinRTGenericImportF<Core_IMediaStreamSourceFactory>)
  public
    // -> Core_IMediaStreamSourceFactory
    class function CreateFromDescriptor(descriptor: Core_IMediaStreamDescriptor): Core_IMediaStreamSource; static; inline;
    class function CreateFromDescriptors(descriptor: Core_IMediaStreamDescriptor; descriptor2: Core_IMediaStreamDescriptor): Core_IMediaStreamSource; static; inline;
  end;

  // Windows.Media.Core.MediaStreamSourceClosedEventArgs
  // DualAPI

  // Windows.Media.Core.MediaStreamSourceStartingEventArgs
  // DualAPI

  // Windows.Media.Core.MediaStreamSourceSampleRequestedEventArgs
  // DualAPI

  // Windows.Media.Core.MediaStreamSourceSwitchStreamsRequestedEventArgs
  // DualAPI

  // Windows.Media.Core.MediaStreamSamplePropertySet
  // DualAPI

  // Windows.Media.Core.MediaStreamSample
  // DualAPI
  TCore_MediaStreamSample = class(TWinRTGenericImportS<Core_IMediaStreamSampleStatics>)
  public
    // -> Core_IMediaStreamSampleStatics
    class function CreateFromBuffer(buffer: IBuffer; timestamp: TimeSpan): Core_IMediaStreamSample; static; inline;
    class function CreateFromStreamAsync(stream: IInputStream; count: Cardinal; timestamp: TimeSpan): IAsyncOperation_1__Core_IMediaStreamSample; static; inline;
  end;

  // Windows.Media.Core.MediaStreamSampleProtectionProperties
  // DualAPI

  // Windows.Media.Core.MediaStreamSourceClosedRequest
  // DualAPI

  // Windows.Media.Core.MediaStreamSourceStartingRequestDeferral
  // DualAPI

  // Windows.Media.Core.MediaStreamSourceStartingRequest
  // DualAPI

  // Windows.Media.Core.MediaStreamSourceSampleRequestDeferral
  // DualAPI

  // Windows.Media.Core.MediaStreamSourceSampleRequest
  // DualAPI

  // Windows.Media.Core.MediaStreamSourceSwitchStreamsRequestDeferral
  // DualAPI

  // Windows.Media.Core.MediaStreamSourceSwitchStreamsRequest
  // DualAPI

  // Windows.Media.Core.MseStreamSource
  // DualAPI
  TCore_MseStreamSource = class(TWinRTGenericImportSI<Core_IMseStreamSourceStatics, Core_IMseStreamSource>)
  public
    // -> Core_IMseStreamSourceStatics
    class function IsContentTypeSupported(contentType: HSTRING): Boolean; static; inline;
  end;

  // Windows.Media.Core.MseSourceBufferList
  // DualAPI

  // Windows.Media.Core.MseSourceBuffer
  // DualAPI

  // Windows.Media.Transcoding.PrepareTranscodeResult
  // DualAPI

  // Windows.Media.Transcoding.MediaTranscoder
  // DualAPI
  TTranscoding_MediaTranscoder = class(TWinRTGenericImportI<Transcoding_IMediaTranscoder>) end;

  // Windows.Media.Core.HighDynamicRangeControl
  // DualAPI

  // Windows.Media.Core.SceneAnalysisEffect
  // DualAPI

  // Windows.Media.Core.SceneAnalyzedEventArgs
  // DualAPI

  // Windows.Media.Core.HighDynamicRangeOutput
  // DualAPI

  // Windows.Media.Core.SceneAnalysisEffectFrame
  // DualAPI

  // Windows.Media.Core.SceneAnalysisEffectDefinition
  // DualAPI
  TCore_SceneAnalysisEffectDefinition = class(TWinRTGenericImportI<Effects_IVideoEffectDefinition>) end;

  // Windows.Media.Core.FaceDetectionEffectFrame
  // DualAPI

  // Windows.Media.Core.FaceDetectedEventArgs
  // DualAPI

  // Windows.Media.Core.FaceDetectionEffect
  // DualAPI

  // Windows.Media.Core.FaceDetectionEffectDefinition
  // DualAPI
  TCore_FaceDetectionEffectDefinition = class(TWinRTGenericImportI<Core_IFaceDetectionEffectDefinition>) end;

  // Windows.Media.Core.VideoStabilizationEffectEnabledChangedEventArgs
  // DualAPI

  // Windows.Media.Core.VideoStabilizationEffect
  // DualAPI

  // Windows.Media.Core.VideoStabilizationEffectDefinition
  // DualAPI
  TCore_VideoStabilizationEffectDefinition = class(TWinRTGenericImportI<Effects_IVideoEffectDefinition>) end;

  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSource
  // DualAPI
  TStreaming_Adaptive_AdaptiveMediaSource = class(TWinRTGenericImportS<Streaming_Adaptive_IAdaptiveMediaSourceStatics>)
  public
    // -> Streaming_Adaptive_IAdaptiveMediaSourceStatics
    class function IsContentTypeSupported(contentType: HSTRING): Boolean; static; inline;
    class function CreateFromUriAsync(uri: IUriRuntimeClass): IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult; overload; static; inline;
    class function CreateFromUriAsync(uri: IUriRuntimeClass; httpClient: Http_IHttpClient): IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult; overload; static; inline;
    class function CreateFromStreamAsync(stream: IInputStream; uri: IUriRuntimeClass; contentType: HSTRING): IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult; overload; static; inline;
    class function CreateFromStreamAsync(stream: IInputStream; uri: IUriRuntimeClass; contentType: HSTRING; httpClient: Http_IHttpClient): IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult; overload; static; inline;
  end;

  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceCreationResult
  // DualAPI

  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadBitrateChangedEventArgs
  // DualAPI

  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourcePlaybackBitrateChangedEventArgs
  // DualAPI

  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadRequestedEventArgs
  // DualAPI

  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadCompletedEventArgs
  // DualAPI

  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadFailedEventArgs
  // DualAPI

  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadResult
  // DualAPI

  // Windows.Media.Streaming.Adaptive.AdaptiveMediaSourceDownloadRequestedDeferral
  // DualAPI

  // Windows.Media.Core.MediaSourceError
  // DualAPI

  // Windows.Media.Core.MediaSource
  // DualAPI
  TCore_MediaSource = class(TWinRTGenericImportS<Core_IMediaSourceStatics>)
  public
    // -> Core_IMediaSourceStatics
    class function CreateFromAdaptiveMediaSource(mediaSource: Streaming_Adaptive_IAdaptiveMediaSource): Core_IMediaSource2; static; inline;
    class function CreateFromMediaStreamSource(mediaSource: Core_IMediaStreamSource): Core_IMediaSource2; static; inline;
    class function CreateFromMseStreamSource(mediaSource: Core_IMseStreamSource): Core_IMediaSource2; static; inline;
    class function CreateFromIMediaSource(mediaSource: Core_IMediaSource): Core_IMediaSource2; static; inline;
    class function CreateFromStorageFile(&file: IStorageFile): Core_IMediaSource2; static; inline;
    class function CreateFromStream(stream: IRandomAccessStream; contentType: HSTRING): Core_IMediaSource2; static; inline;
    class function CreateFromStreamReference(stream: IRandomAccessStreamReference; contentType: HSTRING): Core_IMediaSource2; static; inline;
    class function CreateFromUri(uri: IUriRuntimeClass): Core_IMediaSource2; static; inline;
  end;

  // Windows.Media.Core.MediaSourceOpenOperationCompletedEventArgs
  // DualAPI

  // Windows.Media.Core.TimedTextSource
  // DualAPI
  TCore_TimedTextSource = class(TWinRTGenericImportS<Core_ITimedTextSourceStatics>)
  public
    // -> Core_ITimedTextSourceStatics
    class function CreateFromStream(stream: IRandomAccessStream): Core_ITimedTextSource; overload; static; inline;
    class function CreateFromUri(uri: IUriRuntimeClass): Core_ITimedTextSource; overload; static; inline;
    class function CreateFromStream(stream: IRandomAccessStream; defaultLanguage: HSTRING): Core_ITimedTextSource; overload; static; inline;
    class function CreateFromUri(uri: IUriRuntimeClass; defaultLanguage: HSTRING): Core_ITimedTextSource; overload; static; inline;
  end;

  // Windows.Media.Core.TimedMetadataTrack
  // DualAPI
  TCore_TimedMetadataTrack = class(TWinRTGenericImportF<Core_ITimedMetadataTrackFactory>)
  public
    // -> Core_ITimedMetadataTrackFactory
    class function Create(id: HSTRING; language: HSTRING; kind: Core_TimedMetadataKind): Core_ITimedMetadataTrack; static; inline;
  end;

  // Windows.Media.Core.TimedTextRegion
  // DualAPI
  TCore_TimedTextRegion = class(TWinRTGenericImportI<Core_ITimedTextRegion>) end;

  // Windows.Media.Core.TimedTextStyle
  // DualAPI
  TCore_TimedTextStyle = class(TWinRTGenericImportI<Core_ITimedTextStyle>) end;

  // Windows.Media.Core.TimedTextLine
  // DualAPI
  TCore_TimedTextLine = class(TWinRTGenericImportI<Core_ITimedTextLine>) end;

  // Windows.Media.Core.TimedTextSubformat
  // DualAPI
  TCore_TimedTextSubformat = class(TWinRTGenericImportI<Core_ITimedTextSubformat>) end;

  // Windows.Media.Core.TimedMetadataTrackError
  // DualAPI

  // Windows.Media.Core.MediaCueEventArgs
  // DualAPI

  // Windows.Media.Core.TimedMetadataTrackFailedEventArgs
  // DualAPI

  // Windows.Media.Core.TimedTextSourceResolveResultEventArgs
  // DualAPI

  // Windows.Media.Core.TimedTextCue
  // DualAPI
  TCore_TimedTextCue = class(TWinRTGenericImportI<Core_ITimedTextCue>) end;

  // Windows.Media.Core.DataCue
  // DualAPI
  TCore_DataCue = class(TWinRTGenericImportI<Core_IDataCue>) end;

  // Windows.Media.Core.VideoTrack
  // DualAPI

  // Windows.Media.Core.AudioTrack
  // DualAPI

  // Windows.Media.Playback.MediaPlaybackAudioTrackList
  // DualAPI

  // Windows.Media.Playback.MediaPlaybackVideoTrackList
  // DualAPI

  // Windows.Media.Playback.MediaPlaybackTimedMetadataTrackList
  // DualAPI

  // Windows.Media.Playback.MediaPlaybackItemError
  // DualAPI

  // Windows.Media.Playback.MediaPlaybackList
  // DualAPI
  TPlayback_MediaPlaybackList = class(TWinRTGenericImportI<Playback_IMediaPlaybackList>) end;

  // Windows.Media.Playback.MediaPlaybackItemFailedEventArgs
  // DualAPI

  // Windows.Media.Playback.CurrentMediaPlaybackItemChangedEventArgs
  // DualAPI

  // Windows.Media.Playback.MediaPlaybackItemOpenedEventArgs
  // DualAPI

  // Windows.Media.Playback.TimedMetadataPresentationModeChangedEventArgs
  // DualAPI

  // Windows.Media.Playlists.Playlist
  // DualAPI
  TPlaylists_Playlist = class(TWinRTGenericImportSI<Playlists_IPlaylistStatics, Playlists_IPlaylist>)
  public
    // -> Playlists_IPlaylistStatics
    class function LoadAsync(&file: IStorageFile): IAsyncOperation_1__Playlists_IPlaylist; static; inline;
  end;


implementation

  // Emit Classes Implementation
 { TVideoFrame }
// Factories for : "VideoFrame"
// Factory: "Windows.Media.IVideoFrameFactory"
// -> IVideoFrameFactory

class function TVideoFrame.Create(format: Imaging_BitmapPixelFormat; width: Integer; height: Integer): IVideoFrame;
begin
  Result := Factory.Create(format, width, height);
end;

class function TVideoFrame.CreateWithAlpha(format: Imaging_BitmapPixelFormat; width: Integer; height: Integer; alpha: Imaging_BitmapAlphaMode): IVideoFrame;
begin
  Result := Factory.CreateWithAlpha(format, width, height, alpha);
end;


 { TAudioFrame }
// Factories for : "AudioFrame"
// Factory: "Windows.Media.IAudioFrameFactory"
// -> IAudioFrameFactory

class function TAudioFrame.Create(capacity: Cardinal): IAudioFrame;
begin
  Result := Factory.Create(capacity);
end;


 { TAudio_AudioGraph }

class function TAudio_AudioGraph.CreateAsync(settings: Audio_IAudioGraphSettings): IAsyncOperation_1__Audio_ICreateAudioGraphResult;
begin
  Result := Statics.CreateAsync(settings);
end;


 { TAudio_AudioGraphSettings }
// Factories for : "Audio_AudioGraphSettings"
// Factory: "Windows.Media.Audio.IAudioGraphSettingsFactory"
// -> Audio_IAudioGraphSettingsFactory

class function TAudio_AudioGraphSettings.Create(audioRenderCategory: Render_AudioRenderCategory): Audio_IAudioGraphSettings;
begin
  Result := Factory.Create(audioRenderCategory);
end;


 { TAudio_EqualizerEffectDefinition }
// Factories for : "Audio_EqualizerEffectDefinition"
// Factory: "Windows.Media.Audio.IEqualizerEffectDefinitionFactory"
// -> Audio_IEqualizerEffectDefinitionFactory

class function TAudio_EqualizerEffectDefinition.Create(audioGraph: Audio_IAudioGraph): Audio_IEqualizerEffectDefinition;
begin
  Result := Factory.Create(audioGraph);
end;


 { TAudio_ReverbEffectDefinition }
// Factories for : "Audio_ReverbEffectDefinition"
// Factory: "Windows.Media.Audio.IReverbEffectDefinitionFactory"
// -> Audio_IReverbEffectDefinitionFactory

class function TAudio_ReverbEffectDefinition.Create(audioGraph: Audio_IAudioGraph): Audio_IReverbEffectDefinition;
begin
  Result := Factory.Create(audioGraph);
end;


 { TAudio_EchoEffectDefinition }
// Factories for : "Audio_EchoEffectDefinition"
// Factory: "Windows.Media.Audio.IEchoEffectDefinitionFactory"
// -> Audio_IEchoEffectDefinitionFactory

class function TAudio_EchoEffectDefinition.Create(audioGraph: Audio_IAudioGraph): Audio_IEchoEffectDefinition;
begin
  Result := Factory.Create(audioGraph);
end;


 { TAudio_LimiterEffectDefinition }
// Factories for : "Audio_LimiterEffectDefinition"
// Factory: "Windows.Media.Audio.ILimiterEffectDefinitionFactory"
// -> Audio_ILimiterEffectDefinitionFactory

class function TAudio_LimiterEffectDefinition.Create(audioGraph: Audio_IAudioGraph): Audio_ILimiterEffectDefinition;
begin
  Result := Factory.Create(audioGraph);
end;


 { TCasting_CastingDevice }

class function TCasting_CastingDevice.GetDeviceSelector(&type: Casting_CastingPlaybackTypes): HSTRING;
begin
  Result := Statics.GetDeviceSelector(&type);
end;

class function TCasting_CastingDevice.GetDeviceSelectorFromCastingSourceAsync(castingSource: Casting_ICastingSource): IAsyncOperation_1__HSTRING;
begin
  Result := Statics.GetDeviceSelectorFromCastingSourceAsync(castingSource);
end;

class function TCasting_CastingDevice.FromIdAsync(value: HSTRING): IAsyncOperation_1__Casting_ICastingDevice;
begin
  Result := Statics.FromIdAsync(value);
end;

class function TCasting_CastingDevice.DeviceInfoSupportsCastingAsync(device: IDeviceInformation): IAsyncOperation_1__Boolean;
begin
  Result := Statics.DeviceInfoSupportsCastingAsync(device);
end;


 { TCasting_CastingDevicePicker }

 { TDialProtocol_DialDevicePicker }

 { TEffects_VideoCompositorDefinition }
// Factories for : "Effects_VideoCompositorDefinition"
// Factory: "Windows.Media.Effects.IVideoCompositorDefinitionFactory"
// -> Effects_IVideoCompositorDefinitionFactory

class function TEffects_VideoCompositorDefinition.Create(activatableClassId: HSTRING): Effects_IVideoCompositorDefinition;
begin
  Result := Factory.Create(activatableClassId);
end;

class function TEffects_VideoCompositorDefinition.CreateWithProperties(activatableClassId: HSTRING; props: IPropertySet): Effects_IVideoCompositorDefinition;
begin
  Result := Factory.CreateWithProperties(activatableClassId, props);
end;


 { TEditing_MediaOverlay }
// Factories for : "Editing_MediaOverlay"
// Factory: "Windows.Media.Editing.IMediaOverlayFactory"
// -> Editing_IMediaOverlayFactory

class function TEditing_MediaOverlay.Create(clip: Editing_IMediaClip): Editing_IMediaOverlay;
begin
  Result := Factory.Create(clip);
end;

class function TEditing_MediaOverlay.CreateWithPositionAndOpacity(clip: Editing_IMediaClip; position: TRectF; opacity: Double): Editing_IMediaOverlay;
begin
  Result := Factory.CreateWithPositionAndOpacity(clip, position, opacity);
end;


 { TEditing_MediaClip }

class function TEditing_MediaClip.CreateFromColor(color: Color; originalDuration: TimeSpan): Editing_IMediaClip;
begin
  Result := Statics.CreateFromColor(color, originalDuration);
end;

class function TEditing_MediaClip.CreateFromFileAsync(&file: IStorageFile): IAsyncOperation_1__Editing_IMediaClip;
begin
  Result := Statics.CreateFromFileAsync(&file);
end;

class function TEditing_MediaClip.CreateFromImageFileAsync(&file: IStorageFile; originalDuration: TimeSpan): IAsyncOperation_1__Editing_IMediaClip;
begin
  Result := Statics.CreateFromImageFileAsync(&file, originalDuration);
end;


class function TEditing_MediaClip.CreateFromSurface(surface: DirectX_Direct3D11_IDirect3DSurface; originalDuration: TimeSpan): Editing_IMediaClip;
begin
  Result := Statics2.CreateFromSurface(surface, originalDuration);
end;


 { TEditing_BackgroundAudioTrack }

class function TEditing_BackgroundAudioTrack.CreateFromEmbeddedAudioTrack(embeddedAudioTrack: Editing_IEmbeddedAudioTrack): Editing_IBackgroundAudioTrack;
begin
  Result := Statics.CreateFromEmbeddedAudioTrack(embeddedAudioTrack);
end;

class function TEditing_BackgroundAudioTrack.CreateFromFileAsync(&file: IStorageFile): IAsyncOperation_1__Editing_IBackgroundAudioTrack;
begin
  Result := Statics.CreateFromFileAsync(&file);
end;


 { TEditing_MediaComposition }

class function TEditing_MediaComposition.LoadAsync(&file: IStorageFile): IAsyncOperation_1__Editing_IMediaComposition;
begin
  Result := Statics.LoadAsync(&file);
end;


 { TEditing_MediaOverlayLayer }
// Factories for : "Editing_MediaOverlayLayer"
// Factory: "Windows.Media.Editing.IMediaOverlayLayerFactory"
// -> Editing_IMediaOverlayLayerFactory

class function TEditing_MediaOverlayLayer.CreateWithCompositorDefinition(compositorDefinition: Effects_IVideoCompositorDefinition): Editing_IMediaOverlayLayer;
begin
  Result := Factory.CreateWithCompositorDefinition(compositorDefinition);
end;


 { TImport_PhotoImportSource }

class function TImport_PhotoImportSource.FromIdAsync(sourceId: HSTRING): IAsyncOperation_1__Import_IPhotoImportSource;
begin
  Result := Statics.FromIdAsync(sourceId);
end;

class function TImport_PhotoImportSource.FromFolderAsync(sourceRootFolder: IStorageFolder): IAsyncOperation_1__Import_IPhotoImportSource;
begin
  Result := Statics.FromFolderAsync(sourceRootFolder);
end;


 { TImport_PhotoImportManager }

class function TImport_PhotoImportManager.IsSupportedAsync: IAsyncOperation_1__Boolean;
begin
  Result := Statics.IsSupportedAsync;
end;

class function TImport_PhotoImportManager.FindAllSourcesAsync: IAsyncOperation_1__IVectorView_1__Import_IPhotoImportSource;
begin
  Result := Statics.FindAllSourcesAsync;
end;

class function TImport_PhotoImportManager.GetPendingOperations: IVectorView_1__Import_IPhotoImportOperation;
begin
  Result := Statics.GetPendingOperations;
end;


 { TCapture_MediaCapture }

class function TCapture_MediaCapture.IsVideoProfileSupported(videoDeviceId: HSTRING): Boolean;
begin
  Result := Statics.IsVideoProfileSupported(videoDeviceId);
end;

class function TCapture_MediaCapture.FindAllVideoProfiles(videoDeviceId: HSTRING): IVectorView_1__Capture_IMediaCaptureVideoProfile;
begin
  Result := Statics.FindAllVideoProfiles(videoDeviceId);
end;

class function TCapture_MediaCapture.FindConcurrentProfiles(videoDeviceId: HSTRING): IVectorView_1__Capture_IMediaCaptureVideoProfile;
begin
  Result := Statics.FindConcurrentProfiles(videoDeviceId);
end;

class function TCapture_MediaCapture.FindKnownVideoProfiles(videoDeviceId: HSTRING; name: Capture_KnownVideoProfile): IVectorView_1__Capture_IMediaCaptureVideoProfile;
begin
  Result := Statics.FindKnownVideoProfiles(videoDeviceId, name);
end;


 { TCapture_MediaCaptureInitializationSettings }

 { TVideoEffects }

class function TVideoEffects.get_VideoStabilization: HSTRING;
begin
  Result := Statics.get_VideoStabilization;
end;


 { TEffects_VideoEffectDefinition }
// Factories for : "Effects_VideoEffectDefinition"
// Factory: "Windows.Media.Effects.IVideoEffectDefinitionFactory"
// -> Effects_IVideoEffectDefinitionFactory

class function TEffects_VideoEffectDefinition.Create(activatableClassId: HSTRING): Effects_IVideoEffectDefinition;
begin
  Result := Factory.Create(activatableClassId);
end;

class function TEffects_VideoEffectDefinition.CreateWithProperties(activatableClassId: HSTRING; props: IPropertySet): Effects_IVideoEffectDefinition;
begin
  Result := Factory.CreateWithProperties(activatableClassId, props);
end;


 { TEffects_AudioEffectDefinition }
// Factories for : "Effects_AudioEffectDefinition"
// Factory: "Windows.Media.Effects.IAudioEffectDefinitionFactory"
// -> Effects_IAudioEffectDefinitionFactory

class function TEffects_AudioEffectDefinition.Create(activatableClassId: HSTRING): Effects_IAudioEffectDefinition;
begin
  Result := Factory.Create(activatableClassId);
end;

class function TEffects_AudioEffectDefinition.CreateWithProperties(activatableClassId: HSTRING; props: IPropertySet): Effects_IAudioEffectDefinition;
begin
  Result := Factory.CreateWithProperties(activatableClassId, props);
end;


 { TEffects_VideoTransformEffectDefinition }

 { TProtection_MediaProtectionPMPServer }
// Factories for : "Protection_MediaProtectionPMPServer"
// Factory: "Windows.Media.Protection.IMediaProtectionPMPServerFactory"
// -> Protection_IMediaProtectionPMPServerFactory

class function TProtection_MediaProtectionPMPServer.CreatePMPServer(pProperties: IPropertySet): Protection_IMediaProtectionPMPServer;
begin
  Result := Factory.CreatePMPServer(pProperties);
end;


 { TPlayback_MediaPlaybackItem }
// Factories for : "Playback_MediaPlaybackItem"
// Factory: "Windows.Media.Playback.IMediaPlaybackItemFactory"
// -> Playback_IMediaPlaybackItemFactory

class function TPlayback_MediaPlaybackItem.Create(source: Core_IMediaSource2): Playback_IMediaPlaybackItem;
begin
  Result := Factory.Create(source);
end;


 { TCore_AudioStreamDescriptor }
// Factories for : "Core_AudioStreamDescriptor"
// Factory: "Windows.Media.Core.IAudioStreamDescriptorFactory"
// -> Core_IAudioStreamDescriptorFactory

class function TCore_AudioStreamDescriptor.Create(encodingProperties: IAudioEncodingProperties): Core_IAudioStreamDescriptor;
begin
  Result := Factory.Create(encodingProperties);
end;


 { TCore_VideoStreamDescriptor }
// Factories for : "Core_VideoStreamDescriptor"
// Factory: "Windows.Media.Core.IVideoStreamDescriptorFactory"
// -> Core_IVideoStreamDescriptorFactory

class function TCore_VideoStreamDescriptor.Create(encodingProperties: IVideoEncodingProperties): Core_IVideoStreamDescriptor;
begin
  Result := Factory.Create(encodingProperties);
end;


 { TCore_MediaStreamSource }
// Factories for : "Core_MediaStreamSource"
// Factory: "Windows.Media.Core.IMediaStreamSourceFactory"
// -> Core_IMediaStreamSourceFactory

class function TCore_MediaStreamSource.CreateFromDescriptor(descriptor: Core_IMediaStreamDescriptor): Core_IMediaStreamSource;
begin
  Result := Factory.CreateFromDescriptor(descriptor);
end;

class function TCore_MediaStreamSource.CreateFromDescriptors(descriptor: Core_IMediaStreamDescriptor; descriptor2: Core_IMediaStreamDescriptor): Core_IMediaStreamSource;
begin
  Result := Factory.CreateFromDescriptors(descriptor, descriptor2);
end;


 { TCore_MediaStreamSample }

class function TCore_MediaStreamSample.CreateFromBuffer(buffer: IBuffer; timestamp: TimeSpan): Core_IMediaStreamSample;
begin
  Result := Statics.CreateFromBuffer(buffer, timestamp);
end;

class function TCore_MediaStreamSample.CreateFromStreamAsync(stream: IInputStream; count: Cardinal; timestamp: TimeSpan): IAsyncOperation_1__Core_IMediaStreamSample;
begin
  Result := Statics.CreateFromStreamAsync(stream, count, timestamp);
end;


 { TCore_MseStreamSource }

class function TCore_MseStreamSource.IsContentTypeSupported(contentType: HSTRING): Boolean;
begin
  Result := Statics.IsContentTypeSupported(contentType);
end;


 { TTranscoding_MediaTranscoder }

 { TCore_SceneAnalysisEffectDefinition }

 { TCore_FaceDetectionEffectDefinition }

 { TCore_VideoStabilizationEffectDefinition }

 { TStreaming_Adaptive_AdaptiveMediaSource }

class function TStreaming_Adaptive_AdaptiveMediaSource.IsContentTypeSupported(contentType: HSTRING): Boolean;
begin
  Result := Statics.IsContentTypeSupported(contentType);
end;

class function TStreaming_Adaptive_AdaptiveMediaSource.CreateFromUriAsync(uri: IUriRuntimeClass): IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult;
begin
  Result := Statics.CreateFromUriAsync(uri);
end;

class function TStreaming_Adaptive_AdaptiveMediaSource.CreateFromUriAsync(uri: IUriRuntimeClass; httpClient: Http_IHttpClient): IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult;
begin
  Result := Statics.CreateFromUriAsync(uri, httpClient);
end;

class function TStreaming_Adaptive_AdaptiveMediaSource.CreateFromStreamAsync(stream: IInputStream; uri: IUriRuntimeClass; contentType: HSTRING): IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult;
begin
  Result := Statics.CreateFromStreamAsync(stream, uri, contentType);
end;

class function TStreaming_Adaptive_AdaptiveMediaSource.CreateFromStreamAsync(stream: IInputStream; uri: IUriRuntimeClass; contentType: HSTRING; httpClient: Http_IHttpClient): IAsyncOperation_1__Streaming_Adaptive_IAdaptiveMediaSourceCreationResult;
begin
  Result := Statics.CreateFromStreamAsync(stream, uri, contentType, httpClient);
end;


 { TCore_MediaSource }

class function TCore_MediaSource.CreateFromAdaptiveMediaSource(mediaSource: Streaming_Adaptive_IAdaptiveMediaSource): Core_IMediaSource2;
begin
  Result := Statics.CreateFromAdaptiveMediaSource(mediaSource);
end;

class function TCore_MediaSource.CreateFromMediaStreamSource(mediaSource: Core_IMediaStreamSource): Core_IMediaSource2;
begin
  Result := Statics.CreateFromMediaStreamSource(mediaSource);
end;

class function TCore_MediaSource.CreateFromMseStreamSource(mediaSource: Core_IMseStreamSource): Core_IMediaSource2;
begin
  Result := Statics.CreateFromMseStreamSource(mediaSource);
end;

class function TCore_MediaSource.CreateFromIMediaSource(mediaSource: Core_IMediaSource): Core_IMediaSource2;
begin
  Result := Statics.CreateFromIMediaSource(mediaSource);
end;

class function TCore_MediaSource.CreateFromStorageFile(&file: IStorageFile): Core_IMediaSource2;
begin
  Result := Statics.CreateFromStorageFile(&file);
end;

class function TCore_MediaSource.CreateFromStream(stream: IRandomAccessStream; contentType: HSTRING): Core_IMediaSource2;
begin
  Result := Statics.CreateFromStream(stream, contentType);
end;

class function TCore_MediaSource.CreateFromStreamReference(stream: IRandomAccessStreamReference; contentType: HSTRING): Core_IMediaSource2;
begin
  Result := Statics.CreateFromStreamReference(stream, contentType);
end;

class function TCore_MediaSource.CreateFromUri(uri: IUriRuntimeClass): Core_IMediaSource2;
begin
  Result := Statics.CreateFromUri(uri);
end;


 { TCore_TimedTextSource }

class function TCore_TimedTextSource.CreateFromStream(stream: IRandomAccessStream): Core_ITimedTextSource;
begin
  Result := Statics.CreateFromStream(stream);
end;

class function TCore_TimedTextSource.CreateFromUri(uri: IUriRuntimeClass): Core_ITimedTextSource;
begin
  Result := Statics.CreateFromUri(uri);
end;

class function TCore_TimedTextSource.CreateFromStream(stream: IRandomAccessStream; defaultLanguage: HSTRING): Core_ITimedTextSource;
begin
  Result := Statics.CreateFromStream(stream, defaultLanguage);
end;

class function TCore_TimedTextSource.CreateFromUri(uri: IUriRuntimeClass; defaultLanguage: HSTRING): Core_ITimedTextSource;
begin
  Result := Statics.CreateFromUri(uri, defaultLanguage);
end;


 { TCore_TimedMetadataTrack }
// Factories for : "Core_TimedMetadataTrack"
// Factory: "Windows.Media.Core.ITimedMetadataTrackFactory"
// -> Core_ITimedMetadataTrackFactory

class function TCore_TimedMetadataTrack.Create(id: HSTRING; language: HSTRING; kind: Core_TimedMetadataKind): Core_ITimedMetadataTrack;
begin
  Result := Factory.Create(id, language, kind);
end;


 { TCore_TimedTextRegion }

 { TCore_TimedTextStyle }

 { TCore_TimedTextLine }

 { TCore_TimedTextSubformat }

 { TCore_TimedTextCue }

 { TCore_DataCue }

 { TPlayback_MediaPlaybackList }

 { TPlaylists_Playlist }

class function TPlaylists_Playlist.LoadAsync(&file: IStorageFile): IAsyncOperation_1__Playlists_IPlaylist;
begin
  Result := Statics.LoadAsync(&file);
end;



end.
