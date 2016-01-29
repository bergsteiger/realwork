/*
 * $Id: SplaySet.h,v 1.25 2012/09/03 10:59:07 dolgop Exp $
 */

#ifndef _SplaySet_h
#define _SplaySet_h 1

#include "Set.h"
#include <deque>

template <class Data>
class SplaySet : public Set<Data>
{
public:
	struct SplayNode
	{
		SplayNode* lt;
		SplayNode* rt;
		SplayNode* par;
		Data item;
		SplayNode(Data& h, SplayNode* l=0, SplayNode* r=0) :lt(l), rt(r), par(0), item(h) {};
		~SplayNode() {};
	};
	struct _dummySplayNode
	{
		SplayNode* lt;
		SplayNode* rt;
		SplayNode* par;
	} _dummy_null;

	typedef typename SplaySet<Data>::SplayNode* NodePtr;

protected:
	SplayNode* root;

	SplayNode* leftmost() const;
	SplayNode* rightmost() const;
	SplayNode* pred(SplayNode* t) const;
	SplayNode* succ(SplayNode* t) const;
	
	void _kill(SplayNode* t);
	void _l_kill(SplayNode* t);
	void _r_kill(SplayNode* t);
        
	SplayNode* _copy(SplayNode* t);

public:
	SplaySet();
	SplaySet(const SplaySet& a);
	inline ~SplaySet();

	virtual Point add(Data& item);
	virtual Point _add(Data item);
	virtual void del(Data& item);
	inline int contains(Data& item);

	virtual inline void clear();
	inline Point first() const;
	inline void next(Point& i) const;
	inline Data& operator () (Point i) const;
	inline Data& contents (Point i);
	inline const Data* operator [] (Point i);
	void	set_and( SplaySet* b );
	void	set_minus( SplaySet* b );
	void	set_copy( SplaySet* b );
	void	set_or( SplaySet* b );
	Point seek(Data& item);

	Point last() const;
	void prev(Point& i) const;

	SplaySet& operator = (const SplaySet& b);
	void operator |= (SplaySet& b);
	void operator -= (SplaySet& b);
	void operator &= (SplaySet& b);
	int operator & (SplaySet& y);

	int operator == (SplaySet& b);
	int operator != (SplaySet& b);
	int operator <= (SplaySet& b); 

	int OK();
};

template <class Data>
inline SplaySet<Data>::~SplaySet()
{
  _kill(root);
}

template <class Data>
inline SplaySet<Data>::SplaySet()
{
  root = 0;
  this->count = 0; // GARANT_THIS
}

template <class Data>
inline SplaySet<Data>::SplaySet(const SplaySet& b)
{
	this->root = 0;
	this->count = 0;
	SplayNode* u = b.leftmost ();
	while (u != 0) {
		add (u->item);
		u = b.succ (u);
	}
	
	/*
	this->count = b.count;
	root = _copy(b.root);
	*/
}

template <class Data>
inline SplaySet<Data>& SplaySet<Data>::operator = (const SplaySet& b)
{
	if (this != &b) {
		_kill (root);
		this->root = 0;
		this->count = 0;

		SplayNode* u = b.leftmost ();
		while (u != 0) {
			add (u->item);
			u = b.succ (u);
		}

		/*
		this->count = b.count;
		root = _copy (b.root);
		*/
	}
	return *this;
}

template <class Data>
inline int SplaySet<Data>::operator != (SplaySet<Data>& b)
{
  return ! (*this == b);
}

template <class Data>
inline Point SplaySet<Data>::first() const
{
  return (Point)(leftmost());
}

template <class Data>
inline Point SplaySet<Data>::last() const
{
  return Point(rightmost());
}

template <class Data>
inline void SplaySet<Data>::next(Point& i) const
{
  if (i != 0) i = (Point)(succ((SplayNode*)i));
}

template <class Data>
inline void SplaySet<Data>::prev(Point& i) const
{
  if (i != 0) i = Point(pred((SplayNode*)i));
}

template <class Data>
inline Data& SplaySet<Data>::operator () (Point i) const
{
  if (i == 0) this->error("null Point"); // GARANT_THIS
  return ((SplayNode*)i)->item;
}

template <class Data>
inline Data& SplaySet<Data>::contents (Point i)
{
  if (i == 0) this->error("null Point"); // GARANT_THIS
  return ((SplayNode*)i)->item;
}


template <class Data>
inline const Data* SplaySet<Data>::operator [] (Point i)
{
  if (i == 0) this->error("null Point"); // GARANT_THIS
  return &((SplayNode*)i)->item;
}

