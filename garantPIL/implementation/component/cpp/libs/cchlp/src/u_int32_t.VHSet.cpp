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

#ifdef __GNUG__
#pragma implementation
#endif
#include "u_int32_t.VHSet.h"

/* codes for status fields */

#define EMPTYCELL   0
#define VALIDCELL   1
#define DELETEDCELL 2


u_int32_tVHSet::u_int32_tVHSet(unsigned int sz)
{
  tab = new u_int32_t[size = sz];
  status = new char[size];
  for (unsigned int i = 0; i < size; ++i) status[i] = EMPTYCELL;
  count = 0;
}

u_int32_tVHSet::u_int32_tVHSet(u_int32_tVHSet& a)
{
  tab = new u_int32_t[size = a.size];
  status = new char[size];
  for (unsigned int i = 0; i < size; ++i) status[i] = EMPTYCELL;
  count = 0;
  for (Pix p = a.first(); p; a.next(p)) add(a(p));
}


/* 
 * hashing method: double hash based on high bits of hash fct,
 * followed by linear probe. Can't do too much better if table
 * sizes not constrained to be prime.
*/


static inline unsigned int doublehashinc(unsigned int h, unsigned int s)
{
  unsigned int dh =  ((h / s) % s);
  return (dh > 1)? dh : 1;
}

Pix u_int32_tVHSet::seek(u_int32_t  key)
{
  unsigned int hashval = u_int32_tHASH(key);
  unsigned int h = hashval % size;
  for (unsigned int i = 0; i <= size; ++i)
  {
    if (status[h] == EMPTYCELL)
      return 0;
    else if (status[h] == VALIDCELL && u_int32_tEQ(key, tab[h]))
      return Pix(&tab[h]);
    if (i == 0)
      h = (h + doublehashinc(hashval, size)) % size;
    else if (++h >= size)
      h -= size;
  }
  return 0;
}


Pix u_int32_tVHSet::add(u_int32_t  item)
{
  if (HASHTABLE_TOO_CROWDED(count, size))
    resize();

  unsigned int bestspot = size;
  unsigned int hashval = u_int32_tHASH(item);
  unsigned int h = hashval % size;
  for (unsigned int i = 0; i <= size; ++i)
  {
    if (status[h] == EMPTYCELL)
    {
      if (bestspot >= size) bestspot = h;
      tab[bestspot] = item;
      status[bestspot] = VALIDCELL;
      ++count;
      return Pix(&tab[bestspot]);
    }
    else if (status[h] == DELETEDCELL)
    {
      if (bestspot >= size) bestspot = h;
    }
    else if (u_int32_tEQ(tab[h],item))
      return Pix(&tab[h]);

    if (i == 0)
      h = (h + doublehashinc(hashval, size)) % size;
    else if (++h >= size)
      h -= size;
  }
  tab[bestspot] = item;
  status[bestspot] = VALIDCELL;
  ++count;
  return Pix(&tab[bestspot]);

}


void u_int32_tVHSet::del(u_int32_t  key)
{
  unsigned int hashval = u_int32_tHASH(key);
  unsigned int h = hashval % size;
  for (unsigned int i = 0; i <= size; ++i)
  {
    if (status[h] == EMPTYCELL)
      return;
    else if (status[h] == VALIDCELL && u_int32_tEQ(key, tab[h]))
    {
      status[h] = DELETEDCELL;
      --count;
      return;
    }
    if (i == 0)
      h = (h + doublehashinc(hashval, size)) % size;
    else if (++h >= size)
      h -= size;
  }
}


void u_int32_tVHSet::clear()
{
  for (unsigned int i = 0; i < size; ++i) status[i] = EMPTYCELL;
  count = 0;
}

void u_int32_tVHSet::resize(unsigned int newsize)
{
  if (newsize <= count)
  {
    newsize = DEFAULT_INITIAL_CAPACITY;
    while (HASHTABLE_TOO_CROWDED(count, newsize))  newsize <<= 1;
  }
  u_int32_t* oldtab = tab;
  char* oldstatus = status;
  unsigned int oldsize = size;
  tab = new u_int32_t[size = newsize];
  status = new char[size];
  unsigned int i;
  for (i = 0; i < size; ++i) status[i] = EMPTYCELL;
  count = 0;
  for (i = 0; i < oldsize; ++i) if (oldstatus[i] == VALIDCELL) add(oldtab[i]);
  delete [] oldtab;
  delete oldstatus;
}

Pix u_int32_tVHSet::first()
{
  for (unsigned int pos = 0; pos < size; ++pos)
    if (status[pos] == VALIDCELL) return Pix(&tab[pos]);
  return 0;
}

void u_int32_tVHSet::next(Pix& i)
{
  if (i == 0) return;
  unsigned long pos = ((unsigned long)i - (unsigned long)tab) / sizeof(u_int32_t) + 1;
  for (; pos < size; ++pos)
    if (status[pos] == VALIDCELL)
    {
      i = Pix(&tab[pos]);
      return;
    }
  i = 0;
}
  
int u_int32_tVHSet:: operator == (u_int32_tVHSet& b)
{
  if (count != b.count)
    return 0;
  else
  {
	unsigned int i;
    for (i = 0; i < size; ++i)
      if (status[i] == VALIDCELL && b.seek(tab[i]) == 0)
          return 0;
    for (i = 0; i < b.size; ++i)
      if (b.status[i] == VALIDCELL && seek(b.tab[i]) == 0)
          return 0;
    return 1;
  }
}

int u_int32_tVHSet::operator <= (u_int32_tVHSet& b)
{
  if (count > b.count)
    return 0;
  else
  {
    for (unsigned int i = 0; i < size; ++i)
      if (status[i] == VALIDCELL && b.seek(tab[i]) == 0)
          return 0;
    return 1;
  }
}

void u_int32_tVHSet::operator |= (u_int32_tVHSet& b)
{
  if (&b == this || b.count == 0)
    return;
  for (unsigned int i = 0; i < b.size; ++i)
    if (b.status[i] == VALIDCELL) add(b.tab[i]);
}

void u_int32_tVHSet::operator &= (u_int32_tVHSet& b)
{
  if (&b == this || count == 0)
    return;
  for (unsigned int i = 0; i < size; ++i)
  {
    if (status[i] == VALIDCELL && b.seek(tab[i]) == 0)
    {
      status[i] = DELETEDCELL;
      --count;
    }
  }
}

void u_int32_tVHSet::operator -= (u_int32_tVHSet& b)
{
  for (unsigned int i = 0; i < size; ++i)
  {
    if (status[i] == VALIDCELL && b.seek(tab[i]) != 0)
    {
      status[i] = DELETEDCELL;
      --count;
    }
  }
}

int u_int32_tVHSet::OK()
{
  int v = tab != 0;
  v &= status != 0;
  unsigned int n = 0;
  for (unsigned int i = 0; i < size; ++i) 
  {
    if (status[i] == VALIDCELL) ++n;
    else if (status[i] != DELETEDCELL && status[i] != EMPTYCELL)
      v = 0;
  }
  v &= n == count;
  if (!v) error("invariant failure");
  return v;
}
