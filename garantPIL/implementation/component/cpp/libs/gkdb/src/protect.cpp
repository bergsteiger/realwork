#include "shared/Core/fix/mpcxc.h"
#include "protect.h"
#include "osdep.h"
#include "garutils.h"
#include "pagefile.h"

#include "../../GPersn/src/PL_Types.h"

#include "shared/GCL/os/FileOp.h"
#include <string>
#include <set>

#include "ace/OS.h"

#include <iostream> // GARANT_TODO to std::cerr features not yet implememted across platform

#if defined (WIN32) || defined(_MSC_VER) 
#include	<devguid.h>
#include	<setupapi.h>
#pragma comment (lib, "setupapi.lib")
#endif

#define SIZE_PROT_RECORDID		8
#define SIZE_COMPLECT_NAME		9
#define SIZE_PROT_REGFIELD		256
#define SIZE_PROT_USERINFO		512
#define PROT_COMPL_STRUCT_ID	0x1234

#define VERTYPE_LOCAL           1       // Local Version
#define VERTYPE_NET             2       // Net Version
#define VERTYPE_NET_ONEUSER     3       // One User Net Version
#define	VERTYPE_WORKCD		0x8000
#define	VERTYPE_MASK		0x3

const WORD c_trial_bit= 0x0004U;
const WORD c_supermobile_bit = 0x0008U;

#define PROT401_ERR_READ_REGISTRY_PROBLEM 0x10
#define PROT401_ERR_GET_VERSION_EX_FAILED 0x11
#define ERROR_BasesOrg_Not_Found	-1   // file "BASES.ORG" not found
#define ERROR_BasesOrg_Access_Denied    -1   // file "BASES.ORG" not found and can't create it
#define ERROR_Wrong_Size_Of_BasesOrg    -2   // wrong size of file "BASES.ORG"
#define	ERROR_Complect_Not_Found	-3
#pragma	pack(push,1)
struct PROTINFO {
	short   DATA_dir_DateTime;              // date and time of DATA dir (packed to int)
	long    NDT_fSize;                      // Size of .NDT file
	long    KEY_fSize;                      // Size of .KEY file
	long    STR_fSize;                      // Size of .STR file
	short   VerType;                        // Version Type
	unsigned short    Reserved;				// Reserved
	unsigned short    HardwareID;			// ID of local machine
	char    NDT_fName [SIZE_PROT_RECORDID]; // Name of .NDT without path and extension
};  // sizeof ( PROTINFO ) = 28

struct COMPLECTINFO {
	 WORD		StructID;
	 WORD		ComplectCount;
	 char		ComplectName[SIZE_COMPLECT_NAME];
	 WORD		ComplectWeight;
	 short		ComplectSet;
	 char		Bases[1][SIZE_COMPLECT_NAME];
};
#pragma	pack(pop)

extern "C" {
	extern unsigned long adler32 (unsigned long adler, const unsigned char *buf, unsigned int len);
}

BasesOrgProtection :: BasesOrgProtection()
{
}

long GetFSize ( const char *PathToFile )
{
	int  input_file;
	long SizeOfFile;

	if (( input_file = ace_os_open( PathToFile,  ACE_OS_O_RDONLY | ACE_OS_O_BINARY )) == (-1) )
		return (-1);

	SizeOfFile = ace_os_filesize( input_file );
	ace_os_close( input_file );

	return SizeOfFile;
}

unsigned short BiosDateSum (void)
{
#if defined(_MSC_VER) || defined(WIN32)
	#define BIOSDATE_SIZE 8   /* MM/DD/YY */

	unsigned short Res = 0;

	BYTE buffer [11];
	int i;
	long result;
	HKEY hKey;
	long size;
	unsigned long lpType;
	OSVERSIONINFO ver;

	/* detect Windows NT */
	memset(&ver, 0, sizeof(ver));
	ver.dwOSVersionInfoSize = sizeof(ver);
	if (!GetVersionEx(&ver))
		return PROT401_ERR_GET_VERSION_EX_FAILED;

	if (ver.dwPlatformId != VER_PLATFORM_WIN32_NT)
		/* Win95, Win98 implementation (direct memory access) */
		memcpy (&buffer, (void*)0xFFFF5, BIOSDATE_SIZE);
	else {
		/* Windows NT implementation (read from regisrty) */
		result = RegOpenKeyEx(HKEY_LOCAL_MACHINE, "HARDWARE\\DESCRIPTION\\System", 0, KEY_QUERY_VALUE, &hKey);

		if (result != ERROR_SUCCESS)
			return PROT401_ERR_READ_REGISTRY_PROBLEM;

		size   = BIOSDATE_SIZE+1;
		lpType = REG_SZ;
		result = RegQueryValueEx(hKey, "SystemBiosDate", 0, (LPDWORD)&lpType, (LPBYTE)&buffer, (LPDWORD)&size);

		if (result != ERROR_SUCCESS) {
			RegCloseKey (hKey);
			result = RegOpenKeyEx(HKEY_LOCAL_MACHINE, "HARDWARE\\DESCRIPTION\\System\\BIOS", 0, KEY_QUERY_VALUE, &hKey);
			if (result == ERROR_SUCCESS) {
				size   = 11;
				lpType = REG_SZ;
				result = RegQueryValueEx (hKey, "BIOSReleaseDate", 0, (LPDWORD)&lpType, (LPBYTE)&buffer, (LPDWORD)&size);
				if (result != ERROR_SUCCESS)
					return PROT401_ERR_READ_REGISTRY_PROBLEM;
			} else {
				return PROT401_ERR_READ_REGISTRY_PROBLEM;
			}
		}

		RegCloseKey (hKey);
	}

	for (i=0; i < size; i++)
		Res += (BYTE)buffer [i];			

	return Res;
#elif defined(GARANT_MPCXC) // GARANT_TODO to be implemented; macro GARANT_MPCXC temporary ok
std::cerr<<"GARANT_TODO: *** gkdb protect.cpp BiosDateSum()=406 for grigorio ***"<<std::endl;
	return 406; // to be implemented soon // GARANT_XXX
#else
#error Platform not supported BiosDateSum().
#endif
}

