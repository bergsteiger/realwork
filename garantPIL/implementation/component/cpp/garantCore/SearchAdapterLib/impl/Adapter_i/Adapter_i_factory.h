////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/Adapter_i/Adapter_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garantCore::SearchAdapterLib::Adapter_i::Adapter_i
// Заголовк реализации фабрик интерфеса IAdapter для серванта Adapter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_ADAPTER_I_FCTR_H__
#define __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_ADAPTER_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/Adapter/AdapterFactories.h"

namespace SearchAdapterLib {
namespace Adapter_i {

/// Interface-factory implementation for Adapter_i
class Adapter_i_factory: virtual public ::Core::RefCountObjectBase, virtual public Adapter::IAdapterAbstractFactory {
public:
	Adapter_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Adapter::IAdapter* instance ();

};

typedef ::Core::Var<Adapter_i_factory> Adapter_i_factory_var;

} // namespace Adapter_i
} // namespace SearchAdapterLib


#endif //__GARANTCORE_SEARCHADAPTERLIB_ADAPTER_I_ADAPTER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

