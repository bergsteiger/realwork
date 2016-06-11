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
// Interfaces for Cocoa framework CoreText 
//
unit Macapi.CoreText;

{$WEAKPACKAGEUNIT}

interface

uses
  Posix.StdDef,
  Macapi.ObjCRuntime,
  Macapi.ObjectiveC,  Macapi.CocoaTypes,
  Macapi.CoreGraphics,
  Macapi.CoreFoundation;


const
  kCTAdobeCNS1CharacterCollection = 1;
  {$EXTERNALSYM kCTAdobeCNS1CharacterCollection}
  kCTAdobeGB1CharacterCollection = 2;
  {$EXTERNALSYM kCTAdobeGB1CharacterCollection}
  kCTAdobeJapan1CharacterCollection = 3;
  {$EXTERNALSYM kCTAdobeJapan1CharacterCollection}
  kCTAdobeJapan2CharacterCollection = 4;
  {$EXTERNALSYM kCTAdobeJapan2CharacterCollection}
  kCTAdobeKorea1CharacterCollection = 5;
  {$EXTERNALSYM kCTAdobeKorea1CharacterCollection}
  kCTCenterTextAlignment = 2;
  {$EXTERNALSYM kCTCenterTextAlignment}
  kCTFontAlertHeaderFontType = 18;
  {$EXTERNALSYM kCTFontAlertHeaderFontType}
  kCTFontApplicationFontType = 9;
  {$EXTERNALSYM kCTFontApplicationFontType}
  kCTFontBoldTrait = 2;
  {$EXTERNALSYM kCTFontBoldTrait}
  kCTFontClarendonSerifsClass = 1073741824;
  {$EXTERNALSYM kCTFontClarendonSerifsClass}
  kCTFontClassMaskShift = 28;
  {$EXTERNALSYM kCTFontClassMaskShift}
  kCTFontClassMaskTrait = -268435456;
  {$EXTERNALSYM kCTFontClassMaskTrait}
  kCTFontCondensedTrait = 64;
  {$EXTERNALSYM kCTFontCondensedTrait}
  kCTFontControlContentFontType = 26;
  {$EXTERNALSYM kCTFontControlContentFontType}
  kCTFontDefaultOrientation = 0;
  {$EXTERNALSYM kCTFontDefaultOrientation}
  kCTFontEmphasizedSystemDetailFontType = 20;
  {$EXTERNALSYM kCTFontEmphasizedSystemDetailFontType}
  kCTFontEmphasizedSystemFontType = 3;
  {$EXTERNALSYM kCTFontEmphasizedSystemFontType}
  kCTFontExpandedTrait = 32;
  {$EXTERNALSYM kCTFontExpandedTrait}
  kCTFontFormatBitmap = 5;
  {$EXTERNALSYM kCTFontFormatBitmap}
  kCTFontFormatOpenTypePostScript = 1;
  {$EXTERNALSYM kCTFontFormatOpenTypePostScript}
  kCTFontFormatOpenTypeTrueType = 2;
  {$EXTERNALSYM kCTFontFormatOpenTypeTrueType}
  kCTFontFormatPostScript = 4;
  {$EXTERNALSYM kCTFontFormatPostScript}
  kCTFontFormatTrueType = 3;
  {$EXTERNALSYM kCTFontFormatTrueType}
  kCTFontFormatUnrecognized = 0;
  {$EXTERNALSYM kCTFontFormatUnrecognized}
  kCTFontFreeformSerifsClass = 1879048192;
  {$EXTERNALSYM kCTFontFreeformSerifsClass}
  kCTFontHorizontalOrientation = 1;
  {$EXTERNALSYM kCTFontHorizontalOrientation}
  kCTFontItalicTrait = 1;
  {$EXTERNALSYM kCTFontItalicTrait}
  kCTFontLabelFontType = 10;
  {$EXTERNALSYM kCTFontLabelFontType}
  kCTFontManagerAutoActivationDefault = 0;
  {$EXTERNALSYM kCTFontManagerAutoActivationDefault}
  kCTFontManagerAutoActivationDisabled = 1;
  {$EXTERNALSYM kCTFontManagerAutoActivationDisabled}
  kCTFontManagerAutoActivationEnabled = 2;
  {$EXTERNALSYM kCTFontManagerAutoActivationEnabled}
  kCTFontManagerAutoActivationPromptUser = 3;
  {$EXTERNALSYM kCTFontManagerAutoActivationPromptUser}
  kCTFontManagerErrorAlreadyRegistered = 105;
  {$EXTERNALSYM kCTFontManagerErrorAlreadyRegistered}
  kCTFontManagerErrorFileNotFound = 101;
  {$EXTERNALSYM kCTFontManagerErrorFileNotFound}
  kCTFontManagerErrorInUse = 202;
  {$EXTERNALSYM kCTFontManagerErrorInUse}
  kCTFontManagerErrorInsufficientPermissions = 102;
  {$EXTERNALSYM kCTFontManagerErrorInsufficientPermissions}
  kCTFontManagerErrorInvalidFontData = 104;
  {$EXTERNALSYM kCTFontManagerErrorInvalidFontData}
  kCTFontManagerErrorNotRegistered = 201;
  {$EXTERNALSYM kCTFontManagerErrorNotRegistered}
  kCTFontManagerErrorSystemRequired = 202;
  {$EXTERNALSYM kCTFontManagerErrorSystemRequired}
  kCTFontManagerErrorUnrecognizedFormat = 103;
  {$EXTERNALSYM kCTFontManagerErrorUnrecognizedFormat}
  kCTFontManagerScopeNone = 0;
  {$EXTERNALSYM kCTFontManagerScopeNone}
  kCTFontManagerScopeProcess = 1;
  {$EXTERNALSYM kCTFontManagerScopeProcess}
  kCTFontManagerScopeSession = 3;
  {$EXTERNALSYM kCTFontManagerScopeSession}
  kCTFontManagerScopeUser = 2;
  {$EXTERNALSYM kCTFontManagerScopeUser}
  kCTFontMenuItemCmdKeyFontType = 14;
  {$EXTERNALSYM kCTFontMenuItemCmdKeyFontType}
  kCTFontMenuItemFontType = 12;
  {$EXTERNALSYM kCTFontMenuItemFontType}
  kCTFontMenuItemMarkFontType = 13;
  {$EXTERNALSYM kCTFontMenuItemMarkFontType}
  kCTFontMenuTitleFontType = 11;
  {$EXTERNALSYM kCTFontMenuTitleFontType}
  kCTFontMessageFontType = 23;
  {$EXTERNALSYM kCTFontMessageFontType}
  kCTFontMiniEmphasizedSystemFontType = 7;
  {$EXTERNALSYM kCTFontMiniEmphasizedSystemFontType}
  kCTFontMiniSystemFontType = 6;
  {$EXTERNALSYM kCTFontMiniSystemFontType}
  kCTFontModernSerifsClass = 805306368;
  {$EXTERNALSYM kCTFontModernSerifsClass}
  kCTFontMonoSpaceTrait = 1024;
  {$EXTERNALSYM kCTFontMonoSpaceTrait}
  kCTFontNoFontType = -1;
  {$EXTERNALSYM kCTFontNoFontType}
  kCTFontOldStyleSerifsClass = 268435456;
  {$EXTERNALSYM kCTFontOldStyleSerifsClass}
  kCTFontOptionsDefault = 0;
  {$EXTERNALSYM kCTFontOptionsDefault}
  kCTFontOptionsPreferSystemFont = 4;
  {$EXTERNALSYM kCTFontOptionsPreferSystemFont}
  kCTFontOptionsPreventAutoActivation = 1;
  {$EXTERNALSYM kCTFontOptionsPreventAutoActivation}
  kCTFontOrnamentalsClass = -1879048192;
  {$EXTERNALSYM kCTFontOrnamentalsClass}
  kCTFontPaletteFontType = 24;
  {$EXTERNALSYM kCTFontPaletteFontType}
  kCTFontPriorityComputer = 30000;
  {$EXTERNALSYM kCTFontPriorityComputer}
  kCTFontPriorityDynamic = 50000;
  {$EXTERNALSYM kCTFontPriorityDynamic}
  kCTFontPriorityNetwork = 20000;
  {$EXTERNALSYM kCTFontPriorityNetwork}
  kCTFontPriorityProcess = 60000;
  {$EXTERNALSYM kCTFontPriorityProcess}
  kCTFontPrioritySystem = 10000;
  {$EXTERNALSYM kCTFontPrioritySystem}
  kCTFontPriorityUser = 40000;
  {$EXTERNALSYM kCTFontPriorityUser}
  kCTFontPushButtonFontType = 16;
  {$EXTERNALSYM kCTFontPushButtonFontType}
  kCTFontSansSerifClass = -2147483648;
  {$EXTERNALSYM kCTFontSansSerifClass}
  kCTFontScriptsClass = -1610612736;
  {$EXTERNALSYM kCTFontScriptsClass}
  kCTFontSlabSerifsClass = 1342177280;
  {$EXTERNALSYM kCTFontSlabSerifsClass}
  kCTFontSmallEmphasizedSystemFontType = 5;
  {$EXTERNALSYM kCTFontSmallEmphasizedSystemFontType}
  kCTFontSmallSystemFontType = 4;
  {$EXTERNALSYM kCTFontSmallSystemFontType}
  kCTFontSmallToolbarFontType = 22;
  {$EXTERNALSYM kCTFontSmallToolbarFontType}
  kCTFontSymbolicClass = -1073741824;
  {$EXTERNALSYM kCTFontSymbolicClass}
  kCTFontSystemDetailFontType = 19;
  {$EXTERNALSYM kCTFontSystemDetailFontType}
  kCTFontSystemFontType = 2;
  {$EXTERNALSYM kCTFontSystemFontType}
  kCTFontTableAcnt = 1633906292;
  {$EXTERNALSYM kCTFontTableAcnt}
  kCTFontTableAvar = 1635148146;
  {$EXTERNALSYM kCTFontTableAvar}
  kCTFontTableBASE = 1111577413;
  {$EXTERNALSYM kCTFontTableBASE}
  kCTFontTableBdat = 1650745716;
  {$EXTERNALSYM kCTFontTableBdat}
  kCTFontTableBhed = 1651008868;
  {$EXTERNALSYM kCTFontTableBhed}
  kCTFontTableBloc = 1651273571;
  {$EXTERNALSYM kCTFontTableBloc}
  kCTFontTableBsln = 1651731566;
  {$EXTERNALSYM kCTFontTableBsln}
  kCTFontTableCFF = 1128678944;
  {$EXTERNALSYM kCTFontTableCFF}
  kCTFontTableCmap = 1668112752;
  {$EXTERNALSYM kCTFontTableCmap}
  kCTFontTableCvar = 1668702578;
  {$EXTERNALSYM kCTFontTableCvar}
  kCTFontTableCvt = 1668707360;
  {$EXTERNALSYM kCTFontTableCvt}
  kCTFontTableDSIG = 1146308935;
  {$EXTERNALSYM kCTFontTableDSIG}
  kCTFontTableEBDT = 1161970772;
  {$EXTERNALSYM kCTFontTableEBDT}
  kCTFontTableEBLC = 1161972803;
  {$EXTERNALSYM kCTFontTableEBLC}
  kCTFontTableEBSC = 1161974595;
  {$EXTERNALSYM kCTFontTableEBSC}
  kCTFontTableFdsc = 1717859171;
  {$EXTERNALSYM kCTFontTableFdsc}
  kCTFontTableFeat = 1717920116;
  {$EXTERNALSYM kCTFontTableFeat}
  kCTFontTableFmtx = 1718449272;
  {$EXTERNALSYM kCTFontTableFmtx}
  kCTFontTableFpgm = 1718642541;
  {$EXTERNALSYM kCTFontTableFpgm}
  kCTFontTableFvar = 1719034226;
  {$EXTERNALSYM kCTFontTableFvar}
  kCTFontTableGDEF = 1195656518;
  {$EXTERNALSYM kCTFontTableGDEF}
  kCTFontTableGPOS = 1196445523;
  {$EXTERNALSYM kCTFontTableGPOS}
  kCTFontTableGSUB = 1196643650;
  {$EXTERNALSYM kCTFontTableGSUB}
  kCTFontTableGasp = 1734439792;
  {$EXTERNALSYM kCTFontTableGasp}
  kCTFontTableGlyf = 1735162214;
  {$EXTERNALSYM kCTFontTableGlyf}
  kCTFontTableGvar = 1735811442;
  {$EXTERNALSYM kCTFontTableGvar}
  kCTFontTableHdmx = 1751412088;
  {$EXTERNALSYM kCTFontTableHdmx}
  kCTFontTableHead = 1751474532;
  {$EXTERNALSYM kCTFontTableHead}
  kCTFontTableHhea = 1751672161;
  {$EXTERNALSYM kCTFontTableHhea}
  kCTFontTableHmtx = 1752003704;
  {$EXTERNALSYM kCTFontTableHmtx}
  kCTFontTableHsty = 1752396921;
  {$EXTERNALSYM kCTFontTableHsty}
  kCTFontTableJSTF = 1246975046;
  {$EXTERNALSYM kCTFontTableJSTF}
  kCTFontTableJust = 1786082164;
  {$EXTERNALSYM kCTFontTableJust}
  kCTFontTableKern = 1801810542;
  {$EXTERNALSYM kCTFontTableKern}
  kCTFontTableLTSH = 1280594760;
  {$EXTERNALSYM kCTFontTableLTSH}
  kCTFontTableLcar = 1818452338;
  {$EXTERNALSYM kCTFontTableLcar}
  kCTFontTableLoca = 1819239265;
  {$EXTERNALSYM kCTFontTableLoca}
  kCTFontTableMaxp = 1835104368;
  {$EXTERNALSYM kCTFontTableMaxp}
  kCTFontTableMort = 1836020340;
  {$EXTERNALSYM kCTFontTableMort}
  kCTFontTableMorx = 1836020344;
  {$EXTERNALSYM kCTFontTableMorx}
  kCTFontTableName = 1851878757;
  {$EXTERNALSYM kCTFontTableName}
  kCTFontTableOS2 = 1330851634;
  {$EXTERNALSYM kCTFontTableOS2}
  kCTFontTableOpbd = 1869636196;
  {$EXTERNALSYM kCTFontTableOpbd}
  kCTFontTableOptionExcludeSynthetic = 1;
  {$EXTERNALSYM kCTFontTableOptionExcludeSynthetic}
  kCTFontTableOptionNoOptions = 0;
  {$EXTERNALSYM kCTFontTableOptionNoOptions}
  kCTFontTablePCLT = 1346587732;
  {$EXTERNALSYM kCTFontTablePCLT}
  kCTFontTablePost = 1886352244;
  {$EXTERNALSYM kCTFontTablePost}
  kCTFontTablePrep = 1886545264;
  {$EXTERNALSYM kCTFontTablePrep}
  kCTFontTableProp = 1886547824;
  {$EXTERNALSYM kCTFontTableProp}
  kCTFontTableTrak = 1953653099;
  {$EXTERNALSYM kCTFontTableTrak}
  kCTFontTableVDMX = 1447316824;
  {$EXTERNALSYM kCTFontTableVDMX}
  kCTFontTableVORG = 1448038983;
  {$EXTERNALSYM kCTFontTableVORG}
  kCTFontTableVhea = 1986553185;
  {$EXTERNALSYM kCTFontTableVhea}
  kCTFontTableVmtx = 1986884728;
  {$EXTERNALSYM kCTFontTableVmtx}
  kCTFontTableZapf = 1516335206;
  {$EXTERNALSYM kCTFontTableZapf}
  kCTFontToolTipFontType = 25;
  {$EXTERNALSYM kCTFontToolTipFontType}
  kCTFontToolbarFontType = 21;
  {$EXTERNALSYM kCTFontToolbarFontType}
  kCTFontTransitionalSerifsClass = 536870912;
  {$EXTERNALSYM kCTFontTransitionalSerifsClass}
  kCTFontUIOptimizedTrait = 4096;
  {$EXTERNALSYM kCTFontUIOptimizedTrait}
  kCTFontUnknownClass = 0;
  {$EXTERNALSYM kCTFontUnknownClass}
  kCTFontUserFixedPitchFontType = 1;
  {$EXTERNALSYM kCTFontUserFixedPitchFontType}
  kCTFontUserFontType = 0;
  {$EXTERNALSYM kCTFontUserFontType}
  kCTFontUtilityWindowTitleFontType = 17;
  {$EXTERNALSYM kCTFontUtilityWindowTitleFontType}
  kCTFontVerticalOrientation = 2;
  {$EXTERNALSYM kCTFontVerticalOrientation}
  kCTFontVerticalTrait = 2048;
  {$EXTERNALSYM kCTFontVerticalTrait}
  kCTFontViewsFontType = 8;
  {$EXTERNALSYM kCTFontViewsFontType}
  kCTFontWindowTitleFontType = 15;
  {$EXTERNALSYM kCTFontWindowTitleFontType}
  kCTFrameProgressionRightToLeft = 1;
  {$EXTERNALSYM kCTFrameProgressionRightToLeft}
  kCTFrameProgressionTopToBottom = 0;
  {$EXTERNALSYM kCTFrameProgressionTopToBottom}
  kCTIdentityMappingCharacterCollection = 0;
  {$EXTERNALSYM kCTIdentityMappingCharacterCollection}
  kCTJustifiedTextAlignment = 3;
  {$EXTERNALSYM kCTJustifiedTextAlignment}
  kCTLeftTextAlignment = 0;
  {$EXTERNALSYM kCTLeftTextAlignment}
  kCTLineBreakByCharWrapping = 1;
  {$EXTERNALSYM kCTLineBreakByCharWrapping}
  kCTLineBreakByClipping = 2;
  {$EXTERNALSYM kCTLineBreakByClipping}
  kCTLineBreakByTruncatingHead = 3;
  {$EXTERNALSYM kCTLineBreakByTruncatingHead}
  kCTLineBreakByTruncatingMiddle = 5;
  {$EXTERNALSYM kCTLineBreakByTruncatingMiddle}
  kCTLineBreakByTruncatingTail = 4;
  {$EXTERNALSYM kCTLineBreakByTruncatingTail}
  kCTLineBreakByWordWrapping = 0;
  {$EXTERNALSYM kCTLineBreakByWordWrapping}
  kCTLineTruncationEnd = 1;
  {$EXTERNALSYM kCTLineTruncationEnd}
  kCTLineTruncationMiddle = 2;
  {$EXTERNALSYM kCTLineTruncationMiddle}
  kCTLineTruncationStart = 0;
  {$EXTERNALSYM kCTLineTruncationStart}
  kCTNaturalTextAlignment = 4;
  {$EXTERNALSYM kCTNaturalTextAlignment}
  kCTParagraphStyleSpecifierAlignment = 0;
  {$EXTERNALSYM kCTParagraphStyleSpecifierAlignment}
  kCTParagraphStyleSpecifierBaseWritingDirection = 13;
  {$EXTERNALSYM kCTParagraphStyleSpecifierBaseWritingDirection}
  kCTParagraphStyleSpecifierCount = 14;
  {$EXTERNALSYM kCTParagraphStyleSpecifierCount}
  kCTParagraphStyleSpecifierDefaultTabInterval = 5;
  {$EXTERNALSYM kCTParagraphStyleSpecifierDefaultTabInterval}
  kCTParagraphStyleSpecifierFirstLineHeadIndent = 1;
  {$EXTERNALSYM kCTParagraphStyleSpecifierFirstLineHeadIndent}
  kCTParagraphStyleSpecifierHeadIndent = 2;
  {$EXTERNALSYM kCTParagraphStyleSpecifierHeadIndent}
  kCTParagraphStyleSpecifierLineBreakMode = 6;
  {$EXTERNALSYM kCTParagraphStyleSpecifierLineBreakMode}
  kCTParagraphStyleSpecifierLineHeightMultiple = 7;
  {$EXTERNALSYM kCTParagraphStyleSpecifierLineHeightMultiple}
  kCTParagraphStyleSpecifierLineSpacing = 10;
  {$EXTERNALSYM kCTParagraphStyleSpecifierLineSpacing}
  kCTParagraphStyleSpecifierMaximumLineHeight = 8;
  {$EXTERNALSYM kCTParagraphStyleSpecifierMaximumLineHeight}
  kCTParagraphStyleSpecifierMinimumLineHeight = 9;
  {$EXTERNALSYM kCTParagraphStyleSpecifierMinimumLineHeight}
  kCTParagraphStyleSpecifierParagraphSpacing = 11;
  {$EXTERNALSYM kCTParagraphStyleSpecifierParagraphSpacing}
  kCTParagraphStyleSpecifierParagraphSpacingBefore = 12;
  {$EXTERNALSYM kCTParagraphStyleSpecifierParagraphSpacingBefore}
  kCTParagraphStyleSpecifierTabStops = 4;
  {$EXTERNALSYM kCTParagraphStyleSpecifierTabStops}
  kCTParagraphStyleSpecifierTailIndent = 3;
  {$EXTERNALSYM kCTParagraphStyleSpecifierTailIndent}
  kCTRightTextAlignment = 1;
  {$EXTERNALSYM kCTRightTextAlignment}
  kCTRunStatusHasNonIdentityMatrix = 4;
  {$EXTERNALSYM kCTRunStatusHasNonIdentityMatrix}
  kCTRunStatusNoStatus = 0;
  {$EXTERNALSYM kCTRunStatusNoStatus}
  kCTRunStatusNonMonotonic = 2;
  {$EXTERNALSYM kCTRunStatusNonMonotonic}
  kCTRunStatusRightToLeft = 1;
  {$EXTERNALSYM kCTRunStatusRightToLeft}
  kCTUnderlinePatternDash = 512;
  {$EXTERNALSYM kCTUnderlinePatternDash}
  kCTUnderlinePatternDashDot = 768;
  {$EXTERNALSYM kCTUnderlinePatternDashDot}
  kCTUnderlinePatternDashDotDot = 1024;
  {$EXTERNALSYM kCTUnderlinePatternDashDotDot}
  kCTUnderlinePatternDot = 256;
  {$EXTERNALSYM kCTUnderlinePatternDot}
  kCTUnderlinePatternSolid = 0;
  {$EXTERNALSYM kCTUnderlinePatternSolid}
  kCTUnderlineStyleDouble = 9;
  {$EXTERNALSYM kCTUnderlineStyleDouble}
  kCTUnderlineStyleNone = 0;
  {$EXTERNALSYM kCTUnderlineStyleNone}
  kCTUnderlineStyleSingle = 1;
  {$EXTERNALSYM kCTUnderlineStyleSingle}
  kCTUnderlineStyleThick = 2;
  {$EXTERNALSYM kCTUnderlineStyleThick}
  kCTVersionNumber10_5 = 131072;
  {$EXTERNALSYM kCTVersionNumber10_5}
  kCTVersionNumber10_5_2 = 131073;
  {$EXTERNALSYM kCTVersionNumber10_5_2}
  kCTVersionNumber10_5_3 = 131074;
  {$EXTERNALSYM kCTVersionNumber10_5_3}
  kCTVersionNumber10_5_5 = 131075;
  {$EXTERNALSYM kCTVersionNumber10_5_5}
  kCTVersionNumber10_6 = 196608;
  {$EXTERNALSYM kCTVersionNumber10_6}
  kCTWritingDirectionLeftToRight = 0;
  {$EXTERNALSYM kCTWritingDirectionLeftToRight}
  kCTWritingDirectionNatural = -1;
  {$EXTERNALSYM kCTWritingDirectionNatural}
  kCTWritingDirectionRightToLeft = 1;
  {$EXTERNALSYM kCTWritingDirectionRightToLeft}

