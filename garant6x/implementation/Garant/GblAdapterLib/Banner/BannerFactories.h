////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Banner/BannerFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Banner
//
// Баннеры
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BANNER_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_BANNER_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Banner/Banner.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Banner

class BannerAbstractFactory;

/// factory manager for Banner
class BannerFactoryManager {
public:
	static void register_factory (BannerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	BannerFactoryManager ();
	
	~BannerFactoryManager ();
	
	void register_factory_i (BannerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Banner* make () /*throw (Core::Root::NoActiveFactory, CanNotFindData)*/;

	friend class BannerFactory;
	typedef ACE_Singleton <BannerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <BannerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<BannerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<BannerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Banner
class BannerAbstractFactory : virtual public Core::IObject {
	friend class BannerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Banner* make () /*throw (CanNotFindData)*/ = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BANNER_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

