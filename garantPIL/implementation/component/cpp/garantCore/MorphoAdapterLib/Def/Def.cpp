////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/Def/Def.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::MorphoAdapterLib::Def
//
// Интерфейсы и типы морфо-адаптера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garantCore/MorphoAdapterLib/Def/Def.h"
#include "garantCore/MorphoAdapterLib/Def/DefFactories.h"

namespace MorphoAdapterLib {

// factory interface wrapper for MorphoAdapter
MorphoAdapter* MorphoAdapterFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return MorphoAdapterFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for MlmaRu
MlmaRu* MlmaRuFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return MlmaRuFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for MorphoManager
MorphoManager* MorphoManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return MorphoManagerFactoryManager::Singleton::instance ()->make ();
}

} // namespace MorphoAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

