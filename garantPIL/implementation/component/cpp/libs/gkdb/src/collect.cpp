
#include "collect.h"
#include "gardefs.h"

Collection :: Collection ( int itemSize, int pageSize ) {
#ifdef WANT_SMALL_STACK
	Count = new long [MAX_COL_PAGES];
	Pages = new void * [ MAX_COL_PAGES ];
#endif
	ItemSize  = itemSize;
	PageSize  = pageSize;
	ItemCount = 0;
	PageCount = 0;
}

Collection :: Collection ( const Collection& col )
{
#ifdef WANT_SMALL_STACK
	Count = new long [MAX_COL_PAGES];
	Pages = new void * [ MAX_COL_PAGES ];
#endif
	PageCount = 0;
	ItemCount = 0;

	* this = col;
}

void* Collection :: AllocPage () {
	return malloc( PageSize * ItemSize );
}

void	Collection :: FreeAll ()
{
	heap ();
	for ( int i = 0; i < PageCount; i++ )
		free ( Pages [i] );

	heap ();

	PageCount = 0;
	ItemCount = 0;
}

void	Collection :: Move ( Collection& col )
{
	ItemCount	= col.ItemCount;
	PageCount	= col.PageCount;
	PageSize	= col.PageSize;
	col.PageCount = 0;
	col.ItemCount = 0;

	for ( int i = 0; i < PageCount; i++ )
	{
		Pages [i] = col.Pages [i];
		Count [i] = col.Count [i];
	}
}

void	Collection :: Copy (const Collection* col)
{
	FreeAll ();

	ItemSize = col->ItemSize;
	PageSize = col->PageSize;

	for ( int p = 0; p < col->PageCount; p++ )
	{
		Pages [p] = AllocPage ();
		Count [p] = col->Count [p];

		if ( Pages [p] == 0 )
		{
			PageCount = p;
			ItemCount = p * PageSize;
			OkBox ( "Внимание", "Не хватает памяти\nСписок может быть не полным" );
			return;
		}

		memmove ( Pages [p], col->Pages [p], ItemSize * PageSize );
	}

	heap ();
	PageCount = col->PageCount;
	ItemCount = col->ItemCount;
}


Collection& Collection::operator = (const Collection& col) {
	this->Copy (&col);
	return *this;
}

int	Collection :: Add ( const void * item )
{
	if ( PageCount < 1 || Count [PageCount - 1] >= PageSize ) {
		if ( PageCount == MAX_COL_PAGES || ( Pages [PageCount] = AllocPage () ) == 0 )
			return 0;

		Count [PageCount++] = 0;
	}
	void* pOut = Count [PageCount - 1] * ItemSize + (char *) Pages [PageCount - 1];
	if ( ItemSize == 4 )
		*(ACE_INT32*)pOut= *(ACE_INT32*)item;
	else
	if ( ItemSize == 8 )
		*(ACE_UINT64*)pOut= *(ACE_UINT64*)item;
	else
		memmove ( pOut, item, ItemSize );

	Count [PageCount - 1] ++;
	ItemCount ++;

	return 1;
}

void  * Collection :: GetItem ( long index )
{	
	if ( index >= ItemCount )
		index = ItemCount - 1;

	if ( index < 0 )
		index = 0;

	int page;
	for ( page = 0; index >= Count [page]; page++ )
		index -= Count [page];

	return index * ItemSize + (char *) Pages [page];
}

const void  * Collection :: GetItem ( long index ) const
{	
	if ( index >= ItemCount )
		index = ItemCount - 1;

	if ( index < 0 )
		index = 0;

	int page;
	for ( page = 0; index >= Count [page]; page++ )
		index -= Count [page];

	return index * ItemSize + (char *) Pages [page];
}

