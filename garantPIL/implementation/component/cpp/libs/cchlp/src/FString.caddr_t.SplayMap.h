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


#ifndef _FStringcaddr_tSplayMap_h
#ifdef __GNUG__
#pragma interface
#endif
#define _FStringcaddr_tSplayMap_h 1

#include "FString.caddr_t.Map.h"

#ifndef _FStringcaddr_tSplayNode
#define _FStringcaddr_tSplayNode 1

struct FStringcaddr_tSplayNode
{
  FStringcaddr_tSplayNode*   lt;
  FStringcaddr_tSplayNode*   rt;
  FStringcaddr_tSplayNode*   par;
  FString                item;
  caddr_t                cont;
                     FStringcaddr_tSplayNode(FString& h, caddr_t  c, 
                                     FStringcaddr_tSplayNode* l=0, 
                                     FStringcaddr_tSplayNode* r=0);
                  ~FStringcaddr_tSplayNode();
};


inline FStringcaddr_tSplayNode::FStringcaddr_tSplayNode(FString& h, caddr_t  c, 
                                        FStringcaddr_tSplayNode* l, 
                                        FStringcaddr_tSplayNode* r)
     :lt(l), rt(r), par(0), item(h), cont(c)  {}

inline FStringcaddr_tSplayNode::~FStringcaddr_tSplayNode() {}

typedef FStringcaddr_tSplayNode* FStringcaddr_tSplayNodePtr;

#endif

class FStringcaddr_tSplayMap : public FStringcaddr_tMap
{
protected:
  FStringcaddr_tSplayNode*   root;

  FStringcaddr_tSplayNode*   leftmost();
  FStringcaddr_tSplayNode*   rightmost();
  FStringcaddr_tSplayNode*   pred(FStringcaddr_tSplayNode* t);
  FStringcaddr_tSplayNode*   succ(FStringcaddr_tSplayNode* t);
  void               _kill(FStringcaddr_tSplayNode* t);
  FStringcaddr_tSplayNode*   _copy(FStringcaddr_tSplayNode* t);

	struct _dummySplayNode
	{
	  FStringcaddr_tSplayNode*    lt;
	  FStringcaddr_tSplayNode*    rt;
	  FStringcaddr_tSplayNode*    par;
	} _dummy_null;
public:
               FStringcaddr_tSplayMap(caddr_t  dflt);
               FStringcaddr_tSplayMap(FStringcaddr_tSplayMap& a);
  inline              ~FStringcaddr_tSplayMap();

  caddr_t&          operator [] (FString& key);

  void          del(FString& key);

  inline Pix           first();
  inline void          next(Pix& i);
  inline FString&          key(Pix i);
  inline caddr_t&          contents(Pix i);

  Pix           seek(FString& key);
  inline int           contains(FString& key);

  inline void          clear(); 

  Pix           last();
  void          prev(Pix& i);

  int           OK();
};


inline FStringcaddr_tSplayMap::~FStringcaddr_tSplayMap()
{
  _kill(root);
}

inline FStringcaddr_tSplayMap::FStringcaddr_tSplayMap(caddr_t  dflt) :FStringcaddr_tMap(dflt)
{
  root = 0;
}

inline FStringcaddr_tSplayMap::FStringcaddr_tSplayMap(FStringcaddr_tSplayMap& b) :FStringcaddr_tMap(b.def)
{
  count = b.count;
  root = _copy(b.root);
}

inline Pix FStringcaddr_tSplayMap::first()
{
  return Pix(leftmost());
}

inline Pix FStringcaddr_tSplayMap::last()
{
  return Pix(rightmost());
}

inline void FStringcaddr_tSplayMap::next(Pix& i)
{
  if (i != 0) i = Pix(succ((FStringcaddr_tSplayNode*)i));
}

inline void FStringcaddr_tSplayMap::prev(Pix& i)
{
  if (i != 0) i = Pix(pred((FStringcaddr_tSplayNode*)i));
}

inline FString& FStringcaddr_tSplayMap::key (Pix i)
{
  if (i == 0) error("null Pix");
  return ((FStringcaddr_tSplayNode*)i)->item;
}

inline caddr_t& FStringcaddr_tSplayMap::contents (Pix i)
{
  if (i == 0) error("null Pix");
  return ((FStringcaddr_tSplayNode*)i)->cont;
}

inline void FStringcaddr_tSplayMap::clear()
{
  _kill(root);
  count = 0;
  root = 0;
}

inline int FStringcaddr_tSplayMap::contains(FString& key)
{
  return seek(key) != 0;
}

#endif
