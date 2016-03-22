#ifndef __PROT401_H
#define __PROT401_H

// Sizes
#define SIZE_PROT_RECORDID  8
#define SIZE_COMPLECT_NAME  9
#define SIZE_PROT_REGFIELD  256
#define SIZE_PROT_USERINFO  512

// Version Types and flags
#define VERTYPE_LOCAL           1       // Local Version
#define VERTYPE_NET             2       // Net Version
#define VERTYPE_NET_ONEUSER     3       // One User Net Version
#define VERTYPE_DEMO		4       // Equal to Vines: for DemoVersion
#define VERTYPE_DEBUG		0
#define	VERTYPE_MASK		0x3

#define VERTYPE_READONLY        0x8000  // Read-Only Version (CDROM)

// Return Error Codes of "CheckProtInfo"
#define PROTFAULT_No_File               0x0001
#define PROTFAULT_DATA_dir_DateTime     0x0002
#define PROTFAULT_NDT_fName             0x0004
#define PROTFAULT_STR_fSize             0x0008
#define PROTFAULT_KEY_fSize             0x0010
#define PROTFAULT_NDT_fSize             0x0020
#define PROTFAULT_VerType               0x0040
#define PROTFAULT_HardwareID            0x0080
#define PROTFAULT_MustBeCD              0x0100

// ID of ComplectInfo structure
#define PROT_COMPL_STRUCT_ID            0x1234

// Return Error Codes
#define ERROR_BasesOrg_Not_Found        -1   // file "BASES.ORG" not found
#define ERROR_BasesOrg_Access_Denied    -1   // file "BASES.ORG" not found and can't create it
#define ERROR_Wrong_Size_Of_BasesOrg    -2   // wrong size of file "BASES.ORG"

// return error codes for complect
#define ERROR_Complect_Not_Found			 -3

// misc errorcodes
#define PROT401_ERR_READ_REGISTRY_PROBLEM 0x10
#define PROT401_ERR_GET_VERSION_EX_FAILED 0x11

extern char pathBasesOrigin[ MAX_PATH ];

#pragma pack(push,1)
struct PROTINFO
{
	short   DATA_dir_DateTime;              // date and time of DATA dir (packed to int)
	long    NDT_fSize;                      // Size of .NDT file
	long    KEY_fSize;                      // Size of .KEY file
	long    STR_fSize;                      // Size of .STR file
	short   VerType;                        // Version Type
	unsigned short    Reserved;				// Reserved
	unsigned short    HardwareID;			// ID of local machine
	char    NDT_fName [SIZE_PROT_RECORDID]; // Name of .NDT without path and extension
};  // sizeof ( PROTINFO ) = 28

struct GM_PROTINFO
{
	 short   DATA_dir_DateTime;				// date and time of DATA dir (packed to int)
	 char    GDB_fName [SIZE_PROT_RECORDID];// Name of .NDT without path and extension
	 long    GDB_fSize;						// Size of .STR file
	 short   VerType;						// Version Type
	 WORD    HardwareID;					// ID of local machine
	 WORD    Reserved;						// Reserved
};

struct COMPLECTINFO
{
	 WORD		StructID;
	 WORD		ComplectCount;
	 char		ComplectName[SIZE_COMPLECT_NAME];
	 WORD		ComplectWeight;
	 short		ComplectSet;
	 char		Bases[1][SIZE_COMPLECT_NAME];
};
#pragma pack(pop)

#ifdef __cplusplus
extern "C" {
#endif

void     GetSegments    ( void );
void     GetSelectors   ( void );

int      WriteUserInfo  ( const char*, const char* );
int      ReadUserInfo   ( char*, char* );

int      EnumProtInfo   ( char* );
int      ReadProtInfo   ( struct PROTINFO*, const char* );
unsigned CheckProtInfo 	( const struct PROTINFO*, const struct PROTINFO*);

void     GetProtInfo    ( struct PROTINFO*, const char*, int );
int      WriteProtInfo  ( const struct PROTINFO* );

int 	 WriteComplectInfo   ( const struct COMPLECTINFO * C_I );
int 	 ReadComplectInfo    ( struct COMPLECTINFO * C_I );

void     GM_GetProtInfo    ( struct GM_PROTINFO*, const char*, int );
int      GM_WriteProtInfo  ( const struct GM_PROTINFO* );

#ifdef __cplusplus
}
#endif

#endif	//__PROT401_H
