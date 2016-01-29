{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

// system.pas uses this one?
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
  
function mblen(const S: MarshaledAString; N: LongWord): Integer; cdecl;
  external libc name _PU + 'mblen';
{$EXTERNALSYM mblen}

function malloc(size: size_t): Pointer; cdecl;
  external libc name _PU + 'malloc';
{$EXTERNALSYM malloc}

// TODO: system.pas uses this one - investigate
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

// TODO: system.pas uses this one (name collision issue?)
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


// LibC implementation defines MB_CUR_MAX to call these
{$IFDEF MACOS}
function __ctype_get_mb_cur_max: size_t;        external libc name _PU + '___mb_cur_max';
{$EXTERNALSYM __ctype_get_mb_cur_max}
{$ELSE !MACOS}
function __ctype_get_mb_cur_max: size_t;        external libc name _PU + '_ctype_get_mb_cur_max';
{$EXTERNALSYM __ctype_get_mb_cur_max}
{$ENDIF}

{$IFDEF MACOS}
function MB_CUR_MAX: size_t; cdecl;
  external libc name _PU + '___mb_cur_max';
{$EXTERNALSYM MB_CUR_MAX}
{$ELSE !MACOS}
function MB_CUR_MAX: size_t; cdecl;
  external libc name _PU + '_ctype_get_mb_cur_max';
{$EXTERNALSYM MB_CUR_MAX}
{$ENDIF}
