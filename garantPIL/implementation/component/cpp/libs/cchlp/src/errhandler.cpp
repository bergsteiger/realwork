#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "errhandler.h"

static void my_lib_eh(const char *, const char *, ...);

void (*lib_error_handler)(const char *, const char *, ...) = my_lib_eh;

void my_lib_eh(const char *who, const char *fmt, ...)
{
	va_list ap;
	va_start(ap, fmt);

	fprintf(stderr,"%s: ", who );
	vfprintf(stderr, fmt, ap);
	exit(1);
}
