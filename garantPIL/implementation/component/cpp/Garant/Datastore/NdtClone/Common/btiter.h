//
// Class for iterating through a B-tree
// allows setting to a given key, forward & backward traversal
//
// Author : Alex V. Boreskoff
//

#ifndef	__PILOT_BTITERATOR__
#define	__PILOT_BTITERATOR__

#include "shared/DB/DBCore/DBCore.h"
#include "../../NdtClone/Common/btree.h"

namespace NdtClone {

class BTIterator 
	: virtual public DBCore::IBTreeIterator 
#ifndef PLAIN_GKDB
	, virtual public Core::RefCountObjectBase 
#endif
												{
public:
	NdtClone::BTree* tree;
	NdtClone::BTStack* Stack;
	int	Sp;
	int	Pos;	// index of current record
	void* buf;	// use this buffer for all stack

	BTIterator ( const BTree *itree, const void * start_key = 0 );
	virtual ~BTIterator ();

	virtual int	Set   ( BTKEY );	// sets to first item >= key

	virtual BTKEY Key () const;		// returns current item

	virtual int	End () const		// whether iterator reached end of tree
	{				// in either direction
		return Sp < 0;
	}
					// define comparisons based on tree -> Compare
	int	operator < ( BTKEY key ) const
	{
		return tree -> Compare ( Key (), key ) < 0;
	}

	int	operator <= ( BTKEY key ) const
	{
		return tree -> Compare ( Key (), key ) <= 0;
	}

	int	operator > ( BTKEY key ) const
	{
		return tree -> Compare ( Key (), key ) > 0;
	}

	int	operator >= ( BTKEY key ) const
	{
		return tree -> Compare ( Key (), key ) >= 0;
	}

	virtual void next();
	void	operator ++ (){ next(); }         // advance one item forward
	virtual void prev();
	void	operator -- () {prev();}		// advance one item backward
};
} // namespace NdtClone
typedef NdtClone::BTIterator BTIterator;
#endif
