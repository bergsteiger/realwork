#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: dbproc.m-writer.cpp,v 2.90 2013/06/17 05:34:53 young Exp $
 */
#include <cctype>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <cerrno>
#include <cstdlib>
//#include <unistd.h>
#include <cstring>

#include "dbproc.m-writer.h"
#include "dbproc.mh.h"
#include "recode.h"
#ifdef PTRS_IN_META
	#include "pack.h"
#endif

extern	bool	b5Context;

#undef CHECKBUF
#define CHECKBUF(l) if(bufSiz < (l)){ \
			bufSiz = (l); \
			if(buf) free(buf); \
			buf = (DbProcMetaFile::DbProcMRecord*) \
				malloc(bufSiz+sizeof(DbProcMetaHolder::DbProcMRecord)); \
		}
#undef MAKEDATAPTR
#define MAKEDATAPTR(a,t,d,ptr) \
		CHECKBUF(sizeof(t)+d+sizeof(DbProcMetaHolder::DbProcMRecord)); \
		buf->action = a; \
		buf->recSize = sizeof(t)+d+sizeof(DbProcMetaHolder::DbProcMRecord); \
		t *ptr = (t *)(buf+1);


#undef MAKECHARDATAPTR
#define MAKECHARDATAPTR(po) ((char*)((po)+1))

#undef SETRECORDDATA
#define SETRECORDDATA(p,d,dl) memcpy(MAKECHARDATAPTR(p),(d),(dl))


#ifdef WITH_DBL_THREAD
	#include "stdbase.h"
	#include "newdoc.h"
	#include "u_int64_t.CtxLongSet.SplayMap.h"
	extern unsigned getParaWord(char *, const char **, unsigned &, int *);
	extern void flushIt(	Base *, u_int64_tCtxLongSetSplayMap &, char *);
#endif

DbProcessorMWritter :: ~DbProcessorMWritter () 
{
	addTopicParaHeights (0, 0, 0);
	if( buf) free(buf);
}
DbProcessorMWritter :: DbProcessorMWritter (DbProcMetaHolder *m):
	buf(0), bufSiz(0), m_pDocStackHeights(0)
{
    status = 0;
    mh = m;
    CHECKBUF( 4096 );
}
topic_t DbProcessorMWritter ::  createTopic(long id,const char *title,int tl,
										const revision *r,int pk)
{
	MAKEDATAPTR( DbProcMetaFile::createTopic, 
				DbProcMetaFile::CreateTopicData, tl, dptr );
	para_count = 0;
	/*if(id == 100001){
		printf("Take DEBUG !!");
		getch();
	}*/
	dptr->docid = id;
	dptr->pk = pk;
	dptr->title_len = tl;
	dptr->rv = *r;
	SETRECORDDATA(dptr,title,tl);
	mh->write(buf);
	return (topic_t) id;
}

