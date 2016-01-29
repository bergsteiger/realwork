#ifndef _CachedBaseRO_h
#define _CachedBaseRO_h

#include "SearchB.h"

#include "../../GPersn/src/PL_Types.h"

#pragma pack(1)
struct PagedFileBuffsNew {
	PagedFileBuffsNew () : pFAT (0), pPackOffs (0),
		pPackOffs0(0),pPackOffs1(0),pPackOffs2(0),pPackOffs3(0),pPackOffs4(0),pPackOffs5(0),m_pList(0),
		m_cntCln(0) {
	}
	int* pFAT, *pPackOffs;
	LPPL_BASE_FILE_LIST *m_ppNxt;
	unsigned int* pPackOffs0, *pPackOffs1, *pPackOffs2, *pPackOffs3, *pPackOffs4, *pPackOffs5;
	LPPL_BASE_FILE_LIST m_pList;

	int m_cntCln;
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
	bool IsBaseFile(char *pBaseName)
	{
		char *pfnd0= strrchr(pBaseName,'.');
		bool ret= false;
		if(pfnd0-pBaseName == strrchr(m_key,'.')-m_key && !memcmp(pBaseName,m_key,pfnd0-pBaseName)){
			ret= true;
		}
		return ret;
	}
protected:
	char m_key [1024];
};

typedef QuickSplayMap <gcl_FullFileName, PagedFileBuffsNew> StreamFileFats;

struct CacheFats : public Core::RefCountObjectBase {
	CacheFats () {
		static PagedFileBuffsNew _tmp_;
		m_pAllFats= new StreamFileFats(_tmp_);
		pPackOffs0=pPackOffs1=pPackOffs2=pPackOffs3=pPackOffs4=pPackOffs5=0;
		m_pList= 0;
	}
	~CacheFats ();
	StreamFileFats* m_pAllFats;
	unsigned int* pPackOffs0, *pPackOffs1, *pPackOffs2, *pPackOffs3, *pPackOffs4, *pPackOffs5;
	LPPL_BASE_FILE_LIST m_pList;
};

class BaseRO_Ex : public SearchBase
{
public:
	BaseRO_Ex (const char* name, int mode, const std::vector<std::string> &indxs_n = std::vector<std::string>());
	virtual ~BaseRO_Ex ();

public:
	virtual	StreamFile* make_StreamsPool (PagedFile*, int);
	virtual	bool IsMultiThreadsR ();
protected:
	void getNumberIndex(Index *pAx, int make_mode, long PreLastPage);
	virtual long get_ID_FATS_IN_AUX(Index *pAx, int make_mode);
	virtual void correct_Old_Aux_FAT(Index *, int *);
	virtual void actualMorpho(Index **pOutPtrIndex, long PreLastPage, int make_mode, Index *pAx);
    static Core::Var <CacheFats> s_shared_cacheFats; // статический экзапляр ВАРа на КЕШ ФАТОВ
	Index *FindIndexWithFAT(Index *pAx, const char *name, const long PreLastPage);
	void FindAttrsIndexWithFAT(Index *pAx= 0, const long PreLastPage= 0);
	virtual void *getDefList(char *InputedBaseFileName, void *pMake);
	virtual void freeDefList(void *pList) {}
	void makeCacheThreads();

	bool m_makeCacheThreads;
	int m_mmode;
	PagedFile* simple_TextFile;
	void openAllInKey();
	void hack_add_ref();
};

class CachedBaseRO : public BaseRO_Ex
{
public:
	CachedBaseRO::CachedBaseRO(const char* name, const std::vector<std::string> &indxs_n = std::vector<std::string>()) : BaseRO_Ex(name, 0x20000000, indxs_n)
	{
	}
	virtual ~CachedBaseRO()
	{
	}
};

class CachedBaseRO_without6tr4tr : public BaseRO_Ex {
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
