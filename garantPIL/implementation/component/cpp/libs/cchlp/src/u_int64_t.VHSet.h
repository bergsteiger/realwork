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


#ifndef _u_int64_tVHSet_h
#ifdef __GNUG__
#pragma interface
#endif
#define _u_int64_tVHSet_h 1

#include "u_int64_t.Set.h"



class u_int64_tVHSet : public u_int64_tSet
{
protected:
  u_int64_t*          tab;
  char*         status;
  unsigned int  size;

public:
                u_int64_tVHSet(unsigned int sz = DEFAULT_INITIAL_CAPACITY);
                u_int64_tVHSet(u_int64_tVHSet& a);
  inline               ~u_int64_tVHSet();

  Pix           add(u_int64_t  item);
  void          del(u_int64_t  item);
  inline int           contains(u_int64_t  item);

  void          clear();

  Pix           first();
  void          next(Pix& i);
  inline u_int64_t&          operator () (Pix i);
  Pix           seek(u_int64_t  item);

  void          operator |= (u_int64_tVHSet& b);
  void          operator -= (u_int64_tVHSet& b);
  void          operator &= (u_int64_tVHSet& b);

  int           operator == (u_int64_tVHSet& b);
  int           operator != (u_int64_tVHSet& b);
  int           operator <= (u_int64_tVHSet& b); 

  int           capacity();
  void          resize(unsigned int newsize = 0);

  int           OK();
};


inline u_int64_tVHSet::~u_int64_tVHSet()
{
  delete [] tab;
  delete status;
}


inline int u_int64_tVHSet::capacity()
{
  return size;
}

inline int u_int64_tVHSet::contains(u_int64_t  key)
{
  return seek(key) != 0;
}

inline u_int64_t& u_int64_tVHSet::operator () (Pix i)
{
  if (i == 0) error("null Pix");
  return *((u_int64_t*)i);
}

inline int u_int64_tVHSet::operator != (u_int64_tVHSet& b)
{
  return ! ((*this) == b);
}

#endif
