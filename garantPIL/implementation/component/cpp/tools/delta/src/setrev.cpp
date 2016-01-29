
#include "shared/Core/fix/mpcxc.h"

/*
 * $Id: setrev.cpp,v 2.45 2013/11/15 08:31:27 young Exp $
 */
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fcntl.h>
#include <sys/stat.h>
#include <ctime>
#include "grev_ver.h"
#include "garver.h"
#include "stdbase.h"
#include "garutils.h"
#include "basemask.h"
#include "reviser.h"
#include "Logger.h"
#include "adds.h"

#ifndef _EXTERN_MAIN
	#include "gsscreen.h"

	code_t out = mpcxc_cd_cursys();

	LogScreen tracer;
	Logger logger;
#else
	extern Logger logger;
#endif

int StrRev ( char * pStr, revision& theRev )
{	
	if ( !strcmp ( pStr, "cur" ) ) {
		struct tm *tmCur;        
		time_t lTime;
		time( &lTime );
		tmCur = localtime( &lTime );
		if ( !tmCur ) return 0;

		theRev.RevisionDate.da_day = tmCur->tm_mday;
		theRev.RevisionDate.da_mon = tmCur->tm_mon + 1;
		theRev.RevisionDate.da_year = tmCur->tm_year + 1900;
		theRev.RevisionTime.ti_min = tmCur->tm_min;
		theRev.RevisionTime.ti_hour = tmCur->tm_hour;
	} else {
		unsigned short day, month, year, hour, min, find;
		find = sscanf ( pStr, "%hd/%hd/%hd:%hd:%hd", &day, &month, &year, &hour, &min );

		if ( find != 3 && find != 5 ) return 0;
		if ( day > 31 || month > 12 ) return 0;
		if ( year < 100 ) year += 2000;
		theRev.RevisionDate.da_day = (unsigned char)day;
		theRev.RevisionDate.da_mon = (unsigned char)month;
		theRev.RevisionDate.da_year = year;
		if ( find == 5 ) {
			if ( hour > 23 || min > 59 ) return 0;
			theRev.RevisionTime.ti_min = (unsigned char)min;
			theRev.RevisionTime.ti_hour = (unsigned char)hour;
		} else {
			theRev.RevisionTime.ti_min = 0;
			theRev.RevisionTime.ti_hour = 0;
		}
	}

	return 1;
}

#ifndef _EXTERN_MAIN
bool	compareOnlyTexts = false;

bool	compatMode = false;

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (1);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	return mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
}

int main_logic ( int argc, char *argv[] )
{
	{
		VER_PARAM verParam;
		int	i;

		verParam.exeId= TID_GREV_2;			// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i == VC_ADD_OK){
			}else{
			}
	#ifdef _DEBUG
			printf("\n *** GREV Debug Version. For test, only... ***\n\n");
	#else
			exit(0);
	#endif
		}
	}

	logger.Init ( &tracer, cd_win, out );
	ProgressScreen* screen = new GSScreen( cd_win, out );
