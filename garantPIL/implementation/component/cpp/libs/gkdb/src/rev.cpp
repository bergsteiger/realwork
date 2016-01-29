
#include "gardefs.h"
#include "rev.h"

#include <cstring>
#include <ctime>


void rev_addweek ( revision& theRev, const int weeks ) 
{ 
	time_t atime; 
	struct tm atm; 
	struct tm *ptm; 
	memset( &atm, 0, sizeof( atm )); 
	atm.tm_year = theRev.RevisionDate.da_year - 1900; 
	atm.tm_mday = theRev.RevisionDate.da_day; 
	atm.tm_mon  = theRev.RevisionDate.da_mon - 1; 
	atime = mktime( &atm ); 
	atime += (long)weeks * 7l * 24l * 3600l; 
	ptm   = gmtime( &atime ); 
	theRev.RevisionDate.da_year = ptm -> tm_year + 1900; 
	theRev.RevisionDate.da_day = ptm -> tm_mday; 
	theRev.RevisionDate.da_mon = ptm -> tm_mon + 1;	 
} 
 
void rev_adddays ( revision& theRev, const int days ) 
{ 
	time_t atime; 
	struct tm atm; 
	struct tm *ptm; 
	memset( &atm, 0, sizeof( atm )); 
	atm.tm_year = theRev.RevisionDate.da_year - 1900; 
	atm.tm_mday = theRev.RevisionDate.da_day; 
	atm.tm_mon  = theRev.RevisionDate.da_mon - 1; 
	atime = mktime( &atm ); 
	atime += (long)days * 24l * 3600l; 
	ptm   = gmtime( &atime ); 
	theRev.RevisionDate.da_year = ptm -> tm_year + 1900; 
	theRev.RevisionDate.da_day = ptm -> tm_mday; 
	theRev.RevisionDate.da_mon = ptm -> tm_mon + 1;	 
} 
 
long rev_daysdiff ( revision theRev1, revision theRev2 ) 
{ 
	time_t atime1, atime2; 
	struct tm atm1, atm2; 
	memset( &atm1, 0, sizeof( atm1 )); 
	atm1.tm_year = theRev1.RevisionDate.da_year - 1900; 
	atm1.tm_mday = theRev1.RevisionDate.da_day; 
	atm1.tm_mon  = theRev1.RevisionDate.da_mon - 1; 
	atm1.tm_isdst = 1;
	atime1 = mktime( &atm1 ); 

	memset( &atm2, 0, sizeof( atm2 )); 
	atm2.tm_year = theRev2.RevisionDate.da_year - 1900; 
	atm2.tm_mday = theRev2.RevisionDate.da_day; 
	atm2.tm_mon  = theRev2.RevisionDate.da_mon - 1; 
	atm2.tm_isdst = 1;
	atime2 = mktime( &atm2 ); 

	return ( atime1 + 3600l - atime2 ) / ( 24l * 3600l );
}
