#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: garcomp.cpp,v 1.154 2015/04/09 05:54:08 young Exp $
 */

#include <cstdlib>
#include <fcntl.h>
#include <ctime>
#include <cerrno>
#include <cstring>
#include <sys/stat.h>

#ifdef WITH_DBL_THREAD
	#include "MyPipe.h"
 #ifndef AS_PROCESS
	extern int local_mf2_main(LPTHREAD_CNTX);
 #endif
#endif

#include "garver.h"
#include "garcomp.h"
#include "nsrccmd.h"
#include "gcini.h"
#include "sttop.h"
#include "argsutils.h"
#include "classes.h"
#include "sources.h"
#include "publish.h"
#include "belongs.h"
#include "complect.h"
#include "refsort.h"
#include "fstringer.h"
#include "loadStringMap.h"
#include "dbproc.m-writer.h"
#include "blobtable.h"
#include "norminfo.h"
#include "indices.h"

#include "FString.long.SplayMap.h"
#include "FString.caddr_t.SplayMap.h"
#include "FString.long.VHMap.h"
#include "FString.FString.SplayMap.h"
#include "FString.SplaySet.h"
#include "FString.VHSet.h"
#include "CaseString.defs.h"
#include "u_int64_t.SplaySet.h"
#include "u_int32_t.VHSet.h"
#include "u_int32_t.SplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "u_int32_t.FString.SplayMap.h"
#include "u_int32_t.FString.VHMap.h"

#include "doccol.h"

#include "shared/Core/os/IniFile.h"

#ifdef __MSVC__
#define __CHECK_TIME__
#endif

#ifdef __CHECK_TIME__
#include <sys/timeb.h>
#endif

#ifdef HAS_WORKING_THREADS
   #include "dbproc.m-to-gkdb.h"
   #include "dbproc.mh-mt.h"
   #include "dbproc.mh-mt-srw.h"
   #include "stdbase.h"
#else
   #include "dbproc.mf.h"
#endif

#include "gc_ver.h"
#include "basemask.h"
#include "recode.h"

bool b_english_base = false;
bool bIgnoreFatal = false;
bool b_recode = true;
bool b_inpharm = false;
bool bIgnoreTvsErrors = false;

extern	std::deque<std::string> errors;
char* kwFile = 0;

extern	void	gc_SetLicence( PagedFile* pNDT, int max_profiles, int max_num, int max_perm);

struct nsrc2mParams {
  nsrcParser *np;
  ThreadCompileInfo *tcinfo;
};

#ifdef	JUST_CHECKER
bool bEnglish = false;
#endif
extern bool bEnglish; // see libs/gc/src/glproc.cpp
extern bool bIgnoreFatal; // see libs/gc/src/glproc.cpp
extern	bool bIgnoreTvsErrors;
extern	bool	b_recode;
bool b5Context = false;
bool b_fastfakeattrs = false;	

#ifdef OLD_MAP
	longSplaySet	hereBelongs;
#else
	GSubMap hereBelongs(0);
#endif

BaseCore* basesInfo;

static FStringlongSplayMap *getSources(const char *catFile);
static void usage( const char *);
static void setToday();
static int readWarningsMap ( const char *fn, ThreadCompileInfo* );
static int readFStringsSet ( FStringSplaySet &dst, const char *fn);
static void flushBaseInfo(ThreadCompileInfo *inf);
static void flushBasesWeights(ThreadCompileInfo *inf);
static void setBaseClassInfo(ThreadCompileInfo *inf);
static void setBasePrefixInfo(ThreadCompileInfo *inf);
static void writeRespsCorrs(ThreadCompileInfo *inf);
static void generateRefTable(ThreadCompileInfo& tcinfo, GCParameters *p);
static int readRefTable(ThreadCompileInfo& tcinfo, GCParameters *p);
static int readTerritoryFile( SourcesInfo *si, const char *tf );
static int readObjTypes(ThreadCompileInfo& tcinfo, GCParameters *p);


int procKWfile(ThreadCompileInfo *, const char *kwstream);

extern int bWdoRefDocCheck;

extern date maxDate;
extern date todayDate;
extern date prevSatDate;
extern date satDate;

void writeRespsCorrs(ThreadCompileInfo *inf)
{
	DbProcessor *dbproc=inf->dbproc;
	Pix i;

	for( i=inf->corrs->first();i;inf->corrs->next(i)) {
		long docid = inf->corrs->key(i);
		if (inf->notADocs->contains(docid) && !std::binary_search (inf->editions->begin (), inf->editions->end (), docid))
			continue;

#ifdef OLD_MAP
		u_int64_tSplaySet *st = (u_int64_tSplaySet*) (inf->corrs->contents(i));
#else
		GRefMap *st = &(inf->corrs->contents(i));
#endif

		int n = st->length();
		if( !n ){
#ifdef OLD_MAP
			delete st;
#else
			st->kill_root();
#endif
			inf->corrs->del(i);
			continue;
		}

		u_int64_t *buf = (u_int64_t*)malloc( sizeof(u_int64_t)*n );
		n = 0;
		for( Pix ii=st->first(); ii; st->next(ii) ) {
			Ref2Int64 rf;
			rf.asint = (*st)(ii);
			if (!inf->notADocs->contains(rf.asref.docid) || std::binary_search (inf->editions->begin (), inf->editions->end (), rf.asref.docid))
				buf[n++] = (*st)(ii);
		}

		if (n) {
			qsort(buf,n,sizeof(Ref),(int(*)(const void*, const void*))CompRefs);
			dbproc->setCorrs(docid,buf,n);
		}
		free(buf);
	}


	for( i=inf->resps->first();i;inf->resps->next(i)) {
		long docid = inf->resps->key(i);
		if (inf->notADocs->contains(docid) && !std::binary_search (inf->editions->begin (), inf->editions->end (), docid))
			continue;

#ifdef OLD_MAP
		u_int64_tSplaySet *st = (u_int64_tSplaySet*)
#else
		GRefMap *st = &
#endif
													(inf->resps->contents(i));
		int n = st->length();
		if( !n ){
#ifdef OLD_MAP
			delete st;
#else
			st->kill_root();
#endif
			inf->resps->del(i);
			continue;
		}

		u_int64_t *buf = (u_int64_t*)malloc( sizeof(u_int64_t)*n );
		n = 0;
		for( Pix ii=st->first(); ii; st->next(ii) ) {
			Ref2Int64 rf;
			rf.asint = (*st)(ii);
			if (!inf->notADocs->contains(rf.asref.docid) || std::binary_search (inf->editions->begin (), inf->editions->end (), rf.asref.docid))
				buf[n++] = (*st)(ii);
		}

		if (n) {
			qsort(buf,n,sizeof(Ref),(int(*)(const void*, const void*))CompRefs);
			dbproc->setTopicResps(docid,buf,n);
		}
		free(buf);
	}
}

FStringlongSplayMap *getSources(const char *catFile)
{
	struct stat st;
	FStringlongSplayMap *srcs = new FStringlongSplayMap(0);

	FileStringer fst( catFile );
	if( !fst.OK() ){
		gclog.noHdr();
		gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Ó≈ Õœ«’ œ‘À“Ÿ‘ÿ CatFile %s\n", catFile);
		return 0;
	}
	int cl=0;
	const char *buf;
	int l;
	gclog.setFileName( catFile );

	while( (buf=fst.gets(l)) != 0 ){
		gclog.setLN( ++cl );
		if( !l  || buf[0] == ';' )
			continue;
		FString n(buf,l);n.bDoFree = 1;
		if( stat(n.chars(), &st) == 0 ) {
			if( access(n.chars(), 4 ) == 0 ) {
				(*srcs)[n] = st.st_size;
				n.bDoFree = 0;
			} else {
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,"Ó≈‘ ƒœ”‘’–¡ À %s: %s\n", n.chars(), strerror(errno) );
			}
		} else {
			gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "Ó≈ Õœ«’ –œÃ’ﬁ…‘ÿ ”‘¡‘…”‘…À’ ƒÃ— %s: %s\n", n.chars(), strerror(errno) );
		}
	}
	if( !srcs->length() ){
		delete srcs;
		return 0;
	}
	return srcs;
}

