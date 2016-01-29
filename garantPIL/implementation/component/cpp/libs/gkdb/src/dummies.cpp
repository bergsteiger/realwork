// unixdummies.cc

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <stdarg.h>

#include "gardefs.h"
#include "pagefile.h"

void OkBox(const char *t, const char *fmt, ... ){
	va_list ap;
	va_start(ap, fmt);
	fprintf(stderr,"Diag: OkBox: %s\n", t);
	vfprintf(stderr,(const char *)fmt, ap);
	va_end(ap);
}
int MemoryError(){
	fprintf(stderr,"Diag: MemoryError\n");
	return 1;
}

