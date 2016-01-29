//
// Collection of doc references ( struc Ref's )
// Supports adding, deleting items,
// merging & intersection of collections
//
// Author : Alex V. Boreskoff
//
// Last modification 5/10/96
//

#ifndef __REF_COLLECTION__
#define __REF_COLLECTION__

#define	REL_COL_PAGE_SIZE  16384
#define	REF_PAGE_SIZE      16384
#define CORRREFS_PAGE_SIZE 16384

#define OT_REFCOLLECTION        101
#define OT_RELECOLLECTION       102
#define	OT_RELESUBCOLLECTION    104
#define	OT_PARASCOLLECTION      105
#define	OT_PARASRELECOLLECTION	106
#define	OT_RELEEXCOLLECTION     121
#define OT_CORRREFS_COLLECTION  122
#define	OT_REFWEIGHTCOLLECTION	123

#include "collect.h"
#include "doccol.h"
#include "garutils.h"

class Base;
class DocCollection;

extern bool bClassMerge;

class	RefwWeightCollection : public SortedCollection
{
public:
	RefwWeightCollection () : SortedCollection ( sizeof ( RefwWeight ), REF_PAGE_SIZE ) {}
	RefwWeightCollection ( int pageSize ) : SortedCollection ( sizeof ( RefwWeight ), pageSize ) {}
	RefwWeightCollection ( const RefwWeightCollection& refs) : SortedCollection( refs ) {}

	inline virtual short Tag () const {
		return OT_REFWEIGHTCOLLECTION;
	}

	inline virtual int Compare ( const void * p1, const void * p2 ) const {
		return CompRefwWeight ( (RefwWeight*) p1, (RefwWeight*) p2 );
	}

	virtual int Intersect ( SortedCollection* );
	virtual int Intersect ( SortedCollection& );
	virtual int Minus ( SortedCollection& );

	void Compact () {
		int page;
		for ( ItemCount = 0, page = 0; page < PageCount; page++ )
			ItemCount += Count [page];

		for ( page = 0; page < PageCount - 1; )
			if ( Count [page] < PageSize / 2 )
				if ( Count [page] + Count [page + 1] <= PageSize )
					Collection :: Merge ( page );
				else {
					Collection :: Balance ( page );
					page++;
				}
			else
				page++;

		while (PageCount && !Count [PageCount-1])
			PageCount--;
	}
};

class	RefwReleCollection : public SortedCollection
{
public:
	RefwReleCollection () : SortedCollection ( sizeof ( RefwRele ), REF_PAGE_SIZE ) {}
	RefwReleCollection ( int pageSize ) : SortedCollection ( sizeof ( RefwRele ), pageSize ) {}
	RefwReleCollection ( const RefwReleCollection& refs) : SortedCollection( refs ) {}

	virtual int Intersect ( SortedCollection& );
	int Intersect ( DocCollection* );
	virtual int Minus ( SortedCollection& );

	inline virtual short Tag () const {
		return OT_RELECOLLECTION;
	}

	void Compact () {
		int page;
		for ( ItemCount = 0, page = 0; page < PageCount; page++ )
			ItemCount += Count [page];

		for ( page = 0; page < PageCount - 1; )
			if ( Count [page] < PageSize / 2 )
				if ( Count [page] + Count [page + 1] <= PageSize )
					Collection :: Merge ( page );
				else {
					Collection :: Balance ( page );
					page++;
				}
			else
				page++;

		while (PageCount && !Count [PageCount-1])
			PageCount--;
	}

	inline virtual int Compare ( const void * p1, const void * p2 ) const {
		return CompRele( (RefwRele*) p1, (RefwRele*) p2 );
	}

	virtual long DocCount () const; // returns number for unequal docs Id in refs collection
	virtual int Merge (SortedCollection& col);
};

class	RefwReleSubCollection : public RefwReleCollection
{
public:
	RefwReleSubCollection () : RefwReleCollection() {}
	RefwReleSubCollection ( const RefwReleSubCollection& refs) : RefwReleCollection( refs ) {}

	inline virtual short Tag () const {
		return OT_RELESUBCOLLECTION;
	}
};

class	RefwReleExCollection : public SortedCollection
{
public:
	RefwReleExCollection () : SortedCollection ( sizeof ( RefwReleEx ), 4096 ) {}
	RefwReleExCollection ( const RefwReleExCollection& refs) : SortedCollection( refs ) {}

	inline virtual short Tag () const {
		return OT_RELEEXCOLLECTION;
	}
};

