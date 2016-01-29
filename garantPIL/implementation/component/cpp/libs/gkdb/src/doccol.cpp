/*
 * $Id: doccol.cpp,v 2.46 2015/07/20 11:15:58 young Exp $
 */
//
// Collection of doc Id's ( long )
// Supports adding, deleting items,
// merging & intersection of collections
//
// Author : Alex V. Boreskoff
//

/*
#if defined(unix) || defined(__CYGWIN32__) || defined(_WINDOWS) || defined(WIN32) || defined(__WIN32__)
	#include <stdlib.h>
#else
	#include        <mem.h>
	#include        "malloc.h"
#endif
*/

#include "osdep.h"
#include "check.h"
#include "doccol.h"
#include "gardefs.h"

#include <cstdlib>


int MemoryError ();

int     DocCollection :: Compare ( const void * p1, const void * p2 ) const
{
	long    l1 = *(long *) p1;
	long    l2 = *(long *) p2;

        if ( l1 < l2 )
                return -1;
        else
        if ( l1 > l2 )
                return 1;
        else
                return 0;
}

int     DocCollection :: Merge ( SortedCollection& list )
{
#if !defined(__WIN16__) && !defined(__DOS16__)
	if ( !list.ItemCount )
		return 1;

	if ( ItemCount / list.ItemCount < insertBalance ) {
		if ( list.Tag() == OT_DOCCOLLECTION ) {
			DocCollection *result = new DocCollection();

			long	page1 = 0;
			long	page2 = 0;
			long	item1 = 0;
			long	item2 = 0;

			long*	ptr1 = ItemCount ? (long*) Pages[ page1 ] : 0;
			long*	ptr2 = (long*) list.Pages[ page2 ];

			int	add1 = 0;
			int add2 = 0;

			while ( ptr1 && ptr2 ) {
				if ( *ptr1 < *ptr2 ) {
					result->Collection::Add( ptr1 );
					add1 = 1;
				} else
				if ( *ptr1 > *ptr2 ) {
					result->Collection::Add( ptr2 );
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
							ptr1 = (long*) Pages[ page1 ];
							item1 = 0;
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
							ptr2 = (long*) list.Pages[ page2 ];
							item2 = 0;
						}
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
						ptr1 = (long*) Pages[ page1 ];
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
						ptr2 = (long*) list.Pages[ page2 ];
						item2 = 0;
					}
				}
			}

			FreeAll();
			Move( *result );
			delete result;

			return 1;
		} else
		if ( list.Tag() == OT_REFCOLLECTION || list.Tag () == OT_PARASCOLLECTION) {
			DocCollection *result = new DocCollection(PageSize);

			long	page1 = 0;
			long	page2 = 0;
			long	item1 = 0;
			long	item2 = 0;

			long*	ptr1 = ItemCount ? (long*) Pages[ page1 ] : 0;
			Ref*	ptr2 = (Ref*) list.Pages[ page2 ];

			int	add1 = 0;
			int add2 = 0;

			while ( ptr1 && ptr2 ) {
				if ( *ptr1 < ptr2->DocId ) {
					result->Collection::Add( ptr1 );
					add1 = 1;
				} else
				if ( *ptr1 > ptr2->DocId ) {
					result->Collection::Add( &ptr2->DocId );
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
							ptr1 = (long*) Pages[ page1 ];
							item1 = 0;
						}
					}
				}
				if ( add2 ) {
					long docid = ptr2->DocId;
					add2 = 0;
				nextitem:
					ptr2++;
					if ( ++item2 == list.Count[ page2 ] ) {
						if ( ++page2 == list.PageCount )
							ptr2 = 0;
						else {
							ptr2 = (Ref*) list.Pages[ page2 ];
							item2 = 0;
						}
					}
					if (ptr2 && ptr2->DocId == docid)
						goto nextitem;
				}
			}
			while ( ptr1 ) {
				result->Collection::Add( ptr1 );
				ptr1++;
				if ( ++item1 == Count[ page1 ] ) {
					if ( ++page1 == PageCount )
						ptr1 = 0;
					else {
						ptr1 = (long*) Pages[ page1 ];
						item1 = 0;
					}
				}
			}
			while ( ptr2 ) {
				long docid = ptr2->DocId;
				result->Collection::Add( &docid );
			nextitem2:
				ptr2++;
				if ( ++item2 == list.Count[ page2 ] ) {
					if ( ++page2 == list.PageCount )
						ptr2 = 0;
					else {
						ptr2 = (Ref*) list.Pages[ page2 ];						
						item2 = 0;
					}
				}
				if (ptr2 && ptr2->DocId == docid)
					goto nextitem2;
			}

			FreeAll();
			Move( *result );
			delete result;

			return 1;
		} else if (list.Tag() == OT_RELESUBCOLLECTION || list.Tag () == OT_RELECOLLECTION) {
			DocCollection *result = new DocCollection(PageSize);

			long	page1 = 0;
			long	page2 = 0;
			long	item1 = 0;
			long	item2 = 0;

			long*	ptr1 = ItemCount ? (long*) Pages[ page1 ] : 0;
			RefwRele*	ptr2 = (RefwRele*) list.Pages[ page2 ];

			int	add1 = 0;
			int add2 = 0;

			while ( ptr1 && ptr2 ) {
				if ( *ptr1 < ptr2->DocId ) {
					result->Collection::Add( ptr1 );
					add1 = 1;
				} else
				if ( *ptr1 > ptr2->DocId ) {
					result->Collection::Add( &ptr2->DocId );
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
							ptr1 = (long*) Pages[ page1 ];
							item1 = 0;
						}
					}
				}
				if ( add2 ) {
					long docid = ptr2->DocId;
					add2 = 0;
				nextitem_rele:
					ptr2++;
					if ( ++item2 == list.Count[ page2 ] ) {
						if ( ++page2 == list.PageCount )
							ptr2 = 0;
						else {
							ptr2 = (RefwRele*) list.Pages[ page2 ];
							item2 = 0;
						}
					}
					if (ptr2 && ptr2->DocId == docid)
						goto nextitem_rele;
				}
			}
			while ( ptr1 ) {
				result->Collection::Add( ptr1 );
				ptr1++;
				if ( ++item1 == Count[ page1 ] ) {
					if ( ++page1 == PageCount )
						ptr1 = 0;
					else {
						ptr1 = (long*) Pages[ page1 ];
						item1 = 0;
					}
				}
			}
			while ( ptr2 ) {
				long docid = ptr2->DocId;
				result->Collection::Add( &docid );
			nextitem2_rele:
				ptr2++;
				if ( ++item2 == list.Count[ page2 ] ) {
					if ( ++page2 == list.PageCount )
						ptr2 = 0;
					else {
						ptr2 = (RefwRele*) list.Pages[ page2 ];						
						item2 = 0;
					}
				}
				if (ptr2 && ptr2->DocId == docid)
					goto nextitem2_rele;
			}

			FreeAll();
			Move( *result );
			delete result;

			return 1;
		}
	}