void usage(const char *nm){
	printf("GARANT Base compiler v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
	printf("Usage is:\n%s ini-file\n", nm);
}

int _compare_int16_t( const void *arg1, const void *arg2 )
{
   return ((*(int16_t*)arg1)-(*(int16_t*)arg2));
}

static void setHereBases(ThreadCompileInfo*inf, GCParameters &p)
{
	int16_t *hereBases = new int16_t[p.here_info.nbelongs];
	for(int i=0; i<p.here_info.nbelongs; i++ ){
		hereBases[i] = p.here_info.belongs[i];
	}

	qsort((void *)hereBases,(size_t)p.here_info.nbelongs,sizeof(int16_t),_compare_int16_t);

	inf->dbproc->writeAux("Here", hereBases, 
					p.here_info.nbelongs*sizeof(int16_t) );
	delete hereBases;
}

int readWarningsMap ( const char * fn, ThreadCompileInfo *inf )
{
	FString sdflt("no such warning");
	u_int32_tFStringSplayMap tm(sdflt);

	int cl=0;
	const char *buf;
	int l;

	inf->warningMap = new u_int32_tFStringVHMap(sdflt,10);

	FileStringer fst( fn );
	if( !fst.OK() ){
		gclog.noHdr();
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Ó≈ Õœ«’ œ‘À“Ÿ‘ÿ %s\n", fn);
		return 1;
	}
	gclog.setFileName( fn );
	while( (buf=fst.gets(l)) != 0 ){
		gclog.setLN( ++cl );
		if( l < 2 || buf[0] == ';' ){
			continue;
		}
		const char* p = buf;
		while (*p == ' ' || *p == '\t') p++;
		if (*p < '0' || *p > '9')
		{
			gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,
				"Ó≈◊≈“ŒŸ  ∆œ“Õ¡‘ ”‘“œÀ…\n");
			continue;
		}
		u_int32_t id = atoi( p );
		while (*p >= '0' && *p <= '9') p++;
		if (*p != ' ' && *p != '\t')
		{
			gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,
				"Ó≈◊≈“ŒŸ  ∆œ“Õ¡‘ ”‘“œÀ…\n");
			continue;
		}
		while (*p == ' ' || *p == '\t') p++;
		const char* q = buf + l - 1;
		while (*q == ' ' || *q == '\t') q--;

		FString ucs(p,q-p+1);
		tm[id] = ucs;
	}
	if( tm.length() ){
		inf->warningMap->clear();
		inf->warningMap->resize(VHMAPREALSIZE(tm.length()));
		for(Pix i=tm.first();i;tm.next(i)){
			FString t = tm.contents(i);
			(*(inf->warningMap))[tm.key(i)]=t ;

		}
	}
	return inf->warningMap->length() == 0;
}

void setToday()
{
	time_t now = time(0);
	struct tm *tmnow = localtime( &now );
	todayDate.da_year = tmnow->tm_year + 1900;
	todayDate.da_mon = tmnow->tm_mon +1;
	todayDate.da_day = tmnow->tm_mday +1;

	int n = (tmnow->tm_wday + 1) % 7;
	now -= n * 3600 * 24;
	tmnow = localtime( &now );
	prevSatDate.da_year = tmnow->tm_year + 1900;
	prevSatDate.da_mon = tmnow->tm_mon +1;
	prevSatDate.da_day = tmnow->tm_mday;

	now += 7 * 3600 * 24;
	tmnow = localtime( &now );
	satDate.da_year = tmnow->tm_year + 1900;
	satDate.da_mon = tmnow->tm_mon+1;
	satDate.da_day = tmnow->tm_mday;
}

static void setDefaultParams(GCParameters &p)
{
	bzero((caddr_t)&p, sizeof(GCParameters) );
	p.do_stdout = 1;
	p.ref_doc_check = 1;
	p.ref_vincluded_check = 1;
	p.fatal_ifnotinbelongs = 0;
	p.iniSbrf = 0;
	p.name_len_check = 1;
	p.text_command_check = 1;
	p.print_prefix_ex = 0;
	p.sub_title_check = 0;
	p.ref_table_gen = 0;
	p.extrn_ref_fatal = 1;
}

static int checkParams(GCParameters &p)
{
	if( ! p.here_info.nbelongs ){
		fprintf(stderr,"No Here bases.\n");
		return 1;
	}
	for(int i=0; i<p.here_info.nbelongs; i++ ){
		if( p.here_info.belongs[i] < 1 ||
			p.here_info.belongs[i] >= MAX_BASES ){

			fprintf(stderr,"Bad base id %d.\n", p.here_info.belongs[i]);
			return 1;
		}
	}
#define CHECKFILERD(a,b) if( !p.a ){ \
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "%s file must be specified.\n", b);\
							exit(1);\
						} \
						if( access(p.a,4) ){ \
							gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "%s file %s can't be ace_os_read (%s).\n",\
							b,p.a,strerror(errno));\
							exit(1); \
						}

#define CHECKFILERD2(a,b) if( p.a ){ \
								if( access(p.a,4) ){ \
									gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "%s file %s can't be read (%s).\n",\
									b,p.a,strerror(errno));\
									exit(1); \
								} \
						}

	CHECKFILERD(belongsMapFile,"Belongs table")
	CHECKFILERD(weightsTableFile,"Complects info file")
	CHECKFILERD(classFile,"Class list")
	CHECKFILERD(kindFile,"Kind list")
	CHECKFILERD(typesFile,"Types list")
#ifdef	VERSION62
	CHECKFILERD2(inpharmFirmsFile,"InpharmFirms list")
	CHECKFILERD2(inpharmCountriesFile,"InpharmCountries list")
	CHECKFILERD2(inpharmPharmGroupsFile,"InpharmPharmGroups list")
	CHECKFILERD2(inpharmPharmEffectsFile,"InpharmPharmEffects list")
	CHECKFILERD2(inpharmMkbsFile,"InpharmMkbs list")
	CHECKFILERD2(inpharmChaptersFile,"InpharmChapters list")
	CHECKFILERD2(inpharmAtcsFile,"InpharmAtcs list")
	CHECKFILERD2(inpharmRegStatusesFile,"InpharmRegStatuses list")
	CHECKFILERD2(inpharmLekFormsFile,"InpharmLekForms list")
	CHECKFILERD2(annoUserFile,"AnnoUser list")
	CHECKFILERD2(annoOrganizationFile,"AnnoOrganization list")
	CHECKFILERD2(annoTaxFile,"AnnoTax list")
	CHECKFILERD2(annoInterestFile,"AnnoInterest list")
	CHECKFILERD2(annoKindFile,"AnnoKind list")
#endif
	CHECKFILERD2(serviceInfoFile,"ServiceInfo list")
	CHECKFILERD(territoryFile,"Territory list")
	CHECKFILERD(sourcesFile,"Sources list")
	CHECKFILERD(pubSourceFile,"Valid publication sources list")
	CHECKFILERD(warningsFile,"Warnings map")
	CHECKFILERD(normFile,"Norm/Category File")
	CHECKFILERD(catFile,"NSRC set")
	CHECKFILERD(priorityTableFile,"Priority table");

	if( p.mfCompress < 0 || p.mfCompress > 9 ){
		fprintf(stderr,"MFCompress level must be in range 0-9.\n");
		fprintf(stderr,"Setting to 3.\n");
		p.mfCompress = 3;
	}
	return 0;
}

static void *m2gkdb(void *arg)
{
	return 0;
}

void *nsrc2m( void *arg )
{
	nsrcParser *np = ((struct nsrc2mParams *)arg)->np;
	ThreadCompileInfo *tcinfo = ((struct nsrc2mParams *)arg)->tcinfo;
	Pix i;
  
	u_int64_t totalSourcesSize = 0;
	for(i= tcinfo->Sources->first(); i; tcinfo->Sources->next(i))
		totalSourcesSize += (u_int64_t) tcinfo->Sources->contents(i);

	u_int64_t sourcesDone = 0;
	time_t startTime = time(0);
#ifndef linux
	gclog.noHdr();
	gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "˜‘œ“œ  –“œ»œƒ Œ¡ﬁ¡‘ ◊ %s\n", ctime(&startTime));
#endif

	int cl =0;
	for(i= tcinfo->Sources->first(); i; tcinfo->Sources->next(i) ){
		const char* nsrc_filename = tcinfo->Sources->key(i).chars();
		gclog.setFileName (nsrc_filename);
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Ô¬“¡¬œ‘À¡ ∆¡ Ã¡ %s\n", tcinfo->Sources->key(i).chars());
		FileStringer fst( tcinfo->Sources->key(i).chars() );
		if( !fst.OK() ){
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Ó≈ Õœ«’ œ‘À“Ÿ‘ÿ ∆¡ Ã %s\n", tcinfo->Sources->key(i).chars());
			continue;
		}
		cl = 0;
		const char *buf;
		int l;
		while( (buf=fst.gets(l)) != 0 ){
			gclog.setLN( ++cl );
			if ( l && buf[0] == ';' )
				continue;
			np->addLine (buf, l, nsrc_filename, cl);
		}

		np->flush();
		sourcesDone += tcinfo->Sources->contents(i);
		time_t el_t = time(0) - startTime;
		if( !el_t ) el_t =1;
		if( !sourcesDone ) sourcesDone =1;
		time_t est_t =(time_t) (((double)totalSourcesSize/sourcesDone)*el_t); 

		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Ô¬“¡¬œ‘À¡ ∆¡ Ã¡ ⁄¡◊≈“€≈Œ¡.\n");
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "“…Õ≈“Œœ≈ ◊“≈Õ— œÀœŒﬁ¡Œ…— ÀœÕ–…Ã—√…… ﬁ≈“≈⁄ %d ”≈À.\n", est_t - el_t);
	}
	if (tcinfo->additional_file_strings->size ()) {
		std::deque<std::string>::const_iterator str_it = tcinfo->additional_file_strings->begin ();
		std::deque<std::pair<long,std::string> >::const_iterator source_it = tcinfo->additional_source->begin ();
		for (; str_it != tcinfo->additional_file_strings->end (); str_it++, source_it++) {
			gclog.setFileName (source_it->second.c_str ());
			gclog.setLN (source_it->first);
			std::string str = *str_it;
			np->addLine (str.c_str (), str.size (), "$dummy$", 0);
		}
		np->flush();
	}

	if (kwFile) {
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Èƒ≈‘ œ¬“¡¬œ‘À¡ kw-∆¡ Ã¡\n");
		procKWfile (tcinfo, kwFile);
		gclog.printfC (AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_WIN, "Œ·‡·ÓÚÍ‡ kw-Ù‡ÈÎ‡ Á‡‚Â¯ÂÌ‡\n");
	}

