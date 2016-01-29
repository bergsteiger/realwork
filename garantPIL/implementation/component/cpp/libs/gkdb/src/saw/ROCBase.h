
#ifndef _CachedBaseRO_h
#define _CachedBaseRO_h

#include "SearchB.h"

#pragma pack(1)
struct PagedFileBuffs {
	PagedFileBuffs () : pFAT (0), pPackOffs (0) {}
	int* pFAT, *pPackOffs;
};
#pragma pack()

class gcl_FullFileName {
public:
	gcl_FullFileName () {
		::memset (m_key, 0, 1024);
	}
	gcl_FullFileName (const char* pKey) {
		size_t sz_key = ::strlen (pKey);

		if (sz_key >= 1024) {
			::memcpy (m_key, pKey, 1024);
		} else {
			::memcpy (m_key, pKey, sz_key);
			::memset (m_key + sz_key, 0, 1024 - sz_key);
		}
	}
protected:
	char m_key [1024];
};

typedef QuickSplayMap <gcl_FullFileName, PagedFileBuffs> StreamFileFats;

struct CacheFats : public Core::RefCountObjectBase {
	CacheFats () {
		static PagedFileBuffs _tmp_;
		m_pAllFats= new StreamFileFats(_tmp_);
		cacheAllDocs= 0;
		cacheAllMDocs= 0;
		cacheAllFDocs= 0;
		pPackOffs0=pPackOffs1=pPackOffs2=pPackOffs3=pPackOffs4=pPackOffs5=0;
	}
	~CacheFats ();
	StreamFileFats* m_pAllFats;
	DocCollection* cacheAllDocs;
	DocCollection* cacheAllMDocs;
	DocCollection* cacheAllFDocs;
	unsigned int* pPackOffs0, *pPackOffs1, *pPackOffs2, *pPackOffs3, *pPackOffs4, *pPackOffs5;
};

class	CachedBaseRO : public SearchBase
{
public:
	CachedBaseRO (const char* name, int mode = ACE_OS_O_RDONLY);
	virtual ~CachedBaseRO ();

public:
	virtual	StreamFile* make_StreamsPool (PagedFile*, int);
	virtual	bool IsMultiThreadsR ();

	void open_saw_bases ();
	virtual Index* FindBlobIndexFor (long id);
	virtual Base* FindBaseForDoc (long Doc);
	virtual Document* GetDoc (long DocId, const DocInfo* p_DocInfo = 0);
	virtual void gk_huge *LoadAttr (long DocId, int tag, long& size);
	virtual void gk_huge* LoadAttrEx (long DocId, int tag, long& size);
	virtual int LoadAttr (long DocId, int tag, DBCore::Storable& storable);

	virtual int FindDocName (long Id, char * buf);
	virtual int FindSubName (long Id, long sub, char * buf);
	//virtual int FindDocInfo (long docId, DocInfo&);
	virtual int FindDocAttr (long Id, int Tag, void * buf, int size);

protected:
	void getNumberIndex(Index *pAx, int make_mode, long PreLastPage);
	virtual long get_ID_FATS_IN_AUX(Index *pAx, int make_mode);
	virtual void correct_Old_Aux_FAT(Index *, int *);
	virtual void actualMorpho(Index **pOutPtrIndex, long PreLastPage, int make_mode, Index *pAx);
	static Core::Var <CacheFats> s_shared_cacheFats; // статический экзапляр ВАРа на КЕШ ФАТОВ
	Index *FindIndexWithFAT(int make_mode, Index *pAx, const char *name, const long PreLastPage);

private:
	static std::map<long,char> map_doc_basechar, map_blob_basechar;
	std::vector<YBase*> bases_ptrs;
};

class CachedBaseRO_without6tr4tr : public CachedBaseRO {
public:
	CachedBaseRO_without6tr4tr(const char* name);
	virtual Index* FindIndex (const char *name);
protected:
	virtual long get_ID_FATS_IN_AUX(Index *pAx, int make_mode);
	virtual void correct_Old_Aux_FAT(Index *, int *);
	virtual void actualMorpho(Index **pOutPtrIndex, long PreLastPage, int make_mode, Index *pAx);
};

DBCore::IBasePool* make_base_pool (size_t size, const std::string& path);

#endif
