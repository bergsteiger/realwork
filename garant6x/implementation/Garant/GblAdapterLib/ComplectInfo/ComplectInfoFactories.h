////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ComplectInfo/ComplectInfoFactories.h"
// C++ Interface Factories header files (.h)
// Generated from UML model, root element: <<Interface::Category>> garant6x::GblAdapterLib::ComplectInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_COMPLECTINFO_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_COMPLECTINFO_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ComplectInfo/ComplectInfo.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ComplectInfo

class ComplectInfoFactoryManager;

/// abstarct factory for ComplectInfo
class ComplectInfoAbstractFactory : virtual public Core::IObject {
	friend class ComplectInfoFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ComplectInfo* make () = 0;
};

/// factory manager for ComplectInfo
class ComplectInfoFactoryManager {
public:
	static void register_factory (ComplectInfoAbstractFactory* factory)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ComplectInfoFactoryManager ();
	
	void register_factory_i (ComplectInfoAbstractFactory* factory)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ComplectInfo* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ComplectInfoFactory;
	typedef ACE_Singleton <ComplectInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ComplectInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	bool m_has_registred_factories;
	typedef std::map<std::string, ::Core::Var<ComplectInfoAbstractFactory> > FactoryMap;
	FactoryMap m_factories_map;
	::Core::Var<ComplectInfoAbstractFactory> m_single_active_factory;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_COMPLECTINFO_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

