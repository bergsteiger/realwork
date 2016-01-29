/*
 * $Id: cntxtcol.cpp,v 2.16 2013/06/05 12:15:10 young Exp $
 */


#include <cstring>
#include <cstdarg>
#include <cstdio>
#include "collect.h"
#include "base.h"
#include "garutils.h"
#include "gardefs.h"
#include "doccol.h"
#include "cntxtcol.h"
#include "Logger.h"
extern Logger logger;

// visualise
extern	void	FlushCreate ( long lFlushingCount, bool bEnglish );
extern	void	FlushDestroy (bool);
extern	void	AddFlushing ( long lCount );
extern	long	totalFlushs;

//#define CTX_CONTROL
//#define CTX_DEBUG
#define CTX_ACSESS_COUNT
//#define CTX_DEBUG_MEM
//#define DEBUG_MEM

#ifdef CTX_CONTROL
        char g_pCtxWord[] = "-IV\0";
#endif
#ifdef CTX_ACSESS_COUNT
        unsigned long g_ulAcsessCount = 0;
#endif

ContextCollection::ContextCollection ( Index* pInd, unsigned long ulMemLimit, bool aEnglish)
	: m_pInd(pInd), m_usIdCount(0), m_usPTabPos(0), m_aInt64SplayMap ( 0 ), 
		m_lCashDoc(0), m_usCashPos(0), m_ulMemLimit(ulMemLimit), m_usInUse ( 1 ), 
		m_usUseReserved(0), m_mapSingleCache(SDC_NEW), m_lSingleCasheDocId(0)
{
	bEnglish = aEnglish;
	canModifyFlush = true;
	OutFunc ( 0, 0 );
}

void ContextCollection::SingleToMain ()
{
	char pWord [ CTX_WORD_SIZE + 1 ];
    pWord [CTX_WORD_SIZE] = 0;

	long tmpId = m_lSingleCasheDocId;
	m_lSingleCasheDocId = 0;

	for ( Point p = m_mapSingleCache.first(); p; m_mapSingleCache.next(p) ) {
		*(u_int64_t*)pWord = m_mapSingleCache.key(p);
		char status = m_mapSingleCache.contents (p);

		if ( status == SDC_ADD ) AddWord ( pWord, tmpId );
		else if ( status == SDC_DEL ) DelWord ( pWord, tmpId );
    }
    
    m_mapSingleCache.clear ();
}

void ContextCollection::StartSingleDocCaching ( long docId )
{
	if ( m_lSingleCasheDocId != docId ) 
		SingleToMain ();
		
	m_lSingleCasheDocId = docId;
}

int ContextCollection::SingleDocCaching ( const char* pWord, long lDocId, char op )
{
	if ( lDocId != m_lSingleCasheDocId ) {
		SingleToMain ();
		return 0;
	}

	char status = m_mapSingleCache[*(u_int64_t*) pWord];
	switch ( status ) {
	case SDC_NEW :
		m_mapSingleCache[*(u_int64_t*) pWord] = op;
		break;
	case SDC_ADD :
		if ( op != SDC_ADD ) m_mapSingleCache[*(u_int64_t*) pWord] = SDC_EMPTY;
		break;
	case SDC_DEL :
		if ( op != SDC_DEL ) m_mapSingleCache[*(u_int64_t*) pWord] = SDC_EMPTY;
		break;
	case SDC_EMPTY :
		break;		
	default :
		logger.printf ( lt_error, "ContextCollection::SingleDocCaching: Unknown SDC status (%d)\n", status );
	}
	return 1;
}

