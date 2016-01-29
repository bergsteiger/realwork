//
// Collection of doc Id's ( long )
// Supports adding, deleting items,
// merging & intersection of collections
//
// Author : Alex V. Boreskoff
//
// Last modification 5/10/96
//
#ifndef	__DOC_COLLECTION__
#define	__DOC_COLLECTION__

#define DOC_PAGE_SIZE 16384

#define	OT_DOCCOLLECTION	103

#include "refcol.h"

class	RefCollection;
class	DocCollection : public SortedCollection
{
public:
	DocCollection () : SortedCollection ( 4, DOC_PAGE_SIZE ) {}
	DocCollection (int defPageSize) : SortedCollection ( 4, defPageSize ) {}
	DocCollection ( const DocCollection& docs) : SortedCollection ( docs ) {}

	inline long GetItem ( long index ) const {
		return * (long *)( Collection :: GetItem ( index ) );
	}
	inline long	operator [] ( long index ) const {
		return GetItem ( index );
	}

	virtual	int	Compare ( const void *, const void * ) const;
	inline virtual	short	Tag () const
	{
		return OT_DOCCOLLECTION;
	}
	inline int	Add       ( long ref )	// return true on success
	{
	       return SortedCollection :: Insert ( &ref );
	}
	inline int	Del       ( long item )        // return true on success
	{
		return SortedCollection :: Delete ( &item );
	}
    virtual int Intersect ( SortedCollection& );   // return true on success
    bool IsSect (DocCollection*);

    virtual int Merge     ( SortedCollection& );   // return true on success, false on errors
	virtual int	Minus     ( SortedCollection& );	// return true on success
	int     LoadRefs  ( DBCore::Store * );		// load streamed refs into DocCollection
						// on errors return false, otherwise true
	int     FastLoadRefs  ( DBCore::Store * );		// load streamed refs into DocCollection
						// on errors return false, otherwise true

	int     FastLoadRefWeights  ( DBCore::Store * );		// load streamed refs into DocCollection

	void	Compact ();

protected:
	int	Sect    ( SortedCollection&, int );
};

#endif
