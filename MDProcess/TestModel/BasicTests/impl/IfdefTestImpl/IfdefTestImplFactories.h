////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/IfdefTestImpl/IfdefTestImplFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Impl::Category>> TestModel::BasicTests::IfdefTestImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_IFDEFTESTIMPL_FCTR_H__
#define __TESTMODEL_BASICTESTS_IFDEFTESTIMPL_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "TestModel/BasicTests/impl/IfdefTestImpl/IfdefTestImpl.h"
#if defined(WIN32)

namespace BasicTests {
namespace IfdefTestImpl {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for TestLocal

class TestLocalAbstractFactory;

/// factory manager for TestLocal
class TestLocalFactoryManager {
public:
	static void register_factory (TestLocalAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	TestLocalFactoryManager ();
	
	~TestLocalFactoryManager ();
	
	void register_factory_i (TestLocalAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	TestLocal* create () /*throw (Core::Root::NoActiveFactory)*/;

	friend class TestLocalFactory;
	typedef ACE_Singleton <TestLocalFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <TestLocalFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<TestLocalAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<TestLocalAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for TestLocal
class TestLocalAbstractFactory : virtual public Core::IObject {
	friend class TestLocalFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual TestLocal* create () = 0;
};

} // namespace IfdefTestImpl
} // namespace BasicTests


#endif //WIN32
#endif //__TESTMODEL_BASICTESTS_IFDEFTESTIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

