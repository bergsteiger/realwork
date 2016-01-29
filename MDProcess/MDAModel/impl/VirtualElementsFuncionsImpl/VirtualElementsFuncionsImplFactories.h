////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImplFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::MDAModel::VirtualElementsFuncionsImpl
//
// пакет функций для работы с виртуальными элементами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace VirtualElementsFuncionsImpl {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for AddDependencyLocal

class AddDependencyLocalAbstractFactory;

/// factory manager for AddDependencyLocal
class AddDependencyLocalFactoryManager {
public:
	static void register_factory (AddDependencyLocalAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	AddDependencyLocalFactoryManager ();
	
	~AddDependencyLocalFactoryManager ();
	
	void register_factory_i (AddDependencyLocalAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	AddDependencyLocal& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class AddDependencyLocalFactory;
	typedef ACE_Singleton <AddDependencyLocalFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <AddDependencyLocalFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<AddDependencyLocalAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<AddDependencyLocalAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	AddDependencyLocal_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for AddDependencyLocal
class AddDependencyLocalAbstractFactory : virtual public Core::IObject, virtual public TemplateFunctions::InternalStereotypeFunctionAbstractFactory {
	friend class AddDependencyLocalFactoryManager;
protected:

	virtual AddDependencyLocal* get () = 0;
};

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

