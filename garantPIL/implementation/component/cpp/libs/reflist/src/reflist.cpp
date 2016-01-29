/*
 * $Header: /export/home/cvs/garantPIL/implementation/component/cpp/libs/reflist/src/reflist.cpp,v 1.201 2006/08/10 17:23:03 cyberz Exp $
 */
//
// Basic class for working with lists. Supports name caching, sorting
// adding, deleting, merging & intersection operations
// List is represented via B+ tree
//
// Author: Alex V. Boreskoff
// Adapted:	Herman B. Gorra
// Adapted for DOS by Alexey U. Podshivalov

#define	DEF_CACHESIZE	30

#include <cstdlib>
#include <cctype>
#include <algorithm> // GARANT_GCC

#include "reflist.h"
#include "base.h"
#include "garutils.h"

#ifdef __DPMI16__
	#include "control.h"
	#include "resfile.h"
	#include "str_def.h"
	#include "garant.h"
	#include "garutils.h"
#elif _MSC_VER <= 800 && _MSC_VER > 0
	#include "windows.h"
	extern int SharedCallBack(unsigned, long);
	#define IDS_PROGRESS_PREPARELIST 0xE995
#endif

/////////////////////// static data for attribute cache /////////////////////

struct	AttrCacheEntry
{
	long	Id;			// id of documents, whose attributes area in Info
	DocInfo	Info;
	int	Next;			// index of next item in cache
};

static	int			CacheHead;	// index of most recently used record in attr cache
static	AttrCacheEntry**	Cache;
static  int			sizeCache;
static	Base*			curBase;	// current base for list being sorted
static	int			CompareBy;	// compare criterion
static	unsigned long		AZero = 0l;
static	short			compType = COMP_STD;

#define	SMART_SIZE	5000l
static	DocInfo**	DocInfos = 0;
static	char**		DocNames = 0;

short	isEnglish;

///////////////////////////////// methods //////////////////////////////////

void	SmartDelete( long aCount )
{
	if ( DocNames != 0 )
	{
		for ( long i = 0; i < aCount; i++ ) gk_free( DocNames[ i ] );
		gk_free( DocNames );
		DocNames = 0;
	}
	if ( DocInfos != 0 )
	{
		for ( long i = 0; i < aCount; i++ ) gk_free( DocInfos[ i ] );
		gk_free( DocInfos );
		DocInfos = 0;
	}
}

static int InitAttrCache ( int size )
{
	if ( size < 2 )				// since it incorrectly works when size = 1
		size = 2;

	sizeCache = std::min(size,512); // GARANT_STL

	Cache     = new AttrCacheEntry* [sizeCache];
	CacheHead = 0;

	if ( Cache != 0 )
	{
		for ( int i = 0; i < sizeCache; i++ )
		{
			Cache [i] = new AttrCacheEntry;
			Cache [i] ->Id   = 0;
			Cache [i] ->Next = i + 1;
		}

		Cache [sizeCache - 1] ->Next = -1;

		heap ();

		return 1;
	}

	heap ();

	return 0;
}

static void FreeAttrCache ()
{
	for( int i = 0; i<sizeCache; i++ )
	{
		delete Cache[i];
	}

	delete Cache;
	Cache = 0;
}

static void GetAttr( long id, DocInfo& info )
{
	if ( !Cache )
		InitAttrCache( 100 );

	if ( Cache [CacheHead] ->Id == id )		// check item at the head
		info = Cache [CacheHead] ->Info;
	else
	{
		int i = 0, j = 0; // GARANT_FORSCOPING
		for ( i = Cache [CacheHead] ->Next, j = CacheHead; ; j = i, i = Cache [i] ->Next )
		{
			if ( Cache [i] ->Id == id )	// copy data & put entry on top of list
			{
				info             = Cache [i]->Info;
				Cache [j] ->Next = Cache [i]->Next;
				Cache [i] ->Next = CacheHead;
				CacheHead        = i;

				return;
			}
			else
			if ( Cache [i] ->Next == -1 )
				break;
		}

		// item has not been found => replace last item in list
		long readed_bytes = 0;
		DocInfo* doc_info = reinterpret_cast<DocInfo*> (curBase->LoadAttr (id, IDD_INFO, readed_bytes));
		assert (readed_bytes == sizeof (DocInfo));
		memcpy (&info, doc_info, sizeof (DocInfo));
		gk_free (doc_info);

		// get rid of extra blanks & convert all to upper case
		StrUpr ( strtrim ( info.Title ) );
		Cache [j] ->Next = -1;
		Cache [i] ->Id   = id;
		Cache [i] ->Info = info;
		Cache [i] ->Next = CacheHead;
		CacheHead        = i;
	}
}

static int CompABC( Ref* r1, Ref* r2, char* aName1, long aName2 )
{
	if ( r1 -> DocId == r2 -> DocId )
		return	0;
	else
	if ( DocNames != 0 )
		return strcmp( aName1, DocNames[ aName2 ] );
	else
	{
		int	l;
		char	buf1 [DOC_NAME_SIZE + 1];
		l = curBase->FindDocName (r1->DocId, buf1);
		buf1 [l] = 0;

		char	buf2 [DOC_NAME_SIZE + 1];
		l = curBase->FindDocName (r2->DocId, buf2);
		buf2 [l] = 0;

		return strcmp( buf1, buf2 );
	}
}

inline  int     Sign ( long x )
{
        return ( x > 0 ? 1 : ( x < 0 ? -1 : 0 ) );
}

static int CompareDocs ( /*Base* aBase, short SortedBy, */const void * p1, const void * p2, char* aName1, long aName2, DocInfo* aInfo1 )
{
 	Ref    * r1  = (Ref *) p1;
	Ref    * r2  = (Ref *) p2;
	int	 res = 0;

	if ( r1 -> DocId == r2 -> DocId )
		goto sameDocs;

	if ( ( CompareBy & 0xFF ) == RL_UNSORTED )
		return compType == COMP_PLUS ? CompRefsPlus( (Ref*)r1, (Ref*)r2 ) : CompRefs( (Ref*)r1, (Ref*)r2 );
	else
	if ( ( CompareBy & 0xFF ) == RL_BYABC )
		res = CompABC( r1, r2, aName1, aName2 );
	else
	if ( ( ( CompareBy & 0xFF ) == RL_BYDATE ) || ( ( CompareBy & 0xFF ) == RL_BYDATE2 ) )
	{
		DocInfo  inf1;
		DocInfo  inf2;
		DocInfo* a1;
		DocInfo* a2;

		if ( DocInfos != 0 )
		{
			a1 = aInfo1;
			a2 = DocInfos[ aName2 ];
		}
		else
		{
			a1 = &inf1;
			a2 = &inf2;
			GetAttr( r1 -> DocId, inf1 );
			GetAttr( r2 -> DocId, inf2 );
		}

		res = ( CompareBy & 0xFF ) == RL_BYDATE ? CompDates( &a1 -> FirstDate, &a2 -> FirstDate ) : CompDates( &a1 -> LastDate, &a2 -> LastDate );
		if ( res == 0 )
			res = CompABC( r1, r2, aName1, aName2 );
	}
	else
	if ( ( CompareBy & 0xFF ) == RL_BYFORCE )
	{
		DocInfo  inf1;
		DocInfo  inf2;
		DocInfo* a1;
		DocInfo* a2;

		if ( DocInfos != 0 )
		{
			a1 = aInfo1;
			a2 = DocInfos[ aName2 ];
		}
		else
		{
			a1 = &inf1;
			a2 = &inf2;
			GetAttr( r1 -> DocId, inf1 );
			GetAttr( r2 -> DocId, inf2 );
		}

		if ( a1 -> Force != a2 -> Force )
			res = a1 -> Force < a2 -> Force ? 1 : -1;
		else
		{
			res = CompDates( &a1 -> FirstDate, &a2 -> FirstDate );
			if ( res == 0 )
			{
				res = CompABC( r1, r2, aName1, aName2 );
				if ( res != 0 ) return res;
			}
		}
	}

	if ( res == 0 ) {
sameDocs:
		//if ( !aBase || ( r1->DocId != r2->DocId ))
			return compType == COMP_PLUS ? CompRefsPlus( (Ref*)r1, (Ref*)r2 ) : CompRefs( (Ref*)r1, (Ref*)r2 ); //это старый способ сравнения

		/*
		long lSubCount;
		SubDesc* subs = (SubDesc*) aBase->docInd->Load( r1->DocId, IDD_SUBS, lSubCount );
		lSubCount = lSubCount / sizeof( SubDesc );

		if ( !subs )
			return compType == COMP_PLUS ? CompRefsPlus( (Ref*)r1, (Ref*)r2 ) : CompRefs( (Ref*)r1, (Ref*)r2 ); //это старый способ сравнения

		long	aPara1 = -1L; if ( !r1->Sub ) aPara1 = 0;
		long	aPara2 = -1L; if ( !r2->Sub ) aPara2 = 0;
		for ( long l = 0; l < lSubCount && ( aPara1 == -1 || aPara2 == -1 ); l++ ) {
			if ( subs[l].Sub == r1->Sub )
				aPara1 = subs[ l ].Para;
			else
			if ( subs[l].Sub == r2->Sub )
				aPara2 = subs[ l ].Para;
		}
		gk_free( subs );
		return Sign( aPara1 - aPara2 );
		*/
	}
	return CompareBy & RL_REVERSED ? -res : res;
}

