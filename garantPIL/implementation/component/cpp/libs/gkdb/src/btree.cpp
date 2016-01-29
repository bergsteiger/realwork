//
// Implementation of standart B-tree with fixed-sized keys
// Author : Alex V. Boreskoff
//
// Structure of page
// ( int RecCount, long Ref0 ), ( ( key1, Ref1 ), ( key2, Ref2 ), ... )
//
// where keyn has size of KeyLength, size of Refn is sizeof ( long )
//
#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
	#include "../../../Garant/Datastore/NdtClone/Common/btree.cpp"
#else
#include "osdep.h"
#include "check.h"
#include "btree.h"

/*
#if !defined(unix) && !defined(__CYGWIN32__) && !defined(_WINDOWS) && !defined(WIN32) && !defined(__WIN32__)
	#include    <mem.h>
#endif
*/

BTree :: BTree ()
{
	memset(Stack, 0, sizeof( *Stack ) * GKDB::BT_MAXDEPTH);
}
void BTree :: init (PagedFile *pf, BTInit  *init)
{
	file = pf;
	Sp   = 0;
	Flags     = 0;

	if ( init ){
		Root      = init->Root;
		Order     = init->Order;
		KeyLength = init->KeyLength;
		KeyCount  = init->KeyCount;
		Height    = init->Height;
		LastId    = init->LastId;
	}else{
		Root = -1l;                     // set evidently an illegal value
	}
}

BTree :: ~BTree ()
{
	if( !(file->m_mode & (~0x3000)) && file->IsOk() ){
		free_read_only_bufs_on_BTStack();
	}
}
void BTree :: shutdown (BTInit *i)
{
	i->Root      = Root;
	i->Order     = Order;
	i->KeyLength = KeyLength;
	i->KeyCount  = KeyCount;
	i->Height    = Height;
	i->LastId    = LastId;

}
/*
void    BTree :: PrintPage ( long page )
{
        void * buf = file -> AllocBuf ();

        assert ( buf != 0 );

        file -> GetPage ( page, buf );

        printf ( "\nPage %ld = { %ld", page, GetRef0 ( buf ) );

        for ( int i = 0; i < GetCount ( buf ); i++ )
                printf ( "(%s,%ld)", RecOffs ( buf, i ), GetRef ( buf, i ) );

        printf ( "}" );

        if ( GetRef0 ( buf ) != 0l )
                PrintPage ( GetRef0 ( buf ) );

        for ( i = 0; i < GetCount ( buf ); i++ )
                if ( GetRef ( buf, i ) != 0l )
                        PrintPage ( GetRef ( buf, i ) );

        file -> FreeBuf ( buf );
}

void    BTree :: PrintTree ()
{
        printf ( "\Order = %d Height = %d", Order, Height );
        PrintPage ( Root );
}
*/
void    BTree :: Create ( short key_len )
{
        void  * buf = file -> AllocBuf ();

        Root      = file -> NewPage ();
        KeyCount  = 0;
        Height    = 1;
        LastId    = 0l;
        KeyLength = key_len;
        Order     = ( file -> PageSize - 6 ) / ( 2 * ( KeyLength + 4 ) );

        assert ( buf != 0 );
        assert ( Root != -1l );

        file -> PutPage ( Root, buf );
        file -> FreeBuf ( buf );
}

int     BTree :: Compare ( BTKEY key1, BTKEY key2 ) const
{
        return strcmp ( (char *) key1, (char *) key2 );
}

void BTree :: free_read_only_bufs_on_BTStack()
{
	BTStack *pStackF= Stack;
	while(pStackF->buf){
		if(Flags & PF_MODIFIED)
			if(!file->PutPage(pStackF->Page, pStackF->buf))
				abort();
		free(pStackF->buf);
		pStackF->buf= 0;
		pStackF++;
	}
}

