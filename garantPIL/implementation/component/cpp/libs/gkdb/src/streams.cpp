#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
	#include "../../../Garant/Datastore/NdtClone/Common/streams.cpp"
	#include "../../../Garant/Datastore/NdtClone/Common/exceptions.cpp"
#else
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
// Author: Alex V.Boreskoff
// Last Modification : 30/05/97
//

#include "osdep.h"
#include "streams.h"

#include <cstring>
#include <algorithm>

extern "C" {

#ifdef	__BORLANDC__
#include <ctype.h>
#endif
		// in GSSCREEN.LIB //
		extern void clear_video(void);     /*  Clear screen */
		// show message, trunc if lenght more then 50 //
		extern void show_message(const char *);

		int DefaultMessageForResorceTomFunc(void)
		{
			assert(0);
			return 1;
		}
}

#pragma pack(1)
struct	BlockDesc
{
	short	Id;	   // unsigned Id   : 11; FUCK this stupid MSVC
	short	Size;	   // unsigned Size : 13;
}__PACKED__;
#pragma pack()

inline	long	Handle4Page ( long Handle )
{
	return BIG_STREAM_HANDLE_TO_PAGE(Handle);
}

inline	long	Handle2Page ( long Handle )
{
	return OLD_STREAM_HANDLE_TO_PAGE(Handle);
}

inline	long	Handle3Page ( long Handle )
{
	return ((unsigned long)Handle) >> 10;
}

inline	short	Handle2Id ( long Handle )
{
	return OLD_STREAM_HANDLE_TO_ID(Handle);
}

inline	short	Handle3Id ( long Handle )
{
	return (short)( Handle & 0x03FF );
}

inline	short	Handle4Id ( long Handle, long Low )
{
	return BIG_STREAM_HANDLE_TO_ID(Handle,Low);
}


StreamFile :: StreamFile ( PagedFile * strFile, int bLoadFat )
{
	m_deletedFat= 0;
	file   = strFile;
	SysBuf = new char [file -> PageSize];
	Flags  = 0;
	if ( file->PageSize == 0 )
		bLoadFat = 0;

	if(bLoadFat)
		LoadFat ();
	else
		Fat= 0;
}

StreamFile :: StreamFile ( PagedFile * strFile )
{
	m_deletedFat= 0;
	file   = strFile;
	SysBuf = new char [file -> PageSize];
	Flags  = 0;

	LoadFat ();
}

StreamFile :: ~StreamFile ()
{
  if(!(Flags & SF_DELETE)) { Flags |= SF_DELETE;
#ifndef BRDR32
	if ( file->Flags & PF_PUTPAGE )
		SaveFat ();
#endif
	if(m_deletedFat)
		gk_free ( m_deletedFat );
	delete[] SysBuf;
	delete file;
  }
}

void	StreamFile :: Create ()
{
	if ( file -> NewPage () != file->LastPage )
		assert ( 0 );

	memset ( Fat, '\0', file -> PageSize );

	Fat [file->LastPage]  = FAT_CHAIN;
	fatPages = 1;
	Flags   |= PF_MODIFIED;

	file -> PutAttr ( "FatSize", &fatPages, sizeof ( short ) );
}

void	StreamFile :: LoadFat (PagedFile *otherLine)
{
	if ( !file -> GetAttr ( "FatSize", &fatPages, sizeof ( short ) ) )
		fatPages = 1;

	m_deletedFat= Fat = (int gk_huge *)gk_malloc(((unsigned short*)&fatPages)[0]*(long)file->PageSize);
	if ( file -> GetPage ( 1, Fat ) )	// Fat already exists
	{
		char gk_huge *ptr = (char gk_huge *) Fat;
		for ( long page = Fat [1] & ~FAT_CHAIN, pageCount = 0; 
			page != 0; page = Fat [page] & ~FAT_CHAIN, pageCount++ )
		{
			ptr += file -> PageSize;
			if(!(pageCount <  (long)(0xffff & *((unsigned short*)&fatPages))) || !file -> GetPage ( page, ptr )){
				file= 0;
				break;
			}
		}
	}
}

