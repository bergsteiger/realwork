////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterServer/GblAdapterServer_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<AdapterTarget::Category>> garant6x::GblAdapterServer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERSERVER_TIE_H__
#define __GARANT6X_GBLADAPTERSERVER_TIE_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapter/GblAdapter_tie.h"

extern "C" __declspec (dllexport) unsigned long __stdcall tie_dll_version ();

extern "C" __declspec (dllexport) void __stdcall tie_dll_init_with_locale (unsigned long client_version, const char* locale_string);

extern "C" __declspec (dllexport) void __stdcall tie_dll_init (unsigned long client_version);

extern "C" __declspec (dllexport) void __stdcall tie_dll_done ();

extern "C" __declspec (dllexport) void __stdcall tie_dll_get_root (
	GblAdapter::Root_tie*& root
);


#endif //__GARANT6X_GBLADAPTERSERVER_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
