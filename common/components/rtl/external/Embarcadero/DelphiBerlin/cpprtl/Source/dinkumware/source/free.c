/* free function */
#include "xalloc.h"
_STD_BEGIN

void (free)(void *ptr)
	{	/* free an allocated data object */
	_Cell *q;

#ifdef DEBUG
	size_t size;
#endif /*DEBUG*/

	_OK_Altab(&_Aldata);
	if (ptr == 0)
		return;
	q = (_Cell *)((char *)ptr - CELL_OFF);
	if (q->_Size < SIZE_CELL || (q->_Size & M_MASK) != 0)
		return;	/* erroneous call, bad count */

#ifdef DEBUG
	size = q->_Size;
#endif /*DEBUG*/

	_Locksyslock(_LOCK_MALLOC);
	if (_Aldata._Head == 0
		|| _PTR_NORM(q) < _PTR_NORM(_Aldata._Head))
		{	/* insert at head of list */
		q->_Next = _Aldata._Head;
		_Aldata._Head = q;
		}
	else
		{	/* scan for insertion point */
		_Cell *qp = _Aldata._Head;
		char *qpp;

		while (qp->_Next != 0
			&& _PTR_NORM(qp->_Next) < _PTR_NORM(q))
			qp = qp->_Next;
		qpp = (char *)qp + qp->_Size;
		if (_PTR_NORM((char *)q) < _PTR_NORM(qpp))
			{	/* erroneous call, overlaps qp */
			_Unlocksyslock(_LOCK_MALLOC);
			return;
			}
		else if (_PTR_NORM(qpp) == _PTR_NORM((char *)q))
			{	/* merge qp and q */
			qp->_Size += q->_Size;
			q = qp;
			}
		else if (qp->_Next != 0 && _PTR_NORM((char *)qp->_Next)
			< _PTR_NORM((char *)q + q->_Size))
			{	/* erroneous call, overlaps qp->_Next */
			_Unlocksyslock(_LOCK_MALLOC);
			return;
			}
		else
			{	/* splice q after qp */
			q->_Next = qp->_Next;
			qp->_Next = q;
			}
		}
	if (q->_Next != 0 && _PTR_NORM((char *)q + q->_Size)
		== _PTR_NORM((char *)q->_Next))
		{	/* merge q and q->_Next */
		_Aldata._Plast = 0;	/* deoptimize for safety */
		q->_Size += q->_Next->_Size;
		q->_Next = q->_Next->_Next;
		}
	_UPD_Altab(0, -size, size); /* heap=alloc+free */
	_OK_Altab(&_Aldata);
	_Unlocksyslock(_LOCK_MALLOC);
	/* every successful free "falls off" here */
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
