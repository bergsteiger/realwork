{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFString.h                             }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IF NOT DEFINED (__COREFOUNDATION_CFSTRING__)}

{$DEFINE __COREFOUNDATION_CFSTRING__}

{$I CFBase.inc}
{$I CFArray.inc}
{$I CFData.inc}
{$I CFDictionary.inc}
{$I CFCharacterSet.inc}
{$I CFLocale.inc}

(*
Please note: CFStrings are conceptually an array of Unicode characters.
However, in general, how a CFString stores this array is an implementation
detail. For instance, CFString might choose to use an array of 8-bit characters
to store its contents, or it might use multiple blocks of memory, or whatever.
This is especially true since CFString is toll-free bridged with NSString, enabling
any NSString instance to be used as a CFString. Furthermore, the implementation
may change depending on the default system encoding, the user's language, 
or even a release or update of the OS.

What this means is that you should use the following advanced functions with care:

  CFStringGetPascalStringPtr()
  CFStringGetCStringPtr()
  CFStringGetCharactersPtr()

These functions are provided for optimization only. They will either return the desired
pointer quickly, in constant time, or they return NULL. They might choose to return NULL
for many reasons; for instance it's possible that for users running in different
languages these sometimes return NULL; or in a future OS release the first two might
switch to always returning NULL. Never observing NULL returns in your usages of these
functions does not mean they won't ever return NULL. (But note the CFStringGetCharactersPtr()
exception mentioned further below.)

In your usages of these functions, if you get a NULL return, use the non-Ptr version
of the functions as shown in this example:

  char buffer[BUFSIZE];
  const char *ptr = CFStringGetCStringPtr(str, encoding);
  if (ptr == NULL) {
      if (CFStringGetCString(str, buffer, BUFSIZE, encoding)) ptr = buffer;
  }

Note that CFStringGetCString() or CFStringGetPascalString() calls might still fail --- but
that will happen in two circumstances only: The conversion from the UniChar contents of CFString
to the specified encoding fails, or the buffer is too small. If they fail, that means
the conversion was not possible.

If you need a copy of the buffer in the above example, you might consider simply calling
CFStringGetCString() in all cases --- CFStringGetCStringPtr() is simply an optimization.

In addition, the following functions, which create immutable CFStrings from developer
supplied buffers without copying the buffers, might have to actually copy
under certain circumstances (If they do copy, the buffer will be dealt with by the
"contentsDeallocator" argument.):

  CFStringCreateWithPascalStringNoCopy()
  CFStringCreateWithCStringNoCopy()
  CFStringCreateWithCharactersNoCopy()

You should of course never depend on the backing store of these CFStrings being
what you provided, and in other no circumstance should you change the contents
of that buffer (given that would break the invariant about the CFString being immutable).

Having said all this, there are actually ways to create a CFString where the backing store
is external, and can be manipulated by the developer or CFString itself:

  CFStringCreateMutableWithExternalCharactersNoCopy()
  CFStringSetExternalCharactersNoCopy()

A "contentsAllocator" is used to realloc or free the backing store by CFString.
kCFAllocatorNull can be provided to assure CFString will never realloc or free the buffer.
Developer can call CFStringSetExternalCharactersNoCopy() to update
CFString's idea of what's going on, if the buffer is changed externally. In these
strings, CFStringGetCharactersPtr() is guaranteed to return the external buffer.

These functions are here to allow wrapping a buffer of UniChar characters in a CFString,
allowing the buffer to passed into CFString functions and also manipulated via CFString
mutation functions. In general, developers should not use this technique for all strings,
as it prevents CFString from using certain optimizations.
 *)

{ Identifier for character encoding; the values are the same as Text Encoding Converter TextEncoding.
 }
type
  PCFStringEncoding = ^CFStringEncoding;
  CFStringEncoding = UInt32;
  {$EXTERNALSYM CFStringEncoding}

{ Platform-independent built-in encodings; always available on all platforms.
   Call CFStringGetSystemEncoding() to get the default system encoding.
 }
const
  kCFStringEncodingInvalidId = $ffffffff;
  {$EXTERNALSYM kCFStringEncodingInvalidId}
const
  kCFStringEncodingMacRoman      = 0;
  {$EXTERNALSYM kCFStringEncodingMacRoman}
  kCFStringEncodingWindowsLatin1 = $0500;    { ANSI codepage 1252 }
  {$EXTERNALSYM kCFStringEncodingWindowsLatin1}
  kCFStringEncodingISOLatin1     = $0201; { ISO 8859-1 }
  {$EXTERNALSYM kCFStringEncodingISOLatin1}
  kCFStringEncodingNextStepLatin = $0B01;    { NextStep encoding }
  {$EXTERNALSYM kCFStringEncodingNextStepLatin}
  kCFStringEncodingASCII         = $0600; { 0..127 (in creating CFString, values greater than 0x7F are treated as corresponding Unicode value) }
  {$EXTERNALSYM kCFStringEncodingASCII}
  kCFStringEncodingUnicode       = $0100; { kTextEncodingUnicodeDefault  + kTextEncodingDefaultFormat (aka kUnicode16BitFormat) }
  {$EXTERNALSYM kCFStringEncodingUnicode}
  kCFStringEncodingUTF8          = $08000100; { kTextEncodingUnicodeDefault + kUnicodeUTF8Format }
  {$EXTERNALSYM kCFStringEncodingUTF8}
  kCFStringEncodingNonLossyASCII = $0BFF;   { 7bit Unicode variants used by Cocoa & Java }
  {$EXTERNALSYM kCFStringEncodingNonLossyASCII}
  kCFStringEncodingUTF16         = $0100; { kTextEncodingUnicodeDefault + kUnicodeUTF16Format (alias of kCFStringEncodingUnicode) }
  {$EXTERNALSYM kCFStringEncodingUTF16}
  kCFStringEncodingUTF16BE       = $10000100; { kTextEncodingUnicodeDefault + kUnicodeUTF16BEFormat }
  {$EXTERNALSYM kCFStringEncodingUTF16BE}
  kCFStringEncodingUTF16LE       = $14000100; { kTextEncodingUnicodeDefault + kUnicodeUTF16LEFormat }
  {$EXTERNALSYM kCFStringEncodingUTF16LE}

  kCFStringEncodingUTF32         = $0C000100; { kTextEncodingUnicodeDefault + kUnicodeUTF32Format }
  {$EXTERNALSYM kCFStringEncodingUTF32}
  kCFStringEncodingUTF32BE       = $18000100; { kTextEncodingUnicodeDefault + kUnicodeUTF32BEFormat }
  {$EXTERNALSYM kCFStringEncodingUTF32BE}
  kCFStringEncodingUTF32LE       = $1C000100; { kTextEncodingUnicodeDefault + kUnicodeUTF32LEFormat }
  {$EXTERNALSYM kCFStringEncodingUTF32LE}