/////////////////////////////////////////////////////////////////////////

NameCache :: NameCache ( RefList * l, int size )
{
	list      = l;
	Cache     = new DocName[ CacheSize = size ];
	FirstItem = 30000;

	assert ( Cache != 0 );
}

NameCache :: ~NameCache ()
{
	if( Cache ) delete Cache;
}

DocName * NameCache :: Item ( long item )
{
	long	newFirst = FirstItem;
	long	CSize2   = CacheSize >> 1;

	if ( item < FirstItem )
		if ( item < FirstItem - CSize2 )
			newFirst = item;		// complete refill
		else
			newFirst = FirstItem - CSize2;	// partial refill
	else
	if ( item >= FirstItem + CacheSize )
		if ( item >= FirstItem + CacheSize + CSize2 )
			newFirst = item;
		else
			newFirst = FirstItem + CSize2;
							// check for complete refill
	if ( newFirst != FirstItem )
	{
		long delta = newFirst - FirstItem;
		long from  = 0;
		long to    = CacheSize;

		FirstItem = newFirst;
		if ( labs ( delta ) >= CacheSize )
			;
		else
		if ( delta > 0 )
		{
			memmove ( Cache, Cache + delta, (size_t)(( CacheSize - delta ) * sizeof ( DocName )) );

			from = CacheSize - delta;
		}
		else
		if ( delta < 0 )
		{
			delta = -delta;
			to    = delta;

			memmove ( Cache + delta, Cache, (size_t)(( CacheSize - delta ) * sizeof ( DocName )) );
		}

		LoadItems      ( from, to );
	}

	return Cache + ( item - FirstItem );
}

int	NameCache :: LoadItems ( long from, long to )
{
	for ( long i = from; i < to; i++ )
		LoadItem ( FirstItem + i, Cache + i );

	return 1;
}

int	NameCache :: LoadItem ( long item, DocName * info )
{
	if ( item >= list -> ItemCount ) return 0;

	Ref 	ref = (*list) [ item ];
	char	buf [2 * DOC_NAME_SIZE ];
	char	sub [DOC_NAME_SIZE];
	int	nameSize;
	int	subNameSize;
	char  * ptr = (char *) info;

	memset ( info, '\0', sizeof ( DocName ) );
	memset ( buf,  '\0', 2 * DOC_NAME_SIZE );

	if ( ( nameSize = list -> base -> FindDocName ( ref.DocId, buf ) ) < 1 )
		return 0;

	if ( ( list -> Kind != RLT_CORRS ) && ( ref.Sub != 0 ) ) {
		if ( list -> Kind == RLT_EXTRACT && ref.Sub != 0 && strlen( buf ) < DOC_NAME_SIZE - 32 )
			strcat( buf, isEnglish ? " (extracts)" : " (ў Ё§ў«ҐзҐ­Ёпе)" );
		else
		if ( ( subNameSize = list -> base -> FindSubName ( ref.DocId, ref.Sub, sub ) ) > 0 )
			if ( list->ItemType( item ) != REF_CHILD && subNameSize < 301 && strlen( buf ) < DOC_NAME_SIZE - 302 )
				strcat ( strcat ( buf, ". " ), sub );
			else
			{
				memset( buf, '\0', DOC_NAME_SIZE );
				strcpy ( buf, sub );
			}
		/*
		else
		{
			char	aSub[ 32 ];
			long	aSubToPara = list -> base -> SubToPara( ref );
			if ( aSubToPara == 0 ) aSubToPara = ref.Sub;
			sprintf( aSub, ". Џ а Ја д %ld", aSubToPara );
			if ( strlen( buf ) < DOC_NAME_SIZE - strlen( aSub ) ) strcat( buf, aSub );
		}
		*/
	}

	// Format name. Start with trimming ( removing all extra spaces )
	strtrim( buf );

	memcpy( info -> Name, buf, DOC_NAME_SIZE );
	info -> Name[ DOC_NAME_SIZE - 1 ] = '\0';

#ifdef	__DPMI16__
	nameSize = strlen ( buf );
	for ( int i = 0, j = 0, k = 0, line = 0; i < nameSize; i++ )
		if ( isspace ( buf [i] ) )	// store last blank
			j = i;
		else
		if ( i - k >= Ini.TextWidth - 1 )// too long => return to last blank
		{
			buf [j] = '\0';		// mark it as end-of-line
			strcpy ( ptr, buf + k );

			ptr += Ini.TextWidth + 1;
			k    =
			i    = j + 1;
			line++;
		}

	if ( i > k )				// add last line
	{
		strcpy ( ptr, buf + k );
		ptr += Ini.TextWidth + 1;
		line++;
	}
						// now format all lines except last
	for ( i = 0; i < line - 1; i++ )
		JustifyStr ( info -> Name + i * (Ini.TextWidth + 1), Ini.TextWidth );
#endif

	return 1;
}

/////////////////////////////////////////////////////////////////////////

//short RefList::m_bKill = 0;

RefList :: RefList ( Base * b, RefCollection& refs ) : RefCollection()
{
	m_bKill = 0;
	base        = b;
	SortedBy    = RL_UNSORTED;
	Kind        = RLT_SRCRES;
	Names       = 0;
	Context     = new char [SIZE_REFLIST_CONTEXT];
	PageCount   = refs.PageCount;
	ItemCount   = refs.ItemCount;
	IsFiltered  = 0;
	Offsets     = 0;
	FilterNames = 0;
	FullPutGet  = 0;
	CheckConstriction = 0;
	StoredClassesSize = 0;

	Context[ 0 ] = '\0';

	for ( int i = 0; i < PageCount; i++ )
	{
		Pages [i] = refs.Pages [i];
		Count [i] = refs.Count [i];
	}

	refs.PageCount = 0;
	refs.ItemCount = 0;

	ResetFilter();
	CalcOffsets();
}

