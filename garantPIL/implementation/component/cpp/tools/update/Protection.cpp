#include "stdafx.h"
#include "Protection.h"

#include <io.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

#include "garutils.h"

unsigned long  XOR_KEY = 1;

static	WORD GetFileComplectSize (HFILE file);
char	pathBasesOrigin[ MAX_PATH ] = "";

///////////////////////////////////////////////////////////////////////////

unsigned short BiosDateSum (void)
{
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
	else
	{
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

		RegCloseKey(hKey);
	}

	for (i = 0; i < size; i++)
		Res += (BYTE)buffer[i];			

	return Res;
}

void XorData (char * buf, unsigned len)
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

unsigned short GetComputerID (void)
{
	return BiosDateSum();
}

long GetFSize ( const char *PathToFile )
{
	HFILE input_file;
	long SizeOfFile;

	if (( input_file = _open( PathToFile,  _O_RDONLY | _O_BINARY )) == (-1) )
		return (-1);

	SizeOfFile = _filelength( input_file );
	_close( input_file );

	return SizeOfFile;
}

int WriteUserInfo ( const char * regOrg, const char * regNum )
{
	HFILE file;
	char aOrg [SIZE_PROT_REGFIELD],	aNum [SIZE_PROT_REGFIELD];
	int len_org = strlen (regOrg), len_num = strlen (regNum);
	for (int i = 0; i < SIZE_PROT_REGFIELD; i++) {
		aOrg [i] = (char) (crc ((void*)regOrg, len_org, i ? aOrg [i-1] : regOrg [0] + regNum [0]) & 0xFF);
		aNum [i] = (char) (crc ((void*)regNum, len_num, aOrg [i]) & 0xFF);
	}

	if ((file = _open ( pathBasesOrigin, O_WRONLY | O_BINARY )) == (-1) &&  (file = _open ( pathBasesOrigin, O_WRONLY | O_BINARY | O_CREAT, S_IWRITE )) == (-1))
		return ERROR_BasesOrg_Access_Denied;

	strcpy ( aOrg, regOrg );
	strcpy ( aNum, regNum );

	_lseek  ( file, 0,    SEEK_SET           );
	XorData ( aOrg,       SIZE_PROT_REGFIELD );
	_write  ( file, aOrg, SIZE_PROT_REGFIELD );

	XorData ( aNum,       SIZE_PROT_REGFIELD );
	_write  ( file, aNum, SIZE_PROT_REGFIELD );

	_close ( file );
	return 1;
}

int ReadUserInfo ( char * regOrg, char * regNum )
{
	HFILE file;
	if ((file = _open ( pathBasesOrigin,  O_RDONLY | O_BINARY )) == (-1) )
		return ERROR_BasesOrg_Not_Found;

	_lseek  ( file,   0,      SEEK_SET           );
	_read   ( file,   regOrg, SIZE_PROT_REGFIELD );
	XorData ( regOrg,         SIZE_PROT_REGFIELD );

	_read   ( file,   regNum, SIZE_PROT_REGFIELD );
	XorData ( regNum,         SIZE_PROT_REGFIELD );

	_close ( file );
	return 1;
}


int EnumProtInfo ( char* enumNDT )
{
	HFILE file;
	long fileSize;
	int i, recCount, recFound;
	long offProtInfo;

	if ((file = _open ( pathBasesOrigin,  O_RDONLY | O_BINARY )) == (-1) )
		return 0; // nothing to enumerate

	if ((fileSize = _filelength ( file )) <= SIZE_PROT_USERINFO )
	{
		_close(file);
		return 0; // nothing to enumerate
	}

	offProtInfo = GetFileComplectSize(file) + SIZE_PROT_USERINFO;
	_lseek (file, offProtInfo, SEEK_SET);
	recCount = ( (int)((fileSize-offProtInfo) / sizeof(struct PROTINFO)) );

	recFound = !strlen(enumNDT);
	for (i=0; i<recCount; i++)
	{
		struct PROTINFO P_I;

		_read( file, (char*)&P_I, sizeof(struct PROTINFO) );

		if( stricmp ( "PRIMARY", P_I.NDT_fName ) == 0 )
			continue;
		else
		if( recFound )
		{
			strcpy( enumNDT, P_I.NDT_fName );
			break;
		}
		else
		if ( stricmp ( enumNDT, P_I.NDT_fName ) ==0 )
		{
			recFound = 1;
			continue;
		}
	}

	_close (file);
	return ( i < recCount );
}

