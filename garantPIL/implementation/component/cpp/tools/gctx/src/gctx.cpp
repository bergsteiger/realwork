#include "shared/Core/fix/mpcxc.h"

#include "shared/ContextSearch/Common/Constants.h"
#include "shared/Core/sys/AutoInit.h"

#include "ace/Thread_Manager.h"

// test deep cvs copy
#include <getopt.h>
#include <cstdarg>
#include <cstdio>
#include <cstdlib>
#include <locale.h>

#include "basemask.h"
#include "collect.h"
#include "../../../libs/gctx/src/ctxwords.h"
#include "dociter.h"
#include "garutils.h"
#include "garver.h"
#include "../../../libs/gctx/src/gctxl_ver.h"
#include "osdep.h"
#include "stdbase.h"
#include "strings.h"
#include "../../../libs/gctx/src/u_int64_t.CtxLongSet.SplayMap.h"

#include "../../../libs/mrglib/src/base.h"
#include "../../../libs/endt/BlockDecompile.h"

#include "common/components/rtl/Garant/EVD/eeReader.h"

#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"

extern void setLimits();
extern void flushIt(Base *base, u_int64_tCtxLongSetSplayMap &cm, char *idx);
extern int gctx_nmain (YBase *, NContxtIndex *, DocIterator *, std::deque<long>, std::map< long,std::set<std::string> >&);
extern "C" void* local_main_PRE_ptr= 0;

#ifdef __cplusplus
extern "C" {
	char pTmpBuff0[4096];
	stream_st psstr2;
}
#endif

bool	b_indexcomments = true;
bool	b_index_B = false;
bool	b_index_invisible = false;
bool	b_index_firmtopics = false;

static void usage(const char *me)
{
	printf("GARANT Base indexator v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
	printf("Usage is:\n"
	"%s [-C cache_param] [-m memory_use] base\n"
	"  where:\n"
	"    cache_param looks like key_cache_pages:str_cache_pages.\n"
	"        cache_pages from 100 to 10000.\n"
	"              default is 2000.\n"
	"       memory_use is maximum available memory for data(M)\n"
	"              default is -1 (unlimited); minimum 10.\n", me);
}

#include "recode.h"

#ifdef Not_USE_LongSetSplayNode
LPPL_LINE_NORMLS bsearch_key(	u_int64_t *key, char *base, int *pSize)
{
	int num= *pSize;
    char *lo = base, *hi = base + (num - 1) * sizeof(LPPL_LINE_NORMLS), *mid;
    unsigned int half;
	LPPL_LINE_NORMLS *pMove= (LPPL_LINE_NORMLS*)base, pTmp= pMove[*pSize];
    while (lo <= hi){
            if (half = num / 2)
            {
                    mid = lo + (num & 1 ? half : (half - 1)) * sizeof(LPPL_LINE_NORMLS);
					if((*(LPPL_LINE_NORMLS*)mid)->key == *key){
						return *(LPPL_LINE_NORMLS*)mid;
                    }else if ((*(LPPL_LINE_NORMLS*)mid)->key > *key)
                    {
                            hi = mid - sizeof(LPPL_LINE_NORMLS);
							if(lo >= hi){
								lo= mid;
								if(mid > base && (*(LPPL_LINE_NORMLS*)(mid - sizeof(LPPL_LINE_NORMLS)))->key > *key)
									lo = mid - sizeof(LPPL_LINE_NORMLS);
								goto Insert_New;
							}
                            num = num & 1 ? half : half-1;
                    }else    {
                            lo = mid + sizeof(LPPL_LINE_NORMLS);
							if(lo > hi){
								lo= mid;
								goto Insert_New;
							}
                            num = half;
                    }
            }
            else if (num){
					if((*(LPPL_LINE_NORMLS*)lo)->key == *key){
						return *(LPPL_LINE_NORMLS*)lo;
                    }else if ((*(LPPL_LINE_NORMLS*)lo)->key < *key){
						lo += sizeof(LPPL_LINE_NORMLS);
					}
					goto Insert_New;
            }else
                    break;
	}

	(*pSize)++;
	(*(LPPL_LINE_NORMLS*)base)->key= *key;
	return *(LPPL_LINE_NORMLS*)base;
Insert_New:
	num= *pSize;
	while(pMove + num > (LPPL_LINE_NORMLS*)lo)
		pMove[num--] = pMove[num-1];
	*(LPPL_LINE_NORMLS*)lo= pTmp;(*pSize)++;
	(*(LPPL_LINE_NORMLS*)lo)->key= *key;
	return *(LPPL_LINE_NORMLS*)lo;
}
#endif

int commp(void *pKey, void *pCmp)
{
	return -1;
}

int main_logic ( int argc, char *argv[] );

#if !defined(WIN64) && !defined(MIN_MEM_CONTEXT)
u_int64_tCtxLongSetSplayNode *pAllPreInFirstGig= 0;
#endif

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (1);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
#if !defined(WIN64) && !defined(MIN_MEM_CONTEXT)
	pAllPreInFirstGig= new u_int64_tCtxLongSetSplayNode[MAX_NODES_INCACHE];
#endif
	Core::AutoInit init;
	return main_logic (argc, argv);
}

#include "garantPIL/implementation/component/cpp/tools/gctools/src/MyPipe.h"
extern int local_write(LPTHREAD_CNTX);
extern int local_flush(void*);
extern int local_flush_thread(void*);
static int lock_local_flush= 0, not_whait_next_flush= 0;

LPTHREAD_CNTX p_Reader, p_Writer;

char NameY[]="NWCntxt.str";

#include "UpdtMorph.h"

class	N_WCI : public UpdtContextIndex
{
public:
	u_int64_t AllSizeText;
	int preSize;
	N_WCI(PagedFile*f, const char*n, StreamFile*s,
									unsigned NormlsBuffCount= MAX_NODES_INCACHE, IndexInfo *pinfo= 0 )
					:UpdtContextIndex(f, n, s, NormlsBuffCount, pinfo )
	{
		AllSizeText= (u_int64_t)0;
		preSize= 0;
	}
	virtual void getParaWordFromDoc (u_int64_tCtxLongSetSplayMap *p_ctxTextArray, long Id, long LastPara, long LastWordPos, std::map< long,std::set<std::string> >& kinds, IGarDoc *pdoc= 0, bool include_name_in_text = false);
	virtual int in_pipe(char *, int);
	virtual void set_p_pipe_buff(char *, long);
	virtual int in_pipe_flush(char *, int);
	virtual void in_pipeID(long *pData, DocIterator* it= 0, DocInfo *pLocal_docInfo= 0)
	{
		long *pNxt= pData, stop= 0;
		if(*pData && is_not_pipeID(pData, it))
			;
		else do{
			*pData= it->Id ();
			if ( *pData > 100000 ){
				base->FindDocAttr(*pData,IDD_INFO,(char *)pLocal_docInfo, sizeof(*pLocal_docInfo));
				if ((pLocal_docInfo->Status & (DS_DOC | DS_EDITION)) || (pLocal_docInfo->Status_ex & DS_MEDTOPIC) || (b_index_firmtopics && (pLocal_docInfo->Status_ex & DS_FIRMTOPIC)))
					pNxt= &stop;
				else
					is_not_pipeID(pData, it);
			}else
				is_not_pipeID(pData, it);
		}while(*pNxt);
	}
	virtual bool IsReparsingAllTexts(DocIterator*, IGarDoc *doc= 0, u_int64_tCtxLongSetSplayMap	*pMap= 0) {
		DeleteChildsIndex();
		long Id= 0;
		in_pipe_flush((char*)&Id, 4);
		if(doc) {
			heap ();
			((Document*)doc)->FreeStructs ();
			delete doc;
		}
		return false;
	}
protected:
	bool is_not_pipeID(long *pData, DocIterator* it)
	{
		++(*it);
		if(it->End())
		{
			*pData= 0;
			return true;
		}
		return false;
	}
	bool bWriteStop;
	long key_buff[64];
public:
	virtual void FlushAllParaWords();
};

#include "garantPIL/implementation/component/cpp/libs/cchlp/src/QMap.hpp"
typedef CtxLongSet* LPpCtxLongSets;

typedef struct GCTX_PRESORT_TAG
{
	int *pSrt;
	int *pAlloc;
} PL_PRESORT, *LPPL_PRESORT;
typedef struct GCTX_NORM_TAG
{
	CtxLongSet cont;
	char *item;
} PL_GCTX_NORM, *LPPL_GCTX_NORM;

class	N_WCO : public UpdtContextIndex
{
public:
	N_WCO(PagedFile*f, const char*n, StreamFile*s,
									unsigned NormlsBuffCount= MAX_NODES_INCACHE, IndexInfo *pinfo= 0 )
					:UpdtContextIndex(f, n, s, NormlsBuffCount, pinfo )
	{
	}
	virtual void CopyAsFlushN(	void *vspit, void *vpdstr, void *vpsstr, void *vpin, long *prPos,
						int (__cdecl *compL)(const void *, const void *),
						int (__cdecl *compN)(const void *, const void *));
	virtual void CopyAsFlush(DocIterator *pUpDocs= 0);
	virtual void set_p_pipe_buff(char *pN, long N){
		p_pipe_buff= pN;
		pipe_buff_sz= pipe_buff_tmp= 0;
	}
	virtual void in_pipeID(long *pData, DocIterator* it, DocInfo *pLocal_docInfo= 0)
	{
		if(!(pipe_buff_sz-pipe_buff_tmp)){
			pipe_buff_tmp= 0;
			read_my_pipe(p_Reader, (char*)&pipe_buff_sz, sizeof(pipe_buff_sz));
			read_my_pipe(p_Reader, p_pipe_buff, pipe_buff_sz);
		}
		memcpy(pData,p_pipe_buff+pipe_buff_tmp,4); pipe_buff_tmp+= 4;
		if(!(*pData)){
			in_pipe_flush(0,0);
		}
	}
	virtual int in_pipe(char *pData, int szData)
	{
		if(!(pipe_buff_sz-pipe_buff_tmp)){
			pipe_buff_tmp= 0;
			read_my_pipe(p_Reader, (char*)&pipe_buff_sz, sizeof(pipe_buff_sz));
			read_my_pipe(p_Reader, p_pipe_buff, pipe_buff_sz);
		}
		memcpy(pData,p_pipe_buff+pipe_buff_tmp,szData);pipe_buff_tmp+= szData;
		return szData;
	}
	virtual int in_pipe_flush(char *pData, int szData)
	{
//#ifdef // ОТЛАДКА под Вижуальником ТОЛЬКО Purify_Release
//		::puts("\n Attach Debuger and after press Enter");
//		::getchar();
//#endif
		in_pipe((char*)&hFlushAllParaWords, sizeof(hFlushAllParaWords));
		in_pipe((char*)&pAllWordPos, sizeof(pAllWordPos));
		in_pipe((char*)&hNameFlushAllParaWords, sizeof(hNameFlushAllParaWords));
#if !defined(WIN64) && !defined(MIN_MEM_CONTEXT)
#else
		delete []pAllWordPos; pAllWordPos= 0;
		free(hNameFlushAllParaWords); hNameFlushAllParaWords= 0;
#endif
		return 0;
	}
	virtual void getParaWordFromDoc (u_int64_tCtxLongSetSplayMap *p_ctxTextArray, long Id, long LastPara, long LastWordPos, std::map<long, std::set<std::string> >& kinds, IGarDoc *pdoc= 0, bool include_name_in_text = false);
	virtual IGarDoc *addInOtherMap(long Id, DocInfo *local_docInfo, IGarDoc *doc) { return 0; }
#ifdef WIN64
	virtual void CloseLast_indxs_Temp()
	{
		// расписание НЕ флешим и из памяти НЕ удаляем;
	}
#elif !defined(MIN_MEM_CONTEXT)
	virtual void CloseLast_indxs_Temp()
	{
		LPPL_ZZZ pp_indxs= indxs+FlashCount;
		LPPL_YYY p_IndO= pp_indxs->pInd;
		do{
			::ACE_OS::write(pp_indxs->file, p_IndO->k, (p_IndO->k[0] & 0x3f));
			::ACE_OS::write(pp_indxs->file, &(p_IndO->len), 4);
			p_IndO++;
		}while(--countNewKeys);
		free(indxs[FlashCount].pInd);indxs[FlashCount].pInd= 0;
	}
#endif
protected:
	unsigned wordLen;
	int wordPos;
	char *buf;
	virtual void in_pipe_wordLen()
	{
		in_pipe((char*)&wordLen,4);
	}
	virtual void in_pipe_buf_wordPos()
	{
		in_pipe(buf,wordLen);
		in_pipe((char*)&wordPos,4);
	}
	int read_my_pipe(LPTHREAD_CNTX pCntxt, char *bff, int rd){
		int rr= ::read_my_pipe(pCntxt, bff, rd);
		if(rr < 0){
			rr &= 0x7fffffff;
			memcpy(bff, pCntxt->p_Bf + *pCntxt->p_Rd, rr);
			*pCntxt->p_Rd += rr;
		}
		return rr;
	}
	char key_buff[256];
};

class	N_WCO1 : public N_WCO
{
public:
	LPPL_GCTX_NORM pAAN;
	LPpCtxLongSets		*m_realloc;
	LPPL_PRESORT		m_realloc_flush;
	char *pBigBuff, *pWNxt, *pBigBuff2;
	int switchBigBuff, m_maxSize;

