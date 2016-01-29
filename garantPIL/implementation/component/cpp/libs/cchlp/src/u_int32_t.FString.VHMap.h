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


#ifndef _u_int32_tFStringVHMap_h
#ifdef __GNUG__
#pragma interface
#endif
#define _u_int32_tFStringVHMap_h 1

#include "u_int32_t.FString.Map.h"


class u_int32_tFStringVHMap : public u_int32_tFStringMap
{
protected:
  u_int32_t*           tab;
  FString*           cont;
  char*          status;
  unsigned int   size;

public:
                u_int32_tFStringVHMap(FString& dflt,unsigned int sz=DEFAULT_INITIAL_CAPACITY);
                u_int32_tFStringVHMap(u_int32_tFStringVHMap& a);
  inline               ~u_int32_tFStringVHMap();

  FString&          operator [] (u_int32_t  key);

  void          del(u_int32_t  key);

  Pix           first();
  void          next(Pix& i);
  inline u_int32_t&          key(Pix i);
  inline FString&          contents(Pix i);

  Pix           seek(u_int32_t  key);
  inline int           contains(u_int32_t  key);

  void          clear(); 
  void          resize(unsigned int newsize = 0);

  int           OK();
};

inline u_int32_tFStringVHMap::~u_int32_tFStringVHMap()
{
  delete [] tab;
  delete [] cont;
  delete [] status;
}

inline int u_int32_tFStringVHMap::contains(u_int32_t  key)
{
  return seek(key) != 0;
}

inline u_int32_t& u_int32_tFStringVHMap::key(Pix i)
{
  if (i == 0) error("null Pix");
  return *((u_int32_t*)i);
}

inline FString& u_int32_tFStringVHMap::contents(Pix i)
{
  if (i == 0) error("null Pix");
  return cont[((unsigned long)(i) - (unsigned long)(tab)) / sizeof(u_int32_t)];
}

#endif
