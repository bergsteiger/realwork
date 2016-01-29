// ClassCache.cpp: implementation of the ClassCache class.
//
//////////////////////////////////////////////////////////////////////

#include "clcache.h"
#include "collect.h"
#include "gardefs.h"
#include "base.h"
#include "adds.h"
#include "Logger.h"
#include "unfull.h"

extern UnFull* g_pUnFull;
extern Logger logger;
extern long totalFlushs;

static logtype_t lt_clcache_debug ( 600, "Class Cache debug" );

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

ClassCache::~ClassCache()
{
	canModifyFlush = false;
	Flush ();
}

long ClassCache::modPrefix(const char * pClass, const char * pPref, ccop_t op )
{
	if (!op) return 0;
	logger.printf ( lt_clcache_debug, cd_dos, "ClassCache.%s::modPrefix (class=%s, prefs=%s, op=%d)\n",
		m_pClassInd->Name, pClass, pPref, op );

	SString pref( pPref );
	long prefPos = thePrefixMap[pref];

	if ( prefPos == -1 ) {
		prefPos = thePrefixMap.length()-1;
		if (prefPos >= MAX_PREF_TABLE_SIZE) {
			Flush();
			prefPos = thePrefixMap.length();
		}

		thePrefixMap[pref] = prefPos;
		logger.printf ( lt_clcache_debug, cd_dos, "\tas new prefs   (prefPos=%ld)\n", prefPos );

	} else {
		logger.printf ( lt_clcache_debug, cd_dos, "\tas exist prefs (prefPos=%ld)\n", prefPos );
	}

	SString clas ( pClass );
	char* pPrefs = (char*) theClassMap[clas];

	if ( !pPrefs ) {
		pPrefs = (char*) malloc ( sizeof(char) * MAX_PREF_TABLE_SIZE );
		assert ( pPrefs );
		memset ( pPrefs, ot_void, sizeof(char) * MAX_PREF_TABLE_SIZE );
		
		pPrefs[prefPos] = op;
		theClassMap[clas] = pPrefs;
		logger.printf ( lt_clcache_debug, cd_dos, "\tas new   class (pPrefs=%ld)\n", pPrefs );
	} else {
		// if we add some refs one time, then intersection between Class
		// and Prefix never be void
		if ( pPrefs[prefPos] == ot_void ) pPrefs[prefPos] = op;
		// if we remove refs before adding, then we don't need to add Prefix later
		// (same for reverse)
		else if ( pPrefs[prefPos] != op ) pPrefs[prefPos] = ot_hold;
		logger.printf ( lt_clcache_debug, cd_dos, "\tas exist class (pPrefs=%ld)\n", pPrefs );
	}
	logger.printf ( lt_clcache_debug, cd_dos, "\tset op=%d\n", pPrefs[prefPos] );
	return (long)pPrefs[prefPos];
}