#ifdef	BLOCKSINHERIT
	for ( i = np->typeSet.first(); i; np->typeSet.next(i) )
		delete np->typeSet.contents(i);
	np->typeSet.clear();
#endif
   return 0;
}

void generateRefTable(ThreadCompileInfo& tcinfo, GCParameters *p)
{
	if (!p->outRTFile)
		return ;

	if (!p->ref_table_gen)
		return ;

	FILE* f = mpcxc_fopen(p->outRTFile,"w");
	if (!f) {
		gclog.noHdr();
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Ó≈◊œ⁄Õœ÷Œœ œ‘À“Ÿ‘ÿ Œ¡ ⁄¡–…”ÿ '%s'\n", p->outRTFile);
		return;
	}
	
	for (std::map<long,long*>::const_iterator it = tcinfo.map_doc_subs->begin (); it != tcinfo.map_doc_subs->end (); it++) {
		long id = it->first;
		if (tcinfo.blobs->contains(id))
			continue;

		fprintf(f, "%ld", id);
		if (tcinfo.notADocs->contains(id))
			fprintf(f, " N\n");
		else
			fprintf(f, "\n");

		for (long i = 0, *data = it->second, *ptr = data+1; i < *data; i++, ptr++)
			fprintf(f, "\t%ld\n", *ptr);
	}

	fclose(f);
}

int readTerritoryFile( SourcesInfo *si, const char *tf )
{
	FString aaa("");
	GFStringFStringMap *tmp = new GFStringFStringMap(aaa);
	if( loadStringMap(tmp, tf, ADOPTED_KEY_SIZE )) {
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_KOI,
			"cant load territory file\n");
		delete tmp;
		return 1;
	}
	si->territoryCount = tmp->length();
	if( !si->territoryCount ) {
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_KOI,
			"cant load territory file\n");
		delete tmp;
		return 1;
	}
	si->tinfo = (SourcesInfo::TerritoryInfo*)malloc(si->territoryCount * sizeof(SourcesInfo::TerritoryInfo));

	int I =0;
	si->tm = new CaseStringlongSplayMap(-1);
	for( Pix i=tmp->first(); i; tmp->next(i), I++){
		FString k = tmp->key(i);
		FString d = tmp->contents(i);
		(*(si->tm))[k] = I;
		si->tinfo[I].territoryName = (char*) d.chars();
		si->tinfo[I].nameLength = d.length()+1;
	}
	delete tmp;

	return 0;
}

int readObjTypes(ThreadCompileInfo& tcinfo, GCParameters *p)
{
	CaseStringlongSplayMap *oTypes = new CaseStringlongSplayMap(0);
	
	FileStringer fst(p->objTypesFile);
	if (!fst.OK()) {
		gclog.noHdr();
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, 
			"ÕÂ‚ÓÁÏÓÊÌÓ ÓÚÍ˚Ú¸ Ù‡ÈÎ ˝Ú‡ÎÓÌÌ˚ı ÚËÔÓ‚ Ó·˙ÂÍÚÓ‚: '%s'. œÓ‚Â¸ÚÂ Ô‡‚ËÎ¸ÌÓÒÚ¸ Ô‡‡ÏÂÚ‡ 'ObjTypesFile' ‚ Ù‡ÈÎÂ 'gcini'\n",
			p->objTypesFile);
		return 0;
	}
	gclog.setFileName(p->objTypesFile);
	
	const char *buf;
	int l;
	int cl = 0;
	while((buf = fst.gets(l)) != 0) {
		gclog.setLN(++cl);
		const char* s = buf;
		if (s[0] == ';' || s[0] == '#')
			continue;
		
		const char* q = strchr(s,':');
		if (q && l >= (q-s)) l = q-s;

		if (l > 4) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Ó¡⁄◊¡Œ…≈ ‘…–¡ Œ≈ Õœ÷≈‘ ¬Ÿ‘ÿ ƒÃ…ŒŒ≈≈ 4 ”…Õ◊œÃœ◊\n");
			continue;
		}
		
		FString t(s,l);
		
		unsigned long typeCode = 0;
		unsigned char* tp = (unsigned char*)(&typeCode);
		if (l > 3) tp[0] = *(s+l-4); else tp[0] = 0;
		if (l > 2) tp[1] = *(s+l-3); else tp[1] = 0;
		if (l > 1) tp[2] = *(s+l-2); else tp[2] = 0;
		if (l > 0) tp[3] = *(s+l-1); else tp[3] = 0;
		
		if (oTypes->contains(t))
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Duplicated type %s\n", t.chars());
		else
			(*oTypes)[t] = typeCode;
	}
	tcinfo.objTypes = oTypes;
	return 1;
}

int readRefTable(ThreadCompileInfo& tcinfo, GCParameters *p)
{
	FStringSplaySet *infs = p->inRTFile;
	
	if (!infs) {
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_KOI, "Ó≈ ’À¡⁄¡Œ ∆¡ Ã ‘¡¬Ã…√Ÿ ◊Œ≈€Œ…» ””ŸÃœÀ.\n");
		return 0;
	}
	int wasDupes = 0;
	std::set<long> subs;

	DocCollection tvs_topics;

	for( Pix i=infs->first(); i; infs->next(i) ){
		const char *name = ((*infs)(i)).chars();
		FileStringer fst(name);
		if (!fst.OK()) {
			gclog.noHdr();
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Ó≈◊œ⁄Õœ÷Œœ œ‘À“Ÿ‘ÿ Œ¡ ﬁ‘≈Œ…≈ '%s'\n", name);
			continue;
		}
		gclog.setFileName(name);
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "˛‘≈Œ…≈ ‘¡¬Ã…√Ÿ ◊Œ≈€Œ…» ””ŸÃœÀ.\n");

		const char *buf;
		int l;
		int cl = 0;
		long cnt = -1;
		while((buf = fst.gets(l)) != 0) {
			gclog.setLN(++cl);
			const char* s = buf;
			
			if (*s >= '0' && *s <= '9') {
				//‚ÒÚ‡‚ËÚ¸
				if (cnt != -1) {
					if (subs.size () > 1) {
						//ÂÒÚ¸ Ò‡·˚ ÍÓÏÂ ÌÛÎÂ‚Ó„Ó
						long *data = new long [subs.size () + 1], *ptr = data;
						*ptr++ = subs.size ();
						for (std::set<long>::const_iterator it = subs.begin (); it != subs.end (); it++, ptr++)
							*ptr = *it;
						tcinfo.map_doc_subs->insert (std::map<long,long*>::value_type (cnt, data));
					}
				}

				subs.clear ();
				cnt = atoi(s);
				if ((tcinfo.map_doc_subs->find (cnt) != tcinfo.map_doc_subs->end ()) || (tvs_topics.IndexOf (&cnt) != -1)) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Duplicated topic %d\n", cnt-100000);
					if (!bIgnoreTvsErrors) wasDupes =1;
				} else {
					tvs_topics.Insert (&cnt);
				}
				while (*s >= '0' && *s <= '9') s++;
				while (*s == ' ' || *s == '\t') s++;
				if (*s == 'N')
					tcinfo.notADocs->add(cnt);
			} else if (*s == ' ' || *s == '\t') {
				while (*s == ' ' || *s == '\t') s++;
				if (*s < '0' || *s > '9') {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "Ô€…¬À¡ ∆œ“Õ¡‘¡.\n", buf);
				}
				if (cnt == -1) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "ÓœÕ≈“ ”¡¬¡ ¬≈⁄ ŒœÕ≈“¡ ‘œ–…À¡.\n");
					continue;
				}
				long sub = atoi (s);
				subs.insert (sub);
			} else {
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "Ô€…¬À¡ ∆œ“Õ¡‘¡.\n", buf);
			}
		}
	}

	if( wasDupes && p->extrn_ref_fatal ){
		gclog.noHdr();
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "ÎœÕ–…Ã—√…— –“≈“◊¡Œ¡ - –œ◊‘œ“—¿›…≈”— ‘œ–…À….\n");
		exit(1);
	}

	tcinfo.topic_tvstopics_count = tvs_topics.ItemCount;
	tcinfo.topic_tvstopics = new long [tcinfo.topic_tvstopics_count];
	long* ptr = tcinfo.topic_tvstopics;
	for (int i = 0; i < tcinfo.topic_tvstopics_count; i++, ptr++)
		*ptr = tvs_topics [i];

	return 0;
}

