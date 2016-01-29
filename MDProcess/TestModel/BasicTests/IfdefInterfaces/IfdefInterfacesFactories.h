////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/IfdefInterfaces/IfdefInterfacesFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::IfdefInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_IFDEFINTERFACES_FCTR_H__
#define __TESTMODEL_BASICTESTS_IFDEFINTERFACES_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "TestModel/BasicTests/IfdefInterfaces/IfdefInterfaces.h"
#if defined(WIN32)

namespace BasicTests {
namespace IfdefInterfaces {

#if defined(ACE_HAS_WINNT4) && defined(WIN32)
////////////////////////////////////////////////////////////////////////////////////
// factories definition for TestInterface

class TestInterfaceAbstractFactory;

/// factory manager for TestInterface
class TestInterfaceFactoryManager {
public:
	static void register_factory (TestInterfaceAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	TestInterfaceFactoryManager ();
	
	~TestInterfaceFactoryManager ();
	
	void register_factory_i (TestInterfaceAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	TestInterface* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class TestInterfaceFactory;
	typedef ACE_Singleton <TestInterfaceFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <TestInterfaceFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<TestInterfaceAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<TestInterfaceAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for TestInterface
class TestInterfaceAbstractFactory : virtual public Core::IObject {
	friend class TestInterfaceFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual TestInterface* make () = 0;
};
#endif //ACE_HAS_WINNT4 && WIN32

} // namespace IfdefInterfaces
} // namespace BasicTests


#endif //WIN32
#endif //__TESTMODEL_BASICTESTS_IFDEFINTERFACES_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

