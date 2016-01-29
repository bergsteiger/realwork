#include "shared/Core/fix/mpcxc.h"
#include "shared/Core/fix/wine.h"

/*
 * $Id: update.cpp,v 1.1 2014/12/05 11:10:24 young Exp $
 */
			      // update.cpp //
///////////////////////////////////////////////////////////////////////////////
//									     //
// Purpose:								     //
//	Define the main and main_update procedures			     //
//									     //
// Author:								     //
//	Garant-Service							     //
//									     //
///////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/AutoInit.h"
#include "shared/Core/os/IniFile.h"

#include "garantPIL/implementation/component/cpp/libs/cchlp/src/QMap.hpp"

#include "gu_ver.h"
#include <unistd.h>
#include <cstdio>
#include <cstring>
#include <fcntl.h>
#include <ctime>
#include <locale.h>

#include "ncpf.h"
#include "garutils.h"
#include "deltadef.h"
#include "dltcomon.h"
#include "unfull.h"
#include "SearchB.h"
#include "dhreader.h"
#include "basemask.h"
#include "garver.h"
#include "Logger.h"
#include "adds.h"
#include "osdep.h"
#include "pscreen.h"
#include "timer.h"

///////////////////////////////////////////////////////////////////////////////

#ifdef N_MALLOC
	#include "n_malloc.h"
#endif

#ifdef unix
	#define FILE_NAME_MAX 256
#endif

#define G_RESERVED_SIZE	1024*16

#if defined (__CYGWIN32__)
	#define TEST_MALLOC
#endif

#ifdef TEST_MALLOC
	#define TM_MALL_SIZE	1024*64
	#define TM_CYCLE_COUNT	100
	#define TM_SLIP_COUNT 100
#endif

///////////////////////////// global variables ////////////////////////////////

extern	short	DELTA_DATA_VERSION;

char	err_BaseDate[255];
char	err_UpDateFrom[255];
char	err_UpDateTo[255];
int	err_Segment;

void	*g_pReserved = 0;
UnFull	*g_pUnFull = 0;
Base	*g_pBase = 0;
bool	b_skipturbo = false;
bool	b_updateonlyturbo = false;
bool	b_updateonlyturboplus = false;

ProgressScreen* screen;

///////////////////////////////////////////////////////////////////////////////

#ifndef _EXTERN_MAIN
	#define UPDATEEXIT	exit( EXIT_FAILURE );
	#include "gsscreen.h"

	code_t out = cd_win; //mpcxc_cd_cursys();

	LogScreen tracer;
	Logger logger;
#else
	#define UPDATEEXIT	return -1;
	extern Logger logger;
#endif

///////////////////////////////////////////////////////////////////////////////

#ifdef N_MALLOC
	int mallocReserved (void)
	{
		return g_pReserved ? 0 : (int)(g_pReserved = malloc ( G_RESERVED_SIZE ));
	}

	static char gmess_pErrDPMI [] = "Недоступна DPMI память";

	void	pmhUnDiffMallocHandler(void)
	{
		if ( g_pReserved )
		{
			free ( g_pReserved );
			g_pReserved = 0;

			if ( g_pUnFull ) {
				if ( g_pUnFull -> MemFree () ) {
					g_pReserved = malloc ( G_RESERVED_SIZE );
					if ( !g_pReserved )
						g_pUnFull -> SetUseReservedFlag ();
				} else {
					g_pUnFull -> SetUseReservedFlag ();
				}
			}
		} else {
			logger.printf ( lt_fatal, "%d:%s\n", ERR_DPMINOMEM, gmess_pErrDPMI );
			if ( g_pBase ){
				Base* pForDel = g_pBase;
				g_pBase = 0;
				delete pForDel;
			}
			UPDATEEXIT;
		}
	}
#endif

//////////////////////////// main and main_update /////////////////////////////
#ifdef MULTI_INDEX_STREAM_FILE
	#include "dociter.h"
	static ProgressScreen* pLocalCurrProgressScreen;
#ifndef	GARANT_TOOLS
	int __stdcall LocalSetProgress(int value){
		return pLocalCurrProgressScreen->SetProgress(value);
	}
#endif
	class	LocalDocIterator : public DocIterator
	{
	public:
		long *m_plist, CurrPos;
		LocalDocIterator( long *pList );
		void Rewind()
		{
			CurrPos= 0;
		}
		void next()
		{
			CurrPos++;
		}
		long Id()
		{
			return m_plist[CurrPos];
		}
		int	End () const
		{
			return m_plist[CurrPos] == 0x7ffffffc;
		}
	};
	LocalDocIterator::LocalDocIterator( long *pList ) : DocIterator(0)
	{
		CurrPos= 0;
		m_plist= pList;
	}
#endif

bool	b_english_face = false;
bool	b_show_extended_log = false;
bool	b_flush_extended_log = false;
bool	b_ovp = false;
char	nnn[]= "NWCntxt.str";

char*	delta_buffer = 0; //буфер, откуда для пакованных дельт будут читаться данные (вместо m_DFile1)
char*	delta_buffer_ptr = 0; //указатель

class StreamFileRW : public StreamFile
{
public:
	StreamFileRW(PagedFile *pFile, int bLoadFat) : StreamFile(pFile, bLoadFat)
	{
	}
	virtual void LoadFat       (PagedFile *otherLine= 0)
	{
		AllocSysBuf();
		if ( !file -> GetAttr ( "FatSize", &fatPages, sizeof ( short ) ) )
			fatPages = 1;
		m_deletedFat= (int gk_huge *)::malloc((8887 + fatPages)*(long)file->PageSize);
		Fat = m_deletedFat + (8887 * (file->PageSize / sizeof(*m_deletedFat)));
#ifdef DLT_IN_OLD_CONTEXT
		memset(m_deletedFat,0,(8887 + fatPages)*(long)file->PageSize);
#else
		memset(m_deletedFat,0,8887*(long)file->PageSize);
		if ( file -> GetPage ( 1, Fat ) )	// Fat already exists
		{
			char gk_huge *ptr = (char gk_huge *) Fat;
			for ( long page = Fat [1] & ~FAT_CHAIN, pageCount = 0; 
				page != 0; page = Fat [page] & ~FAT_CHAIN, pageCount++ )
			{
				assert(pageCount < fatPages);
				ptr += file -> PageSize;
				if(!file -> GetPage ( page, ptr )){
					file= 0;
					break;
				}
			}
		}
#endif
	}
};

class YOldSet : public CtxLongSet
{
public:
	YOldSet(){ }
	inline YOldSet(const int){ }
	~YOldSet(){}
};
class YOldForm
{
public:
	ACE_UINT64 val;
	YOldForm(){ }
	inline YOldForm(const int){ }
	inline YOldForm(void *pData)
	{
		val= *(ACE_UINT64*)pData;
	}
	~YOldForm(){
	}
};
template <class Key, class Data>
class OldContextSplayMap: public QuickSplayMap<Key, Data> {
  public:
	OldContextSplayMap(Data dflt, int reAllocF= 1, int reAllocS= 0)
		: QuickSplayMap<Key,Data>(dflt, reAllocF, reAllocS)
	{
	}
	int key_cmp (const Key& a, const Key& b) const {
		return strncmp ( (char*)&a, (char*)&b, sizeof(a) );
	}
	inline ~OldContextSplayMap(){
		this->root= 0; // GARANT_THIS
	}
};
typedef OldContextSplayMap<YOldForm, YOldSet> OldContextMap;
class OldContext;

#include "UpdtMorph.h"

class	N_WCU : public UpdtContextIndex
{
protected:
	u_int64_t AllSizeText;
	int preSize;
	u_int64_tCtxLongSetSplayNode *m_currentForm;
	int m_lenKey, m_fromKey;
public:
	N_WCU(PagedFile*f, const char*n, StreamFile*s,
									unsigned NormlsBuffCount= MAX_NODES_INCACHE, IndexInfo *pinfo= 0 )
					:UpdtContextIndex(f, n, s, NormlsBuffCount, pinfo )
	{
		pBuffNN = 0;
		AllSizeText= (u_int64_t)0;
		preSize= 0;
	}
	virtual void CopyAsFlushN(	void *vspit, void *vpdstr, void *vpsstr, void *vpin, long *prPos,
						int (__cdecl *compL)(const void *, const void *),
						int (__cdecl *compN)(const void *, const void *));
	virtual void CopyAsFlush(DocIterator *pUpDocs= 0);
	virtual void ReallocFormsPre(int otherDefNormlsBuffCount= 0)
	{
		unsigned tmpunsigned= m_NormlsBuffCount;
		m_NormlsBuffCount /= 2;
		InitFormsCache();
		InitOldContext();
		m_NormlsBuffCount= tmpunsigned;
		NormsCount= 0;
		BuffLemm= (char*)malloc(2*(32*128+32));
	}
	virtual void ReallocNormsPre()
	{
		if(!pBuffNN){
	#ifndef NOT_CLEAR_CASHE_FORMS
			m_NormlsBuffCount= pp_ctxTextCacheArray[0]->length()+1;
			pp_ctxTextCacheArray[0]->clear();
			delete []pAllPre;
			pNxtNew0= (pAllPre= new u_int64_tCtxLongSetSplayNode[m_NormlsBuffCount]);
	#endif
			pBuffNN= (char*)calloc(1, brb+MAX_VAL_STR_AS_KEY);
			pNextBuffNN= pBuffNN;
			brb= 0;
			NormsCount= 0;
		}
	}
	void InitOldContext()
	{
		pOldContext= 0;
	}
	long brb;
	char *pBuffNN, *pNextBuffNN, *BuffLemm;
	OldContext *pOldContext;
	virtual void SetCalcNormsFlag(u_int64_t *pReCalcSizeText= 0) {
		brb= 0;
		CreatePreFormsMap();
		(*pReCalcSizeText) *= 4;
		m_AllPatchedAndNewDocsTextSize= *pReCalcSizeText;
		brb= 1;
	}
	virtual void CreatePreFormsMap();
	virtual bool IsReparsingAllTexts(DocIterator* it, IGarDoc *doc= 0, u_int64_tCtxLongSetSplayMap	*pMap= 0) {
		if(brb){
			ReallocNormsPre();
			it->Rewind();
			//
#ifdef DLT_IN_OLD_CONTEXT
			*(long*)(key_buff+1)= m_ID;
			attach_stream(pdstr, get_stref_ex(	key_buff, pin->hdr.keylen, pin->hdr.strinfo.immds,
									pin->hdr.nstreams, 0));
			close_stream(pdstr);
			add_key(pin, key_buff);
#else
			*(long*)key_buff= m_ID;
			attach_stream(pdstr, get_stref_ex(	key_buff, outw.hdr.keylen, outw.hdr.strinfo.immds,
									outw.hdr.nstreams, 0));
			close_stream(pdstr);
			add_key(&outw, key_buff);
#endif
			//
			return true;
		}else{
			if(BuffLemm){
				free(BuffLemm);
				BuffLemm= 0;
			}
		}
		UpdtContextIndex::IsReparsingAllTexts(it, doc, pMap);
		(base->FindIndex("Attrs"))->streams->LoadFat();
		return false;

	}
	virtual IGarDoc *addInOtherMap(long Id, DocInfo *local_docInfo, IGarDoc *doc){
		if (!doc) {
			doc = base->GetGarDoc (Id, local_docInfo);
		} else {
			if(!brb && log) {
				log->printf (lt_info, "Reindex document %ld\n", Id);
				//log->flush (lt_info);
			}
			doc->SetDocInfo(local_docInfo, Id);
			doc->Load(Id);
		}
		AllSizeText += doc->GetDocTextSize();
		if(preSize != (int)((AllSizeText*100)/m_AllPatchedAndNewDocsTextSize)){
			preSize= (int)((AllSizeText*100)/m_AllPatchedAndNewDocsTextSize);
			OS_LocalSetProgress(int(preSize));
		}
		return doc;
	}
	virtual void exit(int _Code, char *name= 0)
	{
		if(name && log){
			if(_Code == 231){
				log->printf (lt_info, "Error Trunc Old key (%s)\n", name);
			}else if(_Code == -22){
				log->printf (lt_info, "Error Load Old key (%s)\n", name);
			}else if(_Code == -636){
				log->printf (lt_info, "Error Not Memory for file (%s)\n", name);
			}else
				log->printf (lt_info, "Error I/O file (%d)(%s)\n", _Code, name);
			log->flush (lt_info);
		}
		::exit(_Code);
	}
	void SetNextKeyBuff(long **ppSet)
	{
		if( m_lenKey < 32 ){
			if(*(m_currentForm->curr_item + m_lenKey)){
				(*ppSet)= (long*)(m_currentForm->curr_item + m_lenKey);
				m_lenKey += 1+ *(char*)(*ppSet);
				if(m_lenKey >= 32)
					m_fromKey++;
			}else{
				m_lenKey= 32;
				(*ppSet)= m_currentForm->cont.e;
			}
		}else if(m_currentForm->cont.lastI){
			if(!pNxtNPut){
				if(m_fromKey){
					m_fromKey= 0;
					(*ppSet)= m_currentForm->cont.e;
				}else
					(*ppSet)= (long *)((char*)(*ppSet) + 1 + *(char*)(*ppSet));
			}else
				(*ppSet) += 8;
		}
	}
	virtual void in_pipeID(long *pData, DocIterator* it= 0, DocInfo *pLocal_docInfo= 0)
	{
		if(*pData){
			++(*it);
			if(it->End()){
				*pData= 0;
				return;
			}
		}
		*pData= it->Id ();
		//base->FindDocAttr(*pData,IDD_INFO,(char *)pLocal_docInfo, sizeof(*pLocal_docInfo));
	}
	virtual CtxLongSet *FromCache(void *buff, LPPL_RET_NORMLS spRet)
	{
		{
	#ifdef NOT_CLEAR_CASHE_FORMS
			if(!brb){
				Pix fnd= pp_ctxTextCacheArray[cacheI]->seek(buff);
				if(fnd){
					spSrc= &pp_ctxTextCacheArray[cacheI]->contents(fnd);
					if(!spSrc->lastElemV)
						spRet->lastI= 0;
					else{
						spRet->lastI= spSrc->lastElemV;
						spRet->e= 0;
						spSrc->e= 0;
					}
				}else{
					spRet->e= 0;
				}
				return spSrc;
			}
	#endif
			return NContxtIndex::FromCache(buff, spRet);
		}
	}
	virtual void GetKeyBuff(long **ppSet, u_int64_tCtxLongSetSplayNode *curr){
		m_currentForm= curr;
		m_lenKey= 32; m_fromKey= 0;

		(*ppSet)= m_currentForm->cont.e;
		if(!pNxtNPut){
			m_lenKey= 0x7f & *m_currentForm->curr_item;
			if( m_lenKey < 31 && m_currentForm->curr_item[++m_lenKey] ){
				if(!(0x7f &m_currentForm->curr_item[m_lenKey])){
	(*ppSet)= (long*)(m_currentForm->curr_item);
				}else{
	(*ppSet)= (long*)(m_currentForm->curr_item + m_lenKey);
					if(0x80 & *(char*)(*ppSet)){
						if((0x7f & *(char*)(*ppSet)))
							m_lenKey += 1 + (0x7f & *(char*)(*ppSet));
					}else{
						m_lenKey += 1 + *(char*)(*ppSet);
						if(m_lenKey >= 32)
							m_fromKey++;
					}
				}
			}else
				m_lenKey= 32;
		}
	}
protected:
	virtual void AllocBufForNormals() { pNxtNPut = 0; }
	virtual void init_buff_Norm() {
		if (!pNxtNPut) {
			buff_Norm = BuffLemm;
			pNxtNPut = (u_int64_t *)buff_Norm;
			buff_Norm += 32 * 128 + 32;
		} else
			buff_Norm = (char*)pNxtNPut + 32 * 128 + 32;
	}
	virtual void WordPosControl(long ID, int ParaN, int *pVal, int textpos_add = 0);
	int freeF, maxAll;
	virtual bool IsNotForms(int *psecondWord, CtxLongSet *sp, char *buf, LPPL_RET_NORMLS spRet) {
		if(sp->capacity == -1 || (spRet->lastI && brb && !(*psecondWord= 0)))
			return 1;
		freeF= pNxtNPut ? 0 : 1;
		maxAll= *(buf-1)+1;
		return 0;
	}
	virtual int SetRetNormsCount(CtxLongSet *sp, LPPL_RET_NORMLS spRet){
		//if(freeF){
			freeF= maxAll;
			int uu= 0, ln;
			for(sp->lastI= 0; sp->lastI < spRet->lastI; sp->lastI++){
				pForm= (char*)sp->e + sp->lastI * 32;
				ln= 0x3f & *pForm;
				maxAll += 1 + ln;
				if(maxAll <= 32){
#ifndef NOT_CLEAR_CASHE_FORMS
					if(!brb)
#endif
					{
						memcpy(	pp_ctxTextCacheArray[cacheI]->root->curr_item+freeF, pForm, 1 + ln);
						freeF += 1 + ln;
						if(freeF < 32)
							*(pp_ctxTextCacheArray[cacheI]->root->curr_item+freeF)= 0;
					}else
						freeF += 1 + ln;
				}else{
					if(brb){
						brb += 1 + ln;
					}else
						break;
				}
			}
			pNxtNPut= 0;
			if(brb){
#ifdef NOT_CLEAR_CASHE_FORMS
				sp->lastElemV= spRet->lastI;
#endif
				spRet->lastI= 0;
				return 0;
			}
			uu= 0;
			while(sp->lastI < spRet->lastI){
				if(!uu){
					spRet->e= (u_int64_t *)pNextBuffNN;
				}else{
					pForm= (char*)sp->e + sp->lastI * 32;
					ln= 0x3f & *pForm;
				} 
				memcpy(pNextBuffNN, pForm, ++ln);
				uu += ln;
				pNextBuffNN += ln;
				sp->lastI++;
			}
			if(uu){
				sp->e= (long*)spRet->e;
			}
		//}else
		//	sp->lastI= spRet->lastI;
		return 1;
	}
	virtual bool IsAlloc_ctxTextCacheArray(){
		return (pp_ctxTextCacheArray == 0);
	}
	virtual bool IsAlloc_pAllPre(){
		return (pAllPre == 0);
	}
	void RestoreNamesFiles(char *gs_target_name, void *strR, PagedFile *file__, StreamFile * streams__);
protected:
	base_st thisBase, *ptarget;
	void *p_UpdThdr;
	char *gs_target_name;
	index_st *pin;
	iter_st *spit;
	stream_st *pdstr;

	char *FormsIName, *pParaStartIndexName;

	index_st *prin;
	stream_st *psstr;
	//
	char key_buff[256];
	Index *Forms;
	//
	index_st inw
#ifndef DLT_IN_OLD_CONTEXT
			, outw
#endif
				;
	iter_st itw;
	//
	int newSZ;
	long *p_DelDocs
#ifdef DLT_IN_OLD_CONTEXT
			, *pikey
#endif
					;
};

void N_WCU::CreatePreFormsMap()
{
	ReallocFormsPre();
}