unsigned short GetComputerID (void)
{
	return BiosDateSum();
}

unsigned short	GetComputerID_FS (const char *path)
{
	unsigned short result = 0;
#if defined(_MSC_VER) || defined(WIN32)
	if (path && path [0]) {
		char NameBuffer [MAX_PATH+1], SysNameBuffer[MAX_PATH+1];
		if (path [1] == ':') {
			char drive [4];
			strncpy (drive, path, 3);
			drive [3] = 0;

			DWORD VSNumber, MCLength, FileSF;
			if (GetVolumeInformation (drive, NameBuffer, sizeof(NameBuffer), &VSNumber, &MCLength, &FileSF, SysNameBuffer, sizeof(SysNameBuffer))) {
				result = ((unsigned short)(VSNumber >> 16)) ^ ((unsigned short) (VSNumber & 0xFFFF));
			}
		} else if (path [0] == '\\') {
			char drive [MAX_PATH];
			const char *deli = strchr (path + 2, '\\');
			if (deli) deli = strchr (deli + 1, '\\');
			if (deli) {
				strncpy (drive, path, deli - path + 1);
				drive [deli - path + 1] = 0;

				DWORD VSNumber, MCLength, FileSF;

				if (GetVolumeInformation (drive, NameBuffer, sizeof(NameBuffer), &VSNumber, &MCLength, &FileSF, SysNameBuffer, sizeof(SysNameBuffer))) {
					result = ((unsigned short)(VSNumber >> 16)) ^ ((unsigned short) (VSNumber & 0xFFFF));
				}
			}
		}
	}
#endif
	return result;
}

unsigned short	GetProtInfo ( struct PROTINFO * P_I, const char * NDTPath, int Ver = 1 )
{
	unsigned short	result = 0;

	std::string drive;
	std::string dir;
	std::string name;
	std::string ext;

	GCL::FileOp::splitpath (NDTPath, drive, dir, name, ext);

	std::string aBasePathName = drive + dir + name;

	// Make Full Path to .STR file
	std::string aSTRPath = aBasePathName + ".9tr"; // ForceExt replacement
	std::string aKEYPath = aBasePathName + ".key";
	std::string aNDTPath = aBasePathName + ".0ey";

	P_I -> DATA_dir_DateTime = 0;
	strncpy ( P_I -> NDT_fName, name.c_str(), SIZE_PROT_RECORDID);

	P_I -> STR_fSize = GetFSize ( aSTRPath.c_str() );
	P_I -> KEY_fSize = GetFSize ( aKEYPath.c_str() );
	P_I -> NDT_fSize = GetFSize ( aNDTPath.c_str() );

	P_I -> VerType   = Ver;
	short xors [4] = {0x47, 0x52, 0xD4, 0x7B};
	P_I -> Reserved  = (unsigned short)((P_I->STR_fSize >> 8) & 0xFFFF);
	unsigned short xor_factor = P_I -> Reserved;
	result = xor_factor;
	P_I -> Reserved ^= xors [P_I -> VerType & 3];

	if ( (Ver & VERTYPE_MASK) != VERTYPE_NET_ONEUSER) {
		P_I -> HardwareID = GetComputerID ();
		//unsigned short xor_factor = (unsigned short) ((xors [P_I -> VerType & 3] << (P_I -> VerType & 3)) & 0xFFFF);
		P_I -> HardwareID ^= xor_factor;
	} else {
		P_I -> HardwareID = 0;
		if ((Ver & VERTYPE_WORKCD) == 0) {
			unsigned short _fs = GetComputerID_FS (NDTPath);
			if (_fs) {
				P_I -> HardwareID = _fs;
				P_I -> HardwareID ^= xor_factor;
			}
		}
	}

	return xor_factor;
}

