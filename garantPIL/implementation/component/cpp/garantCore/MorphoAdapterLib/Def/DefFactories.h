////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/MorphoAdapterLib/Def/DefFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::MorphoAdapterLib::Def
//
// Интерфейсы и типы морфо-адаптера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_MORPHOADAPTERLIB_DEF_FCTR_H__
#define __GARANTCORE_MORPHOADAPTERLIB_DEF_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garantCore/MorphoAdapterLib/Def/Def.h"

namespace MorphoAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for MorphoAdapter

class MorphoAdapterAbstractFactory;

/// factory manager for MorphoAdapter
class MorphoAdapterFactoryManager {
public:
	static void register_factory (MorphoAdapterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	MorphoAdapterFactoryManager ();
	
	~MorphoAdapterFactoryManager ();
	
	void register_factory_i (MorphoAdapterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	MorphoAdapter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class MorphoAdapterFactory;
	typedef ACE_Singleton <MorphoAdapterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MorphoAdapterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<MorphoAdapterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<MorphoAdapterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for MorphoAdapter
class MorphoAdapterAbstractFactory : virtual public Core::IObject {
	friend class MorphoAdapterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual MorphoAdapter* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for MlmaRu

class MlmaRuAbstractFactory;

/// factory manager for MlmaRu
class MlmaRuFactoryManager {
public:
	static void register_factory (MlmaRuAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	MlmaRuFactoryManager ();
	
	~MlmaRuFactoryManager ();
	
	void register_factory_i (MlmaRuAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	MlmaRu* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class MlmaRuFactory;
	typedef ACE_Singleton <MlmaRuFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MlmaRuFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<MlmaRuAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<MlmaRuAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for MlmaRu
class MlmaRuAbstractFactory : virtual public Core::IObject {
	friend class MlmaRuFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual MlmaRu* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for MorphoManager

class MorphoManagerAbstractFactory;

/// factory manager for MorphoManager
class MorphoManagerFactoryManager {
public:
	static void register_factory (MorphoManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	MorphoManagerFactoryManager ();
	
	~MorphoManagerFactoryManager ();
	
	void register_factory_i (MorphoManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	MorphoManager* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class MorphoManagerFactory;
	typedef ACE_Singleton <MorphoManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MorphoManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<MorphoManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<MorphoManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for MorphoManager
class MorphoManagerAbstractFactory : virtual public Core::IObject {
	friend class MorphoManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual MorphoManager* make () = 0;
};

} // namespace MorphoAdapterLib


#endif //__GARANTCORE_MORPHOADAPTERLIB_DEF_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

