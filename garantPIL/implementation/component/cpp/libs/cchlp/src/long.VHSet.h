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


#ifndef _longVHSet_h
#ifdef __GNUG__
#pragma interface
#endif
#define _longVHSet_h 1

#include "long.Set.h"



class longVHSet : public longSet
{
protected:
  long*          tab;
  char*         status;
  unsigned int  size;

public:
                longVHSet(unsigned int sz = DEFAULT_INITIAL_CAPACITY);
                longVHSet(longVHSet& a);
  inline               ~longVHSet();

  Pix           add(long  item);
  void          del(long  item);
  inline int           contains(long  item);

  void          clear();

  Pix           first();
  void          next(Pix& i);
  inline long&          operator () (Pix i);
  Pix           seek(long  item);

  void          operator |= (longVHSet& b);
  void          operator -= (longVHSet& b);
  void          operator &= (longVHSet& b);

  int           operator == (longVHSet& b);
  int           operator != (longVHSet& b);
  int           operator <= (longVHSet& b); 

  int           capacity();
  void          resize(unsigned int newsize = 0);

  int           OK();
};


inline longVHSet::~longVHSet()
{
  delete [] tab;
  delete status;
}


inline int longVHSet::capacity()
{
  return size;
}

inline int longVHSet::contains(long  key)
{
  return seek(key) != 0;
}

inline long& longVHSet::operator () (Pix i)
{
  if (i == 0) error("null Pix");
  return *((long*)i);
}

inline int longVHSet::operator != (longVHSet& b)
{
  return ! ((*this) == b);
}

#endif
