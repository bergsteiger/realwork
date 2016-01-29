////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/Error.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::Error
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_error".
// _error(«сообщение») - выводит сообщение об ошибке и прекращает генерацию
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_ERROR_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_ERROR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class Error; // self forward Var
typedef ::Core::Var<Error> Error_var;
typedef ::Core::Var<const Error> Error_cvar;

class Error_factory;

// реализация встроенной функции генератора "_error".
// _error(«сообщение») - выводит сообщение об ошибке и прекращает генерацию
class Error:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (Error)
	friend class Error_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Error ();

	virtual ~Error ();

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
}; // class Error

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_ERROR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
