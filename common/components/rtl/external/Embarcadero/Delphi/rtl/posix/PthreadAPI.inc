{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

function pthread_once(var InitOnceSemaphore: pthread_once_t; 
  InitOnceProc: TInitOnceProc): Integer; cdecl;
  external libpthread name _PU + 'pthread_once';

function pthread_key_create(var Key: Integer; 
  KeyValueDestructor: TKeyValueDestructor): Integer; cdecl;
  external libpthread name _PU + 'pthread_key_create';

function pthread_key_delete(Key: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_key_delete';

function pthread_create(var Thread: pthread_t; var Attr: pthread_attr_t;
  TFunc: TThreadFunc; Arg: Pointer): Integer; cdecl;
  external libpthread name _PU + 'pthread_create'; overload;
function pthread_create(var Thread: pthread_t; Attr: Ppthread_attr_t;
  TFunc: TThreadFunc; Arg: Pointer): Integer; cdecl;
  external libpthread name _PU + 'pthread_create'; overload;
{$EXTERNALSYM pthread_create}

{ Obtain the identifier of the current thread.  }
function pthread_self: pthread_t; cdecl;
  external libpthread name _PU + 'pthread_self';
{$EXTERNALSYM pthread_self}

{ Compare two thread identifiers.  }
function pthread_equal(Thread1ID, Thread2ID: pthread_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_equal';
{$EXTERNALSYM pthread_equal}

function pthread_exit(var RetVal: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_exit';
{$EXTERNALSYM pthread_exit}

function pthread_detach(thread: pthread_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_detach'
{$EXTERNALSYM pthread_detach}

function pthread_join(thread: pthread_t; var value_ptr: Pointer): Integer; cdecl;
  external libpthread name _PU + 'pthread_join'
{$EXTERNALSYM pthread_join}

{ Functions for mutex handling. }

function pthread_mutex_init(var Mutex: pthread_mutex_t;
  var Attr: pthread_mutexattr_t): Integer; cdecl; overload;
  external libpthread name _PU + 'pthread_mutex_init';
function pthread_mutex_init(var Mutex: pthread_mutex_t;
  Attr: Ppthread_mutexattr_t): Integer; cdecl; overload;
  external libpthread name _PU + 'pthread_mutex_init';
{$EXTERNALSYM pthread_mutex_init}

{ Destroy MUTEX.  }
function pthread_mutex_destroy(var Mutex: pthread_mutex_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_mutex_destroy';
{$EXTERNALSYM pthread_mutex_destroy}

{ Try to lock MUTEX.  }
function pthread_mutex_trylock(var Mutex: pthread_mutex_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_mutex_trylock';
{$EXTERNALSYM pthread_mutex_trylock}

{ Wait until lock for MUTEX becomes available and lock it.  }
function pthread_mutex_lock(var Mutex: pthread_mutex_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_mutex_lock';
{$EXTERNALSYM pthread_mutex_lock}

{$IFDEF LINUX}
{ Wait until lock becomes available, or specified time passes. }
function pthread_mutex_timedlock(var Mutex: pthread_mutex_t; const AbsTime: timespec): Integer; cdecl;
  external libpthread name _PU + 'pthread_mutex_timedlock';
{$EXTERNALSYM pthread_mutex_timedlock}
{$ENDIF LINUX}

{ Unlock MUTEX.  }
function pthread_mutex_unlock(var Mutex: pthread_mutex_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_mutex_unlock';
{$EXTERNALSYM pthread_mutex_unlock}

{ Functions for handling mutex attributes.  }

{ Initialize mutex attribute object ATTR with default attributes
   (kind is PTHREAD_MUTEX_FAST_NP).  }
function pthread_mutexattr_init(var Attr: pthread_mutexattr_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_mutexattr_init';
{$EXTERNALSYM pthread_mutexattr_init}

{ Destroy mutex attribute object ATTR.  }
function pthread_mutexattr_destroy(var Attr: pthread_mutexattr_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_mutexattr_destroy';
{$EXTERNALSYM pthread_mutexattr_destroy}

{ Get the process-shared flag of the mutex attribute ATTR.  }
function pthread_mutexattr_getpshared(var Attr: pthread_mutexattr_t; // Actually __const PThreadMutexAttr *
  var ProcessShared: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_mutexattr_getpshared';
{$EXTERNALSYM pthread_mutexattr_getpshared}

{ Set the process-shared flag of the mutex attribute ATTR.  }
function pthread_mutexattr_setpshared(var Attr: pthread_mutexattr_t; ProcessShared: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_mutexattr_setpshared';
{$EXTERNALSYM pthread_mutexattr_setpshared}

{ Set the mutex kind attribute in *ATTR to KIND (either PTHREAD_MUTEX_NORMAL,
   PTHREAD_MUTEX_RECURSIVE, PTHREAD_MUTEX_ERRORCHECK, or
   PTHREAD_MUTEX_DEFAULT).  }
function pthread_mutexattr_settype(var Attr: pthread_mutexattr_t; Kind: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_mutexattr_settype';
{$EXTERNALSYM pthread_mutexattr_settype}

{ Return in *KIND the mutex kind attribute in *ATTR. }
function pthread_mutexattr_gettype(var Attr: pthread_mutexattr_t; var Kind: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_mutexattr_gettype';
{$EXTERNALSYM pthread_mutexattr_gettype}

function pthread_attr_init(var Attr: pthread_attr_t): Integer; cdecl
  external libpthread name _PU + 'pthread_attr_init';
{$EXTERNALSYM pthread_attr_init}

function pthread_attr_destroy(var Attr: pthread_attr_t): Integer; cdecl
  external libpthread name _PU + 'pthread_attr_destroy';
{$EXTERNALSYM pthread_attr_destroy}

function pthread_attr_setdetachstate(var Attr: pthread_attr_t; State: Integer): Integer; cdecl
  external libpthread name _PU + 'pthread_attr_setdetachstate';
{$EXTERNALSYM pthread_attr_setdetachstate}

{ Return in *DETACHSTATE the `detachstate' attribute in *ATTR.  }
function pthread_attr_getdetachstate(const [Ref] Attr: pthread_attr_t;
  var DetachState: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_attr_getdetachstate';
{$EXTERNALSYM pthread_attr_getdetachstate}

{ Initialize condition variable COND using attributes ATTR, or use
   the default values if later is NULL.  }
function pthread_cond_init(var Cond: pthread_cond_t; var CondAttr: pthread_condattr_t): Integer; cdecl; overload;
  external libpthread name _PU + 'pthread_cond_init';
function pthread_cond_init(var Cond: pthread_cond_t; CondAttr: Ppthread_condattr_t): Integer; cdecl; overload;
  external libpthread name _PU + 'pthread_cond_init';
{$EXTERNALSYM pthread_cond_init}

{ Destroy condition variable COND.  }
function pthread_cond_destroy(var Cond: pthread_cond_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_cond_destroy';
{$EXTERNALSYM pthread_cond_destroy}

{ Wake up one thread waiting for condition variable COND.  }
function pthread_cond_signal(var Cond: pthread_cond_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_cond_signal';
{$EXTERNALSYM pthread_cond_signal}

{ Wake up all threads waiting for condition variables COND.  }
function pthread_cond_broadcast(var Cond: pthread_cond_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_cond_broadcast';
{$EXTERNALSYM pthread_cond_broadcast}

{ Wait for condition variable COND to be signaled or broadcast.
   MUTEX is assumed to be locked before.  }
function pthread_cond_wait(var Cond: pthread_cond_t; var Mutex: pthread_mutex_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_cond_wait';
{$EXTERNALSYM pthread_cond_wait}

{ Wait for condition variable COND to be signaled or broadcast until
   ABSTIME.  MUTEX is assumed to be locked before.  ABSTIME is an
   absolute time specification; zero is the beginning of the epoch
   (00:00:00 GMT, January 1, 1970). }
function pthread_cond_timedwait(var Cond: pthread_cond_t; var Mutex: pthread_mutex_t; const AbsTime: timeSpec): Integer; cdecl;
  external libpthread name _PU + 'pthread_cond_timedwait';
{$EXTERNALSYM pthread_cond_timedwait}

{ Functions for handling condition variable attributes.  }

{ Initialize condition variable attribute ATTR.  }
function pthread_condattr_init(var Attr: pthread_condattr_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_condattr_init';
{$EXTERNALSYM pthread_condattr_init}

{ Destroy condition variable attribute ATTR.  }
function pthread_condattr_destroy(var Attr: pthread_condattr_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_condattr_destroy';
{$EXTERNALSYM pthread_condattr_destroy}

{ Get the process-shared flag of the condition variable attribute ATTR.  }
function pthread_condattr_getpshared(var Attr: pthread_condattr_t; // Actually: const *
  var ProcessShared: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_condattr_getpshared';
{$EXTERNALSYM pthread_condattr_getpshared}

{ Set the process-shared flag of the condition variable attribute ATTR.  }
function pthread_condattr_setpshared(var Attr: pthread_condattr_t; ProcessShared: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_condattr_setpshared';
{$EXTERNALSYM pthread_condattr_setpshared}

{ Functions for handling read-write locks.  }

{ Initialize read-write lock RWLOCK using attributes ATTR, or use
   the default values if latter is NULL.  }
function pthread_rwlock_init(var RWLock: pthread_rwlock_t; var Attr: pthread_rwlockattr_t): Integer; cdecl; overload;
  external libpthread name _PU + 'pthread_rwlock_init';
{$EXTERNALSYM pthread_rwlock_init}

function pthread_rwlock_init(var RWLock: pthread_rwlock_t; Attr: Ppthread_rwlockattr_t): Integer; cdecl; overload;
  external libpthread name _PU + 'pthread_rwlock_init';
{$EXTERNALSYM pthread_rwlock_init}

{ Destroy read-write lock RWLOCK.  }
function pthread_rwlock_destroy(var RWLock: pthread_rwlock_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_rwlock_destroy';
{$EXTERNALSYM pthread_rwlock_destroy}

{ Acquire read lock for RWLOCK.  }
function pthread_rwlock_rdlock(var RWLock: pthread_rwlock_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_rwlock_rdlock';
{$EXTERNALSYM pthread_rwlock_rdlock}

{ Try to acquire read lock for RWLOCK.  }
function pthread_rwlock_tryrdlock(var RWLock: pthread_rwlock_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_rwlock_tryrdlock';
{$EXTERNALSYM pthread_rwlock_tryrdlock}

{$IFDEF LINUX}
{ Try to acquire read lock for RWLOCK or return after specfied time.  }
function pthread_rwlock_timedrdlock(var RWLock: pthread_rwlock_t;
  const AbsTime: timespec): Integer; cdecl;
  external libpthread name _PU + 'pthread_rwlock_timedrdlock';
{$EXTERNALSYM pthread_rwlock_timedrdlock}
{$ENDIF LINUX}

{ Acquire write lock for RWLOCK.  }
function pthread_rwlock_wrlock(var RWLock: pthread_rwlock_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_rwlock_wrlock';
{$EXTERNALSYM pthread_rwlock_wrlock}

{ Try to acquire writelock for RWLOCK.  }
function pthread_rwlock_trywrlock(var RWLock: pthread_rwlock_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_rwlock_trywrlock';
{$EXTERNALSYM pthread_rwlock_trywrlock}

{$IFDEF LINUX}
{ Try to acquire write lock for RWLOCK or return after specfied time.  }
function pthread_rwlock_timedwrlock(var RWLock: pthread_rwlock_t;
  const AbsTime: timespec): Integer; cdecl;
  external libpthread name _PU + 'pthread_rwlock_timedwrlock';
{$EXTERNALSYM pthread_rwlock_timedwrlock}
{$ENDIF LINUX}

{ Unlock RWLOCK.  }
function pthread_rwlock_unlock(var RWLock: pthread_rwlock_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_rwlock_unlock';
{$EXTERNALSYM pthread_rwlock_unlock}

{ Functions for handling read-write lock attributes.  }

{ Initialize attribute object ATTR with default values.  }
function pthread_rwlockattr_init(var Attr: pthread_rwlockattr_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_rwlockattr_init';
{$EXTERNALSYM pthread_rwlockattr_init}

{ Destroy attribute object ATTR.  }
function pthread_rwlockattr_destroy(var Attr: pthread_rwlockattr_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_rwlockattr_destroy';
{$EXTERNALSYM pthread_rwlockattr_destroy}

{ Return current setting of process-shared attribute of ATTR in PSHARED.  }
function pthread_rwlockattr_getpshared(const [Ref] Attr: pthread_rwlockattr_t; var PShared: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_rwlockattr_getpshared';
{$EXTERNALSYM pthread_rwlockattr_getpshared}

{ Set process-shared attribute of ATTR to PSHARED.  }
function pthread_rwlockattr_setpshared(var Attr: pthread_rwlockattr_t; PShared: Integer): Integer; cdecl;
external libpthread name _PU + 'pthread_rwlockattr_setpshared';
{$EXTERNALSYM pthread_rwlockattr_setpshared}

{$IFDEF LINUX}
{ Return current setting of reader/writer preference.  }
function pthread_rwlockattr_getkind_np(const [Ref] Attr: pthread_rwlockattr_t; var Pref: Integer): Integer; cdecl;
external libpthread name _PU + 'pthread_rwlockattr_getkind_np';
{$EXTERNALSYM pthread_rwlockattr_getkind_np}

{ Set reader/write preference.  }
function pthread_rwlockattr_setkind_np(var Attr: pthread_rwlockattr_t; Pref: Integer): Integer; cdecl;
external libpthread name _PU + 'pthread_rwlockattr_setkind_np';
{$EXTERNALSYM pthread_rwlockattr_setkind_np}
{$ENDIF LINUX}

{ Set scheduling inheritance mode in *ATTR according to INHERIT.  }
function pthread_attr_setinheritsched(var Attr: pthread_attr_t;
  Inherit: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_attr_setinheritsched';
{$EXTERNALSYM pthread_attr_setinheritsched}

{ Return in *INHERIT the scheduling inheritance mode of *ATTR.  }
function pthread_attr_getinheritsched(const [Ref] Attr: pthread_attr_t;
  var Inherit: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_attr_getinheritsched';
{$EXTERNALSYM pthread_attr_getinheritsched}

{ Set the scheduling parameters for TARGET_THREAD according to POLICY
   and *PARAM. }
function pthread_setschedparam(ThreadID: pthread_t; Policy: Integer;
  var Param: sched_param): Integer; cdecl;
  external libpthread name _PU + 'pthread_setschedparam';
{$EXTERNALSYM pthread_setschedparam}

{ Return in *POLICY and *PARAM the scheduling parameters for TARGET_THREAD. }
function pthread_getschedparam(ThreadID: pthread_t; var Policy: Integer;
  var Param: sched_param): Integer; cdecl;
  external libpthread name _PU + 'pthread_getschedparam';
{$EXTERNALSYM pthread_getschedparam}

{ Store POINTER in the thread-specific data slot identified by KEY. }
function pthread_setspecific(Key: pthread_key_t; Ptr: Pointer): Integer; cdecl;
  external libpthread name _PU + 'pthread_setspecific';
{$EXTERNALSYM pthread_setspecific}

{ Return current value of the thread-specific data slot identified by KEY.  }
function pthread_getspecific(Key: pthread_key_t): Pointer; cdecl;
  external libpthread name _PU + 'pthread_getspecific';
{$EXTERNALSYM pthread_getspecific}

{ Set scheduling policy in *ATTR according to POLICY.  }
function pthread_attr_setschedpolicy(var Attr: pthread_attr_t;
  Policy: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_attr_setschedpolicy';
{$EXTERNALSYM pthread_attr_setschedpolicy}

{ Return in *POLICY the scheduling policy of *ATTR.  }
function pthread_attr_getschedpolicy(const [Ref] Attr: pthread_attr_t;
  var Policy: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_attr_getschedpolicy';
{$EXTERNALSYM pthread_attr_getschedpolicy}

{ Set scheduling contention scope in *ATTR according to SCOPE.  }
function pthread_attr_setscope(var Attr: pthread_attr_t;
  Scope: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_attr_setscope';
{$EXTERNALSYM pthread_attr_setscope}

{ Return in *SCOPE the scheduling contention scope of *ATTR.  }
function pthread_attr_getscope(const [Ref] Attr: pthread_attr_t;
  var Scope: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_attr_getscope';
{$EXTERNALSYM pthread_attr_getscope}

{ Set the size of the guard area at the bottom of the thread.  }
function pthread_attr_setguardsize(var Attr: pthread_attr_t;
  Guardsize: size_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_attr_setguardsize';
{$EXTERNALSYM pthread_attr_setguardsize}

{ Get the size of the guard area at the bottom of the thread.  }
function pthread_attr_getguardsize(const [Ref] Attr: pthread_attr_t;
  var Guardsize: size_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_attr_getguardsize';
{$EXTERNALSYM pthread_attr_getguardsize}

{ The following two interfaces are intended to replace the last two.  They
   require setting the address as well as the size since only setting the
   address will make the implementation on some architectures impossible.  }
function pthread_attr_setstack(var Attr: pthread_attr_t; StackAddr: Pointer;
  StackSize: size_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_attr_setstack';
{$EXTERNALSYM pthread_attr_setstack}

{ Return the previously set address for the stack.  }
function pthread_attr_getstack(const [Ref] Attr: pthread_attr_t; var StackAddr: Pointer;
  var StackSize: size_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_attr_getstack';
{$EXTERNALSYM pthread_attr_getstack}

{ Add information about the minimum stack size needed for the thread
   to be started.  This size must never be less than PTHREAD_STACK_SIZE
   and must also not exceed the system limits.  }
function pthread_attr_setstacksize(var Attr: pthread_attr_t;
  StackSize: size_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_attr_setstacksize';
{$EXTERNALSYM pthread_attr_setstacksize}

{ Return the currently used minimal stack size.  }
function pthread_attr_getstacksize(const [Ref] Attr: pthread_attr_t;
  var StackSize: size_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_attr_getstacksize';
{$EXTERNALSYM pthread_attr_getstacksize}

type
  TForkHandler = procedure; cdecl; // Used anonymously in header file.
  {$EXTERNALSYM TForkHandler}

function pthread_atfork(Prepare: TForkHandler; Parent: TForkHandler;
  Child: TForkHandler): Integer; cdecl;
  external libpthread name _PU + 'pthread_atfork';
{$EXTERNALSYM pthread_atfork}

{ Functions for handling cancellation. }

{ Cancel THREAD immediately or at the next possibility.  }
function pthread_cancel(ThreadID: pthread_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_cancel';
{$EXTERNALSYM pthread_cancel}

{ Set cancelability state of current thread to STATE, returning old
   state in *OLDSTATE if OLDSTATE is not NULL.  }
function pthread_setcancelstate(State: Integer; OldState: PInteger): Integer; cdecl;
  external libpthread name _PU + 'pthread_setcancelstate';
{$EXTERNALSYM pthread_setcancelstate}

{ Set cancellation state of current thread to TYPE, returning the old
   type in *OLDTYPE if OLDTYPE is not NULL.  }
function pthread_setcanceltype(CancelType: Integer; OldType: PInteger): Integer; cdecl;
  external libpthread name _PU + 'pthread_setcanceltype';
{$EXTERNALSYM pthread_setcanceltype}

{ Test for pending cancellation for the current thread and terminate
   the thread as per pthread_exit(PTHREAD_CANCELED) if it has been
   cancelled. }
procedure pthread_testcancel; cdecl;
  external libpthread name _PU + 'pthread_testcancel';
{$EXTERNALSYM pthread_testcancel}

{$IFDEF LINUX}
{ The IEEE Std. 1003.1j-2000 introduces functions to implement
   spinlocks.  }

{ Initialize the spinlock LOCK.  If PSHARED is nonzero the spinlock can
   be shared between different processes.  }
function pthread_spin_init(var Lock: pthread_spinlock_t; ProcessShared: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_spin_init';
{$EXTERNALSYM pthread_spin_init}

{ Destroy the spinlock LOCK.  }
function pthread_spin_destroy(var Lock: pthread_spinlock_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_spin_destroy';
{$EXTERNALSYM pthread_spin_destroy}

{ Wait until spinlock LOCK is retrieved.  }
function pthread_spin_lock(var Lock: pthread_spinlock_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_spin_lock';
{$EXTERNALSYM pthread_spin_lock}

{ Try to lock spinlock LOCK.  }
function pthread_spin_trylock(var Lock: pthread_spinlock_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_spin_trylock';
{$EXTERNALSYM pthread_spin_trylock}

{ Release spinlock LOCK.  }
function pthread_spin_unlock(var Lock: pthread_spinlock_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_spin_unlock';
{$EXTERNALSYM pthread_spin_unlock}

{ Barriers are a also a new feature in 1003.1j-2000. }

function pthread_barrier_init(var Barrier: pthread_barrier_t;
  var Attr: pthread_barrierattr_t; Count: Cardinal): Integer; cdecl; overload;
  external libpthread name _PU + 'pthread_barrier_init';
function pthread_barrier_init(var Barrier: pthread_barrier_t;
  Attr: Ppthread_barrierattr_t; Count: Cardinal): Integer; cdecl; overload;
  external libpthread name _PU + 'pthread_barrier_init';
{$EXTERNALSYM pthread_barrier_init}

function pthread_barrier_destroy(var Barrier: pthread_barrier_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_barrier_destroy';
{$EXTERNALSYM pthread_barrier_destroy}

function pthread_barrierattr_init(var Barrier: pthread_barrierattr_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_barrierattr_init';
{$EXTERNALSYM pthread_barrierattr_init}

function pthread_barrierattr_destroy(var Barrier: pthread_barrierattr_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_barrierattr_destroy';
{$EXTERNALSYM pthread_barrierattr_destroy}

function pthread_barrierattr_getpshared(var Attr: pthread_barrierattr_t;
  var ProcessShared: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_barrierattr_getpshared';
{$EXTERNALSYM pthread_barrierattr_getpshared}

function pthread_barrierattr_setpshared(var Attr: pthread_barrierattr_t;
  ProcessShared: Integer): Integer; cdecl;
  external libpthread name _PU + 'pthread_barrierattr_setpshared';
{$EXTERNALSYM pthread_barrierattr_setpshared}

function pthread_barrier_wait(var Barrier: pthread_barrier_t): Integer; cdecl;
  external libpthread name _PU + 'pthread_barrier_wait';
{$EXTERNALSYM pthread_barrier_wait}
{$ENDIF LINUX}
(* TODO -otgerdes -cHeader Translation: Missing apis:
void  pthread_cleanup_pop(int);
void  pthread_cleanup_push(void (* )(void* ), void * );
int   pthread_condattr_getclock(const pthread_condattr_t *restrict,
          clockid_t *restrict);
int   pthread_condattr_setclock(pthread_condattr_t *, clockid_t);

int   pthread_mutex_consistent(pthread_mutex_t * );
int   pthread_mutexattr_getrobust(const pthread_mutexattr_t *restrict,
          int *restrict);
int   pthread_mutexattr_setrobust(pthread_mutexattr_t *, int);

[OB XSI]
int   pthread_getconcurrency(void);
int   pthread_setconcurrency(int);
[TCT]
int   pthread_getcpuclockid(pthread_t, clockid_t * );
[RPP|TPP]
int   pthread_mutex_getprioceiling(const pthread_mutex_t *restrict,
          int *restrict);
int   pthread_mutex_setprioceiling(pthread_mutex_t *restrict, int,
          int *restrict);
int   pthread_mutexattr_getprioceiling(
          const pthread_mutexattr_t *restrict, int *restrict);
int   pthread_mutexattr_setprioceiling(pthread_mutexattr_t *, int);
[MC1]
int   pthread_mutexattr_getprotocol(const pthread_mutexattr_t *restrict,
          int *restrict);
int   pthread_mutexattr_setprotocol(pthread_mutexattr_t *, int);
[TPS] // place this with (set|get)schedparam
int   pthread_setschedprio(pthread_t, int);
*)
