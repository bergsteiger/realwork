////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CatLockerFacadeImpl_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::CatLockerFacadeImpl
//
// реализация интерфейса обертки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CatLockerFacadeImpl_factory.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CatLockerFacadeImpl.h"


CatLockerFacadeImpl_factory::CatLockerFacadeImpl_factory () {
}

void CatLockerFacadeImpl_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	MDPSupport::CatLockerFacadeFactoryManager::register_factory (this, priority);
}

const char* CatLockerFacadeImpl_factory::key () const {
	return "CatLockerFacadeImpl";
}

MDPSupport::CatLockerFacade* CatLockerFacadeImpl_factory::make (IRoseCategoryPtr cat) {
	CatLockerFacadeImpl_var ret = new CatLockerFacadeImpl (cat);
	return ret._retn ();
}

MDPSupport::CatLockerFacade* CatLockerFacadeImpl_factory::make (IRoseElementPtr elem) {
	CatLockerFacadeImpl_var ret = new CatLockerFacadeImpl (elem);
	return ret._retn ();
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

