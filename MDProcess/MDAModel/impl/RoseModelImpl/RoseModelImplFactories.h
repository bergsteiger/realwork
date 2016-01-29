////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImplFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::MDAModel::RoseModelImpl
//
// Пакет реализации интерфейсов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImpl.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"

namespace RoseModelImpl {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ImplementedItemEx

class ImplementedItemExAbstractFactory;

/// factory manager for ImplementedItemEx
class ImplementedItemExFactoryManager {
public:
	static void register_factory (ImplementedItemExAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ImplementedItemExFactoryManager ();
	
	~ImplementedItemExFactoryManager ();
	
	void register_factory_i (ImplementedItemExAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ImplementedItemEx* make (const std::string& stored_value) /*throw (Core::Root::NoActiveFactory)*/;

	friend class ImplementedItemExFactory;
	typedef ACE_Singleton <ImplementedItemExFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ImplementedItemExFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ImplementedItemExAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ImplementedItemExAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ImplementedItemEx
class ImplementedItemExAbstractFactory : virtual public Core::IObject, virtual public ImplementedItemAbstractFactory {
	friend class ImplementedItemExFactoryManager;
protected:

	virtual ImplementedItemEx* make (const std::string& stored_value) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for OverloadedItemEx

class OverloadedItemExAbstractFactory;

/// factory manager for OverloadedItemEx
class OverloadedItemExFactoryManager {
public:
	static void register_factory (OverloadedItemExAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	OverloadedItemExFactoryManager ();
	
	~OverloadedItemExFactoryManager ();
	
	void register_factory_i (OverloadedItemExAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	OverloadedItemEx* make (const std::string& stored_value) /*throw (Core::Root::NoActiveFactory)*/;

	friend class OverloadedItemExFactory;
	typedef ACE_Singleton <OverloadedItemExFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <OverloadedItemExFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<OverloadedItemExAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<OverloadedItemExAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for OverloadedItemEx
class OverloadedItemExAbstractFactory : virtual public Core::IObject, virtual public OverloadedItemAbstractFactory {
	friend class OverloadedItemExFactoryManager;
protected:

	virtual OverloadedItemEx* make (const std::string& stored_value) = 0;
};

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