static WORD GetFileComplectSize (int filehandle)
{
	WORD id;
	WORD compl_size = 0;
	bool isComplectInfo;
	char intSize[4];


	// set complect size to zero (no complect)
	compl_size = 0;

	// detect complect
	ace_os_lseek(filehandle, SIZE_PROT_USERINFO, ACE_OS_SEEK_SET);
	ace_os_read (filehandle, (char*)&id, sizeof(id));
	isComplectInfo = (id == PROT_COMPL_STRUCT_ID);
	if (isComplectInfo == false)
		return (0);

	// determine complect size
	ace_os_lseek(filehandle, (SIZE_PROT_USERINFO + 2l), ACE_OS_SEEK_SET);
	memset(intSize, 0, sizeof(intSize));
	ace_os_read(filehandle, intSize, sizeof(intSize));
	compl_size = sizeof(WORD)*3 + sizeof(short) + SIZE_COMPLECT_NAME*(1 + *((short *)(intSize)));

	return compl_size;
}

int ReadProtInfo ( const char* pathBasesOrigin, struct PROTINFO * P_I, const char * pathNDT )
{
	int file;
	long fileSize;
	int i,recCount;
	long offProtInfo;

	if ((file = ace_os_open ( pathBasesOrigin,  ACE_OS_O_RDONLY | ACE_OS_O_BINARY )) == (-1) )
		return ERROR_BasesOrg_Not_Found;

	if ((fileSize = ace_os_filesize ( file )) <= SIZE_PROT_USERINFO ) {
		ace_os_close(file);
		return ERROR_Wrong_Size_Of_BasesOrg;
	}

	std::string drive, dir, nameNDT, ext;
	GCL::FileOp::splitpath(pathNDT, drive, dir, nameNDT, ext);

	offProtInfo = GetFileComplectSize(file) + SIZE_PROT_USERINFO;
	ace_os_lseek (file, offProtInfo, ACE_OS_SEEK_SET);
	recCount = ( (int)((fileSize-offProtInfo) / sizeof(struct PROTINFO)) );

	for ( i=0; i < recCount; i++ ) {
		ace_os_read ( file, (char*)P_I, sizeof(struct PROTINFO) );
		if ( strnicmp( P_I->NDT_fName, nameNDT.c_str (), SIZE_PROT_RECORDID) == 0 )
			break;
	}

	ace_os_close (file);
	return ( i < recCount );
}

int WriteProtInfo ( const char* pathBasesOrigin, const struct PROTINFO * P_I )
{
	int file;
	long fileSize;
	long i,recCount;
	long offProtInfo;
	long FileOfs = 0;

	char aPName[ SIZE_PROT_RECORDID + 1 ];
	char fName[ SIZE_PROT_RECORDID + 1 ];

	if ( (file = ace_os_open ( pathBasesOrigin,  ACE_OS_O_RDWR | ACE_OS_O_BINARY)) == (-1) )
		return ERROR_BasesOrg_Not_Found;

	if ( (fileSize = ace_os_filesize ( file )) < SIZE_PROT_USERINFO ) {
		ace_os_close(file);
		return ERROR_Wrong_Size_Of_BasesOrg;
	}

	offProtInfo = GetFileComplectSize(file) + SIZE_PROT_USERINFO;
	ace_os_lseek (file, offProtInfo, ACE_OS_SEEK_SET);
	recCount = ( (int)((fileSize-offProtInfo) / sizeof(struct PROTINFO)) );

	for (i=0; i<recCount; i++) {
		struct PROTINFO FileProtInfo;

		ace_os_read( file, &FileProtInfo, sizeof(struct PROTINFO) );

		strncpy ( aPName, P_I->NDT_fName, SIZE_PROT_RECORDID);
		strncpy ( fName, FileProtInfo.NDT_fName, SIZE_PROT_RECORDID);

		if ( strnicmp( aPName, fName, SIZE_PROT_RECORDID) == 0 ) {
			FileOfs = ace_os_tell(file) - sizeof(struct PROTINFO);
			break;
		}
	}

	// Write PROTINFO
	if ( FileOfs != 0 )
		ace_os_lseek ( file, FileOfs, ACE_OS_SEEK_SET );
	else
		ace_os_lseek ( file, 0, ACE_OS_SEEK_END );

	ace_os_write ( file, (char*)P_I, sizeof (struct PROTINFO) );

	ace_os_close ( file );
	return 1;
}

int ReadComplectInfo ( const char* pathBasesOrigin, struct COMPLECTINFO * C_I )
{
	int file;
	WORD complSize;

	if ((file = ace_os_open ( pathBasesOrigin,  ACE_OS_O_RDONLY | ACE_OS_O_BINARY )) == (-1) )
		return ERROR_BasesOrg_Not_Found;

	if ( ace_os_filesize(file) <= SIZE_PROT_USERINFO ) {
		ace_os_close(file);
		return ERROR_Wrong_Size_Of_BasesOrg;
	}

	complSize = GetFileComplectSize(file);

	if (complSize == 0) {
		ace_os_close(file);
		return ERROR_Complect_Not_Found;
	}

	// read complect
	ace_os_lseek (file, SIZE_PROT_USERINFO, ACE_OS_SEEK_SET);
	ace_os_read  (file, (char*)C_I, complSize);
	ace_os_close (file);

	return 1;
}

