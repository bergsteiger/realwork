////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CatLockerSrv_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::CatLockerSrv
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CatLockerSrv_factory.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CatLockerSrv.h"


CatLockerSrv_factory::CatLockerSrv_factory () {
}

void CatLockerSrv_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	MDPSupport::CatLockerFactoryManager::register_factory (this, priority);
}

const char* CatLockerSrv_factory::key () const {
	return "CatLockerSrv";
}

MDPSupport::CatLocker* CatLockerSrv_factory::make (IRoseCategoryPtr cat) {
	CatLockerSrv_var ret = new CatLockerSrv (cat);
	return ret._retn ();
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

