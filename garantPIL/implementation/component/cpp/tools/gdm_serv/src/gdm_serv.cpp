/*
 * $Id: gdm_serv.cpp,v 1.20 2005/11/01 13:31:38 grigorio Exp $
 */

//#define _USE_CORBA_CONVERTS

#include "OrbServer.h"
#include "ServerShell.h"
#include "merger_i.h"
#include "killer_i.h"

#include <unistd.h>
#include <cstdio>
#include <fcntl.h>

#include "garver.h"
#include "Logger.h"
#include "osdep.h"

#ifndef _EXTERN_MAIN
	code_t out = mpcxc_cd_cursys();
	LogScreen tracer;
	Logger log;
#else
	extern Logger log;
#endif

class LogShell : public ServerShell
{
public:
	LogShell () {};
	
	void Message ( const char* pMess, const char* pTitle, long lType ) {
		log.printf ( lt_debug, "%s::%s\n", pMess, pTitle );
	}
};

void printHelp ()
{
	log.printf ( lt_always, "  USAGE : gdm_serv [-xmplPh][-ORB]\n\n" );
	log.printf ( lt_always, "       c:<name>   - COS Naming context bind name\n" );
	log.printf ( lt_always, "                  (optional, default : \"Garant_delta_server\")\n" );
	log.printf ( lt_always, "       m:<size>   - memory usage limit in Mb\n" );
	log.printf ( lt_always, "                  (optional, default : unlimit)\n" );
	log.printf ( lt_always, "       p:<days>   - delta period in cache limit in days\n" );
	log.printf ( lt_always, "                  (optional, default : unlimit)\n" );
	log.printf ( lt_always, "       l:<path>   - is log file's path and name\n" );
	log.printf ( lt_always, "                  (optional, default : stdout)\n" );
	log.printf ( lt_always, "       P:<prior>  - log output priority, default INFO\n");
	log.printf ( lt_always, "                  DEBUG   - full log information\n");
	log.printf ( lt_always, "                  INFO    - standart log information\n");
	log.printf ( lt_always, "                  WARNING - warning and error information\n");
	log.printf ( lt_always, "                  ERROR   - only error information\n");
	log.printf ( lt_always, "       L          - create special thread's log\n" );
	log.printf ( lt_always, "                  (optional, default : stdout)\n" );
	log.printf ( lt_always, "       ORB<param> <value> - special ORB options\n" );
	log.printf ( lt_always, "                  (see ORB's manual for details)\n" );
	log.printf ( lt_always, "       h          - to display this help\n" );
	exit ( EXIT_FAILURE );
}

#ifndef _EXTERN_MAIN
int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	log.Init ( &tracer, cd_win, out, lt_info );
	log.GetPolicy()->SetLogLevel ( lt_debug );
