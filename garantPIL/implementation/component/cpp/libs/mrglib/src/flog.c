#include "shared/Core/fix/mpcxc.h"
#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>

#include "gdbapi.h"

static int hLog=-1;

// Converter for current text coding //
extern char *do_tr(const char *);

static void close_log(void);
static char *lpszInternal=NULL;

int create_log(char *lpszName, int redirect_stderr)
{
	int hstderr;

	if (hLog != -1) return 0;
	if ((hLog=c_io_open(	lpszName, ACE_OS_O_CREAT | ACE_OS_O_TRUNC | ACE_OS_O_TEXT | ACE_OS_O_WRONLY // GARANT_GCC
						)) == -1) return 0;
	lpszInternal = (char *)ml_malloc(1024);
	bzero(lpszInternal, 1024);
	atexit(close_log);
	if (redirect_stderr) {
		//hstderr = fileno(stderr); // GARANT_POSIX: ok, but no way to cast to ACE_HANDLE
		//ace_os_dup2(hLog, hstderr); // not correct
		//fclose(stderr);
		assert(false);
	}
	return hLog;
}



static void close_log(void)
{
	if(hLog != -1) c_io_close(hLog);
	if(lpszInternal) free(lpszInternal);
}

void m_log(char *lpsz)
{
	char *t= do_tr(lpsz);
	if(hLog != -1) c_io_write(hLog, t, strlen(t));
}

char* flog(char *format, ...)
{
	int len;
	va_list arglist;

	if(hLog == -1) return NULL;
	va_start(arglist, format);
	len = vsprintf(lpszInternal, format, arglist);
	c_io_write(hLog, lpszInternal, len);
	va_end(arglist);
	return lpszInternal;
}