void	StreamFile :: SaveFat ()
{
	char gk_huge * ptr = (char gk_huge *) Fat;
	long page;

	page = 1;

	while(page != 0 ) 
	{
		if(file -> PutPage ( page, ptr ))
			ptr += file -> PageSize;
		else{
			printf("\nError put Page(%d) !!",page );
			abort();
		}
		page = Fat [page] & ~FAT_CHAIN;
	}
	file -> PutAttr ( "FatSize", &fatPages, sizeof ( short ) );
}

long	StreamFile :: AllocPage (int bigHandle)
{
	long	newPage  = file -> NewPage ();
	long	maxPages = (long)fatPages * (long)file -> PageSize / sizeof ( long );

	if ( newPage < maxPages )
		return newPage;

				// increase Fat size by 1 page
				// allocate new
	long        newSize = (long) ( fatPages + 1 ) * (long) file -> PageSize;
	m_deletedFat  = (int *) realloc ( m_deletedFat, newSize );
	memset(((char*)m_deletedFat) + newSize - file -> PageSize, 0, file -> PageSize);
	fatPages++;		// append one more page to Fat chain
	Fat = m_deletedFat;
	/*if(*(long*)(file->m_pCryptoTag) > file->PageSize)
		AppendPage ( (bigHandle ? (3 << 5) : (3 << 12)), bigHandle );
	else*/
		AppendPage ( (bigHandle ? (1 << 5) : (1 << 12)), bigHandle );

	return newPage;
}

int	StreamFile :: FindSubBlock ( long Page, short id )
{
	BlockDesc * BlockPtr = (BlockDesc *) SysBuf;

	if ( !GetPage ( Page, SysBuf ) )
		return -1;
	int Offs;
	for ( Offs = 0; BlockPtr -> Id != id && BlockPtr -> Id != 0; BlockPtr = (BlockDesc *)( SysBuf + Offs ) )
	{
		Offs += sizeof ( BlockDesc ) + BlockPtr -> Size;

		if ( Offs >= file -> PageSize )		// somehow get out of range
			return -1;
	}

	if ( BlockPtr -> Id != id )
		return -1;

	return Offs;
}

long	StreamFile :: NewHandle ( long Size, long *p_bigHandle )
{
	long	Page = -1l;

	if ( Size >= (long)(file -> PageSize - sizeof ( BlockDesc ))) {
		// allocate whole page

		Page = AllocPage (p_bigHandle ? *p_bigHandle : 0);

		memset ( SysBuf, '\0', file -> PageSize );
		PutPage ( Page, SysBuf );

		Fat [Page] = FAT_CHAIN;			// set hi-bit to 1, next page to 0
		Flags     |= PF_MODIFIED;

		if(p_bigHandle){
			*p_bigHandle &= ~0x7f000000;
			return Page << 5;
		}
		return Page << 12;
	}

	for ( long i = 0; i <= file -> LastPage; i++ ){
		// try to use existing page
		if ((Fat[i]&FAT_CHAIN)==0 && Fat[i]>=(long)(Size+sizeof(BlockDesc))){
			Page = i;
			break;
		}
	}

	if ( Page == -1l ) {
		// allocate new page

		Page = AllocPage (p_bigHandle ? *p_bigHandle : 0);
		memset ( SysBuf, '\0', file -> PageSize );
		Fat [Page] = file -> PageSize;
	}else{
		GetPage ( Page, SysBuf );
	}

	BlockDesc	d        = { 1, 0 };
	BlockDesc     * BlockPtr = (BlockDesc *) SysBuf;
	{
		int Offs = 0;
		if(BlockPtr -> Id == 0){
			memset(SysBuf, 0, file->PageSize);
		}else do{
			if ( BlockPtr -> Id == d.Id )
			{
				d.Id ++;
				Offs = 0;
			}
			else{
				Offs += sizeof ( BlockDesc ) + BlockPtr -> Size;
				if(file->PageSize-Offs <= Fat[Page]){
					((BlockDesc *)( SysBuf + Offs ))->Id= 0;
				}
			}
			BlockPtr = (BlockDesc *)( SysBuf + Offs );
		}while(BlockPtr -> Id != 0);
	}
	memmove ( BlockPtr, &d, sizeof ( BlockDesc ) );

	Fat [Page] -= sizeof ( BlockDesc );
	Flags      |= PF_MODIFIED;

	PutPage ( Page, SysBuf );

	if(!p_bigHandle)
		return ( Page << 12 ) | d.Id;

	Size = (long)(d.Id & 0x7f);	// low bits from Id
	*p_bigHandle &= ~0x7f000000;	// erase old low bits in Stream::allocatedSize
	*p_bigHandle |= Size << 24;	// put new low bits in Stream::allocatedSize

	return ( Page << 5 ) | (d.Id >> 7);
}

