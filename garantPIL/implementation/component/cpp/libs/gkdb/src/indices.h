
#ifndef	__GARANT_INDICES__
#define __GARANT_INDICES__

#include <set>

#include "btiter.h"
#include "hindex.h"

#include "garantPIL/implementation/component/cpp/libs/cchlp/src/Logger.h"

extern "C" {
extern int attrcmp(const void *a1, const void *a2);
extern int attrcmp_new(const void *a1, const void *a2);
}

class AttrIndex : public Index {
public:
	AttrIndex (PagedFile* f, const char* n, StreamFile* s) : Index (f,n,s) {}

	virtual int	Put (long DocId, int tag, const void* data, int size);
	int Get (long DocId, int tag, void* data, int size);

	void gk_huge* Load (Stream* str, long& size);
	void gk_huge* Load (long DocId, int tag, long& size);
	void gk_huge* LoadEx (long DocId, int tag, long& size, Stream** ppRet);

	int Load (Stream* str, DBCore::Storable& storable);
	int Load (long DocId, int tag, DBCore::Storable& storable);
	int	Del  (long DocId, int tag);
	virtual int	Replace (long DocId, int tag, void* buf, int size);
	int Replace (long DocId, int tag, DBCore::Storable& storable);

	virtual int	Compare (BTKEY, BTKEY) const;
protected:
	void GetStream (AttrKey& key, Stream** ppRet, int iCreate = 0);
};

class BlobIndex : public Index {
public:
	BlobIndex (PagedFile* f, const char* n, StreamFile* s) : Index (f, n, s) {}
	virtual	int	Compare (BTKEY, BTKEY) const;
};

class IntIndex : public Index {
public:
	IntIndex (PagedFile* f, const char* n, StreamFile* s) : Index (f, n, s) {}
	virtual	int	Compare (BTKEY, BTKEY) const;
};

class LongIndex : public Index {
public:
	LongIndex (PagedFile* f, const char* n, StreamFile* s) : Index (f, n, s) {}
	virtual	int	Compare (BTKEY, BTKEY) const;
};

class DateIndex : public Index {
public:
	DateIndex (PagedFile* f, const char* n, StreamFile* s) : Index (f, n, s) {}
	virtual	int	Compare (BTKEY, BTKEY) const;
};

typedef DateIndex DateRefIndex; // это не нужно..

class ContextIndex : public Index {
public:
	ContextIndex (PagedFile* f, const char* n, StreamFile* s) : Index (f, n, s) {}
	virtual	int	Compare (BTKEY, BTKEY) const;
};

class ContextStrIndex : public Index {
public:
	ContextStrIndex (PagedFile* f, const char* n, StreamFile* s) : Index (f, n, s) {}
	virtual	int	Compare (BTKEY, BTKEY) const;
};

class FContxtIndex : public Index {
public:
	FContxtIndex (PagedFile* f, const char* n, StreamFile* s) : Index (f, n, s) {}
	int Compare (BTKEY, BTKEY) const;
};

class RefIndex : public Index {
public:
	RefIndex (PagedFile* f, const char* n, StreamFile* s) : Index (f, n, s) {}
	virtual	int	Compare (BTKEY, BTKEY) const;
};

class RealRefIndex : public Index {
public:
	RealRefIndex (PagedFile* f, const char* n, StreamFile* s) : Index (f, n, s) {}
	virtual	int	Compare (BTKEY, BTKEY) const;
};

class KeyWordIndex : public HIndex {
public:
	KeyWordIndex (PagedFile* f, const char* n, StreamFile* s) : HIndex (f, n, s) {}
	virtual	int	CompareKeys (const char*, const char*) const;
};

#include "garantPIL/implementation/component/cpp/libs/gctx/src/u_int64_t.CtxLongSet.SplayMap.h"

