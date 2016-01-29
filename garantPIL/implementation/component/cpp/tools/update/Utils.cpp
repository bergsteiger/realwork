#include "stdafx.h"

#include "Utils.h"
#include "shlobj.h"

#ifndef BRDR32
	#include "Resource.h"
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
	#ifndef BRDR32
		static char THIS_FILE[] = __FILE__;
	#endif
#endif

char*	ReplaceSlashes( char* aPath )
{
	for ( unsigned I = 0; I < strlen( aPath ); I++ )
		if ( aPath[ I ] == '\\' )
			aPath[ I ] = '-';
	return aPath;
}

char*	KillSlashes( char *resultPath, char *srcPath )
{
	int	aSlashCount = 0;
	int	aPathPtr    = 0;
	for ( unsigned I = 0; I <= strlen( srcPath ); I++ )
	{
		char aChar = srcPath[ I ];
		if ( aChar == '\\' ) aSlashCount++; else aSlashCount = 0;
		if ( aSlashCount < 2 || I < 2 )
			resultPath[ aPathPtr++ ] = aChar;
	}
	return resultPath;
}

char*	MakePath( char *path, char *dir, char *file )
{
	char	*aResult = new char[ strlen( dir ) + strlen( file ) + 2 ];
	strcat( strcat( strcpy( aResult, dir ), "\\" ), file );
	KillSlashes( path, aResult );
	delete []aResult;
	return path;
}

int	FileExist( char *name )
{
	WIN32_FIND_DATA findData;
	HANDLE	aResult = FindFirstFile( name, &findData );
	FindClose( aResult );
	return aResult != INVALID_HANDLE_VALUE;
}

LPITEMIDLIST	PidlBrowse( HWND hwnd, int nCSIDL, LPSTR pszDisplayName, int aTitleID )
{
	char	aCurrentDirectory[ MAX_PATH ];
	DWORD aGetCurDir = GetCurrentDirectory( MAX_PATH, aCurrentDirectory );
	
	LPITEMIDLIST	pidlRoot = NULL;
	LPITEMIDLIST	pidlSelected = NULL;
	BROWSEINFO		bi = {0};
	LPMALLOC		pMalloc = NULL;

	SHGetMalloc( &pMalloc );

	if ( nCSIDL )
		SHGetSpecialFolderLocation( hwnd, nCSIDL, &pidlRoot );
	else
		pidlRoot = NULL;

	bi.hwndOwner = hwnd;
	bi.pidlRoot = pidlRoot;
	bi.pszDisplayName = pszDisplayName;
	CString	aTitle;
	aTitle.LoadString( aTitleID );
	bi.lpszTitle = aTitle.GetBuffer( 0 );
	bi.ulFlags = BIF_RETURNONLYFSDIRS | BIF_BROWSEINCLUDEURLS | BIF_USENEWUI | BIF_BROWSEINCLUDEFILES | BIF_NONEWFOLDERBUTTON;
	bi.lpfn = NULL;
	bi.lParam = 0;

	pidlSelected = SHBrowseForFolder( &bi );

	if ( pidlRoot )
		pMalloc -> Free( pidlRoot );

	pMalloc -> Release();

	if ( aGetCurDir )
		SetCurrentDirectory( aCurrentDirectory );

	return pidlSelected;
}

DWORD	FileSize( CString aFileName )
{
	WIN32_FIND_DATA	aFindData;
	HANDLE	aFile = FindFirstFile( aFileName, &aFindData );
	if ( aFile != INVALID_HANDLE_VALUE )
	{
		FindClose( aFile );
		return aFindData.nFileSizeLow;
	}
	else
		return 0;
}

char*	ForceExt( char* name, char* ext )
{
	int i = 0; // GARANT_FORSCOPING
	for ( i = 0; name[ i ] != '\0'; i++ )
		;

	if ( i > 0 )
		for ( i--; name[ i ] != '.' &&name[ i ] != '\\' && i > 0; i-- )
			;

	if ( name[ i ] == '.' )
		strcpy( name + i + 1, ext );
	else
		strcat( strcat( name, "." ), ext );

	return name;
}

