////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/StereotypeManagerImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::HelpersImpl::StereotypeManagerImpl
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/StereotypeManagerImpl_factory.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/StereotypeManagerImpl.h"

namespace HelpersImpl {

StereotypeManagerImpl_factory::StereotypeManagerImpl_factory () {
}

void StereotypeManagerImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Helpers::StereotypeManagerFactoryManager::register_factory (this, priority);
}

const char* StereotypeManagerImpl_factory::key () const {
	return "StereotypeManagerImpl";
}

Helpers::StereotypeManager* StereotypeManagerImpl_factory::make () {
	StereotypeManagerImpl_var ret = new StereotypeManagerImpl ();
	return ret._retn ();
}

} // namespace HelpersImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

