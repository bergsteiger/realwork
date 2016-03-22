//
// Collection of doc references ( struc Ref's )
// Supports adding, deleting items,
// merging & intersection of collections
//
// Author : Alex V. Boreskoff
//
// Last modification 5/10/96
//

#include "osdep.h"
#include "check.h"

#include "refcol.h"
#include "indices.h"
#include    "base.h"
#include    "doccol.h"

bool	bClassMerge = false;

int RefCollection :: Merge ( SortedCollection& list )
{
#if !defined(__WIN16__) && !defined(__DOS16__)
	if ( list.ItemCount < 1 )
		return 1;

	if ( ItemCount / list.ItemCount < insertBalance ) {
		if ( list.Tag() == OT_DOCCOLLECTION ) {
			RefCollection *result = new RefCollection();

			long	page1 = 0;
			long	page2 = 0;
			long	item1 = 0;
			long	item2 = 0;

			Ref*	ptr1 = ItemCount ? (Ref*) Pages[ page1 ] : 0;
			long*	ptr2 = (long*) list.Pages[ page2 ];
			Ref		ref2 = { *ptr2, 0 };

			int	add1 = 0;
			int add2 = 0;

			while ( ptr1 && ptr2 ) {
				if ( Compare( ptr1, &ref2 ) < 0 ) {
					result->Collection::Add( ptr1 );
					add1 = 1;
				} else
				if ( Compare( ptr1, &ref2 ) > 0 ) {
					result->Collection::Add( &ref2 );
					add2 = 1;
				} else {
					result->Collection::Add( ptr1 );
					add1 = 1;
					add2 = 1;
				}

				if ( add1 ) {
					add1 = 0;
					ptr1++;
					if ( ++item1 == Count[ page1 ] ) {
						if ( ++page1 == PageCount )
							ptr1 = 0;
						else {
							item1 = 0;
							ptr1 = (Ref*) Pages[ page1 ];
						}
					}
				}
				if ( add2 ) {
					add2 = 0;
					ptr2++;
					if ( ++item2 == list.Count[ page2 ] ) {
						if ( ++page2 == list.PageCount )
							ptr2 = 0;
						else {
							item2 = 0;
							ptr2 = (long*) list.Pages[ page2 ];
							ref2.DocId = *ptr2;
						}
					} else {
						ref2.DocId = *ptr2;
					}
				}
			}
			while ( ptr1 ) {
				result->Collection::Add( ptr1 );
				ptr1++;
				if ( ++item1 == Count[ page1 ] ) {
					if ( ++page1 == PageCount )
						ptr1 = 0;
					else {
						item1 = 0;
						ptr1 = (Ref*) Pages[ page1 ];
					}
				}
			}
			while ( ptr2 ) {
				result->Collection::Add( &ref2 );
				ptr2++;
				if ( ++item2 == list.Count[ page2 ] ) {
					if ( ++page2 == list.PageCount )
						ptr2 = 0;
					else {
						item2 = 0;
						ptr2 = (long*) list.Pages[ page2 ];
						ref2.DocId = *ptr2;
					}
				} else {
					ref2.DocId = *ptr2;
				}
			}

			FreeAll();
			Move( *result );
			delete result;

			return 1;
		} else
		if ( list.Tag() == OT_REFCOLLECTION ) {
			RefCollection *result = new RefCollection(PageSize);

			long	page1 = 0;
			long	page2 = 0;
			long	item1 = 0;
			long	item2 = 0;

			Ref*	ptr1 = ItemCount ? (Ref*) Pages[ page1 ] : 0;
			Ref*	ptr2 = (Ref*) list.Pages[ page2 ];

			int	add1 = 0;
			int add2 = 0;

			while ( ptr1 && ptr2 ) {
				if ( Compare( ptr1, ptr2 ) < 0 ) {
					result->Collection::Add( ptr1 );
					add1 = 1;
				} else
				if ( Compare( ptr1, ptr2 ) > 0 ) {
					result->Collection::Add( ptr2 );
					add2 = 1;
				} else {
	#ifdef	BLOCKSINHERIT
					if ( bClassMerge ) {
						if ( ( ptr2->Sub & INHERITED_BLOCK && !(ptr1->Sub & INHERITED_BLOCK )) || ( ptr1->Sub & INHERITED_BLOCK && !(ptr2->Sub & INHERITED_BLOCK )))
							ptr1->Sub &= MINUS_INHERITED_BLOCK; //(!X или X) равно (X или X!) и равно для классов X
					} else {
						if ( ptr2->Sub & INHERITED_BLOCK )
							ptr1->Sub |= INHERITED_BLOCK ;
					}
	#endif
					result->Collection::Add( ptr1 );
					add1 = 1;
					add2 = 1;
				}

				if ( add1 ) {
					add1 = 0;
					ptr1++;
					if ( ++item1 == Count[ page1 ] ) {
						if ( ++page1 == PageCount )
							ptr1 = 0;
						else {
							item1 = 0;
							ptr1 = (Ref*) Pages[ page1 ];
						}
					}
				}
				if ( add2 ) {
					add2 = 0;
					ptr2++;
					if ( ++item2 == list.Count[ page2 ] ) {
						if ( ++page2 == list.PageCount )
							ptr2 = 0;
						else {
							item2 = 0;
							ptr2 = (Ref*) list.Pages[ page2 ];
						}
					}
				}
			}
			while ( ptr1 ) {
				result->Collection::Add( ptr1 );
				item1++;
				ptr1++;
				if ( item1 == Count[ page1 ] ) {
					if ( ++page1 == PageCount )
						ptr1 = 0;
					else {
						ptr1 = (Ref*) Pages[ page1 ];
						item1 = 0;				
					}
				}
			}
			while ( ptr2 ) {
				result->Collection::Add( ptr2 );
				ptr2++;
				if ( ++item2 == list.Count[ page2 ] ) {
					if ( ++page2 == list.PageCount )
						ptr2 = 0;
					else {
						ptr2 = (Ref*) list.Pages[ page2 ];
						item2 = 0;
					}
				}
			}

			FreeAll();
			Move( *result );
			delete result;

			return 1;
		}
	}	
#endif
	if ( ItemCount == 0 ) {
		for ( int i = 0; i < list.PageCount; i++ ) {
			if ( list.Tag () == OT_DOCCOLLECTION ) {
				long   * ptr = (long *) list.Pages [i];
				for ( int j = 0; j < list.Count [i]; j++ ) {
					Ref ref = { ptr[j], 0 };
					if ( !Collection::Add ( &ref ) ) return 0;
				}
			}
			else
			if ( list.Tag () == OT_REFCOLLECTION || list.Tag () == OT_PARASCOLLECTION) {
				Ref   * ptr = (Ref *) list.Pages [i];
				for ( int j = 0; j < list.Count [i]; j++ )
					if ( !Collection::Add ( &ptr [j] ) ) return 0;
			} else return 0;
		}
	} else {
		for ( int i = 0; i < list.PageCount; i++ ) {
			if ( list.Tag () == OT_DOCCOLLECTION ) {
				long   * ptr = (long *) list.Pages [i];
				for ( int j = 0; j < list.Count [i]; j++ ) {
					Ref ref = { ptr[j], 0 };
					if ( !Add ( ref ) ) return 0;
				}
			}
			else
			if ( list.Tag () == OT_REFCOLLECTION ) {
				Ref   * ptr = (Ref *) list.Pages [i];
				for ( int j = 0; j < list.Count [i]; j++ )
					if ( !Add ( ptr [j] ) ) return 0;
			} else return 0;
		}
	}

	Compact();
	return 1;
}

