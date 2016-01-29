////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/SetVar.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::SetVar
// Заголовок реализации класса серванта для интерфеса 
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
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SETVAR_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SETVAR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace VarFunctionsImpl {

class SetVar; // self forward Var
typedef ::Core::Var<SetVar> SetVar_var;
typedef ::Core::Var<const SetVar> SetVar_cvar;

class SetVar_factory;

// реализация встроенной функции генератора _set_var.
// _set_var («идентификатор», «значение») - определяет и инициализирует глобальную переменную
// (область видимость неограничена) типа ЭЛЕМЕНТ МОДЕЛИ или СТРОКА. Например:
// {code}
// %f_set_var (CURRENT_ELEM, S) .... %{CURRENT_ELEM}N
// %f_set_var (PARENT, P) .... %{PARENT}%CN
// %f_set_var (TEMP, "[{%SM=Interface::Class}{non interface}interface]") .... %{TEMP}N
// {code}
class SetVar:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (SetVar)
	friend class SetVar_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetVar ();

	virtual ~SetVar ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalFunctionBase
	// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
	virtual const std::string execute_impl (
		const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class SetVar

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SETVAR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
