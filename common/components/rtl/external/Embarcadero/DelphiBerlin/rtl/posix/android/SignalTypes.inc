{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ An integral type that can be modified atomically, without the
   possibility of a signal arriving in the middle of the operation.  }
type
  sig_atomic_t = Integer;
  {$EXTERNALSYM sig_atomic_t}
  Psig_atomic_t = ^sig_atomic_t;

const
  LONG_BIT = 32 platform;
  {$EXTERNALSYM LONG_BIT}
type
  sigset_t = UInt32;
  {$EXTERNALSYM sigset_t}
  Psigset_t = ^sigset_t;

  sigval = record
    case Integer of
      0: (sival_int: Integer);
      1: (sival_ptr: Pointer);
  end;
  {$EXTERNALSYM sigval}
  sigval_t = sigval;
  Psigval = ^sigval;
const
{ Structure to transport application-defined values with signals.  }
  __SIGEV_MAX_SIZE        = 64;
  {$EXTERNALSYM __SIGEV_MAX_SIZE}
  __SIGEV_PAD_SIZE        = (__SIGEV_MAX_SIZE div SizeOf(Integer)) - 3;
  {$EXTERNALSYM __SIGEV_PAD_SIZE}
type
  TSignalEventStartProc = procedure(param: sigval_t); cdecl;

  sigev_thread_t = record
    _function: TSignalEventStartProc;
    _attribute: Pointer; // Really pthread_attr_t
  end;

  sigevent = record
    sigev_value: sigval_t;
    sigev_signo: Integer;
    sigev_notify: Integer;
    case Integer of
      0: (_pad: array[0..__SIGEV_PAD_SIZE-1] of Integer);
      1: (_tid: Integer);
      2: (_sigev_thread: sigev_thread_t);
  end;
  {$EXTERNALSYM sigevent}
  Psigevent = ^sigevent;


{ Fake signal functions.  }
const
  SIG_ERR = (-1);             { Error return.  }
  {$EXTERNALSYM SIG_ERR}
  SIG_DFL = (0);              { Default action.  }
  {$EXTERNALSYM SIG_DFL}
  SIG_IGN = (1);              { Ignore signal.  }
  {$EXTERNALSYM SIG_IGN}

{ Signals.  }
  SIGHUP          = 1;      { Hangup (POSIX).  }
  {$EXTERNALSYM SIGHUP}
  SIGINT          = 2;      { Interrupt (ANSI).  }
  {$EXTERNALSYM SIGINT}
  SIGQUIT         = 3;      { Quit (POSIX).  }
  {$EXTERNALSYM SIGQUIT}
  SIGILL          = 4;      { Illegal instruction (ANSI).  }
  {$EXTERNALSYM SIGILL}
  SIGTRAP         = 5;      { Trace trap (POSIX).  }
  {$EXTERNALSYM SIGTRAP}
  SIGABRT         = 6;      { Abort (ANSI).  }
  {$EXTERNALSYM SIGABRT}
  SIGIOT          = 6 platform;      { IOT trap (4.2 BSD).  }
  {$EXTERNALSYM SIGIOT}
  SIGBUS          = 7;      { BUS error (4.2 BSD).  }
  {$EXTERNALSYM SIGBUS}
  SIGFPE          = 8;      { Floating-point exception (ANSI).  }
  {$EXTERNALSYM SIGFPE}
  SIGKILL         = 9;      { Kill, unblockable (POSIX).  }
  {$EXTERNALSYM SIGKILL}
  SIGUSR1         = 10;     { User-defined signal 1 (POSIX).  }
  {$EXTERNALSYM SIGUSR1}
  SIGSEGV         = 11;     { Segmentation violation (ANSI).  }
  {$EXTERNALSYM SIGSEGV}
  SIGUSR2         = 12;     { User-defined signal 2 (POSIX).  }
  {$EXTERNALSYM SIGUSR2}
  SIGPIPE         = 13;     { Broken pipe (POSIX).  }
  {$EXTERNALSYM SIGPIPE}
  SIGALRM         = 14;     { Alarm clock (POSIX).  }
  {$EXTERNALSYM SIGALRM}
  SIGTERM         = 15;     { Termination (ANSI).  }
  {$EXTERNALSYM SIGTERM}
  SIGSTKFLT       = 16 platform;     { Stack fault.  }
  {$EXTERNALSYM SIGSTKFLT}
  SIGCHLD         = 17;     { Child status has changed (POSIX).  }
  {$EXTERNALSYM SIGCHLD}
  SIGCLD          = SIGCHLD; { Same as SIGCHLD (System V).  }
  {$EXTERNALSYM SIGCLD}
  SIGCONT         = 18;     { Continue (POSIX).  }
  {$EXTERNALSYM SIGCONT}
  SIGSTOP         = 19;     { Stop, unblockable (POSIX).  }
  {$EXTERNALSYM SIGSTOP}
  SIGTSTP         = 20;     { Keyboard stop (POSIX).  }
  {$EXTERNALSYM SIGTSTP}
  SIGTTIN         = 21;     { Background read from tty (POSIX).  }
  {$EXTERNALSYM SIGTTIN}
  SIGTTOU         = 22;     { Background write to tty (POSIX).  }
  {$EXTERNALSYM SIGTTOU}
  SIGURG          = 23;     { Urgent condition on socket (4.2 BSD).  }
  {$EXTERNALSYM SIGURG}
  SIGXCPU         = 24;     { CPU limit exceeded (4.2 BSD).  }
  {$EXTERNALSYM SIGXCPU}
  SIGXFSZ         = 25;     { File size limit exceeded (4.2 BSD).  }
  {$EXTERNALSYM SIGXFSZ}
  SIGVTALRM       = 26;     { Virtual alarm clock (4.2 BSD).  }
  {$EXTERNALSYM SIGVTALRM}
  SIGPROF         = 27 platform;     { Profiling alarm clock (4.2 BSD).  }
  {$EXTERNALSYM SIGPROF}
  SIGWINCH        = 28 platform;     { Window size change (4.3 BSD, Sun).  }
  {$EXTERNALSYM SIGWINCH}
  SIGIO           = 29 platform;     { I/O now possible (4.2 BSD).  }
  {$EXTERNALSYM SIGIO}
  SIGPOLL         = SIGIO platform;  { Pollable event occurred (System V).  }
  {$EXTERNALSYM SIGPOLL}
  SIGPWR          = 30 platform;     { Power failure restart (System V).  }
  {$EXTERNALSYM SIGPWR}
  SIGUNUSED       = 31;
  {$EXTERNALSYM SIGUNUSED}
  SIGSYS       = 31;
  {$EXTERNALSYM SIGSYS}


