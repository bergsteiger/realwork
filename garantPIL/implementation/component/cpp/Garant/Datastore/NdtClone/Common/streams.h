#include "shared/Core/fix/mpcxc.h"
//
// 	Basic classes for handling multiple data chunks - streams
// Stream is a model of a normal file - you can read (write) data
// to (from) them, position in them, truncate them.
// 	All streams are stored in StreamFiles, which supports packing
// of data - small chunks of data can be stored together in pages
// IndexRec buffer can be provided to support immediate data storing
// within the directory (index) record.
//
// Structure of StreamFile
// 	Page 0    - System ( like every other PagedFile )
// 	Page 1    - 1st page of FAT
//      Page 2 ...  data ( stream ) pages
//
// Structure of record passed to Stream constructor
// 	long streamSize      - size of stream in bytes
//	long streamHandle    - handle of Stream
//
// This feature ( record ) is implemented to provide ability
// to store pointes to streams in different places ( files )
//
// Structure of FAT entry
//   Hi-bit ( 31 )  is set if this page is part in a chain list, so
//                  low-order 31 bits are next page #
//   Hi-bit ( 31 ) is cleared if this page is divided into subblocks,
//                  and low-order 31 bits are free space on this page
//
// Handle ( 1, 0 ) is used to store FAT, so page 1 ALWAYS contains
// beginning of the FAT
//
// Author	: Alex V.Boreskoff
//

#ifndef	__PILOT_STREAMS__
#define	__PILOT_STREAMS__

#ifndef PLAIN_GKDB
	#include "ace/Basic_Types.h"
	#include "ace/OS.h"
#endif
#include "shared/DB/DBCore/DBCore.h"

#include "pagefile.h"
#include "../../../../libs/gkdb/src/gardefs.h"

#define	SF_BUFDIRTY		0x0001		// internal buffer has been modified
#define	SF_MODIFIED		0x0002		// stream has been modified
#define	SF_CREATE		0x0010
#define	SF_DELETE		0x0020

#define	SF_IN_TRANSCTN	0x0080
#define	SF_IN_OPERATION	0x0100

#define	SF_IN_AUTOTRANSCTN		0x0800
#define	SF_IN_NOT_COPY			0x0400
#define	SF_IN_PRE_ATRANSCTN		0x0200
#define	SF_IN_FIRST_COPY		0x1000

#define	SF_IN_FIRST_LOG			0x2000
#define	SF_NOT_FIRST_DUMP		0x4000
#define	SF_IN_FILE_DIRECT		0x8000
#define	SF_NEW_HANDLE			0x10000

#define	SF_NOT_ACTUAL			0x20000
#define	SF_UPDT_ACTUAL			0x40000

#define	SF_GLOBAL_CREATE		0x080000
#define	SF_SKIP_UPDT_CACHE		0x100000
#define	SF_LOAD_FAT_ON_DEMAND	0x200000
#define	SF_SRC_AS_SHORT			0x400000
#define	SF_FIRST_POS_BCKP		0x800000
#define	SF_NOT_RENAME_OLD_BCKP	0x1000000
#define	SF_POST_REST_FAT		0x2000000
#define	SF_RESTR_LONG_BKP		0x4000000
#define	SF_POST_CREATE_AS_TMP	0x8000000

#define	FAT_CHAIN	0x80000000l	// pages are chained

static const char SF_FAT_OD[]= "FOD";

#include "../../../../libs/cchlp/src/QMap.hpp"

typedef struct SF_INFILE_TAG
{
	int Page;
	char *pBff;
} SF_INFILE, *LPSF_INFILE;

namespace NdtClone {

static const int NDTC_MAX_PATH_SIZE= 2048;