int	StreamFile :: DelHandle ( long Handle, long bigHandle )
{
	if ( Handle == 0 )
		return 1;

	long	Page = bigHandle ? Handle4Page ( Handle ) : Handle2Page ( Handle );
	short	Id = (bigHandle == STREAM_PER_4BYTES ? Handle3Id ( Handle )
					: (bigHandle ? Handle4Id ( Handle, bigHandle ): Handle2Id ( Handle )));

	if ( Id == 0 )			// chain of pages
		return FreePageChain ( Page );

					// it's a block on a page, so locate it
	int	Offs = FindSubBlock ( Page, Id );

	if ( Offs < 0 )			// error
		return 0;

	RemoveBlock ( Page, Offs );

	return 1;
}

long	StreamFile :: FindPage ( long Handle, int PageNo, int Per4Bytes )
{
	long Page = (Per4Bytes == STREAM_PER_4BYTES ? Handle3Page ( Handle )
					: (Per4Bytes ? Handle4Page ( Handle )
							: Handle2Page ( Handle )));

	while ( PageNo-- > 0 )
	{
		assert ( ( Fat [Page] & FAT_CHAIN ) != 0 );

		Page = Fat [Page] & ~FAT_CHAIN;

		if ( Page == 0 )
			return 0;
	}

	return Page;
}

long	StreamFile :: AppendPage ( long Handle, long bigHandle )
{
	long	Page = bigHandle ? Handle4Page ( Handle ) : Handle2Page ( Handle );

	assert ( ( Fat [Page] & FAT_CHAIN ) != 0 );
	long i;
	for ( i = Page; Fat [i] & ~FAT_CHAIN; )	// find last page
		i = Fat [i] & ~FAT_CHAIN;
							// set hi-bit to 1 and set next page
	Page       = AllocPage (bigHandle);
	Fat [i]    = FAT_CHAIN | (int) Page;
	Fat [Page] = FAT_CHAIN;
	Flags     |= PF_MODIFIED;

	return Page;
}

int	StreamFile :: FreePageChain ( long Page )
{
	while ( Page != 0 )
	{
		long	nextPage = (long) ( Fat [Page] & ~FAT_CHAIN );

		assert ( ( Fat [Page] & FAT_CHAIN ) != 0 );

		Fat [Page] = 0;				// mark page as FREE

		file -> DelPage ( Page );

		Page = nextPage;
	}

	Flags |= PF_MODIFIED;

	return 1;
}

/*!
	load block ( page ) from stream with a given number
	returns
	# of bytes transferred, or -1 if error
*/

int	StreamFile :: LoadBlock ( long Handle, int PageNo, void * buf, int Per4Bytes )
{

	short	Id = (Per4Bytes == STREAM_PER_4BYTES ? Handle3Id ( Handle )
					: (Per4Bytes ? Handle4Id ( Handle, Per4Bytes ): Handle2Id ( Handle )));
	long page;

	if ( Id == 0 )			// chain of pages
	{
		if((page= (Per4Bytes == STREAM_PER_4BYTES ? FindPage ( Handle, PageNo, STREAM_PER_4BYTES)
			: ( Per4Bytes ? FindPage ( Handle, PageNo, Per4Bytes) : FindPage ( Handle, PageNo )) ))){
			if ( GetPage ( page, buf ) )
				return file -> PageSize;
			abort();
		}else
			return 1;
	}
	// it's a subblock on a page
	int	Offs = FindSubBlock ( Per4Bytes == STREAM_PER_4BYTES ? Handle3Page ( Handle )
								: (Per4Bytes ? Handle4Page ( Handle ) : Handle2Page ( Handle )), Id );

	if ( Offs < 0 )			// error
		return -1;

	BlockDesc * BlockPtr = (BlockDesc *) ( SysBuf + Offs );

	memmove ( buf, BlockPtr + 1, BlockPtr -> Size );

	return BlockPtr -> Size;
}


/*!
	saves block ( page ) from stream with a given number
	Handle may be modified due to reallocation
	returns
	# of bytes transferred, or -1 if error
*/

