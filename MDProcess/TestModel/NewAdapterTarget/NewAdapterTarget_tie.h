////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/NewAdapterTarget/NewAdapterTarget_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<AdapterTarget::Category>> TestModel::NewAdapterTarget
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_NEWADAPTERTARGET_TIE_H__
#define __TESTMODEL_NEWADAPTERTARGET_TIE_H__

#include "shared/Core/sys/std_inc.h"
#include 

extern "C" __declspec (dllexport) unsigned long __stdcall tie_dll_version ();

extern "C" __declspec (dllexport) void __stdcall tie_dll_init_with_locale (unsigned long client_version, const char* locale_string);

extern "C" __declspec (dllexport) void __stdcall tie_dll_init (unsigned long client_version);

extern "C" __declspec (dllexport) void __stdcall tie_dll_done ();

extern "C" __declspec (dllexport) void __stdcall tie_dll_get_root (
	NewInstallerTarget::Root_tie*& root
);


#endif //__TESTMODEL_NEWADAPTERTARGET_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