RefList :: RefList( Base * b, SortedCollection& coll ) : RefCollection()
{
	m_bKill = 0;
	base        = b;
	SortedBy    = RL_UNSORTED;
	Kind        = RLT_SRCRES;
	Names       = 0;
	Context     = new char [SIZE_REFLIST_CONTEXT];
	IsFiltered  = 0;
	Offsets     = 0;
	FilterNames = 0;
	FullPutGet  = 0;
	CheckConstriction = 0;
	StoredClassesSize = 0;

	Context[ 0 ] = '\0';

	for ( long i = 0; i < coll.ItemCount; i++ )	{
		Ref	ref;

		if ( coll.Tag() == OT_DOCCOLLECTION ) {
			ref.Sub = 0;
			ref.DocId = *(unsigned long*)coll[i];
		} else if ( coll.Tag() == OT_REFCOLLECTION ) {
			ref = *(Ref*)coll[i];
		} else {
			ref.Sub = 0;
			ref.DocId = 0;
		}

		if ( !Collection :: Add ( &ref ) ) {
		//if ( !Add( ref ) ) {
			MemoryError ();
			break;
		}
	}

	coll.FreeAll();

	ResetFilter();
	CalcOffsets();
}

RefList :: RefList ( Base * b, DocCollection& docs ) : RefCollection ()
{
	m_bKill = 0;
	base		= b;
	SortedBy	= RL_UNSORTED;
	Kind		= RLT_SRCRES;
	Names		= 0;
	Context		= new char [SIZE_REFLIST_CONTEXT];
	IsFiltered      = 0;
	Offsets         = 0;
	FilterNames     = 0;
	FullPutGet	= 0;
	CheckConstriction = 0;
	StoredClassesSize = 0;

	Context[ 0 ] = '\0';

	Ref	ref;
	ref.Sub = 0;
	for ( long i = 0; i < docs.ItemCount; i++ )
	{
		ref.DocId = docs [i];

		if ( !Collection :: Add ( &ref ) )
		{
			MemoryError ();
			break;
		}
	}

        ResetFilter();
	CalcOffsets();

	heap ();
}

RefList :: RefList ( Base * b, long count, Ref * ref, short aDontUseMem ) : RefCollection ( aDontUseMem ? count : RL_REFS_PER_PAGE )
{
	m_bKill = 0;
	base        = b;
	SortedBy    = RL_BYFORCE;
	Kind        = RLT_MULTIREF;
	Names       = 0;

	if ( aDontUseMem )
		Context = 0;
	else {
		Context     = new char [SIZE_REFLIST_CONTEXT];
		Context[ 0 ] = '\0';
	}

	IsFiltered  = 0;
	Offsets     = 0;
	FilterNames = 0;
	FullPutGet  = 0;
	CheckConstriction = 0;
	StoredClassesSize = 0;

	// add item in their order
	for ( long k = 0; k < count; k++, ref++ )
		if ( !Collection :: Add ( ref ) ) {
			MemoryError ();
			break;
		}

	if ( !aDontUseMem ) {
		ResetFilter();
		CalcOffsets();
	}

	heap ();
}

RefList :: RefList() : RefCollection()
{
	m_bKill = 0;
	FilterNames = 0;
	Names = 0;
	IsFiltered = 0;
	Offsets = 0;

	Context = new char [SIZE_REFLIST_CONTEXT];
	Context[ 0 ] = '\0';

	FullPutGet = 0;
	StoredClassesSize = 0;
	CheckConstriction = 0;
	assert ( 1 );
}

RefList :: RefList ( Base * b ) : RefCollection ()
{
	m_bKill = 0;
	base        = b;
	SortedBy    = RL_UNSORTED;
	Kind        = RLT_UNKNOWN;
	Names       = 0;
	Context     = new char [SIZE_REFLIST_CONTEXT];
	IsFiltered  = 0;
	Offsets     = 0;
	FullPutGet  = 0;
	FilterNames = 0;
	CheckConstriction = 0;
	StoredClassesSize = 0;

	ResetFilter();
	CalcOffsets();

	Context[ 0 ] = '\0';
}

RefList :: ~RefList ()
{
	m_bKill = 1;

	if ( Names )
	{
		delete Names;
		Names = 0;
	}

	if ( FilterNames )
	{
		delete FilterNames;
		FilterNames = 0;
	}

	if ( Context )
	{
		delete Context;
		Context = 0;
	}

	if ( Offsets )
	{
		delete Offsets;
		Offsets = 0;
	}

	if ( IsFiltered )
	{
		delete IsFiltered;
		IsFiltered = 0;
	}

	if ( StoredClassesSize ) {
		StoredClassesSize = 0;
		delete StoredClasses;
	}
}

void	RefList :: Inherit ( const RefList& list )
{
	assert(ItemCount==0);

	base          = list.base;
	SortedBy      = list.SortedBy;
	Kind          = list.Kind;
	if ( list.Context ) strcpy(Context, list.Context);

	if ( list.StoredClassesSize ) {
		StoredClassesSize = list.StoredClassesSize;
		StoredClasses = new char gk_huge[ StoredClassesSize ];
		memcpy( StoredClasses, list.StoredClasses, StoredClassesSize );
	}

	if ( Names ) Names -> Reset ();
}

RefList& RefList :: operator = ( const RefList& list )
{
	Inherit( list );

	if ( list.IsFiltered )
	{
		if ( IsFiltered )
			*IsFiltered = *list.IsFiltered;
		else
			IsFiltered = new Collection( *list.IsFiltered );
	}
	else
	{
		if ( IsFiltered ) delete IsFiltered;
		IsFiltered = 0;
	}

	if ( list.Offsets )
	{
		if ( Offsets )
			*Offsets = *list.Offsets;
		else
			Offsets = new Collection( *list.Offsets );
	}
	else
	{
		if ( Offsets ) delete Offsets;
		Offsets = 0;
	}

	CheckConstriction = list.CheckConstriction;
	RedoMask = list.RedoMask;
	CurMask = list.CurMask;
	FilterNamesPos = list.FilterNamesPos;

	if ( FilterNames )
	{
		delete FilterNames;
		FilterNames = 0;
	}

	if ( list.FilterNames )
	{
	        FilterNames = new StrCollection( 80, 32 );
		for ( short I = 0; I < list.FilterNames->ItemCount; I++ )
			FilterNames -> AddStr( (char*)(*list.FilterNames)[ I ] );
	}

	if ( list.StoredClassesSize )
	{
		StoredClassesSize = list.StoredClassesSize;
		StoredClasses = new char gk_huge[ StoredClassesSize ];
		memcpy( StoredClasses, list.StoredClasses, StoredClassesSize );
	}

	return (RefList&) Collection :: operator = ( list );
}

short	RefList :: ItemType( long no ) const
{
	if ( no > 0l && (*this)[ no - 1 ].DocId == (*this)[ no ].DocId )
		return REF_CHILD;
	else
	if ( no == ItemCount - 1 || (*this)[ no ].DocId != (*this)[ no + 1 ].DocId )
		return REF_NORMAL;
	else
		return REF_WITHCHILDS;
}

short	RefList :: FilteredItemType( long no ) const
{
        long	fNo = FilteredItem( no );
        long	fNoMinus = FilteredItem( no - 1 );
        long	fNoPlus  = FilteredItem( no + 1 );
	if ( no > 0l && (*this)[ fNoMinus ].DocId == (*this)[ fNo ].DocId )
		return REF_CHILD;
	else
	if ( no == ItemCount - 1 || (*this)[ fNo ].DocId != (*this)[ fNoPlus ].DocId )
		return REF_NORMAL;
	else
		return REF_WITHCHILDS;
}