{ Bits in `sa_flags'.  }
const
  SA_NOCLDSTOP  = 1;         { Don't send SIGCHLD when children stop.  }
  {$EXTERNALSYM SA_NOCLDSTOP}
  SA_NOCLDWAIT  = 2;         { Don't create zombie on child death.  }
  {$EXTERNALSYM SA_NOCLDWAIT}
  SA_SIGINFO    = 4;         { Invoke signal-catching function with three arguments instead of one.  }
  {$EXTERNALSYM SA_SIGINFO}
  SA_THIRTYTWO    = $02000000;
  {$EXTERNALSYM SA_THIRTYTWO}
  SA_ONSTACK    = $08000000; { Use signal stack by using `sa_restorer'. }
  {$EXTERNALSYM SA_ONSTACK}
  SA_RESTART    = $10000000; { Restart syscall on signal return.  }
  {$EXTERNALSYM SA_RESTART}
  SA_NODEFER    = $40000000; { Don't automatically block the signal when its handler is being executed.  }
  {$EXTERNALSYM SA_NODEFER}
  SA_RESETHAND  = $80000000; { Reset to SIG_DFL on entry to handler.  }
  {$EXTERNALSYM SA_RESETHAND}
  SA_INTERRUPT  = $20000000 platform; { Historical no-op.  }
  {$EXTERNALSYM SA_INTERRUPT}

{ Some aliases for the SA_ constants.  }
  SA_NOMASK     = SA_NODEFER platform;
  {$EXTERNALSYM SA_NOMASK}
  SA_ONESHOT    = SA_RESETHAND platform;
  {$EXTERNALSYM SA_ONESHOT}
  SA_STACK      = SA_ONSTACK platform;
  {$EXTERNALSYM SA_STACK}

{ Values for the HOW argument to `sigprocmask'.  }
  SIG_BLOCK     = 0;         { Block signals.  }
  {$EXTERNALSYM SIG_BLOCK}
  SIG_UNBLOCK   = 1;         { Unblock signals.  }
  {$EXTERNALSYM SIG_UNBLOCK}
  SIG_SETMASK   = 2;         { Set the set of blocked signals.  }
  {$EXTERNALSYM SIG_SETMASK}

  MINSIGSTKSZ   = 2048;
  {$EXTERNALSYM MINSIGSTKSZ}
  SIGSTKSZ   = 8192;
  {$EXTERNALSYM SIGSTKSZ}

const
  __SI_MAX_SIZE      = 128;
  {$EXTERNALSYM __SI_MAX_SIZE}
  __SI_PAD_SIZE      = (__SI_MAX_SIZE div sizeof (Integer)) - 3;
  {$EXTERNALSYM __SI_PAD_SIZE}

type
{ siginfo nested types (_si_* ). These are not found in the header file. }
  _si_pad = packed array[0..__SI_PAD_SIZE-1] of Integer;
  {$EXTERNALSYM _si_pad}
  P_si_pad = ^_si_pad;
  {$EXTERNALSYM P_si_pad}

  { kill().  }
  _si_kill = record
    si_pid: pid_t;            { Sending process ID.  }
    si_uid: uid_t;            { Real user ID of sending process.  }
  end;
  {$EXTERNALSYM _si_kill}
  P_si_kill = ^_si_kill;
  {$EXTERNALSYM P_si_kill}

  { POSIX.1b timers.  }
  { _si_timer_pad =  packed array[0..sizeof(uid_t) - sizeof(Integer) - 1] of Byte; // _timer padding}
  _si_timer = record
    _tid: timer_t;
    _overrun: Integer;
    {_pad: _si_timer_pad; // _timer padding}
    _sigval: sigval_t;
    _sys_private: Integer;
  end;
  {$EXTERNALSYM _si_timer}
  P_si_timer = ^_si_timer;
  {$EXTERNALSYM P_si_timer}

  { POSIX.1b signals.  }
  _si_rt = record
    si_pid: pid_t;            { Sending process ID.  }
    si_uid: uid_t;            { Real user ID of sending process.  }
    si_sigval: sigval;        { Signal value.  }
  end;
  {$EXTERNALSYM _si_rt}
  P_si_rt = ^_si_rt;
  {$EXTERNALSYM P_si_rt}

  { SIGCHLD.  }
  _si_sigchld = record
    si_pid: pid_t;            { Which child.  }
    si_uid: uid_t;            { Real user ID of sending process.  }
    si_status: Integer;         { Exit value or signal.  }
    si_utime: clock_t;
    si_stime: clock_t;
  end;
  {$EXTERNALSYM _si_sigchld}
  P_si_sigchld = ^_si_sigchld;
  {$EXTERNALSYM P_si_sigchld}

  { SIGILL, SIGFPE, SIGSEGV, SIGBUS.  }
  _si_sigfault = record
    si_addr: Pointer;           { Faulting insn/memory ref.  }
  end;
  {$EXTERNALSYM _si_sigfault}
  P_si_sigfault = ^_si_sigfault;
  {$EXTERNALSYM P_si_sigfault}

  { SIGPOLL.  }
  _si_sigpoll = record
    si_band: Longint;           { Band event for SIGPOLL.  }
    si_fd: Integer;
  end;
  {$EXTERNALSYM _si_sigpoll}
  P_si_sigpoll = ^_si_sigpoll;
  {$EXTERNALSYM P_si_sigpoll}

  siginfo_t = record
    si_signo: Integer;          { Signal number.  }
    si_errno: Integer;          { If non-zero, an errno value associated with
				   this signal, as defined in <errno.h>.  }
    si_code: Integer;           { Signal code.  }
    _sifields: record
      case Integer of
        0: (_pad: _si_pad);
        1: (_kill: _si_kill);
        2: (_timer: _si_timer);
        3: (_rt: _si_rt);
        4: (_sigchld: _si_sigchld);
        5: (_sigfault: _si_sigfault);
        6: (_sigpoll: _si_sigpoll);
    end;
  end;
  {$EXTERNALSYM siginfo_t}
  Psiginfo_t = ^siginfo_t;

{ Structure describing the action to be taken when a signal arrives.  }
  TSignalHandler = procedure(SigNum: Integer); cdecl;
  TRestoreHandler = procedure; cdecl; // Used anonymously in header file
  TSigActionHandler = procedure(SigNum: Integer; SigInfo: Psiginfo_t; Context: Pointer); cdecl;
  
  { Signal handler. }
  sigaction_t = record // Renamed symbol, not in header file.
    _u: record { Pointer to a signal-catching function }
      case Integer of
        0: (sa_handler: TSignalHandler);
        1: (sa_sigaction: TSigActionHandler);
    end; 
    sa_mask: sigset_t;   { Additional set of signals to be blocked.  }
    sa_flags: Integer;   { Special flags.  }
    sa_restorer: TRestoreHandler; { Restore handler.  }
  end;
  {$EXTERNALSYM sigaction_t}
  Psigaction_t = ^sigaction_t;

  stack_t = record
    ss_sp: Pointer;
    ss_flags: Integer;
    ss_size: size_t;
  end;
  {$EXTERNALSYM stack_t}
  Pstack_t = ^stack_t;

// Translated from asm/sigcontext_t.h

type
  sigcontext_t = record
    trapno: UInt32; // trap_no
    error_code: UInt32;
    oldmask: UInt32;
    arm_r0: UInt32;
    arm_r1: UInt32;
    arm_r2: UInt32;
    arm_r3: UInt32;
    arm_r4: UInt32;
    arm_r5: UInt32;
    arm_r6: UInt32;
    arm_r7: UInt32;
    arm_r8: UInt32;
    arm_r9: UInt32;
    arm_r10: UInt32;
    arm_fp: UInt32;
    arm_ip: UInt32;
    arm_sp: UInt32;
    arm_lr: UInt32;
    arm_pc: UInt32;
    arm_cpsr: UInt32;
    fault_address: UInt32;
  end;
  {$EXTERNALSYM sigcontext_t}
  Psigcontext_t = ^sigcontext_t;

// Translated from Kernel\arch\arm\include\asm\ucontext.h

type
  Pucontext_t = ^ucontext_t;
  ucontext_t = record
    uc_flags: UInt32;
    uc_link: Pucontext_t;
    uc_stack: stack_t;
    uc_mcontext: sigcontext_t;
    uc_sigmask: sigset_t;
  end;


//{ Type for general register.  }
//type
//  greg_t = Integer;
//  {$EXTERNALSYM greg_t}
//  Pgreg_t = ^greg_t;
//
//{ Number of general registers.  }
//const
//  NGREG = 19;
//  {$EXTERNALSYM NGREG}
//
//{ Container for all general registers.  }
//type
//  gregset_t = packed array[0..NGREG-1] of greg_t;
//  {$EXTERNALSYM gregset_t}
//  Pgregset_t = ^gregset_t;
//
//{ Number of each register is the `gregset_t' array.  }
//const
//  REG_GS = 0;
//  {$EXTERNALSYM REG_GS}
//  REG_FS = 1;
//  {$EXTERNALSYM REG_FS}
//  REG_ES = 2;
//  {$EXTERNALSYM REG_ES}
//  REG_DS = 3;
//  {$EXTERNALSYM REG_DS}
//  REG_EDI = 4;
//  {$EXTERNALSYM REG_EDI}
//  REG_ESI = 5;
//  {$EXTERNALSYM REG_ESI}
//  REG_EBP = 6;
//  {$EXTERNALSYM REG_EBP}
//  REG_ESP = 7;
//  {$EXTERNALSYM REG_ESP}
//  REG_EBX = 8;
//  {$EXTERNALSYM REG_EBX}
//  REG_EDX = 9;
//  {$EXTERNALSYM REG_EDX}
//  REG_ECX = 10;
//  {$EXTERNALSYM REG_ECX}
//  REG_EAX = 11;
//  {$EXTERNALSYM REG_EAX}
//  REG_TRAPNO = 12;
//  {$EXTERNALSYM REG_TRAPNO}
//  REG_ERR = 13;
//  {$EXTERNALSYM REG_ERR}
//  REG_EIP = 14;
//  {$EXTERNALSYM REG_EIP}
//  REG_CS = 15;
//  {$EXTERNALSYM REG_CS}
//  REG_EFL = 16;
//  {$EXTERNALSYM REG_EFL}
//  REG_UESP = 17;
//  {$EXTERNALSYM REG_UESP}
//  REG_SS = 18;
//  {$EXTERNALSYM REG_SS}
//
//
//{ Definitions taken from the kernel headers.  }
//type
//  _libc_fpreg = record
//    significand: packed array[0..4-1] of Word;
//    exponent: Word;
//  end;
//  {$EXTERNALSYM _libc_fpreg}
//  P_libc_fpreg = ^_libc_fpreg;
//
//  _libc_fpstate = record
//    cw: LongWord;
//    sw: LongWord;
//    tag: LongWord;
//    ipoff: LongWord;
//    cssel: LongWord;
//    dataoff: LongWord;
//    datasel: LongWord;
//    _st: packed array[0..8-1] of _libc_fpreg;
//    status: LongWord;
//  end;
//  {$EXTERNALSYM _libc_fpstate}
//  P_libc_fpstate = ^_libc_fpstate;
//
//{ Structure to describe FPU registers.  }
//  fpregset_t = ^_libc_fpstate;
//  {$EXTERNALSYM fpregset_t}
//  Pfpregset_t = ^fpregset_t;
//
//{ Context to describe whole processor state.  }
//  mcontext_t = record
//    gregs: gregset_t;
//    { Due to Linux's history we have to use a pointer here.  The SysV/i386
//       ABI requires a struct with the values.  }
//    fpregs: fpregset_t;
//    oldmask: LongWord;
//    cr2: LongWord;
//  end;
//  {$EXTERNALSYM mcontext_t}
//  Pmcontext_t = ^mcontext_t;
//
//
//{ Userlevel context.  }
//  Pucontext_t = ^ucontext_t;
//  ucontext_t = record
//    uc_flags: LongWord;
//    uc_link: Pucontext_t;
//    uc_stack: stack_t;
//    uc_mcontext: Pmcontext_t;
//    uc_sigmask: sigset_t;
//    __fpregs_mem: _libc_fpstate;
//  end;
//  {$EXTERNALSYM ucontext_t}
//

