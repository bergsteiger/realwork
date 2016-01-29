/*
 * $Id: cntxtcol.h,v 2.12 2007/03/30 13:16:58 vlad Exp $
 */

#ifndef __CNTXMAP_H__
#define __CNTXMAP_H__

#include	"ace/ACE.h"

#include	"collect.h"
#include	"index.h"
#include	"deltadef.h"
#include	"gardefs.h"
#include	"SplayMap.h"

#define WORD_BUF_SIZE   1024*16                 // # of docs cached in ContextCollection
#define POS_TAB_SIZE    32768                   // # of keys with more then one docs (don't change)

#define M_SM_ITEM_TYPE  32768			// (don't change)
#define SM_ITEM_SINGLE  0			// (don't change)
#define SM_ITEM_MULTI   32768                   // (don't change)

#define M_SM_DOC_TYPE   16384                   // (don't change)
#define SM_DOC_ADD      0                       // (don't change)
#define SM_DOC_DEL      16384                   // (don't change)

#define M_SM_TAB_STOP   32768                   // (don't change)
#define SM_TAB_LAST     0                       // (don't change)
#define SM_TAB_NEXT     32768			// (don't change)

#define M_SM_DOC_POS    16383			// (don't change)
#define M_SM_TAB_POS    32767			// (don't change)
#define M_SM_DOC_POSTYPE 32767			// (don't change)

#define SDC_NEW 0
#define SDC_ADD 1
#define SDC_DEL 2
#define SDC_EMPTY 3

#ifdef N_MALLOC
extern int mallocReserved (void);
#endif

class   ContextCollection
{
protected:
	bool	bEnglish;
	bool	canModifyFlush;
	Index *					m_pInd;
	long 					m_pIdList [WORD_BUF_SIZE+1]; // ! pos [0] reserved !
	unsigned short *			m_pPosTable [POS_TAB_SIZE];
	unsigned short				m_usIdCount;
	unsigned short				m_usPTabPos;
	SplayMap<u_int64_t,u_int16_t>	m_aInt64SplayMap;
	long						m_lCashDoc;
	unsigned short				m_usCashPos;
	unsigned long				m_ulMemLimit;
	unsigned short				m_usInUse;
	SplayMap <u_int64_t, char>  m_mapSingleCache;
	long                        m_lSingleCasheDocId;

	void LogOut ( const char* pMess );
	void SingleToMain ();
	int SingleDocCaching ( const char* pWord, long lDocId, char op );
	
	inline int OutFunc ( int iRetVal, unsigned short usPrevInUse ) {
#ifdef N_MALLOC
		if ( m_usUseReserved )	{
			m_usUseReserved = 0;
			LogOut ( "OutFunc: Owner mem cleaner prevent to Flush" );
			Flush ();
			mallocReserved ();
		}

		m_usInUse = usPrevInUse;
#else
		usPrevInUse = 0;
#endif
		return iRetVal;
	}
       
public:
	unsigned short			m_usUseReserved;

    ContextCollection ( Index * pInd, unsigned long ulMemLimit, bool aEnglish ); 
    ~ContextCollection () { 
		if ( m_usIdCount > 0 ) {
			canModifyFlush = false;
			Flush (); 
		}
	}

    int Flush ();               // save all data to index

	inline unsigned short RegisterId ( long lDocId ) {
			unsigned short usPrevInUse = m_usInUse;
			m_usInUse = 1;			
			for ( unsigned short i = 1; i <= m_usIdCount; i++ )
				if ( m_pIdList [i] == lDocId ) {
					return (unsigned short)OutFunc ( (int)i, usPrevInUse );
			}
            if ( m_usIdCount >= WORD_BUF_SIZE ) {
				LogOut ( "RegisterId:  IdList overflow" );
				Flush ();
			}
            m_pIdList [++m_usIdCount] = lDocId;  // ! IDs fills from pos [1] !
            return (unsigned short)OutFunc ( (int)m_usIdCount, usPrevInUse );
        }
	int            AddWord ( char *, long );
    int            DelWord ( char *, long );
	void StartSingleDocCaching ( long docId );
	inline unsigned short InUse () { return m_usInUse; }
};

#endif

