/* xxxatan.h -- common _[FL]Atan functionality */
#include "xmath.h"
_C_LIB_DECL

	/* coefficients */

 #if   FBITS <= 28
  #define CPOLY(x)	(c[0] * x + c[1])
  #define SPOLY(x)	(s[0])

_STATIC_CONST FTYPE c[] = {	/* s3/c4, |x| < 2-sqrt(3) (100.0%) */
	FLIT(0.0828021377),
	FLIT(0.8483080898),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT(0.5149751685),
	};

  #define CPOLY2(x)	((c2[0] * x + c2[1]) * x + c2[2])
  #define SPOLY2(x)	((s2[0] * x + s2[1]) * x + s2[2])

_STATIC_CONST FTYPE c2[] = {	/* 0.9 <= |x| <= 1 */
	FLIT(0.2989761005),
	FLIT(0.8971745856),
	FLIT(0.9985051194),
	};
_STATIC_CONST FTYPE s2[] = {
	FLIT(0.8402900806e-2),
	FLIT(0.1989610641),
	FLIT(0.4992525600),
	};

 #elif FBITS <= 59
  #define CPOLY(x)	(((c[0] * x + c[1]) * x + c[2]) * x + c[3])
  #define SPOLY(x)	((s[0] * x + s[1]) * x + s[2])

_STATIC_CONST FTYPE c[] = {	/* s7/c8, |x| < 2-sqrt(3) (100.0%) */
	FLIT(0.00506666138256980774),
	FLIT(0.18786627197308930065),
	FLIT(1.05290797687252613439),
	FLIT(1.84896092990243571481),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT(0.06383198950003615800),
	FLIT(0.63658766690479336192),
	FLIT(1.51562759656910323406),
	};

 #elif FBITS <= 67
  #define CPOLY(x)	(((c[0] * x + c[1]) * x + c[2]) * x + c[3])
  #define SPOLY(x)	(((s[0] * x + s[1]) * x + s[2]) * x + s[3])

_STATIC_CONST FTYPE c[] = {	/* s9/c8, |x| < 2-sqrt(3) (100.0%) */
	FLIT(0.0243304614668045790646931),
	FLIT(0.3656586088272377012513945),
	FLIT(1.4503636021784732014830863),
	FLIT(2.0977409028047682556912090),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT(0.0039508182234785684966481),
	FLIT(0.1588951124718203193457553),
	FLIT(0.9511166345768818834389669),
	FLIT(1.7644075694714349274494922),
	};

 #elif FBITS <= 114
  #define CPOLY(x)	((((((c[0] * x + c[1]) * x + c[2]) * x + c[3]) * x \
		+ c[4]) * x + c[5]) * x + c[6])
  #define SPOLY(x)	((((((s[0] * x + s[1]) * x + s[2]) * x + s[3]) * x \
		+ s[4]) * x + s[5]) * x + s[6])

_STATIC_CONST FTYPE c[] = {	/* s13/c12, |x| < 2-sqrt(3) (100.0%) */
	FLIT(0.0005911838990298410394205183899708203732),
	FLIT(0.0241212247588117062496763313784763708597),
	FLIT(0.2811820143719257289927145903226375437774),
	FLIT(1.4315183225402044337791066350104594027901),
	FLIT(3.7132565768706978802546209429525324879387),
	FLIT(5.1272717262665749143199308954091573117442),
	FLIT(3.5876427442622998952436901644636740342206),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT(0.0000588657554399560046800095049916302629),
	FLIT(0.0067029208852937893628369610349867853141),
	FLIT(0.1219110467749526805328881283577704446863),
	FLIT(0.8178111945769264873964112723430110304103),
	FLIT(2.5788374074438233640538582551768503216181),
	FLIT(4.1313908115124749492387008404455910339193),
	FLIT(3.2543094109289665619103568311304841099209),
	};

 #else /* FBITS */
  #error atan has insufficient precision
 #endif /* FBITS */

_STATIC_CONST FTYPE a[8] = {
	FLIT(0.0),
	FLIT(0.52359877559829887307710723054658382),
	FLIT(1.57079632679489661923132169163975145),
	FLIT(1.04719755119659774615421446109316763),
	FLIT(1.57079632679489661923132169163975145),
	FLIT(2.09439510239319549230842892218633526),
	FLIT(3.14159265358979323846264338327950287),
	FLIT(2.61799387799149436538553615273291908),
	};

_STATIC_CONST FTYPE rt3 = FLIT(1.7320508075688772935274463415058725);
_STATIC_CONST FTYPE fold = FLIT(0.26794919243112270647255365849412763);
_STATIC_CONST FTYPE piby4 = FLIT(0.78539816339744830961566084581987572);

FTYPE _CDECL FNAME(Atan)(FTYPE x, int idx)
	{	/* compute atan(x), 0 <= x <= 1.0 */
	int idx7;

	if (x == FLIT(1.0))
		x = piby4;

 #if defined(SPOLY2)
	else if (FLIT(0.9) <= x)
		{	/* approximate near 1 */
		FTYPE eps = x - FLIT(1.0);

		x = piby4 + FDIV(eps * SPOLY2(eps), CPOLY2(eps));
		}
 #endif /* SPOLY2 */

	else
		{	/* fold as needed to approximate < 0.268 */
		if (fold < x)
			{	/* 2-sqrt(3) < x */
			x = FDIV(rt3 * x - FLIT(1.0), x + rt3);
			idx |= 0x1;
			}
		if (x < -FCONST(Rteps) || FCONST(Rteps) < x)
			{	/* compute rational approximation */
			const FTYPE z = x * x;
				const FTYPE eps = z * CPOLY(z);
				const FTYPE denom = FINVERT(FLIT(1.0) + eps);

				x += x * z * SPOLY(z);
				x -= x * eps * denom;
			}
		}

	if (idx & 0x2)
		FNEGATE(x);
	if ((idx7 = idx & 0x7) != 0)
		{	/* add pi fraction and set inexact */
		x += a[idx7];
		_Feraise(_FE_INEXACT);
		}

	if (idx & 0x8)
		FNEGATE(x);
	return (x);
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
