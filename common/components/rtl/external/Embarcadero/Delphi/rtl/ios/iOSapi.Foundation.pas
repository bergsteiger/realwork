{**********************************************************}
{                                                          }
{           CodeGear Delphi Runtime Library                }
{                                                          }
{ Delphi-Objective-C Bridge                                }
{ Interfaces for Cocoa framework Foundation                }
{                                                          }
{ Copyright (c) 1994-2011, Apple Inc. All rights reserved. }
{                                                          }
{ Translator: Embarcadero Technologies, Inc.               }
{   Copyright(c) 2012-2013 Embarcadero Technologies, Inc.  }
{                                                          }
{**********************************************************}

unit iOSapi.Foundation;

interface

uses
  iOSapi.CocoaTypes, Macapi.CoreFoundation, Macapi.ObjectiveC, Macapi.ObjCRuntime;
//  iOSapi.ObjCRuntime,
//  iOSapi.ObjectiveC,
//  iOSapi.CocoaTypes,
//  iOSapi.IOKit,
//  iOSapi.IOKit;

const
  NSASCIIStringEncoding = 1;
  NSAdminApplicationDirectory = 4;
  NSAggregateExpressionType = 14;
  NSAllApplicationsDirectory = 100;
  NSAllDomainsMask = 65535;
  NSAllLibrariesDirectory = 101;
  NSAllPredicateModifier = 1;
  NSAnchoredSearch = 8;
  NSAndPredicateType = 1;
  NSAnyPredicateModifier = 2;
  NSApplicationDirectory = 1;
  NSApplicationSupportDirectory = 14;
  NSAtomicWrite = 1;
  NSAttributedStringEnumerationLongestEffectiveRangeNotRequired = 1048576;
  NSAttributedStringEnumerationReverse = 2;
  NSAutosavedInformationDirectory = 11;
  NSBackwardsSearch = 4;
  NSBeginsWithPredicateOperatorType = 8;
  NSBetweenPredicateOperatorType = 100;
  NSBinarySearchingFirstEqual = 256;
  NSBinarySearchingInsertionIndex = 1024;
  NSBinarySearchingLastEqual = 512;
  NSBlockExpressionType = 19;
  NSBundleExecutableArchitectureI386 = 7;
  NSBundleExecutableArchitecturePPC = 18;
  NSBundleExecutableArchitecturePPC64 = 16777234;
  NSBundleExecutableArchitectureX86_64 = 16777223;
  NSCachesDirectory = 13;
  NSCalculationDivideByZero = 4;
  NSCalculationLossOfPrecision = 1;
  NSCalculationNoError = 0;
  NSCalculationOverflow = 3;
  NSCalculationUnderflow = 2;
  NSCalendarCalendarUnit = 1048576;
  NSCaseInsensitivePredicateOption = 1;
  NSCaseInsensitiveSearch = 1;
  NSConstantValueExpressionType = 0;
  NSContainsPredicateOperatorType = 99;
  NSCoreServiceDirectory = 10;
  NSCustomSelectorPredicateOperatorType = 11;
  NSDataReadingMapped = 1;
  NSDataReadingMappedAlways = 8;
  NSDataReadingMappedIfSafe = 1;
  NSDataReadingUncached = 2;
  NSDataSearchAnchored = 2;
  NSDataSearchBackwards = 1;
  NSDataWritingAtomic = 1;
  NSDateFormatterBehavior10_4 = 1040;
  NSDateFormatterBehaviorDefault = 0;
  NSDateFormatterFullStyle = 4;
  NSDateFormatterLongStyle = 3;
  NSDateFormatterMediumStyle = 2;
  NSDateFormatterNoStyle = 0;
  NSDateFormatterShortStyle = 1;
  NSDayCalendarUnit = 16;
  NSDecimalMaxSize = 8;
  NSDecimalNoScale = 32767;
  NSDemoApplicationDirectory = 2;
  NSDesktopDirectory = 12;
  NSDeveloperApplicationDirectory = 3;
  NSDeveloperDirectory = 6;
  NSDiacriticInsensitivePredicateOption = 2;
  NSDiacriticInsensitiveSearch = 128;
  NSDirectPredicateModifier = 0;
  NSDirectoryEnumerationSkipsHiddenFiles = 4;
  NSDirectoryEnumerationSkipsPackageDescendants = 2;
  NSDirectoryEnumerationSkipsSubdirectoryDescendants = 1;
  NSDocumentDirectory = 9;
  NSDocumentationDirectory = 8;
  NSDownloadsDirectory = 15;
  NSEndsWithPredicateOperatorType = 9;
  NSEnumerationConcurrent = 1;
  NSEnumerationReverse = 2;
  NSEqualToPredicateOperatorType = 4;
  NSEraCalendarUnit = 2;
  NSEvaluatedObjectExpressionType = 1;
  NSExecutableArchitectureMismatchError = 3585;
  NSExecutableErrorMaximum = 3839;
  NSExecutableErrorMinimum = 3584;
  NSExecutableLinkError = 3588;
  NSExecutableLoadError = 3587;
  NSExecutableNotLoadableError = 3584;
  NSExecutableRuntimeMismatchError = 3586;
  NSFileCoordinatorReadingResolvesSymbolicLink = 2;
  NSFileCoordinatorReadingWithoutChanges = 1;
  NSFileCoordinatorWritingForDeleting = 1;
  NSFileCoordinatorWritingForMerging = 4;
  NSFileCoordinatorWritingForMoving = 2;
  NSFileCoordinatorWritingForReplacing = 8;
  NSFileErrorMaximum = 1023;
  NSFileErrorMinimum = 0;
  NSFileLockingError = 255;
  NSFileManagerItemReplacementUsingNewMetadataOnly = 1;
  NSFileManagerItemReplacementWithoutDeletingBackupItem = 2;
  NSFileNoSuchFileError = 4;
  NSFileReadCorruptFileError = 259;
  NSFileReadInapplicableStringEncodingError = 261;
  NSFileReadInvalidFileNameError = 258;
  NSFileReadNoPermissionError = 257;
  NSFileReadNoSuchFileError = 260;
  NSFileReadTooLargeError = 263;
  NSFileReadUnknownError = 256;
  NSFileReadUnknownStringEncodingError = 264;
  NSFileReadUnsupportedSchemeError = 262;
  NSFileVersionAddingByMoving = 1;
  NSFileVersionReplacingByMoving = 1;
  NSFileWrapperReadingImmediate = 1;
  NSFileWrapperReadingWithoutMapping = 2;
  NSFileWrapperWritingAtomic = 1;
  NSFileWrapperWritingWithNameUpdating = 2;
  NSFileWriteFileExistsError = 516;
  NSFileWriteInapplicableStringEncodingError = 517;
  NSFileWriteInvalidFileNameError = 514;
  NSFileWriteNoPermissionError = 513;
  NSFileWriteOutOfSpaceError = 640;
  NSFileWriteUnknownError = 512;
  NSFileWriteUnsupportedSchemeError = 518;
  NSFileWriteVolumeReadOnlyError = 642;
  NSForcedOrderingSearch = 512;
  NSFormattingError = 2048;
  NSFormattingErrorMaximum = 2559;
  NSFormattingErrorMinimum = 2048;
  NSFoundationVersionNumber10_0 = 397.40;
  NSFoundationVersionNumber10_1 = 425.00;
  NSFoundationVersionNumber10_1_1 = 425.00;
  NSFoundationVersionNumber10_1_2 = 425.00;
  NSFoundationVersionNumber10_1_3 = 425.00;
  NSFoundationVersionNumber10_1_4 = 425.00;
  NSFoundationVersionNumber10_2 = 462.00;
  NSFoundationVersionNumber10_2_1 = 462.00;
  NSFoundationVersionNumber10_2_2 = 462.00;
  NSFoundationVersionNumber10_2_3 = 462.00;
  NSFoundationVersionNumber10_2_4 = 462.00;
  NSFoundationVersionNumber10_2_5 = 462.00;
  NSFoundationVersionNumber10_2_6 = 462.00;
  NSFoundationVersionNumber10_2_7 = 462.70;
  NSFoundationVersionNumber10_2_8 = 462.70;
  NSFoundationVersionNumber10_3 = 500.00;
  NSFoundationVersionNumber10_3_1 = 500.00;
  NSFoundationVersionNumber10_3_2 = 500.30;
  NSFoundationVersionNumber10_3_3 = 500.54;
  NSFoundationVersionNumber10_3_4 = 500.56;
  NSFoundationVersionNumber10_3_5 = 500.56;
  NSFoundationVersionNumber10_3_6 = 500.56;
  NSFoundationVersionNumber10_3_7 = 500.56;
  NSFoundationVersionNumber10_3_8 = 500.56;
  NSFoundationVersionNumber10_3_9 = 500.58;
  NSFoundationVersionNumber10_4 = 567.00;
  NSFoundationVersionNumber10_4_1 = 567.00;
  NSFoundationVersionNumber10_4_10 = 567.29;
  NSFoundationVersionNumber10_4_11 = 567.36;
  NSFoundationVersionNumber10_4_2 = 567.12;
  NSFoundationVersionNumber10_4_3 = 567.21;
  NSFoundationVersionNumber10_4_4_Intel = 567.23;
  NSFoundationVersionNumber10_4_4_PowerPC = 567.21;
  NSFoundationVersionNumber10_4_5 = 567.25;
  NSFoundationVersionNumber10_4_6 = 567.26;
  NSFoundationVersionNumber10_4_7 = 567.27;
  NSFoundationVersionNumber10_4_8 = 567.28;
  NSFoundationVersionNumber10_4_9 = 567.29;
  NSFoundationVersionNumber10_5 = 677.00;
  NSFoundationVersionNumber10_5_1 = 677.10;
  NSFoundationVersionNumber10_5_2 = 677.15;
  NSFoundationVersionNumber10_5_3 = 677.19;
  NSFoundationVersionNumber10_5_4 = 677.19;
  NSFoundationVersionNumber10_5_5 = 677.21;
  NSFoundationVersionNumber10_5_6 = 677.22;
  NSFoundationVersionNumber10_5_7 = 677.24;
  NSFoundationVersionNumber10_5_8 = 677.26;
  NSFoundationVersionNumber10_6 = 751.00;
  NSFoundationVersionNumber10_6_1 = 751.00;
  NSFoundationVersionNumber10_6_2 = 751.14;
  NSFoundationVersionNumber10_6_3 = 751.21;
  NSFoundationVersionNumber10_6_4 = 751.29;
  NSFoundationVersionNumber10_6_5 = 751.42;
  NSFoundationVersionNumber_iOS_4_0 = 751.32;
  NSFoundationVersionNumber_iOS_4_1 = 751.37;
  NSFoundationVersionNumber_iOS_4_2 = 751.49;
  NSFoundationVersionNumber_iPhoneOS_2_0 = 678.24;
  NSFoundationVersionNumber_iPhoneOS_2_1 = 678.26;
  NSFoundationVersionNumber_iPhoneOS_2_2 = 678.29;
  NSFoundationVersionNumber_iPhoneOS_3_0 = 678.47;
  NSFoundationVersionNumber_iPhoneOS_3_1 = 678.51;
  NSFoundationVersionNumber_iPhoneOS_3_2 = 678.60;
  NSFoundationVersionWithFileManagerResourceForkSupport = 412;
  NSFunctionExpressionType = 4;
  NSGreaterThanOrEqualToPredicateOperatorType = 3;
  NSGreaterThanPredicateOperatorType = 2;
  NSHPUXOperatingSystem = 4;
  NSHTTPCookieAcceptPolicyAlways = 0;
  NSHTTPCookieAcceptPolicyNever = 1;
  NSHTTPCookieAcceptPolicyOnlyFromMainDocumentDomain = 2;
  NSHourCalendarUnit = 32;
  NSINTEGER_DEFINED = 1;
  NSISO2022JPStringEncoding = 21;
  NSISOLatin1StringEncoding = 5;
  NSISOLatin2StringEncoding = 9;
  NSInPredicateOperatorType = 10;
  NSInputMethodsDirectory = 16;
  NSIntegerMax = 2147483647;
  NSIntegerMin = -2147483648;
  NSIntersectSetExpressionType = 6;
  NSItemReplacementDirectory = 99;
  NSJSONReadingAllowFragments = 4;
  NSJSONReadingMutableContainers = 1;
  NSJSONReadingMutableLeaves = 2;
  NSJSONWritingPrettyPrinted = 1;
  NSJapaneseEUCStringEncoding = 3;
  NSKeyPathExpressionType = 3;
  NSKeyValueChangeInsertion = 2;
  NSKeyValueChangeRemoval = 3;
  NSKeyValueChangeReplacement = 4;
  NSKeyValueChangeSetting = 1;
  NSKeyValueIntersectSetMutation = 3;
  NSKeyValueMinusSetMutation = 2;
  NSKeyValueObservingOptionInitial = 4;
  NSKeyValueObservingOptionNew = 1;
  NSKeyValueObservingOptionOld = 2;
  NSKeyValueObservingOptionPrior = 8;
  NSKeyValueSetSetMutation = 4;
  NSKeyValueUnionSetMutation = 1;
  NSKeyValueValidationError = 1024;
  NSLessThanOrEqualToPredicateOperatorType = 1;
  NSLessThanPredicateOperatorType = 0;
  NSLibraryDirectory = 5;
  NSLikePredicateOperatorType = 7;
  NSLinguisticTaggerJoinNames = 16;
  NSLinguisticTaggerOmitOther = 8;
  NSLinguisticTaggerOmitPunctuation = 2;
  NSLinguisticTaggerOmitWhitespace = 4;
  NSLinguisticTaggerOmitWords = 1;
  NSLiteralSearch = 2;
  NSLocalDomainMask = 2;
  NSLocaleLanguageDirectionBottomToTop = 4;
  NSLocaleLanguageDirectionLeftToRight = 1;
  NSLocaleLanguageDirectionRightToLeft = 2;
  NSLocaleLanguageDirectionTopToBottom = 3;
  NSLocaleLanguageDirectionUnknown = 0;
  NSMACHOperatingSystem = 5;
  NSMacOSRomanStringEncoding = 30;
  NSMachPortDeallocateNone = 0;
  NSMachPortDeallocateReceiveRight = 2;
  NSMachPortDeallocateSendRight = 1;
  NSMappedRead = 1;
  NSMatchesPredicateOperatorType = 6;
  NSMatchingAnchored = 4;
  NSMatchingCompleted = 2;
  NSMatchingHitEnd = 4;
  NSMatchingInternalError = 16;
  NSMatchingProgress = 1;
  NSMatchingReportCompletion = 2;
  NSMatchingReportProgress = 1;
  NSMatchingRequiredEnd = 8;
  NSMatchingWithTransparentBounds = 8;
  NSMatchingWithoutAnchoringBounds = 16;
  NSMaximumStringLength = 2147483646;
  NSMinusSetExpressionType = 7;
  NSMinuteCalendarUnit = 64;
  NSMonthCalendarUnit = 8;
  NSMoviesDirectory = 17;
  NSMusicDirectory = 18;
  NSNEXTSTEPStringEncoding = 2;
  NSNetServiceNoAutoRename = 1;
  NSNetServicesActivityInProgress = -72003;
  NSNetServicesBadArgumentError = -72004;
  NSNetServicesCancelledError = -72005;
  NSNetServicesCollisionError = -72001;
  NSNetServicesInvalidError = -72006;
  NSNetServicesNotFoundError = -72002;
  NSNetServicesTimeoutError = -72007;
  NSNetServicesUnknownError = -72000;
  NSNetworkDomainMask = 4;
  NSNonLossyASCIIStringEncoding = 7;
  NSNormalizedPredicateOption = 4;
  NSNotEqualToPredicateOperatorType = 5;
  NSNotFound = 2147483647;
  NSNotPredicateType = 0;
  NSNotificationCoalescingOnName = 1;
  NSNotificationCoalescingOnSender = 2;
  NSNotificationNoCoalescing = 0;
  NSNumberFormatterBehavior10_4 = 1040;
  NSNumberFormatterBehaviorDefault = 0;
  NSNumberFormatterCurrencyStyle = 2;
  NSNumberFormatterDecimalStyle = 1;
  NSNumberFormatterNoStyle = 0;
  NSNumberFormatterPadAfterPrefix = 1;
  NSNumberFormatterPadAfterSuffix = 3;
  NSNumberFormatterPadBeforePrefix = 0;
  NSNumberFormatterPadBeforeSuffix = 2;
  NSNumberFormatterPercentStyle = 3;
  NSNumberFormatterRoundCeiling = 0;
  NSNumberFormatterRoundDown = 2;
  NSNumberFormatterRoundFloor = 1;
  NSNumberFormatterRoundHalfDown = 5;
  NSNumberFormatterRoundHalfEven = 4;
  NSNumberFormatterRoundHalfUp = 6;
  NSNumberFormatterRoundUp = 3;
  NSNumberFormatterScientificStyle = 4;
  NSNumberFormatterSpellOutStyle = 5;
  NSNumericSearch = 64;
  NSOSF1OperatingSystem = 7;
  NSOpenStepUnicodeReservedBase = 62464;
  NSOperationQueueDefaultMaxConcurrentOperationCount = -1;
  NSOperationQueuePriorityHigh = 4;
  NSOperationQueuePriorityLow = -4;
  NSOperationQueuePriorityNormal = 0;
  NSOperationQueuePriorityVeryHigh = 8;
  NSOperationQueuePriorityVeryLow = -8;
  NSOrPredicateType = 2;
  NSOrderedAscending = -1;
  NSOrderedDescending = 1;
  NSOrderedSame = 0;
  NSPicturesDirectory = 19;
  NSPostASAP = 2;
  NSPostNow = 3;
  NSPostWhenIdle = 1;
  NSPreferencePanesDirectory = 22;
  NSPrinterDescriptionDirectory = 20;
  NSPropertyListBinaryFormat_v1_0 = 200;
  NSPropertyListErrorMaximum = 4095;
  NSPropertyListErrorMinimum = 3840;
  NSPropertyListImmutable = 0;
  NSPropertyListMutableContainers = 1;
  NSPropertyListMutableContainersAndLeaves = 2;
  NSPropertyListOpenStepFormat = 1;
  NSPropertyListReadCorruptError = 3840;
  NSPropertyListReadStreamError = 3842;
  NSPropertyListReadUnknownVersionError = 3841;
  NSPropertyListWriteStreamError = 3851;
  NSPropertyListXMLFormat_v1_0 = 100;
  NSProprietaryStringEncoding = 65536;
  NSQuarterCalendarUnit = 2048;
  NSRegularExpressionAllowCommentsAndWhitespace = 2;
  NSRegularExpressionAnchorsMatchLines = 16;
  NSRegularExpressionCaseInsensitive = 1;
  NSRegularExpressionDotMatchesLineSeparators = 8;
  NSRegularExpressionIgnoreMetacharacters = 4;
  NSRegularExpressionSearch = 1024;
  NSRegularExpressionUseUnicodeWordBoundaries = 64;
  NSRegularExpressionUseUnixLineSeparators = 32;
  NSRoundBankers = 3;
  NSRoundDown = 1;
  NSRoundPlain = 0;
  NSRoundUp = 2;
  NSSecondCalendarUnit = 128;
  NSSharedPublicDirectory = 21;
  NSShiftJISStringEncoding = 8;
  NSSolarisOperatingSystem = 3;
  NSSortConcurrent = 1;
  NSSortStable = 16;
  NSStreamEventEndEncountered = 16;
  NSStreamEventErrorOccurred = 8;
  NSStreamEventHasBytesAvailable = 2;
  NSStreamEventHasSpaceAvailable = 4;
  NSStreamEventNone = 0;
  NSStreamEventOpenCompleted = 1;
  NSStreamStatusAtEnd = 5;
  NSStreamStatusClosed = 6;
  NSStreamStatusError = 7;
  NSStreamStatusNotOpen = 0;
  NSStreamStatusOpen = 2;
  NSStreamStatusOpening = 1;
  NSStreamStatusReading = 3;
  NSStreamStatusWriting = 4;
  NSStringEncodingConversionAllowLossy = 1;
  NSStringEncodingConversionExternalRepresentation = 2;
  NSStringEnumerationByComposedCharacterSequences = 2;
  NSStringEnumerationByLines = 0;
  NSStringEnumerationByParagraphs = 1;
  NSStringEnumerationBySentences = 4;
  NSStringEnumerationByWords = 3;
  NSStringEnumerationLocalized = 1024;
  NSStringEnumerationReverse = 256;
  NSStringEnumerationSubstringNotRequired = 512;
  NSSubqueryExpressionType = 13;
  NSSunOSOperatingSystem = 6;
  NSSymbolStringEncoding = 6;
  NSSystemDomainMask = 8;
  NSTextCheckingAllCustomTypes = 18446744069414584320;
  NSTextCheckingAllSystemTypes = 4294967295;
  NSTextCheckingAllTypes = 18446744073709551615;
  NSTextCheckingTypeAddress = 16;
  NSTextCheckingTypeCorrection = 512;
  NSTextCheckingTypeDash = 128;
  NSTextCheckingTypeDate = 8;
  NSTextCheckingTypeGrammar = 4;
  NSTextCheckingTypeLink = 32;
  NSTextCheckingTypeOrthography = 1;
  NSTextCheckingTypePhoneNumber = 2048;
  NSTextCheckingTypeQuote = 64;
  NSTextCheckingTypeRegularExpression = 1024;
  NSTextCheckingTypeReplacement = 256;
  NSTextCheckingTypeSpelling = 2;
  NSTextCheckingTypeTransitInformation = 4096;
  NSTimeIntervalSince1970 = 978307200.0;
  NSTimeZoneCalendarUnit = 2097152;
  NSTimeZoneNameStyleDaylightSaving = 2;
  NSTimeZoneNameStyleGeneric = 4;
  NSTimeZoneNameStyleShortDaylightSaving = 3;
  NSTimeZoneNameStyleShortGeneric = 5;
  NSTimeZoneNameStyleShortStandard = 1;
  NSTimeZoneNameStyleStandard = 0;
  NSUIntegerMax = 4294967295;
  NSURLBookmarkCreationMinimalBookmark = 512;
  NSURLBookmarkCreationPreferFileIDResolution = 256;
  NSURLBookmarkCreationSuitableForBookmarkFile = 1024;
  NSURLBookmarkResolutionWithoutMounting = 512;
  NSURLBookmarkResolutionWithoutUI = 256;
  NSURLCacheStorageAllowed = 0;
  NSURLCacheStorageAllowedInMemoryOnly = 1;
  NSURLCacheStorageNotAllowed = 2;
  NSURLCredentialPersistenceForSession = 1;
  NSURLCredentialPersistenceNone = 0;
  NSURLCredentialPersistencePermanent = 2;
  NSURLErrorBadServerResponse = -1011;
  NSURLErrorBadURL = -1000;
  NSURLErrorCallIsActive = -1019;
  NSURLErrorCancelled = -999;
  NSURLErrorCannotCloseFile = -3002;
  NSURLErrorCannotConnectToHost = -1004;
  NSURLErrorCannotCreateFile = -3000;
  NSURLErrorCannotDecodeContentData = -1016;
  NSURLErrorCannotDecodeRawData = -1015;
  NSURLErrorCannotFindHost = -1003;
  NSURLErrorCannotLoadFromNetwork = -2000;
  NSURLErrorCannotMoveFile = -3005;
  NSURLErrorCannotOpenFile = -3001;
  NSURLErrorCannotParseResponse = -1017;
  NSURLErrorCannotRemoveFile = -3004;
  NSURLErrorCannotWriteToFile = -3003;
  NSURLErrorClientCertificateRejected = -1205;
  NSURLErrorClientCertificateRequired = -1206;
  NSURLErrorDNSLookupFailed = -1006;
  NSURLErrorDataLengthExceedsMaximum = -1103;
  NSURLErrorDataNotAllowed = -1020;
  NSURLErrorDownloadDecodingFailedMidStream = -3006;
  NSURLErrorDownloadDecodingFailedToComplete = -3007;
  NSURLErrorFileDoesNotExist = -1100;
  NSURLErrorFileIsDirectory = -1101;
  NSURLErrorHTTPTooManyRedirects = -1007;
  NSURLErrorInternationalRoamingOff = -1018;
  NSURLErrorNetworkConnectionLost = -1005;
  NSURLErrorNoPermissionsToReadFile = -1102;
  NSURLErrorNotConnectedToInternet = -1009;
  NSURLErrorRedirectToNonExistentLocation = -1010;
  NSURLErrorRequestBodyStreamExhausted = -1021;
  NSURLErrorResourceUnavailable = -1008;
  NSURLErrorSecureConnectionFailed = -1200;
  NSURLErrorServerCertificateHasBadDate = -1201;
  NSURLErrorServerCertificateHasUnknownRoot = -1203;
  NSURLErrorServerCertificateNotYetValid = -1204;
  NSURLErrorServerCertificateUntrusted = -1202;
  NSURLErrorTimedOut = -1001;
  NSURLErrorUnknown = -1;
  NSURLErrorUnsupportedURL = -1002;
  NSURLErrorUserAuthenticationRequired = -1013;
  NSURLErrorUserCancelledAuthentication = -1012;
  NSURLErrorZeroByteResource = -1014;
  NSURLNetworkServiceTypeBackground = 3;
  NSURLNetworkServiceTypeDefault = 0;
  NSURLNetworkServiceTypeVideo = 2;
  NSURLNetworkServiceTypeVoIP = 1;
  NSURLNetworkServiceTypeVoice = 4;
  NSURLRequestReloadIgnoringCacheData = 1;
  NSURLRequestReloadIgnoringLocalAndRemoteCacheData = 4;
  NSURLRequestReloadIgnoringLocalCacheData = 1;
  NSURLRequestReloadRevalidatingCacheData = 5;
  NSURLRequestReturnCacheDataDontLoad = 3;
  NSURLRequestReturnCacheDataElseLoad = 2;
  NSURLRequestUseProtocolCachePolicy = 0;
  NSURLResponseUnknownLength = -1;
  NSUTF16BigEndianStringEncoding = 2415919360;
  NSUTF16LittleEndianStringEncoding = 2483028224;
  NSUTF16StringEncoding = 10;
  NSUTF32BigEndianStringEncoding = 2550137088;
  NSUTF32LittleEndianStringEncoding = 2617245952;
  NSUTF32StringEncoding = 2348810496;
  NSUTF8StringEncoding = 4;
  NSUbiquitousKeyValueStoreInitialSyncChange = 1;
  NSUbiquitousKeyValueStoreQuotaViolationChange = 2;
  NSUbiquitousKeyValueStoreServerChange = 0;
  NSUncachedRead = 2;
  NSUndefinedDateComponent = 2147483647;
  NSUndoCloseGroupingRunLoopOrdering = 350000;
  NSUnicodeStringEncoding = 10;
  NSUnionSetExpressionType = 5;
  NSUserCancelledError = 3072;
  NSUserDirectory = 7;
  NSUserDomainMask = 1;
  NSValidationErrorMaximum = 2047;
  NSValidationErrorMinimum = 1024;
  NSVariableExpressionType = 2;
  NSVolumeEnumerationProduceFileReferenceURLs = 4;
  NSVolumeEnumerationSkipHiddenVolumes = 2;
  NSWeekCalendarUnit = 256;
  NSWeekOfMonthCalendarUnit = 4096;
  NSWeekOfYearCalendarUnit = 8192;
  NSWeekdayCalendarUnit = 512;
  NSWeekdayOrdinalCalendarUnit = 1024;
  NSWidthInsensitiveSearch = 256;
  NSWindows95OperatingSystem = 2;
  NSWindowsCP1250StringEncoding = 15;
  NSWindowsCP1251StringEncoding = 11;
  NSWindowsCP1252StringEncoding = 12;
  NSWindowsCP1253StringEncoding = 13;
  NSWindowsCP1254StringEncoding = 14;
  NSWindowsNTOperatingSystem = 1;
  NSWrapCalendarComponents = 1;
  NSXMLParserAttributeHasNoValueError = 41;
  NSXMLParserAttributeListNotFinishedError = 51;
  NSXMLParserAttributeListNotStartedError = 50;
  NSXMLParserAttributeNotFinishedError = 40;
  NSXMLParserAttributeNotStartedError = 39;
  NSXMLParserAttributeRedefinedError = 42;
  NSXMLParserCDATANotFinishedError = 63;
  NSXMLParserCharacterRefAtEOFError = 10;
  NSXMLParserCharacterRefInDTDError = 13;
  NSXMLParserCharacterRefInEpilogError = 12;
  NSXMLParserCharacterRefInPrologError = 11;
  NSXMLParserCommentContainsDoubleHyphenError = 80;
  NSXMLParserCommentNotFinishedError = 45;
  NSXMLParserConditionalSectionNotFinishedError = 59;
  NSXMLParserConditionalSectionNotStartedError = 58;
  NSXMLParserDOCTYPEDeclNotFinishedError = 61;
  NSXMLParserDelegateAbortedParseError = 512;
  NSXMLParserDocumentStartError = 3;
  NSXMLParserElementContentDeclNotFinishedError = 55;
  NSXMLParserElementContentDeclNotStartedError = 54;
  NSXMLParserEmptyDocumentError = 4;
  NSXMLParserEncodingNotSupportedError = 32;
  NSXMLParserEntityBoundaryError = 90;
  NSXMLParserEntityIsExternalError = 29;
  NSXMLParserEntityIsParameterError = 30;
  NSXMLParserEntityNotFinishedError = 37;
  NSXMLParserEntityNotStartedError = 36;
  NSXMLParserEntityRefAtEOFError = 14;
  NSXMLParserEntityRefInDTDError = 17;
  NSXMLParserEntityRefInEpilogError = 16;
  NSXMLParserEntityRefInPrologError = 15;
  NSXMLParserEntityRefLoopError = 89;
  NSXMLParserEntityReferenceMissingSemiError = 23;
  NSXMLParserEntityReferenceWithoutNameError = 22;
  NSXMLParserEntityValueRequiredError = 84;
  NSXMLParserEqualExpectedError = 75;
  NSXMLParserExternalStandaloneEntityError = 82;
  NSXMLParserExternalSubsetNotFinishedError = 60;
  NSXMLParserExtraContentError = 86;
  NSXMLParserGTRequiredError = 73;
  NSXMLParserInternalError = 1;
  NSXMLParserInvalidCharacterError = 9;
  NSXMLParserInvalidCharacterInEntityError = 87;
  NSXMLParserInvalidCharacterRefError = 8;
  NSXMLParserInvalidConditionalSectionError = 83;
  NSXMLParserInvalidDecimalCharacterRefError = 7;
  NSXMLParserInvalidEncodingError = 81;
  NSXMLParserInvalidEncodingNameError = 79;
  NSXMLParserInvalidHexCharacterRefError = 6;
  NSXMLParserInvalidURIError = 91;
  NSXMLParserLTRequiredError = 72;
  NSXMLParserLTSlashRequiredError = 74;
  NSXMLParserLessThanSymbolInAttributeError = 38;
  NSXMLParserLiteralNotFinishedError = 44;
  NSXMLParserLiteralNotStartedError = 43;
  NSXMLParserMisplacedCDATAEndStringError = 62;
  NSXMLParserMisplacedXMLDeclarationError = 64;
  NSXMLParserMixedContentDeclNotFinishedError = 53;
  NSXMLParserMixedContentDeclNotStartedError = 52;
  NSXMLParserNAMERequiredError = 68;
  NSXMLParserNMTOKENRequiredError = 67;
  NSXMLParserNamespaceDeclarationError = 35;
  NSXMLParserNoDTDError = 94;
  NSXMLParserNotWellBalancedError = 85;
  NSXMLParserNotationNotFinishedError = 49;
  NSXMLParserNotationNotStartedError = 48;
  NSXMLParserOutOfMemoryError = 2;
  NSXMLParserPCDATARequiredError = 69;
  NSXMLParserParsedEntityRefAtEOFError = 18;
  NSXMLParserParsedEntityRefInEpilogError = 20;
  NSXMLParserParsedEntityRefInInternalError = 88;
  NSXMLParserParsedEntityRefInInternalSubsetError = 21;
  NSXMLParserParsedEntityRefInPrologError = 19;
  NSXMLParserParsedEntityRefMissingSemiError = 25;
  NSXMLParserParsedEntityRefNoNameError = 24;
  NSXMLParserPrematureDocumentEndError = 5;
  NSXMLParserProcessingInstructionNotFinishedError = 47;
  NSXMLParserProcessingInstructionNotStartedError = 46;
  NSXMLParserPublicIdentifierRequiredError = 71;
  NSXMLParserSeparatorRequiredError = 66;
  NSXMLParserSpaceRequiredError = 65;
  NSXMLParserStandaloneValueError = 78;
  NSXMLParserStringNotClosedError = 34;
  NSXMLParserStringNotStartedError = 33;
  NSXMLParserTagNameMismatchError = 76;
  NSXMLParserURIFragmentError = 92;
  NSXMLParserURIRequiredError = 70;
  NSXMLParserUndeclaredEntityError = 26;
  NSXMLParserUnfinishedTagError = 77;
  NSXMLParserUnknownEncodingError = 31;
  NSXMLParserUnparsedEntityError = 28;
  NSXMLParserXMLDeclNotFinishedError = 57;
  NSXMLParserXMLDeclNotStartedError = 56;
  NSYearCalendarUnit = 4;
  NSYearForWeekOfYearCalendarUnit = 16384;
  NS_BLOCKS_AVAILABLE = 1;
  NS_BigEndian = 2;
  NS_LittleEndian = 1;
  NS_UNICHAR_IS_EIGHT_BIT = 0;
  NS_UnknownByteOrder = 0;

// ===== Typedefs and structs =====
{$M+}
type
  NSCalendarUnit = NSUInteger;
  NSComparisonPredicateOptions = NSUInteger;
  NSComparator = Pointer;
  NSComparisonPredicateModifier = NSUInteger;
  NSComparisonResult = NSInteger;
  NSCompoundPredicateType = NSUInteger;
  NSDataReadingOptions = NSUInteger;
  NSDataSearchOptions = NSUInteger;
  NSDataWritingOptions = NSUInteger;
  NSDateFormatterBehavior = NSUInteger;
  NSDateFormatterStyle = NSUInteger;
  NSDirectoryEnumerationOptions = NSUInteger;
  NSExpressionType = NSUInteger;
  NSFileManagerItemReplacementOptions = NSUInteger;
  NSFileVersionAddingOptions = NSUInteger;
  NSFileVersionReplacingOptions = NSUInteger;
  NSFileWrapperReadingOptions = NSUInteger;
  NSFileWrapperWritingOptions = NSUInteger;
  NSHTTPCookieAcceptPolicy = NSUInteger;
  NSJSONReadingOptions = NSUInteger;
  NSJSONWritingOptions = NSUInteger;
  NSKeyValueChange = NSUInteger;
  NSKeyValueObservingOptions = NSUInteger;
  NSKeyValueSetMutationKind = NSUInteger;
  NSLinguisticTaggerOptions = NSUInteger;
  NSLocaleLanguageDirection = NSUInteger;
  NSMatchingOptions = NSUInteger;
  NSNetServiceOptions = NSUInteger;
  NSNumberFormatterBehavior = NSUInteger;
  NSNumberFormatterPadPosition = NSUInteger;
  NSNumberFormatterRoundingMode = NSUInteger;
  NSNumberFormatterStyle = NSUInteger;
  NSOperationQueuePriority = NSInteger;
  NSPostingStyle = NSUInteger;
  NSPredicateOperatorType = NSUInteger;
  NSPropertyListFormat = NSUInteger;
  PNSPropertyListFormat = ^NSPropertyListFormat;
  NSPropertyListMutabilityOptions = NSUInteger;
  NSPropertyListReadOptions = NSUInteger;
  NSPropertyListWriteOptions = NSUInteger;
  NSRegularExpressionOptions = NSUInteger;
  NSRoundingMode = NSUInteger;
  NSSearchPathDirectory = NSUInteger;
  NSSearchPathDomainMask = NSUInteger;
  NSStreamStatus = NSUInteger;
  NSStringCompareOptions = NSUInteger;
  NSStringEncoding = NSUInteger;
  PNSStringEncoding = ^NSStringEncoding;
  NSStringEncodingConversionOptions = NSUInteger;
  NSTextCheckingType = UInt64;
  NSTextCheckingTypes = UInt64;
  NSTimeZoneNameStyle = NSInteger;
  NSURLBookmarkCreationOptions = NSUInteger;
  NSURLBookmarkFileCreationOptions = NSUInteger;
  NSURLBookmarkResolutionOptions = NSUInteger;
  NSURLCacheStoragePolicy = Integer;
  NSURLCredentialPersistence = NSUInteger;
  NSURLRequestCachePolicy = NSUInteger;
  NSURLRequestNetworkServiceType = NSUInteger;
  NSVolumeEnumerationOptions = NSUInteger;
  PNSArray = Pointer;
  PNSString = Pointer;
  SecIdentityRef = Pointer;
  SecTrustRef = Pointer;

  NSDecimal = record
    _exponent: Integer;
    _length: Longword;
    _isNegative: Longword;
    _isCompact: Longword;
    _mantissa: Word;
  end;
  PNSDecimal = ^NSDecimal;

  NSRange = record
    location: NSUInteger;
    length: NSUInteger;
  end;
  PNSRange = ^NSRange;

  NSPoint = record
    x: Single;
    y: Single;
  end;

  NSSize = record
    width: Single;
    height: Single;
  end;

  NSRect = record
    origin: NSPoint;
    size: NSSize;
  end;

