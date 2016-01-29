#ifndef GLL_VERSION
#define GLL_VERSION 1

#include "gkdb_ver.h"
#include "cchlp_ver.h"
#include "gsscreen_ver.h"

#if GKDB_VERSION != 3
#error Incompatible version f GKDB
#endif

#if CCHLP_VERSION != 1
#error Incompatible version of CCHLP
#endif

#if GSSCREEN_VERSION != 1
#error Incompatible version of GSSCREEN
#endif

#endif
