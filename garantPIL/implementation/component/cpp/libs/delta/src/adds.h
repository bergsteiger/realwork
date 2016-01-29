/*
 * $Id: adds.h,v 2.27 2010/09/08 07:47:13 vlad Exp $
 */

#ifndef	__DELTA_ADDS__
#define	__DELTA_ADDS__

#include "stringz.h"
#include "base.h"
#include "btiter.h"
#include "doccol.h"
#include "SplaySet.h"
#include "StorableSplaySet.h"
#include "SplayMap.h"
#include "Logger.h"
#include "dltcomon.h"

long SaveStream ( Stream* pstr, FILE* pfile, long from=-1, long count=-1, short saveCount=1 );
int readSubs(const char *str, DocCollection *& pSubColl);
StringZ * LoadStrz ( Base* base, long docId, int tag );
short objcmp ( Stream*, Stream* ); 
short bicmp ( BaseInfo& a, BaseInfo& b ); 
int DocInfoCmp ( DocInfo& a, DocInfo& b, bool compare_lastParaID = false);
int read_unsignedlongs ( SplaySet<long>& set, const char * filename );

class BaseInfoMap : public SplayMap<short, BaseInfo>
{
	static BaseInfo bi_dummy;

public :
	BaseInfoMap( Base* base );
	BaseInfoMap(const BaseInfoMap& a) : SplayMap<short, BaseInfo>(a) {}
	
	int SaveInfo ( Base* base );
};

class BlobIterator : public BTIterator 
{
public :
	BlobIterator ( Base * base, SplaySet<unsigned short>* pids )
		: BTIterator ( base->FindIndex("Blob") ), m_pids(pids) 
	{
		if ( !End() && !CheckCurrentKey() ) next();
	}
	virtual void next();
	virtual void prev();	
	
protected:	
	SplaySet<unsigned short>* m_pids;
	virtual int CheckCurrentKey();		
};

class ErrorPolicy : public LogPolicy 
{
	unsigned m_errcount;
	LogPolicy* duplicate () const {
		return new ErrorPolicy (*this);
	};

public:
	ErrorPolicy () : LogPolicy (), m_errcount(0) {};
	ErrorPolicy ( const LogPolicy& copy ) : LogPolicy ( copy ), m_errcount(0) {};
	ErrorPolicy ( LogDevice* dev, code_t in, code_t out ) : LogPolicy ( dev, in, out ), m_errcount(0) {};
	unsigned ErrCount() {
		return m_errcount;
	};
protected:
	virtual int PrePrint ( logtype_t& type, char *& str ) {
		if ( type == lt_error || type == lt_fatal )
			m_errcount++;
		return 1;
	};
};

int check_ready_status ( short tid, Base *pBase, LogSession* plog );

/**************vizualize*************/

#include "pscreen.h"

void SetProgressScreen (ProgressScreen*);
ProgressScreen* GetProgressScreen();
void SetSegmentName ( char* pName, int iCur=0, int iAll=0, bool b_english_face = false);
void CleanSegmentName ();
void DocsProcCreate ( long lDocInDelta, bool bEnglish );
void AddDelta ( long lDeltaCount );
void FlushCreate ( long lFlushingCount, bool bEnglish );
void FlushDestroy (bool bEnglish);
void AddFlushing ( long lCount );
void AddPara ( long lCount );
void ParaProcDestroy ();
void ParaProcCreate ( long lParaCount );

#endif
