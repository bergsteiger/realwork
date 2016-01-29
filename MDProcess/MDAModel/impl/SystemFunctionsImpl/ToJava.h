////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ToJava.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ToJava
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_to_java"
// _to_java (<шаблон>) - конвертирует строку <шаблон> в стиль «Java» - составные части склеены и
// начинаются с заглавных букв (кроме первой части)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_TOJAVA_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_TOJAVA_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class ToJava; // self forward Var
typedef ::Core::Var<ToJava> ToJava_var;
typedef ::Core::Var<const ToJava> ToJava_cvar;

class ToJava_factory;

// реализация встроенной функции генератора "_to_java"
// _to_java (<шаблон>) - конвертирует строку <шаблон> в стиль «Java» - составные части склеены и
// начинаются с заглавных букв (кроме первой части)
class ToJava:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (ToJava)
	friend class ToJava_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ToJava ();

	virtual ~ToJava ();

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
}; // class ToJava

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_TOJAVA_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
