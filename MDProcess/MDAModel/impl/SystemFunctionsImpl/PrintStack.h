////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/PrintStack.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::PrintStack
// Заголовок реализации класса серванта для интерфеса 
//
// %f_print_stack("маркер") - выводит стэк вызова функций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_PRINTSTACK_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_PRINTSTACK_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class PrintStack; // self forward Var
typedef ::Core::Var<PrintStack> PrintStack_var;
typedef ::Core::Var<const PrintStack> PrintStack_cvar;

class PrintStack_factory;

// %f_print_stack("маркер") - выводит стэк вызова функций
class PrintStack:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (PrintStack)
	friend class PrintStack_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PrintStack ();

	virtual ~PrintStack ();

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
}; // class PrintStack

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_PRINTSTACK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
