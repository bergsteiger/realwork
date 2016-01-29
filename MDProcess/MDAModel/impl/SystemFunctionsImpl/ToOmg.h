////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ToOmg.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ToOmg
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_to_omg"
// _to_omg (<шаблон>) - конвертирует строку <шаблон> в стиль «OMG» - составные части с маленьких
// букв разделенных символом подчеркивания
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_TOOMG_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_TOOMG_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class ToOmg; // self forward Var
typedef ::Core::Var<ToOmg> ToOmg_var;
typedef ::Core::Var<const ToOmg> ToOmg_cvar;

class ToOmg_factory;

// реализация встроенной функции генератора "_to_omg"
// _to_omg (<шаблон>) - конвертирует строку <шаблон> в стиль «OMG» - составные части с маленьких
// букв разделенных символом подчеркивания
class ToOmg:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (ToOmg)
	friend class ToOmg_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ToOmg ();

	virtual ~ToOmg ();

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
}; // class ToOmg

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_TOOMG_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
