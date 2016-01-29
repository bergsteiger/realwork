#include "shared/Core/fix/mpcxc.h"
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>

//#include <unistd.h>
#include <string.h>

#include "osdep.h"
#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/log.h"

#ifdef __WIN32__
	#ifdef __cplusplus
	extern "C" {
	#endif

	extern int optind;
	extern int opterr;
	extern int optopt;
	extern char *optarg;
	extern int optreset;

	extern int getopt(int argc, char *argv[], char *optstring);

	#ifdef __cplusplus
	}
	#endif
#endif

FILE *file_in ;
char *source_base_name =0;
char *gs_logfile =0;
char *gs_resfile =0;
char *output_path =0;
u_int32_t global_options =0;
extern u_int32_t debug_level;

extern void usage(void);
extern void help(void);
extern void version(void);

int split_turbo =
#ifndef PTRS_IN_META
					1
#else
					0
#endif
						;
int split_subname = 0;
int split_bases = 1;

#include "message.h"

#include <basemask.h>
#include <garver.h>

extern char *GetBasedExtFileName( char *, int);


int parse_cmdline(int argc, char **argv)
{
	int c;
#ifndef _WINDOWS
	FILE *f;
#endif
	int len;

#ifndef _WINDOWS
	int iRetV;

	////////////////////////////
	// Init parametred struct //
	////////////////////////////
	VER_PARAM verParam;

	verParam.exeId= TID_GSPLIT;				// defines BASEMASK.H
	verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
	verParam.stdOut= stdout;
	verParam.pDate= __DATE__;
	verParam.pTime= __TIME__;

	/////////////////////////////////
	// Check or Add version record //
	/////////////////////////////////
	if((iRetV=_imp_GVersion(&argc, argv, &verParam))){
		if(iRetV == VC_ADD_OK){
			///////////////////////////////////////////////////////////////////
			// Corrected Add version record after execute with option - '-z' //
			///////////////////////////////////////////////////////////////////
		}else{
			////////////////////////////////////////////////
			// Run-Time Error in function Version Control //
			////////////////////////////////////////////////
		}
#ifdef _DEBUG
		printf("\n *** GSPLIT Debug Version. For test, only... ***\n\n");
#else
		exit(0);
#endif
	}
	////////////////////////////////////////////
	// Corrected version record after execute //
	////////////////////////////////////////////
#endif
	file_in = stdin;
	
	while((c=getopt(argc, argv, "?bhestf:o:l:d:r:")) != -1) {
		switch(c) {
			case '?': // Help query
				break;
			case 'b':
#ifndef PTRS_IN_META
				split_bases = 0;
#else
				printf("\nThis version not support spliting morpho only !");
#endif
				break;
			case 's':
				split_subname = 1;
				break;
			case 't':
				split_turbo = 0;				
				break;
			case 'h':
				help();
				return 1;
			case 'e':
				set_language(1);
				break;
			case 'r': // Set output bases path
				len = strlen(optarg);
				gs_resfile = (char *)malloc(len+2);
				strcpy(gs_resfile, optarg);
				break;
			case 'l': // Set output bases path
				len = strlen(optarg);
				gs_logfile = (char *)malloc(len+2);
				strcpy(gs_logfile, optarg);
				break;
			case 'd': // Set output bases path
				debug_level = atoi(optarg);
				break;
			case 'o': // Set output bases path
				len = strlen(optarg);
				output_path = (char *)malloc(len+2);
				strcpy(output_path, optarg);
				if(output_path[len-1] != DIRECTORIES_TERM) {
					output_path[len++] = DIRECTORIES_TERM;
					output_path[len] = '\0';
				}
				break;
			case 'f': // Sets info filename
#ifndef _WINDOWS
				f = mpcxc_fopen(optarg, "r");
				if(f) {
					file_in = f;
					global_options |= 0x80000000;
				}
				else {
					printf("Can't open \"bases set\" file %s. %s.", optarg, strerror(errno));
					return -1;
				}
#endif
				break;
			default:
				printf("Unkhown option: -%c\n", c);
				usage();
				return 1;
		}
	}
	argc -= optind;
	argv += optind;
	if(!argc) {
		printf("No source base name given.\n");
		usage();
		return 1;
	}
	if(!output_path) {
		output_path = (char *)malloc(512);
		bzero(output_path, 512);
	}
	source_base_name = strdup(*argv);
	if (!gs_logfile)
#ifndef BRDR32
		gs_logfile = "gsplit.log";
#else
		gs_logfile = "nul";
#endif
	return 0;
}

#include "osdep.h"

#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>

#include <unistd.h>
#include <strings.h>
#include <alloca.h>

#include <fcntl.h>
#ifdef __WIN32__
#include <time.h>
#else
#include <sys/time.h>
#include <sys/resource.h>
#endif

#include "../../../libs/mrglib/src/sets.h"

#include "toys.h"

#include "ready.h"

#include "message.h"
#include "garver.h"

extern FILE *file_in;
extern char *source_base_name;
extern char *gs_logfile;
extern char *gs_resfile;
extern u_int32_t global_options;
extern char **segname;

int parse_cmdline(int, char **);
extern int get_seginfo(
#ifndef _WINDOWS
					   FILE *
#else
					   char *
#endif
					   );
extern set_st *create_doclists(void *, base_st *pbase, int count);
extern char *get_version();
extern int check_segsets(base_st *pbase, int *, void *);
int make_index(void *, char *name, base_st *pdest, int count, base_st *psrc, set_st *doclist, set_st *link);

static void create_base_name(char *buf, const char *name);
static char *make_title(char *msg);

