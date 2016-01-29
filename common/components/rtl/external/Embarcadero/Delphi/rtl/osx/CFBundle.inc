{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFBundle.h                             }
{          Copyright (c) 1999-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFNDEF __COREFOUNDATION_CFBUNDLE__}

{$DEFINE __COREFOUNDATION_CFBUNDLE__}

{$I CFArray.inc}
{$I CFBase.inc}
{$I CFDictionary.inc}
{$I CFError.inc}
{$I CFString.inc}
{$I CFURL.inc}

type
  PCFBundleRef = ^CFBundleRef;
  CFBundleRef = ^__CBundle;
  {$EXTERNALSYM CFBundleRef}
  __CBundle = record
  end;
  {$EXTERNALSYM __CBundle}

  PCFPlugInRef = ^CFPlugInRef;
  CFPlugInRef = ^__CFPlugIn;
  {$EXTERNALSYM CFPlugInRef}
  __CFPlugIn = record
  end;
  {$EXTERNALSYM __CFPlugIn}

{ ===================== Standard Info.plist keys ===================== }
function kCFBundleInfoDictionaryVersionKey: CFStringRef;
{$EXTERNALSYM kCFBundleInfoDictionaryVersionKey}
{ The version of the Info.plist format }
function kCFBundleExecutableKey: CFStringRef;
{$EXTERNALSYM kCFBundleExecutableKey}
{ The name of the executable in this bundle, if any }
function kCFBundleIdentifierKey: CFStringRef;
{$EXTERNALSYM kCFBundleIdentifierKey}
{ The bundle identifier (for CFBundleGetBundleWithIdentifier()) }
function kCFBundleVersionKey: CFStringRef;
{$EXTERNALSYM kCFBundleVersionKey}
{ The version number of the bundle.  For Mac OS 9 style version numbers (for example "2.5.3d5"), }
{ clients can use CFBundleGetVersionNumber() instead of accessing this key directly since that }
{ function will properly convert the version string into its compact integer representation. }
function kCFBundleDevelopmentRegionKey: CFStringRef;
{$EXTERNALSYM kCFBundleDevelopmentRegionKey}
{ The name of the development language of the bundle. }
function kCFBundleNameKey: CFStringRef;
{$EXTERNALSYM kCFBundleNameKey}
{ The human-readable name of the bundle.  This key is often found in the InfoPlist.strings since it is usually localized. }
function kCFBundleLocalizationsKey: CFStringRef;
{$EXTERNALSYM kCFBundleLocalizationsKey}
{ Allows an unbundled application that handles localization itself to specify which localizations it has available. }

{ ===================== Finding Bundles ===================== }

function CFBundleGetMainBundle: CFBundleRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetMainBundle';
{$EXTERNALSYM CFBundleGetMainBundle}

function CFBundleGetBundleWithIdentifier(
  bundleID: CFStringRef): CFBundleRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetBundleWithIdentifier';
{$EXTERNALSYM CFBundleGetBundleWithIdentifier}
{ A bundle can name itself by providing a key in the info dictionary. }
{ This facility is meant to allow bundle-writers to get hold of their }
{ bundle from their code without having to know where it was on the disk. }
{ This is meant to be a replacement mechanism for +bundleForClass: users. }
{ Note that this does not search for bundles on the disk; it will locate }
{ only bundles already loaded or otherwise known to the current process. }

function CFBundleGetAllBundles: CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetAllBundles';
{$EXTERNALSYM CFBundleGetAllBundles}
{ This is potentially expensive, and not thread-safe.  Use with care. }
{ Best used for debuggging or other diagnostic purposes. }

{ ===================== Creating Bundles ===================== }

function CFBundleGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetTypeID';
{$EXTERNALSYM CFBundleGetTypeID}

function CFBundleCreate(allocator: CFAllocatorRef;
  bundleURL: CFURLRef): CFBundleRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCreate';
{$EXTERNALSYM CFBundleCreate}
{ Might return an existing instance with the ref-count bumped. }

