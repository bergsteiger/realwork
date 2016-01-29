#if !defined(__DELTA_COMMON_UTILS_H__)
#define __DELTA_COMMON_UTILS_H__ 1

#include <ctime> // GARANT_GCC
#include "gardefs.h"
#include "garutils.h"
#include "dhr_ver.h"
#include "rev.h"
#include "SplaySet.h"
#include "Logger.h"

/* // GARANT_GCC
#if defined (unix) || defined(__CYGWIN32__)
	#ifdef __CYGWIN32__
		#include <windows.h>
	#else
		#ifdef N_MALLOC
			#include "n_malloc.h"
		#else
			#ifdef	__USE_HOARD__

			#else
				#include "malloc.h"
			#endif
		#endif
	#endif
#elif defined (_WIN32)
	#if !defined(_WINDOWS_)
		#include <windows.h>
	#endif
#endif
*/

#ifdef __USE_HOARD__
#ifdef __cplusplus
extern "C" {
#endif

/* SVID2/XPG mallinfo structure */

struct mallinfo {
  int arena;    /* total space allocated from system */
  int ordblks;  /* number of non-inuse chunks */
  int smblks;   /* unused -- always zero */
  int hblks;    /* number of mmapped regions */
  int hblkhd;   /* total space in mmapped regions */
  int usmblks;  /* unused -- always zero */
  int fsmblks;  /* unused -- always zero */
  int uordblks; /* total allocated space */
  int fordblks; /* total non-inuse space */
  int keepcost; /* top-most, releasable (via malloc_trim) space */
};	
	
#ifdef __cplusplus
};  /* end of extern "C" */
#endif
#endif

struct log_struct {
	char* pDltName;
	char* pCompName;
	revision* pOldRev; 
	revision* pNewRev;
	char**     pArgv;
	int        iArgc;
	SplaySet<unsigned short>* segs;
};

inline void fprintTime ( FILE* file ) {
	struct tm *newtime;
	time_t aclock;
	::time( &aclock );
   	newtime = localtime( &aclock ); 
	fprintf ( file, "%s", asctime( newtime ) );
}

void fprintLog ( LogSession* plog, logtype_t type, log_struct* pStruct, char* pHeader, int iExtendetLog, int delta_version = DEFINE_DELTA_DATA_VERSION );

inline int FillDeltaName ( char* pName, revision theRev, revision theNewRev, char ext, int noName = 0 )
{	
	long days = rev_daysdiff ( theNewRev, theRev );
	assert ( days >= 0 );

	if ( noName ) {
		if ( days <= 99 )
			sprintf ( pName, ".%c%02d", ext, (int)days );
		else sprintf ( pName, ".%cXX",	ext );
	} else {
		if ( theRev.RevisionDate.da_year < 1900 ) return 0;
		theRev.RevisionDate.da_year -= 1900;
		if ( theRev.RevisionDate.da_year > 99 ) theRev.RevisionDate.da_year -= 100;
		if ( theRev.RevisionDate.da_year > 99 ) return 0;
		if ( theRev.RevisionDate.da_mon > 12 ||
			theRev.RevisionDate.da_day > 31 ) return 0;

		if ( days <= 99 )
			sprintf ( pName, "%02d%02d%02d.%c%02d", 		
				theRev.RevisionDate.da_day,
				theRev.RevisionDate.da_mon,
				theRev.RevisionDate.da_year,
				ext, (int)days );
		else sprintf ( pName, "%02d%02d%02d.%cXX",
				theRev.RevisionDate.da_day,
				theRev.RevisionDate.da_mon,
				theRev.RevisionDate.da_year,
				ext );
	}

	return 1;
}	

