{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFBase.h                               }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IF NOT DEFINED (__COREFOUNDATION_CFBASE__)}

{$DEFINE __COREFOUNDATION_CFBASE__}

{$IF NOT DECLARED(_PU)}
const
  {$IFDEF UNDERSCOREIMPORTNAME}
  _PU = '_';
  {$ELSE}
  _PU = '';
  {$ENDIF}
  {$EXTERNALSYM _PU}
{$ENDIF}

type
  UInt8 = Byte;
  {$EXTERNALSYM UInt8}
  SInt8 = ShortInt;
  {$EXTERNALSYM SInt8}
  UInt16 = Word;
  {$EXTERNALSYM UInt16}
  SInt16 = SmallInt;
  {$EXTERNALSYM SInt16}
  UInt32 = LongWord;
  {$EXTERNALSYM UInt32}
  SInt32 = Integer;
  {$EXTERNALSYM SInt32}
  SInt64 = Int64;
  {$EXTERNALSYM SInt64}
  OSStatus = SInt32;
  {$EXTERNALSYM OSStatus}

  Float32 = Single;  // ???
  {$EXTERNALSYM Float32}
  Float64 = Double;
  {$EXTERNALSYM Float64}
  UniChar = WideChar;
  {$EXTERNALSYM UniChar}
  UniCharCount = LongWord;
  {$EXTERNALSYM UniCharCount}
  StringPtr = PByte;
  {$EXTERNALSYM StringPtr}
  ConstStringPtr = PByte;
  {$EXTERNALSYM ConstStringPtr}
  Str255 = packed array[0..255] of Byte;
  {$EXTERNALSYM Str255}
  ConstStr255Param = PByte;
  {$EXTERNALSYM ConstStr255Param}
  OSErr = SInt16;
  {$EXTERNALSYM OSErr}
  RegionCode = SInt16;
  {$EXTERNALSYM RegionCode}
  LangCode = SInt16;
  {$EXTERNALSYM LangCode}
  ScriptCode = SInt16;
  {$EXTERNALSYM ScriptCode}
  FourCharCode = UInt32;
  {$EXTERNALSYM FourCharCode}
  POSType = ^OSType;
  OSType = FourCharCode;
  {$EXTERNALSYM OSType}
  SignedByte = SInt8;
  {$EXTERNALSYM SignedByte}

  UTF32Char = UInt32;
  {$EXTERNALSYM UTF32Char}
  UTF16Char = WideChar;
  {$EXTERNALSYM UTF16Char}
{$IFNDEF NEXTGEN}
  UTF8Char = AnsiChar;
  {$EXTERNALSYM UTF8Char}
{$ENDIF !NEXTGEN}

  PUInt32 = ^UInt32;
  PUniChar = PWideChar;
  PUTF32Char = ^UTF32Char;

  function kCFCoreFoundationVersionNumber: Double;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber}

