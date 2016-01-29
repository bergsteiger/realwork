#include	<bios.h>
#include	<dos.h>
#include	<fcntl.h>
#include	<mem.h>
#include	<stdio.h>
#include	<stdlib.h>
#include	<string.h>
#include	<sys\stat.h>

#include "common.h"

int DisketteError;

DelLabel ( int Disk, int Track )
{
	FormatTable	Tbl [40];
	int		i;

	if ((SaveTrack = (char *) malloc (512)) == NULL)
		return FALSE;

	for ( i = 0; i < SecNo + 1; i++ )
	{
		Tbl [i].Cyl    = Track;
		Tbl [i].Head   = 0;

		Tbl [i].Sector = 1 + i;
		Tbl [i].Size   = 2;
	}

	do
		DiskResult = BIOSFormat (Disk, 0, Track, SecNo, &Tbl);
	while ( DiskResult == 3 );

	if ( DiskResult != 0 )
		{
		free ( SaveTrack );
		return FALSE;
		}
	BIOSReadSector (Disk, 0, Track, 1, SaveTrack);

	free ( SaveTrack );
	return TRUE;
}

