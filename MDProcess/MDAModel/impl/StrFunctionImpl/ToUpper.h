////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ToUpper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ToUpper
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_to_upper".
// _to_upper ("<строка>")  - изменяет регистр строки на uppercase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOUPPER_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOUPPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class ToUpper; // self forward Var
typedef ::Core::Var<ToUpper> ToUpper_var;
typedef ::Core::Var<const ToUpper> ToUpper_cvar;

class ToUpper_factory;

// реализация встроенной функции генератора "_to_upper".
// _to_upper ("<строка>")  - изменяет регистр строки на uppercase
class ToUpper:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (ToUpper)
	friend class ToUpper_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ToUpper ();

	virtual ~ToUpper ();

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
}; // class ToUpper

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOUPPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
