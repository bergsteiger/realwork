#include <stdlib.h>

#ifdef sun
	#include <strings.h>
#endif

#include "stringz.h"

#include "assert.h"
#include "string.h"

#include "osdep.h"

StringZ :: StringZ ( char* pBuff, long lSize, int iSortingWithSub, int selfstore )
{
	m_bSelfStore = selfstore;
	if ( m_bSelfStore ) {
		m_pStrzBuff = (char*) malloc ( lSize );
		memcpy ( m_pStrzBuff, pBuff, lSize );
	} else m_pStrzBuff = pBuff;

	m_iSortingWithSub = iSortingWithSub;
	long i = lSize;
	m_iStrzCount = 0;

	while ( i ) if ( !m_pStrzBuff [--i] ) m_iStrzCount ++;

	m_pStrzArray = (char**) malloc ( sizeof ( char* ) * m_iStrzCount );

	m_pStrzAttrib = (char*) malloc ( sizeof ( char ) * m_iStrzCount );
	if ( m_pStrzAttrib ) gk_bzero ( m_pStrzAttrib, m_iStrzCount );

	int j = 0;
	if ( m_iStrzCount ) m_pStrzArray [j++] = m_pStrzBuff;

	i = 0;
	while ( j < m_iStrzCount && i < lSize ) if ( !m_pStrzBuff [i++] ) { 
		// Sorting Here
		for ( int k = 0; k < j; k++ ) {			
			char * pPureStrI = 0;
			char * pPureStrK = 0;

			if ( m_iSortingWithSub ) {
				pPureStrI = &m_pStrzBuff [i];
				pPureStrK = m_pStrzArray [k];
			}
			else { // Sorting with out Subs Number 
				pPureStrI = strchr ( &m_pStrzBuff [i], ':' );
				if ( ! pPureStrI ) pPureStrI = &m_pStrzBuff [i];

				pPureStrK = strchr ( m_pStrzArray [k], ':' );
				if ( ! pPureStrK ) pPureStrK = m_pStrzArray [k];
			}

			int iRes = strcmp ( pPureStrI, pPureStrK );
			if ( !iRes ) iRes = strncmp ( &m_pStrzBuff [i], m_pStrzArray [k], pPureStrK - m_pStrzArray [k] );
			if (  iRes <= 0 ) {
				memmove ( &m_pStrzArray [k+1], &m_pStrzArray [k], sizeof ( char* ) * (j++ - k) );
				m_pStrzArray [k] = &m_pStrzBuff [i];
			
				goto INS_OK;
			}
		}
	
		m_pStrzArray [j++] = &m_pStrzBuff [i];
INS_OK: ;
	}

	m_iCurrentPos = 0;
	m_bEnableHide = 1;
}

StringZ :: ~StringZ ()
{
	if ( m_pStrzAttrib ) free ( m_pStrzAttrib );
	if ( m_pStrzArray ) free ( m_pStrzArray );
	if ( m_bSelfStore ) free ( m_pStrzBuff );
}

void StringZ :: operator ++ ()
{
	if ( m_iCurrentPos < m_iStrzCount ) m_iCurrentPos ++;
	if ( m_bEnableHide ) {
		while ( m_iCurrentPos < m_iStrzCount && ( m_pStrzAttrib [m_iCurrentPos] & Z_ATTR_HIDE ) )
			m_iCurrentPos ++;
	}
}

void StringZ :: operator -- ()
{
	if ( m_iCurrentPos > 0 ) m_iCurrentPos --;
	if ( m_bEnableHide ) {
		while ( ( m_iCurrentPos > 0 && m_pStrzAttrib [m_iCurrentPos] & Z_ATTR_HIDE ) )
			m_iCurrentPos --;
	}
}

const char* StringZ :: GetAt( int iPos )
{
	if ( ! m_bEnableHide ) 
		return m_pStrzArray[ iPos ];
	int iNonHideCount = 0;

	for ( int i = 0; i < m_iStrzCount; i++ )
		if ( !( m_pStrzAttrib [i] & Z_ATTR_HIDE ) ) {
			if ( iNonHideCount == iPos )
				return m_pStrzArray[ i ];
			iNonHideCount ++;
		}

	return 0;
}

