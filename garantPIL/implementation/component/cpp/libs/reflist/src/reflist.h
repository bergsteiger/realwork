/*
 * $Id: reflist.h,v 1.58 2006/08/10 17:23:03 cyberz Exp $
 */
//
// Basic class for working with lists. Supports name caching, sorting
// adding, deleteing, merging & intersection operations
// List is represented via B+ tree
//
// Author: Alex V. Boreskoff
//

#ifndef	__REF_LIST__
#define	__REF_LIST__

#include "store.h"
#include "gardefs.h"
#include "doccol.h"
#include "refcol.h"
#include "base.h"

#include "filters.h"

#define	RL_UNSORTED	1	// sorted by DocId
#define	RL_BYDATE	2	// sorted by date
#define	RL_BYDATE2	3
#define	RL_BYFORCE	4	// sorted by juridical force
#define	RL_BYABC	5	// sorted by alphabet
#define	RL_BYNUMBER	6	// sorted by number
#define	RL_REVERSED	0x100	// sort in decreasing order instaed of increasing

#define	RL_REFS_PER_PAGE	REF_PAGE_SIZE	// same as of RefCollection
#define	OT_REFLIST		102

				// type of reflists (source)
#define	RLT_UNKNOWN	0
#define	RLT_SRCRES	1	// K3 wizard
#define	RLT_MULTIREF	2	// multiref from hypertext
#define	RLT_RESPS	3	// respondents
#define	RLT_CORRS	4	// correspondents
#define	RLT_KEYWORDS	5	// KeyWords wizard
#define	RLT_EXTRACT	6	// ╤яшёюъ т шчтыхўхэш ї

#define	REF_NORMAL	1
#define	REF_WITHCHILDS	2
#define	REF_CHILD	3

#define SIZE_REFLIST_CONTEXT	0x80

struct	DocName
{
	char	Name[ DOC_NAME_SIZE + 100 ];
};

class	RefList;

class	NameCache
{
public:
	RefList * list;
	DocName * Cache;
	int	  CacheSize;			// # of items in cache
	long	  FirstItem;			// index of 1st item in cache

	NameCache ( RefList * l, int size );
	~NameCache ();

	int	IsOk () const
	{
		return Cache != 0;
	}

	void	Reset ()
	{
		FirstItem = 300000l;		// will force complete reload of buffer
	}

	friend class	RefList;

protected:
	DocName * Item      ( long no );
	int	  LoadItem  ( long no, DocName * info );
	int	  LoadItems ( long from, long to );
};

class	RefList : public RefCollection
{
public:
	short	SortedBy;	// sorting method
	Base	*base;		// document base in use
	short	Kind;		// of or RLT_* constansts
	char	*Context;
	short	FullPutGet;
	short	CheckConstriction;

	long	StoredClassesSize;
	char gk_huge*	StoredClasses;

	RefList ( Base *, RefCollection& );
	RefList ( Base *, DocCollection& );
	RefList ( Base *, SortedCollection& );
	RefList ( Base * );
	RefList ();
	RefList ( Base *, long count, Ref * ref, short aDontUseMem = 0 );	// no assumptions on ref array sorting
	~RefList ();

	RefList& operator = ( const RefList& );

	Ref&	operator [] ( long n )
	{
		return * (Ref *)( Collection :: operator [] ( n ) );
	}
	Ref	operator [] ( long n ) const
	{
		return * (Ref *)( Collection :: operator [] ( n ) );
	}

	int	IsOk () const
	{
		return Names == 0 || Names -> IsOk ();
	}

	void	ResetCache()
	{
		if ( Names ) Names -> Reset ();
	}

	DocName * ItemName  ( long no ); 	// return name of item with spec. index
	short	ItemType( long no ) const;
	short	FilteredItemType( long no ) const;


	void	Inherit   ( const RefList& );	// inherit attributes of an existing list
	void	Del       ( long pos );	// delete item at a spec. pos.
	void	DelAll    ();
	int	Merge     ( RefList& );	// merge this list with another one
	int	Intersect ( RefList& );	// intersect this list with another
	int	Minus ( RefList& );
	int	Sort      ( int by );		// sort list by given criteria
						// prepare all for sorting
	int	  SortInit  ( long size, int compBy, int smart );
	void	  SortDone  ();

	int	RemoveAbsentAndNoDocs();
	void	RemoveAbsents( short aDontUseMem = 0 );

	virtual	int	Compare ( const void *, const void * ) const;
	virtual	int	Put ( Store * );
	virtual	int	Get ( Store * );
	virtual	short	Tag () const
	{
		return OT_REFLIST;
	}

	void	ResetFilter();
	void	CalcOffsets();

	long	FilteredItemCount() const;
	long	FilteredDocCount() const;
	long	FilteredItem( long item ) const;

	short	ApplyFilter( Filter *aFilter );
	short	Filtration( SortedCollection* pfilt );

	short	IsItemNonFiltered( long ) const;

#if _MSC_VER <= 800 && _MSC_VER > 0
	inline	void	InitProgress( long nInit, const char *lpszMessage );
	inline	int ReleaseProgress();
	inline	int	IncProgressValue();
	inline	void	SetCursor( int nWait = 1 );

private:
	long	m_nCurPos;
	long	m_nMax;
	short	draw_Pos;
#endif

public:
	void	RemoveNonFiltered( short aRecalculate = 0 );

	short	UndoFilter( short EnableRedo = 1 );
	short	RedoFilter();
	short	CanUndo() { return CurMask != 1; }
	short	CanRedo() { return CurMask != RedoMask; }
	virtual long ReduceRefsBySub ( Base* pbase = 0 ); // parametr base is allways ignored
	void	UndoReduceRefsBySub();

protected:
	void	Sift         ( long l, long r );

private:
	unsigned long	CurMask, RedoMask;
	NameCache	*Names;		// names for stored documents
	Collection	*Offsets;	// аналог FATа для отфильтрованного списка
	Collection	*IsFiltered;	// массив boolов, отфильтрован ли Iый элемент
	short	m_bKill;        // locking flag for multi-threaded Garwin OS

public:
	StrCollection	*FilterNames;
	short		FilterNamesPos;

	void	AddFilterName( const char* );
	char*	GetFilterName();
	void	DeleteFilterName();
};

#endif