UpdatedBase :: UpdatedBase(const char * name, int mode, int key_cpages, int str_cpages, int ndt_cache, FILE *stat_file) : UpdatedSearchBase(name)
{
	Index *pAx= FindIndex("Aux.str");
	int PreLastPage= 0;
	if(pAx->file->GetAttr(ID_FATS_IN_AUX, &PreLastPage, sizeof(PreLastPage))){
		pAx->file->DelAttr(ID_FATS_IN_AUX);
		pAx->file->LastPage=PreLastPage;
	}
	if(new_docBuf)
		free(new_docBuf);
	new_docBuf= 0;
	new_docBuf = (char *) calloc ( 1, 2*ADD_BLOCK_SIZE + 1024 + ADD_BLOCK_SIZE );
	pDocsBlockBufferOut= pDocsBlockBuffer= new_docBuf + 2*ADD_BLOCK_SIZE + 1024;
	countDocsBlockBuffer= 0;
	new_runs	= (PageRun *)calloc(sizeof(PageRun),MAX_RUNS);
	new_blocks	= (BlockRec *)calloc(sizeof(BlockRec),MAX_BLOCKS);

	max_runs = MAX_RUNS;
	max_blocks = MAX_BLOCKS;

	Stream *str = Base::FindIndex ("Aux")->Open (AUX_DOC_BASE);
	if (str) {
		long length = str->Length ();
		char *data = new char [length], *ptr = data;
		str->Read (data, length);
		Base::FindIndex ("Aux")->Close (str);
		while (ptr - data < length) {
			long id;
			memcpy (&id, ptr, sizeof (id));
			ptr += sizeof (id);
			char basechar = *ptr;
			ptr++;
			map_doc_basechar.insert (std::map<long,char>::value_type (id, basechar));
		}
		delete []data;
	}
	str = Base::FindIndex ("Aux")->Open (AUX_BLOB_BASE);
	if (str) {
		long length = str->Length ();
		char *data = new char [length], *ptr = data;
		str->Read (data, length);
		Base::FindIndex ("Aux")->Close (str);
		while (ptr - data < length) {
			long id;
			memcpy (&id, ptr, sizeof (id));
			ptr += sizeof (id);
			char basechar = *ptr;
			ptr++;
			map_blob_basechar.insert (std::map<long,char>::value_type (id, basechar));
		}
		delete []data;
	}
	str = Base::FindIndex ("Aux")->Open (AUX_BASES_LIST);
	std::vector<std::string> bases_list;
	bases_list.push_back ("this");
	if (str) {
		long length = str->Length ();
		char *bases = new char [length], *ptr = bases;
		str->Read (bases, length);
		Base::FindIndex ("Aux")->Close (str);
		for (; ptr - bases < length; ptr += strlen (ptr) + 1)
			bases_list.push_back (ptr);
		delete []bases;
	}
	for (std::vector<std::string>::const_iterator basename_it = bases_list.begin (); basename_it != bases_list.end (); basename_it++) {
		if (basename_it == bases_list.begin ()) {
			bases_ptrs.push_back (this);
		} else {
			UpdatedBase *base = new UpdatedBase (basename_it->c_str ());
			bases_ptrs.push_back (base);
		}
	}
}

Index* UpdatedBase::FindIndex (const char *name){
	if(!strcmp(nnn,name)){
		Index *pCreated= FindIndexOther(name);
		int indCountCurr= indCount;
		while(indCountCurr--){
			if(indTable[indCountCurr] == pCreated){
				break;
			}
		}
		Index *pret= 0;
		if(indCountCurr > 0){
			if(indCountCurr == indCount-1){
				return pCreated;
			}
			delete indTable[indCountCurr+1];
			delete indTable[indCountCurr];
			indTable[indCountCurr]= indTable[indCountCurr+2];
			indCount-=2;
			delete (pOtherNextIndex-2)->pStreamFile;
			delete (pOtherNextIndex-2)->pKey;
			int tmp_curr_mode= curr_mode;
			(pOtherNextIndex-2)->pStreamFile= (pOtherNextIndex-1)->pStreamFile;
			(pOtherNextIndex-2)->pKey= (pOtherNextIndex-1)->pKey;
			(pOtherNextIndex-1)->pStreamFile= 0;
			(pOtherNextIndex-1)->pKey= 0;
			pOtherNextIndex--;
			curr_mode= 0;
			pret= YBase::FindIndex(nnn);
			pret->pResultFileKeyName= pret->file->FileName;
			pret->streams->StartTransaction();
			curr_mode= tmp_curr_mode;
		}else
			return 0;

		return pret;
	}
	return FindIndexOther(name);
}

StreamFile* UpdatedBase::make_StreamsPool(PagedFile *pFile, int bLoadFat){
	StreamFile *ret= new StreamFileRW(pFile, 0);
	ret->LoadFat();
	return ret;
}

bool UpdatedBase::IsMultiThreadsR(){
	return true;
}

IGarDoc* UpdatedBase::GetGarDoc( long id, long aOwnerDoc, DocInfo *local_docInfo)
{
	if(local_docInfo){
		return new Document(this,id,local_docInfo);
	}else
		return 0;
}

UpdatedBase* UpdatedBase::find_base_for_doc (long id) {		
	std::map<long,char>::const_iterator map_it = map_doc_basechar.find (id);
	char basechar = (map_it == map_doc_basechar.end ()) ? bases_ptrs.size () - 1 : map_it->second;
	return bases_ptrs [basechar];
}

UpdatedBase* UpdatedBase::find_base_for_blob (long id) {		
	std::map<long,char>::const_iterator map_it = map_blob_basechar.find (id);
	char basechar = (map_it == map_blob_basechar.end ()) ? bases_ptrs.size () - 1 : map_it->second;
	return bases_ptrs [basechar];
}

Index* UpdatedBase::makeMorphoIndex( ::PagedFile * tf, const char * name, StreamFile * s)
{
	return new N_WCU( tf, name, s );
}

void UnFull::lastDocFlush()
{
	m_lDocId= 0;

	if(pNewDocN){
		delete pNewDocN;
		pNewDocN = 0;
	}
#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
	if(pTmpDoc) {
		pTmpDoc->runs= 0;
		pTmpDoc->blocks= 0;

		pTmpDoc->FreeStructs();
		delete pTmpDoc;
		pTmpDoc= 0;
	}
#endif
}

NewDoc_GU *UnFull::make_GU_Doc(const char *ttl, int pckng, std::set<long> *m_pUpdDocs)
{
	return new NewDoc_GU (m_pNewBase, m_lDocId, ttl, m_aDocRevision, pckng);
}

void FillForms (NContxtIndex *pContextIndex, FContxtIndex* f_index, LemmatizeProc lemmatize)
{
	pContextIndex->InitMorpho ();
	PL_RET_NORMLS retrn;
	char	   bufT[256], *buf= bufT+1, *pForm1;
	unsigned wordLen;
	for ( BTIterator it (f_index); !it.End(); ++it ){
		pForm1= (char*)it.Key();
		wordLen= (unsigned)strlen(pForm1);
		memcpy(buf, pForm1, wordLen);
		buf[wordLen]= 0;
		retrn.lastI= 0;
		pContextIndex->GetNormalesFromString (buf, &retrn, lemmatize, wordLen);
		pContextIndex->pp_ctxTextCacheArray[pContextIndex->cacheI]->root->cont.capacity= -2;
	}
}
 
extern int gctx_nmain (YBase *, NContxtIndex *, DocIterator *, std::deque<long>, std::map< long,std::set<std::string> >&);

#ifndef _EXTERN_MAIN

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (1);
}

int main ( int argc, char *argv[] ) {
	gk_bzero (&CCr, sizeof (CCr));
	SetUnhandledExceptionFilter (UEF);
	setlocale (LC_ALL, "ru_RU.CP1251");
	Core::AutoInit init;

#ifdef	__FreeBSD__
	int res = main_logic(argc, argv);
	exit (res);
#else
	int res = 
				mpcxc_run_main_stack_size (main_logic, argc, argv, (32*1024*1024))
				//main_logic(argc, argv)// однопоточное приложение для пюрифая/квантифая, где размер стека линкеру в вену
		;
	return res;
#endif
}

int main_logic ( int argc, char *argv[] )
{
	{
		VER_PARAM verParam;
		int	i;

		verParam.exeId= TID_GU;					// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i == VC_ADD_OK){
			}else{
			}
	#ifdef _DEBUG
			printf("\n *** GU Debug Version. For test, only... ***\n\n");
	#else
			exit(0);
	#endif
		}
	}

	logger.Init ( &tracer, cd_win, out );
	screen = new GSScreen( cd_win, out );
  #ifdef MULTI_INDEX_STREAM_FILE
	pLocalCurrProgressScreen= screen;
  #endif

#else

