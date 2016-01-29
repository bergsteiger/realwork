/*
 * $Id: gdltmrg.cpp,v 2.30 2013/12/16 11:08:17 young Exp $
 */

#include "ace/ACE.h"
#include <cstdio>
#include <cstring>
#include <fcntl.h>
#include "deltamerger.h"
#include "dhreader.h"
#include "garver.h"
#include "Logger.h"
#include "osdep.h"
#include "SplaySet.h"

#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"

#ifndef _EXTERN_MAIN
	code_t out = mpcxc_cd_cursys();
	LogScreen tracer;
	Logger logger;
#else
	extern Logger logger;
#endif

#ifndef _EXTERN_MAIN
int MemoryError ( )
{
	printf ( "Memory error" );
	exit ( 0 );
	return 0;
}

void cdecl OkBox ( char *s1, char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit ( 0 );
}

void cdecl OkBox ( const char *s1, const char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit ( 0 );
}

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (1);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	return main_logic (argc, argv);
}

#define	MAX_THREADS	16
struct thread_data_struct {
	volatile int done;
};
thread_data_struct thread_data [MAX_THREADS];
std::deque<SplaySet <unsigned short> >::const_iterator delta_it;
ACE_Recursive_Thread_Mutex delta_it_mutex;
std::deque<SplaySet <unsigned short> > deltas;
long delta_counter = 0;

std::deque<SplaySet <unsigned short> >::const_iterator get_delta (bool next, long& counter)
{
	RWRITE_GUARD (delta_it_mutex) {
		if (delta_it != deltas.end ()) {
			if (next) {
				delta_it++;
				counter = ++delta_counter;
			}
		}
		return delta_it;
	}
}

DeltaMerger* pMerger;

void	do_delta (int* thread_id)
{
	long this_thread_id = *thread_id, count;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	DeltaMerger::Settings settings;
	SplaySet<Period> per = pMerger->getAllPeriods ();	
	settings.period = per (per.first ());

	for (;;) {
		std::deque<SplaySet <unsigned short> >::const_iterator it = get_delta (true, count);
		if (it == deltas.end ()) {
			printf ("thread %ld finished\n", this_thread_id); fflush (stdout);
			break;
		}

		char delta_name [16];
		sprintf (delta_name, "out\\%ld", count);
		settings.out_name = delta_name;
		settings.mrg_segs = *it;

		//try {
			pMerger->assemblingDelta (settings);
		//} catch (...) {
		//}
	}
	thread_data_ptr->done = 1;
}

