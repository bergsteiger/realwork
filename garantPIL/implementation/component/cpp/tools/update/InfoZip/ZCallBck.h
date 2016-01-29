#ifndef ZCALLBCK_H
#define ZCALLBCK_H

#include "StdAfx.h"
#include <windows.h>

#define MAX_FILES 4096

#pragma pack (push)

struct CZipCallbackData
{
	DWORD m_hwndHandle;
	HWND m_pCaller;
	long int m_liVersion;
	BOOL m_bIsOperationZip;
	long int m_liActionCode;
	long int m_liErrorCode;
	long int m_liFileSize;
	char m_pszFileNameOrMsg[512];
};

#pragma pack (pop)

typedef BOOL (__stdcall *ZFunctionPtrType) (CZipCallbackData*);

#endif ZCALLBCK_H  //   ZCALLBCK_H
