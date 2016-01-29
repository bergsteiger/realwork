/*
 * $Id: dhreader.h,v 2.8 2005/06/03 05:35:47 grigorio Exp $
 */

#ifndef __DLT_HEDAER__
#define __DLT_HEDAER__

#include "dhr_ver.h"

//#ifdef unix
//        #include <unistd.h>
//#endif

#include <cstdlib> // GARANT_GCC
#include <cstdio>
#include <cassert>

#include "gardefs.h"
#include "deltadef.h"

// Delta file status
#define DHRS_OK		0
#define DHRS_BADVER	1
#define DHRS_BADSIZE	2
#define DHRS_WRERR	3

class DeltaHeader {
public :
	DeltaHeader ( FILE* pfDelta ) {
		assert ( pfDelta );
		m_pfDelta = pfDelta;
	}
	~DeltaHeader () {}

protected :
	long m_lTextSize;
	short m_siDeltaVersion;
	int m_iValidSize;
	short m_siSegCount;	
	long m_lClassId;
	revision m_OldRev;
	revision m_NewRev;
	long m_lDocCount;
	short * m_pSegs;
	long m_lCRC;
	short m_siCrypt;

protected :
	FILE * m_pfDelta;
	unsigned long m_ulHeaderSize;
};

class DHReader : public DeltaHeader {
public :
	DHReader ( FILE* pfDelta, int iRewind = 0 );
	~DHReader ();

	inline short Version () { return m_siDeltaVersion; }
	inline revision GetOldRev () { return m_OldRev; }
	inline revision GetNewRev () { return m_NewRev; }
	inline long GetClassId () { return m_lClassId; }
	inline long GetDocCount () { return m_lDocCount; };
	int IsOK ();
	short * LoadSegs ( short & siCount ); // Caller must free after
	inline long GetCRC () { return m_lCRC; };
	inline short GetCrypt () { return m_siCrypt; };

	inline unsigned long HederSize () { return m_ulHeaderSize; };
};

class DHProtWriter : public DHReader {
public :
	DHProtWriter ( FILE* pfDelta, int iRewind = 0 ) : DHReader ( pfDelta, iRewind ) {};
	~DHProtWriter () {};
	long WriteProt ( long crc, short crypt );
};

#endif
