#include "shared/Core/fix/mpcxc.h"
#include "zlib.h"
#include "MyPipe.h"

/*
 * $Id: nsrcparser.cpp,v 2.699 2015/10/13 10:05:51 young Exp $
*/

#include <algorithm>
#include <ctime>
#include <cstdlib>
//#include <unistd.h>
#include <fcntl.h>
#include <cstdio>
#include <limits.h>
#include <cstring>
#include <cerrno>
#include <sys/stat.h>
#include "garcomp.h"
#include "gardefs.h"
#include "classes.h"
#include "sources.h"
#include "sttop.h"
#include "publish.h"
#include "norminfo.h"
#include "pack.h"
#include "FString.long.VHMap.h"
#include "CaseString.defs.h"
#include "FString.VHSet.h"
#include "u_int32_t.VHSet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "u_int32_t.FString.VHMap.h"
#include "u_int64_t.SplaySet.h"
#include "u_int64_t.VHSet.h"
#include "u_int32_t.SplaySet.h"
#include "refsort.h"
#include "nsrccmd.h"
#include "base.h"
#include "rev.h"
#include "recode.h"
#include "garutils.h"

#include "common/components/rtl/Garant/EVD/EeGenerator_i.h"
#include "common/components/rtl/Garant/EVD/Types/Types.h"

/*
extern	unsigned char* codeTables[4][4];
extern	unsigned char Dos2Win_tatar [ 256 ];
*/

extern "C"
{
	typedef int (*sort_func_t)(const void *, const void*);
}

extern	int	compare_subdescex (const void* p1, const void* p2);
extern	int	compare_docstruct (const void* p1, const void* p2);

extern	void	SetDocMonitoring( DocInfo* docInfo, long aId );


#define SaSize 8192
const long maxSubs= 0x3fff;

static int ref_vincluded_check=0;
static const char *TextCommand[] = {
	"STYLE", "SUB", "TYPE", "CLASS", "SOURCE", "TERRITORY", "PREFIX", "DATE", "CODE", "BLOCK", "MAIN", "TABLE", "CELL", "ROW", 0};
#define TEXT_COMMANDS 14

char* rus2eng[] = {
	"А", "A", "Б", "B", "В", "V", "Г", "G", "Д", "D", "Е", "E", "р", "E", "Ж", "ZH", "З", "Z", "И", "1", "Й", "1", "К", "K", "Л", "L", "М", "M", "Н", "N",
	"О", "0", "П", "P", "Р", "R", "С", "S", "Т", "T", "У", "U", "Ф", "F", "Х", "KH", "Ц", "TS", "Ч", "CH", "Ш", "SH", "Щ", "SCH", "Ь", "Ь", "Ы", "Ы", "Ъ", "Ъ",
	"Э", "E", "Ю", "YU", "Я", "YA", ""};

date maxDate;
date todayDate;
date prevSatDate;
date satDate;

int  bWdoRefDocCheck = 0;

extern	bool	bEnglish;
extern	bool	bIgnoreFatal;
extern	bool	b_recode;
extern	std::deque<std::string> errors;
extern bool b_fastfakeattrs;

bool	annoPhase = false;

/*
int		annoLine = 0;
char*	annoLines[1000];
bool	checkTopicId = true;
*/

#ifdef VERSION56
bool DocActivityEx::operator<(const DocActivityEx& a) const {
	/*
	if (from.da_year < a.from.da_year)
		return true;
	if (from.da_mon < a.from.da_mon)
		return true;
	if (from.da_day < a.from.da_day)
		return true;
	if (to.da_year == 0)
		return false;
	if (to.da_year < a.to.da_year)
		return true;
	if (to.da_mon < a.to.da_mon)
		return true;
	if (to.da_day < a.to.da_day)
		return true;
	return block < a.block;
	*/
	int result = is_lt(from, a.from);
	if (result == 0) {
		result = is_lt (to, a.to);
		if (result == 0)
			result = block - a.block;
	}
	return result != 0;
}

bool DocNotSure::operator<(const DocNotSure& a) const {
	return (is_lt(from, a.from) != 0);
}

bool DocChDate::operator<(const DocChDate& a) const {
	return (is_lt(anonce, a.anonce) != 0);
}

bool ChDateEx::operator<(const ChDateEx& a) const {
	int result = is_lt(anonce, a.anonce);
	if (result)
		return true;
	else {
		result = ref.DocId - a.ref.DocId;
		if (result)
			return ref.DocId < a.ref.DocId;
		else
			return ref.Sub < a.ref.Sub;
	}
}

bool DivisionInfo::operator<(const DivisionInfo& a) const {
	return Para < a.Para;
}

int is_ok(const DocActivityEx& interval) {
	if ( interval.to.da_year )
		return is_lt(interval.from, interval.to) || is_eq( interval.from, interval.to);
	else
		return true;
}

bool is_in(date d, const DocActivityEx& interval) {
	if (is_lt(d, interval.from)) return false;
	if (is_eq(d, interval.to) || is_lt(d, interval.to)) return true;
	if (!interval.to.da_year && (is_lt(interval.from,d) || is_eq (interval.from, d))) return true;
	return false;
}

int is_ok(const Activity& a) {
	Activity::const_iterator i=a.begin(),j=a.begin();
	if (i==a.end()) return true;
	++j;
	while (j!=a.end()) {
		if (!is_lt(i++->to, j++->from)) return false;
	}
	return true;
}

int getActivityDate(const char *s, int l, date &d) {
	if (l<1 || !('0'<=s[0] && s[0]<='9')) return 0;
	const char *dd=s;
	int i;
	for (i=0; i<l && '0'<=s[i] && s[i]<='9'; i++);
	++i;
	if (i>=l || s[i-1]!='/' || !('0'<=s[i] && s[i]<='9')) return 0;
	const char *mm=&s[i];
	for (; i<l && '0'<=s[i] && s[i]<='9'; i++);
	++i;
	if (i>=l || s[i-1]!='/' || !('0'<=s[i] && s[i]<='9')) return 0;
	const char *yyyy=&s[i];

	d.da_day = atoi( dd );
	d.da_mon = atoi( mm );
	d.da_year = atoi( yyyy );
	if (!isValidDate(d)) {
		d.da_day = 0;
		d.da_mon = 0;
		d.da_year = 0;
		return 0;
	}

	for (; i<l && '0'<=s[i] && s[i]<='9'; i++);
	return i;
}


void getActivity(const char *s, int l, DocActivityEx& docActivity) {
	int i;
	for (i=0; i<l && (s[i]==' ' || s[i]=='\t'); i++);
	if (i==l) return;
	if (s[i]=='-') { // перва€ дата не задана
		for (++i; i<l && (s[i]==' ' || s[i]=='\t'); i++);
		i+=getActivityDate(&s[i], l-i, docActivity.to);
	} else {
		int n=getActivityDate(&s[i], l-i, docActivity.from);
		if (n>0) {
			for (i+=n; i<l && (s[i]==' ' || s[i]=='\t'); i++);
			if (i==l) return;
			if (s[i]=='-') { // возможно заданы обе даты
				for (++i; i<l && (s[i]==' ' || s[i]=='\t'); i++);
				i+=getActivityDate(&s[i], l-i, docActivity.to);
			}
		}
	}
	while (i<l && (s[i]==' ' || s[i]=='\t')) i++;
	if (i==l) return;
	if (s[i++]=='"') {
		int j;
		for (j=l-1; j>i && s[j]!='"'; j--);
		if (j>i) { // задана формулировка
			docActivity.text=new char[j-i+1];
			strncpy(docActivity.text, &s[i], j-i);
			docActivity.text[j-i]='\0';
		}
	} else {
		if (i<l) { // задана формулировка
			docActivity.text=new char[l-i+1];
			strncpy(docActivity.text, &s[i], l-i);
			docActivity.text[l-i]='\0';
		}
	}
}

void	getChDate( const char *s, int l, ChDateEx &chDateEx) {
	int i;
	for (i=0; i<l && (s[i]==' ' || s[i]=='\t'); i++);
	if (i==l) return;
	int n=getActivityDate(&s[i], l-i, chDateEx.anonce);
	chDateEx.ref.DocId = 0;
	chDateEx.ref.Sub = 0;
	if (n>0) {
		for (i+=n; i<l && (s[i]==' ' || s[i]=='\t'); i++);
		if (i==l) return;
		char* p = (char*)s + i;
		chDateEx.ref.DocId = atol (p) + ID_BORDER;
		char* point = strchr (p, '.');
		if (point)
			chDateEx.ref.Sub = atol (point+1);
		//i+=getActivityDate(&s[i], l-i, chDate.active);
	}
}

void	getNotSure( const char *s, int l, DocNotSure& notSure ) {
	int i;
	for (i=0; i<l && (s[i]==' ' || s[i]=='\t'); i++);
	if (i==l) return;
	int n=getActivityDate(&s[i], l-i, notSure.from);
	if (n>0) {
		for (i+=n; i<l && (s[i]==' ' || s[i]=='\t'); i++);
		if (i==l) return;
		if (s[i]=='-')
			for (++i; i<l && (s[i]==' ' || s[i]=='\t'); i++);
		i+=getActivityDate(&s[i], l-i, notSure.to);
	} else {
		gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќеверный формат команды NOTSURE\n");
		return ;
	}
#ifdef	VERSION61
	while (i<l && (s[i]==' ' || s[i]=='\t')) i++;
	if (i==l) return;
	if (s[i++]=='"') {
		int j;
		for (j=l-1; j>i && s[j]!='"'; j--);
		if (j>i) { // задана формулировка
			notSure.text=new char[j-i+1];
			strncpy(notSure.text, &s[i], j-i);
			notSure.text[j-i]='\0';
		} else {
			gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќеверный формат команды NOTSURE. ¬озможно, пропущены кавычки.\n");
			return ;
		}
	} else {
		if (i<l) { // задана формулировка
			notSure.text=new char[l-i+1];
			strncpy(notSure.text, &s[i], l-i);
			notSure.text[l-i]='\0';
		}
	}
#endif
}

void	getContents( const char *s, int l, ContentsStruct& contentsStruct ) {
	contentsStruct.Size = 2;
	int i;
	for (i=0; i<l && (s[i]==' ' || s[i]=='\t'); i++);
	if (i==l) return;

	char* p = (char*)s+i;
	contentsStruct.Size = atoi( p );

	while ( p-s < l && *p >= '0' && *p <= '9' ) p++;
	while ( p-s < l && (*p == ' ' || *p=='\t' ) ) p++;
	if ( p - s < l )
		contentsStruct.Extended = atoi( p );
}

void	getCompareContents( const char *s, int l, CompareContentsStruct& contentsStruct ) {
	int i;
	for (i=0; i<l && (s[i]==' ' || s[i]=='\t'); i++);
	if (i==l) return;

	char* p = (char*)s+i;
	contentsStruct.Levels = atoi( p );
}

void	getDivision( const char *s, int l, DivisionInfo& divisionInfo ) {
	int i;
	for (i=0; i<l && (s[i]==' ' || s[i]=='\t'); i++) ;
	if ( i == l ) return;

	divisionInfo.Symbol = s[i++];
	for (; i<l && (s[i]==' ' || s[i]=='\t' || s[i] == '\"'); i++) ;

	if ( i == l ) return;

	int savedI = i;
	for ( ; i<l && s[i] != '\"'; i++ ) ;

	divisionInfo.Params = new char[ i - savedI + 1 ];
	strncpy(divisionInfo.Params, s+savedI, i-savedI );
	divisionInfo.Params[i-savedI] = 0;
}

void nsrcParser :: check_page_break(const char *s, int& l) {
	int i=0;
	while ((s[i]==' ' || s[i]=='\t') && i<l) ++i;
	for (; i<l; i++)  {
		switch (s[i]) {
		case '\t':
		case ' ':
			++wordInPara; 
			while ((s[i]==' ' || s[i]=='\t') && i<l) 
				++i;
			--i;
			break;
#ifdef	VERSION56
		case 8: {
				if (me < ID_DIC_LO || me > ID_DIC_HI) {
					// переводы страниц не действуют дл€ —ловар€
					PageBreak page={cpn, wordInPara};
					dbproc->addTopicPages(me, page);
					memcpy((void*)&s[i], &s[i+1], l-i-1);
					--l;--i;
				}
			}
			break;
#endif
		}
	}
	++wordInPara;
}
#endif

void nsrcParser :: checkRef (long docid, long sub)
{
	std::map<long,long*>::const_iterator map_it = map_doc_subs->find (docid);
	if (map_it != map_doc_subs->end ()) {
		if (sub) {
			long* data = map_it->second;
			if (!bsearch (&sub, data + 1, *data, sizeof (long), longcmp))
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•в sub-† %ld Ґ §Ѓ™гђ•≠в• %ld\n", sub, docid - REAL_DOC_OFFS);
		}
	} else {
		if (!bsearch (&docid, topic_tvstopics, topic_tvstopics_count, sizeof (long), longcmp))
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•в вЃѓ®™† %ld\n", docid - REAL_DOC_OFFS);
		else if (sub)
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•в sub-† %ld Ґ §Ѓ™гђ•≠в• %ld\n", sub, docid - REAL_DOC_OFFS);
	}
}

void nsrcParser :: checkNegativeRef( long docid, long sub )
{
	if (((docid < 0) || (docid > MAX_DOC_NUMBER)) || ((sub < 0) || (sub > MAX_SUB_NUMBER))) {
		gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_ALT, "Ова®ж†в•Ђм≠†п бблЂ™† (%ld:%ld)\n", docid-REAL_DOC_OFFS,sub);
	}
}

void nsrcParser :: flush ()
{
	finishTopic();
}

nsrcParser :: ~nsrcParser()
{
	free(objData);

	delete[] subsTmp;
	delete[] subsExTmp;

	delete srcsSet;
	delete typesSet;
	delete kindsSet;
	delete mkbsSet;
	delete chaptersSet;
	delete serviceInfoSet;
	delete annoUserSet;
	delete annoOrganizationSet;
	delete annoTaxSet;
	delete annoInterestSet;
	delete annoKindSet;

	delete docPrefixes;
	delete docClasses;

	delete markedDocs;
#ifndef PTRS_IN_META
	delete []paraFinalBuf;
#endif
	delete[] paraBuf;

	free(objRoot);
}

static int CheckSpecials(const unsigned char *buffer, int l)
{
	while(l--)
		if (*buffer++ < 10 )
			return 1;
	
	return 0;
}

nsrcParser :: nsrcParser ()
{
	printf("No default constructor.\n");
}

nsrcParser :: nsrcParser ( ThreadCompileInfo *inf):
	me(0),
	baddoc_andskip(false),
	map_doc_subs(inf->map_doc_subs),
	set_empty_blocks(inf->set_empty_blocks),
	map_file_leadingparas(inf->map_file_leadingparas),
	additional_file_strings(inf->additional_file_strings),
	additional_source (inf->additional_source),
	bad_docs (inf->bad_docs),
	docs_with_class (inf->docs_with_class),
	topic_tvstopics(inf->topic_tvstopics),
	topic_tvstopics_count(inf->topic_tvstopics_count),
	editions_map(inf->editions_map)
{
	ci = inf->classesInfo;
	si = inf->sourcesInfo;
	ref_vincluded_check=inf->ref_vincluded_check;
	basesCore = inf->basesCore;
	dbproc = inf->dbproc;
#ifdef WITH_DBL_THREAD
	inf->dbproc->pInfo= &Info;
#endif
	packing = inf->defPacking;
	today_rev = inf->rtoday;
	objRootLength = inf->objRoot ? strlen (inf->objRoot) : 0;
	objRoot = (char*) malloc (objRootLength+2048);
	if (inf->objRoot)
		strcpy (objRoot, inf->objRoot);
	else
		objRoot [0] = '\0';

	paraBufSz = 16384;
	paraBuf = new unsigned char[paraBufSz << 6];
#ifdef PTRS_IN_META
	paraFinalBuf= 0;
#else
	paraFinalBuf= new unsigned char[paraBufSz << 6];
#endif

	cinfo = inf;

	warningMap = inf->warningMap;
	normInfo = inf->normInfo;
	norm  = tradename = intname = 0;
	markedDocs = new u_int32_tSplaySet();
	
	docClasses = new u_int64_tVHSet(200);
	docPrefixes = new u_int64_tVHSet(200);
	typesSet = new CaseStringSplaySet;
	kindsSet = new CaseStringSplaySet;
	mkbsSet = new CaseStringSplaySet;
	chaptersSet = new CaseStringSplaySet;
	serviceInfoSet = new CaseStringSplaySet;
	annoUserSet = new CaseStringSplaySet;
	annoOrganizationSet = new CaseStringSplaySet;
	annoTaxSet = new CaseStringSplaySet;
	annoInterestSet = new CaseStringSplaySet;
	annoKindSet = new CaseStringSplaySet;
	srcsSet = new CaseStringSplaySet;

	subsTmp = new SubDesc[maxSubs];
	subsExTmp = new SubDescEx[maxSubs*64*8];
	bIsSub = 0;

	name_len_check = inf -> name_len_check;
	text_command_check = 0;//inf -> text_command_check;
	iniSbrf = inf->iniSbrf;
	sub_title_check = inf -> sub_title_check;
	blobs = inf->blobs;
	objDataMaxSize = 500000;
	objData = malloc( objDataMaxSize );
	objType = 0;
	gk_bzero(spec,1000);
	gk_bzero((caddr_t)spec_pos,1000*sizeof(int));

	getDate ("1/1/2013",8,date_1_1_2013);

	b_show_skip_info = false;
}

bool nsrcParser :: finishBlob()
{
	if (!bObjectOk || !wasObjPath ) {
		objType = 0;
		me = 0;
		baddoc_andskip = false;
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"H≈‘ ƒѕ”‘’–Ѕ Ћ ∆Ѕ ћ’ ѕ¬я≈Ћ‘Ѕ …ћ… ќ≈ ЏЅƒЅќў Ѕ‘“…¬’‘ў.\n");
		return 0;
	}

	int rsz = sizeof(ObjInfo) + sizeof(u_int32_t);
	int l = 0;

	if( sLongNameSz  ){
		sLongName[sLongNameSz++] = 0;
		rsz += sLongNameSz;
	}else{
		l= strlen( objInfo.name ) +1;
		rsz += l;
	}
#ifdef	WINENCODE
	if (b_recode) Recoding( cd_dos, cd_win, sLongName );
	if (b_recode) Recoding( cd_dos, cd_win, objInfo.name );
#endif
	if( objInfo.size )
		rsz += objInfo.size;
	else
	    gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "о≈‘ ƒЅќќў» ƒћ— ѕ¬я≈Ћ‘Ѕ %d\n", me - REAL_DOC_OFFS);

	char * bf;
#ifndef WITH_DBL_THREAD
	bf= (char*) malloc(rsz);
#else
	if(objInfo.packed)
		bf= (char*)objData + *(long*)objInfo.reserved;
	else
		bf= (char*)objData;
#endif
	char *ptr = bf;
	memcpy(ptr, &objInfo, sizeof(ObjInfo));
	ptr+=sizeof(ObjInfo);
#ifndef WITH_DBL_THREAD
	memcpy(ptr, objData, objInfo.size);
#endif
	ptr+=objInfo.size;
	if( sLongNameSz  ){
		*(u_int32_t*)ptr = sLongNameSz;
		ptr+=sizeof(u_int32_t);
		memcpy(ptr, sLongName, sLongNameSz);
	}else{
		*(u_int32_t*)ptr = l;
		ptr+=sizeof(u_int32_t);
		memcpy(ptr, objInfo.name, l);
	}
	dbproc->setBlobData (me, bf, rsz);
#ifndef WITH_DBL_THREAD
	free( bf );
#endif
	if( belongsSet.length() ){
		int l =  belongsSet.length();
		short * ba;
#ifndef WITH_DBL_THREAD
		ba =  (short*)malloc(sizeof(short)* l );
#else
		if( ((long)sizeof(short))*l + (long)sizeof(ObjInfo) > objDataMaxSize ) {
			objDataMaxSize = sizeof(short)*l*2 + sizeof(ObjInfo);
			objData = realloc( objData, objDataMaxSize );
		}
		ba= (short*)objData;
#endif
		int n =0;
		for( Pix i=belongsSet.first(); i; belongsSet.next(i) )
			ba[n++] = (short)(belongsSet(i));
		dbproc->setBlobBelongs(me, ba, n );
		if (objInfo.type == EOT_XLS || objInfo.type == EOT_RTF)
			dbproc->setBlobFormsBelongs(me, ba, n );
#ifndef WITH_DBL_THREAD
		free(ba);
#endif
	}else{
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "п¬я≈Ћ‘ %ld ќ≈ –“…ќЅƒћ≈÷…‘ ќ… Ћ ЋЅЋѕ  ¬ЅЏ≈.\n", DocId-REAL_DOC_OFFS);
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "(п¬я≈Ћ‘ ƒѕћ÷≈ќ –“…ќЅƒћ≈÷Ѕ‘Ў »ѕ‘—-¬ў Ћ ѕƒќѕ  ¬ЅЏ≈)\n");
	}
	me = 0;
	baddoc_andskip = false;
	objType = 0;
	return 1;
}

long	my_table_row_cell_id;

static int	my_evd_buffer_length;
static char	my_evd_buffer [256]
#ifdef PTRS_IN_META
								, idd_evd_buffer[64*1024*1024]
#else
								, idd_evd_buffer[BUFSIZE]
#endif
																, *idd_evd_buffer_ptr= idd_evd_buffer;

struct MyWriter : public evd::UserWriter {
public:
	long write (unsigned char* buffer, long buffer_size) {
		my_evd_buffer_length = buffer_size + sizeof (long) + sizeof (char);
		memcpy (my_evd_buffer, &my_table_row_cell_id, sizeof (long));
		my_evd_buffer [4] = (char) (buffer_size & 0xFF);
		memcpy (my_evd_buffer+5, buffer, buffer_size);
		return 0;
	}
};

void nsrcParser :: finishTopic()
{
	if (!me)
		return;

	if (isBlob) {
		finishBlob ();
		return;
	}

/*
#ifdef	_DEBUG
	{
	for (std::map<long,long>::const_iterator it = map_subdescexid_allleafparacount.begin (); it != map_subdescexid_allleafparacount.end (); it++) {
		printf ("%ld(%ld).%ld\n", map_subdescexid_to_id.find (it->first)->second, it->first, it->second);
	}
	}
#endif
*/

	if (cell_ids.size () || row_ids.size () || table_ids.size ()) {
		while (cell_ids.size ())
			cell_ids.pop ();
		while (row_ids.size ())
			row_ids.pop ();
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "¬ документе есть незакрытые €чейки/строки таблиц или таблицы\n");
	}

#ifdef VERSION56
	if (cinfo && !Info.nextEdition) {
		VerLink::const_iterator i=cinfo->m_next->find(me);
		if (i!=cinfo->m_next->end()) {
			if (cinfo->bad_docs->find (i->second) == cinfo->bad_docs->end ())
				Info.nextEdition=i->second;
		}
	}

	if (dsActivity.size ()) {
		date adate = dsActivity.begin()->from;
		if (Info.prevEdition)
			dbproc->addTopicCalCh (me, adate);
		else
			dbproc->addTopicCalIn (me, adate);
	} else {
		if (FirstDate.da_year && !Info.prevEdition && ((Info.Status & DS_NOTTM) == 0))
			dbproc->addTopicCalIn (me, FirstDate);
	}

	if (dVIncluded.da_year || dVAnonced.da_year) {
		if (!dVIncluded.da_year) dVIncluded.da_year = 2099;
		if (!dVAnonced.da_year) dVAnonced.da_year = 2099;
		if (is_lt (dVAnonced, dVIncluded))
			dbproc->addTopicSortDate(me, dVAnonced);
		else
			dbproc->addTopicSortDate(me, dVIncluded);
	}

	if ( (( Info.Status & DS_NOTTM ) == 0 ) && bIsPrefixDocuments && dsActivity.size() == 0 && docDate.da_year ) {
		if ( !( Info.Status & DS_ABOLISHED )) {
			DocActivityEx docActivity= { 0 };
			docActivity.b_add_iddactive = true;
			docActivity.from = docDate;
			dsActivity.insert (docActivity);
		}
	}

	if ( bIsPrefixInternational && dsActivity.size() == 0 )
		Info.Status |= DS_NOTTM;
#endif

	if (bShowActiveToWarning && (wasWarning == 2 || wasWarning == 3 || wasWarning == 7 || wasWarning == 12 || wasWarning == 13 || wasWarning == 19 || wasWarning == 31 || wasWarning == 33 || wasWarning == 40))
		gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "ƒата \"ѕо\" в команде !ACTIVE больше текущей.\n");

	if ( docRDate.da_year ) {
		if ( !docDate.da_year ) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, " оманда !RDATE не может быть использована без !DATE\n" );
		}
		if ( dateCmp( docDate, docRDate ) > 0 ) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "¬ команде !DATE дата больше, чем в !RDATE\n" );
		}
	}

    // это то, что надо (документ?), но VINCLUDED не указан
	if (!bIsNoDoc && !bVIncludedSet && ref_vincluded_check && !( Info.Status & DS_EDITION ))
		gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "ќтсутствует команда !VINCLUDED в топике с признаком DOC.\n");

	int *docBases = 0;
	int nDocBases= 0;

	endPara();

#ifdef	VERSION56
	if (cinfo && me && cinfo->vlcontrols->contains(me) && !bEnglish) {
		dbproc->addTopicEmptyPara(me); endParaEx ();
		paraCount++; cpn++;
		const char* ss = "!STYLE J 1 72 1";
		CMD_CALL(STYLE,mkNewPara,ss,15);
		strcpy( (char*)paraBuf, " Н†бвЃпй®© §Ѓ™гђ•≠в б≠пв б ™Ѓ≠ваЃЂп" );
		paraBufPos = strlen( (char*)paraBuf );
		endPara(); endParaEx ();
		dbproc->addTopicEmptyPara(me);
		paraCount++; cpn++;
	}
#endif

	if (cpn == 0) {
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "“опик %ld не содержит параграфов.\n", me - REAL_DOC_OFFS);
		dbproc->addTopicEmptyPara(me);
		paraCount++;
	}

#ifdef	BLOCKSINHERIT
	if ( lastFlushedSub != lastSub ) {
		lastFlushedSub = lastSub;

		if ( lastSubsPos && lastSubs[ lastSubsPos - 1 ] != lastSub ) {
			lastSubs[ lastSubsPos ] = lastSub;
			lastSubsPos++;
			flushSub();
			lastSubsPos--;
		}else {
			flushSub();
		}

	}
#else
	flushSub();
#endif

	if ( lastSubsPos ) {
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "“опик %ld содержит незакрытые блоки.\n", me - REAL_DOC_OFFS);
		for (int i = 0; i < lastSubsPos; i++)
			CMD_CALL(BLOCKEND, doBlockEnd, "!BLOCKEND", strlen ("!BLOCKEND"));
	}

	if( subIdx > 0 ){
		paraCount++; //?
		/*
		SubDesc *to = subsTmp, *from = to;
		for (int asub = 0; asub < subIdx; asub++, from++) {
			if (real_subs.find (from->Sub) != real_subs.end ()) {
				memcpy (to, from, sizeof (SubDesc));
				to++;
			}
		}
		qsort (subsTmp, real_subs.size (), sizeof (SubDesc), compare_subdesc);
		*/
		qsort (subsTmp, subIdx, sizeof (SubDesc), compare_subdesc);
		dbproc->setTopicSubDesc (me, subsTmp, subIdx);
	}

	if (subExIdx) {
		qsort (subsExTmp, subExIdx, sizeof (SubDescEx), compare_subdescex);
		//dbproc->setTopicSubDescEx (me, subsExTmp,subExIdx);
	}

	if (table_ids.size () || fatal_table_errors) {
		map_subdescexid_lastpara.insert (std::map<long,long>::value_type (0, cpn/*dbproc->para_count*/));

		gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "¬ документе есть незакрытые/неверные таблицы. —труктура документа будет пустой, пока они не будут исправлены\n");
		while (table_ids.size ())
			table_ids.pop ();
		DocStruct *docstruct = new DocStruct;
		docstruct->m_id = map_subdescexid_levelandlevelid.find (0)->second;
		docstruct->m_para_list_id = map_subdescexid_to_id.find (0)->second;
		docstruct->m_start_para = docstruct->m_first_child = docstruct->m_last_child = 0;
		docstruct->m_end_para = map_subdescexid_lastpara.find (0)->second - 1;
		docstruct->m_para_list_type = (SUBDESCEX_DOCUMENT << 24) + docstruct->m_end_para + 1;
		dbproc->setTopicDocStruct (me, docstruct, 1);
		delete docstruct;
	} else if (subdescexids_instruct.size ()) {
		map_subdescexid_lastpara.insert (std::map<long,long>::value_type (0, cpn));

		long count = subdescexids_instruct.size (), non_empty_count = 0;;
		DocStruct *docstructs = new DocStruct [count], *ptr = docstructs;

		std::map<long,long> decrease_levelid;
		for (std::vector<long>::const_iterator it = subdescexids_instruct.begin (); it != subdescexids_instruct.end (); it++) {
			long id = *it;
			ptr->m_id = map_subdescexid_levelandlevelid.find (id)->second;
			ptr->m_para_list_id = map_subdescexid_to_id.find (id)->second;
			ptr->m_para_list_type = (map_subdescexid_type.find (id)->second << 24) + map_subdescexid_allleafparacount.find (id)->second;
			ptr->m_start_para = map_subdescexid_firstpara.find (id)->second;
			ptr->m_end_para = map_subdescexid_lastpara.find (id)->second;
			if (ptr->m_start_para == ptr->m_end_para && map_subdescexid_type.find (id)->second == SUBDESCEX_BLOCK) {
				//пустой блок, выкидываем. ј всем последующим запис€м надо на 1 уменьшить level_id
				for (std::vector<long>::const_iterator it2 = it; it2 != subdescexids_instruct.end (); it2++) {
					long id2 = *it2, levelandlevelid = map_subdescexid_levelandlevelid.find (id2)->second;
					if ((levelandlevelid & 0xFF000000) == (ptr->m_id & 0xFF000000)) {
						std::map<long,long>::iterator map_it = decrease_levelid.find (levelandlevelid);
						if (map_it == decrease_levelid.end ())
							decrease_levelid.insert (std::map<long,long>::value_type (levelandlevelid, 1));
						else
							map_it->second++;
					}
				}
			} else {
				ptr->m_end_para--; //ƒима заказал, чтобы не писать -1 везде...
				std::map<long,long>::const_iterator map_it = map_subdescexid_firstchildid.find (id);
				if (map_it == map_subdescexid_firstchildid.end ())
					ptr->m_first_child = 0;
				else
					ptr->m_first_child = map_subdescexid_levelandlevelid.find (map_it->second)->second;
				map_it = map_subdescexid_lastchildid.find (id);
				if (map_it == map_subdescexid_lastchildid.end ())
					ptr->m_last_child = 0;
				else
					ptr->m_last_child = map_subdescexid_levelandlevelid.find (map_it->second)->second;
				ptr++;
				non_empty_count++;
			}
		}
		if (count != non_empty_count) {
			gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "¬ документе есть пустые блоки. —труктура документа будет пустой, пока не будут удалены пустые блоки\n");
			docstructs [0].m_para_list_type = (SUBDESCEX_DOCUMENT << 24) + docstructs [0].m_end_para + 1;
			docstructs [0].m_first_child = docstructs [0].m_last_child = 0;
			dbproc->setTopicDocStruct (me, docstructs, 1);
		} else {
			qsort (docstructs, count, sizeof (DocStruct), compare_docstruct);
			std::map<long,long> mid_position;
			long i;
			for (ptr = docstructs, i = 0; i < count; i++,ptr++)
				mid_position.insert (std::map<long,long>::value_type (ptr->m_id, i));
			for (ptr = docstructs, i = 0; i < count; i++,ptr++) {
				std::map<long,long>::const_iterator map_it = decrease_levelid.find (ptr->m_id);
				if (map_it != decrease_levelid.end ())
					ptr->m_id -= map_it->second;
				if (ptr->m_first_child) {
					std::map<long,long>::const_iterator map_it = mid_position.find (ptr->m_first_child);
					if (map_it != mid_position.end ())
						ptr->m_first_child = map_it->second;
				}
				if (ptr->m_last_child) {
					std::map<long,long>::const_iterator map_it = mid_position.find (ptr->m_last_child);
					if (map_it != mid_position.end ())
						ptr->m_last_child = map_it->second;
				}
			}
			dbproc->setTopicDocStruct (me, docstructs, count);
		}
#ifdef PTRS_IN_META
  #ifdef PTRS_ONLY
  #else
		delete [] docstructs;
  #endif
#else
		delete [] docstructs;