int RefCollection :: IsSect ( SortedCollection& list )
{
	if ( list.Tag() == OT_DOCCOLLECTION ) return IsSect ( *(DocCollection*)&list );
	return SortedCollection::IsSect(list);
}

int RefCollection :: IsSect2 ( RefCollection* list )
{
	if ( ItemCount < 50  ) {
		int found = 0;
		for ( int i = 0; i < ItemCount && !found; i++ ) {
			Ref ati = *(Ref*) Collection::GetItem (i);
			if (list->IndexOf (&ati) != -1)
				found = 1;
			else if (ati.Sub) {
				ati.Sub = 0;
				if (list->IndexOf (&ati) != -1)
					found = 1;
			}
		}
		return found;
	} else {
		return SortedCollection::IsSect(*list);
	}
}

int RefCollection :: IsSect ( DocCollection& list ) 
{
	if ( list.ItemCount < 1 || ItemCount < 1 ) return 0;
	
	int	page2 = 0;
	char * ptr2 = (char*) list.Pages [page2];
	int	k = 0;
	int page;

	for ( page = 0; page < PageCount; page++ ) {
		char  * ptr = (char*) Pages [page];
		int i, j;
		for ( i = 0, j = 0; i < Count [page]; i++ ) {
			int iRes;
            while ( (iRes = list.Compare( ptr2 + list.ItemSize * k, ptr + ItemSize * i )) < 0 )
				if ( ++ k >= list.Count [page2] ) {
					if ( ++ page2 >= list.PageCount ) return 0;
					ptr2 = (char*) list.Pages [page2];                    
					k    = 0;
				}
            
			if ( !iRes ) return 1;
		}
	}
	return 0;
}