int	StreamFile::SaveBlock(long& Handle, int PageNo, void * buf, int Size, long *p_bigHandle )
{
	if ( Handle == 0 )
		Handle = NewHandle ( Size, p_bigHandle );

Retry:
	short	Id = p_bigHandle ? Handle4Id ( Handle, *p_bigHandle ) : Handle2Id ( Handle );
	long	Page;

	if ( Id == 0 )				// chain of pages
	{
		if ( (p_bigHandle && ( Page = FindPage ( Handle, PageNo, *p_bigHandle ) ) == 0)
				||
				(!p_bigHandle && ( Page = FindPage ( Handle, PageNo ) ) == 0)	)
				Page = AppendPage ( Handle, p_bigHandle ? *p_bigHandle : 0 );

		if ( PutPage ( Page, buf ) )
			return Size;
		else
			return -1;
	}

						// subblock on a page
	int	Offs = FindSubBlock ( Page = (p_bigHandle ? Handle4Page ( Handle ) : Handle2Page ( Handle )), Id );

	if ( Offs < 0 )			// error
		return -1;

	BlockDesc * BlockPtr = (BlockDesc *) ( SysBuf + Offs );

	if ( Size >= file -> PageSize || (long)(( Fat [Page] & ~FAT_CHAIN ) + BlockPtr -> Size) < Size )
	{
		RemoveBlock ( Page, Offs );

		Handle = NewHandle ( Size, p_bigHandle );

		goto Retry;
	}

	int	Delta = Size - BlockPtr -> Size;
						// now it's possible to do in-page modifications
						// make Offs point to next block
	Offs += sizeof ( BlockDesc ) + BlockPtr -> Size;

	assert(file -> PageSize - Offs - Delta > -1);
	memmove ( SysBuf + Offs + Delta, SysBuf + Offs, file -> PageSize - Offs - Delta );
	memmove ( BlockPtr + 1, buf, Size );

	BlockPtr -> Size   = Size;
	Flags             |= PF_MODIFIED;

	if(Delta < 0 && Fat[Page] < 1){
		// valid for new block //
		memset(SysBuf + file -> PageSize + Delta, 0, -Delta);
	}
	Fat [Page]        -= Delta;			// there must be enogh space to keep hi-bit

	if ( PutPage ( Page, SysBuf ) )
		return Size;
	else
		return -1;
}

int	StreamFile :: TruncStream ( Stream * str, long NewSize, long *p_bigHandle )
{
	if ( NewSize == str -> realSize )
		return 1;

	short	Id = ((p_bigHandle && *p_bigHandle == STREAM_PER_4BYTES) ? Handle3Id ( str -> Handle )
					: ((p_bigHandle && *p_bigHandle) ? Handle4Id ( str -> Handle, *p_bigHandle ): Handle2Id ( str -> Handle )));

	if ( Id == 0 )			// chain of pages
	{				// check if it can be reallocated as subblock
		if ( NewSize < (long)(file -> PageSize - sizeof ( BlockDesc )) )
		{
			long	oldBigHandle = (p_bigHandle ? (*p_bigHandle) : 0);

			str->allocatedSize |= 0x80000000;
			long Handle2 = NewHandle ( NewSize, &(str->allocatedSize) );

			DelHandle ( str -> Handle, (p_bigHandle ? oldBigHandle : 0) );
			str -> Handle = Handle2;

			return 1;
		}

		long Page= (int)( NewSize / file -> PageSize );

		if(p_bigHandle){
			Page= (*p_bigHandle == STREAM_PER_4BYTES ? FindPage ( str -> Handle, Page, STREAM_PER_4BYTES)
				: FindPage ( str -> Handle, Page, *p_bigHandle));
		}else
			Page = FindPage ( str -> Handle, Page );

		long	nextPage = (long) ( Fat [Page] & ~FAT_CHAIN );

		Fat [Page] = FAT_CHAIN;			// clear low-order bits (Next = 0)

		FreePageChain ( nextPage );
	}
	else						// do in-page modification
	{
		long	    Page = p_bigHandle ? Handle4Page ( str -> Handle ) : Handle2Page ( str -> Handle );
		int	    Offs;
		BlockDesc * BlockPtr;

		if ( ( Offs = FindSubBlock ( Page, Id ) ) < 0 )
			return -1;

		BlockPtr = (BlockDesc *)( SysBuf + Offs );

		int	Delta = (int)( BlockPtr -> Size - NewSize );
		int	Offs2 = Offs + BlockPtr -> Size + sizeof ( BlockDesc );

		if ( Delta <= 0 ) return 1; //????
		assert ( Delta > 0 );

		memmove ( SysBuf + Offs2 - Delta, SysBuf + Offs2, file -> PageSize - Offs2 );
		memset  ( SysBuf + file -> PageSize - Delta, '\0', Delta );

		Fat [Page]       += Delta;		// hope hi-bit won't be affected
		BlockPtr -> Size -= Delta;		// adjust subblock size

		PutPage ( Page, SysBuf );
	}

	Flags |= PF_MODIFIED;

	return 1;
}

