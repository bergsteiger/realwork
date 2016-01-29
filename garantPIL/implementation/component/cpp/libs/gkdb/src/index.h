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

#ifndef	__INDEX__
#define	__INDEX__

const int MAX_LEN_FOR_INDEX_NAME = 19;

#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
#include "../../../Garant/Datastore/NdtClone/Common/index.h"
#else
#include "btree.h"
#include "streams.h"
#include "garutils.h"

struct IndexInfo {
    struct BTInit btinit;
    short  immdatasize; /* size of the data may be stored with the key */
    short  rndv;        /* round value, set to 0 or 1 to disable */
                        /* additional space allocation */
    short nstreams;     /* number of data streams per key */
}__PACKED__;

class Index : public BTree {
public:
	char* pResultFileKeyName;
    char Name [MAX_LEN_FOR_INDEX_NAME + 1]; // index name
	int roundv;
	int nstreams; // number of data streams per key

	StreamFile* streams;
	int ImmDataSize;

	Index (PagedFile* tf, const char* name, StreamFile* str, IndexInfo* pInfo = 0);
	virtual ~Index ();

	virtual	void Create (short keysize,short rndv,short ns=1,short immsize=0);
	virtual	int	Compare (BTKEY key1, BTKEY key2) const
	{
	#ifdef IGNOREKEYCASE
		return StrNICmp ((char*) key1, (char*) key2, KeyLength);
	#else
		return strncmp ((char*) key1, (char*) key2, KeyLength);
	#endif
	}

	virtual int Delete (BTKEY key);
	virtual int Rename (BTKEY key1, BTKEY key2);
	virtual	Stream* Open (BTKEY key,int AutoCreate=0,int* pCreated=0);
	virtual	Stream* OpenN (BTKEY k, int sn, int ac=0, int* pCreated=0);
	virtual Stream* keyOpen (BTKEY k, int sn= 0);
	virtual	void Close (Stream* s);

	virtual	int	AddData (BTKEY key, const void * buf, int size, int nS=0);
	virtual	int	SetData (BTKEY key, const void * buf, int size, int nS=0);
	virtual	int	FindData (BTKEY key, void * buf, int buf_size, int nS=0);

	IndexRecordData* recordData (BTKEY key, int sn) const {
		return (IndexRecordData*)
			((char*)key + KeyLength - 
			 ((nstreams-sn)*
			 (sizeof(IndexRecordData::RecordDataHeader)+ImmDataSize)));
	}

	long& Size (BTKEY key, int sn=0) {
		return recordData(key,sn)->header.realDataLength;
	}

protected:
	virtual Stream* makeStream (StreamFile* p1, IndexRecordData* p2, int p3, int p4, int p5= 0);
};

#define	IsBlobPointer(xx,yy,zz) ((xx == 0 && *(short*)yy == 0x6c42 &&  zz == 8L))

#endif
#endif