static void dumpParams(GCParameters &p, AdvLogger &log)
{
	log.noHdr();
	log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "˙¡–’›≈Œ ”œ ”Ã≈ƒ’¿›…Õ… –¡“¡Õ≈‘“¡Õ…:\n");
	log.noHdr();
	log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "ÈÕ— ◊Ÿ»œƒŒœ«œ ∆¡ Ã¡: %s\n", p.outName);
	log.noHdr();
	log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "ÈÕ— belongs-∆¡ Ã¡: %s\n", p.belongsMapFile);
	log.noHdr();
	log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "ÈÕ— cat-∆¡ Ã¡: %s\n", p.catFile );
	if (p.ref_table_gen) {
		log.noHdr();
		log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI,"Á≈Œ≈“…“œ◊¡‘ÿ ‘¡¬Ã…√’ ””ŸÃœÀ: ƒ¡.\n");
	} else {
		log.noHdr();
		log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI,"Á≈Œ≈“…“œ◊¡‘ÿ ‘¡¬Ã…√’ ””ŸÃœÀ: Œ≈‘.\n");
	}

	if( p.kwFile && access(p.kwFile, 4) == 0 ){
		log.noHdr();
		log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "ÎÃ¿ﬁ≈◊Ÿ≈ ”Ãœ◊¡ ﬁ…‘¡¿‘”— …⁄ ∆¡ Ã¡ '%s'.\n", p.kwFile );
	}else{
		log.noHdr();
		log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "ÎÃ¿ﬁ≈◊Ÿ≈ ”Ãœ◊¡ Œ≈ ⁄¡ƒ¡ŒŸ …Ã… Œ≈◊œ⁄Õœ÷Œœ Œ¡ ‘… ∆¡ Ã.\n");
	}
}

void localrev_adddays ( revision& theRev, const int days ) 
{ 
	time_t atime; 
	struct tm atm; 
	struct tm *ptm; 
	memset( &atm, 0, sizeof( atm )); 
	atm.tm_year = theRev.RevisionDate.da_year - 1900; 
	atm.tm_mday = theRev.RevisionDate.da_day; 
	atm.tm_mon  = theRev.RevisionDate.da_mon - 1; 
	atime = mktime( &atm ); 
	atime += (long)days * 24l * 3600l; 
	ptm   = localtime( &atime ); 
	theRev.RevisionDate.da_year = ptm -> tm_year + 1900; 
	theRev.RevisionDate.da_day = ptm -> tm_mday; 
	theRev.RevisionDate.da_mon = ptm -> tm_mon + 1;	 
} 
 
revision today_rev;
unsigned char *paraFinalBuf= 0;
#ifdef PTRS_IN_META
  #ifdef PTRS_ONLY
	unsigned char							*exportBuf= 0;
  #else
	unsigned char one_exportBuf[128*1024],	*exportBuf= one_exportBuf;
  #endif
#endif

int local_main_PRE(
#ifdef PTRS_IN_META
					LPTHREAD_CNTX pCntxt
#else
					ThreadCompileInfo *tcinfo, GCParameters *params, int argc, char **argv
#endif
					)
{
	Pix i;
	
#ifdef WITH_DBL_THREAD
	ThreadCompileInfo *tcinfo= (ThreadCompileInfo *)(pCntxt->PThreadCompileInfo);
	GCParameters *params= (GCParameters *)(pCntxt->PGCParameters);

    int argc= pCntxt->l_argc;
    char **argv= pCntxt->l_argv;
#endif

	FString :: init_tr();

	setDefaultParams(*params);

	if( strcmp(argv[1],"-") == 0 ){
		if( readParams( params, stdin) != 0 ){
			fprintf(stderr,"Read parameters failed.\n");
			return 1;
		}
	}else{
		for ( int i = 1; i < argc; i++ ) {
			if ( argv[i][0] == '-' ) {
				if (argv [i][1] == 'f')
					b_fastfakeattrs = true;
				else if ( argv[i][1] == '5' )
					b5Context = false;
				else if ( argv[i][1] == 't' )
					bIgnoreTvsErrors = true;
				else if ( argv[i][1] == 'i' )
					bIgnoreFatal = true;
				else if ( argv[i][1] == 'e' )
					bEnglish = true;
			} else {
				FILE *pf = mpcxc_fopen(	argv[i],
		#if defined(__CYGWIN32__) || defined(__GO32__) || defined(__MSVC__)
									"rb"
		#else
									"r"
		#endif
					);
				if( !pf ){
					fprintf(stderr,"Can't open parameters file %s.\n", argv[1]);
					return 1;
				}
				if( readParams( params, pf )){
					fprintf(stderr,"Read parameters failed.\n");
					fclose(pf);
					return 1;
				}
		 #ifdef WITH_DBL_THREAD
			params->mfCompress= 0;
		 #endif
				fclose(pf);
			}
		}
	}
	if( checkParams(*params) != 0 ){
		return 1;
	}
	if (params->logFile) {
		char buf[1024];
		sprintf( buf,"%s.log", params->outName );
		gclog.setLogName(errors, params->logFile, buf);
		if (!params->ref_doc_check)
			errors.push_back ("«Ì‡˜ÂÌËÂ CheckReference ‡‚ÌÓ Off");
	} else{
		char buf[1024];
		sprintf( buf,"%s.log", params->outName );
		gclog.setLogName( buf );
	}
	if (params->logEncoding) {
		if (!strcasecmp(params->logEncoding, "win")) 
			gclog.setDestCoding(AdvLogger::CD_WIN);
		else
		if (!strcasecmp(params->logEncoding, "koi")) 
			gclog.setDestCoding(AdvLogger::CD_KOI);
		else
		if (!strcasecmp(params->logEncoding, "dos")) 
			gclog.setDestCoding(AdvLogger::CD_ALT);
		else
		if (!strcasecmp(params->logEncoding, "mac")) 
			gclog.setDestCoding(AdvLogger::CD_MAC);
		else {
			gclog.printf (errors, AdvLogger::LOG_ERROR, "Unknown log encoding %s.\n", params->logEncoding);
		}
	}
	gclog.noHdr();
	dumpParams(*params, gclog);
	bWdoRefDocCheck = params->ref_doc_check;
	int e = 1;

	bzero((caddr_t)tcinfo, sizeof(*tcinfo) );
	tcinfo->ref_doc_check = params->ref_doc_check;
	tcinfo->ref_vincluded_check = params->ref_vincluded_check;
	tcinfo->fatal_ifnotinbelongs = params->fatal_ifnotinbelongs;
	tcinfo->name_len_check = params->name_len_check;
	tcinfo->text_command_check = params->text_command_check;
	tcinfo->iniSbrf = params->iniSbrf;
	tcinfo->print_prefix_ex = params->print_prefix_ex;
	tcinfo->sub_title_check = params->sub_title_check;
	tcinfo->TopicRanges = params->TopicRanges;
	tcinfo->LoTopicRanges = params->LoTopicRanges;
	tcinfo->HiTopicRanges = params->HiTopicRanges;

	if( !params->objRoot ){
		params->objRoot = strdup("./");
	} else {
		if (!strcmp (params->objRoot, "?")) {
			params->objRoot = 0;
		} else {
			for (char* q = strchr(params->objRoot,'\\');q;q = strchr(q,'\\')) *q = '/';
			if (params->objRoot [0] != '/' && strncmp(params->objRoot,"./",2) && !strchr(params->objRoot,':')) {
				char* p = params->objRoot;
				params->objRoot = (char*)malloc(strlen(p)+3);
				strncpy(params->objRoot,"./",2);
				if (p[0] == '/') strcpy(params->objRoot+2,p+1);
				else strcpy(params->objRoot+2,p);
				free(p);
			}
		}
	}
	tcinfo->objRoot = params->objRoot;
	setToday();
	if( params->revDate ){
		gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "ı”‘¡Œ¡◊Ã…◊¡≈Õ revision …⁄ –¡“¡Õ≈‘“¡ ini-∆¡ Ã¡\n");
		if( ! getDate( params->revDate, strlen(params->revDate), tcinfo->rtoday.RevisionDate ) ){
			gclog.noHdr();
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Ó≈◊≈“ŒŸ  ∆œ“Õ¡‘ REVISION.\n");
			return 1;
		}
	}else{
		tcinfo->rtoday.RevisionDate = todayDate;
	}

	if ( params->iniSatDate ) {
		gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "”ÒÚ‡Ì‡‚ÎË‚‡ÂÏ ‰‡ÚÛ ÒÛ··ÓÚ˚ ËÁ Ô‡‡ÏÂÚ‡ SatDate ini-Ù‡ÈÎ‡\n");
		date newSatDate;
		if( !getDate( params->iniSatDate, strlen(params->iniSatDate), newSatDate ) ){
			gclog.noHdr();
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "ÕÂ‚ÂÌ˚È ÙÓÏ‡Ú SatDate.\n");
			return 1;
		} else {
			satDate = newSatDate;
			revision prev;
			gk_bzero(&prev,sizeof(prev));
			prev.RevisionDate = satDate;
			localrev_adddays(prev,-7);
			prevSatDate = prev.RevisionDate;
		}
	}
	
	if ( params->iniTodayDate ) {
		gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "”ÒÚ‡Ì‡‚ÎË‚‡ÂÏ ÒÂ„Ó‰Ìˇ¯Ì˛˛ ‰‡ÚÛ ËÁ Ô‡‡ÏÂÚ‡ TodayDate ini-Ù‡ÈÎ‡\n");
		date newTodayDate;
		if( !getDate( params->iniTodayDate, strlen(params->iniTodayDate), newTodayDate ) ){
			gclog.noHdr();
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "ÕÂ‚ÂÌ˚È ÙÓÏ‡Ú TodayDate.\n");
			return 1;
		} else {
			todayDate = newTodayDate;
		}
	}
	if ( params->iniMaxDate ) {
		gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "”ÒÚ‡Ì‡‚ÎË‚‡ÂÏ Ï‡ÍÒËÏ‡Î¸ÌÛ˛ ‰‡ÚÛ ËÁ Ô‡‡ÏÂÚ‡ MaxDate ini-Ù‡ÈÎ‡\n");
		date newMaxDate;
		if( !getDate( params->iniMaxDate, strlen(params->iniMaxDate), newMaxDate ) ){
			gclog.noHdr();
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "ÕÂ‚ÂÌ˚È ÙÓÏ‡Ú MaxDate.\n");
			return 1;
		} else {
			maxDate = newMaxDate;
		}
	}
	
	if( !(tcinfo->Sources=getSources(params->catFile)) ){
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "Ó≈◊≈“ŒŸ  ∆œ“Õ¡‘ REVISION.\n");
		return 1;
	}

	FString aaa("");
	tcinfo->topicTypes = new GFStringFStringMap(aaa);
	if( loadStringMap(tcinfo->topicTypes, params->typesFile, TYPE_KEY_SIZE )) {
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "Ó≈ Õœ«’ –“œﬁ…‘¡‘ÿ ∆¡ Ã ”œ ”–…”ÀœÕ ‘…–œ◊: %s\n", strerror(e));
		return 1;
	}

