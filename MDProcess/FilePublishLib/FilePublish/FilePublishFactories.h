////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/FilePublishLib/FilePublish/FilePublishFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::FilePublishLib::FilePublish
//
// публикация файла как результата теста
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_FILEPUBLISHLIB_FILEPUBLISH_FCTR_H__
#define __MDPROCESS_FILEPUBLISHLIB_FILEPUBLISH_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/FilePublishLib/FilePublish/FilePublish.h"

namespace FilePublishLib {
namespace FilePublish {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for PlainTextPublish

class PlainTextPublishAbstractFactory;

/// factory manager for PlainTextPublish
class PlainTextPublishFactoryManager {
public:
	static void register_factory (PlainTextPublishAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	PlainTextPublishFactoryManager ();
	
	~PlainTextPublishFactoryManager ();
	
	void register_factory_i (PlainTextPublishAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	PlainTextPublish* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class PlainTextPublishFactory;
	typedef ACE_Singleton <PlainTextPublishFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PlainTextPublishFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PlainTextPublishAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PlainTextPublishAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for PlainTextPublish
class PlainTextPublishAbstractFactory : virtual public Core::IObject {
	friend class PlainTextPublishFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual PlainTextPublish* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for PlainText2FunctionalTest

class PlainText2FunctionalTestAbstractFactory;

/// factory manager for PlainText2FunctionalTest
class PlainText2FunctionalTestFactoryManager {
public:
	static void register_factory (PlainText2FunctionalTestAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	PlainText2FunctionalTestFactoryManager ();
	
	~PlainText2FunctionalTestFactoryManager ();
	
	void register_factory_i (PlainText2FunctionalTestAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	PlainText2FunctionalTest& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class PlainText2FunctionalTestFactory;
	typedef ACE_Singleton <PlainText2FunctionalTestFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PlainText2FunctionalTestFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PlainText2FunctionalTestAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PlainText2FunctionalTestAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	PlainText2FunctionalTest_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for PlainText2FunctionalTest
class PlainText2FunctionalTestAbstractFactory : virtual public Core::IObject {
	friend class PlainText2FunctionalTestFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual PlainText2FunctionalTest* get () = 0;
};

} // namespace FilePublish
} // namespace FilePublishLib


#endif //__MDPROCESS_FILEPUBLISHLIB_FILEPUBLISH_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