int     BTree :: LocateKey ( BTKEY key, void * buf, int& no, long& Page )
{
	int Result= GKDB::BT_NONE;
	if((file->m_mode & (~0x3000))){
		if(!(file->m_mode & (~(0x3000|GKDB::BT_GO_TO_ROOT))) && Stack[0].buf)
			free_read_only_bufs_on_BTStack();

        int     comp   = 1;             // so when no keys comp != 0
        char  * keyPtr;
		
        Page = Root;                    // start at the root of the tree
		
        if ( Sp >= 2 )
        {
			Sp--;
			do
			Sp--;
			while ( Sp >= 0 && !CheckCache ( key ) );
			
			Page = Stack [++Sp].Page;
		}
		else
			Sp = 0;

		while (Result != GKDB::BT_OK)
		{
			if ( Page == 0l )               // no key
				break;
			
			if ( !file -> GetPage ( Page, buf ) )
			{
				Result = GKDB::BT_ERROR;
				break;
			}
			
			int     count   = GetCount ( buf );
			int     k,l,r;
			
			for ( l = 0, r = count - 1; l <= r; )
			{
				comp = Compare ( key, keyPtr = (char *) RecOffs ( buf, k = ( l + r ) >> 1 ) );
				
				if ( comp <= 0 )
					r = k - 1;
				else
					l = k + 1;
			}
			
			keyPtr = (char *) RecOffs ( buf, no = l );
			
            if ( l >= count ) {
				comp = 1;
			} else comp   = Compare ( key, keyPtr );
			
			Stack [Sp].Page  = Page;
			Stack [Sp].Pos   = l;
			Stack [Sp].Count = count;
			Stack [Sp].buf   = 0;
			
			if ( l < count )
				memcpy ( Stack [Sp].curKey, keyPtr, KeyLength );
			
			if ( l > 0 )
				memcpy ( Stack [Sp].prevKey, keyPtr - RecSize (), KeyLength );
			
			Sp ++;
			
			if ( comp == 0 && no < count )  // key found at valid position
				Result = GKDB::BT_OK;
			else
				Page = * (long *) ( keyPtr - 4 );
        }
		
	}else{
        int     k= Sp ? Sp- 1 : Sp, r, count;             // so when no keys comp != 0
        char  * keyPtr;
		
        Page = Root;                    // start at the root of the tree
		no= 0;

		if(Stack [k].Count && (r= Compare ( key, RecOffs ( Stack [k].buf, Stack [k].Pos ) )) >= 0){
			if(!r){
				no= Stack [k].Pos;
				return GKDB::BT_OK;
			}
			Sp--;
			if(Stack [Sp].Pos + 1 >= Stack [Sp].Count){
				if(Sp){
					Sp--;
					while(Stack [Sp].Pos + 1 >= Stack [Sp].Count){
						if(Sp){
							Sp--;
						}else
							break;
					}
				}
			}else
				no= Stack [Sp].Pos + 1;
			Page = Stack [Sp].Page;
			buf= Stack [Sp].buf;
		}else
			Sp = 0;
		while ( 1 )
		{
			if ( Page == 0l )               // no key
			{
				if(Sp > 1 && !(Flags & GKDB::BT_GO_TO_ROOT)){
					// Last node in Stack !
					Sp = 0;
					Page= Stack [Sp].Page;
					Flags |= GKDB::BT_GO_TO_ROOT;
				}else{
					Flags &= ~GKDB::BT_GO_TO_ROOT;
					return GKDB::BT_NONE;
				}
			}

			if(!Stack [Sp].buf && !(Stack [Sp].buf= malloc(file->PageSize)))
				return GKDB::BT_ERROR;
			
			buf= Stack [Sp].buf;

			if ( Stack [Sp].Page  != Page
					//&& (!(Flags |= PF_MODIFIED) || !file -> PutPage ( Stack [Sp].Page,
					//													Stack [Sp].buf ))
					&& !file -> GetPage ( Page, buf ) )
			{
				return GKDB::BT_ERROR;
			}
			Stack [Sp].Pos	= no;
			Stack [Sp].Page	= Page;
			Stack [Sp].Count = GetCount ( buf );

			count= Stack [Sp].Count - no;
			buf= (char *) RecOffs ( buf, no );
			Stack [Sp].Page  = Page;

			for ( no= 0, r= count - 1; no <= r; )
			{
				Result = Compare ( key, keyPtr= (char *)buf + RecSize () * (k= ( no + r ) >> 1) );

				if(!Result){
					r= -1;
					no= k;
				}else if ( Result < 0 ){
					r = k - 1;
				}else
					no= k + 1;
			}
            if ( no >= count ) {
				keyPtr = (char *)buf + RecSize () * no;
				Result = 1;
			} else{
				if(k != no){
					Result   = Compare ( key, keyPtr = (char *)buf + RecSize () * no );
				}
			}
			if ( Result == 0 && no < count ){  // key found at valid position
				Stack [Sp++].Pos += no;
				Flags &= ~GKDB::BT_GO_TO_ROOT;
				return GKDB::BT_OK;
			}else
				Page = * (long *) ( keyPtr - 4 );

			Sp++;
			no= 0;
        }
        return GKDB::BT_NONE;
	}
	return Result;
}

