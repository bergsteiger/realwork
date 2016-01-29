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


#ifndef _FStringVHSet_h
#ifdef __GNUG__
#pragma interface
#endif
#define _FStringVHSet_h 1

#include "FString.Set.h"



class FStringVHSet : public FStringSet
{
protected:
  FString*          tab;
  char*         status;
  unsigned int  size;

public:
                FStringVHSet(unsigned int sz = DEFAULT_INITIAL_CAPACITY);
                FStringVHSet(FStringVHSet& a);
  inline               ~FStringVHSet();

  Pix           add(FString& item);
  void          del(FString& item);
  inline int           contains(FString& item);

  void          clear();

  Pix           first();
  void          next(Pix& i);
  inline FString&          operator () (Pix i);
  Pix           seek(FString& item);

  void          operator |= (FStringVHSet& b);
  void          operator -= (FStringVHSet& b);
  void          operator &= (FStringVHSet& b);

  int           operator == (FStringVHSet& b);
  int           operator != (FStringVHSet& b);
  int           operator <= (FStringVHSet& b); 

  int           capacity();
  void          resize(unsigned int newsize = 0);

  int           OK();
};


inline FStringVHSet::~FStringVHSet()
{
  delete [] tab;
  delete status;
}


inline int FStringVHSet::capacity()
{
  return size;
}

inline int FStringVHSet::contains(FString& key)
{
  return seek(key) != 0;
}

inline FString& FStringVHSet::operator () (Pix i)
{
  if (i == 0) error("null Pix");
  return *((FString*)i);
}

inline int FStringVHSet::operator != (FStringVHSet& b)
{
  return ! ((*this) == b);
}

#endif