const char * StringZ :: GetNext ( int iPos ) const
{
	iPos ++;
	if ( m_bEnableHide ) {
		while ( iPos < m_iStrzCount && ( m_pStrzAttrib [iPos] & Z_ATTR_HIDE ) )
			iPos ++;
	}

	if ( iPos >= m_iStrzCount ) return 0;
	return m_pStrzArray [iPos];
}

const char * StringZ :: GetPrev ( int iPos ) const
{
	iPos --;

	if ( m_bEnableHide ) {
		while ( ( iPos >= 0 && m_pStrzAttrib [iPos] & Z_ATTR_HIDE ) )
		iPos --;
	}

	if ( iPos < 0 ) return 0;
	return m_pStrzArray [ iPos ];
}

int StringZ :: Equal ( const StringZ* pStrZ ) const
{
	if (  GetCount () != pStrZ -> GetCount () )
		return 0;

	for ( int i = 0; i < m_iStrzCount; i++ )
		if ( !( m_pStrzAttrib [i] & Z_ATTR_HIDE ) || !m_bEnableHide )
			if ( pStrZ->Find ( m_pStrzArray [i] ) == -1 )
				return 0;

	return 1;
}

int StringZ :: GetCount () const
{
	if ( ! m_bEnableHide )  return m_iStrzCount;
	int iNonHideCount = 0;

	for ( int i = 0; i < m_iStrzCount; i++ )
		if ( !( m_pStrzAttrib [i] & Z_ATTR_HIDE ) )
			iNonHideCount ++;

	return iNonHideCount;
}

int StringZ :: Find ( const char* pStrz ) const
{
	for ( int i = 0; i < m_iStrzCount; i++ )
		if ( !strcmp ( m_pStrzArray [i], pStrz ) ) {
			if ( !( m_pStrzAttrib [i] & Z_ATTR_HIDE ) || !m_bEnableHide )
				return i;
		}

	return -1;
}

int StringZ :: HasDoublicates ( FILE* pfOutFile, const char* pMessage )
{
	int iDoubCount = 0;
	int bSaveHideMode = m_bEnableHide;
	EnableHide ();

	for ( int i = 0; i < m_iStrzCount; i++ ) {
		if ( m_pStrzAttrib [i] & Z_ATTR_HIDE )
			continue;

		char cSaveAttrib = m_pStrzAttrib [i];
		Hide ( i );

		int iDoubPos;
		if ( ( iDoubPos = Find ( m_pStrzArray [i] ) ) != -1 ) {
			if ( pfOutFile ) {
				fprintf ( pfOutFile, "%s : \"%s\"\n", pMessage, m_pStrzArray [i] );
				//fflush ( pfOutFile );
			}
			iDoubCount ++;
		}

		m_pStrzAttrib [i] = cSaveAttrib;
	}

	m_bEnableHide = bSaveHideMode;
	return iDoubCount;
}

int StringZ :: HideDoublicates ()
{
	int iDoubCount = 0;
	int bSaveHideMode = m_bEnableHide;
	EnableHide ();

	for ( int i = 0; i < m_iStrzCount; i++ ) {
		if ( m_pStrzAttrib [i] & Z_ATTR_HIDE )
			continue;

		char cSaveAttrib = m_pStrzAttrib [i];
		Hide ( i );
		int iDoubPos;

		if ( ( iDoubPos = Find ( m_pStrzArray [i] ) ) != -1 )
			Hide ( iDoubPos ), iDoubCount ++;

		m_pStrzAttrib [i] = cSaveAttrib;
	}
	m_bEnableHide = bSaveHideMode;
	return iDoubCount;
}

