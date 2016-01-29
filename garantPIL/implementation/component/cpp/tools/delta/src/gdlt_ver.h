/*
 * $Id: gdlt_ver.h,v 2.34 2013/07/16 06:23:03 young Exp $
 */

#ifndef GDLT_VERSION
#define GDLT_VERSION 179

#include "gkdb_ver.h"
#include "dhr_ver.h"
#include "delt_ver.h"

#if GKDB_VERSION != 3
#error Incompatible version of gkdb.a
#endif

#if DHR_VERSION != 4
#error Incompatible version of dhr.a
#endif

#if DELT_VERSION != 91
#error Incompatible version of delta.a
#endif

#endif