#ifdef	VERSION62
	tcinfo->topicInpharmFirms = new GFStringFStringMap(aaa);
	if( params->inpharmFirmsFile) {
		if( loadStringMap (tcinfo->topicInpharmFirms, params->inpharmFirmsFile, INPHARM_FIRM_SIZE)) {
			gclog.noHdr();
			gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "ÕÂ ÏÓ„Û ÔÓ˜ËÚ‡Ú¸ Ù‡ÈÎ ÒÓ ÒÔËÒÍÓÏ \"‘ËÏ˚\" ‰Îˇ »ÌÙ‡Ï‡: %s\n", strerror(e));
			return 1;
		}
	}

	tcinfo->topicInpharmCountries = new GFStringFStringMap(aaa);
	if( params->inpharmCountriesFile) {
		if( loadStringMap (tcinfo->topicInpharmCountries, params->inpharmCountriesFile, INPHARM_COUNTRY_SIZE)) {
			gclog.noHdr();
			gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "ÕÂ ÏÓ„Û ÔÓ˜ËÚ‡Ú¸ Ù‡ÈÎ ÒÓ ÒÔËÒÍÓÏ \"—Ú‡Ì˚\" ‰Îˇ »ÌÙ‡Ï‡: %s\n", strerror(e));
			return 1;
		}
	}

	tcinfo->topicInpharmPharmGroups = new GFStringFStringMap(aaa);
	if( params->inpharmPharmGroupsFile) {
		if( loadStringMap (tcinfo->topicInpharmPharmGroups, params->inpharmPharmGroupsFile, INPHARM_PHARMGROUP_SIZE, true)) {
			gclog.noHdr();
			gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "ÕÂ ÏÓ„Û ÔÓ˜ËÚ‡Ú¸ Ù‡ÈÎ ÒÓ ÒÔËÒÍÓÏ \"‘‡Ï√ÛÔÔ˚\" ‰Îˇ »ÌÙ‡Ï‡: %s\n", strerror(e));
			return 1;
		}
	}

	tcinfo->topicInpharmPharmEffects = new GFStringFStringMap(aaa);
	if( params->inpharmPharmEffectsFile) {
		if( loadStringMap (tcinfo->topicInpharmPharmEffects, params->inpharmPharmEffectsFile, INPHARM_PHARMGROUP_SIZE, true)) {
			gclog.noHdr();
			gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "ÕÂ ÏÓ„Û ÔÓ˜ËÚ‡Ú¸ Ù‡ÈÎ ÒÓ ÒÔËÒÍÓÏ \"‘‡Ï›ÙÙÂÍÚ˚\" ‰Îˇ »ÌÙ‡Ï‡: %s\n", strerror(e));
			return 1;
		}
	}

	tcinfo->topicInpharmMkbs = new GFStringFStringMap(aaa);
	if( params->inpharmMkbsFile) {
		if( loadStringMap (tcinfo->topicInpharmMkbs, params->inpharmMkbsFile, INPHARM_MKB_SIZE, true)) {
			gclog.noHdr();
			gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "ÕÂ ÏÓ„Û ÔÓ˜ËÚ‡Ú¸ Ù‡ÈÎ ÒÓ ÒÔËÒÍÓÏ \"Ã ¡\" ‰Îˇ »ÌÙ‡Ï‡: %s\n", strerror(e));
			return 1;
		}
	}

	tcinfo->topicInpharmChapters = new GFStringFStringMap(aaa);
	if (params->inpharmChaptersFile) {
		if (loadStringMap (tcinfo->topicInpharmChapters, params->inpharmChaptersFile, INPHARM_CHAPTER_SIZE, true)) {
			gclog.noHdr ();
			gclog.printfC (AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "ÕÂ ÏÓ„Û ÔÓ˜ËÚ‡Ú¸ Ù‡ÈÎ ÒÓ ÒÔËÒÍÓÏ \"–‡Á‰ÂÎ˚¡‡Á˚\" ‰Îˇ »ÌÙ‡Ï‡: %s\n", strerror(e));
			return 1;
		}
	}

	tcinfo->topicInpharmAtcs = new GFStringFStringMap(aaa);
	if (params->inpharmAtcsFile) {
		if (loadStringMap (tcinfo->topicInpharmAtcs, params->inpharmAtcsFile, INPHARM_ATC_SIZE, true)) {
			gclog.noHdr ();
			gclog.printfC (AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "ÕÂ ÏÓ„Û ÔÓ˜ËÚ‡Ú¸ Ù‡ÈÎ ÒÓ ÒÔËÒÍÓÏ \"ATK\" ‰Îˇ »ÌÙ‡Ï‡: %s\n", strerror(e));
			return 1;
		}
	}

	tcinfo->topicInpharmRegStatuses = new GFStringFStringMap(aaa);
	if (params->inpharmRegStatusesFile) {
		if (loadStringMap (tcinfo->topicInpharmRegStatuses, params->inpharmRegStatusesFile, INPHARM_ATC_SIZE)) {
			gclog.noHdr ();
			gclog.printfC (AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "ÕÂ ÏÓ„Û ÔÓ˜ËÚ‡Ú¸ Ù‡ÈÎ ÒÓ ÒÔËÒÍÓÏ \"–Â„—Ú‡ÚÛÒ\" ‰Îˇ »ÌÙ‡Ï‡: %s\n", strerror(e));
			return 1;
		}
	}

	tcinfo->topicInpharmLekForms = new GFStringFStringMap(aaa);
	if (params->inpharmLekFormsFile) {
		if (loadStringMap (tcinfo->topicInpharmLekForms, params->inpharmLekFormsFile, INPHARM_LEKFORM_SIZE, true)) {
			gclog.noHdr ();
			gclog.printfC (AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "ÕÂ ÏÓ„Û ÔÓ˜ËÚ‡Ú¸ Ù‡ÈÎ ÒÓ ÒÔËÒÍÓÏ \"ÀÂÍ‡ÒÚ‚ÂÌÌ˚Â ÙÓÏ˚Ò\" ‰Îˇ »ÌÙ‡Ï‡: %s\n", strerror(e));
			return 1;
		}
	}
	tcinfo->topicAnnoUser = new GFStringFStringMap(aaa);
	if( params->annoUserFile ) {
		if( loadStringMap(tcinfo->topicAnnoUser, params->annoUserFile, CLASS_KEY_SIZE )) {
			gclog.noHdr();
			gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "ÕÂ ÏÓ„Û ÔÓ˜ËÚ‡Ú¸ Ù‡ÈÎ ÒÓ ÒÔËÒÍÓÏ \" ‡ÚÂ„ÓËˇ ÔÓÎ¸ÁÓ‚‡ÚÂÎˇ\" ‰Îˇ ÏÓÌËÚÓËÌ„Ó‚: %s\n", strerror(e));
			return 1;
		}
	}

	tcinfo->topicAnnoOrganization = new GFStringFStringMap(aaa);
	if ( params->annoOrganizationFile ) {
		if( loadStringMap(tcinfo->topicAnnoOrganization, params->annoOrganizationFile, CLASS_KEY_SIZE )) {
			gclog.noHdr();
			gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "ÕÂ ÏÓ„Û ÔÓ˜ËÚ‡Ú¸ Ù‡ÈÎ ÒÓ ÒÔËÒÍÓÏ \"ŒÒÓ·ÂÌÌÓÒÚË Ó„‡ÌËÁ‡ˆËË\" ‰Îˇ ÏÓÌËÚÓËÌ„Ó‚: %s\n", strerror(e));
			return 1;
		}
	}

	tcinfo->topicAnnoTax = new GFStringFStringMap(aaa);
	if ( params->annoTaxFile ) {
		if( loadStringMap(tcinfo->topicAnnoTax, params->annoTaxFile, CLASS_KEY_SIZE )) {
			gclog.noHdr();
			gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "ÕÂ ÏÓ„Û ÔÓ˜ËÚ‡Ú¸ Ù‡ÈÎ ÒÓ ÒÔËÒÍÓÏ \"ŒÒÓ·ÂÌÌÓÒÚË Ì‡ÎÓ„ÓÓ·ÎÓÊÂÌËˇ\" ‰Îˇ ÏÓÌËÚÓËÌ„Ó‚: %s\n", strerror(e));
			return 1;
		}
	}

	tcinfo->topicAnnoInterest = new GFStringFStringMap(aaa);
	if ( params->annoInterestFile ) {
		if( loadStringMap(tcinfo->topicAnnoInterest, params->annoInterestFile, CLASS_KEY_SIZE )) {
			gclog.noHdr();
			gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "ÕÂ ÏÓ„Û ÔÓ˜ËÚ‡Ú¸ Ù‡ÈÎ ÒÓ ÒÔËÒÍÓÏ \"—ÙÂ‡ ËÌÚÂÂÒÓ‚\" ‰Îˇ ÏÓÌËÚÓËÌ„Ó‚: %s\n", strerror(e));
			return 1;
		}
	}

	tcinfo->topicAnnoKind = new GFStringFStringMap(aaa);
	if ( params->annoKindFile ) {
		if( loadStringMap(tcinfo->topicAnnoKind, params->annoKindFile, CLASS_KEY_SIZE )) {
			gclog.noHdr();
			gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "ÕÂ ÏÓ„Û ÔÓ˜ËÚ‡Ú¸ Ù‡ÈÎ ÒÓ ÒÔËÒÍÓÏ \"¬Ë‰ Ô‡‚Ó‚ÓÈ ËÌÙÓÏ‡ˆËË\" ‰Îˇ ÏÓÌËÚÓËÌ„Ó‚: %s\n", strerror(e));
			return 1;
		}
	}
