//#define S_VALID			1234567890L
#define SYS_INFO_SIGNATURE	54320U
//#define FIRST_SIZE		( (long)( 4096L * 25L ) )
//#define SECOND_SIZE		( (long)( 4096L *  5L ) )
//#define SKIP_SIZE		2048L

#define	Dsk12	0
#define Dsk144	1
#define Dsk360	2
#define Dsk720	3

#define MAGIC_PLACE		(sizeof(Info)+10000)
#define MAGIC_LENGTH		32

// values for Info.System
/*
#define GARANT			1
#define CUSTOMS			2
#define BANKS			3
#define GARANT_F		4
#define MOSCOW			5
#define LAND			6
#define GARANT_E		7
#define SPB			8
*/
typedef struct tagInfo
{
	int		Random;			// ramdom number
	char		ProgName [80];          // Program product name
	char		DelName  [80];          // Program product name
	char		PathName [80];		// default pathname
	unsigned long	FreeSpace;		// Free size on dest drive
	int		Year;			// year to set
	int		Month;			// month to set
	int		Day;			// day to set
//	unsigned	Dirs;			// # of dirs
//	unsigned	Files;			// # of files
	char		Company [50];		// registred to
	int		Net;			// 1 when network
	int		Banian;			// 1 when Vines Banyan
	int		Demo;			// 1 when Demo-version
	int		NetOneWork;		// 1 when one-user net
	int		Online;			// 1 when online
	char	Town [30];		// town for online
	int		System;			// see below

	char		reserved [300];
	char		PCKFileName [13];
	int			InstallCommon;
	unsigned	signature;
} Info;
