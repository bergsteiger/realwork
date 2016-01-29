////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/UnicodeHelper_i/TatarHelper_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::UnicodeHelper_i::TatarHelper
//
// Дополнительные преобразования для татарского языка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/UnicodeHelper_i/TatarHelper_factory.h"
#include "shared/GCI/impl/UnicodeHelper_i/TatarHelper.h"

namespace GCI {
namespace UnicodeHelper_i {

TatarHelper_factory::TatarHelper_factory () {
}

void TatarHelper_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	UnicodeHelper::ConverterHelperFactoryManager::register_factory (this, priority);
}

const I18N::SupportedLocales TatarHelper_factory::key () const {
	return I18N::SL_TATAR;
}

UnicodeHelper::ConverterHelper* TatarHelper_factory::make () {
	TatarHelper_var ret = new TatarHelper ();
	return ret._retn ();
}

} // namespace UnicodeHelper_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

