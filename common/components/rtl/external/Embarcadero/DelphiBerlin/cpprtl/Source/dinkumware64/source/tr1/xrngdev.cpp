// xrngdev: random device for TR1 random number generators
#include <stdexcept>	// for out_of_range

 #if _HAS_TR1
//  #include <random>
_STD_BEGIN
_CRTIMP2P unsigned int _PCDECL _Random_device();

_CRTIMP2P double _PCDECL _Random_device_entropy()
	{	// get entropy
	return (0.0);
	}

unsigned int _PCDECL _Random_device()
	{	// return a random value
	return (_CSTD rand());	// good if Dinkum C, otherwise better than nothing
	}
_STD_END
 #endif /* _HAS_TR1 */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
