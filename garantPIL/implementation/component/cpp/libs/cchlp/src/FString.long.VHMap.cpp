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
#include "FString.long.VHMap.h"

/* codes for status fields */

#define EMPTYCELL   0
#define VALIDCELL   1
#define DELETEDCELL 2


FStringlongVHMap::FStringlongVHMap(long  dflt, unsigned int sz)
     :FStringlongMap(dflt)
{
  tab = new FString[size = sz];
  cont = new long[size];
  status = new char[size];
  for (unsigned int i = 0; i < size; ++i) status[i] = EMPTYCELL;
}

FStringlongVHMap::FStringlongVHMap(FStringlongVHMap& a) : FStringlongMap(a.def)
{
  tab = new FString[size = a.size];
  cont = new long[size];
  status = new char[size];
  for (unsigned int i = 0; i < size; ++i) status[i] = EMPTYCELL;
  count = 0;
  for (Pix p = a.first(); p; a.next(p)) (*this)[a.key(p)] = a.contents(p);
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

Pix FStringlongVHMap::seek(FString& key)
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


long& FStringlongVHMap::operator [](FString& item)
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
      ++count;
      if (bestspot >= size) bestspot = h;
      tab[bestspot] = item;
      status[bestspot] = VALIDCELL;
      cont[bestspot] = def;
      return cont[bestspot];
    }
    else if (status[h] == DELETEDCELL)
    {
      if (bestspot >= size) bestspot = h;
    }
    else if (KeyCompare(tab[h],item)==0)
      return cont[h];

    if (i == 0)
      h = (h + doublehashinc(hashval, size)) % size;
    else if (++h >= size)
      h -= size;
  }

  ++count;
  status[bestspot] = VALIDCELL;
  tab[bestspot] = item;
  cont[bestspot] = def;
  return cont[bestspot];
}


void FStringlongVHMap::del(FString& key)
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


void FStringlongVHMap::clear()
{
  for (unsigned int i = 0; i < size; ++i) status[i] = EMPTYCELL;
  count = 0;
}

void FStringlongVHMap::resize(unsigned int newsize)
{
  if (newsize <= count)
  {
    newsize = DEFAULT_INITIAL_CAPACITY;
    while (HASHTABLE_TOO_CROWDED(count, newsize)) newsize <<= 1;
  }
  FString* oldtab = tab;
  long* oldcont = cont;
  char* oldstatus = status;
  unsigned int oldsize = size;
  tab = new FString[size = newsize];
  cont = new long[size];
  status = new char[size];
  unsigned int i;
  for (i = 0; i < size; ++i) status[i] = EMPTYCELL;
  count = 0;
  for (i = 0; i < oldsize; ++i) 
    if (oldstatus[i] == VALIDCELL) 
      (*this)[oldtab[i]] = oldcont[i];
  delete [] oldtab;
  delete [] oldcont;
  delete [] oldstatus;
}

Pix FStringlongVHMap::first()
{
  for (unsigned int pos = 0; pos < size; ++pos)
    if (status[pos] == VALIDCELL) return Pix(&tab[pos]);
  return 0;
}

void FStringlongVHMap::next(Pix& i)
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
  

int FStringlongVHMap::OK()
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