DocName * RefList :: ItemName ( long no )
{
	if ( !Names )
	{
		Names = new NameCache( this, DEF_CACHESIZE );
		if ( ItemCount > 0 ) Names -> CacheSize = std::min<long>( DEF_CACHESIZE, std::max<long>( 1, ( (long)DEF_CACHESIZE * FilteredItemCount() ) / ItemCount )); // GARANT_STL
	}
	assert ( Names != 0 );

	return Names -> Item ( no );
}

void	RefList :: RemoveAbsents( short aDontUseMem )
{
	for ( long i = 0; i < ItemCount; ) {
		long docId = (*this)[ i ].DocId;
		DocInfo docInfo;
		if ( base->FindDocInfo( docId, docInfo ))
			if ( docInfo.Status & ( DS_DOC | DS_EDITION | DS_NODOC ) ) {
				i++;
				while ( i < ItemCount && (*this)[ i ].DocId == docId )
					i++;
				continue;
			}
		while ( i < ItemCount  && (*this)[ i ].DocId == docId )
			atDelete ( i );
	}

	if ( !aDontUseMem ) {
		ResetFilter();
		CalcOffsets();
	}
}

int	RefList :: RemoveAbsentAndNoDocs ()
{
	if ( DocCount() < 2000 ) {
		RemoveAbsents();
		return 1;
	}

	DocCollection* refs = base -> AllDocs();

#ifdef __DPMI16__
	ProgressWindow1 prWnd = ProgressWindow1 ( appMessages -> LoadString (MSG_LIST_PREPARING), ItemCount );
	MouseSetCursor ( WaitCursor );
#elif _MSC_VER <= 800 && _MSC_VER > 0
	InitProgress( ItemCount - 1, "Удаляются отсутствующие документы" );
	SetCursor();
#endif

	for ( long i = 0; i < ItemCount; )
	{
		long	pos;
		Ref	ref = (*this)[ i ]; ref.Sub = 0;
		if ( ref.DocId < 100000l || refs -> Search( &ref, pos )) {
			while ( i < ItemCount && (*this)[ i ].DocId == ref.DocId )
				i++;
		} else {
			//atDelete ( i );
			while ( i < ItemCount && (*this)[ i ].DocId == ref.DocId )
				atDelete( i );
		}
    
	#ifdef	__DPMI16__
		if ( !prWnd.IncValue ( 1 ) ) break;
	#elif _MSC_VER <= 800 && _MSC_VER > 0
		if ( !IncProgressValue() ) return 0;
	#endif
	}
	
	delete refs;

#ifdef	__DPMI16__
	prWnd.Hide();
	MouseSetCursor ( ArrowCursor );
#elif _MSC_VER <= 800 && _MSC_VER > 0
	SetCursor( 0 );
	if ( !ReleaseProgress () ) return 0;
#endif
	ResetFilter();
	CalcOffsets();
	return 1;
}

int	RefList :: SortInit ( long size, int compBy, int smart )
{
	if ( ( compBy&0xFF ) != RL_UNSORTED )
		if ( !InitAttrCache ( (unsigned) size ) )
			return 0;

	curBase   = base;		// setup base
	CompareBy = compBy;		// setup compare method

	if ( Names )
	{
		delete Names;			// have to since all item positions will be changed
		Names = 0;
	}

#ifdef	__DPMI16__
	if ( !smart || ItemCount > SMART_SIZE )
		return 1;

	heap();

	short	aReadNames = ((( SortedBy & 0xFF ) == RL_BYFORCE ) && ItemCount > 499 ) || (( SortedBy & 0xFF ) == RL_BYABC ) ? 1 : 0;
	short	aReadInfo  = (( SortedBy & 0xFF ) != RL_BYABC ) && ItemCount > 499 ? 1 : 0;

	if ( aReadNames ) DocNames = (char**)    gk_malloc( ItemCount * sizeof( char*    ));
	if ( aReadInfo  ) DocInfos = (DocInfo**) gk_malloc( ItemCount * sizeof( DocInfo* ));

	if ( DocNames || DocInfos )
	{
		ProgressWindow1 progWnd( appMessages -> LoadString( MSG_PREPARE_DOC_LIST ), ItemCount, 1 );

		for ( long i = 0; i < ItemCount; i++ )
		{
			Ref	aRef = (*this)[ i ];

			if ( DocInfos )
			{
				DocInfo* aDocInfo = (DocInfo*) gk_malloc( sizeof( DocInfo ));
				DocInfos[ i ] = aDocInfo;
				curBase -> FindDocAttr( aRef.DocId, IDD_INFO, (void*)aDocInfo, sizeof( DocInfo ));
			}
			if ( DocNames )
			{
				char*	aBuf = (char*) gk_malloc( DOC_NAME_SIZE + 1 );
				DocNames[ i ] = aBuf;
				int l = curBase -> docInd -> Get( aRef.DocId, IDD_NAME, aBuf, DOC_NAME_SIZE );
				aBuf[ l ] = 0;
			}

			if ( !progWnd.IncValue( 1 ))
			{
				SmartDelete( i );
				progWnd.Hide();
				return 0;
			}
		}

		progWnd.Hide();
	}

	heap();
#endif

	return 1;
}

void	RefList :: SortDone ()
{
	SmartDelete( ItemCount );

	if ( ( CompareBy & 0xFF ) != RL_UNSORTED ) FreeAttrCache();

#ifdef __DPMI16__
	MouseSetCursor( ArrowCursor );
#elif _MSC_VER <= 800 && _MSC_VER > 0
	SetCursor( 0 );
#endif

	if ( Names )
	{
		delete Names;
		Names = 0;
	}
	Names = new NameCache ( this, DEF_CACHESIZE );

	CalcOffsets();
}

void	RefList :: Sift ( long l, long r )
{
	char*		aDocName = 0;
	DocInfo*	aDocInfo = 0;
	unsigned long	aX = *(unsigned long *)(*IsFiltered)[ l - 1 ];
	Ref		x = (*this) [l-1];

	if ( DocNames != 0 ) aDocName = DocNames[ l - 1 ];
	if ( DocInfos != 0 ) aDocInfo = DocInfos[ l - 1 ];

	long i = l, j = l << 1; // GARANT_FORSCOPING
	for ( i = l, j = l << 1; j <= r; )
	{
		if ( j < r )
			if ( CompareDocs ( /*Kind == RLT_CORRS ? 0 : base, SortedBy, */&(*this) [j-1], &(*this) [j], DocNames == 0 ? 0 : DocNames[ j - 1 ], j, DocInfos == 0 ? 0 : DocInfos[ j - 1 ] ) < 0 )
				j++;

		if ( CompareDocs ( /*Kind == RLT_CORRS ? 0 : base, SortedBy, */&x, &(*this) [j-1], aDocName, j-1, aDocInfo ) >= 0 )
			break;

		(*this) [i-1] = (*this) [j-1];
		*(unsigned long*)(*IsFiltered)[ i - 1 ] = *(unsigned long*)(*IsFiltered)[ j - 1 ];
		if ( DocNames != 0 ) DocNames[ i - 1 ] = DocNames[ j - 1 ];
		if ( DocInfos != 0 ) DocInfos[ i - 1 ] = DocInfos[ j - 1 ];

		i = j;
		j = i << 1;
	}

	(*this) [i-1] = x;
	*(unsigned long*)(*IsFiltered)[ i - 1 ] = aX;
	if ( DocNames != 0 ) DocNames[ i - 1 ] = aDocName;
	if ( DocInfos != 0 ) DocInfos[ i - 1 ] = aDocInfo;
}

