#include "shared/Core/fix/mpcxc.h"
#include "ace/Thread_Manager.h"

#include <cstdio>
#include <cstring>
#include <cstdlib>

#include "osdep.h"
#include "garver.h"
#include "pagefile.h"
#include "stdbase.h"

#include <sys/stat.h>

//#define STANDALONE

#ifdef STANDALONE               // standalone project
        FILE *logCurr;
        #define NOHDR()         {}
        #define MESSAGE(x)      {fprintf(logCurr,x);fprintf(logCurr,"\n");}
        #define MESSAGE2(x,y)   {fprintf(logCurr,x,y);fprintf(logCurr,"\n");}
        #define WARNING(x)      fprintf(stderr,x)
        #define SETLOG(x)       {if(x)logCurr=mpcxc_fopen(x,"wt");else logCurr=stdout;}
        #define PERCENT1(x,y,z) fprintf(stderr,msg_Packing,x,y,z)
        #define PERCENT2(x,y)   fprintf(stderr,msg_Packing1,x,y)
        #define PERCENT3(x)     fprintf(stderr,msg_unPack,x)
        #define PERCENT4()      fprintf(stderr,msg_unPack1)
        #define SHOWMESS(x)     {}
        #define CLOSELOG()      {}
#else                           // call from breeder

        #include "toys.h"
		FILE *logCurr;

        #define NOHDR()         {}
        #define MESSAGE(x)      {if(logCurr){fprintf(logCurr,x);fprintf(logCurr,"\n");}}
        #define MESSAGE2(x,y)   {if(logCurr){fprintf(logCurr,x,y);fprintf(logCurr,"\n");}}
        #define WARNING(x)      {/*if(logCurr){fprintf(logCurr,x);fprintf(logCurr,"\n");}*/}
        #define SETLOG(x)       {if(x)logCurr=mpcxc_fopen(x,"wt");}
        #define PERCENT1(x,y,z) UpgrPerc(x)
        #define PERCENT2(x,y)   UpgrPerc(100)
        #define PERCENT3(x)     UpgrPerc(x)
        #define PERCENT4()      UpgrPerc(100)
        #define SHOWMESS(x)     ShowMess(x,0)
        #define CLOSELOG()      {if(logCurr){fclose(logCurr);}}
        #define farcoreleft()   (0)
#endif

/////////////////////////////////////////////////////////////////////
#ifdef STANDALONE
static char*    msg_Packing  = "\rPacking... %d%% done. Ratio=%d%%. Estimated size=%d bytes        \r";
static char*    msg_Packing1 = "\rPacking... 100%% done. Ratio=%d%%. Result size=%d bytes        \n";
static char*    msg_unPack   = "\rExtracting... %d%% done\r";
static char*    msg_unPack1  = "\rExtracting... 100%% done\n";
#endif

static char*    msgWindowTitleP    = "Упаковка файлов системы ГАРАНТ";
static char*    msgWindowTitleU    = "Распаковка файлов системы ГАРАНТ";
static char*    msgPacking         = "Идет упаковка";
static char*    msgUnPacking       = "Идет распаковка";
static char*    msgSourceFileError = "Ошибка структуры файла %s.";
static char*    msgFileIsPacked    = "Файл %s упакован.\n";
static char*    msgFileIsUnpacked  = "Файл %s распакован.\n";
//char* msgCannotPack      = "Файл уже упакован. Упаковка невозможна.";
//char* msgCannotUnpack    = "Файл уже распакован. Распаковка невозможна.";
static char*    msgEmptyFile       = "Файл пуст.";
static char*    msgCannotRead      = "Ошибка чтения файла.";
static char*    msgErrorUnpacking  = "Ошибка распаковки файла.";
static char*    msgErrorPacking    = "Критическая ошибка упаковки.";
static char*    msgErrorWriting    = "Ошибка записи на диск.";

#include "packfile.h"

static int packPFile ( CompressedFile *of, PagedFile *nf )
{
	long step= of -> LastPage / 100 + 1, i=0;

	do{
		if(of->
#ifndef OLD_PACK_POS
				PackOldFile
#else
				PackFile
#endif
							(nf,step))
			return 1;
		++i;
#ifndef	STANDALONE
		UpgrPerc((short)i);
#endif
	}while(i*step < of -> LastPage);

	return 0;
}

