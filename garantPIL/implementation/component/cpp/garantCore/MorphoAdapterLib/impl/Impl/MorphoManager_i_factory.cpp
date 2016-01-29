////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/impl/Impl/MorphoManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garantCore::MorphoAdapterLib::Impl::MorphoManager_i
//
// Реализация интерфейса MorphoManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garantCore/MorphoAdapterLib/impl/Impl/MorphoManager_i_factory.h"
#include "garantCore/MorphoAdapterLib/impl/Impl/MorphoManager_i.h"

namespace MorphoAdapterLib {
namespace Impl {

MorphoManager_i_factory::MorphoManager_i_factory () {
}

void MorphoManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	MorphoManagerFactoryManager::register_factory (this, priority);
}

const char* MorphoManager_i_factory::key () const {
	return "MorphoManager_i";
}

MorphoManager* MorphoManager_i_factory::make () {
	MorphoManager_i_var ret = new MorphoManager_i ();
	return ret._retn ();
}

} // namespace Impl
} // namespace MorphoAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

