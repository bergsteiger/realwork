
#pragma warning(disable:4786 4250)

// pthread(s) stuff for windows
#if defined(HAVE_THREADS)
#define HAVE_SEMAPHORE_H 1
#define HAVE_SCHED_H 1
#define HAVE_PTHREAD_H 1
#endif


/* Define to empty if the keyword does not work.  */
/*#undef const */

/* Define if you don't have vprintf but do have _doprnt.  */
/* #undef HAVE_DOPRNT */

/* Define if you have the vprintf function.  */
#define HAVE_VPRINTF 1

/* Define as __inline if that's what the C compiler calls it.  */
/* #undef inline */

/* Define if you need to in order for stat and other things to work.  */
/* #undef _POSIX_SOURCE */

/* Define if you have the ANSI C header files.  */
#define STDC_HEADERS 1

/* Define if you can safely include both <sys/time.h> and <time.h>.  */
#define TIME_WITH_SYS_TIME 1

/* Define if your processor stores words with the most significant
   byte first (like Motorola and SPARC, unlike Intel and VAX).  */
/* #undef WORDS_BIGENDIAN */

/* Define if the X Window System is missing or not being used.  */
#define X_DISPLAY_MISSING 1

/* whether or not --enable-mini-stl is used */
/* #define HAVE_MINI_STL 1 */

/* whether we have byteorder big endian */
/* #undef HAVE_BYTEORDER_BE */

/* whether we have byteorder little endian */
#define HAVE_BYTEORDER_LE 1

/* whether we have a prototype for gethostname */
#define HAVE_GETHOSTNAME_PROTO 1

/* whether we have a prototype for finite */
#define HAVE_FINITE_PROTO 1

/* whether we have a prototype for strerror */
#define HAVE_STRERROR_PROTO 1

/* whether we have a prototype for ftime */
#define HAVE_FTIME_PROTO 1

/* whether C++ compiler supports exception handling */
#define HAVE_EXCEPTS 1

/* whether C++ compiler supports exceptions in shared libs */
#define HAVE_SHARED_EXCEPTS 1

/* whether C++ compiler supports standard exception handling */
#define HAVE_STD_EH 1

/* whether to built ORB with exception support */
#define HAVE_ORB_EXCEPTS 1

/* whether we need to explicitely call global ctors in dlopen()ed module */
/* #undef HAVE_EXPLICIT_CTORS */

/* whether we have IEEE compliant floating point types */
#define HAVE_IEEE_FP 1

/* whether or not class foo { friend void f <> (); } works */
/* #undef HAVE_GUIDING_DECLS */

/* whether or not namespaces work */
#define HAVE_NAMESPACE 1

/* type of size argument to socket calls */
#define socket_size_t int

/* type of sockaddr argument to socket calls */
#define socket_addr_t struct sockaddr *

/* type of fd_set arguments to select calls */
#define select_addr_t fd_set *

/* whether gettimeofday has two args */
/* #undef HAVE_GETTIMEOFDAY_TWOARGS */

/* whether or not he have SSLeay */
/* #undef HAVE_SSL */

/* whether or not bool is supported by C++ compiler */
#define HAVE_BOOL_TYPE 1

/* whether or not typename is supported by C++ compiler */
#define HAVE_TYPENAME 1

/* whether or not scanf ("%Lf", ...) works */
#define HAVE_SCANF_LF 1

/* whether or not scanf ("%Lf", ...) works */
#define HAVE_PRINTF_LF 1

/* whether the system supports dynamic module loading */
/* #undef HAVE_DYNAMIC */

/* whether the c++ compiler supports const overload of conversion operators */
#define HAVE_CONST_OVERLOAD 1

/* whether virtual methods inherited from two or more base class must be
   overridden */
#define HAVE_EXPLICIT_METHOD_OVERRIDE 1

/* whether the compiler fails to automatically generate working
   copy constructors, assignment operators and destructors on structs
   with template members */
/* #undef HAVE_EXPLICIT_STRUCT_OPS */

/* whether we can use the advanced memchecker */
/* #undef USE_MEMTRACE */