int     BTree :: FindKey ( BTKEY key, void * rec )
{
        void  * buf = 0;
        long    Page;                           // page where the key is located
        int     no;                             // no. of record with the key
        int     Result;

		if((file->m_mode & (~0x3000))){
			if ( (buf= file -> AllocBuf ()) == 0 )
					return GKDB::BT_NOMEM;
		}
        if ( ( Result = LocateKey ( key, buf, no, Page ) ) == GKDB::BT_OK ){
			if(!(file->m_mode & (~0x3000)))
				return GKDB::BT_OK;
			memmove ( rec, RecOffs ( buf, no ), KeyLength );
		}
		file -> FreeBuf ( buf );

        return Result;
}

int     BTree :: UpdateKey ( BTKEY key )
{
        void  * buf = file -> AllocBuf ();
        long    Page;                           // page where the key is located
        int     no;                             // no. of record with the key
        int     Result;

        if ( buf == 0 )
                return GKDB::BT_NOMEM;

        if ( ( Result = LocateKey ( key, buf, no, Page ) ) == GKDB::BT_OK )
        {
                memmove ( RecOffs ( buf, no ), key, KeyLength );

                file -> PutPage ( Page, buf );
        }
        else
                Result = AddKey ( key );

        file -> FreeBuf ( buf );

        return Result;
}

int     BTree :: AddKey ( BTKEY key )
{
        long    Page = Root;
        int     comp = 1;               // for case of empty tree
        char  * buf;

        if ( Sp >= 2 ) {
                Sp--;
                do
                        Sp--;
                while ( Sp >= 0 && !CheckCache ( key ) );

                Page = Stack [++Sp].Page;
        }
        else
                Sp = 0;

        for ( ; Page != 0l; Sp++ ) {
                Stack [Sp].buf = buf = (char *) file -> AllocBuf ();

                assert ( buf != 0 );

                if ( !file -> GetPage ( Stack [Sp].Page = Page, buf ) ) {
                        for ( int i = Sp; i >= 0 && Stack [i].buf != 0; i-- ) {
                                file -> FreeBuf ( Stack [i].buf );
                                Stack [i].buf = 0;
                        }

                        return GKDB::BT_ERROR;
                }

                int     count   = GetCount ( buf );
                int     k;
                char  * keyPtr;
                int     comp;
				int l,r;
                for ( l = 0, r = count - 1; l <= r; ) {
                        comp = Compare ( key, keyPtr = (char *) RecOffs ( buf, k = ( l + r ) >> 1 ) );

                        if ( comp <= 0 )
                                r = k - 1;
                        else
                                l = k + 1;
                }

                keyPtr = (char *) RecOffs ( buf, l );
                if ( l >= count ) {
					comp = 1;
				} else comp   = Compare ( key, keyPtr );

                Stack [Sp].Page  = Page;
                Stack [Sp].Pos   = l;
                Stack [Sp].Count = count;

                if ( l < count )
                        memcpy ( Stack [Sp].curKey, keyPtr, KeyLength );

                if ( l > 0 )
                        memcpy ( Stack [Sp].prevKey, keyPtr - RecSize (), KeyLength );

				if ( comp == 0 && l < count ) { // key found at valid position
                        for ( int i = Sp; i >= 0 && Stack [i].buf != 0; i-- ) {
                                file -> FreeBuf ( Stack [i].buf );
                                Stack [i].buf = 0;
                        }

                        return GKDB::BT_DUPLICATE;
                }

                Page = * (long *) ( keyPtr - 4 );
        }

        char    cur  [GKDB::BT_MAXKEYLEN + 4];
        char    next [GKDB::BT_MAXKEYLEN + 4];

        memmove ( cur, key, KeyLength );                // cur = (key, 0l )
        * (long *) &cur [KeyLength] = 0l;

        for ( Sp--, comp = 1; Sp >= 0 && comp; Sp-- ) {
                if ( Stack [Sp].buf == 0 ) {
                        Stack [Sp].buf = file -> AllocBuf ();
                        assert ( Stack [Sp].buf != 0 );
                        file -> GetPage ( Stack [Sp].Page, Stack [Sp].buf );
                }

                comp = Insert ( Stack [Sp].buf, Stack [Sp].Pos, cur, next );

                file -> PutPage ( Stack [Sp].Page, Stack [Sp].buf );
                file -> FreeBuf ( Stack [Sp].buf );

                memcpy ( cur, next, RecSize () );
        }

        for ( int i = Sp; i >= 0 && Stack [i].buf != 0; i-- ) {
                file -> FreeBuf ( Stack [i].buf );
                Stack [i].buf = 0;
        }

		if ( comp ) { // split root page
                buf  = (char *) file -> AllocBuf ();
                Page = file -> NewPage ();

                assert ( buf != 0 );
                assert ( Page != -1l );

                SetCount ( buf, 1 );
                PutRec   ( buf, 0, cur );
                SetRef0  ( buf, Root );

                file -> PutPage ( Page, buf );
                file -> FreeBuf ( buf );

                Root   = Page;
                Height ++;
        }

        KeyCount++;
        Flags |= PF_MODIFIED;

        if ( Sp < 0 )
                Sp = 0;

        return GKDB::BT_OK;
}