int main_update ( int argc, char** argv, ProgressScreen* ascreen )
{
	Core::AutoInit init;

  #ifdef MULTI_INDEX_STREAM_FILE
	pLocalCurrProgressScreen= ascreen;
  #endif
	screen = ascreen;
#endif

	//
	// Progress screen
	//

	SetProgressScreen( screen );
	Timer	*timer = new Timer ( &logger, lt_info, "Base update time" );

	logger.OverlapPolicy ( new ErrorPolicy () );
	logger.GetPolicy()->SetLogLevel ( lt_info );
	logger.printf( lt_always, "Garant Base update program. Update version %d. Version %s.\n", GU_VERSION, GARANT_VERSION);

	struct	tm	*pNewTime;
	time_t		long_time;
	time( &long_time );
	pNewTime = localtime( &long_time );

	Core::IniFile	*pIniFile = 0;
	long		lDeltaCount = 0;
	long		lAvailMem = 0;
	char		**pDeltaNames = 0;
	char		*pBaseName = 0;
	char		*pResName = 0;
	char		*pLogName = 0;
	char		*pIniName = 0;
	char		*pSkipDir = 0;
	int		i;

	//
	// Parse arguments
	//
	for (int i = 1; i < argc; i++ ) {
		if (strstr (argv[i], "-version:") == argv [i]) {
			DELTA_DATA_VERSION = (short) atol (&argv [i][9]);
			break;
		}
	}

	for ( i = 1; i < argc; i++ ) {
		if ( argv[i][0] == '-' )
			switch ( argv[i][1] ) {
				case 'r':
					if ( argv[i][2] != ':' ) {
						logger.printf ( lt_fatal, "\nUnknown parametr (%s)\n", argv[i] );
						UPDATEEXIT;
					}
					if ( pResName ) {
						logger.printf ( lt_fatal, "\nDouble '-r' options\n" );
						UPDATEEXIT;
					}
					pResName = strdup (argv[i]+3);
					break;

				case 'd':
				case 'D':
					b_show_extended_log = true;
					b_flush_extended_log = (argv[i][2] == '+');
					break;

				case 'o':
					if (!stricmp (argv [i]+1, "ovp"))
						b_ovp = true;
					break;

				case 'l':
					if ( argv[i][2] != ':' ) {
						logger.printf ( lt_fatal, "\nUnknown parametr (%s)\n", argv[i] );
						UPDATEEXIT;
					}
					if ( pLogName ) {
						logger.printf ( lt_fatal, "\nDouble '-l' options\n" );
						UPDATEEXIT;
					}
					pLogName = strdup (argv[i]+3);
					break;

				case 'm':
					if ( argv[i][2] != ':' ) {
						logger.printf ( lt_fatal, "\nUnknown parametr (%s)\n", argv[i] );
						UPDATEEXIT;
					}
					if ( lAvailMem ) {
						logger.printf ( lt_fatal, "\nDouble '-m' options\n" );
						UPDATEEXIT;
					}
					lAvailMem = atol ( &argv[i][3] );
					if ( lAvailMem <= 8 ) {
						logger.printf ( lt_fatal, "\nAvailable memory must be > 8Mb (%s)\n", argv[i] );
						UPDATEEXIT;
					}
					break;

				case 'i':
					if ( argv[i][2] != ':' ) {
						logger.printf ( lt_fatal, "\nUnknown parametr (%s)\n", argv[i] );
						UPDATEEXIT;
					}
					if ( pIniName ) {
						logger.printf ( lt_fatal, "\nDouble '-i' options\n" );
						UPDATEEXIT;
					}
					pIniName = argv[i] + 3;
					break;

				case 'P' :
					if ( argv [i][2] != ':' ) {
						logger.printf ( lt_fatal, "\nBad priority option(%s)\n", argv[i] );
						UPDATEEXIT;
					}
					if ( !strcmp (&argv[i][3], "DEBUG" ))
						logger.GetPolicy()->SetLogLevel ( lt_debug );					
					else if ( !strcmp (&argv[i][3], "INFO" )) 
						logger.GetPolicy()->SetLogLevel ( lt_info );
					else if ( !strcmp (&argv[i][3], "ERROR" )) 
						logger.GetPolicy()->SetLogLevel ( lt_error );
					else if ( !strcmp (&argv[i][3], "WARNING" )) 
						logger.GetPolicy()->SetLogLevel ( lt_warning );
					else if ( !strcmp (&argv[i][3], "FULL" )) 
						logger.GetPolicy()->SetLogLevel ( 100000 );
					else {
						logger.printf ( lt_fatal, "\nUnknown priority (%s)\n", &argv[i][3] );
						UPDATEEXIT;
					}
					break;

				case 'e':
				case 'E':
					b_english_face = true;
					break;

				case 't':
				case 'T':
					if (!stricmp (argv [i]+1, "turbo"))
						b_skipturbo = true;
					break;

				case 'u':
				case 'U':
					if (!stricmp (argv [i]+1, "updateturbo"))
						b_updateonlyturbo = true;
					if (!stricmp (argv [i]+1, "updateturbo+"))
						b_updateonlyturbo = b_updateonlyturboplus = true;
					break;

				case 'v':
					break;

				default :
					logger.printf ( lt_fatal, "\nUnknown options (%s)\n", argv [i] );
					UPDATEEXIT;
					break;
			} // end switch
	} // end for

	std::vector <std::string> gu_info;

	char gu_str [512];
	long start_time = (long)(time (0)&0xffffffff);
	sprintf (gu_str, "Отработал gu от %s : %s", __DATE__, __TIME__);
	gu_info.push_back (gu_str);
	if ( pIniName ) {
		gu_info.push_back (pIniName);
		pIniFile = new Core::IniFile ( pIniName );
		assert ( pIniFile );

		short unsigned iSize = 0;

		long language = 0;
		pIniFile->ReadProfileLong( "base", "Language", &language);
		if (language)
			b_english_face = 1;

		//
		// read Base name
		//
		if ( pIniFile->ReadProfileString( "base", "Base", 0, &iSize ) != ERR_OUT_OF_DESTBUF ) {
			logger.printf ( lt_fatal, "\nINI file (%s), has no section [base].Base\n", pIniName );
			UPDATEEXIT;
		}
		
		pBaseName = (char*) malloc ( iSize + 1 );
		assert ( pBaseName );
		pIniFile->ReadProfileString( "base", "Base", pBaseName, iSize );
		gu_info.push_back (pBaseName);

		//
		// read delta's names
		//
		if ( pIniFile->ReadProfileLong ( "delta", "Count", &lDeltaCount) != DEF_SUCCESS ) {
			logger.printf ( lt_fatal, "\nINI file (%s), has no section [delta].Count\n", pIniName );
			UPDATEEXIT;
		}

		long update_turbo = 1;
		if (pIniFile->ReadProfileLong ("delta", "UpdateTurbo", &update_turbo) == DEF_SUCCESS) {
			if (update_turbo == 0) {
				gu_info.push_back ("UpdateTurbo=0");
				b_skipturbo = true;
			}
		}

		long update_only_turbo = 0;
		if (pIniFile->ReadProfileLong ("delta", "UpdateOnlyTurbo", &update_only_turbo) == DEF_SUCCESS) {
			if (update_only_turbo == 1) {
				gu_info.push_back ("UpdateOnlyTurbo=1");
				b_updateonlyturbo = true;
				lDeltaCount = 0;
			}
		}

		long ini_extended_log = 0;
		pIniFile->ReadProfileLong ("delta", "ExtendedLog", &ini_extended_log);
		if (ini_extended_log == 1) {
			b_show_extended_log = true;
			b_flush_extended_log = true;
		}

		pDeltaNames = (char**) malloc ( sizeof(char*) * lDeltaCount );
		assert ( pDeltaNames );

		char * pSectionName = (char*) malloc ( 32 );
		memset ( pSectionName, 32, 0 );

		for ( long l=0; l<lDeltaCount; l++ ) {
			sprintf ( pSectionName, "Delta%ld", l );

			if ( pIniFile->ReadProfileString( "delta", pSectionName, 0, &iSize ) != ERR_OUT_OF_DESTBUF ) {
				logger.printf ( lt_fatal, "\nINI file (%s), has no section [delta].%s\n", pIniName, pSectionName );
				UPDATEEXIT;
			}

			pDeltaNames [l] = (char*) malloc ( iSize + 1 );
			assert ( pDeltaNames [l] );
			pIniFile->ReadProfileString( "delta", pSectionName, pDeltaNames[l], iSize );
			gu_info.push_back (pDeltaNames [l]);
		}

		free ( pSectionName );

		//
		// read res-file name
		//
		if ( pIniFile->ReadProfileString( "out files", "Result", 0, &iSize ) != ERR_OUT_OF_DESTBUF ) {
			logger.printf ( lt_fatal, "\nINI file (%s), has no section [out files].Result\n", pIniName );
			UPDATEEXIT;
		}

		pResName = (char*) malloc ( iSize + 1 );
		assert ( pResName );
		pIniFile->ReadProfileString( "out files", "Result", pResName, iSize );

		//
		// read logger path
		//
		if ( pIniFile->ReadProfileString( "out files", "Log", 0, &iSize ) != ERR_OUT_OF_DESTBUF ) {
			logger.printf ( lt_fatal, "\nINI file (%s), has no section [out files].Log\n", pIniName );
			UPDATEEXIT;
		}

		char	*pLogPath = (char*) malloc ( iSize + 1 );

		assert ( pLogPath );
		pIniFile->ReadProfileString( "out files", "Log", pLogPath, iSize );
		
		char	*pBName = strrchr ( pBaseName, MPCXC_PATHBRK );

		if ( !pBName )
			pBName = pBaseName;
		else
			pBName++;

		pLogName = (char*) malloc ( strlen (pLogPath) + strlen (pBName) + 16 );
		assert ( pLogName );

		if ( pLogPath [strlen ( pLogPath )-1] == MPCXC_PATHBRK ) 
			sprintf ( pLogName, "%s%s.log", pLogPath, pBName );
		else 	
			sprintf ( pLogName, "%s%c%s.log", pLogPath, MPCXC_PATHBRK, pBName );

		free ( pLogPath );

		//
		// read available mem
		//
		if ( pIniFile->ReadProfileInt( "Options", "AvailMem", (int *)&lAvailMem ) != DEF_SUCCESS )
			lAvailMem = 0;

		delete pIniFile;
	} else {
		if ( argc < 3 ) {
			logger.printf ( lt_always, "  USAGE : gu.exe <b-path> <d-path> [-options]\n\n" );
			logger.printf ( lt_always, "         'b-path' is update base's path and name (w/o exstension)\n" );
			logger.printf ( lt_always, "         'd-path' is delta's path and name with extension\n" );
			logger.printf ( lt_always, "     OR : gu.exe -i:<file> [-options]\n\n" );
			logger.printf ( lt_always, "         'file'   is INI-file path and name\n" );
			logger.printf ( lt_always, "options :\n" );
			logger.printf ( lt_always, "       r:<path>' is result file's path and name\n" );
			logger.printf ( lt_always, "                 (optional, default : \"<base name>.res\")\n" );
			logger.printf ( lt_always, "       l:<path>' is log file's path and name\n" );
			logger.printf ( lt_always, "                 (optional, default : \"<base name>.log\")\n" );
			logger.printf ( lt_always, "       m:<mem>'  is size of available physical memory\n" );
			logger.printf ( lt_always, "       P:<prior> log output priority, default INFO\n");
			logger.printf ( lt_always, "                 DEBUG   - full log information\n");
			logger.printf ( lt_always, "                 INFO    - standart log information\n");
			logger.printf ( lt_always, "                 WARNING - warning and error information\n");
			logger.printf ( lt_always, "                 ERROR   - only error information\n");

			return 3;
		}

		gu_str [0] = 0;
		for (int i = 0; i < argc; i++) {
			if (i) strcat (gu_str, " ");
			strcat (gu_str, argv [i]);
		}
		gu_info.push_back (gu_str);
		pBaseName = strdup ( argv [1] );

		if (!b_updateonlyturbo) {
			lDeltaCount = 1;
			pDeltaNames = ( char** ) malloc ( sizeof ( char* ) * lDeltaCount );
			pDeltaNames [0] = strdup ( argv [2] );
		}

		if ( !pResName ) {
			pResName = (char*) malloc ( strlen (pBaseName) + 5 );
			sprintf ( pResName, "%s.res", pBaseName );
		}
		if ( !pLogName ) {
			pLogName = (char*) malloc ( strlen (pBaseName) + 5 );
			sprintf ( pLogName, "%s.log", pBaseName );
		}
	}

	//
	// CREATE OR OPEN ALL EXTERN FILES
	//
	FILE	*presfile = mpcxc_fopen ( pResName, "atc" );

	if ( !presfile ) {
		logger.printf ( lt_fatal, "Не могу открыть файл результата (%s)\n", pResName );
		UPDATEEXIT;
	}
	
	LogFile resfile ( presfile );
	resfile.SelfCode ( cd_dos );
	logger.Devices(lt_fatal) = logger.Devices ();
	logger.Devices(lt_fatal).Add ( &resfile );
	LogFile * logfile;

	try {
		logfile = new LogFile ( pLogName );
		logger.GetPolicy()->AddLogDevice ( logfile );
	} catch (...) {
		logger.printf ( lt_error, "Ошибка открытия файла (%s)\n", pLogName );
		logfile = 0;
	}

	#if !defined(_NO_DOS_SCREEN) && !defined(_EXTERN_MAIN)
		logger.GetPolicy()->DelLogDevice ( &tracer );  // no std output
		logger.Devices(lt_fatal).Add ( &tracer );      // only for fatal error
	#endif 

	screen->InitScreen( b_english_face ? "Master of package update" : "Пакетное пополнение комплекта системы ГАРАНТ" );

	//
	// TEST MEMORY MANAGER
	//
	#ifdef N_MALLOC
		if ( !(g_pReserved = malloc ( G_RESERVED_SIZE )) ) {
			logger.printf ( lt_fatal, "Не хватает оперативной  памяти. Перегрузитесь пожалуйста." );
			UPDATEEXIT;
		}
		Z_set_malloc_handler (pmhUnDiffMallocHandler);
	#endif

	//
	// Testing memory
	//
	#ifdef TEST_MALLOC
		void	*pTest = 0;
		MemTestCreate ( TM_CYCLE_COUNT );

		for ( i=0; i < TM_CYCLE_COUNT; i++ )
		{
			AddMem ( 1 );
			if ( !(pTest = calloc ( TM_MALL_SIZE, i )) )
			{
				for ( int k=0; k < TM_SLIP_COUNT && !pTest; k++ )
				{
					for ( int j=0; j < 100; j++ )
					{
						usleep ( 10000 );
						if ( (pTest = calloc ( TM_MALL_SIZE, i )) )
							break;
					}
				}

				if ( !pTest )
				{
					logger.printf ( lt_fatal, "Нарушение DPMI. Перегрузитесь пожалуйста." );				
					UPDATEEXIT;
				}
			}
			if ( pTest )
				free ( pTest );
		}
	#endif

	//
	// OPEN BASE
	//
	screen->SetMessage( b_english_face ? "Opening database" : "Открытие установленного комплекта" );

	//
	// Calc caches size by AvailMem
	//
	#ifdef __GO32__
		long	lKeyCache = 400;  // in pages
		long	lStrCache = 400;
		long	lNdtCache = 200;
	#else
		long	lKeyCache = 4000;
		long	lStrCache = 4000;
		long	lNdtCache = 2000;
	#endif

	long	ks = 2 * 1024; // in byte
	long	ss = 4 * 1024;
	long	ns = 512;

	if ( lAvailMem > 8 ) {
		lAvailMem -= 8;
		lAvailMem = lAvailMem * 1024 * 1024; // in byte

		lStrCache = lKeyCache = lAvailMem / ( ks+ss+ns/2 );
		lNdtCache = lKeyCache / 2;
	}

	UpdatedBase *pNewBase = new UpdatedBase ( pBaseName );

	#ifdef __GO32__
		((NCPagedFile*)(pNewBase->textFile))->setThresh(1);
	#endif

	if (!b_updateonlyturbo)
		if (!pNewBase || !pNewBase->IsOk () || (!b_skipturbo && !pNewBase->check_version())) {
			logger.printf ( lt_fatal, "Не могу открыть базу (%s)", pBaseName );
			UPDATEEXIT;
		}

	if (!check_ready_status (TID_GU,pNewBase, &logger)) {
		logger.printf ( lt_fatal, b_english_face ? "\nBase is not ready for update" : "\nБаза не готова для обновления\n" );
		g_pBase = 0;
		delete pNewBase;
		UPDATEEXIT;
	}

	UpdatedBase *pOldBase = pNewBase;

	g_pBase = pNewBase;

	BaseInfo aExistBaseInfo;

	if ( pNewBase->FindBaseInfo ( 0, aExistBaseInfo ) != sizeof ( BaseInfo ) ) {
		g_pBase = 0;
		delete pNewBase;
		logger.printf ( lt_fatal, "Ошибка базы. Отсутствует нулевой сегмент.\n" );
		UPDATEEXIT;
	}

	//
	// WRITE LOG HEADER
	//
	char	buf[128];

	logger.printf ( lt_info, "************************** BASE UPDATE LOG FILE ***********************\n" );
    logger.printf ( lt_info, "\n\t Time \t\t\t: %s\n", asctime( pNewTime ) );
	logger.printf ( lt_info, "\t GU Version \t\t: \"%d\"\n", GU_VERSION );
	logger.printf ( lt_info, "\t DDC Version \t\t: \"%d\"\n", DELTA_DATA_VERSION );
	logger.printf ( lt_info, "\t Exist Base \t\t: \"%s\"\n\t 0 revision \t: %s\n", pBaseName, sprintRev ( buf, &aExistBaseInfo.LastUpdate ) );
	logger.printf ( lt_info, "\t Update type\t\t: ");

	long	l;
	if (lDeltaCount) {
		if ( lDeltaCount == 1 )
			logger.printf ( lt_info, " Single\n");
		else
			logger.printf ( lt_info, " Multi (%ld)\n", lDeltaCount );
		
		for ( l = 0; l< lDeltaCount; l++ )
			logger.printf ( lt_info, "\t Delta %ld \t\t: \"%s\"\n", l, pDeltaNames[l] );
	}

	logger.printf ( lt_info, "\t Res File\t\t: \"%s\"\n", pResName );
	logger.printf ( lt_info, "\t Log File\t\t: \"%s\"\n", pLogName );
	logger.printf ( lt_info, "\n\t Run with args (%d) :\n", argc );

	for ( i = 0; i < argc; i++ )
		logger.printf ( lt_info, " \"%s\"", argv [i] );
	
	logger.printf ( lt_info, "\n\t Base cache (in page): key=%lu, str=%lu, ndt=%lu\n", lKeyCache, lStrCache, lNdtCache );
	logger.printf ( lt_info, "\n\t Base cache (in byte): key=%lu, str=%lu, ndt=%lu\n", lKeyCache*ks, lStrCache*ss, lNdtCache*ns );
	logger.printf ( lt_info, "\n\t Process start size %lu\n\n\n", getUsedPhsMem () );

	//pTimer->SetOutFile ( logFile );

	if ( pResName )
		free ( pResName );

	//
	// RESTORING CYCLE FOR ALL DELTA
	//
	delta_buffer = 0;
	UnFull	*FullUnDiff = new UnFull (pOldBase, pNewBase, 0, pSkipDir, b_english_face, lDeltaCount);
	pOldBase->fill_set (pOldBase, FullUnDiff->docs_include_header_in_text);
	pOldBase->fill_kindsset (pOldBase, FullUnDiff->kinds);
	
	HIndex* kinds_index = (HIndex*) pOldBase->FindIndex ("Kind");
	for (long i = 0; i < 2; i++) {
		for (std::set<std::string>::const_iterator it = FullUnDiff->kinds.find (i)->second.begin (); it != FullUnDiff->kinds.find (i)->second.end (); it++) {
			FullUnDiff->old_kinds_set.insert (*it);
		}
	}
	g_pUnFull = FullUnDiff;

	int	iRetVal = ERR_NONE;
	long docs_in_delta = 0;
	FILE	*fpDFile1 = 0;
	std::vector<FILE*> fpDFiles;
	std::vector<long> pos_of_correspondents;
	for (l = 0; l < lDeltaCount; l++) {
		//
		// READ DELTA STATISTIC INFORMATION AND FILLS LOG'S AND ERR'S HEADER
		//
		fpDFile1 = mpcxc_fopen ( pDeltaNames[l], "rb" );

		if ( !fpDFile1 ) {
			logger.printf ( lt_fatal, b_english_face ? "Error opening file %s\n" : "Ошибка открытия файла (%s)\n", pDeltaNames[l] );
			delete pNewBase;
			UPDATEEXIT;
		}

		DHReader * pHeader = new DHReader ( fpDFile1, 1 );

		switch ( pHeader -> IsOK () )
		{
			case DHRS_BADVER :
				if (pHeader->Version () != DELTA_DATA_VERSION) {
					g_pBase = 0;
					logger.printf ( lt_fatal, b_english_face ? "%d:Version of program and delta mismatch" : "%d:Версии программы и данных не совпадают.\n", ERR_BADVERSION );
#ifdef	__FreeBSD__
					exit (-ERR_BADVERSION);
#endif
					delete pNewBase;
					UPDATEEXIT;
				}
				break;

			case DHRS_BADSIZE :
				g_pBase = 0;
				delete pNewBase;
				logger.printf ( lt_fatal, b_english_face ? "%d:Incorrent delta size\n" : "%d:Неверный размер дельты.\nВозможно файл не до конца скачался.\n", ERR_BADSIZE );
				UPDATEEXIT;
				break;

			case DHRS_OK :
				break;

			default :
				g_pBase = 0;
				delete pNewBase;
				logger.printf ( lt_fatal, "%d:Неизвестная часть дельты.\nВозможно у Вас старая версия программы.\n", ERR_UNKNOWNPART );
				UPDATEEXIT;
			break;
		}

		short	siDeltaSegmentsCount;
		short	*pDeltaSegments = pHeader->LoadSegs ( siDeltaSegmentsCount );

		revision aNeededBaseRevision = pHeader->GetOldRev ();
		revision aBaseRevision = pHeader->GetNewRev ();


		//
		// Fills delta's section logger and err
		//
		logger.printf ( lt_info, "-------------------------- Base Update LOG File (%ld) ----------------------\n", l );
		logger.printf ( lt_info, "\t DeltaName \t\t: \"%s\"\n", pDeltaNames[l] );
		logger.printf ( lt_info, "\t Update from \t\t: %s\n", sprintRev ( buf, &aNeededBaseRevision ) );
		logger.printf ( lt_info, "\t Update to \t\t: %s\n", sprintRev ( buf, &aBaseRevision ) );
		logger.printf ( lt_info, "\t Delting \t\t: %d Segments\n", siDeltaSegmentsCount );
		logger.printf ( lt_info, "\t Updating segments list :" );

		for ( short si=0; si < siDeltaSegmentsCount; si++ )
			logger.printf ( lt_info, " %02d", pDeltaSegments [si] );

		logger.printf ( lt_info, "\n\t Exist Base \t\t: \"%s\"\n", pBaseName );

		for ( short s=0; s < siDeltaSegmentsCount; s++ ) {
			BaseInfo aBaseInfo;
			if ( pNewBase->FindBaseInfo ( pDeltaSegments[s], aBaseInfo ) != sizeof ( BaseInfo )){
				logger.printf ( lt_info, "\t Seg N%d exist revision \t: unknown\n", s );
				//fprintf ( "\nDelta segment N%d does not exist in base\n", pDeltaSegments[s] );
			}
			logger.printf ( lt_info, "\t Seg N%d exist revision \t: %s\n", s, sprintRev ( buf, &aExistBaseInfo.LastUpdate ) );			
		}

		docs_in_delta += pHeader->GetDocCount();
		logger.printf ( lt_info, "\n\t Doc in Delta \t\t: %ld\n", pHeader->GetDocCount());
		logger.printf ( lt_info, "\n\t Process start size %lu\n\n\n", getUsedPhsMem () );
		
		if ( siDeltaSegmentsCount > 1 ) {
			char* pComplectName = strdup (b_english_face ? aExistBaseInfo.NameEng : aExistBaseInfo.Name );
#ifndef	WINENCODE
			Recoding ( cd_dos, cd_win, pComplectName ); 
#endif
			SetSegmentName ( pComplectName );
			free (pComplectName);
		} else {
			BaseInfo aBaseInfo;
			pNewBase->FindBaseInfo ( pDeltaSegments[0], aBaseInfo);
#ifndef	WINENCODE
			Recoding ( cd_dos, cd_win, aBaseInfo.Name );
#endif
			SetSegmentName ( b_english_face ? aBaseInfo.NameEng : aBaseInfo.Name, l+1, lDeltaCount, b_english_face );
		}

		free ( pDeltaSegments );
		delete pHeader;
			
		fpDFiles.push_back (fpDFile1);
		FullUnDiff->Reset ( fpDFile1 );
		iRetVal = FullUnDiff->Work (l==0);
		pos_of_correspondents.push_back (FullUnDiff->pos_of_correspondents);
		CleanSegmentName ();

		//! fclose ( fpDFile1 );

		if ( ((ErrorPolicy*)logger.GetPolicy())->ErrCount() ) {
			logger.printf ( lt_always, "\n\tThere is %d error!\n", ((ErrorPolicy*)logger.GetPolicy())->ErrCount() );
		} else
			logger.printf ( lt_always, "\n\tThere is no error\n" );

		logger.printf ( lt_info, "\n\n--------------------------- End of LOG (%ld) --------------------\n\n", l );

		if ( iRetVal != ERR_NONE)
			break;
	} // end for

	if (lDeltaCount)
		FullUnDiff->delete_all ();
	pNewBase->SetReady (TID_GU);

#ifdef N_MALLOC
		Z_reset_malloc_handler ();
		if (g_pReserved)
			free (g_pReserved), g_pReserved = 0;
#endif

	if (iRetVal == ERR_NONE) {
	#if defined(MULTI_INDEX_STREAM_FILE) && defined(QUICK_NEW_DOC) && defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT) && !defined(GARANT_TOOLS)
		free(pNewBase->new_blocks);pNewBase->new_blocks= 0;
		free(pNewBase->new_runs);pNewBase->new_runs= 0;

		char *del_key = "sDel", *upd_key = "sUpd", *size_key = "sSiz";
		Stream *str;
		std::set<long> *pOut= &FullUnDiff->s_DelDocs, s_DelDocs;
		std::set<long>::const_iterator it;
		{
			//синхронизируем s_UpdDocs и s_DelDocs
			str = pNewBase->FindIndex ("Aux")->Open (del_key, 1);
			if (str) {
				if (str->Length () > sizeof(long)) {
					long size = str->Length (), *upd_ids = (long*) malloc (size);
					str->Read (upd_ids, size);
					for (size_t i = 0; i < size / sizeof (long); i++) {
						FullUnDiff->s_DelDocs.insert (upd_ids [i]);
					}
					gk_free (upd_ids);
					for (it = FullUnDiff->s_DelDocs.begin (); it != FullUnDiff->s_DelDocs.end (); it++) {
						if(!std::binary_search(	FullUnDiff->s_UpdDocs.begin() ,FullUnDiff->s_UpdDocs.end(), *it))
							s_DelDocs.insert (*it);
						else{
							logger.printf(lt_info, "include Reindex %ld\n", *it);
							//logger.flush (lt_info);
						}
					}
					pOut= &s_DelDocs;
				}
				if (b_skipturbo){
					pOut->insert (0x7ffffffc);
					str->Seek(0);
					for (it = pOut->begin (); it != pOut->end (); it++) {
						str->Write (&(*it), sizeof (long));
					}
					str->Trunc();
				} else if (b_updateonlyturbo)
					pOut->insert (0x7ffffffc);

				pNewBase->FindIndex ("Aux")->Close (str);
			}
			str = pNewBase->FindIndex ("Aux")->Open (upd_key, 1);
			if (str) {
				if (str->Length () > sizeof(long)) {
					long size = str->Length (), *upd_ids = (long*) malloc (size);
					str->Read (upd_ids, size);
					for (size_t i = 0; i < size / sizeof (long); i++) {
						if(!std::binary_search(	pOut->begin(), pOut->end(), upd_ids [i]))
							FullUnDiff->s_UpdDocs.insert (upd_ids [i]);
						else{
							logger.printf(lt_info, "skip Reindex %ld\n", upd_ids [i]);
							//logger.flush (lt_info);
						}
					}
					gk_free (upd_ids);
				}
				if (b_skipturbo) {
					FullUnDiff->s_UpdDocs.insert (0x7ffffffc);
					str->Seek(0);
					for (it = FullUnDiff->s_UpdDocs.begin (); it != FullUnDiff->s_UpdDocs.end (); it++) {
						long at_it = *it;
						str->Write (&at_it, sizeof (long));
					}
					str->Trunc();
				} else if (b_updateonlyturbo)
					FullUnDiff->s_UpdDocs.insert (0x7ffffffc);
				pNewBase->FindIndex ("Aux")->Close (str);
			}
			str = pNewBase->FindIndex ("Aux")->Open (size_key, 1);
			if (str) {
				if (str->Length () == sizeof (u_int64_t)) {
					u_int64_t old_m_AllPatchedAndNewDocsTextSize;
					str->Read (&old_m_AllPatchedAndNewDocsTextSize, sizeof (old_m_AllPatchedAndNewDocsTextSize));
					FullUnDiff->m_AllPatchedAndNewDocsTextSize += old_m_AllPatchedAndNewDocsTextSize;
				}
				if (b_skipturbo){
					str->Seek(0);
					str->Write (&FullUnDiff->m_AllPatchedAndNewDocsTextSize, sizeof (FullUnDiff->m_AllPatchedAndNewDocsTextSize));
				}
				pNewBase->FindIndex ("Aux")->Close (str);
			}
		}

		if ((FullUnDiff->s_UpdDocs.size () > 1 || FullUnDiff->s_DelDocs.size () > 1) && !b_skipturbo) {
			int SkipAutoSwich= pNewBase->textFile->m_readed.currentDisk;
			pNewBase->textFile->m_readed.currentDisk= 0;
 			NContxtIndex *pContextIndex= (NContxtIndex *)pNewBase->FindIndex(nnn);
			it = FullUnDiff->s_DelDocs.begin ();
			if(FullUnDiff->s_UpdDocs.size () < 2){
				BTIterator GetDocIndex(pContextIndex);
				long first_doc;
				do{
					Stream * pSTR0= pContextIndex->keyOpen(GetDocIndex.Key());
					pSTR0->Read(&first_doc, sizeof(first_doc));
					pContextIndex->Close(pSTR0);
					++GetDocIndex;
				}while(first_doc == *it);
				FullUnDiff->s_UpdDocs.insert (first_doc);
			}
			if (b_updateonlyturbo) {
				if (b_updateonlyturboplus) {
					std::set<long> nodocs;
					for (it = FullUnDiff->s_UpdDocs.begin (); it != FullUnDiff->s_UpdDocs.end (); it++) {
						DocInfo docinfo;
						long id = *it;
						if (pNewBase->FindDocInfo (id, docinfo) == sizeof (DocInfo))
							if ((docinfo.Status & (DS_DOC | DS_EDITION)) || (docinfo.Status_ex & DS_MEDTOPIC))
								pOut->insert (id);
							else
								nodocs.insert (id);
					}
					std::set<long> result;
					std::set_difference (FullUnDiff->s_UpdDocs.begin (), FullUnDiff->s_UpdDocs.end (), nodocs.begin (), nodocs.end (), std::inserter (result, result.end()));
					std::swap (FullUnDiff->s_UpdDocs, result);
				} else {
					for (it = FullUnDiff->s_UpdDocs.begin (); it != FullUnDiff->s_UpdDocs.end (); it++)
						pOut->insert (*it);
				}
			} else  {
				for (it = FullUnDiff->s_UpdDocs.begin (); it != FullUnDiff->s_UpdDocs.end (); it++)
					pOut->insert (*it);
			}
			if(pContextIndex->m_pNIdDelList) free(pContextIndex->m_pNIdDelList);
			pContextIndex->m_pNIdDelList= 0;

			if(pContextIndex && (pContextIndex->m_pNIdList || FullUnDiff->s_UpdDocs.size() >= 1 || pOut->size() >= 1)){
				if(pContextIndex->m_AllPatchedAndNewDocsTextSize < 2)
					pContextIndex->m_AllPatchedAndNewDocsTextSize = FullUnDiff->m_AllPatchedAndNewDocsTextSize;
				pContextIndex->OS_LocalSetProgress= LocalSetProgress;
			#if defined(QUICK_NEW_DOC) && defined(STORE_FORM_N)
				pContextIndex->base= (YBase*)pNewBase;
			#endif
			#ifdef STORE_FORM_N
#ifndef DLT_IN_OLD_CONTEXT
				#ifdef RESTORE_OLD_FORMS_IN_MEM
				screen->SetMessage( "Fill array forms..." );
				#endif
				((FContxtIndex*)((YBase*)pNewBase)->FindIndexOther(const0))
				#ifdef RESTORE_OLD_FORMS_IN_MEM
						->FillForms(pContextIndex)
				#endif
#endif
																							;
			#endif
				long *docs_long_array= 0;
				LocalDocIterator *pIter= 0;
				if(FullUnDiff->s_UpdDocs.size ()/*FullUnDiff->m_ArrayUpdDocs*/){
					docs_long_array = (long*) malloc (sizeof (long) * FullUnDiff->s_UpdDocs.size ());
					long* ptr = docs_long_array;
					for (it = FullUnDiff->s_UpdDocs.begin (); it != FullUnDiff->s_UpdDocs.end (); it++, ptr++ )
						*ptr = *it;
					pIter= new LocalDocIterator( docs_long_array/*(docs_long_array= FullUnDiff->m_ArrayUpdDocs)*/ );
					//FullUnDiff->m_ArrayUpdDocs= 0;
				} else {
					pIter= new LocalDocIterator( pContextIndex->m_pNIdList );
				}
				pContextIndex->log = &logger;
				logger.printf (lt_always, "\n");
				logger.flush (lt_always);

				long *l_ArrayDelDocs= 0, l_SizeArrayDelDocs= 0;

				if(!pContextIndex->m_pNIdList){
					l_SizeArrayDelDocs = pOut->size ();
					l_ArrayDelDocs = (long*) malloc (l_SizeArrayDelDocs * sizeof (long));
					long *ptr = l_ArrayDelDocs;
					for (it = pOut->begin (); it != pOut->end (); it++, ptr++ )
						*ptr = *it;
				} else {
					pContextIndex->SetNormlsBuffCount(pContextIndex->GetNormlsBuffCount() / 4);
				}

				AttrIndex *attrI= (AttrIndex*)FullUnDiff->m_pNewBase->FindIndex ("Attrs");
				pNewBase->textFile->m_readed.currentDisk= SkipAutoSwich;

				logger.printf ( lt_always, "\nUpdate Morpho index... " );
				FullUnDiff->docs_include_header_in_text.clear();
				pNewBase->fill_set(pOldBase, FullUnDiff->docs_include_header_in_text);
				pNewBase->fill_kindsset (pOldBase, FullUnDiff->kinds);

				if ( attrI->streams->Flags & PF_MODIFIED )
					attrI->streams->SaveFat();
				logger.printf (lt_always, "\n");
				logger.flush (lt_always);

				if ( pNewBase->streamFile->Flags & PF_MODIFIED )
					pNewBase->streamFile->SaveFat();
				free(pNewBase->streamFile->m_deletedFat);
				pNewBase->streamFile->m_deletedFat= 0;
				screen->SetMessage( b_english_face ? "Reindex documents" : "Контекстное индексирование документов" );
				if(l_ArrayDelDocs){
					pContextIndex->m_sNIdDelList= l_SizeArrayDelDocs;
					pContextIndex->merge_deleted( pIter, l_ArrayDelDocs);
				}

				pContextIndex->pIOuter= 0;
				gctx_nmain((YBase*)pNewBase, pContextIndex, pIter, FullUnDiff->docs_include_header_in_text, FullUnDiff->kinds);
				delete pIter;

				if( docs_long_array )
					free( docs_long_array );

				pNewBase->streamFile->LoadFat();

				pNewBase->FindIndex ("Aux")->Delete (del_key);
				pNewBase->FindIndex ("Aux")->Delete (upd_key);
				pNewBase->FindIndex ("Aux")->Delete (size_key);
			}
		} //docs_in_delta
	#endif

		if (lDeltaCount) {
			std::vector<FILE*>::const_iterator fpDFiles_it = fpDFiles.begin ();
			std::vector<long>::const_iterator pos_of_correspondents_it = pos_of_correspondents.begin ();
			for (; fpDFiles_it != fpDFiles.end () && pos_of_correspondents_it != pos_of_correspondents.end (); fpDFiles_it++, pos_of_correspondents_it++) {
				FullUnDiff->m_DFile1 = *fpDFiles_it;
				FullUnDiff->read_corrs (*pos_of_correspondents_it);
				fclose (FullUnDiff->m_DFile1);
			}

			FullUnDiff->restore_corrs ();
		}

		logger.printf (lt_always, "\nUpdate complete.\n\n");
		logger.flush (lt_always);

		screen->SetProgress(0);
		screen->SetMessage( b_english_face ? "Update complete" : "Обновление комплекта завершено" );
		screen->CloseScreen();
		sprintf (gu_str, "Обновление комплекта завершено, заняло %ld секунд", (long)(time (0) - start_time));
		gu_info.push_back (gu_str);
		gu_info.push_back ("------------------------------------------------------------");
		str = pNewBase->FindIndex ("Aux")->Open (AUX_INFO, 1);
		if (str) {
			str->Seek (str->Length ());
			for (std::vector<std::string>::const_iterator it = gu_info.begin (); it != gu_info.end (); it++)
				str->Write (it->c_str (), it->size ()+1);
			pNewBase->FindIndex ("Aux")->Close (str);
		}
	} //iRetVal == ERR_NONE

	delete FullUnDiff;
	g_pBase = 0;

	for (std::vector<UpdatedBase*>::iterator base_it = pNewBase->bases_ptrs.begin (); base_it != pNewBase->bases_ptrs.end (); base_it++) {
		if (base_it == pNewBase->bases_ptrs.begin ())
			continue;
		UpdatedBase *base = *base_it;		
		delete base;
	}
	delete pNewBase;

	#ifndef _EXTERN_MAIN
		delete screen;
	#endif

	switch ( iRetVal ) {
		case ERR_NONE:
			fprintf ( presfile, "0" );
			break;

		case ERR_UPDATEDBASE:
			logger.printf ( lt_fatal, "%d:База имеет более свежую дату (%s), чем дельта (%s).\n", ERR_UPDATEDBASE, err_BaseDate, pDeltaNames[l]);
			break;

		case ERR_SKIPDELTA:
			logger.printf ( lt_fatal, "%d:Дельта (%s) не может быть корректно подключена - пропущено обновление с %s по %s.\n", ERR_SKIPDELTA, pDeltaNames[l], err_UpDateFrom, err_UpDateTo);
			break;

		case ERR_NOSEGMENT:
			logger.printf ( lt_fatal, "%d:Сегмент %d из дельты отсутствует в базе.\n", ERR_NOSEGMENT, err_Segment);
			break;

		case ERR_BADVERSION:
			logger.printf ( lt_fatal, "%d:Версии программы и данных не совпадают.\n", ERR_BADVERSION );
			break;

		case ERR_UNKNOWNPART:
			logger.printf ( lt_fatal, "%d:Неизвестная часть дельты. Возможно у Вас старая версия программы.\n", ERR_UNKNOWNPART );
			break;

		case ERR_UNSYNCVER:
			logger.printf ( lt_fatal, "%d:Старая версия программы. Вам необходимо получить новую.\n", ERR_UNSYNCVER );
			break;

		case ERR_UNKNOWN:
			logger.printf ( lt_fatal, "%d:Неизвестная ошибка в файле дельты.\n", ERR_UNKNOWN );
			break;

		case ERR_BADSIZE:
			logger.printf ( lt_fatal, "%d:Неверный размер дельты. Возможно файл не до конца скачался.\n", ERR_BADSIZE );
			break;

		case ERR_NOPARTS:
			logger.printf ( lt_fatal, "%d:Финальная дельта не может быть подключена.\nНе были применены все необходимые частичные дельты\n", ERR_NOPARTS );
			break;

		case ERR_UNKNOWNEOF:
			logger.printf ( lt_fatal, "%d:Неожиданный конец файла дельты (%s)\n", ERR_UNKNOWNEOF, pDeltaNames[l]);
			break;

		case ERR_BADBASE:
			logger.printf ( lt_fatal, "%d:В процессе обновления была нарушена структура базы\n", ERR_BADBASE);
			break;

		default :
			logger.printf ( lt_fatal, "?:Подключение дельты было аварийно завершенно по внутренним причинам.\n" );
			break;
	} // end switch

	if ( g_pReserved )
		free ( g_pReserved );
		
	if ( timer )
		delete timer;

	if ( ((ErrorPolicy*)logger.GetPolicy())->ErrCount() )
		logger.printf ( lt_always, "\n\tThere is %d error!\n", ((ErrorPolicy*)logger.GetPolicy())->ErrCount() );
	else
		logger.printf ( lt_always, "\n\tThere is no error\n" );

	logger.printf ( lt_info, "\n\n*************************** END OF LOG ************************\n\n\n\n" );
	if ( logfile )
		delete logfile;

	for ( l=0; l<lDeltaCount; l++ )
		free ( pDeltaNames [l] );

	free ( pDeltaNames );
	free ( pBaseName );
	free ( pLogName );

	return ( iRetVal == ERR_NONE ? 0 : 1 );
}

