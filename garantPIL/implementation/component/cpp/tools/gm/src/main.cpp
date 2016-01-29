#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: main.cpp,v 2.8 2014/11/11 07:46:05 young Exp $
 */

#include <cstdlib>
#include <fcntl.h>
#include <ctime>
#include <cerrno>
#include <cstring>
#include <sys/stat.h>

#ifdef WITH_DBL_THREAD
	#include "MyPipe.h"
#endif

#include "gar_defs.hpp"
/*#include "garver.h"
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
   #include "../../../libs/gc/src/dbproc.mf.h"
#endif

#include "gc_ver.h"
#include "basemask.h"
#include "recode.h"
*/
bool b_english_base = false;
bool bIgnoreFatal = false;
bool b_recode = true;
bool b_inpharm = false;
bool bIgnoreTvsErrors = false;
#include <deque>
extern	std::deque<std::string> errors;
char* kwFile = 0;
/*
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
extern	bool	b_recode;*/
bool b5Context = false;

#ifdef OLD_MAP
	longSplaySet	hereBelongs;
#else
	#include "QMap.hpp"
	typedef QuickSplayMapG<long, char> GSubMap;

	GSubMap hereBelongs(0);
#endif
/*
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
		if ( inf->notADocs->contains(docid) && !inf->editions->contains(docid))
			continue;

#ifdef OLD_MAP
		u_int64_tSplaySet *st = (u_int64_tSplaySet*)
#else
		GRefMap *st = &
#endif
													 (inf->corrs->contents(i));
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
			if ( inf->editions->contains(rf.asref.docid) || !inf->notADocs->contains(rf.asref.docid))
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
		if ( inf->notADocs->contains(docid) && !inf->editions->contains(docid) )
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
			if ( inf->editions->contains(rf.asref.docid) || !inf->notADocs->contains(rf.asref.docid))
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
		gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Не могу открыть CatFile %s\n", catFile);
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
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,"Нет доступа к %s: %s\n", n.chars(), strerror(errno) );
			}
		} else {
			gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "Не могу получить статистику для %s: %s\n", n.chars(), strerror(errno) );
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
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Не могу открыть %s\n", fn);
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
				"Неверный формат строки\n");
			continue;
		}
		u_int32_t id = atoi( p );
		while (*p >= '0' && *p <= '9') p++;
		if (*p != ' ' && *p != '\t')
		{
			gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,
				"Неверный формат строки\n");
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
	gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Второй проход начат в %s\n", ctime(&startTime));
#endif

	int cl =0;
	for(i= tcinfo->Sources->first(); i; tcinfo->Sources->next(i) ){
		const char* nsrc_filename = tcinfo->Sources->key(i).chars();
		gclog.setFileName (nsrc_filename);
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Обработка файла %s\n", tcinfo->Sources->key(i).chars());
		FileStringer fst( tcinfo->Sources->key(i).chars() );
		if( !fst.OK() ){
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Не могу открыть файл %s\n", tcinfo->Sources->key(i).chars());
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
		gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Обработка файла завершена.\n");
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Примерное время окончания компиляции через %d сек.\n", est_t - el_t);
	}
	if (tcinfo->additional_file_strings->size ()) {
		cl = 0;
		gclog.setFileName ("$dummy$");
		for (std::vector<std::string>::const_iterator str_it = tcinfo->additional_file_strings->begin (); str_it != tcinfo->additional_file_strings->end (); str_it++) {
			gclog.setLN (++cl);
			std::string str = *str_it;
			np->addLine (str.c_str (), str.size (), "$dummy$", cl);
		}
		np->flush();
	}

	if (kwFile) {
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Идет обработка kw-файла\n");
		procKWfile (tcinfo, kwFile);
		gclog.printfC (AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_WIN, "нАПЮАНРЙЮ kw-ТЮИКЮ ГЮБЕПЬЕМЮ\n");
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
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Невозможно открыть на запись '%s'\n", p->outRTFile);
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
			"мЕБНГЛНФМН НРЙПШРЭ ТЮИК ЩРЮКНММШУ РХОНБ НАЗЕЙРНБ: '%s'. оПНБЕПЭРЕ ОПЮБХКЭМНЯРЭ ОЮПЮЛЕРПЮ 'ObjTypesFile' Б ТЮИКЕ 'gcini'\n",
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
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Название типа не может быть длиннее 4 символов\n");
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
		gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_KOI, "Не указан файл таблицы внешних ссылок.\n");
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
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Невозможно открыть на чтение '%s'\n", name);
			continue;
		}
		gclog.setFileName(name);
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Чтение таблицы внешних ссылок.\n");

		const char *buf;
		int l;
		int cl = 0;
		long cnt = -1;
		while((buf = fst.gets(l)) != 0) {
			gclog.setLN(++cl);
			const char* s = buf;
			
			if (*s >= '0' && *s <= '9') {
				//БЯРЮБХРЭ
				if (cnt != -1) {
					if (subs.size () > 1) {
						//ЕЯРЭ ЯЮАШ ЙПНЛЕ МСКЕБНЦН
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
				if (*s == 'N') {
					tcinfo.notInRC->add(cnt);
					tcinfo.notADocs->add(cnt);
				}
			} else if (*s == ' ' || *s == '\t') {
				while (*s == ' ' || *s == '\t') s++;
				if (*s < '0' || *s > '9') {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "Ошибка формата.\n", buf);
				}
				if (cnt == -1) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "Номер саба без номера топика.\n");
					continue;
				}
				long sub = atoi (s);
				subs.insert (sub);
			} else {
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "Ошибка формата.\n", buf);
			}
		}
	}

	if( wasDupes && p->extrn_ref_fatal ){
		gclog.noHdr();
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Компиляция прервана - повторяющиеся топики.\n");
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
	log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Запущен со следующими параметрами:\n");
	log.noHdr();
	log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Имя выходного файла: %s\n", p.outName);
	log.noHdr();
	log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Имя belongs-файла: %s\n", p.belongsMapFile);
	log.noHdr();
	log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Имя cat-файла: %s\n", p.catFile );
	if (p.ref_table_gen) {
		log.noHdr();
		log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI,"Генерировать таблицу ссылок: да.\n");
	} else {
		log.noHdr();
		log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI,"Генерировать таблицу ссылок: нет.\n");
	}

	if( p.kwFile && access(p.kwFile, 4) == 0 ){
		log.noHdr();
		log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Ключевые слова читаются из файла '%s'.\n", p.kwFile );
	}else{
		log.noHdr();
		log.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI, "Ключевые слова не заданы или невозможно найти файл.\n");
	}
}
*/
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
/*
extern	void usage_mf2(const char*);

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
*/