static unsigned char Win2DosTable[] = {
	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0A\x0B\x0C\x0D\x0E\x0F" \
	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1A\x1B\x1C\x1D\x1E\x1F" \
	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2A\x2B\x2C\x2D\x2E\x2F" \
	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3A\x3B\x3C\x3D\x3E\x3F" \
	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4A\x4B\x4C\x4D\x4E\x4F" \
	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5A\x5B\x5C\x5D\x5E\x5F" \
	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6A\x6B\x6C\x6D\x6E\x6F" \
	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7A\x7B\x7C\x7D\x7E\x7F" \
	"\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8A\x8B\x8C\x8D\x8E\x8F" \
	"\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9A\x9B\x9C\x9D\x9E\x9F" \
	"\x20\xAD\x9B\x9C\x0F\x9D\xDD\x15\x22\x63\xA6\xAE\xAA\x2D\x72\x5F" \
	"\xF8\xF1\xFD\x33\x27\xE6\x14\xFA\x2C\x31\xA7\xAF\xAC\xAB\x5F\xA8" \
	"\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8A\x8B\x8C\x8D\x8E\x8F" \
	"\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9A\x9B\x9C\x9D\x9E\x9F" \
	"\xA0\xA1\xA2\xA3\xA4\xA5\xA6\xA7\xA8\xA9\xAA\xAB\xAC\xAD\xAE\xAF" \
	"\xE0\xE1\xE2\xE3\xE4\xE5\xE6\xE7\xE8\xE9\xEA\xEB\xEC\xED\xEE\xEF" };

static unsigned char Dos2WinTable[ 256 ] = {
	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0xA4,
	0x10, 0x11, 0x12, 0x13, 0xB6, 0xA7, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F,
	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F,
	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F,
	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F,
	0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F,
	0xC0, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xCA, 0xCB, 0xCC, 0xCD, 0xCE, 0xCF,
	0xD0, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9, 0xDA, 0xDB, 0xDC, 0xDD, 0xDE, 0xDF,
	0xE0, 0xE1, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9, 0xEA, 0xEB, 0xEC, 0xED, 0xEE, 0xEF,
	0x5F, 0x5F, 0x5F, 0xA6, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F,
	0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F,
	0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0xA6, 0x5F, 0x5F,
	0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9, 0xFA, 0xFB, 0xFC, 0xFD, 0xFE, 0xFF,
	0x5F, 0xB1, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0xB0, 0xB7, 0xB7, 0x5F, 0x6E, 0xB2, 0xA8, 0x5F };

static unsigned char Koi2DosTable[ 256 ] = {
	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,	0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,	0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,	0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,	0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F,
	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,	0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F,
	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57,	0x58, 0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F,
	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,	0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F,
	0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77,	0x78, 0x79, 0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F,
	0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,	0x88, 0x89, 0x8A, 0x8B, 0x8C, 0x8D, 0x8E, 0x8F,
	0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,	0x98, 0x99, 0x9A, 0x9B, 0x9C, 0x9D, 0x9E, 0x9F,
	0xA0, 0xA1, 0xA2, 0xF1, 0xA4, 0xA5, 0xA6, 0xA7,	0xA8, 0xA9, 0xAA, 0xAB, 0xAC, 0xAD, 0xAE, 0xAF,
	0xB0, 0xB1, 0xB2, 0xF0, 0xB4, 0xB5, 0xB6, 0xB7,	0xB8, 0xB9, 0xBA, 0xBB, 0xBC, 0xBD, 0xBE, 0xBF,
	0xEE, 0xA0, 0xA1, 0xE6, 0xA4, 0xA5, 0xE4, 0xA3,	0xE5, 0xA8, 0xA9, 0xAA, 0xAB, 0xAC, 0xAD, 0xAE,
	0xAF, 0xEF, 0xE0, 0xE1, 0xE2, 0xE3, 0xA6, 0xA2,	0xEC, 0xEB, 0xA7, 0xE8, 0xED, 0xE9, 0xE7, 0xEA,
	0x9E, 0x80, 0x81, 0x96, 0x84, 0x85, 0x94, 0x83,	0x95, 0x88, 0x89, 0x8A, 0x8B, 0x8C, 0x8D, 0x8E,
	0x8F, 0x9F, 0x90, 0x91, 0x92, 0x93, 0x86, 0x82,	0x9C, 0x9B, 0x87, 0x98, 0x9D, 0x99, 0x97, 0x9A
};