	class gcl_FullFileName
	{
	public:
		gcl_FullFileName()
		{
			this->Init(0, 0);
		}
		gcl_FullFileName(const int)
		{
			this->Init(0, 0);
		}
		gcl_FullFileName(const char *pKey, const int szKey)
		{
			this->Init(pKey, szKey);
		}
		gcl_FullFileName(const char *pKey)
		{
			this->Init(pKey, int(::strlen(pKey)&0x7fffffff));
		}
	protected:
		char m_key[NDTC_MAX_PATH_SIZE];
		void Init(const char *pKey, const int szKey){
			if(szKey >= NDTC_MAX_PATH_SIZE)
				::memcpy(m_key, pKey, NDTC_MAX_PATH_SIZE);
			else{
				::memcpy(m_key, pKey, szKey);
				::memset(m_key+szKey, 0, NDTC_MAX_PATH_SIZE-szKey);
			}
		}
	};
#pragma pack(1)
	struct PagedFileBuffs
	{
		PagedFileBuffs() : pFAT(0), pPackOffs(0) {}
		PagedFileBuffs(const int) : pFAT(0), pPackOffs(0) {}
		int	*pFAT, *pPackOffs;
	};
#pragma pack()
	typedef QuickSplayMap<gcl_FullFileName,PagedFileBuffs> StreamFileFats;

//const int SF_CACHE_SIZE = 4000;

class	Stream;
class	Index;

inline bool isBigHandle(IndexRecordData *pTmp)
{
	if(pTmp->header.allocatedDataLength & 0x80000000)
		return true;
	return false;
}

#pragma pack(1)

//##ModelId=3C4D2F1A01E6
struct	BlockDesc
{
	//##ModelId=3C4D2F1A0271
	unsigned short	Id;	   // unsigned Id   : 11; FUCK this stupid MSVC
	//##ModelId=3C4D2F1A027A
	short	Size;	   // unsigned Size : 13;
};

#pragma pack()

typedef G_Point Point;

class CachedPage
{
public:
	CachedPage(){
		m_Data= 0;
	}
	CachedPage(::PagedFile *file, void *buff, int *pCount, int changed= 0);
	void PutPage(void *buff, void *pSfl);
	void GetPage(void *buff, void *pSfl);
	short m_changed;
	char *m_Data;
	unsigned int actualLevel;
};
class CachePagesMap : public QuickSplayMap<int,CachedPage*>
{
public:
	CachePagesMap(CachedPage *pDef= 0) : QuickSplayMap<int,CachedPage*> (0), pActualPageMap(0), pFlashedPageMap(0)
	{
	}
	QuickValSplayMap<ACE_UINT64,G_Point> *pActualPageMap;
	QuickValSplayMap<int,G_Point> *pFlashedPageMap;
	~CachePagesMap()
	{
		if(pActualPageMap)
			delete pActualPageMap;
		if(pFlashedPageMap)
			delete pFlashedPageMap;
	}
};
typedef QuickValSplayMap<int,int> STRPageNMap;
typedef QuickSplayMap<int,int> NDTPagesFreeMap;
typedef QuickSplayMap<ACE_UINT64, int> NDTStreamsFreeMap;

class	NPagedFile : public NdtClone::PagedFile
{
protected:
	NDTPagesFreeMap *FreePages;
	virtual void abort(void){
		global_Block();
	}
public:
	NPagedFile ( const char * name, int mode, int database_version
#ifdef COMPATIBILITY_FILE_SIZE
				, int max_paged_file_per_bytes = MAX_BYTE_FILE_SIZE
#endif
				);
	NPagedFile ( LPPF_PARAM pFile );
	virtual	~NPagedFile ();
	int	NewPage ();
	void	DelPage ( int );
	virtual int Delete(int Remove= 0);
	virtual int Connect( const char * name, int mode
#ifdef COMPATIBILITY_FILE_SIZE
				, int max_paged_file_per_bytes
#endif
				);
	/////////////////////////////////////////////////////////////////////////////
	int m_AllocPageCountInCache, m_maxPageCountInCache, m_HardFlushCount, *pCnt;
};

typedef QuickSplayMap<int,char> mapLongToChar;
typedef QuickValSplayMap<short, mapLongToChar*> mapShortTo_pmapLongToChar;

//class Core::GDS::HiResCounter;

class	StreamFile			// Stream manager, all streams reside within this file
{
protected:
	int m_notAutoRoll;
	char *pNameBackupName;
	StreamFile *m_Fs;
	int lastFatPage;
#ifndef WRITE_KEYS_PAGE_INBACKUP
	NdtClone::NDTKPageMap *pWritedPages;
#endif
public:
	virtual void abort(void);
	void AsUpdated(int Page, void *NewBody);
	mapShortTo_pmapLongToChar *m_pFreeOnPages;