#include "UpdtMorph.h"

CtxLongSet lsdef_00;
static u_intPointerV_tCtxLongSetSplayMap tmpA(lsdef_00);

		extern "C" {
			extern int IsMultiFormsNC(char *);
			extern int IsMultiFormsBC(char *);
			extern int IsMultiFormsWC(char *);
			extern int CalcNodeSizeNC(char *, int added, long *, int *, long *, int *);
			extern int CalcNodeSizeBC(char *, int added, long *, int *, long *, int *);
			extern int CalcNodeSizeWC(char *, int added, long *, int *, long *, int *);
			extern int write_stream_FromReaded(int (__cdecl *pPNode)(char*,int,long*,int*,long*,int*),
												stream_st *, void *, u_int32_t, int, int);

		}
		#include "ContextStreamReader.h"
		class CSReader : public ContextStreamReader
		{
		public:
			CSReader (Index *pI, char form, bool is_titles = false)
				: ContextStreamReader(0,0,false,0)
			{
				m_pClosed= pI;
				pBigStream= 0;
			}
			virtual void init(long *pPos, BTKEY k, int stream_N){
			#if defined(STORE_FORM_N) && defined(MIN_MEM_CONTEXT)
				if(pBigStream)
					Delete();
				pBigStream= m_pClosed->keyOpen(k, stream_N);*pPos= 2;
				ContextStreamReader::init(pBigStream,-1,false,&(RefCollection()));
				if(((short*)m_data)[2] & 0x8000)
					*pPos= 3;
			#endif
			}
			void Delete(){
				if (pBigStream) {
					if(pBigStream->Buf)
						free(pBigStream->Buf);
					pBigStream->Buf= 0;
					delete pBigStream;
					pBigStream= 0;
				}
			}
			bool NextRef (Ref &rr, char &cc){
				return ContextStreamReader::getNextRef(rr,cc);
			}
			~CSReader () {
				Delete();
			}
			char tmpVl;
			Ref tmpRf;
			Stream *pBigStream;
			Index *m_pClosed;
		protected:
			virtual void transferSub(long &out){
				long lPos;
				if(0x8000 & *(short*)m_data){
					memcpy(&lPos, m_data, 3);
					if((*(short*)m_data) & 0x4000)
						lPos= (((lPos & 0xff0000) >> 2) | (lPos & 0x3fff))|0x80000000;
					else
						lPos= ((lPos & 0xff0000) >> 2) | (lPos & 0x3fff);
					m_tail -= 3;
					m_data += 3;
				}else{
					memcpy(&lPos, m_data, 2);
					if((*(short*)m_data) & 0x4000)
						lPos= (lPos & 0x3fff)|0x80000000;
					else{
						lPos= lPos & 0x3fff;
					}
					m_tail -= 2;
					m_data += 2;
				}
				out= lPos+m_re;
				if(lPos&0x80000000)
					out= ((out >> 14) << 15) | (out & 0x3fff) | 0x80000000;
				else
					out= ((out >> 14) << 15) | (out & 0x3fff);
				m_re += lPos & 0xfffffc;

				if (out & 0x80000000) { // is blast word
					m_is_bindoc = true;
				}
			}
		};

u_int32_t sDocsAndPossMaxBuff= 96*1024*1024;

void *load_Stream_NWCntxt(stref_st *pref, iter_st *spit, stream_st *psstr)
{
	int short_stream= IS_SHORT_STR(pref);
	if(!(psstr-1)->pDeletedNorms){
		if(!((psstr-1)->pDeletedNorms= (char*)malloc(sDocsAndPossMaxBuff+sizeof(int))))
			exit(-636);
		*(int*)((psstr-1)->pDeletedNorms+sDocsAndPossMaxBuff)= 0;
	}
	if(!short_stream){
		spit->str->str_header= (psstr-1)->pDeletedNorms;
		load_stream_ex(spit->str, pref, psstr, &(spit->strinfo));
		psstr->flags &= ~SF_FREEBUF;
	}else{
		if(!load_stream_ex(spit->str, pref, psstr, &(spit->strinfo)))
			return (void *)-2;
	}
	if(spit->nstreams == 3){
		stream_st psstr2;
		char *new_data= 0, *new_write;
		u_int32_t nxt_sz= 0;
		int short_stream2= IS_SHORT_STR((pref+2));

		memset(&psstr2, 0, sizeof(*psstr));
		if(short_stream && short_stream2){
			memcpy((psstr-1)->pDeletedNorms, psstr->data, psstr->ref.size);
			psstr->rec= psstr->data= (psstr-1)->pDeletedNorms;
		}
		if(!short_stream2){
			spit->str->str_header= (psstr-1)->pDeletedNorms + pref->size;
			load_stream_ex(spit->str, pref+2, &psstr2, &(spit->strinfo));
			psstr2.flags &= ~SF_FREEBUF;
		}else{
			spit->str->str_header= 0;
			load_stream_ex(spit->str, pref+2, &psstr2, &(spit->strinfo));
		}
		new_write= new_data= (psstr-1)->pDeletedNorms + sDocsAndPossMaxBuff - psstr->ref.size/2  - psstr2.ref.size;
		do{
			memcpy(new_write, psstr->rec, sizeof(u_int32_t));
			nxt_sz= ((ref_st*)psstr->rec)->sub - nxt_sz;
			new_write += sizeof(u_int32_t);
			memcpy(new_write, psstr2.rec, nxt_sz);
			psstr2.rec += nxt_sz;
			new_write += nxt_sz;
			nxt_sz= ((ref_st*)psstr->rec)->sub;
			psstr->rec += sizeof(ref_st);
			psstr->ref.size -= sizeof(ref_st);
		}while(psstr->ref.size);

		if(psstr->flags & SF_FREEBUF)
			free(psstr->data);

		psstr->flags &= ~SF_FREEBUF;
		spit->str->str_header= 0;
		psstr->rec= psstr->data= new_data;
		psstr->ref.size= new_write-new_data;

		release_stream(&psstr2);
	}
	return psstr;
}

long add_tmpA= 0, *p_tmpDelDocs= 0;

stream_st *load_Stream2_ex(streamfile_st *psf, stref_st *pref, stream_st *pstr, stream_info *strinfo)
{
	stream_st *pRet= load_stream_ex(psf, pref, pstr, strinfo);
	if(pRet){
		memcpy((pstr-1)->data, pstr->data, ((pstr-1)->ref.size= pstr->ref.size));
		release_stream(pstr);
	}
	return pRet;
}

extern "C" int CompStringsZZZX(const void *, const void *);
extern int attach_buff(stream_st *pdstr, stref_st *pref, index_st *pIndexOut);
const char errorMSG[]= "ERROR GU: Not find actual form '%s' for norm '%s' !!!";

