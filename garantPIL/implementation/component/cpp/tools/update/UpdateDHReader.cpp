#include "stdafx.h"
#include "UpdateDHReader.h"

UpdateDHReader :: UpdateDHReader( char* aFileName )
{
	pfDelta = fopen( aFileName, "rb" );
	dhReader = new DHReader( pfDelta, 0 );
}

UpdateDHReader :: ~UpdateDHReader()
{
	fclose( pfDelta );
	delete dhReader;
}

int	UpdateDHReader :: IsOK()
{
	return	dhReader -> IsOK();
}

short* UpdateDHReader :: LoadSegs( short& siCount )
{
	return dhReader -> LoadSegs( siCount );
}