/* whether a derived class can override a typedef in the base class */
#define HAVE_TYPEDEF_OVERLOAD 1

/* whether we support dynamic_cast<> */
#define HAVE_DYNAMIC_CAST 1

/* whether to build CCM-specific parts */
/* #define USE_CCM 1 */

/* path information */
#define ABSEXECDIR "c:/Frank/mico"
#define ABSSHRDDIR "c:/Frank/mico"

/* whether ANSI C++ header files are present */
#if !defined(__MINGW32__)
#define HAVE_ANSI_CPLUSPLUS_HEADERS
#endif

/* The number of bytes in a double.  */
#define SIZEOF_DOUBLE 8

/* The number of bytes in a float.  */
#define SIZEOF_FLOAT 4

/* The number of bytes in a int.  */
#define SIZEOF_INT 4

/* The number of bytes in a long.  */
#define SIZEOF_LONG 4

/* The number of bytes in a long double.  */
#define SIZEOF_LONG_DOUBLE 12

/* The number of bytes in a long long.  */
/* #define SIZEOF_LONG_LONG 8 */

/* The number of bytes in a short.  */
#define SIZEOF_SHORT 2

/* The number of bytes in a unsigned char.  */
#define SIZEOF_UNSIGNED_CHAR 1

/* The number of bytes in a unsigned int.  */
#define SIZEOF_UNSIGNED_INT 4

/* The number of bytes in a unsigned long.  */
#define SIZEOF_UNSIGNED_LONG 4

/* The number of bytes in a unsigned long long.  */
/* #define SIZEOF_UNSIGNED_LONG_LONG 8 */

/* The number of bytes in a unsigned short.  */
#define SIZEOF_UNSIGNED_SHORT 2

/* Define if you have the asinl function.  */
/* #undef HAVE_ASINL */

/* Define if you have the ceill function.  */
/* #undef HAVE_CEILL */

/* Define if you have the dlopen function.  */
/* #undef HAVE_DLOPEN */

/* Define if you have the fabsl function.  */
/* #undef HAVE_FABSL */

/* Define if you have the finite function.  */
#define HAVE_FINITE 1

/* Define if you have the floorl function.  */
/* #undef HAVE_FLOORL */

/* Define if you have the fmodl function.  */
/* #undef HAVE_FMODL */

/* Define if you have the frexpl function.  */
/* #undef HAVE_FREXPL */

/* Define if you have the ftime function.  */
#define HAVE_FTIME 1

/* Define if you have the gethostname function.  */
#define HAVE_GETHOSTNAME 1

/* Define if you have the infnan function.  */
/* #undef HAVE_INFNAN */

/* Define if you have the infnanl function.  */
/* #undef HAVE_INFNANL */

/* Define if you have the isinf function.  */
/* #undef HAVE_ISINF */

/* Define if you have the isinfl function.  */
/* #undef HAVE_ISINFL */

/* Define if you have the isnan function.  */
/* #undef HAVE_ISNAN */

/* Define if you have the isnanl function.  */
/* #undef HAVE_ISNANL */

/* Define if you have the ldexpl function.  */
/* #undef HAVE_LDEXPL */

/* Define if you have the powl function.  */
/* #undef HAVE_POWL */

/* Define if you have the shl_load function.  */
/* #undef HAVE_SHL_LOAD */

/* Define if you have the strdup function.  */
#define HAVE_STRDUP 1

/* Define if you have the strerror function.  */
#define HAVE_STRERROR 1

/* Define if you have the <arpa/inet.h> header file.  */
#define HAVE_ARPA_INET_H 1

/* Define if you have the <bfd.h> header file.  */
/* #undef HAVE_BFD_H */

/* Define if you have the <byteorder.h> header file.  */
/* #undef HAVE_BYTEORDER_H */

/* Define if you have the <dl.h> header file.  */
/* #undef HAVE_DL_H */

/* Define if you have the <dlfcn.h> header file.  */
/* #undef HAVE_DLFCN_H */

/* Define if you have the <exception> header file.  */
#define HAVE_EXCEPTION 1

