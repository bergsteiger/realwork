#ifndef ZIPDLL_H

#define ZIPDLL_H

#include "windows.h"
#include "stdafx.h"
#include "ZCallBck.h"

struct CZipParams
{
	HWND m_hwndHandle;
			/* "self" referance of the Delphi form */
			/* This is passed back to us in the callback function
			   so we can direct the info to the proper form instance
			   - thanks to Dennis Passmore for this idea. */
	void *m_pCaller;
	long int m_liVersion;   /* version of DLL we expect to see */
	ZFunctionPtrType m_pfCallbackFunction; /* type def in ZCallBck.PAS */
	BOOL m_bTraceEnabled;

         /*============== Begin Zip Flag section ============== */
	char *m_pszZipPassword; /* password pointer */
	BOOL m_bSuffix;   /* not used yet */
	BOOL m_bEncrypt;  /* Encrypt files to be added? */

	/* include system and hidden files */
	BOOL m_bSystem;

	/* Include volume label */
	BOOL m_bVolume;

	/* Include extra file attributes (read-only, unix timestamps, etc) */
	BOOL m_bExtra;

	/* Do not add directory names to .ZIP archive */
	/* see also: fJunkDir */
	BOOL m_bNoDirEntries;

	/* Only add files newer a specified date */
	/* See the "Date" array below if you set this to TRUE */
	BOOL m_bDate;

	/* Give a little more information to the user via message boxes */
	BOOL m_bVerboseEnabled;

	/* Quiet operation - the DLL won't issue any messages at all. */
	/* Delphi program MUST handle ALL errors via it's callback function. */
	BOOL m_bQuiet;

	/* Compression level (0 - 9; 9=max, 0=none) */
	/* All of these levels are variations of deflate. */
	/* I strongly recommend you use one of 3 values here:
	          0 = no compression, just store file
              3 = "fast" compression
              9 = "best" compression */
	long int m_bLevel;

	/* Try to compress files that appear to be already compressed
	   based on their extension: .zip, .arc, .gif, ... */
	BOOL m_bComprSpecial;

	/* translate text file end-of-lines */
	BOOL m_bCRLF_LF;

	/* junk the directory names */
	/* If true, this says not to save dirnames as separate entries,
	   in addition to being save with filenames. */
	/* see also: fNoDirEntries */
	BOOL m_bJunkDir;

	/* Recurse into subdirectories */
	BOOL m_bRecurse;

	/* Allow appending to a zip file */
	BOOL m_bGrow;

	/* Convert filenames to DOS 8x3 names - for compatibility
	   with PKUNZIP v2.04g, which doesn't understand long filenames */
	BOOL m_bForce;

	/* Delete orig files that were added or updated in zip file */
	/* This is a variation of Add */
	BOOL m_bMove;

	/* Delete specified files from zip file */
	BOOL m_bDeleteEntries;

	/* Update zip -- if true, rezip changed, and add new files in fspec */
	/* This is a variation of Add */
	BOOL m_bUpdate;

	/* Freshen zip -- if true, rezip all changed files in fspec */
	/* This is a variation of Add */
	BOOL m_bFreshen;

	/* junk the SFX prefix on the self-extracing .EXE archives */
	BOOL m_bJunkSFX;

	/* Set zip file time to time of newest file in it */
	BOOL m_bLatestTime;

	/*============== End Zip Flag section ============== */

	/* Cutoff Date for Add-by-date; add files newer than this day */
	/* This is only used if the "fDate" option is TRUE */
	/* format = MMDDYY plus a trailing null */
	char m_cDate[8];

	/* Count of files to add or delete - don't forget to set this! */
	long int m_liFileCount;
	/* ptr to name of zip file */
	char *m_pszArchiveFileName;
	long int m_liSeven; /* pass a 7 here to validate struct size */

	/* Array of filenames contained in the ZIP archive */
	char* m_pszFileNames[MAX_FILES];
};

/*
	Main call to execute a ZIP add or Delete.  This call returns the
	number of files that were sucessfully operated on.
*/
typedef DWORD (__stdcall *CZipDllExec)(CZipParams *pParams);
typedef DWORD (__stdcall *CGetZipDllVersion)();

#endif  //  ZIPDLL_H