int     ContextCollection :: AddWord ( char * pWord, long lDocId )
{
	unsigned short usPrevInUse = m_usInUse;
	m_usInUse = 1;	

	if ( m_lSingleCasheDocId ) {
		if ( SingleDocCaching ( pWord, lDocId, SDC_ADD ) )
			return OutFunc ( 1, usPrevInUse );			
	}
 
        #ifdef CTX_ACSESS_COUNT
               g_ulAcsessCount++;
        #endif

L_RESTART :    

        unsigned short i = m_usCashPos;
        
        if ( lDocId != m_lCashDoc )
            for ( i = 1; i <= m_usIdCount; i++ )
                if ( m_pIdList [i] == lDocId )
                {
                    m_lCashDoc = lDocId;
                    m_usCashPos = i;
                    break;
                }

        if ( i > m_usIdCount ) i = RegisterId ( lDocId );

        unsigned short usMapPos = m_aInt64SplayMap [ *(u_int64_t*) pWord ];
        
        if ( usMapPos ) // key found
        {
             if ( (usMapPos & M_SM_ITEM_TYPE) == SM_ITEM_SINGLE )    // Item have one doc yet
             {                                                       // (means position in DocsArray)
                 if ( i == (usMapPos & M_SM_DOC_POS) )                 
					 return OutFunc ( 1, usPrevInUse );                        // docs seams
                 else                                                // docs different move into PosTable
                 {
                     if ( m_usPTabPos >= POS_TAB_SIZE )
                     {
                         logger.printf( "Index %s : PosTable overflow (m_usPTabPos=%ud, usMapPos=%x)\n", 
							 m_pInd->Name, m_usPTabPos, usMapPos );

						 Flush ();
                         goto L_RESTART;
                     }
                     m_pPosTable [ m_usPTabPos ] = (unsigned short*) malloc ( sizeof(unsigned short)*2 );
		     assert ( m_pPosTable [ m_usPTabPos ] );

                     m_pPosTable [ m_usPTabPos ][0] = (usMapPos & M_SM_DOC_POSTYPE) | SM_TAB_NEXT;
                     m_pPosTable [ m_usPTabPos ][1] = i | SM_DOC_ADD;
                     
                     usMapPos = SM_ITEM_MULTI | m_usPTabPos++;
                     m_aInt64SplayMap [ *(u_int64_t*) pWord ] = usMapPos;
                 }
             }
             else                                               // Item have multi doc 
             {                                                  // (means position in PosTable)
                 unsigned short* pPos = m_pPosTable [usMapPos & M_SM_TAB_POS];

                 unsigned short us = 0;
                 do
                 {
                     if ( i == (pPos[us] & M_SM_DOC_POS) )
			return OutFunc ( 1, usPrevInUse );              // docs allready in array

                 } while ( pPos[us++] & SM_TAB_NEXT );

                 //     expand pos array
                        
                 unsigned short* pNewPos = (unsigned short*)malloc ( sizeof (unsigned short) * (us+1) );
		 assert ( pNewPos );
                 memcpy ( pNewPos, pPos, sizeof (unsigned short) * us );
                 
                 pNewPos [us-1] |= SM_TAB_NEXT;         // set continue bit
                 pNewPos [us] = i | SM_DOC_ADD;         // fills new item

                 free ( pPos );
                 m_pPosTable [usMapPos & M_SM_TAB_POS] = pNewPos;
             }
        }
        else                                            // New Key
        {
             usMapPos = i | SM_ITEM_SINGLE | SM_DOC_ADD;
             m_aInt64SplayMap [ *(u_int64_t*) pWord ] = usMapPos;
        }
        
        #if defined(unix) && !defined(__GO32__) && defined(DEBUG_MEM)
              mallinfo ();
        #endif

        return OutFunc ( 1, usPrevInUse );
}

int     ContextCollection :: DelWord ( char * pWord, long lDocId )
{
	unsigned short usPrevInUse = m_usInUse;
	m_usInUse = 1;

	if ( m_lSingleCasheDocId ) {
		if ( SingleDocCaching ( pWord, lDocId, SDC_DEL ) )
			return OutFunc ( 1, usPrevInUse );
	}

        #if defined(unix) && !defined(__GO32__) && defined(DEBUG_MEM)
              mallinfo ();
        #endif
    
        #ifdef CTX_ACSESS_COUNT
               g_ulAcsessCount++;
        #endif

L_RESTART :    
        unsigned short i = m_usCashPos;
        
        if ( lDocId != m_lCashDoc )
            for ( i = 1; i <= m_usIdCount; i++ )
                if ( m_pIdList [i] == lDocId )
                {
                    m_lCashDoc = lDocId;
                    m_usCashPos = i;
                    break;
                }
                
        if ( i > m_usIdCount ) i = RegisterId ( lDocId );

        unsigned short usMapPos = m_aInt64SplayMap [ *(u_int64_t*) pWord ];
        
        if ( usMapPos ) // key found
        {
             if ( (usMapPos & M_SM_ITEM_TYPE) == SM_ITEM_SINGLE )    // Item have one doc yet
             {                                                       // (means position in DocsArray)
                 if ( i == (usMapPos & M_SM_DOC_POS) )                 
                     return OutFunc ( 1, usPrevInUse );                   // docs seams
                 else                                           // docs different move into PosTable
                 {
                     if ( m_usPTabPos >= POS_TAB_SIZE )
                     {
						 logger.printf ( "Index %s : PosTable overflow (m_usPTabPos=%ud, usMapPos=%x)\n", 
							 m_pInd->Name, m_usPTabPos, usMapPos );

                         Flush ();
                         goto L_RESTART;
                     }
                     m_pPosTable [ m_usPTabPos ] = (unsigned short*) malloc ( sizeof(unsigned short)*2 );
		     assert (m_pPosTable [ m_usPTabPos ]);
                     m_pPosTable [ m_usPTabPos ][0] = (usMapPos & M_SM_DOC_POSTYPE) | SM_TAB_NEXT;
                     m_pPosTable [ m_usPTabPos ][1] = i | SM_DOC_DEL;
                     
                     usMapPos = SM_ITEM_MULTI | m_usPTabPos++;
                     m_aInt64SplayMap [ *(u_int64_t*) pWord ] = usMapPos;
                 }
             }
             else                                               // Item have multi doc 
             {                                                  // (means position in PosTable)
                 unsigned short* pPos = m_pPosTable [usMapPos & M_SM_TAB_POS];

                 unsigned short us = 0;
                 do
                 {
                     if ( i == (pPos[us] & M_SM_DOC_POS) )
                        return OutFunc ( 1, usPrevInUse );            // docs allready in array

                 } while ( pPos[us++] & SM_TAB_NEXT );

                 //     expand pos array

                 unsigned short* pNewPos = (unsigned short*)malloc ( sizeof (unsigned short) * (us+1) );
                 assert ( pNewPos );
		 memcpy ( pNewPos, pPos, sizeof (unsigned short) * us );
                 
                 pNewPos [us-1] |= SM_TAB_NEXT;         // set continue bit
                 pNewPos [us] = i | SM_DOC_DEL;         // fills new item

                 free ( pPos );
                 m_pPosTable [usMapPos & M_SM_TAB_POS] = pNewPos;
             }
        }
        else                                            // New Key
        {
             usMapPos = i | SM_ITEM_SINGLE | SM_DOC_DEL;
             m_aInt64SplayMap [ *(u_int64_t*) pWord ] = usMapPos;
        }

        #if defined(unix) && !defined(__GO32__) && defined(DEBUG_MEM)
              mallinfo ();
        #endif

        return OutFunc ( 1, usPrevInUse );
}


