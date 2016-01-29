//
// Implementation of standart B-tree with fixed-sized keys
// Author : Alex V. Boreskoff
//
// Structure of page
// ( int RecCount, long Ref0 ), ( ( key1, Ref1 ), ( key2, Ref2 ), ... )
//
// where keyn has size of KeyLength, size of Refn is sizeof ( long )
//

#ifndef __BTREE__
#define __BTREE__
 #if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
	#include "../../../Garant/Datastore/NdtClone/Common/btree.h"
 #else
#include "gardefs.h"
#include "pagefile.h"

#include <cstring>

namespace GKDB {
const int BT_MAXDEPTH   =  10;
const int BT_MAXKEYLEN  =  256;

const int BT_OK         =  0;
const int BT_NONE       =  1;
const int BT_DUPLICATE  =  2;
const int BT_ERROR      =  3;
const int BT_NOMEM      =  4;
const int BT_NOTFOUND   =  5;

const int BT_GO_TO_ROOT = 0x80;
} // namespace GKDB

typedef const void* BTKEY;

#pragma pack(1)

struct BTInit {
	long  Root;
	short Order;
	short KeyLength;
	long  KeyCount;
	short Height;
	long  LastId;
};

struct BTStackEx {
	long Page;
	int  Pos;  // position ( index ) of rec whose ref was used to go further
	int  Count;
};

struct BTStack : public BTStackEx {
	void* buf;
	char curKey  [GKDB::BT_MAXKEYLEN];
	char prevKey [GKDB::BT_MAXKEYLEN];
};

#pragma pack()

class BTIterator;

class BTree {
public:
	PagedFile* file;  // file used for paging
	int Flags;        // now used only PF_MODIFIED
	long KeyCount;    // total # of keys stored
	short Height;     // height of the tree
	long Root;        // root page of tree
	short KeyLength;  // length of key
	short Order;      // every page  (execpt root) contains Order..2*Order recs
	int LastId;       // id for every record

	BTStack Stack [GKDB::BT_MAXDEPTH]; // stack for path caching
	int Sp;                            // pointer to cached stack

	BTree ();

	virtual void init(PagedFile *pf, BTInit *init);
	virtual void shutdown(BTInit *init);
	virtual ~BTree ();

	int IsOk () const // whether tree is OK
	{
		return file->IsOk () && Root > 0l;
	}

	// initialize new B-tree
	void Create (short key_len);

	virtual BTKEY FullKey (const char* key) {
		long Page;     // page where the key is located
		int no;        // no. of record with the key
		int Result;

		void* buf = file->AllocBuf ();
		if (buf == 0) return 0;

		Result = LocateKey (key, buf, no, Page) == GKDB::BT_OK;
		file->FreeBuf (buf);

		void* fullKey = 0;

		if (Result) {
			fullKey = gk_malloc (KeyLength);
			memcpy (fullKey, key, KeyLength);
		}

		return (BTKEY) fullKey;
	}

	// add key to tree
	int AddKey (BTKEY key);

	// delete key from tree
	int DelKey (BTKEY key);

	// update key record
	int UpdateKey (BTKEY key);

	virtual int Compare (BTKEY, BTKEY) const;

	friend class BTIterator;     // class for iterating through tree

	void* RecOffs (void* buf, int rec) const {
		return 6 + rec * RecSize () + (char*) buf;
	}

private:
	int LocateKey (BTKEY key, void* buf, int&no, long& page);

	short RecSize () const {
		return KeyLength + 4;
	}

	void MovRecs (void* toBuf, int toRec, void* fromBuf, int fromRec, int count) {
		memmove (RecOffs (toBuf, toRec), RecOffs (fromBuf, fromRec), count * RecSize ());
	}

	void GetRec (void* page_buf, int rec, void* buf) const {
		memmove (buf, RecOffs (page_buf, rec), RecSize ());
	}

	void PutRec (void* page_buf, int rec, void* buf) {
		memmove (RecOffs ( page_buf, rec ), buf, RecSize ());
	}

	long GetRef (void* buf, int rec) const {
		return *(long*) (KeyLength + (char*) RecOffs (buf, rec));
	}

	void SetRef (void* buf, int rec, long ref) {
		*(long*) (KeyLength + (char*) RecOffs (buf, rec)) = ref;
	}

	long& Ref (void* buf, int rec) const {
		return *(long*) ( KeyLength + (char*) RecOffs (buf, rec));
	}

	long GetRef0 (void* buf) const {
		return *(long *)(2 + (char*) buf);   // note Ref0 == Ref ( -1 )
	}

	void SetRef0 (void* buf, long ref) {
		*(long *)(2 + (char*) buf) = ref;
	}

	short GetCount (void* buf) const {
		return *(short*) buf; 
	}

	void SetCount (void* buf, short n) {
		*(short*) buf = n;
	}

	short& RecCount (void* buf) const {
		return *(short*) buf;
	}

	int Insert (void* buf, int pos, void * ins_rec, void * save_rec);
	int BalancePages (long, void*, int, long, void*, int, long, void*);
	int MergePages (long, void*, int, long, void*, int, long, void*);

	int CheckCache (BTKEY key) const {
		return (Stack [Sp].Pos < Stack [Sp].Count && Compare (key, Stack [Sp].curKey) < 0) &&
			(Stack [Sp].Pos > 0 && Compare ( key, Stack [Sp].prevKey) > 0);
	}

protected:
	void free_read_only_bufs_on_BTStack();
	// find given key and fill buffer with key record
	int FindKey (BTKEY key, void* buf);
public:
	virtual bool IsExist( BTKEY key ){
		if(this->FindKey( key, alloca(this->KeyLength)) == GKDB::BT_OK )
			return true;
		return false;
	}
};

 #endif
#endif
