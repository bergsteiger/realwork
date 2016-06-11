/* _Strerror function */
#include <errno.h>
#include <string.h>
#include "xtls.h"
_STD_BEGIN

#define INIT_STR	"error #xxx"
#define EBUF_SIZE	sizeof (INIT_STR)

_TLS_ARR_DEF(static, char, sbuf, EBUF_SIZE);

char *_Strerror(int errcode, char *buf)
	{	/* copy error message into buffer as needed */
	switch (errcode)
		{	/* switch on known error codes */

 #ifdef E2BIG
	case E2BIG:
		return ("argument list too long");
 #endif /* E2BIG */

 #ifdef EACCES
	case EACCES:
		return ("permission denied");
 #endif /* EACCES */

 #ifdef EAGAIN
	case EAGAIN:
		return ("resource temporarily unavailable");
 #endif /* EAGAIN */

 #ifdef EBADF
	case EBADF:
		return ("bad file descriptor");
 #endif /* EBADF */

 #ifdef EBADMSG
	case EBADMSG:
		return ("bad message");
 #endif /* EBADMSG */

 #ifdef EBUSY
	case EBUSY:
		return ("resource busy");
 #endif /* EBUSY */

 #ifdef ECANCELED
	case ECANCELED:
		return ("operation canceled");
 #endif /* ECANCELED */

 #ifdef ECHILD
	case ECHILD:
		return ("no child processes");
 #endif /* ECHILD */

 #ifdef EDEADLK
	case EDEADLK:
		return ("resource deadlock avoided");
 #endif /* EDEADLK */

 #ifdef EDOM
	case EDOM:
		return ("domain error");
 #endif /* EDOM */

 #ifdef EEXIST
	case EEXIST:
		return ("file exists");
 #endif /* EEXIST */

 #ifdef EFAULT
	case EFAULT:
		return ("bad address");
 #endif /* EFAULT */

 #ifdef EFBIG
	case EFBIG:
		return ("file too large");
 #endif /* EFBIG */

 #ifdef EFPOS
	case EFPOS:
		return ("file positioning error");
 #endif /* EFPOS */

 #ifdef EILSEQ
	case EILSEQ:
		return ("multibyte encoding error");
 #endif /* EILSEQ */

 #ifdef EINPROGRESS
	case EINPROGRESS:
		return ("operation in progress");
 #endif /* EINPROGRESS */

 #ifdef EINTR
	case EINTR:
		return ("interrupted function call");
 #endif /* EINTR */

 #ifdef EINVAL
	case EINVAL:
		return ("invalid argument");
 #endif /* EINVAL */

 #ifdef EIO
	case EIO:
		return ("input/output error");
 #endif /* EIO */

 #ifdef EISDIR
	case EISDIR:
		return ("is a directory");
 #endif /* EISDIR */

 #ifdef EMFILE
	case EMFILE:
		return ("too many open files");
 #endif /* EMFILE */

 #ifdef EMLINK
	case EMLINK:
		return ("too many links");
 #endif /* EMLINK */

 #ifdef EMSGSIZE
	case EMSGSIZE:
		return ("bad message buffer length");
 #endif /* EMSGSIZE */

 #ifdef ENAMETOOLONG
	case ENAMETOOLONG:
		return ("filename too long");
 #endif /* ENAMETOOLONG */

 #ifdef ENFILE
	case ENFILE:
		return ("too many files open in system");
 #endif /* ENFILE */

 #ifdef ENODEV
	case ENODEV:
		return ("no such device");
 #endif /* ENODEV */

 #ifdef ENOENT
	case ENOENT:
		return ("no such file or directory");
 #endif /* ENOENT */

 #ifdef ENOEXEC
	case ENOEXEC:
		return ("exec format error");
 #endif /* ENOEXEC */

 #ifdef ENOLCK
	case ENOLCK:
		return ("no locks available");
 #endif /* ENOLCK */

 #ifdef ENOMEM
	case ENOMEM:
		return ("not enough space");
 #endif /* ENOMEM */

 #ifdef ENOSPC
	case ENOSPC:
		return ("no space left on device");
 #endif /* ENOSPC */

 #ifdef ENOSYS
	case ENOSYS:
		return ("function not implemented");
 #endif /* ENOSYS */

 #ifdef ENOTDIR
	case ENOTDIR:
		return ("not a directory");
 #endif /* ENOTDIR */

 #ifdef ENOTEMPTY
	case ENOTEMPTY:
		return ("directory not empty");
 #endif /* ENOTEMPTY */

 #ifdef ENOTSUP
	case ENOTSUP:
		return ("not supported");
 #endif /* ENOTSUP */

 #ifdef ENOTTY
	case ENOTTY:
		return ("bad I/O control operation");
 #endif /* ENOTTY */

 #ifdef ENXIO
	case ENXIO:
		return ("no such device or address");
 #endif /* ENXIO */

 #ifdef EPERM
	case EPERM:
		return ("operation not permitted");
 #endif /* EPERM */

 #ifdef EPIPE
	case EPIPE:
		return ("broken pipe");
 #endif /* EPIPE */

 #ifdef ERANGE
	case ERANGE:
		return ("range error");
 #endif /* ERANGE */

 #ifdef EROFS
	case EROFS:
		return ("read-only file system");
 #endif /* EROFS */

 #ifdef ESPIPE
	case ESPIPE:
		return ("invalid seek");
 #endif /* ESPIPE */

 #ifdef ESRCH
	case ESRCH:
		return ("no such process");
 #endif /* ESRCH */

 #ifdef ETIMEDOUT
	case ETIMEDOUT:
		return ("operation timed out");
 #endif /* ETIMEDOUT */

 #ifdef EXDEV
	case EXDEV:
		return ("improper link");
 #endif /* EXDEV */

	case 0:
		return ("no error");

	default:
		if (buf == 0)
			buf = _TLS_ARR(sbuf);
		strcpy(buf, INIT_STR);
		buf[9] = (char)(errcode % 10 + '0');
		buf[8] = (char)((errcode /= 10) % 10 + '0');
		buf[7] = (char)((errcode / 10) % 10 + '0');
		return (&buf[0]);
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
