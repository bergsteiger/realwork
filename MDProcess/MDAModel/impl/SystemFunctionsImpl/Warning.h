////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/Warning.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::Warning
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_warning"
// _warning(«сообщение») - выводит предупреждение.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_WARNING_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_WARNING_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class Warning; // self forward Var
typedef ::Core::Var<Warning> Warning_var;
typedef ::Core::Var<const Warning> Warning_cvar;

class Warning_factory;

// реализация встроенной функции генератора "_warning"
// _warning(«сообщение») - выводит предупреждение.
class Warning:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (Warning)
	friend class Warning_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Warning ();

	virtual ~Warning ();

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
}; // class Warning

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_WARNING_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
