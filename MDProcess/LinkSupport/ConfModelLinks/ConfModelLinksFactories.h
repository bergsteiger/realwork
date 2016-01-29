////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/LinkSupport/ConfModelLinks/ConfModelLinksFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::LinkSupport::ConfModelLinks
//
// пакет, обеспечивающий переход из Конфлюенса в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_LINKSUPPORT_CONFMODELLINKS_FCTR_H__
#define __MDPROCESS_LINKSUPPORT_CONFMODELLINKS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/LinkSupport/ConfModelLinks/ConfModelLinks.h"
#include "MDProcess/LinkSupport/ConfModelLinks/ConfModelLinksS.h"

namespace LinkSupport {
namespace ConfModelLinks {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ShowOnModelMng

class ShowOnModelMngAbstractFactory;

/// factory manager for ShowOnModelMng
class ShowOnModelMngFactoryManager: virtual public POA_LinkSupport::ConfModelLinks::ShowOnModelMngFactoryManagerSrv {
public:
	static void register_factory (ShowOnModelMngAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	ShowOnModelMngFactoryManager ();
	
	~ShowOnModelMngFactoryManager ();
	
	void register_factory_i (ShowOnModelMngAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ShowOnModelMng* get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class ShowOnModelMngFactory;
	typedef ACE_Singleton <ShowOnModelMngFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ShowOnModelMngFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ShowOnModelMngAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ShowOnModelMngAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	ShowOnModelMng_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for ShowOnModelMng
class ShowOnModelMngAbstractFactory : virtual public Core::IObject {
	friend class ShowOnModelMngFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ShowOnModelMng* get () = 0;
};

} // namespace ConfModelLinks
} // namespace LinkSupport


#endif //__MDPROCESS_LINKSUPPORT_CONFMODELLINKS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

