/*
 * $Id: gkdb_ver.h,v 2.11 2003/04/24 15:12:45 yaroslav Exp $
 * $Log: gkdb_ver.h,v $
 * Revision 2.11  2003/04/24 15:12:45  yaroslav
 * Fix for 5.6.x
 *
 * Revision 2.10  2003/04/18 09:19:32  yaroslav
 * Fix for 5.6.x (new names)
 *
 * Revision 2.9  2003/04/17 15:02:48  yaroslav
 * Fix for 5.6.x
 *
 * Revision 2.8  2003/04/16 12:44:03  yaroslav
 * Fix for 5.6.x
 *
 * Revision 2.7  2002/06/24 10:46:49  yaroslav
 * fix for 5.4
 *
 * Revision 2.6  2001/10/17 13:29:26  vlad
 * изменена версия GKDB_VERSION c 2 на 3
 *
 * Revision 2.5  2001/08/07 15:01:20  yaroslav
 * add support with Breeder32 in Shell's
 *
 * Revision 2.4  2001/07/31 06:26:13  yaroslav
 * add support with Breeder32 in Kernel's
 *
 * Revision 2.3  1999/06/03 08:41:32  den
 * 1) Introduce Index::OpenN
 * 2) Adopt database data format for pre-allocated streams data
 *
 * Revision 2.2  1999/05/02 17:02:42  max
 * Setup 4.06.2 develop state
 *
 * Revision 1.1.4.4  1998/07/31 15:13:03  max
 * Add basemask component
 *
 * Revision 1.1.4.3  1998/06/25 06:26:39  max
 * Move VALID_SIGN into gkdb_ver.h BASE_DATA_VERSION
 *
 * Revision 1.1.4.2  1998/06/03 15:14:29  alik
 * nothing worth
 *
 * Revision 1.1.4.1  1998/05/18 15:52:48  max
 * go away from RELENG_4_05
 *
 * Revision 1.1.2.1  1998/05/18 15:19:44  max
 * insert prototype for some components version files (xxxx_ver.h), developers MUST edit this files itself !!!
 *
 *
 */

#ifndef GKDB_VERSION
#define GKDB_VERSION 3

#include "bmsk_ver.h"

#if BMSK_VERSION != 1
#error Incompatible version of basemask.a
#endif

#ifndef BASE_DATA_VERSION
	#if defined(BRDR) || defined(BRDR32) || defined(INSTLL_CIB)
		#ifndef BRDR32
			#define BASE_DATA_VERSION_OUT -1999l
			#define BASE_DATA_VERSION -1968l
		#elif defined(RD_AS_ETALON)
			#define BASE_DATA_VERSION_OUT -1999l
			#define BASE_DATA_VERSION -1968l
		#else
			#ifdef NOT_RD
				#define BASE_DATA_VERSION_OUT -1999l
			#else
				#define BASE_DATA_VERSION_OUT -1968l
			#endif
			#define BASE_DATA_VERSION -1970l
		#endif
	#elif defined(MULTI_INDEX_STREAM_FILE) && defined(MAKE_HDD) && defined(PL_REPLCTR_FUNC)
		#define BASE_DATA_VERSION -1968l
	#else
		#define BASE_DATA_VERSION -1999l
	#endif
#else
	#if BASE_DATA_VERSION != -1999l
	#error Conflict with previous BASE_DATA_VERSION definitions
	#endif
#endif

#endif      