long ClassCache :: Flush ()
{
	int iModify = 0;

	logger.printf ( lt_clcache_debug, cd_dos, "In ClassCache stored %ld class keys\n", (long)theClassMap.length() );
	if ( canModifyFlush ) totalFlushs++;
	//FlushCreate ( (long)theClassMap.length(), bEnglish ); // visualise
	
	SortedCollection * pPrefColl = 0;
	switch ( GetDataType ( m_pClassInd ) ) {
	case SDT_DOCS :
		pPrefColl = new DocCollection ();
		break;
	case SDT_REFS :
		pPrefColl = new RefCollection ();
		break;
	default :
		logger.printf ( lt_error, "ClassCache::Flush : Collection Work Fault - unknown data type\n" );
		return 0;
	}

	for ( Point i=theClassMap.first(); i; theClassMap.next(i) ) {
		//AddFlushing ( 1 ); // visualise

		SString clas = theClassMap.key(i);

		char* pPrefs = (char*) theClassMap.contents(i);
		assert  ( pPrefs );

		long clasLevel = 1;
		{
			const char* cls = clas;
			while ( *cls ) if ( *(cls++) == '\\' ) clasLevel++;
		}
		logger.printf ( lt_clcache_debug, cd_dos, "Class \"%s\" (%ld levels)\n", (char*)clas, clasLevel );
		
		ClassLevelInfo *infos  = new ClassLevelInfo [clasLevel];		
		{
			long ll = 0;
			char * tmp = strdup ( clas );
			for ( long l=0; l<clasLevel; l++ ) {
				Stream * str = m_pClassInd->Open ( tmp );
				if ( !str ) {
					logger.printf ( lt_error, cd_dos, "  level %ld: \"%s\" error: can't open stream\n", l, tmp );
				} else if ( !str->Length() ) { // empty node (remove it), no need to make any modifications with cache
					m_pClassInd->Close ( str );
					BTKEY key = m_pClassInd->FullKey(tmp);
					if ( !m_pClassInd->OwnChildrenCount ( key ) ) {
						logger.printf ( lt_clcache_debug, cd_dos, "  level %ld: \"%s\" node's data alredy deleted - remove key\n", l, tmp );
						if ( m_pClassInd->Delete ( tmp ) != GKDB::BT_OK )
							logger.printf ( lt_error, cd_dos, "  level %ld: \"%s\" error: can't remove key\n", l, tmp );
					} else logger.printf ( lt_clcache_debug, cd_dos, "  level %ld: \"%s\" node's data alredy deleted, but node has child - skip\n", l, tmp );
					free ( (void*)key );
				} else {					
					m_pClassInd->Close ( str );
					logger.printf ( lt_clcache_debug, cd_dos, "  level %ld: \"%s\" node's data exist\n", l, tmp );
					infos[ll++].level = strdup ( tmp );
				}
				
				char* c = strrchr ( tmp, '\\' );
				if ( c ) *c = 0;
			}
			free ( (void*)tmp );
			clasLevel = ll;
		}

		if ( !clasLevel ) {
			free ( pPrefs );
			delete [] infos;
			continue;
		}

// process all stored prefix
		for ( Point ii=thePrefixMap.first(); ii; thePrefixMap.next(ii) ) {
			long prefPos = thePrefixMap.contents(ii);

			if ( pPrefs[prefPos] == ot_void ) {
// no modification for prefix
				SString pref = thePrefixMap.key(ii);
				logger.printf ( lt_clcache_debug, cd_dos, "\tno modification for prefix \"%s\"\n", (char*)pref );
				
			} else if ( pPrefs[prefPos] == ot_hold ) {
// any changes compensated
				SString pref = thePrefixMap.key(ii);
				logger.printf ( lt_clcache_debug, cd_dos, "\tany changes compensated for prefix \"%s\"\n", (char*)pref );
			
			} else {				
// current prefix has modification
				int needTopModify = 1;
				for ( long l=0; l < clasLevel && needTopModify; l++ ) {
					SString pref = thePrefixMap.key(ii);
					needTopModify = ProcessOneLevel ( infos[l], pref, pPrefs[prefPos], pPrefColl );
				}
				pPrefColl->FreeAll();
			} 		
		}
// end of prefix processing
		
		free ( pPrefs );

		for ( long l=0; l < clasLevel; l++ ) {
			if ( infos[l].secondStream ) {
				if ( infos[l].dataModify ) {
					infos[l].secondStream->Seek(0);
					if ( !infos[l].dataLength ) {
						// empty stream - data must be added later by other prefs
						logger.printf ( lt_clcache_debug, cd_dos, "  Empty result stream saved by key \"%s\"\n",
							(char*)clas );
					} else {
						infos[l].secondStream->Write ( infos[l].streamData, infos[l].dataLength );
						logger.printf ( lt_clcache_debug, cd_dos, "  Stream updated (len: %ld) by key \"%s\"\n",
							infos[l].dataLength, (char*)clas );
					}
					infos[l].secondStream->Trunc();
				}
				m_pClassInd->Close ( infos[l].secondStream );
			}
		}
		delete [] infos;
	}
// end of class processing
	delete pPrefColl;

	theClassMap.clear();
	thePrefixMap.clear();

	//FlushDestroy (bEnglish); // visualise
	return iModify;
}

