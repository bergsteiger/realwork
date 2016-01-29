{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFPreferences.h                        }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$I CFBase.inc}
{$I CFData.inc}
{$I CFStream.inc}
{$I CFString.inc}

{$IFNDEF __COREFOUNDATION_CFPROPERTYLIST__}

{$DEFINE __COREFOUNDATION_CFPROPERTYLIST__}

const
  kCFPropertyListImmutable                  = 0;
  {$EXTERNALSYM kCFPropertyListImmutable}
  kCFPropertyListMutableContainers          = 1;
  {$EXTERNALSYM kCFPropertyListMutableContainers}
  kCFPropertyListMutableContainersAndLeaves = 2;
  {$EXTERNALSYM kCFPropertyListMutableContainersAndLeaves}
type
  CFPropertyListMutabilityOptions = CFOptionFlags;
  {$EXTERNALSYM CFPropertyListMutabilityOptions}

{ 
	Creates a property list object from its XML description; xmlData should
	be the raw bytes of that description, possibly the contents of an XML
	file. Returns NULL if the data cannot be parsed; if the parse fails
	and errorString is non-NULL, a human-readable description of the failure
	is returned in errorString. It is the caller's responsibility to release
	either the returned object or the error string, whichever is applicable.
 
        This function is obsolete and will be deprecated soon. See CFPropertyListCreateWithData() for a replacement.
 }
function CFPropertyListCreateFromXMLData(allocator: CFAllocatorRef; 
  xmlData: CFDataRef; mutabilityOption: CFOptionFlags; 
  errorString: PCFStringRef): CFPropertyListRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPropertyListCreateFromXMLData';
{$EXTERNALSYM CFPropertyListCreateFromXMLData}

{ 
	Returns the XML description of the given object; propertyList must
	be one of the supported property list types, and (for composite types
	like CFArray and CFDictionary) must not contain any elements that
	are not themselves of a property list type. If a non-property list
	type is encountered, NULL is returned. The returned data is
	appropriate for writing out to an XML file. Note that a data, not a
	string, is returned because the bytes contain in them a description
	of the string encoding used.
 
        This function is obsolete and will be deprecated soon. See CFPropertyListCreateData() for a replacement.
 }
function CFPropertyListCreateXMLData(allocator: CFAllocatorRef; 
  propertyList: CFPropertyListRef): CFDataRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPropertyListCreateXMLData';
{$EXTERNALSYM CFPropertyListCreateXMLData}

{ 
	Recursively creates a copy of the given property list (so nested arrays
	and dictionaries are copied as well as the top-most container). The
	resulting property list has the mutability characteristics determined
	by mutabilityOption.
 }
function CFPropertyListCreateDeepCopy(allocator: CFAllocatorRef; 
  propertyList: CFPropertyListRef; 
  mutabilityOption: CFOptionFlags): CFPropertyListRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPropertyListCreateDeepCopy';
{$EXTERNALSYM CFPropertyListCreateDeepCopy}

const
  kCFPropertyListOpenStepFormat    = 1; 
  {$EXTERNALSYM kCFPropertyListOpenStepFormat}
  kCFPropertyListXMLFormat_v1_0    = 100; 
  {$EXTERNALSYM kCFPropertyListXMLFormat_v1_0}
  kCFPropertyListBinaryFormat_v1_0 = 200; 
  {$EXTERNALSYM kCFPropertyListBinaryFormat_v1_0}
type
  PCFPropertyListFormat = ^CFPropertyListFormat;
  CFPropertyListFormat = CFIndex; 
  {$EXTERNALSYM CFPropertyListFormat}

{ Returns true if the object graph rooted at plist is a valid property list
 * graph -- that is, no cycles, containing only plist objects, and dictionary
 * keys are strings. The debugging library version spits out some messages
 * to be helpful. The plist structure which is to be allowed is given by
 * the format parameter. }
function CFPropertyListIsValid(plist: CFPropertyListRef; 
  format: CFPropertyListFormat): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFPropertyListIsValid';
{$EXTERNALSYM CFPropertyListIsValid}

{ Writes the bytes of a plist serialization out to the stream.  The
 * stream must be opened and configured -- the function simply writes
 * a bunch of bytes to the stream. The output plist format can be chosen.
 * Leaves the stream open, but note that reading a plist expects the
 * reading stream to end wherever the writing ended, so that the
 * end of the plist data can be identified. Returns the number of bytes
 * written, or 0 on error. Error messages are not currently localized, but
 * may be in the future, so they are not suitable for comparison. 
 *
 * This function is obsolete and will be deprecated soon. See CFPropertyListWrite() for a replacement. }
