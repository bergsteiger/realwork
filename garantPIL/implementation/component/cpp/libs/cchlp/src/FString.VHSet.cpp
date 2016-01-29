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
#include "FString.VHSet.h"

/* codes for status fields */

#define EMPTYCELL   0
#define VALIDCELL   1
#define DELETEDCELL 2


FStringVHSet::FStringVHSet(unsigned int sz)
{
  tab = new FString[size = sz];
  status = new char[size];
  for (unsigned int i = 0; i < size; ++i) status[i] = EMPTYCELL;
  count = 0;
}

FStringVHSet::FStringVHSet(FStringVHSet& a)
{
  tab = new FString[size = a.size];
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

Pix FStringVHSet::seek(FString& key)
{
  unsigned int hashval = FStringHASH(key);
  unsigned int h = hashval % size;
  for (unsigned int i = 0; i <= size; ++i)
  {
    if (status[h] == EMPTYCELL)
      return 0;
    else if (status[h] == VALIDCELL && KeyCompare(key, tab[h])==0)
      return Pix(&tab[h]);
    if (i == 0)
      h = (h + doublehashinc(hashval, size)) % size;
    else if (++h >= size)
      h -= size;
  }
  return 0;
}


Pix FStringVHSet::add(FString& item)
{
  if (HASHTABLE_TOO_CROWDED(count, size))
    resize();

  unsigned int bestspot = size;
  unsigned int hashval = FStringHASH(item);
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
    else if (KeyCompare(tab[h],item)==0)
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


void FStringVHSet::del(FString& key)
{
  unsigned int hashval = FStringHASH(key);
  unsigned int h = hashval % size;
  for (unsigned int i = 0; i <= size; ++i)
  {
    if (status[h] == EMPTYCELL)
      return;
    else if (status[h] == VALIDCELL && KeyCompare(key, tab[h])==0)
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


void FStringVHSet::clear()
{
  for (unsigned int i = 0; i < size; ++i) status[i] = EMPTYCELL;
  count = 0;
}

void FStringVHSet::resize(unsigned int newsize)
{
  if (newsize <= count)
  {
    newsize = DEFAULT_INITIAL_CAPACITY;
    while (HASHTABLE_TOO_CROWDED(count, newsize))  newsize <<= 1;
  }
  FString* oldtab = tab;
  char* oldstatus = status;
  unsigned int oldsize = size;
  tab = new FString[size = newsize];
  status = new char[size];
  unsigned int i;
  for (i = 0; i < size; ++i) status[i] = EMPTYCELL;
  count = 0;
  for ( i = 0; i < oldsize; ++i) if (oldstatus[i] == VALIDCELL) add(oldtab[i]);
  delete [] oldtab;
  delete oldstatus;
}

Pix FStringVHSet::first()
{
  for (unsigned int pos = 0; pos < size; ++pos)
    if (status[pos] == VALIDCELL) return Pix(&tab[pos]);
  return 0;
}

void FStringVHSet::next(Pix& i)
{
  if (i == 0) return;
  unsigned int pos = ((unsigned)i - (unsigned)tab) / sizeof(FString) + 1;
  for (; pos < size; ++pos)
    if (status[pos] == VALIDCELL)
    {
      i = Pix(&tab[pos]);
      return;
    }
  i = 0;
}
  
int FStringVHSet:: operator == (FStringVHSet& b)
{
  if (count != b.count)
    return 0;
  else
  {
	unsigned int i;
    for ( i = 0; i < size; ++i)
      if (status[i] == VALIDCELL && b.seek(tab[i]) == 0)
          return 0;
    for ( i = 0; i < b.size; ++i)
      if (b.status[i] == VALIDCELL && seek(b.tab[i]) == 0)
          return 0;
    return 1;
  }
}

int FStringVHSet::operator <= (FStringVHSet& b)
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

void FStringVHSet::operator |= (FStringVHSet& b)
{
  if (&b == this || b.count == 0)
    return;
  for (unsigned int i = 0; i < b.size; ++i)
    if (b.status[i] == VALIDCELL) add(b.tab[i]);
}

void FStringVHSet::operator &= (FStringVHSet& b)
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

void FStringVHSet::operator -= (FStringVHSet& b)
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

int FStringVHSet::OK()
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
