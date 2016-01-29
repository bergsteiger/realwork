#include "shared/Core/fix/mpcxc.h"

#include "onlineflash.h"

#include "garantPIL/implementation/component/cpp/tools/update/unzip60/windll/structs.h"
#include "garantPIL/implementation/component/cpp/tools/update/unzip60/windll/decs.h"

typedef int (WINAPI * _DLL_UNZIP)(int, char **, int, char **, LPDCL, LPUSERFUNCTIONS);

int WINAPI password (LPSTR p, int n, LPCSTR m, LPCSTR name)
{
	return 1;
}

int WINAPI DisplayBuf (LPSTR buf, unsigned long size)
{
	return (int)(unsigned int) size;
}

int WINAPI GetReplaceDlgRetVal (LPSTR filename, unsigned fnbufsiz)
{
	return 1;
}

OFDLL_API int DoWrite (char flash_letter, char* archive_name, char* ininame, char* login, char* data) {
	char dest [256];
	sprintf (dest, "%c:\\", flash_letter);
	;//AfxMessageBox (dest);
	HINSTANCE hUnzipDll = LoadLibrary ("unzdll.dll");	
	if (hUnzipDll) {
		;//AfxMessageBox ("unzdll ok");
		_DLL_UNZIP pWiz_SingleEntryUnzip = (_DLL_UNZIP) GetProcAddress (hUnzipDll, "Wiz_SingleEntryUnzip");
		if (pWiz_SingleEntryUnzip) {
			;//AfxMessageBox ("dll method found");
			int infc = 0, exfc = 0;
			char **infv = 0, **exfv = 0;

			HANDLE hDCL = GlobalAlloc (GPTR, (DWORD) sizeof (DCL));
			LPDCL lpDCL = (LPDCL) GlobalLock (hDCL);
			lpDCL->StructVersID = UZ_DCL_STRUCTVER; /* version of this structure */
			lpDCL->ncflag = 0;              /* write to stdout if true */
			lpDCL->fQuiet = 2;              /* we want all messagesm, 1 = fewer messages, 2 = no messages */
			lpDCL->ntflag = 0;              /* test zip file if true */
			lpDCL->nvflag = 0;              /* give a verbose listing if true */
			lpDCL->nzflag = 0;              /* display zip file comment if true */
			lpDCL->ndflag = 1;              /* recreate directories != 0, skip "../" if < 2 */
			lpDCL->naflag = 0;              /* do not convert CR to CRLF */
			lpDCL->nfflag = 0;              /* do not freshen existing files only */
			lpDCL->noflag = 1;              /* over-write all files if true */
			lpDCL->nZIflag = 0;             /* no ZipInfo output mode */
			lpDCL->B_flag = 0;              /* do not backup existing files */
			lpDCL->C_flag = 0;              /* do not match case-insensitive */
			lpDCL->D_flag = 0;              /* restore all timestamps */
			lpDCL->U_flag = 0;              /* do not disable UTF-8 support */
			lpDCL->ExtractOnlyNewer = 0;    /* do not extract only newer */
			lpDCL->SpaceToUnderscore = 0;   /* do not convert space to '_' in filenames */
			lpDCL->PromptToOverwrite = 0;   /* "overwrite all" selected -> no query mode */
			lpDCL->lpszZipFN = archive_name;
			lpDCL->lpszExtractDir = dest;

			HANDLE hUF = GlobalAlloc (GPTR, (DWORD) sizeof (USERFUNCTIONS));
			LPUSERFUNCTIONS lpUserFunctions = (LPUSERFUNCTIONS) GlobalLock (hUF);
			lpUserFunctions->password = password;
			lpUserFunctions->print = DisplayBuf;
			lpUserFunctions->sound = 0;
			lpUserFunctions->replace = GetReplaceDlgRetVal;
			lpUserFunctions->SendApplicationMessage = 0;

			;//AfxMessageBox ("try to unzip");
			int unzip_result = (*pWiz_SingleEntryUnzip)(infc, infv, exfc, exfv, lpDCL, lpUserFunctions);

			GlobalUnlock (lpUserFunctions);
			GlobalFree (hUF);
			GlobalUnlock (lpDCL);
			GlobalFree (hDCL);
			FreeLibrary (hUnzipDll);

			if (0 == unzip_result) {
				;//AfxMessageBox ("unzip ok");
				strcat (dest, ininame);
				if (WritePrivateProfileString ("garant", "login", login, dest) && WritePrivateProfileString ("garant", "data", data, dest) && WritePrivateProfileString (0,0,0,dest))
					return 0;
				else
					return GetLastError ();
			} else {
				return unzip_result;
				;//AfxMessageBox ("unzip failed");
			}
		} else {
			;//AfxMessageBox ("method Wiz_SingleEntryUnzip not found");
		}
	} else {
		;//AfxMessageBox ("unzdll not found");
	}
	return 255;
}