void	Dos2Win( CString& aString )
{
	for ( short I = 0; I < aString.GetLength(); I++ )
		aString.SetAt( I, Dos2WinTable[ (unsigned char) aString.GetAt( I ) ] );
}

void	Dos2Win( char* aString )
{
	for ( size_t I = 0; I < strlen( aString ); I++ )
		aString[ I ] = Dos2WinTable[ (unsigned char) aString[ I ]];
}

void	Win2Dos( char* aString )
{
	for ( size_t I = 0; I < strlen( aString ); I++ )
		aString[ I ] = Win2DosTable[ (unsigned char) aString[ I ]];
}

void	Koi2Win( CString& aString )
{
	for ( short I = 0; I < aString.GetLength(); I++ )
		aString.SetAt( I, Dos2WinTable[ Koi2DosTable[ (unsigned char) aString.GetAt( I ) ]] );
}

int		MyCreateDirectory( char* aFileName )
{
	char	aBuffer[ MAX_PATH ];
	strcpy( aBuffer, aFileName );
	char*	ptr = aBuffer;

	while (( ptr = strchr( ptr, '\\' )) != NULL )
	{
		*ptr   = '\0';
		CreateDirectory( aBuffer, NULL );
		*ptr++ = '\\';
	}

	return 1;
}

void	RemoveDirectoryEx( char* aDirectory )
{
	char	aMask[ MAX_PATH ];
	MakePath( aMask, aDirectory, "*.*" );
	WIN32_FIND_DATA	findData;
	HANDLE	aFindResult = FindFirstFile( aMask, &findData );
	while ( aFindResult != INVALID_HANDLE_VALUE )
	{
		if ( ( findData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY ) != 0 && strcmp( findData.cFileName, "." ) && strcmp( findData.cFileName, ".." ) )
		{
			char	aNewDirectory[ MAX_PATH ];
			MakePath( aNewDirectory, aDirectory, findData.cFileName );
			RemoveDirectoryEx( aNewDirectory );
		}

		if ( !FindNextFile( aFindResult, &findData ))
			break;
	}
	FindClose( aFindResult );
	RemoveDirectory( aDirectory );
}

void	RemoveFilesInDirectory( char* aDirectory )
{
	char	aMask[ MAX_PATH ];
	MakePath( aMask, aDirectory, "*.*" );

	WIN32_FIND_DATA	findData;
	HANDLE	aFindResult = FindFirstFile( aMask, &findData );
	while ( aFindResult != INVALID_HANDLE_VALUE )
	{
		if ( ( findData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY ) == 0 )
		{
			char	aFileName[ MAX_PATH ];
			MakePath( aFileName, aDirectory, findData.cFileName );
			MyDeleteFile( aFileName );
		}

		if ( !FindNextFile( aFindResult, &findData ))
			break;
	}
	FindClose( aFindResult );
}

