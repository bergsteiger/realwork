//
// Implementation of standart B-tree with fixed-sized keys
// Author : Alex V. Boreskoff
//
// Structure of page
// ( int RecCount, long Ref0 ), ( ( key1, Ref1 ), ( key2, Ref2 ), ... )
//
// where keyn has size of KeyLength, size of Refn is sizeof ( long )
//

#ifndef __PILOT_BTREE__
#define __PILOT_BTREE__

#ifndef PLAIN_GKDB
	#include "shared/Core/sys/Logs.h"
#endif

#include "../../../../libs/cchlp/src/QMap.hpp"
#include "pagefile.h"

#include <cstring>

namespace GKDB
	{
	const int BT_MAXDEPTH		= 28;

	const int BT_OK				= 0;
	const int BT_NONE			= 1;
	const int BT_DUPLICATE		= 2;
	const int BT_ERROR			= 3;
	const int BT_NOMEM			= 4;
	const int BT_NOTFOUND		= 5;

	const int BT_GO_TO_ROOT	= 0x80;
	}

namespace NdtClone {

typedef const void* BTKEY;
const int BT_OK			= 0;

struct  BTStackEx
{
        int    Page;
        int     Pos;            // position ( index ) of rec whose ref was used to go further
        int     Count;
};

struct  BTStack : public BTStackEx
{
        void  * buf;
        char    *curKey;
        char    *prevKey;
};

class   BTIterator;

class NDTKPage {
	char *m_data;
public:
	inline NDTKPage(const int start= 0) : m_data(0) { }
	inline NDTKPage(PagedFile *pFile, const void *pData)
	{
		m_data= new char[pFile->PageSize];
		if(pData){
			memcpy(m_data, pData, pFile->PageSize);
		}
	}
	void *GetData() const { return (void*)m_data; }
	void KillData(){ m_data= 0; }
	inline NDTKPage(const NDTKPage& c)
	{
		m_data= (char*)c.GetData();
		((NDTKPage*)&c)->KillData();
	}
	inline NDTKPage& operator = (const NDTKPage& c) {
		if(this->m_data)
			delete [](this->m_data);
		this->m_data= (char*)c.GetData();
		((NDTKPage*)&c)->KillData();
		return *this;
	}	
	~NDTKPage(){
		if(m_data)
			delete []m_data;
	}
};

typedef QuickValSplayMap<int,int> NDTPageNMap;
typedef QuickValSplayMap<int,NDTKPage> NDTKPageMap;

class CachedPage;

class   BTree
{
protected:
	virtual void abort(void){
		global_Block();
	}
public:
	NdtClone::NDTKPageMap *pWritedPages;
	virtual int GetPage(int page, void*buff);
	virtual int PutPage(int page, void*buff, int onlyPut= 0);
	virtual void PutRootPage(void  * buf);
        PagedFile * file;              // file used for paging
        PagedFile * fileUpdt;              // file used for paging
        int          Flags;             // now used only PF_MODIFIED
        int         KeyCount;          // total # of keys stored
        short        Height;            // height of the tree
        int         Root, preRoot;              // root page of tree
        short        KeyLength;         // length of key
        short        Order;             // every page  (execpt root) contains Order..2*Order recs
        int         LastId;            // id for every record
                                        // stack for path caching
        BTStack      *Stack;
        int          Sp;                // pointer to cached stack

        BTree ();
		virtual void init(PagedFile *pf, BTInit *init);
		virtual void shutdown(BTInit *init);
        virtual ~BTree ();

        int     IsOk () const // whether tree is OK
        {
                return file -> IsOk () && Root > 0l;
        }
                                        // initialize new B-tree
        void    Create    ( short key_len );

		virtual BTKEY   FullKey( const char* key) {
			int    Page;                           // page where the key is located
			int     no;                             // no. of record with the key
			int     Result;
	        
			void  * buf = file -> AllocBuf ();
			if ( buf == 0 ) return 0;

			Result = LocateKey ( key, buf, no, Page ) == GKDB::BT_OK;
	        file -> FreeBuf ( buf );

			void* fullKey = 0;
			if ( Result ) {
				fullKey = malloc ( KeyLength );
				memcpy ( fullKey, key, KeyLength );
			}

			return (BTKEY) fullKey;
		}
		int FindOk() const { return GKDB::BT_OK; }
                                        // add key to tree
	virtual	void   PrepareRecord  ( BTKEY key, char * buf1= 0 ) {}
	int     AddKey    ( BTKEY key, void *pBuff= (void *)-1, int AutoAdd= 0 );

                                        // delete key from tree
        void *DelKey    ( BTKEY key );

