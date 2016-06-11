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
// Interfaces for Cocoa framework Foundation 
//
unit Macapi.Foundation;

interface

uses
  Macapi.ObjCRuntime, Macapi.ObjectiveC, Macapi.CocoaTypes, Macapi.CoreFoundation, Macapi.CoreServices;


const
  NSOrderedAscending = -1;
  NSOrderedSame = 0;
  NSOrderedDescending = 1;
  NSEnumerationConcurrent = (1 shl 0);
  NSEnumerationReverse = (1 shl 1);
  NSSortConcurrent = (1 shl 0);
  NSSortStable = (1 shl 4);
  NSQualityOfServiceUserInteractive = 33;
  NSQualityOfServiceUserInitiated = 25;
  NSQualityOfServiceUtility = 17;
  NSQualityOfServiceBackground = 9;
  NSQualityOfServiceDefault = -1;
  NSNotFound = 2147483647;
  NSScannedOption = (1 shl 0);
  NSCollectorDisabledOption = (1 shl 1);
  NSBinarySearchingFirstEqual = (1 shl 8);
  NSBinarySearchingLastEqual = (1 shl 9);
  NSBinarySearchingInsertionIndex = (1 shl 10);
  NSBundleExecutableArchitectureI386 = 7;
  NSBundleExecutableArchitecturePPC = 18;
  NSBundleExecutableArchitectureX86_64 = 16777223;
  NSBundleExecutableArchitecturePPC64 = 16777234;
  NS_UnknownByteOrder = CFByteOrderUnknown;
  NS_LittleEndian = CFByteOrderLittleEndian;
  NS_BigEndian = CFByteOrderBigEndian;
  NSCalendarUnitEra = kCFCalendarUnitEra;
  NSCalendarUnitYear = kCFCalendarUnitYear;
  NSCalendarUnitMonth = kCFCalendarUnitMonth;
  NSCalendarUnitDay = kCFCalendarUnitDay;
  NSCalendarUnitHour = kCFCalendarUnitHour;
  NSCalendarUnitMinute = kCFCalendarUnitMinute;
  NSCalendarUnitSecond = kCFCalendarUnitSecond;
  NSCalendarUnitWeekday = kCFCalendarUnitWeekday;
  NSCalendarUnitWeekdayOrdinal = kCFCalendarUnitWeekdayOrdinal;
  NSCalendarUnitQuarter = kCFCalendarUnitQuarter;
  NSCalendarUnitWeekOfMonth = kCFCalendarUnitWeekOfMonth;
  NSCalendarUnitWeekOfYear = kCFCalendarUnitWeekOfYear;
  NSCalendarUnitYearForWeekOfYear = kCFCalendarUnitYearForWeekOfYear;
  NSCalendarUnitNanosecond = (1 shl 15);
  NSCalendarUnitCalendar = (1 shl 20);
  NSCalendarUnitTimeZone = (1 shl 21);
  NSEraCalendarUnit = NSCalendarUnitEra;
  NSYearCalendarUnit = NSCalendarUnitYear;
  NSMonthCalendarUnit = NSCalendarUnitMonth;
  NSDayCalendarUnit = NSCalendarUnitDay;
  NSHourCalendarUnit = NSCalendarUnitHour;
  NSMinuteCalendarUnit = NSCalendarUnitMinute;
  NSSecondCalendarUnit = NSCalendarUnitSecond;
  NSWeekCalendarUnit = kCFCalendarUnitWeek;
  NSWeekdayCalendarUnit = NSCalendarUnitWeekday;
  NSWeekdayOrdinalCalendarUnit = NSCalendarUnitWeekdayOrdinal;
  NSQuarterCalendarUnit = NSCalendarUnitQuarter;
  NSWeekOfMonthCalendarUnit = NSCalendarUnitWeekOfMonth;
  NSWeekOfYearCalendarUnit = NSCalendarUnitWeekOfYear;
  NSYearForWeekOfYearCalendarUnit = NSCalendarUnitYearForWeekOfYear;
  NSCalendarCalendarUnit = NSCalendarUnitCalendar;
  NSTimeZoneCalendarUnit = NSCalendarUnitTimeZone;
  NSCalendarWrapComponents = (1 shl 0);
  NSCalendarMatchStrictly = (1 shl 1);
  NSCalendarSearchBackwards = (1 shl 2);
  NSCalendarMatchPreviousTimePreservingSmallerUnits = (1 shl 8);
  NSCalendarMatchNextTimePreservingSmallerUnits = (1 shl 9);
  NSCalendarMatchNextTime = (1 shl 10);
  NSCalendarMatchFirst = (1 shl 12);
  NSCalendarMatchLast = (1 shl 13);
  NSWrapCalendarComponents = NSCalendarWrapComponents;
  NSDateComponentUndefined = 9223372036854775807;
  NSUndefinedDateComponent = NSDateComponentUndefined;
  NSCaseInsensitiveSearch = 1;
  NSLiteralSearch = 2;
  NSBackwardsSearch = 4;
  NSAnchoredSearch = 8;
  NSNumericSearch = 64;
  NSDiacriticInsensitiveSearch = 128;
  NSWidthInsensitiveSearch = 256;
  NSForcedOrderingSearch = 512;
  NSRegularExpressionSearch = 1024;
  NSASCIIStringEncoding = 1;
  NSNEXTSTEPStringEncoding = 2;
  NSJapaneseEUCStringEncoding = 3;
  NSUTF8StringEncoding = 4;
  NSISOLatin1StringEncoding = 5;
  NSSymbolStringEncoding = 6;
  NSNonLossyASCIIStringEncoding = 7;
  NSShiftJISStringEncoding = 8;
  NSISOLatin2StringEncoding = 9;
  NSUnicodeStringEncoding = 10;
  NSWindowsCP1251StringEncoding = 11;
  NSWindowsCP1252StringEncoding = 12;
  NSWindowsCP1253StringEncoding = 13;
  NSWindowsCP1254StringEncoding = 14;
  NSWindowsCP1250StringEncoding = 15;
  NSISO2022JPStringEncoding = 21;
  NSMacOSRomanStringEncoding = 30;
  NSUTF16StringEncoding = NSUnicodeStringEncoding;
  NSUTF16BigEndianStringEncoding = 2415919360;
  NSUTF16LittleEndianStringEncoding = 2483028224;
  NSUTF32StringEncoding = 2348810496;
  NSUTF32BigEndianStringEncoding = 2550137088;
  NSUTF32LittleEndianStringEncoding = 2617245952;
  NSStringEncodingConversionAllowLossy = 1;
  NSStringEncodingConversionExternalRepresentation = 2;
  NSStringEnumerationByLines = 0;
  NSStringEnumerationByParagraphs = 1;
  NSStringEnumerationByComposedCharacterSequences = 2;
  NSStringEnumerationByWords = 3;
  NSStringEnumerationBySentences = 4;
  NSStringEnumerationReverse = 1 shl 8;
  NSStringEnumerationSubstringNotRequired = 1 shl 9;
  NSStringEnumerationLocalized = 1 shl 10;
  NSProprietaryStringEncoding = 65536;
  NSOpenStepUnicodeReservedBase = 62464;
  NSDataReadingMappedIfSafe = 1 shl 0;
  NSDataReadingUncached = 1 shl 1;
  NSDataReadingMappedAlways = 1 shl 3;
  NSDataReadingMapped = NSDataReadingMappedIfSafe;
  NSMappedRead = NSDataReadingMapped;
  NSUncachedRead = NSDataReadingUncached;
  NSDataWritingAtomic = 1 shl 0;
  NSDataWritingWithoutOverwriting = 1 shl 1;
  NSAtomicWrite = NSDataWritingAtomic;
  NSDataSearchBackwards = 1 shl 0;
  NSDataSearchAnchored = 1 shl 1;
  NSDataBase64Encoding64CharacterLineLength = 1 shl 0;
  NSDataBase64Encoding76CharacterLineLength = 1 shl 1;
  NSDataBase64EncodingEndLineWithCarriageReturn = 1 shl 4;
  NSDataBase64EncodingEndLineWithLineFeed = 1 shl 5;
  NSDataBase64DecodingIgnoreUnknownCharacters = 1 shl 0;
  NSFormattingContextUnknown = 0;
  NSFormattingContextDynamic = 1;
  NSFormattingContextStandalone = 2;
  NSFormattingContextListItem = 3;
  NSFormattingContextBeginningOfSentence = 4;
  NSFormattingContextMiddleOfSentence = 5;
  NSFormattingUnitStyleShort = 1;
  NSFormattingUnitStyleMedium = 2;
  NSFormattingUnitStyleLong = 3;
  NSDateFormatterNoStyle = kCFDateFormatterNoStyle;
  NSDateFormatterShortStyle = kCFDateFormatterShortStyle;
  NSDateFormatterMediumStyle = kCFDateFormatterMediumStyle;
  NSDateFormatterLongStyle = kCFDateFormatterLongStyle;
  NSDateFormatterFullStyle = kCFDateFormatterFullStyle;
  NSDateFormatterBehaviorDefault = 0;
  NSDateFormatterBehavior10_0 = 1000;
  NSDateFormatterBehavior10_4 = 1040;
  NSDateIntervalFormatterNoStyle = 0;
  NSDateIntervalFormatterShortStyle = 1;
  NSDateIntervalFormatterMediumStyle = 2;
  NSDateIntervalFormatterLongStyle = 3;
  NSDateIntervalFormatterFullStyle = 4;
  NSMassFormatterUnitGram = 11;
  NSMassFormatterUnitKilogram = 14;
  NSMassFormatterUnitOunce = (6 shl 8) + 1;
  NSMassFormatterUnitPound = (6 shl 8) + 2;
  NSMassFormatterUnitStone = (6 shl 8) + 3;
  NSLengthFormatterUnitMillimeter = 8;
  NSLengthFormatterUnitCentimeter = 9;
  NSLengthFormatterUnitMeter = 11;
  NSLengthFormatterUnitKilometer = 14;
  NSLengthFormatterUnitInch = (5 shl 8) + 1;
  NSLengthFormatterUnitFoot = (5 shl 8) + 2;
  NSLengthFormatterUnitYard = (5 shl 8) + 3;
  NSLengthFormatterUnitMile = (5 shl 8) + 4;
  NSEnergyFormatterUnitJoule = 11;
  NSEnergyFormatterUnitKilojoule = 14;
  NSEnergyFormatterUnitCalorie = (7 shl 8) + 1;
  NSEnergyFormatterUnitKilocalorie = (7 shl 8) + 2;
  NSRoundPlain = 0;
  NSRoundDown = 1;
  NSRoundUp = 2;
  NSRoundBankers = 3;
  NSCalculationNoError = 0;
  NSCalculationLossOfPrecision = 1;
  NSCalculationUnderflow = 2;
  NSCalculationOverflow = 3;
  NSCalculationDivideByZero = 4;
  NSApplicationDirectory = 1;
  NSDemoApplicationDirectory = 2;
  NSDeveloperApplicationDirectory = 3;
  NSAdminApplicationDirectory = 4;
  NSLibraryDirectory = 5;
  NSDeveloperDirectory = 6;
  NSUserDirectory = 7;
  NSDocumentationDirectory = 8;
  NSDocumentDirectory = 9;
  NSCoreServiceDirectory = 10;
  NSAutosavedInformationDirectory = 11;
  NSDesktopDirectory = 12;
  NSCachesDirectory = 13;
  NSApplicationSupportDirectory = 14;
  NSDownloadsDirectory = 15;
  NSInputMethodsDirectory = 16;
  NSMoviesDirectory = 17;
  NSMusicDirectory = 18;
  NSPicturesDirectory = 19;
  NSPrinterDescriptionDirectory = 20;
  NSSharedPublicDirectory = 21;
  NSPreferencePanesDirectory = 22;
  NSApplicationScriptsDirectory = 23;
  NSItemReplacementDirectory = 99;
  NSAllApplicationsDirectory = 100;
  NSAllLibrariesDirectory = 101;
  NSTrashDirectory = 102;
  NSUserDomainMask = 1;
  NSLocalDomainMask = 2;
  NSNetworkDomainMask = 4;
  NSSystemDomainMask = 8;
  NSAllDomainsMask = 65535;
  NSVolumeEnumerationSkipHiddenVolumes = 1 shl 1;
  NSVolumeEnumerationProduceFileReferenceURLs = 1 shl 2;
  NSDirectoryEnumerationSkipsSubdirectoryDescendants = 1 shl 0;
  NSDirectoryEnumerationSkipsPackageDescendants = 1 shl 1;
  NSDirectoryEnumerationSkipsHiddenFiles = 1 shl 2;
  NSFileManagerItemReplacementUsingNewMetadataOnly = 1 shl 0;
  NSFileManagerItemReplacementWithoutDeletingBackupItem = 1 shl 1;
  NSURLRelationshipContains = 0;
  NSURLRelationshipSame = 1;
  NSURLRelationshipOther = 2;
  NSPointerFunctionsStrongMemory = (0 shl 0);
  NSPointerFunctionsZeroingWeakMemory = (1 shl 0);
  NSPointerFunctionsOpaqueMemory = (2 shl 0);
  NSPointerFunctionsMallocMemory = (3 shl 0);
  NSPointerFunctionsMachVirtualMemory = (4 shl 0);
  NSPointerFunctionsWeakMemory = (5 shl 0);
  NSPointerFunctionsObjectPersonality = (0 shl 8);
  NSPointerFunctionsOpaquePersonality = (1 shl 8);
  NSPointerFunctionsObjectPointerPersonality = (2 shl 8);
  NSPointerFunctionsCStringPersonality = (3 shl 8);
  NSPointerFunctionsStructPersonality = (4 shl 8);
  NSPointerFunctionsIntegerPersonality = (5 shl 8);
  NSPointerFunctionsCopyIn = (1 shl 16);
  NSHashTableStrongMemory = 0;
  NSHashTableZeroingWeakMemory = NSPointerFunctionsZeroingWeakMemory;
  NSHashTableCopyIn = NSPointerFunctionsCopyIn;
  NSHashTableObjectPointerPersonality = NSPointerFunctionsObjectPointerPersonality;
  NSHashTableWeakMemory = NSPointerFunctionsWeakMemory;
  NSHTTPCookieAcceptPolicyAlways = 0;
  NSHTTPCookieAcceptPolicyNever = 1;
  NSHTTPCookieAcceptPolicyOnlyFromMainDocumentDomain = 2;
  NSJSONReadingMutableContainers = (1 shl 0);
  NSJSONReadingMutableLeaves = (1 shl 1);
  NSJSONReadingAllowFragments = (1 shl 2);
  NSJSONWritingPrettyPrinted = (1 shl 0);
  NSKeyValueObservingOptionNew = 1;
  NSKeyValueObservingOptionOld = 2;
  NSKeyValueObservingOptionInitial = 4;
  NSKeyValueObservingOptionPrior = 8;
  NSKeyValueChangeSetting = 1;
  NSKeyValueChangeInsertion = 2;
  NSKeyValueChangeRemoval = 3;
  NSKeyValueChangeReplacement = 4;
  NSKeyValueUnionSetMutation = 1;
  NSKeyValueMinusSetMutation = 2;
  NSKeyValueIntersectSetMutation = 3;
  NSKeyValueSetSetMutation = 4;
  NSPropertyListImmutable = kCFPropertyListImmutable;
  NSPropertyListMutableContainers = kCFPropertyListMutableContainers;
  NSPropertyListMutableContainersAndLeaves = kCFPropertyListMutableContainersAndLeaves;
  NSPropertyListOpenStepFormat = kCFPropertyListOpenStepFormat;
  NSPropertyListXMLFormat_v1_0 = kCFPropertyListXMLFormat_v1_0;
  NSPropertyListBinaryFormat_v1_0 = kCFPropertyListBinaryFormat_v1_0;
  NSAlignMinXInward = 1 shl 0;
  NSAlignMinYInward = 1 shl 1;
  NSAlignMaxXInward = 1 shl 2;
  NSAlignMaxYInward = 1 shl 3;
  NSAlignWidthInward = 1 shl 4;
  NSAlignHeightInward = 1 shl 5;
  NSAlignMinXOutward = 1 shl 8;
  NSAlignMinYOutward = 1 shl 9;
  NSAlignMaxXOutward = 1 shl 10;
  NSAlignMaxYOutward = 1 shl 11;
  NSAlignWidthOutward = 1 shl 12;
  NSAlignHeightOutward = 1 shl 13;
  NSAlignMinXNearest = 1 shl 16;
  NSAlignMinYNearest = 1 shl 17;
  NSAlignMaxXNearest = 1 shl 18;
  NSAlignMaxYNearest = 1 shl 19;
  NSAlignWidthNearest = 1 shl 20;
  NSAlignHeightNearest = 1 shl 21;
  NSAlignRectFlipped = 1 shl 63;
  NSAlignAllEdgesInward = NSAlignMinXInward or NSAlignMaxXInward or NSAlignMinYInward or NSAlignMaxYInward;
  NSAlignAllEdgesOutward = NSAlignMinXOutward or NSAlignMaxXOutward or NSAlignMinYOutward or NSAlignMaxYOutward;
  NSAlignAllEdgesNearest = NSAlignMinXNearest or NSAlignMaxXNearest or NSAlignMinYNearest or NSAlignMaxYNearest;
  NSLocaleLanguageDirectionUnknown = kCFLocaleLanguageDirectionUnknown;
  NSLocaleLanguageDirectionLeftToRight = kCFLocaleLanguageDirectionLeftToRight;
  NSLocaleLanguageDirectionRightToLeft = kCFLocaleLanguageDirectionRightToLeft;
  NSLocaleLanguageDirectionTopToBottom = kCFLocaleLanguageDirectionTopToBottom;
  NSLocaleLanguageDirectionBottomToTop = kCFLocaleLanguageDirectionBottomToTop;
  NSMapTableStrongMemory = 0;
  NSMapTableZeroingWeakMemory = NSPointerFunctionsZeroingWeakMemory;
  NSMapTableCopyIn = NSPointerFunctionsCopyIn;
  NSMapTableObjectPointerPersonality = NSPointerFunctionsObjectPointerPersonality;
  NSMapTableWeakMemory = NSPointerFunctionsWeakMemory;
  NSPostWhenIdle = 1;
  NSPostASAP = 2;
  NSPostNow = 3;
  NSNotificationNoCoalescing = 0;
  NSNotificationCoalescingOnName = 1;
  NSNotificationCoalescingOnSender = 2;
  NSNumberFormatterBehaviorDefault = 0;
  NSNumberFormatterBehavior10_0 = 1000;
  NSNumberFormatterBehavior10_4 = 1040;
  NSNumberFormatterNoStyle = kCFNumberFormatterNoStyle;
  NSNumberFormatterDecimalStyle = kCFNumberFormatterDecimalStyle;
  NSNumberFormatterCurrencyStyle = kCFNumberFormatterCurrencyStyle;
  NSNumberFormatterPercentStyle = kCFNumberFormatterPercentStyle;
  NSNumberFormatterScientificStyle = kCFNumberFormatterScientificStyle;
  NSNumberFormatterSpellOutStyle = kCFNumberFormatterSpellOutStyle;
  NSNumberFormatterPadBeforePrefix = kCFNumberFormatterPadBeforePrefix;
  NSNumberFormatterPadAfterPrefix = kCFNumberFormatterPadAfterPrefix;
  NSNumberFormatterPadBeforeSuffix = kCFNumberFormatterPadBeforeSuffix;
  NSNumberFormatterPadAfterSuffix = kCFNumberFormatterPadAfterSuffix;
  NSNumberFormatterRoundCeiling = kCFNumberFormatterRoundCeiling;
  NSNumberFormatterRoundFloor = kCFNumberFormatterRoundFloor;
  NSNumberFormatterRoundDown = kCFNumberFormatterRoundDown;
  NSNumberFormatterRoundUp = kCFNumberFormatterRoundUp;
  NSNumberFormatterRoundHalfEven = kCFNumberFormatterRoundHalfEven;
  NSNumberFormatterRoundHalfDown = kCFNumberFormatterRoundHalfDown;
  NSNumberFormatterRoundHalfUp = kCFNumberFormatterRoundHalfUp;
  NSOperationQueuePriorityVeryLow = -8;
  NSOperationQueuePriorityLow = -4;
  NSOperationQueuePriorityNormal = 0;
  NSOperationQueuePriorityHigh = 4;
  NSOperationQueuePriorityVeryHigh = 8;
  NSOperationQueueDefaultMaxConcurrentOperationCount = -1;
  NSMachPortDeallocateNone = 0;
  NSMachPortDeallocateSendRight = (1 shl 0);
  NSMachPortDeallocateReceiveRight = (1 shl 1);
  NSWindowsNTOperatingSystem = 1;
  NSWindows95OperatingSystem = 2;
  NSSolarisOperatingSystem = 3;
  NSHPUXOperatingSystem = 4;
  NSMACHOperatingSystem = 5;
  NSSunOSOperatingSystem = 6;
  NSOSF1OperatingSystem = 7;
  NSActivityIdleDisplaySleepDisabled = (1 shl 40);
  NSActivityIdleSystemSleepDisabled = (1 shl 20);
  NSActivitySuddenTerminationDisabled = (1 shl 14);
  NSActivityAutomaticTerminationDisabled = (1 shl 15);
  NSActivityUserInitiated = (16777215 or NSActivityIdleSystemSleepDisabled);
  NSActivityUserInitiatedAllowingIdleSystemSleep = (NSActivityUserInitiated and not NSActivityIdleSystemSleepDisabled);
  NSActivityBackground = 255;
  NSActivityLatencyCritical = 1095216660480;
  NSTextCheckingTypeOrthography = 1 shl 0;
  NSTextCheckingTypeSpelling = 1 shl 1;
  NSTextCheckingTypeGrammar = 1 shl 2;
  NSTextCheckingTypeDate = 1 shl 3;
  NSTextCheckingTypeAddress = 1 shl 4;
  NSTextCheckingTypeLink = 1 shl 5;
  NSTextCheckingTypeQuote = 1 shl 6;
  NSTextCheckingTypeDash = 1 shl 7;
  NSTextCheckingTypeReplacement = 1 shl 8;
  NSTextCheckingTypeCorrection = 1 shl 9;
  NSTextCheckingTypeRegularExpression = 1 shl 10;
  NSTextCheckingTypePhoneNumber = 1 shl 11;
  NSTextCheckingTypeTransitInformation = 1 shl 12;
  NSTextCheckingAllSystemTypes = 4294967295;
  NSTextCheckingAllCustomTypes = 4294967295 shl 32;
  NSTextCheckingAllTypes = (NSTextCheckingAllSystemTypes or NSTextCheckingAllCustomTypes);
  NSRegularExpressionCaseInsensitive = 1 shl 0;
  NSRegularExpressionAllowCommentsAndWhitespace = 1 shl 1;
  NSRegularExpressionIgnoreMetacharacters = 1 shl 2;
  NSRegularExpressionDotMatchesLineSeparators = 1 shl 3;
  NSRegularExpressionAnchorsMatchLines = 1 shl 4;
  NSRegularExpressionUseUnixLineSeparators = 1 shl 5;
  NSRegularExpressionUseUnicodeWordBoundaries = 1 shl 6;
  NSMatchingReportProgress = 1 shl 0;
  NSMatchingReportCompletion = 1 shl 1;
  NSMatchingAnchored = 1 shl 2;
  NSMatchingWithTransparentBounds = 1 shl 3;
  NSMatchingWithoutAnchoringBounds = 1 shl 4;
  NSMatchingProgress = 1 shl 0;
  NSMatchingCompleted = 1 shl 1;
  NSMatchingHitEnd = 1 shl 2;
  NSMatchingRequiredEnd = 1 shl 3;
  NSMatchingInternalError = 1 shl 4;
  NSStreamStatusNotOpen = 0;
  NSStreamStatusOpening = 1;
  NSStreamStatusOpen = 2;
  NSStreamStatusReading = 3;
  NSStreamStatusWriting = 4;
  NSStreamStatusAtEnd = 5;
  NSStreamStatusClosed = 6;
  NSStreamStatusError = 7;
  NSStreamEventNone = 0;
  NSStreamEventOpenCompleted = 1 shl 0;
  NSStreamEventHasBytesAvailable = 1 shl 1;
  NSStreamEventHasSpaceAvailable = 1 shl 2;
  NSStreamEventErrorOccurred = 1 shl 3;
  NSStreamEventEndEncountered = 1 shl 4;
  NSTimeZoneNameStyleStandard = 0;
  NSTimeZoneNameStyleShortStandard = 1;
  NSTimeZoneNameStyleDaylightSaving = 2;
  NSTimeZoneNameStyleShortDaylightSaving = 3;
  NSTimeZoneNameStyleGeneric = 4;
  NSTimeZoneNameStyleShortGeneric = 5;
  NSURLHandleNotLoaded = 0;
  NSURLHandleLoadSucceeded = 1;
  NSURLHandleLoadInProgress = 2;
  NSURLHandleLoadFailed = 3;
  NSURLBookmarkCreationPreferFileIDResolution = (1 shl 8);
  NSURLBookmarkCreationMinimalBookmark = (1 shl 9);
  NSURLBookmarkCreationSuitableForBookmarkFile = (1 shl 10);
  NSURLBookmarkCreationWithSecurityScope = (1 shl 11);
  NSURLBookmarkCreationSecurityScopeAllowOnlyReadAccess = (1 shl 12);
  NSURLBookmarkResolutionWithoutUI = (1 shl 8);
  NSURLBookmarkResolutionWithoutMounting = (1 shl 9);
  NSURLBookmarkResolutionWithSecurityScope = (1 shl 10);
  NSURLCacheStorageAllowed = 0;
  NSURLCacheStorageAllowedInMemoryOnly = 1;
  NSURLCacheStorageNotAllowed = 2;
  NSURLCredentialPersistenceNone = 0;
  NSURLCredentialPersistenceForSession = 1;
  NSURLCredentialPersistencePermanent = 2;
  NSURLCredentialPersistenceSynchronizable = 3;
  NSURLErrorCancelledReasonUserForceQuitApplication = 0;
  NSURLErrorCancelledReasonBackgroundUpdatesDisabled = 1;
  NSURLErrorCancelledReasonInsufficientSystemResources = 2;
  NSURLErrorUnknown = -1;
  NSURLErrorCancelled = -999;
  NSURLErrorBadURL = -1000;
  NSURLErrorTimedOut = -1001;
  NSURLErrorUnsupportedURL = -1002;
  NSURLErrorCannotFindHost = -1003;
  NSURLErrorCannotConnectToHost = -1004;
  NSURLErrorNetworkConnectionLost = -1005;
  NSURLErrorDNSLookupFailed = -1006;
  NSURLErrorHTTPTooManyRedirects = -1007;
  NSURLErrorResourceUnavailable = -1008;
  NSURLErrorNotConnectedToInternet = -1009;
  NSURLErrorRedirectToNonExistentLocation = -1010;
  NSURLErrorBadServerResponse = -1011;
  NSURLErrorUserCancelledAuthentication = -1012;
  NSURLErrorUserAuthenticationRequired = -1013;
  NSURLErrorZeroByteResource = -1014;
  NSURLErrorCannotDecodeRawData = -1015;
  NSURLErrorCannotDecodeContentData = -1016;
  NSURLErrorCannotParseResponse = -1017;
  NSURLErrorFileDoesNotExist = -1100;
  NSURLErrorFileIsDirectory = -1101;
  NSURLErrorNoPermissionsToReadFile = -1102;
  NSURLErrorDataLengthExceedsMaximum = -1103;
  NSURLErrorSecureConnectionFailed = -1200;
  NSURLErrorServerCertificateHasBadDate = -1201;
  NSURLErrorServerCertificateUntrusted = -1202;
  NSURLErrorServerCertificateHasUnknownRoot = -1203;
  NSURLErrorServerCertificateNotYetValid = -1204;
  NSURLErrorClientCertificateRejected = -1205;
  NSURLErrorClientCertificateRequired = -1206;
  NSURLErrorCannotLoadFromNetwork = -2000;
  NSURLErrorCannotCreateFile = -3000;
  NSURLErrorCannotOpenFile = -3001;
  NSURLErrorCannotCloseFile = -3002;
  NSURLErrorCannotWriteToFile = -3003;
  NSURLErrorCannotRemoveFile = -3004;
  NSURLErrorCannotMoveFile = -3005;
  NSURLErrorDownloadDecodingFailedMidStream = -3006;
  NSURLErrorDownloadDecodingFailedToComplete = -3007;
  NSURLErrorInternationalRoamingOff = -1018;
  NSURLErrorCallIsActive = -1019;
  NSURLErrorDataNotAllowed = -1020;
  NSURLErrorRequestBodyStreamExhausted = -1021;
  NSURLErrorBackgroundSessionRequiresSharedContainer = -995;
  NSURLErrorBackgroundSessionInUseByAnotherProcess = -996;
  NSURLErrorBackgroundSessionWasDisconnected = -997;
  NSURLRequestUseProtocolCachePolicy = 0;
  NSURLRequestReloadIgnoringLocalCacheData = 1;
  NSURLRequestReloadIgnoringLocalAndRemoteCacheData = 4;
  NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData;
  NSURLRequestReturnCacheDataElseLoad = 2;
  NSURLRequestReturnCacheDataDontLoad = 3;
  NSURLRequestReloadRevalidatingCacheData = 5;
  NSURLNetworkServiceTypeDefault = 0;
  NSURLNetworkServiceTypeVoIP = 1;
  NSURLNetworkServiceTypeVideo = 2;
  NSURLNetworkServiceTypeBackground = 3;
  NSURLNetworkServiceTypeVoice = 4;
  NSXMLParserResolveExternalEntitiesNever = 0;
  NSXMLParserResolveExternalEntitiesNoNetwork = 1;
  NSXMLParserResolveExternalEntitiesSameOriginOnly = 2;
  NSXMLParserResolveExternalEntitiesAlways = 3;
  NSXMLParserInternalError = 1;
  NSXMLParserOutOfMemoryError = 2;
  NSXMLParserDocumentStartError = 3;
  NSXMLParserEmptyDocumentError = 4;
  NSXMLParserPrematureDocumentEndError = 5;
  NSXMLParserInvalidHexCharacterRefError = 6;
  NSXMLParserInvalidDecimalCharacterRefError = 7;
  NSXMLParserInvalidCharacterRefError = 8;
  NSXMLParserInvalidCharacterError = 9;
  NSXMLParserCharacterRefAtEOFError = 10;
  NSXMLParserCharacterRefInPrologError = 11;
  NSXMLParserCharacterRefInEpilogError = 12;
  NSXMLParserCharacterRefInDTDError = 13;
  NSXMLParserEntityRefAtEOFError = 14;
  NSXMLParserEntityRefInPrologError = 15;
  NSXMLParserEntityRefInEpilogError = 16;
  NSXMLParserEntityRefInDTDError = 17;
  NSXMLParserParsedEntityRefAtEOFError = 18;
  NSXMLParserParsedEntityRefInPrologError = 19;
  NSXMLParserParsedEntityRefInEpilogError = 20;
  NSXMLParserParsedEntityRefInInternalSubsetError = 21;
  NSXMLParserEntityReferenceWithoutNameError = 22;
  NSXMLParserEntityReferenceMissingSemiError = 23;
  NSXMLParserParsedEntityRefNoNameError = 24;
  NSXMLParserParsedEntityRefMissingSemiError = 25;
  NSXMLParserUndeclaredEntityError = 26;
  NSXMLParserUnparsedEntityError = 28;
  NSXMLParserEntityIsExternalError = 29;
  NSXMLParserEntityIsParameterError = 30;
  NSXMLParserUnknownEncodingError = 31;
  NSXMLParserEncodingNotSupportedError = 32;
  NSXMLParserStringNotStartedError = 33;
  NSXMLParserStringNotClosedError = 34;
  NSXMLParserNamespaceDeclarationError = 35;
  NSXMLParserEntityNotStartedError = 36;
  NSXMLParserEntityNotFinishedError = 37;
  NSXMLParserLessThanSymbolInAttributeError = 38;
  NSXMLParserAttributeNotStartedError = 39;
  NSXMLParserAttributeNotFinishedError = 40;
  NSXMLParserAttributeHasNoValueError = 41;
  NSXMLParserAttributeRedefinedError = 42;
  NSXMLParserLiteralNotStartedError = 43;
  NSXMLParserLiteralNotFinishedError = 44;
  NSXMLParserCommentNotFinishedError = 45;
  NSXMLParserProcessingInstructionNotStartedError = 46;
  NSXMLParserProcessingInstructionNotFinishedError = 47;
  NSXMLParserNotationNotStartedError = 48;
  NSXMLParserNotationNotFinishedError = 49;
  NSXMLParserAttributeListNotStartedError = 50;
  NSXMLParserAttributeListNotFinishedError = 51;
  NSXMLParserMixedContentDeclNotStartedError = 52;
  NSXMLParserMixedContentDeclNotFinishedError = 53;
  NSXMLParserElementContentDeclNotStartedError = 54;
  NSXMLParserElementContentDeclNotFinishedError = 55;
  NSXMLParserXMLDeclNotStartedError = 56;
  NSXMLParserXMLDeclNotFinishedError = 57;
  NSXMLParserConditionalSectionNotStartedError = 58;
  NSXMLParserConditionalSectionNotFinishedError = 59;
  NSXMLParserExternalSubsetNotFinishedError = 60;
  NSXMLParserDOCTYPEDeclNotFinishedError = 61;
  NSXMLParserMisplacedCDATAEndStringError = 62;
  NSXMLParserCDATANotFinishedError = 63;
  NSXMLParserMisplacedXMLDeclarationError = 64;
  NSXMLParserSpaceRequiredError = 65;
  NSXMLParserSeparatorRequiredError = 66;
  NSXMLParserNMTOKENRequiredError = 67;
  NSXMLParserNAMERequiredError = 68;
  NSXMLParserPCDATARequiredError = 69;
  NSXMLParserURIRequiredError = 70;
  NSXMLParserPublicIdentifierRequiredError = 71;
  NSXMLParserLTRequiredError = 72;
  NSXMLParserGTRequiredError = 73;
  NSXMLParserLTSlashRequiredError = 74;
  NSXMLParserEqualExpectedError = 75;
  NSXMLParserTagNameMismatchError = 76;
  NSXMLParserUnfinishedTagError = 77;
  NSXMLParserStandaloneValueError = 78;
  NSXMLParserInvalidEncodingNameError = 79;
  NSXMLParserCommentContainsDoubleHyphenError = 80;
  NSXMLParserInvalidEncodingError = 81;
  NSXMLParserExternalStandaloneEntityError = 82;
  NSXMLParserInvalidConditionalSectionError = 83;
  NSXMLParserEntityValueRequiredError = 84;
  NSXMLParserNotWellBalancedError = 85;
  NSXMLParserExtraContentError = 86;
  NSXMLParserInvalidCharacterInEntityError = 87;
  NSXMLParserParsedEntityRefInInternalError = 88;
  NSXMLParserEntityRefLoopError = 89;
  NSXMLParserEntityBoundaryError = 90;
  NSXMLParserInvalidURIError = 91;
  NSXMLParserURIFragmentError = 92;
  NSXMLParserNoDTDError = 94;
  NSXMLParserDelegateAbortedParseError = 512;
  NSFileNoSuchFileError = 4;
  NSFileLockingError = 255;
  NSFileReadUnknownError = 256;
  NSFileReadNoPermissionError = 257;
  NSFileReadInvalidFileNameError = 258;
  NSFileReadCorruptFileError = 259;
  NSFileReadNoSuchFileError = 260;
  NSFileReadInapplicableStringEncodingError = 261;
  NSFileReadUnsupportedSchemeError = 262;
  NSFileReadTooLargeError = 263;
  NSFileReadUnknownStringEncodingError = 264;
  NSFileWriteUnknownError = 512;
  NSFileWriteNoPermissionError = 513;
  NSFileWriteInvalidFileNameError = 514;
  NSFileWriteFileExistsError = 516;
  NSFileWriteInapplicableStringEncodingError = 517;
  NSFileWriteUnsupportedSchemeError = 518;
  NSFileWriteOutOfSpaceError = 640;
  NSFileWriteVolumeReadOnlyError = 642;
  NSKeyValueValidationError = 1024;
  NSFormattingError = 2048;
  NSUserCancelledError = 3072;
  NSFeatureUnsupportedError = 3328;
  NSExecutableNotLoadableError = 3584;
  NSExecutableArchitectureMismatchError = 3585;
  NSExecutableRuntimeMismatchError = 3586;
  NSExecutableLoadError = 3587;
  NSExecutableLinkError = 3588;
  NSFileErrorMinimum = 0;
  NSFileErrorMaximum = 1023;
  NSValidationErrorMinimum = 1024;
  NSValidationErrorMaximum = 2047;
  NSExecutableErrorMinimum = 3584;
  NSExecutableErrorMaximum = 3839;
  NSFormattingErrorMinimum = 2048;
  NSFormattingErrorMaximum = 2559;
  NSPropertyListReadCorruptError = 3840;
  NSPropertyListReadUnknownVersionError = 3841;
  NSPropertyListReadStreamError = 3842;
  NSPropertyListWriteStreamError = 3851;
  NSPropertyListWriteInvalidError = 3852;
  NSPropertyListErrorMinimum = 3840;
  NSPropertyListErrorMaximum = 4095;
  NSXPCConnectionInterrupted = 4097;
  NSXPCConnectionInvalid = 4099;
  NSXPCConnectionReplyInvalid = 4101;
  NSXPCConnectionErrorMinimum = 4096;
  NSXPCConnectionErrorMaximum = 4224;
  NSUbiquitousFileUnavailableError = 4353;
  NSUbiquitousFileNotUploadedDueToQuotaError = 4354;
  NSUbiquitousFileUbiquityServerNotAvailable = 4355;
  NSUbiquitousFileErrorMinimum = 4352;
  NSUbiquitousFileErrorMaximum = 4607;
  NSUserActivityHandoffFailedError = 4608;
  NSUserActivityConnectionUnavailableError = 4609;
  NSUserActivityRemoteApplicationTimedOutError = 4610;
  NSUserActivityHandoffUserInfoTooLargeError = 4611;
  NSUserActivityErrorMinimum = 4608;
  NSUserActivityErrorMaximum = 4863;
  NSAttributedStringEnumerationReverse = (1 shl 1);
  NSAttributedStringEnumerationLongestEffectiveRangeNotRequired = (1 shl 20);
  NSByteCountFormatterUseDefault = 0;
  NSByteCountFormatterUseBytes = 1 shl 0;
  NSByteCountFormatterUseKB = 1 shl 1;
  NSByteCountFormatterUseMB = 1 shl 2;
  NSByteCountFormatterUseGB = 1 shl 3;
  NSByteCountFormatterUseTB = 1 shl 4;
  NSByteCountFormatterUsePB = 1 shl 5;
  NSByteCountFormatterUseEB = 1 shl 6;
  NSByteCountFormatterUseZB = 1 shl 7;
  NSByteCountFormatterUseYBOrHigher = 255 shl 8;
  NSByteCountFormatterUseAll = 65535;
  NSByteCountFormatterCountStyleFile = 0;
  NSByteCountFormatterCountStyleMemory = 1;
  NSByteCountFormatterCountStyleDecimal = 2;
  NSByteCountFormatterCountStyleBinary = 3;
  NSCaseInsensitivePredicateOption = 1;
  NSDiacriticInsensitivePredicateOption = 2;
  NSNormalizedPredicateOption = 4;
  NSDirectPredicateModifier = 0;
  NSAllPredicateModifier = 1;
  NSAnyPredicateModifier = 2;
  NSLessThanPredicateOperatorType = 0;
  NSLessThanOrEqualToPredicateOperatorType = 1;
  NSGreaterThanPredicateOperatorType = 2;
  NSGreaterThanOrEqualToPredicateOperatorType = 3;
  NSEqualToPredicateOperatorType = 4;
  NSNotEqualToPredicateOperatorType = 5;
  NSMatchesPredicateOperatorType = 6;
  NSLikePredicateOperatorType = 7;
  NSBeginsWithPredicateOperatorType = 8;
  NSEndsWithPredicateOperatorType = 9;
  NSInPredicateOperatorType = 10;
  NSCustomSelectorPredicateOperatorType = 11;
  NSContainsPredicateOperatorType = 99;
  NSBetweenPredicateOperatorType = 100;
  NSNotPredicateType = 0;
  NSAndPredicateType = 1;
  NSOrPredicateType = 2;
  NSDateComponentsFormatterUnitsStylePositional = 0;
  NSDateComponentsFormatterUnitsStyleAbbreviated = 1;
  NSDateComponentsFormatterUnitsStyleShort = 2;
  NSDateComponentsFormatterUnitsStyleFull = 3;
  NSDateComponentsFormatterUnitsStyleSpellOut = 4;
  NSDateComponentsFormatterZeroFormattingBehaviorNone = (0);
  NSDateComponentsFormatterZeroFormattingBehaviorDefault = (1 shl 0);
  NSDateComponentsFormatterZeroFormattingBehaviorDropLeading = (1 shl 1);
  NSDateComponentsFormatterZeroFormattingBehaviorDropMiddle = (1 shl 2);
  NSDateComponentsFormatterZeroFormattingBehaviorDropTrailing = (1 shl 3);
  NSDateComponentsFormatterZeroFormattingBehaviorDropAll =
    (NSDateComponentsFormatterZeroFormattingBehaviorDropLeading or
    NSDateComponentsFormatterZeroFormattingBehaviorDropMiddle or
    NSDateComponentsFormatterZeroFormattingBehaviorDropTrailing);
  NSDateComponentsFormatterZeroFormattingBehaviorPad = (1 shl 16);
  NSConstantValueExpressionType = 0;
  NSEvaluatedObjectExpressionType = 1;
  NSVariableExpressionType = 2;
  NSKeyPathExpressionType = 3;
  NSFunctionExpressionType = 4;
  NSUnionSetExpressionType = 5;
  NSIntersectSetExpressionType = 6;
  NSMinusSetExpressionType = 7;
  NSSubqueryExpressionType = 13;
  NSAggregateExpressionType = 14;
  NSAnyKeyExpressionType = 15;
  NSBlockExpressionType = 19;
  NSItemProviderUnknownError = -1;
  NSItemProviderItemUnavailableError = -1000;
  NSItemProviderUnexpectedValueClassError = -1100;
  NSFileCoordinatorReadingWithoutChanges = 1 shl 0;
  NSFileCoordinatorReadingResolvesSymbolicLink = 1 shl 1;
  NSFileCoordinatorReadingImmediatelyAvailableMetadataOnly = 1 shl 2;
  NSFileCoordinatorReadingForUploading = 1 shl 3;
  NSFileCoordinatorWritingForDeleting = 1 shl 0;
  NSFileCoordinatorWritingForMoving = 1 shl 1;
  NSFileCoordinatorWritingForMerging = 1 shl 2;
  NSFileCoordinatorWritingForReplacing = 1 shl 3;
  NSFileCoordinatorWritingContentIndependentMetadataOnly = 1 shl 4;
  NSFileVersionAddingByMoving = 1 shl 0;
  NSFileVersionReplacingByMoving = 1 shl 0;
  NSFileWrapperReadingImmediate = 1 shl 0;
  NSFileWrapperReadingWithoutMapping = 1 shl 1;
  NSFileWrapperWritingAtomic = 1 shl 0;
  NSFileWrapperWritingWithNameUpdating = 1 shl 1;
  NSLinguisticTaggerOmitWords = 1 shl 0;
  NSLinguisticTaggerOmitPunctuation = 1 shl 1;
  NSLinguisticTaggerOmitWhitespace = 1 shl 2;
  NSLinguisticTaggerOmitOther = 1 shl 3;
  NSLinguisticTaggerJoinNames = 1 shl 4;
  NSNetServicesUnknownError = -72000;
  NSNetServicesCollisionError = -72001;
  NSNetServicesNotFoundError = -72002;
  NSNetServicesActivityInProgress = -72003;
  NSNetServicesBadArgumentError = -72004;
  NSNetServicesCancelledError = -72005;
  NSNetServicesInvalidError = -72006;
  NSNetServicesTimeoutError = -72007;
  NSNetServiceNoAutoRename = 1 shl 0;
  NSNetServiceListenForConnections = 1 shl 1;
  NSUbiquitousKeyValueStoreServerChange = 0;
  NSUbiquitousKeyValueStoreInitialSyncChange = 1;
  NSUbiquitousKeyValueStoreQuotaViolationChange = 2;
  NSUbiquitousKeyValueStoreAccountChange = 3;
  NSUndoCloseGroupingRunLoopOrdering = 350000;
  NSURLSessionTaskStateRunning = 0;
  NSURLSessionTaskStateSuspended = 1;
  NSURLSessionTaskStateCanceling = 2;
  NSURLSessionTaskStateCompleted = 3;
  NSURLSessionAuthChallengeUseCredential = 0;
  NSURLSessionAuthChallengePerformDefaultHandling = 1;
  NSURLSessionAuthChallengeCancelAuthenticationChallenge = 2;
  NSURLSessionAuthChallengeRejectProtectionSpace = 3;
  NSURLSessionResponseCancel = 0;
  NSURLSessionResponseAllow = 1;
  NSURLSessionResponseBecomeDownload = 2;
  NSBackgroundActivityResultFinished = 1;
  NSBackgroundActivityResultDeferred = 2;
  NSNotificationSuspensionBehaviorDrop = 1;
  NSNotificationSuspensionBehaviorCoalesce = 2;
  NSNotificationSuspensionBehaviorHold = 3;
  NSNotificationSuspensionBehaviorDeliverImmediately = 4;
  NSNotificationDeliverImmediately = (1 shl 0);
  NSNotificationPostToAllSessions = (1 shl 1);
  NSTaskTerminationReasonExit = 1;
  NSTaskTerminationReasonUncaughtSignal = 2;
  NSXMLNodeOptionsNone = 0;
  NSXMLNodeIsCDATA = 1 shl 0;
  NSXMLNodeExpandEmptyElement = 1 shl 1;
  NSXMLNodeCompactEmptyElement = 1 shl 2;
  NSXMLNodeUseSingleQuotes = 1 shl 3;
  NSXMLNodeUseDoubleQuotes = 1 shl 4;
  NSXMLNodeNeverEscapeContents = 1 shl 5;
  NSXMLDocumentTidyHTML = 1 shl 9;
  NSXMLDocumentTidyXML = 1 shl 10;
  NSXMLDocumentValidate = 1 shl 13;
  NSXMLNodeLoadExternalEntitiesAlways = 1 shl 14;
  NSXMLNodeLoadExternalEntitiesSameOriginOnly = 1 shl 15;
  NSXMLNodeLoadExternalEntitiesNever = 1 shl 19;
  NSXMLDocumentXInclude = 1 shl 16;
  NSXMLNodePrettyPrint = 1 shl 17;
  NSXMLDocumentIncludeContentTypeDeclaration = 1 shl 18;
  NSXMLNodePreserveNamespaceOrder = 1 shl 20;
  NSXMLNodePreserveAttributeOrder = 1 shl 21;
  NSXMLNodePreserveEntities = 1 shl 22;
  NSXMLNodePreservePrefixes = 1 shl 23;
  NSXMLNodePreserveCDATA = 1 shl 24;
  NSXMLNodePreserveWhitespace = 1 shl 25;
  NSXMLNodePreserveDTD = 1 shl 26;
  NSXMLNodePreserveCharacterReferences = 1 shl 27;
  NSXMLNodePromoteSignificantWhitespace = 1 shl 28;
  NSXMLNodePreserveEmptyElements = (NSXMLNodeExpandEmptyElement or NSXMLNodeCompactEmptyElement);
  NSXMLNodePreserveQuotes = (NSXMLNodeUseSingleQuotes or NSXMLNodeUseDoubleQuotes);
  NSXMLNodePreserveAll = (NSXMLNodePreserveNamespaceOrder or NSXMLNodePreserveAttributeOrder or
    NSXMLNodePreserveEntities or NSXMLNodePreservePrefixes or NSXMLNodePreserveCDATA or
    NSXMLNodePreserveEmptyElements or NSXMLNodePreserveQuotes or NSXMLNodePreserveWhitespace or NSXMLNodePreserveDTD or
    NSXMLNodePreserveCharacterReferences or 4293918720);
  NSXMLInvalidKind = 0;
  NSXMLDocumentKind = 1;
  NSXMLElementKind = 2;
  NSXMLAttributeKind = 3;
  NSXMLNamespaceKind = 4;
  NSXMLProcessingInstructionKind = 5;
  NSXMLCommentKind = 6;
  NSXMLTextKind = 7;
  NSXMLDTDKind = 8;
  NSXMLEntityDeclarationKind = 9;
  NSXMLAttributeDeclarationKind = 10;
  NSXMLElementDeclarationKind = 11;
  NSXMLNotationDeclarationKind = 12;
  NSXMLEntityGeneralKind = 1;
  NSXMLEntityParsedKind = 2;
  NSXMLEntityUnparsedKind = 3;
  NSXMLEntityParameterKind = 4;
  NSXMLEntityPredefined = 5;
  NSXMLAttributeCDATAKind = 6;
  NSXMLAttributeIDKind = 7;
  NSXMLAttributeIDRefKind = 8;
  NSXMLAttributeIDRefsKind = 9;
  NSXMLAttributeEntityKind = 10;
  NSXMLAttributeEntitiesKind = 11;
  NSXMLAttributeNMTokenKind = 12;
  NSXMLAttributeNMTokensKind = 13;
  NSXMLAttributeEnumerationKind = 14;
  NSXMLAttributeNotationKind = 15;
  NSXMLElementDeclarationUndefinedKind = 16;
  NSXMLElementDeclarationEmptyKind = 17;
  NSXMLElementDeclarationAnyKind = 18;
  NSXMLElementDeclarationMixedKind = 19;
  NSXMLElementDeclarationElementKind = 20;
  NSXMLDocumentXMLKind = 0;
  NSXMLDocumentXHTMLKind = 1;
  NSXMLDocumentHTMLKind = 2;
  NSXMLDocumentTextKind = 3;
  NSNoScriptError = 0;
  NSReceiverEvaluationScriptError = 1;
  NSKeySpecifierEvaluationScriptError = 2;
  NSArgumentEvaluationScriptError = 3;
  NSReceiversCantHandleCommandScriptError = 4;
  NSRequiredArgumentsMissingScriptError = 5;
  NSArgumentsWrongScriptError = 6;
  NSUnknownKeyScriptError = 7;
  NSInternalScriptError = 8;
  NSOperationNotSupportedForKeyScriptError = 9;
  NSCannotCreateScriptCommandError = 10;
  NSNoSpecifierError = 0;
  NSNoTopLevelContainersSpecifierError = 1;
  NSContainerSpecifierError = 2;
  NSUnknownKeySpecifierError = 3;
  NSInvalidIndexSpecifierError = 4;
  NSInternalSpecifierError = 5;
  NSOperationNotSupportedForKeySpecifierError = 6;
  NSPositionAfter = 0;
  NSPositionBefore = 1;
  NSPositionBeginning = 2;
  NSPositionEnd = 3;
  NSPositionReplace = 4;
  NSRelativeAfter = 0;
  NSRelativeBefore = 1;
  NSIndexSubelement = 0;
  NSEverySubelement = 1;
  NSMiddleSubelement = 2;
  NSRandomSubelement = 3;
  NSNoSubelement = 4;
  NSSaveOptionsYes = 0;
  NSSaveOptionsNo = 1;
  NSSaveOptionsAsk = 2;
  NSEqualToComparison = 0;
  NSLessThanOrEqualToComparison = 1;
  NSLessThanComparison = 2;
  NSGreaterThanOrEqualToComparison = 3;
  NSGreaterThanComparison = 4;
  NSBeginsWithComparison = 5;
  NSEndsWithComparison = 6;
  NSContainsComparison = 7;
  NSUserNotificationActivationTypeNone = 0;
  NSUserNotificationActivationTypeContentsClicked = 1;
  NSUserNotificationActivationTypeActionButtonClicked = 2;
  NSUserNotificationActivationTypeReplied = 3;
  NSUserNotificationActivationTypeAdditionalActionClicked = 4;
  NSXPCConnectionPrivileged = (1 shl 12);
  NSDecimalMaxSize = 8;
  NSDecimalNoScale = 32767;
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
  NSINTEGER_DEFINED = 1;
  NSIntegerMax = High(NSInteger);
  NSIntegerMin = Low(NSInteger);
  NSObjectAutoreleasedEvent = 3;
  NSObjectExtraRefDecrementedEvent = 5;
  NSObjectExtraRefIncrementedEvent = 4;
  NSObjectInternalRefDecrementedEvent = 7;
  NSObjectInternalRefIncrementedEvent = 6;
  NSUIntegerMax = High(NSUInteger);
  NS_BLOCKS_AVAILABLE = 1;
  NS_UNICHAR_IS_EIGHT_BIT = 0;

