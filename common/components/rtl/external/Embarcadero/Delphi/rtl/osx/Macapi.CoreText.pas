{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework CoreText 
//
unit Macapi.CoreText;

{$WEAKPACKAGEUNIT}

interface

uses
  Macapi.ObjCRuntime,
  Macapi.ObjectiveC,
  Macapi.CocoaTypes,
//  Macapi.ATS,
  Macapi.CoreGraphics,
  Macapi.CoreFoundation,
  Macapi.CoreServices;
//  Macapi.Accelerate;


const
  kCTAdobeCNS1CharacterCollection = 1;
  kCTAdobeGB1CharacterCollection = 2;
  kCTAdobeJapan1CharacterCollection = 3;
  kCTAdobeJapan2CharacterCollection = 4;
  kCTAdobeKorea1CharacterCollection = 5;
  kCTCenterTextAlignment = 2;
  kCTFontAlertHeaderFontType = 18;
  kCTFontApplicationFontType = 9;
  kCTFontBoldTrait = 2;
  kCTFontClarendonSerifsClass = 1073741824;
  kCTFontClassMaskShift = 28;
  kCTFontClassMaskTrait = -268435456;
  kCTFontCondensedTrait = 64;
  kCTFontControlContentFontType = 26;
  kCTFontDefaultOrientation = 0;
  kCTFontEmphasizedSystemDetailFontType = 20;
  kCTFontEmphasizedSystemFontType = 3;
  kCTFontExpandedTrait = 32;
  kCTFontFormatBitmap = 5;
  kCTFontFormatOpenTypePostScript = 1;
  kCTFontFormatOpenTypeTrueType = 2;
  kCTFontFormatPostScript = 4;
  kCTFontFormatTrueType = 3;
  kCTFontFormatUnrecognized = 0;
  kCTFontFreeformSerifsClass = 1879048192;
  kCTFontHorizontalOrientation = 1;
  kCTFontItalicTrait = 1;
  kCTFontLabelFontType = 10;
  kCTFontManagerAutoActivationDefault = 0;
  kCTFontManagerAutoActivationDisabled = 1;
  kCTFontManagerAutoActivationEnabled = 2;
  kCTFontManagerAutoActivationPromptUser = 3;
  kCTFontManagerErrorAlreadyRegistered = 105;
  kCTFontManagerErrorFileNotFound = 101;
  kCTFontManagerErrorInUse = 202;
  kCTFontManagerErrorInsufficientPermissions = 102;
  kCTFontManagerErrorInvalidFontData = 104;
  kCTFontManagerErrorNotRegistered = 201;
  kCTFontManagerErrorSystemRequired = 202;
  kCTFontManagerErrorUnrecognizedFormat = 103;
  kCTFontManagerScopeNone = 0;
  kCTFontManagerScopeProcess = 1;
  kCTFontManagerScopeSession = 3;
  kCTFontManagerScopeUser = 2;
  kCTFontMenuItemCmdKeyFontType = 14;
  kCTFontMenuItemFontType = 12;
  kCTFontMenuItemMarkFontType = 13;
  kCTFontMenuTitleFontType = 11;
  kCTFontMessageFontType = 23;
  kCTFontMiniEmphasizedSystemFontType = 7;
  kCTFontMiniSystemFontType = 6;
  kCTFontModernSerifsClass = 805306368;
  kCTFontMonoSpaceTrait = 1024;
  kCTFontNoFontType = -1;
  kCTFontOldStyleSerifsClass = 268435456;
  kCTFontOptionsDefault = 0;
  kCTFontOptionsPreferSystemFont = 4;
  kCTFontOptionsPreventAutoActivation = 1;
  kCTFontOrnamentalsClass = -1879048192;
  kCTFontPaletteFontType = 24;
  kCTFontPriorityComputer = 30000;
  kCTFontPriorityDynamic = 50000;
  kCTFontPriorityNetwork = 20000;
  kCTFontPriorityProcess = 60000;
  kCTFontPrioritySystem = 10000;
  kCTFontPriorityUser = 40000;
  kCTFontPushButtonFontType = 16;
  kCTFontSansSerifClass = -2147483648;
  kCTFontScriptsClass = -1610612736;
  kCTFontSlabSerifsClass = 1342177280;
  kCTFontSmallEmphasizedSystemFontType = 5;
  kCTFontSmallSystemFontType = 4;
  kCTFontSmallToolbarFontType = 22;
  kCTFontSymbolicClass = -1073741824;
  kCTFontSystemDetailFontType = 19;
  kCTFontSystemFontType = 2;
  kCTFontTableAcnt = 1633906292;
  kCTFontTableAvar = 1635148146;
  kCTFontTableBASE = 1111577413;
  kCTFontTableBdat = 1650745716;
  kCTFontTableBhed = 1651008868;
  kCTFontTableBloc = 1651273571;
  kCTFontTableBsln = 1651731566;
  kCTFontTableCFF = 1128678944;
  kCTFontTableCmap = 1668112752;
  kCTFontTableCvar = 1668702578;
  kCTFontTableCvt = 1668707360;
  kCTFontTableDSIG = 1146308935;
  kCTFontTableEBDT = 1161970772;
  kCTFontTableEBLC = 1161972803;
  kCTFontTableEBSC = 1161974595;
  kCTFontTableFdsc = 1717859171;
  kCTFontTableFeat = 1717920116;
  kCTFontTableFmtx = 1718449272;
  kCTFontTableFpgm = 1718642541;
  kCTFontTableFvar = 1719034226;
  kCTFontTableGDEF = 1195656518;
  kCTFontTableGPOS = 1196445523;
  kCTFontTableGSUB = 1196643650;
  kCTFontTableGasp = 1734439792;
  kCTFontTableGlyf = 1735162214;
  kCTFontTableGvar = 1735811442;
  kCTFontTableHdmx = 1751412088;
  kCTFontTableHead = 1751474532;
  kCTFontTableHhea = 1751672161;
  kCTFontTableHmtx = 1752003704;
  kCTFontTableHsty = 1752396921;
  kCTFontTableJSTF = 1246975046;
  kCTFontTableJust = 1786082164;
  kCTFontTableKern = 1801810542;
  kCTFontTableLTSH = 1280594760;
  kCTFontTableLcar = 1818452338;
  kCTFontTableLoca = 1819239265;
  kCTFontTableMaxp = 1835104368;
  kCTFontTableMort = 1836020340;
  kCTFontTableMorx = 1836020344;
  kCTFontTableName = 1851878757;
  kCTFontTableOS2 = 1330851634;
  kCTFontTableOpbd = 1869636196;
  kCTFontTableOptionExcludeSynthetic = 1;
  kCTFontTableOptionNoOptions = 0;
  kCTFontTablePCLT = 1346587732;
  kCTFontTablePost = 1886352244;
  kCTFontTablePrep = 1886545264;
  kCTFontTableProp = 1886547824;
  kCTFontTableTrak = 1953653099;
  kCTFontTableVDMX = 1447316824;
  kCTFontTableVORG = 1448038983;
  kCTFontTableVhea = 1986553185;
  kCTFontTableVmtx = 1986884728;
  kCTFontTableZapf = 1516335206;
  kCTFontToolTipFontType = 25;
  kCTFontToolbarFontType = 21;
  kCTFontTransitionalSerifsClass = 536870912;
  kCTFontUIOptimizedTrait = 4096;
  kCTFontUnknownClass = 0;
  kCTFontUserFixedPitchFontType = 1;
  kCTFontUserFontType = 0;
  kCTFontUtilityWindowTitleFontType = 17;
  kCTFontVerticalOrientation = 2;
  kCTFontVerticalTrait = 2048;
  kCTFontViewsFontType = 8;
  kCTFontWindowTitleFontType = 15;
  kCTFrameProgressionRightToLeft = 1;
  kCTFrameProgressionTopToBottom = 0;
  kCTIdentityMappingCharacterCollection = 0;
  kCTJustifiedTextAlignment = 3;
  kCTLeftTextAlignment = 0;
  kCTLineBreakByCharWrapping = 1;
  kCTLineBreakByClipping = 2;
  kCTLineBreakByTruncatingHead = 3;
  kCTLineBreakByTruncatingMiddle = 5;
  kCTLineBreakByTruncatingTail = 4;
  kCTLineBreakByWordWrapping = 0;
  kCTLineTruncationEnd = 1;
  kCTLineTruncationMiddle = 2;
  kCTLineTruncationStart = 0;
  kCTNaturalTextAlignment = 4;
  kCTParagraphStyleSpecifierAlignment = 0;
  kCTParagraphStyleSpecifierBaseWritingDirection = 13;
  kCTParagraphStyleSpecifierCount = 14;
  kCTParagraphStyleSpecifierDefaultTabInterval = 5;
  kCTParagraphStyleSpecifierFirstLineHeadIndent = 1;
  kCTParagraphStyleSpecifierHeadIndent = 2;
  kCTParagraphStyleSpecifierLineBreakMode = 6;
  kCTParagraphStyleSpecifierLineHeightMultiple = 7;
  kCTParagraphStyleSpecifierLineSpacing = 10;
  kCTParagraphStyleSpecifierMaximumLineHeight = 8;
  kCTParagraphStyleSpecifierMinimumLineHeight = 9;
  kCTParagraphStyleSpecifierParagraphSpacing = 11;
  kCTParagraphStyleSpecifierParagraphSpacingBefore = 12;
  kCTParagraphStyleSpecifierTabStops = 4;
  kCTParagraphStyleSpecifierTailIndent = 3;
  kCTRightTextAlignment = 1;
  kCTRunStatusHasNonIdentityMatrix = 4;
  kCTRunStatusNoStatus = 0;
  kCTRunStatusNonMonotonic = 2;
  kCTRunStatusRightToLeft = 1;
  kCTUnderlinePatternDash = 512;
  kCTUnderlinePatternDashDot = 768;
  kCTUnderlinePatternDashDotDot = 1024;
  kCTUnderlinePatternDot = 256;
  kCTUnderlinePatternSolid = 0;
  kCTUnderlineStyleDouble = 9;
  kCTUnderlineStyleNone = 0;
  kCTUnderlineStyleSingle = 1;
  kCTUnderlineStyleThick = 2;
  kCTVersionNumber10_5 = 131072;
  kCTVersionNumber10_5_2 = 131073;
  kCTVersionNumber10_5_3 = 131074;
  kCTVersionNumber10_5_5 = 131075;
  kCTVersionNumber10_6 = 196608;
  kCTWritingDirectionLeftToRight = 0;
  kCTWritingDirectionNatural = -1;
  kCTWritingDirectionRightToLeft = 1;

// ===== External functions =====

const
  libCoreText = '/System/Library/Frameworks/ApplicationServices.framework/Frameworks/CoreText.framework/CoreText';

function CTFontCollectionCreateCopyWithFontDescriptors(original: CTFontCollectionRef; descriptors: CFArrayRef; options: CFDictionaryRef): CTFontCollectionRef; cdecl; external libCoreText name _PU + 'CTFontCollectionCreateCopyWithFontDescriptors';
function CTFontCollectionCreateFromAvailableFonts(options: CFDictionaryRef): CTFontCollectionRef; cdecl; external libCoreText name _PU + 'CTFontCollectionCreateFromAvailableFonts';
function CTFontCollectionCreateMatchingFontDescriptors(collection: CTFontCollectionRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontCollectionCreateMatchingFontDescriptors';
function CTFontCollectionCreateMatchingFontDescriptorsSortedWithCallback(collection: CTFontCollectionRef; sortCallback: CTFontCollectionSortDescriptorsCallback; refCon: Pointer): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontCollectionCreateMatchingFontDescriptorsSortedWithCallback';
function CTFontCollectionCreateWithFontDescriptors(descriptors: CFArrayRef; options: CFDictionaryRef): CTFontCollectionRef; cdecl; external libCoreText name _PU + 'CTFontCollectionCreateWithFontDescriptors';
function CTFontCollectionGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTFontCollectionGetTypeID';
function CTFontCopyAttribute(font: CTFontRef; attribute: CFStringRef): CFTypeRef; cdecl; external libCoreText name _PU + 'CTFontCopyAttribute';
function CTFontCopyAvailableTables(font: CTFontRef; options: CTFontTableOptions): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontCopyAvailableTables';
function CTFontCopyCharacterSet(font: CTFontRef): CFCharacterSetRef; cdecl; external libCoreText name _PU + 'CTFontCopyCharacterSet';
function CTFontCopyDisplayName(font: CTFontRef): CFStringRef; cdecl; external libCoreText name _PU + 'CTFontCopyDisplayName';
function CTFontCopyFamilyName(font: CTFontRef): CFStringRef; cdecl; external libCoreText name _PU + 'CTFontCopyFamilyName';
function CTFontCopyFeatureSettings(font: CTFontRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontCopyFeatureSettings';
function CTFontCopyFeatures(font: CTFontRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontCopyFeatures';
function CTFontCopyFontDescriptor(font: CTFontRef): CTFontDescriptorRef; cdecl; external libCoreText name _PU + 'CTFontCopyFontDescriptor';
function CTFontCopyFullName(font: CTFontRef): CFStringRef; cdecl; external libCoreText name _PU + 'CTFontCopyFullName';
function CTFontCopyGraphicsFont(font: CTFontRef; attributes: PCTFontDescriptorRef): CGFontRef; cdecl; external libCoreText name _PU + 'CTFontCopyGraphicsFont';
function CTFontCopyLocalizedName(font: CTFontRef; nameKey: CFStringRef; language: PCFStringRef): CFStringRef; cdecl; external libCoreText name _PU + 'CTFontCopyLocalizedName';
function CTFontCopyName(font: CTFontRef; nameKey: CFStringRef): CFStringRef; cdecl; external libCoreText name _PU + 'CTFontCopyName';
function CTFontCopyPostScriptName(font: CTFontRef): CFStringRef; cdecl; external libCoreText name _PU + 'CTFontCopyPostScriptName';
function CTFontCopySupportedLanguages(font: CTFontRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontCopySupportedLanguages';
function CTFontCopyTable(font: CTFontRef; table: CTFontTableTag; options: CTFontTableOptions): CFDataRef; cdecl; external libCoreText name _PU + 'CTFontCopyTable';
function CTFontCopyTraits(font: CTFontRef): CFDictionaryRef; cdecl; external libCoreText name _PU + 'CTFontCopyTraits';
function CTFontCopyVariation(font: CTFontRef): CFDictionaryRef; cdecl; external libCoreText name _PU + 'CTFontCopyVariation';
function CTFontCopyVariationAxes(font: CTFontRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontCopyVariationAxes';
function CTFontCreateCopyWithAttributes(font: CTFontRef; size: Single; matrix: PCGAffineTransform; attributes: CTFontDescriptorRef): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateCopyWithAttributes';
function CTFontCreateCopyWithFamily(font: CTFontRef; size: Single; matrix: PCGAffineTransform; family: CFStringRef): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateCopyWithFamily';
function CTFontCreateCopyWithSymbolicTraits(font: CTFontRef; size: Single; matrix: PCGAffineTransform; symTraitValue: CTFontSymbolicTraits; symTraitMask: CTFontSymbolicTraits): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateCopyWithSymbolicTraits';
function CTFontCreateForString(currentFont: CTFontRef; string_: CFStringRef; range: CFRange): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateForString';
function CTFontCreatePathForGlyph(font: CTFontRef; glyph: CGGlyph; transform: PCGAffineTransform): CGPathRef; cdecl; external libCoreText name _PU + 'CTFontCreatePathForGlyph';
function CTFontCreateUIFontForLanguage(uiType: CTFontUIFontType; size: Single; language: CFStringRef): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateUIFontForLanguage';
function CTFontCreateWithFontDescriptor(descriptor: CTFontDescriptorRef; size: Single; matrix: PCGAffineTransform): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateWithFontDescriptor';
function CTFontCreateWithFontDescriptorAndOptions(descriptor: CTFontDescriptorRef; size: Single; matrix: PCGAffineTransform; options: CTFontOptions): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateWithFontDescriptorAndOptions';
function CTFontCreateWithGraphicsFont(graphicsFont: CGFontRef; size: Single; matrix: PCGAffineTransform; attributes: CTFontDescriptorRef): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateWithGraphicsFont';
function CTFontCreateWithName(name: CFStringRef; size: Single; matrix: PCGAffineTransform): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateWithName';
function CTFontCreateWithNameAndOptions(name: CFStringRef; size: Single; matrix: PCGAffineTransform; options: CTFontOptions): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateWithNameAndOptions';
function CTFontCreateWithPlatformFont(platformFont: ATSFontRef; size: Single; matrix: PCGAffineTransform; attributes: CTFontDescriptorRef): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateWithPlatformFont';
function CTFontCreateWithQuickdrawInstance(name: ConstStr255Param; identifier: Smallint; style: Byte; size: Single): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateWithQuickdrawInstance';
function CTFontDescriptorCopyAttribute(descriptor: CTFontDescriptorRef; attribute: CFStringRef): CFTypeRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCopyAttribute';
function CTFontDescriptorCopyAttributes(descriptor: CTFontDescriptorRef): CFDictionaryRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCopyAttributes';
function CTFontDescriptorCopyLocalizedAttribute(descriptor: CTFontDescriptorRef; attribute: CFStringRef; language: PCFStringRef): CFTypeRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCopyLocalizedAttribute';
function CTFontDescriptorCreateCopyWithAttributes(original: CTFontDescriptorRef; attributes: CFDictionaryRef): CTFontDescriptorRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCreateCopyWithAttributes';
function CTFontDescriptorCreateCopyWithFeature(original: CTFontDescriptorRef; featureTypeIdentifier: CFNumberRef; featureSelectorIdentifier: CFNumberRef): CTFontDescriptorRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCreateCopyWithFeature';
function CTFontDescriptorCreateCopyWithVariation(original: CTFontDescriptorRef; variationIdentifier: CFNumberRef; variationValue: Single): CTFontDescriptorRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCreateCopyWithVariation';
function CTFontDescriptorCreateMatchingFontDescriptor(descriptor: CTFontDescriptorRef; mandatoryAttributes: CFSetRef): CTFontDescriptorRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCreateMatchingFontDescriptor';
function CTFontDescriptorCreateMatchingFontDescriptors(descriptor: CTFontDescriptorRef; mandatoryAttributes: CFSetRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCreateMatchingFontDescriptors';
function CTFontDescriptorCreateWithAttributes(attributes: CFDictionaryRef): CTFontDescriptorRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCreateWithAttributes';
function CTFontDescriptorCreateWithNameAndSize(name: CFStringRef; size: Single): CTFontDescriptorRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCreateWithNameAndSize';
function CTFontDescriptorGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTFontDescriptorGetTypeID';
function CTFontGetAdvancesForGlyphs(font: CTFontRef; orientation: CTFontOrientation; glyphs: PCGGlyph; advances: PCGSize; count: CFIndex): double; cdecl; external libCoreText name _PU + 'CTFontGetAdvancesForGlyphs';
function CTFontGetAscent(font: CTFontRef): Single; cdecl; external libCoreText name _PU + 'CTFontGetAscent';
function CTFontGetBoundingBox(font: CTFontRef): CGRect; cdecl; external libCoreText name _PU + 'CTFontGetBoundingBox';
function CTFontGetBoundingRectsForGlyphs(font: CTFontRef; orientation: CTFontOrientation; glyphs: PCGGlyph; boundingRects: PCGRect; count: CFIndex): CGRect; cdecl; external libCoreText name _PU + 'CTFontGetBoundingRectsForGlyphs';
function CTFontGetCapHeight(font: CTFontRef): Single; cdecl; external libCoreText name _PU + 'CTFontGetCapHeight';
function CTFontGetDescent(font: CTFontRef): Single; cdecl; external libCoreText name _PU + 'CTFontGetDescent';
function CTFontGetGlyphCount(font: CTFontRef): CFIndex; cdecl; external libCoreText name _PU + 'CTFontGetGlyphCount';
function CTFontGetGlyphWithName(font: CTFontRef; glyphName: CFStringRef): CGGlyph; cdecl; external libCoreText name _PU + 'CTFontGetGlyphWithName';
function CTFontGetGlyphsForCharacters(font: CTFontRef; characters: PUniChar; glyphs: PCGGlyph; count: CFIndex): Integer; cdecl; external libCoreText name _PU + 'CTFontGetGlyphsForCharacters';
function CTFontGetLeading(font: CTFontRef): Single; cdecl; external libCoreText name _PU + 'CTFontGetLeading';
function CTFontGetMatrix(font: CTFontRef): CGAffineTransform; cdecl; external libCoreText name _PU + 'CTFontGetMatrix';
function CTFontGetPlatformFont(font: CTFontRef; attributes: PCTFontDescriptorRef): ATSFontRef; cdecl; external libCoreText name _PU + 'CTFontGetPlatformFont';
function CTFontGetSize(font: CTFontRef): Single; cdecl; external libCoreText name _PU + 'CTFontGetSize';
function CTFontGetSlantAngle(font: CTFontRef): Single; cdecl; external libCoreText name _PU + 'CTFontGetSlantAngle';
function CTFontGetStringEncoding(font: CTFontRef): CFStringEncoding; cdecl; external libCoreText name _PU + 'CTFontGetStringEncoding';
function CTFontGetSymbolicTraits(font: CTFontRef): CTFontSymbolicTraits; cdecl; external libCoreText name _PU + 'CTFontGetSymbolicTraits';
function CTFontGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTFontGetTypeID';
function CTFontGetUnderlinePosition(font: CTFontRef): Single; cdecl; external libCoreText name _PU + 'CTFontGetUnderlinePosition';
function CTFontGetUnderlineThickness(font: CTFontRef): Single; cdecl; external libCoreText name _PU + 'CTFontGetUnderlineThickness';
function CTFontGetUnitsPerEm(font: CTFontRef): Longword; cdecl; external libCoreText name _PU + 'CTFontGetUnitsPerEm';
procedure CTFontGetVerticalTranslationsForGlyphs(font: CTFontRef; glyphs: PCGGlyph; translations: PCGSize; count: CFIndex); cdecl; external libCoreText name _PU + 'CTFontGetVerticalTranslationsForGlyphs';
function CTFontGetXHeight(font: CTFontRef): Single; cdecl; external libCoreText name _PU + 'CTFontGetXHeight';
function CTFontManagerCompareFontFamilyNames(family1: Pointer; family2: Pointer; context: Pointer): CFComparisonResult; cdecl; external libCoreText name _PU + 'CTFontManagerCompareFontFamilyNames';
function CTFontManagerCopyAvailableFontFamilyNames: CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontManagerCopyAvailableFontFamilyNames';
function CTFontManagerCopyAvailableFontURLs: CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontManagerCopyAvailableFontURLs';
function CTFontManagerCopyAvailablePostScriptNames: CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontManagerCopyAvailablePostScriptNames';
function CTFontManagerCreateFontDescriptorsFromURL(fileURL: CFURLRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontManagerCreateFontDescriptorsFromURL';
procedure CTFontManagerEnableFontDescriptors(descriptors: CFArrayRef; enable: Integer); cdecl; external libCoreText name _PU + 'CTFontManagerEnableFontDescriptors';
function CTFontManagerGetAutoActivationSetting(bundleIdentifier: CFStringRef): CTFontManagerAutoActivationSetting; cdecl; external libCoreText name _PU + 'CTFontManagerGetAutoActivationSetting';
function CTFontManagerGetScopeForURL(fontURL: CFURLRef): CTFontManagerScope; cdecl; external libCoreText name _PU + 'CTFontManagerGetScopeForURL';
function CTFontManagerIsSupportedFont(fontURL: CFURLRef): Integer; cdecl; external libCoreText name _PU + 'CTFontManagerIsSupportedFont';
function CTFontManagerRegisterFontsForURL(fontURL: CFURLRef; scope: CTFontManagerScope; error: PCFErrorRef): Integer; cdecl; external libCoreText name _PU + 'CTFontManagerRegisterFontsForURL';
function CTFontManagerRegisterFontsForURLs(fontURLs: CFArrayRef; scope: CTFontManagerScope; errors: PCFArrayRef): Integer; cdecl; external libCoreText name _PU + 'CTFontManagerRegisterFontsForURLs';
procedure CTFontManagerSetAutoActivationSetting(bundleIdentifier: CFStringRef; setting: CTFontManagerAutoActivationSetting); cdecl; external libCoreText name _PU + 'CTFontManagerSetAutoActivationSetting';
function CTFontManagerUnregisterFontsForURL(fontURL: CFURLRef; scope: CTFontManagerScope; error: PCFErrorRef): Integer; cdecl; external libCoreText name _PU + 'CTFontManagerUnregisterFontsForURL';
function CTFontManagerUnregisterFontsForURLs(fontURLs: CFArrayRef; scope: CTFontManagerScope; errors: PCFArrayRef): Integer; cdecl; external libCoreText name _PU + 'CTFontManagerUnregisterFontsForURLs';
procedure CTFrameDraw(frame: CTFrameRef; context: CGContextRef); cdecl; external libCoreText name _PU + 'CTFrameDraw';
function CTFrameGetFrameAttributes(frame: CTFrameRef): CFDictionaryRef; cdecl; external libCoreText name _PU + 'CTFrameGetFrameAttributes';
procedure CTFrameGetLineOrigins(frame: CTFrameRef; range: CFRange; origins: PCGPoint); cdecl; external libCoreText name _PU + 'CTFrameGetLineOrigins';
function CTFrameGetLines(frame: CTFrameRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFrameGetLines';
function CTFrameGetPath(frame: CTFrameRef): CGPathRef; cdecl; external libCoreText name _PU + 'CTFrameGetPath';
function CTFrameGetStringRange(frame: CTFrameRef): CFRange; cdecl; external libCoreText name _PU + 'CTFrameGetStringRange';
function CTFrameGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTFrameGetTypeID';
function CTFrameGetVisibleStringRange(frame: CTFrameRef): CFRange; cdecl; external libCoreText name _PU + 'CTFrameGetVisibleStringRange';
function CTFramesetterCreateFrame(framesetter: CTFramesetterRef; stringRange: CFRange; path: CGPathRef; frameAttributes: CFDictionaryRef): CTFrameRef; cdecl; external libCoreText name _PU + 'CTFramesetterCreateFrame';
function CTFramesetterCreateWithAttributedString(string_: CFAttributedStringRef): CTFramesetterRef; cdecl; external libCoreText name _PU + 'CTFramesetterCreateWithAttributedString';
function CTFramesetterGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTFramesetterGetTypeID';
function CTFramesetterGetTypesetter(framesetter: CTFramesetterRef): CTTypesetterRef; cdecl; external libCoreText name _PU + 'CTFramesetterGetTypesetter';
function CTFramesetterSuggestFrameSizeWithConstraints(framesetter: CTFramesetterRef; stringRange: CFRange; frameAttributes: CFDictionaryRef; constraints: CGSize; fitRange: PCFRange): CGSize; cdecl; external libCoreText name _PU + 'CTFramesetterSuggestFrameSizeWithConstraints';
function CTGetCoreTextVersion: Longword; cdecl; external libCoreText name _PU + 'CTGetCoreTextVersion';
function CTGlyphInfoCreateWithCharacterIdentifier(cid: CGFontIndex; collection: CTCharacterCollection; baseString: CFStringRef): CTGlyphInfoRef; cdecl; external libCoreText name _PU + 'CTGlyphInfoCreateWithCharacterIdentifier';
function CTGlyphInfoCreateWithGlyph(glyph: CGGlyph; font: CTFontRef; baseString: CFStringRef): CTGlyphInfoRef; cdecl; external libCoreText name _PU + 'CTGlyphInfoCreateWithGlyph';
function CTGlyphInfoCreateWithGlyphName(glyphName: CFStringRef; font: CTFontRef; baseString: CFStringRef): CTGlyphInfoRef; cdecl; external libCoreText name _PU + 'CTGlyphInfoCreateWithGlyphName';
function CTGlyphInfoGetCharacterCollection(glyphInfo: CTGlyphInfoRef): CTCharacterCollection; cdecl; external libCoreText name _PU + 'CTGlyphInfoGetCharacterCollection';
function CTGlyphInfoGetCharacterIdentifier(glyphInfo: CTGlyphInfoRef): CGFontIndex; cdecl; external libCoreText name _PU + 'CTGlyphInfoGetCharacterIdentifier';
function CTGlyphInfoGetGlyphName(glyphInfo: CTGlyphInfoRef): CFStringRef; cdecl; external libCoreText name _PU + 'CTGlyphInfoGetGlyphName';
function CTGlyphInfoGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTGlyphInfoGetTypeID';
function CTLineCreateJustifiedLine(line: CTLineRef; justificationFactor: Single; justificationWidth: double): CTLineRef; cdecl; external libCoreText name _PU + 'CTLineCreateJustifiedLine';
function CTLineCreateTruncatedLine(line: CTLineRef; width: double; truncationType: CTLineTruncationType; truncationToken: CTLineRef): CTLineRef; cdecl; external libCoreText name _PU + 'CTLineCreateTruncatedLine';
function CTLineCreateWithAttributedString(string_: CFAttributedStringRef): CTLineRef; cdecl; external libCoreText name _PU + 'CTLineCreateWithAttributedString';
procedure CTLineDraw(line: CTLineRef; context: CGContextRef); cdecl; external libCoreText name _PU + 'CTLineDraw';
function CTLineGetGlyphCount(line: CTLineRef): CFIndex; cdecl; external libCoreText name _PU + 'CTLineGetGlyphCount';
function CTLineGetGlyphRuns(line: CTLineRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTLineGetGlyphRuns';
function CTLineGetImageBounds(line: CTLineRef; context: CGContextRef): CGRect; cdecl; external libCoreText name _PU + 'CTLineGetImageBounds';
function CTLineGetOffsetForStringIndex(line: CTLineRef; charIndex: CFIndex; secondaryOffset: PSingle): Single; cdecl; external libCoreText name _PU + 'CTLineGetOffsetForStringIndex';
function CTLineGetPenOffsetForFlush(line: CTLineRef; flushFactor: Single; flushWidth: double): double; cdecl; external libCoreText name _PU + 'CTLineGetPenOffsetForFlush';
function CTLineGetStringIndexForPosition(line: CTLineRef; position: CGPoint): CFIndex; cdecl; external libCoreText name _PU + 'CTLineGetStringIndexForPosition';
function CTLineGetStringRange(line: CTLineRef): CFRange; cdecl; external libCoreText name _PU + 'CTLineGetStringRange';
function CTLineGetTrailingWhitespaceWidth(line: CTLineRef): double; cdecl; external libCoreText name _PU + 'CTLineGetTrailingWhitespaceWidth';
function CTLineGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTLineGetTypeID';
function CTLineGetTypographicBounds(line: CTLineRef; ascent: PSingle; descent: PSingle; leading: PSingle): double; cdecl; external libCoreText name _PU + 'CTLineGetTypographicBounds';
function CTParagraphStyleCreate(settings: PCTParagraphStyleSetting; settingCount: CFIndex): CTParagraphStyleRef; cdecl; external libCoreText name _PU + 'CTParagraphStyleCreate';
function CTParagraphStyleCreateCopy(paragraphStyle: CTParagraphStyleRef): CTParagraphStyleRef; cdecl; external libCoreText name _PU + 'CTParagraphStyleCreateCopy';
function CTParagraphStyleGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTParagraphStyleGetTypeID';
function CTParagraphStyleGetValueForSpecifier(paragraphStyle: CTParagraphStyleRef; spec: CTParagraphStyleSpecifier; valueBufferSize: Longword; valueBuffer: Pointer): Integer; cdecl; external libCoreText name _PU + 'CTParagraphStyleGetValueForSpecifier';
procedure CTRunDraw(run: CTRunRef; context: CGContextRef; range: CFRange); cdecl; external libCoreText name _PU + 'CTRunDraw';
procedure CTRunGetAdvances(run: CTRunRef; range: CFRange; buffer: PCGSize); cdecl; external libCoreText name _PU + 'CTRunGetAdvances';
function CTRunGetAdvancesPtr(run: CTRunRef): PCGSize; cdecl; external libCoreText name _PU + 'CTRunGetAdvancesPtr';
function CTRunGetAttributes(run: CTRunRef): CFDictionaryRef; cdecl; external libCoreText name _PU + 'CTRunGetAttributes';
function CTRunGetGlyphCount(run: CTRunRef): CFIndex; cdecl; external libCoreText name _PU + 'CTRunGetGlyphCount';
procedure CTRunGetGlyphs(run: CTRunRef; range: CFRange; buffer: PCGGlyph); cdecl; external libCoreText name _PU + 'CTRunGetGlyphs';
function CTRunGetGlyphsPtr(run: CTRunRef): PCGGlyph; cdecl; external libCoreText name _PU + 'CTRunGetGlyphsPtr';
function CTRunGetImageBounds(run: CTRunRef; context: CGContextRef; range: CFRange): CGRect; cdecl; external libCoreText name _PU + 'CTRunGetImageBounds';
procedure CTRunGetPositions(run: CTRunRef; range: CFRange; buffer: PCGPoint); cdecl; external libCoreText name _PU + 'CTRunGetPositions';
function CTRunGetPositionsPtr(run: CTRunRef): PCGPoint; cdecl; external libCoreText name _PU + 'CTRunGetPositionsPtr';
function CTRunGetStatus(run: CTRunRef): CTRunStatus; cdecl; external libCoreText name _PU + 'CTRunGetStatus';
procedure CTRunGetStringIndices(run: CTRunRef; range: CFRange; buffer: PCFIndex); cdecl; external libCoreText name _PU + 'CTRunGetStringIndices';
function CTRunGetStringIndicesPtr(run: CTRunRef): PCFIndex; cdecl; external libCoreText name _PU + 'CTRunGetStringIndicesPtr';
function CTRunGetStringRange(run: CTRunRef): CFRange; cdecl; external libCoreText name _PU + 'CTRunGetStringRange';
function CTRunGetTextMatrix(run: CTRunRef): CGAffineTransform; cdecl; external libCoreText name _PU + 'CTRunGetTextMatrix';
function CTRunGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTRunGetTypeID';
function CTRunGetTypographicBounds(run: CTRunRef; range: CFRange; ascent: PSingle; descent: PSingle; leading: PSingle): double; cdecl; external libCoreText name _PU + 'CTRunGetTypographicBounds';
function CTTextTabCreate(alignment: CTTextAlignment; location: double; options: CFDictionaryRef): CTTextTabRef; cdecl; external libCoreText name _PU + 'CTTextTabCreate';
function CTTextTabGetAlignment(tab: CTTextTabRef): CTTextAlignment; cdecl; external libCoreText name _PU + 'CTTextTabGetAlignment';
function CTTextTabGetLocation(tab: CTTextTabRef): double; cdecl; external libCoreText name _PU + 'CTTextTabGetLocation';
function CTTextTabGetOptions(tab: CTTextTabRef): CFDictionaryRef; cdecl; external libCoreText name _PU + 'CTTextTabGetOptions';
function CTTextTabGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTTextTabGetTypeID';
function CTTypesetterCreateLine(typesetter: CTTypesetterRef; stringRange: CFRange): CTLineRef; cdecl; external libCoreText name _PU + 'CTTypesetterCreateLine';
function CTTypesetterCreateWithAttributedString(string_: CFAttributedStringRef): CTTypesetterRef; cdecl; external libCoreText name _PU + 'CTTypesetterCreateWithAttributedString';
function CTTypesetterCreateWithAttributedStringAndOptions(string_: CFAttributedStringRef; options: CFDictionaryRef): CTTypesetterRef; cdecl; external libCoreText name _PU + 'CTTypesetterCreateWithAttributedStringAndOptions';
function CTTypesetterGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTTypesetterGetTypeID';
function CTTypesetterSuggestClusterBreak(typesetter: CTTypesetterRef; startIndex: CFIndex; width: double): CFIndex; cdecl; external libCoreText name _PU + 'CTTypesetterSuggestClusterBreak';
function CTTypesetterSuggestLineBreak(typesetter: CTTypesetterRef; startIndex: CFIndex; width: double): CFIndex; cdecl; external libCoreText name _PU + 'CTTypesetterSuggestLineBreak';

// CoreText String Attributes

function kCTCharacterShapeAttributeName: Pointer;
function kCTFontAttributeName: Pointer;
function kCTKernAttributeName: Pointer;
function kCTLigatureAttributeName: Pointer;
function kCTForegroundColorAttributeName: Pointer;
function kCTForegroundColorFromContextAttributeName: Pointer;
function kCTParagraphStyleAttributeName: Pointer;
function kCTStrokeWidthAttributeName: Pointer;
function kCTStrokeColorAttributeName: Pointer;
function kCTSuperscriptAttributeName: Pointer;
function kCTUnderlineColorAttributeName: Pointer;
function kCTUnderlineStyleAttributeName: Pointer;
function kCTVerticalFormsAttributeName: Pointer;
function kCTGlyphInfoAttributeName: Pointer;

implementation

uses System.SysUtils;

{$REGION Internal variables for function results}
var
  kCTCharacterShapeAttributeName_: Pointer;
  kCTFontAttributeName_: Pointer;
  kCTKernAttributeName_: Pointer;
  kCTLigatureAttributeName_: Pointer;
  kCTForegroundColorAttributeName_: Pointer;
  kCTForegroundColorFromContextAttributeName_: Pointer;
  kCTParagraphStyleAttributeName_: Pointer;
  kCTStrokeWidthAttributeName_: Pointer;
  kCTStrokeColorAttributeName_: Pointer;
  kCTSuperscriptAttributeName_: Pointer;
  kCTUnderlineColorAttributeName_: Pointer;
  kCTUnderlineStyleAttributeName_: Pointer;
  kCTVerticalFormsAttributeName_: Pointer;
  kCTGlyphInfoAttributeName_: Pointer;
{$ENDREGION}

function GetCTAttributeObject(Attr: string): Pointer;
var
  CTLib: HMODULE;
begin
  CTLib := LoadLibrary(libCoreText);
  Result := Pointer(GetProcAddress(CTLib, PWideChar(Attr))^);
  FreeLibrary(CTLib);
end;

function kCTCharacterShapeAttributeName: Pointer;
begin
  if kCTCharacterShapeAttributeName_ = nil then
    kCTCharacterShapeAttributeName_ := GetCTAttributeObject('kCTCharacterShapeAttributeName');
  Result := kCTCharacterShapeAttributeName_;
end;

function kCTFontAttributeName: Pointer;
begin
  if kCTFontAttributeName_ = nil then
    kCTFontAttributeName_ := GetCTAttributeObject('kCTFontAttributeName');
  Result := kCTFontAttributeName_;
end;

function kCTKernAttributeName: Pointer;
begin
  if kCTKernAttributeName_ = nil then
    kCTKernAttributeName_ := GetCTAttributeObject('kCTKernAttributeName');
  Result := kCTKernAttributeName_;
end;

function kCTLigatureAttributeName: Pointer;
begin
  if kCTLigatureAttributeName_ = nil then
    kCTLigatureAttributeName_ := GetCTAttributeObject('kCTLigatureAttributeName');
  Result := kCTLigatureAttributeName_;
end;

function kCTForegroundColorAttributeName: Pointer;
begin
  if kCTForegroundColorAttributeName_ = nil then
    kCTForegroundColorAttributeName_ := GetCTAttributeObject('kCTForegroundColorAttributeName');
  Result := kCTForegroundColorAttributeName_;
end;

function kCTForegroundColorFromContextAttributeName: Pointer;
begin
  if kCTForegroundColorFromContextAttributeName_ = nil then
    kCTForegroundColorFromContextAttributeName_ := GetCTAttributeObject('kCTForegroundColorFromContextAttributeName');
  Result := kCTForegroundColorFromContextAttributeName_;
end;

function kCTParagraphStyleAttributeName: Pointer;
begin
  if kCTParagraphStyleAttributeName_ = nil then
    kCTParagraphStyleAttributeName_ := GetCTAttributeObject('kCTParagraphStyleAttributeName');
  Result := kCTParagraphStyleAttributeName_;
end;

function kCTStrokeWidthAttributeName: Pointer;
begin
  if kCTStrokeWidthAttributeName_ = nil then
    kCTStrokeWidthAttributeName_ := GetCTAttributeObject('kCTStrokeWidthAttributeName');
  Result := kCTStrokeWidthAttributeName_;
end;

function kCTStrokeColorAttributeName: Pointer;
begin
  if kCTStrokeColorAttributeName_ = nil then
    kCTStrokeColorAttributeName_ := GetCTAttributeObject('kCTStrokeColorAttributeName');
  Result := kCTStrokeColorAttributeName_;
end;

function kCTSuperscriptAttributeName: Pointer;
begin
  if kCTSuperscriptAttributeName_ = nil then
    kCTSuperscriptAttributeName_ := GetCTAttributeObject('kCTSuperscriptAttributeName');
  Result := kCTSuperscriptAttributeName_;
end;

function kCTUnderlineColorAttributeName: Pointer;
begin
  if kCTUnderlineColorAttributeName_ = nil then
    kCTUnderlineColorAttributeName_ := GetCTAttributeObject('kCTUnderlineColorAttributeName');
  Result := kCTUnderlineColorAttributeName_;
end;

function kCTUnderlineStyleAttributeName: Pointer;
begin
  if kCTUnderlineStyleAttributeName_ = nil then
    kCTUnderlineStyleAttributeName_ := GetCTAttributeObject('kCTUnderlineStyleAttributeName');
  Result := kCTUnderlineStyleAttributeName_;
end;

function kCTVerticalFormsAttributeName: Pointer;
begin
  if kCTVerticalFormsAttributeName_ = nil then
    kCTVerticalFormsAttributeName_ := GetCTAttributeObject('kCTVerticalFormsAttributeName');
  Result := kCTVerticalFormsAttributeName_;
end;

function kCTGlyphInfoAttributeName: Pointer;
begin
  if kCTGlyphInfoAttributeName_ = nil then
    kCTGlyphInfoAttributeName_ := GetCTAttributeObject('kCTGlyphInfoAttributeName');
  Result := kCTGlyphInfoAttributeName_;
end;

end.
