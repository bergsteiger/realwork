{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

const
  EPERM            = 1;            // Operation not permitted 
  {$EXTERNALSYM EPERM}
  ENOENT           = 2;            // No such file or directory 
  {$EXTERNALSYM ENOENT}
  ESRCH            = 3;            // No such process 
  {$EXTERNALSYM ESRCH}
  EINTR            = 4;            // Interrupted system call 
  {$EXTERNALSYM EINTR}
  EIO              = 5;            // Input/output error 
  {$EXTERNALSYM EIO}
  ENXIO            = 6;            // Device not configured 
  {$EXTERNALSYM ENXIO}
  E2BIG            = 7;            // Argument list too long 
  {$EXTERNALSYM E2BIG}
  ENOEXEC          = 8;            // Exec format error 
  {$EXTERNALSYM ENOEXEC}
  EBADF            = 9;            // Bad file descriptor 
  {$EXTERNALSYM EBADF}
  ECHILD           = 10;           // No child processes 
  {$EXTERNALSYM ECHILD}
  EDEADLK          = 11;           // Resource deadlock avoided 
  {$EXTERNALSYM EDEADLK}
                                        // 11 was EAGAIN 
  ENOMEM           = 12;           // Cannot allocate memory 
  {$EXTERNALSYM ENOMEM}
  EACCES           = 13;           // Permission denied 
  {$EXTERNALSYM EACCES}
  EFAULT           = 14;           // Bad address 
  {$EXTERNALSYM EFAULT}
  ENOTBLK          = 15 platform;  // Block device required 
  {$EXTERNALSYM ENOTBLK}
  EBUSY            = 16;           // Device / Resource busy 
  {$EXTERNALSYM EBUSY}
  EEXIST           = 17;           // File exists 
  {$EXTERNALSYM EEXIST}
  EXDEV            = 18;           // Cross-device link 
  {$EXTERNALSYM EXDEV}
  ENODEV           = 19;           // Operation not supported by device 
  {$EXTERNALSYM ENODEV}
  ENOTDIR          = 20;           // Not a directory 
  {$EXTERNALSYM ENOTDIR}
  EISDIR           = 21;           // Is a directory 
  {$EXTERNALSYM EISDIR}
  EINVAL           = 22;           // Invalid argument 
  {$EXTERNALSYM EINVAL}
  ENFILE           = 23;           // Too many open files in system 
  {$EXTERNALSYM ENFILE}
  EMFILE           = 24;           // Too many open files 
  {$EXTERNALSYM EMFILE}
  ENOTTY           = 25;           // Inappropriate ioctl for device 
  {$EXTERNALSYM ENOTTY}
  ETXTBSY          = 26;           // Text file busy 
  {$EXTERNALSYM ETXTBSY}
  EFBIG            = 27;           // File too large 
  {$EXTERNALSYM EFBIG}
  ENOSPC           = 28;           // No space left on device 
  {$EXTERNALSYM ENOSPC}
  ESPIPE           = 29;           // Illegal seek 
  {$EXTERNALSYM ESPIPE}
  EROFS            = 30;           // Read-only file system 
  {$EXTERNALSYM EROFS}
  EMLINK           = 31;           // Too many links 
  {$EXTERNALSYM EMLINK}
  EPIPE            = 32;           // Broken pipe 
  {$EXTERNALSYM EPIPE}

// math software 
  EDOM             = 33;           // Numerical argument out of domain 
  {$EXTERNALSYM EDOM}
  ERANGE           = 34;           // Result too large 
  {$EXTERNALSYM ERANGE}

// non-blocking and interrupt i/o 
  EAGAIN           = 35;           // Resource temporarily unavailable 
  {$EXTERNALSYM EAGAIN}
  EWOULDBLOCK      = EAGAIN;       // Operation would block 
  {$EXTERNALSYM EWOULDBLOCK}
  EINPROGRESS      = 36;           // Operation now in progress 
  {$EXTERNALSYM EINPROGRESS}
  EALREADY         = 37;           // Operation already in progress 
  {$EXTERNALSYM EALREADY}

// ipc/network software --; argument error/ 
  ENOTSOCK         = 38;           // Socket operation on non-socket 
  {$EXTERNALSYM ENOTSOCK}
  EDESTADDRREQ     = 39;           // Destination address required 
  {$EXTERNALSYM EDESTADDRREQ}
  EMSGSIZE         = 40;           // Message too long 
  {$EXTERNALSYM EMSGSIZE}
  EPROTOTYPE       = 41;           // Protocol wrong type for socket 
  {$EXTERNALSYM EPROTOTYPE}
  ENOPROTOOPT      = 42;           // Protocol not available 
  {$EXTERNALSYM ENOPROTOOPT}
  EPROTONOSUPPORT  = 43;           // Protocol not supported 
  {$EXTERNALSYM EPROTONOSUPPORT}
  ESOCKTNOSUPPORT  = 44 platform;  // Socket type not supported 
  {$EXTERNALSYM ESOCKTNOSUPPORT}
  ENOTSUP          = 45;           // Operation not supported 
  {$EXTERNALSYM ENOTSUP}

  EPFNOSUPPORT     = 46 platform;  // Protocol family not supported 
  {$EXTERNALSYM EPFNOSUPPORT}
  EAFNOSUPPORT     = 47;           // Address family not supported by protocol family 
  {$EXTERNALSYM EAFNOSUPPORT}
  EADDRINUSE       = 48;           // Address already in use 
  {$EXTERNALSYM EADDRINUSE}
  EADDRNOTAVAIL    = 49;           // Can't assign requested address 
  {$EXTERNALSYM EADDRNOTAVAIL}

// ipc/network software --; operational errors 
  ENETDOWN         = 50;           // Network is down 
  {$EXTERNALSYM ENETDOWN}
  ENETUNREACH      = 51;           // Network is unreachable 
  {$EXTERNALSYM ENETUNREACH}
  ENETRESET        = 52;           // Network dropped connection on reset 
  {$EXTERNALSYM ENETRESET}
  ECONNABORTED     = 53;           // Software caused connection abort 
  {$EXTERNALSYM ECONNABORTED}
  ECONNRESET       = 54;           // Connection reset by peer 
  {$EXTERNALSYM ECONNRESET}
  ENOBUFS          = 55;           // No buffer space available 
  {$EXTERNALSYM ENOBUFS}
  EISCONN          = 56;           // Socket is already connected 
  {$EXTERNALSYM EISCONN}
  ENOTCONN         = 57;           // Socket is not connected 
  {$EXTERNALSYM ENOTCONN}
  ESHUTDOWN        = 58 platform;  // Can't send after socket shutdown 
  {$EXTERNALSYM ESHUTDOWN}
  ETOOMANYREFS     = 59 platform;  // Too many references: can't splice 
  {$EXTERNALSYM ETOOMANYREFS}
  ETIMEDOUT        = 60;           // Operation timed out 
  {$EXTERNALSYM ETIMEDOUT}
  ECONNREFUSED     = 61;           // Connection refused 
  {$EXTERNALSYM ECONNREFUSED}

  ELOOP            = 62;           // Too many levels of symbolic links 
  {$EXTERNALSYM ELOOP}
  ENAMETOOLONG     = 63;           // File name too long 
  {$EXTERNALSYM ENAMETOOLONG}

// should be rearranged 
  EHOSTDOWN        = 64 platform;  // Host is down 
  {$EXTERNALSYM EHOSTDOWN}
  EHOSTUNREACH     = 65;           // No route to host 
  {$EXTERNALSYM EHOSTUNREACH}
  ENOTEMPTY        = 66;           // Directory not empty 
  {$EXTERNALSYM ENOTEMPTY}

// quotas & mush 
  EPROCLIM         = 67 platform;  // Too many processes 
  {$EXTERNALSYM EPROCLIM}
  EUSERS           = 68 platform;  // Too many users 
  {$EXTERNALSYM EUSERS}
  EDQUOT           = 69;           // Disc quota exceeded 
  {$EXTERNALSYM EDQUOT}

// Network File System 
  ESTALE           = 70;           // Stale NFS file handle 
  {$EXTERNALSYM ESTALE}
  EREMOTE          = 71 platform;  // Too many levels of remote in path 
  {$EXTERNALSYM EREMOTE}
  EBADRPC          = 72 platform;  // RPC struct is bad 
  {$EXTERNALSYM EBADRPC}
  ERPCMISMATCH     = 73 platform;  // RPC version wrong 
  {$EXTERNALSYM ERPCMISMATCH}
  EPROGUNAVAIL     = 74 platform;  // RPC prog. not avail 
  {$EXTERNALSYM EPROGUNAVAIL}
  EPROGMISMATCH    = 75 platform;  // Program version wrong 
  {$EXTERNALSYM EPROGMISMATCH}
  EPROCUNAVAIL     = 76 platform;  // Bad procedure for program 
  {$EXTERNALSYM EPROCUNAVAIL}

  ENOLCK           = 77;           // No locks available 
  {$EXTERNALSYM ENOLCK}
  ENOSYS           = 78;           // Function not implemented 
  {$EXTERNALSYM ENOSYS}

  EFTYPE           = 79 platform;  // Inappropriate file type or format 
  {$EXTERNALSYM EFTYPE}
  EAUTH            = 80 platform;  // Authentication error 
  {$EXTERNALSYM EAUTH}
  ENEEDAUTH        = 81 platform;  // Need authenticator 
  {$EXTERNALSYM ENEEDAUTH}

// Intelligent device errors 
  EPWROFF          = 82 platform;  // Device power is off 
  {$EXTERNALSYM EPWROFF}
  EDEVERR          = 83 platform;  // Device error, e.g. paper out 
  {$EXTERNALSYM EDEVERR}

  EOVERFLOW        = 84;           // Value too large to be stored in data type 
  {$EXTERNALSYM EOVERFLOW}

// Program loading errors
  EBADEXEC         = 85 platform;  // Bad executable 
  {$EXTERNALSYM EBADEXEC}
  EBADARCH         = 86 platform;  // Bad CPU type in executable 
  {$EXTERNALSYM EBADARCH}
  ESHLIBVERS       = 87 platform;  // Shared library version mismatch 
  {$EXTERNALSYM ESHLIBVERS}
  EBADMACHO        = 88 platform;  // Malformed Macho file 
  {$EXTERNALSYM EBADMACHO}

  ECANCELED        = 89;           // Operation canceled 
  {$EXTERNALSYM ECANCELED}

  EIDRM            = 90;           // Identifier removed 
  {$EXTERNALSYM EIDRM}
  ENOMSG           = 91;           // No message of desired type    
  {$EXTERNALSYM ENOMSG}
  EILSEQ           = 92;           // Illegal byte sequence 
  {$EXTERNALSYM EILSEQ}
  ENOATTR          = 93 platform;  // Attribute not found 
  {$EXTERNALSYM ENOATTR}

  EBADMSG          = 94;           // Bad message 
  {$EXTERNALSYM EBADMSG}
  EMULTIHOP        = 95;           // Reserved 
  {$EXTERNALSYM EMULTIHOP}
  ENODATA          = 96;           // No message available on STREAM 
  {$EXTERNALSYM ENODATA}
  ENOLINK          = 97;           // Reserved 
  {$EXTERNALSYM ENOLINK}
  ENOSR            = 98;           // No STREAM resources 
  {$EXTERNALSYM ENOSR}
  ENOSTR           = 99;           // Not a STREAM 
  {$EXTERNALSYM ENOSTR}
  EPROTO           = 100;          // Protocol error 
  {$EXTERNALSYM EPROTO}
  ETIME            = 101;          // STREAM ioctl timeout 
  {$EXTERNALSYM ETIME}

// This value is only discrete when compiing __DARWIN_UNIX03, or KERNEL 
  EOPNOTSUPP       = 102;          // Operation not supported on socket 
  {$EXTERNALSYM EOPNOTSUPP}

(*This is the same for binary and source copmpatability, unless compiling
  the kernel itself, or compiling __DARWIN_UNIX03; if compiling for the
  kernel, the correct value will be returned.  If compiling non-POSIX
  source, the kernel return value will be converted by a stub in libc, and
  if compiling source with __DARWIN_UNIX03, the conversion in libc is not
  done, and the caller gets the expected (discrete) value. 
  EOPNOTSUPP       =  ENOTSUP;     // Operation not supported on socket 
  {$EXTERNALSYM EOPNOTSUPP}
*)
  ENOPOLICY        = 103 platform; // No such policy registered 
  {$EXTERNALSYM ENOPOLICY}

  ELAST            = 103 platform; // Must be equal largest errno 
  {$EXTERNALSYM ELAST}

