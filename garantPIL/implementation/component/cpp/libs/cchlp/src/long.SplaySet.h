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


#ifndef _longSplaySet_h
#ifdef __GNUG__
#pragma interface
#endif
#define _longSplaySet_h 1

#include "long.Set.h"
#include "long.SplayNode.h"

class longSplaySet : public longSet
{
protected:
  longSplayNode*   root;

  longSplayNode*   leftmost();
  longSplayNode*   rightmost();
  longSplayNode*   pred(longSplayNode* t);
  longSplayNode*   succ(longSplayNode* t);
  void            _kill(longSplayNode* t);
  longSplayNode*   _copy(longSplayNode* t);

	struct _dummySplayNode
	{
	  longSplayNode*    lt;
	  longSplayNode*    rt;
	  longSplayNode*    par;
	} _dummy_null;
public:
                  longSplaySet();
                  longSplaySet(longSplaySet& a);
  inline                 ~longSplaySet();

  Pix             add(long  item);
  void            del(long  item);
  inline int             contains(long  item);

  inline void            clear();

  inline Pix             first();
  inline void            next(Pix& i);
  inline long&            operator () (Pix i);
  Pix             seek(long  item);

  Pix             last();
  void            prev(Pix& i);

  longSplaySet&    operator =  (const longSplaySet& b);
  void            operator |= (longSplaySet& b);
  void            operator -= (longSplaySet& b);
  void            operator &= (longSplaySet& b);
  int             operator & (longSplaySet& b);

  int             operator == (longSplaySet& b);
  int             operator != (longSplaySet& b);
  int             operator <= (longSplaySet& b); 

  int             OK();
};


inline longSplaySet::~longSplaySet()
{
  _kill(root);
}

inline longSplaySet::longSplaySet()
{
  root = 0;
  count = 0;
}

inline longSplaySet::longSplaySet(longSplaySet& b)
{
  count = b.count;
  root = _copy(b.root);
}


inline longSplaySet& longSplaySet::operator = (const longSplaySet& b)
{
  if (this != &b)
    {
      _kill (root);
      count = b.count;
      root = _copy (b.root);
    }
  return *this;
}

inline int longSplaySet::operator != (longSplaySet& b)
{
  return ! (*this == b);
}

inline Pix longSplaySet::first()
{
  return Pix(leftmost());
}

inline Pix longSplaySet::last()
{
  return Pix(rightmost());
}

inline void longSplaySet::next(Pix& i)
{
  if (i != 0) i = Pix(succ((longSplayNode*)i));
}

inline void longSplaySet::prev(Pix& i)
{
  if (i != 0) i = Pix(pred((longSplayNode*)i));
}

inline long& longSplaySet::operator () (Pix i)
{
  if (i == 0) error("null Pix");
  return ((longSplayNode*)i)->item;
}

inline void longSplaySet::clear()
{
  _kill(root);
  count = 0;
  root = 0;
}

inline int longSplaySet::contains(long  key)
{
  return seek(key) != 0;
}

#endif
