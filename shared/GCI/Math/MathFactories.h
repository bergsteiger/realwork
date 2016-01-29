////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/Math/MathFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::Math
//
// Пакет интерфейсов связанных с математическими выичслениями
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MATH_FCTR_H__
#define __SHARED_GCI_MATH_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/GCI/Math/Math.h"

namespace GCI {
namespace Math {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Calculator

class CalculatorAbstractFactory;

/// factory manager for Calculator
class CalculatorFactoryManager {
public:
	static void register_factory (CalculatorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	CalculatorFactoryManager ();
	
	~CalculatorFactoryManager ();
	
	void register_factory_i (CalculatorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Calculator& make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class CalculatorFactory;
	typedef ACE_Singleton <CalculatorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <CalculatorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<CalculatorAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<CalculatorAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	Calculator_var m_cached_object_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for Calculator
class CalculatorAbstractFactory : virtual public Core::IObject {
	friend class CalculatorFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Calculator* make () = 0;
};

} // namespace Math
} // namespace GCI


#endif //__SHARED_GCI_MATH_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

