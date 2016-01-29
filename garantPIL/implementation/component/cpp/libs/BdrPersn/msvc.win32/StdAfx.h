// stdafx.h : include file for standard system include files,
//  or project specific include files that are used frequently, but
//      are changed infrequently
//

#if !defined(AFX_STDAFX_H__532FDC06_26D8_4A3B_ACC4_EB51AA5DB4B2__INCLUDED_)
#define AFX_STDAFX_H__532FDC06_26D8_4A3B_ACC4_EB51AA5DB4B2__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define VC_EXTRALEAN		// Exclude rarely-used stuff from Windows headers

#if defined (_GCD_CLIENT) || defined (PILOT)
#include "ace/ACE.h"        // This file should be included before "windows.h"!
#endif

#include <afxwin.h>         // MFC core and standard components
#include <afxext.h>         // MFC extensions
#include <afxdisp.h>        // MFC Automation classes
#include <afxdtctl.h>		// MFC support for Internet Explorer 4 Common Controls
#ifndef _AFX_NO_AFXCMN_SUPPORT
#include <afxcmn.h>			// MFC support for Windows Common Controls
#endif // _AFX_NO_AFXCMN_SUPPORT

#define MAX_HDD_COUNT 1000

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDAFX_H__532FDC06_26D8_4A3B_ACC4_EB51AA5DB4B2__INCLUDED_)