const
  kCFCoreFoundationVersionNumber10_0 = 196.40;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_0}
  kCFCoreFoundationVersionNumber10_0_3 = 196.50;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_0_3}
  kCFCoreFoundationVersionNumber10_1 = 226.00;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_1}
  kCFCoreFoundationVersionNumber10_1_1 = 226.00;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_1_1}
  // Note the next three do not follow the usual numbering policy from the base release
  kCFCoreFoundationVersionNumber10_1_2 = 227.20;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_1_2}
  kCFCoreFoundationVersionNumber10_1_3 = 227.20;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_1_3}
  kCFCoreFoundationVersionNumber10_1_4 = 227.30;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_1_4}
  kCFCoreFoundationVersionNumber10_2 = 263.00;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_2}
  kCFCoreFoundationVersionNumber10_2_1 = 263.10;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_2_1}
  kCFCoreFoundationVersionNumber10_2_2 = 263.10;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_2_2}
  kCFCoreFoundationVersionNumber10_2_3 = 263.30;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_2_3}
  kCFCoreFoundationVersionNumber10_2_4 = 263.30;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_2_4}
  kCFCoreFoundationVersionNumber10_2_5 = 263.50;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_2_5}
  kCFCoreFoundationVersionNumber10_2_6 = 263.50;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_2_6}
  kCFCoreFoundationVersionNumber10_2_7 = 263.50;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_2_7}
  kCFCoreFoundationVersionNumber10_2_8 = 263.50;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_2_8}
  kCFCoreFoundationVersionNumber10_3 = 299.00;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_3}
  kCFCoreFoundationVersionNumber10_3_1 = 299.00;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_3_1}
  kCFCoreFoundationVersionNumber10_3_2 = 299.00;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_3_2}
  kCFCoreFoundationVersionNumber10_3_3 = 299.30;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_3_3}
  kCFCoreFoundationVersionNumber10_3_4 = 299.31;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_3_4}
  kCFCoreFoundationVersionNumber10_3_5 = 299.31;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_3_5}
  kCFCoreFoundationVersionNumber10_3_6 = 299.32;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_3_6}
  kCFCoreFoundationVersionNumber10_3_7 = 299.33;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_3_7}
  kCFCoreFoundationVersionNumber10_3_8 = 299.33;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_3_8}
  kCFCoreFoundationVersionNumber10_3_9 = 299.35;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_3_9}
  kCFCoreFoundationVersionNumber10_4 = 368.00;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_4}
  kCFCoreFoundationVersionNumber10_4_1 = 368.10;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_4_1}
  kCFCoreFoundationVersionNumber10_4_2 = 368.11;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_4_2}
  kCFCoreFoundationVersionNumber10_4_3 = 368.18;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_4_3}
  kCFCoreFoundationVersionNumber10_4_4_Intel = 368.26;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_4_4_Intel}
  kCFCoreFoundationVersionNumber10_4_4_PowerPC = 368.25;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_4_4_PowerPC}
  kCFCoreFoundationVersionNumber10_4_5_Intel = 368.26;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_4_5_Intel}
  kCFCoreFoundationVersionNumber10_4_5_PowerPC = 368.25;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_4_5_PowerPC}
  kCFCoreFoundationVersionNumber10_4_6_Intel = 368.26;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_4_6_Intel}
  kCFCoreFoundationVersionNumber10_4_6_PowerPC = 368.25;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_4_6_PowerPC}
  kCFCoreFoundationVersionNumber10_4_7 = 368.27;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_4_7}
  kCFCoreFoundationVersionNumber10_4_8 = 368.27;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_4_8}
  kCFCoreFoundationVersionNumber10_4_9 = 368.28;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_4_9}
  kCFCoreFoundationVersionNumber10_4_10 = 368.28;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_4_10}
  kCFCoreFoundationVersionNumber10_4_11 = 368.31;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_4_11}
  kCFCoreFoundationVersionNumber10_5 = 476.00;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_5}
  kCFCoreFoundationVersionNumber10_5_1 = 476.00;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_5_1}
  kCFCoreFoundationVersionNumber10_5_2 = 476.10;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_5_2}
  kCFCoreFoundationVersionNumber10_5_3 = 476.13;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_5_3}
  kCFCoreFoundationVersionNumber10_5_4 = 476.14;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_5_4}
  kCFCoreFoundationVersionNumber10_5_5 = 476.15;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_5_5}
  kCFCoreFoundationVersionNumber10_5_6 = 476.17;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber10_5_6}

  kCFCoreFoundationVersionNumber_iPhoneOS_2_0 = 478.23;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber_iPhoneOS_2_0}
  kCFCoreFoundationVersionNumber_iPhoneOS_2_1 = 478.26;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber_iPhoneOS_2_1}
  kCFCoreFoundationVersionNumber_iPhoneOS_2_2 = 478.29;
  {$EXTERNALSYM kCFCoreFoundationVersionNumber_iPhoneOS_2_2}


type
  CFTypeID = LongWord;
  {$EXTERNALSYM CFTypeID}
  CFOptionFlags = LongWord;
  {$EXTERNALSYM CFOptionFlags}
  CFHashCode = LongWord;
  {$EXTERNALSYM CFHashCode}
  CFIndex = Integer;
  {$EXTERNALSYM CFIndex}
  PCFIndex = ^CFIndex;

  PCFTypeRef = ^CFTypeRef;
{ Base "type" of all "CF objects", and polymorphic functions on them }
  CFTypeRef = Pointer;
  {$EXTERNALSYM CFTypeRef}

  PCFStringRef = ^CFStringRef;
  CFStringRef = ^__CFString;
  {$EXTERNALSYM CFStringRef}
  __CFString = record
  end;
  {$EXTERNALSYM __CFString}

  PCFMutableStringRef = ^CFMutableStringRef;
  CFMutableStringRef = ^__CFString;
  {$EXTERNALSYM CFMutableStringRef}

{
        Type to mean any instance of a property list type;
        currently, CFString, CFData, CFNumber, CFBoolean, CFDate,
        CFArray, and CFDictionary.
 }
  PCFPropertyListRef = ^CFPropertyListRef;
  CFPropertyListRef = CFTypeRef;
  {$EXTERNALSYM CFPropertyListRef}

{ Values returned from comparison functions }
const
  kCFCompareLessThan    = -1;
  {$EXTERNALSYM kCFCompareLessThan}
  kCFCompareEqualTo     = 0;
  {$EXTERNALSYM kCFCompareEqualTo}
  kCFCompareGreaterThan = 1;
  {$EXTERNALSYM kCFCompareGreaterThan}

type
  CFComparisonResult = CFIndex;
  {$EXTERNALSYM CFComparisonResult}

