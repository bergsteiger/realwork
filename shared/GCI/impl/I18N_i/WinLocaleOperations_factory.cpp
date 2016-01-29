////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/I18N_i/WinLocaleOperations_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::WinLocaleOperations
//
// установка локали в win32 системах
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/I18N_i/WinLocaleOperations_factory.h"
#include "shared/GCI/impl/I18N_i/WinLocaleOperations.h"
#include "shared/GCI/impl/I18N_i/Environment.h"

namespace GCI {
namespace I18N_i {

WinLocaleOperations_factory::WinLocaleOperations_factory () {
}

void WinLocaleOperations_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	I18N::LocaleOperationsFactoryManager::register_factory (this, priority);
}

const char* WinLocaleOperations_factory::key () const {
	return "WinLocaleOperations";
}

I18N::LocaleOperations* WinLocaleOperations_factory::make () {
	WinLocaleOperations_var ret = new WinLocaleOperations ();
	return ret._retn ();
}

} // namespace I18N_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

