/* 
 * $Id:
 */

//////////////////////////////////////////////////////////////////////
//
// ClassCache.h: interface for the ClassCache class.
//
//////////////////////////////////////////////////////////////////////

#ifndef __CLCACHE_H__
#define __CLCACHE_H__

#include "ace/ACE.h"

//#include "FString.caddr_t.SplayMap.h"
//#include "FString.long.SplayMap.h"
#include "SplayMap.h"
#include "SharedData.h"
#include "hindex.h"
#include "collect.h"

#define MAX_PREF_TABLE_SIZE	8192	// max Prefix in cache, then overload do Flush

long DelStrStr ( char* pDest, const char* pStr, long& len );
long AddStrStr ( char* &pDest, const char* pStr, long& len );

typedef char ccop_t;
#define ot_void 0 // startup operation
#define ot_add  1 // need to be added
#define ot_del -1 // need to be removed
#define ot_hold 2 // no need any modification

class ClassCache
{

public:
	ClassCache( HIndex* pClas, HIndex* pPref, bool aEnglish ):
				bEnglish (aEnglish),
				theClassMap(0) , thePrefixMap(-1),
				m_pClassInd(pClas), m_pPrefInd(pPref) { canModifyFlush = true; };
	virtual ~ClassCache();
	long AddPrefix ( const char* pClass, const char* pPref ) {
		return modPrefix ( pClass, pPref, ot_add );
	}
	long DelPrefix ( const char* pClass, const char* pPref ) {
		return modPrefix ( pClass, pPref, ot_del );
	}
	long Flush ();
protected:
	bool	bEnglish;
	bool	canModifyFlush;

	//FStringcaddr_tSplayMap theClassMap;
	SplayMap<SString,caddr_t> theClassMap;
	//FStringlongSplayMap thePrefixMap;
	SplayMap<SString,long> thePrefixMap;
	
	HIndex* m_pClassInd;
	HIndex* m_pPrefInd;

	struct ClassLevelInfo {
		SortedCollection* collection;

		Stream * secondStream;
		char* streamData;
		long dataLength;
		int dataModify;
		char* level;
		ClassLevelInfo () : collection(0), secondStream(0), 
			streamData(0), dataLength(0), dataModify(0), level(0) {};
		~ClassLevelInfo () {
			if ( level ) free ( level );
			if ( streamData ) free ( streamData );
			if ( collection ) delete collection;
		}
	};

	long modPrefix ( const char* pClass, const char* pPref, ccop_t op );
	int ProcessOneLevel ( ClassLevelInfo& info, 
		const char* prefix, ccop_t op, SortedCollection* prefixColl );
};

#endif