int ReadProtInfo ( struct PROTINFO * P_I, const char * pathNDT )
{
	HFILE file;
	long fileSize;
	int i,recCount;
	char nameNDT[ _MAX_FNAME ];
	long offProtInfo;

	char aPName[ SIZE_PROT_RECORDID + 1 ];
	char ndtName[ SIZE_PROT_RECORDID + 1 ];

	if ((file = _open ( pathBasesOrigin,  O_RDONLY | O_BINARY )) == (-1) )
		return ERROR_BasesOrg_Not_Found;

	if ((fileSize = _filelength ( file )) <= SIZE_PROT_USERINFO )
	{
		_close(file);
		return ERROR_Wrong_Size_Of_BasesOrg;
	}

	if(stricmp(pathNDT,"PRIMARY") != 0)
	{
		char drive [_MAX_DRIVE];
		char dir   [_MAX_DIR];
		char ext   [_MAX_EXT];

		_splitpath(pathNDT, drive, dir, nameNDT, ext);
	}
	else
		strcpy(nameNDT,pathNDT);

	offProtInfo = GetFileComplectSize(file) + SIZE_PROT_USERINFO;
	_lseek (file, offProtInfo, SEEK_SET);
	recCount = ( (int)((fileSize-offProtInfo) / sizeof(struct PROTINFO)) );

	for ( i=0; i < recCount; i++ )
	{
		_read ( file, (char*)P_I, sizeof(struct PROTINFO) );

		memcpy( aPName, P_I->NDT_fName, SIZE_PROT_RECORDID + 1 );
		aPName[ SIZE_PROT_RECORDID ] = '\0';
		
		memcpy( ndtName, nameNDT, SIZE_PROT_RECORDID + 1 );
		ndtName[ SIZE_PROT_RECORDID ] = '\0';

		if ( stricmp( aPName, ndtName ) == 0 )
			break;
	}

	_close (file);
	return ( i < recCount );
}

////////////////////////////////////////////////////////////////////////////
int WriteProtInfo ( const struct PROTINFO * P_I )
{
	HFILE file;
	long fileSize;
	long i,recCount;
	long offProtInfo;
	long FileOfs = 0;

	char aPName[ SIZE_PROT_RECORDID + 1 ];
	char fName[ SIZE_PROT_RECORDID + 1 ];

	if ( (file = _open ( pathBasesOrigin,  O_RDWR | O_BINARY, S_IWRITE )) == (-1) )
		return ERROR_BasesOrg_Not_Found;

	if ( (fileSize = _filelength ( file )) < SIZE_PROT_USERINFO )
	{
		_close(file);
		return ERROR_Wrong_Size_Of_BasesOrg;
	}

	offProtInfo = GetFileComplectSize(file) + SIZE_PROT_USERINFO;
	_lseek (file, offProtInfo, SEEK_SET);
	recCount = ( (int)((fileSize-offProtInfo) / sizeof(struct PROTINFO)) );

	for (i=0; i<recCount; i++)
	{
		struct PROTINFO FileProtInfo;

		_read( file, &FileProtInfo, sizeof(struct PROTINFO) );

		memcpy( aPName, P_I->NDT_fName, SIZE_PROT_RECORDID + 1 );
		aPName[ SIZE_PROT_RECORDID ] = '\0';
		
		memcpy( fName, FileProtInfo.NDT_fName, SIZE_PROT_RECORDID + 1 );
		fName[ SIZE_PROT_RECORDID ] = '\0';

		if ( stricmp ( aPName, fName ) == 0 )
		{
			FileOfs = _tell(file) - sizeof(struct PROTINFO);
			break;
		}
	}

	// Write PROTINFO
	if ( FileOfs != 0 )
		_lseek ( file, FileOfs, SEEK_SET );
	else
		_lseek ( file, 0, SEEK_END );

	_write ( file, (char*)P_I, sizeof (struct PROTINFO) );

	_close ( file );
	return 1;
}

