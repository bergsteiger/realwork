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
#include "clTreeNode.SplaySet.h"


/* 

 struct to simulate the special `null' node in the Sleater & Tarjan JACM 1985
 splay tree algorithms

 All routines use a version of their `simple top-down' splay alg. (p 669)

*/

/*
 traversal primitives
*/


clTreeNodeSplayNode* clTreeNodeSplaySet::leftmost()
{
  clTreeNodeSplayNode* t = root;
  if (t != 0) while (t->lt != 0) t = t->lt;
  return t;
}

clTreeNodeSplayNode* clTreeNodeSplaySet::rightmost()
{
  clTreeNodeSplayNode* t = root;
  if (t != 0) while (t->rt != 0) t = t->rt;
  return t;
}

clTreeNodeSplayNode* clTreeNodeSplaySet::succ(clTreeNodeSplayNode* t)
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

clTreeNodeSplayNode* clTreeNodeSplaySet::pred(clTreeNodeSplayNode* t)
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


Pix clTreeNodeSplaySet::seek(clTreeNode& key)
{
  clTreeNodeSplayNode* t = root;
  if (t == 0)
    return 0;

  int comp = clTreeNodeCMP(key, t->item);
  if (comp == 0)
    return Pix(t);

  clTreeNodeSplayNode* dummy = (clTreeNodeSplayNode*)(&_dummy_null);
  clTreeNodeSplayNode* l = dummy;
  clTreeNodeSplayNode* r = dummy;
  dummy->rt = dummy->lt = dummy->par = 0;

  while (comp != 0)
  {
    if (comp > 0)
    {
      clTreeNodeSplayNode* tr = t->rt;
      if (tr == 0)
        break;
      else
      {
        comp = clTreeNodeCMP(key, tr->item);
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
          comp = clTreeNodeCMP(key, t->item);
        }
      }
    }
    else
    {
      clTreeNodeSplayNode* tl = t->lt;
      if (tl == 0)
        break;
      else
      {
        comp = clTreeNodeCMP(key, tl->item);
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
          comp = clTreeNodeCMP(key, t->item);
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



Pix clTreeNodeSplaySet::add(clTreeNode& item)
{
  clTreeNodeSplayNode* t = root;
  if (t == 0)
  {
    ++count;
    root = new clTreeNodeSplayNode(item);
    return Pix(root);
  }
  int comp = clTreeNodeCMP(item, t->item);
  if (comp == 0)
    return Pix(t);

  clTreeNodeSplayNode* dummy = (clTreeNodeSplayNode*)(&_dummy_null);
  clTreeNodeSplayNode* l = dummy;
  clTreeNodeSplayNode* r = dummy;
  dummy->rt = dummy->lt = dummy->par = 0;

  while (comp != 0)
  {
    if (comp > 0)
    {
      clTreeNodeSplayNode* tr = t->rt;
      if (tr == 0)
      {
        ++count;
        tr = new clTreeNodeSplayNode(item);
        comp = 0;
      }
      else
        comp = clTreeNodeCMP(item, tr->item);
        
      if (comp <= 0)
      {
        l->rt = t; t->par = l;
        l = t;
        t = tr;
      }
      else 
      {
        clTreeNodeSplayNode* trr = tr->rt;
        if (trr == 0)
        {
          ++count;
          trr =  new clTreeNodeSplayNode(item);
          comp = 0;
        }
        else
          comp = clTreeNodeCMP(item, trr->item);

        if ((t->rt = tr->lt) != 0) t->rt->par = t;
        tr->lt = t; t->par = tr;
        l->rt = tr; tr->par = l;
        l = tr;
        t = trr;
      }
    }
    else
    {
      clTreeNodeSplayNode* tl = t->lt;
      if (tl == 0)
      {
        ++count;
        tl = new clTreeNodeSplayNode(item);
        comp = 0;
      }
      else
        comp = clTreeNodeCMP(item, tl->item);

      if (comp >= 0)
      {
        r->lt = t; t->par = r;
        r = t;
        t = tl;
      }
      else
      {
        clTreeNodeSplayNode* tll = tl->lt;
        if (tll == 0)
        {
          ++count;
          tll = new clTreeNodeSplayNode(item);
          comp = 0;
        }
        else
          comp = clTreeNodeCMP(item, tll->item);

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

void clTreeNodeSplaySet::del(clTreeNode& key)
{
  clTreeNodeSplayNode* t = (clTreeNodeSplayNode*)(seek(key));
  if (t == 0) return;

  clTreeNodeSplayNode* p = t->par;

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
    clTreeNodeSplayNode* r = t->rt;
    clTreeNodeSplayNode* l = r->lt;
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


void clTreeNodeSplaySet::_kill(clTreeNodeSplayNode* t)
{
  if (t != 0)
  {
    _kill(t->lt);
    _kill(t->rt);
    delete t;
  }
}


clTreeNodeSplayNode* clTreeNodeSplaySet::_copy(clTreeNodeSplayNode* t)
{
  if (t != 0)
  {
    clTreeNodeSplayNode* l = _copy(t->lt);
    clTreeNodeSplayNode* r = _copy(t->rt);
    clTreeNodeSplayNode* x = new clTreeNodeSplayNode(t->item, l, r);
    if (l != 0) l->par = x;
    if (r != 0) r->par = x;
    return x;
  }
  else 
    return 0;
}

/* relationals */

int clTreeNodeSplaySet::operator == (clTreeNodeSplaySet& y)
{
  if (count != y.count)
    return 0;
  else
  {
    clTreeNodeSplayNode* t = leftmost();
    clTreeNodeSplayNode* u = y.leftmost();
    for (;;)
    {
      if (t == 0)
        return 1;
      else if (!clTreeNodeEQ(t->item, u->item))
        return 0;
      else
      {
        t = succ(t);
        u = y.succ(u);
      }
    }
  }
}

int clTreeNodeSplaySet::operator <= (clTreeNodeSplaySet& y)
{
  if (count > y.count)
    return 0;
  else
  {
    clTreeNodeSplayNode* t = leftmost();
    clTreeNodeSplayNode* u = y.leftmost();
    for (;;)
    {
      if (t == 0)
        return 1;
      else if (u == 0)
        return 0;
      int cmp = clTreeNodeCMP(t->item, u->item);
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


void clTreeNodeSplaySet::operator |=(clTreeNodeSplaySet& y)
{
  if (&y == this) return;
  clTreeNodeSplayNode* u = y.leftmost();
  while (u != 0)
  {
    add(u->item);
    u = y.succ(u);
  }
}

void clTreeNodeSplaySet::operator &= (clTreeNodeSplaySet& y)
{
  if (y.count == 0)
    clear();
  else if (&y != this && count != 0)
  {
    clTreeNodeSplayNode* t = leftmost();
    while (t != 0)
    {
      clTreeNodeSplayNode* s = succ(t);
      if (y.seek(t->item) == 0) del(t->item);
      t = s;
    }
  }
}


void clTreeNodeSplaySet::operator -=(clTreeNodeSplaySet& y)
{
  if (&y == this)
    clear();
  else if (y.count != 0)
  {
    clTreeNodeSplayNode* t = leftmost();
    while (t != 0)
    {
      clTreeNodeSplayNode* s = succ(t);
      if (y.seek(t->item) != 0) del(t->item);
      t = s;
    }
  }
}

int clTreeNodeSplaySet::OK()
{
  int v = 1;
  if (root == 0) 
    v = count == 0;
  else
  {
    unsigned int n = 1;
    clTreeNodeSplayNode* trail = leftmost();
    clTreeNodeSplayNode* t = succ(trail);
    while (t != 0)
    {
      ++n;
      v &= clTreeNodeCMP(trail->item, t->item) < 0;
      trail = t;
      t = succ(t);
    }
    v &= n == count;
  }
  if (!v) error("invariant failure");
  return v;
}
