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


#ifndef _u_int64_tSplaySet_h
#ifdef __GNUG__
#pragma interface
#endif
#define _u_int64_tSplaySet_h 1

#include "u_int32_t.SplaySet.h"
#include "u_int64_t.Set.h"
#include "u_int64_t.SplayNode.h"

class u_int64_tSplaySet : public u_int64_tSet
{
protected:
  u_int64_tSplayNode*   root;

  u_int64_tSplayNode*   leftmost();
  u_int64_tSplayNode*   rightmost();
  u_int64_tSplayNode*   pred(u_int64_tSplayNode* t);
  u_int64_tSplayNode*   succ(u_int64_tSplayNode* t);
  void            _kill(u_int64_tSplayNode* t);
  u_int64_tSplayNode*   _copy(u_int64_tSplayNode* t);
	struct _dummySplayNode
	{
	  u_int64_tSplayNode*    lt;
	  u_int64_tSplayNode*    rt;
	  u_int64_tSplayNode*    par;
	} _dummy_null;

public:
                  u_int64_tSplaySet();
                  u_int64_tSplaySet(u_int64_tSplaySet& a);
  inline                 ~u_int64_tSplaySet();

  Pix             add(u_int64_t  item);
  void            del(u_int64_t  item);
  inline int             contains(u_int64_t  item);

  inline void            clear();

  inline Pix             first();
  inline void            next(Pix& i);
  inline u_int64_t&            operator () (Pix i);
  Pix             seek(u_int64_t  item);

  Pix             last();
  void            prev(Pix& i);

  u_int64_tSplaySet&    operator =  (const u_int64_tSplaySet& b);
  void            operator |= (u_int64_tSplaySet& b);
  void            set_or(u_int64_tSplaySet* b);
  void            operator -= (u_int64_tSplaySet& b);
  void            operator &= (u_int64_tSplaySet& b);
  void            operator &= (u_int32_tSplaySet& b);

  int             operator == (u_int64_tSplaySet& b);
  int             operator != (u_int64_tSplaySet& b);
  int             operator <= (u_int64_tSplaySet& b); 

  int             OK();
};


inline u_int64_tSplaySet::~u_int64_tSplaySet()
{
  _kill(root);
}

inline u_int64_tSplaySet::u_int64_tSplaySet()
{
  root = 0;
  count = 0;
}

inline u_int64_tSplaySet::u_int64_tSplaySet(u_int64_tSplaySet& b)
{
  count = b.count;
  root = _copy(b.root);
}


inline u_int64_tSplaySet& u_int64_tSplaySet::operator = (const u_int64_tSplaySet& b)
{
  if (this != &b)
    {
      _kill (root);
      count = b.count;
      root = _copy (b.root);
    }
  return *this;
}

inline int u_int64_tSplaySet::operator != (u_int64_tSplaySet& b)
{
  return ! (*this == b);
}

inline Pix u_int64_tSplaySet::first()
{
  return Pix(leftmost());
}

inline Pix u_int64_tSplaySet::last()
{
  return Pix(rightmost());
}

inline void u_int64_tSplaySet::next(Pix& i)
{
  if (i != 0) i = Pix(succ((u_int64_tSplayNode*)i));
}

inline void u_int64_tSplaySet::prev(Pix& i)
{
  if (i != 0) i = Pix(pred((u_int64_tSplayNode*)i));
}

inline u_int64_t& u_int64_tSplaySet::operator () (Pix i)
{
  if (i == 0) error("null Pix");
  return ((u_int64_tSplayNode*)i)->item;
}

inline void u_int64_tSplaySet::clear()
{
  _kill(root);
  count = 0;
  root = 0;
}

inline int u_int64_tSplaySet::contains(u_int64_t  key)
{
  return seek(key) != 0;
}

#endif
