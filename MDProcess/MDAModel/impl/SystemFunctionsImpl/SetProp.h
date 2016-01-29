////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/SetProp.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::SetProp
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_set_prop"
// _set_prop(«prop id»,«value») - устанавливает свойству ГЕНЕРАТОРА указанное значение.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SETPROP_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SETPROP_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class SetProp; // self forward Var
typedef ::Core::Var<SetProp> SetProp_var;
typedef ::Core::Var<const SetProp> SetProp_cvar;

class SetProp_factory;

// реализация встроенной функции генератора "_set_prop"
// _set_prop(«prop id»,«value») - устанавливает свойству ГЕНЕРАТОРА указанное значение.
class SetProp:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (SetProp)
	friend class SetProp_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetProp ();

	virtual ~SetProp ();

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
}; // class SetProp

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SETPROP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
