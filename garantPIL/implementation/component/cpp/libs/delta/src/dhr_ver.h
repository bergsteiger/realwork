/*
 * $Id: dhr_ver.h,v 2.34 2015/10/29 11:10:23 young Exp $
 * $Log: dhr_ver.h,v $
 * Revision 2.34  2015/10/29 11:10:23  young
 * версия дельты - 712
 *
 * Revision 2.33  2015/04/30 12:31:07  young
 * версия дельты; компаратор для DocRele
 *
 * Revision 2.32  2014/07/28 08:47:29  young
 * версия дельты
 *
 * Revision 2.31  2013/07/16 06:22:55  young
 * версия дельты
 *
 * Revision 2.30  2012/06/20 08:02:26  vlad
 * ААК; $371641073
 *
 * Revision 2.29  2010/12/20 14:38:24  vlad
 * версия 977
 *
 * Revision 2.28  2010/08/26 09:13:51  vlad
 * версия дельты - 976
 *
 * Revision 2.27  2010/05/14 10:53:07  vlad
 * 975
 *
 * Revision 2.26  2009/06/16 11:04:02  vlad
 * версия дельты - 974
 *
 * Revision 2.25  2009/06/09 12:30:11  vlad
 * версия дельты
 *
 *
 * Committed on the Free edition of March Hare Software CVSNT Server.
 * Upgrade to CVS Suite for more features and support:
 * http://march-hare.com/cvsnt/
 *
 * Revision 2.24  2008/12/26 17:26:01  vlad
 * временно вернули 972
 *
 * Revision 2.23  2008/12/22 08:04:28  vlad
 * версия дельты - 973
 *
 * Revision 2.22  2008/01/25 10:29:59  vlad
 * новый формат дельты 972
 *
 * Revision 2.21  2007/10/09 11:18:47  vlad
 * формат дельты - 971.
 * Изменили обновление IDD_HAND(HAND)MASK - чтобы сохранить порядок (важен юристам)
 *
 * Revision 2.20  2007/06/29 12:43:36  vlad
 * формат дельты - 971
 *
 * Revision 2.19  2007/03/09 16:11:37  vlad
 * формат дельты - 970 убраны старые синонимы (Adopted) и вопросы
 *
 * Revision 2.18  2006/11/07 09:58:23  vlad
 * дельта - 940
 *
 * Revision 2.17  2006/08/08 07:22:53  vlad
 * fix
 *
 * Revision 2.16  2006/06/29 07:10:59  vlad
 * version
 *
 * Revision 2.15  2006/04/12 08:05:50  vlad
 * дельта для 64
 *
 * Revision 2.14  2005/08/01 13:36:15  grigorio
 * Merge garant4x/libs from jun 15 to jul 30 2005.
 *
 * Revision 2.15  2005/07/25 11:49:00  vlad
 * delta versions
 *
 * Revision 2.14  2005/06/27 12:21:14  vlad
 * из-за изменения CorrRef меняем версию дельты
 *
 * Revision 2.13  2005/02/11 16:10:35  vlad
 * defines
 *
 * Revision 2.12  2005/02/11 16:03:53  vlad
 * новые флаги
 *
 * Revision 2.11  2004/11/12 13:52:10  vlad
 * prepare for 61
 *
 * Revision 2.10  2004/07/29 11:33:17  vlad
 * версия для NEMESIS - 888
 *
 * Revision 2.9  2003/03/04 09:37:19  vlad
 * Версия 5.6 (редакции документов)
 *
 * Revision 2.8  2003/03/04 08:31:20  vlad
 * VERSION56. Редакции документов
 *
 * Revision 2.7  2001/10/17 13:29:42  vlad
 * версия дельты изменена на 717 для 5.2
 *
 * Revision 2.6  2001/02/21 10:59:41  max
 * add SplashTopic delting
 *
 * Revision 2.5  2000/03/24 09:02:12  max
 * BaseInfo delting/restoring
 *
 * Revision 2.4  1999/07/07 17:43:49  max
 * increase all module version for 4.08
 *
 * Revision 2.3  1999/05/28 15:42:55  max
 * Remove all Ctrl-M
 *
 * Revision 2.2  1999/05/02 17:06:17  max
 * Setup 4.06.2 develop state
 *
 * Revision 1.1.4.6  1999/01/29 19:10:13  max
 * New DHReeder ready for days delta
 *
 * Revision 1.1.4.5  1998/09/08 08:23:21  max
 * Not Tested
 *
 * Revision 1.1.4.4  1998/06/19 22:53:57  max
 * Add version control independent from DHReader
 *
 * Revision 1.1.4.3  1998/05/30 14:54:21  max
 * Check _DATA_VERSION redefinition conflicts
 *
 * Revision 1.1.4.2  1998/05/18 16:04:42  max
 * Some test with CCCS
 *
 * Revision 1.1.4.1  1998/05/18 15:47:38  max
 * Go away from RELENG_4_05
 *
 * Revision 1.1.2.1  1998/05/18 14:52:11  max
 * Integrated with CCCS
 *
 *
 */

#ifndef DHR_VERSION
#define DHR_VERSION 4

#include "gkdb_ver.h"

#if GKDB_VERSION != 3
#error Incompatible version of gkdb.a
#endif

#ifndef DEFINE_DELTA_DATA_VERSION
#define DEFINE_DELTA_DATA_VERSION 712
#else
#if DEFINE_DELTA_DATA_VERSION != 712
#error Conflict with DELTA_DATA_VERSION definitions
#endif
#endif

#endif
