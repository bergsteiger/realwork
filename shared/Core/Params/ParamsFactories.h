////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/Params/ParamsFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::Params
//
// пакет для работы с параметрами приложения
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_PARAMS_FCTR_H__
#define __SHARED_CORE_PARAMS_FCTR_H__

#include "shared/Core/sys/core_std_inc.h"
#include "shared/Core/Root/Root.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/Core/Params/Params.h"

namespace Core {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ParamManager

class ParamManagerAbstractFactory;

/// factory manager for ParamManager
class ParamManagerFactoryManager {
public:
	static void register_factory (ParamManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ParamManagerFactoryManager ();
	
	~ParamManagerFactoryManager ();
	
	void register_factory_i (ParamManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ParamManager& get () /*throw (Core::Root::NoActiveFactory)*/;

	ParamManager* make (const std::string& args) /*throw (Core::Root::NoActiveFactory)*/;

	friend class ParamManagerFactory;
	typedef ACE_Singleton <ParamManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ParamManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ParamManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ParamManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	ParamManager_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for ParamManager
class ParamManagerAbstractFactory : virtual public Core::IObject {
	friend class ParamManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ParamManager* get () = 0;

	virtual ParamManager* make (const std::string& args) = 0;
};

} // namespace Core


#endif //__SHARED_CORE_PARAMS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

