
#ifndef _FStringdefs_h
#define _FStringdefs_h 1

#include "fstring.h"

// equality operator
#ifndef FStringEQ
#define FStringEQ(a, b)  (fscmp((a),(b))==0)
#endif

// less-than-or-equal
#ifndef FStringLE
#define FStringLE(a, b)  (fscmp((a),(b))<=0)
#endif

// comparison : less-than -> < 0; equal -> 0; greater-than -> > 0
#ifndef FStringCMP
#define FStringCMP(a, b) ( fscmp((a),(b)) )
#endif

// hash function
#ifndef FStringHASH
extern unsigned int hashpjw(const char *);
#define FStringHASH(x)  hashpjw(x.chars())
#endif

// initial capacity for structures requiring one

#ifndef DEFAULT_INITIAL_CAPACITY
#define DEFAULT_INITIAL_CAPACITY 100
#endif

// HASHTABLE_TOO_CROWDED(COUNT, SIZE) is true iff a hash table with COUNT
// elements and SIZE slots is too full, and should be resized.
// This is so if available space is less than 1/8.

#ifndef HASHTABLE_TOO_CROWDED
#define HASHTABLE_TOO_CROWDED(COUNT, SIZE) ((unsigned)(SIZE) - (unsigned)((SIZE) >> 3) <= ((unsigned)COUNT))
#endif

#ifndef VHMAPREALSIZE
   #define VHMAPREALSIZE(x) (((x)<<3)/7)
#endif


#endif