void	StreamFile :: RemoveBlock ( long Page, int Offs )
{
	BlockDesc * BlockPtr = (BlockDesc *)( SysBuf + Offs );
	int	    Size     = BlockPtr -> Size;
	int	    Offs2    = Offs + sizeof ( BlockDesc ) + Size;

	Fat [Page] += sizeof ( BlockDesc ) + Size;		// hope hi-bit won't be affected
	memmove ( SysBuf + Offs, SysBuf + Offs2, file -> PageSize - Offs2 );
	memset  ( SysBuf + file -> PageSize - sizeof ( BlockDesc ) - Size, '\0', sizeof ( BlockDesc ) + Size );

	PutPage ( Page, SysBuf );

	Flags |= PF_MODIFIED;
}

int	StreamFile :: CheckPage ( long page )
/*
 * return 0 if page ok; 
 *        diff otherwise
 */
{
	if ( Fat [page] & FAT_CHAIN )
		return 0;

	int	FreeSpace1 = Fat [page];
	int	FreeSpace2 = file -> PageSize;
	void  * buf = file -> AllocBuf ();

	BlockDesc     * BlockPtr = (BlockDesc *) buf;

	GetPage ( page, buf );

	for ( int Offs = 0; Offs < (long)(file -> PageSize - sizeof ( BlockDesc )) && BlockPtr -> Id != 0; BlockPtr = (BlockDesc *)( Offs + (char *) buf ) )
	{
		FreeSpace2 -= sizeof ( BlockDesc ) + BlockPtr -> Size;
		Offs       += sizeof ( BlockDesc ) + BlockPtr -> Size;
	}

	file -> FreeBuf ( buf );

	return FreeSpace1 - FreeSpace2;
}

int	StreamFile :: Check ()
{
	int diff;
	int rv = 1;
	for ( long i = fatPages + 1; i <= file -> LastPage; i++ ){
		diff = CheckPage ( i );
		if ( diff ) {
			fprintf (stdout, "Streams : error on page %ld (%d)\n", i, diff );
			rv =  0;
		}
	}

	return rv;
}

Stream :: Stream ( StreamFile * sFile )
{
	file     = sFile;
	Flags    = 0;
	realSize = allocatedSize    = 0;
	roundV = 0;
	Pos      = 0;
	Handle   = 0;
	IndexBuf = IndexFreeBuf= Buf= 0;
	if(file){
		BufSize  = file -> file -> PageSize;
		Buf      = (char*)malloc( BufSize + roundV) ;
		memset ( Buf, '\0', BufSize );
	}
	Rec      = 0;
	ImmSize  = 0;
	IndexBuf = 0;
}

extern "C" {
extern int CreatedBigStream;
}

