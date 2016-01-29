#ifndef UNZIPDLL_H

#define UNZIPDLL_H

#include "windows.h"
#include "stdafx.h"
#include "ZCallBck.h"

struct CUnzipParams
{
	HWND m_wndHandle;
	void * m_pCaller;    /* "self" referance of the Delphi form */
                     /* This is passed back to us in the callback function
                     so we can direct the info to the proper form instance
                     - thanks to Dennis Passmore for this idea. */
	long int m_liVersion;   /* version of DLL we expect to see */
	void* m_pfCallbackFunction; /* type def in ZCallBck.PAS */
	BOOL m_bTraceEnabled;

         /*============== Begin UnZip Flag section ============== */
	BOOL m_bPromptToOverwrite;  // not used yet
	char* m_pszZipPassword;         // password pointer 
	BOOL m_bTest;               // if true, test zipfile, don't save extracted files
	BOOL m_bComments;           // show zip comment (not supported yet)
	BOOL m_bConvert;            // if true, do ASCII/EBCDIC or EOL translation

	BOOL m_bQuiet;              // DLL be quiet!
	BOOL m_bVerboseEnabled;     // verbose flag
	BOOL m_bUpdate;             // "update" (extract only newer files & brand new files)
	BOOL m_bFreshen;            // "freshen" (extract only newer files that already exist)
	BOOL m_bDirectories;        // if true, recreate dir structure
	BOOL m_bOverwrite;          // if true, overwrite existing (no asking)

         /* Count of filespecs to extract - don't forget to set this! */
	long int m_liFileCount;
         /* ptr to zipfile name */
	char *m_pszArchiveFileName;
	long int m_liSeven; /* pass a 7 here to validate struct size */
         /* Array of filenames contained in the ZIP archive */
	char* m_pszFileNames[MAX_FILES];
};


/* Main call to execute a ZIP add or Delete.  This call returns the
  number of files that were sucessfully operated on. */
typedef DWORD (__stdcall *CUnzipDllExec)(CUnzipParams *pParams);
typedef DWORD (__stdcall *CGetUnzipDllVersion)();

#endif  //  UNZIPDLL_H