////////////////////////////////////////////////////////////////////////////
void GetProtInfo ( struct PROTINFO * P_I, const char * NDTPath, int Ver )
{
	char drive [_MAX_DRIVE];
	char dir   [_MAX_DIR];
	char Name  [_MAX_FNAME];
	char ext   [_MAX_EXT];

	char DrivePlusDir  [_MAX_DRIVE + _MAX_DIR];
	char DrivePlusDir2 [_MAX_DRIVE + _MAX_DIR];

	char aNDTPath[_MAX_PATH]; 
	char aSTRPath[_MAX_PATH];
	char aKEYPath[_MAX_PATH];

	strcpy( aNDTPath, NDTPath );

	_splitpath (aNDTPath, drive, dir, Name, ext);

	// Create Drive Plus Path
	strcpy( DrivePlusDir, drive );
	strcat( DrivePlusDir, dir   );
	strcpy( DrivePlusDir2, DrivePlusDir);
	*(strchr(DrivePlusDir2, '\0')-1) = '\0';

	// Make Full Path to .STR file
	strcpy ( aSTRPath, drive    );
	strcat ( aSTRPath, dir      );
	strcat ( aSTRPath, Name     );
	strcpy ( aKEYPath, aSTRPath );

	P_I -> DATA_dir_DateTime = 0;
	strcpy ( P_I -> NDT_fName, Name );

	ForceExt( aSTRPath, "9TR" ); P_I -> STR_fSize = GetFSize ( aSTRPath );
	ForceExt( aKEYPath, "KEY" ); P_I -> KEY_fSize = GetFSize ( aKEYPath );
	ForceExt( aNDTPath, "0EY" ); P_I -> NDT_fSize = GetFSize ( aNDTPath );

	P_I -> VerType   = Ver;
	short xors [4] = {0x47, 0x52, 0xD4, 0x7B};
	P_I -> Reserved  = (unsigned short)((P_I->STR_fSize >> 8) & 0xFFFF);
	unsigned short xor_factor = P_I -> Reserved;
	P_I -> Reserved ^= xors [P_I -> VerType & 3];

	if ((Ver & VERTYPE_MASK) != VERTYPE_NET_ONEUSER) {
		P_I -> HardwareID = GetComputerID ();
		P_I -> HardwareID ^= xor_factor;
	} else {
		P_I -> HardwareID = 0;
		if ((Ver & 0x8000) == 0) {
			if (NDTPath [0]) {
				if (NDTPath [1] == ':') {
					char drive [4];
					strncpy (drive, NDTPath, 3);
					drive [3] = 0;

					char NameBuffer [MAX_PATH], SysNameBuffer[MAX_PATH];
					DWORD VSNumber, MCLength, FileSF;

					if (GetVolumeInformation (drive, NameBuffer, sizeof(NameBuffer), &VSNumber, &MCLength, &FileSF, SysNameBuffer, sizeof(SysNameBuffer))) {
						P_I -> HardwareID = ((unsigned short)(VSNumber >> 16)) ^ ((unsigned short) (VSNumber & 0xFFFF));
						P_I -> HardwareID ^= xor_factor;
					}
				} else if (NDTPath [0] == '\\') {
					char drive [MAX_PATH];
					const char *deli = strchr (NDTPath + 2, '\\');
					if (deli) deli = strchr (deli + 1, '\\');
					if (deli) {
						strncpy (drive, NDTPath, deli - NDTPath + 1);
						drive [deli - NDTPath + 1] = 0;

						char NameBuffer [MAX_PATH], SysNameBuffer[MAX_PATH];
						DWORD VSNumber, MCLength, FileSF;

						if (GetVolumeInformation (drive, NameBuffer, sizeof(NameBuffer), &VSNumber, &MCLength, &FileSF, SysNameBuffer, sizeof(SysNameBuffer))) {
							P_I -> HardwareID = ((unsigned short)(VSNumber >> 16)) ^ ((unsigned short) (VSNumber & 0xFFFF));
							P_I -> HardwareID ^= xor_factor;
						}
					}
				}
			}
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////
unsigned CheckProtInfo ( const struct PROTINFO *FileData, const struct PROTINFO *RealData )
{
	char fName[ SIZE_PROT_RECORDID + 1 ];
	char rName[ SIZE_PROT_RECORDID + 1 ];

	unsigned short unRdOnly;
	unsigned wCheckMask = 0;

	unRdOnly = FileData -> VerType & VERTYPE_READONLY;

	memcpy( fName, FileData->NDT_fName, SIZE_PROT_RECORDID + 1 );
	fName[ SIZE_PROT_RECORDID ] = '\0';
		
	memcpy( rName, RealData->NDT_fName, SIZE_PROT_RECORDID + 1 );
	rName[ SIZE_PROT_RECORDID ] = '\0';

	if ( stricmp ( fName, rName ) != 0  )
		wCheckMask|= PROTFAULT_NDT_fName;

	if ( (unRdOnly == 0) && ( ( ( FileData->VerType&0x0FFF ) == VERTYPE_LOCAL ) || ( ( FileData->VerType&0x0FFF) == VERTYPE_DEMO ) ) )
	{
		if ( FileData -> HardwareID != RealData -> HardwareID )
			wCheckMask|= PROTFAULT_HardwareID;
	}

	if ( FileData -> STR_fSize != RealData -> STR_fSize ) wCheckMask|= PROTFAULT_STR_fSize;
	if ( FileData -> KEY_fSize != RealData -> KEY_fSize ) wCheckMask|= PROTFAULT_KEY_fSize;
	if ( FileData -> NDT_fSize != RealData -> NDT_fSize ) wCheckMask|= PROTFAULT_NDT_fSize;
	if ( FileData -> VerType   != RealData -> VerType   ) wCheckMask|= PROTFAULT_VerType;
	if ( FileData -> Reserved  != RealData -> Reserved  ) wCheckMask|= PROTFAULT_VerType;

	return wCheckMask;
}


///////////////// C O M P L E C T   R O U T I N E S ////////////////////////

int write_insert ( HFILE src_handle,        // handle of source file
                        void *inserted_buf,      // inserted buffer
                        WORD inserted_buf_len,   // length of inserted buffer
                        long srcfile_ofs)        // where to place inserted buffer
                                                 //   (from beginning of file)
{

/*
        Return:  ( 1) - success
                 (-1) - can't create temporary file
                 (-2) - file_ofs is out of file
*/

	#define LOCAL_BUF_SIZE  512

	HFILE src,dest;
	WORD Big, Small, i;
	long SourceFileSize, TmpFileSize;
	char local_buf[LOCAL_BUF_SIZE];

	char	TmpFileName[ MAX_PATH ];
	strcpy( TmpFileName, pathBasesOrigin );
	TmpFileName[ strlen( pathBasesOrigin ) - 1 ] = '$';

	src  = src_handle;
	SourceFileSize = _filelength(src);

	if (SourceFileSize < srcfile_ofs)
		return (-2);

	///// create backup file with tail /////
	TmpFileSize = SourceFileSize - srcfile_ofs;

	Big   = (WORD)(TmpFileSize / LOCAL_BUF_SIZE    );
	Small = (WORD)(TmpFileSize - LOCAL_BUF_SIZE*Big);

	dest = _open(TmpFileName, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IREAD | S_IWRITE);

	if ( dest == (-1) )
		return (-1);

	_lseek (src, srcfile_ofs, SEEK_SET);

	if (Big>0)
	{
		for ( i=1; i<=Big; i++ )
		{
			_read  (src,  local_buf, LOCAL_BUF_SIZE);
			_write (dest, local_buf, LOCAL_BUF_SIZE);
		}
	}

	if (Small>0)
	{
		_read  (src,  local_buf, Small);
		_write (dest, local_buf, Small);
	}

	_close(dest);

	/////// write inserted_buf ///////
	src = src_handle;
	_lseek (src, srcfile_ofs, SEEK_SET);
	_write (src, inserted_buf, inserted_buf_len);

	/////// write saved tail ///////
	src  = _open(TmpFileName, O_RDONLY | O_BINARY );
	dest = src_handle;

	if (Big>0)
	{
		for ( i=1; i<=Big; i++ )
		{
			_read  (src,  local_buf, LOCAL_BUF_SIZE);
			_write (dest, local_buf, LOCAL_BUF_SIZE);
		}
	}

	if (Small>0)
	{
		_read  (src,  local_buf, Small);
		_write (dest, local_buf, Small);
	}

	_close  (src);                     // close temporary file
	_unlink (TmpFileName);     // unlink temporary file

	return 1;
}


////////////////////////////////////////////////////////////////////////////////////////////////////
int DeleteBlockFromFile ( int src_handle,          // handle of source file
                          long block_ofs,          // offset of block in file
                          long block_len)          // length of file

{
	#define LOCAL_BUF_SIZE  512

	HFILE src,dest;
	WORD Big, Small, i;
	long SourceFileSize, TmpFileSize;
	char local_buf[LOCAL_BUF_SIZE];

	char	TmpFileName[ _MAX_PATH ];
	strcpy( TmpFileName, pathBasesOrigin );
	TmpFileName[ strlen( pathBasesOrigin ) - 1 ] = '$';

	src  = src_handle;
	SourceFileSize = _filelength(src);

	// check source size
	if (SourceFileSize < block_ofs + block_len )
		return (-2);

	// stage #1 - save tail behind block
	TmpFileSize = SourceFileSize - block_ofs - block_len;

	Big   = (WORD)(TmpFileSize / LOCAL_BUF_SIZE    );
	Small = (WORD)(TmpFileSize - LOCAL_BUF_SIZE*Big);

	dest = _open(TmpFileName, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IREAD | S_IWRITE);

	_lseek (src, block_ofs + block_len, SEEK_SET);

	if ( dest == (-1) )
		return (-1);

	if (Big>0)
	{
		for ( i=1; i<=Big; i++ )
		{
			_read  (src,  local_buf, LOCAL_BUF_SIZE);
			_write (dest, local_buf, LOCAL_BUF_SIZE);
		}
	}

	if (Small>0)
	{
		_read  (src,  local_buf, Small);
		_write (dest, local_buf, Small);
	}

	_close(dest);

	// stage #2 - truncate source file
	src = src_handle;
	_chsize (src, block_ofs);

	// stage #3 - write saved tail
	src  = _open ( TmpFileName, O_RDONLY | O_BINARY );
	dest = src_handle;
	_lseek (dest, block_ofs, SEEK_SET);

	if (Big>0)
	{
		for ( i=1; i<=Big; i++ )
		{
			_read  (src,  local_buf, LOCAL_BUF_SIZE);
			_write (dest, local_buf, LOCAL_BUF_SIZE);
		}
	}

	if (Small>0)
	{
		_read  (src,  local_buf, Small);
		_write (dest, local_buf, Small);
	}

	_close(src);

	_unlink (TmpFileName);
	return 1;
}

////////////////////////////////////////////////////////////////////////////
int WriteComplectInfo ( const struct COMPLECTINFO * C_I )
{
	HFILE file;
	WORD file_compl_size = 0;   // size of Complect in "BASES.ORG"
	WORD new_compl_size = 0;    // size of new Complect

	if ( (file = _open ( pathBasesOrigin,  O_RDWR | O_BINARY, S_IWRITE )) == (-1) )
		return ERROR_BasesOrg_Not_Found;

	if ( _filelength(file) < SIZE_PROT_USERINFO )
	{
		_close(file);
		return ERROR_Wrong_Size_Of_BasesOrg;
	}

	file_compl_size = GetFileComplectSize(file);

	// if complect in "BASES.ORG" found - delete it
	if (file_compl_size != 0)
		DeleteBlockFromFile ( file, SIZE_PROT_USERINFO, file_compl_size );

	// calculate size of new complect
	new_compl_size =  sizeof(C_I->StructID) + sizeof(C_I->ComplectCount) + sizeof(C_I->ComplectName) + sizeof(C_I->ComplectWeight) + sizeof(C_I->ComplectSet) + SIZE_COMPLECT_NAME * C_I->ComplectCount;

	// write new complect in "BASES.ORG"
	write_insert ( file, (char*)C_I, new_compl_size, SIZE_PROT_USERINFO );

	_close ( file );
	return 1;
}

////////////////////////////////////////////////////////////////////////////
int ReadComplectInfo ( struct COMPLECTINFO * C_I )
{
	HFILE file;
	WORD complSize;

	if ((file = _open ( pathBasesOrigin,  O_RDONLY | O_BINARY )) == (-1) )
		return ERROR_BasesOrg_Not_Found;

	if ( _filelength(file) <= SIZE_PROT_USERINFO )
	{
		_close(file);
		return ERROR_Wrong_Size_Of_BasesOrg;
	}

	complSize = GetFileComplectSize(file);

	if (complSize == 0)
	{
		_close(file);
		return ERROR_Complect_Not_Found;
	}

	// read complect
	_lseek (file, SIZE_PROT_USERINFO, SEEK_SET);
	_read  (file, (char*)C_I, complSize);
	_close (file);

	return 1;
}


/////////////////////////////////////////////////////////////////////////
static WORD GetFileComplectSize (HFILE filehandle)
{
	WORD id;
	WORD compl_size = 0;
	BOOL isComplectInfo;
	char intSize[4];


	// set complect size to zero (no complect)
	compl_size = 0;

	// detect complect
	_lseek(filehandle, SIZE_PROT_USERINFO, SEEK_SET);
	_read (filehandle, (char*)&id, sizeof(id));
	isComplectInfo = (id == PROT_COMPL_STRUCT_ID);
	if (isComplectInfo == FALSE)
		return (0);

	// determine complect size
	_lseek(filehandle, (SIZE_PROT_USERINFO + 2l), SEEK_SET);
	memset(intSize, 0, sizeof(intSize));
	_read(filehandle, intSize, sizeof(intSize));
	compl_size = sizeof(WORD)*3 + sizeof(short) + SIZE_COMPLECT_NAME*(1 + *((short *)(intSize)));

	return compl_size;
}

void	GM_GetProtInfo ( struct GM_PROTINFO * P_I, const char * GDBPath, int Ver )
{
	char drive [_MAX_DRIVE];
	char dir   [_MAX_DIR];
	char Name  [_MAX_FNAME];
	char ext   [_MAX_EXT];

	char DrivePlusDir  [_MAX_DRIVE + _MAX_DIR];
	char DrivePlusDir2 [_MAX_DRIVE + _MAX_DIR];

	_splitpath (GDBPath, drive, dir, Name, ext);

	// Create Drive Plus Path
	strcpy  ( DrivePlusDir, drive );
	strcat  ( DrivePlusDir, dir   );
	strcpy(DrivePlusDir2, DrivePlusDir);
	*(strchr(DrivePlusDir2, '\0')-1) = '\0';

	// Make Full Path to .STR file

	P_I -> DATA_dir_DateTime = 0;

	strcpy ( P_I -> GDB_fName, Name );

	P_I -> GDB_fSize = GetFSize ( GDBPath );
	P_I -> VerType   = Ver;
	if ( (Ver&0x0FFF) == VERTYPE_LOCAL )
		P_I -> HardwareID = GetComputerID ();
	else
		P_I -> HardwareID = 0;
}

int	GM_WriteProtInfo ( const struct GM_PROTINFO * P_I )
{
	HFILE file;
	long fileSize;
	long i,recCount;
	long offProtInfo;
	long FileOfs = 0;

	if ( (file = open ( pathBasesOrigin,  O_RDWR | O_BINARY, S_IWRITE )) == (-1) )
		return ERROR_BasesOrg_Not_Found;

	if ( (fileSize = filelength ( file )) < SIZE_PROT_USERINFO ) {
		close(file);
		return ERROR_Wrong_Size_Of_BasesOrg;
	}

	offProtInfo = GetFileComplectSize(file) + SIZE_PROT_USERINFO;
	lseek (file, offProtInfo, SEEK_SET);
	recCount = ( (int)((fileSize-offProtInfo) / sizeof(struct GM_PROTINFO)) );

	for (i=0; i<recCount; i++) {
		struct GM_PROTINFO FileProtInfo;

		read( file, &FileProtInfo, sizeof(struct GM_PROTINFO) );
		if ( stricmp (P_I->GDB_fName, FileProtInfo.GDB_fName) == 0 ) {
			FileOfs = tell(file) - sizeof(struct GM_PROTINFO);
			break;
		}
	}

	// Write PROTINFO
	if ( FileOfs != 0 )
		lseek ( file, FileOfs, SEEK_SET );
	else
		lseek ( file, 0, SEEK_END );

	write ( file, (char*)P_I, sizeof (struct GM_PROTINFO) );

	close ( file );
	return 1;
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