Stream::Stream(StreamFile*sFile,IndexRecordData*rec,int rec_size,long rv, int otherFile)
{
	file     = sFile;
	Flags    = 0;
  if(rec){
	realSize     = rec->header.realDataLength;
	allocatedSize = rec->header.allocatedDataLength;
	roundV = rv;
	Pos      = 0;
	BufSize  = file -> file -> PageSize;
	Buf      = (char*)calloc( 1, BufSize + roundV) ;
	Rec      = rec;
	ImmSize  = rec_size;
	IndexFreeBuf= IndexBuf= 0;

	m_Per4Bytes= (otherFile == STREAM_PER_4BYTES ? STREAM_PER_4BYTES : 0);

	heap   ();
	assert ( Buf != 0 );

	if ( realSize <= ImmSize ){
		// data are inside Rec ( immediate data )

		Handle = 0;
		memmove ( Buf, rec->data.bin, ImmSize );

		if(CreatedBigStream)
			allocatedSize |= 0x80000000;

		if(isBigHandle())
			m_Per4Bytes= allocatedSize;

	}else {
		Handle = rec ->data.handle;
		if(isBigHandle())
			m_Per4Bytes= allocatedSize;
		file -> LoadBlock ( Handle, 0, Buf, m_Per4Bytes );
	}
	m_extBlobFileHandle= -1;
	m_PostMessageForResorceTomFunc= DefaultMessageForResorceTomFunc;
	if(otherFile && otherFile != STREAM_PER_4BYTES){
		Pos= (long)MAX_BYTE_FILE_SIZE;
		realSizeExt= realSize= *((long*)Buf+1);
		long pgcount= realSize / file->file->PageSize;
		if(realSize & ((1 * file->file->PageSize)-1)){
			pgcount++;
			realSizeExt= pgcount * file->file->PageSize;
		}
		m_Pos= 0L;
		m_extBlobFileHandle= -1;
	}
  }else{
	Flags    = 0;
	Rec= 0;
	Buf= 0;
	realSize = allocatedSize    = 0;
	m_Per4Bytes= 0;
	IndexFreeBuf= IndexBuf= 0;
  }
}

void Stream :: closeAttrs ()
{
	if(Buf){
		if(Modified ()){
			if ( Flags & SF_BUFDIRTY )
				Save ();

			if ( Rec != 0 )
			{
				Rec->header.realDataLength = realSize;
				Rec->header.allocatedDataLength = allocatedSize;

				if ( realSize > ImmSize )
					Rec->data.handle = Handle;
			}
		}
		if(m_extBlobFileHandle != -1)
		{
			abort();//ace_os_close(m_extBlobFileHandle);
		}
		free( Buf );
	}
	Buf= 0;
}

Stream :: ~Stream ()
{
	closeAttrs ();
	if(IndexFreeBuf)
		free( IndexFreeBuf );
}

int	Stream :: Save ()
{
	Flags &= ~SF_BUFDIRTY;

	if ( realSize <= ImmSize && Rec != 0 )
	{
		memmove ( Rec->data.bin, Buf, (int) realSize );
		allocatedSize = ImmSize;
		return 1;
	}else{
		return file->SaveBlock(
							   Handle,
							   (int)(Pos/BufSize),
							   Buf, 
							   SaveBlockSize (), isBigHandle() ? &allocatedSize : 0 );
	}

}

int	Stream :: SaveBlockSize ()
{
	int rv;

	if ( (Handle == 0) || (isBigHandle() && Handle4Id(Handle, allocatedSize)) || (!isBigHandle() && Handle2Id(Handle)) ){	
		// (handle not allocated yet so Size < PageSize) ||
		// (handle belongs to subblock)
		rv = ((realSize+roundV-1)/roundV)*roundV;
		if( rv >= BufSize ){
			rv = BufSize - 1;
		}
		allocatedSize &= 0xff000000;
		allocatedSize |= rv;
	}else{
		rv =  BufSize;
	}

	return rv;
}

extern "C" char *GetBasedExtFileName( char *, int );

int	Stream :: Read (void* buf, int Count) {
	if ( Pos + Count > realSize )
		Count = realSize - Pos;

	unsigned long	TotalCount = Count;
	unsigned long	PageNo     = ( Pos / BufSize );

	while ( Count > 0 )	{
		short	Id = (m_Per4Bytes == STREAM_PER_4BYTES ? Handle3Id ( Handle )
						: (isBigHandle() ? Handle4Id ( Handle, allocatedSize ): Handle2Id ( Handle )));
		unsigned long	BlockSize= ( Id != 0 ? realSize : BufSize - ( Pos % BufSize ) );
		unsigned long	TransfSize = Count < (long)BlockSize ? Count : BlockSize;

		memmove ( buf, Buf + ( Pos % BufSize ), TransfSize );

		buf    = TransfSize + (char gk_huge *) buf;
		Pos   += TransfSize;
		Count -= TransfSize;

		if ( Pos / BufSize != (long)PageNo ) {
			if ( Flags & SF_BUFDIRTY ){	
				// save buffer if it has been modified
				if(isBigHandle()){
					file -> SaveBlock ( Handle, PageNo, Buf, Id != 0 ? (int)realSize : BufSize, &allocatedSize );
					m_Per4Bytes= allocatedSize;
				}else{
					file -> SaveBlock ( Handle, PageNo, Buf, Id != 0 ? (int)realSize : BufSize );
					Flags &= ~SF_BUFDIRTY;
				}
			}
			file -> LoadBlock ( Handle, ++ PageNo, Buf, isBigHandle() ? allocatedSize : m_Per4Bytes );
		}
	}

	heap ();

	return TotalCount;
}