function CFPropertyListWriteToStream(propertyList: CFPropertyListRef; 
  stream: CFWriteStreamRef; format: CFPropertyListFormat; 
  errorString: PCFStringRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFPropertyListWriteToStream';
{$EXTERNALSYM CFPropertyListWriteToStream}


{ Same as current function CFPropertyListCreateFromXMLData()
 * but takes a stream instead of data, and works on any plist file format.
 * CFPropertyListCreateFromXMLData() also works on any plist file format.
 * The stream must be open and configured -- the function simply reads a bunch
 * of bytes from it starting at the current location in the stream, to the END
 * of the stream, which is expected to be the end of the plist, or up to the
 * number of bytes given by the length parameter if it is not 0. Error messages
 * are not currently localized, but may be in the future, so they are not
 * suitable for comparison. 
 *
 * This function is obsolete and will be deprecated soon. See CFPropertyListCreateWithStream() for a replacement. }
function CFPropertyListCreateFromStream(allocator: CFAllocatorRef; 
  stream: CFReadStreamRef; streamLength: CFIndex; 
  mutabilityOption: CFOptionFlags; format: PCFPropertyListFormat;
  errorString: PCFStringRef): CFPropertyListRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPropertyListCreateFromStream';
{$EXTERNALSYM CFPropertyListCreateFromStream}


const
  kCFPropertyListReadCorruptError        = 3840;         // Error parsing a property list
  {$EXTERNALSYM kCFPropertyListReadCorruptError}
  kCFPropertyListReadUnknownVersionError = 3841;         // The version number in the property list is unknown
  {$EXTERNALSYM kCFPropertyListReadUnknownVersionError}
  kCFPropertyListReadStreamError         = 3842;         // Stream error reading a property list
  {$EXTERNALSYM kCFPropertyListReadStreamError}
  kCFPropertyListWriteStreamError        = 3851;         // Stream error writing a property list
  {$EXTERNALSYM kCFPropertyListWriteStreamError}

{ Create a property list with a CFData input. If the format parameter is
  non-NULL, it will be set to the format of the data after parsing is complete.
  The options parameter is used to specify CFPropertyListMutabilityOptions. If
  an error occurs while parsing the data, the return value will be NULL.
  Additionally, if an error occurs and the error parameter is non-NULL, the
  error parameter will be set to a CFError describing the problem, which the
  caller must release. If the parse succeeds, the returned value is a reference
  to the new property list. It is the responsibility of the caller to release
  this value.
 }
function CFPropertyListCreateWithData(allocator: CFAllocatorRef; 
  data: CFDataRef; options: CFOptionFlags; format: PCFPropertyListFormat;
  error: PCFErrorRef): CFPropertyListRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPropertyListCreateWithData';
{$EXTERNALSYM CFPropertyListCreateWithData}

{ Create and return a property list with a CFReadStream input. TIf the format
  parameter is non-NULL, it will be set to the format of the data after parsing
  is complete. The options parameter is used to specify
  CFPropertyListMutabilityOptions. The streamLength parameter specifies the
  number of bytes to read from the stream. Set streamLength to 0 to read until
  the end of the stream is detected. If an error occurs while parsing the data,
  the return value will be NULL. Additionally, if an error occurs and the error
  parameter is non-NULL, the error parameter will be set to a CFError
  describing the problem, which the caller must release. If the parse succeeds,
  the returned value is a reference to the new property list. It is the
  responsibility of the caller to release this value.
 }
function CFPropertyListCreateWithStream(allocator: CFAllocatorRef; 
  stream: CFReadStreamRef; streamLength: CFIndex; options: CFOptionFlags; 
  format: PCFPropertyListFormat; error: PCFErrorRef): CFPropertyListRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPropertyListCreateWithStream';
{$EXTERNALSYM CFPropertyListCreateWithStream}

{ Write the bytes of a serialized property list out to a stream. The stream
  must be opened and configured. The format of the property list can be chosen
  with the format parameter. The options parameter is currently unused and
  should be set to 0. The return value is the number of bytes written or 0 in
  the case of an error. If an error occurs and the error parameter is non-NULL,
  the error parameter will be set to a CFError describing the problem, which
  the caller must release.
 }
function CFPropertyListWrite(propertyList: CFPropertyListRef; 
  stream: CFWriteStreamRef; format: CFPropertyListFormat; 
  options: CFOptionFlags; error: PCFErrorRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFPropertyListWrite';
{$EXTERNALSYM CFPropertyListWrite}

{ Create a CFData with the bytes of a serialized property list. The format
  of the property list can be chosen with the format parameter. The options
  parameter is currently unused and should be set to 0. If an error occurs
  while parsing the data, the return value will be NULL. Additionally, if an
  error occurs and the error parameter is non-NULL, the error parameter will
  be set to a CFError describing the problem, which the caller must release.
  If the conversion succeeds, the returned value is a reference to the created
  data. It is the responsibility of the caller to release this value.
 }
function CFPropertyListCreateData(allocator: CFAllocatorRef; 
  propertyList: CFPropertyListRef; format: CFPropertyListFormat; 
  options: CFOptionFlags; error: PCFErrorRef): CFDataRef; cdecl;
  external CoreFoundationLib name _PU + 'CFPropertyListCreateData';
{$EXTERNALSYM CFPropertyListCreateData}


{$ENDIF !__COREFOUNDATION_CFPROPERTYLIST__}

