////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/IsEmpty_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::IsEmpty
// Заголовк реализации фабрик интерфеса  для серванта IsEmpty
//
// реализация встроенной функции генератора _is_empty.
// _is_empty(«идентификатор») - возвращает true, если список пуст
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_ISEMPTY_FCTR_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_ISEMPTY_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace VarFunctionsImpl {

/// Interface-factory implementation for IsEmpty
class IsEmpty_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	IsEmpty_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<IsEmpty_factory> IsEmpty_factory_var;

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_ISEMPTY_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

