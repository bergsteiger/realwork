#ifndef __LABELS_H_
#define __LABELS_H_

#define	LABEL_LOC	1
#define	LABEL_NET	2
#define	LABEL_ONE	3
#define	LABEL_VB	4
#define	LABEL_USED	-1

#ifdef __cplusplus
extern "C" {
#endif

typedef struct tagLabelRec
	{
	char basename [9];
	int type;
	int track;
	} LabelRec;

// 40 - размер SIGNATURE1 и SIGNATURE2, 4 байта CRC 16 пароль
//char data [sizeof (LabelRec) * 80 + 40 + 4 + 16];

typedef struct tagDATFile
	{
	char sign1 [20];
	LabelRec Lab [80];
	char passwd [16];
	char sign2 [20];
	unsigned int DiskID;
	unsigned long CRC;
	} DATFile;

int IsKeyDisk (int Floppy);
int ResetDrive (int Floppy);
//#ifndef SETCOPY
int ReadPassword (int Floppy, char *str);
//#endif
int ReadFilePassword (int Floppy, char *str);
int WritePassword (int Floppy, char *str);
//#ifdef SHOWCOPY
int GetCopies (int Floppy, int IsCD);
//#endif
int CheckCopy (int Floppy, char *base, int cpType);
int CheckCopies (int Floppy, char *base, int *Loc, int *Net, int *One, int *VB);
int DecreaseCopy (int Floppy, char *base, int cpType);
int SetCopies (int Floppy, char *pwd);

#ifdef __cplusplus
}
#endif

#endif
