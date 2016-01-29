////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/CommonUtils/XML/XMLFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::CommonUtils::XML
//
// Интерфейс для чтения XML от внешних систем.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_COMMONUTILS_XML_FCTR_H__
#define __GARANT6X_COMMONUTILS_XML_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/CommonUtils/XML/XML.h"

namespace CommonUtils {
namespace XML {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for XMLReader

class XMLReaderAbstractFactory;

/// factory manager for XMLReader
class XMLReaderFactoryManager {
public:
	static void register_factory (XMLReaderAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	XMLReaderFactoryManager ();
	
	~XMLReaderFactoryManager ();
	
	void register_factory_i (XMLReaderAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	XMLReader* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class XMLReaderFactory;
	typedef ACE_Singleton <XMLReaderFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <XMLReaderFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<XMLReaderAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<XMLReaderAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for XMLReader
class XMLReaderAbstractFactory : virtual public Core::IObject {
	friend class XMLReaderFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual XMLReader* make () = 0;
};

} // namespace XML
} // namespace CommonUtils


#endif //__GARANT6X_COMMONUTILS_XML_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

