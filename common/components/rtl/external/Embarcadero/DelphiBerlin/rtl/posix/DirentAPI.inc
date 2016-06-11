{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

//function alphasort(const d1; const d2): Integer; //TODO: OSX
function alphasort(const d1: Pdirent; const d2: Pdirent): Integer; cdecl;
  external libc name _PU + 'alphasort' + _INODE_SUFFIX;
{$EXTERNALSYM alphasort}

{ Close the directory stream PDirectoryStream.
   Return 0 if successful, -1 if not.  }
function closedir(Handle: PDIR): Integer; cdecl;
  external libc name _PU + 'closedir';
{$EXTERNALSYM closedir}

{$IF defined(LINUX) or defined(ANDROID)}
function dirfd(dirp: PDIR): Integer; cdecl; //TODO: OSX defined as macro: ((dirp)->__dd_fd)
  external libc name _PU + 'dirfd';
{$EXTERNALSYM dirfd}

function fdopendir(FD: Integer): PDIR; cdecl; //TODO -cOSX: not defined
  external libc name _PU + 'fdopendir';
{$EXTERNALSYM fdopendir}
{$ENDIF LINUX OR ANDROID}

{ Open a directory stream on NAME.
   Return a PDirectoryStream stream on the directory, or NULL if it could not
   be opened.  }
function opendir(PathName: MarshaledAString): PDIR; cdecl;
  external libc name _PU + 'opendir';
{$EXTERNALSYM opendir}

function readdir(Handle: PDIR): Pdirent; cdecl;
  external libc name _PU + 'readdir' + _INODE_SUFFIX;
{$EXTERNALSYM readdir}

{ Reentrant version of `readdir'.  Return in RESULT a pointer to the
   next entry.  }
function readdir_r(Handle: PDIR; Entry: Pdirent;
  var __result: Pdirent): Integer; cdecl;
  external libc name _PU + 'readdir_r' + _INODE_SUFFIX;
{$EXTERNALSYM readdir_r}

procedure rewinddir(Handle: PDIR); cdecl;
  external libc name _PU + 'rewinddir';
{$EXTERNALSYM rewinddir}

function scandir(dirname: MarshaledAString; var namelist: PPdirent; SelProc: TSelectorProc; CmpProc: TCompareProc): Integer; cdecl;
  external libc name _PU + 'scandir' + _INODE_SUFFIX;
{$EXTERNALSYM scandir}

{$IFNDEF ANDROID}
procedure seekdir(Handle: PDIR; loc: Int64); cdecl;
  external libc name _PU + 'seekdir';
{$EXTERNALSYM seekdir}

function telldir(Handle: PDIR): Int64; cdecl;
  external libc name _PU + 'telldir';
{$EXTERNALSYM telldir}
{$ENDIF !ANDROID}