	int last_full_page;
	void FlushIndexPagedFileAdaptiveCache();
	int LastCreatedBlockPage, NextIdPerOldPage;
	void FirstRecord();
	void *m_pDelKeys;
	enum opertionS_t {
		open_n_index,
		read_stream,
		write_stream,
		close_index
	};
	StreamFile *pOldCreate;
	ACE_UINT64 streamID;
	opertionS_t m_curr_;
	void *m_pVal;
	void BeginOperation(void *pVal, opertionS_t curr_= open_n_index);
	void EndOperation();
	//##ModelId=3BFE7DEB010A
	PagedFile * file;		// data file for all streams
	PagedFile * pKfile;

	Index **pCreateOtherK;
	int iCreateOther, iDeleteFile;
	Index *pFirst;
	NdtClone::BTStack Stack[GKDB::BT_MAXDEPTH];
	NdtClone::Stream *pFirstStr;
	STRPageNMap *rpages
#ifndef SAVE_ALL_FAT_ON_BUCKUP
						, *fpages
#endif
									, *bpages;
	int m_hBackup/*, m_hBackupKeys*/;
	virtual char *GetBackupName();
	int	            Flags, dfltII;
	//NDTTransaction StartTransaction();
	void StartTransaction(); // GARANT_W343
	int
#ifdef WRITE_KEYS_PAGE_INBACKUP
			lastKeyPage,
#endif
							 CountAllFlush;
	void PreBackupTransaction(int skipWritePage= 0);
	void BackupTransaction();
	void EndTransaction(int Buckup= 1);
	void InitFirstStr( Stream * );
	int InitFirstMaps();

	int nSysP;
	char *SysBuf, *aSysBuf, *m_next_actual_FAT_page;	// system buffer (size == pageSize)
	short	            fatPages;	// # of pages occupied by FAT

protected:
	void	AddFatNext(int page, int Val);
	void	AddFat(int page, int Val, int checkShort= 1);
	//##ModelId=3BFE7DEB0110
	virtual int GetPage(int page, void *buff);
	int PrePutPage(int page, void *buff, void *DirectBuf= 0);
	virtual int PutPage(int page, void *buff);

public:
	int gk_huge *Fat, *m_deletedFat;

	char *GetSysBuff() const { return SysBuf; }
	void InitThis( ::PagedFile * strFile, int bLoadFat );
	StreamFile ( ::PagedFile * strFile, int bLoadFat );
	StreamFile ( ::PagedFile * strFile );
	~StreamFile ();

	void	Create (PagedFile *pFirstKey= 0);		// create ( initialize ) file
	int	IsOk   () const		// whether file is OK
	{
		return file -> IsOk () && SysBuf != 0;
	}
	virtual void AddPageFromCache(int page, CachePagesMap *pMap, ::PagedFile *file, void *buff, char **ppPagesStack, int *pCount, int as_changed= 0);
	void FlushCache(CachePagesMap **ppMap, ::PagedFile *file, char **ppPagesStack, int *pCount);
	int GetPageFromCache(int page, CachePagesMap **ppMap, ::PagedFile *FileDef, void *buff, char **ppPagesStack, int *pCount);
	int GetKeysPageFromCache(int Page, void *buff);
	int GetStrsPageFromCache(int Page, void *buff);
	int PutPageFromCache(int page, CachePagesMap **ppMap, ::PagedFile *FileDef, void *buff, char **ppPagesStack, int *pCount);
	int PutKeysPageFromCache(int Page, void *buff);
	int PutStrsPageFromCache(int Page, void *buff);
	void Delete();
protected:
	// allocate new handle for data of given size
	unsigned short	NewHandle     ( int Size, int *p_bigHandle= 0, void *pNewData= 0, int *p_Handle= 0 );
	// free handle
	int		DelHandle     ( int bigHandle, Stream *pstr );
	// find page with given pos (no) in chain
	int	FindPage      ( int Handle, int PageNo, int Per4Bytes= 0 );
	// append new page to page chain
	int	AppendPage    ( int Handle, int bigHandle= 0 );
	int	AddNewPage    ( int LastPage, int bigHandle= 0 );
	// load block of data corresponding to
	// given page # into buffer
	int		LoadBlock     ( Stream *str, int PageNo, void * buf );
	// save buffer data corresponding to handle
	// into given page
	int	SaveBlock     ( Stream *pstr, int PageNo, void * buf, int Size, int *p_bigHandle= 0 );
	// remove subblock from non-chained page
	int*	RemoveBlock   ( int Page, int Offs, Stream *str= 0, int Size= 0, void *pNewData= 0 );
	// truncate stream to given size
	int		TruncStream   ( Stream * s, int NewSize, int *p_bigHandle= 0, char *newData= 0);
	// locate subblock with given id & return its
	// offset ( or -1 if none ), loads SysBuf
	int		FindSubBlock  ( int Page, short id );
	int		FreePageChain ( int page );
	// allocate new page
	int	AllocPage     (int bigHandle= 0);	// increasing FAT size if required

