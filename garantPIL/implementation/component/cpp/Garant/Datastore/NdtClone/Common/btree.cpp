//
// Implementation of standart B-tree with fixed-sized keys
// Author : Alex V. Boreskoff
//
// Structure of page
// ( int RecCount, long Ref0 ), ( ( key1, Ref1 ), ( key2, Ref2 ), ... )
//
// where keyn has size of KeyLength, size of Refn is sizeof ( long )
//

//#include "include/osdep.h"

/* GARANT_CROSSP
#if !defined(unix) && !defined(__CYGWIN32__) && !defined(_WINDOWS) && !defined(WIN32) && !defined(__WIN32__)
	#include    <mem.h>
#endif
*/
#include        "../../NdtClone/Common/btree.h"

#include        <cstdlib>
#include        <cstring>
#include        <cstdio>
#include        <cassert>


namespace NdtClone {
BTree :: BTree ()
{
	global_check();
#ifndef WRITE_KEYS_PAGE_INBACKUP
	pWritedPages
#else
	pReadedPages= pBuckupedPages
#endif
		= 0;
	Stack= 0;
	Sp   = 0;
	pNextMemForStacksBuf= 0;
	KeyCount= 0;
	Root= 0;
}

void BTree :: init (PagedFile *pf, BTInit  *init)
{
	fileUpdt = 0;
	file = pf;
	Flags     = 0;

	Order     = 0;
	KeyLength = 0;
	KeyCount  = 0;
	Height    = 0;
	LastId    = 0;
	preRoot   = 0;
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
	if(global_IsBlock())
		return;
}


int BTree :: GetPage(int page, void*buff)
{
	return 1;
}

int BTree :: PutPage(int page, void*buff, int onlyPut)
{
	LOG_E (("abort in BTree :: PutPage"));
	abort();
	return 0;
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

void *BTree :: CreateInfo(short key_len)
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

		return buf;
}

void    BTree :: Create ( short key_len )
{
        PutRootPage( CreateInfo(key_len) );
}

void BTree :: PutRootPage(void  * buf)
{
	LOG_E (("abort in BTree :: PutRootPage"));
	abort();
}

int     BTree :: Compare ( BTKEY key1, BTKEY key2 ) const
{
        return strcmp ( (char *) key1, (char *) key2 );
}

int     BTree :: LocateKey ( BTKEY key, void * buf, int& no, int& Page, int AutoAdd )
{
	int Result= GKDB::BT_NONE;
	int     comp   = 1;             // so when no keys comp != 0

	if(file->m_mode & (~(0x3000 | GKDB::BT_GO_TO_ROOT))){
		if((Result= AddKey ( key, buf, AutoAdd )) == GKDB::BT_DUPLICATE){
			if(AutoAdd != -1){
				Page= Stack[Sp-1].Page;
				no = Stack[Sp-1].Pos;
			}
			if(buf == key){
				memcpy(buf, Stack [Sp-1].curKey, KeyLength);
			}
			return GKDB::BT_OK;
		}else if(Result == GKDB::BT_OK && AutoAdd){
			return GKDB::BT_NONE;
		}
	}else{
        int     k= Sp ? Sp- 1 : Sp, r, count;             // so when no keys comp != 0
        char  * keyPtr;
		
        Page = Root;                    // start at the root of the tree
		no= 0;

		if(Stack [k].Count && (r= Compare ( key, RecOffs ( (Stack [k].buf= cachedPage(Stack [k].Page)), Stack [k].Pos ) )) >= 0){
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
		}else{
			Sp = 0;
			Flags |= GKDB::BT_GO_TO_ROOT;
		}
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
			buf= Stack [Sp].buf= cachedPage(Page);

			Stack [Sp].Pos	= no;
			Stack [Sp].Page	= Page;
			Stack [Sp].Count = GetCount ( buf );

			count= Stack [Sp].Count - no;
			buf= (char *) RecOffs ( buf, no );

			for ( no= 0, r= count - 1; no <= r; )
			{
				keyPtr= (char*)buf + RecSize () * (k= ( no + r ) >> 1);
				Result = Compare ( key, keyPtr );

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
					keyPtr = (char*)buf + RecSize () * no;
					Result   = Compare ( key, keyPtr );
				}
			}
			if ( Result == 0 && no < count ){  // key found at valid position
				Stack [Sp++].Pos += no;
				Flags &= ~GKDB::BT_GO_TO_ROOT;
				return GKDB::BT_OK;
			}else{
				count= Stack [Sp].Pos;
				Stack [Sp].Pos	= no;
				Page = GetNext( keyPtr );
				Stack [Sp].Pos	= count;
			}
			Sp++;
			no= 0;
        }
        return GKDB::BT_NONE;
	}
	return Result;
}

