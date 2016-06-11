{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.KhrPlatform;

interface

{$I Androidapi.inc}

const 
  KHRONOS_SUPPORT_INT64 = 1;
  {$EXTERNALSYM KHRONOS_SUPPORT_INT64}
  KHRONOS_SUPPORT_FLOAT = 1;
  {$EXTERNALSYM KHRONOS_SUPPORT_FLOAT}
  
 
type
  khronos_int32_t  = Int32;
  {$EXTERNALSYM khronos_int32_t}
  khronos_uint32_t = UInt32;
  {$EXTERNALSYM khronos_uint32_t}
  khronos_int64_t  = Int64;
  {$EXTERNALSYM khronos_int64_t}
  khronos_uint64_t = UInt64;
  {$EXTERNALSYM khronos_uint64_t}
  
  khronos_int8_t   = ShortInt;
  {$EXTERNALSYM khronos_int8_t}
  khronos_uint8_t  = Byte;
  {$EXTERNALSYM khronos_uint8_t}
  khronos_int16_t  = SmallInt;
  {$EXTERNALSYM khronos_int16_t}
  khronos_uint16_t  = Word;
  {$EXTERNALSYM khronos_uint16_t}
  khronos_intptr_t  = IntPtr;
  {$EXTERNALSYM khronos_intptr_t}
  khronos_uintptr_t = UIntPtr;
  {$EXTERNALSYM khronos_uintptr_t}
  khronos_ssize_t   = Int32;
  {$EXTERNALSYM khronos_ssize_t}
  khronos_usize_t   = UInt32;
  {$EXTERNALSYM khronos_usize_t}

  khronos_float_t   = Single;
  {$EXTERNALSYM khronos_float_t}
  
  khronos_utime_nanoseconds_t = khronos_uint64_t;
  {$EXTERNALSYM khronos_utime_nanoseconds_t}
  khronos_stime_nanoseconds_t = khronos_int64_t;
  {$EXTERNALSYM khronos_stime_nanoseconds_t}

  
implementation

end.
