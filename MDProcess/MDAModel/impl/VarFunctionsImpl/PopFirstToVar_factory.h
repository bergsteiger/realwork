////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/PopFirstToVar_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::PopFirstToVar
// Заголовк реализации фабрик интерфеса  для серванта PopFirstToVar
//
// реализация встроенной функции генератора  _pop_first_to_var.
// _pop_first_to_var(«идентификатор», «идентификатор переменной») - помещает в переменную
// «идентификатор переменной» значение певого дампера из списка (аналогично _set_var), и удаляет
// его (из списка)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_POPFIRSTTOVAR_FCTR_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_POPFIRSTTOVAR_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace VarFunctionsImpl {

/// Interface-factory implementation for PopFirstToVar
class PopFirstToVar_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	PopFirstToVar_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<PopFirstToVar_factory> PopFirstToVar_factory_var;

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_POPFIRSTTOVAR_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