#endif
	}

	if (map_tableid_zoom.size () || map_tableid_leftindent.size ()) {
		for (std::map<long,long>::const_iterator it = map_tableid_type.begin (); it != map_tableid_type.end (); it++) {
			long table_id = it->first;
			std::map<long,long>::const_iterator zoom_it = map_tableid_zoom.find (table_id), leftindent_it = map_tableid_leftindent.find (table_id);
			if ((zoom_it != map_tableid_zoom.end ()) || (leftindent_it != map_tableid_leftindent.end ())) {
				long table_type = it->second;
				my_table_row_cell_id = table_id;
				MyWriter writer;
				evd::IeeGenerator_var generator = new evd::EeGenerator_i (&writer, sizeof (my_evd_buffer));

				generator->Start ();
					generator->StartChild(table_type);
						if (zoom_it != map_tableid_zoom.end ())
							generator->AddIntegerAtom (evd::ti_Zoom, zoom_it->second);
						if (leftindent_it != map_tableid_leftindent.end ())
							generator->AddIntegerAtom (evd::ti_LeftIndent, leftindent_it->second);
					generator->Finish();
				generator->Finish();
				if(((idd_evd_buffer_ptr-idd_evd_buffer)+my_evd_buffer_length > 32*1024*1024) || my_evd_buffer_length > 256) {
					fprintf(stderr, "\nERROR, idd_evd_buffer overflow\n");
					getch ();
				}
				memcpy (idd_evd_buffer_ptr, my_evd_buffer, my_evd_buffer_length);
				idd_evd_buffer_ptr += my_evd_buffer_length;
			}
		}
	}
	
	std::set<long> processed_blocks;
	std::map<long,long>::const_iterator map_style_it, map_location_it;
	if (blocks_in_contents.size ()) {
		for (std::set<long>::const_iterator it = blocks_in_contents.begin (); it != blocks_in_contents.end (); it++) {
			long block = *it;
			if (blocks_woname.find (block) != blocks_woname.end ())
				continue;
			my_table_row_cell_id = -block;
			MyWriter writer;
			evd::IeeGenerator_var generator = new evd::EeGenerator_i (&writer, sizeof (my_evd_buffer));
			generator->Start ();
					generator->StartChild(evd::id_Block);
						processed_blocks.insert (block);
						generator->AddIntegerAtom (evd::ti_InContents, EVD::sp_InContentsAndOnSubPanel);

						map_style_it = map_block_style.find (block);
						if (map_style_it != map_block_style.end ())
							generator->AddIntegerAtom (evd::ti_Style, map_style_it->second);
						map_location_it = map_block_location.find (block);
						if (map_location_it != map_block_location.end ())
							generator->AddIntegerAtom (evd::ti_ViewKind, map_location_it->second);
					generator->Finish();
			generator->Finish();
			if(((idd_evd_buffer_ptr - idd_evd_buffer) + my_evd_buffer_length > 32*1024*1024) || my_evd_buffer_length > 256) {
				fprintf (stderr, "\nERROR, idd_evd_buffer overflow\n");
				getch ();
			}
			memcpy (idd_evd_buffer_ptr, my_evd_buffer, my_evd_buffer_length);
			idd_evd_buffer_ptr += my_evd_buffer_length;
		}
	}

	/*
	for (std::set<long>::const_iterator block_it = processed_subsblocks.begin (); block_it != processed_subsblocks.end (); block_it++) {
		long block = *block_it;
		if (blocks_in_contents.find (block) != blocks_in_contents.end ())
			continue;
		if (processed_subs.find (block) != processed_subs.end ())
			continue;

		my_generator obj;
		my_table_row_cell_id = -block;
		evd::IeeGenerator_var generator = new evd::EeGenerator_i (my_callback, &obj, sizeof (my_evd_buffer));
		generator->Start ();
				generator->StartChild(evd::id_Block);
					processed_blocks.insert (block);
					generator->AddIntegerAtom (evd::ti_InContents, EVD::sp_OnlyOnSubPanel);

					map_style_it = map_block_style.find (block);
					if (map_style_it != map_block_style.end ())
						generator->AddIntegerAtom (evd::ti_Style, map_style_it->second);
					map_location_it = map_block_location.find (block);
					if (map_location_it != map_block_location.end ())
						generator->AddIntegerAtom (evd::ti_ViewKind, map_location_it->second);
				generator->Finish();
		generator->Finish();
		if(((idd_evd_buffer_ptr - idd_evd_buffer) + my_evd_buffer_length > 32*1024*1024) || my_evd_buffer_length > 256) {
			fprintf (stderr, "\nERROR, idd_evd_buffer overflow\n");
			getch ();
		}
		memcpy (idd_evd_buffer_ptr, my_evd_buffer, my_evd_buffer_length);
		idd_evd_buffer_ptr += my_evd_buffer_length;

	}
	*/
	
	for (map_style_it = map_block_style.begin (); map_style_it != map_block_style.end (); map_style_it++) {
		long block = map_style_it->first;
		if (processed_blocks.find (block) == processed_blocks.end ()) {
			processed_blocks.insert (block);

			my_table_row_cell_id = -block;
			MyWriter writer;
			evd::IeeGenerator_var generator = new evd::EeGenerator_i (&writer, sizeof (my_evd_buffer));
			generator->Start ();
					generator->StartChild(evd::id_Block);
						generator->AddIntegerAtom (evd::ti_Style, map_style_it->second);						
						map_location_it = map_block_location.find (block);
						if (map_location_it != map_block_location.end ())
							generator->AddIntegerAtom (evd::ti_ViewKind, map_location_it->second);
					generator->Finish();
			generator->Finish();
			memcpy (idd_evd_buffer_ptr, my_evd_buffer, my_evd_buffer_length);
			idd_evd_buffer_ptr += my_evd_buffer_length;
		}
	}
	for (map_location_it = map_block_location.begin (); map_location_it != map_block_location.end (); map_location_it++) {
		long block = map_location_it->first;
		if (processed_blocks.find (block) == processed_blocks.end ()) {
			my_table_row_cell_id = -block;
			MyWriter writer;
			evd::IeeGenerator_var generator = new evd::EeGenerator_i (&writer, sizeof (my_evd_buffer));
			generator->Start ();
					generator->StartChild(evd::id_Block);
						generator->AddIntegerAtom (evd::ti_ViewKind, map_location_it->second);
					generator->Finish();
			generator->Finish();
			memcpy (idd_evd_buffer_ptr, my_evd_buffer, my_evd_buffer_length);
			idd_evd_buffer_ptr += my_evd_buffer_length;
		}
	}

	if (idd_evd_buffer_ptr != idd_evd_buffer) {
		dbproc->addTopicEvd (me, idd_evd_buffer, idd_evd_buffer_ptr - idd_evd_buffer);
		idd_evd_buffer_ptr = idd_evd_buffer;
	}

	if( sLongNameSz  ) {
		sLongName[sLongNameSz++] = 0;
		dbproc->setTopicName(me,sLongName,sLongNameSz);
	} else {
		int l = strlen( Info.Title );
		if( l )
			dbproc->setTopicName( me, Info.Title, l+1 );
	}

	finishSources();

	if (gprefixSet.length () && !docPrefixes->length ())
		if (!b_was_doc && !std::binary_search (cinfo->docs_with_class->begin (), cinfo->docs_with_class->end (), me))
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ќтсутствует команда CLASS.\n");

	// adding all classes
	Pix i;

	for (i = docPrefixes->first(); i; docPrefixes->next(i) ) {
		union DocClass dc;
		dc.asint = (*docPrefixes)(i); 
		int pfxId = dc.asref.id;
		int sub = dc.asref.sub;

		dbproc->add2PrefixIndex(ci->pfxInfo[pfxId].prefixName, ci->pfxInfo[pfxId].nameLength,me,sub);
	}

	for (i = docClasses->first(); i; docClasses->next(i) ) {
		union DocClass dc;
		dc.asint = (*docClasses)(i); 
		int clId = dc.asref.id;
		int sub = dc.asref.sub;

		dbproc->add2ClassIndex( ci->clInfo[clId].className, ci->clInfo[clId].nameLength, me, sub);
	}

#ifdef VERSION56
	if (Info.Status & DS_EDITION) {
		Info.Status |= DS_NODOC;
		Info.Status &= ~DS_DOC;
	}
#endif

	if (!(Info.Status & DS_DOC) && !(Info.Status & DS_NODOC)) {
		if (!cinfo->notADocs->contains(me) && (Info.Status || sLongNameSz)) {
			Info.Status |= DS_DOC;
			//gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "о≈ѕ–“≈ƒ≈ћ≈ќќў  ‘…– ƒѕЋ’Ќ≈ќ‘Ѕ …Ќ≈јЁ≈«ѕ ”‘Ѕ‘’”. чў”‘Ѕ„ћ—≈‘”— ‘…– DS_DOC. Topic %ld.\n", me - REAL_DOC_OFFS);
		} else {
			Info.Status |= DS_NODOC;
			if (!cinfo->notADocs->contains(me)) {
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "о≈ѕ–“≈ƒ≈ћ≈ќќў  ‘…– ƒѕЋ’Ќ≈ќ‘Ѕ ќ≈ …Ќ≈јЁ≈«ѕ ”‘Ѕ‘’”. чў”‘Ѕ„ћ—≈‘”— ‘…– DS_NODOC. Topic %ld.\n", me - REAL_DOC_OFFS);
				cinfo->notADocs->add(DocId);
			}
		}
	}

	if ( ( Info.Status & DS_DOC ) && ! ( Info.Status & DS_EDITION )) {
		if( (Info.Status & DS_MOJREG) && (Info.Status & DS_MOJNOTREG) ) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "р“≈ƒўƒ’Ё…  ‘ѕ–…Ћ %ld ќ≈ Ќѕ÷≈‘ …Ќ≈‘Ў (!RCODE …ћ… !RDATE) „Ќ≈”‘≈ ” !MOJNOTREG.\n", me - REAL_DOC_OFFS);
		}
		if( ! (Info.Status & ( DS_MOJREG | DS_MOJNOTREG) ) ) 
			Info.Status |= DS_MOJOTHER;
		if( !(Info.Status & (DS_ABOLISHED|DS_PREACTIVE) ) ) {
#ifdef VERSION56
			Activity::const_iterator j=dsActivity.begin();
			if (j==dsActivity.end()) {
				Info.Status |= DS_ACTIVE;
			} else {
				while (j!=dsActivity.end()) {
					if (is_in(todayDate, *j++)) {
						Info.Status |= DS_ACTIVE;
						break;
					}
				}
				if (!(Info.Status & DS_ACTIVE)) {
					j=dsActivity.begin();
					if ( is_eq(todayDate,j->from))
						Info.Status |= DS_ACTIVE;
					else
					if ( is_lt(todayDate,j->from))
						Info.Status |= DS_PREACTIVE;
					else
						Info.Status |= DS_ABOLISHED;
				}
			}
#else
			Info.Status |= DS_ACTIVE;
#endif
		}

	}
	
	if (dsActivity.size () && (Info.Status & DS_DOC) && !Info.nextEdition) {
		date adate = dsActivity.begin()->to;
		if (adate.da_year) {
			adate = date_plusdays (adate, 1);
			dbproc->addTopicCalAb (me, adate);
		}
	}

	if ( Info.Status & DS_DOC ) {
		if( (Info.Status & (DS_ACTIVE|DS_ABOLISHED|DS_PREACTIVE)) == Info.Status ) {
			Info.Status |= DS_ACTIVE;
			gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "о≈ѕ–“≈ƒ≈ћ≈ќќў  ”‘Ѕ‘’” ƒѕЋ’Ќ≈ќ‘Ѕ. чў”‘Ѕ„ћ—≈‘”— ”‘Ѕ‘’” DS_ACTIVE. Topic %ld.\n", me - REAL_DOC_OFFS);
		}
		
		if( (Info.Status & (DS_MOJREG|DS_MOJNOTREG|DS_MOJOTHER)) == Info.Status ) {
			Info.Status |= DS_MOJOTHER;
			gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "о≈ѕ–“≈ƒ≈ћ≈ќќЅ— “≈«…”‘“Ѕ√…— ƒѕЋ’Ќ≈ќ‘Ѕ. чў”‘Ѕ„ћ—≈‘”— “≈«…”‘“Ѕ√…— DS_MOJOTHER. Topic %ld.\n", me - REAL_DOC_OFFS);
		}
	}

	/*
	if ((b_prefix_is_sudebnaya && Info.LastDate.da_year && is_lt (Info.LastDate, date_1_1_2008)) ||
		(b_prefix_is_comment && Info.LastDate.da_year && is_lt (Info.LastDate, date_1_1_2008)) || 
		(b_source_is_lowrele) ||
		(b_type_is_letter && Info.LastDate.da_year && is_lt (Info.LastDate, date_1_1_2008)))
		Info.Status_ex |= DS_IZM;
	*/

	if (Info.LastDate.da_year && is_lt (Info.LastDate, date_1_1_2013))
		Info.Status_ex |= DS_DATE;

	if ( Info.Status & DS_EDITION ) {
		if ( !dsActivity.size() && !( Info.Status & ( DS_ABOLISHED | DS_PREACTIVE ))) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "–едакци€ %ld имеет неопределенный интервал действи€.\n", me - REAL_DOC_OFFS);
			dsActivity.clear();
		}
	} 

	dbproc->setTopicStatus_exex (me, GetDocStatusExEx (&Info));

	if (Info.Status_ex & DS_NOCOMPARE)
		dbproc->setTopicStatus_ex (me, DS_NOCOMPARE, 0);
	if (Info.Status_ex & DS_IZM)
		dbproc->setTopicStatus_ex (me, DS_IZM, 0);
	if (Info.Status_ex & DS_DATE)
		dbproc->setTopicStatus_ex (me, DS_DATE, 0);

	if (Info.Status_ex & (DS_NARCOTIC|DS_NOTNARCOTIC))
		dbproc->setTopicStatus_ex (me, Info.Status_ex & (DS_NARCOTIC|DS_NOTNARCOTIC),0);
	if (Info.Status_ex & (DS_MEDTOPIC|DS_MDICTTOPIC|DS_FIRMTOPIC))
		dbproc->setTopicStatus_ex (me, Info.Status_ex & (DS_MEDTOPIC|DS_MDICTTOPIC|DS_FIRMTOPIC),0);

	if( Info.Status & (DS_EDITION|DS_NODOC|DS_ANNO))
		dbproc->setTopicStatus(me, Info.Status );
	if( Info.Status & DS_DOC ) {
		dbproc->setTopicStatus(me, Info.Status );
		if ( norm ) {
			dbproc->setTopicCategory(me,norm->chars(),norm->length()+1);
		} else {
			dbproc->setTopicCategory(me,normInfo->default_->chars(),normInfo->default_->length()+1);
		}
	} else {
		if ( norm )
			dbproc->setTopicCategory(me,norm->chars(),norm->length()+1);
		else
			dbproc->setTopicCategory(me,normInfo->default_->chars(),normInfo->default_->length()+1);
	}

	if (b_fastfakeattrs && !b_was_kind && (Info.Status & (DS_DOC | DS_EDITION))) {
		char kind [300];
		strcpy (kind, "$DUMMY$");
		dbproc->addTopicKind (kind, sizeof (kind), me, 0);
	}

	if (tradename) {
		dbproc->setTopicTradeName (me, tradename->chars (), tradename->length () + 1);
		tradename->bDoFree = 1;
		delete tradename;
		tradename = 0;
	}
	if (intname) {
		dbproc->setTopicIntName (me, intname->chars (), intname->length () + 1);
		intname->bDoFree = 1;
		delete intname;
		intname = 0;
	}

	if( norm ) {
		norm->bDoFree = 1;
		delete norm;
		norm = 0;
	}
	if (tradename) {
		tradename->bDoFree = 1;
		delete tradename;
		tradename = 0;
	}
	if (intname) {
		intname->bDoFree = 1;
		delete intname;
		intname = 0;
	}
	void *local_data = 0;
	if( belongsSet.length() ){
		int l =  belongsSet.length();
		short *ba;
#ifndef WITH_DBL_THREAD
		docBases = (int*) malloc(sizeof(int*)*l);
		ba =  (short*)malloc(sizeof(short)* l );
#else
		long size = (sizeof(int*)+sizeof(short))*l*2;
		local_data = malloc (size);
		ba= (short*)local_data;
		docBases = (int*)(ba+l);
#endif
		for( Pix i=belongsSet.first(); i; belongsSet.next(i) ){
			short seg = (short) (belongsSet(i) & 0xFFFF);
			docBases[ nDocBases ] = seg;
			ba [nDocBases] = seg;
			nDocBases ++;
		}
		dbproc->setTopicBelongs(me, ba, nDocBases);
#ifndef WITH_DBL_THREAD
		free(ba);
#endif
		checkEditionHere(me, Info.prevEdition, Info.nextEdition);

		long tmp = DICTIONARY_SEGMENT;
		if (belongsSet.contains (tmp) && !bwasNamedTerm)
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "” топика (%ld), принадлежащего “олковому —ловарю, нет ни одного термина.\n", DocId-REAL_DOC_OFFS);
	}else{
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "фѕ–…Ћ %ld ќ≈ –“…ќЅƒћ≈÷…‘ ќ… Ћ ЋЅЋѕ  ¬ЅЏ≈.\n", DocId-REAL_DOC_OFFS);
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "(фѕ–…Ћ ƒѕћ÷≈ќ –“…ќЅƒћ≈÷Ѕ‘Ў »ѕ‘—-¬ў Ћ ѕƒќѕ  ¬ЅЏ≈)\n");
	}

	/*
	if ( !bwasChDate && ( Info.Status & DS_EDITION )) {
		gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "” топика (%ld) есть !EDITION, но нет команды !CHDATE\n", DocId-REAL_DOC_OFFS);
	}
	*/
	if ( wasVerlink && !bwasChDate ) {
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "” топика (%ld) есть !VERLINK, но нет команды !CHDATE\n", DocId-REAL_DOC_OFFS);
	}
	if ( Info.prevEdition && typeSet[0]->length() == 0 && sourcesSet.length() == 0 ) {
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "” топика (%ld) есть !VERLINK, но нет команды !SOURCE или !TYPE\n", DocId-REAL_DOC_OFFS);
	}

	if( dsVchanged.length() ){
		if( !bVIncludedSet ){
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "лѕЌЅќƒЅ VCHANGED ’ЋЅЏЅќЅ „ ‘ѕ–…Ћ≈ %ld\n", DocId);
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "„ ‘ѕ „“≈Ќ— ЋЅЋ VINCLUDED –“ѕ–’Ё≈ќЅ.\n");
		}
		for( Pix i = dsVchanged.first(); i; dsVchanged.next(i) ){
			date & d = dsVchanged(i);
			dbproc->addTopicVChanged(me, d );
		}
	}
#ifdef VERSION56
	if ((Info.Status & DS_NOTTM) && dsActivity.size()) {
		if (Info.Status & DS_PREACTIVE) {
			DocActivityEx da = *dsActivity.begin ();
			if (da.from.da_year + da.to.da_year) {
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ќдновременно указаны NOTTM и ACTIVE\n" );
				dsActivity.clear();
			}
		} else {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ќдновременно указаны NOTTM и ACTIVE\n" );
			dsActivity.clear();
		}
	}

	if (!is_ok(dsActivity)) {
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ѕересечение интервалов активности (!ACTIVE).\n");
	}
	if (dsActivity.size ()) {
		for (Activity::iterator j=dsActivity.begin(); j!=dsActivity.end(); j++)
			dbproc->addTopicActivity(me, *j);
	} else if (Info.FirstDate.da_year) {
		DocActivityEx docActivity = { 0 };
		docActivity.b_add_iddactive = false;
		docActivity.from = Info.FirstDate;
		dbproc->addTopicActivity (me, docActivity);
	}
	for (ChDate::iterator cj=dsChDate.begin(); cj!=dsChDate.end(); cj++) {
		dbproc->addTopicChDate(me, *cj);
	}
	for (ChDateExes::iterator cj=dsChDateEx.begin(); cj!=dsChDateEx.end(); cj++) {
		dbproc->addTopicChDateEx(me, *cj);
	}
	for (Pages::iterator pj=dsPage.begin(); pj!=dsPage.end(); pj++) {
		dbproc->addTopicPages(me, *pj);
	}

	if (!wascontents0 && dsContents.size()) {
		ContentsStruct contents = { 0,2,2 };
		dsContents.insert (contents);
	}
	for (Contents::iterator coj = dsContents.begin(); coj != dsContents.end(); coj++) {
		dbproc->addTopicContents(me, *coj );
		CompareContents::iterator cc_it = dsCompareContents.end ();
		for (CompareContents::const_iterator ccit = dsCompareContents.begin (); ccit != dsCompareContents.end (); ccit++) {
			if (ccit->Sub == coj->Sub) {
				cc_it == ccit;
				break;
			}
		}
		if (cc_it == dsCompareContents.end ()) {
			CompareContentsStruct contents = {coj->Sub, coj->Size};
			dsCompareContents.insert (contents);
		} else {
			CompareContentsStruct contents = {coj->Sub, std::max <short> (cc_it->Levels, coj->Size)};
			dsCompareContents.erase (cc_it);
			dsCompareContents.insert (contents);
		}
	}
	for (CompareContents::iterator ccoj = dsCompareContents.begin(); ccoj != dsCompareContents.end(); ccoj++)
		dbproc->addTopicCompareContents (me, *ccoj);

	for (NotSure::iterator ns=dsNotSure.begin(); ns!=dsNotSure.end(); ns++) {
		dbproc->addTopicNotSure(me, *ns);
	}
	for (Divisions::iterator di=dsDivisions.begin(); di!=dsDivisions.end(); di++) {
		dbproc->addTopicDivision(me, *di);
	}
#endif

	for(int ii = 0; ii< nDocBases; ii++ ){
		BaseCore *binfo = &(basesCore[ docBases[ii]]);
		if( thatsSplashTopic ){
			if( binfo->splashTopic ){
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "лѕЌЅќƒЅ SPLASH ’÷≈ ’ЋЅЏЅќЅ.\n");
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "ф≈Ћ’Ё…  ‘ѕ–…Ћ %ld, рѕЌ≈ё≈ќќў  “Ѕќ≈≈ ‘ѕ–…Ћ %ld\n", DocId, binfo->splashTopic);
			}else{
				binfo->splashTopic = DocId;
			}
		}
		if( thatsBannerTopic ){
			if( binfo->bannerTopic ){
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "лѕЌЅќƒЅ BANNER ’÷≈ ’ЋЅЏЅќЅ.\n");
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "ф≈Ћ’Ё…  ‘ѕ–…Ћ %ld, рѕЌ≈ё≈ќќў  “Ѕќ≈≈ ‘ѕ–…Ћ %ld\n", DocId, binfo->bannerTopic);
			}else{
				binfo->bannerTopic = DocId;
			}
		}
	}
	if (Info.GreenComments % 2)
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈–Ѕ“ќў≈ green comments\n");
	Info.GreenComments /= 2;

	if (ctprio == DEFAULT_TOPIC_PRIORITY)
		ctprio = cinfo->st2p->getp( srcsSet, typesSet);

	if ((Info.Status & DS_ABOLISHED) || (Info.Status & DS_NODOC))
		ctprio += DEFAULT_TOPIC_PRIORITY;

	if (Info.Status & DS_MOJREG)
		ctprio -= 1;
	if (bIsm)
		ctprio += 1;

	Info.Force = (short)ctprio;
	long saved_me = me;
	if ((Info.Status_ex & DS_FLASH) && !wasObjPath)
		Info.Status_ex &= ~DS_FLASH;

	dbproc->setTopicInfo (me, &Info);
	dbproc->endTopic (me
#ifdef PTRS_IN_META
							,0,0
#endif
									);
	bIsNoDoc = 0;
	bIsEdition = 0;

#ifdef	BLOCKSINHERIT
	classSet.clear();
	prefixesSet.clear();
#endif

	if (Info.Status_ex & DS_FLASH) {
		me = saved_me;
		strcpy (objInfo.name, Info.Title);
		if (finishBlob ()) {
			me = saved_me;
			dbproc->setTopicStatus_ex (me, DS_FLASH, 0);
		}
		me = 0;
		baddoc_andskip = false;
	}

#ifndef WITH_DBL_THREAD
	if( docBases )
		free(docBases);
#else
	if (local_data)
		gk_free (local_data);
#endif
}

int	getParaStyle( const char* s, int l )
{
	while( l && (*s == ' ' || *s=='\t' ) ){
	  s++;
	  l--;
	}

	if ( !l )
		return 0;

	switch( *s ){
#ifndef	VERSION61
		case 'L':
#endif
	    case 'J':
			return PS_JUSTIFIED;
			break;
	    case 'C':
			return PS_CENTERED;
			break;
	    case 'V':
			return PS_VERSION;
			break;
	    case 'R':
			return PS_RIGHT;
			break;
#ifdef	JUST_CHECKER
		case 'S':
			return bEnglish ? PS_SIDEBYSIDE : 0;
			break;
#endif
	    case 'P':
	    case 'T':
			return PS_PREFORMATTED;
			break;
#ifdef	VERSION61
		case 'L':
			return PS_LEFT;
			break;
#endif
	    default:
	        return 0;
	}
}

void nsrcParser :: mkNewPara ( const char *s, int l )
{
#if CHECK_LEVEL > 0
	if( paraStyle ){
		gclog.printf(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "рЅ“Ѕ«“Ѕ∆ ’÷≈ ”’Ё≈”‘„’≈‘.\n");
		return;
	}
#endif
	struct para_header *ph = (struct para_header *)paraFinalBuf;

	while( l && (*s == ' ' || *s=='\t' ) ){
	  s++; l--;
	}
	if( !l ) goto getout_err;				

	switch( *s ){
#ifndef	VERSION61
		case 'L':
#endif
	    case 'J':
			paraStyle = PS_JUSTIFIED;
			break;
	    case 'C':
			paraStyle = PS_CENTERED;
			break;
	    case 'V':
			paraStyle = PS_VERSION;
			break;
	    case 'R':
			paraStyle = PS_RIGHT;
			break;
#ifdef	JUST_CHECKER
			if (bEnglish)
				paraStyle = PS_SIDEBYSIDE;
			else
				goto getout_err;
			break;
#endif
		case 'P':
			paraStyle = PS_PREFORMATTED;
			break;
	    case 'T':
			paraStyle = PS_PREFORMATTED;
			break;
#ifdef	VERSION61
		case 'L':
			paraStyle = PS_LEFT;
			break;
#endif
		case '#':
			paraStyle = PS_STYLENUM;
			break;
		case 'D':
			paraStyle = PS_STYLED;
			break;
	    default:
	        goto getout_err;
	}
	
	ph->dm8 = 8;
	ph->dm0 = 0;
	ph->rlm = ph->lm = ph->rm = 0;
	styleh = 0;

	if (paraStyle == PS_STYLENUM) {
		char str [10];
		s--, l++;
		while (l) {
			l--, s++;
			if (s[0] == '#') {
				long style = atol (s+1);
				sprintf (str, "#%ld", style);
				s += strlen (str);
				l -= strlen (str);
				ph->lm = (unsigned char) (style & 0xFF);
			} else if (s[0] == 'H') {
				styleh = atol (s+1);
				sprintf (str, "H%ld", styleh);
				s += strlen (str);
				l -= strlen (str);
			} else if (s[0] == 'L') {
				long lindent = atol (s+1);
				sprintf (str, "H%ld", lindent);
				s += strlen (str);
				l -= strlen (str);
				ph->rlm = (unsigned char) (lindent & 0xFF);
			} else if (s[0] == 'J') {
				ph->rm = s[1];
				s += 2;
				l -= 2;
			}
		}
		paraBufPos = 0;
		return ;
	}

	s++; l--;
	while( l && (*s == ' ' || *s=='\t' ) ) {s++; l--;}
	if( !l ) goto getout_err;

	if( *s < '0' || *s > '9' ) goto getout_err;
	while( l && (*s >= '0' && *s <='9' ) ){
	  ph->lm *=10;
	  ph->lm+= *s - '0';
	  s++; l--;
	}
	while( l && (*s == ' ' || *s=='\t' ) ) {s++; l--;}
	if( !l ) goto getout_err;
	if( *s < '0' || *s > '9' ) goto getout_err;
	while( l && (*s >= '0' && *s <='9' ) ){
	  ph->rm *=10;
	  ph->rm+= *s - '0';
	  s++; l--;
	}
	while( l && (*s == ' ' || *s=='\t' ) ) {s++; l--;}
	if( !l ) goto getout_err;
	if( *s < '0' || *s > '9' ) goto getout_err;
	while( l && (*s >= '0' && *s <='9' ) ){
	  ph->rlm *=10;
	  ph->rlm+= *s - '0';
	  s++; l--;
	}
	if (paraStyle == PS_RIGHT && cell_ids.size ())
		ph->rlm = 111;
	while( l && (*s == ' ' || *s=='\t' ) ) {s++; l--;}
	if (l && s[0] == 'H') {
		styleh = atol (s+1);
		char str [10];
		sprintf (str, "H%ld", styleh);
		s += strlen (str);
		l -= strlen (str);
	} else {
		styleh = 0;
	}
	if (l) {
		gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "м…џќ…≈ ”…Ќ„ѕћў „ ЋѕЌЅќƒ≈ STYLE\n");
	}
	if (paraStyle == PS_CENTERED) {
	      ph->lm = ph->rm = 0;
	}else{
		if (ph->rm > 73) {
			gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "Ќеправильный параметр в команде STYLE: %d\n", ph->rm);
			ph->rm=73;
		};
		ph->rm = 73-ph->rm;
	}
	paraBufPos = 0;
	goto getout;

getout_err:
	gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќЅ— ЋѕЌЅќƒЅ STYLE\n");
	paraStyle= 0;

getout:
	return;
}

void nsrcParser :: doKey (const char *s, int l)
{
	gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,  " оманда игнорируетс€.\n");
}

void nsrcParser :: doSource( const char *s, int l)
{
	if (lastSub) {
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, " оманда SOURCE недопустима в %d сабе.\n",lastSub);
		return;
	}

	const char *tptr = (const char *)0;
	int tl = CMD_CALL3(SOURCE,getChars,s,l,tptr);
	if( tl ) {
		FString t(tptr,tl); t.bDoFree = 1;
		if( si->sm->contains(t) ) {
			int srcn = (*(si->sm))[t];
			if( !sourcesSet.contains(srcn) ) {
				sourcesSet.add(srcn);
				if(!srcsSet->seek(t)){
					srcsSet->add(t);
					t.bDoFree = 0;
				}
			} else {
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "ПЃҐвЃапой®©бп ®бвЃз≠®™ '%s'\n", t.chars());
			}
		} else {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© ®бвЃз≠®™ '%s'\n", t.chars());
		}
	} else {
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў SOURCE.\n");
	}
}

void nsrcParser :: finishSources()
{
	if (sourcesSet.length() == 0 && territorySet.length() == 0)
		return;

	if (sourcesSet.length() == 0 && territorySet.length() != 0) {
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ќтсутствует команда SOURCE в 0 сабе топика %d.\n",me);
		sourcesSet.clear();
		territorySet.clear();
		return;
	}

	Pix i,ii;

	if (territorySet.length() == 0) {
		for(i = sourcesSet.first(); i; sourcesSet.next(i)) {
			int n = sourcesSet(i);
			if( si->sinfo[n].territoryN->length() ) {
				break;
			}			
		}
		if (!i) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ќтсутствует команда TERRITORY в 0 сабе топика %d.\n",me);
			sourcesSet.clear();
			territorySet.clear();
			return;
		}
	}

	if (territorySet.length() == 0) {
		for(i = sourcesSet.first(); i; sourcesSet.next(i)) {
			int n = sourcesSet(i);
			for (Pix pix5 = si->sinfo[n].territoryN->first(); pix5; si->sinfo[n].territoryN->next(pix5)) {
				territorySet.add((*si->sinfo[n].territoryN)(pix5) );
			}
		} 
	}
	
	for( i=territorySet.first(); i; territorySet.next(i)) {
		int n = territorySet(i);
		dbproc->addTopicTerritory(
			si->tinfo[n].territoryName, 
			si->tinfo[n].nameLength, me);
	}
	for( ii = sourcesSet.first(); ii; sourcesSet.next(ii)) {
		int srcn = sourcesSet(ii);
		dbproc->addTopicSource(
			si->sinfo[srcn].sourceName, 
			si->sinfo[srcn].nameLength, me);
	}
	for( ii = sourcesSet.first(); ii; sourcesSet.next(ii)) {
		int srcn = sourcesSet(ii);
		for( i=territorySet.first(); i; territorySet.next(i)) {
			int n = territorySet(i);
			dbproc->setSourceAndTerritory(
				si->sinfo[srcn].sourceName, 
				si->sinfo[srcn].nameLength,
				si->tinfo[n].territoryName, 
				si->tinfo[n].nameLength );
		}
	}
}