// ===== External functions =====

const
  libFoundation = '/System/Library/Frameworks/Foundation.framework/Foundation';

function CFBridgingRelease(X: CFTypeRef): Pointer; cdecl; external libFoundation name _PU + 'CFBridgingRelease';
function CFBridgingRetain(X: Pointer): CFTypeRef; cdecl; external libFoundation name _PU + 'CFBridgingRetain';
function NSAllocateMemoryPages(bytes: NSUInteger): Pointer; cdecl; external libFoundation name _PU + 'NSAllocateMemoryPages';
function NSAllocateObject(aClass: Pointer; extraBytes: NSUInteger; zone: Pointer): Pointer; cdecl; external libFoundation name _PU + 'NSAllocateObject';
function NSClassFromString(aClassName: PNSString): Pointer; cdecl; external libFoundation name _PU + 'NSClassFromString';
//function NSConvertHostDoubleToSwapped(x: double): NSSwappedDouble; cdecl; external libFoundation name _PU + 'NSConvertHostDoubleToSwapped';
//function NSConvertHostFloatToSwapped(x: Single): NSSwappedFloat; cdecl; external libFoundation name _PU + 'NSConvertHostFloatToSwapped';
//function NSConvertSwappedDoubleToHost(x: NSSwappedDouble): double; cdecl; external libFoundation name _PU + 'NSConvertSwappedDoubleToHost';
//function NSConvertSwappedFloatToHost(x: NSSwappedFloat): Single; cdecl; external libFoundation name _PU + 'NSConvertSwappedFloatToHost';
procedure NSCopyMemoryPages(source: Pointer; dest: Pointer; bytes: NSUInteger); cdecl; external libFoundation name _PU + 'NSCopyMemoryPages';
function NSCopyObject(object_: Pointer; extraBytes: NSUInteger; zone: Pointer): Pointer; cdecl; external libFoundation name _PU + 'NSCopyObject';
function NSCreateZone(startSize: NSUInteger; granularity: NSUInteger; canFree: Boolean): Pointer; cdecl; external libFoundation name _PU + 'NSCreateZone';
procedure NSDeallocateMemoryPages(ptr: Pointer; bytes: NSUInteger); cdecl; external libFoundation name _PU + 'NSDeallocateMemoryPages';
procedure NSDeallocateObject(object_: Pointer); cdecl; external libFoundation name _PU + 'NSDeallocateObject';
//function NSDecimalAdd(result: PNSDecimal; leftOperand: PNSDecimal; rightOperand: PNSDecimal; roundingMode: NSRoundingMode): NSCalculationError; cdecl; external libFoundation name _PU + 'NSDecimalAdd';
procedure NSDecimalCompact(number: PNSDecimal); cdecl; external libFoundation name _PU + 'NSDecimalCompact';
function NSDecimalCompare(leftOperand: PNSDecimal; rightOperand: PNSDecimal): NSComparisonResult; cdecl; external libFoundation name _PU + 'NSDecimalCompare';
procedure NSDecimalCopy(destination: PNSDecimal; source: PNSDecimal); cdecl; external libFoundation name _PU + 'NSDecimalCopy';
//function NSDecimalDivide(result: PNSDecimal; leftOperand: PNSDecimal; rightOperand: PNSDecimal; roundingMode: NSRoundingMode): NSCalculationError; cdecl; external libFoundation name _PU + 'NSDecimalDivide';
function NSDecimalIsNotANumber(dcm: PNSDecimal): Boolean; cdecl; external libFoundation name _PU + 'NSDecimalIsNotANumber';
//function NSDecimalMultiply(result: PNSDecimal; leftOperand: PNSDecimal; rightOperand: PNSDecimal; roundingMode: NSRoundingMode): NSCalculationError; cdecl; external libFoundation name _PU + 'NSDecimalMultiply';
//function NSDecimalMultiplyByPowerOf10(result: PNSDecimal; number: PNSDecimal; power: Smallint; roundingMode: NSRoundingMode): NSCalculationError; cdecl; external libFoundation name _PU + 'NSDecimalMultiplyByPowerOf10';
//function NSDecimalNormalize(number1: PNSDecimal; number2: PNSDecimal; roundingMode: NSRoundingMode): NSCalculationError; cdecl; external libFoundation name _PU + 'NSDecimalNormalize';
//function NSDecimalPower(result: PNSDecimal; number: PNSDecimal; power: NSUInteger; roundingMode: NSRoundingMode): NSCalculationError; cdecl; external libFoundation name _PU + 'NSDecimalPower';
procedure NSDecimalRound(result: PNSDecimal; number: PNSDecimal; scale: NSInteger; roundingMode: NSRoundingMode); cdecl; external libFoundation name _PU + 'NSDecimalRound';
function NSDecimalString(dcm: PNSDecimal; locale: Pointer): PNSString; cdecl; external libFoundation name _PU + 'NSDecimalString';
//function NSDecimalSubtract(result: PNSDecimal; leftOperand: PNSDecimal; rightOperand: PNSDecimal; roundingMode: NSRoundingMode): NSCalculationError; cdecl; external libFoundation name _PU + 'NSDecimalSubtract';
function NSDecrementExtraRefCountWasZero(object_: Pointer): Boolean; cdecl; external libFoundation name _PU + 'NSDecrementExtraRefCountWasZero';
function NSDefaultMallocZone: Pointer; cdecl; external libFoundation name _PU + 'NSDefaultMallocZone';
function NSExtraRefCount(object_: Pointer): NSUInteger; cdecl; external libFoundation name _PU + 'NSExtraRefCount';
function NSFullUserName: PNSString; cdecl; external libFoundation name _PU + 'NSFullUserName';
function NSGetSizeAndAlignment(typePtr: MarshaledAString; sizep: PNSUInteger; alignp: PNSUInteger): MarshaledAString; cdecl; external libFoundation name _PU + 'NSGetSizeAndAlignment';
//function NSGetUncaughtExceptionHandler: PNSUncaughtExceptionHandler; cdecl; external libFoundation name _PU + 'NSGetUncaughtExceptionHandler';
function NSHomeDirectory: PNSString; cdecl; external libFoundation name _PU + 'NSHomeDirectory';
function NSHomeDirectoryForUser(userName: PNSString): PNSString; cdecl; external libFoundation name _PU + 'NSHomeDirectoryForUser';
function NSHostByteOrder: Longint; cdecl; external libFoundation name _PU + 'NSHostByteOrder';
procedure NSIncrementExtraRefCount(object_: Pointer); cdecl; external libFoundation name _PU + 'NSIncrementExtraRefCount';
function NSIntersectionRange(range1: NSRange; range2: NSRange): NSRange; cdecl; external libFoundation name _PU + 'NSIntersectionRange';
procedure NSLog(format: PNSString); cdecl; varargs; external libFoundation name _PU + 'NSLog';
function NSLogPageSize: NSUInteger; cdecl; external libFoundation name _PU + 'NSLogPageSize';
//procedure NSLogv(format: PNSString; args: va_list); cdecl; external libFoundation name _PU + 'NSLogv';
function NSMakeCollectable(cf: CFTypeRef): Pointer; cdecl; external libFoundation name _PU + 'NSMakeCollectable';
function NSOpenStepRootDirectory: PNSString; cdecl; external libFoundation name _PU + 'NSOpenStepRootDirectory';
function NSPageSize: NSUInteger; cdecl; external libFoundation name _PU + 'NSPageSize';
function NSProtocolFromString(namestr: PNSString): Pointer; cdecl; external libFoundation name _PU + 'NSProtocolFromString';
function NSRangeFromString(aString: PNSString): NSRange; cdecl; external libFoundation name _PU + 'NSRangeFromString';
function NSRealMemoryAvailable: NSUInteger; cdecl; external libFoundation name _PU + 'NSRealMemoryAvailable';
procedure NSRecycleZone(zone: Pointer); cdecl; external libFoundation name _PU + 'NSRecycleZone';
function NSRoundDownToMultipleOfPageSize(bytes: NSUInteger): NSUInteger; cdecl; external libFoundation name _PU + 'NSRoundDownToMultipleOfPageSize';
function NSRoundUpToMultipleOfPageSize(bytes: NSUInteger): NSUInteger; cdecl; external libFoundation name _PU + 'NSRoundUpToMultipleOfPageSize';
function NSSearchPathForDirectoriesInDomains(directory: NSSearchPathDirectory; domainMask: NSSearchPathDomainMask; expandTilde: Boolean): PNSArray; cdecl; external libFoundation name _PU + 'NSSearchPathForDirectoriesInDomains';
function NSSelectorFromString(aSelectorName: PNSString): SEL; cdecl; external libFoundation name _PU + 'NSSelectorFromString';
//procedure NSSetUncaughtExceptionHandler(dummy: PNSUncaughtExceptionHandler); cdecl; external libFoundation name _PU + 'NSSetUncaughtExceptionHandler';
procedure NSSetZoneName(zone: Pointer; name: PNSString); cdecl; external libFoundation name _PU + 'NSSetZoneName';
function NSShouldRetainWithZone(anObject: Pointer; requestedZone: Pointer): Boolean; cdecl; external libFoundation name _PU + 'NSShouldRetainWithZone';
function NSStringFromClass(aClass: Pointer): PNSString; cdecl; external libFoundation name _PU + 'NSStringFromClass';
function NSStringFromProtocol(proto: Pointer): PNSString; cdecl; external libFoundation name _PU + 'NSStringFromProtocol';
function NSStringFromRange(range: NSRange): PNSString; cdecl; external libFoundation name _PU + 'NSStringFromRange';
function NSStringFromSelector(aSelector: SEL): PNSString; cdecl; external libFoundation name _PU + 'NSStringFromSelector';
//function NSSwapBigDoubleToHost(x: NSSwappedDouble): double; cdecl; external libFoundation name _PU + 'NSSwapBigDoubleToHost';
//function NSSwapBigFloatToHost(x: NSSwappedFloat): Single; cdecl; external libFoundation name _PU + 'NSSwapBigFloatToHost';
function NSSwapBigIntToHost(x: Longword): Longword; cdecl; external libFoundation name _PU + 'NSSwapBigIntToHost';
function NSSwapBigLongLongToHost(x: UInt64): UInt64; cdecl; external libFoundation name _PU + 'NSSwapBigLongLongToHost';
function NSSwapBigLongToHost(x: Longword): Longword; cdecl; external libFoundation name _PU + 'NSSwapBigLongToHost';
function NSSwapBigShortToHost(x: Word): Word; cdecl; external libFoundation name _PU + 'NSSwapBigShortToHost';
//function NSSwapDouble(x: NSSwappedDouble): NSSwappedDouble; cdecl; external libFoundation name _PU + 'NSSwapDouble';
//function NSSwapFloat(x: NSSwappedFloat): NSSwappedFloat; cdecl; external libFoundation name _PU + 'NSSwapFloat';
//function NSSwapHostDoubleToBig(x: double): NSSwappedDouble; cdecl; external libFoundation name _PU + 'NSSwapHostDoubleToBig';
//function NSSwapHostDoubleToLittle(x: double): NSSwappedDouble; cdecl; external libFoundation name _PU + 'NSSwapHostDoubleToLittle';
//function NSSwapHostFloatToBig(x: Single): NSSwappedFloat; cdecl; external libFoundation name _PU + 'NSSwapHostFloatToBig';
//function NSSwapHostFloatToLittle(x: Single): NSSwappedFloat; cdecl; external libFoundation name _PU + 'NSSwapHostFloatToLittle';
function NSSwapHostIntToBig(x: Longword): Longword; cdecl; external libFoundation name _PU + 'NSSwapHostIntToBig';
function NSSwapHostIntToLittle(x: Longword): Longword; cdecl; external libFoundation name _PU + 'NSSwapHostIntToLittle';
function NSSwapHostLongLongToBig(x: UInt64): UInt64; cdecl; external libFoundation name _PU + 'NSSwapHostLongLongToBig';
function NSSwapHostLongLongToLittle(x: UInt64): UInt64; cdecl; external libFoundation name _PU + 'NSSwapHostLongLongToLittle';
function NSSwapHostLongToBig(x: Longword): Longword; cdecl; external libFoundation name _PU + 'NSSwapHostLongToBig';
function NSSwapHostLongToLittle(x: Longword): Longword; cdecl; external libFoundation name _PU + 'NSSwapHostLongToLittle';
function NSSwapHostShortToBig(x: Word): Word; cdecl; external libFoundation name _PU + 'NSSwapHostShortToBig';
function NSSwapHostShortToLittle(x: Word): Word; cdecl; external libFoundation name _PU + 'NSSwapHostShortToLittle';
function NSSwapInt(inv: Longword): Longword; cdecl; external libFoundation name _PU + 'NSSwapInt';
//function NSSwapLittleDoubleToHost(x: NSSwappedDouble): double; cdecl; external libFoundation name _PU + 'NSSwapLittleDoubleToHost';
//function NSSwapLittleFloatToHost(x: NSSwappedFloat): Single; cdecl; external libFoundation name _PU + 'NSSwapLittleFloatToHost';
function NSSwapLittleIntToHost(x: Longword): Longword; cdecl; external libFoundation name _PU + 'NSSwapLittleIntToHost';
function NSSwapLittleLongLongToHost(x: UInt64): UInt64; cdecl; external libFoundation name _PU + 'NSSwapLittleLongLongToHost';
function NSSwapLittleLongToHost(x: Longword): Longword; cdecl; external libFoundation name _PU + 'NSSwapLittleLongToHost';
function NSSwapLittleShortToHost(x: Word): Word; cdecl; external libFoundation name _PU + 'NSSwapLittleShortToHost';
function NSSwapLong(inv: Longword): Longword; cdecl; external libFoundation name _PU + 'NSSwapLong';
function NSSwapLongLong(inv: UInt64): UInt64; cdecl; external libFoundation name _PU + 'NSSwapLongLong';
function NSSwapShort(inv: Word): Word; cdecl; external libFoundation name _PU + 'NSSwapShort';
function NSTemporaryDirectory: PNSString; cdecl; external libFoundation name _PU + 'NSTemporaryDirectory';
function NSUnionRange(range1: NSRange; range2: NSRange): NSRange; cdecl; external libFoundation name _PU + 'NSUnionRange';
function NSUserName: PNSString; cdecl; external libFoundation name _PU + 'NSUserName';
function NSZoneCalloc(zone: Pointer; numElems: NSUInteger; byteSize: NSUInteger): Pointer; cdecl; external libFoundation name _PU + 'NSZoneCalloc';
procedure NSZoneFree(zone: Pointer; ptr: Pointer); cdecl; external libFoundation name _PU + 'NSZoneFree';
function NSZoneFromPointer(ptr: Pointer): Pointer; cdecl; external libFoundation name _PU + 'NSZoneFromPointer';
function NSZoneMalloc(zone: Pointer; size: NSUInteger): Pointer; cdecl; external libFoundation name _PU + 'NSZoneMalloc';
function NSZoneName(zone: Pointer): PNSString; cdecl; external libFoundation name _PU + 'NSZoneName';
function NSZoneRealloc(zone: Pointer; ptr: Pointer; size: NSUInteger): Pointer; cdecl; external libFoundation name _PU + 'NSZoneRealloc';

//type
//{$M+}
// ===== Forward declarations =====
//
//  NSCacheDelegate = interface;
//  NSFileManagerDelegate = interface;
//  NSFilePresenter = interface;
//  NSKeyedArchiverDelegate = interface;
//  NSKeyedUnarchiverDelegate = interface;
//  NSMachPortDelegate = interface;
//  NSMetadataQueryDelegate = interface;
//  NSNetServiceBrowserDelegate = interface;
//  NSNetServiceDelegate = interface;
//  NSPortDelegate = interface;
//  NSStreamDelegate = interface;
//  NSURLAuthenticationChallengeSender = interface;
//  NSURLConnectionDataDelegate = interface;
//  NSURLConnectionDelegate = interface;
//  NSURLConnectionDownloadDelegate = interface;
//  NSURLProtocolClient = interface;
//  NSXMLParserDelegate = interface;