	N_WCO1(PagedFile*f, const char*n, StreamFile*s):N_WCO(f, n, s)
	{
  #if !defined(WIN64) && !defined(MIN_MEM_CONTEXT)
		pAllPre= pAllPreInFirstGig;
		pNxtNew0= pAllPre;

		if (!(pp_ctxTextCacheArray= (u_int64_tCtxLongSetSplayMap**)malloc (sizeof(u_int64_tCtxLongSetSplayMap*))))
			abort();
		if(!(pp_ctxTextCacheArray[0] = new u_int256_tCtxLongSetSplayMap(lsdef, pNxtNew0 ? &pNxtNew0 : 0)))
			abort();
  #endif
		m_next_realloc= 0;
		m_next_realloc_flush= 0;
		m_fID= 0;
		max_flush_normaled_nodes= 0;
		pAAN= 0;
		if(n[1] == 'W'){
			m_realloc= new LPpCtxLongSets[4*1024*1024];
			m_realloc_flush= new PL_PRESORT[400*1024];

			switchfb= 24*(1024*1024+10000/*Headers*/+10000/*Hide*/);
#ifdef	WIN64
			m_maxSize= 450*1024*1024 - switchfb;
#else
			m_maxSize= 350*1024*1024 - switchfb;
#endif

			pWNxt= pBigBuff = new char [m_maxSize+switchfb];
			pBigBuff2 = new char [m_maxSize+switchfb];

			pFlush= 0;
			switchfb= 0;
			switchBigBuff= 0;
		}else{
			m_realloc= 0;
			m_realloc_flush= 0;
		}
	}
	virtual void set_p_pipe_buff(char *pN, long N){
		p_pipe_buff= pN;
		pipe_buff_sz= pipe_buff_tmp= 0;
	}
	virtual void in_pipeID(long *pData, DocIterator* it, DocInfo *pLocal_docInfo= 0)
	{
		N_WCO::in_pipeID(pData, it, pLocal_docInfo);
		*(long*)pWNxt= *pData;pWNxt += 4;
	}
	virtual IGarDoc *addInOtherMap(long Id, DocInfo *local_docInfo, IGarDoc *doc) { return 0; }
	virtual int IsRealloc(CtxLongSet *sp){
		if(!sp->lastI){
			m_realloc[m_next_realloc++]= sp;
		}
		if(!(sp->lastI % (GROW_BY*4
  #ifndef NOT_OPTIMIZE_REALLOC
			* m_CurrReallocFactor
  #endif
									)))
		{
			itemsDone += 5
   #ifndef NOT_OPTIMIZE_REALLOC
										* m_CurrReallocFactor
   #endif
																		;
		}
		return 0;
	}
	int32_t m_next_realloc;
	int m_next_realloc_flush ;
	virtual NContxtIndex * FindContextIndexForFlash()
	{
		return 0;
	}
	u_int64_tCtxLongSetSplayNode *m_PP_AllocForNew, *m_PP_ForNew;
	int max_flush_normaled_nodes;
	virtual char *asNorm(void *pNewKey) { return (char*)pNewKey; }
	virtual void nflushIt(	u_int64_tCtxLongSetSplayMap *, NContxtIndex *);
	virtual int GetNormalesFromString (char*, LPPL_RET_NORMLS, LemmatizeProc lemmatize, unsigned wordLen = 0);
	virtual void GetKeyBuff(long **, u_int64_tCtxLongSetSplayNode *);
	virtual void MakeN_Map(u_int64_tCtxLongSetSplayMap **ppNew // <-- убрать в gctx_func.cpp
#ifdef PRE_ALLOC_NODES
		, u_int64_tCtxLongSetSplayNode **pp_ForNew
#endif
		){
			m_PP_AllocForNew= m_PP_ForNew= new u_int64_tCtxLongSetSplayNode[1024*1024];
			*ppNew= new 
			#ifdef QUCK_CNTXT_HASH
						u_int64_tCtxLongSetSplayMap
			#else
			#ifdef STORE_FORM_N
						u_intPointerN_tCtxLongSetSplayMap
			#else
						u_int256_tCtxLongSetSplayMap
			#endif
			#endif
															(lsdef, &m_PP_ForNew);
	}
	virtual CtxLongSet *GetSpNorm(u_int64_tCtxLongSetSplayMap	*p_ctxTextArray, u_int64_t *pNxt_normales){
		CtxLongSet *ret=  &((*p_ctxTextArray)[(void*)&pNxt_normales]);
		size_t offset= p_ctxTextArray->root-m_PP_AllocForNew;
		*(int*)pWNxt= offset;pWNxt += 4;
		return ret;
	}
	virtual void PutOffset(CtxLongSet *sp, long id, long j, int wordPos)
	{
		sp->lastI += 3;
	}
	long m_fID;
	virtual void InitMorpho(long Id= 0){
		if(m_fID == 0){
			m_fID= Id;
			// Иницилизация Массива русских окончаний
			NContxtIndex::InitMorpho ();
		}else if(m_fID != -1){
			maxItems= Id;
		}
	}
	virtual CtxLongSet *FromCache(void *pkey, LPPL_RET_NORMLS spRet)
	{
#ifdef WIN64
		static __int64 gi_Bcount= 0;
		if (b_index_B) {
			if(((char*)pkey)[1] == -62 && ((char*)pkey)[0] == 2){
				// одинокое "В" раскидываем по восьми различным псевдо-лексемам //
				int switchB= gi_Bcount%8;
				gi_Bcount++;
				if (switchB) {
					*(char*)pkey += 4;
					sprintf((char*)pkey+1,"ВЯZ%dZ",switchB);
				}
			}
		}
		return N_WCO::FromCache(pkey, spRet);
#else
		CtxLongSet *ret= &(*pp_ctxTextCacheArray[cacheI])[pkey];

		if((spRet->lastI= ret->lastI)){
			spRet->e= (u_int64_t *)ret->e;
			if(ret->lastElemV == -1)
				ret->capacity= 0;
			if(ret->capacity || ret->lastElemV == -1){
				ret->lastI= ret->capacity;
				ret->capacity= (long)ret->e;
				ret->e= (long*)ret->lastElemV;
				ret->lastElemV= ret->capacity;
				ret->capacity= 0;
			}
		}else{
  #ifndef MIN_MEM_CONTEXT 
	#ifdef _DEBUG
			if((pp_ctxTextCacheArray[cacheI]->m_pp_ForNew)[0] + 2 >= (pAllPre + MAX_NODES_INCACHE)){
				printf("\nERROR: Upper MAX_NODES_INCACHE ! ...\n");
				exit(-11);
			}
	#endif
			*(pp_ctxTextCacheArray[cacheI]->m_pp_ForNew)= (u_int64_tCtxLongSetSplayNode*)((char*)(*(pp_ctxTextCacheArray[cacheI]->m_pp_ForNew)) - (31 - pp_ctxTextCacheArray[cacheI]->root->curr_item[0]));
  #endif
			spRet->e= spRet->e;
		}
		return ret;
#endif
	}
	N_WCO1 *pFlush, *pFlsh;
	unsigned int switchfb;
protected:
	void *pRddRootForms;
	virtual void in_pipe_wordLen()
	{
		in_pipe((char*)&wordLen,4);
		*(unsigned*)pWNxt= wordLen;pWNxt += 4;
	}
	virtual void in_pipe_buf_wordPos()
	{
		in_pipe(buf,wordLen);
		in_pipe((char*)&wordPos,4);
		*(int*)pWNxt= wordPos;pWNxt += 4;
	}
	virtual bool IsReaderFlush(){
		ace_os_sleep(2969);
		return true;
	}
	int32_t m_pre_maxItems;
public:
	IGarDoc *doc;
	DocInfo	   local_docInfo;
	std::map< long,std::set<std::string> > gctx_kinds;
	virtual bool IsFlush() {
		bool ret= false;
		if(itemsDone > 1){
			if(pFlush){
				if((switchBigBuff % 2)){
					if(pWNxt-pBigBuff2 > m_maxSize){
						pFlush->maxItems= maxItems;
						pWNxt= pBigBuff;
						switchBigBuff++;
						ret= true;
					}
				}else{
					if(pWNxt-pBigBuff > m_maxSize){
						pFlush->maxItems= maxItems;
						pWNxt= pBigBuff2;
						switchBigBuff++;
						ret= true;
					}
				}
			}else{
				pWNxt= pBigBuff2;
				switchBigBuff= 1;
				ret= true;
			}
		}
		return ret;
	}
};

class	N_WCO2 : public N_WCO1
{
public:
	N_WCO2(PagedFile*f, const char*n, StreamFile*s):N_WCO1(f, n, s)
	{
		itemsDone = 0;
	}
	virtual void in_pipeID(long *pData, DocIterator*, DocInfo *)
	{
		*pData= *(long*)pWNxt, pWNxt += 4;
	}
	virtual int in_pipe(char *pData, int szData)
	{
		*(long*)pData= *(long*)pWNxt, pWNxt += 4;
		return 4;
	}
	size_t offsetR;
	virtual int GetNormalesFromString (char* buf, LPPL_RET_NORMLS spRet, LemmatizeProc lemmatize, unsigned wordLen = 0)
	{
		offsetR= *(long*)pWNxt;
		spRet->wordPos= 1;
		spRet->e= (u_int64_t *)(
#if defined(WIN64) || defined(MIN_MEM_CONTEXT)
									pAllPre[offsetR].
#else
									((u_int64_tCtxLongSetSplayNode*)offsetR)->
#endif
																				cont.e);
		spRet->lastI=
#if defined(WIN64) || defined(MIN_MEM_CONTEXT)
						pAllPre[offsetR].
#else
						((u_int64_tCtxLongSetSplayNode*)offsetR)->
#endif
																	cont.lastI;
 		pWNxt += 4;
		return 0;
	}
	virtual void GetKeyBuff(long **ppSet, u_int64_tCtxLongSetSplayNode *curr)
	{
		(*ppSet)=
#if defined(WIN64) || defined(MIN_MEM_CONTEXT)
					pAllPre[offsetR].
#else
					((u_int64_tCtxLongSetSplayNode*)offsetR)->
#endif
																cont.e;
	}
	virtual CtxLongSet *GetSpNorm(u_int64_tCtxLongSetSplayMap	*p_ctxTextArray, u_int64_t *pNxt_normales){
		long offset= *(long*)pWNxt;pWNxt += 4;
		return &(pAAN[offset].cont);
	}
	virtual int IsRealloc(CtxLongSet *sp){
		if(!sp->lastI){
			if(m_next_realloc_flush < FlashCount){
				m_next_realloc_flush= FlashCount;
				delete [](m_realloc_flush[m_next_realloc_flush].pAlloc);
				//m_realloc_flush[m_next_realloc_flush].pAlloc= 0;
			}
			sp->e= (long*)malloc(m_realloc_flush[FlashCount+1].pAlloc[m_next_realloc++]*sizeof(*sp->e));
		}
		if(!(sp->lastI % (GROW_BY*4
  #ifndef NOT_OPTIMIZE_REALLOC
			* m_CurrReallocFactor
  #endif
									)))
		{
			itemsDone += 5
   #ifndef NOT_OPTIMIZE_REALLOC
										* m_CurrReallocFactor
   #endif
																		;
		}
		return 0;
	}
	virtual NContxtIndex * FindContextIndexForFlash()
	{
		return UpdtContextIndex::FindContextIndexForFlash();
	}
	virtual void nflushIt(	u_int64_tCtxLongSetSplayMap *ctxmap, NContxtIndex *pIndex )
	{
		itemsDone= 0;
		LPPL_GCTX_NORM pNode;
		long *pData, pt;
		pWNxt= pBigBuff;
		while(itemsDone < m_next_realloc){
			pNode= pAAN+m_realloc_flush[FlashCount].pSrt[itemsDone++];
			pData= pNode->cont.e;
			{
				long cnt= 0, *pOut= (long*)pWNxt, lstDocFromTemp= *pData;
				pData += 3;
				pt= 0;
				*pOut= lstDocFromTemp;pOut++;
				do{
			#if !defined(STD_REALLOC)
					if(SkipDocForFlush && lstDocFromTemp == SkipDocForFlush)
						break;
			#endif
					if(lstDocFromTemp > lastDocFromTemp)
						lastDocFromTemp= lstDocFromTemp;
					pNode->cont.lastI -= 3;
					while(pNode->cont.lastI && *pData == lstDocFromTemp){
						*pOut++= ((*(pData-2) >> 14) << 15) | (*(pData-2) & 0x3fff);
						*pOut++= 0x40000000 | *(pData-1);
						cnt++;
						pData += 3; pNode->cont.lastI -= 3;
					}
					*pOut++= 0x80000000 | (((*(pData-2) >> 14) << 15) | (*(pData-2) & 0x3fff));
					*pOut++= 0x40000000 | *(pData-1);
					cnt++;
					pt += sizeof(long) + cnt*(sizeof(long)*2);
					cnt= 0;
				}while(pNode->cont.lastI && (lstDocFromTemp= *pOut= *pData) && (pData += 3)
						&& (pOut= (long*)((char*)pOut + sizeof(long))));
				if(indxs[FlashCount].max_size_saved_Node < pt)
					indxs[FlashCount].max_size_saved_Node= pt;

				pWNxt += pt;
				if( (countNewKeys == alloc_size
					&& (alloc_size += GROW_BY * (pNxtNPut ? 10 : 1))
							&& (indxs[FlashCount].pInd=
							(LPPL_YYY)realloc(indxs[FlashCount].pInd,sizeof(PL_YYY)*alloc_size))
										== 0))
					abort();
				(indxs[FlashCount].pInd+countNewKeys)->k= asNorm(pNode->item);
				(indxs[FlashCount].pInd+countNewKeys)->len= pt;
				countNewKeys++;
			}
			FreeData( &(pNode->cont) );
		}
		if((indxs[FlashCount].file_len= ::ACE_OS::write(indxs[FlashCount].file, pBigBuff, pWNxt-pBigBuff )) != pWNxt-pBigBuff){
			abort();
		}
		indxs[FlashCount].file_len += sizeof(int);
		delete [](m_realloc_flush[FlashCount].pSrt);
		m_next_realloc= 0;
	}
	virtual void PutOffset(CtxLongSet *sp, long id, long j, int wordPos)
	{
		sp->e[sp->lastI++] = id;
		sp->e[sp->lastI++] = wordPos;
		sp->e[sp->lastI++]= (long)(offsetR & 0x3fffffff);
	}
protected:
	virtual void in_pipe_wordLen()
	{
		in_pipe((char*)&wordLen,4);
	}
	virtual void in_pipe_buf_wordPos()
	{
		in_pipe((char*)&wordPos,4);
	}
};

