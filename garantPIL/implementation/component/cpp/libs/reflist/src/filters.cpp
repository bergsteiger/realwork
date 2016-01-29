#include "shared/Core/fix/mpcxc.h"
#include "filters.h"
//#include "shell.h"

/*
#define INISTR_FILTER_NAME		"Name"
#define INISTR_FILTER_INDCOUNT	"IndCount"
#define INISTR_FILTER_INDID		"IndId"
#define INISTR_FILTER_KEY		"IndKey"
#define INISTR_FILTER_KEYCOUNT	"IndKeyCount"

#define INISTR_FILTERS_SECT		"FiltersColl"
#define INISTR_FILTERS_COUNT	"FiltersCount"
#define INISTR_FILTERS_DEFAULT	"FiltersDefault"
*/

// constant structure defines all known kernel filters
static const struct index_type g_indices [] = {
	{ INDF_BYSEGMENT, "Segment", ktShort, dtDocs },
	{ INDF_BYSTATUS, "Status", ktShort, dtDocs },
	{ INDF_BYCATEGORY, "Category", ktAsciiz, dtDocs },
	{ INDF_BYJUSTICE, "Status", ktShort, dtDocs },
	{ INDF_BYADOPTED, "Territory", ktAsciiz, dtDocs },
	{ INDF_BYDOCKIND, "DocKind", ktAsciiz, dtRefs }
};

// find known kernel filters by its name
const index_type* FindIndFilter ( fcond_type indfId )
{
	for ( u_int16_t l=0; l < sizeof ( g_indices ); l++ )
		if ( g_indices[l].filterId == indfId )
			return &g_indices[l];

	return 0;
}

///////////////////////////////////////////////////////////////////////////////
//
// ind_filter class implimentation
//
//