	int GetLastCreatedBlockPage();
	int directSysBuf(int Page, bool bPut= false);

public:
	int IsNotBlock(int Size);
	virtual void LoadFat       (::PagedFile *otherLine= 0);
	//##ModelId=3BFE7DEB01A6
	void	SaveFat       (int hOtherSaveHandle= -1);

	//##ModelId=3BFE7DEB01A8
	int	CheckPage     ( int page );
	//##ModelId=3BFE7DEB01B0
	int	Check ();

	friend class Stream;
	friend class Index;
	int GetTransactionCounter() const {
		return m_transaction_counter;
	}
	void SetTransactionCounter(int newCount){
		m_transaction_counter= newCount;
	}
	CachePagesMap *m_PagesCacheKeys;
	char *m_pCacheKeysStack;
	int m_pCacheKeysStackCount;
	CachePagesMap *m_PagesCacheBlocks;
	char *m_pCacheBlocksStack;
	int m_pCacheBlocksStackCount;
private:
	int m_transaction_counter;
public:
	char *m_stepWriteBuff;
	int m_bLoadFat;
	void DirectFlush(::PagedFile * otherFile);
protected:
	char *AllocSysBuf();
public:
#ifdef _DEBUG
	NDTStreamsFreeMap *ostreams;
#endif
#ifdef MIN_MEM_CONTEXT
	::PagedFile *pOtherBackuped;
#endif
protected:
	CachedPage *forceSysBuf(bool fastAdd= false, int *p_bigHandle= 0, int *p_Handle= 0);
	void reConnectFirst(char*);
public:
	/*Core::GDS::HiResCounter hi_res_counter;
	unsigned m_s;
	unsigned m_ms;
	unsigned m_us;*/
	NPagedFile *fc;
protected:
	virtual void re_find_bytes_in_pre_pages(int Size= 0);
	virtual int prePut_for_test_IO();
	virtual bool writeBigStreamPage(int Pg, void *bf, int pageNo= 0);
	void first_bb();
	virtual BlockDesc* getOldBlock();
public:
	virtual bool onlyAdd() const { return false; }
	void LoadFatEx (int hOtherSaveHandle, bool b_ignoreFOD= false);
	unsigned short m_LastNewId;
	bool backup_System();
	virtual int	GetNextPageFromBigStreamForUpdate(int page, void *buf)
	{
		return file->GetPage(page,buf);
	}
	void UpActualLevel(CachedPage *pFnd, CachePagesMap *pMap);
	unsigned int m_uCountLockedPage;
	void modifyBKP(bool old= false);
	void not_actual_BKP();
	virtual int get_guard()
	{
		return 1;
	}
	virtual int get_ro_guard()
	{
		return 1;
	}
	virtual void kill_guard(int){}
	virtual void kill_ro_guard(int){}
	virtual bool is_next_write()
	{
		return true;
	}
	virtual void end_write(){}
	virtual void set_transactionID(){}
	virtual void start_read_transaction(){}
	virtual void end_read_transaction(){}
	void AllocFAT(::PagedFile *otherLine= 0);
	void clearTmp(int *pStartVa);
	char * m_PagedBackupSystemPage;
	void Clone_IO_File(PagedFile *);
protected:
	virtual bool write_FirstGKDB();
};

class	StreamFileFastAdd : public StreamFile
{
public:
	StreamFileFastAdd ( ::PagedFile * strFile, int bLoadFat ) : StreamFile ( strFile, bLoadFat )
	{
	}
	StreamFileFastAdd ( ::PagedFile * strFile ) : StreamFile ( strFile )
	{
	}
protected:
	virtual void re_find_bytes_in_pre_pages(int Size= 0);
	virtual int prePut_for_test_IO();
	virtual bool writeBigStreamPage(int Pg, void *bf, int pageNo= 0);
	virtual BlockDesc* getOldBlock();
public:
	virtual bool onlyAdd() const { return true; }
	virtual int	GetNextPageFromBigStreamForUpdate(int page, void *buf)
	{
		CachedPage *pFnd= (CachedPage *)m_PagesCacheBlocks->seek(page);
		if(pFnd){
			pFnd= m_PagesCacheBlocks->contents(pFnd);
			memcpy(buf, pFnd->m_Data, file->PageSize);
			return 1;
		}
		return file->GetPage(page,buf);
	}
protected:
	virtual bool write_FirstGKDB();
};


#define STREAM_PER_4BYTES 0x1968
#define STREAM_AS_COLLECTION 0x1970

class	Stream : public DBCore::Store
{
protected:
	virtual void abort(void){
		global_Block();
	}
	int nxtBlock ( unsigned int *pPgNo, void *Readed= 0 );
public:
	int *blocks, blocks_count;
	StreamFile * file;
	int	     Flags;
	int	     Handle;			// handle associated with this stream
	int	     Pos;			// current position within stream
	int realSize;			// current size of stream data
	int realSizeExt;
	int allocatedSize;
	int	     BufSize;			// == file -> file -> PageSize
	char       * Buf, *hBuf;			// internal buffer
	IndexRecordData * Rec;
	int	     ImmSize;
	int         roundV;
	int oPage, oPos;
	int WritePage(int page, void *buff);
	bool m_bAsNew;
public:
	StreamFile *GetStreamsFile() { return file; }
	IndexRecordData	 * GetRec() { return Rec; }
	ACE_UINT64 streamID;
	char	   * IndexBuf;
	char	   * IndexFreeBuf;

