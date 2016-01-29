{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFURLEnumerator.h                      }
{          Copyright (c) 2008-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFNDEF __COREFOUNDATION_CFURLENUMERATOR__}

{$DEFINE __COREFOUNDATION_CFURLENUMERATOR__}

{$I CFArray.inc}
{$I CFBase.inc}
{$I CFError.inc}
{$I CFURL.inc}


type
  PCFURLEnumeratorRef = ^CFURLEnumeratorRef;
  CFURLEnumeratorRef = ^__CFURLEnumerator;
  {$EXTERNALSYM CFURLEnumeratorRef}
  __CFURLEnumerator = record
  end;
  {$EXTERNALSYM __CFURLEnumerator}

{ CFURLEnumeratorGetTypeID - Returns the CFURLEnumerator CFTypeID. }
function CFURLEnumeratorGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFURLEnumeratorGetTypeID';
{$EXTERNALSYM CFURLEnumeratorGetTypeID}


{ CFURLEnumeratorOptions - Options for controlling enumerator behavior. }
const
  kCFURLEnumeratorDescendRecursively        = 1 shl 0; { The directory enumerator will recurse ("depth-first") into each subdirectory enumerated }
  {$EXTERNALSYM kCFURLEnumeratorDescendRecursively}
  kCFURLEnumeratorSkipInvisibles            = 1 shl 1; { The directory or volume enumerator skips "hidden" or "invisible" objects }
  {$EXTERNALSYM kCFURLEnumeratorSkipInvisibles}
  kCFURLEnumeratorGenerateFileReferenceURLs = 1 shl 2;     { The volume enumerator generates file reference URLs }
  {$EXTERNALSYM kCFURLEnumeratorGenerateFileReferenceURLs}
  kCFURLEnumeratorSkipPackageContents       = 1 shl 3; { The directory enumerator skips package directory contents }
  {$EXTERNALSYM kCFURLEnumeratorSkipPackageContents}
type
  CFURLEnumeratorOptions = CFOptionFlags;
  {$EXTERNALSYM CFURLEnumeratorOptions}

{ CFURLEnumeratorCreateForDirectoryURL - Creates a directory enumerator,
  flat or recursive. Client specifies the directory URL to enumerate, a bit
  array of options, and an optional array of property keys to pre-fetch for
  the found URLs. Specifying pre-fetch properties allows the implementation
  to optimize device access by using bulk operations when available. Pre-
  fetching more properties than are actually needed may degrade performance.

A directory enumerator generates URLs with the same type as the directory
URL being enumerated. If the directoryURL input parameter is a file reference
URL, then generated URLs will be file reference URLs. If the directoryURL
input parameter is a file path URL, then generated URLs will be file path URLs.

The kCFURLEnumeratorGenerateFileReferenceURLs option is ignored by
CFURLEnumeratorCreateForDirectoryURL.
 }
function CFURLEnumeratorCreateForDirectoryURL(alloc: CFAllocatorRef; 
  directoryURL: CFURLRef; option: CFURLEnumeratorOptions; 
  propertyKeys: CFArrayRef): CFURLEnumeratorRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLEnumeratorCreateForDirectoryURL';
{$EXTERNALSYM CFURLEnumeratorCreateForDirectoryURL}


{ CFURLEnumeratorCreateForMountedVolumes - Creates an enumerator for
  mounted filesystem volumes. Client specifies an allocator, a bit array
  of options, and an optional array of property keys to pre-fetch for the
  volume URLs. Specifying pre-fetch properties allows the implementation
  to optimize device access by using bulk operations when available. Pre-
  fetching more properties than are actually needed may degrade performance.

A volume enumerator generates file path URLs. If you want a volume enumerator
to generate file reference URLs, pass the
kCFURLEnumeratorGenerateFileReferenceURLs option.

The kCFURLEnumeratorDescendRecursively and kCFURLEnumeratorSkipPackageContents
options are ignored by CFURLEnumeratorCreateForMountedVolumes.
 }
