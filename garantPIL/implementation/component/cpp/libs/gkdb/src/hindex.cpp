#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: hindex.cpp,v 2.29 2010/09/17 09:07:27 yaroslav Exp $
 *
 * Basic class for handling multi-level indices
 * all keys area given in the normal MSDOS form, e.g.
 * parent1\parent2\....\key
 *
 * data can be associated with every item independently 
 * whether it's a leaf node or directory
 *
 * Author Alex V. Boreskoff
 *
 */

#include        "hindex.h"
#include        "btiter.h"

#include "shared/Core/fix/mpcxc.h" // GARANT_GCC

#include <cstdlib>
#include <cstring>

#define CREATED		2

void    HIndex :: Create ( short k_len,  short rndv, short ns, short imm)
{
        Index :: Create (k_len+sizeof(HIndexKey)-1,rndv,ns,imm);
}

int     HIndex :: Compare ( BTKEY key1, BTKEY key2 ) const
{
        if ( Level ( key1 ) != Level ( key2 ) )
                return Level ( key1 ) - Level ( key2 );
        else
        if ( Parent ( key1 ) < Parent ( key2 ) )
                return -1;
        else
        if ( Parent ( key1 ) > Parent ( key2 ) )
                return 1;
        else
                return CompareKeys ( Text(key1), Text(key2) );
}

static	unsigned char	ToUpper ( const unsigned char ch )
{
        if ( ch >= static_cast<unsigned char>('a') && ch <= static_cast<unsigned char>('z') ) // GARANT_W343
                return ch + static_cast<unsigned char>('A') - static_cast<unsigned char>('a');
        if ( ch >= static_cast<unsigned char>('†') && ch <= static_cast<unsigned char>('Ø' ))
                return ch + static_cast<unsigned char>('Ä') - static_cast<unsigned char>('†');
        if ( ch >= static_cast<unsigned char>('‡') && ch <= static_cast<unsigned char>('Ô') )
                return ch + static_cast<unsigned char>('ê') - static_cast<unsigned char>('‡');
        else
                return ch;
}

static	int str_cmp(const char * s1, const char * s2)
{
	register const unsigned char *p1 = (const unsigned char*)s1;
	register const unsigned char *p2 = (const unsigned char*)s2;
	while( *p1 && *p2 )
	{
		unsigned char	c1 = ToUpper ( *p1 );
		unsigned char	c2 = ToUpper ( *p2 );

		if ( c1 != c2 )
			return c1 - c2;
			
		p1++; p2++;
	}

	if ( *p1 || *p2 )
		if ( *p1 ) return 1; else return -1;	
	else
		return 0;
}

int real_stricmp (
        const char * dst,
        const char * src
        )
{
    int f, l;

    do
    {
        if ( ((f = (unsigned char)(*(dst++))) >= 'A') && (f <= 'Z') )
            f -= 'A' - 'a';
        if ( ((l = (unsigned char)(*(src++))) >= 'A') && (l <= 'Z') )
            l -= 'A' - 'a';
    }
    while ( f && (f == l) );

    return(f - l);
}

int     HIndex :: CompareKeys ( const char * key1, const char * key2 ) const
{
#ifdef	IGNOREKEYCASE
	return str_cmp (key1, key2);
#else
	return real_stricmp (key1, key2);
#endif
}

void HIndex::IncChildren(int level, char *dirName)
{
	char* 	first;
	char* 	last;
	char 	save_char;
	int 	direct_parent = 1;
	char 	keyBuf[384];

	first = last = dirName + strlen(dirName);
	while (*first != '\\' && first != dirName)
		first--;
	if (first != dirName) {
		
		last = first;
		first --;
		level --;

		while (level >= 0) {
		
			while (*first != '\\' && first != dirName)
				first--;
			
			save_char = *last;
			*last = '\0';
			BuildKey(keyBuf, 
				(level) ? first+1 : first, level, 
				(level) ? DirIdCache[level-1] : 0); 
			*last = save_char;
		
			if (FindKey(keyBuf, keyBuf) != GKDB::BT_OK) {
				return;
			}
	
			((HIndexKey*)keyBuf)->achCount++;
			if (direct_parent) ((HIndexKey*)keyBuf)->chCount++;
	
			UpdateKey(keyBuf);
		
			level--;
			direct_parent = 0;	
			last = first;
			if (first == dirName) break;
			first--;
		}
	}
}


