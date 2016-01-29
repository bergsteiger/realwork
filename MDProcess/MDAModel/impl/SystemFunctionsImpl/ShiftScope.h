////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ShiftScope.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ShiftScope
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_shift_scope".
// _shift_scope(true/false) - устанавливает флаг - нужно ли сдвинуть scope на один уровень.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SHIFTSCOPE_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SHIFTSCOPE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class ShiftScope; // self forward Var
typedef ::Core::Var<ShiftScope> ShiftScope_var;
typedef ::Core::Var<const ShiftScope> ShiftScope_cvar;

class ShiftScope_factory;

// реализация встроенной функции генератора "_shift_scope".
// _shift_scope(true/false) - устанавливает флаг - нужно ли сдвинуть scope на один уровень.
class ShiftScope:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (ShiftScope)
	friend class ShiftScope_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ShiftScope ();

	virtual ~ShiftScope ();

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
}; // class ShiftScope

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SHIFTSCOPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