int iMakeAllDocs= 0;
int iMakeAllDocsParaMax= 50000;
long iMakeAllDocsSizeMax= 0x7fffffff;

#include "gsscreen.h"

extern "C" {
extern int parse_cmdline(int argc, char **argv);
extern int read_settings(void);
extern int gmmain(int threadMode, void *ThreadCntxt);
extern void help(void);
}
extern void init_screen(ProgressScreen *);

GSScreen *curr_GM_GSScreen= 0;

#ifdef PTRS_IN_META
	#include "../../../tools/gctools/src/MyPipe.h"
	int main_logic (LPTHREAD_CNTX pCntxt)
#else
	int main_logic (int argc, char *argv[])
#endif
{
	int use_settings;

#ifdef PTRS_IN_META
	int argc= pCntxt->l_argc;
	char **argv= pCntxt->l_argv;
	if(pCntxt->l_argv[1])
#endif
	{
		if(!(use_settings=parse_cmdline(argc, argv)))
			return -3;
		use_settings--;
		if(use_settings)
			if(!read_settings()) return -4;

		GSScreen scr(	cd_koi,
	#if defined(__GO32__) || defined(__WIN32__)
						cd_dos
	#else
						cd_koi
	#endif
						);

		curr_GM_GSScreen= &scr;
		init_screen(curr_GM_GSScreen);
		gmmain(1,
#ifdef PTRS_IN_META
					pCntxt
#else
					0
#endif
							);
		scr.CloseScreen();
	}
#ifdef PTRS_IN_META
	else
	{
		if(!gmmain(	0, pCntxt)) {
			// Write error message to log;
			return -7;
		}
	}
#endif
	return 0;
}

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

#ifdef PTRS_IN_META
	extern "C" void* local_main_PRE_ptr= 0;
	int main ( int argc, char *argv[] ) {
		LPTHREAD_CNTX p_Writer, p_Reader;
		local_main_PRE_ptr= (void*)0;
		init_my_pipe(&p_Writer, &p_Reader, (void*)main_logic);

		p_Writer->l_argc= argc;
		p_Writer->l_argv= argv;

		p_Reader->l_argc= argc;
		p_Reader->l_argv= argv;
		p_Reader->pTxtCntxt= p_Writer;
		{
			LPTHREAD_CNTX p_Writer1, p_Reader1;
			init_my_pipe(&p_Writer1, &p_Reader1, (void*)main_logic);

			char **argv1= (char **)alloca(argc+sizeof(*argv1));
			int rpt= argc;
			while(rpt--){
				argv1[rpt]= argv[rpt];
			}
			argv1[1]= 0;

			p_Writer->pTxtCntxt= p_Reader1;

			p_Writer1->l_argc= argc;
			p_Writer1->l_argv= argv1;
			p_Writer1->pTxtCntxt= 0;

			p_Reader1->l_argc= argc;
			p_Reader1->l_argv= argv1;
			p_Reader1->pTxtCntxt= p_Writer1;

			main_logic( p_Reader );
		}
		return 0;
	}
#else
	int main ( int argc, char *argv[] ) {
		SetUnhandledExceptionFilter (UEF);
		return mpcxc_run_main_stack_size (main_logic, argc, argv, (32*1024*1024));
		return 0;
	}
#endif

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

