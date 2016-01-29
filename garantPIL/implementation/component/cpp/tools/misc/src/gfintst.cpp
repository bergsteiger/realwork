#include "shared/Core/fix/mpcxc.h"
/*
 * $Id
 */

#include <cstring>

#include "base.h"
#include "stdbase.h"
#include "garutils.h"
#include "gardefs.h"
#include "dociter.h"
#include "basemask.h"
#include "collect.h"

#include "garver.h"

static int check_ready_status(Base *, const char *name);

int main ( int argc, char** argv )
{
	printf( "GARANT Bases tester for final delta v%s (%s %s)\n\n", GARANT_VERSION, __DATE__, __TIME__);

	if ( argc < 4 ) {
		printf ( "\tUSAGE\t: %s <old base> <week base> <new base> [log file]\n", argv[0] );
		exit (EXIT_FAILURE);
	}

	Base * pOldBase = new YBase ( argv [1], ACE_OS_O_RDONLY );
	Base * pWeekBase = new YBase ( argv [2], ACE_OS_O_RDONLY );
	Base * pNewBase = new StdBigBase ( argv [3], ACE_OS_O_RDWR );

	if ( !pOldBase || !pOldBase->IsOk () ) {
		printf ( "\nCan't open selected old Base (%s)\n", argv [1] );
		exit ( EXIT_FAILURE );
	}
	if(!check_ready_status(pOldBase, argv[1]))
		return EXIT_FAILURE;
		
	if ( !pWeekBase || !pWeekBase->IsOk () ) {
		printf ( "\nCan't open selected weekly Base (%s)\n", argv [2] );
		exit ( EXIT_FAILURE );
	}
	if(!check_ready_status(pWeekBase, argv[2]))
		return EXIT_FAILURE;
		
	if ( !pNewBase || !pNewBase->IsOk () ) {
		printf ( "\nCan't open selected new Base (%s)\n", argv [3] );
		exit ( EXIT_FAILURE );
	}
	if(!check_ready_status(pNewBase, argv[3]))
		return EXIT_FAILURE;

	FILE* pfErrFile = 0;
	if ( argc == 5 ) pfErrFile = mpcxc_fopen ( argv[4], "w+t" );
	else pfErrFile = mpcxc_fopen ( "gfintst.log", "w+t" );
	if ( !pfErrFile ) {
		printf ( "Can't create log file" );
		exit ( EXIT_FAILURE );
	} else {
		fprintf ( pfErrFile, "TESTING FOR FINAL DELTA CREATION BASE'S COMPATOBILITY\n" );
		fprintf ( pfErrFile, "OLD BASE   : %s\n", argv[1] );
		fprintf ( pfErrFile, "WEEKLY BASE: %s\n", argv[2] );
		fprintf ( pfErrFile, "NEW BASE   : %s\n", argv[3] );
	}
	
	DocCollection * docsOld = pOldBase->AllTopics ( 100000 );
	DocCollection * docsWeek = pWeekBase->AllTopics ( 100000 );
	DocCollection * docsNew = pNewBase->AllTopics ( 100000 ); 
		
	docsOld->Intersect(*docsWeek);
	int hasErr = 0;
	if ( docsOld->ItemCount ) {
		hasErr = 1;
		fprintf ( pfErrFile, "ERROR! Weekly base contains %ld docs from Old base:\n", 
			docsOld->ItemCount );
		for ( ColIterator it (docsOld); !it.End(); ++it )
			fprintf ( pfErrFile, "\t%ld\n", *((long*)it.Key()) );
	}
		
	docsNew->Intersect(*docsWeek);
	docsWeek->Minus(*docsNew);
	if ( docsWeek->ItemCount ) {
		hasErr = 1;
		fprintf ( pfErrFile, "ERROR! New base missing %ld docs from Weekly base:\n", 
			docsWeek->ItemCount );
		for ( ColIterator it (docsWeek); !it.End(); ++it )
			fprintf ( pfErrFile, "\t%ld\n", *((long*)it.Key()) );
	}
	
	fclose ( pfErrFile );
	
	if ( hasErr ) {
		printf ( "Testing bases has some errors. Final delta can't be created." );
		fprintf ( pfErrFile, "Testing bases has some errors. Final delta can't be created." );
	} else {		
		pNewBase->SetReady(TID_GFINTST);
		fprintf ( pfErrFile, "TESTING COMPLITED\n" );
		printf ( "TESTING COMPLITED\n" );
	}
		
	delete docsOld;
	delete docsNew;
	delete docsWeek;
	delete pOldBase;
	delete pWeekBase;
	delete pNewBase;
	if ( hasErr ) exit (EXIT_FAILURE);
}

static int check_ready_status(Base *pBase, const char *name)
{
	char *s, *missing;
	int16_t x, y;
	u_int32_t status;

	if ((status = pBase->CheckReady(TID_GFINTST))) {
		s = missing = GetProcessDescription(status, x, y);
		if (!missing) {
			printf("Base %s has invalid ready status.\n", name);
			return 0;
		}
		printf("Base %s is not ready for final testing.\n", name);
		printf("At least the following programs must be applied to base %s:\n", name);
		do {
			printf("\t%s\n", s);
			s += strlen(s) + 1;
		} while (*s);
		free(missing);
		return 0;
	}
	return 1;
}




