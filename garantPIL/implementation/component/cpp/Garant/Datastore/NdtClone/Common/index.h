//
// Basic index class for managing search
// Based of BTree class to provide add/delete/find capabilities
// structure of record ( record size == KeyLength )
//
//
// where ImmData is data block for keeping small data directly in key record
// if data size is greater than ImmDataSize, then handle to stream with data is kept in this field
//
// Author Alex V. Boreskoff
//

#ifndef	__PILOT_INDEX__
#define	__PILOT_INDEX__

#include "btree.h"
#include "streams.h"

#include <cstring>
  #ifndef PLAIN_GKDB
#include "ace/Basic_Types.h"
  #endif

namespace NdtClone {

extern NdtClone::PagedFile *GetUpdatedPagedFile(const char * name, int database_version);
extern NdtClone::PagedFile *GetReadOnlyPagedFile(const char * name, int database_version);
extern NdtClone::PagedFile *CloneUpdatedPagedFile(LPPF_PARAM pFile, int database_version);

class TransactionMng {	
public:
	TransactionMng (StreamFile* str) : m_stream(str) {
		if (m_stream) {
			m_stream->StartTransaction();
		}
	}

	~TransactionMng () {
		if (m_stream) {
			m_stream->EndTransaction();
		}
	}
	
private:
	TransactionMng (const TransactionMng& copy) {
	}

private:
	StreamFile* m_stream;
};

extern void set_global_transaction_path(const char *pNewPath);
extern void start_global_transaction(int notCopy= 0);

class BackupedFileName
{
protected:
	char m_FullName[NDTC_MAX_PATH_SIZE];
public:
	BackupedFileName(const char*pFullName= 0)
	{
		memset(m_FullName, 0, NDTC_MAX_PATH_SIZE);
		if(pFullName){
			int len= int(::strlen(pFullName)&0x7fffffff);
			if(len){
				if(len >= NDTC_MAX_PATH_SIZE)
					len= NDTC_MAX_PATH_SIZE - 1;
					
				memcpy(m_FullName, pFullName, len);
				m_FullName[len]= 0;
			}
		}
	}
	const char *GetName() { return m_FullName; }
};

typedef QuickSplayMap<BackupedFileName,int> BackupedFileNameMap;
typedef QuickSplayMap<StreamFile*,char> StreamFile_List;

extern void end_global_transaction(BackupedFileNameMap *pAsCompact= 0);

class	Index : public BTree
{
protected:
	virtual void abort(void){
		if(streams)
			streams->abort();
		else
  #ifdef PLAIN_GKDB
		global_Block();
  #else
		throw NdtClone::Error ();
  #endif
	}
	virtual void check_abort(void);
	void SkipFirstBackupIndex ();
	virtual char *readPage(long Page);
public:
	PagedFile *GetCreatedPagedFile(const char * name, int database_version);
	virtual char *cachedPage(long Page, CachedPage **ppRet= 0);
	int IsGlobalTransaction(int SkipGlobalBuckup= 0);
	void StartAutoLocalTransaction();
	virtual char *PrepareStackBuff( int page, char *cur, void* buf1);
	virtual void PrepareStackBuffWrite();
	virtual int GetPage(int page, void *buff);
	virtual int PutPage(int page, void *buff, int onlyPut= 0);
	virtual int BuckupRoot(int hFile);
	void PutRootPage(void  * buf);
	void flush_files();
    char         Name [20];         // index name
	int roundv;
	int nstreams; // number of data streams per key

	StreamFile*	streams;
	StreamFile*	streamsUpdt;
	Index*		indexUpdt;
	int	     ImmDataSize;

	void InitThis( PagedFile * tf, const char * name, StreamFile * str, IndexInfo *pOtherBuffer= 0 );
	Index () : BTree ()
	{
		streams= 0;
	}
	Index ( PagedFile * tf, const char * name, StreamFile * str);
	Index ( ::PagedFile * tf, const char * name, StreamFile * str);
	void Init_Index ( PagedFile * tf, const char * name, StreamFile * str );
	virtual ~Index();

	virtual	void Create(short keysize,short rndv,short ns=1,short immsize=0);
	virtual	int	Compare ( BTKEY key1, BTKEY key2 ) const
	{
		return strncmp ( (char *) key1, (char *) key2, KeyLength );
	}

	virtual int Delete ( BTKEY key );
	virtual int Rename(BTKEY key1, BTKEY key2);
	virtual	Stream* Open(BTKEY key,int AutoCreate=0,int *pCreated=0);
	virtual	Stream* OpenN(BTKEY k,int sn= -1, int ac=0, int *pCreated=0);
	//int	AddData ( BTKEY k, int sn, const void  * buf, int Count );
	//int	AddData_MRGLIB( BTKEY k, int sn, char **buf, int Count );
	//int	AddStream_MRGLIB( BTKEY k, char **buf, int Count );
	virtual	Stream* OpenN(IndexRecordData *);

