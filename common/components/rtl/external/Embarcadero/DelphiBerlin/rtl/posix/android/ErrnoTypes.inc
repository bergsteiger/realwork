{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

const
  EPERM           =  1;           // Operation not permitted
  {$EXTERNALSYM EPERM}
  ENOENT          =  2;           // No such file or directory
  {$EXTERNALSYM ENOENT}
  ESRCH           =  3;           // No such process
  {$EXTERNALSYM ESRCH}
  EINTR           =  4;           // Interrupted system call
  {$EXTERNALSYM EINTR}
  EIO             =  5;           // I/O error
  {$EXTERNALSYM EIO}
  ENXIO           =  6;           // No such device or address
  {$EXTERNALSYM ENXIO}
  E2BIG           =  7;           // Argument list too long
  {$EXTERNALSYM E2BIG}
  ENOEXEC         =  8;           // Exec format error
  {$EXTERNALSYM ENOEXEC}
  EBADF           =  9;           // Bad file number
  {$EXTERNALSYM EBADF}
  ECHILD          = 10;           // No child processes
  {$EXTERNALSYM ECHILD}
  EAGAIN          = 11;           // Try again
  {$EXTERNALSYM EAGAIN}
  ENOMEM          = 12;           // Out of memory
  {$EXTERNALSYM ENOMEM}
  EACCES          = 13;           // Permission denied
  {$EXTERNALSYM EACCES}
  EFAULT          = 14;           // Bad address
  {$EXTERNALSYM EFAULT}
  ENOTBLK         = 15;           // Block device required
  {$EXTERNALSYM ENOTBLK}
  EBUSY           = 16;           // Device or resource busy
  {$EXTERNALSYM EBUSY}
  EEXIST          = 17;           // File exists
  {$EXTERNALSYM EEXIST}
  EXDEV           = 18;           // Cross-device link
  {$EXTERNALSYM EXDEV}
  ENODEV          = 19;           // No such device
  {$EXTERNALSYM ENODEV}
  ENOTDIR         = 20;           // Not a directory
  {$EXTERNALSYM ENOTDIR}
  EISDIR          = 21;           // Is a directory
  {$EXTERNALSYM EISDIR}
  EINVAL          = 22;           // Invalid argument
  {$EXTERNALSYM EINVAL}
  ENFILE          = 23;           // File table overflow
  {$EXTERNALSYM ENFILE}
  EMFILE          = 24;           // Too many open files
  {$EXTERNALSYM EMFILE}
  ENOTTY          = 25;           // Not a typewriter
  {$EXTERNALSYM ENOTTY}
  ETXTBSY         = 26;           // Text file busy
  {$EXTERNALSYM ETXTBSY}
  EFBIG           = 27;           // File too large
  {$EXTERNALSYM EFBIG}
  ENOSPC          = 28;           // No space left on device
  {$EXTERNALSYM ENOSPC}
  ESPIPE          = 29;           // Illegal seek
  {$EXTERNALSYM ESPIPE}
  EROFS           = 30;           // Read-only file system
  {$EXTERNALSYM EROFS}
  EMLINK          = 31;           // Too many links
  {$EXTERNALSYM EMLINK}
  EPIPE           = 32;           // Broken pipe
  {$EXTERNALSYM EPIPE}
  EDOM            = 33;           // Math argument out of domain of func
  {$EXTERNALSYM EDOM}
  ERANGE          = 34;           // Math result not representable
  {$EXTERNALSYM ERANGE}

  EDEADLK         = 35;           // Resource deadlock would occur
  {$EXTERNALSYM EDEADLK}
  ENAMETOOLONG    = 36;           // File name too long
  {$EXTERNALSYM ENAMETOOLONG}
  ENOLCK          = 37;           // No record locks available
  {$EXTERNALSYM ENOLCK}
  ENOSYS          = 38;           // Function not implemented
  {$EXTERNALSYM ENOSYS}
  ENOTEMPTY       = 39;           // Directory not empty
  {$EXTERNALSYM ENOTEMPTY}
  ELOOP           = 40;           // Too many symbolic links encountered
  {$EXTERNALSYM ELOOP}
  EWOULDBLOCK     = EAGAIN;       // Operation would block
  {$EXTERNALSYM EWOULDBLOCK}
  ENOMSG          = 42;           // No message of desired type
  {$EXTERNALSYM ENOMSG}
  EIDRM           = 43;           // Identifier removed
  {$EXTERNALSYM EIDRM}
  ECHRNG          = 44 platform;  // Channel number out of range
  {$EXTERNALSYM ECHRNG}
  EL2NSYNC        = 45 platform;  // Level 2 not synchronized
  {$EXTERNALSYM EL2NSYNC}
  EL3HLT          = 46 platform;  // Level 3 halted
  {$EXTERNALSYM EL3HLT}
  EL3RST          = 47 platform;  // Level 3 reset
  {$EXTERNALSYM EL3RST}
  ELNRNG          = 48 platform;  // Link number out of range
  {$EXTERNALSYM ELNRNG}
  EUNATCH         = 49 platform;  // Protocol driver not attached
  {$EXTERNALSYM EUNATCH}
  ENOCSI          = 50 platform;  // No CSI structure available
  {$EXTERNALSYM ENOCSI}
  EL2HLT          = 51 platform;  // Level 2 halted
  {$EXTERNALSYM EL2HLT}
  EBADE           = 52 platform;  // Invalid exchange
  {$EXTERNALSYM EBADE}
  EBADR           = 53 platform;  // Invalid request descriptor
  {$EXTERNALSYM EBADR}
  EXFULL          = 54 platform;  // Exchange full
  {$EXTERNALSYM EXFULL}
  ENOANO          = 55 platform;  // No anode
  {$EXTERNALSYM ENOANO}
  EBADRQC         = 56 platform;  // Invalid request code
  {$EXTERNALSYM EBADRQC}
  EBADSLT         = 57 platform;  // Invalid slot
  {$EXTERNALSYM EBADSLT}

  EDEADLOCK       = EDEADLK;
  {$EXTERNALSYM EDEADLOCK}

  EBFONT          = 59;           // Bad font file format
  {$EXTERNALSYM EBFONT}
  ENOSTR          = 60;           // Device not a stream
  {$EXTERNALSYM ENOSTR}
  ENODATA         = 61;           // No data available
  {$EXTERNALSYM ENODATA}
  ETIME           = 62;           // Timer expired
  {$EXTERNALSYM ETIME}
  ENOSR           = 63 platform;  // Out of streams resources
  {$EXTERNALSYM ENOSR}
  ENONET          = 64 platform;  // Machine is not on the network
  {$EXTERNALSYM ENONET}
  ENOPKG          = 65 platform;  // Package not installed
  {$EXTERNALSYM ENOPKG}
  EREMOTE         = 66 platform;  // Object is remote
  {$EXTERNALSYM EREMOTE}
  ENOLINK         = 67;           // Link has been severed
  {$EXTERNALSYM ENOLINK}
  EADV            = 68 platform;  // Advertise error
  {$EXTERNALSYM EADV}
  ESRMNT          = 69 platform;  // Srmount error
  {$EXTERNALSYM ESRMNT}
  ECOMM           = 70 platform;  // Communication error on send
  {$EXTERNALSYM ECOMM}
  EPROTO          = 71;           // Protocol error
  {$EXTERNALSYM EPROTO}
  EMULTIHOP       = 72;           // Multihop attempted
  {$EXTERNALSYM EMULTIHOP}
  EDOTDOT         = 73 platform;  // RFS specific error
  {$EXTERNALSYM EDOTDOT}
  EBADMSG         = 74;           // Not a data message
  {$EXTERNALSYM EBADMSG}
  EOVERFLOW       = 75;           // Value too large for defined data type
  {$EXTERNALSYM EOVERFLOW}
  ENOTUNIQ        = 76 platform;  // Name not unique on network
  {$EXTERNALSYM ENOTUNIQ}
  EBADFD          = 77;           // File descriptor in bad state
  {$EXTERNALSYM EBADFD}
  EREMCHG         = 78 platform;  // Remote address changed
  {$EXTERNALSYM EREMCHG}
  ELIBACC         = 79 platform;  // Can not access a needed shared library
  {$EXTERNALSYM ELIBACC}
  ELIBBAD         = 80 platform;  // Accessing a corrupted shared library
  {$EXTERNALSYM ELIBBAD}
  ELIBSCN         = 81 platform;  // .lib section in a.out corrupted
  {$EXTERNALSYM ELIBSCN}
  ELIBMAX         = 82 platform;  // Attempting to link in too many shared libraries
  {$EXTERNALSYM ELIBMAX}
  ELIBEXEC        = 83 platform;  // Cannot exec a shared library directly
  {$EXTERNALSYM ELIBEXEC}
  EILSEQ          = 84;           // Illegal byte sequence
  {$EXTERNALSYM EILSEQ}
  ERESTART        = 85 platform;  // Interrupted system call should be restarted
  {$EXTERNALSYM ERESTART}
  ESTRPIPE        = 86 platform;  // Streams pipe error
  {$EXTERNALSYM ESTRPIPE}
  EUSERS          = 87 platform;  // Too many users
  {$EXTERNALSYM EUSERS}
  ENOTSOCK        = 88;           // Socket operation on non-socket
  {$EXTERNALSYM ENOTSOCK}
  EDESTADDRREQ    = 89;           // Destination address required
  {$EXTERNALSYM EDESTADDRREQ}
  EMSGSIZE        = 90;           // Message too long
  {$EXTERNALSYM EMSGSIZE}
  EPROTOTYPE      = 91;           // Protocol wrong type for socket
  {$EXTERNALSYM EPROTOTYPE}
  ENOPROTOOPT     = 92;           // Protocol not available
  {$EXTERNALSYM ENOPROTOOPT}
  EPROTONOSUPPORT = 93;           // Protocol not supported
  {$EXTERNALSYM EPROTONOSUPPORT}
  ESOCKTNOSUPPORT = 94 platform;  // Socket type not supported
  {$EXTERNALSYM ESOCKTNOSUPPORT}
  EOPNOTSUPP      = 95;           // Operation not supported on transport endpoint
  {$EXTERNALSYM EOPNOTSUPP}
  EPFNOSUPPORT    = 96 platform;  // Protocol family not supported
  {$EXTERNALSYM EPFNOSUPPORT}
  EAFNOSUPPORT    = 97;           // Address family not supported by protocol
  {$EXTERNALSYM EAFNOSUPPORT}
  EADDRINUSE      = 98;           // Address already in use
  {$EXTERNALSYM EADDRINUSE}
  EADDRNOTAVAIL   = 99;           // Cannot assign requested address
  {$EXTERNALSYM EADDRNOTAVAIL}
  ENETDOWN        = 100;          // Network is down
  {$EXTERNALSYM ENETDOWN}
  ENETUNREACH     = 101;          // Network is unreachable
  {$EXTERNALSYM ENETUNREACH}
  ENETRESET       = 102;          // Network dropped connection because of reset
  {$EXTERNALSYM ENETRESET}
  ECONNABORTED    = 103;          // Software caused connection abort
  {$EXTERNALSYM ECONNABORTED}
  ECONNRESET      = 104;          // Connection reset by peer
  {$EXTERNALSYM ECONNRESET}
  ENOBUFS         = 105;          // No buffer space available
  {$EXTERNALSYM ENOBUFS}
  EISCONN         = 106;          // Transport endpoint is already connected
  {$EXTERNALSYM EISCONN}
  ENOTCONN        = 107;          // Transport endpoint is not connected
  {$EXTERNALSYM ENOTCONN}
  ESHUTDOWN       = 108 platform; // Cannot send after transport endpoint shutdown
  {$EXTERNALSYM ESHUTDOWN}
  ETOOMANYREFS    = 109 platform; // Too many references: cannot splice
  {$EXTERNALSYM ETOOMANYREFS}
  ETIMEDOUT       = 110;          // Connection timed out
  {$EXTERNALSYM ETIMEDOUT}
  ECONNREFUSED    = 111;          // Connection refused
  {$EXTERNALSYM ECONNREFUSED}
  EHOSTDOWN       = 112 platform; // Host is down
  {$EXTERNALSYM EHOSTDOWN}
  EHOSTUNREACH    = 113;          // No route to host
  {$EXTERNALSYM EHOSTUNREACH}
  EALREADY        = 114;          // Operation already in progress
  {$EXTERNALSYM EALREADY}
  EINPROGRESS     = 115;          // Operation now in progress
  {$EXTERNALSYM EINPROGRESS}
  ESTALE          = 116;          // Stale NFS file handle
  {$EXTERNALSYM ESTALE}
  EUCLEAN         = 117 platform; // Structure needs cleaning
  {$EXTERNALSYM EUCLEAN}
  ENOTNAM         = 118 platform; // Not a XENIX named type file
  {$EXTERNALSYM ENOTNAM}
  ENAVAIL         = 119 platform; // No XENIX semaphores available
  {$EXTERNALSYM ENAVAIL}
  EISNAM          = 120 platform; // Is a named type file
  {$EXTERNALSYM EISNAM}
  EREMOTEIO       = 121 platform; // Remote I/O error
  {$EXTERNALSYM EREMOTEIO}
  EDQUOT          = 122;          // Quota exceeded
  {$EXTERNALSYM EDQUOT}

  ENOMEDIUM       = 123 platform; // No medium found
  {$EXTERNALSYM ENOMEDIUM}
  EMEDIUMTYPE     = 124 platform; // Wrong medium type
  {$EXTERNALSYM EMEDIUMTYPE}
  ECANCELED       = 125;          // Operation Canceled
  {$EXTERNALSYM ECANCELED}
  ENOKEY          = 126 platform; // Required key not available
  {$EXTERNALSYM ENOKEY}
  EKEYEXPIRED     = 127 platform; // Key has expired
  {$EXTERNALSYM EKEYEXPIRED}
  EKEYREVOKED     = 128 platform; // Key has been revoked
  {$EXTERNALSYM EKEYREVOKED}
  EKEYREJECTED    = 129 platform; // Key was rejected by service
  {$EXTERNALSYM EKEYREJECTED}

// for robust mutexes
  EOWNERDEAD      = 130 platform; // Owner died
  {$EXTERNALSYM EOWNERDEAD}
  ENOTRECOVERABLE = 131 platform; // State not recoverable
  {$EXTERNALSYM ENOTRECOVERABLE}
  
  ENOTSUP        = EOPNOTSUPP;
  {$EXTERNALSYM EOPNOTSUPP}
