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


#ifndef _clTreeNodedefs_h
#define _clTreeNodedefs_h 1

#include "clTreeNode.h"

// equality operator
#ifndef clTreeNodeEQ
#define clTreeNodeEQ(a, b)  ((a.name) == (b.name))
#endif

// less-than-or-equal
#ifndef clTreeNodeLE
#define clTreeNodeLE(a, b)  ((a.name) <= (b.name))
#endif

static int clTreeNodeComp(clTreeNode &a, clTreeNode& b)
{
	if ((a.name) < (b.name)) return -1;
	if ((a.name) > (b.name)) return 1;
	if ((a.children) < (b.children)) return -1;
	if ((a.children) > (b.children)) return 1;
	if ((a.dchildren) < (b.dchildren)) return -1;
	if ((a.dchildren) > (b.dchildren)) return 1;
	return 0;
}


// comparison : less-than -> < 0; equal -> 0; greater-than -> > 0
#ifndef clTreeNodeCMP
#define clTreeNodeCMP(a, b) (clTreeNodeComp((a), (b)))
#endif

// hash function
#ifndef clTreeNodeHASH
extern unsigned int hash(clTreeNode&);
#define clTreeNodeHASH(x)  hash(x)
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
