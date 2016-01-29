{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFNumber.h                             }
{          Copyright (c) 1999-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IF NOT DEFINED(__COREFOUNDATION_CFNUMBER__)}

{$DEFINE __COREFOUNDATION_CFNUMBER__}

{$I CFBase.inc}

type
  PCFBooleanRef = ^CFBooleanRef;
  CFBooleanRef = ^__CFBoolean;
  {$EXTERNALSYM CFBooleanRef}
  __CFBoolean = record
  end;
  {$EXTERNALSYM __CFBoolean}

function kCFBooleanTrue: CFBooleanRef;
{$EXTERNALSYM kCFBooleanTrue}
function kCFBooleanFalse: CFBooleanRef;
{$EXTERNALSYM kCFBooleanFalse}

function CFBooleanGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFBooleanGetTypeID';
{$EXTERNALSYM CFBooleanGetTypeID}

function CFBooleanGetValue(boolean: CFBooleanRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFBooleanGetValue';
{$EXTERNALSYM CFBooleanGetValue}

const
  kCFNumberSInt8Type     = 1;
  {$EXTERNALSYM kCFNumberSInt8Type}
  kCFNumberSInt16Type    = 2;
  {$EXTERNALSYM kCFNumberSInt16Type}
  kCFNumberSInt32Type    = 3;
  {$EXTERNALSYM kCFNumberSInt32Type}
  kCFNumberSInt64Type    = 4;
  {$EXTERNALSYM kCFNumberSInt64Type}
  kCFNumberFloat32Type   = 5;
  {$EXTERNALSYM kCFNumberFloat32Type}
  kCFNumberFloat64Type   = 6; { 64-bit IEEE 754 }
  {$EXTERNALSYM kCFNumberFloat64Type}
{ Basic C types }
  kCFNumberCharType      = 7;
  {$EXTERNALSYM kCFNumberCharType}
  kCFNumberShortType     = 8;
  {$EXTERNALSYM kCFNumberShortType}
  kCFNumberIntType       = 9;
  {$EXTERNALSYM kCFNumberIntType}
  kCFNumberLongType      = 10;
  {$EXTERNALSYM kCFNumberLongType}
  kCFNumberLongLongType  = 11;
  {$EXTERNALSYM kCFNumberLongLongType}
  kCFNumberFloatType     = 12;
  {$EXTERNALSYM kCFNumberFloatType}
  kCFNumberDoubleType    = 13;
  {$EXTERNALSYM kCFNumberDoubleType}
{ Other }
  kCFNumberCFIndexType   = 14;
  {$EXTERNALSYM kCFNumberCFIndexType}
  kCFNumberNSIntegerType = 15;
  {$EXTERNALSYM kCFNumberNSIntegerType}
  kCFNumberCGFloatType   = 16;
  {$EXTERNALSYM kCFNumberCGFloatType}
  kCFNumberMaxType       = 16;
  {$EXTERNALSYM kCFNumberMaxType}
type
  CFNumberType = CFIndex;
  {$EXTERNALSYM CFNumberType}

  PCFNumberRef = ^CFNumberRef;
  CFNumberRef = ^__CFNumber;
  {$EXTERNALSYM CFNumberRef}
  __CFNumber = record
  end;
  {$EXTERNALSYM __CFNumber}

function kCFNumberPositiveInfinity: CFNumberRef;
{$EXTERNALSYM kCFNumberPositiveInfinity}
function kCFNumberNegativeInfinity: CFNumberRef;
{$EXTERNALSYM kCFNumberNegativeInfinity}
function kCFNumberNaN: CFNumberRef;
{$EXTERNALSYM kCFNumberNaN}

function CFNumberGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberGetTypeID';
{$EXTERNALSYM CFNumberGetTypeID}

{
	Creates a CFNumber with the given value. The type of number pointed
	to by the valuePtr is specified by type. If type is a floating point
	type and the value represents one of the infinities or NaN, the
	well-defined CFNumber for that value is returned. If either of
	valuePtr or type is an invalid value, the result is undefined.
 }
function CFNumberCreate(allocator: CFAllocatorRef; theType: CFNumberType;
  valuePtr: Pointer): CFNumberRef; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberCreate';
{$EXTERNALSYM CFNumberCreate}

{ 
	Returns the storage format of the CFNumber's value.  Note that
	this is not necessarily the type provided in CFNumberCreate().
 }
function CFNumberGetType(number: CFNumberRef): CFNumberType; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberGetType';
{$EXTERNALSYM CFNumberGetType}

{
	Returns the size in bytes of the type of the number.
 }
function CFNumberGetByteSize(number: CFNumberRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberGetByteSize';
{$EXTERNALSYM CFNumberGetByteSize}

{
	Returns true if the type of the CFNumber's value is one of
	the defined floating point types.
 }
function CFNumberIsFloatType(number: CFNumberRef): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberIsFloatType';
{$EXTERNALSYM CFNumberIsFloatType}

{ 
	Copies the CFNumber's value into the space pointed to by
	valuePtr, as the specified type. If conversion needs to take
	place, the conversion rules follow human expectation and not
	C's promotion and truncation rules. If the conversion is
	lossy, or the value is out of range, false is returned. Best
	attempt at conversion will still be in *valuePtr.
 }
function CFNumberGetValue(number: CFNumberRef; theType: CFNumberType;
  valuePtr: Pointer): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberGetValue';
{$EXTERNALSYM CFNumberGetValue}

{ 
	Compares the two CFNumber instances. If conversion of the
	types of the values is needed, the conversion and comparison
	follow human expectations and not C's promotion and comparison
	rules. Negative zero compares less than positive zero.
	Positive infinity compares greater than everything except
	itself, to which it compares equal. Negative infinity compares
	less than everything except itself, to which it compares equal.
	Unlike standard practice, if both numbers are NaN, then they
	compare equal; if only one of the numbers is NaN, then the NaN
	compares greater than the other number if it is negative, and
	smaller than the other number if it is positive. (Note that in
	CFEqual() with two CFNumbers, if either or both of the numbers
	is NaN, true is returned.)
 }
function CFNumberCompare(number: CFNumberRef; otherNumber: CFNumberRef;
  context: Pointer): CFComparisonResult; cdecl;
  external CoreFoundationLib name _PU + 'CFNumberCompare';
{$EXTERNALSYM CFNumberCompare}

{$ENDIF !__COREFOUNDATION_CFNUMBER__}

