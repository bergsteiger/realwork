/*
 * $Id: SplayMap.h,v 1.9 2006/08/08 08:11:32 vlad Exp $
 */

#ifndef _SplayMap_h
#define _SplayMap_h 1

#include <stdlib.h>
#include "Map.h"

template <class Key, class Data>
class SplayMap: public Map<Key, Data>
{
protected:
	struct SplayNode
	{
		SplayNode* lt;
		SplayNode* rt;
		SplayNode* par;
		Key item;
		Data cont;
		SplayNode(Key  h, Data& c, SplayNode* l=0, SplayNode* r=0)
			:lt(l), rt(r), par(0), item(h), cont(c)  {};
		~SplayNode() {};
	};
	struct _dummySplayNode
	{
		SplayNode* lt;
		SplayNode* rt;
		SplayNode* par;
	} _dummy_null;

protected:
	SplayNode* root;

	SplayNode* leftmost();
	SplayNode* rightmost();
	SplayNode* pred(SplayNode* t);
	SplayNode* succ(SplayNode* t);
	void _kill(SplayNode* t);
	void _l_kill(SplayNode* t);
	void _r_kill(SplayNode* t);
	SplayNode* _copy(SplayNode* t);

public:
	SplayMap() : root(0) {}
	SplayMap(Data dflt) : Map<Key,Data>(dflt), root(0) {}
	SplayMap(const SplayMap& a) : Map<Key,Data>(a.def) {
		this->count = a.count; // GARANT_GCC
		root = _copy(a.root);
	}
	inline ~SplayMap() {
		_kill(root);
	}
	inline SplayMap<Key,Data>& operator = (const SplayMap& b)
	{
		if (this != &b)
		{
			_kill (root);
			this->count = b.count; // GARANT_GCC
			root = _copy (b.root);

			this->def = b.def; // GARANT_GCC
		}
		return *this;
	}	
	Data& operator [] (Key  key);
	Data& get (Key  key);
	Data* get_ptr (Key  key);
	int add (Key  key, Data& data);
	void del(Key  key);
	void del(Point i);
	Point seek(Key  key);

	inline Point first() {
		return (Point)leftmost();
	}
	inline void next(Point& i) {
		if (i != 0) i = (Point)(succ((SplayNode*)i));
	}
	inline Key& key(Point i) {
		if (i == 0) this->error("null Point"); // GARANT_GCC
		return ((SplayNode*)i)->item;
	}
	inline Data& contents(Point i) {
		if (i == 0) this->error("null Point"); // GARANT_THIS
		return ((SplayNode*)i)->cont;
	}	
	inline int contains(const Key  key) { // GARANT_MSVC7 const qualifier ommited
		return seek(key) != 0;
	}
	inline void clear() {
		_kill(root);
		this->count = 0; // GARANT_GCC
		root = 0;
	}	
	Point last() {
		return (Point)(rightmost());
	}
	void prev(Point& i) {
		if (i != 0) i = (Point)(pred((SplayNode*)i));
	}
	int OK();
};


template <class Key, class Data>
int SplayMap<Key,Data>::OK()
{
  int v = 1;
  if (root == 0) 
    v = (this->count == 0); // GARANT_GCC
  else
  {
    unsigned int n = 1;
    SplayNode* trail = leftmost();
    SplayNode* t = succ(trail);
    while (t != 0)
    {
      ++n;
      v &= (trail->item < t->item);
      trail = t;
      t = succ(t);
    }
    v &= (n == this->count); // GARANT_GCC
  }
  if (!v) this->error("invariant failure"); // GARANT_GCC
  return v;
}

