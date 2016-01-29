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


#ifndef _FStringlongSplayMap_h
#ifdef __GNUG__
#pragma interface
#endif
#define _FStringlongSplayMap_h 1

#include "FString.long.Map.h"

#ifndef _FStringlongSplayNode
#define _FStringlongSplayNode 1

struct FStringlongSplayNode
{
  FStringlongSplayNode*   lt;
  FStringlongSplayNode*   rt;
  FStringlongSplayNode*   par;
  FString                item;
  long                cont;
                     FStringlongSplayNode(FString& h, long  c, 
                                     FStringlongSplayNode* l=0, 
                                     FStringlongSplayNode* r=0);
                  ~FStringlongSplayNode();
};


inline FStringlongSplayNode::FStringlongSplayNode(FString& h, long  c, 
                                        FStringlongSplayNode* l, 
                                        FStringlongSplayNode* r)
     :lt(l), rt(r), par(0), item(h), cont(c)  {}

inline FStringlongSplayNode::~FStringlongSplayNode() {}

typedef FStringlongSplayNode* FStringlongSplayNodePtr;

#endif

class FStringlongSplayMap : public FStringlongMap
{
protected:
  FStringlongSplayNode*   root;

  FStringlongSplayNode*   leftmost();
  FStringlongSplayNode*   rightmost();
  FStringlongSplayNode*   pred(FStringlongSplayNode* t);
  FStringlongSplayNode*   succ(FStringlongSplayNode* t);
  void               _kill(FStringlongSplayNode* t);
  FStringlongSplayNode*   _copy(FStringlongSplayNode* t);

	struct _dummySplayNode
	{
	  FStringlongSplayNode*    lt;
	  FStringlongSplayNode*    rt;
	  FStringlongSplayNode*    par;
	} _dummy_null;
public:
               FStringlongSplayMap(long  dflt);
               FStringlongSplayMap(FStringlongSplayMap& a);
  inline              ~FStringlongSplayMap();

  long&          operator [] (FString& key);

  void          del(FString& key);

  inline Pix           first();
  inline void          next(Pix& i);
  inline FString&          key(Pix i);
  inline long&          contents(Pix i);

  Pix           seek(FString& key);
  Pix           nearest(FString& key);
  inline int           contains(FString& key);

  inline void          clear(); 

  Pix           last();
  void          prev(Pix& i);

  int           OK();
};


inline FStringlongSplayMap::~FStringlongSplayMap()
{
  _kill(root);
}

inline FStringlongSplayMap::FStringlongSplayMap(long  dflt) :FStringlongMap(dflt)
{
  root = 0;
}

inline FStringlongSplayMap::FStringlongSplayMap(FStringlongSplayMap& b) :FStringlongMap(b.def)
{
  count = b.count;
  root = _copy(b.root);
}

inline Pix FStringlongSplayMap::first()
{
  return Pix(leftmost());
}

inline Pix FStringlongSplayMap::last()
{
  return Pix(rightmost());
}

inline void FStringlongSplayMap::next(Pix& i)
{
  if (i != 0) i = Pix(succ((FStringlongSplayNode*)i));
}

inline void FStringlongSplayMap::prev(Pix& i)
{
  if (i != 0) i = Pix(pred((FStringlongSplayNode*)i));
}

inline FString& FStringlongSplayMap::key (Pix i)
{
  if (i == 0) error("null Pix");
  return ((FStringlongSplayNode*)i)->item;
}

inline long& FStringlongSplayMap::contents (Pix i)
{
  if (i == 0) error("null Pix");
  return ((FStringlongSplayNode*)i)->cont;
}

inline void FStringlongSplayMap::clear()
{
  _kill(root);
  count = 0;
  root = 0;
}

inline int FStringlongSplayMap::contains(FString& key)
{
  return seek(key) != 0;
}

#endif