void	RefList :: Del( long pos )
{
	if ( Names ) Names -> Reset();

	if ( CheckConstriction )
	{
		long aDocId = ((*this)[ pos ]).DocId;
		long I = 0l; while ( I < ItemCount )
		{
			if ( (*this)[ I ].DocId == aDocId )
			{
				if ( IsFiltered ) IsFiltered -> atDelete( I );
				atDelete( I );
			}
			else
				I++;
		}
		CalcOffsets();
	}
	else
	{
		if ( Offsets != 0 )
		{
			for ( long I = 0; I < Offsets -> ItemCount; I++ )
			{
				if ( * (long*) (*Offsets)[ I ] == pos )
				{
					Offsets -> atDelete( I );
					for ( long J = I; J < Offsets -> ItemCount; J++ )
						*(long*)(*Offsets)[ J ] = *(long*)(*Offsets)[ J ] - 1;
					break;
				}
			}
		}
		atDelete( pos );
		if ( IsFiltered ) IsFiltered -> atDelete( pos );
	}
}

void	RefList :: DelAll ()
{
	if ( Names ) Names -> Reset ();

	FreeAll ();

	ResetFilter();
	CalcOffsets();

	heap ();
}

int	RefList :: Merge ( RefList& list )
{
	if ( list.ItemCount == 0 ) return 1;

	long	aPrevItemCount = ItemCount;

	short	aCheckConstriction = CheckConstriction;
	if ( CheckConstriction ) UndoReduceRefsBySub();
	RemoveNonFiltered();

	if ( !SortInit ( ItemCount + list.ItemCount, SortedBy, 0 ) )
		return 0;			// but the sorting mehod remains the same

#ifdef __DPMI16__
	ProgressWindow1 prWnd = ProgressWindow1 ( appMessages -> LoadString( MSG_LIST_ADDING ), list.ItemCount - 1, 1, ItemCount + list.ItemCount > SMART_SIZE );
#elif _MSC_VER <= 800 && _MSC_VER > 0
	InitProgress( list.ItemCount - 1, "Объединение списков" );
#endif
							// for correct merging we'll need compares
	for ( long i = 0; i < list.ItemCount; i++ )
	{
		// get reference and insert in into sorted collection
		Ref	ref = list[ i ];
		Insert( &ref );

	#ifdef __DPMI16__
		prWnd.IncValue( 1 );
	#elif _MSC_VER <= 800 && _MSC_VER > 0
		if ( !IncProgressValue() ) return 0;
	#endif
	}
	
	if ( !strlen(Context) )
		strcpy ( Context, list.Context );

	SortDone ();
	heap     ();

	if ( FilterNames )
	{
		delete FilterNames;
		FilterNames = 0;
	}

    ResetFilter();
	if ( aPrevItemCount == 0 && list.Kind == RLT_EXTRACT ) {
		Kind = RLT_EXTRACT;
		if ( list.StoredClassesSize ) {
			StoredClassesSize = list.StoredClassesSize;
			StoredClasses = new char gk_huge[ StoredClassesSize ];
			memcpy( StoredClasses, list.StoredClasses, StoredClassesSize );
		}
	}
	else
	if ( Kind == RLT_EXTRACT /*&& list.Kind != RLT_EXTRACT*/ ) {
		aCheckConstriction = false;
		Kind = RLT_SRCRES;
		if ( StoredClassesSize ) {
			StoredClassesSize = 0;
			delete StoredClasses;
		}
	}

	if ( aCheckConstriction || Kind == RLT_EXTRACT )
		ReduceRefsBySub();

	CalcOffsets();

#ifdef __DPMI16__
	prWnd.Hide();
#elif _MSC_VER <= 800 && _MSC_VER > 0
	ReleaseProgress();
#endif
	return 1;
}

int	RefList :: Minus( RefList& list )
{
	if ( list.ItemCount == 0 )
		return 0;

#ifdef __DPMI16__
#elif _MSC_VER <= 800 && _MSC_VER > 0
	InitProgress( ItemCount - 1, "Вычитание списков" );
	SetCursor();
#endif
	RemoveNonFiltered();

	compType = COMP_MINUS;
	for ( long I = 0; I < ItemCount; )
	{
		Ref	ref = (*this)[ I ];
		long	pos = 0;
		if ( list.Search( &ref, pos ))
			atDelete( I );
		else
		/*
		if ( ref.Sub )
		{
			ref.Sub = 0;
			if ( list.Search( &ref, pos ))
				atDelete( I );
			else
				I++;
		}
		else
		*/
			I++;

#ifdef __DPMI16__
#elif _MSC_VER <= 800 && _MSC_VER > 0
		if ( !IncProgressValue() )
			break;
	#endif
		
	}

	m_bCompType = COMP_STD;
	ResetFilter();
	CalcOffsets();	

#ifdef __DPMI16__
#elif _MSC_VER <= 800 && _MSC_VER > 0
	ReleaseProgress();
	SetCursor(0);
#endif

	return 1;
}

int	RefList :: Intersect ( RefList& list )
{
	if ( list.ItemCount == 0 ) return 0;

	short aCheckConstriction = CheckConstriction;
	if ( CheckConstriction ) UndoReduceRefsBySub();
	RemoveNonFiltered();

#ifdef __DPMI16__
	ProgressWindow1 prWnd = ProgressWindow1 ( appMessages -> LoadString( MSG_LIST_SUBTRACTING ), ItemCount - 1, 1, ItemCount + list.ItemCount > SMART_SIZE );
#elif _MSC_VER <= 800 && _MSC_VER > 0
	InitProgress( ItemCount - 1, "Пересечение списков" );
	SetCursor();
#endif

	// we'll need compares in the list. Use list.SortedBy for list.Search
	if ( !list.SortInit ( ItemCount + list.ItemCount, list.SortedBy, 0 ) )
		return 0;

	compType = COMP_PLUS;
	int page = 0; // GARANT_FORSCOPING
	for ( page = 0; page < PageCount; page++ )
	{					// for every item on page
		Ref  * pagePtr = (Ref *) Pages [page];
		int i = 0, j = 0; // GARANT_FORSCOPING
		for ( i = 0, j = 0; i < Count [page]; i++ )
		{				// get reference to check
			long	k;
			int	leave = 0;	// whether we should leave current item

			// if sub is named then leave it if same doc presents in another list
			leave = list.Search( &pagePtr[ i ], k );

			if ( leave )		// if ref is to be leaved then copy it to page
				pagePtr [j++] = pagePtr [i];

#ifdef __DPMI16__
			if ( !prWnd.IncValue( 1 )) break;
#elif _MSC_VER <= 800 && _MSC_VER > 0
			if ( !IncProgressValue() ) break;
#endif

		}		
		Count [page] = j;
	}
	compType = COMP_STD;

	ItemCount = 0;				// find total # of items
	for ( page = 0; page < PageCount; page++ )
		ItemCount += Count [page];
	list.SortDone ();

	if ( FilterNames )
	{
		delete FilterNames;
		FilterNames = 0;
	}

	ResetFilter();
	if ( aCheckConstriction ) ReduceRefsBySub();
	CalcOffsets();

#ifdef __DPMI16__
	prWnd.Hide();
#elif _MSC_VER <= 800 && _MSC_VER > 0
	SetCursor( 0 );
	ReleaseProgress();
#endif

	if ( !strlen(Context) )
		strcpy ( Context, list.Context );

	return 1;
}

