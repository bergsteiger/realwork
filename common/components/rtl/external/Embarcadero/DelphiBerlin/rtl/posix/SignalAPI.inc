{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ Install a signal handler }
function sigaction(SigNum: Integer; Action: Psigaction_t; OldAction: Psigaction_t): Integer; cdecl;
  external libc name _PU + 'sigaction';
{$EXTERNALSYM sigaction}


{$IFNDEF ANDROID} { Those functions are inline in Android }
{ Add SIGNO to SET.  }
function sigaddset(var SigSet: sigset_t; SigNum: Integer): Integer; cdecl;
  external libc name _PU + 'sigaddset';
{$EXTERNALSYM sigaddset}

{ Clear all signals from SET.  }
function sigemptyset(var SigSet: sigset_t): Integer; cdecl;
  external libc name _PU + 'sigemptyset';
{$EXTERNALSYM sigemptyset}

{ Set all signals in SET.  }
function sigfillset(var SigSet: sigset_t): Integer; cdecl;
  external libc name _PU + 'sigfillset';
{$EXTERNALSYM sigfillset}

{ Remove SIGNO from SET.  }
function sigdelset(var SigSet: sigset_t; SigNum: Integer): Integer; cdecl;
  external libc name _PU + 'sigdelset';
{$EXTERNALSYM sigdelset}

{ Return 1 if SIGNO is in SET, 0 if not.  }
function sigismember(const [Ref] SigSet: sigset_t; SigNum: Integer): Integer; cdecl;
  external libc name _PU + 'sigismember';
{$EXTERNALSYM sigismember}

{ Print a message describing the meaning of the given signal number.  }
procedure psignal(SigNum: Integer; const S: MarshaledAString); cdecl;
  external libc name _PU + 'psignal';
{$EXTERNALSYM psignal}
{$ENDIF !ANDROID}

{ Send signal SIG to process number PID.  If PID is zero,
   send SIG to all processes in the current process's process group.
   If PID is < -1, send SIG to all processes in process group - PID.  }
function kill(ProcessID: pid_t; SigNum: Integer): Integer; cdecl;
  external libc name _PU + 'kill';
{$EXTERNALSYM kill}

{ Send SIG to all processes in process group PGRP.
   If PGRP is zero, send SIG to all processes in
   the current process's process group.  }
function killpg(ProcessGrp: pid_t; SigNum: Integer): Integer; cdecl;
  external libc name _PU + 'killpg';
{$EXTERNALSYM killpg}

{ POSIX name 'raise' conflicts with Pascal raise reserved word, so we move
 this out of the namespace.}
function __raise(signal: Integer): Integer; cdecl;
  external libc name _PU + 'raise';
{.$EXTERNALSYM __raise}

{ Send signal SIGNO to the given thread. }
function pthread_kill(ThreadID: pthread_t; SigNum: Integer): Integer; cdecl;
  external libc name _PU + 'pthread_kill';
{$EXTERNALSYM pthread_kill}

{ Modify the signal mask for the calling thread.  The arguments have
   the same meaning as for sigprocmask(2). }
function pthread_sigmask(How: Integer; const NewMask: Psigset_t;
  OldMask: Psigset_t): Integer; cdecl;
  external libc name _PU + 'pthread_sigmask';
{$EXTERNALSYM pthread_sigmask}

{ Get and/or change the set of blocked signals.  }
function sigprocmask(How: Integer; SigSet: Psigset_t; OldSigSet: Psigset_t): Integer; cdecl;
  external libc name _PU + 'sigprocmask';
{$EXTERNALSYM sigprocmask}

{ Change the set of blocked signals to SET,
   wait until a signal arrives, and restore the set of blocked signals.  }
function sigsuspend(const [Ref] SigSet: sigset_t): Integer; cdecl;
  external libc name _PU + 'sigsuspend';
{$EXTERNALSYM sigsuspend}

{ Put in SET all signals that are blocked and waiting to be delivered.  }
function sigpending(var SigSet: sigset_t): Integer; cdecl;
  external libc name _PU + 'sigpending';
{$EXTERNALSYM sigpending}

{ Select any of pending signals from SET or wait for any to arrive.  }
function sigwait(const [Ref] SigSet: sigset_t; SigNum: PInteger): Integer; cdecl;
  external libc name _PU + 'sigwait';
{$EXTERNALSYM sigwait}

{ Alternate signal handler stack interface.
   This interface should always be preferred over `sigstack'.  }
function sigaltstack(SS: Pstack_t; OSS: Pstack_t): Integer; cdecl;
  external libc name _PU + 'sigaltstack';
{$EXTERNALSYM sigaltstack}

{ Set the handler for the signal SIG to HANDLER, returning the old
   handler, or SIG_ERR on error.  By default `signal' has the BSD semantic.  }
function signal(SigNum: Integer; Handler: TSignalHandler): TSignalHandler; cdecl;
{$IFDEF ANDROID}
  external libc name _PU + 'bsd_signal';
{$ELSE}
  external libc name _PU + 'signal';
{$ENDIF ANDROID}  
{$EXTERNALSYM signal}

(*TODO -otgerdes -cHeader Translation: missing functions:
void   psiginfo(const siginfo_t *, const char * );

{ Send signal SIG to the process PID.  Associate data in VAL with the signal.  }
function sigqueue(ProcessID: pid_t; SigNum: Integer; Val: sigval): Integer; cdecl;
{$EXTERNALSYM sigqueue}

{ Select any of pending signals from SET and place information in INFO.
   Wait the time specified by TIMEOUT if no signal is pending.  }
function sigtimedwait(const SigSet: TSigset; SigInfo: PSigInfo;
  Timeout: PTimeSpec): Integer; cdecl;
{$EXTERNALSYM sigtimedwait}

{ Select any of pending signals from SET and place information in INFO.  }
function sigwaitinfo(const SigSet: TSigset; SigInfo: PSigInfo): Integer; cdecl;
{$EXTERNALSYM sigwaitinfo}
*)
