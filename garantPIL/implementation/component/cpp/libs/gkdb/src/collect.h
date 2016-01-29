//
// Simple collection of fixed-sized items based of list of pages
//
// Author Alex V. Boreskoff
//
// Last modification : 16.06.96
//

#ifndef _collect_h
#define _collect_h

#include "shared/DB/DBCore/DBCore.h"

#define	MAX_COL_PAGES	4096
#define	OT_COLLECTION	100

/*#if defined (_WINDOWS) || defined (WIN32)
	#define WANT_SMALL_STACK
#endif*/

enum colcomp_t {
	COMP_STD,
	COMP_PLUS,
	COMP_MINUS,
	COMP_STRONG
};

//////////////////////////////////////////////////////////////////////////////////////////////////
// romank: итератор для обхода коллекции произвольного типа (альтернатива тормозному GetItem)

template <typename DataType, typename ItemType>
class CollectionIterator {
public:
	CollectionIterator (const DataType& data) 
		: m_data (data)
		, m_page (0)
		, m_delta (0)
		, m_pos (0)
		, m_total (m_data.Count [0]) {
	}

	ItemType& operator * () {
		return *(this->ptr ());
	}

	// для работы с нетипизированной коллекцией, когда во время
	// создания итератора мы не знаем тип элемента
	void* get_raw_data () {
		return this->raw_ptr ();
	}

	bool end () const {
		return m_pos >= m_data.ItemCount;
	}

	void operator ++ () { 
		++m_pos; 
	}

	long get_position () const {
		return m_pos;
	}

protected:
	ItemType* ptr () { 
		return reinterpret_cast <ItemType*> (this->raw_ptr ());
	}

	void* raw_ptr () { 
		if (m_pos >= m_total) {
			++m_page;
			m_delta = m_total;
			m_total += m_data.Count [m_page];
		}

		return (m_pos - m_delta) * m_data.ItemSize + (char*) m_data.Pages [m_page];
	}

private:
	const DataType& m_data;

	size_t m_page;

	long m_pos;
	long m_total;
	long m_delta;
};

//////////////////////////////////////////////////////////////////////////////////////////////////

class	Collection : public DBCore::Storable {
protected:
	inline void* get_pointer (unsigned long index) const {	
		assert (index < static_cast<const unsigned long>(ItemCount));
		
		unsigned long page = 0;
		for (; index >= static_cast<const unsigned long>(Count[page]); page++) {
			index -= static_cast<const unsigned long>(Count[page]);
		}

		return index * ItemSize + (char *)Pages[page];
	}

public:
	int	PageCount;
	int	PageSize;			// page size in items
#ifndef WANT_SMALL_STACK
	long Count [MAX_COL_PAGES];		// # of items for each page
	void* Pages [MAX_COL_PAGES];		// pointers to data pages
#else
	long *Count;
	void **Pages;
#endif

public:
	int	ItemSize;	// item size in bytes
	long ItemCount;	// total # of items in collection

	Collection (int itemSize, int pageSize);
	Collection (const Collection&);

	virtual ~Collection () {
		FreeAll ();
		#ifdef WANT_SMALL_STACK
			if (Count) delete Count;
			if (Pages) delete Pages;
		#endif
	}

	void FreeAll ();			// remove all elements
	int	Add (const void*);		// insert as last item,
								// on failure returns false
	int	atInsert (long, const void*);	// insert item at a given position
										// on failure returns false
	void atDelete (long);			// delete item at a given position

	const void* GetItem (long index) const;	// get element with given index	
	void* GetItem (long index);				// get element with given index	

	const void* operator [] (long index) const {
		return GetItem (index);
	}	

	void* operator [] (long index) {
		return GetItem (index);
	}	

	void Move (Collection& col);	// move items from col to this
	Collection& operator = (const Collection&);
	void Copy (const Collection* col);

	bool Inflated ();
	void Deflate ();
	void Cut (long size);

	virtual	int	Put (DBCore::Store*);	// load collection from store
	virtual	int	Get (DBCore::Store*);	// save to store
	virtual	short Tag () const
	{
		return OT_COLLECTION;
	}

	inline virtual int	Insert (const void* item)	// if no order known add as last
	{
		return Add (item);
	}
	virtual void fromDelete (long index);   // remove all elements from the index to the end

protected:
	void Balance (int);	// balance given page with next
	int Split (int);	// split given page in two allocating new page
	void Merge (int);	// merge given page with next page
	void* AllocPage ();	// allocate & zero new page
};

#define AFRES_OK          0
#define AFRES_EMPTYFILTER 1
#define AFRES_EMPTYRESULT 2

class Base;

class SortedCollection : public Collection {
public:
	colcomp_t m_bCompType;
	int insertBalance;
public:
	SortedCollection (int itemSize, int pageSize, int InsertBalance)
		: Collection (itemSize, pageSize), m_bCompType (COMP_STD), insertBalance(InsertBalance) {}
	SortedCollection (int itemSize, int pageSize)
		: Collection (itemSize, pageSize), m_bCompType (COMP_STD), insertBalance(50) {}
	SortedCollection (const SortedCollection& col)
		: Collection (col), m_bCompType (COMP_STD), insertBalance(50) {}

	long IndexOf (const void*);
	virtual	int	Search (const void*, long&);
	virtual	int	Insert (const void*);
	virtual	int	Delete (const void*);
	inline virtual int Compare (const void* p1, const void* p2) const {
		return strcmp ((char*) p1, (char*) p2);
	}
	virtual int Intersect (SortedCollection&) { return 0; };   // return 1 on success
	virtual int Merge     (SortedCollection&) { return 0; };   // return 1 on success, 0 on errors
	virtual int Minus     (SortedCollection&) { return 0; }; 	// return 1 on success
	virtual int IsSect    (SortedCollection&);  // return 1 if collections has any equal elements, 0 if not, -1 on err
	virtual short Filtration (SortedCollection* aFilter);
	virtual long ReduceRefsBySub (Base* pbase) { return 0; };
	virtual long DocCount () const;
};

#endif
