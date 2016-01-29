{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

const
  libc        = '/usr/lib/libc.dylib';
  libpthread  = '/usr/lib/libpthread.dylib';
  libiconv    = '/usr/lib/libiconv.dylib';
  libdl       = '/usr/lib/libdl.dylib';

{$IF not Declared(_PU)}
const
  // On Mac OSX, cdecl names have a preceeding underscore
  // if x86 native backend.
  {$IF Defined(UNDERSCOREIMPORTNAME)}
  _PU = '_';
  {$ELSE}
  _PU = '';
  {$ENDIF}
  {$EXTERNALSYM _PU}
{$ENDIF}

const
{$IFNDEF IOS}
  _INODE_SUFFIX = '$INODE64';
{$ELSE IOS}
  _INODE_SUFFIX = '';
{$ENDIF !IOS}
  {$EXTERNALSYM _INODE_SUFFIX}
