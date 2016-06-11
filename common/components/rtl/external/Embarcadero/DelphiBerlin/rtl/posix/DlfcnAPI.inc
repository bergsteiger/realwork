{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ dladdr is _not_ a POSIX function, but it _is_ in both Linux and Mac OSX. }
function dladdr(Address: NativeUInt; var Info: dl_info): Integer; cdecl;
  external libdl name _PU + 'dladdr';
{$EXTERNALSYM dladdr}

function dlopen(Filename: MarshaledAString; Flag: Integer): NativeUInt; cdecl;
  external libdl name _PU + 'dlopen';
{$EXTERNALSYM dlopen}
function dlclose(Handle: NativeUInt): Integer; cdecl;
  external libdl name _PU + 'dlclose';
{$EXTERNALSYM dlclose }
function dlsym(Handle: NativeUInt; Symbol: MarshaledAString): Pointer; cdecl;
  external libdl name _PU + 'dlsym';
{$EXTERNALSYM dlsym}
function dlerror: MarshaledAString; cdecl;
  external libdl name _PU + 'dlerror';
{$EXTERNALSYM dlerror}

{$IFDEF MACOS}
function _dyld_get_image_name(image_index: Cardinal): MarshaledAString; cdecl;
  external libc name _PU + '_dyld_get_image_name';
{$EXTERNALSYM _dyld_get_image_name}
{$ENDIF}

{$IF Defined(CPUARM32) and Defined(Android)}
function dl_unwind_find_exidx(pc: NativeUInt; var pcount: integer): Pointer; cdecl;
  external libdl name _PU + 'dl_unwind_find_exidx';
{$EXTERNALSYM dl_unwind_find_exidx}
{$ENDIF}
