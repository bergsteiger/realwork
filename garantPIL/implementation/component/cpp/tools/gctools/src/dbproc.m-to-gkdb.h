/*
 * $Id: dbproc.m-to-gkdb.h,v 2.80 2013/06/17 05:34:53 young Exp $
 */
#ifndef _dbproc_mf_to_gkdb_h
#define _dbproc_mf_to_gkdb_h

#include "../../../tools/gctools/src/dbproc.m0-to-gkdb.h"
#include "FString.SplaySet.h"
#include "u_int32_t.SplaySet.h"
#include "refcol.h"
#include <set>
#include <vector>

#ifdef	VERSION56
typedef std::set<DocActivityEx> Activity;
typedef std::set<DocChDate> ChDate;
typedef std::set<DocNotSure> NotSure;
typedef std::vector<PageBreak> Pages;
typedef std::vector<ContentsStruct> ContentsToGKDF;
typedef std::vector<CompareContentsStruct> CompareContentsToGKDF;
typedef std::set<DivisionInfo> Divisions;
#endif

class NewDocument;

class CIdxShortInt;
class CIdxShortRef;
class CIdxString;
class CIdxDate;
class CIdxClass;
class CIdxPrefix;
class CIdxAdopted;
class CIdxHRefs;
class CIdxHRefsEx;
class CIdxHDocs;
class CIdxHDocsEx;
class CIdxRefDate;

class DbProcessorMtoGKDB : public DbProcessorM0toGKDB {
  protected:
	NewDocument *cdoc;

	CIdxShortInt *cidxStatus, *cidxSegment;
	CIdxShortRef *cidxStatus_ex;
	CIdxString *cidxCategory, *cidxTradeName, *cidxIntName;
	CIdxHRefsEx *cidxType, *cidxKind;
	CIdxHRefsEx *cidxServiceInfo;
	CIdxHRefsEx *cidxInpharmFirm, *cidxInpharmCountry, *cidxRegStatus;
	CIdxHRefsEx *cidxLekForm;
	CIdxHDocsEx *cidxInpharmPharmGroup;
	CIdxHDocsEx *cidxInpharmPharmEffect;
	CIdxHDocsEx *cidxAtc;
	CIdxHRefsEx *cidxInpharmMkb;
	CIdxHRefsEx *cidxInpharmChapter;
	CIdxString *cidxCode, *cidxRCode;
	CIdxDate   *cidxDate, *cidxRDate, *cidxSortDate;
	CIdxDate   *cidxVAbolished, *cidxVChanged, *cidxVIncluded;
	CIdxDate   *cidxVAnonced, *cidxVLControl;
	CIdxClass  *cidxClass;
	CIdxPrefix *cidxPrefix;
	CIdxRefDate *cidxRegDate, *cidxAnnulDate, *cidxActive;
	CIdxAdopted *cidxSource, *cidxTerritory;
	CIdxDate   *cidxCalIn, *cidxCalAb, *cidxCalCh;
	CIdxHRefsEx *cidxKeyword;
	CIdxHDocsEx *cidxPublishedIn;

	FString	*			sTopKeyName;
	RefCollection * pTopKeyRefs;

	unsigned char * attr_buf;
	unsigned long attr_buf_len;

	void FlushStr(unsigned long topic_id, unsigned short tag, FStringSplaySet& at);
	void FlushInt(unsigned long topic_id, unsigned short tag, u_int32_tSplaySet& at);
#ifdef VERSION56
	void FlushAct(unsigned long topic_id, unsigned short tag, Activity& at);
	void FlushActEx(unsigned long topic_id, unsigned short tag, Activity& at);
	void FlushChDate(unsigned long topic_id, unsigned short tag, ChDate& at);
	void FlushChDateEx(unsigned long topic_id, unsigned short tag, ChDateExes& at);
	void FlushNotSure(unsigned long topic_id, unsigned short tag, NotSure& at);
	void FlushDivisionInfo(unsigned long topic_id, unsigned short tag, Divisions& at);
#endif

	FStringSplaySet idd_name, idd_id, idd_source, idd_div, idd_key, idd_addcode;
	FStringSplaySet idd_adword, idd_serviceinfo, idd_type, idd_kind, idd_rcode, idd_warning, idd_publishedin;
	FStringSplaySet idd_casecode;
	FStringSplaySet idd_inpharmfirm, idd_inpharmcountry, idd_atc, idd_regstatus;
	FStringSplaySet idd_lekform;	
	FStringSplaySet idd_annouser, idd_annoorganization, idd_annotax, idd_annointerest, idd_annokind;
	FStringSplaySet idd_pharmgroup, idd_pharmeffect, idd_chapter, idd_mkb;
	FStringSplaySet idd_sourcefile, idd_territory, idd_dockind, idd_category;
	FStringSplaySet idd_tradename, idd_intname;
	u_int32_tSplaySet idd_date, idd_vincluded, idd_vchanged, idd_vabolished;
	u_int32_tSplaySet idd_rdate, idd_sortdate, idd_vanonced, idd_vlcontrol, idd_annodate;
	u_int32_tSplaySet idd_calin, idd_calch, idd_calab;

