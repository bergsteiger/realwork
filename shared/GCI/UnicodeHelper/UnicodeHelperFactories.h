////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/UnicodeHelper/UnicodeHelperFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::UnicodeHelper
//
// вспомогательные интерфейсы для работы с Unicode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_UNICODEHELPER_FCTR_H__
#define __SHARED_GCI_UNICODEHELPER_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/GCI/UnicodeHelper/UnicodeHelper.h"

namespace GCI {
namespace UnicodeHelper {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for ConverterHelper

class ConverterHelperAbstractFactory;

/// factory manager for ConverterHelper
class ConverterHelperFactoryManager {
public:
	static void register_factory (ConverterHelperAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
	
	static ConverterHelperFactory::KeySet* keys ();

protected:
	ConverterHelperFactoryManager ();
	
	~ConverterHelperFactoryManager ();
	
	void register_factory_i (ConverterHelperAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ConverterHelper* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ConverterHelperFactory;
	typedef ACE_Singleton <ConverterHelperFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ConverterHelperFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ConverterHelperAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <I18N::SupportedLocales, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ConverterHelperAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ConverterHelper
class ConverterHelperAbstractFactory : virtual public Core::IObject {
	friend class ConverterHelperFactoryManager;
protected:
	virtual const I18N::SupportedLocales key () const = 0;

	virtual ConverterHelper* make () = 0;
};

} // namespace UnicodeHelper
} // namespace GCI


#endif //__SHARED_GCI_UNICODEHELPER_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

