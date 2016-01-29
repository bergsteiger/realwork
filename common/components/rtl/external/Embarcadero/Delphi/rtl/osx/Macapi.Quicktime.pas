{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework Quicktime
//

unit Macapi.Quicktime;

interface

uses
  Macapi.ObjCRuntime,
  Macapi.ObjectiveC,
  Macapi.CocoaTypes,
//  Macapi.QuickTime,
//  Macapi.HIToolbox,
//  Macapi.NavigationServices,
//  Macapi.CarbonSound,
  Macapi.CoreFoundation,
//  Macapi.CoreAudio,
//  Macapi.AudioToolbox,
//  Macapi.AudioUnit,
//  Macapi.Accelerate,
//  Macapi.ApplicationServices,
  Macapi.Security,
//  Macapi.IOKit,
  Macapi.SystemConfiguration,
//  Macapi.CoreData,
  Macapi.Foundation,
  Macapi.CoreServices;

const
  ClipAID = 1668049264;
  CloneMediaAID = 1668050798;
  ColorTableAID = 1668571490;
  CompressedMovieAID = 1668116342;
  CompressedMovieDataAID = 1668118116;
  DataCompressionAtomAID = 1684238189;
  DataInfoAID = 1684631142;
  DataRefAID = 1685218662;
  DataRefContainerAID = 1685218915;
  EditListAID = 1701606260;
  EditsAID = 1701082227;
  FileTypeAID = 1718909296;
  GenericMediaInfoAID = 1735223662;
  GenericMediaInfoHeaderAID = 1735223396;
  HandlerAID = 1751411826;
  InputMapAID = 1768776048;
  LoadSettingsAID = 1819238756;
  MEDIA_TYPE = 1835297121;
  MOVIE_TYPE = 1836019574;
  MatteAID = 1835103348;
  MatteCompAID = 1802330484;
  MediaAID = 1835297121;
  MediaHeaderAID = 1835296868;
  MediaInfoAID = 1835626086;
  MovieAID = 1836019574;
  MovieBufferHintsAID = 1835165288;
  MovieDataRefAliasAID = 1835299425;
  MovieHeaderAID = 1836476516;
  PropertyAtomAID = 1668244581;
  QT_MEDIA_TYPE = 1835297121;
  QT_MOVIE_TYPE = 1836019574;
  QT_SOUND_TYPE = 1936684398;
  QT_TRACK_TYPE = 1953653099;
  QT_VIDEO_TYPE = 1986618469;
  ReferenceMovieAlternateGroupAID = 1919770983;
  ReferenceMovieCPURatingAID = 1919771507;
  ReferenceMovieComponentCheckAID = 1919771492;
  ReferenceMovieDataRateAID = 1919771762;
  ReferenceMovieDataRefAID = 1919185510;
  ReferenceMovieDescriptorAID = 1919771745;
  ReferenceMovieLanguageAID = 1919773793;
  ReferenceMovieNetworkStatusAID = 1919837556;
  ReferenceMovieQualityAID = 1919775093;
  ReferenceMovieRecordAID = 1919775329;
  ReferenceMovieVersionCheckAID = 1919776355;
  RgnClipAID = 1668441966;
  SOUND_TYPE = 1936684398;
  STChunkOffset64AID = 1668232756;
  STChunkOffsetAID = 1937007471;
  STCompositionOffsetAID = 1668576371;
  STCompositionShiftLeastGreatestAID = 1668508775;
  STPartialSyncSampleAID = 1937010803;
  STSampleDependencyAID = 1935963248;
  STSampleDescAID = 1937011556;
  STSampleIDAID = 1937008996;
  STSampleSizeAID = 1937011578;
  STSampleToChunkAID = 1937011555;
  STShadowSyncAID = 1937011560;
  STSyncSampleAID = 1937011571;
  STTimeToSampAID = 1937011827;
  SampleTableAID = 1937007212;
  SecureContentInfoAID = 1936289382;
  SecureContentSchemeInfoAID = 1935894633;
  SecureContentSchemeTypeAID = 1935894637;
  SoundLocalizationAID = 1936486243;
  SoundMediaInfoHeaderAID = 1936549988;
  TRACK_TYPE = 1953653099;
  TrackAID = 1953653099;
  TrackApertureModeDimensionsAID = 1952542836;
  TrackCleanApertureDimensionsAID = 1668048230;
  TrackEnable = 1;
  TrackEncodedPixelsDimensionsAID = 1701736294;
  TrackHeaderAID = 1953196132;
  TrackInMovie = 2;
  TrackInPoster = 8;
  TrackInPreview = 4;
  TrackProductionApertureDimensionsAID = 1886547814;
  TrackReferenceAID = 1953654118;
  UserDataAID = 1969517665;
  VIDEO_TYPE = 1986618469;
  VideoMediaInfoHeaderAID = 1986881636;
  kDataRate144ModemRate = 1400;
  kDataRate1MbpsRate = 100000;
  kDataRate256kbpsRate = 25600;
  kDataRate288ModemRate = 2800;
  kDataRate384kbpsRate = 38400;
  kDataRate512kbpsRate = 51200;
  kDataRate768kbpsRate = 76800;
  kDataRateDefaultIfNotSet = 51200;
  kDataRateDualISDNRate = 11200;
  kDataRateISDNRate = 5600;
  kDataRateInfiniteRate = 2147483647;
  kDataRateT1Rate = 150000;
  kDataRefIsSelfContained = 1;
  kMovieVersion = 0;
  kQTCPUSpeed1Rating = 100;
  kQTCPUSpeed2Rating = 200;
  kQTCPUSpeed3Rating = 300;
  kQTCPUSpeed4Rating = 400;
  kQTCPUSpeed5Rating = 500;
  kQTComponentPropertyListenerCollectionContextVersion = 1;
  kQTFileTypeBrandISOFile = 1769172845;
  kQTFileTypeBrandMPEG4v1 = 1836069937;
  kQTFileTypeBrandMPEG4v2 = 1836069938;
  kQTFileTypeBrandQuickTimeMovie = 1903435808;
  kQTSampleDependency_DependsOnOthers_Corrected = 16;
  kQTSampleDependency_DoesNotDependOnOthers_Corrected = 32;
  kQTSampleDependency_EarlierDisplayTimesAllowed = 64;
  kQTSampleDependency_HasNoRedundantCoding_Corrected = 2;
  kQTSampleDependency_HasRedundantCoding_Corrected = 1;
  kQTSampleDependency_IsDependedOnByOthers_Corrected = 4;
  kQTSampleDependency_IsNotDependedOnByOthers_Corrected = 8;
  kVersionCheckMask = 1;
  kVersionCheckMin = 0;
  uppCallComponentExecuteWiredActionProcInfo = 65520;
  uppDataHAddMovieProcInfo = 4080;
  uppDataHAppend64ProcInfo = 16368;
  uppDataHCanUseDataRefProcInfo = 4080;
  uppDataHCloseForReadProcInfo = 240;
  uppDataHCloseForWriteProcInfo = 240;
  uppDataHCompareDataRefProcInfo = 4080;
  uppDataHCreateFileProcInfo = 2032;
  uppDataHCreateFileWithFlagsProcInfo = 14320;
  uppDataHDeleteFileProcInfo = 240;
  uppDataHDoesBufferProcInfo = 4080;
  uppDataHFinishDataProcInfo = 2032;
  uppDataHFlushCacheProcInfo = 240;
  uppDataHFlushDataProcInfo = 240;
  uppDataHGetAvailableFileSize64ProcInfo = 1008;
  uppDataHGetAvailableFileSizeProcInfo = 1008;
  uppDataHGetCacheSizeLimitProcInfo = 1008;
  uppDataHGetDataAvailability64ProcInfo = 65520;
  uppDataHGetDataAvailabilityProcInfo = 65520;
  uppDataHGetDataInBufferProcInfo = 4080;
  uppDataHGetDataProcInfo = 65520;
  uppDataHGetDataRateProcInfo = 4080;
  uppDataHGetDataRefAsTypeProcInfo = 4080;
  uppDataHGetDataRefExtensionProcInfo = 4080;
  uppDataHGetDataRefProcInfo = 1008;
  uppDataHGetDataRefWithAnchorProcInfo = 16368;
  uppDataHGetDeviceIndexProcInfo = 1008;
  uppDataHGetFileNameProcInfo = 1008;
  uppDataHGetFileSize64ProcInfo = 1008;
  uppDataHGetFileSizeAsyncProcInfo = 16368;
  uppDataHGetFileSizeProcInfo = 1008;
  uppDataHGetFileTypeOrderingProcInfo = 1008;
  uppDataHGetFreeSpace64ProcInfo = 1008;
  uppDataHGetFreeSpaceProcInfo = 1008;
  uppDataHGetInfoFlagsProcInfo = 1008;
  uppDataHGetInfoProcInfo = 4080;
  uppDataHGetMIMETypeAsyncProcInfo = 16368;
  uppDataHGetMIMETypeProcInfo = 1008;
  uppDataHGetMacOSFileTypeProcInfo = 1008;
  uppDataHGetMovieProcInfo = 4080;
  uppDataHGetMovieWithFlagsProcInfo = 12272;
  uppDataHGetPreferredBlockSizeProcInfo = 1008;
  uppDataHGetScheduleAheadTimeProcInfo = 1008;
  uppDataHGetTemporaryDataRefCapabilitiesProcInfo = 1008;
  uppDataHGetVolumeListProcInfo = 1008;
  uppDataHIsStreamingDataHandlerProcInfo = 1008;
  uppDataHOpenForReadProcInfo = 240;
  uppDataHOpenForWriteProcInfo = 240;
  uppDataHPlaybackHints64ProcInfo = 65520;
  uppDataHPlaybackHintsProcInfo = 65520;
  uppDataHPollReadProcInfo = 4080;
  uppDataHPreextend64ProcInfo = 4080;
  uppDataHPreextendProcInfo = 4080;
  uppDataHPutDataProcInfo = 65520;
  uppDataHReadAsyncProcInfo = 262128;
  uppDataHRenameFileProcInfo = 1008;
  uppDataHResolveDataRefProcInfo = 8176;
  uppDataHScheduleData64ProcInfo = 1048560;
  uppDataHScheduleDataProcInfo = 1048560;
  uppDataHSetCacheSizeLimitProcInfo = 1008;
  uppDataHSetDataRefExtensionProcInfo = 4080;
  uppDataHSetDataRefProcInfo = 1008;
  uppDataHSetDataRefWithAnchorProcInfo = 16368;
  uppDataHSetFileSize64ProcInfo = 1008;
  uppDataHSetFileSizeProcInfo = 1008;
  uppDataHSetIdleManagerProcInfo = 1008;
  uppDataHSetMacOSFileTypeProcInfo = 1008;
  uppDataHSetMovieUsageFlagsProcInfo = 1008;
  uppDataHSetTimeBaseProcInfo = 1008;
  uppDataHSetTimeHintsProcInfo = 262128;
  uppDataHTaskProcInfo = 240;
  uppDataHUpdateMovieProcInfo = 3056;
  uppDataHUseTemporaryDataRefProcInfo = 1008;
  uppDataHWrite64ProcInfo = 262128;
  uppDataHWriteProcInfo = 262128;
  uppGraphicsImageImportGetSequenceEnabledProcInfo = 1008;
  uppGraphicsImageImportSetSequenceEnabledProcInfo = 496;
  uppMIDIImportGetSettingsProcInfo = 1008;
  uppMIDIImportSetSettingsProcInfo = 1008;
  uppMediaChangedNonPrimarySourceProcInfo = 1008;
  uppMediaCompareProcInfo = 16368;
  uppMediaCurrentMediaQueuedDataProcInfo = 1008;
  uppMediaDisposeTargetRefConProcInfo = 1008;
  uppMediaDoIdleActionsProcInfo = 240;
  uppMediaEmptyAllPurgeableChunksProcInfo = 240;
  uppMediaEmptySampleCacheProcInfo = 4080;
  uppMediaEnterEmptyEditProcInfo = 240;
  uppMediaFlushNonPrimarySourceDataProcInfo = 1008;
  uppMediaForceUpdateProcInfo = 1008;
  uppMediaGGetIdleManagerProcInfo = 1008;
  uppMediaGGetLatencyProcInfo = 1008;
  uppMediaGGetStatusProcInfo = 1008;
  uppMediaGSetActiveSegmentProcInfo = 4080;
  uppMediaGSetIdleManagerProcInfo = 1008;
  uppMediaGSetVolumeProcInfo = 752;
  uppMediaGenerateApertureModeDimensionsProcInfo = 240;
  uppMediaGetActionsForQTEventProcInfo = 65520;
  uppMediaGetApertureModeClipRectForSampleDescriptionIndexProcInfo = 4080;
  uppMediaGetApertureModeMatrixForSampleDescriptionIndexProcInfo = 4080;
  uppMediaGetChunkManagementFlagsProcInfo = 1008;
  uppMediaGetClockProcInfo = 1008;
  uppMediaGetDrawingRgnProcInfo = 1008;
  uppMediaGetEffectiveSoundBalanceProcInfo = 1008;
  uppMediaGetEffectiveVolumeProcInfo = 1008;
  uppMediaGetErrorStringProcInfo = 4080;
  uppMediaGetGraphicsModeProcInfo = 4080;
  uppMediaGetInvalidRegionProcInfo = 1008;
  uppMediaGetMediaInfoProcInfo = 1008;
  uppMediaGetMediaLoadStateProcInfo = 1008;
  uppMediaGetNameProcInfo = 16368;
  uppMediaGetNextBoundsChangeProcInfo = 1008;
  uppMediaGetNextStepTimeProcInfo = 65264;
  uppMediaGetOffscreenBufferSizeProcInfo = 15344;
  uppMediaGetPublicInfoProcInfo = 16368;
  uppMediaGetPurgeableChunkMemoryAllowanceProcInfo = 1008;
  uppMediaGetSampleDataPointerProcInfo = 65520;
  uppMediaGetSoundBalanceProcInfo = 1008;
  uppMediaGetSoundBassAndTrebleProcInfo = 4080;
  uppMediaGetSoundEqualizerBandLevelsProcInfo = 1008;
  uppMediaGetSoundEqualizerBandsProcInfo = 1008;
  uppMediaGetSoundLevelMeterInfoProcInfo = 1008;
  uppMediaGetSoundLevelMeteringEnabledProcInfo = 1008;
  uppMediaGetSoundOutputComponentProcInfo = 1008;
  uppMediaGetSrcRgnProcInfo = 4080;
  uppMediaGetTrackOpaqueProcInfo = 1008;
  uppMediaGetURLLinkProcInfo = 4080;
  uppMediaGetUserPreferredCodecsProcInfo = 1008;
  uppMediaGetVideoParamProcInfo = 4080;
  uppMediaHasCharacteristicProcInfo = 4080;
  uppMediaHitTestForTargetRefConProcInfo = 16368;
  uppMediaHitTestTargetRefConProcInfo = 65520;
  uppMediaIdleProcInfo = 65520;
  uppMediaInitializeProcInfo = 1008;
  uppMediaInvalidateRegionProcInfo = 1008;
  uppMediaMCIsPlayerEventProcInfo = 4080;
  uppMediaMakeMediaTimeTableProcInfo = 3866608;
  uppMediaNavigateTargetRefConProcInfo = 4080;
  uppMediaPrePrerollBeginProcInfo = 65520;
  uppMediaPrePrerollCancelProcInfo = 1008;
  uppMediaPrerollProcInfo = 4080;
  uppMediaPutMediaInfoProcInfo = 1008;
  uppMediaQueueNonPrimarySourceDataProcInfo = 67108848;
  uppMediaRefConGetPropertyProcInfo = 16368;
  uppMediaRefConSetPropertyProcInfo = 16368;
  uppMediaReleaseSampleDataPointerProcInfo = 1008;
  uppMediaResolveTargetRefConProcInfo = 16368;
  uppMediaSampleDescriptionB2NProcInfo = 1008;
  uppMediaSampleDescriptionChangedProcInfo = 1008;
  uppMediaSampleDescriptionN2BProcInfo = 1008;
  uppMediaSetActionsCallbackProcInfo = 4080;
  uppMediaSetActiveProcInfo = 496;
  uppMediaSetChunkManagementFlagsProcInfo = 4080;
  uppMediaSetClipProcInfo = 1008;
  uppMediaSetDimensionsProcInfo = 4080;
  uppMediaSetDoMCActionCallbackProcInfo = 4080;
  uppMediaSetGWorldProcInfo = 4080;
  uppMediaSetGraphicsModeProcInfo = 4080;
  uppMediaSetHandlerCapabilitiesProcInfo = 4080;
  uppMediaSetHintsProcInfo = 1008;
  uppMediaSetMatrixProcInfo = 1008;
  uppMediaSetMediaTimeScaleProcInfo = 1008;
  uppMediaSetMovieTimeScaleProcInfo = 1008;
  uppMediaSetNonPrimarySourceDataProcInfo = 16777200;
  uppMediaSetPublicInfoProcInfo = 16368;
  uppMediaSetPurgeableChunkMemoryAllowanceProcInfo = 1008;
  uppMediaSetRateProcInfo = 1008;
  uppMediaSetScreenLockProcInfo = 496;
  uppMediaSetSoundBalanceProcInfo = 752;
  uppMediaSetSoundBassAndTrebleProcInfo = 2800;
  uppMediaSetSoundEqualizerBandsProcInfo = 1008;
  uppMediaSetSoundLevelMeteringEnabledProcInfo = 496;
  uppMediaSetSoundLocalizationDataProcInfo = 1008;
  uppMediaSetSoundOutputComponentProcInfo = 1008;
  uppMediaSetTrackApertureModeDimensionsUsingSampleDescriptionProcInfo = 1008;
  uppMediaSetTrackInputMapReferenceProcInfo = 1008;
  uppMediaSetUserPreferredCodecsProcInfo = 1008;
  uppMediaSetVideoParamProcInfo = 4080;
  uppMediaTargetRefConsEqualProcInfo = 16368;
  uppMediaTimeBaseChangedProcInfo = 240;
  uppMediaTrackEditedProcInfo = 240;
  uppMediaTrackPropertyAtomChangedProcInfo = 240;
  uppMediaTrackReferencesChangedProcInfo = 240;
  uppMediaVideoOutputChangedProcInfo = 1008;
  uppMovieExportDisposeGetDataAndPropertiesProcsProcInfo = 16368;
  uppMovieExportNewGetDataAndPropertiesProcsProcInfo = 67108848;
  uppTextExportGetDisplayDataProcInfo = 1008;
  uppTextExportGetSettingsProcInfo = 1008;
  uppTextExportGetTimeFractionProcInfo = 1008;
  uppTextExportSetSettingsProcInfo = 1008;
  uppTextExportSetTimeFractionProcInfo = 1008;
  uppVDAddKeyColorProcInfo = 1008;
  uppVDCaptureStateChangingProcInfo = 1008;
  uppVDClearClipRgnProcInfo = 1008;
  uppVDCompressDoneProcInfo = 262128;
  uppVDCompressOneFrameAsyncProcInfo = 240;
  uppVDCopyPreferredAudioDeviceProcInfo = 1008;
  uppVDDoneProcInfo = 752;
  uppVDGetActiveSrcRectProcInfo = 3824;
  uppVDGetBlackLevelValueProcInfo = 1008;
  uppVDGetBrightnessProcInfo = 1008;
  uppVDGetCLUTInUseProcInfo = 1008;
  uppVDGetClipStateProcInfo = 1008;
  uppVDGetCompressionTimeProcInfo = 1047536;
  uppVDGetCompressionTypesProcInfo = 1008;
  uppVDGetContrastProcInfo = 1008;
  uppVDGetCurrentFlagsProcInfo = 4080;
  uppVDGetDMADepthsProcInfo = 4080;
  uppVDGetDataRateProcInfo = 16368;
  uppVDGetDeviceNameAndFlagsProcInfo = 4080;
  uppVDGetDigitizerInfoProcInfo = 1008;
  uppVDGetDigitizerRectProcInfo = 1008;
  uppVDGetFieldPreferenceProcInfo = 1008;
  uppVDGetHueProcInfo = 1008;
  uppVDGetImageDescriptionProcInfo = 1008;
  uppVDGetInputColorSpaceModeProcInfo = 1008;
  uppVDGetInputFormatProcInfo = 3824;
  uppVDGetInputGammaRecordProcInfo = 1008;
  uppVDGetInputGammaValueProcInfo = 16368;
  uppVDGetInputNameProcInfo = 4080;
  uppVDGetInputProcInfo = 1008;
  uppVDGetKeyColorProcInfo = 1008;
  uppVDGetKeyColorRangeProcInfo = 4080;
  uppVDGetMaskPixMapProcInfo = 1008;
  uppVDGetMaskandValueProcInfo = 16112;
  uppVDGetMaxAuxBufferProcInfo = 4080;
  uppVDGetMaxSrcRectProcInfo = 3824;
  uppVDGetNextKeyColorProcInfo = 1008;
  uppVDGetNumberOfInputsProcInfo = 1008;
  uppVDGetPLLFilterTypeProcInfo = 1008;
  uppVDGetPlayThruDestinationProcInfo = 65520;
  uppVDGetPreferredImageDimensionsProcInfo = 4080;
  uppVDGetPreferredTimeScaleProcInfo = 1008;
  uppVDGetSaturationProcInfo = 1008;
  uppVDGetSharpnessProcInfo = 1008;
  uppVDGetSoundInputDriverProcInfo = 1008;
  uppVDGetSoundInputSourceProcInfo = 4080;
  uppVDGetTimeCodeProcInfo = 16368;
  uppVDGetUniqueIDsProcInfo = 4080;
  uppVDGetVBlankRectProcInfo = 3824;
  uppVDGetVideoDefaultsProcInfo = 4194288;
  uppVDGetWhiteLevelValueProcInfo = 1008;
  uppVDGrabOneFrameAsyncProcInfo = 752;
  uppVDGrabOneFrameProcInfo = 240;
  uppVDPreflightDestinationProcInfo = 65520;
  uppVDPreflightGlobalRectProcInfo = 4080;
  uppVDReleaseAsyncBuffersProcInfo = 240;
  uppVDReleaseCompressBufferProcInfo = 1008;
  uppVDResetCompressSequenceProcInfo = 240;
  uppVDSelectUniqueIDsProcInfo = 4080;
  uppVDSetBlackLevelValueProcInfo = 1008;
  uppVDSetBrightnessProcInfo = 1008;
  uppVDSetClipRgnProcInfo = 1008;
  uppVDSetClipStateProcInfo = 752;
  uppVDSetCompressionOnOffProcInfo = 496;
  uppVDSetCompressionProcInfo = 1047536;
  uppVDSetContrastProcInfo = 1008;
  uppVDSetDataRateProcInfo = 1008;
  uppVDSetDestinationPortProcInfo = 1008;
  uppVDSetDigitizerRectProcInfo = 1008;
  uppVDSetDigitizerUserInterruptProcInfo = 16368;
  uppVDSetFieldPreferenceProcInfo = 752;
  uppVDSetFrameRateProcInfo = 1008;
  uppVDSetHueProcInfo = 1008;
  uppVDSetInputColorSpaceModeProcInfo = 752;
  uppVDSetInputGammaRecordProcInfo = 1008;
  uppVDSetInputGammaValueProcInfo = 16368;
  uppVDSetInputProcInfo = 752;
  uppVDSetInputStandardProcInfo = 752;
  uppVDSetKeyColorProcInfo = 1008;
  uppVDSetKeyColorRangeProcInfo = 4080;
  uppVDSetMasterBlendLevelProcInfo = 1008;
  uppVDSetPLLFilterTypeProcInfo = 752;
  uppVDSetPlayThruDestinationProcInfo = 65520;
  uppVDSetPlayThruGlobalRectProcInfo = 4080;
  uppVDSetPlayThruOnOffProcInfo = 752;
  uppVDSetPreferredImageDimensionsProcInfo = 4080;
  uppVDSetPreferredPacketSizeProcInfo = 1008;
  uppVDSetSaturationProcInfo = 1008;
  uppVDSetSharpnessProcInfo = 1008;
  uppVDSetTimeBaseProcInfo = 1008;
  uppVDSetWhiteLevelValueProcInfo = 1008;
  uppVDSetupBuffersProcInfo = 1008;
  uppVDUseSafeBuffersProcInfo = 496;
  uppVDUseThisCLUTProcInfo = 1008;

// ===== External functions =====

const
  libQuicktime = '/System/Library/Frameworks/Quicktime.framework/Quicktime';


implementation

end.
