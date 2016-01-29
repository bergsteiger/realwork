////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/DelVar_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::DelVar
// Заголовк реализации фабрик интерфеса  для серванта DelVar
//
// реализация встроенной функции генератора _del_var.
// _del_var («идентификатор») - удаляет глобальную переменную (область видимость неограничена)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_DELVAR_FCTR_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_DELVAR_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace VarFunctionsImpl {

/// Interface-factory implementation for DelVar
class DelVar_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	DelVar_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<DelVar_factory> DelVar_factory_var;

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_DELVAR_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