#endif
	tcinfo->topicServiceInfo = new GFStringFStringMap(aaa);
	if( params->serviceInfoFile ) {
		if( loadStringMap(tcinfo->topicServiceInfo, params->serviceInfoFile, CLASS_KEY_SIZE )) {
			gclog.noHdr();
			gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "ÕÂ ÏÓ„Û ÔÓ˜ËÚ‡Ú¸ Ù‡ÈÎ ÒÓ ÒÔËÒÍÓÏ \"—ÎÛÊÂ·Ì‡ˇ »ÌÙÓÏ‡ˆËˇ\": %s\n", strerror(e));
			return 1;
		}
	}

	tcinfo->topicKinds = new GFStringFStringMap(aaa);
	if( params->kindFile ) {
		if( loadStringMap(tcinfo->topicKinds, params->kindFile, KIND_KEY_SIZE )) {
			gclog.noHdr();
			gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "Ó≈ Õœ«’ –“œﬁ…‘¡‘ÿ ∆¡ Ã ”œ ”–…”ÀœÕ ◊…ƒœ◊: %s\n", strerror(e));
			return 1;
		}
	}

	readObjTypes(*tcinfo,params);

	tcinfo->sourcesInfo = (SourcesInfo*)calloc(1,sizeof(SourcesInfo) );
	if( readTerritoryFile( tcinfo->sourcesInfo, params->territoryFile )){
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "Cant read territory\n");
	}

	if( readSourcesInfo( tcinfo->sourcesInfo, params->sourcesFile ) ){
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "Cant read sources\n");
		
		return 1;
	}

	tcinfo->normInfo = (NormInfo*)calloc(1,sizeof(NormInfo) );
	if( readNormInfo( tcinfo->normInfo, params->normFile ) ){
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "Cant read norms/categories\n");
		return 1;
	}

	basesInfo = new BaseCore[MAX_BASES];
	for (int i = 0; i < MAX_BASES; i++)
		gk_bzero( &basesInfo [i], sizeof(BaseCore) );

	tcinfo->st2p  = new STtoP(params->priorityTableFile,tcinfo);
#ifdef OLD_MAP
	tcinfo.invalidDocs = new u_int32_tSplaySet();
	tcinfo.inDocs = new u_int32_tSplaySet();
	tcinfo.notADocs = new u_int32_tSplaySet();
  #ifdef	VERSION56
	tcinfo.anonces = new u_int32_tSplaySet();
	tcinfo.vlcontrols = new u_int32_tSplaySet();
	tcinfo.editions = new u_int32_tSplaySet();
  #endif
#else
	char defChar8= 0;
	tcinfo->invalidDocs = new GSubMap(defChar8);
	tcinfo->notADocs = new GSubMap(defChar8);
  #ifdef	VERSION56
	tcinfo->anonces = new GSubMap(defChar8);
	tcinfo->vlcontrols = new GSubMap(defChar8);
  #endif
#endif

	tcinfo->relatedS = new std::deque<long>;
	tcinfo->editions = new std::deque<long>;

	delete [] basesInfo;
	basesInfo = new BaseCore[ MAX_BASES ];
	for (int i = 0; i < MAX_BASES; i++)
		gk_bzero( &basesInfo [i], sizeof(BaseCore) );
	tcinfo->basesCore = basesInfo;
	tcinfo->hereBelongs = new longSplaySet();
	tcinfo->ignoreBelongs = new std::set<long>;
	readBelongsMap( params->belongsMapFile, tcinfo );
	long tmpLong;
	for (int ii=0; ii<params->here_info.nbelongs; ii++) {
		for (i = tcinfo->belongsMap->first(); i; tcinfo->belongsMap->next(i) ) {
			if (tcinfo->belongsMap->contents(i) == params->here_info.belongs[ii]) {
				tmpLong= params->here_info.belongs[ii];
				hereBelongs.add(tmpLong);
				tcinfo->hereBelongs->add(tmpLong);
				break;
			}
		}
		if (!i) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"ÕÂËÁ‚ÂÒÚÌ˚È ÌÓÏÂ ·‡Á˚ ‚ BelongsList: %d\n",params->here_info.belongs[ii]);
		}
	}
	for (int ii=0; ii<params->here_info.nbelongs_i; ii++) {
		for (i = tcinfo->belongsMap->first(); i; tcinfo->belongsMap->next(i) ) {
			if (tcinfo->belongsMap->contents(i) == params->here_info.belongs_i[ii]) {
				tmpLong= params->here_info.belongs_i[ii];
				tcinfo->ignoreBelongs->insert(tmpLong);
				break;
			}
		}
		if (!i) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"ÕÂËÁ‚ÂÒÚÌ˚È ÌÓÏÂ ·‡Á˚ ‚ IgnoreBelongsList: %d\n",params->here_info.belongs_i[ii]);
		}
	}
	
	tcinfo->weightsTable = (BaseWeight *)calloc(64, sizeof(BaseWeight));
	readWeightsTable( params->weightsTableFile, tcinfo );
	if( params->warningsFile && readWarningsMap(params->warningsFile, tcinfo) ){
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "Ó≈ Õœ«’ –“œﬁ…‘¡‘ÿ ‘¡¬Ã…√’ –“≈ƒ’–“≈÷ƒ≈Œ… \n");
		return 1;
	}

	tcinfo->pubSrcMap = new GFStringFStringMap(aaa);
	tcinfo->pubSrcMapConverter = new GFStringFStringMap(aaa);
	if( loadPublishMap(tcinfo->pubSrcMap, tcinfo->pubSrcMapConverter, params->pubSourceFile, PUBLISHEDIN_KEY_SIZE )) {
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "Ó≈ Õœ«’ –“œﬁ≈”‘ÿ ”–…”œÀ …”‘œﬁŒ…Àœ◊ œ–’¬Ã…Àœ◊¡Œ…—\n" );
		return 1;
	}
	tcinfo->topicBelongs = new std::map<long,short*>;
	tcinfo->map_doc_subs = new std::map<long,long*>;
	tcinfo->topics_tocompile = new std::deque<long>;
	tcinfo->set_empty_blocks = new std::set<u_int64_t> ;
	tcinfo->map_file_leadingparas = new std::map<std::string, std::set<long> >;
	tcinfo->additional_file_strings = new std::deque<std::string>;
	tcinfo->additional_source = new std::deque<std::pair<long,std::string> >;

	tcinfo->bad_docs = new std::set<long>;
	tcinfo->docs_with_class = new std::deque<long>;
	tcinfo->topic_tvstopics = 0;
	tcinfo->editions_map = new std::map<long,long>;

	tcinfo->blobs = new u_int32_tSplaySet();

#ifdef VERSION56
	tcinfo->m_next=new VerLink;
#endif

	tcinfo->incorrect_dates_to = new std::map<long,date>;
	tcinfo->incorrect_dates_toto = new std::map<long,date>;

	gcpass1 (*tcinfo);
	delete tcinfo->hereBelongs;
	tcinfo->hereBelongs= 0;

	generateRefTable(*tcinfo, params);
	if( params->inRTFile && readRefTable(*tcinfo, params) )
		return 1;

	if (params->obj_table_gen) {
		generateBlobTable(*tcinfo, params);
	} 
	if( params->inOFile && readBlobTable(*tcinfo, params) )
		return 1;

	rehashBlobTbl(*tcinfo);

	gclog.noHdr();
	gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Ûﬁ…‘Ÿ◊¡≈‘”— ∆¡ Ã ÀÃ¡””œ◊\n");

	return 0;
}

extern "C" void* local_main_PRE_ptr= 0;