void N_WCO1::nflushIt(	u_int64_tCtxLongSetSplayMap *ctxmap, NContxtIndex *pIndex )
{
	while(lock_local_flush) ace_os_sleep(20);lock_local_flush++;
	int *pSize= new int[m_next_realloc];
	int *pSrt= new int[m_next_realloc];
	m_realloc_flush[m_next_realloc_flush].pSrt= pSrt;
	m_realloc_flush[m_next_realloc_flush].pAlloc= pSize;
	m_next_realloc= 0;
	pAAN= (LPPL_GCTX_NORM)calloc(ctxmap->length(), sizeof(*pAAN));
	for( Pix ii = ctxmap->first(); ii; ctxmap->next(ii) ){
		pAAN[m_next_realloc].item= (char*)*(size_t*)m_PP_AllocForNew[m_next_realloc].curr_item;
		*(pSize++)= m_realloc[m_next_realloc]->lastI;
		m_realloc[m_next_realloc]->lastI= 0;
		pSrt[m_next_realloc++]= ((u_int64_tCtxLongSetSplayNode *)ii) - m_PP_AllocForNew;
	}
	m_PP_ForNew= m_PP_AllocForNew;
	ctxmap->clear();
	m_next_realloc_flush++;
	m_next_realloc= 0;
	if(hFlushAllParaWords){
		pFlush->maxItems= maxItems;
		ctxmap->clear();
		not_whait_next_flush= -1;
		local_flush(this);
		delete []m_PP_AllocForNew;
		delete []pBigBuff;
		delete []pBigBuff2;
		pFlush->pp_ctxTextCacheArray= 0;
		indxs= pFlush->indxs;pFlush->indxs= 0;
		FlashCount= pFlush->FlashCount;pFlush->FlashCount= 0;
		itemsDone= 0;
		pre_size= pFlush->pre_size;
		alloc_size= pFlush->alloc_size;
		countNewKeys= pFlush->countNewKeys;
		lastDocFromTemp= pFlush->lastDocFromTemp;
	}else{
//#ifdef // ОТЛАДКА под Вижуальником ТОЛЬКО Purify_Release
		//local_flush(this);
//#else
			if(pFlush == 0){
				lock_local_flush= 0;
				ACE_thread_t working_thread_id = 0;
				ACE_hthread_t working_thread_handle = 0;

				int res = ACE_OS::thr_create (
					(ACE_THR_FUNC)local_flush_thread
					, this
					, THR_NEW_LWP | THR_JOINABLE
					, &working_thread_id
					, &working_thread_handle
					, ACE_DEFAULT_THREAD_PRIORITY
					, 0 //stack_ptr
					, MPCXC_STACK_SIZE/16
				);
				if(res == 1)
					abort();
				ace_os_sleep(969);
			}else{
//#endif*/
				not_whait_next_flush++;
				lock_local_flush= 0;
			}
	}
}

#include "shared/ContextSearch/Common/Constants.h"
#include "Normalize.h"

class TextsBase : public YBase
{
public:
	TextsBase(const char * name
				, int mode= ACE_OS_O_RDONLY
				, int key_cpages=-1
				, int str_cpages =-1
				, int ndt_cache = -1
				, FILE *stat_file =0 ) : YBase(name, ACE_OS_O_RDONLY)
	{
	}
	virtual Index* makedMorpho(LPG_OTHER_INDEX pMorpho)
	{
		N_WCO1 *pRet= new N_WCO1( pMorpho->pKey, NameY, pMorpho->pStreamFile );
		pRet->pFlsh= new N_WCO2( pRet->file, "NZ.str", pRet->streams );
		return indTable[indCount++]= pRet;
	}
	virtual Index* FindIndex (const char *name){
		if(!strcmp(NameY, name)){
			OpenStreams(NameY);
			LPG_OTHER_INDEX pProto= pOtherNextIndex++;
			return makedMorpho(pProto);
		}
		return FindIndexOther(name);
	}
};

int local_flush(void *pBase)
{
	N_WCO1 *pCreated= (N_WCO1 *)pBase;
	{
		long IdPt;
		if(!(pCreated->pFlush)){
			pCreated->pFlush= pCreated->pFlsh;
			pCreated->pFlush->pBigBuff= pCreated->pFlush->pWNxt= pCreated->pBigBuff;
			pCreated->pFlush->in_pipeID(&(IdPt), 0, &(pCreated->local_docInfo));
			pCreated->pFlush->maxItems= IdPt;
			pCreated->pFlush->m_fID= -1;
			pCreated->pFlush->pAllPre= pCreated->pAllPre;
			pCreated->pFlush->pindPut= pCreated->pFlush;
			pCreated->pFlush->pp_ctxTextCacheArray= pCreated->pp_ctxTextCacheArray;
			pCreated->pFlush->pp_ctxTextCacheArray[0] = pCreated->pp_ctxTextCacheArray[0];
			pCreated->pFlush->pIOuter= 0;
			pCreated->pFlush->m_realloc_flush= pCreated->m_realloc_flush;
			pCreated->pFlush->m_PP_AllocForNew= pCreated->m_PP_AllocForNew;
			pCreated->pFlush->m_CurrReallocFactor= pCreated->m_CurrReallocFactor;
		}else{
			if((pCreated->switchfb++)%2)
			{
				pCreated->pFlush->pBigBuff= pCreated->pFlush->pWNxt= pCreated->pBigBuff;
			}else{
				pCreated->pFlush->pBigBuff= pCreated->pFlush->pWNxt= pCreated->pBigBuff2;
			}
			pCreated->pFlush->in_pipeID(&(IdPt), 0, &(pCreated->local_docInfo));
		}
		pCreated->pFlush->pAAN= pCreated->pAAN;
		do{
			pCreated->pFlush->getParaWordFromDoc( 0, IdPt, 0, 0, pCreated->gctx_kinds, 0, false);
			if(pCreated->pFlush->maxItems == IdPt){
				IdPt= 0;
			}else{
				pCreated->pFlush->in_pipeID(&(IdPt), 0, &(pCreated->local_docInfo));
			}
		}while(IdPt);
		pCreated->pFlush->pindPut->nflushIt( 0, pCreated->pFlush->pindPut->FindContextIndexForFlash() );
		pCreated->pFlush->itemsDone= 0;
		free(pCreated->pFlush->pAAN);
	}
	return 0;
}

int local_flush_thread(void *pBase)
{
	do{
		while(lock_local_flush) ace_os_sleep(20);lock_local_flush++;
		local_flush(pBase);
		lock_local_flush= 0;
		while(!not_whait_next_flush) ace_os_sleep(20);
	}while(not_whait_next_flush != -1 && !(not_whait_next_flush= 0));
	return 0;
}

void N_WCI::set_p_pipe_buff(char *pN, long N){
	p_pipe_buff= pN;
	pipe_buff_sz= N;
	pipe_buff_tmp= 0;
}

int N_WCI::in_pipe(char *pData, int szData)
{
	bWriteStop = true;
	if(szData > pipe_buff_sz - pipe_buff_tmp){
		write_my_pipe(p_Writer, (char*)&pipe_buff_tmp, sizeof(pipe_buff_tmp));
		write_my_pipe(p_Writer, p_pipe_buff, pipe_buff_tmp);
		pipe_buff_tmp= 0;
	}
	memcpy(p_pipe_buff+pipe_buff_tmp,pData, szData);pipe_buff_tmp += szData;
	return szData;
}

int N_WCI::in_pipe_flush(char *pData, int szData)
{
	in_pipe(pData,szData);
	in_pipe((char*)&hFlushAllParaWords, sizeof(hFlushAllParaWords));
	in_pipe((char*)&pAllWordPos, sizeof(pAllWordPos));
	in_pipe((char*)&hNameFlushAllParaWords, sizeof(hNameFlushAllParaWords));
	szData= 0;
	int rep0= BUFSIZE/sizeof(szData);
	while(rep0--)
		in_pipe((char*)&szData, sizeof(szData));
	return szData;
}

std::map<long, std::vector<long> > map_doc_gctx_para_lens;
std::map<long, std::vector<u_int64_t> > map_doc_invisiblepos_fragmentlen;
std::map<long, std::vector<u_int64_t> > map_doc_invisibleblockpos_releplus;
std::map<long, std::vector<u_int64_t> > map_doc_invisiblepos_releplus;

char	gctx_shrinked_str [1024];
char*	gctx_shrink_str (char* index_str)
{
	char* toput = gctx_shrinked_str;
	*toput = 0;
	char *token = strtok (index_str, "\\");
	while (token) {
		if (toput != gctx_shrinked_str) {
			toput++;
			*toput = '\\';
			toput++;
		}
		int length = strlen (token)-4;
		memcpy (toput, token+4, length+1);
		toput += length - 1;
		token = strtok (0, "\\");
	}
	return gctx_shrinked_str;
}

std::map <std::string,std::vector<std::string> > bigrams;
std::set<std::string> bigrams_words;

