{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

function __getenv(Name: MarshaledAString): MarshaledAString; cdecl;
  external libc name _PU + 'getenv';
{$EXTERNALSYM __getenv}

// libc defines this one
function getenv(Name: MarshaledAString): MarshaledAString; cdecl;
  external libc name _PU + 'getenv';
{$EXTERNALSYM getenv}

function setenv(const Name: MarshaledAString; const Value: MarshaledAString; Overwrite: Integer): Integer; cdecl;
  external libc name _PU + 'setenv';

function realpath(const FileName: MarshaledAString; const ResolvedName: MarshaledAString): MarshaledAString; cdecl;
  external libc name _PU + 'realpath';
{$EXTERNALSYM realpath}

{$IFNDEF ANDROID}
function mblen(const S: MarshaledAString; N: LongWord): Integer; cdecl;
  external libc name _PU + 'mblen';
{$EXTERNALSYM mblen}
{$ENDIF !ANDROID}

function putenv(const S: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'putenv';
{$EXTERNALSYM putenv}

function unsetenv(const Name: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'unsetenv';
{$EXTERNALSYM unsetenv}

function strtol(const Str: MarshaledAString; EndPtr: PMarshaledAString;Base: Integer): LongInt; cdecl;
  external libc name _PU + 'strtol';
{$EXTERNALSYM strtol}

function strtoll(const Str: MarshaledAString; EndPtr: PMarshaledAString; Base: Integer): Int64; cdecl;
  external libc name _PU + 'strtoll';
{$EXTERNALSYM strtoll}

function strtoul(const Str: MarshaledAString; EndPtr: PMarshaledAString; Base: Integer): LongInt; cdecl;
  external libc name _PU + 'strtoul';
{$EXTERNALSYM strtoul}

function strtoull(const Str: MarshaledAString; EndPtr: PMarshaledAString; Base: Integer): UInt64; cdecl;
  external libc name _PU + 'strtoull';
{$EXTERNALSYM strtoull}

function strtod(const Nptr: MarshaledAString; EndPtr: PMarshaledAString):Double; cdecl;
  external libc name _PU + 'strtod';
{$EXTERNALSYM strtod}

function atoi(const Str: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'atoi';
{$EXTERNALSYM atoi}

function atol(const Str: MarshaledAString): LongInt; cdecl;
  external libc name _PU + 'atol';
{$EXTERNALSYM atol}

function atoll(const Str: MarshaledAString): Int64; cdecl;
  external libc name _PU + 'atoll';
{$EXTERNALSYM atoll}

function jrand48(Xsubi: PWord): LongInt; cdecl;
  external libc name _PU + 'jrand48';
{$EXTERNALSYM jrand48}

function mrand48: LongInt; cdecl;
  external libc name _PU + 'mrand48';
{$EXTERNALSYM mrand48}

function nrand48(Xsubi: PWord): LongInt; cdecl;
  external libc name _PU + 'nrand48';
{$EXTERNALSYM nrand48}

function lrand48: LongInt; cdecl;
  external libc name _PU + 'lrand48';
{$EXTERNALSYM lrand48}

function seed48(Seed: PWord): PWord; cdecl;
  external libc name _PU + 'seed48';
{$EXTERNALSYM seed48}

function erand48(Xsubi: Word): Double; cdecl;
  external libc name _PU + 'erand48';
{$EXTERNALSYM erand48}

function drand48: Double; cdecl;
  external libc name _PU + 'drand48';
{$EXTERNALSYM drand48}

procedure srand48(SeedVal: LongInt); cdecl
  external libc name _PU + 'srand48';
{$EXTERNALSYM srand48}

function unlockpt(Fildes: Integer): Integer; cdecl;
  external libc name _PU + 'unlockpt';
{$EXTERNALSYM unlockpt}

function ptsname(Fildes: Integer): MarshaledAString; cdecl;
  external libc name _PU + 'ptsname';
{$EXTERNALSYM ptsname}

function _div(Number: Integer; Denom: Integer): div_t; cdecl;
  external libc name _PU + 'div';
{$EXTERNALSYM _div}

function ldiv(Number: Int32; Denom: Int32): ldiv_t; cdecl;
  external libc name _PU + 'ldiv';
{$EXTERNALSYM ldiv}

function lldiv(Number:  Int64; Denom: Int64): lldiv_t; cdecl;
  external libc name _PU + 'lldiv';
{$EXTERNALSYM lldiv}

function bsearch(Key: Pointer; Base0: Pointer; Nmeb: size_t; Size: size_t; CmpProc: TCompareProc): Pointer; cdecl;
  external libc name _PU + 'bsearch';
{$EXTERNALSYM bsearch}

procedure qsort(Base: Pointer; Nel: size_t; Width: size_t; CmpProc: TCompareProc); cdecl;
  external libc name _PU + 'qsort';
{$EXTERNALSYM qsort}


function malloc(size: size_t): Pointer; cdecl;
  external libc name _PU + 'malloc';
{$EXTERNALSYM malloc}

function __malloc(size: size_t): Pointer; cdecl;
  external libc name _PU + 'malloc';
{$EXTERNALSYM __malloc}

function calloc(nelem: size_t; eltsize: size_t): Pointer; cdecl;
  external libc name _PU + 'calloc';
{$EXTERNALSYM calloc}

function realloc(P: Pointer; NewSize: size_t): Pointer; cdecl;
  external libc name _PU + 'realloc';
{$EXTERNALSYM realloc}

procedure free(p: Pointer); cdecl;
  external libc name _PU + 'free';
{$EXTERNALSYM free}

function valloc(size: size_t): Pointer; cdecl; platform;
  external libc name _PU + 'valloc';
{$EXTERNALSYM valloc}

procedure __free(p: Pointer); cdecl;
  external libc name _PU + 'free';
{$EXTERNALSYM __free}

{
  POSIX name 'exit' conflicts with Pascal reserved word.
}
procedure __exit(ExitCode: Integer); cdecl;
  external libc name _PU + 'exit';
{$EXTERNALSYM __exit}

procedure abort; cdecl;
  external libc name _PU + 'abort';
{$EXTERNALSYM abort}

function _system(Name: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'system';
{$EXTERNALSYM _system}

function mkstemp(template: MarshaledAString): Integer; cdecl;
  external libc name _PU + 'mkstemp';
{$EXTERNALSYM mkstemp}

{$IFNDEF ANDROID}
// LibC implementation defines MB_CUR_MAX to call these
function __ctype_get_mb_cur_max: size_t;
  external libc name _PU +
{$IFDEF MACOS}
                           '___mb_cur_max';
{$ELSE !MACOS}
                           '__ctype_get_mb_cur_max';
{$ENDIF}
{$EXTERNALSYM __ctype_get_mb_cur_max}

function MB_CUR_MAX: size_t; cdecl;
  external libc name _PU +
{$IFDEF MACOS}
                           '___mb_cur_max';
{$ELSE !MACOS}
                           '__ctype_get_mb_cur_max';
{$ENDIF}
{$EXTERNALSYM MB_CUR_MAX}

{$ENDIF !ANDROID}