#ifndef OLD_PACK_POS
static int packPBigFile ( CompressedFile *of, PagedFile *nf )
{
	long step= of -> LastPage / 100 + 1, i=0;

	do{
		if(of->PackBigFile(nf,step))
			return 1;
		++i;
#ifndef	STANDALONE
		UpgrPerc((short)i);
#endif
	}while(i*step < of -> LastPage);

	return 0;
}
#endif

static int unpackPFile ( PagedFile *of, PagedFile *nf )
{
        nf -> LastPage     = of -> LastPage;
        nf -> FreePage     = of -> FreePage;
        nf -> lastFreePage = of -> lastFreePage;
        nf -> AttrOffs     = of -> AttrOffs;

        memcpy ( nf -> SystemPageBuf, of -> SystemPageBuf, of -> PageSize );

		if(((PagedFileHeader*)nf->SystemPageBuf)->TomPerPages)
			nf->m_max_paged_file_per_bytes
				= ((PagedFileHeader*)nf->SystemPageBuf)->TomPerPages
					* nf->PageSize;
		else
			nf->m_max_paged_file_per_bytes = MAX_BYTE_FILE_SIZE;

		nf->m_mode ^= ACE_OS_O_CREAT;

		if(nf -> GetAttr ( ID_PACKED, 0, 0 ))
			nf -> DelAttr ( ID_PACKED );
		else
			nf -> DelAttr ( ID_PACKED_NEW );

        if ( of -> LastPage == 0 )
                { NOHDR(); MESSAGE(msgEmptyFile); return 1; }

        if ( of -> FreePage != -1 || of -> lastFreePage != -1 )
                WARNING("\nWarning: file contains free pages");

        u_int32_t nPackPages = of -> LastPage;
        u_int16_t pageSize   = of -> PageSize;

        int pc = -1;
		char *pbuf= (char*)malloc(of -> PageSize);
		if(pbuf == 0)
			{ NOHDR(); MESSAGE(msgCannotRead); return 1; }

        for ( u_int32_t i = 1; i <= nPackPages; i++ )
        {
                int percent = i * 100 / nPackPages;
                if ( pc != percent )
                        PERCENT3(percent);
                pc = percent;

				if(!of -> GetPage(i, pbuf))
					{ NOHDR(); MESSAGE(msgCannotRead); return 1; }

				if(!nf -> PutPage ( i, pbuf ))
					{ NOHDR();
				MESSAGE(msgErrorWriting); return 1; }
        }
        free ( pbuf );

        PERCENT4();
        return 0;
}

static int usage ( char *path )
{
        printf( "Usage: %s [option] <in_file> [out_file]\n", path );
        printf( "Options: -a pack file.\n" );
        printf( "         -x unpack file.\n" );
        printf( "         -h to get this help.\n" );
        printf( "         -e for English interface.\n");
        printf( "         -r <res_file> write result log to res_file.\n" );
        printf( "         no option gives packed status.\n" );
        return 1;
}

////////////////
static char *logname;

#define STATUS  0x0
#define PACK    0x1
#define UNPACK  0x2
#define HELP    0x4
#define	PACKNDT 0x8

#include <basemask.h>

long	FileSize ( char * name )
{
	int	fd  = ace_os_open( name, ACE_OS_O_RDONLY | ACE_OS_O_BINARY );

	if ( fd != -1 ) {
		long len = ace_os_filesize ( fd );
		ace_os_close ( fd );
		return len;
	}
	else {
		return 0;
	}
}

extern "C" long DefValCryptoTag;
extern "C" char *GetBasedExtFileName( char *, int);

#include "dociter.h"
#include "newdoc.h"
#include "../../libs/delta/src/tempdoc.h"
#include "Logger.h"
Logger logger;
extern "C" long lDefNdtCryptoTag;

#include "shared/Core/sys/start_stop.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	Core::init ();
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	Core::fini ();
	return res;
}

volatile	long	bad = 0;
volatile	long	pack_count = 0;
volatile	long	max_pack_count = 1;
volatile	long	packed_count = 0;

bool	b_skip_turbo = false;
bool	b_only_turbo = false;

