////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/UnicodeHelper_i/EmptyHelper_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::UnicodeHelper_i::EmptyHelper
//
// Заглушка, не выполняющая дополнительных преобразований
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/UnicodeHelper_i/EmptyHelper_factory.h"
#include "shared/GCI/impl/UnicodeHelper_i/EmptyHelper.h"

namespace GCI {
namespace UnicodeHelper_i {

EmptyHelper_factory::EmptyHelper_factory () {
}

void EmptyHelper_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	UnicodeHelper::ConverterHelperFactoryManager::register_factory (this, priority);
}

const I18N::SupportedLocales EmptyHelper_factory::key () const {
	return I18N::SL_UNKNOWN;
}

UnicodeHelper::ConverterHelper* EmptyHelper_factory::make () {
	EmptyHelper_var ret = new EmptyHelper ();
	return ret._retn ();
}

} // namespace UnicodeHelper_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

