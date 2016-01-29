/*
 * $Id: delt_ver.h,v 2.6 2013/07/16 06:22:55 young Exp $
 * $Log: delt_ver.h,v $
 * Revision 2.6  2013/07/16 06:22:55  young
 * גונסטÿ הוכüעû
 *
 * Revision 2.5  2001/10/17 13:37:12  vlad
 * version
 *
 * Revision 2.4  1999/07/07 17:43:49  max
 * increase all module version for 4.08
 *
 * Revision 2.3  1999/05/28 15:42:55  max
 * Remove all Ctrl-M
 *
 * Revision 2.2  1999/05/02 17:06:16  max
 * Setup 4.06.2 develop state
 *
 * Revision 1.1.4.4  1999/01/31 16:49:16  max
 * Ready for days delta
 *
 * Revision 1.1.4.3  1998/06/03 16:51:03  max
 * Correct some after Alik intervention
 *
 * Revision 1.1.4.2  1998/05/18 16:04:41  max
 * Some test with CCCS
 *
 * Revision 1.1.4.1  1998/05/18 15:47:36  max
 * Go away from RELENG_4_05
 *
 * Revision 1.1.2.1  1998/05/18 14:52:09  max
 * Integrated with CCCS
 *
 *
 */

#ifndef DELT_VERSION
#define DELT_VERSION 91

#include "gkdb_ver.h"
#include "gctxl_ver.h"

#if GKDB_VERSION != 3
#error Incompatible version of gkdb.a
#endif

#if GCTXL_VERSION != 1
#error Incompatible version of gctx.a
#endif

#endif
