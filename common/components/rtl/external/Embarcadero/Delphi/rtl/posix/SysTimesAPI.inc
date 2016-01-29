{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{  Store the CPU time used by this process and all its
   dead children (and their dead children) in BUFFER.
   Return the elapsed real time, or (clock_t) -1 for errors.
   All times are in CLK_TCKths of a second.  }
function times(var __buffer: tms): clock_t; cdecl; overload;
  external libc name _PU + 'times';
{$EXTERNALSYM times}
function times(__buffer: Ptms): clock_t; cdecl; overload;
  external libc name _PU + 'times';
{$EXTERNALSYM times}
