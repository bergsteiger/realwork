{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}


{
 Note:  The IEEE Std 1003.1-2008 defines other APIs, but they are all optional.  Only
 the ones below are available in all POSIX compliant systems.
}

function mmap(Addr: Pointer; Len: size_t; Prot: Integer; Flags: Integer;
              FileDes: Integer; Off: off_t): Pointer; cdecl;
  external libc name _PU + 'mmap';
{$EXTERNALSYM mmap}

function mprotect(Addr: Pointer; Len: size_t; Prot: Integer): Integer; cdecl;
  external libc name _PU + 'mprotect';
{$EXTERNALSYM mprotect}

function munmap(Addr: Pointer; Len: size_t): Integer; cdecl;
  external libc name _PU + 'munmap';
{$EXTERNALSYM munmap}

function msync(Addr: Pointer; length: size_t; flags: Integer): Integer; cdecl;
  external libc name _PU + 'msync';
{$EXTERNALSYM msync}

function mlock(Addr: Pointer; len: size_t): Integer; cdecl;
  external libc name _PU + 'mlock';
{$EXTERNALSYM mlock}

function munlock(Addr: Pointer; len: size_t): Integer; cdecl;
  external libc name _PU + 'munlock';
{$EXTERNALSYM munlock}

function madvise(Addr: Pointer; len: size_t; advice: Integer): Integer; cdecl;
  external libc name _PU + 'madvise';
{$EXTERNALSYM madvise}