int     BTree :: FindKey ( BTKEY key, void * rec, int AutoAdd )
{
    int    Page;                           // page where the key is located
    int     no;                             // no. of record with the key

	if(!(file->m_mode & (~(0x3000 | GKDB::BT_GO_TO_ROOT)))){
		if(key == rec){
			int ret= LocateKey ( key, 0, no, Page, /*AutoAdd ? AutoAdd : */0 );
			if(ret == GKDB::BT_OK){
				memcpy(rec, RecOffs ( Stack [Sp-1].buf, Stack [Sp-1].Pos ), KeyLength);
			}
			return ret;
		}
		//void  * buf = alloca( file -> PageSize );
		return LocateKey ( key, 0/*buf*/, no, Page, /*AutoAdd ? AutoAdd : */0 );
	}
    return LocateKey ( key, rec, no, Page, AutoAdd ? AutoAdd : 0 );
}

int     BTree :: UpdateKey ( BTKEY key )
{
        int    Page;                           // page where the key is located
        int     no;                             // no. of record with the key
        int     Result;

        if ( ( Result = LocateKey ( key, 0, no, Page, -1 ) ) != GKDB::BT_OK )
			abort();//Result = AddKey ( key );

        return Result;
}

char *	BTree :: PrepareStackBuff( int page, char *cur, void* buf1)
{
	return (char*)(Stack [Sp].buf= cur);
}

int BTree :: LastCompare( BTKEY a, BTKEY b, int preComp)
{
	return Compare(a,b);
}

int     BTree :: AddKey ( BTKEY pFndVal, void * buf1, int AutoAdd )
{
        int    Page = -1;
        int     comp = 1;               // for case of empty tree

		m_key= pFndVal;
		if(buf1 == (void*)-1){
			buf1= (void*)m_key;
			AutoAdd= 1;
			if(Root == -1){
				StartBackupEx();
				Page = Root;
			}
		}else if(Root == -1 && !AutoAdd)
			return GKDB::BT_NONE;
		initCritical();

		char    *keyPtr;

		if(Page != 0l){
		  int	*pC, *pP, k, r, preComp;
		  char *cur= 0;
			do{
			cur=  PrepareStackBuff( Page, 0/*cur*/, 0/*buf1*/ );
			pC= &(Stack [Sp].Count);
			pP= &(Stack [Sp].Pos);
			preComp= 0;
			(*pC)	= GetCount ( cur );
			
			for ( (*pP) = 0, r = (*pC) - 1; (*pP) <= r; )
			{
				comp = Compare ( m_key, keyPtr = (char *) RecOffs ( cur, k = ( (*pP) + r ) >> 1 ) );
				
				if ( comp <= 0 )
					r = k - 1;
				else{
					(*pP) = k + 1;
					preComp++;
				}
			}
			keyPtr = (char *) RecOffs ( cur, (*pP) );
			
			if(comp) {
				if ( (*pP) >= (*pC) ) {
					comp = 1;
				}else
					comp= LastCompare ( m_key, keyPtr, preComp );
			}
			if ( (*pP) > 0 ){
				//if(Stack [Sp].prevKey)
					memcpy ( Stack [Sp].prevKey, keyPtr - RecSize (), KeyLength );
			}
			if ( (*pP) < (*pC) ){
				if ( !comp ){
					UpdateUpKey( AutoAdd, keyPtr, (char*)m_key );
					Sp ++;
					return GKDB::BT_DUPLICATE;
				}
				memcpy ( Stack [Sp].curKey, keyPtr, KeyLength );
				Page= GetNext( keyPtr );
			}else{
				Page= GetNext( keyPtr );
			}
			Sp ++;
		  }while (Page
						//&& (cur += file->PageSize)
													);
		}
		if(!AutoAdd){
			skipCritical();
			return GKDB::BT_NONE;
		}

		/*char    *curZ= (char*)alloca(file->PageSize * Sp);
		Page= Sp;
		while(Page--){
			if(Stack [Page].buf != 0){
				if(Stack [Page].Page > file->curr_last)
					;
				else{
					memcpy(curZ, Stack [Page].buf, file->PageSize);
					Stack [Page].buf= curZ;
					curZ += file->PageSize;
				}
			}
		}*/
		char	*cur1= (char*)alloca(((KeyLength + 4) * 2) + file -> PageSize )
				, *next= cur1 + KeyLength + 4;

		keyPtr= (next + KeyLength + 4);

		PrepareRecord  ( m_key, (char *)buf1 );
		// Init new record //
        memcpy ( cur1, buf1, KeyLength );
		// pointer next page //
        * (int *) &cur1 [KeyLength] = 0l;

        for ( Page= -1, AutoAdd= -1, Sp--, comp = 1; Sp > -1 && comp; Sp-- ){
#ifdef _DEBUG
			if ( Stack [Sp].buf == 0 ){
				PrepareStackBuffWrite();
				comp = Insert ( Stack [Sp].buf, Stack [Sp].Pos, cur1, next );
			}else
#endif
			{
				PrepareStackBuffWrite();
				comp = Insert ( Stack [Sp].buf, Stack [Sp].Pos, cur1, next );
			}
			Stack [Sp].buf= 0;
			if(AutoAdd == -1){
				AutoAdd= 0;
				if(!comp){
					Stack [Sp].buf= (void*)-1;
					Sp--;
					break;
				}else{
					if(Stack [Sp].Pos < Order){
						Page= Stack [Sp].Page;
						AutoAdd= Stack [Sp].Pos;
					}else if(Stack [Sp].Pos == Order){
						AutoAdd= -1;
					}else{
						Page= *(int*)(next+KeyLength);
						AutoAdd= Stack [Sp].Pos - Order - 1;
					}
				}
			}
			memcpy ( cur1, next, RecSize () );
        }
		if ( Sp < 0 ){
			Sp = 0;
			/*if(Stack->Pos < Order){
				Stack [1].buf= (void*)-1;
				Stack [1].Page= Stack->Page;
				Stack [1].Pos= Stack->Pos;
			}*/
		}
		if(Page > 0){
			Stack [Sp+1].buf= (void*)-1;
			Stack [Sp+1].Page= Page;
			Stack [Sp+1].Pos= AutoAdd;
		}
		if ( comp )             // split root page
		{
//#ifndef WITH_NOT_PACK_PAGED_FILE
//			memset(keyPtr, 0, file -> PageSize );
//#endif
			Page = NewPage (keyPtr);
			comp= Stack [Sp].Page;
			keyPtr  = PrepareStackBuff(Page,0,0);
			Stack [Sp].Page= comp;

			SetCount ( keyPtr, 1 );
			PutRec   ( keyPtr, 0, cur1 );
			SetRef0  ( keyPtr, Root );

			Root   = Page;
			Height ++;
		}
		skipCritical();

        KeyCount++;
        Flags |= PF_MODIFIED;

        return GKDB::BT_OK;
}