// Servis method for H-StringZ
int StringZ :: FindUnEquelLevel ( int iPos ) const
{
	if ( iPos < 0 || iPos >= m_iStrzCount ) return -1;
	int iLev = 0;
	int iLevLen = 0;
	char * pPureStr = m_pStrzArray [iPos];
		
	/*
	if ( !m_iSortingWithSub ) {
		char* str = m_pStrzArray [iPos];
		pPureStr = strchr ( str, ':' );
		if ( !pPureStr ) pPureStr = m_pStrzArray [iPos];
	}
	*/
		
	char * pLevBeg = strdup ( pPureStr );
	char * pLevEnd = pLevBeg + strlen ( pLevBeg );

	while ( 1 ) {                
		iLevLen = pLevEnd - pLevBeg + 1;
		const char* pNextStrz = GetNext ( iPos );
		const char* pPrevStrz = GetPrev ( iPos );
				
		/*
		if ( !m_iSortingWithSub ) {
			if ( pNextStrz ) pNextStrz = strchr ( pNextStrz, ':' );
			if ( !pNextStrz ) pNextStrz = GetNext ( iPos );

			if ( pPrevStrz ) pPrevStrz  = strchr ( pPrevStrz , ':' );
			if ( !pPrevStrz ) pPrevStrz = GetPrev ( iPos );
		}
		*/

		if ( pPrevStrz && !strncmp ( pPureStr, pPrevStrz, iLevLen ) || pNextStrz && !strncmp ( pPureStr, pNextStrz, iLevLen ) )
		{
			free ( pLevBeg );
			return iLev;
		}

		pLevEnd = strrchr ( pLevBeg, '\\' );
		iLev ++;

		if ( !pLevEnd ) {
			free ( pLevBeg );
			return iLev;
		}
		
		*pLevEnd = '\0';
        }
}

void StringZ :: Print ( LogSession* log, logtype_t type ) const
{
	for ( int i = 0; i < m_iStrzCount; i++ )
		log->printf ( type, cd_dos, "%d : \"%s\"\n", i, m_pStrzArray [i] );
}

size_t StringZ :: UnHideSize ( int iCountMask )
{
	size_t stSize = 0;
	for ( int i = 0; i < m_iStrzCount; i++ ) {
		if ( m_pStrzAttrib [i] & Z_ATTR_HIDE )
			continue;
	
		stSize += strlen ( m_pStrzArray [i] );
		if ( iCountMask & WITH_Z ) stSize++;
	}
	return stSize;
}

const char* StringZ :: IterateBySub ( long sub, int &pos ) const
{
	if ( pos < 0 || pos >= m_iStrzCount ) return 0;
	if ( sub != -1 ) {
		while ( pos < m_iStrzCount && sub != atol ( m_pStrzArray [pos] )) pos++;
		if ( pos >= m_iStrzCount ) return 0;		
	}
	return GetKey ( pos++, 0 );
}

/////////////////////////////////////////////////////////////////////////////////////////

ZStrings::~ZStrings()
{
	if( strings ) free (strings);
	if( data && doFreeData ) free((void*)data);
}
int ZStrings::hasString(const char *p) const
{
	for( int i=0; i<n; i++) {
		if( strcmp(strings[i].ptr, p ) == 0 ){
			return 1;
		}
	}
	return 0;
}
int ZStrings::hasStringHIPart(const char *p, int len) const
{
	for( int i=0; i<n; i++) {
		if( strncmp(strings[i].ptr, p, len ) == 0 ){
			if( strings[i].ptr[len] == '\0' || strings[i].ptr[len] == '\\' )
				return 1;
		}
	}
	return 0;
}

ZStrings::ZStrings(const char *d, size_t len) : 
	doFreeData(0), data(d), n(0), strings(NULL)
{
	int i;
	for( i=0; i<(int)len; i++){
		if( *d++ == '\0' ) n++;
	}
	if( n ) {
		strings = (ZStringData*)malloc(sizeof(ZStringData)*n);
		strings[0].ptr=data;
		i = 0;
		const char *pptr = data;
		for( d=data; len; len--, d++ ) {
			if( *d == '\0' ){
				strings[i].len = d - pptr;
				i++;
				if( i < n ){
					pptr = d+1;
					strings[i].ptr = d+1;
				}
			}
		}
	}
}
