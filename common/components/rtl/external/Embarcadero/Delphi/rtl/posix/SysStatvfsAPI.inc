{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{ Return information about the filesystem on which FILE resides.  }
function statvfs(__file: MarshaledAString; var __buf: _statvfs): Integer; cdecl;
  external libc name _PU + 'statvfs';
{$EXTERNALSYM statvfs}

{ Return information about the filesystem containing the file FILDES refers to.  }
function fstatvfs(__fildes: Integer; var __buf: _statvfs): Integer; cdecl;
  external libc name _PU + 'fstatvfs';
{$EXTERNALSYM fstatvfs}

(* TODO: We included these in libc.pas, but they're not available on mac

function statvfs64(__file: PAnsiChar; var __buf: _statvfs64): Integer; cdecl;
  external libc name _PU + 'statvfs64';
{$EXTERNALSYM statvfs64}

function fstatvfs64(__fildes: Integer; var __buf: _statvfs64): Integer; cdecl;
  external libc name _PU + 'fstatvfs64';
{$EXTERNALSYM fstatvfs64}

*)
