/* malloc function */
#include "xalloc.h"
#include "yfuns.h"
_STD_BEGIN

/* xalloc.h internal header - debugging components */

#ifdef DEBUG
int _OK_Cell(_Cell *p)
	{
	ASSERT(SIZE_CELL <= p->_Size);
	return 1;
	}

typedef struct _DB_Altab {
	size_t total_heap;
	size_t total_alloc;
	size_t total_free;
	} _DB_Altab;

_DB_Altab _DB_Altab_object = {0};

void _UPD_Altab(size_t d_heap, size_t d_alloc, size_t d_free)
	{
	_DB_Altab *pd = &_DB_Altab_object;
	pd->total_heap += d_heap;
	pd->total_alloc += d_alloc;
	pd->total_free += d_free;
	}

int _OK_Altab(_Altab *p)
	{
	_DB_Altab *pd = &_DB_Altab_object;
	_Cell *q;
	size_t total_free = 0;
	if (p->_Head == 0)
		return 1;
	for (q = p->_Head; q != 0; q = q->_Next)
		{
		total_free += q->_Size;
		_OK_Cell(q);
		if (q->_Next != 0)
			{
			ASSERT(_PTR_NORM((char *)q + q->_Size) <=
				_PTR_NORM((char *)q->_Next));
			ASSERT(_PTR_NORM(q) < _PTR_NORM(q->_Next));
			}
		}
	ASSERT(pd->total_heap == pd->total_alloc + pd->total_free);
	ASSERT(total_free == pd->total_free);
	return 1;
	}
#endif /* DEBUG */

		/* static data */
_Altab _Aldata = {0};	/* heap initially empty */
size_t _Size_block = {SIZE_BLOCK};	/* preferred _Getmem chunk */

static _Cell **findmem(size_t size)
	{	/* find storage */
	_Cell *q, **qb;

	for (; ; )
		{	/* check freed space first */
		if ((qb = _Aldata._Plast) == 0)
			{	/* take it from the top */
			for (qb = &_Aldata._Head; *qb != 0;
				qb = &(*qb)->_Next)
				if (size <= (*qb)->_Size)
					return (qb);
			}
		else
			{	/* resume where we left off */
			for (; *qb != 0; qb = &(*qb)->_Next)
				if (size <= (*qb)->_Size)
					return (qb);
			q = *_Aldata._Plast;
			for (qb = &_Aldata._Head; *qb != q;
				qb = &(*qb)->_Next)
				if (size <= (*qb)->_Size)
					return (qb);
			}
		 {	/* try to buy more space */
		size_t bs;

		for (bs = _Size_block; ; bs >>= 1)
			{	/* try larger blocks first */
			if (bs < size)
				bs = size;
			if ((q = (_Cell *)_Getmem(bs)) != 0)
				break;
			else if (bs == size)
				return (0);	/* no storage */
			}
		/* got storage: add to heap and retry */
		q->_Size = bs;
		_UPD_Altab(q->_Size, q->_Size, 0); /* heap=alloc+free */
		free((char *)q + CELL_OFF);
		 }
		}
		}

void *(malloc)(size_t size_arg)
	{	/* allocate a data object on the heap */
	_Cell *q, **qb;
	size_t size = (size_arg + (CELL_OFF + M_MASK)) & ~M_MASK;

	_Locksyslock(_LOCK_MALLOC);
	_OK_Altab(&_Aldata);
	if (size <= size_arg)
		{	/* size_arg too large */
		_Unlocksyslock(_LOCK_MALLOC);
		return (0);
		}
	if (size < SIZE_CELL)	/* round up size */
		size = SIZE_CELL;
	if ((qb = findmem(size)) == 0)
		{	/* no memory to be found */
		_Unlocksyslock(_LOCK_MALLOC);
		return (0);
		}
	q = *qb;
	if (q->_Size - SIZE_CELL < size)
		*qb = q->_Next;	/* use entire cell */
	else
		{	/* peel off a residual cell */
		*qb = (_Cell *)((char *)q + size);
		(*qb)->_Next = q->_Next;
		(*qb)->_Size = q->_Size - size;
		q->_Size = size;
		}
	_Aldata._Plast = *qb && (*qb)->_Next ? &(*qb)->_Next : 0;
	_UPD_Altab(0, q->_Size, -q->_Size); /* heap=alloc+free */
	_OK_Altab(&_Aldata);
	_Unlocksyslock(_LOCK_MALLOC);
	return ((char *)q + CELL_OFF);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
