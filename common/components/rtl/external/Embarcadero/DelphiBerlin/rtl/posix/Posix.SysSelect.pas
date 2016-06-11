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

unit Posix.SysSelect;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base, Posix.SysTime, Posix.Time, Posix.Signal;

{$IFDEF MACOS}
{$I osx/SysSelectTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/SysSelectTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/SysSelectTypes.inc}
{$ENDIF}

{$I SysSelectAPI.inc}

{ Access macros for `fd_set'.  }
procedure __FD_ZERO(var fdset: fd_set);
{$IFDEF ANDROID}
{$EXTERNALSYM __FD_ZERO}
{$ENDIF ANDROID}
procedure __FD_SET(fd: Integer; var fdset: fd_set);
{$IFDEF ANDROID}
{$EXTERNALSYM __FD_SET}
{$ENDIF ANDROID}
procedure __FD_CLR(fd: Integer; var fdset: fd_set);
{$IFDEF ANDROID}
{$EXTERNALSYM __FD_CLR}
{$ENDIF ANDROID}
function __FD_ISSET(fd: Integer; const fdset: fd_set): Boolean;
{$IFDEF ANDROID}
{$EXTERNALSYM __FD_ISSET}
{$ENDIF ANDROID}

procedure FD_ZERO(var fdset: fd_set); inline;
{$EXTERNALSYM FD_ZERO}
procedure _FD_SET(fd: Integer; var fdset: fd_set); inline;
{$EXTERNALSYM _FD_SET}
procedure FD_CLR(fd: Integer; var fdset: fd_set); inline;
{$EXTERNALSYM FD_CLR}
function FD_ISSET(fd: Integer; const fdset: fd_set): Boolean; inline;
{$EXTERNALSYM FD_ISSET}


implementation



function __FDELT(d: Integer): Integer;
begin
  Result := d div NFDBITS;
end;

function __FDMASK(d: Integer): fd_mask;
begin
  Result := 1 shl (d mod NFDBITS);
end;

procedure __FD_ZERO(var fdset: fd_set);
var
  I: Integer;
begin
  with fdset do
    for I := Low(fds_bits) to High(fds_bits) do
      fds_bits[I] := 0;
end;

procedure __FD_SET(fd: Integer; var fdset: fd_set);
begin
  fdset.fds_bits[__FDELT(fd)] := fdset.fds_bits[__FDELT(fd)] or __FDMASK(fd);
end;

procedure __FD_CLR(fd: Integer; var fdset: fd_set);
begin
  fdset.fds_bits[__FDELT(fd)] := fdset.fds_bits[__FDELT(fd)] and (not __FDMASK(fd));
end;

function __FD_ISSET(fd: Integer; const fdset: fd_set): Boolean;
begin
  Result := (fdset.fds_bits[__FDELT(fd)] and __FDMASK(fd)) <> 0;
end;

procedure FD_ZERO(var fdset: fd_set);
begin
  __FD_ZERO(fdset);
end;

procedure _FD_SET(fd: Integer; var fdset: fd_set);
begin
  __FD_SET(fd, fdset);
end;

procedure FD_CLR(fd: Integer; var fdset: fd_set);
begin
  __FD_CLR(fd, fdset);
end;

function FD_ISSET(fd: Integer; const fdset: fd_set): Boolean;
begin
  result := __FD_ISSET(fd, fdset);
end;


end.
