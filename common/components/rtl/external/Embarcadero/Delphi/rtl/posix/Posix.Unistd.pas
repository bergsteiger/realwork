{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.Unistd;

{$WEAKPACKAGEUNIT}

interface

uses Posix.Base, Posix.SysTypes, Posix.Stdio;

{$IFDEF MACOS}
{$I osx/UnistdTypes.inc}
{$ENDIF MACOS}
{$IFDEF LINUX}
{$I linux/UnistdTypes.inc}
{$ENDIF LINUX}

{$IFDEF MACOS}
{$I CrtexternsAPI.inc}
{$ENDIF MACOS}

{$I UnistdAPI.inc}

(*$HPPEMIT '#include <unistd.h>' *)

function environ: PMarshaledAString; inline;
{$EXTERNALSYM environ}

{$IFDEF MACOS}
{ Simulates the euidaccess function that is present only on LINUX systems. }
function euidaccess(Name: MarshaledAString; Mode: Integer): Integer;
{$ENDIF MACOS}

implementation

{$IFDEF MACOS}
uses
  Posix.SysStat, Posix.Errno;
{$ENDIF MACOS}

function environ: PMarshaledAString;
begin
{$IFDEF MACOS}
  Result := PMarshaledAString(__NSGetEnviron()^);
{$ENDIF MACOS}
{$IFDEF LINUX}
  Result := PPAnsiChar(@__Environ);
{$ENDIF LINUX}
end;

{$IFDEF MACOS}
function euidaccess(Name: MarshaledAString; Mode: Integer): Integer;

  { Checks if a user is a member of a UNIX group }
  function IsMemberOf(AGID: gid_t): Boolean;
  var
    LGroupCount, I: Integer;
    LGroups: array of gid_t;
  begin
    { Default: not found }
    Result := false;

    { Get the number of groups for current user }
    LGroupCount := getgroups(0, nil);

    { Fail if something went wrong }
    if LGroupCount < 0 then
      Exit;

    { Obtain memory for the group info }
    SetLength(LGroups, LGroupCount);

    { Actually read the group info }
    LGroupCount := getgroups(LGroupCount, Addr(LGroups[0]));

    if LGroupCount < 1 then
      Exit;

    { Search the group list for the group we want to check }
    for I := 0 to LGroupCount - 1 do
      if LGroups[I] = AGID then
        Result := true;
  end;

  procedure TestPerm(Condition: Boolean; Perm: Integer; AStat: _stat;
    var Success: Boolean);
  begin
    if Condition then
      Success := Success and ((AStat.st_mode and Perm) = Perm);
  end;

var
  LRealUID, LEffectiveUID: uid_t;
  LRealGID, LEffectiveGID: gid_t;
  LCkRead, LCkWrite, LCkExec: Boolean;
  LSuccess: Boolean;
  LStat: _stat;
begin
  { Obtain user and gorup ids }
  LRealUID := getuid();
  LRealGID := getgid();
  LEffectiveUID := geteuid();
  LEffectiveGID := getegid();

  { In most cases, read u(g)id = eff u(g)id. So call access in these cases. }
  if ((LRealUID = LEffectiveUID) and (LRealGID = LEffectiveGID)) then
    Exit(access(Name, Mode));

  { Obtain file information. Return -1 if failed to. }
  if stat(Name, LStat) <> 0 then
    Exit(-1);

  { See what we need to check }
  LCkRead := ((Mode and R_OK) = R_OK);
  LCkWrite := ((Mode and W_OK) = W_OK);
  LCkExec := ((Mode and X_OK) = X_OK);

  { If nothing to check exit (return 0 since the file is found). }
  if (not LCkRead) and (not LCkWrite) and (not LCkExec) then
    Exit(0);

  { If the effective UID is ROOT, it can do anything and can execute anything (if marked so) }
  if (LEffectiveUID = 0) then
  begin
    { If checking for execute, do some more checks. }
    if LCkExec then
    begin
      if ((LStat.st_mode and S_IXUSR) = S_IXUSR) or
         ((LStat.st_mode and S_IXGRP) = S_IXGRP) or
         ((LStat.st_mode and S_IXOTH) = S_IXOTH)
      then
        Exit(0) // Have Xecute access
      else
        Exit(-1); // No Xecute access ... fail.

    end else
      Exit(0); // Otherwise all is fine
  end;

  LSuccess := true;

  { Check permissions based on effective user }
  if LEffectiveUID = LStat.st_uid then
  begin
    { Same user. Check permissions directly. }
    TestPerm(LCkRead, S_IRUSR, LStat, LSuccess);
    TestPerm(LCkWrite, S_IWUSR, LStat, LSuccess);
    TestPerm(LCkExec, S_IXUSR, LStat, LSuccess);
  end
  else if (LEffectiveGID = LStat.st_gid) or (IsMemberOf(LStat.st_gid)) then
  begin
    { Same Group or member of file's group. Check permissions. }
    TestPerm(LCkRead, S_IRGRP, LStat, LSuccess);
    TestPerm(LCkWrite, S_IWGRP, LStat, LSuccess);
    TestPerm(LCkExec, S_IXGRP, LStat, LSuccess);
  end else
  begin
    { No direct relationship with the file. Check "other" permissions. }
    TestPerm(LCkRead, S_IROTH, LStat, LSuccess);
    TestPerm(LCkWrite, S_IWOTH, LStat, LSuccess);
    TestPerm(LCkExec, S_IXOTH, LStat, LSuccess);
  end;

  { Check success state }
  if LSuccess then
    Result := 0
  else
  begin
    SetLastError(EACCES);
    Result := -1;
  end;
end;
{$ENDIF MACOS}

end.
