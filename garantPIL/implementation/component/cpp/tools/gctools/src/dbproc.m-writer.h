/*
 * $Id: dbproc.m-writer.h,v 2.62 2013/06/17 05:34:53 young Exp $
 */
#ifndef _dbproc_mf_writer_h
#define _dbproc_mf_writer_h

#include "../../../libs/gc/src/dbproc.h"
#include "../../../libs/gc/src/dbproc.mf.h"

class DbProcMetaHolder;

#include "QMap.hpp"

template <class Key, class Data>
class QuickStackMap: public QuickSplayMap<Key, Data> {
public:
	QuickStackMap(const Data dflt, int reAllocF= 1, int reAllocS= 0) : QuickSplayMap<Key,Data>(dflt, reAllocF, reAllocS)
	{
	}
	virtual int key_cmp (const Key& a, const Key& b) const {
		return 1;
	}
};

struct  bytesInMem
{
        int		len;
        void*	dta;
};
typedef QuickStackMap<char,bytesInMem> DocStackHeights;

class DbProcessorMWritter : public DbProcessor {
  protected:
	DbProcMetaHolder *mh;
	int status;
	DbProcMetaFile::DbProcMRecord *buf;
	size_t bufSiz;
  public:
	int para_count;
  	DbProcessorMWritter( DbProcMetaHolder *);
	virtual ~DbProcessorMWritter();
	virtual topic_t createTopic(long id,const char *title, int title_len,
										const revision *r,int pk);
	virtual int setTopicName(topic_t tpic,const char *d,u_int32_t size);

	virtual int writeAuxAppend(const void *key, const void *d, int l);
	virtual int writeAux(const void *key, const void *d, int l);

	virtual int setTopicSubDesc(topic_t tpic, SubDesc *subsTmp, long count);
	virtual int setTopicSubDescEx(topic_t tpic, SubDescEx *subsExTmp, long count);
	virtual int setTopicDocStruct (topic_t tpic, DocStruct *docstruct, long count);
	virtual int setTopicInfo(topic_t tpic,DocInfo *);

	virtual int setTopicStatus(topic_t tpic,int);
	virtual int setTopicStatus_ex(topic_t tpic,int,gdocsub_t);
	virtual int setTopicStatus_exex(topic_t tpic,int);

	virtual int setBaseCore(u_int32_t bid, BaseCore *);

	virtual int setTopicResps(topic_t tpic,u_int64_t *resps,u_int32_t count);
	// count here is number of longs.
	virtual int setCorrs(u_int32_t tid,u_int64_t *corrs,u_int32_t count);
	virtual int setTopicBelongs(topic_t tpic,int16_t *resps,int count);
	// count here is number of shorts.

	virtual int addTopicVChanged(topic_t tpic, date &);
	// should set both "VChanged" index and IDD_VCHANGED in attrs.

	virtual int addTopicChange(topic_t tpic, IddChangeStruct*);

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

	virtual int addTopicInpharmFirm (const char *, size_t,topic_t,gdocsub_t);
	virtual int addTopicInpharmCountry (const char *, size_t,topic_t,gdocsub_t);
	virtual int addTopicAtc (const char *, size_t,topic_t);
	virtual int addTopicRegStatus (const char *, size_t,topic_t,gdocsub_t);
	virtual int addTopicLekForm (const char *, size_t,topic_t,gdocsub_t);

	virtual int addTopicServiceInfo(const char *, size_t,topic_t,gdocsub_t);
	virtual int addTopicAdword(const char *, size_t,topic_t,gdocsub_t);
	virtual int addTopicCasecode(const char *, size_t,topic_t);

	virtual int addTopicType(const char *, size_t,topic_t,gdocsub_t);
	virtual int addTopicKind(const char *, size_t,topic_t,gdocsub_t);

	virtual int addTopicAnnoUser(const char *, size_t,topic_t);
	virtual int addTopicAnnoOrganization(const char *, size_t,topic_t);
	virtual int addTopicAnnoTax(const char *, size_t,topic_t);
	virtual int addTopicAnnoInterest(const char *, size_t,topic_t);
	virtual int addTopicAnnoKind(const char *, size_t,topic_t);

	virtual int addTopicPharmGroup (const char *, size_t,topic_t);
	virtual int addTopicPharmEffect (const char *, size_t,topic_t);
	virtual int addTopicChapter (const char *, size_t,topic_t,gdocsub_t);
	virtual int addTopicMkb (const char *, size_t,topic_t,gdocsub_t);

	virtual int setTopicCategory(topic_t tpic, const char *, size_t );
	virtual int setTopicTradeName (topic_t tpic, const char *, size_t );
	virtual int setTopicIntName (topic_t tpic, const char *, size_t );

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
	// should set IDD_PREANNODATE in attrs.

	virtual int addTopicVLControl(topic_t tpic, date& );
	// should set both "VLControl" index and IDD_VLControl in attrs.

	virtual int addTopicSortDate(topic_t tpic, date& );
	// should set both "SortDate" index and IDD_SORTDATE in attrs.

	virtual int addTopicRDate(topic_t tpic, date& );
	// should set both "RDate" index and IDD_RDATE in attrs.

	virtual int addTopicRegDate(topic_t tpic, date&, gdocsub_t);
	virtual int addTopicAnnulDate(topic_t tpic, date&, gdocsub_t);

	virtual int addTopicDate(topic_t tpic, date& );
	// should set both "Date" index and IDD_DATE in attrs.

	virtual int addTopicEvd(topic_t tpic, const char* data, size_t len);
	virtual int addTopicParaHeights (topic_t tpic, const char* data, size_t len);

	virtual int setRefName(topic_t tpic, const char *n, size_t, gdocsub_t);
	// should set both "Date" index and IDD_DATE in attrs.

	virtual int addTopicPara(topic_t tpic, int s, const void *p, int len);

	virtual int addTopicEmptyPara(topic_t tpic);

	virtual int endTopic(topic_t &tpic
#ifdef PTRS_IN_META
											, u_int32_t a0, size_t a1
#endif
							);

	virtual int addKeyWord(const char *key,size_t l,const void * , size_t);

	virtual int add2ClassIndex(const char*cl,size_t l,topic_t,gdocsub_t sub);
	virtual int setClassAndPrefix(const char*c,size_t cl,
								  const char*p,size_t pl);


	virtual int add2PrefixIndex(const char*p,size_t l,topic_t,gdocsub_t sub);

	virtual int setUNode(const char *pfx, size_t pfxLen,
						 int jtype, 
						 const char *uname, size_t ul,
						 const char *cls, size_t clsl );

	virtual int addAttribute(topic_t tpic,u_int32_t tag,const void*,size_t l);
	virtual int setBlobData(u_int32_t blob, const void *,size_t l);
	virtual int setBlobBelongs(u_int32_t blob,int16_t *bases,int count);
	virtual int setBlobFormsBelongs(u_int32_t blob,int16_t *bases,int count);

	virtual int OK();
protected:
	DocStackHeights *m_pDocStackHeights;
	u_int32_t DocStackHeightsVal;
#ifdef PTRS_IN_META
protected:
	void addTopicParas(topic_t t);
#endif
};
#endif
