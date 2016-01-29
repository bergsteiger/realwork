{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework Foundation 
//
unit Macapi.Foundation;

interface

uses
  Macapi.ObjCRuntime,
  Macapi.ObjectiveC,
  Macapi.CocoaTypes,
  Macapi.CoreFoundation,
//  Macapi.CFNetwork,
  Macapi.SystemConfiguration,
  Macapi.Security,
  Macapi.CoreServices;


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
  NSArgumentEvaluationScriptError = 3;
  NSArgumentsWrongScriptError = 6;
  NSAtomicWrite = 1;
  NSAttributedStringEnumerationLongestEffectiveRangeNotRequired = 1048576;
  NSAttributedStringEnumerationReverse = 2;
  NSAutosavedInformationDirectory = 11;
  NSBackwardsSearch = 4;
  NSBeginsWithComparison = 5;
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
  NSCannotCreateScriptCommandError = 10;
  NSCaseInsensitivePredicateOption = 1;
  NSCaseInsensitiveSearch = 1;
  NSCollectorDisabledOption = 2;
  NSConstantValueExpressionType = 0;
  NSContainerSpecifierError = 2;
  NSContainsComparison = 7;
  NSContainsPredicateOperatorType = 99;
  NSCoreServiceDirectory = 10;
  NSCustomSelectorPredicateOperatorType = 11;
  NSDataReadingMapped = 1;
  NSDataReadingUncached = 2;
  NSDataSearchAnchored = 2;
  NSDataSearchBackwards = 1;
  NSDataWritingAtomic = 1;
  NSDateFormatterBehavior10_0 = 1000;
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
  NSEndsWithComparison = 6;
  NSEndsWithPredicateOperatorType = 9;
  NSEnumerationConcurrent = 1;
  NSEnumerationReverse = 2;
  NSEqualToComparison = 0;
  NSEqualToPredicateOperatorType = 4;
  NSEraCalendarUnit = 2;
  NSEvaluatedObjectExpressionType = 1;
  NSEverySubelement = 1;
  NSExecutableArchitectureMismatchError = 3585;
  NSExecutableErrorMaximum = 3839;
  NSExecutableErrorMinimum = 3584;
  NSExecutableLinkError = 3588;
  NSExecutableLoadError = 3587;
  NSExecutableNotLoadableError = 3584;
  NSExecutableRuntimeMismatchError = 3586;
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
  NSFoundationVersionNumber10_0 = 397.39999999999998;
  NSFoundationVersionNumber10_1 = 425.00000000000000;
  NSFoundationVersionNumber10_1_1 = 425.00000000000000;
  NSFoundationVersionNumber10_1_2 = 425.00000000000000;
  NSFoundationVersionNumber10_1_3 = 425.00000000000000;
  NSFoundationVersionNumber10_1_4 = 425.00000000000000;
  NSFoundationVersionNumber10_2 = 462.00000000000000;
  NSFoundationVersionNumber10_2_1 = 462.00000000000000;
  NSFoundationVersionNumber10_2_2 = 462.00000000000000;
  NSFoundationVersionNumber10_2_3 = 462.00000000000000;
  NSFoundationVersionNumber10_2_4 = 462.00000000000000;
  NSFoundationVersionNumber10_2_5 = 462.00000000000000;
  NSFoundationVersionNumber10_2_6 = 462.00000000000000;
  NSFoundationVersionNumber10_2_7 = 462.69999999999999;
  NSFoundationVersionNumber10_2_8 = 462.69999999999999;
  NSFoundationVersionNumber10_3 = 500.00000000000000;
  NSFoundationVersionNumber10_3_1 = 500.00000000000000;
  NSFoundationVersionNumber10_3_2 = 500.30000000000001;
  NSFoundationVersionNumber10_3_3 = 500.54000000000002;
  NSFoundationVersionNumber10_3_4 = 500.56000000000000;
  NSFoundationVersionNumber10_3_5 = 500.56000000000000;
  NSFoundationVersionNumber10_3_6 = 500.56000000000000;
  NSFoundationVersionNumber10_3_7 = 500.56000000000000;
  NSFoundationVersionNumber10_3_8 = 500.56000000000000;
  NSFoundationVersionNumber10_3_9 = 500.57999999999998;
  NSFoundationVersionNumber10_4 = 567.00000000000000;
  NSFoundationVersionNumber10_4_1 = 567.00000000000000;
  NSFoundationVersionNumber10_4_10 = 567.28999999999996;
  NSFoundationVersionNumber10_4_11 = 567.36000000000001;
  NSFoundationVersionNumber10_4_2 = 567.12000000000000;
  NSFoundationVersionNumber10_4_3 = 567.21000000000004;
  NSFoundationVersionNumber10_4_4_Intel = 567.23000000000002;
  NSFoundationVersionNumber10_4_4_PowerPC = 567.21000000000004;
  NSFoundationVersionNumber10_4_5 = 567.25000000000000;
  NSFoundationVersionNumber10_4_6 = 567.25999999999999;
  NSFoundationVersionNumber10_4_7 = 567.26999999999998;
  NSFoundationVersionNumber10_4_8 = 567.27999999999997;
  NSFoundationVersionNumber10_4_9 = 567.28999999999996;
  NSFoundationVersionNumber10_5 = 677.00000000000000;
  NSFoundationVersionNumber10_5_1 = 677.10000000000002;
  NSFoundationVersionNumber10_5_2 = 677.14999999999998;
  NSFoundationVersionNumber10_5_3 = 677.19000000000005;
  NSFoundationVersionNumber10_5_4 = 677.19000000000005;
  NSFoundationVersionNumber10_5_5 = 677.21000000000004;
  NSFoundationVersionNumber10_5_6 = 677.22000000000003;
  NSFoundationVersionNumber10_5_7 = 677.24000000000001;
  NSFoundationVersionNumber10_5_8 = 677.25999999999999;
  NSFoundationVersionNumber10_6 = 751.00000000000000;
  NSFoundationVersionNumber10_6_1 = 751.00000000000000;
  NSFoundationVersionNumber10_6_2 = 751.13999999999999;
  NSFoundationVersionNumber10_6_3 = 751.21000000000004;
  NSFoundationVersionWithFileManagerResourceForkSupport = 412;
  NSFunctionExpressionType = 4;
  NSGreaterThanComparison = 4;
  NSGreaterThanOrEqualToComparison = 3;
  NSGreaterThanOrEqualToPredicateOperatorType = 3;
  NSGreaterThanPredicateOperatorType = 2;
  NSHPUXOperatingSystem = 4;
  NSHTTPCookieAcceptPolicyAlways = 0;
  NSHTTPCookieAcceptPolicyNever = 1;
  NSHTTPCookieAcceptPolicyOnlyFromMainDocumentDomain = 2;
  NSHashTableCopyIn = 65536;
  NSHashTableObjectPointerPersonality = 512;
  NSHashTableStrongMemory = 0;
  NSHashTableZeroingWeakMemory = 1;
  NSHourCalendarUnit = 32;
  NSINTEGER_DEFINED = 1;
  NSISO2022JPStringEncoding = 21;
  NSISOLatin1StringEncoding = 5;
  NSISOLatin2StringEncoding = 9;
  NSInPredicateOperatorType = 10;
  NSIndexSubelement = 0;
  NSInputMethodsDirectory = 16;
  NSIntegerMax = 2147483647;
  NSIntegerMin = -2147483648;
  NSInternalScriptError = 8;
  NSInternalSpecifierError = 5;
  NSIntersectSetExpressionType = 6;
  NSInvalidIndexSpecifierError = 4;
  NSItemReplacementDirectory = 99;
  NSJapaneseEUCStringEncoding = 3;
  NSKeyPathExpressionType = 3;
  NSKeySpecifierEvaluationScriptError = 2;
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
  NSLessThanComparison = 2;
  NSLessThanOrEqualToComparison = 1;
  NSLessThanOrEqualToPredicateOperatorType = 1;
  NSLessThanPredicateOperatorType = 0;
  NSLibraryDirectory = 5;
  NSLikePredicateOperatorType = 7;
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
  NSMapTableCopyIn = 65536;
  NSMapTableObjectPointerPersonality = 512;
  NSMapTableStrongMemory = 0;
  NSMapTableZeroingWeakMemory = 1;
  NSMappedRead = 1;
  NSMatchesPredicateOperatorType = 6;
  NSMiddleSubelement = 2;
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
  NSNoScriptError = 0;
  NSNoSpecifierError = 0;
  NSNoSubelement = 4;
  NSNoTopLevelContainersSpecifierError = 1;
  NSNonLossyASCIIStringEncoding = 7;
  NSNotEqualToPredicateOperatorType = 5;
  NSNotFound = 2147483647;
  NSNotPredicateType = 0;
  NSNotificationCoalescingOnName = 1;
  NSNotificationCoalescingOnSender = 2;
  NSNotificationDeliverImmediately = 1;
  NSNotificationNoCoalescing = 0;
  NSNotificationPostToAllSessions = 2;
  NSNotificationSuspensionBehaviorCoalesce = 2;
  NSNotificationSuspensionBehaviorDeliverImmediately = 4;
  NSNotificationSuspensionBehaviorDrop = 1;
  NSNotificationSuspensionBehaviorHold = 3;
  NSNumberFormatterBehavior10_0 = 1000;
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
  NSObjectAutoreleasedEvent = 3;
  NSObjectExtraRefDecrementedEvent = 5;
  NSObjectExtraRefIncrementedEvent = 4;
  NSObjectInternalRefDecrementedEvent = 7;
  NSObjectInternalRefIncrementedEvent = 6;
  NSOpenStepUnicodeReservedBase = 62464;
  NSOperationNotSupportedForKeyScriptError = 9;
  NSOperationNotSupportedForKeySpecifierError = 6;
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
  NSPointerFunctionsCStringPersonality = 768;
  NSPointerFunctionsCopyIn = 65536;
  NSPointerFunctionsIntegerPersonality = 1280;
  NSPointerFunctionsMachVirtualMemory = 4;
  NSPointerFunctionsMallocMemory = 3;
  NSPointerFunctionsObjectPersonality = 0;
  NSPointerFunctionsObjectPointerPersonality = 512;
  NSPointerFunctionsOpaqueMemory = 2;
  NSPointerFunctionsOpaquePersonality = 256;
  NSPointerFunctionsStrongMemory = 0;
  NSPointerFunctionsStructPersonality = 1024;
  NSPointerFunctionsZeroingWeakMemory = 1;
  NSPositionAfter = 0;
  NSPositionBefore = 1;
  NSPositionBeginning = 2;
  NSPositionEnd = 3;
  NSPositionReplace = 4;
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
  NSQuarterCalendarUnit = 2048;
  NSRandomSubelement = 3;
  NSReceiverEvaluationScriptError = 1;
  NSReceiversCantHandleCommandScriptError = 4;
  NSRelativeAfter = 0;
  NSRelativeBefore = 1;
  NSRequiredArgumentsMissingScriptError = 5;
  NSRoundBankers = 3;
  NSRoundDown = 1;
  NSRoundPlain = 0;
  NSRoundUp = 2;
  NSSaveOptionsAsk = 2;
  NSSaveOptionsNo = 1;
  NSSaveOptionsYes = 0;
  NSScannedOption = 1;
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
  NSTaskTerminationReasonExit = 1;
  NSTaskTerminationReasonUncaughtSignal = 2;
  NSTextCheckingAllCustomTypes = 0;
  NSTextCheckingAllSystemTypes = -1;
  NSTextCheckingAllTypes = -1;
  NSTextCheckingTypeAddress = 16;
  NSTextCheckingTypeCorrection = 512;
  NSTextCheckingTypeDash = 128;
  NSTextCheckingTypeDate = 8;
  NSTextCheckingTypeGrammar = 4;
  NSTextCheckingTypeLink = 32;
  NSTextCheckingTypeOrthography = 1;
  NSTextCheckingTypeQuote = 64;
  NSTextCheckingTypeReplacement = 256;
  NSTextCheckingTypeSpelling = 2;
  NSTimeIntervalSince1970 = 978307200.00000000;
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
  NSURLErrorDownloadDecodingFailedMidStream = -3006;
  NSURLErrorDownloadDecodingFailedToComplete = -3007;
  NSURLErrorFileDoesNotExist = -1100;
  NSURLErrorFileIsDirectory = -1101;
  NSURLErrorHTTPTooManyRedirects = -1007;
  NSURLErrorNetworkConnectionLost = -1005;
  NSURLErrorNoPermissionsToReadFile = -1102;
  NSURLErrorNotConnectedToInternet = -1009;
  NSURLErrorRedirectToNonExistentLocation = -1010;
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
  NSURLHandleLoadFailed = 3;
  NSURLHandleLoadInProgress = 2;
  NSURLHandleLoadSucceeded = 1;
  NSURLHandleNotLoaded = 0;
  NSURLRequestReloadIgnoringCacheData = 1;
  NSURLRequestReloadIgnoringLocalAndRemoteCacheData = 4;
  NSURLRequestReloadIgnoringLocalCacheData = 1;
  NSURLRequestReloadRevalidatingCacheData = 5;
  NSURLRequestReturnCacheDataDontLoad = 3;
  NSURLRequestReturnCacheDataElseLoad = 2;
  NSURLRequestUseProtocolCachePolicy = 0;
  NSUTF16BigEndianStringEncoding = -1879047936;
  NSUTF16LittleEndianStringEncoding = -1811939072;
  NSUTF16StringEncoding = 10;
  NSUTF32BigEndianStringEncoding = -1744830208;
  NSUTF32LittleEndianStringEncoding = -1677721344;
  NSUTF32StringEncoding = -1946156800;
  NSUTF8StringEncoding = 4;
  NSUncachedRead = 2;
  NSUndefinedDateComponent = 2147483647;
  NSUndoCloseGroupingRunLoopOrdering = 350000;
  NSUnicodeStringEncoding = 10;
  NSUnionSetExpressionType = 5;
  NSUnknownKeyScriptError = 7;
  NSUnknownKeySpecifierError = 3;
  NSUserCancelledError = 3072;
  NSUserDirectory = 7;
  NSUserDomainMask = 1;
  NSValidationErrorMaximum = 2047;
  NSValidationErrorMinimum = 1024;
  NSVariableExpressionType = 2;
  NSVolumeEnumerationProduceFileReferenceURLs = 4;
  NSVolumeEnumerationSkipHiddenVolumes = 2;
  NSWeekCalendarUnit = 256;
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
  NSXMLAttributeCDATAKind = 6;
  NSXMLAttributeDeclarationKind = 10;
  NSXMLAttributeEntitiesKind = 11;
  NSXMLAttributeEntityKind = 10;
  NSXMLAttributeEnumerationKind = 14;
  NSXMLAttributeIDKind = 7;
  NSXMLAttributeIDRefKind = 8;
  NSXMLAttributeIDRefsKind = 9;
  NSXMLAttributeKind = 3;
  NSXMLAttributeNMTokenKind = 12;
  NSXMLAttributeNMTokensKind = 13;
  NSXMLAttributeNotationKind = 15;
  NSXMLCommentKind = 6;
  NSXMLDTDKind = 8;
  NSXMLDocumentHTMLKind = 2;
  NSXMLDocumentIncludeContentTypeDeclaration = 262144;
  NSXMLDocumentKind = 1;
  NSXMLDocumentTextKind = 3;
  NSXMLDocumentTidyHTML = 512;
  NSXMLDocumentTidyXML = 1024;
  NSXMLDocumentValidate = 8192;
  NSXMLDocumentXHTMLKind = 1;
  NSXMLDocumentXInclude = 65536;
  NSXMLDocumentXMLKind = 0;
  NSXMLElementDeclarationAnyKind = 18;
  NSXMLElementDeclarationElementKind = 20;
  NSXMLElementDeclarationEmptyKind = 17;
  NSXMLElementDeclarationKind = 11;
  NSXMLElementDeclarationMixedKind = 19;
  NSXMLElementDeclarationUndefinedKind = 16;
  NSXMLElementKind = 2;
  NSXMLEntityDeclarationKind = 9;
  NSXMLEntityGeneralKind = 1;
  NSXMLEntityParameterKind = 4;
  NSXMLEntityParsedKind = 2;
  NSXMLEntityPredefined = 5;
  NSXMLEntityUnparsedKind = 3;
  NSXMLInvalidKind = 0;
  NSXMLNamespaceKind = 4;
  NSXMLNodeCompactEmptyElement = 4;
  NSXMLNodeExpandEmptyElement = 2;
  NSXMLNodeIsCDATA = 1;
  NSXMLNodeOptionsNone = 0;
  NSXMLNodePreserveAll = -1048546;
  NSXMLNodePreserveAttributeOrder = 2097152;
  NSXMLNodePreserveCDATA = 16777216;
  NSXMLNodePreserveCharacterReferences = 134217728;
  NSXMLNodePreserveDTD = 67108864;
  NSXMLNodePreserveEmptyElements = 6;
  NSXMLNodePreserveEntities = 4194304;
  NSXMLNodePreserveNamespaceOrder = 1048576;
  NSXMLNodePreservePrefixes = 8388608;
  NSXMLNodePreserveQuotes = 24;
  NSXMLNodePreserveWhitespace = 33554432;
  NSXMLNodePrettyPrint = 131072;
  NSXMLNodeUseDoubleQuotes = 16;
  NSXMLNodeUseSingleQuotes = 8;
  NSXMLNotationDeclarationKind = 12;
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
  NSXMLProcessingInstructionKind = 5;
  NSXMLTextKind = 7;
  NSYearCalendarUnit = 4;
  NS_BLOCKS_AVAILABLE = 1;
  NS_BigEndian = 2;
  NS_LittleEndian = 1;
  NS_UNICHAR_IS_EIGHT_BIT = 0;
  NS_UnknownByteOrder = 0;

type
{$M+}
// ===== Forward declarations =====

  NSThread = interface;
  NSTextCheckingResult = interface;
  NSTask = interface;
  NSTimeZone = interface;
  NSMetadataQueryResultGroup = interface;
  NSMethodSignature = interface;
  NSTimer = interface;
  NSNetService = interface;
  NSNetServiceBrowser = interface;
  NSNotification = interface;
  NSSortDescriptor = interface;
  NSString = interface;
  NSStream = interface;
  NSSpellServer = interface;
  NSLocale = interface;
  NSLock = interface;
  NSURLConnection = interface;
  NSURLCredential = interface;
  NSInvocation = interface;
  NSURLDownload = interface;
  NSURLCredentialStorage = interface;
  NSMetadataItem = interface;
  NSMetadataQuery = interface;
  NSMetadataQueryAttributeValueTuple = interface;
  NSURL = interface;
  NSURLCache = interface;
  NSURLAuthenticationChallenge = interface;
  NSMapTable = interface;
  NSScriptSuiteRegistry = interface;
  NSProxy = interface;
  NSScriptObjectSpecifier = interface;
  NSPropertyListSerialization = interface;
  NSPositionalSpecifier = interface;
  NSPredicate = interface;
  NSProcessInfo = interface;
  NSScanner = interface;
  NSScriptCommand = interface;
  NSScriptCoercionHandler = interface;
  NSRunLoop = interface;
  NSScriptExecutionContext = interface;
  NSRecursiveLock = interface;
  NSScriptCommandDescription = interface;
  NSOperationQueue = interface;
  NSOrthography = interface;
  NSSet = interface;
  NSOperation = interface;
  NSNotificationCenter = interface;
  NSNotificationQueue = interface;
  NSNull = interface;
  NSScriptWhoseTest = interface;
  NSPortMessage = interface;
  NSPortNameServer = interface;
  NSPort = interface;
  NSPipe = interface;
  NSPointerArray = interface;
  NSPointerFunctions = interface;
  NSCoder = interface;
  NSCondition = interface;
  NSConditionLock = interface;
  NSCalendar = interface;
  NSCharacterSet = interface;
  NSClassDescription = interface;
  NSConnection = interface;
  NSDate = interface;
  NSDateComponents = interface;
  NSUserDefaults = interface;
  NSValueTransformer = interface;
  NSValue = interface;
  NSData = interface;
  NSAppleScript = interface;
  NSXMLParser = interface;
  NSArray = interface;
  NSAffineTransform = interface;
  NSAppleEventDescriptor = interface;
  NSAppleEventManager = interface;
  NSAssertionHandler = interface;
  NSBundle = interface;
  NSCache = interface;
  NSCachedURLResponse = interface;
  NSAttributedString = interface;
  NSAutoreleasePool = interface;
  NSXMLNode = interface;
  NSGarbageCollector = interface;
  NSFormatter = interface;
  NSURLRequest = interface;
  NSHTTPCookieStorage = interface;
  NSHTTPCookie = interface;
  NSEnumerator = interface;
  NSExpression = interface;
  NSFileHandle = interface;
  NSException = interface;
  NSError = interface;
  NSFileManager = interface;
  NSDistributedLock = interface;
  NSDecimalNumberHandler = interface;
  NSUndoManager = interface;
  NSIndexPath = interface;
  NSURLProtectionSpace = interface;
  NSIndexSet = interface;
  NSDictionary = interface;
  NSURLResponse = interface;
  NSDistantObjectRequest = interface;
  NSURLProtocol = interface;
  NSHost = interface;
  NSHashTable = interface;
  NSUnarchiver = interface;
  NSSocketPort = interface;
  NSSpecifierTest = interface;
  NSSocketPortNameServer = interface;
  NSUniqueIDSpecifier = interface;
  NSSetCommand = interface;
  NSXMLDocument = interface;
  NSXMLElement = interface;
  NSXMLDTDNode = interface;
  NSWhoseSpecifier = interface;
  NSXMLDTD = interface;
  NSIndexSpecifier = interface;
  NSInputStream = interface;
  NSHTTPURLResponse = interface;
  NSDistantObject = interface;
  NSDistributedNotificationCenter = interface;
  NSLogicalTest = interface;
  NSMachBootstrapServer = interface;
  NSKeyedUnarchiver = interface;
  NSInvocationOperation = interface;
  NSKeyedArchiver = interface;
  NSDirectoryEnumerator = interface;
  NSCloneCommand = interface;
  NSCloseCommand = interface;
  NSCalendarDate = interface;
  NSArchiver = interface;
  NSBlockOperation = interface;
  NSDateFormatter = interface;
  NSDeleteCommand = interface;
  NSCreateCommand = interface;
  NSComparisonPredicate = interface;
  NSCompoundPredicate = interface;
  NSMachPort = interface;
  NSOutputStream = interface;
  NSPortCoder = interface;
  NSNumberFormatter = interface;
  NSNameSpecifier = interface;
  NSNumber = interface;
  NSRelativeSpecifier = interface;
  NSScriptClassDescription = interface;
  NSRangeSpecifier = interface;
  NSProtocolChecker = interface;
  NSQuitCommand = interface;
  NSMutableURLRequest = interface;
  NSMutableAttributedString = interface;
  NSMutableCharacterSet = interface;
  NSMutableData = interface;
  NSMessagePortNameServer = interface;
  NSMoveCommand = interface;
  NSMutableArray = interface;
  NSMutableSet = interface;
  NSMutableString = interface;
  NSMutableIndexSet = interface;
  NSMutableDictionary = interface;
  NSDecimalNumber = interface;
  NSCountedSet = interface;

// ==== Protocols ====

  NSConnectionDelegate = interface(IObjectiveC)
    ['{67175E23-7533-4752-BF68-2922E39F564F}']
  end;

  NSDecimalNumberBehaviors = interface(IObjectiveC)
    ['{9ECF9209-68CD-4D62-8F44-ADDEE1A3ABB0}']
  end;

  NSKeyedArchiverDelegate = interface(IObjectiveC)
    ['{5D4F1838-2A58-4ED1-9B09-3372B1D206E0}']
  end;

  NSKeyedUnarchiverDelegate = interface(IObjectiveC)
    ['{7C0E6A07-973A-4F0A-8102-07E6E7E1F9A2}']
  end;

  NSMachPortDelegate = interface(IObjectiveC)
    ['{DA6942FB-8C9C-4F8E-8176-6CF5CE723D18}']
  end;

  NSMetadataQueryDelegate = interface(IObjectiveC)
    ['{01F576EC-84C9-4D6C-B251-5B2ADB04D209}']
  end;

  NSNetServiceBrowserDelegate = interface(IObjectiveC)
    ['{E06EC9AE-822E-4169-8C91-084775339434}']
  end;

  NSNetServiceDelegate = interface(IObjectiveC)
    ['{7812C8D9-4E93-44B8-BEE2-269D8A21C837}']
  end;

  NSPortDelegate = interface(IObjectiveC)
    ['{BCC00A5F-23C8-4F3B-9EF3-E25E6CA12E58}']
  end;

  NSSpellServerDelegate = interface(IObjectiveC)
    ['{2AC42F5E-5C55-4F36-A627-8804EC1D01EA}']
  end;

  NSStreamDelegate = interface(IObjectiveC)
    ['{84994F37-6AD9-4DEE-8519-FCDE3FEDD047}']
  end;

  NSURLProtocolClient = interface(IObjectiveC)
    ['{C4D6D267-A17F-42B5-B726-4FCB802E5D13}']
  end;

  NSXMLParserDelegate = interface(IObjectiveC)
    ['{26AC937B-0BCB-4781-B104-86A4F498CEA5}']
  end;

// ===== Interface declarations =====

  NSThreadClass = interface(NSObjectClass)
    ['{594B5208-DA16-4E07-8554-08013C0CD759}']
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
    ['{B1232DE1-1B93-44BE-B50B-177E55C07EFB}']
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
    ['{1DB3A542-F03D-42C0-8CB7-7FC2A6034E77}']
    {class} function addressCheckingResultWithRange(range: NSRange; components: NSDictionary): Pointer; cdecl;
    {class} function correctionCheckingResultWithRange(range: NSRange; replacementString: NSString): Pointer; cdecl;
    {class} function dashCheckingResultWithRange(range: NSRange; replacementString: NSString): Pointer; cdecl;
    {class} function dateCheckingResultWithRange(range: NSRange; date: NSDate): Pointer; cdecl; overload;
    {class} function dateCheckingResultWithRange(range: NSRange; date: NSDate; timeZone: NSTimeZone; duration: NSTimeInterval): Pointer; cdecl; overload;
    {class} function grammarCheckingResultWithRange(range: NSRange; details: NSArray): Pointer; cdecl;
    {class} function linkCheckingResultWithRange(range: NSRange; URL: NSURL): Pointer; cdecl;
    {class} function orthographyCheckingResultWithRange(range: NSRange; orthography: NSOrthography): Pointer; cdecl;
    {class} function quoteCheckingResultWithRange(range: NSRange; replacementString: NSString): Pointer; cdecl;
    {class} function replacementCheckingResultWithRange(range: NSRange; replacementString: NSString): Pointer; cdecl;
    {class} function spellCheckingResultWithRange(range: NSRange): Pointer; cdecl;
  end;
  NSTextCheckingResult = interface(NSObject)
    ['{382CB7BF-15A1-4B7D-A87A-EE56CEF8BCF9}']
    function duration: NSTimeInterval; cdecl;
    function range: NSRange; cdecl;
    function resultType: NSTextCheckingType; cdecl;
  end;
  TNSTextCheckingResult = class(TOCGenericImport<NSTextCheckingResultClass, NSTextCheckingResult>)  end;

  NSTaskClass = interface(NSObjectClass)
    ['{C1932C92-F902-41BA-833C-550649C770FB}']
    {class} function launchedTaskWithLaunchPath(path: NSString; arguments: NSArray): Pointer; cdecl;
  end;
  NSTask = interface(NSObject)
    ['{6AB1D0FF-4F85-430D-846D-E2E122436299}']
    function arguments: NSArray; cdecl;
    function currentDirectoryPath: NSString; cdecl;
    function environment: NSDictionary; cdecl;
    function init: Pointer; cdecl;
    procedure interrupt; cdecl;
    function isRunning: Boolean; cdecl;
    procedure launch; cdecl;
    function launchPath: NSString; cdecl;
    function processIdentifier: Integer; cdecl;
    function resume: Boolean; cdecl;
    procedure setArguments(arguments: NSArray); cdecl;
    procedure setCurrentDirectoryPath(path: NSString); cdecl;
    procedure setEnvironment(dict: NSDictionary); cdecl;
    procedure setLaunchPath(path: NSString); cdecl;
    procedure setStandardError(error: Pointer); cdecl;
    procedure setStandardInput(input: Pointer); cdecl;
    procedure setStandardOutput(output: Pointer); cdecl;
    function standardError: Pointer; cdecl;
    function standardInput: Pointer; cdecl;
    function standardOutput: Pointer; cdecl;
    function suspend: Boolean; cdecl;
    procedure terminate; cdecl;
    function terminationReason: NSTaskTerminationReason; cdecl;
    function terminationStatus: Integer; cdecl;
    procedure waitUntilExit; cdecl;
  end;
  TNSTask = class(TOCGenericImport<NSTaskClass, NSTask>)  end;

  NSTimeZoneClass = interface(NSObjectClass)
    ['{86327E95-65A1-454F-8BE2-3CC73121D897}']
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
    ['{800D6ED8-4717-4BDA-9906-B06BE3BA38BD}']
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

  NSMetadataQueryResultGroupClass = interface(NSObjectClass)
    ['{78119E69-CEF9-431D-9BC5-EA5F5F1FA857}']
  end;
  NSMetadataQueryResultGroup = interface(NSObject)
    ['{DAE808C2-E196-49F6-8AEE-91B033630715}']
    function attribute: NSString; cdecl;
    function resultAtIndex(idx: NSUInteger): Pointer; cdecl;
    function resultCount: NSUInteger; cdecl;
    function results: NSArray; cdecl;
    function subgroups: NSArray; cdecl;
    function value: Pointer; cdecl;
  end;
  TNSMetadataQueryResultGroup = class(TOCGenericImport<NSMetadataQueryResultGroupClass, NSMetadataQueryResultGroup>)  end;

  NSMethodSignatureClass = interface(NSObjectClass)
    ['{0F13AE24-07C9-4D95-A1DC-FB922838D185}']
    {class} function signatureWithObjCTypes(types: MarshaledAString): Pointer; cdecl;
  end;
  NSMethodSignature = interface(NSObject)
    ['{D24E70F0-7D99-482E-BB09-B718ABAC11F6}']
    function frameLength: NSUInteger; cdecl;
    function getArgumentTypeAtIndex(idx: NSUInteger): MarshaledAString; cdecl;
    function isOneway: Boolean; cdecl;
    function methodReturnLength: NSUInteger; cdecl;
    function methodReturnType: MarshaledAString; cdecl;
    function numberOfArguments: NSUInteger; cdecl;
  end;
  TNSMethodSignature = class(TOCGenericImport<NSMethodSignatureClass, NSMethodSignature>)  end;

  NSTimerClass = interface(NSObjectClass)
    ['{28D1B0D9-79AA-42C0-9BFA-6852A4FC844B}']
    {class} function scheduledTimerWithTimeInterval(ti: NSTimeInterval; invocation: NSInvocation; repeats: Boolean): Pointer; cdecl; overload;
    {class} function scheduledTimerWithTimeInterval(ti: NSTimeInterval; target: Pointer; selector: SEL; userInfo: Pointer; repeats: Boolean): Pointer; cdecl; overload;
    {class} function timerWithTimeInterval(ti: NSTimeInterval; invocation: NSInvocation; repeats: Boolean): Pointer; cdecl; overload;
    {class} function timerWithTimeInterval(ti: NSTimeInterval; target: Pointer; selector: SEL; userInfo: Pointer; repeats: Boolean): Pointer; cdecl; overload;
  end;
  NSTimer = interface(NSObject)
    ['{56E60CC3-89C2-4F00-AA4C-C4747EF6ADFE}']
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

  NSNetServiceClass = interface(NSObjectClass)
    ['{450D03AC-1380-44BA-B4C3-2D30DACACA43}']
    {class} function dataFromTXTRecordDictionary(txtDictionary: NSDictionary): NSData; cdecl;
    {class} function dictionaryFromTXTRecordData(txtData: NSData): NSDictionary; cdecl;
  end;
  NSNetService = interface(NSObject)
    ['{8FACC18E-5DFA-4526-A256-DBD7CF74B65C}']
    function TXTRecordData: NSData; cdecl;
    function addresses: NSArray; cdecl;
    function delegate: NSNetServiceDelegate; cdecl;
    function domain: NSString; cdecl;
    function getInputStream(inputStream: NSInputStream; outputStream: NSOutputStream): Boolean; cdecl;
    function hostName: NSString; cdecl;
    function name: NSString; cdecl;
    function port: NSInteger; cdecl;
    function protocolSpecificInformation: NSString; cdecl;
    procedure publish; cdecl;
    procedure publishWithOptions(options: NSNetServiceOptions); cdecl;
    procedure removeFromRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure resolve; cdecl;
    procedure resolveWithTimeout(timeout: NSTimeInterval); cdecl;
    procedure scheduleInRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure setDelegate(delegate: NSNetServiceDelegate); cdecl;
    procedure setProtocolSpecificInformation(specificInformation: NSString); cdecl;
    function setTXTRecordData(recordData: NSData): Boolean; cdecl;
    procedure startMonitoring; cdecl;
    procedure stop; cdecl;
    procedure stopMonitoring; cdecl;
  end;
  TNSNetService = class(TOCGenericImport<NSNetServiceClass, NSNetService>)  end;

  NSNetServiceBrowserClass = interface(NSObjectClass)
    ['{D61D5064-E856-4A6E-92C3-6FFB5ECE4EE0}']
  end;
  NSNetServiceBrowser = interface(NSObject)
    ['{EF649219-2343-4D2A-ADAF-888853498D3A}']
    function delegate: NSNetServiceBrowserDelegate; cdecl;
    function init: Pointer; cdecl;
    procedure removeFromRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure scheduleInRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure searchForAllDomains; cdecl;
    procedure searchForBrowsableDomains; cdecl;
    procedure searchForRegistrationDomains; cdecl;
    procedure searchForServicesOfType(type_: NSString; inDomain: NSString); cdecl;
    procedure setDelegate(delegate: NSNetServiceBrowserDelegate); cdecl;
    procedure stop; cdecl;
  end;
  TNSNetServiceBrowser = class(TOCGenericImport<NSNetServiceBrowserClass, NSNetServiceBrowser>)  end;

  NSNotificationClass = interface(NSObjectClass)
    ['{C7E40944-6407-499D-947C-87A9BE26002F}']
  end;
  NSNotification = interface(NSObject)
    ['{04030ADE-507A-4E0A-A372-219771AA64AE}']
    function name: NSString; cdecl;
    function userInfo: NSDictionary; cdecl;
  end;
  TNSNotification = class(TOCGenericImport<NSNotificationClass, NSNotification>)  end;

  NSSortDescriptorClass = interface(NSObjectClass)
    ['{DF690E16-6BD1-4879-A780-FF9291D0882B}']
    {class} function sortDescriptorWithKey(key: NSString; ascending: Boolean): Pointer; cdecl; overload;
//    {class} function sortDescriptorWithKey(key: NSString; ascending: Boolean; comparator: NSComparator): Pointer; cdecl; overload;
    {class} function sortDescriptorWithKey(key: NSString; ascending: Boolean; selector: SEL): Pointer; cdecl; overload;
  end;
  NSSortDescriptor = interface(NSObject)
    ['{5E776AE0-21CE-4790-A55A-B8483154E10C}']
    function ascending: Boolean; cdecl;
    function comparator: NSComparator; cdecl;
    function compareObject(object1: Pointer; toObject: Pointer): NSComparisonResult; cdecl;
    function initWithKey(key: NSString; ascending: Boolean): Pointer; cdecl; overload;
//    function initWithKey(key: NSString; ascending: Boolean; comparator: NSComparator): Pointer; cdecl; overload;
    function initWithKey(key: NSString; ascending: Boolean; selector: SEL): Pointer; cdecl; overload;
    function key: NSString; cdecl;
    function reversedSortDescriptor: Pointer; cdecl;
    function selector: SEL; cdecl;
  end;
  TNSSortDescriptor = class(TOCGenericImport<NSSortDescriptorClass, NSSortDescriptor>)  end;

  NSStringClass = interface(NSObjectClass)
    ['{A21B9D92-0C1F-4BE4-9FA0-7E5357D46EDA}']
    {class} function availableStringEncodings: PNSStringEncoding; cdecl;
    {class} function defaultCStringEncoding: NSStringEncoding; cdecl;
    {class} function localizedNameOfStringEncoding(encoding: NSStringEncoding): Pointer; cdecl;
    {class} function localizedStringWithFormat(localizedStringWithFormat: NSString): Pointer; cdecl;
    {class} function pathWithComponents(components: NSArray): Pointer; cdecl;
    {class} function stringWithCString(bytes: MarshaledAString): Pointer; cdecl; overload;
    {class} function stringWithCString(cString: MarshaledAString; encoding: NSStringEncoding): Pointer; cdecl; overload;
//    {class} function stringWithCString(bytes: MarshaledAString; length: NSUInteger): Pointer; cdecl; overload;
    {class} function stringWithCharacters(characters: MarshaledString; length: NSUInteger): Pointer; cdecl;
    {class} function stringWithContentsOfFile(path: NSString): Pointer; cdecl; overload;
    {class} function stringWithContentsOfFile(path: NSString; encoding: NSStringEncoding; error: PPointer): Pointer; cdecl; overload;
    {class} function stringWithContentsOfFile(path: NSString; usedEncoding: PNSStringEncoding; error: PPointer): Pointer; cdecl; overload;
    {class} function stringWithContentsOfURL(url: NSURL): Pointer; cdecl; overload;
    {class} function stringWithContentsOfURL(url: NSURL; encoding: NSStringEncoding; error: PPointer): Pointer; cdecl; overload;
    {class} function stringWithContentsOfURL(url: NSURL; usedEncoding: PNSStringEncoding; error: PPointer): Pointer; cdecl; overload;
    {class} function stringWithFormat(stringWithFormat: NSString): Pointer; cdecl;
    {class} function stringWithString(string_: NSString): Pointer; cdecl;
    {class} function stringWithUTF8String(nullTerminatedCString: MarshaledAString): Pointer; cdecl;
  end;
  NSString = interface(NSObject)
    ['{510EFCC6-29A8-49B4-AC88-611C43D8D9A2}']
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
//    function initWithCString(bytes: PAnsiChar; length: NSUInteger): Pointer; cdecl; overload;
    function initWithCStringNoCopy(bytes: MarshaledAString; length: NSUInteger; freeWhenDone: Boolean): Pointer; cdecl;
    function initWithCharacters(characters: MarshaledString; length: NSUInteger): Pointer; cdecl;
    function initWithCharactersNoCopy(characters: MarshaledString; length: NSUInteger; freeWhenDone: Boolean): Pointer; cdecl;
    function initWithContentsOfFile(path: NSString): Pointer; cdecl; overload;
    function initWithContentsOfFile(path: NSString; encoding: NSStringEncoding; error: PPointer): Pointer; cdecl; overload;
    function initWithContentsOfFile(path: NSString; usedEncoding: PNSStringEncoding; error: PPointer): Pointer; cdecl; overload;
    function initWithContentsOfURL(url: NSURL): Pointer; cdecl; overload;
    function initWithContentsOfURL(url: NSURL; encoding: NSStringEncoding; error: PPointer): Pointer; cdecl; overload;
    function initWithContentsOfURL(url: NSURL; usedEncoding: PNSStringEncoding; error: PPointer): Pointer; cdecl; overload;
    function initWithData(data: NSData; encoding: NSStringEncoding): Pointer; cdecl;
    function initWithFormat(initWithFormat: NSString): Pointer; cdecl; overload;
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
    function stringByAppendingFormat(stringByAppendingFormat: NSString): NSString; cdecl;
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
    function writeToFile(path: NSString; atomically: Boolean): Boolean; cdecl; overload;
    function writeToFile(path: NSString; atomically: Boolean; encoding: NSStringEncoding; error: PPointer): Boolean; cdecl; overload;
    function writeToURL(url: NSURL; atomically: Boolean): Boolean; cdecl; overload;
    function writeToURL(url: NSURL; atomically: Boolean; encoding: NSStringEncoding; error: PPointer): Boolean; cdecl; overload;
  end;
  TNSString = class(TOCGenericImport<NSStringClass, NSString>)  end;

  NSStreamClass = interface(NSObjectClass)
    ['{38456B34-68A3-44FC-B1E9-B372B482C7A8}']
    {class} procedure getStreamsToHost(host: NSHost; port: NSInteger; inputStream: NSInputStream; outputStream: NSOutputStream); cdecl;
  end;
  NSStream = interface(NSObject)
    ['{ED8BFE9C-5FB9-44C5-B1F5-481127971A54}']
    procedure close; cdecl;
    function delegate: NSStreamDelegate; cdecl;
    procedure open; cdecl;
    function propertyForKey(key: NSString): Pointer; cdecl;
    procedure removeFromRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure scheduleInRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure setDelegate(delegate: NSStreamDelegate); cdecl;
    function setProperty(property_: Pointer; forKey: NSString): Boolean; cdecl;
    function streamError: NSError; cdecl;
    function streamStatus: NSStreamStatus; cdecl;
  end;
  TNSStream = class(TOCGenericImport<NSStreamClass, NSStream>)  end;

  NSSpellServerClass = interface(NSObjectClass)
    ['{16FF8F64-D24B-4AE9-BE61-3111EB40A2CD}']
  end;
  NSSpellServer = interface(NSObject)
    ['{938C291B-1CF3-4E5A-959C-BDEBAEE8D617}']
    function delegate: NSSpellServerDelegate; cdecl;
    function isWordInUserDictionaries(word: NSString; caseSensitive: Boolean): Boolean; cdecl;
    function registerLanguage(language: NSString; byVendor: NSString): Boolean; cdecl;
    procedure run; cdecl;
    procedure setDelegate(anObject: NSSpellServerDelegate); cdecl;
  end;
  TNSSpellServer = class(TOCGenericImport<NSSpellServerClass, NSSpellServer>)  end;

  NSLocaleClass = interface(NSObjectClass)
    ['{FAB54816-BE0F-4507-A4C2-A1EAF4A0D851}']
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
    ['{D3E30922-4AA5-4143-AD1B-5756995B7406}']
    function displayNameForKey(key: Pointer; value: Pointer): NSString; cdecl;
    function initWithLocaleIdentifier(string_: NSString): Pointer; cdecl;
    function localeIdentifier: NSString; cdecl;
    function objectForKey(key: Pointer): Pointer; cdecl;
  end;
  TNSLocale = class(TOCGenericImport<NSLocaleClass, NSLocale>)  end;

  NSLockClass = interface(NSObjectClass)
    ['{B254B8B7-2858-483F-B258-D9255A3E3EA1}']
  end;
  NSLock = interface(NSObject)
    ['{B9122405-9881-4A35-B493-4262E2F17FF1}']
    function lockBeforeDate(limit: NSDate): Boolean; cdecl;
    function name: NSString; cdecl;
    procedure setName(n: NSString); cdecl;
    function tryLock: Boolean; cdecl;
  end;
  TNSLock = class(TOCGenericImport<NSLockClass, NSLock>)  end;

  NSURLConnectionClass = interface(NSObjectClass)
    ['{BA3F0136-95A6-447D-956E-B271DBDCB418}']
    {class} function canHandleRequest(request: NSURLRequest): Boolean; cdecl;
    {class} function connectionWithRequest(request: NSURLRequest; delegate: Pointer): Pointer; cdecl;
    {class} function sendSynchronousRequest(request: NSURLRequest; returningResponse: NSURLResponse; error: PPointer): NSData; cdecl;
  end;
  NSURLConnection = interface(NSObject)
    ['{BDFFFFF2-60D7-4E17-9E36-418B0D594F99}']
    procedure cancel; cdecl;
    function initWithRequest(request: NSURLRequest; delegate: Pointer): Pointer; cdecl; overload;
    function initWithRequest(request: NSURLRequest; delegate: Pointer; startImmediately: Boolean): Pointer; cdecl; overload;
    procedure scheduleInRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure start; cdecl;
    procedure unscheduleFromRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
  end;
  TNSURLConnection = class(TOCGenericImport<NSURLConnectionClass, NSURLConnection>)  end;

  NSURLCredentialClass = interface(NSObjectClass)
    ['{A4B21487-4AB6-4366-AE27-AAAADF014B27}']
    {class} function credentialForTrust(trust: SecTrustRef): Pointer; cdecl;
    {class} function credentialWithIdentity(identity: SecIdentityRef; certificates: NSArray; persistence: NSURLCredentialPersistence): Pointer; cdecl;
    {class} function credentialWithUser(user: NSString; password: NSString; persistence: NSURLCredentialPersistence): Pointer; cdecl;
  end;
  NSURLCredential = interface(NSObject)
    ['{BE36A308-A6DE-45FA-B5D2-B4AD4FC07EB0}']
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

  NSInvocationClass = interface(NSObjectClass)
    ['{A62299E3-ABFB-4176-B656-30FF6DF6DFE0}']
    {class} function invocationWithMethodSignature(sig: NSMethodSignature): Pointer; cdecl;
  end;
  NSInvocation = interface(NSObject)
    ['{3904B578-B369-4FD8-9826-354904C1D14A}']
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

  NSURLDownloadClass = interface(NSObjectClass)
    ['{CC44D94A-FAB7-4C8A-A2CF-451167C728FB}']
    {class} function canResumeDownloadDecodedWithEncodingMIMEType(MIMEType: NSString): Boolean; cdecl;
  end;
  NSURLDownload = interface(NSObject)
    ['{10E142E0-046B-4C58-BD1F-675A344B4586}']
    procedure cancel; cdecl;
    function deletesFileUponFailure: Boolean; cdecl;
    function initWithRequest(request: NSURLRequest; delegate: Pointer): Pointer; cdecl;
    function initWithResumeData(resumeData: NSData; delegate: Pointer; path: NSString): Pointer; cdecl;
    function request: NSURLRequest; cdecl;
    function resumeData: NSData; cdecl;
    procedure setDeletesFileUponFailure(deletesFileUponFailure: Boolean); cdecl;
    procedure setDestination(path: NSString; allowOverwrite: Boolean); cdecl;
  end;
  TNSURLDownload = class(TOCGenericImport<NSURLDownloadClass, NSURLDownload>)  end;

  NSURLCredentialStorageClass = interface(NSObjectClass)
    ['{373FEB3A-8D17-482A-AA10-39EE1F84D765}']
    {class} function sharedCredentialStorage: Pointer; cdecl;
  end;
  NSURLCredentialStorage = interface(NSObject)
    ['{2584B7A9-0211-47F1-AB89-733EC4244478}']
    function allCredentials: NSDictionary; cdecl;
    function credentialsForProtectionSpace(space: NSURLProtectionSpace): NSDictionary; cdecl;
    function defaultCredentialForProtectionSpace(space: NSURLProtectionSpace): NSURLCredential; cdecl;
    procedure removeCredential(credential: NSURLCredential; forProtectionSpace: NSURLProtectionSpace); cdecl;
    procedure setCredential(credential: NSURLCredential; forProtectionSpace: NSURLProtectionSpace); cdecl;
    procedure setDefaultCredential(credential: NSURLCredential; forProtectionSpace: NSURLProtectionSpace); cdecl;
  end;
  TNSURLCredentialStorage = class(TOCGenericImport<NSURLCredentialStorageClass, NSURLCredentialStorage>)  end;

  NSMetadataItemClass = interface(NSObjectClass)
    ['{4A8B902D-99BA-4FA6-AA87-B6CB7543BA4C}']
  end;
  NSMetadataItem = interface(NSObject)
    ['{B56726E5-99B2-438F-BEB3-BC3945B6362B}']
    function attributes: NSArray; cdecl;
    function valueForAttribute(key: NSString): Pointer; cdecl;
    function valuesForAttributes(keys: NSArray): NSDictionary; cdecl;
  end;
  TNSMetadataItem = class(TOCGenericImport<NSMetadataItemClass, NSMetadataItem>)  end;

  NSMetadataQueryClass = interface(NSObjectClass)
    ['{003A531F-CA1F-4BAB-A471-CF1C641FFC54}']
  end;
  NSMetadataQuery = interface(NSObject)
    ['{70A5A9EF-1147-44A9-AED5-CA8EF3E2414F}']
    function delegate: NSMetadataQueryDelegate; cdecl;
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
    procedure setDelegate(delegate: NSMetadataQueryDelegate); cdecl;
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
    ['{C2CF1EE6-42E2-4A54-86BD-1FAFB7D39D99}']
  end;
  NSMetadataQueryAttributeValueTuple = interface(NSObject)
    ['{C091BE4C-F0D2-4A69-A548-ABB395DA9F50}']
    function attribute: NSString; cdecl;
    function count: NSUInteger; cdecl;
    function value: Pointer; cdecl;
  end;
  TNSMetadataQueryAttributeValueTuple = class(TOCGenericImport<NSMetadataQueryAttributeValueTupleClass, NSMetadataQueryAttributeValueTuple>)  end;

  NSURLClass = interface(NSObjectClass)
    ['{EBFF91D9-3727-4B8F-A63B-484103919E64}']
    {class} function URLByResolvingBookmarkData(bookmarkData: NSData; options: NSURLBookmarkResolutionOptions; relativeToURL: NSURL; bookmarkDataIsStale: PBoolean; error: PPointer): Pointer; cdecl;
    {class} function URLWithString(URLString: NSString): Pointer; cdecl; overload;
    {class} function URLWithString(URLString: NSString; relativeToURL: NSURL): Pointer; cdecl; overload;
    {class} function bookmarkDataWithContentsOfURL(bookmarkFileURL: NSURL; error: PPointer): NSData; cdecl;
    {class} function fileURLWithPath(path: NSString): Pointer; cdecl; overload;
    {class} function fileURLWithPath(path: NSString; isDirectory: Boolean): Pointer; cdecl; overload;
    {class} function fileURLWithPathComponents(components: NSArray): Pointer; cdecl;
    {class} function resourceValuesForKeys(keys: NSArray; fromBookmarkData: NSData): NSDictionary; cdecl; overload;
    {class} function writeBookmarkData(bookmarkData: NSData; toURL: NSURL; options: NSURLBookmarkFileCreationOptions; error: PPointer): Boolean; cdecl;
  end;
  NSURL = interface(NSObject)
    ['{BB3BDECA-2E3A-4326-BDD8-6C339A277E34}']
    function URLByAppendingPathComponent(pathComponent: NSString): NSURL; cdecl;
    function URLByAppendingPathExtension(pathExtension: NSString): NSURL; cdecl;
    function URLByDeletingLastPathComponent: NSURL; cdecl;
    function URLByDeletingPathExtension: NSURL; cdecl;
    function URLByResolvingSymlinksInPath: NSURL; cdecl;
    function URLByStandardizingPath: NSURL; cdecl;
    function absoluteString: NSString; cdecl;
    function absoluteURL: NSURL; cdecl;
    function baseURL: NSURL; cdecl;
    function bookmarkDataWithOptions(options: NSURLBookmarkCreationOptions; includingResourceValuesForKeys: NSArray; relativeToURL: NSURL; error: PPointer): NSData; cdecl;
    function checkResourceIsReachableAndReturnError(error: PPointer): Boolean; cdecl;
    function filePathURL: NSURL; cdecl;
    function fileReferenceURL: NSURL; cdecl;
    function fragment: NSString; cdecl;
    function getResourceValue(value: Pointer; forKey: NSString; error: PPointer): Boolean; cdecl;
    function host: NSString; cdecl;
    function initByResolvingBookmarkData(bookmarkData: NSData; options: NSURLBookmarkResolutionOptions; relativeToURL: NSURL; bookmarkDataIsStale: PBoolean; error: PPointer): Pointer; cdecl;
    function initFileURLWithPath(path: NSString): Pointer; cdecl; overload;
    function initFileURLWithPath(path: NSString; isDirectory: Boolean): Pointer; cdecl; overload;
    function initWithScheme(scheme: NSString; host: NSString; path: NSString): Pointer; cdecl;
    function initWithString(URLString: NSString): Pointer; cdecl; overload;
    function initWithString(URLString: NSString; relativeToURL: NSURL): Pointer; cdecl; overload;
    function isFileReferenceURL: Boolean; cdecl;
    function isFileURL: Boolean; cdecl;
    function lastPathComponent: NSString; cdecl;
    procedure loadResourceDataNotifyingClient(client: Pointer; usingCache: Boolean); cdecl;
    function parameterString: NSString; cdecl;
    function password: NSString; cdecl;
    function path: NSString; cdecl;
    function pathComponents: NSArray; cdecl;
    function pathExtension: NSString; cdecl;
    function port: NSNumber; cdecl;
    function propertyForKey(propertyKey: NSString): Pointer; cdecl;
    function query: NSString; cdecl;
    function relativePath: NSString; cdecl;
    function relativeString: NSString; cdecl;
    function resourceDataUsingCache(shouldUseCache: Boolean): NSData; cdecl;
    function resourceSpecifier: NSString; cdecl;
    function resourceValuesForKeys(keys: NSArray; error: PPointer): NSDictionary; cdecl; overload;
    function scheme: NSString; cdecl;
    function setProperty(property_: Pointer; forKey: NSString): Boolean; cdecl;
    function setResourceData(data: NSData): Boolean; cdecl;
    function setResourceValue(value: Pointer; forKey: NSString; error: PPointer): Boolean; cdecl;
    function setResourceValues(keyedValues: NSDictionary; error: PPointer): Boolean; cdecl;
    function standardizedURL: NSURL; cdecl;
    function user: NSString; cdecl;
  end;
  TNSURL = class(TOCGenericImport<NSURLClass, NSURL>)  end;

  NSURLCacheClass = interface(NSObjectClass)
    ['{8CC92F48-1D45-4023-A4D6-725658D2E448}']
    {class} procedure setSharedURLCache(cache: NSURLCache); cdecl;
    {class} function sharedURLCache: Pointer; cdecl;
  end;
  NSURLCache = interface(NSObject)
    ['{8425A107-8113-4DCA-ADE8-8D14740EC76A}']
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

  NSURLAuthenticationChallengeClass = interface(NSObjectClass)
    ['{F3CE70A8-618C-4565-B435-F9F68AA69B27}']
  end;
  NSURLAuthenticationChallenge = interface(NSObject)
    ['{81ABFAE1-24C6-4F20-866C-FCA383B10ACB}']
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

  NSMapTableClass = interface(NSObjectClass)
    ['{DE5F6C31-9EEA-4679-878B-640C7300FBF4}']
    {class} function mapTableWithKeyOptions(keyOptions: NSPointerFunctionsOptions; valueOptions: NSPointerFunctionsOptions): Pointer; cdecl;
    {class} function mapTableWithStrongToStrongObjects: Pointer; cdecl;
    {class} function mapTableWithStrongToWeakObjects: Pointer; cdecl;
    {class} function mapTableWithWeakToStrongObjects: Pointer; cdecl;
    {class} function mapTableWithWeakToWeakObjects: Pointer; cdecl;
  end;
  NSMapTable = interface(NSObject)
    ['{9F5036A0-6068-458A-8785-528EDF2CB079}']
    function count: NSUInteger; cdecl;
    function dictionaryRepresentation: NSDictionary; cdecl;
    function initWithKeyOptions(keyOptions: NSPointerFunctionsOptions; valueOptions: NSPointerFunctionsOptions; capacity: NSUInteger): Pointer; cdecl;
    function initWithKeyPointerFunctions(keyFunctions: NSPointerFunctions; valuePointerFunctions: NSPointerFunctions; capacity: NSUInteger): Pointer; cdecl;
    function keyEnumerator: NSEnumerator; cdecl;
    function keyPointerFunctions: NSPointerFunctions; cdecl;
    function objectEnumerator: NSEnumerator; cdecl;
    function objectForKey(aKey: Pointer): Pointer; cdecl;
    procedure removeAllObjects; cdecl;
    procedure removeObjectForKey(aKey: Pointer); cdecl;
    procedure setObject(anObject: Pointer; forKey: Pointer); cdecl;
    function valuePointerFunctions: NSPointerFunctions; cdecl;
  end;
  TNSMapTable = class(TOCGenericImport<NSMapTableClass, NSMapTable>)  end;

  NSScriptSuiteRegistryClass = interface(NSObjectClass)
    ['{90A363E1-243A-41D8-905F-7650C2E2DBB1}']
    {class} procedure setSharedScriptSuiteRegistry(registry: NSScriptSuiteRegistry); cdecl;
    {class} function sharedScriptSuiteRegistry: Pointer; cdecl;
  end;
  NSScriptSuiteRegistry = interface(NSObject)
    ['{8486B319-5479-4F3C-AA9E-C7654582DEF3}']
    function aeteResource(languageName: NSString): NSData; cdecl;
    function appleEventCodeForSuite(suiteName: NSString): FourCharCode; cdecl;
    function bundleForSuite(suiteName: NSString): NSBundle; cdecl;
    function classDescriptionWithAppleEventCode(appleEventCode: FourCharCode): NSScriptClassDescription; cdecl;
    function classDescriptionsInSuite(suiteName: NSString): NSDictionary; cdecl;
    function commandDescriptionWithAppleEventClass(appleEventClassCode: FourCharCode; andAppleEventCode: FourCharCode): NSScriptCommandDescription; cdecl;
    function commandDescriptionsInSuite(suiteName: NSString): NSDictionary; cdecl;
    procedure loadSuiteWithDictionary(suiteDeclaration: NSDictionary; fromBundle: NSBundle); cdecl;
    procedure loadSuitesFromBundle(bundle: NSBundle); cdecl;
    procedure registerClassDescription(classDescription: NSScriptClassDescription); cdecl;
    procedure registerCommandDescription(commandDescription: NSScriptCommandDescription); cdecl;
    function suiteForAppleEventCode(appleEventCode: FourCharCode): NSString; cdecl;
    function suiteNames: NSArray; cdecl;
  end;
  TNSScriptSuiteRegistry = class(TOCGenericImport<NSScriptSuiteRegistryClass, NSScriptSuiteRegistry>)  end;

  NSProxyClass = interface(IObjectiveCClass)
    ['{F2968831-355F-4E26-BDB3-9050F5D1F638}']
    {class} function alloc: Pointer; cdecl;
    {class} function allocWithZone(zone: Pointer): Pointer; cdecl;
    {class} function respondsToSelector(aSelector: SEL): Boolean; cdecl;
  end;
  NSProxy = interface(IObjectiveCInstance)
    ['{78B6959B-3FCD-4ADC-B7E6-BE15B00FBA08}']
    procedure dealloc; cdecl;
    function description: NSString; cdecl;
    procedure finalize; cdecl;
    procedure forwardInvocation(invocation: NSInvocation); cdecl;
    function methodSignatureForSelector(sel: SEL): NSMethodSignature; cdecl;
  end;
  TNSProxy = class(TOCGenericImport<NSProxyClass, NSProxy>)  end;

  NSScriptObjectSpecifierClass = interface(NSObjectClass)
    ['{554294D7-932C-4952-8BE3-342C721A4DF9}']
    {class} function objectSpecifierWithDescriptor(descriptor: NSAppleEventDescriptor): Pointer; cdecl;
  end;
  NSScriptObjectSpecifier = interface(NSObject)
    ['{D7605E50-558E-46BC-AB20-BF01FEF8DA34}']
    function childSpecifier: NSScriptObjectSpecifier; cdecl;
    function containerClassDescription: NSScriptClassDescription; cdecl;
    function containerIsObjectBeingTested: Boolean; cdecl;
    function containerIsRangeContainerObject: Boolean; cdecl;
    function containerSpecifier: NSScriptObjectSpecifier; cdecl;
    function descriptor: NSAppleEventDescriptor; cdecl;
    function evaluationErrorNumber: NSInteger; cdecl;
    function evaluationErrorSpecifier: NSScriptObjectSpecifier; cdecl;
    function indicesOfObjectsByEvaluatingWithContainer(container: Pointer; count: NSInteger): NSInteger; cdecl;
    function initWithContainerClassDescription(classDesc: NSScriptClassDescription; containerSpecifier: NSScriptObjectSpecifier; key: NSString): Pointer; cdecl;
    function initWithContainerSpecifier(container: NSScriptObjectSpecifier; key: NSString): Pointer; cdecl;
    function key: NSString; cdecl;
    function keyClassDescription: NSScriptClassDescription; cdecl;
    function objectsByEvaluatingSpecifier: Pointer; cdecl;
    function objectsByEvaluatingWithContainers(containers: Pointer): Pointer; cdecl;
    procedure setChildSpecifier(child: NSScriptObjectSpecifier); cdecl;
    procedure setContainerClassDescription(classDesc: NSScriptClassDescription); cdecl;
    procedure setContainerIsObjectBeingTested(flag: Boolean); cdecl;
    procedure setContainerIsRangeContainerObject(flag: Boolean); cdecl;
    procedure setContainerSpecifier(subRef: NSScriptObjectSpecifier); cdecl;
    procedure setEvaluationErrorNumber(error: NSInteger); cdecl;
    procedure setKey(key: NSString); cdecl;
  end;
  TNSScriptObjectSpecifier = class(TOCGenericImport<NSScriptObjectSpecifierClass, NSScriptObjectSpecifier>)  end;

  NSPropertyListSerializationClass = interface(NSObjectClass)
    ['{1B7DFA62-CC27-4B5E-98C2-4124F122F0DF}']
    {class} function dataFromPropertyList(plist: Pointer; format: NSPropertyListFormat; errorDescription: NSString): NSData; cdecl;
    {class} function dataWithPropertyList(plist: Pointer; format: NSPropertyListFormat; options: NSPropertyListWriteOptions; error: PPointer): NSData; cdecl;
    {class} function propertyList(plist: Pointer; isValidForFormat: NSPropertyListFormat): Boolean; cdecl;
    {class} function propertyListFromData(data: NSData; mutabilityOption: NSPropertyListMutabilityOptions; format: PNSPropertyListFormat; errorDescription: NSString): Pointer; cdecl;
    {class} function propertyListWithData(data: NSData; options: NSPropertyListReadOptions; format: PNSPropertyListFormat; error: PPointer): Pointer; cdecl;
    {class} function propertyListWithStream(stream: NSInputStream; options: NSPropertyListReadOptions; format: PNSPropertyListFormat; error: PPointer): Pointer; cdecl;
    {class} function writePropertyList(plist: Pointer; toStream: NSOutputStream; format: NSPropertyListFormat; options: NSPropertyListWriteOptions; error: PPointer): NSInteger; cdecl;
  end;
  NSPropertyListSerialization = interface(NSObject)
    ['{D1086383-FB2B-4092-9857-89E99819344E}']
  end;
  TNSPropertyListSerialization = class(TOCGenericImport<NSPropertyListSerializationClass, NSPropertyListSerialization>)  end;

  NSPositionalSpecifierClass = interface(NSObjectClass)
    ['{5111171D-73E9-42C8-A605-6FA8FDDBD053}']
  end;
  NSPositionalSpecifier = interface(NSObject)
    ['{582F6F8B-F0F1-44EE-8A45-4ACA8E8B8628}']
    procedure evaluate; cdecl;
    function initWithPosition(position: NSInsertionPosition; objectSpecifier: NSScriptObjectSpecifier): Pointer; cdecl;
    function insertionContainer: Pointer; cdecl;
    function insertionIndex: NSInteger; cdecl;
    function insertionKey: NSString; cdecl;
    function insertionReplaces: Boolean; cdecl;
    function objectSpecifier: NSScriptObjectSpecifier; cdecl;
    function position: NSInsertionPosition; cdecl;
    procedure setInsertionClassDescription(classDescription: NSScriptClassDescription); cdecl;
  end;
  TNSPositionalSpecifier = class(TOCGenericImport<NSPositionalSpecifierClass, NSPositionalSpecifier>)  end;

  NSPredicateClass = interface(NSObjectClass)
    ['{99C7DE8B-2E86-4912-97AB-F4171F8CEC6F}']
    {class} function predicateWithFormat(predicateWithFormat: NSString): Pointer; cdecl; overload;
    {class} function predicateWithFormat(predicateFormat: NSString; argumentArray: NSArray): Pointer; cdecl; overload;
    {class} function predicateWithValue(value: Boolean): Pointer; cdecl;
  end;
  NSPredicate = interface(NSObject)
    ['{D50FED07-6B93-4CA7-BF5A-675CD26DF286}']
    function evaluateWithObject(object_: Pointer): Boolean; cdecl; overload;
    function evaluateWithObject(object_: Pointer; substitutionVariables: NSDictionary): Boolean; cdecl; overload;
    function predicateFormat: NSString; cdecl;
    function predicateWithSubstitutionVariables(variables: NSDictionary): NSPredicate; cdecl;
  end;
  TNSPredicate = class(TOCGenericImport<NSPredicateClass, NSPredicate>)  end;

  NSProcessInfoClass = interface(NSObjectClass)
    ['{82872F3D-C9F6-4DBF-9151-EB70642C0901}']
    {class} function processInfo: Pointer; cdecl;
  end;
  NSProcessInfo = interface(NSObject)
    ['{B96935F6-3809-4A49-AD4F-CBBAB0F2C961}']
    function activeProcessorCount: NSUInteger; cdecl;
    function arguments: NSArray; cdecl;
    procedure disableSuddenTermination; cdecl;
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
    procedure setProcessName(newName: NSString); cdecl;
    function systemUptime: NSTimeInterval; cdecl;
  end;
  TNSProcessInfo = class(TOCGenericImport<NSProcessInfoClass, NSProcessInfo>)  end;

  NSScannerClass = interface(NSObjectClass)
    ['{E87710C9-5E78-4E18-8046-37EB56241BA8}']
    {class} function localizedScannerWithString(string_: NSString): Pointer; cdecl;
    {class} function scannerWithString(string_: NSString): Pointer; cdecl;
  end;
  NSScanner = interface(NSObject)
    ['{3DCC0948-2386-4E78-89C8-2261C05BD4DF}']
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
    function scanHexInt(value: PLongword): Boolean; cdecl;
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

  NSScriptCommandClass = interface(NSObjectClass)
    ['{4EC6C9BF-86A6-40F7-916A-FAAECD90C59C}']
    {class} function currentCommand: Pointer; cdecl;
  end;
  NSScriptCommand = interface(NSObject)
    ['{FE34833F-703D-4EB4-B92D-BB823F90D6EA}']
    function appleEvent: NSAppleEventDescriptor; cdecl;
    function arguments: NSDictionary; cdecl;
    function commandDescription: NSScriptCommandDescription; cdecl;
    function directParameter: Pointer; cdecl;
    function evaluatedArguments: NSDictionary; cdecl;
    function evaluatedReceivers: Pointer; cdecl;
    function executeCommand: Pointer; cdecl;
    function initWithCommandDescription(commandDef: NSScriptCommandDescription): Pointer; cdecl;
    function isWellFormed: Boolean; cdecl;
    function performDefaultImplementation: Pointer; cdecl;
    function receiversSpecifier: NSScriptObjectSpecifier; cdecl;
    procedure resumeExecutionWithResult(result: Pointer); cdecl;
    function scriptErrorExpectedTypeDescriptor: NSAppleEventDescriptor; cdecl;
    function scriptErrorNumber: Integer; cdecl;
    function scriptErrorOffendingObjectDescriptor: NSAppleEventDescriptor; cdecl;
    function scriptErrorString: NSString; cdecl;
    procedure setArguments(args: NSDictionary); cdecl;
    procedure setDirectParameter(directParameter: Pointer); cdecl;
    procedure setReceiversSpecifier(receiversRef: NSScriptObjectSpecifier); cdecl;
    procedure setScriptErrorExpectedTypeDescriptor(errorExpectedTypeDescriptor: NSAppleEventDescriptor); cdecl;
    procedure setScriptErrorNumber(errorNumber: Integer); cdecl;
    procedure setScriptErrorOffendingObjectDescriptor(errorOffendingObjectDescriptor: NSAppleEventDescriptor); cdecl;
    procedure setScriptErrorString(errorString: NSString); cdecl;
    procedure suspendExecution; cdecl;
  end;
  TNSScriptCommand = class(TOCGenericImport<NSScriptCommandClass, NSScriptCommand>)  end;

  NSScriptCoercionHandlerClass = interface(NSObjectClass)
    ['{D7FBD124-F2F4-4336-9686-E527C6B678E5}']
    {class} function sharedCoercionHandler: Pointer; cdecl;
  end;
  NSScriptCoercionHandler = interface(NSObject)
    ['{FA8D67A6-B214-4F48-9CBC-1812B2488F0E}']
    function coerceValue(value: Pointer; toClass: Pointer): Pointer; cdecl;
    procedure registerCoercer(coercer: Pointer; selector: SEL; toConvertFromClass: Pointer; toClass: Pointer); cdecl;
  end;
  TNSScriptCoercionHandler = class(TOCGenericImport<NSScriptCoercionHandlerClass, NSScriptCoercionHandler>)  end;

  NSRunLoopClass = interface(NSObjectClass)
    ['{053D85B7-3856-4CEC-BD92-BCDFBE62DD0F}']
    {class} function currentRunLoop: Pointer; cdecl;
    {class} function mainRunLoop: Pointer; cdecl;
  end;
  NSRunLoop = interface(NSObject)
    ['{2B4561EB-056A-491D-BD95-87EA8221D5FD}']
    procedure acceptInputForMode(mode: NSString; beforeDate: NSDate); cdecl;
    procedure addPort(aPort: NSPort; forMode: NSString); cdecl;
    procedure addTimer(timer: NSTimer; forMode: NSString); cdecl;
    procedure cancelPerformSelector(aSelector: SEL; target: Pointer; argument: Pointer); cdecl;
    procedure cancelPerformSelectorsWithTarget(target: Pointer); cdecl;
    procedure configureAsServer; cdecl;
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

  NSScriptExecutionContextClass = interface(NSObjectClass)
    ['{9A07A461-1522-4206-9800-015190A2042C}']
    {class} function sharedScriptExecutionContext: Pointer; cdecl;
  end;
  NSScriptExecutionContext = interface(NSObject)
    ['{9528E257-DC2A-4CB5-B264-1569EB179476}']
    function objectBeingTested: Pointer; cdecl;
    function rangeContainerObject: Pointer; cdecl;
    procedure setObjectBeingTested(obj: Pointer); cdecl;
    procedure setRangeContainerObject(obj: Pointer); cdecl;
    procedure setTopLevelObject(obj: Pointer); cdecl;
    function topLevelObject: Pointer; cdecl;
  end;
  TNSScriptExecutionContext = class(TOCGenericImport<NSScriptExecutionContextClass, NSScriptExecutionContext>)  end;

  NSRecursiveLockClass = interface(NSObjectClass)
    ['{2BAE9833-74D2-41F6-87A3-0F01A364280E}']
  end;
  NSRecursiveLock = interface(NSObject)
    ['{A6268BC8-99EE-4571-8D45-A88156791B96}']
    function lockBeforeDate(limit: NSDate): Boolean; cdecl;
    function name: NSString; cdecl;
    procedure setName(n: NSString); cdecl;
    function tryLock: Boolean; cdecl;
  end;
  TNSRecursiveLock = class(TOCGenericImport<NSRecursiveLockClass, NSRecursiveLock>)  end;

  NSScriptCommandDescriptionClass = interface(NSObjectClass)
    ['{01E11DE6-B006-4ABC-8FA7-C2BED1F67F11}']
  end;
  NSScriptCommandDescription = interface(NSObject)
    ['{A6B1AB95-F47A-4A43-8AC7-3E16D14C7D1A}']
    function appleEventClassCode: FourCharCode; cdecl;
    function appleEventCode: FourCharCode; cdecl;
    function appleEventCodeForArgumentWithName(argumentName: NSString): FourCharCode; cdecl;
    function appleEventCodeForReturnType: FourCharCode; cdecl;
    function argumentNames: NSArray; cdecl;
    function commandClassName: NSString; cdecl;
    function commandName: NSString; cdecl;
    function createCommandInstance: NSScriptCommand; cdecl;
    function createCommandInstanceWithZone(zone: Pointer): NSScriptCommand; cdecl;
    function initWithSuiteName(suiteName: NSString; commandName: NSString; dictionary: NSDictionary): Pointer; cdecl;
    function isOptionalArgumentWithName(argumentName: NSString): Boolean; cdecl;
    function returnType: NSString; cdecl;
    function suiteName: NSString; cdecl;
    function typeForArgumentWithName(argumentName: NSString): NSString; cdecl;
  end;
  TNSScriptCommandDescription = class(TOCGenericImport<NSScriptCommandDescriptionClass, NSScriptCommandDescription>)  end;

  NSOperationQueueClass = interface(NSObjectClass)
    ['{91B813BC-6BF0-42F7-8F67-81BF7A13D856}']
    {class} function currentQueue: Pointer; cdecl;
    {class} function mainQueue: Pointer; cdecl;
  end;
  NSOperationQueue = interface(NSObject)
    ['{D482188A-254C-48D4-8390-9217636BDBED}']
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

  NSOrthographyClass = interface(NSObjectClass)
    ['{0EEBA032-E078-4691-9250-7B21B6C1CD8C}']
    {class} function orthographyWithDominantScript(script: NSString; languageMap: NSDictionary): Pointer; cdecl;
  end;
  NSOrthography = interface(NSObject)
    ['{82299054-53CF-4185-85C9-1043B24AF5E0}']
    function dominantLanguageForScript(script: NSString): NSString; cdecl;
    function initWithDominantScript(script: NSString; languageMap: NSDictionary): Pointer; cdecl;
    function languagesForScript(script: NSString): NSArray; cdecl;
  end;
  TNSOrthography = class(TOCGenericImport<NSOrthographyClass, NSOrthography>)  end;

  NSSetClass = interface(NSObjectClass)
    ['{8B827BFD-6D4F-4D12-9DF9-4E94FD301B25}']
    {class} function setWithArray(array_: NSArray): Pointer; cdecl;
    {class} function setWithObject(object_: Pointer): Pointer; cdecl;
    {class} function setWithObjects(setWithObjects: Pointer): Pointer; cdecl; overload;
    {class} function setWithObjects(objects: Pointer; count: NSUInteger): Pointer; cdecl; overload;
    {class} function setWithSet(set_: NSSet): Pointer; cdecl;
  end;
  NSSet = interface(NSObject)
    ['{04512521-E62D-46B1-A519-521DFAF0ACD2}']
    procedure addObserver(observer: NSObject; forKeyPath: NSString; options: NSKeyValueObservingOptions; context: Pointer); cdecl;
    function allObjects: NSArray; cdecl;
    function anyObject: Pointer; cdecl;
    function containsObject(anObject: Pointer): Boolean; cdecl;
    function count: NSUInteger; cdecl;
    function description: NSString; cdecl;
    function descriptionWithLocale(locale: Pointer): NSString; cdecl;
    function filteredSetUsingPredicate(predicate: NSPredicate): NSSet; cdecl;
    function initWithArray(array_: NSArray): Pointer; cdecl;
    function initWithObjects(initWithObjects: Pointer): Pointer; cdecl; overload;
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
    procedure removeObserver(observer: NSObject; forKeyPath: NSString); cdecl;
    function setByAddingObject(anObject: Pointer): NSSet; cdecl;
    function setByAddingObjectsFromArray(other: NSArray): NSSet; cdecl;
    function setByAddingObjectsFromSet(other: NSSet): NSSet; cdecl;
    procedure setValue(value: Pointer; forKey: NSString); cdecl;
    function sortedArrayUsingDescriptors(sortDescriptors: NSArray): NSArray; cdecl;
    function valueForKey(key: NSString): Pointer; cdecl;
  end;
  TNSSet = class(TOCGenericImport<NSSetClass, NSSet>)  end;

  NSOperationClass = interface(NSObjectClass)
    ['{C30A1B62-BC0D-4CA3-B008-B7DEE5ACF48D}']
  end;
  NSOperation = interface(NSObject)
    ['{F5F3D93D-DD6B-434F-A371-48C564B6DA44}']
    procedure addDependency(op: NSOperation); cdecl;
    procedure cancel; cdecl;
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

  NSNotificationCenterClass = interface(NSObjectClass)
    ['{7F8058EA-EEC7-4BF1-924A-9D7055CA6F27}']
    {class} function defaultCenter: Pointer; cdecl;
  end;
  NSNotificationCenter = interface(NSObject)
    ['{774E16BA-22B1-4053-B914-355808C40F8B}']
    procedure postNotification(notification: NSNotification); cdecl;
    procedure removeObserver(observer: Pointer); cdecl; overload;
    procedure addObserver(notificationObserver: Pointer; selector: SEL; name: Pointer; &object: Pointer); cdecl;
  end;
  TNSNotificationCenter = class(TOCGenericImport<NSNotificationCenterClass, NSNotificationCenter>)  end;

  NSNotificationQueueClass = interface(NSObjectClass)
    ['{C8C175D8-8135-4F3B-9288-2612CB789527}']
    {class} function defaultQueue: Pointer; cdecl;
  end;
  NSNotificationQueue = interface(NSObject)
    ['{1EAFCA44-A7BB-493A-8716-A1165F89E9D8}']
    procedure dequeueNotificationsMatching(notification: NSNotification; coalesceMask: NSUInteger); cdecl;
    procedure enqueueNotification(notification: NSNotification; postingStyle: NSPostingStyle); cdecl; overload;
    procedure enqueueNotification(notification: NSNotification; postingStyle: NSPostingStyle; coalesceMask: NSUInteger; forModes: NSArray); cdecl; overload;
    function initWithNotificationCenter(notificationCenter: NSNotificationCenter): Pointer; cdecl;
  end;
  TNSNotificationQueue = class(TOCGenericImport<NSNotificationQueueClass, NSNotificationQueue>)  end;

  NSNullClass = interface(NSObjectClass)
    ['{797B82FE-6C7F-4DBF-BDC5-A6BBD3C55739}']
    {class} function null: Pointer; cdecl;
  end;
  NSNull = interface(NSObject)
    ['{0A67D799-61FA-4662-BA21-92BF28C37E6D}']
  end;
  TNSNull = class(TOCGenericImport<NSNullClass, NSNull>)  end;

  NSScriptWhoseTestClass = interface(NSObjectClass)
    ['{7F531DDF-EF80-4811-8199-E5C62810F080}']
  end;
  NSScriptWhoseTest = interface(NSObject)
    ['{0C555287-E211-43D1-9835-B9EB097ED347}']
    function isTrue: Boolean; cdecl;
  end;
  TNSScriptWhoseTest = class(TOCGenericImport<NSScriptWhoseTestClass, NSScriptWhoseTest>)  end;

  NSPortMessageClass = interface(NSObjectClass)
    ['{A971950E-0866-4C99-910B-C02118EBFD8F}']
  end;
  NSPortMessage = interface(NSObject)
    ['{40AA5858-5106-49BF-A4E2-9B965723D113}']
    function components: NSArray; cdecl;
    function initWithSendPort(sendPort: NSPort; receivePort: NSPort; components: NSArray): Pointer; cdecl;
    function msgid: Longword; cdecl;
    function receivePort: NSPort; cdecl;
    function sendBeforeDate(date: NSDate): Boolean; cdecl;
    function sendPort: NSPort; cdecl;
    procedure setMsgid(msgid: Longword); cdecl;
  end;
  TNSPortMessage = class(TOCGenericImport<NSPortMessageClass, NSPortMessage>)  end;

  NSPortNameServerClass = interface(NSObjectClass)
    ['{E9C4685A-80DA-4E2D-A2F3-07F25FAB36F7}']
    {class} function systemDefaultPortNameServer: Pointer; cdecl;
  end;
  NSPortNameServer = interface(NSObject)
    ['{A8287A2E-7C73-4B73-A00D-5A63E8837272}']
    function portForName(name: NSString): NSPort; cdecl; overload;
    function portForName(name: NSString; host: NSString): NSPort; cdecl; overload;
    function registerPort(port: NSPort; name: NSString): Boolean; cdecl;
    function removePortForName(name: NSString): Boolean; cdecl;
  end;
  TNSPortNameServer = class(TOCGenericImport<NSPortNameServerClass, NSPortNameServer>)  end;

  NSPortClass = interface(NSObjectClass)
    ['{49E7FB3E-D8A0-475A-AF78-4730DF3369E2}']
    {class} function allocWithZone(zone: Pointer): Pointer; cdecl;
    {class} function port: Pointer; cdecl;
  end;
  NSPort = interface(NSObject)
    ['{2C8244E7-5429-48F6-9DDD-C1CA0A2FBF4C}']
    procedure addConnection(conn: NSConnection; toRunLoop: NSRunLoop; forMode: NSString); cdecl;
    function delegate: NSPortDelegate; cdecl;
    procedure invalidate; cdecl;
    function isValid: Boolean; cdecl;
    procedure removeConnection(conn: NSConnection; fromRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure removeFromRunLoop(runLoop: NSRunLoop; forMode: NSString); cdecl;
    function reservedSpaceLength: NSUInteger; cdecl;
    procedure scheduleInRunLoop(runLoop: NSRunLoop; forMode: NSString); cdecl;
    function sendBeforeDate(limitDate: NSDate; components: NSMutableArray; from: NSPort; reserved: NSUInteger): Boolean; cdecl; overload;
    function sendBeforeDate(limitDate: NSDate; msgid: NSUInteger; components: NSMutableArray; from: NSPort; reserved: NSUInteger): Boolean; cdecl; overload;
    procedure setDelegate(anObject: NSPortDelegate); cdecl;
  end;
  TNSPort = class(TOCGenericImport<NSPortClass, NSPort>)  end;

  NSPipeClass = interface(NSObjectClass)
    ['{C02DA69A-1A06-4411-88A9-E28C74F7DBA9}']
    {class} function pipe: Pointer; cdecl;
  end;
  NSPipe = interface(NSObject)
    ['{5A9F7ECC-A015-4035-A2C6-054813A24D2B}']
    function fileHandleForReading: NSFileHandle; cdecl;
    function fileHandleForWriting: NSFileHandle; cdecl;
    function init: Pointer; cdecl;
  end;
  TNSPipe = class(TOCGenericImport<NSPipeClass, NSPipe>)  end;

  NSPointerArrayClass = interface(NSObjectClass)
    ['{A79A1E10-23BA-4EBB-9433-35120431E2CE}']
    {class} function pointerArrayWithOptions(options: NSPointerFunctionsOptions): Pointer; cdecl;
    {class} function pointerArrayWithPointerFunctions(functions: NSPointerFunctions): Pointer; cdecl;
    {class} function pointerArrayWithStrongObjects: Pointer; cdecl;
    {class} function pointerArrayWithWeakObjects: Pointer; cdecl;
  end;
  NSPointerArray = interface(NSObject)
    ['{060B45A5-4E65-476C-AA4D-A3BD4AEA1B66}']
    procedure addPointer(pointer: Pointer); cdecl;
    function allObjects: NSArray; cdecl;
    procedure compact; cdecl;
    function count: NSUInteger; cdecl;
    function initWithOptions(options: NSPointerFunctionsOptions): Pointer; cdecl;
    function initWithPointerFunctions(functions: NSPointerFunctions): Pointer; cdecl;
    procedure insertPointer(item: Pointer; atIndex: NSUInteger); cdecl;
    function pointerAtIndex(index: NSUInteger): Pointer; cdecl;
    function pointerFunctions: NSPointerFunctions; cdecl;
    procedure removePointerAtIndex(index: NSUInteger); cdecl;
    procedure replacePointerAtIndex(index: NSUInteger; withPointer: Pointer); cdecl;
    procedure setCount(count: NSUInteger); cdecl;
  end;
  TNSPointerArray = class(TOCGenericImport<NSPointerArrayClass, NSPointerArray>)  end;

  NSPointerFunctionsClass = interface(NSObjectClass)
    ['{93FAF787-6361-4666-82E8-17BCBBD5BDFD}']
    {class} function pointerFunctionsWithOptions(options: NSPointerFunctionsOptions): Pointer; cdecl;
  end;
  NSPointerFunctions = interface(NSObject)
    ['{4D27BF10-2B97-403F-B83D-A953650A14B1}']
    function initWithOptions(options: NSPointerFunctionsOptions): Pointer; cdecl;
    function usesStrongWriteBarrier: Boolean; cdecl;
    function usesWeakReadAndWriteBarriers: Boolean; cdecl;
  end;
  TNSPointerFunctions = class(TOCGenericImport<NSPointerFunctionsClass, NSPointerFunctions>)  end;

  NSCoderClass = interface(NSObjectClass)
    ['{FA8F242F-494A-4803-A478-61BE98B9B1C7}']
  end;
  NSCoder = interface(NSObject)
    ['{4B8D76E7-EC96-4C2D-B64A-32E0EA17EA5B}']
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
    function decodeNXObject: Pointer; cdecl;
    function decodeObject: Pointer; cdecl;
    function decodeObjectForKey(key: NSString): Pointer; cdecl;
    function decodePoint: NSPoint; cdecl;
    function decodePointForKey(key: NSString): NSPoint; cdecl;
    function decodePropertyList: Pointer; cdecl;
    function decodeRect: NSRect; cdecl;
    function decodeRectForKey(key: NSString): NSRect; cdecl;
    function decodeSize: NSSize; cdecl;
    function decodeSizeForKey(key: NSString): NSSize; cdecl;
    procedure decodeValueOfObjCType(type_: MarshaledAString; at: Pointer); cdecl;
    procedure decodeValuesOfObjCTypes(decodeValuesOfObjCTypes: MarshaledAString); cdecl;
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
    procedure encodeNXObject(object_: Pointer); cdecl;
    procedure encodeObject(object_: Pointer); cdecl; overload;
    procedure encodeObject(objv: Pointer; forKey: NSString); cdecl; overload;
    procedure encodePoint(point: NSPoint); cdecl; overload;
    procedure encodePoint(point: NSPoint; forKey: NSString); cdecl; overload;
    procedure encodePropertyList(aPropertyList: Pointer); cdecl;
    procedure encodeRect(rect: NSRect); cdecl; overload;
    procedure encodeRect(rect: NSRect; forKey: NSString); cdecl; overload;
    procedure encodeRootObject(rootObject: Pointer); cdecl;
    procedure encodeSize(size: NSSize); cdecl; overload;
    procedure encodeSize(size: NSSize; forKey: NSString); cdecl; overload;
    procedure encodeValueOfObjCType(type_: MarshaledAString; at: Pointer); cdecl;
    procedure encodeValuesOfObjCTypes(encodeValuesOfObjCTypes: MarshaledAString); cdecl;
    function objectZone: Pointer; cdecl;
    procedure setObjectZone(zone: Pointer); cdecl;
    function systemVersion: Longword; cdecl;
    function versionForClassName(className: NSString): NSInteger; cdecl;
  end;
  TNSCoder = class(TOCGenericImport<NSCoderClass, NSCoder>)  end;

  NSConditionClass = interface(NSObjectClass)
    ['{1C6C957F-4DC6-4E10-82C5-FCC7F00A0F98}']
  end;
  NSCondition = interface(NSObject)
    ['{E7D8118D-F4AB-46A9-9FE2-B1CE938CA8BA}']
    procedure broadcast; cdecl;
    function name: NSString; cdecl;
    procedure setName(n: NSString); cdecl;
    procedure signal; cdecl;
    procedure wait; cdecl;
    function waitUntilDate(limit: NSDate): Boolean; cdecl;
  end;
  TNSCondition = class(TOCGenericImport<NSConditionClass, NSCondition>)  end;

  NSConditionLockClass = interface(NSObjectClass)
    ['{B10184ED-74FF-4D5C-A666-E93BBF214DF0}']
  end;
  NSConditionLock = interface(NSObject)
    ['{96289A78-50B5-4FDA-9BB7-8089581CB9B0}']
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

  NSCalendarClass = interface(NSObjectClass)
    ['{3D1F84D2-841D-44BB-8D48-2AD25EEEA07A}']
    {class} function autoupdatingCurrentCalendar: Pointer; cdecl;
    {class} function currentCalendar: Pointer; cdecl;
  end;
  NSCalendar = interface(NSObject)
    ['{C78DD97E-6C63-448C-89E2-14416406C8A2}']
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
    ['{4585D306-4E0D-4183-9592-03427184D04D}']
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
    ['{08EB510F-8DEB-4E32-A4B6-28F90EBA5468}']
    function bitmapRepresentation: NSData; cdecl;
    function characterIsMember(aCharacter: unichar): Boolean; cdecl;
    function hasMemberInPlane(thePlane: Byte): Boolean; cdecl;
    function invertedSet: NSCharacterSet; cdecl;
    function isSupersetOfSet(theOtherSet: NSCharacterSet): Boolean; cdecl;
    function longCharacterIsMember(theLongChar: UTF32Char): Boolean; cdecl;
  end;
  TNSCharacterSet = class(TOCGenericImport<NSCharacterSetClass, NSCharacterSet>)  end;

  NSClassDescriptionClass = interface(NSObjectClass)
    ['{755ECB0E-0B7A-4013-AC84-FC5255095605}']
    {class} function classDescriptionForClass(aClass: Pointer): Pointer; cdecl;
    {class} procedure invalidateClassDescriptionCache; cdecl;
    {class} procedure registerClassDescription(description: NSClassDescription; forClass: Pointer); cdecl;
  end;
  NSClassDescription = interface(NSObject)
    ['{F7D67D05-FF7F-4443-9618-2796D3E57AB5}']
    function attributeKeys: NSArray; cdecl;
    function inverseForRelationshipKey(relationshipKey: NSString): NSString; cdecl;
    function toManyRelationshipKeys: NSArray; cdecl;
    function toOneRelationshipKeys: NSArray; cdecl;
  end;
  TNSClassDescription = class(TOCGenericImport<NSClassDescriptionClass, NSClassDescription>)  end;

  NSConnectionClass = interface(NSObjectClass)
    ['{05A09160-67B0-40B2-830F-C93CD7F337E1}']
    {class} function allConnections: NSArray; cdecl;
    {class} function connectionWithReceivePort(receivePort: NSPort; sendPort: NSPort): Pointer; cdecl;
    {class} function connectionWithRegisteredName(name: NSString; host: NSString): Pointer; cdecl; overload;
    {class} function connectionWithRegisteredName(name: NSString; host: NSString; usingNameServer: NSPortNameServer): Pointer; cdecl; overload;
    {class} function currentConversation: Pointer; cdecl;
    {class} function defaultConnection: Pointer; cdecl;
    {class} function rootProxyForConnectionWithRegisteredName(name: NSString; host: NSString): NSDistantObject; cdecl; overload;
    {class} function rootProxyForConnectionWithRegisteredName(name: NSString; host: NSString; usingNameServer: NSPortNameServer): NSDistantObject; cdecl; overload;
    {class} function serviceConnectionWithName(name: NSString; rootObject: Pointer): Pointer; cdecl; overload;
    {class} function serviceConnectionWithName(name: NSString; rootObject: Pointer; usingNameServer: NSPortNameServer): Pointer; cdecl; overload;
  end;
  NSConnection = interface(NSObject)
    ['{C8546B17-60AF-4EDE-97C4-C51783C5FA19}']
    procedure addRequestMode(rmode: NSString); cdecl;
    procedure addRunLoop(runloop: NSRunLoop); cdecl;
    function delegate: NSConnectionDelegate; cdecl;
    procedure enableMultipleThreads; cdecl;
    function independentConversationQueueing: Boolean; cdecl;
    function initWithReceivePort(receivePort: NSPort; sendPort: NSPort): Pointer; cdecl;
    procedure invalidate; cdecl;
    function isValid: Boolean; cdecl;
    function localObjects: NSArray; cdecl;
    function multipleThreadsEnabled: Boolean; cdecl;
    function receivePort: NSPort; cdecl;
    function registerName(name: NSString): Boolean; cdecl; overload;
    function registerName(name: NSString; withNameServer: NSPortNameServer): Boolean; cdecl; overload;
    function remoteObjects: NSArray; cdecl;
    procedure removeRequestMode(rmode: NSString); cdecl;
    procedure removeRunLoop(runloop: NSRunLoop); cdecl;
    function replyTimeout: NSTimeInterval; cdecl;
    function requestModes: NSArray; cdecl;
    function requestTimeout: NSTimeInterval; cdecl;
    function rootObject: Pointer; cdecl;
    function rootProxy: NSDistantObject; cdecl;
    procedure runInNewThread; cdecl;
    function sendPort: NSPort; cdecl;
    procedure setDelegate(anObject: NSConnectionDelegate); cdecl;
    procedure setIndependentConversationQueueing(yorn: Boolean); cdecl;
    procedure setReplyTimeout(ti: NSTimeInterval); cdecl;
    procedure setRequestTimeout(ti: NSTimeInterval); cdecl;
    procedure setRootObject(anObject: Pointer); cdecl;
    function statistics: NSDictionary; cdecl;
  end;
  TNSConnection = class(TOCGenericImport<NSConnectionClass, NSConnection>)  end;

  NSDateClass = interface(NSObjectClass)
    ['{D2D0F5C8-28AE-4275-8385-232C5CCDE8C6}']
    {class} function date: Pointer; cdecl;
    {class} function dateWithNaturalLanguageString(string_: NSString): Pointer; cdecl; overload;
    {class} function dateWithNaturalLanguageString(string_: NSString; locale: Pointer): Pointer; cdecl; overload;
    {class} function dateWithString(aString: NSString): Pointer; cdecl;
    {class} function dateWithTimeInterval(ti: NSTimeInterval; sinceDate: NSDate): Pointer; cdecl;
    {class} function dateWithTimeIntervalSince1970(secs: NSTimeInterval): Pointer; cdecl;
    {class} function dateWithTimeIntervalSinceNow(secs: NSTimeInterval): Pointer; cdecl;
    {class} function dateWithTimeIntervalSinceReferenceDate(secs: NSTimeInterval): Pointer; cdecl;
    {class} function distantFuture: Pointer; cdecl;
    {class} function distantPast: Pointer; cdecl;
    {class} function timeIntervalSinceReferenceDate: NSTimeInterval; cdecl; overload;
  end;
  NSDate = interface(NSObject)
    ['{C849F0D5-DD07-4D2C-AC4F-85DEDE5BE35C}']
    function addTimeInterval(seconds: NSTimeInterval): Pointer; cdecl;
    function compare(other: NSDate): NSComparisonResult; cdecl;
    function dateByAddingTimeInterval(ti: NSTimeInterval): Pointer; cdecl;
    function dateWithCalendarFormat(format: NSString; timeZone: NSTimeZone): NSCalendarDate; cdecl;
    function description: NSString; cdecl;
    function descriptionWithCalendarFormat(format: NSString; timeZone: NSTimeZone; locale: Pointer): NSString; cdecl;
    function descriptionWithLocale(locale: Pointer): NSString; cdecl;
    function earlierDate(anotherDate: NSDate): NSDate; cdecl;
    function init: Pointer; cdecl;
    function initWithString(description: NSString): Pointer; cdecl;
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

  NSDateComponentsClass = interface(NSObjectClass)
    ['{305F4053-713E-4B06-A15A-0D8F33D2772A}']
  end;
  NSDateComponents = interface(NSObject)
    ['{737A06FB-53C4-42E4-8A1D-B432608DBD06}']
    function day: NSInteger; cdecl;
    function era: NSInteger; cdecl;
    function hour: NSInteger; cdecl;
    function minute: NSInteger; cdecl;
    function month: NSInteger; cdecl;
    function quarter: NSInteger; cdecl;
    function second: NSInteger; cdecl;
    procedure setDay(v: NSInteger); cdecl;
    procedure setEra(v: NSInteger); cdecl;
    procedure setHour(v: NSInteger); cdecl;
    procedure setMinute(v: NSInteger); cdecl;
    procedure setMonth(v: NSInteger); cdecl;
    procedure setQuarter(v: NSInteger); cdecl;
    procedure setSecond(v: NSInteger); cdecl;
    procedure setWeek(v: NSInteger); cdecl;
    procedure setWeekday(v: NSInteger); cdecl;
    procedure setWeekdayOrdinal(v: NSInteger); cdecl;
    procedure setYear(v: NSInteger); cdecl;
    function week: NSInteger; cdecl;
    function weekday: NSInteger; cdecl;
    function weekdayOrdinal: NSInteger; cdecl;
    function year: NSInteger; cdecl;
  end;
  TNSDateComponents = class(TOCGenericImport<NSDateComponentsClass, NSDateComponents>)  end;

  NSUserDefaultsClass = interface(NSObjectClass)
    ['{A0881DFD-C49E-4ECC-ADDD-10F97D25A8B8}']
    {class} procedure resetStandardUserDefaults; cdecl;
    {class} function standardUserDefaults: Pointer; cdecl;
  end;
  NSUserDefaults = interface(NSObject)
    ['{76A26CB2-96A6-47B9-A540-52A7C67FA94D}']
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

  NSValueTransformerClass = interface(NSObjectClass)
    ['{ED411CCC-FEAE-4C64-B4EE-8D826DB9CC0E}']
    {class} function allowsReverseTransformation: Boolean; cdecl;
    {class} procedure setValueTransformer(transformer: NSValueTransformer; forName: NSString); cdecl;
    {class} function valueTransformerForName(name: NSString): Pointer; cdecl;
    {class} function valueTransformerNames: NSArray; cdecl;
  end;
  NSValueTransformer = interface(NSObject)
    ['{401B917A-E80C-4CD4-B981-7116CB8FC31B}']
    function reverseTransformedValue(value: Pointer): Pointer; cdecl;
    function transformedValue(value: Pointer): Pointer; cdecl;
  end;
  TNSValueTransformer = class(TOCGenericImport<NSValueTransformerClass, NSValueTransformer>)  end;

  NSValueClass = interface(NSObjectClass)
    ['{36AA6975-7D23-4ED2-B0E3-96E3A423BCD4}']
    {class} function value(value: Pointer; withObjCType: MarshaledAString): Pointer; cdecl;
    {class} function valueWithBytes(value: Pointer; objCType: MarshaledAString): Pointer; cdecl;
    {class} function valueWithNonretainedObject(anObject: Pointer): Pointer; cdecl;
    {class} function valueWithPoint(point: NSPoint): Pointer; cdecl;
    {class} function valueWithPointer(pointer: Pointer): Pointer; cdecl;
    {class} function valueWithRange(range: NSRange): Pointer; cdecl;
    {class} function valueWithRect(rect: NSRect): Pointer; cdecl;
    {class} function valueWithSize(size: NSSize): Pointer; cdecl;
    {class} function valueWithCMTime(time: CMTime): Pointer; cdecl;
  end;
  NSValue = interface(NSObject)
    ['{FEF18776-4371-43F5-AB58-8168AA8D902D}']
    procedure getValue(value: Pointer); cdecl;
    function initWithBytes(value: Pointer; objCType: MarshaledAString): Pointer; cdecl;
    function isEqualToValue(value: NSValue): Boolean; cdecl;
    function nonretainedObjectValue: Pointer; cdecl;
    function objCType: MarshaledAString; cdecl;
    function pointValue: NSPoint; cdecl;
    function pointerValue: Pointer; cdecl;
    function rangeValue: NSRange; cdecl;
    function rectValue: NSRect; cdecl;
    function sizeValue: NSSize; cdecl;
  end;
  TNSValue = class(TOCGenericImport<NSValueClass, NSValue>)  end;

  NSDataClass = interface(NSObjectClass)
    ['{6B8C90E6-F881-47D9-8286-86139FAAACEB}']
    {class} function data: Pointer; cdecl;
    {class} function dataWithBytes(bytes: Pointer; length: NSUInteger): Pointer; cdecl;
    {class} function dataWithBytesNoCopy(bytes: Pointer; length: NSUInteger): Pointer; cdecl; overload;
    {class} function dataWithBytesNoCopy(bytes: Pointer; length: NSUInteger; freeWhenDone: Boolean): Pointer; cdecl; overload;
    {class} function dataWithContentsOfFile(path: NSString): Pointer; cdecl; overload;
    {class} function dataWithContentsOfFile(path: NSString; options: NSDataReadingOptions; error: PPointer): Pointer; cdecl; overload;
    {class} function dataWithContentsOfMappedFile(path: NSString): Pointer; cdecl;
    {class} function dataWithContentsOfURL(url: NSURL): Pointer; cdecl; overload;
    {class} function dataWithContentsOfURL(url: NSURL; options: NSDataReadingOptions; error: PPointer): Pointer; cdecl; overload;
    {class} function dataWithData(data: NSData): Pointer; cdecl;
  end;
  NSData = interface(NSObject)
    ['{E2645613-B973-4F1C-93F1-950D9654506A}']
    function bytes: Pointer; cdecl;
    function description: NSString; cdecl;
    procedure getBytes(buffer: Pointer); cdecl; overload;
    procedure getBytes(buffer: Pointer; length: NSUInteger); cdecl; overload;
    procedure getBytes(buffer: Pointer; range: NSRange); cdecl; overload;
    function initWithBytes(bytes: Pointer; length: NSUInteger): Pointer; cdecl;
    function initWithBytesNoCopy(bytes: Pointer; length: NSUInteger): Pointer; cdecl; overload;
    function initWithBytesNoCopy(bytes: Pointer; length: NSUInteger; freeWhenDone: Boolean): Pointer; cdecl; overload;
    function initWithContentsOfFile(path: NSString): Pointer; cdecl; overload;
    function initWithContentsOfFile(path: NSString; options: NSDataReadingOptions; error: PPointer): Pointer; cdecl; overload;
    function initWithContentsOfMappedFile(path: NSString): Pointer; cdecl;
    function initWithContentsOfURL(url: NSURL): Pointer; cdecl; overload;
    function initWithContentsOfURL(url: NSURL; options: NSDataReadingOptions; error: PPointer): Pointer; cdecl; overload;
    function initWithData(data: NSData): Pointer; cdecl;
    function isEqualToData(other: NSData): Boolean; cdecl;
    function length: NSUInteger; cdecl;
    function rangeOfData(dataToFind: NSData; options: NSDataSearchOptions; range: NSRange): NSRange; cdecl;
    function subdataWithRange(range: NSRange): NSData; cdecl;
    function writeToFile(path: NSString; atomically: Boolean): Boolean; cdecl; overload;
    function writeToFile(path: NSString; options: NSDataWritingOptions; error: PPointer): Boolean; cdecl; overload;
    function writeToURL(url: NSURL; atomically: Boolean): Boolean; cdecl; overload;
    function writeToURL(url: NSURL; options: NSDataWritingOptions; error: PPointer): Boolean; cdecl; overload;
  end;
  TNSData = class(TOCGenericImport<NSDataClass, NSData>)  end;

  NSAppleScriptClass = interface(NSObjectClass)
    ['{BF13F099-F9E7-46DB-A5F0-FD25330836EF}']
  end;
  NSAppleScript = interface(NSObject)
    ['{0AB1D902-25CE-4F0B-A3BE-C4ABEDEB88BC}']
    function compileAndReturnError(errorInfo: NSDictionary): Boolean; cdecl;
    function executeAndReturnError(errorInfo: NSDictionary): NSAppleEventDescriptor; cdecl;
    function executeAppleEvent(event: NSAppleEventDescriptor; error: NSDictionary): NSAppleEventDescriptor; cdecl;
    function initWithContentsOfURL(url: NSURL; error: NSDictionary): Pointer; cdecl;
    function initWithSource(source: NSString): Pointer; cdecl;
    function isCompiled: Boolean; cdecl;
    function source: NSString; cdecl;
  end;
  TNSAppleScript = class(TOCGenericImport<NSAppleScriptClass, NSAppleScript>)  end;

  NSXMLParserClass = interface(NSObjectClass)
    ['{54530ECF-9FD7-41A4-8446-4A645E06CE0D}']
  end;
  NSXMLParser = interface(NSObject)
    ['{BD6572D1-7903-4D4E-804F-D0EE501B6749}']
    procedure abortParsing; cdecl;
    function columnNumber: NSInteger; cdecl;
    function delegate: NSXMLParserDelegate; cdecl;
    function initWithContentsOfURL(url: NSURL): Pointer; cdecl;
    function initWithData(data: NSData): Pointer; cdecl;
    function lineNumber: NSInteger; cdecl;
    function parse: Boolean; cdecl;
    function parserError: NSError; cdecl;
    function publicID: NSString; cdecl;
    procedure setDelegate(delegate: NSXMLParserDelegate); cdecl;
    procedure setShouldProcessNamespaces(shouldProcessNamespaces: Boolean); cdecl;
    procedure setShouldReportNamespacePrefixes(shouldReportNamespacePrefixes: Boolean); cdecl;
    procedure setShouldResolveExternalEntities(shouldResolveExternalEntities: Boolean); cdecl;
    function shouldProcessNamespaces: Boolean; cdecl;
    function shouldReportNamespacePrefixes: Boolean; cdecl;
    function shouldResolveExternalEntities: Boolean; cdecl;
    function systemID: NSString; cdecl;
  end;
  TNSXMLParser = class(TOCGenericImport<NSXMLParserClass, NSXMLParser>)  end;

  NSArrayClass = interface(NSObjectClass)
    ['{986AF97D-36D2-4F5C-85AF-E1FBF30CE230}']
    {class} function arrayWithArray(array_: NSArray): Pointer; cdecl;
    {class} function arrayWithContentsOfFile(path: NSString): Pointer; cdecl;
    {class} function arrayWithContentsOfURL(url: NSURL): Pointer; cdecl;
    {class} function arrayWithObject(anObject: Pointer): Pointer; cdecl;
    {class} function arrayWithObjects(arrayWithObjects: Pointer): Pointer; cdecl; overload;
    {class} function arrayWithObjects(objects: Pointer; count: NSUInteger): Pointer; cdecl; overload;
  end;
  NSArray = interface(NSObject)
    ['{346F966C-9BD0-4E45-AA69-E14F8B7041FC}']
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
    function indexOfObject(obj: Pointer; inSortedRange: NSRange; options: NSBinarySearchingOptions; usingComparator: NSComparator): NSUInteger; cdecl; overload;
    function indexOfObjectIdenticalTo(anObject: Pointer): NSUInteger; cdecl; overload;
    function indexOfObjectIdenticalTo(anObject: Pointer; inRange: NSRange): NSUInteger; cdecl; overload;
    function initWithArray(array_: NSArray): Pointer; cdecl; overload;
    function initWithArray(array_: NSArray; copyItems: Boolean): Pointer; cdecl; overload;
    function initWithContentsOfFile(path: NSString): Pointer; cdecl;
    function initWithContentsOfURL(url: NSURL): Pointer; cdecl;
    function initWithObjects(initWithObjects: Pointer): Pointer; cdecl; overload;
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
    procedure removeObserver(observer: NSObject; fromObjectsAtIndexes: NSIndexSet; forKeyPath: NSString); cdecl; overload;
    function reverseObjectEnumerator: NSEnumerator; cdecl;
    procedure setValue(value: Pointer; forKey: NSString); cdecl;
    function sortedArrayHint: NSData; cdecl;
    function sortedArrayUsingComparator(cmptr: NSComparator): NSArray; cdecl;
    function sortedArrayUsingDescriptors(sortDescriptors: NSArray): NSArray; cdecl;
    function sortedArrayUsingSelector(comparator: SEL): NSArray; cdecl;
    function sortedArrayWithOptions(opts: NSSortOptions; usingComparator: NSComparator): NSArray; cdecl;
    function subarrayWithRange(range: NSRange): NSArray; cdecl;
    function valueForKey(key: NSString): Pointer; cdecl;
    function writeToFile(path: NSString; atomically: Boolean): Boolean; cdecl;
    function writeToURL(url: NSURL; atomically: Boolean): Boolean; cdecl;
  end;
  TNSArray = class(TOCGenericImport<NSArrayClass, NSArray>)  end;

  NSAffineTransformClass = interface(NSObjectClass)
    ['{E8EF81FE-F141-440B-9E21-79526A93B885}']
    {class} function transform: Pointer; cdecl;
  end;
  NSAffineTransform = interface(NSObject)
    ['{B00709E8-4346-4086-BF73-E585A99FC096}']
    procedure appendTransform(transform: NSAffineTransform); cdecl;
    function initWithTransform(transform: NSAffineTransform): Pointer; cdecl;
    procedure invert; cdecl;
    procedure prependTransform(transform: NSAffineTransform); cdecl;
    procedure rotateByDegrees(angle: Single); cdecl;
    procedure rotateByRadians(angle: Single); cdecl;
    procedure scaleBy(scale: Single); cdecl;
    procedure scaleXBy(scaleX: Single; yBy: Single); cdecl;
    procedure setTransformStruct(transformStruct: NSAffineTransformStruct); cdecl;
    function transformPoint(aPoint: NSPoint): NSPoint; cdecl;
    function transformSize(aSize: NSSize): NSSize; cdecl;
    function transformStruct: NSAffineTransformStruct; cdecl;
    procedure translateXBy(deltaX: Single; yBy: Single); cdecl;
  end;
  TNSAffineTransform = class(TOCGenericImport<NSAffineTransformClass, NSAffineTransform>)  end;

  NSAppleEventDescriptorClass = interface(NSObjectClass)
    ['{5206D101-2500-431B-B904-15CC85C89096}']
    {class} function appleEventWithEventClass(eventClass: AEEventClass; eventID: AEEventID; targetDescriptor: NSAppleEventDescriptor; returnID: AEReturnID; transactionID: AETransactionID): Pointer; cdecl;
    {class} function descriptorWithBoolean(boolean: Boolean): Pointer; cdecl;
    {class} function descriptorWithDescriptorType(descriptorType: DescType; bytes: Pointer; length: NSUInteger): Pointer; cdecl; overload;
    {class} function descriptorWithDescriptorType(descriptorType: DescType; data: NSData): Pointer; cdecl; overload;
    {class} function descriptorWithEnumCode(enumerator: OSType): Pointer; cdecl;
    {class} function descriptorWithInt32(signedInt: SInt32): Pointer; cdecl;
    {class} function descriptorWithString(string_: NSString): Pointer; cdecl;
    {class} function descriptorWithTypeCode(typeCode: OSType): Pointer; cdecl;
    {class} function listDescriptor: Pointer; cdecl;
    {class} function nullDescriptor: Pointer; cdecl;
    {class} function recordDescriptor: Pointer; cdecl;
  end;
  NSAppleEventDescriptor = interface(NSObject)
    ['{B67238FA-DC1D-4332-89D4-A14A2973C0CB}']
    function aeDesc: AEDesc; cdecl;
    function attributeDescriptorForKeyword(keyword: AEKeyword): NSAppleEventDescriptor; cdecl;
    function booleanValue: Boolean; cdecl;
    function coerceToDescriptorType(descriptorType: DescType): NSAppleEventDescriptor; cdecl;
    function data: NSData; cdecl;
    function descriptorAtIndex(index: NSInteger): NSAppleEventDescriptor; cdecl;
    function descriptorForKeyword(keyword: AEKeyword): NSAppleEventDescriptor; cdecl;
    function descriptorType: DescType; cdecl;
    function enumCodeValue: OSType; cdecl;
    function eventClass: AEEventClass; cdecl;
    function eventID: AEEventID; cdecl;
    function initListDescriptor: Pointer; cdecl;
    function initRecordDescriptor: Pointer; cdecl;
    function initWithAEDescNoCopy(aeDesc: AEDesc): Pointer; cdecl;
    function initWithDescriptorType(descriptorType: DescType; bytes: Pointer; length: NSUInteger): Pointer; cdecl; overload;
    function initWithDescriptorType(descriptorType: DescType; data: NSData): Pointer; cdecl; overload;
    function initWithEventClass(eventClass: AEEventClass; eventID: AEEventID; targetDescriptor: NSAppleEventDescriptor; returnID: AEReturnID; transactionID: AETransactionID): Pointer; cdecl;
    procedure insertDescriptor(descriptor: NSAppleEventDescriptor; atIndex: NSInteger); cdecl;
    function int32Value: SInt32; cdecl;
    function keywordForDescriptorAtIndex(index: NSInteger): AEKeyword; cdecl;
    function numberOfItems: NSInteger; cdecl;
    function paramDescriptorForKeyword(keyword: AEKeyword): NSAppleEventDescriptor; cdecl;
    procedure removeDescriptorAtIndex(index: NSInteger); cdecl;
    procedure removeDescriptorWithKeyword(keyword: AEKeyword); cdecl;
    procedure removeParamDescriptorWithKeyword(keyword: AEKeyword); cdecl;
    function returnID: AEReturnID; cdecl;
    procedure setAttributeDescriptor(descriptor: NSAppleEventDescriptor; forKeyword: AEKeyword); cdecl;
    procedure setDescriptor(descriptor: NSAppleEventDescriptor; forKeyword: AEKeyword); cdecl;
    procedure setParamDescriptor(descriptor: NSAppleEventDescriptor; forKeyword: AEKeyword); cdecl;
    function stringValue: NSString; cdecl;
    function transactionID: AETransactionID; cdecl;
    function typeCodeValue: OSType; cdecl;
  end;
  TNSAppleEventDescriptor = class(TOCGenericImport<NSAppleEventDescriptorClass, NSAppleEventDescriptor>)  end;

  NSAppleEventManagerClass = interface(NSObjectClass)
    ['{4C2C9633-E241-4A99-8723-A00A3A131130}']
    {class} function sharedAppleEventManager: Pointer; cdecl;
  end;
  NSAppleEventManager = interface(NSObject)
    ['{80BA1348-D346-45A2-B988-FC2A74E6E0D0}']
    function appleEventForSuspensionID(suspensionID: NSAppleEventManagerSuspensionID): NSAppleEventDescriptor; cdecl;
    function currentAppleEvent: NSAppleEventDescriptor; cdecl;
    function currentReplyAppleEvent: NSAppleEventDescriptor; cdecl;
    function dispatchRawAppleEvent(theAppleEvent: Pointer; withRawReply: Pointer; handlerRefCon: SRefCon): OSErr; cdecl;
    procedure removeEventHandlerForEventClass(eventClass: AEEventClass; andEventID: AEEventID); cdecl;
    function replyAppleEventForSuspensionID(suspensionID: NSAppleEventManagerSuspensionID): NSAppleEventDescriptor; cdecl;
    procedure resumeWithSuspensionID(suspensionID: NSAppleEventManagerSuspensionID); cdecl;
    procedure setCurrentAppleEventAndReplyEventWithSuspensionID(suspensionID: NSAppleEventManagerSuspensionID); cdecl;
    procedure setEventHandler(handler: Pointer; andSelector: SEL; forEventClass: AEEventClass; andEventID: AEEventID); cdecl;
    function suspendCurrentAppleEvent: NSAppleEventManagerSuspensionID; cdecl;
  end;
  TNSAppleEventManager = class(TOCGenericImport<NSAppleEventManagerClass, NSAppleEventManager>)  end;

  NSAssertionHandlerClass = interface(NSObjectClass)
    ['{6359048B-0176-4237-8F0D-BE643444DD18}']
    {class} function currentHandler: Pointer; cdecl;
  end;
  NSAssertionHandler = interface(NSObject)
    ['{A2657F10-C451-4DA8-8240-736F5D57A272}']
  end;
  TNSAssertionHandler = class(TOCGenericImport<NSAssertionHandlerClass, NSAssertionHandler>)  end;

  NSBundleClass = interface(NSObjectClass)
    ['{BD9893C4-4712-4DF9-97FF-CF764C17944F}']
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
    ['{9EAD5ACF-08F5-4C97-B61C-20FD66B392BD}']
    function URLForAuxiliaryExecutable(executableName: NSString): NSURL; cdecl;
    function URLForResource(name: NSString; withExtension: NSString): NSURL; cdecl; overload;
    function URLForResource(name: NSString; withExtension: NSString; subdirectory: NSString): NSURL; cdecl; overload;
    function URLForResource(name: NSString; withExtension: NSString; subdirectory: NSString; localization: NSString): NSURL; cdecl; overload;
    function URLsForResourcesWithExtension(ext: NSString; subdirectory: NSString): NSArray; cdecl; overload;
    function URLsForResourcesWithExtension(ext: NSString; subdirectory: NSString; localization: NSString): NSArray; cdecl; overload;
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
    function loadAndReturnError(error: PPointer): Boolean; cdecl;
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
    function preflightAndReturnError(error: PPointer): Boolean; cdecl;
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
    ['{7A9310E6-BF84-4F83-9128-FB12E3294038}']
  end;
  NSCache = interface(NSObject)
    ['{836FABDF-32BE-4454-A763-4DF488EC30A5}']
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

  NSCachedURLResponseClass = interface(NSObjectClass)
    ['{3C85FA22-3FD6-411D-8732-FA9BB3C3D58B}']
  end;
  NSCachedURLResponse = interface(NSObject)
    ['{9AACEFC7-C780-47BC-BCC4-F95C3E13C5C5}']
    function data: NSData; cdecl;
    function initWithResponse(response: NSURLResponse; data: NSData): Pointer; cdecl; overload;
    function initWithResponse(response: NSURLResponse; data: NSData; userInfo: NSDictionary; storagePolicy: NSURLCacheStoragePolicy): Pointer; cdecl; overload;
    function response: NSURLResponse; cdecl;
    function storagePolicy: NSURLCacheStoragePolicy; cdecl;
    function userInfo: NSDictionary; cdecl;
  end;
  TNSCachedURLResponse = class(TOCGenericImport<NSCachedURLResponseClass, NSCachedURLResponse>)  end;

  NSAttributedStringClass = interface(NSObjectClass)
    ['{3F097201-1AF3-49D3-9DC0-EF5B65FB6B2C}']
  end;
  NSAttributedString = interface(NSObject)
    ['{84D7ED86-27D3-4AE3-9E97-5372EC1911E3}']
    function attribute(attrName: NSString; atIndex: NSUInteger; effectiveRange: PNSRange): Pointer; cdecl; overload;
    function attribute(attrName: NSString; atIndex: NSUInteger; longestEffectiveRange: PNSRange; inRange: NSRange): Pointer; cdecl; overload;
    function attributedSubstringFromRange(range: NSRange): Pointer; cdecl;
    function attributesAtIndex(location: NSUInteger; effectiveRange: PNSRange): NSDictionary; cdecl; overload;
    function attributesAtIndex(location: NSUInteger; longestEffectiveRange: PNSRange; inRange: NSRange): NSDictionary; cdecl; overload;
    function initWithAttributedString(attrStr: NSAttributedString): Pointer; cdecl;
    function initWithString(str: NSString): Pointer; cdecl; overload;
    function initWithString(str: NSString; attributes: NSDictionary): Pointer; cdecl; overload;
    function isEqualToAttributedString(other: NSAttributedString): Boolean; cdecl;
    function length: NSUInteger; cdecl;
  end;
  TNSAttributedString = class(TOCGenericImport<NSAttributedStringClass, NSAttributedString>)  end;

  NSAutoreleasePoolClass = interface(NSObjectClass)
    ['{17BCDCFC-8C78-4ACD-BB3F-D0E97F3B21CE}']
    {class} procedure addObject(anObject: Pointer); cdecl; overload;
    {class} function autoreleasedObjectCount: NSUInteger; cdecl;
    {class} procedure enableFreedObjectCheck(enable: Boolean); cdecl;
    {class} procedure enableRelease(enable: Boolean); cdecl;
    {class} function poolCountHighWaterMark: NSUInteger; cdecl;
    {class} function poolCountHighWaterResolution: NSUInteger; cdecl;
    {class} procedure resetTotalAutoreleasedObjects; cdecl;
    {class} procedure setPoolCountHighWaterMark(count: NSUInteger); cdecl;
    {class} procedure setPoolCountHighWaterResolution(res: NSUInteger); cdecl;
    {class} procedure showPools; cdecl;
    {class} function topAutoreleasePoolCount: NSUInteger; cdecl;
    {class} function totalAutoreleasedObjects: NSUInteger; cdecl;
  end;
  NSAutoreleasePool = interface(NSObject)
    ['{2A8CF793-DBC0-44C1-BB55-44EE36F28C3C}']
    procedure addObject(anObject: Pointer); cdecl; overload;
    procedure drain; cdecl;
  end;
  TNSAutoreleasePool = class(TOCGenericImport<NSAutoreleasePoolClass, NSAutoreleasePool>)  end;

  NSXMLNodeClass = interface(NSObjectClass)
    ['{5712572E-9A51-4726-97A4-0EE1C28D1BB1}']
    {class} function DTDNodeWithXMLString(string_: NSString): Pointer; cdecl;
    {class} function attributeWithName(name: NSString; URI: NSString; stringValue: NSString): Pointer; cdecl; overload;
    {class} function attributeWithName(name: NSString; stringValue: NSString): Pointer; cdecl; overload;
    {class} function commentWithStringValue(stringValue: NSString): Pointer; cdecl;
    {class} function document: Pointer; cdecl;
    {class} function documentWithRootElement(element: NSXMLElement): Pointer; cdecl;
    {class} function elementWithName(name: NSString): Pointer; cdecl; overload;
    {class} function elementWithName(name: NSString; URI: NSString): Pointer; cdecl; overload;
    {class} function elementWithName(name: NSString; children: NSArray; attributes: NSArray): Pointer; cdecl; overload;
//    {class} function elementWithName(name: NSString; stringValue: NSString): Pointer; cdecl; overload;
    {class} function localNameForName(name: NSString): NSString; cdecl;
    {class} function namespaceWithName(name: NSString; stringValue: NSString): Pointer; cdecl;
    {class} function predefinedNamespaceForPrefix(name: NSString): Pointer; cdecl;
    {class} function prefixForName(name: NSString): NSString; cdecl;
    {class} function processingInstructionWithName(name: NSString; stringValue: NSString): Pointer; cdecl;
    {class} function textWithStringValue(stringValue: NSString): Pointer; cdecl;
  end;
  NSXMLNode = interface(NSObject)
    ['{C448ACAC-0CA2-47FF-924C-F200EA42E5A6}']
    function URI: NSString; cdecl;
    function XMLString: NSString; cdecl;
    function XMLStringWithOptions(options: NSUInteger): NSString; cdecl;
    function XPath: NSString; cdecl;
    function canonicalXMLStringPreservingComments(comments: Boolean): NSString; cdecl;
    function childAtIndex(index: NSUInteger): NSXMLNode; cdecl;
    function childCount: NSUInteger; cdecl;
    function children: NSArray; cdecl;
    function description: NSString; cdecl;
    procedure detach; cdecl;
    function index: NSUInteger; cdecl;
    function initWithKind(kind: NSXMLNodeKind): Pointer; cdecl; overload;
    function initWithKind(kind: NSXMLNodeKind; options: NSUInteger): Pointer; cdecl; overload;
    function kind: NSXMLNodeKind; cdecl;
    function level: NSUInteger; cdecl;
    function localName: NSString; cdecl;
    function name: NSString; cdecl;
    function nextNode: NSXMLNode; cdecl;
    function nextSibling: NSXMLNode; cdecl;
    function nodesForXPath(xpath: NSString; error: PPointer): NSArray; cdecl;
    function objectValue: Pointer; cdecl;
    function objectsForXQuery(xquery: NSString; constants: NSDictionary; error: PPointer): NSArray; cdecl; overload;
    function objectsForXQuery(xquery: NSString; error: PPointer): NSArray; cdecl; overload;
    function parent: NSXMLNode; cdecl;
    function prefix: NSString; cdecl;
    function previousNode: NSXMLNode; cdecl;
    function previousSibling: NSXMLNode; cdecl;
    function rootDocument: NSXMLDocument; cdecl;
    procedure setName(name: NSString); cdecl;
    procedure setObjectValue(value: Pointer); cdecl;
    procedure setStringValue(string_: NSString); cdecl; overload;
    procedure setStringValue(string_: NSString; resolvingEntities: Boolean); cdecl; overload;
    procedure setURI(URI: NSString); cdecl;
    function stringValue: NSString; cdecl;
  end;
  TNSXMLNode = class(TOCGenericImport<NSXMLNodeClass, NSXMLNode>)  end;

  NSGarbageCollectorClass = interface(NSObjectClass)
    ['{A1F9E5CC-282B-42B6-954C-D179AA607A91}']
    {class} function defaultCollector: Pointer; cdecl;
  end;
  NSGarbageCollector = interface(NSObject)
    ['{CFDC3CB9-D322-4FB3-814E-18E94AE4DB6D}']
    procedure collectExhaustively; cdecl;
    procedure collectIfNeeded; cdecl;
    procedure disable; cdecl;
    procedure disableCollectorForPointer(ptr: Pointer); cdecl;
    procedure enable; cdecl;
    procedure enableCollectorForPointer(ptr: Pointer); cdecl;
    function isCollecting: Boolean; cdecl;
    function isEnabled: Boolean; cdecl;
    function zone: Pointer; cdecl;
  end;
  TNSGarbageCollector = class(TOCGenericImport<NSGarbageCollectorClass, NSGarbageCollector>)  end;

  NSFormatterClass = interface(NSObjectClass)
    ['{FF2215D7-57FE-463C-8E74-6DCCE5A04975}']
  end;
  NSFormatter = interface(NSObject)
    ['{3427329D-FE29-4AB9-9D32-2C642D2AB501}']
    function attributedStringForObjectValue(obj: Pointer; withDefaultAttributes: NSDictionary): NSAttributedString; cdecl;
    function editingStringForObjectValue(obj: Pointer): NSString; cdecl;
    function getObjectValue(out obj: Pointer; forString: NSString; out errorDescription: NSString): Boolean; cdecl;
    function isPartialStringValid(partialString: NSString; newEditingString: NSString; errorDescription: NSString): Boolean; cdecl; overload;
    function isPartialStringValid(partialStringPtr: NSString; proposedSelectedRange: PNSRange; originalString: NSString; originalSelectedRange: NSRange; errorDescription: NSString): Boolean; cdecl; overload;
    function stringForObjectValue(obj: Pointer): NSString; cdecl;
  end;
  TNSFormatter = class(TOCGenericImport<NSFormatterClass, NSFormatter>)  end;

  NSURLRequestClass = interface(NSObjectClass)
    ['{B4E3090B-1DAB-496A-966D-0262DCC4B572}']
    {class} function requestWithURL(URL: NSURL): Pointer; cdecl; overload;
    {class} function requestWithURL(URL: NSURL; cachePolicy: NSURLRequestCachePolicy; timeoutInterval: NSTimeInterval): Pointer; cdecl; overload;
  end;
  NSURLRequest = interface(NSObject)
    ['{B2F10FBF-90BA-4266-9D90-0FC6DE2C5EA9}']
    function HTTPBody: NSData; cdecl;
    function HTTPBodyStream: NSInputStream; cdecl;
    function HTTPMethod: NSString; cdecl;
    function HTTPShouldHandleCookies: Boolean; cdecl;
    function URL: NSURL; cdecl;
    function allHTTPHeaderFields: NSDictionary; cdecl;
    function cachePolicy: NSURLRequestCachePolicy; cdecl;
    function initWithURL(URL: NSURL): Pointer; cdecl; overload;
    function initWithURL(URL: NSURL; cachePolicy: NSURLRequestCachePolicy; timeoutInterval: NSTimeInterval): Pointer; cdecl; overload;
    function mainDocumentURL: NSURL; cdecl;
    function timeoutInterval: NSTimeInterval; cdecl;
    function valueForHTTPHeaderField(field: NSString): NSString; cdecl;
  end;
  TNSURLRequest = class(TOCGenericImport<NSURLRequestClass, NSURLRequest>)  end;

  NSHTTPCookieStorageClass = interface(NSObjectClass)
    ['{BCFC3146-A13B-4559-97DF-610C2DAC2AC3}']
    {class} function sharedHTTPCookieStorage: Pointer; cdecl;
  end;
  NSHTTPCookieStorage = interface(NSObject)
    ['{76B22EE3-873D-483F-BDD0-561BF0F8806C}']
    function cookieAcceptPolicy: NSHTTPCookieAcceptPolicy; cdecl;
    function cookies: NSArray; cdecl;
    function cookiesForURL(URL: NSURL): NSArray; cdecl;
    procedure deleteCookie(cookie: NSHTTPCookie); cdecl;
    function initWithStorageLocation(storageFileURL: NSURL): Pointer; cdecl;
    procedure setCookie(cookie: NSHTTPCookie); cdecl;
    procedure setCookieAcceptPolicy(cookieAcceptPolicy: NSHTTPCookieAcceptPolicy); cdecl;
    procedure setCookies(cookies: NSArray; forURL: NSURL; mainDocumentURL: NSURL); cdecl;
  end;
  TNSHTTPCookieStorage = class(TOCGenericImport<NSHTTPCookieStorageClass, NSHTTPCookieStorage>)  end;

  NSHTTPCookieClass = interface(NSObjectClass)
    ['{B12A4D63-82EA-47A3-9787-12007E44B765}']
    {class} function cookieWithProperties(properties: NSDictionary): Pointer; cdecl;
    {class} function cookiesWithResponseHeaderFields(headerFields: NSDictionary; forURL: NSURL): NSArray; cdecl;
    {class} function requestHeaderFieldsWithCookies(cookies: NSArray): NSDictionary; cdecl;
  end;
  NSHTTPCookie = interface(NSObject)
    ['{E9FF1814-E14F-4350-84FB-BE6842C1889F}']
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

  NSEnumeratorClass = interface(NSObjectClass)
    ['{FADCFF03-845E-4357-A232-502FB1E2F5D2}']
  end;
  NSEnumerator = interface(NSObject)
    ['{CB5409F8-9A6B-422B-B64A-97A21A49A307}']
    function allObjects: NSArray; cdecl;
    function nextObject: Pointer; cdecl;
  end;
  TNSEnumerator = class(TOCGenericImport<NSEnumeratorClass, NSEnumerator>)  end;

  NSExpressionClass = interface(NSObjectClass)
    ['{444BBE86-AF42-4113-847B-97AD8AE2DADF}']
    {class} function expressionForAggregate(subexpressions: NSArray): Pointer; cdecl;
    {class} function expressionForConstantValue(obj: Pointer): Pointer; cdecl;
    {class} function expressionForEvaluatedObject: Pointer; cdecl;
    {class} function expressionForFunction(name: NSString; arguments: NSArray): Pointer; cdecl; overload;
    {class} function expressionForFunction(target: NSExpression; selectorName: NSString; arguments: NSArray): Pointer; cdecl; overload;
    {class} function expressionForKeyPath(keyPath: NSString): Pointer; cdecl;
    {class} function expressionForSubquery(expression: NSExpression; usingIteratorVariable: NSString; predicate: Pointer): Pointer; cdecl;
    {class} function expressionForVariable(string_: NSString): Pointer; cdecl;
  end;
  NSExpression = interface(NSObject)
    ['{B97CF538-8F5A-4A26-ACE9-DDAFCDA288F4}']
    function arguments: NSArray; cdecl;
    function collection: Pointer; cdecl;
    function constantValue: Pointer; cdecl;
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

  NSFileHandleClass = interface(NSObjectClass)
    ['{4FD0241A-02DA-4EFB-864B-A8E47A5DE602}']
    {class} function fileHandleForReadingAtPath(path: NSString): Pointer; cdecl;
    {class} function fileHandleForReadingFromURL(url: NSURL; error: PPointer): Pointer; cdecl;
    {class} function fileHandleForUpdatingAtPath(path: NSString): Pointer; cdecl;
    {class} function fileHandleForUpdatingURL(url: NSURL; error: PPointer): Pointer; cdecl;
    {class} function fileHandleForWritingAtPath(path: NSString): Pointer; cdecl;
    {class} function fileHandleForWritingToURL(url: NSURL; error: PPointer): Pointer; cdecl;
    {class} function fileHandleWithNullDevice: Pointer; cdecl;
    {class} function fileHandleWithStandardError: Pointer; cdecl;
    {class} function fileHandleWithStandardInput: Pointer; cdecl;
    {class} function fileHandleWithStandardOutput: Pointer; cdecl;
  end;
  NSFileHandle = interface(NSObject)
    ['{1377961B-8432-4E31-B439-86233529E79B}']
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
    function seekToEndOfFile: UInt64; cdecl;
    procedure seekToFileOffset(offset: UInt64); cdecl;
    procedure synchronizeFile; cdecl;
    procedure truncateFileAtOffset(offset: UInt64); cdecl;
    procedure waitForDataInBackgroundAndNotify; cdecl;
    procedure waitForDataInBackgroundAndNotifyForModes(modes: NSArray); cdecl;
    procedure writeData(data: NSData); cdecl;
  end;
  TNSFileHandle = class(TOCGenericImport<NSFileHandleClass, NSFileHandle>)  end;

  NSExceptionClass = interface(NSObjectClass)
    ['{8DF17C68-D5B6-4CDD-A70C-97B0C3277DA3}']
    {class} function exceptionWithName(name: NSString; reason: NSString; userInfo: NSDictionary): Pointer; cdecl;
  end;
  NSException = interface(NSObject)
    ['{1DFC2097-BE35-4C8B-80D1-4F05BC061EC7}']
    function callStackReturnAddresses: NSArray; cdecl;
    function callStackSymbols: NSArray; cdecl;
    function initWithName(aName: NSString; reason: NSString; userInfo: NSDictionary): Pointer; cdecl;
    function name: NSString; cdecl;
    function reason: NSString; cdecl;
    function userInfo: NSDictionary; cdecl;
  end;
  TNSException = class(TOCGenericImport<NSExceptionClass, NSException>)  end;

  NSErrorClass = interface(NSObjectClass)
    ['{6E85E0D3-A335-43D0-9977-483295439287}']
    {class} function errorWithDomain(domain: NSString; code: NSInteger; userInfo: NSDictionary): Pointer; cdecl;
  end;
  NSError = interface(NSObject)
    ['{F0F91517-C3AA-477C-B115-544A8C78C226}']
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

  NSFileManagerClass = interface(NSObjectClass)
    ['{E666ADEB-9DBE-4BF0-BEE0-5912CF9F5AB4}']
    {class} function defaultManager: Pointer; cdecl;
  end;
  NSFileManager = interface(NSObject)
    ['{9736DF94-95E9-4111-8C94-82D5EFF52A81}']
    function URLForDirectory(directory: NSSearchPathDirectory; inDomain: NSSearchPathDomainMask; appropriateForURL: NSURL; create: Boolean; error: PPointer): NSURL; cdecl;
    function URLsForDirectory(directory: NSSearchPathDirectory; inDomains: NSSearchPathDomainMask): NSArray; cdecl;
    function attributesOfFileSystemForPath(path: NSString; error: PPointer): NSDictionary; cdecl;
    function attributesOfItemAtPath(path: NSString; error: PPointer): NSDictionary; cdecl;
    function changeCurrentDirectoryPath(path: NSString): Boolean; cdecl;
    function changeFileAttributes(attributes: NSDictionary; atPath: NSString): Boolean; cdecl;
    function componentsToDisplayForPath(path: NSString): NSArray; cdecl;
    function contentsAtPath(path: NSString): NSData; cdecl;
    function contentsEqualAtPath(path1: NSString; andPath: NSString): Boolean; cdecl;
    function contentsOfDirectoryAtPath(path: NSString; error: PPointer): NSArray; cdecl;
    function contentsOfDirectoryAtURL(url: NSURL; includingPropertiesForKeys: NSArray; options: NSDirectoryEnumerationOptions; error: PPointer): NSArray; cdecl;
    function copyItemAtPath(srcPath: NSString; toPath: NSString; error: PPointer): Boolean; cdecl;
    function copyItemAtURL(srcURL: NSURL; toURL: NSURL; error: PPointer): Boolean; cdecl;
    function copyPath(src: NSString; toPath: NSString; handler: Pointer): Boolean; cdecl;
    function createDirectoryAtPath(path: NSString; attributes: NSDictionary): Boolean; cdecl; overload;
    function createDirectoryAtPath(path: NSString; withIntermediateDirectories: Boolean; attributes: NSDictionary; error: PPointer): Boolean; cdecl; overload;
    function createFileAtPath(path: NSString; contents: NSData; attributes: NSDictionary): Boolean; cdecl;
    function createSymbolicLinkAtPath(path: NSString; pathContent: NSString): Boolean; cdecl; overload;
    function createSymbolicLinkAtPath(path: NSString; withDestinationPath: NSString; error: PPointer): Boolean; cdecl; overload;
    function currentDirectoryPath: NSString; cdecl;
    function delegate: Pointer; cdecl;
    function destinationOfSymbolicLinkAtPath(path: NSString; error: PPointer): NSString; cdecl;
    function directoryContentsAtPath(path: NSString): NSArray; cdecl;
    function displayNameAtPath(path: NSString): NSString; cdecl;
    function enumeratorAtPath(path: NSString): NSDirectoryEnumerator; cdecl;
    function fileAttributesAtPath(path: NSString; traverseLink: Boolean): NSDictionary; cdecl;
    function fileExistsAtPath(path: NSString): Boolean; cdecl; overload;
    function fileExistsAtPath(path: NSString; isDirectory: PBoolean): Boolean; cdecl; overload;
    function fileSystemAttributesAtPath(path: NSString): NSDictionary; cdecl;
    function fileSystemRepresentationWithPath(path: NSString): MarshaledAString; cdecl;
    function isDeletableFileAtPath(path: NSString): Boolean; cdecl;
    function isExecutableFileAtPath(path: NSString): Boolean; cdecl;
    function isReadableFileAtPath(path: NSString): Boolean; cdecl;
    function isWritableFileAtPath(path: NSString): Boolean; cdecl;
    function linkItemAtPath(srcPath: NSString; toPath: NSString; error: PPointer): Boolean; cdecl;
    function linkItemAtURL(srcURL: NSURL; toURL: NSURL; error: PPointer): Boolean; cdecl;
    function linkPath(src: NSString; toPath: NSString; handler: Pointer): Boolean; cdecl;
    function mountedVolumeURLsIncludingResourceValuesForKeys(propertyKeys: NSArray; options: NSVolumeEnumerationOptions): NSArray; cdecl;
    function moveItemAtPath(srcPath: NSString; toPath: NSString; error: PPointer): Boolean; cdecl;
    function moveItemAtURL(srcURL: NSURL; toURL: NSURL; error: PPointer): Boolean; cdecl;
    function movePath(src: NSString; toPath: NSString; handler: Pointer): Boolean; cdecl;
    function pathContentOfSymbolicLinkAtPath(path: NSString): NSString; cdecl;
    function removeFileAtPath(path: NSString; handler: Pointer): Boolean; cdecl;
    function removeItemAtPath(path: NSString; error: PPointer): Boolean; cdecl;
    function removeItemAtURL(URL: NSURL; error: PPointer): Boolean; cdecl;
    function replaceItemAtURL(originalItemURL: NSURL; withItemAtURL: NSURL; backupItemName: NSString; options: NSFileManagerItemReplacementOptions; resultingItemURL: NSURL; error: PPointer): Boolean; cdecl;
    function setAttributes(attributes: NSDictionary; ofItemAtPath: NSString; error: PPointer): Boolean; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    function stringWithFileSystemRepresentation(str: MarshaledAString; length: NSUInteger): NSString; cdecl;
    function subpathsAtPath(path: NSString): NSArray; cdecl;
    function subpathsOfDirectoryAtPath(path: NSString; error: PPointer): NSArray; cdecl;
  end;
  TNSFileManager = class(TOCGenericImport<NSFileManagerClass, NSFileManager>)  end;

  NSDistributedLockClass = interface(NSObjectClass)
    ['{6423800D-B401-4BA3-85EC-925C169718DC}']
    {class} function lockWithPath(path: NSString): Pointer; cdecl;
  end;
  NSDistributedLock = interface(NSObject)
    ['{AC86968F-68EF-42BF-B1B2-B08349F11EAC}']
    procedure breakLock; cdecl;
    function initWithPath(path: NSString): Pointer; cdecl;
    function lockDate: NSDate; cdecl;
    function tryLock: Boolean; cdecl;
    procedure unlock; cdecl;
  end;
  TNSDistributedLock = class(TOCGenericImport<NSDistributedLockClass, NSDistributedLock>)  end;

  NSDecimalNumberHandlerClass = interface(NSObjectClass)
    ['{27A2E2CF-C10C-4626-A671-C2F91D3A1856}']
    {class} function decimalNumberHandlerWithRoundingMode(roundingMode: NSRoundingMode; scale: Smallint; raiseOnExactness: Boolean; raiseOnOverflow: Boolean; raiseOnUnderflow: Boolean; raiseOnDivideByZero: Boolean): Pointer; cdecl;
    {class} function defaultDecimalNumberHandler: Pointer; cdecl;
  end;
  NSDecimalNumberHandler = interface(NSObject)
    ['{858FA1C6-F0D4-4A63-9EC9-6CB6827B8DB7}']
    function initWithRoundingMode(roundingMode: NSRoundingMode; scale: Smallint; raiseOnExactness: Boolean; raiseOnOverflow: Boolean; raiseOnUnderflow: Boolean; raiseOnDivideByZero: Boolean): Pointer; cdecl;
  end;
  TNSDecimalNumberHandler = class(TOCGenericImport<NSDecimalNumberHandlerClass, NSDecimalNumberHandler>)  end;

  NSUndoManagerClass = interface(NSObjectClass)
    ['{5EEBE294-DF64-4935-BA0D-3BE131772DAB}']
  end;
  NSUndoManager = interface(NSObject)
    ['{69EFD1FF-7518-4B54-A1E4-538121D7EFEB}']
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
    function redoActionName: NSString; cdecl;
    function redoMenuItemTitle: NSString; cdecl;
    function redoMenuTitleForUndoActionName(actionName: NSString): NSString; cdecl;
    procedure removeAllActions; cdecl;
    procedure removeAllActionsWithTarget(target: Pointer); cdecl;
    function runLoopModes: NSArray; cdecl;
    procedure setActionName(actionName: NSString); cdecl;
    procedure setGroupsByEvent(groupsByEvent: Boolean); cdecl;
    procedure setLevelsOfUndo(levels: NSUInteger); cdecl;
    procedure setRunLoopModes(runLoopModes: NSArray); cdecl;
    procedure undo; cdecl;
    function undoActionName: NSString; cdecl;
    function undoMenuItemTitle: NSString; cdecl;
    function undoMenuTitleForUndoActionName(actionName: NSString): NSString; cdecl;
    procedure undoNestedGroup; cdecl;
  end;
  TNSUndoManager = class(TOCGenericImport<NSUndoManagerClass, NSUndoManager>)  end;

  NSIndexPathClass = interface(NSObjectClass)
    ['{DE492DBD-D4F7-4E2F-AD93-8D69ABBAEF9E}']
    {class} function indexPathWithIndex(index: NSUInteger): Pointer; cdecl;
    {class} function indexPathWithIndexes(indexes: NSUInteger; length: NSUInteger): Pointer; cdecl;
  end;
  NSIndexPath = interface(NSObject)
    ['{28CF6DB1-BD57-49E3-9E6D-7F96A7C151BC}']
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

  NSURLProtectionSpaceClass = interface(NSObjectClass)
    ['{8210A096-2BD5-4967-9FB8-E61B14F85FED}']
  end;
  NSURLProtectionSpace = interface(NSObject)
    ['{5FE6096D-DC8B-426C-8561-C9DAC694298B}']
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

  NSIndexSetClass = interface(NSObjectClass)
    ['{B3596E90-BC4D-4E77-B31B-F8811DF185C9}']
    {class} function indexSet: Pointer; cdecl;
    {class} function indexSetWithIndex(value: NSUInteger): Pointer; cdecl;
    {class} function indexSetWithIndexesInRange(range: NSRange): Pointer; cdecl;
  end;
  NSIndexSet = interface(NSObject)
    ['{2A4BF113-7E6F-404B-9EEB-6ED2026E1002}']
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

  NSDictionaryClass = interface(NSObjectClass)
    ['{8DC3A7FC-0869-4ED9-8420-11023F5571BA}']
    {class} function dictionary: Pointer; cdecl;
    {class} function dictionaryWithContentsOfFile(path: NSString): Pointer; cdecl;
    {class} function dictionaryWithContentsOfURL(url: NSURL): Pointer; cdecl;
    {class} function dictionaryWithDictionary(dict: NSDictionary): Pointer; cdecl;
    {class} function dictionaryWithObject(object_: Pointer; forKey: Pointer): Pointer; cdecl;
    {class} function dictionaryWithObjects(objects: NSArray; forKeys: NSArray): Pointer; cdecl; overload;
    {class} function dictionaryWithObjects(objects: Pointer; forKeys: Pointer; count: NSUInteger): Pointer; cdecl; overload;
    {class} function dictionaryWithObjectsAndKeys(dictionaryWithObjectsAndKeys: Pointer): Pointer; cdecl;
  end;
  NSDictionary = interface(NSObject)
    ['{840DAB9A-BC1B-4AEF-8435-2A0417F095D8}']
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
    function initWithObjectsAndKeys(initWithObjectsAndKeys: Pointer): Pointer; cdecl;
    function isEqualToDictionary(otherDictionary: NSDictionary): Boolean; cdecl;
    function keyEnumerator: NSEnumerator; cdecl;
    function keysSortedByValueUsingComparator(cmptr: NSComparator): NSArray; cdecl;
    function keysSortedByValueUsingSelector(comparator: SEL): NSArray; cdecl;
    function keysSortedByValueWithOptions(opts: NSSortOptions; usingComparator: NSComparator): NSArray; cdecl;
    function objectEnumerator: NSEnumerator; cdecl;
    function objectForKey(aKey: Pointer): Pointer; cdecl;
    function objectsForKeys(keys: NSArray; notFoundMarker: Pointer): NSArray; cdecl;
    function valueForKey(key: NSString): Pointer; cdecl;
    function writeToFile(path: NSString; atomically: Boolean): Boolean; cdecl;
    function writeToURL(url: NSURL; atomically: Boolean): Boolean; cdecl;
  end;
  TNSDictionary = class(TOCGenericImport<NSDictionaryClass, NSDictionary>)  end;

  NSURLResponseClass = interface(NSObjectClass)
    ['{498558F9-F6BD-49FA-9125-F602402249C0}']
  end;
  NSURLResponse = interface(NSObject)
    ['{BA821EDF-CE34-4F48-BCEB-9DAEC9630341}']
    function MIMEType: NSString; cdecl;
    function URL: NSURL; cdecl;
    function expectedContentLength: Int64; cdecl;
    function initWithURL(URL: NSURL; MIMEType: NSString; expectedContentLength: NSInteger; textEncodingName: NSString): Pointer; cdecl;
    function suggestedFilename: NSString; cdecl;
    function textEncodingName: NSString; cdecl;
  end;
  TNSURLResponse = class(TOCGenericImport<NSURLResponseClass, NSURLResponse>)  end;

  NSDistantObjectRequestClass = interface(NSObjectClass)
    ['{F5D93D2B-82EA-4E23-BDEE-BE3288138822}']
  end;
  NSDistantObjectRequest = interface(NSObject)
    ['{2A6C93ED-8619-4A52-BFC9-C5E9A6EDC857}']
    function connection: NSConnection; cdecl;
    function conversation: Pointer; cdecl;
    function invocation: NSInvocation; cdecl;
    procedure replyWithException(exception: NSException); cdecl;
  end;
  TNSDistantObjectRequest = class(TOCGenericImport<NSDistantObjectRequestClass, NSDistantObjectRequest>)  end;

  NSURLProtocolClass = interface(NSObjectClass)
    ['{0070600E-059F-4045-A9FC-2BC5A422B4F9}']
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
    ['{D646F000-E583-4E0D-9F6A-E4301118E042}']
    function cachedResponse: NSCachedURLResponse; cdecl;
    function client: NSURLProtocolClient; cdecl;
    function initWithRequest(request: NSURLRequest; cachedResponse: NSCachedURLResponse; client: NSURLProtocolClient): Pointer; cdecl;
    function request: NSURLRequest; cdecl;
    procedure startLoading; cdecl;
    procedure stopLoading; cdecl;
  end;
  TNSURLProtocol = class(TOCGenericImport<NSURLProtocolClass, NSURLProtocol>)  end;

  NSHostClass = interface(NSObjectClass)
    ['{15DE45C7-D480-45DA-AF3E-B843D0C1D9B4}']
    {class} function currentHost: Pointer; cdecl;
    {class} procedure flushHostCache; cdecl;
    {class} function hostWithAddress(address: NSString): Pointer; cdecl;
    {class} function hostWithName(name: NSString): Pointer; cdecl;
    {class} function isHostCacheEnabled: Boolean; cdecl;
    {class} procedure setHostCacheEnabled(flag: Boolean); cdecl;
  end;
  NSHost = interface(NSObject)
    ['{6FDDDFDB-7F88-44B3-97C4-46F88A2A7DCD}']
    function address: NSString; cdecl;
    function addresses: NSArray; cdecl;
    function isEqualToHost(aHost: NSHost): Boolean; cdecl;
    function localizedName: NSString; cdecl;
    function name: NSString; cdecl;
    function names: NSArray; cdecl;
  end;
  TNSHost = class(TOCGenericImport<NSHostClass, NSHost>)  end;

  NSHashTableClass = interface(NSObjectClass)
    ['{D8A2246B-39A0-4AFB-B19D-061566C0C601}']
    {class} function hashTableWithOptions(options: NSPointerFunctionsOptions): Pointer; cdecl;
    {class} function hashTableWithWeakObjects: Pointer; cdecl;
  end;
  NSHashTable = interface(NSObject)
    ['{892A9C7F-F4D0-40DE-A71A-B1B7050AA425}']
    procedure addObject(object_: Pointer); cdecl;
    function allObjects: NSArray; cdecl;
    function anyObject: Pointer; cdecl;
    function containsObject(anObject: Pointer): Boolean; cdecl;
    function count: NSUInteger; cdecl;
    function initWithOptions(options: NSPointerFunctionsOptions; capacity: NSUInteger): Pointer; cdecl;
    function initWithPointerFunctions(functions: NSPointerFunctions; capacity: NSUInteger): Pointer; cdecl;
    procedure intersectHashTable(other: NSHashTable); cdecl;
    function intersectsHashTable(other: NSHashTable): Boolean; cdecl;
    function isEqualToHashTable(other: NSHashTable): Boolean; cdecl;
    function isSubsetOfHashTable(other: NSHashTable): Boolean; cdecl;
    function member(object_: Pointer): Pointer; cdecl;
    procedure minusHashTable(other: NSHashTable); cdecl;
    function objectEnumerator: NSEnumerator; cdecl;
    function pointerFunctions: NSPointerFunctions; cdecl;
    procedure removeAllObjects; cdecl;
    procedure removeObject(object_: Pointer); cdecl;
    function setRepresentation: NSSet; cdecl;
    procedure unionHashTable(other: NSHashTable); cdecl;
  end;
  TNSHashTable = class(TOCGenericImport<NSHashTableClass, NSHashTable>)  end;

  NSUnarchiverClass = interface(NSCoderClass)
    ['{860BF6E1-54E2-434F-9C86-970BB02FD35A}']
    {class} function classNameDecodedForArchiveClassName(inArchiveName: NSString): NSString; cdecl; overload;
    {class} procedure decodeClassName(inArchiveName: NSString; asClassName: NSString); cdecl; overload;
    {class} function unarchiveObjectWithData(data: NSData): Pointer; cdecl;
    {class} function unarchiveObjectWithFile(path: NSString): Pointer; cdecl;
  end;
  NSUnarchiver = interface(NSCoder)
    ['{D1305A9F-C050-4819-8BB6-DA421AABEF5B}']
    function classNameDecodedForArchiveClassName(inArchiveName: NSString): NSString; cdecl; overload;
    procedure decodeClassName(inArchiveName: NSString; asClassName: NSString); cdecl; overload;
    function initForReadingWithData(data: NSData): Pointer; cdecl;
    function isAtEnd: Boolean; cdecl;
    function objectZone: Pointer; cdecl;
    procedure replaceObject(object_: Pointer; withObject: Pointer); cdecl;
    procedure setObjectZone(zone: Pointer); cdecl;
    function systemVersion: Longword; cdecl;
  end;
  TNSUnarchiver = class(TOCGenericImport<NSUnarchiverClass, NSUnarchiver>)  end;

  NSSocketPortClass = interface(NSPortClass)
    ['{D8FC1A6F-A132-4BC6-A13B-702497959278}']
  end;
  NSSocketPort = interface(NSPort)
    ['{20DB9528-5F34-4EDC-AC34-9D5D4F734FC4}']
    function address: NSData; cdecl;
    function init: Pointer; cdecl;
    function initRemoteWithProtocolFamily(family: Integer; socketType: Integer; protocol: Integer; address: NSData): Pointer; cdecl;
    function initRemoteWithTCPPort(port: Word; host: NSString): Pointer; cdecl;
    function initWithProtocolFamily(family: Integer; socketType: Integer; protocol: Integer; address: NSData): Pointer; cdecl; overload;
    function initWithProtocolFamily(family: Integer; socketType: Integer; protocol: Integer; socket: NSSocketNativeHandle): Pointer; cdecl; overload;
    function initWithTCPPort(port: Word): Pointer; cdecl;
    function protocol: Integer; cdecl;
    function protocolFamily: Integer; cdecl;
    function socket: NSSocketNativeHandle; cdecl;
    function socketType: Integer; cdecl;
  end;
  TNSSocketPort = class(TOCGenericImport<NSSocketPortClass, NSSocketPort>)  end;

  NSSpecifierTestClass = interface(NSScriptWhoseTestClass)
    ['{6D09FC34-0A13-4DBC-A272-1D7A708FF7B9}']
  end;
  NSSpecifierTest = interface(NSScriptWhoseTest)
    ['{771FA4F0-2634-426D-BB70-BD76E0EDC8E2}']
    function initWithObjectSpecifier(obj1: NSScriptObjectSpecifier; comparisonOperator: NSTestComparisonOperation; testObject: Pointer): Pointer; cdecl;
  end;
  TNSSpecifierTest = class(TOCGenericImport<NSSpecifierTestClass, NSSpecifierTest>)  end;

  NSSocketPortNameServerClass = interface(NSPortNameServerClass)
    ['{15814DC6-0FD2-4EBC-AEEC-6047B25D4708}']
    {class} function sharedInstance: Pointer; cdecl;
  end;
  NSSocketPortNameServer = interface(NSPortNameServer)
    ['{EAFB893A-12A0-4B14-B38E-D25DEC28EBFA}']
    function defaultNameServerPortNumber: Word; cdecl;
    function portForName(name: NSString): NSPort; cdecl; overload;
    function portForName(name: NSString; host: NSString): NSPort; cdecl; overload;
    function portForName(name: NSString; host: NSString; nameServerPortNumber: Word): NSPort; cdecl; overload;
    function registerPort(port: NSPort; name: NSString): Boolean; cdecl; overload;
    function registerPort(port: NSPort; name: NSString; nameServerPortNumber: Word): Boolean; cdecl; overload;
    function removePortForName(name: NSString): Boolean; cdecl;
    procedure setDefaultNameServerPortNumber(portNumber: Word); cdecl;
  end;
  TNSSocketPortNameServer = class(TOCGenericImport<NSSocketPortNameServerClass, NSSocketPortNameServer>)  end;

  NSUniqueIDSpecifierClass = interface(NSScriptObjectSpecifierClass)
    ['{714F9A84-E7B0-44E0-93FE-ADE0D2AC0F55}']
  end;
  NSUniqueIDSpecifier = interface(NSScriptObjectSpecifier)
    ['{6DC56AC3-439B-4654-8EC9-415AC19A67E3}']
    function initWithContainerClassDescription(classDesc: NSScriptClassDescription; containerSpecifier: NSScriptObjectSpecifier; key: NSString; uniqueID: Pointer): Pointer; cdecl;
    procedure setUniqueID(uniqueID: Pointer); cdecl;
    function uniqueID: Pointer; cdecl;
  end;
  TNSUniqueIDSpecifier = class(TOCGenericImport<NSUniqueIDSpecifierClass, NSUniqueIDSpecifier>)  end;

  NSSetCommandClass = interface(NSScriptCommandClass)
    ['{8E3FA348-80C4-40F0-865B-65202A045A33}']
  end;
  NSSetCommand = interface(NSScriptCommand)
    ['{F4902345-0B83-43B2-A00A-F342F8FEE103}']
    function keySpecifier: NSScriptObjectSpecifier; cdecl;
    procedure setReceiversSpecifier(receiversRef: NSScriptObjectSpecifier); cdecl;
  end;
  TNSSetCommand = class(TOCGenericImport<NSSetCommandClass, NSSetCommand>)  end;

  NSXMLDocumentClass = interface(NSXMLNodeClass)
    ['{AA8DF8AA-416A-4E1C-9289-FC9D961943CB}']
  end;
  NSXMLDocument = interface(NSXMLNode)
    ['{5912C10C-0465-46F8-B811-3709849454E0}']
    function DTD: NSXMLDTD; cdecl;
    function MIMEType: NSString; cdecl;
    function XMLData: NSData; cdecl;
    function XMLDataWithOptions(options: NSUInteger): NSData; cdecl;
    procedure addChild(child: NSXMLNode); cdecl;
    function characterEncoding: NSString; cdecl;
    function documentContentKind: NSXMLDocumentContentKind; cdecl;
    function initWithContentsOfURL(url: NSURL; options: NSUInteger; error: PPointer): Pointer; cdecl;
    function initWithData(data: NSData; options: NSUInteger; error: PPointer): Pointer; cdecl;
    function initWithRootElement(element: NSXMLElement): Pointer; cdecl;
    function initWithXMLString(string_: NSString; options: NSUInteger; error: PPointer): Pointer; cdecl;
    procedure insertChild(child: NSXMLNode; atIndex: NSUInteger); cdecl;
    procedure insertChildren(children: NSArray; atIndex: NSUInteger); cdecl;
    function isStandalone: Boolean; cdecl;
    function objectByApplyingXSLT(xslt: NSData; arguments: NSDictionary; error: PPointer): Pointer; cdecl;
    function objectByApplyingXSLTAtURL(xsltURL: NSURL; arguments: NSDictionary; error: PPointer): Pointer; cdecl;
    function objectByApplyingXSLTString(xslt: NSString; arguments: NSDictionary; error: PPointer): Pointer; cdecl;
    procedure removeChildAtIndex(index: NSUInteger); cdecl;
    procedure replaceChildAtIndex(index: NSUInteger; withNode: NSXMLNode); cdecl;
    function rootElement: NSXMLElement; cdecl;
    procedure setCharacterEncoding(encoding: NSString); cdecl;
    procedure setChildren(children: NSArray); cdecl;
    procedure setDTD(documentTypeDeclaration: NSXMLDTD); cdecl;
    procedure setDocumentContentKind(kind: NSXMLDocumentContentKind); cdecl;
    procedure setMIMEType(MIMEType: NSString); cdecl;
    procedure setRootElement(root: NSXMLNode); cdecl;
    procedure setStandalone(standalone: Boolean); cdecl;
    procedure setVersion(version: NSString); cdecl;
    function validateAndReturnError(error: PPointer): Boolean; cdecl;
    function version: NSString; cdecl;
  end;
  TNSXMLDocument = class(TOCGenericImport<NSXMLDocumentClass, NSXMLDocument>)  end;

  NSXMLElementClass = interface(NSXMLNodeClass)
    ['{BCED51C8-A978-434C-A079-542509198DCE}']
  end;
  NSXMLElement = interface(NSXMLNode)
    ['{CC71A33B-594C-43CD-9124-EB6807CE4351}']
    procedure addAttribute(attribute: NSXMLNode); cdecl;
    procedure addChild(child: NSXMLNode); cdecl;
    procedure addNamespace(aNamespace: NSXMLNode); cdecl;
    function attributeForLocalName(localName: NSString; URI: NSString): NSXMLNode; cdecl;
    function attributeForName(name: NSString): NSXMLNode; cdecl;
    function attributes: NSArray; cdecl;
    function elementsForLocalName(localName: NSString; URI: NSString): NSArray; cdecl;
    function elementsForName(name: NSString): NSArray; cdecl;
    function initWithName(name: NSString): Pointer; cdecl; overload;
    function initWithName(name: NSString; URI: NSString): Pointer; cdecl; overload;
//    function initWithName(name: NSString; stringValue: NSString): Pointer; cdecl; overload;
    function initWithXMLString(string_: NSString; error: PPointer): Pointer; cdecl;
    procedure insertChild(child: NSXMLNode; atIndex: NSUInteger); cdecl;
    procedure insertChildren(children: NSArray; atIndex: NSUInteger); cdecl;
    function namespaceForPrefix(name: NSString): NSXMLNode; cdecl;
    function namespaces: NSArray; cdecl;
    procedure normalizeAdjacentTextNodesPreservingCDATA(preserve: Boolean); cdecl;
    procedure removeAttributeForName(name: NSString); cdecl;
    procedure removeChildAtIndex(index: NSUInteger); cdecl;
    procedure removeNamespaceForPrefix(name: NSString); cdecl;
    procedure replaceChildAtIndex(index: NSUInteger; withNode: NSXMLNode); cdecl;
    function resolveNamespaceForName(name: NSString): NSXMLNode; cdecl;
    function resolvePrefixForNamespaceURI(namespaceURI: NSString): NSString; cdecl;
    procedure setAttributes(attributes: NSArray); cdecl;
    procedure setAttributesAsDictionary(attributes: NSDictionary); cdecl;
    procedure setChildren(children: NSArray); cdecl;
    procedure setNamespaces(namespaces: NSArray); cdecl;
  end;
  TNSXMLElement = class(TOCGenericImport<NSXMLElementClass, NSXMLElement>)  end;

  NSXMLDTDNodeClass = interface(NSXMLNodeClass)
    ['{428BB49E-87C6-4CD2-90F3-F081DCAB74F0}']
  end;
  NSXMLDTDNode = interface(NSXMLNode)
    ['{5B12D641-5C6D-4A20-AD2F-CE57FAA889F3}']
    function DTDKind: NSXMLDTDNodeKind; cdecl;
    function initWithXMLString(string_: NSString): Pointer; cdecl;
    function isExternal: Boolean; cdecl;
    function notationName: NSString; cdecl;
    function publicID: NSString; cdecl;
    procedure setDTDKind(kind: NSXMLDTDNodeKind); cdecl;
    procedure setNotationName(notationName: NSString); cdecl;
    procedure setPublicID(publicID: NSString); cdecl;
    procedure setSystemID(systemID: NSString); cdecl;
    function systemID: NSString; cdecl;
  end;
  TNSXMLDTDNode = class(TOCGenericImport<NSXMLDTDNodeClass, NSXMLDTDNode>)  end;

  NSWhoseSpecifierClass = interface(NSScriptObjectSpecifierClass)
    ['{677C8732-32FC-4DC9-8DF4-78149D33B6F9}']
  end;
  NSWhoseSpecifier = interface(NSScriptObjectSpecifier)
    ['{220BD653-FF1F-4B83-83B3-EE3DE099714C}']
    function endSubelementIdentifier: NSWhoseSubelementIdentifier; cdecl;
    function endSubelementIndex: NSInteger; cdecl;
    function initWithContainerClassDescription(classDesc: NSScriptClassDescription; containerSpecifier: NSScriptObjectSpecifier; key: NSString; test: NSScriptWhoseTest): Pointer; cdecl;
    procedure setEndSubelementIdentifier(subelement: NSWhoseSubelementIdentifier); cdecl;
    procedure setEndSubelementIndex(index: NSInteger); cdecl;
    procedure setStartSubelementIdentifier(subelement: NSWhoseSubelementIdentifier); cdecl;
    procedure setStartSubelementIndex(index: NSInteger); cdecl;
    procedure setTest(test: NSScriptWhoseTest); cdecl;
    function startSubelementIdentifier: NSWhoseSubelementIdentifier; cdecl;
    function startSubelementIndex: NSInteger; cdecl;
    function test: NSScriptWhoseTest; cdecl;
  end;
  TNSWhoseSpecifier = class(TOCGenericImport<NSWhoseSpecifierClass, NSWhoseSpecifier>)  end;

  NSXMLDTDClass = interface(NSXMLNodeClass)
    ['{0FCE1F84-DF56-49FA-9287-D24B536189E5}']
    {class} function predefinedEntityDeclarationForName(name: NSString): NSXMLDTDNode; cdecl;
  end;
  NSXMLDTD = interface(NSXMLNode)
    ['{18D9F23F-8032-4B75-92F5-888BADEEAC0B}']
    procedure addChild(child: NSXMLNode); cdecl;
    function attributeDeclarationForName(name: NSString; elementName: NSString): NSXMLDTDNode; cdecl;
    function elementDeclarationForName(name: NSString): NSXMLDTDNode; cdecl;
    function entityDeclarationForName(name: NSString): NSXMLDTDNode; cdecl;
    function initWithContentsOfURL(url: NSURL; options: NSUInteger; error: PPointer): Pointer; cdecl;
    function initWithData(data: NSData; options: NSUInteger; error: PPointer): Pointer; cdecl;
    procedure insertChild(child: NSXMLNode; atIndex: NSUInteger); cdecl;
    procedure insertChildren(children: NSArray; atIndex: NSUInteger); cdecl;
    function notationDeclarationForName(name: NSString): NSXMLDTDNode; cdecl;
    function publicID: NSString; cdecl;
    procedure removeChildAtIndex(index: NSUInteger); cdecl;
    procedure replaceChildAtIndex(index: NSUInteger; withNode: NSXMLNode); cdecl;
    procedure setChildren(children: NSArray); cdecl;
    procedure setPublicID(publicID: NSString); cdecl;
    procedure setSystemID(systemID: NSString); cdecl;
    function systemID: NSString; cdecl;
  end;
  TNSXMLDTD = class(TOCGenericImport<NSXMLDTDClass, NSXMLDTD>)  end;

  NSIndexSpecifierClass = interface(NSScriptObjectSpecifierClass)
    ['{7F2FA6A1-3EC5-447E-AC1F-2BFD55157266}']
  end;
  NSIndexSpecifier = interface(NSScriptObjectSpecifier)
    ['{383F7E1C-3465-4128-BAC5-45B4669C438D}']
    function index: NSInteger; cdecl;
    function initWithContainerClassDescription(classDesc: NSScriptClassDescription; containerSpecifier: NSScriptObjectSpecifier; key: NSString; index: NSInteger): Pointer; cdecl;
    procedure setIndex(index: NSInteger); cdecl;
  end;
  TNSIndexSpecifier = class(TOCGenericImport<NSIndexSpecifierClass, NSIndexSpecifier>)  end;

  NSInputStreamClass = interface(NSStreamClass)
    ['{87F8C5BC-970E-43AB-89AF-43C43D1A5966}']
    {class} function inputStreamWithData(data: NSData): Pointer; cdecl;
    {class} function inputStreamWithFileAtPath(path: NSString): Pointer; cdecl;
    {class} function inputStreamWithURL(url: NSURL): Pointer; cdecl;
  end;
  NSInputStream = interface(NSStream)
    ['{10218429-C158-4629-9222-DC1B92E3337C}']
    function getBuffer(buffer: PByte; length: NSUInteger): Boolean; cdecl;
    function hasBytesAvailable: Boolean; cdecl;
    function initWithData(data: NSData): Pointer; cdecl;
    function initWithFileAtPath(path: NSString): Pointer; cdecl;
    function initWithURL(url: NSURL): Pointer; cdecl;
    function read(buffer: PByte; maxLength: NSUInteger): NSInteger; cdecl;
  end;
  TNSInputStream = class(TOCGenericImport<NSInputStreamClass, NSInputStream>)  end;

  NSHTTPURLResponseClass = interface(NSURLResponseClass)
    ['{4EF09BB7-9862-4ED0-BAC4-9BC18984022F}']
    {class} function localizedStringForStatusCode(statusCode: NSInteger): NSString; cdecl;
  end;
  NSHTTPURLResponse = interface(NSURLResponse)
    ['{FA2C33B9-208E-41CA-B18F-E4C8DF108639}']
    function allHeaderFields: NSDictionary; cdecl;
    function statusCode: NSInteger; cdecl;
  end;
  TNSHTTPURLResponse = class(TOCGenericImport<NSHTTPURLResponseClass, NSHTTPURLResponse>)  end;

  NSDistantObjectClass = interface(NSProxyClass)
    ['{06055934-9690-4189-8B76-3D4439684FDF}']
    {class} function proxyWithLocal(target: Pointer; connection: NSConnection): Pointer; cdecl;
    {class} function proxyWithTarget(target: Pointer; connection: NSConnection): Pointer; cdecl;
  end;
  NSDistantObject = interface(NSProxy)
    ['{DDDE84C7-E24B-4947-B18F-CE769C30E54C}']
    function connectionForProxy: NSConnection; cdecl;
    function initWithLocal(target: Pointer; connection: NSConnection): Pointer; cdecl;
    function initWithTarget(target: Pointer; connection: NSConnection): Pointer; cdecl;
    procedure setProtocolForProxy(proto: Pointer); cdecl;
  end;
  TNSDistantObject = class(TOCGenericImport<NSDistantObjectClass, NSDistantObject>)  end;

  NSDistributedNotificationCenterClass = interface(NSNotificationCenterClass)
    ['{92E62476-AE48-485A-889E-1EB15134DC33}']
    {class} function defaultCenter: Pointer; cdecl;
    {class} function notificationCenterForType(notificationCenterType: NSString): Pointer; cdecl;
  end;
  NSDistributedNotificationCenter = interface(NSNotificationCenter)
    ['{208D9E8E-AFD0-4EED-A152-B2CD39717EAE}']
    procedure setSuspended(suspended: Boolean); cdecl;
    function suspended: Boolean; cdecl;
  end;
  TNSDistributedNotificationCenter = class(TOCGenericImport<NSDistributedNotificationCenterClass, NSDistributedNotificationCenter>)  end;

  NSLogicalTestClass = interface(NSScriptWhoseTestClass)
    ['{E79A37D0-6A46-4506-AFA6-CC77C212216B}']
  end;
  NSLogicalTest = interface(NSScriptWhoseTest)
    ['{8E7B8A04-6766-41C1-B4C5-68A806B652E1}']
    function initAndTestWithTests(subTests: NSArray): Pointer; cdecl;
    function initNotTestWithTest(subTest: NSScriptWhoseTest): Pointer; cdecl;
    function initOrTestWithTests(subTests: NSArray): Pointer; cdecl;
  end;
  TNSLogicalTest = class(TOCGenericImport<NSLogicalTestClass, NSLogicalTest>)  end;

  NSMachBootstrapServerClass = interface(NSPortNameServerClass)
    ['{BF7C6F0D-FA4A-4D70-ABB9-C0C39E8AA595}']
    {class} function sharedInstance: Pointer; cdecl;
  end;
  NSMachBootstrapServer = interface(NSPortNameServer)
    ['{6B6B8F0F-5EF6-4EDB-A5A2-B69A2EAC295E}']
    function portForName(name: NSString): NSPort; cdecl; overload;
    function portForName(name: NSString; host: NSString): NSPort; cdecl; overload;
    function registerPort(port: NSPort; name: NSString): Boolean; cdecl;
    function servicePortWithName(name: NSString): NSPort; cdecl;
  end;
  TNSMachBootstrapServer = class(TOCGenericImport<NSMachBootstrapServerClass, NSMachBootstrapServer>)  end;

  NSKeyedUnarchiverClass = interface(NSCoderClass)
    ['{13218FA5-7958-42FA-BC1A-641CC6AEFC2F}']
    {class} procedure setClass(cls: Pointer; forClassName: NSString); cdecl; overload;
    {class} function unarchiveObjectWithData(data: NSData): Pointer; cdecl;
    {class} function unarchiveObjectWithFile(path: NSString): Pointer; cdecl;
  end;
  NSKeyedUnarchiver = interface(NSCoder)
    ['{E584D821-8B8D-40E0-87C6-16A2475A7905}']
    function containsValueForKey(key: NSString): Boolean; cdecl;
    function decodeBoolForKey(key: NSString): Boolean; cdecl;
    function decodeBytesForKey(key: NSString; returnedLength: NSUInteger): PByte; cdecl;
    function decodeDoubleForKey(key: NSString): double; cdecl;
    function decodeFloatForKey(key: NSString): Single; cdecl;
    function decodeInt32ForKey(key: NSString): Integer; cdecl;
    function decodeInt64ForKey(key: NSString): Int64; cdecl;
    function decodeIntForKey(key: NSString): Integer; cdecl;
    function decodeObjectForKey(key: NSString): Pointer; cdecl;
    function delegate: NSKeyedUnarchiverDelegate; cdecl;
    procedure finishDecoding; cdecl;
    function initForReadingWithData(data: NSData): Pointer; cdecl;
    procedure setClass(cls: Pointer; forClassName: NSString); cdecl; overload;
    procedure setDelegate(delegate: NSKeyedUnarchiverDelegate); cdecl;
  end;
  TNSKeyedUnarchiver = class(TOCGenericImport<NSKeyedUnarchiverClass, NSKeyedUnarchiver>)  end;

  NSInvocationOperationClass = interface(NSOperationClass)
    ['{1C6DEE7F-4278-4661-A822-45C8129D975B}']
  end;
  NSInvocationOperation = interface(NSOperation)
    ['{A866109F-6BBA-42D1-854A-66132200EB9E}']
    function initWithInvocation(inv: NSInvocation): Pointer; cdecl;
    function invocation: NSInvocation; cdecl;
    function result: Pointer; cdecl;
  end;
  TNSInvocationOperation = class(TOCGenericImport<NSInvocationOperationClass, NSInvocationOperation>)  end;

  NSKeyedArchiverClass = interface(NSCoderClass)
    ['{BA67F62D-48DC-4F55-8FF8-0AE273C14277}']
    {class} function archiveRootObject(rootObject: Pointer; toFile: NSString): Boolean; cdecl;
    {class} function archivedDataWithRootObject(rootObject: Pointer): NSData; cdecl;
    {class} function classNameForClass(cls: Pointer): NSString; cdecl; overload;
    {class} procedure setClassName(codedName: NSString; forClass: Pointer); cdecl; overload;
  end;
  NSKeyedArchiver = interface(NSCoder)
    ['{34A248B6-8A28-4DF2-9FDC-E0D30A7A909E}']
    function classNameForClass(cls: Pointer): NSString; cdecl; overload;
    function delegate: NSKeyedArchiverDelegate; cdecl;
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
    procedure setDelegate(delegate: NSKeyedArchiverDelegate); cdecl;
    procedure setOutputFormat(format: NSPropertyListFormat); cdecl;
  end;
  TNSKeyedArchiver = class(TOCGenericImport<NSKeyedArchiverClass, NSKeyedArchiver>)  end;

  NSDirectoryEnumeratorClass = interface(NSEnumeratorClass)
    ['{401A25B9-DA23-4253-AEA6-802A5E240226}']
  end;
  NSDirectoryEnumerator = interface(NSEnumerator)
    ['{BEF51428-DA73-456B-96D9-18E93C0B75F1}']
    function directoryAttributes: NSDictionary; cdecl;
    function fileAttributes: NSDictionary; cdecl;
    function level: NSUInteger; cdecl;
    procedure skipDescendants; cdecl;
    procedure skipDescendents; cdecl;
  end;
  TNSDirectoryEnumerator = class(TOCGenericImport<NSDirectoryEnumeratorClass, NSDirectoryEnumerator>)  end;

  NSCloneCommandClass = interface(NSScriptCommandClass)
    ['{CAE7B277-C6AA-4B71-8344-B15DBEA9C63B}']
  end;
  NSCloneCommand = interface(NSScriptCommand)
    ['{E8B9033E-0785-4A38-A796-830E29E8F332}']
    function keySpecifier: NSScriptObjectSpecifier; cdecl;
    procedure setReceiversSpecifier(receiversRef: NSScriptObjectSpecifier); cdecl;
  end;
  TNSCloneCommand = class(TOCGenericImport<NSCloneCommandClass, NSCloneCommand>)  end;

  NSCloseCommandClass = interface(NSScriptCommandClass)
    ['{4CF3E3C4-C376-4E7F-BC0D-EBB2C419C1A2}']
  end;
  NSCloseCommand = interface(NSScriptCommand)
    ['{675B6274-A15E-4625-A345-03E96282EC2F}']
    function saveOptions: NSSaveOptions; cdecl;
  end;
  TNSCloseCommand = class(TOCGenericImport<NSCloseCommandClass, NSCloseCommand>)  end;

  NSCalendarDateClass = interface(NSDateClass)
    ['{16A09ED6-C2ED-4FFB-832E-95F6371EFF93}']
    {class} function calendarDate: Pointer; cdecl;
    {class} function dateWithString(description: NSString; calendarFormat: NSString): Pointer; cdecl; overload;
    {class} function dateWithString(description: NSString; calendarFormat: NSString; locale: Pointer): Pointer; cdecl; overload;
    {class} function dateWithYear(year: NSInteger; month: NSUInteger; day: NSUInteger; hour: NSUInteger; minute: NSUInteger; second: NSUInteger; timeZone: NSTimeZone): Pointer; cdecl;
  end;
  NSCalendarDate = interface(NSDate)
    ['{CE258A6D-8C21-44D8-B1EF-76F9E78D8B55}']
    function calendarFormat: NSString; cdecl;
    function dateByAddingYears(year: NSInteger; months: NSInteger; days: NSInteger; hours: NSInteger; minutes: NSInteger; seconds: NSInteger): NSCalendarDate; cdecl;
    function dayOfCommonEra: NSInteger; cdecl;
    function dayOfMonth: NSInteger; cdecl;
    function dayOfWeek: NSInteger; cdecl;
    function dayOfYear: NSInteger; cdecl;
    function descriptionWithCalendarFormat(format: NSString): NSString; cdecl; overload;
    function descriptionWithCalendarFormat(format: NSString; locale: Pointer): NSString; cdecl; overload;
    function descriptionWithLocale(locale: Pointer): NSString; cdecl;
    function hourOfDay: NSInteger; cdecl;
    function initWithString(description: NSString): Pointer; cdecl; overload;
    function initWithString(description: NSString; calendarFormat: NSString): Pointer; cdecl; overload;
    function initWithString(description: NSString; calendarFormat: NSString; locale: Pointer): Pointer; cdecl; overload;
    function initWithYear(year: NSInteger; month: NSUInteger; day: NSUInteger; hour: NSUInteger; minute: NSUInteger; second: NSUInteger; timeZone: NSTimeZone): Pointer; cdecl;
    function minuteOfHour: NSInteger; cdecl;
    function monthOfYear: NSInteger; cdecl;
    function secondOfMinute: NSInteger; cdecl;
    procedure setCalendarFormat(format: NSString); cdecl;
    procedure setTimeZone(aTimeZone: NSTimeZone); cdecl;
    function timeZone: NSTimeZone; cdecl;
    function yearOfCommonEra: NSInteger; cdecl;
    procedure years(yp: NSInteger; months: NSInteger; days: NSInteger; hours: NSInteger; minutes: NSInteger; seconds: NSInteger; sinceDate: NSCalendarDate); cdecl;
  end;
  TNSCalendarDate = class(TOCGenericImport<NSCalendarDateClass, NSCalendarDate>)  end;

  NSArchiverClass = interface(NSCoderClass)
    ['{C175B929-639D-46FA-9C46-41EE7A649AE3}']
    {class} function archiveRootObject(rootObject: Pointer; toFile: NSString): Boolean; cdecl;
    {class} function archivedDataWithRootObject(rootObject: Pointer): NSData; cdecl;
  end;
  NSArchiver = interface(NSCoder)
    ['{D2FBA799-B8AF-4983-B7C2-D7F7D4968C96}']
    function archiverData: NSMutableData; cdecl;
    function classNameEncodedForTrueClassName(trueName: NSString): NSString; cdecl;
    procedure encodeClassName(trueName: NSString; intoClassName: NSString); cdecl;
    procedure encodeConditionalObject(object_: Pointer); cdecl;
    procedure encodeRootObject(rootObject: Pointer); cdecl;
    function initForWritingWithMutableData(mdata: NSMutableData): Pointer; cdecl;
    procedure replaceObject(object_: Pointer; withObject: Pointer); cdecl;
  end;
  TNSArchiver = class(TOCGenericImport<NSArchiverClass, NSArchiver>)  end;

  NSBlockOperationClass = interface(NSOperationClass)
    ['{B2B56D1F-5087-412B-9F17-EA045C3D0915}']
  end;
  NSBlockOperation = interface(NSOperation)
    ['{CE91B1C0-A750-419F-B956-A811321F4BE7}']
    function executionBlocks: NSArray; cdecl;
  end;
  TNSBlockOperation = class(TOCGenericImport<NSBlockOperationClass, NSBlockOperation>)  end;

  NSDateFormatterClass = interface(NSFormatterClass)
    ['{820EA13C-144E-4355-9B1D-4AE9DAB8FAB6}']
    {class} function dateFormatFromTemplate(tmplate: NSString; options: NSUInteger; locale: NSLocale): NSString; cdecl;
    {class} function defaultFormatterBehavior: NSDateFormatterBehavior; cdecl;
    {class} function localizedStringFromDate(date: NSDate; dateStyle: NSDateFormatterStyle; timeStyle: NSDateFormatterStyle): NSString; cdecl;
    {class} procedure setDefaultFormatterBehavior(behavior: NSDateFormatterBehavior); cdecl;
  end;
  NSDateFormatter = interface(NSFormatter)
    ['{DBC51587-B19E-4790-9220-8F6B81F23CEF}']
    function AMSymbol: NSString; cdecl;
    function PMSymbol: NSString; cdecl;
    function allowsNaturalLanguage: Boolean; cdecl;
    function calendar: NSCalendar; cdecl;
    function dateFormat: NSString; cdecl;
    function dateFromString(string_: NSString): NSDate; cdecl;
    function dateStyle: NSDateFormatterStyle; cdecl;
    function defaultDate: NSDate; cdecl;
    function doesRelativeDateFormatting: Boolean; cdecl;
    function eraSymbols: NSArray; cdecl;
    function formatterBehavior: NSDateFormatterBehavior; cdecl;
    function generatesCalendarDates: Boolean; cdecl;
    function getObjectValue(out obj: Pointer; forString: NSString; out range: PNSRange; out error: NSError): Boolean; cdecl;
    function gregorianStartDate: NSDate; cdecl;
    function initWithDateFormat(format: NSString; allowNaturalLanguage: Boolean): Pointer; cdecl;
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

  NSDeleteCommandClass = interface(NSScriptCommandClass)
    ['{E4186254-6B19-4AB9-AEBE-CD39EF183D44}']
  end;
  NSDeleteCommand = interface(NSScriptCommand)
    ['{30B4F4EB-0EC2-4DC1-A253-9B212ABACFDB}']
    function keySpecifier: NSScriptObjectSpecifier; cdecl;
    procedure setReceiversSpecifier(receiversRef: NSScriptObjectSpecifier); cdecl;
  end;
  TNSDeleteCommand = class(TOCGenericImport<NSDeleteCommandClass, NSDeleteCommand>)  end;

  NSCreateCommandClass = interface(NSScriptCommandClass)
    ['{B33C93B7-902F-4F06-A685-5EC206CE3DBB}']
  end;
  NSCreateCommand = interface(NSScriptCommand)
    ['{1923E01C-04AE-4854-B7A3-17AF1FB429A2}']
    function createClassDescription: NSScriptClassDescription; cdecl;
    function resolvedKeyDictionary: NSDictionary; cdecl;
  end;
  TNSCreateCommand = class(TOCGenericImport<NSCreateCommandClass, NSCreateCommand>)  end;

  NSComparisonPredicateClass = interface(NSPredicateClass)
    ['{0A2EA8F4-D183-47BE-AAA1-CA7AF5739753}']
    {class} function predicateWithLeftExpression(lhs: NSExpression; rightExpression: NSExpression; customSelector: SEL): NSPredicate; cdecl; overload;
  end;
  NSComparisonPredicate = interface(NSPredicate)
    ['{E10A5ABA-EA2A-4442-B18A-8B6F5601EA24}']
    function comparisonPredicateModifier: NSComparisonPredicateModifier; cdecl;
    function customSelector: SEL; cdecl;
    function initWithLeftExpression(lhs: NSExpression; rightExpression: NSExpression; customSelector: SEL): Pointer; cdecl; overload;
    function leftExpression: NSExpression; cdecl;
    function options: NSUInteger; cdecl;
    function predicateOperatorType: NSPredicateOperatorType; cdecl;
    function rightExpression: NSExpression; cdecl;
  end;
  TNSComparisonPredicate = class(TOCGenericImport<NSComparisonPredicateClass, NSComparisonPredicate>)  end;

  NSCompoundPredicateClass = interface(NSPredicateClass)
    ['{D7818819-385D-4D66-BE54-1C7242F820C2}']
    {class} function andPredicateWithSubpredicates(subpredicates: NSArray): NSPredicate; cdecl;
    {class} function notPredicateWithSubpredicate(predicate: NSPredicate): NSPredicate; cdecl;
    {class} function orPredicateWithSubpredicates(subpredicates: NSArray): NSPredicate; cdecl;
  end;
  NSCompoundPredicate = interface(NSPredicate)
    ['{2F295442-B323-46E6-8417-2E85ABC457D4}']
    function compoundPredicateType: NSCompoundPredicateType; cdecl;
    function initWithType(type_: NSCompoundPredicateType; subpredicates: NSArray): Pointer; cdecl;
    function subpredicates: NSArray; cdecl;
  end;
  TNSCompoundPredicate = class(TOCGenericImport<NSCompoundPredicateClass, NSCompoundPredicate>)  end;

  NSMachPortClass = interface(NSPortClass)
    ['{D3B0F171-CE37-4D2B-904F-D815AABD293F}']
    {class} function portWithMachPort(machPort: Longword): NSPort; cdecl; overload;
    {class} function portWithMachPort(machPort: Longword; options: NSUInteger): NSPort; cdecl; overload;
  end;
  NSMachPort = interface(NSPort)
    ['{38E9CF5E-3127-4039-BC6D-C4C727E1053E}']
    function delegate: NSMachPortDelegate; cdecl;
    function initWithMachPort(machPort: Longword): Pointer; cdecl; overload;
    function initWithMachPort(machPort: Longword; options: NSUInteger): Pointer; cdecl; overload;
    function machPort: Longword; cdecl;
    procedure removeFromRunLoop(runLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure scheduleInRunLoop(runLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure setDelegate(anObject: NSMachPortDelegate); cdecl;
  end;
  TNSMachPort = class(TOCGenericImport<NSMachPortClass, NSMachPort>)  end;

  NSOutputStreamClass = interface(NSStreamClass)
    ['{4B33B379-1415-4092-B0D1-1A9DFA2E03FE}']
    {class} function outputStreamToBuffer(buffer: PByte; capacity: NSUInteger): Pointer; cdecl;
    {class} function outputStreamToFileAtPath(path: NSString; append: Boolean): Pointer; cdecl;
    {class} function outputStreamToMemory: Pointer; cdecl;
    {class} function outputStreamWithURL(url: NSURL; append: Boolean): Pointer; cdecl;
  end;
  NSOutputStream = interface(NSStream)
    ['{E4EAF16A-9B4F-4EB3-8B65-BE2A50BDE913}']
    function hasSpaceAvailable: Boolean; cdecl;
    function initToBuffer(buffer: PByte; capacity: NSUInteger): Pointer; cdecl;
    function initToFileAtPath(path: NSString; append: Boolean): Pointer; cdecl;
    function initToMemory: Pointer; cdecl;
    function initWithURL(url: NSURL; append: Boolean): Pointer; cdecl;
    function write(buffer: PByte; maxLength: NSUInteger): NSInteger; cdecl;
  end;
  TNSOutputStream = class(TOCGenericImport<NSOutputStreamClass, NSOutputStream>)  end;

  NSPortCoderClass = interface(NSCoderClass)
    ['{F94BC015-EA03-4409-8488-85ECE7D1B6E4}']
    {class} function portCoderWithReceivePort(rcvPort: NSPort; sendPort: NSPort; components: NSArray): Pointer; cdecl;
  end;
  NSPortCoder = interface(NSCoder)
    ['{D4CBD043-1412-46AD-AB3F-5D55629B7F14}']
    function connection: NSConnection; cdecl;
    function decodePortObject: NSPort; cdecl;
    procedure dispatch; cdecl;
    procedure encodePortObject(aport: NSPort); cdecl;
    function initWithReceivePort(rcvPort: NSPort; sendPort: NSPort; components: NSArray): Pointer; cdecl;
    function isBycopy: Boolean; cdecl;
    function isByref: Boolean; cdecl;
  end;
  TNSPortCoder = class(TOCGenericImport<NSPortCoderClass, NSPortCoder>)  end;

  NSNumberFormatterClass = interface(NSFormatterClass)
    ['{98A46D3C-09D1-4220-BBA7-AB1320D411D6}']
    {class} function defaultFormatterBehavior: NSNumberFormatterBehavior; cdecl;
    {class} function localizedStringFromNumber(num: NSNumber; numberStyle: NSNumberFormatterStyle): NSString; cdecl;
    {class} procedure setDefaultFormatterBehavior(behavior: NSNumberFormatterBehavior); cdecl;
  end;
  NSNumberFormatter = interface(NSFormatter)
    ['{735C5BFD-8CAA-46EA-BA01-0A085B77F1EE}']
    function allowsFloats: Boolean; cdecl;
    function alwaysShowsDecimalSeparator: Boolean; cdecl;
    function attributedStringForNil: NSAttributedString; cdecl;
    function attributedStringForNotANumber: NSAttributedString; cdecl;
    function attributedStringForZero: NSAttributedString; cdecl;
    function currencyCode: NSString; cdecl;
    function currencyDecimalSeparator: NSString; cdecl;
    function currencyGroupingSeparator: NSString; cdecl;
    function currencySymbol: NSString; cdecl;
    function decimalSeparator: NSString; cdecl;
    function exponentSymbol: NSString; cdecl;
    function format: NSString; cdecl;
    function formatWidth: NSUInteger; cdecl;
    function formatterBehavior: NSNumberFormatterBehavior; cdecl;
    function generatesDecimalNumbers: Boolean; cdecl;
    function getObjectValue(out obj: Pointer; forString: NSString; out range: PNSRange; out error: NSError): Boolean; cdecl;
    function groupingSeparator: NSString; cdecl;
    function groupingSize: NSUInteger; cdecl;
    function hasThousandSeparators: Boolean; cdecl;
    function internationalCurrencySymbol: NSString; cdecl;
    function isLenient: Boolean; cdecl;
    function isPartialStringValidationEnabled: Boolean; cdecl;
    function locale: NSLocale; cdecl;
    function localizesFormat: Boolean; cdecl;
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
    function roundingBehavior: NSDecimalNumberHandler; cdecl;
    function roundingIncrement: NSNumber; cdecl;
    function roundingMode: NSNumberFormatterRoundingMode; cdecl;
    function secondaryGroupingSize: NSUInteger; cdecl;
    procedure setAllowsFloats(flag: Boolean); cdecl;
    procedure setAlwaysShowsDecimalSeparator(b: Boolean); cdecl;
    procedure setAttributedStringForNil(newAttributedString: NSAttributedString); cdecl;
    procedure setAttributedStringForNotANumber(newAttributedString: NSAttributedString); cdecl;
    procedure setAttributedStringForZero(newAttributedString: NSAttributedString); cdecl;
    procedure setCurrencyCode(string_: NSString); cdecl;
    procedure setCurrencyDecimalSeparator(string_: NSString); cdecl;
    procedure setCurrencyGroupingSeparator(string_: NSString); cdecl;
    procedure setCurrencySymbol(string_: NSString); cdecl;
    procedure setDecimalSeparator(string_: NSString); cdecl;
    procedure setExponentSymbol(string_: NSString); cdecl;
    procedure setFormat(string_: NSString); cdecl;
    procedure setFormatWidth(number: NSUInteger); cdecl;
    procedure setFormatterBehavior(behavior: NSNumberFormatterBehavior); cdecl;
    procedure setGeneratesDecimalNumbers(b: Boolean); cdecl;
    procedure setGroupingSeparator(string_: NSString); cdecl;
    procedure setGroupingSize(number: NSUInteger); cdecl;
    procedure setHasThousandSeparators(flag: Boolean); cdecl;
    procedure setInternationalCurrencySymbol(string_: NSString); cdecl;
    procedure setLenient(b: Boolean); cdecl;
    procedure setLocale(locale: NSLocale); cdecl;
    procedure setLocalizesFormat(flag: Boolean); cdecl;
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
    procedure setRoundingBehavior(newRoundingBehavior: NSDecimalNumberHandler); cdecl;
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
    procedure setThousandSeparator(newSeparator: NSString); cdecl;
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
    function thousandSeparator: NSString; cdecl;
    function usesGroupingSeparator: Boolean; cdecl;
    function usesSignificantDigits: Boolean; cdecl;
    function zeroSymbol: NSString; cdecl;
  end;
  TNSNumberFormatter = class(TOCGenericImport<NSNumberFormatterClass, NSNumberFormatter>)  end;

  NSNameSpecifierClass = interface(NSScriptObjectSpecifierClass)
    ['{08998C46-0CC7-43DB-954D-DE2FDC7E6BE6}']
  end;
  NSNameSpecifier = interface(NSScriptObjectSpecifier)
    ['{85B2C26D-0738-465C-86BB-51B65414639D}']
    function initWithContainerClassDescription(classDesc: NSScriptClassDescription; containerSpecifier: NSScriptObjectSpecifier; key: NSString; name: NSString): Pointer; cdecl;
    function name: NSString; cdecl;
    procedure setName(name: NSString); cdecl;
  end;
  TNSNameSpecifier = class(TOCGenericImport<NSNameSpecifierClass, NSNameSpecifier>)  end;

  NSNumberClass = interface(NSValueClass)
    ['{DF327E76-2E10-4114-95DE-4636B8E165AE}']
    {class} function numberWithBool(value: Boolean): Pointer; cdecl;
    {class} function numberWithChar(value: AnsiChar): Pointer; cdecl;
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
    ['{CC5A6F33-EED7-455E-8E32-ABDDEC5B454F}']
    function boolValue: Boolean; cdecl;
    function charValue: AnsiChar; cdecl;
    function compare(otherNumber: NSNumber): NSComparisonResult; cdecl;
    function decimalValue: NSDecimal; cdecl;
    function descriptionWithLocale(locale: Pointer): NSString; cdecl;
    function doubleValue: double; cdecl;
    function floatValue: Single; cdecl;
    function initWithBool(value: Boolean): Pointer; cdecl;
    function initWithChar(value: AnsiChar): Pointer; cdecl;
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

  NSRelativeSpecifierClass = interface(NSScriptObjectSpecifierClass)
    ['{9FA5DC1E-9FF4-46B7-8052-5B44688E9BE5}']
  end;
  NSRelativeSpecifier = interface(NSScriptObjectSpecifier)
    ['{A4543A7A-26BE-4FFC-9CA3-27A37FBE707B}']
    function baseSpecifier: NSScriptObjectSpecifier; cdecl;
    function initWithContainerClassDescription(classDesc: NSScriptClassDescription; containerSpecifier: NSScriptObjectSpecifier; key: NSString; relativePosition: NSRelativePosition; baseSpecifier: NSScriptObjectSpecifier): Pointer; cdecl;
    function relativePosition: NSRelativePosition; cdecl;
    procedure setBaseSpecifier(baseSpecifier: NSScriptObjectSpecifier); cdecl;
    procedure setRelativePosition(relPos: NSRelativePosition); cdecl;
  end;
  TNSRelativeSpecifier = class(TOCGenericImport<NSRelativeSpecifierClass, NSRelativeSpecifier>)  end;

  NSScriptClassDescriptionClass = interface(NSClassDescriptionClass)
    ['{FF371F58-5F57-43D0-9008-FA0237A8F031}']
    {class} function classDescriptionForClass(aClass: Pointer): Pointer; cdecl;
  end;
  NSScriptClassDescription = interface(NSClassDescription)
    ['{B3A80499-73EB-4F90-B03A-76EBA2750D06}']
    function appleEventCode: FourCharCode; cdecl;
    function appleEventCodeForKey(key: NSString): FourCharCode; cdecl;
    function classDescriptionForKey(key: NSString): NSScriptClassDescription; cdecl;
    function className: NSString; cdecl;
    function defaultSubcontainerAttributeKey: NSString; cdecl;
    function hasOrderedToManyRelationshipForKey(key: NSString): Boolean; cdecl;
    function hasPropertyForKey(key: NSString): Boolean; cdecl;
    function hasReadablePropertyForKey(key: NSString): Boolean; cdecl;
    function hasWritablePropertyForKey(key: NSString): Boolean; cdecl;
    function implementationClassName: NSString; cdecl;
    function initWithSuiteName(suiteName: NSString; className: NSString; dictionary: NSDictionary): Pointer; cdecl;
    function isLocationRequiredToCreateForKey(toManyRelationshipKey: NSString): Boolean; cdecl;
    function isReadOnlyKey(key: NSString): Boolean; cdecl;
    function keyWithAppleEventCode(appleEventCode: FourCharCode): NSString; cdecl;
    function matchesAppleEventCode(appleEventCode: FourCharCode): Boolean; cdecl;
    function selectorForCommand(commandDescription: NSScriptCommandDescription): SEL; cdecl;
    function suiteName: NSString; cdecl;
    function superclassDescription: NSScriptClassDescription; cdecl;
    function supportsCommand(commandDescription: NSScriptCommandDescription): Boolean; cdecl;
    function typeForKey(key: NSString): NSString; cdecl;
  end;
  TNSScriptClassDescription = class(TOCGenericImport<NSScriptClassDescriptionClass, NSScriptClassDescription>)  end;

  NSRangeSpecifierClass = interface(NSScriptObjectSpecifierClass)
    ['{90EA1CB7-DE33-4E7F-89E1-F526C187D549}']
  end;
  NSRangeSpecifier = interface(NSScriptObjectSpecifier)
    ['{DDAA3DA0-20F9-4B62-BC48-68B9E76B477B}']
    function endSpecifier: NSScriptObjectSpecifier; cdecl;
    function initWithContainerClassDescription(classDesc: NSScriptClassDescription; containerSpecifier: NSScriptObjectSpecifier; key: NSString; startSpecifier: NSScriptObjectSpecifier; endSpecifier: NSScriptObjectSpecifier): Pointer; cdecl;
    procedure setEndSpecifier(endSpec: NSScriptObjectSpecifier); cdecl;
    procedure setStartSpecifier(startSpec: NSScriptObjectSpecifier); cdecl;
    function startSpecifier: NSScriptObjectSpecifier; cdecl;
  end;
  TNSRangeSpecifier = class(TOCGenericImport<NSRangeSpecifierClass, NSRangeSpecifier>)  end;

  NSProtocolCheckerClass = interface(NSProxyClass)
    ['{E46354C1-1BE8-454C-AE02-43D5B60AD05C}']
    {class} function protocolCheckerWithTarget(anObject: NSObject; protocol: Pointer): Pointer; cdecl;
  end;
  NSProtocolChecker = interface(NSProxy)
    ['{421FBF4A-F63C-480F-9373-5CD25BEEEB87}']
    function initWithTarget(anObject: NSObject; protocol: Pointer): Pointer; cdecl;
    function protocol: Pointer; cdecl;
    function target: NSObject; cdecl;
  end;
  TNSProtocolChecker = class(TOCGenericImport<NSProtocolCheckerClass, NSProtocolChecker>)  end;

  NSQuitCommandClass = interface(NSScriptCommandClass)
    ['{039D7067-19B7-43F8-8B73-CEA3A8B834B1}']
  end;
  NSQuitCommand = interface(NSScriptCommand)
    ['{4938570D-095B-469D-9484-7F38A4A49E8D}']
    function saveOptions: NSSaveOptions; cdecl;
  end;
  TNSQuitCommand = class(TOCGenericImport<NSQuitCommandClass, NSQuitCommand>)  end;

  NSMutableURLRequestClass = interface(NSURLRequestClass)
    ['{A689E5D2-523D-45C5-AB21-1B1CAFC4BAB2}']
  end;
  NSMutableURLRequest = interface(NSURLRequest)
    ['{4672D40A-8A86-4FCC-925C-727BEAE36E46}']
    procedure addValue(value: NSString; forHTTPHeaderField: NSString); cdecl;
    procedure setAllHTTPHeaderFields(headerFields: NSDictionary); cdecl;
    procedure setCachePolicy(policy: NSURLRequestCachePolicy); cdecl;
    procedure setHTTPBody(data: NSData); cdecl;
    procedure setHTTPBodyStream(inputStream: NSInputStream); cdecl;
    procedure setHTTPMethod(method: NSString); cdecl;
    procedure setHTTPShouldHandleCookies(should: Boolean); cdecl;
    procedure setMainDocumentURL(URL: NSURL); cdecl;
    procedure setTimeoutInterval(seconds: NSTimeInterval); cdecl;
    procedure setURL(URL: NSURL); cdecl;
    procedure setValue(value: NSString; forHTTPHeaderField: NSString); cdecl;
  end;
  TNSMutableURLRequest = class(TOCGenericImport<NSMutableURLRequestClass, NSMutableURLRequest>)  end;

  NSMutableAttributedStringClass = interface(NSAttributedStringClass)
    ['{A867F098-ECA8-4BEF-AB72-A18594B6E279}']
  end;
  NSMutableAttributedString = interface(NSAttributedString)
    ['{36EBB015-A8D2-44CD-859A-136AB577DB77}']
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

  NSMutableCharacterSetClass = interface(NSCharacterSetClass)
    ['{2FEB7555-733A-46C4-A2AC-58E05F701DB6}']
  end;
  NSMutableCharacterSet = interface(NSCharacterSet)
    ['{CB7E635D-8D5E-4B98-859B-64FB46997588}']
    procedure addCharactersInRange(aRange: NSRange); cdecl;
    procedure addCharactersInString(aString: NSString); cdecl;
    procedure formIntersectionWithCharacterSet(otherSet: NSCharacterSet); cdecl;
    procedure formUnionWithCharacterSet(otherSet: NSCharacterSet); cdecl;
    procedure invert; cdecl;
    procedure removeCharactersInRange(aRange: NSRange); cdecl;
    procedure removeCharactersInString(aString: NSString); cdecl;
  end;
  TNSMutableCharacterSet = class(TOCGenericImport<NSMutableCharacterSetClass, NSMutableCharacterSet>)  end;

  NSMutableDataClass = interface(NSDataClass)
    ['{3A7A32F3-9196-482D-9177-0EFB0545D6AD}']
    {class} function dataWithCapacity(aNumItems: NSUInteger): Pointer; cdecl;
    {class} function dataWithLength(length: NSUInteger): Pointer; cdecl;
  end;
  NSMutableData = interface(NSData)
    ['{3FBE9FC9-A73D-4F39-A2CA-F62C0CF59A64}']
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

  NSMessagePortNameServerClass = interface(NSPortNameServerClass)
    ['{5C3C5645-4A59-4037-9A44-7E664A392BBD}']
    {class} function sharedInstance: Pointer; cdecl;
  end;
  NSMessagePortNameServer = interface(NSPortNameServer)
    ['{8F39D20E-3DC6-41F5-A441-9CAF877CA1B2}']
    function portForName(name: NSString): NSPort; cdecl; overload;
    function portForName(name: NSString; host: NSString): NSPort; cdecl; overload;
  end;
  TNSMessagePortNameServer = class(TOCGenericImport<NSMessagePortNameServerClass, NSMessagePortNameServer>)  end;

  NSMoveCommandClass = interface(NSScriptCommandClass)
    ['{A74F2CE3-6462-4F5E-A9E5-AF7FBA1A59D3}']
  end;
  NSMoveCommand = interface(NSScriptCommand)
    ['{14DFB397-5452-41D2-8435-C780E2416D2D}']
    function keySpecifier: NSScriptObjectSpecifier; cdecl;
    procedure setReceiversSpecifier(receiversRef: NSScriptObjectSpecifier); cdecl;
  end;
  TNSMoveCommand = class(TOCGenericImport<NSMoveCommandClass, NSMoveCommand>)  end;

  NSMutableArrayClass = interface(NSArrayClass)
    ['{FCC5E79A-DFEB-4409-965E-49B8DAA5C378}']
    {class} function arrayWithCapacity(numItems: NSUInteger): Pointer; cdecl;
  end;
  NSMutableArray = interface(NSArray)
    ['{A0553412-4AE4-4556-BE05-6C6715913009}']
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
    procedure sortUsingComparator(cmptr: NSComparator); cdecl;
    procedure sortUsingDescriptors(sortDescriptors: NSArray); cdecl;
    procedure sortUsingSelector(comparator: SEL); cdecl;
    procedure sortWithOptions(opts: NSSortOptions; usingComparator: NSComparator); cdecl;
  end;
  TNSMutableArray = class(TOCGenericImport<NSMutableArrayClass, NSMutableArray>)  end;

  NSMutableSetClass = interface(NSSetClass)
    ['{96C4780B-65B7-47AC-99D1-9E24F8A5329F}']
    {class} function setWithCapacity(numItems: NSUInteger): Pointer; cdecl;
  end;
  NSMutableSet = interface(NSSet)
    ['{7E111C7D-6DAC-452E-A4F7-06303ADC7E4F}']
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

  NSMutableStringClass = interface(NSStringClass)
    ['{C71FAEC5-4D2E-4564-8EC4-DF8F6DDAD61F}']
    {class} function stringWithCapacity(capacity: NSUInteger): Pointer; cdecl;
  end;
  NSMutableString = interface(NSString)
    ['{D1C2A3C0-9B45-4DDC-A235-324B84D7651E}']
    procedure appendFormat(appendFormat: NSString); cdecl;
    procedure appendString(aString: NSString); cdecl;
    procedure deleteCharactersInRange(range: NSRange); cdecl;
    function initWithCapacity(capacity: NSUInteger): Pointer; cdecl;
    procedure insertString(aString: NSString; atIndex: NSUInteger); cdecl;
    procedure replaceCharactersInRange(range: NSRange; withString: NSString); cdecl;
    function replaceOccurrencesOfString(target: NSString; withString: NSString; options: NSStringCompareOptions; range: NSRange): NSUInteger; cdecl;
    procedure setString(aString: NSString); cdecl;
  end;
  TNSMutableString = class(TOCGenericImport<NSMutableStringClass, NSMutableString>)  end;

  NSMutableIndexSetClass = interface(NSIndexSetClass)
    ['{F6FDD504-E114-407A-ADAB-ABC9677B46BC}']
  end;
  NSMutableIndexSet = interface(NSIndexSet)
    ['{9AF55AE9-42D2-43EC-A975-DD46242A67F0}']
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

  NSMutableDictionaryClass = interface(NSDictionaryClass)
    ['{C7AC3570-545E-473D-A5E3-8DF5FE7520CF}']
    {class} function dictionaryWithCapacity(numItems: NSUInteger): Pointer; cdecl;
  end;
  NSMutableDictionary = interface(NSDictionary)
    ['{33010272-5700-4065-BCBD-9F1D9087EF71}']
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

  NSDecimalNumberClass = interface(NSNumberClass)
    ['{8CF0B675-0286-43AC-BF8D-34133C6FFEEC}']
    {class} function decimalNumberWithDecimal(dcm: NSDecimal): Pointer; cdecl;
    {class} function decimalNumberWithMantissa(mantissa: UInt64; exponent: Smallint; isNegative: Boolean): Pointer; cdecl;
    {class} function decimalNumberWithString(numberValue: NSString): Pointer; cdecl; overload;
    {class} function decimalNumberWithString(numberValue: NSString; locale: Pointer): Pointer; cdecl; overload;
    {class} function defaultBehavior: NSDecimalNumberBehaviors; cdecl;
    {class} function maximumDecimalNumber: Pointer; cdecl;
    {class} function minimumDecimalNumber: Pointer; cdecl;
    {class} function notANumber: Pointer; cdecl;
    {class} function one: Pointer; cdecl;
    {class} procedure setDefaultBehavior(behavior: NSDecimalNumberBehaviors); cdecl;
    {class} function zero: Pointer; cdecl;
  end;
  NSDecimalNumber = interface(NSNumber)
    ['{22CD5B7D-D0EF-4BD8-81B8-AD2A56FB52DB}']
    function compare(decimalNumber: NSNumber): NSComparisonResult; cdecl;
    function decimalNumberByAdding(decimalNumber: NSDecimalNumber): NSDecimalNumber; cdecl; overload;
    function decimalNumberByAdding(decimalNumber: NSDecimalNumber; withBehavior: NSDecimalNumberBehaviors): NSDecimalNumber; cdecl; overload;
    function decimalNumberByDividingBy(decimalNumber: NSDecimalNumber): NSDecimalNumber; cdecl; overload;
    function decimalNumberByDividingBy(decimalNumber: NSDecimalNumber; withBehavior: NSDecimalNumberBehaviors): NSDecimalNumber; cdecl; overload;
    function decimalNumberByMultiplyingBy(decimalNumber: NSDecimalNumber): NSDecimalNumber; cdecl; overload;
    function decimalNumberByMultiplyingBy(decimalNumber: NSDecimalNumber; withBehavior: NSDecimalNumberBehaviors): NSDecimalNumber; cdecl; overload;
    function decimalNumberByMultiplyingByPowerOf10(power: Smallint): NSDecimalNumber; cdecl; overload;
    function decimalNumberByMultiplyingByPowerOf10(power: Smallint; withBehavior: NSDecimalNumberBehaviors): NSDecimalNumber; cdecl; overload;
    function decimalNumberByRaisingToPower(power: NSUInteger): NSDecimalNumber; cdecl; overload;
    function decimalNumberByRaisingToPower(power: NSUInteger; withBehavior: NSDecimalNumberBehaviors): NSDecimalNumber; cdecl; overload;
    function decimalNumberByRoundingAccordingToBehavior(behavior: NSDecimalNumberBehaviors): NSDecimalNumber; cdecl;
    function decimalNumberBySubtracting(decimalNumber: NSDecimalNumber): NSDecimalNumber; cdecl; overload;
    function decimalNumberBySubtracting(decimalNumber: NSDecimalNumber; withBehavior: NSDecimalNumberBehaviors): NSDecimalNumber; cdecl; overload;
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

  NSCountedSetClass = interface(NSMutableSetClass)
    ['{4E468B75-0A3D-4A8C-8937-EA24B3239F88}']
  end;
  NSCountedSet = interface(NSMutableSet)
    ['{A5A4E593-D6B2-4474-819D-B3CF990A486E}']
    procedure addObject(object_: Pointer); cdecl;
    function countForObject(object_: Pointer): NSUInteger; cdecl;
    function initWithArray(array_: NSArray): Pointer; cdecl;
    function initWithCapacity(numItems: NSUInteger): Pointer; cdecl;
    function initWithSet(set_: NSSet): Pointer; cdecl;
    function objectEnumerator: NSEnumerator; cdecl;
    procedure removeObject(object_: Pointer); cdecl;
  end;
  TNSCountedSet = class(TOCGenericImport<NSCountedSetClass, NSCountedSet>)  end;

// exported string consts

function NSDefaultRunLoopMode: NSString;
function NSRunLoopCommonModes: NSString;

// Convenience method for creating an NSString from a Delphi Unicode string
function NSSTR(Str: string): NSString;

// Utility method for loading an pointer constant from a framework
function CocoaPointerConst(Fwk: string; ConstStr: string): Pointer;

// Utility method for loading an NSString constant from a framework
function CocoaNSStringConst(Fwk: string; ConstStr: string): NSString;

implementation

uses System.SysUtils;

const
  FoundationFwk: string = '/System/Library/Frameworks/Foundation.framework/Foundation';

function NSSTR(Str: string): NSString;
var
  M: TMarshaller;
begin
  Result := TNSString.Wrap(TNSString.OCClass.stringWithUTF8String(M.AsAnsi(Str, CP_UTF8).ToPointer));
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

end.