int     BTree :: DelKey ( BTKEY key )
{
        int     SaveSp;
        long    Page = Root;
//        int     comp;
        char  * keyPtr;
        int     count;

        for ( Sp = 0; ; Sp++ )
        {
                Stack [Sp].buf  = file -> AllocBuf ();
                Stack [Sp].Page = Page;
/*
                if ( Stack [Sp].buf == 0 )
                        ;//printf ( "\nSp = %d", Sp );
*/
                assert ( Stack [Sp].buf != 0 );
                file -> GetPage ( Stack [Sp].Page, Stack [Sp].buf );
/*
                KeyPtr = (char *) RecOffs ( Stack [Sp].buf, 0 );
                Count  = GetCount ( Stack [Sp].buf );

                for ( int i = 0; i < Count; i++, KeyPtr += RecSize () )
                        if ( ( Res = Compare ( key, KeyPtr ) ) <= 0 )
                                break;
*/
                int     k;
                int     comp;

                count = GetCount ( Stack [Sp].buf );
				int l, r;
                for ( l = 0, r = count - 1; l <= r; )
                {
                        comp = Compare ( key, keyPtr = (char *) RecOffs ( Stack [Sp].buf, k = ( l + r ) >> 1 ) );

                        if ( comp <= 0 )
                                r = k - 1;
                        else
                                l = k + 1;
                }

                keyPtr = (char *) RecOffs ( Stack [Sp].buf, l );

                if (l<count) {
                  comp   = Compare ( key, keyPtr );
                }

                if ( comp == 0 && l < count )        // key was found at valid position
                {
                        Stack [Sp].Pos = l;
                        break;
                }
                else
                        Stack [Sp].Pos = l - 1;

                if ( ( Page = * (long *) ( keyPtr - 4 ) ) == 0l )
                {
                        for ( int i = Sp; i >= 0; i-- )
                        {
                                file -> FreeBuf ( Stack [i].buf );
                                Stack [Sp].buf = 0;
                        }

                        return GKDB::BT_NOTFOUND;
                }
        }

        SaveSp = Sp;                                    // save coord's of page containing key

        if ( ( Page = * (long *)( keyPtr - 4 ) ) == 0l )// it's a leaf page
        {
                if ( Stack [Sp].Pos < count - 1 )
                        MovRecs ( Stack [Sp].buf, Stack [Sp].Pos, Stack [Sp].buf, Stack [Sp].Pos + 1, count - Stack [Sp].Pos - 1 );

                SetCount ( Stack [Sp].buf, count - 1 );

                file -> PutPage ( Stack [Sp].Page, Stack [Sp].buf );
        }
        else                            // it's inner node => traverse the tree to leaf
        {
                Page = GetRef ( Stack [Sp].buf, Stack [Sp].Pos - 1 );

                for ( Sp++; Page != 0l; Sp++ )
                {
                        Stack [Sp].buf  = file -> AllocBuf ();

                        file -> GetPage ( Stack [Sp].Page = Page, Stack [Sp].buf );

                        Stack [Sp].Pos = GetCount ( Stack [Sp].buf ) - 1;
                        Page           = GetRef ( Stack [Sp].buf, Stack [Sp].Pos );
                }

                // now we've reached leaf node swap last key with deleted key
                Sp--;
//              SetRef  ( Stack [Sp].buf, Stack [Sp].Pos, GetRef ( Stack [SaveSp].buf, Stack [SaveSp].Pos ) );

                long ref = GetRef ( Stack [SaveSp].buf, Stack [SaveSp].Pos );
                
                MovRecs ( Stack [SaveSp].buf, Stack [SaveSp].Pos, Stack [Sp].buf, Stack [Sp].Pos, 1 );
                SetRef ( Stack [SaveSp].buf, Stack [SaveSp].Pos, ref );
                // remove last item from page

                SetCount ( Stack [Sp].buf, GetCount ( Stack [Sp].buf ) - 1 );

                file -> PutPage ( Stack [Sp].Page,     Stack [Sp].buf );
                file -> PutPage ( Stack [SaveSp].Page, Stack [SaveSp].buf );
        }

        void  * buf2 = file -> AllocBuf ();             // now that key has been removed check for underflow

        assert ( buf2 != 0 );

        for ( ; Sp > 0; Sp-- )
        {
                if ( ( count = GetCount ( Stack [Sp].buf ) ) >= Order )
                        break;
                                // underflow => balance or merge with neighbour page
                int     Pos1  = ( SaveSp != Sp - 1 ? Stack [Sp-1].Pos : Stack [Sp-1].Pos - 1 );
                int     Pos2  = ( Pos1 + 1 < GetCount ( Stack [Sp-1].buf ) ? Pos1 + 1 : Pos1 - 1 );
                long    Page2 = GetRef ( Stack [Sp-1].buf, Pos2 );

                file -> GetPage ( Page2, buf2 );

                if ( count + GetCount ( buf2 ) < Order * 2 )
                        MergePages ( Stack [Sp-1].Page, Stack [Sp-1].buf, Pos1, Stack [Sp].Page, Stack [Sp].buf, Pos2, Page2, buf2 );
                else
                {
                        BalancePages ( Stack [Sp-1].Page, Stack [Sp-1].buf, Pos1, Stack [Sp].Page, Stack [Sp].buf, Pos2, Page2, buf2 );
                        break;
                }

                file -> FreeBuf ( Stack [Sp].buf );

                Stack [Sp].buf = 0;
        }

        file -> FreeBuf ( buf2 );

                                // now check for root page changes
        if ( Sp == 0 )          // we've not breaked => rec was removed from root page
        {
                                // save it
                file -> PutPage ( Stack [0].Page, Stack [0].buf );
                                // check for removing root page
                if ( GetCount ( Stack [0].buf ) < 1 && Height > 1 )
                {
                        Page = Root;
                        Root = GetRef0 ( Stack [0].buf );
                        Height--;

                        file -> DelPage ( Page );
                }
        }

        for ( int i = Sp; i >= 0; i-- )
        {
                file -> FreeBuf ( Stack [i].buf );
                Stack [i].buf = 0;
        }

        KeyCount--;
        Flags |= PF_MODIFIED;

        Sp = 0;

        return GKDB::BT_OK;
}