	std::vector<date> idd_regdate, idd_annuldate;
	std::vector<long> idd_regdatesubs, idd_annuldatesubs;
	std::vector<long> idd_lifesubs, idd_unrecipesubs, idd_allowedsubs, idd_notlifesubs, idd_notallowedsubs, idd_recipesubs;
#ifdef VERSION56
	Activity idd_activity;
	ChDate idd_chdate;
	ChDateExes idd_chdateex;
	Pages idd_pages;
	CompareContentsToGKDF idd_comparecontents;
	ContentsToGKDF idd_contents;
	NotSure idd_notsure;
	Divisions idd_divisions;
#endif

	void InitTopic();
	void Flush(unsigned long topic_id, unsigned char bIsNoDoc);

	BaseInfo *binfo;
	int16_t *cdoc_belongs;
	int cdoc_nbelongs;

	int addref2index(Index *idx,const void *key, long id,long s );
	int add2index(Index *idx, long id,const void *key );
#ifdef WITH_DBL_THREAD
	int skipBlob;
#endif
  public:
  	DbProcessorMtoGKDB(DbProcMetaHolder *m, Base *b, int debug=0 );
	void setAllCached();
	virtual ~DbProcessorMtoGKDB();
	virtual int OK();
	virtual topic_t createTopic(long id,const char *title, int title_len,
										const revision *r,int pk);
	virtual int setTopicName(topic_t tpic,const char *d,u_int32_t size);

	virtual int writeAuxAppend(const void *key, const void *d, int l);

	virtual int setTopicSubDesc(topic_t tpic, SubDesc *subsTmp, long count);
	virtual int setTopicSubDescEx(topic_t tpic, SubDescEx *subsExTmp, long count);

	virtual int setTopicInfo(topic_t tpic,DocInfo *);

	virtual int setBaseCore(u_int32_t bid, BaseCore *);

	virtual int setTopicStatus(topic_t tpic,int);
	virtual int setTopicStatus_ex(topic_t tpic,int,gdocsub_t);
	virtual int setTopicStatus_exex(topic_t tpic,int);

	virtual int setTopicResps(topic_t tpic,u_int64_t *resps,u_int32_t count);
	// count here is number of longs.
	virtual int setCorrs(u_int32_t tid,u_int64_t *corrs,u_int32_t count);
	virtual int setTopicBelongs(topic_t tpic,int16_t *resps,int count);
	// count here is number of shorts.

	virtual int addTopicVChanged(topic_t tpic, date &);
	// should set both "VChanged" index and IDD_VCHANGED in attrs.
	
	virtual int addTopicChange(topic_t t, IddChangeStruct* i);

#ifdef VERSION56
	virtual int addTopicActivity(topic_t t, const DocActivityEx& i);
	virtual int addTopicChDate(topic_t t, const DocChDate& i);
	virtual int addTopicChDateEx(topic_t t, const ChDateEx& i);
	virtual int addTopicPages(topic_t t, const PageBreak& i);
	virtual int addTopicContents( topic_t t, const ContentsStruct& i );
	virtual int addTopicCompareContents( topic_t t, const CompareContentsStruct& i );
	virtual int addTopicNotSure(topic_t t, const DocNotSure& i);
	virtual int addTopicDivision(topic_t t, const DivisionInfo& i);
#endif

	virtual int addTopicRcode(topic_t tpic, const char *, size_t );
	// should set both "RCode" index and IDD_RCODE in attrs.

	virtual int addTopicCode(topic_t tpic, const char *, size_t );
	// should set both "Number" index and IDD_ID in attrs.

	virtual int addTopicAddCode(topic_t tpic, const char *, size_t );

	virtual int setTopicCategory(topic_t tpic, const char *, size_t );
	virtual int setTopicTradeName (topic_t tpic, const char *, size_t );
	virtual int setTopicIntName (topic_t tpic, const char *, size_t );

	virtual int addTopicInpharmFirm (const char *, size_t,topic_t,gdocsub_t );
	virtual int addTopicInpharmCountry (const char *, size_t,topic_t,gdocsub_t );
	virtual int addTopicAtc (const char *, size_t,topic_t);
	virtual int addTopicRegStatus (const char *, size_t,topic_t,gdocsub_t );
	virtual int addTopicLekForm (const char *, size_t,topic_t,gdocsub_t );

