////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/DebugFunc.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::DebugFunc
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_dbg_point"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_DEBUGFUNC_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_DEBUGFUNC_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class DebugFunc; // self forward Var
typedef ::Core::Var<DebugFunc> DebugFunc_var;
typedef ::Core::Var<const DebugFunc> DebugFunc_cvar;

class DebugFunc_factory;

// реализация встроенной функции генератора "_dbg_point"
class DebugFunc:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (DebugFunc)
	friend class DebugFunc_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DebugFunc ();

	virtual ~DebugFunc ();

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
}; // class DebugFunc

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_DEBUGFUNC_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
