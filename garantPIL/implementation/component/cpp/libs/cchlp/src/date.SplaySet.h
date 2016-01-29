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


#ifndef _dateSplaySet_h
#ifdef __GNUG__
#pragma interface
#endif
#define _dateSplaySet_h 1

#include "date.Set.h"
#include "date.SplayNode.h"

class dateSplaySet : public dateSet
{
protected:
  dateSplayNode*   root;

  dateSplayNode*   leftmost();
  dateSplayNode*   rightmost();
  dateSplayNode*   pred(dateSplayNode* t);
  dateSplayNode*   succ(dateSplayNode* t);
  void            _kill(dateSplayNode* t);
  dateSplayNode*   _copy(dateSplayNode* t);

	struct _dummySplayNode
	{
	  dateSplayNode*    lt;
	  dateSplayNode*    rt;
	  dateSplayNode*    par;
	} _dummy_null;

public:
                  dateSplaySet();
                  dateSplaySet(dateSplaySet& a);
  inline                 ~dateSplaySet();

  Pix             add(date& item);
  void            del(date& item);
  inline int             contains(date& item);

  inline void            clear();

  inline Pix             first();
  inline void            next(Pix& i);
  inline date&            operator () (Pix i);
  Pix             seek(date& item);

  Pix             last();
  void            prev(Pix& i);

  dateSplaySet&    operator =  (const dateSplaySet& b);
  void            operator |= (dateSplaySet& b);
  void            operator -= (dateSplaySet& b);
  void            operator &= (dateSplaySet& b);

  int             operator == (dateSplaySet& b);
  int             operator != (dateSplaySet& b);
  int             operator <= (dateSplaySet& b); 

  int             OK();
};


inline dateSplaySet::~dateSplaySet()
{
  _kill(root);
}

inline dateSplaySet::dateSplaySet()
{
  root = 0;
  count = 0;
}

inline dateSplaySet::dateSplaySet(dateSplaySet& b)
{
  count = b.count;
  root = _copy(b.root);
}


inline dateSplaySet& dateSplaySet::operator = (const dateSplaySet& b)
{
  if (this != &b)
    {
      _kill (root);
      count = b.count;
      root = _copy (b.root);
    }
  return *this;
}

inline int dateSplaySet::operator != (dateSplaySet& b)
{
  return ! (*this == b);
}

inline Pix dateSplaySet::first()
{
  return Pix(leftmost());
}

inline Pix dateSplaySet::last()
{
  return Pix(rightmost());
}

inline void dateSplaySet::next(Pix& i)
{
  if (i != 0) i = Pix(succ((dateSplayNode*)i));
}

inline void dateSplaySet::prev(Pix& i)
{
  if (i != 0) i = Pix(pred((dateSplayNode*)i));
}

inline date& dateSplaySet::operator () (Pix i)
{
  if (i == 0) error("null Pix");
  return ((dateSplayNode*)i)->item;
}

inline void dateSplaySet::clear()
{
  _kill(root);
  count = 0;
  root = 0;
}

inline int dateSplaySet::contains(date& key)
{
  return seek(key) != 0;
}

#endif
