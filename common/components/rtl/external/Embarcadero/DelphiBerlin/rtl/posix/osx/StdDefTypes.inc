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

  size_t = LongWord;
  {$EXTERNALSYM size_t}
  Psize_t = ^size_t;
