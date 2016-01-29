// stdafx.h : include file for standard system include files,
// or project specific include files that are used frequently,
// but are changed infrequently

#pragma once

#ifndef STRICT
#define STRICT
#endif

// Modify the following defines if you have to target a platform prior to the ones specified below.
// Refer to MSDN for the latest info on corresponding values for different platforms.
#ifndef WINVER				// Allow use of features specific to Windows 95 and Windows NT 4 or later.
#define WINVER 0x0400		// Change this to the appropriate value to target Windows 98 and Windows 2000 or later.
#endif

#ifndef _WIN32_WINNT		// Allow use of features specific to Windows NT 4 or later.
#define _WIN32_WINNT 0x0400	// Change this to the appropriate value to target Windows 2000 or later.
#endif						

//#ifndef _WIN32_WINDOWS		// Allow use of features specific to Windows 98 or later.
//#define _WIN32_WINDOWS 0x0410 // Change this to the appropriate value to target Windows Me or later.
//#endif

#ifndef _WIN32_IE			// Allow use of features specific to IE 4.0 or later.
#define _WIN32_IE 0x0400	// Change this to the appropriate value to target IE 5.0 or later.
#endif

#define _ATL_APARTMENT_THREADED
#define _ATL_NO_AUTOMATIC_NAMESPACE

#define _ATL_CSTRING_EXPLICIT_CONSTRUCTORS	// some CString constructors will be explicit

// turns off ATL's hiding of some common and often safely ignored warning messages
#define _ATL_ALL_WARNINGS


#include "resource.h"
#include <atlbase.h>
#include <atlcom.h>
#include <atlwin.h>
using namespace ATL;

#include <io.h>
#include <vector>
#include <aqConsts.h>
#include <tcProductKeys.h>
#include <ActionsConst.h>
#include <tcConst.h>
#include <tcProjectNodeActionKey.h>

#import "scrrun.dll" raw_interfaces_only, raw_native_types, named_guids, \
	rename("DeleteFile", "DeleteFileR"), \
	rename("MoveFile", "MoveFileR"), \
	rename("CopyFile", "CopyFileR")

#import "C:\Program Files\Automated QA\TestComplete 6\Bin\TestComplete.exe" \
	raw_interfaces_only, raw_native_types, named_guids, auto_search, no_namespace, \
	rename("PlaySound", "PlsySoundR"), \
	exclude("tagRECT", "UINT_PTR"), \
	rename("GetMessage", "GetMessageR")


#import "C:\Program Files\Automated QA\TestComplete 6\Bin\Extensions\TestCompleteInternal.tlb" \
	raw_interfaces_only, raw_native_types, named_guids, auto_search, no_namespace, \
	exclude("PUINT_PTR", "tagPOINT", "IEnumUnknown", "_FILETIME", "AQ_PROPERTY_TYPE", "ITypeLib", "ITypeInfo"), \
	exclude("tagTYPEATTR", "tagTYPEKIND", "tagTYPEDESC", "__MIDL_IOleAutomationTypes_0005", "tagARRAYDESC"), \
	exclude("tagSAFEARRAYBOUND", "tagIDLDESC", "DWORD", "ITypeComp", "tagDESCKIND", "tagFUNCDESC", "tagELEMDESC"), \
	exclude("tagPARAMDESC", "tagPARAMDESCEX", "tagFUNCKIND", "tagINVOKEKIND", "tagCALLCONV", "tagVARDESC"), \
	exclude("__MIDL_IOleAutomationTypes_0006", "tagVARKIND", "tagTLIBATTR", "tagSYSKIND"), \
	rename("GetUserName", "GetUserNameR"), \
	rename("GetWindowsDirectory", "GetWindowsDirectoryR"), \
	rename("GetSystemDirectory", "GetSystemDirectoryR"), \
	rename("GetFileVersionInfo", "GetFileVersionInfoR"), \
	rename("CreateProcess", "CreateProcessR"), \
	rename("FindWindow", "FindWindowR"), \
	rename("FindWindowEx", "FindWindowExR"), \
	rename("GetMenuItemInfo", "GetMenuItemInfoR"), \
	rename("RegisterWindowMessage", "RegisterWindowMessageR"), \
	rename("CreateProcess", "CreateProcessR"), \
	rename("FindWindow", "FindWindowR"), \
	rename("FindWindowEx", "FindWindowExR"), \
	rename("GetMenuItemInfo", "GetMenuItemInfoR"), \
	rename("PostMessage", "PostMessageR"), \
	rename("PostThreadMessage", "PostThreadMessageR"), \
	rename("SendMessage", "SendMessageR"), \
	rename("SendMessageTimeout", "SendMessageTimeoutR"), \
	rename("RegisterWindowMessage", "RegisterWindowMessageR"), \
	rename("GetObject", "GetObjectR"), \
	rename("SendMessageTimeout", "SendMessageTimeoutR"), \
	rename("GetObject", "GetObjectR"), \
	rename("GetFileAttributes", "GetFileAttributesR"), \
	rename("CopyFile", "CopyFileR"), \
	rename("LoadImage", "LoadImageR"), \
	rename("CreateEvent", "CreateEventR"), \
	rename("CreateProcessAsUser", "CreateProcessAsUserR"), \
	rename("VkKeyScanEx", "VkKeyScanExR"), \
	rename("MapVirtualKeyEx", "MapVirtualKeyExR")

extern HINSTANCE hInstance;
