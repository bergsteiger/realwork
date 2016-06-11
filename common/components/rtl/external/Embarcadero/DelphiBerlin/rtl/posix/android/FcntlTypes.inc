{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

const
  F_DUPFD = $0;
  {$EXTERNALSYM F_DUPFD}
  F_GETFD = $1;
  {$EXTERNALSYM F_GETFD}
  F_SETFD = $2;
  {$EXTERNALSYM F_SETFD}
  F_GETFL = $3;
  {$EXTERNALSYM F_GETFL}
  F_SETFL = $4;
  {$EXTERNALSYM F_SETFL}
  F_GETLK = $5;
  {$EXTERNALSYM F_GETLK}
  F_SETLK = $6;
  {$EXTERNALSYM F_SETLK}
  F_SETLKW = $7;
  {$EXTERNALSYM F_SETLKW}
  F_GETOWN = $9;
  {$EXTERNALSYM F_GETOWN}
  F_SETOWN = $8;
  {$EXTERNALSYM F_SETOWN}
  F_SETSIG = $10;
  {$EXTERNALSYM F_SETSIG}
  F_GETSIG = $11;
  {$EXTERNALSYM F_GETSIG}
  FD_CLOEXEC = $1;
  {$EXTERNALSYM FD_CLOEXEC}
  F_RDLCK = $0;
  {$EXTERNALSYM F_RDLCK}
  F_UNLCK = $2;
  {$EXTERNALSYM F_UNLCK}
  F_WRLCK = $1;
  {$EXTERNALSYM F_WRLCK}
  F_EXLCK = $4;
  {$EXTERNALSYM F_EXLCK}
  F_SHLCK = $8;
  {$EXTERNALSYM F_SHLCK}
  F_INPROGRESS = $16;
  {$EXTERNALSYM F_INPROGRESS}
  LOCK_SH         = 1;      { shared lock }
  {$EXTERNALSYM LOCK_SH}
  LOCK_EX         = 2;      { exclusive lock }
  {$EXTERNALSYM LOCK_EX}
  LOCK_NB         = 4;      { or'd with one of the above to prevent blocking }
  {$EXTERNALSYM LOCK_NB}
  LOCK_UN         = 8;      { remove lock }
  {$EXTERNALSYM LOCK_UN}
  LOCK_MAND       = 32;     { This is a mandatory flock:	}
  {$EXTERNALSYM LOCK_MAND}
  LOCK_READ       = 64;     { ... which allows concurrent read operations.	 }
  {$EXTERNALSYM LOCK_READ}
  LOCK_WRITE      = 128;    { ... which allows concurrent write operations.  }
  {$EXTERNALSYM LOCK_WRITE}
  LOCK_RW         = 192;    { ... Which allows concurrent read & write operations.	 }
  {$EXTERNALSYM LOCK_RW}
  O_CREAT = $40;
  {$EXTERNALSYM O_CREAT}
  O_EXCL = $80;
  {$EXTERNALSYM O_EXCL}
  O_NOCTTY = $100;
  {$EXTERNALSYM O_NOCTTY}
  O_TRUNC = $200;
  {$EXTERNALSYM O_TRUNC}
  O_APPEND = $400;
  {$EXTERNALSYM O_APPEND}
  O_NONBLOCK = $800;
  {$EXTERNALSYM O_NONBLOCK}
  O_SYNC = $1000;
  {$EXTERNALSYM O_SYNC}
  O_ACCMODE = $3;
  {$EXTERNALSYM O_ACCMODE}
  O_RDONLY = $0;
  {$EXTERNALSYM O_RDONLY}
  O_RDWR = $2;
  {$EXTERNALSYM O_RDWR}
  O_WRONLY = $1;
  {$EXTERNALSYM O_WRONLY}
  FASYNC =  $2000;
  {$EXTERNALSYM FASYNC}
  O_ASYNC = FASYNC;
  {$EXTERNALSYM O_ASYNC}
  O_DIRECT = $10000 ;
  {$EXTERNALSYM O_DIRECT}
  O_LARGEFILE = $20000;
  {$EXTERNALSYM O_LARGEFILE}
  O_DIRECTORY = $4000;
  {$EXTERNALSYM O_DIRECTORY}
  O_NOFOLLOW = $8000;
  {$EXTERNALSYM O_NOFOLLOW}
  O_NOATIME =  $40000;
  {$EXTERNALSYM O_NOATIME}
  O_NDELAY = O_NONBLOCK;
  {$EXTERNALSYM O_NDELAY}
  O_CLOEXEC = $80000;
  {$EXTERNALSYM O_CLOEXEC}
  F_LINUX_SPECIFIC_BASE = 1024;
  {$EXTERNALSYM F_LINUX_SPECIFIC_BASE}
  F_SETLEASE = F_LINUX_SPECIFIC_BASE+0;
  {$EXTERNALSYM F_SETLEASE}
  F_GETLEASE = F_LINUX_SPECIFIC_BASE+1;
  {$EXTERNALSYM F_GETLEASE}
  F_NOTIFY = F_LINUX_SPECIFIC_BASE+2;
  {$EXTERNALSYM F_NOTIFY}
  DN_ACCESS    = $00000001;     { File accessed.  }
  {$EXTERNALSYM DN_ACCESS}
  DN_MODIFY    = $00000002;     { File modified.  }
  {$EXTERNALSYM DN_MODIFY}
  DN_CREATE    = $00000004;     { File created.  }
  {$EXTERNALSYM DN_CREATE}
  DN_DELETE    = $00000008;     { File removed.  }
  {$EXTERNALSYM DN_DELETE}
  DN_RENAME    = $00000010;     { File renamed.  }
  {$EXTERNALSYM DN_RENAME}
  DN_ATTRIB    = $00000020;     { File changed attibutes.  }
  {$EXTERNALSYM DN_ATTRIB}
  DN_MULTISHOT = $80000000;     { Don't remove notifier.  }
  {$EXTERNALSYM DN_MULTISHOT}
  AT_FDCWD = -100;
  {$EXTERNALSYM AT_FDCWD}
  AT_SYMLINK_NOFOLLOW = $100;
  {$EXTERNALSYM AT_SYMLINK_NOFOLLOW}
  AT_REMOVEDIR = $200;
  {$EXTERNALSYM AT_REMOVEDIR}
  AT_SYMLINK_FOLLOW = $400;
  {$EXTERNALSYM AT_SYMLINK_FOLLOW}

type
  flock = {packed} record
    l_type: Smallint;   { Type of lock: F_RDLCK, F_WRLCK, or F_UNLCK.  }
    l_whence: Smallint; { Where `l_start' is relative to (like `lseek').  }
    l_start: off_t;   { Offset where the lock begins.  }
    l_len: off_t;     { Size of the locked area; zero means until EOF.  }
    l_pid: pid_t;     { Process holding the lock.  }
  end;
  {$EXTERNALSYM flock}
  Pflock = ^flock;
  // flock() is also a function. So EXTERNALSYM Pflock and 
  // manually emit its declaration to disambiguate via the 'struct' keyword
  // But only do that for PosixFcntl.pas - not SysInit, System and others 
  // that pull in the .inc files
  {$EXTERNALSYM Pflock}
  
{$IFDEF IN_POSIXFCNTL}  
  (*$HPPEMIT 'namespace Posix { namespace Fcntl { typedef struct flock *Pflock; } }' *)
{$ENDIF}  
