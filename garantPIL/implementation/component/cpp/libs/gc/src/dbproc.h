/*
 * $Id: dbproc.h,v 1.64 2013/06/17 05:34:47 young Exp $
 */
#ifndef _dbproc_h
#define _dbproc_h

#include <sys/types.h>

class UnixBase;
struct revision;
struct SubDesc;
struct date;
struct DocInfo;

#include "topic_t.h"
#include "gar_defs.hpp"

typedef long gdocsub_t;

#pragma pack(1)

struct BaseCore
{
	u_int32_t splashTopic;
	u_int32_t bannerTopic;
	u_int32_t weight;
	char name[BASE_NAME_SIZE];
	char nameEng[BASE_NAME_SIZE];
	char copyright[NAME_SIZE];
};

#pragma pack()


#ifdef WITH_DBL_THREAD
	#include "../../../libs/gctx/src/u_int64_t.CtxLongSet.SplayMap.h"
	#undef	GROW_BY
	#define	GROW_BY 16
#endif

#define DB_PROC_OK  0
#define DB_PROC_ERR 1

class DbProcessor {
  public:
  	DbProcessor();
	virtual ~DbProcessor();
	virtual topic_t createTopic(long id,const char *title, int title_len,
										const revision *r,int pk);

	virtual int setTopicName(topic_t tpic,const char *d,u_int32_t size);

	virtual int writeAuxAppend(const void *key, const void *d, int l);
	virtual int writeAux(const void *key, const void *d, int l);

	virtual int setTopicSubDesc(topic_t tpic, SubDesc *subsTmp, long count);
	// should docIdxPut(me, IDD_SUBS, subsTmp,sizeof(SubDesc)*count )
	virtual int setTopicSubDescEx(topic_t tpic, SubDescEx *subsExTmp, long count);
	virtual int setTopicDocStruct (topic_t tpic, DocStruct *docstruct, long count);

	virtual int setTopicStatus(topic_t tpic,int);
	virtual int setTopicStatus_ex(topic_t tpic,int,gdocsub_t);
	virtual int setTopicStatus_exex(topic_t tpic,int);
	virtual int setTopicCategory(topic_t tpic, const char *, size_t );
	virtual int setTopicTradeName (topic_t tpic, const char *, size_t );
	virtual int setTopicIntName (topic_t tpic, const char *, size_t );

	virtual int setTopicInfo(topic_t tpic,DocInfo *);
	virtual int setBaseCore(u_int32_t bid, BaseCore *);

	virtual int setTopicResps(topic_t tpic, u_int64_t *resps, u_int32_t count);
	// count here is number of longs.
	virtual int setCorrs(u_int32_t tid,u_int64_t *corrs,u_int32_t count);
	// count here is number of corrs.
#ifdef	VERSION56
	virtual int setNewCorrs(u_int32_t tid,CorrRef *newcorrs,u_int32_t count);
#endif

	virtual int setTopicBelongs(topic_t tpic,int16_t *bases,int count);
	// count here is number of shorts.

	virtual int addTopicVChanged(topic_t tpic, date &);
	// should set both "VChanged" index and IDD_VCHANGED in attrs.
	
	virtual int addTopicRcode(topic_t tpic, const char *, size_t );
	// should set both "RCode" index and IDD_RCODE in attrs.

	virtual int addTopicChange (topic_t tpic, IddChangeStruct*);

	virtual int addTopicCode(topic_t tpic, const char *, size_t );
	// should set both "Number" index and IDD_ID in attrs.

	virtual int addTopicAddCode(topic_t tpic, const char *, size_t );

	virtual int addTopicInpharmFirm (const char *, size_t, topic_t t, gdocsub_t sub);
	virtual int addTopicInpharmCountry (const char *, size_t, topic_t t, gdocsub_t sub);

	virtual int addTopicServiceInfo(const char *, size_t, topic_t t, gdocsub_t sub );
	virtual int addTopicAdword(const char *, size_t, topic_t t, gdocsub_t sub );

	virtual int addTopicType(const char *, size_t, topic_t t, gdocsub_t sub );
	virtual int addTopicKind(const char *, size_t, topic_t t, gdocsub_t sub );

	virtual int addTopicCasecode (const char *, size_t, topic_t t);

	virtual int addTopicAnnoUser(const char *, size_t, topic_t t );
	virtual int addTopicAnnoOrganization(const char *, size_t, topic_t t );
	virtual int addTopicAnnoTax(const char *, size_t, topic_t t );
	virtual int addTopicAnnoInterest(const char *, size_t, topic_t t );
	virtual int addTopicAnnoKind(const char *, size_t, topic_t t );

