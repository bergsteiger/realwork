// This may look like C code, but it is really -*- C++ -*-
/* 
Copyright (C) 1988 Free Software Foundation
    written by Doug Lea (dl@rocky.oswego.edu)

This file is part of the GNU C++ Library.  This library is free
software; you can redistribute it and/or modify it under the terms of
the GNU Library General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your
option) any later version.  This library is distributed in the hope
that it will be useful, but WITHOUT ANY WARRANTY; without even the
implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.  See the GNU Library General Public License for more details.
You should have received a copy of the GNU Library General Public
License along with this library; if not, write to the Free Software
Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/


#ifndef _u_int64_tdefs_h
#define _u_int64_tdefs_h 1

#include <sys/types.h>
//#include "stdintdefs.h"
#include "osdep.h"

// equality operator
#ifndef u_int64_tEQ
#define u_int64_tEQ(a, b)  ((a) == (b))
#endif

// less-than-or-equal
#ifndef u_int64_tLE
#define u_int64_tLE(a, b)  ((a) <= (b))
#endif

// comparison : less-than -> < 0; equal -> 0; greater-than -> > 0
#ifndef u_int64_tCMP
#define u_int64_tCMP(a, b) ( ((a) <= (b))? (((a) == (b))? 0 : -1) : 1 )
#endif

// hash function
#ifndef u_int64_tHASH
#define u_int64_tHASH(x)  ((*(u_int32_t *)&(x))*(*(((u_int32_t *)&(x))+1)))
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