int local_main(
#ifdef WITH_DBL_THREAD
			   LPTHREAD_CNTX pCntxt
#else
			   int argc, char **argv
#endif
			   )
{
	ThreadCompileInfo *tcinfo= 
#ifdef PTRS_IN_META
		(ThreadCompileInfo *)(pCntxt->PThreadCompileInfo)
#else
		0
#endif
		;
	GCParameters *params=
#ifdef PTRS_IN_META
		(GCParameters *)(pCntxt->PGCParameters)
#else
		0
#endif
		;
									#ifdef __CHECK_TIME__
	struct timeb curtm;
	ftime(&curtm);

	unsigned long starttime = ((long)curtm.time)*1000 + (long)curtm.millitm;
									#endif
#ifdef JUST_CHECKER
	ThreadCompileInfo tcinfo_chk;
	GCParameters param_chk;

	params= &param_chk;
	tcinfo= &tcinfo_chk;
	local_main_PRE(tcinfo, params, argc, argv);
#endif
	ClassesInfo *cinfo = new ClassesInfo;
	if( readClassInfo( *cinfo, params->classFile, tcinfo->print_prefix_ex) ){
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "Ó≈ Õœ«’ –“œﬁ≈”‘ÿ ÀÃ¡””…∆…À¡‘œ“.\n");
		return 1;
	}
	{
		FString navigator (b_english_base ? "999=Legal Navigator" : "999=è‡†¢Æ¢Æ© ≠†¢®£†‚Æ‡");
		navigator.bDoFree = 0;
		FString navigator_short (b_english_base ? "Legal Navigator" : "è‡†¢Æ¢Æ© ≠†¢®£†‚Æ‡");
		navigator_short.bDoFree = 0;

		cinfo->pfxInfo = (ClassesInfo::PrefixInfo *) realloc (cinfo->pfxInfo, sizeof(ClassesInfo::PrefixInfo)* (cinfo->prefixCount+1));

		cinfo->allPrefixes->add (navigator);
		(*cinfo->pm) [navigator_short] = cinfo->prefixCount;
		cinfo->pfxInfo [cinfo->prefixCount].prefixName = strdup (navigator.chars ());
		cinfo->pfxInfo [cinfo->prefixCount].prefixType = 0;
		cinfo->pfxInfo [cinfo->prefixCount].nameLength = strlen (navigator.chars ()) + 1;
		cinfo->prefixCount++;
	}
	tcinfo->classesInfo = cinfo;

	gclog.noHdr();
	gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "“œﬁ…‘¡Œœ %d ÀÃ¡””œ◊, ◊≈“”…— %d\n", cinfo->classCount, cinfo->v);
	
	gclog.noHdr();
	gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "≈“◊Ÿ  –“œ»œƒ ⁄¡◊≈“€≈Œ.\n");
	gclog.noHdr();
	gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Ó¡ ƒ≈Œœ %d ‘œ–…Àœ◊.\n", tcinfo->map_doc_subs->size ());

	
	tcinfo->defPacking = PM_ZIP;/*(params->ndtCompress)?PM_ZIP:PM_STORED*/

#ifdef OLD_MAP
	tcinfo.corrs= new u_int32_tcaddr_tSplayMap( (caddr_t) 0 );
	tcinfo.resps= new u_int32_tcaddr_tSplayMap( (caddr_t) 0 );
#else
	char defChar2(0);
	GRefMap defM2(defChar2);
	tcinfo->corrs= new GDocsRefsMap( defM2 );
	tcinfo->resps= new GDocsRefsMap( defM2 );
#endif

#ifdef JUST_CHECKER
	DbProcessor nulProcessor;
	tcinfo->dbproc = &nulProcessor;
#else

#ifndef HAS_WORKING_THREADS
 #ifndef WITH_DBL_THREAD
	DbProcMetaFile mh(params.outName,1,params.mfCompress);
 #else
	*pCntxt->ppPipename= strdup(params->outName);
	DbProcMetaFile mh((const char*)pCntxt,1,params->mfCompress);
 #endif
	if (!mh.OK()) {
	        gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN,"ÕÂ ÏÓ„Û ÓÚÍ˚Ú¸ ÏÂÚ‡Ù‡ÈÎ %s\n", params->outName);
		return 1;
	}
	tcinfo->dbproc= new DbProcessorMWritter( &mh );
#else
	DbProcMetaMTSRWHolder mh(1024*1024 );

	StdBigBase stdBase(params.outName,ACE_OS_O_RDWR | ACE_OS_O_CREAT );
	tcinfo.dbproc= new DbProcessorMtoGKDB( &mh, &stdBase );

  #ifdef USE_POSIX_TH
	pthread_t m2gt;
	pthread_attr_t m2gt_a;
	pthread_attr_init(&m2gt_a);
	pthread_attr_setscope(&m2gt_a, PTHREAD_SCOPE_SYSTEM);
	pthread_create(&m2gt,&m2gt_a,m2gkdb,tcinfo.dbproc);
  #else
	thread_t m2gt;
	thr_create(0,0,m2gkdb,tcinfo.dbproc,THR_BOUND | THR_NEW_LWP,&m2gt);
  #endif // USE_POSIX_TH

#endif // define HAS_WORKING_THREADS

#endif // JUST_CHECKER

#ifdef WITH_DBL_THREAD
	if(pCntxt->bGCTX_in_MF2GARDB){
		tcinfo->dbproc->p_ctxTextMap= 0;
		tcinfo->dbproc->p_ctxNameMap= 0;
	}else{
		tcinfo->dbproc->p_ctxTextMap= (u_int64_tCtxLongSetSplayMap *)pCntxt->pTxtCntxt;
		tcinfo->dbproc->p_ctxNameMap= (u_int64_tCtxLongSetSplayMap *)pCntxt->pNmeCntxt;
	}
#endif

	nsrcParser np(tcinfo);
	struct nsrc2mParams p;
	p.np = &np;
	p.tcinfo = tcinfo;
	if (params->kwFile) kwFile = strdup (params->kwFile);

#ifdef USE_THREADS
 #ifdef USE_POSIX_TH
	pthread_t s2mt;
	pthread_attr_t s2mt_a;
	pthread_attr_init(&s2mt_a);
	pthread_attr_setscope(&s2mt_a, PTHREAD_SCOPE_SYSTEM);
	pthread_create(&s2mt,&s2mt_a,nsrc2m,&p);
	pthread_join(s2mt,0);
 #else
	thread_t s2mt;
	thr_create(0,0,nsrc2m,&p,THR_BOUND | THR_NEW_LWP,&s2mt);
	thr_join(s2mt,0,0);
 #endif
#else
	//delete tcinfo.belongsMap; tcinfo.belongsMap= 0;
	nsrc2m(&p);
#endif

	flushBaseInfo(tcinfo);
	setBaseClassInfo(tcinfo);
	setBasePrefixInfo(tcinfo);
	setHereBases(tcinfo,*params);
	flushBasesWeights(tcinfo);
	writeRespsCorrs(tcinfo);

#ifndef JUST_CHECKER
	mh.noteEOM();
	delete tcinfo->dbproc;
#endif
#ifdef HAS_WORKING_THREADS
#ifdef USE_POSIX_TH
	pthread_join(m2gt,0);
#else
	thr_join(m2gt,0,0);
#endif	
#endif
#if !defined(GARANT_TOOLS) || (defined(GARANT_TOOLS) && defined(__FreeBSD_SingleThread__))
	delete [] basesInfo;
#ifdef OLD_MAP
	u_int64_tSplaySet *st;
	for( i=tcinfo.resps->first();i;tcinfo.resps->next(i)) {
		if((st = (u_int64_tSplaySet*)tcinfo.resps->contents(i)))
			delete st;
	}
#endif
	delete tcinfo->resps;
#ifdef OLD_MAP
	for( i=tcinfo.corrs->first();i;tcinfo.corrs->next(i)) {
		if((st = (u_int64_tSplaySet*)tcinfo.corrs->contents(i)))
			delete st;
	}
#endif
	delete tcinfo->corrs;

	delete tcinfo->blobs;
	delete tcinfo->topicBelongs;
	delete tcinfo->map_doc_subs;
	delete tcinfo->set_empty_blocks;
	delete tcinfo->map_file_leadingparas;
	delete tcinfo->additional_file_strings;
	delete tcinfo->bad_docs;
	delete tcinfo->docs_with_class;
	delete tcinfo->topic_tvstopics;
	delete tcinfo->editions_map;

	delete tcinfo->pubSrcMapConverter;
	delete tcinfo->pubSrcMap;

	free(tcinfo->weightsTable);

	delete tcinfo->relatedS;
	delete tcinfo->editions;
	delete tcinfo->notADocs;
	delete tcinfo->invalidDocs;
	while(tcinfo->st2p->nSources--)
		free(tcinfo->st2p->matrix[tcinfo->st2p->nSources]);
	free(tcinfo->st2p->matrix);
	delete tcinfo->st2p;

	delete tcinfo->topicInpharmFirms;
	delete tcinfo->topicTypes;
	delete tcinfo->topicAnnoUser;
	delete tcinfo->topicAnnoOrganization;
	delete tcinfo->topicAnnoTax;
	delete tcinfo->topicAnnoInterest;
	delete tcinfo->topicAnnoKind;

  #ifdef VERSION56
	delete tcinfo->m_next;
	delete tcinfo->anonces;
	delete tcinfo->vlcontrols;
 #endif
	free((void*)tcinfo->objRoot);
#endif

#ifdef __CHECK_TIME__
	ftime(&curtm);
	unsigned long endtime = ((long)curtm.time)*1000 + (long)curtm.millitm;
	double deltatm = ((double)(endtime-starttime))/1000;
	gclog.noHdr();
	gclog.printfC(AdvLogger::LOG_INFO_MPCXC,AdvLogger::CD_KOI,"Compile working time: %f secs.\n",deltatm);
#endif
	
	return 0;
}

extern	void usage_mf2(const char*);

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (1);
}

