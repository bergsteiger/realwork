#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: gutils.cpp,v 1.8 2010/10/04 06:42:53 yaroslav Exp $
 */

#include "stdbase.h"
#include "dociter.h"
#include "Logger.h"
#include "stringz.h"

#ifndef _EXTERN_MAIN
	code_t out = mpcxc_cd_cursys();
	LogScreen tracer;
	Logger log;
#else
	extern Logger log;
#endif


int RenameDoc ( Base* base, long oldid, long newid )
{
	if ( !base->RenameDoc ( oldid, newid ) ) {
		log.printf ( lt_error, "Can't rename %ld to %ld\n", oldid, newid );
		return 0;
	}
	return 1;
}

int CalcClassPerDoc ( Base* base )
{	
	log.printf ( lt_always, "Идет подсчет классов в базе...\n" );

	DocIterator docIter ( base );

	unsigned long totClass = 0;

	while ( !docIter.End () ) {
		long docId = docIter.Id ();
		++ docIter;
		
		if ( docId <= ID_BORDER) continue;
		
		long size;
		char * pAttr = (char*) base -> docInd -> Load ( docId, IDD_DIV, size );
		if ( size == -1 || !size || !pAttr ) continue;

		StringZ strZ ( pAttr, size, 0 );
		strZ.EnableHide();

		totClass += strZ.GetCount ();
		
		if ( pAttr ) free ( pAttr );
	}

	log.printf ( lt_always, "Всего найдено классов: %ld\n", totClass );
	return 0;
}

void printHelp ()
{
	log.printf ( lt_always, "  USAGE : gutils [-ah] base\n\n" );
	log.printf ( lt_always, "       a:<action>  select actions\n" );
	log.printf ( lt_always, "                   1 - class counting (default)\n" );
	log.printf ( lt_always, "                   2 - rename doc 1 to 3\n" );
	log.printf ( lt_always, "       h           to display this help\n" );
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
	log.Init ( &tracer, cd_win, out );
#else
int main_gutils ( int argc, char** argv )
{
#endif
	int i;
	int action = 0;
	int openmode = ACE_OS_O_RDONLY;
	char* base_name = 0;
	for ( i = 1; i < argc; i++ ) {
		if ( argv[i][0] == '-' ) switch ( argv[i][1] ) {
		case 'a':  // select action
			if ( argv[i][2] != ':' ) {
				log.printf ( lt_fatal, "\nUnknown parametr (%s)\n", argv[i] );
				printHelp ();
			}
			if ( action ) {
				log.printf ( lt_fatal, "\nDouble '-a' options\n" );
				printHelp ();
			}
			action = atol ( &argv[i][3] );
			if ( !action ) {
				log.printf ( lt_fatal, "\nBad actions argument (%s)\n", argv[i]+3 );
				printHelp ();
			}
			break;

		default :
			log.printf ( lt_fatal, "\nUnknown options (%s)\n", argv [i] );
			printHelp ();
		} else {
			if ( base_name ) {
				log.printf ( lt_fatal, "\nOnly one base must be specified\n" );
				printHelp ();
			}
			base_name = argv[i];
		}
	}
	if ( !base_name ) printHelp ();
	
	if ( action == 2 ) openmode = ACE_OS_O_RDWR;
	
	Base* base = new YBase ( base_name, openmode );
	if ( !base->IsOk () ) {
		log.printf( lt_fatal, "\nCan't open Base (%s): %s\n", base_name, base->strBaseStatus () );
		exit ( EXIT_FAILURE );
	}

	switch ( action ) {
	case 0 :
	case 1 :
		CalcClassPerDoc ( base );
		break;
	case 2 :
		RenameDoc ( base, 1, 3 );
		break;

	default :
		log.printf ( lt_fatal, "\nUnknown action (%d)\n", action );
	}

	delete base;

	return 0;
}