/*!
	insert record ins_rec in a given page at a postion pos
	if it causes splitting returns non-zero and a key in save_rec
	which should be inserted in parent's page
*/

int     BTree :: Insert ( void * buf, int pos, void * ins_rec, void * save_rec )
{
        short   Count = GetCount ( buf );

        if ( Count < Order * 2 )                // it's possible to insert in current page
        {
                MovRecs  ( buf, pos + 1, buf, pos, Count - pos );
                PutRec   ( buf, pos, ins_rec );
                SetCount ( buf, Count + 1 );

                return 0;                       // no further splitting required
        }

        // splitting required, both pages will have Order keys
        // and one key wil go up ( save_rec )

        void  * new_buf  = file -> AllocBuf ();
        long    new_page = file -> NewPage ();

        assert ( new_buf != 0 );

        if ( pos < Order )              // insert ins_rec in 1st page ( half )
        {
                GetRec  ( buf, Order - 1, save_rec );
                MovRecs ( new_buf, 0, buf, Order, Order );
                MovRecs ( buf, pos + 1, buf, pos, Order - pos );
                PutRec  ( buf, pos, ins_rec );
        }
        else
        if ( pos == Order )             // then this item ( ins_rec ) goes up
        {
                memmove ( save_rec, ins_rec, RecSize () );
                MovRecs ( new_buf, 0, buf, Order, Order );
        }
        else                            // ins_rec goes to 2nd half
        {
                GetRec  ( buf, Order, save_rec );
                MovRecs ( new_buf, 0, buf, Order + 1, pos - Order - 1 );
                PutRec  ( new_buf, pos - Order - 1, ins_rec );
                MovRecs ( new_buf, pos - Order, buf, pos, 2*Order - pos );
        }

        SetCount ( buf, Order );        // both splitters will have Order keys
        SetCount ( new_buf, Order );
        SetRef0  ( new_buf, * (long *)( KeyLength + (char *)save_rec ) );

        * (long *)( KeyLength + (char *)save_rec ) = new_page;

        file -> PutPage ( new_page, new_buf );
        file -> FreeBuf ( new_buf );

        return 1;                       // element went up
}