class u_int256_tCtxLongSetSplayMap : public u_int64_tCtxLongSetSplayMap {
public:
	u_int256_tCtxLongSetSplayMap(CtxLongSet& dflt, u_int64_tCtxLongSetSplayNode **pp_ForNew= 0)
		: u_int64_tCtxLongSetSplayMap(dflt, pp_ForNew) {}
	int comp_items(void *pFirst, void*pSecond);
	void SetItemInNode(void *pOldItem, void *pNewItem);
};

class u_intPointerN_tCtxLongSetSplayMap : public u_int64_tCtxLongSetSplayMap {
public:
	u_intPointerN_tCtxLongSetSplayMap(CtxLongSet& dflt, u_int64_tCtxLongSetSplayNode **pp_ForNew= 0)
		: u_int64_tCtxLongSetSplayMap(dflt, pp_ForNew) {}
	int comp_items(void *pFirst, void*pSecond);
	void SetItemInNode(void *pOldItem, void *pNewItem);
};

	#define STD_REALLOC
	#define KEYS_IN_MAP

	#pragma pack(1) 

#ifdef MULTI_INDEX_STREAM_FILE
	#define BUFF_SIZE_FROM_TEMP 0x8000
	typedef struct PL_YYY_TAG
	{
		char	*k;
		long len;
	} PL_YYY, *LPPL_YYY;

	typedef struct PL_ZZZ_TAG
	{
		LPPL_YYY pInd;
		char *readBuff, *FileName;
		int read, file_len;
		ACE_HANDLE file;
		int max_size_saved_Node, next_in_buf, in_mem;
	} PL_ZZZ, *LPPL_ZZZ;
	extern int compZZZ( const void *arg1, const void *arg2 );
	extern int compZZZ1( const void *arg1, const void *arg2 );
#endif

	typedef struct PL_RET_NORMLS_TAG
	{
		u_int64_t *e;
		long lastI, wordPos;
	} PL_RET_NORMLS, *LPPL_RET_NORMLS;

	typedef struct PL_POS_NORMLS_TAG
	{
		long Id, Para, Word;
		PL_POS_NORMLS_TAG *pNext;
	} PL_POS_NORMLS, *LPPL_POS_NORMLS;

	typedef struct PL_LINE_NORMLS_TAG
	{
		u_int64_t key;
		PL_POS_NORMLS_TAG *pFirst, *pLast;
	} PL_LINE_NORMLS, *LPPL_LINE_NORMLS;

	#pragma pack() 

#ifdef	WIN64
	#define MAX_NODES_INCACHE 25000000
#else
	#define MAX_NODES_INCACHE 5000000
