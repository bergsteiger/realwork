/*
 * $Id: merger_i.h,v 1.8 2001/02/05 17:25:07 max Exp $
 */

#ifndef __MERGER_IMPLIMENTATION_H__
#define __MERGER_IMPLIMENTATION_H__ 1

#include "merger.h"
#include "SplaySet.h"
#include "deltamerger.h"

class Merger_i : public POA_Merger, public PortableServer::RefCountServantBase
{
protected :
	DeltaMerger m_theMerger;
	int m_isThdlog;

public:
	Merger_i ( unsigned long mlim = 0, unsigned long dlim = 0, short isThdlog = 0 ) 
		: m_theMerger (mlim, dlim), m_isThdlog (isThdlog) {}
	virtual CORBA::Short loadDeltas ( const StringArr& mrgFiles, short cl_id );
	virtual CORBA::Short unLoadDeltas ( const StrPeriod& p );
	CORBA::Short assemblingDelta(const StrSettings& settings, CORBA::String_out outname, CORBA::Short cl_id);
	ShortArr* whatForPeriod ( const StrPeriod& p );
	StrPeriodArr* getAllPeriods ();  
};

#endif