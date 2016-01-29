/*
 * $Id: timer.h,v 2.9 2005/06/03 05:35:47 grigorio Exp $
 */

#include <ctime> // GARANT_GCC
#include "Logger.h"

class Timer 
{
public :
	Timer ( LogSession* log= 0, logtype_t type = lt_debug, const char* mess = 0 ) 
		: m_log(log), m_type(type), m_mess (0) {
		if ( mess ) m_mess = strdup (mess);
		time( &m_longTime );				
		m_ctStartTime = clock();		
	}
	~Timer () {
		Flush ( m_mess, m_type );
		if ( m_mess ) free ( m_mess );		
	}

	LogSession* SetOutLog ( LogSession* log ) {
		LogSession* ret = m_log;
		m_log = log;
		return ret;
	}

	void Flush ( const char* pMess, logtype_t type = lt_debug ) {			
		time_t longTime;
		time( &longTime );
		
		if ( !pMess ) pMess = "Execution";

		long unsigned luSecCount = (clock() - m_ctStartTime) / CLOCKS_PER_SEC;
		long unsigned luMinCount = luSecCount / 60;
		luSecCount -= luMinCount*60;
		long unsigned luHourCount = luMinCount / 60;
		luMinCount -= luHourCount*60;
            
		long unsigned luRunSecCount = (long unsigned) difftime( longTime, m_longTime );
		long unsigned luRunMinCount = luRunSecCount / 60;
		luRunSecCount -= luRunMinCount*60;
		long unsigned luRunHourCount = luRunMinCount / 60;
		luRunMinCount -= luRunHourCount*60;

		if ( m_log ) m_log->printf( type, "%s :\n\tCPU-time: %lu hr %lu min %lu sec;\n"
				"\tRun-time: %lu hr %lu min %lu sec;\n", 
				pMess, luHourCount, luMinCount, luSecCount, 
				luRunHourCount, luRunMinCount, luRunSecCount );
		else printf( "%s :\n\tCPU-time: %lu hr %lu min %lu sec;\n"
				"\tRun-time: %lu hr %lu min %lu sec;\n", 
				pMess, luHourCount, luMinCount, luSecCount, 
				luRunHourCount, luRunMinCount, luRunSecCount );
	}
protected :
	clock_t m_ctStartTime;
	time_t m_longTime;		
	LogSession* m_log;
	logtype_t m_type;
	char* m_mess;
};
