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

#ifdef __GNUG__
#pragma implementation
#endif
//#include <stream.h>
#include "long.longSplaySet.SplayMap.h"
#include <deque>


/* 

 struct to simulate the special `null' node in the Sleater & Tarjan JACM 1985
 splay tree algorithms

 All routines use a version of their `simple top-down' splay alg. (p 669)

*/

/*
 traversal primitives
*/


longlongSplaySetSplayNode* longlongSplaySetSplayMap::leftmost()
{
  longlongSplaySetSplayNode* t = root;
  if (t != 0) while (t->lt != 0) t = t->lt;
  return t;
}

longlongSplaySetSplayNode* longlongSplaySetSplayMap::rightmost()
{
  longlongSplaySetSplayNode* t = root;
  if (t != 0) while (t->rt != 0) t = t->rt;
  return t;
}

longlongSplaySetSplayNode* longlongSplaySetSplayMap::succ(longlongSplaySetSplayNode* t)
{
  if (t == 0)
    return 0;
  if (t->rt != 0)
  {
    t = t->rt;
    while (t->lt != 0) t = t->lt;
    return t;
  }
  else
  {
    for (;;)
    {
      if (t->par == 0 || t == t->par->lt)
        return t->par;
      else
        t = t->par;
    }
  }
}

longlongSplaySetSplayNode* longlongSplaySetSplayMap::pred(longlongSplaySetSplayNode* t)
{
  if (t == 0)
    return 0;
  else if (t->lt != 0)
  {
    t = t->lt;
    while (t->rt != 0) t = t->rt;
    return t;
  }
  else
  {
    for (;;)
    {
      if (t->par == 0 || t == t->par->rt)
        return t->par;
      else
        t = t->par;
    }
  }
}


Pix longlongSplaySetSplayMap::seek(long  key)
{
  longlongSplaySetSplayNode* t = root;
  if (t == 0)
    return 0;

  int comp = longCMP(key, t->item);
  if (comp == 0)
    return Pix(t);

  longlongSplaySetSplayNode* dummy = (longlongSplaySetSplayNode*)(&_dummy_null);
  longlongSplaySetSplayNode* l = dummy;
  longlongSplaySetSplayNode* r = dummy;
  dummy->rt = dummy->lt = dummy->par = 0;

  while (comp != 0)
  {
    if (comp > 0)
    {
      longlongSplaySetSplayNode* tr = t->rt;
      if (tr == 0)
        break;
      else
      {
        comp = longCMP(key, tr->item);
        if (comp <= 0 || tr->rt == 0)
        {
          l->rt = t; t->par = l;
          l = t;
          t = tr;
          if (comp >= 0)
            break;
        }
        else
        {
          if ((t->rt = tr->lt) != 0) t->rt->par = t;
          tr->lt = t; t->par = tr;
          l->rt = tr; tr->par = l;
          l = tr;
          t = tr->rt;
          comp = longCMP(key, t->item);
        }
      }
    }
    else
    {
      longlongSplaySetSplayNode* tl = t->lt;
      if (tl == 0)
        break;
      else
      {
        comp = longCMP(key, tl->item);
        if (comp >= 0 || tl->lt == 0)
        {
          r->lt = t; t->par = r;
          r = t;
          t = tl;
          if (comp <= 0)
            break;
        }
        else
        {
          if ((t->lt = tl->rt) != 0) t->lt->par = t;
          tl->rt = t; t->par = tl;
          r->lt = tl; tl->par = r;
          r = tl;
          t = tl->lt;
          comp = longCMP(key, t->item);
        }
      }
    }
  }
  if ((r->lt = t->rt) != 0) r->lt->par = r;
  if ((l->rt = t->lt) != 0) l->rt->par = l;
  if ((t->lt = dummy->rt) != 0) t->lt->par = t;
  if ((t->rt = dummy->lt) != 0) t->rt->par = t;
  t->par = 0;
  root = t;
  return (comp == 0) ? Pix(t) : 0;
}