// ===== Protocol declarations =====
(*
  NSCacheDelegate = interface(IObjectiveC)
    ['{B599129B-5DE7-4042-9C49-01D4E8717C86}']
    procedure cache(cache: NSCache; willEvictObject: Pointer); cdecl;
  end;
  NSCoding = interface
    ['{A097DD51-409B-45C4-A67A-94019DEB46F5}']
    procedure encodeWithCoder(aCoder: NSCoder); cdecl;
    function initWithCoder(aDecoder: NSCoder): Pointer; cdecl;
  end;
  NSCopying = interface
    ['{D05A935C-2D91-42E3-B8C9-ED6CE4ECDDC2}']
    function copyWithZone(zone: Pointer): Pointer; cdecl;
  end;
  NSDecimalNumberBehaviors = interface
    ['{8FA1345B-F5E1-4F2F-950D-589F3E41105C}']
    function exceptionDuringOperation(operation: SEL; error: NSCalculationError; leftOperand: NSDecimalNumber; rightOperand: NSDecimalNumber): NSDecimalNumber; cdecl;
    function roundingMode: NSRoundingMode; cdecl;
    function scale: Smallint; cdecl;
  end;
  NSDiscardableContent = interface
    ['{A52C50BA-8A13-4169-914B-6DFFAD7A2AAE}']
    function beginContentAccess: Boolean; cdecl;
    procedure discardContentIfPossible; cdecl;
    procedure endContentAccess; cdecl;
    function isContentDiscarded: Boolean; cdecl;
  end;
  NSFastEnumeration = interface
    ['{8834CF48-07D3-438F-854D-46C4066EC64A}']
    function countByEnumeratingWithState(state: NSFastEnumerationState; objects: Pointer; count: NSUInteger): NSUInteger; cdecl;
  end;
  NSFileManagerDelegate = interface(IObjectiveC)
    ['{0DF2AED6-DF37-4A29-A670-6709C81D952E}']
    function fileManager(fileManager: NSFileManager; shouldCopyItemAtPath: NSString; toPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldCopyItemAtURL: NSURL; toURL: NSURL): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldLinkItemAtPath: NSString; toPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldLinkItemAtURL: NSURL; toURL: NSURL): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldMoveItemAtPath: NSString; toPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldMoveItemAtURL: NSURL; toURL: NSURL): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; copyingItemAtPath: NSString; toPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; copyingItemAtURL: NSURL; toURL: NSURL): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; linkingItemAtPath: NSString; toPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; linkingItemAtURL: NSURL; toURL: NSURL): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; movingItemAtPath: NSString; toPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; movingItemAtURL: NSURL; toURL: NSURL): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; removingItemAtPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; removingItemAtURL: NSURL): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldRemoveItemAtPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldRemoveItemAtURL: NSURL): Boolean; cdecl; overload;
  end;
  NSFilePresenter = interface(IObjectiveC)
    ['{D526650B-D59A-4CE3-9EF4-16D882DF93BA}']
    procedure presentedItemDidChange; cdecl;
    procedure presentedItemDidGainVersion(version: NSFileVersion); cdecl;
    procedure presentedItemDidLoseVersion(version: NSFileVersion); cdecl;
    procedure presentedItemDidMoveToURL(newURL: NSURL); cdecl;
    procedure presentedItemDidResolveConflictVersion(version: NSFileVersion); cdecl;
    function presentedItemOperationQueue: NSOperationQueue; cdecl;
    function presentedItemURL: NSURL; cdecl;
    procedure presentedSubitemAtURL(url: NSURL; didGainVersion: NSFileVersion); cdecl; overload;
    procedure presentedSubitemAtURL(url: NSURL; didLoseVersion: NSFileVersion); cdecl; overload;
    procedure presentedSubitemAtURL(oldURL: NSURL; didMoveToURL: NSURL); cdecl; overload;
    procedure presentedSubitemAtURL(url: NSURL; didResolveConflictVersion: NSFileVersion); cdecl; overload;
    procedure presentedSubitemDidAppearAtURL(url: NSURL); cdecl;
    procedure presentedSubitemDidChangeAtURL(url: NSURL); cdecl;
  end;
  NSKeyedArchiverDelegate = interface(IObjectiveC)
    ['{A5F91533-73FB-46F2-83C4-52D34F2DAD20}']
    procedure archiver(archiver: NSKeyedArchiver; didEncodeObject: Pointer); cdecl; overload;
    function archiver(archiver: NSKeyedArchiver; willEncodeObject: Pointer): Pointer; cdecl; overload;
    procedure archiver(archiver: NSKeyedArchiver; willReplaceObject: Pointer; withObject: Pointer); cdecl; overload;
    procedure archiverDidFinish(archiver: NSKeyedArchiver); cdecl;
    procedure archiverWillFinish(archiver: NSKeyedArchiver); cdecl;
  end;
  NSKeyedUnarchiverDelegate = interface(IObjectiveC)
    ['{09B875EF-31FC-4FA4-86DC-5F771FA6F1CE}']
    function unarchiver(unarchiver: NSKeyedUnarchiver; didDecodeObject: Pointer): Pointer; cdecl; overload;
    procedure unarchiver(unarchiver: NSKeyedUnarchiver; willReplaceObject: Pointer; withObject: Pointer); cdecl; overload;
    procedure unarchiverDidFinish(unarchiver: NSKeyedUnarchiver); cdecl;
    procedure unarchiverWillFinish(unarchiver: NSKeyedUnarchiver); cdecl;
  end;
  NSLocking = interface
    ['{BD6D8247-8760-4EB3-A754-9FBA926DA7FB}']
    procedure lock; cdecl;
    procedure unlock; cdecl;
  end;
  NSMachPortDelegate = interface(NSPortDelegate)
    ['{A7BF82D1-7C3E-4555-8EDD-69F3AC5F4C78}']
    procedure handleMachMessage(msg: Pointer); cdecl;
  end;
  NSMetadataQueryDelegate = interface(IObjectiveC)
    ['{436F09B1-6A78-4130-B846-50605B59897E}']
    function metadataQuery(query: NSMetadataQuery; replacementObjectForResultObject: NSMetadataItem): Pointer; cdecl; overload;
    function metadataQuery(query: NSMetadataQuery; replacementValueForAttribute: NSString; value: Pointer): Pointer; cdecl; overload;
  end;
  NSMutableCopying = interface
    ['{38AF11D4-75EB-4CE6-A7A7-703A74D23D9D}']
    function mutableCopyWithZone(zone: Pointer): Pointer; cdecl;
  end;
  NSNetServiceBrowserDelegate = interface(IObjectiveC)
    ['{3B70B04D-442C-4DDC-81BD-C91ECAD8B356}']
    procedure netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser; didFindDomain: NSString; moreComing: Boolean); cdecl; overload;
    procedure netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser; didFindService: NSNetService; moreComing: Boolean); cdecl; overload;
    procedure netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser; didNotSearch: NSDictionary); cdecl; overload;
    procedure netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser; didRemoveDomain: NSString; moreComing: Boolean); cdecl; overload;
    procedure netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser; didRemoveService: NSNetService; moreComing: Boolean); cdecl; overload;
    procedure netServiceBrowserDidStopSearch(aNetServiceBrowser: NSNetServiceBrowser); cdecl;
    procedure netServiceBrowserWillSearch(aNetServiceBrowser: NSNetServiceBrowser); cdecl;
  end;
  NSNetServiceDelegate = interface(IObjectiveC)
    ['{98315523-A2B1-4337-B3F8-EA3E171025B9}']
    procedure netService(sender: NSNetService; didNotPublish: NSDictionary); cdecl; overload;
    procedure netService(sender: NSNetService; didNotResolve: NSDictionary); cdecl; overload;
    procedure netService(sender: NSNetService; didUpdateTXTRecordData: NSData); cdecl; overload;
    procedure netServiceDidPublish(sender: NSNetService); cdecl;
    procedure netServiceDidResolveAddress(sender: NSNetService); cdecl;
    procedure netServiceDidStop(sender: NSNetService); cdecl;
    procedure netServiceWillPublish(sender: NSNetService); cdecl;
    procedure netServiceWillResolve(sender: NSNetService); cdecl;
  end;
  NSObject = interface
    ['{5FC98210-A3F2-471B-B89F-63DF8F60DF42}']
    function autorelease: Pointer; cdecl;
    function conformsToProtocol(aProtocol: Pointer): Boolean; cdecl;
    function debugDescription: NSString; cdecl;
    function description: NSString; cdecl;
    function hash: NSUInteger; cdecl;
    function isEqual(object_: Pointer): Boolean; cdecl;
    function isKindOfClass(aClass: Pointer): Boolean; cdecl;
    function isMemberOfClass(aClass: Pointer): Boolean; cdecl;
    function isProxy: Boolean; cdecl;
    function performSelector(aSelector: SEL): Pointer; cdecl; overload;
    function performSelector(aSelector: SEL; withObject: Pointer): Pointer; cdecl; overload;
    procedure release; cdecl;
    function respondsToSelector(aSelector: SEL): Boolean; cdecl;
    function retain: Pointer; cdecl;
    function retainCount: NSUInteger; cdecl;
    function self: Pointer; cdecl;
    function zone: Pointer; cdecl;
  end;
  NSPortDelegate = interface(IObjectiveC)
    ['{0301DBDF-F430-4B44-9B31-2B4735FE9155}']
    procedure handlePortMessage(message: NSPortMessage); cdecl;
  end;
  NSStreamDelegate = interface(IObjectiveC)
    ['{E88966DE-2163-4FE7-8D09-106106D0DF3C}']
    procedure stream(aStream: NSStream; handleEvent: NSStreamEvent); cdecl;
  end;
  NSURLAuthenticationChallengeSender = interface(IObjectiveC)
    ['{6C9B108A-A17B-4B8C-A159-0CD663BDAA05}']
    procedure cancelAuthenticationChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
    procedure continueWithoutCredentialForAuthenticationChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
    procedure performDefaultHandlingForAuthenticationChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
    procedure rejectProtectionSpaceAndContinueWithChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
    procedure useCredential(credential: NSURLCredential; forAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl;
  end;
  NSURLConnectionDataDelegate = interface(NSURLConnectionDelegate)
    ['{6F015871-FCF4-4F8D-B9E5-C6484D6F60E7}']
    procedure connection(connection: NSURLConnection; didReceiveData: NSData); cdecl; overload;
    procedure connection(connection: NSURLConnection; didReceiveResponse: NSURLResponse); cdecl; overload;
    procedure connection(connection: NSURLConnection; didSendBodyData: NSInteger; totalBytesWritten: NSInteger; totalBytesExpectedToWrite: NSInteger); cdecl; overload;
    function connection(connection: NSURLConnection; needNewBodyStream: NSURLRequest): NSInputStream; cdecl; overload;
    function connection(connection: NSURLConnection; willCacheResponse: NSCachedURLResponse): NSCachedURLResponse; cdecl; overload;
    function connection(connection: NSURLConnection; willSendRequest: NSURLRequest; redirectResponse: NSURLResponse): NSURLRequest; cdecl; overload;
    procedure connectionDidFinishLoading(connection: NSURLConnection); cdecl;
  end;
  NSURLConnectionDelegate = interface(IObjectiveC)
    ['{682BABAC-89E0-4A9B-BFF5-96A7EE7881A6}']
    function connection(connection: NSURLConnection; canAuthenticateAgainstProtectionSpace: NSURLProtectionSpace): Boolean; cdecl; overload;
    procedure connection(connection: NSURLConnection; didCancelAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl; overload;
    procedure connection(connection: NSURLConnection; didFailWithError: NSError); cdecl; overload;
    procedure connection(connection: NSURLConnection; didReceiveAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl; overload;
    procedure connection(connection: NSURLConnection; willSendRequestForAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl; overload;
    function connectionShouldUseCredentialStorage(connection: NSURLConnection): Boolean; cdecl;
  end;
  NSURLConnectionDownloadDelegate = interface(NSURLConnectionDelegate)
    ['{3E8ADDEC-8885-4076-A7C8-C5F45E98B826}']
    procedure connection(connection: NSURLConnection; didWriteData: Int64; totalBytesWritten: Int64; expectedTotalBytes: Int64); cdecl;
    procedure connectionDidFinishDownloading(connection: NSURLConnection; destinationURL: NSURL); cdecl;
    procedure connectionDidResumeDownloading(connection: NSURLConnection; totalBytesWritten: Int64; expectedTotalBytes: Int64); cdecl;
  end;
  NSURLProtocolClient = interface(IObjectiveC)
    ['{99D98DA9-B099-42A4-B8B9-B9A068416977}']
    procedure URLProtocol(protocol: NSURLProtocol; cachedResponseIsValid: NSCachedURLResponse); cdecl; overload;
    procedure URLProtocol(protocol: NSURLProtocol; didCancelAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl; overload;
    procedure URLProtocol(protocol: NSURLProtocol; didFailWithError: NSError); cdecl; overload;
    procedure URLProtocol(protocol: NSURLProtocol; didLoadData: NSData); cdecl; overload;
    procedure URLProtocol(protocol: NSURLProtocol; didReceiveAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl; overload;
    procedure URLProtocol(protocol: NSURLProtocol; didReceiveResponse: NSURLResponse; cacheStoragePolicy: NSURLCacheStoragePolicy); cdecl; overload;
    procedure URLProtocol(protocol: NSURLProtocol; wasRedirectedToRequest: NSURLRequest; redirectResponse: NSURLResponse); cdecl; overload;
    procedure URLProtocolDidFinishLoading(protocol: NSURLProtocol); cdecl;
  end;
  NSXMLParserDelegate = interface(IObjectiveC)
    ['{1B1EFB31-E840-49A4-A2AE-B854E29D0BF4}']
    procedure parser(parser: NSXMLParser; didEndElement: NSString; namespaceURI: NSString; qualifiedName: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; didEndMappingPrefix: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; didStartElement: NSString; namespaceURI: NSString; qualifiedName: NSString; attributes: NSDictionary); cdecl; overload;
    procedure parser(parser: NSXMLParser; didStartMappingPrefix: NSString; toURI: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundCDATA: NSData); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundCharacters: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundComment: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundElementDeclarationWithName: NSString; model: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundExternalEntityDeclarationWithName: NSString; publicID: NSString; systemID: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundIgnorableWhitespace: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundInternalEntityDeclarationWithName: NSString; value: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundNotationDeclarationWithName: NSString; publicID: NSString; systemID: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundProcessingInstructionWithTarget: NSString; data: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundUnparsedEntityDeclarationWithName: NSString; publicID: NSString; systemID: NSString; notationName: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; parseErrorOccurred: NSError); cdecl; overload;
    function parser(parser: NSXMLParser; resolveExternalEntityName: NSString; systemID: NSString): NSData; cdecl; overload;
    procedure parser(parser: NSXMLParser; validationErrorOccurred: NSError); cdecl; overload;
    procedure parserDidEndDocument(parser: NSXMLParser); cdecl;
    procedure parserDidStartDocument(parser: NSXMLParser); cdecl;
  end;
*)

type
{$M+}
// ===== Forward declarations =====

  NSTimer = interface;
  NSTimeZone = interface;
  NSURL = interface;
  NSMethodSignature = interface;
  NSURLAuthenticationChallenge = interface;
  NSStream = interface;
  NSSortDescriptor = interface;
  NSString = interface;
  NSThread = interface;
  NSTextCheckingResult = interface;
  NSMetadataQueryResultGroup = interface;
  NSLinguisticTagger = interface;
  NSLocale = interface;
  NSURLConnection = interface;
  NSJSONSerialization = interface;
  NSURLCredential = interface;
  NSMetadataQuery = interface;
  NSMetadataQueryAttributeValueTuple = interface;
  NSMetadataItem = interface;
  NSLock = interface;
  NSURLCache = interface;
  NSSet = interface;
  NSPipe = interface;
  NSPort = interface;
  NSRegularExpression = interface;
  NSOrderedSet = interface;
  NSOrthography = interface;
  NSProxy = interface;
  NSRecursiveLock = interface;
  NSPropertyListSerialization = interface;
  NSPredicate = interface;
  NSProcessInfo = interface;
  NSOperationQueue = interface;
  NSNotificationCenter = interface;
  NSNotificationQueue = interface;
  NSNotification = interface;
  NSNetService = interface;
  NSNetServiceBrowser = interface;
//  NSObject = interface;
  NSOperation = interface;
  NSRunLoop = interface;
  NSNull = interface;
  NSScanner = interface;
  NSConditionLock = interface;
  NSUserDefaults = interface;
  NSCondition = interface;
  NSValueTransformer = interface;
  NSValue = interface;
  NSDateComponents = interface;
  NSUbiquitousKeyValueStore = interface;
  NSDate = interface;
  NSData = interface;
  NSUndoManager = interface;
  NSCoder = interface;
  NSAutoreleasePool = interface;
  NSXMLParser = interface;
  NSAttributedString = interface;
  NSArray = interface;
  NSAssertionHandler = interface;
  NSCalendar = interface;
  NSCharacterSet = interface;
  NSCachedURLResponse = interface;
  NSBundle = interface;
  NSCache = interface;
  NSURLResponse = interface;
  NSHTTPCookieStorage = interface;
  NSURLProtocol = interface;
  NSHTTPCookie = interface;
  NSFileWrapper = interface;
  NSFormatter = interface;
  NSInvocation = interface;
  NSURLCredentialStorage = interface;
  NSURLProtectionSpace = interface;
  NSIndexPath = interface;
  NSIndexSet = interface;
  NSFileVersion = interface;
  NSEnumerator = interface;
  NSError = interface;
  NSURLRequest = interface;
  NSDecimalNumberHandler = interface;
  NSDictionary = interface;
  NSFileHandle = interface;
  NSFileManager = interface;
  NSFileCoordinator = interface;
  NSException = interface;
  NSExpression = interface;
  NSInvocationOperation = interface;
  NSInputStream = interface;
  NSHTTPURLResponse = interface;
  NSMachPort = interface;
  NSKeyedUnarchiver = interface;
  NSKeyedArchiver = interface;
  NSCompoundPredicate = interface;
  NSComparisonPredicate = interface;
  NSBlockOperation = interface;
  NSDirectoryEnumerator = interface;
  NSDateFormatter = interface;
  NSDataDetector = interface;
  NSMutableArray = interface;
  NSMutableURLRequest = interface;
  NSMutableString = interface;
  NSMutableSet = interface;
  NSOutputStream = interface;
  NSNumberFormatter = interface;
  NSNumber = interface;
  NSMutableData = interface;
  NSMutableCharacterSet = interface;
  NSMutableAttributedString = interface;
  NSMutableDictionary = interface;
  NSMutableOrderedSet = interface;
  NSMutableIndexSet = interface;
  NSCountedSet = interface;
  NSDecimalNumber = interface;

// ===== Interface declarations =====

  NSTimerClass = interface(NSObjectClass)
    ['{C6D8E649-A9E8-4504-AB80-CD00B1648C26}']
    {class} function scheduledTimerWithTimeInterval(ti: NSTimeInterval; invocation: NSInvocation; repeats: Boolean): Pointer; cdecl; overload;
    {class} function scheduledTimerWithTimeInterval(ti: NSTimeInterval; target: Pointer; selector: SEL; userInfo: Pointer; repeats: Boolean): Pointer; cdecl; overload;
    {class} function timerWithTimeInterval(ti: NSTimeInterval; invocation: NSInvocation; repeats: Boolean): Pointer; cdecl; overload;
    {class} function timerWithTimeInterval(ti: NSTimeInterval; target: Pointer; selector: SEL; userInfo: Pointer; repeats: Boolean): Pointer; cdecl; overload;
  end;
  NSTimer = interface(NSObject)
    ['{DFFD98EE-530A-431B-B88F-251C935DF474}']
    procedure fire; cdecl;
    function fireDate: NSDate; cdecl;
    function initWithFireDate(date: NSDate; interval: NSTimeInterval; target: Pointer; selector: SEL; userInfo: Pointer; repeats: Boolean): Pointer; cdecl;
    procedure invalidate; cdecl;
    function isValid: Boolean; cdecl;
    procedure setFireDate(date: NSDate); cdecl;
    function timeInterval: NSTimeInterval; cdecl;
    function userInfo: Pointer; cdecl;
  end;
  TNSTimer = class(TOCGenericImport<NSTimerClass, NSTimer>)  end;

  NSTimeZoneClass = interface(NSObjectClass)
    ['{73225883-9AEE-4DC8-BCF6-61897B676A73}']
    {class} function abbreviationDictionary: NSDictionary; cdecl;
    {class} function defaultTimeZone: Pointer; cdecl;
    {class} function knownTimeZoneNames: NSArray; cdecl;
    {class} function localTimeZone: Pointer; cdecl;
    {class} procedure resetSystemTimeZone; cdecl;
    {class} procedure setAbbreviationDictionary(dict: NSDictionary); cdecl;
    {class} procedure setDefaultTimeZone(aTimeZone: NSTimeZone); cdecl;
    {class} function systemTimeZone: Pointer; cdecl;
    {class} function timeZoneDataVersion: NSString; cdecl;
    {class} function timeZoneForSecondsFromGMT(seconds: NSInteger): Pointer; cdecl;
    {class} function timeZoneWithAbbreviation(abbreviation: NSString): Pointer; cdecl;
    {class} function timeZoneWithName(tzName: NSString): Pointer; cdecl; overload;
    {class} function timeZoneWithName(tzName: NSString; data: NSData): Pointer; cdecl; overload;
  end;
  NSTimeZone = interface(NSObject)
    ['{95840E3F-DA85-4DB7-941C-4496669174B8}']
    function abbreviation: NSString; cdecl;
    function abbreviationForDate(aDate: NSDate): NSString; cdecl;
    function data: NSData; cdecl;
    function daylightSavingTimeOffset: NSTimeInterval; cdecl;
    function daylightSavingTimeOffsetForDate(aDate: NSDate): NSTimeInterval; cdecl;
    function description: NSString; cdecl;
    function initWithName(tzName: NSString): Pointer; cdecl; overload;
    function initWithName(tzName: NSString; data: NSData): Pointer; cdecl; overload;
    function isDaylightSavingTime: Boolean; cdecl;
    function isDaylightSavingTimeForDate(aDate: NSDate): Boolean; cdecl;
    function isEqualToTimeZone(aTimeZone: NSTimeZone): Boolean; cdecl;
    function localizedName(style: NSTimeZoneNameStyle; locale: NSLocale): NSString; cdecl;
    function name: NSString; cdecl;
    function nextDaylightSavingTimeTransition: NSDate; cdecl;
    function nextDaylightSavingTimeTransitionAfterDate(aDate: NSDate): NSDate; cdecl;
    function secondsFromGMT: NSInteger; cdecl;
    function secondsFromGMTForDate(aDate: NSDate): NSInteger; cdecl;
  end;
  TNSTimeZone = class(TOCGenericImport<NSTimeZoneClass, NSTimeZone>)  end;

  NSURLClass = interface(NSObjectClass)
    ['{B6B9A999-A7CF-430F-8FA7-987AC532BD1E}']
    {class} function URLByResolvingBookmarkData(bookmarkData: NSData; options: NSURLBookmarkResolutionOptions; relativeToURL: NSURL; bookmarkDataIsStale: PBoolean; error: NSError): Pointer; cdecl;
    {class} function URLWithString(URLString: NSString): Pointer; cdecl; overload;
    {class} function URLWithString(URLString: NSString; relativeToURL: NSURL): Pointer; cdecl; overload;
    {class} function bookmarkDataWithContentsOfURL(bookmarkFileURL: NSURL; error: NSError): NSData; cdecl;
    {class} function fileURLWithPath(path: NSString): Pointer; cdecl; overload;
    {class} function fileURLWithPath(path: NSString; isDirectory: Boolean): Pointer; cdecl; overload;
    {class} function fileURLWithPathComponents(components: NSArray): Pointer; cdecl;
    {class} function resourceValuesForKeys(keys: NSArray; fromBookmarkData: NSData): NSDictionary; cdecl; overload;
    {class} function writeBookmarkData(bookmarkData: NSData; toURL: NSURL; options: NSURLBookmarkFileCreationOptions; error: NSError): Boolean; cdecl;
  end;
  NSURL = interface(NSObject)
    ['{17F81A07-11FF-4ABE-BFA3-F16C1CCF4C06}']
    function URLByAppendingPathComponent(pathComponent: NSString): NSURL; cdecl; overload;
    function URLByAppendingPathComponent(pathComponent: NSString; isDirectory: Boolean): NSURL; cdecl; overload;
    function URLByAppendingPathExtension(pathExtension: NSString): NSURL; cdecl;
    function URLByDeletingLastPathComponent: NSURL; cdecl;
    function URLByDeletingPathExtension: NSURL; cdecl;
    function URLByResolvingSymlinksInPath: NSURL; cdecl;
    function URLByStandardizingPath: NSURL; cdecl;
    function absoluteString: NSString; cdecl;
    function absoluteURL: NSURL; cdecl;
    function baseURL: NSURL; cdecl;
    function bookmarkDataWithOptions(options: NSURLBookmarkCreationOptions; includingResourceValuesForKeys: NSArray; relativeToURL: NSURL; error: NSError): NSData; cdecl;
    function checkResourceIsReachableAndReturnError(error: NSError): Boolean; cdecl;
    function filePathURL: NSURL; cdecl;
    function fileReferenceURL: NSURL; cdecl;
    function fragment: NSString; cdecl;
    function getResourceValue(value: Pointer; forKey: NSString; error: NSError): Boolean; cdecl;
    function host: NSString; cdecl;
    function initByResolvingBookmarkData(bookmarkData: NSData; options: NSURLBookmarkResolutionOptions; relativeToURL: NSURL; bookmarkDataIsStale: PBoolean; error: NSError): Pointer; cdecl;
    function initFileURLWithPath(path: NSString): Pointer; cdecl; overload;
    function initFileURLWithPath(path: NSString; isDirectory: Boolean): Pointer; cdecl; overload;
    function initWithScheme(scheme: NSString; host: NSString; path: NSString): Pointer; cdecl;
    function initWithString(URLString: NSString): Pointer; cdecl; overload;
    function initWithString(URLString: NSString; relativeToURL: NSURL): Pointer; cdecl; overload;
    function isFileReferenceURL: Boolean; cdecl;
    function isFileURL: Boolean; cdecl;
    function lastPathComponent: NSString; cdecl;
    function parameterString: NSString; cdecl;
    function password: NSString; cdecl;
    function path: NSString; cdecl;
    function pathComponents: NSArray; cdecl;
    function pathExtension: NSString; cdecl;
    function port: NSNumber; cdecl;
    function query: NSString; cdecl;
    function relativePath: NSString; cdecl;
    function relativeString: NSString; cdecl;
    function resourceSpecifier: NSString; cdecl;
    function resourceValuesForKeys(keys: NSArray; error: NSError): NSDictionary; cdecl; overload;
    function scheme: NSString; cdecl;
    function setResourceValue(value: Pointer; forKey: NSString; error: NSError): Boolean; cdecl;
    function setResourceValues(keyedValues: NSDictionary; error: NSError): Boolean; cdecl;
    function standardizedURL: NSURL; cdecl;
    function user: NSString; cdecl;
  end;
  TNSURL = class(TOCGenericImport<NSURLClass, NSURL>)  end;

  NSMethodSignatureClass = interface(NSObjectClass)
    ['{D86B4BB9-8BE3-43CF-BF8A-7BE43B86D2D5}']
    {class} function signatureWithObjCTypes(types: MarshaledAString): Pointer; cdecl;
  end;
  NSMethodSignature = interface(NSObject)
    ['{DA5CDD2A-212A-45F6-8863-BA60CA7CB855}']
    function frameLength: NSUInteger; cdecl;
    function getArgumentTypeAtIndex(idx: NSUInteger): MarshaledAString; cdecl;
    function isOneway: Boolean; cdecl;
    function methodReturnLength: NSUInteger; cdecl;
    function methodReturnType: MarshaledAString; cdecl;
    function numberOfArguments: NSUInteger; cdecl;
  end;
  TNSMethodSignature = class(TOCGenericImport<NSMethodSignatureClass, NSMethodSignature>)  end;

  NSURLAuthenticationChallengeClass = interface(NSObjectClass)
    ['{F30BA11A-EFD1-410C-AE68-476E71BA8361}']
  end;
  NSURLAuthenticationChallenge = interface(NSObject)
    ['{1E71FEDD-0AA2-48C7-9383-6F011D2FC4A6}']
    function error: NSError; cdecl;
    function failureResponse: NSURLResponse; cdecl;
    function initWithAuthenticationChallenge(challenge: NSURLAuthenticationChallenge; sender: Pointer): Pointer; cdecl;
    function initWithProtectionSpace(space: NSURLProtectionSpace; proposedCredential: NSURLCredential; previousFailureCount: NSInteger; failureResponse: NSURLResponse; error: NSError; sender: Pointer): Pointer; cdecl;
    function previousFailureCount: NSInteger; cdecl;
    function proposedCredential: NSURLCredential; cdecl;
    function protectionSpace: NSURLProtectionSpace; cdecl;
    function sender: Pointer; cdecl;
  end;
  TNSURLAuthenticationChallenge = class(TOCGenericImport<NSURLAuthenticationChallengeClass, NSURLAuthenticationChallenge>)  end;

  NSStreamClass = interface(NSObjectClass)
    ['{67F62CBB-288A-483F-9757-ADE7C6DE6C37}']
  end;
  NSStream = interface(NSObject)
    ['{1FF54EEE-3422-465E-8FDF-8ACB63719DDB}']
    procedure close; cdecl;
    function delegate: Pointer; cdecl;
    procedure open; cdecl;
    function propertyForKey(key: NSString): Pointer; cdecl;
    procedure removeFromRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure scheduleInRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    function setProperty(property_: Pointer; forKey: NSString): Boolean; cdecl;
    function streamError: NSError; cdecl;
    function streamStatus: NSStreamStatus; cdecl;
  end;
  TNSStream = class(TOCGenericImport<NSStreamClass, NSStream>)  end;

  NSSortDescriptorClass = interface(NSObjectClass)
    ['{F05469BE-3EB8-4C4F-8288-809A802549C4}']
    {class} function sortDescriptorWithKey(key: NSString; ascending: Boolean): Pointer; cdecl; overload;
    {class} function sortDescriptorWithKey(key: NSString; ascending: Boolean; selector: SEL): Pointer; cdecl; overload;
  end;
  NSSortDescriptor = interface(NSObject)
    ['{F38A315C-02F2-4684-B892-1591E48C70D8}']
    function ascending: Boolean; cdecl;
    function comparator: NSComparator; cdecl;
    function compareObject(object1: Pointer; toObject: Pointer): NSComparisonResult; cdecl;
    function initWithKey(key: NSString; ascending: Boolean): Pointer; cdecl; overload;
    function initWithKey(key: NSString; ascending: Boolean; selector: SEL): Pointer; cdecl; overload;
    function key: NSString; cdecl;
    function reversedSortDescriptor: Pointer; cdecl;
    function selector: SEL; cdecl;
  end;
  TNSSortDescriptor = class(TOCGenericImport<NSSortDescriptorClass, NSSortDescriptor>)  end;

  NSStringClass = interface(NSObjectClass)
    ['{00B82BBF-C972-47D7-BC7E-2B6AB042FF34}']
    {class} function availableStringEncodings: PNSStringEncoding; cdecl;
    {class} function defaultCStringEncoding: NSStringEncoding; cdecl;
    {class} function localizedNameOfStringEncoding(encoding: NSStringEncoding): Pointer; cdecl;
    {class} function localizedStringWithFormat(format: NSString): Pointer; cdecl;
    {class} function pathWithComponents(components: NSArray): Pointer; cdecl;
    {class} function stringWithCString(bytes: MarshaledAString): Pointer; cdecl; overload;
    {class} function stringWithCString(cString: MarshaledAString; encoding: NSStringEncoding): Pointer; cdecl; overload;
//    {class} function stringWithCString(bytes: MarshaledAString; length: NSUInteger): Pointer; cdecl; overload;
    {class} function stringWithCharacters(characters: MarshaledString; length: NSUInteger): Pointer; cdecl;
    {class} function stringWithContentsOfFile(path: NSString): Pointer; cdecl; overload;
    {class} function stringWithContentsOfFile(path: NSString; encoding: NSStringEncoding; error: NSError): Pointer; cdecl; overload;
    {class} function stringWithContentsOfFile(path: NSString; usedEncoding: PNSStringEncoding; error: NSError): Pointer; cdecl; overload;
    {class} function stringWithContentsOfURL(url: NSURL): Pointer; cdecl; overload;
    {class} function stringWithContentsOfURL(url: NSURL; encoding: NSStringEncoding; error: NSError): Pointer; cdecl; overload;
    {class} function stringWithContentsOfURL(url: NSURL; usedEncoding: PNSStringEncoding; error: NSError): Pointer; cdecl; overload;
    {class} function stringWithFormat(format: NSString): Pointer; cdecl;
    {class} function stringWithString(string_: NSString): Pointer; cdecl;
    {class} function stringWithUTF8String(nullTerminatedCString: MarshaledAString): Pointer; cdecl;
  end;
  NSString = interface(NSObject)
    ['{1DE2D395-9581-465A-8C45-C1E6DDC2F269}']
    function UTF8String: MarshaledAString; cdecl;
    function boolValue: Boolean; cdecl;
    function cString: MarshaledAString; cdecl;
    function cStringLength: NSUInteger; cdecl;
    function cStringUsingEncoding(encoding: NSStringEncoding): MarshaledAString; cdecl;
    function canBeConvertedToEncoding(encoding: NSStringEncoding): Boolean; cdecl;
    function capitalizedString: NSString; cdecl;
    function caseInsensitiveCompare(string_: NSString): NSComparisonResult; cdecl;
    function characterAtIndex(index: NSUInteger): unichar; cdecl;
    function commonPrefixWithString(aString: NSString; options: NSStringCompareOptions): NSString; cdecl;
    function compare(string_: NSString): NSComparisonResult; cdecl; overload;
    function compare(string_: NSString; options: NSStringCompareOptions): NSComparisonResult; cdecl; overload;
    function compare(string_: NSString; options: NSStringCompareOptions; range: NSRange): NSComparisonResult; cdecl; overload;
    function compare(string_: NSString; options: NSStringCompareOptions; range: NSRange; locale: Pointer): NSComparisonResult; cdecl; overload;
    function completePathIntoString(outputName: NSString; caseSensitive: Boolean; matchesIntoArray: NSArray; filterTypes: NSArray): NSUInteger; cdecl;
    function componentsSeparatedByCharactersInSet(separator: NSCharacterSet): NSArray; cdecl;
    function componentsSeparatedByString(separator: NSString): NSArray; cdecl;
    function dataUsingEncoding(encoding: NSStringEncoding): NSData; cdecl; overload;
    function dataUsingEncoding(encoding: NSStringEncoding; allowLossyConversion: Boolean): NSData; cdecl; overload;
    function decomposedStringWithCanonicalMapping: NSString; cdecl;
    function decomposedStringWithCompatibilityMapping: NSString; cdecl;
    function description: NSString; cdecl;
    function doubleValue: double; cdecl;
    function fastestEncoding: NSStringEncoding; cdecl;
    function fileSystemRepresentation: MarshaledAString; cdecl;
    function floatValue: Single; cdecl;
    function getBytes(buffer: Pointer; maxLength: NSUInteger; usedLength: NSUInteger; encoding: NSStringEncoding; options: NSStringEncodingConversionOptions; range: NSRange; remainingRange: PNSRange): Boolean; cdecl;
    procedure getCString(bytes: MarshaledAString); cdecl; overload;
    procedure getCString(bytes: MarshaledAString; maxLength: NSUInteger); cdecl; overload;
    function getCString(buffer: MarshaledAString; maxLength: NSUInteger; encoding: NSStringEncoding): Boolean; cdecl; overload;
    procedure getCString(bytes: MarshaledAString; maxLength: NSUInteger; range: NSRange; remainingRange: PNSRange); cdecl; overload;
    procedure getCharacters(buffer: MarshaledString); cdecl; overload;
    procedure getCharacters(buffer: MarshaledString; range: NSRange); cdecl; overload;
    function getFileSystemRepresentation(cname: MarshaledAString; maxLength: NSUInteger): Boolean; cdecl;
    function hasPrefix(aString: NSString): Boolean; cdecl;
    function hasSuffix(aString: NSString): Boolean; cdecl;
    function hash: NSUInteger; cdecl;
    function init: Pointer; cdecl;
    function initWithBytes(bytes: Pointer; length: NSUInteger; encoding: NSStringEncoding): Pointer; cdecl;
    function initWithBytesNoCopy(bytes: Pointer; length: NSUInteger; encoding: NSStringEncoding; freeWhenDone: Boolean): Pointer; cdecl;
    function initWithCString(bytes: MarshaledAString): Pointer; cdecl; overload;
    function initWithCString(nullTerminatedCString: MarshaledAString; encoding: NSStringEncoding): Pointer; cdecl; overload;
//    function initWithCString(bytes: MarshaledAString; length: NSUInteger): Pointer; cdecl; overload;
    function initWithCStringNoCopy(bytes: MarshaledAString; length: NSUInteger; freeWhenDone: Boolean): Pointer; cdecl;
    function initWithCharacters(characters: MarshaledString; length: NSUInteger): Pointer; cdecl;
    function initWithCharactersNoCopy(characters: MarshaledString; length: NSUInteger; freeWhenDone: Boolean): Pointer; cdecl;
    function initWithContentsOfFile(path: NSString): Pointer; cdecl; overload;
    function initWithContentsOfFile(path: NSString; encoding: NSStringEncoding; error: NSError): Pointer; cdecl; overload;
    function initWithContentsOfFile(path: NSString; usedEncoding: PNSStringEncoding; error: NSError): Pointer; cdecl; overload;
    function initWithContentsOfURL(url: NSURL): Pointer; cdecl; overload;
    function initWithContentsOfURL(url: NSURL; encoding: NSStringEncoding; error: NSError): Pointer; cdecl; overload;
    function initWithContentsOfURL(url: NSURL; usedEncoding: PNSStringEncoding; error: NSError): Pointer; cdecl; overload;
    function initWithData(data: NSData; encoding: NSStringEncoding): Pointer; cdecl;
    function initWithFormat(format: NSString): Pointer; cdecl; overload;
    function initWithFormat(format: NSString; locale: Pointer): Pointer; cdecl; overload;
    function initWithString(aString: NSString): Pointer; cdecl;
    function initWithUTF8String(nullTerminatedCString: MarshaledAString): Pointer; cdecl;
    function intValue: Integer; cdecl;
    function integerValue: NSInteger; cdecl;
    function isAbsolutePath: Boolean; cdecl;
    function isEqualToString(aString: NSString): Boolean; cdecl;
    function lastPathComponent: NSString; cdecl;
    function length: NSUInteger; cdecl;
    function lengthOfBytesUsingEncoding(enc: NSStringEncoding): NSUInteger; cdecl;
    function lineRangeForRange(range: NSRange): NSRange; cdecl;
    function linguisticTagsInRange(range: NSRange; scheme: NSString; options: NSLinguisticTaggerOptions; orthography: NSOrthography; tokenRanges: NSArray): NSArray; cdecl;
    function localizedCaseInsensitiveCompare(string_: NSString): NSComparisonResult; cdecl;
    function localizedCompare(string_: NSString): NSComparisonResult; cdecl;
    function localizedStandardCompare(string_: NSString): NSComparisonResult; cdecl;
    function longLongValue: Int64; cdecl;
    function lossyCString: MarshaledAString; cdecl;
    function lowercaseString: NSString; cdecl;
    function maximumLengthOfBytesUsingEncoding(enc: NSStringEncoding): NSUInteger; cdecl;
    function paragraphRangeForRange(range: NSRange): NSRange; cdecl;
    function pathComponents: NSArray; cdecl;
    function pathExtension: NSString; cdecl;
    function precomposedStringWithCanonicalMapping: NSString; cdecl;
    function precomposedStringWithCompatibilityMapping: NSString; cdecl;
    function propertyList: Pointer; cdecl;
    function propertyListFromStringsFileFormat: NSDictionary; cdecl;
    function rangeOfCharacterFromSet(aSet: NSCharacterSet): NSRange; cdecl; overload;
    function rangeOfCharacterFromSet(aSet: NSCharacterSet; options: NSStringCompareOptions): NSRange; cdecl; overload;
    function rangeOfCharacterFromSet(aSet: NSCharacterSet; options: NSStringCompareOptions; range: NSRange): NSRange; cdecl; overload;
    function rangeOfComposedCharacterSequenceAtIndex(index: NSUInteger): NSRange; cdecl;
    function rangeOfComposedCharacterSequencesForRange(range: NSRange): NSRange; cdecl;
    function rangeOfString(aString: NSString): NSRange; cdecl; overload;
    function rangeOfString(aString: NSString; options: NSStringCompareOptions): NSRange; cdecl; overload;
    function rangeOfString(aString: NSString; options: NSStringCompareOptions; range: NSRange): NSRange; cdecl; overload;
    function rangeOfString(aString: NSString; options: NSStringCompareOptions; range: NSRange; locale: NSLocale): NSRange; cdecl; overload;
    function smallestEncoding: NSStringEncoding; cdecl;
    function stringByAbbreviatingWithTildeInPath: NSString; cdecl;
    function stringByAddingPercentEscapesUsingEncoding(enc: NSStringEncoding): NSString; cdecl;
    function stringByAppendingFormat(format: NSString): NSString; cdecl;
    function stringByAppendingPathComponent(str: NSString): NSString; cdecl;
    function stringByAppendingPathExtension(str: NSString): NSString; cdecl;
    function stringByAppendingString(aString: NSString): NSString; cdecl;
    function stringByDeletingLastPathComponent: NSString; cdecl;
    function stringByDeletingPathExtension: NSString; cdecl;
    function stringByExpandingTildeInPath: NSString; cdecl;
    function stringByFoldingWithOptions(options: NSStringCompareOptions; locale: NSLocale): NSString; cdecl;
    function stringByPaddingToLength(newLength: NSUInteger; withString: NSString; startingAtIndex: NSUInteger): NSString; cdecl;
    function stringByReplacingCharactersInRange(range: NSRange; withString: NSString): NSString; cdecl;
    function stringByReplacingOccurrencesOfString(target: NSString; withString: NSString): NSString; cdecl; overload;
    function stringByReplacingOccurrencesOfString(target: NSString; withString: NSString; options: NSStringCompareOptions; range: NSRange): NSString; cdecl; overload;
    function stringByReplacingPercentEscapesUsingEncoding(enc: NSStringEncoding): NSString; cdecl;
    function stringByResolvingSymlinksInPath: NSString; cdecl;
    function stringByStandardizingPath: NSString; cdecl;
    function stringByTrimmingCharactersInSet(set_: NSCharacterSet): NSString; cdecl;
    function stringsByAppendingPaths(paths: NSArray): NSArray; cdecl;
    function substringFromIndex(from: NSUInteger): NSString; cdecl;
    function substringToIndex(to_: NSUInteger): NSString; cdecl;
    function substringWithRange(range: NSRange): NSString; cdecl;
    function uppercaseString: NSString; cdecl;
    function uppercaseStringWithLocale(locale: Pointer): NSString; cdecl;
    function writeToFile(path: NSString; atomically: Boolean): Boolean; cdecl; overload;
    function writeToFile(path: NSString; atomically: Boolean; encoding: NSStringEncoding; error: NSError): Boolean; cdecl; overload;
    function writeToURL(url: NSURL; atomically: Boolean): Boolean; cdecl; overload;
    function writeToURL(url: NSURL; atomically: Boolean; encoding: NSStringEncoding; error: NSError): Boolean; cdecl; overload;
  end;
  TNSString = class(TOCGenericImport<NSStringClass, NSString>)  end;

  NSThreadClass = interface(NSObjectClass)
    ['{C46348C9-34B5-4DB7-8F0A-2ABCC245C63C}']
    {class} function callStackReturnAddresses: NSArray; cdecl;
    {class} function callStackSymbols: NSArray; cdecl;
    {class} function currentThread: Pointer; cdecl;
    {class} procedure detachNewThreadSelector(selector: SEL; toTarget: Pointer; withObject: Pointer); cdecl;
    {class} procedure exit; cdecl;
    {class} function isMainThread: Boolean; cdecl; overload;
    {class} function isMultiThreaded: Boolean; cdecl;
    {class} function mainThread: Pointer; cdecl;
    {class} function setThreadPriority(p: double): Boolean; cdecl; overload;
    {class} procedure sleepForTimeInterval(ti: NSTimeInterval); cdecl;
    {class} procedure sleepUntilDate(date: NSDate); cdecl;
    {class} function threadPriority: double; cdecl; overload;
  end;
  NSThread = interface(NSObject)
    ['{221D82A7-7E85-4BEE-99DD-E6E1817F2D43}']
    procedure cancel; cdecl;
    function init: Pointer; cdecl;
    function isCancelled: Boolean; cdecl;
    function isExecuting: Boolean; cdecl;
    function isFinished: Boolean; cdecl;
    function isMainThread: Boolean; cdecl; overload;
    procedure main; cdecl;
    function name: NSString; cdecl;
    procedure setName(n: NSString); cdecl;
    procedure setStackSize(s: NSUInteger); cdecl;
    procedure setThreadPriority(p: double); cdecl; overload;
    function stackSize: NSUInteger; cdecl;
    procedure start; cdecl;
    function threadDictionary: NSMutableDictionary; cdecl;
    function threadPriority: double; cdecl; overload;
  end;
  TNSThread = class(TOCGenericImport<NSThreadClass, NSThread>)  end;

  NSTextCheckingResultClass = interface(NSObjectClass)
    ['{8ECAB4BC-2421-47F4-B3D5-5E050A34E3DB}']
    {class} function addressCheckingResultWithRange(range: NSRange; components: NSDictionary): Pointer; cdecl;
    {class} function correctionCheckingResultWithRange(range: NSRange; replacementString: NSString): Pointer; cdecl;
    {class} function dashCheckingResultWithRange(range: NSRange; replacementString: NSString): Pointer; cdecl;
    {class} function dateCheckingResultWithRange(range: NSRange; date: NSDate): Pointer; cdecl; overload;
    {class} function dateCheckingResultWithRange(range: NSRange; date: NSDate; timeZone: NSTimeZone; duration: NSTimeInterval): Pointer; cdecl; overload;
    {class} function grammarCheckingResultWithRange(range: NSRange; details: NSArray): Pointer; cdecl;
    {class} function linkCheckingResultWithRange(range: NSRange; URL: NSURL): Pointer; cdecl;
    {class} function orthographyCheckingResultWithRange(range: NSRange; orthography: NSOrthography): Pointer; cdecl;
    {class} function phoneNumberCheckingResultWithRange(range: NSRange; phoneNumber: NSString): Pointer; cdecl;
    {class} function quoteCheckingResultWithRange(range: NSRange; replacementString: NSString): Pointer; cdecl;
    {class} function regularExpressionCheckingResultWithRanges(ranges: PNSRange; count: NSUInteger; regularExpression: NSRegularExpression): Pointer; cdecl;
    {class} function replacementCheckingResultWithRange(range: NSRange; replacementString: NSString): Pointer; cdecl;
    {class} function spellCheckingResultWithRange(range: NSRange): Pointer; cdecl;
    {class} function transitInformationCheckingResultWithRange(range: NSRange; components: NSDictionary): Pointer; cdecl;
  end;
  NSTextCheckingResult = interface(NSObject)
    ['{446F0F8C-4EA7-4DB1-9FCF-FB1D12594CAA}']
    function URL: NSURL; cdecl;
    function addressComponents: NSDictionary; cdecl;
    function components: NSDictionary; cdecl;
    function date: NSDate; cdecl;
    function duration: NSTimeInterval; cdecl;
    function grammarDetails: NSArray; cdecl;
    function numberOfRanges: NSUInteger; cdecl;
    function orthography: NSOrthography; cdecl;
    function phoneNumber: NSString; cdecl;
    function range: NSRange; cdecl;
    function rangeAtIndex(idx: NSUInteger): NSRange; cdecl;
    function regularExpression: NSRegularExpression; cdecl;
    function replacementString: NSString; cdecl;
    function resultByAdjustingRangesWithOffset(offset: NSInteger): NSTextCheckingResult; cdecl;
    function resultType: NSTextCheckingType; cdecl;
    function timeZone: NSTimeZone; cdecl;
  end;
  TNSTextCheckingResult = class(TOCGenericImport<NSTextCheckingResultClass, NSTextCheckingResult>)  end;

  NSMetadataQueryResultGroupClass = interface(NSObjectClass)
    ['{4515A289-FF4F-45C9-A778-70F9F9BDA0B7}']
  end;
  NSMetadataQueryResultGroup = interface(NSObject)
    ['{6C4EEEF6-84DB-415B-A46E-D3584A5852AC}']
    function attribute: NSString; cdecl;
    function resultAtIndex(idx: NSUInteger): Pointer; cdecl;
    function resultCount: NSUInteger; cdecl;
    function results: NSArray; cdecl;
    function subgroups: NSArray; cdecl;
    function value: Pointer; cdecl;
  end;
  TNSMetadataQueryResultGroup = class(TOCGenericImport<NSMetadataQueryResultGroupClass, NSMetadataQueryResultGroup>)  end;

  NSLinguisticTaggerClass = interface(NSObjectClass)
    ['{7EA24D86-2C1B-4EBB-B568-0B8C0494487F}']
    {class} function availableTagSchemesForLanguage(language: NSString): NSArray; cdecl;
  end;
  NSLinguisticTagger = interface(NSObject)
    ['{26A1545C-D71B-436F-9B39-219FD87383D1}']
    function initWithTagSchemes(tagSchemes: NSArray; options: NSUInteger): Pointer; cdecl;
    function orthographyAtIndex(charIndex: NSUInteger; effectiveRange: PNSRange): NSOrthography; cdecl;
    function possibleTagsAtIndex(charIndex: NSUInteger; scheme: NSString; tokenRange: PNSRange; sentenceRange: PNSRange; scores: NSArray): NSArray; cdecl;
    function sentenceRangeForRange(range: NSRange): NSRange; cdecl;
    procedure setOrthography(orthography: NSOrthography; range: NSRange); cdecl;
    procedure setString(string_: NSString); cdecl;
    procedure stringEditedInRange(newRange: NSRange; changeInLength: NSInteger); cdecl;
    function tagAtIndex(charIndex: NSUInteger; scheme: NSString; tokenRange: PNSRange; sentenceRange: PNSRange): NSString; cdecl;
    function tagSchemes: NSArray; cdecl;
    function tagsInRange(range: NSRange; scheme: NSString; options: NSLinguisticTaggerOptions; tokenRanges: NSArray): NSArray; cdecl;
  end;
  TNSLinguisticTagger = class(TOCGenericImport<NSLinguisticTaggerClass, NSLinguisticTagger>)  end;

  NSLocaleClass = interface(NSObjectClass)
    ['{D4D49576-C188-4BE8-B484-EC99EA9E7DC0}']
    {class} function ISOCountryCodes: NSArray; cdecl;
    {class} function ISOCurrencyCodes: NSArray; cdecl;
    {class} function ISOLanguageCodes: NSArray; cdecl;
    {class} function autoupdatingCurrentLocale: Pointer; cdecl;
    {class} function availableLocaleIdentifiers: NSArray; cdecl;
    {class} function canonicalLanguageIdentifierFromString(string_: NSString): NSString; cdecl;
    {class} function canonicalLocaleIdentifierFromString(string_: NSString): NSString; cdecl;
    {class} function characterDirectionForLanguage(isoLangCode: NSString): NSLocaleLanguageDirection; cdecl;
    {class} function commonISOCurrencyCodes: NSArray; cdecl;
    {class} function componentsFromLocaleIdentifier(string_: NSString): NSDictionary; cdecl;
    {class} function currentLocale: Pointer; cdecl;
    {class} function lineDirectionForLanguage(isoLangCode: NSString): NSLocaleLanguageDirection; cdecl;
    {class} function localeIdentifierFromComponents(dict: NSDictionary): NSString; cdecl;
    {class} function localeIdentifierFromWindowsLocaleCode(lcid: Longword): NSString; cdecl;
    {class} function preferredLanguages: NSArray; cdecl;
    {class} function systemLocale: Pointer; cdecl;
    {class} function windowsLocaleCodeFromLocaleIdentifier(localeIdentifier: NSString): Longword; cdecl;
  end;
  NSLocale = interface(NSObject)
    ['{FD343FD1-617B-4DAD-942B-469AD1F8C4A5}']
    function displayNameForKey(key: Pointer; value: Pointer): NSString; cdecl;
    function initWithLocaleIdentifier(string_: NSString): Pointer; cdecl;
    function localeIdentifier: NSString; cdecl;
    function objectForKey(key: Pointer): Pointer; cdecl;
  end;
  TNSLocale = class(TOCGenericImport<NSLocaleClass, NSLocale>)  end;

  NSURLConnectionClass = interface(NSObjectClass)
    ['{7021CED4-133B-4485-ABB1-F3A755EB3C75}']
    {class} function canHandleRequest(request: NSURLRequest): Boolean; cdecl;
    {class} function connectionWithRequest(request: NSURLRequest; delegate: Pointer): Pointer; cdecl;
    {class} function sendSynchronousRequest(request: NSURLRequest; returningResponse: NSURLResponse; error: NSError): NSData; cdecl;
  end;
  NSURLConnection = interface(NSObject)
    ['{545DDD3E-AC2D-4403-9115-3DFE321D78FB}']
    procedure cancel; cdecl;
    function initWithRequest(request: NSURLRequest; delegate: Pointer): Pointer; cdecl; overload;
    function initWithRequest(request: NSURLRequest; delegate: Pointer; startImmediately: Boolean): Pointer; cdecl; overload;
    procedure scheduleInRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure setDelegateQueue(queue: NSOperationQueue); cdecl;
    procedure start; cdecl;
    procedure unscheduleFromRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
  end;
  TNSURLConnection = class(TOCGenericImport<NSURLConnectionClass, NSURLConnection>)  end;

  NSJSONSerializationClass = interface(NSObjectClass)
    ['{6FCDBDE2-6AE0-409C-8860-56362811EAC1}']
    {class} function JSONObjectWithData(data: NSData; options: NSJSONReadingOptions; error: NSError): Pointer; cdecl;
    {class} function JSONObjectWithStream(stream: NSInputStream; options: NSJSONReadingOptions; error: NSError): Pointer; cdecl;
    {class} function dataWithJSONObject(obj: Pointer; options: NSJSONWritingOptions; error: NSError): NSData; cdecl;
    {class} function isValidJSONObject(obj: Pointer): Boolean; cdecl;
    {class} function writeJSONObject(obj: Pointer; toStream: NSOutputStream; options: NSJSONWritingOptions; error: NSError): NSInteger; cdecl;
  end;
  NSJSONSerialization = interface(NSObject)
    ['{7E4617A1-93F0-4FC4-84EE-C20079084FB0}']
  end;
  TNSJSONSerialization = class(TOCGenericImport<NSJSONSerializationClass, NSJSONSerialization>)  end;

  NSURLCredentialClass = interface(NSObjectClass)
    ['{4081992B-7792-4ED1-9A11-292B757E5987}']
    {class} function credentialForTrust(trust: SecTrustRef): Pointer; cdecl;
    {class} function credentialWithIdentity(identity: SecIdentityRef; certificates: NSArray; persistence: NSURLCredentialPersistence): Pointer; cdecl;
    {class} function credentialWithUser(user: NSString; password: NSString; persistence: NSURLCredentialPersistence): Pointer; cdecl;
  end;
  NSURLCredential = interface(NSObject)
    ['{64F6800A-3D46-4541-9AA8-956E11391E6A}']
    function certificates: NSArray; cdecl;
    function hasPassword: Boolean; cdecl;
    function identity: SecIdentityRef; cdecl;
    function initWithIdentity(identity: SecIdentityRef; certificates: NSArray; persistence: NSURLCredentialPersistence): Pointer; cdecl;
    function initWithTrust(trust: SecTrustRef): Pointer; cdecl;
    function initWithUser(user: NSString; password: NSString; persistence: NSURLCredentialPersistence): Pointer; cdecl;
    function password: NSString; cdecl;
    function persistence: NSURLCredentialPersistence; cdecl;
    function user: NSString; cdecl;
  end;
  TNSURLCredential = class(TOCGenericImport<NSURLCredentialClass, NSURLCredential>)  end;

  NSMetadataQueryClass = interface(NSObjectClass)
    ['{7F3DDA6C-BAD2-4510-A092-9ABEEB4FD008}']
  end;
  NSMetadataQuery = interface(NSObject)
    ['{2493279D-2907-437A-BDBF-BA97E714A57F}']
    function delegate: Pointer; cdecl;
    procedure disableUpdates; cdecl;
    procedure enableUpdates; cdecl;
    function groupedResults: NSArray; cdecl;
    function groupingAttributes: NSArray; cdecl;
    function indexOfResult(result: Pointer): NSUInteger; cdecl;
    function init: Pointer; cdecl;
    function isGathering: Boolean; cdecl;
    function isStarted: Boolean; cdecl;
    function isStopped: Boolean; cdecl;
    function notificationBatchingInterval: NSTimeInterval; cdecl;
    function predicate: NSPredicate; cdecl;
    function resultAtIndex(idx: NSUInteger): Pointer; cdecl;
    function resultCount: NSUInteger; cdecl;
    function results: NSArray; cdecl;
    function searchScopes: NSArray; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setGroupingAttributes(attrs: NSArray); cdecl;
    procedure setNotificationBatchingInterval(ti: NSTimeInterval); cdecl;
    procedure setPredicate(predicate: NSPredicate); cdecl;
    procedure setSearchScopes(scopes: NSArray); cdecl;
    procedure setSortDescriptors(descriptors: NSArray); cdecl;
    procedure setValueListAttributes(attrs: NSArray); cdecl;
    function sortDescriptors: NSArray; cdecl;
    function startQuery: Boolean; cdecl;
    procedure stopQuery; cdecl;
    function valueListAttributes: NSArray; cdecl;
    function valueLists: NSDictionary; cdecl;
    function valueOfAttribute(attrName: NSString; forResultAtIndex: NSUInteger): Pointer; cdecl;
  end;
  TNSMetadataQuery = class(TOCGenericImport<NSMetadataQueryClass, NSMetadataQuery>)  end;

  NSMetadataQueryAttributeValueTupleClass = interface(NSObjectClass)
    ['{AE9DB44E-7A11-4C17-BBE1-1FE5B2688C1F}']
  end;
  NSMetadataQueryAttributeValueTuple = interface(NSObject)
    ['{9710F657-4605-47E6-AEDB-84F37C109F57}']
    function attribute: NSString; cdecl;
    function count: NSUInteger; cdecl;
    function value: Pointer; cdecl;
  end;
  TNSMetadataQueryAttributeValueTuple = class(TOCGenericImport<NSMetadataQueryAttributeValueTupleClass, NSMetadataQueryAttributeValueTuple>)  end;

  NSMetadataItemClass = interface(NSObjectClass)
    ['{51A55335-B649-4249-9678-27BBCEEFDCED}']
  end;
  NSMetadataItem = interface(NSObject)
    ['{6B077406-E1DC-4FFC-8400-2C2992B4F0C3}']
    function attributes: NSArray; cdecl;
    function valueForAttribute(key: NSString): Pointer; cdecl;
    function valuesForAttributes(keys: NSArray): NSDictionary; cdecl;
  end;
  TNSMetadataItem = class(TOCGenericImport<NSMetadataItemClass, NSMetadataItem>)  end;

  NSLockClass = interface(NSObjectClass)
    ['{DD30A910-42FA-455D-ADA8-576655E0E799}']
  end;
  NSLock = interface(NSObject)
    ['{15DCD242-9633-4902-9E6E-7B2948E75BFD}']
    function lockBeforeDate(limit: NSDate): Boolean; cdecl;
    function name: NSString; cdecl;
    procedure setName(n: NSString); cdecl;
    function tryLock: Boolean; cdecl;
  end;
  TNSLock = class(TOCGenericImport<NSLockClass, NSLock>)  end;

  NSURLCacheClass = interface(NSObjectClass)
    ['{4C7D8256-F0E0-44A5-983B-296A6708D3D0}']
    {class} procedure setSharedURLCache(cache: NSURLCache); cdecl;
    {class} function sharedURLCache: Pointer; cdecl;
  end;
  NSURLCache = interface(NSObject)
    ['{DD172655-5100-4BA0-B8D6-EB9D17601C66}']
    function cachedResponseForRequest(request: NSURLRequest): NSCachedURLResponse; cdecl;
    function currentDiskUsage: NSUInteger; cdecl;
    function currentMemoryUsage: NSUInteger; cdecl;
    function diskCapacity: NSUInteger; cdecl;
    function initWithMemoryCapacity(memoryCapacity: NSUInteger; diskCapacity: NSUInteger; diskPath: NSString): Pointer; cdecl;
    function memoryCapacity: NSUInteger; cdecl;
    procedure removeAllCachedResponses; cdecl;
    procedure removeCachedResponseForRequest(request: NSURLRequest); cdecl;
    procedure setDiskCapacity(diskCapacity: NSUInteger); cdecl;
    procedure setMemoryCapacity(memoryCapacity: NSUInteger); cdecl;
    procedure storeCachedResponse(cachedResponse: NSCachedURLResponse; forRequest: NSURLRequest); cdecl;
  end;
  TNSURLCache = class(TOCGenericImport<NSURLCacheClass, NSURLCache>)  end;

  NSSetClass = interface(NSObjectClass)
    ['{C04B64A4-BEB7-48D8-A453-A8D55B254147}']
    {class} function setWithArray(array_: NSArray): Pointer; cdecl;
    {class} function setWithObject(object_: Pointer): Pointer; cdecl;
    {class} function setWithObjects(firstObj: Pointer): Pointer; cdecl; overload;
    {class} function setWithObjects(objects: Pointer; count: NSUInteger): Pointer; cdecl; overload;
    {class} function setWithSet(set_: NSSet): Pointer; cdecl;
  end;
  NSSet = interface(NSObject)
    ['{1DDF31B4-3BAA-4547-942C-D31EC314F78A}']
    procedure addObserver(observer: NSObject; forKeyPath: NSString; options: NSKeyValueObservingOptions; context: Pointer); cdecl;
    function allObjects: NSArray; cdecl;
    function anyObject: Pointer; cdecl;
    function containsObject(anObject: Pointer): Boolean; cdecl;
    function count: NSUInteger; cdecl;
    function description: NSString; cdecl;
    function descriptionWithLocale(locale: Pointer): NSString; cdecl;
    function filteredSetUsingPredicate(predicate: NSPredicate): NSSet; cdecl;
    function initWithArray(array_: NSArray): Pointer; cdecl;
    function initWithObjects(firstObj: Pointer): Pointer; cdecl; overload;
    function initWithObjects(objects: Pointer; count: NSUInteger): Pointer; cdecl; overload;
    function initWithSet(set_: NSSet): Pointer; cdecl; overload;
    function initWithSet(set_: NSSet; copyItems: Boolean): Pointer; cdecl; overload;
    function intersectsSet(otherSet: NSSet): Boolean; cdecl;
    function isEqualToSet(otherSet: NSSet): Boolean; cdecl;
    function isSubsetOfSet(otherSet: NSSet): Boolean; cdecl;
    procedure makeObjectsPerformSelector(aSelector: SEL); cdecl; overload;
    procedure makeObjectsPerformSelector(aSelector: SEL; withObject: Pointer); cdecl; overload;
    function member(object_: Pointer): Pointer; cdecl;
    function objectEnumerator: NSEnumerator; cdecl;
    procedure removeObserver(observer: NSObject; forKeyPath: NSString); cdecl; overload;
    procedure removeObserver(observer: NSObject; forKeyPath: NSString; context: Pointer); cdecl; overload;
    function setByAddingObject(anObject: Pointer): NSSet; cdecl;
    function setByAddingObjectsFromArray(other: NSArray): NSSet; cdecl;
    function setByAddingObjectsFromSet(other: NSSet): NSSet; cdecl;
    procedure setValue(value: Pointer; forKey: NSString); cdecl;
    function sortedArrayUsingDescriptors(sortDescriptors: NSArray): NSArray; cdecl;
    function valueForKey(key: NSString): Pointer; cdecl;
  end;
  TNSSet = class(TOCGenericImport<NSSetClass, NSSet>)  end;

  NSPipeClass = interface(NSObjectClass)
    ['{3B325647-ED51-4326-8784-69DE588E25AB}']
    {class} function pipe: Pointer; cdecl;
  end;
  NSPipe = interface(NSObject)
    ['{957A5978-0E43-40F0-B5FD-010484870568}']
    function fileHandleForReading: NSFileHandle; cdecl;
    function fileHandleForWriting: NSFileHandle; cdecl;
    function init: Pointer; cdecl;
  end;
  TNSPipe = class(TOCGenericImport<NSPipeClass, NSPipe>)  end;

  NSPortClass = interface(NSObjectClass)
    ['{01EEB6A6-3661-4ABF-885C-0C07DCDDEA75}']
    {class} function port: Pointer; cdecl;
  end;
  NSPort = interface(NSObject)
    ['{114492E3-1289-4897-9932-21C5E4825899}']
    function delegate: Pointer; cdecl;
    procedure invalidate; cdecl;
    function isValid: Boolean; cdecl;
    procedure removeFromRunLoop(runLoop: NSRunLoop; forMode: NSString); cdecl;
    function reservedSpaceLength: NSUInteger; cdecl;
    procedure scheduleInRunLoop(runLoop: NSRunLoop; forMode: NSString); cdecl;
    function sendBeforeDate(limitDate: NSDate; components: NSMutableArray; from: NSPort; reserved: NSUInteger): Boolean; cdecl; overload;
    function sendBeforeDate(limitDate: NSDate; msgid: NSUInteger; components: NSMutableArray; from: NSPort; reserved: NSUInteger): Boolean; cdecl; overload;
    procedure setDelegate(anObject: Pointer); cdecl;
  end;
  TNSPort = class(TOCGenericImport<NSPortClass, NSPort>)  end;

  NSRegularExpressionClass = interface(NSObjectClass)
    ['{A6FC9813-8148-44EF-A5CF-77248B0BC9B5}']
    {class} function escapedPatternForString(string_: NSString): NSString; cdecl;
    {class} function escapedTemplateForString(string_: NSString): NSString; cdecl;
    {class} function regularExpressionWithPattern(pattern: NSString; options: NSRegularExpressionOptions; error: NSError): Pointer; cdecl;
  end;
  NSRegularExpression = interface(NSObject)
    ['{E88DECD7-E8CB-454B-8CAF-C4235DBA815B}']
    function firstMatchInString(string_: NSString; options: NSMatchingOptions; range: NSRange): NSTextCheckingResult; cdecl;
    function initWithPattern(pattern: NSString; options: NSRegularExpressionOptions; error: NSError): Pointer; cdecl;
    function matchesInString(string_: NSString; options: NSMatchingOptions; range: NSRange): NSArray; cdecl;
    function numberOfCaptureGroups: NSUInteger; cdecl;
    function numberOfMatchesInString(string_: NSString; options: NSMatchingOptions; range: NSRange): NSUInteger; cdecl;
    function options: NSRegularExpressionOptions; cdecl;
    function pattern: NSString; cdecl;
    function rangeOfFirstMatchInString(string_: NSString; options: NSMatchingOptions; range: NSRange): NSRange; cdecl;
    function replaceMatchesInString(string_: NSMutableString; options: NSMatchingOptions; range: NSRange; withTemplate: NSString): NSUInteger; cdecl;
    function replacementStringForResult(result: NSTextCheckingResult; inString: NSString; offset: NSInteger; template: NSString): NSString; cdecl;
    function stringByReplacingMatchesInString(string_: NSString; options: NSMatchingOptions; range: NSRange; withTemplate: NSString): NSString; cdecl;
  end;
  TNSRegularExpression = class(TOCGenericImport<NSRegularExpressionClass, NSRegularExpression>)  end;

  NSOrderedSetClass = interface(NSObjectClass)
    ['{066987D3-4AB4-4FC4-BFE8-529D9011E7D9}']
    {class} function orderedSet: Pointer; cdecl;
    {class} function orderedSetWithArray(array_: NSArray): Pointer; cdecl; overload;
    {class} function orderedSetWithArray(array_: NSArray; range: NSRange; copyItems: Boolean): Pointer; cdecl; overload;
    {class} function orderedSetWithObject(object_: Pointer): Pointer; cdecl;
    {class} function orderedSetWithObjects(firstObj: Pointer): Pointer; cdecl; overload;
    {class} function orderedSetWithObjects(objects: Pointer; count: NSUInteger): Pointer; cdecl; overload;
    {class} function orderedSetWithOrderedSet(set_: NSOrderedSet): Pointer; cdecl; overload;
    {class} function orderedSetWithOrderedSet(set_: NSOrderedSet; range: NSRange; copyItems: Boolean): Pointer; cdecl; overload;
    {class} function orderedSetWithSet(set_: NSSet): Pointer; cdecl; overload;
    {class} function orderedSetWithSet(set_: NSSet; copyItems: Boolean): Pointer; cdecl; overload;
  end;
  NSOrderedSet = interface(NSObject)
    ['{638A917E-F246-4097-81E0-76A32B925630}']
    procedure addObserver(observer: NSObject; forKeyPath: NSString; options: NSKeyValueObservingOptions; context: Pointer); cdecl;
    function containsObject(object_: Pointer): Boolean; cdecl;
    function count: NSUInteger; cdecl;
    function description: NSString; cdecl;
    function descriptionWithLocale(locale: Pointer): NSString; cdecl; overload;
    function descriptionWithLocale(locale: Pointer; indent: NSUInteger): NSString; cdecl; overload;
    function firstObject: Pointer; cdecl;
    procedure getObjects(objects: Pointer; range: NSRange); cdecl;
    function indexOfObject(object_: Pointer): NSUInteger; cdecl; overload;
    function initWithArray(array_: NSArray): Pointer; cdecl; overload;
    function initWithArray(set_: NSArray; copyItems: Boolean): Pointer; cdecl; overload;
    function initWithArray(set_: NSArray; range: NSRange; copyItems: Boolean): Pointer; cdecl; overload;
    function initWithObject(object_: Pointer): Pointer; cdecl;
    function initWithObjects(firstObj: Pointer): Pointer; cdecl; overload;
    function initWithObjects(objects: Pointer; count: NSUInteger): Pointer; cdecl; overload;
    function initWithOrderedSet(set_: NSOrderedSet): Pointer; cdecl; overload;
    function initWithOrderedSet(set_: NSOrderedSet; copyItems: Boolean): Pointer; cdecl; overload;
    function initWithOrderedSet(set_: NSOrderedSet; range: NSRange; copyItems: Boolean): Pointer; cdecl; overload;
    function initWithSet(set_: NSSet): Pointer; cdecl; overload;
    function initWithSet(set_: NSSet; copyItems: Boolean): Pointer; cdecl; overload;
    function intersectsOrderedSet(other: NSOrderedSet): Boolean; cdecl;
    function intersectsSet(set_: NSSet): Boolean; cdecl;
    function isEqualToOrderedSet(other: NSOrderedSet): Boolean; cdecl;
    function isSubsetOfOrderedSet(other: NSOrderedSet): Boolean; cdecl;
    function isSubsetOfSet(set_: NSSet): Boolean; cdecl;
    function lastObject: Pointer; cdecl;
    function objectAtIndex(idx: NSUInteger): Pointer; cdecl;
    function objectEnumerator: NSEnumerator; cdecl;
    function objectsAtIndexes(indexes: NSIndexSet): NSArray; cdecl;
    procedure removeObserver(observer: NSObject; forKeyPath: NSString); cdecl; overload;
    procedure removeObserver(observer: NSObject; forKeyPath: NSString; context: Pointer); cdecl; overload;
    function reverseObjectEnumerator: NSEnumerator; cdecl;
    function reversedOrderedSet: NSOrderedSet; cdecl;
    procedure setValue(value: Pointer; forKey: NSString); cdecl;
    function valueForKey(key: NSString): Pointer; cdecl;
  end;
  TNSOrderedSet = class(TOCGenericImport<NSOrderedSetClass, NSOrderedSet>)  end;

  NSOrthographyClass = interface(NSObjectClass)
    ['{C987D790-1892-4E3B-B400-7B62805EDC4E}']
    {class} function orthographyWithDominantScript(script: NSString; languageMap: NSDictionary): Pointer; cdecl;
  end;
  NSOrthography = interface(NSObject)
    ['{2F3F9873-D720-48EC-A10E-0B3033C89C02}']
    function allLanguages: NSArray; cdecl;
    function allScripts: NSArray; cdecl;
    function dominantLanguage: NSString; cdecl;
    function dominantLanguageForScript(script: NSString): NSString; cdecl;
    function dominantScript: NSString; cdecl;
    function initWithDominantScript(script: NSString; languageMap: NSDictionary): Pointer; cdecl;
    function languageMap: NSDictionary; cdecl;
    function languagesForScript(script: NSString): NSArray; cdecl;
  end;
  TNSOrthography = class(TOCGenericImport<NSOrthographyClass, NSOrthography>)  end;

  NSProxyClass = interface(IObjectiveCClass)
    ['{7890B5C0-0CFE-47F9-8FCB-F8BC95535138}']
    {class} function alloc: Pointer; cdecl;
    {class} function allocWithZone(zone: Pointer): Pointer; cdecl;
    {class} function respondsToSelector(aSelector: SEL): Boolean; cdecl;
  end;
  NSProxy = interface(IObjectiveCInstance)
    ['{28249DE4-888B-401C-85A6-D1FCAAFDD974}']
    procedure dealloc; cdecl;
    function debugDescription: NSString; cdecl;
    function description: NSString; cdecl;
    procedure finalize; cdecl;
    procedure forwardInvocation(invocation: NSInvocation); cdecl;
    function methodSignatureForSelector(sel: SEL): NSMethodSignature; cdecl;
  end;
  TNSProxy = class(TOCGenericImport<NSProxyClass, NSProxy>)  end;

  NSRecursiveLockClass = interface(NSObjectClass)
    ['{015F69BC-51D8-4D8F-897F-6AE7BD06A3C3}']
  end;
  NSRecursiveLock = interface(NSObject)
    ['{31E9C72A-530E-45CB-A5E6-A3954D14CEFB}']
    function lockBeforeDate(limit: NSDate): Boolean; cdecl;
    function name: NSString; cdecl;
    procedure setName(n: NSString); cdecl;
    function tryLock: Boolean; cdecl;
  end;
  TNSRecursiveLock = class(TOCGenericImport<NSRecursiveLockClass, NSRecursiveLock>)  end;

  NSPropertyListSerializationClass = interface(NSObjectClass)
    ['{9B73589B-7736-4B9D-A541-374CA196D74B}']
    {class} function dataFromPropertyList(plist: Pointer; format: NSPropertyListFormat; errorDescription: NSString): NSData; cdecl;
    {class} function dataWithPropertyList(plist: Pointer; format: NSPropertyListFormat; options: NSPropertyListWriteOptions; error: NSError): NSData; cdecl;
    {class} function propertyList(plist: Pointer; isValidForFormat: NSPropertyListFormat): Boolean; cdecl;
    {class} function propertyListFromData(data: NSData; mutabilityOption: NSPropertyListMutabilityOptions; format: PNSPropertyListFormat; errorDescription: NSString): Pointer; cdecl;
    {class} function propertyListWithData(data: NSData; options: NSPropertyListReadOptions; format: PNSPropertyListFormat; error: NSError): Pointer; cdecl;
    {class} function propertyListWithStream(stream: NSInputStream; options: NSPropertyListReadOptions; format: PNSPropertyListFormat; error: NSError): Pointer; cdecl;
    {class} function writePropertyList(plist: Pointer; toStream: NSOutputStream; format: NSPropertyListFormat; options: NSPropertyListWriteOptions; error: NSError): NSInteger; cdecl;
  end;
  NSPropertyListSerialization = interface(NSObject)
    ['{13CAB0EB-1565-4436-8E6C-D5BB3446C723}']
  end;
  TNSPropertyListSerialization = class(TOCGenericImport<NSPropertyListSerializationClass, NSPropertyListSerialization>)  end;

  NSPredicateClass = interface(NSObjectClass)
    ['{5EF9036E-3D70-44E6-AB6F-D1FDE278D09E}']
    {class} function predicateWithFormat(predicateFormat: NSString): Pointer; cdecl; overload;
    {class} function predicateWithFormat(predicateFormat: NSString; argumentArray: NSArray): Pointer; cdecl; overload;
    {class} function predicateWithValue(value: Boolean): Pointer; cdecl;
  end;
  NSPredicate = interface(NSObject)
    ['{FCC547FA-EA01-4E62-AF05-39B55B6018A6}']
    function evaluateWithObject(object_: Pointer): Boolean; cdecl; overload;
    function evaluateWithObject(object_: Pointer; substitutionVariables: NSDictionary): Boolean; cdecl; overload;
    function predicateFormat: NSString; cdecl;
    function predicateWithSubstitutionVariables(variables: NSDictionary): NSPredicate; cdecl;
  end;
  TNSPredicate = class(TOCGenericImport<NSPredicateClass, NSPredicate>)  end;

  NSProcessInfoClass = interface(NSObjectClass)
    ['{D96F16FF-BFB7-40ED-A24C-F1B3012EEBD0}']
    {class} function processInfo: Pointer; cdecl;
  end;
  NSProcessInfo = interface(NSObject)
    ['{76BE35B3-3880-4BDC-A996-346AE469289C}']
    function activeProcessorCount: NSUInteger; cdecl;
    function arguments: NSArray; cdecl;
    function automaticTerminationSupportEnabled: Boolean; cdecl;
    procedure disableAutomaticTermination(reason: NSString); cdecl;
    procedure disableSuddenTermination; cdecl;
    procedure enableAutomaticTermination(reason: NSString); cdecl;
    procedure enableSuddenTermination; cdecl;
    function environment: NSDictionary; cdecl;
    function globallyUniqueString: NSString; cdecl;
    function hostName: NSString; cdecl;
    function operatingSystem: NSUInteger; cdecl;
    function operatingSystemName: NSString; cdecl;
    function operatingSystemVersionString: NSString; cdecl;
    function physicalMemory: UInt64; cdecl;
    function processIdentifier: Integer; cdecl;
    function processName: NSString; cdecl;
    function processorCount: NSUInteger; cdecl;
    procedure setAutomaticTerminationSupportEnabled(flag: Boolean); cdecl;
    procedure setProcessName(newName: NSString); cdecl;
    function systemUptime: NSTimeInterval; cdecl;
  end;
  TNSProcessInfo = class(TOCGenericImport<NSProcessInfoClass, NSProcessInfo>)  end;

  NSOperationQueueClass = interface(NSObjectClass)
    ['{1C7F4DC1-28A5-4776-ADE9-E8448E7E3587}']
    {class} function currentQueue: Pointer; cdecl;
    {class} function mainQueue: Pointer; cdecl;
  end;
  NSOperationQueue = interface(NSObject)
    ['{F2F92F8B-D4BD-462E-961C-6FCD5C558AB0}']
    procedure addOperation(op: NSOperation); cdecl;
    procedure addOperations(ops: NSArray; waitUntilFinished: Boolean); cdecl;
    procedure cancelAllOperations; cdecl;
    function isSuspended: Boolean; cdecl;
    function maxConcurrentOperationCount: NSInteger; cdecl;
    function name: NSString; cdecl;
    function operationCount: NSUInteger; cdecl;
    function operations: NSArray; cdecl;
    procedure setMaxConcurrentOperationCount(cnt: NSInteger); cdecl;
    procedure setName(n: NSString); cdecl;
    procedure setSuspended(b: Boolean); cdecl;
    procedure waitUntilAllOperationsAreFinished; cdecl;
  end;
  TNSOperationQueue = class(TOCGenericImport<NSOperationQueueClass, NSOperationQueue>)  end;

  NSNotificationCenterClass = interface(NSObjectClass)
    ['{6B3FCEF9-6DC4-4677-9494-7DBFD4B5E73F}']
    {class} function defaultCenter: Pointer; cdecl;
  end;
  NSNotificationCenter = interface(NSObject)
    ['{51EA2C04-9CE2-481F-98E1-D456AE279AD7}']
    procedure postNotification(notification: NSNotification); cdecl;
    procedure removeObserver(observer: Pointer); cdecl; overload;
    procedure addObserver(notificationObserver: Pointer; selector: SEL; name: Pointer; &object: Pointer); cdecl;
    procedure postNotificationName(notificationName: Pointer; &object: Pointer); cdecl;
  end;
  TNSNotificationCenter = class(TOCGenericImport<NSNotificationCenterClass, NSNotificationCenter>)  end;

  NSNotificationQueueClass = interface(NSObjectClass)
    ['{291DCF57-9CB7-4F1C-8D52-11364A2D49AD}']
    {class} function defaultQueue: Pointer; cdecl;
  end;
  NSNotificationQueue = interface(NSObject)
    ['{D075C94F-F16B-4953-8790-4341DCF149C4}']
    procedure dequeueNotificationsMatching(notification: NSNotification; coalesceMask: NSUInteger); cdecl;
    procedure enqueueNotification(notification: NSNotification; postingStyle: NSPostingStyle); cdecl; overload;
    procedure enqueueNotification(notification: NSNotification; postingStyle: NSPostingStyle; coalesceMask: NSUInteger; forModes: NSArray); cdecl; overload;
    function initWithNotificationCenter(notificationCenter: NSNotificationCenter): Pointer; cdecl;
  end;
  TNSNotificationQueue = class(TOCGenericImport<NSNotificationQueueClass, NSNotificationQueue>)  end;

  NSNotificationClass = interface(NSObjectClass)
    ['{28331A7D-99D9-4C73-8DF9-8649EF42F675}']
  end;
  NSNotification = interface(NSObject)
    ['{B153D7B5-2F8B-49E4-9A2B-A4DDCF002BEC}']
    function name: NSString; cdecl;
    function userInfo: NSDictionary; cdecl;
  end;
  TNSNotification = class(TOCGenericImport<NSNotificationClass, NSNotification>)  end;

  NSNetServiceClass = interface(NSObjectClass)
    ['{73C87953-2B1B-4685-866B-8995C7994268}']
    {class} function dataFromTXTRecordDictionary(txtDictionary: NSDictionary): NSData; cdecl;
    {class} function dictionaryFromTXTRecordData(txtData: NSData): NSDictionary; cdecl;
  end;
  NSNetService = interface(NSObject)
    ['{A1B6027E-ECBC-4C0B-917F-50E09B385F5B}']
    function TXTRecordData: NSData; cdecl;
    function addresses: NSArray; cdecl;
    function delegate: Pointer; cdecl;
    function domain: NSString; cdecl;
    function getInputStream(inputStream: NSInputStream; outputStream: NSOutputStream): Boolean; cdecl;
    function hostName: NSString; cdecl;
    function name: NSString; cdecl;
    function port: NSInteger; cdecl;
    procedure publish; cdecl;
    procedure publishWithOptions(options: NSNetServiceOptions); cdecl;
    procedure removeFromRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure resolve; cdecl;
    procedure resolveWithTimeout(timeout: NSTimeInterval); cdecl;
    procedure scheduleInRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    function setTXTRecordData(recordData: NSData): Boolean; cdecl;
    procedure startMonitoring; cdecl;
    procedure stop; cdecl;
    procedure stopMonitoring; cdecl;
  end;
  TNSNetService = class(TOCGenericImport<NSNetServiceClass, NSNetService>)  end;

  NSNetServiceBrowserClass = interface(NSObjectClass)
    ['{6C15A4AF-6403-4B2C-9EC6-FCA90D5D0B2F}']
  end;
  NSNetServiceBrowser = interface(NSObject)
    ['{3F70EA13-4042-4A4B-834F-DD3B7173723E}']
    function delegate: Pointer; cdecl;
    function init: Pointer; cdecl;
    procedure removeFromRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure scheduleInRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure searchForBrowsableDomains; cdecl;
    procedure searchForRegistrationDomains; cdecl;
    procedure searchForServicesOfType(type_: NSString; inDomain: NSString); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure stop; cdecl;
  end;
  TNSNetServiceBrowser = class(TOCGenericImport<NSNetServiceBrowserClass, NSNetServiceBrowser>)  end;
(*  Use hand-coded NSObject instead of this.
  NSObjectClass = interface(IObjectiveCClass)
    ['{F9BFF4FF-EAB6-49D8-8577-A6933CA06436}']
    {class} function accessInstanceVariablesDirectly: Boolean; cdecl;
    {class} function alloc: Pointer; cdecl;
    {class} function allocWithZone(zone: Pointer): Pointer; cdecl;
    {class} function automaticallyNotifiesObserversForKey(key: NSString): Boolean; cdecl;
    {class} procedure cancelPreviousPerformRequestsWithTarget(aTarget: Pointer); cdecl; overload;
    {class} function classFallbacksForKeyedArchiver: NSArray; cdecl;
    {class} function conformsToProtocol(protocol: Pointer): Boolean; cdecl; overload;
    {class} function copyWithZone(zone: Pointer): Pointer; cdecl; overload;
    {class} function description: NSString; cdecl; overload;
    {class} procedure initialize; cdecl;
    {class} function instanceMethodForSelector(aSelector: SEL): IMP; cdecl;
    {class} function instanceMethodSignatureForSelector(aSelector: SEL): NSMethodSignature; cdecl;
    {class} function instancesRespondToSelector(aSelector: SEL): Boolean; cdecl;
    {class} function isSubclassOfClass(aClass: Pointer): Boolean; cdecl;
    {class} function keyPathsForValuesAffectingValueForKey(key: NSString): NSSet; cdecl;
    {class} procedure load; cdecl;
    {class} function mutableCopyWithZone(zone: Pointer): Pointer; cdecl; overload;
    {class} function new: Pointer; cdecl;
    {class} function resolveClassMethod(sel: SEL): Boolean; cdecl;
    {class} function resolveInstanceMethod(sel: SEL): Boolean; cdecl;
    {class} procedure setVersion(aVersion: NSInteger); cdecl;
    {class} function version: NSInteger; cdecl;
  end;
  NSObject = interface(IObjectiveCInstance)
    ['{E4D50F26-32F2-4093-BE8E-6D328FF21945}']
    procedure URLProtocol(protocol: NSURLProtocol; cachedResponseIsValid: NSCachedURLResponse); cdecl; overload;
    procedure URLProtocol(protocol: NSURLProtocol; didCancelAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl; overload;
    procedure URLProtocol(protocol: NSURLProtocol; didFailWithError: NSError); cdecl; overload;
    procedure URLProtocol(protocol: NSURLProtocol; didLoadData: NSData); cdecl; overload;
    procedure URLProtocol(protocol: NSURLProtocol; didReceiveAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl; overload;
    procedure URLProtocol(protocol: NSURLProtocol; didReceiveResponse: NSURLResponse; cacheStoragePolicy: NSURLCacheStoragePolicy); cdecl; overload;
    procedure URLProtocol(protocol: NSURLProtocol; wasRedirectedToRequest: NSURLRequest; redirectResponse: NSURLResponse); cdecl; overload;
    procedure URLProtocolDidFinishLoading(protocol: NSURLProtocol); cdecl;
    procedure addObserver(observer: NSObject; forKeyPath: NSString; options: NSKeyValueObservingOptions; context: Pointer); cdecl;
    procedure archiver(archiver: NSKeyedArchiver; didEncodeObject: Pointer); cdecl; overload;
    function archiver(archiver: NSKeyedArchiver; willEncodeObject: Pointer): Pointer; cdecl; overload;
    procedure archiver(archiver: NSKeyedArchiver; willReplaceObject: Pointer; withObject: Pointer); cdecl; overload;
    procedure archiverDidFinish(archiver: NSKeyedArchiver); cdecl;
    procedure archiverWillFinish(archiver: NSKeyedArchiver); cdecl;
    function attemptRecoveryFromError(error: NSError; optionIndex: NSUInteger): Boolean; cdecl; overload;
    procedure attemptRecoveryFromError(error: NSError; optionIndex: NSUInteger; delegate: Pointer; didRecoverSelector: SEL; contextInfo: Pointer); cdecl; overload;
    function autoContentAccessingProxy: Pointer; cdecl;
    function autorelease: Pointer; cdecl;
    function awakeAfterUsingCoder(aDecoder: NSCoder): Pointer; cdecl;
    function beginContentAccess: Boolean; cdecl;
    procedure cache(cache: NSCache; willEvictObject: Pointer); cdecl;
    procedure cancelAuthenticationChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
    function conformsToProtocol(aProtocol: Pointer): Boolean; cdecl; overload;
    function connection(connection: NSURLConnection; canAuthenticateAgainstProtectionSpace: NSURLProtectionSpace): Boolean; cdecl; overload;
    procedure connection(connection: NSURLConnection; didCancelAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl; overload;
    procedure connection(connection: NSURLConnection; didFailWithError: NSError); cdecl; overload;
    procedure connection(connection: NSURLConnection; didReceiveAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl; overload;
    procedure connection(connection: NSURLConnection; didReceiveData: NSData); cdecl; overload;
    procedure connection(connection: NSURLConnection; didReceiveResponse: NSURLResponse); cdecl; overload;
    procedure connection(connection: NSURLConnection; didSendBodyData: NSInteger; totalBytesWritten: NSInteger; totalBytesExpectedToWrite: NSInteger); cdecl; overload;
    procedure connection(connection: NSURLConnection; didWriteData: Int64; totalBytesWritten: Int64; expectedTotalBytes: Int64); cdecl; overload;
    function connection(connection: NSURLConnection; needNewBodyStream: NSURLRequest): NSInputStream; cdecl; overload;
    function connection(connection: NSURLConnection; willCacheResponse: NSCachedURLResponse): NSCachedURLResponse; cdecl; overload;
    function connection(connection: NSURLConnection; willSendRequest: NSURLRequest; redirectResponse: NSURLResponse): NSURLRequest; cdecl; overload;
    procedure connection(connection: NSURLConnection; willSendRequestForAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl; overload;
    procedure connectionDidFinishDownloading(connection: NSURLConnection; destinationURL: NSURL); cdecl;
    procedure connectionDidFinishLoading(connection: NSURLConnection); cdecl;
    procedure connectionDidResumeDownloading(connection: NSURLConnection; totalBytesWritten: Int64; expectedTotalBytes: Int64); cdecl;
    function connectionShouldUseCredentialStorage(connection: NSURLConnection): Boolean; cdecl;
    procedure continueWithoutCredentialForAuthenticationChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
    function copy: Pointer; cdecl;
    function copyWithZone(zone: Pointer): Pointer; cdecl; overload;
    function countByEnumeratingWithState(state: NSFastEnumerationState; objects: Pointer; count: NSUInteger): NSUInteger; cdecl;
    procedure dealloc; cdecl;
    function debugDescription: NSString; cdecl;
    function description: NSString; cdecl; overload;
    function dictionaryWithValuesForKeys(keys: NSArray): NSDictionary; cdecl;
    procedure didChange(changeKind: NSKeyValueChange; valuesAtIndexes: NSIndexSet; forKey: NSString); cdecl;
    procedure didChangeValueForKey(key: NSString); cdecl; overload;
    procedure didChangeValueForKey(key: NSString; withSetMutation: NSKeyValueSetMutationKind; usingObjects: NSSet); cdecl; overload;
    procedure discardContentIfPossible; cdecl;
    procedure doesNotRecognizeSelector(aSelector: SEL); cdecl;
    procedure encodeWithCoder(aCoder: NSCoder); cdecl;
    procedure endContentAccess; cdecl;
    function exceptionDuringOperation(operation: SEL; error: NSCalculationError; leftOperand: NSDecimalNumber; rightOperand: NSDecimalNumber): NSDecimalNumber; cdecl;
    function fileManager(fileManager: NSFileManager; shouldCopyItemAtPath: NSString; toPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldCopyItemAtURL: NSURL; toURL: NSURL): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldLinkItemAtPath: NSString; toPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldLinkItemAtURL: NSURL; toURL: NSURL): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldMoveItemAtPath: NSString; toPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldMoveItemAtURL: NSURL; toURL: NSURL): Boolean; cdecl; overload;
    function fileManager(fm: NSFileManager; shouldProceedAfterError: NSDictionary): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; copyingItemAtPath: NSString; toPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; copyingItemAtURL: NSURL; toURL: NSURL): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; linkingItemAtPath: NSString; toPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; linkingItemAtURL: NSURL; toURL: NSURL): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; movingItemAtPath: NSString; toPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; movingItemAtURL: NSURL; toURL: NSURL): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; removingItemAtPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldProceedAfterError: NSError; removingItemAtURL: NSURL): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldRemoveItemAtPath: NSString): Boolean; cdecl; overload;
    function fileManager(fileManager: NSFileManager; shouldRemoveItemAtURL: NSURL): Boolean; cdecl; overload;
    procedure fileManager(fm: NSFileManager; willProcessPath: NSString); cdecl; overload;
    procedure finalize; cdecl;
    procedure forwardInvocation(anInvocation: NSInvocation); cdecl;
    function forwardingTargetForSelector(aSelector: SEL): Pointer; cdecl;
    procedure handleMachMessage(msg: Pointer); cdecl;
    procedure handlePortMessage(message: NSPortMessage); cdecl;
    function hash: NSUInteger; cdecl;
    function init: Pointer; cdecl;
    function initWithCoder(aDecoder: NSCoder): Pointer; cdecl;
    function isContentDiscarded: Boolean; cdecl;
    function isEqual(object_: Pointer): Boolean; cdecl;
    function isKindOfClass(aClass: Pointer): Boolean; cdecl;
    function isMemberOfClass(aClass: Pointer): Boolean; cdecl;
    function isProxy: Boolean; cdecl;
    procedure lock; cdecl;
    function metadataQuery(query: NSMetadataQuery; replacementObjectForResultObject: NSMetadataItem): Pointer; cdecl; overload;
    function metadataQuery(query: NSMetadataQuery; replacementValueForAttribute: NSString; value: Pointer): Pointer; cdecl; overload;
    function methodForSelector(aSelector: SEL): IMP; cdecl;
    function methodSignatureForSelector(aSelector: SEL): NSMethodSignature; cdecl;
    function mutableArrayValueForKey(key: NSString): NSMutableArray; cdecl;
    function mutableArrayValueForKeyPath(keyPath: NSString): NSMutableArray; cdecl;
    function mutableCopy: Pointer; cdecl;
    function mutableCopyWithZone(zone: Pointer): Pointer; cdecl; overload;
    function mutableOrderedSetValueForKey(key: NSString): NSMutableOrderedSet; cdecl;
    function mutableOrderedSetValueForKeyPath(keyPath: NSString): NSMutableOrderedSet; cdecl;
    function mutableSetValueForKey(key: NSString): NSMutableSet; cdecl;
    function mutableSetValueForKeyPath(keyPath: NSString): NSMutableSet; cdecl;
    procedure netService(sender: NSNetService; didNotPublish: NSDictionary); cdecl; overload;
    procedure netService(sender: NSNetService; didNotResolve: NSDictionary); cdecl; overload;
    procedure netService(sender: NSNetService; didUpdateTXTRecordData: NSData); cdecl; overload;
    procedure netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser; didFindDomain: NSString; moreComing: Boolean); cdecl; overload;
    procedure netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser; didFindService: NSNetService; moreComing: Boolean); cdecl; overload;
    procedure netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser; didNotSearch: NSDictionary); cdecl; overload;
    procedure netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser; didRemoveDomain: NSString; moreComing: Boolean); cdecl; overload;
    procedure netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser; didRemoveService: NSNetService; moreComing: Boolean); cdecl; overload;
    procedure netServiceBrowserDidStopSearch(aNetServiceBrowser: NSNetServiceBrowser); cdecl;
    procedure netServiceBrowserWillSearch(aNetServiceBrowser: NSNetServiceBrowser); cdecl;
    procedure netServiceDidPublish(sender: NSNetService); cdecl;
    procedure netServiceDidResolveAddress(sender: NSNetService); cdecl;
    procedure netServiceDidStop(sender: NSNetService); cdecl;
    procedure netServiceWillPublish(sender: NSNetService); cdecl;
    procedure netServiceWillResolve(sender: NSNetService); cdecl;
    function observationInfo: Pointer; cdecl;
    procedure observeValueForKeyPath(keyPath: NSString; ofObject: Pointer; change: NSDictionary; context: Pointer); cdecl;
    procedure parser(parser: NSXMLParser; didEndElement: NSString; namespaceURI: NSString; qualifiedName: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; didEndMappingPrefix: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; didStartElement: NSString; namespaceURI: NSString; qualifiedName: NSString; attributes: NSDictionary); cdecl; overload;
    procedure parser(parser: NSXMLParser; didStartMappingPrefix: NSString; toURI: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundCDATA: NSData); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundCharacters: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundComment: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundElementDeclarationWithName: NSString; model: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundExternalEntityDeclarationWithName: NSString; publicID: NSString; systemID: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundIgnorableWhitespace: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundInternalEntityDeclarationWithName: NSString; value: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundNotationDeclarationWithName: NSString; publicID: NSString; systemID: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundProcessingInstructionWithTarget: NSString; data: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; foundUnparsedEntityDeclarationWithName: NSString; publicID: NSString; systemID: NSString; notationName: NSString); cdecl; overload;
    procedure parser(parser: NSXMLParser; parseErrorOccurred: NSError); cdecl; overload;
    function parser(parser: NSXMLParser; resolveExternalEntityName: NSString; systemID: NSString): NSData; cdecl; overload;
    procedure parser(parser: NSXMLParser; validationErrorOccurred: NSError); cdecl; overload;
    procedure parserDidEndDocument(parser: NSXMLParser); cdecl;
    procedure parserDidStartDocument(parser: NSXMLParser); cdecl;
    procedure performDefaultHandlingForAuthenticationChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
    function performSelector(aSelector: SEL): Pointer; cdecl; overload;
    procedure performSelector(aSelector: SEL; onThread: NSThread; withObject: Pointer; waitUntilDone: Boolean); cdecl; overload;
    procedure performSelector(aSelector: SEL; onThread: NSThread; withObject: Pointer; waitUntilDone: Boolean; modes: NSArray); cdecl; overload;
    function performSelector(aSelector: SEL; withObject: Pointer): Pointer; cdecl; overload;
    procedure performSelector(aSelector: SEL; withObject: Pointer; afterDelay: NSTimeInterval); cdecl; overload;
    procedure performSelector(aSelector: SEL; withObject: Pointer; afterDelay: NSTimeInterval; inModes: NSArray); cdecl; overload;
    procedure performSelectorInBackground(aSelector: SEL; withObject: Pointer); cdecl;
    procedure performSelectorOnMainThread(aSelector: SEL; withObject: Pointer; waitUntilDone: Boolean); cdecl; overload;
    procedure performSelectorOnMainThread(aSelector: SEL; withObject: Pointer; waitUntilDone: Boolean; modes: NSArray); cdecl; overload;
    procedure presentedItemDidChange; cdecl;
    procedure presentedItemDidGainVersion(version: NSFileVersion); cdecl;
    procedure presentedItemDidLoseVersion(version: NSFileVersion); cdecl;
    procedure presentedItemDidMoveToURL(newURL: NSURL); cdecl;
    procedure presentedItemDidResolveConflictVersion(version: NSFileVersion); cdecl;
    function presentedItemOperationQueue: NSOperationQueue; cdecl;
    function presentedItemURL: NSURL; cdecl;
    procedure presentedSubitemAtURL(url: NSURL; didGainVersion: NSFileVersion); cdecl; overload;
    procedure presentedSubitemAtURL(url: NSURL; didLoseVersion: NSFileVersion); cdecl; overload;
    procedure presentedSubitemAtURL(oldURL: NSURL; didMoveToURL: NSURL); cdecl; overload;
    procedure presentedSubitemAtURL(url: NSURL; didResolveConflictVersion: NSFileVersion); cdecl; overload;
    procedure presentedSubitemDidAppearAtURL(url: NSURL); cdecl;
    procedure presentedSubitemDidChangeAtURL(url: NSURL); cdecl;
    procedure rejectProtectionSpaceAndContinueWithChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
    procedure release; cdecl;
    procedure removeObserver(observer: NSObject; forKeyPath: NSString); cdecl; overload;
    procedure removeObserver(observer: NSObject; forKeyPath: NSString; context: Pointer); cdecl; overload;
    function replacementObjectForCoder(aCoder: NSCoder): Pointer; cdecl;
    function replacementObjectForKeyedArchiver(archiver: NSKeyedArchiver): Pointer; cdecl;
    function respondsToSelector(aSelector: SEL): Boolean; cdecl;
    function retain: Pointer; cdecl;
    function retainCount: NSUInteger; cdecl;
    function roundingMode: NSRoundingMode; cdecl;
    function scale: Smallint; cdecl;
    function self: Pointer; cdecl;
    procedure setNilValueForKey(key: NSString); cdecl;
    procedure setObservationInfo(observationInfo: Pointer); cdecl;
    procedure setValue(value: Pointer; forKey: NSString); cdecl; overload;
    procedure setValue(value: Pointer; forKeyPath: NSString); cdecl; overload;
    procedure setValue(value: Pointer; forUndefinedKey: NSString); cdecl; overload;
    procedure setValuesForKeysWithDictionary(keyedValues: NSDictionary); cdecl;
    procedure stream(aStream: NSStream; handleEvent: NSStreamEvent); cdecl;
    function unarchiver(unarchiver: NSKeyedUnarchiver; didDecodeObject: Pointer): Pointer; cdecl; overload;
    procedure unarchiver(unarchiver: NSKeyedUnarchiver; willReplaceObject: Pointer; withObject: Pointer); cdecl; overload;
    procedure unarchiverDidFinish(unarchiver: NSKeyedUnarchiver); cdecl;
    procedure unarchiverWillFinish(unarchiver: NSKeyedUnarchiver); cdecl;
    procedure unlock; cdecl;
    procedure useCredential(credential: NSURLCredential; forAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl;
    function validateValue(ioValue: Pointer; forKey: NSString; error: NSError): Boolean; cdecl; overload;
    function validateValue(ioValue: Pointer; forKeyPath: NSString; error: NSError): Boolean; cdecl; overload;
    function valueForKey(key: NSString): Pointer; cdecl;
    function valueForKeyPath(keyPath: NSString): Pointer; cdecl;
    function valueForUndefinedKey(key: NSString): Pointer; cdecl;
    procedure willChange(changeKind: NSKeyValueChange; valuesAtIndexes: NSIndexSet; forKey: NSString); cdecl;
    procedure willChangeValueForKey(key: NSString); cdecl; overload;
    procedure willChangeValueForKey(key: NSString; withSetMutation: NSKeyValueSetMutationKind; usingObjects: NSSet); cdecl; overload;
    function zone: Pointer; cdecl;
  end;
  TNSObject = class(TOCGenericImport<NSObjectClass, NSObject>)  end;
*)
  NSOperationClass = interface(NSObjectClass)
    ['{93F325F4-A0F6-4CBF-B3F2-951ACB5CCB81}']
  end;
  NSOperation = interface(NSObject)
    ['{DC872914-E61F-483D-8A77-8951EC87708C}']
    procedure addDependency(op: NSOperation); cdecl;
    procedure cancel; cdecl;
