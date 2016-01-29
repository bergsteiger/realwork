#ifndef GLT_VERSION
#define GLT_VERSION 1

#include "gkdb_ver.h"
#include "gll_ver.h"

#if GKDB_VERSION != 3
#error Incompatible version if GKDB
#endif

#if GLL_VERSION != 1
#error Incompatible version of GL library
#endif

#endif