class RefCollection : public SortedCollection
{
public:
	RefCollection ( int pageSize ) : SortedCollection( sizeof( Ref ), pageSize ) {}
	RefCollection () : SortedCollection ( sizeof ( Ref ), REF_PAGE_SIZE ) {}
	RefCollection ( const RefCollection& refs) : SortedCollection ( refs ) {}

	// refactored part
	inline const Ref& get_item (unsigned long index) const {
		return *(Ref *)Collection::get_pointer (index);
	}

	// old ugly part
	inline Ref operator [] ( long index ) const {
		return GetItem ( index );
	}
	Ref GetItem ( long index ) const {
		return * (Ref *)( Collection :: GetItem ( index ) );
	}

	inline int Add ( Ref& r ) {
#ifdef	BLOCKSINHERIT
		if ( r.Sub > 0 )
			if ( r.Sub & INHERITED_BLOCK ) {
			// паразитный бит можно не снимать, поскольку CompRef его игнорирует
				if ( !bClassMerge ) {
					long	aIndex = IndexOf( &r );
					if ( aIndex != -1 ) {
						((Ref*)Collection::GetItem( aIndex ))->Sub |= INHERITED_BLOCK;
						return 1;
					}
				}
			}
			else
			if ( bClassMerge ) {
				long	aIndex = IndexOf( &r );
				if ( aIndex != -1 ) {
					Ref* atIndex = ((Ref*)Collection::GetItem( aIndex ));
					atIndex->Sub &= MINUS_INHERITED_BLOCK;
					return 1;
				}
			}
#endif
		return SortedCollection :: Insert ( &r );
	}

	inline int Del ( Ref& r ) { // add by Max
		return SortedCollection :: Delete ( &r );
	}

	virtual int Intersect ( SortedCollection& );
	int Intersect ( SortedCollection* );
	virtual int Merge ( SortedCollection& );
	virtual int Minus ( SortedCollection& );
	virtual int IsSect ( SortedCollection& );
	int IsSect2 ( RefCollection* );
	int IsSect ( DocCollection& list ); 
	virtual long ReduceRefsBySub ( Base* pbase );  // delete refs to same docs, leave only:
												  // ref with least Para's pos
	inline virtual short Tag () const {
		return OT_REFCOLLECTION;
	}

	inline virtual int Compare ( const void * p1, const void * p2 ) const {
		return m_bCompType == COMP_PLUS ? CompRefsPlus ((Ref*)p1, (Ref*)p2) 
			: ( m_bCompType == COMP_MINUS ? CompRefsMinus( (Ref*)p1, (Ref*)p2 ) 
			: ( m_bCompType == COMP_STRONG ? CompRefsStrong( (Ref*)p1, (Ref*)p2 )
			: CompRefs( (Ref*)p1, (Ref*)p2 ) ) );
	}
	virtual long DocCount () const; // returns number for unequal docs Id in refs collection

	void Compact ();
	void InheritPress();
};

class ParasCollection : public RefCollection
{
public:
	ParasCollection () : RefCollection () {}
	ParasCollection ( int pageSize ) : RefCollection (pageSize) {}

	inline virtual short Tag () const {
		return OT_PARASCOLLECTION;
	}
};

class	ParaswReleCollection : public RefwReleSubCollection
{
public:
	ParaswReleCollection () : RefwReleSubCollection () {}

	inline virtual short Tag () const {
		return OT_PARASRELECOLLECTION;
	}
};

class CorrRefCollection : public SortedCollection {

public:
	CorrRefCollection () : SortedCollection (sizeof (CorrRef), CORRREFS_PAGE_SIZE) {}
	CorrRefCollection (int pageSize) : SortedCollection (sizeof (CorrRef), pageSize) {}
	CorrRefCollection (const CorrRefCollection& corr_refs) : SortedCollection (corr_refs) {}

	const CorrRef& GetItem (long index) const {
		return *reinterpret_cast<const CorrRef*> (Collection::GetItem (index));
	}

	CorrRef& GetItem (long index) {
		return *reinterpret_cast<CorrRef*> (Collection::GetItem (index));
	}

	const CorrRef& operator [] (long index) const {
		return GetItem (index);
	}

	CorrRef& operator [] (long index) {
		return GetItem (index);
	}

	virtual	int	Compare (const void*, const void*) const;
	
	virtual short Tag () const {
		return OT_CORRREFS_COLLECTION;
	}

	int Add (const CorrRef& ref) {
		return SortedCollection::Insert (&ref);
	}

	virtual int Intersect (SortedCollection& collection);
	void Compact ();
	virtual int IsSect (SortedCollection&);   // return 1 if collections has any equal elements, 0 if not, -1 on err
	virtual int	Minus ( SortedCollection&  );

	virtual long DocCount () const;
};

#endif
