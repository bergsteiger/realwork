#ifndef false
#define		false	0x0000
#endif

#ifndef true
#define		true	0xFFFF
#endif

typedef struct tagStatusType
{
	char ST0, ST1, ST2, C, H, R, N;
} StatusType;

typedef struct tagDPTtype
{
	unsigned SpecBytes;
	char     MotorOffCount;
	char     BytesPerSector;
	char     SectorsPerTrack;
	char     GapLength;
	char     DataTransferLev;
	char     GapFormat;
	char     FillByte;
} DPTtype ;

typedef struct tagBootRecord
{
	char         JMPsignature;   // ��� �������� JMP
	unsigned     JMPaddress;     // ���� �������� JMP
	char         Name[8];        // ᨬ���쭮� ���
	unsigned     SectorSize;     // ���� � ᥪ��
	char         ClusterSize;    // ᥪ�஢ �� ������
	unsigned     ReservSize;     // ᥪ�஢ �� ��ࢮ� ����� FAT
	char         FatCount;       // �᫮ FAT ⠡���
	unsigned     RootSize;       // ���ᨬ��쭮� �᫮ 䠩��� � RootDir
	unsigned     TotalSector;    // ��饥 �᫮ ᥪ�஢ ����㯭�� DOS
	char         Media;          // ���ਯ�� ࠧ���
	unsigned     FatSize;        // �᫮ ᥪ�஢ � FAT
	unsigned     TrackSec;       // �᫮ ᥪ�஢ �� ��஦��
	unsigned     HeadCount;      // �᫮ ��஭ �� ��᪥�
	unsigned     HiddenSector;   // ᥪ�� ��१�ࢨ஢���� ��� Partition
} BootRecord;

typedef	struct tagFormatTable
{
	char Cyl;		// track number
	char Head;		// head number
	char Sector;		// sector number
	char Size;		// size ( 2 == 512 bytes )
} FormatTable;

extern unsigned    ShortDelay;//  = 0;
extern unsigned    FormatDelay;// = 0;
extern unsigned    TestDma;

extern char        * SaveTrack;		// image of the track
extern char	   * PoolOrg;		// buffer, where Pool is taken from

extern char * Pool;			// never crosses segment boundary
extern int    SecNo;			// # of sectors per track
//extern int    TrackNo;			// # of tracks per disk
extern int    DiskResult;		// result of last disk operation
extern char * SaveTrack;		// image of the track
extern char * Garbage;			// for short sectors
extern char * PoolOrg;			// buffer, where Pool is taken from
extern char * Pool1;
extern char * Pool1Org;

extern DPTtype far **DPTPtr;
extern int	      done;
////////////////////////////////////////////////////////////////////////////

BIOSResetDisk ( int Disk );
BIOSReadSector ( int Disk, int Head, int Track, int Sector, void * Buf );
BIOSWriteSector ( int Disk, int Head, int Track, int Sector, void * Buf );
BIOSFormat ( int Disk, int Head, int Track, int NumSectors, FormatTable * tbl );
DPTtype far * SetMedia ( int Disk, int NumTracks, int SectorsPerTrack );
GetDiskType ( int Disk );
CheckSeg ( char far * buf, int size );