#endif
	for ( int i = 0; i < list.PageCount; i++ ) {
		if ( list.Tag () == OT_DOCCOLLECTION ) {
                	long  * ptr = (long *) list.Pages [i];

					for ( int j = 0; j < list.Count [i]; j++ )
        					if ( !Add ( ptr [j] ) )
                					return MemoryError ();
		} else
		if ( list.Tag () == OT_REFCOLLECTION ) {
					Ref  * ptr = (Ref *) list.Pages [i];

        			for ( int j = 0; j < list.Count [i]; j++ )
                			if ( !Add ( ptr [j].DocId ) )
                        			return MemoryError ();
		}
		else return 0;
    }

	Compact();
    return 1;
}

int     DocCollection :: Intersect ( SortedCollection& list )
{
        return Sect ( list, 1 );        
}

int     DocCollection :: Minus ( SortedCollection& list )
{
        return Sect ( list, 0 );
}

int     DocCollection :: LoadRefs (DBCore::Store * str) {
        FreeAll ();

        long    LastId   = -1l;                 // last document added
        long	RefCount = str -> Length () / sizeof ( Ref );
        Ref     ref;

        for ( long i = 0; i < RefCount; i++ )
        {
                if ( str -> Read ( &ref, sizeof ( ref ) ) != sizeof ( ref ) )
                        return 0;

                if ( ref.DocId == LastId )      // this doc already added
                        continue;

                if ( !Add ( LastId = ref.DocId ) )
                        return 0;
        }

        return 1;
}

