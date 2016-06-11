/* rand function */
#include <stdlib.h>
#include "xtls.h"
_STD_BEGIN

#define TSIZ	32	/* must be power of two */
#define TMSK	(TSIZ - 1)
#define XRND(x)	(x) * 1664525L + 1013904223L

_TLS_DATA_DEF(_IMPLICIT_EXTERN, char, _Randinit, 0);
_TLS_DATA_DEF(_IMPLICIT_EXTERN, unsigned long, _Randseed, 1);
_TLS_DATA_DEF(static, unsigned long, idx, 0);
_TLS_ARR_DEF(static, unsigned long, rv, TSIZ);

int (rand)(void)
	{	/* compute pseudo-random value */
	char *pinit = _TLS_DATA_PTR(_Randinit);
	unsigned long *pseed = _TLS_DATA_PTR(_Randseed);
	unsigned long *pidx = _TLS_DATA_PTR(idx);
	unsigned long *prv = _TLS_ARR(rv);
	int j;

	if (*pinit == 0)
		{	/* warm up, then initialize shuffle table */
		for (j = 0; j < 8; ++j)
			*pseed = XRND(*pseed);
		for (j = 0; j < TSIZ; ++j)
			prv[j] = (*pseed = XRND(*pseed));
		*pidx = prv[TSIZ - 1];
		*pinit = 1;
		}
	*pseed = XRND(*pseed);
	j = *pidx & TMSK;
	*pidx = prv[j];
	prv[j] = *pseed;

 #if _ILONG
	return (*pidx & RAND_MAX);

 #else /* _ILONG */
	return ((*pidx >> 16) & RAND_MAX);
 #endif /* _ILONG */

	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
