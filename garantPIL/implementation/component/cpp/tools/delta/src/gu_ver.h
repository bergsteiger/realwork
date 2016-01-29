/*
 * $Id: gu_ver.h,v 2.44 2015/04/30 12:31:40 young Exp $
 */

#ifndef GU_VERSION
#define GU_VERSION 711000

#include "gkdb_ver.h"
#include "cchlp_ver.h"
#include "dhr_ver.h"
#include "delt_ver.h"
//#include "ini_ver.h"

#ifndef _MSC_VER
	#include "gsscreen_ver.h"
	#if GSSCREEN_VERSION != 1
		#error Incompatible version of gsscreen.a
	#endif
#endif

#if GKDB_VERSION != 3
#error Incompatible version of gkdb.a
#endif

#if CCHLP_VERSION != 1
#error Incompatible version of cchlp.a
#endif

#if DHR_VERSION != 4
#error Incompatible version of dhr.a
#endif

#if DELT_VERSION != 91
#error Incompatible version of delta.a
#endif

//#if INI_VERSION != 1
//#error Incompatible version of inifile.a
//#endif    

#endif