type
  CFStringBuiltInEncodings = CFStringEncoding;
  {$EXTERNALSYM CFStringBuiltInEncodings}


{ CFString type ID }
function CFStringGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetTypeID';
{$EXTERNALSYM CFStringGetTypeID}

{ CFSTR() allows creation of compile-time constant CFStringRefs; the argument 
should be a constant C-string.

CFSTR(), not being a "Copy" or "Create" function, does not return a new
reference for you. So, you should not release the return value. This is
much like constant C or Pascal strings --- when you use "hello world"
in a program, you do not free it.

However, strings returned from CFSTR() can be retained and released in a
properly nested fashion, just like any other CF type. That is, if you pass
a CFSTR() return value to a function such as SetMenuItemWithCFString(), the
function can retain it, then later, when it's done with it, it can release it.

Non-7 bit characters (that is, above 127) in CFSTR() are supported, although care must
be taken in dealing with files containing them. If you can trust your editor and tools
to deal with non-ASCII characters in the source code, then you can use them directly 
in CFSTR(); otherwise, you can represent such characters with their escaped octal 
equivalents in the encoding the compiler will use to interpret them (for instance, 
O-umlaut is \303\226 in UTF-8). UTF-8 is the recommended encoding here, 
since it is the default choice with Mac OS X developer tools.
 }

function CFSTR(const cStr: string): CFStringRef; inline; overload;
{$EXTERNALSYM CFSTR}
{$IFNDEF NEXTGEN}
function CFSTR(const cStr: AnsiString): CFStringRef; inline; overload;
{$EXTERNALSYM CFSTR}
function CFSTR(const cStr: UTF8String): CFStringRef; inline; overload;
{$EXTERNALSYM CFSTR}
{$ENDIF !NEXTGEN}

{ ** Immutable string creation functions ** }

{ Functions to create basic immutable strings. The provided allocator is used
  for all memory activity in these functions.
 }