// ===== External functions =====

const
  libCoreText = '/System/Library/Frameworks/ApplicationServices.framework/Frameworks/CoreText.framework/CoreText';
  {$EXTERNALSYM libCoreText}

function CTFontCollectionCreateCopyWithFontDescriptors(original: CTFontCollectionRef; descriptors: CFArrayRef; options: CFDictionaryRef): CTFontCollectionRef; cdecl; external libCoreText name _PU + 'CTFontCollectionCreateCopyWithFontDescriptors';
{$EXTERNALSYM CTFontCollectionCreateCopyWithFontDescriptors}
function CTFontCollectionCreateFromAvailableFonts(options: CFDictionaryRef): CTFontCollectionRef; cdecl; external libCoreText name _PU + 'CTFontCollectionCreateFromAvailableFonts';
{$EXTERNALSYM CTFontCollectionCreateFromAvailableFonts}
function CTFontCollectionCreateMatchingFontDescriptors(collection: CTFontCollectionRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontCollectionCreateMatchingFontDescriptors';
{$EXTERNALSYM CTFontCollectionCreateMatchingFontDescriptors}
function CTFontCollectionCreateMatchingFontDescriptorsSortedWithCallback(collection: CTFontCollectionRef; sortCallback: CTFontCollectionSortDescriptorsCallback; refCon: Pointer): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontCollectionCreateMatchingFontDescriptorsSortedWithCallback';
{$EXTERNALSYM CTFontCollectionCreateMatchingFontDescriptorsSortedWithCallback}
function CTFontCollectionCreateWithFontDescriptors(descriptors: CFArrayRef; options: CFDictionaryRef): CTFontCollectionRef; cdecl; external libCoreText name _PU + 'CTFontCollectionCreateWithFontDescriptors';
{$EXTERNALSYM CTFontCollectionCreateWithFontDescriptors}
function CTFontCollectionGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTFontCollectionGetTypeID';
{$EXTERNALSYM CTFontCollectionGetTypeID}
function CTFontCopyAttribute(font: CTFontRef; attribute: CFStringRef): CFTypeRef; cdecl; external libCoreText name _PU + 'CTFontCopyAttribute';
{$EXTERNALSYM CTFontCopyAttribute}
function CTFontCopyAvailableTables(font: CTFontRef; options: CTFontTableOptions): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontCopyAvailableTables';
{$EXTERNALSYM CTFontCopyAvailableTables}
function CTFontCopyCharacterSet(font: CTFontRef): CFCharacterSetRef; cdecl; external libCoreText name _PU + 'CTFontCopyCharacterSet';
{$EXTERNALSYM CTFontCopyCharacterSet}
function CTFontCopyDisplayName(font: CTFontRef): CFStringRef; cdecl; external libCoreText name _PU + 'CTFontCopyDisplayName';
{$EXTERNALSYM CTFontCopyDisplayName}
function CTFontCopyFamilyName(font: CTFontRef): CFStringRef; cdecl; external libCoreText name _PU + 'CTFontCopyFamilyName';
{$EXTERNALSYM CTFontCopyFamilyName}
function CTFontCopyFeatureSettings(font: CTFontRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontCopyFeatureSettings';
{$EXTERNALSYM CTFontCopyFeatureSettings}
function CTFontCopyFeatures(font: CTFontRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontCopyFeatures';
{$EXTERNALSYM CTFontCopyFeatures}
function CTFontCopyFontDescriptor(font: CTFontRef): CTFontDescriptorRef; cdecl; external libCoreText name _PU + 'CTFontCopyFontDescriptor';
{$EXTERNALSYM CTFontCopyFontDescriptor}
function CTFontCopyFullName(font: CTFontRef): CFStringRef; cdecl; external libCoreText name _PU + 'CTFontCopyFullName';
{$EXTERNALSYM CTFontCopyFullName}
function CTFontCopyGraphicsFont(font: CTFontRef; attributes: PCTFontDescriptorRef): CGFontRef; cdecl; external libCoreText name _PU + 'CTFontCopyGraphicsFont';
{$EXTERNALSYM CTFontCopyGraphicsFont}
function CTFontCopyLocalizedName(font: CTFontRef; nameKey: CFStringRef; language: PCFStringRef): CFStringRef; cdecl; external libCoreText name _PU + 'CTFontCopyLocalizedName';
{$EXTERNALSYM CTFontCopyLocalizedName}
function CTFontCopyName(font: CTFontRef; nameKey: CFStringRef): CFStringRef; cdecl; external libCoreText name _PU + 'CTFontCopyName';
{$EXTERNALSYM CTFontCopyName}
function CTFontCopyPostScriptName(font: CTFontRef): CFStringRef; cdecl; external libCoreText name _PU + 'CTFontCopyPostScriptName';
{$EXTERNALSYM CTFontCopyPostScriptName}
function CTFontCopySupportedLanguages(font: CTFontRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontCopySupportedLanguages';
{$EXTERNALSYM CTFontCopySupportedLanguages}
function CTFontCopyTable(font: CTFontRef; table: CTFontTableTag; options: CTFontTableOptions): CFDataRef; cdecl; external libCoreText name _PU + 'CTFontCopyTable';
{$EXTERNALSYM CTFontCopyTable}
function CTFontCopyTraits(font: CTFontRef): CFDictionaryRef; cdecl; external libCoreText name _PU + 'CTFontCopyTraits';
{$EXTERNALSYM CTFontCopyTraits}
function CTFontCopyVariation(font: CTFontRef): CFDictionaryRef; cdecl; external libCoreText name _PU + 'CTFontCopyVariation';
{$EXTERNALSYM CTFontCopyVariation}
function CTFontCopyVariationAxes(font: CTFontRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontCopyVariationAxes';
{$EXTERNALSYM CTFontCopyVariationAxes}
function CTFontCreateCopyWithAttributes(font: CTFontRef; size: CGFloat; matrix: PCGAffineTransform; attributes: CTFontDescriptorRef): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateCopyWithAttributes';
{$EXTERNALSYM CTFontCreateCopyWithAttributes}
function CTFontCreateCopyWithFamily(font: CTFontRef; size: CGFloat; matrix: PCGAffineTransform; family: CFStringRef): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateCopyWithFamily';
{$EXTERNALSYM CTFontCreateCopyWithFamily}
function CTFontCreateCopyWithSymbolicTraits(font: CTFontRef; size: CGFloat; matrix: PCGAffineTransform; symTraitValue: CTFontSymbolicTraits; symTraitMask: CTFontSymbolicTraits): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateCopyWithSymbolicTraits';
{$EXTERNALSYM CTFontCreateCopyWithSymbolicTraits}
function CTFontCreateForString(currentFont: CTFontRef; string_: CFStringRef; range: CFRange): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateForString';
{$EXTERNALSYM CTFontCreateForString}
function CTFontCreatePathForGlyph(font: CTFontRef; glyph: CGGlyph; transform: PCGAffineTransform): CGPathRef; cdecl; external libCoreText name _PU + 'CTFontCreatePathForGlyph';
{$EXTERNALSYM CTFontCreatePathForGlyph}
function CTFontCreateUIFontForLanguage(uiType: CTFontUIFontType; size: CGFloat; language: CFStringRef): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateUIFontForLanguage';
{$EXTERNALSYM CTFontCreateUIFontForLanguage}
function CTFontCreateWithFontDescriptor(descriptor: CTFontDescriptorRef; size: CGFloat; matrix: PCGAffineTransform): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateWithFontDescriptor';
{$EXTERNALSYM CTFontCreateWithFontDescriptor}
function CTFontCreateWithFontDescriptorAndOptions(descriptor: CTFontDescriptorRef; size: CGFloat; matrix: PCGAffineTransform; options: CTFontOptions): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateWithFontDescriptorAndOptions';
{$EXTERNALSYM CTFontCreateWithFontDescriptorAndOptions}
function CTFontCreateWithGraphicsFont(graphicsFont: CGFontRef; size: CGFloat; matrix: PCGAffineTransform; attributes: CTFontDescriptorRef): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateWithGraphicsFont';
{$EXTERNALSYM CTFontCreateWithGraphicsFont}
function CTFontCreateWithName(name: CFStringRef; size: CGFloat; matrix: PCGAffineTransform): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateWithName';
{$EXTERNALSYM CTFontCreateWithName}
function CTFontCreateWithNameAndOptions(name: CFStringRef; size: CGFloat; matrix: PCGAffineTransform; options: CTFontOptions): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateWithNameAndOptions';
{$EXTERNALSYM CTFontCreateWithNameAndOptions}
function CTFontCreateWithPlatformFont(platformFont: ATSFontRef; size: CGFloat; matrix: PCGAffineTransform; attributes: CTFontDescriptorRef): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateWithPlatformFont';
{$EXTERNALSYM CTFontCreateWithPlatformFont}
function CTFontCreateWithQuickdrawInstance(name: ConstStr255Param; identifier: Smallint; style: Byte; size: CGFloat): CTFontRef; cdecl; external libCoreText name _PU + 'CTFontCreateWithQuickdrawInstance';
{$EXTERNALSYM CTFontCreateWithQuickdrawInstance}
function CTFontDescriptorCopyAttribute(descriptor: CTFontDescriptorRef; attribute: CFStringRef): CFTypeRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCopyAttribute';
{$EXTERNALSYM CTFontDescriptorCopyAttribute}
function CTFontDescriptorCopyAttributes(descriptor: CTFontDescriptorRef): CFDictionaryRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCopyAttributes';
{$EXTERNALSYM CTFontDescriptorCopyAttributes}
function CTFontDescriptorCopyLocalizedAttribute(descriptor: CTFontDescriptorRef; attribute: CFStringRef; language: PCFStringRef): CFTypeRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCopyLocalizedAttribute';
{$EXTERNALSYM CTFontDescriptorCopyLocalizedAttribute}
function CTFontDescriptorCreateCopyWithAttributes(original: CTFontDescriptorRef; attributes: CFDictionaryRef): CTFontDescriptorRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCreateCopyWithAttributes';
{$EXTERNALSYM CTFontDescriptorCreateCopyWithAttributes}
function CTFontDescriptorCreateCopyWithFeature(original: CTFontDescriptorRef; featureTypeIdentifier: CFNumberRef; featureSelectorIdentifier: CFNumberRef): CTFontDescriptorRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCreateCopyWithFeature';
{$EXTERNALSYM CTFontDescriptorCreateCopyWithFeature}
function CTFontDescriptorCreateCopyWithVariation(original: CTFontDescriptorRef; variationIdentifier: CFNumberRef; variationValue: CGFloat): CTFontDescriptorRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCreateCopyWithVariation';
{$EXTERNALSYM CTFontDescriptorCreateCopyWithVariation}
function CTFontDescriptorCreateMatchingFontDescriptor(descriptor: CTFontDescriptorRef; mandatoryAttributes: CFSetRef): CTFontDescriptorRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCreateMatchingFontDescriptor';
{$EXTERNALSYM CTFontDescriptorCreateMatchingFontDescriptor}
function CTFontDescriptorCreateMatchingFontDescriptors(descriptor: CTFontDescriptorRef; mandatoryAttributes: CFSetRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCreateMatchingFontDescriptors';
{$EXTERNALSYM CTFontDescriptorCreateMatchingFontDescriptors}
function CTFontDescriptorCreateWithAttributes(attributes: CFDictionaryRef): CTFontDescriptorRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCreateWithAttributes';
{$EXTERNALSYM CTFontDescriptorCreateWithAttributes}
function CTFontDescriptorCreateWithNameAndSize(name: CFStringRef; size: CGFloat): CTFontDescriptorRef; cdecl; external libCoreText name _PU + 'CTFontDescriptorCreateWithNameAndSize';
{$EXTERNALSYM CTFontDescriptorCreateWithNameAndSize}
function CTFontDescriptorGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTFontDescriptorGetTypeID';
{$EXTERNALSYM CTFontDescriptorGetTypeID}
function CTFontGetAdvancesForGlyphs(font: CTFontRef; orientation: CTFontOrientation; glyphs: PCGGlyph; advances: PCGSize; count: CFIndex): double; cdecl; external libCoreText name _PU + 'CTFontGetAdvancesForGlyphs';
{$EXTERNALSYM CTFontGetAdvancesForGlyphs}
function CTFontGetAscent(font: CTFontRef): CGFloat; cdecl; external libCoreText name _PU + 'CTFontGetAscent';
{$EXTERNALSYM CTFontGetAscent}
function CTFontGetBoundingBox(font: CTFontRef): CGRect; cdecl; external libCoreText name _PU + 'CTFontGetBoundingBox';
{$EXTERNALSYM CTFontGetBoundingBox}
function CTFontGetBoundingRectsForGlyphs(font: CTFontRef; orientation: CTFontOrientation; glyphs: PCGGlyph; boundingRects: PCGRect; count: CFIndex): CGRect; cdecl; external libCoreText name _PU + 'CTFontGetBoundingRectsForGlyphs';
{$EXTERNALSYM CTFontGetBoundingRectsForGlyphs}
function CTFontGetCapHeight(font: CTFontRef): CGFloat; cdecl; external libCoreText name _PU + 'CTFontGetCapHeight';
{$EXTERNALSYM CTFontGetCapHeight}
function CTFontGetDescent(font: CTFontRef): CGFloat; cdecl; external libCoreText name _PU + 'CTFontGetDescent';
{$EXTERNALSYM CTFontGetDescent}
function CTFontGetGlyphCount(font: CTFontRef): CFIndex; cdecl; external libCoreText name _PU + 'CTFontGetGlyphCount';
{$EXTERNALSYM CTFontGetGlyphCount}
function CTFontGetGlyphWithName(font: CTFontRef; glyphName: CFStringRef): CGGlyph; cdecl; external libCoreText name _PU + 'CTFontGetGlyphWithName';
{$EXTERNALSYM CTFontGetGlyphWithName}
function CTFontGetGlyphsForCharacters(font: CTFontRef; characters: PUniChar; glyphs: PCGGlyph; count: CFIndex): Integer; cdecl; external libCoreText name _PU + 'CTFontGetGlyphsForCharacters';
{$EXTERNALSYM CTFontGetGlyphsForCharacters}
function CTFontGetLeading(font: CTFontRef): CGFloat; cdecl; external libCoreText name _PU + 'CTFontGetLeading';
{$EXTERNALSYM CTFontGetLeading}
function CTFontGetMatrix(font: CTFontRef): CGAffineTransform; cdecl; external libCoreText name _PU + 'CTFontGetMatrix';
{$EXTERNALSYM CTFontGetMatrix}
function CTFontGetPlatformFont(font: CTFontRef; attributes: PCTFontDescriptorRef): ATSFontRef; cdecl; external libCoreText name _PU + 'CTFontGetPlatformFont';
{$EXTERNALSYM CTFontGetPlatformFont}
function CTFontGetSize(font: CTFontRef): CGFloat; cdecl; external libCoreText name _PU + 'CTFontGetSize';
{$EXTERNALSYM CTFontGetSize}
function CTFontGetSlantAngle(font: CTFontRef): CGFloat; cdecl; external libCoreText name _PU + 'CTFontGetSlantAngle';
{$EXTERNALSYM CTFontGetSlantAngle}
function CTFontGetStringEncoding(font: CTFontRef): CFStringEncoding; cdecl; external libCoreText name _PU + 'CTFontGetStringEncoding';
{$EXTERNALSYM CTFontGetStringEncoding}
function CTFontGetSymbolicTraits(font: CTFontRef): CTFontSymbolicTraits; cdecl; external libCoreText name _PU + 'CTFontGetSymbolicTraits';
{$EXTERNALSYM CTFontGetSymbolicTraits}
function CTFontGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTFontGetTypeID';
{$EXTERNALSYM CTFontGetTypeID}
function CTFontGetUnderlinePosition(font: CTFontRef): CGFloat; cdecl; external libCoreText name _PU + 'CTFontGetUnderlinePosition';
{$EXTERNALSYM CTFontGetUnderlinePosition}
function CTFontGetUnderlineThickness(font: CTFontRef): CGFloat; cdecl; external libCoreText name _PU + 'CTFontGetUnderlineThickness';
{$EXTERNALSYM CTFontGetUnderlineThickness}
function CTFontGetUnitsPerEm(font: CTFontRef): Cardinal; cdecl; external libCoreText name _PU + 'CTFontGetUnitsPerEm';
{$EXTERNALSYM CTFontGetUnitsPerEm}
procedure CTFontGetVerticalTranslationsForGlyphs(font: CTFontRef; glyphs: PCGGlyph; translations: PCGSize; count: CFIndex); cdecl; external libCoreText name _PU + 'CTFontGetVerticalTranslationsForGlyphs';
{$EXTERNALSYM CTFontGetVerticalTranslationsForGlyphs}
function CTFontGetXHeight(font: CTFontRef): CGFloat; cdecl; external libCoreText name _PU + 'CTFontGetXHeight';
{$EXTERNALSYM CTFontGetXHeight}
function CTFontManagerCompareFontFamilyNames(family1: Pointer; family2: Pointer; context: Pointer): CFComparisonResult; cdecl; external libCoreText name _PU + 'CTFontManagerCompareFontFamilyNames';
{$EXTERNALSYM CTFontManagerCompareFontFamilyNames}
function CTFontManagerCopyAvailableFontFamilyNames: CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontManagerCopyAvailableFontFamilyNames';
{$EXTERNALSYM CTFontManagerCopyAvailableFontFamilyNames}
function CTFontManagerCopyAvailableFontURLs: CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontManagerCopyAvailableFontURLs';
{$EXTERNALSYM CTFontManagerCopyAvailableFontURLs}
function CTFontManagerCopyAvailablePostScriptNames: CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontManagerCopyAvailablePostScriptNames';
{$EXTERNALSYM CTFontManagerCopyAvailablePostScriptNames}
function CTFontManagerCreateFontDescriptorsFromURL(fileURL: CFURLRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFontManagerCreateFontDescriptorsFromURL';
{$EXTERNALSYM CTFontManagerCreateFontDescriptorsFromURL}
procedure CTFontManagerEnableFontDescriptors(descriptors: CFArrayRef; enable: Integer); cdecl; external libCoreText name _PU + 'CTFontManagerEnableFontDescriptors';
{$EXTERNALSYM CTFontManagerEnableFontDescriptors}
function CTFontManagerGetAutoActivationSetting(bundleIdentifier: CFStringRef): CTFontManagerAutoActivationSetting; cdecl; external libCoreText name _PU + 'CTFontManagerGetAutoActivationSetting';
{$EXTERNALSYM CTFontManagerGetAutoActivationSetting}
function CTFontManagerGetScopeForURL(fontURL: CFURLRef): CTFontManagerScope; cdecl; external libCoreText name _PU + 'CTFontManagerGetScopeForURL';
{$EXTERNALSYM CTFontManagerGetScopeForURL}
function CTFontManagerIsSupportedFont(fontURL: CFURLRef): Integer; cdecl; external libCoreText name _PU + 'CTFontManagerIsSupportedFont';
{$EXTERNALSYM CTFontManagerIsSupportedFont}
function CTFontManagerRegisterFontsForURL(fontURL: CFURLRef; scope: CTFontManagerScope; error: PCFErrorRef): Integer; cdecl; external libCoreText name _PU + 'CTFontManagerRegisterFontsForURL';
{$EXTERNALSYM CTFontManagerRegisterFontsForURL}
function CTFontManagerRegisterFontsForURLs(fontURLs: CFArrayRef; scope: CTFontManagerScope; errors: PCFArrayRef): Integer; cdecl; external libCoreText name _PU + 'CTFontManagerRegisterFontsForURLs';
{$EXTERNALSYM CTFontManagerRegisterFontsForURLs}
procedure CTFontManagerSetAutoActivationSetting(bundleIdentifier: CFStringRef; setting: CTFontManagerAutoActivationSetting); cdecl; external libCoreText name _PU + 'CTFontManagerSetAutoActivationSetting';
{$EXTERNALSYM CTFontManagerSetAutoActivationSetting}
function CTFontManagerUnregisterFontsForURL(fontURL: CFURLRef; scope: CTFontManagerScope; error: PCFErrorRef): Integer; cdecl; external libCoreText name _PU + 'CTFontManagerUnregisterFontsForURL';
{$EXTERNALSYM CTFontManagerUnregisterFontsForURL}
function CTFontManagerUnregisterFontsForURLs(fontURLs: CFArrayRef; scope: CTFontManagerScope; errors: PCFArrayRef): Integer; cdecl; external libCoreText name _PU + 'CTFontManagerUnregisterFontsForURLs';
{$EXTERNALSYM CTFontManagerUnregisterFontsForURLs}
procedure CTFrameDraw(frame: CTFrameRef; context: CGContextRef); cdecl; external libCoreText name _PU + 'CTFrameDraw';
{$EXTERNALSYM CTFrameDraw}
function CTFrameGetFrameAttributes(frame: CTFrameRef): CFDictionaryRef; cdecl; external libCoreText name _PU + 'CTFrameGetFrameAttributes';
{$EXTERNALSYM CTFrameGetFrameAttributes}
procedure CTFrameGetLineOrigins(frame: CTFrameRef; range: CFRange; origins: PCGPoint); cdecl; external libCoreText name _PU + 'CTFrameGetLineOrigins';
{$EXTERNALSYM CTFrameGetLineOrigins}
function CTFrameGetLines(frame: CTFrameRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTFrameGetLines';
{$EXTERNALSYM CTFrameGetLines}
function CTFrameGetPath(frame: CTFrameRef): CGPathRef; cdecl; external libCoreText name _PU + 'CTFrameGetPath';
{$EXTERNALSYM CTFrameGetPath}
function CTFrameGetStringRange(frame: CTFrameRef): CFRange; cdecl; external libCoreText name _PU + 'CTFrameGetStringRange';
{$EXTERNALSYM CTFrameGetStringRange}
function CTFrameGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTFrameGetTypeID';
{$EXTERNALSYM CTFrameGetTypeID}
function CTFrameGetVisibleStringRange(frame: CTFrameRef): CFRange; cdecl; external libCoreText name _PU + 'CTFrameGetVisibleStringRange';
{$EXTERNALSYM CTFrameGetVisibleStringRange}
function CTFramesetterCreateFrame(framesetter: CTFramesetterRef; stringRange: CFRange; path: CGPathRef; frameAttributes: CFDictionaryRef): CTFrameRef; cdecl; external libCoreText name _PU + 'CTFramesetterCreateFrame';
{$EXTERNALSYM CTFramesetterCreateFrame}
function CTFramesetterCreateWithAttributedString(string_: CFAttributedStringRef): CTFramesetterRef; cdecl; external libCoreText name _PU + 'CTFramesetterCreateWithAttributedString';
{$EXTERNALSYM CTFramesetterCreateWithAttributedString}
function CTFramesetterGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTFramesetterGetTypeID';
{$EXTERNALSYM CTFramesetterGetTypeID}
function CTFramesetterGetTypesetter(framesetter: CTFramesetterRef): CTTypesetterRef; cdecl; external libCoreText name _PU + 'CTFramesetterGetTypesetter';
{$EXTERNALSYM CTFramesetterGetTypesetter}
function CTFramesetterSuggestFrameSizeWithConstraints(framesetter: CTFramesetterRef; stringRange: CFRange; frameAttributes: CFDictionaryRef; constraints: CGSize; fitRange: PCFRange): CGSize; cdecl; external libCoreText name _PU + 'CTFramesetterSuggestFrameSizeWithConstraints';
{$EXTERNALSYM CTFramesetterSuggestFrameSizeWithConstraints}
function CTGetCoreTextVersion: Cardinal; cdecl; external libCoreText name _PU + 'CTGetCoreTextVersion';
{$EXTERNALSYM CTGetCoreTextVersion}
function CTGlyphInfoCreateWithCharacterIdentifier(cid: CGFontIndex; collection: CTCharacterCollection; baseString: CFStringRef): CTGlyphInfoRef; cdecl; external libCoreText name _PU + 'CTGlyphInfoCreateWithCharacterIdentifier';
{$EXTERNALSYM CTGlyphInfoCreateWithCharacterIdentifier}
function CTGlyphInfoCreateWithGlyph(glyph: CGGlyph; font: CTFontRef; baseString: CFStringRef): CTGlyphInfoRef; cdecl; external libCoreText name _PU + 'CTGlyphInfoCreateWithGlyph';
{$EXTERNALSYM CTGlyphInfoCreateWithGlyph}
function CTGlyphInfoCreateWithGlyphName(glyphName: CFStringRef; font: CTFontRef; baseString: CFStringRef): CTGlyphInfoRef; cdecl; external libCoreText name _PU + 'CTGlyphInfoCreateWithGlyphName';
{$EXTERNALSYM CTGlyphInfoCreateWithGlyphName}
function CTGlyphInfoGetCharacterCollection(glyphInfo: CTGlyphInfoRef): CTCharacterCollection; cdecl; external libCoreText name _PU + 'CTGlyphInfoGetCharacterCollection';
{$EXTERNALSYM CTGlyphInfoGetCharacterCollection}
function CTGlyphInfoGetCharacterIdentifier(glyphInfo: CTGlyphInfoRef): CGFontIndex; cdecl; external libCoreText name _PU + 'CTGlyphInfoGetCharacterIdentifier';
{$EXTERNALSYM CTGlyphInfoGetCharacterIdentifier}
function CTGlyphInfoGetGlyphName(glyphInfo: CTGlyphInfoRef): CFStringRef; cdecl; external libCoreText name _PU + 'CTGlyphInfoGetGlyphName';
{$EXTERNALSYM CTGlyphInfoGetGlyphName}
function CTGlyphInfoGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTGlyphInfoGetTypeID';
{$EXTERNALSYM CTGlyphInfoGetTypeID}
function CTLineCreateJustifiedLine(line: CTLineRef; justificationFactor: CGFloat; justificationWidth: double): CTLineRef; cdecl; external libCoreText name _PU + 'CTLineCreateJustifiedLine';
{$EXTERNALSYM CTLineCreateJustifiedLine}
function CTLineCreateTruncatedLine(line: CTLineRef; width: double; truncationType: CTLineTruncationType; truncationToken: CTLineRef): CTLineRef; cdecl; external libCoreText name _PU + 'CTLineCreateTruncatedLine';
{$EXTERNALSYM CTLineCreateTruncatedLine}
function CTLineCreateWithAttributedString(string_: CFAttributedStringRef): CTLineRef; cdecl; external libCoreText name _PU + 'CTLineCreateWithAttributedString';
{$EXTERNALSYM CTLineCreateWithAttributedString}
procedure CTLineDraw(line: CTLineRef; context: CGContextRef); cdecl; external libCoreText name _PU + 'CTLineDraw';
{$EXTERNALSYM CTLineDraw}
function CTLineGetGlyphCount(line: CTLineRef): CFIndex; cdecl; external libCoreText name _PU + 'CTLineGetGlyphCount';
{$EXTERNALSYM CTLineGetGlyphCount}
function CTLineGetGlyphRuns(line: CTLineRef): CFArrayRef; cdecl; external libCoreText name _PU + 'CTLineGetGlyphRuns';
{$EXTERNALSYM CTLineGetGlyphRuns}
function CTLineGetImageBounds(line: CTLineRef; context: CGContextRef): CGRect; cdecl; external libCoreText name _PU + 'CTLineGetImageBounds';
{$EXTERNALSYM CTLineGetImageBounds}
function CTLineGetOffsetForStringIndex(line: CTLineRef; charIndex: CFIndex; secondaryOffset: PCGFloat): CGFloat; cdecl; external libCoreText name _PU + 'CTLineGetOffsetForStringIndex';
{$EXTERNALSYM CTLineGetOffsetForStringIndex}
function CTLineGetPenOffsetForFlush(line: CTLineRef; flushFactor: CGFloat; flushWidth: double): double; cdecl; external libCoreText name _PU + 'CTLineGetPenOffsetForFlush';
{$EXTERNALSYM CTLineGetPenOffsetForFlush}
function CTLineGetStringIndexForPosition(line: CTLineRef; position: CGPoint): CFIndex; cdecl; external libCoreText name _PU + 'CTLineGetStringIndexForPosition';
{$EXTERNALSYM CTLineGetStringIndexForPosition}
function CTLineGetStringRange(line: CTLineRef): CFRange; cdecl; external libCoreText name _PU + 'CTLineGetStringRange';
{$EXTERNALSYM CTLineGetStringRange}
function CTLineGetTrailingWhitespaceWidth(line: CTLineRef): double; cdecl; external libCoreText name _PU + 'CTLineGetTrailingWhitespaceWidth';
{$EXTERNALSYM CTLineGetTrailingWhitespaceWidth}
function CTLineGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTLineGetTypeID';
{$EXTERNALSYM CTLineGetTypeID}
function CTLineGetTypographicBounds(line: CTLineRef; ascent: PCGFloat; descent: PCGFloat; leading: PCGFloat): double; cdecl; external libCoreText name _PU + 'CTLineGetTypographicBounds';
{$EXTERNALSYM CTLineGetTypographicBounds}
function CTParagraphStyleCreate(settings: PCTParagraphStyleSetting; settingCount: CFIndex): CTParagraphStyleRef; cdecl; external libCoreText name _PU + 'CTParagraphStyleCreate';
{$EXTERNALSYM CTParagraphStyleCreate}
function CTParagraphStyleCreateCopy(paragraphStyle: CTParagraphStyleRef): CTParagraphStyleRef; cdecl; external libCoreText name _PU + 'CTParagraphStyleCreateCopy';
{$EXTERNALSYM CTParagraphStyleCreateCopy}
function CTParagraphStyleGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTParagraphStyleGetTypeID';
{$EXTERNALSYM CTParagraphStyleGetTypeID}
function CTParagraphStyleGetValueForSpecifier(paragraphStyle: CTParagraphStyleRef; spec: CTParagraphStyleSpecifier; valueBufferSize: size_t; valueBuffer: Pointer): Integer; cdecl; external libCoreText name _PU + 'CTParagraphStyleGetValueForSpecifier';
{$EXTERNALSYM CTParagraphStyleGetValueForSpecifier}
procedure CTRunDraw(run: CTRunRef; context: CGContextRef; range: CFRange); cdecl; external libCoreText name _PU + 'CTRunDraw';
{$EXTERNALSYM CTRunDraw}
procedure CTRunGetAdvances(run: CTRunRef; range: CFRange; buffer: PCGSize); cdecl; external libCoreText name _PU + 'CTRunGetAdvances';
{$EXTERNALSYM CTRunGetAdvances}
function CTRunGetAdvancesPtr(run: CTRunRef): PCGSize; cdecl; external libCoreText name _PU + 'CTRunGetAdvancesPtr';
{$EXTERNALSYM CTRunGetAdvancesPtr}
function CTRunGetAttributes(run: CTRunRef): CFDictionaryRef; cdecl; external libCoreText name _PU + 'CTRunGetAttributes';
{$EXTERNALSYM CTRunGetAttributes}
function CTRunGetGlyphCount(run: CTRunRef): CFIndex; cdecl; external libCoreText name _PU + 'CTRunGetGlyphCount';
{$EXTERNALSYM CTRunGetGlyphCount}
procedure CTRunGetGlyphs(run: CTRunRef; range: CFRange; buffer: PCGGlyph); cdecl; external libCoreText name _PU + 'CTRunGetGlyphs';
{$EXTERNALSYM CTRunGetGlyphs}
function CTRunGetGlyphsPtr(run: CTRunRef): PCGGlyph; cdecl; external libCoreText name _PU + 'CTRunGetGlyphsPtr';
{$EXTERNALSYM CTRunGetGlyphsPtr}
function CTRunGetImageBounds(run: CTRunRef; context: CGContextRef; range: CFRange): CGRect; cdecl; external libCoreText name _PU + 'CTRunGetImageBounds';
{$EXTERNALSYM CTRunGetImageBounds}
procedure CTRunGetPositions(run: CTRunRef; range: CFRange; buffer: PCGPoint); cdecl; external libCoreText name _PU + 'CTRunGetPositions';
{$EXTERNALSYM CTRunGetPositions}
function CTRunGetPositionsPtr(run: CTRunRef): PCGPoint; cdecl; external libCoreText name _PU + 'CTRunGetPositionsPtr';
{$EXTERNALSYM CTRunGetPositionsPtr}
function CTRunGetStatus(run: CTRunRef): CTRunStatus; cdecl; external libCoreText name _PU + 'CTRunGetStatus';
{$EXTERNALSYM CTRunGetStatus}
procedure CTRunGetStringIndices(run: CTRunRef; range: CFRange; buffer: PCFIndex); cdecl; external libCoreText name _PU + 'CTRunGetStringIndices';
{$EXTERNALSYM CTRunGetStringIndices}
function CTRunGetStringIndicesPtr(run: CTRunRef): PCFIndex; cdecl; external libCoreText name _PU + 'CTRunGetStringIndicesPtr';
{$EXTERNALSYM CTRunGetStringIndicesPtr}
function CTRunGetStringRange(run: CTRunRef): CFRange; cdecl; external libCoreText name _PU + 'CTRunGetStringRange';
{$EXTERNALSYM CTRunGetStringRange}
function CTRunGetTextMatrix(run: CTRunRef): CGAffineTransform; cdecl; external libCoreText name _PU + 'CTRunGetTextMatrix';
{$EXTERNALSYM CTRunGetTextMatrix}
function CTRunGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTRunGetTypeID';
{$EXTERNALSYM CTRunGetTypeID}
function CTRunGetTypographicBounds(run: CTRunRef; range: CFRange; ascent: PCGFloat; descent: PCGFloat; leading: PCGFloat): double; cdecl; external libCoreText name _PU + 'CTRunGetTypographicBounds';
{$EXTERNALSYM CTRunGetTypographicBounds}
function CTTextTabCreate(alignment: CTTextAlignment; location: double; options: CFDictionaryRef): CTTextTabRef; cdecl; external libCoreText name _PU + 'CTTextTabCreate';
{$EXTERNALSYM CTTextTabCreate}
function CTTextTabGetAlignment(tab: CTTextTabRef): CTTextAlignment; cdecl; external libCoreText name _PU + 'CTTextTabGetAlignment';
{$EXTERNALSYM CTTextTabGetAlignment}
function CTTextTabGetLocation(tab: CTTextTabRef): double; cdecl; external libCoreText name _PU + 'CTTextTabGetLocation';
{$EXTERNALSYM CTTextTabGetLocation}
function CTTextTabGetOptions(tab: CTTextTabRef): CFDictionaryRef; cdecl; external libCoreText name _PU + 'CTTextTabGetOptions';
{$EXTERNALSYM CTTextTabGetOptions}
function CTTextTabGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTTextTabGetTypeID';
{$EXTERNALSYM CTTextTabGetTypeID}
function CTTypesetterCreateLine(typesetter: CTTypesetterRef; stringRange: CFRange): CTLineRef; cdecl; external libCoreText name _PU + 'CTTypesetterCreateLine';
{$EXTERNALSYM CTTypesetterCreateLine}
function CTTypesetterCreateWithAttributedString(string_: CFAttributedStringRef): CTTypesetterRef; cdecl; external libCoreText name _PU + 'CTTypesetterCreateWithAttributedString';
{$EXTERNALSYM CTTypesetterCreateWithAttributedString}
function CTTypesetterCreateWithAttributedStringAndOptions(string_: CFAttributedStringRef; options: CFDictionaryRef): CTTypesetterRef; cdecl; external libCoreText name _PU + 'CTTypesetterCreateWithAttributedStringAndOptions';
{$EXTERNALSYM CTTypesetterCreateWithAttributedStringAndOptions}
function CTTypesetterGetTypeID: CFTypeID; cdecl; external libCoreText name _PU + 'CTTypesetterGetTypeID';
{$EXTERNALSYM CTTypesetterGetTypeID}
function CTTypesetterSuggestClusterBreak(typesetter: CTTypesetterRef; startIndex: CFIndex; width: double): CFIndex; cdecl; external libCoreText name _PU + 'CTTypesetterSuggestClusterBreak';
{$EXTERNALSYM CTTypesetterSuggestClusterBreak}
function CTTypesetterSuggestLineBreak(typesetter: CTTypesetterRef; startIndex: CFIndex; width: double): CFIndex; cdecl; external libCoreText name _PU + 'CTTypesetterSuggestLineBreak';
{$EXTERNALSYM CTTypesetterSuggestLineBreak}

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