/* Define if you have the <exception.h> header file.  */
/* #undef HAVE_EXCEPTION_H */

/* Define if you have the <fcntl.h> header file.  */
#define HAVE_FCNTL_H 1

/* Define if you have the <float.h> header file.  */
#define HAVE_FLOAT_H 1

/* Define if you have the <ieeefp.h> header file.  */
/* #undef HAVE_IEEEFP_H */

/* Define if you have the <iostream> header file.  */
#define HAVE_IOSTREAM 1

/* Define if you have the <link.h> header file.  */
/* #undef HAVE_LINK_H */

/* Define if you have the <map> header file.  */
#define HAVE_MAP 1

/* Define if you have the <netdb.h> header file.  */
/* #undef HAVE_NETDB_H */

/* Define if you have the <netinet/in.h> header file.  */
/* #undef HAVE_NETINET_IN_H */

/* Define if you have the <netinet/tcp.h> header file.  */
/* #undef HAVE_NETINET_TCP_H */

/* Define if you have the <openssl/ssl.h> header file.  */
/* #undef HAVE_OPENSSL_SSL_H */

/* Define if you have the <qapplication.h> header file.  */
/* #undef HAVE_QAPPLICATION_H */

/* Define if you have the <qlineedit.h> header file.  */
/* #undef HAVE_QLINEEDIT_H */

/* Define if you have the <qsocketnotifier.h> header file.  */
/* #undef HAVE_QSOCKETNOTIFIER_H */

/* Define if you have the <sstream> header file.  */
#define HAVE_SSTREAM 1

/* Define if you have the <stdlib.h> header file.  */
#define HAVE_STDLIB_H 1

/* Define if you have the <string> header file.  */
#define HAVE_STRING 1

/* Define if you have the <strings.h> header file.  */
/* #undef HAVE_STRINGS_H */

/* Define if you have the <sunmath.h> header file.  */
/* #undef HAVE_SUNMATH_H */

/* Define if you have the <sys/select.h> header file.  */
/* #undef HAVE_SYS_SELECT_H */

/* Define if you have the <sys/time.h> header file.  */
/* #undef HAVE_SYS_TIME_H */

/* Define if you have the <sys/un.h> header file.  */
/* #undef HAVE_SYS_UN_H */

/* Define if you have the <terminate.h> header file.  */
/* #undef HAVE_TERMINATE_H */

/* Define if you have the <unistd.h> header file.  */
/* #undef HAVE_UNISTD_H */

/* Define if you have the Hcurses library (-lHcurses).  */
/* #undef HAVE_LIBHCURSES */

/* Define if you have the bsd library (-lbsd).  */
/* #undef HAVE_LIBBSD */

/* Define if you have the crypto library (-lcrypto).  */
/* #undef HAVE_LIBCRYPTO */

/* Define if you have the curses library (-lcurses).  */
/* #undef HAVE_LIBCURSES */

/* Define if you have the dl library (-ldl).  */
/* #undef HAVE_LIBDL */

/* Define if you have the dld library (-ldld).  */
/* #undef HAVE_LIBDLD */

/* Define if you have the elf library (-lelf).  */
/* #undef HAVE_LIBELF */

/* Define if you have the iberty library (-liberty).  */
/* #undef HAVE_LIBIBERTY */

/* Define if you have the ld library (-lld).  */
/* #undef HAVE_LIBLD */

/* Define if you have the m library (-lm).  */
#define HAVE_LIBM 1

/* Define if you have the ncurses library (-lncurses).  */
/* #undef HAVE_LIBNCURSES */

/* Define if you have the nsl library (-lnsl).  */
/* #undef HAVE_LIBNSL */

/* Define if you have the readline library (-lreadline).  */
/*#define HAVE_LIBREADLINE 1*/

/* Define if you have the socket library (-lsocket).  */
/* #undef HAVE_LIBSOCKET */

/* Define if you have the ssl library (-lssl).  */
/* #undef HAVE_LIBSSL */

/* Define if you have the termcap library (-ltermcap).  */
/* #undef HAVE_LIBTERMCAP */