#ifdef	BLOCKSINHERIT
void nsrcParser :: doClass( int theid, long aaSub )
#else
void nsrcParser :: doClass( int theid )
#endif
{
	// add gprefixes-> prefixes
	longSet * pSet = 0;

	longVHSet	parentPrefixes;

#ifdef	BLOCKSINHERIT
	int	aPos = lastSubsPos - 1;
	if ( lastSub & INHERITED_BLOCK ) {
		// найдем позицию блока, от которого наследуем PREFIX. Ќачинаем смотреть с aaSub и вверх
		for ( int aaPos = 0; aaPos < lastSubsPos - 1; aaPos++ )
			if ( lastSubs[ aaPos ] == aaSub ) {
				aPos = aaPos;
				break;
			}
		for( short aSubs = aPos; aSubs >= 0 && !pSet; aSubs-- ) {
			pSet = &prefixesSet[lastSubs[ aSubs ]];
			if ( pSet && !pSet->length() )
				pSet = 0;
		}
	} else {
		if ( prefixSet.length() )
			pSet = &prefixSet;

		// есть блок с CLASS без PREFIX, у него есть верхние блоки. ¬се их PREFIXы надо объединить в один set
		if ( !pSet ) {
			for ( int aSubs = 0; aSubs < lastSubsPos - 1; aSubs++ ) {
				longSet *aSet = &prefixesSet[lastSubs[ aSubs ]];
				for( Pix pi=aSet->first(); pi; aSet->next(pi)) {
					parentPrefixes.add((*aSet)(pi));
				}
			}
			if ( parentPrefixes.length())
				pSet = &parentPrefixes;
		}
	}

	if ( !pSet && gprefixSet.length() )
		pSet = &gprefixSet;
#else
	if( prefixSet.length() )
		pSet = &prefixSet;
	else if ( gprefixSet.length() )
		pSet = &gprefixSet;
#endif

	if( !pSet ){
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "CLASS ¬≈Џ PREFIX –“ѕ…«ќѕ“…“ѕ„Ѕќ.\n");
		return;
	}

	int nPrefixes = pSet->length();

	union DocClass dc;

	Pix pi;

	for( pi=pSet->first(); pi; pSet->next(pi) ) {
		if ( ! ( Info.Status & DS_EDITION ))
			Info.Status |= (ci->pfxInfo[(*pSet)(pi)].prefixType) | DS_DOC;

		dc.asref.id = (*pSet)(pi);
		dc.asref.sub = lastSub;
#ifdef	BLOCKSINHERIT
		if ( ( lastSub & INHERITED_BLOCK ) == 0 )
#endif
		docPrefixes->add(dc.asint);
	}

	dc.asref.id = theid;
	dc.asref.sub = lastSub;
	docClasses->add(dc.asint);
	for( pi=pSet->first(); pi; pSet->next(pi)) {
		dbproc->setClassAndPrefix(ci->clInfo[theid].className, ci->clInfo[theid].nameLength, ci->pfxInfo[(*pSet)(pi)].prefixName, ci->pfxInfo[(*pSet)(pi)].nameLength );
	}

	int neq = ci->clInfo[theid].nEquals;
	for (int idx1 = 0; idx1 < neq; idx1++) {
		long id = ci->clInfo[theid].equals[idx1];

		bool found = false;
#ifdef	BLOCKSINHERIT
		if ( lastSub & INHERITED_BLOCK ) {
			//проверить, не совпал ли id с eq(классов на lastSubа)
			long ownSub = lastSub & MINUS_INHERITED_BLOCK;
			for ( Pix owni = classSet[ownSub].first(); owni; classSet[ownSub].next(owni) ) {
				long ownClass = classSet[ownSub](owni);
				int ownneq = ci->clInfo[ ownClass ].nEquals;
				for (int ownidx1 = 0; ownidx1 < ownneq && !found; ownidx1++) {
					long owneqClass = ci->clInfo[ ownClass ].equals[ ownidx1 ];
					if ( owneqClass == id )
						found = true;
				}
			}
		}
#endif

		if ( !found ) {
			dc.asref.id = id;
			docClasses->add(dc.asint);
			for( pi=pSet->first(); pi; pSet->next(pi) ) {
				dbproc->setClassAndPrefix(ci->clInfo[id].className, ci->clInfo[id].nameLength, ci->pfxInfo[(*pSet)(pi)].prefixName, ci->pfxInfo[(*pSet)(pi)].nameLength );
			}
		}
	}
}

void nsrcParser :: loadObject(const char *ptr, int l )
{
	if (objType == 0) {
		char* dot_pos = (char*)(strrchr (ptr, '.'));
		if (!dot_pos) {
			bObjectOk = 0;
			return ;
		}
		char ext [32];
		dot_pos++;
		memcpy(ext, dot_pos, l - (dot_pos - ptr));
		ext[l - (dot_pos - ptr)]= 0;
		StrUpr (ext);
		memcpy (&objType, ext, 4);
		//if (strlen (ext) < 4)
			objType <<= 8;
		if (objType == EOT_BMP)
			objType = EOT_PIC;
	}
	bool use_template = false;
	if( !wasObjPath ){
		if (objRootLength && objRoot[objRootLength-1] != '/') {
			objRoot[objRootLength] = '/';
			objRootLength++;
		}
		char* toput = objRoot + objRootLength;
		if (ptr[0] == '\\' || ptr[0] == '/') {
			memcpy(objRoot + objRootLength, ptr+1, l-1 );
			objRoot[objRootLength+l-1] =0;
		} else {
			memcpy(objRoot + objRootLength, ptr, l );
			objRoot[objRootLength+l] =0;
		}
		int fd;
		long fd_len;
#ifndef WITH_DBL_THREAD
		//gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_WIN, "open %s\n", objRoot);
		fd = ace_os_open(objRoot, ACE_OS_O_RDONLY | ACE_OS_O_BINARY );

		if( fd != -1 ){
			fd_len = ace_os_filesize (fd);
			if ( fd_len > 0 ) {
#else
				int file=ace_os_open(objRoot, ACE_OS_O_RDONLY | ACE_OS_O_BINARY );
				if (file<0) {
			#ifdef	unix
					if (objType == EOT_PIC) {
						use_template = true;
						gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "‘айл объекта %s не найден\n", objRoot);
						strcpy(toput, "$DUMMY$.BMP");
					}
					else
			#endif
					{
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "‘айл объекта %s не найден\n", objRoot);
						bObjectOk=false;
						return;
					}
				} else {
					ace_os_close(file);
				}
				fd= strlen(objRoot);
#endif
				char* fileData;
				int dataLength;
				wasObjPath = 1;
#ifndef WITH_DBL_THREAD
				fileData = new char[fd_len];
				dataLength = ace_os_read( fd, fileData, fd_len );

				PBITMAPINFOHEADER bih = (PBITMAPINFOHEADER)(fileData + sizeof(BITMAPFILEHEADER));
				int dataSize = (int)BitmapSize(bih->biWidth,bih->biHeight,bih->biBitCount);

				if (objType == EOT_PIC) {
					if (fileData[0] != 'B' || fileData[1] != 'M') {
						gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "√рафический файл (%s) не в формате BMP.\n", objRoot);//GARFBWIN
						bObjectOk = 0;
						delete[] fileData;
						return;
					}

					if (dataLength < dataSize) {
						gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "√рафический файл (%s) меньше, чем длинна указанна€ в заголовке.\n", objRoot);
						bObjectOk = 0;
						delete[] fileData;
						return;
					}

					if (dataLength > dataSize) {
						gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "√рафический файл (%s) урезан на %d байт.\n", objRoot, dataLength-dataSize);
						dataLength = dataSize;
					}
				}
				objInfo.crc32 = crc32(0, (const Bytef *)fileData,dataLength);
#else
				fd_len= dataLength= fd + 1;
				if( fd_len + (long)sizeof(ObjInfo) > objDataMaxSize ) {
					objDataMaxSize = fd_len + sizeof(ObjInfo);
					objData = realloc( objData, objDataMaxSize );
				}
				fileData = (char*)objData + sizeof(ObjInfo);
				memcpy(fileData, objRoot, dataLength);
#endif
				objInfo.type = objType;

				if (dataLength < 2000000000) {
#ifndef WITH_DBL_THREAD
					if( fd_len> objDataMaxSize ) {
						objDataMaxSize = fd_len;
						objData = realloc( objData, objDataMaxSize );
					}
					memcpy(objData,fileData,dataLength);
#endif
					objInfo.size = dataLength;
				} else {
#ifndef WITH_DBL_THREAD
					objData = realloc( objData, dataLength + dataLength/2 );
#else
					int add;
					if (sLongNameSz)
						add= sLongNameSz;
					else
						add= strlen( objInfo.name ) + 1;
					add += sizeof(u_int32_t);
					if( dataLength*2 + add > objDataMaxSize ) {
						objDataMaxSize = dataLength*2 + add;
						objData = realloc( objData, objDataMaxSize );
						fileData= (char*)objData + sizeof(ObjInfo);
					}
					*(long*)objInfo.reserved= dataLength;
#endif
					unsigned long type = objInfo.type;
					if (type == EOT_PNG || type == EOT_JPG || type == EOT_GIF || type == EOT_PDF) {
						objInfo.size = dataLength;
						memcpy (objData, fileData, dataLength);
					} else {
						objInfo.size = G_ZIP( fileData, dataLength, (char*)objData
	#ifdef WITH_DBL_THREAD
										+ sizeof(ObjInfo) + dataLength ,dataLength - 1
	#else
										,dataLength + dataLength/2
	#endif
						);
					}
					if (objInfo.size)
						objInfo.packed = 1;
					else {
						gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "Can not compress data. Compression skiped.\n");
#ifndef WITH_DBL_THREAD
						memcpy(objData,fileData,dataLength);
#endif
						objInfo.size = dataLength;
					}
				}
