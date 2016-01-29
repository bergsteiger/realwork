{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


type
  ctlname = record
    ctl_name: MarshaledAString;
    ctl_type: Integer;
  end;
  {$EXTERNALSYM ctlname}

const
  CTLTYPE        = $f;             // Mask for the type
  {$EXTERNALSYM CTLTYPE}
  CTLTYPE_NODE   = 1;              // name is a node
  {$EXTERNALSYM CTLTYPE_NODE}
  CTLTYPE_INT    = 2;              // name describes an integer
  {$EXTERNALSYM CTLTYPE_INT}
  CTLTYPE_STRING = 3;              // name describes a string
  {$EXTERNALSYM CTLTYPE_STRING}
  CTLTYPE_QUAD   = 4;              // name describes a 64-bit number
  {$EXTERNALSYM CTLTYPE_QUAD}
  CTLTYPE_OPAQUE = 5;              // name describes a structure
  {$EXTERNALSYM CTLTYPE_OPAQUE}
  CTLTYPE_STRUCT = CTLTYPE_OPAQUE; // name describes a structure
  {$EXTERNALSYM CTLTYPE_STRUCT}

  CTLFLAG_RD     = $80000000;      // Allow reads of variable
  {$EXTERNALSYM CTLFLAG_RD}
  CTLFLAG_WR     = $40000000;      // Allow writes to the variable
  {$EXTERNALSYM CTLFLAG_WR}
  CTLFLAG_RW     = (CTLFLAG_RD or CTLFLAG_WR);
  {$EXTERNALSYM CTLFLAG_RW}
  CTLFLAG_NOLOCK = $20000000;      // XXX Don't Lock
  {$EXTERNALSYM CTLFLAG_NOLOCK}
  CTLFLAG_ANYBODY= $10000000;      // All users can set this var
  {$EXTERNALSYM CTLFLAG_ANYBODY}
  CTLFLAG_SECURE = $08000000;      // Permit set only if securelevel<=0
  {$EXTERNALSYM CTLFLAG_SECURE}
  CTLFLAG_MASKED = $04000000;      // deprecated variable, do not display
  {$EXTERNALSYM CTLFLAG_MASKED}
  CTLFLAG_NOAUTO = $02000000;      // do not auto-register
  {$EXTERNALSYM CTLFLAG_NOAUTO}
  CTLFLAG_KERN   = $01000000;      // valid inside the kernel
  {$EXTERNALSYM CTLFLAG_KERN}
  CTLFLAG_LOCKED = $00800000;      // node will handle locking itself
  {$EXTERNALSYM CTLFLAG_LOCKED}
  CTLFLAG_OID2   = $00400000;      // struct sysctl_oid has version info
  {$EXTERNALSYM CTLFLAG_OID2}

  OID_AUTO       = (-1);
  {$EXTERNALSYM OID_AUTO}
  OID_AUTO_START = 100; // conventional
  {$EXTERNALSYM OID_AUTO_START}


(*
 * Top-level identifiers
 *)
  CTL_UNSPEC    = 0;              // unused
  {$EXTERNALSYM CTL_UNSPEC}
  CTL_KERN      = 1;              // "high kernel": proc, limits
  {$EXTERNALSYM CTL_KERN}
  CTL_VM        = 2;              // virtual memory
  {$EXTERNALSYM CTL_VM}
  CTL_VFS       = 3;              // file system, mount type is next
  {$EXTERNALSYM CTL_VFS}
  CTL_NET       = 4;              // network, see socket.h
  {$EXTERNALSYM CTL_NET}
  CTL_DEBUG     = 5;              // debugging parameters
  {$EXTERNALSYM CTL_DEBUG}
  CTL_HW        = 6;              // generic cpu/io
  {$EXTERNALSYM CTL_HW}
  CTL_MACHDEP   = 7;              // machine dependent
  {$EXTERNALSYM CTL_MACHDEP}
  CTL_USER      = 8;              // user-level
  {$EXTERNALSYM CTL_USER}
  CTL_MAXID     = 9;              // number of valid top-level ids
  {$EXTERNALSYM CTL_MAXID}

  CTL_NAMES: array[0..8] of ctlname = (
        ( ctl_name: nil; ctl_type: 0 ),
        ( ctl_name:'kern'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name:'vm'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name:'vfs'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name:'net'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name:'debug'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name:'hw'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name:'machdep'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name:'user'; ctl_type: CTLTYPE_NODE ));
  {$EXTERNALSYM CTL_NAMES}

(*
 * CTL_KERN identifiers
 *)
  KERN_OSTYPE               = 1;      // string: system version
  {$EXTERNALSYM KERN_OSTYPE}
  KERN_OSRELEASE            = 2;      // string: system release
  {$EXTERNALSYM KERN_OSRELEASE}
  KERN_OSREV                = 3;      // int: system revision
  {$EXTERNALSYM KERN_OSREV}
  KERN_VERSION              = 4;      // string: compile time info
  {$EXTERNALSYM KERN_VERSION}
  KERN_MAXVNODES            = 5;      // int: max vnodes
  {$EXTERNALSYM KERN_MAXVNODES}
  KERN_MAXPROC              = 6;      // int: max processes
  {$EXTERNALSYM KERN_MAXPROC}
  KERN_MAXFILES             = 7;      // int: max open files
  {$EXTERNALSYM KERN_MAXFILES}
  KERN_ARGMAX               = 8;      // int: max arguments to exec
  {$EXTERNALSYM KERN_ARGMAX}
  KERN_SECURELVL            = 9;      // int: system security level
  {$EXTERNALSYM KERN_SECURELVL}
  KERN_HOSTNAME            = 10;      // string: hostname
  {$EXTERNALSYM KERN_HOSTNAME}
  KERN_HOSTID              = 11;      // int: host identifier
  {$EXTERNALSYM KERN_HOSTID}
  KERN_CLOCKRATE           = 12;      // struct: struct clockrate
  {$EXTERNALSYM KERN_CLOCKRATE}
  KERN_VNODE               = 13;      // struct: vnode structures
  {$EXTERNALSYM KERN_VNODE}
  KERN_PROC                = 14;      // struct: process entries
  {$EXTERNALSYM KERN_PROC}
  KERN_FILE                = 15;      // struct: file entries
  {$EXTERNALSYM KERN_FILE}
  KERN_PROF                = 16;      // node: kernel profiling info
  {$EXTERNALSYM KERN_PROF}
  KERN_POSIX1              = 17;      // int: POSIX.1 version
  {$EXTERNALSYM KERN_POSIX1}
  KERN_NGROUPS             = 18;      // int: # of supplemental group ids
  {$EXTERNALSYM KERN_NGROUPS}
  KERN_JOB_CONTROL         = 19;      // int: is job control available
  {$EXTERNALSYM KERN_JOB_CONTROL}
  KERN_SAVED_IDS           = 20;      // int: saved set-user/group-ID
  {$EXTERNALSYM KERN_SAVED_IDS}
  KERN_BOOTTIME            = 21;      // struct: time kernel was booted
  {$EXTERNALSYM KERN_BOOTTIME}
  KERN_NISDOMAINNAME       = 22;      // string: YP domain name
  {$EXTERNALSYM KERN_NISDOMAINNAME}
  KERN_DOMAINNAME          = KERN_NISDOMAINNAME;
  {$EXTERNALSYM KERN_DOMAINNAME}
  KERN_MAXPARTITIONS       = 23;      // int: number of partitions/disk
  {$EXTERNALSYM KERN_MAXPARTITIONS}
  KERN_KDEBUG                      = 24;      // int: kernel trace points
  {$EXTERNALSYM KERN_KDEBUG}
  KERN_UPDATEINTERVAL      = 25;      // int: update process sleep time
  {$EXTERNALSYM KERN_UPDATEINTERVAL}
  KERN_OSRELDATE           = 26;      // int: OS release date
  {$EXTERNALSYM KERN_OSRELDATE}
  KERN_NTP_PLL             = 27;      // node: NTP PLL control
  {$EXTERNALSYM KERN_NTP_PLL}
  KERN_BOOTFILE            = 28;      // string: name of booted kernel
  {$EXTERNALSYM KERN_BOOTFILE}
  KERN_MAXFILESPERPROC     = 29;      // int: max open files per proc
  {$EXTERNALSYM KERN_MAXFILESPERPROC}
  KERN_MAXPROCPERUID       = 30;      // int: max processes per uid
  {$EXTERNALSYM KERN_MAXPROCPERUID}
  KERN_DUMPDEV             = 31;      // dev_t: device to dump on
  {$EXTERNALSYM KERN_DUMPDEV}
  KERN_IPC                 = 32;      // node: anything related to IPC
  {$EXTERNALSYM KERN_IPC}
  KERN_DUMMY               = 33;      // unused
  {$EXTERNALSYM KERN_DUMMY}
  KERN_PS_STRINGS  = 34;      // int: address of PS_STRINGS
  {$EXTERNALSYM KERN_PS_STRINGS}
  KERN_USRSTACK32  = 35;      // int: address of USRSTACK
  {$EXTERNALSYM KERN_USRSTACK32}
  KERN_LOGSIGEXIT  = 36;      // int: do we log sigexit procs?
  {$EXTERNALSYM KERN_LOGSIGEXIT}
  KERN_SYMFILE             = 37;      // string: kernel symbol filename
  {$EXTERNALSYM KERN_SYMFILE}
  KERN_PROCARGS            = 38;
  {$EXTERNALSYM KERN_PROCARGS}
                             // 39 was KERN_PCSAMPLES... now deprecated
  KERN_NETBOOT             = 40;      // int: are we netbooted? 1=yes,0=no
  {$EXTERNALSYM KERN_NETBOOT}
  KERN_PANICINFO           = 41;      // node: panic UI information
  {$EXTERNALSYM KERN_PANICINFO}
  KERN_SYSV                = 42;      // node: System V IPC information
  {$EXTERNALSYM KERN_SYSV}
  KERN_AFFINITY            = 43;      // xxx
  {$EXTERNALSYM KERN_AFFINITY}
  KERN_TRANSLATE           = 44;      // xxx
  {$EXTERNALSYM KERN_TRANSLATE}
  KERN_CLASSIC             = KERN_TRANSLATE;  // XXX backwards compat
  {$EXTERNALSYM KERN_CLASSIC}
  KERN_EXEC                = 45;      // xxx
  {$EXTERNALSYM KERN_EXEC}
  KERN_CLASSICHANDLER      = KERN_EXEC; // XXX backwards compatibility
  {$EXTERNALSYM KERN_CLASSICHANDLER}
  KERN_AIOMAX              = 46;      // int: max aio requests
  {$EXTERNALSYM KERN_AIOMAX}
  KERN_AIOPROCMAX          = 47;      // int: max aio requests per process
  {$EXTERNALSYM KERN_AIOPROCMAX}
  KERN_AIOTHREADS          = 48;      // int: max aio worker threads
  {$EXTERNALSYM KERN_AIOTHREADS}
{$IFDEF __APPLE_API_UNSTABLE}
  KERN_PROCARGS2           = 49;
  {$EXTERNALSYM KERN_PROCARGS2}
{$endif __APPLE_API_UNSTABLE}
  KERN_COREFILE            = 50;      // string: corefile format string
  {$EXTERNALSYM KERN_COREFILE}
  KERN_COREDUMP            = 51;      // int: whether to coredump at all
  {$EXTERNALSYM KERN_COREDUMP}
  KERN_SUGID_COREDUMP      = 52;      // int: whether to dump SUGID cores
  {$EXTERNALSYM KERN_SUGID_COREDUMP}
  KERN_PROCDELAYTERM       = 53;      // int: set/reset current proc for delayed termination during shutdown
  {$EXTERNALSYM KERN_PROCDELAYTERM}
  KERN_SHREG_PRIVATIZABLE  = 54;      // int: can shared regions be privatized ?
  {$EXTERNALSYM KERN_SHREG_PRIVATIZABLE}
                             // 55 was KERN_PROC_LOW_PRI_IO... now deprecated
  KERN_LOW_PRI_WINDOW      = 56;      // int: set/reset throttle window - milliseconds
  {$EXTERNALSYM KERN_LOW_PRI_WINDOW}
  KERN_LOW_PRI_DELAY       = 57;      // int: set/reset throttle delay - milliseconds
  {$EXTERNALSYM KERN_LOW_PRI_DELAY}
  KERN_POSIX               = 58;      // node: posix tunables
  {$EXTERNALSYM KERN_POSIX}
  KERN_USRSTACK64          = 59;      // LP64 user stack query
  {$EXTERNALSYM KERN_USRSTACK64}
  KERN_NX_PROTECTION       = 60;      // int: whether no-execute protection is enabled
  {$EXTERNALSYM KERN_NX_PROTECTION}
  KERN_TFP                 = 61;      // Task for pid settings
  {$EXTERNALSYM KERN_TFP}
  KERN_PROCNAME            = 62;      // setup process program  name(2*MAXCOMLEN)
  {$EXTERNALSYM KERN_PROCNAME}
  KERN_THALTSTACK          = 63;      // for compat with older x86 and does nothing
  {$EXTERNALSYM KERN_THALTSTACK}
  KERN_SPECULATIVE_READS   = 64;      // int: whether speculative reads are disabled
  {$EXTERNALSYM KERN_SPECULATIVE_READS}
  KERN_OSVERSION           = 65;      // for build number i.e. 9A127
  {$EXTERNALSYM KERN_OSVERSION}
  KERN_SAFEBOOT            = 66;      // are we booted safe?
  {$EXTERNALSYM KERN_SAFEBOOT}
  KERN_LCTX                = 67;      // node: login context
  {$EXTERNALSYM KERN_LCTX}
  KERN_RAGEVNODE           = 68;
  {$EXTERNALSYM KERN_RAGEVNODE}
  KERN_TTY                 = 69;      // node: tty settings
  {$EXTERNALSYM KERN_TTY}
  KERN_CHECKOPENEVT        = 70;      // spi: check the VOPENEVT flag on vnodes at open time
  {$EXTERNALSYM KERN_CHECKOPENEVT}
  KERN_THREADNAME          = 71;      // set/get thread name
  {$EXTERNALSYM KERN_THREADNAME}
  KERN_MAXID               = 72;      // number of valid kern ids
  {$EXTERNALSYM KERN_MAXID}
(*
 * Don't add any more sysctls like this.  Instead, use the SYSCTL_*() macros
 * and OID_AUTO. This will have the added benefit of not having to recompile
 * sysctl(8) to pick up your changes.
 *)

{$if defined(COUNT_SYSCALLS) and defined(KERNEL)}
  KERN_COUNT_SYSCALLS = (KERN_OSTYPE + 1000);        // keep called count for each bsd syscall
  {$EXTERNALSYM KERN_COUNT_SYSCALLS}
{$ENDIF}

{$IFDEF __LP64__}
  KERN_USRSTACK  = KERN_USRSTACK64;
  {$EXTERNALSYM KERN_USRSTACK}
{$else}
  KERN_USRSTACK  = KERN_USRSTACK32;
  {$EXTERNALSYM KERN_USRSTACK}
{$endif}


// KERN_RAGEVNODE types
  KERN_RAGE_PROC           = 1;
  {$EXTERNALSYM KERN_RAGE_PROC}
  KERN_RAGE_THREAD         = 2;
  {$EXTERNALSYM KERN_RAGE_THREAD}
  KERN_UNRAGE_PROC         = 3;
  {$EXTERNALSYM KERN_UNRAGE_PROC}
  KERN_UNRAGE_THREAD       = 4;
  {$EXTERNALSYM KERN_UNRAGE_THREAD}

// KERN_OPENEVT types
  KERN_OPENEVT_PROC      = 1;
  {$EXTERNALSYM KERN_OPENEVT_PROC}
  KERN_UNOPENEVT_PROC    = 2;
  {$EXTERNALSYM KERN_UNOPENEVT_PROC}

// KERN_TFP types
  KERN_TFP_POLICY                  = 1;
  {$EXTERNALSYM KERN_TFP_POLICY}

// KERN_TFP_POLICY values . All policies allow task port for self
  KERN_TFP_POLICY_DENY             = 0;       // Deny Mode: None allowed except privileged
  {$EXTERNALSYM KERN_TFP_POLICY_DENY}
  KERN_TFP_POLICY_DEFAULT          = 2;       // Default  Mode: related ones allowed and upcall authentication
  {$EXTERNALSYM KERN_TFP_POLICY_DEFAULT}

// KERN_KDEBUG types
  KERN_KDEFLAGS            = 1;
  {$EXTERNALSYM KERN_KDEFLAGS}
  KERN_KDDFLAGS            = 2;
  {$EXTERNALSYM KERN_KDDFLAGS}
  KERN_KDENABLE            = 3;
  {$EXTERNALSYM KERN_KDENABLE}
  KERN_KDSETBUF            = 4;
  {$EXTERNALSYM KERN_KDSETBUF}
  KERN_KDGETBUF            = 5;
  {$EXTERNALSYM KERN_KDGETBUF}
  KERN_KDSETUP             = 6;
  {$EXTERNALSYM KERN_KDSETUP}
  KERN_KDREMOVE            = 7;
  {$EXTERNALSYM KERN_KDREMOVE}
  KERN_KDSETREG            = 8;
  {$EXTERNALSYM KERN_KDSETREG}
  KERN_KDGETREG            = 9;
  {$EXTERNALSYM KERN_KDGETREG}
  KERN_KDREADTR            = 10;
  {$EXTERNALSYM KERN_KDREADTR}
  KERN_KDPIDTR             = 11;
  {$EXTERNALSYM KERN_KDPIDTR}
  KERN_KDTHRMAP            = 12;
  {$EXTERNALSYM KERN_KDTHRMAP}
// Don't use 13 as it is overloaded with KERN_VNODE
  KERN_KDPIDEX             = 14;
  {$EXTERNALSYM KERN_KDPIDEX}
  KERN_KDSETRTCDEC         = 15;
  {$EXTERNALSYM KERN_KDSETRTCDEC}
  KERN_KDGETENTROPY        = 16;
  {$EXTERNALSYM KERN_KDGETENTROPY}
  KERN_KDWRITETR           = 17;
  {$EXTERNALSYM KERN_KDWRITETR}
  KERN_KDWRITEMAP          = 18;
  {$EXTERNALSYM KERN_KDWRITEMAP}
{$IFDEF IOS}
  KERN_KDENABLE_BG_TRACE   = 19;
  {$EXTERNALSYM KERN_KDENABLE_BG_TRACE}
  KERN_KDDISABLE_BG_TRACE  = 20;
  {$EXTERNALSYM KERN_KDDISABLE_BG_TRACE}
{$ENDIF}


// KERN_PANICINFO types
  KERN_PANICINFO_MAXSIZE   = 1;       // quad: panic UI image size limit
  {$EXTERNALSYM KERN_PANICINFO_MAXSIZE}
  KERN_PANICINFO_IMAGE     = 2;       // panic UI in 8-bit kraw format
  {$EXTERNALSYM KERN_PANICINFO_IMAGE}

  CTL_KERN_NAMES: array[0..71] of ctlname = (
        ( ctl_name: nil; ctl_type: 0 ),
        ( ctl_name: 'ostype'; ctl_type: CTLTYPE_STRING ),
        ( ctl_name: 'osrelease'; ctl_type: CTLTYPE_STRING ),
        ( ctl_name: 'osrevision'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'version'; ctl_type: CTLTYPE_STRING ),
        ( ctl_name: 'maxvnodes'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'maxproc'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'maxfiles'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'argmax'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'securelevel'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'hostname'; ctl_type: CTLTYPE_STRING ),
        ( ctl_name: 'hostid'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'clockrate'; ctl_type: CTLTYPE_STRUCT ),
        ( ctl_name: 'vnode'; ctl_type: CTLTYPE_STRUCT ),
        ( ctl_name: 'proc'; ctl_type: CTLTYPE_STRUCT ),
        ( ctl_name: 'file'; ctl_type: CTLTYPE_STRUCT ),
        ( ctl_name: 'profiling'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name: 'posix1version'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'ngroups'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'job_control'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'saved_ids'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'boottime'; ctl_type: CTLTYPE_STRUCT ),
        ( ctl_name: 'nisdomainname'; ctl_type: CTLTYPE_STRING ),
        ( ctl_name: 'maxpartitions'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'kdebug'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'update'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'osreldate'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'ntp_pll'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name: 'bootfile'; ctl_type: CTLTYPE_STRING ),
        ( ctl_name: 'maxfilesperproc'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'maxprocperuid'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'dumpdev'; ctl_type: CTLTYPE_STRUCT ),  // we lie; don't print as int
        ( ctl_name: 'ipc'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name: 'dummy'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'dummy'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'usrstack'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'logsigexit'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'symfile'; ctl_type: CTLTYPE_STRING ),
        ( ctl_name: 'procargs'; ctl_type: CTLTYPE_STRUCT ),
        ( ctl_name: 'dummy'; ctl_type: CTLTYPE_INT ),                // deprecated pcsamples
        ( ctl_name: 'netboot'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'panicinfo'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name: 'sysv'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name: 'dummy'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'dummy'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'exec'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name: 'aiomax'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'aioprocmax'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'aiothreads'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'procargs2'; ctl_type: CTLTYPE_STRUCT ),
        ( ctl_name: 'corefile'; ctl_type: CTLTYPE_STRING ),
        ( ctl_name: 'coredump'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'sugid_coredump'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'delayterm'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'shreg_private'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'proc_low_pri_io'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'low_pri_window'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'low_pri_delay'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'posix'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name: 'usrstack64'; ctl_type: CTLTYPE_QUAD ),
        ( ctl_name: 'nx'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'tfp'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name: 'procname'; ctl_type: CTLTYPE_STRING ),
        ( ctl_name: 'threadsigaltstack'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'speculative_reads_disabled'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'osversion'; ctl_type: CTLTYPE_STRING ),
        ( ctl_name: 'safeboot'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'lctx'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name: 'rage_vnode'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'tty'; ctl_type: CTLTYPE_NODE ),
        ( ctl_name: 'check_openevt'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'thread_name'; ctl_type: CTLTYPE_STRING ));
  {$EXTERNALSYM CTL_KERN_NAMES}

(*
 * CTL_VFS identifiers
 *)
  CTL_VFS_NAMES: array [0..0] of ctlname = (
        ( ctl_name: 'vfsconf'; ctl_type: CTLTYPE_STRUCT ));
  {$EXTERNALSYM CTL_VFS_NAMES}

(*
 * KERN_PROC subtypes
 *)
  KERN_PROC_ALL            = 0;       // everything
  {$EXTERNALSYM KERN_PROC_ALL}
  KERN_PROC_PID            = 1;       // by process id
  {$EXTERNALSYM KERN_PROC_PID}
  KERN_PROC_PGRP           = 2;       // by process group id
  {$EXTERNALSYM KERN_PROC_PGRP}
  KERN_PROC_SESSION        = 3;       // by session of pid
  {$EXTERNALSYM KERN_PROC_SESSION}
  KERN_PROC_TTY            = 4;       // by controlling tty
  {$EXTERNALSYM KERN_PROC_TTY}
  KERN_PROC_UID            = 5;       // by effective uid
  {$EXTERNALSYM KERN_PROC_UID}
  KERN_PROC_RUID           = 6;       // by real uid
  {$EXTERNALSYM KERN_PROC_RUID}
  KERN_PROC_LCID           = 7;       // by login context id
  {$EXTERNALSYM KERN_PROC_LCID}

(*
 * KERN_LCTX subtypes
 *)
  KERN_LCTX_ALL            = 0;       // everything
  {$EXTERNALSYM KERN_LCTX_ALL}
  KERN_LCTX_LCID           = 1;       // by login context id
  {$EXTERNALSYM KERN_LCTX_LCID}


(*
 * KERN_PROC subtype ops return arrays of augmented proc structures:
 *)

type
  P_pcred = ^_pcred;
  P_ucred = ^_ucred;
  _pcred = record
        pc_lock: array[0..71] of Byte;     // opaque content
        pc_ucred: P_ucred;                 // Current credentials.
        p_ruid: uid_t;                     // Real user id.
        p_svuid: uid_t;                    // Saved effective user id.
        p_rgid: gid_t;                     // Real group id.
        p_svgid: gid_t;                    // Saved effective group id.
        p_refcnt: Integer;                 // Number of references.
  end;
  {$EXTERNALSYM _pcred}

  _ucred = record
        cr_ref: Cardinal;                 // reference count
        cr_uid: uid_t;                 // effective user id
        cr_ngroups: word;             // number of groups
        cr_groups: array[0..0] of gid_t;     // groups // TODO: NGROUPS
  end;
  {$EXTERNALSYM _ucred}
(* TODO -otgerdes -cTranslate: kinfo_proc (needs proc.h)
struct kinfo_proc {
        struct  extern_proc kp_proc;                    // proc structure
        struct  eproc {
                struct  proc *e_paddr;          // address of proc
                struct  session *e_sess;        // session pointer
                struct  _pcred e_pcred;         // process credentials
                struct  _ucred e_ucred;         // current credentials
                struct   vmspace e_vm;          // address space
                pid_t   e_ppid;                 // parent process id
                pid_t   e_pgid;                 // process group id
                short   e_jobc;                 // job control counter
                dev_t   e_tdev;                 // controlling tty dev
                pid_t   e_tpgid;                // tty process group id
                struct  session *e_tsess;       // tty session pointer
#define WMESGLEN        7
                char    e_wmesg[WMESGLEN+1];    // wchan message
                segsz_t e_xsize;                // text size
                short   e_xrssize;              // text rss
                short   e_xccount;              // text references
                short   e_xswrss;
                int32_t e_flag;
#define EPROC_CTTY      0x01    // controlling tty vnode active
#define EPROC_SLEADER   0x02    // session leader
#define COMAPT_MAXLOGNAME       12
                char    e_login[COMAPT_MAXLOGNAME];     // short setlogin() name
#if CONFIG_LCTX
                pid_t   e_lcid;
                int32_t e_spare[3];
#else
                int32_t e_spare[4];
#endif
        } kp_eproc;
};
*)

  kinfo_lctx = record
    id: pid_t;     // Login Context ID
    mc: integer;     // Member Count
  end;
  {$EXTERNALSYM kinfo_lctx}


(*
 * KERN_IPC identifiers
 *)
const
  KIPC_MAXSOCKBUF          = 1;       // int: max size of a socket buffer
  {$EXTERNALSYM KIPC_MAXSOCKBUF}
  KIPC_SOCKBUF_WASTE       = 2;       // int: wastage factor in sockbuf
  {$EXTERNALSYM KIPC_SOCKBUF_WASTE}
  KIPC_SOMAXCONN           = 3;       // int: max length of connection q
  {$EXTERNALSYM KIPC_SOMAXCONN}
  KIPC_MAX_LINKHDR         = 4;       // int: max length of link header
  {$EXTERNALSYM KIPC_MAX_LINKHDR}
  KIPC_MAX_PROTOHDR        = 5;       // int: max length of network header
  {$EXTERNALSYM KIPC_MAX_PROTOHDR}
  KIPC_MAX_HDR             = 6;       // int: max total length of headers
  {$EXTERNALSYM KIPC_MAX_HDR}
  KIPC_MAX_DATALEN         = 7;       // int: max length of data?
  {$EXTERNALSYM KIPC_MAX_DATALEN}
  KIPC_MBSTAT              = 8;       // struct: mbuf usage statistics
  {$EXTERNALSYM KIPC_MBSTAT}
  KIPC_NMBCLUSTERS         = 9;       // int: maximum mbuf clusters
  {$EXTERNALSYM KIPC_NMBCLUSTERS}
  KIPC_SOQLIMITCOMPAT      = 10;      // int: socket queue limit
  {$EXTERNALSYM KIPC_SOQLIMITCOMPAT}

(*
 * CTL_VM identifiers
 *)
  VM_METER         = 1;               // struct vmmeter
  {$EXTERNALSYM VM_METER}
  VM_LOADAVG       = 2;               // struct loadavg
  {$EXTERNALSYM VM_LOADAVG}
(*
 * Note: "3" was skipped sometime ago and should probably remain unused
 * to avoid any new entry from being accepted by older kernels...
 *)
  VM_MACHFACTOR    = 4;               // struct loadavg with mach factor
  {$EXTERNALSYM VM_MACHFACTOR}
  VM_SWAPUSAGE     = 5;               // total swap usage
  {$EXTERNALSYM VM_SWAPUSAGE}
  VM_MAXID         = 6;               // number of valid vm ids
  {$EXTERNALSYM VM_MAXID}

  CTL_VM_NAMES: array[0..5] of ctlname = (
        ( ctl_name: nil; ctl_type: 0 ),
        ( ctl_name: 'vmmeter'; ctl_type:  CTLTYPE_STRUCT  ),
        ( ctl_name: 'loadavg'; ctl_type:  CTLTYPE_STRUCT  ),
        ( ctl_name: nil; ctl_type: 0 ), // placeholder for "3" (see comment above)
        ( ctl_name: 'dummy'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'swapusage'; ctl_type:  CTLTYPE_STRUCT  ));
  {$EXTERNALSYM CTL_VM_NAMES}
type
  xsw_usage = record
    xsu_total: UInt64;
    xsu_avail: UInt64;
    xsu_used: UInt64;
    xsu_pagesize: UInt32;
    xsu_encrypted: Boolean;
  end;
  {$EXTERNALSYM xsw_usage}


{$ifdef __APPLE_API_PRIVATE}
// Load average structure.  Use of fixpt_t assume <sys/types.h> in scope.
// XXX perhaps we should protect fixpt_t, and define it here (or discard it)
(*  TODO:
  loadavg = record
    ldavg: array[0..2] of fixpt_t;
    fscale: LongWord;
  end;
  extern struct loadavg averunnable;
  LSCALE   = 1000;            // scaling for "fixed point" arithmetic
*)
{$endif __APPLE_API_PRIVATE}


(*
 * CTL_HW identifiers
 *)
const
  HW_MACHINE        = 1;              // string: machine class
  {$EXTERNALSYM HW_MACHINE}
  HW_MODEL          = 2;              // string: specific machine model
  {$EXTERNALSYM HW_MODEL}
  HW_NCPU           = 3;              // int: number of cpus
  {$EXTERNALSYM HW_NCPU}
  HW_BYTEORDER      = 4;              // int: machine byte order
  {$EXTERNALSYM HW_BYTEORDER}
  HW_PHYSMEM        = 5;              // int: total memory
  {$EXTERNALSYM HW_PHYSMEM}
  HW_USERMEM        = 6;              // int: non-kernel memory
  {$EXTERNALSYM HW_USERMEM}
  HW_PAGESIZE       = 7;              // int: software page size
  {$EXTERNALSYM HW_PAGESIZE}
  HW_DISKNAMES      = 8;              // strings: disk drive names
  {$EXTERNALSYM HW_DISKNAMES}
  HW_DISKSTATS      = 9;              // struct: diskstats[]
  {$EXTERNALSYM HW_DISKSTATS}
  HW_EPOCH         = 10;              // int: 0 for Legacy, else NewWorld
  {$EXTERNALSYM HW_EPOCH}
  HW_FLOATINGPT    = 11;              // int: has HW floating point?
  {$EXTERNALSYM HW_FLOATINGPT}
  HW_MACHINE_ARCH  = 12;              // string: machine architecture
  {$EXTERNALSYM HW_MACHINE_ARCH}
  HW_VECTORUNIT    = 13;              // int: has HW vector unit?
  {$EXTERNALSYM HW_VECTORUNIT}
  HW_BUS_FREQ      = 14;              // int: Bus Frequency
  {$EXTERNALSYM HW_BUS_FREQ}
  HW_CPU_FREQ      = 15;              // int: CPU Frequency
  {$EXTERNALSYM HW_CPU_FREQ}
  HW_CACHELINE     = 16;              // int: Cache Line Size in Bytes
  {$EXTERNALSYM HW_CACHELINE}
  HW_L1ICACHESIZE  = 17;              // int: L1 I Cache Size in Bytes
  {$EXTERNALSYM HW_L1ICACHESIZE}
  HW_L1DCACHESIZE  = 18;              // int: L1 D Cache Size in Bytes
  {$EXTERNALSYM HW_L1DCACHESIZE}
  HW_L2SETTINGS    = 19;              // int: L2 Cache Settings
  {$EXTERNALSYM HW_L2SETTINGS}
  HW_L2CACHESIZE   = 20;              // int: L2 Cache Size in Bytes
  {$EXTERNALSYM HW_L2CACHESIZE}
  HW_L3SETTINGS    = 21;              // int: L3 Cache Settings
  {$EXTERNALSYM HW_L3SETTINGS}
  HW_L3CACHESIZE   = 22;              // int: L3 Cache Size in Bytes
  {$EXTERNALSYM HW_L3CACHESIZE}
  HW_TB_FREQ       = 23;              // int: Bus Frequency
  {$EXTERNALSYM HW_TB_FREQ}
  HW_MEMSIZE       = 24;              // uint64_t: physical ram size
  {$EXTERNALSYM HW_MEMSIZE}
  HW_AVAILCPU      = 25;              // int: number of available CPUs
  {$EXTERNALSYM HW_AVAILCPU}
  HW_MAXID         = 26;              // number of valid hw ids
  {$EXTERNALSYM HW_MAXID}

  CTL_HW_NAMES : array [0..25] of ctlname = (
        ( ctl_name: nil; ctl_type: 0 ),
        ( ctl_name: 'machine'; ctl_type: CTLTYPE_STRING ),
        ( ctl_name: 'model'; ctl_type: CTLTYPE_STRING ),
        ( ctl_name: 'ncpu'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'byteorder'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'physmem'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'usermem'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'pagesize'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'disknames'; ctl_type: CTLTYPE_STRUCT ),
        ( ctl_name: 'diskstats'; ctl_type: CTLTYPE_STRUCT ),
        ( ctl_name: 'epoch'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'floatingpoint'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'machinearch'; ctl_type: CTLTYPE_STRING ),
        ( ctl_name: 'vectorunit'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'busfrequency'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'cpufrequency'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'cachelinesize'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'l1icachesize'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'l1dcachesize'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'l2settings'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'l2cachesize'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'l3settings'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'l3cachesize'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'tbfrequency'; ctl_type: CTLTYPE_INT ),
        ( ctl_name: 'memsize'; ctl_type: CTLTYPE_QUAD ),
        ( ctl_name: 'availcpu'; ctl_type: CTLTYPE_INT ));
  {$EXTERNALSYM CTL_HW_NAMES}

(*
 * XXX This information should be moved to the man page.
 *
 * These are the support HW selectors for sysctlbyname.  Parameters that are byte counts or frequencies are 64 bit numbers.
 * All other parameters are 32 bit numbers.
 *
 *   hw.memsize                - The number of bytes of physical memory in the system.
 *
 *   hw.ncpu                   - The maximum number of processors that could be available this boot.
 *                               Use this value for sizing of static per processor arrays; i.e. processor load statistics.
 *
 *   hw.activecpu              - The number of processors currently available for executing threads.
 *                               Use this number to determine the number threads to create in SMP aware applications.
 *                               This number can change when power management modes are changed.
 *
 *   hw.physicalcpu            - The number of physical processors available in the current power management mode.
 *   hw.physicalcpu_max        - The maximum number of physical processors that could be available this boot
 *
 *   hw.logicalcpu             - The number of logical processors available in the current power management mode.
 *   hw.logicalcpu_max         - The maximum number of logical processors that could be available this boot
 *
 *   hw.tbfrequency            - This gives the time base frequency used by the OS and is the basis of all timing services.
 *                               In general is is better to use mach's or higher level timing services, but this value
 *                               is needed to convert the PPC Time Base registers to real time.
 *
 *   hw.cpufrequency           - These values provide the current, min and max cpu frequency.  The min and max are for
 *   hw.cpufrequency_max       - all power management modes.  The current frequency is the max frequency in the current mode.
 *   hw.cpufrequency_min       - All frequencies are in Hz.
 *
 *   hw.busfrequency           - These values provide the current, min and max bus frequency.  The min and max are for
 *   hw.busfrequency_max       - all power management modes.  The current frequency is the max frequency in the current mode.
 *   hw.busfrequency_min       - All frequencies are in Hz.
 *
 *   hw.cputype                - These values provide the mach-o cpu type and subtype.  A complete list is in <mach/machine.h>
 *   hw.cpusubtype             - These values should be used to determine what processor family the running cpu is from so that
 *                               the best binary can be chosen, or the best dynamic code generated.  They should not be used
 *                               to determine if a given processor feature is available.
 *   hw.cputhreadtype          - This value will be present if the processor supports threads.  Like hw.cpusubtype this selector
 *                               should not be used to infer features, and only used to name the processors thread architecture.
 *                               The values are defined in <mach/machine.h>
 *
 *   hw.byteorder              - Gives the byte order of the processor.  4321 for big endian, 1234 for little.
 *
 *   hw.pagesize               - Gives the size in bytes of the pages used by the processor and VM system.
 *
 *   hw.cachelinesize          - Gives the size in bytes of the processor's cache lines.
 *                               This value should be use to control the strides of loops that use cache control instructions
 *                               like dcbz, dcbt or dcbst.
 *
 *   hw.l1dcachesize           - These values provide the size in bytes of the L1, L2 and L3 caches.  If a cache is not present
 *   hw.l1icachesize           - then the selector will return and error.
 *   hw.l2cachesize            -
 *   hw.l3cachesize            -
 *
 *   hw.packages               - Gives the number of processor packages.
 *
 * These are the selectors for optional processor features for specific processors.  Selectors that return errors are not support
 * on the system.  Supported features will return 1 if they are recommended or 0 if they are supported but are not expected to help .
 * performance.  Future versions of these selectors may return larger values as necessary so it is best to test for non zero.
 *
 * For PowerPC:
 *
 *   hw.optional.floatingpoint - Floating Point Instructions
 *   hw.optional.altivec       - AltiVec Instructions
 *   hw.optional.graphicsops   - Graphics Operations
 *   hw.optional.64bitops      - 64-bit Instructions
 *   hw.optional.fsqrt         - HW Floating Point Square Root Instruction
 *   hw.optional.stfiwx        - Store Floating Point as Integer Word Indexed Instructions
 *   hw.optional.dcba          - Data Cache Block Allocate Instruction
 *   hw.optional.datastreams   - Data Streams Instructions
 *   hw.optional.dcbtstreams   - Data Cache Block Touch Steams Instruction Form
 *
 * For x86 Architecture:
 *
 *   hw.optional.floatingpoint     - Floating Point Instructions
 *   hw.optional.mmx               - Original MMX vector instructions
 *   hw.optional.sse               - Streaming SIMD Extensions
 *   hw.optional.sse2              - Streaming SIMD Extensions 2
 *   hw.optional.sse3              - Streaming SIMD Extensions 3
 *   hw.optional.supplementalsse3  - Supplemental Streaming SIMD Extensions 3
 *   hw.optional.x86_64            - 64-bit support
 *)


(*
 * CTL_USER definitions
 *)
  USER_CS_PATH              = 1;      // string: _CS_PATH
  {$EXTERNALSYM USER_CS_PATH}
  USER_BC_BASE_MAX          = 2;      // int: BC_BASE_MAX
  {$EXTERNALSYM USER_BC_BASE_MAX}
  USER_BC_DIM_MAX           = 3;      // int: BC_DIM_MAX
  {$EXTERNALSYM USER_BC_DIM_MAX}
  USER_BC_SCALE_MAX         = 4;      // int: BC_SCALE_MAX
  {$EXTERNALSYM USER_BC_SCALE_MAX}
  USER_BC_STRING_MAX        = 5;      // int: BC_STRING_MAX
  {$EXTERNALSYM USER_BC_STRING_MAX}
  USER_COLL_WEIGHTS_MAX     = 6;      // int: COLL_WEIGHTS_MAX
  {$EXTERNALSYM USER_COLL_WEIGHTS_MAX}
  USER_EXPR_NEST_MAX        = 7;      // int: EXPR_NEST_MAX
  {$EXTERNALSYM USER_EXPR_NEST_MAX}
  USER_LINE_MAX             = 8;      // int: LINE_MAX
  {$EXTERNALSYM USER_LINE_MAX}
  USER_RE_DUP_MAX           = 9;      // int: RE_DUP_MAX
  {$EXTERNALSYM USER_RE_DUP_MAX}
  USER_POSIX2_VERSION      = 10;      // int: POSIX2_VERSION
  {$EXTERNALSYM USER_POSIX2_VERSION}
  USER_POSIX2_C_BIND       = 11;      // int: POSIX2_C_BIND
  {$EXTERNALSYM USER_POSIX2_C_BIND}
  USER_POSIX2_C_DEV        = 12;      // int: POSIX2_C_DEV
  {$EXTERNALSYM USER_POSIX2_C_DEV}
  USER_POSIX2_CHAR_TERM    = 13;      // int: POSIX2_CHAR_TERM
  {$EXTERNALSYM USER_POSIX2_CHAR_TERM}
  USER_POSIX2_FORT_DEV     = 14;      // int: POSIX2_FORT_DEV
  {$EXTERNALSYM USER_POSIX2_FORT_DEV}
  USER_POSIX2_FORT_RUN     = 15;      // int: POSIX2_FORT_RUN
  {$EXTERNALSYM USER_POSIX2_FORT_RUN}
  USER_POSIX2_LOCALEDEF    = 16;      // int: POSIX2_LOCALEDEF
  {$EXTERNALSYM USER_POSIX2_LOCALEDEF}
  USER_POSIX2_SW_DEV       = 17;      // int: POSIX2_SW_DEV
  {$EXTERNALSYM USER_POSIX2_SW_DEV}
  USER_POSIX2_UPE          = 18;      // int: POSIX2_UPE
  {$EXTERNALSYM USER_POSIX2_UPE}
  USER_STREAM_MAX          = 19;      // int: POSIX2_STREAM_MAX
  {$EXTERNALSYM USER_STREAM_MAX}
  USER_TZNAME_MAX          = 20;      // int: POSIX2_TZNAME_MAX
  {$EXTERNALSYM USER_TZNAME_MAX}
  USER_MAXID               = 21;      // number of valid user ids
  {$EXTERNALSYM USER_MAXID}

  CTL_USER_NAMES: array[0..20] of ctlname = (
        ( ctl_name: nil; ctl_type: 0 ),
        ( ctl_name: 'cs_path'; ctl_type:  CTLTYPE_STRING  ),
        ( ctl_name: 'bc_base_max'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'bc_dim_max'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'bc_scale_max'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'bc_string_max'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'coll_weights_max'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'expr_nest_max'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'line_max'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 're_dup_max'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'posix2_version'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'posix2_c_bind'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'posix2_c_dev'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'posix2_char_term'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'posix2_fort_dev'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'posix2_fort_run'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'posix2_localedef'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'posix2_sw_dev'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'posix2_upe'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'stream_max'; ctl_type:  CTLTYPE_INT  ),
        ( ctl_name: 'tzname_max'; ctl_type:  CTLTYPE_INT  ));
  {$EXTERNALSYM CTL_USER_NAMES}

(*
 * CTL_DEBUG definitions
 *
 * Second level identifier specifies which debug variable.
 * Third level identifier specifies which stucture component.
 *)
  CTL_DEBUG_NAME           = 0;       // string: variable name
  {$EXTERNALSYM CTL_DEBUG_NAME}
  CTL_DEBUG_VALUE          = 1;       // int: variable value
  {$EXTERNALSYM CTL_DEBUG_VALUE}
  CTL_DEBUG_MAXID          = 20;
  {$EXTERNALSYM CTL_DEBUG_MAXID}