void N_WCI::getParaWordFromDoc (u_int64_tCtxLongSetSplayMap	*p_ctxTextArray, long Id, long LastPara, long /*LastWordPos*/, std::map< long,std::set<std::string> >& kinds, IGarDoc *pdoc, bool include_name_in_text)
{
	char	bufT [256], *buf = (char*)bufT + 1, bufN [DOC_NAME_SIZE], *new_src = 0;
	unsigned len, wordLen;
	const char *src = 0;
	long j, style, flags;
	int win_encode, wordPos = 0, RetVal= -1;
	Document *pDeleted = 0;
	bWriteStop = false;
 #if !defined(STD_REALLOC)
	if(!pdoc){
		pdoc= (IGarDoc *)OS_GetDocument(Id);
		if(!pdoc)
			return;
		pDeleted= (Document *)pdoc;
	}
 #else
	assert(pdoc);
 #endif

	IGarDoc *doc= pdoc;
	if(!LastPara)
		LastPara= doc->GetParaCount();
	else
		LastPara++;

	if (bigrams.size () == 0) {
		Stream *str = ((Document*)doc)->base->FindIndex ("Aux")->Open (AUX_BIGRAMS);
		if (str) {
			long size = str->Length ();
			char *data = new char [size], *ptr = data;
			str->Read (data, size);
			((Document*)doc)->base->FindIndex ("Aux")->Close (str);
			while (ptr - data < size) {
				char *new_ptr = ptr + strlen (ptr) + 1;
				long count;
				memcpy (&count, new_ptr, sizeof (long));
				new_ptr += sizeof (long);

				for (int i = 0; i < count; i++) {
					std::map<std::string,std::vector<std::string> >::iterator map_it = bigrams.find (new_ptr);
					if (map_it == bigrams.end ()) {
						std::vector<std::string> toinsert;
						toinsert.push_back (ptr);
						bigrams.insert (std::map<std::string,std::vector<std::string> >::value_type (new_ptr, toinsert));
					} else {
						map_it->second.push_back (ptr);
					}

					GCL::StrVector parts;
					boost::split (parts, new_ptr, boost::is_any_of ("|"));
					for (GCL::StrVector::const_iterator it = parts.begin (); it != parts.end (); it++)
						bigrams_words.insert (*it);

					new_ptr += strlen (new_ptr) + 1;
				}
				ptr = new_ptr;
			}
			delete []data;
		} else {
			std::vector<std::string> empty;
			empty.push_back ("DEADFOOD");
			bigrams.insert (std::map<std::string,std::vector<std::string> >::value_type ("DEADFOOD", empty));
		}
	}

	AttrIndex* attrs = (AttrIndex*) ((Document*)doc)->base->FindIndex ("Attrs");
	long subs_count = -1;
	SubDesc* subs = 0;

	bool is_aaktext = GetDocStatusExEx (&((Document*)doc)->Stat) & DS_AAKTEXT;
	long last_aakpara = 0x7FFFFFFF;
	if (is_aaktext) {
		if (subs_count == -1) {
			subs = (SubDesc*) attrs->Load (Id, IDD_SUBS, subs_count);
			subs_count /= sizeof (SubDesc);
		}

		long length = 0;
		char *data = (char*) ((Document*)doc)->base->LoadAttr (Id, IDD_EVD, length), *ptr = data;
		if (length) {
			while (ptr - data < length) {
				long block_id = *(long*)ptr;
				ptr += sizeof (long);
				long size = (long) ptr [0];
				if (block_id < 0) {
					std::string info;
					evd::IeeGenerator_var generator = EndtTools::BlockDecompileFactory::make (info);
					evd::EvdReader_var evd_reader = new evd::EvdReader (ptr+1, size, generator.in ());
					evd_reader->convert_binary_object ();
					if (info == "RIGHT") {
						block_id = -block_id;
						SubDesc* subpos = (SubDesc*)bsearch (&block_id, subs, subs_count, sizeof (SubDesc), compare_subdesc_subs);
						if (subpos)
							last_aakpara = subpos->Para;
					}
				}
				ptr += size + 1;
			}
			gk_free (data);
		}
	}
	
	std::map<long, std::vector<std::string> > map_para_invisibletexts;
	std::map<long, std::vector<long> > map_para_invisiblereles;
	std::map<long,long> map_para_len;
	{
		char sub_name [SUB_NAME_SIZE+4];
		AttrKey key = {Id, IDD_KIND};
		Stream *str = attrs->Open (&key);
		if (str) {
			int length = str -> Length();
			char *prefixes = (char*) alloca (length+4), *ptr = prefixes;
			if (str->Read (prefixes, length) == length) {
				attrs -> Close (str);
				std::set<std::string> prefixes_set;
				while (ptr - prefixes < length) {
					prefixes_set.insert (ptr);
					ptr += strlen (ptr) + 1;
				}
				ptr = prefixes;
				for (std::set<std::string>::const_iterator it = prefixes_set.begin (); it != prefixes_set.end (); it++) {
					strcpy (ptr, it->c_str ());
					ptr += strlen (ptr) + 1;
				}
				ptr = prefixes;				
				while (ptr - prefixes < length) {
					long size = strlen (ptr);
					char* prefix = strrchr (ptr, ':') + 1;
					if (kinds.find (0)->second.find (prefix) != kinds.find (0)->second.end ()) {
						if (subs_count == -1) {
							subs = (SubDesc*) attrs->Load (Id, IDD_SUBS, subs_count);
							subs_count /= sizeof (SubDesc);
						}
						long sub = atol (ptr), para = 0;
						if (sub) {
							SubDesc* subpos = (SubDesc*)bsearch (&sub, subs, subs_count, sizeof (SubDesc), compare_subdesc_subs);
							if (subpos)
								para = subpos->Para;
						} else {
							para = 0;
						}
						((Document*)doc)->base->FindSubName (Id, sub, sub_name);
						if (sub_name [0]) {
							std::vector<std::string> texts; texts.push_back (sub_name);
							map_para_invisibletexts.insert (std::map<long,std::vector<std::string> >::value_type (para, texts));
							std::vector<long> reles; reles.push_back (-1);
							map_para_invisiblereles.insert (std::map<long,std::vector<long> >::value_type (para, reles));
						}
					}
					if (kinds.find (1)->second.find (prefix) != kinds.find (1)->second.end ()) {
						if (subs_count == -1) {
							subs = (SubDesc*) attrs->Load (Id, IDD_SUBS, subs_count);
							subs_count /= sizeof (SubDesc);
						}
						long sub = atol (ptr), para = 0;
						if (sub) {
							SubDesc* subpos = (SubDesc*)bsearch (&sub, subs, subs_count, sizeof (SubDesc), compare_subdesc_subs);
							if (subpos)
								para = subpos->Para;
						} else {
							para = 0;
						}
						std::map<long,std::vector<std::string> >::iterator it = map_para_invisibletexts.find (para);

						char* shrinked_prefix = gctx_shrink_str (prefix);
						if (it == map_para_invisibletexts.end ()) {
							std::vector<std::string> texts; texts.push_back (shrinked_prefix);
							map_para_invisibletexts.insert (std::map<long,std::vector<std::string> >::value_type (para, texts));
							std::vector<long> reles; reles.push_back (-1);
							map_para_invisiblereles.insert (std::map<long,std::vector<long> >::value_type (para, reles));
						} else {
							it->second.push_back (shrinked_prefix);
							map_para_invisiblereles.find (para)->second.push_back (-1);
						}
					}
					ptr += size + 1;
				}
			} else {
				attrs -> Close (str);
			}
		}
	}

	{
		AttrKey key = {Id, IDD_HANDMASK};
		Stream *str = attrs->Open (&key);
		if (str) {
			int length = str->Length();
			char* handmasks = (char*) alloca (length), *ptr = handmasks;
			str->Read (handmasks, length);
			attrs->Close (str);
			while (ptr - handmasks < length) {
				if (subs_count == -1) {
					subs = (SubDesc*) attrs->Load (Id, IDD_SUBS, subs_count);
					subs_count /= sizeof (SubDesc);
				}
				long size = strlen (ptr), sub = atol (ptr), para = 0;
				if (sub) {
					SubDesc *subpos = (SubDesc*)bsearch (&sub, subs, subs_count, sizeof (SubDesc), compare_subdesc_subs);
					if (subpos)
						para = subpos->Para;
				}
				char* hm = strchr (ptr, ':') + 1;
				std::map<long,std::vector<std::string> >::iterator map_it = map_para_invisibletexts.find (para);
				if (map_it == map_para_invisibletexts.end ()) {
					char* semi = strchr (hm, ':');
					*semi = '\0';
					long rele = atol (semi+1);
					std::vector<std::string> texts; texts.push_back (hm);
					map_para_invisibletexts.insert (std::map<long,std::vector<std::string> >::value_type (para, texts));
					std::vector<long> reles; reles.push_back (rele);
					map_para_invisiblereles.insert (std::map<long,std::vector<long> >::value_type (para, reles));
				} else {
					char* semi = strchr (hm, ':');
					*semi = '\0';
					long rele = atol (semi+1);
					map_it->second.push_back (hm);
					map_para_invisiblereles.find (para)->second.push_back (rele);
				}
				ptr += size + 1;
			}
		}
	}

	std::map<long,std::vector<std::string> > map_para_invisibleblocktexts; //для каждого из этих блоков есть строка (невидимый текст)
	std::map<long,std::vector<long> > map_para_invisibleblockreles; //для каждого из этих блоков есть вектор дополнительных баллов за релевантность
	std::map<long,std::vector<long> > map_para_blocks; //какие блоки на параграфе начинаются
	
	//соответственно, если на параграф есть map_para_blocks - то по одной начинаем доставать строки, и индексировать
	{
		AttrKey key = {Id, IDD_HANDHANDMASK};
		Stream *str = attrs->Open (&key);
		if (str) {
			int length = str->Length();
			char* handmasks = (char*) alloca (length), *ptr = handmasks;
			str->Read (handmasks, length);
			attrs->Close (str);
			while (ptr - handmasks < length) {
				if (subs_count == -1) {
					subs = (SubDesc*) attrs->Load (Id, IDD_SUBS, subs_count);
					subs_count /= sizeof (SubDesc);
				}
				long size = strlen (ptr), sub = atol (ptr), para = 0;
				if (sub) {
					SubDesc* subpos = (SubDesc*) bsearch (&sub, subs, subs_count, sizeof (SubDesc), compare_subdesc_subs);
					if (subpos)
						para = subpos->Para;
				}
				char* hm = strchr (ptr, ':') + 1;
				std::map<long,std::vector<long> >::iterator blocks_it = map_para_blocks.find (para);
				char* semi = strchr (hm, ':');
				*semi = 0;
				long rele = atol (semi+1);
				if (blocks_it == map_para_blocks.end ()) {
					std::vector<long> blocks; blocks.push_back (sub);
					map_para_blocks.insert (std::map<long,std::vector<long> >::value_type (para, blocks));
					std::vector<std::string> texts; texts.push_back (hm);
					std::vector<long> reles; reles.push_back (rele);
					map_para_invisibleblocktexts.insert (std::map<long,std::vector<std::string> >::value_type (para, texts));
					map_para_invisibleblockreles.insert (std::map<long,std::vector<long> >::value_type (para, reles));
				} else {
					blocks_it->second.push_back (sub);
					map_para_invisibleblocktexts.find (para)->second.push_back (hm);
					map_para_invisibleblockreles.find (para)->second.push_back (rele);
				}
				ptr += size + 1;
			}
		}
	}
	gk_free (subs);

	std::map<long,std::vector<long> > map_para_markedpositions;
	{
		AttrKey key = {Id, IDD_MARKEDTEXT};
		Stream *str = attrs->Open (&key);
		if (str) {
			int length = str->Length ();
			char *data = new char [length];
			str->Read (data, length);
			attrs->Close (str);
			long *ptr = (long*) data;
			length /= sizeof (long);
			while (length) {
				long para = *ptr++; length--;
				long count = *ptr++; length--;
				std::vector<long> positions;
				for (; count; count--, length--)
					positions.push_back (*ptr++);
				map_para_markedpositions.insert (std::map<long,std::vector<long> >::value_type (para, positions));
			}
		}
	}

	std::map<long,long> para_firstword;
	std::map<long,long> map_invisibleblockpos_block; //к каком блоку относится позиция "невидимого текста"; потом для этого блока возьмем параграф, на котором он (блок) кончается, и узнаем длину фрагмента
	std::map<long,long> map_blockpos_releplus; //для этой позиции (невидимого блока) будет увеличиваться релевантность
	std::map<long,long> map_pos_releplus; //для этой позиции будет увеличиваться релевантность
	std::set<long> paras_withaddedtext; //параграфы, к концам которых доклеен невидимый текст (который на самом деле относится к следующему параграфу)
	bool b_docname = true;
	std::set<long> wordposcontrol;
	for (j = 0, style, flags = 0; j < LastPara; ) {
		std::vector<long> marked_positions;
		long saved_len = 0, block = -1, rele = -1;
		bool b_inpara = false, b_invisible_text = false, b_invisible_block = false, b_is_comment = false;
		if (b_docname) {
			//индексируется !NAME документа
			b_docname = false;
			if (!base->FindDocName (Id, bufN))
				continue;
			win_encode = 1, style = 0, src = bufN, len = strlen (src);
		} else if (include_name_in_text) {
			include_name_in_text = false;
			wordPos = ContextSearch::DOC_BEGIN_WORD;
			b_invisible_text = true; //ранее было flags = ENDT_HEADER, и потом срабатывало corr_wordPos |= ContextSearch::POS_HEADER;
			strcpy (bufN, "");
			base->FindDocName (Id, bufN);
			style = 0, win_encode = 1, src = bufN, len = strlen (src);
		} else if (map_para_invisibleblocktexts.find (j) != map_para_invisibleblocktexts.end ()) {
			if (wordPos < ContextSearch::DOC_BEGIN_WORD)
				wordPos = ContextSearch::DOC_BEGIN_WORD;
			if (j) paras_withaddedtext.insert (j-1);
			if (para_firstword.find (j) == para_firstword.end ())
				para_firstword.insert (std::map<long,long>::value_type (j, wordPos));

			std::map<long,std::vector<std::string> >::iterator texts_it = map_para_invisibleblocktexts.find (j);
			new_src = strdup (texts_it->second.begin ()->c_str ());
			texts_it->second.erase (texts_it->second.begin ());
			if (!texts_it->second.size ())
				map_para_invisibleblocktexts.erase (j);

			std::map<long,std::vector<long> >::iterator reles_it = map_para_invisibleblockreles.find (j);
			rele = *reles_it->second.begin ();
			reles_it->second.erase (reles_it->second.begin ());
			if (!reles_it->second.size ())
				map_para_invisibleblockreles.erase (j);

			std::map<long,std::vector<long> >::iterator blocks_it = map_para_blocks.find (j);
			block = *blocks_it->second.begin ();
			blocks_it->second.erase (blocks_it->second.begin ());
			b_invisible_block = true;
			src = new_src, len = strlen (src), win_encode = 1;
		} else if (map_para_invisibletexts.find (j) != map_para_invisibletexts.end ()) {
			if (wordPos < ContextSearch::DOC_BEGIN_WORD)
				wordPos = ContextSearch::DOC_BEGIN_WORD;
			if (j) paras_withaddedtext.insert (j-1);
			if (para_firstword.find (j) == para_firstword.end ())
				para_firstword.insert (std::map<long,long>::value_type (j, wordPos));

			std::map<long, std::vector<std::string> >::iterator texts_it = map_para_invisibletexts.find (j);
			new_src = strdup (texts_it->second.begin ()->c_str ());
			texts_it->second.erase (texts_it->second.begin ());
			if (!texts_it->second.size ())
				map_para_invisibletexts.erase (j);

			std::map<long,std::vector<long> >::iterator reles_it = map_para_invisiblereles.find (j);
			rele = *reles_it->second.begin ();
			reles_it->second.erase (reles_it->second.begin ());
			if (!reles_it->second.size ())
				map_para_invisiblereles.erase (j);

			src = new_src, len = strlen (src), win_encode = 1;
		} else {
			b_inpara = true;
			if (para_firstword.find (j) == para_firstword.end ())
				para_firstword.insert (std::map<long,long>::value_type (j, wordPos));
			src = doc -> GetParaTextBytes (j, (int*)&style, &flags, (int*)&len);
			if (map_para_markedpositions.find (j) != map_para_markedpositions.end ())
				marked_positions = map_para_markedpositions.find (j)->second;
			if (flags & (ENDT_VERSION_COMMENTS| ENDT_COMMENTS))
				b_is_comment = true;
			win_encode = (style == PS_EVD) ? 1 : 0;
			j++;
		}

		if (wordposcontrol.find (j) == wordposcontrol.end ()) {
			wordposcontrol.insert (j);
			if (j == 1) {
				if(wordPos > ContextSearch::DOC_BEGIN_WORD)
					WordPosControl(Id, j, &wordPos, wordPos - ContextSearch::DOC_BEGIN_WORD);
				else
					WordPosControl(Id, j, &wordPos, 0);
			} else {
				WordPosControl (Id, j, &wordPos, 0);
			}
		}

		if (is_aaktext && j > last_aakpara)
			break;
		
		long from_mark = 0x7FFF, to_mark = 0x7FFF;
		std::vector<long>::const_iterator marked_it = marked_positions.begin ();
		if (marked_positions.size ()) {
			from_mark = *marked_it;
			marked_it++;
			to_mark = *marked_it;
			marked_it++;
		}

		long processed_words = 0;
		
		const char* saved_src = src;
		std::string prev_word_1, prev_word_2, prev_word_3;

		while ( (wordLen= getParaWord((char*)buf, &src, len, &win_encode)) && wordLen > 0 && wordPos < ContextSearch::POS_TEXT){
			long marked_pos = src - saved_src;
			bool b_marked = false;
			if (marked_pos > from_mark && marked_pos <= to_mark)
				b_marked = true;
			if (marked_pos >= to_mark && marked_it != marked_positions.end ()) {
				from_mark = *marked_it;
				marked_it++;
				to_mark = *marked_it;
				marked_it++;
			}
			wordPos++, processed_words++;

			if (b_is_comment && !b_indexcomments)
				continue;

			int corr_wordPos = wordPos << 2, pos_flag = 0;
			if (wordPos > ContextSearch::DOC_BEGIN_WORD) {
				if (b_invisible_block) {
					map_invisibleblockpos_block.insert (std::map<long,long>::value_type (wordPos, block));
					if (rele != -1) map_blockpos_releplus.insert (std::map<long,long>::value_type (wordPos, rele));
					corr_wordPos |= (pos_flag = GKDB_POS_INVISIBLE_BLOCK);
				} else if (b_invisible_text || (new_src && src - new_src > saved_len)) {
					if (rele != -1) map_pos_releplus.insert (std::map<long,long>::value_type (wordPos, rele));
					corr_wordPos |= (pos_flag = GKDB_POS_INVISIBLE);
				} else if ((flags & ENDT_HEADER) || (flags & ENDT_ARTICLE_HEADER)) {
					corr_wordPos |= (pos_flag = GKDB_POS_HEADER);
				} else if (b_marked) {
					corr_wordPos |= (pos_flag = GKDB_POS_HEADER);
				}
			} else if (wordPos < ContextSearch::DOC_BEGIN_WORD) {
				corr_wordPos |= (pos_flag = GKDB_POS_HEADER);
			}
			if (RetVal == -1) {
				in_pipe ((char*)&Id, 4);
				RetVal = 0;
			}
			buf [wordLen] = 0;
			in_pipe ((char*)&wordLen, 4);
			in_pipe (buf, wordLen);
			in_pipe ((char*)&corr_wordPos, 4);

			if (bigrams_words.size ()) {
				if (bigrams_words.find (buf) == bigrams_words.end ()) {
					prev_word_1.clear ();
					prev_word_2.clear ();
					prev_word_3.clear ();
				} else {
					if (prev_word_3.size ()) {
						prev_word_3 += "|";
						prev_word_3 += buf;

						std::map<std::string,std::vector<std::string> >::const_iterator bigr_it = bigrams.find (prev_word_3);
						if (bigr_it != bigrams.end ()) for (std::vector<std::string>::const_iterator lemma_it = bigr_it->second.begin (); lemma_it != bigr_it->second.end (); lemma_it++) {
							char *lemma = (char*) lemma_it->c_str ();
							unsigned lemma_len = lemma_it->size ();
							in_pipe ((char*)&lemma_len, 4);
							in_pipe (lemma, lemma_len);
							int prev_pos = ((wordPos - 3) << 2) | pos_flag;
							in_pipe ((char*)&prev_pos, 4);
						}
					}
					if (prev_word_2.size ()) {
						prev_word_2 += "|";
						prev_word_2 += buf;

						std::map<std::string,std::vector<std::string> >::const_iterator bigr_it = bigrams.find (prev_word_2);
						if (bigr_it != bigrams.end ()) for (std::vector<std::string>::const_iterator lemma_it = bigr_it->second.begin (); lemma_it != bigr_it->second.end (); lemma_it++) {
							char *lemma = (char*) lemma_it->c_str ();
							unsigned lemma_len = lemma_it->size ();
							in_pipe ((char*)&lemma_len, 4);
							in_pipe (lemma, lemma_len);
							int prev_pos = ((wordPos - 2) << 2) | pos_flag;
							in_pipe ((char*)&prev_pos, 4);
						}

						prev_word_3.swap (prev_word_2);
					}
					if (prev_word_1.size ()) {
						prev_word_1 += "|";
						prev_word_1 += buf;

						std::map<std::string,std::vector<std::string> >::const_iterator bigr_it = bigrams.find (prev_word_1);
						if (bigr_it != bigrams.end ()) for (std::vector<std::string>::const_iterator lemma_it = bigr_it->second.begin (); lemma_it != bigr_it->second.end (); lemma_it++) {
							char *lemma = (char*) lemma_it->c_str ();
							unsigned lemma_len = lemma_it->size ();
							in_pipe ((char*)&lemma_len, 4);
							in_pipe (lemma, lemma_len);
							int prev_pos = ((wordPos - 1) << 2) | pos_flag;
							in_pipe ((char*)&prev_pos, 4);
						}

						prev_word_2.swap (prev_word_1);
					}
					prev_word_1 = buf;
				}
			}
		}
		if (b_inpara)
			map_para_len.insert (std::map<long,long>::value_type (j-1, processed_words));
		if (new_src) {
			gk_free (new_src);
			new_src = 0;
		}
	}
	para_firstword.insert (std::map<long,long>::value_type (j, wordPos));

	std::map<long,long> map_block_endpara;
	size_t ds_count = -1;
	for (std::map<long,long>::const_iterator it = map_invisibleblockpos_block.begin (); it != map_invisibleblockpos_block.end (); it++) {
		long block = it->second, retSz;
		if (block && ds_count == -1) {
			DocStruct* docstructs = (DocStruct*) attrs->Load (Id, IDD_DOCSTRUCT, retSz), *ptr = docstructs;
			ds_count = retSz & 0x7fffffff;
			for (size_t i = 0; i < ds_count / sizeof (DocStruct); i++, ptr++) {
				short evd_type = (short) ((ptr->m_para_list_type >> 24) & 0xFF);
				if (evd_type == SUBDESCEX_BLOCK)
					map_block_endpara.insert (std::map<long,long>::value_type (ptr->m_para_list_id, ptr->m_end_para + 1));
			}
			gk_free (docstructs);
		}
		long nextpara = block ? map_block_endpara.find (block)->second : j /*doc->GetParaCount ()*/; //последние пустые параграфы скипуются, поэтому так
		long firstpos_innextpara = para_firstword.find (nextpara)->second;
		u_int64_t superpos = (((u_int64_t)it->first) << 32) + firstpos_innextpara - it->first;
		std::map<long,std::vector<u_int64_t> >::iterator map_it = map_doc_invisiblepos_fragmentlen.find (Id);
		if (map_it == map_doc_invisiblepos_fragmentlen.end ()) {
			std::vector<u_int64_t> superpositions;
			superpositions.push_back (superpos);
			map_doc_invisiblepos_fragmentlen.insert (std::map<long,std::vector<u_int64_t> >::value_type (Id, superpositions));
		} else {
			map_it->second.push_back (superpos);
		}
	}

	if (paras_withaddedtext.size ()) {
		std::vector<long> para_lens;
		for (std::set<long>::const_iterator it = paras_withaddedtext.begin (); it != paras_withaddedtext.end (); it++) {
			long para = *it;
			para_lens.push_back (para);
			std::map<long,long>::const_iterator map_it = map_para_len.find (para);
			long len = map_it->second;
			para_lens.push_back (len);
		}
		map_doc_gctx_para_lens.insert (std::map<long, std::vector<long> >::value_type (Id, para_lens));
	}

	if (map_blockpos_releplus.size ()) {
		std::vector<u_int64_t> releplus;
		for (std::map<long,long>::const_iterator rele_it = map_blockpos_releplus.begin (); rele_it != map_blockpos_releplus.end (); rele_it++) {
			long pos = rele_it->first, rele = rele_it->second;
			u_int64_t posrele = (((u_int64_t) pos) << 32) + rele;
			releplus.push_back (posrele);
		}
		map_doc_invisibleblockpos_releplus.insert (std::map<long, std::vector<u_int64_t> >::value_type (Id, releplus));
	}

	if (map_pos_releplus.size ()) {
		std::vector<u_int64_t> releplus;
		for (std::map<long,long>::const_iterator rele_it = map_pos_releplus.begin (); rele_it != map_pos_releplus.end (); rele_it++) {
			long pos = rele_it->first, rele = rele_it->second;
			u_int64_t posrele = (((u_int64_t) pos) << 32) + rele;
			releplus.push_back (posrele);
		}
		map_doc_invisiblepos_releplus.insert (std::map<long, std::vector<u_int64_t> >::value_type (Id, releplus));
	}

	if(pDeleted)
		delete pDeleted;
	if(bWriteStop){
		bWriteStop= false;
		wordLen= 0;
		in_pipe((char*)&wordLen,4);
	}
	long tmpSz= (long)(((AllSizeText += pdoc->GetDocTextSize())/(8*1024*1024)) & 0x7fffffff);
	if(preSize != tmpSz){
		preSize= tmpSz;
		printf("\r%d MBytes processed", (int)(AllSizeText/(1024*1024)));
	}
}


