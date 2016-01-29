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


#ifndef _u_int32_tFStringSplayMap_h
#ifdef __GNUG__
#pragma interface
#endif
#define _u_int32_tFStringSplayMap_h 1

#include "u_int32_t.FString.Map.h"

#ifndef _u_int32_tFStringSplayNode
#define _u_int32_tFStringSplayNode 1

struct u_int32_tFStringSplayNode
{
  u_int32_tFStringSplayNode*   lt;
  u_int32_tFStringSplayNode*   rt;
  u_int32_tFStringSplayNode*   par;
  u_int32_t                item;
  FString                cont;
                     u_int32_tFStringSplayNode(u_int32_t  h, FString& c, 
                                     u_int32_tFStringSplayNode* l=0, 
                                     u_int32_tFStringSplayNode* r=0);
                  ~u_int32_tFStringSplayNode();
};


inline u_int32_tFStringSplayNode::u_int32_tFStringSplayNode(u_int32_t  h, FString& c, 
                                        u_int32_tFStringSplayNode* l, 
                                        u_int32_tFStringSplayNode* r)
     :lt(l), rt(r), par(0), item(h), cont(c)  {}

inline u_int32_tFStringSplayNode::~u_int32_tFStringSplayNode() {}

typedef u_int32_tFStringSplayNode* u_int32_tFStringSplayNodePtr;

#endif

class u_int32_tFStringSplayMap : public u_int32_tFStringMap
{
protected:
  u_int32_tFStringSplayNode*   root;

  u_int32_tFStringSplayNode*   leftmost();
  u_int32_tFStringSplayNode*   rightmost();
  u_int32_tFStringSplayNode*   pred(u_int32_tFStringSplayNode* t);
  u_int32_tFStringSplayNode*   succ(u_int32_tFStringSplayNode* t);
  void               _kill(u_int32_tFStringSplayNode* t);
  u_int32_tFStringSplayNode*   _copy(u_int32_tFStringSplayNode* t);

	struct _dummySplayNode
	{
	  u_int32_tFStringSplayNode*    lt;
	  u_int32_tFStringSplayNode*    rt;
	  u_int32_tFStringSplayNode*    par;
	} _dummy_null;
public:
               u_int32_tFStringSplayMap(FString& dflt);
               u_int32_tFStringSplayMap(u_int32_tFStringSplayMap& a);
  inline              ~u_int32_tFStringSplayMap();

  FString&          operator [] (u_int32_t  key);

  void          del(u_int32_t  key);

  inline Pix           first();
  inline void          next(Pix& i);
  inline u_int32_t&          key(Pix i);
  inline FString&          contents(Pix i);

  Pix           seek(u_int32_t  key);
  inline int           contains(u_int32_t  key);

  inline void          clear(); 

  Pix           last();
  void          prev(Pix& i);

  int           OK();
};


inline u_int32_tFStringSplayMap::~u_int32_tFStringSplayMap()
{
  _kill(root);
}

inline u_int32_tFStringSplayMap::u_int32_tFStringSplayMap(FString& dflt) :u_int32_tFStringMap(dflt)
{
  root = 0;
}

inline u_int32_tFStringSplayMap::u_int32_tFStringSplayMap(u_int32_tFStringSplayMap& b) :u_int32_tFStringMap(b.def)
{
  count = b.count;
  root = _copy(b.root);
}

inline Pix u_int32_tFStringSplayMap::first()
{
  return Pix(leftmost());
}

inline Pix u_int32_tFStringSplayMap::last()
{
  return Pix(rightmost());
}

inline void u_int32_tFStringSplayMap::next(Pix& i)
{
  if (i != 0) i = Pix(succ((u_int32_tFStringSplayNode*)i));
}

inline void u_int32_tFStringSplayMap::prev(Pix& i)
{
  if (i != 0) i = Pix(pred((u_int32_tFStringSplayNode*)i));
}

inline u_int32_t& u_int32_tFStringSplayMap::key (Pix i)
{
  if (i == 0) error("null Pix");
  return ((u_int32_tFStringSplayNode*)i)->item;
}

inline FString& u_int32_tFStringSplayMap::contents (Pix i)
{
  if (i == 0) error("null Pix");
  return ((u_int32_tFStringSplayNode*)i)->cont;
}

inline void u_int32_tFStringSplayMap::clear()
{
  _kill(root);
  count = 0;
  root = 0;
}

inline int u_int32_tFStringSplayMap::contains(u_int32_t  key)
{
  return seek(key) != 0;
}

#endif
