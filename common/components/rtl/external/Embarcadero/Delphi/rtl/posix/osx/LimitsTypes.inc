{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

const
{from sys/syslimits.h}
  ARG_MAX   = (256 * 1024); // max bytes for an exec function
  {$EXTERNALSYM ARG_MAX}
  CHILD_MAX =          266; // max simultaneous processes
  {$EXTERNALSYM CHILD_MAX}

  LINK_MAX    = 32767; // max file link count
  {$EXTERNALSYM LINK_MAX}
  MAX_CANON   =  1024; // max bytes in term canon input line
  {$EXTERNALSYM MAX_CANON}
  MAX_INPUT   =  1024; // max bytes in terminal input
  {$EXTERNALSYM MAX_INPUT}
  NAME_MAX    =   255; // max bytes in a file name
  {$EXTERNALSYM NAME_MAX}
  NGROUPS_MAX =    16; // max supplemental group id's
  {$EXTERNALSYM NGROUPS_MAX}

  GID_MAX     = 2147483647; // max value for a gid_t (2^31-2)
  {$EXTERNALSYM GID_MAX}
  UID_MAX     = 2147483647; // max value for a uid_t (2^31-2)
  {$EXTERNALSYM UID_MAX}

  OPEN_MAX    = 10240; // max open files per process - todo, make a config option?
  {$EXTERNALSYM OPEN_MAX}

  PATH_MAX    =  1024; // max bytes in pathname
  {$EXTERNALSYM PATH_MAX}
  PIPE_BUF    =   512; // max bytes for atomic pipe writes
  {$EXTERNALSYM PIPE_BUF}

  BC_BASE_MAX        =   99; // max ibase/obase values in bc(1)
  {$EXTERNALSYM BC_BASE_MAX}
  BC_DIM_MAX         = 2048; // max array elements in bc(1)
  {$EXTERNALSYM BC_DIM_MAX}
  BC_SCALE_MAX       =   99; // max scale value in bc(1)
  {$EXTERNALSYM BC_SCALE_MAX}
  BC_STRING_MAX      = 1000; // max const string length in bc(1)
  {$EXTERNALSYM BC_STRING_MAX}
  CHARCLASS_NAME_MAX =   14; // max character class name size
  {$EXTERNALSYM CHARCLASS_NAME_MAX}
  COLL_WEIGHTS_MAX   =    2; // max weights for order keyword
  {$EXTERNALSYM COLL_WEIGHTS_MAX}
  EQUIV_CLASS_MAX    =    2;
  {$EXTERNALSYM EQUIV_CLASS_MAX}
  EXPR_NEST_MAX      =   32; // max expressions nested in expr(1)
  {$EXTERNALSYM EXPR_NEST_MAX}
  LINE_MAX           = 2048; // max bytes in an input line
  {$EXTERNALSYM LINE_MAX}
  RE_DUP_MAX         =  255; // max RE's in interval notation
  {$EXTERNALSYM RE_DUP_MAX}

  NZERO = 20; // default priority [XSI]
  {$EXTERNALSYM NZERO}
          // = ((PRIO_MAX - PRIO_MIN) / 2) + 1
          // range: 0 - 39 [(2 * NZERO) - 1]
          // 0 is not actually used

{from i386/limits.h}
  SCHAR_MAX      = 127;            // min value for a signed char
  {$EXTERNALSYM SCHAR_MAX}
  SCHAR_MIN      = -128;           // max value for a signed char
  {$EXTERNALSYM SCHAR_MIN}

  UCHAR_MAX      = 255;            // max value for an unsigned char
  {$EXTERNALSYM UCHAR_MAX}
  CHAR_MAX       = 127;            // max value for a char
  {$EXTERNALSYM CHAR_MAX}
  CHAR_MIN       = -128;           // min value for a char
  {$EXTERNALSYM CHAR_MIN}

  USHRT_MAX      = 65535;          // max value for an unsigned short
  {$EXTERNALSYM USHRT_MAX}
  SHRT_MAX       = 32767;          // max value for a short
  {$EXTERNALSYM SHRT_MAX}
  SHRT_MIN       = -32768;         // min value for a short
  {$EXTERNALSYM SHRT_MIN}

  UINT_MAX       = $ffffffff;      // max value for an unsigned int
  {$EXTERNALSYM UINT_MAX}
  INT_MAX        = 2147483647;     // max value for an int
  {$EXTERNALSYM INT_MAX}
  INT_MIN        = -2147483647-1;  // min value for an int
  {$EXTERNALSYM INT_MIN}

{$IFNDEF CPU386}
  ULONG_MAX      = $ffffffffffffffff;    // max unsigned long
  {$EXTERNALSYM ULONG_MAX}
  LONG_MAX       = $7fffffffffffffff;    // max signed long
  {$EXTERNALSYM LONG_MAX}
  LONG_MIN       = -$7fffffffffffffff-1; // min signed long
  {$EXTERNALSYM LONG_MIN}
{$ELSE CPU386}
  ULONG_MAX      = $ffffffff;     // max unsigned long
  {$EXTERNALSYM ULONG_MAX}
  LONG_MAX       = 2147483647;    // max signed long
  {$EXTERNALSYM LONG_MAX}
  LONG_MIN       = -2147483647-1; // min signed long
  {$EXTERNALSYM LONG_MIN}
{$ENDIF CPU386}

  ULLONG_MAX     = $ffffffffffffffff;    // max unsigned long long
  {$EXTERNALSYM ULLONG_MAX}
  LLONG_MAX      = $7fffffffffffffff;    // max signed long long
  {$EXTERNALSYM LLONG_MAX}
  LLONG_MIN      = -$7fffffffffffffff-1; // min signed long long
  {$EXTERNALSYM LLONG_MIN}

{$IFNDEF CPU386}
  LONG_BIT       = 64;
  {$EXTERNALSYM LONG_BIT}
{$ELSE CPU386}
  LONG_BIT       = 32;
  {$EXTERNALSYM LONG_BIT}
{$ENDIF CPU386}
  SSIZE_MAX      = LONG_MAX;       // max value for a ssize_t
  {$EXTERNALSYM SSIZE_MAX}
  WORD_BIT       = 32;
  {$EXTERNALSYM WORD_BIT}

  SIZE_T_MAX     = ULONG_MAX;      // max value for a size_t
  {$EXTERNALSYM SIZE_T_MAX}

  UQUAD_MAX      = ULLONG_MAX;
  {$EXTERNALSYM UQUAD_MAX}
  QUAD_MAX       = LLONG_MAX;
  {$EXTERNALSYM QUAD_MAX}
  QUAD_MIN       = LLONG_MIN;
  {$EXTERNALSYM QUAD_MIN}

{from limits.h}
  _POSIX_AIO_LISTIO_MAX = 2;
  {$EXTERNALSYM _POSIX_AIO_LISTIO_MAX}
  _POSIX_AIO_MAX        = 1;
  {$EXTERNALSYM _POSIX_AIO_MAX}
  _POSIX_DELAYTIMER_MAX = 32;
  {$EXTERNALSYM _POSIX_DELAYTIMER_MAX}
  _POSIX_HOST_NAME_MAX  = 255;
  {$EXTERNALSYM _POSIX_HOST_NAME_MAX}
  _POSIX_LOGIN_NAME_MAX = 9;
  {$EXTERNALSYM _POSIX_LOGIN_NAME_MAX}
  _POSIX_MQ_OPEN_MAX    = 8;
  {$EXTERNALSYM _POSIX_MQ_OPEN_MAX}
  _POSIX_MQ_PRIO_MAX    = 32;
  {$EXTERNALSYM _POSIX_MQ_PRIO_MAX}

  _POSIX_ARG_MAX     = 4096;
  {$EXTERNALSYM _POSIX_ARG_MAX}
  _POSIX_CHILD_MAX   = 25;
  {$EXTERNALSYM _POSIX_CHILD_MAX}
  _POSIX_LINK_MAX    = 8;
  {$EXTERNALSYM _POSIX_LINK_MAX}
  _POSIX_MAX_CANON   = 255;
  {$EXTERNALSYM _POSIX_MAX_CANON}
  _POSIX_MAX_INPUT   = 255;
  {$EXTERNALSYM _POSIX_MAX_INPUT}
  _POSIX_NAME_MAX    = 14;
  {$EXTERNALSYM _POSIX_NAME_MAX}
  _POSIX_NGROUPS_MAX = 8;
  {$EXTERNALSYM _POSIX_NGROUPS_MAX}
  _POSIX_OPEN_MAX    = 20;
  {$EXTERNALSYM _POSIX_OPEN_MAX}
  _POSIX_PATH_MAX    = 256;
  {$EXTERNALSYM _POSIX_PATH_MAX}
  _POSIX_PIPE_BUF    = 512;
  {$EXTERNALSYM _POSIX_PIPE_BUF}
  _POSIX_SSIZE_MAX   = 32767;
  {$EXTERNALSYM _POSIX_SSIZE_MAX}
  _POSIX_STREAM_MAX  = 8;
  {$EXTERNALSYM _POSIX_STREAM_MAX}
  _POSIX_TZNAME_MAX  = 6;
  {$EXTERNALSYM _POSIX_TZNAME_MAX}

  _POSIX_RE_DUP_MAX                   = 255;
  {$EXTERNALSYM _POSIX_RE_DUP_MAX}
  _POSIX_RTSIG_MAX                    = 8;
  {$EXTERNALSYM _POSIX_RTSIG_MAX}
  _POSIX_SEM_NSEMS_MAX                = 256;
  {$EXTERNALSYM _POSIX_SEM_NSEMS_MAX}
  _POSIX_SEM_VALUE_MAX                = 32767;
  {$EXTERNALSYM _POSIX_SEM_VALUE_MAX}
  _POSIX_SIGQUEUE_MAX                 = 32;
  {$EXTERNALSYM _POSIX_SIGQUEUE_MAX}
  _POSIX_SS_REPL_MAX                  = 4;
  {$EXTERNALSYM _POSIX_SS_REPL_MAX}
  _POSIX_SYMLINK_MAX                  = 255;
  {$EXTERNALSYM _POSIX_SYMLINK_MAX}
  _POSIX_SYMLOOP_MAX                  = 8;
  {$EXTERNALSYM _POSIX_SYMLOOP_MAX}
  _POSIX_THREAD_DESTRUCTOR_ITERATIONS = 4;
  {$EXTERNALSYM _POSIX_THREAD_DESTRUCTOR_ITERATIONS}
  _POSIX_THREAD_KEYS_MAX              = 128;
  {$EXTERNALSYM _POSIX_THREAD_KEYS_MAX}
  _POSIX_THREAD_THREADS_MAX           = 64;
  {$EXTERNALSYM _POSIX_THREAD_THREADS_MAX}
  _POSIX_TIMER_MAX                    = 32;
  {$EXTERNALSYM _POSIX_TIMER_MAX}
  _POSIX_TRACE_EVENT_NAME_MAX         = 30;
  {$EXTERNALSYM _POSIX_TRACE_EVENT_NAME_MAX}
  _POSIX_TRACE_NAME_MAX               = 8;
  {$EXTERNALSYM _POSIX_TRACE_NAME_MAX}
  _POSIX_TRACE_SYS_MAX                = 8;
  {$EXTERNALSYM _POSIX_TRACE_SYS_MAX}
  _POSIX_TRACE_USER_EVENT_MAX         = 32;
  {$EXTERNALSYM _POSIX_TRACE_USER_EVENT_MAX}
  _POSIX_TTY_NAME_MAX                 = 9;
  {$EXTERNALSYM _POSIX_TTY_NAME_MAX}

  _POSIX2_BC_BASE_MAX           = 99;
  {$EXTERNALSYM _POSIX2_BC_BASE_MAX}
  _POSIX2_BC_DIM_MAX            = 2048;
  {$EXTERNALSYM _POSIX2_BC_DIM_MAX}
  _POSIX2_BC_SCALE_MAX          = 99;
  {$EXTERNALSYM _POSIX2_BC_SCALE_MAX}
  _POSIX2_BC_STRING_MAX         = 1000;
  {$EXTERNALSYM _POSIX2_BC_STRING_MAX}
  _POSIX2_CHARCLASS_NAME_MAX    = 14;
  {$EXTERNALSYM _POSIX2_CHARCLASS_NAME_MAX}
  _POSIX2_COLL_WEIGHTS_MAX      = 2;
  {$EXTERNALSYM _POSIX2_COLL_WEIGHTS_MAX}
  _POSIX2_EQUIV_CLASS_MAX       = 2;
  {$EXTERNALSYM _POSIX2_EQUIV_CLASS_MAX}
  _POSIX2_EXPR_NEST_MAX         = 32;
  {$EXTERNALSYM _POSIX2_EXPR_NEST_MAX}
  _POSIX2_LINE_MAX              = 2048;
  {$EXTERNALSYM _POSIX2_LINE_MAX}
  _POSIX2_RE_DUP_MAX            = 255;
  {$EXTERNALSYM _POSIX2_RE_DUP_MAX}

  PTHREAD_STACK_MIN             = 8192;
  {$EXTERNALSYM PTHREAD_STACK_MIN}
  PTHREAD_DESTRUCTOR_ITERATIONS = 4;
  {$EXTERNALSYM PTHREAD_DESTRUCTOR_ITERATIONS}
  PTHREAD_KEYS_MAX              = 512;
  {$EXTERNALSYM PTHREAD_KEYS_MAX}
