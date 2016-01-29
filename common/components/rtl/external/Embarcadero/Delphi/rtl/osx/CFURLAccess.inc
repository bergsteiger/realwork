{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFURLAccess.h                          }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFNDEF __COREFOUNDATION_CFURLACCESS__}

{$DEFINE __COREFOUNDATION_CFURLACCESS__}

{$I CFArray.inc}
{$I CFBase.inc}
{$I CFData.inc}
{$I CFDictionary.inc}
{$I CFError.inc}
{$I CFString.inc}
{$I CFURL.inc}


{ Attempts to read the data and properties for the given URL.  If
only interested in one of the resourceData and properties, pass NULL
for the other.  If properties is non-NULL and desiredProperties is
NULL, then all properties are fetched.  Returns success or failure;
note that as much work as possible is done even if false is returned.
So for instance if one property is not available, the others are
fetched anyway. errorCode is set to 0 on success, and some other
value on failure.  If non-NULL, it is the caller 's responsibility
to release resourceData and properties.

    Apple reserves for its use all negative error code values; these
values represent errors common to any scheme.  Scheme-specific error
codes should be positive, non-zero, and should be used only if one of
the predefined Apple error codes does not apply.  Error codes should
be publicized and documented with the scheme-specific properties.

NOTE: When asking for the resource data, this call will allocate the entire
resource in memory. This can be very expensive, depending on the size of the
resource (file). Please use CFStream or other techniques if you are downloading
large files.

 }
function CFURLCreateDataAndPropertiesFromResource(alloc: CFAllocatorRef; 
  url: CFURLRef; resourceData: PCFDataRef; properties: PCFDictionaryRef;
  desiredProperties: CFArrayRef; out errorCode: SInt32): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreateDataAndPropertiesFromResource';
{$EXTERNALSYM CFURLCreateDataAndPropertiesFromResource}

{ Attempts to write the given data and properties to the given URL.
If dataToWrite is NULL, only properties are written out (use
CFURLDestroyResource() to delete a resource).  Properties not present
in propertiesToWrite are left unchanged, hence if propertiesToWrite
is NULL or empty, the URL's properties are not changed at all.
Returns success or failure; errorCode is set as for
CFURLCreateDataAndPropertiesFromResource(), above.
 }
function CFURLWriteDataAndPropertiesToResource(url: CFURLRef; 
  dataToWrite: CFDataRef; propertiesToWrite: CFDictionaryRef; 
  out errorCode: SInt32): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFURLWriteDataAndPropertiesToResource';
{$EXTERNALSYM CFURLWriteDataAndPropertiesToResource}

{ Destroys the resource indicated by url. }
{ Returns success or failure; errorCode set as above. }
function CFURLDestroyResource(url: CFURLRef;
  out errorCode: SInt32): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFURLDestroyResource';
{$EXTERNALSYM CFURLDestroyResource}

{ Convenience method which calls through to CFURLCreateDataAndPropertiesFromResource(). }
{ Returns NULL on error and sets errorCode accordingly. }
function CFURLCreatePropertyFromResource(alloc: CFAllocatorRef; url: CFURLRef;
  &property: CFStringRef; out errorCode: SInt32): CFTypeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFURLCreatePropertyFromResource';
{$EXTERNALSYM CFURLCreatePropertyFromResource}


{ Common error codes (returned only by the older APIs that predate CFError) }
const
  kCFURLUnknownError                 = -10;
  {$EXTERNALSYM kCFURLUnknownError}
  kCFURLUnknownSchemeError           = -11;
  {$EXTERNALSYM kCFURLUnknownSchemeError}
  kCFURLResourceNotFoundError        = -12;
  {$EXTERNALSYM kCFURLResourceNotFoundError}
  kCFURLResourceAccessViolationError = -13;
  {$EXTERNALSYM kCFURLResourceAccessViolationError}
  kCFURLRemoteHostUnavailableError   = -14;
  {$EXTERNALSYM kCFURLRemoteHostUnavailableError}
  kCFURLImproperArgumentsError       = -15;
  {$EXTERNALSYM kCFURLImproperArgumentsError}
  kCFURLUnknownPropertyKeyError      = -16;
  {$EXTERNALSYM kCFURLUnknownPropertyKeyError}
  kCFURLPropertyKeyUnavailableError  = -17;
  {$EXTERNALSYM kCFURLPropertyKeyUnavailableError}
  kCFURLTimeoutError                 = -18;
  {$EXTERNALSYM kCFURLTimeoutError}
type
  CFURLError = CFIndex;
  {$EXTERNALSYM CFURLError}

{ Older property keys }

function kCFURLFileExists: CFStringRef;
{$EXTERNALSYM kCFURLFileExists}
function kCFURLFileDirectoryContents: CFStringRef;
{$EXTERNALSYM kCFURLFileDirectoryContents}
function kCFURLFileLength: CFStringRef;
{$EXTERNALSYM kCFURLFileLength}
function kCFURLFileLastModificationTime: CFStringRef;
{$EXTERNALSYM kCFURLFileLastModificationTime}
function kCFURLFilePOSIXMode: CFStringRef;
{$EXTERNALSYM kCFURLFilePOSIXMode}
function kCFURLFileOwnerID: CFStringRef;
{$EXTERNALSYM kCFURLFileOwnerID}
function kCFURLHTTPStatusCode: CFStringRef;
{$EXTERNALSYM kCFURLHTTPStatusCode}
function kCFURLHTTPStatusLine: CFStringRef;
{$EXTERNALSYM kCFURLHTTPStatusLine}

{ The value of kCFURLFileExists is a CFBoolean }
{ The value of kCFURLFileDirectoryContents is a CFArray containing CFURLs.
  An empty array means the directory exists, but is empty }
{ The value of kCFURLFileLength is a CFNumber giving the file's length in bytes }
{ The value of kCFURLFileLastModificationTime is a CFDate }
{ The value of kCFURLFilePOSIXMode is a CFNumber as given in stat.h }
{ The value of kCFURLFileOwnerID is a CFNumber representing the owner's uid }

{ Properties for the http: scheme.  Except for the common error codes, above,
  errorCode will be set to the HTTP response status code upon failure.  Any
  HTTP header name can also be used as a property }
{ The value of kCFURLHTTPStatusCode is a CFNumber }
{ The value of kCFURLHTTPStatusLine is a CFString }


{$ENDIF !__COREFOUNDATION_CFURLACCESS__}

