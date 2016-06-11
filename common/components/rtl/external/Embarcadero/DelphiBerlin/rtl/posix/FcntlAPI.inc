{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$IFNDEF MACOS}
function openat(Handle: Integer; Path: MarshaledAString; Flags: Integer): Integer; cdecl; varargs;
  external libc name _PU + 'openat';
{$EXTERNALSYM openat}
{$ENDIF}

function __open(PathName: MarshaledAString; Flags: Integer): Integer; cdecl; varargs;
  external libc name _PU + 'open';
{$EXTERNALSYM __open}

function open(PathName: MarshaledAString; Flags: Integer): Integer; cdecl; varargs;
  external libc name _PU + 'open';
{$EXTERNALSYM open}
{ Do the file control operation described by CMD on FD.
   The remaining arguments are interpreted depending on CMD.  }

function fcntl(Handle: Integer; Command: Integer): Integer; cdecl; varargs;
  external libc name _PU + 'fcntl';
{$EXTERNALSYM fcntl}

function creat(Path: MarshaledAString; Mode: mode_t): Integer; cdecl
  external libc name _PU + 'creat';
{$EXTERNALSYM creat}