void	pack_file (const char* file_name) {
	while (pack_count == max_pack_count)
		ACE_OS::sleep (1);

#ifndef	unix
	InterlockedIncrement(&pack_count);
#endif
	CompressedFile *of = new CompressedFile(file_name);

	of->m_pCryptoTag= (char*)&DefValCryptoTag;
	int MaxTomSrc= -1;
	long curr_page= of->m_readed.page;
	of->m_readed.page= of->LastPage;
	MaxTomSrc= IsNextTom( &of->m_readed );
	of->m_readed.page= curr_page;
#ifndef OLD_PACK_POS
	u_int32_t sizePF= of->GetFileSizeInKbytes();
	if(sizePF > (0x7fffffff/1024)){
		if(packPBigFile(of,of))
#ifdef	unix
			bad++;
#else
			InterlockedIncrement (&bad);
#endif
	}else
#endif
	if(packPFile(of,of))
#ifdef	unix
		bad++;
#else
		InterlockedIncrement (&bad);
#endif
	delete of;
	if(MaxTomSrc > 0) {
		int MaxTomTrgt= 0;
		PagedFile *nf = new PagedFile ( file_name, ACE_OS_O_RDONLY );
		if(nf->m_mode & 0x1000)
			nf->m_readed.page= (long)(( ((((ACE_UINT64)0xffffffff) << 8)|(ACE_UINT64)0xff) & *(ACE_UINT64*)(5 * (nf->LastPage) + (char*)nf->pageOffs)) / (ACE_UINT64)nf->PageSize);
		else
			nf->m_readed.page= nf->pageOffs[nf->LastPage] / nf->PageSize;
		MaxTomTrgt= IsNextTom( &nf->m_readed ) + 1;

		char Ext[4];memcpy(Ext, strrchr(nf->FileName, '.'), 4);
		while(MaxTomTrgt <= MaxTomSrc){
			GetBasedExtFileName(nf->FileName, MaxTomTrgt);
			ace_os_unlink(nf->FileName);
			MaxTomTrgt++;
			memcpy(strrchr(nf->FileName, '.'), Ext, 4);
		}
		delete nf;
	}

#ifdef	unix
	packed_count++;
#else
	InterlockedDecrement(&pack_count);
	InterlockedIncrement(&packed_count);
#endif
}

