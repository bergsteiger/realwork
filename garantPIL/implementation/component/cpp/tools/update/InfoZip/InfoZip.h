// InfoZip.h: interface for the CInfoZip class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_INFOZIP_H__A5C325B4_180B_11D3_ABD5_00A0C9B4D8AB__INCLUDED_)
#define AFX_INFOZIP_H__A5C325B4_180B_11D3_ABD5_00A0C9B4D8AB__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

#include "ZipDll.h"
#include "UnzipDll.h"

#define ZERROR_NONE                    0
#define ZERROR_DLL_NOT_FOUND           1
#define ZERROR_DLL_FOUNCTION_NOT_FOUND 2
#define ZERROR_NOT_INITIALIZED         3

class CInfoZip  
{
public:
	BOOL ExtractFiles(const char* pszArchive, const char* pszTargetFolder);
	void SetDefaultValues(CUnzipParams *pParams);
	void ReleaseParams(CUnzipParams *pParams);
	BOOL Execute(CUnzipParams *pParams);
	BOOL FinalizeUnzip();
	BOOL FinalizeZip();
	BOOL InitializeUnzip();
	BOOL InitializeZip();
	BOOL GetInitializedUnzip();
	BOOL GetInitializedZip();
	void ReleaseParams(CZipParams *pParams);
	BOOL AddFiles(const char *pszArchive, char **paFiles, int iFileCount);
	BOOL Execute(CZipParams *pParams);
	void SetDefaultValues(CZipParams *pZipParms);
	BOOL Finalize();
	BOOL GetInitialized();
	BOOL Initialize();
	UINT GetLastError();
	int GetZipDllVersion();
	int GetUnzipDllVersion();
	CInfoZip();
	virtual ~CInfoZip();

	BOOL	Errors;

private:
	void SetLastError(UINT uiError);
	UINT m_uiLastError;
	HINSTANCE m_ZipDllHandle;
	HINSTANCE m_UnzipDllHandle;
	CZipDllExec m_ZipDllExec;
	CUnzipDllExec m_UnzipDllExec;
	CGetZipDllVersion   m_GetZipDllVersion;
	CGetUnzipDllVersion m_GetUnzipDllVersion;
};

BOOL __stdcall DefaultZipCallback(CZipCallbackData *pData);

#endif // !defined(AFX_INFOZIP_H__A5C325B4_180B_11D3_ABD5_00A0C9B4D8AB__INCLUDED_)
