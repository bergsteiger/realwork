#pragma once

#pragma warning( push, 1 )
#include <script.h>
#pragma warning( pop )

#include <windows.h>
#include <atlstr.h>

#define TestCompleteLog(messageType, message, isAllowLog) if (isAllowLog) { \
	TCHAR *pTestCompleteLogBuf = new TCHAR[2048];\
	_sntprintf_s(pTestCompleteLogBuf, 2048, _TRUNCATE, _T("%s : %s"), _T(__FUNCTION__), (message));\
	try { \
		TestComplete::Log[(messageType)](pTestCompleteLogBuf); \
	} catch (...) {\
	}; \
	delete[] pTestCompleteLogBuf;\
}

#define InitTypeInfo(iid) \
		TCHAR module_name[MAX_PATH];\
		GetModuleFileName(hInstance, module_name, MAX_PATH);\
		CComPtr<ITypeLib> type_lib;\
		LoadTypeLib(CComBSTR(module_name), &type_lib);\
		CComPtr<ITypeInfo> type_info;\
		type_lib->GetTypeInfoOfGuid((iid), &type_info);\
		_ASSERT( type_info != NULL );\
		CComPtr<ITypeInfo2> type_info2;\
		type_info->QueryInterface(&type_info2);\
		_ASSERT( type_info2 != NULL );\
		_tih.m_pInfo = type_info2.Detach();\
		_pAtlModule->AddTermFunc(_tih.Cleanup, (DWORD_PTR)&_tih);

CString GetLastErrorDesc();