int RefCollection :: Intersect (SortedCollection& list) 
{
	if (this->Intersect (&list)) {
		this->Compact ();
		return 1;
	}
	return 0;
}

int RefCollection :: Intersect (SortedCollection* list) 
{
     int mode;
     if ( list->Tag () == OT_DOCCOLLECTION ) mode = 0;
     else if ( list->Tag () == OT_REFCOLLECTION ) mode = 1;
	 else if (list->Tag () == OT_REFWEIGHTCOLLECTION) mode = 2;
     else return 0;

	if ( list->ItemCount < 1 ){
		FreeAll ();
		return 0;
	}

	int	page2 = 0;		// processed page in 'list'
	Ref   * ptr2  = (Ref *) list->Pages [page2];
	RefwWeight   * ptr2w  = (RefwWeight*) list->Pages [page2];
    long  * ptr22 = (long*) list->Pages [page2];

	int	k     = 0;		// index in list's page
	int page;
	for ( page = 0; page < PageCount; page++ ) {	// check every page
		Ref  * ptr = (Ref *) Pages [page];	// pointer to current page
		int i, j;
		for ( i = 0, j = 0; i < Count [page]; i++ ) {
			Ref	item = ptr [i];

			while ( mode ? Compare(mode == 2 ? (Ref*) &ptr2w[k] : &ptr2[k],&item)<0 : ptr22[k]<item.DocId )
				if ( ++ k >= list->Count [page2] ) {
					if ( ++ page2 >= list->PageCount ) {
						Count [page++] = j;
						for ( ; page < PageCount; page++ )
							Count[page] = 0;
						goto Compact;
					}
					ptr2 = (Ref *) list->Pages [page2];
					ptr2w = (RefwWeight *) list->Pages [page2];
                    ptr22 = (long*) list->Pages [page2];
					k    = 0;
				}

			if ( mode ? !Compare(mode == 2 ? (Ref*) &ptr2w[k] : &ptr2[k],&item) : ptr22[k]==item.DocId)
#ifdef	BLOCKSINHERIT
				if ( mode == 1) {
					if ( ( ptr2[k].Sub & INHERITED_BLOCK ) && ( item.Sub & INHERITED_BLOCK ))
						ptr[ j++ ] = item; //!X и !X = !X
					else {
						if ( ptr2[k].Sub != 0 )
							item.Sub &= MINUS_INHERITED_BLOCK;
						ptr[ j++ ] = item;  //!X и X = X и X = X и !X = X
					}
				}
				else
					ptr [j++] = item;
#else
				ptr [j++] = item;
#endif
		}

		Count [page] = j;
	}

Compact:
	for ( ItemCount = 0, page = 0; page < PageCount; page++ )
		ItemCount += Count [page];

	return 1;
}