int BasesOrgProtection::write_protection (const char* base_path, bool is_base_exist) {
	int result = BasesOrgProtection::OK;

	ForceExt (strcpy (m_bases_origin_path, base_path), "org");
	if ( false == is_base_exist ) {
		PROTINFO selfInfo;
		GetProtInfo (&selfInfo, base_path);
		WriteProtInfo (m_bases_origin_path, &selfInfo);
	} else {
		PROTINFO orgInfo;
		if (ReadProtInfo (m_bases_origin_path, &orgInfo, base_path) != 1)
			return BasesOrgProtection::NO_ORG_FILE;
		
		PROTINFO selfInfo;
		GetProtInfo (&selfInfo, base_path, orgInfo.VerType);
		//selfInfo.HardwareID = orgInfo.HardwareID;
		selfInfo.VerType = orgInfo.VerType;
		WriteProtInfo (m_bases_origin_path, &selfInfo);
	}

	return result;
}

int BasesOrgProtection::tune_protection (const char* base_path) {
	int result = BasesOrgProtection::OK;
	ForceExt (strcpy (m_bases_origin_path, base_path), "org");
	PROTINFO orgInfo;
	if (ReadProtInfo (m_bases_origin_path, &orgInfo, base_path) != 1)
		return BasesOrgProtection::NO_ORG_FILE;

	PROTINFO selfInfo;
	GetProtInfo (&selfInfo, base_path, orgInfo.VerType);
	selfInfo.HardwareID = orgInfo.HardwareID;
	selfInfo.VerType = orgInfo.VerType;
	if (WriteProtInfo (m_bases_origin_path, &selfInfo) != 1)
		return BasesOrgProtection::NO_ORG_FILE;

	return result;
}

#if defined (WIN32) || defined(_MSC_VER) 
typedef BOOL (WINAPI *P_GDFSE)(LPCTSTR, PULARGE_INTEGER, PULARGE_INTEGER, PULARGE_INTEGER);

__int64	correctGetDiskFreeSpace( LPCTSTR aPath )
{
	P_GDFSE pGetDiskFreeSpaceEx = (P_GDFSE) GetProcAddress( GetModuleHandle( "kernel32.dll" ), "GetDiskFreeSpaceExA" );

	if ( pGetDiskFreeSpaceEx ) {
		LARGE_INTEGER aAvailSpace, aTotalSpace, aFreeSpace;	
		if ( pGetDiskFreeSpaceEx( aPath, (PULARGE_INTEGER)&aAvailSpace, (PULARGE_INTEGER)&aTotalSpace, (PULARGE_INTEGER)&aFreeSpace ))
			return aFreeSpace.QuadPart;
		else
			return 0;
	} else {
		DWORD	aSectorsPerCluster, aBytesPerSector, aFreeClusters, aTotalClusters;
		if ( GetDiskFreeSpace( aPath, &aSectorsPerCluster, &aBytesPerSector, &aFreeClusters, &aTotalClusters ))
			return (__int64)aFreeClusters * (__int64)aSectorsPerCluster * (__int64)aBytesPerSector;
		else
			return 0;
	}
}

__int64	correctGetDiskTotalSpace( LPCTSTR aPath )
{
	P_GDFSE pGetDiskFreeSpaceEx = (P_GDFSE) GetProcAddress( GetModuleHandle( "kernel32.dll" ), "GetDiskFreeSpaceExA" );
	if ( pGetDiskFreeSpaceEx ) {
		LARGE_INTEGER aAvailSpace, aTotalSpace, aFreeSpace;	
		if ( pGetDiskFreeSpaceEx( aPath, (PULARGE_INTEGER)&aAvailSpace, (PULARGE_INTEGER)&aTotalSpace, (PULARGE_INTEGER)&aFreeSpace ))
			return aTotalSpace.QuadPart;
		else
			return 0;
	} else {
		DWORD	aSectorsPerCluster, aBytesPerSector, aFreeClusters, aTotalClusters;
		if ( GetDiskFreeSpace( aPath, &aSectorsPerCluster, &aBytesPerSector, &aFreeClusters, &aTotalClusters ))
			return (__int64)aTotalClusters * (__int64)aSectorsPerCluster * (__int64)aBytesPerSector;
		else
			return 0;
	}
}
#endif