int	RefList :: Sort ( int by )
{
	SortedBy  = by;
	CompareBy = by;

	if ( ItemCount < 2 )
		return SortedBy;

	if ( !IsFiltered )
	{
		ResetFilter();
		CalcOffsets();
	}

	if ( !SortInit ( ItemCount, SortedBy, 1 ) )
	{
		SortedBy = RL_UNSORTED;
		return SortedBy;
	}
	
	heap ();
    
#ifdef	__DPMI16__
	ProgressWindow1 prWnd ( appMessages -> LoadString (MSG_LIST_SORTING), ItemCount + ( ItemCount >> 1 ) - 1, 1, ItemCount > SMART_SIZE );
#elif _MSC_VER <= 800 && _MSC_VER > 0
	InitProgress( ItemCount + ( ItemCount >> 1 ) - 1, "Сортировка списка" );
	SetCursor();
#endif

	long L = ( ItemCount >> 1 ) + 1;
	long R = ItemCount;

	int	bInterrupted = 0;

	long l = L; // GARANT_FORSCOPING
	for( l = L; l > 1; )
	{
		Sift ( --l, R );

	#ifdef	__DPMI16__
		if ( !prWnd.IncValue( 1 ) )
		{
			bInterrupted = 1;
			break;
		}
	#elif _MSC_VER <= 800 && _MSC_VER > 0
		if ( !IncProgressValue() )
		{
			bInterrupted = 1;
			break;
		}
	#endif
	}

	if ( !bInterrupted ) for ( long r = R; r > 1; )
	{
		Ref   * ptr1 = &(*this) [0];
		Ref   * ptr2 = &(*this) [r-1];
		Ref	ref;

		// swap ref [0] & ref [r-1]
		ref    = * ptr1;
		* ptr1 = * ptr2;
		* ptr2 = ref;

		if ( DocNames != 0 )
		{
			char*	aDocName = DocNames[ 0 ];
			DocNames[ 0 ] = DocNames[ r - 1 ];
			DocNames[ r - 1 ] = aDocName;
		}
		if ( DocInfos != 0 )
		{
			DocInfo* aDocInfo = DocInfos[ 0 ];
			DocInfos[ 0 ] = DocInfos[ r - 1 ];
			DocInfos[ r - 1 ] = aDocInfo;
		}

		// надо также переставить и эти элементы в IsFiltered
		unsigned long	*bPtr1 = (unsigned long *)(*IsFiltered)[ 0 ];
		unsigned long	*bPtr2 = (unsigned long *)(*IsFiltered)[ r-1 ];
		unsigned long	aLong;

		aLong   = * bPtr1;
		* bPtr1 = * bPtr2;
		* bPtr2 = aLong;

		Sift ( l, --r );

	#ifdef	__DPMI16__
		if ( !prWnd.IncValue( 1 ) )
		{
			bInterrupted = 1;
			break;
		}
	#elif _MSC_VER <= 800 && _MSC_VER > 0
		if ( !IncProgressValue() )
		{
			bInterrupted = 1;
			break;
		}
	#endif

	}

	if ( m_bKill ) return 0;

#ifdef	__DPMI16__
	prWnd.Hide();
#elif _MSC_VER <= 800 && _MSC_VER > 0
	SetCursor( 0 );
	ReleaseProgress();
#endif
	if ( m_bKill ) return 0;

	heap ();

	SortDone ();
	if ( bInterrupted )
		SortedBy = RL_UNSORTED;

	return SortedBy;
}

int	RefList :: Put ( Store * str )
{
	if ( Kind == RLT_EXTRACT ) {
		FullPutGet = true;
		ResetFilter();
	}

	long	aItemCount = FullPutGet ? ItemCount : FilteredItemCount();
	short	aDead = (short)0xDEAD;

	str -> Write ( &Kind, sizeof ( Kind ) );
	str -> Write ( &aItemCount, sizeof ( aItemCount ) );
	str -> Write ( &SortedBy, sizeof ( SortedBy ) );
	str -> Write ( Context, SIZE_REFLIST_CONTEXT );

	if ( FullPutGet && Offsets != 0 )
	{
		// надо полностью записать коллекцию и фильтры

		FullPutGet = 0;

		str -> Write( &CurMask,  sizeof( CurMask  ));
		str -> Write( &RedoMask, sizeof( RedoMask ));
		str -> Write( &CheckConstriction, sizeof( CheckConstriction ));

		str -> Write( &FilterNamesPos, sizeof( FilterNamesPos ));
		long aCount = FilterNames ? FilterNames -> ItemCount : 0l;
		str -> Write( &aCount, sizeof( aCount ));
		long I = 0; // GARANT_FORSCOPING
		for ( I = 0; I < aCount; I++ )
			str -> Write( (*FilterNames)[ I ], FilterNames -> ItemSize );
		str -> Write( &aDead, sizeof( aDead ));

		if ( !IsFiltered ) ResetFilter();

		u_int32_t gk_huge *aFiltereds = (u_int32_t gk_huge*) gk_malloc( sizeof( u_int32_t ) * 8192 );
		for ( I = 0; I < aItemCount; I++ ) {
			short J = 0; // GARANT_FORSCOPING
			for ( J = 0; J < 8192 && I < aItemCount; I++, J++ )
				aFiltereds[ J ] = *(u_int32_t gk_huge*)(*IsFiltered)[ I ];

			str -> Write( aFiltereds, sizeof( u_int32_t ) * J );
		}
		gk_free( aFiltereds );
		str -> Write( &aDead, sizeof( aDead ));

		Collection :: Put( str );

		if ( Kind == RLT_EXTRACT && StoredClassesSize ) {
			str->Write( &StoredClassesSize, sizeof( StoredClassesSize ));
			str->Write( StoredClasses, StoredClassesSize );
		}

		return	1;
	}
	else
	{
		Ref gk_huge *atIs = (Ref gk_huge*) gk_malloc( 4096 * sizeof( Ref ));
		for ( long I = 0; I < aItemCount; ) {
			short J = 0; // GARANT_FORSCOPING
			for ( J = 0; J < 4096 && I < aItemCount; I++, J++ )
                		atIs[ J ] = (*this)[ FilteredItem( I ) ];

			str -> Write( atIs, J * sizeof( Ref ));
		}
		gk_free( atIs );
		return 1;
	}
}

