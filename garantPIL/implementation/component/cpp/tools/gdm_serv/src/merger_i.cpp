#include "shared/Core/fix/mpcxc.h"
/*
 * cvs id was here $
 */

#include "merger_i.h"
#include "SplaySet.h"
#include "Logger.h"
#include "deltamerger.h"
#include "CORBA_Convertors.h"

extern Logger log; 

unsigned long g_th_count = 0;

unsigned AutoMutex::m_in_number = 1;
unsigned AutoMutex::m_out_number = 0;

extern	pthread_mutex_t m_mutLoad;

CORBA::Short Merger_i::loadDeltas ( const StringArr& mrgFiles, short cl_id )
{	
	AutoMutex am( m_mutLoad );//!!!

	long	th_count = g_th_count++;
	char	name [64];
	sprintf( name, "th_log_%ld.%ld", cl_id, th_count );
	FILE	*thdlog = 0;

	if( m_isThdlog )
		thdlog = mpcxc_fopen ( name, "at" );

	if( thdlog )
	{
		fprintTime( thdlog );
		fprintf( thdlog, "log for thread %ld, started by client id %ld\n", th_count, cl_id );
		fprintf( thdlog, "Merger_i::loadDeltas invoke\n");
		fflush( thdlog );
	}

	printf ( "Merger_i::loadDeltas invoke\n");
	Sequence_SplaySet_Convertor<StringArr, SString> conv;
	
	CORBA::Short ret;
	try {
		
		ret = m_theMerger.loadDeltas ( conv (mrgFiles), thdlog );

		if (thdlog) {
			fprintf ( thdlog, "1.Loading complete\n" );
			fclose ( thdlog );	
		}
	} catch (DeltaMerger::LoadingExcept& ex) {
		if (thdlog) {
			fprintf ( thdlog, "Loiding exeption raised\n" );
			fclose ( thdlog );
		}
		Merger::LoadingExcept ex_i = ex;
		throw ex_i;
	} catch (...) {
		if (thdlog) {
			fprintf ( thdlog, "Unknown exeption raised\n" );
			fclose (thdlog );
		}
		printf ( "Unknown error while invoke Merger_i::loadDeltas \n" );
		throw Merger::UnknownExcept ();
	}
	return ret;
}

CORBA::Short Merger_i::unLoadDeltas ( const StrPeriod& p )
{	
	printf ( "Merger_i::unLoadDeltas invoke\n");
	throw Merger::UnknownExcept ();
	return 0;
	/*Period per;
	try {
		per = p;
	} catch (...) {
		log.printf ( lt_error, "Bad srguments in StrPeriod\n" );
		throw UnknownExcept ();
	}

	return (CORBA::Short) m_theMerger.unLoadDeltas ( per );*/
}

CORBA::Short Merger_i::assemblingDelta ( const StrSettings& settings, CORBA::String_out outname, CORBA::Short cl_id )
{
	AutoMutex am( m_mutLoad );//!!!

	long th_count = g_th_count++;
	char name [64];
	sprintf ( name, "th_log_%ld.%ld", cl_id, th_count );
	FILE* thdlog = 0;
	if (m_isThdlog) thdlog = mpcxc_fopen ( name, "at" );
	if (thdlog) {
		fprintTime ( thdlog );
		fprintf ( thdlog, "log for thread %ld, started by client id %ld\n", th_count, cl_id );
		fprintf ( thdlog, "Merger_i::assemblingDelta invoke for period\n");
		fprintf ( thdlog, "\told:%s::%s; new:%s::%s\n", 
			(const char*)settings.period.old_date.date, (const char*)settings.period.old_date.time,
			(const char*)settings.period.new_date.date, (const char*)settings.period.new_date.time );
		fflush ( thdlog );
	}

	log.printf(lt_debug, "Merger_i::assemblingDelta invoke for period\n");
	log.printf(lt_debug, "\told:%s::%s; new:%s::%s\n", 
		(const char*)settings.period.old_date.date, (const char*)settings.period.old_date.time,
		(const char*)settings.period.new_date.date, (const char*)settings.period.new_date.time );
	DeltaMerger::Settings s;

	try {
		s = settings;
	} catch (...) {
		printf ( "Bad srguments in StrSettings\n" );		
		throw Merger::UnknownExcept ();
	}
	CORBA::Short ret;
	try {
		ret = (CORBA::Short) m_theMerger.assemblingDelta ( s, outname, thdlog );
		if ( thdlog ) {
			fprintf ( thdlog, "2. delta assembled.\n");
			fclose ( thdlog );
		}
	} catch (DeltaMerger::UnexistSegs ex) {
		Merger::AssemblingExcept ex_i = ex;		
		if (thdlog) { 
			fprintf ( thdlog, "Exception raised: Unexisting Seg\n" );
			fclose ( thdlog );
		}
		throw ex_i;
	} catch (DeltaMerger::AssemblingExcept& ex) {
		Merger::AssemblingExcept ex_i = ex;
		if (thdlog) {
			fprintf ( thdlog, "Exception raised: any Asembling ex\n" );
			fclose ( thdlog );
		}
		throw ex_i;
	} catch (...) {
		printf ( "Error while invoke Merger_i::assemblingDelta\n" );
		if (thdlog) {
			fprintf ( thdlog, "Exception raised: Unknown ex\n" );
			fclose ( thdlog );
		}
		throw Merger::UnknownExcept();
	}
	return ret;
}

ShortArr* Merger_i::whatForPeriod ( const StrPeriod& p )
{
	AutoMutex am( m_mutLoad );//!!!

	log.printf(lt_debug, "Merger_i::whatForPeriod invoke\n");
	Sequence_SplaySet_Convertor<ShortArr, unsigned short> conv2;
	ShortArr* sa = new ShortArr;
	Period per;
	try {
		per = p;
	} catch (...) {
		printf ( "Bad srguments in StrPeriod\n" );
		throw Merger::UnknownExcept();
	}

	try {
		*sa = conv2(m_theMerger.whatForPeriod(per));
		return sa;
	} catch (...)  {
		printf ( "Error while invoke Merger_i::whatForPeriod\n" );
		throw Merger::UnknownExcept();
	}	
}

StrPeriodArr* Merger_i::getAllPeriods ()
{
	AutoMutex am( m_mutLoad );//!!!

	log.printf(lt_debug, "Merger_i::getAllPeriods invoke\n");
	Sequence_SplaySet_Convertor<StrPeriodArr, Period> conv;

	StrPeriodArr* spa = new StrPeriodArr;
	*spa = conv(m_theMerger.getAllPeriods());
	return spa;
}

