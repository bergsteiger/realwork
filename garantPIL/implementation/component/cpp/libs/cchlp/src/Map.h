/*
 * $Id: Map.h,v 1.5 2000/04/11 16:28:06 max Exp $
 */

#ifndef _Map_h
#define _Map_h 1

typedef void* Point;

template <class Key,class Data>
class Map
{
protected:
	Data	def;
	unsigned int	count;	

public:
	Map(const Data dflt) : def ( dflt ), count(0) {};
	Map() : count(0) {};
	virtual ~Map() {};
	
	int	length() const { 
		return count;
	}
	int	empty() const {
		return count == 0;
	}
	virtual int contains(const Key  key);    // is key mapped?
	virtual void clear();                    // delete all items
	virtual Data& operator [] (Key key) = 0; // access contents by key
	virtual Data& get (Key  key) = 0;        // access contents by key
	virtual int add (Key  key, Data& data) = 0; // add new entry
	virtual void del(Key  key) = 0;          // delete entry
	virtual void del(Point i) = 0;           // delete entry
	virtual Point first() = 0;               // Point of first item or 0
	virtual void next(Point& i) = 0;         // advance to next or 0
	virtual Key& key(Point i) = 0;           // access key at i
	virtual Data& contents(Point i) = 0;     // access contents at i
	virtual int owns(Point i);               // is i a valid Point  ?
	virtual Point seek(Key  key);            // Point of key
	Data& dflt() {                           // access default val
		return def;
	}

	inline int KeyCmp (Key& a, Key& b) const {
		return a > b ? 1 : -(int)(a < b);
	}
	
	void error(const char* msg);
	virtual int OK() = 0;                    // rep invariant
};

template <class Key,class Data>
int Map<Key,Data>::owns(Point idx)
{
	if (idx == 0) return 0;
	for (Point i = first(); i; next(i)) if (i == idx) return 1;
	return 0;
}

template <class Key,class Data>
Point Map<Key,Data>::seek(Key  item)
{
	Point i;
	for (i = first(); i != 0 && KeyCmp(key(i), item); next(i));
	return i;
}

template <class Key,class Data>
void Map<Key,Data>::clear()
{
	Point i = first(); 
	while (i != 0)
	{
		del(key(i));
		i = first();
	}
}

template <class Key,class Data>
int Map<Key,Data>::contains (const Key  item)
{
	return seek(item) != 0;
}

template <class Key,class Data>
void Map<Key,Data>::error(const char* msg)
{
	throw msg;
}

#endif
