#ifndef __GarComp_H__
#define __GarComp_H__

#include <cctype>
#include "gardefs.h"
#include "long.long.VHMap.h"
#include "u_int32_t.SplaySet.h"
#include "FString.SplaySet.h"
#include "long.longSplaySet.SplayMap.h"
#include "date.SplaySet.h"
#include "long.VHSet.h"
#include "../../../libs/gc/src/gclog.h"
#include "../../../libs/gc/src/dbproc.h"
#include "fstring.h"
#include "SplayMap.h"
#include <set>
#include <map>
#include <vector>
#include <stack>
#include "StorableSplaySet.h"

#ifndef dateCMP
#define dateCMP(a, b) (((a).da_year>(b).da_year)?1:\
						((a).da_year<(b).da_year)?-1:\
						((a).da_mon>(b).da_mon)?1:\
						((a).da_mon<(b).da_mon)?-1:\
						((a).da_day>(b).da_day)?1:\
						((a).da_day<(b).da_day)?-1:0)

#endif

#ifndef dateCmp
#define dateCmp(a,b) dateCMP(a,b)
#endif

extern "C" {
//	#ifdef __GO32__
//		#include "gnuregex.h"
//	#else
 		#include "rx.h"
 		#include "Regex.h"
//	#endif
}

#ifdef VERSION56
	typedef std::set<DocActivityEx> Activity;
	typedef std::vector<PageBreak> Pages;
	typedef std::set<DocChDate> ChDate;
	typedef std::set<ChDateEx> ChDateExes;
	typedef	std::set<ContentsStruct> Contents;
	typedef	std::set<CompareContentsStruct> CompareContents;
	typedef std::set<DocNotSure> NotSure;
	typedef std::set<DivisionInfo> Divisions;
#endif

#ifdef VERSION56
	int is_ok(const DocActivityEx& interval);
	void getActivity(const char *s, int l, DocActivityEx& docActivity);
	void getContents(const char*s, int l, ContentsStruct& contents );
	void getNotSure(const char*s, int l, NotSure& notSure);
	void getDivision(const char* s, int l, DivisionInfo& divisionInfo );
#endif

class FStringlongSplayMap; 
class CaseStringlongSplayMap; 
class CaseStringCaseStringSplayMap; 
class CaseStringSplaySet;
class FStringlongVHMap;
class FStringVHSet;
class u_int32_tVHSet;
//class std::ifstream;
class STtoP;
class u_int32_tcaddr_tSplayMap;
class u_int32_tFStringVHMap;
class u_int64_tSplaySet;
class u_int32_tSplaySet;
class u_int32_tVHSet;
class u_int64_tVHSet;
class u_int32_tSet;
union Ref2Int64;

class String;

struct BaseCore;
class ClassesInfo;
struct SourcesInfo;
struct NormInfo;

#ifndef OLD_MAP
	#include "QMap.hpp"

	typedef QuickSplayMapG<long, char> GSubMap;
	typedef QuickSplayMapG<long, GSubMap> GDocsSubsMap;

	typedef QuickSplayMapG<u_int64_t, char> GRefMap;
	typedef QuickSplayMapG<long, GRefMap> GDocsRefsMap;

	template <class Key, class Data>
	class QuickSplayStringMapG: public QuickSplayMapG<Key, Data> {
		public:
		QuickSplayStringMapG(Data dflt, int reAllocF= 1, int reAllocS= 0) : QuickSplayMapG<Key,Data>(dflt, reAllocF, reAllocS){
		}
		virtual int key_cmp (const Key& a, const Key& b) const {
			return str_case_cmp( ((FString*)&a)->chars(), ((FString*)&b)->chars());
		}
	};
	typedef QuickSplayStringMapG<FString, FString> GSplayStringStringMap;
	#define GFStringFStringMap GSplayStringStringMap
	//#define GFStringFStringMap CaseStringCaseStringSplayMap
#else
	#define GFStringFStringMap CaseStringCaseStringSplayMap
#endif

typedef std::map<topic_t, topic_t> VerLink;

struct ThreadCompileInfo {
	std::set<long> *bad_docs;
	std::deque<long> *docs_with_class;

#ifdef VERSION56
	VerLink* m_next;
#endif
	ClassesInfo *classesInfo;
	SourcesInfo *sourcesInfo;

	BaseCore *basesCore;
	CaseStringlongSplayMap *belongsMap;
	int bDebugKW;
	DbProcessor *dbproc;
	int defPacking;
	revision rtoday;
	u_int32_tFStringVHMap *warningMap;
	FStringlongSplayMap *Sources;
//	longlongVHMap *topicPriority;
	STtoP *st2p;

