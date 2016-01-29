#if	!defined	__UPDATEDHREADER__
#define	__UPDATEDHREADER__

#include "dhreader.h"

class	UpdateDHReader
{
public:
	FILE*		pfDelta;
	DHReader*	dhReader;

	UpdateDHReader( char* );
	~UpdateDHReader();

	int	IsOK();
	short* LoadSegs( short& siCount );
	inline revision GetOldRev() { return dhReader -> GetOldRev(); }
	inline revision GetNewRev() { return dhReader -> GetNewRev(); }
};

#endif