int BasesOrgProtection::check_protection (const char* base_path, bool check_hardware_id, bool check_work_cd, BasesOrgProtection::BaseVersion base_version) {
	std::string company, regnum;
	get_company_and_regnumber (base_path, company, regnum);
	unsigned int sum = 0, i;
	const unsigned char* _company = (const unsigned char*) company.c_str ();
	for (i = 0; i < company.size (); i++, _company++)
		sum += (unsigned int) *_company;
	sum <<= 16;
	const unsigned char* _regnum = (const unsigned char*) regnum.c_str ();
	for (i = 0; i < regnum.size (); i++)
		sum += (unsigned int) *_regnum;

	ForceExt (strcpy (m_bases_origin_path, base_path), "org");
	PROTINFO orgInfo, selfInfo;
	if (ReadProtInfo (m_bases_origin_path, &orgInfo, base_path) != 1)
		return BasesOrgProtection::NO_ORG_FILE;

	int result = BasesOrgProtection::OK;

	if ((orgInfo.VerType == 0) || ((orgInfo.VerType & VERTYPE_MASK) > 3))
		result |= BasesOrgProtection::BAD_HARDWARE_ID;

	short ver_type = orgInfo.VerType & VERTYPE_MASK;
	if (base_version != DONT_CHECK)
		if ((base_version == LOCAL && ver_type != VERTYPE_LOCAL) || (base_version == NET && ver_type != VERTYPE_NET) || (base_version == NET_ONEUSER && ver_type != VERTYPE_NET_ONEUSER))
			result |= BasesOrgProtection::BAD_NETWORK_VERSION;

	long xor_factor = GetProtInfo (&selfInfo, base_path, orgInfo.VerType);
	if (base_version == LOCAL) {
		selfInfo.HardwareID = GetComputerID ();
		selfInfo.HardwareID ^= xor_factor;
	}

	if (((ver_type == VERTYPE_LOCAL) || check_hardware_id) && !(orgInfo.VerType & VERTYPE_WORKCD) && (orgInfo.HardwareID != selfInfo.HardwareID)) {
		if (ver_type == VERTYPE_NET) {
			//if (strcmp (company.c_str (), "ОАО \"АК Транснефть\"") || strcmp (regnum.c_str (), "77-00501-000061"))
			if (sum != 228459321)
				result |= BasesOrgProtection::BAD_HARDWARE_ID;
		} else {
			result |= BasesOrgProtection::BAD_HARDWARE_ID;
		}
	}

	if (base_version == NET_ONEUSER && ((orgInfo.VerType & VERTYPE_WORKCD) == 0) && orgInfo.HardwareID != selfInfo.HardwareID)
		result |= BasesOrgProtection::BAD_HARDWARE_ID;

	if ((orgInfo.Reserved != selfInfo.Reserved) && ((orgInfo.VerType & VERTYPE_WORKCD) == 0))
		result |= BasesOrgProtection::BAD_HARDWARE_ID;

	if (orgInfo.KEY_fSize != selfInfo.KEY_fSize)
		result |= BasesOrgProtection::INVALID_KEY_SIZE;

	if (orgInfo.NDT_fSize != selfInfo.NDT_fSize)
		result |= BasesOrgProtection::INVALID_NDT_SIZE;

	if (orgInfo.STR_fSize != selfInfo.STR_fSize)
		result |= BasesOrgProtection::INVALID_STR_SIZE;

#if defined (WIN32) || defined(_MSC_VER) 
	// Work CD/DVD check
	if (check_work_cd && (orgInfo.VerType & VERTYPE_WORKCD)) {
		char drive [_MAX_DRIVE];

		if (base_path [0] == '\\') {
			::std::string company, regnum, crc;
			get_company_regnumber_crc (base_path, company, regnum, crc);
			unsigned real_crc = (unsigned) atol (crc.c_str ());
			const unsigned SEED_FOR_ADLER32 = 0x31304947;//(unsigned)"GI01";
			unsigned now_crc = adler32 (SEED_FOR_ADLER32, (unsigned char*) regnum.c_str (), regnum.size ());

			__int64 space = -1, free = -1;
			char *reg_num = strdup (regnum.c_str ()), *pos = strstr (reg_num, "~~");
			bool b_flashid = false;
			if (pos) {
				pos += 2;
				char* pos2 = strchr (pos, '|');
				if (pos2) {
					*pos2 = '\0';
					space = _atoi64 (pos);
					pos2 = strchr (pos = pos2 + 1, '|');
					if (pos2) {
						*pos2 = '\0';
						free = _atoi64 (pos);
						pos2 = strchr (pos = pos2 + 1, '|');
						if (pos2)
							b_flashid = true;
					}
				}
			}
			if (space == 0 && free == 0 && !b_flashid) {
				if (real_crc != now_crc)
					result |= BAD_MEDIA_TYPE;
				return result;
			}
		}

		_splitpath (base_path, drive, 0, 0, 0);
		drive [0] = toupper (drive[0]);

		struct _diskfree_t diskParams;
		if (((drive [0] >= 'A') && (drive [0] <= 'Z')) && (!_getdiskfree (drive [0]-'A'+1, &diskParams))) {
			__int64 freeSpace = (__int64)diskParams.avail_clusters*(__int64)diskParams.sectors_per_cluster*(__int64)diskParams.bytes_per_sector;
			__int64 totalSpace = (__int64)diskParams.total_clusters*(__int64)diskParams.sectors_per_cluster*(__int64)diskParams.bytes_per_sector;

			::std::string company, regnum, crc;
			get_company_regnumber_crc (base_path, company, regnum, crc);
			unsigned real_crc = (unsigned) atol (crc.c_str ());
			const unsigned SEED_FOR_ADLER32 = 0x31304947;//(unsigned)"GI01";
			unsigned now_crc = adler32 (SEED_FOR_ADLER32, (unsigned char*) regnum.c_str (), regnum.size ());
			if (real_crc != now_crc)
				result |= BAD_MEDIA_TYPE;

			char *reg_num = strdup (regnum.c_str ()), *pos = strstr (reg_num, "~~"), drive [_MAX_PATH];
			strcpy (drive, base_path);
			if ( strlen (drive) > 3 && drive [1] == ':' )
				drive [3] = '\0';
			if (pos) {
				pos += 2;
				char* pos2 = strchr (pos, '|');
				if (pos2) {
					*pos2 = '\0';
					__int64 space = _atoi64 (pos);
					pos = pos2 + 1, pos2 = strchr (pos, '|');
					if (pos2) {
						*pos2 = '\0';
						__int64 _free = _atoi64 (pos);

						bool to_check = true;
						if (_free + space != 0) {
							//размер диска и свободного места не должно отличаться больше, чем на 10 мегабайт
							freeSpace = correctGetDiskFreeSpace (drive), totalSpace = correctGetDiskTotalSpace (drive);
							const __int64 m10 = (__int64)10*1024*1024;
							if (_free) {
								if (freeSpace != totalSpace && (freeSpace > _free + m10 || freeSpace < _free - m10 || totalSpace > space + m10 || totalSpace < space - m10)) {
									result |= BAD_MEDIA_TYPE;
									to_check = false;
								}
							} else {
								if (totalSpace > space + m10 || totalSpace < space - m10) {
									result |= BAD_MEDIA_TYPE;
									to_check = false;
								}
							}
						}

						if (to_check) {
							pos = pos2 + 1;
							//теперь здесь метка, а потом через | - уникальный номер
							pos2 = strchr (pos, '|');
							char *volumelabel = 0;
							if (pos2) {
								*pos2 = '\0';
								volumelabel = strdup (pos);
								*pos2 = '|';
							} else {
								volumelabel = strdup (pos);
							}
							DWORD _VolumeSerialNumber, _MaximumComponentLength, _FileSystemFlags;
							GetVolumeInformation (drive, 0, 0, &_VolumeSerialNumber, &_MaximumComponentLength, &_FileSystemFlags, 0,0);
							if (strlen (volumelabel) && (atof (volumelabel) != (float)_VolumeSerialNumber)) {
								to_check = false;
								result |= BAD_MEDIA_TYPE;
							}
							free (volumelabel);

							if (to_check && pos2) {
								if (true/*GetDriveType(drive) == DRIVE_REMOVABLE*/) {
									pos = pos2+1; //по pos - уникальный номер флэшки
									std::set<std::string> unique_ids;

									HDEVINFO devs;
									devs = SetupDiGetClassDevs (0, 0, 0, DIGCF_PRESENT | DIGCF_ALLCLASSES);
									if (devs != INVALID_HANDLE_VALUE) {
										SP_DEVINFO_DATA devInfo;
										devInfo.cbSize = sizeof(devInfo);
										for (DWORD devIndex = 0; SetupDiEnumDeviceInfo (devs,devIndex,&devInfo); devIndex++) {
											char buff [264];
											if (SetupDiGetDeviceRegistryProperty (devs, &devInfo, SPDRP_DEVICEDESC, 0, (BYTE*) buff, 264, 0))
												if (SetupDiGetDeviceInstanceId(devs, &devInfo, buff, 264, 0)) {
													if (strstr (buff, "USBSTOR\\") == buff) {
														char* unique_id_trash = strrchr (buff, '\\') + 1;
														std::string unique_id;
														if (strchr (unique_id_trash, '&'))
															unique_id.assign (unique_id_trash, strchr (unique_id_trash, '&') - unique_id_trash);
														else
															unique_id.assign (unique_id_trash);
														unique_ids.insert (unique_id);
													}
												}
										}
										SetupDiDestroyDeviceInfoList (devs);
									}

									if (unique_ids.find (pos) == unique_ids.end ())
										result |= BAD_MEDIA_TYPE;
								} else {
									result |= BAD_MEDIA_TYPE;
								}
							}
						}
					} else {
						result |= BAD_MEDIA_TYPE;
					}
				} else {
					result |= BAD_MEDIA_TYPE;
				}
			} else {
				if ((freeSpace < 0) || (freeSpace > (__int64)20*1024*1024)) {
					result |= BAD_MEDIA_TYPE;
				}
			}
			free( reg_num );
		} else {
			result |= BAD_MEDIA_TYPE;
		}
	}
#else // GARANT_TODO to be implemented soon
		std::cerr<<"GARANT_TODO: get_free_space requested; nothing to do"<<std::endl;
#endif // defined (WIN32)

	return result;
}

