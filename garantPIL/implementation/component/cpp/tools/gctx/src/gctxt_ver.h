#ifndef GTCXT_VERSION
#define GCTXT_VERSION 1

#include "gkdb_ver.h"
#include "gctxl_ver.h"
#include "cchlp_ver.h"

#if GKDB_VERSION != 2 
#error Incompatible version of GKDB
#endif

#if GCTXL_VERSION != 1
#error Incompatible version of GCTX library
#endif

#if CCHLP_VERSION != 1
#error Incompatible version of CCHLP
#endif

#endif
