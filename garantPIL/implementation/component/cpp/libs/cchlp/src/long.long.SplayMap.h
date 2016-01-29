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


#ifndef _longlongSplayMap_h
#ifdef __GNUG__
#pragma interface
#endif
#define _longlongSplayMap_h 1

#include "long.long.Map.h"

#ifndef _longlongSplayNode
#define _longlongSplayNode 1

struct longlongSplayNode
{
  longlongSplayNode*   lt;
  longlongSplayNode*   rt;
  longlongSplayNode*   par;
  long                item;
  long                cont;
                     longlongSplayNode(long  h, long  c, 
                                     longlongSplayNode* l=0, 
                                     longlongSplayNode* r=0);
                  ~longlongSplayNode();
};


inline longlongSplayNode::longlongSplayNode(long  h, long  c, 
                                        longlongSplayNode* l, 
                                        longlongSplayNode* r)
     :lt(l), rt(r), par(0), item(h), cont(c)  {}

inline longlongSplayNode::~longlongSplayNode() {}

typedef longlongSplayNode* longlongSplayNodePtr;

#endif

class longlongSplayMap : public longlongMap
{
protected:
  longlongSplayNode*   root;

  longlongSplayNode*   leftmost();
  longlongSplayNode*   rightmost();
  longlongSplayNode*   pred(longlongSplayNode* t);
  longlongSplayNode*   succ(longlongSplayNode* t);
  void               _kill(longlongSplayNode* t);
  longlongSplayNode*   _copy(longlongSplayNode* t);

	struct _dummySplayNode
	{
	  longlongSplayNode*    lt;
	  longlongSplayNode*    rt;
	  longlongSplayNode*    par;
	} _dummy_null;
public:
               longlongSplayMap(long  dflt);
               longlongSplayMap(longlongSplayMap& a);
  inline              ~longlongSplayMap();

  long&          operator [] (long  key);

  void          del(long  key);

  inline Pix           first();
  inline void          next(Pix& i);
  inline long&          key(Pix i);
  inline long&          contents(Pix i);

  Pix           seek(long  key);
  inline int           contains(long  key);

  inline void          clear(); 

  Pix           last();
  void          prev(Pix& i);

  int           OK();
};


inline longlongSplayMap::~longlongSplayMap()
{
  _kill(root);
}

inline longlongSplayMap::longlongSplayMap(long  dflt) :longlongMap(dflt)
{
  root = 0;
}

inline longlongSplayMap::longlongSplayMap(longlongSplayMap& b) :longlongMap(b.def)
{
  count = b.count;
  root = _copy(b.root);
}

inline Pix longlongSplayMap::first()
{
  return Pix(leftmost());
}

inline Pix longlongSplayMap::last()
{
  return Pix(rightmost());
}

inline void longlongSplayMap::next(Pix& i)
{
  if (i != 0) i = Pix(succ((longlongSplayNode*)i));
}

inline void longlongSplayMap::prev(Pix& i)
{
  if (i != 0) i = Pix(pred((longlongSplayNode*)i));
}

inline long& longlongSplayMap::key (Pix i)
{
  if (i == 0) error("null Pix");
  return ((longlongSplayNode*)i)->item;
}

inline long& longlongSplayMap::contents (Pix i)
{
  if (i == 0) error("null Pix");
  return ((longlongSplayNode*)i)->cont;
}

inline void longlongSplayMap::clear()
{
  _kill(root);
  count = 0;
  root = 0;
}

inline int longlongSplayMap::contains(long  key)
{
  return seek(key) != 0;
}

#endif
