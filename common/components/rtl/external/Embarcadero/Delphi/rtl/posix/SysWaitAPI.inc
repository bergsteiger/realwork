{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


{ Wait for a child to die.  When one does, put its status in *STAT_LOC
   and return its process ID.  For errors, return (pid_t) -1.  }
function wait(__stat_loc: PInteger): pid_t; cdecl;
  external libc name _PU + 'wait';
{$EXTERNALSYM wait}

{ Wait for a child matching PID to die.
   If PID is greater than 0, match any process whose process ID is PID.
   If PID is (pid_t) -1, match any process.
   If PID is (pid_t) 0, match any process with the
   same process group as the current process.
   If PID is less than -1, match any process whose
   process group is the absolute value of PID.
   If the WNOHANG bit is set in OPTIONS, and that child
   is not already dead, return (pid_t) 0.  If successful,
   return PID and store the dead child's status in STAT_LOC.
   Return (pid_t) -1 for errors.  If the WUNTRACED bit is
   set in OPTIONS, return status for stopped children; otherwise don't.  }
function waitpid(__pid: pid_t; __stat_loc: PInteger; __options: Integer): pid_t; cdecl;
  external libc name _PU + 'waitpid';
{$EXTERNALSYM waitpid}

{ Wait for a childing matching IDTYPE and ID to change the status and
   place appropriate information in *INFOP.
   If IDTYPE is P_PID, match any process whose process ID is ID.
   If IDTYPE is P_PGID, match any process whose process group is ID.
   If IDTYPE is P_ALL, match any process.
   If the WNOHANG bit is set in OPTIONS, and that child
   is not already dead, clear *INFOP and return 0.  If successful, store
   exit code and status in *INFOP.  }
function waitid(__idtype: idtype_t; __id: id_t; __infop: Psiginfo_t; __options: Integer): Integer; cdecl;
  external libc name _PU + 'waitid';
{$EXTERNALSYM waitid}
