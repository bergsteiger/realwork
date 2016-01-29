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
#include "long.SplaySet.h"
#include <deque>

/* 

 struct to simulate the special `null' node in the Sleater & Tarjan JACM 1985
 splay tree algorithms

 All routines use a version of their `simple top-down' splay alg. (p 669)

*/

// #define _dummy_null _dummy_null_longSplayNode

/*
 traversal primitives
*/


longSplayNode* longSplaySet::leftmost()
{
  longSplayNode* t = root;
  if (t != 0) while (t->lt != 0) t = t->lt;
  return t;
}

longSplayNode* longSplaySet::rightmost()
{
  longSplayNode* t = root;
  if (t != 0) while (t->rt != 0) t = t->rt;
  return t;
}

longSplayNode* longSplaySet::succ(longSplayNode* t)
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

longSplayNode* longSplaySet::pred(longSplayNode* t)
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


Pix longSplaySet::seek(long  key)
{
  longSplayNode* t = root;
  if (t == 0)
    return 0;

  int comp = longCMP(key, t->item);
  if (comp == 0)
    return Pix(t);

  longSplayNode* dummy = (longSplayNode*)(&_dummy_null);
  longSplayNode* l = dummy;
  longSplayNode* r = dummy;
  dummy->rt = dummy->lt = dummy->par = 0;

  while (comp != 0)
  {
    if (comp > 0)
    {
      longSplayNode* tr = t->rt;
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
      longSplayNode* tl = t->lt;
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



Pix longSplaySet::add(long  item)
{
  longSplayNode* t = root;
  if (t == 0)
  {
    ++count;
    root = new longSplayNode(item);
    return Pix(root);
  }
  int comp = longCMP(item, t->item);
  if (comp == 0)
    return Pix(t);

  longSplayNode* dummy = (longSplayNode*)(&_dummy_null);
  longSplayNode* l = dummy;
  longSplayNode* r = dummy;
  dummy->rt = dummy->lt = dummy->par = 0;

  while (comp != 0)
  {
    if (comp > 0)
    {
      longSplayNode* tr = t->rt;
      if (tr == 0)
      {
        ++count;
        tr = new longSplayNode(item);
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
        longSplayNode* trr = tr->rt;
        if (trr == 0)
        {
          ++count;
          trr =  new longSplayNode(item);
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
      longSplayNode* tl = t->lt;
      if (tl == 0)
      {
        ++count;
        tl = new longSplayNode(item);
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
        longSplayNode* tll = tl->lt;
        if (tll == 0)
        {
          ++count;
          tll = new longSplayNode(item);
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
  return Pix(root);
}

void longSplaySet::del(long  key)
{
  longSplayNode* t = (longSplayNode*)(seek(key));
  if (t == 0) return;

  longSplayNode* p = t->par;

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
    longSplayNode* r = t->rt;
    longSplayNode* l = r->lt;
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


void longSplaySet::_kill(longSplayNode* t)
{
    if (t != 0) {
	  std::deque<longSplayNode*> ptrs;
	  ptrs.push_back (t);
	  for (long i = 0; i<ptrs.size (); i++) {
		  longSplayNode* ati = ptrs [i];
		  if (ati->lt) ptrs.push_back (ati->lt);
		  if (ati->rt) ptrs.push_back (ati->rt);
	  }
	  for (std::deque<longSplayNode*>::iterator it = ptrs.begin (); it != ptrs.end (); it++) {
		  longSplayNode* ati = *it;
		  delete ati;
	  }
    }
}


longSplayNode* longSplaySet::_copy(longSplayNode* t)
{
  if (t != 0)
  {
    longSplayNode* l = _copy(t->lt);
    longSplayNode* r = _copy(t->rt);
    longSplayNode* x = new longSplayNode(t->item, l, r);
    if (l != 0) l->par = x;
    if (r != 0) r->par = x;
    return x;
  }
  else 
    return 0;
}

/* relationals */

int longSplaySet::operator == (longSplaySet& y)
{
  if (count != y.count)
    return 0;
  else
  {
    longSplayNode* t = leftmost();
    longSplayNode* u = y.leftmost();
    for (;;)
    {
      if (t == 0)
        return 1;
      else if (!longEQ(t->item, u->item))
        return 0;
      else
      {
        t = succ(t);
        u = y.succ(u);
      }
    }
  }
}

int longSplaySet::operator <= (longSplaySet& y)
{
  if (count > y.count)
    return 0;
  else
  {
    longSplayNode* t = leftmost();
    longSplayNode* u = y.leftmost();
    for (;;)
    {
      if (t == 0)
        return 1;
      else if (u == 0)
        return 0;
      int cmp = longCMP(t->item, u->item);
      if (cmp == 0)
      {
        t = succ(t);
        u = y.succ(u);
      }
      else if (cmp < 0)
        return 0;
      else
        u = y.succ(u);
    }
  }
}


void longSplaySet::operator |=(longSplaySet& y)
{
  if (&y == this) return;
  longSplayNode* u = y.leftmost();
  while (u != 0)
  {
    add(u->item);
    u = y.succ(u);
  }
}

void longSplaySet::operator &= (longSplaySet& y)
{
  if (y.count == 0)
    clear();
  else if (&y != this && count != 0)
  {
    longSplayNode* t = leftmost();
    while (t != 0)
    {
      longSplayNode* s = succ(t);
      if (y.seek(t->item) == 0) del(t->item);
      t = s;
    }
  }
}

int longSplaySet::operator & (longSplaySet& y)
{
  if (y.count == 0 || count == 0)
    return 0;
  if (&y == this) return 1;

  longSplayNode* t = leftmost();
  while (t != 0)
  {
      longSplayNode* s = succ(t);
      if (y.seek(t->item) != 0) return 1;
      t = s;
  }
  return 0;
}


void longSplaySet::operator -=(longSplaySet& y)
{
  if (&y == this)
    clear();
  else if (y.count != 0)
  {
    longSplayNode* t = leftmost();
    while (t != 0)
    {
      longSplayNode* s = succ(t);
      if (y.seek(t->item) != 0) del(t->item);
      t = s;
    }
  }
}

int longSplaySet::OK()
{
  int v = 1;
  if (root == 0) 
    v = count == 0;
  else
  {
    unsigned int n = 1;
    longSplayNode* trail = leftmost();
    longSplayNode* t = succ(trail);
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
