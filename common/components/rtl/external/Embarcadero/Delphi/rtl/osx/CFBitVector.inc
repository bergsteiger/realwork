{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFBitvector.h                          }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFNDEF __COREFOUNDATION_CFBITVECTOR__}

{$DEFINE __COREFOUNDATION_CFBITVECTOR__}

{$I CFBase.inc}

type
  CFBit = UInt32;
  {$EXTERNALSYM CFBit}

  PCFBitVectorRef = ^CFBitVectorRef;
  CFBitVectorRef = ^__CFBitVector;
  {$EXTERNALSYM CFBitVectorRef}
  __CFBitVector = record
  end;
  {$EXTERNALSYM __CFBitVector}

  PCFMutableBitVectorRef = ^CFMutableBitVectorRef;
  CFMutableBitVectorRef = ^__CFBitVector;
  {$EXTERNALSYM CFMutableBitVectorRef}

function CFBitVectorGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorGetTypeID';
{$EXTERNALSYM CFBitVectorGetTypeID}

function CFBitVectorCreate(allocator: CFAllocatorRef; bytes: PUInt8;
  numBits: CFIndex): CFBitVectorRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorCreate';
{$EXTERNALSYM CFBitVectorCreate}
function CFBitVectorCreateCopy(allocator: CFAllocatorRef; 
  bv: CFBitVectorRef): CFBitVectorRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorCreateCopy';
{$EXTERNALSYM CFBitVectorCreateCopy}
function CFBitVectorCreateMutable(allocator: CFAllocatorRef; 
  capacity: CFIndex): CFMutableBitVectorRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorCreateMutable';
{$EXTERNALSYM CFBitVectorCreateMutable}
function CFBitVectorCreateMutableCopy(allocator: CFAllocatorRef; 
  capacity: CFIndex; bv: CFBitVectorRef): CFMutableBitVectorRef; cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorCreateMutableCopy';
{$EXTERNALSYM CFBitVectorCreateMutableCopy}

function CFBitVectorGetCount(bv: CFBitVectorRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorGetCount';
{$EXTERNALSYM CFBitVectorGetCount}
function CFBitVectorGetCountOfBit(bv: CFBitVectorRef; range: CFRange; 
  value: CFBit): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorGetCountOfBit';
{$EXTERNALSYM CFBitVectorGetCountOfBit}
function CFBitVectorContainsBit(bv: CFBitVectorRef; range: CFRange; 
  value: CFBit): Boolean; cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorContainsBit';
{$EXTERNALSYM CFBitVectorContainsBit}
function CFBitVectorGetBitAtIndex(bv: CFBitVectorRef; 
  idx: CFIndex): CFBit; cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorGetBitAtIndex';
{$EXTERNALSYM CFBitVectorGetBitAtIndex}
procedure CFBitVectorGetBits(bv: CFBitVectorRef; range: CFRange; 
  bytes: PUInt8); cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorGetBits';
{$EXTERNALSYM CFBitVectorGetBits}
function CFBitVectorGetFirstIndexOfBit(bv: CFBitVectorRef; range: CFRange; 
  value: CFBit): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorGetFirstIndexOfBit';
{$EXTERNALSYM CFBitVectorGetFirstIndexOfBit}
function CFBitVectorGetLastIndexOfBit(bv: CFBitVectorRef; range: CFRange; 
  value: CFBit): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorGetLastIndexOfBit';
{$EXTERNALSYM CFBitVectorGetLastIndexOfBit}

procedure CFBitVectorSetCount(bv: CFMutableBitVectorRef; 
  count: CFIndex); cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorSetCount';
{$EXTERNALSYM CFBitVectorSetCount}
procedure CFBitVectorFlipBitAtIndex(bv: CFMutableBitVectorRef; 
  idx: CFIndex); cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorFlipBitAtIndex';
{$EXTERNALSYM CFBitVectorFlipBitAtIndex}
procedure CFBitVectorFlipBits(bv: CFMutableBitVectorRef; 
  range: CFRange); cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorFlipBits';
{$EXTERNALSYM CFBitVectorFlipBits}
procedure CFBitVectorSetBitAtIndex(bv: CFMutableBitVectorRef; idx: CFIndex; 
  value: CFBit); cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorSetBitAtIndex';
{$EXTERNALSYM CFBitVectorSetBitAtIndex}
procedure CFBitVectorSetBits(bv: CFMutableBitVectorRef; range: CFRange; 
  value: CFBit); cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorSetBits';
{$EXTERNALSYM CFBitVectorSetBits}
procedure CFBitVectorSetAllBits(bv: CFMutableBitVectorRef; 
  value: CFBit); cdecl;
  external CoreFoundationLib name _PU + 'CFBitVectorSetAllBits';
{$EXTERNALSYM CFBitVectorSetAllBits}

{$ENDIF __COREFOUNDATION_CFBITVECTOR__}

