////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/SetVar.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::SetVar
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_set_var(имя переменной,элемент|"строка") - установка переменной, связанной с элементом:
// {code}
// %S%f_set_var(TYPE,T)
// %S%f_set_var(NAME,"%SN")
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_SETVAR_H__
#define __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_SETVAR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalStereotypeFunctionBase.h"

namespace StereotypeFunctionsImpl {

class SetVar; // self forward Var
typedef ::Core::Var<SetVar> SetVar_var;
typedef ::Core::Var<const SetVar> SetVar_cvar;

class SetVar_factory;

// %S%f_set_var(имя переменной,элемент|"строка") - установка переменной, связанной с элементом:
// {code}
// %S%f_set_var(TYPE,T)
// %S%f_set_var(NAME,"%SN")
// {code}
class SetVar:
	virtual public BaseFunctionImpl::InternalStereotypeFunctionBase
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

	// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
	virtual const std::string execute_impl (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class SetVar

} // namespace StereotypeFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_SETVAR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