void HIndex::DecChildren(int level, char *dirName)
{
	char* 	first;
	char* 	last;
	char 	save_char;
	int 	direct_parent = 1;
	char* 	keyBuf = (char *) malloc(256);

	first = last = dirName + strlen(dirName);
	while (*first != '\\' && first != dirName)
		first--;

	if (first != dirName) {
		
		last = first;
		first --;
		level --;

		while (level >= 0) {
		
			while (*first != '\\' && first != dirName)
				first--;
			
			save_char = *last;
			*last = '\0';
			BuildKey(keyBuf, 
				(level) ? first+1 : first, level, 
				(level) ? DirIdCache[level-1] : 0); 
			*last = save_char;
		
			if (FindKey(keyBuf, keyBuf) != GKDB::BT_OK) {
				free(keyBuf);
				return;
			}
	
			((HIndexKey*)keyBuf)->achCount--;
			if (direct_parent) ((HIndexKey*)keyBuf)->chCount--;
	
			UpdateKey(keyBuf);
		
			level--;
			direct_parent = 0;	
			last = first;
			if (first == dirName) break;
			first--;
		}
	}
	free(keyBuf);
}

BTKEY HIndex :: FullKey(const char *key)
{
	char  * keyBuf  = (char *) malloc ( 512 );
	char  * namePtr = (char *)key;
	long    ParId = 0l;
	char    level = 0;
	int     offs  = 0;
	int     result;

	for (;;) {
	    int i;
		for  (i=0;namePtr[i]!='\\'&&namePtr[i]!='\0';i++);
		if ( namePtr [i] == '\0' )
			break;
		assert ( i < KeyLength );
		namePtr[i] = '\\';
	#ifdef	IGNOREKEYCASE
		if ( !StrNICmp (key, DirNameCache, offs + i ) &&
	#else
		if ( !strncmp (key, DirNameCache, offs + i ) &&
	#endif
			(DirNameCache[offs+i]=='\0'||DirNameCache[offs+i]=='\\')){
                        ParId = DirIdCache [level];
		}else{
			namePtr [i] = '\0';
			if (!(result=OpenLevel(keyBuf,namePtr,level,ParId, 0))){
				namePtr [i] = '\\';
				free ( keyBuf );
				return 0;
			}
			ParId = Id(keyBuf);
			DirIdCache [level] = ParId;
			namePtr [i]        = '\\';      // restore key
			strcat ( strcpy ( DirNameCache + offs, keyBuf ), "\\" );
			assert ( strlen ( DirNameCache ) < sizeof ( DirNameCache ) );
		}
		level ++;
		namePtr += i + 1;
		offs    += i + 1;
	}
	if ( !(result=OpenLevel (keyBuf, namePtr, level, ParId, 0))) {
		free ( keyBuf );
		return 0;
	}
	return (BTKEY)keyBuf;
}

Stream * HIndex :: Open( BTKEY key, int a, int* p)
{
	return OpenN(key,0,a,p);
}
Stream * HIndex :: OpenN( BTKEY k_, int sn, int autoCreate, int* pCreated)
{
	if( sn >= nstreams )
		return 0;

	char  * keyBuf  = (char *) malloc ( file->PageSize );
#ifdef	unix
	char * key = (char*) alloca( strlen((const char*)k_)+1);
	strcpy(key,(const char*)k_);
#else
	char	*key = (char*) k_;
#endif
	char  * namePtr = key;
	long    ParId = 0l;
	char    level = 0;
	int     offs  = 0;
	int     result;
	
	if ( pCreated ) *pCreated = 0;

	for (;;) {
	  int i;
		for ( i=0;namePtr[i]!='\\'&&namePtr[i]!='\0';i++);
		if ( namePtr [i] == '\0' )
			break;

		assert ( i < KeyLength );

		namePtr[i] = '\\';
	#ifdef	IGNOREKEYCASE
		if ( !StrNICmp ( (char *) key, DirNameCache, offs + i ) &&
	#else
		if ( !strncmp ( (char *) key, DirNameCache, offs + i ) &&
	#endif
			(DirNameCache[offs+i]=='\0'||DirNameCache[offs+i]=='\\')){
                        ParId = DirIdCache [level];
		}else{
			namePtr [i] = '\0';
			if (!(result=OpenLevel(keyBuf,namePtr,level,ParId,autoCreate))){
				namePtr[i] = '\\';      // restore key
				free ( keyBuf );
				return 0;
			}
			ParId = Id(keyBuf);
			DirIdCache [level] = ParId;
			if (result == CREATED) {
				IncChildren(level, (char *)key);
				if ( pCreated && ! *pCreated ) *pCreated = 1;
			}
			namePtr [i]        = '\\';      // restore key
			strcat ( strcpy ( DirNameCache + offs, keyBuf ), "\\" );
			assert ( strlen ( DirNameCache ) < sizeof ( DirNameCache ) );
		}
		level ++;
		namePtr += i + 1;
		offs    += i + 1;
	}
	if ( !(result=OpenLevel (keyBuf, namePtr, level, ParId, autoCreate ))) {
		free ( keyBuf );
		return 0;
	}
	if (result == CREATED) {
		IncChildren(level, (char *)key);
		if ( pCreated && ! *pCreated ) *pCreated = 1;
	}

	Stream*str=new Stream(streams,recordData(keyBuf,sn),ImmDataSize,roundv);
	str -> IndexBuf = keyBuf;
	return str;
}

int     HIndex :: Delete ( BTKEY key )
{
	char    keyBuf [256];
	char  * namePtr = (char *) key;
	long    ParId = 0l;
	char    level = 0;
	int     offs  = 0;
	for(;;) {
	    int i;
		for ( i=0; namePtr[i]!='\\'&&namePtr[i]!='\0';i++) ;

		if ( namePtr [i] == '\0' )
			break;

		assert ( i < KeyLength );
		namePtr[i] = '\\';
	#ifdef	IGNOREKEYCASE
		if ( !StrNICmp((char *)key, DirNameCache, offs+i) &&
	#else
		if ( !strncmp((char *)key, DirNameCache, offs+i) &&
	#endif
              (DirNameCache[offs+i]=='\0'||DirNameCache[offs+i] == '\\' )){
                        ParId = DirIdCache [level];
		}else{
			namePtr [i] = '\0';
			if ( !OpenLevel (keyBuf, namePtr, level, ParId, 0 ) )
				return 0;

			namePtr [i]        = '\\';      // restore key
			ParId              = Id ( keyBuf );
			DirIdCache [level] = ParId;
			strcat ( strcpy ( DirNameCache + offs, keyBuf ), "\\" );

			assert ( strlen ( DirNameCache ) < sizeof ( DirNameCache ) );
		}

		level ++;
		namePtr += i + 1;
		offs    += i + 1;
	}

	if ( !OpenLevel ( keyBuf, namePtr, level, ParId, 0 ) )
	return 0;
	
	DecChildren(level, (char *)key); 

	return  Index::Delete ( keyBuf );
}

int     HIndex :: DeleteTree ( BTKEY key )
{
        unsigned long    id = Id ( key );
        char    keyBuf [256];

        assert ( KeyLength < 256 );
        for ( BTIterator it ( this, key ); !it.End (); )
        {
                BTKEY pKey = it.Key ();

                if ( Parent ( pKey ) == id )
                {
                        if ( DeleteTree ( pKey ) )
                                return 0;

                        memmove ( keyBuf, pKey, KeyLength );
                        it.Set  ( keyBuf );
                }
                else
                        ++it;
        }

        char	aFullName[ 4096 ];
		FullName( key, aFullName );
		return Delete( aFullName );
}

void  * HIndex :: BuildKey ( char * buf, const char * val, int level, long parId )
{
        memset ( buf, '\0', KeyLength );
        strcpy ( ((HIndexKey*)buf)->text, val );
        ((HIndexKey*)buf) ->level = level;
        ((HIndexKey*)buf)->parent  = parId;

        return buf;
}

int     HIndex :: OpenLevel ( char * keyBuf, char * name, int level, long parId, int autoCreate )
{
	BuildKey ( keyBuf, name, level, parId );

	switch ( FindKey ( keyBuf, keyBuf ) )
	{
		case GKDB::BT_OK:
			break;

		case GKDB::BT_NONE:
			if ( !autoCreate )
				return 0;

			((HIndexKey*)keyBuf)->id = ++LastId;
			Size   ( keyBuf ) = 0;
			((HIndexKey*)keyBuf)->achCount =0;
			((HIndexKey*)keyBuf)->chCount =0;
			AddKey ( keyBuf );
			return CREATED;

                default:
                        return 0;
        }

        return 1;
}

char    * HIndex :: FullName ( BTKEY key, char * buf )
{
        unsigned long    parent = Parent ( key );

        if ( !parent )
                strcpy ( buf, Text(key) );
        else
                for ( BTIterator it ( this ); !it.End (); ++it )
                {
                        BTKEY k = it.Key ();

                        if ( Id ( k ) == parent )
                        {
                                strcat ( strcat ( FullName ( k, buf ), "\\" ), Text(key) );
                                break;
                        }
                }
        return buf;
}
