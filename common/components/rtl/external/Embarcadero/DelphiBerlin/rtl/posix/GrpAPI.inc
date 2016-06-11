{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$IFNDEF ANDROID}
{ Rewind the group-file stream.  }
procedure setgrent; cdecl;
  external libc name _PU + 'setgrent';
{$EXTERNALSYM setgrent}

{ Close the group-file stream.  }
procedure endgrent; cdecl;
  external libc name _PU + 'endgrent';
{$EXTERNALSYM endgrent}

{ Read an entry from the group-file stream, opening it if necessary.  }
function getgrent: Pgroup; cdecl;
  external libc name _PU + 'getgrent';
{$EXTERNALSYM getgrent}

{ Search for an entry with a matching group ID.  }
function getgrgid_r(gid: gid_t; var ResultBuf: group; Buffer: MarshaledAString;
  BufLen: size_t; var __result: Pgroup): Integer; cdecl;
  external libc name _PU + 'getgrgid_r';
{$EXTERNALSYM getgrgid_r}

{ Search for an entry with a matching group name.  }
function getgrnam_r(Name: MarshaledAString; var ResultBuf: group; Buffer: MarshaledAString;
  BufLen: size_t; var __result: Pgroup): Integer; cdecl;
  external libc name _PU + 'getgrnam_r';
{$EXTERNALSYM getgrnam_r}

{$ENDIF !ANDROID}

{ Search for an entry with a matching group ID.  }
function getgrgid(gid: gid_t): Pgroup; cdecl;
  external libc name _PU + 'getgrgid';
{$EXTERNALSYM getgrgid}

{ Search for an entry with a matching group name.  }
function getgrnam(Name: MarshaledAString): Pgroup; cdecl;
  external libc name _PU + 'getgrnam';
{$EXTERNALSYM getgrnam}
