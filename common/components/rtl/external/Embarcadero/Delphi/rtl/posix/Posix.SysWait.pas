{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.SysWait;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.SysTypes, Posix.Signal;

{$IFDEF MACOS}
{$I osx/SysWaitTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/SysWaitTypes.inc}
{$ENDIF LINUX}

{$I SysWaitAPI.inc}

{ If WEXITSTATUS(STATUS), the low-order 8 bits of the status.  }
function WEXITSTATUS(Status: Integer): Integer;
{$EXTERNALSYM WEXITSTATUS}

{ Nonzero if STATUS indicates normal termination.  }
function WIFEXITED(Status: Integer): Boolean; //!! Integer?
{$EXTERNALSYM WIFEXITED}

{ Nonzero if STATUS indicates termination by a signal.  }
function WIFSIGNALED(Status: Integer): Boolean; //!! Integer?
{$EXTERNALSYM WIFSIGNALED}

{ Nonzero if STATUS indicates the child is stopped.  }
function WIFSTOPPED(Status: Integer): Boolean; //!! Integer?
{$EXTERNALSYM WIFSTOPPED}

{ If WSTOPSIG(STATUS), the signal that stopped the child.  }
function WSTOPSIG(Status: Integer): Integer;
{$EXTERNALSYM WSTOPSIG}

{ If WTERMSIG(STATUS), the terminating signal.  }
function WTERMSIG(Status: Integer): Integer;
{$EXTERNALSYM WTERMSIG}


implementation

function WEXITSTATUS(Status: Integer): Integer;
begin
  Result := (Status and $FF00) shr 8;
end;

function WIFEXITED(Status: Integer): Boolean;
begin
  Result := (WTERMSIG(Status) = 0);
end;

function WIFSIGNALED(Status: Integer): Boolean;
begin
  Result := (not WIFSTOPPED(Status)) and (not WIFEXITED(Status));
end;

function WIFSTOPPED(Status: Integer): Boolean;
begin
  Result := ((Status and $FF) = $7F);
end;

function WSTOPSIG(Status: Integer): Integer;
begin
  Result := WEXITSTATUS(Status);
end;

function WTERMSIG(Status: Integer): Integer;
begin
  Result := (Status and $7F);
end;

end.