	GFStringFStringMap *pubSrcMap;
	GFStringFStringMap *pubSrcMapConverter;
	GFStringFStringMap *topicTypes;
	GFStringFStringMap *topicKinds;
	GFStringFStringMap *topicAnnoUser;
	GFStringFStringMap *topicAnnoOrganization;
	GFStringFStringMap *topicAnnoTax;
	GFStringFStringMap *topicAnnoInterest;
	GFStringFStringMap *topicAnnoKind;
	GFStringFStringMap *topicServiceInfo;

	GFStringFStringMap *topicInpharmFirms;
	GFStringFStringMap *topicInpharmCountries;
	GFStringFStringMap *topicInpharmPharmGroups;
	GFStringFStringMap *topicInpharmPharmEffects;
	GFStringFStringMap *topicInpharmMkbs;
	GFStringFStringMap *topicInpharmChapters;
	GFStringFStringMap *topicInpharmAtcs;
	GFStringFStringMap *topicInpharmRegStatuses;
	GFStringFStringMap *topicInpharmLekForms;

	std::deque<long> *relatedS, *editions;

#ifdef OLD_MAP
	u_int32_tSplaySet *notADocs;
  #ifdef	VERSION56
	u_int32_tSplaySet *anonces;
	u_int32_tSplaySet *vlcontrols;
  #endif
	u_int32_tSplaySet *invalidDocs;
	u_int32_tSet   *blobs;

	u_int32_tcaddr_tSplayMap *corrs;
	u_int32_tcaddr_tSplayMap *resps;
#else
	GSubMap *notADocs;
  #ifdef	VERSION56
	GSubMap *anonces;
	GSubMap *vlcontrols;
  #endif
	GSubMap *invalidDocs;

	u_int32_tSet   *blobs;

	GDocsRefsMap *corrs;
	GDocsRefsMap *resps;
#endif
	longSplaySet *hereBelongs;
	std::map<long,short*> *topicBelongs;
	std::set<long> *ignoreBelongs;

	std::map<long,long*> *map_doc_subs;
	std::deque<long> *topics_tocompile;
	std::set<u_int64_t> *set_empty_blocks;
	std::map<std::string, std::set<long> > *map_file_leadingparas;
	std::deque<std::string> *additional_file_strings;
	std::deque<std::pair<long,std::string> > *additional_source;

	long *topic_tvstopics, topic_tvstopics_count;
	std::map<long,long> *editions_map;

	CaseStringlongSplayMap *objTypes;
	BaseWeight *weightsTable;
	NormInfo *normInfo;
	u_int32_t wtCount;
	int ref_doc_check;
	int ref_vincluded_check;
	int fatal_ifnotinbelongs;
	int name_len_check;
	int text_command_check;
	int iniSbrf;
	int print_prefix_ex;
	int sub_title_check;
	const char *objRoot;

	short	TopicRanges;
	int32_t *LoTopicRanges;
	int32_t *HiTopicRanges;

	std::map<long, date> *incorrect_dates_to;
	std::map<long, date> *incorrect_dates_toto;
};

union Ref2Int64 {
	struct {
		long docid;
		u_int32_t sub;
	} asref;
	u_int64_t  asint;
};

extern revision today_rev;
extern unsigned char *paraFinalBuf;
#ifdef PTRS_IN_META
	extern unsigned char *exportBuf;
#endif

class nsrcParser
{

  public:
	bool checkObjectHere(long t);
	void checkEditionHere(long, long, long);
  	nsrcParser();
	nsrcParser(ThreadCompileInfo *inf);
	void addLine( const char *s, int l, const char* nsrc_filename, int line_in_nsrc);
	bool para_contains_formulas ();
	~nsrcParser();
	void putPara();
	int mkFrom(const char *t,int tl, int bBlob);
	void finishTopic();
	long DocId;
	void flush();
#ifdef	BLOCKSINHERIT
	SplayMap <long, longVHSet> classSet, prefixesSet;
	SplayMap <long, CaseStringSplaySet*> typeSet;
	SplayMap <long, CaseStringSplaySet*> mkbSet, chapterSet;
#else
	longVHSet	classSet;
#endif
  protected:
	DocInfo Info;
	date	docRDate, docDate, FirstDate;
	ObjInfo objInfo;
  	DbProcessor *dbproc;
	topic_t me;
	bool baddoc_andskip;
#ifdef	VERSION61
	long	lastSkippedPara;
	bool	contents0;
	bool	wascontents0;
#endif
	bool	b_was_doc;
	bool	b_prevpara_iscomment;
	bool	b_was_kind;

