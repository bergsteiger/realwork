{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.SysSelect;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.SysTime, Posix.Time, Posix.Signal;

{$IFDEF MACOS}
{$I osx/SysSelectTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/SysSelectTypes.inc}
{$ENDIF LINUX}

{$I SysSelectAPI.inc}

{ Access macros for `fd_set'.  }
procedure __FD_ZERO(var fdset: fd_set);
procedure __FD_SET(fd: Integer; var fdset: fd_set);
procedure __FD_CLR(fd: Integer; var fdset: fd_set);
function __FD_ISSET(fd: Integer; const fdset: fd_set): Boolean;

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


end.
