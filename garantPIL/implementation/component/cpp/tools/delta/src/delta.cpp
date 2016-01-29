#include "shared/Core/fix/mpcxc.h"

/*
 * cvs id was here
 */
			      // delta.cpp //
///////////////////////////////////////////////////////////////////////////////
//									     //
// Purpose:								     //
//	Define the main and main_delta procedures			     //
//									     //
// Author:								     //
//	Garant-Service							     //
//									     //
///////////////////////////////////////////////////////////////////////////////

#ifdef __CYGWIN32__
#include <cerrno>
#endif

#include "shared/Core/sys/AutoInit.h"

#include <cstdio>
#include <cstring>
#include <fcntl.h>
#include <ctime>

#include "gdlt_ver.h"
#include "dociter.h"
#include "fulldiff.h"
#include "garutils.h"
#include "basemask.h"
#include "garver.h"
#include "StorableSplaySet.h"
#include "Logger.h"
#include "adds.h"
#include "osdep.h"
#include "recode.h"
#include "rev.h"
#include "timer.h"
#include "pack.h"
#include "Lzma86.h"

#ifdef	MIN_MEM_CONTEXT
#include "SearchB.h"
#else
#include "ROCBase.h"
#endif

#include <boost/thread.hpp>

///////////////////////////////////////////////////////////////////////////////

bool	b_use_lzma = true;

#ifndef _EXTERN_MAIN
	#include "gsscreen.h"

	code_t out = mpcxc_cd_cursys();

	LogScreen tracer;
	Logger logger;
#else
	extern Logger logger;
#endif

extern	short DELTA_DATA_VERSION;

///////////////////////////////////////////////////////////////////////////////

#ifdef	unix
bool b_buildNewCorrDiff = true;
#else
bool b_buildNewCorrDiff = false;
#endif
bool b_buildNewCorrDiff_hack = false;

long	g_lDiffTimeLimit = 0;
bool	b_daily = false, b_sbrf = false, b_ignorerevision = false;
bool	b_ovp = false;
long	checkOnlyDoc = 0;

extern void AddDiff ( long lDeltaCount );
extern void DiffProcCreate ( long lDocInDelta );

bool	b_texts_only = false;
bool	b_gctx_attrs_only = false;
bool	b_prepack = false;
bool	b_pack_delta = false;
bool	b_cache_ro = false;
bool	b_single_cache = false;
bool	b_extended_log = false;
bool	b_flush_log = false;

ProgressScreen* screen;

class	DiffHolder;
extern	DiffHolder	*m_pDiffHolder [16];

///////////////////////////////////////////////////////////////////////////////

void funcSigInt ( int iSig ) 
{	
	logger.printf ( lt_warning, "Delta creating stoped by SIGINT (%d)\nDH-files maybe corrupted!!! Don't forget to delete them!\n", iSig );
	//exit ( EXIT_FAILURE );
}

#ifndef _EXTERN_MAIN
int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

void suppress_crash_handlers( void );
long WINAPI unhandled_exception_handler( EXCEPTION_POINTERS* p_exceptions );

int main ( int argc, char *argv[] ) {
	gk_bzero (&CCr, sizeof (CCr));
	SetUnhandledExceptionFilter (UEF);
	Core::AutoInit init;
	return main_logic(argc, argv);
}

char argDltPath [1024];

unsigned long	threads_count = 1;
#define	MAX_SEGS	600
#define	MAX_THREADS	MAX_SEGS
#define	MAX_POOL	16

std::map<long,long> map_chgdoc_unpackedsize, map_chgdoc_packedsize;
std::map<long,char*> map_chgdoc_packeddata, map_chgdoc_unpackeddata;
std::map<long,long> map_newdoc_unpackedsize, map_newdoc_packedsize;
std::map<long,char*> map_newdoc_packeddata, map_newdoc_unpackeddata;

std::map<long, std::vector<CorrRef> > map_old_newcorr, map_new_newcorr;
std::map<long, std::vector<Ref> > map_old_corr, map_new_corr;

std::map<u_int64_t, StorableSplaySet<short> > map_old_blobbelongs, map_new_blobbelongs;
std::map<u_int64_t, ObjInfo> map_blob_objinfo;
std::map<u_int64_t,short> map_blob_order;
std::map<u_int64_t,long> map_blob_osize, map_blob_tsize;
std::map<u_int64_t,void*> map_blob_odata, map_blob_tdata;

struct thread_data_struct {
	volatile long done, run, pool_id, seg;
	std::deque<long> chg_docs, new_docs;
	std::map<long,long> map_chgdoc_unpackedsize, map_chgdoc_packedsize;
	std::map<long,char*> map_chgdoc_packeddata, map_chgdoc_unpackeddata;
	std::map<long,long> map_newdoc_unpackedsize, map_newdoc_packedsize;
	std::map<long,char*> map_newdoc_packeddata, map_newdoc_unpackeddata;
};

thread_data_struct thread_data [MAX_POOL];
Core::Mutex	thr_docs_it_mutex;
DocIterator	*pDocIter;

long	get_thr_doc (bool next)
{
	GUARD (thr_docs_it_mutex);
	long result = 0;
	if (!pDocIter->End ()) {
		result = pDocIter->Id ();
		if (next) {
			AddDiff(1);
			++(*pDocIter);
		}
	}
	return result;
}

Full	*fulldiffs [MAX_POOL][MAX_SEGS];
short	*segs = 0;
FILE	*dfiles[MAX_POOL][MAX_SEGS];

char	m_AttrFile_name [MAX_POOL][MAX_PATH]; 
char	pfTmp1_name [MAX_POOL][MAX_PATH]; 
char	pfTmp2_name [MAX_POOL][MAX_PATH]; 

FILE*	m_AttrFile [MAX_POOL];

SearchBase *pool_old [MAX_POOL], *pool_new [MAX_POOL];

// список сегментов для слития
StorableSplaySet<unsigned short> ids;
int	segcount = 0;

std::deque<long> cache_chg_docs, cache_new_docs;
std::deque<long>::const_iterator cache_chg_docs_it, cache_new_docs_it;

long	get_packchg_doc (bool next)
{
	GUARD (thr_docs_it_mutex);
	long result = 0;
	if (cache_chg_docs_it != cache_chg_docs.end ()) {
		result = *cache_chg_docs_it;
		if (next)
			cache_chg_docs_it++;
	}
	return result;
}

void	do_pack_chg (long &this_thread_id)
{
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	for (;;) {
		long doc_id = get_packchg_doc (true);
		if (0 == doc_id)
			break;
		Stream *str = m_pDiffHolder [this_thread_id]->idx1->Open (&doc_id);
		if (str) {
			long size = str->Length ();
			char *data = new char [size];
			str->Read (data, size);
			m_pDiffHolder [this_thread_id]->idx1->Close (str);

			if (b_use_lzma) {
				size_t packed_size = size << 1, dict = 1 << 15;
				char *packed_data = new char [packed_size];

				if (Lzma86_Encode ((Byte*)packed_data, &packed_size, (const Byte*)data, size, 2, dict, SZ_FILTER_AUTO) != 0)
					packed_size = 0;

				if (packed_size) {
					thread_data_ptr->map_chgdoc_packeddata.insert (std::map<long,char*>::value_type (doc_id, packed_data));
				} else {
					//если не запакуется, то размер будет равным 0	
					delete []packed_data;
				}
				thread_data_ptr->map_chgdoc_packedsize.insert (std::map<long,long>::value_type (doc_id, packed_size));
				thread_data_ptr->map_chgdoc_unpackedsize.insert (std::map<long,long>::value_type (doc_id, size));
				thread_data_ptr->map_chgdoc_unpackeddata.insert (std::map<long,char*>::value_type (doc_id, data));
			} else {
				char *packed_data = new char [size];
				long packed_size = G_ZIP (data, size, packed_data, size);
				if (packed_size) {
					thread_data_ptr->map_chgdoc_packeddata.insert (std::map<long,char*>::value_type (doc_id, packed_data));
				} else {
					//если не запакуется, то размер будет равным 0	
					delete []packed_data;
				}
				thread_data_ptr->map_chgdoc_packedsize.insert (std::map<long,long>::value_type (doc_id, packed_size));
				thread_data_ptr->map_chgdoc_unpackedsize.insert (std::map<long,long>::value_type (doc_id, size));
				thread_data_ptr->map_chgdoc_unpackeddata.insert (std::map<long,char*>::value_type (doc_id, data));
			}
		} else {
			logger.printf (lt_error, "Can't find changed doc %ld in cache\n", doc_id);
			exit (EXIT_FAILURE);
		}
	}
	InterlockedIncrement (&thread_data_ptr->done);
}

long	get_packnew_doc (bool next)
{
	GUARD (thr_docs_it_mutex);
	long result = 0;
	if (cache_new_docs_it != cache_new_docs.end ()) {
		result = *cache_new_docs_it;
		if (next)
			cache_new_docs_it++;
	}
	return result;
}

void	do_pack_new (long &this_thread_id)
{
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	for (;;) {
		long doc_id = get_packnew_doc (true);
		if (0 == doc_id)
			break;
		Stream *str = m_pDiffHolder [this_thread_id]->idx2->Open (&doc_id);
		if (str) {
			long size = str->Length ();
			char *data = new char [size];
			str->Read (data, size);
			m_pDiffHolder [this_thread_id]->idx2->Close (str);

			if (b_use_lzma) {
				size_t packed_size = size << 1, dict = 1 << 15;
				char *packed_data = new char [packed_size];

				if (Lzma86_Encode ((Byte*)packed_data, &packed_size, (const Byte*)data, size, 2, dict, SZ_FILTER_AUTO) != 0)
					packed_size = 0;

				thread_data_ptr->map_newdoc_unpackedsize.insert (std::map<long,long>::value_type (doc_id, size));
				thread_data_ptr->map_newdoc_packedsize.insert (std::map<long,long>::value_type (doc_id, packed_size));
				if (packed_size)
					thread_data_ptr->map_newdoc_packeddata.insert (std::map<long,char*>::value_type (doc_id, packed_data));
				else
					delete [] packed_data;
				thread_data_ptr->map_newdoc_unpackeddata.insert (std::map<long,char*>::value_type (doc_id, data));
			} else {
				char *packed_data =  new char [size];
				long packed_size = G_ZIP (data, size, packed_data, size);
				//если не запакуется, то размер останется равным 0

				thread_data_ptr->map_newdoc_unpackedsize.insert (std::map<long,long>::value_type (doc_id, size));
				thread_data_ptr->map_newdoc_packedsize.insert (std::map<long,long>::value_type (doc_id, packed_size));
				if (packed_size)
					thread_data_ptr->map_newdoc_packeddata.insert (std::map<long,char*>::value_type (doc_id, packed_data));
				else
					delete [] packed_data;
				thread_data_ptr->map_newdoc_unpackeddata.insert (std::map<long,char*>::value_type (doc_id, data));
			}
		} else {
			logger.printf (lt_error, "Can't find new doc %ld in cache\n", doc_id);
			exit (EXIT_FAILURE);
		}
	}
	InterlockedIncrement (&thread_data_ptr->done);
}

