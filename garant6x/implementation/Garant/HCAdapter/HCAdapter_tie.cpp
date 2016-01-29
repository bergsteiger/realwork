////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapter/HCAdapter_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<AdapterTarget::Category>> garant6x::HCAdapter
//
// Библиотека для взаимодействия сервера консультаций и ПО отдела правовой поддержки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma warning (disable: 4297)
#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapter/HCAdapter_tie.h"
#include "garant6x/implementation/Garant/HCAdapter/HCAdapter.h"

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
	HCAdapter::Root_tie*& root
) {
_DLL_TRY
	root = HCAdapter::Root_tie::instance();
	root->addref();
_DLL_CATCH
}