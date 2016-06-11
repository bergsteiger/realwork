{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
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
  Macapi.CocoaTypes,
  Macapi.CoreServices,
  Macapi.CoreFoundation;

const
  PM_USE_SESSION_APIS = 1;
  {$EXTERNALSYM PM_USE_SESSION_APIS}
  kAllPPDDomains = 1;
  {$EXTERNALSYM kAllPPDDomains}
  kCUPSPPDDomain = 6;
  {$EXTERNALSYM kCUPSPPDDomain}
  kLocalPPDDomain = 3;
  {$EXTERNALSYM kLocalPPDDomain}
  kNetworkPPDDomain = 4;
  {$EXTERNALSYM kNetworkPPDDomain}
  kPMAllocationFailure = -108;
  {$EXTERNALSYM kPMAllocationFailure}
  kPMBorderDoubleHairline = 2;
  {$EXTERNALSYM kPMBorderDoubleHairline}
  kPMBorderDoubleThickline = 4;
  {$EXTERNALSYM kPMBorderDoubleThickline}
  kPMBorderSingleHairline = 1;
  {$EXTERNALSYM kPMBorderSingleHairline}
  kPMBorderSingleThickline = 3;
  {$EXTERNALSYM kPMBorderSingleThickline}
  kPMCMYKColorSpaceModel = 3;
  {$EXTERNALSYM kPMCMYKColorSpaceModel}
  kPMCVMSymbolNotFound = -9662;
  {$EXTERNALSYM kPMCVMSymbolNotFound}
  kPMCancel = 128;
  {$EXTERNALSYM kPMCancel}
  kPMCloseFailed = -9785;
  {$EXTERNALSYM kPMCloseFailed}
  kPMCollateAEKey = 1819763564;
  {$EXTERNALSYM kPMCollateAEKey}
  kPMCollateAEType = 1651470188;
  {$EXTERNALSYM kPMCollateAEType}
  kPMColorSpaceModelCount = 4;
  {$EXTERNALSYM kPMColorSpaceModelCount}
  kPMCopieAEType = 1819242087;
  {$EXTERNALSYM kPMCopieAEType}
  kPMCopiesAEKey = 1819763568;
  {$EXTERNALSYM kPMCopiesAEKey}
  kPMCoverPageAfter = 3;
  {$EXTERNALSYM kPMCoverPageAfter}
  kPMCoverPageBefore = 2;
  {$EXTERNALSYM kPMCoverPageBefore}
  kPMCoverPageDefault = 1;
  {$EXTERNALSYM kPMCoverPageDefault}
  kPMCoverPageNone = 1;
  {$EXTERNALSYM kPMCoverPageNone}
  kPMCreateMessageFailed = -9620;
  {$EXTERNALSYM kPMCreateMessageFailed}
  kPMDataFormatXMLCompressed = 2;
  {$EXTERNALSYM kPMDataFormatXMLCompressed}
  kPMDataFormatXMLDefault = 0;
  {$EXTERNALSYM kPMDataFormatXMLDefault}
  kPMDataFormatXMLMinimal = 1;
  {$EXTERNALSYM kPMDataFormatXMLMinimal}
  kPMDeleteSubTicketFailed = -9585;
  {$EXTERNALSYM kPMDeleteSubTicketFailed}
  kPMDestinationFax = 3;
  {$EXTERNALSYM kPMDestinationFax}
  kPMDestinationFile = 2;
  {$EXTERNALSYM kPMDestinationFile}
  kPMDestinationInvalid = 0;
  {$EXTERNALSYM kPMDestinationInvalid}
  kPMDestinationPreview = 4;
  {$EXTERNALSYM kPMDestinationPreview}
  kPMDestinationPrinter = 1;
  {$EXTERNALSYM kPMDestinationPrinter}
  kPMDestinationProcessPDF = 5;
  {$EXTERNALSYM kPMDestinationProcessPDF}
  kPMDestinationTypeDefault = 1;
  {$EXTERNALSYM kPMDestinationTypeDefault}
  kPMDevNColorSpaceModel = 4;
  {$EXTERNALSYM kPMDevNColorSpaceModel}
  kPMDocumentNotFound = -9644;
  {$EXTERNALSYM kPMDocumentNotFound}
  kPMDontSwitchPDEError = -9531;
  {$EXTERNALSYM kPMDontSwitchPDEError}
  kPMDuplexDefault = 1;
  {$EXTERNALSYM kPMDuplexDefault}
  kPMDuplexNoTumble = 2;
  {$EXTERNALSYM kPMDuplexNoTumble}
  kPMDuplexNone = 1;
  {$EXTERNALSYM kPMDuplexNone}
  kPMDuplexTumble = 3;
  {$EXTERNALSYM kPMDuplexTumble}
  kPMEditRequestFailed = -9544;
  {$EXTERNALSYM kPMEditRequestFailed}
  kPMErrorHandlingAEKey = 1819764072;
  {$EXTERNALSYM kPMErrorHandlingAEKey}
  kPMErrorHandlingAEType = 1701737837;
  {$EXTERNALSYM kPMErrorHandlingAEType}
  kPMErrorHandlingDetailedEnum = 1819763828;
  {$EXTERNALSYM kPMErrorHandlingDetailedEnum}
  kPMErrorHandlingStandardEnum = 1819767668;
  {$EXTERNALSYM kPMErrorHandlingStandardEnum}
  kPMFaxNumberAEKey = 1717663854;
  {$EXTERNALSYM kPMFaxNumberAEKey}
  kPMFaxNumberAEType = 1413830740;
  {$EXTERNALSYM kPMFaxNumberAEType}
  kPMFeatureAEKey = 1819766886;
  {$EXTERNALSYM kPMFeatureAEKey}
  kPMFeatureAEType = 1818850164;
  {$EXTERNALSYM kPMFeatureAEType}
  kPMFeatureNotInstalled = -9533;
  {$EXTERNALSYM kPMFeatureNotInstalled}
  kPMFileOrDirOperationFailed = -9634;
  {$EXTERNALSYM kPMFileOrDirOperationFailed}
  kPMFirstPageAEKey = 1819764336;
  {$EXTERNALSYM kPMFirstPageAEKey}
  kPMFirstPageAEType = 1819242087;
  {$EXTERNALSYM kPMFirstPageAEType}
  kPMFontNameTooLong = -9704;
  {$EXTERNALSYM kPMFontNameTooLong}
  kPMFontNotFound = -9703;
  {$EXTERNALSYM kPMFontNotFound}
  kPMGeneralCGError = -9705;
  {$EXTERNALSYM kPMGeneralCGError}
  kPMGeneralError = -30870;
  {$EXTERNALSYM kPMGeneralError}
  kPMGrayColorSpaceModel = 1;
  {$EXTERNALSYM kPMGrayColorSpaceModel}
  kPMHideInlineItems = 0;
  {$EXTERNALSYM kPMHideInlineItems}
  kPMIOAttrNotAvailable = -9787;
  {$EXTERNALSYM kPMIOAttrNotAvailable}
  kPMIOMSymbolNotFound = -9661;
  {$EXTERNALSYM kPMIOMSymbolNotFound}
  kPMInternalError = -30870;
  {$EXTERNALSYM kPMInternalError}
  kPMInvalidAllocator = -30890;
  {$EXTERNALSYM kPMInvalidAllocator}
  kPMInvalidCVMContext = -9665;
  {$EXTERNALSYM kPMInvalidCVMContext}
  kPMInvalidCalibrationTarget = -30898;
  {$EXTERNALSYM kPMInvalidCalibrationTarget}
  kPMInvalidConnection = -30887;
  {$EXTERNALSYM kPMInvalidConnection}
  kPMInvalidFileType = -30895;
  {$EXTERNALSYM kPMInvalidFileType}
  kPMInvalidIOMContext = -9664;
  {$EXTERNALSYM kPMInvalidIOMContext}
  kPMInvalidIndex = -30882;
  {$EXTERNALSYM kPMInvalidIndex}
  kPMInvalidItem = -30892;
  {$EXTERNALSYM kPMInvalidItem}
  kPMInvalidJobID = -9666;
  {$EXTERNALSYM kPMInvalidJobID}
  kPMInvalidJobTemplate = -30885;
  {$EXTERNALSYM kPMInvalidJobTemplate}
  kPMInvalidKey = -30888;
  {$EXTERNALSYM kPMInvalidKey}
  kPMInvalidLookupSpec = -9542;
  {$EXTERNALSYM kPMInvalidLookupSpec}
  kPMInvalidObject = -30896;
  {$EXTERNALSYM kPMInvalidObject}
  kPMInvalidPBMRef = -9540;
  {$EXTERNALSYM kPMInvalidPBMRef}
  kPMInvalidPDEContext = -9530;
  {$EXTERNALSYM kPMInvalidPDEContext}
  kPMInvalidPMContext = -9663;
  {$EXTERNALSYM kPMInvalidPMContext}
  kPMInvalidPageFormat = -30876;
  {$EXTERNALSYM kPMInvalidPageFormat}
  kPMInvalidPaper = -30897;
  {$EXTERNALSYM kPMInvalidPaper}
  kPMInvalidParameter = -50;
  {$EXTERNALSYM kPMInvalidPaper}
  kPMInvalidPreset = -30899;
  {$EXTERNALSYM kPMInvalidPreset}
  kPMInvalidPrintSession = -30879;
  {$EXTERNALSYM kPMInvalidPrintSession}
  kPMInvalidPrintSettings = -30875;
  {$EXTERNALSYM kPMInvalidPrintSettings}
  kPMInvalidPrinter = -30880;
  {$EXTERNALSYM kPMInvalidPrinter}
  kPMInvalidPrinterAddress = -9780;
  {$EXTERNALSYM kPMInvalidPrinterAddress}
  kPMInvalidPrinterInfo = -30886;
  {$EXTERNALSYM kPMInvalidPrinterInfo}
  kPMInvalidReply = -30894;
  {$EXTERNALSYM kPMInvalidReply}
  kPMInvalidState = -9706;
  {$EXTERNALSYM kPMInvalidState}
  kPMInvalidSubTicket = -9584;
  {$EXTERNALSYM kPMInvalidSubTicket}
  kPMInvalidTicket = -30891;
  {$EXTERNALSYM kPMInvalidTicket}
  kPMInvalidType = -30893;
  {$EXTERNALSYM kPMInvalidType}
  kPMInvalidValue = -30889;
  {$EXTERNALSYM kPMInvalidValue}
  kPMItemIsLocked = -9586;
  {$EXTERNALSYM kPMItemIsLocked}
  kPMJobBusy = -9642;
  {$EXTERNALSYM kPMJobBusy}
  kPMJobCanceled = -9643;
  {$EXTERNALSYM kPMJobCanceled}
  kPMJobGetTicketBadFormatError = -9672;
  {$EXTERNALSYM kPMJobGetTicketBadFormatError}
  kPMJobGetTicketReadError = -9673;
  {$EXTERNALSYM kPMJobGetTicketReadError}
  kPMJobManagerAborted = -9671;
  {$EXTERNALSYM kPMJobManagerAborted}
  kPMJobNotFound = -9641;
  {$EXTERNALSYM kPMJobNotFound}
  kPMJobStreamEndError = -9670;
  {$EXTERNALSYM kPMJobStreamEndError}
  kPMJobStreamOpenFailed = -9668;
  {$EXTERNALSYM kPMJobStreamOpenFailed}
  kPMJobStreamReadFailed = -9669;
  {$EXTERNALSYM kPMJobStreamReadFailed}
  kPMKeyNotFound = -9589;
  {$EXTERNALSYM kPMKeyNotFound}
  kPMKeyNotUnique = -9590;
  {$EXTERNALSYM kPMKeyNotUnique}
  kPMKeyOrValueNotFound = -9623;
  {$EXTERNALSYM kPMKeyOrValueNotFound}
  kPMLandscape = 2;
  {$EXTERNALSYM kPMLandscape}
  kPMLastErrorCodeToMakeMaintenanceOfThisListEasier = -9799;
  {$EXTERNALSYM kPMLastErrorCodeToMakeMaintenanceOfThisListEasier}
  kPMLastPageAEKey = 1819765872;
  {$EXTERNALSYM kPMLastPageAEKey}
  kPMLastPageAEType = 1819242087;
  {$EXTERNALSYM kPMLastPageAEType}
  kPMLayoutAcrossAEKey = 1819765857;
  {$EXTERNALSYM kPMLayoutAcrossAEKey}
  kPMLayoutAcrossAEType = 1819242087;
  {$EXTERNALSYM kPMLayoutAcrossAEType}
  kPMLayoutBottomTopLeftRight = 7;
  {$EXTERNALSYM kPMLayoutBottomTopLeftRight}
  kPMLayoutBottomTopRightLeft = 8;
  {$EXTERNALSYM kPMLayoutBottomTopRightLeft}
  kPMLayoutDownAEKey = 1819765860;
  {$EXTERNALSYM kPMLayoutDownAEKey}
  kPMLayoutDownAEType = 1819242087;
  {$EXTERNALSYM kPMLayoutDownAEType}
  kPMLayoutLeftRightBottomTop = 2;
  {$EXTERNALSYM kPMLayoutLeftRightBottomTop}
  kPMLayoutLeftRightTopBottom = 1;
  {$EXTERNALSYM kPMLayoutLeftRightTopBottom}
  kPMLayoutRightLeftBottomTop = 4;
  {$EXTERNALSYM kPMLayoutRightLeftBottomTop}
  kPMLayoutRightLeftTopBottom = 3;
  {$EXTERNALSYM kPMLayoutRightLeftTopBottom}
  kPMLayoutTopBottomLeftRight = 5;
  {$EXTERNALSYM kPMLayoutTopBottomLeftRight}
  kPMLayoutTopBottomRightLeft = 6;
  {$EXTERNALSYM kPMLayoutTopBottomRightLeft}
  kPMLockIgnored = -30878;
  {$EXTERNALSYM kPMLockIgnored}
  kPMMessagingError = -9624;
  {$EXTERNALSYM kPMMessagingError}
  kPMNoDefaultItem = -9500;
  {$EXTERNALSYM kPMNoDefaultItem}
  kPMNoDefaultPrinter = -30872;
  {$EXTERNALSYM kPMNoDefaultPrinter}
  kPMNoDefaultSettings = -9501;
  {$EXTERNALSYM kPMNoDefaultSettings}
  kPMNoError = 0;
  {$EXTERNALSYM kPMNoError}
  kPMNoPrinterJobID = -9667;
  {$EXTERNALSYM kPMNoPrinterJobID}
  kPMNoSelectedPrinters = -9541;
  {$EXTERNALSYM kPMNoSelectedPrinters}
  kPMNoSuchEntry = -30874;
  {$EXTERNALSYM kPMNoSuchEntry}
  kPMNotImplemented = -30873;
  {$EXTERNALSYM kPMNotImplemented}
  kPMObjectInUse = -30881;
  {$EXTERNALSYM kPMObjectInUse}
  kPMOpenFailed = -9781;
  {$EXTERNALSYM kPMOpenFailed}
  kPMOutOfScope = -30871;
  {$EXTERNALSYM kPMOutOfScope}
  kPMPMSymbolNotFound = -9660;
  {$EXTERNALSYM kPMPMSymbolNotFound}
  kPMPageToPaperMappingNone = 1;
  {$EXTERNALSYM kPMPageToPaperMappingNone}
  kPMPageToPaperMappingScaleToFit = 2;
  {$EXTERNALSYM kPMPageToPaperMappingScaleToFit}
  kPMPaperTypeCoated = 2;
  {$EXTERNALSYM kPMPaperTypeCoated}
  kPMPaperTypeGlossy = 4;
  {$EXTERNALSYM kPMPaperTypeGlossy}
  kPMPaperTypePlain = 1;
  {$EXTERNALSYM kPMPaperTypePlain}
  kPMPaperTypePremium = 3;
  {$EXTERNALSYM kPMPaperTypePremium}
  kPMPaperTypeTShirt = 6;
  {$EXTERNALSYM kPMPaperTypeTShirt}
  kPMPaperTypeTransparency = 5;
  {$EXTERNALSYM kPMPaperTypeTransparency}
  kPMPaperTypeUnknown = 0;
  {$EXTERNALSYM kPMPaperTypeUnknown}
  kPMPermissionError = -9636;
  {$EXTERNALSYM kPMPermissionError}
  kPMPluginNotFound = -9701;
  {$EXTERNALSYM kPMPluginNotFound}
  kPMPluginRegisterationFailed = -9702;
  {$EXTERNALSYM kPMPluginRegisterationFailed}
  kPMPortrait = 1;
  {$EXTERNALSYM kPMPortrait}
  kPMPrBrowserNoUI = -9545;
  {$EXTERNALSYM kPMPrBrowserNoUI}
  kPMPrintAllPages = -1;
  {$EXTERNALSYM kPMPrintAllPages}
  kPMPrintSettingsAEType = 1886610804;
  {$EXTERNALSYM kPMPrintSettingsAEType}
  kPMPrintTimeAEKey = 1819767156;
  {$EXTERNALSYM kPMPrintTimeAEKey}
  kPMPrintTimeAEType = 1818522656;
  {$EXTERNALSYM kPMPrintTimeAEType}
  kPMPrinterAEType = 1953656946;
  {$EXTERNALSYM kPMPrinterAEType}
  kPMPrinterIdle = 3;
  {$EXTERNALSYM kPMPrinterIdle}
  kPMPrinterProcessing = 4;
  {$EXTERNALSYM kPMPrinterProcessing}
  kPMPrinterStopped = 5;
  {$EXTERNALSYM kPMPrinterStopped}
  kPMQualityBest = 13;
  {$EXTERNALSYM kPMQualityBest}
  kPMQualityDraft = 4;
  {$EXTERNALSYM kPMQualityDraft}
  kPMQualityHighest = 15;
  {$EXTERNALSYM kPMQualityHighest}
  kPMQualityInkSaver = 1;
  {$EXTERNALSYM kPMQualityInkSaver}
  kPMQualityLowest = 0;
  {$EXTERNALSYM kPMQualityLowest}
  kPMQualityNormal = 8;
  {$EXTERNALSYM kPMQualityNormal}
  kPMQualityPhoto = 11;
  {$EXTERNALSYM kPMQualityPhoto}
  kPMQueueAlreadyExists = -9639;
  {$EXTERNALSYM kPMQueueAlreadyExists}
  kPMQueueJobFailed = -9640;
  {$EXTERNALSYM kPMQueueJobFailed}
  kPMQueueNotFound = -9638;
  {$EXTERNALSYM kPMQueueNotFound}
  kPMRGBColorSpaceModel = 2;
  {$EXTERNALSYM kPMRGBColorSpaceModel}
  kPMReadFailed = -9782;
  {$EXTERNALSYM kPMReadFailed}
  kPMReadGotZeroData = -9788;
  {$EXTERNALSYM kPMReadGotZeroData}
  kPMReverseLandscape = 4;
  {$EXTERNALSYM kPMReverseLandscape}
  kPMReversePortrait = 3;
  {$EXTERNALSYM kPMReversePortrait}
  kPMScalingCenterOnImgArea = 6;
  {$EXTERNALSYM kPMScalingCenterOnImgArea}
  kPMScalingCenterOnPaper = 5;
  {$EXTERNALSYM kPMScalingCenterOnPaper}
  kPMScalingPinBottomLeft = 3;
  {$EXTERNALSYM kPMScalingPinBottomLeft}
  kPMScalingPinBottomRight = 4;
  {$EXTERNALSYM kPMScalingPinBottomRight}
  kPMScalingPinTopLeft = 1;
  {$EXTERNALSYM kPMScalingPinTopLeft}
  kPMScalingPinTopRight = 2;
  {$EXTERNALSYM kPMScalingPinTopRight}
  kPMServerAlreadyRunning = -9631;
  {$EXTERNALSYM kPMServerAlreadyRunning}
  kPMServerAttributeRestricted = -9633;
  {$EXTERNALSYM kPMServerAttributeRestricted}
  kPMServerCommunicationFailed = -9621;
  {$EXTERNALSYM kPMServerCommunicationFailed}
  kPMServerNotFound = -9630;
  {$EXTERNALSYM kPMServerNotFound}
  kPMServerSuspended = -9632;
  {$EXTERNALSYM kPMServerSuspended}
  kPMShowDefaultInlineItems = 32768;
  {$EXTERNALSYM kPMShowDefaultInlineItems}
  kPMShowInlineCopies = 1;
  {$EXTERNALSYM kPMShowInlineCopies}
  kPMShowInlineOrientation = 8;
  {$EXTERNALSYM kPMShowInlineOrientation}
  kPMShowInlinePageRange = 2;
  {$EXTERNALSYM kPMShowInlinePageRange}
  kPMShowInlinePageRangeWithSelection = 64;
  {$EXTERNALSYM kPMShowInlinePageRangeWithSelection}
  kPMShowInlinePaperSize = 4;
  {$EXTERNALSYM kPMShowInlinePaperSize}
  kPMShowInlineScale = 128;
  {$EXTERNALSYM kPMShowInlineScale}
  kPMShowPageAttributesPDE = 256;
  {$EXTERNALSYM kPMShowPageAttributesPDE}
  kPMShowPrintDialogAEType = 1885629543;
  {$EXTERNALSYM kPMShowPrintDialogAEType}
  kPMSimplexTumble = 4;
  {$EXTERNALSYM kPMSimplexTumble}
  kPMStatusFailed = -9784;
  {$EXTERNALSYM kPMStatusFailed}
  kPMStringConversionFailure = -30883;
  {$EXTERNALSYM kPMStringConversionFailure}
  kPMSubTicketNotFound = -9583;
  {$EXTERNALSYM kPMSubTicketNotFound}
  kPMSyncRequestFailed = -9543;
  {$EXTERNALSYM kPMSyncRequestFailed}
  kPMTargetPrinterAEKey = 1953656946;
  {$EXTERNALSYM kPMTargetPrinterAEKey}
  kPMTargetPrinterAEType = 1413830740;
  {$EXTERNALSYM kPMTargetPrinterAEType}
  kPMTemplateIsLocked = -9588;
  {$EXTERNALSYM kPMTemplateIsLocked}
  kPMTicketIsLocked = -9587;
  {$EXTERNALSYM kPMTicketIsLocked}
  kPMTicketTypeNotFound = -9580;
  {$EXTERNALSYM kPMTicketTypeNotFound}
  kPMUnableToFindProcess = -9532;
  {$EXTERNALSYM kPMUnableToFindProcess}
  kPMUnexpectedImagingError = -9707;
  {$EXTERNALSYM kPMUnexpectedImagingError}
  kPMUnknownColorSpaceModel = 0;
  {$EXTERNALSYM kPMUnknownColorSpaceModel}
  kPMUnknownDataType = -9591;
  {$EXTERNALSYM kPMUnknownDataType}
  kPMUnknownMessage = -9637;
  {$EXTERNALSYM kPMUnknownMessage}
  kPMUnlocked = 0;
  {$EXTERNALSYM kPMUnlocked}
  kPMUnsupportedConnection = -9786;
  {$EXTERNALSYM kPMUnsupportedConnection}
  kPMUpdateTicketFailed = -9581;
  {$EXTERNALSYM kPMUpdateTicketFailed}
  kPMUserOrGroupNotFound = -9635;
  {$EXTERNALSYM kPMUserOrGroupNotFound}
  kPMValidateTicketFailed = -9582;
  {$EXTERNALSYM kPMValidateTicketFailed}
  kPMValueOutOfRange = -30877;
  {$EXTERNALSYM kPMValueOutOfRange}
  kPMWriteFailed = -9783;
  {$EXTERNALSYM kPMWriteFailed}
  kPMXMLParseError = -30884;
  {$EXTERNALSYM kPMXMLParseError}
  kSystemPPDDomain = 2;
  {$EXTERNALSYM kSystemPPDDomain}
  kUserPPDDomain = 5;
  {$EXTERNALSYM kUserPPDDomain}

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