int     DocCollection :: FastLoadRefs (DBCore::Store * str) {
	FreeAll ();

	if (str && str->Length ()) {
		Ref *refs = new Ref [PageSize], *refs_item = refs;
		long refs_maxcount = str->Read (refs, PageSize << 3) >> 3, refs_count = 0, count = 0, id, prev_id = -1, *item = (long*) (Pages [0] = AllocPage ());
		for (;;) {
			if ((id = refs_item->DocId) != prev_id) {
				prev_id = id;
				ItemCount++;			
				if (count == PageSize) {
					Count [PageCount++] = count;
					count = 0;
					item = (long*) (Pages [PageCount] = AllocPage ());
				}
				*item = id;
				count++;
				item++;
			}
			if (++refs_count == refs_maxcount) {
				refs_maxcount = str->Read (refs, PageSize << 3) >> 3;
				if (refs_maxcount == 0)
					break;
				refs_item = refs;
				refs_count = 0;
			} else {
				refs_item++;
			}
		}
		Count [PageCount++] = count;
		delete []refs;
	}
		
	return 1;
}

int     DocCollection :: FastLoadRefWeights (DBCore::Store * str) {
	FreeAll ();

	if (str && str->Length ()) {
		RefwWeight *refs = new RefwWeight [PageSize], *refs_item = refs;
		long refs_maxcount = str->Read (refs, PageSize * sizeof (RefwWeight)) / sizeof (RefwWeight), refs_count = 0, count = 0, id, prev_id = -1, *item = (long*) (Pages [0] = AllocPage ());
		for (;;) {
			if ((id = refs_item->DocId) != prev_id) {
				prev_id = id;
				ItemCount++;			
				if (count == PageSize) {
					Count [PageCount++] = count;
					count = 0;
					item = (long*) (Pages [PageCount] = AllocPage ());
				}
				*item = id;
				count++;
				item++;
			}
			if (++refs_count == refs_maxcount) {
				refs_maxcount = str->Read (refs, PageSize * sizeof (RefwWeight)) / sizeof (RefwWeight);
				if (refs_maxcount == 0)
					break;
				refs_item = refs;
				refs_count = 0;
			} else {
				refs_item++;
			}
		}
		Count [PageCount++] = count;
		delete []refs;
	}
		
	return 1;
}

int     DocCollection :: Sect ( SortedCollection& list, int doSect )
{
	int     page2 = 0;								// processed page in 'list'
	int     k     = 0;								// index in list's page

	if ( list.ItemCount < 1 ) {
		if ( doSect ) FreeAll ();
		return 1;
	}

	int isDoc;
	if ( list.Tag () == OT_DOCCOLLECTION )
		isDoc = 1;
	else
	if ( list.Tag () == OT_REFCOLLECTION )
		isDoc = 0;
	else
	if (list.Tag () == OT_REFWEIGHTCOLLECTION )
		isDoc = 2;
	else
	{
		OkBox ( "Collection Work Fault", "Unknown data type for DocCollection::Sect" );
		return 0;
	}

	for ( int page = 0; page < PageCount; page++ ){	// check every page
		long   * curPage = (long *) Pages [page];
		int i, j;
		for (i = 0, j = 0; i < Count [page]; i++ ){
			long    item = curPage [i];
			long  * docPtr  = (long *) list.Pages [page2];
			Ref   * refPtr  = (Ref *) docPtr;
			RefwWeight *refwPtr = (RefwWeight*) docPtr;
			int     cnt  = list.Count [page2];
			
			while ( isDoc == 1 ? docPtr[k] < item : (isDoc == 2 ? refwPtr[k].DocId < item : refPtr[k].DocId < item)) if ( ++k >= cnt ){
				if ( ++page2 >= list.PageCount ){	// no more elements in this collection					
					if ( doSect ) {					// if it's an intersection then						
						for ( i = page + 1; i < PageCount; i++ ) 
							free ( Pages [i] );     // remove all pages after current page						
						PageCount = page + 1;		// adjust page count
					} else {
						for ( ; i < Count[page]; i++, j++ )
							curPage [j] = curPage [i];
					}
					Count [page] = j;				// set current page item count
					goto Compact;					// only now can go compacting
				}
				k   = 0;
				refPtr = (Ref*) (docPtr = (long *) list.Pages [page2]);
				cnt = list.Count [page2];
			}
			if ( doSect ) {
				// intersect
				if ( isDoc == 1 ? docPtr[k]==item : (isDoc == 2 ? refwPtr[k].DocId==item : refPtr[k].DocId==item) )
					curPage [j++] = item;// item was found then keep the item				
			} else {
				// minus
				if ( isDoc == 1 ? docPtr[k]!=item : (isDoc == 2 ? refwPtr[k].DocId!=item || refwPtr[k].Sub : refPtr[k].DocId!=item || refPtr[k].Sub))
					curPage [j++] = item;		// if it's not equal or not whole doc
												// keep the item
			}
		}
		Count [page] = j;
	}
Compact:
	Compact ();
	return 1;
}