void N_WCO1::GetKeyBuff(long **ppSet, u_int64_tCtxLongSetSplayNode *curr)
{
	(*ppSet)= curr->cont.e;
}

int N_WCO1::GetNormalesFromString (char* bufIn, LPPL_RET_NORMLS spRetIn, LemmatizeProc lemmatize, unsigned wordLenIn) {
	if(NContxtIndex::GetNormalesFromString(bufIn, spRetIn, lemmatize, wordLenIn))
		abort();
	*(int*)pWNxt= 
#if defined(WIN64) || defined(MIN_MEM_CONTEXT)
	(int)(
  #ifdef WIN64
		0x7fffffff &
  #endif
		(pp_ctxTextCacheArray[cacheI]->root-pAllPre));
#else
	(int)(pp_ctxTextCacheArray[cacheI]->root);
#endif
	pWNxt += 4;
	return 0;
}

extern int GetNormalesFromStrings(	NContxtIndex *pind, char *buf, LPPL_RET_NORMLS spRet, unsigned wordLen,
						    u_int64_tCtxLongSetSplayMap	*p_ctxTextArray,
							int *pwordPos, long Id, long j, IGarDoc *pdoc);

int g_iDocsCount= 0;

NContxtIndex *Gind= 0;

void N_WCO::getParaWordFromDoc( u_int64_tCtxLongSetSplayMap	*p_ctxTextArray, long Id, long LastPara, long LastWordPos, std::map< long,std::set<std::string> >& kinds, IGarDoc *, bool include_name_in_text)
{
	g_iDocsCount++;
	// Иницилизация Массива русских окончаний
	InitMorpho (Id);

	PL_RET_NORMLS retrn;
	char	bufT [256];
	buf = (char*)bufT+1;
	const char *src = 0;
	int RetVal, textpos_add = 0;
	Document *pDeleted= 0;

	in_pipe_wordLen();
	if(wordLen){
		in_pipe_buf_wordPos();
		buf[wordLen]= 0;
		retrn.lastI= 0;
		if((RetVal= GetNormalesFromStrings( this, buf, &retrn, wordLen, p_ctxTextArray, &wordPos, Id, 0, 0)))
			abort();
		in_pipe_wordLen();
		while(wordLen){
			in_pipe_buf_wordPos();
			buf[wordLen]= 0;
			retrn.lastI= 0;
			if((RetVal= GetNormalesFromStrings( this, buf, &retrn, wordLen, p_ctxTextArray, &wordPos, Id, 0, 0)))
				abort();
			in_pipe_wordLen();
		}
	}
}

int main_logic ( int argcZ, char *argv[] )
{
	setlocale (LC_ALL, "ru_RU.CP1251");
	int argc= argcZ;
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N)
	if(argc < 0){
		argc= -argcZ;
	}else
#endif
	{
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N)
		init_my_pipe(&p_Writer, &p_Reader, local_write);
		p_Writer->l_argc= argc;
		p_Writer->l_argv= argv;
#endif
		VER_PARAM verParam;
		int	i;

		verParam.exeId= TID_GCTX;		// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i == VC_ADD_OK){
			}else{
			}
	#ifdef _DEBUG
			printf("\n *** GCTX Debug Version. For test, only... ***\n\n");
	#else
			exit(0);
	#endif
		}
	}

	char *basen = 0;
	char *cache = 0;;
	char *sz_p = 0;
	int  key_pages = 4000;
	int  str_pages = 1000;
	int32_t maxmem = -1;
	int option_char;
	bool	b_morpho = true;
	bool	b_3threads = false;

	long size_pipe_buff= 0x3ff;
	b_3threads= true;

	while ((option_char = getopt (argc, argv, "3C:m:h5vBiIfF")) != -1){
		switch (option_char){
			case 'f':
			case 'F':
				b_index_firmtopics = true;
				break;
			case 'i':
			case 'I':
				b_index_invisible = true;
				break;
			case 'B':
				b_index_B = true;
				break;
			case '3':
				break;
			case 'h':
				usage(argv[0]);
				return 0;
			case 'C':
				cache = optarg;
				break;
			case 'm':
				break;
			case '5':
				b_morpho = false;
				break;
			case 'z':
				sz_p = optarg;
				break;
			case 'v':
				b_indexcomments = false;
				break;
			default :
				usage(argv[0]);
				return 1;
		}
	}
	argc -= optind;
	basen = argv[optind];
	maxmem = 250;
	TextsBase *base= 0;

	std::deque<long> *pdocs_include_header_in_text= 0;
	std::map<long,std::set<std::string>> *pgctx_kinds= 0;

	if(argcZ < 0){
		base= (TextsBase *)basen;
		pdocs_include_header_in_text= new std::deque<long>;
		pgctx_kinds= new std::map<long,std::set<std::string>>;
	}else{
		if ( !basen  ) {
			printf("No base in command line.\n");
			usage(argv[0]);
			return 1;
		}
		if(!strchr(basen, '\\')){
			char *newfpth;
			int lnn= strlen(basen);
			newfpth= (char*)malloc(lnn+3);
			if(basen[1] == ':'){
				newfpth[0]= basen[0];
				newfpth[1]= basen[1];
				newfpth[2]= '.';
				newfpth[3]= '\\';
				memcpy(newfpth+4,basen+2,lnn-1);
			}else{
				newfpth[0]= '.';
				newfpth[1]= '\\';
				memcpy(newfpth+2,basen,lnn+1);
			}
			basen= newfpth;
		}
		if( sz_p ){
			size_pipe_buff = atoi( sz_p );
			if( size_pipe_buff < 128 && size_pipe_buff > (1*1024*1*1024) ){
				printf("Bad size_pipe_buff param.\n");
				usage(argv[0]);
				return 1;
			}
		}
		if ( !b_morpho )
			exit( 0 );

		if( cache ){
			key_pages = atoi(cache);
			if( strchr(cache,':') ){
				str_pages=atoi(strchr(cache,':')+1);
			}else{
				printf("Bad cache param.\n");
				usage(argv[0]);
				return 1;
			}
			if( key_pages < 100 || key_pages > 10000 ||
				str_pages < 100 || str_pages > 10000 ){
				printf("Bad cache param.\n");
				usage(argv[0]);
				return 1;
			}
		}
		setLimits();
		base = new TextsBase( basen );
		if( !base || !base->IsOk() ){
			printf("Can't check base %s, bailing out...\n",basen);
			if( base ) delete base ;
			return 1;
		}
		argv[optind]= (char*)base;
	}
	if (base) base->open_saw_bases (ACE_OS_O_RDONLY);
	NContxtIndex *ind= 0;
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N)
	if(argcZ < 0){
		get_docs_include_header_in_text().fill_set(base, *pdocs_include_header_in_text);
		get_gctx_kinds().fill_kindsset (base, *pgctx_kinds);
		ind = new N_WCI( base->keyFile, "Number", base->streamFile );
		ind->base= base;
		ind->buff_Norm= (char*)alloca(256);
		Lemmatize::execute("",ind);
		free(base->streamFile->m_deletedFat);
		base->streamFile->m_deletedFat= 0;
	}else
#endif
	{
		base->curr_mode |= ACE_OS_O_CREAT | ACE_OS_O_WRONLY;
#if !defined(WIN64) && !defined(MIN_MEM_CONTEXT)
#else
		Gind=
#endif
				ind = (NContxtIndex *)base->FindIndex(NameY);

		if(ind == 0)
			abort();
		ind->m_pNIdDelList= (long*)malloc(sizeof(*ind->m_pNIdDelList));
		ind->m_pNIdDelList[0]= 0x7ffffffc;
		ind->m_sNIdDelList= 1;
		base->curr_mode = ACE_OS_O_RDONLY;
		ind->maxItems=(maxmem==-1)?-1 :maxmem*(((1024*1024)/GROW_BY)/sizeof(long));
	}
	DocIterator *pIter= 0;
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N)
	ind->set_p_pipe_buff((char*)alloca(size_pipe_buff),size_pipe_buff);
	if(argcZ > 0){
		if (b_index_invisible)
			pIter = new DocInvIterator (base);
		else
			pIter= new DocIterator(0);
		ind->pIOuter= 0;
		std::deque<long> temp0;
		std::map< long,std::set<std::string> > temp1;
		gctx_nmain((YBase*)base, ind, pIter, temp0, temp1);
	}else