int	RefCollection :: Minus ( SortedCollection& list )
{
	int mode;
     	if ( list.Tag () == OT_DOCCOLLECTION ) mode = 0;
     	else if ( list.Tag () == OT_REFCOLLECTION ) mode = 1;
     	else return 0;

	if ( list.ItemCount < 1 )
		return 1;

	int	page2 = 0;		// processed page in 'list'
	Ref   * ptr2  = (Ref *) list.Pages [page2];
	long   * ptr22  = (long *) list.Pages [page2];
	
	int	k     = 0;		// index in list's page
	int page;
	for (  page = 0; page < PageCount; page++ )	// check every page
	{
		Ref  * ptr = (Ref *) Pages [page];	// pointer to current page
		int i, j;
		for ( i = 0, j = 0; i < Count [page]; i++ )
		{
			Ref	item = ptr [i];

			// mode == 0 - Ё§ Є®««ҐЄжЁЁ Ref®ў ўлзЁв Ґ¬ DocЁ (Sub==0)

			while ( mode ? Compare(&ptr2[k],&item)<0 : ptr22[k] < item.DocId  )
				if ( ++ k >= list.Count [page2] )
				{
					if ( ++ page2 >= list.PageCount )
					{		// list ended before end of *this
							// so add all items remaining on page
						for ( ; i < Count [page]; i++ )
							ptr [j++] = ptr [i];

						Count [page] = j;
						goto Compact;
					}

					ptr2 = (Ref *) list.Pages [page2];
					ptr22 = (long *) list.Pages [page2];
					k    = 0;
				}

			if ( mode ? Compare( &ptr2[ k ], &item ) : ptr22[ k ] != item.DocId )
				ptr [j++] = item;
		}

		Count [page] = j;
	}

Compact:
	Compact ();

	return 1;
}

void	RefCollection :: Compact ()
{
	int page;
	for ( ItemCount = 0, page = 0; page < PageCount; page++ )
		ItemCount += Count [page];

	for ( page = 0; page < PageCount - 1; )
		if ( Count [page] < PageSize / 2 )
			if ( Count [page] + Count [page + 1] <= PageSize )
				Collection :: Merge ( page );
			else {
				Collection :: Balance ( page );
				page++;
			}
		else
			page++;

	while (PageCount && !Count [PageCount-1])
		PageCount--;
}

long	RefCollection :: DocCount () const
{
	Ref   * ptr = 0;
	long lCount = 0;
	long prevDocId = 0;

	for ( int i = 0; i < PageCount; i++ ) {
        	ptr = (Ref *) Pages [i];
		for ( int j = 0; j < Count [i]; j++ )
			if ( ptr [j].DocId != prevDocId ) {
				prevDocId = ptr [j].DocId;
				lCount++;
			}
        }

	return lCount;
}

long RefCollection :: ReduceRefsBySub ( Base* pbase )
{
	Ref bestRef; bestRef.DocId = 0; bestRef.Sub = 0;
	long bestRefPos = 0;

	for ( long l = 0; l < ItemCount; ) {
		Ref ref = (*this)[l];
		
		if ( ref.DocId == bestRef.DocId ) {
			if ( bestRef.Sub ) ref.Sub = pbase->SubToPara(ref);
			if ( ref.Sub < bestRef.Sub ) {
				atDelete ( l-1 );
				bestRef.Sub = ref.Sub;			
			} else atDelete ( l );
		} else {
			bestRef = ref;
			l++;
		}	
	}
    
	return ItemCount;
}

void	RefCollection :: InheritPress()
{
	//удалить все сабы с INHERITED_BLOCK
	
	for ( int page = 0; page < PageCount; page++ ) {
		Ref	*to  = (Ref *) Pages[ page ];
		Ref	*from= to;
		int aNewCount = 0;
		for ( int i = 0; i < Count[ page ]; i++, from++ ) {
			if ( ! (from->Sub & INHERITED_BLOCK ) ) {
				*to = *from;
				to++;
				aNewCount++;
			}
		}
		Count[ page ] = aNewCount;
	}

	Compact();
}