LONG WINAPI VectoredExceptionHandler (PEXCEPTION_POINTERS pExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (1);
}

int main_logic ( int argc, char *argv[] )
{
	AddVectoredExceptionHandler (1, VectoredExceptionHandler);
	SetUnhandledExceptionFilter (UEF);

	VER_PARAM verParam;
	int	i;

#ifdef	JUST_CHECKER
	verParam.exeId= TID_GC_CHECK;		// defines BASEMASK.H
#else
	verParam.exeId= TID_GC;			// defines BASEMASK.H
#endif
	verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
	verParam.stdOut= stdout;
	verParam.pDate= __DATE__;
	verParam.pTime= __TIME__;

	if((i=_imp_GVersion(&argc, argv, &verParam))){
		if(i == VC_ADD_OK){
		}else{
		}
#ifdef _DEBUG
#ifdef	JUST_CHECKER
		printf("\n *** GC_CHECK Debug Version. For test, only... ***\n\n");
#else
		printf("\n *** GC Debug Version. For test, only... ***\n\n");
#endif
#else
		exit(0);
#endif
	}

#ifdef WITH_DBL_THREAD
	LPTHREAD_CNTX p_Writer, p_Reader;
#ifdef AS_PROCESS
	if(argc < 2){
		usage( argv[0]);
		return -1;
	}
	if(strcmp(argv[1], EXCT_FROM_MF2GRDB)){
		puts("\n\n This module execute from mf2grdb.exe, only !\n\n" );
		return -1;
	}
#endif

#ifndef	JUST_CHECKER
	if (argc < 3){
		usage_mf2(argv[0]);
		return -1;
	}
#endif
  #ifdef PTRS_IN_META
	local_main_PRE_ptr= (void*)local_main_PRE;
  #endif
	init_my_pipe(&p_Writer, &p_Reader, (void*)local_main);
#if !defined(AS_PROCESS) && !defined(JUST_CHECKER)
	p_Writer->l_argc= 2;
	p_Writer->l_argv= (char**)malloc(2*sizeof(char*));
	p_Writer->l_argv[0]= strdup(argv[0]);
	if(argc > 1)
		p_Writer->l_argv[1]= strdup(argv[argc-2]);

	p_Reader->l_argc= argc;
	p_Reader->l_argv= argv;
	p_Reader->pTxtCntxt= p_Writer;

	local_mf2_main(p_Reader);
#else
	p_Writer->l_argc= argc;
	p_Writer->l_argv= argv;
	local_main(p_Writer);
#endif
	free(*p_Writer->ppPipename);
	done_my_pipe(p_Writer, p_Reader);
	return 0;
#else
	return local_main( argc, argv );
#endif
}

static void flushBaseInfo(ThreadCompileInfo *inf)
{
	unsigned int j;
	char *p;

	for( int i=1; i< MAX_BASES; i++ ){
		for(p=(char *)((inf->basesCore)+i),j=0;j<sizeof(BaseCore); p++,j++){
			if(*p)
				goto do_write;
		}
		continue;
	do_write:
		inf->dbproc->setBaseCore( i, ((inf->basesCore)+i));
	}
}

static void flushBasesWeights(ThreadCompileInfo *inf)
{
#ifdef	WINENCODE
	if (b_recode) for ( u_int32_t i = 0; i < inf->wtCount; i++ ) {
		Recoding( cd_dos, cd_win, inf->weightsTable[ i ].name );
		Recoding( cd_dos, cd_win, inf->weightsTable[ i ].nameEng );
	}
#endif
	inf->dbproc->writeAux("Comp", inf->weightsTable, inf->wtCount*sizeof(BaseWeight));
}

static void writeFStringSplaySet2Aux(DbProcessor *dbp, const char *k,
									 FStringSplaySet *ss)
{
	size_t tsz = 0;
	Pix i;
	for( i=ss->first(); i; ss->next(i)){
		tsz+=(*ss)(i).length()+1;
	}
	char *buf = (char*)malloc(tsz);
	tsz = 0;
	for( i=ss->first(); i; ss->next(i)){
		memcpy(buf+tsz, (*ss)(i).chars(), (*ss)(i).length()+1);
#ifdef	WINENCODE
		if (b_recode) Recoding(cd_dos,cd_win,buf+tsz);
#endif
		tsz +=(*ss)(i).length()+1;
	}
	dbp->writeAux(k, buf, tsz);
	free(buf);
}

static void setBasePrefixInfo(ThreadCompileInfo *inf)
{

#define	DOW_(k,a) writeFStringSplaySet2Aux(inf->dbproc, k, inf->classesInfo->a )

	DOW_(PR_ALL, allPrefixes);
	DOW_(PR_DOCS,docPrefixes);
	DOW_(PR_COMMENTS,commPrefixes);
	DOW_(PR_FORMS,formPrefixes);
	DOW_(PR_PROJECTS,projPrefixes);
	DOW_(PR_PRACTICE,prakPrefixes);
	DOW_(PR_INTERS,intePrefixes);
	DOW_(PR_QUES,quesPrefixes);
	DOW_(PR_BREF,brefPrefixes);
#undef DOW_
	// write User Nodes info
	for ( Pix i= inf->classesInfo->unodes->first(); i; 
		  inf->classesInfo->unodes->next(i) ) {
	  FString pfx = inf->classesInfo->unodes->key(i);
  	  ClassesInfo::UnodeInfo *ninfo = (ClassesInfo::UnodeInfo *)
							inf->classesInfo->unodes->contents(i);
	  if( ninfo ){
		  for( int j = 0; j < ninfo->nIn; j++ ){
			  inf->dbproc->setUNode(pfx.chars(), pfx.length()+1,
					 ninfo->node[j].jtype, 
					 ninfo->node[j].uname, strlen(ninfo->node[j].uname)+1,
					 ninfo->node[j].cls, strlen(ninfo->node[j].cls)+1 );

		  }
	  }
  }
}
static void setBaseClassInfo(ThreadCompileInfo *inf)
{
	inf->dbproc->writeAux("Clas", &(inf->classesInfo->v), sizeof(inf->classesInfo->v) );
}

int iMakeAllDocs= 0;
int iMakeAllDocsParaMax= 50000;
long iMakeAllDocsSizeMax= 0x7fffffff;

#ifdef OLD_SHORT_STR
	#include "../../../libs/gkdb/src/stdbase.h"
	#undef MAKE_HDD
	#undef PL_REPLCTR_FUNC
	#define INSTLL_CIB
	#include "../../../libs/gkdb/src/pl_crypt.cpp"
	#include "../../../libs/gkdb/src/pagefile.cpp"
	#include "../../../libs/gkdb/src/base.cpp"
	#include "../../../libs/gkdb/src/stdbase.cpp"
	namespace NdtClone {
		extern const char *pBuckupFileExt;
	}
#endif

int
#ifdef JUST_CHECKER
	main_check
#else
	main
#endif
			( int argc, char *argv[] )
{
	SetUnhandledExceptionFilter (UEF);

	int ret = main_logic (argc, argv);
#ifdef OLD_SHORT_STR
	if(!ret){
		class OldBase : public YBase
		{
			public:
				OldBase(const char * name)
					: YBase(	name
								, ACE_OS_O_RDWR|ACE_OS_O_CREAT
								, -1)
				{
					currentBlockSize= ADD_BLOCK_SIZE;
					reConnectKeyAndStr(name,ACE_OS_O_RDWR);
					if(strFile->IsOk()){
						int lenF= strlen(strFile->FileName), lenE= strlen(NdtClone::pBuckupFileExt)+1;
						char *nmDlt= (char*)alloca(lenF+lenE);
						memcpy(nmDlt,strFile->FileName,lenF);
						memcpy(nmDlt+lenF,NdtClone::pBuckupFileExt,lenE);
						ace_os_unlink(nmDlt);
						*(nmDlt+lenF-3)= '8';
						ace_os_unlink(nmDlt);
						*(nmDlt+lenF-3)= '9';
						ace_os_unlink(nmDlt);
					}
					pl_OpenBase(	&keyFile->m_readed, &strFile->m_readed,
									&keyFile->m_pCryptoTag, &strFile->m_pCryptoTag,
									&textFile->m_pCryptoTag);
				}
			protected:
				virtual PagedFile *makePagedFile(const char * name, int omode)
				{
					return NdtClone::GetUpdatedPagedFile(name, BASE_DATA_VERSION);
				}
		};
		OldBase tmp(argv[argc-1]);
		//gc_SetLicence (tmp.textFile, 2000,2000,0);		
		long *FirstFAT= (long *)alloca(tmp.strFile->PageSize);
		if(tmp.strFile->GetPage(3,FirstFAT)){
			FirstFAT[1]= FirstFAT[3];
			FirstFAT[3]= tmp.strFile->PageSize;
			if(!tmp.strFile->PutPage(1,FirstFAT))
				return -1;
			void *nn= alloca(tmp.strFile->PageSize);
			memset(nn,0,tmp.strFile->PageSize);
			if(!tmp.strFile->PutPage(3,nn))
				return -1;
		}
	}
#endif
	return ret;
}

#ifdef JUST_CHECKER
int main ( int argc, char *argv[] )
{
	AddVectoredExceptionHandler (1, VectoredExceptionHandler);
	SetUnhandledExceptionFilter (UEF);
	return main_check (argc, argv);
}
#endif


