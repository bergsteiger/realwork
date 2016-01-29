////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ShiftIntend.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ShiftIntend
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_shift_intend".
// _shift_intend(N) - изменяет величину отступа по команде # на величину N, где N - целое число со
// знаком.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SHIFTINTEND_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SHIFTINTEND_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class ShiftIntend; // self forward Var
typedef ::Core::Var<ShiftIntend> ShiftIntend_var;
typedef ::Core::Var<const ShiftIntend> ShiftIntend_cvar;

class ShiftIntend_factory;

// реализация встроенной функции генератора "_shift_intend".
// _shift_intend(N) - изменяет величину отступа по команде # на величину N, где N - целое число со
// знаком.
class ShiftIntend:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (ShiftIntend)
	friend class ShiftIntend_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ShiftIntend ();

	virtual ~ShiftIntend ();

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
}; // class ShiftIntend

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SHIFTINTEND_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
