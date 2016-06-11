/* xxxrint.h -- common _{FL]Rint functionality */
#include <fenv.h>
#include "xmath.h"
_STD_BEGIN

FTYPE FNAME(Rint)(FTYPE xarg)
	{	/* round finite x according to current mode */
	FTYPE x = xarg;	/* deoptimize to avoid code generation bug */

	switch (fegetround())
		{	/* round according to current mode */
	case FE_DOWNWARD:
		if (FNAME(Dint)(&x, 0) != 0 && FISNEG(x))
			x -= FLIT(1.0);				
		break;

	case FE_TONEAREST:
		if (FNAME(Dint)(&x, 1) == 0)
			{	/* xxx.0 or xxx.5, round latter to even */
			if (FNAME(Dint)(&x, 0) == 0
				|| FNAME(Dint)(&x, -1) == 0)
				;
			else if (FISNEG(x))
				x -= FLIT(2.0);	/* round negative to even */
			else
				x += FLIT(2.0);	/* round positive to even */
			}
		else if (FNAME(Dint)(&x, 0) == 0)
			;
		else if (FISNEG(x))
			x -= FLIT(1.0);
		else
			x += FLIT(1.0);
		break;

	case FE_TOWARDZERO:
		FNAME(Dint)(&x, 0);
		break;

	case FE_UPWARD:
		if (FNAME(Dint)(&x, 0) != 0 && !FISNEG(x))
			x += FLIT(1.0);				
		}
	return (x);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
