////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/NumberCmp.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::NumberCmp
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора _number_cmp
// _number_cmp("<строка1>","<строка2>","<операция сравнения>") - сравнивает как числа строку1 со
// строкой2 применяя заданную операцию (>,<,==, !=, >=, <=). Если результат сравнения - истина,
// возвращает 1, в противном случае 0.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_NUMBERCMP_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_NUMBERCMP_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class NumberCmp; // self forward Var
typedef ::Core::Var<NumberCmp> NumberCmp_var;
typedef ::Core::Var<const NumberCmp> NumberCmp_cvar;

class NumberCmp_factory;

// реализация встроенной функции генератора _number_cmp
// _number_cmp("<строка1>","<строка2>","<операция сравнения>") - сравнивает как числа строку1 со
// строкой2 применяя заданную операцию (>,<,==, !=, >=, <=). Если результат сравнения - истина,
// возвращает 1, в противном случае 0.
class NumberCmp:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (NumberCmp)
	friend class NumberCmp_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	NumberCmp ();

	virtual ~NumberCmp ();

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
}; // class NumberCmp

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_NUMBERCMP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