/*!
	balances page1 and page2 splitting their elements between them 50:50
	Parent [pos1] == page1, Parent [pos2] == page2, pos2 = pos1 +/- 1
	both pages are auto saved on completion
*/

int     BTree :: BalancePages ( long ParentPage, void * ParentBuf, int pos1, long page1, void * buf1, int pos2, long page2, void * buf2 )
{
        if ( pos2 < pos1 )      // swap page1 and page2, so pos2 = pos1+1
        {
                long    tmp1 = page1;
                void  * tmp2 = buf1;
                int     tmp3 = pos1;

                page1 = page2;
                buf1  = buf2;
                pos1  = pos2;
                page2 = tmp1;
                buf2  = tmp2;
                pos2  = tmp3;
        }

        int     Count1    = GetCount ( buf1 );
        int     Count2    = GetCount ( buf2 );
        int     NewCount1 = ( Count1 + Count2 ) / 2;
        int     Delta     = NewCount1 > Count1 ? NewCount1 - Count1 : Count1 - NewCount1;

        if ( NewCount1 == Count1 )
                return GKDB::BT_OK;

        if ( Count1 < Order * 2 )               // use page1 for buffer
        {
                MovRecs ( buf1, Count1, ParentBuf, pos2, 1 );
                SetRef  ( buf1, Count1, GetRef0 ( buf2 ) );

                if ( NewCount1 > Count1 + 1 )   // add Delta recs from page2
                {
                        MovRecs ( buf1,      Count1 + 1, buf2, 0,         Delta - 1 );
                        MovRecs ( ParentBuf, pos2,       buf2, Delta - 1, 1 );
                        MovRecs ( buf2,      0,          buf2, Delta,     Count2 - Delta );
                }
                else
                if ( NewCount1 < Count1 + 1 )   // add Delta recs to page2
                {
                        MovRecs ( buf2, Delta, buf2, 0, Count2 );       // free place
                        MovRecs ( buf2, 0, buf1, NewCount1 + 1, Delta );// add recs from page1
                        MovRecs ( ParentBuf, pos2, buf1, NewCount1, 1 ); // copy rec to parent
                }
                else                            // NewCount1 == Count1 + 1
                {
                        MovRecs ( ParentBuf, pos2, buf2, 0, 1 );
                        MovRecs ( buf2, 0, buf2, 1, Count2 - 1 );
                }
        }
        else                            // page1 is full, page2 is used for buffer
        {
                MovRecs ( buf2, 1, buf2, 0, Count2 );   // free 1 slot
                MovRecs ( buf2, 0, ParentBuf, pos2, 1 );
                SetRef  ( buf2, 0, GetRef0 ( buf2 ) );
                MovRecs ( buf2, Delta-1, buf2, 0, Count2 + 1 ); // free Delta-1 slots
                MovRecs ( buf2, 0, buf1, NewCount1 + 1, Delta-1 );
                MovRecs ( ParentBuf, pos2, buf1, NewCount1, 1 );
        }

        SetRef0  ( buf2, GetRef ( ParentBuf, pos2 ) );
        SetRef   ( ParentBuf, pos2, page2 );
        SetCount ( buf1, NewCount1 );
        SetCount ( buf2, Count1 + Count2 - NewCount1 );

        file -> PutPage ( page1,      buf1 );
        file -> PutPage ( page2,      buf2 );
        file -> PutPage ( ParentPage, ParentBuf );

        return GKDB::BT_OK;
}