	BaseCore *basesCore;
	long ctprio;
	longSplaySet belongsSet;
	std::map<long,long*> *map_doc_subs;
	std::deque<long> *topics_tocompile;
	std::set<u_int64_t> *set_empty_blocks;
	std::map<std::string, std::set<long> > *map_file_leadingparas;
	std::deque<std::string> *additional_file_strings;
	std::deque<std::pair<long,std::string> > *additional_source;

	long *topic_tvstopics, topic_tvstopics_count;
	std::set<long> *bad_docs;
	std::deque<long> *docs_with_class;
	std::map<long,long> *editions_map;

	void mkNewPara( const char *s, int l );
	void append2LName(const char *s, size_t l);
	void endPara();
	void endParaEx ();
	void addRespCorr(unsigned t, Ref2Int64 &rf );
	void checkRef( long docid, long sub );
	void checkNegativeRef( long docid, long sub );
	static int cmpRefsByForce(const void *ptr1, const void *ptr2);

#pragma pack(1)

	struct para_header {
		unsigned char dm8 ;
		unsigned char dm0;
		unsigned char lm;
		unsigned char rm;
		unsigned char rlm;
	};

#pragma pack()


	unsigned char *paraBuf;
	char spec[8000];
	int spec_pos[8000];
	ptrdiff_t paraBufSz, paraBufPos;

	int paraStyle;
	int checkPara(const unsigned char *s, int l, const unsigned char*& s_new, int& l_new);
	int checkParaRef(const unsigned char *s, int l);
	void issuePrefPara(const unsigned char *s, int l);
	void issueSBSPara(const char *s, int l);
	int  makeParaData(unsigned char *dst, const unsigned char *s, int l, size_t &fl);

	void loadObject(const char *, int );
	bool finishBlob();

	ClassesInfo *ci;
	SourcesInfo *si;

	int thatsSplashTopic;
	int thatsBannerTopic;
	int isBlob;

	int wasRcode;
	int wasWarning;
	int wasVerlink;
	bool	bIsm;

	int cpn;
	int paraCount;
	int lastFlushedSub;
	int lastSub;
	std::map<long,std::set<long> > blocks_in_cell;
	int lastSubs[100];
	int lastSubsPos;

	int table_row_cell_id;
	long subdescex_id, level;

	std::map<long,long> map_level_maxid; //последний id для уровня (ПЗ в К: для поля ID - идентификатор элемента структуры состоит из: старший байт - номер уровня, младшие три байта - сквозной (это важно) номер в уровне)
	std::map<long,long> map_subdescexid_levelandlevelid; //мапа subdescexid и какой у него level+levelid в пределах уровня
	std::map<long,long> map_subdescexid_type; //тип объекта
	std::map<long,long> map_subdescexid_firstpara, map_subdescexid_lastpara;
	std::map<long,long> map_subdescexid_firstchildid, map_subdescexid_lastchildid;
	std::map<long,long> map_subdescexid_to_id; //перевод в id блока или табличного элемента	
	std::vector<long> vector_subdescex_ids; //по мере увеличения levelа сюда кладем новые id; как level завершается - удаляем последний элемент.
	std::map<long,long> map_subdescexid_allleafparacount;
	std::set<long> set_block_subdescexids; //номера subdescexids для блоков; т.е. если текущий subdescex_id - блок, то в endParaEx надо увеличивать leaf
	std::set<long> set_cell_subdescexids; //номера subdescexids для cellов; т.е. если текущий subdescex_id - блок, то в endParaEx надо увеличивать leaf
	std::vector<long> subdescexids_instruct;
	long subdescex_id_inprocess;

	std::map<long,long> map_tableid_zoom, map_tableid_leftindent, map_tableid_type;

	long block_level; //уровень блока (в оглавлении)
	long max_level_in_contents; //пока block_level меньше max_level_in_contents, то блок попадает в оглавление; max_level_in_contents считается как сумма contentsов вышестоящих блоков; если последний contents равен 0, то max_level_in_contents тоже равен 0
	std::vector<long> vector_contents; //вектор, в котором накапливаем значения !contents для блоков
	std::vector<long> stack_block_with_contents;
	std::set<long> block_with_contents; //блоки, у которых есть contents; только встретил blockend такого блока, удаляем последнее значение из vector_contents
	std::set<long> blocks_in_contents; //блоки, которые попали в оглавление; им надо выставить ti_InContents 
	std::set<long> blocks_woname; //блоки без имен, не должны попадать в оглавление
	std::map<long,long> map_block_level; //уровень блока; соответственно, max_level_in_contents должен быть равен contentsу этого блока + уровень этого блока

