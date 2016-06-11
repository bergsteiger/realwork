{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.SysStat;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses
  Posix.Base, Posix.SysTypes;

{$IFDEF MACOS}
{$I osx/SysStatTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/SysStatTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/SysStatTypes.inc}
{$ENDIF}

{$I SysStatAPI.inc}

(*$HPPEMIT '#include <sys/stat.h>' *)
{$IF defined(MACOS) or defined(ANDROID)}
(*$HPPEMIT 'typedef struct stat _stat;' *)
{$ENDIF} { defined(MACOS) or defined(ANDROID) }



function S_ISBLK(mode: mode_t): Boolean; inline;
{$EXTERNALSYM S_ISBLK}
function S_ISCHR(mode: mode_t): Boolean; inline;
{$EXTERNALSYM S_ISCHR}
function S_ISDIR(mode: mode_t): Boolean; inline;
{$EXTERNALSYM S_ISDIR}
function S_ISFIFO(mode: mode_t): Boolean; inline;
{$EXTERNALSYM S_ISFIFO}
function S_ISREG(mode: mode_t): Boolean; inline;
{$EXTERNALSYM S_ISREG}
function S_ISLNK(mode: mode_t): Boolean; inline;
{$EXTERNALSYM S_ISLNK}
function S_ISSOCK(mode: mode_t): Boolean; inline;
{$EXTERNALSYM S_ISSOCK}


{$IFDEF ANDROID}
function mkfifo(PathName: MarshaledAString; Mode: mode_t): Integer; inline;
{$EXTERNALSYM mkfifo}
{$ENDIF ANDROID}

implementation

function S_ISBLK(mode: mode_t): Boolean;
begin
  Result := (mode and S_IFMT) = S_IFBLK;
end;

function S_ISCHR(mode: mode_t): Boolean;
begin
  Result := (mode and S_IFMT) = S_IFCHR;
end;

function S_ISDIR(mode: mode_t): Boolean;
begin
  Result := (mode and S_IFMT) = S_IFDIR;
end;

function S_ISFIFO(mode: mode_t): Boolean;
begin
  Result := (mode and S_IFMT) = S_IFIFO;
end;

function S_ISREG(mode: mode_t): Boolean;
begin
  Result := (mode and S_IFMT) = S_IFREG;
end;

function S_ISLNK(mode: mode_t): Boolean;
begin
  Result := (mode and S_IFMT) = S_IFLNK;
end;

function S_ISSOCK(mode: mode_t): Boolean;
begin
  Result := (mode and S_IFMT) = S_IFSOCK;
end;

{$IFDEF ANDROID}
function mkfifo(PathName: MarshaledAString; Mode: mode_t): Integer;
begin
  Result := mknod(PathName, (Mode and (S_IFMT xor $FFFFFFFF)) or S_IFIFO, 0);
end;
{$ENDIF ANDROID}

end.
