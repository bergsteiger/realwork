////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/ParamsImpl/ParamManagerImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::ParamsImpl::ParamManagerImpl
// Заголовк реализации фабрик интерфеса ParamManager для серванта ParamManagerImpl
//
// реализация менеджера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_PARAMSIMPL_PARAMMANAGERIMPL_FCTR_H__
#define __SHARED_CORE_PARAMSIMPL_PARAMMANAGERIMPL_FCTR_H__

#include "ace/ACE.h"
#include "shared/Core/Params/ParamsFactories.h"

namespace Core {
namespace ParamsImpl {

/// Interface-factory implementation for ParamManagerImpl
class ParamManagerImpl_factory: virtual public ::Core::RefCountObjectBase, virtual public ParamManagerAbstractFactory {
public:
	ParamManagerImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	ParamManager* get ();

	ParamManager* make (const std::string& args);

};

typedef ::Core::Var<ParamManagerImpl_factory> ParamManagerImpl_factory_var;

} // namespace ParamsImpl
} // namespace Core


#endif //__SHARED_CORE_PARAMSIMPL_PARAMMANAGERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