int ClassCache::ProcessOneLevel ( ClassLevelInfo& info, const char* prefix, 
								 ccop_t op, SortedCollection* prefixColl )
{
	int needTopModify;
	if ( !info.secondStream ) {
// read old prefix's set from class
		int mod;
		info.secondStream = m_pClassInd->OpenN ( info.level, 1, 1, &mod );
		if ( !info.secondStream ) {
			logger.printf ( lt_error, cd_dos, "ClassCache::Flush : Error - can't open/create second stream in index\"%s\", by key \"%s\"\n",
				m_pClassInd->Name, info.level );						
			return 0;
		}

		info.dataLength = info.secondStream->Length();
					
		if ( info.dataLength ) {
			info.streamData = (char*) malloc ( info.dataLength );
			info.secondStream->Read ( info.streamData, info.dataLength );
		}
	}

	if ( op == ot_add ) {
// try to add current prefix to class prefix's set
		logger.printf ( lt_clcache_debug, cd_dos, "\tAdd Prefix \"%s\" to Class (level:%s)\n", prefix, info.level );
		int modify = AddStrStr ( info.streamData, prefix, info.dataLength );
					
		if ( !info.dataModify ) info.dataModify = modify;
		needTopModify = modify;
	} else {
// try to remove current prefix from class prefix's set
		logger.printf ( lt_clcache_debug, cd_dos, "\tTry to remove Prefix \"%s\" from Class (level:%s)\n", prefix, info.level );

		BTKEY key = m_pPrefInd->FullKey ( prefix );
		int remov;
		if ( key && !m_pPrefInd->OwnChildrenCount(key) ) {
			if ( !info.collection ) {
// read class docs		
				if ( GetDataType ( m_pClassInd ) == SDT_DOCS )
					info.collection = new DocCollection ();
				else info.collection = new RefCollection ();
		
				Stream* str = m_pClassInd->Open ( info.level );
				info.collection->Get( str );
				m_pClassInd->Close ( str );
			}

			if ( !prefixColl->ItemCount ) {
				Stream * str = m_pPrefInd->Index::OpenN ( key, 0 );
				if ( str ) {
// read prefix docs
					prefixColl->Get ( str );
					m_pPrefInd->Close ( str );
				}
			}			
			
			prefixColl->m_bCompType = COMP_STRONG;
			remov = !prefixColl->IsSect ( *info.collection );
			prefixColl->m_bCompType = COMP_STD;
			needTopModify = remov;
			
		} else remov = 1;

		if ( key ) free ( (void*)key );

// check it
		if ( remov ) {
			logger.printf ( lt_clcache_debug, cd_dos, "\tRemove Prefix \"%s\" from Class (level:%s)\n", prefix, info.level );
			needTopModify = DelStrStr ( info.streamData, prefix, info.dataLength );
			if ( !info.dataModify ) info.dataModify = needTopModify;
		} else {
			logger.printf ( lt_clcache_debug, cd_dos, "\tSkip Removing of Prefix \"%s\" from Class (level:%s)\n", prefix, info.level );
			needTopModify = 0;
		}
	}

	return needTopModify;
}

long DelStrStr ( char* pDest, const char* pStr, long& len ) {
	if ( !pDest || !pStr ) return 0;

	long lpos=0;

	while ( lpos<len ) {
		long recSize = strlen( pDest+lpos ) + 1;
		if ( !strcmp ( pDest + lpos, pStr ) ) {
			memmove ( pDest+lpos, pDest+lpos+recSize, len-lpos-recSize );

			len-=recSize;
			pDest[len] = 0;
			return 1;
		}
		lpos+=recSize;
	}

	return 0;
}

long AddStrStr ( char* &pDest, const char* pStr, long& len ) {
	if ( !pStr ) return 0;

	long lpos = 0;
	while ( lpos < len ) {
		if ( !strcmp ( pDest+lpos, pStr ) ) {
			return 0;
		}
		lpos += strlen(pDest+lpos) + 1;
	}

	long addlen = strlen ( pStr ) + 1;
	char* pTmp = (char*) malloc ( len + addlen );
	memcpy ( pTmp, pDest, len );
	memcpy ( pTmp+len, pStr, addlen );

	len += addlen;

	if ( pDest ) free ( pDest );
	pDest = pTmp;
	return 1;
}