void *BTree :: DelKey ( BTKEY key )
{
	/*if(*(file->FileName+34) == '_' && *(file->FileName+36) == 'v'){
		LOG_E (("Del key(%d, %d)... (%s)", ((long*)key)[0], ((long*)key)[1], file->FileName+31) );
	}*/
        int     SaveSp ,Page = -1, count, comp= 1;
        char  * keyPtr;
		initCritical();
#ifdef _DEBUG
		int *pNbrsPg= (int *)alloca(4*GKDB::BT_MAXDEPTH), iNbrsPg= 0;
#endif
        for ( Sp = 0; ; Sp++ )
        {
#ifdef _DEBUG
			{
				int tmp_iNbrsPg= iNbrsPg;
				while(tmp_iNbrsPg--){
					if(pNbrsPg[tmp_iNbrsPg] == Page)
					{
						LOG_E (("Cicle Error key(%d, %d)... (%s)", ((long*)key)[0], ((long*)key)[1], file->FileName));
						abort();
					}
				}
				pNbrsPg[iNbrsPg++]= Page;
			}
#endif
				PrepareStackBuff( Page, 0//cur
															, 0//buf1
																		);
                int     k;

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

                if ( l < count && (comp == 0 || (comp   = Compare ( key, keyPtr )) == 0))
                {
                        Stack [Sp].Pos = l;
                        break;
                }
                else
                        Stack [Sp].Pos = l - 1;

                if ( ( Page = * (long *) ( keyPtr - 4 ) ) == 0l )
                {
						skipCritical();
                        return 0;
                }
        }
		void *pRetStrForAfterClose= DeleteUpKey();
		if(pRetStrForAfterClose){
			SaveSp = Sp;                                    // save coord's of page containing key

			PrepareStackBuffWrite();

			if ( ( Page = * (long *)( keyPtr - 4 ) ) == 0l )// it's a leaf page
			{
					if ( Stack [Sp].Pos < count - 1 )
							MovRecs ( Stack [Sp].buf, Stack [Sp].Pos, Stack [Sp].buf, Stack [Sp].Pos + 1, count - Stack [Sp].Pos - 1 );

					SetCount ( Stack [Sp].buf, count - 1 );

					PutPage ( Stack [Sp].Page, Stack [Sp].buf );
			}
			else                            // it's inner node => traverse the tree to leaf
			{
					Page = GetRef ( Stack [Sp].buf, Stack [Sp].Pos - 1 );

					for ( Sp++; Page != 0l; Sp++ )
					{
						if(Stack[Sp].buf && Stack [Sp].Page != Page)
							Stack [Sp].buf= 0;
						Stack [Sp].Page= Page;
						PrepareStackBuffWrite();
						Stack [Sp].Pos = GetCount ( Stack [Sp].buf ) - 1;
						Page           = GetRef ( Stack [Sp].buf, Stack [Sp].Pos );
					}
					// now we've reached leaf node swap last key with deleted key
					Sp--;

					long ref = GetRef ( Stack [SaveSp].buf, Stack [SaveSp].Pos );
	                
					MovRecs ( Stack [SaveSp].buf, Stack [SaveSp].Pos, Stack [Sp].buf, Stack [Sp].Pos, 1 );
					SetRef ( Stack [SaveSp].buf, Stack [SaveSp].Pos, ref );
					// remove last item from page

					SetCount ( Stack [Sp].buf, GetCount ( Stack [Sp].buf ) - 1 );

					PutPage ( Stack [Sp].Page,     Stack [Sp].buf );
					PutPage ( Stack [SaveSp].Page, Stack [SaveSp].buf );
			}
			comp = Sp;
			while(Sp > 0 && GetCount ((keyPtr= (char*)(Stack [Sp].buf))) < Order){
				Page= Stack [Sp].Page;

				Sp--;
				key= PrepareStackBuff(Stack [Sp].Page,0,0);

								// underflow => balance or merge with neighbour page
				int	Pos1= ( SaveSp != Sp ? Stack [Sp].Pos : Stack [Sp].Pos - 1 ),
					Pos2= Pos1 + 1;

				if(Pos2 >= GetCount ( (void*)key ))
					Pos2 -= 2;

				count = Sp;
				Sp= GKDB::BT_MAXDEPTH - 1;
				key = PrepareStackBuff(GetRef( (void*)key, Pos2 ), 0, 0);
				Sp= count;
				count= GKDB::BT_MAXDEPTH - 1;

				if ( GetCount ( keyPtr ) + GetCount ( (void*)key ) < Order * 2 )
				{
					PrepareStackBuffWrite();
					MergePages ( Stack [Sp].buf, Pos1, Page, keyPtr, Pos2, Stack[count].Page, (void*)key );
					Stack[count].buf= 0;
				}else{
					BalancePages ( Pos1, Page, keyPtr, Pos2, Stack[count].Page, (void*)key );
					Stack[count].buf= 0;
					Sp++;
					break;
				}
			}
									// now check for root page changes
			if ( Sp == 0 )          // we've not breaked => rec was removed from root page
			{
									// save it
					PutPage ( Stack->Page, Stack->buf );
									// check for removing root page
					if ( GetCount ( Stack->buf ) < 1 && Height > 1 )
					{
							file -> DelPage ( Root );
							Root = GetRef0 ( Stack->buf );
							Height--;
					}
			}
			Sp= comp;
			skipCritical();
			KeyCount--;
			Flags |= PF_MODIFIED;
			Sp = 0;
		}
		return pRetStrForAfterClose;
}

