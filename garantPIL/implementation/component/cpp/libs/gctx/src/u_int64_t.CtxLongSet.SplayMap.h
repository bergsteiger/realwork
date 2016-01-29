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


#ifndef _u_int64_tCtxLongSetSplayMap_h
#ifdef __GNUG__
#pragma interface
#endif
#define _u_int64_tCtxLongSetSplayMap_h 1

#include "u_int64_t.CtxLongSet.Map.h"

#ifndef _u_int64_tCtxLongSetSplayNode
#define _u_int64_tCtxLongSetSplayNode 1

struct u_int64_tCtxLongSetSplayNode
{
  u_int64_tCtxLongSetSplayNode*   lt;
  u_int64_tCtxLongSetSplayNode*   rt;
  u_int64_tCtxLongSetSplayNode*   par;
  CtxLongSet                cont;
         u_int64_tCtxLongSetSplayNode(u_int64_t  h, CtxLongSet& c, 
                         u_int64_tCtxLongSetSplayNode* l=0, 
                         u_int64_tCtxLongSetSplayNode* r=0);
         u_int64_tCtxLongSetSplayNode(CtxLongSet& c, 
                         u_int64_tCtxLongSetSplayNode* l=0, 
                         u_int64_tCtxLongSetSplayNode* r=0);
         u_int64_tCtxLongSetSplayNode();
      ~u_int64_tCtxLongSetSplayNode();
  char curr_item[32];
};


inline u_int64_tCtxLongSetSplayNode::u_int64_tCtxLongSetSplayNode(u_int64_t  h, CtxLongSet& c, 
                                        u_int64_tCtxLongSetSplayNode* l, 
                                        u_int64_tCtxLongSetSplayNode* r)
     :lt(l), rt(r), par(0), cont(c)  {}
inline u_int64_tCtxLongSetSplayNode::u_int64_tCtxLongSetSplayNode(CtxLongSet& c, 
                                        u_int64_tCtxLongSetSplayNode* l, 
                                        u_int64_tCtxLongSetSplayNode* r)
     :lt(l), rt(r), par(0), cont(c)  {}

inline u_int64_tCtxLongSetSplayNode::u_int64_tCtxLongSetSplayNode(){}

inline u_int64_tCtxLongSetSplayNode::~u_int64_tCtxLongSetSplayNode() {}

typedef u_int64_tCtxLongSetSplayNode* u_int64_tCtxLongSetSplayNodePtr;

#endif

class u_int64_tCtxLongSetSplayMap : public u_int64_tCtxLongSetMap
{
protected:
  u_int64_tCtxLongSetSplayNode*   leftmost();
  u_int64_tCtxLongSetSplayNode*   rightmost();
  u_int64_tCtxLongSetSplayNode*   pred(u_int64_tCtxLongSetSplayNode* t);
  u_int64_tCtxLongSetSplayNode*   succ(u_int64_tCtxLongSetSplayNode* t);
  void               _kill(u_int64_tCtxLongSetSplayNode* t);
  u_int64_tCtxLongSetSplayNode*   _copy(u_int64_tCtxLongSetSplayNode* t);

	struct _dummySplayNode
	{
	  u_int64_tCtxLongSetSplayNode*    lt;
	  u_int64_tCtxLongSetSplayNode*    rt;
	  u_int64_tCtxLongSetSplayNode*    par;
	} _dummy_null;

public:
  u_int64_tCtxLongSetSplayNode**	m_pp_ForNew;
   u_int64_tCtxLongSetSplayNode*		root;
   u_int64_tCtxLongSetSplayMap(CtxLongSet& dflt,
								u_int64_tCtxLongSetSplayNode **pp_ForNew= 0);
   u_int64_tCtxLongSetSplayMap(u_int64_tCtxLongSetSplayMap& a);
  inline              ~u_int64_tCtxLongSetSplayMap();

  CtxLongSet&          operator [] (u_int64_t  key);
  CtxLongSet&          operator [] (void *pkey);

  void          del(u_int64_t  key);

  inline Pix           first();
  inline void          next(Pix& i);
  inline u_int64_t&			key(Pix i);
  void *					pkey (Pix i);
  inline CtxLongSet&          contents(Pix i);

  Pix           seek(u_int64_t  key);
  Pix           seek(void *pFndkey);
  inline int           contains(u_int64_t  key);

  inline void          clear(); 

  Pix           last();
  void          prev(Pix& i);

  int           OK();

  virtual int comp_items(void *pFirst, void*pSecond);
  virtual void SetItemInNode(void *pOldItem, void *pNewItem);
};


inline u_int64_tCtxLongSetSplayMap::~u_int64_tCtxLongSetSplayMap()
{
	if(!m_pp_ForNew)
		_kill(root);
}

inline u_int64_tCtxLongSetSplayMap::u_int64_tCtxLongSetSplayMap(CtxLongSet& dflt,
								u_int64_tCtxLongSetSplayNode **pp_ForNew) : u_int64_tCtxLongSetMap(dflt)
{
  if(pp_ForNew)
	  m_pp_ForNew= pp_ForNew;
  else
	  m_pp_ForNew= 0;
  root = 0;
}

inline u_int64_tCtxLongSetSplayMap::u_int64_tCtxLongSetSplayMap(u_int64_tCtxLongSetSplayMap& b) :u_int64_tCtxLongSetMap(b.def)
{
  count = b.count;
  root = _copy(b.root);
}

inline Pix u_int64_tCtxLongSetSplayMap::first()
{
  return Pix(leftmost());
}

inline Pix u_int64_tCtxLongSetSplayMap::last()
{
  return Pix(rightmost());
}

inline void u_int64_tCtxLongSetSplayMap::next(Pix& i)
{
  if (i != 0) i = Pix(succ((u_int64_tCtxLongSetSplayNode*)i));
}

inline void u_int64_tCtxLongSetSplayMap::prev(Pix& i)
{
  if (i != 0) i = Pix(pred((u_int64_tCtxLongSetSplayNode*)i));
}


inline u_int64_t& u_int64_tCtxLongSetSplayMap::key (Pix i)
{
  if (i == 0) error("null Pix");
  return *(u_int64_t*)(((u_int64_tCtxLongSetSplayNode*)i)->curr_item);
}

inline void *u_int64_tCtxLongSetSplayMap::pkey (Pix i)
{
  if (i == 0) error("null Pix");
  return (((u_int64_tCtxLongSetSplayNode*)i)->curr_item);
}

inline CtxLongSet& u_int64_tCtxLongSetSplayMap::contents (Pix i)
{
  if (i == 0) error("null Pix");
  return ((u_int64_tCtxLongSetSplayNode*)i)->cont;
}

inline void u_int64_tCtxLongSetSplayMap::clear()
{
  if(!m_pp_ForNew)
	_kill(root);
  count = 0;
  root = 0;
}

inline int u_int64_tCtxLongSetSplayMap::contains(u_int64_t  key)
{
  return seek(key) != 0;
}

#endif