void	RemoveDirectoryWithFiles( char* aDirectory )
{
	char	aMask[ MAX_PATH ];
	MakePath( aMask, aDirectory, "*.*" );
	WIN32_FIND_DATA	findData;
	HANDLE	aFindResult = FindFirstFile( aMask, &findData );
	RemoveFilesInDirectory( aDirectory );
	while ( aFindResult != INVALID_HANDLE_VALUE )
	{
		if ( ( findData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY ) != 0 && strcmp( findData.cFileName, "." ) && strcmp( findData.cFileName, ".." ) )
		{
			char	aNewDirectory[ MAX_PATH ];
			MakePath( aNewDirectory, aDirectory, findData.cFileName );
			RemoveFilesInDirectory( aNewDirectory );
			RemoveDirectoryWithFiles( aNewDirectory );
		}

		if ( !FindNextFile( aFindResult, &findData ))
			break;
	}
	FindClose( aFindResult );
}

BOOL	IsPath( char* aPath )
{
	if ( aPath[ 0 ] == '\"' ) aPath++;
	return ( aPath[ 1 ] == ':'  || ( aPath[ 0 ] == '\\' && aPath[ 1 ] == '\\' ));
}

void	TunePath( char* aPath )
{
	if ( aPath[ 0 ] == '\"' ) {
		char* aCopy = strdup( aPath + 1 );
		strcpy( aPath, aCopy );
		free( aCopy );
	}
	if ( aPath[ strlen( aPath ) - 1 ] = '\"' )
		aPath[ strlen( aPath ) - 1 ] = '\0';
}

BOOL	MyDeleteFile( char* aFileName )
{
	DWORD	aAttrib = GetFileAttributes( aFileName );
	if ( aAttrib & FILE_ATTRIBUTE_READONLY )
		SetFileAttributes( aFileName, aAttrib & !FILE_ATTRIBUTE_READONLY );
	return DeleteFile( aFileName );
}

BOOL	MyDeleteFile( CString aFileName )
{
	DWORD	aAttrib = GetFileAttributes( aFileName );
	if ( aAttrib & FILE_ATTRIBUTE_READONLY )
		SetFileAttributes( aFileName, aAttrib & !FILE_ATTRIBUTE_READONLY );
	return DeleteFile( aFileName );
}

typedef BOOL (WINAPI *P_GDFSE)(LPCTSTR, PULARGE_INTEGER, PULARGE_INTEGER, PULARGE_INTEGER);

LONGLONG MyGetDiskFreeSpace( LPCTSTR aPath )
{
	P_GDFSE pGetDiskFreeSpaceEx = (P_GDFSE) GetProcAddress( GetModuleHandle( "kernel32.dll" ), "GetDiskFreeSpaceExA" );
	if ( pGetDiskFreeSpaceEx ) {
		LARGE_INTEGER aAvailSpace, aTotalSpace, aFreeSpace;	
		if ( pGetDiskFreeSpaceEx( aPath, (PULARGE_INTEGER)&aAvailSpace, (PULARGE_INTEGER)&aTotalSpace, (PULARGE_INTEGER)&aFreeSpace ))
			return aFreeSpace.QuadPart;
		else {
			char corrected_path [MAX_PATH];
			strcpy (corrected_path, aPath);
			if (strrchr (corrected_path, '\\'))
				*strrchr (corrected_path, '\\') = 0;
			if ( pGetDiskFreeSpaceEx( corrected_path, (PULARGE_INTEGER)&aAvailSpace, (PULARGE_INTEGER)&aTotalSpace, (PULARGE_INTEGER)&aFreeSpace ))
				return aFreeSpace.QuadPart;
			else
				return 0;
		}
	} else {
		DWORD	aSectorsPerCluster, aBytesPerSector, aFreeClusters, aTotalClusters;
		if ( GetDiskFreeSpace( aPath, &aSectorsPerCluster, &aBytesPerSector, &aFreeClusters, &aTotalClusters ))
			return (LONGLONG)aFreeClusters * (LONGLONG)aSectorsPerCluster * (LONGLONG)aBytesPerSector;
		else
			return 0;
	}
}