void ReRead_Stream(NContxtIndex *pNIndx, stream_st *pstr, stref_st *pref, u_intPointerV_tCtxLongSetSplayMap *ptmpA, char *flushName= 0)
{
	u_int32_t pgsize;
	stream_st *pdstr= pstr+1;
	Pix ii/*, jj*/;
	u_intFrm_tCtxLongSetSplayMap tmpF(pNIndx->lsdef);

	u_int64_tCtxLongSetSplayMap Indxs(pNIndx->lsdef);

	long NewVal= 0, startRead= 0, startProc= 0;
	int szBlockPointersN= pdstr->szBlockPointers, lookOlForms= 1, maxOld= pdstr->ref.size/32;
	char **ppN= pdstr->ppBlock;
	pdstr->ref.size= 0;

	if(!pNIndx->IsNormsIndex()){
		(*ptmpA)[(void*)&lookOlForms];
		lookOlForms= 0;
	}
	pgsize = 1 << pstr->str->pgfile.pgpow;
	if(pstr->ref.size <= pstr->info.immds)
		pstr->ref.size= pstr->ref.size;
	else{
		  ReParse_Stream(&Indxs, pNIndx, pstr, ptmpA, lookOlForms, &NewVal, &tmpF, ppN, -1, 0);
		  {
			int WithOldNumbers= 0, CompOk= 0;
			ii = ptmpA->first();
			if(tmpF.length() == 0){
				// всегда старая форма(ы) подходит для новой(ых) //
				while(ii){
					ptmpA->contents(ii).lastI=  NewVal++;
					ptmpA->next(ii);
				}
			}else{
				while(ii){
					ptmpA->contents(ii).lastI=  -1;
					ptmpA->next(ii);
				}
				for(startRead= 0; startRead < maxOld; startRead++){
					for( ii = ptmpA->first(); ii; ptmpA->next(ii) ){
						if(!pNIndx->pp_ctxTextCacheArray[pNIndx->cacheI]
								->comp_items(	*ppN+32*startRead,
												((u_int64_tCtxLongSetSplayNode *)
												*(long*)ptmpA->pkey(ii))->curr_item)){
							// для новых подходят старые индексы //
							CompOk++;
							if(startRead >= NewVal){
								// новые индексы могут начинаться только с максимального из актуальных старых //
								NewVal= startRead+1;
							}
							tmpF.del(u_int64_t(startRead));
							ptmpA->contents(ii).lastI=  startRead;
							break;
						}
					}
					if(!ii && !tmpF.seek(u_int64_t(startRead))){
						// сохранаем старые неактуальные индексы //
						pstr->ArrayIOffs[pstr->ArrayIOffsCount++].i= (unsigned char)startRead;
					}
				}
				for( ii = ptmpA->first(); ii; ptmpA->next(ii) ){
					if(ptmpA->contents(ii).lastI ==  -1){
					  if(pstr->ArrayIOffsCount){
						WithOldNumbers++;
						ptmpA->contents(ii).lastI= (long)pstr->ArrayIOffs->i;
						if((int)pstr->ArrayIOffs->i >= NewVal)
							NewVal= (int)pstr->ArrayIOffs->i+1;
						pstr->ArrayIOffsCount--;
						if(pstr->ArrayIOffsCount){
							memcpy(pstr->ArrayIOffs, pstr->ArrayIOffs+1,
									sizeof(*pstr->ArrayIOffs)*(pstr->ArrayIOffsCount-1));
						}
					  }else
						ptmpA->contents(ii).lastI= NewVal++;
					}
				}
			}
			if((pstr+2)->pAForms){
			  char *pFormCOld;
			  Form_Node *fndForm= 0;
			  for( ii = tmpF.first(); ii; tmpF.next(ii) ){
			    // старая форма актуальна в мапе старых форм //
				pFormCOld= ppN[0]+ *(unsigned char*)tmpF.pkey(ii)*32;
				if(*pFormCOld < 32){
					if(!(fndForm= (Form_Node *)bsearch(	pFormCOld+1
								, (pstr+2)->pAForms, (pstr+2)->max_B, sizeof(Form_Node)
								, CompStringsZZZX))){
						printf(errorMSG, pFormCOld+1, (char*)pref - 32);
						//__debugbreak();
					}else
						fndForm->BasesMask= (u_int64_t)1;
				}else{
					char tmpKeyOld[32];
					memcpy(tmpKeyOld, pFormCOld+1, 31);
					tmpKeyOld[31]= 0;
					if(!(fndForm= (Form_Node *)bsearch(	tmpKeyOld
								, (pstr+2)->pAForms, (pstr+2)->max_B, sizeof(Form_Node)
								, CompStringsZZZX))){
						printf(errorMSG, tmpKeyOld, (char*)pref - 32);
						//__debugbreak();
					}else
						fndForm->BasesMask= (u_int64_t)1;
				}
			  }
			}
			if(!pdstr->hDocsFile){
				pdstr->hDocsFile = -2;
				if(!pdstr->pDeletedNorms){
					if(!(pdstr->pDeletedNorms= (char*)malloc(sDocsAndPossMaxBuff+sizeof(int))))
						((N_WCU*)pNIndx)->exit(-636,"pdstr->hDocsFile");
					*(int*)(pdstr->pDeletedNorms+sDocsAndPossMaxBuff)= 0;
				}
			}else if(pdstr->temp_flush_handle)
				pdstr->ref.size= pdstr[-1].refs_count;
			ReParse_Stream(&Indxs, pNIndx, pstr, ptmpA, lookOlForms, &NewVal, &tmpF, ppN, WithOldNumbers, CompOk);
		  }
	}
	pNIndx->ReWrite_Stream(pdstr, &Indxs);
	pstr->flags |= SF_WRLOCK;
	if(flushName){
		unsigned long buff_Sz= 0xe000;
		c_io_write((int)pdstr->temp_flush_handle, (pdstr+5)->data, (pdstr+5)->rec-(pdstr+5)->data);(pdstr+5)->rec= (pdstr+5)->data;
		c_io_close(pdstr->temp_flush_handle);pdstr->temp_flush_handle= 0;
		pstr->temp_flush_handle= c_io_open(	flushName, ACE_OS_O_RDONLY | ACE_OS_O_BINARY);
		char *flushBff= ppN[0] + (256 * 32);
		long lstBytes= pdstr->ref.size % buff_Sz;
		long repeat_flush= pdstr->ref.size / buff_Sz; pdstr->ref.size= 0;
		while(repeat_flush--){
			c_io_read(pstr->temp_flush_handle, flushBff, buff_Sz);
			write_stream(pdstr, flushBff, buff_Sz);
		}
		c_io_read(pstr->temp_flush_handle, flushBff, lstBytes);
		write_stream(pdstr, flushBff, lstBytes);
		c_io_close(pstr->temp_flush_handle);
		pstr->temp_flush_handle= 0;
		pstr->refs_count= 0;
		attach_stream(pdstr, pref);
		pstr->ppBlock= pdstr->ppBlock;
		pstr->bcount= pdstr->bcount;
		pstr->szBlockPointers= pdstr->szBlockPointers;
	}else if(pdstr->temp_flush_handle == 0)
		attach_stream(pdstr, pref);

	if(pdstr->temp_flush_handle == 0){
		close_stream(pdstr);
		pdstr->refs_count += pstr->hDocsFile;
		if(pdstr->hDocsFile > 0){
			c_io_lseek(pdstr->hDocsFile, 0, ACE_OS_SEEK_SET);
			int bff_sz= 0xe000, ww_bff= (pdstr->refs_count)/bff_sz, ww_bff_lst= (pdstr->refs_count)%bff_sz;
			char *bff_wr= ppN[0] + (256 * 32);
			while(ww_bff--){
			  c_io_read(pdstr->hDocsFile, bff_wr, bff_sz);
			  write_stream(pdstr, bff_wr, bff_sz);
			}
			c_io_read(pdstr->hDocsFile, bff_wr, ww_bff_lst);
			write_stream(pdstr, bff_wr, ww_bff_lst);
			attach_stream(pdstr, pref - 2);
		}else
			attach_buff(pdstr, pref - 2, 0);
	}
	pdstr->ArrayIOffsCount= NewVal;
	pdstr->ppBlock= ppN;
	pdstr->szBlockPointers= 32;
	pdstr->bcount= 1;
}

#include "shared/ContextSearch/Common/Constants.h"
extern "C" void * bsearch_nxt(long, long **, int *);
#ifdef DLT_IN_OLD_CONTEXT
extern int first_read6tr;
 void *next_word_key(iter_st *pit, long **pOtr)
 {
	next_key(pit);
	if(pit->pkey[0] != 0)
		pit->pkey= 0;
	else
		*pOtr= (long*)(pit->pkey+1);

	return pit->pkey;
 }
#endif
void N_WCU::WordPosControl(long ID, int ParaN, int *pVal, int textpos_add){
	if(ParaN == 1) {
		*pVal= ContextSearch::DOC_BEGIN_WORD + textpos_add;
		if(brb){
			if(!pAllWordPos){
				pAllWordPos= new char[4];
				pPutWordPosCount= pAllWordPos;
				m_ID = ID;
				static char const1[]="SWords.str";
				FormsIName= &(const0[0]);
				pParaStartIndexName= &(const1[0]);
				//
				ptarget= makeBaseForCopy(	base, thisBase, file, streams, m_pNIdList, Root,
#ifdef DLT_IN_OLD_CONTEXT
												g_OldCntxN, Name, &p_UpdThdr, &gs_target_name, &pin, &spit, &pdstr);
				memcpy(streams->Fat,thisBase.str.fat,thisBase.str.fat_size*thisBase.str.pgfile.pfhdr->page_size);
				free(thisBase.str.fat);
				prin= pin + 1;
				prin->str->fat= (fat_rec_type *)(streams->Fat);
				thisBase.str.fat= prin->str->fat;
				psstr= pdstr + 2;
				Forms= 0;
				if(spit->pkey){
					init_iter(prin, spit+1);
					first_key(spit+1);
					while( (0x40 & *spit[1].pkey) != 0x40 )
						next_key(spit+1);
				}
#ifdef POST_DEACTUAL_ALL_FORMS
				else{
					Forms= base->FindIndex(FormsIName);
					prin[1].pf= thisBase.pSubToms->pKey= (pgfile_st*)calloc(1, sizeof(thisBase.key));
					prin[1].str= thisBase.pSubToms->pStr= (streamfile_st *)calloc(1, sizeof(thisBase.str));

					if(!open_pgfile(Forms->file->FileName, thisBase.pSubToms->pKey)
							||
						!open_pgfile(Forms->streams->file->FileName, (pgfile_st*)(thisBase.pSubToms->pStr))
							||
						!(prin[1].pf->PrmExt.cur_Seek= my_def_io_seek) || !(prin[1].pf->PrmExt.cur_Read= my_def_io_read)
							||
						!(prin[1].pf->PrmExt.accesMode |= ACE_OS_O_RDWR)
							||
						!get_info(prin[1].pf, FormsIName, &(prin[1].hdr))
							||
						!(((pgfile_st*)(thisBase.pSubToms->pStr))->PrmExt.pCrptTag= prin[1].pf->PrmExt.pCrptTag= Forms->file->m_pCryptoTag)
							||
						!init_iter(prin+1, spit+1)
							||
						!first_key(spit+1)){
						exit(-29);
					}
					thisBase.pNextSubToms->pKey= prin[1].pf;
					thisBase.pNextSubToms->pStr= prin[1].str;
					thisBase.pNextSubToms->pName= strdup(FormsIName);
					thisBase.pNextSubToms++;

					prin[1].str->fat_size= Forms->streams->fatPages;
					prin[1].str->fat= (fat_rec_type *)(Forms->streams->m_deletedFat);
					init_streams_cache(prin[1].str, OBSC_SEQSP | OBSC_LARGE);
					//
					if(prin[1].str->hits) free(prin[1].str->hits); prin[1].str->hits= 0;
					Forms->streams->m_deletedFat= 0;
				}
#endif
				memset(&inw, 0, sizeof(inw));
				memset(&itw, 0, sizeof(itw));
				inw= *prin;
				init_iter(&inw, &itw);
				first_key(&itw);
				pdstr->flags |= SF_NOALLOC;
				create_stream(pin, pdstr);
				((pgfile_st*)(pin->str))->PrmExt.cur_Seek= pin->pf->PrmExt.cur_Seek= my_def_io_seek;
				//
				newSZ= m_sNIdDelList;
				p_DelDocs= m_pNIdDelList;
				memset(key_buff, 0, pin->hdr.keylen);
				if(spit->pkey == 0){
					write_stream(pdstr, m_pNIdDelList, m_sNIdDelList*4-4);
				}else{
					load_stream_ex(itw.str, get_stref(&itw, 1), psstr, &(itw.strinfo));
					int oldC= psstr->ref.size/4, newC= m_sNIdDelList-1;
					long *pOldC= (long*)(psstr->data), *pNewC= m_pNIdDelList, *wwD= (long*)malloc((oldC+newC)*4), *wwDn= wwD;
					unsigned long wwC= 0;

					while(oldC && newC){
						if(*pOldC < *pNewC){
							*wwDn= *pOldC;pOldC++;oldC--;wwC++;wwDn++;
						}else if(*pOldC == *pNewC){
							*wwDn= *pOldC;pOldC++;oldC--;wwC++;wwDn++;pNewC++;newC--;
						}else{
							*wwDn= *pNewC;pNewC++;newC--;wwC++;wwDn++;
						}
					}
					write_stream(pdstr, wwD, wwC*4);
					write_stream(pdstr, pOldC, oldC*4);
					write_stream(pdstr, pNewC, newC*4);
					release_stream(psstr);
					next_word_key(&itw, &pikey);
				}
				attach_stream(pdstr, get_stref_ex(	key_buff, pin->hdr.keylen, pin->hdr.strinfo.immds,
										pin->hdr.nstreams, 1));
				close_stream(pdstr);
				add_key(pin, key_buff);
				//
			}else{
				//
				*key_buff= 0;
				*(long*)(key_buff+1)= m_ID;
				attach_stream(pdstr, get_stref_ex(	key_buff, pin->hdr.keylen, pin->hdr.strinfo.immds,
										pin->hdr.nstreams, 0));
				close_stream(pdstr);
				add_key(pin, key_buff);
				//
				m_ID = ID;
			}
			AllParaCount= ParaN;
			pikey= (long*)(itw.pkey+1);
			while(itw.pkey && *pikey < m_ID){
				if(!bsearch_nxt(*pikey, &p_DelDocs, &newSZ)){
					load_stream_ex(itw.str, get_stref(&itw, 0), psstr, &(itw.strinfo));
					move_stream(psstr, pdstr->str, get_stref(&itw, 0));
					add_key(pin, itw.pkey);
					release_stream(psstr);
				}
				next_word_key(&itw, &pikey);
			}
			if(!itw.pkey || *pikey == m_ID || *pikey > m_ID){
				if(itw.pkey && *pikey == m_ID)
					next_word_key(&itw, &pikey);
				write_stream(pdstr, pVal, 3);
#else

												Name, Name, &p_UpdThdr, &gs_target_name, &pin, &spit, &pdstr);
				//
				prin= pin + 1;
				psstr= pdstr + 2;
				//
				Forms= base->FindIndex(FormsIName);
				prin[1].pf= thisBase.pSubToms->pKey= (pgfile_st*)calloc(1, sizeof(thisBase.key));
				prin[1].str= thisBase.pSubToms->pStr= (streamfile_st *)calloc(1, sizeof(thisBase.str));

				if(!open_pgfile(Forms->file->FileName, thisBase.pSubToms->pKey)
						||
					!open_pgfile(Forms->streams->file->FileName, (pgfile_st*)(thisBase.pSubToms->pStr))
						||
					!(prin[1].pf->PrmExt.cur_Seek= my_def_io_seek) || !(prin[1].pf->PrmExt.cur_Read= my_def_io_read)
						||
					!(prin[1].pf->PrmExt.accesMode |= ACE_OS_O_RDWR)
						||
					!get_info(prin[1].pf, FormsIName, &(prin[1].hdr))
						||
					!(((pgfile_st*)(thisBase.pSubToms->pStr))->PrmExt.pCrptTag= prin[1].pf->PrmExt.pCrptTag= Forms->file->m_pCryptoTag)
						||
					!init_iter(prin+1, spit+1)
						||
					!first_key(spit+1)){
					exit(-29);
				}
				thisBase.pNextSubToms->pKey= prin[1].pf;
				thisBase.pNextSubToms->pStr= prin[1].str;
				thisBase.pNextSubToms->pName= strdup(FormsIName);
				thisBase.pNextSubToms++;

				prin[1].str->fat_size= Forms->streams->fatPages;
				prin[1].str->fat= (fat_rec_type *)(Forms->streams->m_deletedFat);
				init_streams_cache(prin[1].str, OBSC_SEQSP | OBSC_LARGE);
				//
				if(prin[1].str->hits) free(prin[1].str->hits); prin[1].str->hits= 0;
				free(Forms->streams->file->SystemPageBuf);
				free(Forms->file->SystemPageBuf);
				Forms->streams->m_deletedFat= 0;
				//
				memset(&inw, 0, sizeof(inw));
				memset(&outw, 0, sizeof(outw));
				memset(&itw, 0, sizeof(itw));
				open_index_hack(prin->pf, pParaStartIndexName, &inw);
				inw.str= prin->str;
				init_iter(&inw, &itw);
				first_key(&itw);
				create_index_hack(pin->pf, pParaStartIndexName, &outw);
				outw.str= pin->str;
				outw.pbase= ptarget;
				pdstr->flags |= SF_NOALLOC;
				create_stream(&outw, pdstr);
				((pgfile_st*)(outw.str))->PrmExt.cur_Seek= outw.pf->PrmExt.cur_Seek= my_def_io_seek;
				//
				newSZ= m_sNIdDelList;
				p_DelDocs= m_pNIdDelList;
				//
			}else{
				//
				*(long*)key_buff= m_ID;
				attach_stream(pdstr, get_stref_ex(	key_buff, outw.hdr.keylen, outw.hdr.strinfo.immds,
										outw.hdr.nstreams, 0));
				close_stream(pdstr);
				add_key(&outw, key_buff);
				//
				m_ID = ID;
			}
			AllParaCount= ParaN;
			while(itw.pkey && *(long*)itw.pkey < m_ID){
				if(!bsearch_nxt(*(long*)itw.pkey, &p_DelDocs, &newSZ)){
					load_stream_ex(itw.str, get_stref(&itw, 0), psstr, &(itw.strinfo));
					move_stream(psstr, pdstr->str, get_stref(&itw, 0));
					add_key(&outw, itw.pkey);
					release_stream(psstr);
				}
				next_key(&itw);
			}
			if(!itw.pkey || *(long*)itw.pkey == m_ID || *(long*)itw.pkey > m_ID){
				if(itw.pkey && *(long*)itw.pkey == m_ID)
					next_key(&itw);
				write_stream(pdstr, pVal, 3);
#endif
			}
		}
	}
	else if(brb && ParaN > 0 && AllParaCount != ParaN){
		AllParaCount= ParaN;
		write_stream(pdstr, pVal, 3);
	}
}