#else
int main_gdm_serv ( int argc, char** argv )
{	
#endif	
	log.printf( lt_always, "Garant Delta Merger server. Version %s.\n", GARANT_VERSION);

	char * pLogName = 0;
	char * pContextName = 0;
	unsigned long phsLimit = 0;
	unsigned long dayLimit = 0;
	int isThdlog = 0;

	int i;
	for ( i = 1; i < argc; i++ ) {
		if ( argv[i][0] == '-' ) { 
			switch ( argv[i][1] ) {
			case 'c':
				if ( argv[i][2] != ':' ) {
					log.printf ( lt_fatal, "\nUnknown parametr (%s)\n\n", argv[i] );
					printHelp();
				}
				if ( pContextName ) {
					log.printf ( lt_fatal, "\nDouble '-c' options\n\n" );
					printHelp();
				}
				pContextName = argv[i]+3;
				break;
			case 'm':
				if ( argv[i][2] != ':' ) {
					log.printf ( lt_fatal, "\nUnknown parametr (%s)\n\n", argv[i] );
					printHelp();
				}
				if ( phsLimit ) {
					log.printf ( lt_fatal, "\nDouble '-m' options\n\n" );
					printHelp();
				}
				phsLimit = atol ( &argv[i][3] );
				if ( phsLimit <= 0 ) {
					log.printf( lt_fatal, "\nBad free memory limit (%s)\n\n", argv[i] );
					printHelp();
				}
				phsLimit *= 1024*1024;
				break;
			case 'p':
				if ( argv[i][2] != ':' ) {
					log.printf ( lt_fatal, "\nUnknown parametr (%s)\n\n", argv[i] );
					printHelp();
				}
				if ( dayLimit ) {
					log.printf ( lt_fatal, "\nDouble '-p' options\n\n" );
					printHelp();
				}
				dayLimit = atol ( &argv[i][3] );
				if ( dayLimit <= 0 ) {
					log.printf( lt_fatal, "\nBad period limit (%s)\n\n", argv[i] );
					printHelp();
				}				
				break;

			case 'O':
				if ( argv[i][2] != 'R' || argv[i][3] != 'B' ) {
					log.printf ( lt_fatal, "\nUnknown parametr (%s)\n\n", argv[i] );
					printHelp();
				}
				i++; // skip ORB args
				break;

			case 'l':
				if ( argv[i][2] != ':' ) {
					log.printf ( lt_fatal, "\nUnknown parametr (%s)\n\n", argv[i] );
					printHelp();
				}
				if ( pLogName ) {
					log.printf ( lt_fatal, "\nDouble '-l' options\n\n" );
					printHelp();
				}
				pLogName = argv[i]+3;
				break;
			
			case 'P' :
				if ( argv [i][2] != ':' ) {
					log.printf ( lt_fatal, "\nBad priority option(%s)\n\n", argv[i] );
					printHelp();
				}
				if ( !strcmp (&argv[i][3], "DEBUG" )) 
					log.GetPolicy()->SetLogLevel ( lt_debug );					
				else if ( !strcmp (&argv[i][3], "INFO" )) 
					log.GetPolicy()->SetLogLevel ( lt_info );
				else if ( !strcmp (&argv[i][3], "ERROR" )) 
					log.GetPolicy()->SetLogLevel ( lt_error );
				else if ( !strcmp (&argv[i][3], "WARNING" )) 
					log.GetPolicy()->SetLogLevel ( lt_warning );
				else if ( !strcmp (&argv[i][3], "FULL" )) 
					log.GetPolicy()->SetLogLevel ( 100000 );
				else {
					log.printf ( lt_fatal, "\nUnknown priority (%s)\n\n", &argv[i][3] );
					printHelp();
				}
				break;
			case 'h':
				printHelp();
				break;
			case 'L':
				isThdlog = 1;
				break;
			default :
				log.printf ( lt_fatal, "\nUnknown options (%s)\n", argv [i] );
				printHelp();
			}
		} else {
			printHelp();
		}
	}

	if ( !pContextName ) pContextName = "Garant_delta_server";

	LogFile* logfile = 0;
	if ( pLogName ) {		
		try {
			logfile = new LogFile ( pLogName );
			log.GetPolicy()->AddLogDevice ( logfile );
		} catch (...) {
			log.printf ( lt_error, "\nFile open failure (%s)\n", pLogName );
			logfile = 0; 

			return 1;
		}
	}

	LogShell * pShell = new LogShell;
	ORBServer * pServer;
	try {
		pServer = new POAServer ( pShell );
		//pServer->init (inTimeout, outTimeout);
		pServer->init (argc, argv);
	} catch (...) {
		log.printf (lt_fatal, "Error while ORB initializing\n" );
		return 1;
	}
	
	try {
		pServer->attach ( new Merger_i (phsLimit, dayLimit, isThdlog), "Merger", pContextName );
		pServer->attach ( new OrbKiller_i (pServer), "Killer", pContextName );
	} catch (...) {
		log.printf (lt_fatal, "Error while Server to ORB attaching\n" );
		return 1;
	}
	
	try {
		pServer->startServants ( ORBServer::st_sync );
	} catch (...) {
		log.printf (lt_fatal, "Error while Server working\n" );
		return 1;
	}
			
	delete pServer;
	delete pShell;

	if ( logfile ) delete logfile;

	return 0;
}