int main_logic ( int argc, char *argv[] )
{
	logger.Init ( &tracer, cd_win, out );
#else
int main_dmerge ( int argc, char** argv )
{
#endif
	logger.OverlapPolicy ( new ErrorPolicy () );
	logger.GetPolicy()->SetLogLevel ( lt_info );
	logger.printf( lt_always, "Garant Delta merger. Version %s.\n", GARANT_VERSION);

	char * pLogName = 0;
	char * pIniName = 0;

	SplaySet <SString> mrgFiles;
	DeltaMerger::Settings settings;
	
	int i;
	for ( i = 1; i < argc; i++ ) {
		if ( argv[i][0] == '-' ) { 
			switch ( argv[i][1] ) {
			case 'l':
				if ( argv[i][2] != ':' ) {
					logger.printf ( lt_fatal, "\nUnknown parametr (%s)\n", argv[i] );
					exit ( EXIT_FAILURE );
				}
				if ( pLogName ) {
					logger.printf ( lt_fatal, "\nDouble '-l' options\n" );
					exit ( EXIT_FAILURE );
				}
				pLogName = argv[i]+3;
				break;
			
			case 'i':
				if ( argv[i][2] != ':' ) {
					logger.printf ( lt_fatal, "\nUnknown parametr (%s)\n", argv[i] );
					exit ( EXIT_FAILURE );
				}
				if ( pIniName ) {
					logger.printf ( lt_fatal, "\nDouble '-i' options\n" );
					exit ( EXIT_FAILURE );
				}
				pIniName = argv[i] + 3;
				break;
			case 'P' :
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
				else if ( !strcmp (&argv[i][3], "FULL" )) 
					logger.GetPolicy()->SetLogLevel ( 100000 );
				else {
					logger.printf ( lt_fatal, "\nUnknown priority (%s)\n", &argv[i][3] );
					exit ( EXIT_FAILURE );
				}
				break;

			default :
				logger.printf ( lt_fatal, "\nUnknown options (%s)\n", argv [i] );
				exit ( EXIT_FAILURE );
			}
		} else {
			if ( i == 1 ) {
				settings.out_name = argv [i];
			} else {
				SString arg (argv[i]);
				mrgFiles.add ( arg );
			}
		}
	}

	if ( pIniName ) {
	} else {
		if ( !settings.out_name || !mrgFiles.length() ) {
			logger.printf ( lt_always, "  USAGE : gdltmrg.exe <out> <merge>[merge] [-options]\n\n" );
			logger.printf ( lt_always, "         'out'   is out delta path and name (w/o extension)\n" );
			logger.printf ( lt_always, "         'merge' is deltas to merge path and name\n" );
			logger.printf ( lt_always, "     OR : gdltmrg.exe <out> -i:<file> [-options]\n\n" );
			logger.printf ( lt_always, "         'file'  is input-file path and name\n" );
			logger.printf ( lt_always, "options :\n" );
			logger.printf ( lt_always, "       l:<path>' is logger file's path and name\n" );
			logger.printf ( lt_always, "                 (optional, default : \"<out>.logger\")\n" );
			logger.printf ( lt_always, "       P:<prior> logger output priority, default INFO\n");
			logger.printf ( lt_always, "                 DEBUG   - full log information\n");
			logger.printf ( lt_always, "                 INFO    - standart log information\n");
			logger.printf ( lt_always, "                 WARNING - warning and error information\n");
			logger.printf ( lt_always, "                 ERROR   - only error information\n");
			logger.printf ( lt_always, "       nopic     exclude delta for picture\n");
			logger.printf ( lt_always, "       nortf     exclude delta for RTF-files\n");

			return 3;
		}
	}

	if (!stricmp (settings.out_name, "in.txt")) {
		FILE *in = fopen (argv [1], "rt");
		if (in) {
			while (!feof (in)) {
				char str [4096];
				if (!fgets (str, sizeof (str), in))
					break;
				int length = strlen (str);

				while (length && (str [length-1] == 10 || str [length-1] == 13))
					str [--length] = 0;
				if (!length)
					continue;

				std::vector<std::string> parts;
				boost::split (parts, str, boost::is_any_of (","));
				SplaySet <unsigned short> segs;
				for (unsigned int i = 0; i < parts.size (); i++) {
					unsigned short seg = (unsigned short) (atol (parts.at (i).c_str ()) & 0x7FFF); 
					segs.add (seg);
				}
				deltas.push_back (segs);			
			}
			fclose (in);
		}

		try {
			pMerger = new DeltaMerger;
			if ( !pMerger->loadDeltas ( mrgFiles ) ) return 1;

			delta_it = deltas.begin ();

			int thread_id, threads_count = 6;
			for (thread_id = 0; thread_id < threads_count; thread_id++)
				thread_data [thread_id].done = 0;

			long ok_threads = 0;
			for (thread_id = 0; thread_id < threads_count; thread_id++) {
				ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
				inst->spawn ((ACE_THR_FUNC)do_delta, &thread_id, THR_DETACHED);
				ok_threads++;
				ACE_OS::sleep (2);
			}
			long last_time = static_cast<long> (time (0)), count;
			for (;;) {
				if (get_delta (false, count) == deltas.end ()) {
					int dones = 0;
					for (thread_id = 0; thread_id < threads_count; thread_id++)
						if (thread_data [thread_id].done)
							dones++;
					if (dones == ok_threads)
						break;
					else {
						if (time (0) - last_time > 180) {
							printf ("\ntimeout"); fflush (stdout);
							break;
						}
						ACE_OS::sleep (10);
					}
				} else {
					last_time = (long) time (0);
					ACE_OS::sleep (10);
				}
			}
		} catch (...) {
			logger.printf ( lt_error, "Exception while invoke DeltaMerger methods...\n");
			return 1;
		}
		/*
		int delta_cnt = 0;
		for (std::deque<SplaySet <unsigned short> >::const_iterator delta_it = deltas.begin (); delta_it != deltas.end (); delta_it++) {
			char delta_name [16];
			sprintf (delta_name, "out\\%ld", ++delta_cnt);
			settings.out_name = delta_name;
			settings.mrg_segs = *delta_it;

			SplaySet<Period> per = pMerger->getAllPeriods ();	
			settings.period = per(per.first());
			char * outname = 0;
			if ( !pMerger->assemblingDelta ( settings, outname ) ) return 1;
			if ( outname ) free ( outname );
		}
		*/
	} else {
		try {
			pMerger = new DeltaMerger;
			if (!pMerger->loadDeltas (mrgFiles))
				return 1;

			SplaySet<Period> per = pMerger->getAllPeriods ();	
			settings.period = per (per.first ());
			settings.mrg_segs = pMerger->whatForPeriod ( settings.period );	
			
			if (!pMerger->assemblingDelta (settings))
				return 1;

			delete pMerger;
		} catch (...) {
			logger.printf ( lt_error, "Exception while invoke DeltaMerger methods...\n");
			return 1;
		}
	}
    
	return 0;
}