template <class Data>
inline void SplaySet<Data>::clear()
{
  _kill(root);
  this->count = 0;
  root = 0;
}

template <class Data>
inline int SplaySet<Data>::contains(Data& key)
{
  return seek(key) != 0;
}

/*
 traversal primitives
*/

template <class Data>
typename SplaySet<Data>::SplayNode* SplaySet<Data>::leftmost() const // GARANT_TYPENAME
{
  SplayNode* t = root;
  if (t != 0) while (t->lt != 0) t = t->lt;
  return t;
}

template <class Data>
typename SplaySet<Data>::SplayNode* SplaySet<Data>::rightmost() const
{
  SplayNode* t = root;
  if (t != 0) while (t->rt != 0) t = t->rt;
  return t;
}

template <class Data>
typename SplaySet<Data>::SplayNode* SplaySet<Data>::succ(typename SplaySet<Data>::SplayNode* t) const
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

template <class Data>
typename SplaySet<Data>::SplayNode* SplaySet<Data>::pred(typename SplaySet<Data>::SplayNode* t) const
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

template <class Data>
Point SplaySet<Data>::seek(Data& key)
{
  SplayNode* t = root;
  if (t == 0)
    return 0;

  int comp = this->DataCmp(key, t->item);
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
        comp = this->DataCmp(key, tr->item);
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
          comp = this->DataCmp(key, t->item);
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
        comp = this->DataCmp(key, tl->item);
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
          comp = this->DataCmp(key, t->item);
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

template <class Data>
Point SplaySet<Data>::_add(Data item)
{
	return add ( item );
}

template <class Data>
Point SplaySet<Data>::add(Data& item)
{
  SplayNode* t = root;
  if (t == 0)
  {
    ++this->count;
    root = new SplayNode(item);
    return (Point)(root);
  }
  int comp = this->DataCmp(item, t->item);
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
      {
        ++this->count;
        tr = new SplayNode(item);
        comp = 0;
      }
      else
        comp = this->DataCmp(item, tr->item);
        
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
          trr =  new SplayNode(item);
          comp = 0;
        }
        else
          comp = this->DataCmp(item, trr->item);

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
        tl = new SplayNode(item);
        comp = 0;
      }
      else
        comp = this->DataCmp(item, tl->item);

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
          tll = new SplayNode(item);
          comp = 0;
        }
        else
          comp = this->DataCmp(item, tll->item);

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
  return (Point)(root);
}

