#include <mem.h>
#include <dos.h>

#include "common.h"

#include	"pins_ver.h"

int   CheckTrack;

unsigned    ShortDelay;
unsigned    FormatDelay;
unsigned    TestDma;

char        * SaveTrack;	// image of the track
char	    * PoolOrg;		// buffer, where Pool is taken from

char * Pool;			// never crosses segment boundary
int    SecNo;			// # of sectors per track
int    DiskResult;		// result of last disk operation
char	    * Garbage;		// for short sectors
char	    * PoolOrg;		// buffer, where Pool is taken from
char	    * Pool1;
char        * Pool1Org;

DPTtype far **DPTPtr = (DPTtype far **) 0x78L;	// address of diskette parameter block
int	      done;

BIOSResetDisk ( int Disk )
{
	asm mov ah, 	00h;
	asm mov dl, 	byte ptr Disk;
	asm int 	13h;
}

BIOSReadSector ( int Disk, int Head, int Track, int Sector, void * Buf )
{
//	int	res;

	asm push 	es;
	asm mov 	ah, 02h;
	asm mov 	al, 1;
	asm mov 	ch, byte ptr Track;
	asm mov 	cl, byte ptr Sector
	asm mov 	dh, byte ptr Head;
	asm mov 	dl, byte ptr Disk;
	asm les 	bx, Buf;
	asm int 	13h;
	asm jc  	error;
	asm xor 	ax, ax
error:	asm pop 	es;
	asm mov		al, ah;
	asm xor		ah, ah
//	asm mov		res, ax;

//	return res;
}

BIOSWriteSector ( int Disk, int Head, int Track, int Sector, void * Buf )
{
//	int	res;

	asm push 	es;
	asm mov 	ah, 03h;
	asm mov 	al, 1;
	asm mov 	ch, byte ptr Track;
	asm mov 	cl, byte ptr Sector
	asm mov 	dh, byte ptr Head;
	asm mov 	dl, byte ptr Disk;
	asm les 	bx, Buf;
	asm int 	13h;
	asm jc  	error;
	asm xor 	ax, ax
error:	asm pop 	es;
	asm mov		al, ah;
	asm xor		ah, ah
//	asm mov		res, ax;

//	return res;
}

BIOSFormat ( int Disk, int Head, int Track, int NumSectors, FormatTable * tbl )
{
//	int	res;

	asm mov 	ah, 05h;
	asm mov 	al, byte ptr NumSectors;
	asm mov 	ch, byte ptr Track;
	asm mov 	cl, 1;
	asm mov 	dh, byte ptr Head;
	asm mov 	dl, byte ptr Disk;
	asm push 	es;		// save old ES
	asm les 	bx, tbl;
	asm int 	13h;
	asm jc 		error;
	asm xor 	ax, ax;		// set AX to 0
error:  asm mov 	al, ah;
	asm xor 	ah, ah;
	asm pop 	es;		// restore AX
//	asm mov 	res, ax;

//	return res;
}

DPTtype far * SetMedia ( int Disk, int NumTracks, int SectorsPerTrack )
{
	int	offs, segm;

	asm push	es
	asm push	di
	asm mov		ah, 18h
	asm mov		dl, byte ptr Disk
	asm mov		ch, byte ptr NumTracks
	asm dec		ch
	asm mov		cl, byte ptr SectorsPerTrack
	asm int		13h
	asm jnc		ok
	asm xor		di, di
	asm mov		es, di
ok:	asm mov		offs, di
	asm mov		di, es
	asm mov		segm, di
	asm pop		di
	asm pop		es

	return ( DPTtype far * ) MK_FP ( segm, offs );
}

GetDiskType ( int Disk )
{
	BootRecord   Boot;
	unsigned     BiosRes;

	BIOSResetDisk ( Disk );
	BiosRes = BIOSReadSector ( Disk, 0, 0, 1, Pool );

	if ( BiosRes )
	{
		BIOSResetDisk ( Disk );
		BiosRes = BIOSReadSector ( Disk, 0, 0, 1, Pool );
	}

	if ( BiosRes )
		return FALSE;

	movmem ( Pool, &Boot, sizeof ( Boot ) );

	if ( (Boot.SectorSize != 512) || (Boot.HeadCount != 2) ||
	     (Boot.Media == 0) || (Boot.FatSize == 0) || (!((Boot.TrackSec == 15) ||
	     (Boot.TrackSec == 18) )))
	{
		DiskResult = 0x0B;
		return FALSE;
	}

	SecNo   = Boot.TrackSec;

	return TRUE;
}

CheckSeg ( char far * buf, int size )
{
	long	addr = ( ( (long) FP_SEG ( buf ) ) << 4 ) + (long) FP_OFF ( buf );

	return ( addr & 0x0000FFFFL ) + (long) size < 0x0000FFFFL;
}
