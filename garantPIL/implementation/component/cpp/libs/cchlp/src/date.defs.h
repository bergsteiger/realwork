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


#ifndef _datedefs_h
#define _datedefs_h 1

// #include "gardefs.h"
#include "osdep.h"

// comparison : less-than -> < 0; equal -> 0; greater-than -> > 0
#ifndef dateCMP
#define dateCMP(a, b) (((a).da_year>(b).da_year)?1:\
						((a).da_year<(b).da_year)?-1:\
						((a).da_mon>(b).da_mon)?1:\
						((a).da_mon<(b).da_mon)?-1:\
						((a).da_day>(b).da_day)?1:\
						((a).da_day<(b).da_day)?-1:0)

#endif

// equality operator
#ifndef dateEQ
#define dateEQ(a, b)  ( dateCMP(a, b) == 0 )
#endif

// less-than-or-equal
#ifndef dateLE
#define dateLE(a, b)  ((a) <= (b))
#endif


// hash function
#ifndef dateHASH
extern unsigned int hash(date&);
#define dateHASH(x)  hash(x)
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

#endif
