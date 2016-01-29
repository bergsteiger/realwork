////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/DocCardRemote/DocCardRemoteFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ArchiGate::DocCardRemote
//
// для работы с гардоком
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIGATE_DOCCARDREMOTE_FCTR_H__
#define __MDPROCESS_ARCHIGATE_DOCCARDREMOTE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteS.h"

namespace ArchiGate {
namespace DocCardRemote {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for BigFileIterator

class BigFileIteratorAbstractFactory;

/// factory manager for BigFileIterator
class BigFileIteratorFactoryManager: virtual public POA_ArchiGate::DocCardRemote::BigFileIteratorFactoryManagerSrv {
public:
	static void register_factory (BigFileIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void destroy (BigFileIterator* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	static void publish_self ();

protected:
	BigFileIteratorFactoryManager ();
	
	~BigFileIteratorFactoryManager ();
	
	void register_factory_i (BigFileIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	BigFileIterator* make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	void destroy_i (BigFileIterator* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	friend class BigFileIteratorFactory;
	typedef ACE_Singleton <BigFileIteratorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <BigFileIteratorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<BigFileIteratorAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<BigFileIteratorAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for BigFileIterator
class BigFileIteratorAbstractFactory : virtual public Core::IObject {
	friend class BigFileIteratorFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual BigFileIterator* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ArchiEventsListener

class ArchiEventsListenerAbstractFactory;

/// factory manager for ArchiEventsListener
class ArchiEventsListenerFactoryManager: virtual public POA_ArchiGate::DocCardRemote::ArchiEventsListenerFactoryManagerSrv {
public:
	static void register_factory (ArchiEventsListenerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void release (ArchiEventsListener* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	static void publish_self ();

protected:
	ArchiEventsListenerFactoryManager ();
	
	~ArchiEventsListenerFactoryManager ();
	
	void register_factory_i (ArchiEventsListenerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ArchiEventsListener* make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	void release_i (ArchiEventsListener* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	friend class ArchiEventsListenerFactory;
	typedef ACE_Singleton <ArchiEventsListenerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ArchiEventsListenerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ArchiEventsListenerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ArchiEventsListenerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ArchiEventsListener
class ArchiEventsListenerAbstractFactory : virtual public Core::IObject {
	friend class ArchiEventsListenerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ArchiEventsListener* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Searcher2

class Searcher2AbstractFactory;

/// factory manager for Searcher2
class Searcher2FactoryManager: virtual public POA_ArchiGate::DocCardRemote::Searcher2FactoryManagerSrv {
public:
	static void register_factory (Searcher2AbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void release (Searcher2* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	static void publish_self ();

protected:
	Searcher2FactoryManager ();
	
	~Searcher2FactoryManager ();
	
	void register_factory_i (Searcher2AbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Searcher2* make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	void release_i (Searcher2* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	friend class Searcher2Factory;
	typedef ACE_Singleton <Searcher2FactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <Searcher2FactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<Searcher2AbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<Searcher2AbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Searcher2
class Searcher2AbstractFactory : virtual public Core::IObject {
	friend class Searcher2FactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Searcher2* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Utils

class UtilsAbstractFactory;

/// factory manager for Utils
class UtilsFactoryManager: virtual public POA_ArchiGate::DocCardRemote::UtilsFactoryManagerSrv {
public:
	static void register_factory (UtilsAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void release (Utils* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	static void publish_self ();

protected:
	UtilsFactoryManager ();
	
	~UtilsFactoryManager ();
	
	void register_factory_i (UtilsAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Utils* make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	void release_i (Utils* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	friend class UtilsFactory;
	typedef ACE_Singleton <UtilsFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <UtilsFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<UtilsAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<UtilsAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Utils
class UtilsAbstractFactory : virtual public Core::IObject {
	friend class UtilsFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Utils* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for GardocGetter

class GardocGetterAbstractFactory;

/// factory manager for GardocGetter
class GardocGetterFactoryManager: virtual public POA_ArchiGate::DocCardRemote::GardocGetterFactoryManagerSrv {
public:
	static void register_factory (GardocGetterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void release (GardocGetter* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	static void publish_self ();

protected:
	GardocGetterFactoryManager ();
	
	~GardocGetterFactoryManager ();
	
	void register_factory_i (GardocGetterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	GardocGetter* make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	void release_i (GardocGetter* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	friend class GardocGetterFactory;
	typedef ACE_Singleton <GardocGetterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <GardocGetterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<GardocGetterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<GardocGetterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for GardocGetter
class GardocGetterAbstractFactory : virtual public Core::IObject {
	friend class GardocGetterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual GardocGetter* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Searcher

class SearcherAbstractFactory;

/// factory manager for Searcher
class SearcherFactoryManager: virtual public POA_ArchiGate::DocCardRemote::SearcherFactoryManagerSrv {
public:
	static void register_factory (SearcherAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void release (Searcher* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	static void publish_self ();

protected:
	SearcherFactoryManager ();
	
	~SearcherFactoryManager ();
	
	void register_factory_i (SearcherAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Searcher* make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	void release_i (Searcher* obj_) throw (CORBA::SystemException, CoreSrv::ForeignObject);

	friend class SearcherFactory;
	typedef ACE_Singleton <SearcherFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SearcherFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<SearcherAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<SearcherAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Searcher
class SearcherAbstractFactory : virtual public Core::IObject {
	friend class SearcherFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Searcher* make () = 0;
};

} // namespace DocCardRemote
} // namespace ArchiGate


#endif //__MDPROCESS_ARCHIGATE_DOCCARDREMOTE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

