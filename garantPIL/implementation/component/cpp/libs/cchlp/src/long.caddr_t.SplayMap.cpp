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
#include "long.caddr_t.SplayMap.h"


/* 

 struct to simulate the special `null' node in the Sleater & Tarjan JACM 1985
 splay tree algorithms

 All routines use a version of their `simple top-down' splay alg. (p 669)

*/

/*
 traversal primitives
*/


longcaddr_tSplayNode* longcaddr_tSplayMap::leftmost()
{
  longcaddr_tSplayNode* t = root;
  if (t != 0) while (t->lt != 0) t = t->lt;
  return t;
}

longcaddr_tSplayNode* longcaddr_tSplayMap::rightmost()
{
  longcaddr_tSplayNode* t = root;
  if (t != 0) while (t->rt != 0) t = t->rt;
  return t;
}

longcaddr_tSplayNode* longcaddr_tSplayMap::succ(longcaddr_tSplayNode* t)
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

longcaddr_tSplayNode* longcaddr_tSplayMap::pred(longcaddr_tSplayNode* t)
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


Pix longcaddr_tSplayMap::seek(long  key)
{
  longcaddr_tSplayNode* t = root;
  if (t == 0)
    return 0;

  int comp = longCMP(key, t->item);
  if (comp == 0)
    return Pix(t);

  longcaddr_tSplayNode* dummy = (longcaddr_tSplayNode*)(&_dummy_null);
  longcaddr_tSplayNode* l = dummy;
  longcaddr_tSplayNode* r = dummy;
  dummy->rt = dummy->lt = dummy->par = 0;

  while (comp != 0)
  {
    if (comp > 0)
    {
      longcaddr_tSplayNode* tr = t->rt;
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
      longcaddr_tSplayNode* tl = t->lt;
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


caddr_t& longcaddr_tSplayMap::operator [] (long  item)
{
  longcaddr_tSplayNode* t = root;
  if (t == 0)
  {
    ++count;
    root = new longcaddr_tSplayNode(item, def);
    return root->cont;
  }
  int comp = longCMP(item, t->item);
  if (comp == 0)
    return t->cont;

  longcaddr_tSplayNode* dummy = (longcaddr_tSplayNode*)(&_dummy_null);
  longcaddr_tSplayNode* l = dummy;
  longcaddr_tSplayNode* r = dummy;
  dummy->rt = dummy->lt = dummy->par = 0;

  while (comp != 0)
  {
    if (comp > 0)
    {
      longcaddr_tSplayNode* tr = t->rt;
      if (tr == 0)
      {
        ++count;
        tr = new longcaddr_tSplayNode(item, def);
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
        longcaddr_tSplayNode* trr = tr->rt;
        if (trr == 0)
        {
          ++count;
          trr =  new longcaddr_tSplayNode(item, def);
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
      longcaddr_tSplayNode* tl = t->lt;
      if (tl == 0)
      {
        ++count;
        tl = new longcaddr_tSplayNode(item, def);
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
        longcaddr_tSplayNode* tll = tl->lt;
        if (tll == 0)
        {
          ++count;
          tll = new longcaddr_tSplayNode(item, def);
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

void longcaddr_tSplayMap::del(long  key)
{
  longcaddr_tSplayNode* t = (longcaddr_tSplayNode*)(seek(key));
  if (t == 0) return;

  longcaddr_tSplayNode* p = t->par;

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
    longcaddr_tSplayNode* r = t->rt;
    longcaddr_tSplayNode* l = r->lt;
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


void longcaddr_tSplayMap::_kill(longcaddr_tSplayNode* t)
{
  if (t != 0)
  {
    _kill(t->lt);
    _kill(t->rt);
    delete t;
  }
}


longcaddr_tSplayNode* longcaddr_tSplayMap::_copy(longcaddr_tSplayNode* t)
{
  if (t != 0)
  {
    longcaddr_tSplayNode* l = _copy(t->lt);
    longcaddr_tSplayNode* r = _copy(t->rt);
    longcaddr_tSplayNode* x = new longcaddr_tSplayNode(t->item, t->cont, l, r);
    if (l != 0) l->par = x;
    if (r != 0) r->par = x;
    return x;
  }
  else 
    return 0;
}


int longcaddr_tSplayMap::OK()
{
  int v = 1;
  if (root == 0) 
    v = count == 0;
  else
  {
    unsigned int n = 1;
    longcaddr_tSplayNode* trail = leftmost();
    longcaddr_tSplayNode* t = succ(trail);
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