	virtual int addTopicPharmGroup(const char *, size_t, topic_t t );
	virtual int addTopicPharmEffect(const char *, size_t, topic_t t );
	virtual int addTopicMkb (const char *, size_t, topic_t t, gdocsub_t sub);
	virtual int addTopicChapter(const char *, size_t, topic_t t, gdocsub_t sub);
	virtual int addTopicAtc (const char *, size_t, topic_t t);
	virtual int addTopicRegStatus (const char *, size_t, topic_t t, gdocsub_t sub);
	virtual int addTopicLekForm (const char *, size_t, topic_t t, gdocsub_t sub);

	virtual int addTopicSource(const char *, size_t, topic_t t );
	// should set both "Adopted" index and IDD_SOURCE in attrs.
	virtual int addTopicTerritory(const char *, size_t, topic_t t );
	// should set both "Territory" index and IDD_TERRITORY in attrs.
	virtual int setSourceAndTerritory(const char*s,size_t sl,
								  const char*t,size_t tl);


	virtual int addTopicPublishedIn(topic_t tpic, const char *, size_t );
	// should set both "PublishedIn" index and IDD_PUBLISHEDIN in attrs.

	virtual int addTopicVIncluded(topic_t tpic, date& );
	// should set both "VIncluded" index and IDD_VINCLUDED in attrs.

	virtual int addTopicCalIn(topic_t tpic, date& );
	virtual int addTopicCalAb(topic_t tpic, date& );
	virtual int addTopicCalCh(topic_t tpic, date& );

	virtual int addTopicVAbolished(topic_t tpic, date& );
	// should set both "VAbolished" index and IDD_VABOLISHED in attrs.

	virtual int addTopicVAnonced(topic_t tpic, date& );
	virtual int addTopicAnnoDate(topic_t tpic, date& );
	virtual int addTopicVLControl(topic_t tpic, date& );

	virtual int addTopicActivity(topic_t tpic, const DocActivityEx& i);
	virtual int addTopicChDate(topic_t tpic, const DocChDate& i);
	virtual int addTopicChDateEx(topic_t tpic, const ChDateEx& i);
	virtual int addTopicNotSure(topic_t tpic, const DocNotSure& i);
	virtual int addTopicPages(topic_t tpic, const PageBreak& i);
	virtual int addTopicContents(topic_t tpic, const ContentsStruct& i);
	virtual int addTopicCompareContents(topic_t tpic, const CompareContentsStruct& i);
	virtual int addTopicDivision(topic_t tpic, const DivisionInfo& i);

	virtual int addTopicParaHeights (topic_t tpic, const char*, size_t);

	virtual int addTopicSortDate(topic_t tpic, date& );
	// should set both "SortDate" index and IDD_SORTDATE in attrs.

	virtual int addTopicRDate(topic_t tpic, date& );
	// should set both "RDate" index and IDD_RDATE in attrs.

	virtual int addTopicDate(topic_t tpic, date& );
	// should set both "Date" index and IDD_DATE in attrs.

	virtual int addTopicEvd (topic_t tpic, const char*, size_t);

	virtual int addTopicRegDate(topic_t tpic, date&, gdocsub_t sub);
	virtual int addTopicAnnulDate(topic_t tpic, date&, gdocsub_t sub);

	virtual int setRefName(topic_t tpic, const char *n, size_t, gdocsub_t);
	// should set both "Date" index and IDD_DATE in attrs.

	virtual int addTopicPara(topic_t tpic, int s, const void *p, int len);

	virtual int addTopicEmptyPara(topic_t tpic);
	virtual int endTopic(	topic_t &tpic
#ifdef PTRS_IN_META
											, u_int32_t a0, size_t a1
#endif
							)
	{
		tpic = 0;
		return DB_PROC_OK;
	}
	virtual int addKeyWord(const char *key,size_t l,const void * , size_t);
	// should set 2 keys in "KeyWord" index and IDD_KEY once.

	virtual int add2ClassIndex(const char*cl,size_t l,topic_t,gdocsub_t sub);
	virtual int setClassAndPrefix(const char*c,size_t cl,
								  const char*p,size_t pl);
	virtual int add2PrefixIndex(const char*p,size_t l,topic_t,gdocsub_t sub);

	virtual int setUNode(const char *pfx, size_t pfxLen,
						 int jtype, 
						 const char *uname, size_t ul,
						 const char *cls, size_t clsl );

	virtual int addAttribute(topic_t, u_int32_t tag, const void *,size_t l);
	virtual int setBlobData(u_int32_t blob, const void *,size_t l);
	virtual int setBlobBelongs(u_int32_t blob,int16_t *bases,int count);
	virtual int setBlobFormsBelongs(u_int32_t blob,int16_t *bases,int count);

	virtual int OK();
#ifdef WITH_DBL_THREAD
	DocInfo *pInfo;
	u_int64_tCtxLongSetSplayMap *p_ctxTextMap;
	u_int64_tCtxLongSetSplayMap *p_ctxNameMap;

	int				lastParaStyle;
	unsigned long	itemsDone;

	char	   buf128[128];
	int at_f;
	long *tp;
	const char* src;
	unsigned len0;
	CtxLongSet *sp;
	long para_count;
#endif
};
#endif
