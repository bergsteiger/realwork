/*
 * $Id: grev_ver.h,v 2.9 2013/07/16 06:23:03 young Exp $
 */

#ifndef GREV_VERSION
#define GREV_VERSION 112

#include "gkdb_ver.h"
#include "delt_ver.h"

#if GKDB_VERSION != 3
#error Incompatible version of gkdb.a
#endif

#if DELT_VERSION != 91
#error Incompatible version of delta.a
#endif    

#endif
