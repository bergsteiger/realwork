////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/impl/Impl/MorphoAdapter_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garantCore::MorphoAdapterLib::Impl::MorphoAdapter_i
//
// Реализация интерфейса MorphoAdapter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garantCore/MorphoAdapterLib/impl/Impl/MorphoAdapter_i_factory.h"
#include "garantCore/MorphoAdapterLib/impl/Impl/MorphoAdapter_i.h"

namespace MorphoAdapterLib {
namespace Impl {

MorphoAdapter_i_factory::MorphoAdapter_i_factory () {
}

void MorphoAdapter_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	MorphoAdapterFactoryManager::register_factory (this, priority);
}

const char* MorphoAdapter_i_factory::key () const {
	return "MorphoAdapter_i";
}

MorphoAdapter* MorphoAdapter_i_factory::make () {
	MorphoAdapter_i_var ret = new MorphoAdapter_i ();
	return ret._retn ();
}

} // namespace Impl
} // namespace MorphoAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