function CFURLEnumeratorCreateForMountedVolumes(alloc: CFAllocatorRef; 
  option: CFURLEnumeratorOptions; 
  propertyKeys: CFArrayRef): CFURLEnumeratorRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLEnumeratorCreateForMountedVolumes';
{$EXTERNALSYM CFURLEnumeratorCreateForMountedVolumes}


{ CFURLEnumeratorResult - Results for CFURLEnumeratorGetNextURL }
const
  kCFURLEnumeratorSuccess = 1;      { The enumeration was successful. The url output parameter is valid. }
  {$EXTERNALSYM kCFURLEnumeratorSuccess}
  kCFURLEnumeratorEnd     = 2;   { The enumeration is complete. }
  {$EXTERNALSYM kCFURLEnumeratorEnd}
  kCFURLEnumeratorError   = 3;    { An error occured during enumeration. The retained error output parameter describes the error. }
  {$EXTERNALSYM kCFURLEnumeratorError}
type
  CFURLEnumeratorResult = CFIndex; 
  {$EXTERNALSYM CFURLEnumeratorResult}

{ CFURLEnumeratorGetNextURL - Advances the enumerator. If
  kCFURLEnumeratorSuccess is returned, the url output parameter returns
  the next URL found. If kCFURLEnumeratorError is returned, an error has
  occured and the error output parameter describes the error. If
  kCFURLEnumeratorEnd, the enumeration is finished.

The url output parameter, if returned, is not retained. The error output
parameter, if returned, is retained and must be released.
 }
function CFURLEnumeratorGetNextURL(enumerator: CFURLEnumeratorRef; 
  url: PCFURLRef; error: PCFErrorRef): CFURLEnumeratorResult; cdecl;
  external CoreFoundationLib name _PU + 'CFURLEnumeratorGetNextURL';
{$EXTERNALSYM CFURLEnumeratorGetNextURL}


{ CFURLEnumeratorSkipDescendents - Tells a recursive CFURLEnumerator not
  to descend into the directory of the last CFURLRef returned by
  CFURLEnumeratorGetNextURL.

Calls to CFURLEnumeratorSkipDescendents are ignored if:
    * CFURLEnumeratorGetNextURL has never been called with the CFURLEnumerator.
    * The last CFURL returned by CFURLEnumeratorGetNextURL is not a directory.
    * The CFURLEnumerator was not created with CFURLEnumeratorCreateForDirectoryURL using the kCFURLEnumeratorDescendRecursively option.
 }
procedure CFURLEnumeratorSkipDescendents(
  enumerator: CFURLEnumeratorRef); cdecl;
  external CoreFoundationLib name _PU + 'CFURLEnumeratorSkipDescendents';
{$EXTERNALSYM CFURLEnumeratorSkipDescendents}


{ CFURLEnumeratorGetDescendentLevel - Returns the number of levels a
  directory enumerator has descended down into the directory hierarchy
  from the starting directory. The children of the starting directory
  are at level 1. Each time a recursive enumerator descends into a
  subdirectory, it adds one to the descendent level. It then subtracts
  one from the level when it finishes a subdirectory and continues enumerating
  the parent directory.
 }
function CFURLEnumeratorGetDescendentLevel(
  enumerator: CFURLEnumeratorRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFURLEnumeratorGetDescendentLevel';
{$EXTERNALSYM CFURLEnumeratorGetDescendentLevel}


{ CFURLEnumeratorGetSourceDidChange - Returns true if the data source
  changed while being enumerated. If the directory contents (or the
  volume list) changes during enumeration, the enumerator's results may be
  stale. Best practice is to check the result
  CFURLEnumeratorGetSourceDidChange() after completing enumeration, and
  repeat if necessary by creating a new enumerator. Be prepared to handle
  rapidly changing directories, for which clean enumeration may not be possible.
 }
function CFURLEnumeratorGetSourceDidChange(
  enumerator: CFURLEnumeratorRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFURLEnumeratorGetSourceDidChange';
{$EXTERNALSYM CFURLEnumeratorGetSourceDidChange}


{$ENDIF !__COREFOUNDATION_CFURLENUMERATOR__}

