#include <dir.h>
#include <dos.h>
#include <mem.h>
#include <time.h>

int GetCode ( )
{
	struct ffblk	ffblk;
	int		done = findfirst ( "C:\\*.*", &ffblk, -1 );
	int		t = time ( NULL );

	t = t * t;
	while ( !done )
	{
		if ( ffblk.ff_attrib & FA_DIREC )
			return (ffblk.ff_ftime + t) & 0x7FFF;
		done = findnext ( &ffblk );
	}
	// else return something random
	return (ffblk.ff_ftime + t) & 0x7FFF;
}
