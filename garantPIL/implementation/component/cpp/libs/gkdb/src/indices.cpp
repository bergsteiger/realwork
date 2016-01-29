
#include "check.h"
#include "indices.h"
#include "garutils.h"
#include "pack.h"

#include <cstdlib>

int IntIndex::Compare (BTKEY key1, BTKEY key2) const {
	return ( *(short *) key1 > *(short *) key2 ) ? 1 :
		( *(short *) key1 < *(short *) key2 ) ? -1 : 0;
}

int LongIndex::Compare (BTKEY key1, BTKEY key2) const {
	return ( *(long *) key1 > *(long *) key2 ) ? 1 :
		( *(long *) key1 < *(long *) key2 ) ? -1 : 0;
}

int DateIndex::Compare (BTKEY key1, BTKEY key2) const {
	return CompDates ((date *) key1, (date *) key2);
}

int BlobIndex::Compare (BTKEY key1, BTKEY key2) const {
	ObjKey* aObj1 = (ObjKey*)key1;
	ObjKey* aObj2 = (ObjKey*)key2;

	if ( aObj1 -> id > aObj2 -> id )
		return 1;
	else	
	if ( aObj1 -> id < aObj2 -> id )
		return -1;
	else
		return 0;	
}

int ContextIndex::Compare (BTKEY key1, BTKEY key2) const {
	return strncmp ((char*) key1, (char*) key2, 4);
}

int ContextStrIndex::Compare (BTKEY key1, BTKEY key2) const {
	const unsigned char* char1 = (const unsigned char*) key1;
	const unsigned char* char2 = (const unsigned char*) key2;
	unsigned char mask1 = *char1 & 0x40;
	unsigned char mask2 = *char2 & 0x40;
	if (mask1 == mask2 && mask1) {
		return strncmp ((char*)char1 + 1, (char*)char2 + 1, 31);
	} else {
		if (*char1 < *char2)
			return -1;
		else
		if (*char1 > *char2)
			return 1;
		else {
			if (*char1 == 0 && *char2 == 0) {
				char1++, char2++;
				return ( *(long *) char1 > *(long *) char2 ) ? 1 : ( *(long *) char1 < *(long *) char2 ) ? -1 : 0;	
			} else {
				return strncmp ((char*)char1 + 1, (char*)char2 + 1, 31);
			}
		}
	}
}

int FContxtIndex::Compare (BTKEY key1, BTKEY key2) const {
	return strcmp ((const char*) key1, (const char*) key2);
}

int AttrIndex::Put (long DocId, int tag, const void * buf, int size)
{
	if (tag == IDD_DIV || tag == IDD_SUBS_EX || tag == IDD_DOCSTRUCT || tag == IDD2_PARAIDS) {
		long old_size;
		void gk_huge* old_buf = Load (DocId, tag, old_size);
		if (old_size) {
			long new_size = old_size + size;
			void gk_huge *new_buf = malloc (new_size);
			memcpy (new_buf, old_buf, old_size);
			gk_free (old_buf);
			memcpy ((char*)new_buf + old_size, buf, size);
			Replace (DocId, tag, new_buf, new_size);
			free (new_buf);
			return size;
		} else {
			return Replace (DocId, tag, (void*) buf, size);
		}
	} else {
		AttrKey key = {DocId, (short) tag};
		return AddData (&key, buf, size);
	}
}

int     AttrIndex :: Get ( long DocId, int tag, void * buf, int size )
{
	AttrKey key = {DocId, (short) tag};
	int result = FindData ( &key, buf, size );
	if ((tag == IDD_DIV || tag == IDD_SUBS_EX || tag == IDD_EVD || tag == IDD_DOCSTRUCT || tag == IDD2_PARAIDS) && result) {
		if (tag == IDD2_PARAIDS) {
			char* data = (char*) buf;
			long tail = size % 4;
			if (0 == tail) {
				if (*(long*) data == 0xDEADF00D) {
					data += 4;
					size = result - 4;

					long unpacked_size = *(long*) data;
					void gk_huge* unpacked_data = malloc (unpacked_size);
					G_UNZIP (data + sizeof (long), size - sizeof (long), unpacked_data, unpacked_size);
					memcpy (buf, unpacked_data, unpacked_size);
					result = unpacked_size;
					gk_free (unpacked_data);
				}
			} else {
				long unpacked_size = *(long*) data;
				void gk_huge* unpacked_data = malloc (unpacked_size);
				G_UNZIP (data + sizeof (long), size - sizeof (long), unpacked_data, unpacked_size);
				memcpy (buf, unpacked_data, unpacked_size);
				result = unpacked_size;
				gk_free (unpacked_data);
			}			
		} else if (tag == IDD_DIV) {
			char* data = (char*) buf;
			if (data [3] == 0) {
				long unpacked_size = *(long*) data;
				void gk_huge* unpacked_data = malloc (unpacked_size);
				G_UNZIP (data + sizeof (long), size - sizeof (long), unpacked_data, unpacked_size);
				memcpy (buf, unpacked_data, unpacked_size);
				result = unpacked_size;
				gk_free (unpacked_data);
			}
		} else if (tag == IDD_SUBS_EX || tag == IDD_EVD || tag == IDD_DOCSTRUCT) {
			long* data = (long*) buf;
			if (*data == 0) {
				data++;
				long unpacked_size = *(long*) data;
				data++;
				void gk_huge* unpacked_data = malloc (unpacked_size);
				G_UNZIP (data, size - 2 * sizeof (long), unpacked_data, unpacked_size);
				memcpy (buf, unpacked_data, unpacked_size);
				result = unpacked_size;
				gk_free (unpacked_data);
			}
		}
	}

	return result;
}