void XorData( char * buf, const unsigned len )
{
	unsigned Key = 50;
	for (unsigned i = 0; i < len; ++i) {
		buf [i] ^= Key;
		Key += 2;
		if (Key > 240) {
			if (Key % 2)
				Key = 0;
			else
				Key = 1;
		}
	}
}

long	BasesOrgProtection::get_region (const char* base_path) {
	std::string company, regnum;	
	get_company_and_regnumber (base_path, company, regnum);
	char* reg = (char*) malloc (regnum.size ()+1);
	strcpy (reg, regnum.c_str ());
	long ret = 0;
	char *s1 = strtok (reg, "-");
	if (s1) {
		char* s2 = strtok (0, "-");
		if (s2) {
			char* s3 = strtok (0, "-");
			if (s3)
				ret = atol (s1);
		}
	}

	free (reg);
	return ret;
}

int	BasesOrgProtection::get_company_and_regnumber (const char* base_path, ::std::string& company, ::std::string& regnum, bool removeEx ) {
	ForceExt (strcpy (m_bases_origin_path, base_path), "org");

	int file;
	if ((file = ace_os_open (m_bases_origin_path, ACE_OS_O_RDONLY|ACE_OS_O_BINARY)) == (-1)) {
		return BasesOrgProtection::NO_ORG_FILE;
	}

	char tmp_org [256], tmp_reg [256];
	
	ace_os_lseek (file, 0, ACE_OS_SEEK_SET);
	ace_os_read (file, tmp_org, SIZE_PROT_REGFIELD);
	XorData (tmp_org, SIZE_PROT_REGFIELD);

	ace_os_read (file, tmp_reg, SIZE_PROT_REGFIELD);
	XorData (tmp_reg, SIZE_PROT_REGFIELD);

	ace_os_close (file);

	if ( removeEx ) {
		char* pos = strstr( tmp_reg, "~~" );
		if ( pos )
			*pos = '\0';
		pos = strstr( tmp_org, "~~" );
		if ( pos )
			*pos = '\0';
	}

	company = tmp_org;
	regnum  = tmp_reg;

	return BasesOrgProtection::OK;
}

