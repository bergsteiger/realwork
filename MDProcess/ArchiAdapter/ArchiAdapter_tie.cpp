////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapter/ArchiAdapter_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<AdapterTarget::Category>> MDProcess::ArchiAdapter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma warning (disable: 4297)
#include "shared/Core/sys/std_inc.h"
#include "MDProcess/ArchiAdapter/ArchiAdapter_tie.h"
#include "MDProcess/ArchiAdapter/ArchiAdapter.h"

// DLL export methods
extern "C" __declspec (dllexport) unsigned long __stdcall tie_dll_version () {
	return dll_version ();
}

extern "C" __declspec (dllexport) void __stdcall tie_dll_init_with_locale (unsigned long client_version, const char* locale_string) {
	dll_init_with_locale (client_version, locale_string);
}

extern "C" __declspec (dllexport) void __stdcall tie_dll_init (unsigned long client_version) {
	dll_init (client_version);
}

extern "C" __declspec (dllexport) void __stdcall tie_dll_done () {
	dll_done ();
}

extern "C" __declspec (dllexport) void __stdcall tie_dll_get_root (
	ArchiAdapter::Root_tie*& root
) {
_DLL_TRY
	root = ArchiAdapter::Root_tie::instance();
	root->addref();
_DLL_CATCH
}