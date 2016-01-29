{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


{ Check the first NFDS descriptors each in READFDS (if not NULL) for read
   readiness, in WRITEFDS (if not NULL) for write readiness, and in EXCEPTFDS
   (if not NULL) for exceptional conditions.  If TIMEOUT is not NULL, time out
   after waiting the interval specified therein.  Returns the number of ready
   descriptors, or -1 for errors.  }
function select(nfds: Integer; readfds, writefds, exceptfds: Pfd_set;
  timeout: Ptimeval): Integer; cdecl;
  external libc name _PU + 'select';
{$EXTERNALSYM select}

{ XXX Once/if POSIX.1g gets official this prototype will be available
   when defining USE_POSIX.  }
{ Same as above only that the TIMEOUT value is given with higher
   resolution and a sigmask which is been set temporarily.  This version
   should be used.  }
function pselect(nfds: Integer; readfds, writefds, exceptfds: Pfd_set;
  timeout: Ptimespec; sigmask: Psigset_t): Integer; cdecl;
  external libc name _PU + 'pselect';
{$EXTERNALSYM pselect}