//    function completionBlock: void (^)(void); cdecl;
    function dependencies: NSArray; cdecl;
    function init: Pointer; cdecl;
    function isCancelled: Boolean; cdecl;
    function isConcurrent: Boolean; cdecl;
    function isExecuting: Boolean; cdecl;
    function isFinished: Boolean; cdecl;
    function isReady: Boolean; cdecl;
    procedure main; cdecl;
    function queuePriority: NSOperationQueuePriority; cdecl;
    procedure removeDependency(op: NSOperation); cdecl;
    procedure setQueuePriority(p: NSOperationQueuePriority); cdecl;
    procedure setThreadPriority(p: double); cdecl;
    procedure start; cdecl;
    function threadPriority: double; cdecl;
    procedure waitUntilFinished; cdecl;
  end;
  TNSOperation = class(TOCGenericImport<NSOperationClass, NSOperation>)  end;

  NSRunLoopClass = interface(NSObjectClass)
    ['{A7BD196E-2B24-4EB3-8336-8723006676EB}']
    {class} function currentRunLoop: Pointer; cdecl;
    {class} function mainRunLoop: Pointer; cdecl;
  end;
  NSRunLoop = interface(NSObject)
    ['{775F67AF-A91B-4E43-B905-F89D1E8B75A5}']
    procedure acceptInputForMode(mode: NSString; beforeDate: NSDate); cdecl;
    procedure addPort(aPort: NSPort; forMode: NSString); cdecl;
    procedure addTimer(timer: NSTimer; forMode: NSString); cdecl;
    procedure cancelPerformSelector(aSelector: SEL; target: Pointer; argument: Pointer); cdecl;
    procedure cancelPerformSelectorsWithTarget(target: Pointer); cdecl;
    function currentMode: NSString; cdecl;
    function getCFRunLoop: CFRunLoopRef; cdecl;
    function limitDateForMode(mode: NSString): NSDate; cdecl;
    procedure performSelector(aSelector: SEL; target: Pointer; argument: Pointer; order: NSUInteger; modes: NSArray); cdecl;
    procedure removePort(aPort: NSPort; forMode: NSString); cdecl;
    procedure run; cdecl;
    function runMode(mode: NSString; beforeDate: NSDate): Boolean; cdecl;
    procedure runUntilDate(limitDate: NSDate); cdecl;
  end;
  TNSRunLoop = class(TOCGenericImport<NSRunLoopClass, NSRunLoop>)  end;

  NSNullClass = interface(NSObjectClass)
    ['{3BC76A3D-21AE-47F9-BC0C-1761CE7FE000}']
    {class} function null: Pointer; cdecl;
  end;
  NSNull = interface(NSObject)
    ['{24ED5CA8-7361-4914-809C-DD2897CD1710}']
  end;
  TNSNull = class(TOCGenericImport<NSNullClass, NSNull>)  end;

  NSScannerClass = interface(NSObjectClass)
    ['{BFB87C94-DC51-431E-B952-B1AECDC7BF40}']
    {class} function localizedScannerWithString(string_: NSString): Pointer; cdecl;
    {class} function scannerWithString(string_: NSString): Pointer; cdecl;
  end;
  NSScanner = interface(NSObject)
    ['{6C70A589-CA01-4B10-B829-891ECB6DF232}']
    function caseSensitive: Boolean; cdecl;
    function charactersToBeSkipped: NSCharacterSet; cdecl;
    function initWithString(string_: NSString): Pointer; cdecl;
    function isAtEnd: Boolean; cdecl;
    function locale: Pointer; cdecl;
    function scanCharactersFromSet(set_: NSCharacterSet; intoString: NSString): Boolean; cdecl;
    function scanDecimal(dcm: NSDecimal): Boolean; cdecl;
    function scanDouble(value: PDouble): Boolean; cdecl;
    function scanFloat(value: PSingle): Boolean; cdecl;
    function scanHexDouble(result: PDouble): Boolean; cdecl;
    function scanHexFloat(result: PSingle): Boolean; cdecl;
    function scanHexInt(value: PInteger): Boolean; cdecl;
    function scanHexLongLong(result: PUInt64): Boolean; cdecl;
    function scanInt(value: PInteger): Boolean; cdecl;
    function scanInteger(value: NSInteger): Boolean; cdecl;
    function scanLocation: NSUInteger; cdecl;
    function scanLongLong(value: PInt64): Boolean; cdecl;
    function scanString(string_: NSString; intoString: NSString): Boolean; cdecl;
    function scanUpToCharactersFromSet(set_: NSCharacterSet; intoString: NSString): Boolean; cdecl;
    function scanUpToString(string_: NSString; intoString: NSString): Boolean; cdecl;
    procedure setCaseSensitive(flag: Boolean); cdecl;
    procedure setCharactersToBeSkipped(set_: NSCharacterSet); cdecl;
    procedure setLocale(locale: Pointer); cdecl;
    procedure setScanLocation(pos: NSUInteger); cdecl;
  end;
  TNSScanner = class(TOCGenericImport<NSScannerClass, NSScanner>)  end;

  NSConditionLockClass = interface(NSObjectClass)
    ['{BD5235E9-ABB9-4592-8677-94DADAE8F00B}']
  end;
  NSConditionLock = interface(NSObject)
    ['{BAFDC74F-2E71-40FE-B950-3E32D875BB6E}']
    function condition: NSInteger; cdecl;
    function initWithCondition(condition: NSInteger): Pointer; cdecl;
    function lockBeforeDate(limit: NSDate): Boolean; cdecl;
    procedure lockWhenCondition(condition: NSInteger); cdecl; overload;
    function lockWhenCondition(condition: NSInteger; beforeDate: NSDate): Boolean; cdecl; overload;
    function name: NSString; cdecl;
    procedure setName(n: NSString); cdecl;
    function tryLock: Boolean; cdecl;
    function tryLockWhenCondition(condition: NSInteger): Boolean; cdecl;
    procedure unlockWithCondition(condition: NSInteger); cdecl;
  end;
  TNSConditionLock = class(TOCGenericImport<NSConditionLockClass, NSConditionLock>)  end;

  NSUserDefaultsClass = interface(NSObjectClass)
    ['{AA19A42B-50C7-47B5-916D-C1D9A21B0566}']
    {class} procedure resetStandardUserDefaults; cdecl;
    {class} function standardUserDefaults: Pointer; cdecl;
  end;
  NSUserDefaults = interface(NSObject)
    ['{07413276-93BF-45FC-95FC-1E18CA4863CB}']
    function URLForKey(defaultName: NSString): NSURL; cdecl;
    procedure addSuiteNamed(suiteName: NSString); cdecl;
    function arrayForKey(defaultName: NSString): NSArray; cdecl;
    function boolForKey(defaultName: NSString): Boolean; cdecl;
    function dataForKey(defaultName: NSString): NSData; cdecl;
    function dictionaryForKey(defaultName: NSString): NSDictionary; cdecl;
    function dictionaryRepresentation: NSDictionary; cdecl;
    function doubleForKey(defaultName: NSString): double; cdecl;
    function floatForKey(defaultName: NSString): Single; cdecl;
    function init: Pointer; cdecl;
    function initWithUser(username: NSString): Pointer; cdecl;
    function integerForKey(defaultName: NSString): NSInteger; cdecl;
    function objectForKey(defaultName: NSString): Pointer; cdecl;
    function objectIsForcedForKey(key: NSString): Boolean; cdecl; overload;
    function objectIsForcedForKey(key: NSString; inDomain: NSString): Boolean; cdecl; overload;
    function persistentDomainForName(domainName: NSString): NSDictionary; cdecl;
    function persistentDomainNames: NSArray; cdecl;
    procedure registerDefaults(registrationDictionary: NSDictionary); cdecl;
    procedure removeObjectForKey(defaultName: NSString); cdecl;
    procedure removePersistentDomainForName(domainName: NSString); cdecl;
    procedure removeSuiteNamed(suiteName: NSString); cdecl;
    procedure removeVolatileDomainForName(domainName: NSString); cdecl;
    procedure setBool(value: Boolean; forKey: NSString); cdecl;
    procedure setDouble(value: double; forKey: NSString); cdecl;
    procedure setFloat(value: Single; forKey: NSString); cdecl;
    procedure setInteger(value: NSInteger; forKey: NSString); cdecl;
    procedure setObject(value: Pointer; forKey: NSString); cdecl;
    procedure setPersistentDomain(domain: NSDictionary; forName: NSString); cdecl;
    procedure setURL(url: NSURL; forKey: NSString); cdecl;
    procedure setVolatileDomain(domain: NSDictionary; forName: NSString); cdecl;
    function stringArrayForKey(defaultName: NSString): NSArray; cdecl;
    function stringForKey(defaultName: NSString): NSString; cdecl;
    function synchronize: Boolean; cdecl;
    function volatileDomainForName(domainName: NSString): NSDictionary; cdecl;
    function volatileDomainNames: NSArray; cdecl;
  end;
  TNSUserDefaults = class(TOCGenericImport<NSUserDefaultsClass, NSUserDefaults>)  end;

  NSConditionClass = interface(NSObjectClass)
    ['{2B574496-79E9-411D-A51E-AA634E07421D}']
  end;
  NSCondition = interface(NSObject)
    ['{E23AECF0-6BA2-4110-8244-D7C39CBFAA36}']
    procedure broadcast; cdecl;
    function name: NSString; cdecl;
    procedure setName(n: NSString); cdecl;
    procedure signal; cdecl;
    procedure wait; cdecl;
    function waitUntilDate(limit: NSDate): Boolean; cdecl;
  end;
  TNSCondition = class(TOCGenericImport<NSConditionClass, NSCondition>)  end;

  NSValueTransformerClass = interface(NSObjectClass)
    ['{B62A5881-27E0-444A-A6B2-06EDA757184F}']
    {class} function allowsReverseTransformation: Boolean; cdecl;
    {class} procedure setValueTransformer(transformer: NSValueTransformer; forName: NSString); cdecl;
    {class} function valueTransformerForName(name: NSString): Pointer; cdecl;
    {class} function valueTransformerNames: NSArray; cdecl;
  end;
  NSValueTransformer = interface(NSObject)
    ['{87BD3A8C-2E71-425F-B42E-5FD56B6F80E4}']
    function reverseTransformedValue(value: Pointer): Pointer; cdecl;
    function transformedValue(value: Pointer): Pointer; cdecl;
  end;
  TNSValueTransformer = class(TOCGenericImport<NSValueTransformerClass, NSValueTransformer>)  end;

  NSValueClass = interface(NSObjectClass)
    ['{182B7688-3BE2-465F-B2E5-A9D5015E6E88}']
    {class} function value(value: Pointer; withObjCType: MarshaledAString): Pointer; cdecl;
    {class} function valueWithBytes(value: Pointer; objCType: MarshaledAString): Pointer; cdecl;
    {class} function valueWithNonretainedObject(anObject: Pointer): Pointer; cdecl;
    {class} function valueWithPointer(pointer: Pointer): Pointer; cdecl;
    {class} function valueWithRange(range: NSRange): Pointer; cdecl;
  end;
  NSValue = interface(NSObject)
    ['{3CF18344-A043-4C8F-ACCE-B52DC34C14A9}']
    procedure getValue(value: Pointer); cdecl;
    function initWithBytes(value: Pointer; objCType: MarshaledAString): Pointer; cdecl;
    function isEqualToValue(value: NSValue): Boolean; cdecl;
    function nonretainedObjectValue: Pointer; cdecl;
    function objCType: MarshaledAString; cdecl;
    function pointerValue: Pointer; cdecl;
    function rangeValue: NSRange; cdecl;
  end;
  TNSValue = class(TOCGenericImport<NSValueClass, NSValue>)  end;

  NSDateComponentsClass = interface(NSObjectClass)
    ['{12C8F7BC-F3BC-425F-B1C6-4D17A93F861B}']
  end;
  NSDateComponents = interface(NSObject)
    ['{485F32A8-8CE5-4CCA-A03B-EEE021A8D8D8}']
    function calendar: NSCalendar; cdecl;
    function date: NSDate; cdecl;
    function day: NSInteger; cdecl;
    function era: NSInteger; cdecl;
    function hour: NSInteger; cdecl;
    function minute: NSInteger; cdecl;
    function month: NSInteger; cdecl;
    function quarter: NSInteger; cdecl;
    function second: NSInteger; cdecl;
    procedure setCalendar(cal: NSCalendar); cdecl;
    procedure setDay(v: NSInteger); cdecl;
    procedure setEra(v: NSInteger); cdecl;
    procedure setHour(v: NSInteger); cdecl;
    procedure setMinute(v: NSInteger); cdecl;
    procedure setMonth(v: NSInteger); cdecl;
    procedure setQuarter(v: NSInteger); cdecl;
    procedure setSecond(v: NSInteger); cdecl;
    procedure setTimeZone(tz: NSTimeZone); cdecl;
    procedure setWeek(v: NSInteger); cdecl;
    procedure setWeekOfMonth(w: NSInteger); cdecl;
    procedure setWeekOfYear(w: NSInteger); cdecl;
    procedure setWeekday(v: NSInteger); cdecl;
    procedure setWeekdayOrdinal(v: NSInteger); cdecl;
    procedure setYear(v: NSInteger); cdecl;
    procedure setYearForWeekOfYear(y: NSInteger); cdecl;
    function timeZone: NSTimeZone; cdecl;
    function week: NSInteger; cdecl;
    function weekOfMonth: NSInteger; cdecl;
    function weekOfYear: NSInteger; cdecl;
    function weekday: NSInteger; cdecl;
    function weekdayOrdinal: NSInteger; cdecl;
    function year: NSInteger; cdecl;
    function yearForWeekOfYear: NSInteger; cdecl;
  end;
  TNSDateComponents = class(TOCGenericImport<NSDateComponentsClass, NSDateComponents>)  end;

  NSUbiquitousKeyValueStoreClass = interface(NSObjectClass)
    ['{188E43E2-1970-41A6-AF30-47FBEBCE88C8}']
    {class} function defaultStore: Pointer; cdecl;
  end;
  NSUbiquitousKeyValueStore = interface(NSObject)
    ['{76EC096B-4E30-4C34-9BD3-B9751D3414C0}']
    function arrayForKey(aKey: NSString): NSArray; cdecl;
    function boolForKey(aKey: NSString): Boolean; cdecl;
    function dataForKey(aKey: NSString): NSData; cdecl;
    function dictionaryForKey(aKey: NSString): NSDictionary; cdecl;
    function dictionaryRepresentation: NSDictionary; cdecl;
    function doubleForKey(aKey: NSString): double; cdecl;
    function longLongForKey(aKey: NSString): Int64; cdecl;
    function objectForKey(aKey: NSString): Pointer; cdecl;
    procedure removeObjectForKey(aKey: NSString); cdecl;
    procedure setArray(anArray: NSArray; forKey: NSString); cdecl;
    procedure setBool(value: Boolean; forKey: NSString); cdecl;
    procedure setData(aData: NSData; forKey: NSString); cdecl;
    procedure setDictionary(aDictionary: NSDictionary; forKey: NSString); cdecl;
    procedure setDouble(value: double; forKey: NSString); cdecl;
    procedure setLongLong(value: Int64; forKey: NSString); cdecl;
    procedure setObject(anObject: Pointer; forKey: NSString); cdecl;
    procedure setString(aString: NSString; forKey: NSString); cdecl;
    function stringForKey(aKey: NSString): NSString; cdecl;
    function synchronize: Boolean; cdecl;
  end;
  TNSUbiquitousKeyValueStore = class(TOCGenericImport<NSUbiquitousKeyValueStoreClass, NSUbiquitousKeyValueStore>)  end;

  NSDateClass = interface(NSObjectClass)
    ['{CD5F76FF-1CAF-4AA7-B2D2-BACA8B0CF3DE}']
    {class} function date: Pointer; cdecl;
    {class} function dateWithTimeInterval(ti: NSTimeInterval; sinceDate: NSDate): Pointer; cdecl;
    {class} function dateWithTimeIntervalSince1970(secs: NSTimeInterval): Pointer; cdecl;
    {class} function dateWithTimeIntervalSinceNow(secs: NSTimeInterval): Pointer; cdecl;
    {class} function dateWithTimeIntervalSinceReferenceDate(secs: NSTimeInterval): Pointer; cdecl;
    {class} function distantFuture: Pointer; cdecl;
    {class} function distantPast: Pointer; cdecl;
    {class} function timeIntervalSinceReferenceDate: NSTimeInterval; cdecl; overload;
  end;
  NSDate = interface(NSObject)
    ['{93FC9F8F-5AC2-4ED8-B5DA-0B05FC45FFFA}']
    function addTimeInterval(seconds: NSTimeInterval): Pointer; cdecl;
    function compare(other: NSDate): NSComparisonResult; cdecl;
    function dateByAddingTimeInterval(ti: NSTimeInterval): Pointer; cdecl;
    function description: NSString; cdecl;
    function descriptionWithLocale(locale: Pointer): NSString; cdecl;
    function earlierDate(anotherDate: NSDate): NSDate; cdecl;
    function init: Pointer; cdecl;
    function initWithTimeInterval(secsToBeAdded: NSTimeInterval; sinceDate: NSDate): Pointer; cdecl;
    function initWithTimeIntervalSince1970(ti: NSTimeInterval): Pointer; cdecl;
    function initWithTimeIntervalSinceNow(secs: NSTimeInterval): Pointer; cdecl;
    function initWithTimeIntervalSinceReferenceDate(secsToBeAdded: NSTimeInterval): Pointer; cdecl;
    function isEqualToDate(otherDate: NSDate): Boolean; cdecl;
    function laterDate(anotherDate: NSDate): NSDate; cdecl;
    function timeIntervalSince1970: NSTimeInterval; cdecl;
    function timeIntervalSinceDate(anotherDate: NSDate): NSTimeInterval; cdecl;
    function timeIntervalSinceNow: NSTimeInterval; cdecl;
    function timeIntervalSinceReferenceDate: NSTimeInterval; cdecl; overload;
  end;
  TNSDate = class(TOCGenericImport<NSDateClass, NSDate>)  end;

  NSDataClass = interface(NSObjectClass)
    ['{FC1B5E54-5356-41B1-9784-806C092CC2C8}']
    {class} function data: Pointer; cdecl;
    {class} function dataWithBytes(bytes: Pointer; length: NSUInteger): Pointer; cdecl;
    {class} function dataWithBytesNoCopy(bytes: Pointer; length: NSUInteger): Pointer; cdecl; overload;
    {class} function dataWithBytesNoCopy(bytes: Pointer; length: NSUInteger; freeWhenDone: Boolean): Pointer; cdecl; overload;
    {class} function dataWithContentsOfFile(path: NSString): Pointer; cdecl; overload;
    {class} function dataWithContentsOfFile(path: NSString; options: NSDataReadingOptions; error: NSError): Pointer; cdecl; overload;
    {class} function dataWithContentsOfMappedFile(path: NSString): Pointer; cdecl;
    {class} function dataWithContentsOfURL(url: NSURL): Pointer; cdecl; overload;
    {class} function dataWithContentsOfURL(url: NSURL; options: NSDataReadingOptions; error: NSError): Pointer; cdecl; overload;
    {class} function dataWithData(data: NSData): Pointer; cdecl;
  end;
  NSData = interface(NSObject)
    ['{E3D4B061-40E6-4506-8B27-34185AB7FD5E}']
    function bytes: Pointer; cdecl;
    function description: NSString; cdecl;
    procedure getBytes(buffer: Pointer); cdecl; overload;
    procedure getBytes(buffer: Pointer; length: NSUInteger); cdecl; overload;
    procedure getBytes(buffer: Pointer; range: NSRange); cdecl; overload;
    function initWithBytes(bytes: Pointer; length: NSUInteger): Pointer; cdecl;
    function initWithBytesNoCopy(bytes: Pointer; length: NSUInteger): Pointer; cdecl; overload;
    function initWithBytesNoCopy(bytes: Pointer; length: NSUInteger; freeWhenDone: Boolean): Pointer; cdecl; overload;
    function initWithContentsOfFile(path: NSString): Pointer; cdecl; overload;
    function initWithContentsOfFile(path: NSString; options: NSDataReadingOptions; error: NSError): Pointer; cdecl; overload;
    function initWithContentsOfMappedFile(path: NSString): Pointer; cdecl;
    function initWithContentsOfURL(url: NSURL): Pointer; cdecl; overload;
    function initWithContentsOfURL(url: NSURL; options: NSDataReadingOptions; error: NSError): Pointer; cdecl; overload;
    function initWithData(data: NSData): Pointer; cdecl;
    function isEqualToData(other: NSData): Boolean; cdecl;
    function length: NSUInteger; cdecl;
    function rangeOfData(dataToFind: NSData; options: NSDataSearchOptions; range: NSRange): NSRange; cdecl;
    function subdataWithRange(range: NSRange): NSData; cdecl;
    function writeToFile(path: NSString; atomically: Boolean): Boolean; cdecl; overload;
    function writeToFile(path: NSString; options: NSDataWritingOptions; error: NSError): Boolean; cdecl; overload;
    function writeToURL(url: NSURL; atomically: Boolean): Boolean; cdecl; overload;
    function writeToURL(url: NSURL; options: NSDataWritingOptions; error: NSError): Boolean; cdecl; overload;
  end;
  TNSData = class(TOCGenericImport<NSDataClass, NSData>)  end;

  NSUndoManagerClass = interface(NSObjectClass)
    ['{7A732426-E04C-4526-AA3B-CE84723EC6FE}']
  end;
  NSUndoManager = interface(NSObject)
    ['{D0712CF9-8A53-4281-AA41-C66CD12B1122}']
    procedure beginUndoGrouping; cdecl;
    function canRedo: Boolean; cdecl;
    function canUndo: Boolean; cdecl;
    procedure disableUndoRegistration; cdecl;
    procedure enableUndoRegistration; cdecl;
    procedure endUndoGrouping; cdecl;
    function groupingLevel: NSInteger; cdecl;
    function groupsByEvent: Boolean; cdecl;
    function isRedoing: Boolean; cdecl;
    function isUndoRegistrationEnabled: Boolean; cdecl;
    function isUndoing: Boolean; cdecl;
    function levelsOfUndo: NSUInteger; cdecl;
    function prepareWithInvocationTarget(target: Pointer): Pointer; cdecl;
    procedure redo; cdecl;
    function redoActionIsDiscardable: Boolean; cdecl;
    function redoActionName: NSString; cdecl;
    function redoMenuItemTitle: NSString; cdecl;
    function redoMenuTitleForUndoActionName(actionName: NSString): NSString; cdecl;
    procedure removeAllActions; cdecl;
    procedure removeAllActionsWithTarget(target: Pointer); cdecl;
    function runLoopModes: NSArray; cdecl;
    procedure setActionIsDiscardable(discardable: Boolean); cdecl;
    procedure setActionName(actionName: NSString); cdecl;
    procedure setGroupsByEvent(groupsByEvent: Boolean); cdecl;
    procedure setLevelsOfUndo(levels: NSUInteger); cdecl;
    procedure setRunLoopModes(runLoopModes: NSArray); cdecl;
    procedure undo; cdecl;
    function undoActionIsDiscardable: Boolean; cdecl;
    function undoActionName: NSString; cdecl;
    function undoMenuItemTitle: NSString; cdecl;
    function undoMenuTitleForUndoActionName(actionName: NSString): NSString; cdecl;
    procedure undoNestedGroup; cdecl;
  end;
  TNSUndoManager = class(TOCGenericImport<NSUndoManagerClass, NSUndoManager>)  end;

  NSCoderClass = interface(NSObjectClass)
    ['{6D32BE75-E10C-4B9E-9F3E-49F748647B3A}']
  end;
  NSCoder = interface(NSObject)
    ['{949794EC-3459-4BD6-918A-0F542F675C94}']
    function allowsKeyedCoding: Boolean; cdecl;
    function containsValueForKey(key: NSString): Boolean; cdecl;
    procedure decodeArrayOfObjCType(itemType: MarshaledAString; count: NSUInteger; at: Pointer); cdecl;
    function decodeBoolForKey(key: NSString): Boolean; cdecl;
    function decodeBytesForKey(key: NSString; returnedLength: NSUInteger): PByte; cdecl;
    function decodeBytesWithReturnedLength(lengthp: NSUInteger): Pointer; cdecl;
    function decodeDataObject: NSData; cdecl;
    function decodeDoubleForKey(key: NSString): double; cdecl;
    function decodeFloatForKey(key: NSString): Single; cdecl;
    function decodeInt32ForKey(key: NSString): Integer; cdecl;
    function decodeInt64ForKey(key: NSString): Int64; cdecl;
    function decodeIntForKey(key: NSString): Integer; cdecl;
    function decodeIntegerForKey(key: NSString): NSInteger; cdecl;
    function decodeObject: Pointer; cdecl;
    function decodeObjectForKey(key: NSString): Pointer; cdecl;
    procedure decodeValueOfObjCType(type_: MarshaledAString; at: Pointer); cdecl;
    procedure decodeValuesOfObjCTypes(types: MarshaledAString); cdecl;
    procedure encodeArrayOfObjCType(type_: MarshaledAString; count: NSUInteger; at: Pointer); cdecl;
    procedure encodeBool(boolv: Boolean; forKey: NSString); cdecl;
    procedure encodeBycopyObject(anObject: Pointer); cdecl;
    procedure encodeByrefObject(anObject: Pointer); cdecl;
    procedure encodeBytes(byteaddr: Pointer; length: NSUInteger); cdecl; overload;
    procedure encodeBytes(bytesp: PByte; length: NSUInteger; forKey: NSString); cdecl; overload;
    procedure encodeConditionalObject(object_: Pointer); cdecl; overload;
    procedure encodeConditionalObject(objv: Pointer; forKey: NSString); cdecl; overload;
    procedure encodeDataObject(data: NSData); cdecl;
    procedure encodeDouble(realv: double; forKey: NSString); cdecl;
    procedure encodeFloat(realv: Single; forKey: NSString); cdecl;
    procedure encodeInt32(intv: Integer; forKey: NSString); cdecl;
    procedure encodeInt64(intv: Int64; forKey: NSString); cdecl;
    procedure encodeInt(intv: Integer; forKey: NSString); cdecl;
    procedure encodeInteger(intv: NSInteger; forKey: NSString); cdecl;
    procedure encodeObject(object_: Pointer); cdecl; overload;
    procedure encodeObject(objv: Pointer; forKey: NSString); cdecl; overload;
    procedure encodeRootObject(rootObject: Pointer); cdecl;
    procedure encodeValueOfObjCType(type_: MarshaledAString; at: Pointer); cdecl;
    procedure encodeValuesOfObjCTypes(types: MarshaledAString); cdecl;
    function objectZone: Pointer; cdecl;
    procedure setObjectZone(zone: Pointer); cdecl;
    function systemVersion: Longword; cdecl;
    function versionForClassName(className: NSString): NSInteger; cdecl;
  end;
  TNSCoder = class(TOCGenericImport<NSCoderClass, NSCoder>)  end;

  NSAutoreleasePoolClass = interface(NSObjectClass)
    ['{DBA0D78E-8F08-45AA-A5AD-F8467DE270A9}']
    {class} procedure addObject(anObject: Pointer); cdecl; overload;
  end;
  NSAutoreleasePool = interface(NSObject)
    ['{587CDD53-8646-42AC-8A6F-3F9B356C5D7B}']
    procedure addObject(anObject: Pointer); cdecl; overload;
    procedure drain; cdecl;
  end;
  TNSAutoreleasePool = class(TOCGenericImport<NSAutoreleasePoolClass, NSAutoreleasePool>)  end;

  NSXMLParserClass = interface(NSObjectClass)
    ['{8891E206-097C-4813-8484-2A5269B52970}']
  end;
  NSXMLParser = interface(NSObject)
    ['{F6681F54-46BC-4EFE-B60E-C2D36CBC366E}']
    procedure abortParsing; cdecl;
    function columnNumber: NSInteger; cdecl;
    function delegate: Pointer; cdecl;
    function initWithContentsOfURL(url: NSURL): Pointer; cdecl;
    function initWithData(data: NSData): Pointer; cdecl;
    function initWithStream(stream: NSInputStream): Pointer; cdecl;
    function lineNumber: NSInteger; cdecl;
    function parse: Boolean; cdecl;
    function parserError: NSError; cdecl;
    function publicID: NSString; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setShouldProcessNamespaces(shouldProcessNamespaces: Boolean); cdecl;
    procedure setShouldReportNamespacePrefixes(shouldReportNamespacePrefixes: Boolean); cdecl;
    procedure setShouldResolveExternalEntities(shouldResolveExternalEntities: Boolean); cdecl;
    function shouldProcessNamespaces: Boolean; cdecl;
    function shouldReportNamespacePrefixes: Boolean; cdecl;
    function shouldResolveExternalEntities: Boolean; cdecl;
    function systemID: NSString; cdecl;
  end;
  TNSXMLParser = class(TOCGenericImport<NSXMLParserClass, NSXMLParser>)  end;

  NSAttributedStringClass = interface(NSObjectClass)
    ['{B73B65A2-F931-4FD6-921C-366915725D58}']
  end;
  NSAttributedString = interface(NSObject)
    ['{D1B80173-A550-4876-93C5-70EAB5E6E8A7}']
    function attribute(attrName: NSString; atIndex: NSUInteger; effectiveRange: PNSRange): Pointer; cdecl; overload;
    function attribute(attrName: NSString; atIndex: NSUInteger; longestEffectiveRange: PNSRange; inRange: NSRange): Pointer; cdecl; overload;
    function attributedSubstringFromRange(range: NSRange): NSAttributedString; cdecl;
    function attributesAtIndex(location: NSUInteger; effectiveRange: PNSRange): NSDictionary; cdecl; overload;
    function attributesAtIndex(location: NSUInteger; longestEffectiveRange: PNSRange; inRange: NSRange): NSDictionary; cdecl; overload;
    function initWithAttributedString(attrStr: NSAttributedString): Pointer; cdecl;
    function initWithString(str: NSString): Pointer; cdecl; overload;
    function initWithString(str: NSString; attributes: NSDictionary): Pointer; cdecl; overload;
    function isEqualToAttributedString(other: NSAttributedString): Boolean; cdecl;
    function length: NSUInteger; cdecl;
  end;
  TNSAttributedString = class(TOCGenericImport<NSAttributedStringClass, NSAttributedString>)  end;

  NSArrayClass = interface(NSObjectClass)
    ['{4046AAAF-5D17-4625-BCB3-74560E52835A}']
    {class} function arrayWithArray(array_: NSArray): Pointer; cdecl;
    {class} function arrayWithContentsOfFile(path: NSString): Pointer; cdecl;
    {class} function arrayWithContentsOfURL(url: NSURL): Pointer; cdecl;
    {class} function arrayWithObject(anObject: Pointer): Pointer; cdecl;
    {class} function arrayWithObjects(firstObj: Pointer): Pointer; cdecl; overload;
    {class} function arrayWithObjects(objects: Pointer; count: NSUInteger): Pointer; cdecl; overload;
  end;
  NSArray = interface(NSObject)
    ['{4738B4F2-347A-41C6-8B62-F0E324B67C7B}']
    procedure addObserver(observer: NSObject; forKeyPath: NSString; options: NSKeyValueObservingOptions; context: Pointer); cdecl; overload;
    procedure addObserver(observer: NSObject; toObjectsAtIndexes: NSIndexSet; forKeyPath: NSString; options: NSKeyValueObservingOptions; context: Pointer); cdecl; overload;
    function arrayByAddingObject(anObject: Pointer): NSArray; cdecl;
    function arrayByAddingObjectsFromArray(otherArray: NSArray): NSArray; cdecl;
    function componentsJoinedByString(separator: NSString): NSString; cdecl;
    function containsObject(anObject: Pointer): Boolean; cdecl;
    function count: NSUInteger; cdecl;
    function description: NSString; cdecl;
    function descriptionWithLocale(locale: Pointer): NSString; cdecl; overload;
    function descriptionWithLocale(locale: Pointer; indent: NSUInteger): NSString; cdecl; overload;
    function filteredArrayUsingPredicate(predicate: NSPredicate): NSArray; cdecl;
    function firstObjectCommonWithArray(otherArray: NSArray): Pointer; cdecl;
    procedure getObjects(objects: Pointer); cdecl; overload;
    procedure getObjects(objects: Pointer; range: NSRange); cdecl; overload;
    function indexOfObject(anObject: Pointer): NSUInteger; cdecl; overload;
    function indexOfObject(anObject: Pointer; inRange: NSRange): NSUInteger; cdecl; overload;
    function indexOfObjectIdenticalTo(anObject: Pointer): NSUInteger; cdecl; overload;
    function indexOfObjectIdenticalTo(anObject: Pointer; inRange: NSRange): NSUInteger; cdecl; overload;
    function initWithArray(array_: NSArray): Pointer; cdecl; overload;
    function initWithArray(array_: NSArray; copyItems: Boolean): Pointer; cdecl; overload;
    function initWithContentsOfFile(path: NSString): Pointer; cdecl;
    function initWithContentsOfURL(url: NSURL): Pointer; cdecl;
    function initWithObjects(firstObj: Pointer): Pointer; cdecl; overload;
    function initWithObjects(objects: Pointer; count: NSUInteger): Pointer; cdecl; overload;
    function isEqualToArray(otherArray: NSArray): Boolean; cdecl;
    function lastObject: Pointer; cdecl;
    procedure makeObjectsPerformSelector(aSelector: SEL); cdecl; overload;
    procedure makeObjectsPerformSelector(aSelector: SEL; withObject: Pointer); cdecl; overload;
    function objectAtIndex(index: NSUInteger): Pointer; cdecl;
    function objectEnumerator: NSEnumerator; cdecl;
    function objectsAtIndexes(indexes: NSIndexSet): NSArray; cdecl;
    function pathsMatchingExtensions(filterTypes: NSArray): NSArray; cdecl;
    procedure removeObserver(observer: NSObject; forKeyPath: NSString); cdecl; overload;
    procedure removeObserver(observer: NSObject; forKeyPath: NSString; context: Pointer); cdecl; overload;
    procedure removeObserver(observer: NSObject; fromObjectsAtIndexes: NSIndexSet; forKeyPath: NSString); cdecl; overload;
    procedure removeObserver(observer: NSObject; fromObjectsAtIndexes: NSIndexSet; forKeyPath: NSString; context: Pointer); cdecl; overload;
    function reverseObjectEnumerator: NSEnumerator; cdecl;
    procedure setValue(value: Pointer; forKey: NSString); cdecl;
    function sortedArrayHint: NSData; cdecl;
    function sortedArrayUsingDescriptors(sortDescriptors: NSArray): NSArray; cdecl;
    function sortedArrayUsingSelector(comparator: SEL): NSArray; cdecl;
    function subarrayWithRange(range: NSRange): NSArray; cdecl;
    function valueForKey(key: NSString): Pointer; cdecl;
    function writeToFile(path: NSString; atomically: Boolean): Boolean; cdecl;
    function writeToURL(url: NSURL; atomically: Boolean): Boolean; cdecl;
  end;
  TNSArray = class(TOCGenericImport<NSArrayClass, NSArray>)  end;

  NSAssertionHandlerClass = interface(NSObjectClass)
    ['{FAD13D4D-08C4-4800-AE0A-3C7BDA6D8EA2}']
    {class} function currentHandler: Pointer; cdecl;
  end;
  NSAssertionHandler = interface(NSObject)
    ['{34F7FF7F-1D9B-47B0-B5D0-73D8DCE851DF}']
  end;
  TNSAssertionHandler = class(TOCGenericImport<NSAssertionHandlerClass, NSAssertionHandler>)  end;

  NSCalendarClass = interface(NSObjectClass)
    ['{D79DCC09-8263-448E-B5A4-FD6982962107}']
    {class} function autoupdatingCurrentCalendar: Pointer; cdecl;
    {class} function currentCalendar: Pointer; cdecl;
  end;
  NSCalendar = interface(NSObject)
    ['{C77984D5-A41A-418B-9191-3ACA383B4C1D}']
    function calendarIdentifier: NSString; cdecl;
    function components(unitFlags: NSUInteger; fromDate: NSDate): NSDateComponents; cdecl; overload;
    function components(unitFlags: NSUInteger; fromDate: NSDate; toDate: NSDate; options: NSUInteger): NSDateComponents; cdecl; overload;
    function dateByAddingComponents(comps: NSDateComponents; toDate: NSDate; options: NSUInteger): NSDate; cdecl;
    function dateFromComponents(comps: NSDateComponents): NSDate; cdecl;
    function firstWeekday: NSUInteger; cdecl;
    function initWithCalendarIdentifier(ident: NSString): Pointer; cdecl;
    function locale: NSLocale; cdecl;
    function maximumRangeOfUnit(unit_: NSCalendarUnit): NSRange; cdecl;
    function minimumDaysInFirstWeek: NSUInteger; cdecl;
    function minimumRangeOfUnit(unit_: NSCalendarUnit): NSRange; cdecl;
    function ordinalityOfUnit(smaller: NSCalendarUnit; inUnit: NSCalendarUnit; forDate: NSDate): NSUInteger; cdecl;
    function rangeOfUnit(smaller: NSCalendarUnit; inUnit: NSCalendarUnit; forDate: NSDate): NSRange; cdecl; overload;
    function rangeOfUnit(unit_: NSCalendarUnit; startDate: NSDate; interval: NSTimeInterval; forDate: NSDate): Boolean; cdecl; overload;
    procedure setFirstWeekday(weekday: NSUInteger); cdecl;
    procedure setLocale(locale: NSLocale); cdecl;
    procedure setMinimumDaysInFirstWeek(mdw: NSUInteger); cdecl;
    procedure setTimeZone(tz: NSTimeZone); cdecl;
    function timeZone: NSTimeZone; cdecl;
  end;
  TNSCalendar = class(TOCGenericImport<NSCalendarClass, NSCalendar>)  end;

  NSCharacterSetClass = interface(NSObjectClass)
    ['{9A6BBEF7-C9AA-44B0-B0E9-DDAF728B416E}']
    {class} function alphanumericCharacterSet: Pointer; cdecl;
    {class} function capitalizedLetterCharacterSet: Pointer; cdecl;
    {class} function characterSetWithBitmapRepresentation(data: NSData): Pointer; cdecl;
    {class} function characterSetWithCharactersInString(aString: NSString): Pointer; cdecl;
    {class} function characterSetWithContentsOfFile(fName: NSString): Pointer; cdecl;
    {class} function characterSetWithRange(aRange: NSRange): Pointer; cdecl;
    {class} function controlCharacterSet: Pointer; cdecl;
    {class} function decimalDigitCharacterSet: Pointer; cdecl;
    {class} function decomposableCharacterSet: Pointer; cdecl;
    {class} function illegalCharacterSet: Pointer; cdecl;
    {class} function letterCharacterSet: Pointer; cdecl;
    {class} function lowercaseLetterCharacterSet: Pointer; cdecl;
    {class} function newlineCharacterSet: Pointer; cdecl;
    {class} function nonBaseCharacterSet: Pointer; cdecl;
    {class} function punctuationCharacterSet: Pointer; cdecl;
    {class} function symbolCharacterSet: Pointer; cdecl;
    {class} function uppercaseLetterCharacterSet: Pointer; cdecl;
    {class} function whitespaceAndNewlineCharacterSet: Pointer; cdecl;
    {class} function whitespaceCharacterSet: Pointer; cdecl;
  end;
  NSCharacterSet = interface(NSObject)
    ['{71DB44B0-140C-4D12-AE86-1605B8597A34}']
    function bitmapRepresentation: NSData; cdecl;
    function characterIsMember(aCharacter: unichar): Boolean; cdecl;
    function hasMemberInPlane(thePlane: Byte): Boolean; cdecl;
    function invertedSet: NSCharacterSet; cdecl;
    function isSupersetOfSet(theOtherSet: NSCharacterSet): Boolean; cdecl;
    function longCharacterIsMember(theLongChar: UTF32Char): Boolean; cdecl;
  end;
  TNSCharacterSet = class(TOCGenericImport<NSCharacterSetClass, NSCharacterSet>)  end;

  NSCachedURLResponseClass = interface(NSObjectClass)
    ['{4ABF03BD-8B4B-48D4-A693-8B33CA7032A6}']
  end;
  NSCachedURLResponse = interface(NSObject)
    ['{41FEF993-7A8B-4EEB-B8D1-A6CC8ED02074}']
    function data: NSData; cdecl;
    function initWithResponse(response: NSURLResponse; data: NSData): Pointer; cdecl; overload;
    function initWithResponse(response: NSURLResponse; data: NSData; userInfo: NSDictionary; storagePolicy: NSURLCacheStoragePolicy): Pointer; cdecl; overload;
    function response: NSURLResponse; cdecl;
    function storagePolicy: NSURLCacheStoragePolicy; cdecl;
    function userInfo: NSDictionary; cdecl;
  end;
  TNSCachedURLResponse = class(TOCGenericImport<NSCachedURLResponseClass, NSCachedURLResponse>)  end;

  NSBundleClass = interface(NSObjectClass)
    ['{0072ABF4-50F5-46A4-BC0D-D6C5BEADF849}']
    {class} function URLForResource(name: NSString; withExtension: NSString; subdirectory: NSString; inBundleWithURL: NSURL): NSURL; cdecl; overload;
    {class} function URLsForResourcesWithExtension(ext: NSString; subdirectory: NSString; inBundleWithURL: NSURL): NSArray; cdecl; overload;
    {class} function allBundles: NSArray; cdecl;
    {class} function allFrameworks: NSArray; cdecl;
    {class} function bundleForClass(aClass: Pointer): Pointer; cdecl;
    {class} function bundleWithIdentifier(identifier: NSString): Pointer; cdecl;
    {class} function bundleWithPath(path: NSString): Pointer; cdecl;
    {class} function bundleWithURL(url: NSURL): Pointer; cdecl;
    {class} function mainBundle: Pointer; cdecl;
    {class} function pathForResource(name: NSString; ofType: NSString; inDirectory: NSString): NSString; cdecl; overload;
    {class} function pathsForResourcesOfType(ext: NSString; inDirectory: NSString): NSArray; cdecl; overload;
    {class} function preferredLocalizationsFromArray(localizationsArray: NSArray): NSArray; cdecl; overload;
    {class} function preferredLocalizationsFromArray(localizationsArray: NSArray; forPreferences: NSArray): NSArray; cdecl; overload;
  end;
  NSBundle = interface(NSObject)
    ['{7C2EF877-25D5-4D60-9CA7-6FD9F99B844A}']
    function URLForAuxiliaryExecutable(executableName: NSString): NSURL; cdecl;
    function URLForResource(name: NSString; withExtension: NSString): NSURL; cdecl; overload;
    function URLForResource(name: NSString; withExtension: NSString; subdirectory: NSString): NSURL; cdecl; overload;
    function URLForResource(name: NSString; withExtension: NSString; subdirectory: NSString; localization: NSString): NSURL; cdecl; overload;
    function URLsForResourcesWithExtension(ext: NSString; subdirectory: NSString): NSArray; cdecl; overload;
    function URLsForResourcesWithExtension(ext: NSString; subdirectory: NSString; localization: NSString): NSArray; cdecl; overload;
    function appStoreReceiptURL: NSURL; cdecl;
    function builtInPlugInsPath: NSString; cdecl;
    function builtInPlugInsURL: NSURL; cdecl;
    function bundleIdentifier: NSString; cdecl;
    function bundlePath: NSString; cdecl;
    function bundleURL: NSURL; cdecl;
    function developmentLocalization: NSString; cdecl;
    function executableArchitectures: NSArray; cdecl;
    function executablePath: NSString; cdecl;
    function executableURL: NSURL; cdecl;
    function infoDictionary: NSDictionary; cdecl;
    function initWithPath(path: NSString): Pointer; cdecl;
    function initWithURL(url: NSURL): Pointer; cdecl;
    function isLoaded: Boolean; cdecl;
    function load: Boolean; cdecl;
    function loadAndReturnError(error: NSError): Boolean; cdecl;
    function localizations: NSArray; cdecl;
    function localizedInfoDictionary: NSDictionary; cdecl;
    function localizedStringForKey(key: NSString; value: NSString; table: NSString): NSString; cdecl;
    function objectForInfoDictionaryKey(key: NSString): Pointer; cdecl;
    function pathForAuxiliaryExecutable(executableName: NSString): NSString; cdecl;
    function pathForResource(name: NSString; ofType: NSString): NSString; cdecl; overload;
    function pathForResource(name: NSString; ofType: NSString; inDirectory: NSString): NSString; cdecl; overload;
    function pathForResource(name: NSString; ofType: NSString; inDirectory: NSString; forLocalization: NSString): NSString; cdecl; overload;
    function pathsForResourcesOfType(ext: NSString; inDirectory: NSString): NSArray; cdecl; overload;
    function pathsForResourcesOfType(ext: NSString; inDirectory: NSString; forLocalization: NSString): NSArray; cdecl; overload;
    function preferredLocalizations: NSArray; cdecl;
    function preflightAndReturnError(error: NSError): Boolean; cdecl;
    function privateFrameworksPath: NSString; cdecl;
    function privateFrameworksURL: NSURL; cdecl;
    function resourcePath: NSString; cdecl;
    function resourceURL: NSURL; cdecl;
    function sharedFrameworksPath: NSString; cdecl;
    function sharedFrameworksURL: NSURL; cdecl;
    function sharedSupportPath: NSString; cdecl;
    function sharedSupportURL: NSURL; cdecl;
    function unload: Boolean; cdecl;
  end;
  TNSBundle = class(TOCGenericImport<NSBundleClass, NSBundle>)  end;

  NSCacheClass = interface(NSObjectClass)
    ['{ACF90BE9-BBE1-4514-B1D0-8BBC6486C284}']
  end;
  NSCache = interface(NSObject)
    ['{D5B63E0B-F7B8-445A-AE16-C2375948AD8C}']
    function countLimit: NSUInteger; cdecl;
    function delegate: Pointer; cdecl;
    function evictsObjectsWithDiscardedContent: Boolean; cdecl;
    function name: NSString; cdecl;
    function objectForKey(key: Pointer): Pointer; cdecl;
    procedure removeAllObjects; cdecl;
    procedure removeObjectForKey(key: Pointer); cdecl;
    procedure setCountLimit(lim: NSUInteger); cdecl;
    procedure setDelegate(d: Pointer); cdecl;
    procedure setEvictsObjectsWithDiscardedContent(b: Boolean); cdecl;
    procedure setName(n: NSString); cdecl;
    procedure setObject(obj: Pointer; forKey: Pointer); cdecl; overload;
    procedure setObject(obj: Pointer; forKey: Pointer; cost: NSUInteger); cdecl; overload;
    procedure setTotalCostLimit(lim: NSUInteger); cdecl;
    function totalCostLimit: NSUInteger; cdecl;
  end;
  TNSCache = class(TOCGenericImport<NSCacheClass, NSCache>)  end;

  NSURLResponseClass = interface(NSObjectClass)
    ['{1565D623-EB1D-464E-94D8-42C0A8905B18}']
  end;
  NSURLResponse = interface(NSObject)
    ['{F5E0DFBA-CFA5-4EDC-9CD6-251968315F43}']
    function MIMEType: NSString; cdecl;
    function URL: NSURL; cdecl;
    function expectedContentLength: Int64; cdecl;
    function initWithURL(URL: NSURL; MIMEType: NSString; expectedContentLength: NSInteger; textEncodingName: NSString): Pointer; cdecl;
    function suggestedFilename: NSString; cdecl;
    function textEncodingName: NSString; cdecl;
  end;
  TNSURLResponse = class(TOCGenericImport<NSURLResponseClass, NSURLResponse>)  end;

  NSHTTPCookieStorageClass = interface(NSObjectClass)
    ['{19865EAE-890E-479A-B968-C1A3766ECB1F}']
    {class} function sharedHTTPCookieStorage: Pointer; cdecl;
  end;
  NSHTTPCookieStorage = interface(NSObject)
    ['{7EC095E5-728A-4A89-9388-CC75ABE4FB62}']
    function cookieAcceptPolicy: NSHTTPCookieAcceptPolicy; cdecl;
    function cookies: NSArray; cdecl;
    function cookiesForURL(URL: NSURL): NSArray; cdecl;
    procedure deleteCookie(cookie: NSHTTPCookie); cdecl;
    procedure setCookie(cookie: NSHTTPCookie); cdecl;
    procedure setCookieAcceptPolicy(cookieAcceptPolicy: NSHTTPCookieAcceptPolicy); cdecl;
    procedure setCookies(cookies: NSArray; forURL: NSURL; mainDocumentURL: NSURL); cdecl;
    function sortedCookiesUsingDescriptors(sortOrder: NSArray): NSArray; cdecl;
  end;
  TNSHTTPCookieStorage = class(TOCGenericImport<NSHTTPCookieStorageClass, NSHTTPCookieStorage>)  end;

  NSURLProtocolClass = interface(NSObjectClass)
    ['{57A83353-99AD-4DE3-99F4-7A397BDFCF91}']
    {class} function canInitWithRequest(request: NSURLRequest): Boolean; cdecl;
    {class} function canonicalRequestForRequest(request: NSURLRequest): NSURLRequest; cdecl;
    {class} function propertyForKey(key: NSString; inRequest: NSURLRequest): Pointer; cdecl;
    {class} function registerClass(protocolClass: Pointer): Boolean; cdecl;
    {class} procedure removePropertyForKey(key: NSString; inRequest: NSMutableURLRequest); cdecl;
    {class} function requestIsCacheEquivalent(a: NSURLRequest; toRequest: NSURLRequest): Boolean; cdecl;
    {class} procedure setProperty(value: Pointer; forKey: NSString; inRequest: NSMutableURLRequest); cdecl;
    {class} procedure unregisterClass(protocolClass: Pointer); cdecl;
  end;
  NSURLProtocol = interface(NSObject)
    ['{08CDF707-4E62-484E-99C0-B829E283D232}']
    function cachedResponse: NSCachedURLResponse; cdecl;
    function client: Pointer; cdecl;
    function initWithRequest(request: NSURLRequest; cachedResponse: NSCachedURLResponse; client: Pointer): Pointer; cdecl;
    function request: NSURLRequest; cdecl;
    procedure startLoading; cdecl;
    procedure stopLoading; cdecl;
  end;
  TNSURLProtocol = class(TOCGenericImport<NSURLProtocolClass, NSURLProtocol>)  end;

  NSHTTPCookieClass = interface(NSObjectClass)
    ['{A90972DB-B51A-4E1A-98D3-33A8069A7F12}']
    {class} function cookieWithProperties(properties: NSDictionary): Pointer; cdecl;
    {class} function cookiesWithResponseHeaderFields(headerFields: NSDictionary; forURL: NSURL): NSArray; cdecl;
    {class} function requestHeaderFieldsWithCookies(cookies: NSArray): NSDictionary; cdecl;
  end;
  NSHTTPCookie = interface(NSObject)
    ['{0AC47694-5657-453B-8C16-567F432F7A76}']
    function comment: NSString; cdecl;
    function commentURL: NSURL; cdecl;
    function domain: NSString; cdecl;
    function expiresDate: NSDate; cdecl;
    function initWithProperties(properties: NSDictionary): Pointer; cdecl;
    function isHTTPOnly: Boolean; cdecl;
    function isSecure: Boolean; cdecl;
    function isSessionOnly: Boolean; cdecl;
    function name: NSString; cdecl;
    function path: NSString; cdecl;
    function portList: NSArray; cdecl;
    function properties: NSDictionary; cdecl;
    function value: NSString; cdecl;
    function version: NSUInteger; cdecl;
  end;
  TNSHTTPCookie = class(TOCGenericImport<NSHTTPCookieClass, NSHTTPCookie>)  end;

  NSFileWrapperClass = interface(NSObjectClass)
    ['{B5F18BD1-1847-485B-8372-BDD46C9B5C91}']
  end;
  NSFileWrapper = interface(NSObject)
    ['{4B43D5A5-2039-47EA-8D3A-4D7FA9E8ACBD}']
    function addFileWrapper(child: NSFileWrapper): NSString; cdecl;
    function addRegularFileWithContents(data: NSData; preferredFilename: NSString): NSString; cdecl;
    function fileAttributes: NSDictionary; cdecl;
    function fileWrappers: NSDictionary; cdecl;
    function filename: NSString; cdecl;
    function initDirectoryWithFileWrappers(childrenByPreferredName: NSDictionary): Pointer; cdecl;
    function initRegularFileWithContents(contents: NSData): Pointer; cdecl;
    function initSymbolicLinkWithDestinationURL(url: NSURL): Pointer; cdecl;
    function initWithSerializedRepresentation(serializeRepresentation: NSData): Pointer; cdecl;
    function initWithURL(url: NSURL; options: NSFileWrapperReadingOptions; error: NSError): Pointer; cdecl;
    function isDirectory: Boolean; cdecl;
    function isRegularFile: Boolean; cdecl;
    function isSymbolicLink: Boolean; cdecl;
    function keyForFileWrapper(child: NSFileWrapper): NSString; cdecl;
    function matchesContentsOfURL(url: NSURL): Boolean; cdecl;
    function preferredFilename: NSString; cdecl;
    function readFromURL(url: NSURL; options: NSFileWrapperReadingOptions; error: NSError): Boolean; cdecl;
    function regularFileContents: NSData; cdecl;
    procedure removeFileWrapper(child: NSFileWrapper); cdecl;
    function serializedRepresentation: NSData; cdecl;
    procedure setFileAttributes(fileAttributes: NSDictionary); cdecl;
    procedure setFilename(fileName: NSString); cdecl;
    procedure setPreferredFilename(fileName: NSString); cdecl;
    function symbolicLinkDestinationURL: NSURL; cdecl;
    function writeToURL(url: NSURL; options: NSFileWrapperWritingOptions; originalContentsURL: NSURL; error: NSError): Boolean; cdecl;
  end;
  TNSFileWrapper = class(TOCGenericImport<NSFileWrapperClass, NSFileWrapper>)  end;

  NSFormatterClass = interface(NSObjectClass)
    ['{9CF8F6A6-4B40-474D-BF8B-EB86169872AF}']
  end;
  NSFormatter = interface(NSObject)
    ['{4284B953-9A8D-411D-8B6C-5D4A980790D0}']
    function attributedStringForObjectValue(obj: Pointer; withDefaultAttributes: NSDictionary): NSAttributedString; cdecl;
    function editingStringForObjectValue(obj: Pointer): NSString; cdecl;
    function getObjectValue(obj: Pointer; forString: NSString; errorDescription: NSString): Boolean; cdecl;
    function isPartialStringValid(partialString: NSString; newEditingString: NSString; errorDescription: NSString): Boolean; cdecl; overload;
    function isPartialStringValid(partialStringPtr: NSString; proposedSelectedRange: PNSRange; originalString: NSString; originalSelectedRange: NSRange; errorDescription: NSString): Boolean; cdecl; overload;
    function stringForObjectValue(obj: Pointer): NSString; cdecl;
  end;
  TNSFormatter = class(TOCGenericImport<NSFormatterClass, NSFormatter>)  end;

  NSInvocationClass = interface(NSObjectClass)
    ['{EC179FA9-9693-4174-BA51-D16905365E9A}']
    {class} function invocationWithMethodSignature(sig: NSMethodSignature): Pointer; cdecl;
  end;
  NSInvocation = interface(NSObject)
    ['{BA98E2B3-94E8-4406-8DAE-4FD4272FA386}']
    function argumentsRetained: Boolean; cdecl;
    procedure getArgument(argumentLocation: Pointer; atIndex: NSInteger); cdecl;
    procedure getReturnValue(retLoc: Pointer); cdecl;
    procedure invoke; cdecl;
    procedure invokeWithTarget(target: Pointer); cdecl;
    function methodSignature: NSMethodSignature; cdecl;
    procedure retainArguments; cdecl;
    function selector: SEL; cdecl;
    procedure setArgument(argumentLocation: Pointer; atIndex: NSInteger); cdecl;
    procedure setReturnValue(retLoc: Pointer); cdecl;
    procedure setSelector(selector: SEL); cdecl;
    procedure setTarget(target: Pointer); cdecl;
    function target: Pointer; cdecl;
  end;
  TNSInvocation = class(TOCGenericImport<NSInvocationClass, NSInvocation>)  end;

  NSURLCredentialStorageClass = interface(NSObjectClass)
    ['{BDB08B72-1FF0-49F8-B634-9392631D0BAC}']
    {class} function sharedCredentialStorage: Pointer; cdecl;
  end;
  NSURLCredentialStorage = interface(NSObject)
    ['{A226D276-9EE2-483F-82C8-28B58AC1607C}']
    function allCredentials: NSDictionary; cdecl;
    function credentialsForProtectionSpace(space: NSURLProtectionSpace): NSDictionary; cdecl;
    function defaultCredentialForProtectionSpace(space: NSURLProtectionSpace): NSURLCredential; cdecl;
    procedure removeCredential(credential: NSURLCredential; forProtectionSpace: NSURLProtectionSpace); cdecl;
    procedure setCredential(credential: NSURLCredential; forProtectionSpace: NSURLProtectionSpace); cdecl;
    procedure setDefaultCredential(credential: NSURLCredential; forProtectionSpace: NSURLProtectionSpace); cdecl;
  end;
  TNSURLCredentialStorage = class(TOCGenericImport<NSURLCredentialStorageClass, NSURLCredentialStorage>)  end;

  NSURLProtectionSpaceClass = interface(NSObjectClass)
    ['{5EC3B966-8944-441D-855C-8288207EEDA8}']
  end;
  NSURLProtectionSpace = interface(NSObject)
    ['{3B64DE60-2FE6-4131-B85B-623B0DE8A745}']
    function authenticationMethod: NSString; cdecl;
    function distinguishedNames: NSArray; cdecl;
    function host: NSString; cdecl;
    function initWithHost(host: NSString; port: NSInteger; protocol: NSString; realm: NSString; authenticationMethod: NSString): Pointer; cdecl;
    function isProxy: Boolean; cdecl;
    function port: NSInteger; cdecl;
    function protocol: NSString; cdecl;
    function proxyType: NSString; cdecl;
    function realm: NSString; cdecl;
    function receivesCredentialSecurely: Boolean; cdecl;
    function serverTrust: SecTrustRef; cdecl;
  end;
  TNSURLProtectionSpace = class(TOCGenericImport<NSURLProtectionSpaceClass, NSURLProtectionSpace>)  end;

  NSIndexPathClass = interface(NSObjectClass)
    ['{EB1F22E7-9955-4266-91E7-66ED41BE8B09}']
    {class} function indexPathWithIndex(index: NSUInteger): Pointer; cdecl;
    {class} function indexPathWithIndexes(indexes: NSUInteger; length: NSUInteger): Pointer; cdecl;
  end;
  NSIndexPath = interface(NSObject)
    ['{CF5A1A30-CA1B-4791-A6D2-20F2155883CA}']
    function compare(otherObject: NSIndexPath): NSComparisonResult; cdecl;
    procedure getIndexes(indexes: NSUInteger); cdecl;
    function indexAtPosition(position: NSUInteger): NSUInteger; cdecl;
    function indexPathByAddingIndex(index: NSUInteger): NSIndexPath; cdecl;
    function indexPathByRemovingLastIndex: NSIndexPath; cdecl;
    function initWithIndex(index: NSUInteger): Pointer; cdecl;
    function initWithIndexes(indexes: NSUInteger; length: NSUInteger): Pointer; cdecl;
    function length: NSUInteger; cdecl;
  end;
  TNSIndexPath = class(TOCGenericImport<NSIndexPathClass, NSIndexPath>)  end;

  NSIndexSetClass = interface(NSObjectClass)
    ['{B2F478A1-098B-4B54-8C14-5DAC46536411}']
    {class} function indexSet: Pointer; cdecl;
    {class} function indexSetWithIndex(value: NSUInteger): Pointer; cdecl;
    {class} function indexSetWithIndexesInRange(range: NSRange): Pointer; cdecl;
  end;
  NSIndexSet = interface(NSObject)
    ['{FDAC7E88-723F-4003-B83F-8910145956A4}']
    function containsIndex(value: NSUInteger): Boolean; cdecl;
    function containsIndexes(indexSet: NSIndexSet): Boolean; cdecl;
    function containsIndexesInRange(range: NSRange): Boolean; cdecl;
    function count: NSUInteger; cdecl;
    function countOfIndexesInRange(range: NSRange): NSUInteger; cdecl;
    function firstIndex: NSUInteger; cdecl;
    function getIndexes(indexBuffer: NSUInteger; maxCount: NSUInteger; inIndexRange: PNSRange): NSUInteger; cdecl;
    function indexGreaterThanIndex(value: NSUInteger): NSUInteger; cdecl;
    function indexGreaterThanOrEqualToIndex(value: NSUInteger): NSUInteger; cdecl;
    function indexLessThanIndex(value: NSUInteger): NSUInteger; cdecl;
    function indexLessThanOrEqualToIndex(value: NSUInteger): NSUInteger; cdecl;
    function init: Pointer; cdecl;
    function initWithIndex(value: NSUInteger): Pointer; cdecl;
    function initWithIndexSet(indexSet: NSIndexSet): Pointer; cdecl;
    function initWithIndexesInRange(range: NSRange): Pointer; cdecl;
    function intersectsIndexesInRange(range: NSRange): Boolean; cdecl;
    function isEqualToIndexSet(indexSet: NSIndexSet): Boolean; cdecl;
    function lastIndex: NSUInteger; cdecl;
  end;
  TNSIndexSet = class(TOCGenericImport<NSIndexSetClass, NSIndexSet>)  end;

  NSFileVersionClass = interface(NSObjectClass)
    ['{ABE6514E-360B-49BF-AC81-A7BB8B66E20D}']
    {class} function addVersionOfItemAtURL(url: NSURL; withContentsOfURL: NSURL; options: NSFileVersionAddingOptions; error: NSError): Pointer; cdecl;
    {class} function currentVersionOfItemAtURL(url: NSURL): Pointer; cdecl;
    {class} function otherVersionsOfItemAtURL(url: NSURL): NSArray; cdecl;
    {class} function removeOtherVersionsOfItemAtURL(url: NSURL; error: NSError): Boolean; cdecl;
    {class} function temporaryDirectoryURLForNewVersionOfItemAtURL(url: NSURL): NSURL; cdecl;
    {class} function unresolvedConflictVersionsOfItemAtURL(url: NSURL): NSArray; cdecl;
    {class} function versionOfItemAtURL(url: NSURL; forPersistentIdentifier: Pointer): Pointer; cdecl;
  end;
  NSFileVersion = interface(NSObject)
    ['{47278444-EC20-48C2-B775-4540BA872242}']
    function URL: NSURL; cdecl;
    function isConflict: Boolean; cdecl;
    function isDiscardable: Boolean; cdecl;
    function isResolved: Boolean; cdecl;
    function localizedName: NSString; cdecl;
    function localizedNameOfSavingComputer: NSString; cdecl;
    function modificationDate: NSDate; cdecl;
    function persistentIdentifier: Pointer; cdecl;
    function removeAndReturnError(outError: NSError): Boolean; cdecl;
    function replaceItemAtURL(url: NSURL; options: NSFileVersionReplacingOptions; error: NSError): NSURL; cdecl;
    procedure setDiscardable(discardable: Boolean); cdecl;
    procedure setResolved(resolved: Boolean); cdecl;
  end;
  TNSFileVersion = class(TOCGenericImport<NSFileVersionClass, NSFileVersion>)  end;

  NSEnumeratorClass = interface(NSObjectClass)
    ['{CA84BD67-2FEB-4589-B36E-082676B41F4B}']
  end;
  NSEnumerator = interface(NSObject)
    ['{25DFC98A-5BCC-41AC-AB84-1801E17E838D}']
    function allObjects: NSArray; cdecl;
    function nextObject: Pointer; cdecl;
  end;
  TNSEnumerator = class(TOCGenericImport<NSEnumeratorClass, NSEnumerator>)  end;

  NSErrorClass = interface(NSObjectClass)
    ['{97B5F2E2-DD78-4874-9EF6-D2BD111587E1}']
    {class} function errorWithDomain(domain: NSString; code: NSInteger; userInfo: NSDictionary): Pointer; cdecl;
  end;
  NSError = interface(NSObject)
    ['{8E8F832A-5F75-4F65-A18B-5A8E2F49A867}']
    function code: NSInteger; cdecl;
    function domain: NSString; cdecl;
    function helpAnchor: NSString; cdecl;
    function initWithDomain(domain: NSString; code: NSInteger; userInfo: NSDictionary): Pointer; cdecl;
    function localizedDescription: NSString; cdecl;
    function localizedFailureReason: NSString; cdecl;
    function localizedRecoveryOptions: NSArray; cdecl;
    function localizedRecoverySuggestion: NSString; cdecl;
    function recoveryAttempter: Pointer; cdecl;
    function userInfo: NSDictionary; cdecl;
  end;
  TNSError = class(TOCGenericImport<NSErrorClass, NSError>)  end;
  PNSError = ^NSError;

  NSURLRequestClass = interface(NSObjectClass)
    ['{A93A4D14-529E-41F0-86EC-B570715512BB}']
    {class} function requestWithURL(URL: NSURL): Pointer; cdecl; overload;
    {class} function requestWithURL(URL: NSURL; cachePolicy: NSURLRequestCachePolicy; timeoutInterval: NSTimeInterval): Pointer; cdecl; overload;
  end;
  NSURLRequest = interface(NSObject)
    ['{83575778-CDDD-41D2-A02D-B12358709400}']
    function HTTPBody: NSData; cdecl;
    function HTTPBodyStream: NSInputStream; cdecl;
    function HTTPMethod: NSString; cdecl;
    function HTTPShouldHandleCookies: Boolean; cdecl;
    function HTTPShouldUsePipelining: Boolean; cdecl;
    function URL: NSURL; cdecl;
    function allHTTPHeaderFields: NSDictionary; cdecl;
    function cachePolicy: NSURLRequestCachePolicy; cdecl;
    function initWithURL(URL: NSURL): Pointer; cdecl; overload;
    function initWithURL(URL: NSURL; cachePolicy: NSURLRequestCachePolicy; timeoutInterval: NSTimeInterval): Pointer; cdecl; overload;
    function mainDocumentURL: NSURL; cdecl;
    function networkServiceType: NSURLRequestNetworkServiceType; cdecl;
    function timeoutInterval: NSTimeInterval; cdecl;
    function valueForHTTPHeaderField(field: NSString): NSString; cdecl;
  end;
  TNSURLRequest = class(TOCGenericImport<NSURLRequestClass, NSURLRequest>)  end;

  NSDecimalNumberHandlerClass = interface(NSObjectClass)
    ['{51007C90-91B2-407C-ADB5-C0645C103D7C}']
    {class} function decimalNumberHandlerWithRoundingMode(roundingMode: NSRoundingMode; scale: Smallint; raiseOnExactness: Boolean; raiseOnOverflow: Boolean; raiseOnUnderflow: Boolean; raiseOnDivideByZero: Boolean): Pointer; cdecl;
    {class} function defaultDecimalNumberHandler: Pointer; cdecl;
  end;
  NSDecimalNumberHandler = interface(NSObject)
    ['{E2924457-A750-4174-A29B-1F9E685D06D3}']
    function initWithRoundingMode(roundingMode: NSRoundingMode; scale: Smallint; raiseOnExactness: Boolean; raiseOnOverflow: Boolean; raiseOnUnderflow: Boolean; raiseOnDivideByZero: Boolean): Pointer; cdecl;
  end;
  TNSDecimalNumberHandler = class(TOCGenericImport<NSDecimalNumberHandlerClass, NSDecimalNumberHandler>)  end;

  NSDictionaryClass = interface(NSObjectClass)
    ['{5B8960AD-1E66-4A78-AAF5-208CEB603583}']
    {class} function dictionary: Pointer; cdecl;
    {class} function dictionaryWithContentsOfFile(path: NSString): Pointer; cdecl;
    {class} function dictionaryWithContentsOfURL(url: NSURL): Pointer; cdecl;
    {class} function dictionaryWithDictionary(dict: NSDictionary): Pointer; cdecl;
    {class} function dictionaryWithObject(object_: Pointer; forKey: Pointer): Pointer; cdecl;
    {class} function dictionaryWithObjects(objects: NSArray; forKeys: NSArray): Pointer; cdecl; overload;
    {class} function dictionaryWithObjects(objects: Pointer; forKeys: Pointer; count: NSUInteger): Pointer; cdecl; overload;
    {class} function dictionaryWithObjectsAndKeys(firstObject: Pointer): Pointer; cdecl;
  end;
  NSDictionary = interface(NSObject)
    ['{9F4A8304-A061-4C6E-8A1C-62FFD42B76AE}']
    function allKeys: NSArray; cdecl;
    function allKeysForObject(anObject: Pointer): NSArray; cdecl;
    function allValues: NSArray; cdecl;
    function count: NSUInteger; cdecl;
    function description: NSString; cdecl;
    function descriptionInStringsFileFormat: NSString; cdecl;
    function descriptionWithLocale(locale: Pointer): NSString; cdecl; overload;
    function descriptionWithLocale(locale: Pointer; indent: NSUInteger): NSString; cdecl; overload;
    function fileCreationDate: NSDate; cdecl;
    function fileExtensionHidden: Boolean; cdecl;
    function fileGroupOwnerAccountID: NSNumber; cdecl;
    function fileGroupOwnerAccountName: NSString; cdecl;
    function fileHFSCreatorCode: OSType; cdecl;
    function fileHFSTypeCode: OSType; cdecl;
    function fileIsAppendOnly: Boolean; cdecl;
    function fileIsImmutable: Boolean; cdecl;
    function fileModificationDate: NSDate; cdecl;
    function fileOwnerAccountID: NSNumber; cdecl;
    function fileOwnerAccountName: NSString; cdecl;
    function filePosixPermissions: NSUInteger; cdecl;
    function fileSize: UInt64; cdecl;
    function fileSystemFileNumber: NSUInteger; cdecl;
    function fileSystemNumber: NSInteger; cdecl;
    function fileType: NSString; cdecl;
    procedure getObjects(objects: Pointer; andKeys: Pointer); cdecl;
    function initWithContentsOfFile(path: NSString): Pointer; cdecl;
    function initWithContentsOfURL(url: NSURL): Pointer; cdecl;
    function initWithDictionary(otherDictionary: NSDictionary): Pointer; cdecl; overload;
    function initWithDictionary(otherDictionary: NSDictionary; copyItems: Boolean): Pointer; cdecl; overload;
    function initWithObjects(objects: NSArray; forKeys: NSArray): Pointer; cdecl; overload;
    function initWithObjects(objects: Pointer; forKeys: Pointer; count: NSUInteger): Pointer; cdecl; overload;
    function initWithObjectsAndKeys(firstObject: Pointer): Pointer; cdecl;
    function isEqualToDictionary(otherDictionary: NSDictionary): Boolean; cdecl;
    function keyEnumerator: NSEnumerator; cdecl;
    function keysSortedByValueUsingSelector(comparator: SEL): NSArray; cdecl;
    function objectEnumerator: NSEnumerator; cdecl;
    function objectForKey(aKey: Pointer): Pointer; cdecl;
    function objectsForKeys(keys: NSArray; notFoundMarker: Pointer): NSArray; cdecl;
    function valueForKey(key: NSString): Pointer; cdecl;
    function writeToFile(path: NSString; atomically: Boolean): Boolean; cdecl;
    function writeToURL(url: NSURL; atomically: Boolean): Boolean; cdecl;
  end;
  TNSDictionary = class(TOCGenericImport<NSDictionaryClass, NSDictionary>)  end;

  NSFileHandleClass = interface(NSObjectClass)
    ['{F271DE7C-9A1A-4AAE-A2C1-3E21D318DCD1}']
    {class} function fileHandleForReadingAtPath(path: NSString): Pointer; cdecl;
    {class} function fileHandleForReadingFromURL(url: NSURL; error: NSError): Pointer; cdecl;
    {class} function fileHandleForUpdatingAtPath(path: NSString): Pointer; cdecl;
    {class} function fileHandleForUpdatingURL(url: NSURL; error: NSError): Pointer; cdecl;
    {class} function fileHandleForWritingAtPath(path: NSString): Pointer; cdecl;
    {class} function fileHandleForWritingToURL(url: NSURL; error: NSError): Pointer; cdecl;
    {class} function fileHandleWithNullDevice: Pointer; cdecl;
    {class} function fileHandleWithStandardError: Pointer; cdecl;
    {class} function fileHandleWithStandardInput: Pointer; cdecl;
    {class} function fileHandleWithStandardOutput: Pointer; cdecl;
  end;
  NSFileHandle = interface(NSObject)
    ['{742193ED-CEAD-4D44-B686-12EE2EB17BAE}']
    procedure acceptConnectionInBackgroundAndNotify; cdecl;
    procedure acceptConnectionInBackgroundAndNotifyForModes(modes: NSArray); cdecl;
    function availableData: NSData; cdecl;
    procedure closeFile; cdecl;
    function fileDescriptor: Integer; cdecl;
    function initWithFileDescriptor(fd: Integer): Pointer; cdecl; overload;
    function initWithFileDescriptor(fd: Integer; closeOnDealloc: Boolean): Pointer; cdecl; overload;
    function offsetInFile: UInt64; cdecl;
    function readDataOfLength(length: NSUInteger): NSData; cdecl;
    function readDataToEndOfFile: NSData; cdecl;
    procedure readInBackgroundAndNotify; cdecl;
    procedure readInBackgroundAndNotifyForModes(modes: NSArray); cdecl;
    procedure readToEndOfFileInBackgroundAndNotify; cdecl;
    procedure readToEndOfFileInBackgroundAndNotifyForModes(modes: NSArray); cdecl;
