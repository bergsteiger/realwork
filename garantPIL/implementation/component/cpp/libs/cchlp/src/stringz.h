// StringZ.h    : header file of StringZ class
// Created by   : Krylov Maxim
// Date         : 17.04.1997
///////////////////////////////////////////////

#ifndef _STRZ_H_
#define _STRZ_H_

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "osdep.h"

#include "Logger.h"

#define Z_ATTR_HIDE     1
#define Z_ATTR_DIV_DEL  2
#define Z_ATTR_DIV_SUF	4

#define WITH_Z			1
#define WITH_CS			2
#define WITH_SUF		4

class StringZ
{
public :
	StringZ ( char* pStrzBuff, long lSize, int iSortingWithSub, int selfstore = 0 );
	virtual ~StringZ ();

	inline const char* operator () () const {
		if ( ! m_iStrzCount || m_iCurrentPos >= m_iStrzCount ) return 0;
		return m_pStrzArray [ m_iCurrentPos ];
	}

	inline const char* operator [] ( int iPos ) const {
		if ( iPos >= 0 && iPos < m_iStrzCount ) return m_pStrzArray [ iPos ];
		else return 0;
	}
	const char* GetAt( int iPos );
	inline const char* Get ( int iPos = -1 ) const {
		if ( iPos == -1 ) iPos = m_iCurrentPos;
		if ( iPos >= 0 && iPos < m_iStrzCount ) return m_pStrzArray [ iPos ];
		else return 0;
	}

	void operator ++ ();
	void operator -- ();
        
	const char* GetPrev ( int ) const;
	const char* GetNext ( int ) const;

	inline int End () const {
		return m_iCurrentPos >= m_iStrzCount;
	}

	int Equal ( const StringZ* pStrZ ) const; // compare all items in both object with current HIDE orders
	int Find ( const char* pStrz ) const; // find ASCIIZ in object with current HIDE orders; return index or -1
	int GetCount () const;
	inline int GetPos () const { 
		return m_iCurrentPos;
	}
	inline int Seek ( int pos ) { 
		if ( pos < 0 || pos >= m_iStrzCount ) return 0;
		m_iCurrentPos = pos;
		return 1;
	}
        
	inline char GetAttrib( int iPos ) const {
		if ( iPos < 0 || iPos >= m_iStrzCount ) return (char)(-1);
		return m_pStrzAttrib [ iPos ];
	}

	inline int Hide ( int iPos = -1 ) {
		if ( iPos == -1 ) iPos = m_iCurrentPos;
		if ( iPos < 0 || iPos >= m_iStrzCount ) return -1;
		if ( m_pStrzAttrib [ iPos ] & Z_ATTR_HIDE ) return 0;
		m_pStrzAttrib [ iPos ] |= Z_ATTR_HIDE;
		return 1;
	}

	inline int UnHide ( int iPos = -1 ) {
		if ( iPos == -1 ) iPos = m_iCurrentPos;
		if ( iPos < 0 || iPos >= m_iStrzCount ) return -1;
		if ( ! ( m_pStrzAttrib [ iPos ] & Z_ATTR_HIDE ) ) return 0;
		m_pStrzAttrib [ iPos ] &= ~Z_ATTR_HIDE;
		return 1;
	}

	inline void EnableHide () {
		m_bEnableHide = 1;
	}

	inline void DisableHide () {
		m_bEnableHide = 0;
	}

	int HideDoublicates ();
	int HasDoublicates ( FILE* pfOutFile = 0, const char* pMessage = 0 );

	int FindUnEquelLevel ( int iPos ) const;
	
	inline long GetSub ( int iPos = -1 ) const {
		if ( iPos == -1 ) iPos = m_iCurrentPos;
		return atol ( m_pStrzArray [iPos] );
	}

	//  Return buffer with full key with out sub if present. Must free after if copy==1.
	inline char* GetKey ( int iPos = -1, int copy = 1 ) const {
		if ( iPos == -1 ) iPos = m_iCurrentPos;
		else if ( iPos < 0 || iPos >= m_iStrzCount ) return 0;
		
		char * pKey;
		if ( m_iSortingWithSub ) {
			pKey = strchr ( m_pStrzArray [iPos], ':' );
			pKey = pKey ? pKey + 1 : m_pStrzArray [iPos];
		} else pKey = m_pStrzArray [iPos];
		
		return copy ? strdup ( pKey ) : pKey;
	}

	virtual size_t UnHideSize ( int iCountMask = 0 );

	void Print ( LogSession* log, logtype_t type ) const;
	const char* IterateBySub ( long sub, int &pos ) const;

protected :
	int	m_iStrzCount;
	char**	m_pStrzArray;
	char*	m_pStrzAttrib;
	char*	m_pStrzBuff;
	int	m_iSortingWithSub;
	int	m_iCurrentPos;
	int	m_bEnableHide;
	int	m_bSelfStore;
};

class ZStrings
{
public:
	ZStrings(const char *d, size_t sz);
	~ZStrings();
	struct ZStringData {
		const char *ptr;
		size_t len;
	};
	int count() const 
		{ 
			return n; 
		};
	const ZStringData * operator[] (int i) const
		{
			return ((unsigned)i<(unsigned)n )?strings+i:0;
		}
	int hasString(const char *ptr) const;
	int hasString( const ZStringData *p )  const
		{
			return hasString (p->ptr);
		}
	int hasStringHIPart(const char *ptr, int sz) const;
	int hasStringHIPart( const ZStringData *p ) const
		{
			return hasStringHIPart (p->ptr, p->len);
		}

	int doFreeData;
protected:
	const char *data;
	int n;
	struct ZStringData *strings;
};


#endif


