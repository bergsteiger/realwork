{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.SysStat;

{$WEAKPACKAGEUNIT}

interface

uses
  Posix.Base, Posix.SysTypes;

{$IFDEF MACOS}
{$I osx/SysStatTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/SysStatTypes.inc}
{$ENDIF LINUX}

{$I SysStatAPI.inc}

(*$HPPEMIT '#include <sys/stat.h>' *)
{$IFDEF MACOS}
(*$HPPEMIT 'typedef struct stat _stat;' *)
{$ENDIF MACOS}


function S_ISBLK(mode: mode_t): Boolean;
{$EXTERNALSYM S_ISBLK}
function S_ISCHR(mode: mode_t): Boolean;
{$EXTERNALSYM S_ISCHR}
function S_ISDIR(mode: mode_t): Boolean;
{$EXTERNALSYM S_ISDIR}
function S_ISFIFO(mode: mode_t): Boolean;
{$EXTERNALSYM S_ISFIFO}
function S_ISREG(mode: mode_t): Boolean;
{$EXTERNALSYM S_ISREG}
function S_ISLNK(mode: mode_t): Boolean;
{$EXTERNALSYM S_ISLNK}
function S_ISSOCK(mode: mode_t): Boolean;
{$EXTERNALSYM S_ISSOCK}

implementation

function S_ISBLK(mode: mode_t): Boolean;
{$IFDEF MACOS}
begin
  Result := (mode and S_IFMT) = S_IFBLK;
end;
{$ENDIF MACOS}
{$IFDEF LINUX}
begin
  Result := (mode and S_IFMT) = S_IFBLK;
end;
{$ENDIF LINUX}

function S_ISCHR(mode: mode_t): Boolean;
{$IFDEF MACOS}
begin
  Result := (mode and S_IFMT) = S_IFCHR;
end;
{$ENDIF MACOS}
{$IFDEF LINUX}
begin
  Result := (mode and S_IFMT) = S_IFCHR;
end;
{$ENDIF LINUX}

function S_ISDIR(mode: mode_t): Boolean;
{$IFDEF MACOS}
begin
  Result := (mode and S_IFMT) = S_IFDIR;
end;
{$ENDIF MACOS}
{$IFDEF LINUX}
begin
  Result := (mode and S_IFMT) = S_IFDIR;
end;
{$ENDIF LINUX}

function S_ISFIFO(mode: mode_t): Boolean;
{$IFDEF MACOS}
begin
  Result := (mode and S_IFMT) = S_IFIFO;
end;
{$ENDIF MACOS}
{$IFDEF LINUX}
begin
  Result := (mode and S_IFMT) = S_IFIFO;
end;
{$ENDIF LINUX}

function S_ISREG(mode: mode_t): Boolean;
{$IFDEF MACOS}
begin
  Result := (mode and S_IFMT) = S_IFREG;
end;
{$ENDIF MACOS}
{$IFDEF LINUX}
begin
  Result := (mode and S_IFMT) = S_IFREG;
end;
{$ENDIF LINUX}

function S_ISLNK(mode: mode_t): Boolean;
{$IFDEF MACOS}
begin
  Result := (mode and S_IFMT) = S_IFLNK;
end;
{$ENDIF MACOS}
{$IFDEF LINUX}
begin
  Result := (mode and S_IFMT) = S_IFLNK;
end;
{$ENDIF LINUX}

function S_ISSOCK(mode: mode_t): Boolean;
{$IFDEF MACOS}
begin
  Result := (mode and S_IFMT) = S_IFSOCK;
end;
{$ENDIF MACOS}
{$IFDEF LINUX}
begin
  Result := (mode and S_IFMT) = S_IFSOCK;
end;
{$ENDIF LINUX}

end.