#endif
	{
		if (b_index_invisible)
			pIter = new DocInvIterator (base);
		else
			pIter= new DocIterator(base);

		ind->pIOuter= 0;
		gctx_nmain((YBase*)base, ind, pIter, *pdocs_include_header_in_text, *pgctx_kinds);
	}
	//printf("\nFinished, %d (max %d) nodes in cache.\nNow build 6tr, please wait...", ind->NormsCount, ind->m_NormlsBuffCount);
	delete pIter;
 	base->streamFile= 0;
	base->keyFile= 0;
	base->strFile= 0;
	if (argcZ > 0) {
		base->pOtherIndex = 0;
		delete base;
	}
	//printf("\rPlease, wait ...");

	if (argv[optind+1] && argc > 1) {
		FILE* out_file = fopen (argv[optind+1], "wt");
		for (std::map<long,std::vector<long> >::const_iterator it = map_doc_gctx_para_lens.begin (); it != map_doc_gctx_para_lens.end (); it++) {
			fprintf (out_file, "%ld:", it->first);
			for (std::vector<long>::const_iterator it2 = it->second.begin (); it2 != it->second.end (); it2++)
				fprintf (out_file, " %ld", *it2);
			fprintf (out_file, "\n");
		}
		fclose (out_file);
	}

	if (argv[optind+2] && argc > 2) {
		FILE* out_file = fopen (argv[optind+2], "wt");
		std::map<long, std::vector<u_int64_t> >::const_iterator map_len_it = map_doc_invisiblepos_fragmentlen.begin ();
		std::map<long, std::vector<u_int64_t> >::const_iterator map_rele_it = map_doc_invisibleblockpos_releplus.begin ();
		for (; map_len_it != map_doc_invisiblepos_fragmentlen.end (); map_len_it++, map_rele_it++) {
			fprintf (out_file, "%ld:", map_len_it->first);
			std::vector<u_int64_t>::const_iterator len_it = map_len_it->second.begin ();
			std::vector<u_int64_t>::const_iterator rele_it = map_rele_it->second.begin ();
			for (; len_it != map_len_it->second.end (); len_it++, rele_it++)
				fprintf (out_file, " %ld:%ld:%ld", (long)(*len_it >> 32), (long)(*len_it & 0xFFFFFFFF), (long)(*rele_it & 0xFFFFFFFF));
			fprintf (out_file, "\n");
		}
		fclose (out_file);
	}

	if (argv[optind+3] && argc > 3) {
		FILE* out_file = fopen (argv[optind+3], "wt");
		for (std::map<long, std::vector<u_int64_t> >::const_iterator map_rele_it = map_doc_invisiblepos_releplus.begin (); map_rele_it != map_doc_invisiblepos_releplus.end (); map_rele_it++) {
			fprintf (out_file, "%ld:", map_rele_it->first);
			for (std::vector<u_int64_t>::const_iterator rele_it = map_rele_it->second.begin (); rele_it != map_rele_it->second.end (); rele_it++)
				fprintf (out_file, " %ld:%ld", (long)(*rele_it >> 32), (long)(*rele_it & 0xFFFFFFFF));
			fprintf (out_file, "\n");
		}
		fclose (out_file);
	}

	return 0;
}

#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N)
int local_write(LPTHREAD_CNTX pCntxt)
{
    int argcZ= -(pCntxt->l_argc);
    char **argvZ= pCntxt->l_argv;
	return main_logic ( argcZ, argvZ );
}

CtxLongSet lsdef_00;
static u_intPointerV_tCtxLongSetSplayMap ttmpA(lsdef_00);

extern "C" {
	int snake_streams(	index_st *pin, LPPL_ZZZ pNew, long isLast, stream_st *pdstr,
						long *pPos, int (__cdecl *compL)(const void *, const void *))
	{
#if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
		if(write_stream(pdstr, pNew->readBuff, pNew->read) != pNew->read)
			return -1;

		  while(pNew->pInd->len > 0){
			pNew->read= pNew->pInd->len <= BUFF_SIZE_FROM_TEMP
							? pNew->pInd->len : BUFF_SIZE_FROM_TEMP;
if(pNew->read > pNew->in_mem){
	memcpy(pNew->readBuff, pNew->readBuff+(BUFF_SIZE_FROM_TEMP-pNew->in_mem), pNew->in_mem);
	::ACE_OS::read(pNew->file, pNew->readBuff+pNew->in_mem, pNew->read-pNew->in_mem+BUFF_SIZE_FROM_TEMP);
	pNew->in_mem= pNew->read+BUFF_SIZE_FROM_TEMP;
}else{
	if(pNew->in_mem >= BUFF_SIZE_FROM_TEMP){
		memcpy(pNew->readBuff, pNew->readBuff+(pNew->in_mem-BUFF_SIZE_FROM_TEMP), BUFF_SIZE_FROM_TEMP);
		pNew->in_mem= BUFF_SIZE_FROM_TEMP - pNew->read;
	}else{
		memcpy(pNew->readBuff, pNew->readBuff+(BUFF_SIZE_FROM_TEMP-pNew->in_mem), pNew->read);
		pNew->in_mem -= pNew->read;
	}
}
			pNew->pInd->len -= pNew->read;
			pNew->file_len -= pNew->read;
			if(write_stream(pdstr, pNew->readBuff, pNew->read) != pNew->read)
				return -1;
		  }
#endif
		return 0;
	}
}
static long preReRead_Stream(u_int64_tCtxLongSetSplayMap *pIndxs, NContxtIndex *pNIndx, stream_st *pstr, stref_st *pref, u_intPointerV_tCtxLongSetSplayMap *ptmpA, char *flushName)
{
	ptmpA->clear();
	u_int32_t pgsize;
	stream_st *pdstr= pstr+1;
	Pix ii;
	u_intFrm_tCtxLongSetSplayMap tmpF(pNIndx->lsdef);

	long NewVal= 0, startRead= 0, startProc= 0;
	int szBlockPointersN= pdstr->szBlockPointers, lookOlForms= 1, maxOld= pdstr->ref.size/32;
	char **ppN= pdstr->ppBlock;
#ifndef WIN64
	pdstr->ref.size= 0;
#endif
	pgsize = 1 << pstr->str->pgfile.pgpow;

	  ReParse_Stream(pIndxs, pNIndx, pstr, ptmpA, lookOlForms, &NewVal, &tmpF, ppN, -1, 0);
	  {
		int WithOldNumbers= 0, CompOk= 0;
		for( ii = ptmpA->first(); ii; ptmpA->next(ii) ){
			ptmpA->contents(ii).lastI= NewVal++;
		}
		pdstr->ref.size += (u_int32_t)(pdstr->curr_B & 0x7fffffff);pdstr->curr_B= 0;

		if(!pdstr->hDocsFile){
			pdstr->hDocsFile = -2;
	#ifndef WIN64
			if((g_iDocsCount*8+0x10000) > 64*1024*1024){
	#endif
					pdstr->pDeletedNorms= (char*)malloc(g_iDocsCount*8+0x10000);
	#ifndef WIN64
			}else
				pdstr->pDeletedNorms= (char*)malloc(64*1024*1024);

			if(!pdstr->hDocsFile){
				:: puts("\n ERROR: Not Memory for buff Doc's !");
				:: exit(-244);
			}
	#endif
		}
		ReParse_Stream(pIndxs, pNIndx, pstr, ptmpA, lookOlForms, &NewVal, &tmpF, ppN, WithOldNumbers, CompOk);
	  }
	return NewVal;
}

extern int attach_buff(stream_st *, stref_st *, index_st *pIndexOut);

static void ReRead_Stream(NContxtIndex *pNIndx, stream_st *pstr, stref_st *pref, u_intPointerV_tCtxLongSetSplayMap *ptmpA, char *flushName= 0)
{
	stream_st *pdstr= pstr+1;
	u_int64_tCtxLongSetSplayMap Indxs(pNIndx->lsdef);
	char **ppN= pdstr->ppBlock;

	long NewVal= preReRead_Stream(&Indxs, pNIndx, pstr, pref, ptmpA, flushName);
#ifndef WIN64
	if(pdstr->temp_flush_handle_GCTX){
		u_int32_t uu= 0;
		while(uu < pdstr->cblock)
			c_io_write(pdstr->temp_flush_handle_GCTX, pdstr->ppBlock[uu++], 0x10000);
		c_io_write(pdstr->temp_flush_handle_GCTX, pdstr->ppBlock[uu], pdstr->cboffs);
		int szFull= (int)(pdstr->ref.size & 0x7fffffff);
		c_io_lseek(pdstr->temp_flush_handle_GCTX, 0, ACE_OS_SEEK_SET);
		close_stream(pdstr);
		int bff_sz= 0xe000, ww_bff= szFull/bff_sz, ww_bff_lst= szFull%bff_sz;
		char *bff_wr= ppN[0] + (256 * 32);
		while(ww_bff--){
		  c_io_read(pdstr->temp_flush_handle_GCTX, bff_wr, bff_sz);
		  write_stream(pdstr, bff_wr, bff_sz);
		}
		c_io_read(pdstr->temp_flush_handle_GCTX, bff_wr, ww_bff_lst);
		write_stream(pdstr, bff_wr, ww_bff_lst);
		pdstr[-1].szBlockPointers= pdstr->szBlockPointers;
		pdstr[-1].bcount= pdstr->bcount;
		pdstr[-1].ppBlock= pdstr->ppBlock;
	}
	pNIndx->ReWrite_Stream(pdstr, &Indxs);
#endif
	pstr->flags |= SF_WRLOCK;

	attach_stream(pdstr, pref);
	close_stream(pdstr);
#ifndef WIN64
	pdstr->refs_count += pstr->hDocsFile;
#endif
	attach_buff(pdstr, pref - 2, 0);

	pdstr->ArrayIOffsCount= NewVal;
	pdstr->ppBlock= ppN;
	pdstr->szBlockPointers= 32;
	pdstr->bcount= 1;
}