type
{$M+}
// ===== Forward declarations =====
  NSObject = interface;
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
  NSUserNotification  = interface;
  NSUserNotificationCenter = interface;
  NSUserNotificationCenterDelegate = interface;
  NSURLSession = interface;
  NSURLSessionDataTask = interface;
  NSURLSessionUploadTask = interface;
  NSURLSessionDownloadTask = interface;
  NSURLSessionConfiguration = interface;
  NSURLSessionDelegate = interface;
  NSURLSessionTask = interface;
  NSURLSessionTaskDelegate = interface;
  NSURLSessionDataDelegate = interface;
  NSURLSessionDownloadDelegate = interface;
  NSFileVersion = interface;

// ===== UIKit typedefs and structs =====
  NSUserNotificationActivationType = NSUInteger;
  NSURLSessionAuthChallengeDisposition = NSInteger;
  NSURLSessionResponseDisposition = NSInteger;
  NSURLRequestNetworkServiceType = NSUInteger;
  NSURLSessionTaskState = NSInteger;
  NSStreamEvent = NSUInteger;

  SSLProtocol = Cardinal;
  TFoundationCompletionBlock = procedure of object;
  TFoundationCompletionHandler = procedure(param1: NSURLResponse; param2: NSData; param3: NSError) of object;
  TFoundationCompletionHandler1 = procedure(param1: NSError) of object;
  TFoundationCompletionHandler2 = procedure(param1: NSArray; param2: NSArray; param3: NSArray) of object;
  TFoundationCompletionHandler3 = procedure(param1: NSData; param2: NSURLResponse; param3: NSError) of object;
  TFoundationCompletionHandler5 = procedure(param1: NSData) of object;
  TFoundationCompletionHandler4 = procedure(param1: NSURL; param2: NSURLResponse; param3: NSError) of object;
  TFoundationCompletionHandler6 = procedure(param1: NSURLSessionAuthChallengeDisposition; param2: NSURLCredential) of object;
  TFoundationCompletionHandler7 = procedure(param1: NSURLRequest) of object;
  TFoundationNeedNewBodyStream = procedure(param1: NSInputStream) of object;
  TFoundationCompletionHandler8 = procedure(param1: NSURLSessionResponseDisposition) of object;
  TFoundationCompletionHandler9 = procedure(param1: NSCachedURLResponse) of object;
  TFoundationByAccessor = procedure(param1: NSURL) of object;
  TFoundationByAccessor1 = procedure(param1: NSURL; param2: NSURL) of object;
  TFoundationByAccessor2 = procedure(param1: TFoundationCompletionBlock) of object;

  NSSwappedFloat = record
    v: Cardinal;
  end;
  PNSSwappedFloat = ^NSSwappedFloat;

  NSSwappedDouble = record
    v: UInt64;
  end;
  PNSSwappedDouble = ^NSSwappedDouble;
  NSCalculationError = NSUInteger;
  NSUncaughtExceptionHandler = procedure(param1: NSException) of object;
  TFoundationNSGetUncaughtExceptionHandler = NSUncaughtExceptionHandler;
  NSHashEnumerator = record
    _pi: NSUInteger;
    _si: NSUInteger;
    _bs: Pointer;
  end;
  PNSHashEnumerator = ^NSHashEnumerator;

  TFoundationHash = function(param1: NSHashTable; param2: Pointer): NSUInteger of object;
  TFoundationIsEqual = function(param1: NSHashTable; param2: Pointer; param3: Pointer): Boolean of object;
  TFoundationRetain = procedure(param1: NSHashTable; param2: Pointer) of object;
  TFoundationDescribe = function(param1: NSHashTable; param2: Pointer): NSString of object;

  NSHashTableCallBacks = record
    hash: TFoundationHash;
    isEqual: TFoundationIsEqual;
    retain: TFoundationRetain;
    release: TFoundationRetain;
    describe: TFoundationDescribe;
  end;
  PNSHashTableCallBacks = ^NSHashTableCallBacks;

  NSEdgeInsets = record
    top: CGFloat;
    left: CGFloat;
    bottom: CGFloat;
    right: CGFloat;
  end;
  PNSEdgeInsets = ^NSEdgeInsets;

  NSAlignmentOptions = UInt64;
  NSLocaleLanguageDirection = NSUInteger;
  NSMapTableOptions = NSUInteger;

  NSMapEnumerator = record
    _pi: NSUInteger;
    _si: NSUInteger;
    _bs: Pointer;
  end;
  PNSMapEnumerator = ^NSMapEnumerator;

  TFoundationHash1 = function(param1: NSMapTable; param2: Pointer): NSUInteger of object;
  TFoundationIsEqual1 = function(param1: NSMapTable; param2: Pointer; param3: Pointer): Boolean of object;
  TFoundationRetain1 = procedure(param1: NSMapTable; param2: Pointer) of object;
  TFoundationDescribe1 = function(param1: NSMapTable; param2: Pointer): NSString of object;

  NSMapTableKeyCallBacks = record
    hash: TFoundationHash1;
    isEqual: TFoundationIsEqual1;
    retain: TFoundationRetain1;
    release: TFoundationRetain1;
    describe: TFoundationDescribe1;
    notAKeyMarker: Pointer;
  end;
  PNSMapTableKeyCallBacks = ^NSMapTableKeyCallBacks;

  NSMapTableValueCallBacks = record
    retain: TFoundationRetain1;
    release: TFoundationRetain1;
    describe: TFoundationDescribe1;
  end;
  PNSMapTableValueCallBacks = ^NSMapTableValueCallBacks;

  NSOperatingSystemVersion = record
    majorVersion: NSInteger;
    minorVersion: NSInteger;
    patchVersion: NSInteger;
  end;
  PNSOperatingSystemVersion = ^NSOperatingSystemVersion;

  NSActivityOptions = UInt64;
  NSURLRelationship = NSInteger;
  TFoundationErrorHandler = function(param1: NSURL; param2: NSError): Boolean of object;
  NSItemProviderCompletionHandler = procedure(param1: Pointer; param2: NSError) of object;
  NSItemProviderLoadHandler = procedure(param1: NSItemProviderCompletionHandler; param2: Pointer; param3: NSDictionary)
    of object;
  NSItemProviderErrorCode = NSInteger;
  NSFileCoordinatorReadingOptions = NSUInteger;
  NSFileCoordinatorWritingOptions = NSUInteger;
  TFoundationByAccessor3 = procedure(param1: TFoundationCompletionBlock) of object;
  NSFileVersionAddingOptions = NSUInteger;
  NSFileVersionReplacingOptions = NSUInteger;
  NSFileWrapperReadingOptions = NSUInteger;
  NSFileWrapperWritingOptions = NSUInteger;




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
    ['{5588A9D5-8D4C-4444-A4B9-7C944FC124EB}']
    procedure stream(aStream: NSStream; handleEvent: NSStreamEvent); cdecl;
  end;

  NSURLAuthenticationChallengeSender = interface(IObjectiveC)
    ['{F23F6B54-86CF-430A-8A6B-27157620EA0B}']
    procedure useCredential(credential: NSURLCredential;
      forAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl;
    procedure continueWithoutCredentialForAuthenticationChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
    procedure cancelAuthenticationChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
    procedure performDefaultHandlingForAuthenticationChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
    procedure rejectProtectionSpaceAndContinueWithChallenge(challenge: NSURLAuthenticationChallenge); cdecl;
  end;

  NSURLConnectionDelegate = interface(IObjectiveC)
    ['{467F147F-72A0-4E83-A58C-31011E08E8EA}']
    [MethodName('connection:didFailWithError:')]
    procedure connectionDidFailWithError(connection: NSURLConnection; didFailWithError: NSError); cdecl;
    function connectionShouldUseCredentialStorage(connection: NSURLConnection): Boolean; cdecl;
    [MethodName('connection:willSendRequestForAuthenticationChallenge:')]
    procedure connectionWillSendRequestForAuthenticationChallenge(connection: NSURLConnection;
      willSendRequestForAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl;
    [MethodName('connection:canAuthenticateAgainstProtectionSpace:')]
    function connectionCanAuthenticateAgainstProtectionSpace(connection: NSURLConnection;
      canAuthenticateAgainstProtectionSpace: NSURLProtectionSpace): Boolean; cdecl;
    [MethodName('connection:didReceiveAuthenticationChallenge:')]
    procedure connectionDidReceiveAuthenticationChallenge(connection: NSURLConnection;
      didReceiveAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl;
    [MethodName('connection:didCancelAuthenticationChallenge:')]
    procedure connectionDidCancelAuthenticationChallenge(connection: NSURLConnection;
      didCancelAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl;
  end;

  NSURLConnectionDataDelegate = interface(IObjectiveC)
    ['{24F2FAB4-C858-41CC-84DE-B1044DCEB3EB}']
    [MethodName('connection:willSendRequest:redirectResponse:')]
    function connectionWillSendRequestRedirectResponse(connection: NSURLConnection; willSendRequest: NSURLRequest;
      redirectResponse: NSURLResponse): NSURLRequest; cdecl;
    [MethodName('connection:didReceiveResponse:')]
    procedure connectionDidReceiveResponse(connection: NSURLConnection; didReceiveResponse: NSURLResponse); cdecl;
    [MethodName('connection:didReceiveData:')]
    procedure connectionDidReceiveData(connection: NSURLConnection; didReceiveData: NSData); cdecl;
    [MethodName('connection:needNewBodyStream:')]
    function connectionNeedNewBodyStream(connection: NSURLConnection; needNewBodyStream: NSURLRequest)
      : NSInputStream; cdecl;
    [MethodName('connection:didSendBodyData:totalBytesWritten:totalBytesExpectedToWrite:')]
    procedure connectionDidSendBodyDataTotalBytesWrittenTotalBytesExpectedToWrite(connection: NSURLConnection;
      didSendBodyData: NSInteger; totalBytesWritten: NSInteger; totalBytesExpectedToWrite: NSInteger); cdecl;
    [MethodName('connection:willCacheResponse:')]
    function connectionWillCacheResponse(connection: NSURLConnection; willCacheResponse: NSCachedURLResponse)
      : NSCachedURLResponse; cdecl;
    procedure connectionDidFinishLoading(connection: NSURLConnection); cdecl;
  end;

  NSURLConnectionDownloadDelegate = interface(IObjectiveC)
    ['{2D38BAF6-DE19-46AA-8895-F016F6D542FD}']
    procedure connection(connection: NSURLConnection; didWriteData: Int64; totalBytesWritten: Int64;
      expectedTotalBytes: Int64); cdecl;
    procedure connectionDidResumeDownloading(connection: NSURLConnection; totalBytesWritten: Int64;
      expectedTotalBytes: Int64); cdecl;
    procedure connectionDidFinishDownloading(connection: NSURLConnection; destinationURL: NSURL); cdecl;
  end;

  NSURLProtocolClient = interface(IObjectiveC)
    ['{6FE7D5B3-CD38-46B1-84B3-CA731D03BA19}']
    [MethodName('URLProtocol:wasRedirectedToRequest:redirectResponse:')]
    procedure URLProtocolWasRedirectedToRequestRedirectResponse(protocol: NSURLProtocol;
      wasRedirectedToRequest: NSURLRequest; redirectResponse: NSURLResponse); cdecl;
    [MethodName('URLProtocol:cachedResponseIsValid:')]
    procedure URLProtocolCachedResponseIsValid(protocol: NSURLProtocol;
      cachedResponseIsValid: NSCachedURLResponse); cdecl;
    [MethodName('URLProtocol:didReceiveResponse:cacheStoragePolicy:')]
    procedure URLProtocolDidReceiveResponseCacheStoragePolicy(protocol: NSURLProtocol;
      didReceiveResponse: NSURLResponse; cacheStoragePolicy: NSURLCacheStoragePolicy); cdecl;
    [MethodName('URLProtocol:didLoadData:')]
    procedure URLProtocolDidLoadData(protocol: NSURLProtocol; didLoadData: NSData); cdecl;
    procedure URLProtocolDidFinishLoading(protocol: NSURLProtocol); cdecl;
    [MethodName('URLProtocol:didFailWithError:')]
    procedure URLProtocolDidFailWithError(protocol: NSURLProtocol; didFailWithError: NSError); cdecl;
    [MethodName('URLProtocol:didReceiveAuthenticationChallenge:')]
    procedure URLProtocolDidReceiveAuthenticationChallenge(protocol: NSURLProtocol;
      didReceiveAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl;
    [MethodName('URLProtocol:didCancelAuthenticationChallenge:')]
    procedure URLProtocolDidCancelAuthenticationChallenge(protocol: NSURLProtocol;
      didCancelAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl;
  end;

  NSXMLParserDelegate = interface(IObjectiveC)
    ['{C7F64B8C-2CAC-4426-9FAA-E21C90F1C279}']
    procedure parserDidStartDocument(parser: NSXMLParser); cdecl;
    procedure parserDidEndDocument(parser: NSXMLParser); cdecl;
    [MethodName('parser:foundNotationDeclarationWithName:publicID:systemID:')]
    procedure parserFoundNotationDeclarationWithNamePublicIDSystemID(parser: NSXMLParser;
      foundNotationDeclarationWithName: NSString; publicID: NSString; systemID: NSString); cdecl;
    [MethodName('parser:foundUnparsedEntityDeclarationWithName:publicID:systemID:notationName:')]
    procedure parserFoundUnparsedEntityDeclarationWithNamePublicIDSystemIDNotationName(parser: NSXMLParser;
      foundUnparsedEntityDeclarationWithName: NSString; publicID: NSString; systemID: NSString;
      notationName: NSString); cdecl;
    [MethodName('parser:foundAttributeDeclarationWithName:forElement:type:defaultValue:')]
    procedure parserFoundAttributeDeclarationWithNameForElementTypeDefaultValue(parser: NSXMLParser;
      foundAttributeDeclarationWithName: NSString; forElement: NSString; &type: NSString;
      defaultValue: NSString); cdecl;
    [MethodName('parser:foundElementDeclarationWithName:model:')]
    procedure parserFoundElementDeclarationWithNameModel(parser: NSXMLParser; foundElementDeclarationWithName: NSString;
      model: NSString); cdecl;
    [MethodName('parser:foundInternalEntityDeclarationWithName:value:')]
    procedure parserFoundInternalEntityDeclarationWithNameValue(parser: NSXMLParser;
      foundInternalEntityDeclarationWithName: NSString; value: NSString); cdecl;
    [MethodName('parser:foundExternalEntityDeclarationWithName:publicID:systemID:')]
    procedure parserFoundExternalEntityDeclarationWithNamePublicIDSystemID(parser: NSXMLParser;
      foundExternalEntityDeclarationWithName: NSString; publicID: NSString; systemID: NSString); cdecl;
    [MethodName('parser:didStartElement:namespaceURI:qualifiedName:attributes:')]
    procedure parserDidStartElementNamespaceURIQualifiedNameAttributes(parser: NSXMLParser; didStartElement: NSString;
      namespaceURI: NSString; qualifiedName: NSString; attributes: NSDictionary); cdecl;
    [MethodName('parser:didEndElement:namespaceURI:qualifiedName:')]
    procedure parserDidEndElementNamespaceURIQualifiedName(parser: NSXMLParser; didEndElement: NSString;
      namespaceURI: NSString; qualifiedName: NSString); cdecl;
    [MethodName('parser:didStartMappingPrefix:toURI:')]
    procedure parserDidStartMappingPrefixToURI(parser: NSXMLParser; didStartMappingPrefix: NSString;
      toURI: NSString); cdecl;
    [MethodName('parser:didEndMappingPrefix:')]
    procedure parserDidEndMappingPrefix(parser: NSXMLParser; didEndMappingPrefix: NSString); cdecl;
    [MethodName('parser:foundCharacters:')]
    procedure parserFoundCharacters(parser: NSXMLParser; foundCharacters: NSString); cdecl;
    [MethodName('parser:foundIgnorableWhitespace:')]
    procedure parserFoundIgnorableWhitespace(parser: NSXMLParser; foundIgnorableWhitespace: NSString); cdecl;
    [MethodName('parser:foundProcessingInstructionWithTarget:data:')]
    procedure parserFoundProcessingInstructionWithTargetData(parser: NSXMLParser;
      foundProcessingInstructionWithTarget: NSString; data: NSString); cdecl;
    [MethodName('parser:foundComment:')]
    procedure parserFoundComment(parser: NSXMLParser; foundComment: NSString); cdecl;
    [MethodName('parser:foundCDATA:')]
    procedure parserFoundCDATA(parser: NSXMLParser; foundCDATA: NSData); cdecl;
    [MethodName('parser:resolveExternalEntityName:systemID:')]
    function parserResolveExternalEntityNameSystemID(parser: NSXMLParser; resolveExternalEntityName: NSString;
      systemID: NSString): NSData; cdecl;
    [MethodName('parser:parseErrorOccurred:')]
    procedure parserParseErrorOccurred(parser: NSXMLParser; parseErrorOccurred: NSError); cdecl;
    [MethodName('parser:validationErrorOccurred:')]
    procedure parserValidationErrorOccurred(parser: NSXMLParser; validationErrorOccurred: NSError); cdecl;
  end;

  NSCacheDelegate = interface(IObjectiveC)
    ['{852EF72A-93FD-477A-835E-641B4E995717}']
    procedure cache(cache: NSCache; willEvictObject: Pointer); cdecl;
  end;

  NSURLSessionDelegate = interface(IObjectiveC)
    ['{3637A2FD-1D29-42CE-9924-0DAB04F9F59B}']
    [MethodName('URLSession:didBecomeInvalidWithError:')]
    procedure URLSessionDidBecomeInvalidWithError(session: NSURLSession; didBecomeInvalidWithError: NSError); cdecl;
    [MethodName('URLSession:didReceiveChallenge:completionHandler:')]
    procedure URLSessionDidReceiveChallengeCompletionHandler(session: NSURLSession;
      didReceiveChallenge: NSURLAuthenticationChallenge; completionHandler: TFoundationCompletionHandler6); cdecl;
  end;

  NSURLSessionTaskDelegate = interface(IObjectiveC)
    ['{C48E0AED-64F3-45A4-8D42-E3DB12F668E7}']
    [MethodName('URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler:')]
    procedure URLSessionTaskWillPerformHTTPRedirectionNewRequestCompletionHandler(session: NSURLSession;
      task: NSURLSessionTask; willPerformHTTPRedirection: NSHTTPURLResponse; newRequest: NSURLRequest;
      completionHandler: TFoundationCompletionHandler7); cdecl;
    [MethodName('URLSession:task:didReceiveChallenge:completionHandler:')]
    procedure URLSessionTaskDidReceiveChallengeCompletionHandler(session: NSURLSession; task: NSURLSessionTask;
      didReceiveChallenge: NSURLAuthenticationChallenge; completionHandler: TFoundationCompletionHandler6); cdecl;
    [MethodName('URLSession:task:needNewBodyStream:')]
    procedure URLSessionTaskNeedNewBodyStream(session: NSURLSession; task: NSURLSessionTask;
      needNewBodyStream: TFoundationNeedNewBodyStream); cdecl;
    [MethodName('URLSession:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend:')]
    procedure URLSessionTaskDidSendBodyDataTotalBytesSentTotalBytesExpectedToSend(session: NSURLSession;
      task: NSURLSessionTask; didSendBodyData: Int64; totalBytesSent: Int64; totalBytesExpectedToSend: Int64); cdecl;
    [MethodName('URLSession:task:didCompleteWithError:')]
    procedure URLSessionTaskDidCompleteWithError(session: NSURLSession; task: NSURLSessionTask;
      didCompleteWithError: NSError); cdecl;
  end;

  NSURLSessionDataDelegate = interface(IObjectiveC)
    ['{9B66A569-04EB-4B0C-9043-BCF97E891CBD}']
    [MethodName('URLSession:dataTask:didReceiveResponse:completionHandler:')]
    procedure URLSessionDataTaskDidReceiveResponseCompletionHandler(session: NSURLSession;
      dataTask: NSURLSessionDataTask; didReceiveResponse: NSURLResponse;
      completionHandler: TFoundationCompletionHandler8); cdecl;
    [MethodName('URLSession:dataTask:didBecomeDownloadTask:')]
    procedure URLSessionDataTaskDidBecomeDownloadTask(session: NSURLSession; dataTask: NSURLSessionDataTask;
      didBecomeDownloadTask: NSURLSessionDownloadTask); cdecl;
    [MethodName('URLSession:dataTask:didReceiveData:')]
    procedure URLSessionDataTaskDidReceiveData(session: NSURLSession; dataTask: NSURLSessionDataTask;
      didReceiveData: NSData); cdecl;
    [MethodName('URLSession:dataTask:willCacheResponse:completionHandler:')]
    procedure URLSessionDataTaskWillCacheResponseCompletionHandler(session: NSURLSession;
      dataTask: NSURLSessionDataTask; willCacheResponse: NSCachedURLResponse;
      completionHandler: TFoundationCompletionHandler9); cdecl;
  end;

  NSURLSessionDownloadDelegate = interface(IObjectiveC)
    ['{E7E68940-0950-4B8F-A7F0-F2299482ADB0}']
    [MethodName('URLSession:downloadTask:didFinishDownloadingToURL:')]
    procedure URLSessionDownloadTaskDidFinishDownloadingToURL(session: NSURLSession;
      downloadTask: NSURLSessionDownloadTask; didFinishDownloadingToURL: NSURL); cdecl;
    [MethodName('URLSession:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:')]
    procedure URLSessionDownloadTaskDidWriteDataTotalBytesWrittenTotalBytesExpectedToWrite(session: NSURLSession;
      downloadTask: NSURLSessionDownloadTask; didWriteData: Int64; totalBytesWritten: Int64;
      totalBytesExpectedToWrite: Int64); cdecl;
    [MethodName('URLSession:downloadTask:didResumeAtOffset:expectedTotalBytes:')]
    procedure URLSessionDownloadTaskDidResumeAtOffsetExpectedTotalBytes(session: NSURLSession;
      downloadTask: NSURLSessionDownloadTask; didResumeAtOffset: Int64; expectedTotalBytes: Int64); cdecl;
  end;

  NSURLDownloadDelegate = interface(IObjectiveC)
    ['{DAC8D212-E59D-4729-89A4-3584F98A0BB9}']
    procedure downloadDidBegin(download: NSURLDownload); cdecl;
    [MethodName('download:willSendRequest:redirectResponse:')]
    function downloadWillSendRequestRedirectResponse(download: NSURLDownload; willSendRequest: NSURLRequest;
      redirectResponse: NSURLResponse): NSURLRequest; cdecl;
    [MethodName('download:canAuthenticateAgainstProtectionSpace:')]
    function downloadCanAuthenticateAgainstProtectionSpace(connection: NSURLDownload;
      canAuthenticateAgainstProtectionSpace: NSURLProtectionSpace): Boolean; cdecl;
    [MethodName('download:didReceiveAuthenticationChallenge:')]
    procedure downloadDidReceiveAuthenticationChallenge(download: NSURLDownload;
      didReceiveAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl;
    [MethodName('download:didCancelAuthenticationChallenge:')]
    procedure downloadDidCancelAuthenticationChallenge(download: NSURLDownload;
      didCancelAuthenticationChallenge: NSURLAuthenticationChallenge); cdecl;
    function downloadShouldUseCredentialStorage(download: NSURLDownload): Boolean; cdecl;
    [MethodName('download:didReceiveResponse:')]
    procedure downloadDidReceiveResponse(download: NSURLDownload; didReceiveResponse: NSURLResponse); cdecl;
    [MethodName('download:willResumeWithResponse:fromByte:')]
    procedure downloadWillResumeWithResponseFromByte(download: NSURLDownload; willResumeWithResponse: NSURLResponse;
      fromByte: Int64); cdecl;
    [MethodName('download:didReceiveDataOfLength:')]
    procedure downloadDidReceiveDataOfLength(download: NSURLDownload; didReceiveDataOfLength: NSUInteger); cdecl;
    [MethodName('download:shouldDecodeSourceDataOfMIMEType:')]
    function downloadShouldDecodeSourceDataOfMIMEType(download: NSURLDownload;
      shouldDecodeSourceDataOfMIMEType: NSString): Boolean; cdecl;
    [MethodName('download:decideDestinationWithSuggestedFilename:')]
    procedure downloadDecideDestinationWithSuggestedFilename(download: NSURLDownload;
      decideDestinationWithSuggestedFilename: NSString); cdecl;
    [MethodName('download:didCreateDestination:')]
    procedure downloadDidCreateDestination(download: NSURLDownload; didCreateDestination: NSString); cdecl;
    procedure downloadDidFinish(download: NSURLDownload); cdecl;
    [MethodName('download:didFailWithError:')]
    procedure downloadDidFailWithError(download: NSURLDownload; didFailWithError: NSError); cdecl;
  end;

  NSFilePresenter = interface(IObjectiveC)
    ['{3AF4B29F-A73C-443A-AB4A-1E8490AF97C7}']
    function presentedItemURL: NSURL; cdecl;
    function presentedItemOperationQueue: NSOperationQueue; cdecl;
    function primaryPresentedItemURL: NSURL; cdecl;
    procedure relinquishPresentedItemToReader(reader: TFoundationByAccessor3); cdecl;
    procedure relinquishPresentedItemToWriter(writer: TFoundationByAccessor3); cdecl;
    procedure savePresentedItemChangesWithCompletionHandler(completionHandler: TFoundationByAccessor); cdecl;
    procedure accommodatePresentedItemDeletionWithCompletionHandler(completionHandler: TFoundationByAccessor); cdecl;
    procedure presentedItemDidMoveToURL(newURL: NSURL); cdecl;
    procedure presentedItemDidChange; cdecl;
    procedure presentedItemDidGainVersion(version: NSFileVersion); cdecl;
    procedure presentedItemDidLoseVersion(version: NSFileVersion); cdecl;
    procedure presentedItemDidResolveConflictVersion(version: NSFileVersion); cdecl;
    procedure accommodatePresentedSubitemDeletionAtURL(url: NSURL; completionHandler: TFoundationByAccessor); cdecl;
    procedure presentedSubitemDidAppearAtURL(url: NSURL); cdecl;
    [MethodName('presentedSubitemAtURL:didMoveToURL:')]
    procedure presentedSubitemAtURLDidMoveToURL(oldURL: NSURL; didMoveToURL: NSURL); cdecl;
    procedure presentedSubitemDidChangeAtURL(url: NSURL); cdecl;
    [MethodName('presentedSubitemAtURL:didGainVersion:')]
    procedure presentedSubitemAtURLDidGainVersion(url: NSURL; didGainVersion: NSFileVersion); cdecl;
    [MethodName('presentedSubitemAtURL:didLoseVersion:')]
    procedure presentedSubitemAtURLDidLoseVersion(url: NSURL; didLoseVersion: NSFileVersion); cdecl;
    [MethodName('presentedSubitemAtURL:didResolveConflictVersion:')]
    procedure presentedSubitemAtURLDidResolveConflictVersion(url: NSURL;
      didResolveConflictVersion: NSFileVersion); cdecl;
  end;

// ===== Interface declarations =====

  NSObjectClass = interface(IObjectiveCClass)
    ['{84CDD025-E02A-4128-B1AC-35A7A5A4643B}']
  end;
  NSObject = interface(IObjectiveCInstance)
    ['{C8CC567E-50C3-461C-BAA7-AD96D2CDC5C6}']
    procedure retain; cdecl;
    procedure release; cdecl;
    function retainCount: NSUInteger; cdecl;
    function isKindOfClass(cls: Pointer): Boolean; cdecl;
    function isMemberOfClass(cls: Pointer): Boolean; cdecl;
  end;
  TNSObject = class(TOCGenericImport<NSObjectClass, NSObject>) end;
	
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
    function getBytes(buffer: Pointer; maxLength: NSUInteger; usedLength: PNSUInteger; encoding: NSStringEncoding; options: NSStringEncodingConversionOptions; range: NSRange; remainingRange: PNSRange): Boolean; cdecl;
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
    {class} function localeIdentifierFromWindowsLocaleCode(lcid: UInt32): NSString; cdecl;
    {class} function preferredLanguages: NSArray; cdecl;
    {class} function systemLocale: Pointer; cdecl;
    {class} function windowsLocaleCodeFromLocaleIdentifier(localeIdentifier: NSString): UInt32; cdecl;
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
    {class} function sendSynchronousRequest(request: NSURLRequest; returningResponse: PPointer; error: PPointer): NSData; cdecl;
    {class} procedure sendAsynchronousRequest(request: NSURLRequest; queue: NSOperationQueue;
      completionHandler: TFoundationCompletionHandler); cdecl;
  end;
  NSURLConnection = interface(NSObject)
    ['{BDFFFFF2-60D7-4E17-9E36-418B0D594F99}']
    function originalRequest: NSURLRequest; cdecl;
    function currentRequest: NSURLRequest; cdecl;
    procedure cancel; cdecl;
    function initWithRequest(request: NSURLRequest; delegate: Pointer): Pointer; cdecl; overload;
    function initWithRequest(request: NSURLRequest; delegate: Pointer; startImmediately: Boolean): Pointer; cdecl; overload;
    procedure scheduleInRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure start; cdecl;
    procedure unscheduleFromRunLoop(aRunLoop: NSRunLoop; forMode: NSString); cdecl;
    procedure setDelegateQueue(queue: NSOperationQueue); cdecl;
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
    function indicesOfObjectsByEvaluatingWithContainer(container: Pointer; count: PNSInteger): PNSInteger; cdecl;
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
    function scanDecimal(dcm: PNSDecimal): Boolean; cdecl;
    function scanDouble(value: PDouble): Boolean; cdecl;
    function scanFloat(value: PSingle): Boolean; cdecl;
    function scanHexDouble(result: PDouble): Boolean; cdecl;
    function scanHexFloat(result: PSingle): Boolean; cdecl;
    function scanHexInt(value: PCardinal): Boolean; cdecl;
    function scanHexLongLong(result: PUInt64): Boolean; cdecl;
    function scanInt(value: PInteger): Boolean; cdecl;
    function scanInteger(value: PNSInteger): Boolean; cdecl;
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
    procedure removeObserver(notificationObserver: Pointer; name: Pointer; &object: Pointer); cdecl; overload;
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
    function msgid: UInt32; cdecl;
    function receivePort: NSPort; cdecl;
    function sendBeforeDate(date: NSDate): Boolean; cdecl;
    function sendPort: NSPort; cdecl;
    procedure setMsgid(msgid: UInt32); cdecl;
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
    function decodeBytesForKey(key: NSString; returnedLength: PNSUInteger): PByte; cdecl;
    function decodeBytesWithReturnedLength(lengthp: PNSUInteger): Pointer; cdecl;
    function decodeDataObject: NSData; cdecl;
    function decodeDoubleForKey(key: NSString): double; cdecl;
    function decodeFloatForKey(key: NSString): Single; cdecl;
    function decodeInt32ForKey(key: NSString): Int32; cdecl;
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
    procedure encodeInt32(intv: Int32; forKey: NSString); cdecl;
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
    function systemVersion: Cardinal; cdecl;
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
    function compileAndReturnError(errorInfo: PPointer): Boolean; cdecl;
    function executeAndReturnError(errorInfo: PPointer): NSAppleEventDescriptor; cdecl;
    function executeAppleEvent(event: NSAppleEventDescriptor; error: PPointer): NSAppleEventDescriptor; cdecl;
    function initWithContentsOfURL(url: NSURL; error: PPointer): Pointer; cdecl;
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
    procedure rotateByDegrees(angle: CGFloat); cdecl;
    procedure rotateByRadians(angle: CGFloat); cdecl;
    procedure scaleBy(scale: CGFloat); cdecl;
    procedure scaleXBy(scaleX: CGFloat; yBy: CGFloat); cdecl;
    procedure setTransformStruct(transformStruct: NSAffineTransformStruct); cdecl;
    function transformPoint(aPoint: NSPoint): NSPoint; cdecl;
    function transformSize(aSize: NSSize): NSSize; cdecl;
    function transformStruct: NSAffineTransformStruct; cdecl;
    procedure translateXBy(deltaX: CGFloat; yBy: CGFloat); cdecl;
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
    [MethodName('URLForResource:withExtension:subdirectory:localization:')]
    function URLForResourceWithExtensionSubdirectoryLocalization(name: NSString; withExtension: NSString;
      subdirectory: NSString; localization: NSString): NSURL; cdecl;
    function classNamed(className: NSString): Pointer; cdecl;
    function principalClass: Pointer; cdecl;
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
    function getObjectValue(obj: Pointer; forString: NSString; errorDescription: PPointer): Boolean; cdecl;
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
    [MethodName('getRelationship:ofDirectoryAtURL:toItemAtURL:error:')]
    function getRelationshipOfDirectoryAtURLToItemAtURLError(outRelationship: NSURLRelationship;
      ofDirectoryAtURL: NSURL; toItemAtURL: NSURL; error: NSError): Boolean; cdecl;
    [MethodName('getRelationship:ofDirectory:inDomain:toItemAtURL:error:')]
    function getRelationshipOfDirectoryInDomainToItemAtURLError(outRelationship: NSURLRelationship;
      ofDirectory: NSSearchPathDirectory; inDomain: NSSearchPathDomainMask; toItemAtURL: NSURL; error: NSError): Boolean; cdecl;
    function createDirectoryAtURL(url: NSURL; withIntermediateDirectories: Boolean; attributes: NSDictionary;
      error: NSError): Boolean; cdecl;
    function createSymbolicLinkAtURL(url: NSURL; withDestinationURL: NSURL; error: NSError): Boolean; cdecl;
    [MethodName('createDirectoryAtPath:withIntermediateDirectories:attributes:error:')]
    function createDirectoryAtPathWithIntermediateDirectoriesAttributesError(path: NSString;
      withIntermediateDirectories: Boolean; attributes: NSDictionary; error: NSError): Boolean; cdecl;
    [MethodName('createSymbolicLinkAtPath:withDestinationPath:error:')]
    function createSymbolicLinkAtPathWithDestinationPathError(path: NSString; withDestinationPath: NSString;
      error: NSError): Boolean; cdecl;
    function trashItemAtURL(url: NSURL; resultingItemURL: NSURL; error: NSError): Boolean; cdecl;
    [MethodName('createSymbolicLinkAtPath:pathContent:')]
    function createSymbolicLinkAtPathPathContent(path: NSString; pathContent: NSString): Boolean; cdecl;
    [MethodName('createDirectoryAtPath:attributes:')]
    function createDirectoryAtPathAttributes(path: NSString; attributes: NSDictionary): Boolean; cdecl;
    function enumeratorAtURL(url: NSURL; includingPropertiesForKeys: NSArray; options: NSDirectoryEnumerationOptions;
      errorHandler: TFoundationErrorHandler): NSDirectoryEnumerator; cdecl;
    function setUbiquitous(flag: Boolean; itemAtURL: NSURL; destinationURL: NSURL; error: NSError): Boolean; cdecl;
    function isUbiquitousItemAtURL(url: NSURL): Boolean; cdecl;
    function startDownloadingUbiquitousItemAtURL(url: NSURL; error: NSError): Boolean; cdecl;
    function evictUbiquitousItemAtURL(url: NSURL; error: NSError): Boolean; cdecl;
    function URLForUbiquityContainerIdentifier(containerIdentifier: NSString): NSURL; cdecl;
    function URLForPublishingUbiquitousItemAtURL(url: NSURL; expirationDate: NSDate; error: NSError): NSURL; cdecl;
    function ubiquityIdentityToken: Pointer; cdecl;
    function containerURLForSecurityApplicationGroupIdentifier(groupIdentifier: NSString): NSURL; cdecl;
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
    {class} function indexPathWithIndexes(indexes: PNSUInteger; length: NSUInteger): Pointer; cdecl;
  end;
  NSIndexPath = interface(NSObject)
    ['{28CF6DB1-BD57-49E3-9E6D-7F96A7C151BC}']
    function compare(otherObject: NSIndexPath): NSComparisonResult; cdecl;
    procedure getIndexes(indexes: PNSUInteger); cdecl;
    function indexAtPosition(position: NSUInteger): NSUInteger; cdecl;
    function indexPathByAddingIndex(index: NSUInteger): NSIndexPath; cdecl;
    function indexPathByRemovingLastIndex: NSIndexPath; cdecl;
    function initWithIndex(index: NSUInteger): Pointer; cdecl;
    function initWithIndexes(indexes: PNSUInteger; length: NSUInteger): Pointer; cdecl;
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
    function getIndexes(indexBuffer: PNSUInteger; maxCount: NSUInteger; inIndexRange: PNSRange): NSUInteger; cdecl;
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
    function systemVersion: Cardinal; cdecl;
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
    function defaultNameServerPortNumber: UInt16; cdecl;
    function portForName(name: NSString): NSPort; cdecl; overload;
    function portForName(name: NSString; host: NSString): NSPort; cdecl; overload;
    function portForName(name: NSString; host: NSString; nameServerPortNumber: UInt16): NSPort; cdecl; overload;
    function registerPort(port: NSPort; name: NSString): Boolean; cdecl; overload;
    function registerPort(port: NSPort; name: NSString; nameServerPortNumber: UInt16): Boolean; cdecl; overload;
    function removePortForName(name: NSString): Boolean; cdecl;
    procedure setDefaultNameServerPortNumber(portNumber: UInt16); cdecl;
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
    function getBuffer(buffer: PByte; length: PNSUInteger): Boolean; cdecl;
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
    function decodeBytesForKey(key: NSString; returnedLength: PNSUInteger): PByte; cdecl;
    function decodeDoubleForKey(key: NSString): double; cdecl;
    function decodeFloatForKey(key: NSString): Single; cdecl;
    function decodeInt32ForKey(key: NSString): Int32; cdecl;
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
    procedure encodeInt32(intv: Int32; forKey: NSString); cdecl;
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
    procedure years(yp: PNSInteger; months: PNSInteger; days: PNSInteger; hours: PNSInteger; minutes: PNSInteger; seconds: PNSInteger; sinceDate: NSCalendarDate); cdecl;
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
    function getObjectValue(out obj: Pointer; forString: NSString; var range: NSRange; error: PPointer): Boolean; cdecl;
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
    {class} function portWithMachPort(machPort: UInt32): NSPort; cdecl; overload;
    {class} function portWithMachPort(machPort: UInt32; options: NSUInteger): NSPort; cdecl; overload;
  end;
  NSMachPort = interface(NSPort)
    ['{38E9CF5E-3127-4039-BC6D-C4C727E1053E}']
    function delegate: NSMachPortDelegate; cdecl;
    function initWithMachPort(machPort: UInt32): Pointer; cdecl; overload;
    function initWithMachPort(machPort: UInt32; options: NSUInteger): Pointer; cdecl; overload;
    function machPort: UInt32; cdecl;
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
    function getObjectValue(out obj: Pointer; forString: NSString; var range: NSRange; error: PPointer): Boolean; cdecl;
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
{$IFDEF NEXTGEN}
    {class} function numberWithChar(value: Char): Pointer; cdecl;                                                     
{$ELSE  NEXTGEN}
    {class} function numberWithChar(value: AnsiChar): Pointer; cdecl;
{$ENDIF NEXTGEN}
    {class} function numberWithDouble(value: double): Pointer; cdecl;
    {class} function numberWithFloat(value: Single): Pointer; cdecl;
    {class} function numberWithInt(value: Integer): Pointer; cdecl;
    {class} function numberWithInteger(value: NSInteger): Pointer; cdecl;
    {class} function numberWithLong(value: LongInt): Pointer; cdecl;
    {class} function numberWithLongLong(value: Int64): Pointer; cdecl;
    {class} function numberWithShort(value: Smallint): Pointer; cdecl;
    {class} function numberWithUnsignedChar(value: Byte): Pointer; cdecl;
    {class} function numberWithUnsignedInt(value: Cardinal): Pointer; cdecl;
    {class} function numberWithUnsignedInteger(value: NSUInteger): Pointer; cdecl;
    {class} function numberWithUnsignedLong(value: LongWord): Pointer; cdecl;
    {class} function numberWithUnsignedLongLong(value: UInt64): Pointer; cdecl;
    {class} function numberWithUnsignedShort(value: Word): Pointer; cdecl;
  end;
  NSNumber = interface(NSValue)
    ['{CC5A6F33-EED7-455E-8E32-ABDDEC5B454F}']
    function boolValue: Boolean; cdecl;
{$IFDEF NEXTGEN}
    function charValue: Char; cdecl;                                                     
{$ELSE  NEXTGEN}
    function charValue: AnsiChar; cdecl;
{$ENDIF NEXTGEN}
    function compare(otherNumber: NSNumber): NSComparisonResult; cdecl;
    function decimalValue: NSDecimal; cdecl;
    function descriptionWithLocale(locale: Pointer): NSString; cdecl;
    function doubleValue: double; cdecl;
    function floatValue: Single; cdecl;
    function initWithBool(value: Boolean): Pointer; cdecl;
{$IFDEF NEXTGEN}
    function initWithChar(value: Char): Pointer; cdecl;                                                     
{$ELSE  NEXTGEN}
    function initWithChar(value: AnsiChar): Pointer; cdecl;
{$ENDIF NEXTGEN}
    function initWithDouble(value: double): Pointer; cdecl;
    function initWithFloat(value: Single): Pointer; cdecl;
    function initWithInt(value: Integer): Pointer; cdecl;
    function initWithInteger(value: NSInteger): Pointer; cdecl;
    function initWithLong(value: LongInt): Pointer; cdecl;
    function initWithLongLong(value: Int64): Pointer; cdecl;
    function initWithShort(value: Smallint): Pointer; cdecl;
    function initWithUnsignedChar(value: Byte): Pointer; cdecl;
    function initWithUnsignedInt(value: Cardinal): Pointer; cdecl;
    function initWithUnsignedInteger(value: NSUInteger): Pointer; cdecl;
    function initWithUnsignedLong(value: LongWord): Pointer; cdecl;
    function initWithUnsignedLongLong(value: UInt64): Pointer; cdecl;
    function initWithUnsignedShort(value: Word): Pointer; cdecl;
    function intValue: Integer; cdecl;
    function integerValue: NSInteger; cdecl;
    function isEqualToNumber(number: NSNumber): Boolean; cdecl;
    function longLongValue: Int64; cdecl;
    function longValue: LongInt; cdecl;
    function shortValue: Smallint; cdecl;
    function stringValue: NSString; cdecl;
    function unsignedCharValue: Byte; cdecl;
    function unsignedIntValue: Cardinal; cdecl;
    function unsignedIntegerValue: NSUInteger; cdecl;
    function unsignedLongLongValue: UInt64; cdecl;
    function unsignedLongValue: LongWord; cdecl;
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
    procedure removeObjectsFromIndices(indices: PNSUInteger; numIndices: NSUInteger); cdecl;
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

  NSUUIDClass = interface(NSObjectClass)
  ['{E46675F8-A60F-4ED3-A168-12D3B381B913}']
    {class} function UUID: Pointer; cdecl;
  end;

  NSUUID = interface(NSObject)
  ['{A6E35A1D-0491-4918-9B50-7CAF9F66B2AD}']
    function init: NSUUID; cdecl;
    function initWithUUIDBytes: NSUUID; cdecl;
    function initWithUUIDString(string_: NSString): NSUUID; cdecl;
    function UUIDString: NSString; cdecl;
    procedure getUUIDBytes(uuid: uuid_t); cdecl;
  end;
  TNSUUID = class(TOCGenericImport<NSUUIDClass, NSUUID>)  end;

  NSUserNotificationClass = interface(NSObjectClass)
    ['{BD63AA5F-BF1C-442A-B72A-526358F5E448}']
  end;
  NSUserNotification = interface(NSObject)
    ['{5289169B-7A4F-46BE-8716-C10A780CBD0E}']
    function title: NSString; cdecl;
    procedure setTitle(title: NSString); cdecl;
    function subTitle: NSString; cdecl;
    procedure setSubTitle(subTitle: NSString); cdecl;
    function informativeText: NSString; cdecl;
    procedure setInformativeText(informativeText: NSString); cdecl;
    function hasActionButton: Boolean; cdecl;
    procedure setHasActionButton(hasActionButton: Boolean); cdecl;
    function actionButtonTitle: NSString; cdecl;
    procedure setActionButtonTitle(actionButtonTitle: NSString); cdecl;
    function otherButtonTitle: NSString; cdecl;
    procedure setOtherButtonTitle(otherButtonTitle: NSString); cdecl;
    function deliveryDate: NSDate; cdecl;
    procedure setDeliveryDate(deliveryDate: NSDate); cdecl;
    function actualDeliveryDate: NSDate; cdecl;
    function deliveryRepeatInterval: NSDateComponents; cdecl;
    procedure setDeliveryRepeatInterval(deliveryRepeatInterval: NSDateComponents); cdecl;
    function deliveryTimeZone: NSTimeZone; cdecl;
    procedure setDeliveryTimeZone(deliveryTimeZone: NSTimeZone); cdecl;
    function presented: Boolean; cdecl;
    function remote: Boolean; cdecl;
    function soundName: NSString; cdecl;
    procedure setSoundName(soundName: NSString); cdecl;
    function activationType: NSUserNotificationActivationType; cdecl;
    function userInfo: NSDictionary; cdecl;
    procedure setUserInfo(userInfo: NSDictionary); cdecl;
  end;
  TNSUserNotification = class(TOCGenericImport<NSUserNotificationClass, NSUserNotification>)  end;

  NSUserNotificationCenterDelegate = interface(IObjectiveC)
  ['{E506E35D-14F1-470A-9117-F8FBAD1C28D6}']
    procedure userNotificationCenter(center: NSUserNotificationCenter; didActivateNotification: NSUserNotification); cdecl;
//    procedure userNotificationCenter(center: NSUserNotificationCenter; didDeliverNotification: NSUserNotification); cdecl;
//    function userNotificationCenter(center: NSUserNotificationCenter; shouldPresentNotification: NSUserNotification): Boolean; overload; cdecl;
  end;

  NSUserNotificationCenterClass = interface(NSObjectClass)
    ['{BD63AA5F-BF1C-442A-B72A-526358F5E448}']
    {class} function defaultUserNotificationCenter: Pointer; cdecl;
  end;
  NSUserNotificationCenter = interface(NSObject)
    ['{5289169B-7A4F-46BE-8716-C10A780CBD0E}']
    procedure scheduleNotification(notification: NSUserNotification); cdecl;
    function scheduledNotifications: NSArray; cdecl;
    procedure removeScheduledNotification(notification: NSUserNotification); cdecl;
    procedure deliverNotification(notification: NSUserNotification); cdecl;
    function deliveredNotifications: NSArray; cdecl;
    procedure removeDeliveredNotification(notification: NSUserNotification); cdecl;
    procedure removeAllDeliveredNotifications; cdecl;
    procedure setDelegate(delegate: NSUserNotificationCenterDelegate); cdecl;
    function delegate: NSUserNotificationCenterDelegate; cdecl;
  end;
  TNSUserNotificationCenter = class(TOCGenericImport<NSUserNotificationCenterClass, NSUserNotificationCenter>)  end;

  NSURLSessionClass = interface(NSObjectClass)
    ['{68359970-AA48-4A7E-9084-D509B9ADE66F}']
    {class} function sharedSession: NSURLSession; cdecl;
    {class} [MethodName('sessionWithConfiguration:')]
    function sessionWithConfiguration(configuration: NSURLSessionConfiguration): NSURLSession; cdecl;
    {class} [MethodName('sessionWithConfiguration:delegate:delegateQueue:')]
    function sessionWithConfigurationDelegateDelegateQueue(configuration: NSURLSessionConfiguration; delegate: Pointer;
      delegateQueue: NSOperationQueue): NSURLSession; cdecl;
  end;

  NSURLSession = interface(NSObject)
    ['{D2FE9897-F223-421E-BF50-16D2572FDD9E}']
    function delegateQueue: NSOperationQueue; cdecl;
    function delegate: Pointer; cdecl;
    function configuration: NSURLSessionConfiguration; cdecl;
    procedure setSessionDescription(sessionDescription: NSString); cdecl;
    function sessionDescription: NSString; cdecl;
    procedure finishTasksAndInvalidate; cdecl;
    procedure invalidateAndCancel; cdecl;
    procedure resetWithCompletionHandler(completionHandler: TFoundationCompletionBlock); cdecl;
    procedure flushWithCompletionHandler(completionHandler: TFoundationCompletionBlock); cdecl;
    procedure getTasksWithCompletionHandler(completionHandler: TFoundationCompletionHandler2); cdecl;
    [MethodName('dataTaskWithRequest:')]
    function dataTaskWithRequest(request: NSURLRequest): NSURLSessionDataTask; cdecl;
    [MethodName('dataTaskWithURL:')]
    function dataTaskWithURL(url: NSURL): NSURLSessionDataTask; cdecl;
    [MethodName('uploadTaskWithRequest:fromFile:')]
    function uploadTaskWithRequestFromFile(request: NSURLRequest; fromFile: NSURL): NSURLSessionUploadTask; cdecl;
    [MethodName('uploadTaskWithRequest:fromData:')]
    function uploadTaskWithRequestFromData(request: NSURLRequest; fromData: NSData): NSURLSessionUploadTask; cdecl;
    function uploadTaskWithStreamedRequest(request: NSURLRequest): NSURLSessionUploadTask; cdecl;
    [MethodName('downloadTaskWithRequest:')]
    function downloadTaskWithRequest(request: NSURLRequest): NSURLSessionDownloadTask; cdecl;
    [MethodName('downloadTaskWithURL:')]
    function downloadTaskWithURL(url: NSURL): NSURLSessionDownloadTask; cdecl;
    [MethodName('downloadTaskWithResumeData:')]
    function downloadTaskWithResumeData(resumeData: NSData): NSURLSessionDownloadTask; cdecl;
    [MethodName('dataTaskWithRequest:completionHandler:')]
    function dataTaskWithRequestCompletionHandler(request: NSURLRequest;
      completionHandler: TFoundationCompletionHandler3): NSURLSessionDataTask; cdecl;
    [MethodName('dataTaskWithURL:completionHandler:')]
    function dataTaskWithURLCompletionHandler(url: NSURL; completionHandler: TFoundationCompletionHandler3)
      : NSURLSessionDataTask; cdecl;
    [MethodName('uploadTaskWithRequest:fromFile:completionHandler:')]
    function uploadTaskWithRequestFromFileCompletionHandler(request: NSURLRequest; fromFile: NSURL;
      completionHandler: TFoundationCompletionHandler3): NSURLSessionUploadTask; cdecl;
    [MethodName('uploadTaskWithRequest:fromData:completionHandler:')]
    function uploadTaskWithRequestFromDataCompletionHandler(request: NSURLRequest; fromData: NSData;
      completionHandler: TFoundationCompletionHandler3): NSURLSessionUploadTask; cdecl;
    [MethodName('downloadTaskWithRequest:completionHandler:')]
    function downloadTaskWithRequestCompletionHandler(request: NSURLRequest;
      completionHandler: TFoundationCompletionHandler4): NSURLSessionDownloadTask; cdecl;
    [MethodName('downloadTaskWithURL:completionHandler:')]
    function downloadTaskWithURLCompletionHandler(url: NSURL; completionHandler: TFoundationCompletionHandler4)
      : NSURLSessionDownloadTask; cdecl;
    [MethodName('downloadTaskWithResumeData:completionHandler:')]
    function downloadTaskWithResumeDataCompletionHandler(resumeData: NSData;
      completionHandler: TFoundationCompletionHandler4): NSURLSessionDownloadTask; cdecl;
    [MethodName('dataTaskWithHTTPGetRequest:')]
    function dataTaskWithHTTPGetRequest(url: NSURL): NSURLSessionDataTask; cdecl;
    [MethodName('dataTaskWithHTTPGetRequest:completionHandler:')]
    function dataTaskWithHTTPGetRequestCompletionHandler(url: NSURL; completionHandler: TFoundationCompletionHandler3)
      : NSURLSessionDataTask; cdecl;
  end;

  TNSURLSession = class(TOCGenericImport<NSURLSessionClass, NSURLSession>)
  end;

  NSURLSessionTaskClass = interface(NSObjectClass)
    ['{60EED1DD-A31E-4574-A448-11BFE4EF87BC}']
  end;

  NSURLSessionTask = interface(NSObject)
    ['{16E2CD5B-41D3-4163-B572-8E2A316FDE1E}']
    function taskIdentifier: NSUInteger; cdecl;
    function originalRequest: NSURLRequest; cdecl;
    function currentRequest: NSURLRequest; cdecl;
    function response: NSURLResponse; cdecl;
    function countOfBytesReceived: Int64; cdecl;
    function countOfBytesSent: Int64; cdecl;
    function countOfBytesExpectedToSend: Int64; cdecl;
    function countOfBytesExpectedToReceive: Int64; cdecl;
    procedure setTaskDescription(taskDescription: NSString); cdecl;
    function taskDescription: NSString; cdecl;
    procedure cancel; cdecl;
    function state: NSURLSessionTaskState; cdecl;
    function error: NSError; cdecl;
    procedure suspend; cdecl;
    procedure resume; cdecl;
  end;

  TNSURLSessionTask = class(TOCGenericImport<NSURLSessionTaskClass, NSURLSessionTask>)
  end;

  NSURLSessionDataTaskClass = interface(NSURLSessionTaskClass)
    ['{EBD5B7B7-E688-4305-AAF1-7628D110893C}']
  end;

  NSURLSessionDataTask = interface(NSURLSessionTask)
    ['{3905C5B9-935A-45C1-AE4B-32DD9C879078}']
  end;

  TNSURLSessionDataTask = class(TOCGenericImport<NSURLSessionDataTaskClass, NSURLSessionDataTask>)
  end;

  NSURLSessionUploadTaskClass = interface(NSURLSessionDataTaskClass)
    ['{E84DF68E-E120-4202-96E1-94537A5D506D}']
  end;

  NSURLSessionUploadTask = interface(NSURLSessionDataTask)
    ['{3EE77272-A611-4621-B35E-CE0D2BC59B5B}']
  end;

  TNSURLSessionUploadTask = class(TOCGenericImport<NSURLSessionUploadTaskClass, NSURLSessionUploadTask>)
  end;

  NSURLSessionDownloadTaskClass = interface(NSURLSessionTaskClass)
    ['{D1A2DEC7-00C4-4CAB-B101-DE5450D6EDFF}']
  end;

  NSURLSessionDownloadTask = interface(NSURLSessionTask)
    ['{1CD4BB63-3AB6-4902-8F7C-284B2F20B150}']
    procedure cancelByProducingResumeData(completionHandler: TFoundationCompletionHandler5); cdecl;
  end;

  TNSURLSessionDownloadTask = class(TOCGenericImport<NSURLSessionDownloadTaskClass, NSURLSessionDownloadTask>)
  end;

  NSURLSessionConfigurationClass = interface(NSObjectClass)
    ['{9CD9EE15-D2B4-4D2F-9B1B-9062D214AB83}']
    {class} function defaultSessionConfiguration: NSURLSessionConfiguration; cdecl;
    {class} function ephemeralSessionConfiguration: NSURLSessionConfiguration; cdecl;
    {class} function backgroundSessionConfiguration(identifier: NSString): NSURLSessionConfiguration; cdecl;
  end;

  NSURLSessionConfiguration = interface(NSObject)
    ['{EAB008A8-52AC-444E-A55A-5E7B9648DF83}']
    function identifier: NSString; cdecl;
    procedure setRequestCachePolicy(requestCachePolicy: NSURLRequestCachePolicy); cdecl;
    function requestCachePolicy: NSURLRequestCachePolicy; cdecl;
    procedure setTimeoutIntervalForRequest(timeoutIntervalForRequest: NSTimeInterval); cdecl;
    function timeoutIntervalForRequest: NSTimeInterval; cdecl;
    procedure setTimeoutIntervalForResource(timeoutIntervalForResource: NSTimeInterval); cdecl;
    function timeoutIntervalForResource: NSTimeInterval; cdecl;
    procedure setNetworkServiceType(networkServiceType: NSURLRequestNetworkServiceType); cdecl;
    function networkServiceType: NSURLRequestNetworkServiceType; cdecl;
    procedure setAllowsCellularAccess(allowsCellularAccess: Boolean); cdecl;
    function allowsCellularAccess: Boolean; cdecl;
    procedure setConnectionProxyDictionary(connectionProxyDictionary: NSDictionary); cdecl;
    function connectionProxyDictionary: NSDictionary; cdecl;
    procedure setTLSMinimumSupportedProtocol(TLSMinimumSupportedProtocol: SSLProtocol); cdecl;
    function TLSMinimumSupportedProtocol: SSLProtocol; cdecl;
    procedure setTLSMaximumSupportedProtocol(TLSMaximumSupportedProtocol: SSLProtocol); cdecl;
    function TLSMaximumSupportedProtocol: SSLProtocol; cdecl;
    procedure setHTTPShouldUsePipelining(HTTPShouldUsePipelining: Boolean); cdecl;
    function HTTPShouldUsePipelining: Boolean; cdecl;
    procedure setHTTPShouldSetCookies(HTTPShouldSetCookies: Boolean); cdecl;
    function HTTPShouldSetCookies: Boolean; cdecl;
    procedure setHTTPCookieAcceptPolicy(HTTPCookieAcceptPolicy: NSHTTPCookieAcceptPolicy); cdecl;
    function HTTPCookieAcceptPolicy: NSHTTPCookieAcceptPolicy; cdecl;
    procedure setHTTPAdditionalHeaders(HTTPAdditionalHeaders: NSDictionary); cdecl;
    function HTTPAdditionalHeaders: NSDictionary; cdecl;
    procedure setHTTPMaximumConnectionsPerHost(HTTPMaximumConnectionsPerHost: NSInteger); cdecl;
    function HTTPMaximumConnectionsPerHost: NSInteger; cdecl;
    procedure setHTTPCookieStorage(HTTPCookieStorage: NSHTTPCookieStorage); cdecl;
    function HTTPCookieStorage: NSHTTPCookieStorage; cdecl;
    procedure setURLCredentialStorage(URLCredentialStorage: NSURLCredentialStorage); cdecl;
    function URLCredentialStorage: NSURLCredentialStorage; cdecl;
    procedure setURLCache(URLCache: NSURLCache); cdecl;
    function URLCache: NSURLCache; cdecl;
    procedure setProtocolClasses(protocolClasses: NSArray); cdecl;
    function protocolClasses: NSArray; cdecl;
  end;

  TNSURLSessionConfiguration = class(TOCGenericImport<NSURLSessionConfigurationClass, NSURLSessionConfiguration>)
  end;


  NSExtensionContextClass = interface(NSObjectClass)
    ['{ADC5F989-89D6-435D-9260-96824A91FF7A}']
  end;
  NSExtensionContext = interface(NSObject)
    ['{746C1D05-2EFC-440D-A261-F127BCE76FF7}']
    function inputItems: NSArray; cdecl;
    procedure completeRequestReturningItems(items: NSArray; completionHandler: TFoundationCompletionHandler5); cdecl;
    procedure cancelRequestWithError(error: NSError); cdecl;
    procedure openURL(url: NSURL; completionHandler: TFoundationCompletionHandler5); cdecl;
  end;
  TNSExtensionContext = class(TOCGenericImport<NSExtensionContextClass, NSExtensionContext>)
  end;
  PNSExtensionContext = Pointer;

  NSItemProviderClass = interface(NSObjectClass)
    ['{9CE0CEA3-368A-449D-8ED6-0143AF4C9C57}']
  end;
  NSItemProvider = interface(NSObject)
    ['{16308020-A312-4F4E-A07F-4006046538B7}']
    function initWithItem(item: Pointer; typeIdentifier: NSString): Pointer {instancetype}; cdecl;
    function initWithContentsOfURL(fileURL: NSURL): Pointer {instancetype}; cdecl;
    procedure registerItemForTypeIdentifier(typeIdentifier: NSString; loadHandler: NSItemProviderLoadHandler); cdecl;
    function registeredTypeIdentifiers: NSArray; cdecl;
    function hasItemConformingToTypeIdentifier(typeIdentifier: NSString): Boolean; cdecl;
    procedure loadItemForTypeIdentifier(typeIdentifier: NSString; options: NSDictionary;
      completionHandler: NSItemProviderCompletionHandler); cdecl;
    procedure setPreviewImageHandler(previewImageHandler: NSItemProviderLoadHandler); cdecl;
    function previewImageHandler: NSItemProviderLoadHandler; cdecl;
    procedure loadPreviewImageWithOptions(options: NSDictionary;
      completionHandler: NSItemProviderCompletionHandler); cdecl;
  end;
  TNSItemProvider = class(TOCGenericImport<NSItemProviderClass, NSItemProvider>)
  end;
  PNSItemProvider = Pointer;

  NSExtensionItemClass = interface(NSObjectClass)
    ['{22C6B8DF-F8C6-4308-A1DA-FD2A9CBF078C}']
  end;
  NSExtensionItem = interface(NSObject)
    ['{664799E6-2FD5-4C75-9C5C-F5465B28B083}']
    procedure setAttributedTitle(attributedTitle: NSAttributedString); cdecl;
    function attributedTitle: NSAttributedString; cdecl;
    procedure setAttributedContentText(attributedContentText: NSAttributedString); cdecl;
    function attributedContentText: NSAttributedString; cdecl;
    procedure setAttachments(attachments: NSArray); cdecl;
    function attachments: NSArray; cdecl;
    procedure setUserInfo(userInfo: NSDictionary); cdecl;
    function userInfo: NSDictionary; cdecl;
  end;
  TNSExtensionItem = class(TOCGenericImport<NSExtensionItemClass, NSExtensionItem>)
  end;
  PNSExtensionItem = Pointer;

  NSFileAccessIntentClass = interface(NSObjectClass)
    ['{546C2C6B-73E5-4F2C-AB2B-4F5265F378E5}']
    {class} function readingIntentWithURL(url: NSURL; options: NSFileCoordinatorReadingOptions)
      : Pointer {instancetype}; cdecl;
    {class} function writingIntentWithURL(url: NSURL; options: NSFileCoordinatorWritingOptions)
      : Pointer {instancetype}; cdecl;
  end;
  NSFileAccessIntent = interface(NSObject)
    ['{C172119F-95E0-45D3-B1A9-278C504F5984}']
    function url: NSURL; cdecl;
  end;
  TNSFileAccessIntent = class(TOCGenericImport<NSFileAccessIntentClass, NSFileAccessIntent>)
  end;
  PNSFileAccessIntent = Pointer;

  NSFileCoordinatorClass = interface(NSObjectClass)
    ['{DB2C1812-FFC9-4C7C-9F7F-DF8DA7CC7AAA}']
    {class} procedure addFilePresenter(filePresenter: Pointer); cdecl;
    {class} procedure removeFilePresenter(filePresenter: Pointer); cdecl;
    {class} function filePresenters: NSArray; cdecl;
  end;
  NSFileCoordinator = interface(NSObject)
    ['{B04643AB-8B96-4DE0-8990-FD68BE47DD78}']
    function initWithFilePresenter(filePresenterOrNil: Pointer): Pointer {instancetype}; cdecl;
    procedure setPurposeIdentifier(purposeIdentifier: NSString); cdecl;
    function purposeIdentifier: NSString; cdecl;
    procedure coordinateAccessWithIntents(intents: NSArray; queue: NSOperationQueue;
      byAccessor: TFoundationByAccessor); cdecl;
    [MethodName('coordinateReadingItemAtURL:options:error:byAccessor:')]
    procedure coordinateReadingItemAtURLOptionsErrorByAccessor(url: NSURL; options: NSFileCoordinatorReadingOptions;
      error: NSError; byAccessor: TFoundationByAccessor1); cdecl;
    [MethodName('coordinateWritingItemAtURL:options:error:byAccessor:')]
    procedure coordinateWritingItemAtURLOptionsErrorByAccessor(url: NSURL; options: NSFileCoordinatorWritingOptions;
      error: NSError; byAccessor: TFoundationByAccessor1); cdecl;
    [MethodName('coordinateReadingItemAtURL:options:writingItemAtURL:options:error:byAccessor:')]
    procedure coordinateReadingItemAtURLOptionsWritingItemAtURLOptionsErrorByAccessor(readingURL: NSURL;
      options: NSFileCoordinatorReadingOptions; writingItemAtURL: NSURL; options1: NSFileCoordinatorWritingOptions;
      error: NSError; byAccessor: TFoundationByAccessor2); cdecl;
    [MethodName('coordinateWritingItemAtURL:options:writingItemAtURL:options:error:byAccessor:')]
    procedure coordinateWritingItemAtURLOptionsWritingItemAtURLOptionsErrorByAccessor(url1: NSURL;
      options: NSFileCoordinatorWritingOptions; writingItemAtURL: NSURL; options1: NSFileCoordinatorWritingOptions;
      error: NSError; byAccessor: TFoundationByAccessor2); cdecl;
    procedure prepareForReadingItemsAtURLs(readingURLs: NSArray; options: NSFileCoordinatorReadingOptions;
      writingItemsAtURLs: NSArray; options1: NSFileCoordinatorWritingOptions; error: NSError;
      byAccessor: TFoundationByAccessor3); cdecl;
    [MethodName('itemAtURL:willMoveToURL:')]
    procedure itemAtURLWillMoveToURL(oldURL: NSURL; willMoveToURL: NSURL); cdecl;
    [MethodName('itemAtURL:didMoveToURL:')]
    procedure itemAtURLDidMoveToURL(oldURL: NSURL; didMoveToURL: NSURL); cdecl;
    procedure cancel; cdecl;
  end;
  TNSFileCoordinator = class(TOCGenericImport<NSFileCoordinatorClass, NSFileCoordinator>)
  end;
  PNSFileCoordinator = Pointer;

  NSFileVersionClass = interface(NSObjectClass)
    ['{4C81557C-C85E-4C9F-94C5-F5AC05CDDDDE}']
    {class} function currentVersionOfItemAtURL(url: NSURL): NSFileVersion; cdecl;
    {class} function otherVersionsOfItemAtURL(url: NSURL): NSArray; cdecl;
    {class} function unresolvedConflictVersionsOfItemAtURL(url: NSURL): NSArray; cdecl;
    {class} procedure getNonlocalVersionsOfItemAtURL(url: NSURL;
      completionHandler: TFoundationCompletionHandler6); cdecl;
    {class} function versionOfItemAtURL(url: NSURL; forPersistentIdentifier: Pointer): NSFileVersion; cdecl;
    {class} function addVersionOfItemAtURL(url: NSURL; withContentsOfURL: NSURL; options: NSFileVersionAddingOptions;
      error: NSError): NSFileVersion; cdecl;
    {class} function temporaryDirectoryURLForNewVersionOfItemAtURL(url: NSURL): NSURL; cdecl;
    {class} function removeOtherVersionsOfItemAtURL(url: NSURL; error: NSError): Boolean; cdecl;
  end;
  NSFileVersion = interface(NSObject)
    ['{EFCC2E65-65F9-499E-9276-64752F349E2E}']
    function url: NSURL; cdecl;
    function localizedName: NSString; cdecl;
    function localizedNameOfSavingComputer: NSString; cdecl;
    function modificationDate: NSDate; cdecl;
    function persistentIdentifier: Pointer; cdecl;
    function isConflict: Boolean; cdecl;
    procedure setResolved(resolved: Boolean); cdecl;
    function isResolved: Boolean; cdecl;
    procedure setDiscardable(discardable: Boolean); cdecl;
    function isDiscardable: Boolean; cdecl;
    function hasLocalContents: Boolean; cdecl;
    function hasThumbnail: Boolean; cdecl;
    function replaceItemAtURL(url: NSURL; options: NSFileVersionReplacingOptions; error: NSError): NSURL; cdecl;
    function removeAndReturnError(outError: NSError): Boolean; cdecl;
  end;
  TNSFileVersion = class(TOCGenericImport<NSFileVersionClass, NSFileVersion>)
  end;
  PNSFileVersion = Pointer;

  NSFileWrapperClass = interface(NSObjectClass)
    ['{AC3DB040-5585-49A2-B36A-B728DB3D7EB3}']
  end;
  NSFileWrapper = interface(NSObject)
    ['{0D0E334B-C7E6-4253-AA41-449D4991E869}']
    function initWithURL(url: NSURL; options: NSFileWrapperReadingOptions; error: NSError)
      : Pointer {instancetype}; cdecl;
    function initDirectoryWithFileWrappers(childrenByPreferredName: NSDictionary): Pointer {instancetype}; cdecl;
    function initRegularFileWithContents(contents: NSData): Pointer {instancetype}; cdecl;
    function initSymbolicLinkWithDestinationURL(url: NSURL): Pointer {instancetype}; cdecl;
    function initWithSerializedRepresentation(serializeRepresentation: NSData): Pointer {instancetype}; cdecl;
    function initWithCoder(inCoder: NSCoder): Pointer {instancetype}; cdecl;
    function isDirectory: Boolean; cdecl;
    function isRegularFile: Boolean; cdecl;
    function isSymbolicLink: Boolean; cdecl;
    procedure setPreferredFilename(preferredFilename: NSString); cdecl;
    function preferredFilename: NSString; cdecl;
    procedure setFilename(filename: NSString); cdecl;
    function filename: NSString; cdecl;
    procedure setFileAttributes(fileAttributes: NSDictionary); cdecl;
    function fileAttributes: NSDictionary; cdecl;
    function matchesContentsOfURL(url: NSURL): Boolean; cdecl;
    function readFromURL(url: NSURL; options: NSFileWrapperReadingOptions; error: NSError): Boolean; cdecl;
    function writeToURL(url: NSURL; options: NSFileWrapperWritingOptions; originalContentsURL: NSURL; error: NSError)
      : Boolean; cdecl;
    function serializedRepresentation: NSData; cdecl;
    function addFileWrapper(child: NSFileWrapper): NSString; cdecl;
    function addRegularFileWithContents(data: NSData; preferredFilename: NSString): NSString; cdecl;
    procedure removeFileWrapper(child: NSFileWrapper); cdecl;
    function fileWrappers: NSDictionary; cdecl;
    function keyForFileWrapper(child: NSFileWrapper): NSString; cdecl;
    function regularFileContents: NSData; cdecl;
    function symbolicLinkDestinationURL: NSURL; cdecl;
    function initWithPath(path: NSString): Pointer; cdecl;
    function initSymbolicLinkWithDestination(path: NSString): Pointer; cdecl;
    function needsToBeUpdatedFromPath(path: NSString): Boolean; cdecl;
    function updateFromPath(path: NSString): Boolean; cdecl;
    function writeToFile(path: NSString; atomically: Boolean; updateFilenames: Boolean): Boolean; cdecl;
    function addFileWithPath(path: NSString): NSString; cdecl;
    function addSymbolicLinkWithDestination(path: NSString; preferredFilename: NSString): NSString; cdecl;
    function symbolicLinkDestination: NSString; cdecl;
  end;
  TNSFileWrapper = class(TOCGenericImport<NSFileWrapperClass, NSFileWrapper>)
  end;
  PNSFileWrapper = Pointer;


  // ===== Exported string consts =====

function NSFoundationVersionNumber: Pointer;
function NSBundleDidLoadNotification: NSString;
function NSLoadedClasses: NSString;
function NSSystemClockDidChangeNotification: NSString;
function NSCalendarIdentifierGregorian: NSString;
function NSCalendarIdentifierBuddhist: NSString;
function NSCalendarIdentifierChinese: NSString;
function NSCalendarIdentifierCoptic: NSString;
function NSCalendarIdentifierEthiopicAmeteMihret: NSString;
function NSCalendarIdentifierEthiopicAmeteAlem: NSString;
function NSCalendarIdentifierHebrew: NSString;
function NSCalendarIdentifierISO8601: NSString;
function NSCalendarIdentifierIndian: NSString;
function NSCalendarIdentifierIslamic: NSString;
function NSCalendarIdentifierIslamicCivil: NSString;
function NSCalendarIdentifierJapanese: NSString;
function NSCalendarIdentifierPersian: NSString;
function NSCalendarIdentifierRepublicOfChina: NSString;
function NSCalendarIdentifierIslamicTabular: NSString;
function NSCalendarIdentifierIslamicUmmAlQura: NSString;
function NSCalendarDayChangedNotification: NSString;
function NSParseErrorException: NSString;
function NSCharacterConversionException: NSString;
function NSStringEncodingDetectionSuggestedEncodingsKey: NSString;
function NSStringEncodingDetectionDisallowedEncodingsKey: NSString;
function NSStringEncodingDetectionUseOnlySuggestedEncodingsKey: NSString;
function NSStringEncodingDetectionAllowLossyKey: NSString;
function NSStringEncodingDetectionFromWindowsKey: NSString;
function NSStringEncodingDetectionLossySubstitutionKey: NSString;
function NSStringEncodingDetectionLikelyLanguageKey: NSString;
function NSDecimalNumberExactnessException: NSString;
function NSDecimalNumberOverflowException: NSString;
function NSDecimalNumberUnderflowException: NSString;
function NSDecimalNumberDivideByZeroException: NSString;
function NSCocoaErrorDomain: NSString;
function NSPOSIXErrorDomain: NSString;
function NSOSStatusErrorDomain: NSString;
function NSMachErrorDomain: NSString;
function NSUnderlyingErrorKey: NSString;
function NSLocalizedDescriptionKey: NSString;
function NSLocalizedFailureReasonErrorKey: NSString;
function NSLocalizedRecoverySuggestionErrorKey: NSString;
function NSLocalizedRecoveryOptionsErrorKey: NSString;
function NSRecoveryAttempterErrorKey: NSString;
function NSHelpAnchorErrorKey: NSString;
function NSStringEncodingErrorKey: NSString;
function NSURLErrorKey: NSString;
function NSFilePathErrorKey: NSString;
function NSGenericException: NSString;
function NSRangeException: NSString;
function NSInvalidArgumentException: NSString;
function NSInternalInconsistencyException: NSString;
function NSMallocException: NSString;
function NSObjectInaccessibleException: NSString;
function NSObjectNotAvailableException: NSString;
function NSDestinationInvalidException: NSString;
function NSPortTimeoutException: NSString;
function NSInvalidSendPortException: NSString;
function NSInvalidReceivePortException: NSString;
function NSPortSendException: NSString;
function NSPortReceiveException: NSString;
function NSOldStyleException: NSString;
function NSAssertionHandlerKey: NSString;
function NSFileHandleOperationException: NSString;
function NSFileHandleReadCompletionNotification: NSString;
function NSFileHandleReadToEndOfFileCompletionNotification: NSString;
function NSFileHandleConnectionAcceptedNotification: NSString;
function NSFileHandleDataAvailableNotification: NSString;
function NSFileHandleNotificationDataItem: NSString;
function NSFileHandleNotificationFileHandleItem: NSString;
function NSFileHandleNotificationMonitorModes: NSString;
function NSUbiquityIdentityDidChangeNotification: NSString;
function NSFileType: NSString;
function NSFileTypeDirectory: NSString;
function NSFileTypeRegular: NSString;
function NSFileTypeSymbolicLink: NSString;
function NSFileTypeSocket: NSString;
function NSFileTypeCharacterSpecial: NSString;
function NSFileTypeBlockSpecial: NSString;
function NSFileTypeUnknown: NSString;
function NSFileSize: NSString;
function NSFileModificationDate: NSString;
function NSFileReferenceCount: NSString;
function NSFileDeviceIdentifier: NSString;
function NSFileOwnerAccountName: NSString;
function NSFileGroupOwnerAccountName: NSString;
function NSFilePosixPermissions: NSString;
function NSFileSystemNumber: NSString;
function NSFileSystemFileNumber: NSString;
function NSFileExtensionHidden: NSString;
function NSFileHFSCreatorCode: NSString;
function NSFileHFSTypeCode: NSString;
function NSFileImmutable: NSString;
function NSFileAppendOnly: NSString;
function NSFileCreationDate: NSString;
function NSFileOwnerAccountID: NSString;
function NSFileGroupOwnerAccountID: NSString;
function NSFileBusy: NSString;
function NSFileSystemSize: NSString;
function NSFileSystemFreeSize: NSString;
function NSFileSystemNodes: NSString;
function NSFileSystemFreeNodes: NSString;
function NSIntegerHashCallBacks: Pointer;
function NSNonOwnedPointerHashCallBacks: Pointer;
function NSNonRetainedObjectHashCallBacks: Pointer;
function NSObjectHashCallBacks: Pointer;
function NSOwnedObjectIdentityHashCallBacks: Pointer;
function NSOwnedPointerHashCallBacks: Pointer;
function NSPointerToStructHashCallBacks: Pointer;
function NSIntHashCallBacks: Pointer;
function NSHTTPCookieName: NSString;
function NSHTTPCookieValue: NSString;
function NSHTTPCookieOriginURL: NSString;
function NSHTTPCookieVersion: NSString;
function NSHTTPCookieDomain: NSString;
function NSHTTPCookiePath: NSString;
function NSHTTPCookieSecure: NSString;
function NSHTTPCookieExpires: NSString;
function NSHTTPCookieComment: NSString;
function NSHTTPCookieCommentURL: NSString;
function NSHTTPCookieDiscard: NSString;
function NSHTTPCookieMaximumAge: NSString;
function NSHTTPCookiePort: NSString;
function NSHTTPCookieManagerAcceptPolicyChangedNotification: NSString;
function NSHTTPCookieManagerCookiesChangedNotification: NSString;
function NSUndefinedKeyException: NSString;
function NSAverageKeyValueOperator: NSString;
function NSCountKeyValueOperator: NSString;
function NSDistinctUnionOfArraysKeyValueOperator: NSString;
function NSDistinctUnionOfObjectsKeyValueOperator: NSString;
function NSDistinctUnionOfSetsKeyValueOperator: NSString;
function NSMaximumKeyValueOperator: NSString;
function NSMinimumKeyValueOperator: NSString;
function NSSumKeyValueOperator: NSString;
function NSUnionOfArraysKeyValueOperator: NSString;
function NSUnionOfObjectsKeyValueOperator: NSString;
function NSUnionOfSetsKeyValueOperator: NSString;
function NSKeyValueChangeKindKey: NSString;
function NSKeyValueChangeNewKey: NSString;
function NSKeyValueChangeOldKey: NSString;
function NSKeyValueChangeIndexesKey: NSString;
function NSKeyValueChangeNotificationIsPriorKey: NSString;
function NSZeroPoint: Pointer;
function NSZeroSize: Pointer;
function NSZeroRect: Pointer;
function NSEdgeInsetsZero: Pointer;
function NSInvalidArchiveOperationException: NSString;
function NSInvalidUnarchiveOperationException: NSString;
function NSKeyedArchiveRootObjectKey: NSString;
function NSCurrentLocaleDidChangeNotification: NSString;
function NSLocaleIdentifier: NSString;
function NSLocaleLanguageCode: NSString;
function NSLocaleCountryCode: NSString;
function NSLocaleScriptCode: NSString;
function NSLocaleVariantCode: NSString;
function NSLocaleExemplarCharacterSet: NSString;
function NSLocaleCalendar: NSString;
function NSLocaleCollationIdentifier: NSString;
function NSLocaleUsesMetricSystem: NSString;
function NSLocaleMeasurementSystem: NSString;
function NSLocaleDecimalSeparator: NSString;
function NSLocaleGroupingSeparator: NSString;
function NSLocaleCurrencySymbol: NSString;
function NSLocaleCurrencyCode: NSString;
function NSLocaleCollatorIdentifier: NSString;
function NSLocaleQuotationBeginDelimiterKey: NSString;
function NSLocaleQuotationEndDelimiterKey: NSString;
function NSLocaleAlternateQuotationBeginDelimiterKey: NSString;
function NSLocaleAlternateQuotationEndDelimiterKey: NSString;
function NSGregorianCalendar: NSString;
function NSBuddhistCalendar: NSString;
function NSChineseCalendar: NSString;
function NSHebrewCalendar: NSString;
function NSIslamicCalendar: NSString;
function NSIslamicCivilCalendar: NSString;
function NSJapaneseCalendar: NSString;
function NSRepublicOfChinaCalendar: NSString;
function NSPersianCalendar: NSString;
function NSIndianCalendar: NSString;
function NSISO8601Calendar: NSString;
function NSIntegerMapKeyCallBacks: Pointer;
function NSNonOwnedPointerMapKeyCallBacks: Pointer;
function NSNonOwnedPointerOrNullMapKeyCallBacks: Pointer;
function NSNonRetainedObjectMapKeyCallBacks: Pointer;
function NSObjectMapKeyCallBacks: Pointer;
function NSOwnedPointerMapKeyCallBacks: Pointer;
function NSIntMapKeyCallBacks: Pointer;
function NSIntegerMapValueCallBacks: Pointer;
function NSNonOwnedPointerMapValueCallBacks: Pointer;
function NSObjectMapValueCallBacks: Pointer;
function NSNonRetainedObjectMapValueCallBacks: Pointer;
function NSOwnedPointerMapValueCallBacks: Pointer;
function NSIntMapValueCallBacks: Pointer;
function NSInvocationOperationVoidResultException: NSString;
function NSInvocationOperationCancelledException: NSString;
function NSPortDidBecomeInvalidNotification: NSString;
function NSTextCheckingNameKey: NSString;
function NSTextCheckingJobTitleKey: NSString;
function NSTextCheckingOrganizationKey: NSString;
function NSTextCheckingStreetKey: NSString;
function NSTextCheckingCityKey: NSString;
function NSTextCheckingStateKey: NSString;
function NSTextCheckingZIPKey: NSString;
function NSTextCheckingCountryKey: NSString;
function NSTextCheckingPhoneKey: NSString;
function NSTextCheckingAirlineKey: NSString;
function NSTextCheckingFlightKey: NSString;
function NSDefaultRunLoopMode: NSString;
function NSRunLoopCommonModes: NSString;
function NSStreamSocketSecurityLevelKey: NSString;
function NSStreamSocketSecurityLevelNone: NSString;
function NSStreamSocketSecurityLevelSSLv2: NSString;
function NSStreamSocketSecurityLevelSSLv3: NSString;
function NSStreamSocketSecurityLevelTLSv1: NSString;
function NSStreamSocketSecurityLevelNegotiatedSSL: NSString;
function NSStreamSOCKSProxyConfigurationKey: NSString;
function NSStreamSOCKSProxyHostKey: NSString;
function NSStreamSOCKSProxyPortKey: NSString;
function NSStreamSOCKSProxyVersionKey: NSString;
function NSStreamSOCKSProxyUserKey: NSString;
function NSStreamSOCKSProxyPasswordKey: NSString;
function NSStreamSOCKSProxyVersion4: NSString;
function NSStreamSOCKSProxyVersion5: NSString;
function NSStreamDataWrittenToMemoryStreamKey: NSString;
function NSStreamFileCurrentOffsetKey: NSString;
function NSStreamSocketSSLErrorDomain: NSString;
function NSStreamSOCKSErrorDomain: NSString;
function NSStreamNetworkServiceType: NSString;
function NSStreamNetworkServiceTypeVoIP: NSString;
function NSStreamNetworkServiceTypeVideo: NSString;
function NSStreamNetworkServiceTypeBackground: NSString;
function NSStreamNetworkServiceTypeVoice: NSString;
function NSWillBecomeMultiThreadedNotification: NSString;
function NSDidBecomeSingleThreadedNotification: NSString;
function NSThreadWillExitNotification: NSString;
function NSSystemTimeZoneDidChangeNotification: NSString;
function NSHTTPPropertyStatusCodeKey: NSString;
function NSHTTPPropertyStatusReasonKey: NSString;
function NSHTTPPropertyServerHTTPVersionKey: NSString;
function NSHTTPPropertyRedirectionHeadersKey: NSString;
function NSHTTPPropertyErrorPageDataKey: NSString;
function NSHTTPPropertyHTTPProxy: NSString;
function NSFTPPropertyUserLoginKey: NSString;
function NSFTPPropertyUserPasswordKey: NSString;
function NSFTPPropertyActiveTransferModeKey: NSString;
function NSFTPPropertyFileOffsetKey: NSString;
function NSFTPPropertyFTPProxy: NSString;
function NSURLFileScheme: NSString;
function NSURLKeysOfUnsetValuesKey: NSString;
function NSURLNameKey: NSString;
function NSURLLocalizedNameKey: NSString;
function NSURLIsRegularFileKey: NSString;
function NSURLIsDirectoryKey: NSString;
function NSURLIsSymbolicLinkKey: NSString;
function NSURLIsVolumeKey: NSString;
function NSURLIsPackageKey: NSString;
function NSURLIsSystemImmutableKey: NSString;
function NSURLIsUserImmutableKey: NSString;
function NSURLIsHiddenKey: NSString;
function NSURLHasHiddenExtensionKey: NSString;
function NSURLCreationDateKey: NSString;
function NSURLContentAccessDateKey: NSString;
function NSURLContentModificationDateKey: NSString;
function NSURLAttributeModificationDateKey: NSString;
function NSURLLinkCountKey: NSString;
function NSURLParentDirectoryURLKey: NSString;
function NSURLVolumeURLKey: NSString;
function NSURLTypeIdentifierKey: NSString;
function NSURLLocalizedTypeDescriptionKey: NSString;
function NSURLLabelNumberKey: NSString;
function NSURLLabelColorKey: NSString;
function NSURLLocalizedLabelKey: NSString;
function NSURLEffectiveIconKey: NSString;
function NSURLCustomIconKey: NSString;
function NSURLFileResourceIdentifierKey: NSString;
function NSURLVolumeIdentifierKey: NSString;
function NSURLPreferredIOBlockSizeKey: NSString;
function NSURLIsReadableKey: NSString;
function NSURLIsWritableKey: NSString;
function NSURLIsExecutableKey: NSString;
function NSURLFileSecurityKey: NSString;
function NSURLIsExcludedFromBackupKey: NSString;
function NSURLTagNamesKey: NSString;
function NSURLPathKey: NSString;
function NSURLIsMountTriggerKey: NSString;
function NSURLGenerationIdentifierKey: NSString;
function NSURLDocumentIdentifierKey: NSString;
function NSURLAddedToDirectoryDateKey: NSString;
function NSURLQuarantinePropertiesKey: NSString;
function NSURLFileResourceTypeKey: NSString;
function NSURLFileResourceTypeNamedPipe: NSString;
function NSURLFileResourceTypeCharacterSpecial: NSString;
function NSURLFileResourceTypeDirectory: NSString;
function NSURLFileResourceTypeBlockSpecial: NSString;
function NSURLFileResourceTypeRegular: NSString;
function NSURLFileResourceTypeSymbolicLink: NSString;
function NSURLFileResourceTypeSocket: NSString;
function NSURLFileResourceTypeUnknown: NSString;
function NSURLThumbnailDictionaryKey: NSString;
function NSURLThumbnailKey: NSString;
function NSThumbnail1024x1024SizeKey: NSString;
function NSURLFileSizeKey: NSString;
function NSURLFileAllocatedSizeKey: NSString;
function NSURLTotalFileSizeKey: NSString;
function NSURLTotalFileAllocatedSizeKey: NSString;
function NSURLIsAliasFileKey: NSString;
function NSURLVolumeLocalizedFormatDescriptionKey: NSString;
function NSURLVolumeTotalCapacityKey: NSString;
function NSURLVolumeAvailableCapacityKey: NSString;
function NSURLVolumeResourceCountKey: NSString;
function NSURLVolumeSupportsPersistentIDsKey: NSString;
function NSURLVolumeSupportsSymbolicLinksKey: NSString;
function NSURLVolumeSupportsHardLinksKey: NSString;
function NSURLVolumeSupportsJournalingKey: NSString;
function NSURLVolumeIsJournalingKey: NSString;
function NSURLVolumeSupportsSparseFilesKey: NSString;
function NSURLVolumeSupportsZeroRunsKey: NSString;
function NSURLVolumeSupportsCaseSensitiveNamesKey: NSString;
function NSURLVolumeSupportsCasePreservedNamesKey: NSString;
function NSURLVolumeSupportsRootDirectoryDatesKey: NSString;
function NSURLVolumeSupportsVolumeSizesKey: NSString;
function NSURLVolumeSupportsRenamingKey: NSString;
function NSURLVolumeSupportsAdvisoryFileLockingKey: NSString;
function NSURLVolumeSupportsExtendedSecurityKey: NSString;
function NSURLVolumeIsBrowsableKey: NSString;
function NSURLVolumeMaximumFileSizeKey: NSString;
function NSURLVolumeIsEjectableKey: NSString;
function NSURLVolumeIsRemovableKey: NSString;
function NSURLVolumeIsInternalKey: NSString;
function NSURLVolumeIsAutomountedKey: NSString;
function NSURLVolumeIsLocalKey: NSString;
function NSURLVolumeIsReadOnlyKey: NSString;
function NSURLVolumeCreationDateKey: NSString;
function NSURLVolumeURLForRemountingKey: NSString;
function NSURLVolumeUUIDStringKey: NSString;
function NSURLVolumeNameKey: NSString;
function NSURLVolumeLocalizedNameKey: NSString;
function NSURLIsUbiquitousItemKey: NSString;
function NSURLUbiquitousItemHasUnresolvedConflictsKey: NSString;
function NSURLUbiquitousItemIsDownloadedKey: NSString;
function NSURLUbiquitousItemIsDownloadingKey: NSString;
function NSURLUbiquitousItemIsUploadedKey: NSString;
function NSURLUbiquitousItemIsUploadingKey: NSString;
function NSURLUbiquitousItemPercentDownloadedKey: NSString;
function NSURLUbiquitousItemPercentUploadedKey: NSString;
function NSURLUbiquitousItemDownloadingStatusKey: NSString;
function NSURLUbiquitousItemDownloadingErrorKey: NSString;
function NSURLUbiquitousItemUploadingErrorKey: NSString;
function NSURLUbiquitousItemDownloadRequestedKey: NSString;
function NSURLUbiquitousItemContainerDisplayNameKey: NSString;
function NSURLUbiquitousItemDownloadingStatusNotDownloaded: NSString;
function NSURLUbiquitousItemDownloadingStatusDownloaded: NSString;
function NSURLUbiquitousItemDownloadingStatusCurrent: NSString;
function NSURLCredentialStorageChangedNotification: NSString;
function NSURLCredentialStorageRemoveSynchronizableCredentials: NSString;
function NSURLErrorDomain: NSString;
function NSURLErrorFailingURLErrorKey: NSString;
function NSURLErrorFailingURLStringErrorKey: NSString;
function NSErrorFailingURLStringKey: NSString;
function NSURLErrorFailingURLPeerTrustErrorKey: NSString;
function NSURLErrorBackgroundTaskCancelledReasonKey: NSString;
function NSURLProtectionSpaceHTTP: NSString;
function NSURLProtectionSpaceHTTPS: NSString;
function NSURLProtectionSpaceFTP: NSString;
function NSURLProtectionSpaceHTTPProxy: NSString;
function NSURLProtectionSpaceHTTPSProxy: NSString;
function NSURLProtectionSpaceFTPProxy: NSString;
function NSURLProtectionSpaceSOCKSProxy: NSString;
function NSURLAuthenticationMethodDefault: NSString;
function NSURLAuthenticationMethodHTTPBasic: NSString;
function NSURLAuthenticationMethodHTTPDigest: NSString;
function NSURLAuthenticationMethodHTMLForm: NSString;
function NSURLAuthenticationMethodNTLM: NSString;
function NSURLAuthenticationMethodNegotiate: NSString;
function NSURLAuthenticationMethodClientCertificate: NSString;
function NSURLAuthenticationMethodServerTrust: NSString;
function NSGlobalDomain: NSString;
function NSArgumentDomain: NSString;
function NSRegistrationDomain: NSString;
function NSUserDefaultsDidChangeNotification: NSString;
function NSWeekDayNameArray: NSString;
function NSShortWeekDayNameArray: NSString;
function NSMonthNameArray: NSString;
function NSShortMonthNameArray: NSString;
function NSTimeFormatString: NSString;
function NSDateFormatString: NSString;
function NSTimeDateFormatString: NSString;
function NSShortTimeDateFormatString: NSString;
function NSCurrencySymbol: NSString;
function NSDecimalSeparator: NSString;
function NSThousandsSeparator: NSString;
function NSDecimalDigits: NSString;
function NSAMPMDesignation: NSString;
function NSHourNameDesignations: NSString;
function NSYearMonthWeekDesignations: NSString;
function NSEarlierTimeDesignations: NSString;
function NSLaterTimeDesignations: NSString;
function NSThisDayDesignations: NSString;
function NSNextDayDesignations: NSString;
function NSNextNextDayDesignations: NSString;
function NSPriorDayDesignations: NSString;
function NSDateTimeOrdering: NSString;
function NSInternationalCurrencyString: NSString;
function NSShortDateFormatString: NSString;
function NSPositiveCurrencyFormatString: NSString;
function NSNegativeCurrencyFormatString: NSString;
function NSNegateBooleanTransformerName: NSString;
function NSIsNilTransformerName: NSString;
function NSIsNotNilTransformerName: NSString;
function NSUnarchiveFromDataTransformerName: NSString;
function NSKeyedUnarchiveFromDataTransformerName: NSString;
function NSXMLParserErrorDomain: NSString;
function NSExtensionItemsAndErrorsKey: NSString;
function NSItemProviderPreferredImageSizeKey: NSString;
function NSExtensionJavaScriptPreprocessingResultsKey: NSString;
function NSItemProviderErrorDomain: NSString;
function NSExtensionItemAttributedTitleKey: NSString;
function NSExtensionItemAttributedContentTextKey: NSString;
function NSExtensionItemAttachmentsKey: NSString;
function NSLinguisticTagSchemeTokenType: NSString;
function NSLinguisticTagSchemeLexicalClass: NSString;
function NSLinguisticTagSchemeNameType: NSString;
function NSLinguisticTagSchemeNameTypeOrLexicalClass: NSString;
function NSLinguisticTagSchemeLemma: NSString;
function NSLinguisticTagSchemeLanguage: NSString;
function NSLinguisticTagSchemeScript: NSString;
function NSLinguisticTagWord: NSString;
function NSLinguisticTagPunctuation: NSString;
function NSLinguisticTagWhitespace: NSString;
function NSLinguisticTagOther: NSString;
function NSLinguisticTagNoun: NSString;
function NSLinguisticTagVerb: NSString;
function NSLinguisticTagAdjective: NSString;
function NSLinguisticTagAdverb: NSString;
function NSLinguisticTagPronoun: NSString;
function NSLinguisticTagDeterminer: NSString;
function NSLinguisticTagParticle: NSString;
function NSLinguisticTagPreposition: NSString;
function NSLinguisticTagNumber: NSString;
function NSLinguisticTagConjunction: NSString;
function NSLinguisticTagInterjection: NSString;
function NSLinguisticTagClassifier: NSString;
function NSLinguisticTagIdiom: NSString;
function NSLinguisticTagOtherWord: NSString;
function NSLinguisticTagSentenceTerminator: NSString;
function NSLinguisticTagOpenQuote: NSString;
function NSLinguisticTagCloseQuote: NSString;
function NSLinguisticTagOpenParenthesis: NSString;
function NSLinguisticTagCloseParenthesis: NSString;
function NSLinguisticTagWordJoiner: NSString;
function NSLinguisticTagDash: NSString;
function NSLinguisticTagOtherPunctuation: NSString;
function NSLinguisticTagParagraphBreak: NSString;
function NSLinguisticTagOtherWhitespace: NSString;
function NSLinguisticTagPersonalName: NSString;
function NSLinguisticTagPlaceName: NSString;
function NSLinguisticTagOrganizationName: NSString;
function NSMetadataItemFSNameKey: NSString;
function NSMetadataItemDisplayNameKey: NSString;
function NSMetadataItemURLKey: NSString;
function NSMetadataItemPathKey: NSString;
function NSMetadataItemFSSizeKey: NSString;
function NSMetadataItemFSCreationDateKey: NSString;
function NSMetadataItemFSContentChangeDateKey: NSString;
function NSMetadataItemContentTypeKey: NSString;
function NSMetadataItemContentTypeTreeKey: NSString;
function NSMetadataItemIsUbiquitousKey: NSString;
function NSMetadataUbiquitousItemHasUnresolvedConflictsKey: NSString;
function NSMetadataUbiquitousItemIsDownloadedKey: NSString;
function NSMetadataUbiquitousItemDownloadingStatusKey: NSString;
function NSMetadataUbiquitousItemDownloadingStatusNotDownloaded: NSString;
function NSMetadataUbiquitousItemDownloadingStatusDownloaded: NSString;
function NSMetadataUbiquitousItemDownloadingStatusCurrent: NSString;
function NSMetadataUbiquitousItemIsDownloadingKey: NSString;
function NSMetadataUbiquitousItemIsUploadedKey: NSString;
function NSMetadataUbiquitousItemIsUploadingKey: NSString;
function NSMetadataUbiquitousItemPercentDownloadedKey: NSString;
function NSMetadataUbiquitousItemPercentUploadedKey: NSString;
function NSMetadataUbiquitousItemDownloadingErrorKey: NSString;
function NSMetadataUbiquitousItemUploadingErrorKey: NSString;
function NSMetadataUbiquitousItemDownloadRequestedKey: NSString;
function NSMetadataUbiquitousItemIsExternalDocumentKey: NSString;
function NSMetadataUbiquitousItemContainerDisplayNameKey: NSString;
function NSMetadataUbiquitousItemURLInLocalContainerKey: NSString;
function NSMetadataItemAttributeChangeDateKey: NSString;
function NSMetadataItemKeywordsKey: NSString;
function NSMetadataItemTitleKey: NSString;
function NSMetadataItemAuthorsKey: NSString;
function NSMetadataItemEditorsKey: NSString;
function NSMetadataItemParticipantsKey: NSString;
function NSMetadataItemProjectsKey: NSString;
function NSMetadataItemDownloadedDateKey: NSString;
function NSMetadataItemWhereFromsKey: NSString;
function NSMetadataItemCommentKey: NSString;
function NSMetadataItemCopyrightKey: NSString;
function NSMetadataItemLastUsedDateKey: NSString;
function NSMetadataItemContentCreationDateKey: NSString;
function NSMetadataItemContentModificationDateKey: NSString;
function NSMetadataItemDateAddedKey: NSString;
function NSMetadataItemDurationSecondsKey: NSString;
function NSMetadataItemContactKeywordsKey: NSString;
function NSMetadataItemVersionKey: NSString;
function NSMetadataItemPixelHeightKey: NSString;
function NSMetadataItemPixelWidthKey: NSString;
function NSMetadataItemPixelCountKey: NSString;
function NSMetadataItemColorSpaceKey: NSString;
function NSMetadataItemBitsPerSampleKey: NSString;
function NSMetadataItemFlashOnOffKey: NSString;
function NSMetadataItemFocalLengthKey: NSString;
function NSMetadataItemAcquisitionMakeKey: NSString;
function NSMetadataItemAcquisitionModelKey: NSString;
function NSMetadataItemISOSpeedKey: NSString;
function NSMetadataItemOrientationKey: NSString;
function NSMetadataItemLayerNamesKey: NSString;
function NSMetadataItemWhiteBalanceKey: NSString;
function NSMetadataItemApertureKey: NSString;
function NSMetadataItemProfileNameKey: NSString;
function NSMetadataItemResolutionWidthDPIKey: NSString;
function NSMetadataItemResolutionHeightDPIKey: NSString;
function NSMetadataItemExposureModeKey: NSString;
function NSMetadataItemExposureTimeSecondsKey: NSString;
function NSMetadataItemEXIFVersionKey: NSString;
function NSMetadataItemCameraOwnerKey: NSString;
function NSMetadataItemFocalLength35mmKey: NSString;
function NSMetadataItemLensModelKey: NSString;
function NSMetadataItemEXIFGPSVersionKey: NSString;
function NSMetadataItemAltitudeKey: NSString;
function NSMetadataItemLatitudeKey: NSString;
function NSMetadataItemLongitudeKey: NSString;
function NSMetadataItemSpeedKey: NSString;
function NSMetadataItemTimestampKey: NSString;
function NSMetadataItemGPSTrackKey: NSString;
function NSMetadataItemImageDirectionKey: NSString;
function NSMetadataItemNamedLocationKey: NSString;
function NSMetadataItemGPSStatusKey: NSString;
function NSMetadataItemGPSMeasureModeKey: NSString;
function NSMetadataItemGPSDOPKey: NSString;
function NSMetadataItemGPSMapDatumKey: NSString;
function NSMetadataItemGPSDestLatitudeKey: NSString;
function NSMetadataItemGPSDestLongitudeKey: NSString;
function NSMetadataItemGPSDestBearingKey: NSString;
function NSMetadataItemGPSDestDistanceKey: NSString;
function NSMetadataItemGPSProcessingMethodKey: NSString;
function NSMetadataItemGPSAreaInformationKey: NSString;
function NSMetadataItemGPSDateStampKey: NSString;
function NSMetadataItemGPSDifferentalKey: NSString;
function NSMetadataItemCodecsKey: NSString;
function NSMetadataItemMediaTypesKey: NSString;
function NSMetadataItemStreamableKey: NSString;
function NSMetadataItemTotalBitRateKey: NSString;
function NSMetadataItemVideoBitRateKey: NSString;
function NSMetadataItemAudioBitRateKey: NSString;
function NSMetadataItemDeliveryTypeKey: NSString;
function NSMetadataItemAlbumKey: NSString;
function NSMetadataItemHasAlphaChannelKey: NSString;
function NSMetadataItemRedEyeOnOffKey: NSString;
function NSMetadataItemMeteringModeKey: NSString;
function NSMetadataItemMaxApertureKey: NSString;
function NSMetadataItemFNumberKey: NSString;
function NSMetadataItemExposureProgramKey: NSString;
function NSMetadataItemExposureTimeStringKey: NSString;
function NSMetadataItemHeadlineKey: NSString;
function NSMetadataItemInstructionsKey: NSString;
function NSMetadataItemCityKey: NSString;
function NSMetadataItemStateOrProvinceKey: NSString;
function NSMetadataItemCountryKey: NSString;
function NSMetadataItemTextContentKey: NSString;
function NSMetadataItemAudioSampleRateKey: NSString;
function NSMetadataItemAudioChannelCountKey: NSString;
function NSMetadataItemTempoKey: NSString;
function NSMetadataItemKeySignatureKey: NSString;
function NSMetadataItemTimeSignatureKey: NSString;
function NSMetadataItemAudioEncodingApplicationKey: NSString;
function NSMetadataItemComposerKey: NSString;
function NSMetadataItemLyricistKey: NSString;
function NSMetadataItemAudioTrackNumberKey: NSString;
function NSMetadataItemRecordingDateKey: NSString;
function NSMetadataItemMusicalGenreKey: NSString;
function NSMetadataItemIsGeneralMIDISequenceKey: NSString;
function NSMetadataItemRecordingYearKey: NSString;
function NSMetadataItemOrganizationsKey: NSString;
function NSMetadataItemLanguagesKey: NSString;
function NSMetadataItemRightsKey: NSString;
function NSMetadataItemPublishersKey: NSString;
function NSMetadataItemContributorsKey: NSString;
function NSMetadataItemCoverageKey: NSString;
function NSMetadataItemSubjectKey: NSString;
function NSMetadataItemThemeKey: NSString;
function NSMetadataItemDescriptionKey: NSString;
function NSMetadataItemIdentifierKey: NSString;
function NSMetadataItemAudiencesKey: NSString;
function NSMetadataItemNumberOfPagesKey: NSString;
function NSMetadataItemPageWidthKey: NSString;
function NSMetadataItemPageHeightKey: NSString;
function NSMetadataItemSecurityMethodKey: NSString;
function NSMetadataItemCreatorKey: NSString;
function NSMetadataItemEncodingApplicationsKey: NSString;
function NSMetadataItemDueDateKey: NSString;
function NSMetadataItemStarRatingKey: NSString;
function NSMetadataItemPhoneNumbersKey: NSString;
function NSMetadataItemEmailAddressesKey: NSString;
function NSMetadataItemInstantMessageAddressesKey: NSString;
function NSMetadataItemKindKey: NSString;
function NSMetadataItemRecipientsKey: NSString;
function NSMetadataItemFinderCommentKey: NSString;
function NSMetadataItemFontsKey: NSString;
function NSMetadataItemAppleLoopsRootKeyKey: NSString;
function NSMetadataItemAppleLoopsKeyFilterTypeKey: NSString;
function NSMetadataItemAppleLoopsLoopModeKey: NSString;
function NSMetadataItemAppleLoopDescriptorsKey: NSString;
function NSMetadataItemMusicalInstrumentCategoryKey: NSString;
function NSMetadataItemMusicalInstrumentNameKey: NSString;
function NSMetadataItemCFBundleIdentifierKey: NSString;
function NSMetadataItemInformationKey: NSString;
function NSMetadataItemDirectorKey: NSString;
function NSMetadataItemProducerKey: NSString;
function NSMetadataItemGenreKey: NSString;
function NSMetadataItemPerformersKey: NSString;
function NSMetadataItemOriginalFormatKey: NSString;
function NSMetadataItemOriginalSourceKey: NSString;
function NSMetadataItemAuthorEmailAddressesKey: NSString;
function NSMetadataItemRecipientEmailAddressesKey: NSString;
function NSMetadataItemAuthorAddressesKey: NSString;
function NSMetadataItemRecipientAddressesKey: NSString;
function NSMetadataItemIsLikelyJunkKey: NSString;
function NSMetadataItemExecutableArchitecturesKey: NSString;
function NSMetadataItemExecutablePlatformKey: NSString;
function NSMetadataItemApplicationCategoriesKey: NSString;
function NSMetadataItemIsApplicationManagedKey: NSString;
function NSMetadataQueryDidStartGatheringNotification: NSString;
function NSMetadataQueryGatheringProgressNotification: NSString;
function NSMetadataQueryDidFinishGatheringNotification: NSString;
function NSMetadataQueryDidUpdateNotification: NSString;
function NSMetadataQueryUpdateAddedItemsKey: NSString;
function NSMetadataQueryUpdateChangedItemsKey: NSString;
function NSMetadataQueryUpdateRemovedItemsKey: NSString;
function NSMetadataQueryResultContentRelevanceAttribute: NSString;
function NSMetadataQueryUserHomeScope: NSString;
function NSMetadataQueryLocalComputerScope: NSString;
function NSMetadataQueryNetworkScope: NSString;
function NSMetadataQueryIndexedLocalComputerScope: NSString;
function NSMetadataQueryIndexedNetworkScope: NSString;
function NSMetadataQueryUbiquitousDocumentsScope: NSString;
function NSMetadataQueryUbiquitousDataScope: NSString;
function NSMetadataQueryAccessibleUbiquitousExternalDocumentsScope: NSString;
function NSNetServicesErrorCode: NSString;
function NSNetServicesErrorDomain: NSString;
function NSProgressEstimatedTimeRemainingKey: NSString;
function NSProgressThroughputKey: NSString;
function NSProgressKindFile: NSString;
function NSProgressFileOperationKindKey: NSString;
function NSProgressFileOperationKindDownloading: NSString;
function NSProgressFileOperationKindDecompressingAfterDownloading: NSString;
function NSProgressFileOperationKindReceiving: NSString;
function NSProgressFileOperationKindCopying: NSString;
function NSProgressFileURLKey: NSString;
function NSProgressFileTotalCountKey: NSString;
function NSProgressFileCompletedCountKey: NSString;
function NSProgressFileAnimationImageKey: NSString;
function NSProgressFileAnimationImageOriginalRectKey: NSString;
function NSProgressFileIconKey: NSString;
function NSUbiquitousKeyValueStoreDidChangeExternallyNotification: NSString;
function NSUbiquitousKeyValueStoreChangeReasonKey: NSString;
function NSUbiquitousKeyValueStoreChangedKeysKey: NSString;
function NSUndoManagerGroupIsDiscardableKey: NSString;
function NSUndoManagerCheckpointNotification: NSString;
function NSUndoManagerWillUndoChangeNotification: NSString;
function NSUndoManagerWillRedoChangeNotification: NSString;
function NSUndoManagerDidUndoChangeNotification: NSString;
function NSUndoManagerDidRedoChangeNotification: NSString;
function NSUndoManagerDidOpenUndoGroupNotification: NSString;
function NSUndoManagerWillCloseUndoGroupNotification: NSString;
function NSUndoManagerDidCloseUndoGroupNotification: NSString;
function NSURLSessionTransferSizeUnknown: Pointer;
function NSURLSessionTaskPriorityDefault: Pointer;
function NSURLSessionTaskPriorityLow: Pointer;
function NSURLSessionTaskPriorityHigh: Pointer;
function NSURLSessionDownloadTaskResumeData: NSString;
function NSUserActivityTypeBrowsingWeb: NSString;
function NSInconsistentArchiveException: NSString;
function NSConnectionReplyMode: NSString;
function NSConnectionDidDieNotification: NSString;
function NSFailedAuthenticationException: NSString;
function NSConnectionDidInitializeNotification: NSString;
function NSLocalNotificationCenterType: NSString;
function NSTaskDidTerminateNotification: NSString;
function NSAppleEventTimeOutDefault: Pointer;
function NSAppleEventTimeOutNone: Pointer;
function NSAppleEventManagerWillProcessFirstEventNotification: NSString;
function NSAppleScriptErrorMessage: NSString;
function NSAppleScriptErrorNumber: NSString;
function NSAppleScriptErrorAppName: NSString;
function NSAppleScriptErrorBriefMessage: NSString;
function NSAppleScriptErrorRange: NSString;
function NSClassDescriptionNeededForClassNotification: NSString;
function NSOperationNotSupportedForKeyException: NSString;
function NSGrammarRange: NSString;
function NSGrammarUserDescription: NSString;
function NSGrammarCorrections: NSString;
function NSUserNotificationDefaultSoundName: NSString;
function NSDebugEnabled: Pointer;
function NSZombieEnabled: Pointer;
function NSDeallocateZombies: Pointer;
function NSKeepAllocationStatistics: Pointer;


// Convenience method for creating an NSString from a Delphi Unicode string
function NSSTR(const Str: string): NSString; deprecated 'use StrToNSStr instead';

// Utility method for loading an integer constant from a framework
function CocoaIntegerConst(const Fwk: string; const ConstStr: string): Integer;

// Utility method for loading an pointer constant from a framework
function CocoaPointerConst(const Fwk: string; const ConstStr: string): Pointer;

// Utility method for loading an NSString constant from a framework
function CocoaNSStringConst(const Fwk: string; const ConstStr: string): NSString;

// Utility method to check if an NSObject is an instance from the NSClass or its parents
function NSInheritsFrom(const AObject: NSObject; const AClass: NSObjectClass): Boolean;

const
  libFoundation = '/System/Library/Frameworks/Foundation.framework/Foundation';


// ===== External functions =====

function NSStringFromSelector(aSelector: SEL): Pointer {NSString}; cdecl;
  external libFoundation name _PU + 'NSStringFromSelector';
function NSSelectorFromString(aSelectorName: Pointer {NSString}): SEL; cdecl;
  external libFoundation name _PU + 'NSSelectorFromString';
function NSStringFromClass(aClass: Pointer): Pointer {NSString}; cdecl;
  external libFoundation name _PU + 'NSStringFromClass';
function NSClassFromString(aClassName: Pointer {NSString}): Pointer; cdecl;
  external libFoundation name _PU + 'NSClassFromString';
function NSStringFromProtocol(proto: Pointer {Pointer}): Pointer {NSString}; cdecl;
  external libFoundation name _PU + 'NSStringFromProtocol';
function NSProtocolFromString(namestr: Pointer {NSString}): Pointer {Pointer}; cdecl;
  external libFoundation name _PU + 'NSProtocolFromString';
function NSGetSizeAndAlignment(typePtr: MarshaledAString; sizep: NSUInteger; alignp: NSUInteger): MarshaledAString;
  cdecl; external libFoundation name _PU + 'NSGetSizeAndAlignment';
function NSDefaultMallocZone: Pointer; cdecl; external libFoundation name _PU + 'NSDefaultMallocZone';
function NSCreateZone(startSize: NSUInteger; granularity: NSUInteger; canFree: Boolean): Pointer; cdecl;
  external libFoundation name _PU + 'NSCreateZone';
procedure NSRecycleZone(zone: Pointer); cdecl; external libFoundation name _PU + 'NSRecycleZone';
procedure NSSetZoneName(zone: Pointer; name: Pointer {NSString}); cdecl;
  external libFoundation name _PU + 'NSSetZoneName';
function NSZoneName(zone: Pointer): Pointer {NSString}; cdecl; external libFoundation name _PU + 'NSZoneName';
function NSZoneFromPointer(ptr: Pointer): Pointer; cdecl; external libFoundation name _PU + 'NSZoneFromPointer';
function NSZoneMalloc(zone: Pointer; size: NSUInteger): Pointer; cdecl;
  external libFoundation name _PU + 'NSZoneMalloc';
function NSZoneCalloc(zone: Pointer; numElems: NSUInteger; byteSize: NSUInteger): Pointer; cdecl;
  external libFoundation name _PU + 'NSZoneCalloc';
function NSZoneRealloc(zone: Pointer; ptr: Pointer; size: NSUInteger): Pointer; cdecl;
  external libFoundation name _PU + 'NSZoneRealloc';
procedure NSZoneFree(zone: Pointer; ptr: Pointer); cdecl; external libFoundation name _PU + 'NSZoneFree';
function NSAllocateCollectable(size: NSUInteger; options: NSUInteger): Pointer; cdecl;
  external libFoundation name _PU + 'NSAllocateCollectable';
function NSReallocateCollectable(ptr: Pointer; size: NSUInteger; options: NSUInteger): Pointer; cdecl;
  external libFoundation name _PU + 'NSReallocateCollectable';
function NSMakeCollectable(cf: CFTypeRef): Pointer; cdecl; external libFoundation name _PU + 'NSMakeCollectable';
function NSPageSize: NSUInteger; cdecl; external libFoundation name _PU + 'NSPageSize';
function NSLogPageSize: NSUInteger; cdecl; external libFoundation name _PU + 'NSLogPageSize';
function NSRoundUpToMultipleOfPageSize(bytes: NSUInteger): NSUInteger; cdecl;
  external libFoundation name _PU + 'NSRoundUpToMultipleOfPageSize';
function NSRoundDownToMultipleOfPageSize(bytes: NSUInteger): NSUInteger; cdecl;
  external libFoundation name _PU + 'NSRoundDownToMultipleOfPageSize';
function NSAllocateMemoryPages(bytes: NSUInteger): Pointer; cdecl;
  external libFoundation name _PU + 'NSAllocateMemoryPages';
procedure NSDeallocateMemoryPages(ptr: Pointer; bytes: NSUInteger); cdecl;
  external libFoundation name _PU + 'NSDeallocateMemoryPages';
procedure NSCopyMemoryPages(source: Pointer; dest: Pointer; bytes: NSUInteger); cdecl;
  external libFoundation name _PU + 'NSCopyMemoryPages';
function NSRealMemoryAvailable: NSUInteger; cdecl; external libFoundation name _PU + 'NSRealMemoryAvailable';
function NSAllocateObject(aClass: Pointer; extraBytes: NSUInteger; zone: Pointer): Pointer; cdecl;
  external libFoundation name _PU + 'NSAllocateObject';
procedure NSDeallocateObject(&object: Pointer); cdecl; external libFoundation name _PU + 'NSDeallocateObject';
function NSCopyObject(&object: Pointer; extraBytes: NSUInteger; zone: Pointer): Pointer; cdecl;
  external libFoundation name _PU + 'NSCopyObject';
function NSShouldRetainWithZone(anObject: Pointer; requestedZone: Pointer): Boolean; cdecl;
  external libFoundation name _PU + 'NSShouldRetainWithZone';
procedure NSIncrementExtraRefCount(&object: Pointer); cdecl;
  external libFoundation name _PU + 'NSIncrementExtraRefCount';
function NSDecrementExtraRefCountWasZero(&object: Pointer): Boolean; cdecl;
  external libFoundation name _PU + 'NSDecrementExtraRefCountWasZero';
function NSExtraRefCount(&object: Pointer): NSUInteger; cdecl; external libFoundation name _PU + 'NSExtraRefCount';
function CFBridgingRetain(X: Pointer): CFTypeRef; cdecl; external libFoundation name _PU + 'CFBridgingRetain';
function CFBridgingRelease(X: CFTypeRef): Pointer; cdecl; external libFoundation name _PU + 'CFBridgingRelease';
function NSMakeRange(loc: NSUInteger; len: NSUInteger): NSRange; cdecl; external libFoundation name _PU + 'NSMakeRange';
function NSMaxRange(range: NSRange): NSUInteger; cdecl; external libFoundation name _PU + 'NSMaxRange';
function NSLocationInRange(loc: NSUInteger; range: NSRange): Boolean; cdecl;
  external libFoundation name _PU + 'NSLocationInRange';
function NSEqualRanges(range1: NSRange; range2: NSRange): Boolean; cdecl;
  external libFoundation name _PU + 'NSEqualRanges';
function NSUnionRange(range1: NSRange; range2: NSRange): NSRange; cdecl;
  external libFoundation name _PU + 'NSUnionRange';
function NSIntersectionRange(range1: NSRange; range2: NSRange): NSRange; cdecl;
  external libFoundation name _PU + 'NSIntersectionRange';
function NSStringFromRange(range: NSRange): Pointer {NSString}; cdecl;
  external libFoundation name _PU + 'NSStringFromRange';
function NSRangeFromString(aString: Pointer {NSString}): NSRange; cdecl;
  external libFoundation name _PU + 'NSRangeFromString';
function NSHostByteOrder: LongInt; cdecl; external libFoundation name _PU + 'NSHostByteOrder';
function NSSwapShort(inv: Word): Word; cdecl; external libFoundation name _PU + 'NSSwapShort';
function NSSwapInt(inv: Cardinal): Cardinal; cdecl; external libFoundation name _PU + 'NSSwapInt';
function NSSwapLong(inv: LongWord): LongWord; cdecl; external libFoundation name _PU + 'NSSwapLong';
function NSSwapLongLong(inv: UInt64): UInt64; cdecl; external libFoundation name _PU + 'NSSwapLongLong';
function NSSwapBigShortToHost(X: Word): Word; cdecl; external libFoundation name _PU + 'NSSwapBigShortToHost';
function NSSwapBigIntToHost(X: Cardinal): Cardinal; cdecl; external libFoundation name _PU + 'NSSwapBigIntToHost';
function NSSwapBigLongToHost(X: LongWord): LongWord; cdecl; external libFoundation name _PU + 'NSSwapBigLongToHost';
function NSSwapBigLongLongToHost(X: UInt64): UInt64; cdecl; external libFoundation name _PU + 'NSSwapBigLongLongToHost';
function NSSwapHostShortToBig(X: Word): Word; cdecl; external libFoundation name _PU + 'NSSwapHostShortToBig';
function NSSwapHostIntToBig(X: Cardinal): Cardinal; cdecl; external libFoundation name _PU + 'NSSwapHostIntToBig';
function NSSwapHostLongToBig(X: LongWord): LongWord; cdecl; external libFoundation name _PU + 'NSSwapHostLongToBig';
function NSSwapHostLongLongToBig(X: UInt64): UInt64; cdecl; external libFoundation name _PU + 'NSSwapHostLongLongToBig';
function NSSwapLittleShortToHost(X: Word): Word; cdecl; external libFoundation name _PU + 'NSSwapLittleShortToHost';
function NSSwapLittleIntToHost(X: Cardinal): Cardinal; cdecl; external libFoundation name _PU + 'NSSwapLittleIntToHost';
function NSSwapLittleLongToHost(X: LongWord): LongWord; cdecl;
  external libFoundation name _PU + 'NSSwapLittleLongToHost';
function NSSwapLittleLongLongToHost(X: UInt64): UInt64; cdecl;
  external libFoundation name _PU + 'NSSwapLittleLongLongToHost';
function NSSwapHostShortToLittle(X: Word): Word; cdecl; external libFoundation name _PU + 'NSSwapHostShortToLittle';
function NSSwapHostIntToLittle(X: Cardinal): Cardinal; cdecl; external libFoundation name _PU + 'NSSwapHostIntToLittle';
function NSSwapHostLongToLittle(X: LongWord): LongWord; cdecl;
  external libFoundation name _PU + 'NSSwapHostLongToLittle';
function NSSwapHostLongLongToLittle(X: UInt64): UInt64; cdecl;
  external libFoundation name _PU + 'NSSwapHostLongLongToLittle';
function NSConvertHostFloatToSwapped(X: Single): NSSwappedFloat; cdecl;
  external libFoundation name _PU + 'NSConvertHostFloatToSwapped';
function NSConvertSwappedFloatToHost(X: NSSwappedFloat): Single; cdecl;
  external libFoundation name _PU + 'NSConvertSwappedFloatToHost';
function NSConvertHostDoubleToSwapped(X: Double): NSSwappedDouble; cdecl;
  external libFoundation name _PU + 'NSConvertHostDoubleToSwapped';
function NSConvertSwappedDoubleToHost(X: NSSwappedDouble): Double; cdecl;
  external libFoundation name _PU + 'NSConvertSwappedDoubleToHost';
function NSSwapFloat(X: NSSwappedFloat): NSSwappedFloat; cdecl; external libFoundation name _PU + 'NSSwapFloat';
function NSSwapDouble(X: NSSwappedDouble): NSSwappedDouble; cdecl; external libFoundation name _PU + 'NSSwapDouble';
function NSSwapBigDoubleToHost(X: NSSwappedDouble): Double; cdecl;
  external libFoundation name _PU + 'NSSwapBigDoubleToHost';
function NSSwapBigFloatToHost(X: NSSwappedFloat): Single; cdecl;
  external libFoundation name _PU + 'NSSwapBigFloatToHost';
function NSSwapHostDoubleToBig(X: Double): NSSwappedDouble; cdecl;
  external libFoundation name _PU + 'NSSwapHostDoubleToBig';
function NSSwapHostFloatToBig(X: Single): NSSwappedFloat; cdecl;
  external libFoundation name _PU + 'NSSwapHostFloatToBig';
function NSSwapLittleDoubleToHost(X: NSSwappedDouble): Double; cdecl;
  external libFoundation name _PU + 'NSSwapLittleDoubleToHost';
function NSSwapLittleFloatToHost(X: NSSwappedFloat): Single; cdecl;
  external libFoundation name _PU + 'NSSwapLittleFloatToHost';
function NSSwapHostDoubleToLittle(X: Double): NSSwappedDouble; cdecl;
  external libFoundation name _PU + 'NSSwapHostDoubleToLittle';
function NSSwapHostFloatToLittle(X: Single): NSSwappedFloat; cdecl;
  external libFoundation name _PU + 'NSSwapHostFloatToLittle';
function NXReadNSObjectFromCoder(decoder: Pointer {NSCoder}): Pointer {NSObject}; cdecl;
  external libFoundation name _PU + 'NXReadNSObjectFromCoder';
function NSDecimalIsNotANumber(dcm: Pointer): Boolean; cdecl; external libFoundation name _PU + 'NSDecimalIsNotANumber';
procedure NSDecimalCopy(destination: Pointer; source: Pointer); cdecl;
  external libFoundation name _PU + 'NSDecimalCopy';
procedure NSDecimalCompact(number: Pointer); cdecl; external libFoundation name _PU + 'NSDecimalCompact';
function NSDecimalCompare(leftOperand: Pointer; rightOperand: Pointer): NSComparisonResult; cdecl;
  external libFoundation name _PU + 'NSDecimalCompare';
procedure NSDecimalRound(result: Pointer; number: Pointer; scale: NSInteger; roundingMode: NSRoundingMode); cdecl;
  external libFoundation name _PU + 'NSDecimalRound';
function NSDecimalNormalize(number1: Pointer; number2: Pointer; roundingMode: NSRoundingMode): NSCalculationError;
  cdecl; external libFoundation name _PU + 'NSDecimalNormalize';
function NSDecimalAdd(result: Pointer; leftOperand: Pointer; rightOperand: Pointer; roundingMode: NSRoundingMode)
  : NSCalculationError; cdecl; external libFoundation name _PU + 'NSDecimalAdd';
function NSDecimalSubtract(result: Pointer; leftOperand: Pointer; rightOperand: Pointer; roundingMode: NSRoundingMode)
  : NSCalculationError; cdecl; external libFoundation name _PU + 'NSDecimalSubtract';
function NSDecimalMultiply(result: Pointer; leftOperand: Pointer; rightOperand: Pointer; roundingMode: NSRoundingMode)
  : NSCalculationError; cdecl; external libFoundation name _PU + 'NSDecimalMultiply';
function NSDecimalDivide(result: Pointer; leftOperand: Pointer; rightOperand: Pointer; roundingMode: NSRoundingMode)
  : NSCalculationError; cdecl; external libFoundation name _PU + 'NSDecimalDivide';
function NSDecimalPower(result: Pointer; number: Pointer; power: NSUInteger; roundingMode: NSRoundingMode)
  : NSCalculationError; cdecl; external libFoundation name _PU + 'NSDecimalPower';
function NSDecimalMultiplyByPowerOf10(result: Pointer; number: Pointer; power: SmallInt; roundingMode: NSRoundingMode)
  : NSCalculationError; cdecl; external libFoundation name _PU + 'NSDecimalMultiplyByPowerOf10';
function NSDecimalString(dcm: Pointer; locale: Pointer): Pointer {NSString}; cdecl;
  external libFoundation name _PU + 'NSDecimalString';
function NSGetUncaughtExceptionHandler: TFoundationNSGetUncaughtExceptionHandler; cdecl;
  external libFoundation name _PU + 'NSGetUncaughtExceptionHandler';
procedure NSSetUncaughtExceptionHandler(param1: TFoundationNSGetUncaughtExceptionHandler); cdecl;
  external libFoundation name _PU + 'NSSetUncaughtExceptionHandler';
function NSUserName: Pointer {NSString}; cdecl; external libFoundation name _PU + 'NSUserName';
function NSFullUserName: Pointer {NSString}; cdecl; external libFoundation name _PU + 'NSFullUserName';
function NSHomeDirectory: Pointer {NSString}; cdecl; external libFoundation name _PU + 'NSHomeDirectory';
function NSHomeDirectoryForUser(username: Pointer {NSString}): Pointer {NSString}; cdecl;
  external libFoundation name _PU + 'NSHomeDirectoryForUser';
function NSTemporaryDirectory: Pointer {NSString}; cdecl; external libFoundation name _PU + 'NSTemporaryDirectory';
function NSOpenStepRootDirectory: Pointer {NSString}; cdecl;
  external libFoundation name _PU + 'NSOpenStepRootDirectory';
function NSSearchPathForDirectoriesInDomains(directory: NSSearchPathDirectory; domainMask: NSSearchPathDomainMask;
  expandTilde: Boolean): Pointer {NSArray}; cdecl;
  external libFoundation name _PU + 'NSSearchPathForDirectoriesInDomains';
procedure NSFreeHashTable(table: Pointer {NSHashTable}); cdecl; external libFoundation name _PU + 'NSFreeHashTable';
procedure NSResetHashTable(table: Pointer {NSHashTable}); cdecl; external libFoundation name _PU + 'NSResetHashTable';
function NSCompareHashTables(table1: Pointer {NSHashTable}; table2: Pointer {NSHashTable}): Boolean; cdecl;
  external libFoundation name _PU + 'NSCompareHashTables';
function NSCopyHashTableWithZone(table: Pointer {NSHashTable}; zone: Pointer): Pointer {NSHashTable}; cdecl;
  external libFoundation name _PU + 'NSCopyHashTableWithZone';
function NSHashGet(table: Pointer {NSHashTable}; Pointer: Pointer): Pointer; cdecl;
  external libFoundation name _PU + 'NSHashGet';
procedure NSHashInsert(table: Pointer {NSHashTable}; Pointer: Pointer); cdecl;
  external libFoundation name _PU + 'NSHashInsert';
procedure NSHashInsertKnownAbsent(table: Pointer {NSHashTable}; Pointer: Pointer); cdecl;
  external libFoundation name _PU + 'NSHashInsertKnownAbsent';
function NSHashInsertIfAbsent(table: Pointer {NSHashTable}; Pointer: Pointer): Pointer; cdecl;
  external libFoundation name _PU + 'NSHashInsertIfAbsent';
procedure NSHashRemove(table: Pointer {NSHashTable}; Pointer: Pointer); cdecl;
  external libFoundation name _PU + 'NSHashRemove';
function NSEnumerateHashTable(table: Pointer {NSHashTable}): NSHashEnumerator; cdecl;
  external libFoundation name _PU + 'NSEnumerateHashTable';
function NSNextHashEnumeratorItem(enumerator: Pointer): Pointer; cdecl;
  external libFoundation name _PU + 'NSNextHashEnumeratorItem';
procedure NSEndHashTableEnumeration(enumerator: Pointer); cdecl;
  external libFoundation name _PU + 'NSEndHashTableEnumeration';
function NSCountHashTable(table: Pointer {NSHashTable}): NSUInteger; cdecl;
  external libFoundation name _PU + 'NSCountHashTable';
function NSStringFromHashTable(table: Pointer {NSHashTable}): Pointer {NSString}; cdecl;
  external libFoundation name _PU + 'NSStringFromHashTable';
function NSAllHashTableObjects(table: Pointer {NSHashTable}): Pointer {NSArray}; cdecl;
  external libFoundation name _PU + 'NSAllHashTableObjects';
function NSCreateHashTableWithZone(callBacks: NSHashTableCallBacks; capacity: NSUInteger; zone: Pointer)
  : Pointer {NSHashTable}; cdecl; external libFoundation name _PU + 'NSCreateHashTableWithZone';
function NSCreateHashTable(callBacks: NSHashTableCallBacks; capacity: NSUInteger): Pointer {NSHashTable}; cdecl;
  external libFoundation name _PU + 'NSCreateHashTable';
function NSMakePoint(X: CGFloat; y: CGFloat): NSPoint; cdecl; external libFoundation name _PU + 'NSMakePoint';
function NSMakeSize(w: CGFloat; h: CGFloat): NSSize; cdecl; external libFoundation name _PU + 'NSMakeSize';
function NSMakeRect(X: CGFloat; y: CGFloat; w: CGFloat; h: CGFloat): NSRect; cdecl;
  external libFoundation name _PU + 'NSMakeRect';
function NSMaxX(aRect: NSRect): CGFloat; cdecl; external libFoundation name _PU + 'NSMaxX';
function NSMaxY(aRect: NSRect): CGFloat; cdecl; external libFoundation name _PU + 'NSMaxY';
function NSMidX(aRect: NSRect): CGFloat; cdecl; external libFoundation name _PU + 'NSMidX';
function NSMidY(aRect: NSRect): CGFloat; cdecl; external libFoundation name _PU + 'NSMidY';
function NSMinX(aRect: NSRect): CGFloat; cdecl; external libFoundation name _PU + 'NSMinX';
function NSMinY(aRect: NSRect): CGFloat; cdecl; external libFoundation name _PU + 'NSMinY';
function NSWidth(aRect: NSRect): CGFloat; cdecl; external libFoundation name _PU + 'NSWidth';
function NSHeight(aRect: NSRect): CGFloat; cdecl; external libFoundation name _PU + 'NSHeight';
function NSRectFromCGRect(CGRect: CGRect): NSRect; cdecl; external libFoundation name _PU + 'NSRectFromCGRect';
function NSRectToCGRect(NSRect: NSRect): CGRect; cdecl; external libFoundation name _PU + 'NSRectToCGRect';
function NSPointFromCGPoint(CGPoint: CGPoint): NSPoint; cdecl; external libFoundation name _PU + 'NSPointFromCGPoint';
function NSPointToCGPoint(NSPoint: NSPoint): CGPoint; cdecl; external libFoundation name _PU + 'NSPointToCGPoint';
function NSSizeFromCGSize(CGSize: CGSize): NSSize; cdecl; external libFoundation name _PU + 'NSSizeFromCGSize';
function NSSizeToCGSize(NSSize: NSSize): CGSize; cdecl; external libFoundation name _PU + 'NSSizeToCGSize';
function NSEdgeInsetsMake(top: CGFloat; left: CGFloat; bottom: CGFloat; right: CGFloat): NSEdgeInsets; cdecl;
  external libFoundation name _PU + 'NSEdgeInsetsMake';
function NSEqualPoints(aPoint: NSPoint; bPoint: NSPoint): Boolean; cdecl;
  external libFoundation name _PU + 'NSEqualPoints';
function NSEqualSizes(aSize: NSSize; bSize: NSSize): Boolean; cdecl; external libFoundation name _PU + 'NSEqualSizes';
function NSEqualRects(aRect: NSRect; bRect: NSRect): Boolean; cdecl; external libFoundation name _PU + 'NSEqualRects';
function NSIsEmptyRect(aRect: NSRect): Boolean; cdecl; external libFoundation name _PU + 'NSIsEmptyRect';
function NSEdgeInsetsEqual(aInsets: NSEdgeInsets; bInsets: NSEdgeInsets): Boolean; cdecl;
  external libFoundation name _PU + 'NSEdgeInsetsEqual';
function NSInsetRect(aRect: NSRect; dX: CGFloat; dY: CGFloat): NSRect; cdecl;
  external libFoundation name _PU + 'NSInsetRect';
function NSIntegralRect(aRect: NSRect): NSRect; cdecl; external libFoundation name _PU + 'NSIntegralRect';
function NSIntegralRectWithOptions(aRect: NSRect; opts: NSAlignmentOptions): NSRect; cdecl;
  external libFoundation name _PU + 'NSIntegralRectWithOptions';
function NSUnionRect(aRect: NSRect; bRect: NSRect): NSRect; cdecl; external libFoundation name _PU + 'NSUnionRect';
function NSIntersectionRect(aRect: NSRect; bRect: NSRect): NSRect; cdecl;
  external libFoundation name _PU + 'NSIntersectionRect';
function NSOffsetRect(aRect: NSRect; dX: CGFloat; dY: CGFloat): NSRect; cdecl;
  external libFoundation name _PU + 'NSOffsetRect';
procedure NSDivideRect(inRect: NSRect; slice: Pointer; rem: Pointer; amount: CGFloat; edge: NSRectEdge); cdecl;
  external libFoundation name _PU + 'NSDivideRect';
function NSPointInRect(aPoint: NSPoint; aRect: NSRect): Boolean; cdecl;
  external libFoundation name _PU + 'NSPointInRect';
function NSMouseInRect(aPoint: NSPoint; aRect: NSRect; flipped: Boolean): Boolean; cdecl;
  external libFoundation name _PU + 'NSMouseInRect';
function NSContainsRect(aRect: NSRect; bRect: NSRect): Boolean; cdecl;
  external libFoundation name _PU + 'NSContainsRect';
function NSIntersectsRect(aRect: NSRect; bRect: NSRect): Boolean; cdecl;
  external libFoundation name _PU + 'NSIntersectsRect';
function NSStringFromPoint(aPoint: NSPoint): Pointer {NSString}; cdecl;
  external libFoundation name _PU + 'NSStringFromPoint';
function NSStringFromSize(aSize: NSSize): Pointer {NSString}; cdecl;
  external libFoundation name _PU + 'NSStringFromSize';
function NSStringFromRect(aRect: NSRect): Pointer {NSString}; cdecl;
  external libFoundation name _PU + 'NSStringFromRect';
function NSPointFromString(aString: Pointer {NSString}): NSPoint; cdecl;
  external libFoundation name _PU + 'NSPointFromString';
function NSSizeFromString(aString: Pointer {NSString}): NSSize; cdecl;
  external libFoundation name _PU + 'NSSizeFromString';
function NSRectFromString(aString: Pointer {NSString}): NSRect; cdecl;
  external libFoundation name _PU + 'NSRectFromString';
procedure NSFreeMapTable(table: Pointer {NSMapTable}); cdecl; external libFoundation name _PU + 'NSFreeMapTable';
procedure NSResetMapTable(table: Pointer {NSMapTable}); cdecl; external libFoundation name _PU + 'NSResetMapTable';
function NSCompareMapTables(table1: Pointer {NSMapTable}; table2: Pointer {NSMapTable}): Boolean; cdecl;
  external libFoundation name _PU + 'NSCompareMapTables';
function NSCopyMapTableWithZone(table: Pointer {NSMapTable}; zone: Pointer): Pointer {NSMapTable}; cdecl;
  external libFoundation name _PU + 'NSCopyMapTableWithZone';
function NSMapMember(table: Pointer {NSMapTable}; key: Pointer; originalKey: Pointer; value: Pointer): Boolean; cdecl;
  external libFoundation name _PU + 'NSMapMember';
function NSMapGet(table: Pointer {NSMapTable}; key: Pointer): Pointer; cdecl;
  external libFoundation name _PU + 'NSMapGet';
procedure NSMapInsert(table: Pointer {NSMapTable}; key: Pointer; value: Pointer); cdecl;
  external libFoundation name _PU + 'NSMapInsert';
procedure NSMapInsertKnownAbsent(table: Pointer {NSMapTable}; key: Pointer; value: Pointer); cdecl;
  external libFoundation name _PU + 'NSMapInsertKnownAbsent';
function NSMapInsertIfAbsent(table: Pointer {NSMapTable}; key: Pointer; value: Pointer): Pointer; cdecl;
  external libFoundation name _PU + 'NSMapInsertIfAbsent';
procedure NSMapRemove(table: Pointer {NSMapTable}; key: Pointer); cdecl;
  external libFoundation name _PU + 'NSMapRemove';
function NSEnumerateMapTable(table: Pointer {NSMapTable}): NSMapEnumerator; cdecl;
  external libFoundation name _PU + 'NSEnumerateMapTable';
function NSNextMapEnumeratorPair(enumerator: Pointer; key: Pointer; value: Pointer): Boolean; cdecl;
  external libFoundation name _PU + 'NSNextMapEnumeratorPair';
procedure NSEndMapTableEnumeration(enumerator: Pointer); cdecl;
  external libFoundation name _PU + 'NSEndMapTableEnumeration';
function NSCountMapTable(table: Pointer {NSMapTable}): NSUInteger; cdecl;
  external libFoundation name _PU + 'NSCountMapTable';
function NSStringFromMapTable(table: Pointer {NSMapTable}): Pointer {NSString}; cdecl;
  external libFoundation name _PU + 'NSStringFromMapTable';
function NSAllMapTableKeys(table: Pointer {NSMapTable}): Pointer {NSArray}; cdecl;
  external libFoundation name _PU + 'NSAllMapTableKeys';
function NSAllMapTableValues(table: Pointer {NSMapTable}): Pointer {NSArray}; cdecl;
  external libFoundation name _PU + 'NSAllMapTableValues';
function NSCreateMapTableWithZone(keyCallBacks: NSMapTableKeyCallBacks; valueCallBacks: NSMapTableValueCallBacks;
  capacity: NSUInteger; zone: Pointer): Pointer {NSMapTable}; cdecl;
  external libFoundation name _PU + 'NSCreateMapTableWithZone';
function NSCreateMapTable(keyCallBacks: NSMapTableKeyCallBacks; valueCallBacks: NSMapTableValueCallBacks;
  capacity: NSUInteger): Pointer {NSMapTable}; cdecl; external libFoundation name _PU + 'NSCreateMapTable';
function NSFileTypeForHFSTypeCode(hfsFileTypeCode: OSType): Pointer {NSString}; cdecl;
  external libFoundation name _PU + 'NSFileTypeForHFSTypeCode';
function NSHFSTypeCodeFromFileType(fileTypeString: Pointer {NSString}): OSType; cdecl;
  external libFoundation name _PU + 'NSHFSTypeCodeFromFileType';
function NSHFSTypeOfFile(fullFilePath: Pointer {NSString}): Pointer {NSString}; cdecl;
  external libFoundation name _PU + 'NSHFSTypeOfFile';
function NSIsFreedObject(anObject: Pointer): Boolean; cdecl; external libFoundation name _PU + 'NSIsFreedObject';
function NSFrameAddress(frame: NSUInteger): Pointer; cdecl; external libFoundation name _PU + 'NSFrameAddress';
function NSReturnAddress(frame: NSUInteger): Pointer; cdecl; external libFoundation name _PU + 'NSReturnAddress';
function NSCountFrames: NSUInteger; cdecl; external libFoundation name _PU + 'NSCountFrames';
procedure NSRecordAllocationEvent(eventType: Integer; &object: Pointer); cdecl;
  external libFoundation name _PU + 'NSRecordAllocationEvent';



implementation

uses
  Posix.Dlfcn, System.SysUtils, System.Generics.Collections;

var
  FrameworkDic: TDictionary<string, THandle>;

function NSSTR(const Str: string): NSString;
begin
    Result := TNSString.Wrap(TNSString.OCClass.stringWithCharacters(PChar(Str),Str.Length));
end;

procedure FreeFrameworkDic;
var
  Fwk: THandle;
begin
  if FrameworkDic <> nil then
  begin
    for Fwk in FrameworkDic.Values do
      FreeLibrary(Fwk);
    FrameworkDic.Free;
  end;
end;

function CocoaIntegerConst(const Fwk: string; const ConstStr: string): Integer;
var
  Obj: Pointer;
begin
  Obj := CocoaPointerConst(Fwk, ConstStr);
  if Obj <> nil then
    Result := Integer(Obj^)
  else
    Result := 0;
end;

function CocoaPointerConst(const Fwk: string; const ConstStr: string): Pointer;
var
  FrameworkMod: HMODULE;
begin
  if FrameworkDic = nil then
    FrameworkDic := TDictionary<string, THandle>.Create;

  Result := nil;
  FrameworkMod := 0;

  TMonitor.Enter(FrameworkDic);
  try
    if not FrameworkDic.TryGetValue(Fwk, FrameworkMod) then
    begin
      FrameworkMod := LoadLibrary(PWideChar(Fwk));
      FrameworkDic.Add(Fwk, FrameworkMod);
    end;
  finally
    TMonitor.Exit(FrameworkDic);
  end;

  if FrameworkMod <> 0 then
    Result := GetProcAddress(FrameworkMod, PWideChar(ConstStr));
end;

function CocoaNSStringConst(const Fwk: string; const ConstStr: string): NSString;
var
  Obj: Pointer;
begin
  Obj := Pointer(CocoaPointerConst(Fwk, ConstStr)^);
  if Obj <> nil then
    Result := TNSString.Wrap(Obj)
  else
    Result := nil;
end;

function NSInheritsFrom(const AObject: NSObject; const AClass: NSObjectClass): Boolean;
begin
  Result := AObject.isKindOfClass((AClass as ILocalObject).GetObjectID);
end;

function NSBundleDidLoadNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSBundleDidLoadNotification');
end;

function NSLoadedClasses: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLoadedClasses');
end;

function NSSystemClockDidChangeNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSSystemClockDidChangeNotification');
end;

function NSCalendarIdentifierGregorian: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierGregorian');
end;

function NSCalendarIdentifierBuddhist: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierBuddhist');
end;

function NSCalendarIdentifierChinese: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierChinese');
end;

function NSCalendarIdentifierCoptic: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierCoptic');
end;

function NSCalendarIdentifierEthiopicAmeteMihret: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierEthiopicAmeteMihret');
end;

function NSCalendarIdentifierEthiopicAmeteAlem: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierEthiopicAmeteAlem');
end;

function NSCalendarIdentifierHebrew: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierHebrew');
end;

function NSCalendarIdentifierISO8601: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierISO8601');
end;

function NSCalendarIdentifierIndian: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierIndian');
end;

function NSCalendarIdentifierIslamic: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierIslamic');
end;

function NSCalendarIdentifierIslamicCivil: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierIslamicCivil');
end;

function NSCalendarIdentifierJapanese: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierJapanese');
end;

function NSCalendarIdentifierPersian: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierPersian');
end;

function NSCalendarIdentifierRepublicOfChina: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierRepublicOfChina');
end;

function NSCalendarIdentifierIslamicTabular: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierIslamicTabular');
end;

function NSCalendarIdentifierIslamicUmmAlQura: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarIdentifierIslamicUmmAlQura');
end;

function NSCalendarDayChangedNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCalendarDayChangedNotification');
end;

function NSParseErrorException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSParseErrorException');
end;

function NSCharacterConversionException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCharacterConversionException');
end;

function NSStringEncodingDetectionSuggestedEncodingsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStringEncodingDetectionSuggestedEncodingsKey');
end;

function NSStringEncodingDetectionDisallowedEncodingsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStringEncodingDetectionDisallowedEncodingsKey');
end;

function NSStringEncodingDetectionUseOnlySuggestedEncodingsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStringEncodingDetectionUseOnlySuggestedEncodingsKey');
end;

function NSStringEncodingDetectionAllowLossyKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStringEncodingDetectionAllowLossyKey');
end;

function NSStringEncodingDetectionFromWindowsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStringEncodingDetectionFromWindowsKey');
end;

function NSStringEncodingDetectionLossySubstitutionKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStringEncodingDetectionLossySubstitutionKey');
end;

function NSStringEncodingDetectionLikelyLanguageKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStringEncodingDetectionLikelyLanguageKey');
end;

function NSDecimalNumberExactnessException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSDecimalNumberExactnessException');
end;

function NSDecimalNumberOverflowException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSDecimalNumberOverflowException');
end;

function NSDecimalNumberUnderflowException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSDecimalNumberUnderflowException');
end;

function NSDecimalNumberDivideByZeroException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSDecimalNumberDivideByZeroException');
end;

function NSCocoaErrorDomain: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCocoaErrorDomain');
end;

function NSPOSIXErrorDomain: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSPOSIXErrorDomain');
end;

function NSOSStatusErrorDomain: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSOSStatusErrorDomain');
end;

function NSMachErrorDomain: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMachErrorDomain');
end;

function NSUnderlyingErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUnderlyingErrorKey');
end;

function NSLocalizedDescriptionKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocalizedDescriptionKey');
end;

function NSLocalizedFailureReasonErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocalizedFailureReasonErrorKey');
end;

function NSLocalizedRecoverySuggestionErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocalizedRecoverySuggestionErrorKey');
end;

function NSLocalizedRecoveryOptionsErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocalizedRecoveryOptionsErrorKey');
end;

function NSRecoveryAttempterErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSRecoveryAttempterErrorKey');
end;

function NSHelpAnchorErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHelpAnchorErrorKey');
end;

function NSStringEncodingErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStringEncodingErrorKey');
end;

function NSURLErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLErrorKey');
end;

function NSFilePathErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFilePathErrorKey');
end;

function NSGenericException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSGenericException');
end;

function NSRangeException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSRangeException');
end;

function NSInvalidArgumentException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSInvalidArgumentException');
end;

function NSInternalInconsistencyException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSInternalInconsistencyException');
end;

function NSMallocException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMallocException');
end;

function NSObjectInaccessibleException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSObjectInaccessibleException');
end;

function NSObjectNotAvailableException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSObjectNotAvailableException');
end;

function NSDestinationInvalidException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSDestinationInvalidException');
end;

function NSPortTimeoutException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSPortTimeoutException');
end;

function NSInvalidSendPortException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSInvalidSendPortException');
end;

function NSInvalidReceivePortException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSInvalidReceivePortException');
end;

function NSPortSendException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSPortSendException');
end;

function NSPortReceiveException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSPortReceiveException');
end;

function NSOldStyleException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSOldStyleException');
end;

function NSAssertionHandlerKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSAssertionHandlerKey');
end;

function NSFileHandleOperationException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileHandleOperationException');
end;

function NSFileHandleReadCompletionNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileHandleReadCompletionNotification');
end;

function NSFileHandleReadToEndOfFileCompletionNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileHandleReadToEndOfFileCompletionNotification');
end;

function NSFileHandleConnectionAcceptedNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileHandleConnectionAcceptedNotification');
end;

function NSFileHandleDataAvailableNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileHandleDataAvailableNotification');
end;

function NSFileHandleNotificationDataItem: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileHandleNotificationDataItem');
end;

function NSFileHandleNotificationFileHandleItem: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileHandleNotificationFileHandleItem');
end;

function NSFileHandleNotificationMonitorModes: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileHandleNotificationMonitorModes');
end;

function NSUbiquityIdentityDidChangeNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUbiquityIdentityDidChangeNotification');
end;

function NSFileType: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileType');
end;

function NSFileTypeDirectory: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileTypeDirectory');
end;

function NSFileTypeRegular: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileTypeRegular');
end;

function NSFileTypeSymbolicLink: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileTypeSymbolicLink');
end;

function NSFileTypeSocket: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileTypeSocket');
end;

function NSFileTypeCharacterSpecial: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileTypeCharacterSpecial');
end;

function NSFileTypeBlockSpecial: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileTypeBlockSpecial');
end;

function NSFileTypeUnknown: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileTypeUnknown');
end;

function NSFileSize: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileSize');
end;

function NSFileModificationDate: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileModificationDate');
end;

function NSFileReferenceCount: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileReferenceCount');
end;

function NSFileDeviceIdentifier: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileDeviceIdentifier');
end;

function NSFileOwnerAccountName: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileOwnerAccountName');
end;

function NSFileGroupOwnerAccountName: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileGroupOwnerAccountName');
end;

function NSFilePosixPermissions: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFilePosixPermissions');
end;

function NSFileSystemNumber: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileSystemNumber');
end;

function NSFileSystemFileNumber: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileSystemFileNumber');
end;

function NSFileExtensionHidden: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileExtensionHidden');
end;

function NSFileHFSCreatorCode: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileHFSCreatorCode');
end;

function NSFileHFSTypeCode: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileHFSTypeCode');
end;

function NSFileImmutable: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileImmutable');
end;

function NSFileAppendOnly: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileAppendOnly');
end;

function NSFileCreationDate: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileCreationDate');
end;

function NSFileOwnerAccountID: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileOwnerAccountID');
end;

function NSFileGroupOwnerAccountID: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileGroupOwnerAccountID');
end;

function NSFileBusy: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileBusy');
end;

function NSFileSystemSize: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileSystemSize');
end;

function NSFileSystemFreeSize: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileSystemFreeSize');
end;

function NSFileSystemNodes: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileSystemNodes');
end;

function NSFileSystemFreeNodes: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFileSystemFreeNodes');
end;

function NSHTTPCookieName: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPCookieName');
end;

function NSHTTPCookieValue: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPCookieValue');
end;

function NSHTTPCookieOriginURL: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPCookieOriginURL');
end;

function NSHTTPCookieVersion: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPCookieVersion');
end;

function NSHTTPCookieDomain: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPCookieDomain');
end;

function NSHTTPCookiePath: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPCookiePath');
end;

function NSHTTPCookieSecure: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPCookieSecure');
end;

function NSHTTPCookieExpires: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPCookieExpires');
end;

function NSHTTPCookieComment: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPCookieComment');
end;

function NSHTTPCookieCommentURL: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPCookieCommentURL');
end;

function NSHTTPCookieDiscard: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPCookieDiscard');
end;

function NSHTTPCookieMaximumAge: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPCookieMaximumAge');
end;

function NSHTTPCookiePort: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPCookiePort');
end;

function NSHTTPCookieManagerAcceptPolicyChangedNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPCookieManagerAcceptPolicyChangedNotification');
end;

function NSHTTPCookieManagerCookiesChangedNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPCookieManagerCookiesChangedNotification');
end;

function NSUndefinedKeyException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUndefinedKeyException');
end;

function NSAverageKeyValueOperator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSAverageKeyValueOperator');
end;

function NSCountKeyValueOperator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCountKeyValueOperator');
end;

function NSDistinctUnionOfArraysKeyValueOperator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSDistinctUnionOfArraysKeyValueOperator');
end;

function NSDistinctUnionOfObjectsKeyValueOperator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSDistinctUnionOfObjectsKeyValueOperator');
end;

function NSDistinctUnionOfSetsKeyValueOperator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSDistinctUnionOfSetsKeyValueOperator');
end;

function NSMaximumKeyValueOperator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMaximumKeyValueOperator');
end;

function NSMinimumKeyValueOperator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMinimumKeyValueOperator');
end;

function NSSumKeyValueOperator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSSumKeyValueOperator');
end;

function NSUnionOfArraysKeyValueOperator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUnionOfArraysKeyValueOperator');
end;

function NSUnionOfObjectsKeyValueOperator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUnionOfObjectsKeyValueOperator');
end;

function NSUnionOfSetsKeyValueOperator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUnionOfSetsKeyValueOperator');
end;

function NSKeyValueChangeKindKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSKeyValueChangeKindKey');
end;

function NSKeyValueChangeNewKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSKeyValueChangeNewKey');
end;

function NSKeyValueChangeOldKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSKeyValueChangeOldKey');
end;

function NSKeyValueChangeIndexesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSKeyValueChangeIndexesKey');
end;

function NSKeyValueChangeNotificationIsPriorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSKeyValueChangeNotificationIsPriorKey');
end;

function NSInvalidArchiveOperationException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSInvalidArchiveOperationException');
end;

function NSInvalidUnarchiveOperationException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSInvalidUnarchiveOperationException');
end;

function NSKeyedArchiveRootObjectKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSKeyedArchiveRootObjectKey');
end;

function NSCurrentLocaleDidChangeNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCurrentLocaleDidChangeNotification');
end;

function NSLocaleIdentifier: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleIdentifier');
end;

function NSLocaleLanguageCode: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleLanguageCode');
end;

function NSLocaleCountryCode: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleCountryCode');
end;

function NSLocaleScriptCode: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleScriptCode');
end;

function NSLocaleVariantCode: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleVariantCode');
end;

function NSLocaleExemplarCharacterSet: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleExemplarCharacterSet');
end;

function NSLocaleCalendar: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleCalendar');
end;

function NSLocaleCollationIdentifier: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleCollationIdentifier');
end;

function NSLocaleUsesMetricSystem: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleUsesMetricSystem');
end;

function NSLocaleMeasurementSystem: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleMeasurementSystem');
end;

function NSLocaleDecimalSeparator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleDecimalSeparator');
end;

function NSLocaleGroupingSeparator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleGroupingSeparator');
end;

function NSLocaleCurrencySymbol: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleCurrencySymbol');
end;

function NSLocaleCurrencyCode: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleCurrencyCode');
end;

function NSLocaleCollatorIdentifier: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleCollatorIdentifier');
end;

function NSLocaleQuotationBeginDelimiterKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleQuotationBeginDelimiterKey');
end;

function NSLocaleQuotationEndDelimiterKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleQuotationEndDelimiterKey');
end;

function NSLocaleAlternateQuotationBeginDelimiterKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleAlternateQuotationBeginDelimiterKey');
end;

function NSLocaleAlternateQuotationEndDelimiterKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocaleAlternateQuotationEndDelimiterKey');
end;

function NSGregorianCalendar: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSGregorianCalendar');
end;

function NSBuddhistCalendar: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSBuddhistCalendar');
end;

function NSChineseCalendar: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSChineseCalendar');
end;

function NSHebrewCalendar: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHebrewCalendar');
end;

function NSIslamicCalendar: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSIslamicCalendar');
end;

function NSIslamicCivilCalendar: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSIslamicCivilCalendar');
end;

function NSJapaneseCalendar: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSJapaneseCalendar');
end;

function NSRepublicOfChinaCalendar: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSRepublicOfChinaCalendar');
end;

function NSPersianCalendar: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSPersianCalendar');
end;

function NSIndianCalendar: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSIndianCalendar');
end;

function NSISO8601Calendar: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSISO8601Calendar');
end;

function NSInvocationOperationVoidResultException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSInvocationOperationVoidResultException');
end;

function NSInvocationOperationCancelledException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSInvocationOperationCancelledException');
end;

function NSPortDidBecomeInvalidNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSPortDidBecomeInvalidNotification');
end;

function NSTextCheckingNameKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSTextCheckingNameKey');
end;

function NSTextCheckingJobTitleKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSTextCheckingJobTitleKey');
end;

function NSTextCheckingOrganizationKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSTextCheckingOrganizationKey');
end;

function NSTextCheckingStreetKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSTextCheckingStreetKey');
end;

function NSTextCheckingCityKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSTextCheckingCityKey');
end;

function NSTextCheckingStateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSTextCheckingStateKey');
end;

function NSTextCheckingZIPKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSTextCheckingZIPKey');
end;

function NSTextCheckingCountryKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSTextCheckingCountryKey');
end;

function NSTextCheckingPhoneKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSTextCheckingPhoneKey');
end;

function NSTextCheckingAirlineKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSTextCheckingAirlineKey');
end;

function NSTextCheckingFlightKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSTextCheckingFlightKey');
end;

function NSDefaultRunLoopMode: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSDefaultRunLoopMode');
end;

function NSRunLoopCommonModes: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSRunLoopCommonModes');
end;

function NSStreamSocketSecurityLevelKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSocketSecurityLevelKey');
end;

function NSStreamSocketSecurityLevelNone: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSocketSecurityLevelNone');
end;

function NSStreamSocketSecurityLevelSSLv2: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSocketSecurityLevelSSLv2');
end;

function NSStreamSocketSecurityLevelSSLv3: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSocketSecurityLevelSSLv3');
end;

function NSStreamSocketSecurityLevelTLSv1: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSocketSecurityLevelTLSv1');
end;

function NSStreamSocketSecurityLevelNegotiatedSSL: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSocketSecurityLevelNegotiatedSSL');
end;

function NSStreamSOCKSProxyConfigurationKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSOCKSProxyConfigurationKey');
end;

function NSStreamSOCKSProxyHostKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSOCKSProxyHostKey');
end;

function NSStreamSOCKSProxyPortKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSOCKSProxyPortKey');
end;

function NSStreamSOCKSProxyVersionKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSOCKSProxyVersionKey');
end;

function NSStreamSOCKSProxyUserKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSOCKSProxyUserKey');
end;

function NSStreamSOCKSProxyPasswordKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSOCKSProxyPasswordKey');
end;

function NSStreamSOCKSProxyVersion4: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSOCKSProxyVersion4');
end;

function NSStreamSOCKSProxyVersion5: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSOCKSProxyVersion5');
end;

function NSStreamDataWrittenToMemoryStreamKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamDataWrittenToMemoryStreamKey');
end;

function NSStreamFileCurrentOffsetKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamFileCurrentOffsetKey');
end;

function NSStreamSocketSSLErrorDomain: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSocketSSLErrorDomain');
end;

function NSStreamSOCKSErrorDomain: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamSOCKSErrorDomain');
end;

function NSStreamNetworkServiceType: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamNetworkServiceType');
end;

function NSStreamNetworkServiceTypeVoIP: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamNetworkServiceTypeVoIP');
end;

function NSStreamNetworkServiceTypeVideo: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamNetworkServiceTypeVideo');
end;

function NSStreamNetworkServiceTypeBackground: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamNetworkServiceTypeBackground');
end;

function NSStreamNetworkServiceTypeVoice: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSStreamNetworkServiceTypeVoice');
end;

function NSWillBecomeMultiThreadedNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSWillBecomeMultiThreadedNotification');
end;

function NSDidBecomeSingleThreadedNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSDidBecomeSingleThreadedNotification');
end;

function NSThreadWillExitNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSThreadWillExitNotification');
end;

function NSSystemTimeZoneDidChangeNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSSystemTimeZoneDidChangeNotification');
end;

function NSHTTPPropertyStatusCodeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPPropertyStatusCodeKey');
end;

function NSHTTPPropertyStatusReasonKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPPropertyStatusReasonKey');
end;

function NSHTTPPropertyServerHTTPVersionKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPPropertyServerHTTPVersionKey');
end;

function NSHTTPPropertyRedirectionHeadersKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPPropertyRedirectionHeadersKey');
end;

function NSHTTPPropertyErrorPageDataKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPPropertyErrorPageDataKey');
end;

function NSHTTPPropertyHTTPProxy: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHTTPPropertyHTTPProxy');
end;

function NSFTPPropertyUserLoginKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFTPPropertyUserLoginKey');
end;

function NSFTPPropertyUserPasswordKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFTPPropertyUserPasswordKey');
end;

function NSFTPPropertyActiveTransferModeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFTPPropertyActiveTransferModeKey');
end;

function NSFTPPropertyFileOffsetKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFTPPropertyFileOffsetKey');
end;

function NSFTPPropertyFTPProxy: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFTPPropertyFTPProxy');
end;

function NSURLFileScheme: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLFileScheme');
end;

function NSURLKeysOfUnsetValuesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLKeysOfUnsetValuesKey');
end;

function NSURLNameKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLNameKey');
end;

function NSURLLocalizedNameKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLLocalizedNameKey');
end;

function NSURLIsRegularFileKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLIsRegularFileKey');
end;

function NSURLIsDirectoryKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLIsDirectoryKey');
end;

function NSURLIsSymbolicLinkKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLIsSymbolicLinkKey');
end;

function NSURLIsVolumeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLIsVolumeKey');
end;

function NSURLIsPackageKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLIsPackageKey');
end;

function NSURLIsSystemImmutableKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLIsSystemImmutableKey');
end;

function NSURLIsUserImmutableKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLIsUserImmutableKey');
end;

function NSURLIsHiddenKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLIsHiddenKey');
end;

function NSURLHasHiddenExtensionKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLHasHiddenExtensionKey');
end;

function NSURLCreationDateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLCreationDateKey');
end;

function NSURLContentAccessDateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLContentAccessDateKey');
end;

function NSURLContentModificationDateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLContentModificationDateKey');
end;

function NSURLAttributeModificationDateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLAttributeModificationDateKey');
end;

function NSURLLinkCountKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLLinkCountKey');
end;

function NSURLParentDirectoryURLKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLParentDirectoryURLKey');
end;

function NSURLVolumeURLKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeURLKey');
end;

function NSURLTypeIdentifierKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLTypeIdentifierKey');
end;

function NSURLLocalizedTypeDescriptionKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLLocalizedTypeDescriptionKey');
end;

function NSURLLabelNumberKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLLabelNumberKey');
end;

function NSURLLabelColorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLLabelColorKey');
end;

function NSURLLocalizedLabelKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLLocalizedLabelKey');
end;

function NSURLEffectiveIconKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLEffectiveIconKey');
end;

function NSURLCustomIconKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLCustomIconKey');
end;

function NSURLFileResourceIdentifierKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLFileResourceIdentifierKey');
end;

function NSURLVolumeIdentifierKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeIdentifierKey');
end;

function NSURLPreferredIOBlockSizeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLPreferredIOBlockSizeKey');
end;

function NSURLIsReadableKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLIsReadableKey');
end;

function NSURLIsWritableKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLIsWritableKey');
end;

function NSURLIsExecutableKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLIsExecutableKey');
end;

function NSURLFileSecurityKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLFileSecurityKey');
end;

function NSURLIsExcludedFromBackupKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLIsExcludedFromBackupKey');
end;

function NSURLTagNamesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLTagNamesKey');
end;

function NSURLPathKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLPathKey');
end;

function NSURLIsMountTriggerKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLIsMountTriggerKey');
end;

function NSURLGenerationIdentifierKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLGenerationIdentifierKey');
end;

function NSURLDocumentIdentifierKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLDocumentIdentifierKey');
end;

function NSURLAddedToDirectoryDateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLAddedToDirectoryDateKey');
end;

function NSURLQuarantinePropertiesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLQuarantinePropertiesKey');
end;

function NSURLFileResourceTypeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLFileResourceTypeKey');
end;

function NSURLFileResourceTypeNamedPipe: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLFileResourceTypeNamedPipe');
end;

function NSURLFileResourceTypeCharacterSpecial: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLFileResourceTypeCharacterSpecial');
end;

function NSURLFileResourceTypeDirectory: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLFileResourceTypeDirectory');
end;

function NSURLFileResourceTypeBlockSpecial: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLFileResourceTypeBlockSpecial');
end;

function NSURLFileResourceTypeRegular: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLFileResourceTypeRegular');
end;

function NSURLFileResourceTypeSymbolicLink: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLFileResourceTypeSymbolicLink');
end;

function NSURLFileResourceTypeSocket: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLFileResourceTypeSocket');
end;

function NSURLFileResourceTypeUnknown: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLFileResourceTypeUnknown');
end;

function NSURLThumbnailDictionaryKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLThumbnailDictionaryKey');
end;

function NSURLThumbnailKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLThumbnailKey');
end;

function NSThumbnail1024x1024SizeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSThumbnail1024x1024SizeKey');
end;

function NSURLFileSizeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLFileSizeKey');
end;

function NSURLFileAllocatedSizeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLFileAllocatedSizeKey');
end;

function NSURLTotalFileSizeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLTotalFileSizeKey');
end;

function NSURLTotalFileAllocatedSizeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLTotalFileAllocatedSizeKey');
end;

function NSURLIsAliasFileKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLIsAliasFileKey');
end;

function NSURLVolumeLocalizedFormatDescriptionKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeLocalizedFormatDescriptionKey');
end;

function NSURLVolumeTotalCapacityKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeTotalCapacityKey');
end;

function NSURLVolumeAvailableCapacityKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeAvailableCapacityKey');
end;

function NSURLVolumeResourceCountKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeResourceCountKey');
end;

function NSURLVolumeSupportsPersistentIDsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeSupportsPersistentIDsKey');
end;

function NSURLVolumeSupportsSymbolicLinksKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeSupportsSymbolicLinksKey');
end;

function NSURLVolumeSupportsHardLinksKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeSupportsHardLinksKey');
end;

function NSURLVolumeSupportsJournalingKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeSupportsJournalingKey');
end;

function NSURLVolumeIsJournalingKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeIsJournalingKey');
end;

function NSURLVolumeSupportsSparseFilesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeSupportsSparseFilesKey');
end;

function NSURLVolumeSupportsZeroRunsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeSupportsZeroRunsKey');
end;

function NSURLVolumeSupportsCaseSensitiveNamesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeSupportsCaseSensitiveNamesKey');
end;

function NSURLVolumeSupportsCasePreservedNamesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeSupportsCasePreservedNamesKey');
end;

function NSURLVolumeSupportsRootDirectoryDatesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeSupportsRootDirectoryDatesKey');
end;

function NSURLVolumeSupportsVolumeSizesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeSupportsVolumeSizesKey');
end;

function NSURLVolumeSupportsRenamingKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeSupportsRenamingKey');
end;

function NSURLVolumeSupportsAdvisoryFileLockingKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeSupportsAdvisoryFileLockingKey');
end;

function NSURLVolumeSupportsExtendedSecurityKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeSupportsExtendedSecurityKey');
end;

function NSURLVolumeIsBrowsableKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeIsBrowsableKey');
end;

function NSURLVolumeMaximumFileSizeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeMaximumFileSizeKey');
end;

function NSURLVolumeIsEjectableKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeIsEjectableKey');
end;

function NSURLVolumeIsRemovableKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeIsRemovableKey');
end;

function NSURLVolumeIsInternalKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeIsInternalKey');
end;

function NSURLVolumeIsAutomountedKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeIsAutomountedKey');
end;

function NSURLVolumeIsLocalKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeIsLocalKey');
end;

function NSURLVolumeIsReadOnlyKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeIsReadOnlyKey');
end;

function NSURLVolumeCreationDateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeCreationDateKey');
end;

function NSURLVolumeURLForRemountingKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeURLForRemountingKey');
end;

function NSURLVolumeUUIDStringKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeUUIDStringKey');
end;

function NSURLVolumeNameKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeNameKey');
end;

function NSURLVolumeLocalizedNameKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLVolumeLocalizedNameKey');
end;

function NSURLIsUbiquitousItemKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLIsUbiquitousItemKey');
end;

function NSURLUbiquitousItemHasUnresolvedConflictsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLUbiquitousItemHasUnresolvedConflictsKey');
end;

function NSURLUbiquitousItemIsDownloadedKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLUbiquitousItemIsDownloadedKey');
end;

function NSURLUbiquitousItemIsDownloadingKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLUbiquitousItemIsDownloadingKey');
end;

function NSURLUbiquitousItemIsUploadedKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLUbiquitousItemIsUploadedKey');
end;

function NSURLUbiquitousItemIsUploadingKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLUbiquitousItemIsUploadingKey');
end;

function NSURLUbiquitousItemPercentDownloadedKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLUbiquitousItemPercentDownloadedKey');
end;

function NSURLUbiquitousItemPercentUploadedKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLUbiquitousItemPercentUploadedKey');
end;

function NSURLUbiquitousItemDownloadingStatusKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLUbiquitousItemDownloadingStatusKey');
end;

function NSURLUbiquitousItemDownloadingErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLUbiquitousItemDownloadingErrorKey');
end;

function NSURLUbiquitousItemUploadingErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLUbiquitousItemUploadingErrorKey');
end;

function NSURLUbiquitousItemDownloadRequestedKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLUbiquitousItemDownloadRequestedKey');
end;

function NSURLUbiquitousItemContainerDisplayNameKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLUbiquitousItemContainerDisplayNameKey');
end;

function NSURLUbiquitousItemDownloadingStatusNotDownloaded: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLUbiquitousItemDownloadingStatusNotDownloaded');
end;

function NSURLUbiquitousItemDownloadingStatusDownloaded: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLUbiquitousItemDownloadingStatusDownloaded');
end;

function NSURLUbiquitousItemDownloadingStatusCurrent: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLUbiquitousItemDownloadingStatusCurrent');
end;

function NSURLCredentialStorageChangedNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLCredentialStorageChangedNotification');
end;

function NSURLCredentialStorageRemoveSynchronizableCredentials: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLCredentialStorageRemoveSynchronizableCredentials');
end;

function NSURLErrorDomain: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLErrorDomain');
end;

function NSURLErrorFailingURLErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLErrorFailingURLErrorKey');
end;

function NSURLErrorFailingURLStringErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLErrorFailingURLStringErrorKey');
end;

function NSErrorFailingURLStringKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSErrorFailingURLStringKey');
end;

function NSURLErrorFailingURLPeerTrustErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLErrorFailingURLPeerTrustErrorKey');
end;

function NSURLErrorBackgroundTaskCancelledReasonKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLErrorBackgroundTaskCancelledReasonKey');
end;

function NSURLProtectionSpaceHTTP: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLProtectionSpaceHTTP');
end;

function NSURLProtectionSpaceHTTPS: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLProtectionSpaceHTTPS');
end;

function NSURLProtectionSpaceFTP: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLProtectionSpaceFTP');
end;

function NSURLProtectionSpaceHTTPProxy: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLProtectionSpaceHTTPProxy');
end;

function NSURLProtectionSpaceHTTPSProxy: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLProtectionSpaceHTTPSProxy');
end;

function NSURLProtectionSpaceFTPProxy: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLProtectionSpaceFTPProxy');
end;

function NSURLProtectionSpaceSOCKSProxy: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLProtectionSpaceSOCKSProxy');
end;

function NSURLAuthenticationMethodDefault: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLAuthenticationMethodDefault');
end;

function NSURLAuthenticationMethodHTTPBasic: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLAuthenticationMethodHTTPBasic');
end;

function NSURLAuthenticationMethodHTTPDigest: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLAuthenticationMethodHTTPDigest');
end;

function NSURLAuthenticationMethodHTMLForm: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLAuthenticationMethodHTMLForm');
end;

function NSURLAuthenticationMethodNTLM: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLAuthenticationMethodNTLM');
end;

function NSURLAuthenticationMethodNegotiate: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLAuthenticationMethodNegotiate');
end;

function NSURLAuthenticationMethodClientCertificate: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLAuthenticationMethodClientCertificate');
end;

function NSURLAuthenticationMethodServerTrust: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLAuthenticationMethodServerTrust');
end;

function NSGlobalDomain: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSGlobalDomain');
end;

function NSArgumentDomain: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSArgumentDomain');
end;

function NSRegistrationDomain: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSRegistrationDomain');
end;

function NSUserDefaultsDidChangeNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUserDefaultsDidChangeNotification');
end;

function NSWeekDayNameArray: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSWeekDayNameArray');
end;

function NSShortWeekDayNameArray: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSShortWeekDayNameArray');
end;

function NSMonthNameArray: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMonthNameArray');
end;

function NSShortMonthNameArray: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSShortMonthNameArray');
end;

function NSTimeFormatString: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSTimeFormatString');
end;

function NSDateFormatString: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSDateFormatString');
end;

function NSTimeDateFormatString: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSTimeDateFormatString');
end;

function NSShortTimeDateFormatString: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSShortTimeDateFormatString');
end;

function NSCurrencySymbol: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSCurrencySymbol');
end;

function NSDecimalSeparator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSDecimalSeparator');
end;

function NSThousandsSeparator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSThousandsSeparator');
end;

function NSDecimalDigits: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSDecimalDigits');
end;

function NSAMPMDesignation: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSAMPMDesignation');
end;

function NSHourNameDesignations: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSHourNameDesignations');
end;

function NSYearMonthWeekDesignations: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSYearMonthWeekDesignations');
end;

function NSEarlierTimeDesignations: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSEarlierTimeDesignations');
end;

function NSLaterTimeDesignations: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLaterTimeDesignations');
end;

function NSThisDayDesignations: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSThisDayDesignations');
end;

function NSNextDayDesignations: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSNextDayDesignations');
end;

function NSNextNextDayDesignations: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSNextNextDayDesignations');
end;

function NSPriorDayDesignations: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSPriorDayDesignations');
end;

function NSDateTimeOrdering: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSDateTimeOrdering');
end;

function NSInternationalCurrencyString: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSInternationalCurrencyString');
end;

function NSShortDateFormatString: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSShortDateFormatString');
end;

function NSPositiveCurrencyFormatString: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSPositiveCurrencyFormatString');
end;

function NSNegativeCurrencyFormatString: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSNegativeCurrencyFormatString');
end;

function NSNegateBooleanTransformerName: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSNegateBooleanTransformerName');
end;

function NSIsNilTransformerName: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSIsNilTransformerName');
end;

function NSIsNotNilTransformerName: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSIsNotNilTransformerName');
end;

function NSUnarchiveFromDataTransformerName: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUnarchiveFromDataTransformerName');
end;

function NSKeyedUnarchiveFromDataTransformerName: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSKeyedUnarchiveFromDataTransformerName');
end;

function NSXMLParserErrorDomain: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSXMLParserErrorDomain');
end;

function NSExtensionItemsAndErrorsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSExtensionItemsAndErrorsKey');
end;

function NSItemProviderPreferredImageSizeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSItemProviderPreferredImageSizeKey');
end;

function NSExtensionJavaScriptPreprocessingResultsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSExtensionJavaScriptPreprocessingResultsKey');
end;

function NSItemProviderErrorDomain: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSItemProviderErrorDomain');
end;

function NSExtensionItemAttributedTitleKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSExtensionItemAttributedTitleKey');
end;

function NSExtensionItemAttributedContentTextKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSExtensionItemAttributedContentTextKey');
end;

function NSExtensionItemAttachmentsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSExtensionItemAttachmentsKey');
end;

function NSLinguisticTagSchemeTokenType: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagSchemeTokenType');
end;

function NSLinguisticTagSchemeLexicalClass: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagSchemeLexicalClass');
end;

function NSLinguisticTagSchemeNameType: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagSchemeNameType');
end;

function NSLinguisticTagSchemeNameTypeOrLexicalClass: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagSchemeNameTypeOrLexicalClass');
end;

function NSLinguisticTagSchemeLemma: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagSchemeLemma');
end;

function NSLinguisticTagSchemeLanguage: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagSchemeLanguage');
end;

function NSLinguisticTagSchemeScript: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagSchemeScript');
end;

function NSLinguisticTagWord: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagWord');
end;

function NSLinguisticTagPunctuation: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagPunctuation');
end;

function NSLinguisticTagWhitespace: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagWhitespace');
end;

function NSLinguisticTagOther: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagOther');
end;

function NSLinguisticTagNoun: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagNoun');
end;

function NSLinguisticTagVerb: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagVerb');
end;

function NSLinguisticTagAdjective: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagAdjective');
end;

function NSLinguisticTagAdverb: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagAdverb');
end;

function NSLinguisticTagPronoun: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagPronoun');
end;

function NSLinguisticTagDeterminer: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagDeterminer');
end;

function NSLinguisticTagParticle: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagParticle');
end;

function NSLinguisticTagPreposition: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagPreposition');
end;

function NSLinguisticTagNumber: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagNumber');
end;

function NSLinguisticTagConjunction: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagConjunction');
end;

function NSLinguisticTagInterjection: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagInterjection');
end;

function NSLinguisticTagClassifier: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagClassifier');
end;

function NSLinguisticTagIdiom: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagIdiom');
end;

function NSLinguisticTagOtherWord: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagOtherWord');
end;

function NSLinguisticTagSentenceTerminator: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagSentenceTerminator');
end;

function NSLinguisticTagOpenQuote: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagOpenQuote');
end;

function NSLinguisticTagCloseQuote: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagCloseQuote');
end;

function NSLinguisticTagOpenParenthesis: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagOpenParenthesis');
end;

function NSLinguisticTagCloseParenthesis: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagCloseParenthesis');
end;

function NSLinguisticTagWordJoiner: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagWordJoiner');
end;

function NSLinguisticTagDash: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagDash');
end;

function NSLinguisticTagOtherPunctuation: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagOtherPunctuation');
end;

function NSLinguisticTagParagraphBreak: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagParagraphBreak');
end;

function NSLinguisticTagOtherWhitespace: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagOtherWhitespace');
end;

function NSLinguisticTagPersonalName: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagPersonalName');
end;

function NSLinguisticTagPlaceName: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagPlaceName');
end;

function NSLinguisticTagOrganizationName: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLinguisticTagOrganizationName');
end;

function NSMetadataItemFSNameKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemFSNameKey');
end;

function NSMetadataItemDisplayNameKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemDisplayNameKey');
end;

function NSMetadataItemURLKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemURLKey');
end;

function NSMetadataItemPathKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemPathKey');
end;

function NSMetadataItemFSSizeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemFSSizeKey');
end;

function NSMetadataItemFSCreationDateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemFSCreationDateKey');
end;

function NSMetadataItemFSContentChangeDateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemFSContentChangeDateKey');
end;

function NSMetadataItemContentTypeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemContentTypeKey');
end;

function NSMetadataItemContentTypeTreeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemContentTypeTreeKey');
end;

function NSMetadataItemIsUbiquitousKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemIsUbiquitousKey');
end;

function NSMetadataUbiquitousItemHasUnresolvedConflictsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemHasUnresolvedConflictsKey');
end;

function NSMetadataUbiquitousItemIsDownloadedKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemIsDownloadedKey');
end;

function NSMetadataUbiquitousItemDownloadingStatusKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemDownloadingStatusKey');
end;

function NSMetadataUbiquitousItemDownloadingStatusNotDownloaded: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemDownloadingStatusNotDownloaded');
end;

function NSMetadataUbiquitousItemDownloadingStatusDownloaded: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemDownloadingStatusDownloaded');
end;

function NSMetadataUbiquitousItemDownloadingStatusCurrent: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemDownloadingStatusCurrent');
end;

function NSMetadataUbiquitousItemIsDownloadingKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemIsDownloadingKey');
end;

function NSMetadataUbiquitousItemIsUploadedKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemIsUploadedKey');
end;

function NSMetadataUbiquitousItemIsUploadingKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemIsUploadingKey');
end;

function NSMetadataUbiquitousItemPercentDownloadedKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemPercentDownloadedKey');
end;

function NSMetadataUbiquitousItemPercentUploadedKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemPercentUploadedKey');
end;

function NSMetadataUbiquitousItemDownloadingErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemDownloadingErrorKey');
end;

function NSMetadataUbiquitousItemUploadingErrorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemUploadingErrorKey');
end;

function NSMetadataUbiquitousItemDownloadRequestedKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemDownloadRequestedKey');
end;

function NSMetadataUbiquitousItemIsExternalDocumentKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemIsExternalDocumentKey');
end;

function NSMetadataUbiquitousItemContainerDisplayNameKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemContainerDisplayNameKey');
end;

function NSMetadataUbiquitousItemURLInLocalContainerKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataUbiquitousItemURLInLocalContainerKey');
end;

function NSMetadataItemAttributeChangeDateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAttributeChangeDateKey');
end;

function NSMetadataItemKeywordsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemKeywordsKey');
end;

function NSMetadataItemTitleKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemTitleKey');
end;

function NSMetadataItemAuthorsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAuthorsKey');
end;

function NSMetadataItemEditorsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemEditorsKey');
end;

function NSMetadataItemParticipantsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemParticipantsKey');
end;

function NSMetadataItemProjectsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemProjectsKey');
end;

function NSMetadataItemDownloadedDateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemDownloadedDateKey');
end;

function NSMetadataItemWhereFromsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemWhereFromsKey');
end;

function NSMetadataItemCommentKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemCommentKey');
end;

function NSMetadataItemCopyrightKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemCopyrightKey');
end;

function NSMetadataItemLastUsedDateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemLastUsedDateKey');
end;

function NSMetadataItemContentCreationDateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemContentCreationDateKey');
end;

function NSMetadataItemContentModificationDateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemContentModificationDateKey');
end;

function NSMetadataItemDateAddedKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemDateAddedKey');
end;

function NSMetadataItemDurationSecondsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemDurationSecondsKey');
end;

function NSMetadataItemContactKeywordsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemContactKeywordsKey');
end;

function NSMetadataItemVersionKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemVersionKey');
end;

function NSMetadataItemPixelHeightKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemPixelHeightKey');
end;

function NSMetadataItemPixelWidthKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemPixelWidthKey');
end;

function NSMetadataItemPixelCountKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemPixelCountKey');
end;

function NSMetadataItemColorSpaceKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemColorSpaceKey');
end;

function NSMetadataItemBitsPerSampleKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemBitsPerSampleKey');
end;

function NSMetadataItemFlashOnOffKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemFlashOnOffKey');
end;

function NSMetadataItemFocalLengthKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemFocalLengthKey');
end;

function NSMetadataItemAcquisitionMakeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAcquisitionMakeKey');
end;

function NSMetadataItemAcquisitionModelKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAcquisitionModelKey');
end;

function NSMetadataItemISOSpeedKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemISOSpeedKey');
end;

function NSMetadataItemOrientationKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemOrientationKey');
end;

function NSMetadataItemLayerNamesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemLayerNamesKey');
end;

function NSMetadataItemWhiteBalanceKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemWhiteBalanceKey');
end;

function NSMetadataItemApertureKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemApertureKey');
end;

function NSMetadataItemProfileNameKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemProfileNameKey');
end;

function NSMetadataItemResolutionWidthDPIKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemResolutionWidthDPIKey');
end;

function NSMetadataItemResolutionHeightDPIKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemResolutionHeightDPIKey');
end;

function NSMetadataItemExposureModeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemExposureModeKey');
end;

function NSMetadataItemExposureTimeSecondsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemExposureTimeSecondsKey');
end;

function NSMetadataItemEXIFVersionKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemEXIFVersionKey');
end;

function NSMetadataItemCameraOwnerKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemCameraOwnerKey');
end;

function NSMetadataItemFocalLength35mmKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemFocalLength35mmKey');
end;

function NSMetadataItemLensModelKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemLensModelKey');
end;

function NSMetadataItemEXIFGPSVersionKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemEXIFGPSVersionKey');
end;

function NSMetadataItemAltitudeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAltitudeKey');
end;

function NSMetadataItemLatitudeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemLatitudeKey');
end;

function NSMetadataItemLongitudeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemLongitudeKey');
end;

function NSMetadataItemSpeedKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemSpeedKey');
end;

function NSMetadataItemTimestampKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemTimestampKey');
end;

function NSMetadataItemGPSTrackKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemGPSTrackKey');
end;

function NSMetadataItemImageDirectionKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemImageDirectionKey');
end;

function NSMetadataItemNamedLocationKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemNamedLocationKey');
end;

function NSMetadataItemGPSStatusKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemGPSStatusKey');
end;

function NSMetadataItemGPSMeasureModeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemGPSMeasureModeKey');
end;

function NSMetadataItemGPSDOPKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemGPSDOPKey');
end;

function NSMetadataItemGPSMapDatumKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemGPSMapDatumKey');
end;

function NSMetadataItemGPSDestLatitudeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemGPSDestLatitudeKey');
end;

function NSMetadataItemGPSDestLongitudeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemGPSDestLongitudeKey');
end;

function NSMetadataItemGPSDestBearingKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemGPSDestBearingKey');
end;

function NSMetadataItemGPSDestDistanceKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemGPSDestDistanceKey');
end;

function NSMetadataItemGPSProcessingMethodKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemGPSProcessingMethodKey');
end;

function NSMetadataItemGPSAreaInformationKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemGPSAreaInformationKey');
end;

function NSMetadataItemGPSDateStampKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemGPSDateStampKey');
end;

function NSMetadataItemGPSDifferentalKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemGPSDifferentalKey');
end;

function NSMetadataItemCodecsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemCodecsKey');
end;

function NSMetadataItemMediaTypesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemMediaTypesKey');
end;

function NSMetadataItemStreamableKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemStreamableKey');
end;

function NSMetadataItemTotalBitRateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemTotalBitRateKey');
end;

function NSMetadataItemVideoBitRateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemVideoBitRateKey');
end;

function NSMetadataItemAudioBitRateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAudioBitRateKey');
end;

function NSMetadataItemDeliveryTypeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemDeliveryTypeKey');
end;

function NSMetadataItemAlbumKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAlbumKey');
end;

function NSMetadataItemHasAlphaChannelKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemHasAlphaChannelKey');
end;

function NSMetadataItemRedEyeOnOffKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemRedEyeOnOffKey');
end;

function NSMetadataItemMeteringModeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemMeteringModeKey');
end;

function NSMetadataItemMaxApertureKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemMaxApertureKey');
end;

function NSMetadataItemFNumberKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemFNumberKey');
end;

function NSMetadataItemExposureProgramKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemExposureProgramKey');
end;

function NSMetadataItemExposureTimeStringKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemExposureTimeStringKey');
end;

function NSMetadataItemHeadlineKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemHeadlineKey');
end;

function NSMetadataItemInstructionsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemInstructionsKey');
end;

function NSMetadataItemCityKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemCityKey');
end;

function NSMetadataItemStateOrProvinceKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemStateOrProvinceKey');
end;

function NSMetadataItemCountryKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemCountryKey');
end;

function NSMetadataItemTextContentKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemTextContentKey');
end;

function NSMetadataItemAudioSampleRateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAudioSampleRateKey');
end;

function NSMetadataItemAudioChannelCountKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAudioChannelCountKey');
end;

function NSMetadataItemTempoKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemTempoKey');
end;

function NSMetadataItemKeySignatureKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemKeySignatureKey');
end;

function NSMetadataItemTimeSignatureKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemTimeSignatureKey');
end;

function NSMetadataItemAudioEncodingApplicationKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAudioEncodingApplicationKey');
end;

function NSMetadataItemComposerKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemComposerKey');
end;

function NSMetadataItemLyricistKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemLyricistKey');
end;

function NSMetadataItemAudioTrackNumberKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAudioTrackNumberKey');
end;

function NSMetadataItemRecordingDateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemRecordingDateKey');
end;

function NSMetadataItemMusicalGenreKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemMusicalGenreKey');
end;

function NSMetadataItemIsGeneralMIDISequenceKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemIsGeneralMIDISequenceKey');
end;

function NSMetadataItemRecordingYearKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemRecordingYearKey');
end;

function NSMetadataItemOrganizationsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemOrganizationsKey');
end;

function NSMetadataItemLanguagesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemLanguagesKey');
end;

function NSMetadataItemRightsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemRightsKey');
end;

function NSMetadataItemPublishersKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemPublishersKey');
end;

function NSMetadataItemContributorsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemContributorsKey');
end;

function NSMetadataItemCoverageKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemCoverageKey');
end;

function NSMetadataItemSubjectKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemSubjectKey');
end;

function NSMetadataItemThemeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemThemeKey');
end;

function NSMetadataItemDescriptionKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemDescriptionKey');
end;

function NSMetadataItemIdentifierKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemIdentifierKey');
end;

function NSMetadataItemAudiencesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAudiencesKey');
end;

function NSMetadataItemNumberOfPagesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemNumberOfPagesKey');
end;

function NSMetadataItemPageWidthKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemPageWidthKey');
end;

function NSMetadataItemPageHeightKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemPageHeightKey');
end;

function NSMetadataItemSecurityMethodKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemSecurityMethodKey');
end;

function NSMetadataItemCreatorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemCreatorKey');
end;

function NSMetadataItemEncodingApplicationsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemEncodingApplicationsKey');
end;

function NSMetadataItemDueDateKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemDueDateKey');
end;

function NSMetadataItemStarRatingKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemStarRatingKey');
end;

function NSMetadataItemPhoneNumbersKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemPhoneNumbersKey');
end;

function NSMetadataItemEmailAddressesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemEmailAddressesKey');
end;

function NSMetadataItemInstantMessageAddressesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemInstantMessageAddressesKey');
end;

function NSMetadataItemKindKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemKindKey');
end;

function NSMetadataItemRecipientsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemRecipientsKey');
end;

function NSMetadataItemFinderCommentKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemFinderCommentKey');
end;

function NSMetadataItemFontsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemFontsKey');
end;

function NSMetadataItemAppleLoopsRootKeyKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAppleLoopsRootKeyKey');
end;

function NSMetadataItemAppleLoopsKeyFilterTypeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAppleLoopsKeyFilterTypeKey');
end;

function NSMetadataItemAppleLoopsLoopModeKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAppleLoopsLoopModeKey');
end;

function NSMetadataItemAppleLoopDescriptorsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAppleLoopDescriptorsKey');
end;

function NSMetadataItemMusicalInstrumentCategoryKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemMusicalInstrumentCategoryKey');
end;

function NSMetadataItemMusicalInstrumentNameKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemMusicalInstrumentNameKey');
end;

function NSMetadataItemCFBundleIdentifierKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemCFBundleIdentifierKey');
end;

function NSMetadataItemInformationKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemInformationKey');
end;

function NSMetadataItemDirectorKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemDirectorKey');
end;

function NSMetadataItemProducerKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemProducerKey');
end;

function NSMetadataItemGenreKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemGenreKey');
end;

function NSMetadataItemPerformersKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemPerformersKey');
end;

function NSMetadataItemOriginalFormatKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemOriginalFormatKey');
end;

function NSMetadataItemOriginalSourceKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemOriginalSourceKey');
end;

function NSMetadataItemAuthorEmailAddressesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAuthorEmailAddressesKey');
end;

function NSMetadataItemRecipientEmailAddressesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemRecipientEmailAddressesKey');
end;

function NSMetadataItemAuthorAddressesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemAuthorAddressesKey');
end;

function NSMetadataItemRecipientAddressesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemRecipientAddressesKey');
end;

function NSMetadataItemIsLikelyJunkKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemIsLikelyJunkKey');
end;

function NSMetadataItemExecutableArchitecturesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemExecutableArchitecturesKey');
end;

function NSMetadataItemExecutablePlatformKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemExecutablePlatformKey');
end;

function NSMetadataItemApplicationCategoriesKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemApplicationCategoriesKey');
end;

function NSMetadataItemIsApplicationManagedKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataItemIsApplicationManagedKey');
end;

function NSMetadataQueryDidStartGatheringNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryDidStartGatheringNotification');
end;

function NSMetadataQueryGatheringProgressNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryGatheringProgressNotification');
end;

function NSMetadataQueryDidFinishGatheringNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryDidFinishGatheringNotification');
end;

function NSMetadataQueryDidUpdateNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryDidUpdateNotification');
end;

function NSMetadataQueryUpdateAddedItemsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryUpdateAddedItemsKey');
end;

function NSMetadataQueryUpdateChangedItemsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryUpdateChangedItemsKey');
end;

function NSMetadataQueryUpdateRemovedItemsKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryUpdateRemovedItemsKey');
end;

function NSMetadataQueryResultContentRelevanceAttribute: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryResultContentRelevanceAttribute');
end;

function NSMetadataQueryUserHomeScope: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryUserHomeScope');
end;

function NSMetadataQueryLocalComputerScope: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryLocalComputerScope');
end;

function NSMetadataQueryNetworkScope: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryNetworkScope');
end;

function NSMetadataQueryIndexedLocalComputerScope: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryIndexedLocalComputerScope');
end;

function NSMetadataQueryIndexedNetworkScope: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryIndexedNetworkScope');
end;

function NSMetadataQueryUbiquitousDocumentsScope: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryUbiquitousDocumentsScope');
end;

function NSMetadataQueryUbiquitousDataScope: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryUbiquitousDataScope');
end;

function NSMetadataQueryAccessibleUbiquitousExternalDocumentsScope: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSMetadataQueryAccessibleUbiquitousExternalDocumentsScope');
end;

function NSNetServicesErrorCode: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSNetServicesErrorCode');
end;

function NSNetServicesErrorDomain: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSNetServicesErrorDomain');
end;

function NSProgressEstimatedTimeRemainingKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSProgressEstimatedTimeRemainingKey');
end;

function NSProgressThroughputKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSProgressThroughputKey');
end;

function NSProgressKindFile: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSProgressKindFile');
end;

function NSProgressFileOperationKindKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSProgressFileOperationKindKey');
end;

function NSProgressFileOperationKindDownloading: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSProgressFileOperationKindDownloading');
end;

function NSProgressFileOperationKindDecompressingAfterDownloading: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSProgressFileOperationKindDecompressingAfterDownloading');
end;

function NSProgressFileOperationKindReceiving: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSProgressFileOperationKindReceiving');
end;

function NSProgressFileOperationKindCopying: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSProgressFileOperationKindCopying');
end;

function NSProgressFileURLKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSProgressFileURLKey');
end;

function NSProgressFileTotalCountKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSProgressFileTotalCountKey');
end;

function NSProgressFileCompletedCountKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSProgressFileCompletedCountKey');
end;

function NSProgressFileAnimationImageKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSProgressFileAnimationImageKey');
end;

function NSProgressFileAnimationImageOriginalRectKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSProgressFileAnimationImageOriginalRectKey');
end;

function NSProgressFileIconKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSProgressFileIconKey');
end;

function NSUbiquitousKeyValueStoreDidChangeExternallyNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUbiquitousKeyValueStoreDidChangeExternallyNotification');
end;

function NSUbiquitousKeyValueStoreChangeReasonKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUbiquitousKeyValueStoreChangeReasonKey');
end;

function NSUbiquitousKeyValueStoreChangedKeysKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUbiquitousKeyValueStoreChangedKeysKey');
end;

function NSUndoManagerGroupIsDiscardableKey: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUndoManagerGroupIsDiscardableKey');
end;

function NSUndoManagerCheckpointNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUndoManagerCheckpointNotification');
end;

function NSUndoManagerWillUndoChangeNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUndoManagerWillUndoChangeNotification');
end;

function NSUndoManagerWillRedoChangeNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUndoManagerWillRedoChangeNotification');
end;

function NSUndoManagerDidUndoChangeNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUndoManagerDidUndoChangeNotification');
end;

function NSUndoManagerDidRedoChangeNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUndoManagerDidRedoChangeNotification');
end;

function NSUndoManagerDidOpenUndoGroupNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUndoManagerDidOpenUndoGroupNotification');
end;

function NSUndoManagerWillCloseUndoGroupNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUndoManagerWillCloseUndoGroupNotification');
end;

function NSUndoManagerDidCloseUndoGroupNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUndoManagerDidCloseUndoGroupNotification');
end;

function NSURLSessionDownloadTaskResumeData: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSURLSessionDownloadTaskResumeData');
end;

function NSUserActivityTypeBrowsingWeb: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUserActivityTypeBrowsingWeb');
end;

function NSInconsistentArchiveException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSInconsistentArchiveException');
end;

function NSConnectionReplyMode: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSConnectionReplyMode');
end;

function NSConnectionDidDieNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSConnectionDidDieNotification');
end;

function NSFailedAuthenticationException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSFailedAuthenticationException');
end;

function NSConnectionDidInitializeNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSConnectionDidInitializeNotification');
end;

function NSLocalNotificationCenterType: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSLocalNotificationCenterType');
end;

function NSTaskDidTerminateNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSTaskDidTerminateNotification');
end;

function NSAppleEventManagerWillProcessFirstEventNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSAppleEventManagerWillProcessFirstEventNotification');
end;

function NSAppleScriptErrorMessage: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSAppleScriptErrorMessage');
end;

function NSAppleScriptErrorNumber: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSAppleScriptErrorNumber');
end;

function NSAppleScriptErrorAppName: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSAppleScriptErrorAppName');
end;

function NSAppleScriptErrorBriefMessage: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSAppleScriptErrorBriefMessage');
end;

function NSAppleScriptErrorRange: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSAppleScriptErrorRange');
end;

function NSClassDescriptionNeededForClassNotification: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSClassDescriptionNeededForClassNotification');
end;

function NSOperationNotSupportedForKeyException: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSOperationNotSupportedForKeyException');
end;

function NSGrammarRange: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSGrammarRange');
end;

function NSGrammarUserDescription: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSGrammarUserDescription');
end;

function NSGrammarCorrections: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSGrammarCorrections');
end;

function NSUserNotificationDefaultSoundName: NSString;
begin
  result := CocoaNSStringConst(libFoundation, 'NSUserNotificationDefaultSoundName');
end;

function NSFoundationVersionNumber: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSFoundationVersionNumber');
end;

function NSIntegerHashCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSIntegerHashCallBacks');
end;

function NSNonOwnedPointerHashCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSNonOwnedPointerHashCallBacks');
end;

function NSNonRetainedObjectHashCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSNonRetainedObjectHashCallBacks');
end;

function NSObjectHashCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSObjectHashCallBacks');
end;

function NSOwnedObjectIdentityHashCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSOwnedObjectIdentityHashCallBacks');
end;

function NSOwnedPointerHashCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSOwnedPointerHashCallBacks');
end;

function NSPointerToStructHashCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSPointerToStructHashCallBacks');
end;

function NSIntHashCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSIntHashCallBacks');
end;

function NSZeroPoint: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSZeroPoint');
end;

function NSZeroSize: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSZeroSize');
end;

function NSZeroRect: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSZeroRect');
end;

function NSEdgeInsetsZero: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSEdgeInsetsZero');
end;

function NSIntegerMapKeyCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSIntegerMapKeyCallBacks');
end;

function NSNonOwnedPointerMapKeyCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSNonOwnedPointerMapKeyCallBacks');
end;

function NSNonOwnedPointerOrNullMapKeyCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSNonOwnedPointerOrNullMapKeyCallBacks');
end;

function NSNonRetainedObjectMapKeyCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSNonRetainedObjectMapKeyCallBacks');
end;

function NSObjectMapKeyCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSObjectMapKeyCallBacks');
end;

function NSOwnedPointerMapKeyCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSOwnedPointerMapKeyCallBacks');
end;

function NSIntMapKeyCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSIntMapKeyCallBacks');
end;

function NSIntegerMapValueCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSIntegerMapValueCallBacks');
end;

function NSNonOwnedPointerMapValueCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSNonOwnedPointerMapValueCallBacks');
end;

function NSObjectMapValueCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSObjectMapValueCallBacks');
end;

function NSNonRetainedObjectMapValueCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSNonRetainedObjectMapValueCallBacks');
end;

function NSOwnedPointerMapValueCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSOwnedPointerMapValueCallBacks');
end;

function NSIntMapValueCallBacks: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSIntMapValueCallBacks');
end;

function NSURLSessionTransferSizeUnknown: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSURLSessionTransferSizeUnknown');
end;

function NSURLSessionTaskPriorityDefault: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSURLSessionTaskPriorityDefault');
end;

function NSURLSessionTaskPriorityLow: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSURLSessionTaskPriorityLow');
end;

function NSURLSessionTaskPriorityHigh: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSURLSessionTaskPriorityHigh');
end;

function NSAppleEventTimeOutDefault: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSAppleEventTimeOutDefault');
end;

function NSAppleEventTimeOutNone: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSAppleEventTimeOutNone');
end;

function NSDebugEnabled: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSDebugEnabled');
end;

function NSZombieEnabled: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSZombieEnabled');
end;

function NSDeallocateZombies: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSDeallocateZombies');
end;

function NSKeepAllocationStatistics: Pointer;
begin
  result := CocoaPointerConst(libFoundation, 'NSKeepAllocationStatistics');
end;

var
  CLModule: THandle;

initialization
  CLModule := LoadLibrary(PChar(libFoundation));

finalization
  FreeFrameworkDic;
  FreeLibrary(CLModule);
end.
