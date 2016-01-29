////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/Evaluate.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::Evaluate
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _evaluate
// _evaluate(«мат. выражение») - вичисляет мат. выражение и возвращает результат. Например:
// %f_evaluate(2*2+10) - вернёт 14.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_EVALUATE_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_EVALUATE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class Evaluate; // self forward Var
typedef ::Core::Var<Evaluate> Evaluate_var;
typedef ::Core::Var<const Evaluate> Evaluate_cvar;

class Evaluate_factory;

// реализация встроенной функции генератора _evaluate
// _evaluate(«мат. выражение») - вичисляет мат. выражение и возвращает результат. Например:
// %f_evaluate(2*2+10) - вернёт 14.
class Evaluate:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (Evaluate)
	friend class Evaluate_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Evaluate ();

	virtual ~Evaluate ();

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
}; // class Evaluate

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_EVALUATE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
