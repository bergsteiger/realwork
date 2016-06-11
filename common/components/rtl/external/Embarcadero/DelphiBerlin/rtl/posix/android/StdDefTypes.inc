{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}


type
  {$IFDEF CPU64BITS}
  ptrdiff_t = Int64;
  {$ELSE}
  ptrdiff_t = Integer;
  {$ENDIF}
  {$EXTERNALSYM ptrdiff_t}
  Pptrdiff_t = ^ptrdiff_t;

  wchar_t = Int32;
  {$EXTERNALSYM wchar_t}
  Pwchar_t = ^wchar_t;

  {$IFDEF CPU64BITS}
  size_t = UInt64;
  {$ELSE}
  size_t = UInt32;
  {$ENDIF}
  {$EXTERNALSYM size_t}
  Psize_t = ^size_t;
