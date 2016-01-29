/*
 * $Id: StorableSplaySet.h,v 2.14 2012/09/03 10:50:32 dolgop Exp $
 */

#ifndef _StorableSplaySet_h
#define _StorableSplaySet_h 1

#include "SplaySet.h"
#include "shared/DB/DBCore/DBCore.h"

template <class Data>
class StorableSplaySet : public SplaySet<Data>, public DBCore::Storable
{
public:
	StorableSplaySet();
	StorableSplaySet(const StorableSplaySet& a);
	inline ~StorableSplaySet();

	virtual	int	Put (DBCore::Store*);		// save object to Store
	virtual	int	Get (DBCore::Store*);		// reload contents of existing object from Store
	virtual	int	Add (DBCore::Store*);		// add contents from Store
	virtual	short Tag () const;		// tag for restoring object

	typedef typename SplaySet<Data>::SplayNode* SplayNodePtr; 

	void _kill(SplayNodePtr t);

	/*
	SplaySet& operator = (const SplaySet& b);
	void operator |= (SplaySet& b);
	void operator -= (SplaySet& b);
	void operator &= (SplaySet& b);

	int operator == (SplaySet& b);
	int operator != (SplaySet& b);
	int operator <= (SplaySet& b);
	int OK();
	*/
};

template <class Data>
StorableSplaySet<Data>::~StorableSplaySet()
{
	_kill(this->root);
	this->root = 0;
}

template <class Data>
int	StorableSplaySet<Data>::Put (DBCore::Store* store)
{
	if ( store ) {
		for ( Point point = this->first(); point; this->next(point) ) // GARANT_GCC
			store->Write ( &(((typename SplaySet<Data>::SplayNode*)point)->item), sizeof(Data) ); // GARANT_GCC

		return 1;
	} else return 0;
}

template <class Data>
int	StorableSplaySet<Data>::Get (DBCore::Store* store)
{
	this->clear(); // GARANT_GCC
	return Add ( store );
}

template <class Data>
int	StorableSplaySet<Data>::Add (DBCore::Store* store)
{
	if ( store ) {
		long count = store->Length() / sizeof ( Data );

		for ( long l=0; l<count; l++ ) {
			Data data;
			store->Read ( &data, sizeof(Data) );
			this->add ( data );
		}
		return 1;
	} else return 0;
}

template <class Data>
inline short StorableSplaySet<Data>::Tag () const
{
	return 4321;
}

template <class Data>
inline StorableSplaySet<Data>::StorableSplaySet(const StorableSplaySet& b) : SplaySet<Data> (b)
{
}


template <class Data>
inline StorableSplaySet<Data>::StorableSplaySet() : SplaySet<Data> ()
{
}

template <class Data>
void StorableSplaySet<Data>::_kill(SplayNodePtr t)
{
	if (t != 0) {
		std::deque<SplayNodePtr> ptrs;
		ptrs.push_back (t);
		for (size_t i = 0; i<ptrs.size (); i++) {
			SplayNodePtr ati = ptrs [i];
			if (ati->lt) ptrs.push_back (ati->lt);
			if (ati->rt) ptrs.push_back (ati->rt);
		}
		for (typename std::deque<SplayNodePtr>::iterator it = ptrs.begin (); it != ptrs.end (); it++) {
			SplayNodePtr ati = *it;
			delete ati;
		}
	}
}

/*
template <class Data>
inline StorableSplaySet<Data>::~StorableSplaySet()
{
}

template <class Data>
inline SplaySet<Data>& SplaySet<Data>::operator = (const SplaySet& b)
{
  if (this != &b)
    {
      _kill (root);
      count = b.count;
      root = _copy (b.root);
    }
  return *this;
}

template <class Data>
inline int SplaySet<Data>::operator != (SplaySet<Data>& b)
{
  return ! (*this == b);
}

template <class Data>
int SplaySet<Data>::operator == (SplaySet<Data>& y)
{
  if (count != y.count)
    return 0;
  else
  {
    SplayNode* t = leftmost();
    SplayNode* u = y.leftmost();
    for (;;)
    {
      if (t == 0)
        return 1;
      else if (!DataEQ(t->item, u->item))
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
  if (count > y.count)
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
      int cmp = DataCmp(t->item, u->item);
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
void SplaySet<Data>::operator &= (SplaySet<Data>& y)
{
  if (y.count == 0)
    clear();
  else if (&y != this && count != 0)
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
int StorableSplaySet<Data>::OK()
{
	return SplaySet<Data>::OK();
}
*/

#endif