function CFBundleCreateBundlesFromDirectory(allocator: CFAllocatorRef;
  directoryURL: CFURLRef; bundleType: CFStringRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCreateBundlesFromDirectory';
{$EXTERNALSYM CFBundleCreateBundlesFromDirectory}
{ Create instances for all bundles in the given directory matching the given type }
{ (or all of them if bundleType is NULL).  Instances are created using CFBundleCreate() and are not released. }

{ ==================== Basic Bundle Info ==================== }

function CFBundleCopyBundleURL(bundle: CFBundleRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyBundleURL';
{$EXTERNALSYM CFBundleCopyBundleURL}

function CFBundleGetValueForInfoDictionaryKey(bundle: CFBundleRef;
  key: CFStringRef): CFTypeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetValueForInfoDictionaryKey';
{$EXTERNALSYM CFBundleGetValueForInfoDictionaryKey}
{ Returns a localized value if available, otherwise the global value. }
{ This is the recommended function for examining the info dictionary. }

function CFBundleGetInfoDictionary(
  bundle: CFBundleRef): CFDictionaryRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetInfoDictionary';
{$EXTERNALSYM CFBundleGetInfoDictionary}
{ This is the global info dictionary.  Note that CFBundle may add }
{ extra keys to the dictionary for its own use. }

function CFBundleGetLocalInfoDictionary(
  bundle: CFBundleRef): CFDictionaryRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetLocalInfoDictionary';
{$EXTERNALSYM CFBundleGetLocalInfoDictionary}
{ This is the localized info dictionary. }

procedure CFBundleGetPackageInfo(bundle: CFBundleRef; packageType: PUInt32;
  packageCreator: PUInt32); cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetPackageInfo';
{$EXTERNALSYM CFBundleGetPackageInfo}

function CFBundleGetIdentifier(bundle: CFBundleRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetIdentifier';
{$EXTERNALSYM CFBundleGetIdentifier}

function CFBundleGetVersionNumber(bundle: CFBundleRef): UInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetVersionNumber';
{$EXTERNALSYM CFBundleGetVersionNumber}

function CFBundleGetDevelopmentRegion(bundle: CFBundleRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetDevelopmentRegion';
{$EXTERNALSYM CFBundleGetDevelopmentRegion}

function CFBundleCopySupportFilesDirectoryURL(
  bundle: CFBundleRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopySupportFilesDirectoryURL';
{$EXTERNALSYM CFBundleCopySupportFilesDirectoryURL}

function CFBundleCopyResourcesDirectoryURL(
  bundle: CFBundleRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyResourcesDirectoryURL';
{$EXTERNALSYM CFBundleCopyResourcesDirectoryURL}

function CFBundleCopyPrivateFrameworksURL(
  bundle: CFBundleRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyPrivateFrameworksURL';
{$EXTERNALSYM CFBundleCopyPrivateFrameworksURL}

function CFBundleCopySharedFrameworksURL(bundle: CFBundleRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopySharedFrameworksURL';
{$EXTERNALSYM CFBundleCopySharedFrameworksURL}

function CFBundleCopySharedSupportURL(bundle: CFBundleRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopySharedSupportURL';
{$EXTERNALSYM CFBundleCopySharedSupportURL}

function CFBundleCopyBuiltInPlugInsURL(bundle: CFBundleRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyBuiltInPlugInsURL';
{$EXTERNALSYM CFBundleCopyBuiltInPlugInsURL}

{ ------------- Basic Bundle Info without a CFBundle instance ------------- }
{ This API is provided to enable developers to retrieve basic information }
{ about a bundle without having to create an instance of CFBundle. }
{ Because of caching behavior when a CFBundle instance exists, it will be faster }
{ to actually create a CFBundle if you need to retrieve multiple pieces of info. }
function CFBundleCopyInfoDictionaryInDirectory(
  bundleURL: CFURLRef): CFDictionaryRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyInfoDictionaryInDirectory';
{$EXTERNALSYM CFBundleCopyInfoDictionaryInDirectory}

function CFBundleGetPackageInfoInDirectory(url: CFURLRef; packageType: PUInt32;
  packageCreator: PUInt32): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetPackageInfoInDirectory';
{$EXTERNALSYM CFBundleGetPackageInfoInDirectory}

{ ==================== Resource Handling API ==================== }

function CFBundleCopyResourceURL(bundle: CFBundleRef; resourceName: CFStringRef;
  resourceType: CFStringRef; subDirName: CFStringRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyResourceURL';
{$EXTERNALSYM CFBundleCopyResourceURL}

function CFBundleCopyResourceURLsOfType(bundle: CFBundleRef;
  resourceType: CFStringRef; subDirName: CFStringRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyResourceURLsOfType';
{$EXTERNALSYM CFBundleCopyResourceURLsOfType}

function CFBundleCopyLocalizedString(bundle: CFBundleRef; key: CFStringRef;
  value: CFStringRef; tableName: CFStringRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyLocalizedString';
{$EXTERNALSYM CFBundleCopyLocalizedString}

function CFCopyLocalizedString(key: CFStringRef; comment: MarshaledAString): CFStringRef; inline;
{$EXTERNALSYM CFCopyLocalizedString}

function CFCopyLocalizedStringFromTable(key: CFStringRef; tbl: CFStringRef;
  comment: MarshaledAString): CFStringRef; inline;
{$EXTERNALSYM CFCopyLocalizedStringFromTable}

function CFCopyLocalizedStringFromTableInBundle(key: CFStringRef; tbl: CFStringRef;
  bundle: CFBundleRef; comment: MarshaledAString): CFStringRef; inline;
{$EXTERNALSYM CFCopyLocalizedStringFromTableInBundle}

function CFCopyLocalizedStringWithDefaultValue(key: CFStringRef; tbl: CFStringRef;
  bundle: CFBundleRef; value: CFStringRef; comment: MarshaledAString): CFStringRef; inline;
{$EXTERNALSYM CFCopyLocalizedStringWithDefaultValue}

{ ------------- Resource Handling without a CFBundle instance ------------- }
{ This API is provided to enable developers to use the CFBundle resource }
{ searching policy without having to create an instance of CFBundle. }
{ Because of caching behavior when a CFBundle instance exists, it will be faster }
{ to actually create a CFBundle if you need to access several resources. }

function CFBundleCopyResourceURLInDirectory(bundleURL: CFURLRef;
  resourceName: CFStringRef; resourceType: CFStringRef;
  subDirName: CFStringRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyResourceURLInDirectory';
{$EXTERNALSYM CFBundleCopyResourceURLInDirectory}

function CFBundleCopyResourceURLsOfTypeInDirectory(bundleURL: CFURLRef;
  resourceType: CFStringRef; subDirName: CFStringRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyResourceURLsOfTypeInDirectory';
{$EXTERNALSYM CFBundleCopyResourceURLsOfTypeInDirectory}

{ =========== Localization-specific Resource Handling API =========== }
{ This API allows finer-grained control over specific localizations,  }
{ as distinguished from the above API, which always uses the user's   }
{ preferred localizations for the bundle in the current app context.  }

function CFBundleCopyBundleLocalizations(
  bundle: CFBundleRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyBundleLocalizations';
{$EXTERNALSYM CFBundleCopyBundleLocalizations}
{ Lists the localizations that a bundle contains.  }

function CFBundleCopyPreferredLocalizationsFromArray(
  locArray: CFArrayRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyPreferredLocalizationsFromArray';
{$EXTERNALSYM CFBundleCopyPreferredLocalizationsFromArray}
{ Given an array of possible localizations, returns the one or more }
{ of them that CFBundle would use in the current application context. }
{ To determine the localizations that would be used for a particular }
{ bundle in the current application context, apply this function to the }
{ result of CFBundleCopyBundleLocalizations().  }

function CFBundleCopyLocalizationsForPreferences(locArray: CFArrayRef;
  prefArray: CFArrayRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyLocalizationsForPreferences';
{$EXTERNALSYM CFBundleCopyLocalizationsForPreferences}
{ Given an array of possible localizations, returns the one or more of }
{ them that CFBundle would use, without reference to the current application }
{ context, if the user's preferred localizations were given by prefArray. }
{ If prefArray is NULL, the current user's actual preferred localizations will }
{ be used. This is not the same as CFBundleCopyPreferredLocalizationsFromArray(), }
{ because that function takes the current application context into account. }
{ To determine the localizations that another application would use, apply }
{ this function to the result of CFBundleCopyBundleLocalizations().  }

function CFBundleCopyResourceURLForLocalization(bundle: CFBundleRef;
  resourceName: CFStringRef; resourceType: CFStringRef; subDirName: CFStringRef;
  localizationName: CFStringRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyResourceURLForLocalization';
{$EXTERNALSYM CFBundleCopyResourceURLForLocalization}

function CFBundleCopyResourceURLsOfTypeForLocalization(bundle: CFBundleRef;
  resourceType: CFStringRef; subDirName: CFStringRef;
  localizationName: CFStringRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyResourceURLsOfTypeForLocalization';
{$EXTERNALSYM CFBundleCopyResourceURLsOfTypeForLocalization}
{ The localizationName argument to CFBundleCopyResourceURLForLocalization() or }
{ CFBundleCopyResourceURLsOfTypeForLocalization() must be identical to one of the }
{ localizations in the bundle, as returned by CFBundleCopyBundleLocalizations(). }
{ It is recommended that either CFBundleCopyPreferredLocalizationsFromArray() or }
{ CFBundleCopyLocalizationsForPreferences() be used to select the localization. }

{ =================== Unbundled application info ===================== }
{ This API is provided to enable developers to retrieve bundle-related }
{ information about an application that may be bundled or unbundled.   }
function CFBundleCopyInfoDictionaryForURL(
  url: CFURLRef): CFDictionaryRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyInfoDictionaryForURL';
{$EXTERNALSYM CFBundleCopyInfoDictionaryForURL}
{ For a directory URL, this is equivalent to CFBundleCopyInfoDictionaryInDirectory(). }
{ For a plain file URL representing an unbundled executable, this will attempt to read }
{ an info dictionary from the (__TEXT, __info_plist) section, if it is a Mach-o file, }
{ or from a 'plst' resource.  }

function CFBundleCopyLocalizationsForURL(url: CFURLRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyLocalizationsForURL';
{$EXTERNALSYM CFBundleCopyLocalizationsForURL}
{ For a directory URL, this is equivalent to calling CFBundleCopyBundleLocalizations() }
{ on the corresponding bundle.  For a plain file URL representing an unbundled executable, }
{ this will attempt to determine its localizations using the CFBundleLocalizations and }
{ CFBundleDevelopmentRegion keys in the dictionary returned by CFBundleCopyInfoDictionaryForURL, }
{ or from a 'vers' resource if those are not present.  }

function CFBundleCopyExecutableArchitecturesForURL(
  url: CFURLRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyExecutableArchitecturesForURL';
{$EXTERNALSYM CFBundleCopyExecutableArchitecturesForURL}
{ For a directory URL, this is equivalent to calling CFBundleCopyExecutableArchitectures() }
{ on the corresponding bundle.  For a plain file URL representing an unbundled executable, }
{ this will return the architectures it provides, if it is a Mach-o file, or NULL otherwise. }

{ ==================== Primitive Code Loading API ==================== }
{ This API abstracts the various different executable formats supported on }
{ various platforms.  It can load DYLD, CFM, or DLL shared libraries (on their }
{ appropriate platforms) and gives a uniform API for looking up functions. }

function CFBundleCopyExecutableURL(bundle: CFBundleRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyExecutableURL';
{$EXTERNALSYM CFBundleCopyExecutableURL}

const
  kCFBundleExecutableArchitectureI386   = $00000007;
  {$EXTERNALSYM kCFBundleExecutableArchitectureI386}
  kCFBundleExecutableArchitecturePPC    = $00000012;
  {$EXTERNALSYM kCFBundleExecutableArchitecturePPC}
  kCFBundleExecutableArchitectureX86_64 = $01000007;
  {$EXTERNALSYM kCFBundleExecutableArchitectureX86_64}
  kCFBundleExecutableArchitecturePPC64  = $01000012;
  {$EXTERNALSYM kCFBundleExecutableArchitecturePPC64}

function CFBundleCopyExecutableArchitectures(
  bundle: CFBundleRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyExecutableArchitectures';
{$EXTERNALSYM CFBundleCopyExecutableArchitectures}
{ If the bundle's executable exists and is a Mach-o file, this function will return an array }
{ of CFNumbers whose values are integers representing the architectures the file provides. }
{ The values currently in use are those listed in the enum above, but others may be added }
{ in the future.  If the executable is not a Mach-o file, this function returns NULL. }

function CFBundlePreflightExecutable(bundle: CFBundleRef;
  error: PCFErrorRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFBundlePreflightExecutable';
{$EXTERNALSYM CFBundlePreflightExecutable}
{ This function will return true if the bundle is loaded, or if the bundle appears to be }
{ loadable upon inspection.  This does not mean that the bundle is definitively loadable, }
{ since it may fail to load due to link errors or other problems not readily detectable. }
{ If this function detects problems, it will return false, and return a CFError by reference. }
{ It is the responsibility of the caller to release the CFError. }

function CFBundleLoadExecutableAndReturnError(bundle: CFBundleRef;
  error: PCFErrorRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleLoadExecutableAndReturnError';
{$EXTERNALSYM CFBundleLoadExecutableAndReturnError}
{ If the bundle is already loaded, this function will return true.  Otherwise, it will attempt }
{ to load the bundle, and it will return true if that attempt succeeds.  If the bundle fails }
{ to load, this function will return false, and it will return a CFError by reference.  }
{ It is the responsibility of the caller to release the CFError. }

function CFBundleLoadExecutable(bundle: CFBundleRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleLoadExecutable';
{$EXTERNALSYM CFBundleLoadExecutable}

function CFBundleIsExecutableLoaded(bundle: CFBundleRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleIsExecutableLoaded';
{$EXTERNALSYM CFBundleIsExecutableLoaded}

procedure CFBundleUnloadExecutable(bundle: CFBundleRef); cdecl;
  external CoreFoundationLib name _PU + 'CFBundleUnloadExecutable';
{$EXTERNALSYM CFBundleUnloadExecutable}

function CFBundleGetFunctionPointerForName(bundle: CFBundleRef;
  functionName: CFStringRef): Pointer; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetFunctionPointerForName';
{$EXTERNALSYM CFBundleGetFunctionPointerForName}

procedure CFBundleGetFunctionPointersForNames(bundle: CFBundleRef;
  functionNames: CFArrayRef; ftbl: Pointer); cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetFunctionPointersForNames';
{$EXTERNALSYM CFBundleGetFunctionPointersForNames}

function CFBundleGetDataPointerForName(bundle: CFBundleRef;
  symbolName: CFStringRef): Pointer; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetDataPointerForName';
{$EXTERNALSYM CFBundleGetDataPointerForName}

procedure CFBundleGetDataPointersForNames(bundle: CFBundleRef;
  symbolNames: CFArrayRef; stbl: Pointer); cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetDataPointersForNames';
{$EXTERNALSYM CFBundleGetDataPointersForNames}

function CFBundleCopyAuxiliaryExecutableURL(bundle: CFBundleRef;
  executableName: CFStringRef): CFURLRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCopyAuxiliaryExecutableURL';
{$EXTERNALSYM CFBundleCopyAuxiliaryExecutableURL}
{ This function can be used to find executables other than your main }
{ executable.  This is useful, for instance, for applications that have }
{ some command line tool that is packaged with and used by the application. }
{ The tool can be packaged in the various platform executable directories }
{ in the bundle and can be located with this function.  This allows an }
{ app to ship versions of the tool for each platform as it does for the }
{ main app executable. }

{ ==================== Getting a bundle's plugIn ==================== }

function CFBundleGetPlugIn(bundle: CFBundleRef): CFPlugInRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleGetPlugIn';
{$EXTERNALSYM CFBundleGetPlugIn}

{ ==================== Resource Manager-Related API ==================== }

type
  PCFBundleRefNum = ^CFBundleRefNum;
{$IFDEF CPUX64} // __LP64__
  CFBundleRefNum = Int64;
  {$EXTERNALSYM CFBundleRefNum}
{$ELSE !CPUX64}
  CFBundleRefNum = SInt16;
  {$EXTERNALSYM CFBundleRefNum}
{$ENDIF !CPUX64}

function CFBundleOpenBundleResourceMap(
  bundle: CFBundleRef): CFBundleRefNum; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleOpenBundleResourceMap';
{$EXTERNALSYM CFBundleOpenBundleResourceMap}
{ This function opens the non-localized and the localized resource files }
{ (if any) for the bundle, creates and makes current a single read-only }
{ resource map combining both, and returns a reference number for it. }
{ If it is called multiple times, it opens the files multiple times, }
{ and returns distinct reference numbers.  }

function CFBundleOpenBundleResourceFiles(bundle: CFBundleRef;
  refNum: PCFBundleRefNum; localizedRefNum: PCFBundleRefNum): SInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFBundleOpenBundleResourceFiles';
{$EXTERNALSYM CFBundleOpenBundleResourceFiles}
{ Similar to CFBundleOpenBundleResourceMap(), except that it creates two }
{ separate resource maps and returns reference numbers for both. }

procedure CFBundleCloseBundleResourceMap(bundle: CFBundleRef;
  refNum: CFBundleRefNum); cdecl;
  external CoreFoundationLib name _PU + 'CFBundleCloseBundleResourceMap';
{$EXTERNALSYM CFBundleCloseBundleResourceMap}

{$ENDIF __COREFOUNDATION_CFBUNDLE__}