void    DocCollection :: Compact ()
{
	ItemCount = 0;
	int page;
	for ( page = 0; page < PageCount; page++ )
		ItemCount += Count [page];

	for ( page = 0; page < PageCount - 1; )
		if ( Count [page] <= PageSize / 2 )
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

	heap ();
}

/*
int DocCollection :: Intersect( Store* str )
{
	long aCount = str->Length() / sizeof( long );

	long* aDocs = new long[ DOC_PAGE_SIZE ];

	//прочитать первые данные
	long aToRead = min( aCount, DOC_PAGE_SIZE );
	str -> Read( aDocs, aToRead * sizeof( long ));
	aCount -= aToRead;
	int	k = 0;

	for ( int page = 0; page < PageCount; page++ ) {
		long* ptr = (long*) Pages[ page];
		int i, j;
		for ( i = 0, j = 0; i < Count[ page ]; i++ ) {
			long item = ptr[ i ];
			while ( aDocs[ k ] < item )
				if ( ++k > aToRead ) {
					if ( !aCount ) {
						//больше читать нечего 
						Count[ page++ ] = j;
						for ( ; page < PageCount; page++ )
							Count[ page ] = 0;
						goto Compact;
					}

					//читаем новую порцию
					aToRead = min( aCount, DOC_PAGE_SIZE );
					str -> Read( aDocs, aToRead * sizeof( long ));
					aCount -= aToRead;
					k = 0;
				}

            if ( aDocs[ k ] == item )
				ptr[ j++ ] = item;
		}
		Count[ page ] = j;
	}

Compact:
    Compact();
	delete aDocs;
	return 1;
}
*/

bool	DocCollection :: IsSect (DocCollection* list)
{
	if (0 == list->ItemCount || 0 == ItemCount)
		return false;
	int src_page = 0, list_page = 0, src_count = 0, list_count = 0;
	int src_maxcount = Count [src_page], list_maxcount = list->Count [list_page];
	long *src_item = (long*) Pages [src_page], *list_item = (long*) list->Pages [list_page];
	for (;;) {
		if (*src_item == *list_item)
			return true;
		else
		if (*src_item < *list_item) {
			src_count++;
			if (src_count == src_maxcount) {
				if (++src_page == PageCount)
					return false;
				src_item = (long*) Pages [src_page];
				src_maxcount = Count [src_page];
				src_count = 0;
			} else {
				src_item++;
			}
		} else {
			list_count++;
			if (list_count == list_maxcount) {
				if (++list_page == list->PageCount)
					return false;
				list_item = (long*) list->Pages [list_page];
				list_maxcount = list->Count [list_page];
				list_count = 0;
			} else {
				list_item++;
			}
		}	
	}
	return false;
}