longSplaySet& longlongSplaySetSplayMap::operator [] (long  item)
{
  longlongSplaySetSplayNode* t = root;
  if (t == 0)
  {
    ++count;
    root = new longlongSplaySetSplayNode(item, def);
    return root->cont;
  }
  int comp = longCMP(item, t->item);
  if (comp == 0)
    return t->cont;

  longlongSplaySetSplayNode* dummy = (longlongSplaySetSplayNode*)(&_dummy_null);
  longlongSplaySetSplayNode* l = dummy;
  longlongSplaySetSplayNode* r = dummy;
  dummy->rt = dummy->lt = dummy->par = 0;

  while (comp != 0)
  {
    if (comp > 0)
    {
      longlongSplaySetSplayNode* tr = t->rt;
      if (tr == 0)
      {
        ++count;
        tr = new longlongSplaySetSplayNode(item, def);
        comp = 0;
      }
      else
        comp = longCMP(item, tr->item);
        
      if (comp <= 0)
      {
        l->rt = t; t->par = l;
        l = t;
        t = tr;
      }
      else 
      {
        longlongSplaySetSplayNode* trr = tr->rt;
        if (trr == 0)
        {
          ++count;
          trr =  new longlongSplaySetSplayNode(item, def);
          comp = 0;
        }
        else
          comp = longCMP(item, trr->item);

        if ((t->rt = tr->lt) != 0) t->rt->par = t;
        tr->lt = t; t->par = tr;
        l->rt = tr; tr->par = l;
        l = tr;
        t = trr;
      }
    }
    else
    {
      longlongSplaySetSplayNode* tl = t->lt;
      if (tl == 0)
      {
        ++count;
        tl = new longlongSplaySetSplayNode(item, def);
        comp = 0;
      }
      else
        comp = longCMP(item, tl->item);

      if (comp >= 0)
      {
        r->lt = t; t->par = r;
        r = t;
        t = tl;
      }
      else
      {
        longlongSplaySetSplayNode* tll = tl->lt;
        if (tll == 0)
        {
          ++count;
          tll = new longlongSplaySetSplayNode(item, def);
          comp = 0;
        }
        else
          comp = longCMP(item, tll->item);

        if ((t->lt = tl->rt) != 0) t->lt->par = t;
        tl->rt = t; t->par = tl;
        r->lt = tl; tl->par = r;
        r = tl;
        t = tll;
      }
    }
  }
  if ((r->lt = t->rt) != 0) r->lt->par = r;
  if ((l->rt = t->lt) != 0) l->rt->par = l;
  if ((t->lt = dummy->rt) != 0) t->lt->par = t;
  if ((t->rt = dummy->lt) != 0) t->rt->par = t;
  t->par = 0;
  root = t;
  return root->cont;
}

void longlongSplaySetSplayMap::del(long  key)
{
  longlongSplaySetSplayNode* t = (longlongSplaySetSplayNode*)(seek(key));
  if (t == 0) return;

  longlongSplaySetSplayNode* p = t->par;

  --count;
  if (t->rt == 0)
  {
    if (t == root)
    {
      if ((root = t->lt) != 0) root->par = 0;
    }
    else if (t == p->lt)
    {
      if ((p->lt = t->lt) != 0) p->lt->par = p;
    }
    else
      if ((p->rt = t->lt) != 0) p->rt->par = p;
  }
  else
  {
    longlongSplaySetSplayNode* r = t->rt;
    longlongSplaySetSplayNode* l = r->lt;
    for(;;)
    {
      if (l == 0)
      {
        if (t == root)
        {
          root = r;
          r->par = 0;
        }
        else if (t == p->lt) 
        {
          p->lt = r;
          r->par = p;
        }
        else
        {
          p->rt = r;
          r->par = p;
        }
        if ((r->lt = t->lt) != 0) r->lt->par = r;
        break;
      }
      else
      {
        if ((r->lt = l->rt) != 0) r->lt->par = r;
        l->rt = r; r->par = l;
        r = l;
        l = l->lt;
      }
    }
  }
  delete t;
}


void longlongSplaySetSplayMap::_kill(longlongSplaySetSplayNode* t)
{
    if (t != 0) {
	  std::deque<longlongSplaySetSplayNode*> ptrs;
	  ptrs.push_back (t);
	  for (long i = 0; i<ptrs.size (); i++) {
		  longlongSplaySetSplayNode* ati = ptrs [i];
		  if (ati->lt) ptrs.push_back (ati->lt);
		  if (ati->rt) ptrs.push_back (ati->rt);
	  }
	  for (std::deque<longlongSplaySetSplayNode*>::iterator it = ptrs.begin (); it != ptrs.end (); it++) {
		  longlongSplaySetSplayNode* ati = *it;
		  delete ati;
	  }
    }
}


longlongSplaySetSplayNode* longlongSplaySetSplayMap::_copy(longlongSplaySetSplayNode* t)
{
  if (t != 0)
  {
    longlongSplaySetSplayNode* l = _copy(t->lt);
    longlongSplaySetSplayNode* r = _copy(t->rt);
    longlongSplaySetSplayNode* x = new longlongSplaySetSplayNode(t->item, t->cont, l, r);
    if (l != 0) l->par = x;
    if (r != 0) r->par = x;
    return x;
  }
  else 
    return 0;
}


int longlongSplaySetSplayMap::OK()
{
  int v = 1;
  if (root == 0) 
    v = count == 0;
  else
  {
    unsigned int n = 1;
    longlongSplaySetSplayNode* trail = leftmost();
    longlongSplaySetSplayNode* t = succ(trail);
    while (t != 0)
    {
      ++n;
      v &= longCMP(trail->item, t->item) < 0;
      trail = t;
      t = succ(t);
    }
    v &= n == count;
  }
  if (!v) error("invariant failure");
  return v;
}
