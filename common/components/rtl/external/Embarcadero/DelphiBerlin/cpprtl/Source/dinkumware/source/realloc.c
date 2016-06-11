/* realloc function */
#include <string.h>
#include "xalloc.h"
_STD_BEGIN

static void *(myrealloc)(void *ptr, size_t size_arg,
	_Cell *q, size_t size)
	{	/* try to buy a larger cell */
	if (_Aldata._Head != 0)
		{	/* look for adjacent free space */
		_Cell **qb = &_Aldata._Head;
		char *const qn = (char *)q + q->_Size;

		while ((*qb)->_Next != 0
			&& _PTR_NORM((*qb)->_Next) < _PTR_NORM(q))
			qb = &(*qb)->_Next;
		if (_PTR_NORM(qn) == _PTR_NORM((char *)*qb))
			{	/* merge q and *qb */
			_Aldata._Plast = 0;	/* deoptimize for safety */
			_UPD_Altab(/*heap*/ 0,
				/*alloc*/ (*qb)->_Size,
				/*free*/ -(*qb)->_Size);
			q->_Size += (*qb)->_Size;
			*qb = (*qb)->_Next;
			if (size <= q->_Size)
				return (realloc(ptr, size_arg));	/* trim */
			}
		else if (_PTR_NORM(qn)
			== _PTR_NORM((char *)(*qb)->_Next))
			{	/* merge q and (*qb)->_Next */
			_Aldata._Plast = 0;	/* deoptimize for safety */
			_UPD_Altab(/*heap*/ 0,
				/*alloc*/ (*qb)->_Next->_Size,
				/*free*/ -(*qb)->_Next->_Size);
			q->_Size += (*qb)->_Next->_Size;
			(*qb)->_Next = (*qb)->_Next->_Next;
			if (size <= q->_Size)
				return (realloc(ptr, size_arg));	/* trim */
			}
		if (*qb != 0 && _PTR_NORM((char *)*qb + (*qb)->_Size)
			== _PTR_NORM((char *)q)
			&& size <= (*qb)->_Size + q->_Size)
			{	/* merge *qb and q, then copy down */
			_Cell *const next_q = (*qb)->_Next;
				_Aldata._Plast = 0;	/* deoptimize for safety */
			_UPD_Altab(/*heap*/ 0, /*alloc*/ q->_Size,
				/*free*/ -q->_Size);
			(*qb)->_Size += q->_Size;
			ptr = memmove((char *)*qb + CELL_OFF, ptr,
				q->_Size - CELL_OFF);
			*qb = next_q;
			return (realloc(ptr, size_arg));	/* trim */
			}
		}
	return (0);
	}

void *(realloc)(void *ptr, size_t size_arg)
	{	/* reallocate a data object on the heap */
	_Cell *q;
	size_t size;

	_OK_Altab(&_Aldata); /* too many returns to check at return */
	if (ptr == 0)
		return (malloc(size_arg));
	if (size_arg == 0)
		{	/* free if zero size */
		free(ptr);
		return (0);
		}
	size = (size_arg + (CELL_OFF + M_MASK)) & ~M_MASK;
	if (size <= size_arg)
		return (0);	/* size_arg too large */
	if (size < SIZE_CELL)	/* round up size */
		size = SIZE_CELL;
	q = (_Cell *)((char *)ptr - CELL_OFF);
	if (q->_Size < SIZE_CELL || (q->_Size & M_MASK) != 0)
		return (0);	/* erroneous call, bad count */
	if (size <= q->_Size - SIZE_CELL)
		{	/* free excess space */
		_Cell *const new_q = (_Cell *)((char *)q + size);

		new_q->_Size = q->_Size - size;
		q->_Size = size;
		free((char *)new_q + CELL_OFF);
		return (ptr);
		}
	else if (size <= q->_Size)
		return (ptr);	/* leave cell alone */
	else
		{	/* try to buy larger cell */
		void *new_p;

		_Locksyslock(_LOCK_MALLOC);
		new_p = myrealloc(ptr, size_arg, q, size);
		_Unlocksyslock(_LOCK_MALLOC);
		if (new_p != 0)
			return (new_p);
		else if ((new_p = malloc(size_arg)) == 0)
			return (0);
		else
			{	/* copy to new cell and free old */
			memcpy(new_p, ptr, q->_Size - CELL_OFF);
			free(ptr);
			return (new_p);
			}
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