//
//	insert record ins_rec in a given page at a postion pos
//	if it causes splitting returns non-zero and a key in save_rec
//	which should be inserted in parent's page
//

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
		int Page = NewPage (buf);
		void  * new_buf;
		{
			int zz= Stack [Sp].Page;
			new_buf  = PrepareStackBuff(Page,0,0);
			Stack [Sp].Page= zz;
		}
		*(int*)((char*)new_buf+2)= 0;

		if ( pos < Order )              // insert ins_rec in 1st page ( half )
		{
				GetRec  ( buf, Order - 1, save_rec );
				MovRecs ( new_buf, 0, buf, Order, Order );
				MovRecs ( buf, pos + 1, buf, pos, Order - pos );
				PutRec  ( buf, pos, ins_rec );
		}
		else if ( pos == Order )             // then this item ( ins_rec ) goes up
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
		SetRef0  ( new_buf, * (int *)( KeyLength + (char *)save_rec ) );

		save_rec= (((char *)save_rec) + KeyLength);

		* (int *)save_rec = Page;

		return 1;//PutPage ( * (int *)save_rec, new_buf );
}

//
//	balances page1 and page2 splitting their elements between them 50:50
//	Parent [pos1] == page1, Parent [pos2] == page2, pos2 = pos1 +/- 1
//	both pages are auto saved on completion
//