int	Collection :: atInsert ( long pos, const void * item )
{
	if ( pos >= ItemCount )
		return Add ( item );
	int page;
	for ( page = 0; pos >= Count [page]; page++ )
		pos -= Count [page];

	if ( Count [page] >= PageSize )		// insufficient space
	{
		if ( page + 1 < PageCount )	// try to balance with next
		{
			Balance ( page );	// pos can shift to next page
			if ( pos > Count [page] )
				pos -= Count [page++];
		}

		if ( Count [page] >= PageSize )
		{
			if ( !Split ( page ) )
				return 0;
							// but postion can be in next page
			if ( pos > Count [page] )
				pos -= Count [page++];
		}
	}

	char  * ptr = pos * ItemSize + (char *) Pages [page];	// pointer to inserted position

	memmove ( ptr + ItemSize, ptr,  (Count [page] - (int)pos) * ItemSize );
	if ( ItemSize == 4 )
		*(ACE_INT32*)ptr = *(ACE_INT32*)item;
	else
	if ( ItemSize == 8 )
		*(ACE_UINT64*)ptr = *(ACE_UINT64*)item;
	else
		memmove ( ptr, item, ItemSize );

	Count [page] ++;
	ItemCount ++;


	return 1;
}

void	Collection :: atDelete ( long index )
{
	if ( index < 0 || index >= ItemCount )
		return;

	int page;
	for ( page = 0; index >= Count [page]; page++ )
		index -= Count [page];

	// now remove item from pos. index  from page page

	char  * ptr = index * ItemSize + (char *) Pages [page];

	memmove ( ptr, ptr + ItemSize, ( Count [page] - index - 1 ) * ItemSize );
	Count [page]--;
	ItemCount--;

	if ( Count [page] < 1 && page > 0 )
		Merge ( page - 1 );
}

int	Collection :: Get (DBCore::Store* str) {
	int	sze = str -> Length ();
	int	size = PageSize * ItemSize;

	FreeAll ();
	//return true;

	ItemCount = (long)( (long)(sze) / (long) ItemSize );
	PageCount = (int)(long)(( ItemCount + PageSize - 1 ) / (long)PageSize);

	for ( int i = 0; i < PageCount; i++ )
	{
		if ( ( Pages [i] = AllocPage () ) == 0 )	// insufficient memory
		{
			PageCount = i;ItemCount = PageCount * PageSize;return 0;
		}
		if(size > sze){
			Count [i] = (int) str -> Read ( Pages [i], sze );
			if(Count [i] != sze){
				PageCount = i;ItemCount = size;return 0;
			}
		}else{
			Count [i] = (int) str -> Read ( Pages [i], size );
			if(Count [i] != size){
				PageCount = i;ItemCount = size;return 0;
			}
			sze -= size;
		}
		Count [i] /= ItemSize;
		if ( Count [i] < 1 )
			return 0;
	}

	return 1;
}

int	Collection :: Put ( DBCore::Store * str )
{
	for ( int i = 0; i < PageCount; i++ )
		if ( str -> Write ( Pages [i], Count [i] * ItemSize ) != Count [i] * ItemSize )
			return 0;

	return 1;
}

void	Collection :: Balance ( int page )
{
	int	newSize = ( Count [page] + Count [page+1] ) / 2;  // new Count [page]

	if ( newSize < Count [page] )				  // move extra items to next page
	{
		int	moveItems = Count [page] - newSize;       // # of items to move
		int	moveSize  = moveItems * ItemSize;	  // # of bytes to be moved
								  // shift all items to free space
		memmove ( moveSize+(char *)Pages [page+1], Pages [page+1], Count [page+1]*ItemSize );
		memmove ( Pages [page+1], newSize * ItemSize + (char *) Pages [page], moveSize );
	}
	else
	if ( newSize > Count [page] )				  // move items from next page
	{							  // to current
		int	moveItems = newSize - Count [page];	  // # of items to move
		int	moveSize  = moveItems * ItemSize;	  // # of bytes to be moved

		memmove ( Count [page]*ItemSize + (char *) Pages [page], Pages [page+1], moveSize );
		memmove ( Pages [page+1], moveSize + (char *) Pages [page+1], (Count [page+1]-moveItems)*ItemSize );
	}

	Count [page + 1] = Count [page] + Count [page + 1] - newSize;
	Count [page]     = newSize;
}

