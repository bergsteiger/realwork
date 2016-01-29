/*
 * $Id: ListSet.h,v 1.5 2005/08/17 13:39:03 grigorio Exp $
 */

#ifndef _List_h
#define _List_h 1

template <class Data>
class ListSet : public Set<Data>
{
protected:
	struct ListNode
	{
		ListNode* lprev;
		ListNode* lnext;
		Data item;
		ListNode(Data& h, ListNode* p=0, ListNode* n=0) :lprev(p), lnext(n), item(h) {};
		~ListNode() {};
	};

	ListNode* lfirst;
	ListNode* llast;

	void _kill(ListNode* t) {
		if (t != 0) {
			_kill(t->lnext);
			delete t;
		}
	}

public:
	ListSet() : lfirst(0), llast(0) {
		this->count = 0; // GARANT_THIS
	};
	~ListSet() {
		_kill(lfirst);
	}

	virtual Point add(Data& item) {
		ListNode* p = (ListNode*) seek(item);
		if ( p ) return (Point)p;

		p = new ListNode (item, llast);
		if ( llast )
			llast->lnext = p;
		else
			lfirst = p;
		
		llast = p;

		this->count++;
		return (Point)llast;
	}
	virtual Point _add(Data item) {
		return add(item);
	}
	virtual void del(Data& item) {
		ListNode* p = (ListNode*)  seek(item);
		if ( p ) {
			if ( p->lprev ) 
				p->lprev->lnext = p->lnext;
			else // it's first
				lfirst = p->lnext;
			
			if ( p->lnext )
				p->lnext->lprev = p->lprev;
			else // it's last
				llast = p->lprev;

			this->count--;
			delete p;
		}
	}
	virtual void makeFirst (Point i) {
		if ( i && ((ListNode*)i) != lfirst ) {
			// remove from list
			((ListNode*)i)->lprev->lnext = ((ListNode*)i)->lnext;
			
			if ( ((ListNode*)i)->lnext )
				((ListNode*)i)->lnext->lprev = ((ListNode*)i)->lprev;
			else // it's last
				llast = ((ListNode*)i)->lprev;

			// make it first
			lfirst->lprev = ((ListNode*)i);
			((ListNode*)i)->lnext = lfirst;
			((ListNode*)i)->lprev = 0;
			lfirst = ((ListNode*)i);			
		}
	}
	virtual void makeLast (Point i) {
		if ( i && ((ListNode*)i) != llast ) {
			// remove from list
			if ( ((ListNode*)i)->lprev ) 
				((ListNode*)i)->lprev->lnext = ((ListNode*)i)->lnext;
			else // it's first
				lfirst = ((ListNode*)i)->lnext;
						
			((ListNode*)i)->lnext->lprev = ((ListNode*)i)->lprev;
			
			// make it last
			llast->lnext = ((ListNode*)i);
			((ListNode*)i)->lnext = 0;
			((ListNode*)i)->lprev = llast;
			llast = ((ListNode*)i);			
		}
	}
	virtual Point first() const {
		return lfirst;
	}
	virtual Point last() const {
		return llast;
	}
	virtual void next(Point& i) const {
		if ( i ) i = ((ListNode*)i)->lnext;
	}
	virtual Data& operator () (Point i) const {
		if (i == 0) this->error("null Point");
		return ((ListNode*)i)->item;
	}
	virtual Data& contents (Point i) {
		if (i == 0) this->error("null Point");
		return ((ListNode*)i)->item;
	}
	virtual const Data* operator [] (Point i) {
		if (i == 0) this->error("null Point");
		return &((ListNode*)i)->item;
	}
	virtual int OK() {
		ListNode* lst=0;
		for ( Point p = first(); p; next(p) )
			lst = (ListNode*)p;
		return lst == llast;
	}
	virtual void clear() {
		_kill(lfirst);
		llast = 0;
		lfirst = 0;
		this->count = 0;
	}
};

#endif
