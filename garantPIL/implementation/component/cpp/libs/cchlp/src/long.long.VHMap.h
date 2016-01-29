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


#ifndef _longlongVHMap_h
#ifdef __GNUG__
#pragma interface
#endif
#define _longlongVHMap_h 1

#include "long.long.Map.h"


class longlongVHMap : public longlongMap
{
protected:
  long*           tab;
  long*           cont;
  char*          status;
  unsigned int   size;

public:
                longlongVHMap(long  dflt,unsigned int sz=DEFAULT_INITIAL_CAPACITY);
                longlongVHMap(longlongVHMap& a);
  inline               ~longlongVHMap();

  long&          operator [] (long  key);

  void          del(long  key);

  Pix           first();
  void          next(Pix& i);
  inline long&          key(Pix i);
  inline long&          contents(Pix i);

  Pix           seek(long  key);
  inline int           contains(long  key);

  void          clear(); 
  void          resize(unsigned int newsize = 0);

  int           OK();
};

inline longlongVHMap::~longlongVHMap()
{
  delete [] tab;
  delete [] cont;
  delete [] status;
}

inline int longlongVHMap::contains(long  key)
{
  return seek(key) != 0;
}

inline long& longlongVHMap::key(Pix i)
{
  if (i == 0) error("null Pix");
  return *((long*)i);
}

inline long& longlongVHMap::contents(Pix i)
{
  if (i == 0) error("null Pix");
  return cont[((unsigned)(i) - (unsigned)(tab)) / sizeof(long)];
}

#endif