	virtual	Stream* DelNodeOnStreamN(void *pNode, short BytesPerNode,  BTKEY k, int sn= 0);
	virtual	Stream* AddNodeOnStreamN(void *pNode, short BytesPerNode,  BTKEY k, int sn= 0, int iAutoCreate= 0);
	virtual	Stream* FindNodeOnStreamN(void *pNode, short BytesPerNode,  BTKEY k, int sn= 0);
	virtual Stream* ResultAsStream (StoredSortedCollection*);
	const Stream* OpenNforRead(BTKEY k,int sn){
		return (const Stream*)OpenN(k,sn);
	}
	virtual	void	Close  ( Stream * s, int iRemoveKey= 0);
	virtual	void	PrepareRecord  ( BTKEY key, char * buf1= 0 );
	virtual	int	AddData ( BTKEY key, const void * buf, int size, int nS=0);
	virtual	int	SetData ( BTKEY key, const void * buf, int size, int nS=0);
	virtual	int	FindDataEx ( BTKEY key, void * buf, int buf_size, int nS=0);
	IndexRecordData * recordData(BTKEY key, int sn ) const
	{
		return (IndexRecordData*)
			((char*)key + KeyLength - 
			 ((nstreams-sn)*
			   (sizeof(IndexRecordData::RecordDataHeader)+ImmDataSize)));
	}
	virtual void UpdateUpKey(int AutoAdd, char *old_key, char* new_key);
	void AsUpdated( Stream *pMod, int sn= 0 ){
		char *UpdatedBuf = (char *) malloc ( 256 );
#ifdef _DEBUG
	{
		int tmpMM= 256;
		while(tmpMM--)
			UpdatedBuf[tmpMM]= 0;
	}
#endif
		memcpy(UpdatedBuf, pMod->IndexBuf, KeyLength);
		pMod->IndexBuf= UpdatedBuf;
		pMod->Rec= recordData(pMod->IndexBuf, sn);
	}
	int&	Size ( BTKEY key, int sn=0)
	{
		return recordData(key,sn)->header.realDataLength;
	}

