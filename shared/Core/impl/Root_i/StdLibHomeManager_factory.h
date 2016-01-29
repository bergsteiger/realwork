////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/Root_i/StdLibHomeManager_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::Root_i::StdLibHomeManager
// Заголовк реализации фабрик интерфеса LibHomeManager для серванта StdLibHomeManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_ROOT_I_STDLIBHOMEMANAGER_FCTR_H__
#define __SHARED_CORE_ROOT_I_STDLIBHOMEMANAGER_FCTR_H__

#include "ace/ACE.h"
#include "shared/Core/Root/RootFactories.h"
#include "shared/Core/impl/Root_i/Root_i.h"

namespace Core {
namespace Root_i {

/// Interface-factory implementation for StdLibHomeManager
class StdLibHomeManager_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Root::LibHomeManagerAbstractFactory
{
public:
	StdLibHomeManager_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Root::LibHomeManager* get ();

};

typedef ::Core::Var<StdLibHomeManager_factory> StdLibHomeManager_factory_var;

} // namespace Root_i
} // namespace Core


#endif //__SHARED_CORE_ROOT_I_STDLIBHOMEMANAGER_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

