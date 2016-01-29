{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

type
  sig_atomic_t = Integer;
  {$EXTERNALSYM sig_atomic_t}
  Psig_atomic_t = ^sig_atomic_t;
  
  sigset_t = Uint32;
  {$EXTERNALSYM sigset_t}
  Psigset_t = ^sigset_t;

  sigval = record
    case Integer of
      0: (sival_int: Integer);
      1: (sival_ptr: Pointer);
  end;
  {$EXTERNALSYM sigval}

  TSignalEventStartProc = procedure(param: sigval); cdecl;

  sigevent = record
    sigev_notify: Integer;
    sigev_signo: Integer;
    sigev_value: sigval;
    sigev_notify_function: TSignalEventStartProc;
    sigev_notify_attributes: Ppthread_attr_t;
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
  SIG_HOLD = (5);             { Add signal to hold mask.  }
  {$EXTERNALSYM SIG_HOLD}

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
  SIGIOT          = SIGABRT platform;{ IOT trap (4.2 BSD, Darwin).  }
  {$EXTERNALSYM SIGIOT}
  SIGEMT          = 7 platform;      { EMT instruction (Darwin) }
  {$EXTERNALSYM SIGEMT}
  SIGFPE          = 8;      { Floating-point exception (ANSI).  }
  {$EXTERNALSYM SIGFPE}
  SIGKILL         = 9;      { Kill, unblockable (POSIX).  }
  {$EXTERNALSYM SIGKILL}
  SIGBUS          = 10;     { Bus error. }
  {$EXTERNALSYM SIGBUS}
  SIGSEGV         = 11;     { Segmentation violation (ANSI).  }
  {$EXTERNALSYM SIGSEGV}
  SIGSYS          = 12;     { Bad argument to system call.  }
  {$EXTERNALSYM SIGSYS}
  SIGPIPE         = 13;     { Broken pipe (POSIX).  }
  {$EXTERNALSYM SIGPIPE}
  SIGALRM         = 14;     { Alarm clock (POSIX).  }
  {$EXTERNALSYM SIGALRM}
  SIGTERM         = 15;     { Termination (ANSI).  }
  {$EXTERNALSYM SIGTERM}
  SIGURG          = 16;     { Urgent condition on IO channel.  }
  {$EXTERNALSYM SIGURG}
  SIGSTOP         = 17;     { Sendable stop signal not from tty. }
  {$EXTERNALSYM SIGSTOP}
  SIGTSTP         = 18;     { Stop signal from tty.  }
  {$EXTERNALSYM SIGTSTP}
  SIGCONT         = 19;     { Continue a stopped process. }
  {$EXTERNALSYM SIGCONT}
  SIGCHLD         = 20;     { To parent on child stop or exit. }
  {$EXTERNALSYM SIGCHLD}
  SIGTTIN         = 21;     { Background read from tty (POSIX).  }
  {$EXTERNALSYM SIGTTIN}
  SIGTTOU         = 22;     { Background write to tty (POSIX).  }
  {$EXTERNALSYM SIGTTOU}
  SIGIO           = 23  platform;     { Input/output possible signal (Darwin). }
  {$EXTERNALSYM SIGIO}
  SIGXCPU         = 24;     { CPU limit exceeded (4.2 BSD).  }
  {$EXTERNALSYM SIGXCPU}
  SIGXFSZ         = 25;     { File size limit exceeded (4.2 BSD).  }
  {$EXTERNALSYM SIGXFSZ}
  SIGVTALRM       = 26;     { Virtual alarm clock (4.2 BSD).  }
  {$EXTERNALSYM SIGVTALRM}
  SIGPROF         = 27;     { Profiling alarm clock (4.2 BSD).  }
  {$EXTERNALSYM SIGPROF}
  SIGWINCH        = 28 platform;     { Window size change (4.3 BSD, Sun, Darwin).  }
  {$EXTERNALSYM SIGWINCH}
  SIGINFO         = 29 platform;     { Information request (Darwin).  }
  {$EXTERNALSYM SIGINFO}
  SIGUSR1         = 30;     { User defined signal 1 (Darwin).  }
  {$EXTERNALSYM SIGUSR1}
  SIGUSR2         = 31;     { User defined signal 2 (Darwin). }
  {$EXTERNALSYM SIGUSR2}

type
  TSigActionHandler = procedure(Signal: Integer); cdecl; // Used anonymously in header file
  sigaction_t = record
    __sigaction_handler: TSigActionHandler;
    sa_mask: sigset_t;
    sa_flags: Integer
  end;
  {$EXTERNALSYM sigaction_t}
  Psigaction_t = ^sigaction_t;

const 
  SA_ONSTACK   = $0001;  { take signal on signal stack }
  {$EXTERNALSYM SA_ONSTACK}
  SA_RESTART   = $0002;  { restart system on signal return }
  {$EXTERNALSYM SA_RESTART}
  SA_RESETHAND = $0004;  { reset to SIG_DFL when taking signal }
  {$EXTERNALSYM SA_RESETHAND}
  SA_NOCLDSTOP = $0008;  { do not generate SIGCHLD on child stop }
  {$EXTERNALSYM SA_NOCLDSTOP}
  SA_NODEFER   = $0010;  { don't mask the signal we're delivering }
  {$EXTERNALSYM SA_NODEFER}
  SA_NOCLDWAIT = $0020;  { don't keep zombies around }
  {$EXTERNALSYM SA_NOCLDWAIT}
  SA_SIGINFO   = $0040;  { signal handler with SA_SIGINFO args }
  {$EXTERNALSYM SA_SIGINFO}
  SS_ONSTACK  = $0001; { take signal on signal stack }
  {$EXTERNALSYM SS_ONSTACK}
  SS_DISABLE  = $0004; { disable taking signals on alternate stack }
  {$EXTERNALSYM SS_DISABLE}
  MINSIGSTKSZ = 32768; { (32K)minimum allowable stack }
  {$EXTERNALSYM MINSIGSTKSZ}
  SIGSTKSZ    = 131072; { (128K)recommended stack size }
  {$EXTERNALSYM SIGSTKSZ}


  SIG_BLOCK     = 1;         { Block signals.  }
  {$EXTERNALSYM SIG_BLOCK}
  SIG_UNBLOCK   = 2;         { Unblock signals.  }
  {$EXTERNALSYM SIG_UNBLOCK}
  SIG_SETMASK   = 3;         { Set the set of blocked signals.  }
  {$EXTERNALSYM SIG_SETMASK}

type
{$IF     defined(CPUARM)}
  arm_exception_state = record
    __exception: UInt32;
    __fsr: UInt32;
    __far: UInt32;
  end;
  {$EXTERNALSYM arm_exception_state}
  Pexception_state = ^arm_exception_state;
  
  arm_thread_state = record
    __r: array[0..12] of UInt32;
    __sp: UInt32;
    __lr: UInt32;
    __pc: UInt32;
    __cpsr: UInt32;
  end;
  {$EXTERNALSYM arm_thread_state}
  Pthread_state = ^arm_thread_state;
  
  arm_vfp_state = record
    __r: array[0..63] of UInt32;
    __fpscr: UInt32;
  end;
  {$EXTERNALSYM arm_vfp_state}
  Pvfp_state = ^arm_vfp_state;
  
{$ELSEIF defined(CPUX86)}
  x86_exception_state = record
    __trapno: Uint32;
    __err: Uint32;
    __faultvaddr: Uint32
  end;
  {$EXTERNALSYM x86_exception_state}
  Pexception_state = ^x86_exception_state;
  
  x86_thread_state = record
    __eax: Uint32;
    __ebx: Uint32;
    __ecx: Uint32;
    __edx: Uint32;
    __edi: Uint32;
    __esi: Uint32;
    __ebp: Uint32;
    __esp: Uint32;
    __ss: Uint32;
    __eflags: Uint32;
    __eip: Uint32;
    __cs: Uint32;
    __ds: Uint32;
    __es: Uint32;
    __fs: Uint32;
    __gs: Uint32
  end;
  {$EXTERNALSYM x86_thread_state}
  Pthread_state = ^x86_thread_state;
  
  mmst_reg = record
    __mmst_reg: array [0..9] of Byte;
    __mmst_rsrv: array [0..5] of Byte;
  end;
  {$EXTERNALSYM mmst_reg}
  Pmmst_reg = ^mmst_reg;
  
  xmm_reg = record
    __xmm_reg: array [0..15] of Byte;
  end;
  {$EXTERNALSYM xmm_reg}
  Pxmm_reg = ^xmm_reg;
  
  x86_float_state = record
    __fpu_reserved: array [0..1] of Integer;
    __fpu_fcw: Uint16;
    __fpu_fsw: Uint16;
    __fpu_ftw: Byte;
    __fpu_rsrv1: Byte;
    __fpu_fop: Uint16;
    __fpu_ip: Uint32;
    __fpu_cs: Uint16;
    __fpu_rsrv2: Uint16;
    __fpu_dp: Uint32;
    __fpu_ds: Uint16;
    __fpu_rsrv3: Uint16;
    __fpu_mxcsr: Uint32;
    __fpu_mxcsrmask: Uint32;
    __fpu_stmm0: mmst_reg;
    __fpu_stmm1: mmst_reg;
    __fpu_stmm2: mmst_reg;
    __fpu_stmm3: mmst_reg;
    __fpu_stmm4: mmst_reg;
    __fpu_stmm5: mmst_reg;
    __fpu_stmm6: mmst_reg;
    __fpu_stmm7: mmst_reg;
    __fpu_xmm0: xmm_reg;
    __fpu_xmm1: xmm_reg;
    __fpu_xmm2: xmm_reg;
    __fpu_xmm3: xmm_reg;
    __fpu_xmm4: xmm_reg;
    __fpu_xmm5: xmm_reg;
    __fpu_xmm6: xmm_reg;
    __fpu_xmm7: xmm_reg;
    __fpu_rsrv4: array [0..223] of Byte;
    __fpu_reserved1: Integer;
  end;
  {$EXTERNALSYM x86_float_state}
  Pfloat_state = ^x86_float_state;
{$ENDIF }

{$IF     defined(CPUARM)}
{$ELSEIF defined(CPUX86)}
{$ENDIF }

{$IF     defined(CPUARM)}
  _STRUCT_MCONTEXT = record
    __es: arm_exception_state;
    __ss: arm_thread_state;
    __fs: arm_vfp_state;
  end;
  {$EXTERNALSYM _STRUCT_MCONTEXT}
{$ELSEIF defined(CPUX86)}
  _STRUCT_MCONTEXT32 = record
    __es: x86_exception_state;
    __ss: x86_thread_state;
    __fs: x86_float_state;
  end;
  {$EXTERNALSYM _STRUCT_MCONTEXT32}
{$ENDIF }

{$IF     defined(CPUARM)}
  mcontext_t = ^_STRUCT_MCONTEXT;
{$ELSEIF defined(CPUX86)}
  mcontext_t = ^_STRUCT_MCONTEXT32;
{$ENDIF }
  {$EXTERNALSYM mcontext_t}


  Pmcontext_t = mcontext_t;

  _sigaltstack = record
    ss_sp: Pointer;
    ss_size: Longint;
    ss_flags: Integer
  end;
  {.$EXTERNALSYM sigaltstack}
  stack_t = _sigaltstack;
  {$EXTERNALSYM stack_t}
  Pstack_t = ^stack_t;
  
  Pucontext_t = ^ucontext_t;
  ucontext_t = record
    uc_onstack: Integer;
    uc_sigmask: sigset_t;
    uc_stack: _sigaltstack;
    uc_link: Pucontext_t;
    uc_mcsize: Longint;
    uc_mcontext: Pmcontext_t
  end;
  {$EXTERNALSYM ucontext_t}
  
  siginfo_t = record
    si_signo: Integer;
    si_errno: Integer;
    si_code: Integer;
    si_pid: pid_t;
    si_uid: uid_t;
    si_status: Integer;
    si_addr: Pointer;
    si_value: Pointer;
    si_band: Longint;
    __pad: array [0..6] of Uint32;
  end;
  {$EXTERNALSYM siginfo_t}
  Psiginfo_t = ^siginfo_t;

  TSignalHandler = procedure(SigNum: Integer); cdecl;
