#ifndef GKDBCMP_VERSION
#define GKDBCMP_VERSION 1

#include "gkdb_ver.h"
#include "cchlp_ver.h"

#if GKDB_VERSION != 2 
#error Incompatible version of GKDB
#endif

#if CCHLP_VERSION != 1
#error Incompatible version of CCHLP
#endif

#endif