int RefwReleCollection::Merge (SortedCollection& list) {
	if (list.ItemCount) {
		if (!ItemCount) {
			this->Move (list);
		} else {
			//объединить накопленную коллекцию с новой. Если есть одинаковые документы - взять максимальную релевантность
			RefwReleCollection *newlist = new RefwReleCollection();

			long page1 = 0;
			long page2 = 0;
			long item1 = 0;
			long item2 = 0;

			RefwRele* ptr1 = (RefwRele*) Pages[ page1 ];
			RefwRele* ptr2 = (RefwRele*) list.Pages[ page2 ];

			int	add1 = 0;
			int add2 = 0;

			while ( ptr1 && ptr2 ) {
				if ( ptr1->DocId < ptr2->DocId ) {
					newlist->Collection::Add( ptr1 );
					add1 = 1;
				} else
				if ( ptr1->DocId > ptr2->DocId ) {
					newlist->Collection::Add( ptr2 );
					add2 = 1;
				} else {
					if ( ptr1->Rele > ptr2->Rele ) {
						newlist->Collection::Add( ptr1 );
					} else {
						newlist->Collection::Add( ptr2 );
					}
					add1 = 1;
					add2 = 1;
				}

				if ( add1 ) {
					add1 = 0;
					ptr1++;
					if ( ++item1 == Count[ page1 ] ) {
						if ( ++page1 == PageCount )
							ptr1 = 0;
						else {
							ptr1 = (RefwRele*) Pages[ page1 ];
							item1 = 0;
							if (!Count [page1])
								ptr1 = 0;
						}
					}
				}
				if ( add2 ) {
					add2 = 0;
					ptr2++;
					if ( ++item2 == list.Count[ page2 ] ) {
						++page2;
						if ( page2 == list.PageCount )
							ptr2 = 0;
						else {
							ptr2 = (RefwRele*) list.Pages[ page2 ];
							item2 = 0;
							if (!list.Count [page2])
								ptr2 = 0;
						}
					}
				}
			}
			while ( ptr1 ) {
				newlist->Collection::Add( ptr1 );
				ptr1++;
				if ( ++item1 == Count[ page1 ] ) {
					if ( ++page1 == PageCount )
						ptr1 = 0;
					else {
						ptr1 = (RefwRele*) Pages[ page1 ];
						item1 = 0;
						if (!Count [page1])
							ptr1 = 0;
					}
				}
			}
			while ( ptr2 ) {
				newlist->Collection::Add( ptr2 );
				ptr2++;
				if ( ++item2 == list.Count[ page2 ] ) {
					if ( ++page2 == list.PageCount )
						ptr2 = 0;
					else {
						ptr2 = (RefwRele*) list.Pages[ page2 ];
						item2 = 0;
						if (!list.Count [page2])
							ptr2 = 0;
					}
				}
			}

			this->FreeAll ();
			this->Move (*newlist);
			delete newlist;
		}
	}

	return 1;
}

long	RefwReleCollection :: DocCount () const
{
	RefwRele   * ptr = 0;
	long lCount = 0;
	long prevDocId = 0;

	for ( int i = 0; i < PageCount; i++ ) {
        	ptr = (RefwRele *) Pages [i];
		for ( int j = 0; j < Count [i]; j++ )
			if ( ptr [j].DocId != prevDocId ) {
				prevDocId = ptr [j].DocId;
				lCount++;
			}
        }

	return lCount;
}

int	RefwReleCollection :: Minus ( SortedCollection& list )
{
	if ( list.Tag () != OT_DOCCOLLECTION )
		return 0;

	if ( list.ItemCount < 1)
		return 1;

	int	page2 = 0;		// processed page in 'list'
	RefwRele   * ptr2  = (RefwRele *) list.Pages [page2];
	long   * ptr22  = (long *) list.Pages [page2];
	
	int	k     = 0;		// index in list's page
	int page;
	for (  page = 0; page < PageCount; page++ )	{// check every page
		RefwRele  * ptr = (RefwRele*) Pages [page];	// pointer to current page
		int i, j;
		for ( i = 0, j = 0; i < Count [page]; i++ ) {
			RefwRele	item = ptr [i];

			while ( ptr22[k] < item.DocId  )
				if ( ++ k >= list.Count [page2] ) {
					if ( ++ page2 >= list.PageCount ) {
						// list ended before end of *this
						// so add all items remaining on page
						for ( ; i < Count [page]; i++ )
							ptr [j++] = ptr [i];

						Count [page] = j;
						goto Compact;
					}

					ptr2 = (RefwRele *) list.Pages [page2];
					ptr22 = (long *) list.Pages [page2];
					k    = 0;
				}

			if ( ptr22[ k ] != item.DocId )
				ptr [j++] = item;
		}

		Count [page] = j;
	}

Compact:
	Compact ();

	return 1;
}