int     ContextCollection :: Flush ()
{        
        unsigned short usPrevInUse = m_usInUse;
		m_usInUse = 1;

	#if defined(unix) && !defined(__GO32__) && defined(DEBUG_MEM)
              mallinfo ();
        #endif

		if ( m_lSingleCasheDocId ) SingleToMain();

        int ii = m_aInt64SplayMap.length();

        logger.printf ( "Index %s Flushing Start (Word to Flush:%d)\n", 
					m_pInd->Name, ii );
		logger.printf( "(Id in Cash:%d, Doc in tab:%d )\n", m_usIdCount, m_usPTabPos );

		if ( canModifyFlush ) totalFlushs++;
        FlushCreate ( ii, bEnglish ); // visualise

        char pWord [ CTX_WORD_SIZE + 1 ];
        pWord [CTX_WORD_SIZE] = 0;

        for ( Point i = m_aInt64SplayMap.first (); i; m_aInt64SplayMap.next (i) )
        {
            AddFlushing ( 1 ); // visualise

            *(u_int64_t*)pWord = m_aInt64SplayMap.key(i);
            unsigned short usPos = m_aInt64SplayMap.contents (i);

            Stream *str = m_pInd -> Open ( pWord, 1 );
            int bEmptyKey = 0;

            DocCollection* col = new DocCollection ;
            if ( str )
            {
                col -> Get ( str );
                str -> Seek ( 0 );

                if ( (usPos & M_SM_ITEM_TYPE) == SM_ITEM_SINGLE )
                {
                    if ( (usPos & M_SM_DOC_TYPE) == SM_DOC_ADD )
                        col->Add ( m_pIdList [ usPos & M_SM_DOC_POS ] );
                    else
                        col->Del ( m_pIdList [ usPos & M_SM_DOC_POS ] );
                }
                else
                {
                    unsigned short * pPos = m_pPosTable [ usPos & M_SM_TAB_POS ];
                    unsigned short us = 0;
                    do
                    {
                        if ( (pPos[us] & M_SM_DOC_TYPE) == SM_DOC_ADD )
                           col->Add ( m_pIdList [ pPos[us] & M_SM_DOC_POS ] );
                        else
                           col->Del ( m_pIdList [ pPos[us] & M_SM_DOC_POS ] );
                    } while ( pPos[us++] & SM_TAB_NEXT );

                    free ( pPos );
                }

                col -> Put ( str );
                str -> Trunc ( );

                if ( !col->ItemCount ) bEmptyKey = 1;

                delete col;
            }
            else logger.printf ( lt_error, "Can't open/create Stream by Key \"%s\" in Context Index\n", pWord );
            
            m_pInd -> Close ( str );

            if ( bEmptyKey ) m_pInd -> DelKey ( pWord );
        }
        
        m_aInt64SplayMap.clear ();
        m_usIdCount = 0;
        m_usPTabPos = 0;
        m_lCashDoc  = 0;
        m_usCashPos = 0;

        logger.printf ( "ContexFlushing End\n" );
        #ifdef CTX_ACSESS_COUNT
               logger.printf ( "Context acsess count = %lu\n", g_ulAcsessCount );
        #endif

        FlushDestroy (bEnglish); // visualise

        #if defined(unix) && !defined(__GO32__) && defined(DEBUG_MEM)
              mallinfo ();
        #endif

        return OutFunc ( 1, usPrevInUse );
}

void ContextCollection :: LogOut ( const char* pMess )
{
	logger.printf ( "Index %s LogOut: %s\n", m_pInd->Name, pMess );
}

#ifdef CTX_CONTROL
#undef CTX_CONTROL
#endif        

#ifdef CTX_ACSESS_COUNT
#undef CTX_ACSESS_COUNT
#endif        

#ifdef CTX_DEBUG_MEM
#undef CTX_DEBUG_MEM
#endif        