                                        // update key record
        int     UpdateKey ( BTKEY key );

        virtual int     Compare ( BTKEY, BTKEY ) const;

		friend  class   BTIterator;     // class for iterating through tree

        virtual void  * RecOffs ( void * buf, int rec ) const
        {
                return 6 + rec * RecSize () + (char *) buf;
        }
		virtual int GetNext(char * keyPtr)
		{
			return * (int *) ( keyPtr - 4 );
		}
        int     LocateKey ( BTKEY key, void * buf, int&no, int& page, int AutoAdd= 0  );
        virtual short   GetCount ( void* buf ) const
        {
                return * (short *) buf; 
        }
		char *pNextMemForStacksBuf;
		void *GetNextMemForStacksBuf()
		{
			if(pNextMemForStacksBuf){
				pNextMemForStacksBuf += file->PageSize;
				return pNextMemForStacksBuf;
			}
			return malloc(file->PageSize);
		}
		virtual char *PrepareStackBuff( int page, char *cur, void* buf1);
		virtual int LastCompare( BTKEY cur, BTKEY buf1, int preComp);
		virtual void PrepareStackBuffWrite() {}
		virtual void UpdateUpKey(int AutoAdd, char *old_key, char* new_key)
		{
			if(AutoAdd == -1){
				m_bAsNew= false;
			}
			memcpy ( Stack [Sp].curKey, old_key, KeyLength );
		}
protected:
	virtual char *readPage(long Page){
		return 0;
	}
	bool m_bAsNew;
private:

        virtual short   RecSize () const
        {
                return KeyLength + 4;
        }
        void    MovRecs ( void * toBuf, int toRec, void * fromBuf, int fromRec, int count )
        {
                memmove ( RecOffs ( toBuf, toRec ), RecOffs ( fromBuf, fromRec ), count * RecSize () );
        }

        void    GetRec ( void * page_buf, int rec, void * buf ) const
        {
                memmove ( buf, RecOffs ( page_buf, rec ), RecSize () );
        }

        void    PutRec ( void * page_buf, int rec, void * buf )
        {
                memmove ( RecOffs ( page_buf, rec ), buf, RecSize () );
        }

        int    GetRef ( void * buf, int rec ) const
        {
                return * (int *) ( KeyLength + (char *)RecOffs ( buf, rec ) );
        }

        void    SetRef ( void * buf, int rec, int ref )
        {
                * (int *) ( KeyLength + (char *)RecOffs ( buf, rec ) ) = ref;
        }

        int&   Ref ( void * buf, int rec ) const
        {
                return * (int *) ( KeyLength + (char *) RecOffs ( buf, rec ) );
        }

        int    GetRef0 ( void * buf ) const
        {
                return * (int *)( 2 + (char *)buf );   // note Ref0 == Ref ( -1 )
        }

        void    SetRef0 ( void * buf, int ref )
        {
                * (int *)( 2 + (char *)buf ) = ref;
        }

        void    SetCount ( void * buf, short n )
        {
                * (short *) buf = n;
        }

        short&  RecCount ( void * buf ) const
        {
                return * (short *) buf;
        }

        int     Insert ( void * buf, int pos, void * ins_rec, void * save_rec );
        int     BalancePages ( int, int, void *, int, int, void * );
        int     MergePages ( void *, int, int, void *, int, int, void * );

        int     CheckCache ( BTKEY key ) const
        {
                return ( Stack [Sp].Pos < Stack [Sp].Count && Compare ( key, Stack [Sp].curKey ) < 0 ) &&
                       ( Stack [Sp].Pos > 0 && Compare ( key, Stack [Sp].prevKey ) > 0 );
        }
protected:
	virtual int initCritical()
	{ 
		return 0;
	}
	virtual void skipCritical() = 0;
public:
	virtual char *cachedPage(long Page, CachedPage **ppRet= 0) { return 0; }
protected:
	void *CreateInfo(short key_len);
	virtual void *DeleteUpKey() { return (void*)-1; }
									// find given key and fill
									// buffer with key record
	int     FindKey   ( BTKEY key, void * buf, int AutoAdd= 0 );
	virtual int	NewPage (void *bf= 0){
		this->abort();//return file -> NewPage ();
		return 0;
	}
	BTKEY m_key;
public:
	virtual bool IsExist( BTKEY key );
	virtual void StartBackupEx ( int AutoCreate= 1 ){
		this->abort();
	}
};
} // namespace NdtClone

typedef NdtClone::BTKEY BTKEY;
typedef NdtClone::BTree BTree;
typedef NdtClone::BTStackEx BTStackEx;
#endif
