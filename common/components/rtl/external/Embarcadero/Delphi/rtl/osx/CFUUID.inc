{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFUUID.h                               }
{          Copyright (c) 1999-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$IFNDEF __COREFOUNDATION_CFUUID__}

{$DEFINE __COREFOUNDATION_CFUUID__}

{$I CFBase.inc}
{$I CFString.inc}

type
  PCFUUIDRef = ^CFUUIDRef;
  CFUUIDRef = ^__CFUUID;
  {$EXTERNALSYM CFUUIDRef}
  __CFUUID = record
  end;
  {$EXTERNALSYM __CFUUID}

  PCFUUIDBytes = ^CFUUIDBytes;
  CFUUIDBytes = record
    byte0: UInt8;
    byte1: UInt8;
    byte2: UInt8;
    byte3: UInt8;
    byte4: UInt8;
    byte5: UInt8;
    byte6: UInt8;
    byte7: UInt8;
    byte8: UInt8;
    byte9: UInt8;
    byte10: UInt8;
    byte11: UInt8;
    byte12: UInt8;
    byte13: UInt8;
    byte14: UInt8;
    byte15: UInt8;
  end;
  {$EXTERNALSYM CFUUIDBytes}
{ The CFUUIDBytes struct is a 128-bit struct that contains the
raw UUID.  A CFUUIDRef can provide such a struct from the
CFUUIDGetUUIDBytes() function.  This struct is suitable for
passing to APIs that expect a raw UUID.
 }

function CFUUIDGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFUUIDGetTypeID';
{$EXTERNALSYM CFUUIDGetTypeID}

function CFUUIDCreate(alloc: CFAllocatorRef): CFUUIDRef; cdecl;
  external CoreFoundationLib name _PU + 'CFUUIDCreate';
{$EXTERNALSYM CFUUIDCreate}
{ Create and return a brand new unique identifier }

function CFUUIDCreateWithBytes(alloc: CFAllocatorRef; byte0: UInt8;
  byte1: UInt8; byte2: UInt8; byte3: UInt8; byte4: UInt8; byte5: UInt8;
  byte6: UInt8; byte7: UInt8; byte8: UInt8; byte9: UInt8; byte10: UInt8;
  byte11: UInt8; byte12: UInt8; byte13: UInt8; byte14: UInt8;
  byte15: UInt8): CFUUIDRef; cdecl;
  external CoreFoundationLib name _PU + 'CFUUIDCreateWithBytes';
{$EXTERNALSYM CFUUIDCreateWithBytes}
{ Create and return an identifier with the given contents.  This may return an existing instance with its ref count bumped because of uniquing. }

function CFUUIDCreateFromString(alloc: CFAllocatorRef;
  uuidStr: CFStringRef): CFUUIDRef; cdecl;
  external CoreFoundationLib name _PU + 'CFUUIDCreateFromString';
{$EXTERNALSYM CFUUIDCreateFromString}
{ Converts from a string representation to the UUID.  This may return an existing instance with its ref count bumped because of uniquing. }

function CFUUIDCreateString(alloc: CFAllocatorRef;
  uuid: CFUUIDRef): CFStringRef; cdecl;
  external CoreFoundationLib name _PU + 'CFUUIDCreateString';
{$EXTERNALSYM CFUUIDCreateString}
{ Converts from a UUID to its string representation. }

function CFUUIDGetConstantUUIDWithBytes(alloc: CFAllocatorRef; byte0: UInt8;
  byte1: UInt8; byte2: UInt8; byte3: UInt8; byte4: UInt8; byte5: UInt8;
  byte6: UInt8; byte7: UInt8; byte8: UInt8; byte9: UInt8; byte10: UInt8;
  byte11: UInt8; byte12: UInt8; byte13: UInt8; byte14: UInt8;
  byte15: UInt8): CFUUIDRef; cdecl;
  external CoreFoundationLib name _PU + 'CFUUIDGetConstantUUIDWithBytes';
{$EXTERNALSYM CFUUIDGetConstantUUIDWithBytes}
{ This returns an immortal CFUUIDRef that should not be released.  It can be used in headers to declare UUID constants with #define. }

function CFUUIDGetUUIDBytes(uuid: CFUUIDRef): CFUUIDBytes; cdecl;
  external CoreFoundationLib name _PU + 'CFUUIDGetUUIDBytes';
{$EXTERNALSYM CFUUIDGetUUIDBytes}

function CFUUIDCreateFromUUIDBytes(alloc: CFAllocatorRef;
  bytes: CFUUIDBytes): CFUUIDRef; cdecl;
  external CoreFoundationLib name _PU + 'CFUUIDCreateFromUUIDBytes';
{$EXTERNALSYM CFUUIDCreateFromUUIDBytes}


{$ENDIF !__COREFOUNDATION_CFUUID__}