int     AttrIndex :: Del ( long DocId, int tag )
{
        AttrKey key;

        key.DocId   = DocId;
        key.AttrTag = (short) tag;

        return Delete ( &key );
}

void gk_huge * AttrIndex :: Load ( long DocId, int tag, long& size )
{
        Stream * str;

		void gk_huge *pRet= LoadEx(DocId, tag, size, &str), *unpacked_data= 0;

		if( str )
			Close ( str );

		if (size) {
			if (tag == IDD2_PARAIDS) {
				char* data = (char*) pRet;
				long tail = size % 4;
				if (0 == tail) {
					if (*(long*) data == 0xDEADF00D) {
						data += 4;
						size -= 4;

						long unpacked_size = *(long*) (data);
						if (!(unpacked_data = (void gk_huge*)gk_malloc (unpacked_size)))
							goto ErrorUnPack;

						if(G_UNZIP (data + sizeof (long), size - sizeof (long), unpacked_data, unpacked_size) != unpacked_size)
							goto ErrorUnPack;

						gk_free (pRet);
						pRet = unpacked_data;
						size = unpacked_size;

#ifdef	_GCD_SERVER
						if (DocId == PROTECTED_DOCID) {
							size += sizeof (long);
							pRet = realloc (pRet, size);
						}
#endif
					}					
				} else {
					long unpacked_size = *(long*) (data);
					if (!(unpacked_data = (void gk_huge*)gk_malloc (unpacked_size)))
						goto ErrorUnPack;

					if(G_UNZIP (data + sizeof (long), size - sizeof (long), unpacked_data, unpacked_size) != unpacked_size)
						goto ErrorUnPack;

					gk_free (pRet);
					pRet = unpacked_data;
					size = unpacked_size;

#ifdef	_GCD_SERVER
					if (DocId == PROTECTED_DOCID) {
						size += sizeof (long);
						pRet = realloc (pRet, size);
					}
#endif
				}
			} else
			if (tag == IDD_DIV) {
				char* data = (char*) pRet;
				if (data [3] == 0) {
					long unpacked_size = *(long*) data;
					if( !(unpacked_data = (void gk_huge*)gk_malloc (unpacked_size)))
						goto ErrorUnPack;

					if(G_UNZIP (data + sizeof (long), size - sizeof (long), unpacked_data, unpacked_size) != unpacked_size)
						goto ErrorUnPack;

					gk_free (pRet);
					pRet = unpacked_data;
					size = unpacked_size;
				}
			} else
			if (tag == IDD_EVD || tag == IDD_SUBS_EX || tag == IDD_DOCSTRUCT) {
				long* data = (long*) pRet;
				if (*data == 0) {
					data++;
					long unpacked_size = *(long*) data;
					data++;
					if( !(unpacked_data = (void gk_huge*)gk_malloc (unpacked_size)))
						goto ErrorUnPack;

					if(G_UNZIP (data, size - 2 * sizeof (long), unpacked_data, unpacked_size) != unpacked_size)
						goto ErrorUnPack;

					gk_free (pRet);
					pRet = unpacked_data;
					size = unpacked_size;
				}
#ifdef	_GCD_SERVER
				if (tag == IDD_DOCSTRUCT && DocId == PROTECTED_DOCID)
					((DocStruct*)pRet)->m_end_para++;
#endif
			}
		}
        return pRet;
ErrorUnPack:
		if(unpacked_data)
			free(unpacked_data);
		if(pRet)
			free(pRet);
		size= 0;
		return 0;
}

void gk_huge * AttrIndex :: Load ( Stream* str, long& size )
{
	void gk_huge * buf;
	if ( str == 0 ) {
		size = 0;
		return 0;
	}

	if ( ( size = str -> Length () ) > 0 ) {
		buf = (void gk_huge*) gk_malloc( size );
		assert ( buf );
		size = str -> Read ( buf, size );
	}

	Close ( str );

	return buf;
}

int AttrIndex :: Load ( Stream* str, DBCore::Storable& storable )
{
	int res = storable.Get ( str );
	Close ( str );
	return res;
}

int AttrIndex :: Load ( long DocId, int tag, DBCore::Storable& storable )
{
	AttrKey key = {DocId, (short) tag};

	Stream *str;
	GetStream ( key, &str);
	if (!str)
		return 0;
	str->Seek (0);
	return Load (str, storable);
}

