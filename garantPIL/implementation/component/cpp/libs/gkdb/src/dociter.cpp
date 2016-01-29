//
// Class for iterating through documents in the given base
//
// Author: Alex V. Boreskoff

#include "check.h"
#include "dociter.h"

#include <cstdlib>


DocIterator :: DocIterator ( Base * base ) : BTIterator ( base ? base ->FindIndex("Attrs") : tree = 0  )
{
	if (base && base->bases_ptrs.size () > 1) {
		for (std::vector<Base*>::const_iterator base_it = base->bases_ptrs.begin (); base_it != base->bases_ptrs.end (); base_it++) {
			AttrKey key = {ID_BORDER, IDD_INFO};
			for (BTIterator it ((*base_it)->FindIndex ("Attrs"), &key); !it.End (); ++it) {
				AttrKey *keyptr = (AttrKey*) it.Key ();
				if (keyptr->AttrTag != IDD_INFO)
					break;
				ids.insert (keyptr->DocId);
			}
		}
	}
	Rewind ();
}

void	DocIterator :: Rewind ()
{
	if(!tree)
		return ;

	if (ids.size ()) {
		ids_iter = ids.begin ();
		return ;
	}

	Set ( 0 );
	while ( !End () && Tag () != IDD_INFO )
		this -> BTIterator :: next ();
}

long	DocIterator :: Id ()
{
	if (ids.size ()) {
		return *ids_iter++;
	}

	AttrKey * ptr = (AttrKey *) Key ();
	return ptr -> DocId;
}

int	DocIterator :: Tag () const
{
	AttrKey * ptr = (AttrKey *) Key ();

	return ptr -> AttrTag;
}

void	DocIterator :: next ()
{
	if (ids.size ()) {
		if (ids_iter != ids.end ())
			ids_iter++;
		return ;
	}

	do
		this -> BTIterator :: next ();
	while ( !End () && Tag () != IDD_INFO );
}

void	DocIterator :: prev ()
{
	if (ids.size ()) {
		if (ids_iter != ids.begin ())
			ids_iter--;
		return;
	}

	do
		this -> BTIterator :: prev();
	while ( !End () && Tag () != IDD_INFO );
}

DocInvIterator :: DocInvIterator ( Base * base ) : DocIterator ( base )
{
	AttrKey key = {ID_BORDER, IDD_HANDMASK};
	for (BTIterator it1 (base->FindIndex ("Attrs"), &key); !it1.End (); ++it1) {
		AttrKey *key = (AttrKey*) it1.Key ();
		if (key->AttrTag != IDD_HANDMASK)
			break;
		docs_with_invisible.insert (key->DocId);			
	}
	key.AttrTag = IDD_HANDHANDMASK;
	for (BTIterator it2 (base->FindIndex ("Attrs"), &key); !it2.End (); ++it2) {
		AttrKey *key = (AttrKey*) it2.Key ();
		if (key->AttrTag != IDD_HANDHANDMASK)
			break;
		docs_with_invisible.insert (key->DocId);			
	}
}

void	DocInvIterator :: next ()
{
	while (true) {
		DocIterator::next ();
		if (End () || Tag () != IDD_INFO)
			break;
		if (docs_with_invisible.find (Id ()) == docs_with_invisible.end ())
			continue;
		break;
	}
}
