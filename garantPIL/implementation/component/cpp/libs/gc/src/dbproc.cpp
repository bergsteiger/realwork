/*
 * $Id: dbproc.cpp,v 1.58 2013/06/17 05:34:47 young Exp $
 */
#include <ctype.h>
#include <string.h>
#include "dbproc.h"

DbProcessor :: ~DbProcessor () 
{
}
DbProcessor :: DbProcessor () 
{
#ifdef WITH_DBL_THREAD
	p_ctxTextMap= p_ctxNameMap= 0;
	itemsDone = 0;
#endif
}
topic_t DbProcessor ::  createTopic(long id,const char *title,int tl,
										const revision *r,int pk)
{
	(void)id; (void)title; (void)tl; (void)r; (void)pk;
	return (topic_t) (id);
}

int DbProcessor :: setTopicName(topic_t tpic,const char *d,u_int32_t size)
{
	(void)tpic;(void)d;(void)size;
	return DB_PROC_OK;
}
int DbProcessor :: writeAuxAppend(const void *key, const void *d, int l)
{
	(void)key;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: writeAux(const void *key, const void *d, int l)
{
	(void)key;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: setTopicSubDesc(topic_t t, SubDesc  *d, long l)
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: setTopicSubDescEx(topic_t t, SubDescEx  *d, long l)
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: setTopicDocStruct (topic_t t, DocStruct *d, long l)
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: setTopicResps(topic_t t,u_int64_t *d,u_int32_t c)
{
	(void)t;(void)d;(void)c;
	return DB_PROC_OK;
}

int DbProcessor :: setCorrs(u_int32_t t,u_int64_t *d,u_int32_t c)
{
	(void)t;(void)d;(void)c;
	return DB_PROC_OK;
}

#ifdef	VERSION56
int DbProcessor :: setNewCorrs(u_int32_t t,CorrRef *d,u_int32_t c)
{
	(void)t;(void)d;(void)c;
	return DB_PROC_OK;
}

#endif

int DbProcessor :: setTopicBelongs(topic_t t,int16_t *d,int c)
{
	(void)t;(void)d;(void)c;
	return DB_PROC_OK;
}
int DbProcessor :: setTopicCategory(topic_t t, const char *c, size_t l)
{
	(void)t;(void)c;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: setTopicTradeName (topic_t t, const char *c, size_t l)
{
	(void)t;(void)c;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: setTopicIntName (topic_t t, const char *c, size_t l)
{
	(void)t;(void)c;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: add2ClassIndex(const char *c,size_t l,topic_t t,gdocsub_t s)
{
	(void)t;(void)c;(void)l;(void)s;
	return DB_PROC_OK;
}
int DbProcessor :: add2PrefixIndex(const char *c,size_t l,topic_t t,gdocsub_t s)
{
	(void)t;(void)c;(void)l;(void)s;
	return DB_PROC_OK;
}
int DbProcessor :: setClassAndPrefix(const char *c,size_t cl,
									 const char *p,size_t pl )
{
	(void)cl;(void)c;(void)p;(void)pl;
	return DB_PROC_OK;
}

int DbProcessor :: setTopicStatus(topic_t t,int d)
{
	(void)t;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: setTopicStatus_ex(topic_t t,int d, gdocsub_t sub)
{
	(void)t;(void)d;(void)sub;
	return DB_PROC_OK;
}

int DbProcessor :: setTopicStatus_exex(topic_t t,int d)
{
	(void)t;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: setBaseCore(u_int32_t bid, BaseCore *d)
{
	(void)bid;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicChange (topic_t t, IddChangeStruct* d)
{
	(void)t;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicParaHeights (topic_t t, const char* c, size_t l)
{
	(void)t;(void)c;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicDate(topic_t t,date &d)
{
	(void)t;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicEvd(topic_t t, const char* c, size_t l)
{
	(void)t;(void)c;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicRegDate(topic_t t,date &d, gdocsub_t sub)
{
	(void)t;(void)d;(void)sub;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicAnnulDate(topic_t t,date &d, gdocsub_t sub)
{
	(void)t;(void)d;(void)sub;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicRDate(topic_t t,date &d)
{
	(void)t;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicSortDate(topic_t t,date &d)
{
	(void)t;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicVAbolished(topic_t t,date &d)
{
	(void)t;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicVAnonced(topic_t t,date &d)
{
	(void)t;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicAnnoDate(topic_t t,date &d)
{
	(void)t;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicVLControl(topic_t t,date &d)
{
	(void)t;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicVIncluded(topic_t t,date &d)
{
	(void)t;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicCalIn (topic_t t,date &d)
{
	(void)t;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicCalAb (topic_t t,date &d)
{
	(void)t;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicCalCh (topic_t t,date &d)
{
	(void)t;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicVChanged(topic_t t,date &d)
{
	(void)t;(void)d;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicRcode(topic_t t,const char *d, size_t l)
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor::addTopicCode(topic_t t,const char *d, size_t l)
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor::addTopicAddCode(topic_t t,const char *d, size_t l)
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor::addTopicServiceInfo(const char *d, size_t l, topic_t t, gdocsub_t sub )
{
	(void)t;(void)d;(void)l;(void)sub;
	return DB_PROC_OK;
}

int DbProcessor::addTopicInpharmFirm (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	(void)t;(void)d;(void)l;(void)sub;
	return DB_PROC_OK;
}

int DbProcessor::addTopicInpharmCountry (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	(void)t;(void)d;(void)l;(void)sub;
	return DB_PROC_OK;
}

int DbProcessor::addTopicAdword(const char *d, size_t l, 
							  topic_t t, gdocsub_t sub )
{
	(void)t;(void)d;(void)l;(void)sub;
	return DB_PROC_OK;
}

int DbProcessor::addTopicType(const char *d, size_t l, topic_t t, gdocsub_t sub )
{
	(void)t;(void)d;(void)l;(void)sub;
	return DB_PROC_OK;
}

int DbProcessor::addTopicKind(const char *d, size_t l, topic_t t, gdocsub_t sub )
{
	(void)t;(void)d;(void)l;(void)sub;
	return DB_PROC_OK;
}

int DbProcessor::addTopicCasecode (const char *d, size_t l, topic_t t)
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor::addTopicAnnoUser(const char *d, size_t l, topic_t t )
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor::addTopicAnnoOrganization(const char *d, size_t l, topic_t t )
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor::addTopicAnnoTax(const char *d, size_t l, topic_t t )
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor::addTopicAnnoInterest(const char *d, size_t l, topic_t t )
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor::addTopicAnnoKind(const char *d, size_t l, topic_t t )
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicPublishedIn(topic_t t,const char *d, size_t l)
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicSource(const char *d, size_t l, topic_t t)
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicPharmGroup (const char *d, size_t l, topic_t t)
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicPharmEffect (const char *d, size_t l, topic_t t)
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicMkb (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	(void)t;(void)d;(void)l;(void)sub;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicChapter (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	(void)t;(void)d;(void)l;(void)sub;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicAtc (const char *d, size_t l, topic_t t)
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicRegStatus (const char *d, size_t l, topic_t t, gdocsub_t sub )
{
	(void)t;(void)d;(void)l;(void)sub;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicLekForm (const char *d, size_t l, topic_t t, gdocsub_t sub )
{
	(void)t;(void)d;(void)l;(void)sub;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicTerritory(const char *d, size_t l, topic_t t)
{
	(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}

int DbProcessor :: setSourceAndTerritory(const char *s, size_t sl, 
										 const char *t, size_t tl ) 
{
	(void)t;(void)s;(void)sl;(void)tl;
	return DB_PROC_OK;
}

int DbProcessor :: setRefName(topic_t t,const char *n, size_t l, gdocsub_t ls)
{
	(void)t;(void)n;(void)l;(void)ls;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicPara(topic_t tpic, int s, const void *p, int len)
{
	(void)tpic; (void)s; (void) p; (void)len;
	return DB_PROC_OK;
}

int DbProcessor::addKeyWord(const char *k, size_t l, const void * refs, size_t lr)
{
	(void)k; (void)l; (void)refs; (void)lr; 
	return DB_PROC_OK;
}


int DbProcessor :: setTopicInfo(topic_t tpic, DocInfo *i )
{
	(void)tpic;(void)i;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicEmptyPara(topic_t tpic )
{
	(void)tpic;
	return DB_PROC_OK;
}

#ifdef VERSION56
int DbProcessor :: addTopicActivity(topic_t tpic, const DocActivityEx& i)
{
	(void)tpic;(void)i;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicChDate(topic_t tpic, const DocChDate& i)
{
	(void)tpic;(void)i;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicChDateEx(topic_t tpic, const ChDateEx& i)
{
	(void)tpic;(void)i;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicNotSure(topic_t tpic, const DocNotSure& i)
{
	(void)tpic;(void)i;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicDivision(topic_t tpic, const DivisionInfo& i)
{
	(void)tpic;(void)i;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicPages(topic_t tpic, const PageBreak& i)
{
	(void)tpic;(void)i;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicContents(topic_t tpic, const ContentsStruct& i)
{
	(void)tpic;(void)i;
	return DB_PROC_OK;
}

int DbProcessor :: addTopicCompareContents(topic_t tpic, const CompareContentsStruct& i)
{
	(void)tpic;(void)i;
	return DB_PROC_OK;
}
#endif

int DbProcessor::addAttribute(topic_t tpic,u_int32_t t,const void *d,size_t l)
{
	(void)tpic;(void)t;(void)d;(void)l;
	return DB_PROC_OK;
}
int DbProcessor::setBlobData(u_int32_t blob, const void *d,size_t l)
{
	(void)blob;(void)d;(void)l;
	return DB_PROC_OK;
}
int DbProcessor::setBlobBelongs(u_int32_t blob,int16_t *bases,int count)
{
	(void)blob;(void)bases;(void)count;
	return DB_PROC_OK;
}
int DbProcessor::setBlobFormsBelongs(u_int32_t blob,int16_t *bases,int count)
{
	(void)blob;(void)bases;(void)count;
	return DB_PROC_OK;
}


int DbProcessor :: OK()
{
	return 1;
}

int DbProcessor::setUNode(const char *pfx, size_t pfxLen,
                                               int jtype,
                                               const char *uname, size_t ul,
                                               const char *cls, size_t clsl )
{
      (void)pfx;
      (void)pfxLen;
      (void)jtype;
      (void)uname;(void)ul;
      (void)cls; (void)clsl;
      return DB_PROC_OK;
}
