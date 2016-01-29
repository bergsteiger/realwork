////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/fix/win_afx.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::fix::win_afx
//
// Различные запладки и инклюды для MFC-приложений (должно включаться вместо StdAfx)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_FIX_WIN_AFX_H__
#define __SHARED_CORE_FIX_WIN_AFX_H__

#include "ace/ACE.h"

//#UC START# *45740CEE0280_USER_INCLUDES*
#include "shared/Core/sys/std_inc.h"

#define _ATL_FREE_THREADED
#define _ATL_NO_AUTOMATIC_NAMESPACE
#define _ATL_CSTRING_EXPLICIT_CONSTRUCTORS	// some CString constructors will be explicit
#define _ATL_ALL_WARNINGS // turns off ATL's hiding of some common and often safely ignored warning messages

#if defined (_NATIVE_WCHAR_T_DEFINED)
#if defined (_DEBUG)
#pragma comment (lib, "comsuppwd.lib")
#else // defined (_DEBUG)
#pragma comment (lib, "comsuppw.lib")
#endif // defined (_DEBUG)
#else // defined (_NATIVE_WCHAR_T_DEFINED)
#if defined (_DEBUG)
#pragma comment (lib, "comsuppd.lib")
#else // defined (_DEBUG)
#pragma comment (lib, "comsupp.lib")
#endif // defined (_DEBUG)
#endif // defined (_NATIVE_WCHAR_T_DEFINED)
// } GARANT

#include <afxwin.h>         // MFC core and standard components
#include <afxext.h>         // MFC extensions
#include <afxole.h>         // MFC OLE classes
#include <afxodlgs.h>       // MFC OLE dialog classes
#include <afxdisp.h>        // MFC Automation classes
#include <afxdtctl.h>		// MFC support for Internet Explorer 4 Common Controls
#include <afxcmn.h>			// MFC support for Windows Common Controls
#include <afxtempl.h>
#include <atlbase.h>
#include <atlcom.h>
//#UC END# *45740CEE0280_USER_INCLUDES*

namespace Core {

//#UC START# *45740CEE0280_USER_DEFINITION*
//#UC END# *45740CEE0280_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_FIX_WIN_AFX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
