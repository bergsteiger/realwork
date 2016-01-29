////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CatsContainerImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::CatsContainerImpl
//
// реализация интерфейса контэйнера катов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CatsContainerImpl_factory.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CatsContainerImpl.h"


CatsContainerImpl_factory::CatsContainerImpl_factory () {
}

void CatsContainerImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	MDPSupport::CatsContainerFactoryManager::register_factory (this, priority);
}

const char* CatsContainerImpl_factory::key () const {
	return "CatsContainerImpl";
}

MDPSupport::CatsContainer* CatsContainerImpl_factory::get () {
	CatsContainerImpl_var ret = new CatsContainerImpl ();
	return ret._retn ();
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