	std::map<long,long> map_block_style;
	std::map<long,long> map_block_location;

	std::map<long,long> subdescex_ids;
	std::set<long> processed_subsblocks;
	std::set<long> processed_subs;
	std::stack <unsigned short> table_types;
	std::stack <long> table_ids, row_ids, cell_ids;
	long last_cell_para;
	unsigned char bIsSub;
	int subIdx, subExIdx;
	std::map<long,long> cells_in_row;
	bool fatal_table_errors;

	int bBelongsSet;
	int bPrioritySet;
	int bRelatedSet;
	int bVIncludedSet;
	int bSortDateSet;
	int bRevisionSet;

	int bRCodeSet;
	int bRDateSet;
	int bIsNoDoc;
	bool bIsEdition;
	bool bShowActiveToWarning;
	int bIsParaExist;
	int bIsPrefixDocuments;
	int bIsPrefixInternational;

	bool b_emptyparawithstyle;

	date date_1_1_2013;

	unsigned char isPriceLevelDefined;

	int bVAbolishedSet;
	int bVAnoncedSet;
	int bAnnoSet;
	int bVLControlSet;

	int bPublishedInSet;

	date dVAbolished;
	date dVIncluded;
	date dVAnonced;
	bool bwasNamedTerm;
	bool bwasChDate;

	bool b_show_skip_info;

#ifdef	BLOCKSINHERIT
	void doClass( int id, long aaSub );
#else
	void doClass( int id );
#endif
	void doSource( const char *s, int l );
	void doName( const char *s, int l );
	void doKey( const char *s, int l );
	void doSub( const char *s, int l , int max, bool b_is_sub = true);
	void doBlockEnd( const char *s, int l);
	void flushSub();
	void finishSources();

	longVHSet	gprefixSet, prefixSet;
	CaseStringSplaySet* typesSet;
	CaseStringSplaySet* kindsSet;
	CaseStringSplaySet *mkbsSet, *chaptersSet;

	CaseStringSplaySet* serviceInfoSet;
	CaseStringSplaySet* annoUserSet;
	CaseStringSplaySet* annoOrganizationSet;
	CaseStringSplaySet* annoTaxSet;
	CaseStringSplaySet* annoInterestSet;
	CaseStringSplaySet* annoKindSet;

	longVHSet   territorySet;
	longVHSet   sourcesSet;
	CaseStringSplaySet* srcsSet;
	dateSplaySet   dsVchanged;
#ifdef VERSION56
	Activity dsActivity;
	Pages dsPage;
	void check_page_break(const char *s, int& l);
	ChDate dsChDate;
	ChDateExes dsChDateEx;
	NotSure dsNotSure;		
	Contents dsContents;
	CompareContents dsCompareContents;
	Divisions dsDivisions;
#endif
	NormInfo *normInfo;
	FString *norm, *tradename, *intname;	

	ThreadCompileInfo *cinfo;

	u_int32_tSet   *blobs;
	u_int32_tFStringVHMap *warningMap;
	u_int32_tSplaySet *markedDocs;

#pragma pack(1)
	union DocClass {
		struct {
			u_int32_t id;
			u_int32_t sub;
		} asref;
		u_int64_t asint;
	};
#pragma pack()

	u_int64_tVHSet *docClasses;
	u_int64_tVHSet *docPrefixes;

	date dummyDate;
	int packing;

	int name_len_check;
	int text_command_check;
	int sub_title_check;
	int iniSbrf;

	SubDesc *subsTmp;
	SubDescEx *subsExTmp;
	char sLongName[DOC_NAME_SIZE+1];
	size_t sLongNameSz;
	char *objRoot;
	int  objRootLength;
	int objDataMaxSize;
	void *objData;
	int wasObjPath;
	unsigned long objType;
	unsigned char bObjectOk;
	short wordInPara;

	long	styleh; //STYLE ... H8 - ЧПФ УПВУФЧЕООП styleh Й ВХДЕФ ТБЧЕО 8
	std::vector<long> para_styleh_pairs;
};


extern int bWdoRefDocCheck;
extern date todayDate;
extern date maxDate;
extern date prevSatDate;
extern date satDate;

class STtoP;

void gcpass1(ThreadCompileInfo &);

#ifndef VHMAPREALSIZE
	#define VHMAPREALSIZE(x) (((x)<<3)/7)
#endif

#define REAL_DOC_OFFS 100000

#define MAX_DOC_NUMBER (0x7ffffff0)

#ifdef	BLOCKSINHERIT
#define	MAX_SUB_NUMBER	0x3FFFFFFE
#else
#define MAX_SUB_NUMBER (0x7ffffff0)
#endif


#endif

