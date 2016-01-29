#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include <sys/types.h>

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "common/components/rtl/Garant/EVD/eeReader.h"
#include "garantPIL/implementation/component/cpp/libs/endt/EndtReader.h"
#include "garantPIL/implementation/component/cpp/libs/endt/EndtParser.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	if ( argc < 2 )
		return 0;

	StdBigBase* aBase = new StdBigBase( argv[ 1 ], ACE_OS_O_RDWR );

	DocCollection* allTopics = aBase->AllTopics(ID_BORDER);
	for ( long i = 0; i < allTopics->ItemCount; i++ ) {
		long docId = (*allTopics)[i];
		printf( "%ld\r", docId );
		Document* doc = aBase->GetDoc( docId );
		if ( doc && doc->IsOk() && doc->Stat.Status & DS_EVD ) {
			EVDParaInfo* paraflags = 0;
			long paracount = 0;
			for ( long para = 0; para < doc->Stat.ParaCount; para++ ) {
				char* cpara = doc->GetPara( para );
				long flags = doc->EVDFlags (cpara), size = doc->EVDTextSize (cpara), formulas = 0;

				if (flags & (ENDT_HAS_BMP | ENDT_SBS)) {
					paraflags = (EVDParaInfo*) realloc( paraflags, sizeof( EVDParaInfo ) * ( paracount + 1 ));
					paraflags[paracount].flags = flags;
					paraflags[paracount].para = para;
					paracount++;
				}
			}
			if ( paraflags ) {
				aBase->ReplaceAttr( docId, IDD_PARAFLAGS, paraflags, paracount * sizeof( EVDParaInfo ));
				free( paraflags );
			}
		}
		if ( doc ) delete doc;
	}
	printf( "\n" );
	
	delete aBase;

	return 0;
}

int MemoryError ( )
{
	printf ( "Memory error" );
	exit (EXIT_FAILURE);
	return 0;
}

void cdecl OkBox ( char *s1, char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}

void cdecl OkBox ( const char *s1, const char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}




