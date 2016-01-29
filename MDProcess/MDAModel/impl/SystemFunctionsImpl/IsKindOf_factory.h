////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/IsKindOf_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::IsKindOf
// Заголовк реализации фабрик интерфеса  для серванта IsKindOf
//
// _kind_of(«дампер», «мета-класс») - возвращает true, если мета-класс переданного дампера
// совпадает или является наследником от «мета-класс». Пример использования:
// %f_kind_of(S,SimpleClass::Class)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_ISKINDOF_FCTR_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_ISKINDOF_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace SystemFunctionsImpl {

/// Interface-factory implementation for IsKindOf
class IsKindOf_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	IsKindOf_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<IsKindOf_factory> IsKindOf_factory_var;

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_ISKINDOF_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

