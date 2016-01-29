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


#ifndef _FStringSplaySet_h
#ifdef __GNUG__
#pragma interface
#endif
#define _FStringSplaySet_h 1

#include "FString.Set.h"
#include "FString.SplayNode.h"

class FStringSplaySet : public FStringSet
{
protected:
  FStringSplayNode*   root;

  FStringSplayNode*   leftmost();
  FStringSplayNode*   rightmost();
  FStringSplayNode*   pred(FStringSplayNode* t);
  FStringSplayNode*   succ(FStringSplayNode* t);
  void            _kill(FStringSplayNode* t);
  FStringSplayNode*   _copy(FStringSplayNode* t);
	struct _dummySplayNode
	{
	  FStringSplayNode*    lt;
	  FStringSplayNode*    rt;
	  FStringSplayNode*    par;
	} _dummy_null;

public:
                  FStringSplaySet();
                  FStringSplaySet(FStringSplaySet& a);
  inline                 ~FStringSplaySet();

  Pix             add(FString& item);
  void            del(FString& item);
  inline int             contains(FString& item);

  inline void            clear();

  inline Pix             first();
  inline void            next(Pix& i);
  inline FString&            operator () (Pix i);
  Pix             seek(FString& item);

  Pix             last();
  void            prev(Pix& i);

  FStringSplaySet&    operator =  (const FStringSplaySet& b);
  void            operator |= (FStringSplaySet& b);
  void            operator -= (FStringSplaySet& b);
  void            operator &= (FStringSplaySet& b);

  int             operator == (FStringSplaySet& b);
  int             operator != (FStringSplaySet& b);
  int             operator <= (FStringSplaySet& b); 

  int             OK();
};


inline FStringSplaySet::~FStringSplaySet()
{
  _kill(root);
}

inline FStringSplaySet::FStringSplaySet()
{
  root = 0;
  count = 0;
}

inline FStringSplaySet::FStringSplaySet(FStringSplaySet& b)
{
  count = b.count;
  root = _copy(b.root);
}


inline FStringSplaySet& FStringSplaySet::operator = (const FStringSplaySet& b)
{
  if (this != &b)
    {
      _kill (root);
      count = b.count;
      root = _copy (b.root);
    }
  return *this;
}

inline int FStringSplaySet::operator != (FStringSplaySet& b)
{
  return ! (*this == b);
}

inline Pix FStringSplaySet::first()
{
  return Pix(leftmost());
}

inline Pix FStringSplaySet::last()
{
  return Pix(rightmost());
}

inline void FStringSplaySet::next(Pix& i)
{
  if (i != 0) i = Pix(succ((FStringSplayNode*)i));
}

inline void FStringSplaySet::prev(Pix& i)
{
  if (i != 0) i = Pix(pred((FStringSplayNode*)i));
}

inline FString& FStringSplaySet::operator () (Pix i)
{
  if (i == 0) error("null Pix");
  return ((FStringSplayNode*)i)->item;
}

inline void FStringSplaySet::clear()
{
  _kill(root);
  count = 0;
  root = 0;
}

inline int FStringSplaySet::contains(FString& key)
{
  return seek(key) != 0;
}

#endif