template <class Key, class Data>
Point SplayMap<Key,Data>::seek(Key  key)
{
  SplayNode* t = root;
  if (t == 0)
    return 0;

  int comp = KeyCmp ( key, t->item );
  
  if (comp == 0)
    return (Point)(t);

  SplayNode* dummy = (SplayNode*)(&_dummy_null);
  SplayNode* l = dummy;
  SplayNode* r = dummy;
  dummy->rt = dummy->lt = dummy->par = 0;

  while (comp != 0)
  {
    if (comp > 0)
    {
      SplayNode* tr = t->rt;
      if (tr == 0)
        break;
      else
      {
        comp = KeyCmp(key, tr->item);
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
          comp = KeyCmp(key, t->item);
        }
      }
    }
    else
    {
      SplayNode* tl = t->lt;
      if (tl == 0)
        break;
      else
      {
        comp = KeyCmp(key, tl->item);
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
          comp = KeyCmp(key, t->item);
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
  return (comp == 0) ? (Point)(t) : 0;
}

template <class Key, class Data>
void SplayMap<Key,Data>::del(Key key)
{
  del(seek(key));
}

template <class Key, class Data>
void SplayMap<Key,Data>::del(Point i)
{
  SplayNode* t = (SplayNode*)(i);
  if (t == 0) return;

  SplayNode* p = t->par;

  --this->count; // GARANT_GCC
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
    SplayNode* r = t->rt;
    SplayNode* l = r->lt;
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

template <class Key, class Data>
Data& SplayMap<Key,Data>::operator [] (Key  item)
{
	return get ( item );
}

template <class Key, class Data>
Data* SplayMap<Key,Data>::get_ptr (Key  item)
{
  Point i = seek(item);
  if (i)
	return &((SplayNode*)i)->cont;
  else
    return &this->def;
}

template <class Key, class Data>
Data& SplayMap<Key,Data>::get (Key  item)
{
  SplayNode* t = root;
  if (t == 0)
  {
    ++this->count; // GARANT_GCC
    root = new SplayNode(item, this->def); // GARANT_GCC
    return root->cont;
  }
  int comp = KeyCmp(item, t->item);
  if (comp == 0)
    return t->cont;

  SplayNode* dummy = (SplayNode*)(&_dummy_null);
  SplayNode* l = dummy;
  SplayNode* r = dummy;
  dummy->rt = dummy->lt = dummy->par = 0;

  while (comp != 0)
  {
    if (comp > 0)
    {
      SplayNode* tr = t->rt;
      if (tr == 0)
      {
        ++this->count; // GARANT_GCC
        tr = new SplayNode(item, this->def); // GARANT_GCC
        comp = 0;
      }
      else
        comp = KeyCmp(item, tr->item);
        
      if (comp <= 0)
      {
        l->rt = t; t->par = l;
        l = t;
        t = tr;
      }
      else 
      {
        SplayNode* trr = tr->rt;
        if (trr == 0)
        {
          ++this->count;
          trr =  new SplayNode(item, this->def);
          comp = 0;
        }
        else
          comp = KeyCmp(item, trr->item);

        if ((t->rt = tr->lt) != 0) t->rt->par = t;
        tr->lt = t; t->par = tr;
        l->rt = tr; tr->par = l;
        l = tr;
        t = trr;
      }
    }
    else
    {
      SplayNode* tl = t->lt;
      if (tl == 0)
      {
        ++this->count;
        tl = new SplayNode(item, this->def);
        comp = 0;
      }
      else
        comp = KeyCmp(item, tl->item);

      if (comp >= 0)
      {
        r->lt = t; t->par = r;
        r = t;
        t = tl;
      }
      else
      {
        SplayNode* tll = tl->lt;
        if (tll == 0)
        {
          ++this->count;
          tll = new SplayNode(item, this->def);
          comp = 0;
        }
        else
          comp = KeyCmp(item, tll->item);

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

template <class Key, class Data>
int SplayMap<Key,Data>::add (Key  item, Data& data )
{
  SplayNode* t = root;
  if (t == 0)
  {
    ++this->count; // GARANT_GCC
    root = new SplayNode(item, data);
    return 1;
  }
  int comp = KeyCmp(item, t->item);
  if (comp == 0)
    return 0;

  SplayNode* dummy = (SplayNode*)(&_dummy_null);
  SplayNode* l = dummy;
  SplayNode* r = dummy;
  dummy->rt = dummy->lt = dummy->par = 0;

  int ret = 0;
  while (comp != 0)
  {
    if (comp > 0)
    {
      SplayNode* tr = t->rt;
      if (tr == 0)
      {
        ++this->count; // GARANT_GCC
        tr = new SplayNode(item, data);
        comp = 0;
		ret = 1;
      }
      else
        comp = KeyCmp(item, tr->item);
        
      if (comp <= 0)
      {
        l->rt = t; t->par = l;
        l = t;
        t = tr;
      }
      else 
      {
        SplayNode* trr = tr->rt;
        if (trr == 0)
        {
          ++this->count;
          trr =  new SplayNode(item, data);
          comp = 0;
		  ret = 1;
        }
        else
          comp = KeyCmp(item, trr->item);

        if ((t->rt = tr->lt) != 0) t->rt->par = t;
        tr->lt = t; t->par = tr;
        l->rt = tr; tr->par = l;
        l = tr;
        t = trr;
      }
    }
    else
    {
      SplayNode* tl = t->lt;
      if (tl == 0)
      {
        ++this->count;
        tl = new SplayNode(item, data);
        comp = 0;
		ret = 1;
      }
      else
        comp = KeyCmp(item, tl->item);

      if (comp >= 0)
      {
        r->lt = t; t->par = r;
        r = t;
        t = tl;
      }
      else
      {
        SplayNode* tll = tl->lt;
        if (tll == 0)
        {
          ++this->count;
          tll = new SplayNode(item, data);
          comp = 0;
		  ret = 1;
        }
        else
          comp = KeyCmp(item, tll->item);

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
  return ret;
}

////////////////////////////////////////////////////////


template <class Key, class Data>
void SplayMap<Key,Data>::_l_kill(SplayNode* t)
{
	if (t != 0) {
		SplayNode* lend=t;
		t = lend->par;

		if (lend != 0) while (lend->lt != 0) 
			lend = lend->lt;		
	
		while (lend && lend != t) {
			SplayNode* par = lend->par;
			if (par) par->lt = 0;

			if ( lend->rt ) {
				if ( lend->rt->lt ) _l_kill(lend->rt);
				else _r_kill(lend->rt);
			}

			delete lend;
			lend = par;
		}
	}
}

template <class Key, class Data>
void SplayMap<Key,Data>::_r_kill(SplayNode* t)
{
	if (t != 0) {		
		SplayNode* rend=t;
		t = rend->par;

		if (rend != 0) while (rend->rt != 0) 
			rend = rend->rt;		
	
		while (rend && rend != t) {
			SplayNode* par = rend->par;
			if (par) par->rt = 0;
			
			if ( rend->lt ) {
				if ( rend->lt->rt ) _r_kill(rend->lt);
				else _l_kill(rend->lt);
			}

			delete rend;
			rend = par;
		}
	}
}

template <class Key, class Data>
void SplayMap<Key,Data>::_kill(SplayNode* t)
{
  if (t != 0)
  {
    if (t->lt) _l_kill(t);
    else _r_kill(t);
  }
}

template <class Key, class Data>
typename SplayMap<Key,Data>::SplayNode* SplayMap<Key,Data>::leftmost() // GARANT_GCC
{
  SplayNode* t = root;
  if (t != 0) while (t->lt != 0) t = t->lt;
  return t;
}

template <class Key, class Data>
typename SplayMap<Key,Data>::SplayNode* SplayMap<Key,Data>::succ(SplayNode* t) // GARANT_GCC
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

template <class Key, class Data>
typename SplayMap<Key,Data>::SplayNode* SplayMap<Key,Data>::rightmost() // GARANT_GCC
{
  SplayNode* t = root;
  if (t != 0) while (t->rt != 0) t = t->rt;
  return t;
}


template <class Key, class Data>
typename SplayMap<Key,Data>::SplayNode* SplayMap<Key,Data>::pred(SplayNode* t) // GARANT_GCC
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

template <class Key, class Data>
typename SplayMap<Key,Data>::SplayNode* SplayMap<Key,Data>::_copy(SplayNode* t) // GARANT_GCC
{
  if (t != 0)
  {
    SplayNode* l = _copy(t->lt);
    SplayNode* r = _copy(t->rt);
    SplayNode* x = new SplayNode(t->item, t->cont, l, r);
    if (l != 0) l->par = x;
    if (r != 0) r->par = x;
    return x;
  }
  else 
    return 0;
}

#endif