	virtual int addTopicServiceInfo(const char *, size_t,topic_t,gdocsub_t );
	virtual int addTopicAdword(const char *, size_t,topic_t,gdocsub_t );
	virtual int addTopicCasecode(const char *, size_t,topic_t);

	virtual int addTopicType(const char *, size_t,topic_t,gdocsub_t );
	virtual int addTopicKind(const char *, size_t,topic_t,gdocsub_t );

	virtual int addTopicAnnoUser(const char *, size_t,topic_t );
	virtual int addTopicAnnoOrganization(const char *, size_t,topic_t );
	virtual int addTopicAnnoTax(const char *, size_t,topic_t );
	virtual int addTopicAnnoInterest(const char *, size_t,topic_t );
	virtual int addTopicAnnoKind(const char *, size_t,topic_t );

	virtual int addTopicPharmGroup (const char *, size_t,topic_t);
	virtual int addTopicPharmEffect (const char *, size_t,topic_t);
	virtual int addTopicChapter (const char *, size_t,topic_t,gdocsub_t);
	virtual int addTopicMkb (const char *, size_t,topic_t,gdocsub_t);

	virtual int addTopicSource(const char *, size_t, topic_t t );
	// should set both "Adopted" index and IDD_SOURCE in attrs.
	virtual int addTopicTerritory(const char *, size_t, topic_t t );
	// should set both "Territory" index and IDD_TERRITORY in attrs.
	virtual int setSourceAndTerritory(const char*s,size_t sl,
								  const char*t,size_t tl);

	virtual int addTopicPublishedIn(topic_t tpic, const char *, size_t );

	virtual int addTopicCalIn (topic_t tpic, date& );
	virtual int addTopicCalAb (topic_t tpic, date& );
	virtual int addTopicCalCh (topic_t tpic, date& );

	virtual int addTopicVIncluded(topic_t tpic, date& );
	// should set both "VIncluded" index and IDD_VINCLUDED in attrs.

	virtual int addTopicVAbolished(topic_t tpic, date& );
	// should set both "VAbolished" index and IDD_VABOLISHED in attrs.

	virtual int addTopicVAnonced(topic_t tpic, date& );
	// should set both "VAnonced" index and IDD_VAnonced in attrs.

	virtual int addTopicAnnoDate(topic_t tpic, date& );

	virtual int addTopicVLControl(topic_t tpic, date& );
	// should set both "VLControl" index and IDD_VLControl in attrs.

	virtual int addTopicSortDate(topic_t tpic, date& );
	// should set both "SortDate" index and IDD_SORTDATE in attrs.

	virtual int addTopicRDate(topic_t tpic, date& );
	// should set both "RDate" index and IDD_RDATE in attrs.

	virtual int addTopicRegDate(topic_t tpic, date&, gdocsub_t);
	virtual int addTopicAnnulDate(topic_t tpic, date&, gdocsub_t);

	virtual int addTopicEvd(topic_t tpic, const char* data, size_t len);
	virtual int addTopicParaHeights (topic_t tpic, const char* data, size_t len);

	virtual int addTopicDate(topic_t tpic, date& );
	// should set both "Date" index and IDD_DATE in attrs.

	virtual int setRefName(topic_t tpic, const char *n, size_t, gdocsub_t);
	// should set both "Date" index and IDD_DATE in attrs.

	virtual int addTopicPara(topic_t tpic, int s, const void *p, int len);

	virtual int addTopicEmptyPara(topic_t tpic);

	virtual int endTopic(topic_t &tpic
#ifdef PTRS_IN_META
							, u_int32_t a0=0, size_t a1= 0
#endif
							);

	virtual int addKeyWord(const char *,size_t ,const void * , size_t);

	virtual int add2ClassIndex(const char*cl,size_t l,topic_t,gdocsub_t sub);
	virtual int setClassAndPrefix(const char*c,size_t cl,
								  const char*p,size_t pl);

	virtual int add2PrefixIndex(const char*p,size_t l,topic_t,gdocsub_t sub);

	virtual int setUNode(const char *pfx, size_t pfxLen,
						 int jtype, 
						 const char *uname, size_t ul,
						 const char *cls, size_t clsl );


	virtual int setBlobData(u_int32_t blob, const void *,size_t l);
	virtual int setBlobBelongs(u_int32_t blob,int16_t *bases,int count);
	virtual int setBlobFormsBelongs(u_int32_t blob,int16_t *bases,int count);
};
#endif
