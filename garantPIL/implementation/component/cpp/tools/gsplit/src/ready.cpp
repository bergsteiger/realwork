#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: ready.cpp,v 2.106 2012/08/10 17:37:39 yaroslav Exp $
 */

#include <cstdlib>
#include <fcntl.h>
#include <ctime>
#include <cerrno>
#include <cstring>
#include <sys/stat.h>

#ifdef WITH_DBL_THREAD
	#include "MyPipe.h"
#endif

#include "gar_defs.hpp"

/*bool b_english_base = false;
bool bIgnoreFatal = false;
bool b_recode = true;
bool b_inpharm = false;
bool bIgnoreTvsErrors = false;*/
#include <deque>
extern	std::deque<std::string> errors;
char* kwFile = 0;

bool b5Context = false;

#ifdef OLD_MAP
	longSplaySet	hereBelongs;
#else
	#include "QMap.hpp"
	typedef QuickSplayMapG<long, char> GSubMap;

	GSubMap hereBelongs(0);
#endif

void localrev_adddays ( revision& theRev, const int days ) 
{ 
	time_t atime; 
	struct tm atm; 
	struct tm *ptm; 
	memset( &atm, 0, sizeof( atm )); 
	atm.tm_year = theRev.RevisionDate.da_year - 1900; 
	atm.tm_mday = theRev.RevisionDate.da_day; 
	atm.tm_mon  = theRev.RevisionDate.da_mon - 1; 
	atime = mktime( &atm ); 
	atime += (long)days * 24l * 3600l; 
	ptm   = localtime( &atime ); 
	theRev.RevisionDate.da_year = ptm -> tm_year + 1900; 
	theRev.RevisionDate.da_day = ptm -> tm_mday; 
	theRev.RevisionDate.da_mon = ptm -> tm_mon + 1;	 
} 

revision today_rev;
unsigned char *paraFinalBuf= 0;
#ifdef PTRS_IN_META
  #ifdef PTRS_ONLY
	unsigned char							*exportBuf= 0;
  #else
	unsigned char one_exportBuf[128*1024],	*exportBuf= one_exportBuf;
  #endif
#endif

int iMakeAllDocs= 0;
int iMakeAllDocsParaMax= 50000;
long iMakeAllDocsSizeMax= 0x7fffffff;

#include "gsscreen.h"

extern "C" {
extern int parse_cmdline(int argc, char **argv);
extern int read_settings(void);
extern int gmmain(int threadMode, void *ThreadCntxt);
extern void help(void);
}

#include "message.h"

extern "C" void *CreateContext(void *pCurrent)
{
	if(pCurrent == 0){
			pCurrent= (void*) new GSScreen(						cd_koi,
											#if defined(__GO32__) || defined(__WIN32__)
																cd_dos
											#else
																cd_koi
											#endif
																);
	}
	((GSScreen*)pCurrent)->InitScreen(get_message(MSG_TITLE));
	return pCurrent;
}

extern "C" void freeContext(void *pCurrent)
{
	delete ((GSScreen*)pCurrent);
}

extern "C" void ShowMessageFromContext(void *pCurrent, char *CurrMsg)
{
#ifdef NO_GSSCREEN
	return;
#endif
	char *s = Recoding(	cd_koi,
		
#ifndef BRDR32
	#if defined(__GO32__) || defined(__WIN32__)
							cd_dos
	#else
							cd_koi
	#endif
#else
							cd_win
#endif
						,strdup(CurrMsg));
	((GSScreen*)pCurrent)->OtherShowMessage(s);
	free(s);
}

extern "C" void otherIncProgress(void *pCurrent)
{
#ifdef NO_GSSCREEN
	return;
#endif
	static int globalProcess= 0;
	globalProcess++;
	if(globalProcess > 100 ) globalProcess = 100;
	((GSScreen*)pCurrent)->SetProgress(globalProcess);
}

static QuickSplayMap<long,char> reference_docs(0);

extern "C" int add_reference_id(long Id)
{
	reference_docs.get(Id);
	return 1;
}

extern "C" int is_reference_id(u_int32_t Id)
{
	if(reference_docs.seek(long((Id & 0x7fffffff))))
		return 1;
	return 0;
}

#if (!defined(_WINDOWS) && defined(PTRS_IN_META))
	extern "C" {
		int gsplit_Method(int argc, char **argv, void *pCntx);
		void* local_main_PRE_ptr= 0;
	}
	int main ( int argc, char *argv[] ) {
		local_main_PRE_ptr= (void*)0;
		int res = gsplit_Method(argc, argv, 0);

		return res;
	}
  #ifdef OLD_SHORT_STR
	#include "../../../libs/gkdb/src/stdbase.h"
	#undef MAKE_HDD
	#undef PL_REPLCTR_FUNC
	#define INSTLL_CIB
	#include "../../../libs/gkdb/src/pl_crypt.cpp"
	#include "../../../libs/gkdb/src/pagefile.cpp"
	#include "../../../libs/gkdb/src/base.cpp"
	#include "../../../libs/gkdb/src/stdbase.cpp"
	namespace NdtClone {
		extern const char *pBuckupFileExt;
	}
  #endif
#else
	#include "../../../libs/gkdb/src/basemask.h"
#endif
	extern "C" {
		#include "../../../libs/mrglib/src/gdbapi.h"
		u_int32_t get_ready(base_st *pbase)
		{
			GDataStatusMask msk(TID_GSPLIT);

			return msk.CheckMask(pbase->ready_flags);
		}
		u_int32_t get_final_mask(u_int32_t mask)
		{
			GDataStatusMask msk(TID_GSPLIT);

			return msk.SetMask(mask);
		}
		char *missing_process_description(u_int32_t mask)
		{
			int16_t x, y;

			return GetProcessDescription(mask, x, y);
		}
		int gsplit_Method(int argc, char **argv, void *pCntx);
	}

