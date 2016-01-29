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


#ifndef _FStringFStringSplayMap_h
#ifdef __GNUG__
#pragma interface
#endif
#define _FStringFStringSplayMap_h 1

#include "FString.FString.Map.h"

#ifndef _FStringFStringSplayNode
#define _FStringFStringSplayNode 1

struct FStringFStringSplayNode
{
  FStringFStringSplayNode*   lt;
  FStringFStringSplayNode*   rt;
  FStringFStringSplayNode*   par;
  FString                item;
  FString                cont;
                     FStringFStringSplayNode(FString& h, FString& c, 
                                     FStringFStringSplayNode* l=0, 
                                     FStringFStringSplayNode* r=0);
                  ~FStringFStringSplayNode();
};


inline FStringFStringSplayNode::FStringFStringSplayNode(FString& h, FString& c, 
                                        FStringFStringSplayNode* l, 
                                        FStringFStringSplayNode* r)
     :lt(l), rt(r), par(0), item(h), cont(c)  {}

inline FStringFStringSplayNode::~FStringFStringSplayNode() {}

typedef FStringFStringSplayNode* FStringFStringSplayNodePtr;

#endif

class FStringFStringSplayMap : public FStringFStringMap
{
protected:
  FStringFStringSplayNode*   root;

  FStringFStringSplayNode*   leftmost();
  FStringFStringSplayNode*   rightmost();
  FStringFStringSplayNode*   pred(FStringFStringSplayNode* t);
  FStringFStringSplayNode*   succ(FStringFStringSplayNode* t);
  void               _kill(FStringFStringSplayNode* t);
  FStringFStringSplayNode*   _copy(FStringFStringSplayNode* t);

	struct _dummySplayNode
	{
	  FStringFStringSplayNode*    lt;
	  FStringFStringSplayNode*    rt;
	  FStringFStringSplayNode*    par;
	} _dummy_null;
public:
               FStringFStringSplayMap(FString& dflt);
               FStringFStringSplayMap(FStringFStringSplayMap& a);
  inline              ~FStringFStringSplayMap();

  FString&          operator [] (FString& key);

  void          del(FString& key);

  inline Pix           first();
  inline void          next(Pix& i);
  inline FString&          key(Pix i);
  inline FString&          contents(Pix i);

  Pix           seek(FString& key);
  inline int           contains(FString& key);

  inline void          clear(); 

  Pix           last();
  void          prev(Pix& i);

  int           OK();
};


inline FStringFStringSplayMap::~FStringFStringSplayMap()
{
  _kill(root);
}

inline FStringFStringSplayMap::FStringFStringSplayMap(FString& dflt) :FStringFStringMap(dflt)
{
  root = 0;
}

inline FStringFStringSplayMap::FStringFStringSplayMap(FStringFStringSplayMap& b) :FStringFStringMap(b.def)
{
  count = b.count;
  root = _copy(b.root);
}

inline Pix FStringFStringSplayMap::first()
{
  return Pix(leftmost());
}

inline Pix FStringFStringSplayMap::last()
{
  return Pix(rightmost());
}

inline void FStringFStringSplayMap::next(Pix& i)
{
  if (i != 0) i = Pix(succ((FStringFStringSplayNode*)i));
}

inline void FStringFStringSplayMap::prev(Pix& i)
{
  if (i != 0) i = Pix(pred((FStringFStringSplayNode*)i));
}

inline FString& FStringFStringSplayMap::key (Pix i)
{
  if (i == 0) error("null Pix");
  return ((FStringFStringSplayNode*)i)->item;
}

inline FString& FStringFStringSplayMap::contents (Pix i)
{
  if (i == 0) error("null Pix");
  return ((FStringFStringSplayNode*)i)->cont;
}

inline void FStringFStringSplayMap::clear()
{
  _kill(root);
  count = 0;
  root = 0;
}

inline int FStringFStringSplayMap::contains(FString& key)
{
  return seek(key) != 0;
}

#endif
