////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/CycleBreak.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::CycleBreak
// Заголовок реализации класса серванта для интерфеса 
//
// встроенная функция:
// _cycle_break() - прерывает текущий цикл, если функция вызвана вне цикла - генерируется исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_CYCLEBREAK_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_CYCLEBREAK_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class CycleBreak; // self forward Var
typedef ::Core::Var<CycleBreak> CycleBreak_var;
typedef ::Core::Var<const CycleBreak> CycleBreak_cvar;

class CycleBreak_factory;

// встроенная функция:
// _cycle_break() - прерывает текущий цикл, если функция вызвана вне цикла - генерируется исключение
class CycleBreak:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (CycleBreak)
	friend class CycleBreak_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CycleBreak ();

	virtual ~CycleBreak ();

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
}; // class CycleBreak

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_CYCLEBREAK_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