void N_WCO::CopyAsFlushN(	void *vspit, void *vpdstr, void *vpsstr, void *vpin, long *prPos,
									int (__cdecl *compL)(const void *, const void *),
									int (__cdecl *compN)(const void *, const void *))
{
#if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
	pNIndexReRead= this;
	iter_st *spit= (iter_st *)vspit;
	stream_st *pdstr= (stream_st *)vpdstr, *psstr= (stream_st *)vpsstr;
	index_st *pin= (index_st *)vpin;
	///////////////////////////////////////////////////////////////////
		pdstr[1].flags= (pdstr[0].flags |= SF_NOALLOC);
		u_int64_t AllSizeTemp= 0, ReadFromTemp= 0;
		int ii, jj= FlashCount;
		set_st m_stNIdDelList;
		m_stNIdDelList.pSkipDoc= m_pNIdDelList;
		m_stNIdDelList.SkipDocCount= m_sNIdDelList;
		LPPL_ZZZ *kk= (LPPL_ZZZ*)alloca(sizeof(PL_ZZZ*)*FlashCount);
#ifndef WIN64
		LPPL_YYY pIndsTMP= (LPPL_YYY)malloc(sizeof(PL_YYY)*1024*FlashCount);
#endif
		pIndsCount= FlashCount;
		for(ii= 0; ii < jj; ii++){
			{
#ifndef WIN64
				::ACE_OS::lseek(indxs[ii].file, indxs[ii].file_len, ACE_OS_SEEK_SET);indxs[ii].file_len -= sizeof(long);
				::ACE_OS::read(indxs[ii].file, &lastDocFromTemp, sizeof(long));
				::ACE_OS::read(indxs[ii].file, &(indxs[ii].next_in_buf), sizeof(long));

				indxs[ii].pInd= pIndsTMP+(ii*1024);
				indxs[ii].next_in_buf= 0;
	#ifdef MIN_MEM_CONTEXT
				::ACE_OS::read(indxs[ii].file, indxs[ii].pInd, 1024*sizeof(*indxs[ii].pInd));
	#else
				int aa= 1024;
				while(aa-- && ::ACE_OS::read(indxs[ii].file, indxs[ii].pInd, 1) > 0){
						indxs[ii].FileName= (char*)malloc(1+(0x3f & *(char*)(indxs[ii].pInd)));
						*(indxs[ii].FileName)= *(char*)(indxs[ii].pInd);
					{
						indxs[ii].FileName[::ACE_OS::read(indxs[ii].file, indxs[ii].FileName+1, (0x3f & *(char*)(indxs[ii].pInd))-1)+1]= 0;
						indxs[ii].pInd->k= indxs[ii].FileName;
						::ACE_OS::read(indxs[ii].file, &(indxs[ii].pInd->len), 4);
					}
					indxs[ii].pInd++;
				}
				indxs[ii].pInd= pIndsTMP+(ii*1024);
	#endif
				indxs[ii].max_size_saved_Node= ::ACE_OS::lseek(indxs[ii].file, 0, ACE_OS_SEEK_CUR);
				if(::ACE_OS::lseek(indxs[ii].file, sizeof(long), ACE_OS_SEEK_SET) == sizeof(long))
				{
					indxs[ii].FileName= (char*)ii;
				}
#else
				lastDocFromTemp= indxs[FlashCount].in_mem;
				indxs[ii].file_len -= sizeof(long);
				::ACE_OS::lseek(indxs[ii].file, sizeof(long), ACE_OS_SEEK_SET);
#endif
			}
			kk[ii]= indxs+ii;
		}
		for(ii= 0; ii < jj; ii++){
			kk[ii]->readBuff= (char*)malloc(BUFF_SIZE_FROM_TEMP + BUFF_SIZE_FROM_TEMP + sizeof(long));
			kk[ii]->read= kk[ii]->pInd->len <= BUFF_SIZE_FROM_TEMP ? kk[ii]->pInd->len : BUFF_SIZE_FROM_TEMP;
			::ACE_OS::read(kk[ii]->file, kk[ii]->readBuff, BUFF_SIZE_FROM_TEMP);
			kk[ii]->in_mem= BUFF_SIZE_FROM_TEMP - kk[ii]->read;
			kk[ii]->file_len -= kk[ii]->read;
			kk[ii]->pInd->len -= kk[ii]->read;
			AllSizeTemp += kk[ii]->file_len;
		}
		create_stream(pin, pdstr);
		create_stream(pin, pdstr+1);
		ii= ::strlen(file->FileName)-3;
		memcpy(name_temp_flush_handle, file->FileName, ii);
		memcpy(name_temp_flush_handle+ii, "flush.tmp", 10);
#ifndef WIN64
	char zName_B[1024];*zName_B=0;
#endif
		while(FlashCount){
			qsort( kk, FlashCount, sizeof(LPPL_ZZZ), compL);
		  pp_ctxTextCacheArray[0]->SetItemInNode(key_buff, (*kk)->pInd->k);

pref00 = get_stref_ex( key_buff, pin->hdr.keylen, pin->hdr.strinfo.immds, pin->hdr.nstreams, 2);

			for(ii= 1; ii <  FlashCount && !compL(kk+ii, kk+ii-1); ii++);
			qsort( kk, ii, sizeof(LPPL_ZZZ), compZZZ1);
			for(jj= 0; jj < ii; jj++){
			  if(jj+1 < ii){
				snake_streams(pin, kk[jj], jj,	pdstr, prPos, compN);
#ifndef WIN64
				if(pdstr->ref.size > 0x20000000 &&
					(
						(key_buff[0] & 0x80)
							||
						(key_buff[0] == 2 && ((key_buff[1]==-62)||(key_buff[1]==-56)||(key_buff[1]==-47)||(key_buff[1]==-50)||(key_buff[1]==-61)))
							||
						(key_buff[0] == 3 && (	(key_buff[1]==-51 && key_buff[2]==-64)
												||
												(key_buff[1]==-50 && key_buff[2]==-46)
												||
												(key_buff[1]==-49 && key_buff[2]==-50)	))
					))
				{
					stream_st *pdstr1= pdstr+1;
					u_int64_tCtxLongSetSplayMap Indxs1(lsdef);
					char **ppN1= pdstr1->ppBlock;

					long NewVal1= preReRead_Stream(&Indxs1, this, pdstr, pref00, &ttmpA, 0);
					int size1= (int)(pdstr1->ref.size & 0x7fffffff);
					pdstr1->flags |= SF_WRLOCK;
					{
						if(!pdstr1->temp_flush_handle_GCTX){
							::strcpy(zName_B, ((pgfile_st*)pdstr1->str)->PrmExt.FileName);
							::strcat(zName_B,".b.tmp");
							pdstr1->temp_flush_handle_GCTX = c_io_open(zName_B, ACE_OS_O_RDWR | ACE_OS_O_TRUNC | ACE_OS_O_CREAT | ACE_OS_O_BINARY);
						}
						u_int32_t uu= 0;
						while(uu < pdstr1->cblock)
							c_io_write(pdstr1->temp_flush_handle_GCTX, pdstr1->ppBlock[uu++], 0x10000);
						c_io_write(pdstr1->temp_flush_handle_GCTX, pdstr1->ppBlock[uu], pdstr1->cboffs);

						close_stream(pdstr1);
					}
					pdstr1->ArrayIOffsCount= NewVal1;
					pdstr1->ppBlock= ppN1;
					pdstr1->szBlockPointers= 32;
					pdstr1->bcount= 1;
					pdstr1->curr_B += size1;
					close_stream(pdstr);
				}
#endif
			}else
				snake_streams(pin, kk[jj], 3333,pdstr, prPos, compN);
#if !defined(WIN64) && !defined(MIN_MEM_CONTEXT)
				free(kk[jj]->pInd->k);
#endif
				if(kk[jj]->file_len < 1){
					::ACE_OS::close(kk[jj]->file);
#ifdef MIN_MEM_CONTEXT
					char tmpBaseName[256], *fnd= strrchr(file->FileName, '.');
					*fnd= 0;
					sprintf(tmpBaseName, pTempFileFormat, file->FileName, kk[jj]->FileName);
					*fnd= '.';
					ace_os_unlink(tmpBaseName);
#endif
					memcpy(kk+jj, kk+jj+1, (FlashCount-jj-1)*sizeof(LPPL_ZZZ));
					jj--;
					ii--;
					FlashCount--;
				}else{
#ifndef WIN64
					kk[jj]->next_in_buf++;
					if(kk[jj]->next_in_buf == 1024){
						kk[jj]->pInd -= kk[jj]->next_in_buf-1;
						kk[jj]->read= ::ACE_OS::lseek(kk[jj]->file, 0, ACE_OS_SEEK_CUR);
						::ACE_OS::lseek(kk[jj]->file, kk[jj]->max_size_saved_Node, ACE_OS_SEEK_SET);
#ifdef MIN_MEM_CONTEXT
						kk[jj]->max_size_saved_Node +=  ::ACE_OS::read(kk[jj]->file, kk[jj]->pInd, 1024*sizeof(*(kk[jj]->pInd)));
#else
						int aa= 1024;
						kk[jj]->max_size_saved_Node= (int)(kk[jj]->FileName);
						while(aa-- && ::ACE_OS::read(kk[jj]->file, kk[jj]->pInd, 1) > 0){
								kk[jj]->FileName= (char*)malloc(1+(0x3f & *(char*)(kk[jj]->pInd)));
								*(kk[jj]->FileName)= *(char*)(kk[jj]->pInd);
							{
								kk[jj]->FileName[::ACE_OS::read(kk[jj]->file, kk[jj]->FileName+1, (0x3f & *(char*)(kk[jj]->pInd))-1)+1]= 0;
								kk[jj]->pInd->k= kk[jj]->FileName;
								::ACE_OS::read(kk[jj]->file, &(kk[jj]->pInd->len), 4);
							}
							kk[jj]->pInd++;
						}
						kk[jj]->pInd= pIndsTMP+(kk[jj]->max_size_saved_Node*1024);
						kk[jj]->FileName= (char*)(kk[jj]->max_size_saved_Node);
						kk[jj]->max_size_saved_Node= ::ACE_OS::lseek(kk[jj]->file, 0, ACE_OS_SEEK_CUR);
#endif
						kk[jj]->next_in_buf= 0;
						::ACE_OS::lseek(kk[jj]->file, kk[jj]->read, ACE_OS_SEEK_SET);
					}else
#endif
						kk[jj]->pInd++;
					//
	kk[jj]->read= kk[jj]->pInd->len <= BUFF_SIZE_FROM_TEMP ? kk[jj]->pInd->len : BUFF_SIZE_FROM_TEMP;
					if(kk[jj]->read > kk[jj]->in_mem){
						memcpy(kk[jj]->readBuff, kk[jj]->readBuff+(BUFF_SIZE_FROM_TEMP-kk[jj]->in_mem), kk[jj]->in_mem);
						::ACE_OS::read(kk[jj]->file, kk[jj]->readBuff+kk[jj]->in_mem, kk[jj]->read-kk[jj]->in_mem+BUFF_SIZE_FROM_TEMP);
						kk[jj]->in_mem= kk[jj]->read+BUFF_SIZE_FROM_TEMP;
					}else{
						if(kk[jj]->in_mem >= BUFF_SIZE_FROM_TEMP){
							memcpy(kk[jj]->readBuff, kk[jj]->readBuff+(kk[jj]->in_mem-BUFF_SIZE_FROM_TEMP), BUFF_SIZE_FROM_TEMP);
							kk[jj]->in_mem= BUFF_SIZE_FROM_TEMP - kk[jj]->read;
						}else{
							memcpy(kk[jj]->readBuff, kk[jj]->readBuff+(BUFF_SIZE_FROM_TEMP-kk[jj]->in_mem), kk[jj]->read);
							kk[jj]->in_mem -= kk[jj]->read;
						}
					}
					kk[jj]->pInd->len -= kk[jj]->read;
					kk[jj]->file_len -= kk[jj]->read;
				}
			}
			*prPos= 0;
			{
				{
					ReRead_Stream(this, pdstr, pref00, &ttmpA);
#ifndef WIN64
					if(*zName_B != 0){
						pdstr[1].curr_B= 0;
						c_io_close(pdstr[1].temp_flush_handle_GCTX);pdstr[1].temp_flush_handle_GCTX= 0;
						ace_os_unlink(zName_B); *zName_B= 0;
					}
					if(pdstr[0].ref.size > ( ContextSearch::POS_TEXT * (4+4) )
						&& max_size00 < (pdstr[0].ref.size - ( ContextSearch::POS_TEXT * (4+4) )))
						max_size00= (pdstr[0].ref.size - ( ContextSearch::POS_TEXT * (4+4) ));
#endif
				}
				close_stream(pdstr+1);
			}
			SetFormsData(&ttmpA, key_buff, pin, pdstr);
			close_stream(pdstr);
#ifdef WIN64
			pdstr->ref.alloc= 0;
#endif
			add_key(pin, key_buff);
		}
		pdstr->flags &= ~SF_NOALLOC;
		close_stream(pdstr);
		memset(pdstr, 0, sizeof(*pdstr));
#ifndef WIN64
		if((psstr-1)->hDocsFile > 0){
			char zName[1024];
			::strcpy(zName, ((pgfile_st*)(psstr-1)->str)->PrmExt.FileName);
			::strcat(zName,".tmp");
			c_io_close((psstr-1)->hDocsFile);
			(psstr-1)->hDocsFile= 0;
			ace_os_unlink(zName);
		}
#endif
		CloseBlockMap(pin+4, pdstr+7);
		if(NormalFromPointer){
			for(ii= 0; ii < pIndsCount; ii++){
				free(indxs[ii].readBuff);
				indxs[ii].readBuff= 0;
			}
#ifndef WIN64
			free(pIndsTMP);
#endif
			if(indxs)
				free(indxs);
		}
#endif
}

extern "C" void flush_streams_file(base_st *, streamfile_st *);

char *Ggs_target_name;
index_st *Gpin;
iter_st *Gspit;
stream_st *Gpdstr;
base_st GthisBase, *Gptarget;

void N_WCI::FlushAllParaWords()
{
	if(!hFlushAllParaWords){
#if !defined(WIN64) && !defined(MIN_MEM_CONTEXT)
		char tmpBaseName[256], *fnd= strrchr(file->FileName, '.');
		*fnd= 0;
		sprintf(tmpBaseName, pTempFileListFormat, file->FileName);
		if((hFlushAllParaWords= c_io_open(tmpBaseName, ACE_OS_O_CREAT|ACE_OS_O_WRONLY|ACE_OS_O_BINARY)) != -1){
			hNameFlushAllParaWords= strdup(tmpBaseName);
		}
		*fnd= '.';
#else
		hFlushAllParaWords= 3;
		void *p_UpdThdr;
		Gptarget= makeBaseForCopy(	base, GthisBase, Gind->file, Gind->streams, m_pNIdList, Gind->Root,
										Gind->Name, Gind->Name, &p_UpdThdr, &Ggs_target_name, &Gpin, &Gspit, &Gpdstr);
		char *pBuffs= Gptarget->key.name;
		Gptarget->key.name= Gind->file->FileName;
		c_io_close(Gind->file->GetFileHandle());
		c_io_close(Gind->streams->file->GetFileHandle());
		create_index(Gptarget, base->m_SWordsName, Gpin);
		make_BlocksIndex(Gptarget,Gpin+4, Gpdstr+7);
		Gptarget->key.name= pBuffs;

		Gpdstr->flags |= SF_NOALLOC;
		create_stream(Gpin, Gpdstr);
#endif
	}
#if !defined(WIN64) && !defined(MIN_MEM_CONTEXT)
	if(hFlushAllParaWords != -1){
		c_io_write(hFlushAllParaWords, &m_ID, sizeof(m_ID));
		c_io_write(hFlushAllParaWords, pPutWordPosCount, (AllParaCount+1) * 3);
	}
#else
	key_buff[0]= m_ID;
	write_stream(Gpdstr, pPutWordPosCount+3, AllParaCount*3);
	attach_stream(	Gpdstr, get_stref_ex(	(char*)key_buff, Gpin->hdr.keylen, Gpin->hdr.strinfo.immds, Gpin->hdr.nstreams, 0));
	close_stream(Gpdstr);
	add_key(Gpin, key_buff);
#endif
}