void	do_thread (long &this_thread_id)
{
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);

	for (;;) {
		long doc_id = get_thr_doc (true);
		if (0 == doc_id)
			break;

		StorableSplaySet<unsigned short> ids;
		fulldiffs [this_thread_id][segs[0]]->m_pNewBase->LoadAttr (doc_id, IDD_BASES, ids);

		bool b_chg = false, b_new = false;
		for (int i = 0; i < segcount; i++) {
			Full *fulldiff = fulldiffs [this_thread_id][segs[i]];
			if (ids & fulldiff->m_ids) {
				int order = fulldiff->GetDocOrder (doc_id);
				if (order == O_DOC_CHG) {
					if (b_chg)
						continue;
					b_chg = true;
					thread_data_ptr->chg_docs.push_back (doc_id);
					fulldiff->WorkDoc (doc_id, order);
					_fseeki64 (m_AttrFile [this_thread_id], 0, ACE_OS_SEEK_SET);
				} else if (order == O_DOC_NEW) {
					if (b_new)
						continue;
					b_new = true;
					fulldiff->WorkDoc(doc_id, order);
					thread_data_ptr->new_docs.push_back (doc_id);
					_fseeki64 (m_AttrFile [this_thread_id], 0, ACE_OS_SEEK_SET);
				}
			}
		}
	}

	InterlockedIncrement (&thread_data_ptr->done);
}

std::map<long,std::deque<long> > map_segment_docs;
std::set<long> segs_to_run; //дельты каких сегментов надо построить	
std::set<long>::const_iterator seg_it;
Core::Mutex	writedelta_mutex;
long	done_threads = 0, b_first_postwork2 = 1;

void	do_writepackeddelta (long &this_thread_id)
{
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	InterlockedExchange (&thread_data_ptr->run, 1);
	InterlockedExchange (&thread_data_ptr->done, 0);

	short seg = (short)(thread_data_ptr->seg & 0xFFFF);
	while (true) {
		std::deque<long> chgandnew_docs = map_segment_docs.find (seg)->second;
		long prev_perc = 0, total = chgandnew_docs.size (), count = 0;

		screen->SetProgress (0);
		Full *full = fulldiffs [0][seg];
		full->m_pNewBase = pool_new [thread_data_ptr->pool_id];
		full->m_pOldBase = pool_old [thread_data_ptr->pool_id];
		full->m_thread = thread_data_ptr->pool_id;

		for (std::deque<long>::const_iterator doc_it = chgandnew_docs.begin (); doc_it != chgandnew_docs.end (); doc_it++, count++) {
			long doc_id = *doc_it, perc = (count * 100) / total;
			full->WorkDoc (doc_id);
			if (perc != prev_perc) screen->SetProgress (prev_perc = perc);
		}
		full->PostWork1 ();
		full->DeltaBlobs ();

		{
			GUARD (writedelta_mutex);
			if (seg_it == segs_to_run.end ())
				break;
			seg = *seg_it;
			seg_it++;
		}
	}

	{
		GUARD (writedelta_mutex);
		done_threads++;
	}

	InterlockedDecrement (&thread_data_ptr->run);
	InterlockedIncrement (&thread_data_ptr->done);
}

void	do_postwork2 (long &this_thread_id)
{
	long thread_id = this_thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [thread_id]);
	InterlockedExchange (&thread_data_ptr->run, 1);
	InterlockedExchange (&thread_data_ptr->done, 0);

	short seg = (short)(thread_data_ptr->seg & 0xFFFF);
	while (true) {
		fulldiffs [0][seg]->PostWork2 (pool_old [thread_data_ptr->pool_id], pool_new [thread_data_ptr->pool_id], thread_id);
		delete fulldiffs [0][seg];

		{
			GUARD (writedelta_mutex);
			if (InterlockedCompareExchange (&b_first_postwork2, 0, 0) || seg_it == segs_to_run.end ())
				break;
			seg = *seg_it;
			seg_it++;
		}
	}

	{
		GUARD (writedelta_mutex);
		done_threads++;
	}

	InterlockedDecrement (&thread_data_ptr->run);
	InterlockedIncrement (&thread_data_ptr->done);
}

/*
	[09:42]  БВ> 1. gdlt старая новая -T:1 -cache -prepack 
	[09:43]  БВ> 2. gdlt старая новая -pack -cachero -n+ -threads:10 
*/

int main_logic ( int argc, char *argv[] )
{
	{
		VER_PARAM verParam;

		verParam.exeId= TID_GDLT;				// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

#ifndef	_DEBUG
		int	i;
		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i == VC_ADD_OK){
			}else{
			}
			exit(0);
		}
#endif
	}

	logger.Init ( &tracer, cd_win, out );
	screen = new GSScreen( cd_win, out );
