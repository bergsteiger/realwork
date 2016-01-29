#include "shared/Core/fix/mpcxc.h"
#include <dos.h>
#include <io.h>
#include <dir.h>
#include <string.h>
#include <stdio.h>
#include <bios.h>
#include <fcntl.h>
#include <share.h>

#include "qcrc.h"
#include "labels.h"
#include "myzip.h"

#define START_TRACK		1

int DelLabel (int Disk, int Track);
int GetLabel (int, int, void *, int);

// Common data
unsigned SIGNATURE1 [10] = {
	0x11A0, 0x12C5, 0x13B1, 0x1419, 0x15C8,
	0x1636, 0x2098, 0xA5D2, 0xFF00, 0xC5F0
	};
unsigned SIGNATURE2 [10] = {
	0xA5D0, 0x1665, 0x3129, 0x1525, 0x07A2,
	0x4729, 0xDBA7, 0x7821, 0xFEFF, 0xF0CB
	};

DATFile data;

static struct ftime ft;

int curTrack;
int mediaType;

////////////////////////////////////
int GetMediaType_ ( int );
////////////////////////////////////

void DecodeData (char *data, unsigned int len)
	{
	int i;

	for (i = 0; i < len; i++)
		{
		data [i] ^= 0xA5;
		data [i] ^= (i & 0xFF);
		}
	}

void EncodeData (char *data, unsigned int len)
	{
	int i;

	for (i = 0; i < len; i++)
		{
		data [i] ^= (i & 0xFF);
		data [i] ^= 0xA5;
		}
	}

void CodeDataWithID (char *data, unsigned int len, unsigned int code)
	{
	int i;

	for (i = 0; i < len; i++)
		if (i % 2)
			data [i] ^= (code & 0xFF);
		else
			data [i] ^= ((code & 0xFF00) >> 8);
	}

int ReadCheckData (int Floppy)
	{
	FILE *file;
	unsigned fhandle;
	int sdisk;

	mediaType = GetMediaType_ (Floppy);
	switch (mediaType)
		{
		case -1:
			return 0;		// unknown disk
		case Dsk360:
		case Dsk720:
			return 0;		// не поддерживаем
		}

	sdisk = getdisk ();
	setdisk (Floppy);
	file = fopen ("\\garant.dat", "r+b");
	if (!file)
		return 0;

	if (!fread (&data, sizeof (data), 1, file))
		{
		fclose (file);
		return 0;
		}
	fclose (file);

	fhandle = ace_os_open ("\\garant.dat", ACE_OS_O_RDONLY, SH_COMPAT);
	getftime (fhandle, &ft);
	ace_os_close (fhandle);

	DecodeData ((char *) &data, sizeof (data));
	CodeDataWithID ((char *) &data, sizeof (data) - 6, data.DiskID);

	if (prot_crc32 ((char *) &data, sizeof (data) - 4) != data.CRC)
		return 0;

	if (memcmp (data.sign1, SIGNATURE1, 20))
		return 0;

	if (memcmp (data.sign2, SIGNATURE2, 20))
		return 0;
	setdisk (sdisk);

	return 1;
	}

int WritePrepData (int Floppy)
	{
	FILE *file;
	unsigned int fhandle;
	int sdisk;

	data.CRC = prot_crc32 ((char *) &data, sizeof (data) - 4);
	CodeDataWithID ((char *) &data, sizeof (data) - 6, data.DiskID);
	EncodeData ((char *) &data, sizeof (data));

	sdisk = getdisk ();
	setdisk (Floppy);
	file = fopen ("\\garant.dat", "wb");
	if (!file)
		return 0;

	if (!fwrite (&data, sizeof (data), 1, file))
		{
		fclose (file);
		return 0;
		}
	fclose (file);
	fhandle = ace_os_open ("\\garant.dat", ACE_OS_O_RDWR, SH_COMPAT);
	setftime (fhandle, &ft);
	ace_os_close (fhandle);
	setdisk (sdisk);

	return 1;
	}

int IsKeyDisk (int Floppy)
	{
	char tmpbuf [20];

	return GetLabel (Floppy, 79 - (START_TRACK - 1), tmpbuf, 18);
	}

int CheckCopy (int Floppy, char *base, int cpType)
	{
	int labIndex;
	int  i;
	LabelRec lrLabel;

	if (!ReadCheckData (Floppy))
		return 0;

	labIndex = -1;

	for (i = 0; i < 80; i++)
		{
		if (!strcmpi (data.Lab[i].basename, base) &&
			(data.Lab[i].type == cpType))
			{
			labIndex = i;
			break;
			}
		}

	if (labIndex == -1)
		return 0;

	if (!GetLabel (Floppy, data.Lab[i].track, &lrLabel, sizeof (LabelRec)))
		return 0;

	if (strcmpi (lrLabel.basename, base) || (lrLabel.type != cpType))
		return 0;

	return 1;
	}

int DecreaseCopy (int Floppy, char *base, int cpType)
	{
	int labIndex;
	int  i;

	if (!ReadCheckData (Floppy))
		return 0;

	labIndex = -1;

	for (i = 0; i < 80; i++)
		{
		if (!strcmpi (data.Lab [i].basename, base) &&
			(data.Lab [i].type == cpType))
			{
			labIndex = i;
			break;
			}
		}

	if (labIndex == -1)
		return 0;

	if (!DelLabel (Floppy, data.Lab [i].track))
		return 0;

	data.Lab [i].type = LABEL_USED;
	data.Lab [i].basename [0] = 0;
	if (!WritePrepData (Floppy))
		return 0;

	return 1;
	}

GetMediaType_ ( int Floppy )
{
	struct fatinfo	diskinfo;

	getfat ( Floppy + 1, &diskinfo );

	if ( (diskinfo.fi_nclus > 2700) && (diskinfo.fi_nclus < 2880))
		return Dsk144;

	switch ( diskinfo.fi_nclus )
	{
		case 354 : return Dsk360;
		case 2371: return Dsk12 ;
//		case 2847: return Dsk144;
		case 713 : return Dsk720;
	}
	return -1;
}
