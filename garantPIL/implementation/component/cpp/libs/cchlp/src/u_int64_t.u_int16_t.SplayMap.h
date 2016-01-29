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


#ifndef _u_int64_tu_int16_tSplayMap_h
#ifdef __GNUG__
#pragma interface
#endif
#define _u_int64_tu_int16_tSplayMap_h 1

#include "u_int64_t.u_int16_t.Map.h"

#ifndef _u_int64_tu_int16_tSplayNode
#define _u_int64_tu_int16_tSplayNode 1

struct u_int64_tu_int16_tSplayNode
{
  u_int64_tu_int16_tSplayNode*   lt;
  u_int64_tu_int16_tSplayNode*   rt;
  u_int64_tu_int16_tSplayNode*   par;
  u_int64_t                item;
  u_int16_t                cont;
                     u_int64_tu_int16_tSplayNode(u_int64_t  h, u_int16_t  c, 
                                     u_int64_tu_int16_tSplayNode* l=0, 
                                     u_int64_tu_int16_tSplayNode* r=0);
                  ~u_int64_tu_int16_tSplayNode();
};


inline u_int64_tu_int16_tSplayNode::u_int64_tu_int16_tSplayNode(u_int64_t  h, u_int16_t  c, 
                                        u_int64_tu_int16_tSplayNode* l, 
                                        u_int64_tu_int16_tSplayNode* r)
     :lt(l), rt(r), par(0), item(h), cont(c)  {}

inline u_int64_tu_int16_tSplayNode::~u_int64_tu_int16_tSplayNode() {}

typedef u_int64_tu_int16_tSplayNode* u_int64_tu_int16_tSplayNodePtr;

#endif

class u_int64_tu_int16_tSplayMap : public u_int64_tu_int16_tMap
{
protected:
  u_int64_tu_int16_tSplayNode*   root;

  u_int64_tu_int16_tSplayNode*   leftmost();
  u_int64_tu_int16_tSplayNode*   rightmost();
  u_int64_tu_int16_tSplayNode*   pred(u_int64_tu_int16_tSplayNode* t);
  u_int64_tu_int16_tSplayNode*   succ(u_int64_tu_int16_tSplayNode* t);
  void               _kill(u_int64_tu_int16_tSplayNode* t);
  u_int64_tu_int16_tSplayNode*   _copy(u_int64_tu_int16_tSplayNode* t);
	struct _dummySplayNode
	{
	  u_int64_tu_int16_tSplayNode*    lt;
	  u_int64_tu_int16_tSplayNode*    rt;
	  u_int64_tu_int16_tSplayNode*    par;
	} _dummy_null;
public:
               u_int64_tu_int16_tSplayMap(u_int16_t  dflt);
               u_int64_tu_int16_tSplayMap(u_int64_tu_int16_tSplayMap& a);
  inline              ~u_int64_tu_int16_tSplayMap();

  u_int16_t&          operator [] (u_int64_t  key);

  void          del(u_int64_t  key);

  inline Pix           first();
  inline void          next(Pix& i);
  inline u_int64_t&          key(Pix i);
  inline u_int16_t&          contents(Pix i);

  Pix           seek(u_int64_t  key);
  inline int           contains(u_int64_t  key);

  inline void          clear(); 

  Pix           last();
  void          prev(Pix& i);

  int           OK();
};


inline u_int64_tu_int16_tSplayMap::~u_int64_tu_int16_tSplayMap()
{
  _kill(root);
}

inline u_int64_tu_int16_tSplayMap::u_int64_tu_int16_tSplayMap(u_int16_t  dflt) :u_int64_tu_int16_tMap(dflt)
{
  root = 0;
}

inline u_int64_tu_int16_tSplayMap::u_int64_tu_int16_tSplayMap(u_int64_tu_int16_tSplayMap& b) :u_int64_tu_int16_tMap(b.def)
{
  count = b.count;
  root = _copy(b.root);
}

inline Pix u_int64_tu_int16_tSplayMap::first()
{
  return Pix(leftmost());
}

inline Pix u_int64_tu_int16_tSplayMap::last()
{
  return Pix(rightmost());
}

inline void u_int64_tu_int16_tSplayMap::next(Pix& i)
{
  if (i != 0) i = Pix(succ((u_int64_tu_int16_tSplayNode*)i));
}

inline void u_int64_tu_int16_tSplayMap::prev(Pix& i)
{
  if (i != 0) i = Pix(pred((u_int64_tu_int16_tSplayNode*)i));
}

inline u_int64_t& u_int64_tu_int16_tSplayMap::key (Pix i)
{
  if (i == 0) error("null Pix");
  return ((u_int64_tu_int16_tSplayNode*)i)->item;
}

inline u_int16_t& u_int64_tu_int16_tSplayMap::contents (Pix i)
{
  if (i == 0) error("null Pix");
  return ((u_int64_tu_int16_tSplayNode*)i)->cont;
}

inline void u_int64_tu_int16_tSplayMap::clear()
{
  _kill(root);
  count = 0;
  root = 0;
}

inline int u_int64_tu_int16_tSplayMap::contains(u_int64_t  key)
{
  return seek(key) != 0;
}

#endif