int	BasesOrgProtection::get_company_regnumber_crc (const char* base_path, ::std::string& company, ::std::string& regnum, ::std::string& crc) {
	ForceExt (strcpy (m_bases_origin_path, base_path), "org");

	int file;
	if ((file = ace_os_open (m_bases_origin_path, ACE_OS_O_RDONLY|ACE_OS_O_BINARY)) == (-1)) {
		return BasesOrgProtection::NO_ORG_FILE;
	}

	char tmp_org [256], tmp_reg [256], tmp_crc [32];
	
	ace_os_lseek (file, 0, ACE_OS_SEEK_SET);
	ace_os_read (file, tmp_org, SIZE_PROT_REGFIELD);
	XorData (tmp_org, SIZE_PROT_REGFIELD);
	char* crc_ptr = tmp_org + strlen (tmp_org) + 1;
	if (*crc_ptr == 'N' && *(crc_ptr+1) == 'U' && *(crc_ptr+2) == 'M')
		strcpy (tmp_crc, crc_ptr+3);
	else
		tmp_crc [0] = '\0';

	ace_os_read (file, tmp_reg, SIZE_PROT_REGFIELD);
	XorData (tmp_reg, SIZE_PROT_REGFIELD);

	ace_os_close (file);

	company = tmp_org;
	regnum  = tmp_reg;
	crc     = tmp_crc;

	return BasesOrgProtection::OK;
}

int	BasesOrgProtection::is_work_cd (const char* base_path, bool& work_cd) {
	work_cd = false;

	PROTINFO orgInfo;

	ForceExt (strcpy (m_bases_origin_path, base_path), "org");
	if (ReadProtInfo (m_bases_origin_path, &orgInfo, base_path) != 1) {
		return BasesOrgProtection::NO_ORG_FILE;
	}

	if (orgInfo.VerType & VERTYPE_WORKCD) {
		work_cd = true;
	}

	return BasesOrgProtection::OK;
}

bool BasesOrgProtection::get_base_version (const char* base_path, BasesOrgProtection::BaseVersion& base_version, bool& is_work_cd) {
	ForceExt (strcpy (m_bases_origin_path, base_path), "org");

	PROTINFO orgInfo;
	if (ReadProtInfo (m_bases_origin_path, &orgInfo, base_path) != 1) {
		return false;
	}

	is_work_cd = false;
	if (VERTYPE_WORKCD == (orgInfo.VerType & VERTYPE_WORKCD)) {
		is_work_cd = true;
		orgInfo.VerType ^= VERTYPE_WORKCD;
	}
	if (VERTYPE_LOCAL == orgInfo.VerType) {
		base_version = LOCAL;
	} else if (VERTYPE_NET == orgInfo.VerType) {
		base_version = NET;
	} else if (VERTYPE_NET_ONEUSER == orgInfo.VerType) {
		base_version = NET_ONEUSER;
	} else {
		assert (0);
		return false;
	}

	return true;
}

