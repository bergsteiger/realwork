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


#ifndef _longlongSplaySetSplayMap_h
#ifdef __GNUG__
#pragma interface
#endif
#define _longlongSplaySetSplayMap_h 1

#include "long.longSplaySet.Map.h"

#ifndef _longlongSplaySetSplayNode
#define _longlongSplaySetSplayNode 1

struct longlongSplaySetSplayNode
{
  longlongSplaySetSplayNode*   lt;
  longlongSplaySetSplayNode*   rt;
  longlongSplaySetSplayNode*   par;
  long                item;
  longSplaySet                cont;
                     longlongSplaySetSplayNode(long  h, longSplaySet& c, 
                                     longlongSplaySetSplayNode* l=0, 
                                     longlongSplaySetSplayNode* r=0);
                  ~longlongSplaySetSplayNode();
};


inline longlongSplaySetSplayNode::longlongSplaySetSplayNode(long  h, longSplaySet& c, 
                                        longlongSplaySetSplayNode* l, 
                                        longlongSplaySetSplayNode* r)
     :lt(l), rt(r), par(0), item(h), cont(c)  {}

inline longlongSplaySetSplayNode::~longlongSplaySetSplayNode() {}

typedef longlongSplaySetSplayNode* longlongSplaySetSplayNodePtr;

#endif

class longlongSplaySetSplayMap : public longlongSplaySetMap
{
protected:
  longlongSplaySetSplayNode*   root;

  longlongSplaySetSplayNode*   leftmost();
  longlongSplaySetSplayNode*   rightmost();
  longlongSplaySetSplayNode*   pred(longlongSplaySetSplayNode* t);
  longlongSplaySetSplayNode*   succ(longlongSplaySetSplayNode* t);
  void               _kill(longlongSplaySetSplayNode* t);
  longlongSplaySetSplayNode*   _copy(longlongSplaySetSplayNode* t);

	struct _dummySplayNode
	{
	  longlongSplaySetSplayNode*    lt;
	  longlongSplaySetSplayNode*    rt;
	  longlongSplaySetSplayNode*    par;
	} _dummy_null;
public:
               longlongSplaySetSplayMap(longSplaySet& dflt);
               longlongSplaySetSplayMap(longlongSplaySetSplayMap& a);
  inline              ~longlongSplaySetSplayMap();

  longSplaySet&          operator [] (long  key);

  void          del(long  key);

  inline Pix           first();
  inline void          next(Pix& i);
  inline long&          key(Pix i);
  inline longSplaySet&          contents(Pix i);

  Pix           seek(long  key);
  inline int           contains(long  key);

  inline void          clear(); 

  Pix           last();
  void          prev(Pix& i);

  int           OK();
};


inline longlongSplaySetSplayMap::~longlongSplaySetSplayMap()
{
  _kill(root);
}

inline longlongSplaySetSplayMap::longlongSplaySetSplayMap(longSplaySet& dflt) :longlongSplaySetMap(dflt)
{
  root = 0;
}

inline longlongSplaySetSplayMap::longlongSplaySetSplayMap(longlongSplaySetSplayMap& b) :longlongSplaySetMap(b.def)
{
  count = b.count;
  root = _copy(b.root);
}

inline Pix longlongSplaySetSplayMap::first()
{
  return Pix(leftmost());
}

inline Pix longlongSplaySetSplayMap::last()
{
  return Pix(rightmost());
}

inline void longlongSplaySetSplayMap::next(Pix& i)
{
  if (i != 0) i = Pix(succ((longlongSplaySetSplayNode*)i));
}

inline void longlongSplaySetSplayMap::prev(Pix& i)
{
  if (i != 0) i = Pix(pred((longlongSplaySetSplayNode*)i));
}

inline long& longlongSplaySetSplayMap::key (Pix i)
{
  if (i == 0) error("null Pix");
  return ((longlongSplaySetSplayNode*)i)->item;
}

inline longSplaySet& longlongSplaySetSplayMap::contents (Pix i)
{
  if (i == 0) error("null Pix");
  return ((longlongSplaySetSplayNode*)i)->cont;
}

inline void longlongSplaySetSplayMap::clear()
{
  _kill(root);
  count = 0;
  root = 0;
}

inline int longlongSplaySetSplayMap::contains(long  key)
{
  return seek(key) != 0;
}

#endif