	Stream ( StreamFile * );
	Stream ( StreamFile *, IndexRecordData * rec, int rec_size, int rv, int otherFile= 0 );
	~Stream ();
	void closeAttrs();

	int	ReadEx  ( void  * buf, int Count );
	int	Write ( const void  * buf, int Count );
	int	SeekEx  ( int );			// seek from beginning of file
	int	Trunc ();
	int	AllocatedSize () const
	{
		return allocatedSize;
	}
	int	Tell  () const
	{
		if(Pos == MAX_BYTE_FILE_SIZE)
			return m_Pos;
		return Pos;
	}
	int	Length () const
	{
		return realSize;
	}
	int	SeekCur ( int Offs )
	{
		return Seek ( Tell() + Offs );
	}
	int	SeekCurrEx ( int Offs ) 
	{
		return SeekEx ( Pos + Offs );
	}
	int	Modified ()
	{
		return	Flags & SF_MODIFIED;
	}
	int	SkipModified ()
	{
		return	Flags &= ~SF_MODIFIED;
	}
	bool isBigHandle()
	{
		if(allocatedSize & 0x80000000)
			return true;
		return false;
	}
	virtual int Read ( void  * buf, int Count ) { return this->ReadEx ( buf, Count ); }
	virtual int Seek( int pos ) { return this->SeekEx ( pos ); }
	char *getTempBuf() const { return hBuf; }
	void setTempBuf(char *pnew) { Buf= hBuf= pnew; }
	int	Save  ();
protected:
	int PreLoadBlock;
	int m_extBlobFileHandle;

	int	SaveBlockSize ();

	int m_Pos;

	//PostMessageForResorceTom m_PostMessageForResorceTomFunc;