#else
int main_setrev ( int argc, char **argv, ProgressScreen* screen )
{	
#endif
	SetProgressScreen ( screen );

	struct tm *pNewTime;
	time_t long_time;
	time( &long_time );
	pNewTime = localtime( &long_time );

	int iRunMode = 0;
	int iHaveTwoBase = 0;
	bool controlRevision = false;
	bool annoRevision = false;
        
	revision aDocSetRev;
	revision aSegSetRev;
	revision aControlSetRev;
	revision aAnnoSetRev;
	revision aReservedSetRev;
	memset ( &aDocSetRev, 0, sizeof ( revision ) );
	memset ( &aSegSetRev, 0, sizeof ( revision ) );
	memset ( &aControlSetRev, 0, sizeof ( revision ) );
	memset ( &aAnnoSetRev, 0, sizeof ( revision ) );
	memset ( &aReservedSetRev, 0, sizeof ( revision ) );

	char * pArgLogPath= 0;
	int iDocSet = 0;
	int iSegSet = 0;
	bool b_daily = false;
	for ( int i = 2; i < argc; i++ ) {
		if ( argv [i][0] == '-' ) 
			switch ( argv [i][1] ) {
			case 'f':
			case 'F':
				compareOnlyTexts = true;
				break;
			case 'c':
			case 'C':
				controlRevision = true;
				if ( argv [i][2] != ':' ) {
					logger.printf ( lt_fatal, "\nBad revision in option (%s)\n", argv[i] );
					exit ( EXIT_FAILURE );
				}
				if ( !StrRev ( &argv [i][3], aControlSetRev ) ) {
					logger.printf ( lt_fatal, "\nBad date's format \"%s\"\n", argv [i] );
					exit  ( EXIT_FAILURE );
				}
				break;
			case 'a':
			case 'A':
				annoRevision = true;
				if ( argv [i][2] != ':' ) {
					logger.printf ( lt_fatal, "\nBad revision in option (%s)\n", argv[i] );
					exit ( EXIT_FAILURE );
				}
				if ( !StrRev ( &argv [i][3], aAnnoSetRev ) ) {
					logger.printf ( lt_fatal, "\nBad date's format \"%s\"\n", argv [i] );
					exit  ( EXIT_FAILURE );
				}
				break;

			case 'r' :
				if ( iSegSet || iDocSet ) {
					logger.printf ( lt_fatal, "\nDouble setup revision (%s)\n", argv[i] );
					exit ( EXIT_FAILURE );
				}
				if ( argv [i][2] != ':' ) {
					logger.printf ( lt_fatal, "\nBad revision in option (%s)\n", argv[i] );
					exit ( EXIT_FAILURE );
				}
				if ( !StrRev ( &argv [i][3], aDocSetRev ) ) {
					logger.printf ( lt_fatal, "\nBad date's format \"%s\"\n", argv [i] );
					exit  ( EXIT_FAILURE );
				}
				aSegSetRev = aDocSetRev;
				iDocSet = iSegSet = 1;
				iRunMode = 1;
				break;
			case 's' :
				if ( iSegSet ) {
					logger.printf ( lt_fatal, "\nDouble setup revision (%s)\n", argv[i] );
					exit ( EXIT_FAILURE );
				}
				if ( argv [i][2] != ':' ) {
					logger.printf ( lt_fatal, "\nBad revision in option (%s)\n", argv[i] );
					exit ( EXIT_FAILURE );
				}
				if ( !StrRev ( &argv [i][3], aSegSetRev ) ) {
					logger.printf ( lt_fatal, "\nBad date's format \"%s\"\n", argv [i] );
					exit  ( EXIT_FAILURE );
				}
				iSegSet = 1;
				iRunMode = 1;
				break;
			case 'd' :
				if ( iDocSet ) {
					logger.printf ( lt_fatal, "\nDouble setup revision (%s)\n", argv[i] );
					exit ( EXIT_FAILURE );
				}
				if (!stricmp (argv [i]+1, "daily")) {
					b_daily = true;
				} else {
					if ( argv [i][2] != ':' ) {
						logger.printf ( lt_fatal, "\nBad revision in option (%s)\n", argv[i] );
						exit ( EXIT_FAILURE );
					}
					if ( !StrRev ( &argv [i][3], aDocSetRev ) ) {
						logger.printf ( lt_fatal, "\nBad date's format \"%s\"\n", argv [i] );
						exit  ( EXIT_FAILURE );
					}				
					iDocSet = 1;
					iRunMode = 1;
				}
				break;
			case 'l' :
				if ( argv [i][2] != ':' ) {
					logger.printf ( lt_fatal, "\nBad logger path in option (%s)\n", argv[i] );
					exit ( EXIT_FAILURE );
				}
				pArgLogPath = &argv[i][3];			

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
				else {
					logger.printf ( lt_fatal, "\nUnknown priority (%s)\n", &argv[i][3] );
					exit ( EXIT_FAILURE );
				}

				break;

			default :
				logger.printf ( lt_fatal, "\nUnknown option (%s)\n", argv[i] );
				exit ( EXIT_FAILURE );
			}
			else iHaveTwoBase++;
	}

	if ( iHaveTwoBase && iRunMode ) {
		logger.printf ( lt_fatal, "\nCan't use '-[rds]' option in multi base (comparison) mode\n" );
		exit ( EXIT_FAILURE );
	}

	if ( iHaveTwoBase > 1 || argc < 3 ) {		
		logger.printf ( lt_always, "Garant base reviser v%d. Version %s.\n", GREV_VERSION, GARANT_VERSION);
		logger.printf ( lt_always, "USAGE :\n%s <old base> <new base> [-c:<rev>] [-l:<path>] [-p:<logger prior>]\n", argv[0] );
		logger.printf ( lt_always, "\tfor revisions comparison between two bases or create Control index\n\n" );
		logger.printf ( lt_always, "\tor\n%s <new base> -[rds]:<rev> [-l:<path>] [-p:<logger prior>]\n", argv[0] );
		logger.printf ( lt_always, "\tfor setup revision for new base\n\n" );
		logger.printf ( lt_always, "\t'-l' : sets path to logger-file\n" );
		logger.printf ( lt_always, "\t'-P' : logger output priority, default INFO\n");
		logger.printf ( lt_always, "\t\tDEBUG   - full logger information\n");
		logger.printf ( lt_always, "\t\tINFO    - standart logger information\n");
		logger.printf ( lt_always, "\t\tWARNING - warning and error information\n");
		logger.printf ( lt_always, "\t\tERROR   - only error information\n");

		logger.printf ( lt_always, "\t'-d' : setup revision <rev> for documents only\n" );
		logger.printf ( lt_always, "\t'-s' : setup revision <rev> for segments only\n" );
		logger.printf ( lt_always, "\t'-r' : setup revision <rev> for both docs and segs\n" );
		logger.printf ( lt_always, "\t\t<rev> is \"DD/MM/YYYY[:HH:MM]\" date's string\n" );
		logger.printf ( lt_always, "\t\tor \"cur\" for setup current date and time\n" );
		logger.printf ( lt_always, "\nYou can use -s and -d options together to specify different setup revisions\n\n" );

		return 1;
	}
 
	Base* pOldBase = 0;
	Base* pNewBase = 0;
	BaseInfo aOldBaseInfo, aNewBaseInfo;

	if ( !iRunMode ) {		
		logger.printf ( lt_info, "Open New Base\n" );

		pNewBase = new StdBigBase ( argv[2], ACE_OS_O_RDWR );
		if ( !pNewBase || !pNewBase->IsOk () ) {
			logger.printf ( lt_fatal, "Can't ace_os_open (for read/write) new Base \"%s\"\n", argv[2] );
			exit ( EXIT_FAILURE );
		}
	
		if (!check_ready_status(TID_GREV_2, pNewBase, &logger)) {
			delete pNewBase;
			return EXIT_FAILURE;			
		}
	} else {
		logger.printf ( lt_info, "Open New Base\n" );
		pNewBase = new StdBigBase ( argv[1], ACE_OS_O_RDWR );
		if ( !pNewBase || !pNewBase->IsOk () ) {
			logger.printf ( lt_fatal, "Can't ace_os_open (for read/write) new Base \"%s\"\n", argv[1] );
			exit ( EXIT_FAILURE );
		}
		if (!check_ready_status(TID_GREV_1, pNewBase, &logger)) {
			delete pNewBase;
			return EXIT_FAILURE;			
		}
	}
	
	char pHereKey []	= "Here";
	Index * pAuxInd = pNewBase -> FindIndex ( "Aux" );
	Stream * pStr = pAuxInd -> Open ( pHereKey );			
	short * pPresentSegments = (short*) malloc ( pStr->Length() );
	short siPresentSegmentsCount = pStr->Length () / sizeof ( short );		
	assert ( pStr && pPresentSegments && siPresentSegmentsCount );
	pStr -> Read ( pPresentSegments, pStr->Length () );
	pAuxInd -> Close ( pStr );			
	int iSegId = pPresentSegments [0];
	free ( pPresentSegments );

	if ( pNewBase->FindBaseInfo ( iSegId, aNewBaseInfo ) != sizeof ( BaseInfo ) ) {
		logger.printf ( lt_fatal, "\nSelected segment (%d) does not exist in new base\n", iSegId );
		exit ( EXIT_FAILURE );
	}

	if ( !iRunMode ) {
		logger.printf ( lt_info, "Open Old Base\n" );
		pOldBase = new YBase ( argv [1], ACE_OS_O_RDONLY );

		if ( !pOldBase || !pOldBase->IsOk () ) {
			logger.printf ( lt_fatal, "Can't ace_os_open (for read only) old Base \"%s\"\n", argv[1] );
			exit ( EXIT_FAILURE );
		}
		if (!check_ready_status(TID_GREV_2, pNewBase, &logger)) {
			delete pNewBase;
			return EXIT_FAILURE;			
		}
        
		if ( pOldBase->FindBaseInfo ( iSegId, aOldBaseInfo ) != sizeof ( BaseInfo ) ) {
			logger.printf ( lt_fatal, "\nSelected segment (%d) does not exist in old base\n", iSegId );
			exit ( EXIT_FAILURE );
		}
				
		if ( CompRevs ( &aOldBaseInfo.LastUpdate, &aNewBaseInfo.LastUpdate ) >= 0 ) {
			char buf [256];
			logger.printf ( lt_fatal, "\nOld Base has the same or higher revision date\n" );
			logger.printf ( lt_fatal, "\tOld Base revision : %s\n", sprintRev ( buf, &aOldBaseInfo.LastUpdate ) );
			logger.printf ( lt_fatal, "\tNew Base revision : %s\n", sprintRev ( buf, &aNewBaseInfo.LastUpdate ) );			
			exit ( EXIT_FAILURE );
		}
		AttrIndex* oldIndex = (AttrIndex*) pOldBase->FindIndex( "Attribs" );
		if ( oldIndex->Root == -1 )
			compatMode = true;
	}

	char * pFullLogName = 0;
	char * pLogName = 0;

	if ( pArgLogPath ) {
		pFullLogName = (char*) malloc ( strlen ( pArgLogPath ) + 16 );
		assert ( pFullLogName );

		memcpy ( pFullLogName, pArgLogPath, strlen (pArgLogPath) );

		if ( pFullLogName [ strlen (pArgLogPath) - 1 ] != MPCXC_PATHBRK )
		{
			pFullLogName [ strlen (pArgLogPath) ] = MPCXC_PATHBRK;
			pLogName = pFullLogName + strlen ( pArgLogPath ) + 1;
		}
		else pLogName = pFullLogName + strlen ( pArgLogPath );
	} else {	
		pFullLogName = (char*) malloc ( 16 );
		assert ( pFullLogName );
		
		pLogName = pFullLogName;
	}
					
	revision aLogRevision = iRunMode?(iSegSet?aSegSetRev:aDocSetRev):aNewBaseInfo.LastUpdate;

	if (
		aLogRevision.RevisionDate.da_mon > 99 ||
		aLogRevision.RevisionDate.da_day > 99 ) 
	{
		logger.printf ( lt_fatal, "\nCan't create logger name\n" );
		exit ( EXIT_FAILURE );
	}

	sprintf ( pLogName, "MX%02d%02d%02d.rev",
		aLogRevision.RevisionDate.da_day,
		aLogRevision.RevisionDate.da_mon,
		aLogRevision.RevisionDate.da_year%100 );
		
	LogFile * logFile;
	try {
		logFile = new LogFile ( pFullLogName );		
		logger.GetPolicy()->AddLogDevice ( logFile );
	} catch (...) {
		logger.printf ( lt_error, "\nFile open failure (%s)\n", pFullLogName );
		logFile = 0;
	}

#if !defined(_NO_DOS_SCREEN) && !defined(_EXTERN_MAIN)
	logger.GetPolicy()->DelLogDevice ( &tracer );  // no std output
	logger.Devices(lt_fatal) = logger.Devices ();
	logger.Devices(lt_fatal).Add ( &tracer );      // only for fatal error
#endif   	
	{
		char pbuf[1024];
		sprintf ( pbuf,"Garant Base revision programm %s", GARANT_VERSION );
		screen->InitScreen( pbuf );
	}
    		
	logger.printf ( lt_info, "************************** BASE REVISION LOG FILE ***********************\n" );
	logger.printf ( lt_info, "\n\t Time \t\t: %s\n", asctime( pNewTime ) );
	if ( !iRunMode ) {
		char buf [256];
		logger.printf ( lt_info, "\t Runing in comparisons mode (two base)\n" );
		logger.printf ( lt_info, "\t Old Base \t: \"%s\"\n", argv[1] );
		logger.printf ( lt_info, "\t with revision : %s\n", sprintRev ( buf, &aOldBaseInfo.LastUpdate ) );
		logger.printf ( lt_info, "\t New Base \t: \"%s\"\n", argv[2] );
		logger.printf ( lt_info, "\t with revision : %s\n", sprintRev ( buf, &aNewBaseInfo.LastUpdate ) );
	} else {
		char buf [256];
		logger.printf ( lt_info, "\t Runing in setup mode (single base)\n" );
		logger.printf ( lt_info, "\t New Base \t: \"%s\"\n", argv[1] );
		logger.printf ( lt_info, "\t with revision : %s\n", sprintRev ( buf, &aNewBaseInfo.LastUpdate ) );
		logger.printf ( lt_info, "\t Setup revision : \n" );
		
		if ( iSegSet ) logger.printf ( lt_info, "\t\t for segments : %s\n", sprintRev ( buf, &aSegSetRev ) );
		else logger.printf ( lt_info, "\t\t for segments : none\n" );
		
		if ( iDocSet ) logger.printf ( lt_info, "\t\t for documents : %s\n", sprintRev ( buf, &aDocSetRev ) );
		else logger.printf ( lt_info, "\t\t for documents : none\n" );
	}
	logger.printf ( lt_info, "\n\n\n" );
		
    Reviser* RevSet;

    if ( !iRunMode ) {
		screen->SetMessage ( "Create Doc Iterators" );
		RevSet = new Reviser ( pOldBase, pNewBase, 0 );
		assert ( RevSet );
	} else {
		screen->SetMessage ( "Create Doc Iterator" );
		RevSet = new Reviser ( pNewBase, iDocSet ? &aDocSetRev:0, iSegSet ? &aSegSetRev:0 );
		assert ( RevSet );
	}
	
	int iRes = controlRevision ? RevSet->RunControlRevising( aControlSetRev, b_daily ) : 
			   ( annoRevision ? RevSet->RunAnnoRevising( aAnnoSetRev ) : RevSet->RunRevising () );

	delete RevSet;

    if ( pOldBase ) delete pOldBase;
	if (!iRes) {
		if(iRunMode) pNewBase->SetReady(TID_GREV_1);
		else pNewBase->SetReady(TID_GREV_2);
	}
	
	if ( pNewBase ) delete pNewBase;	
	if ( pFullLogName ) free ( pFullLogName );
	
	screen->SetMessage ( "REVISING COMPLITED!" );
	screen->CloseScreen();
#ifndef _EXTERN_MAIN
	delete screen;
#endif

	logger.printf ( lt_info, "\n\n*************************** END OF LOG ************************\n\n\n\n" );	
	if ( logFile ) delete logFile;
	return 0;
}