{ The following four functions copy the provided buffer into CFString's internal storage. }
function CFStringCreateWithPascalString(alloc: CFAllocatorRef;
  pStr: ConstStr255Param; encoding: CFStringEncoding): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateWithPascalString';
{$EXTERNALSYM CFStringCreateWithPascalString}

function CFStringCreateWithCString(alloc: CFAllocatorRef; cStr: MarshaledAString;
  encoding: CFStringEncoding): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateWithCString';
{$EXTERNALSYM CFStringCreateWithCString}

{ The following takes an explicit length, and allows you to specify whether the data
  is an external format --- that is, whether to pay attention to the BOM character
  (if any) and do byte swapping if necessary
 }
function CFStringCreateWithBytes(alloc: CFAllocatorRef; bytes: PByte;
  numBytes: CFIndex; encoding: CFStringEncoding;
  isExternalRepresentation: Boolean): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateWithBytes';
{$EXTERNALSYM CFStringCreateWithBytes}

function CFStringCreateWithCharacters(alloc: CFAllocatorRef;
  chars: PUniChar; numChars: CFIndex): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateWithCharacters';
{$EXTERNALSYM CFStringCreateWithCharacters}


{ These functions try not to copy the provided buffer. The buffer will be deallocated 
with the provided contentsDeallocator when it's no longer needed; to not free
the buffer, specify kCFAllocatorNull here. As usual, NULL means default allocator.

NOTE: Do not count on these buffers as being used by the string; 
in some cases the CFString might free the buffer and use something else
(for instance if it decides to always use Unicode encoding internally). 

NOTE: If you are not transferring ownership of the buffer to the CFString
(for instance, you supplied contentsDeallocator = kCFAllocatorNull), it is your
responsibility to assure the buffer does not go away during the lifetime of the string.
If the string is retained or copied, its lifetime might extend in ways you cannot
predict. So, for strings created with buffers whose lifetimes you cannot
guarantee, you need to be extremely careful --- do not hand it out to any
APIs which might retain or copy the strings.
 }
function CFStringCreateWithPascalStringNoCopy(alloc: CFAllocatorRef; 
  pStr: ConstStr255Param; encoding: CFStringEncoding; 
  contentsDeallocator: CFAllocatorRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateWithPascalStringNoCopy';
{$EXTERNALSYM CFStringCreateWithPascalStringNoCopy}

function CFStringCreateWithCStringNoCopy(alloc: CFAllocatorRef;
  cStr: MarshaledAString; encoding: CFStringEncoding;
  contentsDeallocator: CFAllocatorRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateWithCStringNoCopy';
{$EXTERNALSYM CFStringCreateWithCStringNoCopy}

{ The following takes an explicit length, and allows you to specify whether the
  data is an external format --- that is, whether to pay attention to the
  BOM character (if any) and do byte swapping if necessary
 }
function CFStringCreateWithBytesNoCopy(alloc: CFAllocatorRef;
  bytes: PByte; numBytes: CFIndex; encoding: CFStringEncoding;
  isExternalRepresentation: Boolean; contentsDeallocator: CFAllocatorRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateWithBytesNoCopy';
{$EXTERNALSYM CFStringCreateWithBytesNoCopy}

function CFStringCreateWithCharactersNoCopy(alloc: CFAllocatorRef;
  chars: PUniChar; numChars: CFIndex; contentsDeallocator: CFAllocatorRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateWithCharactersNoCopy';
{$EXTERNALSYM CFStringCreateWithCharactersNoCopy}

{ Create copies of part or all of the string.
 }
function CFStringCreateWithSubstring(alloc: CFAllocatorRef; str: CFStringRef; 
  range: CFRange): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateWithSubstring';
{$EXTERNALSYM CFStringCreateWithSubstring}

function CFStringCreateCopy(alloc: CFAllocatorRef; theString: CFStringRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateCopy';
{$EXTERNALSYM CFStringCreateCopy}

{ These functions create a CFString from the provided printf-like format string and arguments.
 }
function CFStringCreateWithFormat(alloc: CFAllocatorRef;
  formatOptions: CFDictionaryRef; format: CFStringRef): CFStringRef; cdecl; varargs;
  external CoreFoundationLib name _PU + 'CFStringCreateWithFormat';
{$EXTERNALSYM CFStringCreateWithFormat}

function CFStringCreateWithFormatAndArguments(alloc: CFAllocatorRef;
  formatOptions: CFDictionaryRef; format: CFStringRef): CFStringRef; cdecl; varargs;
  external CoreFoundationLib name _PU + 'CFStringCreateWithFormatAndArguments';
{$EXTERNALSYM CFStringCreateWithFormatAndArguments}

{ Functions to create mutable strings. "maxLength", if not 0, is a hard bound
  on the length of the string. If 0, there is no limit on the length.
 }
function CFStringCreateMutable(alloc: CFAllocatorRef;
  maxLength: CFIndex): CFMutableStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateMutable';
{$EXTERNALSYM CFStringCreateMutable}

function CFStringCreateMutableCopy(alloc: CFAllocatorRef; maxLength: CFIndex;
  theString: CFStringRef): CFMutableStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateMutableCopy';
{$EXTERNALSYM CFStringCreateMutableCopy}

{ This function creates a mutable string that has a developer supplied and directly editable backing store.
The string will be manipulated within the provided buffer (if any) until it outgrows capacity; then the
externalCharactersAllocator will be consulted for more memory. When the CFString is deallocated, the
buffer will be freed with the externalCharactersAllocator. Provide kCFAllocatorNull here to prevent the buffer
from ever being reallocated or deallocated by CFString. See comments at top of this file for more info.
 }
function CFStringCreateMutableWithExternalCharactersNoCopy(
  alloc: CFAllocatorRef; chars: PUniChar; numChars: CFIndex; capacity: CFIndex;
  externalCharactersAllocator: CFAllocatorRef): CFMutableStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateMutableWithExternalCharactersNoCopy';
{$EXTERNALSYM CFStringCreateMutableWithExternalCharactersNoCopy}

{ ** Basic accessors for the contents ** }

{ Number of 16-bit Unicode characters in the string.
 }
function CFStringGetLength(theString: CFStringRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetLength';
{$EXTERNALSYM CFStringGetLength}

{ Extracting the contents of the string. For obtaining multiple characters, calling
CFStringGetCharacters() is more efficient than multiple calls to CFStringGetCharacterAtIndex().
If the length of the string is not known (so you can't use a fixed size buffer for CFStringGetCharacters()),
another method is to use is CFStringGetCharacterFromInlineBuffer() (see further below).
 }
function CFStringGetCharacterAtIndex(theString: CFStringRef;
  idx: CFIndex): UniChar; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetCharacterAtIndex';
{$EXTERNALSYM CFStringGetCharacterAtIndex}

procedure CFStringGetCharacters(theString: CFStringRef; range: CFRange;
  buffer: PUniChar); cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetCharacters';
{$EXTERNALSYM CFStringGetCharacters}


{ ** Conversion to other encodings ** }

{ These two convert into the provided buffer; they return false if conversion isn't possible
(due to conversion error, or not enough space in the provided buffer). 
These functions do zero-terminate or put the length byte; the provided bufferSize should include
space for this (so pass 256 for Str255). More sophisticated usages can go through CFStringGetBytes().
These functions are equivalent to calling CFStringGetBytes() with 
the range of the string; lossByte = 0; and isExternalRepresentation = false; 
if successful, they then insert the leading length or terminating zero, as desired.
 }
function CFStringGetPascalString(theString: CFStringRef; buffer: StringPtr;
  bufferSize: CFIndex; encoding: CFStringEncoding): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetPascalString';
{$EXTERNALSYM CFStringGetPascalString}

function CFStringGetCString(theString: CFStringRef; buffer: MarshaledAString;
  bufferSize: CFIndex; encoding: CFStringEncoding): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetCString';
{$EXTERNALSYM CFStringGetCString}

{ These functions attempt to return in O(1) time the desired format for the string.
Note that although this means a pointer to the internal structure is being returned,
this can't always be counted on. Please see note at the top of the file for more
details.
 }
function CFStringGetPascalStringPtr(theString: CFStringRef;
  encoding: CFStringEncoding): ConstStringPtr; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetPascalStringPtr';
{$EXTERNALSYM CFStringGetPascalStringPtr}
// May return NULL at any time; be prepared for NULL

function CFStringGetCStringPtr(theString: CFStringRef; encoding: CFStringEncoding): MarshaledAString; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetCStringPtr';
{$EXTERNALSYM CFStringGetCStringPtr}
// May return NULL at any time; be prepared for NULL

function CFStringGetCharactersPtr(theString: CFStringRef): PUniChar; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetCharactersPtr';
{$EXTERNALSYM CFStringGetCharactersPtr}
// May return NULL at any time; be prepared for NULL

{ The primitive conversion routine; allows you to convert a string piece at a time
       into a fixed size buffer. Returns number of characters converted. 
   Characters that cannot be converted to the specified encoding are represented
       with the byte specified by lossByte; if lossByte is 0, then lossy conversion
       is not allowed and conversion stops, returning partial results.
   Pass buffer==NULL if you don't care about the converted string (but just the convertability,
       or number of bytes required). 
   maxBufLength indicates the maximum number of bytes to generate. It is ignored when buffer==NULL.
   Does not zero-terminate. If you want to create Pascal or C string, allow one extra byte at start or end. 
   Setting isExternalRepresentation causes any extra bytes that would allow 
       the data to be made persistent to be included; for instance, the Unicode BOM. Note that
       CFString prepends UTF encoded data with the Unicode BOM <http://www.unicode.org/faq/utf_bom.html> 
       when generating external representation if the target encoding allows. It's important to note that
       only UTF-8, UTF-16, and UTF-32 define the handling of the byte order mark character, and the "LE"
       and "BE" variants of UTF-16 and UTF-32 don't.
 }
function CFStringGetBytes(theString: CFStringRef; range: CFRange; 
  encoding: CFStringEncoding; lossByte: UInt8; isExternalRepresentation: Boolean;
  buffer: PByte; maxBufLen: CFIndex; usedBufLen: PCFIndex): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetBytes';
{$EXTERNALSYM CFStringGetBytes}

{ Convenience functions String <-> Data. These generate "external" formats, that is, formats that
   can be written out to disk. For instance, if the encoding is Unicode,
   CFStringCreateFromExternalRepresentation() pays attention to the BOM character (if any)
   and does byte swapping if necessary. Similarly CFStringCreateExternalRepresentation() will
   include a BOM character if appropriate. See CFStringGetBytes() for more on this and lossByte.
 }
function CFStringCreateFromExternalRepresentation(alloc: CFAllocatorRef;
  data: CFDataRef; encoding: CFStringEncoding): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateFromExternalRepresentation';
{$EXTERNALSYM CFStringCreateFromExternalRepresentation}
// May return NULL on conversion error

function CFStringCreateExternalRepresentation(alloc: CFAllocatorRef;
  theString: CFStringRef; encoding: CFStringEncoding;
  lossByte: UInt8): CFDataRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateExternalRepresentation';
{$EXTERNALSYM CFStringCreateExternalRepresentation}
// May return NULL on conversion error

{ Hints about the contents of a string
 }
function CFStringGetSmallestEncoding(theString: CFStringRef): CFStringEncoding; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetSmallestEncoding';
{$EXTERNALSYM CFStringGetSmallestEncoding}

function CFStringGetFastestEncoding(theString: CFStringRef): CFStringEncoding; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetFastestEncoding';
{$EXTERNALSYM CFStringGetFastestEncoding}

{ General encoding info
 }
function CFStringGetSystemEncoding: CFStringEncoding; cdecl; { The default encoding for the system; untagged 8-bit characters are usually in this encoding }
  external CoreFoundationLib name _PU + 'CFStringGetSystemEncoding';
{$EXTERNALSYM CFStringGetSystemEncoding}

function CFStringGetMaximumSizeForEncoding(length: CFIndex; 
  encoding: CFStringEncoding): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetMaximumSizeForEncoding';
{$EXTERNALSYM CFStringGetMaximumSizeForEncoding}


{ ** FileSystem path conversion functions ** }

{ Extract the contents of the string as a NULL-terminated 8-bit string appropriate
  for passing to POSIX APIs (for example, normalized for HFS+).  The string is
  zero-terminated. false will be returned if the conversion results don't fit
  into the buffer.  Use CFStringGetMaximumSizeOfFileSystemRepresentation() if
  you want to make sure the buffer is of sufficient length.
 }
function CFStringGetFileSystemRepresentation(&string: CFStringRef; buffer: MarshaledAString;
  maxBufLen: CFIndex): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetFileSystemRepresentation';
{$EXTERNALSYM CFStringGetFileSystemRepresentation}

{ Get the upper bound on the number of bytes required to hold the file system
  representation for the string. This result is returned quickly as a very
  rough approximation, and could be much larger than the actual space required.
  The result includes space for the zero termination. If you are allocating a
  buffer for long-term keeping, it's recommended that you reallocate it smaller
  (to be the right size) after calling CFStringGetFileSystemRepresentation().
 }
function CFStringGetMaximumSizeOfFileSystemRepresentation(
  &string: CFStringRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetMaximumSizeOfFileSystemRepresentation';
{$EXTERNALSYM CFStringGetMaximumSizeOfFileSystemRepresentation}

{ Create a CFString from the specified zero-terminated POSIX file system
  representation.  If the conversion fails (possible due to bytes in the
  buffer not being a valid sequence of bytes for the appropriate character
  encoding), NULL is returned.
 }
function CFStringCreateWithFileSystemRepresentation(alloc: CFAllocatorRef;
  buffer: MarshaledAString): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateWithFileSystemRepresentation';
{$EXTERNALSYM CFStringCreateWithFileSystemRepresentation}


{ ** Comparison functions. ** }

{ Find and compare flags; these are OR'ed together and provided as
  CFStringCompareFlags in the various functions.
 }
const
  kCFCompareCaseInsensitive      = 1;
  {$EXTERNALSYM kCFCompareCaseInsensitive}
  kCFCompareBackwards            = 4; { Starting from the end of the string }
  {$EXTERNALSYM kCFCompareBackwards}
  kCFCompareAnchored             = 8; { Only at the specified starting point }
  {$EXTERNALSYM kCFCompareAnchored}
  kCFCompareNonliteral           = 16; { If specified, loose equivalence is performed (o-umlaut == o, umlaut) }
  {$EXTERNALSYM kCFCompareNonliteral}
  kCFCompareLocalized            = 32; { User's default locale is used for the comparisons }
  {$EXTERNALSYM kCFCompareLocalized}
  kCFCompareNumerically          = 64; { Numeric comparison is used; that is, Foo2.txt < Foo7.txt < Foo25.txt }
  {$EXTERNALSYM kCFCompareNumerically}
  kCFCompareDiacriticInsensitive = 128;   { If specified, ignores diacritics (o-umlaut == o) }
  {$EXTERNALSYM kCFCompareDiacriticInsensitive}
  kCFCompareWidthInsensitive     = 256; { If specified, ignores width differences ('a' == UFF41) }
  {$EXTERNALSYM kCFCompareWidthInsensitive}
  kCFCompareForcedOrdering       = 512; { If specified, comparisons are forced to return either kCFCompareLessThan or kCFCompareGreaterThan if the strings are equivalent but not strictly equal, for stability when sorting (e.g. "aaa" > "AAA" with kCFCompareCaseInsensitive specified) }
  {$EXTERNALSYM kCFCompareForcedOrdering}
type
  CFStringCompareFlags = CFOptionFlags; 
  {$EXTERNALSYM CFStringCompareFlags}

{ The main comparison routine; compares specified range of the first string to (the full range of) the second string.
locale == NULL indicates canonical locale (the return value from CFLocaleGetSystem()).
kCFCompareNumerically, added in 10.2, does not work if kCFCompareLocalized is specified on systems before 10.3
kCFCompareBackwards and kCFCompareAnchored are not applicable.
 }
function CFStringCompareWithOptionsAndLocale(theString1: CFStringRef;
  theString2: CFStringRef; rangeToCompare: CFRange;
  compareOptions: CFStringCompareFlags; locale: CFLocaleRef): CFComparisonResult; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCompareWithOptionsAndLocale';
{$EXTERNALSYM CFStringCompareWithOptionsAndLocale}

{ Comparison convenience. Uses the current user locale (the return value from CFLocaleCopyCurrent()) if kCFCompareLocalized.
 }
function CFStringCompareWithOptions(theString1: CFStringRef;
  theString2: CFStringRef; rangeToCompare: CFRange;
  compareOptions: CFStringCompareFlags): CFComparisonResult; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCompareWithOptions';
{$EXTERNALSYM CFStringCompareWithOptions}

{ Comparison convenience suitable for passing as sorting functions.
   kCFCompareNumerically, added in 10.2, does not work if kCFCompareLocalized is specified on systems before 10.3
   kCFCompareBackwards and kCFCompareAnchored are not applicable.
 }
function CFStringCompare(theString1: CFStringRef; theString2: CFStringRef;
  compareOptions: CFStringCompareFlags): CFComparisonResult; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCompare';
{$EXTERNALSYM CFStringCompare}

{ CFStringFindWithOptionsAndLocale() returns the found range in the CFRange * argument; you can pass NULL for simple discovery check.
 locale == NULL indicates canonical locale (the return value from CFLocaleGetSystem()).
 If stringToFind is the empty string (zero length), nothing is found.
 Ignores the kCFCompareNumerically option.
 }
function CFStringFindWithOptionsAndLocale(theString: CFStringRef;
  stringToFind: CFStringRef; rangeToSearch: CFRange;
  searchOptions: CFStringCompareFlags; locale: CFLocaleRef;
  result: PCFRange): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFStringFindWithOptionsAndLocale';
{$EXTERNALSYM CFStringFindWithOptionsAndLocale}

{ Find convenience. Uses the current user locale (the return value from CFLocaleCopyCurrent()) if kCFCompareLocalized.
 }
function CFStringFindWithOptions(theString: CFStringRef;
  stringToFind: CFStringRef; rangeToSearch: CFRange;
  searchOptions: CFStringCompareFlags; result: PCFRange): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFStringFindWithOptions';
{$EXTERNALSYM CFStringFindWithOptions}

{ CFStringCreateArrayWithFindResults() returns an array of CFRange pointers, or NULL if there are no matches.
   Overlapping instances are not found; so looking for "AA" in "AAA" finds just one range.
   Post 10.1: If kCFCompareBackwards is provided, the scan is done from the end (which can give a different result), and
      the results are stored in the array backwards (last found range in slot 0).
   If stringToFind is the empty string (zero length), nothing is found.
   kCFCompareAnchored causes just the consecutive instances at start (or end, if kCFCompareBackwards) to be reported. So, searching for "AB" in "ABABXAB..." you just get the first two occurrences.
   Ignores the kCFCompareNumerically option.
 }
function CFStringCreateArrayWithFindResults(alloc: CFAllocatorRef;
  theString: CFStringRef; stringToFind: CFStringRef; rangeToSearch: CFRange;
  compareOptions: CFStringCompareFlags): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateArrayWithFindResults';
{$EXTERNALSYM CFStringCreateArrayWithFindResults}

{ Find conveniences; see comments above concerning empty string and options.
 }
function CFStringFind(theString: CFStringRef; stringToFind: CFStringRef;
  compareOptions: CFStringCompareFlags): CFRange; cdecl;
  external CoreFoundationLib name _PU + 'CFStringFind';
{$EXTERNALSYM CFStringFind}

function CFStringHasPrefix(theString: CFStringRef;
  prefix: CFStringRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFStringHasPrefix';
{$EXTERNALSYM CFStringHasPrefix}

function CFStringHasSuffix(theString: CFStringRef;
  suffix: CFStringRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFStringHasSuffix';
{$EXTERNALSYM CFStringHasSuffix}

{ !
	@function CFStringGetRangeOfComposedCharactersAtIndex
	Returns the range of the composed character sequence at the specified index.
	@param theString The CFString which is to be searched.  If this
                		parameter is not a valid CFString, the behavior is
              		undefined.
	@param theIndex The index of the character contained in the
			composed character sequence.  If the index is
			outside the index space of the string (0 to N-1 inclusive,
			where N is the length of the string), the behavior is
			undefined.
	@result The range of the composed character sequence.
 }
function CFStringGetRangeOfComposedCharactersAtIndex(theString: CFStringRef;
  theIndex: CFIndex): CFRange; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetRangeOfComposedCharactersAtIndex';
{$EXTERNALSYM CFStringGetRangeOfComposedCharactersAtIndex}

{ !
	@function CFStringFindCharacterFromSet
	Query the range of the first character contained in the specified character set.
	@param theString The CFString which is to be searched.  If this
                		parameter is not a valid CFString, the behavior is
              		undefined.
	@param theSet The CFCharacterSet against which the membership
			of characters is checked.  If this parameter is not a valid
			CFCharacterSet, the behavior is undefined.
	@param range The range of characters within the string to search. If
			the range location or end point (defined by the location
			plus length minus 1) are outside the index space of the
			string (0 to N-1 inclusive, where N is the length of the
			string), the behavior is undefined. If the range length is
			negative, the behavior is undefined. The range may be empty
			(length 0), in which case no search is performed.
	@param searchOptions The bitwise-or'ed option flags to control
			the search behavior.  The supported options are
			kCFCompareBackwards andkCFCompareAnchored.
			If other option flags are specified, the behavior
                        is undefined.
	@param result The pointer to a CFRange supplied by the caller in
			which the search result is stored.  Note that the length
			of this range can be more than 1, if for instance the 
			result is a composed character. If a pointer to an invalid
			memory is specified, the behavior is undefined.
	@result true, if at least a character which is a member of the character
			set is found and result is filled, otherwise, false.
 }
function CFStringFindCharacterFromSet(theString: CFStringRef;
  theSet: CFCharacterSetRef; rangeToSearch: CFRange;
  searchOptions: CFStringCompareFlags; result: PCFRange): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFStringFindCharacterFromSet';
{$EXTERNALSYM CFStringFindCharacterFromSet}

{ Find range of bounds of the line(s) that span the indicated range (startIndex, numChars),
   taking into account various possible line separator sequences (CR, CRLF, LF, and Unicode NextLine, LineSeparator, ParagraphSeparator).
   All return values are "optional" (provide NULL if you don't want them)
     lineBeginIndex: index of first character in line
     lineEndIndex: index of first character of the next line (including terminating line separator characters)
     contentsEndIndex: index of the first line separator character
   Thus, lineEndIndex - lineBeginIndex is the number of chars in the line, including the line separators
         contentsEndIndex - lineBeginIndex is the number of chars in the line w/out the line separators
 }
procedure CFStringGetLineBounds(theString: CFStringRef; range: CFRange;
  lineBeginIndex: PCFIndex; lineEndIndex: PCFIndex;
  contentsEndIndex: PCFIndex); cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetLineBounds';
{$EXTERNALSYM CFStringGetLineBounds}

{ Same as CFStringGetLineBounds(), however, will only look for paragraphs. Won't stop at Unicode NextLine or LineSeparator characters.
 }
procedure CFStringGetParagraphBounds(&string: CFStringRef; range: CFRange;
  parBeginIndex: PCFIndex; parEndIndex: PCFIndex; contentsEndIndex: PCFIndex); cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetParagraphBounds';
{$EXTERNALSYM CFStringGetParagraphBounds}

{ ** Exploding and joining strings with a separator string ** }

function CFStringCreateByCombiningStrings(alloc: CFAllocatorRef;
  theArray: CFArrayRef; separatorString: CFStringRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateByCombiningStrings';
{$EXTERNALSYM CFStringCreateByCombiningStrings}
// Empty array returns empty string; one element array returns the element

function CFStringCreateArrayBySeparatingStrings(alloc: CFAllocatorRef;
  theString: CFStringRef; separatorString: CFStringRef): CFArrayRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringCreateArrayBySeparatingStrings';
{$EXTERNALSYM CFStringCreateArrayBySeparatingStrings}
// No separators in the string returns array with that string; string == sep returns two empty strings

{ ** Parsing non-localized numbers from strings ** }

function CFStringGetIntValue(str: CFStringRef): SInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetIntValue';
{$EXTERNALSYM CFStringGetIntValue}

function CFStringGetDoubleValue(str: CFStringRef): Double; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetDoubleValue';
{$EXTERNALSYM CFStringGetDoubleValue}


{ ** MutableString functions ** }

{ CFStringAppend("abcdef", "xxxxx") -> "abcdefxxxxx"
   CFStringDelete("abcdef", CFRangeMake(2, 3)) -> "abf"
   CFStringReplace("abcdef", CFRangeMake(2, 3), "xxxxx") -> "abxxxxxf"
   CFStringReplaceAll("abcdef", "xxxxx") -> "xxxxx"
 }
procedure CFStringAppend(theString: CFMutableStringRef; 
  appendedString: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFStringAppend';
{$EXTERNALSYM CFStringAppend}

procedure CFStringAppendCharacters(theString: CFMutableStringRef; 
  chars: PUniChar; numChars: CFIndex); cdecl;
  external CoreFoundationLib name _PU + 'CFStringAppendCharacters';
{$EXTERNALSYM CFStringAppendCharacters}

procedure CFStringAppendPascalString(theString: CFMutableStringRef;
  pStr: ConstStr255Param; encoding: CFStringEncoding); cdecl;
  external CoreFoundationLib name _PU + 'CFStringAppendPascalString';
{$EXTERNALSYM CFStringAppendPascalString}

procedure CFStringAppendCString(theString: CFMutableStringRef;
  cStr: MarshaledAString; encoding: CFStringEncoding); cdecl;
  external CoreFoundationLib name _PU + 'CFStringAppendCString';
{$EXTERNALSYM CFStringAppendCString}

procedure CFStringAppendFormat(theString: CFMutableStringRef;
  formatOptions: CFDictionaryRef; format: CFStringRef); cdecl; varargs;
  external CoreFoundationLib name _PU + 'CFStringAppendFormat';
{$EXTERNALSYM CFStringAppendFormat}

procedure CFStringAppendFormatAndArguments(theString: CFMutableStringRef;
  formatOptions: CFDictionaryRef; format: CFStringRef); cdecl; varargs;
  external CoreFoundationLib name _PU + 'CFStringAppendFormatAndArguments';
{$EXTERNALSYM CFStringAppendFormatAndArguments}

procedure CFStringInsert(str: CFMutableStringRef; idx: CFIndex; 
  insertedStr: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFStringInsert';
{$EXTERNALSYM CFStringInsert}

procedure CFStringDelete(theString: CFMutableStringRef; range: CFRange); cdecl;
  external CoreFoundationLib name _PU + 'CFStringDelete';
{$EXTERNALSYM CFStringDelete}

procedure CFStringReplace(theString: CFMutableStringRef; range: CFRange; 
  replacement: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFStringReplace';
{$EXTERNALSYM CFStringReplace}

procedure CFStringReplaceAll(theString: CFMutableStringRef; 
  replacement: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFStringReplaceAll';
{$EXTERNALSYM CFStringReplaceAll}

{ Replace all occurrences of target in rangeToSearch of theString with replacement.
   Pays attention to kCFCompareCaseInsensitive, kCFCompareBackwards, kCFCompareNonliteral, and kCFCompareAnchored.
   kCFCompareBackwards can be used to do the replacement starting from the end, which could give a different result.
     ex. AAAAA, replace AA with B -> BBA or ABB; latter if kCFCompareBackwards
   kCFCompareAnchored assures only anchored but multiple instances are found (the instances must be consecutive at start or end)
     ex. AAXAA, replace A with B -> BBXBB or BBXAA; latter if kCFCompareAnchored
   Returns number of replacements performed.
 }
function CFStringFindAndReplace(theString: CFMutableStringRef;
  stringToFind: CFStringRef; replacementString: CFStringRef;
  rangeToSearch: CFRange; compareOptions: CFStringCompareFlags): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFStringFindAndReplace';
{$EXTERNALSYM CFStringFindAndReplace}

{ This function will make the contents of a mutable CFString point directly at the specified UniChar array.
   It works only with CFStrings created with CFStringCreateMutableWithExternalCharactersNoCopy().
   This function does not free the previous buffer.
   The string will be manipulated within the provided buffer (if any) until it outgrows capacity; then the
     externalCharactersAllocator will be consulted for more memory.
   See comments at the top of this file for more info.
 }
procedure CFStringSetExternalCharactersNoCopy(theString: CFMutableStringRef;
  chars: PUniChar; length: CFIndex; capacity: CFIndex); cdecl;
  external CoreFoundationLib name _PU + 'CFStringSetExternalCharactersNoCopy';
{$EXTERNALSYM CFStringSetExternalCharactersNoCopy}

{ CFStringPad() will pad or cut down a string to the specified size.
   The pad string is used as the fill string; indexIntoPad specifies which character to start with.
     CFStringPad("abc", " ", 9, 0) ->  "abc      "
     CFStringPad("abc", ". ", 9, 1) -> "abc . . ."
     CFStringPad("abcdef", ?, 3, ?) -> "abc"

     CFStringTrim() will trim the specified string from both ends of the string.
     CFStringTrimWhitespace() will do the same with white space characters (tab, newline, etc)
     CFStringTrim("  abc ", " ") -> "abc"
     CFStringTrim("* * * *abc * ", "* ") -> "*abc "
 }
procedure CFStringPad(theString: CFMutableStringRef; padString: CFStringRef; 
  length: CFIndex; indexIntoPad: CFIndex); cdecl;
  external CoreFoundationLib name _PU + 'CFStringPad';
{$EXTERNALSYM CFStringPad}

procedure CFStringTrim(theString: CFMutableStringRef; 
  trimString: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFStringTrim';
{$EXTERNALSYM CFStringTrim}

procedure CFStringTrimWhitespace(theString: CFMutableStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFStringTrimWhitespace';
{$EXTERNALSYM CFStringTrimWhitespace}

procedure CFStringLowercase(theString: CFMutableStringRef; locale: CFLocaleRef); cdecl;
  external CoreFoundationLib name _PU + 'CFStringLowercase';
{$EXTERNALSYM CFStringLowercase}

procedure CFStringUppercase(theString: CFMutableStringRef; locale: CFLocaleRef); cdecl;
  external CoreFoundationLib name _PU + 'CFStringUppercase';
{$EXTERNALSYM CFStringUppercase}

procedure CFStringCapitalize(theString: CFMutableStringRef; locale: CFLocaleRef); cdecl;
  external CoreFoundationLib name _PU + 'CFStringCapitalize';
{$EXTERNALSYM CFStringCapitalize}

{ !
	@typedef CFStringNormalizationForm
	This is the type of Unicode normalization forms as described in
	Unicode Technical Report #15. To normalize for use with file
	system calls, use CFStringGetFileSystemRepresentation().
 }
const
  kCFStringNormalizationFormD  = 0; // Canonical Decomposition
  {$EXTERNALSYM kCFStringNormalizationFormD}
  kCFStringNormalizationFormKD = 1; // Compatibility Decomposition
  {$EXTERNALSYM kCFStringNormalizationFormKD}
  kCFStringNormalizationFormC  = 2; // Canonical Decomposition followed by Canonical Composition
  {$EXTERNALSYM kCFStringNormalizationFormC}
  kCFStringNormalizationFormKC = 3; // Compatibility Decomposition followed by Canonical Composition
  {$EXTERNALSYM kCFStringNormalizationFormKC}
type
  CFStringNormalizationForm = CFIndex;
  {$EXTERNALSYM CFStringNormalizationForm}

{ !
	@function CFStringNormalize
	Normalizes the string into the specified form as described in
	Unicode Technical Report #15.
	@param theString  The string which is to be normalized.  If this
		parameter is not a valid mutable CFString, the behavior is
		undefined.
	@param theForm  The form into which the string is to be normalized.
		If this parameter is not a valid CFStringNormalizationForm value,
		the behavior is undefined.
 }
procedure CFStringNormalize(theString: CFMutableStringRef;
  theForm: CFStringNormalizationForm); cdecl;
  external CoreFoundationLib name _PU + 'CFStringNormalize';
{$EXTERNALSYM CFStringNormalize}

{ !
	@function CFStringFold
	Folds the string into the form specified by the flags.
		Character foldings are operations that convert any of a set of characters
		sharing similar semantics into a single representative from that set.
		This function can be used to preprocess strings that are to be compared,
		searched, or indexed.
		Note that folding does not include normalization, so it is necessary
		to use CFStringNormalize in addition to CFStringFold in order to obtain
		the effect of kCFCompareNonliteral.
	@param theString  The string which is to be folded.  If this parameter is not
		a valid mutable CFString, the behavior is undefined.
	@param theFlag  The equivalency flags which describes the character folding form.
		Only those flags containing the word "insensitive" are recognized here; other flags are ignored.		
		Folding with kCFCompareCaseInsensitive removes case distinctions in accordance with the mapping
		specified by ftp://ftp.unicode.org/Public/UNIDATA/CaseFolding.txt.  Folding with
		kCFCompareDiacriticInsensitive removes distinctions of accents and other diacritics.  Folding
		with kCFCompareWidthInsensitive removes character width distinctions by mapping characters in
		the range U+FF00-U+FFEF to their ordinary equivalents.
	@param theLocale The locale tailoring the character folding behavior. If NULL,
		it's considered to be the system locale returned from CFLocaleGetSystem().
		If non-NULL and not a valid CFLocale object, the behavior is undefined.
 }

procedure CFStringFold(theString: CFMutableStringRef; theFlags: CFOptionFlags; 
  theLocale: CFLocaleRef); cdecl;
  external CoreFoundationLib name _PU + 'CFStringFold';
{$EXTERNALSYM CFStringFold}

{ Perform string transliteration.  The transformation represented by transform is applied
  to the given range of string, modifying it in place. Only the specified range will be
  modified, but the transform may look at portions of the string outside that range for
  context. NULL range pointer causes the whole string to be transformed. On return,
  range is modified to reflect the new range corresponding to the original range.
  reverse indicates that the inverse transform should be used instead, if it exists.
  If the transform is successful, true is returned; if unsuccessful, false. Reasons
  for the transform being unsuccessful include an invalid transform identifier, or
  attempting to reverse an irreversible transform.

  You can pass one of the predefined transforms below, or any valid ICU transform
  ID as defined in the ICU User Guide. Note that we do not support arbitrary set
  of ICU transform rules.
 }
function CFStringTransform(&string: CFMutableStringRef; range: PCFRange;
  transform: CFStringRef; reverse: Boolean): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFStringTransform';
{$EXTERNALSYM CFStringTransform}

{ Transform identifiers for CFStringTransform()
 }
function kCFStringTransformStripCombiningMarks: CFStringRef;
{$EXTERNALSYM kCFStringTransformStripCombiningMarks}
function kCFStringTransformToLatin: CFStringRef;
{$EXTERNALSYM kCFStringTransformToLatin}
function kCFStringTransformFullwidthHalfwidth: CFStringRef;
{$EXTERNALSYM kCFStringTransformFullwidthHalfwidth}
function kCFStringTransformLatinKatakana: CFStringRef;
{$EXTERNALSYM kCFStringTransformLatinKatakana}
function kCFStringTransformLatinHiragana: CFStringRef;
{$EXTERNALSYM kCFStringTransformLatinHiragana}
function kCFStringTransformHiraganaKatakana: CFStringRef;
{$EXTERNALSYM kCFStringTransformHiraganaKatakana}
function kCFStringTransformMandarinLatin: CFStringRef;
{$EXTERNALSYM kCFStringTransformMandarinLatin}
function kCFStringTransformLatinHangul: CFStringRef;
{$EXTERNALSYM kCFStringTransformLatinHangul}
function kCFStringTransformLatinArabic: CFStringRef;
{$EXTERNALSYM kCFStringTransformLatinArabic}
function kCFStringTransformLatinHebrew: CFStringRef;
{$EXTERNALSYM kCFStringTransformLatinHebrew}
function kCFStringTransformLatinThai: CFStringRef;
{$EXTERNALSYM kCFStringTransformLatinThai}
function kCFStringTransformLatinCyrillic: CFStringRef;
{$EXTERNALSYM kCFStringTransformLatinCyrillic}
function kCFStringTransformLatinGreek: CFStringRef;
{$EXTERNALSYM kCFStringTransformLatinGreek}
function kCFStringTransformToXMLHex: CFStringRef;
{$EXTERNALSYM kCFStringTransformToXMLHex}
function kCFStringTransformToUnicodeName: CFStringRef;
{$EXTERNALSYM kCFStringTransformToUnicodeName}
function kCFStringTransformStripDiacritics: CFStringRef;
{$EXTERNALSYM kCFStringTransformStripDiacritics}


{ ** General encoding related functionality ** }

{ This returns availability of the encoding on the system
 }
function CFStringIsEncodingAvailable(encoding: CFStringEncoding): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFStringIsEncodingAvailable';
{$EXTERNALSYM CFStringIsEncodingAvailable}

{ This function returns list of available encodings.  The returned list is terminated with kCFStringEncodingInvalidId and owned by the system.
 }
function CFStringGetListOfAvailableEncodings: PCFStringEncoding; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetListOfAvailableEncodings';
{$EXTERNALSYM CFStringGetListOfAvailableEncodings}

{ Returns name of the encoding; non-localized.
 }
function CFStringGetNameOfEncoding(encoding: CFStringEncoding): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetNameOfEncoding';
{$EXTERNALSYM CFStringGetNameOfEncoding}

{ ID mapping functions from/to Cocoa NSStringEncoding.  Returns kCFStringEncodingInvalidId if no mapping exists.
 }
function CFStringConvertEncodingToNSStringEncoding(
  encoding: CFStringEncoding): LongWord; cdecl;
  external CoreFoundationLib name _PU + 'CFStringConvertEncodingToNSStringEncoding';
{$EXTERNALSYM CFStringConvertEncodingToNSStringEncoding}

function CFStringConvertNSStringEncodingToEncoding(
  encoding: LongWord): CFStringEncoding; cdecl;
  external CoreFoundationLib name _PU + 'CFStringConvertNSStringEncodingToEncoding';
{$EXTERNALSYM CFStringConvertNSStringEncodingToEncoding}

{ ID mapping functions from/to Microsoft Windows codepage (covers both OEM & ANSI).  Returns kCFStringEncodingInvalidId if no mapping exists.
 }
function CFStringConvertEncodingToWindowsCodepage(
  encoding: CFStringEncoding): UInt32; cdecl;
  external CoreFoundationLib name _PU + 'CFStringConvertEncodingToWindowsCodepage';
{$EXTERNALSYM CFStringConvertEncodingToWindowsCodepage}

function CFStringConvertWindowsCodepageToEncoding(
  codepage: UInt32): CFStringEncoding; cdecl;
  external CoreFoundationLib name _PU + 'CFStringConvertWindowsCodepageToEncoding';
{$EXTERNALSYM CFStringConvertWindowsCodepageToEncoding}

{ ID mapping functions from/to IANA registery charset names.  Returns kCFStringEncodingInvalidId if no mapping exists.
 }
function CFStringConvertIANACharSetNameToEncoding(
  theString: CFStringRef): CFStringEncoding; cdecl;
  external CoreFoundationLib name _PU + 'CFStringConvertIANACharSetNameToEncoding';
{$EXTERNALSYM CFStringConvertIANACharSetNameToEncoding}

function CFStringConvertEncodingToIANACharSetName(
  encoding: CFStringEncoding): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFStringConvertEncodingToIANACharSetName';
{$EXTERNALSYM CFStringConvertEncodingToIANACharSetName}

{ Returns the most compatible MacOS script value for the input encoding }
{ i.e. kCFStringEncodingMacRoman -> kCFStringEncodingMacRoman }
{ 	kCFStringEncodingWindowsLatin1 -> kCFStringEncodingMacRoman }
{ 	kCFStringEncodingISO_2022_JP -> kCFStringEncodingMacJapanese }
function CFStringGetMostCompatibleMacStringEncoding(
  encoding: CFStringEncoding): CFStringEncoding; cdecl;
  external CoreFoundationLib name _PU + 'CFStringGetMostCompatibleMacStringEncoding';
{$EXTERNALSYM CFStringGetMostCompatibleMacStringEncoding}



{ The next two functions allow fast access to the contents of a string, 
   assuming you are doing sequential or localized accesses. To use, call
   CFStringInitInlineBuffer() with a CFStringInlineBuffer (on the stack, say),
   and a range in the string to look at. Then call CFStringGetCharacterFromInlineBuffer()
   as many times as you want, with a index into that range (relative to the start
   of that range). These are INLINE functions and will end up calling CFString only 
   once in a while, to fill a buffer.  CFStringGetCharacterFromInlineBuffer() returns 0 if
   a location outside the original range is specified.
 }
const
  __kCFStringInlineBufferLength = 64;
  {$EXTERNALSYM __kCFStringInlineBufferLength}
type
  PCFStringInlineBuffer = ^CFStringInlineBuffer;
  CFStringInlineBuffer = record
    buffer: packed array[0..__kCFStringInlineBufferLength-1] of UniChar;
    theString: CFStringRef;
    directBuffer: PUniChar;
    rangeToBuffer: CFRange; { Range in string to buffer }
    bufferedRangeStart: CFIndex; { Start of range currently buffered (relative to rangeToBuffer.location) }
    bufferedRangeEnd: CFIndex; { bufferedRangeStart + number of chars actually buffered }
  end;
  {$EXTERNALSYM CFStringInlineBuffer}

procedure CFStringInitInlineBuffer(str: CFStringRef; buf: PCFStringInlineBuffer; range: CFRange); inline;

function CFStringGetCharacterFromInlineBuffer(buf: PCFStringInlineBuffer; idx: CFIndex): UniChar;


{ UTF-16 surrogate support }

function CFStringIsSurrogateHighCharacter(character: UniChar): Boolean; inline;

function CFStringIsSurrogateLowCharacter(character: UniChar): Boolean; inline;

function CFStringGetLongCharacterForSurrogatePair(surrogateHigh: UniChar;
  surrogateLow: UniChar): UTF32Char; inline;

// Maps a UTF-32 character to a pair of UTF-16 surrogate characters.
//  The buffer pointed by surrogates has to have space for at least 2 UTF-16
//  characters. Returns true if mapped to a surrogate pair.
function CFStringGetSurrogatePairForLongCharacter(character: UTF32Char;
  surrogates: PUniChar): Boolean;

{ Rest of the stuff in this file is private and should not be used directly
 }
{ For debugging only; output goes to stderr
   Use CFShow() to printf the description of any CFType;
   Use CFShowStr() to printf detailed info about a CFString
 }
procedure CFShow(obj: CFTypeRef); cdecl;
  external CoreFoundationLib name _PU + 'CFShow';
{$EXTERNALSYM CFShow}

procedure CFShowStr(str: CFStringRef); cdecl;
  external CoreFoundationLib name _PU + 'CFShowStr';
{$EXTERNALSYM CFShowStr}

{ This function is private and should not be used directly }
function __CFStringMakeConstantString(cStr: MarshaledAString): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + '__CFStringMakeConstantString';
{$EXTERNALSYM __CFStringMakeConstantString}

{$ENDIF !__COREFOUNDATION_CFSTRING__}