static char *index_names[] = {
	"SubName", "SubName.str", "Attrs.str", "CalIn.str", "CalAb.str", "CalCh.str", "Tag.str",
	"Attribs", "Active", "TradeName", "IntName", "RegDate", "AnnulDate", "PhGroup",
	"PhEffect", "Chapter", "Atc", "RegStatus", "LekForm", "Mkb",
	"PhFirm", "PhCountry", "Territory", "Adopted",
	"PublishedIn", "ServiceInfo", "Type", "Kind", "Date", "Number", "Status", "Status_ex",
	"KeyWord", "RCode", "Respondent",  "Correspondent", "NewCorr", "Control", "Class6",
	"AnnoUser", "AnnoOrganization", "AnnoTax", "AnnoInterest", "AnnoKind", "AnnoDate",
	"RDate", "Context.str", "VAnonced", "VIncluded", "VChanged", "VAbolished", "VLControl", "DocKind", "Class",
	"Segment", "SortDate", "Category", "Blob",
#ifdef PTRS_IN_META
	"Aux.str",
	"KindCorr"
#else
	"KindCorr",
	"Aux.str"
#endif
};

#ifdef PTRS_IN_META
	extern void set_key_attr_area(base_st *);
	extern void clone_close_base(base_st *);
#endif

#ifndef _WINDOWS
	#if defined(__WIN32__) || defined(__DOS32__)
	extern int _fmode;
	#endif
#endif

#define HAS_RLIMIT 1

#if defined(__DOS32__) || defined(__WIN32__)
#undef HAS_RLIMIT
#define OB_MODE (OBSC_SEQSP | OBSC_LARGE)
extern int mkstemp(char *);
static int test_files(int);
#else
// #define OB_MODE (OBSC_RNDSP | OBSC_LARGE)
#define OB_MODE (OBSC_SEQSP | OBSC_LARGE)
#endif

extern char *fileBuffRead;
extern set_st *segset;

//extern unsigned UnZip ( void *, int, void *, int );
//extern unsigned Pack(char *src, int size, char *dst, int out_size);

void free_my_global()
{
#ifndef BRDR32
	if(fileBuffRead != 0){
		free(fileBuffRead);
		fileBuffRead= 0;
	}
#endif
	if(segset != 0){
		free(segset);
		segset= 0;
	}
	if(segname != 0){
		free(segname);
		segname= 0;
	}
}

extern void *CreateContext(void *pCurrent);
extern void freeContext(void *pCurrent);
extern void ShowMessageFromContext(void *pCurrent, char *CurrMsg);

#if (defined (BRDR32) && defined (WIN32))/* || defined (GARANT_MPCXC)*/
	extern void PostGL(
	#ifdef BRDR32
						base_st *targets,
	#endif
						void *pCurrent, char* aBasePath, FILE* aLogFile, int iPacked);
#endif

#ifdef BRDR32
extern int open_base_from_base(void *, base_st *);
extern int create_base_inAsCopy(void *, const char *, base_st *);
extern int CIB_AsUpdated(void *);
extern int CopyAsFromContext(void *, char *, char *, int);
extern int _IsNotSplit(void *);
#endif
extern int number_Msg;
extern int makeDocListFromBase(set_st *, const char*, base_st *pbase);

int curr_open_mode= OB_MODE;

#ifdef INSTLL_CIB
	#include "../../GPersn/src/PL_Proto.h"
	extern void pl_GetLoginFromBase(char **, char *, int);
#endif

extern int truncation_NWCntxt_stream(	set_st *p_DelDocs, index_st *pin, 
								iter_st *spit, stream_st *psstr, stream_st *pdstr);

int iAddSkipedDoc= 0;
extern stream_st *load_stream_ex(streamfile_st *psf, stref_st *pref, stream_st *pstr, stream_info *strinfo);
extern Form_Node *FormsInSortedArray(stream_st *psstr, iter_st *spit, int *pRetSize);

extern void * bsearch_nxt(long key, long **ppBase, int *pNum);

int CompStringsZZZX(const void *l1, const void *l2){
	return CompStringsZZZ((void *)l1, (void *)l2);
}

char pTmpBuff0[4096];
stream_st psstr2;

#define ISSHORT_STR(_pref_) (0 != ((_pref_->alloc & 0x80000000) ? BIG_STREAM_HANDLE_TO_ID(_pref_->data.pos, _pref_->alloc ) : OLD_STREAM_HANDLE_TO_ID( _pref_->data.pos )))

extern int streamed_Blocks_IsOk(stream_st *pstr, int i);

