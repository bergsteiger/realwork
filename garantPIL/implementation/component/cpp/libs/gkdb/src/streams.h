
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
// Author: Alex V.Boreskoff
// Last Modification : 28/05/97
//

#ifndef	__STREAMS__
#define	__STREAMS__
 #if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
		#include "../../../Garant/Datastore/NdtClone/Common/btree.h"
		#include "../../../Garant/Datastore/NdtClone/Common/streams.h"
	#else
#include "shared/DB/DBCore/DBCore.h"
#include "pagefile.h"

#define	SF_BUFDIRTY	0x0001		// internal buffer has been modified
#define	SF_MODIFIED	0x0002		// stream has been modified
#define	SF_DELETE	0x0020


#define	FAT_CHAIN	0x80000000l	// pages are chained

struct IndexRecordData
{
	struct RecordDataHeader {
		long realDataLength;
		long allocatedDataLength;
	} header;
	union RecordData {
		long handle;
		char   bin[4];		
	} data;
}__PACKED__;

class	Stream;
class	Index;


class	StreamFile			// Stream manager, all streams reside within this file
{
public:
	PagedFile * file;		// data file for all streams
	int	            Flags;
	int gk_huge	* Fat, *m_deletedFat;
	short	            fatPages;	// # of pages occupied by FAT
protected:
	char              * SysBuf;	// system buffer (size == pageSize)
public:
	StreamFile ( PagedFile * strFile, int bLoadFat );
	StreamFile ( PagedFile * strFile );
	~StreamFile ();

	void	Create ();		// create ( initialize ) file
	int	IsOk   () const		// whether file is OK
	{
		return file -> IsOk () && SysBuf != 0;
	}

protected:				// allocate new handle for data of given size
	long	NewHandle     ( long Size, long *p_bigHandle= 0  );

					// free handle
	int	DelHandle     ( long Handle, long bigHandle= 0 );

					// find page with given pos (no) in chain
	long	FindPage      ( long Handle, int PageNo, int Per4Bytes= 0 );

					// append new page to page chain
	long	AppendPage    ( long Handle, long bigHandle= 0 );

					// load block of data corresponding to
					// given page # into buffer
	int	LoadBlock     ( long Handle, int PageNo, void * buf, int Per4Bytes= 0 );

					// save buffer data corresponding to handle
					// into given page
	int	SaveBlock     ( long& Handle, int PageNo, void * buf, int Size, long *p_bigHandle= 0 );

					// remove subblock from non-chained page
	void	RemoveBlock   ( long Page, int Offs );

					// truncate stream to given size
	int	TruncStream   ( Stream * s, long NewSize, long *p_bigHandle= 0 );

					// locate subblock with given id & return its
					// offset ( or -1 if none ), loads SysBuf
	int	FindSubBlock  ( long Page, short id );
	int	FreePageChain ( long page );
					// allocate new page
	long	AllocPage     (int bigHandle= 0);	// increasing FAT size if required

public:
	virtual void LoadFat(PagedFile *otherLine= 0);
	void	SaveFat       ();
	int	CheckPage     ( long page );
	int	Check ();
	void StartTransaction() {}
	void EndTransaction() {}
	void AllocSysBuf() {}

	friend class Stream;
	friend class Index;
	friend class AttrIndex;
	void LoadFatEx (int hOtherSaveHandle, bool b_ignoreFOD= false) { return; }
protected:				// allocate new handle for data of given size
	virtual int GetPage(long page, void *buff){
		return file->GetPage(page, buff);
	}
	virtual int PutPage(long page, void *buff){
		return file->PutPage(page, buff);
	}
};

#ifdef  __cplusplus
extern "C" {
#endif
	typedef int (*PostMessageForResorceTom)(void);
#ifdef  __cplusplus
}
#endif

#define STREAM_PER_4BYTES 0x1968

class Stream : public DBCore::Store {
public:
	long Pos;              // current position within stream

protected:
	StreamFile* file;
	int Flags;
	long Handle;           // handle associated with this stream
	int realSize;         // current size of stream data
	long realSizeExt;      // current size of stream data
	long allocatedSize;
	long BufSize;          // == file -> file -> PageSize
	IndexRecordData* Rec;
	long ImmSize;
	long roundV;
	int m_Per4Bytes;

public:
	char* Buf;             // internal buffer
	char* IndexBuf;
	char* IndexFreeBuf;

	Stream (StreamFile* );
	Stream (StreamFile*, IndexRecordData* rec, int rec_size, long rv, int otherFile= 0);
	virtual ~Stream ();

	void closeAttrs ();

	virtual int Read  (void* buf, int Count);
	virtual int Write (const void* buf, int Count);
	virtual int Seek  (int);			// seek from beginning of file
	virtual int Trunc ();

	inline IndexRecordData* GetRec () const { 
		return Rec; 
	}
	inline StreamFile* GetStreamsFile() const {
		return file; 
	}

	virtual int Tell () const {
		if (Pos == MAX_BYTE_FILE_SIZE) {
			return m_Pos;
		}
		return Pos;
	}

	inline int Length () const {
		return realSize;
	}

	inline long AllocatedSize () const {
		return allocatedSize;
	}

	long SeekCur (long Offs) {
		return Seek (Tell () + Offs);
	}

	inline int Modified ()	{
		return Flags & SF_MODIFIED;
	}

	inline int SkipModified () {
		return Flags &= ~SF_MODIFIED;
	}

	inline bool isBigHandle () {
		if (allocatedSize & 0x80000000) {
			return true;
		}
		return false;
	}
	char *getTempBuf() const { return Buf; }
	void setTempBuf(char *pnew) { Buf= pnew; }
protected:
	int	SaveBlockSize ();
	int	Save ();				// flush buffer to disk
	
	int m_extBlobFileHandle;
	long m_Pos;

	PostMessageForResorceTom m_PostMessageForResorceTomFunc;

	friend class StreamFile;
};
	#endif
#endif