//    function readabilityHandler: void (^)(NSFileHandle ; cdecl;
    function seekToEndOfFile: UInt64; cdecl;
    procedure seekToFileOffset(offset: UInt64); cdecl;
    procedure synchronizeFile; cdecl;
    procedure truncateFileAtOffset(offset: UInt64); cdecl;
    procedure waitForDataInBackgroundAndNotify; cdecl;
    procedure waitForDataInBackgroundAndNotifyForModes(modes: NSArray); cdecl;
    procedure writeData(data: NSData); cdecl;
//    function writeabilityHandler: void (^)(NSFileHandle ; cdecl;
  end;
  TNSFileHandle = class(TOCGenericImport<NSFileHandleClass, NSFileHandle>)  end;

  NSFileManagerClass = interface(NSObjectClass)
    ['{007F0D12-E722-4DD0-8C0D-F609187C4E6F}']
    {class} function defaultManager: Pointer; cdecl;
  end;
  NSFileManager = interface(NSObject)
    ['{BB6643FC-20D8-41EF-881C-15326FD03C77}']
    function URLForDirectory(directory: NSSearchPathDirectory; inDomain: NSSearchPathDomainMask; appropriateForURL: NSURL; create: Boolean; error: NSError): NSURL; cdecl;
    function URLForPublishingUbiquitousItemAtURL(url: NSURL; expirationDate: NSDate; error: NSError): NSURL; cdecl;
    function URLForUbiquityContainerIdentifier(containerIdentifier: NSString): NSURL; cdecl;
    function URLsForDirectory(directory: NSSearchPathDirectory; inDomains: NSSearchPathDomainMask): NSArray; cdecl;
    function attributesOfFileSystemForPath(path: NSString; error: NSError): NSDictionary; cdecl;
    function attributesOfItemAtPath(path: NSString; error: NSError): NSDictionary; cdecl;
    function changeCurrentDirectoryPath(path: NSString): Boolean; cdecl;
    function changeFileAttributes(attributes: NSDictionary; atPath: NSString): Boolean; cdecl;
    function componentsToDisplayForPath(path: NSString): NSArray; cdecl;
    function contentsAtPath(path: NSString): NSData; cdecl;
    function contentsEqualAtPath(path1: NSString; andPath: NSString): Boolean; cdecl;
    function contentsOfDirectoryAtPath(path: NSString; error: NSError): NSArray; cdecl;
    function contentsOfDirectoryAtURL(url: NSURL; includingPropertiesForKeys: NSArray; options: NSDirectoryEnumerationOptions; error: NSError): NSArray; cdecl;
    function copyItemAtPath(srcPath: NSString; toPath: NSString; error: NSError): Boolean; cdecl;
    function copyItemAtURL(srcURL: NSURL; toURL: NSURL; error: NSError): Boolean; cdecl;
    function createDirectoryAtPath(path: NSString; attributes: NSDictionary): Boolean; cdecl; overload;
    function createDirectoryAtPath(path: NSString; withIntermediateDirectories: Boolean; attributes: NSDictionary; error: NSError): Boolean; cdecl; overload;
    function createDirectoryAtURL(url: NSURL; withIntermediateDirectories: Boolean; attributes: NSDictionary; error: NSError): Boolean; cdecl;
    function createFileAtPath(path: NSString; contents: NSData; attributes: NSDictionary): Boolean; cdecl;
    function createSymbolicLinkAtPath(path: NSString; pathContent: NSString): Boolean; cdecl; overload;
    function createSymbolicLinkAtPath(path: NSString; withDestinationPath: NSString; error: NSError): Boolean; cdecl; overload;
    function createSymbolicLinkAtURL(url: NSURL; withDestinationURL: NSURL; error: NSError): Boolean; cdecl;
    function currentDirectoryPath: NSString; cdecl;
    function delegate: Pointer; cdecl;
    function destinationOfSymbolicLinkAtPath(path: NSString; error: NSError): NSString; cdecl;
    function directoryContentsAtPath(path: NSString): NSArray; cdecl;
    function displayNameAtPath(path: NSString): NSString; cdecl;
    function enumeratorAtPath(path: NSString): NSDirectoryEnumerator; cdecl;
    function evictUbiquitousItemAtURL(url: NSURL; error: NSError): Boolean; cdecl;
    function fileAttributesAtPath(path: NSString; traverseLink: Boolean): NSDictionary; cdecl;
    function fileExistsAtPath(path: NSString): Boolean; cdecl; overload;
    function fileExistsAtPath(path: NSString; isDirectory: PBoolean): Boolean; cdecl; overload;
    function fileSystemAttributesAtPath(path: NSString): NSDictionary; cdecl;
    function fileSystemRepresentationWithPath(path: NSString): MarshaledAString; cdecl;
    function isDeletableFileAtPath(path: NSString): Boolean; cdecl;
    function isExecutableFileAtPath(path: NSString): Boolean; cdecl;
    function isReadableFileAtPath(path: NSString): Boolean; cdecl;
    function isUbiquitousItemAtURL(url: NSURL): Boolean; cdecl;
    function isWritableFileAtPath(path: NSString): Boolean; cdecl;
    function linkItemAtPath(srcPath: NSString; toPath: NSString; error: NSError): Boolean; cdecl;
    function linkItemAtURL(srcURL: NSURL; toURL: NSURL; error: NSError): Boolean; cdecl;
    function mountedVolumeURLsIncludingResourceValuesForKeys(propertyKeys: NSArray; options: NSVolumeEnumerationOptions): NSArray; cdecl;
    function moveItemAtPath(srcPath: NSString; toPath: NSString; error: NSError): Boolean; cdecl;
    function moveItemAtURL(srcURL: NSURL; toURL: NSURL; error: NSError): Boolean; cdecl;
    function pathContentOfSymbolicLinkAtPath(path: NSString): NSString; cdecl;
    function removeItemAtPath(path: NSString; error: NSError): Boolean; cdecl;
    function removeItemAtURL(URL: NSURL; error: NSError): Boolean; cdecl;
    function replaceItemAtURL(originalItemURL: NSURL; withItemAtURL: NSURL; backupItemName: NSString; options: NSFileManagerItemReplacementOptions; resultingItemURL: NSURL; error: NSError): Boolean; cdecl;
    function setAttributes(attributes: NSDictionary; ofItemAtPath: NSString; error: NSError): Boolean; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    function setUbiquitous(flag: Boolean; itemAtURL: NSURL; destinationURL: NSURL; error: NSError): Boolean; cdecl;
    function startDownloadingUbiquitousItemAtURL(url: NSURL; error: NSError): Boolean; cdecl;
    function stringWithFileSystemRepresentation(str: MarshaledAString; length: NSUInteger): NSString; cdecl;
    function subpathsAtPath(path: NSString): NSArray; cdecl;
    function subpathsOfDirectoryAtPath(path: NSString; error: NSError): NSArray; cdecl;
  end;
  TNSFileManager = class(TOCGenericImport<NSFileManagerClass, NSFileManager>)  end;

  NSFileCoordinatorClass = interface(NSObjectClass)
    ['{92A34809-475A-44F2-AD48-3DBC94E45C87}']
    {class} procedure addFilePresenter(filePresenter: Pointer); cdecl;
    {class} function filePresenters: NSArray; cdecl;
    {class} procedure removeFilePresenter(filePresenter: Pointer); cdecl;
  end;
  NSFileCoordinator = interface(NSObject)
    ['{6657485B-2F55-49FF-AC00-1CF5C79AA429}']
    procedure cancel; cdecl;
    function initWithFilePresenter(filePresenterOrNil: Pointer): Pointer; cdecl;
    procedure itemAtURL(oldURL: NSURL; didMoveToURL: NSURL); cdecl;
  end;
  TNSFileCoordinator = class(TOCGenericImport<NSFileCoordinatorClass, NSFileCoordinator>)  end;

  NSExceptionClass = interface(NSObjectClass)
    ['{01AA9836-6962-4514-8E8A-77A34DDD7305}']
    {class} function exceptionWithName(name: NSString; reason: NSString; userInfo: NSDictionary): Pointer; cdecl;
  end;
  NSException = interface(NSObject)
    ['{CA04D403-6602-4FE7-9763-498D837C49F7}']
    function callStackReturnAddresses: NSArray; cdecl;
    function callStackSymbols: NSArray; cdecl;
    function initWithName(aName: NSString; reason: NSString; userInfo: NSDictionary): Pointer; cdecl;
    function name: NSString; cdecl;
    function reason: NSString; cdecl;
    function userInfo: NSDictionary; cdecl;
  end;
  TNSException = class(TOCGenericImport<NSExceptionClass, NSException>)  end;

  NSExpressionClass = interface(NSObjectClass)
    ['{4C3D1539-EE0E-4C3F-B2B2-4C9301B0FDDE}']
    {class} function expressionForAggregate(subexpressions: NSArray): Pointer; cdecl;
    {class} function expressionForConstantValue(obj: Pointer): Pointer; cdecl;
    {class} function expressionForEvaluatedObject: Pointer; cdecl;
    {class} function expressionForFunction(name: NSString; arguments: NSArray): Pointer; cdecl; overload;
    {class} function expressionForFunction(target: NSExpression; selectorName: NSString; arguments: NSArray): Pointer; cdecl; overload;
    {class} function expressionForKeyPath(keyPath: NSString): Pointer; cdecl;
    {class} function expressionForSubquery(expression: NSExpression; usingIteratorVariable: NSString; predicate: Pointer): Pointer; cdecl;
    {class} function expressionForVariable(string_: NSString): Pointer; cdecl;
    {class} function expressionWithFormat(expressionFormat: NSString): Pointer; cdecl; overload;
    {class} function expressionWithFormat(expressionFormat: NSString; argumentArray: NSArray): Pointer; cdecl; overload;
  end;
  NSExpression = interface(NSObject)
    ['{A79DFF89-2D05-4A2B-9441-BEE45D9F708F}']
    function arguments: NSArray; cdecl;
    function collection: Pointer; cdecl;
    function constantValue: Pointer; cdecl;
    function expressionBlock: Pointer; cdecl;
    function expressionType: NSExpressionType; cdecl;
    function expressionValueWithObject(object_: Pointer; context: NSMutableDictionary): Pointer; cdecl;
    function initWithExpressionType(type_: NSExpressionType): Pointer; cdecl;
    function keyPath: NSString; cdecl;
    function leftExpression: NSExpression; cdecl;
    function operand: NSExpression; cdecl;
    function predicate: NSPredicate; cdecl;
    function rightExpression: NSExpression; cdecl;
    function variable: NSString; cdecl;
  end;
  TNSExpression = class(TOCGenericImport<NSExpressionClass, NSExpression>)  end;

  NSInvocationOperationClass = interface(NSOperationClass)
    ['{5C07C02B-E9D7-47C0-826E-B6A6D079EC75}']
  end;
  NSInvocationOperation = interface(NSOperation)
    ['{128CD074-6666-472E-97AF-EB05BB958BD3}']
    function initWithInvocation(inv: NSInvocation): Pointer; cdecl;
    function invocation: NSInvocation; cdecl;
    function result: Pointer; cdecl;
  end;
  TNSInvocationOperation = class(TOCGenericImport<NSInvocationOperationClass, NSInvocationOperation>)  end;

  NSInputStreamClass = interface(NSStreamClass)
    ['{16A102FC-917E-4EF6-A142-8321BB2F8B19}']
    {class} function inputStreamWithData(data: NSData): Pointer; cdecl;
    {class} function inputStreamWithFileAtPath(path: NSString): Pointer; cdecl;
    {class} function inputStreamWithURL(url: NSURL): Pointer; cdecl;
  end;
  NSInputStream = interface(NSStream)
    ['{978FB0D8-3E75-4980-973D-3F6967A1D975}']
    function getBuffer(buffer: PByte; length: NSUInteger): Boolean; cdecl;
    function hasBytesAvailable: Boolean; cdecl;
    function initWithData(data: NSData): Pointer; cdecl;
    function initWithFileAtPath(path: NSString): Pointer; cdecl;
    function initWithURL(url: NSURL): Pointer; cdecl;
    function read(buffer: PByte; maxLength: NSUInteger): NSInteger; cdecl;
  end;
  TNSInputStream = class(TOCGenericImport<NSInputStreamClass, NSInputStream>)  end;

  NSHTTPURLResponseClass = interface(NSURLResponseClass)
    ['{EE289328-43FD-4F16-A662-B9E1E3636A1C}']
    {class} function localizedStringForStatusCode(statusCode: NSInteger): NSString; cdecl;
  end;
  NSHTTPURLResponse = interface(NSURLResponse)
    ['{C413D5CD-C39F-468C-BBB0-6435B74E2C60}']
    function allHeaderFields: NSDictionary; cdecl;
    function initWithURL(url: NSURL; statusCode: NSInteger; HTTPVersion: NSString; headerFields: NSDictionary): Pointer; cdecl;
    function statusCode: NSInteger; cdecl;
  end;
  TNSHTTPURLResponse = class(TOCGenericImport<NSHTTPURLResponseClass, NSHTTPURLResponse>)  end;

  NSMachPortClass = interface(NSPortClass)
    ['{5DE1035F-E455-43C9-A2BF-2A5A99F7538F}']
    {class} function portWithMachPort(machPort: Longword): NSPort; cdecl; overload;
    {class} function portWithMachPort(machPort: Longword; options: NSUInteger): NSPort; cdecl; overload;
  end;
  NSMachPort = interface(NSPort)
    ['{D1FC873A-2A57-48C8-A55A-E85742270A7F}']
    function delegate: Pointer; cdecl;
    function initWithMachPort(machPort: Longword): Pointer; cdecl; overload;
    function initWithMachPort(machPort: Longword; options: NSUInteger): Pointer; cdecl; overload;
    function machPort: Longword; cdecl;
    procedure removeFromRunLoop(runLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure scheduleInRunLoop(runLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure setDelegate(anObject: Pointer); cdecl;
  end;
  TNSMachPort = class(TOCGenericImport<NSMachPortClass, NSMachPort>)  end;

  NSKeyedUnarchiverClass = interface(NSCoderClass)
    ['{B67F9B9F-FF05-4F03-99CE-136EA85ECE07}']
    {class} procedure setClass(cls: Pointer; forClassName: NSString); cdecl; overload;
    {class} function unarchiveObjectWithData(data: NSData): Pointer; cdecl;
    {class} function unarchiveObjectWithFile(path: NSString): Pointer; cdecl;
  end;
  NSKeyedUnarchiver = interface(NSCoder)
    ['{194D4B2F-5496-42BB-B674-73BA86288A22}']
    function containsValueForKey(key: NSString): Boolean; cdecl;
    function decodeBoolForKey(key: NSString): Boolean; cdecl;
    function decodeBytesForKey(key: NSString; returnedLength: NSUInteger): PByte; cdecl;
    function decodeDoubleForKey(key: NSString): double; cdecl;
    function decodeFloatForKey(key: NSString): Single; cdecl;
    function decodeInt32ForKey(key: NSString): Integer; cdecl;
    function decodeInt64ForKey(key: NSString): Int64; cdecl;
    function decodeIntForKey(key: NSString): Integer; cdecl;
    function decodeObjectForKey(key: NSString): Pointer; cdecl;
    function delegate: Pointer; cdecl;
    procedure finishDecoding; cdecl;
    function initForReadingWithData(data: NSData): Pointer; cdecl;
    procedure setClass(cls: Pointer; forClassName: NSString); cdecl; overload;
    procedure setDelegate(delegate: Pointer); cdecl;
  end;
  TNSKeyedUnarchiver = class(TOCGenericImport<NSKeyedUnarchiverClass, NSKeyedUnarchiver>)  end;

  NSKeyedArchiverClass = interface(NSCoderClass)
    ['{DF9BC570-C5E5-4CB8-B23F-CC3D45CD7826}']
    {class} function archiveRootObject(rootObject: Pointer; toFile: NSString): Boolean; cdecl;
    {class} function archivedDataWithRootObject(rootObject: Pointer): NSData; cdecl;
    {class} function classNameForClass(cls: Pointer): NSString; cdecl; overload;
    {class} procedure setClassName(codedName: NSString; forClass: Pointer); cdecl; overload;
  end;
  NSKeyedArchiver = interface(NSCoder)
    ['{BD14DE95-B9E3-4753-B7AC-F471B533D842}']
    function classNameForClass(cls: Pointer): NSString; cdecl; overload;
    function delegate: Pointer; cdecl;
    procedure encodeBool(boolv: Boolean; forKey: NSString); cdecl;
    procedure encodeBytes(bytesp: PByte; length: NSUInteger; forKey: NSString); cdecl;
    procedure encodeConditionalObject(objv: Pointer; forKey: NSString); cdecl;
    procedure encodeDouble(realv: double; forKey: NSString); cdecl;
    procedure encodeFloat(realv: Single; forKey: NSString); cdecl;
    procedure encodeInt32(intv: Integer; forKey: NSString); cdecl;
    procedure encodeInt64(intv: Int64; forKey: NSString); cdecl;
    procedure encodeInt(intv: Integer; forKey: NSString); cdecl;
    procedure encodeObject(objv: Pointer; forKey: NSString); cdecl;
    procedure finishEncoding; cdecl;
    function initForWritingWithMutableData(data: NSMutableData): Pointer; cdecl;
    function outputFormat: NSPropertyListFormat; cdecl;
    procedure setClassName(codedName: NSString; forClass: Pointer); cdecl; overload;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setOutputFormat(format: NSPropertyListFormat); cdecl;
  end;
  TNSKeyedArchiver = class(TOCGenericImport<NSKeyedArchiverClass, NSKeyedArchiver>)  end;

  NSCompoundPredicateClass = interface(NSPredicateClass)
    ['{E4E1609D-295E-49FE-804E-EB0EDA50C192}']
    {class} function andPredicateWithSubpredicates(subpredicates: NSArray): NSPredicate; cdecl;
    {class} function notPredicateWithSubpredicate(predicate: NSPredicate): NSPredicate; cdecl;
    {class} function orPredicateWithSubpredicates(subpredicates: NSArray): NSPredicate; cdecl;
  end;
  NSCompoundPredicate = interface(NSPredicate)
    ['{F57072CB-F2E2-4182-882B-EE23D5D7123E}']
    function compoundPredicateType: NSCompoundPredicateType; cdecl;
    function initWithType(type_: NSCompoundPredicateType; subpredicates: NSArray): Pointer; cdecl;
    function subpredicates: NSArray; cdecl;
  end;
  TNSCompoundPredicate = class(TOCGenericImport<NSCompoundPredicateClass, NSCompoundPredicate>)  end;

  NSComparisonPredicateClass = interface(NSPredicateClass)
    ['{786AB822-4B8B-4070-BF93-5D11B68472C9}']
    {class} function predicateWithLeftExpression(lhs: NSExpression; rightExpression: NSExpression; customSelector: SEL): NSPredicate; cdecl; overload;
  end;
  NSComparisonPredicate = interface(NSPredicate)
    ['{E5909A18-ED9B-4255-8CED-8455ECD28843}']
    function comparisonPredicateModifier: NSComparisonPredicateModifier; cdecl;
    function customSelector: SEL; cdecl;
    function initWithLeftExpression(lhs: NSExpression; rightExpression: NSExpression; customSelector: SEL): Pointer; cdecl; overload;
    function leftExpression: NSExpression; cdecl;
    function options: NSComparisonPredicateOptions; cdecl;
    function predicateOperatorType: NSPredicateOperatorType; cdecl;
    function rightExpression: NSExpression; cdecl;
  end;
  TNSComparisonPredicate = class(TOCGenericImport<NSComparisonPredicateClass, NSComparisonPredicate>)  end;

  NSBlockOperationClass = interface(NSOperationClass)
    ['{44B31923-9CB8-4C4E-B789-CDCC3954E0B7}']
  end;
  NSBlockOperation = interface(NSOperation)
    ['{2491EBFA-C43F-4AC6-AA82-D1679E0760DC}']
    function executionBlocks: NSArray; cdecl;
  end;
  TNSBlockOperation = class(TOCGenericImport<NSBlockOperationClass, NSBlockOperation>)  end;

  NSDirectoryEnumeratorClass = interface(NSEnumeratorClass)
    ['{35015557-9EC0-4C85-955C-7B36FFC16CE0}']
  end;
  NSDirectoryEnumerator = interface(NSEnumerator)
    ['{6CE6B7F6-ECA3-43A9-8495-94D2270960A3}']
    function directoryAttributes: NSDictionary; cdecl;
    function fileAttributes: NSDictionary; cdecl;
    function level: NSUInteger; cdecl;
    procedure skipDescendants; cdecl;
    procedure skipDescendents; cdecl;
  end;
  TNSDirectoryEnumerator = class(TOCGenericImport<NSDirectoryEnumeratorClass, NSDirectoryEnumerator>)  end;

  NSDateFormatterClass = interface(NSFormatterClass)
    ['{7D7FC6A9-97FF-4CEA-9B2F-B36971A14C42}']
    {class} function dateFormatFromTemplate(tmplate: NSString; options: NSUInteger; locale: NSLocale): NSString; cdecl;
    {class} function defaultFormatterBehavior: NSDateFormatterBehavior; cdecl;
    {class} function localizedStringFromDate(date: NSDate; dateStyle: NSDateFormatterStyle; timeStyle: NSDateFormatterStyle): NSString; cdecl;
    {class} procedure setDefaultFormatterBehavior(behavior: NSDateFormatterBehavior); cdecl;
  end;
  NSDateFormatter = interface(NSFormatter)
    ['{0CCF42E5-243E-48DD-959C-C35E0AAC4A10}']
    function AMSymbol: NSString; cdecl;
    function PMSymbol: NSString; cdecl;
    function calendar: NSCalendar; cdecl;
    function dateFormat: NSString; cdecl;
    function dateFromString(string_: NSString): NSDate; cdecl;
    function dateStyle: NSDateFormatterStyle; cdecl;
    function defaultDate: NSDate; cdecl;
    function doesRelativeDateFormatting: Boolean; cdecl;
    function eraSymbols: NSArray; cdecl;
    function formatterBehavior: NSDateFormatterBehavior; cdecl;
    function generatesCalendarDates: Boolean; cdecl;
    function getObjectValue(obj: Pointer; forString: NSString; range: PNSRange; error: NSError): Boolean; cdecl;
    function gregorianStartDate: NSDate; cdecl;
    function isLenient: Boolean; cdecl;
    function locale: NSLocale; cdecl;
    function longEraSymbols: NSArray; cdecl;
    function monthSymbols: NSArray; cdecl;
    function quarterSymbols: NSArray; cdecl;
    procedure setAMSymbol(string_: NSString); cdecl;
    procedure setCalendar(calendar: NSCalendar); cdecl;
    procedure setDateFormat(string_: NSString); cdecl;
    procedure setDateStyle(style: NSDateFormatterStyle); cdecl;
    procedure setDefaultDate(date: NSDate); cdecl;
    procedure setDoesRelativeDateFormatting(b: Boolean); cdecl;
    procedure setEraSymbols(array_: NSArray); cdecl;
    procedure setFormatterBehavior(behavior: NSDateFormatterBehavior); cdecl;
    procedure setGeneratesCalendarDates(b: Boolean); cdecl;
    procedure setGregorianStartDate(date: NSDate); cdecl;
    procedure setLenient(b: Boolean); cdecl;
    procedure setLocale(locale: NSLocale); cdecl;
    procedure setLongEraSymbols(array_: NSArray); cdecl;
    procedure setMonthSymbols(array_: NSArray); cdecl;
    procedure setPMSymbol(string_: NSString); cdecl;
    procedure setQuarterSymbols(array_: NSArray); cdecl;
    procedure setShortMonthSymbols(array_: NSArray); cdecl;
    procedure setShortQuarterSymbols(array_: NSArray); cdecl;
    procedure setShortStandaloneMonthSymbols(array_: NSArray); cdecl;
    procedure setShortStandaloneQuarterSymbols(array_: NSArray); cdecl;
    procedure setShortStandaloneWeekdaySymbols(array_: NSArray); cdecl;
    procedure setShortWeekdaySymbols(array_: NSArray); cdecl;
    procedure setStandaloneMonthSymbols(array_: NSArray); cdecl;
    procedure setStandaloneQuarterSymbols(array_: NSArray); cdecl;
    procedure setStandaloneWeekdaySymbols(array_: NSArray); cdecl;
    procedure setTimeStyle(style: NSDateFormatterStyle); cdecl;
    procedure setTimeZone(tz: NSTimeZone); cdecl;
    procedure setTwoDigitStartDate(date: NSDate); cdecl;
    procedure setVeryShortMonthSymbols(array_: NSArray); cdecl;
    procedure setVeryShortStandaloneMonthSymbols(array_: NSArray); cdecl;
    procedure setVeryShortStandaloneWeekdaySymbols(array_: NSArray); cdecl;
    procedure setVeryShortWeekdaySymbols(array_: NSArray); cdecl;
    procedure setWeekdaySymbols(array_: NSArray); cdecl;
    function shortMonthSymbols: NSArray; cdecl;
    function shortQuarterSymbols: NSArray; cdecl;
    function shortStandaloneMonthSymbols: NSArray; cdecl;
    function shortStandaloneQuarterSymbols: NSArray; cdecl;
    function shortStandaloneWeekdaySymbols: NSArray; cdecl;
    function shortWeekdaySymbols: NSArray; cdecl;
    function standaloneMonthSymbols: NSArray; cdecl;
    function standaloneQuarterSymbols: NSArray; cdecl;
    function standaloneWeekdaySymbols: NSArray; cdecl;
    function stringFromDate(date: NSDate): NSString; cdecl;
    function timeStyle: NSDateFormatterStyle; cdecl;
    function timeZone: NSTimeZone; cdecl;
    function twoDigitStartDate: NSDate; cdecl;
    function veryShortMonthSymbols: NSArray; cdecl;
    function veryShortStandaloneMonthSymbols: NSArray; cdecl;
    function veryShortStandaloneWeekdaySymbols: NSArray; cdecl;
    function veryShortWeekdaySymbols: NSArray; cdecl;
    function weekdaySymbols: NSArray; cdecl;
  end;
  TNSDateFormatter = class(TOCGenericImport<NSDateFormatterClass, NSDateFormatter>)  end;

  NSDataDetectorClass = interface(NSRegularExpressionClass)
    ['{098B3580-09D4-4CAC-A909-ADC38FE7F221}']
    {class} function dataDetectorWithTypes(checkingTypes: NSTextCheckingTypes; error: NSError): Pointer; cdecl;
  end;
  NSDataDetector = interface(NSRegularExpression)
    ['{FF837F9D-876C-4595-85E9-D67A8E2F46D4}']
    function checkingTypes: NSTextCheckingTypes; cdecl;
    function initWithTypes(checkingTypes: NSTextCheckingTypes; error: NSError): Pointer; cdecl;
  end;
  TNSDataDetector = class(TOCGenericImport<NSDataDetectorClass, NSDataDetector>)  end;

  NSMutableArrayClass = interface(NSArrayClass)
    ['{553484FC-06B7-42B8-AE42-7B521728E9A6}']
    {class} function arrayWithCapacity(numItems: NSUInteger): Pointer; cdecl;
  end;
  NSMutableArray = interface(NSArray)
    ['{F0B9F97E-F33A-4A1A-AD8F-920C03FDD3B7}']
    procedure addObject(anObject: Pointer); cdecl;
    procedure addObjectsFromArray(otherArray: NSArray); cdecl;
    procedure exchangeObjectAtIndex(idx1: NSUInteger; withObjectAtIndex: NSUInteger); cdecl;
    procedure filterUsingPredicate(predicate: NSPredicate); cdecl;
    function initWithCapacity(numItems: NSUInteger): Pointer; cdecl;
    procedure insertObject(anObject: Pointer; atIndex: NSUInteger); cdecl;
    procedure insertObjects(objects: NSArray; atIndexes: NSIndexSet); cdecl;
    procedure removeAllObjects; cdecl;
    procedure removeLastObject; cdecl;
    procedure removeObject(anObject: Pointer); cdecl; overload;
    procedure removeObject(anObject: Pointer; inRange: NSRange); cdecl; overload;
    procedure removeObjectAtIndex(index: NSUInteger); cdecl;
    procedure removeObjectIdenticalTo(anObject: Pointer); cdecl; overload;
    procedure removeObjectIdenticalTo(anObject: Pointer; inRange: NSRange); cdecl; overload;
    procedure removeObjectsAtIndexes(indexes: NSIndexSet); cdecl;
    procedure removeObjectsFromIndices(indices: NSUInteger; numIndices: NSUInteger); cdecl;
    procedure removeObjectsInArray(otherArray: NSArray); cdecl;
    procedure removeObjectsInRange(range: NSRange); cdecl;
    procedure replaceObjectAtIndex(index: NSUInteger; withObject: Pointer); cdecl;
    procedure replaceObjectsAtIndexes(indexes: NSIndexSet; withObjects: NSArray); cdecl;
    procedure replaceObjectsInRange(range: NSRange; withObjectsFromArray: NSArray); cdecl; overload;
    procedure setArray(otherArray: NSArray); cdecl;
    procedure sortUsingDescriptors(sortDescriptors: NSArray); cdecl;
    procedure sortUsingSelector(comparator: SEL); cdecl;
  end;
  TNSMutableArray = class(TOCGenericImport<NSMutableArrayClass, NSMutableArray>)  end;

  NSMutableURLRequestClass = interface(NSURLRequestClass)
    ['{34615854-F0B3-45A1-BBED-F5C44E9E7D56}']
  end;
  NSMutableURLRequest = interface(NSURLRequest)
    ['{49BEA692-B5DD-4469-90EE-EE46801F5148}']
    procedure addValue(value: NSString; forHTTPHeaderField: NSString); cdecl;
    procedure setAllHTTPHeaderFields(headerFields: NSDictionary); cdecl;
    procedure setCachePolicy(policy: NSURLRequestCachePolicy); cdecl;
    procedure setHTTPBody(data: NSData); cdecl;
    procedure setHTTPBodyStream(inputStream: NSInputStream); cdecl;
    procedure setHTTPMethod(method: NSString); cdecl;
    procedure setHTTPShouldHandleCookies(should: Boolean); cdecl;
    procedure setHTTPShouldUsePipelining(shouldUsePipelining: Boolean); cdecl;
    procedure setMainDocumentURL(URL: NSURL); cdecl;
    procedure setNetworkServiceType(networkServiceType: NSURLRequestNetworkServiceType); cdecl;
    procedure setTimeoutInterval(seconds: NSTimeInterval); cdecl;
    procedure setURL(URL: NSURL); cdecl;
    procedure setValue(value: NSString; forHTTPHeaderField: NSString); cdecl;
  end;
  TNSMutableURLRequest = class(TOCGenericImport<NSMutableURLRequestClass, NSMutableURLRequest>)  end;

  NSMutableStringClass = interface(NSStringClass)
    ['{5CBD1AF1-C96E-467F-82CC-3B111FA880F9}']
    {class} function stringWithCapacity(capacity: NSUInteger): Pointer; cdecl;
  end;
  NSMutableString = interface(NSString)
    ['{0DE0FF9A-B0CD-4448-8262-4FACD281E4DB}']
    procedure appendFormat(format: NSString); cdecl;
    procedure appendString(aString: NSString); cdecl;
    procedure deleteCharactersInRange(range: NSRange); cdecl;
    function initWithCapacity(capacity: NSUInteger): Pointer; cdecl;
    procedure insertString(aString: NSString; atIndex: NSUInteger); cdecl;
    procedure replaceCharactersInRange(range: NSRange; withString: NSString); cdecl;
    function replaceOccurrencesOfString(target: NSString; withString: NSString; options: NSStringCompareOptions; range: NSRange): NSUInteger; cdecl;
    procedure setString(aString: NSString); cdecl;
  end;
  TNSMutableString = class(TOCGenericImport<NSMutableStringClass, NSMutableString>)  end;

  NSMutableSetClass = interface(NSSetClass)
    ['{DA83FDA5-F35B-4EB8-B259-6D211349AF37}']
    {class} function setWithCapacity(numItems: NSUInteger): Pointer; cdecl;
  end;
  NSMutableSet = interface(NSSet)
    ['{A99715A3-693D-4FBF-8374-3580A703A5C1}']
    procedure addObject(object_: Pointer); cdecl;
    procedure addObjectsFromArray(array_: NSArray); cdecl;
    procedure filterUsingPredicate(predicate: NSPredicate); cdecl;
    function initWithCapacity(numItems: NSUInteger): Pointer; cdecl;
    procedure intersectSet(otherSet: NSSet); cdecl;
    procedure minusSet(otherSet: NSSet); cdecl;
    procedure removeAllObjects; cdecl;
    procedure removeObject(object_: Pointer); cdecl;
    procedure setSet(otherSet: NSSet); cdecl;
    procedure unionSet(otherSet: NSSet); cdecl;
  end;
  TNSMutableSet = class(TOCGenericImport<NSMutableSetClass, NSMutableSet>)  end;

  NSOutputStreamClass = interface(NSStreamClass)
    ['{8503B038-20EB-4F49-B36D-665782C7D05F}']
    {class} function outputStreamToBuffer(buffer: PByte; capacity: NSUInteger): Pointer; cdecl;
    {class} function outputStreamToFileAtPath(path: NSString; append: Boolean): Pointer; cdecl;
    {class} function outputStreamToMemory: Pointer; cdecl;
    {class} function outputStreamWithURL(url: NSURL; append: Boolean): Pointer; cdecl;
  end;
  NSOutputStream = interface(NSStream)
    ['{A76DB431-5E26-4853-B0F1-095363B009F1}']
    function hasSpaceAvailable: Boolean; cdecl;
    function initToBuffer(buffer: PByte; capacity: NSUInteger): Pointer; cdecl;
    function initToFileAtPath(path: NSString; append: Boolean): Pointer; cdecl;
    function initToMemory: Pointer; cdecl;
    function initWithURL(url: NSURL; append: Boolean): Pointer; cdecl;
    function write(buffer: PByte; maxLength: NSUInteger): NSInteger; cdecl;
  end;
  TNSOutputStream = class(TOCGenericImport<NSOutputStreamClass, NSOutputStream>)  end;

  NSNumberFormatterClass = interface(NSFormatterClass)
    ['{7943B454-721E-4A57-AD86-D2DC25D68D2A}']
    {class} function defaultFormatterBehavior: NSNumberFormatterBehavior; cdecl;
    {class} function localizedStringFromNumber(num: NSNumber; numberStyle: NSNumberFormatterStyle): NSString; cdecl;
    {class} procedure setDefaultFormatterBehavior(behavior: NSNumberFormatterBehavior); cdecl;
  end;
  NSNumberFormatter = interface(NSFormatter)
    ['{D4C838DB-7233-40DA-8D0A-8FA4D8384A0F}']
    function allowsFloats: Boolean; cdecl;
    function alwaysShowsDecimalSeparator: Boolean; cdecl;
    function currencyCode: NSString; cdecl;
    function currencyDecimalSeparator: NSString; cdecl;
    function currencyGroupingSeparator: NSString; cdecl;
    function currencySymbol: NSString; cdecl;
    function decimalSeparator: NSString; cdecl;
    function exponentSymbol: NSString; cdecl;
    function formatWidth: NSUInteger; cdecl;
    function formatterBehavior: NSNumberFormatterBehavior; cdecl;
    function generatesDecimalNumbers: Boolean; cdecl;
    function getObjectValue(obj: Pointer; forString: NSString; range: PNSRange; error: NSError): Boolean; cdecl;
    function groupingSeparator: NSString; cdecl;
    function groupingSize: NSUInteger; cdecl;
    function internationalCurrencySymbol: NSString; cdecl;
    function isLenient: Boolean; cdecl;
    function isPartialStringValidationEnabled: Boolean; cdecl;
    function locale: NSLocale; cdecl;
    function maximum: NSNumber; cdecl;
    function maximumFractionDigits: NSUInteger; cdecl;
    function maximumIntegerDigits: NSUInteger; cdecl;
    function maximumSignificantDigits: NSUInteger; cdecl;
    function minimum: NSNumber; cdecl;
    function minimumFractionDigits: NSUInteger; cdecl;
    function minimumIntegerDigits: NSUInteger; cdecl;
    function minimumSignificantDigits: NSUInteger; cdecl;
    function minusSign: NSString; cdecl;
    function multiplier: NSNumber; cdecl;
    function negativeFormat: NSString; cdecl;
    function negativeInfinitySymbol: NSString; cdecl;
    function negativePrefix: NSString; cdecl;
    function negativeSuffix: NSString; cdecl;
    function nilSymbol: NSString; cdecl;
    function notANumberSymbol: NSString; cdecl;
    function numberFromString(string_: NSString): NSNumber; cdecl;
    function numberStyle: NSNumberFormatterStyle; cdecl;
    function paddingCharacter: NSString; cdecl;
    function paddingPosition: NSNumberFormatterPadPosition; cdecl;
    function perMillSymbol: NSString; cdecl;
    function percentSymbol: NSString; cdecl;
    function plusSign: NSString; cdecl;
    function positiveFormat: NSString; cdecl;
    function positiveInfinitySymbol: NSString; cdecl;
    function positivePrefix: NSString; cdecl;
    function positiveSuffix: NSString; cdecl;
    function roundingIncrement: NSNumber; cdecl;
    function roundingMode: NSNumberFormatterRoundingMode; cdecl;
    function secondaryGroupingSize: NSUInteger; cdecl;
    procedure setAllowsFloats(flag: Boolean); cdecl;
    procedure setAlwaysShowsDecimalSeparator(b: Boolean); cdecl;
    procedure setCurrencyCode(string_: NSString); cdecl;
    procedure setCurrencyDecimalSeparator(string_: NSString); cdecl;
    procedure setCurrencyGroupingSeparator(string_: NSString); cdecl;
    procedure setCurrencySymbol(string_: NSString); cdecl;
    procedure setDecimalSeparator(string_: NSString); cdecl;
    procedure setExponentSymbol(string_: NSString); cdecl;
    procedure setFormatWidth(number: NSUInteger); cdecl;
    procedure setFormatterBehavior(behavior: NSNumberFormatterBehavior); cdecl;
    procedure setGeneratesDecimalNumbers(b: Boolean); cdecl;
    procedure setGroupingSeparator(string_: NSString); cdecl;
    procedure setGroupingSize(number: NSUInteger); cdecl;
    procedure setInternationalCurrencySymbol(string_: NSString); cdecl;
    procedure setLenient(b: Boolean); cdecl;
    procedure setLocale(locale: NSLocale); cdecl;
    procedure setMaximum(number: NSNumber); cdecl;
    procedure setMaximumFractionDigits(number: NSUInteger); cdecl;
    procedure setMaximumIntegerDigits(number: NSUInteger); cdecl;
    procedure setMaximumSignificantDigits(number: NSUInteger); cdecl;
    procedure setMinimum(number: NSNumber); cdecl;
    procedure setMinimumFractionDigits(number: NSUInteger); cdecl;
    procedure setMinimumIntegerDigits(number: NSUInteger); cdecl;
    procedure setMinimumSignificantDigits(number: NSUInteger); cdecl;
    procedure setMinusSign(string_: NSString); cdecl;
    procedure setMultiplier(number: NSNumber); cdecl;
    procedure setNegativeFormat(format: NSString); cdecl;
    procedure setNegativeInfinitySymbol(string_: NSString); cdecl;
    procedure setNegativePrefix(string_: NSString); cdecl;
    procedure setNegativeSuffix(string_: NSString); cdecl;
    procedure setNilSymbol(string_: NSString); cdecl;
    procedure setNotANumberSymbol(string_: NSString); cdecl;
    procedure setNumberStyle(style: NSNumberFormatterStyle); cdecl;
    procedure setPaddingCharacter(string_: NSString); cdecl;
    procedure setPaddingPosition(position: NSNumberFormatterPadPosition); cdecl;
    procedure setPartialStringValidationEnabled(b: Boolean); cdecl;
    procedure setPerMillSymbol(string_: NSString); cdecl;
    procedure setPercentSymbol(string_: NSString); cdecl;
    procedure setPlusSign(string_: NSString); cdecl;
    procedure setPositiveFormat(format: NSString); cdecl;
    procedure setPositiveInfinitySymbol(string_: NSString); cdecl;
    procedure setPositivePrefix(string_: NSString); cdecl;
    procedure setPositiveSuffix(string_: NSString); cdecl;
    procedure setRoundingIncrement(number: NSNumber); cdecl;
    procedure setRoundingMode(mode: NSNumberFormatterRoundingMode); cdecl;
    procedure setSecondaryGroupingSize(number: NSUInteger); cdecl;
    procedure setTextAttributesForNegativeInfinity(newAttributes: NSDictionary); cdecl;
    procedure setTextAttributesForNegativeValues(newAttributes: NSDictionary); cdecl;
    procedure setTextAttributesForNil(newAttributes: NSDictionary); cdecl;
    procedure setTextAttributesForNotANumber(newAttributes: NSDictionary); cdecl;
    procedure setTextAttributesForPositiveInfinity(newAttributes: NSDictionary); cdecl;
    procedure setTextAttributesForPositiveValues(newAttributes: NSDictionary); cdecl;
    procedure setTextAttributesForZero(newAttributes: NSDictionary); cdecl;
    procedure setUsesGroupingSeparator(b: Boolean); cdecl;
    procedure setUsesSignificantDigits(b: Boolean); cdecl;
    procedure setZeroSymbol(string_: NSString); cdecl;
    function stringFromNumber(number: NSNumber): NSString; cdecl;
    function textAttributesForNegativeInfinity: NSDictionary; cdecl;
    function textAttributesForNegativeValues: NSDictionary; cdecl;
    function textAttributesForNil: NSDictionary; cdecl;
    function textAttributesForNotANumber: NSDictionary; cdecl;
    function textAttributesForPositiveInfinity: NSDictionary; cdecl;
    function textAttributesForPositiveValues: NSDictionary; cdecl;
    function textAttributesForZero: NSDictionary; cdecl;
    function usesGroupingSeparator: Boolean; cdecl;
    function usesSignificantDigits: Boolean; cdecl;
    function zeroSymbol: NSString; cdecl;
  end;
  TNSNumberFormatter = class(TOCGenericImport<NSNumberFormatterClass, NSNumberFormatter>)  end;

  NSNumberClass = interface(NSValueClass)
    ['{82392D79-32AF-4380-9389-667299F94C07}']
    {class} function numberWithBool(value: Boolean): Pointer; cdecl;
    {class} function numberWithChar(value: char): Pointer; cdecl;
    {class} function numberWithDouble(value: double): Pointer; cdecl;
    {class} function numberWithFloat(value: Single): Pointer; cdecl;
    {class} function numberWithInt(value: Integer): Pointer; cdecl;
    {class} function numberWithInteger(value: NSInteger): Pointer; cdecl;
    {class} function numberWithLong(value: Longint): Pointer; cdecl;
    {class} function numberWithLongLong(value: Int64): Pointer; cdecl;
    {class} function numberWithShort(value: Smallint): Pointer; cdecl;
    {class} function numberWithUnsignedChar(value: Byte): Pointer; cdecl;
    {class} function numberWithUnsignedInt(value: Longword): Pointer; cdecl;
    {class} function numberWithUnsignedInteger(value: NSUInteger): Pointer; cdecl;
    {class} function numberWithUnsignedLong(value: Longword): Pointer; cdecl;
    {class} function numberWithUnsignedLongLong(value: UInt64): Pointer; cdecl;
    {class} function numberWithUnsignedShort(value: Word): Pointer; cdecl;
  end;
  NSNumber = interface(NSValue)
    ['{547076CE-9409-4389-B449-47DA1D9718EF}']
    function boolValue: Boolean; cdecl;
    function charValue: char; cdecl;
    function compare(otherNumber: NSNumber): NSComparisonResult; cdecl;
    function decimalValue: NSDecimal; cdecl;
    function descriptionWithLocale(locale: Pointer): NSString; cdecl;
    function doubleValue: double; cdecl;
    function floatValue: Single; cdecl;
    function initWithBool(value: Boolean): Pointer; cdecl;
    function initWithChar(value: char): Pointer; cdecl;
    function initWithDouble(value: double): Pointer; cdecl;
    function initWithFloat(value: Single): Pointer; cdecl;
    function initWithInt(value: Integer): Pointer; cdecl;
    function initWithInteger(value: NSInteger): Pointer; cdecl;
    function initWithLong(value: Longint): Pointer; cdecl;
    function initWithLongLong(value: Int64): Pointer; cdecl;
    function initWithShort(value: Smallint): Pointer; cdecl;
    function initWithUnsignedChar(value: Byte): Pointer; cdecl;
    function initWithUnsignedInt(value: Longword): Pointer; cdecl;
    function initWithUnsignedInteger(value: NSUInteger): Pointer; cdecl;
    function initWithUnsignedLong(value: Longword): Pointer; cdecl;
    function initWithUnsignedLongLong(value: UInt64): Pointer; cdecl;
    function initWithUnsignedShort(value: Word): Pointer; cdecl;
    function intValue: Integer; cdecl;
    function integerValue: NSInteger; cdecl;
    function isEqualToNumber(number: NSNumber): Boolean; cdecl;
    function longLongValue: Int64; cdecl;
    function longValue: Longint; cdecl;
    function shortValue: Smallint; cdecl;
    function stringValue: NSString; cdecl;
    function unsignedCharValue: Byte; cdecl;
    function unsignedIntValue: Longword; cdecl;
    function unsignedIntegerValue: NSUInteger; cdecl;
    function unsignedLongLongValue: UInt64; cdecl;
    function unsignedLongValue: Longword; cdecl;
    function unsignedShortValue: Word; cdecl;
  end;
  TNSNumber = class(TOCGenericImport<NSNumberClass, NSNumber>)  end;

  NSMutableDataClass = interface(NSDataClass)
    ['{D59C5AA0-FAFC-4F5D-A86C-CB8299298413}']
    {class} function dataWithCapacity(aNumItems: NSUInteger): Pointer; cdecl;
    {class} function dataWithLength(length: NSUInteger): Pointer; cdecl;
  end;
  NSMutableData = interface(NSData)
    ['{FE359B3B-16C3-4EC1-9912-C9DAB084D827}']
    procedure appendBytes(bytes: Pointer; length: NSUInteger); cdecl;
    procedure appendData(other: NSData); cdecl;
    procedure increaseLengthBy(extraLength: NSUInteger); cdecl;
    function initWithCapacity(capacity: NSUInteger): Pointer; cdecl;
    function initWithLength(length: NSUInteger): Pointer; cdecl;
    function mutableBytes: Pointer; cdecl;
    procedure replaceBytesInRange(range: NSRange; withBytes: Pointer); cdecl; overload;
    procedure replaceBytesInRange(range: NSRange; withBytes: Pointer; length: NSUInteger); cdecl; overload;
    procedure resetBytesInRange(range: NSRange); cdecl;
    procedure setData(data: NSData); cdecl;
    procedure setLength(length: NSUInteger); cdecl;
  end;
  TNSMutableData = class(TOCGenericImport<NSMutableDataClass, NSMutableData>)  end;

  NSMutableCharacterSetClass = interface(NSCharacterSetClass)
    ['{AC618765-16E8-4507-B8EB-66DF1702CF84}']
  end;
  NSMutableCharacterSet = interface(NSCharacterSet)
    ['{EB87C54C-F16F-4FEF-9F75-64FD2F0926F4}']
    procedure addCharactersInRange(aRange: NSRange); cdecl;
    procedure addCharactersInString(aString: NSString); cdecl;
    procedure formIntersectionWithCharacterSet(otherSet: NSCharacterSet); cdecl;
    procedure formUnionWithCharacterSet(otherSet: NSCharacterSet); cdecl;
    procedure invert; cdecl;
    procedure removeCharactersInRange(aRange: NSRange); cdecl;
    procedure removeCharactersInString(aString: NSString); cdecl;
  end;
  TNSMutableCharacterSet = class(TOCGenericImport<NSMutableCharacterSetClass, NSMutableCharacterSet>)  end;

  NSMutableAttributedStringClass = interface(NSAttributedStringClass)
    ['{C6ED1E21-1F3C-4109-9277-710F12D40EF7}']
  end;
  NSMutableAttributedString = interface(NSAttributedString)
    ['{469A5ABD-EC5A-4667-A228-AAEFFD710631}']
    procedure addAttribute(name: NSString; value: Pointer; range: NSRange); cdecl;
    procedure addAttributes(attrs: NSDictionary; range: NSRange); cdecl;
    procedure appendAttributedString(attrString: NSAttributedString); cdecl;
    procedure beginEditing; cdecl;
    procedure deleteCharactersInRange(range: NSRange); cdecl;
    procedure endEditing; cdecl;
    procedure insertAttributedString(attrString: NSAttributedString; atIndex: NSUInteger); cdecl;
    function mutableString: NSMutableString; cdecl;
    procedure removeAttribute(name: NSString; range: NSRange); cdecl;
    procedure replaceCharactersInRange(range: NSRange; withAttributedString: NSAttributedString); cdecl; overload;
    procedure replaceCharactersInRange(range: NSRange; withString: NSString); cdecl; overload;
    procedure setAttributedString(attrString: NSAttributedString); cdecl;
    procedure setAttributes(attrs: NSDictionary; range: NSRange); cdecl;
  end;
  TNSMutableAttributedString = class(TOCGenericImport<NSMutableAttributedStringClass, NSMutableAttributedString>)  end;

  NSMutableDictionaryClass = interface(NSDictionaryClass)
    ['{99BDB475-B46E-4A68-8D4C-94EB9B2DA1A0}']
    {class} function dictionaryWithCapacity(numItems: NSUInteger): Pointer; cdecl;
  end;
  NSMutableDictionary = interface(NSDictionary)
    ['{C03FBD1C-B89A-4B95-B21F-0E567665B10A}']
    procedure addEntriesFromDictionary(otherDictionary: NSDictionary); cdecl;
    function initWithCapacity(numItems: NSUInteger): Pointer; cdecl;
    procedure removeAllObjects; cdecl;
    procedure removeObjectForKey(aKey: Pointer); cdecl;
    procedure removeObjectsForKeys(keyArray: NSArray); cdecl;
    procedure setDictionary(otherDictionary: NSDictionary); cdecl;
    procedure setObject(anObject: Pointer; forKey: Pointer); cdecl;
    procedure setValue(value: Pointer; forKey: NSString); cdecl;
  end;
  TNSMutableDictionary = class(TOCGenericImport<NSMutableDictionaryClass, NSMutableDictionary>)  end;

  NSMutableOrderedSetClass = interface(NSOrderedSetClass)
    ['{CA252F5F-42EC-4F9B-A149-B8FF6073B440}']
    {class} function orderedSetWithCapacity(numItems: NSUInteger): Pointer; cdecl;
  end;
  NSMutableOrderedSet = interface(NSOrderedSet)
    ['{7B781355-2096-4665-AB2F-73F268D58961}']
    procedure addObject(object_: Pointer); cdecl;
    procedure addObjects(objects: Pointer; count: NSUInteger); cdecl;
    procedure addObjectsFromArray(array_: NSArray); cdecl;
    procedure exchangeObjectAtIndex(idx1: NSUInteger; withObjectAtIndex: NSUInteger); cdecl;
    function initWithCapacity(numItems: NSUInteger): Pointer; cdecl;
    procedure insertObject(object_: Pointer; atIndex: NSUInteger); cdecl;
    procedure insertObjects(objects: NSArray; atIndexes: NSIndexSet); cdecl;
    procedure intersectOrderedSet(other: NSOrderedSet); cdecl;
    procedure intersectSet(other: NSSet); cdecl;
    procedure minusOrderedSet(other: NSOrderedSet); cdecl;
    procedure minusSet(other: NSSet); cdecl;
    procedure moveObjectsAtIndexes(indexes: NSIndexSet; toIndex: NSUInteger); cdecl;
    procedure removeAllObjects; cdecl;
    procedure removeObject(object_: Pointer); cdecl;
    procedure removeObjectAtIndex(idx: NSUInteger); cdecl;
    procedure removeObjectsAtIndexes(indexes: NSIndexSet); cdecl;
    procedure removeObjectsInArray(array_: NSArray); cdecl;
    procedure removeObjectsInRange(range: NSRange); cdecl;
    procedure replaceObjectAtIndex(idx: NSUInteger; withObject: Pointer); cdecl;
    procedure replaceObjectsAtIndexes(indexes: NSIndexSet; withObjects: NSArray); cdecl;
    procedure replaceObjectsInRange(range: NSRange; withObjects: Pointer; count: NSUInteger); cdecl;
    procedure setObject(obj: Pointer; atIndex: NSUInteger); cdecl;
    procedure unionOrderedSet(other: NSOrderedSet); cdecl;
    procedure unionSet(other: NSSet); cdecl;
  end;
  TNSMutableOrderedSet = class(TOCGenericImport<NSMutableOrderedSetClass, NSMutableOrderedSet>)  end;

  NSMutableIndexSetClass = interface(NSIndexSetClass)
    ['{73C480DD-4EF5-421E-81C4-151DEE3B0D0F}']
  end;
  NSMutableIndexSet = interface(NSIndexSet)
    ['{77C90236-5A11-4BD2-9371-1ED064FD5B27}']
    procedure addIndex(value: NSUInteger); cdecl;
    procedure addIndexes(indexSet: NSIndexSet); cdecl;
    procedure addIndexesInRange(range: NSRange); cdecl;
    procedure removeAllIndexes; cdecl;
    procedure removeIndex(value: NSUInteger); cdecl;
    procedure removeIndexes(indexSet: NSIndexSet); cdecl;
    procedure removeIndexesInRange(range: NSRange); cdecl;
    procedure shiftIndexesStartingAtIndex(index: NSUInteger; by: NSInteger); cdecl;
  end;
  TNSMutableIndexSet = class(TOCGenericImport<NSMutableIndexSetClass, NSMutableIndexSet>)  end;

  NSCountedSetClass = interface(NSMutableSetClass)
    ['{E09CF650-F47E-4E87-B682-6974D345A40C}']
  end;
  NSCountedSet = interface(NSMutableSet)
    ['{74B496BA-3AAC-4529-A936-2AF76731072A}']
    procedure addObject(object_: Pointer); cdecl;
    function countForObject(object_: Pointer): NSUInteger; cdecl;
    function initWithArray(array_: NSArray): Pointer; cdecl;
    function initWithCapacity(numItems: NSUInteger): Pointer; cdecl;
    function initWithSet(set_: NSSet): Pointer; cdecl;
    function objectEnumerator: NSEnumerator; cdecl;
    procedure removeObject(object_: Pointer); cdecl;
  end;
  TNSCountedSet = class(TOCGenericImport<NSCountedSetClass, NSCountedSet>)  end;

  NSDecimalNumberClass = interface(NSNumberClass)
    ['{E41F598D-6651-44B9-98F5-624D607FD89E}']
    {class} function decimalNumberWithDecimal(dcm: NSDecimal): Pointer; cdecl;
    {class} function decimalNumberWithMantissa(mantissa: UInt64; exponent: Smallint; isNegative: Boolean): Pointer; cdecl;
    {class} function decimalNumberWithString(numberValue: NSString): Pointer; cdecl; overload;
    {class} function decimalNumberWithString(numberValue: NSString; locale: Pointer): Pointer; cdecl; overload;
    {class} function defaultBehavior: Pointer; cdecl;
    {class} function maximumDecimalNumber: Pointer; cdecl;
    {class} function minimumDecimalNumber: Pointer; cdecl;
    {class} function notANumber: Pointer; cdecl;
    {class} function one: Pointer; cdecl;
    {class} procedure setDefaultBehavior(behavior: Pointer); cdecl;
    {class} function zero: Pointer; cdecl;
  end;
  NSDecimalNumber = interface(NSNumber)
    ['{A141A5E9-C247-41C1-B677-787F77B700AC}']
    function compare(decimalNumber: NSNumber): NSComparisonResult; cdecl;
    function decimalNumberByAdding(decimalNumber: NSDecimalNumber): NSDecimalNumber; cdecl; overload;
    function decimalNumberByAdding(decimalNumber: NSDecimalNumber; withBehavior: Pointer): NSDecimalNumber; cdecl; overload;
    function decimalNumberByDividingBy(decimalNumber: NSDecimalNumber): NSDecimalNumber; cdecl; overload;
    function decimalNumberByDividingBy(decimalNumber: NSDecimalNumber; withBehavior: Pointer): NSDecimalNumber; cdecl; overload;
    function decimalNumberByMultiplyingBy(decimalNumber: NSDecimalNumber): NSDecimalNumber; cdecl; overload;
    function decimalNumberByMultiplyingBy(decimalNumber: NSDecimalNumber; withBehavior: Pointer): NSDecimalNumber; cdecl; overload;
    function decimalNumberByMultiplyingByPowerOf10(power: Smallint): NSDecimalNumber; cdecl; overload;
    function decimalNumberByMultiplyingByPowerOf10(power: Smallint; withBehavior: Pointer): NSDecimalNumber; cdecl; overload;
    function decimalNumberByRaisingToPower(power: NSUInteger): NSDecimalNumber; cdecl; overload;
    function decimalNumberByRaisingToPower(power: NSUInteger; withBehavior: Pointer): NSDecimalNumber; cdecl; overload;
    function decimalNumberByRoundingAccordingToBehavior(behavior: Pointer): NSDecimalNumber; cdecl;
    function decimalNumberBySubtracting(decimalNumber: NSDecimalNumber): NSDecimalNumber; cdecl; overload;
    function decimalNumberBySubtracting(decimalNumber: NSDecimalNumber; withBehavior: Pointer): NSDecimalNumber; cdecl; overload;
    function decimalValue: NSDecimal; cdecl;
    function descriptionWithLocale(locale: Pointer): NSString; cdecl;
    function doubleValue: double; cdecl;
    function initWithDecimal(dcm: NSDecimal): Pointer; cdecl;
    function initWithMantissa(mantissa: UInt64; exponent: Smallint; isNegative: Boolean): Pointer; cdecl;
    function initWithString(numberValue: NSString): Pointer; cdecl; overload;
    function initWithString(numberValue: NSString; locale: Pointer): Pointer; cdecl; overload;
    function objCType: MarshaledAString; cdecl;
  end;
  TNSDecimalNumber = class(TOCGenericImport<NSDecimalNumberClass, NSDecimalNumber>)  end;

// Convenience method for creating an NSString from a Delphi Unicode string
function NSSTR(const Str: string): NSString;

// exported string consts

function NSDefaultRunLoopMode: NSString;
function NSRunLoopCommonModes: NSString;
function NSLocaleLanguageCode: NSString;

// Utility method for loading an pointer constant from a framework
function CocoaPointerConst(Fwk: string; ConstStr: string): Pointer;
// Utility method for loading an NSString constant from a framework
function CocoaNSStringConst(Fwk: string; ConstStr: string): NSString;

function NSMakeRange(loc: NSUInteger; len: NSUInteger): NSRange; inline;
function NSMaxRange(range: NSRange): NSUInteger; inline;
function NSLocationInRange(loc: NSUInteger; range: NSRange): Boolean; inline;
function NSEqualRanges(range1: NSRange; range2: NSRange): Boolean; inline;

implementation

uses
  System.SysUtils;

const
  FoundationFwk: string = '/System/Library/Frameworks/Foundation.framework/Foundation';

function NSSTR(const Str: string): NSString;
begin
  if Str.Length = 0 then Result := TNSString.Wrap(nil)
  else
  Result := TNSString.Wrap(TNSString.OCClass.stringWithCharacters(@Str[Low(string)],Str.Length));
end;

function CocoaPointerConst(Fwk: string; ConstStr: string): Pointer;
var
  FwkMod: HMODULE;
begin
  Result := nil;
  FwkMod := LoadLibrary(PWideChar(Fwk));
  if FwkMod <> 0 then
  begin
    Result := GetProcAddress(FwkMod, PWideChar(ConstStr));
    FreeLibrary(FwkMod);
  end;
end;

function CocoaNSStringConst(Fwk: string; ConstStr: string): NSString;
var
  Obj: Pointer;
begin
  Obj := Pointer(CocoaPointerConst(Fwk, ConstStr)^);
  if Obj <> nil then
    Result := TNSString.Wrap(Obj)
  else
    Result := nil;
end;

function NSDefaultRunLoopMode: NSString;
begin
  Result := CocoaNSStringConst(FoundationFwk, 'NSDefaultRunLoopMode');
end;

function NSRunLoopCommonModes: NSString;
begin
  Result := CocoaNSStringConst(FoundationFwk, 'NSRunLoopCommonModes');
end;

function NSLocaleLanguageCode: NSString;
begin
  Result := CocoaNSStringConst(FoundationFwk, 'NSLocaleLanguageCode');
end;

function NSMakeRange(loc: NSUInteger; len: NSUInteger): NSRange;
begin
  Result.location := loc;
  Result.length := len;
end;

function NSMaxRange(range: NSRange): NSUInteger;
begin
  Result := range.location + range.length;
end;

function NSLocationInRange(loc: NSUInteger; range: NSRange): Boolean;
begin
  Result := (loc - range.location) < range.length;
end;

function NSEqualRanges(range1: NSRange; range2: NSRange): Boolean;
begin
  Result := (range1.location = range2.location) and (range1.length = range2.length);
end;

end.
