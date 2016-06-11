{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

type

  timer_t = Integer;
  {$EXTERNALSYM timer_t}
  Ptimer_t = ^timer_t;

  blkcnt_t = UInt32;
  {$EXTERNALSYM blkcnt_t}
  Pblkcnt_t = ^blkcnt_t;

  blksize_t = UInt32;
  {$EXTERNALSYM blksize_t}
  Pblksize_t = ^blksize_t;

  clock_t = Int32;
  {$EXTERNALSYM clock_t}
  Pclock_t = ^clock_t;

  clockid_t = Integer;
  {$EXTERNALSYM clockid_t}
  Pclockid_t = ^clockid_t;

  dev_t = UInt32;
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

  ino_t = Integer;
  {$EXTERNALSYM ino_t}
  Pino_t = ^ino_t;

  key_t = Integer;
  {$EXTERNALSYM key_t}
  Pkey_t = ^key_t;

  mode_t = Word;
  {$EXTERNALSYM mode_t}
  Pmode_t = ^mode_t;

  nlink_t = Word;
  {$EXTERNALSYM nlink_t}
  Pnlink_t = ^nlink_t;

{$IFNDEF _OFF_T_DEFINED_}
{$DEFINE _OFF_T_DEFINED_}
  off_t = Longint;
  {$EXTERNALSYM off_t}
  Poff_t = ^off_t;

  off64_t = Int64;
  {$EXTERNALSYM off64_t}
  Poff64_t = ^off64_t;
{$ENDIF}

  pid_t = Integer;
  {$EXTERNALSYM pid_t}
  Ppid_t = ^pid_t;

  {$IFDEF CPU64BITS}
  ssize_t = Int64;
  {$ELSE}
  ssize_t = Integer;
  {$ENDIF}
  {$EXTERNALSYM ssize_t}
  Pssize_t = ^ssize_t;

  uid_t = UInt32;
  {$EXTERNALSYM uid_t}
  Puid_t = ^uid_t;

  suseconds_t = LongInt;
  {$EXTERNALSYM suseconds_t}
  Psuseconds_t = ^suseconds_t;

{ PThreads Support }

type

 uint32_t = UInt32;
  {$EXTERNALSYM uint32_t}
 int32_t = Int32;
  {$EXTERNALSYM int32_t}

{$IFNDEF _PTHREAD_ATTR_T_DEFINED}
  pthread_attr_t = record
    flags: uint32_t;
    stack_base: Pointer;
    stack_size: size_t;
    guard_size: size_t;
    sched_policy: int32_t;
    sched_priority: int32_t;
  end;
  {$EXTERNALSYM pthread_attr_t}
{$ENDIF _PTHREAD_ATTR_T_DEFINED}
  Ppthread_attr_t = ^pthread_attr_t;

  pthread_cond_t = record
    value: Integer;
  end;
  {$EXTERNALSYM pthread_cond_t}

  pthread_condattr_t = Integer;
  {$EXTERNALSYM pthread_condattr_t}
  Ppthread_condattr_t = ^pthread_condattr_t;

  pthread_key_t = Integer;
  {$EXTERNALSYM pthread_key_t}

  pthread_mutex_t = record
    value: Integer;
  end;
  {$EXTERNALSYM pthread_mutex_t}

  pthread_once_t = Integer;
  {$EXTERNALSYM pthread_once_t}

  pthread_rwlock_t = record
    lock: pthread_mutex_t;
    cond: pthread_cond_t;
    numLocks: integer;
    writerThreadId: integer;
    pendingReaders: integer;
    pendingWriters: integer;
    reserved: array[0..3] of Pointer;  //* for future extensibility */
  end;
  {$EXTERNALSYM pthread_rwlock_t}

  pthread_rwlockattr_t = Integer;
  {$EXTERNALSYM pthread_rwlockattr_t}
  Ppthread_rwlockattr_t = ^pthread_rwlockattr_t;

  pthread_t = LongWord;
  {$EXTERNALSYM pthread_t}

  pthread_mutexattr_t = LongInt;
  {$EXTERNALSYM pthread_mutexattr_t}
  Ppthread_mutexattr_t = ^pthread_mutexattr_t;

  time_t = Longint;
  {$EXTERNALSYM time_t}
  Ptime_t = ^time_t;

  useconds_t = LongInt; //UInt32 platform;
  {$EXTERNALSYM useconds_t}
  Puseconds_t = ^useconds_t;

  caddr_t = MarshaledAString platform;
  {$EXTERNALSYM caddr_t}
