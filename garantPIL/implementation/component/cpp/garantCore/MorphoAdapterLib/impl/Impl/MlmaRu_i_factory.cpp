////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/impl/Impl/MlmaRu_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garantCore::MorphoAdapterLib::Impl::MlmaRu_i
//
// Сервант-обертка для экспорта функций библиотеки mlmaru
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garantCore/MorphoAdapterLib/impl/Impl/MlmaRu_i_factory.h"
#include "garantCore/MorphoAdapterLib/impl/Impl/MlmaRu_i.h"

namespace MorphoAdapterLib {
namespace Impl {

MlmaRu_i_factory::MlmaRu_i_factory () {
}

void MlmaRu_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	MlmaRuFactoryManager::register_factory (this, priority);
}

const char* MlmaRu_i_factory::key () const {
	return "MlmaRu_i";
}

MlmaRu* MlmaRu_i_factory::make () {
	MlmaRu_i_var ret = new MlmaRu_i ();
	return ret._retn ();
}

} // namespace Impl
} // namespace MorphoAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