int	Collection :: Split ( int page )
{
	int	newSize = Count [page] / 2;
	void  * ptr     = AllocPage ();

	if ( PageCount >= MAX_COL_PAGES || ptr == 0 )
		return 0;

	for ( int i = PageCount; i > page; i-- )
	{
		Count [i] = Count [i-1];
		Pages [i] = Pages [i-1];
	}

	PageCount ++;

	Pages [page + 1] = ptr;
	Count [page + 1] = Count [page] - newSize;
	Count [page]     = newSize;

	memmove ( Pages [page + 1], newSize * ItemSize + (char *) Pages [page],
		  Count [page + 1] * ItemSize );

	return 1;
}

void	Collection :: Merge ( int page )
{
	memmove ( Count [page] * ItemSize + (char *) Pages [page], Pages [page+1],
		  Count [page+1] * ItemSize );

	Count [page] += Count [page+1];

	PageCount--;

	free ( Pages [page+1] );

	for ( register int i = page + 1; i < PageCount; i++ )
	{
		Pages [i] = Pages [i+1];
		Count [i] = Count [i+1];
	}
}


void Collection::fromDelete (long index) {
	this->Cut (index);

	// TODO: єфрышЄ№!
	/*
	if ( index < 0 || index >= ItemCount )
		return;

	long count_to_delete = ItemCount - index;

	int page = PageCount - 1;

	while (Count [page] <= count_to_delete) {
		ItemCount -= Count [page];
		count_to_delete -= Count [page];
		Count [page] = 0;
		if (page) {
			this->Merge (page - 1);
			--page;
		} else {
			break;
		}
	}
	for (; count_to_delete; --count_to_delete) {
		this->atDelete (ItemCount - 1);
	}
	*/
}

bool Collection::Inflated () {
	if (PageCount > 0) {
		for (int i = 0; i < PageCount - 1; ++i) {
			if (PageSize != Count [i]) {
				return true;
			}
		}
	}
	return false;
}

void Collection::Deflate () {
	if (0 == ItemCount)
		return ;

	size_t pos = 0;

	const size_t buf_size = PageSize * ItemSize;

	char* buffer = new char [buf_size];
	char* ptr = buffer;

	int i, p = 0;

	for (i = 0; i < PageCount;) {
		size_t page_size = Count [i] * ItemSize;
		size_t sz = std::min <size_t> (buf_size - (ptr - buffer), page_size - pos);

		const char* page_buf = (char*) Pages [i];

		memmove (ptr, page_buf + pos, sz);

		ptr += sz;
		pos += sz;

		if (pos >= page_size) {
			++i;
			pos = 0;
		}

		if (ptr - buffer == buf_size) {
			GDS_ASSERT (p < i);

			memmove (Pages [p], buffer, buf_size);
			Count [p] = PageSize;
			ptr = buffer;
			++p;
		}
	}

	if (ptr - buffer != buf_size) {
		GDS_ASSERT (p < i);

		memmove (Pages [p], buffer, ptr - buffer);
		Count [p] = (ptr - buffer) / ItemSize;
		++p;
	}

	delete [] buffer;

	for (i = p; i < PageCount; ++i) {
		free (Pages [i]);
		Pages [i] = 0;
		Count [i] = 0;
	}

	GDS_ASSERT ((p - 1) * PageSize + Count [p - 1] == ItemCount);

	PageCount = p;
}

void Collection::Cut (long size) {
	if (size >= 0 && size < ItemCount) {
		long count = 0;
		int i = 0;

		for (i = 0; i < PageCount; ++i) {
			count += Count [i];

			if (count >= size) {
				break;
			}
		}

		GDS_ASSERT (i < PageCount);

		Count [i] = size - (count - Count [i]);
		ItemCount = size;

		int page_count = i + 1;

		for (i = page_count; i < PageCount; ++i) {
			free (Pages [i]);
			Pages [i] = 0;
			Count [i] = 0;
		}

		PageCount = page_count;
	}
}

