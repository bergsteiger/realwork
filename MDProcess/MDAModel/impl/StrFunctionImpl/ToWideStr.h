////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ToWideStr.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ToWideStr
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_to_wide_str"
// _to_wide_str (<строка>, <префикс>, <открывающий символ>, <закрывающий символ>) - трансформирует
// строку в wide-коды, если задан открывающий символ то английские символы сохраняются в ASCI-
// формате и обрамляются указанными символами.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOWIDESTR_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOWIDESTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class ToWideStr; // self forward Var
typedef ::Core::Var<ToWideStr> ToWideStr_var;
typedef ::Core::Var<const ToWideStr> ToWideStr_cvar;

class ToWideStr_factory;

// реализация встроенной функции генератора "_to_wide_str"
// _to_wide_str (<строка>, <префикс>, <открывающий символ>, <закрывающий символ>) - трансформирует
// строку в wide-коды, если задан открывающий символ то английские символы сохраняются в ASCI-
// формате и обрамляются указанными символами.
class ToWideStr:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (ToWideStr)
	friend class ToWideStr_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ToWideStr ();

	virtual ~ToWideStr ();

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
}; // class ToWideStr

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOWIDESTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