int RefwReleCollection :: Intersect( SortedCollection& list )
{
	if ( list.Tag () != OT_DOCCOLLECTION )
		return 0;
	if ( list.ItemCount < 1){
		this->FreeAll();
		return 1;
	}

	int	page2 = 0;
	int	k     = 0;
	long *atk  = (long*) list.Pages[ page2 ];
	int page;
	for ( page = 0; page < this->PageCount; page++ ) {
		int i, j;
		RefwRele* ati = (RefwRele*) this->Pages[ page ];
		RefwRele* atj = ati;
		for ( i = 0, j = 0; i < this->Count[ page ]; i++, ati++ ) {
			while ( *atk < ati->DocId ) {
				atk++;
				if ( ++k >= list.Count[ page2 ] ) {
					if ( ++page2 >= list.PageCount ) {
						this->Count[ page++ ] = j;
						for ( ; page < this->PageCount; page++ )
							this->Count[ page ] = 0;
						goto Compact;
					}
					k   = 0;
					atk = (long*) list.Pages[ page2 ];
				}
			}

			if ( *atk == ati->DocId ) {
				*atj++ = *ati;
				j++;
			}
		}

		this->Count[ page ] = j;
	}				
Compact:
	this->Compact();

	return 1;
}

int RefwReleCollection::Intersect (DocCollection* list) {
	return RefwReleCollection::Intersect (*list);
}

int CorrRefCollection::Compare (const void * p1, const void * p2) const {
	CorrRef* corr_ref1 = (CorrRef*) p1;
	CorrRef* corr_ref2 = (CorrRef*) p2;
	if (corr_ref1->DocId == corr_ref2->DocId) {
		if (corr_ref1->RealPara < corr_ref2->RealPara) {
				return -1;
		}
		else {
			if (corr_ref1->RealPara > corr_ref2->RealPara) {
				return 1;
			} else {
				return 0;
			}
		}
	} else { 
		if (corr_ref1->DocId < corr_ref2->DocId) {
			return -1;
		} else {
			return 1;
		}

	}
}

void CorrRefCollection::Compact () {
	int page;
	for ( ItemCount = 0, page = 0; page < PageCount; page++ )
		ItemCount += Count [page];

	for ( page = 0; page < PageCount - 1; )
		if ( Count [page] < PageSize / 2 )
			if ( Count [page] + Count [page + 1] <= PageSize )
				Collection :: Merge ( page );
			else
			{
				Collection :: Balance ( page );
				page++;
			}
		else
			page++;
}