template <class Data>
void SplaySet<Data>::del(Data& key)
{
  SplayNode* t = (SplayNode*)(seek(key));
  if (t == 0) return;

  SplayNode* p = t->par;

  --this->count;
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

#ifdef RECURSION_CONTROL
	unsigned long reqursion_count;
	unsigned long prev_req_count;
#endif

template <class Data>
void SplaySet<Data>::_l_kill(SplayNode* t)
{
#ifdef RECURSION_CONTROL
	reqursion_count++;
	if ( reqursion_count == prev_req_count + 1000 ) {
		printf ( "reqursion is: %ld\n", reqursion_count );
		prev_req_count += 1000;
	}
#endif
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
#ifdef RECURSION_CONTROL
	reqursion_count--;
#endif

}

template <class Data>
void SplaySet<Data>::_r_kill(SplayNode* t)
{
#ifdef RECURSION_CONTROL
	reqursion_count++;
	if ( reqursion_count == prev_req_count + 1000 ) {
		printf ( "reqursion is: %ld\n", reqursion_count );
		prev_req_count += 1000;
	}
#endif

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
#ifdef RECURSION_CONTROL
	reqursion_count--;
#endif
}


template <class Data>
void SplaySet<Data>::_kill(SplayNode* t)
{
#ifdef RECURSION_CONTROL
	if (t == root) {
			reqursion_count = 0;
			prev_req_count = 0;
	}
	else {
		reqursion_count++;

		if ( reqursion_count == prev_req_count + 1000 ) {
			printf ( "reqursion is: %ld\n", reqursion_count );
			prev_req_count += 1000;
		}
	}
#endif

	if (t != 0) {
		std::deque<NodePtr> ptrs;
		ptrs.push_back (t);
		for (size_t i = 0; i < ptrs.size (); i++) {
			NodePtr ati = ptrs [i];
			if (ati->lt) ptrs.push_back (ati->lt);
			if (ati->rt) ptrs.push_back (ati->rt);
		}
		for (typename std::deque<NodePtr>::iterator it = ptrs.begin (); it != ptrs.end (); it++) {
			NodePtr ati = *it;
			delete ati;
		}
	}

#ifdef RECURSION_CONTROL
    if (t == root) { 
		reqursion_count = 0;
		prev_req_count = 0;
	}
	else reqursion_count--;
#endif
}

template <class Data>
typename SplaySet<Data>::SplayNode* SplaySet<Data>::_copy(typename SplaySet<Data>::SplayNode* t)
{
	if (t != 0) {
		SplayNode* l = _copy(t->lt);
		SplayNode* r = _copy(t->rt);
		SplayNode* x = new SplayNode(t->item, l, r);
		if (l != 0) l->par = x;
		if (r != 0) r->par = x;
		return x;
	}
	else 
		return 0;
}

template <class Data>
int SplaySet<Data>::operator == (SplaySet<Data>& y)
{
  if (this->count != y.count)
    return 0;
  else
  {
    SplayNode* t = leftmost();
    SplayNode* u = y.leftmost();
    for (;;)
    {
      if (t == 0)
        return 1;
      else if (this->DataCmp(t->item, u->item))
        return 0;
      else
      {
        t = succ(t);
        u = y.succ(u);
      }
    }
  }
}

template <class Data>
int SplaySet<Data>::operator <= (SplaySet<Data>& y)
{
  if (this->count > y.count)
    return 0;
  else
  {
    SplayNode* t = leftmost();
    SplayNode* u = y.leftmost();
    for (;;)
    {
      if (t == 0)
        return 1;
      else if (u == 0)
        return 0;
      int cmp = this->DataCmp(t->item, u->item);
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

template <class Data>
void SplaySet<Data>::operator |=(SplaySet<Data>& y)
{
  if (&y == this) return;
  SplayNode* u = y.leftmost();
  while (u != 0)
  {
    add(u->item);
    u = y.succ(u);
  }
}

template <class Data>
void SplaySet<Data>::set_or(SplaySet<Data>* y)
{
  if (y == this) return;
  SplayNode* u = y->leftmost();
  while (u != 0)
  {
    add(u->item);
    u = y->succ(u);
  }
}

template <class Data>
void	SplaySet<Data>::set_and(SplaySet<Data>* y)
{
	if ( y->count == 0 )
		clear();
	else
	if ( this->count != 0 ) { // GARANT_THIS
		SplayNode* t = leftmost();
		while (t != 0) {
			SplayNode* s = succ(t);
			if (y->seek(t->item) == 0)
				del(t->item);
			t = s;
		}		
	}
}

template <class Data>
void	SplaySet<Data>::set_copy(SplaySet<Data>* y)
{
	clear();
	Point p;
	for ( p = y->first(); p; y->next(p)) {
		add(((SplayNode*)p)->item);
	}
}

template <class Data>
void	SplaySet<Data>::set_minus(SplaySet<Data>* y)
{
	if (y->count != 0) {
		SplayNode* t = leftmost();
		while (t != 0) {
			SplayNode* s = succ(t);
			if (y->seek(t->item) != 0)
				del(t->item);
			t = s;
		}
	}
}

template <class Data>
void SplaySet<Data>::operator &= (SplaySet<Data>& y)
{
  if (y.count == 0)
    clear();
  else if (&y != this && this->count != 0)
  {
    SplayNode* t = leftmost();
    while (t != 0)
    {
      SplayNode* s = succ(t);
      if (y.seek(t->item) == 0) del(t->item);
      t = s;
    }
  }
}

template <class Data>
int SplaySet<Data>::operator & (SplaySet<Data>& y)
{
  if (y.count == 0 || this->count == 0)
    return 0;
  if (&y == this) return 1;

  SplayNode* t = leftmost();
  while (t != 0)
  {
      SplayNode* s = succ(t);
      if (y.seek(t->item) != 0) return 1;
      t = s;
  }
  return 0;
}

template <class Data>
void SplaySet<Data>::operator -=(SplaySet<Data>& y)
{
  if (&y == this)
    clear();
  else if (y.count != 0)
  {
    SplayNode* t = leftmost();
    while (t != 0)
    {
      SplayNode* s = succ(t);
      if (y.seek(t->item) != 0) del(t->item);
      t = s;
    }
  }
}

template <class Data>
int SplaySet<Data>::OK()
{
  int v = 1;
  if (root == 0) 
    v = (this->count == 0); // GARANT_THIS
  else
  {
    unsigned int n = 1;
    SplayNode* trail = leftmost();
    SplayNode* t = succ(trail);
    while (t != 0)
    {
      ++n;
      v &= this->DataCmp(trail->item, t->item) < 0;
      trail = t;
      t = succ(t);
    }
    v &= (n == this->count); // GARANT_THIS
  }
  if (!v) this->error("invariant failure");
  return v;
}

#endif