inline unsigned long getUsedPhsMem ( LogSession* plog = 0, logtype_t type = lt_debug )
{
#ifdef	WIN64
	u_int64_t	usedPhsMem;
#else
	unsigned long usedPhsMem;
#endif
#if defined (WIN32) // GARANT_WIN32
	MEMORYSTATUS memStat;
	GlobalMemoryStatus ( &memStat );
	if ( plog ) {
		plog->printf ( type, "\tpercent of memory in use:    %lu\n", memStat.dwMemoryLoad );
		plog->printf ( type, "\tbytes of physical memory:    %lu\n", memStat.dwTotalPhys );
		plog->printf ( type, "\tfree physical memory bytes:  %lu\n", memStat.dwAvailPhys );
		plog->printf ( type, "\tbytes of paging file:        %lu\n", memStat.dwTotalPageFile );
		plog->printf ( type, "\tfree bytes of paging file:   %lu\n", memStat.dwAvailPageFile );	
		plog->printf ( type, "\tuser bytes of address space: %lu\n", memStat.dwTotalVirtual );
		plog->printf ( type, "\tfree user bytes:             %lu\n", memStat.dwAvailVirtual );
	}
	usedPhsMem = (memStat.dwTotalPhys + memStat.dwTotalPageFile) - (memStat.dwAvailPhys + memStat.dwAvailPageFile);
#elif defined (__Linux__)
	if ( plog ) {
		plog->printf ( type, "\ttotal space in arena:            %lu\n", mallinfo().arena );
		plog->printf ( type, "\tnumber of ordinary blocks:       %lu\n", mallinfo().ordblks );
		plog->printf ( type, "\tnumber of small blocks:          %lu\n", mallinfo().smblks );
		plog->printf ( type, "\tspace in holding block headers:  %lu\n", mallinfo().hblkhd );
		plog->printf ( type, "\tnumber of holding blocks:        %lu\n", mallinfo().hblks );
		plog->printf ( type, "\tspace in small blocks in use:    %lu\n", mallinfo().usmblks );
		plog->printf ( type, "\tspace in free small blocks:      %lu\n", mallinfo().fsmblks );
		plog->printf ( type, "\tspace in ordinary blocks in use: %lu\n", mallinfo().uordblks );
		plog->printf ( type, "\tspace in free ordinary blocks:   %lu\n", mallinfo().fordblks );
		plog->printf ( type, "\tspace penalty if keep option:    %lu\n", mallinfo().keepcost );
	}
	usedPhsMem = mallinfo().uordblks;
#elif defined (__GO32__) 
	struct __dpmi_memory_info dmi;
	__dpmi_get_memory_information( &dmi );
	
	if ( plog ) {
		plog->printf ( type, "       total_allocated_bytes_of_physical_memory_host  = %lu\n", dmi.total_allocated_bytes_of_physical_memory_host );
		plog->printf ( type, "       total_allocated_bytes_of_virtual_memory_host   = %lu\n", dmi.total_allocated_bytes_of_virtual_memory_host );
		plog->printf ( type, "       total_available_bytes_of_virtual_memory_host   = %lu\n", dmi.total_available_bytes_of_virtual_memory_host );
		plog->printf ( type, "       total_allocated_bytes_of_virtual_memory_vcpu   = %lu\n", dmi.total_allocated_bytes_of_virtual_memory_vcpu );
		plog->printf ( type, "       total_available_bytes_of_virtual_memory_vcpu   = %lu\n", dmi.total_available_bytes_of_virtual_memory_vcpu );
		plog->printf ( type, "       total_allocated_bytes_of_virtual_memory_client = %lu\n", dmi.total_allocated_bytes_of_virtual_memory_client );
		plog->printf ( type, "       total_available_bytes_of_virtual_memory_client = %lu\n", dmi.total_available_bytes_of_virtual_memory_client );
		plog->printf ( type, "       total_locked_bytes_of_memory_client            = %lu\n", dmi.total_locked_bytes_of_memory_client );
		plog->printf ( type, "       max_locked_bytes_of_memory_client              = %lu\n", dmi.max_locked_bytes_of_memory_client );
		plog->printf ( type, "       highest_linear_address_available_to_client     = %lu\n", dmi.highest_linear_address_available_to_client );
		plog->printf ( type, "       size_in_bytes_of_largest_free_memory_block     = %lu\n", dmi.size_in_bytes_of_largest_free_memory_block );
		plog->printf ( type, "       size_of_minimum_allocation_unit_in_bytes       = %lu\n", dmi.size_of_minimum_allocation_unit_in_bytes );
		plog->printf ( type, "       size_of_allocation_alignment_unit_in_bytes     = %lu\n", dmi.size_of_allocation_alignment_unit_in_bytes );	
	}
	usedPhsMem = dmi.total_allocated_bytes_of_physical_memory_host + dmi.total_allocated_bytes_of_virtual_memory_host;
#else
	if ( plog ) plog->printf ( lt_error, "\tdon't know how to get memory statistics\n" );	
	usedPhsMem = 0;
#endif
	return (unsigned long)(usedPhsMem & 0xFFFFFFFF);
}

#endif