{ A standard comparison function }
  CFComparatorFunction = function(val1: Pointer; val2: Pointer; 
    context: Pointer): CFComparisonResult; cdecl;
  {$EXTERNALSYM CFComparatorFunction}

{ Constant used by some functions to indicate failed searches. }
{ This is of type CFIndex. }
const
  kCFNotFound = -1;
  {$EXTERNALSYM kCFNotFound}


// Range type
type
  PCFRange = ^CFRange;
  CFRange = record
    location: CFIndex;
    length: CFIndex;
  end;
  {$EXTERNALSYM CFRange}

function CFRangeMake(loc: CFIndex; len: CFIndex): CFRange; inline;
{$EXTERNALSYM CFRangeMake}


{ Null representant }

type
  PCFNullRef = ^CFNullRef; 
  CFNullRef = ^__CFNull; 
  {$EXTERNALSYM CFNullRef}
  __CFNull = record
  end;
  {$EXTERNALSYM __CFNull}

function CFNullGetTypeID: CFTypeID; cdecl;
{$EXTERNALSYM CFNullGetTypeID}


function kCFNull: CFNullRef;	// the singleton null instance
{$EXTERNALSYM kCFNull}



{ Allocator API

   Most of the time when specifying an allocator to Create functions, the NULL
   argument indicates "use the default"; this is the same as using kCFAllocatorDefault
   or the return value from CFAllocatorGetDefault().  This assures that you will use
   the allocator in effect at that time.

   You should rarely use kCFAllocatorSystemDefault, the default default allocator.
 }
type
  PCFAllocatorRef = ^CFAllocatorRef;
  CFAllocatorRef = ^__CFAllocator;
  {$EXTERNALSYM CFAllocatorRef}
  __CFAllocator = record
  end;
  {$EXTERNALSYM __CFAllocator}