int	RefList :: Get ( Store * str )
{
	short	aDead;
	DelAll ();

	if ( Names ) Names -> Reset ();

	str   -> Read ( &Kind, sizeof ( Kind ) );
	str   -> Read ( &ItemCount, sizeof ( ItemCount ) );
	str   -> Read ( &SortedBy, sizeof ( SortedBy ) );
	str   -> Read ( Context, SIZE_REFLIST_CONTEXT );

	if ( Kind == RLT_EXTRACT )
		FullPutGet = true;

	if ( FullPutGet )
	{
		str -> Read( &CurMask,  sizeof( CurMask  ));
		str -> Read( &RedoMask, sizeof( RedoMask ));
		str -> Read( &CheckConstriction, sizeof( CheckConstriction ));

		str -> Read( &FilterNamesPos, sizeof( FilterNamesPos ));
		long aCount;
		str -> Read( &aCount, sizeof( aCount ));
		if ( aCount )
		{
			FilterNames = new StrCollection( 80, 32 );
			char	aFilterName[ 80 ];
			for ( long I = 0; I < aCount; I++ )
			{
				str -> Read( aFilterName, FilterNames -> ItemSize );
				FilterNames -> AddStr( aFilterName );
			}
		}
		str -> Read( &aDead, sizeof( aDead ));

		IsFiltered = new Collection( sizeof( unsigned long ), 8000 );

		u_int32_t gk_huge *aFiltereds = (u_int32_t gk_huge *) gk_malloc( 8192 * sizeof( u_int32_t ));
		long	itemsReaded = 0;
		for ( long I = 0; I < ItemCount; ) {
			str -> Read( aFiltereds, sizeof( u_int32_t ) * ( itemsReaded + 8192 < ItemCount ? 8192 : ItemCount - itemsReaded ));
		short J = 0; // GARANT_FORSCOPING
		for ( J = 0; J < 8192 && I < ItemCount; I++, J++ )
				IsFiltered -> Add( &aFiltereds[ J ] );
			itemsReaded += J;
		}
		gk_free( aFiltereds );
		str -> Read( &aDead, sizeof( aDead ));
	}

	PageCount = (long) ( ItemCount + RL_REFS_PER_PAGE - 1 ) / (long) RL_REFS_PER_PAGE;
	for ( int page = 0; page < PageCount; page++ )
	{
		if ( ( Pages[ page ] = AllocPage() )  == 0 )
		{
			PageCount = page;
			ItemCount = PageCount * RL_REFS_PER_PAGE;
			return 0;
		}

		Count[ page ] = (long) ( ItemCount - page * RL_REFS_PER_PAGE );
		if ( Count[ page ] > RL_REFS_PER_PAGE ) Count[ page ] = RL_REFS_PER_PAGE;

		str -> Read( Pages[ page ], Count[ page ] * sizeof( Ref ));
	}

	if ( Kind == RLT_EXTRACT ) {
		str->Read( &StoredClassesSize, sizeof( StoredClassesSize ));
		StoredClasses = new char gk_huge[ StoredClassesSize ];
		str->Read( StoredClasses, StoredClassesSize );
	}

	if ( !FullPutGet )
	{
		IsFiltered  = 0;
		Offsets     = 0;
		ResetFilter();
	}

	FullPutGet = 0;
	CalcOffsets();
	if ( Names )
	{
		Names -> Reset();
		if ( ItemCount > 0 ) Names -> CacheSize = std::min<long>( DEF_CACHESIZE, std::max<long>( 1, ( (long)DEF_CACHESIZE * FilteredItemCount() ) / ItemCount ));
	}

	return 1;
}

int	RefList :: Compare ( const void * p1, const void * p2 ) const
{
	if ( ((SortedBy & 0xFF) == RL_BYDATE ) || ((SortedBy & 0xFF) == RL_BYDATE2) )
	{
		Ref    * r1 = (Ref *) p1;
		Ref    * r2 = (Ref *) p2;
		int	 res;

		DocInfo  inf1;
		DocInfo  inf2;

		int size1 = curBase -> FindDocAttr ( r1->DocId, IDD_INFO, &inf1, sizeof (DocInfo) );
		int size2 = curBase -> FindDocAttr ( r2->DocId, IDD_INFO, &inf2, sizeof (DocInfo) );

		if ( size1 != sizeof ( DocInfo ) )
			return SortedBy & RL_REVERSED ? -1 : 1;

		if ( size2 != sizeof ( DocInfo ) )
			return SortedBy & RL_REVERSED ? 1 : -1;

		if ( (SortedBy & 0xFF) == RL_BYDATE )
			res = CompDates ( &inf1.FirstDate, &inf2.FirstDate );
		else
		if ( (SortedBy & 0xFF) == RL_BYDATE2 )
			res = CompDates ( &inf1.LastDate, &inf2.LastDate );

		if ( res == 0 )
		{
			int	l;
			char	buf1 [DOC_NAME_SIZE + 1];
			l = curBase->FindDocName (r1->DocId, buf1);
			buf1 [l] = 0;
			
			char	buf2 [DOC_NAME_SIZE + 1];
			l = curBase->FindDocName (r2->DocId, buf2);
			buf2 [l] = 0;
			res = strcmp (buf1, buf2);
		}

		if ( res == 0 )
			return ( compType == COMP_PLUS ? CompRefsPlus( (Ref*)r1, (Ref*)r2 ) : CompRefs( (Ref*)r1, (Ref*)r2 ));

		return SortedBy & RL_REVERSED ? -res : res;
	}
	else
		return CompareDocs ( /*base, SortedBy, */(Ref *) p1, (Ref *) p2, 0, 0, 0 );
}

void	RefList :: ResetFilter()
{
	if ( IsFiltered ) {
		delete IsFiltered;
		IsFiltered = 0;
	}

	if ( ItemCount > 0 ) {
		IsFiltered = new Collection( sizeof( unsigned long ), 8000 );
		for ( long I = 0; I < ItemCount; I++ )
			IsFiltered -> Add( &AZero );
	}

	CurMask  = 1l;
	RedoMask = 1l;
}

short	RefList :: IsItemNonFiltered( long aItem ) const
{
	if ( IsFiltered == 0 )
		return true;
	else {
		unsigned long atI = *(unsigned long*)(*IsFiltered)[ aItem ];
		if ( ( atI & CurMask ) == 0l )
			return true;
		else
			return false;	
	}
}

void	RefList :: CalcOffsets()
{
	if ( Offsets )
	{
		delete Offsets;
		Offsets = 0;
	}

	if ( IsFiltered != 0 && ItemCount > 0 )
	{
		Offsets = new Collection( sizeof( long ), 8000 );
		for ( long I = 0; I < ItemCount; I++ )
		{
			unsigned long atI = *(unsigned long*)(*IsFiltered)[ I ];
			if ( ( atI & CurMask ) == 0l )
				if ( !CheckConstriction || ( CheckConstriction && (( atI & 0x80000000l ) == 0l )))
					Offsets -> Add( &I );
		}
	}

	if ( Names )
	{
		Names -> Reset();
		if ( ItemCount > 0 ) Names -> CacheSize = std::min<long>( DEF_CACHESIZE, std::max<long>( 1, ( (long)DEF_CACHESIZE * FilteredItemCount() ) / ItemCount )); // GARANT_STL
	}
}

long	RefList :: FilteredItemCount() const
{
	if ( Offsets != 0 )
		return Offsets -> ItemCount;
	else
		return ItemCount;
}

long	RefList :: FilteredDocCount() const
{
        long	aCount = 0;
        for ( long I = 0; I < FilteredItemCount(); I++ )
        	if ( FilteredItemType( I ) != REF_CHILD )
        		aCount++;
	return aCount;
}

long	RefList :: FilteredItem( long item ) const
{
	if ( Offsets != 0 && item < Offsets -> ItemCount )
	{
		long aItem = * (long*) (*Offsets)[ item ];
		return aItem;
	}
	else
		return item;
}

void	RefList :: RemoveNonFiltered( short aRecalculate )
{
	if ( IsFiltered )
	{
		if ( FilteredItemCount() < ItemCount )
		{
			for ( long I = ItemCount - 1; I >= 0; I-- )
			if ( ( ( *(unsigned long*)(*IsFiltered)[ I ] ) & CurMask ) != 0 )
				atDelete( I );
		}

		delete IsFiltered;
		IsFiltered = 0;
	}

	if ( Names ) Names -> Reset ();

	if ( aRecalculate )
	{
		ResetFilter();
		CalcOffsets();
	}
}

short	RefList :: ApplyFilter( Filter *aFilter )
{
	if ( !aFilter ) return AFRES_EMPTYFILTER;
	if ( !IsFiltered ) ResetFilter();

#ifdef  __DPMI16__
	char* aHint = appMessages -> LoadString( MSG_PREPARE_FILTER );
	InfoWindow *info = new InfoWindow( 36 - strlen( aHint ) / 2, 9, strlen( aHint ) + 4, 5, deskTop, aHint );
	info -> Show();
	MouseSetCursor( WaitCursor );
#endif

	short aRes = Filtration ( (SortedCollection*) aFilter -> GetRefs() );
	if ( aRes == AFRES_OK ) AddFilterName( aFilter -> Name() );

#ifdef  __DPMI16__
	delete info;
	MouseSetCursor( ArrowCursor );
#endif

	return aRes;
}

