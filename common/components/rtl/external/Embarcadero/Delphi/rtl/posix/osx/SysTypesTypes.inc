{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

type
  time_t = Longint;
  {$EXTERNALSYM time_t}
  Ptime_t = ^time_t;

  clock_t = UInt32; //unsigned long
  {$EXTERNALSYM clock_t}
  Pclock_t = ^clock_t;

  blkcnt_t = Int64;
  {$EXTERNALSYM blkcnt_t}
  Pblkcnt_t = ^blkcnt_t;

  blksize_t = Int32;
  {$EXTERNALSYM blksize_t}
  Pblksize_t = ^blksize_t;

  dev_t = Int32;
  {$EXTERNALSYM dev_t}
  Pdev_t = ^dev_t;

  fsblkcnt_t = UInt32;
  {$EXTERNALSYM fsblkcnt_t}
  Pfsblkcnt_t = ^fsblkcnt_t;

  fsfilcnt_t = UInt32;
  {$EXTERNALSYM fsfilcnt_t}
  Pfsfilcnt_t = ^fsfilcnt_t;

  gid_t = UInt32;
  {$EXTERNALSYM gid_t}
  Pgid_t = ^gid_t;

  id_t = UInt32;
  {$EXTERNALSYM id_t}
  _Pid_t = ^id_t;

  ino_t = Int64;
  {$EXTERNALSYM ino_t}
  Pino_t = ^ino_t;

  mode_t = UInt16;
  {$EXTERNALSYM mode_t}
  Pmode_t = ^mode_t;

  nlink_t = Uint16;
  {$EXTERNALSYM nlink_t}
  Pnlink_t = ^nlink_t;

  off_t = Int64;
  {$EXTERNALSYM off_t}
  Poff_t = ^off_t;

  pid_t = UInt32;
  {$EXTERNALSYM pid_t}
  Ppid_t = ^pid_t;

  ssize_t = LongInt;
  {$EXTERNALSYM ssize_t}
  Pssize_t = ^ssize_t;

  uid_t = UInt32;
  {$EXTERNALSYM uid_t}
  Puid_t = ^uid_t;

  useconds_t = UInt32;
  {$EXTERNALSYM useconds_t}
  Puseconds_t = ^useconds_t;

  suseconds_t = Int32;
  {$EXTERNALSYM suseconds_t}
  Psuseconds_t = ^suseconds_t;

{ PThreads Support }
const
  PTHREAD_ONCE_SIZE = 4;
  {$EXTERNALSYM PTHREAD_ONCE_SIZE}
  PTHREAD_MUTEX_SIZE = 40;
  {$EXTERNALSYM PTHREAD_MUTEX_SIZE}
  PTHREAD_MUTEXATTR_SIZE = 8;
  {$EXTERNALSYM PTHREAD_MUTEXATTR_SIZE}
  __PTHREAD_ATTR_SIZE = 36;
  {$EXTERNALSYM __PTHREAD_ATTR_SIZE}
  PTHREAD_COND_SIZE = 24;
  {$EXTERNALSYM PTHREAD_COND_SIZE}
  PTHREAD_CONDATTR_SIZE = 4;
  {$EXTERNALSYM PTHREAD_CONDATTR_SIZE}
  PTHREAD_RWLOCK_SIZE = 124;
  {$EXTERNALSYM PTHREAD_RWLOCK_SIZE}
  PTHREAD_RWLOCKATTR_SIZE = 12;
  {$EXTERNALSYM PTHREAD_RWLOCKATTR_SIZE}

  PTHREAD_MUTEX_RECURSIVE = 2;
  {$EXTERNALSYM PTHREAD_MUTEX_RECURSIVE}
//  PTHREAD_ONCE_INIT_SIG = $30B1BCBA;

type
  pthread_t = Pointer;
  {$EXTERNALSYM pthread_t}

  pthread_once_t = record
    __sig: Longint;
    opaque: array [0..PTHREAD_ONCE_SIZE - 1] of Byte;
  end;
  {$EXTERNALSYM pthread_once_t}

  pthread_mutex_t = record
    __sig: Longint;
    opaque: array [0..PTHREAD_MUTEX_SIZE - 1] of Byte;
  end;
  {$EXTERNALSYM pthread_mutex_t}

  pthread_mutexattr_t = record
    __sig: Longint;
    opaque: array [0..PTHREAD_MUTEXATTR_SIZE - 1] of Byte;
  end;
  {$EXTERNALSYM pthread_mutexattr_t}
  Ppthread_mutexattr_t = ^pthread_mutexattr_t;

  pthread_cond_t = record
    __sig: Longint;
    opaque: array [0..PTHREAD_COND_SIZE - 1] of Byte;
  end;
  {$EXTERNALSYM pthread_cond_t}

  pthread_condattr_t = record
    __sig: Longint;
    opaque: array [0..PTHREAD_CONDATTR_SIZE - 1] of Byte;
  end;
  {$EXTERNALSYM pthread_condattr_t}
  Ppthread_condattr_t = ^pthread_condattr_t;

  pthread_key_t = UInt32;
  {$EXTERNALSYM pthread_key_t}

  pthread_rwlock_t = record
    __sig: Longint;
    opaque: array [0..PTHREAD_RWLOCK_SIZE - 1] of Byte;
  end;
  {$EXTERNALSYM pthread_rwlock_t}

  pthread_rwlockattr_t = record
    __sig: Longint;
    opaque: array [0..PTHREAD_RWLOCKATTR_SIZE - 1] of Byte;
  end;
  {$EXTERNALSYM pthread_rwlockattr_t}
  Ppthread_rwlockattr_t = ^pthread_rwlockattr_t;


{$IFNDEF _PTHREAD_ATTR_T_DEFINED}
  pthread_attr_t = record
    __sig: Longint;
    opaque: array [0..__PTHREAD_ATTR_SIZE - 1] of Byte;
  end;
  {$EXTERNALSYM pthread_attr_t}
{$ENDIF _PTHREAD_ATTR_T_DEFINED}
  Ppthread_attr_t = ^pthread_attr_t;
  caddr_t = MarshaledAString platform;
  {$EXTERNALSYM caddr_t}