int     BTree :: BalancePages (int pos1, int page1, void * buf1, int pos2, int page2, void * buf2 )
{
        if ( pos2 < pos1 )      // swap page1 and page2, so pos2 = pos1+1
        {
                int    tmp1 = page1;
                void  * tmp2 = buf1;
                int     tmp3 = pos1;

                page1 = page2;
                buf1  = (void*)buf2;
                pos1  = pos2;
                page2 = tmp1;
                buf2  = tmp2;
                pos2  = tmp3;
        }

        int     Count1    = GetCount ( buf1 );
        int     Count2    = GetCount ( buf2 );
        int     NewCount1 = ( Count1 + Count2 ) / 2;
        int     Delta     = NewCount1 > Count1 ? NewCount1 - Count1 : Count1 - NewCount1;

		if ( NewCount1 != Count1 ){
			PrepareStackBuffWrite();
			void *ParentBuf= alloca(file->PageSize + file->PageSize);
			buf1= memcpy(ParentBuf, buf1, file->PageSize);
			buf2= memcpy(((char*)ParentBuf)+file->PageSize, buf2, file->PageSize);
			ParentBuf= Stack[Sp].buf;
			if ( Count1 < Order * 2 )               // use page1 for buffer
			{
					MovRecs ( buf1, Count1, ParentBuf, pos2, 1 );
					SetRef  ( buf1, Count1, GetRef0 ( buf2 ) );

					if ( NewCount1 > Count1 + 1 ){
						// add Delta recs from page2
						MovRecs ( buf1,      Count1 + 1, buf2, 0,         Delta - 1 );
						MovRecs ( ParentBuf, pos2,       buf2, Delta - 1, 1 );
						MovRecs ( (void*)buf2,      0,          buf2, Delta,     Count2 - Delta );
					}else if ( NewCount1 < Count1 + 1 ){
						  // add Delta recs to page2
						MovRecs ( (void*)buf2, Delta, buf2, 0, Count2 );       // free place
						MovRecs ( (void*)buf2, 0, buf1, NewCount1 + 1, Delta );// add recs from page1
						MovRecs ( ParentBuf, pos2, buf1, NewCount1, 1 ); // copy rec to parent
					}else{
						// NewCount1 == Count1 + 1
						MovRecs ( ParentBuf, pos2, buf2, 0, 1 );
						MovRecs ( (void*)buf2, 0, buf2, 1, Count2 - 1 );
					}
			}else{
				// page1 is full, page2 is used for buffer
				MovRecs ( (void*)buf2, 1, buf2, 0, Count2 );   // free 1 slot
				MovRecs ( (void*)buf2, 0, ParentBuf, pos2, 1 );
				SetRef  ( (void*)buf2, 0, GetRef0 ( buf2 ) );
				MovRecs ( (void*)buf2, Delta-1, buf2, 0, Count2 + 1 ); // free Delta-1 slots
				MovRecs ( (void*)buf2, 0, buf1, NewCount1 + 1, Delta-1 );
				MovRecs ( ParentBuf, pos2, buf1, NewCount1, 1 );
			}
			SetRef0  ( (void*)buf2, GetRef ( ParentBuf, pos2 ) );
			SetRef   ( ParentBuf, pos2, page2 );
			SetCount ( buf1, NewCount1 );
			SetCount ( (void*)buf2, Count1 + Count2 - NewCount1 );

			PutPage ( page1,      buf1 );
			PutPage ( page2,      (void*)buf2 );
			PutPage ( Stack[Sp].Page, ParentBuf );
		}
        return GKDB::BT_OK;
}

//
//	Merge page1 and page2 into one removing key item from parents' page
//	Parent [pos1] == page1, Parent [pos2] == page2, pos2 = pos1 +/- 1
//

//#pragma argsused
int     BTree :: MergePages ( void *ParentBuf, int pos1, int page1, void * buf1, int pos2, int page2, void * buf2 )
{
        if ( pos2 < pos1 )      // swap page1 and page2, so pos2 = pos1+1
        {
                int    tmp1 = page1;
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

		PutPage ( Stack[Sp].Page, ParentBuf );              // save changes in parent's page
        PutPage ( page1, buf1 );                        // save total page
        file -> DelPage ( page2 );                              // no need to save deleted page

        return GKDB::BT_OK;
}

bool BTree :: IsExist( BTKEY key )
{
	if(this->FindKey( key, Stack [GKDB::BT_MAXDEPTH-1].curKey) == GKDB::BT_OK )
		return true;
	return false;
}

} // namespace NdtClone
