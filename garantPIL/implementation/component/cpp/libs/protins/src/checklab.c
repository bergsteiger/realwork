#include	<alloc.h>
#include	<bios.h>
#include	<dos.h>
#include	<dir.h>
#include	<direct.h>
#include	<fcntl.h>
#include	<mem.h>
#include	<stdio.h>
#include	<stdlib.h>
#include	<string.h>
#include	<sys\stat.h>

#include "common.h"
#include "labels.h"
#include "qcrc.h"

#define      Reanimate  *MotorCounter = 0xFF ;

#ifdef SETCOPY
	extern	char  far * MotorCounter;
#else
	char	far * MotorCounter = MK_FP ( 0x40, 0x40 );
#endif

int GetLabel (int Disk, int Track, void *lab, int labsize)
{
	DPTtype		MyDPT;
	DPTtype 	SaveDPT;
	DPTtype far   * tmp;
	int     far   * tseg;
	int     far   * tofs;
	int		i;
	int		GAPLen;
	int		IntDisk = Disk;
	unsigned long CRC;
	char *c;
//	char *aPool;
//	int sdisk;
//	struct ffblk fblk;

	memcpy (&SaveDPT, *DPTPtr, sizeof (DPTtype));
//	sdisk = getdisk ();
//	setdisk (IntDisk);
//	findfirst ("\\*.*", &fblk, 0xFF);
//	setdisk (sdisk);
	PoolOrg = malloc ( 16 * 1024 );
	if (!PoolOrg)
		return 0;

	if ( CheckSeg ( PoolOrg, 8*1024 ) )
//		{
		Pool = PoolOrg;
//		aPool = PoolOrg + 8*1024;
//		}
	else
//		{
		Pool = PoolOrg + 8*1024;
//		aPool = PoolOrg;
//		}

	if ( !GetDiskType ( IntDisk ) )
		if ( !GetDiskType ( 0 ) )
			{
			free (PoolOrg);
			return FALSE;
			}
		else
			IntDisk = 0;

	// Helps to avoid Error 04h while reading label sector
	BIOSReadSector ( IntDisk, 0, Track, 1, Pool );
	if ( ( tmp = SetMedia ( IntDisk, 80, SecNo ) ) == NULL )
	{
		tseg = MK_FP(0, 0x1E*4 + 2);
		tofs = MK_FP(0, 0x1E*4);
		tmp = MK_FP(*tseg, *tofs);
		tmp->SectorsPerTrack = SecNo;
		tmp->GapLength = (SecNo == 18) ? 0x1B : 0x2A;
		tmp->GapFormat = (SecNo == 18) ? 0x6C : 0x50;
	}

	memcpy ( &MyDPT, tmp, sizeof ( DPTtype ) );
	MyDPT.GapFormat       = 7;
	MyDPT.SectorsPerTrack = SecNo + 1;
	MyDPT.BytesPerSector  = 6;
	memcpy (*DPTPtr, &MyDPT, sizeof (DPTtype));
//	**DPTPtr = MyDPT;

	memset ( Pool, 0, 8*1024 );

	DiskResult = BIOSReadSector ( IntDisk, 0, Track, SecNo + 1, Pool );
//	sprintf (msg, "DiskResult: 0x%02X", DiskResult);
//	OkBox (msg);
/*	if (DiskResult == 0x80)
	{
		StartOperations ( IntDisk, 0, 0 );
		SetFDCparam ( 2, 7, 0xFF );
		SetCHRN ( Track, 0, SecNo + 1, 6 );
		Reanimate;
		ReadSector ( Pool );
	}
*/
//	BIOSReadSector ( IntDisk, 0, Track, 1, aPool );

	memcpy (*DPTPtr, &SaveDPT, sizeof (DPTtype));
//	BIOSResetDisk (IntDisk);
	memcpy (lab, Pool + 4, labsize);
	CRC = prot_crc32 (Pool, labsize + 4);
	if (CRC == *((unsigned long *) (Pool + 4 + labsize)))
		{
		for ( GAPLen = i = 514; Pool [i] == '\x4E'; i++ )
			GAPLen++;

		i = * ( int * ) ( Pool + 2 );		// old gap length

		if ( GAPLen == i )
			{
			free ( PoolOrg );

			c = (char *) lab;
			for (i = 0; i < labsize; i++)
				(*(c+i)) ^= 0xA5;
			return TRUE;
			}
//		else
//			OkBox ("GAP error");
		}
//	else
//		OkBox ("CRC error");
	free ( PoolOrg );
	return FALSE;
}

