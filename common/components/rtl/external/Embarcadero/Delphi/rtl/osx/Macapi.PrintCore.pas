{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework PrintCore
//
// Copyright (c) 2000-2006,2008 Apple Inc. All Rights Reserved.
//

unit Macapi.PrintCore;

interface

uses
  Macapi.ObjCRuntime,
  Macapi.ObjectiveC,
  Macapi.CocoaTypes,
  Macapi.CoreServices,
//  Macapi.ColorSync,
  Macapi.CoreGraphics,
  Macapi.CoreFoundation,
  Macapi.Security,
  Macapi.SystemConfiguration,
//  Macapi.HIServices,
  Macapi.Foundation;

const
  PM_USE_SESSION_APIS = 1;
  kAllPPDDomains = 1;
  kCUPSPPDDomain = 6;
  kLocalPPDDomain = 3;
  kNetworkPPDDomain = 4;
  kPMAllocationFailure = -108;
  kPMBorderDoubleHairline = 2;
  kPMBorderDoubleThickline = 4;
  kPMBorderSingleHairline = 1;
  kPMBorderSingleThickline = 3;
  kPMCMYKColorSpaceModel = 3;
  kPMCVMSymbolNotFound = -9662;
  kPMCancel = 128;
  kPMCloseFailed = -9785;
  kPMCollateAEKey = 1819763564;
  kPMCollateAEType = 1651470188;
  kPMColorSpaceModelCount = 4;
  kPMCopieAEType = 1819242087;
  kPMCopiesAEKey = 1819763568;
  kPMCoverPageAfter = 3;
  kPMCoverPageBefore = 2;
  kPMCoverPageDefault = 1;
  kPMCoverPageNone = 1;
  kPMCreateMessageFailed = -9620;
  kPMDataFormatXMLCompressed = 2;
  kPMDataFormatXMLDefault = 0;
  kPMDataFormatXMLMinimal = 1;
  kPMDeleteSubTicketFailed = -9585;
  kPMDestinationFax = 3;
  kPMDestinationFile = 2;
  kPMDestinationInvalid = 0;
  kPMDestinationPreview = 4;
  kPMDestinationPrinter = 1;
  kPMDestinationProcessPDF = 5;
  kPMDestinationTypeDefault = 1;
  kPMDevNColorSpaceModel = 4;
  kPMDocumentNotFound = -9644;
  kPMDontSwitchPDEError = -9531;
  kPMDuplexDefault = 1;
  kPMDuplexNoTumble = 2;
  kPMDuplexNone = 1;
  kPMDuplexTumble = 3;
  kPMEditRequestFailed = -9544;
  kPMErrorHandlingAEKey = 1819764072;
  kPMErrorHandlingAEType = 1701737837;
  kPMErrorHandlingDetailedEnum = 1819763828;
  kPMErrorHandlingStandardEnum = 1819767668;
  kPMFaxNumberAEKey = 1717663854;
  kPMFaxNumberAEType = 1413830740;
  kPMFeatureAEKey = 1819766886;
  kPMFeatureAEType = 1818850164;
  kPMFeatureNotInstalled = -9533;
  kPMFileOrDirOperationFailed = -9634;
  kPMFirstPageAEKey = 1819764336;
  kPMFirstPageAEType = 1819242087;
  kPMFontNameTooLong = -9704;
  kPMFontNotFound = -9703;
  kPMGeneralCGError = -9705;
  kPMGeneralError = -30870;
  kPMGrayColorSpaceModel = 1;
  kPMHideInlineItems = 0;
  kPMIOAttrNotAvailable = -9787;
  kPMIOMSymbolNotFound = -9661;
  kPMInternalError = -30870;
  kPMInvalidAllocator = -30890;
  kPMInvalidCVMContext = -9665;
  kPMInvalidCalibrationTarget = -30898;
  kPMInvalidConnection = -30887;
  kPMInvalidFileType = -30895;
  kPMInvalidIOMContext = -9664;
  kPMInvalidIndex = -30882;
  kPMInvalidItem = -30892;
  kPMInvalidJobID = -9666;
  kPMInvalidJobTemplate = -30885;
  kPMInvalidKey = -30888;
  kPMInvalidLookupSpec = -9542;
  kPMInvalidObject = -30896;
  kPMInvalidPBMRef = -9540;
  kPMInvalidPDEContext = -9530;
  kPMInvalidPMContext = -9663;
  kPMInvalidPageFormat = -30876;
  kPMInvalidPaper = -30897;
  kPMInvalidParameter = -50;
  kPMInvalidPreset = -30899;
  kPMInvalidPrintSession = -30879;
  kPMInvalidPrintSettings = -30875;
  kPMInvalidPrinter = -30880;
  kPMInvalidPrinterAddress = -9780;
  kPMInvalidPrinterInfo = -30886;
  kPMInvalidReply = -30894;
  kPMInvalidState = -9706;
  kPMInvalidSubTicket = -9584;
  kPMInvalidTicket = -30891;
  kPMInvalidType = -30893;
  kPMInvalidValue = -30889;
  kPMItemIsLocked = -9586;
  kPMJobBusy = -9642;
  kPMJobCanceled = -9643;
  kPMJobGetTicketBadFormatError = -9672;
  kPMJobGetTicketReadError = -9673;
  kPMJobManagerAborted = -9671;
  kPMJobNotFound = -9641;
  kPMJobStreamEndError = -9670;
  kPMJobStreamOpenFailed = -9668;
  kPMJobStreamReadFailed = -9669;
  kPMKeyNotFound = -9589;
  kPMKeyNotUnique = -9590;
  kPMKeyOrValueNotFound = -9623;
  kPMLandscape = 2;
  kPMLastErrorCodeToMakeMaintenanceOfThisListEasier = -9799;
  kPMLastPageAEKey = 1819765872;
  kPMLastPageAEType = 1819242087;
  kPMLayoutAcrossAEKey = 1819765857;
  kPMLayoutAcrossAEType = 1819242087;
  kPMLayoutBottomTopLeftRight = 7;
  kPMLayoutBottomTopRightLeft = 8;
  kPMLayoutDownAEKey = 1819765860;
  kPMLayoutDownAEType = 1819242087;
  kPMLayoutLeftRightBottomTop = 2;
  kPMLayoutLeftRightTopBottom = 1;
  kPMLayoutRightLeftBottomTop = 4;
  kPMLayoutRightLeftTopBottom = 3;
  kPMLayoutTopBottomLeftRight = 5;
  kPMLayoutTopBottomRightLeft = 6;
  kPMLockIgnored = -30878;
  kPMMessagingError = -9624;
  kPMNoDefaultItem = -9500;
  kPMNoDefaultPrinter = -30872;
  kPMNoDefaultSettings = -9501;
  kPMNoError = 0;
  kPMNoPrinterJobID = -9667;
  kPMNoSelectedPrinters = -9541;
  kPMNoSuchEntry = -30874;
  kPMNotImplemented = -30873;
  kPMObjectInUse = -30881;
  kPMOpenFailed = -9781;
  kPMOutOfScope = -30871;
  kPMPMSymbolNotFound = -9660;
  kPMPageToPaperMappingNone = 1;
  kPMPageToPaperMappingScaleToFit = 2;
  kPMPaperTypeCoated = 2;
  kPMPaperTypeGlossy = 4;
  kPMPaperTypePlain = 1;
  kPMPaperTypePremium = 3;
  kPMPaperTypeTShirt = 6;
  kPMPaperTypeTransparency = 5;
  kPMPaperTypeUnknown = 0;
  kPMPermissionError = -9636;
  kPMPluginNotFound = -9701;
  kPMPluginRegisterationFailed = -9702;
  kPMPortrait = 1;
  kPMPrBrowserNoUI = -9545;
  kPMPrintAllPages = -1;
  kPMPrintSettingsAEType = 1886610804;
  kPMPrintTimeAEKey = 1819767156;
  kPMPrintTimeAEType = 1818522656;
  kPMPrinterAEType = 1953656946;
  kPMPrinterIdle = 3;
  kPMPrinterProcessing = 4;
  kPMPrinterStopped = 5;
  kPMQualityBest = 13;
  kPMQualityDraft = 4;
  kPMQualityHighest = 15;
  kPMQualityInkSaver = 1;
  kPMQualityLowest = 0;
  kPMQualityNormal = 8;
  kPMQualityPhoto = 11;
  kPMQueueAlreadyExists = -9639;
  kPMQueueJobFailed = -9640;
  kPMQueueNotFound = -9638;
  kPMRGBColorSpaceModel = 2;
  kPMReadFailed = -9782;
  kPMReadGotZeroData = -9788;
  kPMReverseLandscape = 4;
  kPMReversePortrait = 3;
  kPMScalingCenterOnImgArea = 6;
  kPMScalingCenterOnPaper = 5;
  kPMScalingPinBottomLeft = 3;
  kPMScalingPinBottomRight = 4;
  kPMScalingPinTopLeft = 1;
  kPMScalingPinTopRight = 2;
  kPMServerAlreadyRunning = -9631;
  kPMServerAttributeRestricted = -9633;
  kPMServerCommunicationFailed = -9621;
  kPMServerNotFound = -9630;
  kPMServerSuspended = -9632;
  kPMShowDefaultInlineItems = 32768;
  kPMShowInlineCopies = 1;
  kPMShowInlineOrientation = 8;
  kPMShowInlinePageRange = 2;
  kPMShowInlinePageRangeWithSelection = 64;
  kPMShowInlinePaperSize = 4;
  kPMShowInlineScale = 128;
  kPMShowPageAttributesPDE = 256;
  kPMShowPrintDialogAEType = 1885629543;
  kPMSimplexTumble = 4;
  kPMStatusFailed = -9784;
  kPMStringConversionFailure = -30883;
  kPMSubTicketNotFound = -9583;
  kPMSyncRequestFailed = -9543;
  kPMTargetPrinterAEKey = 1953656946;
  kPMTargetPrinterAEType = 1413830740;
  kPMTemplateIsLocked = -9588;
  kPMTicketIsLocked = -9587;
  kPMTicketTypeNotFound = -9580;
  kPMUnableToFindProcess = -9532;
  kPMUnexpectedImagingError = -9707;
  kPMUnknownColorSpaceModel = 0;
  kPMUnknownDataType = -9591;
  kPMUnknownMessage = -9637;
  kPMUnlocked = 0;
  kPMUnsupportedConnection = -9786;
  kPMUpdateTicketFailed = -9581;
  kPMUserOrGroupNotFound = -9635;
  kPMValidateTicketFailed = -9582;
  kPMValueOutOfRange = -30877;
  kPMWriteFailed = -9783;
  kPMXMLParseError = -30884;
  kSystemPPDDomain = 2;
  kUserPPDDomain = 5;

// ===== External functions =====

const
  libPrintCore = '/System/Library/Frameworks/ApplicationServices.framework/Frameworks/PrintCore.framework/PrintCore';

function PMCGImageCreateWithEPSDataProvider(epsDataProvider: CGDataProviderRef; epsPreview: CGImageRef): CGImageRef; cdecl; external libPrintCore name _PU + 'PMCGImageCreateWithEPSDataProvider';
function PMCopyAvailablePPDs(domain: PMPPDDomain; ppds: PCFArrayRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMCopyAvailablePPDs';
function PMCopyLocalizedPPD(ppd: CFURLRef; localizedPPD: PCFURLRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMCopyLocalizedPPD';
function PMCopyPPDData(ppd: CFURLRef; data: PCFDataRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMCopyPPDData';
function PMCopyPageFormat(formatSrc: PMPageFormat; formatDest: PMPageFormat): OSStatus; cdecl; external libPrintCore name _PU + 'PMCopyPageFormat';
function PMCopyPrintSettings(settingSrc: PMPrintSettings; settingDest: PMPrintSettings): OSStatus; cdecl; external libPrintCore name _PU + 'PMCopyPrintSettings';
function PMCreateGenericPrinter(printer: PPMPrinter): OSStatus; cdecl; external libPrintCore name _PU + 'PMCreateGenericPrinter';
function PMCreatePageFormat(pageFormat: PPMPageFormat): OSStatus; cdecl; external libPrintCore name _PU + 'PMCreatePageFormat';
function PMCreatePageFormatWithPMPaper(pageFormat: PPMPageFormat; paper: PMPaper): OSStatus; cdecl; external libPrintCore name _PU + 'PMCreatePageFormatWithPMPaper';
function PMCreatePrintSettings(printSettings: PPMPrintSettings): OSStatus; cdecl; external libPrintCore name _PU + 'PMCreatePrintSettings';
function PMCreateSession(printSession: PPMPrintSession): OSStatus; cdecl; external libPrintCore name _PU + 'PMCreateSession';
function PMFlattenPageFormatToCFData(pageFormat: PMPageFormat; flatFormat: PCFDataRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMFlattenPageFormatToCFData';
function PMFlattenPageFormatToURL(pageFormat: PMPageFormat; flattenFileURL: CFURLRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMFlattenPageFormatToURL';
function PMFlattenPrintSettingsToCFData(printSettings: PMPrintSettings; flatSetting: PCFDataRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMFlattenPrintSettingsToCFData';
function PMFlattenPrintSettingsToURL(printSettings: PMPrintSettings; flattenFileURL: CFURLRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMFlattenPrintSettingsToURL';
function PMGetAdjustedPageRect(pageFormat: PMPageFormat; pageRect: PPMRect): OSStatus; cdecl; external libPrintCore name _PU + 'PMGetAdjustedPageRect';
function PMGetAdjustedPaperRect(pageFormat: PMPageFormat; paperRect: PPMRect): OSStatus; cdecl; external libPrintCore name _PU + 'PMGetAdjustedPaperRect';
function PMGetCollate(printSettings: PMPrintSettings; collate: PBoolean): OSStatus; cdecl; external libPrintCore name _PU + 'PMGetCollate';
function PMGetCopies(printSettings: PMPrintSettings; copies: PUInt32): OSStatus; cdecl; external libPrintCore name _PU + 'PMGetCopies';
function PMGetDuplex(printSettings: PMPrintSettings; duplexSetting: PPMDuplexMode): OSStatus; cdecl; external libPrintCore name _PU + 'PMGetDuplex';
function PMGetFirstPage(printSettings: PMPrintSettings; first: PUInt32): OSStatus; cdecl; external libPrintCore name _PU + 'PMGetFirstPage';
function PMGetLastPage(printSettings: PMPrintSettings; last: PUInt32): OSStatus; cdecl; external libPrintCore name _PU + 'PMGetLastPage';
function PMGetOrientation(pageFormat: PMPageFormat; orientation: PPMOrientation): OSStatus; cdecl; external libPrintCore name _PU + 'PMGetOrientation';
function PMGetPageFormatExtendedData(pageFormat: PMPageFormat; dataID: OSType; size: PUInt32; extendedData: Pointer): OSStatus; cdecl; external libPrintCore name _PU + 'PMGetPageFormatExtendedData';
function PMGetPageFormatPaper(format: PMPageFormat; paper: PPMPaper): OSStatus; cdecl; external libPrintCore name _PU + 'PMGetPageFormatPaper';
function PMGetPageRange(printSettings: PMPrintSettings; minPage: PUInt32; maxPage: PUInt32): OSStatus; cdecl; external libPrintCore name _PU + 'PMGetPageRange';
function PMGetPrintSettingsExtendedData(printSettings: PMPrintSettings; dataID: OSType; size: PUInt32; extendedData: Pointer): OSStatus; cdecl; external libPrintCore name _PU + 'PMGetPrintSettingsExtendedData';
function PMGetScale(pageFormat: PMPageFormat; scale: PDouble): OSStatus; cdecl; external libPrintCore name _PU + 'PMGetScale';
function PMGetUnadjustedPageRect(pageFormat: PMPageFormat; pageRect: PPMRect): OSStatus; cdecl; external libPrintCore name _PU + 'PMGetUnadjustedPageRect';
function PMGetUnadjustedPaperRect(pageFormat: PMPageFormat; paperRect: PPMRect): OSStatus; cdecl; external libPrintCore name _PU + 'PMGetUnadjustedPaperRect';
function PMPageFormatCreateDataRepresentation(pageFormat: PMPageFormat; data: PCFDataRef; format: PMDataFormat): OSStatus; cdecl; external libPrintCore name _PU + 'PMPageFormatCreateDataRepresentation';
function PMPageFormatCreateWithDataRepresentation(data: CFDataRef; pageFormat: PPMPageFormat): OSStatus; cdecl; external libPrintCore name _PU + 'PMPageFormatCreateWithDataRepresentation';
function PMPageFormatGetPrinterID(pageFormat: PMPageFormat; printerID: PCFStringRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPageFormatGetPrinterID';
function PMPaperCreateCustom(printer: PMPrinter; id: CFStringRef; name: CFStringRef; width: double; height: double; margins: PPMPaperMargins; paperP: PPMPaper): OSStatus; cdecl; external libPrintCore name _PU + 'PMPaperCreateCustom';
function PMPaperCreateLocalizedName(paper: PMPaper; printer: PMPrinter; paperName: PCFStringRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPaperCreateLocalizedName';
function PMPaperGetHeight(paper: PMPaper; paperHeight: PDouble): OSStatus; cdecl; external libPrintCore name _PU + 'PMPaperGetHeight';
function PMPaperGetID(paper: PMPaper; paperID: PCFStringRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPaperGetID';
function PMPaperGetMargins(paper: PMPaper; paperMargins: PPMPaperMargins): OSStatus; cdecl; external libPrintCore name _PU + 'PMPaperGetMargins';
function PMPaperGetName(paper: PMPaper; paperName: PCFStringRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPaperGetName';
function PMPaperGetPPDPaperName(paper: PMPaper; paperName: PCFStringRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPaperGetPPDPaperName';
function PMPaperGetPrinterID(paper: PMPaper; printerID: PCFStringRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPaperGetPrinterID';
function PMPaperGetWidth(paper: PMPaper; paperWidth: PDouble): OSStatus; cdecl; external libPrintCore name _PU + 'PMPaperGetWidth';
function PMPaperIsCustom(paper: PMPaper): Boolean; cdecl; external libPrintCore name _PU + 'PMPaperIsCustom';
function PMPresetCopyName(preset: PMPreset; name: PCFStringRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPresetCopyName';
function PMPresetCreatePrintSettings(preset: PMPreset; session: PMPrintSession; printSettings: PPMPrintSettings): OSStatus; cdecl; external libPrintCore name _PU + 'PMPresetCreatePrintSettings';
function PMPresetGetAttributes(preset: PMPreset; attributes: PCFDictionaryRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPresetGetAttributes';
function PMPrintSettingsCopyAsDictionary(printSettings: PMPrintSettings; settingsDictionary: PCFDictionaryRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrintSettingsCopyAsDictionary';
function PMPrintSettingsCopyKeys(printSettings: PMPrintSettings; settingsKeys: PCFArrayRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrintSettingsCopyKeys';
function PMPrintSettingsCreateDataRepresentation(printSettings: PMPrintSettings; data: PCFDataRef; format: PMDataFormat): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrintSettingsCreateDataRepresentation';
function PMPrintSettingsCreateWithDataRepresentation(data: CFDataRef; printSettings: PPMPrintSettings): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrintSettingsCreateWithDataRepresentation';
function PMPrintSettingsGetJobName(printSettings: PMPrintSettings; name: PCFStringRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrintSettingsGetJobName';
function PMPrintSettingsGetValue(printSettings: PMPrintSettings; key: CFStringRef; value: PCFTypeRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrintSettingsGetValue';
function PMPrintSettingsSetJobName(printSettings: PMPrintSettings; name: CFStringRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrintSettingsSetJobName';
function PMPrintSettingsSetValue(printSettings: PMPrintSettings; key: CFStringRef; value: CFTypeRef; locked: Boolean): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrintSettingsSetValue';
function PMPrintSettingsToOptions(settings: PMPrintSettings; options: Pchar): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrintSettingsToOptions';
function PMPrintSettingsToOptionsWithPrinterAndPageFormat(settings: PMPrintSettings; printer: PMPrinter; pageFormat: PMPageFormat; options: Pchar): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrintSettingsToOptionsWithPrinterAndPageFormat';
function PMPrinterCopyDescriptionURL(printer: PMPrinter; descriptionType: CFStringRef; fileURL: PCFURLRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterCopyDescriptionURL';
function PMPrinterCopyDeviceURI(printer: PMPrinter; deviceURI: PCFURLRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterCopyDeviceURI';
function PMPrinterCopyHostName(printer: PMPrinter; hostNameP: PCFStringRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterCopyHostName';
function PMPrinterCopyPresets(printer: PMPrinter; presetList: PCFArrayRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterCopyPresets';
function PMPrinterCopyState(printer: PMPrinter; stateDict: PCFDictionaryRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterCopyState';
function PMPrinterCreateFromPrinterID(printerID: CFStringRef): PMPrinter; cdecl; external libPrintCore name _PU + 'PMPrinterCreateFromPrinterID';
function PMPrinterGetCommInfo(printer: PMPrinter; supportsControlCharRangeP: PBoolean; supportsEightBitP: PBoolean): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterGetCommInfo';
function PMPrinterGetDriverCreator(printer: PMPrinter; creator: POSType): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterGetDriverCreator';
function PMPrinterGetDriverReleaseInfo(printer: PMPrinter; release: VersRecPtr): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterGetDriverReleaseInfo';
function PMPrinterGetID(printer: PMPrinter): CFStringRef; cdecl; external libPrintCore name _PU + 'PMPrinterGetID';
function PMPrinterGetIndexedPrinterResolution(printer: PMPrinter; index: UInt32; resolutionP: PPMResolution): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterGetIndexedPrinterResolution';
function PMPrinterGetLanguageInfo(printer: PMPrinter; info: PPMLanguageInfo): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterGetLanguageInfo';
function PMPrinterGetLocation(printer: PMPrinter): CFStringRef; cdecl; external libPrintCore name _PU + 'PMPrinterGetLocation';
function PMPrinterGetMakeAndModelName(printer: PMPrinter; makeAndModel: PCFStringRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterGetMakeAndModelName';
function PMPrinterGetMimeTypes(printer: PMPrinter; settings: PMPrintSettings; mimeTypes: PCFArrayRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterGetMimeTypes';
function PMPrinterGetName(printer: PMPrinter): CFStringRef; cdecl; external libPrintCore name _PU + 'PMPrinterGetName';
function PMPrinterGetOutputResolution(printer: PMPrinter; printSettings: PMPrintSettings; resolutionP: PPMResolution): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterGetOutputResolution';
function PMPrinterGetPaperList(printer: PMPrinter; paperList: PCFArrayRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterGetPaperList';
function PMPrinterGetPrinterResolutionCount(printer: PMPrinter; countP: PUInt32): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterGetPrinterResolutionCount';
function PMPrinterGetState(printer: PMPrinter; state: PPMPrinterState): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterGetState';
function PMPrinterIsDefault(printer: PMPrinter): Boolean; cdecl; external libPrintCore name _PU + 'PMPrinterIsDefault';
function PMPrinterIsFavorite(printer: PMPrinter): Boolean; cdecl; external libPrintCore name _PU + 'PMPrinterIsFavorite';
function PMPrinterIsPostScriptCapable(printer: PMPrinter): Boolean; cdecl; external libPrintCore name _PU + 'PMPrinterIsPostScriptCapable';
function PMPrinterIsPostScriptPrinter(printer: PMPrinter; isPSPrinter: PBoolean): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterIsPostScriptPrinter';
function PMPrinterIsRemote(printer: PMPrinter; isRemoteP: PBoolean): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterIsRemote';
function PMPrinterPrintWithFile(printer: PMPrinter; settings: PMPrintSettings; format: PMPageFormat; mimeType: CFStringRef; fileURL: CFURLRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterPrintWithFile';
function PMPrinterPrintWithProvider(printer: PMPrinter; settings: PMPrintSettings; format: PMPageFormat; mimeType: CFStringRef; provider: CGDataProviderRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterPrintWithProvider';
function PMPrinterSendCommand(printer: PMPrinter; commandString: CFStringRef; jobTitle: CFStringRef; options: CFDictionaryRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterSendCommand';
function PMPrinterSetDefault(printer: PMPrinter): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterSetDefault';
function PMPrinterSetOutputResolution(printer: PMPrinter; printSettings: PMPrintSettings; resolutionP: PPMResolution): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterSetOutputResolution';
function PMPrinterWritePostScriptToURL(printer: PMPrinter; settings: PMPrintSettings; format: PMPageFormat; mimeType: CFStringRef; sourceFileURL: CFURLRef; destinationFileURL: CFURLRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMPrinterWritePostScriptToURL';
function PMRelease(object_: PMObject): OSStatus; cdecl; external libPrintCore name _PU + 'PMRelease';
function PMRetain(object_: PMObject): OSStatus; cdecl; external libPrintCore name _PU + 'PMRetain';
function PMServerCreatePrinterList(server: PMServer; printerList: PCFArrayRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMServerCreatePrinterList';
function PMServerLaunchPrinterBrowser(server: PMServer; options: CFDictionaryRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMServerLaunchPrinterBrowser';
function PMSessionBeginCGDocumentNoDialog(printSession: PMPrintSession; printSettings: PMPrintSettings; pageFormat: PMPageFormat): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionBeginCGDocumentNoDialog';
function PMSessionBeginPageNoDialog(printSession: PMPrintSession; pageFormat: PMPageFormat; pageFrame: PPMRect): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionBeginPageNoDialog';
function PMSessionCopyDestinationFormat(printSession: PMPrintSession; printSettings: PMPrintSettings; destFormatP: PCFStringRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionCopyDestinationFormat';
function PMSessionCopyDestinationLocation(printSession: PMPrintSession; printSettings: PMPrintSettings; destLocationP: PCFURLRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionCopyDestinationLocation';
function PMSessionCopyOutputFormatList(printSession: PMPrintSession; destType: PMDestinationType; documentFormatP: PCFArrayRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionCopyOutputFormatList';
function PMSessionCreatePageFormatList(printSession: PMPrintSession; printer: PMPrinter; pageFormatList: PCFArrayRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionCreatePageFormatList';
function PMSessionCreatePrinterList(printSession: PMPrintSession; printerList: PCFArrayRef; currentIndex: PCFIndex; currentPrinter: PPMPrinter): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionCreatePrinterList';
function PMSessionDefaultPageFormat(printSession: PMPrintSession; pageFormat: PMPageFormat): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionDefaultPageFormat';
function PMSessionDefaultPrintSettings(printSession: PMPrintSession; printSettings: PMPrintSettings): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionDefaultPrintSettings';
function PMSessionEndDocumentNoDialog(printSession: PMPrintSession): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionEndDocumentNoDialog';
function PMSessionEndPageNoDialog(printSession: PMPrintSession): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionEndPageNoDialog';
function PMSessionError(printSession: PMPrintSession): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionError';
function PMSessionGetCGGraphicsContext(printSession: PMPrintSession; context: PCGContextRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionGetCGGraphicsContext';
function PMSessionGetCurrentPrinter(printSession: PMPrintSession; currentPrinter: PPMPrinter): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionGetCurrentPrinter';
function PMSessionGetDataFromSession(printSession: PMPrintSession; key: CFStringRef; data: PCFTypeRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionGetDataFromSession';
function PMSessionGetDestinationType(printSession: PMPrintSession; printSettings: PMPrintSettings; destTypeP: PPMDestinationType): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionGetDestinationType';
function PMSessionSetCurrentPMPrinter(session: PMPrintSession; printer: PMPrinter): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionSetCurrentPMPrinter';
function PMSessionSetDataInSession(printSession: PMPrintSession; key: CFStringRef; data: CFTypeRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionSetDataInSession';
function PMSessionSetDestination(printSession: PMPrintSession; printSettings: PMPrintSettings; destType: PMDestinationType; destFormat: CFStringRef; destLocation: CFURLRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionSetDestination';
function PMSessionSetError(printSession: PMPrintSession; printError: OSStatus): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionSetError';
function PMSessionValidatePageFormat(printSession: PMPrintSession; pageFormat: PMPageFormat; result: PBoolean): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionValidatePageFormat';
function PMSessionValidatePrintSettings(printSession: PMPrintSession; printSettings: PMPrintSettings; result: PBoolean): OSStatus; cdecl; external libPrintCore name _PU + 'PMSessionValidatePrintSettings';
function PMSetCollate(printSettings: PMPrintSettings; collate: Boolean): OSStatus; cdecl; external libPrintCore name _PU + 'PMSetCollate';
function PMSetCopies(printSettings: PMPrintSettings; copies: UInt32; lock: Boolean): OSStatus; cdecl; external libPrintCore name _PU + 'PMSetCopies';
function PMSetDuplex(printSettings: PMPrintSettings; duplexSetting: PMDuplexMode): OSStatus; cdecl; external libPrintCore name _PU + 'PMSetDuplex';
function PMSetFirstPage(printSettings: PMPrintSettings; first: UInt32; lock: Boolean): OSStatus; cdecl; external libPrintCore name _PU + 'PMSetFirstPage';
function PMSetLastPage(printSettings: PMPrintSettings; last: UInt32; lock: Boolean): OSStatus; cdecl; external libPrintCore name _PU + 'PMSetLastPage';
function PMSetOrientation(pageFormat: PMPageFormat; orientation: PMOrientation; lock: Boolean): OSStatus; cdecl; external libPrintCore name _PU + 'PMSetOrientation';
function PMSetPageFormatExtendedData(pageFormat: PMPageFormat; dataID: OSType; size: UInt32; extendedData: Pointer): OSStatus; cdecl; external libPrintCore name _PU + 'PMSetPageFormatExtendedData';
function PMSetPageRange(printSettings: PMPrintSettings; minPage: UInt32; maxPage: UInt32): OSStatus; cdecl; external libPrintCore name _PU + 'PMSetPageRange';
function PMSetPrintSettingsExtendedData(printSettings: PMPrintSettings; dataID: OSType; size: UInt32; extendedData: Pointer): OSStatus; cdecl; external libPrintCore name _PU + 'PMSetPrintSettingsExtendedData';
function PMSetScale(pageFormat: PMPageFormat; scale: double): OSStatus; cdecl; external libPrintCore name _PU + 'PMSetScale';
function PMUnflattenPageFormatWithCFData(flattenCFData: CFDataRef; pageFormat: PPMPageFormat): OSStatus; cdecl; external libPrintCore name _PU + 'PMUnflattenPageFormatWithCFData';
function PMUnflattenPageFormatWithURL(flattenFileURL: CFURLRef; pageFormat: PPMPageFormat): OSStatus; cdecl; external libPrintCore name _PU + 'PMUnflattenPageFormatWithURL';
function PMUnflattenPrintSettingsWithCFData(flattenCFData: CFDataRef; printSettings: PPMPrintSettings): OSStatus; cdecl; external libPrintCore name _PU + 'PMUnflattenPrintSettingsWithCFData';
function PMUnflattenPrintSettingsWithURL(flattenFileURL: CFURLRef; printSettings: PPMPrintSettings): OSStatus; cdecl; external libPrintCore name _PU + 'PMUnflattenPrintSettingsWithURL';
function PMWorkflowCopyItems(workflowItems: PCFArrayRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMWorkflowCopyItems';
function PMWorkflowSubmitPDFWithOptions(workflowItem: CFURLRef; title: CFStringRef; options: MarshaledAString; pdfFile: CFURLRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMWorkflowSubmitPDFWithOptions';
function PMWorkflowSubmitPDFWithSettings(workflowItem: CFURLRef; settings: PMPrintSettings; pdfFile: CFURLRef): OSStatus; cdecl; external libPrintCore name _PU + 'PMWorkflowSubmitPDFWithSettings';

implementation

end.
