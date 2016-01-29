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


#ifndef _clTreeNodeSplaySet_h
#ifdef __GNUG__
#pragma interface
#endif
#define _clTreeNodeSplaySet_h 1

#include "clTreeNode.Set.h"
#include "clTreeNode.SplayNode.h"

class clTreeNodeSplaySet : public clTreeNodeSet
{
protected:
  clTreeNodeSplayNode*   root;

  clTreeNodeSplayNode*   leftmost();
  clTreeNodeSplayNode*   rightmost();
  clTreeNodeSplayNode*   pred(clTreeNodeSplayNode* t);
  clTreeNodeSplayNode*   succ(clTreeNodeSplayNode* t);
  void            _kill(clTreeNodeSplayNode* t);
  clTreeNodeSplayNode*   _copy(clTreeNodeSplayNode* t);
	struct _dummySplayNode
	{
	  clTreeNodeSplayNode*    lt;
	  clTreeNodeSplayNode*    rt;
	  clTreeNodeSplayNode*    par;
	} _dummy_null;
public:
                  clTreeNodeSplaySet();
                  clTreeNodeSplaySet(clTreeNodeSplaySet& a);
  inline                 ~clTreeNodeSplaySet();

  Pix             add(clTreeNode& item);
  void            del(clTreeNode& item);
  inline int             contains(clTreeNode& item);

  inline void            clear();

  inline Pix             first();
  inline void            next(Pix& i);
  inline clTreeNode&            operator () (Pix i);
  Pix             seek(clTreeNode& item);

  Pix             last();
  void            prev(Pix& i);

  clTreeNodeSplaySet&    operator =  (const clTreeNodeSplaySet& b);
  void            operator |= (clTreeNodeSplaySet& b);
  void            operator -= (clTreeNodeSplaySet& b);
  void            operator &= (clTreeNodeSplaySet& b);

  int             operator == (clTreeNodeSplaySet& b);
  int             operator != (clTreeNodeSplaySet& b);
  int             operator <= (clTreeNodeSplaySet& b); 

  int             OK();
};


inline clTreeNodeSplaySet::~clTreeNodeSplaySet()
{
  _kill(root);
}

inline clTreeNodeSplaySet::clTreeNodeSplaySet()
{
  root = 0;
  count = 0;
}

inline clTreeNodeSplaySet::clTreeNodeSplaySet(clTreeNodeSplaySet& b)
{
  count = b.count;
  root = _copy(b.root);
}


inline clTreeNodeSplaySet& clTreeNodeSplaySet::operator = (const clTreeNodeSplaySet& b)
{
  if (this != &b)
    {
      _kill (root);
      count = b.count;
      root = _copy (b.root);
    }
  return *this;
}

inline int clTreeNodeSplaySet::operator != (clTreeNodeSplaySet& b)
{
  return ! (*this == b);
}

inline Pix clTreeNodeSplaySet::first()
{
  return Pix(leftmost());
}

inline Pix clTreeNodeSplaySet::last()
{
  return Pix(rightmost());
}

inline void clTreeNodeSplaySet::next(Pix& i)
{
  if (i != 0) i = Pix(succ((clTreeNodeSplayNode*)i));
}

inline void clTreeNodeSplaySet::prev(Pix& i)
{
  if (i != 0) i = Pix(pred((clTreeNodeSplayNode*)i));
}

inline clTreeNode& clTreeNodeSplaySet::operator () (Pix i)
{
  if (i == 0) error("null Pix");
  return ((clTreeNodeSplayNode*)i)->item;
}

inline void clTreeNodeSplaySet::clear()
{
  _kill(root);
  count = 0;
  root = 0;
}

inline int clTreeNodeSplaySet::contains(clTreeNode& key)
{
  return seek(key) != 0;
}

#endif