int DbProcessorMWritter :: setTopicName(topic_t tpic,const char *d,
			u_int32_t size)
{
	MAKEDATAPTR( DbProcMetaFile::setTopicName, DbProcMetaFile::SetTopicData, size, dptr );
	dptr->docid = tpic;
	dptr->datalen = size;
#ifdef WITH_DBL_THREAD
  #ifdef MIN_MEM_CONTEXT
	if ( b5Context && p_ctxNameMap && ( pInfo->Status & ( DS_DOC|DS_EDITION ))) {
		at_f = 0;
		src= d;
		len0 = size;
		while ( *(u_int64_t*)buf128=0, getParaWord(buf128, &src, len0, &at_f) ){
			sp = &(*p_ctxNameMap)[*(u_int64_t*)buf128];
			if( (topic_t)sp->lastElemV != tpic ){
				if( sp->lastI >= sp->capacity ){
					sp->capacity += GROW_BY;
					sp->e=(long*)realloc(sp->e,sizeof(long)*sp->capacity);
					if( !sp->e ){
						printf("\nNo memory!\n");
						exit(1);
					}
					itemsDone++;
				}
				sp->e[sp->lastI++] = tpic;
				sp->lastElemV = tpic;
			}
		}
	}
  #endif
#endif
	SETRECORDDATA(dptr, d, size );
	return mh->write(buf);
}
int DbProcessorMWritter::writeAuxAppend(const void *key,const void *d,int l)
{
	MAKEDATAPTR( DbProcMetaFile::writeAuxAppend, 
				DbProcMetaFile::WriteAux, l, dptr );
	dptr->dataLength =l;
	memcpy(dptr->key, key, 5 );
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter::setBaseCore(u_int32_t bid, BaseCore * d)
{
	MAKEDATAPTR( DbProcMetaFile::setBaseCore, 
				DbProcMetaFile::SetBaseData, sizeof(BaseCore), dptr );
	dptr->bid = bid;
	dptr->datalen = sizeof(BaseCore);
	SETRECORDDATA(dptr, d, sizeof(BaseCore) );
	return mh->write(buf);
}
int DbProcessorMWritter::writeAux(const void *key,const void *d,int l)
{
	MAKEDATAPTR( DbProcMetaFile::writeAux, 
				DbProcMetaFile::WriteAux, l, dptr );
	dptr->dataLength =l;
	memcpy(dptr->key, key, 5 );
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: setTopicSubDesc(topic_t t, SubDesc  *d, long l)
{
	l *= sizeof(SubDesc);
	MAKEDATAPTR( DbProcMetaFile::setTopicSubDesc, DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen = l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: setTopicSubDescEx (topic_t t, SubDescEx *d, long l)
{
	l *= sizeof(SubDescEx);

	MAKEDATAPTR( DbProcMetaFile::setTopicSubDescEx, DbProcMetaFile::SetTopicData, l, dptr);
	dptr->docid = t;
	dptr->datalen = l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

#ifdef PTRS_IN_META
	extern unsigned char *paraFinalBuf, *exportBuf;

	#pragma pack(1)
		struct expBlk{
			int PrsBlk;
			size_t valPtr;
		};
	#pragma pack()

	void DbProcessorMWritter::addTopicParas(topic_t t)
	{
  #ifdef PTRS_ONLY
		MAKEDATAPTR( DbProcMetaFile::addTopicPara, 
					DbProcMetaFile::AddTopicPara, sizeof(expBlk), dptr );
		dptr->docid = t;
		dptr->style = u_int32_t((paraFinalBuf-3-exportBuf) & 0x7fffffff);
		//size_t qqq= sizeof(BlockHeader);
		*(int*)(exportBuf+ADD_BLOCK_SIZE+1020)= (int)G_ZIP((char*)exportBuf, dptr->style, (char*)exportBuf+ADD_BLOCK_SIZE+1024+7/*qqq*/, dptr->style);
		exportBuf= (unsigned char *)malloc(ADD_BLOCK_SIZE+ADD_BLOCK_SIZE+1024);
		if(!exportBuf)
			dptr->datalen= sizeof(expBlk);
		dptr->datalen= sizeof(expBlk);
		{
			expBlk tmpExp;
			tmpExp.PrsBlk= para_count;
			tmpExp.valPtr= (size_t)exportBuf;
			SETRECORDDATA(dptr, &tmpExp, sizeof(expBlk));
		}
  #else
		MAKEDATAPTR( DbProcMetaFile::addTopicPara, 
					DbProcMetaFile::SetRefData, (ADD_BLOCK_SIZE+11), dptr );
		dptr->docid= t;
		dptr->sub= u_int32_t(para_count&0x7fffffff);

		t= u_int32_t((paraFinalBuf-3-exportBuf) & 0x7fffffff);
		dptr[1].docid = t;
		dptr->datalen= G_ZIP((char*)exportBuf, t, 7+(char*)(&(dptr[1].sub)), t);
		if(dptr->datalen < 1 || dptr->datalen >= t){
			memcpy(7+(char*)(&(dptr[1].sub)),exportBuf,t);
			dptr->datalen= t;
		}
		dptr->datalen += 23;
		buf->recSize= dptr->datalen + 8;
  #endif
		mh->write(buf);
		*(ACE_UINT64*)(exportBuf+3)= *(ACE_UINT64*)paraFinalBuf;
		paraFinalBuf= exportBuf+3;
	}
#endif

int DbProcessorMWritter :: setTopicDocStruct (topic_t t, DocStruct *d, long l)
{
	l *= sizeof (DocStruct);
#ifndef PTRS_IN_META
	MAKEDATAPTR( DbProcMetaFile::setTopicDocStruct, DbProcMetaFile::SetTopicData, l, dptr);
	dptr->docid = t;
	dptr->datalen = l;
	if(l > 32*1024*1024){
fprintf(stderr, "\n ERROR size Big !!!");
getch();
	}
	SETRECORDDATA(dptr, d, l );
#else
  #ifdef PTRS_ONLY
	MAKEDATAPTR( DbProcMetaFile::setTopicDocStruct, DbProcMetaFile::SetTopicData, sizeof(expBlk), dptr);
	dptr->docid = t;
	dptr->datalen = sizeof(expBlk);
	{
		expBlk tmpExp;
		tmpExp.PrsBlk= l;
		tmpExp.valPtr= (size_t)d;
		SETRECORDDATA(dptr, &tmpExp, sizeof(expBlk));
	}
  #else
	MAKEDATAPTR( DbProcMetaFile::setTopicDocStruct, DbProcMetaFile::SetTopicData, l, dptr);
	dptr->docid = t;
	dptr->datalen = l;
	if(l > 32*1024*1024){
fprintf(stderr, "\n ERROR size Big !!!");
getch();
	}
	SETRECORDDATA(dptr, d, l );
  #endif
#endif
	return mh->write(buf);
}

int DbProcessorMWritter :: setTopicStatus(topic_t t, int s)
{
	MAKEDATAPTR( DbProcMetaFile::setTopicStatus, 
				DbProcMetaFile::SetTopicStatus, 0, dptr );
	dptr->docid = t;
	dptr->status = s;
	return mh->write(buf);
}

int DbProcessorMWritter :: setTopicStatus_ex(topic_t t, int s,gdocsub_t sub)
{
	MAKEDATAPTR( DbProcMetaFile::setTopicStatus_ex, DbProcMetaFile::SetTopicStatus_ex, 0, dptr );
	dptr->docid = t;
	dptr->sub = sub;
	dptr->status = s;
	return mh->write(buf);
}

int DbProcessorMWritter :: setTopicStatus_exex(topic_t t, int s)
{
	MAKEDATAPTR( DbProcMetaFile::setTopicStatus_exex, DbProcMetaFile::SetTopicStatus_exex, 0, dptr );
	dptr->docid = t;
	dptr->status = s;
	return mh->write(buf);
}

int DbProcessorMWritter :: setTopicInfo(topic_t t,DocInfo *d)
{
	MAKEDATAPTR( DbProcMetaFile::setTopicInfo, DbProcMetaFile::SetTopicData, sizeof(DocInfo), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(DocInfo);
	SETRECORDDATA(dptr, d, sizeof(DocInfo) );
	return mh->write(buf);
}

int DbProcessorMWritter :: setCorrs(u_int32_t t,u_int64_t *d,u_int32_t c)
{
	c *= sizeof(u_int64_t);
	MAKEDATAPTR( DbProcMetaFile::setCorrs, 
				DbProcMetaFile::SetTopicData, c, dptr );
	dptr->docid = t;
	dptr->datalen =c;
	SETRECORDDATA(dptr, d, c );
	return mh->write(buf);
}

int DbProcessorMWritter :: setTopicResps(topic_t t,u_int64_t *d,u_int32_t c)
{
	c *= sizeof(u_int64_t);
	MAKEDATAPTR( DbProcMetaFile::setTopicResps, 
				DbProcMetaFile::SetTopicData, c, dptr );
	dptr->docid = t;
	dptr->datalen =c;
	SETRECORDDATA(dptr, d, c );
	return mh->write(buf);
}

int DbProcessorMWritter :: setTopicBelongs(topic_t t,int16_t *d,int c)
{
	c *= sizeof(int16_t);
	MAKEDATAPTR( DbProcMetaFile::setTopicBelongs, 
				DbProcMetaFile::SetTopicData, c, dptr );
	dptr->docid = t;
	dptr->datalen =c;
	SETRECORDDATA(dptr, d, c );
	return mh->write(buf);
}

int DbProcessorMWritter :: addAttribute(topic_t t, u_int32_t tg,
	const void *d, size_t l)
{
	if(t <= 100000l)
		return 0;

	MAKEDATAPTR( DbProcMetaFile::addAttribute, 
				DbProcMetaFile::SetTopicAttribute, l, dptr );
	dptr->docid = t;
	dptr->tag = tg;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}


int DbProcessorMWritter :: setClassAndPrefix(const char *c,	size_t cl,
											 const char *p, size_t pl)
{
	MAKEDATAPTR( DbProcMetaFile::setClassAndPrefix, 
				DbProcMetaFile::Set2StringsData, cl+pl, dptr );
	dptr->len1 =cl;
	dptr->len2 =pl;
	memcpy(MAKECHARDATAPTR(dptr), c, cl );
	memcpy(MAKECHARDATAPTR(dptr) + cl, p, pl );
	return mh->write(buf);
}


int DbProcessorMWritter :: add2PrefixIndex(const char *c, size_t l,
								   topic_t t, gdocsub_t s)
{
	MAKEDATAPTR( DbProcMetaFile::add2PrefixIndex, 
				DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->sub = s;
	dptr->datalen =l;
	SETRECORDDATA(dptr, c, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: setUNode(const char *pfx, size_t pfxl,
						 int jtype, 
						 const char *uname, size_t ul,
						 const char *cls, size_t clsl )
{
	MAKEDATAPTR( DbProcMetaFile::setUNode, 
				DbProcMetaFile::SetUNodeData, pfxl+ul+clsl, dptr );
	dptr->pfx_l =pfxl;
	dptr->uname_l =ul;
	dptr->cls_l = clsl;
	dptr->jtype = jtype;
	memcpy(MAKECHARDATAPTR(dptr), pfx, pfxl );
	memcpy(MAKECHARDATAPTR(dptr) + pfxl, uname,  ul);
	memcpy(MAKECHARDATAPTR(dptr) + pfxl +ul , cls,  clsl);
	return mh->write(buf);
}



int DbProcessorMWritter :: add2ClassIndex(const char *c, size_t l,
						topic_t t, gdocsub_t s)
{
	MAKEDATAPTR( DbProcMetaFile::add2ClassIndex, 
				DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->sub = s;
	dptr->datalen =l;
	SETRECORDDATA(dptr, c, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicDate(topic_t t,date &d)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicDate, 
				DbProcMetaFile::SetTopicData, sizeof(date), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(date);
	SETRECORDDATA(dptr, &d, sizeof(date) );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicRegDate(topic_t t,date &d, gdocsub_t s)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicRegDate, DbProcMetaFile::SetRefData, sizeof(date), dptr );
	dptr->docid = t;
	dptr->sub = s;
	dptr->datalen =sizeof(date);
	SETRECORDDATA(dptr, &d, sizeof(date));
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicEvd (topic_t t, const char* data, size_t l)
{
#ifndef PTRS_IN_META
	MAKEDATAPTR( DbProcMetaFile::addTopicEvd, DbProcMetaFile::SetTopicData, l, dptr);
	dptr->docid = t;
	dptr->datalen = l;
	SETRECORDDATA(dptr, data, l );
#else
  #ifdef PTRS_ONLY
	MAKEDATAPTR( DbProcMetaFile::addTopicEvd, DbProcMetaFile::SetTopicData, sizeof(expBlk), dptr);
	dptr->docid = t;
	dptr->datalen = sizeof(expBlk);
	{
		expBlk tmpExp;
		tmpExp.PrsBlk= l;
		void *ptrOut= malloc(l);
		memcpy(ptrOut, data, l);
		tmpExp.valPtr= (size_t)ptrOut;
		SETRECORDDATA(dptr, &tmpExp, sizeof(expBlk));
	}
  #else
	MAKEDATAPTR( DbProcMetaFile::addTopicEvd, DbProcMetaFile::SetTopicData, l, dptr);
	dptr->docid = t;
	dptr->datalen = l;
	SETRECORDDATA(dptr, data, l );
  #endif
#endif
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicParaHeights (topic_t tt, const char* data, size_t l)
{
	static bytesInMem GbytesInMem= {0,0};
	if(m_pDocStackHeights){
		if(DocStackHeightsVal != tt){
			G_Point t;
			size_t ll=0;
			char *datadata;
			for(t= m_pDocStackHeights->first(); t ; m_pDocStackHeights->next(t)){
				ll += m_pDocStackHeights->contents(t).len;
			}
			char *pnxt= (datadata= new char[ll]);
			for(t= m_pDocStackHeights->first(); t ; m_pDocStackHeights->next(t)){
				memcpy(pnxt, m_pDocStackHeights->contents(t).dta, m_pDocStackHeights->contents(t).len);
				pnxt += m_pDocStackHeights->contents(t).len;
				delete [](m_pDocStackHeights->contents(t).dta);
			}
			delete m_pDocStackHeights;
			MAKEDATAPTR( DbProcMetaFile::addTopicParaHeights, DbProcMetaFile::SetTopicData, ll, dptr);
			dptr->docid = DocStackHeightsVal;
			DocStackHeightsVal= tt;
			dptr->datalen = ll;
			SETRECORDDATA(dptr, datadata, ll );
			mh->write(buf);
			delete []datadata;
			if(!tt)
				return 0;
			m_pDocStackHeights= new DocStackHeights(GbytesInMem);
		}
	}else{
		if(!tt)
			return 0;
		m_pDocStackHeights= new DocStackHeights(GbytesInMem);
		DocStackHeightsVal= tt;
	}
	m_pDocStackHeights->get(*(char*)m_pDocStackHeights);
	char *pp= new char[l];
	memcpy(pp,data,l);
	m_pDocStackHeights->contents(m_pDocStackHeights->GetRootG_SimpleSplayNode()).len= l;
	m_pDocStackHeights->contents(m_pDocStackHeights->GetRootG_SimpleSplayNode()).dta= pp;
	return l;
}

int DbProcessorMWritter :: addTopicAnnulDate(topic_t t,date &d, gdocsub_t s)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicAnnulDate, DbProcMetaFile::SetRefData, sizeof(date), dptr );
	dptr->docid = t;
	dptr->sub = s;
	dptr->datalen =sizeof(date);
	SETRECORDDATA(dptr, &d, sizeof(date));
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicRDate(topic_t t,date &d)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicRDate, 
				DbProcMetaFile::SetTopicData, sizeof(date), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(date);
	SETRECORDDATA(dptr, &d, sizeof(date) );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicSortDate(topic_t t,date &d)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicSortDate, 
				DbProcMetaFile::SetTopicData, sizeof(date), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(date);
	SETRECORDDATA(dptr, &d, sizeof(date) );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicVAbolished(topic_t t,date &d)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicVAbolished, 
				DbProcMetaFile::SetTopicData, sizeof(date), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(date);
	SETRECORDDATA(dptr, &d, sizeof(date) );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicVAnonced(topic_t t,date &d)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicVAnonced, 
				DbProcMetaFile::SetTopicData, sizeof(date), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(date);
	SETRECORDDATA(dptr, &d, sizeof(date) );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicAnnoDate(topic_t t,date &d)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicAnnoDate, 
				DbProcMetaFile::SetTopicData, sizeof(date), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(date);
	SETRECORDDATA(dptr, &d, sizeof(date) );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicVLControl(topic_t t,date &d)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicVLControl, 
				DbProcMetaFile::SetTopicData, sizeof(date), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(date);
	SETRECORDDATA(dptr, &d, sizeof(date) );
	return mh->write(buf);
}
int DbProcessorMWritter :: addTopicVIncluded(topic_t t,date &d)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicVIncluded, 
				DbProcMetaFile::SetTopicData, sizeof(date), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(date);
	SETRECORDDATA(dptr, &d, sizeof(date) );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicCalIn (topic_t t,date &d)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicCalIn, DbProcMetaFile::SetTopicData, sizeof(date), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(date);
	SETRECORDDATA(dptr, &d, sizeof(date) );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicCalAb (topic_t t,date &d)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicCalAb, DbProcMetaFile::SetTopicData, sizeof(date), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(date);
	SETRECORDDATA(dptr, &d, sizeof(date) );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicCalCh (topic_t t,date &d)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicCalCh, DbProcMetaFile::SetTopicData, sizeof(date), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(date);
	SETRECORDDATA(dptr, &d, sizeof(date) );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicVChanged(topic_t t,date &d)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicVChanged, 
				DbProcMetaFile::SetTopicData, sizeof(date), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(date);
	SETRECORDDATA(dptr, &d, sizeof(date) );
	return mh->write(buf);
}

int DbProcessorMWritter :: setTopicCategory(topic_t t,const char *d, size_t l)
{
	MAKEDATAPTR( DbProcMetaFile::setTopicCategory, 
				DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: setTopicTradeName (topic_t t,const char *d, size_t l)
{
	MAKEDATAPTR( DbProcMetaFile::setTopicTradeName, DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: setTopicIntName (topic_t t,const char *d, size_t l)
{
	MAKEDATAPTR( DbProcMetaFile::setTopicIntName, DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicRcode(topic_t t,const char *d, size_t l)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicRcode, 
				DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicCode(topic_t t,const char *d, size_t l)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicCode, 
				DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicAddCode(topic_t t,const char *d, size_t l)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicAddCode, DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicServiceInfo(const char *d, size_t l, 
										topic_t t, gdocsub_t sub)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicServiceInfo, 
				DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->sub = sub;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicInpharmFirm (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicInpharmFirm, DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->sub = sub;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicAtc (const char *d, size_t l, topic_t t)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicAtc, DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicRegStatus (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicRegStatus, DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->sub = sub;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicLekForm (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicLekForm, DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->sub = sub;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicInpharmCountry (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicInpharmCountry, DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->sub = sub;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicAdword(const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicAdword, DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->sub = sub;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicCasecode(const char *d, size_t l, topic_t t)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicCasecode, DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicType(const char *d, size_t l, 
										topic_t t, gdocsub_t sub)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicType, 
				DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->sub = sub;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicKind(const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicKind, DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->sub = sub;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicAnnoUser(const char *d, size_t l, topic_t t)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicAnnoUser, DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicPharmGroup (const char *d, size_t l, topic_t t)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicPharmGroup, DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicPharmEffect (const char *d, size_t l, topic_t t)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicPharmEffect, DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicMkb (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicMkb, DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->sub = sub;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicChapter (const char *d, size_t l, topic_t t, gdocsub_t sub)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicChapter, DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->sub = sub;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicAnnoOrganization(const char *d, size_t l, topic_t t)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicAnnoOrganization, DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicAnnoTax(const char *d, size_t l, topic_t t)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicAnnoTax, DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicAnnoInterest(const char *d, size_t l, topic_t t)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicAnnoInterest, DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicAnnoKind(const char *d, size_t l, topic_t t)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicAnnoKind, DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter::addTopicPublishedIn(topic_t t,const char *d,size_t l)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicPublishedIn, 
				DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter::addTopicChange(topic_t t, IddChangeStruct* i)
{
	int l = sizeof (IddChangeStruct);
	MAKEDATAPTR( DbProcMetaFile::addTopicChange, DbProcMetaFile::SetTopicData, l, dptr);
	dptr->docid = t;
	dptr->datalen = l;
	SETRECORDDATA(dptr, i, l );
	return mh->write (buf);
}


#ifdef VERSION56
int DbProcessorMWritter::addTopicActivity(topic_t t, const DocActivityEx& i)
{
	size_t ds=sizeof(i.from)+sizeof(i.to)+sizeof(i.b_add_iddactive)+sizeof(i.block);
	size_t l=ds+1;
	if (i.text) l+=strlen(i.text);
	MAKEDATAPTR( DbProcMetaFile::addTopicActivity, DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;

	char* p=MAKECHARDATAPTR(dptr);
	memcpy(p, &i, ds);
	p+=ds;
	*p='\0';
	if (i.text) strcpy(p, i.text);

	return mh->write(buf);
}

int DbProcessorMWritter::addTopicNotSure(topic_t t, const DocNotSure& i)
{
#ifdef	VERSION61
	size_t ds=sizeof(i.from)+sizeof(i.to);
	size_t l=ds+1;
	if (i.text) l+=strlen(i.text);
	MAKEDATAPTR( DbProcMetaFile::addTopicNotSure, 
				DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;

	char* p=MAKECHARDATAPTR(dptr);
	memcpy(p, &i, ds);
	p+=ds;
	*p='\0';
	if (i.text) strcpy(p, i.text);

	return mh->write(buf);
#else
	MAKEDATAPTR( DbProcMetaFile::addTopicNotSure, 
				DbProcMetaFile::SetTopicData, sizeof(DocNotSure), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(DocNotSure);
	SETRECORDDATA(dptr, &i, sizeof(DocNotSure) );
	return mh->write(buf);
#endif
}

int DbProcessorMWritter::addTopicChDate(topic_t t, const DocChDate& i)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicChDate, 
				DbProcMetaFile::SetTopicData, sizeof(DocChDate), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(DocChDate);
	SETRECORDDATA(dptr, &i, sizeof(DocChDate) );
	return mh->write(buf);
}

int DbProcessorMWritter::addTopicChDateEx(topic_t t, const ChDateEx& i)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicChDateEx, 
				DbProcMetaFile::SetTopicData, sizeof(ChDateEx), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(ChDateEx);
	SETRECORDDATA(dptr, &i, sizeof(ChDateEx) );
	return mh->write(buf);
}

int DbProcessorMWritter::addTopicDivision(topic_t t, const DivisionInfo& i)
{
	size_t ds=sizeof(i.Para)+sizeof(i.Symbol);
	size_t l=ds+1;
	if (i.Params) l+=strlen(i.Params);
	MAKEDATAPTR( DbProcMetaFile::addTopicDivision, DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;

	char* p=MAKECHARDATAPTR(dptr);
	memcpy(p, &i, ds);
	p+=ds;
	*p='\0';
	if (i.Params) strcpy(p, i.Params);

	return mh->write(buf);
}

int DbProcessorMWritter::addTopicPages(topic_t t, const PageBreak& i)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicPages, 
				DbProcMetaFile::SetTopicData, sizeof(PageBreak), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(PageBreak);
	SETRECORDDATA(dptr, &i, sizeof(PageBreak) );
	return mh->write(buf);
}

int DbProcessorMWritter::addTopicContents(topic_t t, const ContentsStruct& i)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicContents, DbProcMetaFile::SetTopicData, sizeof(ContentsStruct), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(ContentsStruct);
	SETRECORDDATA(dptr, &i, sizeof(ContentsStruct) );
	return mh->write(buf);
}

int DbProcessorMWritter::addTopicCompareContents(topic_t t, const CompareContentsStruct& i)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicCompareContents, DbProcMetaFile::SetTopicData, sizeof(CompareContentsStruct), dptr );
	dptr->docid = t;
	dptr->datalen =sizeof(CompareContentsStruct);
	SETRECORDDATA(dptr, &i, sizeof(CompareContentsStruct) );
	return mh->write(buf);
}
#endif

int DbProcessorMWritter :: addTopicSource(const char *d,size_t l,topic_t t)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicSource, 
				DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}


int DbProcessorMWritter::setBlobData(u_int32_t blob, const void *d,size_t l)
{
	MAKEDATAPTR( DbProcMetaFile::setBlobData, 
				DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = blob;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter::setBlobBelongs(u_int32_t t,int16_t *d,int c)
{
	c *= sizeof(int16_t);
	MAKEDATAPTR( DbProcMetaFile::setBlobBelongs, DbProcMetaFile::SetTopicData, c, dptr );
	dptr->docid = t;
	dptr->datalen =c;
	SETRECORDDATA(dptr, d, c );
	return mh->write(buf);
}

int DbProcessorMWritter::setBlobFormsBelongs(u_int32_t t,int16_t *d,int c)
{
	c *= sizeof(int16_t);
	MAKEDATAPTR( DbProcMetaFile::setBlobFormsBelongs, DbProcMetaFile::SetTopicData, c, dptr );
	dptr->docid = t;
	dptr->datalen =c;
	SETRECORDDATA(dptr, d, c );
	return mh->write(buf);
}



int DbProcessorMWritter::addTopicTerritory(const char*d,size_t l,topic_t t)
{
	MAKEDATAPTR( DbProcMetaFile::addTopicTerritory, 
				DbProcMetaFile::SetTopicData, l, dptr );
	dptr->docid = t;
	dptr->datalen =l;
	SETRECORDDATA(dptr, d, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: setSourceAndTerritory(const char *s,	size_t sl,
											 const char *t, size_t tl)
{
	MAKEDATAPTR( DbProcMetaFile::setSourceAndTerritory, 
				DbProcMetaFile::Set2StringsData, sl+tl, dptr );
	dptr->len1 =sl;
	dptr->len2 =tl;
	memcpy(MAKECHARDATAPTR(dptr), s, sl );
	memcpy(MAKECHARDATAPTR(dptr) + sl, t, tl );
	return mh->write(buf);
}


int DbProcessorMWritter::setRefName(topic_t t,const char *n,
						size_t l,gdocsub_t s)
{
	MAKEDATAPTR( DbProcMetaFile::setRefName, 
				DbProcMetaFile::SetRefData, l, dptr );
	dptr->docid = t;
	dptr->sub = s;
	dptr->datalen =l;
	SETRECORDDATA(dptr, n, l );
	return mh->write(buf);
}

int DbProcessorMWritter :: addTopicPara(topic_t t, int s, 
						const void *p, int len)
{
#ifdef PTRS_IN_META
	ACE_UINT64 hdr= *(ACE_UINT64*)paraFinalBuf;

	if(((paraFinalBuf-3) - exportBuf) + (len+3) >= (ADD_BLOCK_SIZE - sizeof ( BlockHeader ))){
		void *pTmp= alloca(len);
		memcpy(pTmp, paraFinalBuf, len);
		addTopicParas(t);
		memcpy(paraFinalBuf, pTmp, len);
	}
	para_count++;
	*(paraFinalBuf-3)= s;
	*(short*)(paraFinalBuf-2)= short(len & 0x7fff);
	paraFinalBuf += len + 3;

	*(ACE_UINT64*)paraFinalBuf= hdr;
	return 1;
#else
	MAKEDATAPTR( DbProcMetaFile::addTopicPara, 
				DbProcMetaFile::AddTopicPara, len, dptr );
	dptr->docid = t;
	dptr->style = s;
 #ifdef WITH_DBL_THREAD
  #ifdef MIN_MEM_CONTEXT
	if( b5Context && pInfo->Status & ( DS_DOC|DS_EDITION )) {
	 if(p_ctxTextMap){
	  // in Context //
	  at_f = 0;
	  src= (char*)p+ *(short*)p - 3;
	  len0=	len - *(short*)p + 3;
	  while ( *(u_int64_t*)buf128=0, getParaWord(buf128, &src, len0, &at_f) ){
		#if CTX_WORD_SIZE == 5 && BYTEORDER == 1234
			*(u_int64_t*)buf128 &= 0x000000ffffffffffULL;
		#elif CTX_WORD_SIZE ==8
			// no mask
		#else
			#error dont know how to handle (specify mask) :)
		#endif
		sp = &(*p_ctxTextMap)[*(u_int64_t*)buf128];
		if( (u_int32_t)sp->lastElemV != t ){
			if( sp->lastI >= sp->capacity ){
				sp->capacity += GROW_BY;
				sp->e=(long*)realloc(sp->e,sizeof(long)*sp->capacity);
				if( !sp->e ){
					printf("\nNo memory!\n");
					exit(1);
				}
				itemsDone++;
			}
			sp->e[sp->lastI++] = t;
			sp->lastElemV = t;
		}
	  }
	 }else{
		 dptr->style = s | 0x2000;
	 }
	}
  #endif
 #endif
	dptr->datalen =len;
	SETRECORDDATA(dptr, p, len );
	return mh->write(buf);
#endif
}

int DbProcessorMWritter :: addTopicEmptyPara(topic_t t )
{
#ifdef PTRS_IN_META
	ACE_UINT64 hdr= *(ACE_UINT64*)paraFinalBuf;
	if(((paraFinalBuf-3) - exportBuf) + 8 >= (ADD_BLOCK_SIZE - sizeof ( BlockHeader ))){
		addTopicParas(t);
	}
	para_count++;
	*(paraFinalBuf-3)= PS_PREFORMATTED;
	*(short*)(paraFinalBuf-2)= 5;
	*paraFinalBuf= 8;
	*(int*)(paraFinalBuf+1)= 0;
	paraFinalBuf += 8;

	*(ACE_UINT64*)paraFinalBuf= hdr;
	return 1;
#else
	MAKEDATAPTR( DbProcMetaFile::addTopicEmptyPara, topic_t, 0, dptr );
	*dptr = t;
	return mh->write(buf);
#endif
}

int DbProcessorMWritter::addKeyWord(const char *k, size_t l, 
			const void * refs, size_t lr)
{
	MAKEDATAPTR( DbProcMetaFile::addKeyWord, 
				DbProcMetaFile::Set2StringsData, l+lr, dptr );
	dptr->len1 =l;
	dptr->len2 =lr;
	memcpy(MAKECHARDATAPTR(dptr), k, l );
	memcpy(MAKECHARDATAPTR(dptr) + l, refs, lr );
	return mh->write(buf);
}

int DbProcessorMWritter :: endTopic(topic_t &t
#ifdef PTRS_IN_META
											, u_int32_t a0, size_t/*a1*/
#endif
							)
{
#ifdef PTRS_IN_META
  #ifdef PTRS_ONLY
	MAKEDATAPTR( DbProcMetaFile::endTopic, 
				DbProcMetaFile::SetRefData, sizeof(DbProcMetaFile::SetRefData), dptr );
	dptr->docid= t;
	dptr->sub= para_count;
	dptr->datalen= u_int32_t((paraFinalBuf - exportBuf) & 0x7fffffff);
	//size_t qqq= sizeof(BlockHeader);
	*(int*)(exportBuf+ADD_BLOCK_SIZE+1020)= (int)G_ZIP((char*)exportBuf, dptr->datalen, (char*)exportBuf+ADD_BLOCK_SIZE+1024+7/*qqq*/, dptr->datalen);
  #else
	MAKEDATAPTR( DbProcMetaFile::endTopic, 
				DbProcMetaFile::SetRefData, (ADD_BLOCK_SIZE+11), dptr );

	dptr->docid= t;
	dptr->sub= u_int32_t(para_count&0x7fffffff);
	t= u_int32_t((paraFinalBuf - 3 - exportBuf) & 0x7fffffff);
	dptr[1].docid = t;
	dptr->datalen= G_ZIP((char*)exportBuf, t, 7+(char*)(&(dptr[1].sub)), t);
	if(dptr->datalen < 1 || dptr->datalen >= t){
		memcpy(7+(char*)(&(dptr[1].sub)),exportBuf,t);
		dptr->datalen= t;
	}
	dptr->datalen += 23;
	buf->recSize= dptr->datalen + 8;
  #endif
#else
	MAKEDATAPTR( DbProcMetaFile::endTopic, 
				topic_t, 0, dptr );
	*dptr = t;
#endif
	t = 0;
	para_count = 0;
	return mh->write(buf);
}

int DbProcessorMWritter :: OK()
{
	return 1;
}






