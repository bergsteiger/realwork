{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ `sysconf', `pathconf', and `confstr' NAME values.  Generic version.
   Copyright (C) 1993,1995-1998,2000,2001,2003,2004,2007,2009
   Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307 USA.  }

{ Values for the NAME argument to `pathconf' and `fpathconf'.  }
const
  _PC_LINK_MAX           = $0001;
  {$EXTERNALSYM _PC_LINK_MAX}
  _PC_MAX_CANON          = $0002;
  {$EXTERNALSYM _PC_MAX_CANON}
  _PC_MAX_INPUT          = $0003;
  {$EXTERNALSYM _PC_MAX_INPUT}
  _PC_NAME_MAX           = $0004;
  {$EXTERNALSYM _PC_NAME_MAX}
  _PC_PATH_MAX           = $0005;
  {$EXTERNALSYM _PC_PATH_MAX}
  _PC_PIPE_BUF           = $0006;
  {$EXTERNALSYM _PC_PIPE_BUF}
  _PC_CHOWN_RESTRICTED   = $000E;
  {$EXTERNALSYM _PC_CHOWN_RESTRICTED}
  _PC_NO_TRUNC           = $000F;
  {$EXTERNALSYM _PC_NO_TRUNC}
  _PC_VDISABLE           = $0010;
  {$EXTERNALSYM _PC_VDISABLE}
  _PC_SYNC_IO            = $0013;
  {$EXTERNALSYM _PC_SYNC_IO}
  _PC_ASYNC_IO           = $0011;
  {$EXTERNALSYM _PC_ASYNC_IO}
  _PC_PRIO_IO            = $0012;
  {$EXTERNALSYM _PC_PRIO_IO}
  _PC_FILESIZEBITS       = $0000;
  {$EXTERNALSYM _PC_FILESIZEBITS}
  _PC_REC_INCR_XFER_SIZE = $0009;
  {$EXTERNALSYM _PC_REC_INCR_XFER_SIZE}
  _PC_REC_MAX_XFER_SIZE  = $000A;
  {$EXTERNALSYM _PC_REC_MAX_XFER_SIZE}
  _PC_REC_MIN_XFER_SIZE  = $000B;
  {$EXTERNALSYM _PC_REC_MIN_XFER_SIZE}
  _PC_REC_XFER_ALIGN     = $000C;
  {$EXTERNALSYM _PC_REC_XFER_ALIGN}
  _PC_ALLOC_SIZE_MIN     = $0008;
  {$EXTERNALSYM _PC_ALLOC_SIZE_MIN}
  _PC_SYMLINK_MAX        = $000D;
  {$EXTERNALSYM _PC_SYMLINK_MAX}
  _PC_2_SYMLINKS         = $0007;
  {$EXTERNALSYM _PC_2_SYMLINKS}

{ Values for the argument to `sysconf'.  }
const
  _SC_ARG_MAX = $0000;
  {$EXTERNALSYM _SC_ARG_MAX}
  _SC_BC_BASE_MAX = $0001;
  {$EXTERNALSYM _SC_BC_BASE_MAX}
  _SC_BC_DIM_MAX = $0002;
  {$EXTERNALSYM _SC_BC_DIM_MAX}
  _SC_BC_SCALE_MAX = $0003;
  {$EXTERNALSYM _SC_BC_SCALE_MAX}
  _SC_BC_STRING_MAX = $0004;
  {$EXTERNALSYM _SC_BC_STRING_MAX}
  _SC_CHILD_MAX = $0005;
  {$EXTERNALSYM _SC_CHILD_MAX}
  _SC_CLK_TCK = $0006;
  {$EXTERNALSYM _SC_CLK_TCK}
  _SC_COLL_WEIGHTS_MAX = $0007;
  {$EXTERNALSYM _SC_COLL_WEIGHTS_MAX}
  _SC_EXPR_NEST_MAX = $0008;
  {$EXTERNALSYM _SC_EXPR_NEST_MAX}
  _SC_LINE_MAX = $0009;
  {$EXTERNALSYM _SC_LINE_MAX}
  _SC_NGROUPS_MAX = $000a;
  {$EXTERNALSYM _SC_NGROUPS_MAX}
  _SC_OPEN_MAX = $000b;
  {$EXTERNALSYM _SC_OPEN_MAX}
  _SC_PASS_MAX = $000c;
  {$EXTERNALSYM _SC_PASS_MAX}
  _SC_2_C_BIND = $000d;
  {$EXTERNALSYM _SC_2_C_BIND}
  _SC_2_C_DEV = $000e;
  {$EXTERNALSYM _SC_2_C_DEV}
  _SC_2_C_VERSION = $000f;
  {$EXTERNALSYM _SC_2_C_VERSION}
  _SC_2_CHAR_TERM = $0010;
  {$EXTERNALSYM _SC_2_CHAR_TERM}
  _SC_2_FORT_DEV = $0011;
  {$EXTERNALSYM _SC_2_FORT_DEV}
  _SC_2_FORT_RUN = $0012;
  {$EXTERNALSYM _SC_2_FORT_RUN}
  _SC_2_LOCALEDEF = $0013;
  {$EXTERNALSYM _SC_2_LOCALEDEF}
  _SC_2_SW_DEV = $0014;
  {$EXTERNALSYM _SC_2_SW_DEV}
  _SC_2_UPE = $0015;
  {$EXTERNALSYM _SC_2_UPE}
  _SC_2_VERSION = $0016;
  {$EXTERNALSYM _SC_2_VERSION}
  _SC_JOB_CONTROL = $0017;
  {$EXTERNALSYM _SC_JOB_CONTROL}
  _SC_SAVED_IDS = $0018;
  {$EXTERNALSYM _SC_SAVED_IDS}
  _SC_VERSION = $0019;
  {$EXTERNALSYM _SC_VERSION}
  _SC_RE_DUP_MAX = $001a;
  {$EXTERNALSYM _SC_RE_DUP_MAX}
  _SC_STREAM_MAX = $001b;
  {$EXTERNALSYM _SC_STREAM_MAX}
  _SC_TZNAME_MAX = $001c;
  {$EXTERNALSYM _SC_TZNAME_MAX}
  _SC_XOPEN_CRYPT = $001d;
  {$EXTERNALSYM _SC_XOPEN_CRYPT}
  _SC_XOPEN_ENH_I18N = $001e;
  {$EXTERNALSYM _SC_XOPEN_ENH_I18N}
  _SC_XOPEN_SHM = $001f;
  {$EXTERNALSYM _SC_XOPEN_SHM}
  _SC_XOPEN_VERSION = $0020;
  {$EXTERNALSYM _SC_XOPEN_VERSION}
  _SC_XOPEN_XCU_VERSION = $0021;
  {$EXTERNALSYM _SC_XOPEN_XCU_VERSION}
  _SC_XOPEN_REALTIME = $0022;
  {$EXTERNALSYM _SC_XOPEN_REALTIME}
  _SC_XOPEN_REALTIME_THREADS = $0023;
  {$EXTERNALSYM _SC_XOPEN_REALTIME_THREADS}
  _SC_XOPEN_LEGACY = $0024;
  {$EXTERNALSYM _SC_XOPEN_LEGACY}
  _SC_ATEXIT_MAX = $0025;
  {$EXTERNALSYM _SC_ATEXIT_MAX}
  _SC_IOV_MAX = $0026;
  {$EXTERNALSYM _SC_IOV_MAX}
  _SC_PAGESIZE = $0027;
  {$EXTERNALSYM _SC_PAGESIZE}
  _SC_PAGE_SIZE = $0028;
  {$EXTERNALSYM _SC_PAGE_SIZE}
  _SC_XOPEN_UNIX = $0029;
  {$EXTERNALSYM _SC_XOPEN_UNIX}
  _SC_XBS5_ILP32_OFF32 = $002a; // NO POSIX
  {$EXTERNALSYM _SC_XBS5_ILP32_OFF32}
  _SC_XBS5_ILP32_OFFBIG = $002b; // NO POSIX
  {$EXTERNALSYM _SC_XBS5_ILP32_OFFBIG}
  _SC_XBS5_LP64_OFF64 = $002c; // NO POSIX
  {$EXTERNALSYM _SC_XBS5_LP64_OFF64}
  _SC_XBS5_LPBIG_OFFBIG = $002d; // NO POSIX
  {$EXTERNALSYM _SC_XBS5_LPBIG_OFFBIG}
  _SC_AIO_LISTIO_MAX = $002e;
  {$EXTERNALSYM _SC_AIO_LISTIO_MAX}
  _SC_AIO_MAX = $002f;
  {$EXTERNALSYM _SC_AIO_MAX}
  _SC_AIO_PRIO_DELTA_MAX = $0030;
  {$EXTERNALSYM _SC_AIO_PRIO_DELTA_MAX}
  _SC_DELAYTIMER_MAX = $0031;
  {$EXTERNALSYM _SC_DELAYTIMER_MAX}
  _SC_MQ_OPEN_MAX = $0032;
  {$EXTERNALSYM _SC_MQ_OPEN_MAX}
  _SC_MQ_PRIO_MAX = $0033;
  {$EXTERNALSYM _SC_MQ_PRIO_MAX}
  _SC_RTSIG_MAX = $0034;
  {$EXTERNALSYM _SC_RTSIG_MAX}
  _SC_SEM_NSEMS_MAX = $0035;
  {$EXTERNALSYM _SC_SEM_NSEMS_MAX}
  _SC_SEM_VALUE_MAX = $0036;
  {$EXTERNALSYM _SC_SEM_VALUE_MAX}
  _SC_SIGQUEUE_MAX = $0037;
  {$EXTERNALSYM _SC_SIGQUEUE_MAX}
  _SC_TIMER_MAX = $0038;
  {$EXTERNALSYM _SC_TIMER_MAX}
  _SC_ASYNCHRONOUS_IO = $0039;
  {$EXTERNALSYM _SC_ASYNCHRONOUS_IO}
  _SC_FSYNC = $003a;
  {$EXTERNALSYM _SC_FSYNC}
  _SC_MAPPED_FILES = $003b;
  {$EXTERNALSYM _SC_MAPPED_FILES}
  _SC_MEMLOCK = $003c;
  {$EXTERNALSYM _SC_MEMLOCK}
  _SC_MEMLOCK_RANGE = $003d;
  {$EXTERNALSYM _SC_MEMLOCK_RANGE}
  _SC_MEMORY_PROTECTION = $003e;
  {$EXTERNALSYM _SC_MEMORY_PROTECTION}
  _SC_MESSAGE_PASSING = $003f;
  {$EXTERNALSYM _SC_MESSAGE_PASSING}
  _SC_PRIORITIZED_IO = $0040;
  {$EXTERNALSYM _SC_PRIORITIZED_IO}
  _SC_PRIORITY_SCHEDULING = $0041;
  {$EXTERNALSYM _SC_PRIORITY_SCHEDULING}
  _SC_REALTIME_SIGNALS = $0042;
  {$EXTERNALSYM _SC_REALTIME_SIGNALS}
  _SC_SEMAPHORES = $0043;
  {$EXTERNALSYM _SC_SEMAPHORES}
  _SC_SHARED_MEMORY_OBJECTS = $0044;
  {$EXTERNALSYM _SC_SHARED_MEMORY_OBJECTS}
  _SC_SYNCHRONIZED_IO = $0045;
  {$EXTERNALSYM _SC_SYNCHRONIZED_IO}
  _SC_TIMERS = $0046;
  {$EXTERNALSYM _SC_TIMERS}
  _SC_GETGR_R_SIZE_MAX = $0047;
  {$EXTERNALSYM _SC_GETGR_R_SIZE_MAX}
  _SC_GETPW_R_SIZE_MAX = $0048;
  {$EXTERNALSYM _SC_GETPW_R_SIZE_MAX}
  _SC_LOGIN_NAME_MAX = $0049;
  {$EXTERNALSYM _SC_LOGIN_NAME_MAX}
  _SC_THREAD_DESTRUCTOR_ITERATIONS = $004a;
  {$EXTERNALSYM _SC_THREAD_DESTRUCTOR_ITERATIONS}
  _SC_THREAD_KEYS_MAX = $004b;
  {$EXTERNALSYM _SC_THREAD_KEYS_MAX}
  _SC_THREAD_STACK_MIN = $004c;
  {$EXTERNALSYM _SC_THREAD_STACK_MIN}
  _SC_THREAD_THREADS_MAX = $004d;
  {$EXTERNALSYM _SC_THREAD_THREADS_MAX}
  _SC_TTY_NAME_MAX = $004e;
  {$EXTERNALSYM _SC_TTY_NAME_MAX}

  _SC_THREADS = $004f;
  {$EXTERNALSYM _SC_THREADS}
  _SC_THREAD_ATTR_STACKADDR = $0050;
  {$EXTERNALSYM _SC_THREAD_ATTR_STACKADDR }
  _SC_THREAD_ATTR_STACKSIZE = $0051;
  {$EXTERNALSYM _SC_THREAD_ATTR_STACKSIZE}
  _SC_THREAD_PRIORITY_SCHEDULING = $0052;
  {$EXTERNALSYM _SC_THREAD_PRIORITY_SCHEDULING}
  _SC_THREAD_PRIO_INHERIT = $0053;
  {$EXTERNALSYM _SC_THREAD_PRIO_INHERIT}
  _SC_THREAD_PRIO_PROTECT = $0054;
  {$EXTERNALSYM _SC_THREAD_PRIO_PROTECT}
  _SC_THREAD_SAFE_FUNCTIONS = $0055;
  {$EXTERNALSYM _SC_THREAD_SAFE_FUNCTIONS}
  
  _SC_NPROCESSORS_CONF = $0060;// NO POSIX
   {$EXTERNALSYM _SC_NPROCESSORS_CONF}
  _SC_NPROCESSORS_ONLN = $0061;// NO POSIX
   {$EXTERNALSYM _SC_NPROCESSORS_ONLN}
  _SC_PHYS_PAGES = $0062;// NO POSIX
   {$EXTERNALSYM _SC_PHYS_PAGES}
  _SC_AVPHYS_PAGES = $0063;// NO POSIX
   {$EXTERNALSYM _SC_AVPHYS_PAGES}



{ Define POSIX options for Linux.
   Copyright (C) 1996-2004, 2006, 2008, 2009 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public License as
   published by the Free Software Foundation; either version 2.1 of the
   License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; see the file COPYING.LIB.  If not,
   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  }

const

{ Job control is supported.  }
  _POSIX_JOB_CONTROL = 1;
  {$EXTERNALSYM _POSIX_JOB_CONTROL}

{ Processes have a saved set-user-ID and a saved set-group-ID.  }
  _POSIX_SAVED_IDS = 1;
  {$EXTERNALSYM _POSIX_SAVED_IDS}

{ Synchronizing file data is supported.  }
  _POSIX_SYNCHRONIZED_IO = 1;
  {$EXTERNALSYM _POSIX_SYNCHRONIZED_IO}

{ The fsync function is present.  }
  _POSIX_FSYNC = 1;
  {$EXTERNALSYM _POSIX_FSYNC}

{ Mapping of files to memory is supported.  }
  _POSIX_MAPPED_FILES = 1;
  {$EXTERNALSYM _POSIX_MAPPED_FILES}

{ Some filesystems allow all users to change file ownership.  }
  _POSIX_CHOWN_RESTRICTED = 1;
  {$EXTERNALSYM _POSIX_CHOWN_RESTRICTED}

{ _POSIX_VDISABLE = '\0';
  $EXTERNALSYM _POSIX_VDISABLE}
 

{ Filenames are not silently truncated.  }
  _POSIX_NO_TRUNC = 1;
  {$EXTERNALSYM _POSIX_NO_TRUNC}
 
 { X/Open Encryption support is not supported }
  _XOPEN_CRYPT = -1;
  {$EXTERNALSYM _XOPEN_CRYPT}
  
  { Internationalization is not supported in C library }
  _XOPEN_ENH_I18N = -1;
  {$EXTERNALSYM _XOPEN_ENH_I18N}

{ X/Open realtime support is not available.  }
  _XOPEN_REALTIME = -1;
  {$EXTERNALSYM _XOPEN_REALTIME}

{ X/Open thread realtime support is not available.  }
  _XOPEN_REALTIME_THREADS = -1;
  {$EXTERNALSYM _XOPEN_REALTIME_THREADS}
  
  { X/Open supports XSI option  }
  _XOPEN_UNIX = 1;
  {$EXTERNALSYM _XOPEN_UNIX}  

{ Tell we have POSIX threads.  }
  _POSIX_THREADS = 1;
  {$EXTERNALSYM _POSIX_THREADS}


{ We support priority inheritence.  }
  _POSIX_THREAD_PRIO_INHERIT = 200112;
  {$EXTERNALSYM _POSIX_THREAD_PRIO_INHERIT}

{ We support priority protection, though only for non-robust
   mutexes.  }
  _POSIX_THREAD_PRIO_PROTECT = 200112;
  {$EXTERNALSYM _POSIX_THREAD_PRIO_PROTECT}

{ Real-time signals are supported.  }
  _POSIX_REALTIME_SIGNALS = -1;
  {$EXTERNALSYM _POSIX_REALTIME_SIGNALS}
  

{ We have POSIX timers.  }
  _POSIX_TIMERS = 1;
  {$EXTERNALSYM _POSIX_TIMERS}

const
  STDIN_FILENO         = 0;
  {$EXTERNALSYM STDIN_FILENO}

  STDOUT_FILENO        = 1;
  {$EXTERNALSYM STDOUT_FILENO}
  
  STDERR_FILENO        = 2;
  {$EXTERNALSYM STDERR_FILENO}
  
  F_OK = 0;
  {$EXTERNALSYM F_OK}
  X_OK = 1 shl 0;
  {$EXTERNALSYM X_OK}
  W_OK = 1 shl 1;
  {$EXTERNALSYM W_OK}
  R_OK = 1 shl 2;
  {$EXTERNALSYM R_OK}
  
  _POSIX_VERSION = 200112;
  {$EXTERNALSYM _POSIX_VERSION}
  
  _POSIX2_VERSION = -1;
  {$EXTERNALSYM _POSIX2_VERSION}
  
  _XOPEN_VERSION = 500;
  {$EXTERNALSYM _XOPEN_VERSION}
  
  

type
  TPipeDescriptors = {packed} record
    ReadDes: Integer;
    WriteDes: Integer;
  end;