int CorrRefCollection::Intersect (SortedCollection& collection) {
    int mode = 1;
	if (collection.ItemCount < 1) {
		FreeAll ();
		return 0;
	}

	if (collection.Tag () == OT_REFCOLLECTION) {
		int	page2 = 0;		// processed page in 'list'
		Ref* collection_ref  = (Ref*) collection.Pages [page2];
		int	k     = 0;		// index in list's page
		int page;
		for (page = 0; page < PageCount; page++ ) {	// check every page
			CorrRef* ptr = (CorrRef*) Pages [page];	// pointer to current page
			int i, j;
			for ( i = 0, j = 0; i < Count [page]; i++ ) {
				Ref	item;
				item.DocId = ptr [i].DocId;
				item.Sub = ptr [i].Block;
				//while (CompRefsPlus (&collection_ref [k],&item) < 0) {
				while (collection_ref [k].DocId < item.DocId) {
					if (++ k >= collection.Count [page2]) {
						if (++page2 >= collection.PageCount) {
							Count [page++] = j;
							for ( ; page < PageCount; page++ )
								Count[page] = 0;
							Compact ();
							return 1;
						}
						collection_ref = (Ref *) collection.Pages [page2];
						k = 0;
					}
				}
				//if (!CompRefsPlus (&collection_ref [k],&item))
				if (collection_ref [k].DocId == item.DocId)
					ptr [j++] = ptr [i];
			}

			Count [page] = j;
		}
	} else if (collection.Tag () == OT_DOCCOLLECTION) {
		int	page2 = 0;		// processed page in 'list'
		long* collection_doc  = (long*) collection.Pages [page2];
		int	k     = 0;		// index in list's page
		int page;
		for (page = 0; page < PageCount; page++ ) {	// check every page
			CorrRef* ptr = (CorrRef*) Pages [page];	// pointer to current page
			int i, j;
			for ( i = 0, j = 0; i < Count [page]; i++ ) {
				Ref	item;
				item.DocId = ptr [i].DocId;
				item.Sub = ptr [i].Block;
				while (collection_doc [k] < ptr [i].DocId) {
					if (++ k >= collection.Count [page2]) {
						if (++page2 >= collection.PageCount) {
							Count [page++] = j;
							for ( ; page < PageCount; page++ )
								Count[page] = 0;
							Compact ();
							return 1;
						}
						collection_doc = (long*) collection.Pages [page2];
						k = 0;
					}
				}
				if (collection_doc [k] == ptr [i].DocId)
					ptr [j++] = ptr [i];
			}

			Count [page] = j;
		}
	}

	Compact ();
	return 1;
}

int CorrRefCollection::IsSect (SortedCollection& collection) {
	if ( collection.ItemCount < 1 || ItemCount < 1 ) return 0;

	int	page2 = 0;		// processed page in 'list'
	Ref* collection_ref  = (Ref*) collection.Pages [page2];

	int	k = 0;		// index in list's page
	int page;

	for ( page = 0; page < PageCount; page++ ) {	// check every page
		CorrRef* ptr = (CorrRef*) Pages [page];	// pointer to current page
		int i;
		for (i = 0; i < Count [page]; i++) {
			int iRes;
			Ref	item;
			item.DocId = ptr [i].DocId;
			item.Sub = ptr [i].Block;
			while ((iRes = CompRefs (collection_ref + k, &item)) < 0) {
				if (++ k >= collection.Count [page2]) {
					if (++page2 >= collection.PageCount) {
						return 0;
					}
					collection_ref  = (Ref*) collection.Pages [page2];
					k = 0;
				}
			}
            if (!iRes)
				return 1;
		}
	}
	return 0;
}

long CorrRefCollection::DocCount () const {
	CorrRef* ptr = 0;
	long lCount = 0;
	long prevDocId = 0;

	for (int i = 0; i < PageCount; ++i) {
		ptr = (CorrRef *) Pages [i];
		for (int j = 0; j < Count [i]; ++j)
			if (ptr [j].DocId != prevDocId) {
				prevDocId = ptr [j].DocId;
				++lCount;
			}
	}

	return lCount;
}

int	CorrRefCollection :: Minus ( SortedCollection& list )
{
	if ( list.Tag () != OT_DOCCOLLECTION )
		return 0;

	if ( list.ItemCount < 1)
		return 1;

	int	page2 = 0;		// processed page in 'list'
	CorrRef   * ptr2  = (CorrRef*) list.Pages [page2];
	long   * ptr22  = (long *) list.Pages [page2];
	
	int	k     = 0;		// index in list's page
	int page;
	for (  page = 0; page < PageCount; page++ )	{// check every page
		CorrRef * ptr = (CorrRef*) Pages [page];	// pointer to current page
		int i, j;
		for ( i = 0, j = 0; i < Count [page]; i++ ) {
			CorrRef	item = ptr [i];

			while ( ptr22[k] < item.DocId  )
				if ( ++ k >= list.Count [page2] ) {
					if ( ++ page2 >= list.PageCount ) {
						// list ended before end of *this
						// so add all items remaining on page
						for ( ; i < Count [page]; i++ )
							ptr [j++] = ptr [i];

						Count [page] = j;
						goto Compact;
					}

					ptr2 = (CorrRef*) list.Pages [page2];
					ptr22 = (long *) list.Pages [page2];
					k    = 0;
				}

			if ( ptr22[ k ] != item.DocId )
				ptr [j++] = item;
		}

		Count [page] = j;
	}

Compact:
	Compact ();

	return 1;
}