int MergeStreams(	CSReader &tmpBig, index_st *pin, LPPL_ZZZ pNew, long isLast, stream_st *pdstr,
					stream_st *psstr, iter_st *spit, long *pPos, long* pDelDocs, set_st* pDel0Docs,
					int retComp)
{
	char oldtmpVl, zInsx[1024*1024];
	int cc;
	Ref oldtmpRf;

	int OnlyNew= 0;
	char *pUpdate= 0, *pGStart= 0;

	//if(spit){
	  char *pNext;
	  long nodes_size, writed= 0, remainder;
	 if(!(*pPos)){
		 tmpA.clear();
		 add_tmpA= 0;
		 if(spit->pkey){
	  if(spit->pkey && !retComp){
		// начинаем объеденять
		stref_st *pref;
		pref= get_stref(spit, 0);
		if((pref->size + pref->size/2 + 2*pref[2].size) < sDocsAndPossMaxBuff){
			if(load_Stream_NWCntxt(pref, spit, psstr) == (void*)-2)
				return -22;
		}else{
			memcpy(	tmpBig.m_pClosed->streams->file->m_postFilePoss
					, psstr->str->pgfile.PrmExt.pFilePoss, MAX_COUNT_FILE_HANDLES*sizeof(u_int32_t));
			tmpBig.init(pPos, spit->pkey, 0);
			tmpBig.NextRef(tmpBig.tmpRf, tmpBig.tmpVl);
			pGStart= ((char*)&tmpBig.tmpRf) - *pPos;
			psstr->ref.size= 0x7fffffff;
		}
		pUpdate= pNew->readBuff;
	  }else{
		pdstr->ArrayIOffsCount= psstr->ArrayIOffsCount= 0;
		(psstr-1)->ref.size= 0;
	  }
														}
	 }else if(*pPos != 1){
	  // продолжаем объеденять
	  pUpdate= pNew->readBuff;
	  if(psstr->ref.size == 0x7fffffff){
		  pGStart= ((char*)&tmpBig.tmpRf) - *pPos;
	  }
	 }
	  if(pUpdate){
		//*pPos= 0;
		//OnlyNew++;
		
		long saved_remainder, moved= 0;
		static int GAdded;
		int (__cdecl *pPNode)(char*,int,long*,int*,long*,int*)= 0;
		long lDoc, lcount;
		int fOffs= 0, repeat= 0;

		if(!pGStart)
			pGStart= psstr->data;
		else if(*pPos < 4){
			GAdded= 0;
			pPNode= CalcNodeSizeWC;
			pdstr->ArrayIOffsCount= 0;
		}
		// Merge Nodes //
		if(!(*pPos)){
			GAdded= 0;
			if((pdstr+1)->ref.size > 32)
				GAdded= 1;
			pdstr->ArrayIOffsCount= 0;
		}
		pPNode= CalcNodeSizeWC;

		pNext= pGStart + *pPos;
		do{
			while(*pPos < (long)psstr->ref.size && (lDoc= 0x7fffffff & *(long*)pNext) < *(long*)pUpdate){

if(pdstr->ref.size > max_size00 && (pdstr+1)->ref.size == 32 && (*pPos) && (*pPos) != 1 && add_tmpA){
	{
		u_int32_t pre_size= (pdstr+1)->ref.size;
		if(!(pdstr+1)->temp_flush_handle){
			(pdstr+1)->temp_flush_handle
				= c_io_open(	name_temp_flush_handle
								, ACE_OS_O_WRONLY | ACE_OS_O_BINARY | ACE_OS_O_CREAT);
			pdstr->hDocsFile= 0;
			(pdstr+1)->refs_count= 0;
		}
		ReRead_Stream(pNIndexReRead, pdstr, pref00, &tmpA);
		pdstr->refs_count= (pdstr+1)->ref.size;
		(pdstr+1)->ref.size= pre_size;
		(pdstr+1)->data = (pdstr+1)->rec = (pdstr+1)->ppBlock[0];
		close_stream(pdstr);
	}
	OnlyNew= 0;
	moved= 0;
	fOffs= 0; repeat= 0;

	if(psstr->ref.size == 0x7fffffff){
		pGStart= ((char*)&tmpBig.tmpRf) - *pPos;
		if(*pPos < 4){
			GAdded= 0;
			pPNode= CalcNodeSizeWC;
			pdstr->ArrayIOffsCount= 0;
		}
	}else
		pGStart= psstr->data;

	pNext= pGStart + *pPos;
}

				while(*p_tmpDelDocs < lDoc)
					p_tmpDelDocs++;
				{
				  if(psstr->ref.size == 0x7fffffff){
				    oldtmpRf= tmpBig.tmpRf;
					oldtmpVl= tmpBig.tmpVl;
				    nodes_size= 0;
					if(*p_tmpDelDocs == lDoc){
						while(!(tmpBig.tmpRf.DocId= 0) && tmpBig.NextRef(tmpBig.tmpRf, tmpBig.tmpVl)){
							if(tmpBig.tmpRf.DocId)
								break;
							oldtmpRf.Sub= tmpBig.tmpRf.Sub;
							oldtmpVl= tmpBig.tmpVl;
						}
					}else{
						if(write_stream(pdstr, &tmpBig.tmpRf.DocId, sizeof(long)) != sizeof(long))
							return -1;
						while(!(tmpBig.tmpRf.DocId= 0) && tmpBig.NextRef(tmpBig.tmpRf, tmpBig.tmpVl)){
							if(tmpBig.tmpRf.DocId)
								break;
							if(write_stream(pdstr, &oldtmpRf.Sub, sizeof(long)) != sizeof(long))
								return -1;
							oldtmpRf.Sub= (long)oldtmpVl;
							cc= psstr->ArrayIOffsCount;
							while(cc--){
								if(psstr->ArrayIOffs[cc].i == (unsigned char)(oldtmpVl&0x7f))
									break;
							}
							if(cc == -1){
								psstr->ArrayIOffs[psstr->ArrayIOffsCount].i= (unsigned char)(oldtmpVl&0x7f);
								psstr->ArrayIOffsCount++;
							}
							if(write_stream(pdstr, &oldtmpRf.Sub, sizeof(long)) != sizeof(long))
								return -1;
							oldtmpRf.Sub= tmpBig.tmpRf.Sub;
							oldtmpVl= tmpBig.tmpVl;
						}
						if(write_stream(pdstr, &oldtmpRf.Sub, sizeof(long)) != sizeof(long))
							return -1;
						oldtmpRf.Sub= oldtmpVl;
						cc= psstr->ArrayIOffsCount;
						while(cc--){
							if(psstr->ArrayIOffs[cc].i == (unsigned char)(oldtmpVl&0x7f))
								break;
						}
						if(cc == -1){
							psstr->ArrayIOffs[psstr->ArrayIOffsCount].i= (unsigned char)(oldtmpVl&0x7f);
							psstr->ArrayIOffsCount++;
						}
						if(write_stream(pdstr, &oldtmpRf.Sub, sizeof(long)) != sizeof(long))
							return -1;
					}
					if(!tmpBig.tmpRf.DocId){
						break;
					}
				  }else
					nodes_size= write_stream_FromReaded(pPNode, 0, pNext,(long)psstr->ref.size, GAdded, 0);
				}
				if(nodes_size && *p_tmpDelDocs == lDoc){
					saved_remainder= (long)pNext - (long)pGStart - *pPos;
					{
					  if(write_stream_FromReaded(	pPNode, pdstr, pGStart + *pPos,
													saved_remainder, GAdded, 0) != saved_remainder)
						return -1;
					}
					*pPos += saved_remainder + nodes_size;
					pNext += nodes_size;
					continue;
				}
				if(nodes_size + (long)pNext - (long)pGStart >= (long)psstr->ref.size){
					if(lDoc < *(long*)pUpdate){
						pNext += nodes_size;
					}else
						psstr->ref.size -= nodes_size;
					break;
				}
				pNext += nodes_size;
			}
			nodes_size= (long)pNext - (long)pGStart - *pPos;
			{
				if(psstr->ref.size == 0x7fffffff){
					if(!tmpBig.tmpRf.DocId)
						*pPos= (long)psstr->ref.size;
				}else if(write_stream_FromReaded(	pPNode, pdstr, pGStart + *pPos,
											nodes_size, GAdded, 0) != nodes_size)
					return -1;
			}
			*pPos += nodes_size;
			if(*pPos < (long)psstr->ref.size && lDoc >= *(long*)pUpdate){
				add_tmpA++;
				if(lDoc == *(long*)pUpdate){
				  if(psstr->ref.size == 0x7fffffff){
				    nodes_size= 0;
					while(!(tmpBig.tmpRf.DocId= 0)){
						if(tmpBig.NextRef(tmpBig.tmpRf, tmpBig.tmpVl)){
							if(tmpBig.tmpRf.DocId)
								break;
						}else{
							*pPos= (long)psstr->ref.size;
							break;
						}
					}
				  }else{
					  do{
						  nodes_size= pPNode(pNext, GAdded, &lDoc, &fOffs, &lcount, (int*)zInsx);
					  }while(repeat-- && (nodes_size -= sizeof(long)) && (pNext += nodes_size));
					  pNext += nodes_size;
					  *pPos += (long)pNext - (long)pGStart - *pPos;
				  }
				}
				repeat= 0;
			}
			remainder= pNew->read - (long)pUpdate + (long)pNew->readBuff + moved;
			if(*pPos >= (long)psstr->ref.size){
				if(remainder){
					pNew->read= remainder;
					pUpdate= pNew->readBuff+writed;
					OnlyNew++;
					break;
				}
				return 0;
			}else{
				saved_remainder= remainder;
				while((0x7fffffff & *(long*)pNext) > *(long*)pUpdate){
				  do{
					char *dnxt= pUpdate+(nodes_size= 4);
					do{
						nodes_size += 8;
					}while(!(*(long*)dnxt & 0x80000000) && (dnxt+=8));
					while(remainder <= nodes_size
							|| remainder - nodes_size == sizeof(long)){
						if(remainder - nodes_size == sizeof(long)){
							moved= sizeof(long);
							saved_remainder -= moved;
							if(write_stream(pdstr, pNew->readBuff + writed, saved_remainder)
											!= saved_remainder)
								return -1;
							*(long*)pNew->readBuff
								= *(long*)(pUpdate+nodes_size);
							pUpdate=pNew->readBuff;
							nodes_size= BUFF_SIZE_FROM_TEMP - moved;
							pNew->read= pNew->pInd->len <= nodes_size
											? pNew->pInd->len : nodes_size;
							if(pNew->read != ::ACE_OS::read(	pNew->file,
													pNew->readBuff + moved,
													pNew->read))
								return -333;
							pNew->pInd->len -= pNew->read;
							pNew->file_len -= pNew->read;
							remainder= saved_remainder= pNew->read + moved;
							writed= nodes_size= 0;
						}else{
							moved= 0;
							if(write_stream(pdstr, pNew->readBuff + writed, saved_remainder)
											!= saved_remainder)
								return -1;

							pNew->read= pNew->pInd->len <= ((long)pNew->file_len)
											? pNew->pInd->len : ((long)pNew->file_len);

							if(pNew->read > 0 && (!(pNew->readBuff= (char*)realloc(pNew->readBuff,pNew->read + sizeof(long)))
								|| pNew->read != ::ACE_OS::read(pNew->file, pNew->readBuff, pNew->read)))
								return -333;
							nodes_size -= remainder;
							pUpdate= pNew->readBuff;
							pNew->pInd->len -= pNew->read;
							pNew->file_len -= pNew->read;
							saved_remainder= pNew->read;
							if(!saved_remainder && pNew->pInd->len + pNew->read <= nodes_size){
								break;
							}
							remainder = pNew->read;
							writed= 0;
						}
					}
					if(pNew->pInd->len + pNew->read <= nodes_size){
						if(isLast < 33337)
							return 0;
						pUpdate= pNew->readBuff;
						writed= 0;
						*(long*)pUpdate= 0x7ffffffc;
						break;
					}
					pUpdate += nodes_size;
					remainder -= nodes_size;
				  }while(0);repeat= 0;
				}
				nodes_size= (long)pUpdate - (long)pNew->readBuff - writed;
				if(write_stream(pdstr, pNew->readBuff + writed, nodes_size) != nodes_size)
					return -1;
				writed += nodes_size;
			}
		}while(*(long*)pUpdate);
	  }else{
	    pUpdate= pNew->readBuff;
		*pPos = 1;
		OnlyNew++;
	  }
	if(OnlyNew){
		if(write_stream(pdstr, pUpdate, pNew->read) != pNew->read)
			return -1;
		  while(pNew->pInd->len > 0){
			pNew->read= pNew->pInd->len <= ((long)pNew->file_len)
							? pNew->pInd->len : ((long)pNew->file_len);
			if(!(pNew->readBuff= (char*)realloc(pNew->readBuff,pNew->read + sizeof(long)))
								|| pNew->read != ::ACE_OS::read(pNew->file, pNew->readBuff, pNew->read))
				return -333;
			pNew->pInd->len -= pNew->read;
			pNew->file_len -= pNew->read;
			if(write_stream(pdstr, pNew->readBuff, pNew->read) != pNew->read)
				return -1;
		  }
	}
	return 0;
}

extern "C" Form_Node *FormsInSortedArray(stream_st *psstr, iter_st *spit, int *pRetSize);

