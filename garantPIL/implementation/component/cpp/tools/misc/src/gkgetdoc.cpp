
#include "shared/Core/fix/mpcxc.h"

#include <cstdarg>
#include <cstdio>
#include <cstdlib>
#include <cctype>
#include "stdbase.h"
#include "garver.h"
#include "basemask.h"
#include <ctime>

YBase		*base;
Document	*doc;

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
#ifndef _DEBUG
	{
		VER_PARAM verParam;
		int	i;

		verParam.exeId= TID_GKGETDOC;			// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i == VC_ADD_OK){
			}else{
			}
			exit(0);
		}
	}
#endif

	if( argc < 3 ){
		fprintf(stderr, "GARANT Base doc retrival v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
#ifdef	VERSION56
		fprintf(stderr,"Usage: %s <base> <DocId> <1>\n", argv[0] );
#else
		fprintf(stderr,"Usage: %s <base> <DocId>\n", argv[0] );
#endif
		return 1;
	}
	base = new YBase( argv[1], ACE_OS_O_RDONLY );
	if( !base || !base->IsOk() ){
		fprintf(stderr, "Can't check base.\n");
		return 1;
	}
	unsigned Id = atoi(argv[2]);

	if (!Id) {
		DocCollection* alldocs = base->AllTopics (ID_BORDER);
		/*long found = 5423330, from = alldocs->IndexOf (&found);
		if (from == -1) from++;*/
		for (long i = 0; i < alldocs->ItemCount; i++) {
			Id = (*alldocs) [i];
			doc = base->GetDoc (Id);
			if ((doc->Stat.Status & DS_EVD) && !(doc->Stat.Status & DS_EDITION)) {
				long aSize, *aIDs = (long*) base->LoadAttrEx (Id, IDD2_PARAIDS, aSize);
				if (!aSize)
					continue;
				for (long para = 0; para < doc->Stat.ParaCount; para++) {
					if (aIDs [para] & 0x40000000) {
						char* spara = doc->GetPara (para);
						if (doc->EVDFlags (spara) & ENDT_VERSION_COMMENTS)
							;//printf ("%ld | version comment %s\n", Id, doc->EVDParaText (spara));
						else
							printf ("%ld | %s\n", Id, doc->EVDParaText (spara));
					}
				}
				gk_free (aIDs);
			}
			delete doc;
		}
		delete alldocs;
		delete base;
		exit (EXIT_SUCCESS);
	}

	printf("Searching for doc %d\n", Id);
	doc = base -> GetDoc ( Id );

#ifdef	VERSION56
	unsigned int aDumpID = argc > 3 && !strcmp( argv[ 3 ], "1" );
	long *aIDs = 0;
	long aSize;

	if ( aDumpID ) {
#ifdef	VERSION61
		aIDs = (long*) base->LoadAttrEx( Id, IDD2_PARAIDS, aSize );
#else
		aIDs = (long*) base->docInd->Load( Id, IDD_PARAIDS, aSize );
#endif
		aSize /= sizeof( long );
	}
#endif

	if( doc && doc->IsOk () ){
		fprintf(stderr, "Processing doc %d\n", Id ); 
		for ( int j = 0; j < doc -> Stat.ParaCount; j++ ) {
			char  * ptr  = doc -> GetPara ( j );

#ifdef	VERSION56
			unsigned len = doc->EVDTextSize( ptr );
			const char *src = doc->EVDParaText ( ptr );
			char *ptr2 = (char*) src;
			for (int i = 0; i < len; i++)
				if (ptr2 [i] == 10)
					ptr2 [i] = '|';
			long flags = doc->EVDFlags (ptr);
			if ( aDumpID && aIDs && j < aSize ) {
				char strID[ 16 ];
				if ( aIDs[ j ] & 0x40000000 ) {
					sprintf( strID, "%12ld | ", aIDs[ j ] & 0x3FFFFFFF );
					for ( unsigned int q = 0; q < strlen( strID ); q++ )
						if ( isdigit( strID[ q ] ) && q ) {
							strID[ q - 1 ] = '!';
							break;
						}
				}
				else
					sprintf( strID, "%12ld | ", aIDs[ j ] );
				fwrite( strID,strlen(strID),1,stdout );
				sprintf( strID, "%ld | ", flags);
				fwrite( strID,strlen(strID),1,stdout );
			}
#else
			unsigned len = TextSize( ptr );
			const char *src = ParaText ( ptr );
#endif
			fwrite(src, len, 1, stdout );
			fputc('\n', stdout);
		}
		delete doc;
	}else{
		fprintf(stderr, "Can't find doc %d\n", Id );
	}

	if ( aIDs )
		gk_free( aIDs );

	delete base;
	return 0;
}