	void InitBackupStatstcsFile();
	void InitBackupStatstcs();
	void realMakeTempFiles();
	virtual void StartBackupEx ( int AutoCreate= 1 );
	char *pResultFileKeyName;
	virtual	int	FindData ( BTKEY key, void * buf, int buf_size, int nS=0){
		return FindDataEx ( key, buf, buf_size, nS);
	}
	//void RestoreNamesFiles(char *gs_target_name, void *strR,
	//	PagedFile *file__, StreamFile * streams__);
	Index ( ::PagedFile * tf, const char * name, StreamFile * s, IndexInfo *pOtherBuffer) : BTree ()
	{
		InitThis( (NdtClone::PagedFile*)tf, name, s, pOtherBuffer);
		SkipFirstBackupIndex();
	}
	Stream* keyOpen(BTKEY k, int sn= 0)
	{
		CollectionStream= 0;
		return makeStream(streams,recordData(k,sn),ImmDataSize,roundv);
	}
	void skipInitRecord(){
		CollectionStream= 55;
	}
protected:
	virtual Stream *makeStream(StreamFile *sFile
								,IndexRecordData *pRec
								,int rec_size
								,int rv
								,int otherFile= 0) const
	{
		Stream *pRt=  new Stream(sFile, pRec, rec_size, rv, otherFile);
		//pRt->m_nObj= 0;
		return pRt;
	}
	int CollectionStream;
	int *m_pCountOut;
public:
	ACE_UINT64 ClosedID;
	void CloneAsCompact(Index *pOut);
	void PutInfo();
protected:
	virtual void skipCritical();
	char *QuickPageBuf;
	int UpKeyAsChanged(int oPage, int oPos, char *keyBuf= 0)
	{
		if(oPos == -1){
			if(streams->m_PagesCacheKeys && streams->m_PagesCacheKeys->key(streams->m_PagesCacheKeys->GetRootG_SimpleSplayNode()) == oPage){
				streams->m_PagesCacheKeys->contents(streams->m_PagesCacheKeys->GetRootG_SimpleSplayNode())->m_changed= 1;
			}
		}else{
			if(!pWritedPages->seek(oPage)){
				pWritedPages->get(oPage) = NDTKPage(file, QuickPageBuf= PrepareStackBuff( oPage, 0, 0 ));
			}
			if(!memcpy (	RecOffs ( (pWritedPages->contents(pWritedPages->GetRootG_SimpleSplayNode()).GetData()), oPos )
							, keyBuf, KeyLength ))
			{
				return -2;
			}
		}
		return 0;
	}
public:
	void update_SystemPage();
	void FlushOperation();
	void reOptimizeShortPage(int Pg, unsigned short *pOutId);
	virtual void *DeleteUpKey();
protected:
	CachedPage *m_ppCritical[GKDB::BT_MAXDEPTH];
	int m_CriticalCount, m_CriticalPreActual[GKDB::BT_MAXDEPTH];
	virtual int initCritical(){
		streams->m_uCountLockedPage= 0;
		return (m_CriticalCount= 0);
	}
	virtual int	NewPage (void *bf= 0);
public:
	void Free_pFirstStackAttribs();
	int	getRootNode(const char * name, void * buf, int size, StreamFile *s= 0);
protected:
	void unlinkBackupHanle(bool bCloseAsFile);
};

#ifndef PLAIN_GKDB
typedef QuickSplayMap<int,Core::Guard *> LockObjsList;
typedef QuickSplayMap<ACE_thread_t,char> ThreadList;

class	MultuThreadStreams : public StreamFile
{
protected:
	LockObjsList *m_LockObjs, *m_r_LockObjs;
	ThreadList *m_pRO_list;
	void init_this()
	{
		m_currLockObj= 0;
		m_LockObjs= new LockObjsList(0);
		m_r_currLockObj= 0;
		m_r_LockObjs= new LockObjsList(0);
		t_id= 0;
		m_ro_Count= 0;
		m_pRO_list= new ThreadList(0);
	}
public:
	MultuThreadStreams ( ::PagedFile * strFile, int bLoadFat ) : StreamFile ( strFile, bLoadFat )
	{
		init_this();
	}
	MultuThreadStreams ( ::PagedFile * strFile ) : StreamFile ( strFile )
	{
		init_this();
	}
	~MultuThreadStreams()
	{
		delete m_r_LockObjs;
		delete m_LockObjs;
		delete m_pRO_list;
	}
	virtual int get_ro_guard()
	{
		Core::Guard local(m_r_mtx1);
		m_r_LockObjs->get(m_r_currLockObj)= new Core::Guard(m_r_mtx0);
		return m_r_currLockObj++;
	}
	virtual void kill_ro_guard(int nObj)
	{
		Core::Guard local(m_r_mtx1);
		delete m_r_LockObjs->get(nObj);
		m_r_LockObjs->del(nObj);
	}
	virtual int get_guard()
	{
		Core::Guard local(m_mtx1);
		m_LockObjs->get(m_currLockObj)= new Core::Guard(m_mtx0);
		return m_currLockObj++;
	}
	virtual void kill_guard(int nObj)
	{
		Core::Guard local(m_mtx1);
		delete m_LockObjs->get(nObj);
		m_LockObjs->del(nObj);
	}
	virtual bool is_next_write()
	{
		Core::Guard *pWriteGuard= new Core::Guard(m_mtx2);
		if(t_id != ACE_OS::thr_self ()){
			set_transactionID();
			m_pWriteGuard= pWriteGuard;
		}else
			delete pWriteGuard;
		return true;
	}
	virtual void end_write()
	{
		Core::Guard local(m_mtx2);
		t_id= 0;
		delete m_pWriteGuard;
	}
	virtual void set_transactionID()
	{
		t_id= ACE_OS::thr_self ();
	}
	virtual void start_read_transaction(){
		if(!m_ro_Count){
			m_pROGuard= new Core::Guard(m_ro_mtx);
		}
		m_ro_Count++;
	}
	virtual void end_read_transaction(){
		m_ro_Count--;
		if(!m_ro_Count)
			delete m_pROGuard;
	}
private:
	ACE_thread_t t_id;// = ACE_OS::thr_self ();
	Core::Mutex m_mtx0, m_mtx1, m_r_mtx0, m_r_mtx1, m_mtx2, m_ro_mtx;
	int m_currLockObj, m_r_currLockObj, m_ro_Count;
	Core::Guard *m_pWriteGuard, *m_pROGuard;
};
#endif

} // namespace NdtClone

typedef NdtClone::Index Index;
typedef NdtClone::StoredSortedCollection StoredSortedCollection;
typedef NdtClone::BTStack BTStack;
typedef NdtClone::IndexInfo IndexInfo;

#ifndef PLAIN_GKDB
extern NdtClone::MultuThreadStreams *connect_MT_streams(NdtClone::PagedFile * strFile, int DefaultPageSizeInStreams= -1);
#endif
extern void StartThreadTransaction (NdtClone::StreamFile_List *p_list);
extern void EndThreadTransaction();
extern void StartROTransaction (NdtClone::StreamFile_List *p_list);
extern void EndROTransaction (NdtClone::StreamFile_List *p_list);


#endif