void N_WCU::CopyAsFlushN(	void *, void *, void *, void *, long *prPos,
									int (__cdecl *compL)(const void *, const void *),
									int (__cdecl *compN)(const void *, const void *))
{
	pNIndexReRead= this;
	///////////////////////////////////////////////////////////////////
		pdstr[6].flags= pdstr[1].flags= (pdstr[0].flags |= SF_NOALLOC);
		u_int64_t AllSizeTemp= 0, ReadFromTemp= 0;
		int iLastProc= 1, ii, jj= FlashCount;
		set_st m_stNIdDelList;
		m_stNIdDelList.pSkipDoc= m_pNIdDelList;
		m_stNIdDelList.SkipDocCount= m_sNIdDelList;
		LPPL_ZZZ *kk= (LPPL_ZZZ*)alloca(sizeof(PL_ZZZ*)*FlashCount);
		pInds= (LPPL_YYY *)malloc(sizeof(LPPL_YYY)*FlashCount);
		pIndsCount= FlashCount;

		char key_buff[256];
		u_int32_t sDocsAndPossMaxBuff0= 0;
#ifdef DLT_IN_OLD_CONTEXT
		if(spit->pkey)
		{
		  while(*spit->pkey == 0) next_key(spit);
#endif
		  while(spit->pkey){
			pref00 = get_stref_ex( spit->pkey, pin->hdr.keylen, pin->hdr.strinfo.immds, pin->hdr.nstreams, 0);
			if(pref00->size > sDocsAndPossMaxBuff0)
				sDocsAndPossMaxBuff0= pref00->size;
			next_key(spit);
#ifdef DLT_IN_OLD_CONTEXT
			if(0x40 & *spit->pkey)
				spit->pkey= 0;
		  }
#endif
		}
		sDocsAndPossMaxBuff0 += m_sNIdDelList*8;
		if(sDocsAndPossMaxBuff0 > sDocsAndPossMaxBuff){
			sDocsAndPossMaxBuff= (sDocsAndPossMaxBuff0/0x10000 + 1) * 0x10000;
		}
		first_key(spit);
#ifdef DLT_IN_OLD_CONTEXT
		while(spit->pkey && spit->pkey[0] == 0)
			next_key(spit);
#endif
		for(ii= 0; ii < jj; ii++){
			{
				long krc;
				if(	::ACE_OS::lseek(indxs[ii].file, indxs[ii].file_len + 4, ACE_OS_SEEK_SET)
						&&
					::ACE_OS::read(indxs[ii].file, &lastDocFromTemp, sizeof(long)) == sizeof(long)
						&&
					::ACE_OS::read(indxs[ii].file, &krc, sizeof(long)) == sizeof(long)
						&&
					(indxs[ii].pInd= (LPPL_YYY)malloc(sizeof(PL_YYY)*krc)) != 0
						&&
					::ACE_OS::read(indxs[ii].file, indxs[ii].pInd, sizeof(*indxs[ii].pInd)*krc)
							== (long)sizeof(*indxs[ii].pInd)*krc
						&&
					::ACE_OS::lseek(indxs[ii].file, sizeof(long), ACE_OS_SEEK_SET) == sizeof(long)
					){
						indxs[ii].FileName= (char*)ii;
				}
			}
			kk[ii]= indxs+ii;
			pInds[ii]= kk[ii]->pInd;
		}
		for(ii= 0; ii < jj; ii++){
			kk[ii]->read= kk[ii]->pInd->len <= kk[ii]->max_size_saved_Node ? kk[ii]->pInd->len : kk[ii]->max_size_saved_Node;
			if(!(kk[ii]->readBuff= (char*)malloc(kk[ii]->read + sizeof(long)))
				|| kk[ii]->read != ::ACE_OS::read(kk[ii]->file, kk[ii]->readBuff, kk[ii]->read))
				exit(-333);
			kk[ii]->file_len -= kk[ii]->read;
			kk[ii]->pInd->len -= kk[ii]->read;
			AllSizeTemp += kk[ii]->file_len;
		}
		create_stream(pin, pdstr);
		create_stream(pin, pdstr+1);
		create_stream(pin, pdstr+6);
		ii= ::strlen(file->FileName)-3;
		memcpy(name_temp_flush_handle, file->FileName, ii);
		memcpy(name_temp_flush_handle+ii, "flush.tmp", 10);
		while(FlashCount || (spit->pkey
#ifdef DLT_IN_OLD_CONTEXT
							&& !(0x40 & *spit->pkey)
#endif
											)){
		 int pre_ii, repeat, retComp;
		 pref00 = get_stref_ex( key_buff, pin->hdr.keylen, pin->hdr.strinfo.immds, pin->hdr.nstreams, 2);
		 if(FlashCount){
			qsort( kk, FlashCount, sizeof(LPPL_ZZZ), compL);
			for(ii= 1, jj= 0; ii <  FlashCount && !compL(kk+ii, kk+ii-1); ii++);
			qsort( kk, ii, sizeof(LPPL_ZZZ), compZZZ1);pre_ii= ii;
		 }
		 do{
			CSReader tmpBig(this, 0);
			PL_YYY dmI;
			PL_ZZZ dm1;
			long dm2[3];
			char tmp32[32];
			*tmp32= 0;

		    repeat= 0;
			pp_ctxTextCacheArray[0]->SetItemInNode(key_buff, (*kk)->pInd->k);
			retComp= 1;
			if(spit->pkey
#ifdef DLT_IN_OLD_CONTEXT
					&& !(0x40 & *spit->pkey)
#endif
									){
			 stref_st *pref_1;
			 tmpA.clear();
			 add_tmpA= 0;
			 while(load_Stream2_ex(spit->str, (pref_1= get_stref(spit, 1)), psstr, &(spit->strinfo))
					&& ((( ((FlashCount && (retComp= compN(spit->pkey, kk[0]->pInd->k)) < 1) || (!FlashCount && (retComp= -1)))
						&& (p_tmpDelDocs= m_stNIdDelList.pSkipDoc)
						&& retComp < 0
						&& (pref_1[-1].size+pref_1[-1].size/2 + 2*pref_1[1].size) < sDocsAndPossMaxBuff))))
			  {
				if(load_Stream_NWCntxt(get_stref(spit, 0), spit, psstr) == (void*)-2)
					exit(-22,spit->pkey);

				pdstr->ArrayIOffsCount= psstr->ArrayIOffsCount= 0;
				if(pin->trunc_NContxt_str(	&m_stNIdDelList, pin, spit, psstr, pdstr))
					exit(231,spit->pkey);

				next_key(spit);
				if(
#ifdef DLT_IN_OLD_CONTEXT
					0x40 & *spit->pkey
#else
					!(spit->pkey)
#endif
								)
				{
					pdstr->ArrayIOffsCount= psstr->ArrayIOffsCount= 0;
					(psstr-1)->ref.size= 0;retComp= 1;
					break;
				}
			 }
			 if(retComp < 0){
				 pp_ctxTextCacheArray[0]->SetItemInNode(tmp32,pAllPre[300].curr_item);
				 dm2[0]= 0;dm2[1]= 0x80000000;dm2[2]= 300;
				 dmI.len= 0; dm1.pInd= &dmI; dm1.read= sizeof(dm2);
				 dm1.readBuff= (char*)(&dm2);dm1.file_len= 0;
				 dm1.file= kk[0]->file;

				 pp_ctxTextCacheArray[0]->SetItemInNode(key_buff, spit->pkey);
				 if((pdstr+1)->ref.size == 32)
					pp_ctxTextCacheArray[0]->SetItemInNode(pAllPre[300].curr_item, (psstr-1)->data);
				 psstr->ArrayIOffsCount= 0;
				 MergeStreams(tmpBig,pin, &dm1, 33337
								,pdstr, psstr, spit, prPos, m_pNIdList, &m_stNIdDelList, 0);
				 if(!(pdstr+1)->temp_flush_handle){
					 if(pdstr->ref.size > 12){
						pp_ctxTextCacheArray[0]->SetItemInNode(	pAllPre[300].curr_item
																, pdstr[1].ppBlock[0]+psstr->ArrayIOffs[0].i*32);
					 }else
						pp_ctxTextCacheArray[0]->SetItemInNode(pAllPre[300].curr_item,pdstr[1].ppBlock[0]);
				 }
				 repeat= 1;
				 ii= 0;
			 }
			}
			if(FlashCount || (spit->pkey
#ifdef DLT_IN_OLD_CONTEXT
							&& !(0x40 & *spit->pkey)
#endif
											)){
				for(;jj < ii;jj++){
				  if(jj+1 < ii){
					MergeStreams(tmpBig, pin, kk[jj], jj
									,pdstr, psstr, spit, prPos, m_pNIdList, &m_stNIdDelList, retComp);
				  }else
					MergeStreams(tmpBig,pin, kk[jj], 33337
									,pdstr, psstr, spit, prPos, m_pNIdList, &m_stNIdDelList, retComp);
				  if(kk[jj]->file_len < 1){
					::ACE_OS::close(kk[jj]->file);
					char tmpBaseName[256], *fnd= strrchr(file->FileName, '.');
					*fnd= 0;
					sprintf(tmpBaseName, pTempFileFormat, file->FileName, kk[jj]->FileName);
					*fnd= '.';
					ace_os_unlink(tmpBaseName);
					kk[jj]->FileName= (char*)-1;
					memcpy(kk+jj, kk+jj+1, (FlashCount-jj-1)*sizeof(LPPL_ZZZ));
					jj--;
					ii--;
					FlashCount--;
				  }else{
					free(kk[jj]->readBuff);
					kk[jj]->readBuff= 0;
				  }
				}
				release_stream(psstr);
				*prPos= 0;
				if(tmpBig.pBigStream){
					memcpy(	psstr->str->pgfile.PrmExt.pFilePoss, streams->file->m_postFilePoss,
								MAX_COUNT_FILE_HANDLES*sizeof(u_int32_t));
				}
				if((pdstr+1)->temp_flush_handle){
					ReRead_Stream(this, pdstr, pref00, &tmpA, name_temp_flush_handle);
				}else{
					if(repeat && pdstr->ref.size <= 12){
						close_stream(pdstr+1);
						close_stream(pdstr);
						next_key(spit);
						continue;
					}
					ReRead_Stream(this, pdstr, pref00, &tmpA);
				}
				pdstr->flags &= ~SF_NOALLOC;
				close_stream(pdstr);
				close_stream(pdstr+1);
				if(*tmp32){
					pp_ctxTextCacheArray[0]->SetItemInNode(pAllPre[300].curr_item, tmp32);
					*tmp32= 0;
				}
				for(jj= 0; jj < ii; jj++){
					kk[jj]->pInd++;
	kk[jj]->read= kk[jj]->pInd->len <= kk[jj]->max_size_saved_Node ? kk[jj]->pInd->len : kk[jj]->max_size_saved_Node;
					if(!(kk[jj]->readBuff= (char*)realloc(kk[jj]->readBuff,kk[jj]->read + sizeof(long)))
						|| kk[jj]->read != ::ACE_OS::read(kk[jj]->file, kk[jj]->readBuff, kk[jj]->read))
						exit(-333,kk[jj]->FileName);
					kk[jj]->pInd->len -= kk[jj]->read;
					kk[jj]->file_len -= kk[jj]->read;
					if(spit){
						ReadFromTemp += kk[jj]->read;
						if(iLastProc != (int)((ReadFromTemp*100)/AllSizeTemp)){
							iLastProc= (int)((ReadFromTemp*100)/AllSizeTemp);
							OS_LocalSetProgress(iLastProc/2+50);
							if (log) {
								log->printf (lt_info, "Merge streams for %s\n", key_buff+1 );
								log->flush (lt_info);
							}
						}
					}
				}
				pdstr->flags |= SF_NOALLOC;pdstr->bcount= 0;
				create_stream(pin, pdstr);

				if(repeat){
					Form_Node *pPut;
					char *pFormC= pdstr[1].data;
					unsigned char max_cc= 0;
					while(psstr->ArrayIOffsCount--){
						if(psstr->ArrayIOffs[psstr->ArrayIOffsCount].i > max_cc)
							max_cc= psstr->ArrayIOffs[psstr->ArrayIOffsCount].i;
						pFormC= pdstr[1].ppBlock[0]+psstr->ArrayIOffs[psstr->ArrayIOffsCount].i*32;
						if(*pFormC < 32){
							if(!(pPut= (Form_Node *)bsearch(	pFormC+1, psstr->pAForms , psstr->max_B, sizeof(*pPut), CompStringsZZZX))){
								printf(errorMSG, pFormC+1, spit->pkey+1);
								//__debugbreak();
							}
						}else{
							char tmpKey[32];
							memcpy(tmpKey, pFormC+1, 31);
							tmpKey[31]= 0;
							if(!(pPut= (Form_Node *)bsearch(	tmpKey, psstr->pAForms , psstr->max_B, sizeof(*pPut), CompStringsZZZX))){
								printf(errorMSG, tmpKey, spit->pkey+1);
								//__debugbreak();
							}
						}
						if(pPut) pPut->BasesMask= (u_int64_t)1;
					}
					psstr->ArrayIOffsCount= 0;
					close_stream(pdstr);
					write_stream(pdstr, pdstr[1].ppBlock[0], 32+32*max_cc);
					attach_stream(pdstr, pref00 - 1);
				}else
					SetFormsData(&tmpA, key_buff, pin, pdstr);

				close_stream(pdstr);
				add_key(pin, key_buff);
				if(spit && spit->pkey
#ifdef DLT_IN_OLD_CONTEXT
							&& !(0x40 & *spit->pkey)
#endif
 								&& !compN(key_buff, spit->pkey)){
				  next_key(spit);
				}
			}
		 }while(repeat && (ii= pre_ii));
		}
#ifndef DLT_IN_OLD_CONTEXT
		if(spit[1].str){
			release_iter(spit);
			pdstr->flags &= ~SF_NOALLOC;
			close_stream(pdstr);
			memset(pdstr, 0, sizeof(*pdstr));
		}
#endif
		CloseBlockMap(pin+4, pdstr+7);
		if(NormalFromPointer){
			for(ii= 0; ii < pIndsCount; ii++){
				free(pInds[ii]);
				free(indxs[ii].readBuff);
				indxs[ii].readBuff= 0;

			}
			free(pInds);
			if(indxs)
				free(indxs);
		}
}

extern "C" int __cdecl truncation_NWCntxt_stream(	struct SET_ST_TAG*,struct tag_index*,
													struct tag_iterator*,struct tag_stream*,
													struct tag_stream*);

