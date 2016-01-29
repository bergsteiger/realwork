////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/ParamsImpl/ParamManagerImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::ParamsImpl::ParamManagerImpl
//
// реализация менеджера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/impl/ParamsImpl/ParamManagerImpl_factory.h"
#include "shared/Core/impl/ParamsImpl/ParamManagerImpl.h"

namespace Core {
namespace ParamsImpl {

ParamManagerImpl_factory::ParamManagerImpl_factory () {
}

void ParamManagerImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ParamManagerFactoryManager::register_factory (this, priority);
}

const char* ParamManagerImpl_factory::key () const {
	return "ParamManagerImpl";
}

ParamManager* ParamManagerImpl_factory::get () {
	ParamManagerImpl_var ret = new ParamManagerImpl ();
	return ret._retn ();
}

ParamManager* ParamManagerImpl_factory::make (const std::string& args) {
	ParamManagerImpl_var ret = new ParamManagerImpl (args);
	return ret._retn ();
}

} // namespace ParamsImpl
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

