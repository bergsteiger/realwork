#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

char*	KillSlashes( char *resultPath, char *srcPath )
{
	int	aSlashCount = 0;
	int	aPathPtr    = 0;
	for ( unsigned I = 0; I <= strlen( srcPath ); I++ ) {
		char aChar = srcPath[ I ];
		if ( aChar == '\\' ) aSlashCount++; else aSlashCount = 0;
		if ( aSlashCount < 2 || I < 2 )
			resultPath[ aPathPtr++ ] = aChar;
	}
	return resultPath;
}

char*	GoodPath (char* path)
{
	char *from = path, *to = path;
	while (*from) {
		while (*from == '\"') from++;
		*to++ = *from++;
	}
	*to = 0;
	return path;
}

char*	MakePath( char *path, char *dir, char *file )
{
	char	*aResult = new char[ strlen( dir ) + strlen( file ) + 2 ];
	strcat( strcat( strcpy( aResult, dir ), "\\" ), file );
	KillSlashes( path, aResult );
	GoodPath (path);
	delete aResult;
	return path;
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

int main_logic ( int argc, char *argv[] )
{
	if ( argc < 2 )
		return 0;

	{
		char	aMask [MAX_PATH], *aDirectory = argv [1], *aDstDirectory = (char*) malloc (MAX_PATH);
		MakePath (aMask, aDirectory, "*.cry");
		GoodPath (strcat (strcpy (aDstDirectory, aDirectory), "\\result\\"));
		CreateDirectory (aDstDirectory, 0);

		WIN32_FIND_DATA	findData;
		HANDLE	aFindResult = FindFirstFile (aMask, &findData);
		while (aFindResult != INVALID_HANDLE_VALUE) {
			if ( ( findData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY ) == 0 ) {
				char	aSrc [MAX_PATH], aDst [MAX_PATH];
				MakePath (aSrc, aDirectory, findData.cFileName);
				ForceExt (MakePath (aDst, aDstDirectory, findData.cFileName), "log");

				FILE *logfile = fopen (aSrc, "rt"), *outfile = fopen (aDst, "wt");
				char small_str [4];
				small_str [3] = 0;
				while (!feof (logfile)) {
					char str [1024*64];
					if ( !fgets (str, sizeof (str), logfile))
						break;

					int length = strlen (str);
					if (length && (str [length-1] == 10 || str [length-1] == 13))
						str [--length] = 0;

					char* ptr = str;
					for (int i = 0; i < length; i += 3, ptr += 3) {
						memcpy (small_str, ptr, 3);
						char out_string [2];
						sprintf (out_string, "%c", (char)atol (small_str));
						fputs (out_string, outfile);
					}
				}
				fclose (logfile);
				fclose (outfile);
			}

			if ( !FindNextFile (aFindResult, &findData))
				break;
		}
		FindClose (aFindResult);
	}

	return 0;
}

int MemoryError ( )
{
	printf ( "Memory error" );
	exit (EXIT_FAILURE);
	return 0;
}

void cdecl OkBox ( char *s1, char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}

void cdecl OkBox ( const char *s1, const char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}