/*!
	Merge page1 and page2 into one removing key item from parents' page
	Parent [pos1] == page1, Parent [pos2] == page2, pos2 = pos1 +/- 1
*/

//#pragma argsused
int     BTree :: MergePages ( long ParentPage, void * ParentBuf, int pos1, long page1, void * buf1, int pos2, long page2, void * buf2 )
{
        if ( pos2 < pos1 )      // swap page1 and page2, so pos2 = pos1+1
        {
                long    tmp1 = page1;
                void  * tmp2 = buf1;
                int     tmp3 = pos1;

                page1 = page2;
                buf1  = buf2;
                pos1  = pos2;
                page2 = tmp1;
                buf2  = tmp2;
                pos2  = tmp3;
        }

        int     Count1 = GetCount ( buf1 );
        int     Count2 = GetCount ( buf2 );

        MovRecs  ( buf1, Count1,     ParentBuf, pos2, 1 );      // page1 [count1] = Parent [pos2]
        SetRef   ( buf1, Count1,     GetRef0 ( buf2 ) );
        MovRecs  ( buf1, Count1 + 1, buf2, 0, Count2 );         // append all recs from page2 to page1
                                                                // delete Parent [pos] from parent page
        MovRecs  ( ParentBuf,        pos2, ParentBuf, pos2 + 1, GetCount ( ParentBuf ) - pos2 - 1 );
        SetCount ( buf1,      Count1 + Count2 + 1 );            // adjust record counts
        SetCount ( ParentBuf, GetCount ( ParentBuf ) - 1 );

        file -> PutPage ( ParentPage, ParentBuf );              // save changes in parent's page
        file -> PutPage ( page1, buf1 );                        // save total page
        file -> DelPage ( page2 );                              // no need to save deleted page

        return GKDB::BT_OK;
}
	#if (!(defined(MIN_MEM_CONTEXT)) && !(defined(BRDR32)))
#ifdef MAKE_HDD
	#include "ncpf.h"

	PagedFile *makePagedFile(const char *name, int omode)
	{
		if(!omode){
			class	PFile : public PagedFile
			{
			  public:
				PFile(const char *name) : PagedFile ( name, ACE_OS_O_RDONLY)
				{
				}
				virtual int Delete(int Remove)
				{
					int ret= PagedFile::Delete(Remove);

					if(PageSize != 512 && SystemPageBuf){
						FreeBuf(SystemPageBuf);
						SystemPageBuf= 0;
					}
					return ret;
				}
				virtual	~PFile ()
				{
					this->Delete(0);
				}
			};
			return new PFile(name);
		}
		return new PagedFile(name, omode);
	}
#else
	  // Ѕридера с новым ядром - Ќ≈ реализовано //
#endif
	#endif
#endif