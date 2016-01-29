////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ToLower.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ToLower
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_to_lower".
// _to_lower  ("<строка>") - изменяет регистр строки на lowercase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOLOWER_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOLOWER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class ToLower; // self forward Var
typedef ::Core::Var<ToLower> ToLower_var;
typedef ::Core::Var<const ToLower> ToLower_cvar;

class ToLower_factory;

// реализация встроенной функции генератора "_to_lower".
// _to_lower  ("<строка>") - изменяет регистр строки на lowercase
class ToLower:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (ToLower)
	friend class ToLower_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ToLower ();

	virtual ~ToLower ();

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
}; // class ToLower

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOLOWER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