#else
int main_delta ( int argc, char** argv , ProgressScreen* screen )
{
#endif
	SetProgressScreen ( screen );
	Timer* timer = new Timer ( &logger, lt_info, "Delta creation time" );

	logger.OverlapPolicy ( new ErrorPolicy () );
	logger.GetPolicy()->SetLogLevel ( lt_info );
	logger.printf( lt_always, "Garant Delta create program. Delta version v%d. Version %s.\n\n", GDLT_VERSION, GARANT_VERSION);

	bool	allsegs = false;
	if ( argc < 4 || argv[3][0] == '-' ) {
		allsegs = true;
	}
	
	if ( ( argc < 4 && !allsegs ) || ( allsegs && argc < 3 )) {
		logger.printf( lt_always, "USAGE : %s <old base> <new base> <id> [-options]\n", argv[0] );
		logger.printf( lt_always, "       'old base'   is the old base's path and name\n" );
		logger.printf( lt_always, "       'new base'   is the new base's path and name\n" );
		logger.printf( lt_always, "       'id'         is the segment number or '0' for all segments in base\n" );
		logger.printf( lt_always, "options :\n" );
		logger.printf( lt_always, "       p:<prefix>   is a prefix for file name of delta\n" );
		logger.printf( lt_always, "                    (optional, default : seg id for one seg, MX for several)\n" );
		logger.printf( lt_always, "       l:<l-path>   is path to folder where logger whill create\n" );
		logger.printf( lt_always, "                    (optional, default : folder with delta)\n" );
		logger.printf( lt_always, "       d:<d-path>   is path to folder where delta whill create\n" );
		logger.printf( lt_always, "                    (optional, default : current folder)\n" );
		logger.printf( lt_always, "       T:<min>      is time limit for creating TEXT delta for each doc\n" );
		logger.printf( lt_always, "                    (optional, default : infinity)\n" );
		logger.printf( lt_always, "       i            ignore seg's set difference for all base delta\n" );
		logger.printf( lt_always, "       D:<d-file>   is name of file with deleted doc ids,\n" );
		logger.printf( lt_always, "                    if name is empty then no deleted docs\n" );
		logger.printf( lt_always, "                    (optional, default : take deleted ids from base's diff)\n" );
		logger.printf( lt_always, "       P:<prior>    logger output priority, default INFO\n");
		logger.printf( lt_always, "                    DEBUG   - full logger information\n");
		logger.printf( lt_always, "                    INFO    - standart logger information\n");
		logger.printf( lt_always, "                    WARNING - warning and error information\n");
		logger.printf( lt_always, "                    ERROR   - only error information\n");

		return 3;		
	}

	char * pArgOldPath = argv[1];
	char * pArgNewPath = argv[2];
	char * pArgIds = argv[3];	
	short bIgnoreSegSetDiff = 0;
	char pArgLogPath [1024];
	char pArgDltPath [1024];
	char pArgDelPath [1024];
	char pArgNamePrefix [16];
	int hasDelOption = 0;
	int removeCache = 1;

	{
		for (int thread = 0; thread < MAX_POOL; thread++)
			m_pDiffHolder [thread] = 0;
	}

	const char* getenv_val = ACE_OS::getenv ("GARANT_REMOVE_CACHE");
	std::string strcache = getenv_val ? getenv_val : "0";
	if (strcache == "1") {
		removeCache = 0;
	}	

	bzero ( argDltPath, 1024 );
	bzero ( pArgDltPath, 1024 );
	bzero ( pArgLogPath, 1024 );
	bzero ( pArgDelPath, 1024 );
	bzero ( pArgNamePrefix, 16 );
	
	for ( int i = allsegs ? 3 : 4; i < argc; i++ ) {
		if ( argv[i][0] != '-' ) {
			logger.printf( lt_fatal, "\nDon't know what is this (%s)\n", argv[i] );
			exit ( EXIT_FAILURE );
		}
		
		switch ( argv[i][1] ) {
			case 'g':
				if (!stricmp (argv [i]+1, "gctx_attrs") || !stricmp (argv [i]+1, "gctxattrs"))
					b_gctx_attrs_only = true;
				break;

			case 't':
				if (!stricmp (argv [i]+1, "textsonly"))
					b_texts_only = true;
				else
				if (strstr (argv [i]+1, "threads:") == argv [i]+1)
					threads_count = std::min <long> (atol (argv[i]+9), MAX_POOL);
				break;

			case 'c':
				if (!stricmp (argv[i]+1, "cache")) {
					removeCache = 0;
				} else if (!stricmp (argv[i]+1, "cachero")) {
					removeCache = 0;
					b_cache_ro = true;
				} else if (!stricmp (argv[i]+1, "cachesingle")) {
					removeCache = 0;
					b_single_cache = true;
				}

				break;

			case 'p':
				if (!strcmp (argv[i], "-prepack")) {
					b_prepack = true;
					removeCache = 0;
					b_cache_ro = false;
				} else if (!strcmp (argv[i], "-packdelta") || !strcmp (argv[i], "-pack"))
					b_pack_delta = true;
				else {
					if ( strlen (pArgNamePrefix) ) {
						logger.printf( lt_fatal, "\nDouble '-p' options\n" );
						exit ( EXIT_FAILURE );
					}
					if ( argv[i][2] != ':' ) {
						logger.printf( lt_fatal, "\nBad name prefix (%s)\n", argv[i] );
						exit ( EXIT_FAILURE );
					}
					strcpy ( pArgNamePrefix, &argv[i][3] );
				}
				break;

			case 'l':
				if ( strlen (pArgLogPath) ) {
					logger.printf( lt_fatal, "\nDouble '-l' options\n" );
					exit ( EXIT_FAILURE );
				}
				if ( argv[i][2] != ':' ) {
					logger.printf( lt_fatal, "\nBad logger path (%s)\n", argv[i] );
					exit ( EXIT_FAILURE );
				}
				strcpy ( pArgLogPath, &argv[i][3] );
				break;

			case 'd':
				if (!strcmp (argv [i], "-d")) {
					b_extended_log = true;
					b_flush_log = false;
				} else if (!strcmp (argv[i], "-daily")) {
					b_daily = true;
				} else if (!stricmp (argv [i], "-d+")) {
					b_extended_log = true;
					b_flush_log = true;
				} else {
					if ( strlen (argDltPath) ) {
						logger.printf( lt_fatal, "\nDouble '-d' options\n" );
						exit ( EXIT_FAILURE );
					}			
					if ( argv[i][2] != ':' ) {
						logger.printf( lt_fatal, "\nBad delta path (%s)\n", argv[i] );
						exit ( EXIT_FAILURE );
					}
					strcpy ( argDltPath, &argv[i][3] );
				}
				break;

			case 'D':
				if (!strcmp (argv [i], "-D")) {
					b_extended_log = true;
					b_flush_log = false;
				} else if (!strcmp (argv [i], "-D+")) {
					b_extended_log = true;
					b_flush_log = true;
				} else {
					if ( hasDelOption ) {
						logger.printf( lt_fatal, "\nDouble '-d' options\n" );
						exit ( EXIT_FAILURE );
					}
					if ( argv[i][2] != ':' ) {
						logger.printf( lt_fatal, "\nBad delta path (%s)\n", argv[i] );
						exit ( EXIT_FAILURE );
					}
					hasDelOption = 1;
					strcpy ( pArgDelPath, &argv[i][3] );
				}
				break;

			case 'T':
				if ( g_lDiffTimeLimit ) {
					logger.printf( lt_fatal, "\nDouble '-T' options\n" );
					exit ( EXIT_FAILURE );
				}
				if ( argv[i][2] != ':' ) {
					logger.printf( lt_fatal, "\nBad TEXT diff time limit (%s)\n", argv[i] );
					exit ( EXIT_FAILURE );
				}
				g_lDiffTimeLimit = atol ( &argv[i][3] );
				if ( g_lDiffTimeLimit <= 0 ) {
					logger.printf( lt_fatal, "\nBad TEXT diff time limit (%s)\n", argv[i] );
					exit ( EXIT_FAILURE );
				}
				if (g_lDiffTimeLimit < 6)
					g_lDiffTimeLimit *= 60;
				break;

			case 'i':			
				if (!strcmp (argv [i], "-ignorerevision"))
					b_ignorerevision = true;
				else {
					if ( argv[i][2] != 0 ) {
						logger.printf( lt_fatal, "\nUnknown options (%s)\n", argv [i] );
						exit ( EXIT_FAILURE );
					}
					bIgnoreSegSetDiff = 1;
				}
				break;
			case 'n':
				b_buildNewCorrDiff = true;
				if (!stricmp (argv [i], "-n+"))
					b_buildNewCorrDiff_hack = true;
				break;

			case 'P':
				if ( argv [i][2] != ':' ) {
					logger.printf ( lt_fatal, "\nBad priority option(%s)\n", argv[i] );
					exit ( EXIT_FAILURE );
				}
				if ( !strcmp (&argv[i][3], "DEBUG" )) 
					logger.GetPolicy()->SetLogLevel ( lt_debug );					
				else if ( !strcmp (&argv[i][3], "INFO" )) 
					logger.GetPolicy()->SetLogLevel ( lt_info );
				else if ( !strcmp (&argv[i][3], "ERROR" )) 
					logger.GetPolicy()->SetLogLevel ( lt_error );
				else if ( !strcmp (&argv[i][3], "WARNING" )) 
					logger.GetPolicy()->SetLogLevel ( lt_warning );
				else {
					logger.printf ( lt_fatal, "\nUnknown priority (%s)\n", &argv[i][3] );
					exit ( EXIT_FAILURE );
				}
				break;

			case 's':
			case 'S':
				if (!strcmp (argv[i], "-sbrf")) {
					b_sbrf = true;
				} else {
					checkOnlyDoc = atol(argv[i]+2);
					printf( "check only doc %d", checkOnlyDoc );
				}
				break;

			case 'v':
				if (strstr (argv[i], "-version:") == argv [i]) {
					DELTA_DATA_VERSION = (short) atol (&argv [i][9]);
					break;
				}
				break;

			case 'o':
				if (!stricmp (argv [i]+1, "ovp"))
					b_ovp = true;
				break;

			default :
				logger.printf( lt_fatal, "\nUnknown options (%s)\n", argv [i] );
				exit ( EXIT_FAILURE );
		} // switch
	} // for

	if ( !g_lDiffTimeLimit )
		g_lDiffTimeLimit = 20;

	//
	// open bases
	//
	logger.printf( lt_info, "Open Old Base : %s\n", pArgOldPath );
#ifdef MIN_MEM_CONTEXT
	SearchBase* pOldBase = new SearchBase ( pArgOldPath );
	if (!pOldBase->IsOk () || !pOldBase->IsOkWithoutText() || !(pOldBase->subNames= pOldBase->FindIndex("SubName"))) {
		logger.printf( lt_fatal, "\nCan't open old Base (%s): %s\n", pArgOldPath, pOldBase->strBaseStatus () );
		exit ( EXIT_FAILURE );
	}
#else
	SearchBase* pOldBase = new CachedBaseRO_without6tr4tr (pArgOldPath);
	if ( !pOldBase->check_version()) {
		Stream* str = pOldBase->FindIndex ("Aux")->Open (AUX_VERSION);
		if (str) {
			long version = 0;
			if (str->Length () == sizeof (version)) {
				str->Read (&version, sizeof (version));
			}
			pOldBase->FindIndex ("Aux")->Close (str);
			if (version != GKDB_BASE_VERSION) {
				logger.printf( lt_fatal, "\nCan't open old Base (%s): incorrect base version %ld\n", pArgOldPath, version);
				exit ( EXIT_FAILURE );
			}
		}
		logger.printf( lt_fatal, "\nCan't open old Base (%s): %s\n", pArgOldPath, pOldBase->strBaseStatus () );
		exit ( EXIT_FAILURE );
	}
#endif
												
	if(!check_ready_status(TID_GDLT, pOldBase, &logger))
		return EXIT_FAILURE;

	if (threads_count > 1) {
		for (unsigned long i = 0; i < threads_count; i++) {
#ifdef MIN_MEM_CONTEXT
			pool_old [i] = new SearchBase (pArgOldPath);
			pool_old [i]->IsOk ();
			pool_old [i]->IsOkWithoutText ();
			pool_old [i]->FindIndex ("SubName");
#else
			pool_old [i] = new CachedBaseRO_without6tr4tr(pArgOldPath);
			pool_old [i]->check_version();
#endif
		}
	} else {
		pool_old [0] = pOldBase;
	}
	logger.printf( lt_info, "Open New Base : %s\n", pArgNewPath );
#ifdef MIN_MEM_CONTEXT
	SearchBase* pNewBase = new SearchBase (pArgNewPath);
	if ( !pNewBase->IsOk () || !pNewBase->IsOkWithoutText() || !(pNewBase->subNames= pNewBase->FindIndex("SubName"))) {
		logger.printf( lt_fatal, "\nCan't open new Base (%s): %s\n", pArgNewPath, pNewBase->strBaseStatus () );
		exit ( EXIT_FAILURE );
	}
#else
	SearchBase* pNewBase = new CachedBaseRO_without6tr4tr (pArgNewPath);
	if ( !pNewBase->check_version()) {
		Stream* str = pNewBase->FindIndex ("Aux")->Open (AUX_VERSION);
		if (str) {
			long version = 0;
			if (str->Length () == sizeof (version)) {
				str->Read (&version, sizeof (version));
			}
			pNewBase->FindIndex ("Aux")->Close (str);
			if (version != GKDB_BASE_VERSION) {
				logger.printf( lt_fatal, "\nCan't open new Base (%s): incorrect base version %ld\n", pArgNewPath, version);
				exit ( EXIT_FAILURE );
			}
		}
		logger.printf( lt_fatal, "\nCan't open new Base (%s): %s\n", pArgNewPath, pNewBase->strBaseStatus () );
		exit ( EXIT_FAILURE );
	}
#endif

	if(!check_ready_status(TID_GDLT, pNewBase, &logger))
		return EXIT_FAILURE;	
	
	if (threads_count > 1) {
		for (unsigned long i = 0; i < threads_count; i++) {
#ifdef MIN_MEM_CONTEXT
			pool_new [i] = new SearchBase (pArgNewPath);
			pool_new [i]->IsOk ();
			pool_new [i]->IsOkWithoutText ();
			pool_new [i]->FindIndex ("SubName");
#else
			pool_new [i] = new CachedBaseRO_without6tr4tr(pArgNewPath);
			pool_new [i]->check_version();
#endif
		}
	} else {
		pool_new [0] = pNewBase;
	}

	// флаг указывающий на то что надо сливать все сегменты
	int forAllBase;

	//
	// Строим индекс всех сегментов для постороения дельты
	//   или из командной строки или из 'Here' новой базы
	//
	if (allsegs) {
		char pHereKey[] = "Here";
		Stream * str = pNewBase->FindIndex("Aux")->Open ( pHereKey );
		ids.Get (str);
		pNewBase->FindIndex("Aux")->Close ( str );
	} else
	if (strchr (pArgIds, '-')) {
		allsegs = true;
		char args_str [32];
		strcpy (args_str, pArgIds);
		char* minus = strchr (args_str, '-');
		*minus = 0;
		short from = short(atol (args_str) & 0x7fff);
		short to = short(atol (minus+1) & 0x7fff);

		char pHereKey[] = "Here";
		Stream * str = pNewBase->FindIndex("Aux")->Open ( pHereKey );
		short length = short((str->Length () / 2) & 0x7fff);
		unsigned short *heres = new unsigned short [length], *ptr = heres;
		str->Read (heres, str->Length ());
		pNewBase->FindIndex("Aux")->Close ( str );
		for (short segs = 0; segs < length; segs++, ptr++) {
			unsigned short seg = *ptr;
			if (seg >= from && seg <= to)
				ids.add (seg);
		}
		delete heres;
	} else {
		if ( strcmp ( pArgIds, "0" ) ) {
			//
			// Берем весь список из командной строки
			//
			forAllBase = 0;
			char * pNext = 0;
			int next = 1;
					
			while ( next ) {
				pNext = strchr ( pArgIds, ',' );
				if ( pNext )
					*pNext = '\x0', next = 1;
				else
					next = 0;
						
				unsigned short id;
				if ( !( id = atoi ( pArgIds ) ) ) {
					logger.printf( lt_fatal, "\nBad base ID. (%s)\n", pArgIds );
					exit ( EXIT_FAILURE );
				}
				else
					ids.add(id);
                        				
				if ( next ) {
					*pNext = ',';
					pArgIds = pNext + 1;				
				}
			}		
		} else {
			//
			// Берем весь список из 'Here' новой базы
			//
			char pHereKey[] = "Here";
			Stream * str = b_sbrf || b_daily ? pOldBase->FindIndex("Aux")->Open ( pHereKey ) : pNewBase->FindIndex("Aux")->Open ( pHereKey );
			ids.Get ( str );
			b_sbrf || b_sbrf ? pOldBase->FindIndex("Aux")->Close ( str ) : pNewBase->FindIndex("Aux")->Close ( str );
			forAllBase = 1;
		}
	}
	
	BaseInfo	aOldBaseInfo,	// BaseInfo старой базы
			aNewBaseInfo;	// BaseInfo новой базы
	revision	aOldRev,	// Ревизия старой быза
			aNewRev;	// Ревизия новой быза
	
	//
	// Цикл по всем сливаемым сегментам на предмет следующих действий:
	//	1. Ревизии всех сегментов новой базы должны совпадать
	//	2. Ревизии всех сегментов старой базы должны совпадать
	//	3. При необходимости из списка сливаемых сегментов удаляется те которых нет
	//	   в старой базе
	//	4. Ревизии сегментов старой базы должны быть меньше тех же в новой
	//
	for ( Point p = ids.first(); p; ids.next(p) ) {
		// Берем BaseInfo новой базы
		if (b_sbrf || b_daily) {
			pNewBase->FindBaseInfo (0, aNewBaseInfo);
		} else {
			if (pNewBase->FindBaseInfo( ids(p), aNewBaseInfo ) != sizeof ( BaseInfo ) ) {
				logger.printf( lt_fatal, "\nSelected segment (%d) does not exist in NEW base\n", ids(p) );
				exit ( EXIT_FAILURE );
			}
		}

		//
		// Запоминаем ревизию первого сегмента новой базы
		//
		if ( p == ids.first() )
			aNewRev = aNewBaseInfo.LastUpdate;
		//
		// Сравниваем ревизию первого сегмента новой базы с ревизией текущего сегмента
		//   если не совпадает то выходим
		//
		else if ( CompRevs ( &aNewRev, &aNewBaseInfo.LastUpdate ) )
		{
			char buf[128];
			logger.printf( lt_fatal, "\nNew Segs %d and %d has different revision\n", ids(ids.first()), ids(p) );
			logger.printf( lt_fatal, "%s not equal ", sprintRev ( buf, &aNewRev ) );
			logger.printf( lt_fatal, "%s\n", sprintRev ( buf, &aNewBaseInfo.LastUpdate ) );
			exit ( EXIT_FAILURE );
		}
	
		//
		// Берем BaseInfo старой базы
		//
		if ( pOldBase->FindBaseInfo ( ids(p), aOldBaseInfo ) != sizeof ( BaseInfo ) ) {
			//
			// Нет сегмента в старой базе
			//
			// Если сливаем все сегменты и стоит опция игнорирования не существующиех сегментов
			//   то удаляем этот сегмент из списка сливания, иначе выход
			//
			if ( forAllBase && bIgnoreSegSetDiff ) {
				logger.printf( lt_warning, "\nSelected segment (%d) does not exist in OLD base\n", ids(p) );
				logger.printf( lt_warning, "Differense ignored\n" );
				unsigned short id = ids(p);
				ids.prev(p);
				ids.del(id);
				continue;										
			}
			logger.printf( lt_fatal, "\nSelected segment (%d) does not exist in OLD base\n", ids(p) );
			if ( !allsegs ) exit ( EXIT_FAILURE );				
		}

		//
		// Если ревизия сегмента старой базы больше ревизии сегмента новой базы то выход
		//
		if ( !b_ignorerevision && (CompRevs ( &aOldBaseInfo.LastUpdate, &aNewBaseInfo.LastUpdate ) >= 0)) {
			char buf[128];
			logger.printf( lt_fatal, "\nOld Base has the same or higher revision date\n" );
			logger.printf( lt_fatal, "\tOld Base revision : %s\n", sprintRev ( buf, &aOldBaseInfo.LastUpdate ) );
			logger.printf( lt_fatal, "\tNew Base revision : %s\n", sprintRev ( buf, &aNewBaseInfo.LastUpdate ) );
			exit ( EXIT_FAILURE );
		}
		
		//
		// Запоминаем ревизию первого сегмента старой базы
		//
		if ( p == ids.first() )
			aOldRev = aOldBaseInfo.LastUpdate;
		//
		// Сравниваем ревизию первого сегмента старой базы с ревизией текущего сегмента
		//   если не совпадает то выходим
		//
		else if ( CompRevs ( &aOldRev, &aOldBaseInfo.LastUpdate ) ) {
			char buf[128];
			logger.printf( lt_fatal, "\nOld Segs %d and %d has different revision\n", ids(ids.first()), ids(p) );
			logger.printf( lt_fatal, "%s not equal ", sprintRev ( buf, &aOldRev ) );
			logger.printf( lt_fatal, "%s\n", sprintRev ( buf, &aOldBaseInfo.LastUpdate ) );
			exit ( EXIT_FAILURE );
		}
	}
			
	//
	// Если список сливаемых сегментов пуст то выход
	//
	if ( !ids.length() ) {
		logger.printf( lt_fatal, "\nNo one selected seg id in both Bases\n" );
		exit ( EXIT_FAILURE );
	}

	//
	// Берем ривизию первого сегмента старой базы
	//
	pOldBase->FindBaseInfo ( ids(ids.first()), aOldBaseInfo );
	
	//
	// Список удаляемых документов
	//
	SplaySet<long>* deldocs = 0;

	//
	// Если установлена опция указывающая на файл содержащий удаленные документы
	//   то считываем этот файл и заполняем deldocs
	//
	if ( hasDelOption ) {
		deldocs = new SplaySet<long>;
		
		logger.printf( lt_info, "Open Del-File : %s\n", pArgDelPath );
		if ( strlen ( pArgDelPath ) ) {
			if ( !read_unsignedlongs ( *deldocs, pArgDelPath ) ) {
				logger.printf( lt_fatal, "\nCan't open specified del-file\"%s\"\n", pArgDelPath );
				exit ( EXIT_FAILURE );
			}
		}
	}
		
	//
	// Если не определен префикс названия дельты то генерируем его
	//   в формате:  "MX" - в случае нескольких сегментов
	//		   nn - в случае одного сегмента
	//             где nn - номер первого сегмента в списке
	//
	if ( !strlen(pArgNamePrefix) ) {
		if ( ids.length() != 1 ) {
			if ( allsegs ) {
				sprintf ( pArgNamePrefix, "00" );
			} else {
				sprintf ( pArgNamePrefix, "MX" );
			}
		} else {
			short id = ids(ids.first());
			if ( id >= 100 ) {
				id -= 100;
				char cPrefix = 'a' + id / 10;
				if ( cPrefix > 'z' ) {
					logger.printf( lt_fatal, "Can't auto generate delta name's prefix. Use -p option\n" );
					exit ( EXIT_FAILURE );
				}
				id -= (id / 10) * 10;
				sprintf ( pArgNamePrefix, "%c%01d", cPrefix, id );
			}
			else
				sprintf ( pArgNamePrefix, "%02d", id );
		}
	}

	//
	// Если префикс названия дельты больше двух символов то выход
	//
	if ( strlen (pArgNamePrefix) > 2 ) {
		logger.printf( lt_fatal, "\nToo long name prefix (%s), maximum two chars.\n", pArgNamePrefix );
		exit ( EXIT_FAILURE );
	}

	//
	// Обрабатываем путь к дельте
	//
	if ( strlen (argDltPath) ) {
		if ( argDltPath[strlen(argDltPath)-1] != MPCXC_PATHBRK )
			argDltPath[strlen(argDltPath)] = MPCXC_PATHBRK;
	} else {
		argDltPath[0] = '.';
		argDltPath[1] = MPCXC_PATHBRK;
	}
	
	//
	// Обрабатываем путь к логам
	//
	if ( strlen(pArgLogPath) ) {
		if ( pArgLogPath[strlen(pArgLogPath)-1] != MPCXC_PATHBRK )
			pArgLogPath[strlen(pArgLogPath)] = MPCXC_PATHBRK;
	}
	else
		strcpy ( pArgLogPath, argDltPath );
	
	//
	// Склеиваем путь к дельте и ее префикс
	//
	strcat ( strcpy (pArgDltPath, argDltPath), pArgNamePrefix );

	//
	// Создаем имя дельты добавляя к префиксу дату ревизии старой и новой баз с буквой "D"
	//
	if ( !FillDeltaName ( pArgDltPath + strlen(pArgDltPath), aOldBaseInfo.LastUpdate, aNewBaseInfo.LastUpdate, 'D' ) ) {
		logger.printf( lt_fatal, "\nCan't create delta name\n" );
		exit ( EXIT_FAILURE );
	}
		
	//
	// Создаем имя лога для дельты добавляя к префиксу дату ревизии старой и новой баз с буквой "L"
	//
	strcat ( pArgLogPath, pArgNamePrefix );
	if ( !FillDeltaName ( pArgLogPath + strlen(pArgLogPath), aOldBaseInfo.LastUpdate, aNewBaseInfo.LastUpdate, 'L' ) ) {
		logger.printf( lt_fatal, "\nCan't create logger name\n" );
		exit ( EXIT_FAILURE );
	}

	logger.printf( lt_info, "Delta name : \"%s\"\n", pArgDltPath );
	logger.printf( lt_info, "  Log name : \"%s\"\n", pArgLogPath );
	if ( checkOnlyDoc )
		logger.printf( lt_info, "  check only:\"%d\"\n", checkOnlyDoc );

#ifdef __CYGWIN32__
	//
	// Создаем временную диркторию
	//
	if( mkdir( "\\tmp", 0777 ) != 0 ) {
		if ( errno != EEXIST ) {
			logger.printf( lt_fatal, "Problem creating temporary directory '\\tmp' : %s\n", strerror ( errno ) );
			exit ( EXIT_FAILURE );
		}
	}
#endif
	//
	// Создаем лог
	//
	LogFile	*logfile;
	try {
		logfile = new LogFile ( pArgLogPath );
		logger.GetPolicy()->AddLogDevice ( logfile );
	} catch (...) {
		logger.printf ( lt_error, "\nFile open failure (%s)\n", pArgLogPath );
		logfile = 0;
	}

#if !defined(_NO_DOS_SCREEN) && !defined(_EXTERN_MAIN)
	logger.GetPolicy()->DelLogDevice ( &tracer );  // no std output
	logger.Devices(lt_fatal) = logger.Devices ();
	logger.Devices(lt_fatal).Add ( &tracer );      // only for fatal error
#endif
	
	{
		char pbuf[1024];
		sprintf ( pbuf,"Garant Delta creation programm %s", GARANT_VERSION );	
		screen->InitScreen( pbuf );
	}
		
	//
	// Устанавливаем кодировку
	//
	Recoding ( cd_dos, cd_win, aOldBaseInfo.Name );
	Recoding ( cd_dos, cd_win, aNewBaseInfo.Name );
	
	//
	// Эта структура используется для вывода в дельту
	//
	struct	log_struct	lsTxtLog;

	lsTxtLog.pDltName  = pArgDltPath;
	lsTxtLog.pCompName = aNewBaseInfo.Name;
	lsTxtLog.pOldRev   = &aOldBaseInfo.LastUpdate;
	lsTxtLog.pNewRev   = &aNewBaseInfo.LastUpdate;
	lsTxtLog.pArgv     = argv;
	lsTxtLog.iArgc     = argc;
	lsTxtLog.segs      = &ids;

	//
	// Пишем в лог чтомы начали делать дельту
	//
	fprintLog ( &logger, lt_info, &lsTxtLog, "************************** CREATE DELTA LOG FILE ***********************\n", 1, DELTA_DATA_VERSION );
	
	//
	// Это файл дельты и его создание
	//
	int thread;

	FILE* dfile;
	std::vector<std::string> filenames_todelete;
	for (thread = 0; thread < (b_prepack ? threads_count : 1); thread++) {
		for (int i = 0; i < MAX_SEGS; i++)
			dfiles [thread][i] = 0;

		if (allsegs) {
			//long segs_processed = 0;
			long first_seg = 0;
			for (Point p = ids.first(); p; ids.next(p)) {
				short id = ids(p);
				
				BaseInfo baseinfo;
				if ( id > MAX_SEGS || pOldBase->FindBaseInfo( id, baseinfo ) != sizeof ( BaseInfo ) )
					continue;

				char prefix [4];
				/*
				if ( id >= 100 ) {
					id -= 100;
					char cPrefix = 'a' + id / 10;
					if ( cPrefix > 'z' ) {
						logger.printf( lt_fatal, "Can't auto generate delta name's prefix. Use -p option\n" );
						exit ( EXIT_FAILURE );
					}
					id -= (id / 10) * 10;
					sprintf ( prefix, "%c%01d", cPrefix, id );
				}
				else
					sprintf ( prefix, "%02d", id );
				*/
				sprintf (prefix, "%03d", id);

				char* ptr = strrchr( pArgDltPath, MPCXC_PATHBRK )+1;
				if (strchr (ptr, '.') - ptr == 9) {
					memcpy (ptr, prefix, 3);
				} else {
					char* dup = strdup (ptr + 2);
					strcpy (ptr, prefix);
					strcat (ptr, dup);
					gk_free (dup);
				}
				//*ptr++ = prefix[0];
				//*ptr = prefix[1];
				char suffix [16];
				sprintf (suffix, "_thr%ld", thread);

				char name_with_thread [MAX_PATH];
				strcpy (name_with_thread, pArgDltPath);
				if (b_prepack) {
					if (thread) strcat (name_with_thread, suffix);
					filenames_todelete.push_back (name_with_thread);
				}

				id = ids(p);
				if (thread) {
					if (0 == first_seg) {
						first_seg = id;
						dfiles [thread][id] = mpcxc_fopen (name_with_thread,"w+b" );
					} else {
						dfiles [thread][id] = dfiles [thread][first_seg];
					}
				} else {
					dfiles [thread][id] = mpcxc_fopen (name_with_thread,"w+b" );
				}
				if( !dfiles [thread][id] ) {
					logger.printf( lt_fatal, "\nFile open failure (%s)\n", name_with_thread);
					exit ( EXIT_FAILURE );
				}
			}
		} else {
			dfile = mpcxc_fopen ( pArgDltPath,"w+b" );
			if (!dfile) {
				logger.printf( lt_fatal, "\nFile open failure (%s)\n", pArgDltPath );
				exit ( EXIT_FAILURE );
			}
			dfiles [thread][0] = dfile;
		}

		//
		// Здесь пишется заголовок дельты
		//
		{
			for ( int i = 0; i < MAX_SEGS; i++ ) if ( dfiles [thread][i] ) {
				dfile = dfiles [thread][i];

				//
				// Лог используемый для построения текстового заголовка дельты
				//
				LogFile		deltafile ( dfile );

				//
				// Досовская кодировка
				//
				deltafile.SelfCode( cd_dos );

				logtype_t	lt_delta ( 0, "DELTA BODY" );

				//
				// Добавляем новый тип устройства вывода в лог, специально для дельты
				//
				logger.Devices( lt_delta ).Add ( &deltafile );
					
				u_int64_t fpTextEnd = 0;
				long	len;

				//
				// Первый long это длина заголовка, пока пустая
				//
				fwrite ( &len, sizeof (len) , 1, dfile );

				StorableSplaySet<unsigned short> _ids;
				if ( allsegs ) {
					unsigned short ii = i;
					_ids.add(ii);
					lsTxtLog.segs = &_ids;

					int id = i;
					char prefix [4];
					sprintf (prefix, "%03d", id);
					/*
					if ( id >= 100 ) {
						id -= 100;
						char cPrefix = 'a' + id / 10;
						if ( cPrefix > 'z' ) {
							logger.printf( lt_fatal, "Can't auto generate delta name's prefix. Use -p option\n" );
							exit ( EXIT_FAILURE );
						}
						id -= (id / 10) * 10;
						sprintf ( prefix, "%c%01d", cPrefix, id );
					}
					else
						sprintf ( prefix, "%02d", id );
					*/

					char* ptr = strrchr( pArgDltPath, MPCXC_PATHBRK )+1;
					if (strchr (ptr, '.') - ptr == 9) {
						memcpy (ptr, prefix, 3);
					} else {
						char* dup = strdup (ptr + 2);
						strcpy (ptr, prefix);
						strcat (ptr, dup);
						gk_free (dup);
					}
					//*ptr++ = prefix[0];
					//*ptr = prefix[1];

					lsTxtLog.pDltName = pArgDltPath;
				}
				fprintLog( &logger, lt_delta, &lsTxtLog, "\n******************* ФАЙЛ ПАКЕТНОГО ОБНОВЛЕНИЯ СИСТЕМЫ ГАРАНТ *******************\n", 0, DELTA_DATA_VERSION );
				logger.printf( lt_delta, "********************************************************************************\n" );
			
				fpTextEnd = _ftelli64 (dfile);
				len = fpTextEnd & 0xFFFFFFFF;
				rewind ( dfile );
				//
				// Теперь мы знаем длину заголовка и записываем ее
				//
				fwrite ( &len, sizeof (len) , 1, dfile );
				_fseeki64 ( dfile, fpTextEnd, ACE_OS_SEEK_SET );
			}
		}
	}

	//
	// Создаем класс для работы с двумя базами
	//
	errno_t err;
	char tmp_filename [L_tmpnam_s];

	FILE*	pfTmp1 [MAX_POOL];
	FILE*	pfTmp2 [MAX_POOL];
	for (thread = 0; thread < (b_prepack ? threads_count : 1); thread++) {
		char suffix [16];
		sprintf (suffix, "thr%ld", thread);

		strcpy (tmp_filename, argDltPath);
		err = tmpnam_s (tmp_filename, L_tmpnam_s);
		m_AttrFile_name [thread][0] = 0;
		if (tmp_filename [0] == '\\') {
			strcat (strcpy (m_AttrFile_name [thread], argDltPath), tmp_filename + 1);
			if (thread) strcat (m_AttrFile_name [thread], suffix);
			m_AttrFile [thread] = mpcxc_fopen (m_AttrFile_name [thread], "w+b");
			if (!m_AttrFile [thread])
				err = 1;
		} else {
			err = tmpfile_s (&m_AttrFile [thread]);
		}

		if (err) {
			strcat (strcpy (m_AttrFile_name [thread], argDltPath), "m_attr.tmp");
			strcat (m_AttrFile_name [thread], suffix);
			m_AttrFile [thread] = mpcxc_fopen (m_AttrFile_name [thread], "w+b");
			if (!m_AttrFile [thread]) {
				logger.printf ( lt_fatal, "tmpfile() : Can't create temporary file, %s\n", strerror ( errno ) );
				exit(0);
			}
		}

		pfTmp1_name [thread][0] = 0;
		strcpy (tmp_filename, argDltPath);
		err = tmpnam_s (tmp_filename, L_tmpnam_s);
		if (tmp_filename [0] == '\\') {
			strcat (strcpy (pfTmp1_name [thread], argDltPath), tmp_filename + 1);
			if (thread) strcat (pfTmp1_name [thread], suffix);
			pfTmp1 [thread] = mpcxc_fopen (pfTmp1_name [thread], "w+b");
			if (!pfTmp1 [thread])
				err = 1;
		} else {
			err = tmpfile_s (&pfTmp1 [thread]);
		}

		if (err) {
			strcat (strcpy (pfTmp1_name [thread], argDltPath), "tmp1.tmp");
			strcat (pfTmp1_name [thread], suffix);
			pfTmp1 [thread] = mpcxc_fopen (pfTmp1_name [thread], "w+b" );
			if (!pfTmp1 [thread]) {
				logger.printf ( lt_fatal, "tmpfile() : Can't create temporary file, %s\n", strerror ( errno ) );
				exit(0);
			}
		}

		pfTmp2_name [thread][0] = 0;
		strcpy (tmp_filename, argDltPath);
		err = tmpnam_s (tmp_filename, L_tmpnam_s);
		if (tmp_filename [0] == '\\') {
			strcat (strcpy (pfTmp2_name [thread], argDltPath), tmp_filename + 1);
			if (thread) strcat (pfTmp2_name [thread], suffix);
			pfTmp2 [thread] = mpcxc_fopen (pfTmp2_name [thread], "w+b");
			if (!pfTmp2 [thread])
				err = 1;
		} else {
			err = tmpfile_s (&pfTmp2 [thread]);
		}

		if (err) {
			strcat (strcpy (pfTmp2_name [thread], argDltPath), "tmp2.tmp");
			strcat (pfTmp2_name [thread], suffix);
			pfTmp2 [thread] = mpcxc_fopen (pfTmp2_name [thread], "w+b" );
			if (!pfTmp2 [thread]) {
				logger.printf ( lt_fatal, "tmpfile() : Can't create temporary file, %s\n", strerror ( errno ) );
				exit(0);
			}
		}
	}

	pDocIter = new DocIterator (pNewBase);
	while (pDocIter->Id () < ID_BORDER && !pDocIter->End ())
		++(*pDocIter);

	if (b_prepack) {
		for (thread = 0; thread < threads_count; thread++) {
			for (int i = 0; i < MAX_SEGS; i++ ) {
				fulldiffs [thread][i] = 0;
				if ( dfiles [thread][i] ) {
					StorableSplaySet<unsigned short> _ids;
					if ( allsegs ) {
						unsigned short ii = i;
						_ids.add(ii);
					} else {
						_ids = ids;
					}
					Full *FullDiff = new Full( pool_old [thread]/*pOldBase*/, pool_new [thread]/*pNewBase*/, _ids, deldocs, dfiles [thread][i], removeCache && !allsegs, !allsegs, m_AttrFile [thread], pfTmp1 [thread], pfTmp2 [thread], i, thread );
					if (0 == thread) segcount++;
					FullDiff->PreWork();
					fulldiffs [thread][i] = FullDiff;
				}
			}
			if (0 == thread) {
				segs = new short [segcount];
				segcount = 0;
				for (int i = 0; i < MAX_SEGS; i++)
					if (dfiles [thread][i])
						segs [segcount++] = i;
			}
		}
	} else {
		for (int i = 0; i < MAX_SEGS; i++) {
			fulldiffs [0][i] = 0;
			if ( dfiles [0][i] ) {
				StorableSplaySet<unsigned short> _ids;
				if ( allsegs ) {
					unsigned short ii = i;
					_ids.add(ii);
				} else {
					_ids = ids;
				}
				Full *FullDiff = new Full (pool_old [0]/*pOldBase*/, pool_new [0]/*pNewBase*/, _ids, deldocs, dfiles [0][i], removeCache && !allsegs, !allsegs, m_AttrFile [0], pfTmp1 [0], pfTmp2 [0], i, 0);
				segcount++;
				FullDiff->PreWork();
				fulldiffs [0][i] = FullDiff;
			}
		}
		segs = new short [segcount];
		segcount = 0;
		for (int i = 0; i < MAX_SEGS; i++)
			if (dfiles [0][i])
				segs [segcount++] = i;

		if (b_pack_delta) {
			//создать кэш блобов
			screen->SetMessage ("cache blobs");
			Index *new_blobs = pNewBase->FindIndex ("Blob");
			Index *old_blobs = pOldBase->FindIndex ("Blob");

			for (BTIterator bi (old_blobs); !bi.End (); ++bi) {
				ObjKey* pkey = (ObjKey*) bi.Key();
				u_int64_t key = *((u_int64_t*) pkey);
				Stream *old_str_1 = old_blobs->OpenN (pkey, 1);
				StorableSplaySet<short> oldset;
				oldset.Get (old_str_1);
				map_old_blobbelongs.insert (std::map<u_int64_t, StorableSplaySet<short> >::value_type (key, oldset));
				old_blobs->Close (old_str_1);
			}

			for (BTIterator bi (new_blobs); !bi.End (); ++bi) {
				ObjKey* pkey = (ObjKey*) bi.Key();
				u_int64_t key = *((u_int64_t*) pkey);
				short order = BO_BLBEQU;
				Stream *old_str_1 = old_blobs->OpenN (pkey, 1), *new_str_1 = 0, *old_str_0 = 0, *new_str_0 = 0;
				if (0 == old_str_1) {
					order = BO_BLBNEW;
					new_str_1 = new_blobs->OpenN (pkey, 1);
					StorableSplaySet<short> oldset, newset;						

					newset.Get (new_str_1);
					if (map_old_blobbelongs.find (key) == map_old_blobbelongs.end ())
						map_old_blobbelongs.insert (std::map<u_int64_t, StorableSplaySet<short> >::value_type (key, oldset));
					map_new_blobbelongs.insert (std::map<u_int64_t, StorableSplaySet<short> >::value_type (key, newset));
				} else {
					new_str_1 = new_blobs->OpenN (pkey, 1);
					StorableSplaySet<short> oldset, newset;						
					oldset.Get (old_str_1);
					newset.Get (new_str_1);
					if (oldset != newset)
						order |= BO_BELCHG;

					if (map_old_blobbelongs.find (key) == map_old_blobbelongs.end ())
						map_old_blobbelongs.insert (std::map<u_int64_t, StorableSplaySet<short> >::value_type (key, oldset));
					map_new_blobbelongs.insert (std::map<u_int64_t, StorableSplaySet<short> >::value_type (key, newset));

					old_str_0 = old_blobs->OpenN (pkey, 0);
					new_str_0 = new_blobs->OpenN (pkey, 0);
			
					order |= objcmp (old_str_0, new_str_0);
				}
				if (order != BO_BLBEQU) {
					ObjInfo info;
					if (0 == new_str_0)
						new_str_0 = new_blobs->OpenN (pkey, 0);
					if (0 == old_str_0)
						old_str_0 = old_blobs->OpenN (pkey, 0);

					new_str_0 = new_blobs->OpenN (pkey, 0);

					new_str_0->Seek (0);
					new_str_0->Read (&info, sizeof (ObjInfo));
					map_blob_objinfo.insert (std::map<u_int64_t,ObjInfo>::value_type (key, info));

					if (info.type == EOT_PIC)
						order |= BO_TYPPIC;
					else if (info.type == EOT_RTF)
						order |= BO_TYPRTF;
					else
						order |= BO_TYPOTH;

					map_blob_order.insert (std::map<u_int64_t,short>::value_type (key, order));

					if ((order & BO_OBJCHG) || (order & BO_BELCHG)) {
						long from = new_str_0->Tell (), count = info.size;
						void* buf = malloc (count);
						new_str_0->Read (buf, count);
						map_blob_osize.insert (std::map<u_int64_t,long>::value_type (key, count));
						map_blob_odata.insert (std::map<u_int64_t,void*>::value_type (key, buf));
					}
					if ((order & BO_TALCHG) || (order & BO_BELCHG)) {
						long from = new_str_0->Seek (info.size + sizeof (ObjInfo)), count = new_str_0->Length () - from;
						void* buf = malloc (count);
						new_str_0->Read (buf, count);
						map_blob_tsize.insert (std::map<u_int64_t,long>::value_type (key, count));
						map_blob_tdata.insert (std::map<u_int64_t,void*>::value_type (key, buf));
					}
				}
				map_blob_order.insert (std::map<u_int64_t,short>::value_type (key, order));
				if (old_str_0) old_blobs->Close (old_str_0);
				if (old_str_1) old_blobs->Close (old_str_1);
				if (new_str_0) new_blobs->Close (new_str_0);
				if (new_str_1) new_blobs->Close (new_str_1);
			}
		}

		if (b_pack_delta) {
			screen->SetMessage ("pack cache");
			for (thread = 1; thread < std::max <long> (2,threads_count); thread++) {
				int created = 0;
				m_pDiffHolder [thread] = new DiffHolder (fulldiffs [0][segs[0]]->GetHolderName (), 0, created);
			}

			for (BTIterator chg_btit (m_pDiffHolder [0]->idx1); !chg_btit.End (); ++chg_btit) {
				long doc_id = *(long*)chg_btit.Key ();
				cache_chg_docs.push_back (doc_id);
			}
			for (BTIterator new_btit (m_pDiffHolder [0]->idx2); !new_btit.End (); ++new_btit) {
				long doc_id = *(long*)new_btit.Key ();
				cache_new_docs.push_back (doc_id);
			}
			long count = cache_chg_docs.size () + cache_new_docs.size (), ok_threads = 0, thr, last_time = time (0), prev_perc = 0;

			cache_chg_docs_it = cache_chg_docs.begin ();
			for (thr = 0; thr < threads_count; thr++) {
				boost::thread thread (do_pack_chg, thr);
				thread.detach ();
				ok_threads++;
				ACE_OS::sleep (1);
			}
			bool b_timeout = false;
			screen->SetProgress (0);
			for (;;) {
				long doc_id = get_packchg_doc (false);
				if (doc_id) {
					long processed = std::distance (cache_chg_docs.begin (), std::find (cache_chg_docs.begin (), cache_chg_docs.end (), doc_id)), perc = ( processed * 100 ) / count;
					if (perc != prev_perc) screen->SetProgress (prev_perc = perc);
					last_time = time (0);
					ACE_OS::sleep (5);
				} else {
					long processed = std::distance (cache_chg_docs.begin (), std::find (cache_chg_docs.begin (), cache_chg_docs.end (), doc_id)), perc = ( processed * 100 ) / count;
					if (perc != prev_perc) screen->SetProgress (prev_perc = perc);
					int dones = 0;
					for (thr = 0; thr < threads_count; thr++)
						if (InterlockedCompareExchange (&thread_data [thr].done, 0, 0))
							dones++;
					if (dones == ok_threads)
						break;
					else {
						if (time (0) - last_time > 180) {
							b_timeout = true;
							break;
						}
						ACE_OS::sleep (5);
					}
				}
			}
			cache_new_docs_it = cache_new_docs.begin ();
			for (ok_threads = 0, thr = 0; thr < threads_count; thr++) {
				InterlockedExchange (&thread_data [thr].run, 0);
				InterlockedExchange (&thread_data [thr].done, 0);
				boost::thread thread (do_pack_new, thr);
				thread.detach ();
				ok_threads++;
				ACE_OS::sleep (1);
			}
			for (b_timeout = false;;) {
				long doc_id = get_packnew_doc (false);
				if (doc_id) {
					long processed = cache_chg_docs.size () + std::distance (cache_new_docs.begin (), std::find (cache_new_docs.begin (), cache_new_docs.end (), doc_id)), perc = ( processed * 100 ) / count;
					if (perc != prev_perc) screen->SetProgress (prev_perc = perc);
					last_time = time (0);
					ACE_OS::sleep (5);
				} else {
					long processed = cache_chg_docs.size () + std::distance (cache_new_docs.begin (), std::find (cache_new_docs.begin (), cache_new_docs.end (), doc_id)), perc = ( processed * 100 ) / count;
					if (perc != prev_perc) screen->SetProgress (prev_perc = perc);
					int dones = 0;
					for (thr = 0; thr < threads_count; thr++)
						if (InterlockedCompareExchange (&thread_data [thr].done, 0, 0))
							dones++;
					if (dones == ok_threads)
						break;
					else {
						if (time (0) - last_time > 180) {
							b_timeout = true;
							break;
						}
						ACE_OS::sleep (5);
					}
				}
			}

			std::set<long> chgandnew_docs;
			chgandnew_docs.insert (cache_chg_docs.begin (), cache_chg_docs.end ());
			chgandnew_docs.insert (cache_new_docs.begin (), cache_new_docs.end ());

			screen->SetProgress (100);
			for (thread = 0; thread < threads_count; thread++) {
				map_chgdoc_unpackedsize.insert (thread_data [thread].map_chgdoc_unpackedsize.begin (), thread_data [thread].map_chgdoc_unpackedsize.end ());
				map_chgdoc_packedsize.insert (thread_data [thread].map_chgdoc_packedsize.begin (), thread_data [thread].map_chgdoc_packedsize.end ());
				map_chgdoc_packeddata.insert (thread_data [thread].map_chgdoc_packeddata.begin (), thread_data [thread].map_chgdoc_packeddata.end ());
				map_chgdoc_unpackeddata.insert (thread_data [thread].map_chgdoc_unpackeddata.begin (), thread_data [thread].map_chgdoc_unpackeddata.end ());
				map_newdoc_unpackedsize.insert (thread_data [thread].map_newdoc_unpackedsize.begin (), thread_data [thread].map_newdoc_unpackedsize.end ());
				map_newdoc_packedsize.insert (thread_data [thread].map_newdoc_packedsize.begin (), thread_data [thread].map_newdoc_packedsize.end ());
				map_newdoc_packeddata.insert (thread_data [thread].map_newdoc_packeddata.begin (), thread_data [thread].map_newdoc_packeddata.end ());
				map_newdoc_unpackeddata.insert (thread_data [thread].map_newdoc_unpackeddata.begin (), thread_data [thread].map_newdoc_unpackeddata.end ());
			}

			screen->SetMessage ("loading belongs for changed docs");
			screen->SetProgress (0);

			for (int i = 0; i < segcount; i++) {
				std::deque<long> empty;
				long seg = segs [i];
				map_segment_docs.insert (std::map<long,std::deque<long> >::value_type (seg, empty));
				segs_to_run.insert (seg);
			}
			long total = chgandnew_docs.size (); 
			prev_perc = count = 0;
			for (std::set<long>::const_iterator doc_it = chgandnew_docs.begin (); doc_it != chgandnew_docs.end (); doc_it++, count++) {
				long doc_id = *doc_it, perc = (count * 100) / total;
				StorableSplaySet<unsigned short> ids;
				pNewBase->LoadAttr (doc_id, IDD_BASES, ids);
				for (Point p = ids.first (); p; ids.next (p)) {
					short seg = ids (p);
					std::map<long,std::deque<long> >::iterator map_it = map_segment_docs.find (seg);
					if (map_it != map_segment_docs.end ()) map_it->second.push_back (doc_id);
				}
				if (perc != prev_perc) screen->SetProgress (prev_perc = perc);
			}
		}
	}

	//
	// Начинаем глобализм!!!
	//   результат работы записывается в файл дельты
	//
	BaseInfo baseinfo;
	pNewBase->FindBaseInfo (0, baseinfo);
	DiffProcCreate (std::max<long> (baseinfo.RecCount,1));
	struct	tm	*pNewTime;
	time_t		long_time;
	time (&long_time); pNewTime = localtime (&long_time);
	logger.printf (lt_warning, "start writing at %s", asctime (pNewTime));
	logger.flush (lt_always);

	if (b_prepack) {
		long thr;
		for (thr = 0; thr < threads_count; thr++)
			InterlockedExchange (&thread_data [thr].done, 0);
		for (thr = 0; thr < threads_count; thr++) {
			boost::thread thread (do_thread, thr);
			thread.detach ();
			ACE_OS::sleep (1);
		}
		long last_time;
		bool b_timeout = false;
		for (;;) {
			long thr_doc = get_thr_doc (false);
			if (thr_doc) {
				last_time = time (0);
				ACE_OS::sleep (10);
			} else {
				int dones = 0;
				for (thr = 0; thr < threads_count; thr++)
					if (InterlockedCompareExchange (&thread_data [thr].done, 0, 0))
						dones++;
				if (dones == threads_count)
					break;
				else {
					if (time (0) - last_time > 180) {
						b_timeout = true;
						break;
					}
					ACE_OS::sleep (10);
				}
			}
		}
	} else if (b_pack_delta) {
		seg_it = segs_to_run.begin ();
		std::set<long> threads_to_run;
		for (thread = 0; thread < 1/*threads_count*/ && seg_it != segs_to_run.end (); thread++, seg_it++) {
			thread_data [thread].done = 0;
			thread_data [thread].run = 0;
			thread_data [thread].pool_id = thread;
			thread_data [thread].seg = *seg_it;
			threads_to_run.insert (thread);
		}
		for (std::set<long>::const_iterator thr_it = threads_to_run.begin (); thr_it != threads_to_run.end (); thr_it++) {
			boost::thread thread (do_writepackeddelta, *thr_it);
			thread.detach ();
			ACE_OS::sleep (1);
		}

		while (true) {
			{
			GUARD (writedelta_mutex);
			if (seg_it == segs_to_run.end () && done_threads == threads_to_run.size ())
				break;
			}
			ACE_OS::sleep (5);
		}

		/*
		screen->SetMessage ("clear packed cache");
		std::map<long,char*>::iterator map_it;
		for (map_it = map_chgdoc_packeddata.begin (); map_it != map_chgdoc_packeddata.end (); map_it++)
			delete map_it->second;
		for (map_it = map_newdoc_packeddata.begin (); map_it != map_newdoc_packeddata.end (); map_it++)
			delete map_it->second;
		*/
		if (threads_count) ACE_OS::sleep (std::min <long> (5, g_lDiffTimeLimit));
	} else {
		DocIterator* pDocIter = new DocIterator ( pNewBase );
		BaseInfo baseinfo;
		pNewBase->FindBaseInfo( 0, baseinfo);
		DiffProcCreate( std::max<long>(baseinfo.RecCount,1) );

		while ( !pDocIter->End () ) {
			long lDocId = pDocIter->Id ();
			if ( lDocId > ID_BORDER ) {
				if ( allsegs ) {
					int	order = O_DOC_EQU;
					DocInfo oldinfo;
					if ( pOldBase->FindDocInfo( lDocId, oldinfo ) != sizeof( DocInfo )) {
						order = O_DOC_NEW; 
					} else {
						DocInfo newinfo;
						pNewBase->FindDocInfo( lDocId, newinfo );
						if ( memcmp( &oldinfo.Revision, &newinfo.Revision, sizeof( revision )))
							order = O_DOC_CHG;
					}

					if ( order != O_DOC_EQU ) {
						StorableSplaySet<unsigned short> ids;
						pNewBase->LoadAttr( lDocId, IDD_BASES, ids );

						for ( int i = 0; i < segcount; i++ )
							if ( ids & fulldiffs[0][segs[i]]->m_ids )
								fulldiffs[0][segs[i]]->WorkDoc(lDocId);
						_fseeki64 ( m_AttrFile [0], 0, ACE_OS_SEEK_SET );
					}
				} else {
					Full* ati = fulldiffs[0][segs[0]];
					if ( ati->IsDocFit( lDocId, VER_NEW ))
						ati->WorkDoc(lDocId);
				}
			}
			++(*pDocIter);
			AddDiff(1);
		}
		delete pDocIter;
	}

	logger.flush (lt_always);
	int i;
	if (b_prepack) {
		screen->SetProgress (0);
		long all_count = 0, prev_perc = 0, count = 0;
		std::map<long,long> map_chgdoc_cache, map_newdoc_cache;
		std::set<long> docs_in_caches;
		for (thread = 0; thread < threads_count; thread++) {
			all_count += thread_data [thread].chg_docs.size () + thread_data [thread].new_docs.size ();

			std::deque<long>::const_iterator it;
			for (it = thread_data [thread].chg_docs.begin (); it != thread_data [thread].chg_docs.end (); it++) {
				long doc_id = *it;
				docs_in_caches.insert (doc_id);
				map_chgdoc_cache.insert (std::map<long,long>::value_type (doc_id, thread));
			}

			for (it = thread_data [thread].new_docs.begin (); it != thread_data [thread].new_docs.end (); it++) {
				long doc_id = *it;
				docs_in_caches.insert (doc_id);
				map_newdoc_cache.insert (std::map<long,long>::value_type (doc_id, thread));
			}

			/*
			for (BTIterator chg_btit (m_pDiffHolder [thread]->idx1); !chg_btit.End (); ++chg_btit) {
				long doc_id = *(long*)chg_btit.Key ();
				docs_in_caches.insert (doc_id);
				map_chgdoc_cache.insert (std::map<long,long>::value_type (doc_id, thread));
			}

			for (BTIterator new_btit (m_pDiffHolder [thread]->idx2); !new_btit.End (); ++new_btit) {
				long doc_id = *(long*)new_btit.Key ();
				docs_in_caches.insert (doc_id);
				map_newdoc_cache.insert (std::map<long,long>::value_type (doc_id, thread));
			}
			*/
		}

		
		if (!b_single_cache) {
			struct	tm	*pNewTime;
			time_t		long_time;
			time (&long_time); pNewTime = localtime (&long_time);
			logger.printf (lt_warning, "merging k/s files started at %s\n", asctime (pNewTime));
			logger.flush (lt_always);

			int created = 0;
			DiffHolder *merged = new DiffHolder (fulldiffs [0][segs[0]]->GetHolderName (), b_cache_ro ? 0 : 1, created);

			for (std::set<long>::const_iterator doc_it = docs_in_caches.begin (); doc_it != docs_in_caches.end (); doc_it++) {
				long id = *doc_it;
				std::map<long,long>::const_iterator map_it = map_chgdoc_cache.find (id);
				if (map_it != map_chgdoc_cache.end ()) {
					count++;
					long thread = map_it->second;
					Stream *str = m_pDiffHolder [thread]->idx1->Open (&id);
					if (str) {
						long size = str->Length ();
						char* data = new char [size];
						str->Read (data, size);
						m_pDiffHolder [thread]->idx1->Close (str);

						str = merged->idx1->Open (&id, 1);
						if (str) {
							str->Write (data, size);
							merged->idx1->Close (str);

						}
						delete []data;
					}
				}

				map_it = map_newdoc_cache.find (id);
				if (map_it != map_newdoc_cache.end ()) {
					count++;
					long thread = map_it->second;
					Stream *str = m_pDiffHolder [thread]->idx2->Open (&id);
					if (str) {
						long size = str->Length ();
						char* data = new char [size];
						str->Read (data, size);
						m_pDiffHolder [thread]->idx2->Close (str);

						str = merged->idx2->Open (&id, 1);
						if (str) {
							str->Write (data, size);
							merged->idx2->Close (str);

						}
						delete []data;
					}
				}
				long perc = (count * 100) / all_count;
				if (perc != prev_perc) {
					prev_perc = perc;
					screen->SetProgress (perc);
				}
			}

			delete merged;
			time (&long_time); pNewTime = localtime (&long_time);
			logger.printf (lt_warning, "merging k/s files finished at %s\n", asctime (pNewTime));

			logger.flush (lt_always);
		}
	}

	if (!b_texts_only && !b_prepack) {
		if (!b_pack_delta) {
			for ( i = 0; i < segcount; i++ )
				fulldiffs[0][segs[i]]->PostWork1();

			for ( i = 0; i < segcount; i++ )
				fulldiffs[0][segs[i]]->DeltaBlobs();
		}

		if ( deldocs ) {
			for ( int i = 0; i < segcount; i++ )
				fulldiffs[0][segs[i]]->FindDelDoc();
		} else {
			struct	tm	*pNewTime;
			time_t		long_time;
			time (&long_time); pNewTime = localtime (&long_time);
			logger.printf (lt_warning, "find deleted documents started at %s", asctime (pNewTime));
			logger.flush (lt_always);
			screen->SetMessage ("find deleted documents");

			DocCollection *old_docs = pOldBase->AllTopics (ID_BORDER);
			DocCollection *new_docs = pNewBase->AllTopics (ID_BORDER);
			old_docs->Minus (*new_docs);
			delete new_docs;
			std::set<long> delete_docs;
			delete_docs.insert (cache_chg_docs.begin (), cache_chg_docs.end ());
			delete_docs.insert (cache_new_docs.begin (), cache_new_docs.end ()); //если документ был в одном сегменте, а переехал в другой - в кэше он new
			for (int i = 0; i < old_docs->ItemCount; i++)
				delete_docs.insert ((*old_docs)[i]);

			for (std::set<long>::const_iterator doc_it = delete_docs.begin (); doc_it != delete_docs.end (); doc_it++) {
				long doc_id = *doc_it;

				StorableSplaySet<unsigned short> oldids, newids;
				pOldBase->LoadAttr (doc_id, IDD_BASES, oldids);
				bool b_chgdoc = old_docs->IndexOf (&doc_id) == -1;
				if (b_chgdoc) pNewBase->LoadAttr (doc_id, IDD_BASES, newids);

				for (int i = 0; i < segcount; i++) {
					Full* ati = fulldiffs[0][segs[i]];
					if (oldids & ati->m_ids) {
						bool fit = false;
						if (b_chgdoc) {
							if ( !(newids & ati->m_ids))
								fit = true;
							else if (b_buildNewCorrDiff_hack) {
								//для оптимального построения дифы NewCorr надо в g_global_deldocs добавить документы, у которых в IDD_BASES удалились сегменты
								oldids -= newids;
								if (oldids.length ())
									ati->g_global_deldocs.insert (doc_id);
							}
						} else {
							fit = true;
						}

						if (fit)
							ati->AddDelDoc (doc_id);
					}
				}
			}

			for ( int i = 0; i < segcount; i++ )
				fulldiffs[0][segs[i]]->FinishDelDoc();
			time (&long_time); pNewTime = localtime (&long_time);
			logger.printf (lt_warning, "find deleted documents finished at %s", asctime (pNewTime));
			logger.flush (lt_always);
		}
	} //if (!b_texts_only && !b_prepack)

	if (b_prepack) {
		if (b_single_cache) {
			delete m_pDiffHolder [0];
		} else {
			for (int thread = 0; thread < threads_count; thread++) {
				delete m_pDiffHolder [thread];
				fulldiffs [thread][segs[0]]->RemoveCache ();
			}
		}
	}

	if (allsegs && removeCache && segcount)
		fulldiffs[0][segs[0]]->RemoveCache();

	if (!b_prepack) {
		if (threads_count > 1) {
			long thread_id;
			for (thread_id = 0; thread_id < MAX_SEGS; thread_id++) {
				InterlockedExchange (&thread_data [thread_id].done, 0);
				InterlockedExchange (&thread_data [thread_id].run, 0);
			}

			if (b_buildNewCorrDiff) {
				screen->SetMessage ("cache newcorr");
				time (&long_time); pNewTime = localtime (&long_time);
				logger.printf (lt_warning, "cache newcorr index started at %s", asctime (pNewTime));
				logger.flush (lt_always);
				std::set<long> corr_docs;
				std::set<long>::const_iterator corr_it;
				for (int seg = 0; seg < segcount; seg++)
					corr_docs.insert (fulldiffs[0][segs[seg]]->g_cordocs.begin (), fulldiffs[0][segs[seg]]->g_cordocs.end ());

				Index *old_newcorr = pOldBase->FindIndex ("NewCorr");
				for (corr_it = corr_docs.begin (); corr_it != corr_docs.end (); corr_it++) {
					long doc_id = *corr_it;
					std::vector<CorrRef> corrs;
					Stream *str = old_newcorr->Open (&doc_id);
					if (str) {
						corrs.resize (str->Length () / sizeof (CorrRef));
						str->Read (&corrs[0], str->Length ());
						old_newcorr->Close (str);
					}
					if (corrs.size ()) map_old_newcorr.insert (std::map<long,std::vector<CorrRef> >::value_type (doc_id, corrs));
				}
				Index *new_newcorr = pNewBase->FindIndex ("NewCorr");
				for (corr_it = corr_docs.begin (); corr_it != corr_docs.end (); corr_it++) {
					long doc_id = *corr_it;
					std::vector<CorrRef> corrs;
					Stream *str = new_newcorr->Open (&doc_id);
					if (str) {
						corrs.resize (str->Length () / sizeof (CorrRef));
						str->Read (&corrs[0], str->Length ());
						new_newcorr->Close (str);
					}
					if (corrs.size ()) map_new_newcorr.insert (std::map<long,std::vector<CorrRef> >::value_type (doc_id, corrs));
				}

				Index *old_corr = pOldBase->FindIndex ("Correspondent");
				for (corr_it = corr_docs.begin (); corr_it != corr_docs.end (); corr_it++) {
					long doc_id = *corr_it;
					std::vector<Ref> corrs;
					Stream *str = old_corr->Open (&doc_id);
					if (str) {
						corrs.resize (str->Length () / sizeof (Ref));
						str->Read (&corrs[0], str->Length ());
						old_corr->Close (str);
					}
					if (corrs.size ()) map_old_corr.insert (std::map<long,std::vector<Ref> >::value_type (doc_id, corrs));
				}
				Index *new_corr = pNewBase->FindIndex ("Correspondent");
				for (corr_it = corr_docs.begin (); corr_it != corr_docs.end (); corr_it++) {
					long doc_id = *corr_it;
					std::vector<Ref> corrs;
					Stream *str = new_corr->Open (&doc_id);
					if (str) {
						corrs.resize (str->Length () / sizeof (Ref));
						str->Read (&corrs[0], str->Length ());
						new_corr->Close (str);
					}
					if (corrs.size ()) map_new_corr.insert (std::map<long,std::vector<Ref> >::value_type (doc_id, corrs));
				}

				time (&long_time); pNewTime = localtime (&long_time);
				logger.printf (lt_warning, "cache newcorr index finished at %s", asctime (pNewTime));
				logger.flush (lt_always);
			}

			//запустить сначала одну нить, чтобы она создала кэши Control/KindCorr/Опечаток
			//std::set<long> pools; //какие нити работают в данный момент
			//pools.insert (0);

			logger.printf (lt_always, "run thread 0\n");
			logger.flush (lt_always);
			seg_it = segs_to_run.begin ();
			done_threads = thread_id = 0;
			InterlockedExchange (&thread_data [thread_id].seg, *seg_it);
			InterlockedExchange (&thread_data [thread_id].done, 0);
			InterlockedExchange (&thread_data [thread_id].run, 0);
			do_postwork2 (thread_id);
			InterlockedDecrement (&b_first_postwork2);

			threads_count = 1;

			logger.printf (lt_always, "run other threads\n");
			seg_it++;
			std::set<long> threads_to_run;
			for (done_threads = thread = 0; thread < threads_count && seg_it != segs_to_run.end (); thread++, seg_it++) {
				thread_data [thread].done = 0;
				thread_data [thread].run = 0;
				thread_data [thread].pool_id = thread;
				thread_data [thread].seg = *seg_it;
				threads_to_run.insert (thread);
			}
			for (std::set<long>::const_iterator thr_it = threads_to_run.begin (); thr_it != threads_to_run.end (); thr_it++) {
				boost::thread thread (do_postwork2, *thr_it);
				thread.detach ();
				ACE_OS::sleep (1);
			}

			while (true) {
				{
				GUARD (writedelta_mutex);
				if (seg_it == segs_to_run.end () && done_threads == threads_to_run.size ())
					break;
				}
				ACE_OS::sleep (5);
			}
		} else {
			for (thread = 0; thread < threads_count; thread++) {
				for ( i = 0; i < segcount; i++ ) {
					if (!b_texts_only && !b_prepack)
						fulldiffs[thread][segs[i]]->PostWork2 (pOldBase, pNewBase, thread);
					delete fulldiffs [thread] [segs[i]];
					fclose( dfiles [thread][segs[i]] );
				}
			}
		}
	}

	ACE_OS::sleep (5);

	if (b_prepack) {
		for (thread = 0; thread < threads_count; thread++) {
			for (i = 0; i < segcount; i++) {
				delete fulldiffs [thread] [segs[i]];
				if (0 == thread)
					fclose (dfiles [thread][segs [i]]);
			}
		}
		for (thread = 1; thread < threads_count; thread++)
			fclose (dfiles [thread][segs [0]] );
		for (std::vector<std::string>::const_iterator it = filenames_todelete.begin (); it != filenames_todelete.end (); it++) {
			const char* name = it->c_str ();
			ace_os_unlink (name);
		}
	}

	//
	// Удаляем глобализм
	//

	if( deldocs )
		delete deldocs;

	for (thread = 0; thread < (b_prepack ? threads_count : 1); thread++) {
		fclose( m_AttrFile [thread]);
		fclose( pfTmp1 [thread]);
		fclose( pfTmp2 [thread]);
		if (strlen (m_AttrFile_name [thread]))
			ace_os_unlink (m_AttrFile_name [thread]);
		if (strlen (pfTmp1_name [thread]))
			ace_os_unlink (pfTmp1_name [thread]);
		if (strlen (pfTmp2_name [thread]))
			ace_os_unlink (pfTmp2_name [thread]);
	}

	if( timer )
		delete timer;

	if ( ((ErrorPolicy*)logger.GetPolicy())->ErrCount() ) 
		logger.printf ( lt_always, "\n\tThere were %d errors!\n", ((ErrorPolicy*)logger.GetPolicy())->ErrCount() );
	else
		logger.printf ( lt_always, "\n\tThere was no error\n" );

	logger.printf ( lt_info, "\n\n*************************** END OF LOG ************************\n\n\n" );
	if ( logfile )
		delete logfile;

#ifndef	MIN_MEM_CONTEXT
	if (pOldBase)
		delete pOldBase;
	if (pNewBase)
		delete pNewBase;
#endif

	screen->SetMessage ( "CREATION COMPLETE!" );
	screen->CloseScreen();
#ifndef _EXTERN_MAIN
	delete screen;
#endif

	/*
	suppress_crash_handlers( );
	abort ();
	*/

	return 0;
}

void suppress_crash_handlers ()
{
	SetUnhandledExceptionFilter (unhandled_exception_handler);
	SetErrorMode (SEM_FAILCRITICALERRORS | SEM_NOALIGNMENTFAULTEXCEPT | SEM_NOGPFAULTERRORBOX | SEM_NOOPENFILEERRORBOX);
	_set_abort_behavior (0, _WRITE_ABORT_MSG | _CALL_REPORTFAULT);
}
 
long WINAPI unhandled_exception_handler (EXCEPTION_POINTERS* p_exceptions)
{
	(void*)p_exceptions;
	return EXCEPTION_EXECUTE_HANDLER;
}

///////////////////////////////////////////////////////////////////////////////
//			End of file "delta.cpp"				     //
///////////////////////////////////////////////////////////////////////////////
