/*
 * $Id: Set.h,v 1.7 2012/09/03 10:59:07 dolgop Exp $
 */

#ifndef _Set_h
#define _Set_h 1

#include "typecmp.h"

typedef void* Point;

template <class Data>
class Set
{
protected:
	unsigned int count;

public:
	inline virtual ~Set() {};
	
	int length() const {                           // current number of items
		return count;
	}
	int empty() const {
		return count == 0;
	}
	virtual Point add(Data& item) = 0;       // add item; return Point
	virtual Point _add(Data item) = 0;       // add item; return Point
	virtual void del(Data& item) = 0;        // delete item
	virtual int contains(Data& item) {       // is item in set?
		return seek(item) != 0;
	}
	virtual void clear();                    // delete all items
	virtual Point first() const = 0;               // Point of first item or 0
	virtual void next(Point& i) const = 0;         // advance to next or 0
	virtual Data& operator () (Point i) const = 0; // access item at i
	virtual Data& contents (Point i) = 0; // access item at i
	virtual const Data* operator [] (Point i) = 0; // access item at i
	virtual int owns(Point i);               // is i a valid Point  ?
	virtual Point seek(Data& item);          // Point of item
	
	void operator |= (Set& b);               // add all items in b
	void operator -= (Set& b);               // delete items also in b
	void operator &= (Set& b);               // delete items not in b
	//int operator & (Set& y);
	int operator == (Set& b);
	int operator != (Set& b);
	int operator <= (Set& b); 
	
	void error(const char* msg) const;
	virtual int OK() = 0;                    // rep invariant
	virtual int DataCmp (Data& a, Data& b) const {
		return a > b ? 1 : -(int)(a < b);
	}
};

template <class Data>
Point Set<Data>::seek(Data& item)
{
  Point i;
  for (i = first(); i != 0 && this->DataCmp((*this)(i), item); next(i));
  return i;
}

template <class Data>
int Set<Data>::owns(Point idx)
{
  if (idx == 0) return 0;
  for (Point i = first(); i; next(i)) if (i == idx) return 1;
  return 0;
}

template <class Data>
void Set<Data>::clear()
{
  Point i = first(); 
  while (i != 0)
  {
    del((*this)(i));
    i = first();
  }
}

template <class Data>
int Set<Data>::operator <= (Set& b)
{
  if (count > b.count) return 0;
  if (count == 0) return 1;
  for (Point i = first(); i; next(i)) if (b.seek((*this)(i)) == 0) return 0;
  return 1;
}

template <class Data>
int Set<Data>::operator == (Set& b)
{
  unsigned int n = count;
  if (n != b.count) return 0;
  if (n == 0) return 1;
  Point i = first();
  Point j = b.first();
  while (n-- > 0)
  {
    if ((b.seek((*this)(i)) == 0) || (seek(b(j)) == 0)) return 0;
    next(i);
    b.next(j);
  }
  return 1;
}

template <class Data>
int Set<Data>::operator != (Set& b)
{
  return !(*this == b);
}

template <class Data>
void Set<Data>::operator |= (Set& b)
{
  if (&b != this)
    for (Point i = b.first(); i; b.next(i)) add(b(i));
}

template <class Data>
void Set<Data>::operator -= (Set& b)
{
  if (&b == this)
    clear();
  else
    for (Point i = b.first(); i; b.next(i)) del(b(i));
}

template <class Data>
void Set<Data>::operator &= (Set& b)
{
  if (&b != this)
  {
    Point i = first();
    Point n = i;
    while (i != 0)
    {
      next(n);
      if (b.seek((*this)(i)) == 0) del((*this)(i));
      i = n;
    }
  }
}

template <class Data>
void Set<Data>::error(const char* msg) const
{
  throw msg;
}

#endif
