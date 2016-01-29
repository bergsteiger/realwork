////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/MDPSupport/MDPSupport.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::MDPSupport
//
// интерфейсы для  работы с сервером залочек
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupportFactories.h"

namespace MDPSupport {

// factory interface wrapper for CatLocker
CatLocker* CatLockerFactory::make (
	IRoseCategoryPtr cat
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return CatLockerFactoryManager::Singleton::instance ()->make (cat);
}

// factory interface wrapper for MDPFacade
MDPFacade& MDPFacadeFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return MDPFacadeFactoryManager::Singleton::instance ()->get ();
}


// контсруктор раз
LockInfo::LockInfo (
	RosePackageLocking::RosePackageLockingServer::LockStatus s
	, const std::string& owner
	, const std::string& time
)
//#UC START# *46237F4B000B_INIT_CTOR_BASE_INIT*
//#UC END# *46237F4B000B_INIT_CTOR_BASE_INIT*
{
	//#UC START# *46237F4B000B_CTOR_BODY*
	status = s;
	lock_owner_name = owner;
	lock_time = time;
	//#UC END# *46237F4B000B_CTOR_BODY*
}

// пустой конструктор
LockInfo::LockInfo ()
//#UC START# *462384E000E6_INIT_CTOR_BASE_INIT*
: status (RosePackageLocking::RosePackageLockingServer::LS_FREE)
//#UC END# *462384E000E6_INIT_CTOR_BASE_INIT*
{
	//#UC START# *462384E000E6_CTOR_BODY*
	//#UC END# *462384E000E6_CTOR_BODY*
}

const char* LockInfoNotExists::uid () const /*throw ()*/ {
	return "07F42C6C-F586-4815-977C-152E12DD9D49";
}

const char* LockInfoNotExists::what () const throw () {
	//#UC START# *47D626BB0090_WHAT_IMPL*
	return "LockInfoNotExists (информауция о залочке отсутствует)";
	//#UC END# *47D626BB0090_WHAT_IMPL*
}

// factory interface wrapper for CatLockerFacade
CatLockerFacade* CatLockerFacadeFactory::make (
	IRoseCategoryPtr cat
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return CatLockerFacadeFactoryManager::Singleton::instance ()->make (cat);
}

CatLockerFacade* CatLockerFacadeFactory::make (
	IRoseElementPtr elem
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return CatLockerFacadeFactoryManager::Singleton::instance ()->make (elem);
}

// factory interface wrapper for CatsContainer
CatsContainer& CatsContainerFactory::get () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return CatsContainerFactoryManager::Singleton::instance ()->get ();
}

} // namespace MDPSupport

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

