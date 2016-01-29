{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


{ Rewind the password-file stream.  }
procedure setpwent(); cdecl;
  external libc name _PU + 'setpwent';
{$EXTERNALSYM setpwent}

{ Close the password-file stream.  }
procedure endpwent(); cdecl;
  external libc name _PU + 'endpwent';
{$EXTERNALSYM endpwent}

{ Read an entry from the password-file stream, opening it if necessary.  }
function getpwent(): Ppasswd; cdecl;
  external libc name _PU + 'getpwent';
{$EXTERNALSYM getpwent}

{ Search for an entry with a matching user ID.  }
function getpwuid(uid: uid_t): Ppasswd; cdecl;
  external libc name _PU + 'getpwuid';
{$EXTERNALSYM getpwuid}

{ Search for an entry with a matching username.  }
function getpwnam(Name: MarshaledAString): Ppasswd; cdecl;
  external libc name _PU + 'getpwnam';
{$EXTERNALSYM getpwnam}

function getpwuid_r(uid: uid_t; var ResultBuf: passwd; Buffer: MarshaledAString;
  BufLen: size_t; var __result: Ppasswd): Integer; cdecl;
  external libc name _PU + 'getpwuid_r';
{$EXTERNALSYM getpwuid_r}

function getpwnam_r(Name: MarshaledAString; var ResultBuf: passwd; Buffer: MarshaledAString;
  BufLen: size_t; var result: Ppasswd): Integer; cdecl;
  external libc name _PU + 'getpwnam_r';
{$EXTERNALSYM getpwnam_r}