int     AttrIndex :: Replace ( long DocId, int tag, void * buf, int size)
{
	AttrKey key = {DocId, (short) tag};
	Stream *str;
	GetStream (key, &str, 1);
	str->Seek (0);
	if (tag == IDD2_PARAIDS) {
		//неупакованные IDD2_PARAIDS по размеру кратны 4. Т.е. достаточно сделать некратным - и это будет признак упакованности
		char* packed_data = (char*) malloc (size + sizeof (long));
		long packed_size = G_ZIP ((char*) buf, size, packed_data + sizeof (long), size);
		if (packed_size && packed_size < size - 5) {
			long dummy = 0, tail = 0;
			if (0 == packed_size % 4) {
				tail = 4;
				dummy = 0xDEADF00D;
			}
			*(long*) packed_data = size;
			if (tail)
				size = str->Write (&dummy, tail);
			else
				size = 0;
			size += str->Write (packed_data, packed_size + sizeof (long));
		} else {
			size = str->Write (buf, size);
		}
		gk_free (packed_data);
	} else
	if (tag == IDD_DIV) {
		char* packed_data = (char*) malloc (size + sizeof (long));
		long packed_size = G_ZIP ((char*) buf, size, packed_data + sizeof (long), size);
		if (packed_size) {
			*(long*)packed_data = size;
			size = str->Write (packed_data, packed_size + sizeof (long));
		} else {
			size = str->Write (buf, size);
		}
		gk_free (packed_data);
	} else
	if (tag == IDD_EVD || tag == IDD_SUBS_EX || tag == IDD_DOCSTRUCT) {
		char* packed_data = (char*) malloc (size + 2 * sizeof (long));
		long packed_size = G_ZIP ((char*) buf, size, packed_data + sizeof (long) * 2, size);
		if (packed_size) {
			long *long_ptr = (long*) packed_data;
			*long_ptr = 0;
			long_ptr++;
			*long_ptr = size;
			size = str->Write (packed_data, packed_size + 2 * sizeof (long));
		} else {
			size = str->Write (buf, size);
		}
		gk_free (packed_data);
	} else {
		size = str->Write ( buf, size );
	}	
	str->Trunc();
	Close ( str );

	return size;
}

int AttrIndex :: Replace ( long DocId, int tag, DBCore::Storable& storable )
{
	AttrKey key;
	key.DocId   = DocId;
	key.AttrTag = (short) tag;

	Stream * str;
	GetStream( key, &str, 1 );
	str->Seek(0);
	int ret = storable.Put ( str );
	str->Trunc();
	Close ( str );

	return ret;
}

int AttrIndex::Compare ( BTKEY key1, BTKEY key2 ) const {
	if(Name[1] == 'T')
		return attrcmp_new(key1, key2);

	return attrcmp(key1, key2);
}

void AttrIndex::GetStream( AttrKey& key, Stream **ppRet, int iCreate) {
	*ppRet= OpenN(&key, 0, iCreate);
}

void gk_huge * AttrIndex::LoadEx( long DocId, int tag, long& size, Stream **ppRet) {
    AttrKey key;
    key.DocId   = DocId;
	key.AttrTag = tag;

	GetStream( key, ppRet );

	void gk_huge *buf= 0;

    if ( *ppRet != 0 && ( size = (*ppRet) -> Length () ) > 0
			&& (buf  = ( void gk_huge * ) gk_malloc ( size )))
    {
        size = (*ppRet) -> Read ( buf, size );
		return buf;
    }
	size= 0;
    return 0;
}

inline int Sign (int x) {
	return (x > 0 ? 1 : (x < 0 ? -1 : 0));
}

inline int Sign (long x) {
	return (x > 0 ? 1 : (x < 0 ? -1 : 0));
}

int     RefIndex :: Compare ( BTKEY key1, BTKEY key2 ) const
{
#ifdef	VERSION63
	struct Ref* at1 = (struct Ref*)key1;
	struct Ref* at2 = (struct Ref*)key2;
	int s = 0;

	if ( at1->Sub == 0 ) {
		if ( at2->Sub == 0 )
			s = Sign( at1->DocId - at2->DocId );
		else
			s = -1;			
	} else {
		if ( at2->Sub == 0 )
			s = 1;
		else
			s = Sign( at1->DocId - at2->DocId );
	}
	if ( s )
		return s;
	else
		return Sign( at1->Sub - at2->Sub );
#else
	int s = Sign( ((struct Ref*)key1)->DocId - ((struct Ref*)key2)->DocId );
	if ( s )
		return s;
	else
		return Sign( ((struct Ref*)key1)->Sub - ((struct Ref*)key2)->Sub );
#endif
}

int     RealRefIndex :: Compare ( BTKEY key1, BTKEY key2 ) const
{
	int s = Sign( ((struct Ref*)key1)->DocId - ((struct Ref*)key2)->DocId );
	if ( s )
		return s;
	else
		return Sign( ((struct Ref*)key1)->Sub - ((struct Ref*)key2)->Sub );
}

int     KeyWordIndex :: CompareKeys (const char*key1,const char*key2) const
{
        return strcmp ( key1, key2 );
}