int main_logic ( int argc, char *argv[] )
{        
	int res, task = STATUS, i;

	VER_PARAM verParam;

	verParam.exeId= TID_GPACK;				// defines BASEMASK.H
	verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
	verParam.stdOut= stdout;
	verParam.pDate= __DATE__;
	verParam.pTime= __TIME__;

	if((i=_imp_GVersion(&argc, argv, &verParam))){
		if(i == VC_ADD_OK){
		}else{
		}
#ifdef _DEBUG
		printf("\n *** GPACK Debug Version. For test, only... ***\n\n");
#else
		exit(0);
#endif
	}

	if (argc < 2) return usage(argv[0]);

	for ( i = 1; i < argc; i++ ) {
		if ( argv [i] && ( !strcmpi ( argv [i], "-r" ) ) ) {
			logname = argv [i + 1];
			i++;
        }
        else
		if ( argv [i] && argv[i][0] == '-' && atol (argv[i]+1))
			max_pack_count = atol (argv[i]+1);
		else
		if ( argv [i] && ( !strcmpi ( argv [i], "-a" ) ) )
			task |= PACK;
        else
		if ( argv [i] && !strcmpi (argv [i], "-skipturbo"))
			b_skip_turbo = true;
		else
		if ( argv [i] && !strcmpi (argv [i], "-onlyturbo"))
			b_only_turbo = true;
		else
		if ( argv [i] && ( !strcmpi ( argv [i], "-x" ) ) )
			task |= UNPACK;
        else if ( argv [i] && ( !strcmpi ( argv [i], "-n" ) ) )
                task |= PACK | PACKNDT;
		else if ( argv [i] && ( !strcmpi ( argv [i], "-e" ) ) ) {
                msgWindowTitleP    = "Packing files of GARANT system";
                msgWindowTitleU    = "Unpacking files of GARANT system";
                msgPacking         = "Packing";
                msgUnPacking       = "Unpacking";
                msgSourceFileError = "Source file is not OK.";
                msgFileIsPacked    = "File %s in packed.";
                msgFileIsUnpacked  = "File %s in unpacked.";
//                      msgCannotPack      = "File is already packed. Cannot pack.";
//                      msgCannotUnpack    = "File in already unpacked. Cannot unpack.";
                msgEmptyFile       = "File in empty.";
                msgCannotRead      = "Cannot read file.";
                msgErrorUnpacking  = "Error unpacking file.";
                msgErrorPacking    = "Critical packing error.";
                msgErrorWriting    = "Disk write error.";
        }
        else
        if ( argv [i] && ( !strcmpi ( argv [i], "-h" ) ) )
			task |= HELP;
        else
			break;
	}
        
	SETLOG(logname);
        
	char * base_path1 = argv [i];
	if ((base_path1) && (task != HELP)) {
		if (base_path1[0] == '/' && base_path1[1] == '/' && base_path1[3] == '/') {
			base_path1++;
			base_path1[0] = base_path1[1];
			base_path1[1] = ':';
		}
	}
        
	char * base_path2 = argv [i+1];
	if ((base_path2) && (task != HELP)) {
		if (base_path2[0] == '/' && base_path2[1] == '/' && base_path2[3] == '/') {
			base_path2++;
			base_path2[0] = base_path2[1];
			base_path2[1] = ':';
		}
	}

#ifndef STANDALONE
	int mem = farcoreleft ( );
#endif

	CompressedFile *of;
	PagedFile *nf;
// unpack ////////////
	if ( strrchr(base_path1,'.') && !stricmp(strrchr(base_path1,'.'), ".ndt" ) && (task & PACK) ) {
		char exts[13][5] = { ".ndt", ".6tr", ".str", ".8tr", ".7tr", ".1ey", ".key", ".5ey", ".3ey", ".4tr", ".2ey", ".9tr", ".0ey" };
		std::set<std::string> turbo_exts;
		turbo_exts.insert (".6tr");
		turbo_exts.insert (".3ey");
		turbo_exts.insert (".4tr");
		turbo_exts.insert (".5ey");

#ifndef STANDALONE
		char screen_title[100];
		sprintf(screen_title,"%s.", msgWindowTitleP);
		garant_scr( 0, screen_title, tr_none );
#endif

		char *fnd , *tmpNameTextFile= 0;
		std::vector<std::string> pack_files;

	#ifdef	MULTI_INDEX_STREAM_FILE
		for ( int aFile = 1; aFile < 13; aFile++ ) {
	#else
		for ( int aFile = 1; aFile < 3; aFile++ ) {
	#endif
			fnd= strrchr( base_path1, '.' );
#if defined(WITH_DBL_THREAD) || defined(QUICK_NEW_DOC)
			if((task & PACKNDT)){
				*fnd= 0;
				Base *pI= new StdBigBase(base_path1, ACE_OS_O_RDONLY);
				if(pI->IsOk() && !IsLogicalTom(&pI->textFile->m_readed)) {
					Base *pO= new StdBigBase(base_path1, ACE_OS_O_RDWR);
					TempDoc *doc= 0;
					NewDocument* pNewDoc = 0;
					Document *pTmpDoc= 0;
					unsigned long allCount= 0;
					if(pO->IsOk()) {
						char	tmpNameTextFileExt[]= ".packed", *fnd0= strrchr(pO->textFile->FileName, '.');
						tmpNameTextFile= (char*)malloc(sizeof(pO->textFile->FileName) +sizeof(tmpNameTextFileExt));
						int len= fnd0 - pO->textFile->FileName;

						////////////////////////
						memcpy(tmpNameTextFile, pO->textFile->FileName, len);
						strcat(strcpy(tmpNameTextFile + len, tmpNameTextFileExt), fnd0);
						fnd0= (char*)alloca(pO->textFile->PageSize);
						c_io_lseek( pO->textFile->GetFileHandle(), 0, ACE_OS_SEEK_SET);
						c_io_read(pO->textFile->GetFileHandle(), fnd0, pO->textFile->PageSize);
						c_io_close(pO->textFile->GetFileHandle());
						pO->textFile->Delete();
						pO->textFile->Connect(tmpNameTextFile, ACE_OS_O_RDWR);
						pO->textFile->Create(pI->textFile->PageSize);
						((PagedFileHeader*)fnd0)->LastPage = 0;
						((PagedFileHeader*)fnd0)->lastFreePage = -1;
						((PagedFileHeader*)fnd0)->FreePage = -1;
						c_io_write(pO->textFile->GetFileHandle(), fnd0, pI->textFile->PageSize);
						c_io_close(pO->textFile->GetFileHandle());
						pO->textFile->Delete();
						pO->textFile->Connect(tmpNameTextFile, ACE_OS_O_RDWR);
						memcpy(pO->textFile->m_readed.pHeader, fnd0, pO->textFile->PageSize);
						pO->textFile->m_pCryptoTag= (char*)&lDefNdtCryptoTag;
						pO->ClearAllTextInNextNewDocument();
						{
							DocIterator it(pI);
							while(!it.End()){
								allCount++;
								++it;
							}
							short shortP= 0;
							unsigned long curCount= 0;
							pO->currentBlockSize= ADD_BLOCK_SIZE;
							it.Rewind();
							DocInfo    Stat;
							Stream * s;
							while(!it.End()){
								s= pI->AttrKeyOpen( it.Key(), 0 );
								s->Read(&Stat, sizeof(Stat));
								pI->CloseAtrrStr(s);
								doc = new TempDoc ( pI, it.Id (), &pTmpDoc, &Stat );
								pNewDoc = new NewDocument ( pO, it.Id (), doc->GetStat().Title, (struct revision&)doc->GetStat().Revision, PM_ZIP);
								for ( int j = 0, zz0= 0, zz1= 0; j < doc->GetStat().ParaCount; j++ ) {
									fnd0= (char*)doc->GetPara(j);
									pNewDoc->AddPara( ParaStyle(fnd0), ParaSize(fnd0), fnd0 + 3);
								}
								if(pNewDoc->pInfo)
									free(pNewDoc->pInfo);
								pNewDoc->pInfo= 0;
								delete pNewDoc;
								delete doc;
								curCount++;
								if(shortP != ((curCount*100)/allCount)){
									shortP= (short)((curCount*100)/allCount);
								#ifndef	STANDALONE
									UpgrPerc(shortP);
								#endif
								}
								++it;
							}
							if(pTmpDoc)
								delete pTmpDoc;
						}
						delete pI;
						////////////////////////
						pO->flushShortBlocks();
						pO->strFile->PutAttr( ID_PACKED_NDT, (void*)"", 0 );
						delete pO;

						aFile= 0;
					}else{
						delete pI;
						delete pO;
					}
				} else {
					delete pI;
				}
				task &= ~PACKNDT;
			}
#endif
			strcpy( fnd, exts[ aFile ] );
			if (FileSize (base_path1) == 0)
				continue;

			if (b_skip_turbo && turbo_exts.find (exts [aFile]) != turbo_exts.end ())
				continue;

			if (b_only_turbo && turbo_exts.find (exts [aFile]) == turbo_exts.end ())
				continue;

			pack_files.push_back (base_path1);

			if ( bad )
				break;
		}
		if (pack_files.size () == 0)
			bad++;
		for (std::vector<std::string>::const_iterator pf = pack_files.begin (); pf != pack_files.end () && !bad; pf++) {
			const char* file_name = strdup (pf->c_str ());
			if (max_pack_count == 1) {
				pack_file (file_name);
			} else {
				ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
				inst->spawn ((ACE_THR_FUNC)pack_file, (void*) file_name, THR_DETACHED);
				ACE_OS::sleep (1);
			}
		}
		while (max_pack_count != 1 && packed_count != pack_files.size () && !bad)
			ACE_OS::sleep (1);
		MESSAGE( bad ? "1" : "0" );
		goto finish;
	}
	of = new CompressedFile( base_path1 );
	PagedFile *ztst = new CompressedFile( base_path2 );
	of->m_pCryptoTag= (char*)&DefValCryptoTag;
	if ( /*argc == 3 &&*/ (task & UNPACK) ){
#ifndef STANDALONE
        char screen_title[100];
        sprintf(screen_title,"%s.", msgWindowTitleU);
        garant_scr ( 0, screen_title, tr_none );
#endif
		if( !of || !of -> IsOk ( ) ) {
            MESSAGE2(msgSourceFileError,argv[i]);
            delete of;
            return 1;
		}
		if ( of -> GetAttr ( ID_PACKED, 0, 0 ) || of -> GetAttr ( ID_PACKED_NEW, 0, 0 ))
			nf = new PagedFile ( base_path2, ACE_OS_O_TRUNC | ACE_OS_O_RDWR | ACE_OS_O_CREAT);
		else{
			MESSAGE2(msgFileIsUnpacked,argv[i]);
			delete of;
			return 1;
		}
		nf -> Create ( of -> PageSize );
		if( !nf || !nf -> IsOk ( ) ){
			MESSAGE2(msgSourceFileError,argv[i+1]);
            return 1;
		}
		SHOWMESS(msgUnPacking);
		res = unpackPFile ( of, nf );
		if ( !res )
				MESSAGE("0");
		delete nf;
		delete of;
	}
////////// pack ///////////
	else if ( /*argc == 3 &&*/ (task & PACK) ){
#ifndef STANDALONE
        char screen_title[100];
        sprintf(screen_title,"%s.", msgWindowTitleP);
        garant_scr ( 0, screen_title, tr_none );
#endif
		if( of->PageSize == 512 || !of || !of -> IsOk ( )) {
			MESSAGE2(msgSourceFileError,argv[i]);
			delete of;
			return 1;
		}
		if ( of -> GetAttr ( ID_PACKED, 0, 0 ) ){
            MESSAGE2(msgFileIsPacked,argv [i]);
            delete of;
            return 1;
		}
		int MaxTomSrc= -1;
		if(base_path2 == 0 || strcmp(base_path1, base_path2) == 0){
			long curr_page= of->m_readed.page;
			of->m_readed.page= of->LastPage;
			MaxTomSrc= IsNextTom( &of->m_readed );
			of->m_readed.page= curr_page;
#ifndef OLD_PACK_POS
			u_int32_t sizePF= of->GetFileSizeInKbytes();
			if(sizePF > (0x7fffffff/1024)){
				if(!packPBigFile(of,of))
					MESSAGE("0");
			}else
#endif
			if(!packPFile(of,of))
				MESSAGE("0");
		}else{
			nf = new PagedFile ( base_path2, ACE_OS_O_RDWR | ACE_OS_O_CREAT );
			nf -> Create ( of -> PageSize );
			if( !nf || !nf -> IsOk ( ) ) {
				MESSAGE2(msgSourceFileError,argv[i+1]);
				return 1;
			}
			SHOWMESS(msgPacking);
#ifndef OLD_PACK_POS
			u_int32_t sizePF= of->GetFileSizeInKbytes();
			if(sizePF > (0x7fffffff/1024)){
				if(!packPBigFile(of,nf))
					MESSAGE("0");
			}else
#endif
			if(!packPFile(of,nf))
				MESSAGE("0");
			delete nf;
		}
		delete of;
		if(MaxTomSrc > 0){
			nf = new PagedFile ( base_path1, ACE_OS_O_RDONLY );
			if(nf->m_mode & 0x1000)
				nf->m_readed.page= (long)(( ((((ACE_UINT64)0xffffffff) << 8)|(ACE_UINT64)0xff) & *(ACE_UINT64*)(5 * (nf->LastPage) + (char*)nf->pageOffs)) / (ACE_UINT64)nf->PageSize);
			else
				nf->m_readed.page= nf->pageOffs[nf->LastPage] / nf->PageSize;
			int MaxTomTrgt= IsNextTom( &nf->m_readed ) + 1;
			char Ext[4];memcpy(Ext, strrchr(nf->FileName, '.'), 4);
			while(MaxTomTrgt <= MaxTomSrc){
				GetBasedExtFileName(nf->FileName, MaxTomTrgt);
				ace_os_unlink(nf->FileName);
				MaxTomTrgt++;
				memcpy(strrchr(nf->FileName, '.'), Ext, 4);
			}
			delete nf;
		}
	}
/////////// usage //////////
	else
	if ( (task & HELP) )
		return usage ( argv [0] );
///////// status ///////////
	else
	if ( /*argc == 2 &&*/ (task & STATUS) ){
		if( !of || !of -> IsOk ( ) ) {
			if (logCurr)
				MESSAGE2(msgSourceFileError,argv [i] )
			else
				printf ( msgSourceFileError,argv [i] );
			delete of;
			return 1;
		}
		if ( of -> GetAttr ( ID_PACKED, 0, 0 ) ) {
			if (logCurr)
				MESSAGE2(msgFileIsPacked,argv[i])
			else
				printf(msgFileIsPacked,argv[i]);
		}
		else {
			if (logCurr)
				MESSAGE2(msgFileIsUnpacked,argv[i])
			else
				printf(msgFileIsUnpacked,argv[i]);
		}
		if (logCurr) CLOSELOG();
		delete of;
		return 0;
	}
///////// otherwize /////////
	else
		return usage ( argv [0] );

finish:
#ifndef STANDALONE
	if ( mem != farcoreleft ( ) )
		WARNING("\nWarning: memory leak\n");

	clear_video ( );
#endif
	CLOSELOG();
	return res;
}

////////////// misc funcs ///////////////

#ifdef STANDALONE
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
#endif