void N_WCO::CopyAsFlush(DocIterator *pUpDoc)
{
#if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
	if(FlashCount > -1){
		CloseLastTemp();
		///////////////////////////////////////////////////////////////////
		streamfile_st *str0;
		pgfile_st *pfIndex1, *pfIndex2;
		streamfile_st *pfIndex1str, *pfIndex2str;
		char FormsIName[]= "NFContxt.str";
 /*#ifndef NOT_NEW_FILES_FOR_NFCONTEXT
		streamfile_st *str00;
 #endif*/
		if(m_pNIdList == (long*)-1){
			base= pFirst;
		}
		printf("\nClose NDT texts reading thread.\nMerge results as '%s' index... ", base->m_SWordsName);
#if !defined(WIN64) && !defined(MIN_MEM_CONTEXT)
		void *p_UpdThdr;
		Gptarget= makeBaseForCopy(	base, GthisBase, file, streams, m_pNIdList, Root,
										Name, Name, &p_UpdThdr, &Ggs_target_name, &Gpin, &Gspit, &Gpdstr);
#endif
		index_st *prin= Gpin + 1;
		stream_st *psstr= Gpdstr + 2;
		long rPos= 0;
		char *pBuffs= Gptarget->key.name;
#if !defined(WIN64) && !defined(MIN_MEM_CONTEXT)
		Gptarget->key.name= file->FileName;
		c_io_close(file->GetFileHandle());
		c_io_close(streams->file->GetFileHandle());
		create_index(Gptarget, base->m_SWordsName, Gpin);
		make_BlocksIndex(Gptarget,Gpin+4, Gpdstr+7);
		Gptarget->key.name= pBuffs;
#endif
		int ii, jj;
		Index *Forms= 0;

		int sNodes= 0;
		Form_Node *pPut= 0;
		if(hFlushAllParaWords && hFlushAllParaWords != -1){
#if !defined(WIN64) && !defined(MIN_MEM_CONTEXT)
			int countRead;
	#ifdef WIN32
			__int64 FlushSize= ::_lseeki64(hFlushAllParaWords, 0, ACE_OS_SEEK_CUR);
	#else
			ACE_HANDLE handleFlushAllParaWords = (ACE_HANDLE)(hFlushAllParaWords);
			ACE_LOFF_T FlushSize= ::ACE_OS::llseek(handleFlushAllParaWords, 0, ACE_OS_SEEK_CUR);
	#endif
			c_io_close(hFlushAllParaWords);
			if((hFlushAllParaWords= c_io_open(hNameFlushAllParaWords, ACE_OS_O_RDONLY|ACE_OS_O_BINARY)) == -1){
				exit(-213);
			}
			Gpdstr->flags |= SF_NOALLOC;
			create_stream(Gpin, Gpdstr);
			while(FlushSize > 0){
				FlushSize -= c_io_read(hFlushAllParaWords, key_buff, sizeof(long));
				countRead= 0;
				FlushSize -= c_io_read(hFlushAllParaWords, &countRead, 3);
				countRead *= 3;
				FlushSize -= c_io_read(hFlushAllParaWords, pAllWordPos, countRead);
				write_stream(Gpdstr, pAllWordPos, countRead);
				attach_stream(	Gpdstr
								, get_stref_ex(	key_buff, Gpin->hdr.keylen, Gpin->hdr.strinfo.immds, Gpin->hdr.nstreams, 0));
				close_stream(Gpdstr);
				add_key(Gpin, key_buff);
			}
			c_io_close(hFlushAllParaWords);
			ace_os_unlink(hNameFlushAllParaWords);
			delete []pAllWordPos; pAllWordPos= 0;
			free(hNameFlushAllParaWords); hNameFlushAllParaWords= 0;
#endif
			hFlushAllParaWords= 0;
			close_stream(Gpdstr);
			pgfile_st *pf0= Gpin->pf;
			str0= Gpin->str;
			close_index(Gpin);
			memset(Gpin, 0, sizeof(index_st));
			create_index_hack(pf0, NameY, Gpin);
			Gpin->str= str0;
			Gpin->pbase= Gptarget;
		}else if(merge_doc_index_names){
			merge_doc_index_names += 256;
			merge_doc_index_count--;
			pgfile_st *pkm= (pgfile_st *)alloca(merge_doc_index_count*sizeof(*pkm));
			streamfile_st *strm= (streamfile_st *)alloca(merge_doc_index_count*sizeof(*strm));
			index_st *pinm= (index_st *)alloca(merge_doc_index_count*sizeof(*pinm));
			iter_st *spitm= (iter_st *)alloca(merge_doc_index_count*sizeof(*spitm));
			int oo= 0, ee;
			long LastDoc;
			char *f1= strrchr(Gpin->pf->name, '.'), *f2= strrchr(Gpin->str->pgfile.name, '.'), *f3, *f4;

			memset(pkm, 0, merge_doc_index_count*sizeof(*pkm));
			memset(strm, 0, merge_doc_index_count*sizeof(*strm));
			memset(pinm, 0, merge_doc_index_count*sizeof(*pinm));
			memset(spitm, 0, merge_doc_index_count*sizeof(*spitm));
			while(oo < merge_doc_index_count){
				f3= merge_doc_index_names + oo * 256;
				f4= strrchr(f3, '\0');
				memcpy(f4, f1, 5);
				open_pgfile(f3, pkm + oo);
				pkm[oo].PrmExt.pCrptTag= Gpin->pf->PrmExt.pCrptTag;
				memcpy(f4, f2, 5);
				open_pgfile(f3, &strm[oo].pgfile);
				strm[oo].pgfile.PrmExt.pCrptTag= Gpin->pf->PrmExt.pCrptTag;
				load_fat(strm + oo);
				init_streams_cache(strm + oo, OBSC_SEQSP | OBSC_LARGE);
				open_index_hack(pkm + oo, Gpin->name, pinm + oo);
				pinm[oo].str= strm + oo;
				init_iter(pinm + oo, spitm + oo);
				first_key(spitm + oo);
				oo++;
			}
			do{
				qsort(spitm, oo, sizeof(*spitm), compare_iter_st_long);
				LastDoc= 0;
				for(ee= 0; ee < oo; ee++){
					if(LastDoc != *(long*)spitm[ee].pkey){
						//load_Stream_ex(spitm[ee].str, (pref = get_stref(spitm+ee, 0)),
						//										psstr, &(spitm[ee].strinfo));
						//move_Stream(psstr, Gpin->str, pref);
						//add_key(Gpin, spitm[ee].pkey);
						release_stream(psstr);
						LastDoc= *(long*)spitm[ee].pkey;
					}
					if(!next_key(spitm + ee)){
						oo--;
						release_iter(spitm+ee);
						memcpy(spitm + oo, spitm + oo + 1, (ee - oo) * sizeof(*spitm));
						ee--;
					}
				}
			}while(oo);
			close_stream(Gpdstr);
			pgfile_st *pf0= Gpin->pf;
			str0= Gpin->str;
			close_index(Gpin);
			for(ee= 0; ee < merge_doc_index_count; ee++){
				if(pinm[ee].str->cache) free(pinm[ee].str->cache);
				if(pinm[ee].str->centries) free(pinm[ee].str->centries);
				if(pinm[ee].str->fat) free(pinm[ee].str->fat);
				close_pgfile(pkm+ee);
				close_pgfile(&strm[ee].pgfile);
			}
			memset(Gpin, 0, sizeof(index_st));
			create_index_hack(pf0, Name, Gpin);
			Gpin->str= str0;
			Gpin->pbase= Gptarget;
		}
		Gpin->trunc_NContxt_str= truncation_NContxt_stream;
		if(rootNodeKey){
			close_indexEx(Gpin, p_UpdThdr);
		}else{
	(Gpdstr+1)->flags &= ~SF_NOALLOC;
	close_stream(Gpdstr+1);
	pgfile_st *pf0= Gpin->pf;
	pfIndex1= pf0;
	pfIndex1str= Gpin->str;
	str0= Gpin->str;
	index_st *pinn= (index_st *)calloc(1, sizeof(index_st));
	stream_st *pdstrn= (stream_st *)calloc(1, sizeof(stream_st));
	pBuffs= Gptarget->key.name;

	Gptarget->key.name= file->FileName;
	create_index(Gptarget, FormsIName, pinn);
	Gptarget->key.name= pBuffs;
	create_stream(pinn, pdstrn);
	pfIndex2= pinn->pf;
	pfIndex2str= pinn->str;
	pdstrn->flags |= SF_NOALLOC;

	printf("Ok.\nMerge results as '%s' index... ", Gpin->name);
/*#if !defined(WIN64) && !defined(MIN_MEM_CONTEXT)
	free (pBufForNormals);pBufForNormals = 0; // была в темпы класть нормы
#endif*/
	CopyAsFlushN(Gspit, Gpdstr, psstr, Gpin, &rPos, compZZZ, CompStringsZZZ);
	// minimize Mem	//
	printf("Ok.\nMerge results as '%s' index... ", pinn->name);
	{
		u_intFormOld_tCtxLongSetSplayMap tmpFOld(lsdef);
		char *pkey;
		CtxLongSet *sp;
		Pix i = 0; // GARANT_FORSCOPING
		for( i = pp_ctxTextCacheArray[0]->first(); i; pp_ctxTextCacheArray[0]->next(i) ){
			pkey= (char*)pp_ctxTextCacheArray[0]->pkey(i);
			sp= &pp_ctxTextCacheArray[0]->contents(i);
			if(!sp->capacity){
				continue;
			}
			if(sp->capacity == -1)
				continue;
			pkey= (char*)pp_ctxTextCacheArray[0]->pkey(i);
			if((*pkey & 0x7f) > MAX_VAL_STR_AS_KEY){
				pp_ctxTextCacheArray[0]->SetItemInNode( key_buff, pkey);
				key_buff[*pkey]= 0;
				tmpFOld[(void*)(key_buff+1)];
			}else{
				tmpFOld[(void*)(pkey+1)];
			}
			tmpFOld.root->cont= *sp;
			tmpFOld.root->cont.e= (long*)i;
		}
		{
			for( i = tmpFOld.first(); i; tmpFOld.next(i) ){
				tmpFOld.SetItemInNode( key_buff, tmpFOld.pkey(i));
				char *pNxtN;
				sp= &tmpFOld.contents(i);
				if(!sp->capacity)
					abort();
				else{
					pkey= key_buff;
					write_stream(pdstrn, &sp->capacity, sizeof(sp->capacity));
					if(NormalFromPointer)
						GetKeyBuff((long**)&pNxtN, (u_int64_tCtxLongSetSplayNode*)(sp->e));
					for(jj = 1; jj <= sp->lastI; jj++){
						if(!NormalFromPointer)
							pNxtN= (char*)sp->e[jj-1];
						if((short)jj == ((short*)&sp->capacity)[1] >> 8){
							write_stream(pdstrn, pNxtN, 32);
							break;
						}
						if(NormalFromPointer)
							SetNextKeyBuff((long**)&pNxtN);
					}
					attach_stream(	pdstrn
									, get_stref_ex(	pkey, Gpin->hdr.keylen, Gpin->hdr.strinfo.immds, Gpin->hdr.nstreams, 0));
					close_stream(pdstrn);
				}
				add_key(pinn, pkey);
			}
		}
	}
	//
	close_index(pinn);
	close_stream(pdstrn);
	Gptarget->flags |= BF_OPTIMAL;
	flush_streams_file(Gptarget,&(Gptarget->str));
	flush_streams_file(Gptarget,pinn->str);
	free(pdstrn);
	free(pinn->name);free(pinn);
	//
	close_index(Gpin);free(Gpin->name);

	if(!NormalFromPointer){
		free(pInds);
		if(indxs)
			free(indxs);
	}
	FreeFprmsBuffs();
		}
		Gptarget->key.name= pBuffs;
		FlashCount--;
		free(Ggs_target_name);
		Ggs_target_name= Gptarget->ndt.name;
		if(!rootNodeKey /*Root != -1*/){
			Gptarget->key.mode= ACE_OS_O_RDONLY;
			close_base(Gptarget);
			pBuffs= strrchr(Ggs_target_name, '.');
			strcpy(pBuffs+1, "key");ace_os_unlink(Ggs_target_name);
			strcpy(pBuffs+1, "str");ace_os_unlink(Ggs_target_name);
// нет необходимости в рамаках утилиты продалжать //
strcpy(pBuffs+1, "ndt");
ace_os_unlink(Ggs_target_name);
printf("Ok.\n");
exit(0);
//
			if(!m_pNIdList){
				if((ii= c_io_open(file->FileName, ACE_OS_O_RDONLY)) == -1
					|| (jj= c_io_open(streams->file->FileName, ACE_OS_O_RDONLY)) == -1){
					exit(-18);
				}
				file->SetFileHandle(ii); *file->m_postFileHandles= ii;
				streams->file->SetFileHandle(jj);*streams->file->m_postFileHandles= jj;
			}
			strcpy(pBuffs+1, "ndt");
		}else
			close_base(Gptarget);
		::free(((pgfile_st *)&Gptarget->key)->PrmExt.pCrptTag);
		::free(((pgfile_st *)&Gptarget->str)->PrmExt.pCrptTag);
		free(Gptarget);
		::free((psstr-1)->ppBlock);
		::free(psstr->ppBlock);
		free(Gpdstr);
		free((prin-1)->name); (prin-1)->name= 0;
		free(prin->name); prin->name= 0;
		free(prin->pf);
		free(prin->str);
		free(Gpin);
		free(streams->file->SystemPageBuf);
		free(file->SystemPageBuf);
		ace_os_unlink(Ggs_target_name);
		free(Ggs_target_name);
	}
#elif defined(STORE_FORM_N) && !defined(GARANT_TOOLS)
	this->FreeFprmsBuffs ();

	if (m_pNIdDelList) {
		free (m_pNIdDelList);
		m_pNIdDelList = 0;
	}
#endif
#endif
	printf("Ok.\n");
}

extern int open_pgfile_from_PagedFile(PagedFile *pClass, pgfile_st *pFile);

void open_pgfiles_from_Base(base_st& thisBase, PagedFile *file, StreamFile * streams)
{
#if defined(MIN_MEM_CONTEXT) || defined(MRG_MERGE_CNTX)
  #ifndef MIN_MEM_CONTEXT
	char *pNK= ::strrchr(file->FileName, '.');
	*pNK= 0;
	pNK= ::strrchr(streams->file->FileName, '.');
	*pNK= 0;
	int NKfile = c_io_open(file->FileName,	ACE_OS_O_RDWR | ACE_OS_O_BINARY | ACE_OS_O_CREAT
  #ifdef BRDR32
								| ACE_OS_O_EXCL
  #endif
								);
	int NSfile = c_io_open(streams->file->FileName,	ACE_OS_O_RDWR | ACE_OS_O_BINARY | ACE_OS_O_CREAT
  #ifdef BRDR32
								| ACE_OS_O_EXCL
  #endif
								);
/*	file->m_mode= ACE_OS_O_RDWR | ACE_OS_O_CREAT
  #ifdef BRDR32
								| ACE_OS_O_EXCL
  #endif
		;
*/	file->SetFileHandle(NKfile);
	streams->file->SetFileHandle(NSfile);
	char pNullsBuf[4096];
	c_io_lseek(NSfile,4096,ACE_OS_SEEK_SET);
	memset(pNullsBuf,0,4096);
	c_io_write(NSfile,pNullsBuf, 4096);
	c_io_lseek(NSfile,0,ACE_OS_SEEK_SET);
	//short FFPages= 1;
	//streams->file->PutAttr( "FatSize", &FFPages, sizeof ( short ) );
  #endif
	if(!open_pgfile_from_PagedFile(file, &thisBase.key)
			||
			!open_pgfile_from_PagedFile(streams->file, &thisBase.str.pgfile))
		exit(-4);

	if(!load_fat(&thisBase.str))
#endif
		exit(-5);
}

#ifdef MRG_MERGE_CNTX
	extern "C"
	{
		char* flog(char *format, ...)
		{
			return 0;
		}
		int gb_set_last_error(int err, ...) // TODO : check for err and obtain parameters
		{
			return -1;
		}
	}
#endif