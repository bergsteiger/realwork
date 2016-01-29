//
// Class for iterating through a B-tree
// allows setting to a given key, forward & backward traversal
//
// Author : Alex V. Boreskoff
//

#include "../../NdtClone/Common/btiter.h"

namespace NdtClone {

BTIterator :: BTIterator ( const BTree * t, BTKEY key )
{
	Stack= 0;
	tree= 0;
	buf= 0;

	if(t){
		Stack = new BTStack [GKDB::BT_MAXDEPTH];
		tree = (BTree*)t;
		buf  = t -> file -> AllocBuf ();

		Set ( key );
	}
}

BTIterator :: ~BTIterator ()
{
	if(tree)
		tree -> file -> FreeBuf ( buf );
	if(Stack)
		delete[] Stack;
}

BTKEY BTIterator::Key () const // returns current item
{
	return tree -> RecOffs ( buf, Pos );
}

int	BTIterator :: Set ( BTKEY key )
{
	if ( tree -> KeyCount < 1 )
	{
		Sp = -1;
		return 0;
	}

	Stack [Sp = 0].Page = tree -> Root;

	if ( key == 0 )		// set to 1st item
	{
		Pos = 0;

		for ( ; ; )
		{
			if(!tree ->GetPage ( Stack [Sp].Page, buf ))
				tree->abort();

			if ( tree -> GetRef ( buf, -1 ) == 0l )
				return -1;

			Stack [Sp].Pos    = - 1;
			Stack [++Sp].Page = tree -> GetRef ( buf, -1 );
			if(Sp >= GKDB::BT_MAXDEPTH)
				tree->abort();
		}
	}

	for ( ; ; )
	{
		char  * KeyPtr = (char *) tree -> RecOffs ( buf, 0 );
		int	comp;

		tree ->GetPage ( Stack [Sp].Page, buf );
		int i;
		for ( i = 0; i < tree -> GetCount ( buf ); i++, KeyPtr += tree -> RecSize () )
			if ( ( comp = tree -> Compare ( key, KeyPtr ) ) <= 0 )
				break;

							// now either we've reached end of page
							// or key <= KeyPtr
		if ( comp == 0 )			// key found
		{
			Pos = i;

			return comp;
		}
		else
		if ( * (long *) ( KeyPtr - 4 ) == 0l )	// reached a leaf, go up
		{
			if ( i < tree -> GetCount ( buf ) )	// g.e. key < KeyPtr
			{
				Pos = i;
				return comp;
			}

								// reached end of page => go up
			for ( Pos = i; Pos >= tree -> GetCount ( buf ); )
			{
				if ( --Sp < 0 )
					return -1;		// ????????

				tree ->GetPage ( Stack [Sp].Page, buf );
				Pos = Stack [Sp].Pos + 1;
			}

			return tree -> Compare ( key, tree -> RecOffs ( buf, Pos ) );
		}

		Stack [Sp].Pos    = i - 1;
		Stack [++Sp].Page = * (long *) ( KeyPtr - 4 );
	}
}

//##ModelId=3BFE7DE90208
void	BTIterator :: next ()
{
	if ( tree -> GetRef ( buf, Pos ) != 0l )	// go down
	{
		Stack [Sp].Pos = Pos;			// save current pos

		do
		{
			Stack [++Sp].Page = tree -> GetRef ( buf, Pos );
			Stack [Sp].Pos    = -1;
			Pos               = -1;

			tree ->GetPage ( Stack [Sp].Page, buf );
		} while ( tree -> GetRef ( buf, -1 ) != 0l );

		Pos = 0;
		return;
	}

	while ( ++Pos >= tree -> GetCount ( buf ) )	// end of page, go up
	{
		if ( --Sp < 0 )
			return;

		tree ->GetPage ( Stack [Sp].Page, buf );
		Pos = Stack [Sp].Pos;
	}
}

//##ModelId=3BFE7DE9020B
void	BTIterator :: prev ()
{
	if ( --Pos >= -1 )
	{                                               // try go down on refs
		Stack [Sp].Pos = Pos;			// save current pos

		while ( tree -> GetRef ( buf, Pos ) != 0l )
		{
			Stack [++Sp].Page = tree -> GetRef ( buf, Pos );

			tree ->GetPage ( Stack [Sp].Page, buf );

			Stack [Sp].Pos    = tree -> GetCount ( buf ) - 1;
			Pos               = tree -> GetCount ( buf ) - 1;
		}

		if ( Pos > -1 )
			return;
	}

	do
	{
		if ( --Sp < 0 )
			return;

		tree ->GetPage ( Stack [Sp].Page, buf );
	} while ( ( Pos = Stack [Sp].Pos ) < 0 );
}

} // namespace NdtClone

