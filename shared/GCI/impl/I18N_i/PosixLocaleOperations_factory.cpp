////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/I18N_i/PosixLocaleOperations_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::PosixLocaleOperations
//
// установка локали для posix систем.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/I18N_i/PosixLocaleOperations_factory.h"
#include "shared/GCI/impl/I18N_i/PosixLocaleOperations.h"
#include "shared/GCI/impl/I18N_i/Environment.h"

namespace GCI {
namespace I18N_i {

PosixLocaleOperations_factory::PosixLocaleOperations_factory () {
}

void PosixLocaleOperations_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	I18N::LocaleOperationsFactoryManager::register_factory (this, priority);
}

const char* PosixLocaleOperations_factory::key () const {
	return "PosixLocaleOperations";
}

I18N::LocaleOperations* PosixLocaleOperations_factory::make () {
	PosixLocaleOperations_var ret = new PosixLocaleOperations ();
	return ret._retn ();
}

} // namespace I18N_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

