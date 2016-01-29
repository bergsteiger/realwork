////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProject.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::IntegrationProject
//
// Пакет для проекта интеграции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProject.h"
#include "garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProjectFactories.h"

namespace GblAdapterLib {


const char* CantCreateObject::uid () const /*throw ()*/ {
	return "B783DEE5-82F3-4AA5-8236-E64E479438A2";
}

const char* CantCreateObject::what () const throw () {
	//#UC START# *463F5105003E_WHAT_IMPL*
	return "CantCreateObject (в базе недостаточно данных для построения объекта)";
	//#UC END# *463F5105003E_WHAT_IMPL*
}

// factory interface wrapper for Integration
Integration* IntegrationFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return IntegrationFactoryManager::Singleton::instance ()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