int RefwWeightCollection :: Intersect (SortedCollection* list) 
{
     int mode;
     if ( list->Tag () == OT_DOCCOLLECTION ) mode = 0;
     else if ( list->Tag () == OT_REFCOLLECTION ) mode = 1;
	 else if (list->Tag () == OT_REFWEIGHTCOLLECTION) mode = 2;
     else return 0;

	if ( list->ItemCount < 1 ){
		FreeAll ();
		return 0;
	}

	int	page2 = 0;		// processed page in 'list'
	Ref   * ptr2  = (Ref *) list->Pages [page2];
	RefwWeight   * ptr2w  = (RefwWeight*) list->Pages [page2];
    long  * ptr22 = (long*) list->Pages [page2];

	int	k     = 0;		// index in list's page
	int page;
	for ( page = 0; page < PageCount; page++ ) {	// check every page
		RefwWeight  * ptr = (RefwWeight*) Pages [page];	// pointer to current page
		int i, j;
		for ( i = 0, j = 0; i < Count [page]; i++ ) {
			RefwWeight	item = ptr [i];

			while ( mode ? CompRefsPlus(mode == 2 ? (Ref*) &ptr2w[k] : &ptr2[k],(Ref*) &item)<0 : ptr22[k]<item.DocId )
				if ( ++ k >= list->Count [page2] ) {
					if ( ++ page2 >= list->PageCount ) {
						Count [page++] = j;
						for ( ; page < PageCount; page++ )
							Count[page] = 0;
						goto Compact;
					}
					ptr2 = (Ref *) list->Pages [page2];
					ptr2w = (RefwWeight *) list->Pages [page2];
                    ptr22 = (long*) list->Pages [page2];
					k    = 0;
				}

			if ( mode ? !CompRefsPlus(mode == 2 ? (Ref*) &ptr2w[k] : &ptr2[k], (Ref*) &item) : ptr22[k]==item.DocId)
				ptr [j++] = item;
		}

		Count [page] = j;
	}

Compact:
	for ( ItemCount = 0, page = 0; page < PageCount; page++ )
		ItemCount += Count [page];

	return 1;
}

int RefwWeightCollection :: Intersect (SortedCollection& list) 
{
	if (this->Intersect (&list)) {
		this->Compact ();
		return 1;
	}
	return 0;
}


int	RefwWeightCollection :: Minus ( SortedCollection& list )
{
	int mode;
     	if ( list.Tag () == OT_DOCCOLLECTION ) mode = 0;
     	else if ( list.Tag () == OT_REFCOLLECTION ) mode = 1;
     	else return 0;

	if ( list.ItemCount < 1 )
		return 1;

	int	page2 = 0;		// processed page in 'list'
	Ref   * ptr2  = (Ref *) list.Pages [page2];
	long   * ptr22  = (long *) list.Pages [page2];
	
	int	k     = 0;		// index in list's page
	int page;
	for (  page = 0; page < PageCount; page++ )	// check every page
	{
		RefwWeight  * ptr = (RefwWeight*) Pages [page];	// pointer to current page
		int i, j;
		for ( i = 0, j = 0; i < Count [page]; i++ ) {
			RefwWeight	item = ptr [i];
			Ref atitem = {item.DocId, item.Sub};

			while ( mode ? Compare(&ptr2[k],&atitem)<0 : ptr22[k] < item.DocId  )
				if ( ++ k >= list.Count [page2] ) {
					if ( ++ page2 >= list.PageCount ) {		// list ended before end of *this
							// so add all items remaining on page
						for ( ; i < Count [page]; i++ )
							ptr [j++] = ptr [i];

						Count [page] = j;
						goto Compact;
					}

					ptr2 = (Ref *) list.Pages [page2];
					ptr22 = (long *) list.Pages [page2];
					k    = 0;
				}

			if ( mode ? Compare( &ptr2[ k ], &atitem ) : ptr22[ k ] != item.DocId )
				ptr [j++] = item;
		}

		Count [page] = j;
	}

Compact:
	Compact ();

	return 1;
}

