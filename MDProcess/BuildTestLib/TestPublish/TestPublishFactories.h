////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/TestPublish/TestPublishFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::BuildTestLib::TestPublish
//
// стандартная публикация результатов тестов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_TESTPUBLISH_FCTR_H__
#define __MDPROCESS_BUILDTESTLIB_TESTPUBLISH_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/BuildTestLib/TestPublish/TestPublish.h"
#include "MDProcess/BuildTestLib/TestPublish/TestPublishS.h"

namespace BuildTestLib {
namespace TestPublish {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Publish

class PublishAbstractFactory;

/// factory manager for Publish
class PublishFactoryManager: virtual public POA_BuildTestLib::TestPublish::PublishFactoryManagerSrv {
public:
	static void register_factory (PublishAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	PublishFactoryManager ();
	
	~PublishFactoryManager ();
	
	void register_factory_i (PublishAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Publish* make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class PublishFactory;
	typedef ACE_Singleton <PublishFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PublishFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PublishAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PublishAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Publish
class PublishAbstractFactory : virtual public Core::IObject {
	friend class PublishFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Publish* make () = 0;
};

} // namespace TestPublish
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_TESTPUBLISH_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