static	unsigned char	ToUpper ( const unsigned char ch )
{
        if ( ch >= 'a' && ch <= 'z' )
                return ch + 'A' - 'a';
        if ( ch >= ' ' && ch <= '¯' )
                return ch + '€' - ' ';
        if ( ch >= 'à' && ch <= 'ï' )
                return ch + '' - 'à';
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

int str_case_cmp(const char * s1, const char * s2)
{
    register const unsigned char *p1 = (const unsigned char*)s1;
    register const unsigned char *p2 = (const unsigned char*)s2;
	while( *p1 && *p2 )
	{
		if( *p1 >= 97 && *p1 <= 122 &&  *p2 >= 97 && *p2 <= 122)
		{
			if (*p1 != *p2)
				return (*p1 - *p2);
		}
		else if( *p1 >= 97 && *p1 <= 122 &&  *p2 >= 65 && *p2 <= 90)
		{
			if (*p1 != (*p2 + 32))
				return (*p1 - (*p2+32));
		}
		else if( *p1 >= 65 && *p1 <= 90 &&  *p2 >= 97 && *p2 <= 122)
		{
			if (*p1 != (*p2 - 32))
				return (*p1 - (*p2-32));
		}
		else if( *p1 >= 90 && *p1 <= 65 &&  *p2 >= 65 && *p2 <= 90)
		{
			if (*p1 != *p2)
				return (*p1 - *p2);
		}


		else if( *p1 >= 160 && *p1 <= 175 && *p2 >= 160 && *p2 <= 175)
		{
			if (*p1 != *p2)
				return (*p1 - *p2);
		}
		else if( *p1 >= 160 && *p1 <= 175 && *p2 >= 128 && *p2 <= 159)
		{
			if (*p1 != (*p2 + 32))
				return (*p1 - (*p2+32));
		}


		else if( *p1 >= 224 && *p1 <= 239 && *p2 >= 224 && *p2 <= 239)
		{
			if (*p1 != *p2)
				return (*p1 - *p2);
		}
		else if( *p1 >= 224 && *p1 <= 239 && *p2 >= 128 && *p2 <= 159)
		{
			if (*p1 != (*p2 + 80))
				return (*p1 - (*p2+80));
		}


		else if( *p1 >= 128 && *p1 <= 143 && (*p2 >= 160 && *p2 <= 175 || *p2 >= 224 && *p2 <= 239))
		{
			if (*p1 != (*p2 - 32))
				return (*p1 - (*p2-32));
		}
		else if( *p1 >= 128 && *p1 <= 143 && *p2 >= 128 && *p2 <= 143)
		{
			if (*p1 != *p2)
				return (*p1 - *p2);
		}
		else if( *p1 >= 144 && *p1 <= 159 && (*p2 >= 160 && *p2 <= 175 || *p2 >= 224 && *p2 <= 239))
		{
			if (*p1 != (*p2 - 80))
				return (*p1 - (*p2-80));
		}
		else if( *p1 >= 144 && *p1 <= 159 && *p2 >= 144 && *p2 <= 159)
		{
			if (*p1 != *p2)
				return (*p1 - *p2);
		}
		else 
		{
			if (*p1 != *p2)	return (*p1 - *p2);
		}
		p1++; p2++;
	}
	return (*p1 - *p2);
}

int str_n_case_cmp(const char * s1, const char * s2, int length)
{
    const unsigned char *p1 = (const unsigned char*)s1;
    const unsigned char *p2 = (const unsigned char*)s2;
	int i = 0; // GARANT_FORSCOPING
	for (i = 0; i < length && *p1 && *p2; i++, p1++, p2++)
	{
		if( *p1 >= 97 && *p1 <= 122 )
		{
			if (*p1 != *p2 && *p1 != (*p2 + 32))
				return (*p2 - *p1);
		}
		else if( *p1 >= 65 && *p1 <= 90 )
		{
			if (*p1 != *p2 && *p1 != (*p2 - 32))
				return (*p2 - *p1);
		}
		else if( *p1 >= 160 && *p1 <= 175 )
		{
			if (*p1 != *p2 && *p1 != (*p2 + 32))
				return (*p2 - *p1);
		}
		else if( *p1 >= 224 && *p1 <= 239 )
		{
			if (*p1 != *p2 && *p1 != (*p2 + 80))
				return (*p2 - *p1);
		}
		else if( *p1 >= 128 && *p1 <= 143 )
		{
			if (*p1 != *p2 && *p1 != (*p2 - 32))
				return (*p2 - *p1);
		}
		else if( *p1 >= 144 && *p1 <= 159 )
		{
			if (*p1 != *p2 && *p1 != (*p2 - 80))
				return (*p2 - *p1);
		}
		else 
		{
			if (*p1 != *p2)	return (*p2 - *p1);
		}
	}
	if (i == length) return 0;
	return (*p2 - *p1);
}

ind_filter :: ind_filter ( fcond_type indfId, Filter* pOwner )
{
	m_pIndFilter = FindIndFilter ( indfId );
	m_lKeyCount = 0;
	voidKeys = 0;
	m_pOwner = pOwner;
}

ind_filter :: ind_filter ( Store* pStore, Filter* pOwner )
{
	m_pIndFilter = 0;
	m_lKeyCount = 0;
	voidKeys = 0;
	m_pOwner = pOwner;
	Get ( pStore );
}

ind_filter :: ind_filter ( const ind_filter& copy, Filter* pOwner )
{
	if ( !pOwner ) m_pOwner = copy.m_pOwner;
	else m_pOwner = pOwner;
	
	m_pIndFilter = copy.m_pIndFilter;
	m_lKeyCount = copy.m_lKeyCount;

	voidKeys = malloc ( m_lKeyCount * KeySize() );
	memcpy ( voidKeys, copy.voidKeys, m_lKeyCount * KeySize() );

	if ( m_pIndFilter && m_pIndFilter->keyType == ktAsciiz )
		for ( u_int16_t l=0; l< m_lKeyCount; l++ )
			((char**)voidKeys)[l] = strdup ( (char*)(copy[l]) );
}

ind_filter :: ~ind_filter ()
{
	Reset ();
}

void ind_filter :: Reset ()
{
	if ( m_pIndFilter && m_pIndFilter->keyType == ktAsciiz )
		for ( u_int16_t l=0; l< m_lKeyCount; l++ )
			free ( ((char**)voidKeys)[l] );

	if ( voidKeys ) free ( voidKeys );
	m_lKeyCount = 0;
	voidKeys = 0;
	if ( m_pOwner ) m_pOwner->m_bBuilded = 0;
}

int16_t ind_filter :: AddKey ( const void* keyBuf )
{
	if ( !m_pIndFilter ) return -1;
	if ( FindKey ( keyBuf ) >= 0 ) return -1;

	u_int16_t bufSize = m_lKeyCount * KeySize ();
	void* pTmp;

	if ( m_pIndFilter->keyType > 0 )	// standart key: keyType==keySize
	{
		pTmp = malloc ( bufSize + KeySize() );
		memmove ( pTmp, voidKeys, bufSize );
		free ( voidKeys );
		voidKeys = pTmp;
		memmove ( (char*)voidKeys + bufSize, keyBuf,KeySize() );

		if ( m_pOwner ) m_pOwner->m_bBuilded = 0;
		return ++m_lKeyCount;
	}

	if ( m_pIndFilter->keyType == ktAsciiz ) // ASCIIZ key
	{
		pTmp = malloc ( bufSize + KeySize() );
		memmove ( pTmp, voidKeys, bufSize );
		free ( voidKeys );
		voidKeys = pTmp;

		((char**)voidKeys)[m_lKeyCount] = strdup ( (char*)keyBuf );

		if ( m_pOwner ) m_pOwner->m_bBuilded = 0;
		return ++m_lKeyCount;
	}

	// unknown no standart key
	return -1;
}

int16_t ind_filter :: FindKey ( const void* keyBuf )
{
	if ( !m_pIndFilter ) return -1;

	for ( u_int16_t l=0; l<m_lKeyCount; l++ ) {
		if ( m_pIndFilter->keyType > 0 ) {
			if ( !memcmp ( (char*)voidKeys+l*KeySize(), keyBuf, KeySize() ) )
				return l;
		} else {
		#ifdef	IGNOREKEYCASE
			if ( !str_cmp( ((char**)voidKeys)[l], (char*)keyBuf ) )
		#else
			if ( !strcmp( ((char**)voidKeys)[l], (char*)keyBuf ) )			
		#endif
				return l;
		}
	}
	return -1;
}

int16_t ind_filter :: DelKey ( const void* keyBuf )
{
	if ( !m_pIndFilter ) return -1;
	int16_t pos = FindKey ( keyBuf );

	if ( pos == -1 ) return -1;

	m_lKeyCount--;

	if ( m_pIndFilter->keyType == ktAsciiz )
		free ( ((char**)voidKeys)[pos] );

	if ( (u_int16_t)pos < m_lKeyCount )
		memmove ( (char*)voidKeys + pos*KeySize(),
			(char*)voidKeys + (pos+1)*KeySize(), (m_lKeyCount-pos)*KeySize() );

	if ( m_pOwner ) m_pOwner->m_bBuilded = 0;
	return m_lKeyCount;
}
const void* ind_filter :: GetKey ( u_int16_t pos ) const
{ // returns one key from buffer by pos.
		if ( pos >= m_lKeyCount ) return 0;
		if ( m_pIndFilter->keyType > 0 )
			return ((char*)voidKeys + pos * KeySize());
		else return ((char**)voidKeys)[pos];
}

char**	ind_filter :: GetCharKeys ( u_int16_t &count )
{
	if ( m_pIndFilter->keyType != ktAsciiz ) return 0;
	char**	aResult = (char**) malloc( m_lKeyCount * sizeof( char* ) );
	for ( u_int16_t i = 0; i < m_lKeyCount; i++ )
		aResult[i] = (char*)GetKey(i);
	count = m_lKeyCount;
	return	aResult;
}

int ind_filter::Put ( Store *pStore )
{
	short _signature = Tag();
	pStore->Write ( &_signature, sizeof(_signature) );
	int16_t int16 = m_pIndFilter->filterId;
	pStore->Write ( &int16, sizeof(int16_t) );
	pStore->Write ( &m_lKeyCount, sizeof(m_lKeyCount) );

	for ( u_int16_t l=0; l < m_lKeyCount; l++ ) {
		const void* pKey = GetKey (l);
		if ( m_pIndFilter->keyType == ktAsciiz ) {
			u_int16_t len = strlen ( (char*)pKey ) + 1;
			pStore->Write ( &len, sizeof(len) );
			pStore->Write ( pKey, len );
		} else pStore->Write ( pKey, KeySize() );
	}
	return 1;
}

int ind_filter::Get ( Store *pStore )
{	
	short _signature;
	pStore->Read ( &_signature, sizeof(_signature) );
	if ( _signature != Tag() ) return 0;
	
	Reset ();
		
	fcond_type indfId;
	int16_t int16;
	u_int16_t count;
	if ( pStore->Read(&int16, sizeof(int16_t)) != sizeof(int16_t) ) 
		return 0;
	indfId = (fcond_type)int16;
	
	if ( !(m_pIndFilter = FindIndFilter ( indfId )) ) return 0;
	
	if ( pStore->Read(&count, sizeof(count)) != sizeof(count) ) 
		return 0;
	
	for ( u_int16_t l=0; l < count; l++ ) {
		void* key;
		u_int16_t len;
		if ( m_pIndFilter->keyType == ktAsciiz ) {
			if  ( pStore->Read(&len, sizeof(len)) != sizeof(len))
				return 0;
		} else len = KeySize();
		
		key = malloc ( len );
		if ( pStore->Read(key, len) != len ) return 0;

		AddKey ( key );
		if (key) free (key);
	}
	return 1;	
}

///////////////////////////////////////////////////////////////////////////////
//
// Filter class implimentation
//
//

// create empty Filter with name
Filter :: Filter ( const char * name, Base* base )
{
	assert ( name );
	m_pName = strdup ( name );
	m_pIndFilters = 0;
	m_lCount = 0;
	m_pBase = base;
	m_bBuilded = 0;
	m_bValid = 1;
	m_pFilterRefs = 0;
	//m_is_validate = true;
}

Filter :: Filter ( const Filter& copy )
{
	*this = copy;
	m_pName = strdup ( copy.m_pName );
}

Filter :: ~Filter ()
{
	Reset();
	if (m_pName) free ( m_pName );
}

void Filter::Reset()
{
	for ( u_int16_t l=0; l<m_lCount; l++ ) delete m_pIndFilters[l];
	if ( m_pIndFilters ) free ( m_pIndFilters );
	if ( m_pFilterRefs ) delete m_pFilterRefs;
	
	m_pIndFilters = 0;
	m_pFilterRefs = 0;
	m_bBuilded = 0;
	m_bValid = 1;
	m_lCount = 0;
}

void Filter :: MoveTo ( Filter& move )
{
	move.Reset();
	move.m_bBuilded = m_bBuilded;
	m_bBuilded = 0;
	move.m_bValid = m_bValid;
	m_bValid = 1;
	move.m_lCount = m_lCount;
	m_lCount = 0;
	move.m_pFilterRefs = m_pFilterRefs;
	m_pFilterRefs = 0;
	move.m_pBase = m_pBase;
	move.m_pIndFilters = m_pIndFilters;
	m_pIndFilters = 0;
	for ( u_int16_t ll=0; ll < move.m_lCount; ll++ )
			move.m_pIndFilters[ll]->m_pOwner = &move;
}

Filter& Filter :: operator = ( const Filter& copy )
{
	if ( &copy != this ) {
		for ( u_int16_t l=0; l < m_lCount; l++ )
			if (m_pIndFilters[l])delete m_pIndFilters[l];
		if (m_pFilterRefs) delete m_pFilterRefs;
	
		m_pBase = copy.m_pBase;
		m_bBuilded = 0;
		m_bValid = copy.m_bValid;
		m_pFilterRefs = 0;	
		m_lCount = copy.m_lCount;
		m_pIndFilters = (ind_filter**) malloc ( m_lCount * sizeof(ind_filter*) );
		for ( u_int16_t ll=0; ll < m_lCount; ll++ )
			m_pIndFilters[ll] = new ind_filter ( *copy.m_pIndFilters[ll], this );
	
	}
	
	return *this;
}

int Filter::Put ( Store *pStore )
{
	short _signature = Tag();
	pStore->Write ( &_signature, sizeof(_signature) );
	
	u_int16_t len = strlen ( m_pName ) + 1;
	pStore->Write ( &len, sizeof (len) );
	pStore->Write ( m_pName, len );
	pStore->Write ( &m_lCount, sizeof(m_lCount) );
	
	for ( u_int16_t l=0; l<m_lCount; l++ )
		if ( !m_pIndFilters[l]->Put ( pStore ) ) return 0;
		
	return 1;	
}

int Filter::Get ( Store *pStore )
{	
	short _signature;
	pStore->Read ( &_signature, sizeof(_signature) );
	if ( _signature != Tag() ) return 0;
	
	Reset ();
	if (m_pName) free ( m_pName );

	u_int16_t count=0;
	u_int16_t len;
    	
    	if ( pStore->Read(&len, sizeof(len)) != sizeof(len) ) return 0;
    	m_pName = (char*) malloc ( len );
    	if ( pStore->Read(m_pName, len) != len ) return 0;
    		
	if ( pStore->Read(&count, sizeof(count)) != sizeof(count) ) return 0;
		
	for ( u_int16_t l=0; l < count; l++ ) {
		ind_filter aIndFilter ( pStore, this );
		Add ( aIndFilter );
	}
	/*if (m_is_validate) {
		Validate ();
	}*/
	return 1;	
}

void Filter :: SetBase ( Base * base )
{
	if(m_pBase != base) {
		m_pBase = base;
		//Validate ();
		m_bBuilded = 0;
	}
}

short Filter :: Validate ()
{
	m_bValid = 0;
	if ( !m_pBase ) return 0;
	if ( !m_lCount ) return 0;

	// processing all ind-filters
	for ( u_int16_t l=0; l < m_lCount; l++ )
	{
	#ifdef	IGNOREKEYCASE
		if ( !str_cmp( m_pIndFilters[l]->m_pIndFilter->indName, "Segment" ))
	#else
		if ( !strcmp( m_pIndFilters[l]->m_pIndFilter->indName, "Segment" ))
	#endif
			continue;

		Index* ind = m_pBase->FindIndex ( m_pIndFilters[l]->m_pIndFilter->indName );
		if ( !ind ) return 0;		

		for ( u_int16_t ll=0; ll < m_pIndFilters[l]->m_lKeyCount; ll++ ) {
			const void * pKey;
			pKey = (*m_pIndFilters[l])[ll];

			BTKEY key = ind->FullKey( (const char*)pKey );
			if ( !key ) return 0;
			gk_free ( (void*)key );
		}
	}
	
	m_bValid = 1;
	return 1;
}

const RefCollection* Filter :: GetRefs () 
{
	if ( m_bBuilded ) return m_pFilterRefs;
	else return BuildRefs ();
}

int16_t Filter :: Del ( fcond_type indfId )
{
	int16_t l = Find ( indfId );
	if ( l < 0 ) return -1;

	m_bBuilded = 0;
	delete m_pIndFilters[l];
	if ( l != (int16_t)--m_lCount ) {
		memmove ( m_pIndFilters+l, m_pIndFilters+l+1, 
			(m_lCount-l) * sizeof (ind_filter*) );
	}
	/*if (m_is_validate) {
		Validate();
	}*/
	return m_lCount;
}

// add new or overwrite exist ind-filter
int16_t Filter :: Add ( ind_filter& filter )
{
	m_bBuilded = 0;
	if ( !filter.voidKeys ) 
		return Del ( filter.m_pIndFilter->filterId );

	int16_t l = Find ( filter.m_pIndFilter->filterId );
	if ( l >= 0 ) {
		delete m_pIndFilters[l];
		m_pIndFilters[l] = new ind_filter ( filter );
		m_pIndFilters[l]->m_pOwner = this;
	} else {
		ind_filter** tmp = (ind_filter**) malloc ( (m_lCount+1) * sizeof(ind_filter*) );
		memcpy (tmp, m_pIndFilters, m_lCount * sizeof(ind_filter*) );
		tmp [m_lCount] = new ind_filter ( filter );
		tmp [m_lCount]->m_pOwner = this;
		m_lCount++;
		if ( m_pIndFilters ) free ( m_pIndFilters );
		m_pIndFilters = tmp;
	}
	/*if (m_is_validate) {
		Validate();
	}*/
	return m_lCount;
}

ind_filter * Filter :: operator [] ( u_int16_t pos ) const
{
	if ( pos >= m_lCount ) return 0;
	return m_pIndFilters [pos];
}

ind_filter * Filter :: Get ( fcond_type indfId )
{
	int16_t pos = Find(indfId);
	if ( pos >= 0 ) return m_pIndFilters [ pos ];
	else return 0;
}

int16_t Filter :: Find ( fcond_type indfId ) const
{
	for ( int16_t l=0; l < m_lCount; l++ )
		if ( m_pIndFilters[l]->m_pIndFilter->filterId == indfId )
			return l;
	return -1;
}

// create RefCollection for Filter
RefCollection * Filter::BuildRefs ()
{	   
	m_bBuilded = 0;
	if ( !m_pBase ) return 0;

	m_bBuilded = 1;

	if ( m_pFilterRefs ) delete m_pFilterRefs;
	m_pFilterRefs = 0;
	if ( !m_lCount ) return 0; // empty filter

	m_pFilterRefs = new RefCollection ();	// for collect filter's refs
	short init = 1;

	DocCollection* allDocs = 0;
	
	short	bSegment = 0;

	// processing all ind-filters
	for ( u_int16_t l=0; l < m_lCount; l++ ) {
		Index* ind = m_pBase->FindIndex ( m_pIndFilters[l]->m_pIndFilter->indName );
		
		if ( !strcmp( m_pIndFilters[l]->m_pIndFilter->indName, "Segment" )) {
			bSegment = 1;
			allDocs = m_pBase->AllDocs();
		}
						
		if ( !ind ) continue;

		SortedCollection * pKeyColl = 0; //temporary coll for loading key's data
		SortedCollection * pIndColl = 0; //temporary coll for merging index's data
		short type;// type of data

		switch ( m_pIndFilters[l]->m_pIndFilter->dataType ) {
		case dtDocs :
			type = 0;
			pKeyColl = new DocCollection (); 
			pIndColl = new DocCollection (); 
			break;
		case dtRefs :
			type = 1;
			pKeyColl = new RefCollection ();
			pIndColl = new RefCollection ();
			break;
		default :
			m_bBuilded = 0;
			return 0;
		}
		
		// processing all keys in ind-filter
		for ( u_int16_t ll=0; ll < m_pIndFilters[l]->m_lKeyCount; ll++ ) {
			const void * pKey;
			pKey = (*m_pIndFilters[l])[ll];

			Stream * str = ind->Open ( pKey );
			if ( str ) {
				if ( !pIndColl->ItemCount ) {
					pIndColl->Get ( str );
				} else {
					pKeyColl->Get ( str );
					pIndColl->Merge ( *pKeyColl );
				}							
				ind->Close ( str );
			}		
		}

		if ( bSegment && allDocs )
			pIndColl->Intersect( *allDocs );
		
		// intersection Refs with Docs is more priorty then Docs with Refs,
		// becouse intersection Doc with Ref may lost ref's Sub
		if ( type ) {
			// pIndColl is pure Refs colection (just loaded), intersect it 
			// with m_pFiltersRef (m_pFiltersRef may contents docs expanded to refs)
			// and swap them after
						
			if ( init ) init = 0;	// if m_pFiltersRef not init - just swap with pIndColl
			else {			// else intersect them
				pIndColl->m_bCompType = COMP_PLUS; // sub 0 interpret as '*'
				pIndColl->Intersect ( *m_pFilterRefs ); 
				pIndColl->m_bCompType = COMP_STD;
			}
						
			RefCollection * tmp = m_pFilterRefs;
			m_pFilterRefs = (RefCollection*) pIndColl;
			pIndColl = tmp;
		} else {
			// pIndColl is Docs collection, intersect m_pFiltersRef with it
			if ( init ) {
				// m_pFiltersRefs is not init, fill it with pIndColl
				m_pFilterRefs->Merge ( *pIndColl );
				init = 0;
			} else {
				m_pFilterRefs->m_bCompType = COMP_PLUS;
				m_pFilterRefs->Intersect ( *pIndColl );
				m_pFilterRefs->m_bCompType = COMP_STD;
			}			
		}
				
		delete pKeyColl;
		delete pIndColl;
	}
	
	if ( allDocs ) delete allDocs;
	
	return m_pFilterRefs;
}


///////////////////////////////////////////////////////////////////////////////
//
// FiltersColl class implimentation
//
//

FiltersColl :: FiltersColl ( const char* filename, Base* base/*, bool validate*/)
{
	m_pFilters = 0;
	m_lCount = 0;
	m_pDefault = 0;
	m_pTempFilter = 0;
	m_pBase = base;
	//m_is_validate = validate;
	
	if ( filename ) {
		m_pFileName = strdup(filename);
		Load ();
	} else m_pFileName = 0;
}

FiltersColl :: ~FiltersColl ()
{
	Reset ();
	if (m_pFileName) free (m_pFileName);
}

void FiltersColl :: Reset ()
{
	for ( u_int16_t l=0; l<m_lCount; l++ )
		delete m_pFilters[l];
	if (m_pFilters) free ( m_pFilters );
	if (m_pTempFilter) delete m_pTempFilter;
	if (m_pDefault) free (m_pDefault);

	m_pFilters = 0;
	m_lCount = 0;
	m_pDefault = 0;
	m_pTempFilter = 0;
}

int16_t FiltersColl::Save (const char *filename)
{
	Store *pStore;

	if ( !m_pFileName ) {
		if ( !filename ) return 0;
		else m_pFileName = strdup(filename);
	}
	else if ( filename )  {
		free(m_pFileName);
		m_pFileName = strdup(filename);
	}

#ifdef WIN32
	/*pStore = new CWinStore();
	if(!((CWinStore *)pStore)->Open(m_pFileName, ACE_OS_O_WRONLY | ACE_OS_O_CREAT | ACE_OS_O_BINARY))
		return 0;*/
	pStore = new DOSFile(m_pFileName, ACE_OS_O_WRONLY | ACE_OS_O_CREAT | ACE_OS_O_BINARY);
	if ( !((DOSFile*)pStore)->IsOk() ) {
#elif defined(__BORLANDC__) || defined(unix)
	pStore = new DOSFile(m_pFileName, ACE_OS_O_WRONLY | ACE_OS_O_CREAT | ACE_OS_O_BINARY);
	if ( !((DOSFile*)pStore)->IsOk() ) {
#else
	#error You need to write [class Store] based class on your platform
#endif	
		delete pStore;
		return 0;
	}
	Put(pStore);
	delete pStore;
	return 1;
}

int16_t FiltersColl::Load (const char *filename)
{
	Store *pStore;

	if ( !m_pFileName ) {
		if (!filename) return 0;
		else m_pFileName = strdup(filename);
	}
	else if (filename) {
		free(m_pFileName);
		m_pFileName = strdup(filename);
	}

	//Reset ();
#ifdef WIN32
	/*pStore = new CWinStore();
	if (!((CWinStore *)pStore)->Open(m_pFileName, ACE_OS_O_RDONLY | ACE_OS_O_BINARY))
		return 0;*/
	pStore = new DOSFile(m_pFileName, ACE_OS_O_RDONLY | ACE_OS_O_BINARY);
	if ( !((DOSFile*)pStore)->IsOk() ) {
#elif defined(__BORLANDC__) || defined (unix)
	pStore = new DOSFile(m_pFileName, ACE_OS_O_RDONLY | ACE_OS_O_BINARY);
	if ( !((DOSFile*)pStore)->IsOk() ) {
#else
	#error You need to write [class Store] based class on your platform
#endif	
		delete pStore;
		return 0;
	}
	Get(pStore);
	delete pStore;
	return 1;
}


int FiltersColl::Put ( Store *pStore )
{
	short _signature = Tag();
	pStore->Write ( &_signature, sizeof(_signature) );
	
	int16_t len = m_pDefault ? strlen(m_pDefault)+1 : 0;
	pStore->Write ( &len, sizeof (len) );
	if ( len ) pStore->Write ( m_pDefault, len );
	
	pStore->Write ( &m_lCount, sizeof(m_lCount) );
	
	for ( int16_t l=0; l<m_lCount; l++ )
		if ( !m_pFilters[l]->Put ( pStore ) ) return 0;
	
	pStore->Trunc();
		
	return 1;
}

int FiltersColl::Get ( Store *pStore )
{	
	short _signature;
	pStore->Read ( &_signature, sizeof(_signature) );
	if ( _signature != Tag() ) return 0;
	
	Reset ();

	u_int16_t count=0;
	int16_t len;
    	
    	if ( pStore->Read(&len, sizeof(len)) != sizeof(len) ) return 0;
    	if ( len ) {
    		m_pDefault = (char*) malloc ( len );
    		if ( pStore->Read(m_pDefault, len) != len ) return 0;
    	}
    	    		
	if ( pStore->Read(&count, sizeof(count)) != sizeof(count) ) return 0;
	
	if ( count )
	{
		m_pFilters = (Filter**) malloc ( count * sizeof (Filter*) );
		assert ( m_pFilters );
	}
	else
		m_pFilters = 0;
	
	u_int16_t l=0, l_pos=0; // GARANT_FORSCOPING
	for ( l=0, l_pos=0; l < count; l++ ){
		m_pFilters[l_pos] = new Filter ( "new", m_pBase );
			
		//m_pFilters[l]->SetValidate (m_is_validate);

		if ( ! m_pFilters[l]->Get ( pStore ) )
			delete m_pFilters[l_pos];
		else l_pos++;
	}
	m_lCount = l_pos;

	return 1;
}


void FiltersColl :: SetBase ( Base * base )
{
	m_pBase = base;
	if ( m_pTempFilter ) m_pTempFilter -> SetBase( base );
	for ( u_int16_t l=0; l < m_lCount; l++ )
		m_pFilters[l]->SetBase ( base );
}

int16_t FiltersColl :: Add ( Filter* filter )
{
	if ( !filter ) return 0;

	int16_t l = RealFind ( filter->Name() );
	if ( l >= 0 ) {
		assert ( m_pFilters[l] != filter );
		delete m_pFilters[l];
		m_pFilters[l] = filter;
	} else {
		Filter ** tmp = (Filter**) malloc ( (m_lCount+1) * sizeof (Filter*) );
		memmove ( tmp, m_pFilters, m_lCount * sizeof (Filter*) );
		tmp [m_lCount] = filter;
		m_lCount++;
		free ( m_pFilters );
		m_pFilters = tmp;
	}	
	return 1;
}

int16_t FiltersColl :: Add ( Filter& filter )
{
	Filter * pNew = new Filter ( filter );
	pNew->SetBase ( m_pBase );
	return Add ( pNew );	
}

int16_t FiltersColl :: SaveTemp ( const char * name )
{
	if ( !m_pTempFilter || !name ) return 0;	
	Filter* pNew = new Filter ( name, m_pBase );
	m_pTempFilter->MoveTo ( *pNew );

	return Add ( pNew );	
}

Filter * FiltersColl :: operator [] ( u_int16_t pos )
{
	if ( !MakeRealPos ( pos ) ) return 0;
	return m_pFilters [pos];
}

int16_t FiltersColl :: MakeRealPos ( u_int16_t& pos )
{
	u_int16_t validPos = 0;
	for ( u_int16_t l=0; l < m_lCount; l++ ) {
		if ( m_pFilters[l]->IsValid() ) validPos++;
		if ( validPos > pos ) {
			pos = l;
			return 1;
		}
	}
	
	return 0;
}

int16_t FiltersColl :: MakeValidPos ( u_int16_t& pos )
{
	if ( pos >= m_lCount || !m_pFilters[pos]->IsValid() ) return 0;

	int16_t validPos = 0;
	for ( u_int16_t l=0; l < pos; l++ )
		if ( m_pFilters[l]->IsValid() ) validPos++;
	
	pos = validPos;
	return 1;
}

int16_t FiltersColl :: RealFind ( const char* name )
{
	if ( !name ) return -1;

	for ( u_int16_t l=0; l < m_lCount; l++ )
		if ( !str_case_cmp(m_pFilters[l]->Name(), name ) )
			return l;
	return -1;
}

int16_t FiltersColl :: Find ( const char* name )
{
	int16_t pos = RealFind ( name );
	if ( pos == -1 ) return -1;
	
	u_int16_t realPos = pos;
	if ( !MakeValidPos ( realPos ) ) return -1;
	else return realPos;
}

Filter * FiltersColl :: Get ( const char * name )
{
	int16_t pos = RealFind( name );
	if ( pos >= 0 && m_pFilters [ pos ]->IsValid() ) return m_pFilters [ pos ];
	else return 0;
}

Filter * FiltersColl :: GetDefault ()
{
	Filter * pDef = Get ( m_pDefault );
	if ( !pDef ) pDef = GetTemp ();
	return pDef;
}

Filter * FiltersColl :: GetTemp ()
{
	if ( !m_pTempFilter )
		m_pTempFilter = new Filter ( "", m_pBase );

	return m_pTempFilter;
}

int16_t FiltersColl :: SetDefault ( int16_t pos )
{
	if ( pos < 0 ) {
		if ( m_pDefault ) free (m_pDefault);
		m_pDefault = 0;
	} else {
		u_int16_t validPos = pos;
		if ( !MakeRealPos ( validPos ) ) return 0;
		if ( m_pDefault ) free (m_pDefault);
		m_pDefault = strdup ( m_pFilters[validPos]->Name() );
	}
	
	return 1;
}

int16_t FiltersColl :: Delete ( u_int16_t pos )
{
	if ( !MakeRealPos ( pos ) ) return -1;

	if ( m_pDefault != 0 && !str_case_cmp( m_pDefault, m_pFilters[pos]->Name() ) ) {
		free ( m_pDefault );
		m_pDefault = 0;
	}
	delete m_pFilters[pos];
	if ( pos != --m_lCount ) {
		memmove ( m_pFilters+pos, m_pFilters+pos+1, 
			(m_lCount-pos) * sizeof (Filter*) );
	}
	return 1;
}


/* Example */
/*
void SaveFilterFromDlg ( const char *name ) {
	Filter filter (name);

	ind_filter statusFilter ( INDF_BYSTATUS );
	statusFilter.AddKey ( statusDlg.GetData() );
	filter.Add ( statusFilter );
	//....
	//....
	ind_filter kindFilter ( INDF_BYDOCKIND );
	for ( long i=0; i < docKindDlg.SelCount; i++ )
		statusFilter.AddKey ( docKindDlg.GetSel (i) );
	filter.Add ( statusFilter );

	filterColl.Add ( filter );
	if ( autoSave ) filterColl.Save ();
}

void LoadFilterToDlg ( const char *name ) {
	FilterColl filterColl ( pProfileIni );

	Filter* pFilter = filterColl.Get (name);

	for ( long l=0; l < pFilter.GetCount(); l++ ) {
		ind_filter * pIndFilter = pFilter[l];
		void * pKeys = pIndFilter->GetKeys ( lKeysCount );

		for ( long ll=0; ll < lKeysCount; ll++ ) {
			switch ( pIndFilter->GetFilterId() ) {
			case INDF_BYSTATUS :
				statusDlg.SetData ( ((short*)pKeys)[ll] );
				break;
			//....
			//....
			case INDF_BYDOCKIND :
				docKindDlg.SetSel ( ((char**)pKeys)[ll] );
				break;
			default :
				// unknown index filter
			}
		}
	}
}

void ApplyDefaultFilter ( RefCollection& refs ) {
	FilterColl filterColl ( pProfileIni );

	Filter* pFilter = filterColl.GetDefault (); // default filter
	RefCollection filterRefs;

	pFilter->CreateRefs ( pBase, filterRefs );

	refs.Intersect (filterRefs);
}

*/
