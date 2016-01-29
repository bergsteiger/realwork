////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::MDAModel::VirtualElementsFuncionsImpl
//
// пакет функций для работы с виртуальными элементами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include <typeinfo>
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImplFactories.h"


namespace VirtualElementsFuncionsImpl {

// factory interface wrapper for AddDependencyLocal
AddDependencyLocal& AddDependencyLocalFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return AddDependencyLocalFactoryManager::Singleton::instance ()->get ();
}

AddDependencyLocal& AddDependencyLocalFactory::make (const std::string& key) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	try {
		return dynamic_cast<AddDependencyLocal&> (TemplateFunctions::InternalStereotypeFunctionFactory::make (key));
	} catch (std::bad_cast&) {
		throw Core::Root::NoActiveFactory ("MDAModel::VirtualElementsFuncionsImpl::AddDependencyLocalFactory");
	}

}



} //namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

