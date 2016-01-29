////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/SetVar_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::SetVar
// Заголовк реализации фабрик интерфеса  для серванта SetVar
//
// реализация встроенной функции генератора _set_var.
// _set_var («идентификатор», «значение») - определяет и инициализирует глобальную переменную
// (область видимость неограничена) типа ЭЛЕМЕНТ МОДЕЛИ или СТРОКА. Например:
// {code}
// %f_set_var (CURRENT_ELEM, S) .... %{CURRENT_ELEM}N
// %f_set_var (PARENT, P) .... %{PARENT}%CN
// %f_set_var (TEMP, "[{%SM=Interface::Class}{non interface}interface]") .... %{TEMP}N
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SETVAR_FCTR_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SETVAR_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace VarFunctionsImpl {

/// Interface-factory implementation for SetVar
class SetVar_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	SetVar_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<SetVar_factory> SetVar_factory_var;

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SETVAR_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

