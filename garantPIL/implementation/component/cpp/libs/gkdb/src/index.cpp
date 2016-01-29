//
// Basic index class for managing search
// Based of BTree class to provide add/delete/find capabilities
//
// Author Alex V. Boreskoff
//
#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
	#include "../../../Garant/Datastore/NdtClone/Common/index.cpp"
#else
#include "check.h"
#include "index.h"

#include <cstdlib>

Stream* Index :: keyOpen(BTKEY k, int sn)
{
	return makeStream(streams,recordData(k,sn),ImmDataSize,roundv);
}

Stream* Index :: makeStream(StreamFile* p1, IndexRecordData* p2, int p3, int p4, int p5)
{
	return new Stream(p1, p2, p3, p4, p5);
}

Index :: Index (PagedFile* tf, const char* name, StreamFile* s, IndexInfo* pInfo) : BTree () {
	file=tf;

#ifndef VERSION61
	if(!(file->m_mode & (~0x3000)))
		file->m_mode |= GKDB::BT_GO_TO_ROOT;
#endif

	strcpy ( Name, name );
    IndexInfo info;

    if(file->IsOk()&& (pInfo || file->GetAttr ( Name, &info, sizeof (info)))){
		if(pInfo){
			info= *pInfo;
		}
		BTree::init(tf, &info.btinit);
		ImmDataSize = info.immdatasize;
		roundv = info.rndv;
		nstreams = info.nstreams;
	}else{
		BTree::init(tf, 0 );
		ImmDataSize = sizeof(IndexRecordData::RecordData);
		roundv = 1;
		nstreams = 1;
	}
	streams     = s;
	pResultFileKeyName= tf->FileName;
}

Index::~Index()
{
	if((file->m_mode & (~0x3000)) & GKDB::BT_GO_TO_ROOT)
		file->m_mode &= ~GKDB::BT_GO_TO_ROOT;

	IndexInfo info;
	BTree :: shutdown(&info.btinit);
	info.immdatasize = ImmDataSize;
	info.rndv = roundv;
	info.nstreams = nstreams;
	if( (file->m_mode & (~0x3000)) && file->IsOk() ){
		file->PutAttr(Name, &info, sizeof(info));
	}
}
void Index::Create (short key_len, short rndv, short ns, short immsize)
{
	if(Root != -1)
		return;
	if( rndv < 1 )
		rndv = 1;
	if( immsize < sizeof(IndexRecordData::RecordData) )
		immsize = sizeof(IndexRecordData::RecordData);
	if( ns < 1) ns=1;
	ImmDataSize = immsize;
	roundv = rndv;
	nstreams = ns;
	BTree::Create ( key_len + ns*(STRSZSZ+immsize) );
}

int	Index :: Rename ( BTKEY key1, BTKEY key2 )
{
	char	KeyBuf [256];

	assert ( KeyLength <= sizeof ( KeyBuf ) );

	if ( FindKey ( key1, KeyBuf ) != GKDB::BT_OK )
		return 0;

	if ( DelKey ( key1 ) != GKDB::BT_OK )
		return 0;

	memmove ( KeyBuf, key2, KeyLength - nstreams*(STRSZSZ+ImmDataSize));
	return AddKey ( KeyBuf ) == GKDB::BT_OK;
}

int	Index :: Delete ( BTKEY key )
{
	char	KeyBuf [256];

	assert ( KeyLength <= sizeof ( KeyBuf ) );

	int iRes = FindKey( key, KeyBuf );
	if ( iRes  != GKDB::BT_OK ) return iRes;

	for( int i=0; i< nstreams; i++ ){
		IndexRecordData *pTmp= recordData(KeyBuf,i);
		if ( pTmp->header.realDataLength > ImmDataSize ){
			streams -> DelHandle (pTmp->data.handle
									, (pTmp->header.allocatedDataLength & 0x80000000) ? pTmp->header.allocatedDataLength : 0);
		}
	}

	return DelKey ( KeyBuf );
}

Stream * Index :: Open ( BTKEY key, int AutoCreate, int *pCreated )
{
	return OpenN(key, 0, AutoCreate, pCreated);
}

Stream * Index :: OpenN ( BTKEY key, int sn, int AutoCreate, int *pCreated )
{
	if( sn >= nstreams )
		return 0;

	char * keyBuf = 0;
	if ((file->m_mode & (~0x3000)) ) {
		keyBuf = (char *) malloc ( file->PageSize );
		assert ( keyBuf != 0 );		
	}

	if ( pCreated ) *pCreated = 0;

	switch ( FindKey ( key, keyBuf ) )
	{
		case GKDB::BT_NONE:			// append new key
			if ( !AutoCreate )
			{
				if(keyBuf)
					free ( keyBuf );
				return 0;
			}

			memset  ( keyBuf, '\0', KeyLength );
			memmove ( keyBuf,key,KeyLength-nstreams*(STRSZSZ+ImmDataSize) );

			if ( AddKey  ( keyBuf ) != GKDB::BT_OK )
			{
				free ( keyBuf );
				return 0;
			}

			if ( pCreated ) *pCreated = 1;

			break;

		case GKDB::BT_OK:			// key found
			if(!(file->m_mode & (~0x3000)))
				keyBuf= (char*)RecOffs ( Stack [Sp-1].buf, Stack [Sp-1].Pos );
			break;

		default:			// some error occurred
			if(keyBuf)
				free ( keyBuf );
			return 0;
	}
	IndexRecordData *pTmp= recordData(keyBuf,sn);
	Stream* str = makeStream (streams, pTmp, ImmDataSize, roundv, IsBlobPointer (sn, Name,pTmp->header.realDataLength));

	if( str) {
		str -> IndexBuf = keyBuf;
		return str;
	}else{
		if((file->m_mode & (~0x3000)))
			free(keyBuf);
		return 0;
	}
}

void	Index :: Close ( Stream * str )
{
	if( str) {
		if(str->Modified ()){
			str->closeAttrs();
			UpdateKey(str -> IndexBuf);
			str -> IndexFreeBuf= str -> IndexBuf;
			delete str;
		}else{
			if((file->m_mode & (~0x3000)))
				str -> IndexFreeBuf= str -> IndexBuf;
			delete str;
		}
	}
}

int	Index :: AddData ( BTKEY key, const void * buf, int size, int sn )
{
	Stream * str = OpenN ( key, sn, 1 );

	str -> Seek  ( str -> Length () );		// seek to end of stream
	size = (int) str -> Write ( buf, size );	// append data to end

	Close ( str );

	return size;
}

int	Index :: SetData ( BTKEY key, const void * buf, int size, int sn )
{
	Stream * str = OpenN ( key, sn, 1 );

	str -> Seek  ( 0 );				// seek to begin of stream
	size = (int) str -> Write ( buf, size );	// write to beginning

	Close ( str );

	return size;
}

int	Index :: FindData ( BTKEY key, void * buf, int buf_size, int ns )
{
	Stream * str = OpenN ( key, ns );

	if ( str != 0 ){
		buf_size = (int) str -> Read ( buf, buf_size );
		Close ( str );
		return buf_size;
	}
	else
		return 0;
}
#endif