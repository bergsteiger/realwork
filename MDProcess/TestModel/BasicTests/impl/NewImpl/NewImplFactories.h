////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/NewImpl/NewImplFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Impl::Category>> TestModel::BasicTests::NewImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NEWIMPL_FCTR_H__
#define __TESTMODEL_BASICTESTS_NEWIMPL_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "TestModel/BasicTests/impl/NewImpl/NewImpl.h"
#include "TestModel/BasicTests/NewInterfaces/NewInterfacesFactories.h"

namespace BasicTests {
namespace NewImpl {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for DerivedLocal

class DerivedLocalAbstractFactory;

/// factory manager for DerivedLocal
class DerivedLocalFactoryManager {
public:
	static void register_factory (DerivedLocalAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DerivedLocalFactoryManager ();
	
	~DerivedLocalFactoryManager ();
	
	void register_factory_i (DerivedLocalAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	friend class DerivedLocalFactory;
	typedef ACE_Singleton <DerivedLocalFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DerivedLocalFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DerivedLocalAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DerivedLocalAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DerivedLocal
class DerivedLocalAbstractFactory : virtual public Core::IObject, virtual public NewInterfaces::DerivedInterfaceAbstractFactory {
	friend class DerivedLocalFactoryManager;
protected:
};

} // namespace NewImpl
} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_NEWIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