int gsplit_Method(int argc, char **argv, void *pCntx)
{
	#ifdef HAS_RLIMIT
		struct rlimit rl;
	#endif

	int cmderr, segcount, i, isBuckup, newSB= 0, iOut;
	unsigned short tmpBlockSize;
	base_st *psrcbase, *targets;
	char *destname;
	stamp_st syncstamp;
#ifdef MULTI_INDEX_STREAM_FILE
	index_st *prin= 0, *pin;
	char *WNameIndx=
  #ifdef VERSION62
						"NWCntxt.str", *WSWords= "SWords.str",
  #else
						"NContxt.str",
  #endif
										*BNameIndx= "NBCntxt.str", *FNameIndx0= "NFContxt.str", *NameIndx= FNameIndx0;
#endif
/*#if defined(__DOS32__) || defined(__WIN32__)
	int new_segcount;
#endif*/
	char *msg, msg01[]="\toutputed path - specified!\n", msg02[]="Finished "
#ifdef BRDR32
		, *s, *missing
#endif
		;
	static FILE *fres, *log_file= 0;
	int hLog;
	time_t checkpoint;
	set_st link;
#ifdef BRDR32
	unsigned long status;
#endif
	set_st *doclists;
	int LocalContext= 0;
/*
	long zzz[]= {1,3,5,6,7,9,10,11,13,14}, *pzzz= zzz, xx= 12;
	int sss= 10;

	bsearch_nxt(xx, &pzzz, &sss);
	xx= 5;
	bsearch_nxt(xx, &pzzz, &sss);
	xx= 6;
	bsearch_nxt(xx, &pzzz, &sss);
*/
	if(pCntx == 0){
		LocalContext= 1;
		pCntx= CreateContext(0);
	}
	msg = (char *)alloca(128);
	cmderr = parse_cmdline(argc, argv);
	if(cmderr != 0) {
		if(global_options & 0x80000000)
			fclose(file_in);
		return (cmderr<0) ? cmderr : 0;
	}
	segcount = get_seginfo(
#ifndef _WINDOWS
							file_in
#else
							argv[2]
#endif
							);
	if(!segcount) {
		printf("Error: Nothing to do\n");
		return -1;
	}/*else if(segcount == -735){
		;
	}*/else if(segcount == -1){
		printf("Error: a few resultanted bases equally by name.\n");
		return -2;
	}else if(segcount == -2){
		printf("Error:\tpathed symbols in names for resultanted base, but\n");
		printf(msg01);
		return -3;
	}else if(segcount == -3){
		printf("Error:\tNot define segments in first CD subfile, but\n");
		printf(msg01);
		return -3;
	}else if(segcount == -4){
		printf("Error:\tBad segment number, but\n");
		printf(msg01);
		return -3;
	}else if(segcount == -15){
		printf("Error:\tTriming -> Size < 1Mb, but\n");
		printf(msg01);
		return -3;
	}
#ifdef HAS_RLIMIT
	getrlimit(RLIMIT_DATA, &rl);
	rl.rlim_cur = rl.rlim_max;
	setrlimit(RLIMIT_DATA, &rl);
#ifndef sun
	getrlimit(RLIMIT_MEMLOCK, &rl);
	rl.rlim_cur = rl.rlim_max;
	setrlimit(RLIMIT_MEMLOCK, &rl);
#endif

#endif /* HAS_RLIMIT */

/*#if defined(__DOS32__) || defined(__WIN32__)
	new_segcount = test_files(segcount);
	if(new_segcount != segcount) {
		sprintf(msg, get_message(MSG_LIMIT), new_segcount);
		ShowMessageFromContext(pCntx, msg);
		segcount = new_segcount;
		//sleep(5); ///!!!
	}
#endif*/
	if(global_options & 0x80000000) fclose(file_in);
	psrcbase = (base_st *)alloca(sizeof(base_st));
	bzero((caddr_t)psrcbase, sizeof(base_st));
	hLog = create_log(gs_logfile, 0);
#ifndef BRDR32
	fprintf(stderr, " \n");
#else
  #ifdef ENGLISH_DEF_RC
	set_language(1);
  #endif
#endif
	gb_enable_log(1);
	time(&checkpoint);
	m_log("Garant database splitter.\nStarted ");
	flog(ctime(&checkpoint));
#ifdef MULTI_INDEX_STREAM_FILE
	psrcbase->pNextSubToms=
		psrcbase->pSubToms= calloc(	sizeof(index_names)/sizeof(*index_names) + 2 // NWCntxt & NFCntxt //
									,sizeof(SubTom_st));
#endif
	if(!
#ifdef BRDR32
		open_base_from_base(pCntx, psrcbase)
#else
		open_base(source_base_name, psrcbase, curr_open_mode)
#endif
		) {
		sprintf(msg, get_message(MSG_NOOPEN), source_base_name);
		ShowMessageFromContext(pCntx, msg);
		m_log(msg);
		free_my_global();
		return -3;
	}
	if(get_info(((pgfile_st *)(&psrcbase->str)), ID_BLOCK_SIZE, &tmpBlockSize)){
		newSB= tmpBlockSize;
	}
#ifdef BRDR32
	{
	char *dirname = strdup( segname[0] );
	char* slashpos = strrchr( dirname, '\\' );
	if ( slashpos ) {
		*slashpos = 0;
		ace_os_mkdir( dirname );
	}
	free( dirname );
	}

	if(_IsNotSplit(pCntx)){
		status= 0;
		if(!segset[0].isPacked){
			if(psrcbase->key.PrmExt.accesMode & 0x2000)
				status |= 1;
			if(((pgfile_st *)(&psrcbase->str))->PrmExt.accesMode & 0x2000)
				status |= 2;
			if(psrcbase->ndt.PrmExt.accesMode & 0x2000)
				status |= 4;
		}
		if(status && CIB_AsUpdated(pCntx))
			status= 0;
		isBuckup= CopyAsFromContext(	pCntx,
										psrcbase->ndt.PrmExt.FileName,
										segname[0], status);
		segcount= 0;
	}else{
	if((status=get_ready(psrcbase))) {
		sprintf(msg, get_message(MSG_NOTREADY), source_base_name);
		ShowMessageFromContext(pCntx, msg);
		m_log(msg);
		flog("At least the following utilities must be applied to the base:\n");
		s = missing = missing_process_description(status);
		do {
			flog("%s\n", s);
			s += strlen(s) + 1;
		} while (*s);
		free(missing);
		close_base(psrcbase);
		free_my_global();
		return -4;
	}
#endif
	for(i=0; i<segcount; i++) {
		if(segset[i].pSourceBase &&(isBuckup= makeDocListFromBase(segset+i, strchr(segname[i], '\0')+2, psrcbase))){
			if(isBuckup == -736)
				printf("Warning: Not new documents in base (%s)!\n", source_base_name);
			else if(isBuckup == -737)
				printf("Warning: Not find added documents in base (%s)!\n", source_base_name);
			close_base(psrcbase);
			free_my_global();
			return -735;
		}
	}
	if(!(isBuckup= check_segsets(psrcbase, &segcount, pCntx))) {
		ShowMessageFromContext(pCntx, get_message((segcount>1) ? MSG_NONEXISTM : MSG_NONEXIST1));
		close_base(psrcbase);
		free_my_global();
		return -5;
	}
#ifdef BRDR32
	}
	if(isBuckup == -65){
		close_base(psrcbase);
		free_my_global();
		return -65;
	}else if(isBuckup == -75){
		close_base(psrcbase);
		free_my_global();
		return -75;
	}
#endif
	if(segcount == 0){
		time(&checkpoint);
		m_log(msg02);
		flog(ctime(&checkpoint));
		//sleep(2); ///!!!
		if(fileBuffRead != 0){free(fileBuffRead); fileBuffRead= 0;}
		if(LocalContext)
			freeContext(pCntx);

		close_base(psrcbase);
		free_my_global();
		if(isBuckup == 55)
			return 555;
		else if(!isBuckup)
			return 55;
		return isBuckup;
	}
	targets = (base_st *)calloc(segcount,sizeof(base_st));
	destname = (char *)alloca(1024);
	for(i=0; i<segcount; i++) {
		create_base_name(destname, segname[i]);
		if(
#ifdef BRDR32
			((isBuckup= create_base_inAsCopy( pCntx, destname, targets+i)) && isBuckup != 55)
#else
			!create_base(destname, targets+i)
#endif
			) {
			for(;i; i--) close_base(targets+i-1);
			printf("Can't create the base %s\n", destname);
			printf("The system reported: %s\n", strerror(errno));
			//if(fileBuffRead != 0){free(fileBuffRead); fileBuffRead= 0;}
			free(targets);
			return -5;
		}
#ifdef MULTI_INDEX_STREAM_FILE
  #ifdef INSTLL_CIB
		pl_GetLoginFromBase( (char**)&targets[i].pNextSubToms,
								((pgfile_st *)&targets[i].ndt)->PrmExt.pHeader,
								1 << ((pgfile_st *)&targets[i].ndt)->pgpow);
		pl_GetLoginFromBase( (char**)&targets[i].pSubToms,
								((pgfile_st *)&psrcbase->ndt)->PrmExt.pHeader,
								1 << ((pgfile_st *)&psrcbase->ndt)->pgpow);
		memcpy(	targets[i].pNextSubToms, targets[i].pSubToms,
				LOGIN_SIZE_PER_BYTES + 1 + SIZE_CRYPTO_KYE_PER_DWORD * sizeof(DWORD));
  #endif
  #ifndef PTRS_IN_META
		targets[i].pNextSubToms=
			targets[i].pSubToms= calloc( sizeof(index_names)/sizeof(*index_names) + 2 // NWCntxt & NFCntxt //
										,sizeof(SubTom_st));
  #endif
#endif
		if(segset[i].iMulti >= 1024){
			targets[i].ndt.pfhdr->TomPerPages
				= (segset[i].iMulti * 1024) / targets[i].ndt.pfhdr->page_size;
			targets[i].ndt.PrmExt.maxFile_per_bytes
				= targets[i].ndt.pfhdr->TomPerPages * targets[i].ndt.pfhdr->page_size;
		}
		if(segset[i].put_first_disk && segset[i].iMultiDemo >= 1024){
			targets[i].str.pgfile.pfhdr->TomPerPages
				= (segset[i].iMultiDemo * 1024) / targets[i].str.pgfile.pfhdr->page_size;
			targets[i].str.pgfile.PrmExt.maxFile_per_bytes
				= targets[i].str.pgfile.pfhdr->TomPerPages
					* targets[i].str.pgfile.pfhdr->page_size;
		}else if(segset[i].iMulti >= 1024){
			targets[i].str.pgfile.pfhdr->TomPerPages
				= (segset[i].iMulti * 1024) / targets[i].str.pgfile.pfhdr->page_size;
			targets[i].str.pgfile.PrmExt.maxFile_per_bytes
				= targets[i].str.pgfile.pfhdr->TomPerPages
					* targets[i].str.pgfile.pfhdr->page_size;
		}
	}
	if(!segcount) {
		printf("Please, specify the segments sets to create\n");
		free_my_global();
		free(targets);
		return 2;
	}
	bzero(&link, sizeof(set_st));
	prin= (index_st *)calloc(1+segcount+1+segcount, sizeof(index_st));
	pin= prin + 1;
	if(open_index(psrcbase, NameIndx, prin, 1)){
		iAddSkipedDoc++;
		prin->trunc_NContxt_str= truncation_NWCntxt_stream;
	}
	doclists = create_doclists(pCntx, psrcbase, segcount);
	if(!doclists) {
		close_base(psrcbase);
		for(i=0; i<segcount; i++) close_base(targets+i);
		printf("Nothing to do...\n");
		if(fileBuffRead != 0){free(fileBuffRead); fileBuffRead= 0;}
		free(targets);
		return -11;
	}
	number_Msg= 0;

	if (split_bases) {
		int j;
		fat_rec_type putFp;
		for(iOut=0; iOut<sizeof(index_names)/sizeof(*index_names); iOut++) {
			if(!strcmp (index_names [iOut], "Attribs") && split_turbo){
				for(i=0; i<segcount; i++){
					if(targets[i].pSubToms->pStr->fat_chain){
						if(targets[i].pSubToms->pStr->cused) {
							flush_write_cache(targets[i].pSubToms->pStr);
						}
						targets[i].pSubToms->pStr->fat[targets[i].pSubToms->pStr->lfp] = CHAIN_FLAG;
						for (j=0, putFp= 1; j<targets[i].pSubToms->pStr->fat_size; j++) {
							write_page((pgfile_st *)targets[i].pSubToms->pStr, putFp, targets[i].pSubToms->pStr->fat + (j << FAT_PAGE_EP));
							putFp= targets[i].pSubToms->pStr->fat[putFp] & (~CHAIN_FLAG);
						}
						set_info((pgfile_st *)targets[i].pSubToms->pStr, "FatSize", &(targets[i].pSubToms->pStr->fat_size), 2);
						j = (targets[i].flags & BF_OPTIMAL) ? 1 : 0; 
						set_info((pgfile_st *)targets[i].pSubToms->pStr, "Optimized", &j, 2);
						free(targets[i].pSubToms->pStr->fat_chain);
						if(targets[i].pSubToms->pStr->cmax) {
							if(targets[i].pSubToms->pStr->centries)
								free(targets[i].pSubToms->pStr->centries);
							free(targets[i].pSubToms->pStr->cache);
						}
					}
					close_pgfile((pgfile_st *)targets[i].pSubToms->pStr);
					if(targets[i].pSubToms->pStr->fat)
						free(targets[i].pSubToms->pStr->fat);
					if(targets[i].flags & BF_READY)
						set_info(targets[i].pSubToms->pKey, "Ready", &(targets[i].ready_flags), 4);
					close_pgfile(targets[i].pSubToms->pKey);
					targets[i].openMode += targets[i].pSubToms->pKey->AddedPage * 2;
					targets[i].iNContxt += ((pgfile_st *)targets[i].pSubToms->pStr)->AddedPage * 4;
					free(targets[i].pSubToms->pStr);
					free(targets[i].pSubToms->pKey);
					free(targets[i].pSubToms);
					targets[i].pNextSubToms=
						targets[i].pSubToms= calloc( sizeof(index_names)/sizeof(*index_names) + 2 // NWCntxt & NFCntxt //
													,sizeof(SubTom_st));
				}
				free(psrcbase->pSubToms[2].pStr->pgfile.name);psrcbase->pSubToms[2].pStr->pgfile.name= 0;
				free(psrcbase->pSubToms[2].pStr->cache);psrcbase->pSubToms[2].pStr->cache= 0;
				free(psrcbase->pSubToms[2].pStr->centries);psrcbase->pSubToms[2].pStr->centries= 0;
				free(psrcbase->pSubToms[2].pStr->hits);psrcbase->pSubToms[2].pStr->hits= 0;
				free(psrcbase->pSubToms[2].pStr->fat);psrcbase->pSubToms[2].pStr->fat= 0;
				free(psrcbase->pSubToms[2].pKey->name);psrcbase->pSubToms[2].pKey->name= 0;
				free(psrcbase->pSubToms[2].pName);psrcbase->pSubToms[2].pName= 0;
				break;
			}
			if ((!strcmp (index_names [iOut], "SubName") && !split_subname) || (!strcmp (index_names [iOut], "SubName.str") && split_subname))
				continue;

			if (make_index(pCntx, index_names[iOut], targets, segcount, psrcbase, doclists, &link)) {
				printf("Runtime error. All target bases is corrupted and unusable.\n");
				printf("See log file %s for details.\n", gs_logfile);
				free_my_global();
				free(targets);
				return -11;
			}
		}
	}

	if (split_turbo) {
		long rPos;
		iter_st *spit= (iter_st *)calloc(2,sizeof(iter_st)), *spitW= spit+1;
		stream_st *psstr= (stream_st *)calloc(1+segcount*2, sizeof(stream_st)),
					*pdstr= psstr +1;
		streamfile_st *str_0;
		char *pCurrIndexN= NameIndx;
		stref_st *pref;
		char *FNameIndx= "NFContxt.str\0\n", *pR;
		pgfile_st *pf0;
		streamfile_st *str0;
		int sNodes;
		Form_Node *pPut = 0;
		u_int64_t BasesMask;
		u_int32_t iz, Rpt, pss, AllocS;

		memset(&psstr2, 0, sizeof(*psstr));

		do {
			if(!psstr || !spit
				|| !init_iter(prin, spit) || !first_key(spit)
				|| (rPos= 0) || !create_stream(prin, psstr)){
				free(prin);
	#ifdef	__FreeBSD__
				break;
	#else
				if(spit)
					free(spit);
				if(psstr)
					free(psstr);
				exit (-29);
	#endif
			}
			if(pCurrIndexN == FNameIndx0){
				pPut= FormsInSortedArray(psstr, spit, &sNodes);
				close_index(prin);
				memset(psstr, 0, sizeof(*psstr));
				psstr->pAForms= pPut;
				psstr->max_B= sNodes;
				memset(spit, 0, sizeof(*spit));
				memset(prin, 0, sizeof(*prin));
				NameIndx= pCurrIndexN= WNameIndx;
				if(open_index(psrcbase, WSWords, prin+1+segcount, 1)
						&&
					open_index_hack((prin+1+segcount)->pf, NameIndx, prin)
						&&
					(prin->str= (prin+1+segcount)->str)){
					prin->trunc_NContxt_str= truncation_NWCntxt_stream;
				}else{
					abort();
				}
				continue;
			}
			if(pCurrIndexN != FNameIndx)
				psstr->pNorml_Node= (Norml_Node*)-1;

			for(i=0; i<segcount; i++) {
				pdstr[i*2].flags |= SF_NOALLOC;
				pdstr[i*2+1].flags |= SF_NOALLOC;
				if(pCurrIndexN != FNameIndx){
					if ( !i ) {
						if ( !init_iter(prin+1+segcount, spitW) || !first_key(spitW)) {
							free(prin);
							if(spit)
								free(spit);
							if(psstr)
								free(psstr);
							exit(-29);
						}
					}

					if(	!create_index(targets+i, WSWords, pin+i+1+segcount)
							||
						!create_index_hack((pin+i+1+segcount)->pf, pCurrIndexN, pin+i)
							||
						!((pin+i)->str = (pin+i+1+segcount)->str)
							||
						!((pin+i)->pbase = targets+i)){
						free(prin);
						if(spit)
							free(spit);
						if(psstr)
							free(psstr);
						exit(-29);
					}
				}
  				if(((pCurrIndexN == FNameIndx && !create_index(targets+i, pCurrIndexN, pin+i)))
					|| !create_stream(pin+i, pdstr+i*2) || !create_stream(pin+i, pdstr+i*2+1)){
						free(prin);
						if(spit)
							free(spit);
						if(psstr)
							free(psstr);
						exit(-29);
				}
			}
			if(pCurrIndexN != FNameIndx){
				char *pFind;
				int FlagLoadStream= 0;
				i= segcount;
				while(i--){
					doclists[i].BSset= doclists[i].set;
					doclists[i].BScount= doclists[i].count;
				}
				while(spitW->pkey){
					i= segcount;
					while(i--){
						if((pFind= bsearch(spitW->pkey, doclists[i].BSset, doclists[i].BScount, sizeof(long), longcmp))
							&& (!doclists[i].put_first_disk
									|| !bsearch(spitW->pkey, doclists[i].all_demo, doclists[i].count_all_demo, sizeof(long), longcmp))){
							doclists[i].BScount
								-= ((u_int32_t)pFind - (u_int32_t)doclists[i].BSset)/sizeof(long) + 1;
							doclists[i].BSset= pFind + sizeof(long);
							if(!FlagLoadStream){
								FlagLoadStream++;
								load_stream_ex(spitW->str, (pref= get_stref(spitW,0)), psstr, &(spitW->strinfo));
							}
							move_stream(psstr, pdstr[i*2].str, pref);
							add_key(pin+i+1+segcount, spitW->pkey);
						}
					}
					if(FlagLoadStream){
						FlagLoadStream= 0;
						release_stream(psstr);
					}
					if(!next_key(spitW))
						break;
				}
				release_iter(spitW);
			}
			str_0= pdstr->str;
			while(load_stream_ex(spit->str, (pref= get_stref(spit,0)), psstr, &(spit->strinfo))){
				i= segcount;
				if(spit->nstreams == 3){
					char *new_data= 0, *new_write, *pTmpBuff= pTmpBuff0;
					u_int32_t nxt_sz= 0;

					if(psstr->flags & SF_FREEBUF)
						pTmpBuff= psstr->rec;
					else{
						memcpy(pTmpBuff, psstr->rec, pref->size);
					}
					pR= 0;
					if((segcount > 1 || get_stref(spit,2)->size <= spit->strinfo.immds || ISSHORT_STR(get_stref(spit,2)))){
						if(		!load_stream_ex(spit->str, get_stref(spit,2), &psstr2, &(spit->strinfo))
							||	!(pR= psstr2.data)){
								printf("\nError 6! (%s)(%d)",spit->pkey+1, psstr2.ref.size);
								exit(-656);
							break;
						}
					}
					{
						if(!(new_write=(new_data= (char*)malloc((AllocS= psstr->ref.size/2+get_stref(spit,2)->size+psstr->str->pgfile.pfhdr->page_size))))){
								printf("\nError 16 ! (%s)(%d)",spit->pkey+1, psstr->ref.size/2+get_stref(spit,2)->size+psstr->str->pgfile.pfhdr->page_size);
								exit(-656);
							break;
						}
						if(segcount == 1 && !pR && get_stref(spit,1)->size == 32 && get_stref(spit,2)->size > 0x10000){
							// при одиночно-выливании для популярных букв буфер целевого стрима равен исходному  //
							AllocS= 1+AllocS/0x10000;
							for(iz= 0; iz < AllocS; iz++){
								if(iz == pdstr[1].bcount) {
									if(!streamed_Blocks_IsOk( pdstr+1, iz)){
										printf("\nError 26 ! (%s)(%d)",spit->pkey+1, psstr->ref.size/2+get_stref(spit,2)->size+psstr->str->pgfile.pfhdr->page_size);
										exit(-656);
									}
									pdstr[1].bcount++;
								}
								if(pdstr[1].ppBlock[iz]){
									free(pdstr[1].ppBlock[iz]);
									pdstr[1].ppBlock[iz]= 0;
								}
							}
						}
						if(pR){
	// при мульти-выливании для популярных букв //
	if(spit->pkey[0] == 2 && (spit->pkey[1] == -62 || spit->pkey[1] == -56)){
		// стрим позиций читаем через файл
		char tmpBaseName[1024], *fnd= strrchr(pdstr->str->pgfile.name, '.');
		int hFlush;
		*fnd= 0;
		sprintf(tmpBaseName, "%s.gsplit.tmp", pdstr->str->pgfile.name);
		*fnd= '.';
		if((hFlush= c_io_open(tmpBaseName, ACE_OS_O_CREAT|ACE_OS_O_RDWR|ACE_OS_O_BINARY)) == -1
			|| c_io_write(hFlush, pR, psstr2.ref.size) != psstr2.ref.size
			|| c_io_lseek(hFlush, 0, ACE_OS_SEEK_SET) != 0){
		}
		// освобождаем огромный буфер с исходным телом стрима позиций
		close_stream(&psstr2);
		if(!(new_write=(new_data= (char*)malloc(psstr->ref.size/2+psstr2.ref.size+psstr->str->pgfile.pfhdr->page_size)))){
				printf("\nError ! (%s)(%d)",spit->pkey+1, psstr->ref.size/2+psstr2.ref.size+psstr->str->pgfile.pfhdr->page_size);
				exit(-656);
			break;
		}
		do{
			*(u_int32_t*)new_write= *(u_int32_t*)pTmpBuff;
			nxt_sz= ((ref_st*)pTmpBuff)->sub - nxt_sz;
			new_write += sizeof(u_int32_t);
			pR= (char*)malloc(nxt_sz+16);
			c_io_read(hFlush, pR, nxt_sz);
			memcpy(new_write, pR, nxt_sz);
			free(pR);
			new_write += nxt_sz;
			nxt_sz= ((ref_st*)pTmpBuff)->sub;
			pTmpBuff += sizeof(ref_st);
			psstr->ref.size -= sizeof(ref_st);
		}while(psstr->ref.size);
		c_io_close(hFlush);
		ace_os_unlink(tmpBaseName);
	}else{
		do{
			*(u_int32_t*)new_write= *(u_int32_t*)pTmpBuff;
			nxt_sz= ((ref_st*)pTmpBuff)->sub - nxt_sz;
			new_write += sizeof(u_int32_t);
			memcpy(new_write, pR, nxt_sz);
			pR += nxt_sz;
			new_write += nxt_sz;
			nxt_sz= ((ref_st*)pTmpBuff)->sub;
			pTmpBuff += sizeof(ref_st);
			psstr->ref.size -= sizeof(ref_st);
		}while(psstr->ref.size);
		close_stream(&psstr2);
	}
						}else
		{
// при одиночно-выливании для популярных букв стрим позиций читаем буфером равным максимальному колличеству позиций для одного документа ///
			u_int32_t readStep= spit->str->pgfile.pfhdr->page_size;
			char *spge= (char*)malloc(readStep+readStep), *spage= spge+readStep, *sp= spage, *spageR= spage;
			fat_rec_type page;
			u_int32_t pgcount, size, pos, p, rmpv= 0, cntRptRead;
			
			pgcount = get_stref(spit,2)->size >> spit->str->pgfile.pgpow;
			if(get_stref(spit,2)->size & (spit->str->pgfile.pfhdr->page_size-1))
				pgcount++;
			if(get_stref(spit,2)->alloc & 0x80000000)
				page = (fat_rec_type)BIG_STREAM_HANDLE_TO_PAGE( get_stref(spit,2)->data.pos );
			else
				page = (fat_rec_type)OLD_STREAM_HANDLE_TO_PAGE( get_stref(spit,2)->data.pos );
			iz = pgcount;
			cntRptRead= readStep/spit->str->pgfile.pfhdr->page_size;
			do {
				size = 1;
				pos = (u_int32_t)page;
				iz--;
				p=page;
				while(iz && (spit->str->fat[p] & ~CHAIN_FLAG) == p+1) {
					size++;
					p = spit->str->fat[p] & ~CHAIN_FLAG;
					iz--;
				}
				pss= pos;
				Rpt= size;
				while(Rpt--){
					read_page(&(spit->str->pgfile), pss, spageR); spageR += spit->str->pgfile.pfhdr->page_size;
					pss++;
					cntRptRead--;
					if(!cntRptRead || (!Rpt && !iz)){
						pR= sp;
						do{
							if((pR+(((ref_st*)pTmpBuff)->sub - nxt_sz))-sp > (readStep + rmpv)){
								rmpv= (spage+readStep) - pR;
								if((((ref_st*)pTmpBuff)->sub - nxt_sz) > readStep){
									u_int32_t szRlc= 1+ (((ref_st*)pTmpBuff)->sub - nxt_sz) / spit->str->pgfile.pfhdr->page_size;
									char *spgeN= (char*)malloc((readStep= szRlc*spit->str->pgfile.pfhdr->page_size)+readStep);
									spage= spgeN + readStep;
									sp= spage - rmpv;
									memcpy(sp, pR, rmpv);
									free(spge);
									spge= spgeN;
								}else{
									sp= spage - rmpv;
									memcpy(sp, pR, rmpv);
								}
								spageR= spage;
								cntRptRead= readStep/spit->str->pgfile.pfhdr->page_size;
								break;
							}
							*(u_int32_t*)new_write= *(u_int32_t*)pTmpBuff;
							nxt_sz= ((ref_st*)pTmpBuff)->sub - nxt_sz;
							new_write += sizeof(u_int32_t);
							memcpy(new_write, pR, nxt_sz);
							pR += nxt_sz;
							new_write += nxt_sz;
							nxt_sz= ((ref_st*)pTmpBuff)->sub;
							pTmpBuff += sizeof(ref_st);
							psstr->ref.size -= sizeof(ref_st);
						}while(psstr->ref.size);
					}
				}
				page = spit->str->fat[pss-1] & ~CHAIN_FLAG; 
			} while(iz);
			free(spge);
			pR= 0;
		}
					}
					if(psstr->flags & SF_FREEBUF){
						free(psstr->data);
					}else
						psstr->flags |= SF_FREEBUF;
					psstr->rec= psstr->data= new_data;
					psstr->ref.size= new_write-new_data;
				}
				while(i--){
					if(pCurrIndexN == FNameIndx){
						BasesMask= ((u_int64_t)1) << i;
						if((psstr->pAForms= bsearch(spit->pkey,
														pPut, sNodes, sizeof(*pPut),
														CompStringsZZZX))
							&& !(psstr->pAForms->BasesMask & BasesMask))
							;
						else{
							move_stream(psstr, pdstr[i*2].str, pref);
							add_key(pin+i, spit->pkey);
						}
					}else{
						psstr->curr_B= i;
						if(!i){
							pdstr->str= str_0;
							pdstr[1].str= str_0;
						}else{
							pdstr->str= pdstr[i*2].str;
							pdstr[1].str= pdstr[i*2].str;
						}
						pdstr->ArrayIOffsCount= psstr->ArrayIOffsCount= 0;
						if(segcount==1 && !pR && get_stref(spit,1)->size == 32 && get_stref(spit,2)->size > 0x10000){
							for(iz= 0; iz < AllocS; iz++){
								pdstr[1].ppBlock[iz]= psstr->rec + iz*0x10000;
							}
							pdstr[1].data= pdstr[1].ppBlock[0];
							if(prin->trunc_NContxt_str(	doclists+i, pin+i, spit, psstr, pdstr))
								return -1;
							for(iz= 0; iz < AllocS; iz++){
								pdstr[1].ppBlock[iz]= 0;
							}
							pdstr[1].flags &= ~SF_NOALLOC;
							close_stream(pdstr+1);
							create_stream(pin, pdstr+1);
							pdstr[1].flags |= SF_NOALLOC;
						}else if(prin->trunc_NContxt_str(	doclists+i, pin+i, spit, psstr, pdstr))
								return -1;
				  }
				}
				release_stream(psstr);
				if(!next_key(spit))
					break;

				if(get_stref(spit,1)->size == 32 && get_stref(spit,2)->size > 0x10000){
					pdstr[0].flags &= ~SF_NOALLOC;
					close_stream(pdstr);
					pdstr[1].flags &= ~SF_NOALLOC;
					close_stream(pdstr+1);
					create_stream(pin, pdstr);
					create_stream(pin, pdstr+1);
					pdstr[0].flags |= SF_NOALLOC;
					pdstr[1].flags |= SF_NOALLOC;
				}
			}
			release_iter(spit);
			for(i=0; i<segcount; i++){
				close_index(pin+i);
			  if(pCurrIndexN == FNameIndx){
				pdstr[i*2].flags &= ~SF_NOALLOC;
				close_stream(pdstr+i*2);
				pdstr[i*2+1].flags &= ~SF_NOALLOC;
				close_stream(pdstr+i*2+1);
				if(doclists[i].pSkipDoc){
					free(doclists[i].pSkipDoc);
					doclists[i].pSkipDoc= 0;
				}
			  }else{
				  close_index(pin+i+1+segcount);
				  pf0= pin[i].pf;
				  memset(pin+i, 0, sizeof(*pin));
				  pin[i].pf= pf0;
			  }
			}
			close_stream(psstr);
			if(pCurrIndexN == FNameIndx)
				break;
			pf0= prin->pf;
			str0= prin->str;
			memset(psstr, 0, sizeof(*psstr));
			memset(spit, 0, sizeof(*spit));
			memset(prin, 0, sizeof(*prin));
			open_index(psrcbase, FNameIndx, prin, 1);
			pCurrIndexN= FNameIndx;
		} while (1);
		free(spit);
		free(psstr);
		if (pPut) free (pPut);
	}
	if (split_turbo && iOut < sizeof(index_names)/sizeof(*index_names))
		make_index(pCntx, index_names[iOut], targets, segcount, psrcbase, doclists, &link);
	i= segcount;
	while(i--){
		if(doclists[i].put_first_disk && doclists[i].all_demo){
			free(doclists[i].all_demo);
			doclists[i].all_demo= 0;
		}
	}
	if(split_turbo)
	  for(iOut++;iOut<sizeof(index_names)/sizeof(*index_names); iOut++) {
		if (make_index(pCntx, index_names[iOut], targets, segcount, psrcbase, doclists, &link)) {
			printf("Runtime error. All target bases is corrupted and unusable.\n");
			printf("See log file %s for details.\n", gs_logfile);
			free_my_global();
			free(targets);
			return -11;
		}
	  }
	free(prin);
	hide_message();
	ShowMessageFromContext(pCntx, get_message(MSG_SUCCESS));
	bzero((caddr_t)&syncstamp, sizeof(stamp_st));
	if(!get_info(&(psrcbase->key), "HSTS", &syncstamp))
		makestamp(&syncstamp);

	for(i=0; i<segcount; i++) {
		char *pFileName= 0;
		u_int32_t kSZ, sSZ, nSZ;
#ifdef PTRS_IN_META
		set_key_attr_area(&(targets[i].key));
		set_info(&(targets[i].key), "HSTS", &syncstamp, sizeof(stamp_st));
#else
		set_info(&(targets[i].key), "HSTS", &syncstamp, sizeof(stamp_st));
		set_base_state(targets+i, get_final_mask(psrcbase->ready_flags));
#endif
		if(segset[i].isDocsList == 1){
			int len;
			len=strlen(targets[i].ndt.PrmExt.FileName)+1;
			pFileName= (char*)malloc(len+1);
			GetBasedExtFileName((char*)memcpy(pFileName,targets[i].ndt.PrmExt.FileName,len+1), 1);
		}
	#if defined(MULTI_INDEX_STREAM_FILE) && defined(BRDR32)
		// Only target Base !!!
		targets[i].pNextSubToms= targets[i].pSubToms;
	#endif
#ifdef PTRS_IN_META
		clone_close_base(targets+i);
#else
		if(newSB)
			set_info(((pgfile_st *)(&targets[i].str)), ID_BLOCK_SIZE, &newSB, sizeof(tmpBlockSize));
		close_base(targets+i);
#endif
#if (defined (BRDR32) && defined (WIN32))/* || defined (GARANT_MPCXC)*/
		if(/*segset[i].isMenu*/1) {
			if (strcmp (gs_logfile, "nul"))
				log_file = mpcxc_fopen (gs_logfile, "a+w");
			PostGL(
	#ifdef BRDR32
					targets+i,
	#endif
					pCntx, segname[i],log_file, segset[i].isPacked);
			if (log_file) fclose(log_file);
		}
#endif
		free(doclists[i].set);
		if(doclists[i].sub_seg_set != 0){
			free(doclists[i].seg_set);
			free(segset[i].sub_seg_set);
		}
		if(pFileName != 0){
#ifndef _DEBUG
			ace_os_unlink(	pFileName );
#endif
			free(pFileName);
			pFileName= 0;
		}
  #if !defined(BRDR32)
		kSZ= targets[i].openMode;
		sSZ= targets[i].iNContxt;
  #else
		kSZ= targets[i].key.AddedPage * 2;
		sSZ= ((pgfile_st *)&(targets[i].str))->AddedPage * 4;
  #endif
		nSZ= targets[i].ndt.AddedPage / 2;
		if(segset[i].count_blob_docs) {
			flog(msg02);
			flog("Make base [%s](key:%dKb.+str:%dKb.+ndt:%dKb.+blb:%dKb.= %dKb.)\n", segname[i],
					kSZ, sSZ, nSZ, (segset[i].count_blob_docs/1024), kSZ+sSZ+nSZ+(segset[i].count_blob_docs/1024));
		}
		else {
			flog(msg02);
			flog("Make base [%s](key:%dKb.+str:%dKb.+ndt:%dKb.= %dKb.)\n", segname[i],
					kSZ, sSZ, nSZ, kSZ+sSZ+nSZ);
		}
	}

	free(doclists);
	close_base(psrcbase);
	free(targets);
	if (gs_resfile) {
		fres = mpcxc_fopen(gs_resfile, "w");
		if(fres) {
			fprintf(fres, "0\n");
			fclose(fres);
		}
	}
	time(&checkpoint);
	flog(msg02);
	flog(ctime(&checkpoint));
#if !defined(BRDR32) && !defined(_WINDOWS)
	if(fileBuffRead != 0){free(fileBuffRead); fileBuffRead= 0;}
#endif
	if(LocalContext)
		freeContext(pCntx);

	set_progress(100);

	gs_logfile= 0;
	log_file= 0;

	if(isBuckup == 55)
		return 555;
	return 0;
}

extern char *output_path;

static void create_base_name(char *buf, const char *name)
{
	strcpy(buf, output_path);
	strcat(buf, name);
}

static char *make_title(char *msg)
{
	strcpy(msg, get_message(MSG_TITLE));
	return msg;
}

#if defined(__DOS32__) || defined(__WIN32__)
typedef char *pchar;
static int test_files(int bases)
{
	int nfiles = (bases + 1) * 4;
	char **fnames;
	int i, *hfiles;
	
	fnames = (pchar *)alloca(nfiles*sizeof(pchar));
	hfiles = (int *)alloca(nfiles*sizeof(int));
	for(i=0; i<nfiles; i++) {
		fnames[i] = strdup("tstXXXXX");
		hfiles[i] = mkstemp(fnames[i]);
		if (hfiles[i] == -1) {
			free(fnames[i]);
			break;
		}
	}
	nfiles = i;
	for (i=0; i<nfiles; i++) {
		c_io_close(hfiles[i]);
		ace_os_unlink(fnames[i]);
		free(fnames[i]);
	}
	nfiles /= 4;
	return --nfiles;
}

#endif