short	RefList :: Filtration( SortedCollection* pfilt )
{
	RefCollection *refs = (RefCollection *) pfilt;
	if ( !refs ) return AFRES_EMPTYFILTER;

	if ( !IsFiltered ) ResetFilter();

#ifdef  __DPMI16__
	ProgressWindow1 prWnd = ProgressWindow1( appMessages -> LoadString( MSG_APPLYFILTER ), ItemCount );
	MouseSetCursor ( WaitCursor );
#elif _MSC_VER <= 800 && _MSC_VER > 0
	InitProgress( ItemCount - 1, "Применяется фильтр" );
	SetCursor();
#endif

	short	nonBreaked = 1;
	unsigned long PrevMask = CurMask;
	if ( CurMask != 0x40000000l ) CurMask <<= 1;

	refs -> m_bCompType = COMP_PLUS;              // Advanced compare method ON
	for ( long I = 0; I < ItemCount; I++ )
	{
		int docsPresent = 0;

	#ifdef __DPMI16__
		if ( !prWnd.IncValue( 1 )) nonBreaked = 0;
	#elif _MSC_VER <= 800 && _MSC_VER > 0
		if ( !IncProgressValue() ) break;
	#endif

		unsigned long *lPtr         = (unsigned long*)(*IsFiltered)[ I ];
		unsigned long aConstrictBit = *lPtr & 0x80000000l;
		unsigned long aPrevBit      = *lPtr & PrevMask;

		if ( nonBreaked && aPrevBit == 0l ) // документ "виден" в списке, и надо его отфильтровать
		{
			long	pos;
			Ref	ref = (*this)[ I ];
			if ( Kind == RLT_CORRS ) ref.Sub = 0;
			docsPresent = refs -> Search( &ref, pos );
			if ( !docsPresent && ref.Sub > 0 )
			{
				ref.Sub = 0;
				refs -> m_bCompType = COMP_STD;
				docsPresent = refs -> Search( &ref, pos );
				refs -> m_bCompType = COMP_PLUS;
			}
		}
		else
			docsPresent = 0;

		if ( PrevMask == 0x40000000l )
		{
			// применение 31 фильтра, надо сдвинуть маску вправо
			*lPtr = ( *lPtr >> 1 ) | aConstrictBit;
		}

		if ( docsPresent )
		{
			*lPtr = *lPtr & ~CurMask;
		}
		else
		{
			// документ не прошел фильтрацию, надо выставить бит
			*lPtr = *lPtr | CurMask;
		}
	}
    if ( m_bKill ) return 0;
#ifdef	__DPMI16__
	prWnd.Hide();
	MouseSetCursor( ArrowCursor );
#elif _MSC_VER <= 800 && _MSC_VER > 0
	SetCursor( 0 );
	ReleaseProgress();
#endif
    if ( m_bKill ) return 0;
	CalcOffsets();

	if ( FilteredItemCount() )
	{
		RedoMask = CurMask;	
		return AFRES_OK;
	}
	else
	{
		CurMask >>= 1;
		RedoMask = CurMask;
		CalcOffsets();

		return AFRES_EMPTYRESULT;
	}
}

void	RefList :: UndoReduceRefsBySub()
{
	CheckConstriction = 0;
	for ( long I = 0; I < ItemCount; I++ )
	{
		unsigned long *lPtr = (unsigned long*)(*IsFiltered)[ I ];
		*lPtr &= 0x7FFFFFFFl;
	}
	CalcOffsets();
}

long	RefList :: ReduceRefsBySub( Base* pbase )
{
	if ( !IsFiltered ) ResetFilter();

#ifdef  __DPMI16__
	ProgressWindow1 prWnd = ProgressWindow1( appMessages -> LoadString( MSG_CONSTRICT_PROGRESS ), ItemCount );
	MouseSetCursor ( WaitCursor );
#elif _MSC_VER <= 800 && _MSC_VER > 0
	InitProgress( ItemCount - 1, "Сворачивание ссылок" );
	SetCursor();
#endif

	CheckConstriction = 1;

	for ( long I = 0; I < ItemCount; I++ )
	{
	#ifdef	__DPMI16__
		if ( !prWnd.IncValue( 1 )) break;
	#elif _MSC_VER <= 800 && _MSC_VER > 0
		if ( !IncProgressValue()) break;
	#endif

		unsigned long *lPtr = (unsigned long*)(*IsFiltered)[ I ];

		if ( ItemType( I ) == REF_CHILD )
			*lPtr |= 0x80000000l;
		else
			*lPtr &= 0x7FFFFFFFl;
	}
    if ( m_bKill ) return 0;
#ifdef	__DPMI16__
	prWnd.Hide();
	MouseSetCursor( ArrowCursor );
#elif _MSC_VER <= 800 && _MSC_VER > 0
	SetCursor( 0 );
	ReleaseProgress();
#endif
	if ( m_bKill ) return 0;
	CalcOffsets();

	return 1;
}

short	RefList :: UndoFilter( short EnableRedo )
{
	if ( CanUndo() )
	{
		CurMask >>= 1;
		CalcOffsets();
		if ( !EnableRedo ) RedoMask = CurMask;
		FilterNamesPos--;
		return 1;
	}
	else
		return 0;
}

short	RefList :: RedoFilter()
{
	if ( CanRedo() )
	{
		CurMask <<= 1;
		CalcOffsets();
		FilterNamesPos++;
		return 1;
	}
	else
		return 0;
}

#if _MSC_VER <= 800 && _MSC_VER > 0
void	RefList :: InitProgress( long nInit, const char * lpszMessage )
{
	m_nCurPos = 0;
	draw_Pos  = 0;
	m_nMax    = nInit;
	SharedCallBack( IDS_PROGRESS_PREPARELIST, -100l );
}

int	RefList :: ReleaseProgress(void)
{
	return SharedCallBack(0,0);
}

int	RefList :: IncProgressValue()
{
	++m_nCurPos;

	short prev_draw_Pos = draw_Pos;
	draw_Pos = (int) ( ( m_nCurPos * 100l ) / max( m_nMax, 1 ));

	if ( draw_Pos != prev_draw_Pos )
		return SharedCallBack( 0, draw_Pos );
	else
		return 1;
}

void	RefList :: SetCursor(int nWait )
{
	if (nWait) SharedCallBack(1,0);
	else SharedCallBack(2,0);
}
#endif

void	RefList :: AddFilterName( const char* aFilterName )
{
	if ( !FilterNames )
	{
		FilterNames = new StrCollection( 80, 32 );
		FilterNamesPos = -1;
	}

	FilterNamesPos++;

	while ( FilterNames -> ItemCount != FilterNamesPos )
		FilterNames -> atDelete( FilterNames -> ItemCount - 1 );

        if ( FilterNamesPos == 32 )
        {
        	FilterNames -> atDelete( 0 );
        	FilterNamesPos--;
	}

        if ( strlen( aFilterName ))
		FilterNames -> AddStr( (char*)aFilterName );
	else
        	FilterNames -> AddStr( "$TEMP$" );
}

void	RefList :: DeleteFilterName()
{
	if ( FilterNames )
		FilterNames -> atDelete( FilterNamesPos-- );
}

char*	RefList :: GetFilterName()
{
        if ( FilterNames && FilterNamesPos != -1 )
        	if ( FilterNamesPos < FilterNames -> ItemCount )
			return (char*)(*FilterNames)[ FilterNamesPos ];
		else
			return 0;
	else
		return 0;
}