int	BasesOrgProtection::is_noncommercial (const char* base_path, bool& is_noncommercial) {
	is_noncommercial = false;

	ForceExt (strcpy (m_bases_origin_path, base_path), "org");
	COMPLECTINFO *complectInfo = (COMPLECTINFO *)malloc (1024);

	if (ReadComplectInfo (m_bases_origin_path, complectInfo) != 1) {
		free (complectInfo);
		return BasesOrgProtection::NO_ORG_FILE;
	}

	const WORD c_noncommercial_bit = 0x8000U;
	is_noncommercial = (complectInfo->ComplectWeight & c_noncommercial_bit) != 0;

	free (complectInfo);
	return BasesOrgProtection::OK;
}

int BasesOrgProtection::is_trial (const char* base_path, bool& is_trial) {
	is_trial = false;

	ForceExt (strcpy (m_bases_origin_path, base_path), "org");
	COMPLECTINFO *complectInfo = (COMPLECTINFO *)malloc (1024);

	if (ReadComplectInfo (m_bases_origin_path, complectInfo) != 1) {
		free (complectInfo);
		return BasesOrgProtection::NO_ORG_FILE;
	}

	is_trial = (complectInfo->ComplectWeight & c_trial_bit) != 0;

	free (complectInfo);
	return BasesOrgProtection::OK;
}

int BasesOrgProtection::is_supermobile (const char* base_path, bool& is_supermobile) {
	/*
	is_supermobile = false;

	ForceExt (strcpy (m_bases_origin_path, base_path), "org");
	COMPLECTINFO *complectInfo = (COMPLECTINFO *)malloc (1024);

	if (ReadComplectInfo (m_bases_origin_path, complectInfo) != 1) {
		free (complectInfo);
		return BasesOrgProtection::NO_ORG_FILE;
	}

	is_supermobile = (complectInfo->ComplectWeight & c_supermobile_bit) != 0;

	free (complectInfo);
	*/

	is_supermobile = true;
	return BasesOrgProtection::OK;
}

int	BasesOrgProtection::get_flash_id (const char* base_path, std::string &unique_id)
{
	unique_id = "";

	ForceExt (strcpy (m_bases_origin_path, base_path), "org");
	PROTINFO orgInfo;
	if (ReadProtInfo (m_bases_origin_path, &orgInfo, base_path) != 1)
		return BasesOrgProtection::NO_ORG_FILE;

	::std::string company, regnum, crc;
	get_company_regnumber_crc (base_path, company, regnum, crc);

	char *reg_num = strdup (regnum.c_str ()), *pos = strstr (reg_num, "~~");
	if (pos) {
		pos = strchr (pos + 2, '|');
		if (pos) {
			pos = strchr (pos + 1, '|');
			if (pos) {
				pos = strchr (pos + 1, '|');
				if (pos)
					unique_id = pos + 1;
			}
		}
	}
	free( reg_num );

	return BasesOrgProtection::OK;
}

unsigned short BasesOrgProtection::get_hardware_id_fs (const char *path)
{
	return GetComputerID_FS (path);
}

int BasesOrgProtection::get_hardware_id (const char* base_path, short& hardware_id) {
	hardware_id = 0;
	///// Зачем в каждом методе выполняются 5 следующих строк мне неведомо, может Влад и Ко когда-нибудь захотят это разгрести
	PROTINFO orgInfo;
	ForceExt (strcpy (m_bases_origin_path, base_path), "org");
	if (ReadProtInfo (m_bases_origin_path, &orgInfo, base_path) != 1) {
		return BasesOrgProtection::NO_ORG_FILE;
	}
	//////
	hardware_id = orgInfo.HardwareID;
	return BasesOrgProtection::OK;
}

int WriteUserInfo (const char *m_bases_origin_path, const char * regOrg, const char * regNum )
{
	int file; 
	char aOrg [SIZE_PROT_REGFIELD],	aNum [SIZE_PROT_REGFIELD];
	int len_org = strlen (regOrg), len_num = strlen (regNum);
	for (int i = 0; i < SIZE_PROT_REGFIELD; i++) {
		aOrg [i] = (char) (crc ((void*)regOrg, len_org, i ? aOrg [i-1] : regOrg [0] + regNum [0]) & 0xFF);
		aNum [i] = (char) (crc ((void*)regNum, len_num, aOrg [i]) & 0xFF);
	}

	if ((file = ace_os_open (m_bases_origin_path, O_WRONLY | O_BINARY)) == -1)
		return ERROR_BasesOrg_Access_Denied;

	strcpy (aOrg, regOrg);
	strcpy (aNum, regNum);

	ace_os_lseek  (file, 0, SEEK_SET);
	XorData (aOrg, SIZE_PROT_REGFIELD);
	ace_os_write (file, aOrg, SIZE_PROT_REGFIELD);

	XorData (aNum, SIZE_PROT_REGFIELD);
	ace_os_write (file, aNum, SIZE_PROT_REGFIELD);

	ace_os_close (file);

	return 0;
}

void	BasesOrgProtection::write_company (const char* base_path, const char* company) {
	std::string old_company, regnum;
	get_company_and_regnumber (base_path, old_company, regnum);

	int result = BasesOrgProtection::OK;
	ForceExt (strcpy (m_bases_origin_path, base_path), "org");
	WriteUserInfo (m_bases_origin_path, company, regnum.c_str ());
}

