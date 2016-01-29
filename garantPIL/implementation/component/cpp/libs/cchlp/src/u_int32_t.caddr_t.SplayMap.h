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


#ifndef _u_int32_tcaddr_tSplayMap_h
#ifdef __GNUG__
#pragma interface
#endif
#define _u_int32_tcaddr_tSplayMap_h 1

#include "u_int32_t.caddr_t.Map.h"

#ifndef _u_int32_tcaddr_tSplayNode
#define _u_int32_tcaddr_tSplayNode 1

struct u_int32_tcaddr_tSplayNode
{
  u_int32_tcaddr_tSplayNode*   lt;
  u_int32_tcaddr_tSplayNode*   rt;
  u_int32_tcaddr_tSplayNode*   par;
  u_int32_t                item;
  caddr_t                cont;
                     u_int32_tcaddr_tSplayNode(u_int32_t  h, caddr_t  c, 
                                     u_int32_tcaddr_tSplayNode* l=0, 
                                     u_int32_tcaddr_tSplayNode* r=0);
                  ~u_int32_tcaddr_tSplayNode();
};


inline u_int32_tcaddr_tSplayNode::u_int32_tcaddr_tSplayNode(u_int32_t  h, caddr_t  c, 
                                        u_int32_tcaddr_tSplayNode* l, 
                                        u_int32_tcaddr_tSplayNode* r)
     :lt(l), rt(r), par(0), item(h), cont(c)  {}

inline u_int32_tcaddr_tSplayNode::~u_int32_tcaddr_tSplayNode() {}

typedef u_int32_tcaddr_tSplayNode* u_int32_tcaddr_tSplayNodePtr;

#endif

class u_int32_tcaddr_tSplayMap : public u_int32_tcaddr_tMap
{
protected:
  u_int32_tcaddr_tSplayNode*   root;

  u_int32_tcaddr_tSplayNode*   leftmost();
  u_int32_tcaddr_tSplayNode*   rightmost();
  u_int32_tcaddr_tSplayNode*   pred(u_int32_tcaddr_tSplayNode* t);
  u_int32_tcaddr_tSplayNode*   succ(u_int32_tcaddr_tSplayNode* t);
  void               _kill(u_int32_tcaddr_tSplayNode* t);
  u_int32_tcaddr_tSplayNode*   _copy(u_int32_tcaddr_tSplayNode* t);

	struct _dummySplayNode
	{
	  u_int32_tcaddr_tSplayNode*    lt;
	  u_int32_tcaddr_tSplayNode*    rt;
	  u_int32_tcaddr_tSplayNode*    par;
	} _dummy_null;

public:
               u_int32_tcaddr_tSplayMap(caddr_t  dflt);
               u_int32_tcaddr_tSplayMap(u_int32_tcaddr_tSplayMap& a);
  inline              ~u_int32_tcaddr_tSplayMap();

  caddr_t&          operator [] (u_int32_t  key);

  void          del(u_int32_t  key);

  inline Pix           first();
  inline void          next(Pix& i);
  inline u_int32_t&          key(Pix i);
  inline caddr_t&          contents(Pix i);

  Pix           seek(u_int32_t  key);
  inline int           contains(u_int32_t  key);

  inline void          clear(); 

  Pix           last();
  void          prev(Pix& i);

  int           OK();
};


inline u_int32_tcaddr_tSplayMap::~u_int32_tcaddr_tSplayMap()
{
  _kill(root);
}

inline u_int32_tcaddr_tSplayMap::u_int32_tcaddr_tSplayMap(caddr_t  dflt) :u_int32_tcaddr_tMap(dflt)
{
  root = 0;
}

inline u_int32_tcaddr_tSplayMap::u_int32_tcaddr_tSplayMap(u_int32_tcaddr_tSplayMap& b) :u_int32_tcaddr_tMap(b.def)
{
  count = b.count;
  root = _copy(b.root);
}

inline Pix u_int32_tcaddr_tSplayMap::first()
{
  return Pix(leftmost());
}

inline Pix u_int32_tcaddr_tSplayMap::last()
{
  return Pix(rightmost());
}

inline void u_int32_tcaddr_tSplayMap::next(Pix& i)
{
  if (i != 0) i = Pix(succ((u_int32_tcaddr_tSplayNode*)i));
}

inline void u_int32_tcaddr_tSplayMap::prev(Pix& i)
{
  if (i != 0) i = Pix(pred((u_int32_tcaddr_tSplayNode*)i));
}

inline u_int32_t& u_int32_tcaddr_tSplayMap::key (Pix i)
{
  if (i == 0) error("null Pix");
  return ((u_int32_tcaddr_tSplayNode*)i)->item;
}

inline caddr_t& u_int32_tcaddr_tSplayMap::contents (Pix i)
{
  if (i == 0) error("null Pix");
  return ((u_int32_tcaddr_tSplayNode*)i)->cont;
}

inline void u_int32_tcaddr_tSplayMap::clear()
{
  _kill(root);
  count = 0;
  root = 0;
}

inline int u_int32_tcaddr_tSplayMap::contains(u_int32_t  key)
{
  return seek(key) != 0;
}

#endif