int	SortedCollection :: Search ( const void * key, long& index )
{
	index = 0;

	if ( ItemCount < 1 )
		return 0;

	int	res = Compare ( key, Pages [0] );

	if ( res == 0 )
		return 1;
	else
	if ( res < 0 )
		return 0;

	// now key > Page [0][0]
	// locate page containing key
	int page;
	for ( page = 1; page < PageCount; page++ )
	{
		if ( ( res = Compare ( key, Pages [page] ) ) <= 0 )
			break;

		index += Count [page - 1];	// since key cannot be in Page [page-1]
	}

	// now can be 2 possibilities :
	//  1. key > Page [PageCount-1][0], so it belongs to Page [PageCount-1], or
	//  2. Page [page-1][0] < key <= Page [page][0], so key belongs to Page [page-1], if not ==

	if ( res == 0 )		// item found, it is Page [page][0]
	{
		index += Count [page - 1];

		return 1;
	}

	// item has not been found, but belongs to page page-1
	// so use binary search to locate it

	char  * ptr = (char *) Pages [--page];
	int l, h;
	for ( l = 0, h = Count [page] - 1; l <= h; ) {
		int	m = ( l + h ) >> 1;

		if ( ( res = Compare ( key, m * ItemSize + ptr ) ) == 0 )
		{
			index += m;	// key == Page [page][m]

			return 1;
		}
		else
		if ( res < 0 )		// key < Page [page][m]
			h = m - 1;
		else                    // key > Page [page][m]
			l = m + 1;
	}
					// if key > all items on a page
	if ( l >= Count [page] )	// then it should really be
	{				// inserted at the start of next page
		index += Count [page++];
		l      = 0;
	}

	index += l;

	return 0;
}

int	SortedCollection :: Insert ( const void * item )
{
	long	index;

	if ( !Search ( item, index ) )
		return atInsert ( index, item );

	return 1;			// item already present
}

int	SortedCollection :: Delete ( const void * item )
{
	long	index;

	if ( Search ( item, index ) )
	{
		atDelete ( index );

		return 1;
	}

	return 0;
}

long	SortedCollection :: IndexOf ( const void * key )
{
	long	index;

	if ( Search ( key, index ) )
		return index;
	else
		return -1l;
}

short SortedCollection :: Filtration ( SortedCollection* pfilt )
{
	if ( !pfilt ) return AFRES_EMPTYFILTER;

	colcomp_t save = m_bCompType;
	m_bCompType = COMP_PLUS;

	if ( !IsSect ( *pfilt ) )
	{
		m_bCompType = save;
		return AFRES_EMPTYRESULT;
	}

	Intersect ( *pfilt );
	m_bCompType = save;
	return AFRES_OK;
}

int SortedCollection :: IsSect ( SortedCollection& list )
{
	if ( list.ItemCount < 1 || ItemCount < 1 ) return 0;

	int	page2 = 0;		// processed page in 'list'
	char   * ptr2  = (char*) list.Pages [page2];

	int	k     = 0;		// index in list's page
	int page;

	for ( page = 0; page < PageCount; page++ )	// check every page
	{
		char  * ptr = (char*) Pages [page];	// pointer to current page
		int i, j;
		for ( i = 0, j = 0; i < Count [page]; i++ )
		{
			int iRes;
			while ( (iRes = Compare( ptr2 + list.ItemSize * k, ptr + ItemSize * i )) < 0 )
				if ( ++ k >= list.Count [page2] )
				{
					if ( ++ page2 >= list.PageCount )
					{
						return 0;
						//Count [page] = j;
						//goto Compact;
					}
					ptr2 = (char*) list.Pages [page2];
					k    = 0;
				}

			if ( !iRes )
				return 1;
		}

		//Count [page] = j;
	}

	return 0;
}

long SortedCollection::DocCount() const
{
	return ItemCount;
}
