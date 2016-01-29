#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include "gsscreen.h"
#include "gl.h"
#include "stdbase.h"
#include "basemask.h"

#include "glt_ver.h"
#include "garver.h"
#include "zlib.h"

#include "SearchB.h"
#include "shared/Core/sys/AutoInit.h"

int iMakeAllDocs= 0;
int iMakeAllDocsParaMax= 50000;
long iMakeAllDocsSizeMax= 0x7fffffff;

#ifdef	BANK
extern	void	gl_SetLicence( PagedFile*, int, int, int );
#endif

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (1);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	int res;
	if(1){	// если не хотим отлаживать много-поточную работу,
			// то надо изменить на невыполнение условия и размер стека указать в проекте вижуальника
			//
		res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	}else
		res = main_logic( argc, argv );

	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
		VER_PARAM verParam;
		int	i;

		verParam.exeId= TID_GL;			// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i == VC_ADD_OK){
			}else{
			}
	#ifdef _DEBUG
			printf("\n *** GL Debug Version. For test, only... ***\n\n");
	#else
			exit(0);
	#endif
		}
	}

	int options = 0;
	int baseType = 0;
	int bCheckInfo = 1;
	int bBreeder = 0;
	int bWWW = 0;
	bool bClass6 = false, bSkipClass6 = false, b_cache_fat = true, b_only_class6 = false;
	FILE *log_file = 0;
	
	if ( argc < 2 ) {
		printf ( "GARANT Base main menu builder v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
		printf ( "Usage: %s [-r/-e] [-n] [-a[:XX[,YY]]] <base> [<debug_file>]\n", argv[0] );
		return 1;
	}

	for ( short aArg = 1; aArg < 5; aArg++ )
		if ( argc > aArg && argv[aArg][0] == '-') {
			options ++;
			switch (argv[aArg][1]) {
				case 'c':
					if (!stricmp (argv [aArg], "-class6"))
						bClass6 = true;
					break;
				case 'o':
					if (!stricmp (argv [aArg], "-onlyclass6")) {
						bClass6 = true;
						b_only_class6 = true;
					}
					break;
				case 'r':
					baseType = 0;
					break;	
				case 'e':
					baseType = 1;
					break;
				case 'n':
					if (!stricmp (argv [aArg], "-noclass6"))
						bSkipClass6 = true;
					else if (!strcmp (argv [aArg], "-nofat"))
						b_cache_fat = false;
					else
						bCheckInfo = 0;
					break;	
				case 'b':
					bBreeder = 1;
					break;
				case 'a':
					iMakeAllDocs++;
					if(strchr(argv[aArg], ':') != 0){
						iMakeAllDocsParaMax= atoi(strchr(argv[aArg], ':')+1) * 1000;
						if(strchr(argv[aArg], ',') != 0){
							iMakeAllDocsSizeMax= atoi(strchr(argv[aArg], ',')+1) * 1024 * 1024;
						}
					}
					break;	
				case 'w':
					bWWW = 1;
					break;	
				default:
					printf("Unknown option: %s\n", argv[1]);
					return 0;
			}
		}

	if( argv[2 + options] ){
		log_file = mpcxc_fopen(argv[2+options], "w");
		if (!log_file) {
			printf("Error creation log.\n");
			exit(-1);
		}
	} else {
		log_file = stdout;
	}

	char * base_path = argv [1 + options];
	if (base_path[0] == '/' && base_path[1] == '/' && base_path[3] == '/') {
		base_path++;
		base_path[0] = base_path[1];
		base_path[1] = ':';
	}

	Core::AutoInit init;

	DBCore::RelevancyTuneData obj;

	if (!b_only_class6) {
		SearchBase* base = new SearchBase (base_path);
		if (base->YBase::IsOk ()) { // чтобы прогрузились фаты
			base->load_relevancy_changes (obj);
		}
		delete base;
	}

	Base *b = b_cache_fat ? new GLBase (base_path) : new StdBigBase (base_path, ACE_OS_O_RDWR);
	if (!b->IsOk()) {
		printf("Base state error: %s\n", b->strBaseStatus());
		return 1;
	}

	if (b->IsPacked()) {
		printf("Base state error: the base was packed\n");
		delete b;
		return 1;
	}

	long lNeed = b->CheckReady(TID_GL);
	if (lNeed == -1) {
		printf("No data mask found.\n");
		delete b;
		return 1;
	} else if (lNeed) {
		short sSize, sProcCount;
		char *pNeedPs = GetProcessDescription(lNeed, sProcCount, sSize);
		if (!pNeedPs) {
			printf("Data mask fatal error.\n");
		} else {
			char *pCurrPs = pNeedPs;
			printf("Lack of %d processes.\n", sProcCount);
			while (sProcCount--) {
				printf("To run: '%s'.\n", pCurrPs);
				pCurrPs += strlen(pCurrPs)+1;
			}
			free(pNeedPs);
		}
	}
	GSScreen screen(cd_koi, cd_win);
	if (b->FindIndex("Class6")->KeyCount == 0 && !bSkipClass6)
		bClass6 = true;

	garlink (b, &screen, baseType, bCheckInfo, bBreeder, bWWW, bClass6, log_file, &obj, b_only_class6);

	fprintf(log_file, "0\n");
	if (log_file != stdout) fclose(log_file);
#ifdef	BANK
	gl_SetLicence( b->textFile, 1000, 1000, 100 );
#endif

	b->SetReady(TID_GL);	

	char gl_info [2048];
	sprintf (gl_info, "Отработал gl от %s : %s, cmd_line: \"gl", __DATE__, __TIME__);
	for (int i = 1; i < argc; i++) {
		strcat (gl_info, " ");
		strcat (gl_info, argv [i]);
	}
	strcat (gl_info, "\"\nСегментный состав комплекта:");
	Stream* str = b->FindIndex ("Aux")->Open ("Here");
	if (str) {
		for (int i = 0; i < str->Length () / 2; i++) {
			short seg; str->Read (&seg, sizeof (seg));
			char sseg [16];
			sprintf (sseg, " %ld", seg);
			strcat (gl_info, sseg);
		}
		b->FindIndex ("Aux")->Close (str);
	}
	str = b->FindIndex ("Aux")->Open (AUX_INFO, 1);
	if (str) {
		str->Seek (str->Length ());
		str->Write (gl_info, strlen (gl_info) + 1);
		strcpy (gl_info, "------------------------------------------------------------");
		str->Write (gl_info, strlen (gl_info) + 1);
		b->FindIndex ("Aux")->Close (str);
	}

	delete b;

	return 0;
}