{ This is a synonym for NULL, if you'd rather use a named constant. }

function kCFAllocatorDefault: CFAllocatorRef;
{$EXTERNALSYM kCFAllocatorDefault}

{ Default system allocator; you rarely need to use this. }

function kCFAllocatorSystemDefault: CFAllocatorRef;
{$EXTERNALSYM kCFAllocatorSystemDefault}

{ This allocator uses malloc(), realloc(), and free(). This should not be
   generally used; stick to kCFAllocatorDefault whenever possible. This
   allocator is useful as the "bytesDeallocator" in CFData or
   "contentsDeallocator" in CFString where the memory was obtained as a
   result of malloc() type functions.
 }

function kCFAllocatorMalloc: CFAllocatorRef;
{$EXTERNALSYM kCFAllocatorMalloc}

{ This allocator explicitly uses the default malloc zone, returned by
   malloc_default_zone(). It should only be used when an object is
   safe to be allocated in non-scanned memory.
 }

function kCFAllocatorMallocZone: CFAllocatorRef;
{$EXTERNALSYM kCFAllocatorMallocZone}

{ Null allocator which does nothing and allocates no memory. This allocator
   is useful as the "bytesDeallocator" in CFData or "contentsDeallocator"
   in CFString where the memory should not be freed. 
 }

function kCFAllocatorNull: CFAllocatorRef;
{$EXTERNALSYM kCFAllocatorNull}

{ Special allocator argument to CFAllocatorCreate() which means
   "use the functions given in the context to allocate the allocator
   itself as well". 
 }

function kCFAllocatorUseContext: CFAllocatorRef;
{$EXTERNALSYM kCFAllocatorUseContext}

type
  CFAllocatorRetainCallBack = function(info: Pointer): Pointer; cdecl;
  {$EXTERNALSYM CFAllocatorRetainCallBack}
  CFAllocatorReleaseCallBack = procedure(info: Pointer); cdecl;
  {$EXTERNALSYM CFAllocatorReleaseCallBack}
  CFAllocatorCopyDescriptionCallBack = function(
    info: Pointer): CFStringRef; cdecl;
  {$EXTERNALSYM CFAllocatorCopyDescriptionCallBack}
  CFAllocatorAllocateCallBack = function(allocSize: CFIndex; 
    hint: CFOptionFlags; info: Pointer): Pointer; cdecl;
  {$EXTERNALSYM CFAllocatorAllocateCallBack}
  CFAllocatorReallocateCallBack = function(ptr: Pointer; newsize: CFIndex; 
    hint: CFOptionFlags; info: Pointer): Pointer; cdecl;
  {$EXTERNALSYM CFAllocatorReallocateCallBack}
  CFAllocatorDeallocateCallBack = procedure(ptr: Pointer; 
    info: Pointer); cdecl;
  {$EXTERNALSYM CFAllocatorDeallocateCallBack}
  CFAllocatorPreferredSizeCallBack = function(size: CFIndex; 
    hint: CFOptionFlags; info: Pointer): CFIndex; cdecl;
  {$EXTERNALSYM CFAllocatorPreferredSizeCallBack}

  PCFAllocatorContext = ^CFAllocatorContext;
  CFAllocatorContext = record
    version: CFIndex;
    info: Pointer;
    retain: CFAllocatorRetainCallBack;
    release: CFAllocatorReleaseCallBack;
    copyDescription: CFAllocatorCopyDescriptionCallBack;
    allocate: CFAllocatorAllocateCallBack;
    reallocate: CFAllocatorReallocateCallBack;
    deallocate: CFAllocatorDeallocateCallBack;
    preferredSize: CFAllocatorPreferredSizeCallBack;
  end;
  {$EXTERNALSYM CFAllocatorContext}

function CFAllocatorGetTypeID: CFTypeID; cdecl;
{$EXTERNALSYM CFAllocatorGetTypeID}

{ 
	CFAllocatorSetDefault() sets the allocator that is used in the current
	thread whenever NULL is specified as an allocator argument. This means
	that most, if not all allocations will go through this allocator. It
	also means that any allocator set as the default needs to be ready to
	deal with arbitrary memory allocation requests; in addition, the size
	and number of requests will change between releases.

	An allocator set as the default will never be released, even if later
	another allocator replaces it as the default. Not only is it impractical
	for it to be released (as there might be caches created under the covers
	that refer to the allocator), in general it's also safer and more
	efficient to keep it around.

	If you wish to use a custom allocator in a context, it's best to provide
	it as the argument to the various creation functions rather than setting
	it as the default. Setting the default allocator is not encouraged.

	If you do set an allocator as the default, either do it for all time in
	your app, or do it in a nested fashion (by restoring the previous allocator
	when you exit your context). The latter might be appropriate for plug-ins
	or libraries that wish to set the default allocator.
 }
procedure CFAllocatorSetDefault(allocator: CFAllocatorRef); cdecl;
{$EXTERNALSYM CFAllocatorSetDefault}

function CFAllocatorGetDefault: CFAllocatorRef; cdecl;
{$EXTERNALSYM CFAllocatorGetDefault}

function CFAllocatorCreate(allocator: CFAllocatorRef;
  context: PCFAllocatorContext): CFAllocatorRef; cdecl;
{$EXTERNALSYM CFAllocatorCreate}

function CFAllocatorAllocate(allocator: CFAllocatorRef; size: CFIndex;
  hint: CFOptionFlags): Pointer; cdecl;
{$EXTERNALSYM CFAllocatorAllocate}

function CFAllocatorReallocate(allocator: CFAllocatorRef; ptr: Pointer;
  newsize: CFIndex; hint: CFOptionFlags): Pointer; cdecl;
{$EXTERNALSYM CFAllocatorReallocate}

procedure CFAllocatorDeallocate(allocator: CFAllocatorRef; ptr: Pointer); cdecl;
{$EXTERNALSYM CFAllocatorDeallocate}

function CFAllocatorGetPreferredSizeForSize(allocator: CFAllocatorRef;
  size: CFIndex; hint: CFOptionFlags): CFIndex; cdecl;
{$EXTERNALSYM CFAllocatorGetPreferredSizeForSize}

procedure CFAllocatorGetContext(allocator: CFAllocatorRef;
  context: PCFAllocatorContext); cdecl;
{$EXTERNALSYM CFAllocatorGetContext}


{ Polymorphic CF functions }

function CFGetTypeID(cf: CFTypeRef): CFTypeID; cdecl;
{$EXTERNALSYM CFGetTypeID}

function CFCopyTypeIDDescription(type_id: CFTypeID): CFStringRef; cdecl;
{$EXTERNALSYM CFCopyTypeIDDescription}

function CFRetain(cf: CFTypeRef): CFTypeRef; cdecl;
{$EXTERNALSYM CFRetain}

procedure CFRelease(cf: CFTypeRef); cdecl;
{$EXTERNALSYM CFRelease}

function CFGetRetainCount(cf: CFTypeRef): CFIndex; cdecl;
{$EXTERNALSYM CFGetRetainCount}

function CFMakeCollectable(cf: CFTypeRef): CFTypeRef; cdecl;
{$EXTERNALSYM CFMakeCollectable}

function CFEqual(cf1: CFTypeRef; cf2: CFTypeRef): Boolean; cdecl;
{$EXTERNALSYM CFEqual}

function CFHash(cf: CFTypeRef): CFHashCode; cdecl;
{$EXTERNALSYM CFHash}

function CFCopyDescription(cf: CFTypeRef): CFStringRef; cdecl;
{$EXTERNALSYM CFCopyDescription}

function CFGetAllocator(cf: CFTypeRef): CFAllocatorRef; cdecl;
{$EXTERNALSYM CFGetAllocator}

{$ENDIF !__COREFOUNDATION_CFBASE__}

