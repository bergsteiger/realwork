#include "stdafx.h"

#include "commonForObjects.h"
using namespace TestComplete;
IMPLEMENT_TESTCOMPLETE_GLOBAL_OBJECTS

CString GetLastErrorDesc()
{
	TCHAR errBuf[2048];
	if (0 == FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, NULL, GetLastError(), 0, errBuf, _countof(errBuf), NULL))
		return CString("");
	else
		return CString(errBuf);
}