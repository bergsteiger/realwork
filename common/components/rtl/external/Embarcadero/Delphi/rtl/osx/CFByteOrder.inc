{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFByteOrder.h                          }
{          Copyright (c) 1995-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


{$IFNDEF __COREFOUNDATION_CFBYTEORDER__}

{$DEFINE __COREFOUNDATION_CFBYTEORDER__}

{$I CFBase.inc}

//TODO -oUnassigned -cReview : OSX: CFByteOrder.h is translated assuming Intel CPU architecture (Little Endian)

const
  CFByteOrderUnknown= 0;
  {$EXTERNALSYM CFByteOrderUnknown}
  CFByteOrderLittleEndian = 1;
  {$EXTERNALSYM CFByteOrderLittleEndian}
  CFByteOrderBigEndian = 2;
  {$EXTERNALSYM CFByteOrderBigEndian}
type
  CFByteOrder = CFIndex;
  {$EXTERNALSYM CFByteOrder}

function CFByteOrderGetCurrent: CFByteOrder; inline;
{$EXTERNALSYM CFByteOrderGetCurrent}

function CFSwapInt16(arg: uint16_t): uint16_t; inline;
{$EXTERNALSYM CFSwapInt16}

function CFSwapInt32(arg: uint32_t): uint32_t; inline;
{$EXTERNALSYM CFSwapInt32}

function CFSwapInt64(arg: uint64_t): uint64_t;
{$EXTERNALSYM CFSwapInt64}

function CFSwapInt16BigToHost(arg: uint16_t): uint16_t; inline;
{$EXTERNALSYM CFSwapInt16BigToHost}

function CFSwapInt32BigToHost(arg: uint32_t): uint32_t; inline;
{$EXTERNALSYM CFSwapInt32BigToHost}

function CFSwapInt64BigToHost(arg: uint64_t): uint64_t; inline;
{$EXTERNALSYM CFSwapInt64BigToHost}

function CFSwapInt16HostToBig(arg: uint16_t): uint16_t; inline;
{$EXTERNALSYM CFSwapInt16HostToBig}

function CFSwapInt32HostToBig(arg: uint32_t): uint32_t; inline;
{$EXTERNALSYM CFSwapInt32HostToBig}

function CFSwapInt64HostToBig(arg: uint64_t): uint64_t; inline;
{$EXTERNALSYM CFSwapInt64HostToBig}

function CFSwapInt16LittleToHost(arg: uint16_t): uint16_t; inline;
{$EXTERNALSYM CFSwapInt16LittleToHost}

function CFSwapInt32LittleToHost(arg: uint32_t): uint32_t; inline;
{$EXTERNALSYM CFSwapInt32LittleToHost}

function CFSwapInt64LittleToHost(arg: uint64_t): uint64_t; inline;
{$EXTERNALSYM CFSwapInt64LittleToHost}

function CFSwapInt16HostToLittle(arg: uint16_t): uint16_t; inline;
{$EXTERNALSYM CFSwapInt16HostToLittle}

function CFSwapInt32HostToLittle(arg: uint32_t): uint32_t; inline;
{$EXTERNALSYM CFSwapInt32HostToLittle}

function CFSwapInt64HostToLittle(arg: uint64_t): uint64_t; inline;
{$EXTERNALSYM CFSwapInt64HostToLittle}

type
  CFSwappedFloat32 = packed record
    v: uint32_t;
  end;
  {$EXTERNALSYM CFSwappedFloat32}
  CFSwappedFloat64 = packed record
    v: uint64_t;
  end;
  {$EXTERNALSYM CFSwappedFloat64}

function CFConvertFloat32HostToSwapped(arg: Float32): CFSwappedFloat32;
{$EXTERNALSYM CFConvertFloat32HostToSwapped}

function CFConvertFloat32SwappedToHost(arg: CFSwappedFloat32): Float32;
{$EXTERNALSYM CFConvertFloat32SwappedToHost}

function CFConvertFloat64HostToSwapped(arg: Float64): CFSwappedFloat64;
{$EXTERNALSYM CFConvertFloat64HostToSwapped}

function CFConvertFloat64SwappedToHost(arg: CFSwappedFloat64): Float64;
{$EXTERNALSYM CFConvertFloat64SwappedToHost}

function CFConvertFloatHostToSwapped(arg: Single): CFSwappedFloat32;
{$EXTERNALSYM CFConvertFloatHostToSwapped}

function CFConvertFloatSwappedToHost(arg: CFSwappedFloat32): Single;
{$EXTERNALSYM CFConvertFloatSwappedToHost}

function CFConvertDoubleHostToSwapped(arg: Double): CFSwappedFloat64;
{$EXTERNALSYM CFConvertDoubleHostToSwapped}

function CFConvertDoubleSwappedToHost(arg: CFSwappedFloat64): Double;
{$EXTERNALSYM CFConvertDoubleSwappedToHost}


{$ENDIF !__COREFOUNDATION_CFBYTEORDER__}