#endif

	class IGarDoc; 
	class DocIterator;
	class Base;
	class NContxtIndex;

	class NContextKey { // Зачем это?
	public:
		virtual void PutKey(void *pKey, long DocID, long ParaNInDoc, long WordPosInPara)= 0;
	};

	#if defined(__cplusplus) 
	extern "C" { 
	#endif 
	extern int CompStringsZZZ(const void *pFirst, const void*pSecond);
	#if defined(__cplusplus) 
	} 
	#endif 

	//////////////////////////////////////////////////////////////////////////

	typedef short (*LemmatizeProc) (char* str, NContxtIndex* index);

	//////////////////////////////////////////////////////////////////////////

	class NContxtIndex : public Index {
	protected:
		virtual void WordPosControl(long ID, int ParaN, int *pVal, int textpos_add = 0) { *pVal = 0; }

		static int nitems, lastP, countNF;

		/////////////////////////////////////////////////////////////////////
		// Адаптивное Кеширование Нормалей обусловлено "тормознутостью",   //
		// импортируемой нормализацией из XXX.DLL						   //
		// см. массис pp_ctxTextCacheArray								   //
		/////////////////////////////////////////////////////////////////////
		// "Некрасивый" механизм подобного преалоцирования объектов в кеше //
		// обусловлен "тормознутостью" и "дырявстью" методов new и realloc //
		/////////////////////////////////////////////////////////////////////

		u_int64_t *pBufForNormals;

		char *pForm, *pTempFileListName, *pAllWordPos, *hNameFlushAllParaWords;
		char *pTempFileFormat;
		char *pTempFileListFormat;
		LPPL_YYY *pInds;
		int pIndsCount, hFlushAllParaWords;

		virtual void AllocBufForNormals() {
			if (!pBufForNormals) {
				pBufForNormals = (u_int64_t*) malloc (m_NormlsBuffCount * 4 * sizeof (u_int64_t));

				GDS_ASSERT (pBufForNormals);

				pNxtNPut = pBufForNormals;
			}
		}
	public:
		char *merge_doc_index_names; // убрать в gctx.cpp
		int merge_doc_index_count; // убрать в gctx.cpp
		void FreeFprmsBuffs();
		virtual CtxLongSet *GetSpNorm(u_int64_tCtxLongSetSplayMap	*p_ctxTextArray, u_int64_t *pNxt_normales){
			return &((*p_ctxTextArray)[
		#ifdef STORE_FORM_N
										(void*)&pNxt_normales
		#else
										(void*)pNxt_normales
		#endif
																]);
		}
		virtual int IsRealloc(CtxLongSet *sp){
			return !(sp->lastI % (GROW_BY*4
	  #ifndef NOT_OPTIMIZE_REALLOC
				* m_CurrReallocFactor
	  #endif
				));
		}

		NContxtIndex *pindPut;

		u_int64_tCtxLongSetSplayNode *pAllPre;
		u_int64_tCtxLongSetSplayNode *pNxtNew0;
		u_int64_t *pNxtNPut;

		virtual int IsDefNContextFiles() { return 1; } // не имеет смысла
		virtual IGarDoc *addInOtherMap(long Id, DocInfo *local_docInfo, IGarDoc *doc);
	  #ifndef NOT_OPTIMIZE_REALLOC
		int m_CurrReallocFactor;
	  #endif

		virtual void InitMorpho(long Id= 0);
		void *p_UpdThdr;

		u_int64_t m_AllPatchedAndNewDocsTextSize;

	#if !defined(STD_REALLOC)
		long SkipDocForFlush;
	#endif

	#ifndef STD_REALLOC
		long *pBigLongs, *pNxtLongs; // убрать в UpdtMorph.cpp
	#endif

		unsigned cacheI, m_NormlsBuffCount;	// колличество nodes в кеше для предварительного аллоцирования
		unsigned NormsCount;
		u_int64_tCtxLongSetSplayMap	**pp_ctxTextCacheArray;
		static CtxLongSet lsdef;

		unsigned GetNormlsBuffCount() { return m_NormlsBuffCount; } // не имеет смысла, т.к. m_NormlsBuffCount объявлен как public
		void SetNormlsBuffCount(unsigned newVal) { m_NormlsBuffCount= newVal; } // не имеет смысла, т.к. m_NormlsBuffCount объявлен как public
		int ( __stdcall *OS_LocalSetProgress)(int);

		virtual void CopyAsFlush(DocIterator *pUpDocs= 0){}
		virtual void nflushIt(	u_int64_tCtxLongSetSplayMap *ctxmap, NContxtIndex *pIndex );
		virtual NContxtIndex * FindContextIndexForFlash() { abort(); return 0; };
		virtual void PutOffset(CtxLongSet *sp, long id, long j, int wordPos);
		virtual void CompPre(char *pForm, LPPL_RET_NORMLS spRet, int uu);
		virtual void MakeN_Map(u_int64_tCtxLongSetSplayMap **ppNew // убрать в gctx_func.cpp
	#ifdef PRE_ALLOC_NODES
			, u_int64_tCtxLongSetSplayNode **pp_ForNew
	#endif
			);
		virtual void GetKeyBuff(long **ppSet, u_int64_tCtxLongSetSplayNode *);
		virtual void SetNextKeyBuff(long **ppSet) { (*ppSet) += 8; }
		virtual CtxLongSet *FromCache(void *, LPPL_RET_NORMLS);
	#if !defined(STD_REALLOC)
		void* ( __stdcall *OS_GetDocument)(long DocID);
	#endif
		char *buff_Norm;
		int32_t maxItems, itemsDone;
		int FlashCount, allocIndxs;
		long pre_size, alloc_size, countNewKeys, lastDocFromTemp, *m_pNIdList, *m_pNIdDelList, m_sNIdDelList;
		LPPL_ZZZ indxs;
		NContxtIndex ( PagedFile*f, const char*n, StreamFile*s,
						unsigned NormlsBuffCount= MAX_NODES_INCACHE, IndexInfo *pinfo= 0 );

		u_int64_t rootNodeKey; // бессмысленная переменная, ибо всегда равна 0
		virtual void DeleteChildsIndex(); ///!!!!!

		virtual ~NContxtIndex();
		int	Compare ( BTKEY key1, BTKEY key2 ) const
		{
			return CompStringsZZZ( (void*)key1, (void*)key2 );
		}
		virtual void SetCalcNormsFlag(u_int64_t *pReCalcSizeText= 0) {}
		virtual bool IsReparsingAllTexts(DocIterator *it, IGarDoc *doc= 0, u_int64_tCtxLongSetSplayMap	*pMap= 0){ abort(); return false;}
		virtual int QuickFlush( u_int64_tCtxLongSetSplayMap *ctxmapNormls, void *pNewKey, long *pData, long all);
		virtual char *asNorm(void *pNewKey) { return (char*)*(size_t*)pNewKey; }
		virtual long ReFormatData( void *, long **, long);
		virtual void ReWrite_Stream(void *, u_int64_tCtxLongSetSplayMap *) {}; // не имеет смысла!!!
		virtual void InBlockMap(u_int64_tCtxLongSetSplayMap *, struct Ref*, int Indx) {}; // не имеет смысла!!!
		virtual void AddKeyBlockMap(char *, void *, void*, void *, u_int32_t) {}; // не имеет смысла!!!
		virtual void CloseBlockMap(void *,void *) {}; // не имеет смысла!!!
		virtual void make_BlocksIndex(void*,void*,void*) {}; // не имеет смысла!!!
		virtual void FreeData( CtxLongSet * );
		virtual int IsNormsIndex() const { return 1; }; // не имеет смысла!!!
		virtual int IsStreamWithCount() const { return 1; };
		virtual void CloseLast_indxs_Temp()
		{
#ifdef MIN_MEM_CONTEXT
			::ACE_OS::write(indxs[FlashCount].file, indxs[FlashCount].pInd,
						sizeof(*indxs[FlashCount].pInd)*countNewKeys);
			::ACE_OS::close(indxs[FlashCount].file);
			if((indxs[FlashCount].file
				= ::ACE_OS::open(indxs[FlashCount].FileName, ACE_OS_O_RDONLY|ACE_OS_O_BINARY))
					== ACE_INVALID_HANDLE)
				exit(-1);
			free(indxs[FlashCount].FileName);indxs[FlashCount].FileName= 0;
#endif
			free(indxs[FlashCount].pInd);indxs[FlashCount].pInd= 0;
		}
		void CloseLastTemp(){
			if(FlashCount > -1){
				::ACE_OS::write(indxs[FlashCount].file, &lastDocFromTemp,
							sizeof(countNewKeys));
				::ACE_OS::write(indxs[FlashCount].file, &countNewKeys,
							sizeof(countNewKeys));
				CloseLast_indxs_Temp();
				/*
				странно, почему под win64 не пишутся lastDocFromTemp и countNewKeys, а потом пытаемся их прочесть из файла
#ifndef WIN64
	#ifdef MIN_MEM_CONTEXT
				if(FlashCount > 0x3fff){
					exit(-341);
				}
	#endif
				::ACE_OS::write(indxs[FlashCount].file, &lastDocFromTemp,
							sizeof(countNewKeys));
				::ACE_OS::write(indxs[FlashCount].file, &countNewKeys,
							sizeof(countNewKeys));
				CloseLast_indxs_Temp();
#else
				indxs[FlashCount].in_mem= lastDocFromTemp;
				CloseLast_indxs_Temp();
#endif
				*/
			}else if(allocIndxs == 0 && (allocIndxs +=
	#if defined(WIN64) || defined(MIN_MEM_CONTEXT)
														0x3fff
	#else
														2048
	#endif
																)
						&&(indxs=
								(LPPL_ZZZ)malloc(sizeof(PL_ZZZ)*allocIndxs))
										== 0)
						exit(-2);

			FlashCount++;
		}
		int isSkipWordWithChar(char *pWord, const char *pChars= 0);

		virtual int GetNormalesFromString(
			char *buf, LPPL_RET_NORMLS sp, LemmatizeProc lemmatize, unsigned wordLen = 0
		);

		virtual void getParaWordFromDoc (u_int64_tCtxLongSetSplayMap *p_ctxTextArray, long Id, long LastPara, long LastWordPos, std::map< long,std::set<std::string> >& gctx_kinds, IGarDoc *pdoc= 0, bool include_name_in_text = false) {}
		unsigned getParaWord(char *dst, const char **src, unsigned &l, int *f);

		NContextKey *pIOuter; // Зачем это?

		void merge_deleted( DocIterator *it, long *pDeletedDocs= 0);
		virtual void InitFileNameTempFiles(); // убрать в UpdtContextIndex
		virtual void InitTempFiles(){} // Зачем это?
		void InitFlushStat();
		virtual void InitFormsCache();

		Base *base;

	public:
		Logger* log;

		virtual void in_pipeID(long *pRet, DocIterator* it= 0, DocInfo *pLocal_docInfo= 0 ){
			*pRet= 0;
		}
		virtual int in_pipe(char *, int) {return 0;} // Зачем это здесь?
		virtual void set_p_pipe_buff(char *, long) {} // Зачем это здесь?
		virtual int in_pipe_flush(char *, int){ return -1;} // Зачем это здесь?
		virtual bool IsFlush() {
			return (maxItems < itemsDone);
		}
	protected:
		char *p_pipe_buff; // убрать в gctx.cpp
		long pipe_buff_sz, pipe_buff_tmp; // убрать в gctx.cpp
		virtual void init_buff_Norm() { buff_Norm= (char*)pNxtNPut + 32 * 128 + 32; }
		virtual bool IsNotForms(int *, CtxLongSet *sp, char *, LPPL_RET_NORMLS) { return sp->capacity == -1; }
		virtual int SetRetNormsCount(CtxLongSet *sp, LPPL_RET_NORMLS spRet){
			sp->lastI= spRet->lastI;
			return 1;
		}
		virtual bool IsAlloc_pAllPre(){ // !?
			return ((pAllPre == 0) && (m_pNIdList == 0));
		}
	};

	class NWContxtIndex : public NContxtIndex
	{
	protected:
		char *pPutWordPos, *pPutWordPosCount;
		virtual void WordPosControl(long ID, int ParaN, int *pVal, int textpos_add = 0);
		int AllParaCount, AllDocCount;
		long m_ID;
	public:
		NWContxtIndex (PagedFile*f, const char*n, StreamFile*s,
										unsigned NormlsBuffCount= MAX_NODES_INCACHE, IndexInfo *pinfo= 0 )
						:NContxtIndex (f, n, s, NormlsBuffCount, pinfo )
		{
			AllDocCount= AllParaCount= 0;
			pPutWordPos= pPutWordPosCount= 0;
			m_CurrReallocFactor= 3;
		}
		virtual void PutOffset(CtxLongSet *sp, long id, long j, int wordPos);
		virtual long ReFormatData( void *, long **, long);
		virtual int IsStreamWithCount() const { return 0; };
		virtual void DeleteChildsIndex();
		virtual void FlushAllParaWords();
	};

	extern "C" int longcmp(const void *, const void*);

#endif

