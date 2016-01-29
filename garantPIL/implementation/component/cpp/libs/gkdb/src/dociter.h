//
// Class DocIterator
// Author : Alex V. Boreskoff
// Modified : 21/09/96
//

#ifndef	__DOC_ITERATOR__
#define	__DOC_ITERATOR__

#include "btiter.h"
#include "base.h"

class	DocIterator : public BTIterator
{
public:
	DocIterator ( Base * );

	virtual void Rewind ();
	virtual void next ();         // advance one item forward
	void	prev ();		// advance one item backward
	virtual long Id  ();			// return id of current document

	virtual int	End () const {  // whether iterator reached end of tree in either direction
		if (ids.size ())
			return ids_iter == ids.end ();
		else
			return BTIterator::End ();
	}

protected:
	int	Tag () const;
	std::set<long> ids;
	std::set<long>::const_iterator ids_iter;
};

class	DocInvIterator : public DocIterator
{
public:
	DocInvIterator (Base*);

	virtual void next ();

private:
	std::set<long> docs_with_invisible;
};

#endif