#ifndef WITH_DBL_THREAD
				delete[] fileData;
			} else {
				gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Can not check file length\n");
				bObjectOk = 0;
			}
			ace_os_close(fd);
		}else{
			gclog.printfC(errors,AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈ Ќѕ«’ ѕ‘Ћ“ў‘Ў ∆Ѕ ћ `%s'\n", objRoot);
			bObjectOk = 0;
		}
#endif
		objRoot[objRootLength] = 0;
	}else{
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "рѕ„‘ѕ“—јЁ… ”— OBJPATH\n");
		bObjectOk = 0;
	}
}

void nsrcParser :: doName( const char *s, int l )
{
	int off;
	while( l && (*s == ' ' || *s=='\t' ) ){
	  s++; l--;
	}
	if( !l )
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў NAME\n");
	else{
		off = l-1;
		while( off && (s[off] == ' ' || s[off]=='\t') )  off --;
		if( off+1 ){
			append2LName(s, off+1);
		}else{
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Invariant failure in doName()" );
		}
	}
}

bool	nsrcParser::para_contains_formulas ()
{
	unsigned char *ptr = paraBuf;
	while (*ptr && (ptr - paraBuf < paraBufPos)) {
		if (*ptr == 19)
			return true;
		ptr++;
	}
	return false;
}

int	_line_in_nsrc;
const char* _nsrc_filename;

void nsrcParser :: addLine( const char *s, int l, const char* nsrc_filename, int line_in_nsrc)
{
	_line_in_nsrc = line_in_nsrc;
	_nsrc_filename = nsrc_filename;
	if (!me) {
#ifdef QSORT_SRC
		DocId= pTopicHdr->doc_n;
		Quick_mkFrom(s,l); 
		return;
#else
		if( IS_CMD(A_TOPIC,s,l) ) { 
			CMD_CALL3(A_TOPIC,mkFrom,s,l,0);
			return;
		}
		else if( IS_CMD(A_OBJTOPIC,s,l) ) { 
			CMD_CALL3(A_OBJTOPIC,mkFrom,s,l,1); 
			return;
		}
		else if( IS_CMD(ANNOTOPIC,s,l) ) { 
			annoPhase = true;
			CMD_CALL3(ANNOTOPIC,mkFrom,s,l,0);
			Info.Status |= DS_ANNO;
			SetDocMonitoring(&Info,DocId-ID_ANNOPLUS);
			annoPhase = false;
			return;
		} else if (IS_CMD (FIRMTOPIC, s, l)) {
			CMD_CALL3 (FIRMTOPIC, mkFrom, s, l, 0);
			Info.Status |= DS_NODOC;
			Info.Status_ex |= DS_FIRMTOPIC;
			return ;
		} else if (IS_CMD (MEDTOPIC, s, l)) {
			CMD_CALL3 (MEDTOPIC, mkFrom, s, l, 0);
			Info.Status |= DS_NODOC;
			Info.Status_ex |= DS_MEDTOPIC;
			return ;
		} else if (IS_CMD (FLASHTOPIC, s, l)) {
			CMD_CALL3 (FLASHTOPIC, mkFrom, s, l, 0);
			Info.Status |= DS_DOC;
			Info.Status_ex |= DS_FLASH;
			return ;
		} else if (IS_CMD (MDICTTOPIC, s, l)) {
			CMD_CALL3 (MDICTTOPIC, mkFrom, s, l, 0);
			Info.Status |= DS_NODOC;
			Info.Status_ex |= DS_MDICTTOPIC;
			return ;
		} else {
			if (b_show_skip_info)
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "йќ∆ѕ“ЌЅ√…— ¬≈Џ ‘ѕ–…ЋЅ –“ѕ…«ќѕ“…“ѕ„ЅќЅ\n");
			b_show_skip_info = false;
			return;
		}
#endif
	}

	if (baddoc_andskip)
		return;

	/*
	if ( annoPhase && !IS_CMD(ANNOEND,s,l)) {
		annoLines[ annoLine++ ] = strdup( s );
		return;
	}
	*/
	if( l >2  && s[0] == '!' && s[1] != '!' && (unsigned char)s[1] < 127) {
		if (!strcmp (s, "!*NOCOMPARE")) {
			Info.Status_ex |= DS_NOCOMPARE;
			return ;
		}

		if ( s[1] == '*' )
			return;

		if (CheckSpecials((unsigned const char *)s, l)) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "у‘“ѕЋЅ ЋѕЌЅќƒў ”ѕƒ≈“÷…‘ ”–≈√. ”…Ќ„ѕћў\n");
			return;
		}
		if( s[1] == 'S' ) {
/*STYLE*/

			if (IS_CMD (STYLEA,s,l) || IS_CMD(STYLE,s,l) ) {
				bool is_stylea = IS_CMD (STYLEA,s,l);
#ifdef	VERSION56
				if (!cpn && me && cinfo && cinfo->anonces->contains(me) && !bEnglish ) {
					dbproc->addTopicEmptyPara(me);
					paraCount++; cpn++; wordInPara=0;
					const char* ss = "!STYLE J 1 72 1";
					CMD_CALL(STYLE,mkNewPara,ss,15);
					strcpy( (char*)paraBuf, " СҐ•§•≠®п Ѓ бв†вгб• §Ѓ™гђ•≠в†, •£Ѓ бҐпІпе б ®≠дЃађ†ж®Ѓ≠≠лђ °†≠™Ѓђ ® §аг£†п ѓЃЂ•І≠†п †≠†Ђ®в®з•б™†п ®≠дЃађ†ж®п Ѓ §†≠≠Ѓђ §Ѓ™гђ•≠в• °г§гв ѓа•§бв†ҐЂ•≠л Ґ Ѓ§≠Ѓђ ®І °Ђ®¶†©и®е Ґлѓгб™ЃҐ б®бв•ђл ГАРАНТ" );
					paraBufPos = strlen( (char*)paraBuf );
					endPara(); endParaEx ();
					dbproc->addTopicEmptyPara(me);
					paraCount++; cpn++; wordInPara=0;
				}
#endif
				if ( paraStyle == PS_CENTERED ) {
					if ( cell_ids.size () || para_contains_formulas () || (getParaStyle( s+(is_stylea ? STYLEA_DOFFS:STYLE_DOFFS), l-(is_stylea?STYLEA_DOFFS:STYLE_DOFFS) ) != PS_CENTERED)) {
						endPara();
						if (is_stylea)
							CMD_CALL(STYLEA,mkNewPara,s,l);
						else
							CMD_CALL(STYLE,mkNewPara,s,l);
					} else if (paraBufPos > 0 && paraBuf [paraBufPos-1] != 1) {
						endPara ();
						if (is_stylea)
							CMD_CALL(STYLEA,mkNewPara,s,l);
						else
							CMD_CALL(STYLE,mkNewPara,s,l);
					}
				} else
				if ( paraStyle == PS_SIDEBYSIDE ) {
					if ( getParaStyle( s + (is_stylea ? STYLEA_DOFFS : STYLE_DOFFS), l - (is_stylea ? STYLEA_DOFFS : STYLE_DOFFS)) != PS_SIDEBYSIDE ) {
						endPara();
						if (is_stylea)
							CMD_CALL(STYLEA,mkNewPara,s,l);
						else
							CMD_CALL(STYLE,mkNewPara,s,l);
					}
				} else {
					endPara();
					if (is_stylea)
						CMD_CALL(STYLEA,mkNewPara,s,l);
					else
						CMD_CALL(STYLE,mkNewPara,s,l);
				}
			}
/*SUB*/
			else if( IS_CMD(SUB,s,l) )
			{
				if (!isBlob) {
					endPara();
					CMD_CALL4(SUB,doSub,s,l,MAX_SUB_NUMBER,true);
				}
			}
/*SUFFIX*/
			else if( IS_CMD(SUFFIX,s,l) )
			{  
				endPara();
			}
/*SOURCE*/
			else if( IS_CMD(SOURCE,s,l) )
			{
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				if (bIsNoDoc) {
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				} else {
					doSource(s,l);
				}
			}
/*SERVICEINFO*/
			else if( IS_CMD(SERVICEINFO,s,l) )
			{
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				const char *ptr;
				int len = 0;
				if( (len=CMD_CALL3(SERVICEINFO,getChars,s,l,ptr)) >0 ){
					FString t(ptr,len);t.bDoFree= 1;

					if(!serviceInfoSet->seek(t)){
						serviceInfoSet->add(t);
						t.bDoFree= 0;
					}

					if( cinfo->topicServiceInfo->contains( t ) ){
						FString *tt = &((*cinfo->topicServiceInfo)[t]);
						dbproc->addTopicServiceInfo(tt->chars(),tt->length()+1, me, lastSub);
					}else{
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© ServiceInfo '%s'\n", t.chars());
					}
				}else{
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў SERVICEINFO.\n");
				}
			}
/*SORTDATE*/
			else if( IS_CMD(SORTDATE,s,l) )
			{
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				if( !bSortDateSet ) {
					if( CMD_CALL3(SORTDATE,getDate,s,l,Info.FirstDate) ) {
						bSortDateSet = 1;
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ƒЅ‘ў\n");
					}
				} else {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "рѕ„‘ѕ“—јЁЅ—”— ЋѕЌЅќƒЅ SORTDATE.\n");
				}
			}
/*SFDATE*/
			else if( IS_CMD(SFDATE,s,l) ) {
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
			}
/*STAGE*/
			else if( IS_CMD(STAGE, s, l) ) {  
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
			}
/*SPLASH*/
			else if( IS_CMD(SPLASH, s, l) ) {
				thatsSplashTopic = 1;
			} else {
				endPara();
				FString t(s,l);
				t.bDoFree=1;
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
			}
		}
		else if( s[1] == 'N' )
		{
			endPara();
			if (!bIsSub) {
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
				return;
			}
			else if (IS_CMD(NEXTVERLINK,s,l)) {
				int val; 
				if( CMD_CALL3(NEXTVERLINK,getInt,s,l,val) == 0 )
					if (bad_docs->find (val+REAL_DOC_OFFS) == bad_docs->end ())
						Info.nextEdition=val+REAL_DOC_OFFS;
				return ;
			}
/*NAME*/
			if (IS_CMD (NARCOTIC,s,l))
				Info.Status_ex |= DS_NARCOTIC;
			else
			if (IS_CMD (NOTNARCOTIC,s,l))
				Info.Status_ex |= DS_NOTNARCOTIC;
			else
			if (IS_CMD (NOTLIFE, s, l)) {
				Info.Status_ex |= DS_NOTLIFE;
				dbproc->setTopicStatus_ex (me, DS_NOTLIFE, lastSub);
				return ;
			} else
			if (IS_CMD (NOTALLOWED, s, l)) {
				Info.Status_ex |= DS_NOTALLOWED;
				dbproc->setTopicStatus_ex (me, DS_NOTALLOWED, lastSub);
				return ;
			} else
			if( IS_CMD(NAME,s,l) ) {
				CMD_CALL(NAME,doName,s,l);
			}
/*NOACTIVE*/
			else if( IS_CMD(NOACTIVE,s,l) )
			{
#ifdef VERSION56
				if (!cinfo->notADocs->contains (me)) {
					DocActivityEx docActivity={0};
					docActivity.b_add_iddactive = true;
					getActivity(s+NOACTIVE_DOFFS, l-NOACTIVE_DOFFS, docActivity);
					if (!docActivity.from.da_year) {
						if( !(Info.Status & (DS_PREACTIVE|DS_ACTIVE) ))
							Info.Status |= DS_ABOLISHED;
						else
							gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_WIN," онфликт NOACTIVE с PREACTIVE или ACTIVE\n");
					} else {
						if( is_lt(docActivity.from, todayDate) || is_eq(docActivity.from, todayDate)) {
							if( !(Info.Status & DS_PREACTIVE ) )
								Info.Status |= DS_ABOLISHED;
							else
								gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_WIN,"NOACTIVE PREACTIVE TOPIC\n");

							if( dateCmp( docActivity.from, prevSatDate ) >= 0 )
								gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,"фѕ–…Ћ ”‘Ѕћ NOACTIVE ќЅ №‘ѕ  ќ≈ƒ≈ћ≈.\n");
						} else {
							//gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN,"ACTIVE NOACTIVE TOPIC\n");
							Info.Status |= DS_ACTIVE;
						}

						docActivity.to = date_plusdays( docActivity.from, -1 );
						docActivity.from.da_day = 0, docActivity.from.da_mon = 0, docActivity.from.da_year = 0;
						dsActivity.insert(docActivity);
					}
				}
#else // стара€ верси€
				if (bIsNoDoc)
				{
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				}
				else
				{
					date d;
					if( CMD_CALL3(NOACTIVE,getDate,s,l,d) )
					{
						if( dateCmp( d, todayDate ) <= 0 )
						{
							if( !(Info.Status & DS_PREACTIVE ) )
							{
								Info.Status |= DS_ABOLISHED;
							}
							else
							{
								gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "NOACTIVE PREACTIVE TOPIC\n");
							}
							if( dateCmp( d, prevSatDate ) >= 0 )
							{
								gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,"фѕ–…Ћ ”‘Ѕћ NOACTIVE ќЅ №‘ѕ  ќ≈ƒ≈ћ≈.\n");
							}
						}
					}
					else
					{
						if( !(Info.Status & DS_PREACTIVE ) )
						{
							Info.Status |= DS_ABOLISHED;
						}
						else
						{
							gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "NOACTIVE PREACTIVE TOPIC\n");
						}
					}
				}
#endif
			}
/*NODOC*/	
			else if( IS_CMD(NODOC,s,l) ){
#ifdef VERSION56
				if (Info.Status & DS_EDITION) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN," оманда NODOC несовместима с командой EDITION.\n");
				} else
#endif
				Info.Status |= DS_NODOC;
			}
/*NORM*/	
			else if( IS_CMD(NORM,s,l) ) {
				if (bIsNoDoc) {
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				} else {
					const char *ptr;
					int len;
					if( (len = CMD_CALL3(NORM,getChars,s,l,ptr))>0 ) {
						if( !norm ) {
							norm = new FString (ptr, len); norm->bDoFree= 1;
							if( !normInfo->norms->contains(*norm) ) {
								gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠Ѓ• І≠†з•≠®• NORM/CATEGORY '%s'\n", norm->chars());
								delete norm;
								norm = 0;
							} else {
								FString *nstr = new FString((*normInfo->norms)(normInfo->norms->seek(*norm)).chars());
								nstr->bDoFree= 1;
								delete norm;
								norm = nstr;
							}
						} else {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "оѕ“ЌЅ/ЋЅ‘≈«ѕ“…— ’÷≈ „”‘“≈ёЅћЅ”Ў.\n");							
						}
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈ Ќѕ«’ “Ѕ”–ѕЏќЅ‘Ў Ѕ“«’Ќ≈ќ‘\n");
					}
				}
			}
			else if( IS_CMD(NOTTM,s,l ))
			{
				Info.Status |= DS_NOTTM;
			}
/*NEWLIST*/
			else if( IS_CMD(NEWLIST,s,l) )
			{
			}
#ifdef	VERSION56
			else if ( IS_CMD(NOTSURE,s,l) ) {
				DocNotSure notSure={0};
				getNotSure(s+NOTSURE_DOFFS, l-NOTSURE_DOFFS, notSure);
				dsNotSure.insert(notSure);
			}
#endif
			else
			{
				FString t(s,l);
				t.bDoFree=1;
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n", t.chars());
			}
		}
		else if (s[1] == 'Z') {
			endPara ();
			if (IS_CMD (ZOOM, s, l)) {
				if (table_types.empty ()) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ѕеред !ZOOM должна быть таблица (!TABLE)\n");
				} else {
					int zoom;
					if (CMD_CALL3 (ZOOM, getInt, s, l, zoom) == 0) {
						map_tableid_zoom.insert (std::map<long,long>::value_type (table_row_cell_id, zoom));
						/*
						my_generator obj;
						my_table_row_cell_id = table_row_cell_id;
						evd::IeeGenerator_var generator = new evd::EeGenerator_i (my_callback, &obj, sizeof (my_evd_buffer));

						generator->Start ();
							generator->StartChild(table_types.top () == SUBDESCEX_SBS ? evd::id_SBS : evd::id_Table);
								generator->AddIntegerAtom (evd::ti_Zoom, zoom);
							generator->Finish();
						generator->Finish();

						memcpy (idd_evd_buffer_ptr, my_evd_buffer, my_evd_buffer_length);
						idd_evd_buffer_ptr += my_evd_buffer_length;
						*/
					}
				}
			}
		}
		else if( s[1] == 'W' )
		{
			endPara();
			if (!bIsSub) {
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
				return;
			}
/*WARNING*/
			if( IS_CMD(WARNING,s,l) ) {
				int val; 
				if( CMD_CALL3(WARNING,getInt,s,l,val) == 0 ) {
					if (wasWarning) {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "рѕ„‘ѕ“—јЁЅ—”— ЋѕЌЅќƒЅ WARNING\n");
					} else {
						u_int32_t t = val;
						if( warningMap->contains(t) ) {
							int lw = strlen( (*warningMap)[t].chars() );
							char* recode = (char*)alloca(lw+1);
							memcpy(recode,(*warningMap)[t].chars(),lw+1);
							if (b_recode) Recoding( cd_dos, cd_win, recode );
							dbproc->addAttribute(me, IDD_WARNING,recode,strlen(recode)+1);
							wasWarning = t;
							if (t == 24 || t == 28 || t == 29 || t == 30)
								Info.Status |= DS_WARNING;
						} else {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈…Џ„≈”‘ќѕ≈ –“≈ƒ’–“≈÷ƒ≈ќ…≈.\n");
						}
					}
				} else {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў WARNING\n");
				}
			} else {
				FString t(s,l);
				t.bDoFree=1;
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n", t.chars());
			}
		}
		else if( s[1] == 'F' ) {
			if (IS_CMD (FLASHTOPIC, s, l)) {
				finishTopic ();
				CMD_CALL3 (FLASHTOPIC, mkFrom, s, l, 0);
				Info.Status_ex |= DS_FLASH;
				return ;
			} else
			if (IS_CMD (FIRMTOPIC, s, l)) {
				finishTopic ();
				CMD_CALL3 (FIRMTOPIC, mkFrom, s, l, 0);
				Info.Status_ex |= DS_FIRMTOPIC;
				return ;
			} else {
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				if (IS_CMD (FIRM, s, l)) {
					const char *ptr;
					int len = 0;
					if( (len=CMD_CALL3 (FIRM,getChars,s,l,ptr)) >0 ){
						FString t(ptr,len);t.bDoFree= 1;

						if( cinfo->topicInpharmFirms->contains (t) ){
							FString *tt = &((*cinfo->topicInpharmFirms)[t]);
							dbproc->addTopicInpharmFirm (tt->chars (), tt->length ()+1, me, lastSub);
						}else{
							gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© FIRM '%s'\n", t.chars());
						}
					}else{
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў FIRM.\n");
					}
				} else
				if( IS_CMD(FULL,s,l) ) {
				}
				else {
					FString t(s,l);
					t.bDoFree=1;
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
				}
			}
		}
		else if( s[1] == 'G' )
		{
			endPara();
			if (!bIsSub) {
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
				return;
			}
/*GDATE*/
			if( IS_CMD(GDDATE,s,l) ) {
			} else {
				FString t(s,l);
				t.bDoFree=1;
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
			}
		}
		else if( s[1] == 'M' ) {
			if (IS_CMD (MREL,s,l)) {
				return ;
			}
			if (IS_CMD (MEDTOPIC,s,l)) {
				finishTopic ();
				CMD_CALL3 (MEDTOPIC, mkFrom, s, l, 0);
				Info.Status_ex |= DS_MEDTOPIC;
				return ;
			}
			if (IS_CMD (MDICTTOPIC,s,l)) {
				finishTopic ();
				CMD_CALL3 (MDICTTOPIC, mkFrom, s, l, 0);
				Info.Status_ex |= DS_MDICTTOPIC;
				return ;
			}
			endPara();
			if (IS_CMD (MKB,s,l) ) {
				const char *ptr;
				int len = 0;
				if ((len=CMD_CALL3 (MKB, getChars, s, l, ptr)) > 0) {
					FString t(ptr,len);t.bDoFree= 1;

					bool aDupFound = false;
					if (!mkbsSet->seek (t)) {
						mkbsSet->add (t);
						t.bDoFree= 0;
					}

					if (cinfo->topicInpharmMkbs->contains (t)) {
						for (short aSubs = 0; aSubs < lastSubsPos && !aDupFound; aSubs++)
							if (mkbSet [lastSubs [aSubs]]->contains (t))
								aDupFound = true;

						if (!aDupFound) {
							if( !mkbSet [lastSub]->seek (t)){
								mkbSet [lastSub]->add (t);
								t.bDoFree= 0;
							}
							FString *tt = &(cinfo->topicInpharmMkbs->contents(cinfo->topicInpharmMkbs->seek(t)));
							dbproc->addTopicMkb(tt->chars(),tt->length()+1, me, lastSub);
						}						
					} else {
						gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© MKB '%s'\n", t.chars());
					}
					/*
					FString t (ptr,len); t.bDoFree= 1;
					if (cinfo->topicInpharmMkbs->contains (t) ){
						FString *tt = &((*cinfo->topicInpharmMkbs)[t]);
						dbproc->addTopicMkb (tt->chars(),tt->length()+1, me, lastSub);
					}else{
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© MKB %s\n", t.chars());
					}
					*/
				}else{
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў MKB.\n");
				}
				return ;
			}
			if (!bIsSub) {
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
				return;
			}
/*MOJNOTREG*/
			if( IS_CMD(MOJNOTREG,s,l) ){
				if (bIsNoDoc) {
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				} else {
					if (Info.Status & DS_MOJREG) {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"Ќедопустима€ команда дл€ документа зарегистрированного в ћинёсте.\n");
					} else {
						Info.Status |= DS_MOJNOTREG;
					}
				}
			}
/*MAIN*/
			else if( IS_CMD(MAIN,s,l) )
			{
			}
/*MAXLINES*/
			else if( IS_CMD(MAXLINES,s,l) ) { }
			else {
				FString t(s,l);
				t.bDoFree=1;
				gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
			}
		}
		else if( s[1] == 'L' ) {
			endPara();
			if (IS_CMD (LEFTINDENT, s, l)) {
				if (table_types.empty ()) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ѕеред !LEFTINDENT должна быть таблица (!TABLE)\n");
				} else {
					int li;
					if (CMD_CALL3 (LEFTINDENT, getInt, s, l, li) == 0) {
						map_tableid_leftindent.insert (std::map<long,long>::value_type (table_row_cell_id, li));
						/*
						my_generator obj;
						my_table_row_cell_id = table_row_cell_id;
						evd::IeeGenerator_var generator = new evd::EeGenerator_i (my_callback, &obj, sizeof (my_evd_buffer));

						generator->Start ();
							generator->StartChild(table_types.top () == SUBDESCEX_SBS ? evd::id_SBS : evd::id_Table);
								generator->AddIntegerAtom (evd::ti_LeftIndent, li);
							generator->Finish();
						generator->Finish();

						memcpy (idd_evd_buffer_ptr, my_evd_buffer, my_evd_buffer_length);
						idd_evd_buffer_ptr += my_evd_buffer_length;
						*/
					}
				}
				return ;
			}
			if (!bIsSub) {
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
				return;
			}
			if (IS_CMD (LIFE, s, l)) {
				Info.Status_ex |= DS_LIFE;
				dbproc->setTopicStatus_ex (me, DS_LIFE, lastSub);
				return ;
			} else
			if (IS_CMD (LEKFORM, s, l)) {
				const char *ptr;
				int len = 0;
				if( (len=CMD_CALL3 (LEKFORM,getChars,s,l,ptr)) > 0) {
					FString t(ptr,len);t.bDoFree= 1;
					if (cinfo->topicInpharmLekForms->contains (t) ) {
						FString *tt = &((*cinfo->topicInpharmLekForms)[t]);
						dbproc->addTopicLekForm (tt->chars (), tt->length ()+1, me, lastSub);
					} else {
						gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© LEKFORM '%s'\n", t.chars());
					}
				}else{
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў LEKFORM.\n");
				}
				return ;
			} else
/*LIST*/
			if( IS_CMD(LIST,s,l) ) {
			} else {
				FString t(s,l);
				t.bDoFree=1;
				gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
			}
		}
		else if( s[1] == 'D' )
		{
			if (IS_CMD(DIVISION,s,l)) {
				endPara ();
				DivisionInfo divisionInfo;
				divisionInfo.Para = cpn;
				divisionInfo.Symbol = 0;
				divisionInfo.Params = 0;
				getDivision(s+DIVISION_DOFFS+1,l-DIVISION_DOFFS-1,divisionInfo);
				dsDivisions.insert(divisionInfo);
				dbproc->addTopicEmptyPara(me); endPara (); endParaEx ();
				cpn++;wordInPara=0;paraCount++;
			} else {
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				if (IS_CMD (DOCTYPE, s, l)) {
					char* ptr = (char*) s;
					ptr += DOCTYPE_DOFFS + 1;
					if (strstr (ptr, "AAKCONTENT") == ptr) {
						SetDocStatusExEx (&Info, DS_AAKCONTENT);
					} else if (strstr (ptr, "AAKTEXT") == ptr) {
						SetDocStatusExEx (&Info, DS_AAKTEXT);
					}
				}
/*DOC*/
				else if( IS_CMD(DOC,s,l) ) {
					b_was_doc = true;
					if (bIsNoDoc) {
						long tmpLong= DICTIONARY_SEGMENT;
						if (!belongsSet.contains (tmpLong))
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");

					} 
	#ifdef VERSION56
					else if (Info.Status & DS_EDITION) {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN," оманда DOC несовместима с командой EDITION.\n");
					}
	#endif
	#ifndef WITH_DBL_THREAD
					else
					{
						Info.Status |= DS_DOC;
					}
	#endif
				}
	/*DATE*/
				else if( IS_CMD(DATE,s,l) ) { 
					if (bIsNoDoc) {
						//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
					} else {
						date d;
						if( CMD_CALL3(DATE,getDate,s,l,d) ){
							if ( dateCmp( d, todayDate ) > 0 ) {
								gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Д†в† !DATE °ЃЂми• в•™гй•©\n" );
							} else {
								dbproc->addTopicDate (me, d);
								if( !Info.FirstDate.da_year || dateCmp (Info.FirstDate,d) > 0)
									Info.FirstDate = d;
								if( !FirstDate.da_year || dateCmp (FirstDate, d) > 0)
									FirstDate = d;
								if (dateCmp(Info.LastDate, d) < 0)
									Info.LastDate = d;
								if (dateCmp(docDate, d) < 0)
									docDate = d;
							}
						} else {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈„≈“ќў  ∆ѕ“ЌЅ‘ ƒЅ‘ў\n");
						}
					}
				} else {
					FString t(s,l);
					t.bDoFree=1;
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
				}
			}
		}
		else if( s[1] == 'R' ) {
			if( IS_CMD(ROWEND,s,l)) {
				if (row_ids.empty ()) {
					gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ƒл€ !ROWEND не найден открывающий !ROW\n");
				} else {
					if ((cells_in_row.find (row_ids.top ()) == cells_in_row.end ()) || cells_in_row.find (row_ids.top ())->second == 0) {
						gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ћежду !ROW/!ROWEND не найдено !CELL/!CELLEND\n");
						fatal_table_errors = true;
					}

					long table_type = table_types.top ();
					subsExTmp[subExIdx].Sub  = row_ids.top ();
					subsExTmp[subExIdx].Para = cpn;
					subsExTmp[subExIdx].Flags= (table_type == SUBDESCEX_SBS) ? SUBDESCEX_SBSSTRINGEND : SUBDESCEX_STRINGEND;
					subsExTmp[subExIdx].Id   = ++subdescex_id;
					row_ids.pop ();
					subExIdx++;

					level--;
					long saved_subdescexid = *vector_subdescex_ids.rbegin ();
					map_subdescexid_lastpara.insert (std::map<long,long>::value_type (saved_subdescexid, cpn));
					vector_subdescex_ids.pop_back ();
					if (vector_subdescex_ids.size ()) {
						long row_leafs = map_subdescexid_allleafparacount.find (subdescex_id_inprocess)->second;
						subdescex_id_inprocess = *vector_subdescex_ids.rbegin ();
						std::map<long,long>::iterator map_it = map_subdescexid_lastchildid.find (subdescex_id_inprocess);
						if (map_it == map_subdescexid_lastchildid.end ())
							map_subdescexid_lastchildid.insert (std::map<long,long>::value_type (subdescex_id_inprocess, saved_subdescexid));
						else
							map_it->second = saved_subdescexid;
						map_subdescexid_allleafparacount.find (subdescex_id_inprocess)->second += row_leafs;
					} else
						subdescex_id_inprocess = 0;
				}
				return ;
			} else
			if( IS_CMD(ROW,s,l)) {
				if (table_types.empty ()) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ƒл€ !ROW не найдена таблица !TABLE\n");
				} else if (row_ids.size () && table_types.size () == 1) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ƒл€ предыдущей !ROW не найдена !ROWEND\n");
				} else {
					long table_type = table_types.top (), row_id = ++table_row_cell_id;
					unsigned short row_type = (table_type == SUBDESCEX_SBS) ? SUBDESCEX_SBSSTRING : SUBDESCEX_STRING;
					subsExTmp[subExIdx].Sub  = row_id;
					subsExTmp[subExIdx].Para = cpn;
					subsExTmp[subExIdx].Flags= row_type;
					subsExTmp[subExIdx].Id   = ++subdescex_id;
					row_ids.push (row_id);

					cells_in_row.insert (std::map<long,long>::value_type (row_id, 0));

					subExIdx++;

					subdescexids_instruct.push_back (subdescex_id);
					if (/*subdescex_id_inprocess && */map_subdescexid_firstchildid.find (subdescex_id_inprocess) == map_subdescexid_firstchildid.end ())
						map_subdescexid_firstchildid.insert (std::map<long,long>::value_type (subdescex_id_inprocess, subdescex_id));
					level++;
					long level_id = 0;
					std::map<long,long>::iterator map_it = map_level_maxid.find (level);
					if (map_it == map_level_maxid.end ()) {
						map_level_maxid.insert (std::map<long,long>::value_type (level, level_id));
					} else {
						level_id = ++map_it->second;
					}
					map_subdescexid_levelandlevelid.insert (std::map<long,long>::value_type (subdescex_id, (level << 24) + level_id));
					map_subdescexid_allleafparacount.insert(std::map<long,long>::value_type (subdescex_id, 0));
					vector_subdescex_ids.push_back (subdescex_id);
					subdescex_id_inprocess = subdescex_id;
					map_subdescexid_to_id.insert (std::map<long,long>::value_type (subdescex_id, table_row_cell_id));
					map_subdescexid_type.insert (std::map<long,long>::value_type (subdescex_id, row_type));
					map_subdescexid_firstpara.insert (std::map<long,long>::value_type (subdescex_id, cpn));
				}
				return ;
			} else
			if (IS_CMD (RECIPE, s, l)) {
				Info.Status_ex |= DS_RECIPE;
				dbproc->setTopicStatus_ex (me, DS_RECIPE, lastSub);
				return ;
			} else
			if (IS_CMD (REGSTATUS, s, l)) {
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				const char *ptr;
				int len = 0;
				if( (len=CMD_CALL3 (REGSTATUS,getChars,s,l,ptr)) > 0) {
					FString t(ptr,len);t.bDoFree= 1;
					if (cinfo->topicInpharmRegStatuses->contains (t) ) {
						FString *tt = &((*cinfo->topicInpharmRegStatuses)[t]);
						dbproc->addTopicRegStatus (tt->chars (), tt->length ()+1, me, lastSub);
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© REGSTATUS '%s'\n", t.chars());
					}
				}else{
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў REGSTATUS.\n");
				}
				return ;
			} else
			if( IS_CMD(REGDATE,s,l) ) {
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				date d;
				if (CMD_CALL3 (REGDATE,getDate,s,l,d )) {
					if( !Info.FirstDate.da_year || dateCmp (Info.FirstDate,d) < 0)
						Info.FirstDate = d;
					dbproc->addTopicRegDate (me, d, lastSub);
				}
			} else {
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
	/*REFDOC*/
				if( IS_CMD(REFDOC,s,l) ) {
					if(Info.Status & DS_DOC){
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
					}else
						Info.Status |= DS_NODOC | DS_REFDOC;
				}
	/*RCODE*/
				else if( IS_CMD(RCODE,s,l) ) {
					int len;
					const char *ptr;
					if (bIsNoDoc) {
						//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
					} else {
						if (Info.Status & DS_MOJNOTREG) {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"ƒокумент имеет команду !MOJNOTREG, которые будут проигнорирована.\n");
							Info.Status &= ~DS_MOJNOTREG;
						}
						if( (len = CMD_CALL3(RCODE,getChars,s,l,ptr))>0 ) {
							FString t(ptr, len);
							if( t.length() < CODE_KEY_SIZE ) {
								t.cp866Code();
								dbproc->addTopicRcode(me, t.chars(), t.length() +1);
								if (bEnglish) {
									std::string eng_code (t.chars ()), new_code;
									for (std::string::const_iterator it = eng_code.begin (); it != eng_code.end (); it++) {
										unsigned char c = (unsigned char) *it;
										int i = 0, added = 0;
										while (strlen (rus2eng [i])) {
											if (c == (unsigned char) rus2eng [i][0]) {
												new_code += rus2eng [i+1];
												added = 1;
												break;
											}
											i += 2;
										}
										if (!added)
											new_code += c;
									}
									FString new_t (new_code.c_str (), new_code.size ());
									new_t.cp866Code ();
									dbproc->addTopicRcode (me, new_t.chars(), new_t.length() +1);
									dbproc->addTopicRcode (me, new_code.c_str (), new_code.size () + 1);
								}

								Info.Status |= DS_MOJREG;
								wasRcode = 1;
								bRCodeSet = 1;
							} else {
								gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "КЃ§ %s §Ђ®≠≠•• %d\n", t.chars(), CODE_KEY_SIZE-1);
							}
							t.bDoFree=1;
						} else {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"дЅќќў≈ ЋѕЌЅќƒў RCODE ”ћ…џЋѕЌ ƒћ…ќќў≈\n");
						}
					}
				}
	/*REVISION*/
				else if( IS_CMD(REVISION,s,l) ) {
					date d;
					if( !(CMD_CALL3(REVISION,getDate,s,l,d)) ) {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈„≈“ќў  ∆ѕ“ЌЅ‘ ƒЅ‘ў\n");
					}
				}
	/*RELATED*/
				else if( IS_CMD(RELATED,s,l) ) {
					int t;
					if( CMD_CALL3(RELATED,getInt,s,l,t) == 0 ) {
						if( !bRelatedSet ) {
							t +=REAL_DOC_OFFS;
							if ((map_doc_subs->find (t) != map_doc_subs->end ()) || cinfo->notADocs->contains (t) ) {
								Info.Related = t;
								bRelatedSet = 1;
							} else {
								gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈‘ RELATED %ld  ƒћ— ‘ѕ–…ЋЅ %ld\n",t - REAL_DOC_OFFS, DocId - REAL_DOC_OFFS);
							}
						} else {
							gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"рѕ„‘ѕ“—јЁЅ—”— ЋѕЌЅќƒЅ RELATED.\n");
						}
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў RELATED.\n");
					}
				}
	/*RDATE*/
				else if( IS_CMD(RDATE,s,l) ) {
					if (bIsNoDoc) {
						//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
					} else {
						if (Info.Status & DS_MOJNOTREG) {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"ƒокумент имеет команду !MOJNOTREG, которые будут проигнорирована.\n");
							Info.Status &= 0xFFEF;
						}
						date d;
						if( CMD_CALL3(RDATE,getDate,s,l,d) ) {
							if ( dateCmp( d, todayDate ) > 0 ) {
								gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Д†в† !RDATE °ЃЂми• в•™гй•©\n" );
							} else {
								docRDate = d;
								dbproc->addTopicRDate(me, d );
								Info.Status |= DS_MOJREG;
								bRDateSet = 1;
							}
						} else {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈„≈“ќў  ∆ѕ“ЌЅ‘ ƒЅ‘ў\n");
						}
					}
	/*REL*/
				} else if( IS_CMD(REL,s,l) ) {
				} else {
					FString t(s,l);
					t.bDoFree=1;
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
				}
			}
		} else if( s[1] == 'B' ) {
			endPara();
			if( IS_CMD(BANNER, s, l) ) {
				thatsBannerTopic = 1;
			}
/*BELONGS*/
			else if( IS_CMD(BELONGS,s,l)  ) {
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
			}
			else if( IS_CMD(BLOCKDATA,s,l) ) {
				char* ptr = (char*) s;
				ptr += BLOCKDATA_DOFFS;
				l -= BLOCKDATA_DOFFS;
				while (l) {
					l--, ptr++;
					if (!strnicmp (ptr, "Style=", 6)) {
						map_block_style.insert (std::map<long,long>::value_type (lastSub, -atol (strchr (ptr, '=')+1)));
						int plus = strchr (ptr, ' ') ? plus = strchr (ptr, ' ') - ptr : strlen (ptr);
						ptr += plus;
						l -= plus;
					} else if (!strnicmp (ptr, "Location=", 9)) {
						char* location = strchr (ptr, '=') + 1;
						if (!strnicmp (location, "RIGHT", 5))
							map_block_location.insert (std::map<long,long>::value_type (lastSub, EVD::bvk_Right));
						else if (!strnicmp (location, "LEFT", 4))
							map_block_location.insert (std::map<long,long>::value_type (lastSub, EVD::bvk_Left));

						int plus = strchr (ptr, ' ') ? plus = strchr (ptr, ' ') - ptr : strlen (ptr);
						ptr += plus;
						l -= plus;
					}
				}
			}
/*BLOCK*/
			else if( IS_CMD(BLOCK,s,l) ) {
				if (!isBlob) {
					endPara();
					CMD_CALL4(BLOCK,doSub,s,l,MAX_SUB_NUMBER,false);
				}
			}
/*BUSINESS*/
			else if ( IS_CMD(BUSINESS,s,l) ) {
			}
/*BLOCKEND*/
			else if( IS_CMD(BLOCKEND,s,l) ) {
				if (!isBlob) CMD_CALL(BLOCKEND,doBlockEnd,s,l);
			} else if( IS_CMD(BOOK,s,l)) {
				Info.Status |= DS_BOOK;
			} else {
				FString t(s,l);
				t.bDoFree=1;
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
			}
		}
		else if( s[1] == 'C' ) {
			endPara();
			if( IS_CMD(CELLEND,s,l)) {
				if (cpn == last_cell_para) {
					endParaEx ();
					dbproc->addTopicEmptyPara(me);
					paraCount++; cpn++;
				}

				if (cell_ids.empty ()) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ƒл€ !CELLEND не найден открывающий !CELL\n");
				} else {
					long cell_id = cell_ids.top ();
					std::map<long,std::set<long> >::iterator it = blocks_in_cell.find (cell_id);
					if (it != blocks_in_cell.end () && it->second.size ()) {
						char error [128];
						sprintf (error, "¬ документе %ld блок %ld открываетс€ в €чейке таблицы, и не закрываетс€ в ней", me, *it->second.begin ());
						errors.push_back (strdup(error));
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ѕлок %ld открываетс€ в €чейке, и не закрываетс€ в ней\n", *it->second.begin ());
						const char* ss = "!BLOCKEND";
						CMD_CALL (BLOCKEND,doBlockEnd,ss,9);
					}

					long table_type = table_types.top ();
					subsExTmp[subExIdx].Sub  = cell_ids.top ();
					subsExTmp[subExIdx].Para = cpn;
					subsExTmp[subExIdx].Flags= (table_type == SUBDESCEX_SBS) ? SUBDESCEX_SBSCELLEND : SUBDESCEX_CELLEND;
					subsExTmp[subExIdx].Id   = ++subdescex_id;
					subExIdx++;
					cell_ids.pop ();

					level--;
					long saved_subdescexid = *vector_subdescex_ids.rbegin ();
					map_subdescexid_lastpara.insert (std::map<long,long>::value_type (saved_subdescexid, cpn));
					vector_subdescex_ids.pop_back ();
					if (vector_subdescex_ids.size ()) {
						long cell_leafs = map_subdescexid_allleafparacount.find (subdescex_id_inprocess)->second;
						subdescex_id_inprocess = *vector_subdescex_ids.rbegin ();
						std::map<long,long>::iterator map_it = map_subdescexid_lastchildid.find (subdescex_id_inprocess);
						if (map_it == map_subdescexid_lastchildid.end ())
							map_subdescexid_lastchildid.insert (std::map<long,long>::value_type (subdescex_id_inprocess, saved_subdescexid));
						else
							map_it->second = saved_subdescexid;
						map_subdescexid_allleafparacount.find (subdescex_id_inprocess)->second = std::max <long> (map_subdescexid_allleafparacount.find (subdescex_id_inprocess)->second, cell_leafs);
					} else
						subdescex_id_inprocess = 0;
				}
				return ;
			} else
			if( IS_CMD(CELL,s,l)) {
				if (table_types.empty ()) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ѕеред !CELL должна быть таблица (!TABLE)\n");
				} else if (row_ids.empty ()) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ѕеред !CELL должна быть строка (!ROW)\n");
				} else if (cell_ids.size () && row_ids.size () == 1) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ƒл€ предыдущей !CELL не найдена !CELLEND\n");
				} else {
					long table_type = table_types.top ();
					long cell_id = ++table_row_cell_id;
					unsigned short cell_type = (table_type == SUBDESCEX_SBS) ? SUBDESCEX_SBSCELL : SUBDESCEX_CELL;
					subsExTmp[subExIdx].Sub  = cell_id;
					subsExTmp[subExIdx].Para = cpn;
					subsExTmp[subExIdx].Flags= cell_type;
					subsExTmp[subExIdx].Id   = ++subdescex_id;
					last_cell_para = cpn;
					cell_ids.push (cell_id);

					char *ptr = (char*)(s + 6), frames [5];
					long width = atol (ptr), merge = 0, vertalign = -1;
					if (width < 0) {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ўирина €чейки не может быть отрицательной\n");
					}
					strcpy (frames, "1111");
					ptr = strchr (ptr, ' ');
					if (ptr) {
						strncpy (frames, ++ptr, 4);
						ptr = strchr (ptr, ' ');
						if (ptr) {
							merge = atol (++ptr);
							ptr = strchr (ptr, ' ');
							if (ptr)
								vertalign = atol (++ptr);
						}
					}

					my_table_row_cell_id = table_row_cell_id;
					MyWriter writer;
					evd::IeeGenerator_var generator = new evd::EeGenerator_i (&writer, sizeof (my_evd_buffer));

					generator->Start ();
						generator->StartChild(evd::id_TableCell);
							generator->AddIntegerAtom(evd::ti_Width, width);
							if (merge) generator->AddIntegerAtom(evd::ti_MergeStatus, merge);
							if (vertalign != -1) generator->AddIntegerAtom(evd::ti_VerticalAligment, vertalign);
							if (!strcmp (frames, "1111")) {
								if (table_type != SUBDESCEX_TABLE)
									generator->AddIntegerAtom (evd::ti_Frame, 1111);						
							} else if (!strcmp (frames, "0000")) {
								if (table_type != SUBDESCEX_SBS)
									generator->AddIntegerAtom(evd::ti_Frame, 0);
							} else {
								generator->StartTag(evd::ti_Frame);
								if (frames [1] == '1') {
									generator->StartTag(evd::ti_FrameLeft);
									generator->Finish();
								}
								if (frames [0] == '1') {
									generator->StartTag(evd::ti_FrameRight);
									generator->Finish();
								}
								if (frames [2] == '1') {
									generator->StartTag(evd::ti_FrameUp);
									generator->Finish();
								}
								if (frames [3] == '1') {
									generator->StartTag(evd::ti_FrameDown);
									generator->Finish();
								}
								generator->Finish();
							}
						generator->Finish();
					generator->Finish();
					if(((idd_evd_buffer_ptr-idd_evd_buffer)+my_evd_buffer_length > 32*1024*1024)
						|| my_evd_buffer_length > 256)
					{
						fprintf(stderr, "\n ERROR 444444");
						getch();
					}
					memcpy (idd_evd_buffer_ptr, my_evd_buffer, my_evd_buffer_length);
					idd_evd_buffer_ptr += my_evd_buffer_length;

					subExIdx++;

					subdescexids_instruct.push_back (subdescex_id);
					if (/*subdescex_id_inprocess && */map_subdescexid_firstchildid.find (subdescex_id_inprocess) == map_subdescexid_firstchildid.end ())
						map_subdescexid_firstchildid.insert (std::map<long,long>::value_type (subdescex_id_inprocess, subdescex_id));
					level++;
					long level_id = 0;
					std::map<long,long>::iterator map_it = map_level_maxid.find (level);
					if (map_it == map_level_maxid.end ()) {
						map_level_maxid.insert (std::map<long,long>::value_type (level, level_id));
					} else {
						level_id = ++map_it->second;
					}
					map_subdescexid_levelandlevelid.insert (std::map<long,long>::value_type (subdescex_id, (level << 24) + level_id));
					map_subdescexid_allleafparacount.insert(std::map<long,long>::value_type (subdescex_id, 0));
					vector_subdescex_ids.push_back (subdescex_id);
					subdescex_id_inprocess = subdescex_id;
					set_cell_subdescexids.insert (subdescex_id);
					map_subdescexid_to_id.insert (std::map<long,long>::value_type (subdescex_id, table_row_cell_id));
					map_subdescexid_type.insert (std::map<long,long>::value_type (subdescex_id, cell_type));
					map_subdescexid_firstpara.insert (std::map<long,long>::value_type (subdescex_id, cpn));

					if (row_ids.size () && cells_in_row.find (row_ids.top ()) != cells_in_row.end ())
						cells_in_row.find (row_ids.top ())->second++;
				}
				return ;
			} else
			if (IS_CMD (CASEDOCPARTICIPANT, s, l)) {
				return ;
			} else
			if (IS_CMD (CASECODE, s, l)) {
				const char *ptr;
				int len = 0;
				if( (len=CMD_CALL3 (CASECODE,getChars,s,l,ptr )) >0 ) {
					FString t (ptr,len);
					if( t.length() < CODE_KEY_SIZE ) {
						t.cp866Code();
	#ifndef	__FreeBSD__
						dbproc->addTopicCasecode(t.chars (), t.length () + 1, me);
	#endif
						dbproc->addTopicCode(me, t.chars(), t.length() +1 );
					}
				}
				return ;
			} else
			if (IS_CMD (CHAPTER,s,l) ) {
				const char *ptr;
				int len = 0;
				if ((len=CMD_CALL3 (CHAPTER, getChars, s, l, ptr)) > 0) {
					FString t(ptr,len);t.bDoFree= 1;

					bool aDupFound = false;
					if (!chaptersSet->seek (t)) {
						chaptersSet->add (t);
						t.bDoFree= 0;
					}

					if (cinfo->topicInpharmChapters->contains (t)) {
						for (short aSubs = 0; aSubs < lastSubsPos && !aDupFound; aSubs++)
							if (chapterSet [lastSubs [aSubs]]->contains (t))
								aDupFound = true;

						if (!aDupFound) {
							if( !chapterSet [lastSub]->seek (t)){
								chapterSet [lastSub]->add (t);
								t.bDoFree= 0;
							}
							FString *tt = &(cinfo->topicInpharmChapters->contents(cinfo->topicInpharmChapters->seek(t)));
							dbproc->addTopicChapter (tt->chars(),tt->length()+1, me, lastSub);
						}						
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© CHAPTER '%s'\n", t.chars());
					}
					/*
					FString t (ptr,len); t.bDoFree= 1;
					if (cinfo->topicInpharmChapters->contains (t) ){
						FString *tt = &((*cinfo->topicInpharmChapters)[t]);
						dbproc->addTopicChapter(tt->chars(),tt->length()+1, me, lastSub);
					}else{
						gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Н•®ІҐ•бв≠л© CHAPTER %s\n", t.chars());
					}
					*/
				}else{
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў CHAPTER.\n");
				}
				return ;
			} 
			if (!bIsSub) {
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
				return;
			}
			if (IS_CMD (CHANGE, s, l)) {
				char *ptr = (char*)(s + 7);
				long changed_id = atol (ptr) + ID_BORDER;
				if (changed_id) {
					ptr = strchr (++ptr, ' ');
					char reason = '\0';
					if (ptr) {
						reason = *++ptr;
					}
					IddChangeStruct idd_change = {changed_id, reason};
					dbproc->addTopicChange (me, &idd_change);
				} else {
					gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_WIN, "Ќеверный формат команды !GCHANGE\n");
				}
				return ;
			} else
#ifdef	VERSION56
/*CHDATE*/
			if ( IS_CMD(CHDATE,s,l)) {
				ChDateEx chDateEx;
				getChDate (s+CHDATE_DOFFS, l-CHDATE_DOFFS, chDateEx);
				dsChDateEx.insert (chDateEx);

				DocChDate chDate = {0};
				chDate.anonce = chDateEx.anonce;
				dsChDate.insert(chDate);

				if (dateCmp(Info.LastDate, chDateEx.anonce) < 0)
					Info.LastDate = chDateEx.anonce;
				
				bwasChDate = true;
			} else
/*CONTENTS*/
			if (IS_CMD (COUNTRY, s, l)) {
				const char *ptr;
				int len = 0;
				if ((len=CMD_CALL3 (COUNTRY,getChars,s,l,ptr)) > 0){
					FString t(ptr,len);t.bDoFree= 1;
					if (cinfo->topicInpharmCountries->contains (t) ){
						FString *tt = &((*cinfo->topicInpharmCountries)[t]);
						dbproc->addTopicInpharmCountry (tt->chars (), tt->length ()+1, me, lastSub);
					} else {
						gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© COUNTRY '%s'\n", t.chars());
					}
				}else{
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў COUNTRY.\n");
				}
			} else
			if ( IS_CMD(COMPARECONTENTS,s,l)) {
				CompareContentsStruct contents = {lastSub, 0};
				getCompareContents(s+COMPARECONTENTS_DOFFS, l-COMPARECONTENTS_DOFFS, contents);
				dsCompareContents.insert(contents);
			} else
			if ( IS_CMD(CONTENTS,s,l)) {
				ContentsStruct contents = { 0 };
				contents.Sub = lastSub;
#ifdef	VERSION61
				if ( !lastSub ) {
					wascontents0 = true;
					contents0 = true;
				}
#endif
				getContents(s+CONTENTS_DOFFS, l-CONTENTS_DOFFS, contents);
				dsContents.insert(contents);

				vector_contents.push_back (contents.Size);
				stack_block_with_contents.push_back (contents.Sub);
				block_with_contents.insert (contents.Sub);
				map_block_level.insert (std::map<long,long>::value_type (contents.Sub, block_level));
				max_level_in_contents = 0;
				if (true/*contents.Size*/) {
					//если указан !CONTENTS 0, это не значит "не показывать в оглавлении". Ёто значит "показывать только один уровень" (т.е. только себ€)
					max_level_in_contents = block_level + contents.Size;
					if (contents.Sub)
						blocks_in_contents.insert (contents.Sub);
				}
				if (block_level <= max_level_in_contents)
					block_with_contents.insert (contents.Sub);
				else {
					//блок вставл€лс€ в оглавление, встретив !BLOCK. ј потом у него мог быть contents 0, надо удалить
					std::set<long>::const_iterator it = blocks_in_contents.find (contents.Sub);
					if (it != blocks_in_contents.end ())
						blocks_in_contents.erase (contents.Sub);
				}
			} else
#endif
/*CLASS*/
			if( IS_CMD(CLASS,s,l) ) { 
				if (bIsNoDoc) {
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				} else {
					const char *ptr;
					int len;
					if( (len=CMD_CALL3(CLASS,getChars,s,l,ptr)) >0 ) {
						FString t(ptr,len);
						if( ci->cm->contains(t) ) {
							if (gprefixSet.empty ()) {
								FString pn = "Па†ҐЃҐЃ© ≠†Ґ®£†вЃа";
								gprefixSet.add ((*(ci->pm))[pn]);
							}

							long cn = (*(ci->cm))[t];
#ifdef	BLOCKSINHERIT
							bool aDupFound = false;
							for( short aSubs = 0; aSubs < lastSubsPos && !aDupFound; aSubs++ ) {
								if ( classSet[lastSubs[ aSubs ]].contains(cn))
									aDupFound = true;

								Pix pi;
								for( pi=classSet[lastSubs[ aSubs ]].first(); pi; classSet[lastSubs[ aSubs ]].next(pi) ) {
									int theid = classSet[ lastSubs[ aSubs ]]( pi );
									int neq = ci->clInfo[ theid ].nEquals;
									for (int idx1 = 0; idx1 < neq; idx1++)
										if ( cn == ci->clInfo[ theid ].equals[ idx1 ] )
											aDupFound = true;
								}
							}

							if( false ) { //aDupFound ) { перенесли проверку в flushSub
								gclog.printfC(errors, AdvLogger::LOG_ERROR,AdvLogger::CD_ALT,"ПЃҐвЃапой®©бп CLASS: '%s' BLOCK: %ld\n", t.chars(), lastSub);
							} else {
								classSet[lastSub].add(cn);
							}
#else
							if( classSet.contains(cn)) {
								gclog.printfC(errros,AdvLogger::LOG_ERROR,AdvLogger::CD_ALT,"ПЃҐвЃапой®©бп CLASS: '%s' BLOCK: %ld\n", t.chars(), lastSub);
							} else {
								classSet.add(cn);
							}
#endif
						} else {
							gclog.printfC(errors, AdvLogger::LOG_ERROR,AdvLogger::CD_ALT,"Н•®ІҐ•бв≠л© CLASS: '%s'\n", t.chars());
						}
						t.bDoFree=1;
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"о≈ Ќѕ«’ “Ѕ”–ѕЏќЅ‘Ў Ѕ“«’Ќ≈ќ‘\n");
					}
					
				}
			}
/*CODE*/
			else  if( IS_CMD(CODE,s,l) ) {
				if (bIsNoDoc) {
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				} else {
					const char *ptr;
					int len = CMD_CALL3(CODE,getChars,s,l,ptr);
					if( len ) {
						FString t(ptr,len);
						if( t.length() < CODE_KEY_SIZE ) {
							t.cp866Code();
							dbproc->addTopicCode(me, t.chars(), t.length() +1 );
							if (bEnglish) {
								std::string eng_code (t.chars ()), new_code;
								for (std::string::const_iterator it = eng_code.begin (); it != eng_code.end (); it++) {
									unsigned char c = (unsigned char) *it;
									int i = 0, added = 0;
									while (strlen (rus2eng [i])) {
										if (c == (unsigned char) rus2eng [i][0]) {
											new_code += rus2eng [i+1];
											added = 1;
											break;
										}
										i += 2;
									}
									if (!added)
										new_code += c;
								}
								FString new_t (new_code.c_str (), new_code.size ());
								new_t.cp866Code ();
								dbproc->addTopicCode (me, new_t.chars(), new_t.length() +1);
								dbproc->addTopicCode (me, new_code.c_str (), new_code.size () + 1);
							}
						} else {
							gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "КЃ§ '%s' §Ђ®≠≠•• %d\n", t.chars(), CODE_KEY_SIZE-1);
						}
						t.bDoFree=1;
						endPara();
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"дЅќќў≈ ЋѕЌЅќƒў CODE ”ћ…џЋѕЌ ƒћ…ќќў≈\n");
					}
				}
			}
/*CALENDAR*/
			else if( IS_CMD(CALENDAR,s,l) ) {
			}
/*CATEGORY*/
			else if( IS_CMD(CATEGORY,s,l) ) {
				const char *ptr;
				int len;
				if( (len = CMD_CALL3(CATEGORY,getChars,s,l,ptr))>0 ) {
					if( !norm ) {
						norm = new FString (ptr, len);
						norm->cp866Code();
						if( !normInfo->norms->contains(*norm) ) {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠Ѓ• І≠†з•≠®• NORM/CATEGORY '%s'\n", norm->chars());
							norm->bDoFree = 1;
							delete norm;
							norm = 0;
						} else {
							FString *nstr = new FString((*normInfo->norms)(normInfo->norms->seek(*norm)).chars());
							delete norm;
							norm = nstr;
       					}
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"оѕ“ЌЅ/ЋЅ‘≈«ѕ“…— ’÷≈ „”‘“≈ёЅћЅ”Ў.\n");						
					}
				} else {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ Ќѕ«’ “Ѕ”–ѕЏќЅ‘Ў Ѕ“«’Ќ≈ќ‘\n");
				}
			}
/*CHECK*/
			else  if( IS_CMD(CHECK,s,l) )
			{
			}
			else
			{
				FString t(s,l);
				t.bDoFree=1;
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
			}
		}
		else if (s[1] == 'I' ){
			if (IS_CMD (INTNAME,s,l)) {
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}

				if (lastSub) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"!INTNAME допустима только в шапке документа.\n");
					return ;
				} else {
					const char *ptr;
					int len;
					if ((len = CMD_CALL3 (INTNAME, getChars, s, l, ptr)) > 0) {
						if (len > INPHARM_INTNAME_SIZE) {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"!INTNAME: слишком длинна€ строка.\n");
						} else {
							if (!intname) {
								intname = new FString (ptr, len);
							} else {
								gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"!INTNAME уже указывалась.\n");
							}
						}
					}
				}
			} else
			if (IS_CMD(IZM,s,l)) {
				Info.Status_ex |= DS_IZM;
				bIsm = true;
			}
		}
		else if( s[1] == 'T' ) {
#ifndef QSORT_SRC
/*TOPIC*/
			if( IS_CMD(TOPIC,s,l)  ) {
				finishTopic();
				CMD_CALL3(TOPIC,mkFrom,s,l,0);
			}
			else
#endif
			if (IS_CMD (TRADENAME,s,l)) {
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}

				if (lastSub) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"!TRADENAME допустима только в шапке документа.\n");
					return ;
				} else {
					const char *ptr;
					int len;
					if ((len = CMD_CALL3 (TRADENAME, getChars, s, l, ptr)) > 0) {
						if (len > INPHARM_TRADENAME_SIZE) {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"!TRADENAME: слишком длинна€ строка.\n");
						} else {
							if (!tradename) {
								tradename = new FString (ptr, len);
							} else {
								gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"!TRADENAME уже указывалась.\n");
							}
						}
					}
				}
			} else
/*TABLE*/
			if( IS_CMD(TABLEEND,s,l)) {
				if (table_types.empty ()) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ƒл€ !TABLEEND не найдена открывающа€ !TABLE\n");
				} else {
					unsigned short table_type = table_types.top ();
					subsExTmp[subExIdx].Sub  = table_ids.top ();
					subsExTmp[subExIdx].Para = cpn;
					subsExTmp[subExIdx].Flags= table_type | SUBDESCEX_END;
					subsExTmp[subExIdx].Id   = ++subdescex_id;
					table_types.pop ();
					table_ids.pop ();
					subExIdx++;

					level--;
					long saved_subdescexid = *vector_subdescex_ids.rbegin ();
					map_subdescexid_lastpara.insert (std::map<long,long>::value_type (saved_subdescexid, cpn));
					vector_subdescex_ids.pop_back ();
					if (vector_subdescex_ids.size ()) {
						long table_leafs = map_subdescexid_allleafparacount.find (subdescex_id_inprocess)->second;
						subdescex_id_inprocess = *vector_subdescex_ids.rbegin ();

						std::map<long,long>::iterator map_it = map_subdescexid_lastchildid.find (subdescex_id_inprocess);
						if (map_it == map_subdescexid_lastchildid.end ())
							map_subdescexid_lastchildid.insert (std::map<long,long>::value_type (subdescex_id_inprocess, saved_subdescexid));
						else
							map_it->second = saved_subdescexid;

						long id = *vector_subdescex_ids.rbegin ();
						if ((set_block_subdescexids.find (id) != set_block_subdescexids.end ()) || (set_cell_subdescexids.find (id) != set_cell_subdescexids.end ()))
							map_subdescexid_allleafparacount.find (id)->second += table_leafs;
					} else
						subdescex_id_inprocess = 0;
				}
			} else
			if( IS_CMD(TABLE,s,l)) {
				endPara ();
				char *ptr = (char*)(s + 6);
				long table_id = ++table_row_cell_id;
				unsigned short table_type = ((atol (ptr) == 1) ? SUBDESCEX_SBS : SUBDESCEX_TABLE);
				subsExTmp[subExIdx].Sub  = table_id;
				subsExTmp[subExIdx].Para = cpn;
				subsExTmp[subExIdx].Flags= table_type;
				subsExTmp[subExIdx].Id   = ++subdescex_id;
				table_ids.push (table_id);
				table_types.push (table_type);
				map_tableid_type.insert (std::map<long,long>::value_type (table_id, table_type));
				subExIdx++;

				subdescexids_instruct.push_back (subdescex_id);
				if (/*subdescex_id_inprocess && */map_subdescexid_firstchildid.find (subdescex_id_inprocess) == map_subdescexid_firstchildid.end ())
					map_subdescexid_firstchildid.insert (std::map<long,long>::value_type (subdescex_id_inprocess, subdescex_id));
				level++;
				long level_id = 0;
				std::map<long,long>::iterator map_it = map_level_maxid.find (level);
				if (map_it == map_level_maxid.end ()) {
					map_level_maxid.insert (std::map<long,long>::value_type (level, level_id));
				} else {
					level_id = ++map_it->second;
				}
				map_subdescexid_levelandlevelid.insert (std::map<long,long>::value_type (subdescex_id, (level << 24) + level_id));
				map_subdescexid_allleafparacount.insert(std::map<long,long>::value_type (subdescex_id, 0));
				vector_subdescex_ids.push_back (subdescex_id);
				subdescex_id_inprocess = subdescex_id;
				map_subdescexid_to_id.insert (std::map<long,long>::value_type (subdescex_id, table_row_cell_id));
				map_subdescexid_type.insert (std::map<long,long>::value_type (subdescex_id, table_type));
				map_subdescexid_firstpara.insert (std::map<long,long>::value_type (subdescex_id, cpn));
			} else
/*TYPE*/
			if( IS_CMD(TYPE,s,l) ) {
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				const char *ptr;
				int len = 0;
				if (bIsNoDoc) {
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				} else if( (len=CMD_CALL3(TYPE,getChars,s,l,ptr)) >0 ){
					FString t(ptr,len);t.bDoFree= 1;

					bool aDupFound = false; // было typesSet->contains(t), т.е. не допускалось указание одинакового типа в шапке и сабе
					if(!typesSet->seek(t)) {
						typesSet->add(t);
						t.bDoFree= 0;
					}

					if( cinfo->topicTypes->contains( t ) ){
#ifdef	BLOCKSINHERIT
						for( short aSubs = 0; aSubs < lastSubsPos && !aDupFound; aSubs++ )
							if ( typeSet[lastSubs[ aSubs ]]->contains(t))
								aDupFound = true;

						if( aDupFound ) {
							/*
							gclog.printfC(AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"рѕ„‘ѕ“—јЁ… ”— TYPE: ");
							gclog.printfCP(AdvLogger::CD_ALT, "'%s'", t.chars());
							gclog.printfCP(AdvLogger::CD_ALT, " BLOCK: %ld\n", lastSub );
							*/
						} else {
							if(!typeSet[lastSub]->seek(t)){
								typeSet[lastSub]->add(t);
								t.bDoFree= 0;
							}
							FString *tt = &(cinfo->topicTypes->contents(cinfo->topicTypes->seek(t)));
							dbproc->addTopicType(tt->chars(),tt->length()+1, me, lastSub);
						}						
#else
						FString *tt = &((*cinfo->topicTypes)[t]);
						dbproc->addTopicType(tt->chars(),tt->length()+1, me, lastSub);
#endif
					}else{
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© в®ѓ '%s'\n", t.chars());
					}
				}else{
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў TYPE.\n");
				}
			}
/*TERM*/
			else if( IS_CMD(TERM,s,l) ) {
				/*
				if (!bIsParaExist) {
					mkNewPara("P 0 73 0",8);
					issuePrefPara((const unsigned char *)"EMPTY",5);
    					bIsSub = 0;
	    				cpn++;wordInPara=0;
					bIsParaExist=1;
				}
				*/

				CMD_CALL4(TERM,doSub,s,l,100,true);

				/*
				s+=TERM_DOFFS;
				l-=TERM_DOFFS;
				while( l && (*s == ' ' || *s=='\t' || (*s >= '0' && *s <= '9')) ) {
	  				s++; l--;
				}
				mkNewPara("P 0 73 0",8);
				issuePrefPara((const unsigned char *)s,l);
   				bIsSub = 0;
				cpn++;wordInPara=0;
				*/
			}
/*TERRITORY*/
			else if( IS_CMD(TERRITORY,s,l) )
			{
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				const char *ptr;
				int len = 0;
				if (bIsNoDoc) {
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				} else if (lastSub) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, " оманда TERRITORY недопустима в %d сабе.\n",lastSub);
				} else  {
					if( (len=CMD_CALL3(TERRITORY,getChars,s,l,ptr)) >0 ) {
						FString t(ptr,len);
						if( si->tm->contains( t ) ) {
							long n = (*(si->tm))[t];
							territorySet.add(n);
						} else {
							gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_ALT,"Н•®ІҐ•бв≠л© TERRITORY '%s'\n", t.chars());
						}
						t.bDoFree=1;
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў TYPE.\n");
					}
				}
			} else {
				endPara();
				FString t(s,l);
				t.bDoFree=1;
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
			}
		}
/*PUBLISHEDIN*/
		else if( s[1] == 'P' ) {
			endPara();
			if (!bIsSub) {
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
				return;
			}
			
			if (IS_CMD (PHARMGROUP,s,l) ) {
				if (lastSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда !PHARMGROUP допустима только в шапке документа.\n");
					return;
				}
				const char *ptr;
				int len = 0;
				if ((len=CMD_CALL3 (PHARMGROUP, getChars, s, l, ptr)) > 0) {
					FString t (ptr,len); t.bDoFree= 1;
					if (cinfo->topicInpharmPharmGroups->contains (t) ){
						FString *tt = &((*cinfo->topicInpharmPharmGroups)[t]);
						dbproc->addTopicPharmGroup (tt->chars(),tt->length()+1, me);
					}else{
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© PHARMGROUP '%s'\n", t.chars());
					}
				}else{
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў PHARMGROUP.\n");
				}
			} else
			if (IS_CMD (PHARMEFFECT,s,l) ) {
				if (lastSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда !PHARMEFFECT допустима только в шапке документа.\n");
					return;
				}
				const char *ptr;
				int len = 0;
				if ((len=CMD_CALL3 (PHARMEFFECT, getChars, s, l, ptr)) > 0) {
					FString t (ptr,len); t.bDoFree= 1;
					if (cinfo->topicInpharmPharmEffects->contains (t) ){
						FString *tt = &((*cinfo->topicInpharmPharmEffects)[t]);
						dbproc->addTopicPharmEffect (tt->chars(),tt->length()+1, me);
					}else{
						gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© PHARMEFFECT '%s'\n", t.chars());
					}
				}else{
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў PHARMEFFECT.\n");
				}
			} else
			if( IS_CMD(PUBLISHEDIN,s,l) ) {
				const char *ptr;
				int len;
				if( (len=CMD_CALL3(PUBLISHEDIN,getChars,s,l,ptr)) >0 ) {
					char* smallS = new char[ strlen( ptr ) + 1 ];
					strcpy( smallS, ptr );

					bool isDummy = /*strlen( smallS )-1 &&*/ smallS[0]=='@' /*&& smallS[1]=='|'*/;
					if ( !isDummy ) {
						{
							FString tt(ptr,len);tt.bDoFree=1;
							if ( !cinfo->pubSrcMap->contains(tt) ) {
								for ( int I = 0; I < 2; I++ ) {
									char* delimiterPos = strrchr( smallS, '|' );
									if ( !delimiterPos ) break;
									*++delimiterPos = 0;
									{
										FString ttt(smallS, strlen(smallS)); ttt.bDoFree=1;
										if ( cinfo->pubSrcMap->contains(ttt) )
											break;
									}
									*--delimiterPos = 0;
									{
										FString ttt(smallS, strlen(smallS)); ttt.bDoFree=1;
										if ( cinfo->pubSrcMap->contains(ttt) )
											break;
									}
								}
							}
						}
						FString t(smallS,strlen(smallS));t.bDoFree=1;
						if( cinfo->pubSrcMap->contains(t) ) {
							Pix fnd= cinfo->pubSrcMapConverter->seek(t);
							FString *old;
							if(fnd)
								old= &(cinfo->pubSrcMapConverter->contents(fnd));
							else{
								old= &((*cinfo->pubSrcMapConverter)[t]);
								t.bDoFree=0;
							}
							if (old->length()) {
								dbproc->addTopicPublishedIn(me,old->chars(),old->length()+1);
							} else {
								gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…Ќў≈ ƒЅќќў≈ „ ЋѕЌЅќƒ≈\n");
							}
						} else {
							gclog.printfC(errors, AdvLogger::LOG_ERROR,AdvLogger::CD_ALT,"Н•®ІҐ•бв≠л© PUBLISHEDIN: '%s'\n", t.chars());
						}
					}
					delete smallS;
				}
				else {
					gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"о≈ Ќѕ«’ “Ѕ”–ѕЏќЅ‘Ў Ѕ“«’Ќ≈ќ‘\n");
				}
			}
/*PRICELEVEL*/
			else if( IS_CMD(PRICELEVEL,s,l) )
			{
			}
/*PREFIX*/
			else if( IS_CMD(PREFIX,s,l) )
			{
				if (bIsNoDoc) {
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				} else {
					const char *ptr;
					int len;
					if( (len=CMD_CALL3(PREFIX,getChars,s,l,ptr)) >0 ) {
						FString t(ptr,len);

						if (cinfo->topicKinds && !strcmp (ptr, bEnglish ? "Forms of documents" : "ФЃађл §Ѓ™гђ•≠вЃҐ")) {
							FString *tt = &((*cinfo->topicKinds)[t]);
							dbproc->addTopicKind(tt->chars(),tt->length()+1, me, lastSub);
							b_was_kind = true;
						}

						/*
						if ( !strncmp( ptr, "А™вл Ѓа£†≠ЃҐ ҐЂ†бв®", 20 ) || !strncmp( ptr, "АКТЫ ОРГАНОВ ВЛАСТИ", 20 )) {
							bIsPrefixDocuments = 1;
						}
						if ( !strncmp( ptr, "М•¶§г≠†аЃ§≠л• §Ѓ£ЃҐЃал", 23 ) || !strncmp( ptr, "МЕЖДУНАРОДНЫЕ ДОГОВОРЫ", 23 )) {
							bIsPrefixInternational = 1;
						}

						if (t == "Сг§•°≠†п ѓа†™в®™†")
							b_prefix_is_sudebnaya = true;
						else
						if (!strncmp (ptr, "КЃђђ•≠в†а®®", 11))
							b_prefix_is_comment = true;
						*/

						t = "Па†ҐЃҐЃ© ≠†Ґ®£†вЃа";
						if( ci->pm->contains(t) ) {
							long pn = (*(ci->pm))[t];

							bool aDupFound = false;
							if ( lastSub ) {
								if ( prefixSet.contains( pn ))
									aDupFound = true;
							} else {
								if ( gprefixSet.contains( pn ))
									aDupFound = true;
							}
						#ifdef	BLOCKSINHERIT
							for( short aSubs = 0; aSubs < lastSubsPos && !aDupFound; aSubs++ )
								if ( prefixesSet[lastSubs[ aSubs ]].contains(pn))
									aDupFound = true;
						#endif

							if( lastSub ) {
								if( aDupFound ) {
									/*
									gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"рѕ„‘ѕ“—јЁ… ”— PREFIX: ");
									gclog.printfCP(AdvLogger::CD_ALT, "'%s'", t.chars());
									gclog.printfCP(AdvLogger::CD_ALT, " BLOCK: %ld\n", lastSub );
									*/
								} else {
									prefixSet.add(pn);
								#ifdef	BLOCKSINHERIT
									prefixesSet[lastSub].add(pn);
								#endif
								}
							} else {
								if( aDupFound ) {
									/*
									gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"рѕ„‘ѕ“—јЁ… ”— PREFIX: ");
									gclog.printfCP(AdvLogger::CD_ALT, "'%s'", t.chars());
									gclog.printfCP(AdvLogger::CD_ALT, " BLOCK: %ld\n", lastSub );
									*/
								} else {
									gprefixSet.add(pn);
								}
							}
						} else {
							gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"Н•®ІҐ•бв≠л© PREFIX: '%s'\n", t.chars());
						}
						t.bDoFree=1;
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"о≈ Ќѕ«’ “Ѕ”–ѕЏќЅ‘Ў Ѕ“«’Ќ≈ќ‘\n");
					}
				}
			}
/*PRIORITY*/
			else if ( IS_CMD(PRIORITY,s,l) )
			{
				if (bIsNoDoc) {
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				} else  {
					int  val;
					if( CMD_CALL3(PRIORITY,getInt,s,l,val) == 0 ) {
						if( !bPrioritySet ) {
							bPrioritySet = 1;
							ctprio = val;
						} else {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"рѕ„‘ѕ“—јЁЅ—”— ЋѕЌЅќƒў PRIORITY.\n");
						}
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў PRIORITY.\n");
					}
				}
			}
/*PREACTIVE*/
			else if( IS_CMD(PREACTIVE,s,l) )
			{
#ifdef VERSION56
				if (!cinfo->notADocs->contains (me)) {
					DocActivityEx docActivity={0};
					docActivity.b_add_iddactive = true;
					getActivity(s+PREACTIVE_DOFFS, l-PREACTIVE_DOFFS, docActivity);
					if ( docActivity.from.da_year ) {
						gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,"лѕЌЅќƒЅ PREACTIVE ’ЋЅЏЅќЅ „ ”‘Ѕ“ѕЌ ∆ѕ“ЌЅ‘≈.\n");
						Info.Status |= DS_PREACTIVE;

						/* дата игнорируетс€
						if( dateCmp( docActivity.from, todayDate ) <= 0 )
							if( dateCmp( docActivity.from, prevSatDate ) >= 0 )
								gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,"фѕ–…Ћ „”‘’–…ћ „ ”…ћ’ ќЅ №‘ѕ  ќ≈ƒ≈ћ≈.\n");

						if( dateCmp( docActivity.from, todayDate ) >= 0 )
							if( !( Info.Status & DS_ABOLISHED )) {
								Info.Status |= DS_PREACTIVE;
							}
							else
								gclog.printfC(AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"PREACTIVE ABOLISED TOPIC\n");
						*/
					} else {
						if( !( Info.Status & (DS_ABOLISHED|DS_ACTIVE) )) {
							Info.Status |= DS_PREACTIVE;
							dsActivity.insert(docActivity);
						}
						else
							gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"конфликт PREACTIVE с NOACTIVE или ACTIVE\n");
					}
				}
#else // стара€ верси€
				if (bIsNoDoc)
				{
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				}
				else 
				{
					date d;
					if( CMD_CALL3(PREACTIVE,getDate,s,l,d) )
					{
						if( dateCmp( d, todayDate ) <= 0 )
							if( dateCmp( d, prevSatDate ) >= 0 )
								gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,"фѕ–…Ћ „”‘’–…ћ „ ”…ћ’ ќЅ №‘ѕ  ќ≈ƒ≈ћ≈.\n");

						if( dateCmp( d, todayDate ) >= 0 )
						{
							if( !( Info.Status & DS_ABOLISHED ))
							{
								Info.Status |= DS_PREACTIVE;
							}
							else
							{
								gclog.printfC(errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"PREACTIVE ABOLISED TOPIC\n");
							}
						}
					}
					else
					{
						if( !( Info.Status & DS_ABOLISHED ))
						{
							Info.Status |= DS_PREACTIVE;
						}
						else
						{
							gclog.printfC(errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"PREACTIVE ABOLISED TOPIC\n");
						}
					}
				}
#endif
			}
/*PRA*/
			else if( IS_CMD(PRA,s,l) )
			{
			}
			else {
				FString t(s,l);
				t.bDoFree=1;
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
			}
		}
		else if( s[1] == 'V' )
		{
			endPara();
			if (!bIsSub) {
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
				return;
			}
/*VINCLUDED*/
			if( IS_CMD(VINCLUDED,s,l) ) {
				if (bIsNoDoc|| bIsEdition || isBlob) {
				} else {
					if( !bVIncludedSet ) {
						if( CMD_CALL3(VINCLUDED,getDate,s,l, dVIncluded) ) {
							if ( dateCmp( dVIncluded, satDate ) > 0 )
								gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,"ƒата подключени€ - будущие недели\n");
							if (maxDate.da_year && dateCmp (dVIncluded, maxDate) > 0) {
								gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"ƒата VINCLUDED больше MaxDate\n");
								dVIncluded = maxDate;
							}
							bVIncludedSet = 1;
							dbproc->addTopicVIncluded(me, dVIncluded );
						} else {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈„≈“ќў  ∆ѕ“ЌЅ‘ ƒЅ‘ў\n");
						}
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"рѕ„‘ѕ“—јЁЅ—”— ЋѕЌЅќƒЅ VINCLUDED.\n");
					}
				}
			}
/*VCHANGED*/
			else if( IS_CMD(VCHANGED,s,l) ){
				if (bIsNoDoc|| bIsEdition) {
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				} else {
					date d;
					if( CMD_CALL3(VCHANGED,getDate,s,l,d) ){
						if ( dateCmp( d, satDate ) > 0 )
							gclog.printfC (errors, AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,"ƒата VCHANGED - будущие недели\n");
						if (maxDate.da_year && dateCmp (d, maxDate) > 0) {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"ƒата VCHANGED больше MaxDate\n");
							d = maxDate;
						}
						dsVchanged.add(d);
						/*
						if (dateCmp(Info.LastDate, d) < 0)
							Info.LastDate = d;
						*/
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈„≈“ќў  ∆ѕ“ЌЅ‘ ƒЅ‘ў\n");
					}
				}
			}
/*VABOLISHED*/
			else if( IS_CMD(VABOLISHED,s,l) ) {
				if (bIsNoDoc|| bIsEdition) {
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				} else {
					if( !bVAbolishedSet ){
						if( CMD_CALL3(VABOLISHED,getDate,s,l,dVAbolished) ){
							if ( dateCmp( dVAbolished, satDate ) > 0 )
								gclog.printfC (errors, AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,"ƒата VABOLISHED - будущие недели\n");
							if (maxDate.da_year && dateCmp (dVAbolished, maxDate) > 0) {
								gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"ƒата VABOLISHED больше MaxDate\n");
								dVAbolished = maxDate;
							}
							bVAbolishedSet = 1;
							dbproc->addTopicVAbolished(me, dVAbolished );
						} else{
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ƒЅ‘ў\n");
						}
						
					}else{
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "рѕ„‘ѕ“—јЁЅ—”— ЋѕЌЅќƒЅ VABOLISHED.\n");
					}
				}
/*VANONCED*/
			}
			else if( IS_CMD(VANONCED,s,l) ){
				if (bIsNoDoc|| bIsEdition) {
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				} else {
					if( !bVAnoncedSet ) {
						if( CMD_CALL3(VANONCED,getDate,s,l,dVAnonced) ) {
							if ( dateCmp(dVAnonced, satDate ) > 0 )
								gclog.printfC (errors, AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,"ƒата подключени€ - будущие недели\n");
							if (maxDate.da_year && dateCmp (dVAnonced, maxDate) > 0) {
								gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"ƒата VANONCED больше MaxDate\n");
								dVAnonced = maxDate;
							}
							dbproc->addTopicVAnonced(me, dVAnonced);
							bVAnoncedSet = 1;
						} else {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈„≈“ќў  ∆ѕ“ЌЅ‘ ƒЅ‘ў\n");
						}
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "фѕ–…Ћ ’÷≈ Ѕќќѕќ”…“ѕ„Ѕќ.\n");
					}
				}
			}
/*VLCONTROL*/
			else if( IS_CMD(VLCONTROL,s,l) ) {
				if (bIsNoDoc) {
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				} else {
					if( !bVLControlSet ) {
						date d;
						if( CMD_CALL3(VLCONTROL,getDate,s,l,d) ) {
							if ( dateCmp( d, satDate ) > 0 )
								gclog.printfC (errors, AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,"ƒата VLCONTROL - будущие недели\n");
							if (maxDate.da_year && dateCmp (d, maxDate) > 0) {
								gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"ƒата VLCONTROL больше MaxDate\n");
								d = maxDate;
							}
							dbproc->addTopicVLControl(me, d );
							bVLControlSet = 1;
						} else {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈„≈“ќў  ∆ѕ“ЌЅ‘ ƒЅ‘ў\n");
						}
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"рѕ„‘ѕ“—јЁ…≈”— ЋѕЌЅќƒў VLCONTROL\n");
					}
				}
			}
/*VERLINK*/
			else if (IS_CMD(VERLINK,s,l)) {
#ifdef VERSION56
				if (wasVerlink) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ѕольше одной команды !VERLINK в одном топике.\n");
				}
				++wasVerlink;
				int val; 
				if (CMD_CALL3(VERLINK,getInt,s,l,val) == 0) {
					if (bad_docs->find (val+REAL_DOC_OFFS) == bad_docs->end ())
						Info.prevEdition=val+REAL_DOC_OFFS;
				}
#endif
			} else {
				FString t(s,l);
				t.bDoFree=1;
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
			}
		}
		else if( s[1] == 'K' )
		{
			endPara();
			if (!bIsSub) {
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
				return;
			}
			if( IS_CMD(KIND,s,l)) {
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				const char *ptr;
				int len = 0;
				if (bIsNoDoc) {
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				} else if( (len=CMD_CALL3(KIND,getChars,s,l,ptr)) >0 ){
					FString t(ptr,len);t.bDoFree= 1;

					if( cinfo->topicKinds->contains( t ) ){
						FString *tt = &((*cinfo->topicKinds)[t]);
						dbproc->addTopicKind(tt->chars(),tt->length()+1, me, lastSub);
						b_was_kind = true;
					}else{
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© Ґ®§ '%s'\n", t.chars());
					}
				}else{
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў KIND.\n");
				}
			} else

/*KEY*/
			if( IS_CMD(KEY,s,l) ) {
				if (bIsNoDoc) {
					//gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈ƒѕ–’”‘…ЌЅ— ЋѕЌЅќƒЅ ’ NODOC ƒѕЋ’Ќ≈ќ‘Ѕ.\n");
				} else {
					CMD_CALL(KEY,doKey,s,l);
				}
			} else {
				FString t(s,l);
				t.bDoFree=1;
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
			}
		}
		else if( s[1] == 'U' )
		{
			endPara();
			if (IS_CMD (UNRECIPE, s, l)) {
				Info.Status_ex |= DS_UNRECIPE;
				dbproc->setTopicStatus_ex (me, DS_UNRECIPE, lastSub);
				return ;
			} else
			if (!bIsSub) {
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
				return;
			}
/*USERINFO*/
			if( IS_CMD(USERINFO,s,l) ) {
			} else {
				FString t(s,l);
				t.bDoFree=1;
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
			}
		}
		else if( s[1] == 'A' ) {
			if (IS_CMD (ADDCODE, s, l)) {
				if (!bIsNoDoc) {
					const char *ptr;
					int len = CMD_CALL3(ADDCODE,getChars,s,l,ptr);
					if( len ) {
						FString t(ptr,len);
						if( t.length() < CODE_KEY_SIZE ) {
							t.cp866Code ();
							dbproc->addTopicAddCode (me, t.chars(), t.length() +1);
							if (bEnglish) {
								std::string eng_code (t.chars ()), new_code;
								for (std::string::const_iterator it = eng_code.begin (); it != eng_code.end (); it++) {
									unsigned char c = (unsigned char) *it;
									int i = 0, added = 0;
									while (strlen (rus2eng [i])) {
										if (c == (unsigned char) rus2eng [i][0]) {
											new_code += rus2eng [i+1];
											added = 1;
											break;
										}
										i += 2;
									}
									if (!added)
										new_code += c;
								}
								FString new_t (new_code.c_str (), new_code.size ());
								new_t.cp866Code ();
								dbproc->addTopicAddCode (me, new_t.chars(), new_t.length() +1);
								dbproc->addTopicAddCode (me, new_code.c_str (), new_code.size () + 1);
							}
						} else {
							gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "КЃ§ '%s' §Ђ®≠≠•• %d\n", t.chars(), CODE_KEY_SIZE-1);
						}
						t.bDoFree=1;
						endPara();
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"дЅќќў≈ ЋѕЌЅќƒў ADDCODE ”ћ…џЋѕЌ ƒћ…ќќў≈\n");
					}
				}
				return ;
			} else if (IS_CMD (ARCHICHECK, s, l))
				return ;
			else
			if (IS_CMD (ALLOWED, s, l)) {
				endPara();
				Info.Status_ex |= DS_ALLOWED;
				dbproc->setTopicStatus_ex (me, DS_ALLOWED, lastSub);
				return ;
			} else
			if (IS_CMD (ATC, s, l)) {
				endPara();
				if (lastSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда !ATC допустима только в шапке документа.\n");
					return;
				}
				const char *ptr;
				int len = 0;
				if( (len=CMD_CALL3 (ATC,getChars,s,l,ptr)) > 0) {
					FString t(ptr,len);t.bDoFree= 1;
					if (cinfo->topicInpharmAtcs->contains (t) ) {
						FString *tt = &((*cinfo->topicInpharmAtcs)[t]);
						dbproc->addTopicAtc (tt->chars (), tt->length ()+1, me);
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© ATC '%s'\n", t.chars());
					}
				}else{
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў ATC.\n");
				}
				return ;
			} else
			if( IS_CMD (ANNULDATE,s,l)) {
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				date d;
				if (CMD_CALL3 (ANNULDATE,getDate,s,l,d))
					dbproc->addTopicAnnulDate (me, d, lastSub);

				return ;
			} else
/*ADWORD*/
			if (IS_CMD (ADWORD, s, l)) {
				const char *ptr;
				int len = 0;
				if( (len=CMD_CALL3( ADWORD,getChars,s,l,ptr )) >0 ) {
					FString t (ptr,len);
					dbproc->addTopicAdword (t.chars (), t.length () + 1, me, lastSub);
				}
			} else
/*ANNOTOPIC*/
			if( IS_CMD(ANNOTOPIC,s,l)  )
			{
#ifdef	VERSION62
				finishTopic();
				annoPhase = true;
				CMD_CALL3(ANNOTOPIC,mkFrom,s,l,0);
				Info.Status |= DS_ANNO;
				SetDocMonitoring(&Info,DocId-ID_ANNOPLUS);
				annoPhase = false;
#endif
				return;
			}
			endPara();
			if (!bIsSub) {
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
				return;
			}
/*ANNOEND*/
			/*
			if ( IS_CMD(ANNOEND,s,l) )
			{
				annoPhase = false;
			}
			*/
/*ANNO*/
			/*
			else if ( IS_CMD(ANNO,s,l) )
			{
				annoPhase = true;
				annoLine  = 0;
				char	sLine[ 32 ];
				long	docId = me + ANNOPLUS;
				sprintf( sLine, "!TOPIC %u", docId - REAL_DOC_OFFS );
				annoLines[ annoLine++ ] = strdup( sLine );
				annoLines[ annoLine++ ] = strdup( "!BELONGS PRIME" );
				annoLines[ annoLine++ ] = strdup( "!NODOC" );
				(*cinfo->topicBelongs)[ docId ].add( 238 );
				cinfo->notADocs->add(docId );
				SetDocMonitoring(&Info,docId);
			}
			*/
/*ANNOUSER*/
			if( IS_CMD(ANNOUSER,s,l) )
			{
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				const char *ptr;
				int len = 0;
				if( (len=CMD_CALL3(ANNOUSER,getChars,s,l,ptr)) >0 ){
					FString t(ptr,len);t.bDoFree= 1;
					if(!annoUserSet->seek(t)){
						annoUserSet->add(t);
						t.bDoFree= 0;
					}
					if( cinfo->topicAnnoUser && cinfo->topicAnnoUser->contains( t ) ){
						FString *tt = &((*cinfo->topicAnnoUser)[t]);
						dbproc->addTopicAnnoUser(tt->chars(),tt->length()+1, me);
					}else{
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© в®ѓ '%s'\n", t.chars());
					}
				}
			}
			else if( IS_CMD(ANNOSIGNIFICANT,s,l) ) {
			}
/*ANNOORGANIZATION*/
			else if( IS_CMD(ANNOORGANIZATION,s,l) )
			{
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				const char *ptr;
				int len = 0;
				if( (len=CMD_CALL3(ANNOORGANIZATION,getChars,s,l,ptr)) >0 ){
					FString t(ptr,len);t.bDoFree= 1;
					if(!annoOrganizationSet->seek(t)){
						annoOrganizationSet->add(t);
						t.bDoFree= 0;
					}
					if( cinfo->topicAnnoOrganization && cinfo->topicAnnoOrganization->contains( t ) ){
						FString *tt = &((*cinfo->topicAnnoOrganization)[t]);
						dbproc->addTopicAnnoOrganization(tt->chars(),tt->length()+1, me);
					}else{
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© в®ѓ '%s'\n", t.chars());
					}
				}
			}
/*ANNOTAX*/
			else if( IS_CMD(ANNOTAX,s,l) )
			{
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				const char *ptr;
				int len = 0;
				if( (len=CMD_CALL3(ANNOTAX,getChars,s,l,ptr)) >0 ){
					FString t(ptr,len);t.bDoFree= 1;
					if(!annoTaxSet->seek(t)){
						annoTaxSet->add(t);
						t.bDoFree= 0;
					}
					if( cinfo->topicAnnoTax && cinfo->topicAnnoTax->contains( t ) ){
						FString *tt = &((*cinfo->topicAnnoTax)[t]);
						dbproc->addTopicAnnoTax(tt->chars(),tt->length()+1, me);
					}else{
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© в®ѓ '%s'\n", t.chars());
					}
				}
			}
/*ANNOINTEREST*/
			else if( IS_CMD(ANNOINTEREST,s,l) )
			{
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				const char *ptr;
				int len = 0;
				if( (len=CMD_CALL3(ANNOINTEREST,getChars,s,l,ptr)) >0 ){
					FString t(ptr,len);t.bDoFree= 1;
					if(!annoInterestSet->seek(t)){
						annoInterestSet->add(t);
						t.bDoFree= 0;
					}
					if( cinfo->topicAnnoInterest && cinfo->topicAnnoInterest->contains( t ) ){
						FString *tt = &((*cinfo->topicAnnoInterest)[t]);
						dbproc->addTopicAnnoInterest(tt->chars(),tt->length()+1, me);
					}else{
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© в®ѓ '%s'\n", t.chars());
					}
				}
			}
/*ANNOKIND*/
			else if( IS_CMD(ANNOKIND,s,l) )
			{
				endPara();
				if (!bIsSub) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, " оманда после параграфа. %ld саб.\n", lastSub);
					return;
				}
				const char *ptr;
				int len = 0;
				if( (len=CMD_CALL3(ANNOKIND,getChars,s,l,ptr)) >0 ){
					FString t(ptr,len);t.bDoFree= 1;
					if(!annoKindSet->seek(t)){
						annoKindSet->add(t);
						t.bDoFree= 0;
					}
					if( cinfo->topicAnnoKind && cinfo->topicAnnoKind->contains( t ) ){
						FString *tt = &((*cinfo->topicAnnoKind)[t]);
						dbproc->addTopicAnnoKind(tt->chars(),tt->length()+1, me);
					}else{
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠л© в®ѓ '%s'\n", t.chars());
					}
				}
			}
/*ANNODATE*/
			else if( IS_CMD(ANNODATE,s,l)) {
				if ( !bAnnoSet ) {
					date d;
					if( CMD_CALL3(VCHANGED,getDate,s,l,d) ) {
						dbproc->addTopicAnnoDate(me, d);
						bAnnoSet = 1;
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈„≈“ќў  ∆ѕ“ЌЅ‘ ƒЅ‘ў\n");
					}
				} else {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "” топика уже есть !ANNODATE\n");
				}
			}

			else if( IS_CMD(ANNONAME,s,l) )
			{
				CMD_CALL(ANNONAME,doName,s,l);
			}
/*ANONCE*/
			else if( IS_CMD(ANONCE,s,l) )
			{
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "лѕЌЅќƒЅ ANONCED ’”‘Ѕ“≈ћЅ.\n");
			}
/*ALTMENU*/
			else if( IS_CMD(ALTMENU,s,l) )
			{
			}
/*ADDMENU*/
			else if( IS_CMD(ADDMENU,s,l) )
			{
			}
/*ARTICLE*/
			else if( IS_CMD(ARTICLE,s,l) )
			{
			}
/*ALARM*/
#ifdef	VERSION56
			else if( IS_CMD(ALARM,s,l) )
			{
				DocActivityEx docActivity={0};
				getActivity(s+ALARM_DOFFS, l-ALARM_DOFFS, docActivity);
				if (!is_lt(docActivity.from, prevSatDate) && 
					is_lt(docActivity.from, date_plusdays(prevSatDate, 7))) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_ALT, "ALARM %s\n", docActivity.text);
				}

			}
#endif
/*ACTIVE*/
			else if( IS_CMD(ACTIVE,s,l) ) {
#ifdef VERSION56
				DocActivityEx docActivity={0};
				docActivity.b_add_iddactive = true;
				docActivity.block = lastSub;
				getActivity(s+ACTIVE_DOFFS, l-ACTIVE_DOFFS, docActivity);
				if (!is_ok(docActivity)) {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "«адан неверный интервал активности (!ACTIVE).\n");
				} else {
					std::map<long,date>::iterator it = cinfo->incorrect_dates_to->find (me);
					if (it != cinfo->incorrect_dates_to->end () && is_eq (it->second, docActivity.to)) {
						docActivity.to = cinfo->incorrect_dates_toto->find (me)->second;
					}

				#ifdef	unix
					if (is_lt (todayDate, docActivity.to)) {
						bShowActiveToWarning = true;
					}
				#endif
					dsActivity.insert(docActivity);
				}
#endif // VERSION56
			} else {
				FString t(s,l);
				t.bDoFree=1;
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
			}
		}
		else if( s[1] == 'E' )
		{
/*EDITION*/
#ifdef VERSION56
			if( IS_CMD(EDITION,s,l) )
			{
				Info.Status |= DS_EDITION | DS_NODOC;
			}
#endif
		}
		else if( s[1] == 'O' )
		{
/*OBJTYPE*/
			if( IS_CMD(OBJTYPE,s,l) )
			{
				const char *ptr;
				int len;
				if( (len=CMD_CALL3(OBJTYPE,getChars,s,l,ptr)) >0 )
				{
					FString t(ptr,len);t.bDoFree= 1;
					if ( !stricmp( t.chars(), "EVD" )) {
						objType = EOT_EVD;
					} else
					if (cinfo->objTypes->contains(t)) {
						objType = (*cinfo->objTypes)[t];
					} else {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈…Џ„≈”‘ќў  ‘…– ѕ¬я≈Ћ‘Ѕ: '%s'\n", t.chars());
						bObjectOk = 0;
					}
				}
			}
/*OBJTOPIC*/
			else if( IS_CMD(OBJTOPIC,s,l)  ) {
				finishTopic();
				CMD_CALL3(OBJTOPIC,mkFrom,s,l,1);
			}
/*OBJPATH*/
			else if( IS_CMD(OBJPATH,s,l) ) {
				const char *ptr;
				int len;
				if( (len=CMD_CALL3(OBJPATH,getChars,s,l,ptr)) >0 ) {
					if (bObjectOk)
						loadObject(ptr, len );
				} else {
					gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"о≈ Ќѕ«’ “Ѕ”–ѕЏќЅ‘Ў Ѕ“«’Ќ≈ќ‘\n");
				}
			} else {
				endPara();
				FString t(s,l);
				t.bDoFree=1;
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
			}
		} else {
			endPara();
			FString t(s,l);
			t.bDoFree=1;
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Н•®ІҐ•бв≠†п ™Ѓђ†≠§† '%s'\n",t.chars());
		}
		return;
	}
	if (isBlob) {
		if (l) gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "“екст в объектном топике \"%s\".\n", s);
		return;
	}

	if (s [0] == '!' && s [1] == '!') {
		s++;
		l--;			
	}
	
	const char *whiteLinePtr;
	if (getChars (s, l, whiteLinePtr) == 0) {
		if( !paraStyle /*|| paraStyle == PS_PREFORMATTED*/ ){
			if( me ){
				if ( !cpn && cinfo && cinfo->anonces->contains(me) && !bEnglish ) {
					dbproc->addTopicEmptyPara(me);
					paraCount++;
					const char* ss = "!STYLE J 1 72 1";
					CMD_CALL(STYLE,mkNewPara,ss,15);
					strcpy( (char*)paraBuf, " СҐ•§•≠®п Ѓ бв†вгб• §Ѓ™гђ•≠в†, •£Ѓ бҐпІпе б ®≠дЃађ†ж®Ѓ≠≠лђ °†≠™Ѓђ ® §аг£†п ѓЃЂ•І≠†п †≠†Ђ®в®з•б™†п ®≠дЃађ†ж®п Ѓ §†≠≠Ѓђ §Ѓ™гђ•≠в• °г§гв ѓа•§бв†ҐЂ•≠л Ґ Ѓ§≠Ѓђ ®І °Ђ®¶†©и®е Ґлѓгб™ЃҐ б®бв•ђл ГАРАНТ" );
					paraBufPos = strlen( (char*)paraBuf );
					endPara(); endParaEx ();
					cpn++; wordInPara=0;
				}

				if ( lastSkippedPara == -1 ) {
					if (true/*!b_prevpara_iscomment*/) {
						std::map<std::string, std::set<long> >::const_iterator map_it = map_file_leadingparas->find (nsrc_filename);
						if (map_it == map_file_leadingparas->end () || map_it->second.find (line_in_nsrc) == map_it->second.end ()) {
							dbproc->addTopicEmptyPara(me);
							endParaEx ();
							paraCount++; cpn++;
						}
					}
					lastSkippedPara = -1;
				}
				bIsSub = 0;
				wordInPara=0;
			}
		}else{
			if (paraBufPos > 65535) {//слишкой большой параграф. Ќиже есть код расширени€ буфера, но второй буфер (дл€ обработанного параграфа) - не растет. Ќо таким большим он все равно быть не может
				paraBufPos = 0;
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "—лишком длинный параграф. ѕропущен.\n");
				endPara ();
			} else {
				if (paraStyle == PS_STYLENUM && !paraBufPos)
					b_emptyparawithstyle = true;
				endPara();
				if( me && lastSkippedPara == -1 ) {
					std::map<std::string, std::set<long> >::const_iterator map_it = map_file_leadingparas->find (nsrc_filename);
					if (map_it == map_file_leadingparas->end () || map_it->second.find (line_in_nsrc) == map_it->second.end ()) {
						if (!b_emptyparawithstyle) {
							dbproc->addTopicEmptyPara(me);
							endParaEx ();
							paraCount++;
							cpn++;
						}
					}
					b_prevpara_iscomment = false;
					wordInPara = 0;
					lastSkippedPara = -1;
				}
				if (b_emptyparawithstyle) {
					b_emptyparawithstyle = false;
					paraBufPos = 0;
				}
			}
		}
	} else {
		if (paraBufPos > 65535) //слишкой большой параграф. Ќиже есть код расширени€ буфера, но второй буфер (дл€ обработанного параграфа) - не растет. Ќо таким большим он все равно быть не может
			return;

		if (false/*text_command_check*/) {
			for (int i = 0; i < TEXT_COMMANDS; i++) {
				const char * p = strstr(s, TextCommand[i]);
				if (p && p-s < l) {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, " оманда в тексте параграфа.\n");
					break;
				}
			}
		}
#ifdef	VERSION56
		check_page_break(s, l);
#endif
		switch( paraStyle ){
			case PS_JUSTIFIED:
			case PS_VERSION:
			case PS_CENTERED:
			case PS_RIGHT:
			case PS_STYLED:
#ifdef	VERSION61
			case PS_LEFT:
#endif
			case PS_SIDEBYSIDE:
			case PS_STYLENUM:
				if( paraBufPos + l + 1 > paraBufSz ){
					// reallocate buffer
					paraBufSz = paraBufPos + l + 8192 ;
					unsigned char *tmp = new unsigned char [ paraBufSz ];
					memcpy( tmp, paraBuf, paraBufPos );
					delete []paraBuf;
					paraBuf = tmp;
				}
				if (paraBufPos)
					if (paraBuf [paraBufPos-1] == 29 && (paraStyle == PS_JUSTIFIED || paraStyle == PS_VERSION || paraStyle == PS_CENTERED || paraStyle == PS_RIGHT || paraStyle == PS_LEFT)) {
						;//paraBuf [paraBufPos-1] = 10;
					} else {
						paraBuf[paraBufPos++] = ' ';
					}
				/*if (codeTables[1][2] == Dos2Win_tatar && l) {
					char* new_s = new char [l+1];
					strcpy (new_s, s);
					Recoding (cd_dos, cd_win, new_s);
					memcpy( paraBuf+paraBufPos, new_s, l );
					delete new_s;
				} else*/ {
					memcpy( paraBuf+paraBufPos, s, l );
				}
				paraBufPos +=l;

				if ( paraStyle == PS_SIDEBYSIDE ) {
					int tab_count = 0;
					for (int i = 0; i < l; i++)
						if (s[i] == '|' || s[i] == '\t')
							tab_count++;
					if (tab_count>1)
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќедопустимое количество разделителей в SBS-параграфе.\n");
					if (( s[ l-1 ] != '|' ) && ( s[ l-1 ] != '\t' )) {
						endPara();
						paraStyle = 0;
						break;
					}
				}
				break;
			case PS_PREFORMATTED:
#ifdef	VERSION61
				if ( contents0 ) {
					int begin = 0;
					int end = l-1;
					if ( l > 2 ) {
						while ( s[begin] == ' ' ) begin++;
						while ( s[end] == ' ' && end > 0 ) end--;
						if ( s[begin] == 5 && s[end] == 5 && end-begin > 1) {
							int begin2 = begin+1;
							int end2 = end-1;
							while ( s[begin2] == ' ' ) begin2++;
							while ( s[end2] == ' ' && end2 > 0 ) end2--;
							if ( ( s[begin2] == 4 && s[end2] == 4 ) || ( s[begin2] == 2 && s[end2] == 2 ) || ( begin2 == end && begin == end2 ) || ( s[begin2] == 3 && s[end2] == 3 && ( end2 - begin2 > 2 ) && s[begin2+1] == 4 && s[end2-1] == 4 ) || ( s[begin2] == 3 && s[end2] == 3 && ( end2 - begin2 > 2 ) && s[begin2+1] == 2 && s[end2-1] == 2 )) {
							    //gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_ALT, "%s\n", s );
								lastSkippedPara = cpn;
								break;
							}
						}
					}
				}
#endif
				/*if (codeTables[1][2] == Dos2Win_tatar && l) {
					char* new_s = new char [l+1];
					strcpy (new_s, s);
					Recoding (cd_dos, cd_win, new_s);
					issuePrefPara((const unsigned char *)new_s,l);
					delete new_s;
				} else*/ {
					issuePrefPara((const unsigned char *)s,l);
				}
				bIsSub = 0;
				cpn++;wordInPara=0;
				break;
			/*
			case PS_SIDEBYSIDE:
				issueSBSPara(s,l);
				bIsSub = 0;
				cpn++;wordInPara=0;
				break;
			*/
			default:
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ѕараграф без команды STYLE.\n");
				FString fs(s,l); fs.bDoFree = 1;
				gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",fs.chars());

				endPara();
				
				if( l + 1 > paraBufSz ){
					paraBufSz = paraBufPos + l + 8192 ;
					delete []paraBuf;
					paraBuf = new unsigned char [ paraBufSz ];
				}
				paraStyle = PS_PREFORMATTED;
				struct para_header *ph = (struct para_header *)paraFinalBuf;
				ph->dm8 = 8;
				ph->lm  = 0;
				ph->rm  = 0;
				ph->rlm = 0;
				issuePrefPara((const unsigned char *)s,l);
				bIsSub = 0;
				cpn++;wordInPara=0;
				break;
		}
	}
}

void nsrcParser :: flushSub()
{
#ifdef	BLOCKSINHERIT
	if (lastSub != 0)
		if (classSet[lastSub].length() == 0 && prefixSet.length() != 0)	{
			if (!b_was_doc && !std::binary_search (cinfo->docs_with_class->begin (), cinfo->docs_with_class->end (), me))
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ќтсутствует команда CLASS.\n"); // в %d сабе,lastSub
			prefixSet.clear();
			classSet[lastSub].clear();
			prefixesSet[lastSub].clear();
			return;
		}

	//нова€ проверка на дубли. ѕеренесли сюда, поскольку CLASS может быть указан второй раз, только с другим prefix
	if ( classSet[lastSub].length() && !prefixesSet[lastSub].length() ) {		
		for ( Pix i = classSet[lastSub].first(); i; classSet[lastSub].next(i) ) {
			bool aDupFound = false;

			int theid = classSet[lastSub](i);
			for( short aSubs = 0; aSubs < lastSubsPos - 1 && !aDupFound; aSubs++ ) {
				if ( classSet[lastSubs[ aSubs ]].contains(theid))
					aDupFound = true;

				// проверка: есть ли у верхних классов такие, эквивалент которых совпадает с рассматриваемым
				Pix pi;
				for( pi=classSet[lastSubs[ aSubs ]].first(); pi; classSet[lastSubs[ aSubs ]].next(pi) ) {
					int theid2 = classSet[ lastSubs[ aSubs ]]( pi );
					int neq = ci->clInfo[ theid2 ].nEquals;
					for (int idx1 = 0; idx1 < neq; idx1++) {
						long eqid = ci->clInfo[ theid2 ].equals[ idx1 ];
						if ( theid == eqid )
							aDupFound = true;
					}
				}

				// проверка: не совпадает ли эквивалентный рассматриваемого класса одному из верхних
				int neq = ci->clInfo[ theid ].nEquals;
				for (int idx1 = 0; idx1 < neq; idx1++) {
					long eqid = ci->clInfo[ theid ].equals[ idx1 ];
					if ( classSet[lastSubs[ aSubs ]].contains(eqid))
						aDupFound = true;
				}
			}

			if ( aDupFound ) {
				/*
				gclog.printfC(AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"рѕ„‘ѕ“—јЁ… ”— CLASS: " );
				gclog.printfCP(AdvLogger::CD_ALT, "'%s'", ci->clInfo[theid].className );
				gclog.printfCP(AdvLogger::CD_ALT, " BLOCK: %ld\n", lastSub );
				*/

				//еще убрать этот дубль
				classSet[lastSub].del(theid);
			}
		}
	}

	if( classSet[lastSub].length() )
		for( Pix i = classSet[lastSub].first(); i; classSet[lastSub].next(i) )
			doClass( classSet[lastSub](i), lastSub );

	if ( lastSubsPos ) {
		bool mustInherit = 0;

		longVHSet *pp1;
		CaseStringSplaySet *pp2, *pp3, *pp4;
		long aSub;

		for( short aSubs = 0; aSubs < lastSubsPos - 1; aSubs++ ) {
			// все данные их этих сабов надо занести в текущий
			aSub = lastSubs [aSubs];
			pp1 = &(classSet [aSub]);
			pp2 = typeSet [aSub];
			pp3 = mkbSet [aSub]; 
			pp4 = chapterSet [aSub]; 
			if (!pp1 || pp1->length () || !pp2 || pp2->length () || !pp3 || pp3->length () || !pp4 || pp4->length ()) {
				mustInherit = 1;
				break;
			}
		}

		if (mustInherit) {
			for (short aSubs = 0; aSubs < lastSubsPos - 1; aSubs++) {
				aSub = lastSubs [aSubs];
				pp3 = mkbSet [aSub]; 
				pp4 = chapterSet [aSub];
				if (!pp3 || pp3->length () || !pp4 || pp4->length ()) {
					for (short asubs = aSubs + 1; asubs < lastSubsPos; asubs++) {
						long savedSub = lastSub;
						lastSub = lastSubs [asubs] | INHERITED_BLOCK;

						CaseStringSplaySet*	amkbs = mkbSet [aSub];
						if (amkbs && amkbs->length()) {
							for (Pix i = amkbs->first(); i; amkbs->next(i)) {
								FString *amkb = &((*cinfo->topicInpharmMkbs)[(*amkbs)(i)]);
								dbproc->addTopicMkb (amkb->chars(),amkb->length()+1, me, lastSub );
							}
						}

						CaseStringSplaySet*	achapters = chapterSet [aSub];
						if (achapters && achapters->length ()) {
							for (Pix i = achapters->first (); i; achapters->next (i)) {
								FString *achapter = &((*cinfo->topicInpharmChapters)[(*achapters)(i)]);
								dbproc->addTopicChapter (achapter->chars(),achapter->length()+1, me, lastSub);
							}
						}

						//subsTmp[subIdx].Para = subsTmp[subIdx-1].Para;
						//subsTmp[subIdx].Sub  = lastSub;
						//subIdx++;

						lastSub = savedSub;
					}
					break;
				}
			}
		}

		if (mustInherit) { 
			pp1 = &(classSet[lastSub]);
			pp2 = typeSet [lastSub];

			if ( (pp1 && pp1->length()) || (pp2 && pp2->length())) {
				long savedSub = lastSub;

				lastSub = lastSub | INHERITED_BLOCK;

				for( short aSubs = 0; aSubs < lastSubsPos - 1; aSubs++ ) {
					// все данные их этих сабов надо занести в текущий

					long aSub = lastSubs[ aSubs ];
					if( classSet[aSub].length() ) {
						for( Pix i = classSet[aSub].first(); i; classSet[aSub].next(i) ) {
							long	classid = classSet[aSub](i);
							bool	found = false;

							if ( classSet[savedSub].length() && prefixesSet[savedSub].length() ) {
								if ( classSet[savedSub].contains( classid ))
									found = true;

								if ( !found ) {
									//эквивалентный classуid не содержитс€ в текущих
									int neq = ci->clInfo[ classid ].nEquals;
									for (int idx1 = 0; idx1 < neq && !found; idx1++) {
										long eqid = ci->clInfo[ classid ].equals[ idx1 ];
										if ( classSet[savedSub].contains( classid ))
											found = true;
									}
								}

								if ( !found ) {
									//не совпадает ли classid с эквивалентным к классам savedSubа
									for ( Pix ii = classSet[savedSub].first(); ii && !found; classSet[savedSub].next(ii) ) {
										long theid = classSet[savedSub]( ii );
										int neq = ci->clInfo[ theid ].nEquals;
										for (int idx1 = 0; idx1 < neq && !found; idx1++) {
											long eqid = ci->clInfo[ theid ].equals[ idx1 ];
											if ( eqid == classid )
												found = true;
										}
									}								
								}
							}

							if ( !found ) doClass( classid, aSub );
						}
					}

					CaseStringSplaySet*	atypes = typeSet[ aSub ];
					if ( atypes && atypes->length() ) {
						for( Pix i = atypes->first(); i; atypes->next(i) ) {
							FString *atype = &((*cinfo->topicTypes)[(*atypes)(i)]);
							dbproc->addTopicType(atype->chars(),atype->length()+1, me, lastSub );
						}
					}
				}

				//subsTmp[subIdx].Para = subsTmp[subIdx-1].Para;
				//subsTmp[subIdx].Sub  = lastSub;
				//subIdx++;

				lastSub = savedSub;
			}
		}
	}
#else
	if (lastSub != 0 && classSet.length () == 0 && prefixSet.length () != 0) {
		if (!b_was_doc && (cinfo->docs_with_class->find (me) == cinfo->docs_with_class->end ()))
			gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ќтсутствует команда CLASS.\n"); //в %d сабе,lastSub
		prefixSet.clear();
		classSet.clear();
		return;
	}

	if (classSet.length ())
		for (Pix i = classSet.first (); i; classSet.next (i))
			doClass (classSet (i));
	classSet.clear();
#endif

	prefixSet.clear();
}

void nsrcParser :: doBlockEnd( const char *s, int l )
{
#ifdef	BLOCKSINHERIT
	if ( lastFlushedSub != lastSub ) {
		lastFlushedSub = lastSub;

		if ( lastSubsPos && lastSubs[ lastSubsPos - 1 ] != lastSub ) {
			lastSubs[ lastSubsPos ] = lastSub;
			lastSubsPos++;
			flushSub();
			lastSubsPos--;
		}else {
			flushSub();
		}

	}
#endif

	while( l && (*s == ' ' || *s=='\t' ) ) {
	  s++; l--;
	}

	int aLastSub = 0;
	if ( lastSubsPos )
		aLastSub = lastSubs[ lastSubsPos-1 ];

	int new_sub;
	if ( !*s ) {
		if ( !aLastSub ) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќевозможно определить блок дл€ команды !BLOCKEND %s.  оманда игнорируетс€.\n", s );
			return;
		}
		else
			new_sub = -aLastSub;
	} else {
		if( !l ) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќеверный номер дл€ команды !BLOCK/SUB/TERM.  оманда игнорируетс€.\n");
			return;
		}

		if( *s < '0' || *s > '9' ) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќеверный номер дл€ команды !BLOCK/SUB/TERM.  оманда игнорируетс€.\n");
			return;
		}

		int64_t new_sub64 = 0;

		while( l && (*s >= '0' && *s <='9' ) ) {
		  new_sub64*=10;
		  new_sub64+=*s-'0';
		  s++; l--;
		}

		new_sub = (int)new_sub64;
		if ( new_sub != aLastSub ) {
			if ( aLastSub )
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "BLOCKEND %ld. Ќарушена структура блоков, последний открытый блок: %ld.  оманда игнорируетс€.\n", new_sub, aLastSub );
			else
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќевозможно определить блок дл€ команды !BLOCKEND %ld.  оманда игнорируетс€.\n", new_sub );
			return;
		}
		new_sub = -new_sub;

		while( l && (*s == ' ' || *s=='\t' ) ) {
		  s++; l--;
		}
	}

	/*
	subsTmp[subIdx].Sub  = new_sub;
	subsTmp[subIdx].Para = cpn;
	subIdx++;
	*/

	//создать начальный блок
	new_sub = -new_sub;

	if (cell_ids.size ()) {
		long cell_id = cell_ids.top ();
		std::map<long,std::set<long> >::iterator it = blocks_in_cell.find (cell_id);
		if (it != blocks_in_cell.end ())
			it->second.erase (new_sub);
	}


	long begin_para = 0;
	for (int asub = 0; asub < subIdx; asub++)
		if (subsTmp[asub].Sub == new_sub) {
			begin_para = subsTmp[asub].Para;
			break;
		}

	if (begin_para != cpn) {
		//блок непустой
		subsExTmp[subExIdx].Sub  = new_sub;
		subsExTmp[subExIdx].Para = begin_para;
		subsExTmp[subExIdx].Flags= SUBDESCEX_BLOCK;
		subsExTmp[subExIdx].Id   = subdescex_ids.find (new_sub)->second;
		subExIdx++;

		subsExTmp[subExIdx].Sub  = new_sub;
		subsExTmp[subExIdx].Para = cpn;
		subsExTmp[subExIdx].Flags= SUBDESCEX_BLOCKEND;
		subsExTmp[subExIdx].Id   = ++subdescex_id;
		subExIdx++;
	}

	lastSubsPos--;

	u_int64_t block64 = (((u_int64_t) DocId) << 32) + new_sub;
	bool b_nonemptyblock = set_empty_blocks->find (block64) == set_empty_blocks->end ();
	if (b_nonemptyblock) {
		{
			if (block_with_contents.find (new_sub) != block_with_contents.end ()) {
				vector_contents.pop_back ();
				stack_block_with_contents.pop_back ();
				if (stack_block_with_contents.size ()) {
					long block_id = *stack_block_with_contents.rbegin ();
					max_level_in_contents = map_block_level.find (block_id)->second + *vector_contents.rbegin ();
				} else {
					max_level_in_contents = 2;
				}
				/*
				for (std::vector<long>::const_iterator it = vector_contents.begin (); it != vector_contents.end (); it++)
					max_level_in_contents += *it;
				*/
			}
			block_level--;
		}

		level--;
		long saved_subdescexid = *vector_subdescex_ids.rbegin (), saved_subdescexid_leafs = map_subdescexid_allleafparacount.find (saved_subdescexid)->second;
		map_subdescexid_lastpara.insert (std::map<long,long>::value_type (saved_subdescexid, cpn));
		vector_subdescex_ids.pop_back ();
		if (vector_subdescex_ids.size ()) {
			subdescex_id_inprocess = *vector_subdescex_ids.rbegin ();
			std::map<long,long>::iterator map_it = map_subdescexid_lastchildid.find (subdescex_id_inprocess);
			if (map_it == map_subdescexid_lastchildid.end ())
				map_subdescexid_lastchildid.insert (std::map<long,long>::value_type (subdescex_id_inprocess, saved_subdescexid));
			else
				map_it->second = saved_subdescexid;
		} else
			subdescex_id_inprocess = 0;

		/*
		for (std::vector<long>::reverse_iterator it = vector_subdescex_ids.rbegin (); it != vector_subdescex_ids.rend (); it++) {
			long id = *it;
			if (set_block_subdescexids.find (id) != set_block_subdescexids.end ()) {
				//map_subdescexid_allleafparacount.find (id)->second++;
				map_subdescexid_allleafparacount.find (id)->second += saved_subdescexid_leafs;
	#ifdef	_DEBUG
				printf ("doBlockEnd for block %ld, added leafcount for %ld, now: %ld\n", new_sub, id, map_subdescexid_allleafparacount.find (id)->second );
	#endif
			}
		}
		*/
		if (vector_subdescex_ids.size ()) {
			long id = *vector_subdescex_ids.rbegin ();
			if (set_block_subdescexids.find (id) != set_block_subdescexids.end ())
				map_subdescexid_allleafparacount.find (id)->second += saved_subdescexid_leafs;
		}
	}
}

void nsrcParser :: doSub( const char *s, int l, int max, bool b_is_sub)
{
	int wasSpaceAfterID = 0;
	const char*	copys = s;

	while( l && (*s == ' ' || *s=='\t' ) ) {
		s++; l--;
	}
	
	if( !l ) {
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќеверный номер дл€ команды !BLOCK/SUB/TERM.  оманда игнорируетс€.\n");
		return;
	}

	if( *s < '0' || *s > '9' ) {
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќеверный номер дл€ команды !BLOCK/SUB/TERM.  оманда игнорируетс€.\n");
		return;
	}

	int64_t new_sub64 = 0;

	while( l && (*s >= '0' && *s <='9' ) ) {
		new_sub64*=10;
		new_sub64+=*s-'0';
		s++; l--;
	}
	
	if ((new_sub64 < 0) || (new_sub64 > max)) {
		char* asub = strdup(copys);
		asub[s-copys]=0;
		gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_WIN,"Ќеверный номер %s дл€ команды !BLOCK/SUB/TERM.  оманда игнорируетс€.\n", asub );
		free(asub);
		return;
	}

	int new_sub = (int)new_sub64;
	if (processed_subsblocks.find (new_sub) != processed_subsblocks.end ())
		return;
	processed_subsblocks.insert (new_sub);

	while( l && (*s == ' ' || *s=='\t' ) ) {
		wasSpaceAfterID = 1;
		s++; l--;
	}

#ifdef	BLOCKSINHERIT
	if ( lastFlushedSub != lastSub ) {
		lastFlushedSub = lastSub;

		if ( lastSubsPos && lastSubs[ lastSubsPos - 1 ] != lastSub ) {
			lastSubs[ lastSubsPos ] = lastSub;
			lastSubsPos++;
			flushSub();
			lastSubsPos--;
		}else {
			flushSub();
		}

	}
#else
	flushSub();
#endif

	lastSub = new_sub;
	if (!b_is_sub) {
		if (cell_ids.size ()) {
			long cell_id = cell_ids.top ();
			std::map<long,std::set<long> >::iterator it = blocks_in_cell.find (cell_id);
			if (it == blocks_in_cell.end ()) {
				std::set<long> blocks;
				blocks.insert (lastSub);
				blocks_in_cell.insert (std::map<long,std::set<long> >::value_type (cell_id, blocks));
			} else {
				it->second.insert (lastSub);
			}
		}
		lastSubs[lastSubsPos++] = lastSub;
	}
	bIsSub = 1;

	if( subIdx < maxSubs ) {
#ifdef	BLOCKSINHERIT
		if(lastSub){
			typeSet[lastSub] = new CaseStringSplaySet;
			mkbSet [lastSub] = new CaseStringSplaySet;
			chapterSet [lastSub] = new CaseStringSplaySet;
		}
#endif
		subsTmp[subIdx].Sub = lastSub;
		subsTmp[subIdx].Para = cpn;
		subIdx++;

		if (b_is_sub) {
			processed_subs.insert (lastSub);
			subsExTmp[subExIdx].Sub  = lastSub;
			subsExTmp[subExIdx].Para = cpn;
			subsExTmp[subExIdx].Flags= SUBDESCEX_SUB;
			subsExTmp[subExIdx].Id   = ++subdescex_id;
			subExIdx++;
		} else {
			subdescex_ids.insert (std::map<long,long>::value_type (lastSub, ++subdescex_id));
		}
	} else {
		gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_KOI, "”ћ…џЋѕЌ Ќќѕ«ѕ ЋѕЌЅќƒ SUB.\n");
	}

	if( l ) {
		// seems like named SUB
		if( !wasSpaceAfterID ) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈‘ –’”‘ѕ«ѕ Ќ≈”‘Ѕ –≈“≈ƒ …Ќ≈ќ≈Ќ SUB'Ѕ\n");
		}

		int off = l-1;
		while( off && (s[off] == ' ' || s[off]=='\t') )  off --;
		if( off+1 ) {
			if (off+2 > SUB_NAME_SIZE) {
				blocks_woname.insert (lastSub);
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "—лишком длинное им€ дл€ комманды SUB\n");
				off=SUB_NAME_SIZE-2;
			}

			//FString t( s, off+1 );//t.bDoFree= 1;
			char tmp= s[off+1];
			((char*)s)[off+1]= 0;
			dbproc->setRefName(me, s, off+2, lastSub );
			((char*)s)[off+1]= tmp;
			bwasNamedTerm |= lastSub < 6;

			//а есть ли у блоков выше имена?
			for( short aSubs = 0; aSubs < lastSubsPos; aSubs++) {
				long check_block = lastSubs[ aSubs ];
				if (blocks_woname.find (check_block) != blocks_woname.end ()) {
					blocks_woname.insert (lastSub);
					break;
				}
			}
		}
	} else {
		if (Info.Status_ex & DS_MEDTOPIC) {
			gclog.printfC(errors, AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, "” MEDTOPICов блоки должны иметь им€\n");
		}
		if (sub_title_check)
			gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "о≈‘ …Ќ≈ќ…’ SUB'Ѕ\n");
		blocks_woname.insert (lastSub);
	}

	if (!b_is_sub) {
		//это блок
		u_int64_t block64 = (((u_int64_t) DocId) << 32) + lastSub;
		bool b_nonemptyblock = set_empty_blocks->find (block64) == set_empty_blocks->end ();

		if (b_nonemptyblock) {
			if (++block_level <= max_level_in_contents)
				blocks_in_contents.insert (lastSub);

			subdescexids_instruct.push_back (subdescex_id);
			if (map_subdescexid_firstchildid.find (subdescex_id_inprocess) == map_subdescexid_firstchildid.end ())
				map_subdescexid_firstchildid.insert (std::map<long,long>::value_type (subdescex_id_inprocess, subdescex_id));
			level++;
			long level_id = 0;
			std::map<long,long>::iterator map_it = map_level_maxid.find (level);
			if (map_it == map_level_maxid.end ()) {
				map_level_maxid.insert (std::map<long,long>::value_type (level, level_id));
			} else {
				level_id = ++map_it->second;
			}
			map_subdescexid_levelandlevelid.insert (std::map<long,long>::value_type (subdescex_id, (level << 24) + level_id));
			map_subdescexid_allleafparacount.insert(std::map<long,long>::value_type (subdescex_id, 0));
			vector_subdescex_ids.push_back (subdescex_id);
			map_subdescexid_to_id.insert (std::map<long,long>::value_type (subdescex_id, lastSub));
			set_block_subdescexids.insert (subdescex_id);
			subdescex_id_inprocess = subdescex_id;
			map_subdescexid_type.insert (std::map<long,long>::value_type (subdescex_id, SUBDESCEX_BLOCK));
			map_subdescexid_firstpara.insert (std::map<long,long>::value_type (subdescex_id, cpn));
		}
	}
}

#ifdef QSORT_SRC
int nsrcParser :: Quick_mkFrom(const char *s,int l)
{ 
    int off;
	unsigned i;
	char buf[1024];

	if (!cinfo->topicBelongs->contains(DocId)) {
		belongsSet = 0;
		gclog.printfC(errors, AdvLogger::LOG_ERROR,AdvLogger::CD_WIN, "Ќевозможно установить принадлежность топика %d к какому-либо сегменту. “опик игнорируетс€.\n",DocId-100000);
		return 1;
	} else {
		belongsSet = (*cinfo->topicBelongs)[DocId];
	}

	if (cinfo->editions->contains(DocId))
		bIsEdition = 1;
	else
		bIsEdition = 0;

	if (cinfo->notADocs->contains(DocId))
		bIsNoDoc = 1;
	else
		bIsNoDoc = 0;

	ctprio = DEFAULT_TOPIC_PRIORITY;

	off = 0;
	if( l ){
		off = l-1;
		while( off && (s[off] == ' ' || s[off]=='\t') )  off --;
		off++;
		if( off ){
			if ( off >= DOC_SHORT_NAME_SIZE) {
				if (false/*name_len_check*/) gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "оЅЏ„Ѕќ…≈ ƒћ…ќќ≈≈ %d ”…Ќ„ѕћѕ„.\n", DOC_SHORT_NAME_SIZE);
				off = DOC_SHORT_NAME_SIZE-1;
			}
			/*
			if (off > 65) {
				if (name_len_check) gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "оЅЏ„Ѕќ…≈ Ќѕ÷≈‘ ќ≈ –ѕЌ≈”‘…‘Ў”— „ ѕЋќѕ DOS ѕ¬ѕћѕёЋ…\n");
			}
			*/
		}else{
			gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Invariant failure in nsrcParser::mkFrom()\n");
		}
	}
	for( i=0; (int)i<off; i++){
		if( (unsigned)s[i] < 10 ){
			gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "фѕ–…Ћ ќ≈ Ќѕ÷≈‘ ”ѕƒ≈“÷Ѕ‘Ў ”–≈√.”…Ќ„ѕћ (%d).\n", (unsigned)s[i]);
			break;
		}
	}
	isBlob= 0;
	me= dbproc->createTopic(DocId, s, off, &today_rev, packing);
/*#ifdef _DEBUG
		static int fhtmp= -1;
		static char wwww[]= "c:/1st.bin", msg[2048];
		if(fhtmp == -1){
			fhtmp= ace_os_open(wwww, ACE_OS_O_CREAT|ACE_OS_O_TRUNC|ACE_OS_O_RDWR|ACE_OS_O_BINARY
						);
		}
		if(fhtmp != -1){
			sprintf(msg, "\n(%d)[%s]", DocId, s);
			ace_os_write(fhtmp, msg, strlen(msg));
		}
#endif*/
	gk_bzero((caddr_t)&Info, sizeof(Info) );
	gk_bzero(&docRDate, sizeof( docRDate ));
	gk_bzero(&docDate, sizeof( docDate ));
	gk_bzero(&FirstDate, sizeof (FirstDate));
	Info.Revision = today_rev;
	strncpy( Info.Title, s, off );
#if !defined(__CYGWIN32__) && !defined(__GO32__) && !defined(__MSVC__)
	dbproc->addAttribute(me, IDD_SOURCEFILE, buf, snprintf(buf, sizeof(buf), "%s:%d", gclog.flName, gclog.lineno) +1) ;
#else
	dbproc->addAttribute(me, IDD_SOURCEFILE, buf, sprintf(buf, "%s:%d", gclog.flName, gclog.lineno) +1) ;
#endif

	cpn = 0; wordInPara = 0; paraCount = 0;
	bIsSub = 1;
	bIsParaExist = 0;
	subIdx = 0;
	subExIdx = 0;
	lastSub = 0;
	styleh = 0;
	para_styleh_pairs.clear ();
	blocks_in_cell.clear ();
	lastSubsPos = 0;
	table_row_cell_id = 0;
	subdescex_id = subdescex_id_inprocess = level = 0;
	subdescexids_instruct.clear ();
	subdescex_ids.clear ();
	map_level_maxid.clear ();
	map_subdescexid_levelandlevelid.clear ();
	map_subdescexid_type.clear ();
	map_subdescexid_firstpara.clear ();
	map_subdescexid_lastpara.clear ();
	map_subdescexid_firstchildid.clear ();
	map_subdescexid_lastchildid.clear ();
	map_subdescexid_to_id.clear ();
	vector_subdescex_ids.clear ();
	map_subdescexid_allleafparacount.clear ();
	set_block_subdescexids.clear ();
	set_cell_subdescexids.clear ();
	map_tableid_zoom.clear ();
	map_tableid_leftindent.clear ();
	map_tableid_type.clear ();
	
	block_level = max_level_in_contents = 0;
	vector_contents.clear ();
	block_with_contents.clear ();
	blocks_in_contents.clear ();
	blocks_woname.clear ();
	stack_block_with_contents.clear ();
	map_block_level.clear ();
	map_block_style.clear ();
	map_block_location.clear ();

	{
		//начало документа
		subdescexids_instruct.push_back (subdescex_id);
		long level_id = 0;
		map_level_maxid.insert (std::map<long,long>::value_type (level, level_id));
		map_subdescexid_levelandlevelid.insert (std::map<long,long>::value_type (subdescex_id, (level << 24) + level_id));
		map_subdescexid_allleafparacount.insert(std::map<long,long>::value_type (subdescex_id, 0));
		vector_subdescex_ids.push_back (subdescex_id);
		map_subdescexid_to_id.insert (std::map<long,long>::value_type (subdescex_id, 0));
		set_block_subdescexids.insert (subdescex_id);
		map_subdescexid_type.insert (std::map<long,long>::value_type (subdescex_id, SUBDESCEX_DOCUMENT));
		subdescex_ids.insert (std::map<long,long>::value_type (0, 0));
		map_subdescexid_firstpara.insert (std::map<long,long>::value_type (subdescex_id, 0));
	}

	processed_subsblocks.clear ();
	processed_subs.clear ();

	gk_bzero( lastSubs, sizeof( lastSubs ));
	lastFlushedSub = -1;
	bBelongsSet = 0;
	cells_in_row.clear ();
	fatal_table_errors = false;
	
	b_emptyparawithstyle = false;
	bPrioritySet = 0;
	bRelatedSet = 0;
	bVIncludedSet = 0; gk_bzero (&dVIncluded, sizeof (dVIncluded));
	bVAbolishedSet = 0;
	bVAnoncedSet = 0; gk_bzero (&dVAnonced, sizeof (dVAnonced));
	bAnnoSet = 0;
	bwasNamedTerm = 0;
	bwasChDate = false;
	b_show_skip_info = false;
	bVLControlSet = 0;
	bSortDateSet = 0;
	bRevisionSet = 0;
	bRDateSet = 0;
	bRCodeSet = 0;
	bIsPrefixDocuments = 0;
	bIsPrefixInternational = 0;
	bShowActiveToWarning = false;
	b_type_is_letter = false;
	b_prefix_is_sudebnaya = false;
	b_prefix_is_comment = false;
	b_source_is_lowrele = false;
	bPublishedInSet = 0;
	isPriceLevelDefined = 0;
	gprefixSet.clear();
	prefixSet.clear();
	classSet.clear();
	territorySet.clear();
	sourcesSet.clear();
	typesSet->clear();
	kindsSet->clear();
	mkbsSet->clear ();
	chaptersSet->clear ();
	aClassesSet->clear();
#ifdef	BLOCKSINHERIT
	Pix iii;
	for (iii = typeSet.first(); iii; typeSet.next(iii) )
		delete typeSet.contents(iii);
	typeSet.clear();
	typeSet[0] = new CaseStringSplaySet;

	for (iii = mkbSet.first(); iii; mkbSet.next(iii) )
		delete mkbSet.contents(iii);
	mkbSet.clear();
	mkbSet[0] = new CaseStringSplaySet;

	for (iii = chapterSet.first(); iii; chapterSet.next(iii) )
		delete chapterSet.contents(iii);
	chapterSet.clear();
	chapterSet[0] = new CaseStringSplaySet;

	prefixesSet.clear();
#endif
	srcsSet->clear();
	markedDocs->clear();
	docClasses -> clear();
	docPrefixes -> clear();
	dsVchanged.clear();
#ifdef VERSION56
	for (Activity::iterator i=dsActivity.begin(); i!=dsActivity.end(); i++) {
		if (i->text) delete i->text;
	}
	dsActivity.clear();
	dsPage.clear();
	dsChDate.clear();
	dsChDateEx.clear();
	dsContents.clear();
	dsCompareContents.clear ();
	dsNotSure.clear();
	dsDivision.clear();
#endif
	sLongNameSz = 0;
	paraStyle = 0;
	norm = tradename = intname = 0;

	thatsUserInfoTopic = 0;
	thatsAccountTopic = 0;
	thatsAltMenu = 0;
	thatsBusinessTopic = 0;
	thatsSplashTopic = 0;
	thatsBannerTopic = 0;

	wasRcode = 0;
	wasWarning = 0;
	wasVerlink = 0;
	bIsm = false;
	wascontents0 = false;
	b_prevpara_iscomment = false;
	b_was_doc = false;
	b_was_kind = false;
#ifdef WITH_DBL_THREAD
	if (!bIsNoDoc)
		Info.Status |= DS_DOC;
#endif
	Info.Status_ex = 0;
	return 0;
}
#endif

int nsrcParser :: mkFrom (const char *s,int l, int bBlob)
{
	std::map<long,short*>::const_iterator map_it;
    int off;
	char buf[1024];
	unsigned i;
	int wasSpaceAfterID = 0;

	if( me ){
		gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI, "рѕ–ў‘ЋЅ ”ѕЏƒЅ‘Ў ’÷≈ ”’Ё≈”‘„’јЁ…  ‘ѕ–…Ћ\n");
		return 1;
	}
	while( l && (*s == ' ' || *s=='\t' ) ){
	  s++; l--;
	}

	int64_t DocId64 = 0;

	if( !l ) goto getout_err;				
	if( *s < '0' || *s > '9' ) goto getout_err;

	while( l && (*s >= '0' && *s <='9' ) ){
	  DocId64*=10;
	  DocId64+=*s-'0';
	  s++; l--;
	}
#ifdef	VERSION62
	if ( annoPhase )
		DocId64 += ID_ANNOPLUS;
#endif
	if ((DocId64 <= 0) || (DocId64 > LONG_MAX-REAL_DOC_OFFS)) goto getout_err;

	DocId=(long)DocId64+REAL_DOC_OFFS;
	typesSet->clear();
	kindsSet->clear();
	mkbsSet->clear ();
	chaptersSet->clear ();
#ifdef	BLOCKSINHERIT
	{
		for ( Pix iii = typeSet.first(); iii; typeSet.next(iii) )
			delete typeSet.contents(iii);
		typeSet.clear();
		typeSet[0] = new CaseStringSplaySet;
	}

	{
		for ( Pix iii = mkbSet.first(); iii; mkbSet.next(iii) )
			delete mkbSet.contents(iii);
		mkbSet.clear();
		mkbSet[0] = new CaseStringSplaySet;
	}

	{
		for ( Pix iii = chapterSet.first(); iii; chapterSet.next(iii) )
			delete chapterSet.contents(iii);
		chapterSet.clear();
		chapterSet[0] = new CaseStringSplaySet;
	}
#endif
	gclog.setTopic((long)DocId64);

	belongsSet.clear ();
	map_it = cinfo->topicBelongs->find (DocId);
	if (map_it == cinfo->topicBelongs->end ()) {
		gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_WIN, "Ќевозможно установить принадлежность топика %d к какому-либо сегменту. “опик игнорируетс€.\n",DocId-100000);
		return 1;
	} else {
		short *ptr = map_it->second, count = *ptr++;
		for (short seg_it = 0; seg_it < count; seg_it++, ptr++)
			belongsSet.add (*ptr);
	}

	if (cinfo->editions && std::binary_search (cinfo->editions->begin (), cinfo->editions->end (), DocId))
		bIsEdition = 1;
	else
		bIsEdition = 0;

	if (cinfo->notADocs->contains(DocId))
		bIsNoDoc = 1;
	else
		bIsNoDoc = 0;

	ctprio = DEFAULT_TOPIC_PRIORITY;

	while( l && (*s == ' ' || *s=='\t' ) ){
	  wasSpaceAfterID = 1;
	  s++; l--;
	}
	off = 0;
	if( l ){
		// seems like named TOPIC
		if( !wasSpaceAfterID ){
			gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI, "о≈‘ –’”‘ѕ«ѕ Ќ≈”‘Ѕ –≈“≈ƒ …Ќ≈ќ≈Ќ TOPIC'Ѕ\n");
		}
		off = l-1;
		while( off && (s[off] == ' ' || s[off]=='\t') )  off --;
		off++;
		if( off ){
			if ( off >= (bBlob ? NAME_SIZE : DOC_SHORT_NAME_SIZE)) {
				if (false/*name_len_check*/) gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "оЅЏ„Ѕќ…≈ ƒћ…ќќ≈≈ %d ”…Ќ„ѕћѕ„.\n", bBlob ? NAME_SIZE : DOC_SHORT_NAME_SIZE);
				off = (bBlob ? NAME_SIZE : DOC_SHORT_NAME_SIZE)-1;
			}
		}else{
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Invariant failure in nsrcParser::mkFrom()\n");
		}
	}
	for( i=0; (int)i<off; i++){
		if( (unsigned)s[i] < 10 ){
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "фѕ–…Ћ ќ≈ Ќѕ÷≈‘ ”ѕƒ≈“÷Ѕ‘Ў ”–≈√.”…Ќ„ѕћ (%d).\n", (unsigned)s[i]);
			break;
		}
	}

	isBlob = bBlob;
	if( !isBlob ) {
		if (bad_docs->find (DocId) == bad_docs->end ()) {
			me= dbproc->createTopic(DocId, s, off,
#ifdef PTRS_IN_META
									(const revision*)(&exportBuf)
#else
									&today_rev
#endif
									, packing);
			baddoc_andskip = false;
		} else {
			me = 0;
			baddoc_andskip = true;
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "“опик %d пропускаетс€ из-за ошибок (с редакци€ми, или flashtopic без swf).\n", DocId - ID_BORDER);
		}
#ifdef PTRS_IN_META
		paraFinalBuf= exportBuf + 3;
#endif
		lastSkippedPara = -1;
		contents0 = false;
		wascontents0 = false;
		b_prevpara_iscomment = false;
		b_was_doc = false;
		b_was_kind = false;
		bObjectOk = 1;
		wasObjPath = 0;
		gk_bzero((caddr_t)&Info, sizeof(Info) );

		gk_bzero(&docDate, sizeof( docDate ));
		gk_bzero(&docRDate, sizeof( docRDate ));
		gk_bzero(&FirstDate, sizeof( FirstDate ));
		Info.Revision = today_rev;
		strncpy( Info.Title, s, off );
#if !defined(__CYGWIN32__) && !defined(__GO32__) && !defined(__MSVC__)
		dbproc->addAttribute(me, IDD_SOURCEFILE, buf, snprintf(buf, sizeof(buf), "%s:%d", gclog.flName, gclog.lineno) +1) ;
#else
		dbproc->addAttribute(me, IDD_SOURCEFILE, buf, sprintf(buf, "%s:%d (topic:%d)", gclog.flName, gclog.lineno, DocId64) +1) ;
#endif
	
		cpn = 0; wordInPara = 0; paraCount = 0;
		bIsSub = 1;
		bIsParaExist = 0;
		subIdx = 0;
		subExIdx = 0;
		lastSub = 0;
		styleh = 0;
		para_styleh_pairs.clear ();
		blocks_in_cell.clear ();
		while (cell_ids.size ()) {
			cell_ids.pop ();
			errors.push_back ("¬ документе есть !CELL без !CELLEND");
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "¬ документе есть !CELL без !CELLEND\n");
		}
		while (row_ids.size ()) {
			errors.push_back ("¬ документе есть !ROW без !ROWEND");
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "¬ документе есть !ROW без !ROWEND\n");
			row_ids.pop ();
		}
		while (table_ids.size ()) {
			errors.push_back ("¬ документе есть !TABLE без !TABLEEND");
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "¬ документе есть !TABLE без !TABLEEND\n");
			table_ids.pop ();
		}
		lastSubsPos = 0;
		table_row_cell_id = 0;
		subdescex_id = subdescex_id_inprocess = level = 0;
		subdescexids_instruct.clear ();
		map_level_maxid.clear ();
		map_subdescexid_levelandlevelid.clear ();
		map_subdescexid_type.clear ();
		map_subdescexid_firstpara.clear ();
		map_subdescexid_lastpara.clear ();
		map_subdescexid_firstchildid.clear ();
		map_subdescexid_lastchildid.clear ();
		map_subdescexid_to_id.clear ();
		vector_subdescex_ids.clear ();
		map_subdescexid_allleafparacount.clear ();
		set_block_subdescexids.clear ();
		set_cell_subdescexids.clear ();
		subdescex_ids.clear ();	
		processed_subsblocks.clear ();
		processed_subs.clear ();
		map_tableid_zoom.clear ();
		map_tableid_leftindent.clear ();
		map_tableid_type.clear ();

		block_level = max_level_in_contents = 0;
		vector_contents.clear ();
		block_with_contents.clear ();
		blocks_in_contents.clear ();
		blocks_woname.clear ();
		stack_block_with_contents.clear ();
		map_block_level.clear ();
		map_block_style.clear ();
		map_block_location.clear ();

		{
		//начало документа
		subdescexids_instruct.push_back (subdescex_id);
		long level_id = 0;
		map_level_maxid.insert (std::map<long,long>::value_type (level, level_id));
		map_subdescexid_levelandlevelid.insert (std::map<long,long>::value_type (subdescex_id, (level << 24) + level_id));
		map_subdescexid_allleafparacount.insert(std::map<long,long>::value_type (subdescex_id, 0));
		vector_subdescex_ids.push_back (subdescex_id);
		map_subdescexid_to_id.insert (std::map<long,long>::value_type (subdescex_id, 0));
		set_block_subdescexids.insert (subdescex_id);
		map_subdescexid_type.insert (std::map<long,long>::value_type (subdescex_id, SUBDESCEX_DOCUMENT));
		subdescex_ids.insert (std::map<long,long>::value_type (0, 0));
		map_subdescexid_firstpara.insert (std::map<long,long>::value_type (subdescex_id, 0));
		}

		gk_bzero( lastSubs, sizeof( lastSubs ));
		lastFlushedSub = -1;
		bBelongsSet = 0;
		bPrioritySet = 0;
		bRelatedSet = 0;
		bVIncludedSet = 0; gk_bzero (&dVIncluded, sizeof (dVIncluded));
		bVAbolishedSet = 0;
		bVAnoncedSet = 0; gk_bzero (&dVAnonced, sizeof (dVAnonced));
		bAnnoSet = 0;
		bwasNamedTerm = 0;
		bwasChDate = false;
		b_show_skip_info = false;
		cells_in_row.clear ();
		fatal_table_errors = false;
		bVLControlSet = 0;
		bSortDateSet = 0;
		bRevisionSet = 0;
		bRDateSet = 0;
		bRCodeSet = 0;
		bIsPrefixDocuments = 0;
		bIsPrefixInternational = 0;
		bShowActiveToWarning = false;
		bPublishedInSet = 0;
		isPriceLevelDefined = 0;
		gprefixSet.clear();
		prefixSet.clear();
		classSet.clear();
		territorySet.clear();
		sourcesSet.clear();
		serviceInfoSet->clear();
		annoUserSet->clear();
		annoOrganizationSet->clear();
		annoTaxSet->clear();
		annoInterestSet->clear();
		annoKindSet->clear();
#ifdef	BLOCKSINHERIT
		prefixesSet.clear();
#endif
		srcsSet->clear();
		markedDocs->clear();
		docClasses -> clear();
		docPrefixes -> clear();
		dsVchanged.clear();
#ifdef VERSION56
		for (Activity::iterator i=dsActivity.begin(); i!=dsActivity.end(); i++)
			if (i->text)
				delete i->text;
		dsActivity.clear();
		dsChDate.clear();
		dsChDateEx.clear();
		dsPage.clear();
		dsContents.clear();
		dsCompareContents.clear();
		dsNotSure.clear();
		dsDivisions.clear();
#endif
		sLongNameSz = 0;
		paraStyle = 0;
		norm = tradename = intname = 0;

		thatsSplashTopic = 0;
		thatsBannerTopic = 0;

		wasRcode = 0;
		wasWarning = 0;
		wasVerlink = 0;
		bIsm = false;
		b_emptyparawithstyle = false;

		wasObjPath = 0;
		gk_bzero((caddr_t)&objInfo, sizeof(objInfo) );
	}else{
		baddoc_andskip = false;
		me = DocId;
		sLongNameSz = 0;
		bBelongsSet = 0;
		isPriceLevelDefined = 0;
		gk_bzero((caddr_t)&objInfo, sizeof(objInfo) );
		strncpy( objInfo.name, s, off );
		objType = 0;
		bIsSub = 1;
		bObjectOk = 1;
		wasObjPath = 0;
		bIsParaExist = 0;
	}
#ifdef WITH_DBL_THREAD
	if (!bIsNoDoc && !std::binary_search (cinfo->editions->begin (), cinfo->editions->end (), me))
		Info.Status |= DS_DOC;
#endif
	Info.Status_ex = 0;
	SetDocStatusExEx (&Info, 0);
	return 0;
getout_err:
	gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"о≈„≈“ќў  ∆ѕ“ЌЅ‘ ЋѕЌЅќƒў !TOPIC („ѕЏЌѕ÷ќѕ ¬ѕћЎџѕ  ќѕЌ≈“).\n");
	return 1;
}

void nsrcParser::append2LName(const char *s, size_t l)
{
	if( !l ){
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "р’”‘Ѕ— ЋѕЌЅќƒЅ !NAME\n"); 
		return;
	}
	if( sLongNameSz ) {
		if( sLongNameSz + 1 + l  > sizeof(sLongName) ){
			gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI, "т≈Џ’ћЎ‘…“’јЁ≈≈ …Ќ— ”ћ…џЋѕЌ ƒћ…ќќѕ≈\n");
			return ;
		}
		sLongName[sLongNameSz++]=' ';
	}else{
		if( l > sizeof(sLongName) ){
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "йЌ— ”ћ…џЋѕЌ ƒћ…ќќѕ≈\n");
			return;
		}
	}
	char *dst = sLongName + sLongNameSz;
	int bWasSpace = 1;
	unsigned int c = 0;
	int rl = 0;
	for( int i=0; (unsigned)i<l; i++ ){
		c = *s++;
		if( bWasSpace ){
			if( c==' ' ) continue;
			*dst++ = c;
			rl ++;
			bWasSpace = 0;
		}else{
			if( c == ' ') bWasSpace = 1;
			*dst++ = c;
			rl++;
		}

	}
	if( rl )
	{
		sLongNameSz += rl;
		if( sLongName[ sLongNameSz-1 ] == ' ' ) sLongNameSz --;
	}
	else
	{
		gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,
					  "л …Ќ≈ќ… ќ≈ё≈«ѕ ќ≈ ƒѕ¬Ѕ„…ћѕ”Ў.\n");
	}
	if (sLongNameSz > DOC_NAME_SIZE - 1)
	{
		gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,
			"–азмер длинного имени документа превышает %ld символов\n",DOC_NAME_SIZE-1);
		sLongNameSz = DOC_NAME_SIZE - 10;
	}
}

void nsrcParser :: issueSBSPara(const char *s, int l)
{
	char *sep = (char *)memchr(s, '|', l);
	if (sep) {
		*sep = '\t';
	}

	sep = (char *)memchr(s, '\t', l );
	if( sep ) {
		size_t len=0;
		makeParaData((unsigned char *)paraFinalBuf+sizeof(struct para_header),
					 (const unsigned char *)s, sep-s ,len );
		paraFinalBuf[sizeof(struct para_header)+len]= '\t';
		len ++;
		size_t len2 =0;
		makeParaData((unsigned char *)paraFinalBuf+sizeof(struct para_header)+len,
					 (const unsigned char*)sep+1,l-(sep-s) -1 ,len2 );
		dbproc->addTopicPara(me,PS_SIDEBYSIDE, paraFinalBuf,sizeof(struct para_header)+len+len2);
		paraCount++;
#ifdef	VERSION61
		lastSkippedPara = -1;		
#endif
	} else {
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈‘ “ЅЏƒ≈ћ…‘≈ћ— „ side-by-side –Ѕ“Ѕ«“Ѕ∆≈.\n");
	}
}

void	nsrcParser :: endParaEx ()
{
	if (set_cell_subdescexids.find (subdescex_id_inprocess) != set_cell_subdescexids.end ()) {
/*
#ifdef	_DEBUG
		printf ("endParaEx for cell, added leafcount for %ld\n", subdescex_id_inprocess);
#endif
*/
		map_subdescexid_allleafparacount.find (subdescex_id_inprocess)->second++;
	} else
	if (set_block_subdescexids.find (subdescex_id_inprocess) != set_block_subdescexids.end ()) {
		//мы в блоке
		map_subdescexid_allleafparacount.find (subdescex_id_inprocess)->second++;
/*
#ifdef	_DEBUG
		printf ("endParaEx for block, added leafcount for %ld, now: %ld\n", subdescex_id_inprocess, map_subdescexid_allleafparacount.find (subdescex_id_inprocess)->second);
#endif
*/
	}
}

void	nsrcParser :: endPara()
{
	if( !me || isBlob ) return ;

	bool b_ispicturepara = false;
	char* picture_paratext = 0;
	long picture_para_len = 0;

	switch( paraStyle ){
		case PS_CENTERED:
		case PS_JUSTIFIED:
		case PS_VERSION:
		case PS_RIGHT:
#ifdef	VERSION61
		case PS_LEFT:
#endif
		case PS_STYLENUM:
		case PS_SIDEBYSIDE:
		case PS_STYLED:
			size_t l;
			if( paraBufPos || b_emptyparawithstyle) {
				makeParaData(paraFinalBuf+5,paraBuf,paraBufPos,l);
				//gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "!: %s\n!: %ld\n", (char*)paraFinalBuf + sizeof(struct para_header), l);
				*(paraFinalBuf+sizeof(struct para_header)+l) = 0;
				if ((paraStyle == PS_JUSTIFIED || paraStyle == PS_VERSION) && l && *(paraFinalBuf+sizeof(struct para_header)) == 5 && *(paraFinalBuf+1+sizeof(struct para_header)) == 3)
					b_prevpara_iscomment = true;
				else
					b_prevpara_iscomment = false;
				if( l+sizeof(struct para_header) < MAX_PARA_LEN - sizeof ( BlockHeader ) - 512 ) {
					endParaEx ();
					if (styleh) {
						dbproc->addTopicParaHeights (me, (char*) &cpn, sizeof (long));
						dbproc->addTopicParaHeights (me, (char*) &styleh, sizeof (long));
						para_styleh_pairs.push_back (cpn);
						para_styleh_pairs.push_back (styleh);
					}
					const char* pic_signature_255 = "\x5\x3Сђ. \x4£а†д®з•б™®©\xFFЃ°к•™в\x4\x3";
					if (!memcmp (paraFinalBuf+sizeof(struct para_header), pic_signature_255, strlen (pic_signature_255)))
						*(paraFinalBuf+sizeof(struct para_header)+18) = 32;
					const char* pic_signature = "\x5\x3Сђ. \x4£а†д®з•б™®© Ѓ°к•™в\x4\x3";
					b_ispicturepara = !memcmp (paraFinalBuf+sizeof(struct para_header), pic_signature, strlen (pic_signature));
					if (b_ispicturepara && l > 39) {
						//заменить им€ картинки на пробелы, http://mdp.garant.ru/pages/viewpage.action?pageId=274466758
						char* from = (char*) paraFinalBuf + 43;
						char* to = (char*) paraFinalBuf + sizeof(struct para_header) + l - 2;
						for (char* chars = from; chars < to; chars++)
							*chars = ' ';

						//из paraBuf надо скопировать оставшийс€ "текст"
						from = (char*) paraBuf;
						for (long i = 0; (i < 3) && (from - (char*)paraBuf < paraBufPos); from++)
							if (*from == 4)
								i++;
						while (*from == ' ') from++;
						to = (char*) paraBuf + paraBufPos - 2;
						picture_para_len = to - from;
						if (picture_para_len) {
							picture_paratext = new char [picture_para_len];
							memcpy (picture_paratext, from, picture_para_len);
						}
					}
					if (!b_ispicturepara) {
						const char* strstr_pos = strstr ((char*)paraFinalBuf + sizeof(struct para_header), (char*)pic_signature);
						if (strstr_pos && (strstr_pos - (char*)paraFinalBuf < l + sizeof(struct para_header))) {
							gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќеверное оформление встроенной картинки\n");
						}
					}
					dbproc->addTopicPara(me,paraStyle,paraFinalBuf,l+sizeof(struct para_header) );
					paraCount++;
#ifdef	VERSION61
					lastSkippedPara = -1;
#endif
				} else {
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "ућ…џЋѕЌ ƒћ…ќќў  –Ѕ“Ѕ«“Ѕ∆. р“ѕ–’Ё≈ќ.\n");
					cpn--;
				}
				cpn++; wordInPara = 0;
			}
			bIsSub = 0;
			paraStyle = 0;

			if (b_ispicturepara && l > 39) {
				if (picture_paratext) {
					const char* ss = "!STYLE J 1 72 1";
					CMD_CALL (STYLE, mkNewPara, ss, 15);
					strncpy ( (char*)paraBuf, picture_paratext, picture_para_len);
					paraBufPos = picture_para_len; //strlen ((char*)paraBuf);
					endPara(); endParaEx ();
				}
			}

			if (picture_paratext)
				delete []picture_paratext;

			break;
		case PS_PREFORMATTED:
			break;
		case 0:
			break;
		default:
			paraStyle = 0;
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈…Џ„≈”‘ќў  ”‘…ћЎ –Ѕ“Ѕ«“Ѕ∆Ѕ.\n");
	}
}

void nsrcParser::addRespCorr(unsigned t, Ref2Int64 &rf )
{
	if (((rf.asref.docid < 0) || (rf.asref.docid > MAX_DOC_NUMBER)) || ((rf.asref.sub < 0) || (rf.asref.sub > MAX_SUB_NUMBER))) return;

	if (!cinfo->notADocs->contains(DocId) && !cinfo->notADocs->contains(me) && (unsigned)DocId!=t) {
#ifdef OLD_MAP
		u_int64_tSplaySet *rs = (u_int64_tSplaySet*)(*(cinfo->resps))[DocId];
		if( !rs ){
			rs = new u_int64_tSplaySet();
			(*(cinfo->resps))[DocId] = (caddr_t) rs;
		}
#else
		GRefMap *rs = &((*cinfo->resps)[DocId]);
#endif
		rs->add( rf.asint );

		if (!markedDocs->contains(t)) {
#ifdef OLD_MAP
			u_int64_tSplaySet *st = (u_int64_tSplaySet*)(*(cinfo->corrs))[t];
			if( !st ) {
				st = new u_int64_tSplaySet();
				(*(cinfo->corrs))[t] = (caddr_t) st;
			}
#else
			GRefMap *st = &((*cinfo->corrs)[t]);
#endif
			rf.asref.docid = DocId;
			rf.asref.sub = cpn;
			st->add( rf.asint );
			markedDocs->add(t);
		}
	}
}

int nsrcParser::checkParaRef(const unsigned char *s, int l)
{
	const unsigned char * nxt = s+l;
	if ((*s >= '0') && (*s <= '9')) {
		unsigned char * eptr = (unsigned char *) s;
		int ncount = 0;
		while( eptr < nxt ) {
			unsigned long t = strtoul((char*)eptr,(char**)&eptr,10);
			if ( !t || t == ULONG_MAX ) {
				gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"о≈–“Ѕ„…ћЎќў  ∆ѕ“ЌЅ‘ ””ўћЋ…: ");
				FString fs((const char*) s,l); fs.bDoFree = 1;
				gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",fs.chars());
				return 0;
			}
			t += REAL_DOC_OFFS;
			if ( !blobs->contains(t ) ) {
				if(*eptr==' '||*eptr=='\t'||*eptr=='\04') {
				} else if( *eptr == '.' ) {
					eptr++;
					if (*eptr != '0') {
						unsigned long tt=strtoul((char*)eptr,(char**)&eptr,10);
						if( !tt || tt == ULONG_MAX ) {
							gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"о≈–“Ѕ„…ћЎќў  ∆ѕ“ЌЅ‘ ””ўћЋ…: ");
							FString fs((const char*) s,l); fs.bDoFree = 1;
							gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",fs.chars());
							return 0;
						}
					} else
						eptr++;
				}
			}
			ncount++;
			while((eptr < nxt)&&(*eptr==' '||*eptr=='\t'))
				eptr++;
			if( !ncount ) {
				gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"р’”‘Ѕ— ””ўћЋЅ.\n");
				return 0;
			}
		}
		return 1;
	}
	else if ((*s >= 'a') && (*s <= 'z')) {
		if (!memcmp(s, "division:", 9)) {
			FString rawClass((const char*)(s+9), nxt-s-9);
			rawClass.bDoFree = 0;
			FString *trClass = ci->pTranslate(rawClass, ClassesInfo::TRANSCLASS);
			if (!trClass) {
				gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_ALT,"Н•®ІҐ•бв≠л© ™Ђ†бб '%s'", rawClass.chars());
				return 0;
			}
		} else {
			FString tt((char*)s, l); tt.bDoFree = 1;
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT,"Н•Ґ•а≠л© дЃађ†в бблЂ™® (≠• І†§†≠ в®ѓ): '%s'\n", tt.chars());
			return 0;
		}
		return 1;
	} else {
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "пџ…¬ЋЅ ∆ѕ“ЌЅ‘Ѕ ””ўћЋ…\n");
		return 0;
	}
	return 1;
}

std::set<long> embedded_pictures;

int nsrcParser::checkPara(const unsigned char *s, int l, const unsigned char*& s_new, int& l_new)
{
	int pos = 0;
	longSplaySet badPositions;
	std::set<long> embedded_positions;

	unsigned char bWasErrors = 0;

	int i;
	for (i=0; i< l; i++) {
		if (s[i] == 0) {
			((char *)s)[i] = 32;
			continue;
		}
		if (s[i] == AT_FORMULA) {
			std::pair<long,std::string> apair (_line_in_nsrc, _nsrc_filename);
			if (!strnicmp ((const char*)(s+i+1),"pic:",4)) {
				//картинка
				/*
				pic:go2011.png;topic:10800201;bloffs:2;res:72
				!OBJTOPIC 10800201
				!NAME ¬строенна€ картинка
				!BELONGS GAR
				!OBJTYPE PNG
				!OBJPATH go2011.png
				additional_file_strings
				*/
				unsigned int b_ok = l - ((s+i+1) - s), b_add_belongs = false;
				char *line = (char*)malloc(b_ok+1);
				memcpy(line, s+i+1, b_ok);
				line[b_ok]= 0;
				if (strchr (line, AT_FORMULA)) {
					*strchr (line, AT_FORMULA) = 0;
					char added_line [128];
					char* topic = strstr (line, "topic:");
					long ctn = 0;
					if (topic) {
						ctn = atol (topic+6);
						sprintf (added_line, "!OBJTOPIC %ld %ld", ctn, ctn);

						ctn += ID_BORDER;
						if (embedded_pictures.find (ctn) == embedded_pictures.end ()) {
							//есть ли в “¬—ах и прочих
							std::map<long,long*>::const_iterator map_it = map_doc_subs->find (ctn);
							if ((map_it != map_doc_subs->end ()) || (bsearch (&ctn, topic_tvstopics, topic_tvstopics_count, sizeof (long), longcmp)) || (blobs->contains (ctn))) {
								b_ok = false;
								gclog.printfC (errors, AdvLogger::LOG_FATAL, AdvLogger::CD_WIN, " артинка, встроенна€ в текст: топик %d уже используетс€.\n", ctn - ID_BORDER);
							}							
						} else {
							//картинку уже один раз встречали, неоходимые команды дл€ ее включени€ в базу уже создали
							b_ok = false;
							b_add_belongs = true;
						}
						embedded_pictures.insert (ctn);

						if (b_ok) {
							additional_file_strings->push_back (added_line);
							additional_source->push_back (apair);

							sprintf (added_line, "!NAME %ld", ctn);
							additional_file_strings->push_back (added_line);
							additional_source->push_back (apair);
						}
					} else {
						b_ok = false;
					}
					if (b_ok) {
						additional_file_strings->push_back ("!BELONGS EMBEDDED_PIC"); //заглушка, так как компил€тор возьмет реальные значени€ из мапы topicBelongs
						additional_source->push_back (apair);
					}

					if (b_ok || b_add_belongs) {
						std::set<short> embedded_belongs;
						std::map<long,short*>::iterator map_it = cinfo->topicBelongs->find (ctn);
						if (map_it != cinfo->topicBelongs->end ()) {
							short *data = map_it->second, *ptr = data, count = *ptr++;
							for (short segs = 0; segs < count; segs++, ptr++)
								embedded_belongs.insert (*ptr);
							delete [] data;
							cinfo->topicBelongs->erase (ctn);
						}
						map_it = cinfo->topicBelongs->find (me);
						if (map_it != cinfo->topicBelongs->end ()) {
							short *data = map_it->second, *ptr = data, count = *ptr++;
							for (short segs = 0; segs < count; segs++, ptr++)
								embedded_belongs.insert (*ptr);
						}
						if (embedded_belongs.size ()) {
							short *data = new short [embedded_belongs.size () + 1], *ptr = data;
							*ptr++ = embedded_belongs.size ();
							for (std::set<short>::const_iterator seg_it = embedded_belongs.begin (); seg_it != embedded_belongs.end (); seg_it++, ptr++)
								*ptr = *seg_it;
							cinfo->topicBelongs->insert (std::map<long,short*>::value_type (ctn, data));
						}
					}

					if (b_ok) {
						char *path = strstr (line, "pic:");
						if (path) {
							if (strchr (path, ';'))
								*strchr (path, ';') = 0;
							sprintf (added_line, "!OBJPATH %s", path+4);
							additional_file_strings->push_back (added_line);
							additional_source->push_back (apair);

						}
						additional_file_strings->push_back ("");
						additional_source->push_back (apair);
					}
				}
				free (line);
				spec[pos] = AT_EMBEDDEDPIC;
				spec_pos[pos] = i;
				embedded_positions.insert (i);
				pos++;
				i = strchr ((char*)(s+i+1), AT_FORMULA) - (char*) s;
				spec_pos[pos] = i;
				spec[pos] = AT_EMBEDDEDPIC;
				spec_pos[pos] = i;
				embedded_positions.insert (i);
				pos++;
			} else {
				spec[pos] = (char)s[i];
				spec_pos[pos] = i;
				pos++;
			}
		} else if (s[i] <= 7 || s[i] == 15) {
			spec[pos] = (char)s[i];
			spec_pos[pos] = i;
			pos++;
		}
	}
	spec[pos] = 0;

	// check references
	/*
	char * p = strstr(spec,"\x4\x4\x4");
	while (p && p-spec<pos) {
		int start_ref = spec_pos[p-spec];
		int middle_ref = spec_pos[p+1-spec];
		int stop_ref = spec_pos[p+2-spec];
		for (i = start_ref+1; i < middle_ref; i++) {
			if (s[i] <= 6) {
				badPositions.add((long)i);
			}
		}
		if (!checkParaRef(s+middle_ref+1,stop_ref-middle_ref-1)) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ќшибка в ссылке. —сылка игнорируетс€.\n");
			badPositions.add((long)(spec_pos[p-spec]));
			for (i = spec_pos[p+1-spec]; i <= spec_pos[p+2-spec]; i++)
				badPositions.add((long)i);
		}
		memcpy(p,"\x8\x8\x8",3);
		p = strstr(spec,"\x4\x4\x4");
	}
	*/

	/*
	{
	char * p = strstr(spec,"\x4\x13\x13\x4\x4");
	while (p && p-spec<pos) {
		int start_ref = spec_pos[p-spec];
		int middle_ref = spec_pos[p+3-spec];
		int stop_ref = spec_pos[p+4-spec];
		for (i = start_ref+1; i < middle_ref; i++) {
			if (s[i] <= 6) {
				badPositions.add((long)i);
			}
		}
		if (!checkParaRef(s+middle_ref+1,stop_ref-middle_ref-1)) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ќшибка в ссылке. —сылка игнорируетс€.\n");
			badPositions.add((long)(spec_pos[p-spec]));
			for (i = spec_pos[p+1-spec]; i <= spec_pos[p+2-spec]; i++)
				badPositions.add((long)i);
		}
		memcpy(p,"\x8\x8\x8\x8\x8",5);
		p = strstr(spec,"\x4\x13\x13\x4\x4");
	}
	}
	*/

	//нова€ (18.06.2015) проверка на пересечение сегментов, http://mdp.garant.ru/pages/viewpage.action?pageId=601983748&focusedCommentId=602001168#comment-602001168
	if (pos) {
		std::vector<char> segment_char;
		long reference_depth = 0; //сколько символов ссылки нашлось, поскольку их три, а не 2, как у всех остальных
		for (int i = 0; i < pos; i++) {
			char ati = spec [i];
			if (segment_char.size () == 0)
				segment_char.push_back (ati);
			else {
				char lastchar = segment_char [segment_char.size () - 1];
				if (lastchar != ati) {
					//есть ли в стэке такие же, уже открытые сегменты
					bool b_valid = true;
					for (std::vector<char>::const_iterator it = segment_char.begin (); it != segment_char.end (); it++) {
						if (*it == ati) {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ѕересечение сегментов выделени€.\n");
							badPositions.add ((long)(spec_pos [i]));
							b_valid = false;
						}
					}
					if (b_valid)
						segment_char.push_back (ati);
				} else {
					if (ati == 4) {
						if (reference_depth) {
							segment_char.erase (segment_char.begin () + segment_char.size () - 1);
							reference_depth = 0;
						} else {
							reference_depth++;
						}
					} else {
						segment_char.erase (segment_char.begin () + segment_char.size () - 1);
					}
				}
			}
		}
	}

	bool b_badrefs = false;
	if (pos) {
		std::stack<long> spec_stack;
		/*if (spec [0] != 8)*/ spec_stack.push (spec [0]);
		for (int i = 1; i < pos; i++) {
			/*if (spec [i] == 8)
				continue;*/
			if (spec_stack.size () == 0)
				spec_stack.push (spec [i]);
			else if (spec [i] == spec_stack.top ()) {
				spec_stack.pop ();
				if (spec [i] == 4) {
					if (spec [i + 1] != 4) {
						gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќезакрыта€ ссылка. —сылка игнорируетс€.\n");
						b_badrefs = true;
						gclog.flush ();
						long j = i - 1;
						while (spec [j] != 4) j--;
						badPositions.add((long)(spec_pos [j]));
						badPositions.add((long)(spec_pos [i]));
					} else {
						if (spec_pos [i] + 1 == spec_pos [i+1]) {
							//пуста€ ссылка
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ѕуста€ ссылка, игнорируетс€.\n");
							gclog.flush ();
							long j = i - 1;
							while (spec [j] != 4) j--;
							badPositions.add((long)(spec_pos [j]));
							badPositions.add((long)(spec_pos [i]));
							badPositions.add((long)(spec_pos [i+1]));
						}
						i++;
					}
				}
			} else
				spec_stack.push (spec [i]);
		}
		if (spec_stack.size ()) {
			gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќезакрытое выделение в параграфе.\n");
			gclog.flush ();
		} else {
			for (int i = 0; i < pos; i++)
				if (spec [i] == 4)
					spec [i] = 8;
		}
	}
	
	/*
	стара€ проверка
	p = strrchr(spec,4);
	while (p && p-spec<pos) {
		if (p>spec && *(p-1) == 4) {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќезакрыта€ ссылка. —сылка игнорируетс€.\n");
			badPositions.add((long)(spec_pos[p-1-spec]));
			badPositions.add((long)(spec_pos[p-spec]));
			memcpy(p-1,"\x8\x8",2);
		} else {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќезакрыта€ ссылка. —сылка игнорируетс€.\n");
			badPositions.add((long)(spec_pos[p-spec]));
			*p = 8;
		}
		p = strrchr(spec,4);
	}
	*/

	/*
	нова€ проверка, неправильна€
	p = strchr (spec, 4);
	while (p && p - spec < pos) {
		char* nextp = strchr (p+1, 4);
		if (nextp && ((nextp - p) % 2 == 1) && *(nextp+1) == 4) {
			*p = 8;
			*nextp = 8;
			*(nextp+1) = 8;
		} else {
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќезакрыта€ ссылка. —сылка игнорируетс€.\n");
			badPositions.add((long)(spec_pos[p-spec]));
			*p = 8;
			if (nextp) {
				badPositions.add((long)(spec_pos[nextp-spec]));
				*nextp = 8;
			}
		}
		p = strchr (spec, 4);
	}
	*/

	while (pos) {
		int new_pos = 0;
		for (i=0; i<pos; i++) {
			if (spec[i] != 8) {
				spec[new_pos] = spec[i];
				spec_pos[new_pos] = spec_pos[i];
				new_pos++;
			}
		}
		
		pos = new_pos;
		spec[pos] = 0;

		if (!pos)
			break;
		
		char * p1 = strstr(spec,"\x1\x1");
		char * p2 = strstr(spec,"\x2\x2");
		char * p3 = strstr(spec,"\x3\x3");
		char * p5 = strstr(spec,"\x5\x5");
		char * p6 = strstr(spec,"\x6\x6");
		char * p7 = strstr(spec,"\x7\x7");
		char * p13 = strstr(spec,"\x13\x13");
		char * p14 = strstr(spec,"\x14\x14");
		char * pF = strstr(spec,"\xF\xF");

		if (!(p1 || p2 || p3 || p5 || p6 || p7 || p13 || p14 || pF)) {
			for (i=0; i< pos; i++) {
				gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќезакрытое выделение в параграфе.\n");
				badPositions.add((long)(spec_pos[i]));
			}
			break;
		}

		while (p1 && p1-spec<pos) {
			memcpy(p1,"\x8\x8",2);
			p1 = strstr(spec,"\x1\x1");
		}
		while (p2 && p2-spec<pos) {
			memcpy(p2,"\x8\x8",2);
			p2 = strstr(spec,"\x2\x2");
		}
		while (p3 && p3-spec<pos) {
			memcpy(p3,"\x8\x8",2);
			p3 = strstr(spec,"\x3\x3");
		}
		while (p5 && p5-spec<pos) {
			memcpy(p5,"\x8\x8",2);
			p5 = strstr(spec,"\x5\x5");
		}
		while (p6 && p6-spec<pos) {
			memcpy(p6,"\x8\x8",2);
			p6 = strstr(spec,"\x6\x6");
		}
		while (p7 && p7-spec<pos) {
			memcpy(p7,"\x8\x8",2);
			p7 = strstr(spec,"\x7\x7");
		}
		while (p13 && p13-spec<pos) {
			memcpy(p13,"\x8\x8",2);
			p13 = strstr(spec,"\x13\x13");
		}
		while (p14 && p14-spec<pos) {
			memcpy(p14,"\x8\x8",2);
			p14 = strstr(spec,"\x14\x14");
		}
		while (pF && pF-spec<pos) {
			memcpy(pF,"\x8\x8",2);
			pF = strstr(spec,"\xF\xF");
		}
	}

	unsigned char * sn= 0;
	if (!badPositions.length()) {
		l_new = l;
		sn = new unsigned char[l_new];
		pos = 0;
		for (i=0; i<l; i++) {
			if (embedded_positions.find (i) == embedded_positions.end ())
				sn[pos] = s[i];
			else
				sn[pos] = AT_EMBEDDEDPIC;
			pos++;
		}
	}else{
		l_new = l - badPositions.length();
		sn = new unsigned char[l_new];
		pos = 0;
		for (i=0; i<l; i++) {
			if (!badPositions.contains(i)) {
				if (embedded_positions.find (i) == embedded_positions.end ())
					sn[pos] = s[i];
				else
					sn[pos] = AT_EMBEDDEDPIC;
				pos++;
			}
		}
	}

	if (b_badrefs) {
		for (int i = 0; i < l_new; i++)
			if (sn [i] == 4)
				sn [i] = ' ';
	}

	s_new = sn;
	return 1;
}

void	nsrcParser::checkEditionHere(long id, long prev, long next)
{
	if (prev) {
		std::map<long,short*>::const_iterator fnd = cinfo->topicBelongs->find (id);
		std::map<long,short*>::const_iterator fnd2 = cinfo->topicBelongs->find (prev);
		if (fnd == cinfo->topicBelongs->end () || fnd2 == cinfo->topicBelongs->end ())
			return;
		
		short *data_fnd = fnd->second, count_fnd = *data_fnd++;
		short *data_fnd2 = fnd2->second, count_fnd2 = *data_fnd2++;

		for (short count2 = 0, *ptr2 = data_fnd2; count2 < count_fnd2; count2++, ptr2++) {
			short seg = *ptr2;
			bool found = false;
			for (short count = 0, *ptr = data_fnd; count < count_fnd && !found; count++, ptr++)
				if (*ptr == seg)
					found = true;
			if (!found)
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,"÷епочка–едакций: топик %ld не принадлежит базе %ld, содержащей топик %ld.\n", id - ID_BORDER, (long) seg, prev - ID_BORDER);
		}

		for (short count = 0, *ptr = data_fnd; count < count_fnd; count++, ptr++) {
			short seg = *ptr;
			bool found = false;
			for (short count2 = 0, *ptr2 = data_fnd2; count2 < count_fnd2 && !found; count2++, ptr2++)
				if (*ptr2 == seg)
					found = true;
			if (!found)
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,"÷епочка–едакций: топик %ld не принадлежит базе %ld, содержащей топик %ld.\n", prev - ID_BORDER, (long) seg, id - ID_BORDER);
		}
	}

	if (next) {
		std::map<long,short*>::const_iterator fnd = cinfo->topicBelongs->find (id);
		std::map<long,short*>::const_iterator fnd2 = cinfo->topicBelongs->find (next);
		if (fnd == cinfo->topicBelongs->end () || fnd2 == cinfo->topicBelongs->end ())
			return;
		
		short *data_fnd = fnd->second, count_fnd = *data_fnd++;
		short *data_fnd2 = fnd2->second, count_fnd2 = *data_fnd2++;

		for (short count2 = 0, *ptr2 = data_fnd2; count2 < count_fnd2; count2++, ptr2++) {
			short seg = *ptr2;
			bool found = false;
			for (short count = 0, *ptr = data_fnd; count < count_fnd && !found; count++, ptr++)
				if (*ptr == seg)
					found = true;
			if (!found)
				gclog.printfC (AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,"÷епочка–едакций: топик %ld не принадлежит базе %ld, содержащей топик %ld.\n", id - ID_BORDER, (long) seg, next - ID_BORDER);
		}

		for (short count = 0, *ptr = data_fnd; count < count_fnd; count++, ptr++) {
			short seg = *ptr;
			bool found = false;
			for (short count2 = 0, *ptr2 = data_fnd2; count2 < count_fnd2 && !found; count2++, ptr2++)
				if (*ptr2 == seg)
					found = true;
			if (!found)
				gclog.printfC (AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN,"÷епочка–едакций: топик %ld не принадлежит базе %ld, содержащей топик %ld.\n", next - ID_BORDER, (long) seg, id - ID_BORDER);
		}
	}
}

bool nsrcParser :: checkObjectHere(long t)
{
	std::map<long,short*>::const_iterator fnd = cinfo->topicBelongs->find (t);
	if (fnd == cinfo->topicBelongs->end ())
		return false;

	std::map<long,short*>::const_iterator fnd2 = cinfo->topicBelongs->find (me);
	if (fnd2 != cinfo->topicBelongs->end ()) {
		short *data_fnd = fnd->second, count_fnd = *data_fnd++;
		short *data_fnd2 = fnd2->second, count_fnd2 = *data_fnd2++;

		for (short count2 = 0, *ptr2 = data_fnd2; count2 < count_fnd2; count2++, ptr2++) {
			short seg = *ptr2;
			bool found = false;
			for (short count = 0, *ptr = data_fnd; count < count_fnd && !found; count++, ptr++)
				if (*ptr == seg)
					found = true;
			if (!found)
				gclog.printfC (AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "ќбъект N %ld не принадлежит базе %ld, содержащей топик %ld.\n",t - ID_BORDER, (long) seg, me - ID_BORDER);
		}
	}
	return true;
}

int nsrcParser :: makeParaData(unsigned char *dst, const unsigned char *s, int l, size_t &fl)
{
	unsigned char* sep = (unsigned char*) s + l - 1;
	if ( paraStyle == PS_SIDEBYSIDE ) {
		while (( sep != (unsigned char*)s ) && ( *sep != '|' ))
			sep--;
		if ( *sep == '|' )
			*sep = '\t';
		
		sep = (unsigned char*) s + l - 1;
		while (( sep != (unsigned char*)s ) && ( *sep != '\t' ))
			sep--;

		if ( *sep != '\t' )
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈‘ “ЅЏƒ≈ћ…‘≈ћ— „ side-by-side –Ѕ“Ѕ«“Ѕ∆≈.\n");
		else
			*sep = ' ';
		paraStyle = PS_LEFT;
	}

	int bWasSpace = 1;
	unsigned char *sdst = dst;
	int bFace = 0;
	
	const unsigned char * sc = 0;
	int lc;
	
	checkPara(s,l,sc,lc);
	const unsigned char* save_sc = sc;
	
	for( ; lc > 0; lc-- ) {
		if( *sc > 6 && *sc != 255) {
			if( *sc == ' ' || *sc == '\t' ) {
				if ( paraStyle == PS_SIDEBYSIDE && *sc == '\t' ) {
					if ( sc == sep ) {
						*dst++ = *sc++;
						bWasSpace = 1;
						continue;
					} else {
						*dst++ = 10;
						sc += 2;
						lc--;
						continue;
					}
				} else {
					if( bWasSpace ) {
						sc++;
						continue;
					} else {
						*dst++ = ' ';
						sc++;
						bWasSpace = 1;
						continue;
					}
				}
			} else {
				//*dst++ = Dos2WinRecodeTable[ *sc++ ];
				if ( *sc == '|' && paraStyle == PS_SIDEBYSIDE ) {
					*dst++ = 10;
					sc += 2;
					lc--;
				} else
				if (*sc == 29) {
					*dst++ = 10;
					sc++;
				} else {
					*dst++ = *sc++;
					bWasSpace = 0;
				}
				continue;
			}
		} else {
			switch (*sc) {
			case 1:
			case 2:
			case 5:
			case 6:
				if ( *sc == 1 && paraStyle == PS_CENTERED ) {
					bFace = bFace - 1;
					if ( bFace  && dst - sdst > 2 && *(dst-1) == ' ' && *(dst-2) == 1 ) {
						*(dst-2) = 10; //softbreak
						dst--;
						sc++;
					} else
					if ( bFace && dst - sdst > 2 && *(dst-1) == 1 ) {
						*(dst-1) = 10; //softbreak
						sc++;
					} else {
						//*dst++ = Dos2WinRecodeTable[ *sc++ ];
						*dst++ = *sc++;
					}
				} else {
					//*dst++ = Dos2WinRecodeTable[ *sc++ ];
					*dst++ = *sc++;
				}
				break;
			case 255:
				*dst++ = 255;
				sc++;
				break;
			case 3:
				Info.GreenComments++;
				*dst++ = *sc++;
				break;
			case 4:
				// issue it
				*dst++ = *sc++;		// copy first delimiter
				lc--;
				// copy first part of reference	
				unsigned char *nxt = (unsigned char *) memchr(sc, 4, lc);
				bWasSpace = 1;
				while( sc < nxt ) {
					if( *sc == ' ' || *sc == '\t' ) {
						if( bWasSpace ) {
							sc++;
							lc--;
							continue;
						} else {
							*dst++ = ' ';
							sc++;
							lc--;
							bWasSpace = 1;
							continue;
						}
					} else {
						//*dst++ = Dos2WinRecodeTable[ *sc++ ];
						*dst++ = *sc++;
						lc--;
						bWasSpace = 0;
						continue;
					}
				}
				*dst++ = 4;
				sc++;
				lc--; 
				
				// start processing list of references
				if (*sc < '0' || *sc > '9') {
					gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "ѕодозрительный символ в ссылке\n");
					while (*sc < '0' || *sc > '9') {
						sc++;
						lc--;
					}
				}

				if ((*sc >= '0') && (*sc <= '9')) {
					u_int64_tSplaySet rf_check;
					unsigned char *reftype_ptr = dst++;
					*reftype_ptr =  REFTYPE_UNKNOWN;
					short *pnrefs = (short *)dst;
					unsigned long *refptr = (unsigned long *)(pnrefs+1);
					void *trefptr = refptr;
					nxt = (unsigned char *)memchr(sc, 4, lc);
					errno = 0;
					unsigned char *eptr = (unsigned char *) sc;
					int ncount = 0;
					unsigned char *prev_eptr = eptr;
					while( eptr < nxt ) {
						unsigned long t = strtoul((char*)eptr,(char**)&eptr,10);
						t += REAL_DOC_OFFS;
						if( *reftype_ptr == REFTYPE_UNKNOWN ) {
							if (bsearch (&t, topic_tvstopics, topic_tvstopics_count, sizeof (long), longcmp))
								*reftype_ptr = REFTYPE_REFLIST;
							else
							if ( blobs->contains(t ) ) {
								*reftype_ptr = REFTYPE_BLOB;
							} else {
								*reftype_ptr = REFTYPE_REFLIST;
							}
						}
						if( *reftype_ptr == REFTYPE_REFLIST ) {
							Ref2Int64 rf;
							unsigned long tt=0;

							if (*eptr==' '||*eptr=='\t'||*eptr=='\04') {
								;
							} else if( *eptr == '.' ) {
								tt=strtoul((char*)++eptr,(char**)&eptr,10);
							}

							checkNegativeRef(t,tt);

							if (bWdoRefDocCheck) checkRef(t,tt);

							rf.asref.docid = t;
							rf.asref.sub = tt;

							if (rf_check.contains(rf.asint)) {
								gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "ќбнаружена дублирующа€ ссылка '%d.%d' (игнорируетс€)\n",t-REAL_DOC_OFFS,tt);
								ncount--;
							} else {
								rf_check.add(rf.asint);
								*refptr++=t;
								*refptr++=tt;
								addRespCorr(t, rf);
							}

						} else {
							// REFTYPE_BLOB
							if ( (map_doc_subs->find (t) != map_doc_subs->end ()) && (*reftype_ptr == REFTYPE_BLOB)) {
								gclog.printfC(AdvLogger::LOG_WARNING_MPCXC,AdvLogger::CD_WIN, "¬ мультиссылке присутствуют ссылки на объекты и документы\n" );
								if ( eptr < nxt && *eptr=='.' ) {
									eptr++;
									while ( eptr < nxt && isalnum( *eptr ))
										eptr++;
								}
							} else if(!checkObjectHere(t) && bWdoRefDocCheck && !blobs->contains(t)) {
								gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"о≈‘ ѕ¬я≈Ћ‘Ѕ %d.\n", t);
								if ( eptr < nxt && *eptr=='.' ) {
									eptr++;
									while ( eptr < nxt && isalnum( *eptr ))
										eptr++;
								}
							}
							*refptr++=t;
							*refptr++=0;					
						}
						ncount++;
						while((eptr < nxt)&&(*eptr==' '||*eptr=='\t'))
							eptr++;
						if (prev_eptr == eptr) {
							gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "ќшибка в ссылке (недопустимый символ)\n");
							++eptr;
						}
						prev_eptr = eptr;
					}
					if( ncount == 1 )
						*pnrefs = 0;
					else {
						if (ncount > 1 && *reftype_ptr == REFTYPE_BLOB) {
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ќе допускаетс€ мультиссылка на объектные топики\n" );
						}
						*pnrefs = ncount;
					}
					
					dst = (unsigned char *) refptr;
					lc -= nxt-sc;
					// l--;
					sc = nxt+1;
					bWasSpace = 0;
				} else if ((*sc >= 'a') && (*sc <= 'z')) {
					sc += 9;
					lc -= 9;
					*dst++ = REFTYPE_CLASS;
					
					nxt = (unsigned char *)memchr(sc, 4, lc);
					
					FString rawClass((const char*)sc, nxt - sc);
					rawClass.bDoFree = 0;
					FString *trClass = ci->pTranslate(rawClass, ClassesInfo::TRANSCLASS);
					trClass->bDoFree = 1;
					strcpy((char*)dst, trClass->chars());
					dst += trClass->length();
					rawClass.bDoFree = 1;
					delete trClass;
					lc -= nxt - sc;
					sc = nxt + 1;
				}
				Info.HyperRefs++;
				break;
			}
		}
	}
	fl = dst-sdst;
	delete[] save_sc;
	return 0;
}

void nsrcParser :: issuePrefPara(const unsigned char *s, int l)
{
	const unsigned char * sc = 0;
	int lc;
	
	int err = checkPara(s,l,sc,lc);
	unsigned char * save_sc = (unsigned char*)sc;
	
	unsigned char *dst = paraFinalBuf + sizeof(struct para_header);
	for( ; lc; lc-- ) {
		if( *sc > 6 && *sc != 9 && *sc != 255 && *sc != 29) {
			*dst++ = *sc++;
			continue;
		} else {
			switch (*sc) {
			case 29:
				*dst++ = ' ';
				sc++;
				break;
			case 9:
				*dst++ = ' ';
				sc++;
				gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, "ч ”‘“ѕЋ≈ –“…”’‘”‘„’≈‘ ”…Ќ„ѕћ ‘Ѕ¬’ћ—√…….\n");
				break;
			case 3:
				Info.GreenComments++;
			case 1:
			case 2:
			case 5:
			case 6:
				*dst++ = *sc++;
				break;
			case 255:
				*dst++ = 255;
				sc++;
				break;
			case 4:
				// issue it
				*dst++ = 4;     // copy first delimiter
				sc++;
				lc--;
				// copy first part of reference
				unsigned char *nxt = (unsigned char *)memchr(sc, 4, lc);
				while( sc < nxt ) {
					if (*sc == 9) {
						*dst++ = ' ';
						sc++;
					} else {
						*dst++ = *sc++;
					}
					lc--;
				}
				*dst++ = 4;
				sc++;
				lc--; 
				
				// start processing list of references 
				if (((*sc >= '0') && (*sc <= '9')) || *sc == '-') {
					if (*sc == '-') {
						gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_WIN, "ѕодозрительный символ в ссылке\n");
						while (*sc < '0' || *sc > '9') {
							sc++;
							lc--;
						}
					}
					unsigned char *reftype_ptr = dst++;
					*reftype_ptr =  REFTYPE_UNKNOWN;
					short *pnrefs = (short *)dst;
					unsigned long *refptr = (unsigned long *)(pnrefs+1);
					void *trefptr = refptr;
					nxt = (unsigned char *)memchr(sc, 4, lc);
					errno = 0;
					unsigned char *eptr = (unsigned char *) sc;
					int ncount = 0;
					while( eptr < nxt ) {
						unsigned long t = strtoul((char*)eptr,(char**)&eptr,10);
						t += REAL_DOC_OFFS;
						if( *reftype_ptr == REFTYPE_UNKNOWN ) {
							// try to distinct reftype
							if ( blobs->contains(t ) )
								// well, its a blob
								*reftype_ptr = REFTYPE_BLOB;
							else
								*reftype_ptr = REFTYPE_REFLIST;
						}
						if( *reftype_ptr == REFTYPE_REFLIST ) {
							*refptr++=t;
							Ref2Int64 rf;
							rf.asref.docid = t;
							if(*eptr==' '||*eptr=='\t'||*eptr=='\04') {
								*refptr++=0;
								rf.asref.sub = 0;

								checkNegativeRef(t,0);

								if( bWdoRefDocCheck ) checkRef(t, 0 );
							} else if( *eptr == '.' ) {
								unsigned long tt=strtoul((char*)++eptr,(char**)&eptr,10);
								rf.asref.sub = (*refptr++=tt);

								checkNegativeRef(t,tt);

								if( bWdoRefDocCheck ) checkRef(t, tt );
							}
							addRespCorr(t, rf);
						} else { // REFTYPE_BLOB
							if(!checkObjectHere(t) && bWdoRefDocCheck && !blobs->contains(t))
								gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "о≈‘ ѕ¬я≈Ћ‘Ѕ %d.\n", t);
							*refptr++=t;
							*refptr++=0;					
						}
						ncount++;
						while((eptr < nxt)&&(*eptr==' '||*eptr=='\t'))
							eptr++;
					}
					if( ncount == 1 )
						*pnrefs = 0;
					else
						*pnrefs = ncount;
					
					dst = (unsigned char *) refptr;
					lc -= nxt-sc;
					// l--;
					sc = nxt+1;
				} else if ((*sc >= 'a') && (*sc <= 'z')) {
					sc += 9;
					lc -= 9;
					*dst++ = REFTYPE_CLASS;
					
					nxt = (unsigned char *)memchr(sc, 4, lc);
					
					FString rawClass((char*)sc, nxt - sc);
					rawClass.bDoFree = 0;
					FString *trClass = ci->pTranslate(rawClass,
						ClassesInfo::TRANSCLASS);
					trClass->bDoFree = 1;
					strcpy((char*)dst, trClass->chars());
					dst += trClass->length();
					rawClass.bDoFree = 1;
					delete trClass;
					lc -= nxt - sc;
					sc = nxt + 1;
				}
				Info.HyperRefs++;
			}
		}
	}
	if (err) {
		sc = save_sc;
		delete[] (unsigned char*)sc;
	}
	if (styleh) {
		dbproc->addTopicParaHeights (me, (char*) &cpn, sizeof (long));
		dbproc->addTopicParaHeights (me, (char*) &styleh, sizeof (long));
		para_styleh_pairs.push_back (cpn);
		para_styleh_pairs.push_back (styleh);
	}

	endParaEx ();
	dbproc->addTopicPara (me,PS_PREFORMATTED,paraFinalBuf,dst-paraFinalBuf);
	paraCount++;
#ifdef	VERSION61
	lastSkippedPara = -1;		
#endif
}