	friend	class	StreamFile;
public:
	unsigned short m_Id;
	virtual int BeginForReWriteAll() {
		if(blocks){
			unsigned int	CurPageNo= (int)(Pos/BufSize);
			if(file->m_PagesCacheBlocks->seek(blocks[CurPageNo])){
				((CachedPage *)(file->m_PagesCacheBlocks->contents(file->m_PagesCacheBlocks->GetRootG_SimpleSplayNode())))->m_changed= 0;
			}
			blocks[CurPageNo+1]= 0;
		}
		return this->SeekEx ( 0 );
	}
	//int m_nObj;
protected:
	void firstAllocBlocks();
};

class	StoredSortedCollection : public Stream, public BTree
{
public:
	StoredSortedCollection (	StreamFile *sFile
								,IndexRecordData *rec
								,int rec_size
								,int rv
								,int otherFile= 0);
	virtual	int	Compare ( BTKEY key1, BTKEY key2 ) const
	{
		  return (*((int*)key1) > (*(int*)key2)) ?
				1 : (*((int*)key1) < *((int*)key2)) ? -1 : 0;
	}
	virtual int GetPage(int page, void*buff)
	{
		if(Stream::blocks){
			int pos= (page-1) * BTree::file->PageSize;
			if(Stream::Seek(pos) != pos)
				return 0;
			return Stream::Read(buff, BTree::file->PageSize);
		}else{
			memcpy(buff, Stream::Buf, Stream::realSize);
			Stream::Pos= Stream::realSize;
		}
		return 1;
	}
	virtual int PutPage(int page, void*buff, int onlyPut= 0)
	{
		BTree::abort();
		return 0;
	}
	virtual void  * RecOffs ( void * buf, int rec ) const
	{
		return (void*)((char*)buf + rec * BTree::KeyLength);
	}
    virtual short   RecSize () const
    {
            return KeyLength;
    }
    virtual int GetNext( char *keyPtr );
	int m_lastPos;
	int m_firstPos;
    virtual short   GetCount ( void * buf ) const;
	virtual int ChangeNode(void *pNode, void * buf, int& no, int& Page)
	{
		int Result= BTree::LocateKey(pNode, buf, no, Page);
		if(Result == GKDB::BT_NONE){
			Page= Stack[Sp-1].Page;
			no= Stack[Sp-1].Pos;
		}
		return Result;
	}
	virtual char *PrepareStackBuff( int page, char *, void*);
	virtual int LastCompare( BTKEY, BTKEY, int);

protected:
	virtual void skipCritical(){};
};

class	StoredSortedRefCollection : public StoredSortedCollection
{
public:
	StoredSortedRefCollection (	StreamFile*sFile
								, IndexRecordData*rec
								, int rec_size
								, int rv
								, int otherFile= 0)
		: StoredSortedCollection ( sFile, rec, rec_size, rv , otherFile)
	{
	}
	virtual	int	Compare ( BTKEY key1, BTKEY key2 ) const
	{
		int ret= ( ((::Ref*)key1)->DocId > ((::Ref*)key2)->DocId ) ?
				1 : (((::Ref*)key1)->DocId < ((::Ref*)key2)->DocId) ? -1 : 0;
		  if(!ret){
			return ( (((::Ref*)key1)->Sub & 0x3fffffff) > (((::Ref*)key2)->Sub & 0x3fffffff) ) ?
				1 : ( (((::Ref*)key1)->Sub & 0x3fffffff) < (((::Ref*)key2)->Sub & 0x3fffffff) ) ? -1 : 0;
		  }
		  return ret;
	}
	virtual int ChangeNode(void *pNode, void * buf, int& no, int& Page);
};

class	StoredSortedRefCollectionPlus : public StoredSortedCollection
{
public:
	StoredSortedRefCollectionPlus (	StreamFile*sFile
								, IndexRecordData*rec
								, int rec_size
								, int rv
								, int otherFile= 0)
		: StoredSortedCollection ( sFile, rec, rec_size, rv , otherFile)
	{
	}
	virtual	int	Compare ( BTKEY key1, BTKEY key2 ) const
	{
		int ret= ( ((::Ref*)key1)->DocId > ((::Ref*)key2)->DocId ) ?
				1 : (((::Ref*)key1)->DocId < ((::Ref*)key2)->DocId) ? -1 : 0;
		return ret;
	}
};

class	StoredSortedClassRefCollection : public StoredSortedRefCollection
{
public:
	StoredSortedClassRefCollection (	StreamFile*sFile
								, IndexRecordData*rec
								, int rec_size
								, int rv
								, int otherFile= 0)
		: StoredSortedRefCollection ( sFile, rec, rec_size, rv , otherFile)
	{
	}
	virtual int ChangeNode(void *pNode, void * buf, int& no, int& Page);
};

class AutoKillStr
{
public:
	AutoKillStr(Stream *pCurr){
		//m_curr= pCurr->m_nObj;
		m_pcurr= pCurr->file;
	}
	~AutoKillStr()
	{
		//m_pcurr->kill_guard(m_curr);
	}
private:
	int m_curr;
	StreamFile *m_pcurr;
};

} // namespace NdtClone
#ifndef GKDB_WITH_INDEX5X
	typedef NdtClone::IndexRecordData IndexRecordData;
	typedef NdtClone::StreamFile StreamFile;
	typedef NdtClone::Stream Stream;
#endif

#endif
