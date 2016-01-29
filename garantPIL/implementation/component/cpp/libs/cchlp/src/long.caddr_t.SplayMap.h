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


#ifndef _longcaddr_tSplayMap_h
#ifdef __GNUG__
#pragma interface
#endif
#define _longcaddr_tSplayMap_h 1

#include "long.caddr_t.Map.h"

#ifndef _longcaddr_tSplayNode
#define _longcaddr_tSplayNode 1

struct longcaddr_tSplayNode
{
  longcaddr_tSplayNode*   lt;
  longcaddr_tSplayNode*   rt;
  longcaddr_tSplayNode*   par;
  long                item;
  caddr_t                cont;
                     longcaddr_tSplayNode(long  h, caddr_t  c, 
                                     longcaddr_tSplayNode* l=0, 
                                     longcaddr_tSplayNode* r=0);
                  ~longcaddr_tSplayNode();
};


inline longcaddr_tSplayNode::longcaddr_tSplayNode(long  h, caddr_t  c, 
                                        longcaddr_tSplayNode* l, 
                                        longcaddr_tSplayNode* r)
     :lt(l), rt(r), par(0), item(h), cont(c)  {}

inline longcaddr_tSplayNode::~longcaddr_tSplayNode() {}

typedef longcaddr_tSplayNode* longcaddr_tSplayNodePtr;

#endif

class longcaddr_tSplayMap : public longcaddr_tMap
{
protected:
  longcaddr_tSplayNode*   root;

  longcaddr_tSplayNode*   leftmost();
  longcaddr_tSplayNode*   rightmost();
  longcaddr_tSplayNode*   pred(longcaddr_tSplayNode* t);
  longcaddr_tSplayNode*   succ(longcaddr_tSplayNode* t);
  void               _kill(longcaddr_tSplayNode* t);
  longcaddr_tSplayNode*   _copy(longcaddr_tSplayNode* t);

	struct _dummySplayNode
	{
	  longcaddr_tSplayNode*    lt;
	  longcaddr_tSplayNode*    rt;
	  longcaddr_tSplayNode*    par;
	} _dummy_null;
public:
               longcaddr_tSplayMap(caddr_t  dflt);
               longcaddr_tSplayMap(longcaddr_tSplayMap& a);
  inline              ~longcaddr_tSplayMap();

  caddr_t&          operator [] (long  key);

  void          del(long  key);

  inline Pix           first();
  inline void          next(Pix& i);
  inline long&          key(Pix i);
  inline caddr_t&          contents(Pix i);

  Pix           seek(long  key);
  inline int           contains(long  key);

  inline void          clear(); 

  Pix           last();
  void          prev(Pix& i);

  int           OK();
};


inline longcaddr_tSplayMap::~longcaddr_tSplayMap()
{
  _kill(root);
}

inline longcaddr_tSplayMap::longcaddr_tSplayMap(caddr_t  dflt) :longcaddr_tMap(dflt)
{
  root = 0;
}

inline longcaddr_tSplayMap::longcaddr_tSplayMap(longcaddr_tSplayMap& b) :longcaddr_tMap(b.def)
{
  count = b.count;
  root = _copy(b.root);
}

inline Pix longcaddr_tSplayMap::first()
{
  return Pix(leftmost());
}

inline Pix longcaddr_tSplayMap::last()
{
  return Pix(rightmost());
}

inline void longcaddr_tSplayMap::next(Pix& i)
{
  if (i != 0) i = Pix(succ((longcaddr_tSplayNode*)i));
}

inline void longcaddr_tSplayMap::prev(Pix& i)
{
  if (i != 0) i = Pix(pred((longcaddr_tSplayNode*)i));
}

inline long& longcaddr_tSplayMap::key (Pix i)
{
  if (i == 0) error("null Pix");
  return ((longcaddr_tSplayNode*)i)->item;
}

inline caddr_t& longcaddr_tSplayMap::contents (Pix i)
{
  if (i == 0) error("null Pix");
  return ((longcaddr_tSplayNode*)i)->cont;
}

inline void longcaddr_tSplayMap::clear()
{
  _kill(root);
  count = 0;
  root = 0;
}

inline int longcaddr_tSplayMap::contains(long  key)
{
  return seek(key) != 0;
}

#endif