void N_WCU::CopyAsFlush(DocIterator *pUpDoc)
{
	DeleteChildsIndex();
	if(FlashCount > -1){
		CloseLastTemp();
		///////////////////////////////////////////////////////////////////
		u_intFormOld_tCtxLongSetSplayMap tmpFOld(lsdef);
		streamfile_st *str0;
		pgfile_st *pfIndex1, *pfIndex2;
		streamfile_st *pfIndex1str, *pfIndex2str;
		streamfile_st *str00;
		delete []pAllWordPos; pAllWordPos= 0;
		stref_st *pref;
		while(itw.pkey)
#ifdef DLT_IN_OLD_CONTEXT
		{
			if(!bsearch_nxt(*pikey, &p_DelDocs, &newSZ)){
				load_stream_ex(itw.str, (pref = get_stref(&itw, 0)), psstr, &(itw.strinfo));
				move_stream(psstr, pdstr->str, pref);
				add_key(pin, itw.pkey);
				release_stream(psstr);
			}
			next_word_key(&itw, &pikey);
		}
		int sNodes= 0;
		Form_Node *pPut= 0;
		if(spit->pkey){
			if(!(psstr->pAForms= (Form_Node*)calloc(spit[1].key_count,sizeof(Form_Node))))
				exit(-29);
			pPut= psstr->pAForms;
			int lnl;
			while(spit[1].pkey){
				lnl= 0x3f & *(spit[1].pkey);
				if(lnl < MAX_VAL_STR_AS_KEY)
					memcpy(pPut->val, spit[1].pkey+1, lnl+1);
				else{
					memcpy(pPut->val, spit[1].pkey+1, MAX_VAL_STR_AS_KEY);
					pPut->val[MAX_VAL_STR_AS_KEY]= 0;
				}
/*if(*(int*)(pPut->val) == -791422497)
*pPut->val= *pPut->val;*/
				next_key(spit+1);
				pPut++;
			}
			release_iter(spit+1);
			sNodes= (pPut-psstr->pAForms);
			if(!(psstr->pAForms= (Form_Node*)realloc(psstr->pAForms, sNodes*sizeof(Form_Node))))
				exit(-29);
			pPut= psstr->pAForms;

/*u_int32_t keySr= sNodes, keyS= keySr;
while(keySr--){
	if(!bsearch(psstr->pAForms+keySr, psstr->pAForms, keyS, sizeof(Form_Node), CompStringsZZZX)){
		printf(errorMSG, psstr->pAForms+keySr, "Test0");
		printf("\n Take DEBUG");
		getch();
	}
}*/
		}else{
			pPut= psstr->pAForms= (Form_Node*)calloc(100,sizeof(Form_Node));
			spit[1]= *spit;
			spit[1].pkey= (char*)pPut;
		}
		psstr->max_B= sNodes;
		psstr->pNorml_Node= (Norml_Node*)-1;

		int ii, jj;
		long rPos= 0;
		char *pBuffs;
		pin->trunc_NContxt_str= truncation_NWCntxt_stream;
		CopyAsFlushN(spit, pdstr, psstr, pin, &rPos, compZZZ, CompStringsZZZ);
 		ace_os_unlink(name_temp_flush_handle);

		if(rootNodeKey){
			close_indexEx(pin, p_UpdThdr);
		}else{
	(pdstr+1)->flags &= ~SF_NOALLOC;
	close_stream(pdstr+1);
	pgfile_st *pf0= pin->pf;
	pfIndex1= pf0;
	pfIndex1str= pin->str;
	str0= pin->str;
 #ifdef NOT_NEW_FILES_FOR_NFCONTEXT
	create_index_hack(pf0, FormsIName, pin);
	pin->str= str0;
	pin->pbase= ptarget;
 #else
	pfIndex2= pin->pf;
	pfIndex2str= pin->str;
 #endif
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
		if((*pkey & 0x3f) > MAX_VAL_STR_AS_KEY){
			pp_ctxTextCacheArray[0]->SetItemInNode( key_buff, pkey);
			memmove(key_buff,key_buff+1,MAX_VAL_STR_AS_KEY);
			key_buff[MAX_VAL_STR_AS_KEY]= 0;
			tmpFOld[(void*)key_buff];
		}else{
			tmpFOld[(void*)(pkey+1)];
		}
		tmpFOld.root->cont= *sp;
		tmpFOld.root->cont.lastElemV= (long)i;
	}
	u_int256_tCtxLongSetSplayMap tmpD(lsdef);
	tmpD.clear();
	if(!pPut){
		if(psstr->pDeletedNorms){
			for(jj= 0; jj < psstr->iDeletedNorms; jj++)
				tmpD[(void*)(psstr->pDeletedNorms+jj*32)];
			free(psstr->pDeletedNorms);
			psstr->pDeletedNorms= 0;
		}
	}
	close_stream(psstr);
	int old_ff= 0;
   #ifdef POST_DEACTUAL_ALL_FORMS
	if(spit->pkey == 0
						&& (old_ff+=1) && (++spit) && (++prin) && (++psstr)
		&& (	!(pkey=spit->pkey)
			||	!create_stream(prin, psstr)
			||	!(prin->str->pgfile.PrmExt.cur_Seek= my_def_io_seek)
			||	!(prin->str->pgfile.PrmExt.cur_Read= my_def_io_read) ))
	{
		exit(-29,prin->pf->name);
	}
  #endif
 #ifndef NOT_NEW_FILES_FOR_NFCONTEXT
	str00= pdstr->str;
 #endif
	ace_os_unlink(pTempFileListName);
/*Form_Node *pPutZ= 0, *pAA;
if(!(pAA= (Form_Node*)calloc(2000000,sizeof(Form_Node))))
	exit(-29);
pPutZ= pAA;*/
	for( i = tmpFOld.first(); i; tmpFOld.next(i) ){
		char *pNxtN;
		int ret= 0;
		sp= &tmpFOld.contents(i);
		if(!sp->capacity)
			abort();
		else
	#ifdef RESTORE_OLD_FORMS_IN_MEM
			if(spit && sp->capacity == -2){
				while(pkey && 0 > (ret= tmpFOld.comp_items(tmpFOld.pkey(i), pkey))){
					pkey=(char*)next_key(spit);
				}
				if(pkey && !ret){
	#else
			{
				pkey= (char*)(tmpFOld.pkey(i));
				while(!old_ff && spit && spit->pkey && strcpy(key_buff,spit->pkey+1) && !(key_buff[MAX_VAL_STR_AS_KEY]=0) &&
						0 > (ret= tmpFOld.comp_items(key_buff, pkey))){
	#endif
//if(*(int*)(spit->pkey+1) == -892806689)
//*pPutZ->val= *pPutZ->val;
					if(pPut){
						if((psstr->pAForms= (Form_Node *)bsearch(	key_buff,
														pPut, sNodes, sizeof(*pPut),
														CompStringsZZZX))
								&& !(psstr->pAForms->BasesMask & (u_int64_t)1)){
							next_key(spit);
							continue;
						}
						load_stream_ex(spit->str, (pref = get_stref(spit, 0)),
																psstr, &(spit->strinfo));
					}else
					{
						load_stream_ex(spit->str, (pref = get_stref(spit, 0)),
																psstr, &(spit->strinfo));
						if(tmpD.seek((void*)(psstr->data))){
							release_stream(psstr);
							next_key(spit);
							continue;
						}
					}
					move_stream(psstr, pdstr->str, pref);
	#ifdef RESTORE_OLD_FORMS_IN_MEM
			}
		}else{
	#else
					add_key(pin, spit->pkey);
/*int lll= 0x3f & *spit->pkey;
if(lll < MAX_VAL_STR_AS_KEY){
	memcpy(pPutZ->val, spit->pkey+1, lll+1);
}else{
	memcpy(pPutZ->val, spit->pkey+1, MAX_VAL_STR_AS_KEY);
	pPutZ->val[MAX_VAL_STR_AS_KEY]= 0;
}
pPutZ++;*/
					release_stream(psstr);
					next_key(spit);
				}
				strcpy( key_buff, pkey);
				if(!old_ff && spit && spit->pkey && !ret) next_key(spit);
	#endif
			pkey= key_buff;
			pref = get_stref_ex(	pkey, pin->hdr.keylen, pin->hdr.strinfo.immds,
									pin->hdr.nstreams, 0);
			write_stream(pdstr, &sp->capacity, sizeof(sp->capacity));
			if(NormalFromPointer)
				GetKeyBuff((long**)&pNxtN, (u_int64_tCtxLongSetSplayNode*)sp->lastElemV);
			for(jj = 1; jj <= sp->lastI; jj++){
				if(!NormalFromPointer)
					pNxtN= (char*)sp->e[jj-1];
				if((short)jj == ((short*)&sp->capacity)[1] >> 8){
					write_stream(pdstr, pNxtN, 32);
					break;
				}
				if(NormalFromPointer)
					SetNextKeyBuff((long**)&pNxtN);
			}
			attach_stream(pdstr, pref);
			close_stream(pdstr);
		}
		int lll= strlen(pkey);
//if(*(int*)pkey == -892806689)
//*pPutZ->val= *pPutZ->val;
		if(lll < MAX_VAL_STR_AS_KEY){
//memcpy(pPutZ->val,pkey,lll+1);
			memmove(pkey+1, pkey, lll+1);
		}else{
//memcpy(pPutZ->val,pkey,lll);
//pPutZ->val[lll]= 0;
			memmove(pkey+1, pkey, (lll= MAX_VAL_STR_AS_KEY));
		}
		*pkey= 0x80|0x40|(char)lll;
		add_key(pin, pkey);
//pPutZ++;
	}
	if(!NormalFromPointer){
		for(ii= 0; ii < pIndsCount; ii++){
			free(pInds[ii]);
		}
		free(pInds);
		if(indxs)
			free(indxs);
	}
	while(!old_ff && spit && spit->pkey){
		if(pPut){
			if((psstr->pAForms= (Form_Node *)bsearch(	spit->pkey,
											pPut, sNodes, sizeof(*pPut),
											CompStringsZZZX))
					&& !(psstr->pAForms->BasesMask & (u_int64_t)1)){
				next_key(spit);
				continue;
			}
			load_stream_ex(spit->str, (pref = get_stref(spit, 0)),
													psstr, &(spit->strinfo));
		}else
		{
			load_stream_ex(spit->str, (pref = get_stref(spit, 0)),
													psstr, &(spit->strinfo));
			if(tmpD.seek((void*)(psstr->data+sizeof(long)))){
				release_stream(psstr);
				next_key(spit);
				continue;
			}
		}
		if(pdstr->str)
			move_stream(psstr, pdstr->str, pref);
		add_key(pin, spit->pkey);
/*if(*(int*)(spit->pkey+1) == -892806689)
pPutZ->val= *pPutZ->val;

			int lll= 0x3f & *spit->pkey;
if(lll < MAX_VAL_STR_AS_KEY){
	memcpy(pPutZ->val, spit->pkey+1, lll+1);
}else{
	memcpy(pPutZ->val, spit->pkey+1, MAX_VAL_STR_AS_KEY);
	pPutZ->val[MAX_VAL_STR_AS_KEY]= 0;
}
pPutZ++;*/
		release_stream(psstr);
		next_key(spit);
	}
/*u_int32_t keyS= pPutZ- pAA;
u_int32_t keySr= keyS;
while(keySr--){
	if(!bsearch(pAA+keySr, pAA, keyS, sizeof(Form_Node), CompStringsZZZX)){
		printf(errorMSG, pAA+keySr, "TST");
		__debugbreak();
	}
}
free(pAA);*/
	free(psstr->ppBlock);psstr->ppBlock= 0;
	if(pPut){
		free(pPut);
		pPut= 0;
	}
	FreeFprmsBuffs();
			close_index(pin);
			free(pin->name);
			pdstr->flags &= ~SF_NOALLOC;
			close_stream(pdstr);
		}
		free(pTempFileListName);
		pTempFileListName= 0;
		FlashCount--;
		free(gs_target_name);
		gs_target_name= ptarget->ndt.name;
		if(!rootNodeKey /*Root != -1*/){
			ptarget->key.mode= ACE_OS_O_RDONLY;
			close_base(ptarget);
			pBuffs= strrchr(gs_target_name, '.');
			strcpy(pBuffs+1, "key");ace_os_unlink(gs_target_name);
			strcpy(pBuffs+1, "str");ace_os_unlink(gs_target_name);
			strcpy(pBuffs+1, "ndt");
		}else
			close_base(ptarget);
		::free(((pgfile_st *)&ptarget->key)->PrmExt.pCrptTag);
		::free(((pgfile_st *)&ptarget->str)->PrmExt.pCrptTag);
		free(ptarget);
		{
			Index *iiU= base->FindIndex(g_OldCntxN);
			PagedFile  *tt1= file;
			StreamFile *tt2= streams;
			file= iiU->file;
			streams= iiU->streams;
			pResultFileKeyName= iiU->file->FileName;
			free(streams->file->SystemPageBuf);
			free(file->SystemPageBuf);
			RestoreNamesFiles(gs_target_name, str0, file, streams);
			file= tt1;
			streams= tt2;
			*(long*)(streams->file->SystemPageBuf)= 0;
			*(long*)(file->SystemPageBuf)= 0;
			if(Forms){
				*(long*)(Forms->streams->file->SystemPageBuf)= 0;
				*(long*)(Forms->file->SystemPageBuf)= 0;
			}
		}
#ifndef NOT_NEW_FILES_FOR_NFCONTEXT
		if(m_pNIdList != (long*)-1){
			pResultFileKeyName= file->FileName;
		}else{
			Forms= base->FindIndex(FormsIName);
			pResultFileKeyName= strdup(pResultFileKeyName);
			strcpy(strrchr(pResultFileKeyName, '.')+1, strrchr(Forms->file->FileName, '.')+1);
			RestoreNamesFiles(gs_target_name, str00, Forms->file, Forms->streams);
			free(pResultFileKeyName);
		}
#endif
		spit--;
		::free(spit);
		::free(thisBase.pSubToms);
		::free(thisBase.key.name);
		::free(thisBase.str.cache);
		::free(thisBase.str.centries);
		::free(pfIndex1);
		::free(pfIndex1str);
		for(sNodes= 1; sNodes < MAX_COUNT_FILE_HANDLES+1 && streams->file->m_postFileHandles[sNodes] != -1; sNodes++){
			streams->file->m_postFileHandles[sNodes]= -1;
		}
		streams->file->SetFileHandle(first_read6tr);
#else
		{
			if(!bsearch_nxt(*(long*)itw.pkey, &p_DelDocs, &newSZ)){
				load_stream_ex(itw.str, (pref = get_stref(&itw, 0)), psstr, &(itw.strinfo));
				move_stream(psstr, pdstr->str, pref);
				add_key(&outw, itw.pkey);
				release_stream(psstr);
			}
			next_key(&itw);
		}
		close_index(&outw);free(outw.name);outw.name= 0;free(inw.name);inw.name= 0;
		int sNodes= 0;
		Form_Node *pPut= FormsInSortedArray(psstr, spit+1, &sNodes);
		psstr->pNorml_Node= (Norml_Node*)-1;
		psstr->max_B= sNodes;
		
		int ii, jj;
		long rPos= 0;
		char *pBuffs;
		pin->trunc_NContxt_str= truncation_NWCntxt_stream;
		CopyAsFlushN(spit, pdstr, psstr, pin, &rPos, compZZZ, CompStringsZZZ);
 		ace_os_unlink(name_temp_flush_handle);stream_st *pdstro= 0;
		index_st *pino= 0;
		if(rootNodeKey){
			close_indexEx(pin, p_UpdThdr);
		}else{
	(pdstr+1)->flags &= ~SF_NOALLOC;
	close_stream(pdstr+1);
	pgfile_st *pf0= pin->pf;
	pfIndex1= pf0;
	pfIndex1str= pin->str;
	str0= pin->str;
	strcpy(pin->name,Name);
	close_index(pin);free(pin->name);
	memset(pin, 0, sizeof(index_st));
 #ifdef NOT_NEW_FILES_FOR_NFCONTEXT
	create_index_hack(pf0, FormsIName, pin);
	pin->str= str0;
	pin->pbase= ptarget;
 #else
	index_st *pinn= (index_st *)calloc(1, sizeof(index_st));
	stream_st *pdstrn= (stream_st *)calloc(1, sizeof(stream_st));
	pino= pin;
	pdstro= pdstr;
	pdstr= pdstrn;
	pin= pinn;
	pBuffs= ptarget->key.name;
	if(!m_pNIdList){
		ptarget->key.name= file->FileName;
		create_index(ptarget, FormsIName, pin);
		ptarget->key.name= pBuffs;
	}else
		create_index(ptarget, FormsIName, pin);
	((pgfile_st*)(pin->str))->PrmExt.cur_Seek= pin->pf->PrmExt.cur_Seek= my_def_io_seek;
	create_stream(pin, pdstr);
	pfIndex2= pin->pf;
	pfIndex2str= pin->str;
	pdstr->flags |= SF_NOALLOC;
 #endif
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
		tmpFOld.root->cont.lastElemV= (long)i;
	}
	u_int256_tCtxLongSetSplayMap tmpD(lsdef);
	tmpD.clear();
	if(!pPut){
		if(psstr->pDeletedNorms){
			for(jj= 0; jj < psstr->iDeletedNorms; jj++)
				tmpD[(void*)(psstr->pDeletedNorms+jj*32)];
			free(psstr->pDeletedNorms);
			psstr->pDeletedNorms= 0;
		}
	}
	close_stream(psstr);
	if(m_pNIdList &&(++spit)&&(++prin)&&init_iter(prin, spit)&&(++psstr)
		&& (	!(pkey=(char*)first_key(spit))
			||	!create_stream(prin, psstr)
			||	!(prin->str->pgfile.PrmExt.cur_Seek= my_def_io_seek)
			||	!(prin->str->pgfile.PrmExt.cur_Read= my_def_io_read) ))
	{
		exit(-29,prin->pf->name);
	}
 #ifndef NOT_NEW_FILES_FOR_NFCONTEXT
	str00= pdstr->str;
 #endif
	for( i = tmpFOld.first(); i; tmpFOld.next(i) ){
		tmpFOld.SetItemInNode( key_buff, tmpFOld.pkey(i));
		char *pNxtN;
		int ret;
		sp= &tmpFOld.contents(i);
		if(!sp->capacity)
			abort();
		else
	#ifdef RESTORE_OLD_FORMS_IN_MEM
			if(spit && sp->capacity == -2){
				while(pkey && 0 > (ret= tmpFOld.comp_items(tmpFOld.pkey(i), pkey))){
					pkey=(char*)next_key(spit);
				}
				if(pkey && !ret){
	#else
			{
				while(spit && spit->pkey &&
						0 > (ret= tmpFOld.comp_items(spit->pkey, tmpFOld.pkey(i)))){
	#endif
					if(pPut){
						if((psstr->pAForms= (Form_Node *)bsearch(	spit->pkey,
														pPut, sNodes, sizeof(*pPut),
														CompStringsZZZX))
								&& !(psstr->pAForms->BasesMask & (u_int64_t)1)){
							next_key(spit);
							continue;
						}
						load_stream_ex(spit->str, (pref = get_stref(spit, 0)),
																psstr, &(spit->strinfo));
					}else
					{
						load_stream_ex(spit->str, (pref = get_stref(spit, 0)),
																psstr, &(spit->strinfo));
						if(tmpD.seek((void*)(psstr->data))){
							release_stream(psstr);
							next_key(spit);
							continue;
						}
					}
					move_stream(psstr, pdstr->str, pref);
	#ifdef RESTORE_OLD_FORMS_IN_MEM
			}
		}else{
	#else
					add_key(pin, spit->pkey);
					release_stream(psstr);
					next_key(spit);
				}
				if(spit && spit->pkey && !ret) next_key(spit);
	#endif
			pkey= key_buff;
			pref = get_stref_ex(	pkey, pin->hdr.keylen, pin->hdr.strinfo.immds,
									pin->hdr.nstreams, 0);
			write_stream(pdstr, &sp->capacity, sizeof(sp->capacity));
			if(NormalFromPointer)
				GetKeyBuff((long**)&pNxtN, (u_int64_tCtxLongSetSplayNode*)sp->lastElemV);
			for(jj = 1; jj <= sp->lastI; jj++){
				if(!NormalFromPointer)
					pNxtN= (char*)sp->e[jj-1];
				if((short)jj == ((short*)&sp->capacity)[1] >> 8){
					write_stream(pdstr, pNxtN, 32);
					break;
				}
				if(NormalFromPointer)
					SetNextKeyBuff((long**)&pNxtN);
			}
			attach_stream(pdstr, pref);
			close_stream(pdstr);
		}
		add_key(pin, pkey);
	}
	if(!NormalFromPointer){
		for(ii= 0; ii < pIndsCount; ii++){
			free(pInds[ii]);
		}
		free(pInds);
		if(indxs)
			free(indxs);
	}
	while(spit && spit->pkey){
		if(pPut){
			if((psstr->pAForms= (Form_Node *)bsearch(	spit->pkey,
											pPut, sNodes, sizeof(*pPut),
											CompStringsZZZX))
					&& !(psstr->pAForms->BasesMask & (u_int64_t)1)){
				next_key(spit);
				continue;
			}
			load_stream_ex(spit->str, (pref = get_stref(spit, 0)),
													psstr, &(spit->strinfo));
		}else
		{
			load_stream_ex(spit->str, (pref = get_stref(spit, 0)),
													psstr, &(spit->strinfo));
			if(tmpD.seek((void*)(psstr->data+sizeof(long)))){
				release_stream(psstr);
				next_key(spit);
				continue;
			}
		}
		if(pdstr->str)
			move_stream(psstr, pdstr->str, pref);
		add_key(pin, spit->pkey);
		release_stream(psstr);
		next_key(spit);
	}
	if(pPut){
		free(pPut);
		pPut= 0;
	}
	FreeFprmsBuffs();
			close_index(pin);
			pdstr->flags &= ~SF_NOALLOC;
			close_stream(pdstr);
#ifndef NOT_NEW_FILES_FOR_NFCONTEXT
			free(pdstr);
			free(pin->name);free(pin);
			pdstr= pdstro;
			pin= pino;
#endif
		}
		if(m_pNIdList){
#ifndef NOT_NEW_FILES_FOR_NFCONTEXT
			release_iter(spit);
			ptarget->pNextSubToms->pKey= prin->pf;
			prin->str->fat_size= 0;
			ptarget->pNextSubToms->pStr= prin->str;
			ptarget->pNextSubToms->pName= (thisBase.pNextSubToms-1)->pName;
			ptarget->pNextSubToms++;
#endif
			ace_os_unlink(pTempFileListName);
			free(pTempFileListName);
			pTempFileListName= 0;
		}
		ptarget->key.name= pBuffs;
		FlashCount--;
		free(gs_target_name);
		gs_target_name= ptarget->ndt.name;
		if(!rootNodeKey /*Root != -1*/){
			ptarget->key.mode= ACE_OS_O_RDONLY;
			close_base(ptarget);
			pBuffs= strrchr(gs_target_name, '.');
			strcpy(pBuffs+1, "key");ace_os_unlink(gs_target_name);
			strcpy(pBuffs+1, "str");ace_os_unlink(gs_target_name);
			if(!m_pNIdList){
				if((ii= c_io_open(file->FileName, ACE_OS_O_RDONLY)) == -1){
					exit(-18,file->FileName);
				}
				if((jj= c_io_open(streams->file->FileName, ACE_OS_O_RDONLY)) == -1){
					exit(-18,streams->file->FileName);
				}
				file->SetFileHandle(ii); *file->m_postFileHandles= ii;
				streams->file->SetFileHandle(jj);*streams->file->m_postFileHandles= jj;
			}
			strcpy(pBuffs+1, "ndt");
		}else
			close_base(ptarget);
		::free(((pgfile_st *)&ptarget->key)->PrmExt.pCrptTag);
		::free(((pgfile_st *)&ptarget->str)->PrmExt.pCrptTag);
		free(ptarget);
		::free((psstr-1)->ppBlock);
		::free(psstr->ppBlock);
		if((psstr-2)->pDeletedNorms)
			free((psstr-2)->pDeletedNorms);
		(psstr-2)->pDeletedNorms= 0;
		free(pdstr);
		free((prin-1)->name); (prin-1)->name= 0;
		free(prin->name); prin->name= 0;
		free(prin->pf);
		free(prin->str);
		free(pin);
		free(streams->file->SystemPageBuf);
		free(file->SystemPageBuf);
		RestoreNamesFiles(gs_target_name, str0, file, streams);
#ifndef NOT_NEW_FILES_FOR_NFCONTEXT
		if(m_pNIdList != (long*)-1){
			pResultFileKeyName= Forms->file->FileName;
			RestoreNamesFiles(gs_target_name, str00, Forms->file, Forms->streams);
		}else{
			Forms= base->FindIndex(FormsIName);
			pResultFileKeyName= strdup(pResultFileKeyName);
			strcpy(strrchr(pResultFileKeyName, '.')+1, strrchr(Forms->file->FileName, '.')+1);
			RestoreNamesFiles(gs_target_name, str00, Forms->file, Forms->streams);
			free(pResultFileKeyName);
		}
#endif
		spit--;
		::free(spit);
		::free(thisBase.pSubToms);
		::free(thisBase.key.name);
		::free(thisBase.str.cache);
		::free(thisBase.str.centries);
		::free(pfIndex1);
		::free(pfIndex2);
		::free(pfIndex1str);
		::free(pfIndex2str);
#endif
		ace_os_unlink(gs_target_name);
		free(gs_target_name);
	}
}

void N_WCU::RestoreNamesFiles(char *gs_target_name, void *strR, PagedFile *file__, StreamFile * streams__)
{
			char	*gs_old_name= strdup(pResultFileKeyName),
					*fnd0= strrchr(gs_old_name, '.'),
					*fnd= strrchr(gs_target_name, '.');
			streamfile_st *str0= (streamfile_st *)strR;
			int jj, ii, PackFlag= 0;
			if(file__->IsPacked())
				PackFlag++;
			for(jj=0; jj < MAX_COUNT_FILE_HANDLES+1; jj++){
				if(file__->m_postFileHandles[jj] != -1){
					if(c_io_close(file__->m_postFileHandles[jj]))
						abort();
				}

			}
			ace_os_unlink(gs_old_name);
			strcpy(fnd+1, strrchr(gs_old_name, '.')+1);
			ace_os_rename(gs_target_name, gs_old_name);
			*file__->m_postFileHandles= c_io_open(gs_old_name, ACE_OS_O_RDONLY|ACE_OS_O_BINARY);
			file__->SetFileHandle(*file__->m_postFileHandles);

			for(jj=0; jj < MAX_COUNT_FILE_HANDLES+1; jj++){
				if(streams__->file->m_postFileHandles[jj] != -1){
					if(c_io_close(streams__->file->m_postFileHandles[jj]))
						abort();
				}
				if(jj > 0){
  ////////////////////
  if(streams__->file->m_postFileHandles[jj] == -1 && str0->pgfile.postFileHandles[jj] == -1)
	  break;
  char *pFileName= 0;
  if((ii=strlen(streams__->file->m_readed.FileName)+1) < 2 ||
		(pFileName= (char*)malloc(ii+1)) == 0 ||
			GetBasedExtFileName((char*)memcpy(pFileName,streams__->file->m_readed.FileName,ii+1) , jj) == 0){
	abort();
  }
  strcpy(fnd0+1, strrchr(pFileName, '.')+1);
  strcpy(fnd+1, strrchr(gs_old_name, '.')+1);
  if(pFileName)
	free(pFileName);
  if(streams__->file->m_postFileHandles[jj] != -1)
	ace_os_unlink(gs_old_name);
  if(str0->pgfile.postFileHandles[jj] != -1)
	  ace_os_rename(gs_target_name, gs_old_name);
  ////////////////////
				}
			}
			strcpy(fnd0+1, strrchr(streams__->file->FileName, '.')+1);
			strcpy(fnd+1, strrchr(gs_old_name, '.')+1);
			ace_os_unlink(gs_old_name);
			ace_os_rename(gs_target_name, gs_old_name);
			*streams__->file->m_postFileHandles= c_io_open(gs_old_name, ACE_OS_O_RDONLY|ACE_OS_O_BINARY);
			streams__->file->SetFileHandle(*streams__->file->m_postFileHandles);
			free(gs_old_name);
			strcpy(fnd+1, "ndt");
			memset(file__->m_postFileHandles+1, -1, sizeof(int)*MAX_COUNT_FILE_HANDLES);
			memset(streams__->file->m_postFileHandles+1, -1, sizeof(int)*MAX_COUNT_FILE_HANDLES);
			file__->SystemPageBuf= strdup(gs_target_name);
			streams__->file->SystemPageBuf= strdup(gs_target_name);
}
extern int open_pgfile_from_PagedFile(PagedFile *pClass, pgfile_st *pFile);

void open_pgfiles_from_Base(base_st& thisBase, PagedFile *file, StreamFile * streams)
{
	if(!open_pgfile_from_PagedFile(file, &thisBase.key)
			||
			!open_pgfile_from_PagedFile(streams->file, &thisBase.str.pgfile))
		exit(-4);
	{
		thisBase.str.fat_size= streams->fatPages;
		thisBase.str.fat = (fat_rec_type *)streams->Fat;
	}
}
///////////////////////////////////////////////////////
//			End of file "update.cpp"			     //
///////////////////////////////////////////////////////