int	Stream :: Write (const void* buf, int Count) {
	long	TotalCount = Count;
	int	PageNo     = (int)( Pos / BufSize );

	while ( Count > 0 )	{
		int	BlockSize = static_cast<int>( std::min<long>( Count, BufSize - ( Pos % BufSize ) ) );

		memmove ( Buf + (int)( Pos % BufSize ), buf, BlockSize );

		buf    = BlockSize + (char *) buf;
		Count -= BlockSize;
		Pos   += BlockSize;
		Flags |= SF_BUFDIRTY;

		if ( Pos > realSize )
			realSize = Pos;

		if ( Count > 0 )		// there're more bytes to copy
		{
			file -> SaveBlock ( Handle, PageNo, Buf, SaveBlockSize (),
				isBigHandle() ? &allocatedSize : 0 );
			Flags &= ~SF_BUFDIRTY;
		}

		if ( Pos / BufSize != PageNo ){
			// reload buffer, so it always contains current position
			// before reloading buffer must save
			if ( Flags & SF_BUFDIRTY )	{
				file -> SaveBlock ( Handle, PageNo, Buf, SaveBlockSize (),
					isBigHandle() ? &allocatedSize : 0 );
				Flags &= ~SF_BUFDIRTY;
			}

			PageNo ++;		// since block has changed

			if ( Pos < realSize )	// there're bytes to read
				file -> LoadBlock ( Handle, PageNo, Buf, isBigHandle() ? allocatedSize : m_Per4Bytes );
			else
				memset ( Buf, '\0', BufSize );

		}
	}

	Flags |= SF_BUFDIRTY | SF_MODIFIED;

	heap ();

	return TotalCount;
}

int	Stream :: Seek ( int NewPos )
{
    if(Pos == MAX_BYTE_FILE_SIZE)
    {
		if ( NewPos > realSizeExt )	// do not allow to position past eof
			NewPos = realSizeExt;
		return m_Pos = NewPos;
    }
	if ( NewPos > realSize )	// do not allow to position past eof
		NewPos = realSize;

	int	CurPageNo = (int) ( Pos / BufSize );
	int	NewPageNo = (int) ( NewPos / BufSize );

	if ( CurPageNo != NewPageNo ) {
		if ( Flags & SF_BUFDIRTY ){	
			// save buffer if it has been modified
			file -> SaveBlock ( 
							   Handle, 
							   (int)( Pos / BufSize ), 
							   Buf, 
							   Handle2Id(Handle)!=0?(int)realSize:BufSize,
							   isBigHandle() ? &allocatedSize : 0 );

			Flags &= ~SF_BUFDIRTY;
		}

		file -> LoadBlock ( Handle, NewPageNo, Buf, isBigHandle() ? allocatedSize : m_Per4Bytes );
	}

	return Pos = NewPos;
}

/*
	Truncates stream at a current position
	returns
	new size
*/

int	Stream :: Trunc ()
{
	if ( Pos >= realSize )
		return realSize;

	if ( Pos < ImmSize && Rec != 0 )
	{
		file -> DelHandle ( Handle, isBigHandle() ? allocatedSize : 0 );
		Handle = 0l;
	}else {
		long savePos = Pos;
		if( savePos < BufSize ){
			savePos = ((savePos+roundV-1)/roundV)*roundV;
			if( savePos >= BufSize ){
				savePos = BufSize - 1;
			}
			allocatedSize &= 0xff000000;
			allocatedSize |= savePos;
		}
		file -> TruncStream ( this, savePos, isBigHandle() ? &allocatedSize : 0 );
	}

	Flags |= SF_MODIFIED | SF_BUFDIRTY;

	return realSize = Pos;
}
#endif